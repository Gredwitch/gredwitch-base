AddCSLuaFile()

sound.Add( {
	name = "V1_Startup",
	channel = CHAN_AUTO,
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

ENT.StartSoundFollow                 =  true          
ENT.ShouldUnweld                     =  true          
ENT.ShouldIgnite                     =  false         
ENT.UseRandomSounds                  =  true                  
ENT.SmartLaunch                      =  true  
ENT.Timed                            =  false 

ENT.ExplosionDamage                  =  20000
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