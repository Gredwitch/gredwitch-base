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
ENT.CallAng						=	90

local SmokeSounds = {}
SmokeSounds[1]                         =  "gred_emp/nebelwerfer/artillery_strike_smoke_close_01.wav"
SmokeSounds[2]                         =  "gred_emp/nebelwerfer/artillery_strike_smoke_close_02.wav"
SmokeSounds[3]                         =  "gred_emp/nebelwerfer/artillery_strike_smoke_close_03.wav"
SmokeSounds[4]                         =  "gred_emp/nebelwerfer/artillery_strike_smoke_close_04.wav"

function ENT:Initialize() 
	self:SetModel(self.Model)
	self.Entity:PhysicsInit(SOLID_NONE)
	self.Entity:SetMoveType(MOVETYPE_VPHYSICS)
	self.Entity:SetSolid(SOLID_NONE)

	pos = self:GetPos()
	timer.Create("gred_stike_ent_delay",self.Delay,1,function()
		
		if not IsValid(self) then return end
		if IsValid(self.Owner) and (CLIENT or game.SinglePlayer()) then
			self.Owner:ChatPrint("[GREDWITCH'S SWEPS]"..self.StrikeString.." strike is launched!")
			if self.ShellType == "gb_bomb_sc500" then
				self:EmitSound("artillery/flyby/stuka_dive_bomb.ogg", 0, 0, 1)
			elseif self.ShellType == "gb_bomb_sc100" or self.ShellType == "gb_bomb_250gp" then
				self:EmitSound("artillery/flyby/bomber_carpetbomb_flyover.ogg", 0, 100, 1)
			end
		end
		
		if self.Bomber then
			timer.Create("gred_strike_bomber_wait_time",10,1,function()
				timer.Create("gred_bomber_firerate",0.5,self.ShellCount,function()
					if CLIENT or game.SinglePlayer() then
						if not IsValid(self) then return end
						self:EmitSound("artillery/flyby/artillery_strike_incoming_0"..(math.random(1,4))..".wav", 180, 100, 1)
					end
					if SERVER then
						self.Bomb = ents.Create(self.ShellType)
						self.Bomb:SetPos(self:GetPos())
						self.Bomb:SetAngles(Angle(0,0,0))
						self.Bomb:Spawn()
						self.Bomb:Activate()
						self.Bomb:Arm()
						self:SetPos(self:GetPos()+Vector(400,0,0))
					end
				end)
			end)
		else
			timer.Create("gred_strike_ent_firerate",self.FireRate,self.ShellCount,function()
				if CLIENT or game.SinglePlayer() then
					if not IsValid(self) then return end
					if self.ShellType == "gb_rocket_81mm" and self.Team == "Allied" then
						self:EmitSound("artillery/105mm/distant_artillery_fire_0"..(math.random(1,4))..".wav", 0, 100, 1)
					elseif self.ShellType == "gb_rocket_81mm" and self.Team == "Axis" then
					
					elseif self.ShellType == "gb_rocket_nebel" then
					
					end
				end
				timer.Create("gred_strike_timer3",math.Rand(self.LoopTimerTime1,self.LoopTimerTime2),1,function()
					if CLIENT or game.SinglePlayer() then
						if not IsValid(self) then return end
						if self.ShellType == "gb_rocket_81mm" and self.Team == "Allied" then
							self:EmitSound("artillery/flyby/artillery_strike_incoming_0"..(math.random(1,4))..".wav", 100, 100, 1)
						elseif self.ShellType == "gb_rocket_81mm" and self.Team == "Axis" then
						
						elseif self.ShellType == "gb_rocket_nebel" then
						
						end
					end
					if SERVER then
						self.Shell = ents.Create(self.ShellType)
						self.Shell:SetPos(pos + Vector(math.Rand(-self.RandomPos,self.RandomPos),math.Rand(-self.RandomPos,self.RandomPos),0))
						self.Shell:SetAngles(Angle(90,0,0))
						self.Shell:Spawn()
						self.Shell:Activate()
							if self.Smoke then
							self.Shell.Effect = "doi_smoke_artillery"
							self.Shell.EffectAir = "doi_smoke_artillery"
							self.Shell.ExplosionRadius = 0
							self.Shell.ExplosionDamage = 0
							self.Shell.SpecialRadius = 0
							self.Shell.PhysForce = 0
							self.Shell.RSound = 1
							self.Shell.DEFAULT_PHYSFORCE                = 0
							self.Shell.DEFAULT_PHYSFORCE_PLYAIR         = 0
							self.Shell.DEFAULT_PHYSFORCE_PLYGROUND      = 0
							self.Shell.ExplosionSound = table.Random(SmokeSounds)
							self.Shell.WaterExplosionSound = table.Random(SmokeSounds)
						end
						self.Shell:Arm()
					end
				end)
			end)
		end
	end)
end