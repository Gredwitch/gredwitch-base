AddCSLuaFile()

DEFINE_BASECLASS( "base_shell" )

local ExploSnds = {}
local CloseExploSnds = {}
local DistExploSnds = {}
for i =1,3 do
ExploSnds[i]                         =  "explosions/m67_detonate_dist_0"..i..".wav"

CloseExploSnds[i]                         =  "explosions/m67_detonate_0"..i..".wav"

DistExploSnds[i]                         =  "explosions/m67_detonate_far_dist_0"..i..".wav"
end

local WaterExploSnds = {}
WaterExploSnds[1]                         =  "explosions/doi_generic_01_water.wav"
WaterExploSnds[2]                         =  "explosions/doi_generic_02_water.wav"
WaterExploSnds[3]                         =  "explosions/doi_generic_03_water.wav"
WaterExploSnds[4]                         =  "explosions/doi_generic_04_water.wav"

local CloseWaterExploSnds = {}
CloseWaterExploSnds[1]                         =  "explosions/doi_generic_02_closewater.wav"
CloseWaterExploSnds[2]                         =  "explosions/doi_generic_02_closewater.wav"
CloseWaterExploSnds[3]                         =  "explosions/doi_generic_03_closewater.wav"
CloseWaterExploSnds[4]                         =  "explosions/doi_generic_04_closewater.wav"

ENT.Spawnable		            	 =  false         
ENT.AdminSpawnable		             =  false

ENT.PrintName		                 =  "[SHELLS]81mm Mortar Shell"
ENT.Author			                 =  "Gredwitch"
ENT.Contact			                 =  "qhamitouche@gmail.com"
ENT.Category                         =  "Gredwitch's Stuff"

ENT.Model                            =  "models/gredwitch/bombs/75mm_shell.mdl"
ENT.Effect                           =  "ins_m203_explosion"
ENT.EffectAir                        =  "ins_m203_explosion"
ENT.EffectWater                      =  "ins_water_explosion"
ENT.SmokeEffect						 =  "m203_smokegrenade"
ENT.AngEffect						 =	true
ENT.Mass                             =  5
     
ENT.ExplosionSound                   =  table.Random(CloseExploSnds)
ENT.FarExplosionSound				 =  table.Random(ExploSnds)
ENT.DistExplosionSound				 =  table.Random(DistExploSnds)
ENT.WaterExplosionSound				 =	table.Random(CloseWaterExploSnds)
ENT.WaterFarExplosionSound			 =  table.Random(WaterExploSnds)

ENT.RSound   						 =  0

ENT.ShouldUnweld                     =  false
ENT.ShouldIgnite                     =  false
ENT.SmartLaunch                      =  true
ENT.Timed                            =  false

ENT.APDamage						 =  1005
ENT.ExplosionDamage                  =  350
ENT.EnginePower                      =  100
ENT.ExplosionRadius                  =  350
ENT.ModelSize						 =	0.5

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

if CLIENT then
	function ENT:Initialize()
	end
	
	function ENT:Think()
	end
	
	function ENT:OnRemove()
	end
	
end