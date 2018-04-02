if not wac then return end
if SERVER then AddCSLuaFile('shared.lua') end
if GetConVarNumber("gred_jets_speed") >= 1 then jetspeed = 70 else jetspeed = 33 end
ENT.Base 				= "wac_pl_base"
ENT.Type 				= "anim"
ENT.Category			= "Gredwitch's Stuff"
ENT.PrintName			= "[WAC]Lockhead SR-71"
ENT.Author				= "Gredwitch"
ENT.Engines = 2
ENT.Spawnable			= true
ENT.AdminSpawnable		= true

ENT.Model            = "models/gredwitch/sr71/sr-71.mdl"
ENT.RotorPhModel        = "models/props_junk/sawblade001a.mdl"
ENT.RotorModel        = "models/mm1/box.mdl"
ENT.engineHealh = 100
ENT.rotorPos        = Vector(0,0,74)
ENT.TopRotorDir        = 1.0
ENT.AutomaticFrameAdvance = true
ENT.EngineForce        = 800
ENT.Weight            = 36000
ENT.SeatSwitcherPos	= Vector(0,0,0)
ENT.AngBrakeMul	= 0.05
ENT.SmokePos        = Vector(-450,-188,120)
ENT.FirePos            = ENT.SmokePos
ENT.maxEnterDistance	=	1000
if CLIENT then
	ENT.thirdPerson = {
		distance = 1200
	}
end

ENT.Agility = {
	Thrust = jetspeed
}

ENT.Wheels={
	{
		mdl="models/gredwitch/sr71/sr-71_wr.mdl",
		pos=Vector(-238,-127,10),
		friction=10,
		mass=600,
	},
	{
		mdl="models/gredwitch/sr71/sr-71_wl.mdl",
		pos=Vector(-238,127,10),
		friction=10,
		mass=600,
	},
	{
		mdl="models/gredwitch/sr71/sr-71_wf.mdl",
		pos=Vector(252,0,16.5),
		friction=10,
		mass=1200,
	},
}

ENT.Seats = {
	{
		pos=Vector(408,0,102),
		exit=Vector(408,100,102),
	},
	{
		pos=Vector(351,0,102),
		exit=Vector(351,100,102),
	}
}

ENT.Sounds={
	Start="WAC/fa18/Start.wav",
	Blades="WAC/fa18/external.wav",
	Engine="WAC/fa18/internal.wav",
	MissileAlert="HelicopterVehicle/MissileNearby.mp3",
	MissileShoot="HelicopterVehicle/MissileShoot.mp3",
	MinorAlarm="HelicopterVehicle/MinorAlarm.mp3",
	LowHealth="HelicopterVehicle/LowHealth.mp3",
	CrashAlarm="HelicopterVehicle/CrashAlarm.mp3"
}

ENT.Camera = {
	model = "models/mm1/box.mdl",
	pos = Vector(0,0,75),
	offset = Vector(0,0,0),
	viewPos = Vector(0, 0, 0),
	maxAng = Angle(0, 90, 0),
	minAng = Angle(0, 90, 0),
	seat = 2
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
				ed:SetOrigin(Vector(-450,188,120)) // offset
				ed:SetMagnitude(throttle)
				ed:SetRadius(30)
				util.Effect("wac_heatwave", ed)
				
				local ed=EffectData()
				ed:SetEntity(self)
				ed:SetOrigin(Vector(-450,-188,120)) // offset
				ed:SetMagnitude(throttle)
				ed:SetRadius(30)
				util.Effect("wac_heatwave", ed)
			end
		end
	end
end