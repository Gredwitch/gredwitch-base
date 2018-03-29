
ENT.Base = "wac_hc_base"
ENT.Type = "anim"
ENT.Author = "Gredwitch"
ENT.Category = "Gredwitch's Stuff"
ENT.Spawnable = true
ENT.AdminSpawnable = true

ENT.PrintName		= "[WAC]Viper AH-1Z (Admin)"

ENT.TopRotor = {
	dir = -1,
	pos = Vector(0,0,120),
	model = "models/bf2/helicopters/ah-1 cobra/ah1z_r.mdl",
}

ENT.BackRotor = {
	dir = -1,
	pos = Vector(-362.61,22.06,107.22),
	model = "models/bf2/helicopters/ah-1 cobra/ah1z_tr.mdl"
}

ENT.Model			= "models/bf2/helicopters/ah-1 cobra/ah1z_b.mdl"
ENT.RotorPhModel	= "models/props_junk/sawblade001a.mdl"

ENT.SmokePos		= Vector(-116.21,0,79.51)
ENT.FirePos			= Vector(-89.17,0,92.37)

ENT.Seats = {
	{
		pos = Vector(70, 0, 48),
		exit = Vector(72,70,0),
		weapons = {"Hydra 70", "M197", "Hellfire", "AIM-9"}
	},
	{
		pos = Vector(120, 0, 42),
		exit = Vector(120,70,0),
		weapons = {"M197", "Hellfire", "AIM-9"}
	},
}


ENT.Weapons = {
	["Hydra 70"] = {
		class = "wac_pod_grocket",
		info = {
			Sequential = true,
			Firerate = 220,
			TkAmmo = 0,
			Ammo = 1,
			Pods = {
				Vector(40.25, 36.33, 32.93),
				Vector(40.25, -36.33, 32.93)
			}
		}
	},
	["Hellfire"] = {
		class = "wac_pod_hellfire",
		info = {
			Pods = {
				Vector(10, 70, 20),
				Vector(10, -70, 20),
				Vector(10, 70, 35),
				Vector(10, -70, 35),
				Vector(10, 50, 35),
				Vector(10, -50, 35),
				Vector(10, 50, 20),
				Vector(10, -50, 20),
			},
			Ammo = 1,
			TkAmmo = 0,
		}
	},
	["AIM-9"] = {
		class = "wac_pod_mis",
		info = {
			Pods = {
				Vector(50, 60, 40),
				Vector(50, -60, 40),
			},
			Ammo = 1,
			TkAmmo = 0,
			model = "models/hawx/aim-9 sidewinder.mdl",
		}
	},
	["M197"] = {
		class = "wac_pod_gunner",
		info = {
			ShootPos = Vector(137, 0, 23),
			ShootOffset = Vector(60, 0, 0),
			TkAmmo = 0,
			Ammo = 1,
			BulletType = "wac_base_20mm",
		}
	}
}


ENT.Camera = {
	model = "models/bf2/helicopters/ah-1 cobra/ah1z_radar1.mdl",
	pos = Vector(175,0,42),
	offset = Vector(-1,0,0),
	viewPos = Vector(2, 0, 3.5),
	maxAng = Angle(45, 90, 0),
	minAng = Angle(-2, -90, 0),
	seat = 2
}


ENT.WeaponAttachments = {

	gunMount1 = {
		model = "models/bf2/helicopters/ah-1 cobra/ah1z_g1.mdl",
		pos = Vector(137,0,29),
		restrictPitch = true
	},
	
	gunMount2 = {
		model = "models/bf2/helicopters/ah-1 cobra/ah1z_g2.mdl",
		pos = Vector(137,0,23),
		offset = Vector(2,0,0)
	},

	gun = {
		model = "models/bf2/helicopters/ah-1 cobra/ah1z_g.mdl",
		pos = Vector(137, 0, 23),
		offset = Vector(2,0,0)
	},
	
	radar1 = {
		model = "models/bf2/helicopters/ah-1 cobra/ah1z_radar2.mdl",
		pos = Vector(175,0,52),
		restrictPitch = true
	},

}


ENT.Sounds = {
	Start = "wac/Heli/ah1_start.wav",
	Blades = "npc/attack_helicopter/aheli_rotor_loop1.wav",
	Engine = "wac/heli/bellinternal.wav",
	MissileAlert = "HelicopterVehicle/MissileNearby.mp3",
	MissileShoot = "HelicopterVehicle/MissileShoot.mp3",
	MinorAlarm = "HelicopterVehicle/MinorAlarm.mp3",
	LowHealth = "HelicopterVehicle/LowHealth.mp3",
	CrashAlarm = "HelicopterVehicle/CrashAlarm.mp3",
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

	cam.Start3D2D(self:LocalToWorld(Vector(30,3.75,37.75)+spos), ang,0.015)
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

	surface.SetTextPos(30, 410) 
	surface.DrawText("SPD  "..math.floor(self:GetVelocity():Length()*0.1) .."kn")
	surface.SetTextPos(30, 445)
	local tr=util.QuickTrace(pos+self:GetUp()*10,Vector(0,0,-999999),self.Entity)
	surface.DrawText("ALT  "..math.ceil((pos.z-tr.HitPos.z)*0.01905).."m")

	cam.End3D2D()
end