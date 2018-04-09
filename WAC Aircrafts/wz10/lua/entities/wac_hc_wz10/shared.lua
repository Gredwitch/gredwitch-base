ENT.Base 		   		= "wac_hc_base"
ENT.Type 		   		= "anim"
ENT.Author 		   		= "Gredwitch"
ENT.Category 	   		= "Gredwitch's Stuff"
ENT.Spawnable     		= true
ENT.AdminSpawnable		= true
ENT.SmokePos 	   		= Vector(-80,0,50)
ENT.FirePos		    	= Vector(-50,0,100)
ENT.MaxEnterDistance 	= 100
ENT.EngineForce			= 50
ENT.Weight 				= 9000
ENT.PrintName 			= "[WAC]CAIC WZ-10"
ENT.Model 				= "models/gredwitch/wz10/wz10.mdl"
ENT.WheelStabilize		=-150

ENT.thirdPerson = {
	distance = 800
}
ENT.TopRotor = {
	pos = Vector(-37.7385,0,92.9699),
	model = "models/gredwitch/wz10/wz10_topRotor.mdl",
}
ENT.BackRotor = {
	pos = Vector(-357.241,-23.5561,90.1976),
	model = "models/gredwitch/wz10/wz10_backRotor.mdl",
}
ENT.Wheels = {
	{
		mdl="models/gredwitch/wz10/wz10_wb.mdl",
		pos=Vector(-299.50187,0,-46.9075),
		friction=100,
		mass=200,
	},
	{
		mdl="models/gredwitch/wz10/wz10_wl.mdl",
		pos=Vector(22.8066,47.3208,-42.7124),
		friction=100,
		mass=200,
	},
	{
		mdl="models/gredwitch/wz10/wz10_wr.mdl",
		pos=Vector(22.8041,-47.2894,-42.7101),
		friction=100,
		mass=200,
	},
}
ENT.Seats = {
	{
		pos = Vector(70,0,0),
		exit = Vector(70,60,5),
		weapons = {"57mm rockets"}
	},
	{
		pos = Vector(10,0,25),
		exit = Vector(10,80,5),
		weapons = {"30mm cannon", "ADK-10"}
	},
}

ENT.Weapons = {
	["30mm cannon"] = {
		class = "wac_pod_gunner",
		info = {
			ShootPos = Vector(140, 0, -35),
			ShootOffset = Vector(100, -1, 0),
			FireRate = 800,
			Ammo = 1000,
			TracerColor = "Green",
			BulletType = "wac_base_30mm",
			Sounds = {
				spin = "",
				shoot1p = "WAC/cannon/havoc_cannon_1p.wav",
				shoot3p = "WAC/cannon/havoc_cannon_3p.wav"
			}
		}
	},
	["57mm rockets"] = {
		class = "wac_pod_grocket",
		info = {
			Pods = {
				Vector(17,60,-12),
				Vector(17,-60,-12),
			},
			Ammo = 16,
			FireRate = 300,
		}
	},
	["ADK-10"] = {
		class = "wac_pod_mis",
		info = {
			Pods = {
				Vector(52.3301,-106.549,-18.4638),
				Vector(52.3301,106.549,-18.4638),
			},
			Firerate = 50,
			Ammo = 2,
			
		}
	}
}


ENT.Sounds = {
	Start = "WAC/Heli/ah1_start.wav",
	Blades = "npc/attack_helicopter/aheli_rotor_loop1.wav",
	Engine = "WAC/heli/bellinternal.wav",
	MissileAlert = "HelicopterVehicle/MissileNearby.mp3",
	MissileShoot = "HelicopterVehicle/MissileShoot.mp3",
	MinorAlarm = "HelicopterVehicle/MinorAlarm.mp3",
	LowHealth = "HelicopterVehicle/LowHealth.mp3",
	CrashAlarm = "HelicopterVehicle/CrashAlarm.mp3",
}


ENT.Camera = {
	model = "models/gredwitch/wz10/wz10_camera.mdl",
	pos = Vector(156.083,0,-5.95776),
	offset = Vector(1,0,0),
	viewPos = Vector(7, 0, 3.5),
	maxAng = Angle(50, 90, 0),
	minAng = Angle(-5, -90, 0),
	seat = 2
}


ENT.WeaponAttachments = {
	
	gunMount1 = {
		model = "models/gredwitch/wz10/wz10_gunpod.mdl",
		pos = Vector(124.302,0,-32.8411),
		restrcitPitch = true
	},
	gun = {
		model = "models/gredwitch/wz10/wz10_gun.mdl",
		pos = Vector(115.133,0,-27.297),
		offset = Vector(0,-1,0),
	}
}