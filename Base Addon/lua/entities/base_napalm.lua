AddCSLuaFile()

DEFINE_BASECLASS( "base_fire" )


ENT.Spawnable		            	 =  false
ENT.AdminSpawnable		             =  false     

ENT.PrintName		                 =  "Napalm fire"        
ENT.Author			                 =  ""      
ENT.Contact			                 =  ""      

ENT.GBOWNER                          =  nil            
ENT.DAMAGE_MUL						 = 1
ENT.Radius							 = 1400
ENT.Lifetime						 = 44
ENT.Damage							 = 1,4
ENT.Rate							 = 0.5

function ENT:Initialize()
	if (SERVER) then
		self:SetModel("models/mm1/box.mdl")
		self:SetSolid( SOLID_NONE )
		self:SetMoveType( MOVETYPE_NONE )
		self:SetUseType( ONOFF_USE ) 
		self.Bursts = 0
		self.GBOWNER = self:GetVar("GBOWNER")
	end
end


function ENT:Think()
    if (SERVER) then
		if !self:IsValid() then return end
		
		for k, v in pairs(ents.FindInSphere(self:GetPos(),self.Radius)) do
			if !v:IsOnFire() then
				if v:IsPlayer() or v:IsNPC() then
					if v:GetClass()=="npc_helicopter" then return end
					v:Ignite(10,10)
				else
					local phys = self:GetPhysicsObject()
					if phys:IsValid() then
						v:Ignite(10,10)
					end
				end
			end
		end
		self.Bursts = self.Bursts + 1
		if (self.Bursts >= self.Lifetime) then
			self:Remove()
		end
		self:NextThink(CurTime() + self.Rate)
		return true
	end
end