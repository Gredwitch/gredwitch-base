
ENT.Base = "wac_hc_base"
ENT.Type = "anim"
ENT.Author = "Gredwitch"
ENT.Category = "Gredwitch's Stuff"
ENT.Spawnable = true
ENT.AdminSpawnable = true
ENT.EngineForce = 70
ENT.Weight = 10000
ENT.PrintName = "[WAC]UTH-66 Blackfoot"
ENT.SmokePos = Vector(-155,40,120)
ENT.FirePos = ENT.SmokePos
ENT.Model = "models/wac/fg_uth66/uth_main997.mdl"

ENT.TopRotor = {
	model = "models/wac/fg_uth66/uth_toprotor.mdl",
	pos = Vector(-10,0,145),
}

ENT.BackRotor = {
	dir = -1,
	model = "models/wac/fg_uth66/uth_rr.mdl",
	pos = Vector(-500,40,200), 
	angles = Angle(0,0,-200),
}
ENT.thirdPerson = {
	distance = 900
}

ENT.Seats = {
	{
		pos = Vector(132, -27, 68),
		exit = Vector(130,-102,45),
		weapons = {"M197", "AS MISSILE"}
	},
	{
		pos = Vector(132, 30, 68),
		exit = Vector(130,100,45),
		weapons = {"M230", "Hellfire"}
	},
	{
		pos = Vector(85, 35, 60),
		ang = Angle(0,-90,9),
		exit = Vector(85,23,45),
	},
	{
		pos = Vector(55, 35, 60),
		ang = Angle(0,-90,9),
		exit = Vector(55,23,45),
	},
	{
		pos = Vector(85, -33, 60),
		ang = Angle(0,90,9),
		exit = Vector(85,-23,45),
	},
	{
		pos = Vector(55, -33, 60),
		ang = Angle(0,90,9),
		exit = Vector(55,-23,45),
	},
	{
		pos = Vector(-61, 0, 60),
		ang = Angle(0,0,9),
		exit = Vector(0,0,45),
	},
	{
		pos = Vector(-5, 37, 41),
		ang = Angle(0,90,9),
		exit = Vector(0,100,45),
	},
	{
		pos = Vector(-5, -39, 41),
		ang = Angle(0,-90,9),
		exit = Vector(0,-102,45),
	}
}




ENT.Weapons = {
	["M197"] = {
		class = "wac_pod_mg",
		info = {
			Pods = {
				Vector(100,72,80),
				Vector(100,-70,80)
			},
			Ammo = 1000,
			FireRate = 1000,
			BulletType = "wac_base_7mm",
			Sequential = false,
			Sounds = {
				shoot = "Warkanum/minigun_shoot.wav",
				stop = "Warkanum/minigun_wind_stop.wav",
			}
		}
	},
	["AS MISSILE"] = {
		class = "wac_pod_grocket",
		info = {
			Pods = {
				Vector(0,102,100),
				Vector(0,-100,100),
				Sequential = false,
			},
			Ammo = 32,
			FireRate = 400,
		}
	},
	["M230"] = {
		class = "wac_pod_gunner",
		info = {
			ShootPos = Vector(120, 0, 25),
			ShootOffset = Vector(100, 0, 5),
			FireRate = 1000,
			Ammo = 1200,
			BulletType = "wac_base_30mm",
			Damage = 60,
			Sounds = {
				spin = "",
				shoot1p = "WAC/cannon/havoc_cannon_1p.wav",
				shoot3p = "WAC/cannon/havoc_cannon_3p.wav"
			}
		}
	},
	["Hellfire"] = {
		class = "wac_pod_mis",
		info = {
			Pods = {
				Vector(3.22,102.38,59.59),
				Vector(3.22,-102.38,59.59),
				
			},
		Ammo = 24,
		FireRate = 200
		}
	}
}

ENT.WeaponAttachments = {

	gunMount1 = {
		model = "models/bf2/helicopters/mil mi-28/mi28_g2.mdl",
		pos = Vector(120,0,37),
		restrictPitch = true
	},
	
	gunMount2 = {
		model = "models/bf2/helicopters/mil mi-28/mi28_g1.mdl",
		pos = Vector(120,0,25),
		offset = Vector(2,0,0)
	},

	gun = {
		model = "models/bf2/helicopters/mil mi-28/mi28_g1.mdl",
		pos = Vector(120,0,25),
		offset = Vector(2,0,0)
	},
}


ENT.Camera = {
	model = "models/bf2/helicopters/ah-1 cobra/ah1z_radar1.mdl",
	pos = Vector(225,0,70),
	offset = Vector(1,0,0),
	viewPos = Vector(20, 0, 0),
	maxAng = Angle(90, 90, 0),
	minAng = Angle(-5, -90, 0),
	seat = 2
}

ENT.Sounds = {
	Start = "WAC/Heli/h6_start.wav",
	Blades = "WAC/Heli/uh60_loop.wav",
	Engine = "",
	MissileAlert = "HelicopterVehicle/MissileNearby.mp3",
	MissileShoot = "HelicopterVehicle/MissileShoot.mp3",
	MinorAlarm = "HelicopterVehicle/MinorAlarm.mp3",
	LowHealth = "HelicopterVehicle/LowHealth.mp3",
	CrashAlarm = "HelicopterVehicle/CrashAlarm.mp3",
	Radio =  "HelicopterVehicle/MissileNearby.mp3",
}