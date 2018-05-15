
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
		self.phys:EnableCollisions(false)
	end	
	if (self.phys:IsValid()) then
		self.phys:Wake()
		self.phys:EnableGravity(true)
	end
	self.oldpos=self:GetPos()-self:GetAngles():Forward()*self.Speed
	self:SetNotSolid(true)
	self.cbt={}
	self.cbt.health=5000
	self.cbt.armor=500
	self.cbt.maxhealth=5000
	self:SetNWInt("gunRPM", self.gunRPM)--Prevents earrape
	self:SetColor(255,255,255,0)
	self:SetRenderMode(RENDERMODE_TRANSALPHA)
	if self.npod == nil then self.npod = 1 end
	self.startTime=CurTime()
	self.canThink=true
	self.IsBullet=true
	self:NextThink(CurTime())
end

ENT.Explode=function(self,tr)
	if self.Exploded then return end
	self.Exploded = true
	if !tr.HitSky then
		self.Owner = self.Owner or self.Entity
		util.BlastDamage(self, self.Owner, tr.HitPos, self.Radius*6, self.Damage*8)
		local bullet = {}
		bullet.Attacker = self.Owner
		bullet.Callback = nil
		bullet.Damage = 0
		bullet.Force = self.Radius*4.5
		bullet.HullSize = 0
		bullet.Num = 1
		bullet.Tracer = 0
		bullet.AmmoType = "12.7mm"
		bullet.TracerName = nil
		bullet.Dir = self.Entity:GetForward()
		bullet.Spread = Vector(0,0,0)
		bullet.Src = self.Entity:GetPos()
		self:FireBullets( bullet, false )
		if GetConVarNumber("gred_noparticles_30mm") == 0 then
			ParticleEffect("30cal_impact",tr.HitPos,Angle(tr.HitNormal:Angle()),nil)
		end
		self.Entity:EmitSound( "impactsounds/30mm_1.wav",140, math.random(90,120),1, CHAN_AUTO )
	end
	self.Entity:Remove()
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
			ParticleEffect("water_medium",tr2.HitPos,Angle(0,0,0),nil)
		end
		self.Entity:EmitSound( "impactsounds/water_bullet_impact_0"..math.random(1,5)..".wav",100, 100,1, CHAN_AUTO )
		self:Remove()
	end
	
end

function ENT:Think()
	self.phys:Wake()
end
