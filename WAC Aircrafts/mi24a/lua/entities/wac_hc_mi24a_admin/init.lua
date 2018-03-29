
include("shared.lua")
AddCSLuaFile("shared.lua")


function ENT:SpawnFunction(p, tr)
	if (!tr.Hit) then return end
	local e = ents.Create(ClassName)
	e:SetPos(tr.HitPos + tr.HitNormal*15)
	e.Owner = p
	e:Spawn()
	e:Activate()
	e:SetSkin(math.random(0,1))
	return e
end

function ENT:Think()
	self:base("wac_hc_base").Think(self)
	self:SetBodygroup(0,0)
end