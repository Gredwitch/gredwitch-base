if not wac then return end
if SERVER then AddCSLuaFile('shared.lua') end
ENT.Base 				= "wac_pl_base"
ENT.Type 				= "anim"
ENT.Category			= "Gredwitch's Stuff"
ENT.PrintName			= "[WAC]SBU-1 Corsair"
ENT.Author				= "Vought"

ENT.Spawnable			= true
ENT.AdminSpawnable		= true

ENT.Model	    = "models/wac/fsx/sbu1.mdl"
ENT.RotorPhModel	= "models/props_junk/sawblade001a.mdl"
ENT.RotorModel	= "models/wac/fsx/sbu1_prop.mdl"

ENT.rotorPos	= Vector(70.893,0,0)
ENT.TopRotorDir	= 1

ENT.EngineForce	= 180
ENT.Weight	    = 2510
ENT.SeatSwitcherPos	= Vector(0,0,0)
ENT.AngBrakeMul	= 0.015
ENT.SmokePos	= Vector(70.893,0,0)
ENT.FirePos	    = Vector(70.893,0,0)

if CLIENT then
	ENT.thirdPerson = {
		distance = 500
	}
end

ENT.Agility = {
	Thrust = 9.3
}

ENT.Wheels={
	{
		mdl="models/wac/fsx/sbu1_front.mdl",
		pos=Vector(8.484,0,-57.82),
		friction=10,
		mass=500,
	},
	{
		mdl="models/wac/fsx/sbu1_back.mdl",
		pos=Vector(-220,0,-14),
		friction=10,
		mass=1000,
	},
}

ENT.Seats = {
	{
		pos=Vector(-58,0,-2.2),
		exit=Vector(-80,80,80),
		weapons={"AN/M1919 Browning", "AN-M57 bomb"}
	},
	{
		pos=Vector(-100,0,-5),
		exit=Vector(-80,-80,80)
	}
}

ENT.Weapons = {
	["AN/M1919 Browning"] = {
		class = "wac_pod_mg",
		info = {
			Pods = {
				Vector(80,-5.426,30)
			},
			Sounds = {
				shoot = "wac/sbu1/browning_start.wav",
				stop = "wac/sbu1/browning_end.wav",
			},
			FireRate = 500,
			BulletType = "wac_base_7mm",
			Ammo = 250
		}
	},
	["AN-M57 bomb"] = {
		class = "wac_pod_gbomb",
		info = {
			Pods = {
				Vector(-46,90,-32),
				Vector(-46,-90,-32),
			},
			Kind = "gb_bomb_250gp"
		}
	}
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