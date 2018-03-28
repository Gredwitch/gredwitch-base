AddCSLuaFile()

DEFINE_BASECLASS( "base_bomb" )

local ExploSnds = {}
ExploSnds[1]                         =  "explosions/gbombs_napalm_1.mp3"
ExploSnds[2]                         =  "explosions/gbombs_napalm_2.mp3"
ExploSnds[3]                         =  "explosions/gbombs_napalm_3.mp3"
ExploSnds[4]                         =  "explosions/gbombs_napalm_4.mp3"


ENT.Spawnable		            	 =  true         
ENT.AdminSpawnable		             =  true 

ENT.PrintName		                 =  "[BOMBS]Mark 77 Napalm"
ENT.Author			                 =  "Gredwitch"
ENT.Contact		                     =  "qhamitouche@gmail.com"
ENT.Category                         =  "Gredwitch's Stuff"

ENT.Model                            =  "models/gbombs/napalm.mdl"                      
ENT.Effect                           =  "napalm_explosion"                  
ENT.EffectAir                        =  "napalm_explosion_midair"                   
ENT.EffectWater                      =  "water_medium"
ENT.ExplosionSound                   =  "explosions/gbombs_napalm_1.mp3"
ENT.ArmSound                         =  "npc/roller/mine/rmine_blip3.wav"            
ENT.ActivationSound                  =  "buttons/button14.wav"     

ENT.ShouldUnweld                     =  true
ENT.ShouldIgnite                     =  false
ENT.ShouldExplodeOnImpact            =  true
ENT.Flamable                         =  false
ENT.UseRandomSounds                  =  true
ENT.UseRandomModels                  =  false
ENT.Timed                            =  false

ENT.ExplosionDamage                  =  750
ENT.PhysForce                        =  750
ENT.ExplosionRadius                  =  950
ENT.SpecialRadius                    =  950
ENT.MaxIgnitionTime                  =  0 
ENT.Life                             =  20                                  
ENT.MaxDelay                         =  2                                 
ENT.TraceLength                      =  300
ENT.ImpactSpeed                      =  350
ENT.Mass                             =  340
ENT.ArmDelay                         =  0
ENT.Timer                            =  0

ENT.GBOWNER                          =  nil             -- don't you fucking touch this.

function ENT:Explode()
	local ent = ents.Create("base_napalm")
	local pos = self:GetPos()
	ent:SetPos( pos )
	ent:Spawn()
	ent:Activate()
	ent:SetVar("GBOWNER",self.GBOWNER)
	
	local ent = ents.Create("shockwave_ent")
	ent:SetPos( pos ) 
	ent:Spawn()
	ent:Activate()
	ent:SetVar("DEFAULT_PHYSFORCE", self.DEFAULT_PHYSFORCE)
	ent:SetVar("DEFAULT_PHYSFORCE_PLYAIR", self.DEFAULT_PHYSFORCE_PLYAIR)
	ent:SetVar("DEFAULT_PHYSFORCE_PLYGROUND", self.DEFAULT_PHYSFORCE_PLYGROUND)
	ent:SetVar("GBOWNER", self.GBOWNER)
	ent:SetVar("SHOCKWAVEDAMAGE",self.ExplosionDamage)
	ent:SetVar("MAX_RANGE",self.ExplosionRadius)
	ent:SetVar("SHOCKWAVE_INCREMENT",100)
	ent:SetVar("DELAY",0.01)
	ent.trace=self.TraceLength
	ent.decal=self.Decal
	for k, v in pairs(ents.FindInSphere(pos,1700)) do
		if v:IsPlayer() or v:IsNPC() then
			if v:GetClass()=="npc_helicopter" then return end
			v:Ignite(6,0)
		else
			local phys = self:GetPhysicsObject()
			if phys:IsValid() then
				v:Ignite(12,0)
			end
		end
	end
	local tracedata    = {}
	tracedata.start    = pos
	tracedata.endpos   = tracedata.start - Vector(0, 0, self.TraceLength)
	tracedata.filter   = self.Entity
				
	local trace = util.TraceLine(tracedata)
	if trace.Hit then
		ParticleEffect(self.Effect,pos,Angle(0,0,0),nil)
    end
	 
	local ent = ents.Create("shockwave_sound_lowsh")
	ent:SetPos( pos ) 
	ent:Spawn()
	ent:Activate()
	ent:SetVar("GBOWNER", self.GBOWNER)
	ent:SetVar("MAX_RANGE",self.ExplosionDamage*self.ExplosionRadius)
	if self.RSound == nil then ent:SetVar("NOFARSOUND",1) else
		ent:SetVar("NOFARSOUND",self.RSound) 
	end
	ent:SetVar("SHOCKWAVE_INCREMENT",200)
	
	ent:SetVar("DELAY",0.01)
	ent:SetVar("SOUNDCLOSE", self.ExplosionSound)
	ent:SetVar("SOUND", self.FarExplosionSound)
	ent:SetVar("SOUNDFAR", self.DistExplosionSound)
	ent:SetVar("Shocktime", 0)
	 
	 if self.IsNBC then
	     local nbc = ents.Create(self.NBCEntity)
		 nbc:SetVar("GBOWNER",self.GBOWNER)
		 nbc:SetPos(self:GetPos())
		 nbc:Spawn()
		 nbc:Activate()
	 end
     self:Remove()
end

function ENT:SpawnFunction( ply, tr )
     if ( !tr.Hit ) then return end
     self.GBOWNER = ply
     local ent = ents.Create( self.ClassName )
     ent:SetPhysicsAttacker(ply)
     ent:SetPos( tr.HitPos + tr.HitNormal * 26 )
     ent:Spawn()
     ent:Activate()

     return ent
end