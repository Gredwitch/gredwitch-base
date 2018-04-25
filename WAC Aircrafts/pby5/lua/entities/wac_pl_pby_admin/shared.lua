if not wac then return end

ENT.Base 				= "wac_pl_base"
ENT.Type 				= "anim"
ENT.PrintName			= "[WAC]PBY-5 Catalina (Admin)"
ENT.Author				= "Gredwitch"
ENT.Category			= "Gredwitch's Stuff"
ENT.Spawnable			= true
ENT.AdminSpawnable	= true

ENT.Model			= "models/liam/pby5/pby5.mdl"
ENT.RotorPhModel	= "models/props_junk/sawblade001a.mdl"
ENT.RotorModel		= "models/liam/pby5/pby5prop.mdl"
ENT.rotorPos	= Vector(185, 64, 78)
ENT.BackRotorPos	= Vector(8, 0, -48)
ENT.EngineForce	= 196
ENT.Weight		= 6000
ENT.SmokePos		= ENT.rotorPos
ENT.FirePos		= ENT.SmokePos

ENT.OtherRotorPos={
	Vector(185,-64,78)
}

ENT.Agility = {
	Thrust = 15
}
ENT.thirdPerson = {
	distance = 600
}
ENT.Seats = {
	{
		pos=Vector(205,10,-7),
		weapons={"Front Browning M1919","250LB Bombs"},
		exit=Vector(215,42,48),
	},
	{
		pos=Vector(205,-10,-7),
		exit=Vector(-78,-42,-48),
	},
}
ENT.Weapons = {
	["250LB Bombs"] = {
		class = "wac_pod_gbomb",
		info = {
			Pods = {
				
				Vector  (100, 133.5, 51),
				Vector  (100,-132.5,51),
			},
			Admin = 1,
			Kind = "gb_bomb_250gp"
		}
	},
	["Front Browning M1919"] = {
		class = "wac_pod_mg",
		info = {
			Pods = {
				Vector  (290,0,65),
			},
			Sounds = {
				shoot = "wac/pby/shoot.wav",
				stop  = "wac/pby/stop.wav",
			},
			BulletType = "wac_base_7mm",
			FireRate = 1000,
			Ammo = 1,
			TkAmmo = 0
		}
	}
}
ENT.Sounds={
	Start="WAC/pby/start.wav",
	Blades="WAC/pby/external.wav",
	Engine="radio/american",
}
