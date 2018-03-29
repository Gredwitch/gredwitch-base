if not wac then return end
if SERVER then AddCSLuaFile('shared.lua') end
if GetConVarNumber("gred_jets_speed") >= 1 then jetspeed = 36 else jetspeed = 33 end
ENT.Base 				= "wac_pl_base"
ENT.Type 				= "anim"
ENT.Category			= "Gredwitch's Stuff"
ENT.PrintName			= "[WAC]AV-8B Harrier II"
ENT.Author				= "Gredwitch"

ENT.Spawnable			= true
ENT.AdminSpawnable		= true

ENT.Model	    = "models/mm1/av8b.mdl"
ENT.RotorPhModel        = "models/props_junk/sawblade001a.mdl"
ENT.RotorModel        = "models/props_junk/PopCan01a.mdl"

ENT.rotorPos	= Vector(0,0,100)
ENT.TopRotorDir	= 1.0
ENT.AutomaticFrameAdvance = true
ENT.EngineForce	= 723
ENT.Weight	    = 10410
ENT.SeatSwitcherPos	= Vector(0,0,0)
ENT.AngBrakeMul	= 0.02
ENT.SmokePos	= Vector(-14.75,33.04,66.14)
ENT.FirePos	    = Vector(-14.75,33.04,66.14)

if CLIENT then
	ENT.thirdPerson = {
		distance = 550
	}
end


ENT.Agility = {
	Thrust = jetspeed
}

ENT.Wheels={
	{
		mdl="models/mm1/av8b_tinywheel.mdl",
		pos=Vector(-71.59,102.24,9.99),
		friction=10,
		mass=300,
	},
	{
		mdl="models/mm1/av8b_tinywheel.mdl",
		pos=Vector(-71.59,-101.94,9.99),
		friction=10,
		mass=300,
	},
	{
		mdl="models/mm1/av8b_wheelsback.mdl",
		pos=Vector(-43.84,0,15.44),
		friction=10,
		mass=600,
	},
	{
		mdl="models/mm1/av8b_frontwheel.mdl",
		pos=Vector(97.8,0,16.58),
		friction=10,
		mass=1200,
	},
}

ENT.Seats = {
	{
		pos=Vector(150,0,70),
		exit=Vector(144.03,0,150),
		weapons={"GAU-12 Equalizer", "CRV7", "CBU-52U", "AGM-88 HARM"}
	}
}

ENT.Weapons = {
	["GAU-12 Equalizer"] = {
		class = "wac_pod_mg",
		info = {
			Pods = {
				Vector(130,19.94,38.08),
			},
			Sounds = {
				shoot = "WAC/f4/gun.wav",
				stop = "WAC/f4/gun_stop.wav",
			},
			Ammo = 300,
			BulletType = "wac_base_20mm",
			FireRate = 4200
		}
	},
	["CRV7"] = {
		class = "wac_pod_grocket",
		info = {
			Ammo = 38,
			FireRate = 300,
			Pods = {
				Vector(10,-156.57,40.4),
				Vector(10,156.57,40.4)
			}
		}
	},
	["CBU-52U"] = {
		class = "wac_pod_gbomb",
		info = {
			FireRate = 150,
			Pods = {
				Vector(-22.33,128.13,53.1),
				Vector(-22.33,-128.13,53.1)
			},
			Kind = "gb_bomb_cbu",
		}
	},
	["AGM-88 HARM"] = {
		class = "wac_pod_mis",
		info = {
			Ammo = 2,
			MaxRange = 40000,
			Pods = {
				Vector(85,-75.62, 56.1),
				Vector(85,75.62, 56.1)
			}
		}
	}
}

ENT.Camera = {
	model = "models/mm1/box.mdl",
	pos = Vector(265.0,0,69.28),
	offset = Vector(-1,0,0),
	viewPos = Vector(5,0,0),
	maxAng = Angle(45, 90, 0),
	minAng = Angle(-2, -90, 0),
	seat = 1
}

ENT.Sounds={
	Start="av8b/start.wav",
	Blades="av8b/external.wav",
	Engine="av8b/internal.wav",
	MissileAlert="a10/misslealert.wav",
	MissileShoot="HelicopterVehicle/MissileShoot.mp3",
	MinorAlarm="a10/osp.wav",
	LowHealth="a10/lowhealth.wav",
	CrashAlarm="a10/crashalarm.wav"
}

// heatwave
if CLIENT then
	local cureffect=0
	function ENT:Think()
		self:base("wac_pl_base").Think(self)
		local throttle = self:GetNWFloat("up", 0)
		local active = self:GetNWBool("active", false)
		local ent=LocalPlayer():GetVehicle():GetNWEntity("wac_aircraft")
		if ent==self and active and throttle > 0.2 and CurTime()>cureffect then
			cureffect=CurTime()+0.02
			local ed=EffectData()
			ed:SetEntity(self)
			ed:SetOrigin(Vector(-14.75,33.04,66.14)) // offset
			ed:SetMagnitude(throttle)
			ed:SetRadius(25)
			util.Effect("wac_heatwave", ed)
			
			local ed=EffectData()
			ed:SetEntity(self)
			ed:SetOrigin(Vector(-14.75,-33.04,66.14)) // offset
			ed:SetMagnitude(throttle)
			ed:SetRadius(25)
			util.Effect("wac_heatwave", ed)
		end
	end
end