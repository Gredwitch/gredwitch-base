if not wac then return end
ENT.Base = "wac_pl_base"
ENT.Type = "anim"
ENT.Category = "Gredwitch's Stuff"
ENT.Spawnable = true
ENT.AdminSpawnable = true

ENT.PrintName = "[WAC]B-17G Flying Fortress (Admin)"

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

ENT.Model				= "models/wac/fsx/b17g.mdl"
ENT.RotorPhModel		= "models/props_junk/sawblade001a.mdl"
ENT.RotorModel			= "models/wac/fsx/b17g_prop.mdl"
ENT.FirePos			= Vector(-1.969,-117.48,-22.126)
ENT.SmokePos		= ENT.FirePos
ENT.Weight			= 29700
ENT.EngineForce		= 250
ENT.Engines = 4
ENT.engineHealth = 450
ENT.rotorPos 	= Vector(126.396,-117.559,-22.52)
ENT.MaxEnterDistance = 100

ENT.OtherRotorPos={
	Vector(126.553,117.559,-22.441),
	Vector(107.467,-255.276,-15.354),
	Vector(107.323,255.276,-15.354)
}

ENT.Agility = {
	Thrust = 10
}

ENT.Wheels={
	{
		mdl="models/wac/fsx/b17g_rw.mdl",
		pos=Vector(-2.283,-129.685,-84.961),
		friction=0,
		mass=1500,
	},
	{
		mdl="models/wac/fsx/b17g_lw.mdl",
		pos=Vector(-2.283,128.11,-85.039),
		friction=0,
		mass=1500,
	},
	{
		mdl="models/wac/fsx/b17g_bw.mdl",
		pos=Vector(-428.597,0,-60.707),
		friction=0,
		mass=1000,
	},
}

ENT.Seats = {
	{
		pos=Vector(87.48,14.646,8.425),
		exit=Vector(115,40,20),
		weapons = {"M2 Browning", "250lb bombs"},
	},
	{
		pos=Vector(87.402,-14.331,8.425),
		exit=Vector(115,40,20),
	},
	{
		pos=Vector(196.772,0.315,-5.591),
		exit=Vector(115,40,20),
	},
	{
		pos=Vector(151.969,6.693,-14.252),
		ang=Angle(0,90,0),
		exit=Vector(115,40,20),
	},
	{
		pos=Vector(-124.173,24.724,-24.094),
		exit=Vector(115,40,20),
		weapons = {"Remote M2 Browning"},
	},--[[
	{
		pos=Vector(-302,0,-25),
		ang=Angle(0,90,0),
		exit=Vector(115,40,20),
		weapons = {"Back left M2 Browning"}
	},
	{												Not fucking working
		pos=Vector(-267,0,-25),
		ang=Angle(0,-90,0),
		exit=Vector(115,40,20),
		weapons = {"Back right M2 Browning"}
	}--]]
}

ENT.Weapons = {
	["M2 Browning"] = {
		class = "wac_pod_mg",
		info = {
			Pods = {
				Vector(85.039,-10.315,61.339),
				Vector(237.638,-8.583,-36.457),
				Vector(85.039,10.236,61.339),
				Vector(237.795,8.661,-36.457),
			},
			Sequential = true,
			TkAmmo = 0,
			Sounds = {
			    shoot = "wac/b17g/shoot_start.wav",
				stop = "wac/b17g/shoot_end.wav",
			},
			FireRate = 500,
		}
	},
	["250lb bombs"] = {
		class = "wac_pod_gbomb",
		info = {
			Pods = {
				Vector(-30,14,-40.0),
			},
			Kind = "gb_bomb_250gp",
			Admin = 1,
			Sounds = {
			    fire = "bomb/bomb_whistle_0"..math.random(1,4)..".wav"
			},
			FireRate = 1000,
		}
	},
	["Remote M2 Browning"] = {
		class = "wac_pod_gunner",
		info = {
			ShootPos = Vector(-179.974,5.5,-40.309),
			ShootOffset = Vector(30,0, 0),
			FireRate = 500,
			TkAmmo = 0,
			Sounds = {
			    shoot = "wac/b17g/shoot_start.wav",
				spin = "";
				stop = "wac/b17g/shoot_end.wav",
			},
		}
	},--[[
	["Back left M2 Browning"] = {
		class = "wac_pod_gunner",
		info = {
			ShootPos = Vector(-300, 70, 0),
			ShootOffset = Angle(0, -90, 0),
			FireRate = 500,
		}
	},
	["Back right M2 Browning"] = {
		class = "wac_pod_gunner",
		info = {
			ShootPos = Vector(-270,0,5),
			ShootOffset = Vector(0, 80, 0),
			FireRate = 500,
		}
	},--]]
}

ENT.WeaponAttachments={

	gunMount1 = {
		model = "models/wac/fsx/b17g_turret_rotator.mdl",
		pos = Vector(-197.48,0.079,8.189),
		restrictPitch = true,
	},
	
	gunMount2 = {
		model = "models/wac/fsx/b17g_turret_pod.mdl",
		pos = Vector(-196.614,0.079,-51.181),
		localTo = "gunMount1",
	},
	
	gun = {
		model = "models/mm1/box.mdl",
		pos = Vector(-182,0.157,-40.309),
		localTo = "gunMount2",
	},
	
	radar1 = {
		model = "models/mm1/box.mdl",
		pos = Vector(-182,0.157,-40.309),
		restrictPitch = true,
	},
	
}

ENT.Camera = {
	model = "models/mm1/box.mdl",
	pos = Vector(-179.974,5.157,-50.309),
	offset = Vector(-1,0,0),
	viewPos = Vector(10, 0, 0),
	minAng = Angle(4, -90, 0),
	maxAng = Angle(180, 180, 180),
	seat = 5
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

function ENT:DrawPilotHud() end
function ENT:DrawWeaponSelection() end