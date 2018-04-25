if not wac then return end
if SERVER then AddCSLuaFile('shared.lua') end
ENT.Base 				= "wac_pl_base"
ENT.Type 				= "anim"
ENT.Category			= "Gredwitch's Stuff"
ENT.PrintName			= "[WAC]Buckingham Nimbus"
ENT.Author				= "Gredwitch"
ENT.Engines = 2
ENT.Spawnable			= true
ENT.AdminSpawnable		= true

ENT.Model            = "models/gredwitch/nimbus/nimbus.mdl"
ENT.RotorPhModel        = "models/props_junk/sawblade001a.mdl"
ENT.RotorModel        = "models/gredwitch/nimbus/nimbus_rotor.mdl"
ENT.rotorPos        = Vector(-85.5,-67,17.5)
ENT.TopRotorDir        = 1.0
ENT.AutomaticFrameAdvance = true
ENT.OtherRotorPos = Vector(-85.5,67,17.5)
ENT.OtherRotorDir = -1
ENT.EngineForce        = 800
ENT.Weight            = 5000
ENT.SeatSwitcherPos	= Vector(0,0,0)
ENT.AngBrakeMul	= 0.05
ENT.SmokePos        = ENT.rotorPos
ENT.FirePos            = ENT.SmokePos
ENT.maxEnterDistance	=	1000
if CLIENT then
	ENT.thirdPerson = {
		distance = 700
	}
end

ENT.Agility = {
	Thrust = 33
}

ENT.Wheels={
	{
		mdl="models/gredwitch/nimbus/nimbus_wl.mdl",
		pos=Vector(-38,43.5,-83),
		friction=10,
		mass=600,
	},
	{
		mdl="models/gredwitch/nimbus/nimbus_wr.mdl",
		pos=Vector(-38,-43.5,-83),
		friction=10,
		mass=600,
	},
	{
		mdl="models/gredwitch/nimbus/nimbus_wf.mdl",
		pos=Vector(309,0,-85.5),
		friction=10,
		mass=1200,
	},
}

ENT.Seats = {
	{
		pos=Vector(260,16,-35),
		exit=Vector(220,100,55),
	},
	{
		pos=Vector(260,-16,-35),
		exit=Vector(220,-100,55),
	},
	----------------------------
	{
		pos=Vector(186,17,-36),
		ang=Angle(0,180,0),
		exit=Vector(155,100,36),
	},
	{
		pos=Vector(186,-17,-35),
		ang=Angle(0,180,0),
		exit=Vector(155,-100,55),
	},
	----------------------------
	{
		pos=Vector(118.7,-18,-35),
		exit=Vector(75,100,55),
	},
	{
		pos=Vector(118.7,18,-35),
		exit=Vector(75,-100,55),
	},
	
	{
		pos=Vector(76,-18,-35),
		ang=Angle(0,180,0),
		exit=Vector(55,100,55),
	},
	{
		pos=Vector(14,-18,-35),
		exit=Vector(55,-100,55),
	},
}

ENT.Sounds={
	Start="wac/luxor/start.wav",
	Blades="wac/luxor/external.wav",
	Engine="wac/luxor/internal.wav",
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
				ed:SetOrigin(self.rotorPos-Vector(150,0,0)) // offset
				ed:SetMagnitude(throttle)
				ed:SetRadius(30)
				util.Effect("wac_heatwave", ed)
				
				local ed=EffectData()
				ed:SetEntity(self)
				ed:SetOrigin(self.OtherRotorPos-Vector(150,0,0)) // offset
				ed:SetMagnitude(throttle)
				ed:SetRadius(30)
				util.Effect("wac_heatwave", ed)
			end
		end
	end
end