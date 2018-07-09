if not wac then return end
ENT.Base = "wac_pod_base"
ENT.Type = "anim"
ENT.PrintName = "Bomb Pod"
ENT.Author = "Grredwitch"
ENT.Category = "Grredwitch's Stuff"
ENT.Spawnable = false
ENT.AdminSpawnable = false
ENT.FireRate = 50
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
	self:NetworkVar("Entity", 0, "Target")
	self:NetworkVar("Vector", 0, "TargetOffset")
	self:NetworkVar( "Entity", 0, "Kind" );
	self:NetworkVar( "Int", 0, "Admin" );
	self:NetworkVar( "Int", 0, "Rocket" );
end

function ENT:drawCrosshair()
	surface.SetDrawColor(255,255,255,150)
	local center = {x=ScrW()/2, y=ScrH()/2}
	if IsValid(self:GetTarget()) then
		local pos = self:GetTarget():LocalToWorld(self:GetTargetOffset()):ToScreen()
		pos = {
			x = math.Clamp(pos.x-center.x+math.Rand(-1,1), -20, 20)+center.x,
			y = math.Clamp(pos.y-center.y+math.Rand(-1,1), -20, 20)+center.y
		}
		surface.DrawLine(center.x-20, pos.y, center.x+20, pos.y)
		surface.DrawLine(pos.x, center.y-20, pos.x, center.y+20)
	else
		surface.DrawLine(center.x+20, center.y, center.x+40, center.y)
		surface.DrawLine(center.x-40, center.y, center.x-20, center.y)
		surface.DrawLine(center.x, center.y+20, center.x, center.y+40)
		surface.DrawLine(center.x, center.y-40, center.x, center.y-20)
	end
	surface.DrawOutlinedRect(center.x-20, center.y-20, 40, 40)
	surface.DrawOutlinedRect(center.x-21, center.y-21, 42, 42)
	draw.Text({
		text = (
			self:GetNextShot() <= CurTime() and self:GetAmmo() > 0
			and (IsValid(self:GetTarget()) and "LOCK" or "READY")
			or "BMB NOT READY"
				
		),
		font = "HudHintTextLarge",
		pos = {center.x, center.y+45},
		color = Color(255, 255, 255, 150),
		xalign = TEXT_ALIGN_CENTER
	})
end