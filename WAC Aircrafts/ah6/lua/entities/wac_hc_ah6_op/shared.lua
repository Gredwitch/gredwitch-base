
ENT.Base = "wac_hc_base"
ENT.Type = "anim"
ENT.Author = "Gredwitch"
ENT.Spawnable = true
ENT.AdminSpawnable = true
ENT.Category			= "Gredwitch's Stuff"
ENT.PrintName = "[WAC]Little Bird AH-6 Buffed"
ENT.Model = "models/flyboi/littlebird/littlebirda_fb.mdl"

ENT.TopRotor = {
	model = "models/flyboi/littlebird/littlebirdrotorm_fb.mdl",
	pos = Vector(-10,0,100),
}

ENT.BackRotor = {
	dir = -1,
	model = "models/flyboi/littlebird/littlebirdt_fb.mdl",
	pos = Vector(-217,9,73), 
}

ENT.EngineForce = 70
ENT.Weight = 1300

ENT.SmokePos = Vector(-90,0,50)
ENT.FirePos = Vector(-50,0,100)

ENT.Seats = {
	{
		pos = Vector(22, 15, 49),
		exit = Vector(70,70,10),
		weapons = {"M134", "Hydra 70"}
	},
	{
		pos = Vector(22, -12, 49),
		exit = Vector(70,-70,10),
	},
}

ENT.thirdPerson = {
	distance = 400
}

ENT.Sounds = {
	Start = "wac/heli/h6_start.wav",
	Blades = "wac/heli/heli_loop_ext.wav",
	Engine = "wac/heli/heli_loop_int.wav",
	MissileAlert = "helicoptervehicle/missilenearby.mp3",
	MinorAlarm = "helicoptervehicle/minoralarm.mp3",
	LowHealth = "helicoptervehicle/lowhealth.mp3",
	CrashAlarm = "helicoptervehicle/crashalarm.mp3",
}

ENT.Weapons = {
	["M134"] = {
		class = "wac_pod_mg",
		info = {
			Pods = {
				Vector(40,40,30),
				Vector(40,-40,30),
			},
			Sounds = {
				shoot = "warkanum/minigun_shoot.wav",
				stop = "warkanum/minigun_wind_stop.wav",
			},
			BulletType = "wac_base_7mm",
			Ammo = 800,
			Sequential = false,
			FireRate = 4000
		}
	},
	["Hydra 70"] = {
		class = "wac_pod_grocket",
		info = {
			Pods = {
				Vector(200,50,40),
				Vector(200,-50,40),
			},
			Sequential = true,
			FireRate = 500,
			Ammo = 14
		}
	}
}

ENT.Camera = {
	model = "models/mm1/box.mdl",
	pos = Vector(60, 15, 100),
	offset = Vector(0,0,0),
	viewPos = Vector(0,0,0),
	maxAng = Angle(0, 0, 0),
	minAng = Angle(0, 0, 0),
	seat = 1
}