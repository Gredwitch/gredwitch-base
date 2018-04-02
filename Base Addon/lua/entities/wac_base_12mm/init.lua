
AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()
	self.Entity:SetModel("models/mm1/box.mdl")		
	self.Entity:PhysicsInit(SOLID_VPHYSICS)
	self.Entity:SetMoveType(MOVETYPE_VPHYSICS)
	self.Entity:SetSolid(SOLID_VPHYSICS)
	self.phys = self.Entity:GetPhysicsObject()
	if self.phys:IsValid() then
		self.phys:SetMass(5)
		self.phys:EnableCollisions(true)
	end	
	if (self.phys:IsValid()) then
		self.phys:Wake()
		self.phys:EnableGravity(true)
	end
	if self.Speed == nil then self.Speed = 1000 end
	if self.Damage == nil then self.Damage = 40 end
	if self.Radius == nil then self.Radius = 70 end
	if self.Owner == nil then self.Owner = ply end
	self.oldpos=self:GetPos()-self:GetAngles():Forward()*self.Speed
	self:SetNotSolid(true)
	self.cbt={}
	self.cbt.health=5000
	self.cbt.armor=500
	self.cbt.maxhealth=5000
	self:SetNWInt("gunRPM", self.gunRPM)--Prevents earrape
	self:SetNWBool("sequential", self.sequential)--Prevents earrape
	self:SetNWInt("npod", self.npod)--Prevents earrape
	self:SetColor(255,255,255,0)
	self:SetRenderMode(RENDERMODE_GLOW)
	if self.npod == nil then self.npod = 1 end
	self.startTime=CurTime()
	self.canThink=true
	self.IsBullet=true
	self:NextThink(CurTime())
	--self.phys:EnableCollisions(false)
end

ENT.Explode=function(self,tr)
	if self.Exploded then return end
	self.Exploded = true
	if !tr.HitSky then
		self.Owner = self.Owner or self.Entity
		if GetConVarNumber("gred_12mm_he_impact") >= 1 then
			util.BlastDamage(self, self.Owner, tr.HitPos, self.Radius, self.Damage)
		end
		local bullet = {}
		bullet.Attacker = self.Owner
		bullet.Callback = nil
		bullet.Damage = self.Damage*3
		bullet.Force = self.Radius*5
		bullet.HullSize = 0
		bullet.Num = 1
		bullet.Tracer = 0
		bullet.AmmoType = "12.7mm"
		bullet.TracerName = nil
		bullet.Dir = self.Entity:GetForward()
		bullet.Spread = Vector(0,0,0)
		bullet.Src = self.Entity:GetPos()
		self:FireBullets( bullet, false )
		ParticleEffect("doi_gunrun_impact",tr.HitPos,tr.HitNormal:Angle(),nil)
		local d
		if self.gunRPM >= 4000 then d = (self.gunRPM / 20000) else d = (self.gunRPM / 5000) end
		if self.gunRPM >= 1000 then
			self.Entity:EmitSound( "impactsounds/gun_impact_"..math.random(1,14)..".wav",100, 100,d, CHAN_AUTO )
			
		elseif !self.sequential then
			d = 1 / self.npod
			self.Entity:EmitSound( "impactsounds/gun_impact_"..math.random(1,14)..".wav",100, 100,d, CHAN_AUTO )--self.Entity:EmitSound( "impactsounds/concrete_bullet_impact_0"..math.random(1,5)..".wav",100, 100,1, CHAN_AUTO )
		else
			self.Entity:EmitSound( "impactsounds/gun_impact_"..math.random(1,14)..".wav",100, 100,1, CHAN_AUTO )
		end
	end
end

function ENT:PhysicsUpdate(ph)
	if !util.IsInWorld(self:GetPos()) then self:Remove() end
	local speed=self.Speed
	if !self.oldpos then self:Remove() return end
	local pos=self:GetPos()
	local difference = (pos - self.oldpos)
	if !self.canThink or speed<50 or self.NoTele then
		self:SetVelocity(difference*1000)
	end
	self.oldpos = pos
	
	local trace = {}
	trace.start = pos
	trace.endpos = pos+difference
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
	trdat2.endpos  = pos-difference
	trdat2.filter  = self
	trdat2.mask    = MASK_WATER
	local tr2 = util.TraceLine(trdat2)
	if tr2.Hit then
		if GetConVarNumber("gred_water_impact") == 1 then
			ParticleEffect("impact_water",tr2.HitPos,Angle(-90,0,0),nil)
		end
		self.Entity:EmitSound( "impactsounds/water_bullet_impact_0"..math.random(1,5)..".wav",100, 100,1, CHAN_AUTO )
	end
	
end

function ENT:Think()
	self.phys:Wake()
end
