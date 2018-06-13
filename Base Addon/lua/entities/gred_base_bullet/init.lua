
AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")
local zero = 0
local threeZ = zero,zero,zero
local audioSpecs = 100, 100,1, CHAN_AUTO
local null = ""
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
		
		wood					=	9,
		wood_Box				=	9,
		wood_Crate 				=	9,
		wood_Furniture			=	9,
		wood_LowDensity 		=	9,
		wood_Plank				=	9,
		wood_Panel				=	9,
		wood_Solid				=	9,
			
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


function ENT:CreateDOIEffect()
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
	end
end

function ENT:CreateINSEffect()
	
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
	
	end
end

function ENT:CreateEffect()
	if SERVER then
		for k,ply in pairs(ents.FindInSphere(hitpos,50000)) do
			if ply:IsPlayer() then
				if self.Caliber == "wac_base_7mm" then
					if ply:GetInfoNum("gred_noparticles_7mm",1) == 0 then
						if ply:GetInfoNum("gred_insparticles",1) == 0 then
							self:CreateDOIEffect()
						else
							self:CreateINSEffect()
						end
					end
				elseif self.Caliber == "wac_base_12mm" then
					if ply:GetInfoNum("gred_noparticles_12mm",1) == 0 then
						ParticleEffect("doi_gunrun_impact",hitpos,hitang,nil)
					end
				elseif self.Caliber == "wac_base_20mm" then
					if ply:GetInfoNum("gred_noparticles_20mm",1) == 0 then
						if !hitsky then
							ParticleEffect("gred_20mm",hitpos,hitang,nil)
						else
							ParticleEffect("gred_20mm_airburst",hitpos,hitang,nil)
						end
					end
				elseif self.Caliber == "wac_base_30mm" then
					if ply:GetInfoNum("gred_noparticles_30mm",1) == 0 then
						ParticleEffect("30cal_impact",hitpos,hitang,nil)
					end
				end
			end
		end
	end
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

ENT.Explode=function(self,tr,ply)
	if SERVER then
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
						util.BlastDamage(self, self.Owner,hitpos, self.Radius, 80)
					else
						bullet.Damage = 80
					end
					local d
					if self.gunRPM >= 4000 then d = (self.gunRPM / 20000) else d = (self.gunRPM / 5000) end
					if self.gunRPM >= 1000 then
						self.Entity:EmitSound("impactsounds/gun_impact_"..math.random(1,14)..".wav",100, 100,d, CHAN_AUTO)
						
					elseif !self.sequential then
						d = 1 / self.npod
						self.Entity:EmitSound("impactsounds/gun_impact_"..math.random(1,14)..".wav",100, 100,d, CHAN_AUTO)
					else
						self.Entity:EmitSound("impactsounds/gun_impact_"..math.random(1,14)..".wav",audioSpecs)
					end
					
				elseif self.Caliber == "wac_base_7mm" then
					if GetConVarNumber("gred_7mm_he_impact") >= 1 then
						bullet.Damage = zero
						util.BlastDamage(self, self.Owner,hitpos, self.Radius, self.Damage)
					else 
						bullet.Damage = self.Damage 
					end
					hitang = hitang+Angle(90,0,0)
					HitMat = util.GetSurfacePropName(tr.SurfaceProps)
				elseif self.Caliber == "wac_base_30mm" then
					bullet.Damage = zero
					util.BlastDamage(self, self.Owner, hitpos, self.Radius*4, 280)
					self.Entity:EmitSound(self.SND_30MM,140, math.random(90,120),1, CHAN_AUTO)
				end
				bullet.Force = 700
				bullet.HullSize = zero
				bullet.Num = 1
				bullet.Tracer = zero
				bullet.AmmoType = null
				bullet.TracerName = nil
				bullet.Dir = self.Entity:GetForward()
				bullet.Spread = Vector(threeZ)
				bullet.Src = self:GetPos()
				self:FireBullets(bullet,false)
				self:CreateEffect()
			end
		else
			util.BlastDamage(self, self.Owner,hitpos, self.Radius*2, 120)
			local bullet = {}
			bullet.Attacker = self.Owner
			bullet.Callback = nil
			bullet.Damage = zero
			bullet.Force = 700
			bullet.HullSize = zero
			bullet.Num = 1
			bullet.Tracer = zero
			bullet.AmmoType = null
			bullet.TracerName = null
			bullet.Dir = self.Entity:GetForward()
			bullet.Spread = Vector(threeZ)
			bullet.Src = pos
			self:FireBullets( bullet, false )
			hitsky = tr.HitSky
			self:CreateEffect()
			self.Entity:EmitSound( "impactsounds/20mm_0"..math.random(1,5)..".wav",audioSpecs)
		end
	end
	self:Remove()
end

function ENT:PhysicsUpdate(ph)
	if SERVER then
		if !util.IsInWorld(self:GetPos()) then self:Remove() end
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
		elseif self.canThink and !self.NoTele then
			self.Entity:SetPos(pos + difference)
		end
		
		local trdat2   = {}
		trdat2.start   = pos
		trdat2.endpos  = dif
		trdat2.filter  = self.Entity
		trdat2.mask    = MASK_WATER
		local tr2 = util.TraceLine(trdat2)
		if tr2.Hit then
		
			for k,ply in pairs(player.GetAll()) do
				if tonumber(ply:GetInfo(self.PCF_WATER)) == 1 then return end
				
				if self.Caliber == "wac_base_7mm" then
					ParticleEffect("doi_impact_water",tr2.HitPos,Angle(-90,zero,zero),nil)
				elseif self.Caliber == "wac_base_12mm" then
					ParticleEffect("impact_water",tr2.HitPos,Angle(-90,zero,zero),nil)
				elseif self.Caliber == "wac_base_20mm" then
					ParticleEffect("water_small",tr2.HitPos,Angle(threeZ),nil)
				elseif self.Caliber == "wac_base_30mm" then
					ParticleEffect("water_medium",tr2.HitPos,Angle(threeZ),nil)
				end
			end
			self.Entity:EmitSound( "impactsounds/water_bullet_impact_0"..math.random(1,5)..".wav",audioSpecs )
			self.Speed = self.Speed / 5
		end
	end
end

function ENT:Think()
	if SERVER then self.phys:Wake() end
end
