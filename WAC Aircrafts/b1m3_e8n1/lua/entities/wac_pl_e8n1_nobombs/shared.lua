if not wac then return end
if SERVER then AddCSLuaFile() end

ENT.Base 				= "wac_pl_base"
ENT.Type 				= "anim"
ENT.Category			= "Gredwitch's Stuff"
ENT.PrintName			= "[WAC]Nakajima E8N1 (No bombs)"
ENT.Author				= "Gredwitch"
ENT.Spawnable			= true
ENT.AdminSpawnable		= false
ENT.engineHealth 		= 100
ENT.Model               = "models/gredwitch/e8n1/e8n1.mdl"
ENT.RotorPhModel        = "models/props_junk/sawblade001a.mdl"
ENT.RotorModel      	= "models/gredwitch/e8n1/e8n1_prop.mdl"
ENT.rotorPos        	= Vector(97,0,94)
ENT.TopRotorDir         = 1
ENT.EngineForce         = 500
ENT.Weight              = 1500
ENT.SeatSwitcherPos		= Vector(0,0,0)
ENT.SmokePos        	= ENT.rotorPos
ENT.FirePos             = ENT.SmokePos
ENT.thirdPerson = {
	distance = 500
}
ENT.Agility = {
	Thrust = 11
}

ENT.Seats = {
	{
		pos=Vector(-8,0,98),
		exit=Vector(-150,100,82),
	},
	{
		pos=Vector(-60,0,100),
		ang=Angle(0,180,0),
		exit=Vector(-150,100,82),
		weapons={"MGs"}
	}
}

ENT.Weapons = {
	["MGs"] = {
		class = "wac_pod_gunner",
		info = {
			ShootPos = Vector(-250,0,130),
			ShootOffset = Vector(0,0, 0),
			FireRate = 500,
			BulletType = "wac_base_7mm",
			Ammo = 250,
			Sounds = {
			    shoot1p = "",
				shoot3p  = "",
				spin = "WAC/Stuka/gun.wav",
			},
		}
	}
}

ENT.WeaponAttachments={
	
	gun = {
		model = "models/mm1/box.mdl",
		pos = Vector(146,0,113.6),
	},
	
}
ENT.Camera = {
	model = "models/mm1/box.mdl",
	pos = Vector(-240,0,130),
	offset = Vector(-1,0,0),
	viewPos = Vector(10, 0, 0),
	minAng = Angle(-180, -180, -180),
	maxAng = Angle(0, 180, 180),
	seat = 2
}

ENT.Sounds = {
	Start="WAC/Stuka/Start.wav",
	Blades="WAC/Stuka/external.wav",
	Engine="WAC/Stuka/internal.wav",
	MissileAlert="",
	MissileShoot="",
	MinorAlarm="",
	LowHealth="",
	CrashAlarm=""
}