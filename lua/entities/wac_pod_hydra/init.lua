AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:SetupDataTables()
	self:base("wac_pod_base").SetupDataTables(self)
	self:NetworkVar( "Int", 0, "TkAmmo" );
end