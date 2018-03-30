
include("shared.lua")
AddCSLuaFile("shared.lua")

function ENT:SpawnFunction(ply, tr)
	if (!tr.Hit) then return end
	local ent=ents.Create(ClassName)
	ent:SetPos(tr.HitPos+tr.HitNormal*60)
	ent:SetAngles(Angle(-10,0,0))
	ent:Spawn()
	ent:Activate()
	ent:SetSkin(math.random(0,1))
	ent.Owner=ply
	return ent
end

ENT.Aerodynamics = {
	Rotation = {
		Front = Vector(0, -3.5, 0),
		Right = Vector(0, 0, 60), -- Rotate towards flying direction
		Top = Vector(0, -40, 0)
	},
	Lift = {
		Front = Vector(0, 0, 50.5), -- Go up when flying forward
		Right = Vector(0, 0, 0),
		Top = Vector(0, 0, -0.5)
	},
	Rail = Vector(3, 5, 20),
	Drag = {
		Directional = Vector(0.01, 0.01, 0.01),
		Angular = Vector(0.01, 0.01, 0.01)
	}
}

function ENT:PhysicsUpdate(ph)
		self:base("wac_pl_base").PhysicsUpdate(self,ph)
	
	if self.rotorRpm > 0.8 and self.rotorRpm < 0.89 and IsValid(self.rotorModel) then
		self.rotorModel:SetBodygroup(1,1)
	elseif self.rotorRpm > 0.9 and IsValid(self.rotorModel) then
		self.rotorModel:SetBodygroup(1,2)
	elseif self.rotorRpm < 0.8 and IsValid(self.rotorModel) then
		self.rotorModel:SetBodygroup(1,0)
	end
	
	if self.rotorRpm > 0.5 and self.rotorRpm < 0.89 and IsValid(self.rotorModel) then
		self.rotorModel:SetBodygroup(1,2)
	elseif self.rotorRpm > 0.9 and IsValid(self.rotorModel) then
		self.rotorModel:SetBodygroup(1,3)
	elseif self.rotorRpm < 0.8 and IsValid(self.rotorModel) then
		self.rotorModel:SetBodygroup(1,1)
	end
	
	if self.rotorRpm > 0.5 and self.rotorRpm < 0.89 and IsValid(self.OtherRotorModel) then
		self.OtherRotorModel:SetBodygroup(1,2)
	elseif self.rotorRpm > 0.9 and IsValid(self.OtherRotorModel) then
		self.OtherRotorModel:SetBodygroup(1,3)
	elseif self.rotorRpm < 0.8 and IsValid(self.OtherRotorModel) then
		self.OtherRotorModel:SetBodygroup(1,1)
	end
	
	local vel = ph:GetVelocity()	
	local pos = self:GetPos()
	local ri = self:GetRight()
	local up = self:GetUp()
	local fwd = self:GetForward()
	local ang = self:GetAngles()
	local dvel = vel:Length()
	local lvel = self:WorldToLocal(pos+vel)
	local throttle = self.controls.throttle/2 + 0.5
	local phm = FrameTime()*66
	
	if !self.disabled then
		for k,v in pairs(self.OtherRotors) do
			if v and v.phys and v.phys:IsValid() then
				if self.active and v:WaterLevel() <= 0 then
					v.phys:AddAngleVelocity(Vector(0,0,self.engineRpm*30 + throttle*self.engineRpm*20)*self.rotorDir*phm)
				end
			end
		end
	end
	
	for k,v in pairs(self.OtherRotors) do
		if v then
			local brake = (throttle+1)*self.rotorRpm/900+v.phys:GetAngleVelocity().z/100
			v.phys:AddAngleVelocity(Vector(0,0,-brake + lvel.x*lvel.x/500000)*self.rotorDir*phm)
		end
	end
end

function ENT:addRotors()
	self:base("wac_pl_base").addRotors(self)
	self.rotorModel.TouchFunc=nil
	
	// new rotors!
	self.OtherRotors={}
	self.OtherRotorsModel={}
	for i=1,2 do
		self.OtherRotors[i] = ents.Create("prop_physics")
		self.OtherRotors[i]:SetModel("models/props_junk/sawblade001a.mdl")
		self.OtherRotors[i]:SetPos(self:LocalToWorld(self.OtherRotorPos[i]))
		self.OtherRotors[i]:SetAngles(self:GetAngles() + Angle(90, 0, 0))
		self.OtherRotors[i]:SetOwner(self.Owner)
		self.OtherRotors[i]:Spawn()
		self.OtherRotors[i]:SetNotSolid(true)
		self.OtherRotors[i].phys = self.OtherRotors[i]:GetPhysicsObject()
		self.OtherRotors[i].phys:EnableGravity(false)
		self.OtherRotors[i].phys:SetMass(5)
		--self.OtherRotors[i].Phys:EnableDrag(false)
		self.OtherRotors[i]:SetNoDraw(true)
		self.OtherRotors[i].fHealth = 100
		self.OtherRotors[i].wac_ignore = true
		if self.RotorModel then
			local e = ents.Create("wac_hitdetector")
			e:SetModel(self.RotorModel)
			e:SetPos(self:LocalToWorld(self.OtherRotorPos[i]))
			e:SetAngles(self:GetAngles())

			e:Spawn()
			e:SetOwner(self.Owner)
			e:SetParent(self.OtherRotors[i])
			e.wac_ignore = true
			local obb=e:OBBMaxs()
			self.RotorWidth=(obb.x>obb.y and obb.x or obb.y)
			self.RotorHeight=obb.z
			self.OtherRotorsModel[i]=e
			self:AddOnRemove(e)
		end
		constraint.Axis(self.Entity, self.OtherRotors[i], 0, 0, self.OtherRotorPos[i], Vector(0,0,1), 0,0,0.01,1)
		self:AddOnRemove(self.OtherRotors[i])
	end
end
