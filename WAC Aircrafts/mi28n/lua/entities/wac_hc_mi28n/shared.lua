
ENT.Base = "wac_hc_base"
ENT.Type = "anim"
ENT.Author = wac.author
ENT.Category = "Gredwitch's Stuff"
ENT.Spawnable = true
ENT.AdminSpawnable = true
ENT.SmokePos = Vector(-80,0,50)
ENT.FirePos = Vector(-50,0,100)
ENT.MaxEnterDistance = 100
ENT.EngineForce	= 30
ENT.Weight = 9000
ENT.PrintName = "[WAC]Mil Mi-28N"
ENT.Model = "models/gredwitch/mi28n/mi28n.mdl"
ENT.WheelStabilize	=-150

ENT.TopRotor = {
	pos = Vector(36,0,172.2),
	model = "models/gredwitch/mi28n/mi28n_tr.mdl",
}

ENT.BackRotor = {
	pos = Vector(-430.5,-35.5,150.37),
	model = "models/gredwitch/mi28n/mi28n_br.mdl",
}

ENT.thirdPerson = {
	distance = 800
}

ENT.Wheels = {
	{
		mdl="models/gredwitch/mi28n/mi28n_wr.mdl",
		pos=Vector(50.2822,-51.2646,19.3729),
		friction=100,
		mass=200,
	},
	{
		mdl="models/gredwitch/mi28n/mi28n_wl.mdl",
		pos=Vector(50.2822,50.4346,19.3729),
		friction=100,
		mass=200,
	},
	{
		mdl="models/gredwitch/mi28n/mi28n_wb.mdl",
		pos=Vector(-391.536,0,31.343),
		friction=100,
		mass=400,
	},
}

ENT.Seats = {
	{
		pos = Vector(85,0,104.654),
		exit = Vector(85,150,20),
		weapons = {"S-8"}
	},
	{
		pos = Vector(145,0,86.3709),
		exit = Vector(145,150,20),
		weapons = {"2A42", "PTUR"}
	}
}

ENT.Weapons = {
	["2A42"] = {
		class = "wac_pod_gunner",
		info = {
			ShootPos = Vector(180, 0, 40),
			ShootOffset = Vector(100, 5, 5),
			FireRate = 500,
			TracerColor = "Green",
			BulletType = "wac_base_30mm",
			Sounds = {
				spin = "",
				shoot1p = "WAC/cannon/havoc_cannon_1p.wav",
				shoot3p = "WAC/cannon/havoc_cannon_3p.wav"
			}
		}
	},
	["S-8"] = {
		class = "wac_pod_grocket",
		info = {
			Pods = {
				Vector(3.22,72.94,49),
				Vector(3.22,-72.94,49),
			},
			Ammo = 40,
			FireRate = 300,
		}
	},
	["PTUR"] = {
		class = "wac_pod_mis",
		info = {
			Pods = {
				Vector(5,-124.6,66),
				Vector(5,-119,66),
				Vector(5,-112,66),
				Vector(5,-102,66),
				Vector(5,-96,66),
				Vector(5,-90,66),
				
				Vector(5,124.6,66),
				Vector(5,119,66),
				Vector(5,112,66),
				Vector(5,102,66),
				Vector(5,96,66),
				Vector(5,90,66),
				
			},
			Firerate = 300,
			Ammo = 12,
		}
	}
}


ENT.Sounds = {
	Start = "WAC/Heli/ah1_start.wav",
	Blades = "npc/attack_helicopter/aheli_rotor_loop1.wav",
	Engine = "WAC/heli/bellinternal.wav",
	MissileAlert = "HelicopterVehicle/MissileNearby.mp3",
	MissileShoot = "HelicopterVehicle/MissileShoot.mp3",
	MinorAlarm = "HelicopterVehicle/MinorAlarm.mp3",
	LowHealth = "HelicopterVehicle/LowHealth.mp3",
	CrashAlarm = "HelicopterVehicle/CrashAlarm.mp3",
}


ENT.Camera = {
	model = "models/gredwitch/mi28n/mi28n_camera.mdl",
	pos = Vector(224,0,84),
	offset = Vector(0,0,0),
	viewPos = Vector(10, 0, -6),
	maxAng = Angle(50, 90, 0),
	minAng = Angle(-5, -90, 0),
	seat = 2
}


ENT.WeaponAttachments = {

	gunMount1 = {
		model = "models/gredwitch/mi28n/mi28n_gunPod.mdl",
		pos = Vector(156.5,0,44),
		restrictPitch = true
	},

	gun = {
		model = "models/gredwitch/mi28n/mi28n_gun.mdl",
		pos = Vector(138.6,0,37.4),
	},
	
	radar1 = {
		model = "models/gredwitch/mi28n/mi28n_radar.mdl",
		pos = Vector(198.5,0,69),
		restrictPitch = true
	},

}
