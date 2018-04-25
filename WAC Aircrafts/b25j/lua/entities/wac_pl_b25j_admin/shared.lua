if not wac then return end
ENT.Base = "wac_pl_base"
ENT.Type = "anim"
ENT.Category = "Gredwitch's Stuff"
ENT.Spawnable = true
ENT.AdminSpawnable = true
ENT.PrintName = "[WAC]B-25J Mitchell (Admin)"
ENT.Model				= "models/gredwitch/b25j/b25j.mdl"
ENT.RotorPhModel		= "models/props_junk/sawblade001a.mdl"
ENT.RotorModel			= "models/gredwitch/b25j/b25j_prop.mdl"
ENT.OtherRotorModel		= ENT.RotorModel
ENT.AutomaticFrameAdvance = true
ENT.Weight			= 3000
ENT.EngineForce		= 3354
ENT.rotorPos 	= Vector(198,117,60)
ENT.OtherRotorPos = Vector(198,-119,60)
ENT.FirePos			= ENT.rotorPos
ENT.SmokePos		= ENT.rotorPos
ENT.OtherRotorDir = -1
ENT.Engines = 2
ENT.maxEnterDistence = 400

ENT.thirdPerson = {
	distance = 600
}

ENT.Agility = {
	Thrust = 19
}

ENT.Wheels={
	{
		mdl="models/gredwitch/b25j/b25j_wr.mdl",
		pos=Vector(73,-119.5,-7),
		friction=10,
		mass=2000,
	},
	{
		mdl="models/gredwitch/b25j/b25j_wl.mdl",
		pos=Vector(73,117.5,-7),
		friction=10,
		mass=2000,
	},
	{
		mdl="models/gredwitch/b25j/b25j_wb.mdl",
		pos=Vector(264,-2,-20),
		friction=10,
		mass=5000,
	},
}
ENT.Seats = {
	{
		pos=Vector(226,14.43,67.85),
		exit=Vector(226,100,40),
		weapons={"Front M2 Brownings","250LB Bombs"}
	},
	{
		pos=Vector(226,-16,66),
		exit=Vector(226,-100,40),
	},
	{
		pos=Vector(293,-3,50),
		exit=Vector(288,100,40),
	},
	{
		pos=Vector(144,0,92),
		ang=Angle(0,180,0),
		exit=Vector(144,100,40),
		weapons={"Turret M2 Browning"}
	}
}

ENT.Weapons = {
	["250LB Bombs"] = {
		class = "wac_pod_gbomb",
		info = {
			Pods = {
				Vector  (98, 15,35.5),
				Vector  (98, 0 ,35.5),
				Vector  (98,-15,35.5),
			},
			Kind = "gb_bomb_250gp",
			Admin = 1,
		}
	},
	["Front M2 Brownings"] = {
		class = "wac_pod_mg",
		info = {
			Pods = {
				Vector(359,0,61.5),
				Vector(345,-18.5,55),
				Vector(343,-13,45),
				
				Vector(213,-31,62),
				Vector(213,-31,41),
				
				Vector(213,31,62),
				Vector(213,31,41),
			},
			Sounds = {
				shoot = "wac/b-25j/shoot.wav",
				stop = "wac/b-25j/stop.wav",
			},
			Sequential = true,
			Ammo = 1,
			TkAmmo = 0,
			FireRate = 5950,
		}
	},
	["Turret M2 Browning"] = {
		class = "wac_pod_gunner",
		info = {
			ShootPos = Vector(150,0,120),
			ShootOffset = Vector(43,0, 0),
			FireRate = 1700,
			Ammo = 1,
			TkAmmo = 0,
			Sounds = {
			    shoot1p = "",
				shoot3p  = "wac/b-25j/turret_stop.wav",
				spin = "",
			},
		}
	},
}

ENT.WeaponAttachments={

	gunMount1 = {
		model = "models/gredwitch/b25j/b25j_gunpod.mdl",
		pos = Vector(143.3,0,114.3),
		restrictPitch = true,
	},
	
	gun = {
		model = "models/gredwitch/b25j/b25j_gun.mdl",
		pos = Vector(146,0,113.6),
		localTo = "gunMount1",
	},
	
}
ENT.Camera = {
	model = "models/mm1/box.mdl",
	pos = Vector(143,0,135),
	offset = Vector(-1,0,0),
	viewPos = Vector(10, 0, 0),
	minAng = Angle(-160, -180, -180),
	maxAng = Angle(0, 180, 180),
	seat = 4
}
ENT.Sounds={
	Start="wac/b-25j/start.wav",
	Blades="wac/b-25j/external.wav",
	Engine="radio/american.wav",
	MissileAlert="",
	MissileShoot="",
	MinorAlarm="",
	LowHealth="",
	CrashAlarm="",
}