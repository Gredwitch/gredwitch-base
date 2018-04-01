if not wac then return end

ENT.Base 				= "wac_hc_base"
ENT.Type 				= "anim"
ENT.PrintName			= "[WAC]UH-1D Gunship"
ENT.Author				= "Gredwitch"
ENT.Category			= "Gredwitch's Stuff"
ENT.Spawnable			= true
ENT.AdminSpawnable	= true

ENT.Model			= "models/nam/huey.mdl"
ENT.EngineForce	= 36
ENT.Weight		= 4309
ENT.SmokePos	= Vector(-85,0,102)
ENT.FirePos		= Vector(-85,0,102)

ENT.TopRotor = {
	dir = -1,
	pos = Vector(2,0,142),
	model = "models/sentry/uh-1d_tr.mdl"
}

ENT.BackRotor = {
	dir = -1,
	pos = Vector(-335,6,156),
	model = "models/sentry/uh-1d_rr.mdl"
}

ENT.Seats = {
	{
		pos=Vector(95,-24.5,47),
		exit=Vector(100,-120,10),
		weapons={"GAU-17/A", "Hydra 70", "M60"},
	},
	{
		pos=Vector(95, 24.5, 47),
		exit=Vector(100,120,10),
	},
	{
		pos=Vector(18,-24.5,47),
		exit=Vector(20,-120,10),
	},
	{
		pos=Vector(18,0,47),
		exit=Vector(40,-120,10),
	},
	{
		pos=Vector(18, 24.5, 47),
		exit=Vector(20,120,10),
	},
}

ENT.Weapons = {
	["GAU-17/A"] = {
		class = "wac_pod_mg",
		info = {
			Pods = {
				Vector(25,86.817,32.261),
				Vector(25,-86.298,32.261),
			},
			Sounds = {
				shoot = "Warkanum/minigun_shoot.wav",
				stop = "Warkanum/minigun_wind_stop.wav",
			},
			Ammo = 1600,
			FireRate = 3000,
			BulletType = "wac_base_20mm",
		}
	},
	["Hydra 70"] = {
		class = "wac_pod_grocket",
		info = {
			Pods = {
				Vector(4.485,74.554,23.97),
				Vector(4.485,-74.035,23.97),
			},
			Sequential = false,
			Ammo = 14,
		}
	},
	["M60"] = {
		class = "wac_pod_mg",
		info = {
			Pods = {
				Vector(53.397,62.987,66.09),
				Vector(53.372,-62.493,66.09),
			},
			Ammo = 400,
			FireRate = 550,
			Sequential = true,
			BulletType = "wac_base_7mm",
			Sounds = {
				shoot = "huey/gun.wav",
				stop = "huey/gun_stop.wav"
			}
		}
	},
}

ENT.Sounds = {
	Start="WAC/uh1d/start.wav",
	Blades="WAC/uh1d/external.wav",
	Engine="WAC/uh1d/internal.wav",
	MissileAlert="HelicopterVehicle/MissileNearby.mp3",
	MissileShoot="ah64d/rocket_fire.wav",
	MinorAlarm="WAC/Heli/fire_alarm_tank.wav",
	LowHealth="WAC/Heli/fire_alarm.wav",
	CrashAlarm="WAC/Heli/FireSmoke.wav"
}