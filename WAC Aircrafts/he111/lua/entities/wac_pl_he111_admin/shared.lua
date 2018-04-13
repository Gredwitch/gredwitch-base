if not wac then return end
ENT.Base = "wac_pl_base"
ENT.Type = "anim"
ENT.Category = "Gredwitch's Stuff"
ENT.Spawnable = true
ENT.AdminSpawnable = true
ENT.PrintName = "[WAC]Heinkel He 111 (Admin)"
ENT.Model				= "models/gredwitch/he111/he111.mdl"
ENT.RotorPhModel		= "models/props_junk/sawblade001a.mdl"
ENT.RotorModel			= "models/gredwitch/he111/he111_prop.mdl"
ENT.OtherRotorModel		= ENT.RotorModel
ENT.AutomaticFrameAdvance = true
ENT.Weight			= 9000
ENT.EngineForce		= 3354
ENT.rotorPos 	= Vector(170, -104, -15)
ENT.OtherRotorPos = Vector(170, 104, -15)
ENT.FirePos			= ENT.rotorPos
ENT.SmokePos		= ENT.rotorPos
ENT.OtherRotorDir = -1
ENT.Engines = 2
ENT.maxEnterDistence = 400

ENT.thirdPerson = {
	distance = 700
}

ENT.Agility = {
	Thrust = 13
}

ENT.Wheels={
	{
		mdl="models/gredwitch/he111/he111_wr.mdl",
		pos=Vector(61,-104,-81),
		friction=10,
		mass=400,
	},
	{
		mdl="models/gredwitch/he111/he111_wl.mdl",
		pos=Vector(61,104,-81),
		friction=10,
		mass=400,
	},
	{
		mdl="models/gredwitch/he111/he111_wb.mdl",
		pos=Vector(-385,0,-30),
		friction=10,
		mass=800,
	},
}

ENT.Seats = {
	{
		pos=Vector(94,13,-15),
		exit=Vector(96,200,0),
		weapons={"Front MG15","100Kg Bombs"}
	},
	{
		pos=Vector(-30,0,12),
		ang=Angle(0,180,0),
		exit=Vector(96,200,0),
		weapons={"MG 87Z"}
	},
}

ENT.Weapons = {
	["100Kg Bombs"] = {
		class = "wac_pod_gbomb",
		info = {
			Pods = {
				Vector(25,15,-30),
				Vector(25,-15,-30),
				
			},
			Admin = 1,
			Kind = "gb_bomb_sc100"
		}
	},
	["Front MG15"] = {
		class = "wac_pod_mg",
		info = {
			Pods = {
				Vector(212.893,-5.16021,-3.64933)
			},
			Sounds = {
				shoot = "wac/he111/shoot.wav",
				stop = "wac/he111/stop.wav",
			},
			Sequential = true,
			Ammo = 1,
			TkAmmo = 0,
			BulletType = "wac_base_7mm",
			FireRate = 1000,
		}
	},
	["MG 87Z"] = {
		class = "wac_pod_gunner",
		info = {
			Sounds = {
	            shoot1p = "",
	            shoot3p = "",
            	spin = "wac/he111/spin.wav"
            },
			ShootPos = Vector(-80,0,50),
			ShootOffset = Vector(0,0,0),
			Sequential = true,
			BulletType = "wac_base_7mm",
			Ammo = 1,
			TkAmmo = 0,
			FireRate = 3000
		}
	}
}
ENT.WeaponAttachments={
	
	gunMount1 = {
		model = "models/gredwitch/he111/he111_mg81.mdl",
		pos = Vector(-47.7841,0,40.6234),
		restrictPitch = true,
	},
	gun = {
		model = "models/gredwitch/he111/he111_mg81.mdl",
		pos = Vector(-47.7841,0,40.6234),
		localTo = "gunMount",
	},
	
	radar1 = {
		model = "models/mm1/box.mdl",
		pos = Vector(-47.7841,0,40.6234),
		restrictPitch = true,
	},
	
}

ENT.Camera = {
	model = "models/mm1/box.mdl",
	pos = Vector(-90,0,80),
	offset = Vector(0,0,0),
	viewPos = Vector(0,0,0),
	minAng = Angle(-60, -360,0),
	maxAng = Angle(25, 360,0),
	seat = 2
}

ENT.Sounds={
	Start="wac/he111/start.wav",
	Blades="wac/he111/external.wav",
	Engine="radio/german.wav",
	MissileAlert="",
	MissileShoot="",
	MinorAlarm="",
	LowHealth="",
	CrashAlarm="",
}