
include("shared.lua")

ENT.thirdPerson = {
	distance = 1200
}

function ENT:Think()
	self:base("wac_pl_base").Think(self)
	self:attachmentThink()
end