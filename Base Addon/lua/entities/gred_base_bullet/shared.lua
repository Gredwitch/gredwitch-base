ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.Author = "Gredwich"
ENT.Category = ""
ENT.Spawnable = false
ENT.AdminSpawnable = false

local zero = 0
local threeZ = zero,zero,zero
local audioSpecs = 100, 100,1, CHAN_AUTO
local null = ""
local LAN = GetConVar("gred_sv_lan"):GetInt() == 1
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

function ENT:CreateEffect()
	if CLIENT then
		local ply = LocalPlayer()
		if self.Caliber == "wac_base_7mm" then
			if ply:GetInfoNum("gred_cl_noparticles_7mm",1) == 1 then return end
			if ply:GetInfoNum("gred_cl_insparticles",1) == 1 then pcfD = "" else pcfD = "doi_" end
			if materials[HitMat] == 1 then
				ParticleEffect(""..pcfD.."impact_concrete",hitpos,hitang,nil)
			elseif materials[HitMat] == 2 then
				ParticleEffect(""..pcfD.."impact_dirt",hitpos,hitang,nil)
				
			elseif materials[HitMat] == 3 then
				--ParticleEffect(""..pcfD.."impact_glass",hitpos,hitang,nil)
				
			elseif materials[HitMat] == 4 then
				ParticleEffect(""..pcfD.."impact_glass",hitpos,hitang,nil)
				
			elseif materials[HitMat] == 5 then
				ParticleEffect(""..pcfD.."impact_metal",hitpos,hitang,nil)
				
			elseif materials[HitMat] == 6 then
				ParticleEffect(""..pcfD.."impact_sand",hitpos,hitang,nil)
				
			elseif materials[HitMat] == 7 then
				ParticleEffect(""..pcfD.."impact_snow",hitpos,hitang,nil)
				
			elseif materials[HitMat] == 8 then
				ParticleEffect(""..pcfD.."impact_leaves",hitpos,hitang,nil)
				
			elseif materials[HitMat] == 9 then
				ParticleEffect(""..pcfD.."impact_wood",hitpos,hitang,nil)
				
			elseif materials[HitMat] == 10 then
				ParticleEffect(""..pcfD.."impact_grass",hitpos,hitang,nil)
				
			elseif materials[HitMat] == 11 then
				ParticleEffect(""..pcfD.."impact_tile",hitpos,hitang,nil)
				
			elseif materials[HitMat] == 12 then
				ParticleEffect(""..pcfD.."impact_plastic",hitpos,hitang,nil)
				
			elseif materials[HitMat] == 13 then
				ParticleEffect(""..pcfD.."impact_rock",hitpos,hitang,nil)
				
			elseif materials[HitMat] == 14 then
				ParticleEffect(""..pcfD.."impact_gravel",hitpos,hitang,nil)
				
			elseif materials[HitMat] == 15 then
				ParticleEffect(""..pcfD.."impact_mud",hitpos,hitang,nil)
			
			elseif materials[HitMat] == 16 then
				ParticleEffect(""..pcfD.."impact_fruit",hitpos,hitang,nil)
				
			elseif materials[HitMat] == 17 then
				ParticleEffect(""..pcfD.."impact_asphalt",hitpos,hitang,nil)
				
			elseif materials[HitMat] == 18 then
				ParticleEffect(""..pcfD.."impact_cardboard",hitpos,hitang,nil)
				
			elseif materials[HitMat] == 19 then
				ParticleEffect(""..pcfD.."impact_rubber",hitpos,hitang,nil)
				
			elseif materials[HitMat] == 20 then
				ParticleEffect(""..pcfD.."impact_carpet",hitpos,hitang,nil)
				
			elseif materials[HitMat] == 21 then
				ParticleEffect(""..pcfD.."impact_brick",hitpos,hitang,nil)
				
			elseif materials[HitMat] == 22 then
				ParticleEffect(""..pcfD.."impact_leaves",hitpos,hitang,nil)
				
			elseif materials[HitMat] == 23 then
				ParticleEffect(""..pcfD.."impact_paper",hitpos,hitang,nil)
				
			elseif materials[HitMat] == 24 then
				ParticleEffect(""..pcfD.."impact_computer",hitpos,hitang,nil)
			end
			
		elseif self.Caliber == "wac_base_12mm" then
			if ply:GetInfoNum("gred_cl_noparticles_12mm",1) == 1 then return end
			ParticleEffect("doi_gunrun_impact",hitpos,hitang,nil)
		elseif self.Caliber == "wac_base_20mm" then
			if ply:GetInfoNum("gred_cl_noparticles_20mm",1) == 1 then return end
			if !hitsky then
				ParticleEffect("gred_20mm",hitpos,hitang,nil)
			else
				ParticleEffect("gred_20mm_airburst",hitpos,hitang,nil)
			end
		elseif self.Caliber == "wac_base_30mm" then
			if ply:GetInfoNum("gred_cl_noparticles_30mm",1) == 1 then return end
			ParticleEffect("30cal_impact",hitpos,hitang,nil)
		end
	elseif LAN then
		if self.Caliber == "wac_base_7mm" then
			if GetConVar("gred_cl_noparticles_7mm",1):GetInt() == 1 then return end
			if GetConVar("gred_cl_insparticles",1):GetInt() == 1 then pcfD = "" else pcfD = "doi_" end
			if materials[HitMat] == 1 then
				ParticleEffect(""..pcfD.."impact_concrete",hitpos,hitang,nil)
			elseif materials[HitMat] == 2 then
				ParticleEffect(""..pcfD.."impact_dirt",hitpos,hitang,nil)
				
			elseif materials[HitMat] == 3 then
				--ParticleEffect(""..pcfD.."impact_glass",hitpos,hitang,nil)
				
			elseif materials[HitMat] == 4 then
				ParticleEffect(""..pcfD.."impact_glass",hitpos,hitang,nil)
				
			elseif materials[HitMat] == 5 then
				ParticleEffect(""..pcfD.."impact_metal",hitpos,hitang,nil)
				
			elseif materials[HitMat] == 6 then
				ParticleEffect(""..pcfD.."impact_sand",hitpos,hitang,nil)
				
			elseif materials[HitMat] == 7 then
				ParticleEffect(""..pcfD.."impact_snow",hitpos,hitang,nil)
				
			elseif materials[HitMat] == 8 then
				ParticleEffect(""..pcfD.."impact_leaves",hitpos,hitang,nil)
				
			elseif materials[HitMat] == 9 then
				ParticleEffect(""..pcfD.."impact_wood",hitpos,hitang,nil)
				
			elseif materials[HitMat] == 10 then
				ParticleEffect(""..pcfD.."impact_grass",hitpos,hitang,nil)
				
			elseif materials[HitMat] == 11 then
				ParticleEffect(""..pcfD.."impact_tile",hitpos,hitang,nil)
				
			elseif materials[HitMat] == 12 then
				ParticleEffect(""..pcfD.."impact_plastic",hitpos,hitang,nil)
				
			elseif materials[HitMat] == 13 then
				ParticleEffect(""..pcfD.."impact_rock",hitpos,hitang,nil)
					
			elseif materials[HitMat] == 14 then
				ParticleEffect(""..pcfD.."impact_gravel",hitpos,hitang,nil)
				
			elseif materials[HitMat] == 15 then
				ParticleEffect(""..pcfD.."impact_mud",hitpos,hitang,nil)
			
			elseif materials[HitMat] == 16 then
				ParticleEffect(""..pcfD.."impact_fruit",hitpos,hitang,nil)
				
			elseif materials[HitMat] == 17 then
				ParticleEffect(""..pcfD.."impact_asphalt",hitpos,hitang,nil)
				
			elseif materials[HitMat] == 18 then
				ParticleEffect(""..pcfD.."impact_cardboard",hitpos,hitang,nil)
				
			elseif materials[HitMat] == 19 then
				ParticleEffect(""..pcfD.."impact_rubber",hitpos,hitang,nil)
				
			elseif materials[HitMat] == 20 then
				ParticleEffect(""..pcfD.."impact_carpet",hitpos,hitang,nil)
				
			elseif materials[HitMat] == 21 then
				ParticleEffect(""..pcfD.."impact_brick",hitpos,hitang,nil)
				
			elseif materials[HitMat] == 22 then
				ParticleEffect(""..pcfD.."impact_leaves",hitpos,hitang,nil)
				
			elseif materials[HitMat] == 23 then
				ParticleEffect(""..pcfD.."impact_paper",hitpos,hitang,nil)
				
			elseif materials[HitMat] == 24 then
				ParticleEffect(""..pcfD.."impact_computer",hitpos,hitang,nil)
			end
			
		elseif self.Caliber == "wac_base_12mm" then
			if GetConVar("gred_cl_noparticles_12mm",1):GetInt() == 1 then return end
			ParticleEffect("doi_gunrun_impact",hitpos,hitang,nil)
		elseif self.Caliber == "wac_base_20mm" then
			if GetConVar("gred_cl_noparticles_20mm",1):GetInt() == 1 then return end
			if !hitsky then
				ParticleEffect("gred_20mm",hitpos,hitang,nil)
			else
				ParticleEffect("gred_20mm_airburst",hitpos,hitang,nil)
			end
		elseif self.Caliber == "wac_base_30mm" then
			if GetConVar("gred_cl_noparticles_30mm",1):GetInt() == 1 then return end
			ParticleEffect("30cal_impact",hitpos,hitang,nil)
		end
	end
end



ENT.Explode=function(self,tr,ply)
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
				if GetConVarNumber("gred_sv_12mm_he_impact") >= 1 then 
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
				if GetConVarNumber("gred_sv_7mm_he_impact") >= 1 then
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
				self.Entity:EmitSound("impactsounds/30mm_1.wav",140, math.random(90,120),1, CHAN_AUTO)
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
	self:Remove()
end
