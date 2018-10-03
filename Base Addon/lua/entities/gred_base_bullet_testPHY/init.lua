
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
	
	
	local physEnvironment = physenv.GetPerformanceSettings()
	physEnvironment.MaxVelocity = 9999999999
	physenv.SetPerformanceSettings(physEnvironment)
	
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
		-- self.phys:EnableGravity(true)
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
	if self.Collided then self:Remove() end
	if !self.explodable then return end
	-- if !util.IsInWorld(pos) then self:Remove() end
	-- if !self.oldpos then self:Remove() return end
	-- local difference = (pos - self.oldpos)
	-- self.oldpos = pos
	-- local dif = pos + difference
	-- local trace = {}
	-- trace.start = pos
	-- trace.endpos = dif
	-- trace.filter = self.Entity
	-- trace.mask=self.Mask
	-- local tr = util.TraceLine(trace)
	-- local tr = util.QuickTrace(pos,dif,self.Entity)
	-- local hit = tr.Hit
	-- local nohitwater = tr.MatType != 83 
	-- if hit and nohitwater then
		-- self.Explode(self,tr)
		-- return
	-- else
		-- if !util.IsInWorld(dif) then
			-- if self.explodable then 
				-- self:Explode(self,tr)
			-- else 
				-- self:Remove()
			-- end
		-- else
			-- self.Entity:SetPos(dif)
		-- end
	-- end
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
		local tr = util.QuickTrace(data.HitPos,data.HitPos,self)
		self.tr = tr
		data.HitEntity:SetVelocity(data.TheirOldVelocity)
		data.HitEntity:SetPos(data.HitEntity:GetPos())
		self:Explode(self,tr)
		self.Collided = true
		self:Remove()
	end)
end
function ENT:Think()
	if self.Collided then self:Remove() end
	self.phys:Wake()
end