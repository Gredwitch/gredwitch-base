AddCSLuaFile()
DEFINE_BASECLASS( "base_rocket" )

local materials = {
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
local damagesound                   =  "weapons/rpg/shotdown.wav"

local SmokeSnds = {}
SmokeSnds[1]                        =  "gred_emp/nebelwerfer/artillery_strike_smoke_close_01.wav"
SmokeSnds[2]                        =  "gred_emp/nebelwerfer/artillery_strike_smoke_close_02.wav"
SmokeSnds[3]                        =  "gred_emp/nebelwerfer/artillery_strike_smoke_close_03.wav"
SmokeSnds[4]                        =  "gred_emp/nebelwerfer/artillery_strike_smoke_close_04.wav"

local APSounds = {}
APSounds[1]							=  "impactsounds/ap_impact_01.wav"
APSounds[2]							=  "impactsounds/ap_impact_02.wav"
APSounds[3]							=  "impactsounds/ap_impact_03.wav"
APSounds[4]							=  "impactsounds/ap_impact_04.wav"

local APWoodSounds = {}
APWoodSounds[1]						=  "impactsounds/ap_impact_wood_01.wav"
APWoodSounds[2]						=  "impactsounds/ap_impact_wood_02.wav"
APWoodSounds[3]						=  "impactsounds/ap_impact_wood_03.wav"
APWoodSounds[4]						=  "impactsounds/ap_impact_wood_04.wav"

local APSoundsDist = {}
APSoundsDist[1]						=  "impactsounds/ap_impact_dist_01.wav"
APSoundsDist[2]						=  "impactsounds/ap_impact_dist_02.wav"
APSoundsDist[3]						=  "impactsounds/ap_impact_dist_03.wav"

local APMetalSounds = {}
APMetalSounds[1]					=  "impactsounds/ap_impact_metal_01.wav"
APMetalSounds[2]					=  "impactsounds/ap_impact_metal_02.wav"
APMetalSounds[3]					=  "impactsounds/ap_impact_metal_03.wav"

local ExploSnds = {}
ExploSnds[1]                         =  "explosions/doi_generic_01.wav"
ExploSnds[2]                         =  "explosions/doi_generic_02.wav"
ExploSnds[3]                         =  "explosions/doi_generic_03.wav"
ExploSnds[4]                         =  "explosions/doi_generic_04.wav"

local CloseExploSnds = {}
CloseExploSnds[1]                         =  "explosions/doi_generic_01_close.wav"
CloseExploSnds[2]                         =  "explosions/doi_generic_02_close.wav"
CloseExploSnds[3]                         =  "explosions/doi_generic_03_close.wav"
CloseExploSnds[4]                         =  "explosions/doi_generic_04_close.wav"

local DistExploSnds = {}
DistExploSnds[1]                         =  "explosions/doi_generic_01_dist.wav"
DistExploSnds[2]                         =  "explosions/doi_generic_02_dist.wav"
DistExploSnds[3]                         =  "explosions/doi_generic_03_dist.wav"
DistExploSnds[4]                         =  "explosions/doi_generic_04_dist.wav"

local WaterExploSnds = {}
WaterExploSnds[1]                         =  "explosions/doi_generic_01_water.wav"
WaterExploSnds[2]                         =  "explosions/doi_generic_02_water.wav"
WaterExploSnds[3]                         =  "explosions/doi_generic_03_water.wav"
WaterExploSnds[4]                         =  "explosions/doi_generic_04_water.wav"

local CloseWaterExploSnds = {}
CloseWaterExploSnds[1]                         =  "explosions/doi_generic_02_closewater.wav"
CloseWaterExploSnds[2]                         =  "explosions/doi_generic_02_closewater.wav"
CloseWaterExploSnds[3]                         =  "explosions/doi_generic_03_closewater.wav"
CloseWaterExploSnds[4]                         =  "explosions/doi_generic_04_closewater.wav"

local WPExploSnds = {}
WPExploSnds[1]                         =  "explosions/doi_wp_01.wav"
WPExploSnds[2]                         =  "explosions/doi_wp_02.wav"
WPExploSnds[3]                         =  "explosions/doi_wp_03.wav"
WPExploSnds[4]                         =  "explosions/doi_wp_04.wav"

ENT.Spawnable		            	=  false
ENT.AdminSpawnable		            =  false

ENT.PrintName		                =  "Gredwitch's Shell base"
ENT.Author			                =  "Gredwitch"
ENT.Contact			                =  "qhamitouche@gmail.com"
ENT.Category                        =  "Gredwitch's Stuff"

ENT.Model							=	"models/gredwitch/bombs/75mm_shell.mdl"
ENT.IsShell							=	true
ENT.MuzzleVelocity					=	0
ENT.Caliber							=	0
ENT.RSound							=	0
ENT.ShellType						=	""
ENT.EffectWater						=	"ins_water_explosion"

function ENT:SetupDataTables()
	self:NetworkVar("Bool",0,"Fired")
	self:NetworkVar("String",0,"ShellType")
	self:NetworkVar("String",1,"TracerColor")
	self:NetworkVar("Int",0,"Caliber")
end

function ENT:PhysicsUpdate(ph)
	if self.Fired then
		if self:WaterLevel() >= 1 then
			local vel = ph:GetVelocity()
			if vel:Length() < self.ImpactSpeed then return end
			if self.ShellType == "AP" then
				self.LastVel = vel
				local HitAng = vel:Angle()
				HitAng:Normalize()
				local c = os.clock()
				if self:CanRicochet(HitAng) then
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
		self.ExplosionDamage = 150 + self.Caliber
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
	else
		self.AngEffect = true
		self.Effect = "gred_ap_impact"
		self.EffectAir = "gred_ap_impact"
		self.ExplosionRadius = 100
		self.Decal = "scorch_small"
	end
	
	self.EnginePower 			= ((self.MuzzleVelocity*gred.CVars["gred_sv_shell_speed_multiplier"]:GetFloat())/0.02540002032) -- m/s
	self.EffectAir 				= self.Effect
	self.Smoke 					= self.ShellType == "Smoke"
	
	self:SetTracerColor(self.TracerColor)
	self:SetCaliber(self.Caliber)
	self:SetShellType(self.ShellType)
	self:SetModelScale(self.Caliber / 75)
	
	for k,v in pairs(ents.FindByClass("gmod_sent_vehicle_fphysics_wheel")) do
		constraint.NoCollide(self,v,0,0)
	end
	
	if !(WireAddon == nil) then self.Inputs = Wire_CreateInputs(self, { "Arm", "Detonate", "Launch" }) end
end

local Baseclass = baseclass.Get("base_rocket")

function ENT:Launch()
	baseclass.Get("base_rocket").Launch(self)
	self:SetBodygroup(0,1)
	self:SetFired(self.Fired)
end

function ENT:AddOnThink()
	-- print("VELOCITE = ",(self:GetPhysicsObject():GetVelocity():Length()*0.02540002032).."m/s")
end

function ENT:AddOnExplode(pos) 
	if self.ShellType == "AP" then
		local vel = (self.LastVel and self.LastVel:Length()*0.02540002032 or self.MuzzleVelocity)
		self.Penetration = (((vel/gred.CVars["gred_sv_shell_speed_multiplier"]:GetFloat())*math.sqrt(self.Mass))/(2400*math.sqrt(self.Caliber)))*1000
		self.ExplosionDamage = self.Penetration*vel*0.1*gred.CVars["gred_sv_shell_ap_damagemultiplier"]:GetFloat()
		-- print("TEMPS DE VOL = "..(CurTime()-self.LAUNCHTIME).."s  -  DISTANCE = "..(self.LAUNCHPOS:Distance(pos)*0.02540002032).."m  - VELOCITE PERDUE = "..(self.MuzzleVelocity-vel).."  -  DEGATS = "..(self.ExplosionDamage).."  -  PENETRATION = "..(self.Penetration).."mm  -  VELOCITE EN SORTIE DE CANNON = "..self.MuzzleVelocity.."m/s  -  MASSE = "..self.Mass.."kg  -  CALIBRE = "..self.Caliber.."mm")
	end
	if self:WaterLevel() < 1 then
		if self.ShellType == "AP" then
			local fwd = self.LastVel:Angle():Forward()
			local tr = util.QuickTrace(pos - fwd*2,fwd*(self.Penetration),self)
			local hitmat = util.GetSurfacePropName(tr.SurfaceProps)
			local class
			self.EffectAir = "AP_impact_wall"
			for k,v in pairs(ents.FindInSphere(tr.HitPos,50)) do
				class = v:GetClass()
				if class == "gmod_sent_vehicle_fphysics_base" then--or class == "gmod_sent_vehicle_fphysics_wheel" then
					if v.GRED_ISTANK and gred.CVars.gred_sv_shell_ap_lowpen_system:GetInt() == 1 then
						local fraction = v:GetMaxHealth()*0.01/self.Penetration
						if fraction >= 1 then
							if gred.CVars.gred_sv_shell_ap_lowpen_shoulddecreasedamage:GetInt() == 1 then 
								self.ExplosionDamage = self.ExplosionDamage / (fraction*fraction)
							end
							local hitang = tr.HitNormal:Angle()
							local CVar = gred.CVars.gred_sv_shell_ap_lowpen_maxricochetchance:GetFloat()
							if math.Rand(0,CVar) > math.abs(math.cos(math.rad(hitang.y))) or math.Rand(0,CVar) > math.abs(math.cos(math.rad(hitang.p))) then
								self.RICOCHET = os.clock()
								self:Ricochet(pos,hitang)
								return true
							end
						end
					end
					hitmat = "metal"
					local dmg = DamageInfo()
					dmg:SetAttacker(self.GBOWNER)
					dmg:SetInflictor(self)
					dmg:SetDamagePosition(pos)
					dmg:SetDamage(v.GRED_ISTANK and self.ExplosionDamage*10 or self.ExplosionDamage)
					dmg:SetDamageType(64) -- DMG_BLAST
					v:TakeDamageInfo(dmg)
					break
				end
			end
			self.ExplosionDamage = 0
			if materials[hitmat] == 1 then
				self.Effect = "AP_impact_wall"
				self.ExplosionSound = table.Random(APMetalSounds)
				self.FarExplosionSound = table.Random(APMetalSounds)
				pos = tr.HitPos+(fwd*2)
			elseif materials[hitmat] == 2 then
				self.ExplosionSound = table.Random(APWoodSounds)
				self.FarExplosionSound = table.Random(APWoodSounds)
			else
				self.ExplosionSound = table.Random(APSounds)
				self.FarExplosionSound = table.Random(APSounds)
			end
		end
	end
end

function ENT:Use( activator, caller )
	if self.Fired then return end
	local ct = CurTime()
	self.NextUse = self.NextUse or 0
	if self.NextUse >= ct then return end
	if self:IsPlayerHolding() then return end
	activator:PickupObject(self)
	activator:SetNWEntity("PickedUpObject",self)
	self.PlyPickup = activator
	self.NextUse = ct + 0.1
end

function ENT:OnRemove()
	if IsValid(self.PlyPickup) then
		self.PlyPickup:DropObject()
	end
	self:StopParticles()
end
-- ENT.shouldOwnerHearSnd = true
if CLIENT then
	-- local glow = Material("sprites/animglow02") 
	local soundSpeed = 18005.25
	local particle
	local vector_zero = Vector(0,0,0)
	local colors = {
		["red"] = CreateMaterial("gred_mat_shell_tracer_red","VertexLitGeneric",{
			["$basetexture"]				= "sprites/animglow02",
			["$color"]						= "{255 0 0}",
		}),
		["green"] = CreateMaterial("gred_mat_shell_tracer_green","VertexLitGeneric",{
			["$basetexture"]				= "sprites/animglow02",
			["$color"]						= "{0 255 0}",
		}),
		["white"] = Material("sprites/animglow02") ,--CreateMaterial("gred_mat_shell_tracer_white","VertexLitGeneric",{
			-- ["$basetexture"]				= "sprites/animglow02",
			-- ["$color"]						= "{255 255 255}",
		-- }),
	}
	
	local function CalcLength(source,receiver)
		local V_s,V_r = source:GetVelocity(),receiver:GetVelocity()
		local vs,vr = source:WorldToLocal(receiver:GetPos())*V_s,receiver:WorldToLocal(source:GetPos())*V_r
		V_s = vs.x > 0 and V_s:Length() or -V_s:Length()
		V_r = vr.x > 0 and V_r:Length() or -V_r:Length()
		return V_s,V_r
	end
	
	local function VectorEqual(v1,v2)
		return v1.x == v2.x and v1.y == v1.y and v1.z == v2.z
	end
	
	function ENT:Initialize()
		self.ply = LocalPlayer()
		self.Emitter = ParticleEmitter(self:GetPos(),false)
		self.shouldOwnerNotHearSnd = false
		
		self.snd = self.snd or {
			CreateSound(self,"bomb/tank_shellwhiz.wav"),
			CreateSound(self,"bomb/shell_trail.wav"),
			-- CreateSound(self,"gredwitch/Shell_fly_loop_03.wav"),
		}
		-- self:SetNoDraw(true)
		self:CallOnRemove("stopshellsnd",function(self)
			if self.snd then 
				for k,v in pairs (self.snd) do
					v:ChangeVolume(0)
					v:Stop()
				end
			end
			if self.Emitter and IsValid(self.Emitter) then self.Emitter:Finish() end
		end)
		for k,v in pairs(self.snd) do v:ChangeVolume(80) end
		
		timer.Simple(0,function()
			if self.GetShellType then  -- sometimes the function just doesn't exist
				if self:GetShellType() != "AP" and !self.snd["wiz_mortar"] then
					table.insert(self.snd,CreateSound(self,"bomb/shellwhiz_mortar_"..math.random(1,2)..".wav"))
					self.snd[#self.snd]:SetSoundLevel(80)
				end
				self.TracerColor = self:GetTracerColor()
				self.TracerColor = colors[self.TracerColor] and colors[self.TracerColor] or colors["white"]
				self.Caliber = self:GetCaliber()
				self.Inited = true
			end
		end)
		self.Rate = 0.03
		self.DefaultF = math.random(110,190)
	end
	local function ClampVector(vec,min,max)
		return Vector(math.Clamp(vec.x,min.x,max.x),math.Clamp(vec.y,min.y,max.y),math.Clamp(vec.z,min.z,max.z))
	end
	function ENT:Think()
		if !self.Inited then self:Initialize() end
		if self.GetFired and !self:GetFired() then return end
		local pos,fwd,v = self:GetPos(),self:GetForward(),self:GetVelocity()
		local fwdv = v:Angle():Forward()
		if self.TracerColor and !VectorEqual(v,vector_zero) then
			if IsValid(self.Emitter) then
				for i = 1,10 do
					particle = self.Emitter:Add(self.TracerColor,pos + fwdv*(i*-self.Caliber*0.1) )--+ ClampVector(fwdv*30,vector_zero,fwd*30))
					if particle then
						particle:SetVelocity(v)
						particle:SetDieTime(0.05)
						particle:SetAirResistance(0) 
						particle:SetStartAlpha(255)
						particle:SetStartSize(self.Caliber and self.Caliber*0.2 or 20)
						particle:SetEndSize(0)
						particle:SetRoll(math.Rand(-1,1))
						particle:SetGravity(Vector(0,0,0))
						particle:SetCollide(false)
					end
				end
			else
				self.Emitter = ParticleEmitter(self:GetPos(),false)
			end
		end
		if !IsValid(self.ply) then return end
		
		local ent = self.ply:GetViewEntity()
		if (ent != self.GBOWNER and ent != self.Owner) or self.shouldOwnerHearSnd then
			local vs,vr = CalcLength(self,ent)
			local f = (self.DefaultF or 100) * (soundSpeed + vr) / (soundSpeed + vs)
			for k,v in pairs (self.snd) do
				v:Play()
				v:ChangePitch(f,self.Rate or 0.1)
			end
		else
			for k,v in pairs (self.snd) do
				v:Stop()
			end
		end
	end
end