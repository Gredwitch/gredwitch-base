
AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")


function ENT:Initialize()
	self.Entity:SetModel("models/gredwitch/bullet.mdl")
	self.Entity:PhysicsInit(SOLID_VPHYSICS)
	self.Entity:SetMoveType(MOVETYPE_VPHYSICS)
	self.Entity:SetSolid(SOLID_VPHYSICS)
	self.Initialized = true
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
	
	-- self.Damage = self.Damage * GetConVar("gred_sv_bullet_dmg"):GetFloat()
	self.Radius = self.Radius * GetConVar("gred_sv_bullet_radius"):GetFloat()
	if self.noTracer then self:SetRenderMode(RENDERMODE_TRANSALPHA) end
	self:SetNotSolid(true)
	self:SetNWInt("gunRPM", self.gunRPM)
	self:SetNWBool("sequential", self.sequential)
	self:SetNWInt("npod", self.npod)
	self.IsBullet=true
	
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
	
	-- local trace = {}
	-- trace.start = self.orpos
	-- trace.endpos = self:GetPos() + self:GetForward()*9999
	-- trace.filter = self.Entity
	-- trace.mask=MASK_WATER
	-- local tr2 = util.TraceLine(trace)
	-- print(tr2.Hit)
	-- if tr2.Hit then
		-- self.WaterHitPos = tr.HitPos
	-- end
	
	self.Initialized = true
	self.explodable = self.Caliber == "wac_base_20mm" or self.Caliber == "wac_base_30mm" or self.Caliber == "wac_base_40mm"
end

function ENT:PhysicsUpdate(ph)
	local pos=self:GetPos()
	if !util.IsInWorld(pos) then self:Remove() end
	if !self.oldpos then self:Remove() return end
	local difference = pos - self.oldpos
	local dif = pos + difference
	if self:WaterLevel() >= 1 then
		local trace = {}
		trace.start = self.oldpos
		trace.endpos = dif
		trace.filter = self.Entity
		trace.mask=self.Mask
		local tr2 = util.TraceLine(trace)
		net.Start("gred_net_impact_fx")
			net.WriteBool(true)
			net.WriteString(self.Caliber)
			net.WriteVector(tr2.HitPos)
		net.Broadcast()
		self.NoParticle = true
		self:EmitSound( "impactsounds/water_bullet_impact_0"..math.random(1,5)..".wav",audioSpecs )
	end
	self.oldpos = pos
	local tr = util.QuickTrace(pos,dif-pos,self)
	if tr.Hit and tr.MatType != 83 then
		-- print(tr.MatType)
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
	if not self.Initialized then self:Initialize() end
	self.phys:Wake()
end
