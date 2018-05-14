if not wac then return end
ENT.Base = "wac_pl_base"
ENT.Type = "anim"
ENT.Category = "Gredwitch's Stuff"
ENT.Spawnable = true
ENT.AdminSpawnable = true
ENT.PrintName = "[WAC]Messerschmitt Bf 110G-2 (No bombs)"
ENT.Model				= "models/gredwitch/bf110g/bf110g.mdl"
ENT.RotorPhModel		= "models/props_junk/sawblade001a.mdl"
ENT.RotorModel			= "models/gredwitch/bf110g/bf110g_prop.mdl"
ENT.OtherRotorModel		= "models/gredwitch/bf110g/bf110g_prop.mdl"
ENT.AutomaticFrameAdvance = true
ENT.Weight			= 4000
ENT.EngineForce		= 3354
ENT.rotorPos 	= Vector(95,-86.7,-12.5)
ENT.OtherRotorPos = Vector(95,91.7,-12.5)
ENT.FirePos			= ENT.rotorPos
ENT.SmokePos		= ENT.rotorPos
ENT.OtherRotorDir = -1
ENT.Engines = 2
ENT.maxEnterDistence = 400

ENT.thirdPerson = {
	distance = 600
}

ENT.Agility = {
	Thrust = 21
}

ENT.Wheels={
	{
		mdl="models/gredwitch/bf110g/bf110g_wr.mdl",
		pos=Vector(27,95,-70.7),
		friction=10,
		mass=100,
	},
	{
		mdl="models/gredwitch/bf110g/bf110g_wl.mdl",
		pos=Vector(27,-90.5,-70.7),
		friction=10,
		mass=100,
	},
	{
		mdl="models/gredwitch/bf110g/bf110g_wb.mdl",
		pos=Vector(-310,0.85,-23.7),
		friction=10,
		mass=200,
	},
}

ENT.Seats = {
	{
		pos=Vector(65,0.3,-10),
		exit=Vector(76,36,-70),
		weapons={"MG 17", "MG 151",}
	},
	{
		pos=Vector(-33,1,-11),
		ang=Angle(0,180,0),
		exit=Vector(-35,36,-70),
		weapons={"MG81Z"}
	},
}

ENT.Weapons = {
	--[[["100Kg Bombs"] = {
		class = "wac_pod_gbomb",
		info = {
			Pods = {
				Vector(70,0,-28),
				Vector(70,12,-28),
				Vector(70,-12,-28),
				Vector(110,0,-28),
				Vector(110,12,-28),
				Vector(110,-12,-28),
				Vector(150,0,-28),
				Vector(150,12,-28),
				Vector(150,-12,-28),
				Vector(110,0,-20),
				
			},
			Kind = "gb_bomb_sc100",
			Sounds = {
			    fire = "bomb/bomb_whistle_0"..math.random(1,4)..".wav"
			},
		}
	},--]]
	["MG 17"] = {
		class = "wac_pod_mg",
		info = {
			Pods = {
				Vector(137,-5,10),
				Vector(140,-1.5,10),
				Vector(140,3.7,10),
				Vector(137,7,10),
			},
			Sounds = {
				shoot = "wac/bf110g/shoot.wav",
				stop = "wac/bf110g/stop.wav",
			},
			Sequential = false,
			BulletType = "wac_base_7mm",
			Ammo = 4000,
			FireRate = 1000,
		}
	},
	["MG 151"] = {
		class = "wac_pod_mg",
		info = {
			Pods = {
				Vector(137.5,-3,-12.5),
				Vector(137.5,3,-12.5),
			},
			Sounds = {
				shoot = "wac/bf110g/20mm_shoot.wav",
				stop = "wac/bf110g/20mm_stop.wav",
			},
			Sequential = false,
			BulletType = "wac_base_20mm",
			Ammo = 750,
			FireRate = 750,
		}
	},
	["MG81Z"] = {
		class = "wac_pod_gunner",
		info = {
			Sounds = {
	            shoot1p = "",
	            shoot3p = "",
            	spin = "wac/bf110g/spin.wav"
            },
			ShootPos = Vector(-60,0,30),
			ShootOffset = Vector(20,0,0),
			Sequential = true,
			BulletType = "wac_base_7mm",
			Ammo = 1500,
			FireRate = 3000
		}
	}
}

ENT.WeaponAttachments={
	gun = {
		model = "models/gredwitch/bf110g/bf110g_mg81z.mdl",
		pos = Vector(-55,1,27.75),
	},
	
}

ENT.Camera = {
	model = "models/mm1/box.mdl", 
	pos = Vector(-60,0,30),
	offset = Vector(-50,0,0), 
	viewPos = Vector(30,0,0),
	minAng = Angle(-60, -360,0),
	maxAng = Angle(25, 360,0),
	seat = 2
}
ENT.Sounds={
	Start="wac/bf110g/start.wav",
	Blades="wac/bf110g/external.wav",
	Engine="radio/german.wav",
	MissileAlert="",
	MissileShoot="",
	MinorAlarm="",
	LowHealth="",
	CrashAlarm="",
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

	cam.Start3D2D(self:LocalToWorld(Vector(12,3.75,37.75)+spos), ang,0.015)
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

	if self:GetNWInt("seat_1_actwep") == 1 and self.weapons["MG 17"] then
		surface.SetTextPos(330,510)
		local n = self.weapons["MG 17"]:GetAmmo()
		surface.DrawText("MG 17	    " .. getspaces(n))
	end
	
	if self:GetNWInt("seat_1_actwep") == 2 and self.weapons["MG 151"] then
		surface.SetTextPos(330,510)
		local n = self.weapons["MG 151"]:GetAmmo()
		surface.DrawText("MG 151	" .. getspaces(n))
	end
	
	if self:GetNWInt("seat_1_actwep") == 3 and self.weapons["100Kg bombs"] then
		surface.SetTextPos(330,510)
		local n = self.weapons["100Kg bombs"]:GetAmmo()
		surface.DrawText("100Kg bombs" .. getspaces(n))
	end
	
	cam.End3D2D()
end
function ENT.DrawWeaponSelection() end