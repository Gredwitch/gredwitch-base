if not wac then return end
ENT.Base = "wac_pl_base"
ENT.Type = "anim"
ENT.Category = "Gredwitch's Stuff"
ENT.Spawnable = true
ENT.AdminSpawnable = true
ENT.PrintName = "[WAC]Junkers Ju 88"
ENT.Model				= "models/gredwitch/ju88/ju88.mdl"
ENT.RotorPhModel		= "models/props_junk/sawblade001a.mdl"
ENT.RotorModel			= "models/gredwitch/ju88/ju88_prop.mdl"
ENT.OtherRotorModel		= "models/gredwitch/ju88/ju88_prop.mdl"
ENT.AutomaticFrameAdvance = true
ENT.Weight			= 9000
ENT.EngineForce		= 3354
ENT.rotorPos 	= Vector(210, -106, -10)
ENT.OtherRotorPos = Vector(210, 106, -10)
ENT.FirePos			= ENT.rotorPos
ENT.SmokePos		= ENT.rotorPos
ENT.OtherRotorDir = -1
ENT.Engines = 2
ENT.maxEnterDistence = 400

ENT.thirdPerson = {
	distance = 600
}

ENT.Agility = {
	Thrust = 15
}

ENT.Wheels={
	{
		mdl="models/gredwitch/ju88/ju88_wr.mdl",
		pos=Vector(80,-104,-90),
		friction=10,
		mass=1000,
	},
	{
		mdl="models/gredwitch/ju88/ju88_wl.mdl",
		pos=Vector(80,104,-90),
		friction=10,
		mass=1000,
	},
	{
		mdl="models/gredwitch/ju88/ju88_wb.mdl",
		pos=Vector(-275,0,-46),
		friction=10,
		mass=1000,
	},
}

ENT.Seats = {
	{
		pos=Vector(156,0,0),
		exit=Vector(400,0,0),
		weapons={"100Kg Bombs", "Front MG131"}
	},
	{
		pos=Vector(143,0,0),
		ang=Angle(0,180,0),
		exit=Vector(400,0,0),
		weapons={"Back MG81"}
	},
}

ENT.Weapons = {
	["100Kg Bombs"] = {
		class = "wac_pod_gbomb",
		info = {
			Pods = {
				Vector(70,0,-28),
				Vector(70,12,-28),
				Vector(70,-12,-28),
				Vector(110,0,-28),
				Vector(110,12,-28),
				Vector(110,-12,-28),
				Vector(150,0,-28),
				Vector(150,12,-28),
				Vector(150,-12,-28),
				Vector(110,0,-20),
				
			},
			Kind = "gb_bomb_sc100",
			Sounds = {
			    fire = "bomb/bomb_whistle_0"..math.random(1,4)..".wav"
			},
		}
	},
	["Front MG131"] = {
		class = "wac_pod_mg",
		info = {
			Pods = {
				Vector(300,-12,-20)
			},
			Sounds = {
				shoot = "wac/ju88/shoot.wav",
				stop = "wac/ju88/stop.wav",
			},
			Sequential = true,
			BulletType = "wac_base_7mm",
			Ammo = 1000,
			FireRate = 750,
		}
	},
	["Back MG81"] = {
		class = "wac_pod_gunner",
		info = {
			Sounds = {
	            shoot1p = "",
	            shoot3p = "",
            	spin = "wac/ju88/shoot.wav"
            },
			ShootPos = Vector(90,0,70),
			ShootOffset = Vector(0,0,0),
			Sequential = true,
			BulletType = "wac_base_7mm",
			Ammo = 1000,
			FireRate = 750
		}
	}
}

ENT.Camera = {
	model = "models/mm1/box.mdl",
	pos = Vector(90,0,45),
	offset = Vector(0,0,0),
	viewPos = Vector(0,0,0),
	minAng = Angle(-180,-180, -180),
	maxAng = Angle(180, 180, 180),
	seat = 2
}

ENT.Sounds={
	Start="wac/ju88/start.wav",
	Blades="wac/ju88/external.wav",
	Engine="radio/german.wav",
	MissileAlert="",
	MissileShoot="",
	MinorAlarm="",
	LowHealth="",
	CrashAlarm="",
}

function ENT:DrawPilotHud() end