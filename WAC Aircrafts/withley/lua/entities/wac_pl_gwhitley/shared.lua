if not wac then return end
ENT.Base = "wac_pl_base"
ENT.Type = "anim"
ENT.Category = "Gredwitch's Stuff"
ENT.Spawnable = true
ENT.AdminSpawnable = true

ENT.PrintName = "[WAC]Whitley Mk V"

ENT.Engines = 2
ENT.Model				= "models/wac/fsx/whitley.mdl"
ENT.RotorPhModel		= "models/props_junk/sawblade001a.mdl"
ENT.RotorModel			= "models/wac/fsx/whitley_prop.mdl"
ENT.OtherRotorModel		= "models/wac/fsx/whitley_prop.mdl"

ENT.rotorPos 	= Vector(175.717,-112.756,-0.031)
ENT.OtherRotorPos = Vector(175.717,112.756,-0.031)
ENT.OtherRotorDir = -1

ENT.FirePos			= ENT.rotorPos
ENT.SmokePos		= ENT.rotorPos
ENT.AutomaticFrameAdvance = true

ENT.Weight			= 15200
ENT.EngineForce		= 200

ENT.Agility = {
	Thrust = 12
}

ENT.Wheels={
	{
		mdl="models/wac/fsx/whitley_front.mdl",
		pos=Vector(55.602,0,-79.414),
		friction=0,
		mass=2000,
	},
	{
		mdl="models/wac/fsx/whitley_back.mdl",
		pos=Vector(-437.25,0,-64.428),
		friction=0,
		mass=1000,
	},
}

ENT.Seats = {
	{
		pos=Vector(134,14,0),
		exit=Vector(200,100,50),
		weapons = {"Vickers K", "250lb GP", "500lb GP", "2000lb GP"},
	},
	{
		pos=Vector(134,-14,0),
		exit=Vector(200,-100,50),
	},
	{
		pos=Vector(87,14,0),
		exit=Vector(100,-100,50),
	},
	{
		pos=Vector(210,0,-10),
		exit=Vector(300,150,75),
	},
	{
		pos=Vector(-563,0,-27),
		exit=Vector(-600,0,0),
		weapons = {"Browning turret"}
	}
}

ENT.Weapons = {
	["Vickers K"] = {
		class = "wac_pod_mg",
		info = {
			Pods = {
				Vector(263,-10.551,7.868)
			},
			FireRate = 950,
			Ammo = 2500,
			Sounds = {
				shoot = "wac/fsx/whitley/vickers_fire.wav",
				stop = "wac/fsx/whitley/shoot_stop.wav",
			}
		}
	},
	["250lb GP"] = {
		class = "wac_pod_gbomb",
		info = {
			Pods = {
				Vector(-40.0,300.0,-22.0),
				Vector(-40.0,-300.0,-22.0),
				Vector(-40.0,320.0,-22.0),
				Vector(-40.0,-320.0,-22.0),
				Vector(-40.0,340.0,-22.0),
				Vector(-40.0,-340.0,-22.0),
				Vector(-40.0,360.0,-22.0),
				Vector(-40.0,-360.0,-22.0),
				Vector(-40.0,380.0,-22.0),
				Vector(-40.0,-380.0,-22.0),
				Vector(-40.0,400.0,-22.0),
				Vector(-40.0,-400.0,-22.0)
			},
			Kind = "gb_bomb_250gp",
			Sounds = {
			    fire = "bomb/bomb_whistle_0"..math.random(1,4)..".wav"
			},
		}
	},
	["500lb GP"] = {
		class = "wac_pod_gbomb",
		info = {
			Pods = {
				Vector(-41.0,60.0,-42.0),
				Vector(-41.0,-60.0,-42.0),
			},
			Kind = "gb_bomb_500gp",
			FireRate = 100,
			Sounds = {
			    fire = "bomb/bomb_whistle_0"..math.random(1,4)..".wav"
			},
		}
	},
	["2000lb GP"] = {
		class = "wac_pod_gbomb",
		info = {
			Kind = "gb_bomb_2000gp",
			Pods = {
				Vector(-10,15,-30),
				Vector(-10,-15,-30),
			},
			FireRate = 50,
			Sounds = {
			    fire = "bomb/bomb_whistle_0"..math.random(1,4)..".wav"
			},
		}
	},
	["Browning turret"] = {
		class = "wac_pod_gunner",
		info = {
			ShootPos = Vector(-553.133,0,-3.897),
			ShootOffset = Vector(36, 0, 0),
			FireRate = 1020,
			Ammo = 1020,
			Sounds = {
				shoot3p = "",
				shoot1p = "",
				spin = "wac/fsx/whitley/m1919_fire.wav",
			}
		}
	}
}

ENT.WeaponAttachments={

	gunMount1 = {
		model = "models/wac/fsx/whitley_turret.mdl",
		pos = Vector(-562.734,0,-26.898),
		restrictPitch = true,
	},
	
	gunMount2 = {
		model = "models/wac/fsx/whitley_gun.mdl",
		pos = Vector(-562.734,0,-3.897),
		localTo = "gunMount1",
	},
	
	gun = {
		model = "models/mm1/box.mdl",
		pos = Vector(-562.734,0,-26.898),
		localTo = "gunMount2",
	},
	
	radar1 = {
		model = "models/mm1/box.mdl",
		pos = Vector(-562.734,0.157,-26.898),
		restrictPitch = true,
	},
	
}

ENT.Camera = {
	model = "models/mm1/box.mdl",
	pos = Vector(-562.734,0,-3.897),
	offset = Vector(0,0,0),
	viewPos = Vector(10, 0, 10),
	minAng = Angle(-60, -360,0),
	maxAng = Angle(25, 360,0),
	seat = 5
}

ENT.Sounds={
	Start="wac/fsx/whitley/start.wav",
	Blades="wac/fsx/whitley/external.wav",
	Engine="wac/fsx/whitley/internal.wav",
	MissileAlert="",
	MissileShoot="",
	MinorAlarm="",
	LowHealth="",
	CrashAlarm="",
}