if not wac then return end
if SERVER then AddCSLuaFile('shared.lua') end
ENT.Base 				= "wac_pl_base"
ENT.Type 				= "anim"
ENT.Category			= "Gredwitch's Stuff"
ENT.PrintName			= "[WAC]Republic P-47D Thunderbolt"
ENT.Author				= "Gredwitch"

ENT.Spawnable			= true
ENT.AdminSpawnable		= false
ENT.Model	    = "models/gredwitch/p47d20/p47d.mdl"
ENT.RotorPhModel	= "models/props_junk/sawblade001a.mdl"
ENT.RotorModel	= "models/gredwitch/p47d20/p47d_prop.mdl"

ENT.rotorPos	= Vector(225.348,0,80.8842)
ENT.TopRotorDir	= 1
ENT.EngineForce	= 13000
ENT.Weight	    = 6000
ENT.SeatSwitcherPos	= Vector(0,0,0)
ENT.AngBrakeMul	= 0.01
ENT.SmokePos	= ENT.rotorPos
ENT.FirePos	    = ENT.rotorPos

if CLIENT then
	ENT.thirdPerson = {
		distance = 600
	}
end

ENT.Agility = {
	Thrust = 25
}

ENT.Wheels={
	{
		mdl="models/gredwitch/p47d20/p47d_wb.mdl",
		pos=Vector(-162.09,0,52.4346),
		friction=0,
		mass=550,
	},
	{
		mdl="models/gredwitch/p47d20/p47d_wl.mdl",
		pos=Vector(115.108,109.147,5.00478),
		friction=0,
		mass=550,
	},
	{
		mdl="models/gredwitch/p47d20/p47d_wr.mdl",
		pos=Vector(115.076,-108.971,4.99831),
		friction=0,
		mass=550,
	},
}

ENT.Seats = {
	{
		pos=Vector(35,0,90),
		exit=Vector(10,60,85),
		weapons={"Browning M2", "HVAR", "500LB bomb", "1000LB bombs"}
    }
}							

ENT.Weapons = {
	["Browning M2"] = {
		class = "wac_pod_mg",
		info = {
			Pods = {
				Vector(141.328,121.858,68.376),
				Vector(141.328,-121.858,68.376),
				
				Vector(135.872,128.775,68.376),
				Vector(135.872,-128.775,68.376),
				
				Vector(128.7,135.278,68.376),
				Vector(128.7,-135.278,68.376),
				
				Vector(122.76,142.441,68.376),
				Vector(122.76,-142.441,68.376),
			},
			FireRate = 6800,
			Sequential = true,
		    Ammo = 3400,
			Sounds = {
				shoot = "WAC/p47/gun.wav",
				stop = "WAC/p47/gun_stop.wav",
			}
		}
	},
	["HVAR"] = {
	    class = "wac_pod_grocket",
		info = {
			Pods = {
				Vector(122.76,180,40),
				Vector(122.76,-180,40),

			},
			Sequential = false,
		    FireRate = 90,
		    Ammo = 10,
			Kind = "gb_rocket_hvar"
		}
	},
	["500LB bomb"] = {
	    class = "wac_pod_gbomb",
		info = {
			Pods = {
				Vector(102.77,0,24.5)

			},
			Kind = "gb_bomb_500gp"
		}
	},
	["1000LB bombs"] = {
	    class = "wac_pod_gbomb",
		info = {
			Pods = {
				Vector(85,147.664,43),
				Vector(85,-147.664,43),

			},
			Sequential = true,
			Kind = "gb_bomb_1000gp"
		}
	}
}

ENT.Sounds={
	Start="WAC/p47/P47D_start_idle_stop.wav",
	Blades="WAC/p47/P47D_rpm2.wav",
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

	if self:GetNWInt("seat_1_actwep") == 1 and self.weapons["Browning M2"] then
		surface.SetTextPos(330,510)
		local n = self.weapons["Browning M2"]:GetAmmo()
		surface.DrawText("Browning M2	" .. getspaces(n))
	end
	
	if self:GetNWInt("seat_1_actwep") == 2 and self.weapons["HVAR"] then
		surface.SetTextPos(330,510)
		local n = self.weapons["HVAR"]:GetAmmo()
		surface.DrawText("HVAR	        " .. getspaces(n))
	end
	
	if self:GetNWInt("seat_1_actwep") == 3 and self.weapons["500LB bomb"] then
		surface.SetTextPos(330,510)
		local n = self.weapons["500LB bomb"]:GetAmmo()
		surface.DrawText("500LB bomb   " .. getspaces(n))
	end
	
	if self:GetNWInt("seat_1_actwep") == 4 and self.weapons["1000LB bombs"] then
		surface.SetTextPos(330,510)
		local n = self.weapons["1000LB bombs"]:GetAmmo()
		surface.DrawText("1000LB bombs" .. getspaces(n))
	end
	
	cam.End3D2D()
end
function ENT.DrawWeaponSelection() end