if not wac then return end

ENT.Base 			= "wac_hc_base"
ENT.Type 			= "anim"
ENT.PrintName		= "[WAC]Mil Mi-24 (Admin)"
ENT.Author			= "Gredwitch"
ENT.Category		= "Gredwitch's Stuff"
ENT.Spawnable		= true
ENT.AdminSpawnable	= true
ENT.Model			= "models/sentry/mi-35.mdl"
ENT.SmokePos		= Vector(-7.5,0,155)
ENT.FirePos			= Vector(-7.5,0,155)
ENT.WheelStabilize	=-150
ENT.EngineForce			= 40
ENT.Weight				= 12000
ENT.MaxEnterDistance	= 100
ENT.RotorWidth	= 400

ENT.Wheels = {
	{
		mdl="models/BF2/helicopters/Mil Mi-28/mi28_w1.mdl",
		pos=Vector(-46,65,10),
		friction=100,
		mass=350,
	},
	{
		mdl="models/BF2/helicopters/Mil Mi-28/mi28_w1.mdl",
		pos=Vector(-46,-65,10),
		friction=100,
		mass=350,
	},
	{
		mdl="models/BF2/helicopters/Mil Mi-28/mi28_w1.mdl",
		pos=Vector(124,10,5),
		friction=100,
		mass=150,
	},
	{
		mdl="models/BF2/helicopters/Mil Mi-28/mi28_w1.mdl",
		pos=Vector(124,-10,5),
		friction=100,
		mass=150,
	},
}

ENT.thirdPerson = {
	distance = 700
}

ENT.TopRotor = {
	dir = -1,
	pos = Vector(-7.5,0,160),
	model = "models/sentry/mi-35_tr.mdl"
}

ENT.BackRotor = {
	dir = -1,
	pos = Vector(-415.5,25,174.5),
	model = "models/sentry/mi-35_rr.mdl"
}

ENT.Seats = {
	{
		pos=Vector(125, 0, 68),
		exit=Vector(125, 70, 0),
		weapons={"57mm Rockets"},
	},
	{
		pos=Vector(180, 0, 40),
		exit=Vector(180, 70, 0),
		weapons={"12.7mm JakB", "9M17 Phalanga"},
	},
}


ENT.Weapons = {
	["57mm Rockets"] = {
		class = "wac_pod_grocket",
		info = {
			Sequential = true,
			Ammo = 1,
			TkAmmo = 0,
			Pods = {
				Vector(3.22,95,60),
				Vector(3.22,-95,60)
			}
		},
	},
	["9M17 Phalanga"] = {
		class = "wac_pod_mis",
		info = {
			Sequential = true,
			TkAmmo = 0,
			Ammo = 1,
			Pods = {
				Vector(-15,152.5,55),
				Vector(-15,-152.5,55)
			},
		},
	},
	["12.7mm JakB"] = {
		class = "wac_pod_gunner",
		info = {
			ShootPos = Vector(219,0,34),
			ShootOffset = Vector(25,0,0),
			FireRate = 700,
			Ammo = 1,
			TkAmmo = 0,
			TracerColor = "Green",
			Sounds = {
				spin = "",
				shoot1p = "WAC/cannon/havoc_cannon_1p.wav",
				shoot3p = "WAC/cannon/havoc_cannon_3p.wav"
			}
		}
	},
}

ENT.WeaponAttachments = {

	gunMount1 = {
		model = "models/sentry/mi-35_gun1.mdl",
		pos = Vector(219,0,34),
	},
	
	gunMount2 = {
		model = "models/sentry/mi-35_gun2.mdl",
		pos = Vector(219,0,34),
		localTo = "gunMount1",
	},
	
}

ENT.Camera = {
	model = "models/props_junk/PopCan01a.mdl",
	pos = Vector(220,0,50),
	offset = Vector(-1,0,0),
	viewPos = Vector(20, 0, 0),
	maxAng = Angle(45, 90, 0),
	minAng = Angle(-2, -90, 0),
	seat = 2
}

ENT.Sounds={
	Start="WAC/mi35/start.wav",
	Blades="WAC/mi35/external.wav",
	Engine="WAC/mi35/internal.wav",
	MissileAlert="HelicopterVehicle/MissileNearby.mp3",
	MissileShoot="HelicopterVehicle/MissileShoot.mp3",
	MinorAlarm="WAC/Heli/fire_alarm_tank.wav",
	LowHealth="WAC/Heli/fire_alarm.wav",
	CrashAlarm="WAC/Heli/FireSmoke.wav",
}

//hud

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