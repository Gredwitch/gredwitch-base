
AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()
	self.Entity:SetModel("models/gredwitch/bullet.mdl")
	self.Entity:PhysicsInit(SOLID_VPHYSICS)
	self.Entity:SetMoveType(MOVETYPE_VPHYSICS)
	self.Entity:SetSolid(SOLID_VPHYSICS)
	self.Entity:SetCollisionGroup(COLLISION_GROUP_NONE)
	self:SetRenderMode(RENDERMODE_TRANSALPHA)
	self:SetColor(Color(255,255,255,0))
	
	
	self.phys = self.Entity:GetPhysicsObject()
	if self.Caliber == "wac_base_7mm" then
		mass = 10
	elseif self.Caliber == "wac_base_12mm" then
		mass = 15
	elseif self.Caliber == "wac_base_20mm" then
		mass = 20
	elseif self.Caliber == "wac_base_30mm" then
		mass = 30
	elseif self.Caliber == "wac_base_40mm" then
		mass = 40
	end
	if IsValid(self.phys) then
		self.phys:SetMass(mass)
		self.phys:EnableCollisions(true)
		self.phys:Wake()
		self.phys:ApplyForceCenter(self:GetForward()*1000000) 
	end
	
	if self.Speed == nil then self.Speed = 1000 end
	if self.Damage == nil then self.Damage = 40 end
	if self.Radius == nil then self.Radius = 70 end
	if self.Owner == nil then self.Owner = ply end
	if self.npod == nil then self.npod = 1 end
	-- if CLIENT then self:SetCaliber(self.Caliber) end
	
	self.Radius = self.Radius * GetConVar("gred_sv_bullet_radius"):GetFloat()
	-- 
	self.NoParticle = false
	
	self:SetNWInt("gunRPM", self.gunRPM)
	self:SetNWBool("sequential", self.sequential)
	self:SetNWInt("npod", self.npod)
	self.IsBullet=true
	if self.FuzeTime > 0 then
		self.GetExplTime = CurTime() + self.FuzeTime 
	end
	
	self.explodable = self.Caliber != "wac_base_7mm" and self.Caliber != "wac_base_12mm"
	if !self.notracer then self:SetColor(Color(255,255,255,255)) end
	self:NextThink(CurTime())
end

function ENT:PhysicsUpdate(ph)
	if !self.explodable then return end
	if self.FuzeTime > 0 then
		if CurTime() >= self.GetExplTime then
			self:Explode()
			return
		end
	end
	if self:WaterLevel() >= 1 then
		net.Start("gred_net_impact_fx")
			net.WriteBool(true)
			net.WriteString(self.Caliber)
			net.WriteVector(self:GetPos())
		net.Broadcast()
		self.NoParticle = true
		self.HitWater = true
		self:EmitSound( "impactsounds/water_bullet_impact_0"..math.random(1,5)..".wav",audioSpecs )
		self:Explode()
	end
end
function ENT:PhysicsCollide(data,phys)
	timer.Simple(0,function()
		self:Explode(data)
		self.tr = data
	end)
end
function ENT:Think()
	self.phys:Wake()
end

function ENT:Explode(tr)
	if self.Exploded then return end
	self.Exploded = true
	-- if not IsValid(self.Owner) then 
		-- if IsValid(self.Entity) then self.Owner = self.Entity
		-- else self.Owner = nil end
	-- end
	-- local tr = self.tr
	local pos = self:GetPos()
	local hitpos = tr.HitPos
	local hitang = tr.HitNormal:Angle()
	
	if !self.explodable then
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
			hitang:Add(Angle(180,0,0))
		elseif self.Caliber == "wac_base_7mm" then
			self.Damage = 40 * GetConVar("gred_sv_bullet_dmg"):GetFloat()
			if GetConVarNumber("gred_sv_7mm_he_impact") >= 1 then
				bullet.Damage = zero
				util.BlastDamage(self, self.Owner,hitpos, self.Radius, self.Damage)
			else
				bullet.Damage = self.Damage 
			end
		end
		bullet.Force = 5
		bullet.HullSize = zero
		bullet.Num = 1
		bullet.Tracer = zero
		bullet.AmmoType = null
		bullet.TracerName = nil
		bullet.Dir = tr.HitNormal
		bullet.Spread = Vector(threeZ)
		bullet.Src = pos
		self:FireBullets(bullet,false)
		if !self.NoParticle then
			net.Start("gred_net_impact_fx")
				net.WriteBool(false)
				net.WriteString(self.Caliber)
				-- if self.Caliber == "wac_base_7mm" then
					-- net.WriteInt(self.Mats[util.GetSurfacePropName(tr.SurfaceProps)] or 24,6)
				-- end
				net.WriteVector(hitpos)
				net.WriteAngle(hitang)
			net.Broadcast()
		end
	else
		if !self.HitWater then
			if self.FuzeTime > 0 then
				hitpos = pos
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
		bullet.Src = pos
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