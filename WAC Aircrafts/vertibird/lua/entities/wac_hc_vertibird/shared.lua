
ENT.Base		    = "wac_hc_base"
ENT.Type 			= "anim"
ENT.Author		    = wac.author
ENT.Category 		= "Gredwitch's Stuff"
ENT.Spawnable	    = true
ENT.AdminSpawnable  = true
ENT.Category		= "Gredwitch's Stuff"
ENT.PrintName	    = "[WAC]VB-02 Vertibird"
ENT.Model 			= "models/fallout_4/vehicles/vertibird01.mdl"
ENT.EngineForce	    = 60
ENT.Weight 			= 17032
ENT.SmokePos 		= Vector(-90,0,50)
ENT.FirePos 		= Vector(-50,0,100)
ENT.MaxEnterDistance = 1000
ENT.thirdPerson = {
	distance = 1200
}

ENT.TopRotor = {
	dir = -1,
	model = "models/fallout_4/vehicles/vertibird01_rotor.mdl",
	pos = Vector(16.026,318.299,366.083),
}

ENT.TopRotor2 = {
	dir = 1,
	angles = Angle(0,0,0),
	model = "models/fallout_4/vehicles/vertibird01_rotor.mdl",
	pos = Vector(16.026,-318.299,366.083), 
}
ENT.BackRotor = {
	dir = 1,
	pos = Vector(-400,0,300),
	model = "models/props_junk/PopCan01a.mdl"
}

ENT.Wheels = {
	{
		mdl = "models/fallout_4/vehicles/vertibird01_wheel.mdl",
		pos = Vector(-82.706,46.3,20.091),
		friction = 0,
		mass = 350,
	},
	{
		mdl = "models/fallout_4/vehicles/vertibird01_wheel.mdl",
		pos = Vector(-82.706,-47.3,20.091),
		friction = 0,
		mass = 350,
	},
	{
		mdl = "models/fallout_4/vehicles/vertibird01_wheel.mdl",
		pos = Vector(-187.529,0,20.837),
		friction = 0,
		mass = 350,
	},
	{
		mdl = "models/fallout_4/vehicles/vertibird01_wheel.mdl",
		pos = Vector(213.72,0,20.56),
		friction = 0,
		mass = 350,
	}
}

ENT.Seats = {
	{
		pos=Vector(190.391, 37.694, 135.253 - 5),
		exit=Vector(135.075,37.482,106.051),
		weapons = {"GUNS"},
	},
	{
		pos=Vector(189.993, -35.857, 135.248 - 5),
		exit=Vector(135.075,-39.731,106.051),
	},
	{
		pos=Vector(46.583, -0.963, 104.456 - 5),
		exit=Vector(90.946,5.895,99.092),
	},


	{
		pos = Vector(33.336, 70.102, 85.36 - 5),
		exit = Vector(33.336, 70.102, 85.36),
		ang = Angle(0,90,0),
	},
	{
		pos = Vector(81.625, 70.102, 85.36 - 5),
		exit = Vector(33.336, 70.102, 85.36),
		ang = Angle(0,90,0),
	},
	{
		pos = Vector(114.59 , -68.49, 85.36 - 5),
		exit = Vector(114.59 , -68.49, 85.36),
		ang = Angle(0,-90,0),
	},
	{
		pos = Vector(33.625, -68.49, 85.36 - 5),
		exit = Vector(33.336, -68.49, 85.36),
		ang = Angle(0,-90,0),
	},
}

ENT.Weapons = {
	["GUNS"] = {
		class = "wac_pod_mg",
		info = {
			Pods = {
				Vector(283.765,63.487,81.878),
				Vector(283.765,-62.573,81.878)
			},
			Sounds = {
				shoot = "warkanum/minigun_shoot.wav",
				stop = "warkanum/minigun_wind_stop.wav"
			},
			Ammo = 2300,
			Sequential = true,
			FireRate = 3000
		}
	}
}

ENT.Sounds = {
	Start = "fx/obj/vertibird/OBJ_Vertibird_Engine_Start_01_3D.mp3",
	Blades = "fx/obj/vertibird/OBJ_Vertibird_Engine_A_2D_01_LP.wav",
	Engine = "fx/obj/vertibird/OBJ_Vertibird_Engine_A_3D_01_LP.wav",
	MissileAlert = "helicoptervehicle/missilenearby.mp3",
	MinorAlarm = "helicoptervehicle/minoralarm.mp3",
	LowHealth = "helicoptervehicle/lowhealth.mp3",
	CrashAlarm = "helicoptervehicle/crashalarm.mp3",
}