ENT.Base 			= "wac_pod_base"
ENT.Type 			= "anim"
ENT.PrintName 		= ""
ENT.Author 			= "Gredwitch"
ENT.Category 		= "Gredwitch's Stuff"
ENT.Contact 		= ""
ENT.Purpose 		= ""
ENT.Instructions 	= "end my life"
ENT.Spawnable		= false
ENT.AdminSpawnable	= false
ENT.Name 			= "Red Gunner Pod"
ENT.Ammo 			= 750
ENT.FireRate 		= 730
ENT.Spray 			= 0.3
ENT.FireOffset 		= Vector(60, 0, 0)
ENT.TkAmmo 			= 1
ENT.TracerColor 	= "Red"
ENT.BulletType 		= "wac_base_12mm"

ENT.HasLastShot		= true
ENT.Sounds = {
	shoot1p = "WAC/cannon/viper_cannon_1p.wav",
	shoot3p = "WAC/cannon/viper_cannon_3p.wav",
	stop1p = "extras/null.wav",
	stop3p = "extras/null1.wav",
	spin = "WAC/cannon/viper_cannon_rotate.wav"
}
if SERVER then util.AddNetworkString("gred_net_wac_gunner_muzzle_fx")  end
function ENT:SetupDataTables()
	self:base("wac_pod_base").SetupDataTables(self)
	self:NetworkVar("Float", 2, "SpinSpeed");
	self:NetworkVar("Bool", 3, "IsShooting");
end



function ENT:drawCrosshair()
	surface.SetDrawColor(255,255,255,150)
	local center = {x=ScrW()/2, y=ScrH()/2}
	surface.DrawLine(center.x+5, center.y, center.x+30, center.y)
	surface.DrawLine(center.x-30, center.y, center.x-5, center.y)
	
	surface.DrawLine(center.x, center.y+5, center.x, center.y+30)
	surface.DrawLine(center.x, center.y-30, center.x, center.y-5)
	
	surface.SetDrawColor(80,80,80,255)
	
	surface.DrawLine(center.x+5, center.y+30, center.x-5, center.y+30)
	surface.DrawLine(center.x+5, center.y-30, center.x-5, center.y-30)
	
	surface.DrawLine(center.x+30, center.y+5, center.x+30, center.y-5)
	surface.DrawLine(center.x-30, center.y+5, center.x-30, center.y-5)
	
	-- surface.DrawOutlinedRect(center.x-10, center.y-10, 20, 20)
	-- surface.DrawOutlinedRect(center.x-11, center.y-11, 22, 22)
end