if not wac then return end
if SERVER then AddCSLuaFile('shared.lua') end
if GetConVarNumber("gred_jets_speed") >= 1 then jetspeed = 100 else jetspeed = 33 end
ENT.Base 				= "wac_pl_base"
ENT.Type 				= "anim"
ENT.Category			= "H-VAP 3"
ENT.PrintName			= "H-VAP SUPER PLANE!!!!111"
ENT.Author				= "Gredwitch"
ENT.Engines = 2
ENT.Spawnable			= true
ENT.AdminSpawnable		= true

ENT.Model            = "models/gredwitch/supahplane/plane.mdl"
ENT.RotorPhModel     = "models/props_junk/sawblade001a.mdl"
ENT.RotorModel       = "models/gredwitch/supahplane/plane_supahprop.mdl"
ENT.engineHealh = 100
ENT.rotorPos        = Vector(0,0,0)
ENT.TopRotorDir        = 1.0
ENT.AutomaticFrameAdvance = true
ENT.EngineForce        = 800
ENT.Weight            = 36000
ENT.SeatSwitcherPos	= Vector(0,0,0)
ENT.AngBrakeMul	= 0.05
ENT.SmokePos        = Vector(-450,-188,120)
ENT.FirePos            = ENT.SmokePos
ENT.MaxEnterDistance	=	1000
if CLIENT then
	ENT.thirdPerson = {
		distance = 500
	}
end

ENT.Agility = {
	Thrust = jetspeed
}
ENT.Seats = {
	{
		pos=Vector(-60,0,-35),
		exit=Vector(-50,100,0),
		weapons={"Supahgun!!!", "Rockets!!!!!","MEGABOMB!!!!!"}
	},
}
ENT.Weapons = {
	["Supahgun!!!"] = {
		class = "wac_pod_mg",
		info = {
			Pods = {
				Vector(400,0,0),
			},
			BulletType = "wac_base_30mm",
		    Ammo = 1,
			TkAmmo = 0,
		}
	},
	["Rockets!!!!!"] = {
	    class = "wac_pod_grocket",
		info = {
			Pods = {
				Vector(400,300,0),
				Vector(400,-300,0),
			},
			TkAmmo = 0,
		    Ammo = 1,
			Kind = "gb_rocket_hvar"
		}
	},
	["MEGABOMB!!!!!"] = {
	    class = "wac_pod_gbomb",
		info = {
			Pods = {
				Vector(0,0,50),
			},
		    Admin = 1,
			Kind = "gb_bomb_sc1000"
		}
	}
}

ENT.Sounds={
	Start="wac/hvap/YOUJUSTGOTPRANKEDBRO.mp3",
	Blades="wac/hvap/TheInternetIsNot.wav",
	Engine="",
	MissileAlert="HelicopterVehicle/MissileNearby.mp3",
	MissileShoot="HelicopterVehicle/MissileShoot.mp3",
	MinorAlarm="HelicopterVehicle/MinorAlarm.mp3",
	LowHealth="HelicopterVehicle/LowHealth.mp3",
	CrashAlarm="HelicopterVehicle/CrashAlarm.mp3"
}
// heatwave
if CLIENT then
	local cureffect=0
	function ENT:Think()
		self:base("wac_pl_base").Think(self)
		
		local throttle = self:GetNWFloat("up", 0)
		local active = self:GetNWBool("active", false)
		local v=LocalPlayer():GetVehicle()
		if IsValid(v) then
			local ent=v:GetNWEntity("wac_aircraft")
			if ent==self and active and throttle > 0.5 and CurTime()>cureffect then
				cureffect=CurTime()+0.01
				local ed=EffectData()
				ed:SetEntity(self)
				ed:SetOrigin(Vector(-70,0,0)) // offset
				ed:SetMagnitude(throttle)
				ed:SetRadius(30)
				util.Effect("wac_heatwave", ed)
			end
		end
	end
end