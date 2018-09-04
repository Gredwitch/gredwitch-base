ENT.Type 			= "anim"
ENT.Base 			= "base_gmodentity"
ENT.Author 			= "Gredwich"
ENT.Category 		= ""
ENT.Spawnable		= false
ENT.AdminSpawnable  = false
ENT.FuzeTime		= 0
-- ENT.Caliber			= ""
local zero = 0
local threeZ = zero,zero,zero
local audioSpecs = 100, 100,1, CHAN_AUTO
local null = ""
if SERVER then
	util.AddNetworkString("gred_net_impact_fx") 

	function ENT.Explode(self,tr,ply)
		if self.Exploded then return end
		self.Exploded = true
		if not IsValid(self.Owner) then 
			if IsValid(self.Entity) then self.Owner = self.Entity
			else self.Owner = nil end
		end
		if self.FuzeTime == 0 then
			if tr.HitNormal == nil then
				hitang = Angle(threeZ)
			else
				hitang = tr.HitNormal:Angle()
			end
			if tr.HitPos == nil then
				hitpos = self.oldpos
			else
				hitpos = tr.HitPos
			end
		end
		if self.Caliber != "wac_base_20mm" and self.Caliber != "wac_base_30mm" and self.Caliber != "wac_base_40mm" then
			if !tr.HitSky then
				local bullet = {}
				bullet.Attacker = self.Owner
				bullet.Callback = nil
				
				if self.Caliber == "wac_base_12mm" then
					self.Damage = 60 * GetConVar("gred_sv_bullet_dmg"):GetFloat()
					if GetConVarNumber("gred_sv_12mm_he_impact") >= 1 then 
						bullet.Damage = zero 
						util.BlastDamage(self, self.Owner,hitpos, self.Radius, self.Damage)
					else
						bullet.Damage = self.Damage
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
					self.Damage = 40 * GetConVar("gred_sv_bullet_dmg"):GetFloat()
					if GetConVarNumber("gred_sv_7mm_he_impact") >= 1 then
						bullet.Damage = zero
						util.BlastDamage(self, self.Owner,hitpos, self.Radius, self.Damage)
					else
						bullet.Damage = self.Damage 
					end
					hitang = hitang+Angle(90,0,0)
					
				end
				bullet.Force = 100
				bullet.HullSize = zero
				bullet.Num = 1
				bullet.Tracer = zero
				bullet.AmmoType = null
				bullet.TracerName = nil
				bullet.Dir = self:GetForward()
				bullet.Spread = Vector(threeZ)
				bullet.Src = self:GetPos()
				self:FireBullets(bullet,false)
				
				if !self.NoParticle then
					net.Start("gred_net_impact_fx")
						net.WriteBool(false)
						net.WriteString(self.Caliber)
						if self.Caliber == "wac_base_7mm" then
							self.Mats={
								default_silent			=	-1,
								floatingstandable		=	-1,
								no_decal				=	-1,
								
								boulder 				=	1,
								concrete				=	1,
								default					=	1,
								item					=	1,
								concrete_block			=	1,
								plaster					=	1,
								pottery					=	1,
								
								dirt					=	2,
										
								alienflesh				=	3,
								antlion					=	3,
								armorflesh				=	3,
								bloodyflesh				=	3,
								player					=	3,
								flesh					=	3,
								player_control_clip		=	3,
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
								metal_Box				=	5,
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
								popcan					=	5,
								weapon					=	5,
									
								quicksand				=	6,
								sand					=	6,
								slipperyslime			=	6,
								antlionsand				=	6,
								
								snow					=	7,
									
								foliage					=	8,
								
								wood					=	9,
								wood_box				=	9,
								wood_crate 				=	9,
								wood_furniture			=	9,
								wood_lowDensity 		=	9,
								ladder 					=	9,
								wood_plank				=	9,
								wood_panel				=	9,
								wood_polid				=	9,
									
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
							net.WriteInt(self.Mats[util.GetSurfacePropName(tr.SurfaceProps)] or 24,6)
						end
						net.WriteVector(hitpos)
						net.WriteAngle(hitang)
					net.Broadcast()
				end
			end
		else
			if SERVER then
				if self.FuzeTime > 0 then
					hitpos = self:GetPos()
					hitang = Angle(threeZ)
					hitsky = true
				else
					hitsky = tr.HitSky
				end
			end
			if self.Caliber == "wac_base_30mm" then
				self.Damage = 100 * GetConVar("gred_sv_bullet_dmg"):GetFloat()
				util.BlastDamage(self, self.Owner, hitpos, self.Radius*3, self.Damage)
				self.Entity:EmitSound("impactsounds/30mm_1.wav",140, math.random(90,120),1, CHAN_AUTO)
			elseif self.Caliber == "wac_base_20mm" then
				self.Damage = 80 * GetConVar("gred_sv_bullet_dmg"):GetFloat()
				self.Entity:EmitSound( "impactsounds/20mm_0"..math.random(1,5)..".wav",100, 100,0.7, CHAN_AUTO)
				util.BlastDamage(self,self.Owner,hitpos,self.Radius*2, self.Damage)
			else
				self.Damage = 120 * GetConVar("gred_sv_bullet_dmg"):GetFloat()
				self.Entity:EmitSound( "impactsounds/20mm_0"..math.random(1,5)..".wav",100, 100,0.7, CHAN_AUTO)
				util.BlastDamage(self,self.Owner,hitpos,self.Radius*4, self.Damage)
			end
			local bullet = {}
			bullet.Damage = zero
			bullet.Attacker = self.Owner
			bullet.Callback = nil
			bullet.Damage = zero
			bullet.Force = 100
			bullet.HullSize = zero
			bullet.Num = 1
			bullet.Tracer = zero
			bullet.AmmoType = null
			bullet.TracerName = null
			bullet.Dir = self:GetForward()
			bullet.Spread = Vector(threeZ)
			bullet.Src = self:GetPos()
			if !hitsky then self:FireBullets( bullet, false ) end
			if !self.NoParticle then
				net.Start("gred_net_impact_fx")
					net.WriteBool(false)
					net.WriteString(self.Caliber)
					net.WriteBool(hitsky)
					net.WriteVector(hitpos)
					if !hitsky then net.WriteAngle(hitang) end
				net.Broadcast()
			end
		end
		self:Remove()
	end
end