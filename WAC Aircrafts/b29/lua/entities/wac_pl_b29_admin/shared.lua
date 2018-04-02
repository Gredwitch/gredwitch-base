if not wac then return end
ENT.Base = "wac_pl_base"
ENT.Type = "anim"
ENT.Category = "Gredwitch's Stuff"
ENT.Spawnable = true
ENT.AdminSpawnable = true
ENT.PrintName = "[WAC]B-29 Super Fortress (Admin)"
ENT.Model				= "models/gredwitch/b29/b29.mdl"
ENT.RotorPhModel		= "models/props_junk/sawblade001a.mdl"
ENT.RotorModel			= "models/gredwitch/b29/b29_prop.mdl"
ENT.Weight			= 25800
ENT.EngineForce		= 8800
ENT.rotorPos 	= Vector(290,-165,115)
ENT.FirePos			= ENT.rotorPos
ENT.SmokePos		= ENT.FirePos
ENT.MaxEnterDistance = 100
ENT.Engines = 4

ENT.OtherRotorPos={
	Vector(290,165,115),
	Vector(270,370,125),
	Vector(270,-370,125),
}

ENT.Agility = {
	Thrust = 16
}

ENT.thirdPerson = {
	distance = 1200
}


ENT.Wheels={
	{
		mdl="models/gredwitch/b29/b29_wl.mdl",
		pos=Vector(69,168,26),
		friction=5,
		mass=500,
	},
	{
		mdl="models/gredwitch/b29/b29_wr.mdl",
		pos=Vector(69,-168,26),
		friction=5,
		mass=500,
	},
	{
		mdl="models/gredwitch/b29/b29_wf.mdl",
		pos=Vector(491,0,17),
		friction=5,
		mass=2000,
	},
}

ENT.Seats = {
	{
		pos=Vector(450,25,110),
		exit=Vector(500,100,20),
		weapons = {"Front dorsal M2 Brownings","500lb bombs"},
	},
	{
		pos=Vector(450,-25,110),
		exit=Vector(500,-100,20),
	},
	{
		pos=Vector(490,0,90),
		exit=Vector(500,-100,20),
	},
	{
		pos=Vector(-21,0,135),
		ang=Angle(0,180,0),
		weapons = {"Rear dorsal M2 Brownings"},
		exit=Vector(500,-100,20),
	}
}

ENT.Weapons = {
	["500lb bombs"] = {
		class = "wac_pod_gbomb",
		info = {
			Pods = {
				Vector(270,0,60),
				
				Vector(80,0,60),
				
			},
			Kind = "gb_bomb_500gp",
			Admin = 1,
			Sounds = {
			    fire = "bomb/bomb_whistle_0"..math.random(1,4)..".wav"
			}
		}
	},
	["Rear dorsal M2 Brownings"] = {
		class = "wac_pod_gunner",
		info = {
			ShootPos = Vector(-82,0,174),
			ShootOffset = Vector(0,0,0),
			FireRate = 3400,
			TkAmmo = 0,
			Ammo = 1
		}
	},
	["Front dorsal M2 Brownings"] = {
		class = "wac_pod_mg",
		info = {
			Pods = {
				Vector(400,0,171)
			},
			FireRate = 3400,
			Sounds = {
				shoot = "WAC/b29/b29_shoot.wav",
				stop = "WAC/b29/b29_stop.wav",
			},
			TkAmmo = 0,
			Ammo = 1
		}
	}
}

ENT.WeaponAttachments={
	gun = {
		model = "models/gredwitch/b29/b29_turrets.mdl",
		pos = Vector(-79,0,176),
		restrictPitch = true,
	}
	
}

ENT.Camera = {
	model = "models/mm1/box.mdl",
	pos = Vector(-78,0,176),
	offset = Vector(0,0,0),
	viewPos = Vector(20,0,10),
	minAng = Angle(-60, -360,0),
	maxAng = Angle(25, 360,0),
	seat = 4
}

ENT.Sounds={
	Start="wac/b17g/startup.wav",
	Blades="wac/b17g/exterior.wav",
	Engine="radio/american.wav",
	MissileAlert="",
	MinorAlarm="wac/b17g/minor.wav",
	LowHealth="wac/b17g/low.wav",
	CrashAlarm="wac/b17g/crash.wav"
}
