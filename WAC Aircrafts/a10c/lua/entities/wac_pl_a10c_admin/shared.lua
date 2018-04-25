if not wac then return end
if SERVER then AddCSLuaFile('shared.lua') end
ENT.Base 				= "wac_pl_base"
ENT.Type 				= "anim"
ENT.Category			= "Gredwitch's Stuff"
ENT.PrintName			= "[WAC]A-10C Thunderbolt II (Admin)"
ENT.Author				= "Gredwitch"
ENT.Spawnable			= true
ENT.AdminSpawnable		= true
ENT.Engines = 2
ENT.Model	    = "models/gredwitch/a10/a10.mdl"
ENT.RotorPhModel	= "models/props_junk/sawblade001a.mdl"
ENT.RotorModel	= "models/gredwitch/a10/a10_lrotor.mdl"
ENT.RotorModel2	= "models/gredwitch/a10/a10_rrotor.mdl"

ENT.rotorPos	= Vector(-102,57,40.5)
ENT.rotorPos2	= Vector(-102,-57,40.5)

ENT.TopRotorDir	= 1

ENT.EngineForce	= 5000
ENT.Weight	    = 3347
ENT.SeatSwitcherPos	= Vector(0,0,0)
ENT.AngBrakeMul	= 0.02
ENT.SmokePos	= ENT.rotorPos
ENT.FirePos	    = ENT.rotorPos

if CLIENT then
	ENT.thirdPerson = {
		distance = 700
	}
end

ENT.Agility = {
	Thrust = 30
}
ENT.Wheels={
	{
		mdl="models/gredwitch/a10/a10_wf.mdl",
		pos=Vector(179,-15,-78),
		friction=0,
		mass=1200,
	},
	{
		mdl="models/gredwitch/a10/a10_wl.mdl",
		pos=Vector(-36,98.5,-71.5),
		friction=0,
		mass=500,
	},
	{
		mdl="models/gredwitch/a10/a10_wr.mdl",
		pos=Vector(-36,-98.5,-71.5),
		friction=0,
		mass=500,
	},
}

ENT.Seats = {
	{
		pos=Vector(165,0,15),
		exit=Vector(126.5,70,20),
		weapons={"GAU-8 Avenger", "Hydra 70", "AIM-9 Missiles", "MK-82 Bombs", "CBU-52U Bombs"}
	},
}

ENT.Weapons = {
	["GAU-8 Avenger"] = {
		class = "wac_pod_mg",
		info = {
			Pods = {
				Vector(295,3,-16),
			},
			BulletType = "wac_base_30mm",
			Ammo = 1,
			TkAmmo = 0,
			FireRate = 3900,
			Brrt = 1,
			Sounds = {
				shoot = "WAC/a10/gun.wav",
				stop = "WAC/a10/gun_stop.wav"
			}
		}
	},
	
	["Hydra 70"] = {
		class = "wac_pod_grocket",
		info = {
			Sequential = true,
			Pods = {
				Vector(22,196.5,-18.5),
				Vector(22,-196.5,-18.5),
			},
			FireRate = 350,
			Ammo = 1,
			TkAmmo = 0,
		}
	},
	["AIM-9 Missiles"] = {
		class = "wac_pod_mis",
		info = {
			Sequential = true,
			Pods = {
				Vector(70,241,-12),
				Vector(70,-241,-12),
			},
			Ammo = 1,
			TkAmmo = 0,
			model = "models/hawx/aim-9 sidewinder.mdl",
			FireRate = 60,
		}
	},
	["MK-82 Bombs"] = {
	    class = "wac_pod_gbomb",
	    info = {
		    Kind = "gb_bomb_mk82",
	        Sequential = true,
	        Pods = {
				Vector(-4,64,-29),
				Vector(-4,-64,-29),
			},
			FireRate = 300,
			Admin = 1
		}
	},
	["CBU-52U Bombs"] = {
	    class = "wac_pod_gbomb",
	    info = {
		    Kind = "gb_bomb_cbu",
	        Sequential = true,
	        Pods = {
				Vector(-6,22,-31),
				Vector(-6,-22,-31),
			},
			FireRate = 300,
			Admin = 1
		}
	}
}

ENT.Sounds={
	Start="WAC/A10/Start.wav",
	Blades="WAC/A10/external.wav",
	Engine="wac/a10/radiochat.mp3",
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
			if ent==self and active and throttle > 0.2 and CurTime()>cureffect then
				cureffect=CurTime()+0.02
				local ed=EffectData()
				ed:SetEntity(self)
				ed:SetOrigin(Vector(-217,57,40.5))
				ed:SetMagnitude(throttle)
				ed:SetRadius(25)
				util.Effect("wac_heatwave", ed)
				
				local ed=EffectData()
				ed:SetEntity(self)
				ed:SetOrigin(Vector(-217,-57,40.5))
				ed:SetMagnitude(throttle)
				ed:SetRadius(25)
				util.Effect("wac_heatwave", ed)
			end
		end
	end
end


ENT.Camera = {
	model = "models/mm1/box.mdl",
	pos = Vector(200,-25,-35),
	offset = Vector(-1,0,0),
	viewPos = Vector(2,0,0),
	maxAng = Angle(45, 90, 0),
	minAng = Angle(-2, -90, 0),
	seat = 1
}

//hud

local function DrawLine(v1,v2)
	surface.DrawLine(v1.y,v1.z,v2.y,v2.z)
end

local mHorizon0 = Material("WeltEnSTurm/WAC/Helicopter/hud_line_0")
local HudCol = Color(70,199,50,150)
local Black = Color(0,0,0,200)

local mat = {
	Material("WeltEnSTurm/WAC/Helicopter/hud_line_0"),
	Material("WeltEnSTurm/WAC/Helicopter/hud_line_high"),
	Material("WeltEnSTurm/WAC/Helicopter/hud_line_low"),
}

local function getspaces(n)
	if n<10 then
		n="      "..n
	elseif n<100 then
		n="    "..n
	elseif n<1000 then
		n="  "..n
	end
	return n
end


function ENT:DrawPilotHud()
	local pos = self:GetPos()
	local ang = self:GetAngles()
	ang:RotateAroundAxis(self:GetRight(), 90)
	ang:RotateAroundAxis(self:GetForward(), 90)

	local uptm = self.SmoothVal
	local upm = self.SmoothUp
	local spos=self.Seats[1].pos

	cam.Start3D2D(self:LocalToWorld(Vector(30,3.75,37.75)+spos), ang,0.015)
	surface.SetDrawColor(HudCol)
	surface.DrawRect(234, 247, 10, 4)
	surface.DrawRect(254, 247, 10, 4)
	surface.DrawRect(247, 234, 4, 10)
	surface.DrawRect(247, 254, 4, 10)

	local a=self:GetAngles()
	a.y=0
	local up=a:Up()
	up.x=0
	up=up:GetNormal()

	local size=180
	local dist=10
	local step=12
	for p=-180,180,step do
		if a.p+p>-size/dist and a.p+p<size/dist then
			if p==0 then
				surface.SetMaterial(mat[1])
			elseif p>0 then
				surface.SetMaterial(mat[2])
			else
				surface.SetMaterial(mat[3])
			end
			surface.DrawTexturedRectRotated(250+up.y*(a.p+p)*dist,250-up.z*(a.p+p)*dist,300,300,a.r)
		end
	end

	surface.SetTextColor(HudCol)
	surface.SetFont("wac_heli_small")

	surface.SetTextPos(30, 410) 
	surface.DrawText("SPD  "..math.floor(self:GetVelocity():Length()*0.1) .."kn")
	surface.SetTextPos(30, 445)
	local tr=util.QuickTrace(pos+self:GetUp()*10,Vector(0,0,-999999),self.Entity)
	surface.DrawText("ALT  "..math.ceil((pos.z-tr.HitPos.z)*0.01905).."m")

	cam.End3D2D()
end