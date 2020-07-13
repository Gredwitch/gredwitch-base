AddCSLuaFile("shared.lua")
AddCSLuaFile("cl_init.lua")
include("shared.lua")

util.AddNetworkString("gred_net_shell_shrapnel_windows_send")
util.AddNetworkString("gred_net_shell_pickup_add") 
util.AddNetworkString("gred_net_shell_pickup_rem")

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

local Baseclass = baseclass.Get("base_rocket")
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
local Launch
local color_red = Color(255,0,0,255)
local color_green = Color(0,255,0,255)

function ENT:ConvertMetersToUnits(Meters)
	return Meters / 0.01905
end

function ENT:ConvertUnitsToMeters(Units)
	return Units * 0.01905
end

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
	
	self.EnginePower 			= self:ConvertMetersToUnits(self.MuzzleVelocity*gred.CVars["gred_sv_shell_speed_multiplier"]:GetFloat()) -- m/s
	self.EffectAir 				= self.Effect
	self.Smoke 					= self.ShellType == "Smoke"
	self:SetTracerColor(self.TRACERCOLOR_TO_INT[self.TracerColor] or 0)
	self:SetCaliber(self.Caliber)
	self:SetShellType(self.ShellType)
	
	self.Filter = {self}
	for k,v in pairs(ents.FindByClass("gmod_sent_vehicle_fphysics_wheel")) do
		constraint.NoCollide(self,v,0,0)
		table.insert(self.Filter,v)
	end
	
	if !(WireAddon == nil) then self.Inputs = Wire_CreateInputs(self, { "Arm", "Detonate", "Launch" }) end
end

function ENT:Launch()
	Launch = Launch or baseclass.Get("base_rocket").Launch
	Launch(self)
	
	local phys = self:GetPhysicsObject() -- for some reason doing this in InitPhysics() doesn't work
	
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
	self:SetFired(self.Fired)
end

function ENT:AddOnThink()
	-- self:SetAngles(Angle(0))
end

function ENT:InitPhysics(phys)
	self.CaliberMul = self.Caliber / 75
	ShellRadiusSquared = self.Caliber*0.5
	ShellRadiusSquared = ShellRadiusSquared * ShellRadiusSquared
	CylinderLength = CYLINDER_LENGTH * self.CaliberMul
	FlowRate = (0.25 * MATH_PI * self.Caliber*self.Caliber * self.MuzzleVelocity) * 1000000 -- cubic millimeters/s
	
	self.DragCoefficient = ((2 * -((FlowRate*TO_METERS_PER_SEC*0.001 * 4) / (MATH_PI * (self.Caliber*0.001)^2))) / ((self.Mass/((ONE_THIRD * MATH_PI * ShellRadiusSquared * CONE_LENGTH * 0.001) + (MATH_PI * ShellRadiusSquared * CylinderLength))) * (FlowRate*FlowRate) * CONE_AREA))  -- density = kg/cubic centimeters | volume = cone volume + cylinder volume
	
	CylinderLength = CylinderLength * CylinderLength
	
	-- self.Inertia = Vector((self.Mass * ShellRadiusSquared) * 0.5,(self.Mass * CylinderLength) * 0.5,(self.Mass * CylinderLength) / 12)
	self.Inertia = Vector((self.Mass * CylinderLength) * 0.5,(self.Mass * ShellRadiusSquared) * 0.5,(self.Mass * ShellRadiusSquared) / 12)
end

function ENT:AddOnExplode(pos)
	if self.ShellType == "Smoke" then return false end
	local vel
	self.LastVelLength = self.LastVel and self.LastVel:Length() or self:ConvertMetersToUnits(self.MuzzleVelocity)
	
	self.ExplosiveMass = (!self.ExplosiveMass and self.TNTEquivalent) and (self.TNTEquivalent * self.Mass) * 0.01 or 0
	self.TNTEquivalent = !self.TNTEquivalent and (self.ExplosiveMass and (self.ExplosiveMass/self.Mass)*100 or 0) or self.TNTEquivalent
	
	if self.IS_AP[self.ShellType] then
		vel = self.LastVel and self:ConvertUnitsToMeters(self.LastVelLength) or self.MuzzleVelocity
		
		if self.LinearPenetration then
			self.Penetration = self.LinearPenetration
		elseif !self.IS_APCR[self.ShellType] then
			self.Penetration = (((vel^1.43)*(self.Mass^0.71))/(kfbr*((self.Caliber*0.01)^1.07)))*100*(self.TNTEquivalent < 0.65 and 1 or (self.TNTEquivalent < 1.6 and 1 + (self.TNTEquivalent-0.65)*-0.07/0.95 or (self.TNTEquivalent < 2 and 0.93 + (self.TNTEquivalent-1.6) * -0.03 / 0.4 or (self.TNTEquivalent < 3 and 0.9+(self.TNTEquivalent-2)*-0.05 or self.TNTEquivalent < 4 and 0.85+(self.TNTEquivalent-3)*-0.1 or 0.75))))*((self.ShellType == "APCBC" or self.ShellType == "APHECBC") and 1 or 0.9)
			
		else
			self.Penetration = ((vel^1.43)*((self.CoreMass + (((((self.CoreMass/self.Mass)*100) > 36.0) and 0.5 or 0.4) * (self.Mass - self.CoreMass)))^0.71))/(kfbrAPCR*((self.Caliber*0.0001)^1.07))
		end
		
		self.ExplosionDamage = self.Penetration*vel*0.03
		
		if self.IS_APCR[self.ShellType] then
			self.ExplosionDamage = self.ExplosionDamage*0.15*gred.CVars["gred_sv_shell_apcr_damagemultiplier"]:GetFloat()
		else
			if self.TNTEquivalent > 0 then
				self.ExplosionDamage = self.ExplosionDamage * ((self.TNTEquivalent < 1 and 1/math.sqrt(math.sqrt(math.sqrt(self.TNTEquivalent))) or self.TNTEquivalent)) * (self.IS_APHE[self.ShellType] and 1.3 or 1)
			end
			self.ExplosionDamage = self.ExplosionDamage * gred.CVars["gred_sv_shell_ap_damagemultiplier"]:GetFloat()
		end
		
	elseif self.LinearPenetration then
		self.Penetration = self.LinearPenetration
	end
	
	self.Penetration = self.Penetration or 0
	
	if self:WaterLevel() < 1 then
		local fwd = self.LastVel:Angle():Forward()
		local tr = util.QuickTrace(pos - fwd*100,fwd*300,self.Filter)
		local HitMat = util.GetSurfacePropName(tr.SurfaceProps)
		local ArmourThickness = 0
		
		self.EffectAir = self.IS_AP[self.ShellType] and "AP_impact_wall" or self.EffectAir
		
		if IsValid(tr.Entity) and simfphys and simfphys.IsCar(tr.Entity) then
			self.EntityHit = tr.Entity
			local Fraction
			local ModuleDamage = gred.CVars.gred_sv_simfphys_moduledamagesystem:GetBool()
			
			local HasTNT = (self.TNTEquivalent and self.TNTEquivalent > 0)
			self.ShrapnelPen = math.ceil(self.Caliber * 0.15)
			self.ShrapnelBoom = HasTNT and math.floor(self.Caliber^1.05) or 0
			-- self.ExplosionDamage = self.ShellType != "HE" and (self.ShrapnelPen * (self.IS_AP[self.ShellType] and 1.5 or 1.1) * (HasTNT and self.ShrapnelBoom * 1.5 or self.Caliber^0.6)) or self.ExplosionDamage
			
			tr = gred.GetImpactInfo(tr,tr.Entity)
			
			if tr.Entity.GRED_TANK and tr.Entity.CachedSpawnList and gred.simfphys[tr.Entity.CachedSpawnList] and gred.simfphys[tr.Entity.CachedSpawnList].Armour then
				local AbsImpactAng = math.abs(tr.HitNormalAngle.p)
				
				if AbsImpactAng > 10 and self.SLOPE_MULTIPLIERS[self.ShellType] then
					local prev
					
					for k,v in SortedPairs(self.SLOPE_MULTIPLIERS[self.ShellType]) do
						if k > AbsImpactAng then
							prev = prev + 2.5 < AbsImpactAng and k or prev -- if we're closer to k than prev, we make k prev so we can use it as a var
							break
						else
							prev = k
						end
					end
					
					local Slope = self.SLOPE_MULTIPLIERS[self.ShellType][prev]["a"] * (tr.ArmourThicknessKE / self.Caliber)^self.SLOPE_MULTIPLIERS[self.ShellType][prev]["b"]
					local Normalization = math.deg(math.acos(1/Slope)) - AbsImpactAng
					
					tr.HitNormalAngle.p = tr.HitNormalAngle.p + Normalization
					tr.NormalNormalizedAngle = Angle(tr.NormalAngle.p + Normalization,tr.NormalAngle.y,tr.NormalAngle.r)
					tr.NormalNormalized = tr.NormalNormalizedAngle:Forward()
				else
					tr.NormalNormalizedAngle = tr.NormalAngle
					tr.NormalNormalized = tr.Normal
				end
				
				tr = gred.CalculateArmourThickness(tr,tr.Entity,0)
				local HP
				
				if gred.CVars.gred_sv_simfphys_realisticarmour:GetBool() then
					ArmourThickness = self.IS_HEAT[self.ShellType] and tr.EffectiveArmourThicknessCHEMICAL or tr.EffectiveArmourThicknessKE
				else
					HP = tr.Entity:GetMaxHealth()*0.01 / gred.CVars.gred_sv_simfphys_health_multplier:GetFloat()
					ArmourThickness = HP / tr.CalculatedImpactCos
				end
				
				Fraction = ArmourThickness / self.Penetration
				self.Fraction = Fraction
				
				if Fraction >= 1 then
					if !ModuleDamage then
						-- if (self.IS_HEAT[self.ShellType] or self.IS_AP[self.ShellType]) and gred.CVars.gred_sv_shell_ap_lowpen_system:GetBool() then
							-- self.ExplosionDamage = self.ExplosionDamage / (Fraction*Fraction)
						-- else
							self.ExplosionDamage = 0
						-- end
					end
				else
					if self.IS_APCR[self.ShellType] then
						for k,v in pairs(ents.FindAlongRay(tr.HitPos,tr.HitPos + fwd * (-tr.Entity:GetModelBounds().x * 2),mins,maxs)) do
							if v:IsPlayer() and v:GetSimfphys() == tr.Entity then v:TakeDamage(self.ExplosionDamage*0.15,self.GBOWNER,self) end
						end
					end
				end
			else
				tr.NormalNormalizedAngle = tr.NormalAngle
				tr.NormalNormalized = tr.Normal
				
				self.Fraction = 0
			end
			
			HitMat = "metal"
			
			tr.ShellLastVel = self.PostHitVel and self.PostHitVel:Length() or self.LastVelLength
			tr.ShellPenTraceLength = (HasTNT and tr.ShellLastVel*0.01 or tr.ShellLastVel)
			tr.ShellExplodePos = tr.HitPos + tr.NormalNormalized * tr.ShellPenTraceLength -- make HEAT start at this + (self.CaliberMul * CONE_LENGTH) * 0.5
			tr.Caliber = self.Caliber
			
			local ShrapnelTab = {
				[0] = { -- HEADER
					[1] = tr.LocalHitPos, -- ShellHitPos
					[2] = tr.ShellPenTraceLength, -- ShellPenLength
					[3] = tr.Entity.ModelSizeLength, -- ModelSizeLength -- the client should do that on his side tbh
					[4] = tr.Entity:WorldToLocalAngles(tr.NormalNormalizedAngle), -- NormalNormalized
					[5] = self.Caliber, -- Caliber
					[6] = self.Fraction >= 1,
					[7] = tr.Entity:GetModel(),
					[8] = tr.Entity:GetSkin(),
					[9] = self.ExplosionDamage,
					[10] = math.Round(self.Penetration),
					[11] = math.Round(ArmourThickness),
					[12] = self.ShrapnelPen,
					[13] = self.ShrapnelBoom,
					[14] = HasTNT and tr.ShellExplodePos or nil, -- let the client calculate that
					[15] = self.IS_AP[self.ShellType] and 0 or 1, -- let the client calculate that
				},
			}
			
			if ModuleDamage then
				if Fraction < 1 then
					-- self.NO_EFFECT = true
					print("woof")
					debugoverlay.Line(tr.HitPos,tr.HitPos + tr.NormalNormalized * ShrapnelTab[0][2],5,color_white)
					
					local MaxAngle = 15
					
					for i = 1,self.ShrapnelPen do
						ShrapnelTab[i] = (tr.NormalNormalizedAngle + Angle(math.Rand(-MaxAngle,MaxAngle),math.Rand(-MaxAngle,MaxAngle))):Forward()
						-- debugoverlay.Line(tr.HitPos,tr.HitPos + ShrapnelTab[i] * ShrapnelTab[0][3],5,color_green)
					end
					
					MaxAngle = self.IS_HEAT[self.ShellType] and 25 or 180
					
					for i = self.ShrapnelPen + 1,self.ShrapnelPen + self.ShrapnelBoom + 1 do
						ShrapnelTab[i] = (tr.NormalNormalizedAngle + Angle(math.Rand(-MaxAngle,MaxAngle),math.Rand(-MaxAngle,MaxAngle))):Forward()
						-- debugoverlay.Line(tr.ShellExplodePos,tr.ShellExplodePos + ShrapnelTab[i] * ShrapnelTab[0][3],5,color_red)
					end
					self:DoModuleDamage(tr,ShrapnelTab,Fraction > 1)
				end
			else
				local dmg = DamageInfo()
				local DamageToDeal = tr.Entity.GRED_TANK and ((Fraction and Fraction >= 1 and !self.IS_AP[self.ShellType]) and 0 or self.ExplosionDamage) or (self.IS_APCR[self.ShellType] and self.ExplosionDamag or self.ExplosionDamage) -- need to localize it otherwise it fucks up
				dmg:SetAttacker(self.GBOWNER)
				dmg:SetInflictor(self)
				dmg:SetDamagePosition(tr.HitPos)
				dmg:SetDamage(DamageToDeal)
				dmg:SetDamageType(64) -- DMG_BLAST
				tr.Entity:TakeDamageInfo(dmg)
				
				if IsValid(self.GBOWNER) and self.GBOWNER:IsPlayer() and gred.CVars.gred_sv_shell_enable_killcam:GetBool() then
					local CompressedTab = util.Compress(util.TableToJSON(ShrapnelTab))
					local len = CompressedTab:len()
					
					net.Start("gred_net_shell_shrapnel_windows_send")
						net.WriteUInt(len,14)
						net.WriteData(CompressedTab,len)
					net.Send(self.GBOWNER)
				end
			end
			
			if self.IS_HEAT[self.ShellType] or self.IS_AP[self.ShellType] then
				self.ExplosionDamage = 0
				self.ExplosionRadius = 0
			end
		end
		-- print("PENETRATION = "..self.Penetration.."mm - DAMAGE = "..self.ExplosionDamage.." - DISTANCE = "..((self.LAUNCHPOS-pos):Length()*0.01905).."m - IMPACT VELOCITY = "..vel.."m/s - MUZZLE VELOCITY = "..self.MuzzleVelocity.."m/s - VELOCITY DIFFERENCE = "..self.MuzzleVelocity-vel.." - DRAG COEFFICIENT = "..self.DragCoefficient.." - MASS = "..self.Mass.." - CALIBER = "..self.Caliber)
		if self.ShellType != "HE" then
			if Materials[HitMat] == 1 then
				self.Effect = "AP_impact_wall"
				self.EffectAir = "AP_impact_wall"
				self.ExplosionSound = table.Random(APMetalSounds)
				self.FarExplosionSound = table.Random(APMetalSounds)
				pos = tr.HitPos+(fwd*2)
			elseif Materials[HitMat] == 2 and !self.IS_HEAT[self.ShellType] then
				self.ExplosionSound = table.Random(APWoodSounds)
				self.FarExplosionSound = table.Random(APWoodSounds)
			elseif !self.IS_HEAT[self.ShellType] then
				self.ExplosionSound = table.Random(APSounds)
				self.FarExplosionSound = table.Random(APSounds)
			end
		end
		
		if self.NO_EFFECT then 
			self.Effect = ""
			self.EffectAir = ""
			self.ExplosionSound = "physics/flesh/flesh_squishy_impact_hard".. math.random(1,4)..".wav"
			self.FarExplosionSound = "extras/null.wav"
			self.DistExplosionSound = "extras/null.wav"
		end
		
		self.ExplosionDamage = self.ExplosionDamageOverride and self.ExplosionDamageOverride or self.ExplosionDamage
	end
end

function ENT:Use(ply)
	if self.Fired then return end
	
	local ct = CurTime()
	if self.NextUse >= ct then return end
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
	
	self.NextUse = ct + 0.1
end

function ENT:OnRemove()
	if IsValid(self.PlyPickup) then
		net.Start("gred_net_shell_pickup_rem")
		net.Send(self.PlyPickup)
		self.PlyPickup:DropObject()
	end
	self:StopParticles()
end
