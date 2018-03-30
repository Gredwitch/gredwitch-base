if not wac then return end
if SERVER then AddCSLuaFile('shared.lua') end
ENT.Base 				= "wac_pl_base"
ENT.Type 				= "anim"
ENT.Category			= "Gredwitch's Stuff"
ENT.PrintName			= "[WAC]Mitsubishi A6M2 Zero"
ENT.Author				= "Gredwitch"

ENT.Spawnable			= true
ENT.AdminSpawnable		= true

ENT.Model	    = "models/sentry/a6m2.mdl"
ENT.RotorPhModel	= "models/props_junk/sawblade001a.mdl"
ENT.RotorModel	= "models/sentry/a6m2_prop.mdl"

ENT.rotorPos	= Vector(101,0,74)
ENT.TopRotorDir	= 1

ENT.EngineForce	= 465
ENT.Weight	    = 2410
ENT.SeatSwitcherPos	= Vector(0,0,0)
ENT.AngBrakeMul	= 0.015
ENT.SmokePos	= Vector(101,0,74)
ENT.FirePos	    = Vector(101,0,74)

if CLIENT then
	ENT.thirdPerson = {
		distance = 550
	}
end

ENT.Agility = {
	Thrust = 25
}

ENT.Wheels={
	{
		mdl="models/sentry/a6m2_bw.mdl",
		pos=Vector(-205.5,0,59.75),
		friction=10,
		mass=600,
	},
	{
		mdl="models/sentry/a6m2_fw.mdl",
		pos=Vector(42,68,12),
		friction=10,
		mass=550,
	},
	{
		mdl="models/sentry/a6m2_fw.mdl",
		pos=Vector(42,-68,12),
		friction=10,
		mass=550,
	},
}

ENT.Seats = {
	{
		pos=Vector(2.5,0,70.23),
		exit=Vector(10,59,85),
		weapons={"Type 97", "Type 99-1", "100Kg bombs"}
	},
}

ENT.Weapons = {
	["Type 97"] = {
		class = "wac_pod_mg",
		info = {
			Pods = {
				Vector(70,8.9,96),
				Vector(70,-8.9,96),
			},
			FireRate = 500,
			BulletType = "wac_base_7mm",
			Sequential = true,
			Ammo = 600,
			Sounds = {
				shoot = "WAC/a6m2/gun2.wav",
				stop = "WAC/a6m2/gun2_stop.wav",
			}
		}
	},
	["Type 99-1"] = {
		class = "wac_pod_mg",
		info = {
			Pods = {
				Vector(67,-86.5,69),
				Vector(67,86.5,69),
			},
			FireRate = 400,
			Sequential = true,
			Ammo = 200,
			BulletType = "wac_base_20mm",
			Sounds = {
				shoot = "WAC/a6m2/gun2.wav",
				stop = "WAC/a6m2/gun2_stop.wav"
			}
		}
	},
	["100Kg bombs"] = {
		class = "wac_pod_gbomb",
		info = {
			Pods = {
				Vector(40,-86.5,60),
				Vector(40,86.5,60)
			},
			FireRate = 500,
			Kind = "gb_bomb_sc100",
		}
	},
}

ENT.Sounds={
	Start="WAC/A6M2/Start.wav",
	Blades="WAC/A6M2/external.wav",
	Engine="WAC/A6M2/internal.wav",
	MissileAlert="",
	MissileShoot="",
	MinorAlarm="",
	LowHealth="",
	CrashAlarm=""
}


function ENT:DrawPilotHud() end
function ENT:DrawWeaponSelection() end
