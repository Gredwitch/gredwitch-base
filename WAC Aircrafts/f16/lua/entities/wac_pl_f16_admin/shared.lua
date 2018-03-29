if not wac then return end
if SERVER then AddCSLuaFile('shared.lua') end
if GetConVarNumber("gred_jets_speed") >= 1 then jetspeed = 44 else jetspeed = 33 end
ENT.Base 				= "wac_pl_base"
ENT.Type 				= "anim"
ENT.Category			= "Gredwitch's Stuff"
ENT.PrintName			= "[WAC]F-16C Falcon (Admin)"
ENT.Author				= "SentryGunMan"

ENT.Spawnable			= true
ENT.AdminSpawnable		= true

ENT.Model	    = "models/sentry/f16.mdl"
ENT.RotorPhModel        = "models/props_junk/sawblade001a.mdl"
ENT.RotorModel        = "models/props_junk/PopCan01a.mdl"

ENT.rotorPos	= Vector(0,0,74)
ENT.TopRotorDir	= 1.0
ENT.AutomaticFrameAdvance = true
ENT.EngineForce	= 600
ENT.Weight	    = 12000
ENT.SeatSwitcherPos	= Vector(0,0,0)
ENT.AngBrakeMul	= 0.02
ENT.SmokePos	= Vector(-235,0,68)
ENT.FirePos	    = Vector(-235,0,68)

if CLIENT then
	ENT.thirdPerson = {
		distance = 550
	}
end

ENT.Agility = {
	Thrust = jetspeed
}

ENT.Wheels={
	{
		mdl="models/sentry/f16_bw.mdl",
		pos=Vector(-66,45.3,12),
		friction=10,
		mass=600,
	},
	{
		mdl="models/sentry/f16_bw.mdl",
		pos=Vector(-66,-45.3,12),
		friction=10,
		mass=600,
	},
	{
		mdl="models/sentry/f16_fw.mdl",
		pos=Vector(86.2,0,10.9),
		friction=10,
		mass=1200,
	},
}

ENT.Seats = {
	{
		pos=Vector(130,0,70),
		exit=Vector(130,70,20),
		weapons={"M61 Vulcan", "Hydra 70", "AIM-9", "JDAM GBU-32 500lb", "Mark-82 500lb"}
	}
}

ENT.Weapons = {
	["M61 Vulcan"] = {
		class = "wac_pod_mg",
		info = {
			Pods = {
				Vector(100,40,80.75),
				Vector(100,-40,80.75)
			},
			Ammo = 1,
			TkAmmo = 0,
			FireRate = 3900,
			BulletType = "wac_base_20mm",
			Sounds = {
				shoot = "WAC/f16/gun.wav",
				stop = "WAC/f16/gun_stop.wav"
			}
		}
	},
	
	["Hydra 70"] = {
		class = "wac_pod_grocket",
		info = {
			Sequential = true,
			Ammo = 1,
			TkAmmo = 0,
			FireRate = 200,
			Pods = {
				Vector(-31.54,155.64,56.31),
				Vector(-31.54,-155.64,56.31)
			}
		}
	},
	["AIM-9"] = {
		class = "wac_pod_mis",
		info = {
			Sequential = true,
			Ammo = 1,
			TkAmmo = 0,
			FireRate = 200,
			Pods = {
				Vector(-31.54,155.64,56.31),
				Vector(-31.54,-155.64,56.31)
			}
		}
	},
	["JDAM GBU-32 500lb"] = {
		class = "wac_pod_gbomb",
		info = {
			Sequential = true,
			Kind = "gb_bomb_gbu38",
			FireRate = 200,
			Pods = {
				Vector(-70, 110.5, 56),
				Vector(-70, -110.5, 56),
			},
			Admin = 1,
		}
	},
	["Mark-82 500lb"] = {
		class = "wac_pod_gbomb",
		info = {
			Sequential = true,
			Kind = "gb_bomb_mk82",
			FireRate = 200,
			Pods = {
				Vector(-40, -65, 50),
				Vector(-40, 65, 50),
			},
			Admin = 1,
		}
	}
}

ENT.Sounds={
	Start="WAC/f16/Start.wav",
	Blades="WAC/f16/external.wav",
	Engine="WAC/f16/internal.wav",
	MissileAlert="HelicopterVehicle/MissileNearby.mp3",
	MissileShoot="HelicopterVehicle/MissileShoot.mp3",
	MinorAlarm="HelicopterVehicle/MinorAlarm.mp3",
	LowHealth="HelicopterVehicle/LowHealth.mp3",
	CrashAlarm="HelicopterVehicle/CrashAlarm.mp3"
}

ENT.Camera = {
	model = "models/mm1/box.mdl",
	pos = Vector(149.2,0,150),
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
				ed:SetOrigin(Vector(-270,0,68)) // offset
				ed:SetMagnitude(throttle)
				ed:SetRadius(25)
				util.Effect("wac_heatwave", ed)
			end
		end
	end
end
