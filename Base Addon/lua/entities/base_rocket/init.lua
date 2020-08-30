AddCSLuaFile("shared.lua")
AddCSLuaFile("init.lua")
include("shared.lua")

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

local RayMul = {
	["Transmission"] = 1,
	["Engine"] = 1.5,
	["LeftTrack"] = 1.5,
	["RightTrack"] = 1.5,
	["TurretRing"] = 2,
	["Ammo"] = 4,
	["GunBreach"] = 1.5,
	["MG"] = 1.5,
}

local RaySquare = {
	["LeftTrack"] = 4,
	["RightTrack"] = 4,
}

local badmats = {
	MAT_ANTLION = true,
	MAT_BLOODYFLESH = true,
	MAT_FLESH = true,
	MAT_ALIENFLESH = true,
	[67] = true,
}

local NO_RICOCHET = {
	-- ["fruit"] = true,
	["mud"] = true,
	["snow"] = true,
	["sand"] = true,
}

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

-- I didn't make the WireMod code

function ENT:AddOnInit()
	self.Filter = {self}
	self.MaxVelocityUnitsSquared = self.MaxVelocity and self:ConvertMetersToUnits(self.MaxVelocity * self.MaxVelocity) or nil
	if not (WireAddon == nil) then self.Inputs = Wire_CreateInputs(self, { "Arm", "Detonate", "Launch" }) end
end

function ENT:TriggerInput(iname, value)
	if value >= 1 and not self.Exploded then
		if iname == "Detonate" and self.Armed then
			self:ExplodeCorrectly()
		elseif iname == "Arm" and not self.Armed and not self.Arming then
			self:EmitSound(self.ActivationSound)
			self:Arm()
		elseif iname == "Launch" and not self.Burnt and not self.Ignition and not self.Fired then
			self:Launch()
		end
	end
end 

function ENT:OnTakeDamage(dmginfo)
	if self.Exploded then return end
	
	local inflictor = dmginfo:GetInflictor()
	
	if IsValid(inflictor) and inflictor.IsGredBomb then return end
	
	self:TakePhysicsDamage(dmginfo)
	
	if gred.CVars["gred_sv_fragility"]:GetBool() and not self.Fired and not self.Burnt and not self.Arming and not self.Armed then
		if math.random(9) == 1 then
			self:Launch()
		else
			self:Arm()
		end
	end
	
	
	if self.Fired and not self.Burnt and self.Armed and dmginfo:GetDamage() >= 2 then
		local phys = self:GetPhysicsObject()
		
		if IsValid(phys) then
			self:EmitSound("weapons/rpg/shotdown.wav")
			phys:AddAngleVelocity(dmginfo:GetDamageForce()*0.1)
		end
	end
	 
	if not self.Armed then return end

	self.CurLife = self.CurLife - dmginfo:GetDamage()
	
	if self.CurLife <= 0 then
		self:ExplodeCorrectly()
	elseif self.CurLife <= self.Life * 0.5 and not self.Exploded and self.Flamable then
		self:Ignite(self.MaxDelay,0)
	end
end

-- Ricochet stuff

function ENT:CalculateRicochetChance(AbsAng,C000,C050,C100)
	if AbsAng < C050 then
		return 1 - (0.5 - ((C050 - AbsAng) / (C050 - C000)) * 0.5)
	elseif AbsAng > C050 then
		return 1 - (0.5 + ((AbsAng - C050) / (C100 - C050)) * 0.5)
	else
		return 0.5
	end
end

function ENT:CanRicochet(ang)
	if self.RICOCHET_ANGLES[self.ShellType] then
		local abs_p,abs_y = math.abs(ang.p),math.abs(ang.y)
		if abs_p <= self.RICOCHET_ANGLES[self.ShellType][1] and abs_y <= self.RICOCHET_ANGLES[self.ShellType][1] then 
			return false
		end
		if abs_p >= self.RICOCHET_ANGLES[self.ShellType][3] or abs_y >= self.RICOCHET_ANGLES[self.ShellType][3] then 
			return true
		end
		
		if math.Rand(0,1) > self:CalculateRicochetChance(abs_p,self.RICOCHET_ANGLES[self.ShellType][1],self.RICOCHET_ANGLES[self.ShellType][2],self.RICOCHET_ANGLES[self.ShellType][3]) then return true end
		if math.Rand(0,1) > self:CalculateRicochetChance(abs_y,self.RICOCHET_ANGLES[self.ShellType][1],self.RICOCHET_ANGLES[self.ShellType][2],self.RICOCHET_ANGLES[self.ShellType][3]) then return true end
	end
	
	return false
end

function ENT:Ricochet(pos,ang,time,data)
	if self.RICOCHET and time - self.RICOCHET < 0.05 then return end -- prevent spam
	
	self.ImpactSpeed = 0
	gred.CreateSound(pos,false,"impactsounds/Tank_shell_impact_ricochet_w_whizz_0"..math.random(1,5)..".ogg","impactsounds/Tank_shell_impact_ricochet_w_whizz_mid_0"..math.random(1,3)..".ogg","impactsounds/Tank_shell_impact_ricochet_w_whizz_mid_0"..math.random(1,3)..".ogg")
	
	ang = self:LocalToWorldAngles(ang)
	ang:RotateAroundAxis(ang:Right(),180)
	
	local effectdata = EffectData()
	effectdata:SetOrigin(pos)
	effectdata:SetNormal(ang:Forward())
	effectdata:SetSurfaceProp(data.TheirSurfaceProps)
	util.Effect("gred_particle_shellricochet",effectdata)
	
	self.Exploded = false
	
	if data.HitEntity and data.HitEntity.GRED_TANK and gred.CVars.gred_sv_simfphys_moduledamagesystem:GetBool() then
		local fwd = self:GetForward()
		local tr = util.QuickTrace(data.HitPos - fwd*100,fwd*200,self.Filter)
		
		if IsValid(tr.Entity) and tr.Entity.GRED_TANK then
			tr = gred.GetImpactInfo(tr,tr.Entity)
			tr = gred.CalculateArmourThickness(tr,tr.Entity,0)
			self:DoModuleDamage(tr,nil,true)
		end
	end
end

function ENT:PhysicsCollide(data,physobj)
	self.LastVel = data.OurOldVelocity
	
	if self.Exploded then return end
	
	if gred.CVars["gred_sv_fragility"]:GetBool() then
		if (not self.Fired and not self.Burnt and not self.Arming and not self.Armed) and data.Speed >= self.ImpactSpeed * 5 then 
			self:EmitSound("weapons/rpg/shotdown.wav")
			
			-- if math.random(9) == 1 then
				self:Launch()
			-- else
				-- self:Arm()
			-- end
		end
	end
	
	if (self.Fired or self.Armed) and data.Speed >= self.ImpactSpeed then
		if self.ShellType then
			self.LastVel = data.OurOldVelocity
			self.PostHitVel = data.OurNewVelocity
			
			if self.IS_AP[self.ShellType] then
				if IsValid(data.HitEntity) and (data.HitEntity:IsPlayer() or data.HitEntity:IsNPC()) and badmats[data.HitEntity:GetMaterialType()] then
					local dmg = DamageInfo()
					dmg:SetAttacker(self.Owner)
					dmg:SetInflictor(self)
					dmg:SetDamagePosition(data.HitPos)
					dmg:SetDamage(self.Caliber*data.OurOldVelocity:Length())
					dmg:SetDamageType(64) -- DMG_BLAST
					data.HitEntity:TakeDamageInfo(dmg)
					
					local effectdata = EffectData()
					effectdata:SetOrigin(data.HitPos)
					effectdata:SetNormal(data.HitNormal)
					effectdata:SetEntity(self)
					effectdata:SetScale(data.HitEntity:GetModelRadius()/50)
					effectdata:SetRadius(data.HitEntity:GetMaterialType())
					effectdata:SetMagnitude(10)
					
					util.Effect("gred_particle_blood_explosion",effectdata)
					physobj:SetVelocityInstantaneous(data.OurOldVelocity)
					return
					-- self.NO_EFFECT = true
				else
					local surfaceprop = util.GetSurfacePropName(data.TheirSurfaceProps)
					
					if surfaceprop and gred.Mats[surfaceprop] and gred.MatsStr[gred.Mats[surfaceprop]] and not NO_RICOCHET[gred.MatsStr[gred.Mats[surfaceprop]]] then
						local HitAng = self:WorldToLocalAngles(data.HitNormal:Angle())
						local c = os.clock()
						self.RicochetCount = self.RicochetCount or 0
						
						if self.RicochetCount <= 10 and (not self.RICOCHET or self.RICOCHET+0.1 >= c) and self:CanRicochet(HitAng) then
							self.RicochetCount = self.RicochetCount + 1
							
							self:Ricochet(data.HitPos,HitAng,c,data)
							self.RICOCHET = c
							return
						end
					end
				end
			end
		end
		
		self.PhysObj = physobj
		self.Exploded = true
		self:Explode(data.HitPos)
	end
end

--

function ENT:Launch()
	if self.Exploded or self.Burnt or self.Fired then return end
	
	local phys = self:GetPhysicsObject()
	
	if !IsValid(phys) then return end
	
	self.ImpactSpeed = 10
	
	self.Fired = true
	
	if self.SmartLaunch then
		constraint.RemoveAll(self)
	end
	
	phys:Wake()
	phys:EnableMotion(true)
	
	if self.IgnitionDelay > 0 then
		timer.Simple(self.IgnitionDelay,function()
			if not IsValid(phys) or not IsValid(self) then return end
			
			self:InitLaunch(phys)
		end)
	else
		self:InitLaunch(phys)
	end
end

function ENT:InitLaunch(phys)
	self:SetNWBool("Fired",true)
	
	self.LAUNCHTIME = CurTime()
	self.LAUNCHPOS = self:GetPos()
	self.Ignition = true
	self:Arm()
	
	if self.StartSoundFollow then
		self:EmitSound(self.StartSound)
	else
		sound.Play(self.StartSound,self:GetPos(),120,100,1)
	end
	
	phys:AddAngleVelocity(Vector(self.RotationalForce or 0,0,0)) -- Rotational force
	
	self:PostLaunch(phys)
	
	if self.IsShell then
		phys:SetVelocityInstantaneous(self:GetForward() * self.EnginePower)
		
		return
	end
	
	phys:EnableDrag(true)
	phys:SetDragCoefficient(self.Drag)
	
	if self.RocketTrail then
		timer.Simple(0,function()
			if !IsValid(self) then return end
			
			ParticleEffectAttach(self.RocketTrail,PATTACH_ABSORIGIN_FOLLOW,self,1)
		end)
	end
	
	if self.FuelBurnoutTime and self.FuelBurnoutTime != 0 then 
		timer.Simple(self.FuelBurnoutTime,function()
			if !IsValid(self) then return end
			
			self.Burnt = true
			self:StopParticles()
			self:StopSound(self.EngineSound)
			self:StopSound(self.StartSound)
			
			if self.RocketBurnoutTrail then 
				ParticleEffectAttach(self.RocketBurnoutTrail,PATTACH_ABSORIGIN_FOLLOW,self,1) 
			end
		end)
	end
end

function ENT:PostLaunch(phys)

end

function ENT:Think()
	if not (self.Burnt or not self.Ignition or self.Exploded) then
		local phys = self:GetPhysicsObject()
		
		if IsValid(phys) then
			if self.MaxVelocityUnitsSquared and phys:GetVelocity():LengthSqr() < self.MaxVelocityUnitsSquared then
				phys:ApplyForceCenter(self:GetForward() * self.EnginePower)
			end
		end
	end
	
	self:AddOnThink()
	
	self:NextThink(CurTime())
	return true
end

function ENT:Use(ply)
	if not gred.CVars["gred_sv_easyuse"]:GetBool() or self.Fired then return end
	
	self.Owner = ply
	self:EmitSound(self.ActivationSound)
	self:Launch()
end

function ENT:OnRemove()
	self:StopSound(self.EngineSound)
	self:StopSound(self.StartSound)
	self:StopParticles()
end

-- Shelltype stuff

function ENT:ConvertMetersToUnits(Meters)
	return Meters / 0.01905
end

function ENT:ConvertUnitsToMeters(Units)
	return Units * 0.01905
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
		
		self.EffectAir = (self.IsShell and self.IS_AP[self.ShellType]) and "AP_impact_wall" or self.EffectAir
		
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
				
				if Fraction >= 1 and self.IsShell then
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
							if v:IsPlayer() and v:GetSimfphys() == tr.Entity then v:TakeDamage(self.ExplosionDamage*0.15,self.Owner,self) end
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
				local DamageToDeal = (tr.Entity.GRED_TANK and ((Fraction and Fraction >= 1 and !self.IS_AP[self.ShellType]) and 0 or self.ExplosionDamage) or (self.IS_APCR[self.ShellType] and self.ExplosionDamag or self.ExplosionDamage)) -- need to localize it otherwise it fucks up
				dmg:SetAttacker(self.Owner)
				dmg:SetInflictor(self)
				dmg:SetDamagePosition(tr.HitPos)
				dmg:SetDamage(DamageToDeal)
				dmg:SetDamageType(64) -- DMG_BLAST
				dmg:SetDamageCustom(self:EntIndex())
				tr.Entity:TakeDamageInfo(dmg)
				
				if IsValid(self.Owner) and self.Owner:IsPlayer() and gred.CVars.gred_sv_shell_enable_killcam:GetBool() then
					local CompressedTab = util.Compress(util.TableToJSON(ShrapnelTab))
					local len = CompressedTab:len()
					
					net.Start("gred_net_shell_shrapnel_windows_send")
						net.WriteUInt(len,14)
						net.WriteData(CompressedTab,len)
					net.Send(self.Owner)
				end
			end
			
			if self.IsShell and (self.IS_HEAT[self.ShellType] or self.IS_AP[self.ShellType]) then
				self.ExplosionDamage = 0
				self.ExplosionRadius = 0
			end
		end
		-- print("PENETRATION = "..self.Penetration.."mm - DAMAGE = "..self.ExplosionDamage.." - DISTANCE = "..((self.LAUNCHPOS-pos):Length()*0.01905).."m - IMPACT VELOCITY = "..vel.."m/s - MUZZLE VELOCITY = "..self.MuzzleVelocity.."m/s - VELOCITY DIFFERENCE = "..self.MuzzleVelocity-vel.." - DRAG COEFFICIENT = "..self.DragCoefficient.." - MASS = "..self.Mass.." - CALIBER = "..self.Caliber)
		
		if self.ShellType != "HE" and self.IsShell then
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


-- Old module system thing, unused and stupid

function ENT:DoModuleDamage(tr,ShrapnelTab,Ricochet)
	
	tr = gred.DoModuleStuff(tr,tr.Entity,nil,ShrapnelTab,Ricochet)
	
	if istable(tr.ModulesHit) then
		tr.Entity.LastShellInflictor = self
		tr.Entity.LastShellAttacker = self.Owner
		tr.Entity.LastShellPos = tr.HitPos
		
		if Ricochet then
			if tr.ModulesHit.LeftTrack then
				self:DamageModule("LeftTrack",tr.ModulesHit.LeftTrack,tr.Entity)
			end
			if tr.ModulesHit.RightTrack then
				self:DamageModule("RightTrack",tr.ModulesHit.RightTrack,tr.Entity)
			end
		else
			for Name,Tab in pairs(tr.ModulesHit) do
				self:DamageModule(Name,Tab,tr.Entity)
			end
		end
	end
end

function ENT:DamageModule(Name,Tab,vehicle)
	for ModuleID,ModuleParts in pairs(Tab) do
		local DamageTable = {}
		local Damage = 0
		local TempDamage = 0
		
		for k,v in pairs(ModuleParts) do
			TempDamage = ((1 - v.Fraction)^(RaySquare[Name] or 1)) * 30 * (RayMul[Name] or 1)
			Damage = TempDamage > Damage and TempDamage or Damage
		end
		print("ModuleHealth_"..Name.."_"..ModuleID,Damage)
		-- vehicle:SetNWInt("ModuleHealth_"..Name.."_"..ModuleID,math.Round(vehicle:GetNWInt("ModuleHealth_"..Name.."_"..ModuleID,100) - Damage))
		
	end
end