
ENT.Base = "wac_hc_base"
ENT.Type = "anim"
ENT.Author = "Gredwitch"
ENT.Category = "Gredwitch's Stuff"
ENT.Spawnable = true
ENT.AdminSpawnable = true
ENT.PrintName = "[WAC]HP-48 Krokodil"
ENT.Model = "models/wac/fg_hp/hpmainfas.mdl"
ENT.EngineForce = 60
ENT.Weight = 10000
ENT.SmokePos = Vector(-130,0,190)
ENT.FirePos = Vector(-130,0,190)
ENT.thirdPerson = {
	distance = 1000
}

ENT.TopRotor = {
	model = "models/bf2/helicopters/uh-60 blackhawk/uh60_r.mdl",
	pos = Vector(-130,0,190)
}

ENT.BackRotor = {
	dir = -1,
	model = "models/bf2/helicopters/uh-60 blackhawk/uh60_rr.mdl",
	pos = Vector(-650,10,210), 
}

ENT.Seats = {
	{
		pos = Vector(23, 1, 115),
		exit = Vector(130,-102,45),
		weapons = {"AS MISSILE"}
	},
	{
		pos = Vector(93, 1, 90),
		exit = Vector(130,100,45),
		weapons = {"M230"}
	},
	{
		pos = Vector(-140, -10, 84),
		ang = Angle(0,-90,9),
		exit = Vector(-100,-102,45),
	},
	{
		pos = Vector(-170, -10, 84),
		ang = Angle(0,-90,9),
		exit = Vector(-100,-102,45),
	},
	{
		pos = Vector(-200, -10, 84),
		ang = Angle(0,-90,9),
		exit = Vector(-100,-102,45),
	},
	{
		pos = Vector(-140, 10, 84),
		ang = Angle(0,90,9),
		exit = Vector(-100,102,45),
	},
	{
		pos = Vector(-170, 10, 84),
		ang = Angle(0,90,9),
		exit = Vector(-100,102,45),
	},
	{
		pos = Vector(-200, 10, 84),
		ang = Angle(0,90,9),
		exit = Vector(-100,102,45),
	},
}

ENT.Weapons = {
	["AS MISSILE"] = {
		class = "wac_pod_grocket",
		info = {
			Pods = {
				Vector(-100,102,100),
				Vector(-100,-100,100),
				Sequential = false,
			},
			Ammo = 1,
			TkAmmo = 0,
			FireRate = 400,
		}
	},
	["M230"] = {
		class = "wac_pod_gunner",
		info = {
			ShootPos = Vector(120, 0, 20),
			ShootOffset = Vector(100, 0, 0),
			FireRate = 1000,
			Ammo = 1,
			TkAmmo = 0,
			BulletType = "wac_base_20mm",
			Sounds = {
				spin = "",
				shoot1p = "WAC/cannon/havoc_cannon_1p.wav",
				shoot3p = "WAC/cannon/havoc_cannon_3p.wav"
			}
		}
	}
}

ENT.WeaponAttachments = {

	gunMount1 = {
		model = "models/bf2/helicopters/mil mi-28/mi28_g2.mdl",
		pos = Vector(70,0,55),
		restrictPitch = true
	},
	
	gunMount2 = {
		model = "models/wac/fg_hp/hpgun.mdl",
		pos = Vector(70,0,20),
		offset = Vector(2,0,0)
	},

	gun = {
		model = "models/wac/fg_hp/hpgun.mdl",
		pos = Vector(70,0,20),
		offset = Vector(2,0,0)
	},
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

ENT.Camera = {
	model = "models/wac/fg_hp/hpcam.mdl",
	pos = Vector(132,0,50),
	offset = Vector(1,0,0),
	viewPos = Vector(7, 0, -5),
	maxAng = Angle(90, 90, 0),
	minAng = Angle(-5, -90, 0),
	seat = 2
}