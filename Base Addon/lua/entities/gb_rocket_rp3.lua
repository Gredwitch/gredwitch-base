AddCSLuaFile()

DEFINE_BASECLASS( "base_rocket" )

local ExploSnds = {}
ExploSnds[1]                         =  "explosions/doi_ty_01.wav"
ExploSnds[2]                         =  "explosions/doi_ty_02.wav"
ExploSnds[3]                         =  "explosions/doi_ty_03.wav"
ExploSnds[4]                         =  "explosions/doi_ty_04.wav"

local CloseExploSnds = {}
CloseExploSnds[1]                         =  "explosions/doi_ty_01_close.wav"
CloseExploSnds[2]                         =  "explosions/doi_ty_02_close.wav"
CloseExploSnds[3]                         =  "explosions/doi_ty_03_close.wav"
CloseExploSnds[4]                         =  "explosions/doi_ty_04_close.wav"

local DistExploSnds = {}
DistExploSnds[1]                         =  "explosions/doi_ty_01_dist.wav"
DistExploSnds[2]                         =  "explosions/doi_ty_02_dist.wav"
DistExploSnds[3]                         =  "explosions/doi_ty_03_dist.wav"
DistExploSnds[4]                         =  "explosions/doi_ty_03_dist.wav"

local WaterExploSnds = {}
WaterExploSnds[1]                         =  "explosions/doi_ty_01_water.wav"
WaterExploSnds[2]                         =  "explosions/doi_ty_02_water.wav"
WaterExploSnds[3]                         =  "explosions/doi_ty_03_water.wav"
WaterExploSnds[4]                         =  "explosions/doi_ty_04_water.wav"

local CloseWaterExploSnds = {}
CloseWaterExploSnds[1]                         =  "explosions/doi_ty_01_closewater.wav"
CloseWaterExploSnds[2]                         =  "explosions/doi_ty_02_closewater.wav"
CloseWaterExploSnds[3]                         =  "explosions/doi_ty_03_closewater.wav"
CloseWaterExploSnds[4]                         =  "explosions/doi_ty_04_closewater.wav"

ENT.Spawnable		            	 =  true         
ENT.AdminSpawnable		             =  true 

ENT.PrintName		                 =  "[ROCKETS]RP-3"
ENT.Author			                 =  ""
ENT.Contact			                 =  ""
ENT.Category                         =  "Gredwitch's Stuff"

ENT.Model                            =  "models/doi/ty_missile.mdl"
ENT.RocketTrail                      =  "rockettrail"
ENT.RocketBurnoutTrail               =  "grenadetrail"
ENT.Effect                           =  "doi_mortar_explosion"
ENT.AngEffect						 =	true
ENT.EffectAir                        =  "doi_mortar_explosion"
ENT.EffectWater                      =  "ins_water_explosion" 

ENT.ExplosionSound                   =  table.Random(CloseExploSnds)
ENT.FarExplosionSound				 =  table.Random(ExploSnds)
ENT.DistExplosionSound				 =  table.Random(DistExploSnds)
ENT.WaterExplosionSound				 =  table.Random(CloseWaterExploSnds)
ENT.WaterFarExplosionSound			 =  table.Random(WaterExploSnds)
ENT.RSound							 =	0

ENT.StartSound                       =  "gunsounds/rocket.wav"          
ENT.ArmSound                         =  "npc/roller/mine/rmine_blip3.wav"            
ENT.ActivationSound                  =  "buttons/button14.wav"    
ENT.EngineSound                      =  "RP3_Engine"

ENT.ShouldUnweld                     =  true          
ENT.ShouldIgnite                     =  false         
ENT.UseRandomSounds                  =  true                  
ENT.SmartLaunch                      =  true  
ENT.Timed                            =  false 

ENT.ExplosionDamage                  =  500
ENT.ExplosionRadius                  =  300
ENT.PhysForce                        =  500
ENT.SpecialRadius                    =  300
ENT.MaxIgnitionTime                  =  0
ENT.Life                             =  1
ENT.MaxDelay                         =  0
ENT.TraceLength                      =  1000
ENT.ImpactSpeed                      =  50
ENT.Mass                             =  30
ENT.EnginePower                      =  100
ENT.FuelBurnoutTime                  =  3
ENT.IgnitionDelay                    =  0.1           
ENT.ArmDelay                         =  0
ENT.RotationalForce                  =  500  
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
	
	ent.ExplosionSound	= table.Random(CloseExploSnds)
	ent.FarExplosionSound	= table.Random(ExploSnds)
	ent.DistExplosionSound	= table.Random(DistExploSnds)
	ent.WaterExplosionSound	= table.Random(CloseWaterExploSnds)
	ent.WaterFarExplosionSound	= table.Random(WaterExploSnds)

    return ent
end