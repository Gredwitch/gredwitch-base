if not wac then return end
if SERVER then AddCSLuaFile('shared.lua') end
ENT.Base 				= "wac_pl_base"
ENT.Type 				= "anim"
ENT.Category			= "Gredwitch's Stuff"
ENT.PrintName			= "[WAC]F-82E TwinMustang"
ENT.Author				= "Gredwitch's Stuff"

ENT.Spawnable			= true
ENT.AdminSpawnable		= true

ENT.Model	    = "models/wac/fsx/f82b.mdl"
ENT.RotorPhModel	= "models/props_junk/sawblade001a.mdl"
ENT.RotorModel	= "models/wac/fsx/f82b_prop.mdl"
ENT.RotorModel2	= "models/wac/fsx/f82b_prop.mdl"

ENT.rotorPos	= Vector(238.425,91.457,0.748)
ENT.rotorPos2	= Vector(238.43,-91.457,0.748)

ENT.TopRotorDir	= 1

ENT.Engines = 2
ENT.EngineForce	= 400
ENT.Weight	    = 11250
ENT.SeatSwitcherPos	= Vector(0,0,0)
ENT.AngBrakeMul	= 0.02
ENT.SmokePos	= Vector(238.425,91.457,0.748)
ENT.FirePos	    = Vector(238.425,91.457,0.748)

if CLIENT then
	ENT.thirdPerson = {
		distance = 550
	}
end

ENT.Agility = {
	Thrust = 25
}

ENT.Wheels={
	{
		mdl="models/wac/fsx/f82b_left.mdl",
		pos=Vector(101.706,109.096,-72.711),
		friction=0,
		mass=500,
	},
	{
		mdl="models/wac/fsx/f82b_right.mdl",
		pos=Vector(101.696,-109.096,-72.711),
		friction=0,
		mass=500,
	},
	{
		mdl="models/wac/fsx/f82b_back.mdl",
		pos=Vector(-163.893,91.457,-21.266),
		friction=0,
		mass=500,
	},
	{
		mdl="models/wac/fsx/f82b_back.mdl",
		pos=Vector(-163.893,-91.457,-21.266),
		friction=0,
		mass=500,
	}
}

ENT.Seats = {
	{
		pos=Vector(66,91.53,1),
		exit=Vector(120,180,24),
		weapons={"M3 Browning", "HVAR", "Mark 83"}
	},
	{
		pos=Vector(66,-91.53,1),
		exit=Vector(120,-180,24),
	}
}

ENT.Weapons = {
	["M3 Browning"] = {
		class = "wac_pod_mg",
		info = {
			Pods = {
				Vector(122,18.898,-21.929),
				Vector(122,-18.898,-21.929),
				Vector(122,11.654,-21.929),
				Vector(122,-11.654,-21.929),
				Vector(122,4.961,-21.929),
				Vector(122,-4.961,-21.929)
			},
			Sounds = {
				shoot = "wac/f86/shoot_start.wav",
				stop = "wac/f86/shoot_end.wav",
			},
			Ammo = 2400,
			FireRate = 7200,
			Sequential = true
		}
	},
	["HVAR"] = {
		class = "wac_pod_grocket",
		info = {
			Pods = {
				Vector(400,240.197,-33.387),
				Vector(400,-240.197,-33.387),
				Vector(400,231.851,-36.615),
				Vector(400,-231.851,-36.615),
				Vector(400,223.11,-33.387),
				Vector(400,-223.11,-33.387),
				Vector(400,214.212,-36.615),
				Vector(400,-214.212,-36.615),
				Vector(400,205.748,-33.387),
				Vector(400,-205.748,-33.387)
			},
			Ammo = 10,
			Kind = "gb_rocket_hvar",
			FireRate = 200,
		}
	},
	["Mark 83"] = {
		class = "wac_pod_gbomb",
		info = {
			Pods = {
				Vector(78,21.85,-45),
				Vector(78,-21.85,-45),
				Vector(78,175,-38),
				Vector(78,-175,-38),
			},
			Sequential = true,
			FireRate = 200,
			Kind = "gb_bomb_mk82",
		}
	}
}

ENT.Sounds={
	Start="wac/fsx/f82/Start.wav",
	Blades="wac/fsx/f82/external.wav",
	Engine="wac/fsx/f82/internal.wav",
	MissileAlert="",
	MissileShoot="",
	MinorAlarm="wac/fsx/seafire/minor.wav",
	LowHealth="wac/fsx/seafire/low.wav",
	CrashAlarm="wac/fsx/seafire/crash.wav"
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

	cam.Start3D2D(self:LocalToWorld(Vector(23,3.75,37.75)+spos), ang,0.015)
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
	surface.DrawText("SPD  "..math.floor(self:GetVelocity():Length()*0.15) .."kn")
	surface.SetTextPos(30, 445)
	local tr=util.QuickTrace(pos+self:GetUp()*10,Vector(0,0,-999999),self.Entity)
	surface.DrawText("ALT  "..math.ceil((pos.z-tr.HitPos.z)*0.01905).."m")

	if self:GetNWInt("seat_1_actwep") == 1 and self.weapons["M3 Browning"] then
		surface.SetTextPos(300,445)
		local n = self.weapons["M3 Browning"]:GetAmmo()
		surface.DrawText("M3 Browning  " .. getspaces(n))
	end
	
	if self:GetNWInt("seat_1_actwep") == 2 and self.weapons["HVAR"] then
		surface.SetTextPos(300,445)
		local n = self.weapons["HVAR"]:GetAmmo()
		surface.DrawText("HVAR  " .. getspaces(n))
	end
	
	if self:GetNWInt("seat_1_actwep") == 3 and self.weapons["Mark 83"] then
		surface.SetTextPos(300,445)
		local n = self.weapons["Mark 83"]:GetAmmo()
		surface.DrawText("Mark 83  " .. getspaces(n))
	end

	cam.End3D2D()
end

function ENT:DrawWeaponSelection() end

function ENT:MovePlayerView(k,p,md)
	if p.wac_air_resetview then md:SetViewAngles(Angle(0,90,0)) p.wac_air_resetview=false end
	local freeView = md:GetViewAngles()
	if !self.Seats or !self.Seats[k] then return end
	if (k==1 and p:GetInfo("wac_cl_air_mouse")=="1" and !p.wac.viewFree) then
		freeView.p = freeView.p-freeView.p*FrameTime()*6
		freeView.y = freeView.y-(freeView.y-90)*FrameTime()*6
	else
		freeView.p = math.Clamp(freeView.p,-90,90)
	end
	freeView.y = (freeView.y)
	md:SetViewAngles(freeView)
end