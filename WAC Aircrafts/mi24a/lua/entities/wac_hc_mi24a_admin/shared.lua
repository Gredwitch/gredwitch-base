
ENT.Base = "wac_hc_base"
ENT.Type = "anim"
ENT.Author = wac.author
ENT.Category = "Gredwitch's Stuff"
ENT.Spawnable = true
ENT.AdminSpawnable = true
ENT.PrintName = "[WAC]Mil Mi-24A (Admin)"
ENT.Model = "models/jessev92/rambo/vehicles/mi24_hull.mdl"
ENT.SmokePos = Vector(-80,0,50)
ENT.FirePos = Vector(-50,0,100)
ENT.MaxEnterDistance = 100
ENT.EngineForce	= 80
ENT.Weight = 5580
ENT.MaxEnterDistance = 1000

ENT.TopRotor = {
	pos = Vector(0,0,170),
	model = "models/jessev92/rambo/vehicles/mi24_rotor_top.mdl",
}

ENT.BackRotor = {
	pos = Vector(-377,0,135),
	model = "models/jessev92/rambo/vehicles/mi24_rotor_tail.mdl",
}

ENT.thirdPerson = {
	distance = 600
}

ENT.Seats = {
	{
		pos = Vector(95, 20, 60),		--	Seat position, relative to base entity
		ang = Angle(0,0,0),
		exit = Vector(95,70,0),			--	Seat exit position, relative to base entity
		weapons = {"S-8"}
	},
	{
		pos = Vector(95, -20, 60),			--	Seat position, relative to base entity
		ang = Angle(0,0,0),
		exit = Vector(95,-70,0),			--	Seat exit position, relative to base entity
		weapons = {"A-12.7","9M120"}
	},
	{
		pos = Vector(-20, 22, 60),		--	Seat position, relative to base entity
		ang = Angle(0,0,0),
		exit = Vector(-20,70,0),
	},
	{
		pos = Vector(-20, -22, 60),		--	Seat position, relative to base entity
		ang = Angle(0,0,0),
		exit = Vector(-20,-70,0),
	},
	{
		pos = Vector(60, -20, 60),		--	Seat position, relative to base entity
		ang = Angle(0,90,0),
		exit = Vector(60,-70,0),		--	Seat exit position, relative to base entity
	},
	{
		pos = Vector(60, 20, 60),		--	Seat position, relative to base entity
		ang = Angle(0,-90,0),
		exit = Vector(60,70,0),			--	Seat exit position, relative to base entity
	},
	{
		pos = Vector(30, -20, 60),		--	Seat position, relative to base entity
		ang = Angle(0,90,0),
		exit = Vector(30,-70,0),		--	Seat exit position, relative to base entity
	},
	{
		pos = Vector(30, 20, 60),		--	Seat position, relative to base entity
		ang = Angle(0,-90,0),
		exit = Vector(30,70,0),			--	Seat exit position, relative to base entity
	},
}

ENT.Wheels = {
	{
		mdl=Model( "models/jessev92/rambo/vehicles/mi24_tyres.mdl" ),
		pos=Vector(95,0,8),
		friction=0,
		mass=500,
	},
	{
		mdl=Model( "models/jessev92/rambo/vehicles/mi24_tyres.mdl" ),
		pos=Vector(-78,-47,8),
		friction=0,
		mass=500,
	},
	{
		mdl=Model( "models/jessev92/rambo/vehicles/mi24_tyres.mdl" ),
		pos=Vector(-78,47,8),
		friction=0,
		mass=500,
	},
}



ENT.Weapons = {
	["A-12.7"] = {
		class = "wac_pod_gunner",
		info = {
			ShootPos = Vector(120,0,30),
			ShootOffset = Vector(35,0,30),
			FireRate = 1000,
			Ammo = 1,
			TkAmmo = 0,
			TracerColor = "Green",
			Sounds = {
				spin = "",
				shoot1p = "WAC/cannon/havoc_cannon_1p.wav",
				shoot3p = "WAC/cannon/havoc_cannon_3p.wav"
			}
		}
	},
	["S-8"] = {
		class = "wac_pod_grocket",
		info = {
			Pods = {
				Vector(0, 78, 45),		--	Location of pod, relative to parent
				Vector(0, 113, 32.93),	--	Location of pod, relative to parent
				Vector(0, -78, 45),		--	Location of pod, relative to parent
				Vector(0, -113, 32.93),	--	Location of pod, relative to parent
			},
			Ammo = 1,
			TkAmmo = 0,
			FireRate = 300,
		}
	},
	["9M120"] = {
		class = "wac_pod_mis",
		info = {
			Pods = {
				Vector(50, 120, 40),	--	Location of pod, relative to parent
				Vector(50, -120, 40),	--	Location of pod, relative to parent
				Vector(50, 140, 40),	--	Location of pod, relative to parent
				Vector(50, -140, 40),	--	Location of pod, relative to parent
			},
			Firerate = 300,
			Ammo = 1,
			TkAmmo = 0,
		}
	}
}
ENT.WeaponAttachments={

	gunMount1 = {
		model = "models/props_junk/garbage_metalcan002a.mdl",
		pos = Vector(120,0,40),
		restrictPitch = true,
	},
	
	gun1 = {
		model = "models/jessev92/rambo/vehicles/mi24_cannon_pipe.mdl",
		pos = Vector(120,0,30),
		localTo = "gunMount1",
		restrictPitch = false,
	},--[[
	gun2 = {
		model = "models/weapons/HueyM60/m60.mdl",
		pos = Vector(-15,40,75),
		restrictPitch = true,
	},
	gun3 = {
		model = "models/weapons/HueyM60/m60.mdl",
		pos = Vector(-15,-40,75),
		restrictPitch = true,
	},--]]
	
}--[[
ENT.Turrets = {
	["M60Left"] = {
		pods = {
			["turret"] = {
				["gun"] = {
					model = "models/weapons/HueyM60/m60.mdl",
					pos = Vector(-15,40,75),
					offset = Vector(0,0,0),
					angle = Angle(0,0,0),
					pitch = true,
					yaw = true,
					limit = true
				},
			},
		},
		info = {
			viewPos = Vector(-14.5,40,83),
			viewOffset = Vector(-10,0,15),
			ang = Angle(0,0,0),
			maxAng = Angle(30, 85, 0),--maxdown, max left
			minAng = Angle(-10, 10, 0),--maxup, max right
			seat = 3
		}
	},
	["M60Right"] = {
		pods = {
			["turret"] = {
				["gun"] = {
					model = "models/weapons/HueyM60/m60.mdl",
					pos = Vector(-15,-40,75),
					offset = Vector(0,0,0),
					angle = Angle(0,0,0),
					pitch = true,
					yaw = true,
					limit = true
				},
			},
		},
		info = {
			viewPos = Vector(-14.5,-40,83),
			viewOffset = Vector(-10,0,15),
			ang = Angle(0,0,0),
			maxAng = Angle(30, 10, 0),--maxdown, max left
			minAng = Angle(-10, -85, 0),--maxup, max right
			seat = 4
		}
	},
}
--]]

ENT.Sounds = {
	Start = "WAC/Heli/ah1_start.wav",
	Blades = "npc/attack_helicopter/aheli_rotor_loop1.wav",
	Engine = "WAC/heli/bellinternal.wav",
	MissileAlert = "HelicopterVehicle/MissileNearby.mp3",
	MissileShoot = "HelicopterVehicle/MissileShoot.mp3",
	MinorAlarm = "HelicopterVehicle/MinorAlarm.mp3",
	LowHealth = "HelicopterVehicle/LowHealth.mp3",
	CrashAlarm = "HelicopterVehicle/CrashAlarm.mp3",
}


ENT.Camera = {
	model = "models/mm1/box.mdl",
	pos = Vector(145,0,30),
	offset = Vector(1,0,0),
	viewPos = Vector(7, 0, 3.5),
	maxAng = Angle(50, 90, 0),
	minAng = Angle(-5, -90, 0),
	seat = 2
}
