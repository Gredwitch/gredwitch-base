if not wac then return end

ENT.Base 				= "wac_hc_base"
ENT.Type 				= "anim"
ENT.PrintName			= "[WAC]KA-50 BlackShark"
ENT.Author				= "Gredwitch"
ENT.Category			= "Gredwitch's Stuff"
ENT.Spawnable			= true
ENT.AdminSpawnable		= true

ENT.Model			= "models/sentry/ka-50.mdl"
ENT.EngineForce	= 36
ENT.Weight		= 21600
ENT.SmokePos	= Vector(28,0,108.48)
ENT.FirePos		= Vector(28,0,108.48)

ENT.thirdPerson = {
	distance = 680
}

ENT.TopRotor = {
	dir = -1,
	pos = Vector(30,0,106),
	model = "models/sentry/ka-50_br.mdl"
}

ENT.TopRotor2 = {
	dir = 1,
	pos = Vector(30,0,158.5),
	angles = Angle(0,0,0),
	model = "models/sentry/ka-50_tr.mdl"
}

ENT.BackRotor = {
	dir = 1,
	pos = Vector(30,0,50),
	model = "models/props_junk/PopCan01a.mdl"
}
ENT.Seats = {
	{
		pos=Vector(116, 0, 52),
		exit=Vector(160,70,40),
		weapons={"Shipunov 2A42", "S-8", "Vikhr"}
	}
}

ENT.Weapons = {
	["Shipunov 2A42"] = {
		class = "wac_pod_mg",
		info = {
			Pods = {
				Vector(140,-35,43)
			},
			Sounds = {
				shoot = "WAC/KA-50/2A42.wav",
				stop = "WAC/KA-50/2A42_stop.wav"
			},
			FireRate = 800,
			BulletType = "wac_base_30mm",
			TracerColor = "Green",
			Ammo = 1200
		}
	},
	["S-8"] = {
		class = "wac_pod_grocket",
		info = {
			Pods = {
				Vector(20,-80,46),
				Vector(20,80,46),
			},
			Sequential = true,
			Ammo = 28
		}
	},
	["Vikhr"] = {
		class = "wac_pod_mis",
		info = {
			Pods = {
				Vector(20,-80,46),
				Vector(20,80,46),
			},
			Sequential = true,
			Ammo = 12
		}
	}
}

ENT.Camera = {
	model = "models/mm1/box.mdl",
	pos = Vector(250,20,0),
	offset = Vector(0,0,0),
	viewPos = Vector(0,0,0),
	maxAng = Angle(0,0,0),
	minAng = Angle(0,0,0),
	seat = 1
}

ENT.Sounds={
	Start="WAC/KA-50/start.wav",
	Blades="WAC/KA-50/external.wav",
	Engine="WAC/KA-50/internal.wav",
	MissileAlert="WAC/Heli/heatseeker_track_warning.wav",
	MissileShoot="HelicopterVehicle/MissileShoot.mp3",
	MinorAlarm="WAC/Heli/fire_alarm_tank.wav",
	LowHealth="WAC/Heli/fire_alarm.wav",
	CrashAlarm="WAC/Heli/laser_warning.wav"
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