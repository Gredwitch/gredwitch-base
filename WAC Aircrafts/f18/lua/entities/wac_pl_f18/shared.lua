if not wac then return end
if SERVER then AddCSLuaFile('shared.lua') end
if GetConVarNumber("gred_jets_speed") >= 1 then jetspeed = 42 else jetspeed = 33 end
ENT.Base 				= "wac_pl_base"
ENT.Type 				= "anim"
ENT.Category			= "Gredwitch's Stuff"
ENT.PrintName			= "[WAC]F/A-18F Super Hornet"
ENT.Author				= "Gredwitch"

ENT.Spawnable			= true
ENT.AdminSpawnable		= true

ENT.Model            = "models/sentry/fa18f.mdl"
ENT.RotorPhModel        = "models/props_junk/sawblade001a.mdl"
ENT.RotorModel        = "models/props_junk/PopCan01a.mdl"
ENT.Engines = 2
ENT.rotorPos        = Vector(0,0,74)
ENT.TopRotorDir        = 1.0
ENT.AutomaticFrameAdvance = true
ENT.EngineForce        = 800
ENT.Weight            = 23120
ENT.SeatSwitcherPos	= Vector(0,0,0)
ENT.AngBrakeMul	= 0.05
ENT.SmokePos        = Vector(-330,21,85)
ENT.FirePos            = Vector(-330,21,85)
ENT.BurnerOffset		= Vector(-330,0,85)

if CLIENT then
	ENT.thirdPerson = {
		distance = 700
	}
end

ENT.Agility = {
	Thrust = jetspeed
}

ENT.Wheels={
	{
		mdl="models/sentry/fa18br.mdl",
		pos=Vector(-106.5,-64.5,24),
		friction=70,
		mass=1200,
	},
	{
		mdl="models/sentry/fa18bl.mdl",
		pos=Vector(-106.5,64.5,24),
		friction=70,
		mass=1200,
	},
	{
		mdl="models/sentry/fa18fw.mdl",
		pos=Vector(133,0,18),
		friction=70,
		mass=1200,
	},
}

ENT.Seats = {
	{
		pos=Vector(167,0,95),
		exit=Vector(170,100,40),
		weapons={"M61A1", "500lb JDAM GBU-38", "500lb GBU-12 Paveway II", "AIM-9X", "AIM-120"}
	},
	{
		pos=Vector(108,0,105),
		exit=Vector(110,100,40),
	}
}

ENT.Weapons = {
	["M61A1"] = {
		class = "wac_pod_mg",
		info = {
			Pods = {
				Vector(305,0,100)
			},
			Sounds = {
				shoot = "WAC/fa18/gun.wav",
				stop = "WAC/fa18/gun_stop.wav"
			},
			FireRate = 6000,
			BulletType = "wac_base_20mm",
			Ammo = 2000,
		}
	},
	["500lb JDAM GBU-38"] = {
	    class = "wac_pod_gbomb",
		info = {
		    Pods = {
			    Vector(-70, -93, 70), --right
				Vector(-70, 92, 70), --left
			},
			Kind = "gb_bomb_gbu38",
		}
	},
	["500lb GBU-12 Paveway II"] = {
	    class = "wac_pod_gbomb",
		info = {
		    Pods = {
			    Vector(-100, -135, 70),
				Vector(-100, 135, 70),
			},
			Kind = "gb_bomb_gbu12",
		}
	},
	["AIM-9X"] = {
	    class = "wac_pod_mis",
		info = {
		    Pods = {
			    Vector(0, -200, 40),
				Vector(0, 200, 40),
			},
			Sequential = true,
			model = "models/hawx/aim-9 sidewinder.mdl",
			Ammo = 2,
		}
	},
	["AIM-120"] = {
	    class = "wac_pod_mis",
		info = {
		    Pods = {
			    Vector(-50, -230, 30),
				Vector(-50, 230, 30),
			},
			Sequential = true,
			model = "models/hawx/aim-120 amraam.mdl",
			Ammo = 2,
		}
	},			
}

ENT.Sounds={
	Start="WAC/fa18/Start.wav",
	Blades="WAC/fa18/external.wav",
	Engine="WAC/fa18/internal.wav",
	MissileAlert="HelicopterVehicle/MissileNearby.mp3",
	MissileShoot="HelicopterVehicle/MissileShoot.mp3",
	MinorAlarm="HelicopterVehicle/MinorAlarm.mp3",
	LowHealth="HelicopterVehicle/LowHealth.mp3",
	CrashAlarm="HelicopterVehicle/CrashAlarm.mp3"
}

ENT.Camera = {
	model = "models/mm1/box.mdl",
	pos = Vector(305,0,100),
	offset = Vector(0,0,0),
	viewPos = Vector(0, 0, 0),
	minAng = Angle(0, 0, 0),
	maxAng = Angle(0, 0, 0),
	seat = 1
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
			if ent==self and active and throttle > 0.5 and CurTime()>cureffect then
				cureffect=CurTime()+0.01
				local ed=EffectData()
				ed:SetEntity(self)
				ed:SetOrigin(Vector(-345,8,90)) // offset
				ed:SetMagnitude(throttle)
				ed:SetRadius(30)
				util.Effect("wac_afterburner", ed)
				
				local ed=EffectData()
				ed:SetEntity(self)
				ed:SetOrigin(Vector(-345,45,90)) // offset
				ed:SetMagnitude(throttle)
				ed:SetRadius(30)
				util.Effect("wac_afterburner", ed)
			end
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