AddCSLuaFile()

DEFINE_BASECLASS( "base_anim" )


ENT.Spawnable		            	 =  false
ENT.AdminSpawnable		             =  false     

ENT.PrintName		                 =  ""        
ENT.Author			                 =  ""      
ENT.Contact			                 =  ""      

ENT.GBOWNER                          =  nil            
ENT.MAX_RANGE                        = 0
ENT.SHOCKWAVE_INCREMENT              = 0
ENT.DELAY                            = 0
ENT.SOUND                            = ""
ENT.DEFAULT_PHYSFORCE		     = 500
ENT.DEFAULT_PHYSFORCE_PLYAIR         = 50
ENT.DEFAULT_PHYSFORCE_PLYGROUND      = 50
if SERVER then
	function ENT:Initialize()  
		self.FILTER = {}
		self:SetModel("models/mm1/box.mdl")
		self:SetSolid( SOLID_NONE )
		self:SetMoveType( MOVETYPE_NONE )
		self:SetUseType( ONOFF_USE ) 
		self.Bursts = 0
		self.CURRENTRANGE = 0
		self:GetVar("GBOWNER")
		self.SOUND = self:GetVar("SOUND")
		self.DEFAULT_PHYSFORCE  = self:GetVar("DEFAULT_PHYSFORCE")
		self.DEFAULT_PHYSFORCE_PLYAIR  = self:GetVar("DEFAULT_PHYSFORCE_PLYAIR")
		self.DEFAULT_PHYSFORCE_PLYGROUND = self:GetVar("DEFAULT_PHYSFORCE_PLYGROUND")
		self.SHOCKWAVEDAMAGE = self:GetVar("SHOCKWAVE_DAMAGE")
		self.allowtrace=true
	end
end
function ENT:Trace()
	if !self:IsValid() then return end
	if GetConVar("gred_sv_decals"):GetInt() == 0 then return end
	local pos = self:GetPos()
	local tracedata    = {}
	tracedata.start    = pos
	tracedata.endpos   = tracedata.start - Vector(0, 0, self.trace)
	tracedata.filter   = self.Entity
	local trace = util.TraceLine(tracedata)
	if self.decal==nil then 
		self.decal="scorch_medium"
	end
	
	util.Decal( self.decal, tracedata.start, tracedata.endpos )
end
function ENT:Think()		
    if (SERVER) then
    if !self:IsValid() then return end
	local pos = self:GetPos()
	self.CURRENTRANGE = self.CURRENTRANGE+(self.SHOCKWAVE_INCREMENT*4)
	if self.allowtrace then
		self:Trace()
		self.allowtrace=false
	end
	 for k, v in pairs(ents.FindInSphere(pos,self.CURRENTRANGE)) do
		 if (v:IsValid() or v:IsPlayer()) and (v.forcefielded==false or v.forcefielded==nil) then
			local i = 0
			 while i < v:GetPhysicsObjectCount() do
				 if self.GBOWNER == nil then
					self.GBOWNER = self
				 end
				 if !self.GBOWNER:IsValid() then
					self.GBOWNER = self
				 end
				self.Owner = self.GBOWNER
				local dmg = DamageInfo()
					dmg:SetDamage(1)
					dmg:SetDamageType(DMG_BLAST)
					dmg:SetAttacker(self.Owner)
					util.BlastDamage(self, self.Owner, pos, self.MAX_RANGE, self.SHOCKWAVEDAMAGE)
					local ent = ents.Create("env_physexplosion")
					ent:SetPos( pos ) 
					ent:Spawn()
					ent:SetKeyValue("magnitude", self.SHOCKWAVEDAMAGE)
					ent:SetKeyValue("radius", self.MAX_RANGE)
					ent:SetKeyValue("spawnflags","19")
					ent:Fire("Explode", 0, 0)
					ent:Remove()
					if (v:IsValid()) then
						phys = v:GetPhysicsObjectNum(i)
						if (v:GetPhysicsObject(i):IsValid()) then
							local mass = phys:GetMass()
							local F_ang = self.DEFAULT_PHYSFORCE
							local dist = (pos - v:GetPos()):Length()
					
							local relation = math.Clamp((self.CURRENTRANGE - dist) / self.CURRENTRANGE, 0, 1)
							if not self.DEFAULT_PHYSFORCE == nil then
								F_dir = (v:GetPos() - pos) * self.DEFAULT_PHYSFORCE
							else
								F_dir = (v:GetPos() - pos) * 1
							end
							phys:AddAngleVelocity(Vector(F_ang, F_ang, F_ang) * relation)
							phys:AddVelocity(F_dir)
							if(GetConVar("gred_sv_shockwave_unfreeze"):GetInt() >= 1) then
								if !v.isWacAircraft then
									phys:Wake()
									phys:EnableMotion(true)
									constraint.RemoveAll(v)
								end
							end
							if (v:GetClass()=="func_breakable" or class=="func_breakable_surf" or class=="func_physbox") then
								v:Fire("Break", 0)
							end
						end
						if (v:IsPlayer()) then
							
							 v:SetMoveType( MOVETYPE_WALK )
							 v:TakeDamageInfo(dmg)
							 local mass = phys:GetMass()
							 local F_ang = self.DEFAULT_PHYSFORCE_PLYAIR
							 local dist = (pos - v:GetPos()):Length()
							 local relation = math.Clamp((self.CURRENTRANGE - dist) / self.CURRENTRANGE, 0, 1)
							 if not self.DEFAULT_PHYSFORCE_PLYAIR == nil then
								F_dir = (v:GetPos() - pos) * self.DEFAULT_PHYSFORCE_PLYAIR
							 else
								F_dir = (v:GetPos() - pos) * 1
							 end
							 v:SetVelocity( F_dir )		
						 end

						 if (v:IsPlayer()) and v:IsOnGround() then
							 v:SetMoveType( MOVETYPE_WALK )
							 v:TakeDamageInfo(dmg)
							 local mass = phys:GetMass()
							 local F_ang = self.DEFAULT_PHYSFORCE_PLYGROUND
							 local dist = (pos - v:GetPos()):Length()
							 local relation = math.Clamp((self.CURRENTRANGE - dist) / self.CURRENTRANGE, 0, 1)
							 if not self.DEFAULT_PHYSFORCE_PLYGROUND == nil then
								F_dir = (v:GetPos() - pos) * self.DEFAULT_PHYSFORCE_PLYGROUND
							 else
								F_dir = (v:GetPos() - pos) * 1
							 end	 
							 v:SetVelocity( F_dir )		
						 end
						 if (v:IsNPC()) then
							 v:TakeDamageInfo(dmg)
						 end
					end
			 i = i + 1
			 end
		 end
 	 end
	 self.Bursts = self.Bursts + 1
	 if (self.CURRENTRANGE >= self.MAX_RANGE) then
	     self:Remove()
	 end
	 self:NextThink(CurTime() + (self.DELAY*10))
	 return true
	 end
end

function ENT:Draw()
     return false
end