if not wac then return end
if SERVER then AddCSLuaFile() end
ENT.Base 				= "wac_pl_base"
ENT.Type 				= "anim"
ENT.Category			= "Gredwitch's Stuff"
ENT.PrintName			= "[WAC]Messerschmitt ME-109F4"
ENT.Author				= "Gredwitch"

ENT.Spawnable			= true
ENT.AdminSpawnable		= true
ENT.engineHealth = 150
ENT.Model	    = "models/gredwitch/me109f4/me109f4.mdl"
ENT.RotorPhModel	= "models/props_junk/sawblade001a.mdl"
ENT.RotorModel	= "models/gredwitch/me109f4/me109f4_prop.mdl"
ENT.rotorPos	= Vector(109.5,0,2.2)
ENT.TopRotorDir	= 1

ENT.EngineForce	= 6500
ENT.Weight	    = 3347
ENT.SeatSwitcherPos	= Vector(0,0,0)
ENT.AngBrakeMul		= 0.02
ENT.SmokePos	= ENT.rotorPos
ENT.FirePos	    = ENT.SmokePos

if CLIENT then
	ENT.thirdPerson = {
		distance = 550
	}
end

ENT.Agility = {
	Thrust = 25
}

ENT.Wheels={
	{
		mdl="models/gredwitch/me109f4/me109f4_wl.mdl",
		pos=Vector(39,-36,-64),
		friction=0,
		mass=550,
	},
	{
		mdl="models/gredwitch/me109f4/me109f4_wr.mdl",
		pos=Vector(39,36,-64),
		friction=0,
		mass=550,
	},
	{
		mdl="models/gredwitch/me109f4/me109f4_wb.mdl",
		pos=Vector(-202.6,0,-4),
		friction=0,
		mass=550,
	},
}

ENT.Seats = {
	{
		pos=Vector(-25,0,-3),
		exit=Vector(-60,-70,0),
		weapons={"MG 17", "MG 151"}
    }
}					

ENT.Weapons = {
	["MG 17"] = {
		class = "wac_pod_mg",
		info = {
			Pods = {
				Vector(67.6,6.6,20),
				Vector(67.6,-6.6,20),
			},
			Sounds = {
				shoot = "WAC/me109f4/shoot.wav",
				stop = "WAC/me109f4/stop.wav",
			},
			FireRate = 1000,
			BulletType = "wac_base_7mm",
			Ammo = 2000,
			Sequential = false,
		}
	},
	["MG 151"] = {
		class = "wac_pod_mg",
		info = {
			Pods = {
				Vector(133,0,2.2),
				
				Vector(68,88.7,-17),
				Vector(68,-88.7,-17),
			},
			Sounds = {
				shoot = "WAC/typhoon/typhoon_shoot.wav",
				stop = "WAC/typhoon/typhoon_stop.wav",
			},
			FireRate = 750,
			BulletType = "wac_base_20mm",
			Ammo = 450,
			Sequential = false,
		}
	}
}
	
ENT.Sounds={
	Start="WAC/me109f4/Start.wav",
	Blades="WAC/me109f4/external.wav",
	Engine="radio/german.wav",
	MissileAlert="",
	MissileShoot="",
	MinorAlarm="",
	LowHealth="",
	CrashAlarm=""
}
local function DrawLine(v1,v2)
	surface.DrawLine(v1.y,v1.z,v2.y,v2.z)
end

local mHorizon0 = Material("WeltEnSTurm/WAC/Helicopter/hud_line_0")
local HudCol = Color(70,199,50,150)
local Black = Color(0,0,0,200)

local mat = {
	Material("WeltEnSTurm/WAC/Helicopter/hud_line_0"),
	Material("WeltEnSTurm/WAC/Helicopter/hud_line_high"),
	Material("WeltEnSTurm/WAC/Helicopter/hud_line_low"),
}

local function getspaces(n)
	if n<10 then
		n="      "..n
	elseif n<100 then
		n="    "..n
	elseif n<1000 then
		n="  "..n
	end
	return n
end


function ENT:DrawPilotHud()
	local pos = self:GetPos()
	local ang = self:GetAngles()
	ang:RotateAroundAxis(self:GetRight(), 90)
	ang:RotateAroundAxis(self:GetForward(), 90)

	local uptm = self.SmoothVal
	local upm = self.SmoothUp
	local spos=self.Seats[1].pos

	cam.Start3D2D(self:LocalToWorld(Vector(17,3.75,37.75)+spos), ang,0.015)
	surface.SetDrawColor(HudCol)
	surface.DrawRect(234, 247, 10, 4)
	surface.DrawRect(254, 247, 10, 4)
	surface.DrawRect(247, 234, 4, 10)
	surface.DrawRect(247, 254, 4, 10)

	local a=self:GetAngles()
	a.y=0
	local up=a:Up()
	up.x=0
	up=up:GetNormal()

	local size=180
	local dist=10
	local step=12
	for p=-180,180,step do
		if a.p+p>-size/dist and a.p+p<size/dist then
			if p==0 then
				surface.SetMaterial(mat[1])
			elseif p>0 then
				surface.SetMaterial(mat[2])
			else
				surface.SetMaterial(mat[3])
			end
			surface.DrawTexturedRectRotated(250+up.y*(a.p+p)*dist,250-up.z*(a.p+p)*dist,300,300,a.r)
		end
	end

	surface.SetTextColor(HudCol)
	surface.SetFont("wac_heli_small")


	surface.SetTextPos(30, 510) 
	surface.DrawText("SPD  "..math.floor(self:GetVelocity():Length()*0.1) .."kn")
	surface.SetTextPos(30, 545)
	local tr=util.QuickTrace(pos+self:GetUp()*10,Vector(0,0,-999999),self.Entity)
	surface.DrawText("ALT  "..math.ceil((pos.z-tr.HitPos.z)*0.01905).."m")

	if self:GetNWInt("seat_1_actwep") == 1 and self.weapons["MG 17"] then
		surface.SetTextPos(330,510)
		local n = self.weapons["MG 17"]:GetAmmo()
		surface.DrawText("MG 17	    " .. getspaces(n))
	end
	
	if self:GetNWInt("seat_1_actwep") == 2 and self.weapons["MG 151"] then
		surface.SetTextPos(330,510)
		local n = self.weapons["MG 151"]:GetAmmo()
		surface.DrawText("MG 151	" .. getspaces(n))
	end
	
	if self:GetNWInt("seat_1_actwep") == 3 and self.weapons["100Kg bomb"] then
		surface.SetTextPos(330,510)
		local n = self.weapons["100Kg bomb"]:GetAmmo()
		surface.DrawText("100Kg bomb" .. getspaces(n))
	end
	
	cam.End3D2D()
end
function ENT.DrawWeaponSelection() end