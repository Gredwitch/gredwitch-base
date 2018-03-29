AddCSLuaFile()

DEFINE_BASECLASS( "base_rocket" )

ENT.Spawnable		            	 =  true
ENT.AdminSpawnable		             =  true

ENT.PrintName		                 =  "[ROCKETS]AM39 Exocet"
ENT.Author			                 =  ""
ENT.Contact			                 =  ""
ENT.Category                         =  "Gredwitch's Stuff"

ENT.Model                            =  "models/hawx/exocet am39.mdl"
ENT.RocketTrail                      =  "ins_rockettrail"
ENT.RocketBurnoutTrail               =  ""
ENT.Effect                           =  "500lb_ground"
ENT.EffectAir                        =  "500lb_ground"
ENT.EffectWater                      =  "water_torpedo"
ENT.ExplosionSound                   =  "explosions/gbomb_4.mp3" 
ENT.StartSound                       =  "gunsounds/rocket2.wav"
ENT.ArmSound                         =  "npc/roller/mine/rmine_blip3.wav"
ENT.ActivationSound                  =  "buttons/button14.wav"
ENT.EngineSound                      =  "RP3_Engine"

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
ENT.TraceLength                      =  50          
ENT.ImpactSpeed                      =  100         
ENT.Mass                             =  45
ENT.EnginePower                      =  9999
ENT.FuelBurnoutTime                  =  20
ENT.IgnitionDelay                    =  0.5
ENT.ArmDelay                         =  0
ENT.RotationalForce                  =  500  
ENT.ForceOrientation                 =  "NORMAL"       
ENT.Timer                            =  0


ENT.DEFAULT_PHYSFORCE                = 155
ENT.DEFAULT_PHYSFORCE_PLYAIR         = 20
ENT.DEFAULT_PHYSFORCE_PLYGROUND         = 1000     
ENT.Shocktime                        = 2

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