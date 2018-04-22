if not wac then return end

ENT.Base 				= "wac_hc_base"
ENT.Type 				= "anim"
ENT.PrintName			= "[WAC]KA-52 Alligator"
ENT.Author				= "Gredwitch"
ENT.Category			= "Gredwitch's Stuff"
ENT.Spawnable			= true
ENT.AdminSpawnable		= true

ENT.Model			= "models/gredwitch/ka52/ka52.mdl"
ENT.EngineForce	= 36
ENT.Weight		= 9000
ENT.SmokePos	= Vector(28,0,108.48)
ENT.FirePos		= Vector(28,0,108.48)

ENT.thirdPerson = {
	distance = 680
}

ENT.TopRotor = {
	dir = -1,
	pos = Vector(7,0,110),
	model = "models/gredwitch/ka52/ka52_topRotor1.mdl"
}

ENT.TopRotor2 = {
	dir = 1,
	pos = Vector(7,0,158),
	angles = Angle(0,0,0),
	model = "models/gredwitch/ka52/ka52_topRotor2.mdl"
}

ENT.BackRotor = {
	dir = 1,
	pos = Vector(-265,0,118),
	model = "models/mm1/box.mdl"
}
ENT.Seats = {
	{
		pos=Vector(94, 13, 35),
		exit=Vector(94,70,40),
		weapons={"Shipunov 2A42", "S-8", "Vikhr"}
	},
	{
		pos=Vector(94,-13, 35),
		exit=Vector(94,70,40),
		--weapons={"Shipunov 2A42", "S-8", "Vikhr"}
	}
}

ENT.Wheels={
	{
		mdl="models/gredwitch/ka52/ka52_wf.mdl",
		pos=Vector(137,0,3),
		friction=100,
		mass=550,
	},
	{
		mdl="models/gredwitch/ka52/ka52_wl.mdl",
		pos=Vector(-34,46.5,6.5),
		friction=100,
		mass=550
	},
	{
		mdl="models/gredwitch/ka52/ka52_wr.mdl",
		pos=Vector(-34,-46.5,6.5),
		friction=100,
		mass=550,
	},

}

ENT.Weapons = {
	["Shipunov 2A42"] = {
		class = "wac_pod_mg",
		info = {
			Pods = {
				Vector(100,-35,35)
			},
			Sounds = {
				shoot = "WAC/ka52/2A42.wav",
				stop = "WAC/ka52/2A42_stop.wav"
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
				Vector(20,-67,37),
				Vector(20,67,37),
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
	Start="WAC/ka52/start.wav",
	Blades="WAC/ka52/external.wav",
	Engine="WAC/ka52/internal.wav",
	MissileAlert="WAC/Heli/heatseeker_track_warning.wav",
	MissileShoot="HelicopterVehicle/MissileShoot.mp3",
	MinorAlarm="WAC/Heli/fire_alarm_tank.wav",
	LowHealth="WAC/Heli/fire_alarm.wav",
	CrashAlarm="WAC/Heli/laser_warning.wav"
}