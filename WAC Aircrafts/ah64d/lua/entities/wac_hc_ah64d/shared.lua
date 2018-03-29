if not wac then return end

ENT.Base 			= "wac_hc_base"
ENT.Type 			= "anim"
ENT.PrintName		= "[WAC]Better AH-64D Apache"
ENT.Author			= "Gredwitch"
ENT.Category		= "Gredwitch's Stuff"
ENT.Spawnable		= true
ENT.AdminSpawnable	= false
ENT.EngineForce		= 160
ENT.Model			= "models/gredwitch/ah64d/apache-prop.mdl"
ENT.SmokePos		= Vector(37,0,75)
ENT.FirePos			= Vector(37,0,75)

ENT.BackRotor = {
	dir = 1,
	pos = Vector(-346,13,87),
	model = "models/gredwitch/ah64d/apache_backrotor.mdl",
}
ENT.TopRotor = {
	dir = 1,
	pos = Vector(22.3,0,90),
	model = "models/gredwitch/ah64d/apache_toprotor.mdl",
}
 
ENT.thirdPerson = {
	distance = 600,
}


ENT.Seats = {
	{
		pos = Vector(82, 0, 18),
		exit = Vector(100,90,0),
		weapons = {"Hydra 70"}
	},
	{
		pos = Vector(135, 0, 2),
		exit = Vector(134,90,0),
		weapons = {"M230","Hellfire","Stinger"}
	},
}

ENT.Wheels={
	{
		mdl="models/gredwitch/ah64d/apache_lw.mdl",
		pos=Vector(68,-39,-51),
		friction=70,
		mass=100,
	},
	{
		mdl="models/gredwitch/ah64d/apache_rw.mdl",
		pos=Vector(68,39,-51),
		friction=70,
		mass=100,
	},
	{
		mdl="models/gredwitch/ah64d/apache_bw.mdl",
		pos=Vector(-353,-4,-34),
		friction=70,
		mass=100,
	},
}


ENT.Weapons = {
	["Hydra 70"] = {
		class = "wac_pod_grocket",
		info = {
			Sequential = true,
			Pods = {
				Vector(69,64,-17),
				Vector(69,-64,-17)
			},
			Ammo = 38,
			FireRate = 400
		}
	},
	["Hellfire"] = {
		class = "wac_pod_mis",
		info = {
			Pods = {
				Vector(40.25,55.84,41.45),
				Vector(40.25,-55.84,41.45),
			},
			Ammo = 8,
			FireRate = 150,
		}
	},
	["Stinger"] = {
		class = "wac_pod_mis",
		info = {
			Pods = {
				Vector(55,-110,11),
				Vector(55,110,11),
			},
			Ammo = 4,
			FireRate = 150,
		}
	},
	["M230"] = {
		class = "wac_pod_gunner",
		info = {
			ShootPos = Vector(115,0,-33),
			ShootOffset = Vector(65, 0, 0),
			FireRate = 625,
			BulletType = "wac_base_30mm",
			Ammo = 1200,
			Sounds = {
				spin = "",
				shoot1p = "WAC/cannon/havoc_cannon_1p.wav",
				shoot3p = "WAC/cannon/havoc_cannon_3p.wav"
			},
		}
	},
}

ENT.WeaponAttachments={

	gunMount1 = {
		model = "models/gredwitch/ah64d/apache-prop_gun_pod.mdl",
		pos = Vector(120,-2,-25),
	},
	
	gun = {
		model = "models/gredwitch/ah64d/apache-prop_gun.mdl",
		pos = Vector(125,0,-34),
		localTo = "gunMount1",
	},
	
	gunMount2 = {
		model = "models/gredwitch/ah64d/apache_radar.mdl",
		pos = Vector(205,0,17),
	},
	
	
}

ENT.Camera = {
	model = "models/gredwitch/ah64d/apache_cam.mdl",
	pos = Vector(204,0,2),
	offset = Vector(-1,0,0),
	viewPos = Vector(30, 0, 3.5),
	maxAng = Angle(45, 90, 0),
	minAng = Angle(-2, -90, 0),
	seat = 2
}

ENT.Sounds={
	Start="WAC/ah64d/start.wav",
	Blades="WAC/ah64d/external.wav",
	Engine="WAC/ah64d/internal.wav",
	MissileAlert="HelicopterVehicle/MissileNearby.mp3",
	MissileShoot="WAC/ah64d/rocket_fire.wav",
	MinorAlarm="WAC/Heli/fire_alarm_tank.wav",
	LowHealth="WAC/Heli/fire_alarm.wav",
	CrashAlarm="WAC/Heli/FireSmoke.wav",
}