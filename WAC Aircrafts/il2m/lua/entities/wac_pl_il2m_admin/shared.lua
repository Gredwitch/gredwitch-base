if not wac then return end
if SERVER then AddCSLuaFile() end
ENT.Base 				= "wac_pl_base"
ENT.Type 				= "anim"
ENT.Category			= "Gredwitch's Stuff"
ENT.PrintName			= "[WAC]Iliouchine Il-2M Sturmovik (Admin)"
ENT.Author				= "Gredwitch"

ENT.Spawnable			= true
ENT.AdminSpawnable		= true
ENT.Model	    = "models/gredwitch/il2/il2.mdl"
ENT.RotorPhModel	= "models/props_junk/sawblade001a.mdl"
ENT.RotorModel	= "models/gredwitch/il2/il2_prop.mdl"
ENT.rotorPos	= Vector(146,0,-2.7)
ENT.TopRotorDir	= 1

ENT.EngineForce	= 6500
ENT.Weight	    = 3347
ENT.SeatSwitcherPos	= Vector(0,0,0)
ENT.AngBrakeMul		= 0.02
ENT.SmokePos	= ENT.rotorPos
ENT.FirePos	    = ENT.SmokePos

if CLIENT then
	ENT.thirdPerson = {
		distance = 550
	}
end

ENT.Agility = {
	Thrust = 17
}

ENT.Wheels={
	{
		mdl="models/gredwitch/il2/il2_wl.mdl",
		pos=Vector(61,-68,-71),
		friction=0,
		mass=550,
	},
	{
		mdl="models/gredwitch/il2/il2_wr.mdl",
		pos=Vector(61,66,-71),
		friction=0,
		mass=550,
	},
	{
		mdl="models/gredwitch/il2/il2_wb.mdl",
		pos=Vector(-273,0,-12.4),
		friction=0,
		mass=550,
	},
}

ENT.Seats = {
	{
		pos=Vector(0,0,3),
		exit=Vector(-14,46,10),
		weapons={"ShKAS", "VYa-23","RS-132","FAB-250"}
    },
	{
		pos=Vector(-38,0,-1.75),
		ang=Angle(0,180,0),
		exit=Vector(-14,46,10),
		weapons={"Berezin UB"}
    } 
}					

ENT.Weapons = {
	["ShKAS"] = {
		class = "wac_pod_mg",
		info = {
			Pods = {
				Vector(76,-92.7,-7.4),
				Vector(76,92.7,-7.4),
			},
			Sounds = {
				shoot = "WAC/il2/shoot.wav",
				stop = "WAC/il2/stop.wav",
			},
			FireRate = 1800,
			TracerColor = "Green",
			BulletType = "wac_base_7mm",
			Ammo = 1,
			TkAmmo = 0,
			Sequential = false,
		}
	},
	["VYa-23"] = {
		class = "wac_pod_mg",
		info = {
			Pods = {
				Vector(97,-110.7,-7.7),
				Vector(97,110.7,-7.7),
			},
			Sounds = {
				shoot = "WAC/il2/20mm_shoot.wav",
				stop = "WAC/il2/20mm_stop.wav",
			},
			FireRate = 600,
			TracerColor = "Green",
			BulletType = "wac_base_20mm",
			Ammo = 1,
			TkAmmo = 0,
			Sequential = false,
		}
	},
	["RS-132"] = {
		class = "wac_pod_grocket",
		info = {
			Pods = {
				Vector(15,-147,-26),
				Vector(15,147,-26),
			},
			FireRate = 160,
			Kind = "gb_rocket_hvar",
			Ammo = 1,
			TkAmmo = 0,
			Sequential = false,
		}
	},
	["FAB-250"] = {
		class = "wac_pod_gbomb",
		info = {
			Pods = {
				Vector(30,34.5,-10),
				Vector(30,-34.5,-10),
				Vector(30,34.5,-10),
				Vector(30,-34.5,-10),
			},
			Kind = "gb_bomb_fab250",
			Sequential = true,
			Admin = 1
		}
	},
	["Berezin UB"] = {
		class = "wac_pod_gunner",
		info = {
			Sounds = {
				spin = "WAC/il2/shoot.wav",
				shoot1p = "",
				shoot3p = "",
			},
			ShootPos = Vector(-67.7,0,33),
			ShootOffset = Vector(30,0,0),
			FireRate = 950,
			TracerColor = "Green",
			Ammo = 1,
			TkAmmo = 0
		}
	}
}

ENT.WeaponAttachments={
	gun = {
		model = "models/gredwitch/il2/il2_gun.mdl",
		pos = Vector(-67.7,0,25),
	}
}


ENT.Camera = {
	model = "models/mm1/box.mdl",
	pos = Vector(-67.7,0,31),
	offset = Vector(-110,0,0),
	viewPos = Vector(20, 0, 0),
	minAng = Angle(-180, -180, -180),
	maxAng = Angle(5, 180, 180),
	seat = 2
}
	
ENT.Sounds={
	Start="WAC/il2/Start.wav",
	Blades="WAC/il2/external.wav",
	Engine="WAC/il2/internal.wav",
	MissileAlert="",
	MissileShoot="",
	MinorAlarm="",
	LowHealth="",
	CrashAlarm=""
}
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

	cam.Start3D2D(self:LocalToWorld(Vector(18,3.75,37.75)+spos), ang,0.015)
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


	surface.SetTextPos(30, 510) 
	surface.DrawText("SPD  "..math.floor(self:GetVelocity():Length()*0.1) .."kn")
	surface.SetTextPos(30, 545)
	local tr=util.QuickTrace(pos+self:GetUp()*10,Vector(0,0,-999999),self.Entity)
	surface.DrawText("ALT  "..math.ceil((pos.z-tr.HitPos.z)*0.01905).."m")

	if self:GetNWInt("seat_1_actwep") == 1 and self.weapons["ShKAS"] then
		surface.SetTextPos(330,510)
		local n = self.weapons["ShKAS"]:GetAmmo()
		surface.DrawText("ShKAS	    " .. getspaces(n))
	end
	
	if self:GetNWInt("seat_1_actwep") == 2 and self.weapons["VYa-23"] then
		surface.SetTextPos(330,510)
		local n = self.weapons["VYa-23"]:GetAmmo()
		surface.DrawText("VYa-23	" .. getspaces(n))
	end
	
	if self:GetNWInt("seat_1_actwep") == 3 and self.weapons["RS-132"] then
		surface.SetTextPos(330,510)
		local n = self.weapons["RS-132"]:GetAmmo()
		surface.DrawText("RS-132" .. getspaces(n))
	end
	
	if self:GetNWInt("seat_1_actwep") == 4 and self.weapons["FAB-250"] then
		surface.SetTextPos(330,510)
		local n = self.weapons["FAB-250"]:GetAmmo()
		surface.DrawText("FAB-250" .. getspaces(n))
	end
	
	cam.End3D2D()
end
function ENT.DrawWeaponSelection() end