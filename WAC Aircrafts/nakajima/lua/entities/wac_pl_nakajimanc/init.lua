
include("shared.lua")
AddCSLuaFile("shared.lua")


function ENT:SpawnFunction(ply, tr)
	if (!tr.Hit) then return end
	local ent=ents.Create(ClassName)
	ent:SetPos(tr.HitPos+tr.HitNormal*10+Vector(0,0,80))
	ent:Spawn()
	ent:Activate()
	ent:SetSkin(math.random(0,3))
	ent.Owner=ply
	return ent
end

ENT.Aerodynamics = {
	Rotation = {
		Front = Vector(0, 0, 0),
		Right = Vector(0, 0, 40), -- Rotate towards flying direction
		Top = Vector(0, -40, 0)
	},
	Lift = {
		Front = Vector(0, 0, 15), -- Go up when flying forward
		Right = Vector(0, 0, 0),
		Top = Vector(0, 0, -0.5)
	},
	Rail = Vector(1, 5, 20),
	Drag = {
		Directional = Vector(0.01, 0.01, 0.01),
		Angular = Vector(0.01, 0.01, 0.01)
	}
}

function ENT:PhysicsUpdate(ph)
	self:base("wac_pl_base").PhysicsUpdate(self,ph)
	if self.rotorRpm > 0.8 and self.rotorRpm < 0.89 and IsValid(self.rotorModel) then
		self.rotorModel:SetBodygroup(0,1)
	elseif self.rotorRpm < 0.8 and IsValid(self.rotorModel) then
		self.rotorModel:SetBodygroup(0,0)
	end
end

function ENT:addRotors()
	self:base("wac_pl_base").addRotors(self)
	self.rotorModel.TouchFunc=nil
end