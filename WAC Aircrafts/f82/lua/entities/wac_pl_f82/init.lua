include("shared.lua")
AddCSLuaFile("shared.lua")

function ENT:SpawnFunction(p, tr)
	if (!tr.Hit) then return end
	local e = ents.Create(ClassName)
	e:SetPos(tr.HitPos + tr.HitNormal*100)
	e.Owner = p
	e:Spawn()
	e:Activate()
	e:SetBodygroup(2,1)
	e:SetBodygroup(3,1)
	e:SetBodygroup(5,1)
	e:SetSkin(math.random(0,1))
	return e
end


function ENT:Think()
	self:base("wac_pl_base").Think(self)
	local ammo = self.weapons["HVAR"]:GetAmmo()
	if ammo >= 1 then
		self:SetBodygroup(3,1)
	else
		self:SetBodygroup(3,0)
	end
end

ENT.AutomaticFrameAdvance = true // needed for gear anims

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
	
	if self.active then
		self:SetBodygroup(2,0)
	else
		self:SetBodygroup(2,1)
	end
	
	local geardown,t1=self:LookupSequence("geardown")
	local gearup,t2=self:LookupSequence("gearup")	
	local trace=util.QuickTrace(self:LocalToWorld(Vector(0,0,62)), self:LocalToWorld(Vector(0,0,50)), {self, self.wheels[1], self.wheels[2], self.wheels[3], self.wheels[4], self.rotor})
	local phys=self:GetPhysicsObject()
	if IsValid(phys) and not self.disabled then
		if self.controls.throttle>0 and self.rotorRpm>0 and phys:GetVelocity():Length() > 1600 and trace.HitPos:Distance( self:LocalToWorld(Vector(0,0,62)) ) > 50  and self:GetSequence() != gearup then
			self:ResetSequence(gearup) 
			self:SetPlaybackRate(1.0)
			self:SetBodygroup(1,1)
			for i=1,4 do 
				self.wheels[i]:SetRenderMode(RENDERMODE_TRANSALPHA)
				self.wheels[i]:SetColor(Color(255,255,255,0))
				self.wheels[i]:SetSolid(SOLID_NONE)
			end
		elseif self.controls.throttle<0 and trace.HitPos:Distance( self:LocalToWorld(Vector(0,0,62)) ) > 50  and self:GetSequence() == gearup then
			self:ResetSequence(geardown)
			self:SetPlaybackRate(1.0)
			geardown,time1=self:LookupSequence("gearup")

			timer.Simple(time1,function()
				if self.wheels then
					for i=1,4 do 
						self.wheels[i]:SetRenderMode(RENDERMODE_NORMAL)
						self.wheels[i]:SetColor(Color(255,255,255,255))
						self.wheels[i]:SetSolid(SOLID_VPHYSICS)
					end
					self:SetBodygroup(1,0)
				end
			end)
		end
	end
	
	if self.rotorRpm > 0.5 and self.rotorRpm < 0.89 and IsValid(self.rotorModel) then
		self.rotorModel:SetBodygroup(1,1)
	elseif self.rotorRpm > 0.9 and IsValid(self.rotorModel) then
		self.rotorModel:SetBodygroup(1,2)
	elseif self.rotorRpm < 0.8 and IsValid(self.rotorModel) then
		self.rotorModel:SetBodygroup(1,0)
	end
	
	if self.rotorRpm > 0.5 and self.rotorRpm < 0.89 and IsValid(self.rotorModel2) then
		self.rotorModel2:SetBodygroup(1,1)
	elseif self.rotorRpm > 0.9 and IsValid(self.rotorModel2) then
		self.rotorModel2:SetBodygroup(1,2)
	elseif self.rotorRpm < 0.8 and IsValid(self.rotorModel2) then
		self.rotorModel2:SetBodygroup(1,0)
	end
	
	if self.rotor2 then
		local vel = ph:GetVelocity()	
		local pos = self:GetPos()
		local lvel = self:WorldToLocal(pos+vel)
		local throttle = self.controls.throttle/2 + 0.5
		local phm = FrameTime()*66
		local brake = (throttle+1)*self.rotorRpm/900+self.rotor.phys:GetAngleVelocity().z/100
		self.rotor2.phys:AddAngleVelocity(Vector(0,0,self.engineRpm*30 + throttle*self.engineRpm*20)*self.rotorDir*phm)
		self.rotor2.phys:AddAngleVelocity(Vector(0,0,-brake + lvel.x*lvel.x/500000)*self.rotorDir*phm)
	end
end

function ENT:addRotors()
	self:base("wac_pl_base").addRotors(self)

	self.rotorModel.TouchFunc=nil
	
	self.rotor2 = ents.Create("prop_physics")
	self.rotor2:SetModel("models/props_junk/sawblade001a.mdl")
	self.rotor2:SetPos(self:LocalToWorld(self.rotorPos2))
	self.rotor2:SetAngles(self:GetAngles() + Angle(90, 0, 0))
	self.rotor2:SetOwner(self.Owner)
	self.rotor2:Spawn()
	self.rotor2:SetNotSolid(true)
	self.rotor2.phys = self.rotor2:GetPhysicsObject()
	self.rotor2.phys:EnableGravity(false)
	self.rotor2.phys:SetMass(5)
	--self.rotor2.phys:EnableDrag(false)
	self.rotor2:SetNoDraw(true)
	self.rotor2.health = 100
	self.rotor2.wac_ignore = true
	if self.RotorModel2 then
		local e = ents.Create("wac_hitdetector")
		e:SetModel(self.RotorModel2)
		e:SetPos(self:LocalToWorld(self.rotorPos2))
		e:SetAngles(self:GetAngles())
		e:Spawn()
		e:SetOwner(self.Owner)
		e:SetParent(self.rotor2)
		e.wac_ignore = true
		local obb=e:OBBMaxs()
		self.RotorWidth=(obb.x>obb.y and obb.x or obb.y)
		self.RotorHeight=obb.z
		self.rotorModel2=e
		self:AddOnRemove(e)
	end
	constraint.Axis(self.Entity, self.rotor2, 0, 0, self.rotorPos2, Vector(0,0,1), 0,0,0.01,1)
	self:AddOnRemove(self.rotor2)
end