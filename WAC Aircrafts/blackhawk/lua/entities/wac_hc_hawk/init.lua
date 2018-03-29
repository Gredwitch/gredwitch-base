include("shared.lua")
AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

ENT.EngineForce	= 53
ENT.Weight		= 9980

function ENT:SpawnFunction(ply, tr)
	if (!tr.Hit) then return end
	local ent=ents.Create(ClassName)
	ent:SetPos(tr.HitPos+tr.HitNormal*2)
	ent:SetSkin(math.random(0,10))
	ent.Owner=ply
	ent:Spawn()
	ent:Activate()
	return ent
end
