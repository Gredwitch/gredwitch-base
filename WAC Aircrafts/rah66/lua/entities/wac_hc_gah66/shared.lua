
ENT.Base = "wac_hc_base"
ENT.Type = "anim"
ENT.Author = "Gredwitch"
ENT.Category = "Gredwitch's Stuff"
ENT.Spawnable = true
ENT.AdminSpawnable = true
ENT.AutomaticFrameAdvance = true
ENT.PrintName		= "[WAC]RAH-66 Comanche"

ENT.TopRotor = {
	dir = 1,
	pos = Vector(30,0,113.5),
	model = "Models/Sentry/RAH66_tr.mdl",
}
 
ENT.BackRotor = {
	dir = 1,
	pos = Vector(-235.61,0,54),
	angles = Angle(0,0,-15),
	model = "Models/sentry/RAH66_br.mdl"
}

ENT.Model			= "Models/Sentry/RAH66.mdl"
ENT.RotorPhModel	= "models/props_junk/sawblade001a.mdl"

ENT.SmokePos		= Vector(30,0,103.5)
ENT.FirePos			= Vector(30,0,113.5)

ENT.Seats = {
	{
		pos = Vector(134, 0, 46),
		exit = Vector(134,70,0),
		weapons = {"Hydra 70"}
	},
	{
		pos = Vector(78, 0, 56),
		exit = Vector(78,70,0),
		weapons = {"Hellfire", "M197"} --XM301 
	},
}

ENT.Wheels={
	{
		mdl="models/sentry/rah66_fwheel.mdl",
		pos=Vector(106.5,-38,3.5),
		friction=70,
		mass=100,
	},
	{
		mdl="models/sentry/rah66_fwheel.mdl",
		pos=Vector(106.5,38,3.5),
		friction=70,
		mass=100,
	},
	{
		mdl="models/sentry/rah66_bwheel.mdl",
		pos=Vector(-199,0,2),
		friction=70,
		mass=100,
	},
}


ENT.Weapons = {
	["Hydra 70"] = {
		class = "wac_pod_grocket",
		info = {
			Sequential = true,
			Ammo = 14,
			FireRate = 300,
			Pods = {
				Vector(40.25, 48.33, 32.93),
				Vector(40.25, -48.33, 32.93)
			}
		}
	},
	["Hellfire"] = {
		class = "wac_pod_mis",
		info = {
			Pods = {
				Vector(40.25,55.84,41.45),
				Vector(40.25,-55.84,41.45),
			},
			Ammo = 8,
			FireRate = 200
		}
	},
	["M197"] = { --XM301 
		class = "wac_pod_gunner",
		info = {
			ShootPos = Vector(187, 0, 29),
			ShootOffset = Vector(60, 0, 0),
			BulletType = "wac_base_20mm",
			Ammo = 1000,
			FireRate = 1500
		}
	}
}


ENT.Camera = {
	model = "models/sentry/rah66_cam.mdl",
	pos = Vector(207,0,53),
	offset = Vector(-1,0,0),
	viewPos = Vector(10, 0, 5),
	maxAng = Angle(90, 90, 0),
	minAng = Angle(-15, -90, 0),
	seat = 2
}


ENT.WeaponAttachments = {

	gunMount1 = {
		model = "models/props_junk/PopCan01a.mdl",
		pos = Vector(187,0,29),
		restrictPitch = true,

	},
	
	gunMount2 = {
		model = "models/props_junk/PopCan01a.mdl",
		pos = Vector(137,0,23),
		offset = Vector(2,0,0)
	},

	gun = {
		model = "models/sentry/rah66_gun.mdl",
		pos = Vector(187, 0, 23),
		offset = Vector(2,0,0)
	},
	 
	radar1 = {
		model = "models/props_junk/PopCan01a.mdl",
		pos = Vector(175,0,52),
		restrictPitch = true,

	},

}


ENT.Sounds = {
	Start = "wac/Heli/RAH66/start.wav",
	Blades = "wac/heli/RAH66/ext.wav",
	Engine = "wac/heli/RAH66/int.wav",
	MissileAlert = "HelicopterVehicle/MissileNearby.mp3",
	MissileShoot = "HelicopterVehicle/MissileShoot.mp3",
	MinorAlarm = "HelicopterVehicle/MinorAlarm.mp3",
	LowHealth = "HelicopterVehicle/LowHealth.mp3",
	CrashAlarm = "HelicopterVehicle/CrashAlarm.mp3",
}

