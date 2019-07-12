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

ENT.PrintName		                 =  "Gredwitch's Rocket base"
ENT.Author			                 =  "Gredwitch"
ENT.Contact			                 =  "qhamitouche@gmail.com"
ENT.Category                         =  "Gredwitch's Stuff"

ENT.Model                            =  ""
ENT.RocketTrail                      =  ""
ENT.RocketBurnoutTrail               =  ""
ENT.Effect                           =  ""
ENT.EffectAir                        =  ""
ENT.EffectWater                      =  ""
     
ENT.ExplosionSound                   =  ENT.ExplosionSound
ENT.FarExplosionSound				 =  ENT.ExplosionSound
ENT.DistExplosionSound				 =  ENT.ExplosionSound
ENT.AngEffect						 =	false

ENT.WaterExplosionSound				 =	nil
ENT.WaterFarExplosionSound			 =  nil
    
ENT.StartSound                       =  ""
ENT.ArmSound                         =  ""
ENT.ActivationSound                  =  ""
ENT.EngineSound                      =  "Missile.Ignite"
ENT.NBCEntity                        =  ""

ENT.ShouldUnweld                     =  false
ENT.ShouldIgnite                     =  false
ENT.UseRandomSounds                  =  false
ENT.SmartLaunch                      =  true
ENT.Timed                            =  false
ENT.IsNBC                            =  false

ENT.ExplosionDamage                  =  0
ENT.ExplosionRadius                  =  0
ENT.PhysForce                        =  0
ENT.SpecialRadius                    =  0
ENT.MaxIgnitionTime                  =  5
ENT.Life                             =  20
ENT.MaxDelay                         =  2
ENT.TraceLength                      =  500
ENT.ImpactSpeed                      =  500
ENT.Mass                             =  0
ENT.EnginePower                      =  0
ENT.FuelBurnoutTime                  =  0
ENT.IgnitionDelay                    =  0
ENT.RotationalForce                  =  25
ENT.ArmDelay                         =  2
ENT.ForceOrientation                 =  "NORMAL"
ENT.Timer                            =  0
ENT.Smoke							 =  false

ENT.LightEmitTime                    =  0
ENT.LightRed                         =  0
ENT.LightBlue						 =  0
ENT.LightGreen						 =  0
ENT.LightBrightness					 =  0
ENT.LightSize   					 =  0
ENT.RSound   						 =  1

ENT.GBOWNER                          =  nil             -- don't you fucking touch this.

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
	if !self:IsValid() then return end
	if self.Exploded then return end
	exploDamage = dmginfo:IsDamageType(64)
	if exploDamage == true then return end
	if (self.Life <= 0) then return end
	self:TakePhysicsDamage(dmginfo)
	if(GetConVar("gred_sv_fragility"):GetInt() >= 1) then  
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

function ENT:PhysicsCollide( data, physobj )
	timer.Simple(0,function()
	-- print(data.HitEntity:GetClass())
	if(self.Exploded) then return end
	if(!self:IsValid()) then return end
	if(self.Life <= 0) then return end
		if(GetConVar("gred_sv_fragility"):GetInt() >= 1) then
			if(!self.Fired and !self.Burnt and !self.Arming and !self.Armed ) and (data.Speed > self.ImpactSpeed * 5) then --and !self.Arming and !self.Armed
				if(math.random(0,9) == 1) then
					self:Launch()
					self:EmitSound(damagesound)
				else
					self:Arm()
					self:EmitSound(damagesound)
				end
			end
		end

		if(!self.Armed) then return end
			
		if (data.Speed > self.ImpactSpeed )then
			self.Exploded = true
			self:Explode()
		end
	end)
end

function ENT:Launch()
	if(self.Exploded) then return end
	if(self.Burned) then return end
	--if(self.Armed) then return end
	if(self.Fired) then return end
	
	local phys = self:GetPhysicsObject()
	if !phys:IsValid() then return end
	self.Fired = true
	if(self.SmartLaunch) then
		constraint.RemoveAll(self)
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
	self:SetNetworkedBool("Exploded",true)
	self:SetNetworkedInt("LightRed", self.LightRed)
	self:SetNetworkedInt("LightBlue", self.LightBlue)
	self:SetNetworkedInt("LightGreen", self.LightGreen)	
	self:SetNetworkedBool("EmitLight",true)
	self:SetNetworkedInt("LightEmitTime", self.LightEmitTime)
	self:SetNetworkedInt("LightBrightness", self.LightBrightness)
	self:SetNetworkedInt("LightSize", self.LightSize)
	self.Ignition = true
	self:Arm()
	local pos = self:GetPos()
	sound.Play(self.StartSound, pos, 120, 100,1)
	-- self:EmitSound(self.EngineSound)
	self:SetNetworkedBool("EmitLight",true)
	self:SetNetworkedBool("self.Ignition",true)
	if self.IsShell then
		phys:AddVelocity(self:GetForward() * self.EnginePower)
		return
	end
	if self.RocketTrail != "" then ParticleEffectAttach(self.RocketTrail,PATTACH_ABSORIGIN_FOLLOW,self,1) end
	if(self.FuelBurnoutTime != 0) then 
		timer.Simple(self.FuelBurnoutTime,function()
			if not self:IsValid() then return end
			self.Burnt = true
			self:StopParticles()
			self:StopSound(self.EngineSound)
			self:StopSound(self.StartSound)
			if self.RocketBurnoutTrail != "" then ParticleEffectAttach(self.RocketBurnoutTrail,PATTACH_ABSORIGIN_FOLLOW,self,1) end
		end)
	end
end

function ENT:Think()
	if(self.Burnt) then return end
	if(!self.Ignition) then return end -- if there wasn't ignition, we won't fly
	if(self.Exploded) then return end -- if we exploded then what the fuck are we doing here
	if(!self:IsValid()) then return end -- if we aren't good then something fucked up
	local phys = self:GetPhysicsObject()
	local thrustpos = self:GetPos()
	if !self.IsShell then
		if(self.ForceOrientation == "RIGHT") then
			phys:AddVelocity(self:GetRight() * self.EnginePower) -- Continuous engine impulse
		elseif(self.ForceOrientation == "LEFT") then
			phys:AddVelocity(self:GetRight() * -self.EnginePower) -- Continuous engine impulse
		elseif(self.ForceOrientation == "UP") then
			phys:AddVelocity(self:GetUp() * self.EnginePower) -- Continuous engine impulse
		elseif(self.ForceOrientation == "DOWN") then 
			phys:AddVelocity(self:GetUp() * -self.EnginePower) -- Continuous engine impulse
		elseif(self.ForceOrientation == "INV") then
			phys:AddVelocity(self:GetForward() * -self.EnginePower) -- Continuous engine impulse
		else
			phys:AddVelocity(self:GetForward() * self.EnginePower) -- Continuous engine impulse
		end
	end
	if (self.Armed) then
	   phys:AddAngleVelocity(Vector(self.RotationalForce,0,0)) -- Rotational force
	end
	if self.Fired then
		if self:WaterLevel() >= 1 then self:Explode() end
	end
	self:AddOnThink()
	self:NextThink(CurTime() + 0.01)
	return true
end

function ENT:Arm()
	if(!self:IsValid()) then return end
	if(self.Armed) then return end
	self.Arming = true
	
	timer.Simple(self.ArmDelay, function()
	    if not self:IsValid() then return end 
	    self.Armed = true
		self.Arming = false
		self:EmitSound(self.ArmSound)
		if(self.Timed) then
		   timer.Simple(self.Timer, function()
			  if !self:IsValid() then return end 
			    self.Exploded = true
			    self:Explode()
				self.EmitLight = true
		   end)
		end
	end)
end	

function ENT:Use( activator, caller )
	if(self.Exploded) then return end
	if(self.Dumb) then return end
	if(GetConVar("gred_sv_easyuse"):GetInt() >= 1) then
	    if(self:IsValid()) then
		   if (!self.Exploded) and (!self.Burnt) and (!self.Fired) then
			  if (activator:IsPlayer()) then
				 self:EmitSound(self.ActivationSound)
				 self:Launch()
			   end
		   end
	    end
	end
end

function ENT:OnRemove()
	self:StopSound(self.EngineSound)
	self:StopSound(self.StartSound)
	self:StopParticles()
end

-- if CLIENT then
	-- function ENT:Initialize()
		-- if self.EngineSound == "" then return end
		-- self.snd = {}
		-- self.snd["rocket"] = CreateSound(self,self.EngineSound)
	-- end	
	-- function ENT:Think()
		-- if !self.snd or !self.Fired then return end
		-- local e=LocalPlayer():GetViewEntity()
		-- local pos=e:GetPos()
		-- local spos=self:GetPos()
		-- local val1=(pos:Distance(spos+e:GetVelocity())-pos:Distance(spos+self:GetVelocity()))/300
		-- local pitch = math.Clamp(1*100+1*1*3+val1, 0, 200)
		-- local volume = 1*math.Clamp(pitch*pitch/4000, 0, false and 1 or 5)
		-- for k,v in pairs (self.snd) do
			-- v:Play()
			-- v:ChangePitch(pitch,0.1)
			-- v:ChangeVolume(volume,0.1)
			-- v:SetSoundLevel(120)
		-- end
	-- end
	
	-- function ENT:OnRemove()
		-- if self.snd then 
			-- for k,v in pairs (self.snd) do
				-- v:Stop()
				-- v = nil
			-- end
		-- end
	-- end
-- end