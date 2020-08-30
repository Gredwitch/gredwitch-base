AddCSLuaFile()

DEFINE_BASECLASS( "base_bomb" )

ENT.Spawnable		            	 =  true
ENT.AdminSpawnable		             =  true

ENT.PrintName		                 =  "[BOMBS] CBU-52U"
ENT.Author			                 =  "Gredwitch"
ENT.Contact		                     =  "contact.gredwitch@gmail.com"
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
ENT.TraceLength                      =  1000
ENT.ImpactSpeed                      =  700
ENT.Mass                             =  52
ENT.ArmDelay                         =  0
ENT.GBOWNER                          =  nil             -- don't you fucking touch this.

ENT.Cube							 =	nil
ENT.DEFAULT_PHYSFORCE                = 155
ENT.DEFAULT_PHYSFORCE_PLYAIR         = 20
ENT.DEFAULT_PHYSFORCE_PLYGROUND      = 1000

function ENT:AddOnExplode()
	local pos = self:LocalToWorld(self:OBBCenter())
	local up = self:GetUp()
	for i=0, (30-1) do
		local ent1 = ents.Create("gb_bomb_cbubomblet") 
		local phys = ent1:GetPhysicsObject()
		ent1:SetPos(pos) 
		ent1:Spawn()
		ent1:Activate()
		ent1:Arm()
		ent1:SetVar("GBOWNER", self.GBOWNER)
		local bphys = ent1:GetPhysicsObject()
		local phys = self:GetPhysicsObject()
		if bphys:IsValid() and phys:IsValid() then
			bphys:ApplyForceCenter(up*155)
			bphys:AddVelocity(phys:GetVelocity()/2)
		end
	end
end

-- function ENT:Think()
	-- if self.Armed and SERVER then
		-- if self.Cube == nil then 
			-- local e = ents.Create("prop_dynamic")
			-- e:SetModel("models/hunter/blocks/cube05x05x05.mdl")
			-- e:Spawn()
			-- self.Cube = e
		-- end
		-- local pos = self:GetPos()
		-- local tr = util.QuickTrace(pos,self:GetUp()*-300,self)
		-- self.Cube:SetPos(tr.HitPos)
		-- if tr.Hit and !tr.HitSky then 
			-- print("blow up")
			-- self:Explode() 
		-- end
	-- end
-- end
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