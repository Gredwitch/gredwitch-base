if not wac then return end
if SERVER then AddCSLuaFile('shared.lua') end
ENT.Base 				= "wac_pl_base"
ENT.Type 				= "anim"
ENT.Category			= "Gredwitch's Stuff"
ENT.PrintName			= "[WAC]Martin B-57B Canberra (Admin)"
ENT.Author				= "Gredwitch"

ENT.Spawnable			= true
ENT.AdminSpawnable		= true

ENT.Model	    = "models/gredwitch/b57/b-57b.mdl"
ENT.RotorPhModel        = "models/props_junk/sawblade001a.mdl"
ENT.RotorModel        = "models/mm1/box.mdl"

ENT.rotorPos	= Vector(-250,-130,0)
ENT.TopRotorDir	= 1.0
ENT.AutomaticFrameAdvance = true
ENT.EngineForce	= 1000
ENT.Weight	    = 29300
ENT.SeatSwitcherPos	= Vector(0,0,0)
ENT.AngBrakeMul	= 0.02
ENT.SmokePos	= ENT.rotorPos
ENT.FirePos	    = ENT.SmokePos
ENT.Engines = 2

if CLIENT then
	ENT.thirdPerson = {
		distance = 1000
	}
end

ENT.Agility = {
	Thrust = 30
}

ENT.Wheels={
	{
		mdl="models/gredwitch/b57/b-57_fwheel.mdl",
		pos=Vector(100,0,-65),
		ang=Angle(90,0,0),
		friction=100,
		mass=1500,
	},
	{
		mdl="models/gredwitch/b57/b-57_rwheel.mdl",
		pos=Vector(-70,105,-50),
		friction=100,
		mass=500,
	},
	{
		mdl="models/gredwitch/b57/b-57_lwheel.mdl",
		pos=Vector(-70,-105,-50),
		friction=100,
		mass=500,
	},
}

ENT.Seats = {
	{
		pos=Vector(160,0,0),
		exit=Vector(210.251,0,150),
		weapons={"M3 Browning","1000LB bombs", "500LB bombs"}
	},
	{
		pos=Vector(100,0,0),
		exit=Vector(210.251,0,150),
		weapons={"1000LB bombs", "500LB bombs"}
	}
}

ENT.Weapons = {
	["M3 Browning"] = {
		class = "wac_pod_mg",
		info = {
			Pods = {
				Vector(3,-170,10),
				Vector(3,170,0),
				Vector(3,175,0),
				Vector(3,-175,0),
				Vector(3,220,0),
				Vector(3,-220,0),
				Vector(3,225,0),
				Vector(3,-225,0),
				
			},
			Sounds = {
				shoot = "wac/f86/shoot_start.wav",
				stop = "wac/f86/shoot_end.wav",
			},
			Ammo = 1,
			TkAmmo = 0,
			Sequential = true,
			FireRate = 9600,
		}
	},
	["1000LB bombs"] = {
		class = "wac_pod_gbomb",
		info = {
			Pods = {
				Vector(-40,0,-25),
			},
			FireRate = 50,
			Admin = 1,
			Kind = "gb_bomb_1000gp"
		}
	},
	["500LB bombs"] = {
		class = "wac_pod_gbomb",
		info = {
			Pods = {
				Vector(-150,0,-25)
			},
			Admin = 1,
			Kind = "gb_bomb_500gp"
		}
	},
}

ENT.Sounds={
	Start="wac/f86/start.wav",
	Blades="wac/f86/external.wav",
	Engine="wac/f86/internal.wav",
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
				ed:SetOrigin(Vector(-250,130,0)) // offset
				ed:SetMagnitude(throttle)
				ed:SetRadius(25)
				util.Effect("wac_heatwave", ed)
				
				local ed=EffectData()
				ed:SetEntity(self)
				ed:SetOrigin(Vector(-250,-130,0)) // offset
				ed:SetMagnitude(throttle)
				ed:SetRadius(25)
				util.Effect("wac_heatwave", ed)
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

	cam.Start3D2D(self:LocalToWorld(Vector(25,3.75,37.75)+spos), ang,0.015)--[[
	surface.SetDrawColor(HudCol)
	surface.DrawRect(234, 247, 10, 4)
	surface.DrawRect(254, 247, 10, 4)
	surface.DrawRect(247, 234, 4, 10)
	surface.DrawRect(247, 254, 4, 10)
--]]
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

	surface.SetTextPos(0, 500) 
	surface.DrawText("SPD  "..math.floor(self:GetVelocity():Length()*0.1) .."kn")
	surface.SetTextPos(0, 520)
	local tr=util.QuickTrace(pos+self:GetUp()*10,Vector(0,0,-999999),self.Entity)
	surface.DrawText("ALT  "..math.ceil((pos.z-tr.HitPos.z)*0.01905).."m")

	if self:GetNWInt("seat_1_actwep") == 1 and self.weapons["M3 Browning"] then
		surface.SetTextPos(400,520)
		local n = self.weapons["M3 Browning"]:GetAmmo()
		surface.DrawText("M3 Browning" .. getspaces(n))
	end
	if self:GetNWInt("seat_1_actwep") == 2 and self.weapons["1000LB bombs"] then
		surface.SetTextPos(400,520)
		local n = self.weapons["1000LB bombs"]:GetAmmo()
		surface.DrawText("1000LB bombs" .. getspaces(n))
	end
	if self:GetNWInt("seat_1_actwep") == 3 and self.weapons["500LB bombs"] then
		surface.SetTextPos(400,520)
		local n = self.weapons["500LB bombs"]:GetAmmo()
		surface.DrawText("500LB bombs" .. getspaces(n))
	end
	cam.End3D2D()
end

function ENT:DrawWeaponSelection() end