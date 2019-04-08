
AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")


function ENT:PhysicsUpdate(ph)
	if self.CEASE then return end
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
	if self.FuseTime > 0 then
		if CurTime() >= self.GetExplTime then
			self:Explode()
			return
		end
	end
end

function ENT:Think()
	if DONOTSPAWN then 
		SafeRemoveEntityDelayed(self,3)
	else
		if not self.CEASE then
			self.phys:Wake()
		end
	end
end
