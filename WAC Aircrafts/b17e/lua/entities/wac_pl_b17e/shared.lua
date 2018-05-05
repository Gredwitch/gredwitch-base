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

ENT.Base 				= "wac_pl_base"
ENT.Type				= "anim"
ENT.Category			= "Gredwitch's Stuff"
ENT.Spawnable 			= true
ENT.AdminSpawnable 		= true
ENT.PrintName 			= "[WAC]B-17E Flying Fortress"
ENT.Model				= "models/gredwitch/b-17e/b-17e.mdl"
ENT.RotorPhModel		= "models/props_junk/sawblade001a.mdl"
ENT.RotorModel			= "models/gredwitch/b-17e/b-17e_prop.mdl"
ENT.Weight				= 29700
ENT.EngineForce			= 250
ENT.rotorPos 			= Vector(120,-288.5,-23)
ENT.FirePos			 	= ENT.rotorPos
ENT.SmokePos		 	= ENT.rotorPos
ENT.MaxEnterDistance 	= 100
ENT.Engines			 	= 4
ENT.thirdPerson			= {
	distance = 1200
}
ENT.OtherRotorPos={
	Vector(148,-135,-34),
	Vector(148,130,-34),
	Vector(120,283,-23)
}

ENT.Agility = {
	Thrust = 13
}

ENT.Wheels={
	{
		mdl="models/gredwitch/b-17e/b-17e_wl.mdl",--r
		pos=Vector(10,-142,-114.5),
		friction=0,
		mass=1500,
	},
	{
		mdl="models/gredwitch/b-17e/b-17e_wl.mdl",
		pos=Vector(10,136,-114.5),
		friction=0,
		mass=1500,
	},
	{
		mdl="models/gredwitch/b-17e/b-17e_wb.mdl",
		pos=Vector(-475,2,-68),
		friction=0,
		mass=1000,
	},
}

ENT.Seats = {
	{
		pos=Vector(99,13,0),
		exit=Vector(217,100,-20),
		weapons={"Front Browning","250lb bombs"}
	},
	{
		pos=Vector(99,-20,0),
		exit=Vector(217,-100,-20),
	},
	{
		pos=Vector(217,-6,-32),
		exit=Vector(217,-100,-32),
	},
	{
		pos=Vector(47.5,-4,25),
		ang=Angle(0,180,0),
		exit=Vector(217,-100,-47),
		weapons={"Remote M2 Browning"},
	},
}

ENT.Weapons = {
	["Front Browning"] = {
		class = "wac_pod_mg",
		info = {
			Pods = {
				Vector(291,16,-5.5),
			},
			Ammo = 500,
			Sounds = {
			    shoot = "wac/b17g/shoot_start.wav",
				stop = "wac/b17g/shoot_end.wav",
			},
			FireRate = 1000,
		}
	},
	["250lb bombs"] = {
		class = "wac_pod_gbomb",
		info = {
			Pods = {
				Vector(-33,-84,-80),
				Vector(-33,79,-80),
				
				Vector(0,31,-45),
				Vector(0,-38,-45),
				Vector(-60,31,-45),
				Vector(-60,-38,-45),
				
				Vector(0,11,-45),
				Vector(0,-18,-45),
				Vector(-60,11,-45),
				Vector(-60,-18,-45),
				
				Vector(-30,17,-25),
				Vector(-30,-24,-25),
			},
			Kind = "gb_bomb_250gp",
			Sounds = {
			    fire = "bomb/bomb_whistle_0"..math.random(1,4)..".wav"
			},
			FireRate = 1000,
		}
	},
	["Remote M2 Browning"] = {
		class = "wac_pod_gunner",
		info = {
			ShootPos = Vector(34.4722,-1.86747,57.6693),
			ShootOffset = Vector(30,0,0),
			FireRate = 500,
			Sounds = {
			    shoot1p = "",
				spin = "wac/b17g/shoot_start.wav",
				shoot3p = "",
			}
		}
	}
}

ENT.WeaponAttachments={

	gunMount1 = {
		model = "models/gredwitch/b-17e/b-17e_gunmount.mdl",
		pos = Vector(43.3282,-2.88671,61.2132),-- 43
		restrictPitch = true,
	},
	
	gun = {
		model = "models/gredwitch/b-17e/b-17e_gun.mdl",
		pos = Vector(43.4722,-1.86747,57.6693), --34
	},
	
}

ENT.Camera = {
	model = "models/mm1/box.mdl",
	pos = Vector(47.5,-4,80),
	offset = Vector(0,0,0),
	viewPos = Vector(10, 0, 0),
	minAng = Angle(-60, -360,0),
	maxAng = Angle(25, 360,0),
	seat = 4
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