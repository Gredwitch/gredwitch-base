AddCSLuaFile()

DEFINE_BASECLASS( "base_bomb" )

ENT.Spawnable		            	 =  true
ENT.AdminSpawnable		             =  true

ENT.PrintName		                 =  "[BOMBS] CBU-52U"
ENT.Author			                 =  "Gredwitch"
ENT.Contact		                     =  "qhamitouche@gmail.com"
ENT.Category                         =  "Gredwitch's Stuff"

ENT.Model                            =  "models/gbombs/bomb_cbu.mdl"
ENT.Effect                           =  "high_explosive_main_2"
ENT.EffectAir                        =  "high_explosive_air_2"
ENT.EffectWater                      =  "water_medium"
ENT.ExplosionSound                   =  "explosions/gbomb_6.mp3"
ENT.ArmSound                         =  "npc/roller/mine/rmine_blip3.wav"
ENT.ActivationSound                  =  "buttons/button14.wav"

ENT.ShouldUnweld                     =  true
ENT.ShouldIgnite                     =  false
ENT.ShouldExplodeOnImpact            =  true
ENT.Flamable                         =  false
ENT.UseRandomSounds                  =  false
ENT.Timed                            =  false

ENT.ExplosionDamage                  =  200
ENT.PhysForce                        =  200
ENT.ExplosionRadius                  =  600
ENT.SpecialRadius                    =  500
ENT.MaxIgnitionTime                  =  0
ENT.Life                             =  50
ENT.MaxDelay                         =  0
ENT.TraceLength                      =  3000
ENT.ImpactSpeed                      =  700
ENT.Mass                             =  52
ENT.ArmDelay                         =  0
ENT.GBOWNER                          =  nil             -- don't you fucking touch this.


ENT.DEFAULT_PHYSFORCE                = 155
ENT.DEFAULT_PHYSFORCE_PLYAIR         = 20
ENT.DEFAULT_PHYSFORCE_PLYGROUND      = 1000

function ENT:Explode()
     if !self.Exploded then return end
	 if self.Exploding then return end
	
	 local pos = self:LocalToWorld(self:OBBCenter())
	
	 constraint.RemoveAll(self)
	 local physo = self:GetPhysicsObject()
	 physo:Wake()	
	 self.Exploding = true
	 if !self:IsValid() then return end 
	 self:StopParticles()
	 local pos = self:LocalToWorld(self:OBBCenter())
	 
	 for i=0, (15-1) do
		 local ent1 = ents.Create("gb_bomb_cbubomblet") 
		 local phys = ent1:GetPhysicsObject()
		 ent1:SetPos( self:GetPos() ) 
		 ent1:Spawn()
		 ent1:Activate()
		 ent1:SetVar("GBOWNER", self.GBOWNER)
		 local bphys = ent1:GetPhysicsObject()
		 local phys = self:GetPhysicsObject()
		 if bphys:IsValid() and phys:IsValid() then
			 bphys:ApplyForceCenter(VectorRand() * bphys:GetMass() * 155)
			 bphys:AddVelocity(phys:GetVelocity()/2)
		 end
	end
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
	
	
	if(self:WaterLevel() >= 1) then
		 local trdata   = {}
		 local trlength = Vector(0,0,9000)

		 trdata.start   = pos
		 trdata.endpos  = trdata.start + trlength
		 trdata.filter  = self
		 local tr = util.TraceLine(trdata) 

		 local trdat2   = {}
		 trdat2.start   = tr.HitPos
		 trdat2.endpos  = trdata.start - trlength
		 trdat2.filter  = self
		 trdat2.mask    = MASK_WATER + CONTENTS_TRANSLUCENT
			 
		 local tr2 = util.TraceLine(trdat2)
			 
	     if tr2.Hit then
		     ParticleEffect(self.EffectWater, tr2.HitPos, Angle(0,0,0), nil)
		 end
		 
		if self.WaterExplosionSound == nil then else 
			self.ExplosionSound = self.WaterExplosionSound 
		end
		if self.WaterFarExplosionSound == nil then else  
			self.FarExplosionSound = self.WaterFarExplosionSound 
		end
		
     else
		 local tracedata    = {}
	     tracedata.start    = pos
		 tracedata.endpos   = tracedata.start - Vector(0, 0, self.TraceLength)
		 tracedata.filter   = self.Entity
				
		 local trace = util.TraceLine(tracedata)
	     
		 if trace.HitWorld then
		    if self.Effect == "doi_artillery_explosion" or self.Effect == "doi_stuka_explosion" or self.Effect == "ins_rpg_explosion" then 
				ParticleEffect(self.Effect,pos,Angle(-90,0,0),nil) 
				--[[local Beffect = self:CreateParticleEffect(self.Effect,2, { attachtype = 2  } )--self.Effect,0,nil)--{1,self,pos})
				Beffect:SetControlPoint(4,Vector(114,114,114))
				Beffect:StartEmission()--]]
			else
				ParticleEffect(self.Effect,pos,Angle(0,0,0),nil)
			end
		 else 
		    if self.EffectAir == "doi_artillery_explosion" or self.EffectAir == "doi_stuka_explosion" or self.EffectAir == "ins_rpg_explosion" then 
				ParticleEffect(self.EffectAir,pos,Angle(-90,0,0),nil) 
			else
				ParticleEffect(self.EffectAir,pos,Angle(0,0,0),nil)
			end
		 end
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
     ent:SetPos( tr.HitPos + tr.HitNormal * 16 ) 
     ent:Spawn()
     ent:Activate()

     return ent
end