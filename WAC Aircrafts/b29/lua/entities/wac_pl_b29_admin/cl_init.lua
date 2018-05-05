
include("shared.lua")

function ENT:Think()
	self:base("wac_pl_base").Think(self)
	self:attachmentThink()
end