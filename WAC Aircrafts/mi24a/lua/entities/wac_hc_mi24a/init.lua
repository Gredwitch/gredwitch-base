
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
	self:SetBodygroup(6,0)
	local ammo = self.weapons["9M120"]:GetAmmo()
	if ammo == 4 then
		self:SetBodygroup(2,0)
		self:SetBodygroup(3,0)
		self:SetBodygroup(4,0)
		self:SetBodygroup(5,0)
	elseif ammo == 3 then 
		self:SetBodygroup(2,1)
		self:SetBodygroup(3,0)
		self:SetBodygroup(4,0)
		self:SetBodygroup(5,0)
	elseif ammo == 2 then 
		self:SetBodygroup(2,1)
		self:SetBodygroup(3,0)
		self:SetBodygroup(4,1)
		self:SetBodygroup(5,0)
	elseif ammo == 1 then 
		self:SetBodygroup(2,1)
		self:SetBodygroup(3,1)
		self:SetBodygroup(4,1)
		self:SetBodygroup(5,0)
	elseif ammo == 0 then 
		self:SetBodygroup(2,1)
		self:SetBodygroup(3,1)
		self:SetBodygroup(4,1)
		self:SetBodygroup(5,1)
	end
	self:SetBodygroup(0,0)
end