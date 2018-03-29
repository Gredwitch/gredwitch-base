if not wac then return end
if SERVER then AddCSLuaFile() end
ENT.Base 				= "wac_pl_base"
ENT.Type 				= "anim"
ENT.Category			= "Gredwitch's Stuff"
ENT.PrintName			= "[WAC]BF-109E (Bomber)"
ENT.Author				= "Gredwitch"

ENT.Spawnable			= true
ENT.AdminSpawnable		= true
ENT.engineHealth = 150
ENT.Model	    = "models/sentry/bf109.mdl"
ENT.RotorPhModel	= "models/props_junk/sawblade001a.mdl"
ENT.RotorModel	= "models/sentry/bf109_prop.mdl"
ENT.rotorPos	= Vector(169.2,0,88.1)
ENT.TopRotorDir	= 1

ENT.EngineForce	= 6500
ENT.Weight	    = 3347
ENT.SeatSwitcherPos	= Vector(0,0,0)
ENT.AngBrakeMul		= 0.02
ENT.SmokePos	= Vector(169,0,88.1)
ENT.FirePos	    = Vector(169,0,88.1)

if CLIENT then
	ENT.thirdPerson = {
		distance = 650
	}
end

ENT.Agility = {
	Thrust = 30
}

ENT.Wheels={
	{
		mdl="models/sentry/bf109_bw.mdl",
		pos=Vector(-238.5,0,86),
		friction=0,
		mass=550,
	},
	{
		mdl="models/sentry/bf109_fw.mdl",
		pos=Vector(57.5,49.5,16.5),
		friction=0,
		mass=550,
	},
	{
		mdl="models/sentry/bf109_fw.mdl",
		pos=Vector(57.5,-49.5,16.5),
		friction=0,
		mass=550,
	},
}

ENT.Seats = {
	{
		pos=Vector(3.5,0,90),
		exit=Vector(3.5,60,100),
		weapons={"MG17", "100Kg bomb"}
    }
}					

ENT.Weapons = {
	["MG17"] = {
		class = "wac_pod_mg",
		info = {
			Pods = {
				Vector(90.5,-116.5,80.5),
				Vector(90.5,116.5,80.5),
				Vector(110.5,6,120),
				Vector(110.5,-6,120)
			},
			Sounds = {
				shoot = "WAC/bf109/gun.wav",
				stop = "WAC/bf109/gun_stop.wav",
			},
			FireRate = 1000,
			Ammo = 425,
			Sequential = true,
		}
	},
	["100Kg bomb"] = {
		class = "wac_pod_gbomb",
		info = {
			Pods = {
				Vector(48,0,49),
			},
			Kind = "gb_bomb_sc100"
		}
	}
}
	
ENT.Sounds={
	Start="WAC/Bf109/Start.wav",
	Blades="WAC/BF109/external.wav",
	Engine="radio/german.wav",
	MissileAlert="",
	MissileShoot="",
	MinorAlarm="",
	LowHealth="",
	CrashAlarm=""
}


function ENT:DrawPilotHud() end
function ENT:DrawWeaponSelection() end