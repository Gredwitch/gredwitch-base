ENT.Base = "wac_pod_base"
ENT.Type = "anim"
ENT.PrintName = "Bomb Pod"
ENT.Author = "Grredwitch"
ENT.Category = "Grredwitch's Stuff"
ENT.Spawnable = false
ENT.AdminSpawnable = false
ENT.FireRate = 999999999
ENT.Sequential = true
ENT.mass = 250
ENT.model = ""
ENT.reload = 10
// false to land and timer, true for midflight timer
ENT.mode = false
ENT.Kind = ""
ENT.mass = 250
ENT.Admin = 0
ENT.Rocket = 0
ENT.Sounds = {
	fire = "wac/stuka/dropbomb.wav"
}

function ENT:SetupDataTables()
    self:base("wac_pod_base").SetupDataTables(self)
	self:NetworkVar( "Entity", 0, "Kind" );
	self:NetworkVar( "Int", 0, "Admin" );
	self:NetworkVar( "Int", 0, "Rocket" );
end

function ENT:drawCrosshair()
	surface.SetDrawColor(255,255,255,150)
	local center = {x=ScrW()/2, y=ScrH()/2}
	surface.DrawLine(center.x+20, center.y, center.x+40, center.y)
	surface.DrawLine(center.x-40, center.y, center.x-20, center.y)
	surface.DrawLine(center.x, center.y+20, center.x, center.y+40)
	surface.DrawLine(center.x, center.y-40, center.x, center.y-20)
	surface.DrawOutlinedRect(center.x-20, center.y-20, 40, 40)
	surface.DrawOutlinedRect(center.x-21, center.y-21, 42, 42)
end