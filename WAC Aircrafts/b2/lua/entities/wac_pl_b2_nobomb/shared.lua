if not wac then return end
if SERVER then AddCSLuaFile('shared.lua') end
ENT.Base 				= "wac_pl_base"
ENT.Type 				= "anim"
ENT.Category			= "Gredwitch's Stuff"
ENT.PrintName			= "[WAC]Northrop B-2 Spirit (No bombs)"
ENT.Author				= "Gredwitch"

ENT.Spawnable			= true
ENT.AdminSpawnable		= true

ENT.Model	    = "models/gredwitch/b2/b2.mdl"
ENT.RotorPhModel        = "models/props_junk/sawblade001a.mdl"
ENT.RotorModel        = "models/mm1/box.mdl"
ENT.maxEnterDistance = 1000
ENT.rotorPos	= Vector(-416,42,114)
ENT.TopRotorDir	= 1.0
ENT.AutomaticFrameAdvance = true
ENT.EngineForce	= 611
ENT.Weight	    = 14600
ENT.SeatSwitcherPos	= Vector(0,0,0)
ENT.AngBrakeMul	= 0.02
ENT.SmokePos	= ENT.rotorPos
ENT.FirePos	    = ENT.rotorPos
ENT.Engines			 = 2
ENT.MaxEnterDistance = 500
ENT.thirdPerson={
	distance = 1500,
}

ENT.Agility = {
	Thrust = 33
}

ENT.Wheels={
	{
		mdl="models/gredwitch/su47/su47_wf.mdl",
		pos=Vector(367,0,14.5),
		friction=10,
		mass=1200,
	},
	--------------------------------------------
	{
		mdl="models/gredwitch/su47/su47_wl.mdl",
		pos=Vector(-56,238,16.2),
		friction=10,
		mass=100,
	},												--Left wheels
	{
		mdl="models/gredwitch/su47/su47_wr.mdl",
		pos=Vector(-56,255.6,16.2),
		friction=10,
	},
	{
		mdl="models/gredwitch/su47/su47_wl.mdl",
		pos=Vector(56,238,16.2),
		friction=10,
		mass=100,
	},												--Left wheels
	{
		mdl="models/gredwitch/su47/su47_wr.mdl",
		pos=Vector(56,255.6,16.2),
		friction=10,
		mass=100,
	},
	--------------------------------------------
	{
		mdl="models/gredwitch/su47/su47_wr.mdl",
		pos=Vector(-56,-238,16.2),
		friction=10,
		mass=100,
	},												--Right wheels
	{
		mdl="models/gredwitch/su47/su47_wl.mdl",
		pos=Vector(-56,-255.6,16.2),
		friction=10,
		mass=100,
	},
	{
		mdl="models/gredwitch/su47/su47_wr.mdl",
		pos=Vector(56,-238,16.2),
		friction=10,
		mass=100,
	},												--Right wheels
	{
		mdl="models/gredwitch/su47/su47_wl.mdl",
		pos=Vector(56,-255.6,16.2),
		friction=10,
		mass=100,
	},
	--------------------------------------------
}

ENT.Seats = {
	{
		pos=Vector(256.5,25,150),
		exit=Vector(256.5,25,10),
	},
	{
		pos=Vector(256.5,-25,150),
		exit=Vector(256.5,-25,10),
	}
}

ENT.Camera = {
	model = "models/mm1/box.mdl",
	pos = Vector(435,0,92),
	offset = Vector(-1,0,0),
	viewPos = Vector(2,0,0),
	maxAng = Angle(45, 90, 0),
	minAng = Angle(-2, -90, 0),
	seat = 1
}

ENT.Sounds={
	Start="WAC/A10/Start.wav",
	Blades="WAC/A10/external.wav",
	Engine="WAC/A10/internal.wav",
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
		local ent=LocalPlayer():GetVehicle():GetNWEntity("wac_aircraft")
		if ent==self and active and throttle > 0.2 and CurTime()>cureffect then
			cureffect=CurTime()+0.02
			local ed=EffectData()
			ed:SetEntity(self)
			ed:SetOrigin(Vector(-130.7,158,143)) // offset
			ed:SetMagnitude(throttle)
			ed:SetRadius(25)
			util.Effect("wac_heatwave", ed)
			local ed=EffectData()
			ed:SetEntity(self)
			ed:SetOrigin(Vector(-130.7,-158,143)) // offset
			ed:SetMagnitude(throttle)
			ed:SetRadius(25)
			util.Effect("wac_heatwave", ed)
		end
	end
end