AddCSLuaFile()

DEFINE_BASECLASS( "base_rocket" )

local ExploSnds = {}
ExploSnds[1]                         =  "wac/tank/tank_shell_01.wav"
ExploSnds[2]                         =  "wac/tank/tank_shell_02.wav"
ExploSnds[3]                         =  "wac/tank/tank_shell_03.wav"
ExploSnds[4]                         =  "wac/tank/tank_shell_04.wav"
ExploSnds[5]                         =  "wac/tank/tank_shell_05.wav"

ENT.Spawnable		            	 =  true         
ENT.AdminSpawnable		             =  true 

ENT.PrintName		                 =  "[ROCKETS]Hydra 70"
ENT.Author			                 =  ""
ENT.Contact			                 =  ""
ENT.Category                         =  "Gredwitch's Stuff"

ENT.Model                            =  "models/weltensturm/wac/rockets/rocket01.mdl"
ENT.RocketTrail                      =  "ins_rockettrail"
ENT.RocketBurnoutTrail               =  "grenadetrail"
ENT.Effect                           =  "100lb_air"
ENT.EffectAir                        =  "100lb_air"
ENT.EffectWater                      =  "water_torpedo" 

ENT.ExplosionSound				 	 =  table.Random(ExploSnds)

ENT.StartSound                       =  ""          
ENT.ArmSound                         =  "helicoptervehicle/missileshoot.mp3"            
ENT.ActivationSound                  =  "buttons/button14.wav"    
ENT.EngineSound                      =  "Hydra_Engine"

ENT.ShouldUnweld                     =  true          
ENT.ShouldIgnite                     =  false                
ENT.SmartLaunch                      =  true  
ENT.Timed                            =  false 

ENT.ExplosionDamage                  =  500
ENT.ExplosionRadius                  =  300             
ENT.PhysForce                        =  500             
ENT.SpecialRadius                    =  300           
ENT.MaxIgnitionTime                  =  0           
ENT.Life                             =  1            
ENT.MaxDelay                         =  0           
ENT.TraceLength                      =  50          
ENT.ImpactSpeed                      =  100         
ENT.Mass                             =  7             
ENT.EnginePower                      =  9999999
ENT.FuelBurnoutTime                  =  12         
ENT.IgnitionDelay                    =  0.1           
ENT.ArmDelay                         =  0
ENT.RotationalForce                  =  500  
ENT.ForceOrientation                 =  "NORMAL"       
ENT.Timer                            =  0


ENT.DEFAULT_PHYSFORCE                = 155
ENT.DEFAULT_PHYSFORCE_PLYAIR         = 20
ENT.DEFAULT_PHYSFORCE_PLYGROUND         = 1000     
ENT.Shocktime                        = 1

ENT.GBOWNER                          =  nil             -- don't you fucking touch this.

function ENT:SpawnFunction( ply, tr )
    if ( !tr.Hit ) then return end
	self.GBOWNER = ply
    local ent = ents.Create( self.ClassName )
	ent:SetPhysicsAttacker(ply)
    ent:SetPos( tr.HitPos + tr.HitNormal * 16 ) 
    ent:Spawn()
    ent:Activate()
	
	ent.ExplosionSound = table.Random(ExploSnds)
	
    return ent
end