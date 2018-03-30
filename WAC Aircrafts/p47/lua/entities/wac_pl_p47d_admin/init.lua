include("shared.lua")
AddCSLuaFile("shared.lua")


function ENT:SpawnFunction(ply, tr)
	if (!tr.Hit) then return end
	local ent=ents.Create(ClassName)
	ent:SetPos(tr.HitPos+tr.HitNormal*10)
	ent:Spawn()
	ent:Activate()
	ent.Owner=ply
	return ent
end

ENT.Aerodynamics = {
	Rotation = {
		Front = Vector(0, -1.5, 0),
		Right = Vector(0, 0, 20), -- Rotate towards flying direction
		Top = Vector(0, -20, 0)
	},
	Lift = {
		Front = Vector(0, 0, 12.25), -- Go up when flying forward
		Right = Vector(0, 0, 0),
		Top = Vector(0, 0, -0.25)
	},
	Rail = Vector(1, 5, 20),
	Drag = {
		Directional = Vector(0.01, 0.01, 0.01),
		Angular = Vector(0.01, 0.01, 0.01)
	}
}

function ENT:PhysicsUpdate(ph)
	self:base("wac_pl_base").PhysicsUpdate(self,ph)

	if self.rotorRpm < 0.8 and IsValid(self.rotorModel) then
		self.rotorModel:SetBodygroup(0,0)
	elseif self.rotorRpm > 0.8 and IsValid(self.rotorModel) then
		self.rotorModel:SetBodygroup(0,1)
	end
	
	local trace=util.QuickTrace(self:LocalToWorld(Vector(0,0,62)), self:LocalToWorld(Vector(0,0,50)), {self, self.wheels[1], self.wheels[2], self.wheels[3], self.rotor})
	local phys=self:GetPhysicsObject()
	if IsValid(phys) and not self.disabled then
		if self.controls.throttle>0 and self.rotorRpm>0.8 and phys:GetVelocity():Length() > 1600 and trace.HitPos:Distance( self:LocalToWorld(Vector(0,0,62)) ) > 50 then
			self:SetBodygroup(1,1)
			self:SetBodygroup(2,1)
			for i=1,3 do 
				self.wheels[i]:SetRenderMode(RENDERMODE_TRANSALPHA)
				self.wheels[i]:SetColor(Color(255,255,255,0))
				self.wheels[i]:SetSolid(SOLID_NONE)
			end
		elseif self.controls.throttle<0 and trace.HitPos:Distance( self:LocalToWorld(Vector(0,0,62)) ) > 50 then
			if self.wheels then
				for i=1,3 do 
					self.wheels[i]:SetRenderMode(RENDERMODE_NORMAL)
					self.wheels[i]:SetColor(Color(255,255,255,255))
					self.wheels[i]:SetSolid(SOLID_VPHYSICS)
				end
			end
			self:SetBodygroup(1,0)
			self:SetBodygroup(2,0)
		end
	end
end

function ENT:addRotors()
	self:base("wac_pl_base").addRotors(self)
	
	self.rotorModel.TouchFunc=nil
end

function ENT:Think()
self:base("wac_pl_base").Think(self)

if self.engineHealth <= 0 then
timer.Simple( 5, function() if IsValid(self) then self:Remove() end end )
end

end
