if not wac then return end
if SERVER then AddCSLuaFile('shared.lua') end
ENT.Base 				= "wac_pl_base"
ENT.Type 				= "anim"
ENT.Category			= "Gredwitch's Stuff"
ENT.PrintName			= "[WAC]Supermarine Spitfire 24"
ENT.Author				= "Gredwitch"
ENT.AutomaticFrameAdvance = true // needed for gear anims

ENT.Spawnable			= true
ENT.AdminSpawnable		= true
ENT.engineHealth = 150
ENT.Model	    = "models/sentry/spitfire.mdl"
ENT.RotorPhModel	= "models/props_junk/sawblade001a.mdl"
ENT.RotorModel	= "models/sentry/spitfire_prop.mdl"

ENT.rotorPos	= Vector(161,-0.25,75.5)
ENT.TopRotorDir	= 1

ENT.EngineForce	= 13000
ENT.Weight	    = 3000
ENT.SeatSwitcherPos	= Vector(0,0,0)
ENT.AngBrakeMul	= 0.02
ENT.SmokePos	= Vector(110,0,72.25)
ENT.FirePos	    = Vector(110,0,72.25)

if CLIENT then
	ENT.thirdPerson = {
		distance = 400
	}
end

ENT.Agility = {
	Thrust = 25
}

ENT.Wheels={
	{
		mdl="models/sentry/spitfire_bw.mdl",
		pos=Vector(-150.5,0,58.75),
		friction=50,
		mass=550,
	},
	{
		mdl="models/sentry/spitfire_fw_l.mdl",
		pos=Vector(80.5,34,10),
		friction=1,
		mass=550,
	},
	{
		mdl="models/sentry/spitfire_fw_r.mdl",
		pos=Vector(80.5,-34,10),
		friction=1,
		mass=550,
	},
}

ENT.Seats = {
	{
		pos=Vector(20,-0.25,60.5),
		exit=Vector(10,59,85),
		weapons={"Vickers", "RP-3 Rockets"}
	}
}

ENT.Weapons = {
	["Vickers"] = {
		class = "wac_pod_mg",
		info = {
			Pods = {
				Vector(135.5,75,53.75),
				Vector(135.5,-75,53.75),		
			},
			FireRate = 700,
			Ammo = 1000,
			Sequential = true,
			Sounds = {
				shoot = "WAC/Spitfire/gun.wav",
				stop = "WAC/Spitfire/gun_stop.wav",
			}
		}
	},
	["RP-3 Rockets"] = {
		class = "wac_pod_grocket",
		info = {
			Pods = {
				Vector(350,75,53.75),
				Vector(350,-75,53.75),		
			},
			FireRate = 150,
			Ammo = 4,
			Kind = "gb_rocket_rp3",
			Sequential = true,
		}
	}
}


ENT.Sounds={
	Start="WAC/Spitfire/Start.wav",
	Blades="WAC/Spitfire/external.wav",
	Engine="WAC/Spitfire/internal.wav",
	MissileAlert="",
	MissileShoot="",
	MinorAlarm="",
	LowHealth="",
	CrashAlarm=""
}


function ENT:DrawPilotHud() end
function ENT:DrawWeaponSelection() end
