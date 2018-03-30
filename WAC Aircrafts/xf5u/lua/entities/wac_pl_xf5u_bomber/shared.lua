if not wac then return end
if SERVER then AddCSLuaFile('shared.lua') end


ENT.Base 					= "wac_pl_base"
ENT.Type 					= "anim"
ENT.Category				= "Gredwitch's Stuff"
ENT.PrintName				= "[WAC]Vought XF5U Flying Pancake (Bomber)"
ENT.Author					= "Gredwitch"
ENT.Spawnable				= true
ENT.AdminSpawnable			= true
ENT.Model	   				= "models/gredwitch/xf5u/XF5U.mdl"
ENT.RotorPhModel        	= "models/props_junk/sawblade001a.mdl"
ENT.RotorModel        		= "models/gredwitch/xf5u/xf5u_leftrotor.mdl"
ENT.OtherRotorModel			= "models/gredwitch/xf5u/xf5u_rightrotor.mdl"
ENT.rotorPos				= Vector(84,121,1)
ENT.OtherRotorPos 			= Vector(84,-121,1)
ENT.OtherRotorDir			= 1.0
ENT.AutomaticFrameAdvance 	= true
ENT.EngineForce				= 723
ENT.Weight	   				= 6000
ENT.Engines = 2
ENT.AngBrakeMul				= 0.02
ENT.SmokePos				= ENT.rotorPos
ENT.FirePos	    			= ENT.rotorPos

if CLIENT then
	ENT.thirdPerson = {
		distance = 500
	}
end

ENT.Agility = {
	Thrust = 20
}

ENT.Wheels={
	{
		mdl="models/gredwitch/xf5u/XF5U_bw.mdl",
		pos=Vector(-165,0,-30),
		friction=10,
		mass=600,
	},
	{
		mdl="models/gredwitch/xf5u/XF5U_lw.mdl",
		pos=Vector(-2,95,-76),
		friction=10,
		mass=300,
	},
	{
		mdl="models/gredwitch/xf5u/XF5U_rw.mdl",
		pos=Vector(-2,-95,-76),
		friction=10,
		mass=300,
	},
}

ENT.Seats = {
	{
		pos=Vector(45,0,-5),
		exit=Vector(100,-50,0),
		weapons={"M2 Browning","500Lb bombs"}
	}
}

ENT.Weapons = {
	["M2 Browning"] = {
		class = "wac_pod_mg",
		info = {
			Pods = {
				Vector(100,-23,0),
				Vector(100,23,0),
				
				Vector(100,-23,-7),
				Vector(100,23,-7),
				
				Vector(100,-23,-14),
				Vector(100,23,-14),
			},
			Sounds = {
				shoot = "wac/fsx/seafire/hispano_fire.wav",
				stop = "wac/fsx/seafire/hispano_stop.wav",
			},
			Sequential = false,
			Ammo = 600,
			FireRate = 500
		}
	},
	["500Lb bombs"] = {
		class = "wac_pod_gbomb",
		info = {
			Pods = {
				Vector(-15,25,-28),
				Vector(-15,-25,-28),
			},
			Sequential = true,
			Kind = "gb_bomb_500gp",
			FireRate = 100
		}
	}
}

ENT.Sounds={
	Start="wac/fsx/f82/Start.wav",
	Blades="wac/fsx/f82/external.wav",
	Engine="radio/american.wav",
	MissileAlert="",
	MissileShoot="",
	MinorAlarm="wac/fsx/seafire/minor.wav",
	LowHealth="wac/fsx/seafire/low.wav",
	CrashAlarm="wac/fsx/seafire/crash.wav"
}