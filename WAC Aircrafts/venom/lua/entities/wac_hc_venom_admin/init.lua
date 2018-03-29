include("shared.lua")
AddCSLuaFile("shared.lua")

ENT.EngineForce	= 38
ENT.Weight		= 8000

function ENT:SpawnFunction(ply, tr)
	if (!tr.Hit) then return end
	local ent=ents.Create(ClassName)
	ent:SetPos(tr.HitPos+tr.HitNormal*2)
	ent.Owner=ply
	ent:Spawn()
	ent:Activate()
	return ent
end
