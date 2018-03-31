if not wac then return end
ENT.Base = "wac_pl_base"
ENT.Type = "anim"
ENT.Category = "Gredwitch's Stuff"
ENT.Spawnable = true
ENT.AdminSpawnable = true
ENT.PrintName = "[WAC]B-25J Mitchell (No bombs)"
ENT.Model				= "models/gredwitch/b25j/b25j.mdl"
ENT.RotorPhModel		= "models/props_junk/sawblade001a.mdl"
ENT.RotorModel			= "models/gredwitch/b25j/b25j_prop.mdl"
ENT.OtherRotorModel		= ENT.RotorModel
ENT.AutomaticFrameAdvance = true
ENT.Weight			= 6000
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
		pos=Vector(70,-119,-20),
		friction=10,
		mass=200,
	},
	{
		mdl="models/gredwitch/b25j/b25j_wl.mdl",
		pos=Vector(70,117,-20),
		friction=10,
		mass=200,
	},
	{
		mdl="models/gredwitch/b25j/b25j_wb.mdl",
		pos=Vector(210,0,-20),
		friction=10,
		mass=5000,
	},
}

ENT.Weapons = {
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
				shoot = "wac/ju88/shoot.wav",
				stop = "wac/ju88/stop.wav",
			},
			Sequential = false,
			Ammo = 2700,
			FireRate = 850,
		}
	}
}

ENT.Seats = {
	{
		pos=Vector(226,14.14,67.85),
		exit=Vector(226,100,40),
		weapons={"Front M2 Brownings"}
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
		pos=Vector(144,0,95),
		ang=Angle(0,180,0),
		exit=Vector(144,100,40),
	}
}

ENT.Sounds={
	Start="wac/ju88/start.wav",
	Blades="wac/ju88/external.wav",
	Engine="radio/american.wav",
	MissileAlert="",
	MissileShoot="",
	MinorAlarm="",
	LowHealth="",
	CrashAlarm="",
}