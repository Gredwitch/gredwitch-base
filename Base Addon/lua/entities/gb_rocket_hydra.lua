AddCSLuaFile()

DEFINE_BASECLASS( "base_rocket" )

local ExploSnds = {}
ExploSnds[1]                         =  "wac/tank/tank_shell_01.wav"
ExploSnds[2]                         =  "wac/tank/tank_shell_02.wav"
ExploSnds[3]                         =  "wac/tank/tank_shell_03.wav"
ExploSnds[4]                         =  "wac/tank/tank_shell_04.wav"
ExploSnds[5]                         =  "wac/tank/tank_shell_05.wav"
	
local ExploSndsNOWAC = {}
ExploSndsNOWAC[1]                         =  "explosions/doi_ty_01.wav"
ExploSndsNOWAC[2]                         =  "explosions/doi_ty_02.wav"
ExploSndsNOWAC[3]                         =  "explosions/doi_ty_03.wav"
ExploSndsNOWAC[4]                         =  "explosions/doi_ty_04.wav"

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

ENT.PrintName		                 =  "[ROCKETS]Hydra 70"
ENT.Author			                 =  ""
ENT.Contact			                 =  ""
ENT.Category                         =  "Gredwitch's Stuff"

ENT.Model                  		     =  "models/weltensturm/wac/rockets/rocket01.mdl"
ENT.RocketTrail                      =  "ins_rockettrail"
ENT.RocketBurnoutTrail               =  "grenadetrail"
ENT.Effect                           =  "high_explosive_air"
ENT.EffectAir                        =  "high_explosive_air"
ENT.EffectWater                      =  "water_torpedo" 

ENT.ExplosionSound				 	 =  table.Random(ExploSnds)

ENT.StartSound                       =  ""          
ENT.ArmSound                         =  "helicoptervehicle/missileshoot.mp3"            
ENT.ActivationSound                  =  "buttons/button14.wav"

ENT.EngineSound                  	 =  "Hydra_Engine"

ENT.ShouldUnweld                     =  true          
ENT.ShouldIgnite                     =  false                
ENT.SmartLaunch                      =  true  
ENT.Timed                            =  false 

ENT.ExplosionDamage                  =  500
ENT.ExplosionRadius                  =  250             
ENT.PhysForce                        =  500             
ENT.SpecialRadius                    =  250           
ENT.MaxIgnitionTime                  =  0           
ENT.Life                             =  1
ENT.MaxDelay                         =  0
ENT.TraceLength                      =  1000
ENT.ImpactSpeed                      =  50         
ENT.Mass                             =  7             
ENT.EnginePower                      =  300
ENT.FuelBurnoutTime                  =  12         
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
	if wac then 
		ent.Model = "models/weltensturm/wac/rockets/rocket01.mdl"
	else
		ent.Model = "models/doi/ty_missile.mdl"
	end
	ent:SetPhysicsAttacker(ply)
    ent:SetPos( tr.HitPos + tr.HitNormal * 16 ) 
    ent:Spawn()
    ent:Activate()
	
	ent.ExplosionSound = table.Random(ExploSnds)
	if not wac then
		ent.ExplosionSound = table.Random(CloseExploSnds)
		ent.FarExplosionSound	= table.Random(ExploSndsNOWAC)
		ent.DistExplosionSound	= table.Random(DistExploSnds)
		ent.WaterExplosionSound	= table.Random(CloseWaterExploSnds)
		ent.WaterFarExplosionSound	= table.Random(WaterExploSnds)
		ent.EngineSound = "RP3_Engine"
	else
		ent.ExplosionSound = table.Random(ExploSnds)
		ent.EngineSound = "Hydra_Engine"
	end
    return ent
end