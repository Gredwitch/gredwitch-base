
include("shared.lua")
AddCSLuaFile("shared.lua")
function ENT:PhysicsUpdate(ph)
	self:base("wac_hc_base").PhysicsUpdate(self,ph)
	
	if self.EngineHealth <= 0 then self.TopRotorModel:SetBodygroup(1,2) end
	if self.rotorRpm > 0.6 and self.rotorRpm < 0.79 and IsValid(self.BackRotor) then
		self.BackRotor:SetBodygroup(1,1)
	elseif self.rotorRpm > 0.8 and IsValid(self.BackRotor) then
		self.BackRotor:SetBodygroup(1,2)
	elseif self.rotorRpm < 0.4 and IsValid(self.BackRotor) then
		self.BackRotor:SetBodygroup(1,0)
	end
end

function ENT:SpawnFunction(ply, tr)
	if (!tr.Hit) then return end
	local ent=ents.Create(ClassName)
	ent:SetPos(tr.HitPos+tr.HitNormal*10)
	ent:Spawn()
	ent:Activate()
	ent:SetSkin(math.random(0,4))
	ent.Owner=ply
	return ent
end


