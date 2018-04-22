if not wac then return end
if SERVER then AddCSLuaFile('shared.lua') end
ENT.Base 				= "wac_hc_base"
ENT.Type 				= "anim"
ENT.Category			= "Gredwitch's Stuff"
ENT.PrintName			= "[WAC]Maibatsu Frogger"
ENT.Author				= "Gredwitch"
ENT.Spawnable			= true
ENT.AdminSpawnable		= true

ENT.Model            = "models/gredwitch/frogger/frogger.mdl"
ENT.RotorWidth		= 190
ENT.EngineForce        = 34
ENT.Weight            = 1451
ENT.SmokePos        = Vector(-225.7,6,82.4)
ENT.FirePos         = ENT.SmokePos

ENT.TopRotor = {
	dir = -1,
	pos = Vector(5.7,0,127),
	model = "models/gredwitch/frogger/frogger_tr.mdl"
}

ENT.BackRotor = {
	dir = -1,
	pos = Vector(-225.7,6,82.4),
	model = "models/gredwitch/frogger/frogger_br.mdl"
}

ENT.thirdPerson = {
	distance = 400
}

ENT.Seats = {
	{
		pos=Vector(83,19,46.4),
		exit=Vector(30,80,10),
	},
	{
		pos=Vector(83,-19,46.4),
		exit=Vector(30,-80,10),
	},
	{
		pos=Vector(42,-23.2,46),
		ang=Angle(-30,0,0),
		exit=Vector(-25,80,10),
	},
	{
		pos=Vector(42,0,46),
		ang=Angle(-90,0,0),
		exit=Vector(-25,80,10),
	},
	{
		pos=Vector(42,23.2,46),
		ang=Angle(-30,0,0),
		exit=Vector(-25,-80,10),
	},
}

ENT.Sounds={
	Start="WAC/Heli/h6_start.wav",
	Blades="WAC/frogger/external.wav",
	Engine="WAC/frogger/internal.wav",
	MissileAlert="HelicopterVehicle/MissileNearby.mp3",
	MissileShoot="HelicopterVehicle/MissileShoot.mp3",
	MinorAlarm="HelicopterVehicle/MinorAlarm.mp3",
	LowHealth="HelicopterVehicle/LowHealth.mp3",
	CrashAlarm="HelicopterVehicle/CrashAlarm.mp3",
}

function ENT:DrawWeaponSelection() end