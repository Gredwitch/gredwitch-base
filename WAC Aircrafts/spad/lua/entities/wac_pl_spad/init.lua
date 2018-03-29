include("shared.lua")
AddCSLuaFile("shared.lua")

function ENT:SpawnFunction(ply, tr)
	if (!tr.Hit) then return end
	local ent=ents.Create(ClassName)
	ent:SetPos(tr.HitPos+tr.HitNormal*16+Vector(0,0,100))
	ent:Spawn()
	ent:Activate()
	ent.Owner=ply
	return ent
end

ENT.AutomaticFrameAdvance = true // needed for gear anims

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

	if self.rotorRpm > 0.2 and self.rotorRpm < 0.89 and IsValid(self.rotorModel) then
		self.rotorModel:SetBodygroup(0,1)
	elseif self.rotorRpm > 0.3 and IsValid(self.rotorModel) then
		self.rotorModel:SetBodygroup(0,2)
	elseif self.rotorRpm > 0.5 and IsValid(self.rotorModel) then
		self.rotorModel:SetBodygroup(0,3)
	elseif self.rotorRpm > 0.7 and IsValid(self.rotorModel) then
		self.rotorModel:SetBodygroup(0,4)
	elseif self.rotorRpm < 0 and IsValid(self.rotorModel) then
		self.rotorModel:SetBodygroup(0,0)
	end
end

function ENT:addRotors()
	self:base("wac_pl_base").addRotors(self)
	self.rotorModel.TouchFunc=nil
	self.rotorModel:SetSolid(SOLID_NONE)
end