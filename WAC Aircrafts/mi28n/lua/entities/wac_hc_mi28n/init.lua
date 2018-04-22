
include("shared.lua")
AddCSLuaFile("shared.lua")

function ENT:SpawnFunction(p, tr)
	if (!tr.Hit) then return end
	local e = ents.Create(ClassName)
	e:SetPos(tr.HitPos+Vector(0,0,10))
	e.Owner = p
	e:Spawn()
	e:SetBodygroup(1,math.random(0,1))
	e:SetSkin(math.random(0,4))
	e:Activate()
	return e
end

function ENT:Think()
	self:base("wac_hc_base").Think(self)
	
	if !IsValid(self.topRotor) then
		self:SetBodygroup(4,1)
	else
		self:SetBodygroup(4,0)
	end
	local ammo = self.weapons["PTUR"]:GetAmmo()
	if ammo > 6 then 
		self:SetBodygroup(2,0)
		self:SetBodygroup(3,0)
	elseif ammo <= 6 and ammo > 0 then
		self:SetBodygroup(2,1)
		self:SetBodygroup(3,0)
	elseif ammo <= 0 then
		self:SetBodygroup(3,1)
		self:SetBodygroup(2,1)
	end
end