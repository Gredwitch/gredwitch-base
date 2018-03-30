if not wac then return end

ENT.Base 				= "wac_hc_base"
ENT.Type 				= "anim"
ENT.Category			= "Gredwitch's Stuff"
ENT.PrintName			= "[WAC]Bell OH-58D Kiowa (Admin)"
ENT.Author				= "Gredwitch"
ENT.Spawnable			= true
ENT.AdminSpawnable		= true
ENT.Model			= "models/bf2/kiowa/body.mdl"
ENT.EngineForce	= 34
ENT.Weight			= 2300
ENT.SmokePos		= Vector(-90,0,95)
ENT.FirePos		= Vector(-90,0,95)

ENT.thirdPerson = {
	distance = 600
}
ENT.TopRotor = {
	dir = -1,
	pos = Vector(-35.5,2,96),
	model = "models/bf2/kiowa/rotor.mdl"
}

ENT.BackRotor = {
	dir = -1,
	pos = Vector(-292.5,4,73.6),
	model = "models/bf2/kiowa/tailrotor.mdl"
}

ENT.Seats = {
	{
		pos=Vector(12, -9, 32),
		exit=Vector(38,-60,10),
		weapons={"M134", "Hydra 70"},
	},
	{
		pos=Vector(12, 14, 32),
		exit=Vector(28,50,10),
	}
}

ENT.Weapons = {
	["M134"] = {
		class = "wac_pod_mg",
		info = {
			Pods = {
				Vector(20,43,23),
			},
			Ammo = 1,
			Sounds = {
				shoot = "Warkanum/minigun_shoot.wav",
				stop = "Warkanum/minigun_wind_stop.wav",
			},
			TkAmmo = 0,
			BulletType = "wac_base_7mm",
			FireRate = 4000
		}
	},
	["Hydra 70"] = {
		class = "wac_pod_grocket",
		info = {
			Pods = {
				Vector(14,-43,28)
			},
			Ammo = 1,
			TkAmmo = 0,
			FireRate = 200
		}
	}
}

ENT.WeaponAttachments = {
	radar1 = {
		model = "models/BF2/Kiowa/mms1.mdl",
		pos = Vector(-35.5,2,120),
	}
}

ENT.Camera = {
	model = "models/BF2/Kiowa/mms2.mdl",
	pos = Vector(-35.5,2,145),
	offset = Vector(-1,0,0),
	viewPos = Vector(15, 0, 3.5),
	maxAng = Angle(45, 90, 0),
	minAng = Angle(-2, -90, 0),
	seat = 2
}

ENT.Sounds={
	Start="WAC/Heli/h6_start.wav",
	Blades="WAC/kiowa/external.wav",
	Engine="WAC/kiowa/internal.wav",
	MissileAlert="HelicopterVehicle/MissileNearby.mp3",
	MissileShoot="HelicopterVehicle/MissileShoot.mp3",
	MinorAlarm="HelicopterVehicle/MinorAlarm.mp3",
	LowHealth="HelicopterVehicle/LowHealth.mp3",
	CrashAlarm="HelicopterVehicle/CrashAlarm.mp3"
}