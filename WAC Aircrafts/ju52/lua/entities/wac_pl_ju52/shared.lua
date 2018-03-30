if not wac then return end

ENT.Base 				= "wac_pl_base"
ENT.Type 				= "anim"
ENT.PrintName			= "[WAC]Junkers Ju 52"
ENT.Author				= "Gredwitch"
ENT.Category			= "Gredwitch's Stuff"
ENT.Spawnable			= true
ENT.AdminSpawnable	= true

ENT.Model			= "models/gredwitch/ju52/ju52.mdl"
ENT.RotorPhModel	= "models/props_junk/sawblade001a.mdl"
ENT.RotorModel		= "models/ju52/ju52prop.mdl"
ENT.rotorPos	= Vector(278, 0, 35)
ENT.BackRotorPos	= Vector(8, 0, -48)
ENT.EngineForce	= 2000
ENT.Weight		= 6000
ENT.SmokePos		= ENT.rotorPos
ENT.FirePos		= ENT.SmokePos
ENT.Engines = 3

ENT.OtherRotorPos={
	Vector(211.5,124,20),
	Vector(211.5,-124,20)
}
ENT.thirdPerson = {
	distance = 600
}
ENT.Wheels={
	{
		mdl="models/ju52/ju52lwheel.mdl",
		pos=Vector(142.5,58,-33),
		friction=0,
		mass=1500,
	},
	{
		mdl="models/ju52/ju52rwheel.mdl",
		pos=Vector(142.5,-58,-33),
		friction=0,
		mass=1500,
	},
	{
		mdl="models/ju52/ju52bwheel.mdl",
		pos=Vector(-247,0,35),
		friction=0,
		mass=1000,
	},
}

ENT.Agility = {
	Thrust = 18
}

ENT.Seats = {
	{
		pos=Vector(187.6,14.2,30),
		exit=Vector(195,42,48),
	},
	{
		pos=Vector(187,-12,30),
		exit=Vector(-78,60,-48),
	},
	{
		pos=Vector(-90,0,50),
		ang=Angle(0,-180,0),
		exit=Vector(-78,60,-48),
		weapons={"MG"},
	},
	{
		pos=Vector(129.5,-15,30),
		exit=Vector(-78,60,-48),
	},
	{
		pos=Vector(129.5,15,30),
		exit=Vector(-78,60,-48),
	},
	{
		pos=Vector(101.5,-15,30),
		exit=Vector(-78,60,-48),
	},
	{
		pos=Vector(101.5,15,30),
		exit=Vector(-78,60,-48),
	},
	{
		pos=Vector(73.5,-15,30),
		exit=Vector(-78,60,-48),
	},
	{
		pos=Vector(73.5,15,30),
		exit=Vector(-78,60,-48),
	},
	{
		pos=Vector(45.5,-15,30),
		exit=Vector(-78,60,-48),
	},
	{
		pos=Vector(45.5,15,30),
		exit=Vector(-78,60,-48),
	},
	{
		pos=Vector(45.5,-15,30),
		exit=Vector(-78,60,-48),
	},
	{
		pos=Vector(17.5,15,30),
		exit=Vector(-78,60,-48),
	},
	{
		pos=Vector(17.5,-15,30),
		exit=Vector(-78,60,-48),
	},
}


ENT.Weapons = {
	["MG"] = {
		class = "wac_pod_gunner",
		info = {
			Sounds = {
	            shoot1p = "",
	            shoot3p = "",
            	spin = "wac/ju88/shoot.wav"
            },
			ShootPos = Vector(-90,0,85),
			ShootOffset = Vector(0,0,0),
			Sequential = true,
			BulletType = "wac_base_7mm",
			Ammo = 1000,
			FireRate = 750
		}
	}
}

ENT.Camera = {
	model = "models/mm1/box.mdl",--sentry/rah66_cam.mdl",
	pos = Vector(-90,0,90),
	offset = Vector(0,0,0),
	viewPos = Vector(0, 0, 0),
	minAng = Angle(-180,-180,-180),
	maxAng = Angle(180,180,180),
	seat = 3
}

ENT.Sounds={
	Start="WAC/jenny/start.wav",
	Blades="WAC/jenny/internal.wav",
	Engine="radio/german.wav",
	MissileAlert="HelicopterVehicle/MissileNearby.mp3",
	MissileShoot="HelicopterVehicle/MissileShoot.mp3",
	MinorAlarm="HelicopterVehicle/MinorAlarm.mp3",
	LowHealth="HelicopterVehicle/LowHealth.mp3",
	CrashAlarm="HelicopterVehicle/CrashAlarm.mp3",
}
