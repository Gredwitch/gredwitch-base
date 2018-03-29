if not wac then return end

ENT.Base 			= "wac_hc_base"
ENT.Type 			= "anim"
ENT.PrintName		= "[WAC]Boeing AH-64D Longbow (Admin)"
ENT.Author			= "Gredwitch"
ENT.Category		= "Gredwitch's Stuff"
ENT.Spawnable		= true
ENT.AdminSpawnable	= true

ENT.Model			= "models/sentry/apache.mdl"
ENT.SmokePos		= Vector(37,0,75)
ENT.FirePos			= Vector(37,0,75)

ENT.TopRotor = {
	dir = -1,
	pos = Vector(37,0,80),
	model = "models/sentry/apachemain.mdl"
}

ENT.BackRotor = {
	dir = -1,
	pos = Vector(-332.5,-17,93.5),
	model = "models/sentry/apacherear.mdl"
}

ENT.Seats={
	{
		pos=Vector(93, 0, 10),
		exit=Vector(93,120,10),
		weapons={"Hydra 70", "M230", "Hellfire", "AIM-9"},
	},
	{	
		pos=Vector(142.5, 0, 0),
		exit=Vector(142.5,120,10),
		weapons={"M230", "Hellfire", "AIM-9"}
	},
}

ENT.thirdPerson = {
	distance = 600
}
ENT.Weapons = {
	["Hydra 70"] = {
		class = "wac_pod_grocket",
		info = {
			Sequential = true,
			Ammo = 1,
			TkAmmo = 0,
			Firerate = 390,
			Pods = {
				Vector(90.25,65.33,-15),
				Vector(90.25,-65.33,-15)
			}
		}
	},
	["Hellfire"] = {
		class = "wac_pod_hellfire",
		info = {
			Sequential = true,
			Ammo = 1,
			TkAmmo = 0,
			Pods = {
				Vector(90.25,65.33,-15),
				Vector(90.25,-65.33,-15)
			}
		}
	},
	["AIM-9"] = {
		class = "wac_pod_mis",
		info = {
			Sequential = true,
			model = "models/hawx/aim-9 sidewinder.mdl",
			Ammo = 1,
			TkAmmo = 0,
			Pods = {
				Vector(90.25,65.33,-15),
				Vector(90.25,-65.33,-15)
			}
		}
	},
	["M230"] = {
		class = "wac_pod_gunner",
		info = {
			ShootPos = Vector(125,0,-39),
			ShootOffset = Vector(65, 0, 0),
			FireRate = 625,
			TkAmmo = 0,
			Ammo = 1,
			BulletType = "wac_base_30mm",
			Sounds = {
				spin = "",
				shoot1p = "WAC/cannon/havoc_cannon_1p.wav",
				shoot3p = "WAC/cannon/havoc_cannon_3p.wav"
			}
		}
	},
}

ENT.WeaponAttachments={

	gunMount1 = {
		model = "models/sentry/apachegun1.mdl",
		pos = Vector(125,0,-30),
	},
	
	gunMount2 = {
		model = "models/sentry/apachegun2.mdl",
		pos = Vector(125,0,-39),
		localTo = "gunMount1",
	},
	
	gun = {
		model = "models/BF2/helicopters/AH-1 Cobra/ah1z_g.mdl",
		pos = Vector(125,0,-39),
		localTo = "gunMount2",
	},
	
	radar1 = {
		model = "models/sentry/apachecam.mdl",
		pos = Vector(213,0,12),
	},
	
}

ENT.Camera = {
	model = "models/BF2/helicopters/AH-1 Cobra/ah1z_radar1.mdl",
	pos = Vector(200,0,0),
	offset = Vector(-1,0,0),
	viewPos = Vector(30, 0, 3.5),
	maxAng = Angle(45, 90, 0),
	minAng = Angle(-2, -90, 0),
	seat = 2
}

ENT.Sounds={
	Start="WAC/ah64d/start.wav",
	Blades="WAC/ah64d/external.wav",
	Engine="WAC/ah64d/internal.wav",
	MissileAlert="HelicopterVehicle/MissileNearby.mp3",
	MissileShoot="WAC/ah64d/rocket_fire.wav",
	MinorAlarm="WAC/Heli/fire_alarm_tank.wav",
	LowHealth="WAC/Heli/fire_alarm.wav",
	CrashAlarm="WAC/Heli/FireSmoke.wav",
}