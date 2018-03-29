if not wac then return end
if SERVER then AddCSLuaFile() end
ENT.Base 				= "wac_pl_base"
ENT.Type 				= "anim"
ENT.Category			= "Gredwitch's Stuff"
ENT.PrintName			= "[WAC]Fw 190F-8 Würger (bomber)"
ENT.Author				= "Chippy"

ENT.Spawnable			= true
ENT.AdminSpawnable		= true
ENT.engineHealth = 150
ENT.AutomaticFrameAdvance = true // needed for gear anims

ENT.Model            = "models/chippy/fw190/body.mdl"
ENT.RotorPhModel        = "models/props_junk/sawblade001a.mdl"
ENT.RotorModel        = "models/chippy/fw190/prop.mdl"
ENT.rotorPos        = Vector(121.5,5,25)
ENT.TopRotorDir        = 1

ENT.EngineForce        = 345
ENT.Weight            = 9130
ENT.SeatSwitcherPos	= Vector(0,0,0)
ENT.AngBrakeMul		= 0.0257
ENT.SmokePos        = Vector(110,5,40.1)
ENT.FirePos			= Vector(110,5,40.1)

if CLIENT then
	ENT.thirdPerson = {
		distance = 400
	}
end

ENT.Wheels={
	{
		mdl="models/chippy/fw190/bwheel.mdl",
		pos=Vector(-151,5,9),
		friction=3,
		mass=900,
	},
	{
		mdl="models/chippy/fw190/fwheel.mdl",
		pos=Vector(71,65,-31),
		friction=0,
		mass=600,
	},
	{
		mdl="models/chippy/fw190/fwheel.mdl",
		pos=Vector(71,-56,-31),
		friction=0,
		mass=600,
	},
}

ENT.Seats = {
	{
		pos=Vector(0,3.4,20.3),
		exit=Vector(3.5,60,100),
		weapons={"MG131", "MG151/20", "500Kg bomb"},
	},
}

ENT.Agility = {
	Thrust = 15
}

ENT.Weapons = {
	["MG131"] = {
		class = "wac_pod_mg",
		info = {
			Pods = {
				Vector(75,-2,51),
				Vector(75,8,51),
			},
			FireRate = 900,
			Ammo = 1500,
			Sequential = true,
			Sounds = {
				shoot = "wac/fw190/shoot_start.wav",
				stop = "wac/fw190/shoot_end.wav",
			},
		}
	},
	["MG151/20"] = {
		class = "wac_pod_mg",
		info = {
			Pods = {
				Vector(75,37,17),
				Vector(75,-29,17)
			},
			FireRate = 750,
			Ammo = 200,
			BulletType = "wac_base_20mm",
			Sequential = true,
			Sounds = {
				shoot = "wac/fw190/shoot_start.wav",
				stop = "wac/fw190/shoot_end.wav",
			},
		}
	},
	["500Kg bomb"] = {
		class = "wac_pod_gbomb",
		info = {
			Pods = {
				Vector(40,5,-11),
			},
			Kind = "gb_bomb_sc500"
		}
	}
}

ENT.Sounds = {
	Start="wac/fw190/Start.wav",
	Blades="wac/fw190/external.wav",
	Engine="radio/german.wav",
	MissileAlert="",
	MissileShoot="",
	MinorAlarm="",
	LowHealth="",
	CrashAlarm=""
}

function ENT:DrawPilotHud() end
function ENT:DrawWeaponSelection() end