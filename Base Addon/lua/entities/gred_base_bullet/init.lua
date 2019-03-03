
AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")


function ENT:Initialize()
	--[[if hab.Module.PhysBullet then
		local OpBullets = GetConVar("gred_sv_lfs_normal_bullets"):GetInt() == 1
		local bullet = {}
		bullet.Attacker = self:GetOwner()
		bullet.Callback = nil
		bullet.Tracer = GetConVar("gred_sv_tracers"):GetInt()
		if self.Caliber == "wac_base_12mm" then
			if self.CustomDMG and !OpBullets then
					self.Damage = self.Damage * GetConVar("gred_sv_bullet_dmg"):GetFloat()
			else
				self.Damage = 60 * GetConVar("gred_sv_bullet_dmg"):GetFloat()
			end
			if GetConVar("gred_sv_12mm_he_impact"):GetInt() >= 1 then 
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
				self.Damage = self.Damage * GetConVar("gred_sv_bullet_dmg"):GetFloat()
			else
				self.Damage = 40 * GetConVar("gred_sv_bullet_dmg"):GetFloat()
			end
			if GetConVar("gred_sv_7mm_he_impact"):GetInt() >= 1 then
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
				self.Damage = self.Damage * GetConVar("gred_sv_bullet_dmg"):GetFloat()
			else
				self.Damage = 100 * GetConVar("gred_sv_bullet_dmg"):GetFloat()
			end
			-- self:EmitSound("impactsounds/30mm_old.wav",100, math.random(90,110),1, CHAN_AUTO)
		elseif self.Caliber == "wac_base_20mm" then
			if self.CustomDMG and !OpBullets then
				self.Damage = self.Damage * GetConVar("gred_sv_bullet_dmg"):GetFloat()
			else
				self.Damage = 80 * GetConVar("gred_sv_bullet_dmg"):GetFloat()
			end
			-- self:EmitSound( "impactsounds/20mm_0"..math.random(1,5)..".wav",100, 100,0.7, CHAN_AUTO)
			bullet.AmmoType = "hvap_20x102_hei"
		else
			if self.CustomDMG and !OpBullets then
				self.Damage = self.Damage * GetConVar("gred_sv_bullet_dmg"):GetFloat()
			else
				self.Damage = 120 * GetConVar("gred_sv_bullet_dmg"):GetFloat()
			end
			-- self:EmitSound( "impactsounds/20mm_0"..math.random(1,5)..".wav",100, 100,0.7, CHAN_AUTO)
		end
		bullet.Force = 5
		bullet.HullSize = zero
		bullet.Num = 1
		bullet.Dir = self:GetForward()
		bullet.Spread = Vector(threeZ)
		bullet.Src = self:GetPos()
		bullet.IgnoreEntity = self.Filter or self
		self:FireBullets(bullet,false)
		self:SetModel("models/mm1/box.mdl")
		DONOTSPAWN = true
	else]]
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
		
		self.Radius = self.Radius * GetConVar("gred_sv_bullet_radius"):GetFloat()
		-- self.Damage = self.Damage * GetConVar("gred_sv_bullet_dmg"):GetFloat()
		
		if self.FuzeTime > 0 then
			self.GetExplTime = CurTime() + self.FuzeTime 
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
		self.oldpos=self.orpos-(self:GetAngles():Forward()*self.Speed)
		self.Filter = self.Filter or {self.Entity}
		local tableinsert = table.insert
		for k,v in pairs(self.Filter) do
			if istable(v) then
				for a,b in pairs(v) do
					tableinsert(self.Filter,b)
				end
			end
		end
		tableinsert(self.Filter,self.Entity)
		self.Mask = MASK_ALL
		self.explodable = self.Caliber == "wac_base_20mm" or self.Caliber == "wac_base_30mm" or self.Caliber == "wac_base_40mm"
	-- end
end

function ENT:PhysicsUpdate(ph)
	local pos=self:GetPos()
	if !util.IsInWorld(pos) then self:Remove() end
	if !self.oldpos then self:Remove() return end
	local difference = pos - self.oldpos
	local dif = pos + difference
	self.oldpos = pos
	local trace = {}
	trace.start = pos
	trace.endpos = dif
	trace.filter = self.Filter
	
	trace.mask=self.Mask
	local tr = util.TraceLine(trace)
	if tr.MatType == 83 then
		local effectdata = EffectData()
		effectdata:SetOrigin(tr.HitPos)
		effectdata:SetAngles(Angle(0,0,0))
		effectdata:SetSurfaceProp(0)
		effectdata:SetMaterialIndex(0)
		effectdata:SetFlags(table.KeyFromValue(gred.Calibre,self.Caliber))
		util.Effect("gred_particle_impact",effectdata)
		
		self.NoParticle = true
		self:EmitSound( "impactsounds/water_bullet_impact_0"..math.random(1,5)..".wav",audioSpecs )
	end
	if tr.Hit and not table.HasValue(self.Filter,tr.Entity) then
		self:Explode(tr)
		return
	else
		if !util.IsInWorld(dif) then
			if self.explodable then 
				self:Explode(tr)
			else 
				self:Remove()
			end
		else
			self.Entity:SetPos(dif)
		end
	end
	if self.FuzeTime > 0 then
		if CurTime() >= self.GetExplTime then
			self:Explode()
			return
		end
	end
end

function ENT:Think()
	if DONOTSPAWN then self:Remove() return end
	self.phys:Wake()
end
