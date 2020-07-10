AddCSLuaFile()
DEFINE_BASECLASS( "base_bomb" )
sound.Add( {
	name = "RP3_Engine",
	channel = CHAN_STATIC,
	volume = 1.0,
	level = 90,
	pitch = {100},
	sound = "gunsounds/rpg_rocket_loop.wav"
} )

sound.Add( {
	name = "Hydra_Engine",
	channel = CHAN_STATIC,
	volume = 1.0,
	level = 90,
	pitch = {100},
	sound = "wac/rocket_idle.wav"
} )

sound.Add( {
	name = "V1_Engine",
	channel = CHAN_STATIC,
	volume = 1.0,
	level = 90,
	pitch = {100},
	sound = "gunsounds/v1_loop.wav"
} )

sound.Add( {
	name = "Nebelwerfer_Fire",
	channel = CHAN_STATIC,
	volume = 1.0,
	level = 90,
	pitch = {80,140},
	sound = "gunsounds/nebelwerfer_rocket.wav"
} )
local ExploSnds = {}
ExploSnds[1]                      =  "chappi/imp0.wav"

local damagesound                    =  "weapons/rpg/shotdown.wav"


ENT.Spawnable		            	 =  false
ENT.AdminSpawnable		             =  false

ENT.PrintName		                 =  "[ROCKETS]Base rocket"
ENT.Author			                 =  "Gredwitch"
ENT.Contact			                 =  "contact.gredwitch@gmail.com"
ENT.Category                         =  "Gredwitch's Stuff"

ENT.RocketTrail                      =  ""
ENT.RocketBurnoutTrail               =  ""
    
ENT.StartSound                       =  ""
ENT.EngineSound                      =  "Missile.Ignite"

ENT.SmartLaunch                      =  false
ENT.EnginePower                      =  0
ENT.FuelBurnoutTime                  =  0
ENT.IgnitionDelay                    =  0
ENT.SmartLaunch                      =  false
ENT.ImpactSpeed                      =  200
ENT.RotationalForce                  =  25
ENT.ForceOrientation                 =  "NORMAL"

ENT.RicochetWhitelist = {
	["LeftTrack"] = true,
	["RightTrack"] = true,
}

ENT.RICOCHET_ANGLES = {
	["APCBC"] = {
		[1] = 48,
		[2] = 63,
		[3] = 71,
	},
	["APDS"] = {
		[1] = 75,
		[2] = 78,
		[3] = 80,
	},
	["APFSDS"] = {
		[1] = 78,
		[2] = 80,
		[3] = 81,
	},
	["HEATFS"] = {
		[1] = 65,
		[2] = 72,
		[3] = 77,
	},
	["HEAT"] = {
		[1] = 62,
		[2] = 69,
		[3] = 73,
	},
	["HE"] = {
		[1] = 79,
		[2] = 80,
		[3] = 81,
	},
	["AP"] = {
		[1] = 47,
		[2] = 60,
		[3] = 65,
	},
	["APCR"] = {
		[1] = 66,
		[2] = 70,
		[3] = 72,
	},
}
ENT.RICOCHET_ANGLES.APHE = ENT.RICOCHET_ANGLES.AP
ENT.RICOCHET_ANGLES.APBC = ENT.RICOCHET_ANGLES.APCBC
ENT.RICOCHET_ANGLES.APC = ENT.RICOCHET_ANGLES.APCBC
ENT.RICOCHET_ANGLES.APHECBC = ENT.RICOCHET_ANGLES.APCBC
ENT.RICOCHET_ANGLES.APHEBC = ENT.RICOCHET_ANGLES.APBC



local World = Entity(0)

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




function ENT:AddOnInit() 
	if !(WireAddon == nil) then self.Inputs = Wire_CreateInputs(self, { "Arm", "Detonate", "Launch" }) end
end

function ENT:TriggerInput(iname, value)
	if (!self:IsValid()) then return end
	if (iname == "Detonate") then
	    if (value >= 1) then
		    if (!self.Exploded and self.Armed) then
			    timer.Simple(math.Rand(0,self.MaxDelay),function()
				    if !self:IsValid() then return end
					self.Exploded = true
					self:Explode()
				end)
		    end
		end
	end
	if (iname == "Arm") then
	    if (value >= 1) then
		   if (!self.Exploded and !self.Armed and !self.Arming) then
			    self:EmitSound(self.ActivationSound)
			  self:Arm()
		   end 
	    end
	end
	if (iname == "Launch") then 
	    if (value >= 1) then
		    if (!self.Exploded and !self.Burnt and !self.Ignition and !self.Fired) then
			    self:Launch()
		    end
	    end
	end
end

function ENT:OnTakeDamage(dmginfo)
	if self.Exploded then return end
	exploDamage = dmginfo:IsDamageType(64)
	if exploDamage == true then return end
	if (self.Life <= 0) then return end
	self:TakePhysicsDamage(dmginfo)
	if(gred.CVars["gred_sv_fragility"]:GetBool()) then  
	    if(!self.Fired and !self.Burnt and !self.Arming and !self.Armed) then
		   if(math.random(0,9) == 1) then
			   self:Launch()
		    else
			    self:Arm()
			end
	    end
	end
	if(self.Fired and !self.Burnt and self.Armed) then
	    if (dmginfo:GetDamage() >= 2) then
		    local phys = self:GetPhysicsObject()
		    self:EmitSound(damagesound)
		   phys:AddAngleVelocity(dmginfo:GetDamageForce()*0.1)
	    end
	end
	if(!self.Armed) then return end
	self.Life = self.Life - dmginfo:GetDamage()
	if (self.Life <= 0) then 
		timer.Simple(math.Rand(0,self.MaxDelay),function()
		   if !self:IsValid() then return end 
			self.Exploded = true
			self:Explode()
			
	    end)
	end
end

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

local color_red = Color(255,0,0,255)
local color_green = Color(0,255,0,255)

function ENT:DoModuleDamage(tr,ShrapnelTab,Ricochet)
	
	tr = gred.DoModuleStuff(tr,tr.Entity,nil,ShrapnelTab,Ricochet)
	
	if istable(tr.ModulesHit) then
		tr.Entity.LastShellInflictor = self
		tr.Entity.LastShellAttacker = self.GBOWNER
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

function ENT:Ricochet(pos,ang,time,data)
	if self.RICOCHET and time-self.RICOCHET < 0.05 then return end
	
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
		if (!self.Fired and !self.Burnt and !self.Arming and !self.Armed) and (data.Speed >= self.ImpactSpeed * 5) then 
			if math.random(0,9) == 1 then
				self:Launch()
				self:EmitSound(damagesound)
			else
				self:Arm()
				self:EmitSound(damagesound)
			end
		end
	end
	
	if (self.Fired or self.Armed) and data.Speed >= self.ImpactSpeed then
		if self.ShellType then
			self.LastVel = data.OurOldVelocity
			self.PostHitVel = data.OurNewVelocity
			
			if self.IS_AP[self.ShellType] then
				if IsValid(data.HitEntity) and (data.HitEntity:IsPlayer() or data.HitEntity:IsNPC()) and badmats[data.HitEntity:GetMaterialType()] then
					local dmg = DamageInfo()
					dmg:SetAttacker(self.GBOWNER)
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
					
					if surfaceprop and gred.Mats[surfaceprop] and gred.MatsStr[gred.Mats[surfaceprop]] and !NO_RICOCHET[gred.MatsStr[gred.Mats[surfaceprop]]] then
						local HitAng = self:WorldToLocalAngles(data.HitNormal:Angle())
						local c = os.clock()
						self.RicochetCount = self.RicochetCount or 0
						
						if self.RicochetCount <= 10 and (!self.RICOCHET or self.RICOCHET+0.1 >= c) and self:CanRicochet(HitAng) then
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

function ENT:Launch()
	if self.Exploded or self.Burnt or self.Fired then return end
	self.ImpactSpeed = 10
	local phys = self:GetPhysicsObject()
	if !IsValid(phys) then return end
	
	self.Fired = true
	if self.SmartLaunch then
		-- constraint.RemoveAll(self)
	end
	phys:Wake()
	phys:EnableMotion(true)
	if self.IgnitionDelay > 0 then
		timer.Simple(self.IgnitionDelay,function()
			if not IsValid(phys) then return end
			self:InitLaunch(phys)
		end)
	else
		self:InitLaunch(phys)
	end
end

function ENT:InitLaunch(phys)
	self.LAUNCHTIME = CurTime()
	self.LAUNCHPOS = self:GetPos()
	self.Ignition = true
	self:Arm()
	if self.StartSoundFollow then
		self:EmitSound(self.StartSound)
	else
		sound.Play(self.StartSound,self:GetPos(),120,100,1)
	end
	if self.IsShell then
		phys:SetVelocityInstantaneous(self:GetForward() * self.EnginePower)
		return
	end
	
	if self.RocketTrail != "" then 
		ParticleEffectAttach(self.RocketTrail,PATTACH_ABSORIGIN_FOLLOW,self,1)
	end
	if self.FuelBurnoutTime != 0 then 
		timer.Simple(self.FuelBurnoutTime,function()
			if !IsValid(self) then return end
			self.Burnt = true
			self:StopParticles()
			self:StopSound(self.EngineSound)
			self:StopSound(self.StartSound)
			if self.RocketBurnoutTrail != "" then 
				ParticleEffectAttach(self.RocketBurnoutTrail,PATTACH_ABSORIGIN_FOLLOW,self,1) 
			end
		end)
	end
end

function ENT:Think()
	if not (self.Burnt or !self.Ignition or self.Exploded) then
		local phys = self:GetPhysicsObject()
		if !self.IsShell then
			phys:AddVelocity(self:GetForward() * self.EnginePower) -- Continuous engine impulse
		end
		if self.Armed then
		   phys:AddAngleVelocity(Vector(self.RotationalForce,0,0)) -- Rotational force
		end
	end
	self:AddOnThink()
	self:NextThink(CurTime())
	return true
end

function ENT:Arm()
	if self.Armed then return end
	self.Arming = true
	
	timer.Simple(self.ArmDelay,function()
	    if !IsValid(self) then return end 
	    self.Armed = true
		self.Arming = false
		self.ImpactSpeed = 100
		self:EmitSound(self.ArmSound)
		if self.Timed then
		   timer.Simple(self.Timer,function()
			  if !IsValid(self) then return end 
			    self.Exploded = true
			    self:Explode()
		   end)
		end
	end)
end	

function ENT:Use( activator, caller )
	if gred.CVars["gred_sv_easyuse"]:GetInt() < 1 or self.Fired then return end
	self:EmitSound(self.ActivationSound)
	self:Launch()
end

function ENT:OnRemove()
	self:StopSound(self.EngineSound)
	self:StopSound(self.StartSound)
	self:StopParticles()
end

