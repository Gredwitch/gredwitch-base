if not wac then return end
if SERVER then AddCSLuaFile('shared.lua') end
ENT.Base 				= "wac_pl_base"
ENT.Type 				= "anim"
ENT.Category			= "Gredwitch's Stuff"
ENT.PrintName			= "[WAC]F-22A Raptor (Bomber)"
ENT.Author				= "Gredwitch"

ENT.Spawnable			= true
ENT.AdminSpawnable		= true

ENT.Model	    = "models/hawx/fa22.mdl"
ENT.RotorPhModel        = "models/props_junk/sawblade001a.mdl"
ENT.RotorModel        = "models/props_junk/PopCan01a.mdl"
ENT.Engines = 2
ENT.rotorPos	= Vector(0,0,100)
ENT.TopRotorDir	= 1.0
ENT.AutomaticFrameAdvance = true
ENT.EngineForce	= 1000
ENT.Weight	    = 29300
ENT.SeatSwitcherPos	= Vector(0,0,0)
ENT.AngBrakeMul	= 0.02
ENT.SmokePos	= Vector(-276.422,0.002,85.075)
ENT.FirePos	    = Vector(-276.422,0.002,85.075)

if CLIENT then
	ENT.thirdPerson = {
		distance = 700
	}
end

ENT.Agility = {
	Thrust = 40
}

ENT.Wheels={
	{
		mdl="models/hawx/fa22_front.mdl",
		pos=Vector(144.401,0.002,15),
		friction=10,
		mass=600,
	},
	{
		mdl="models/hawx/fa22_left.mdl",
		pos=Vector(-87.978,78.277,20.513),
		friction=10,
		mass=1200,
	},
	{
		mdl="models/hawx/fa22_right.mdl",
		pos=Vector(-87.978,-78.277,20.513),
		friction=10,
		mass=1200,
	},
}

ENT.Seats = {
	{
		pos=Vector(202,0,95),
		exit=Vector(210.251,0,150),
		weapons={"M61A2 Vulcan", "AIM-9M/X", "JDAM GBU-38"}
	}
}

ENT.Weapons = {
	["M61A2 Vulcan"] = {
		class = "wac_pod_mg",
		info = {
			Pods = {
				Vector(-37.955,-65.803,95.247)
			},
			Sounds = {
				shoot = "WAC/fa18/gun.wav",
				stop = "WAC/fa18/gun_stop.wav",
			},
			Ammo = 1600,
			FireRate = 6000,
			BulletType = "wac_base_20mm"
		}
	},
	["AIM-9M/X"] = {
		class = "wac_pod_mis",
		info = {
			Pods = {
				Vector(22,60,63),
				Vector(22,-60,63)
			},
			Ammo = 2,
			FireRate = 120,
			model = "models/hawx/aim-9 sidewinder.mdl",
		}
	},
	["JDAM GBU-38"] = {
		class = "wac_pod_gbomb",
		info = {
			Pods = {
				Vector(40,0,55),
				Vector(-50,0,55)
			},
			Kind = "gb_bomb_gbu38",
			FireRate = 120,
		}
	}
}

ENT.Camera = {
	model = "models/mm1/box.mdl",
	pos = Vector(378,0,85),
	offset = Vector(-1,0,0),
	viewPos = Vector(2,0,0),
	maxAng = Angle(45, 90, 0),
	minAng = Angle(-2, -90, 0),
	seat = 1
}

ENT.Sounds={
	Start="hawx/fa22/start.wav",
	Blades="hawx/fa22/external.wav",
	Engine="hawx/fa22/fa22_dickpit.wav",
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
			ed:SetOrigin(Vector(-276.422,0.002,85.075)) // offset
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

	cam.Start3D2D(self:LocalToWorld(Vector(25,3.75,37.75)+spos), ang,0.015)
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

	if self:GetNWInt("seat_1_actwep") == 1 and self.weapons["M61A2 Vulcan"] then
		surface.SetTextPos(300,445)
		local n = self.weapons["M61A2 Vulcan"]:GetAmmo()
		surface.DrawText("M61A2 Vulcan  " .. getspaces(n))
	end
	if self:GetNWInt("seat_1_actwep") == 2 and self.weapons["AIM-9M/X"] then
		surface.SetTextPos(300,445)
		local n = self.weapons["AIM-9M/X"]:GetAmmo()
		surface.DrawText("AIM-9M/X" .. getspaces(n))
	end
	if self:GetNWInt("seat_1_actwep") == 3 and self.weapons["JDAM GBU-38"] then
		surface.SetTextPos(300,445)
		local n = self.weapons["JDAM GBU-38"]:GetAmmo()
		surface.DrawText("JDAM GBU-38" .. getspaces(n))
	end
	cam.End3D2D()
end

function ENT:DrawWeaponSelection() end