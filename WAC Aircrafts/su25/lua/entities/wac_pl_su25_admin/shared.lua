if not wac then return end
if SERVER then AddCSLuaFile('shared.lua') end
if GetConVarNumber("gred_jets_speed") >= 1 then jetspeed = 35.5 else jetspeed = 33 end
ENT.Base 				= "wac_pl_base"
ENT.Type 				= "anim"
ENT.Category			= "Gredwitch's Stuff"
ENT.PrintName			= "[WAC]Su-39 Frogfoot (Admin)"
ENT.Author				= "Gredwitch"

ENT.Spawnable			= true
ENT.AdminSpawnable		= true

ENT.Engines = 2
ENT.Model	    = "models/hawx/su39.mdl"
ENT.RotorPhModel        = "models/props_junk/sawblade001a.mdl"
ENT.RotorModel        = "models/props_junk/PopCan01a.mdl"

ENT.rotorPos	= Vector(0,0,100)
ENT.TopRotorDir	= 1.0
ENT.AutomaticFrameAdvance = true
ENT.EngineForce	= 611
ENT.Weight	    = 14600
ENT.SeatSwitcherPos	= Vector(0,0,0)
ENT.AngBrakeMul	= 0.02
ENT.SmokePos	= Vector(-123.33,33.703,79.364)
ENT.FirePos	    = Vector(-123.33,-33.703,79.364)

ENT.thirdPerson={
	distance = 600,
	position = Vector(0,0,150)
}

ENT.Agility = {
	Thrust = jetspeed
}

ENT.Wheels={
	{
		mdl="models/hawx/su39_front.mdl",
		pos=Vector(135.134,0.062,14.956),
		friction=10,
		mass=1200,
	},
	{
		mdl="models/hawx/su39_left.mdl",
		pos=Vector(-33.292,51.829,38.138),
		friction=10,
		mass=600,
	},
	{
		mdl="models/hawx/su39_right.mdl",
		pos=Vector(-33.2928,-51.829,38.138),
		friction=10,
		mass=600,
	},
}

ENT.Seats = {
	{
		pos=Vector(133,0,76),
		exit=Vector(141.354,0,150),
		weapons={"GSh-30-2", "FAB-250", "S-5", "Kh-23"}
	}
}

ENT.Weapons = {
	["GSh-30-2"] = {
		class = "wac_pod_mg",
		info = {
			Pods = {
				Vector(255,11.985,58.914),
				Vector(255,11.985,58.914)
			},
			BulletType = "wac_base_30mm",
			TracerColor = "Green",
			Ammo = 1,
			TkAmmo = 0,
			FireRate = 1500,
			Sounds = {
				shoot = "WAC/a10/gun.wav",
				stop = "WAC/a10/gun_stop.wav"
			}
		}
	},
	["FAB-250"] = {
		class = "wac_pod_gbomb",
		info = {
			Pods = {
				Vector(-25.056,109.104,84.764),
				Vector(-25.056,-106.742,84.764),
				Vector(-17.084,76.612,84.764),
				Vector(-17.084,-74.249,84.764),
			},
			Kind = "gb_bomb_fab250",
			Admin = 1,
		}
	},
	["S-5"] = {
		class = "wac_pod_grocket",
		info = {
			Ammo = 1,
			TkAmmo = 0,
			FireRate = 400,
			Pods = {
				Vector(-21.653, -140.145, 76.268),
				Vector(-21.653, 141.346, 76.268)
			},
		},
	},
	["Kh-23"] = {
		class = "wac_pod_mis",
		info = {
			Ammo = 1,
			TkAmmo = 0,
			MaxRange = 50000,
			Pods = {
				Vector(-39.53,206.319,83.264),
				Vector(-39.53,-203.96,83.264),
				Vector(-39.53,173.015,83.264),
				Vector(-39.53,-170.661,83.264),
			}
		}
	}
}

ENT.Camera = {
	model = "models/mm1/box.mdl",
	pos = Vector(254.548,0,69),
	offset = Vector(-1,0,0),
	viewPos = Vector(2,0,0),
	maxAng = Angle(45, 90, 0),
	minAng = Angle(-2, -90, 0),
	seat = 1
}

ENT.Sounds={
	Start="WAC/A10/Start.wav",
	Blades="WAC/A10/external.wav",
	Engine="WAC/A10/internal.wav",
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
		local ent=LocalPlayer():GetVehicle():GetNWEntity("wac_aircraft")
		if ent==self and active and throttle > 0.2 and CurTime()>cureffect then
			cureffect=CurTime()+0.02
			local ed=EffectData()
			ed:SetEntity(self)
			ed:SetOrigin(Vector(-123.33,0,79.364)) // offset
			ed:SetMagnitude(throttle)
			ed:SetRadius(25)
			util.Effect("wac_heatwave", ed)
		end
	end
end

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