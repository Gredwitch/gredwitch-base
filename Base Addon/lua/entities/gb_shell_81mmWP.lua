AddCSLuaFile()

DEFINE_BASECLASS( "base_shell" )

local ExploSnds = {}
ExploSnds[1]                         =  "explosions/doi_wp_01.wav"
ExploSnds[2]                         =  "explosions/doi_wp_02.wav"
ExploSnds[3]                         =  "explosions/doi_wp_03.wav"
ExploSnds[4]                         =  "explosions/doi_wp_04.wav"

ENT.Spawnable		            	 =  false         
ENT.AdminSpawnable		             =  false 

ENT.PrintName		                 =  "[SHELLS]81mm WP Shell"
ENT.Author			                 =  "Gredwitch"
ENT.Contact			                 =  "qhamitouche@gmail.com"
ENT.Category                         =  "Gredwitch's Stuff"
ENT.Model                            =  "models/gredwitch/bombs/artillery_shell.mdl"
ENT.Mass                             =  10

ENT.Effect                           =  "doi_wparty_explosion"
ENT.EffectAir                        =  "doi_wparty_explosion"
ENT.EffectWater                      =  "ins_water_explosion"
ENT.AngEffect						 =	true

ENT.ExplosionSound                   =  table.Random(ExploSnds)
ENT.RSound   						 =  1

ENT.ShouldUnweld                     =  false
ENT.ShouldIgnite                     =  false
ENT.SmartLaunch                      =  true
ENT.Timed                            =  false

ENT.APDamage						 =  150
ENT.ExplosionDamage                  =  30
ENT.ExplosionRadius                  =  350


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

function ENT:AddOnExplode()
	local ent = ents.Create("base_napalm")
	local pos = self:GetPos()
	ent:SetPos(pos)
	ent.Radius	 = 500
	ent.Rate  	 = 1
	ent.Lifetime = 15
	ent:Spawn()
	ent:Activate()
	ent:SetVar("GBOWNER",self.GBOWNER)
end