if not wac then return end

ENT.Base 				= "wac_pl_base"
ENT.Type 				= "anim"
ENT.PrintName			= "[WAC]Douglas C-47 Skytrain"
ENT.Author				= "Gredwitch"
ENT.Category			= "Gredwitch's Stuff"
ENT.Spawnable			= true
ENT.AdminSpawnable	= true
ENT.MaxEnterDistance = 500
ENT.Model			= "models/gredwitch/c47/c47.mdl"
ENT.RotorPhModel	= "models/props_junk/sawblade001a.mdl"
ENT.RotorModel		= "models/gredwitch/c47/c47_prop.mdl"
ENT.OtherRotorModel		= ENT.RotorModel
ENT.rotorPos	= Vector(118,-117,-31)
ENT.OtherRotorPos = Vector(118,117,-31)
ENT.EngineForce	= 2000
ENT.Weight		= 6000
ENT.SmokePos		= ENT.rotorPos
ENT.FirePos		= ENT.SmokePos
ENT.Engines = 2
ENT.OtherRotorDir = -1

ENT.thirdPerson = {
	distance = 1200
}
ENT.Wheels={
	{
		mdl="models/gredwitch/c47/c47_wr.mdl",
		pos=Vector(13,-117,-100),
		friction=20,
		mass=200,
	},
	{
		mdl="models/gredwitch/c47/c47_wl.mdl",
		pos=Vector(13,117,-100),
		friction=20,
		mass=200,
	},
	{
		mdl="models/gredwitch/c47/c47_wb.mdl",
		pos=Vector(-436,0,-14),
		friction=20,
		mass=200,
	},
}

ENT.Agility = {
	Thrust = 18
}

ENT.Seats = {
	{
		pos=Vector(161,17,0),
		exit=Vector(161,100,0),
		--weapons={"Door opened"}
	},
	{
		pos=Vector(161,-17,0),
		exit=Vector(161,100,0),
	},
	
	----------Passengers
	
	{
		pos=Vector(34,33,4),
		ang=Angle(0,-90,0),
		exit=Vector(-238,70,-50),
	},
	{
		pos=Vector(34,-33,4),
		ang=Angle(0,90,0),
		exit=Vector(-238,70,-50),
	},
	{
		pos=Vector(11,33,4),
		ang=Angle(0,-90,0),
		exit=Vector(-238,70,-50),
	},
	{
		pos=Vector(11,-33,4),
		ang=Angle(0,90,0),
		exit=Vector(-238,70,-50),
	},
	{
		pos=Vector(-12,33,4),
		ang=Angle(0,-90,0),
		exit=Vector(-238,70,-50),
	},
	{
		pos=Vector(-12,-33,4),
		ang=Angle(0,90,0),
		exit=Vector(-238,70,-50),
	},
	{
		pos=Vector(-35,33,4),
		ang=Angle(0,-90,0),
		exit=Vector(-238,70,-50),
	},
	{
		pos=Vector(-35,-33,4),
		ang=Angle(0,90,0),
		exit=Vector(-238,70,-50),
	},
	{
		pos=Vector(-58,33,4),
		ang=Angle(0,-90,0),
		exit=Vector(-238,70,-50),
	},
	{
		pos=Vector(-58,-33,4),
		ang=Angle(0,90,0),
		exit=Vector(-238,70,-50),
	},
	{
		pos=Vector(-81,33,4),
		ang=Angle(0,-90,0),
		exit=Vector(-238,70,-50),
	},
	{
		pos=Vector(-81,-33,4),
		ang=Angle(0,90,0),
		exit=Vector(-238,70,-50),
	},
	{
		pos=Vector(-104,33,4),
		ang=Angle(0,-90,0),
		exit=Vector(-238,70,-50),
	},
	{
		pos=Vector(-104,-33,4),
		ang=Angle(0,90,0),
		exit=Vector(-238,70,-50),
	},
	{
		pos=Vector(-127,33,4),
		ang=Angle(0,-90,0),
		exit=Vector(-238,70,-50),
	},
	{
		pos=Vector(-127,-33,4),
		ang=Angle(0,90,0),
		exit=Vector(-238,70,-50),
	},
	{
		pos=Vector(-150,33,4),
		ang=Angle(0,-90,0),
		exit=Vector(-238,70,-50),
	},
	{
		pos=Vector(-150,-33,4),
		ang=Angle(0,90,0),
		exit=Vector(-238,70,-50),
	},
	
}

--[[
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
--]]
ENT.Sounds={
	Start="WAC/fh2_ju52/start.wav",
	Blades="WAC/fh2_ju52/external.wav",
	Engine="radio/american.wav",
	MissileAlert="HelicopterVehicle/MissileNearby.mp3",
	MissileShoot="HelicopterVehicle/MissileShoot.mp3",
	MinorAlarm="HelicopterVehicle/MinorAlarm.mp3",
	LowHealth="HelicopterVehicle/LowHealth.mp3",
	CrashAlarm="HelicopterVehicle/CrashAlarm.mp3",
}
