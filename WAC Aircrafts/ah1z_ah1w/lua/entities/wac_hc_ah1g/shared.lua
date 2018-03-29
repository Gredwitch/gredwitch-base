if not wac then return end

ENT.Base = "wac_hc_base"
ENT.Type = "anim"
ENT.Author = "Gredwitch"
ENT.Category = "Gredwitch's Stuff"
ENT.Spawnable = true
ENT.AdminSpawnable = true
ENT.PrintName		= "[WAC]AH-1W Super Cobra"

ENT.Model			= "models/chippy/ah1w/body.mdl"
ENT.SmokePos		= Vector(-177,0,28)
ENT.FirePos			= Vector(-177,-12,28)

ENT.TopRotor = {
	dir = -1,
	pos = Vector(-29,2,65),
	model = "models/chippy/ah1w/mainrotor.mdl"
}

ENT.BackRotor = {
	dir = -1,
	pos = Vector(-432.5,-11.06,63),
	model = "models/chippy/ah1w/tailrotor.mdl"
}

ENT.thirdPerson={
	distance = 700,
	position = Vector(0,0,50)
}

ENT.Seats = {
	{
		pos=Vector(39, 1.2, -1.3),
		exit=Vector(72,70,0),
		weapons = {"Hydra 70"},
	},
	{
		pos=Vector(100, 1, -10),
		exit=Vector(120,70,0),
		weapons = {"M197", "Hellfire", "AIM-9"}
	},
}

ENT.Weapons = {
	["Hydra 70"] = {
		class = "wac_pod_grocket",
		info = {
			Sequential = true,
			Firerate = 220,
			Ammo = 40,
			BulletType = "wac_base_20mm",
			Pods = {
				Vector(35, 45, -20),
				Vector(35, -45, -20),
			}
		}
	},
	["Hellfire"] = {
		class = "wac_pod_hellfire",
		info = {
			Pods = {
				Vector(50, 60, -20),
				Vector(50, -60, -20),
			},
			Ammo = 14,
		}
	},
	["AIM-9"] = {
		class = "wac_pod_mis",
		info = {
			Pods = {
				Vector(50, 60, -20),
				Vector(50, -60, -20),
			},
			Ammo = 8,
			model = "models/hawx/aim-9 sidewinder.mdl",
		}
	},
	["M197"] = {
		class = "wac_pod_gunner",
		info = {
			ShootPos = Vector(110, 2, -33),
			ShootOffset = Vector(60, 0, 0),
			TkAmmo = 0,
			Ammo = 1000,
			BulletType = "wac_base_20mm"
		}
	},
}

ENT.WeaponAttachments={

	gunMount1 = {
		model = "models/BF2/helicopters/AH-1 Cobra/ah1z_g1.mdl",
		pos = Vector(107.5,0,-30.5),
		restrictPitch=true,
	},
	
	gunMount2 = {
		model = "models/BF2/helicopters/AH-1 Cobra/ah1z_g2.mdl",
		pos = Vector(111,0,-37),
		localTo = "gunMount1",
	},
	
	gun = {
		model = "models/BF2/helicopters/AH-1 Cobra/ah1z_g.mdl",
		pos = Vector(111,0,-37),
		localTo = "gunMount2",
	},
	
	radar1 = {
		model = "models/chippy/ah1w/tgp.mdl",
		pos = Vector(160,0,-15),
		restrictPitch=true
	},
	
}

ENT.Camera = {
	model = "models/props_junk/popcan01a.mdl",
	pos = Vector(160,0,-15),
	offset = Vector(-1,0,0),
	viewPos = Vector(10, 0, 0),
	maxAng = Angle(45, 90, 0),
	minAng = Angle(-2, -90, 0),
	seat = 2
}

ENT.Sounds={
	Start="wac/ah1w/startup.wav",
	Blades="wac/ah1w/external.wav",
	Engine="wac/ah1w/internal.wav",
	MissileAlert="HelicopterVehicle/MissileNearby.mp3",
	MissileShoot="HelicopterVehicle/MissileShoot.mp3",
	MinorAlarm="wac/ah1w/lowhealth.wav",
	LowHealth="wac/ah1w/lowhealth.wav",
	CrashAlarm="wac/ah1w/explode.wav"
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

ENT.thirdPerson = {
	distance = 600,
	angle = 10
}


function ENT:attachmentThink()
	if !self.weapons.M197 then return end
	local gun = self.weaponAttachments.gun
	gun.roll = (gun.roll and gun.roll+self.weapons.M197:GetSpinSpeed()*FrameTime()*1500 or 0)
	self:base("wac_hc_base").attachmentThink(self)
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
	
	surface.SetTextPos(100, 410) 
	surface.DrawText("SPD  "..math.floor(self:GetVelocity():Length()*0.1) .."kn")
	surface.SetTextPos(100, 445)
	local tr=util.QuickTrace(pos+self:GetUp()*10,Vector(0,0,-999999),self.Entity)
	surface.DrawText("ALT  "..math.ceil((pos.z-tr.HitPos.z)*0.01905).."m")
	
	if self:GetNWInt("seat_1_actwep") == 1 and self.weapons["Hydra 70"] then
		surface.SetTextPos(270,445)
		local n = self.weapons["Hydra 70"]:GetAmmo()
		surface.DrawText("Hydra 70" .. getspaces(n))
	end
	
	cam.End3D2D()
end

function ENT:DrawWeaponSelection() end
