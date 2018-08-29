AddCSLuaFile()

sound.Add( {
	name = "V1_Startup",
	channel = CHAN_STATIC,
	volume = 1.0,
	level = 150,
	pitch = {100},
	sound = "gunsounds/v1.wav"
} )
DEFINE_BASECLASS( "base_rocket" )

ENT.Spawnable		            	 =  true
ENT.AdminSpawnable		             =  true

ENT.PrintName		                 =  "[ROCKETS]V1"
ENT.Author			                 =  ""
ENT.Contact			                 =  ""
ENT.Category                         =  "Gredwitch's Stuff"

ENT.Model                            =  "models/gredwitch/bombs/v1.mdl"
ENT.RocketTrail                      =  "fire_jet_01"
ENT.RocketBurnoutTrail               =  ""
ENT.Effect                           =  "500lb_ground"
ENT.EffectAir                        =  "500lb_ground"
ENT.EffectWater                      =  "water_torpedo"
ENT.ExplosionSound                   =  "explosions/gbomb_4.mp3" 
ENT.StartSound                       =  "V1_Startup"
ENT.ArmSound                         =  "npc/roller/mine/rmine_blip3.wav"
ENT.ActivationSound                  =  "buttons/button14.wav"
ENT.EngineSound                      =  ""

ENT.ShouldUnweld                     =  true          
ENT.ShouldIgnite                     =  false         
ENT.UseRandomSounds                  =  true                  
ENT.SmartLaunch                      =  true  
ENT.Timed                            =  false 

ENT.ExplosionDamage                  =  500
ENT.PhysForce                        =  500
ENT.ExplosionRadius                  =  1450
ENT.SpecialRadius                    =  1450        
ENT.MaxIgnitionTime                  =  0.5
ENT.Life                             =  1
ENT.MaxDelay                         =  0
ENT.TraceLength                      =  1000
ENT.ImpactSpeed                      =  100
ENT.Mass                             =  700
ENT.EnginePower                      =  50
ENT.FuelBurnoutTime                  =  3
ENT.IgnitionDelay                    =  2
ENT.ArmDelay                         =  0
ENT.RotationalForce                  =  0
ENT.ForceOrientation                 =  "NORMAL"       
ENT.Timer                            =  0

ENT.GBOWNER                          =  nil             -- don't you fucking touch this.

function ENT:SpawnFunction( ply, tr )
     if ( !tr.Hit ) then return end
	 self.GBOWNER = ply
     local ent = ents.Create( self.ClassName )
	 ent:SetPhysicsAttacker(ply)
     ent:SetPos( tr.HitPos + tr.HitNormal * 16 ) 
     ent:Spawn()
     ent:Activate()


     return ent
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
		self:Launch()
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
	 timer.Simple(0.05,function()
	     if not self:IsValid() then return end
	     if(phys:IsValid()) then
             phys:Wake()
		     phys:EnableMotion(true)
	     end
	 end)
	 timer.Simple(self.IgnitionDelay,function()
	     if not self:IsValid() then return end  -- Make a short ignition delay!
		 self:SetNetworkedBool("Exploded",true)
		 self:SetNetworkedInt("LightRed", self.LightRed)
		 self:SetNetworkedInt("LightBlue", self.LightBlue)
		 self:SetNetworkedInt("LightGreen", self.LightGreen)	
		 self:SetNetworkedBool("EmitLight",true)
		 self:SetNetworkedInt("LightEmitTime", self.LightEmitTime)
		 self:SetNetworkedInt("LightBrightness", self.LightBrightness)
		 self:SetNetworkedInt("LightSize", self.LightSize)
		 local phys = self:GetPhysicsObject()
		 self.Ignition = true
		 self:Arm()
		 local pos = self:GetPos()
		 self:EmitSound(self.StartSound)
	     self:EmitSound(self.EngineSound)
		 self:SetNetworkedBool("EmitLight",true)
		 self:SetNetworkedBool("self.Ignition",true)
		if self.RocketTrail != "" then ParticleEffectAttach(self.RocketTrail,PATTACH_ABSORIGIN_FOLLOW,self,1) end
		 if(self.FuelBurnoutTime != 0) then 
	         timer.Simple(self.FuelBurnoutTime,function()
		         if not self:IsValid() then return end 
		         self.Burnt = true
		         self:StopParticles()
		         self:StopSound(self.EngineSound)
	            if self.RocketBurnoutTrail != "" then ParticleEffectAttach(self.RocketBurnoutTrail,PATTACH_ABSORIGIN_FOLLOW,self,1) end
             end)	 
		 end
     end)		 
end