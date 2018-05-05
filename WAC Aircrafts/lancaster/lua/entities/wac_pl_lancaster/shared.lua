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
ENT.PrintName 			= "[WAC]Avro Lancaster B Mk III"
ENT.Model				= "models/gredwitch/lancaster/lancaster.mdl"
ENT.RotorPhModel		= "models/props_junk/sawblade001a.mdl"
ENT.RotorModel			= "models/gredwitch/lancaster/lancaster_prop.mdl"
ENT.Weight				= 29700
ENT.EngineForce			= 250
ENT.rotorPos 			= Vector(185,-141,-4)
ENT.FirePos			 	= ENT.rotorPos
ENT.SmokePos		 	= ENT.rotorPos
ENT.MaxEnterDistance 	= 100
ENT.Engines			 	= 4
ENT.thirdPerson			= {
	distance = 1200
}
ENT.OtherRotorPos={
	Vector(185,144,-4),
	Vector(162,-310,7.5),
	Vector(162,310,7.5),
}

ENT.Agility = {
	Thrust = 14
}

ENT.Wheels={
	{
		mdl="models/gredwitch/lancaster/lancaster_wl.mdl",
		pos=Vector(57,143,-100),
		friction=0,
		mass=1500,
	},
	{
		mdl="models/gredwitch/lancaster/lancaster_wr.mdl",
		pos=Vector(57,-140.5,-100),
		friction=0,
		mass=1500,
	},
	{
		mdl="models/gredwitch/lancaster/lancaster_wb.mdl",
		pos=Vector(-429,0,-43),
		friction=0,
		mass=1000,
	},
}

ENT.Seats = {
	{
		pos=Vector(160,10,15),
		exit=Vector(217,100,-20),
		weapons={"M1919 Browning","500lb bombs"}
	},
	{
		pos=Vector(243.227,0,-10),
		exit=Vector(217,100,-20),
	},
	{
		pos=Vector(-505,0,5),
		ang=Angle(0,180,0),
		exit=Vector(217,100,-20),
		weapons={"M2 Browning turret"}
	},
}

ENT.Weapons = {
	["M1919 Browning"] = {
		class = "wac_pod_mg",
		info = {
			Pods = {
				Vector(-204,-7,68),
				Vector(-204,7,68),
				
				Vector(292,7,30),
				Vector(292,-7,30),
			},
			Ammo = 4000,
			Sounds = {
			    shoot = "wac/b17g/shoot_start.wav",
				stop = "wac/b17g/shoot_end.wav",
			},
			BulletType = "wac_base_7mm",
			FireRate = 1000,
		}
	},
	["500lb bombs"] = {
		class = "wac_pod_gbomb",
		info = {
			Pods = {
				Vector(150,15,-20),
				Vector(150,-15,-20),
				Vector(150,5,-20),
				Vector(150,-5,-20),
				
				Vector(60,15,-20),
				Vector(60,-15,-20),
				Vector(60,5,-20),
				Vector(60,-5,-20),
				
				Vector(-30,5,-20),
				Vector(-30,-5,-20),
				Vector(-30,15,-20),
				Vector(-30,-15,-20),
				
				Vector(-120,15,-20),
				Vector(-120,-15,-20),
			},
			Kind = "gb_bomb_500gp",
			Sounds = {
			    fire = "bomb/bomb_whistle_0"..math.random(1,4)..".wav"
			},
			FireRate = 1000,
		}
	},
	["M2 Browning turret"] = {
		class = "wac_pod_gunner",
		info = {
			ShootPos = Vector(-520,0,25),
			ShootOffset = Vector(40, 0, 0),
			FireRate = 1700,
			Ammo = 5000,
			Sounds = {
				shoot3p = "",
				shoot1p = "",
				spin = "wac/fsx/whitley/m1919_fire.wav",
			}
		}
	}
}

ENT.WeaponAttachments={

	gun = {
		model = "models/gredwitch/lancaster/lancaster_turret.mdl",
		pos =  Vector(-513.901,0,21.4862),
	},
	
}

ENT.Camera = {
	model = "models/mm1/box.mdl",
	pos = Vector(-520,0,30),
	offset = Vector(0,0,0),
	viewPos = Vector(10, 0, 10),
	minAng = Angle(-60, -360,0),
	maxAng = Angle(25, 360,0),
	seat = 3
}

ENT.Sounds={
	Start="wac/lancaster/start.wav",
	Blades="wac/lancaster/external.wav",
	Engine="wac/lancaster/internal.wav",
	MissileAlert="",
	MinorAlarm="",
	LowHealth="",
	CrashAlarm=""
}