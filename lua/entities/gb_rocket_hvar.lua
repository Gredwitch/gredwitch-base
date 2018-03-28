AddCSLuaFile()

DEFINE_BASECLASS( "base_rocket" )

local ExploSnds = {}
ExploSnds[1]                         =  "explosions/doi_panzerschreck_01.wav"
ExploSnds[2]                         =  "explosions/doi_panzerschreck_02.wav"
ExploSnds[3]                         =  "explosions/doi_panzerschreck_03.wav"

local CloseExploSnds = {}
CloseExploSnds[1]                         =  "explosions/doi_panzerschreck_01_close.wav"
CloseExploSnds[2]                         =  "explosions/doi_panzerschreck_02_close.wav"
CloseExploSnds[3]                         =  "explosions/doi_panzerschreck_03_close.wav"

local DistExploSnds = {}
DistExploSnds[1]                         =  "explosions/doi_panzerschreck_01_dist.wav"
DistExploSnds[2]                         =  "explosions/doi_panzerschreck_02_dist.wav"
DistExploSnds[3]                         =  "explosions/doi_panzerschreck_03_dist.wav"

local WaterExploSnds = {}
WaterExploSnds[1]                         =  "explosions/doi_panzerschreck_01_water.wav"
WaterExploSnds[2]                         =  "explosions/doi_panzerschreck_02_water.wav"
WaterExploSnds[3]                         =  "explosions/doi_panzerschreck_03_water.wav"

local CloseWaterExploSnds = {}
CloseWaterExploSnds[1]                         =  "explosions/doi_panzerschreck_01_closewater.wav"
CloseWaterExploSnds[2]                         =  "explosions/doi_panzerschreck_02_closewater.wav"
CloseWaterExploSnds[3]                         =  "explosions/doi_panzerschreck_03_closewater.wav"

ENT.Spawnable		            	 =  true
ENT.AdminSpawnable		             =  true

ENT.PrintName		                 =  "[ROCKETS]HVAR"
ENT.Author			                 =  ""
ENT.Contact			                 =  ""
ENT.Category                         =  "Gredwitch's Stuff"

ENT.Model                            =  "models/gredwitch/hvar.mdl"
ENT.RocketTrail                      =  "ins_rockettrail"
ENT.RocketBurnoutTrail               =  "grenadetrail"
ENT.Effect                           =  "500lb_air"
ENT.EffectAir                        =  "500lb_air"
ENT.EffectWater                      =  "water_torpedo"  
ENT.StartSound                       =  "gunsounds/rocket2.wav"
ENT.ArmSound                         =  "npc/roller/mine/rmine_blip3.wav"
ENT.ActivationSound                  =  "buttons/button14.wav"
ENT.EngineSound                      =  "RP3_Engine"

ENT.ExplosionSound                   =  table.Random(CloseExploSnds)
ENT.FarExplosionSound				 =  table.Random(ExploSnds)
ENT.DistExplosionSound				 =  table.Random(DistExploSnds)
ENT.WaterExplosionSound				 =  table.Random(CloseWaterExploSnds)
ENT.WaterFarExplosionSound			 =  table.Random(WaterExploSnds)
ENT.RSound							 =	0

ENT.ShouldUnweld                     =  true          
ENT.ShouldIgnite                     =  false         
ENT.UseRandomSounds                  =  true                  
ENT.SmartLaunch                      =  true  
ENT.Timed                            =  false 

ENT.ExplosionDamage                  =  500
ENT.ExplosionRadius                  =  500             
ENT.PhysForce                        =  500             
ENT.SpecialRadius                    =  500           
ENT.MaxIgnitionTime                  =  0           
ENT.Life                             =  1            
ENT.MaxDelay                         =  0           
ENT.TraceLength                      =  50          
ENT.ImpactSpeed                      =  100         
ENT.Mass                             =  45
ENT.EnginePower                      =  9999
ENT.FuelBurnoutTime                  =  20
ENT.IgnitionDelay                    =  0.1           
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
	
	ent.ExplosionSound	= table.Random(CloseExploSnds)
	ent.FarExplosionSound	= table.Random(ExploSnds)
	ent.DistExplosionSound	= table.Random(DistExploSnds)
	ent.WaterExplosionSound	= table.Random(CloseWaterExploSnds)
	ent.WaterFarExplosionSound	= table.Random(WaterExploSnds)

    return ent
end