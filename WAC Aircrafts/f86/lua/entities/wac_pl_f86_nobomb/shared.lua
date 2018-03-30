if not wac then return end
if SERVER then AddCSLuaFile() end
if GetConVarNumber("gred_jets_speed") >= 1 then jetspeed = 36 else jetspeed = 33 end
ENT.Base 				= "wac_pl_base"
ENT.Type 				= "anim"
ENT.Category			= "Gredwitch's Stuff"
ENT.PrintName			= "[WAC]F-86F Sabre (No bombs)"
ENT.Author				= "Chippy"

ENT.Spawnable			= true
ENT.AdminSpawnable		= true

ENT.Model            = "models/chippy/f86/body.mdl"

ENT.EngineForce        = 480
ENT.Weight            = 6400
ENT.SeatSwitcherPos	= Vector(0,0,0)
ENT.AngBrakeMul		= 0.0127
ENT.SmokePos        = Vector(-230,1,23)
ENT.FirePos            = Vector(50,-40,1)
ENT.rotorPos			= Vector(0,0,0)

if CLIENT then
	ENT.thirdPerson = {
		distance = 500
	}
end

ENT.Wheels={
	{
		mdl="models/chippy/f86/bwheel1.mdl",
		pos=Vector(-30,-47,-40),
		friction=0,
		mass=900,
	},
	{
		mdl="models/chippy/f86/bwheel2.mdl",
		pos=Vector(-30,47,-40),
		friction=0,
		mass=900,
	},
	{
		mdl="models/chippy/f86/fwheel.mdl",
		pos=Vector(136,-2,-37.8),
		friction=0,
		mass=700,
	},
}

ENT.Agility = {
	Thrust = jetspeed
}


ENT.Seats = {
	{
		pos=Vector(60,-0.2,20.6),
		exit=Vector(3.5,60,100),
		weapons={"M3 Browning", "HVAR"},
	}
}

ENT.Weapons = {
	["M3 Browning"] = {
		class = "wac_pod_mg",
		info = {
			Pods = {
				Vector(140,20,28),
				Vector(140,20,20),
				Vector(140,20,11),
				Vector(140,-20,28),
				Vector(140,-20,20),
				Vector(140,-20,11),
			},
			FireRate = 7200,
			Ammo = 1800,
			Sequential = true,
			Sounds = {
				shoot = "wac/f86/shoot_start.wav",
				stop = "wac/f86/shoot_end.wav",
			},
		}
	},
	["HVAR"] = {
		class = "wac_pod_grocket",
		info = {
			Pods = {
				Vector(200,150,-10),
				Vector(200,-150,-10)
			},
			Kind = "gb_rocket_hvar",
			Ammo = 8,
			FireRate = 300
		}
	}
}

ENT.Sounds={
	Start="wac/f86/start.wav",
	Blades="wac/f86/external.wav",
	Engine="wac/f86/internal.wav",
	MissileAlert="",
	MissileShoot="",
	MinorAlarm="",
	LowHealth="",
	CrashAlarm="",
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
			ed:SetOrigin(Vector(-200,0,10)) // offset
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

	surface.SetTextPos(30, 300) 
	surface.DrawText("SPD  "..math.floor(self:GetVelocity():Length()*0.1) .."kn")
	surface.SetTextPos(30, 340)
	local tr=util.QuickTrace(pos+self:GetUp()*10,Vector(0,0,-999999),self.Entity)
	surface.DrawText("ALT  "..math.ceil((pos.z-tr.HitPos.z)*0.01905).."m")

	if self:GetNWInt("seat_1_actwep") == 1 and self.weapons["M3 Browning"] then
		surface.SetTextPos(250,400)
		local n = self.weapons["M3 Browning"]:GetAmmo()
		surface.DrawText("M3 Browning        " .. getspaces(n))
	end
	if self:GetNWInt("seat_1_actwep") == 2 and self.weapons["HVAR"] then
		surface.SetTextPos(250,400)
		local n = self.weapons["HVAR"]:GetAmmo()
		surface.DrawText("HVAR            " .. getspaces(n))
	end

	cam.End3D2D()
end

function ENT:DrawWeaponSelection() end