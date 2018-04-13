if not wac then return end
if SERVER then AddCSLuaFile('shared.lua') end
ENT.Base 				= "wac_pl_base"
ENT.Type 				= "anim"
ENT.Category			= "Gredwitch's Stuff"
ENT.PrintName			= "[WAC]Hawker Hurricane MkI (Admin)"
ENT.Author				= "Gredwitch"

ENT.Spawnable			= true
ENT.AdminSpawnable		= true

ENT.Model	    = "models/gredwitch/hurricane/hurricane.mdl"
ENT.RotorPhModel	= "models/props_junk/sawblade001a.mdl"
ENT.RotorModel	= "models/gredwitch/hurricane/hurricane_prop.mdl"

ENT.rotorPos	= Vector(115,0,5)
ENT.TopRotorDir	= 1

ENT.EngineForce	= 335
ENT.Weight	    = 3347
ENT.SeatSwitcherPos	= Vector(0,0,0)
ENT.AngBrakeMul	= 0.01
ENT.SmokePos	= ENT.rotorPos
ENT.FirePos	    = ENT.rotorPos
ENT.thirdPerson = {
	distance = 600
}

ENT.Agility = {
	Thrust = 24
}

ENT.Wheels={
	{
		mdl="models/gredwitch/hurricane/hurricane_wr.mdl",
		pos=Vector(33.2599,-46.8386,-72.8353),
		friction=10,
		mass=550,
	},
	{
		mdl="models/gredwitch/hurricane/hurricane_wl.mdl",
		pos=Vector(33.2599,46.8786,-72.8353),
		friction=10,
		mass=550,
	},
	{
		mdl="models/gredwitch/hurricane/hurricane_wb.mdl",
		pos=Vector(-200.971,0,-31.863),
		friction=100,
		mass=500,
	},
}

ENT.Seats = {
	{
		pos=Vector(-14,0,-1.5),
		exit=Vector(10,60,85),
		weapons={"Browning M1919", "RP-3", "250LB bombs"}
    }
}							

ENT.Weapons = {
	["Browning M1919"] = {
		class = "wac_pod_mg",
		info = {
			Pods = {
				Vector(42,90,-17),
				Vector(42,85,-17),
				Vector(42,80,-17),
				Vector(42,75,-17),
				
				Vector(42,-90,-17),
				Vector(42,-85,-17),
				Vector(42,-80,-17),
				Vector(42,-75,-17),
			},
			FireRate = 8000,
			BulletType = "wac_base_7mm",
			Ammo = 1,
			TkAmmo = 0,
			Sequential = true,
			Sounds = {
				shoot = "WAC/P51/gun.wav",
				stop = "WAC/P51/gun_stop.wav"
			}
		}
	},
	["250LB bombs"] = {
		class = "wac_pod_gbomb",
		info = {
			Pods = {
				Vector(-30,-20,-35),
				Vector(-30,20,-35),
			},
			Sequential = true,
			Admin = 1,
			Kind = "gb_bomb_250gp"
		}
	},
	["RP-3"] = {
		class = "wac_pod_grocket",
		info = {
			Pods = {
				Vector(8,92,-26),
				Vector(8,-92,-26),
			},
			Sequential = false,
			Kind = "gb_rocket_rp3",
			FireRate = 100,
			Ammo = 1,
			TkAmmo = 0,
		}
	},
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

	if self:GetNWInt("seat_1_actwep") == 1 and self.weapons["Browning M1919"] then
		surface.SetTextPos(330,510)
		local n = self.weapons["Browning M1919"]:GetAmmo()
		surface.DrawText("Browning M1919	" .. getspaces(n))
	end
	
	if self:GetNWInt("seat_1_actwep") == 2 and self.weapons["RP-3"] then
		surface.SetTextPos(330,510)
		local n = self.weapons["RP-3"]:GetAmmo()
		surface.DrawText("RP-3     	    	" .. getspaces(n))
	end
	
	if self:GetNWInt("seat_1_actwep") == 3 and self.weapons["250LB bombs"] then
		surface.SetTextPos(330,510)
		local n = self.weapons["250LB bombs"]:GetAmmo()
		surface.DrawText("250LB bombs	    " .. getspaces(n))
	end
	
	cam.End3D2D()
end
function ENT:DrawWeaponSelection() end