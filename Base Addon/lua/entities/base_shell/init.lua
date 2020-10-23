AddCSLuaFile("shared.lua")
AddCSLuaFile("cl_init.lua")
include("shared.lua")

util.AddNetworkString("gred_net_shell_shrapnel_windows_send")
util.AddNetworkString("gred_net_shell_pickup_add") 
util.AddNetworkString("gred_net_shell_pickup_rem")

local kfbr = 1900^1.43
local MATH_PI = math.pi
local ONE_THIRD = 1/3
local CONE_LENGTH = 102.384225 -- millimeters
local CYLINDER_LENGTH = 107.866815 -- millimeters
local CONE_AREA = (CONE_LENGTH * 70.31355) * 0.5 -- square millimeters
local TO_METERS_PER_SEC = 1/3.6
local kfbrAPCR = 3000^1.43
local ShellRadiusSquared
local FlowRate
local CylinderLength
local mins,maxs = Vector(-5,-5,-5),Vector(5,5,5)
local color_red = Color(255,0,0,255)
local color_green = Color(0,255,0,255)

local Materials = {
	canister				=	1,
	chain					=	1,
	chainlink				=	1,
	combine_metal			=	1,
	crowbar					=	1,
	floating_metal_barrel	=	1,
	grenade					=	1,
	metal					=	1,
	metal_barrel			=	1,
	metal_bouncy			=	1,
	Metal_Box				=	1,
	metal_seafloorcar		=	1,
	metalgrate				=	1,
	metalpanel				=	1,
	metalvent				=	1,
	metalvehicle			=	1,
	paintcan				=	1,
	roller					=	1,
	slipperymetal			=	1,
	solidmetal				=	1,
	strider					=	1,
	weapon					=	1,
	
	wood					=	2,
	wood_Box				=	2,
	wood_Crate 				=	2,
	wood_Furniture			=	2,
	wood_LowDensity 		=	2,
	wood_Plank				=	2,
	wood_Panel				=	2,
	wood_Solid				=	2,
}

local SmokeSnds = {
	"gred_emp/nebelwerfer/artillery_strike_smoke_close_01.wav",
	"gred_emp/nebelwerfer/artillery_strike_smoke_close_02.wav",
	"gred_emp/nebelwerfer/artillery_strike_smoke_close_03.wav",
	"gred_emp/nebelwerfer/artillery_strike_smoke_close_04.wav",
}

local APSounds = {
	"impactsounds/ap_impact_01.wav",
	"impactsounds/ap_impact_02.wav",
	"impactsounds/ap_impact_03.wav",
	"impactsounds/ap_impact_04.wav",
}

local APWoodSounds = {
	"impactsounds/ap_impact_wood_01.wav",
	"impactsounds/ap_impact_wood_02.wav",
	"impactsounds/ap_impact_wood_03.wav",
	"impactsounds/ap_impact_wood_04.wav",
}

local APSoundsDist = {
	"impactsounds/ap_impact_dist_01.wav",
	"impactsounds/ap_impact_dist_02.wav",
	"impactsounds/ap_impact_dist_03.wav",
}

local APMetalSounds = {
	"impactsounds/ap_impact_metal_01.wav",
	"impactsounds/ap_impact_metal_02.wav",
	"impactsounds/ap_impact_metal_03.wav",
}

local ExploSnds = {
	"explosions/doi_generic_01.wav",
	"explosions/doi_generic_02.wav",
	"explosions/doi_generic_03.wav",
	"explosions/doi_generic_04.wav",
}

local CloseExploSnds = {
	"explosions/doi_generic_01_close.wav",
	"explosions/doi_generic_02_close.wav",
	"explosions/doi_generic_03_close.wav",
	"explosions/doi_generic_04_close.wav",
}

local DistExploSnds = {
	"explosions/doi_generic_01_dist.wav",
	"explosions/doi_generic_02_dist.wav",
	"explosions/doi_generic_03_dist.wav",
	"explosions/doi_generic_04_dist.wav",
}

local WaterExploSnds = {
	"explosions/doi_generic_01_water.wav",
	"explosions/doi_generic_02_water.wav",
	"explosions/doi_generic_03_water.wav",
	"explosions/doi_generic_04_water.wav",
}

local CloseWaterExploSnds = {
	"explosions/doi_generic_02_closewater.wav",
	"explosions/doi_generic_02_closewater.wav",
	"explosions/doi_generic_03_closewater.wav",
	"explosions/doi_generic_04_closewater.wav",
}

local WPExploSnds = {
	"explosions/doi_wp_01.wav",
	"explosions/doi_wp_02.wav",
	"explosions/doi_wp_03.wav",
	"explosions/doi_wp_04.wav",
}

local Math = {
	pow = function(n,e) return n^e end
}


function ENT:PhysicsUpdate(ph)
	if self.Fired then
		local water = self:WaterLevel()
		if water >= 1 then
			if water == 1 then
				local vel = ph:GetVelocity()
				-- if vel:Length() <= self.ImpactSpeed then return end
				if self.IS_AP[self.ShellType] then
					self.LastVel = vel
					local HitAng = vel:Angle()
					HitAng:Normalize()
					local c = os.clock()
					if self:CanRicochet(HitAng,0) then
						local pos = ph:GetPos()
						self.RICOCHET = self.RICOCHET or c
						self.ImpactSpeed = 100
						gred.CreateSound(pos,false,"impactsounds/Tank_shell_impact_ricochet_w_whizz_0"..math.random(1,5)..".ogg","impactsounds/Tank_shell_impact_ricochet_w_whizz_mid_0"..math.random(1,3)..".ogg","impactsounds/Tank_shell_impact_ricochet_w_whizz_mid_0"..math.random(1,3)..".ogg")
						local effectdata = EffectData()
						effectdata:SetOrigin(pos)
						-- HitAng = self:LocalToWorldAngles(HitAng)
						-- HitAng:RotateAroundAxis(HitAng:Right(),0)
						HitAng.p = HitAng.p - 90
						effectdata:SetNormal(HitAng:Forward())
						util.Effect("ManhackSparks",effectdata)
						-- vel.y = -vel.y
						vel.z = -vel.z
						ph:SetVelocityInstantaneous(vel)
						return
					end
					self.PhysObj = ph
				end
			end
			self.Exploded = true
			self:Explode()
			return
		end
	end
end

function ENT:AddOnInit()
	self.ExplosionSound			= table.Random(CloseExploSnds)
	self.FarExplosionSound		= table.Random(ExploSnds)
	self.DistExplosionSound		= table.Random(DistExploSnds)
	self.WaterExplosionSound	= table.Random(CloseWaterExploSnds)
	self.WaterFarExplosionSound	= table.Random(WaterExploSnds)
	
	if self.ShellType == "WP" then
		self.ExplosionSound = table.Random(WPExploSnds)
		self.FarExplosionSound = self.ExplosionSound
		self.DistExplosionSound = self.ExplosionSound
		
		self.AngEffect = true
		self.Effect = self.Caliber < 82 and "doi_wpgrenade_explosion" or "doi_wparty_explosion"
		self.ExplosionDamage = 30
		self.ExplosionRadius = self.Caliber < 82 and 300 or 500
		self.AddOnExplode = function(self)
			local ent = ents.Create("base_napalm")
			local pos = self:GetPos()
			ent:SetPos(pos)
			ent.Radius	 = self.Caliber < 82 and 300 or 500
			ent.Rate  	 = 1
			ent.Lifetime = 15
			ent:Spawn()
			ent:Activate()
			ent:SetVar("GBOWNER",self.GBOWNER)
		end
	elseif self.ShellType == "Gas" then
		self.ExplosionSound = table.Random(WPExploSnds)
		self.FarExplosionSound = self.ExplosionSound
		self.DistExplosionSound = self.ExplosionSound
		
		self.AngEffect = true
		self.Effect = "doi_GASarty_explosion"
		self.ExplosionDamage = 30
		self.ExplosionRadius = self.Caliber < 82 and 400 or 500
		self.AddOnExplode = function(self)
			local ent = ents.Create("base_gas")
			local pos = self:GetPos()
			ent:SetPos(pos)
			ent.Radius	 = self.Caliber < 82 and 400 or 500
			ent.Rate  	 = 1
			ent.Lifetime = 15
			ent:Spawn()
			ent:Activate()
			ent:SetVar("GBOWNER",self.GBOWNER)
		end
	elseif self.ShellType == "Smoke" then
		self.ExplosionSound = table.Random(SmokeSnds)
		self.FarExplosionSound = self.ExplosionSound
		self.DistExplosionSound = ""
		self.Effect = self.SmokeEffect
		self.EffectAir = self.SmokeEffect
		self.Effect = self.Caliber < 88 and "m203_smokegrenade" or "doi_smoke_artillery"
	elseif self.ShellType == "HE" then
		self.ExplosionDamage = (1500 + (gred.CVars.gred_sv_shell_he_damage:GetBool() and 0 or self.Caliber * 200)) * gred.CVars["gred_sv_shell_he_damagemultiplier"]:GetFloat()
		if self.Caliber < 50 then
			self.ExplosionRadius = 350
			self.Effect = "ins_m203_explosion"
			self.AngEffect = true
		elseif self.Caliber >= 50 and self.Caliber < 56 then
			self.ExplosionRadius = 350
			self.Effect = "gred_50mm"
			self.AngEffect = true
		elseif self.Caliber >= 56 and self.Caliber < 75 then
			self.ExplosionRadius = 350
			self.Effect = "ins_rpg_explosion"
			self.AngEffect = true
		elseif self.Caliber >= 75 and self.Caliber < 77 then
			self.ExplosionRadius = 450
			self.Effect = "doi_compb_explosion"
			self.AngEffect = true
		elseif self.Caliber >= 77 and self.Caliber < 82 then
			self.ExplosionRadius = 350
			self.Effect = "gred_mortar_explosion"
			self.AngEffect = true
		elseif self.Caliber >= 82 and self.Caliber < 100 then
			self.ExplosionRadius = 500
			self.Effect = "doi_artillery_explosion"
			self.AngEffect = true
		elseif self.Caliber >= 100 and self.Caliber < 128 then
			self.ExplosionRadius = 500
			self.Effect = "ins_c4_explosion"
			self.AngEffect = true
		elseif self.Caliber >= 128 and self.Caliber < 150 then
			self.ExplosionRadius = 600
			self.Effect = "gred_highcal_rocket_explosion"
			self.AngEffect = true
		elseif self.Caliber >= 150 then
			self.ExplosionRadius = 600
			self.Effect = "doi_artillery_explosion_OLD"
			self.AngEffect = true
		end
	elseif self.IS_HEAT[self.ShellType] then
		self.ExplosionRadius = 200
		self.Effect = "ap_impact_dirt"
		self.ExplosionDamage = ((!self.TNTEquivalent and (self.ExplosiveMass and (self.ExplosiveMass/self.Mass)*100 or 10) or self.TNTEquivalent) * 40 * self.Caliber) * gred.CVars["gred_sv_shell_heat_damagemultiplier"]:GetFloat()
	else
		self.AngEffect = true
		self.Effect = "gred_ap_impact"
		self.ExplosionRadius = 50
		self.Decal = "scorch_small"
	end
	
	self.EnginePower 			= self:ConvertMetersToUnits(self.MuzzleVelocity) -- m/s
	self.EffectAir 				= self.Effect
	self.Smoke 					= self.ShellType == "Smoke"
	self.ModelScale				= self.Caliber / 75
	
	self:SetTracerColor(self.TRACERCOLOR_TO_INT[self.TracerColor] or 0)
	self:SetCaliber(self.Caliber)
	self:SetShellType(self.ShellType)
	self:SetModelScale(self.ModelScale)
	self:Activate()
	
	self:InitCollisionFilter()
	
	if WireAddon then 
		self.Inputs = Wire_CreateInputs(self, { "Arm", "Detonate", "Launch" }) 
	end
end

function ENT:PostLaunch(phys)
	if IsValid(phys) then
		phys:EnableDrag(true)
		phys:SetInertia(self.Inertia)
		phys:SetMaterial("metal")
		
		if self:ConvertUnitsToMeters(self.Inertia:Length()) >= self.MuzzleVelocity or self.ForceDragCoef then
			phys:SetAngleDragCoefficient(self.DragCoefficient)
			phys:SetDragCoefficient(self.DragCoefficient)
		end
	end
	
	self:SetBodygroup(0,1)
end

function ENT:Think()
	-- local mins,maxs = self:GetModelBounds()
	-- print(mins,maxs)
	-- debugoverlay.BoxAngles(self:GetPos(),mins,maxs,self:GetAngles(),1/30,color_white)
	
	-- self:NextThink(CurTime())
	-- return true
end

function ENT:InitPhysics(phys)
	self.CaliberMul = self.Caliber / 75
	ShellRadiusSquared = self.Caliber*0.5
	ShellRadiusSquared = ShellRadiusSquared * ShellRadiusSquared
	CylinderLength = CYLINDER_LENGTH * self.CaliberMul
	self.ShellLength = CylinderLength + CONE_LENGTH * self.CaliberMul
	FlowRate = (0.25 * MATH_PI * self.Caliber*self.Caliber * self.MuzzleVelocity) * 1000000 -- cubic millimeters/s
	
	self.DragCoefficient = ((2 * -((FlowRate*TO_METERS_PER_SEC*0.001 * 4) / (MATH_PI * (self.Caliber*0.001)^2))) / ((self.Mass/((ONE_THIRD * MATH_PI * ShellRadiusSquared * CONE_LENGTH * self.CaliberMul * 0.001) + (MATH_PI * ShellRadiusSquared * CylinderLength))) * (FlowRate*FlowRate) * CONE_AREA))  -- density = kg/cubic centimeters | volume = cone volume + cylinder volume
	
	CylinderLength = CylinderLength * CylinderLength
	
	-- self.Inertia = Vector((self.Mass * ShellRadiusSquared) * 0.5,(self.Mass * CylinderLength) * 0.5,(self.Mass * CylinderLength) / 12)
	self.Inertia = Vector((self.Mass * CylinderLength) * 0.5,(self.Mass * ShellRadiusSquared) * 0.5,(self.Mass * ShellRadiusSquared) / 12)
end

function ENT:Use(ply)
	if self.Fired then return end
	
	if self:IsPlayerHolding() then return end
	
	ply:PickupObject(self)
	
	if IsValid(self.PlyPickup) then
		net.Start("gred_net_shell_pickup_rem")
			net.WriteEntity(self)
		net.Send(self.PlyPickup)
	end
	
	self.PlyPickup = ply
	ply:SetNWEntity("PickedUpObject",self)
	
	net.Start("gred_net_shell_pickup_add")
		net.WriteEntity(self)
	net.Send(ply)
end

function ENT:OnRemove()
	if IsValid(self.PlyPickup) then
		net.Start("gred_net_shell_pickup_rem")
		net.Send(self.PlyPickup)
		self.PlyPickup:DropObject()
	end
	self:StopParticles()
end

