if not wac then return end
if SERVER then AddCSLuaFile('shared.lua') end
ENT.Base 				= "wac_pl_base"
ENT.Type 				= "anim"
ENT.Category			= "Gredwitch's Stuff"
ENT.PrintName			= "[WAC]Fokker Dr.I"
ENT.Author				= "Vought"

ENT.Spawnable			= true
ENT.AdminSpawnable		= true

ENT.Model	    = "models/gredwitch/fokker/fokker dr,i.mdl"
ENT.RotorPhModel	= "models/props_junk/sawblade001a.mdl"
ENT.RotorModel	= "models/bf1/vehicles/fokker dr,i propeller.mdl"

ENT.rotorPos	= Vector(0,0,0)
ENT.TopRotorDir	= 1

ENT.EngineForce	= 110
ENT.Weight	    = 2510
ENT.SeatSwitcherPos	= Vector(0,0,0)
ENT.AngBrakeMul	= 0.015
ENT.SmokePos	= Vector(70.893,0,0)
ENT.FirePos	    = Vector(70.893,0,0)

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
		mdl="models/gredwitch/fokker/fokker_wr.mdl",
		pos=Vector(20.5,30,-51.5),
		friction=10,
		mass=200,
	},
	{
		mdl="models/gredwitch/fokker/fokker_wl.mdl",
		pos=Vector(20.5,-30,-51.5),
		friction=10,
		mass=200,
	},
	{
		mdl="models/gredwitch/fokker/fokker_wb.mdl",
		pos=Vector(-155,0,-14),
		friction=10,
		mass=400,
	},
}

ENT.Seats = {
	{
		pos=Vector(-30,0,-2.2),
		exit=Vector(-80,80,80),
		weapons={"Dual Maschinengewehr 08"}
	}
}

ENT.Weapons = {
	["Dual Maschinengewehr 08"] = {
		class = "wac_pod_mg",
		info = {
			Pods = {
				Vector(80,-5.426,30),
				Vector(80,5.426,30)
			},
			Sounds = {
				shoot = "wac/sbu1/browning_start.wav",
				stop = "wac/sbu1/browning_end.wav",
			},
			Sequential = true,
			FireRate = 500,
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