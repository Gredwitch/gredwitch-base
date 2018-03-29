if not wac then return end
if SERVER then AddCSLuaFile('shared.lua') end
ENT.Base 				= "wac_pl_base"
ENT.Type 				= "anim"
ENT.Category			= "Gredwitch's Stuff"
ENT.PrintName			= "[WAC]PZL P.11c (Admin)"
ENT.Author				= "Gredwitch"

ENT.Spawnable			= true
ENT.AdminSpawnable		= true

ENT.Model	    = "models/gredwitch/pzl/pzl.mdl"
ENT.RotorPhModel	= "models/props_junk/sawblade001a.mdl"
ENT.RotorModel	= "models/gredwitch/pzl/pzl_prop.mdl"

ENT.rotorPos	= Vector(115,0,-5)

ENT.EngineForce	= 1180
ENT.Weight	    = 510
ENT.SeatSwitcherPos	= Vector(0,0,0)
ENT.AngBrakeMul	= 0.015
ENT.SmokePos	= ENT.rotorPos
ENT.FirePos	    = ENT.rotorPos

if CLIENT then
	ENT.thirdPerson = {
		distance = 350
	}
end

ENT.Agility = {
	Thrust = 9.3
}

ENT.Wheels={
	{
		mdl="models/gredwitch/pzl/wl.mdl",
		pos=Vector(65,-47,-52),
		friction=10,
		mass=200,
	},
	{
		mdl="models/gredwitch/pzl/wr.mdl",
		pos=Vector(65,47,-52),
		friction=10,
		mass=200,
	},
	{
		mdl="models/cessna/cessna172_nwheel.mdl",
		pos=Vector(-120,0,-9),
		friction=10,
		mass=400,
	}
}
ENT.Seats = {
	{
		pos=Vector(0,0,-2.2),
		exit=Vector(-80,80,80),
		weapons={"Dual MGs"}
	}
}

ENT.Weapons = {
	["Dual MGs"] = {
		class = "wac_pod_mg",
		info = {
			Pods = {
				Vector(85,67,30),
				Vector(85,-67,30)
			},
			Sounds = {
				shoot = "wac/stuka/gun.wav",
				stop = "wac/stuka/gunstop.wav",
			},
			Sequential = false,
			FireRate = 500,
			TkAmmo = 0,
			Ammo = 500
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