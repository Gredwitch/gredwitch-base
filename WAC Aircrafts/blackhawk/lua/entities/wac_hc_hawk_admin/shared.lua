if not wac then return end

ENT.Base 				= "wac_hc_base"
ENT.Type 				= "anim"
ENT.PrintName			= "[WAC]UH-60L Gunship (Admin)"
ENT.Author				= "Gredwitch"
ENT.Category			= "Gredwitch's Stuff"
ENT.Spawnable		= true
ENT.AdminSpawnable	= true

ENT.Model			= "models/wac/uh60_lau61ca.mdl"
ENT.SmokePos		= Vector(-104.32,36,98.752)
ENT.FirePos			= Vector(-104.32,36,98.752)

ENT.TopRotor = {
	dir = -1,
	pos = Vector(-13.95,-0.33,111.58),
	model = "models/wac/uh60_rotor.mdl"
}

ENT.BackRotor = {
	dir = -1,
	pos = Vector(-376.98,-9.1,136.11),
	model = "models/wac/uh60_back_rotor.mdl"
}

ENT.Wheels={
	{
		mdl="models/wac/uh60_back_wheel.mdl",
		pos=Vector(-288.5,-0.02,9.71),
		friction=60,
		mass=600,
	},
	{
		mdl="models/wac/uh60_front_wheel_left.mdl",
		pos=Vector(29.02,52.71,11.41),
		friction=60,
		mass=600,
	},
	{
		mdl="models/wac/uh60_front_wheel_right.mdl",
		pos=Vector(29.04,-52.44,11.39),
		friction=60,
		mass=600,
	},

}

ENT.Seats = {
	{
		pos=Vector(80.4, -24.49, 45),
		exit=Vector(120, -90, 40),
		weapons={"M134 minigun", "Hydra 70"},
	},
	{
		pos=Vector(80.4, 24.09, 45),
		exit=Vector(120, 90, 40),
	},
	{
		pos=Vector(48.12, -16.99, 40),
		ang=Angle(0,-90,0),
		exit=Vector(120, -90, 40),
	},
	{
		pos=Vector(48.11, 15.07, 40),
		ang=Angle(0,90,0),
		exit=Vector(120, 90, 40),
	},
	{
		pos=Vector(48.52, -1.06, 40),
		ang=Angle(0,180,0),
		exit=Vector(120, -90, 40),
	},
	{
		pos=Vector(-52.96, -24.79, 40),
		exit=Vector(-100, -100, 40),
	},
	{
		pos=Vector(-52.96, 26.39, 40),
		exit=Vector(-100, 100, 40),
	},
	{
		pos=Vector(-52.96, -7.64, 40),
		exit=Vector(-100, -100, 40),
	},
	{
		pos=Vector(-52.96, 9.24, 40),
		exit=Vector(-100, 100, 40),
	},
}

ENT.Weapons = {
	["M134 minigun"] = {
		class = "wac_pod_mg",
		info = {
			Pods = {
				Vector(88.41,-54.2,57.56),
				Vector(88.41,54.2,57.56),
			},
			Ammo = 2,
			BulletType = "wac_base_7mm",
			TkAmmo = 0,
			FireRate = 3900,
			Sounds = {
				shoot = "WAC/uh60lau61/gun.wav",
				stop = "WAC/uh60lau61/gun_stop.wav"
			}
		}
	},
	["Hydra 70"] = {
		class = "wac_pod_grocket",
		info = {
			Pods = {
				Vector(33.97,74.94,56.26),
				Vector(33.97,-75.03,56.26),
				Sequential = true,
			},
			Ammo = 2,
			TkAmmo = 0,
		}
	}
}


ENT.Sounds={
	Start="WAC/uh60lau61/start.wav",
	Blades="WAC/uh60lau61/rotors.wav",
	Engine="WAC/uh60lau61/engine.wav",
	MissileAlert="HelicopterVehicle/MissileNearby.mp3",
	MissileShoot="HelicopterVehicle/MissileShoot.mp3",
	MinorAlarm="HelicopterVehicle/MinorAlarm.mp3",
	LowHealth="HelicopterVehicle/LowHealth.mp3",
	CrashAlarm="HelicopterVehicle/CrashAlarm.mp3",
}
