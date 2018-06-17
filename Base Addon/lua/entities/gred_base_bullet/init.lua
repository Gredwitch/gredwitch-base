
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
		self.phys:Wake()
		self.phys:EnableGravity(true)
	end
	
	if self.Speed == nil then self.Speed = 1000 end
	if self.Damage == nil then self.Damage = 40 end
	if self.Radius == nil then self.Radius = 70 end
	if self.Owner == nil then self.Owner = ply end
	if self.npod == nil then self.npod = 1 end
	self.oldpos=self:GetPos()-self:GetAngles():Forward()*self.Speed
	self.Damage = self.Damage * GetConVar("gred_sv_bullet_dmg"):GetInt()
	self.Radius = self.Radius * GetConVar("gred_sv_bullet_radius"):GetInt()
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

function ENT:PhysicsUpdate(ph)
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
	if tr2.Hit and !self.Exploded then
		if CLIENT then
			local ply = LocalPlayer()
			if tonumber(ply:GetInfo("gred_cl_water_impact")) == 0 then return end
			if self.Caliber == "wac_base_7mm" then
				ParticleEffect("doi_impact_water",tr2.HitPos,Angle(-90,zero,zero),nil)
			elseif self.Caliber == "wac_base_12mm" then
				ParticleEffect("impact_water",tr2.HitPos,Angle(-90,zero,zero),nil)
			elseif self.Caliber == "wac_base_20mm" then
				ParticleEffect("water_small",tr2.HitPos,Angle(threeZ),nil)
			elseif self.Caliber == "wac_base_30mm" then
				ParticleEffect("water_medium",tr2.HitPos,Angle(threeZ),nil)
			end
		elseif LAN then
			if GetConVar("gred_cl_water_impact"):GetInt() == 0 then return end
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

function ENT:Think()
	self.phys:Wake()
end
