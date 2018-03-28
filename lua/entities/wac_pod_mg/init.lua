AddCSLuaFile("shared.lua")
include("shared.lua")
function ENT:SetupDataTables()
	self:base("wac_pod_base").SetupDataTables(self)
	self:NetworkVar( "Int", 0, "TkAmmo" );
	self:NetworkVar( "String", 0, "TracerColor" );
	self:NetworkVar( "String", 0, "BulletType" );
	self:NetworkVar( "Int", 0, "Brrt" );
	self:NetworkVar( "Angle", 0, "ShootAng" );
end