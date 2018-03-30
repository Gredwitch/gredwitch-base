if not wac then return end
function ENT:MovePlayerView(k,p,md)
	if p.wac_air_resetview then md:SetViewAngles(Angle(0,90,0)) p.wac_air_resetview=false end
	local freeView = md:GetViewAngles()
	if !self.Seats or !self.Seats[k] then return end
	if (k==1 and p:GetInfo("wac_cl_air_mouse")=="1" and !p.wac.viewFree) then
		freeView.p = freeView.p-freeView.p*FrameTime()*6
		freeView.y = freeView.y-(freeView.y-90)*FrameTime()*6
	else
		freeView.p = math.Clamp(freeView.p,-90,90)
	end
	freeView.y = (freeView.y)
	md:SetViewAngles(freeView)
end
ENT.Base = "wac_pl_base"
ENT.Type = "anim"
ENT.Category = "Gredwitch's Stuff"
ENT.Spawnable = true
ENT.AdminSpawnable = true
ENT.PrintName = "[WAC]B-29 Super Fortress"
ENT.Model				= "models/gredwitch/b29_fixed.mdl"
ENT.RotorPhModel		= "models/props_junk/sawblade001a.mdl"
ENT.RotorModel			= "models/sentry/spitfire_prop.mdl"
ENT.Weight			= 25800
ENT.EngineForce		= 8800
ENT.rotorPos 	= Vector(290,-165,115)
ENT.FirePos			= ENT.rotorPos
ENT.SmokePos		= ENT.FirePos
ENT.MaxEnterDistance = 100
ENT.Engines = 4

ENT.OtherRotorPos={
	Vector(290,165,115),
	Vector(270,370,125),
	Vector(270,-370,125),
}

ENT.Agility = {
	Thrust = 13
}

ENT.thirdPerson = {
	distance = 1200
}


ENT.Wheels={
	{
		mdl="models/wac/fsx/b17g_rw.mdl",
		pos=Vector(89,-145,28),
		friction=0,
		mass=100,
	},
	{
		mdl="models/wac/fsx/b17g_rw.mdl",
		pos=Vector(89,-185,28),
		friction=0,
		mass=100,
	},
	{
		mdl="models/wac/fsx/b17g_lw.mdl",
		pos=Vector(89,145,28),
		friction=0,
		mass=100,
	},
	{
		mdl="models/wac/fsx/b17g_lw.mdl",
		pos=Vector(89,185,28),
		friction=0,
		mass=100,
	},
	{
		mdl="models/wac/fsx/b17g_bw.mdl",
		pos=Vector(490,10,18),
		friction=0,
		mass=100,
	},
	{
		mdl="models/wac/fsx/b17g_bw.mdl",
		pos=Vector(490,-10,18),
		friction=0,
		mass=100,
	},
	{
		mdl="models/wac/fsx/b17g_bw.mdl",
		pos=Vector(-500,0,86),
		friction=0,
		mass=1,
	},
}

ENT.Seats = {
	{
		pos=Vector(450,25,110),
		exit=Vector(500,100,20),
		weapons = {"500lb bombs"},
	},
	{
		pos=Vector(450,-25,110),
		exit=Vector(500,-100,20),
	},
	{
		pos=Vector(490,0,90),
		exit=Vector(500,-100,20),
		weapons = {"500lb bombs"},
	}
}

ENT.Weapons = {
	["500lb bombs"] = {
		class = "wac_pod_gbomb",
		info = {
			Pods = {
				Vector(200,-20,105), -- Front
				
				Vector(80,0,60), --Back
				
			},
			Kind = "gb_bomb_500gp",
			Admin = 1,
			Sounds = {
			    fire = "bomb/bomb_whistle_0"..math.random(1,4)..".wav"
			}
		}
	}
}

ENT.Sounds={
	Start="wac/b17g/startup.wav",
	Blades="wac/b17g/exterior.wav",
	Engine="radio/american.wav",
	MissileAlert="",
	MinorAlarm="wac/b17g/minor.wav",
	LowHealth="wac/b17g/low.wav",
	CrashAlarm="wac/b17g/crash.wav"
}
