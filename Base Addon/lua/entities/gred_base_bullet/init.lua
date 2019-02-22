
AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")


function ENT:Initialize()
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
	if !self.Filter then self.Filter = {self.Entity} else table.insert(self.Filter,self.Entity) end
	self.Mask = MASK_ALL
	self.explodable = self.Caliber == "wac_base_20mm" or self.Caliber == "wac_base_30mm" or self.Caliber == "wac_base_40mm"
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
	if tr.Hit then
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
function ENT:OnRemove()
	trace = nil
	Filter = nil
end
function ENT:Think()
	self.phys:Wake()
end
