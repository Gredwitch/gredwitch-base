include("shared.lua")

function ENT:Think()
	if self:GetNWBool("Fired",false) then
		self:SetAngles(self:GetVelocity():Angle())
	end
end