AddCSLuaFile()
DEFINE_BASECLASS( "base_anim" )

ENT.Spawnable		            	=	false
ENT.AdminSpawnable		            =	false

ENT.PrintName		                =	"Artillery strike entity"
ENT.Author			                =	"Gredwitch"
ENT.Contact			                =	"qhamitouche@gmail.com"
ENT.Category                        =	"Gredwitch's Stuff"

ENT.Model                         	=	"models/mm1/box.mdl"
ENT.Delay							=	0
ENT.ShellType						=   ""
ENT.StrikeType						=	""
ENT.ShellCount						=	0
ENT.Team							=	""
ENT.FireRate						=	0
ENT.LoopTimerTime1					=	0
ENT.LoopTimerTime2					=	0
ENT.Smoke							=	false
ENT.Bomber							=	false
ENT.RandomPos						= 	0
ENT.Pos								=	nil

local ShellSnd = {}
local RktSnd = {}
local BmbSnd = {}
local SmokeSounds = {}

for i = 1,4 do 
	SmokeSounds[i] =  "gred_emp/nebelwerfer/artillery_strike_smoke_close_0"..i..".wav"
	BmbSnd[i] = "bomb/bomb_whistle_0"..i..".wav"
	RktSnd[i] = "artillery/flyby/rocket_artillery_strike_incoming_0"..i..".wav"
	ShellSnd[i] = "artillery/flyby/artillery_strike_incoming_0"..i..".wav"
end

function ENT:Initialize() 
	self.Entity:SetModel(self.Model)
	self.Entity:PhysicsInit(SOLID_NONE)
	self.Entity:SetMoveType(MOVETYPE_VPHYSICS)
	self.Entity:SetSolid(SOLID_NONE)
	
	self:CreateArtillery()
end

function ENT:CreateArtillery()
	timer.Create("gred_stike_ent_delay",self.Delay,1,function()
		if not IsValid(self) then return end
		self.Pos = self:GetPos()
		
		if IsValid(self.Owner) then
			self.Owner:ChatPrint("[GREDWITCH'S SWEPS]"..self.StrikeString.." strike is launched!")
		end
		if SERVER then
			for _,ply in pairs (player.GetAll()) do
				if self.ShellType == "gb_bomb_sc250" then
					ply:GetViewEntity():EmitSound("artillery/flyby/stuka_dive_bomb.ogg")
				elseif self.Bomber and self.ShellType != "gb_bomb_sc250" then
					ply:GetViewEntity():EmitSound("artillery/flyby/bomber_carpetbomb_flyover.ogg")
				end
			end
		end
		
		if self.Bomber then--[[
			local bomber = ents.Create("prop_dynamic")
			bomber:SetModel("models/gredwitch/b17e_static/b17e_static.mdl")
			bomber:SetPos(self.Pos)
			local ph = bomber:GetPhysicsObject()
			if IsValid(ph) then
				ph:EnableDrag(false)
				ph:EnableCollisions(false)
				ph:Wake()
			end
			bomber:Spawn()
			bomber:Activate()
			bomber:ResetSequence("fly")--]]
			timer.Simple(10,function()
				if not IsValid(self) then return end
				timer.Create("gred_bomber_firerate",0.25,self.ShellCount,function()
					if not IsValid(self) then return end
					self:EmitSound(table.Random(BmbSnd), 140, 100, 1)
					if SERVER then
						bpos = self.Pos + Vector(400,0,0)
						if !util.IsInWorld(bpos) then return end
						self.Bomb = ents.Create(self.ShellType)
						self.Bomb:SetPos(bpos)
						if self.StrikeString == "Stuka" then self.Bomb:SetAngles(Angle(90,0,0)) end
						self.Bomb.IsOnPlane = true
						self.Bomb.Owner = self.Owner
						self.Bomb.GBOWNER = self.Owner
						self.Bomb:Spawn()
						self.Bomb:Activate()
						
						self.Bomb:Arm()
						self:SetPos(bpos)
						self.Pos = bpos
						self.ShellCount = self.ShellCount - 1
					end
				end)
			end)
		else
			timer.Create("gred_strike_ent_firerate",self.FireRate,self.ShellCount,function()
				if not IsValid(self) then return end
				if SERVER then
					for _,ply in pairs (player.GetAll()) do
						if self.ShellType == "gb_rocket_81mm" or self.ShellType == "gb_rocket_81mmWP" then
							ply:GetViewEntity():EmitSound("artillery/far/distant_artillery_fire_0"..math.random(1,4)..".wav" )
						elseif self.ShellType == "gb_rocket_nebel" then
							ply:GetViewEntity():EmitSound("artillery/far/distant_rocket_artillery_fire_0"..math.random(1,4)..".wav")
						end
					end
				
					timer.Simple(math.random(self.LoopTimerTime1,self.LoopTimerTime2),function()
						if not IsValid(self) then return end
						local bpos = self.Pos + Vector(math.random(-self.RandomPos,self.RandomPos),math.random(-self.RandomPos,self.RandomPos),0)
						if !util.IsInWorld(bpos) then return end
						
						if self.ShellType == "gb_rocket_81mm" or self.ShellType == "gb_rocket_81mmWP" then
							self:EmitSound(table.Random(ShellSnd),140,100,1)
						elseif self.ShellType == "gb_rocket_nebel" then
							self:EmitSound(table.Random(RktSnd),140,100,1)
						end
						self.Shell = ents.Create(self.ShellType)
						self.Shell:SetPos(bpos)
						self.Shell:SetAngles(Angle(90,0,0))
						self.Shell.Owner = self.Owner
						self.Shell.GBOWNER = self.Owner
						self.Shell.IsOnPlane = true
						self.Shell:Spawn()
						self.Shell:Activate()
						if self.Smoke then
							self.Shell.Effect = "doi_smoke_artillery"
							self.Shell.EffectAir = "doi_smoke_artillery"
							self.Shell.Smoke = true
							self.Shell.RSound = 1
							self.Shell.ExplosionSound = table.Random(SmokeSounds)
							self.Shell.WaterExplosionSound = table.Random(SmokeSounds)
						end
						self.Shell:Arm()
						self.ShellCount = self.ShellCount - 1
					end)
				end
			end)
		end
	end)
end

function ENT:Think()
	if SERVER then
		if self.ShellCount <= 0 then
			self:Remove()
		end
	end
	return true
end