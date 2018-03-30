if not wac then return end
if SERVER then AddCSLuaFile('shared.lua') end
ENT.Base 				= "wac_pl_base"
ENT.Type 				= "anim"
ENT.Category			= "Gredwitch's Stuff"
ENT.PrintName			= "[WAC]SPAD S.XIII (Admin)"
ENT.Author				= "Vought"

ENT.Spawnable			= true
ENT.AdminSpawnable		= true

ENT.Model	  	  		= "models/gredwitch/spad/spad_xiii.mdl"
ENT.RotorPhModel		= "models/props_junk/sawblade001a.mdl"
ENT.RotorModel			= "models/gredwitch/spad/spad_xiii_prop.mdl"

ENT.rotorPos			= Vector(0,0,0)
ENT.TopRotorDir			= 1

ENT.EngineForce			= 180
ENT.Weight	    		= 2510
ENT.SeatSwitcherPos		= Vector(0,0,0)
ENT.AngBrakeMul			= 0.015
ENT.SmokePos			= Vector(81,0,0)
ENT.FirePos	    		= ENT.SmokePos

if CLIENT then
	ENT.thirdPerson = {
		distance = 600
	}
end

ENT.Agility = {
	Thrust = 10
}

ENT.Wheels={
	{
		mdl="models/gredwitch/spad/spad_xiii_wheel.mdl",
		pos=Vector(25,-55,-76 ),
		friction=0,
		mass=100,
	},
	{
		mdl="models/gredwitch/spad/spad_xiii_wheel.mdl",
		pos=Vector(25,55,-76 ),
		friction=0,
		mass=100,
	},
	{
		mdl="models/cessna/cessna172_nwheel.mdl",
		pos=Vector(-238,0,-22),
		friction=5,
		mass=200,
	}
}

ENT.Seats = {
	{
		pos=Vector(-50,0,5),
		exit=Vector(-80,80,80),
		weapons={"Dual MGs"}
	}
}

ENT.Weapons = {
	["Dual MGs"] = {
		class = "wac_pod_mg",
		info = {
			Pods = {
				Vector(80,-5.426,20),
				Vector(80,5.426,20)
			},
			Sounds = {
				shoot = "WAC/Spitfire/gun.wav",
				stop = "WAC/Spitfire/gun_stop.wav",
			},
			BulletType = "wac_base_7mm",
			Sequential = false,
			FireRate = 500,
			TkAmmo = 0,
			Ammo = 1000
		}
	},
}

ENT.Sounds={
	Start="wac/sbu1/start.wav",
	Blades="wac/sbu1/external.wav",
	Engine="wac/sbu1/internal.wav",
	MissileAlert="",
	MissileShoot="",
	MinorAlarm="wac/sbu1/low.wav",
	LowHealth="wac/sbu1/minor.wav",
	CrashAlarm="wac/sbu1/crash.wav"
}


function ENT:DrawPilotHud() end
function ENT:DrawWeaponSelection() end