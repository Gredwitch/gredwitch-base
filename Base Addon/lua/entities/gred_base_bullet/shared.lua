ENT.Type 			= "anim"
ENT.Base 			= "base_gmodentity"
ENT.Author 			= "Gredwich"
ENT.Category 		= ""
ENT.Spawnable		= false
ENT.AdminSpawnable  = false
ENT.FuseTime		= 0
ENT.Filter			= {}
-- ENT.Caliber			= ""

for i = 1,14 do
sound.Add( {
	name = "GRED_IMPACT_12MM_"..i,
	channel = CHAN_STATIC,
	volume = 1.0,
	level = 140,
	pitch = {100},
	sound = "impactsounds/gun_impact_"..i
} )
end


local zero = 0
local threeZ = zero,zero,zero
local audioSpecs = 100, 100,1, CHAN_AUTO
local null = ""
local tableinsert = table.insert
local pairs = pairs
local istable = istable
local IsValid = IsValid
local RENDERMODE_TRANSALPHA = RENDERMODE_TRANSALPHA

local IsListen 
local OverrideHAB = GetConVar("gred_sv_override_hab")
local Tracers = GetConVar("gred_sv_tracers")
local LFSNormalBullets = GetConVar("gred_sv_lfs_normal_bullets")
local BulletDMG = GetConVar("gred_sv_bullet_dmg")
local SERVER = SERVER
local CLIENT = CLIENT
local HE12MM = GetConVar("gred_sv_12mm_he_impact")
local HE7MM = GetConVar("gred_sv_7mm_he_impact")
local HERADIUS = GetConVar("gred_sv_bullet_radius")

function ENT:SetupDataTables()
	self:NetworkVar("String",0,"Caliber")
	self:NetworkVar("String",1,"Filter")
	
	self:NetworkVar("Float",0,"FuseTime")
end

function ENT:CheckFilter()
	local old = self.Filter
	self.Filter = {}
	for k,v in pairs(old) do
		table.remove(self.Filter,k)
		if IsValid(v) then
			if istable(v) then
				for a,b in pairs(v) do
					tableinsert(self.Filter,b)
				end
			else
				tableinsert(self.Filter,v)
			end
		end
	end
	tableinsert(self.Filter,self)
end

function ENT:Initialize()
	self.fuckHavok = OverrideHAB:GetInt() == 1
	self:SetRenderMode(RENDERMODE_TRANSALPHA)
	
	if hab and hab.Module.PhysBullet then
		if SERVER then self:SetFuseTime(self.FuseTime) end
		if CLIENT then self.FuseTime = self:GetFuseTime() end
	end
	
	if hab and (hab.Module.PhysBullet and not self.fuckHavok) and self.FuseTime == 0 then
		self:Init_Hab()
	else
		if SERVER then
			self.Entity:SetModel("models/gredwitch/bullet.mdl")
			self.Entity:PhysicsInit(SOLID_VPHYSICS)
			self.Entity:SetMoveType(MOVETYPE_VPHYSICS)
			self.Entity:SetSolid(SOLID_VPHYSICS)
			self:SetNotSolid(true)
			if self.noTracer then self:SetRenderMode(RENDERMODE_TRANSALPHA) end
			self.phys = self.Entity:GetPhysicsObject()
			if self.phys:IsValid() then
				self.phys:SetMass(5)
				self.phys:EnableCollisions(true)
				self.phys:EnableGravity(true)
				self.phys:Wake()
			end
			
			if self.Damage == nil then self.Damage = 40 end
			if self.Radius == nil then self.Radius = 70 end
			if self.Owner == nil then self.Owner = ply end
			if self.npod == nil then self.npod = 1 end
			
			self.Radius = self.Radius * HERADIUS:GetFloat()
			-- self.Damage = self.Damage * BulletDMG:GetFloat()
			
			if self.FuseTime > 0 then
				self.GetExplTime = CurTime() + self.FuseTime 
			end
			if self.Caliber == "wac_base_7mm" then
				self.Speed = 1000
			elseif self.Caliber == "wac_base_12mm" then
				self.Speed = 700
			elseif self.Caliber == "wac_base_20mm" then
				self.Speed = 600
			elseif self.Caliber == "wac_base_30mm" then
				self.Speed = 500
			elseif self.Caliber == "wac_base_40mm" then
				self.Speed = 400
			end
			
			self.orpos = self:GetPos()
			self.oldpos = self.orpos - (self:GetAngles():Forward() * self.Speed)
			for k,v in pairs(self.Filter) do
				if istable(v) then
					for a,b in pairs(v) do
						tableinsert(self.Filter,b)
					end
				end
			end
			self.Mask = MASK_ALL
			self.explodable = self.Caliber == "wac_base_20mm" or self.Caliber == "wac_base_30mm" or self.Caliber == "wac_base_40mm"
		end
	end
end

function ENT:Init_Hab()
	if SERVER then
		self:SetCaliber(self.Caliber)
		self:CheckFilter()
		local STR = ""
		for k,v in pairs(self.Filter) do
			STR = STR.." "..tostring(v:EntIndex())
		end
		self:SetFilter(STR)
	end
	if CLIENT then
		self.Caliber = self:GetCaliber()
		self.Filter = string.Explode(" ",self:GetFilter())
		table.remove(self.Filter,1)
		for k,v in pairs(self.Filter) do
			self.Filter[k] = Entity(v)
		end
	end
	
	self.Caliber = self:GetCaliber()
	local OpBullets = LFSNormalBullets:GetInt() == 1
	local bullet = {}
	bullet.Attacker = self.Owner
	bullet.Callback = nil
	bullet.Tracer = Tracers:GetInt()
	if self.Caliber == "wac_base_12mm" then
		if self.CustomDMG and !OpBullets then
				self.Damage = self.Damage * BulletDMG:GetFloat()
		else
			self.Damage = 60 * BulletDMG:GetFloat()
		end
		if HE12MM:GetInt() >= 1 then 
			bullet.Damage = zero 
			-- util.BlastDamage(self, self.Owner,hitpos, self.Radius, self.Damage)
		else
			bullet.Damage = self.Damage
		end
		if self.col == "Green" then
			bullet.AmmoType = "hvap_127x108_ap"
		else
			bullet.AmmoType = "hvap_127x99_ap"
		end
	elseif self.Caliber == "wac_base_7mm" then
		if self.CustomDMG and !OpBullets then
			self.Damage = self.Damage *BulletDMG:GetFloat()
		else
			self.Damage = 40 * BulletDMG:GetFloat()
		end
		if HE7MM:GetInt() >= 1 then
			bullet.Damage = zero
			-- util.BlastDamage(self, self.Owner,hitpos, self.Radius, self.Damage)
		else
			bullet.Damage = self.Damage 
		end
		if self.col == "Green" then
			bullet.AmmoType = "hab_792x57"
		elseif self.col == "Yellow" then
			bullet.AmmoType = "hab_77x56"
		else
			bullet.AmmoType = "hab_762x63"
		end
	elseif self.Caliber == "wac_base_30mm" then
		if self.CustomDMG and !OpBullets then
			self.Damage = self.Damage * BulletDMG:GetFloat()
		else
			self.Damage = 100 * BulletDMG:GetFloat()
		end
		-- self:EmitSound("impactsounds/30mm_old.wav",100, math.random(90,110),1, CHAN_AUTO)
	elseif self.Caliber == "wac_base_20mm" then
		if self.CustomDMG and !OpBullets then
			self.Damage = self.Damage * BulletDMG:GetFloat()
		else
			self.Damage = 80 * BulletDMG:GetFloat()
		end
		-- self:EmitSound( "impactsounds/20mm_0"..math.random(1,5)..".wav",100, 100,0.7, CHAN_AUTO)
		bullet.AmmoType = "hvap_20x102_hei"
	else
		if self.CustomDMG and !OpBullets then
			self.Damage = self.Damage * BulletDMG:GetFloat()
		else
			self.Damage = 120 * BulletDMG:GetFloat()
		end
		-- self:EmitSound( "impactsounds/20mm_0"..math.random(1,5)..".wav",100, 100,0.7, CHAN_AUTO)
	end
	bullet.Force = 5
	bullet.HullSize = 0
	bullet.Num = 1
	bullet.Dir = self:GetForward()
	bullet.Spread = Vector(0)
	bullet.Src = self:GetPos()
	bullet.IgnoreEntity = {}
	for k,v in pairs(self.Filter) do tableinsert(bullet.IgnoreEntity,v) end
	
	self:FireBullets(bullet,false)
	self:SetModel("models/mm1/box.mdl")
	DONOTSPAWN = true
end

if SERVER then
	function ENT:Explode(tr,ply)
		if self.Exploded then return end
		self.Exploded = true
		if not IsValid(self.Owner) then 
			if IsValid(self.Entity) then self.Owner = self.Entity
			else self.Owner = nil end
		end
		local pos = self:GetPos()
		if self.FuseTime == 0 then
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
		local OpBullets = LFSNormalBullets:GetInt() == 1
		if !self.explodable then
			if !tr.HitSky then
				local bullet = {}
				bullet.Attacker = self:GetOwner()
				bullet.Callback = nil
				
				if self.Caliber == "wac_base_12mm" then
					if self.CustomDMG and !OpBullets then
						self.Damage = self.Damage * BulletDMG:GetFloat()
					else
						self.Damage = 60 * BulletDMG:GetFloat()
					end
					if HE12MM:GetInt() >= 1 then 
						bullet.Damage = zero 
						util.BlastDamage(self, self.Owner,hitpos, self.Radius, self.Damage)
					else
						bullet.Damage = self.Damage
					end
					local d
					self.Entity:EmitSound("GRED_IMPACT_12MM_"..math.random(1,14))
					
				elseif self.Caliber == "wac_base_7mm" then
					if self.CustomDMG and !OpBullets then
						self.Damage = self.Damage * BulletDMG:GetFloat()
					else
						self.Damage = 40 * BulletDMG:GetFloat()
					end
					if HE7MM:GetInt() >= 1 then
						bullet.Damage = zero
						util.BlastDamage(self, self.Owner,hitpos, self.Radius, self.Damage)
					else
						bullet.Damage = self.Damage 
					end
					hitang:Add(Angle(90,0,0))
					
				end
				bullet.Force = 5
				bullet.HullSize = zero
				bullet.Num = 1
				bullet.Tracer = zero
				bullet.AmmoType = null
				bullet.TracerName = nil
				bullet.Dir = self:GetForward()
				bullet.Spread = Vector(threeZ)
				bullet.Src = pos
				bullet.IgnoreEntity = self.Filter
				self:FireBullets(bullet,false)
				if !self.NoParticle then
					local effectdata = EffectData()
					effectdata:SetOrigin(hitpos)
					effectdata:SetAngles(hitang)
					effectdata:SetFlags(table.KeyFromValue(gred.Calibre,self.Caliber))
					if self.Caliber == "wac_base_7mm" then
						effectdata:SetSurfaceProp(gred.Mats[util.GetSurfacePropName(tr.SurfaceProps)] or 24,6)
					else
						effectdata:SetSurfaceProp(0)
					end
					effectdata:SetMaterialIndex(1)
					util.Effect("gred_particle_impact",effectdata)
				end
			end
		else
			if self.FuseTime > 0 then
				hitpos = pos
				hitang = Angle(threeZ)
				hitsky = true
			else
				hitsky = tr.HitSky
			end
			if self.Caliber == "wac_base_30mm" then
				if self.CustomDMG and !OpBullets then
					self.Damage = self.Damage * BulletDMG:GetFloat()
				else
					self.Damage = 100 * BulletDMG:GetFloat()
				end
				util.BlastDamage(self, self.Owner, hitpos, self.Radius*3, self.Damage)
				self.Entity:EmitSound("impactsounds/30mm_old.wav",100, math.random(90,110),1, CHAN_AUTO)
				-- local a = math.random(01,10)
				-- if a < 10 then a = "0"..a end
				-- self.Entity:EmitSound("impactsounds/30mm_"..a..".wav",100, math.random(90,120),1, CHAN_AUTO)
			elseif self.Caliber == "wac_base_20mm" then
				if self.CustomDMG and !OpBullets then
					self.Damage = self.Damage * BulletDMG:GetFloat()
				else
					self.Damage = 80 * BulletDMG:GetFloat()
				end
				self.Entity:EmitSound( "impactsounds/20mm_0"..math.random(1,5)..".wav",100, 100,0.7, CHAN_AUTO)
				util.BlastDamage(self,self.Owner,hitpos,self.Radius*2, self.Damage)
			else
				if self.CustomDMG and !OpBullets then
					self.Damage = self.Damage * BulletDMG:GetFloat()
				else
					self.Damage = 120 * BulletDMG:GetFloat()
				end
				self.Entity:EmitSound( "impactsounds/20mm_0"..math.random(1,5)..".wav",100, 100,0.7, CHAN_AUTO)
				util.BlastDamage(self,self.Owner,hitpos,self.Radius*4, self.Damage)
			end
			if !hitsky then 
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
				bullet.Src = pos
				bullet.IgnoreEntity = self.Filter
				self:FireBullets( bullet, false )
			end
			if !self.NoParticle then
				local effectdata = EffectData()
				effectdata:SetOrigin(hitpos)
				if !hitsky then 
					effectdata:SetAngles(hitang)
					effectdata:SetSurfaceProp(0)
				else 
					effectdata:SetAngles(Angle(0,0,0)) 
					effectdata:SetSurfaceProp(1)
				end
				effectdata:SetMaterialIndex(1)
				effectdata:SetFlags(table.KeyFromValue(gred.Calibre,self.Caliber))
				util.Effect("gred_particle_impact",effectdata)
			end
		end
		if hab and hab.Module.PhysBullet then
			self.CEASE = true
			self:SetColor(Color(255,255,255,0))
			SafeRemoveEntityDelayed(self,3)
		else
			self:Remove()
		end
	end
end