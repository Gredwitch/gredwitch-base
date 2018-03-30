if not wac then return end

ENT.Base 				= "wac_hc_base"
ENT.Type 				= "anim"
ENT.PrintName			= "[WAC]Better UH-60L Black Hawk (Admin)"
ENT.Author				= "Gredwitch"
ENT.Category			= "Gredwitch's Stuff"
ENT.Spawnable		= true
ENT.AdminSpawnable	= true
ENT.Model			= "models/gredwitch/uh60l/uh-60l.mdl"
ENT.SmokePos		= Vector(-104.32,36,98.752)
ENT.FirePos			= Vector(-104.32,36,98.752)
ENT.maxEnterDistence = 400
ENT.EngineForce	= 53
ENT.Weight		= 9980
ENT.thirdPerson = {
	distance = 800
}
ENT.TopRotor = {
	dir = -1,
	pos = Vector(-86,-14,100),
	model = "models/gredwitch/uh60l/uh-60l_tr.mdl"
}

ENT.BackRotor = {
	dir = -1,
	pos = Vector(-535,-25,100),
	model = "models/gredwitch/uh60l/uh-60l_br.mdl"
}

ENT.Wheels={
	{
		mdl="models/gredwitch/uh60l/uh-60l_lw.mdl",
		pos=Vector(-423,-13,-63),
		friction=60,
		mass=600,
	},
	{
		mdl="models/gredwitch/uh60l/uh-60l_lw.mdl",
		pos=Vector(-21,52,-31),
		friction=60,
		mass=600,
	},
	{
		mdl="models/gredwitch/uh60l/uh-60l_rw.mdl", 
		pos=Vector(-21,-80,-31),
		friction=60,
		mass=600,
	},

}
ENT.Seats = {
	{
		pos=Vector(60, -42, 25),
		exit=Vector(50, -90, 0),
		weapons={"M240G Machinegun"},
	},
	{
		pos=Vector(60, 14, 25),
		exit=Vector(50, 90, 0),
	},
	{
		pos=Vector(-5, 11, 13),
		ang=Angle(0,90,0),
		exit=Vector(0, 90, 0),
		weapons={"M240G Turret"},
	},
	{
		pos=Vector(-5, -39, 13),
		ang=Angle(0,-90,0),
		exit=Vector(0, -132, 0),
	},
	
	
	{
		pos=Vector(-67,18.6,9),
		ang=Angle(0,180,0),
		exit=Vector(-70, 90, 0),
	},
	{
		pos=Vector(-67,-3,9),
		ang=Angle(0,180,0),
		exit=Vector(-70, 90, 0),
	},
	{
		pos=Vector(-67,-24,9),
		ang=Angle(0,180,0),
		exit=Vector(-70, -132, 0),
	},
	{
		pos=Vector(-67,-45,9),
		ang=Angle(0,180,0),
		exit=Vector(-70, -132, 0),
	},
	
	{
		pos=Vector(-138,-45,5),
		exit=Vector(-70, -132, 0),
	},
	{
		pos=Vector(-138,-24,5),
		exit=Vector(-70, -132, 0),
	},
	{
		pos=Vector(-138,-3,5),
		exit=Vector(-70, 90, 0),
	},
	{
		pos=Vector(-138,18,5),
		exit=Vector(-70, 90, 0),
	},
	
	
	{
		pos=Vector(-33,6,11),
		exit=Vector(0, 90, 0),
	},
	{
		pos=Vector(-33,-13,11),
		exit=Vector(0, 90, 0),
	},
	{
		pos=Vector(-33,-34,11),
		exit=Vector(0, -132, 0),
	},
}

ENT.Weapons = {
	["M240G Machinegun"] = {
		class = "wac_pod_mg",
		info = {
			Pods = {
				Vector(27,-85,38),
			},
			Ammo = 1,
			TkAmmo = 0,
			FireRate = 850,
			BulletType = "wac_base_7mm",
			Sounds = {
				shoot = "WAC/uh60l/gun.wav",
				stop = "WAC/uh60l/gun_stop.wav",
			}
		}
	},
	["M240G Turret"] = {
		class = "wac_pod_gunner",
		info = {
			ShootPos = Vector(-15,62,34),
			ShootOffset = Vector(24,57,38),
			FireRate = 850,
			Ammo = 1,
			TkAmmo = 0,
			BulletType = "wac_base_7mm",
			Sounds = {
				spin = "WAC/uh60l/gun.wav",
				shoot1p = "",
				shoot3p = "WAC/uh60l/gun_stop.wav",
			}
		}
	},
}

ENT.WeaponAttachments = {
	gun = {
		model = "models/gredwitch/uh60l/m240_turret.mdl",
		pos = Vector(-8,61,32),
		restrictPitch = false,
	}

}
ENT.Camera = {
	model = "models/mm1/box.mdl",
	pos = Vector(-14,70,3),
	offset = Vector(1,0,0),
	viewPos = Vector(7, 0, 3.5),
	minAng = Angle(-180, -180, -180),
	maxAng = Angle(180, 180, 180),
	seat = 3
}

ENT.Sounds = {
	Start = "WAC/Heli/h6_start.wav",
	Blades = "WAC/Heli/uh60_loop.wav",
	Engine = "",
	MissileAlert = "HelicopterVehicle/MissileNearby.mp3",
	MissileShoot = "HelicopterVehicle/MissileShoot.mp3",
	MinorAlarm = "HelicopterVehicle/MinorAlarm.mp3",
	LowHealth = "HelicopterVehicle/LowHealth.mp3",
	CrashAlarm = "HelicopterVehicle/CrashAlarm.mp3",
	Radio =  "HelicopterVehicle/MissileNearby.mp3",
}
