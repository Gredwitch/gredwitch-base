if not wac then return end
if SERVER then AddCSLuaFile('shared.lua') end
ENT.Base = "wac_hc_base"
ENT.Type = "anim"
ENT.Author = "Gredwitch"
ENT.Category = "Gredwitch's Stuff"
ENT.Spawnable = true
ENT.AdminSpawnable = true
ENT.PrintName		= "[WAC]Harbin WZ-19"
ENT.Model			= "models/wz-19/wz-19.mdl"
ENT.RotorPhModel	= "models/props_junk/sawblade001a.mdl"
ENT.FirePos			= Vector(-53,-12,175)
ENT.SmokePos		= ENT.FirePos
ENT.EngineForce = 70 
ENT.Weight = 4000
ENT.MaxEnterDistance = 100

ENT.thirdPerson = {
	distance = 700
}
ENT.TopRotor = {
	dir = -1,
	pos = Vector(-53,-12,175),
	model = "models/jessev92/apacheairass/vehicles/mi35_rotor_main.mdl"
}

ENT.BackRotor = {
	dir = -1,
	pos = Vector(-470, 5, 152),
	model = "models/jessev92/apacheairass/vehicles/mi35_rotor_tail.mdl"
}

ENT.Wheels = {
	{
		mdl=Model( "models/jessev92/apacheairass/vehicles/mi35_tyre_front.mdl"),
		pos=Vector(48,-10,-10),
		friction=10,
		mass=800
	},
	{
		mdl=Model( "models/jessev92/apacheairass/vehicles/mi35_tyre_rear.mdl" ),
		pos=Vector(-120,50,-1),
		friction=10,
		mass=400
	},
	{
		mdl=Model( "models/jessev92/apacheairass/vehicles/mi35_tyre_rear.mdl" ),
		pos=Vector(-120,-65,-1),
		friction=10,
		mass=400
	}
}
ENT.Seats = {
	{
		pos = Vector(73, -12, 39),
		exit = Vector(72,100,0),
		weapons = {"HJ-8"}
	},
	{
		pos = Vector(130, -12, 19),
		exit = Vector(120,100,0),
		weapons = {"23mm cannon"}
	},
	------------------------------
	{
		pos = Vector(-4, -2, 35),
		ang=Angle(0,90,0),
		exit = Vector(0,150,0),
	},
	{
		pos = Vector(-30, -2, 35),
		ang=Angle(0,90,0),
		exit = Vector(0,150,0),
	},
	{
		pos = Vector(-56, -2, 35),
		ang=Angle(0,90,0),
		exit = Vector(0,150,0),
	},
	
	------------------------------
	{
		pos = Vector(-4, -15,35),
		ang=Angle(0,-90,0),
		exit = Vector(0,-150,0),
	},
	{
		pos = Vector(-26, -15, 35),
		ang=Angle(0,-90,0),
		exit = Vector(0,-150,0),
	},
	{
		pos = Vector(-52, -15, 35),
		ang=Angle(0,-90,0),
		exit = Vector(0,-150,0),
	},
}


ENT.Weapons = {
	["HJ-8"] = {
		class = "wac_pod_grocket",
		info = {
			Sequential = true,
			Ammo = 28,
			Pods = {
				Vector(40.25, 36.33, 32.93),
				Vector(40.25, -36.33, 32.93)
			}
		}
	},
	["23mm cannon"] = {
		class = "wac_pod_gunner",
		info = {
			Ammo = 800,
			FireRate = 600,
			BulletType = "wac_base_20mm",
			TracerColor = "Green",
			ShootPos = Vector(148, 0, 0),
			ShootOffset = Vector(60, 0, 0),
		}
	}
}

ENT.Camera = {
	model = "models/mm1/box.mdl",
	pos = Vector(220, -11, 0),
	offset = Vector(-1,0,0),
	viewPos = Vector(2, 0, 3.5),
	maxAng = Angle(45, 90, 0),
	minAng = Angle(-2, -90, 0),
	seat = 2
}

ENT.WeaponAttachments = {

	gunMount1 = {
		model = "models/bf2/helicopters/ah-1 cobra/ah1z_g1.mdl",
		pos = Vector(148,-11,10),
		restrictPitch = true
	},

	gun = {
		model = "models/bf2/helicopters/ah-1 cobra/ah1z_g.mdl",
		pos = Vector(148,-11,0),
		offset = Vector(2,0,0)
	},

}

ENT.Sounds = {
	Start = "wac/Heli/ah1_start.wav",
	Blades = "npc/attack_helicopter/aheli_rotor_loop1.wav",
	Engine = "wac/heli/bellinternal.wav",
	MissileAlert = "HelicopterVehicle/MissileNearby.mp3",
	MissileShoot = "HelicopterVehicle/MissileShoot.mp3",
	MinorAlarm = "HelicopterVehicle/MinorAlarm.mp3",
	LowHealth = "HelicopterVehicle/LowHealth.mp3",
	CrashAlarm = "HelicopterVehicle/CrashAlarm.mp3",
}