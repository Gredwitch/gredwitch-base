if not wac then return end
if SERVER then AddCSLuaFile('shared.lua') end
ENT.Base 				= "wac_pl_base"
ENT.Type 				= "anim"
ENT.Category			= "Gredwitch's Stuff"
ENT.PrintName			= "[WAC]Hawker Typhoon Mk1B"
ENT.Author				= "Gredwitch"

ENT.Spawnable			= true
ENT.AdminSpawnable		= false
ENT.Model	    = "models/gredwitch/typhoon/typhoon.mdl"
ENT.RotorPhModel	= "models/props_junk/sawblade001a.mdl"
ENT.RotorModel	= "models/gredwitch/typhoon/typhoon_prop.mdl"

ENT.rotorPos	= Vector(112,0,-35)
ENT.TopRotorDir	= 1
ENT.EngineForce	= 13000
ENT.Weight	    = 6000
ENT.SeatSwitcherPos	= Vector(0,0,0)
ENT.AngBrakeMul	= 0.01
ENT.SmokePos	= ENT.rotorPos
ENT.FirePos	    = ENT.rotorPos

if CLIENT then
	ENT.thirdPerson = {
		distance = 550
	}
end

ENT.Agility = {
	Thrust = 23
}

ENT.Wheels={
	{
		mdl="models/gredwitch/p47d/p47d_wb.mdl",
		pos=Vector(-203,0,-65),
		friction=0,
		mass=550,
	},
	{
		mdl="models/gredwitch/typhoon/typhoon_wr.mdl",
		pos=Vector(40,100,-110),
		friction=0,
		mass=550,
	},
	{
		mdl="models/gredwitch/typhoon/typhoon_wl.mdl",
		pos=Vector(40,-100,-110),
		friction=0,
		mass=550,
	},
}

ENT.Seats = {
	{
		pos=Vector(-20,0,-41),
		exit=Vector(10,60,85),
		weapons={"Hispano-Suiza HS-404", "RP3 Rockets"}
    }
}							

ENT.Weapons = {
	["Hispano-Suiza HS-404"] = {
		class = "wac_pod_mg",
		info = {
			Pods = {
				Vector(105,103,-60),
				Vector(105,135,-57),
				Vector(105,-103,-60),
				Vector(105,-135,-57),
			},
			FireRate = 600,
			BulletType = "wac_base_20mm",
		    Ammo = 560,
			Sounds = {
				shoot = "WAC/p47/gun.wav",
				stop = "WAC/p47/gun_stop.wav",
			}
		}
	},
	["RP3 Rockets"] = {
	    class = "wac_pod_grocket",
		info = {
			Pods = {
				Vector(400,154,-67.5),
				Vector(400,-154,-67.5),

			},
			Sequential = false,
		    FireRate = 90,
		    Ammo = 8,
			Kind = "gb_rocket_rp3"
		}
	}
}


ENT.Sounds={
	Start="WAC/P51/Start.wav",
	Blades="WAC/P51/external.wav",
	Engine="radio/american.wav",
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

	cam.Start3D2D(self:LocalToWorld(Vector(21,3.75,37.75)+spos), ang,0.015)
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

	if self:GetNWInt("seat_1_actwep") == 1 and self.weapons["Hispano-Suiza HS-404"] then
		surface.SetTextPos(330,510)
		local n = self.weapons["Hispano-Suiza HS-404"]:GetAmmo()
		surface.DrawText("Hispano-Suiza HS-404" .. getspaces(n))
	end
	
	if self:GetNWInt("seat_1_actwep") == 2 and self.weapons["RP3 Rockets"] then
		surface.SetTextPos(330,510)
		local n = self.weapons["RP3 Rockets"]:GetAmmo()
		surface.DrawText("RP3 Rockets	" .. getspaces(n))
	end
	
	if self:GetNWInt("seat_1_actwep") == 3 and self.weapons["250lb bombs"] then
		surface.SetTextPos(330,510)
		local n = self.weapons["250lb bombs"]:GetAmmo()
		surface.DrawText("250lb bombs	" .. getspaces(n))
	end
	
	cam.End3D2D()
end
function ENT.DrawWeaponSelection() end