if not wac then return end
if SERVER then AddCSLuaFile() end

ENT.Base 				= "wac_pl_base"
ENT.Type 				= "anim"
ENT.Category			= "Gredwitch's Stuff"
ENT.PrintName			= "[WAC]Nakajima Type 91 (Admin)"
ENT.Author				= "Gredwitch"
ENT.Spawnable			= true
ENT.AdminSpawnable		= false
ENT.engineHealth 		= 100
ENT.Model               = "models/gredwitch/nakajima/nakajima91.mdl"
ENT.RotorPhModel        = "models/props_junk/sawblade001a.mdl"
ENT.RotorModel      	= "models/wop/vehicles/japan/nakajima type 91 propeller.mdl"
ENT.rotorPos        	= Vector(0,0,0)
ENT.TopRotorDir         = 1
ENT.EngineForce         = 500
ENT.Weight              = 1500
ENT.SeatSwitcherPos		= Vector(0,0,0)
ENT.SmokePos        	= Vector(49,0,0)
ENT.FirePos             = ENT.SmokePos
ENT.thirdPerson = {
	distance = 500
}
ENT.Agility = {
	Thrust = 11
}

ENT.Wheels = {
	{
		mdl="models/gredwitch/nakajima/nakajimaNC_wl.mdl",
		pos=Vector(7,40,-53),
		friction=5,
		mass=200,
	},
	{
		mdl="models/gredwitch/nakajima/nakajimaNC_wr.mdl",
		pos=Vector(7,-40,-53),
		friction=5,
		mass=200,
	},
	{
		mdl="models/cessna/cessna172_nwheel.mdl",
		pos=Vector(-200,0,-14),
		friction=5,
		mass=400,
	}
}

ENT.Seats = {
	{
		pos=Vector(-60,0,0),
		exit=Vector(30,60,85),
		weapons={"MGs"}
	},
}

ENT.Weapons = {
	["MGs"] = {
		class = "wac_pod_mg",
		info = {
			Pods = {
				Vector(28,17,10),
				Vector(28,-17,10),
			},
			FireRate = 500,
			TkAmmo = 0,
			--BulletType = "wac_base_7mm",
			Sequential = false,
			Ammo = 425,
			Sounds = {
				shoot = "WAC/stuka/gun.wav",
				stop = "WAC/stuka/gun_stop.wav",
			}
		}
	},
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

local function DrawLine(v1,v2) end
function ENT:DrawPilotHud() end