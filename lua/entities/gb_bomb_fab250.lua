AddCSLuaFile()

DEFINE_BASECLASS( "base_bomb" )

local ExploSnds = {}
ExploSnds[1]                         =  "explosions/doi_generic_01.wav"
ExploSnds[2]                         =  "explosions/doi_generic_02.wav"
ExploSnds[3]                         =  "explosions/doi_generic_03.wav"
ExploSnds[4]                         =  "explosions/doi_generic_04.wav"

local CloseExploSnds = {}
CloseExploSnds[1]                         =  "explosions/doi_generic_01_close.wav"
CloseExploSnds[2]                         =  "explosions/doi_generic_02_close.wav"
CloseExploSnds[3]                         =  "explosions/doi_generic_03_close.wav"
CloseExploSnds[4]                         =  "explosions/doi_generic_04_close.wav"

local DistExploSnds = {}
DistExploSnds[1]                         =  "explosions/doi_generic_01_dist.wav"
DistExploSnds[2]                         =  "explosions/doi_generic_02_dist.wav"
DistExploSnds[3]                         =  "explosions/doi_generic_03_dist.wav"
DistExploSnds[4]                         =  "explosions/doi_generic_04_dist.wav"

ENT.Spawnable		            	 =  true         
ENT.AdminSpawnable		             =  true 

ENT.PrintName		                 =  "[BOMBS]FAB-250"
ENT.Author			                 =  "Gredwitch"
ENT.Contact		                     =  "qhamitouche@gmail.com"
ENT.Category                         =  "Gredwitch's Stuff"

ENT.Model                            =  "models/gredwitch/fab250.mdl"
ENT.Effect                           =  "doi_artillery_explosion"
ENT.EffectAir                        =  "doi_artillery_explosion"
ENT.EffectWater                      =  "ins_water_explosion"

ENT.ExplosionSound                   =  table.Random(CloseExploSnds)
ENT.FarExplosionSound				 =  table.Random(ExploSnds)
ENT.DistExplosionSound				 =  table.Random(DistExploSnds)
ENT.RSound							 =	0

ENT.ArmSound                         =  "npc/roller/mine/rmine_blip3.wav"
ENT.ActivationSound                  =  "buttons/button14.wav"     

ENT.ShouldUnweld                     =  true
ENT.ShouldIgnite                     =  false
ENT.ShouldExplodeOnImpact            =  true
ENT.Flamable                         =  true
ENT.UseRandomSounds                  =  true
ENT.UseRandomModels                  =  false
ENT.Timed                            =  false

ENT.ExplosionDamage                  =  250
ENT.PhysForce                        =  1000
ENT.ExplosionRadius                  =  1000
ENT.SpecialRadius                    =  1000
ENT.MaxIgnitionTime                  =  0 
ENT.Life                             =  50
ENT.MaxDelay                         =  0                                 
ENT.TraceLength                      =  100
ENT.ImpactSpeed                      =  200
ENT.Mass                             =  250
ENT.ArmDelay                         =  0.1   
ENT.Timer                            =  0

ENT.Shocktime                        = 0
ENT.GBOWNER                          =  nil             -- don't you fucking touch this.

ENT.Decal                            = "scorch_medium"


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
	
    return ent
end
