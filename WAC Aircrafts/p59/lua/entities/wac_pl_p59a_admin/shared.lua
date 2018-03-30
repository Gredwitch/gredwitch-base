if not wac then return end
if SERVER then AddCSLuaFile('shared.lua') end
if GetConVarNumber("gred_jets_speed") >= 1 then jetspeed = 34 else jetspeed = 33 end
ENT.Base 				= "wac_pl_base"
ENT.Type 				= "anim"
ENT.Category			= "Gredwitch's Stuff"
ENT.PrintName			= "[WAC]P-59A Airacomet"
ENT.Author				= "Gredwitch"

ENT.Spawnable			= true
ENT.AdminSpawnable		= true

ENT.Model	    = "models/fsx/p59a_airacomet.mdl"
ENT.RotorPhModel	= "models/props_junk/sawblade001a.mdl"
ENT.RotorModel	= "models/fsx/p59a_rotor.mdl"
ENT.RotorModel2	= "models/fsx/p59a_rotor.mdl"

ENT.rotorPos	= Vector(-27.52,-24.764,63.318)
ENT.rotorPos2	= Vector(-27.52,24.764,63.318)

ENT.TopRotorDir	= 1

ENT.Engines = 2
ENT.EngineForce	= 480
ENT.Weight	    = 5008
ENT.SeatSwitcherPos	= Vector(0,0,0)
ENT.AngBrakeMul	= 0.02
ENT.SmokePos	= ENT.rotorPos
ENT.FirePos	    = ENT.SmokePos

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
		mdl="models/sentry/f16_fw.mdl",
		pos=Vector(192,0,26),
		friction=0,
		mass=1000,
	},
	{
		mdl="models/sentry/f16_bw.mdl",
		pos=Vector(35.464,-136.989,23.413),
		friction=0,
		mass=550,
	},
	{
		mdl="models/sentry/f16_bw.mdl",
		pos=Vector(38,136.989,23.413),
		friction=0,
		mass=550,
	},
}

ENT.Seats = {
	{
		pos=Vector(77.287,0,73),
		exit=Vector(80,40,140),
		weapons={"M2 Browning", "37mm cannon"}
	},
}

ENT.Weapons = {
	["M2 Browning"] = {
		class = "wac_pod_mg",
		info = {
			Pods = {
				Vector(213.422,-10.984,81.423),
				Vector(222.913,-5.157,86.187),
				Vector(224.404,-0.984,87.129)
			},
			FireRate = 500,
			Ammo = 300,
			Sounds = {
				shoot = "p59a_airacomet/m2_fire.wav",
				stop = "p59a_airacomet/m2_stop.wav",
			},
		}
	},
	["37mm cannon"] = {
		class = "wac_pod_mg",
		info = {
			Pods = {
				Vector(226.67,10.079,81.423)
			},
			Ammo = 100,
			BulletType = "wac_base_30mm",
			FireRate = 150,
			Sounds = {
				shoot = "p59a_airacomet/m4_fire.wav",
				stop = "p59a_airacomet/m4_stop.wav",
			}
		}
	},
}

ENT.Sounds={
	Start="wac/f86/start.wav",
	Blades="wac/a10/external.wav",
	Engine="wac/f86/internal.wav",
	MissileAlert="",
	MissileShoot="",
	MinorAlarm="",
	LowHealth="",
	CrashAlarm="",
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
			ed:SetOrigin(Vector(-27.52,24.764,63.318)) // offset
			ed:SetMagnitude(throttle)
			ed:SetRadius(25)
			util.Effect("wac_heatwave", ed)
			
			local ed=EffectData()
			ed:SetEntity(self)
			ed:SetOrigin(Vector(-27.52,-24.764,63.318)) // offset
			ed:SetMagnitude(throttle)
			ed:SetRadius(25)
			util.Effect("wac_heatwave", ed)
		end
	end
end

function ENT:DrawPilotHud() end
function ENT:DrawWeaponSelection() end