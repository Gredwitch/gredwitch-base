if not wac then return end
if SERVER then AddCSLuaFile('shared.lua') end

ENT.Base 					= "wac_pl_base"
ENT.Type 					= "anim"
ENT.Category				= "Gredwitch's Stuff"
ENT.PrintName				= "[WAC]Messerschmitt Me 262 Sturmvogel (No bomb)"
ENT.Author					= "Gredwitch"
ENT.Spawnable				= true
ENT.AdminSpawnable			= true

ENT.Model	   				= "models/gredwitch/me262/me262.mdl"
ENT.RotorPhModel        	= "models/props_junk/sawblade001a.mdl"
ENT.RotorModel        		= "models/mm1/box.mdl"
ENT.rotorPos				= Vector(0,0,100)
ENT.TopRotorDir				= 1.0
ENT.AutomaticFrameAdvance 	= true
ENT.EngineForce				= 1600
ENT.Weight	    			= 640
ENT.SeatSwitcherPos			= Vector(0,0,0)
ENT.AngBrakeMul				= 0.02
ENT.SmokePos				= Vector(-38,89,-28)
ENT.Engines = 2
ENT.FirePos	    			= ENT.SmokePos

if CLIENT then
	ENT.thirdPerson = {
		distance = 550
	}
end

ENT.Agility = {
	Thrust = 36
}

ENT.Wheels={
	{
		mdl="models/gredwitch/me262/me262_wf.mdl",
		pos=Vector(164,0,-63),
		friction=5,
		mass=2000,
	},
	{
		mdl="models/gredwitch/me262/me262_wl.mdl",
		pos=Vector(27,63,-56),
		friction=5,
		mass=1000,
	},
	{
		mdl="models/gredwitch/me262/me262_wr.mdl",
		pos=Vector(27,-63,-56),
		friction=5,
		mass=1000,
	},
}
ENT.Seats = {
	{
		pos=Vector(15,1.5,8),
		exit=Vector(100,300,13),
		weapons={"30mm MK 108" ,"R4M Rockets"}
	}
}

ENT.Weapons = {
	["30mm MK 108"] = {
		class = "wac_pod_mg",
		info = {
			Pods = {
				Vector(200,9,-17),
				Vector(200,-12,-17),
				Vector(200,9,-14),
				Vector(200,-12,-14),
			},
			Sounds = {
				shoot = "wac/me262/shoot_start.wav",
				stop = "wac/me262/shoot_end.wav"
			},
			Ammo = 1000,
			Sequential = false,
			BulletType = "wac_base_30mm",
			FireRate = 660
		}
	},
	["R4M Rockets"] = {
		class = "wac_pod_grocket",
		info = {
			Ammo = 24,
			Kind = "gb_rocket_rp3",
			FireRate = 300,
			Pods = {
				Vector(300,158,-15),
				Vector(300,-161,-15)
			}
		}
	}
}

ENT.Sounds={
	Start="wac/me262/me262_start.wav",
	Blades="wac/me262/me262_engine.wav",
	Engine="radio/german.wav",
	MissileAlert="",
	MissileShoot="",
	MinorAlarm="",
	LowHealth="",
	CrashAlarm=""
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
			ed:SetOrigin(Vector(-38,89,-28)) // offset
			ed:SetMagnitude(throttle)
			ed:SetRadius(25)
			util.Effect("wac_heatwave", ed)
			
			local ed=EffectData()
			ed:SetEntity(self)
			ed:SetOrigin(Vector(-38,-92,-28)) // offset
			ed:SetMagnitude(throttle)
			ed:SetRadius(25)
			util.Effect("wac_heatwave", ed)
		end
	end
end