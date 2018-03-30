ENT.Base = "wac_pod_base"
ENT.Type = "anim"
ENT.PrintName = ""
ENT.Author = wac.author
ENT.Category = wac.aircraft.spawnCategory
ENT.Contact = ""
ENT.Purpose = ""
ENT.Instructions = ""
ENT.Spawnable = false
ENT.AdminSpawnable = false
ENT.Name = "Grediwtch's Turret Pod"
ENT.Ammo = 750
ENT.FireRate = 730
ENT.Spray = 0.3
ENT.FireOffset = Vector(60, 0, 0)
ENT.TkAmmo = 1
ENT.TracerColor = "Red"
ENT.BulletType = "wac_base_12mm"
ENT.Sounds = {
	shoot1p = "WAC/cannon/viper_cannon_1p.wav",
	shoot3p = "WAC/cannon/viper_cannon_3p.wav",
	spin = "WAC/cannon/viper_cannon_rotate.wav"
}

function ENT:SetupDataTables()
	self:base("wac_pod_base").SetupDataTables(self)
	self:NetworkVar("Float", 2, "SpinSpeed");
	self:NetworkVar( "String", 0, "TracerColor" );
	self:NetworkVar( "String", 0, "BulletType" );
	self:NetworkVar( "Int", 0, "TkAmmo" );
end



function ENT:drawCrosshair()
	surface.SetDrawColor(255,255,255,150)
	local center = {x=ScrW()/2, y=ScrH()/2}
	surface.DrawLine(center.x+10, center.y, center.x+30, center.y)
	surface.DrawLine(center.x-30, center.y, center.x-10, center.y)
	surface.DrawLine(center.x, center.y+10, center.x, center.y+30)
	surface.DrawLine(center.x, center.y-30, center.x, center.y-10)
	surface.DrawOutlinedRect(center.x-10, center.y-10, 20, 20)
	surface.DrawOutlinedRect(center.x-11, center.y-11, 22, 22)
end