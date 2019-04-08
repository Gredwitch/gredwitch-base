include('shared.lua')
local zero = 0
local threeZ = zero,zero,zero
local audioSpecs = 100, 100,1, CHAN_AUTO
local null = ""

function ENT:Draw()
	self:DrawModel()
end

