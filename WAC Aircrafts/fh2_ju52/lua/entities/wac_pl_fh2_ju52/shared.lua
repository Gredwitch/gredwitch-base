if not wac then return end

ENT.Base 				= "wac_pl_base"
ENT.Type 				= "anim"
ENT.PrintName			= "[WAC]Better Junkers Ju 52"
ENT.Author				= "Gredwitch"
ENT.Category			= "Gredwitch's Stuff"
ENT.Spawnable			= true
ENT.AdminSpawnable	= true
ENT.MaxEnterDistance = 500
ENT.Model			= "models/gredwitch/fh2_ju52/ju52.mdl"
ENT.RotorPhModel	= "models/props_junk/sawblade001a.mdl"
ENT.RotorModel		= "models/gredwitch/fh2_ju52/ju52_mprop.mdl"
ENT.rotorPos	= Vector(304.4,0,9.7)
ENT.EngineForce	= 2000
ENT.Weight		= 6000
ENT.SmokePos		= ENT.rotorPos
ENT.FirePos		= ENT.SmokePos
ENT.Engines = 3

ENT.OtherRotorPos={
	Vector(187,179.5,-23),
	Vector(187,-179.5,-23),
}
ENT.thirdPerson = {
	distance = 1200
}
ENT.Wheels={
	{
		mdl="models/gredwitch/fh2_ju52/ju52_wr.mdl",
		pos=Vector(54.7,-91.4,-116),
		friction=20,
		mass=200,
	},
	{
		mdl="models/gredwitch/fh2_ju52/ju52_wl.mdl",
		pos=Vector(54.7,91.4,-116),
		friction=20,
		mass=200,
	},
	{
		mdl="models/gredwitch/fh2_ju52/ju52_wb.mdl",
		pos=Vector(-602,3,0,-15),
		friction=20,
		mass=400,
	},
}

ENT.Agility = {
	Thrust = 18
}

ENT.Seats = {
	{
		pos=Vector(152,27,30),
		exit=Vector(152,27,30),
		weapons={"Door opened"}
	},
	{
		pos=Vector(152,-27,30),
		exit=Vector(152,27,30),
	},
	
	
	----------Passengers
	
	
	{
		pos=Vector(35,-27,14),
		ang=Angle(0,90,0),
		exit=Vector(-175,70,6),
	},
	{
		pos=Vector(35,27,14),
		ang=Angle(0,-90,0),
		exit=Vector(-175,70,6),
	},
	
	{
		pos=Vector(10,-27,14),
		ang=Angle(0,90,0),
		exit=Vector(-175,70,6),
	},
	{
		pos=Vector(10,27,14),
		ang=Angle(0,-90,0),
		exit=Vector(-175,70,6),
	},
	
	{
		pos=Vector(-15,-27,14),
		ang=Angle(0,90,0),
		exit=Vector(-175,70,6),
	},
	{
		pos=Vector(-15,27,14),
		ang=Angle(0,-90,0),
		exit=Vector(-175,70,6),
	},
	
	{
		pos=Vector(-30,-27,14),
		ang=Angle(0,90,0),
		exit=Vector(-175,70,6),
	},
	{
		pos=Vector(-30,27,14),
		ang=Angle(0,-90,0),
		exit=Vector(-175,70,6),
	},
	
	{
		pos=Vector(-55,-27,14),
		ang=Angle(0,90,0),
		exit=Vector(-175,70,6),
	},
	{
		pos=Vector(-55,27,14),
		ang=Angle(0,-90,0),
		exit=Vector(-175,70,6),
	},
}


ENT.Weapons = {
	["Door opened"] = {
		class = "wac_pod_gatling",
		info = {
			Pods = {
				Vector(0,0,0),
			},
			Ammo = 0,
			Sequential = true,
			FireRate = 0
		}
	}
}

ENT.Sounds={
	Start="WAC/fh2_ju52/start.wav",
	Blades="WAC/fh2_ju52/external.wav",
	Engine="radio/german.wav",
	MissileAlert="HelicopterVehicle/MissileNearby.mp3",
	MissileShoot="HelicopterVehicle/MissileShoot.mp3",
	MinorAlarm="HelicopterVehicle/MinorAlarm.mp3",
	LowHealth="HelicopterVehicle/LowHealth.mp3",
	CrashAlarm="HelicopterVehicle/CrashAlarm.mp3",
}
