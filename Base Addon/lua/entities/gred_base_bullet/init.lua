
AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")
local PLAYER = CLIENT or not game.IsDedicated()
local zero = 0
local threeZ = zero,zero,zero
local audioSpecs = 100, 100,1, CHAN_AUTO

function ENT:CreateEffect()
	local materials={		

		boulder 				=	1,
		concrete				=	1,
		concrete_block			=	1,
		plaster					=	1,
		pottery					=	1,
		
		dirt					=	2,
			
		alienflesh				=	3,
		antlion					=	3,
		armorflesh				=	3,
		bloodyflesh				=	3,
		flesh					=	3,
		zombieflesh				=	3,
			
		glass					=	4,
		ice						=	4,
		glassbottle				=	4,
		combine_glass			=	4,
			
		canister				=	5,
		chain					=	5,
		chainlink				=	5,
		combine_metal			=	5,
		crowbar					=	5,
		floating_metal_barrel	=	5,
		grenade					=	5,
		metal					=	5,
		metal_barrel			=	5,
		metal_bouncy			=	5,
		Metal_Box				=	5,
		metal_seafloorcar		=	5,
		metalgrate				=	5,
		metalpanel				=	5,
		metalvent				=	5,
		metalvehicle			=	5,
		paintcan				=	5,
		roller					=	5,
		slipperymetal			=	5,
		solidmetal				=	5,
		strider					=	5,
		weapon					=	5,
		
		quicksand				=	6,
		sand					=	6,
		slipperyslime			=	6,
		antlionsand				=	6,
		
		snow					=	7,
			
		foliage					=	8,
		
		Wood					=	9,
		Wood_Box				=	9,
		Wood_Crate 				=	9,
		Wood_Furniture			=	9,
		Wood_LowDensity 		=	9,
		Wood_Plank				=	9,
		Wood_Panel				=	9,
		Wood_Solid				=	9,
			
		grass					=	10,
		
		tile					=	11,
		ceiling_tile			=	11,
		
		plastic_barrel			=	12,
		plastic_barrel_buoyant	=	12,
		Plastic_Box				=	12,
		plastic					=	12,
		
		baserock 				=	13,
		rock					=	13,
		
		gravel					=	14,
		
		mud						=	15,
		
		watermelon				=	16,
		
		asphalt 				=	17,
		
		cardbaord 				=	18,
		
		rubber 					=	19,
		rubbertire 				=	19,
		slidingrubbertire 		=	19,
		slidingrubbertire_front =	19,
		slidingrubbertire_rear 	=	19,
		jeeptire 				=	19,
		brakingrubbertire 		=	19,
		
		carpet 					=	20,
		brakingrubbertire 		=	20,
		
		brick					=	21,
			
		foliage					=	22,
		
		paper 					=	23,
		papercup 				=	23,
		
		computer				=	24,
	}
	if GetConVarNumber("gred_insparticles") == zero and GetConVarNumber("gred_noparticles_7mm") == zero then
		if     materials[HitMat] == 1 then
			ParticleEffect("doi_impact_concrete",hitpos,hitang,nil)
		
		elseif materials[HitMat] == 2 then
			ParticleEffect("doi_impact_dirt",hitpos,hitang,nil)
			
		elseif materials[HitMat] == 3 then
			--ParticleEffect("doi_impact_glass",hitpos,hitang,nil)
				
		elseif materials[HitMat] == 4 then
			ParticleEffect("doi_impact_glass",hitpos,hitang,nil)
			
		elseif materials[HitMat] == 5 then
			ParticleEffect("doi_impact_metal",hitpos,hitang,nil)
			
		elseif materials[HitMat] == 6 then
			ParticleEffect("doi_impact_sand",hitpos,hitang,nil)
			
		elseif materials[HitMat] == 7 then
			ParticleEffect("doi_impact_snow",hitpos,hitang,nil)
				
		elseif materials[HitMat] == 8 then
			ParticleEffect("doi_impact_leaves",hitpos,hitang,nil)
				
		elseif materials[HitMat] == 9 then
			ParticleEffect("doi_impact_wood",hitpos,hitang,nil)
			
		elseif materials[HitMat] == 10 then
			ParticleEffect("doi_impact_grass",hitpos,hitang,nil)
			
		elseif materials[HitMat] == 11 then
			ParticleEffect("doi_impact_tile",hitpos,hitang,nil)
				
		elseif materials[HitMat] == 12 then
			ParticleEffect("doi_impact_plastic",hitpos,hitang,nil)
			
		elseif materials[HitMat] == 13 then
			ParticleEffect("doi_impact_rock",hitpos,hitang,nil)
				
		elseif materials[HitMat] == 14 then
			ParticleEffect("doi_impact_gravel",hitpos,hitang,nil)
				
		elseif materials[HitMat] == 15 then
			ParticleEffect("doi_impact_mud",hitpos,hitang,nil)
		
		elseif materials[HitMat] == 16 then
			ParticleEffect("doi_impact_fruit",hitpos,hitang,nil)
			
		elseif materials[HitMat] == 17 then
				ParticleEffect("doi_impact_asphalt",hitpos,hitang,nil)
			
		elseif materials[HitMat] == 18 then
				ParticleEffect("doi_impact_cardboard",hitpos,hitang,nil)
			
		elseif materials[HitMat] == 19 then
			ParticleEffect("doi_impact_rubber",hitpos,hitang,nil)
			
		elseif materials[HitMat] == 20 then
			ParticleEffect("doi_impact_carpet",hitpos,hitang,nil)
			
		elseif materials[HitMat] == 21 then
			ParticleEffect("doi_impact_brick",hitpos,hitang,nil)
			
		elseif materials[HitMat] == 22 then
			ParticleEffect("doi_impact_leaves",hitpos,hitang,nil)
				
		elseif materials[HitMat] == 23 then
			ParticleEffect("doi_impact_paper",hitpos,hitang,nil)
				
		elseif materials[HitMat] == 24 then
			ParticleEffect("doi_impact_computer",hitpos,hitang,nil)
			
		else
			ParticleEffect("doi_impact_asphalt",hitpos,hitang,nil)
		end
	elseif GetConVarNumber("gred_insparticles") == 1 and GetConVarNumber("gred_noparticles_7mm") == zero then
		if     materials[HitMat] == 1 then
			ParticleEffect("impact_concrete",hitpos,hitang,nil)
			
		elseif materials[HitMat] == 2 then
			ParticleEffect("impact_dirt",hitpos,hitang,nil)
			
		elseif materials[HitMat] == 3 then
			--ParticleEffect("impact_glass",hitpos,hitang,nil)
			
		elseif materials[HitMat] == 4 then
			ParticleEffect("impact_glass",hitpos,hitang,nil)
			
		elseif materials[HitMat] == 5 then
			ParticleEffect("impact_metal",hitpos,hitang,nil)
			
		elseif materials[HitMat] == 6 then
			ParticleEffect("impact_sand",hitpos,hitang,nil)
			
		elseif materials[HitMat] == 7 then
			ParticleEffect("impact_snow",hitpos,hitang,nil)
			
		elseif materials[HitMat] == 8 then
			ParticleEffect("impact_leaves",hitpos,hitang,nil)
			
		elseif materials[HitMat] == 9 then
			ParticleEffect("impact_wood",hitpos,hitang,nil)
			
		elseif materials[HitMat] == 10 then
			ParticleEffect("impact_grass",hitpos,hitang,nil)
					
		elseif materials[HitMat] == 11 then
			ParticleEffect("impact_tile",hitpos,hitang,nil)
			
		elseif materials[HitMat] == 12 then
				ParticleEffect("impact_plastic",hitpos,hitang,nil)
				
		elseif materials[HitMat] == 13 then
			ParticleEffect("impact_rock",hitpos,hitang,nil)
			
		elseif materials[HitMat] == 14 then
			ParticleEffect("impact_gravel",hitpos,hitang,nil)
			
		elseif materials[HitMat] == 15 then
				ParticleEffect("impact_mud",hitpos,hitang,nil)
		
		elseif materials[HitMat] == 16 then
			ParticleEffect("impact_fruit",hitpos,hitang,nil)
			
		elseif materials[HitMat] == 17 then
			ParticleEffect("impact_asphalt",hitpos,hitang,nil)
		
		elseif materials[HitMat] == 18 then
			ParticleEffect("impact_cardboard",hitpos,hitang,nil)
			
		elseif materials[HitMat] == 19 then
			ParticleEffect("impact_rubber",hitpos,hitang,nil)
				
		elseif materials[HitMat] == 20 then
			ParticleEffect("impact_carpet",hitpos,hitang,nil)
			
		elseif materials[HitMat] == 21 then
			ParticleEffect("impact_brick",hitpos,hitang,nil)
				
		elseif materials[HitMat] == 22 then
			ParticleEffect("impact_leaves",hitpos,hitang,nil)
				
		elseif materials[HitMat] == 23 then
			ParticleEffect("impact_paper",hitpos,hitang,nil)
					
		elseif materials[HitMat] == 24 then
			ParticleEffect("impact_computer",hitpos,hitang,nil)
			
		else
			ParticleEffect("impact_concrete",hitpos,hitang,nil)
		end
	elseif GetConVarNumber("gred_noparticles_7mm") == 1 then return end
	
end

function ENT:Initialize()
	self.Entity:SetModel("models/mm1/box.mdl")		
	self.Entity:PhysicsInit(SOLID_VPHYSICS)
	self.Entity:SetMoveType(MOVETYPE_VPHYSICS)
	self.Entity:SetSolid(SOLID_VPHYSICS)
	self.phys = self.Entity:GetPhysicsObject()
	if self.phys:IsValid() then
		self.phys:SetMass(5)
		self.phys:EnableCollisions(true)
		self.phys:Wake()
		self.phys:EnableGravity(true)
	end
	
	if self.Speed == nil then self.Speed = 1000 end
	if self.Damage == nil then self.Damage = 40 end
	if self.Radius == nil then self.Radius = 70 end
	if self.Owner == nil then self.Owner = ply end
	if self.npod == nil then self.npod = 1 end
	self.oldpos=self:GetPos()-self:GetAngles():Forward()*self.Speed
	
	self:SetRenderMode(RENDERMODE_GLOW)
	self:SetNotSolid(true)
	self.cbt={}
	self.cbt.health=5000
	self.cbt.armor=500
	self.cbt.maxhealth=5000
	
	self:SetNWInt("gunRPM", self.gunRPM)
	self:SetNWBool("sequential", self.sequential)
	self:SetNWInt("npod", self.npod)
	self.startTime=CurTime()
	self.canThink=true
	self.IsBullet=true
	self:NextThink(CurTime())
end

ENT.Explode=function(self,tr)
	if self.Exploded then return end
	self.Exploded = true
	if not IsValid(self.Owner) then 
		if IsValid(self.Entity) then self.Owner = self.Entity
		else self.Owner = nil end
	end
	hitang = tr.HitNormal:Angle()
	hitpos = tr.HitPos
	
	if self.Caliber != "wac_base_20mm" then
		if !tr.HitSky then
			local bullet = {}
			bullet.Attacker = self.Owner
			bullet.Callback = nil
			if self.Caliber == "wac_base_12mm" then
				if GetConVarNumber("gred_12mm_he_impact") >= 1 then 
					bullet.Damage = zero 
					util.BlastDamage(self, self.Owner, tr.HitPos, self.Radius, self.Damage*3)
				else
					bullet.Damage = 120
				end
				local d
				if self.gunRPM >= 4000 then d = (self.gunRPM / 20000) else d = (self.gunRPM / 5000) end
				if self.gunRPM >= 1000 then
					self.Entity:EmitSound( "impactsounds/gun_impact_"..math.random(1,14)..".wav",100, 100,d, CHAN_AUTO )
					
				elseif !self.sequential then
					d = 1 / self.npod
					self.Entity:EmitSound( "impactsounds/gun_impact_"..math.random(1,14)..".wav",100, 100,d, CHAN_AUTO)
				else
					self.Entity:EmitSound( "impactsounds/gun_impact_"..math.random(1,14)..".wav",audioSpecs)
				end
				
			elseif self.Caliber == "wac_base_7mm" then
				if GetConVarNumber("gred_7mm_he_impact") >= 1 then
					bullet.Damage = zero
					util.BlastDamage(self, self.Owner, tr.HitPos, self.Radius, self.Damage)
				else 
					bullet.Damage = self.Damage 
				end
			elseif self.Caliber == "wac_base_30mm" then
				bullet.Damage = zero
				util.BlastDamage(self, self.Owner, tr.HitPos, self.Radius*3, self.Damage*8)
				if GetConVarNumber("gred_noparticles_30mm") == zero and PLAYER then
					ParticleEffect("30cal_impact",tr.HitPos,Angle(tr.HitNormal:Angle()),nil)
				end
				self.Entity:EmitSound("impactsounds/30mm_1.wav",140, math.random(90,120),1, CHAN_AUTO)
			end
			bullet.Force = 700
			bullet.HullSize = zero
			bullet.Num = 1
			bullet.Tracer = zero
			bullet.AmmoType = "shitmm"
			bullet.TracerName = nil
			bullet.Dir = self.Entity:GetForward()
			bullet.Spread = Vector(threeZ)
			bullet.Src = self:GetPos()
			self:FireBullets(bullet,false)
			if PLAYER then
				if GetConVarNumber("gred_noparticles_7mm") == zero and self.Caliber == "wac_base_7mm" then
					hitang = tr.HitNormal:Angle()+Angle(90,0,0)
					hitpos = tr.HitPos
					
					HitMat = util.GetSurfacePropName(tr.SurfaceProps)
					self:CreateEffect()
				end
				if GetConVarNumber("gred_noparticles_12mm") == zero and self.Caliber == "wac_base_12mm" then
					ParticleEffect("doi_gunrun_impact",tr.HitPos,tr.HitNormal:Angle(),nil)
				end
			end
		end
	else
		util.BlastDamage(self, self.Owner, tr.HitPos, self.Radius*2, self.Damage*4)
		local bullet = {}
		bullet.Attacker = self.Owner
		bullet.Callback = nil
		bullet.Damage = zero
		bullet.Force = 700
		bullet.HullSize = zero
		bullet.Num = 1
		bullet.Tracer = zero
		bullet.AmmoType = "flak.hitler"
		bullet.TracerName = nil
		bullet.Dir = self.Entity:GetForward()
		bullet.Spread = Vector(threeZ)
		bullet.Src = pos
		self:FireBullets( bullet, false )
		if PLAYER then
			if !tr.HitSky and GetConVarNumber("gred_noparticles_20mm") == zero then
				ParticleEffect("gred_20mm",tr.HitPos,Angle(tr.HitNormal:Angle(),zero,zero),nil)
			else
				ParticleEffect("gred_20mm_airburst",tr.HitPos,Angle(tr.HitNormal:Angle(),zero,zero),nil)
			end
		end
		self.Entity:EmitSound( "impactsounds/20mm_0"..math.random(1,5)..".wav",audioSpecs)
	end
	self.Entity:Remove()
end

function ENT:PhysicsUpdate(ph)
	if !util.IsInWorld(self:GetPos()) then self:Remove() end
	local speed=self.Speed
	if !self.oldpos then self:Remove() return end
	local pos=self:GetPos()
	local difference = (pos - self.oldpos)
	self.oldpos = pos
	
	local dif = pos + difference
	
	local trace = {}
	trace.start = pos
	trace.endpos = dif
	trace.filter = self.Entity
	trace.mask=CONTENTS_SOLID + CONTENTS_MOVEABLE + CONTENTS_OPAQUE + CONTENTS_DEBRIS + CONTENTS_HITBOX + CONTENTS_MONSTER + CONTENTS_WINDOW
	local tr = util.TraceLine(trace)
	
	if tr.Hit then
		self.Explode(self,tr)
		self:Remove()
	elseif (self.canThink or speed>50) and !self.NoTele then
		self.Entity:SetPos(pos + difference)
	end
	
	local trdat2   = {}
    trdat2.start   = pos
	trdat2.endpos  = dif
	trdat2.filter  = self.Entity
	trdat2.mask    = MASK_WATER
	local tr2 = util.TraceLine(trdat2)
	if tr2.Hit and GetConVarNumber("gred_water_impact") == 1 and PLAYER then
		if self.Caliber == "wac_base_12mm" then
			ParticleEffect("impact_water",tr2.HitPos,Angle(-90,zero,zero),nil)
		elseif self.Caliber == "wac_base_7mm" then
			ParticleEffect("doi_impact_water",tr2.HitPos,Angle(-90,zero,zero),nil)
		elseif self.Caliber == "wac_base_20mm" then
			ParticleEffect("water_small",tr2.HitPos,Angle(threeZ),nil)
		elseif self.Caliber == "wac_base_30mm" then
			ParticleEffect("water_medium",tr2.HitPos,Angle(threeZ),nil)
		end
		self.Entity:EmitSound( "impactsounds/water_bullet_impact_0"..math.random(1,5)..".wav",audioSpecs )
	end
end

function ENT:Think()
	self.phys:Wake()
	if !IsValid(self.phys) then self:Remove() print("REM") end
end
