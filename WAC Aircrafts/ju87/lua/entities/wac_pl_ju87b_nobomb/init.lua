
include("shared.lua")
AddCSLuaFile("shared.lua")


function ENT:SpawnFunction(ply, tr)
	if (!tr.Hit) then return end
	local ent=ents.Create(ClassName)
	ent:SetPos(tr.HitPos+tr.HitNormal*10)
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
}--[[
function ENT:Think()
	self:base("wac_pl_base").Think(self)
	local phys=self:GetPhysicsObject()
	local siren = CreateSound(self, "wac/stuka/stukadive.wav")
	siren:SetSoundLevel(160)
	ang = phys:GetAngles().p
	sirPitch =  phys:GetVelocity().x
	if IsValid(phys) and not self.disabled then
		if self.controls.throttle>0 and phys:GetVelocity():Length() > 1000 and ang > 45 then--and !siren:IsPlaying() then
			siren:Play()
		elseif ang < 90 then
			siren:Stop()
		end
	end
	if self.engineHealth <= 0 then siren:Stop() end
end--]]
function ENT:addRotors()
	self:base("wac_pl_base").addRotors(self)
	self.rotorModel.TouchFunc=nil
end