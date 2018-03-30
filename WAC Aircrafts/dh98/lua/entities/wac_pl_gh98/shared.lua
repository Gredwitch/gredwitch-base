if not wac then return end
ENT.Base = "wac_pl_base"
ENT.Type = "anim"
ENT.Category = "Gredwitch's Stuff"
ENT.Spawnable = true
ENT.AdminSpawnable = true
ENT.PrintName = "[WAC]DH.98 Mosquito B MK.IV"
ENT.Model				= "models/chippy/dh98/body.mdl"
ENT.RotorPhModel		= "models/props_junk/sawblade001a.mdl"
ENT.RotorModel			= "models/chippy/dh98/prop.mdl"
ENT.OtherRotorModel		= "models/chippy/dh98/prop.mdl"
ENT.FirePos			= Vector(170,220,0)
ENT.SmokePos		= ENT.FirePos
ENT.AutomaticFrameAdvance = true
ENT.OtherRotorPos = Vector(283.6,176,9)
ENT.OtherRotorDir = -1
if CLIENT then
	ENT.thirdPerson = {
		distance = 1000
	}
end
ENT.Weight			= 8000
ENT.EngineForce		= 300
ENT.Engines = 2
ENT.rotorPos 	= Vector(283.6,-180,9)
ENT.Agility = {
	Thrust = 20
}


ENT.Wheels={
	{
		mdl="models/chippy/dh98/fwheel.mdl",
		pos=Vector(138,-180,-120),
		friction=0,
		mass=400,
	},
	{
		mdl="models/chippy/dh98/fwheel.mdl",
		pos=Vector(138,175,-119),
		friction=0,
		mass=400,
	},
	{
		mdl="models/chippy/dh98/bwheel.mdl",
		pos=Vector(-457,-2,-10),
		friction=0,
		mass=1100,
	},
}

ENT.Seats = {
	{
		pos=Vector(175,16,25),
		exit=Vector(372.79,0,9),
	},
	{
		pos=Vector(155,-24,20),
		exit=Vector(372.79,0,14),
	},
	{
		pos=Vector(270,-27,-9),
		ang=Angle(0,90,0),
		exit=Vector(372.79,0,14),
		weapons={"500LB bombs"},
	},
}

ENT.Weapons = {
	["500LB bombs"] = {
		class = "wac_pod_gbomb",
		info = {
			Pods = {
				Vector(40,-22,-30),
				Vector(40,17,-30),
			},
			Kind = "gb_bomb_500gp"
		}
	}
}

ENT.Sounds={
	Start="wac/dh98/start.wav",
	Blades="wac/dh98/external.wav",
	Engine="wac/dh98/internal.wav",
	MissileAlert="",
	MissileShoot="",
	MinorAlarm="",
	LowHealth="",
	CrashAlarm="",
}

function ENT:DrawPilotHud() end
function ENT:DrawWeaponSelection() end