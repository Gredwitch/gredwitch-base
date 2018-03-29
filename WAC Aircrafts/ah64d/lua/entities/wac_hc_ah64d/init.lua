
include("shared.lua")
AddCSLuaFile("shared.lua")

function ENT:SpawnFunction(p, tr)
	if (!tr.Hit) then return end
	local e = ents.Create(ClassName)
	e:SetPos(tr.HitPos+Vector(0,0,80))
	e.Owner = p
	e:Spawn()
	e:Activate()
	e:SetSkin(math.random(0,2))

	return e
end

function ENT:PhysicsUpdate(ph)
	self:base("wac_hc_base").PhysicsUpdate(self,ph)

	if self.rotorRpm > 0.8 and self.rotorRpm < 0.89 and IsValid(self.rotorModel) then
		self.rotorModel:SetBodygroup(0,1)
	elseif self.rotorRpm > 0.9 and IsValid(self.rotorModel) then
		self.rotorModel:SetBodygroup(0,2)
	elseif self.rotorRpm < 0.8 and IsValid(self.rotorModel) then
		self.rotorModel:SetBodygroup(1,0)
	end
	
	if self.active then
		self:SetBodygroup(5,2)
	else
		self:SetBodygroup(5,0)
	end
	
end