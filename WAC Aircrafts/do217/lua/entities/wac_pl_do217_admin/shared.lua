if not wac then return end
ENT.Base = "wac_pl_base"
ENT.Type = "anim"
ENT.Category = "Gredwitch's Stuff"
ENT.Spawnable = true
ENT.AdminSpawnable = true
ENT.PrintName = "[WAC]Dornier Do 217N-1 (Admin)"
ENT.Model				= "models/gredwitch/do217/do217.mdl"
ENT.RotorPhModel		= "models/props_junk/sawblade001a.mdl"
ENT.RotorModel			= "models/gredwitch/do217/do217n1_prop.mdl"
ENT.OtherRotorModel		= ENT.RotorModel
ENT.AutomaticFrameAdvance = true
ENT.Weight			= 6000
ENT.EngineForce		= 3354
ENT.rotorPos 	= Vector(254.2, -127.12, 5.6)
ENT.OtherRotorPos = Vector(254.2, 127.12, 5.6)
ENT.FirePos			= ENT.rotorPos
ENT.SmokePos		= ENT.rotorPos
ENT.OtherRotorDir = -1
ENT.Engines			 = 2
ENT.MaxEnterDistance = 300

ENT.thirdPerson = {
	distance = 600
}

ENT.Agility = {
	Thrust = 15
}

ENT.Wheels={
	{
		mdl="models/gredwitch/do217/do217n1_wl.mdl",
		pos=Vector(144.26,-127,-89),
		friction=10,
		mass=400,
	},
	{
		mdl="models/gredwitch/do217/do217n1_wl.mdl",
		pos=Vector(144.26,127,-89),
		friction=10,
		mass=400,
	},
	{
		mdl="models/gredwitch/do217/do217n1_wb.mdl",
		pos=Vector(-250.7,0,-27.8),
		friction=10,
		mass=400,
	},
}

ENT.Weapons = {
	["100Kg Bombs"] = {
		class = "wac_pod_gbomb",
		info = {
			Pods = {
				Vector(145,0,-28),
			},
			Admin = 1,
			Kind = "gb_bomb_sc100"
		}
	},
	["MG151"] = {
		class = "wac_pod_mg",
		info = {
			Pods = {
				Vector(361,-10.36,-38.5),
				Vector(361,1.8,-38.5),
				Vector(400,-6.2,-27),
				Vector(400,-2.7,-27),
			},
			Sounds = {
				shoot = "wac/ju88/shoot.wav",
				stop = "wac/ju88/stop.wav",
			},
			BulletType = "wac_base_20mm",
			Sequential = true,
			Ammo = 1,
			TkAmmo = 0,
			FireRate = 750,
		}
	},
	["R-B MG17"] = {
		class = "wac_pod_mg",
		info = {
			Pods = {
				Vector(400,-6.2,12.2),
				Vector(400,6,12.2),
				Vector(400.5,-14.2,6.6),
				Vector(400.5,14.2,6.6),
			},
			Sounds = {
				shoot = "wac/ju88/shoot.wav",
				stop = "wac/ju88/stop.wav",
			},
			BulletType = "wac_base_7mm",
			Sequential = true,
			Ammo = 1,
			TkAmmo = 0,
			FireRate = 750,
		}
	},
	["R-B MG17 Turret"] = {
		class = "wac_pod_gunner",
		info = {
			ShootPos = Vector(150,0,60),
			ShootOffset = Vector(0,0,0),
			Sounds = {
				spin = "wac/ju88/shoot.wav",
				shoot1p = "",--"wac/ju88/stop.wav",
				shoot3p = ""
			},
			BulletType = "wac_base_12mm",
			Sequential = true,
			Ammo = 1,
			TkAmmo = 0,
			FireRate = 750,
		}
	},
}

ENT.Seats = {
	{
		pos=Vector(290,10.26,1.35),
		exit=Vector(290,100,0),
		weapons={"R-B MG17", "MG151", "100Kg Bombs"}
	},
	{
		pos=Vector(256,-13.44,0.8),
		exit=Vector(290,100,0),
	},
	{
		pos=Vector(232,12.3,-20.15),
		exit=Vector(290,100,0),
	},
	{
		pos=Vector(194,0,17),
		ang=Angle(0,180,0),
		exit=Vector(290,100,0),
		weapons={"R-B MG17 Turret"}
	},
}

ENT.WeaponAttachments={
	gun = {
		model = "models/mm1/box.mdl",
		pos = Vector(155,0,46.3),
		restrictPitch = true,
	},
	radar1 = {
		model = "models/mm1/box.mdl",
		pos = Vector(155,0,46.3),
		localTo = "gunMount1",
		restrictPitch = true,
	},
	gunMount1 = {
		model = "models/mm1/box.mdl",
		pos = Vector(155,0,46.3),
		localTo = "gunMount1",
		restrictPitch = true,
	},
}

ENT.Camera = {
	model = "models/mm1/box.mdl",
	pos = Vector(155,0,46.3),
	offset = Vector(0,0,0),
	viewPos = Vector(0,0,0),
	minAng = Angle(-180, -180,-180),
	maxAng = Angle(180, 180,180),
	seat = 4
}

ENT.Sounds={
	Start="wac/ju88/start.wav",
	Blades="wac/ju88/external.wav",
	Engine="radio/german.wav",
	MissileAlert="",
	MissileShoot="",
	MinorAlarm="",
	LowHealth="",
	CrashAlarm="",
}

function ENT:DrawPilotHud() end