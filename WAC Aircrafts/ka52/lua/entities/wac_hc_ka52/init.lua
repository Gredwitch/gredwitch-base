include("shared.lua")
AddCSLuaFile("shared.lua")

function ENT:SpawnFunction(ply, tr)
	if (!tr.Hit) then return end
	local ent=ents.Create(ClassName)
	ent:SetPos(tr.HitPos+tr.HitNormal*10)
	ent:Spawn()
	ent:Activate()
	ent:SetSkin(math.random(0,4))
	ent:SetBodygroup(7,(math.random(0,10)))
	ent:SetBodygroup(8,(math.random(0,10)))
	ent:SetBodygroup(9,(math.random(0,1)))
	ent.Owner=ply
	return ent
end

function ENT:addRotors()
	self:base("wac_hc_base").addRotors(self)
	self.topRotor2 = self:addEntity("prop_physics")
	self.topRotor2:SetModel("models/props_junk/sawblade001a.mdl")
	self.topRotor2:SetPos(self:LocalToWorld(self.TopRotor2.pos))
	self.topRotor2:SetAngles(self:LocalToWorldAngles(self.TopRotor2.angles))
	self.topRotor2:SetOwner(self.Owner)
	self.topRotor2:SetNotSolid(true)
	self.topRotor2:Spawn()
	self.topRotor2.Phys = self.topRotor2:GetPhysicsObject()
	self.topRotor2.Phys:EnableGravity(false)
	self.topRotor2.Phys:SetMass(5)
	self.topRotor2.Phys:EnableDrag(false)
	self.topRotor2:SetNoDraw(true)
	self.topRotor2.fHealth = 100
	self.topRotor2.wac_ignore = true
	if self.TopRotor2.model then
		local e = self:addEntity("wac_hitdetector")
		self:SetNWEntity("wac_air_rotor_main", e)
		e:SetModel(self.TopRotor2.model)
		e:SetPos(self.topRotor2:GetPos())
		e:SetAngles(self.topRotor2:GetAngles())
		e:Spawn()
		e:SetNotSolid(true)
		e:SetParent(self.topRotor2)
		e.wac_ignore = true
		local obb = e:OBBMaxs()
		self.RotorWidth2 = (obb.x>obb.y and obb.x or obb.y)
		self.RotorHeight2 = obb.z
		self.topRotor2.vis = e
	end
	constraint.Axis(self.Entity, self.topRotor2, 0, 0, self.TopRotor2.pos, Vector(0,0,1), 0,0,0,1)
	self:AddOnRemove(self.topRotor2)
end

function ENT:PhysicsUpdate(ph)
	self:base("wac_hc_base").PhysicsUpdate(self,ph)		
	
	if self.active then
		self:SetBodygroup(2,1)
	else
		self:SetBodygroup(2,0)
	end
	local vel = ph:GetVelocity()	
	local pos = self:GetPos()
	local ri = self:GetRight()
	local up = self:GetUp()
	local fwd = self:GetForward()
	local ang = self:GetAngles()
	local dvel = vel:Length()
	local lvel = self:WorldToLocal(pos+vel)
	local pilot = self.passengers[1]
	local hover = self:calcHover(ph,pos,vel,ang)
	
	local rotateX = (self.controls.roll*1.5+hover.r)*self.rotorRpm
	local rotateY = (self.controls.pitch+hover.p)*self.rotorRpm
	local rotateZ = self.controls.yaw*1.5*self.rotorRpm
	local trace=util.QuickTrace(self:LocalToWorld(Vector(0,0,62)), self:LocalToWorld(Vector(0,0,50)), {self, self.wheels[1], self.wheels[2], self.wheels[3], self.rotor})
	local phys=self:GetPhysicsObject()
	if IsValid(phys) and not self.disabled then
		if self.rotorRpm>0.5 and phys:GetVelocity():Length() > 300 and trace.HitPos:Distance( self:LocalToWorld(Vector(0,0,10)) ) > 2150 then
			self:SetBodygroup(1,1)
			for i=1,3 do 
				self.wheels[i]:SetRenderMode(RENDERMODE_TRANSALPHA)
				self.wheels[i]:SetColor(Color(255,255,255,0))
				self.wheels[i]:SetSolid(SOLID_NONE)
			end
		elseif trace.HitPos:Distance( self:LocalToWorld(Vector(0,0,10)) ) < 1900 then

			timer.Simple(1,function()
				if self.wheels then
					for i=1,3 do 
						self.wheels[i]:SetRenderMode(RENDERMODE_NORMAL)
						self.wheels[i]:SetColor(Color(255,255,255,255))
						self.wheels[i]:SetSolid(SOLID_VPHYSICS)
					end
					self:SetBodygroup(1,0)
				end
			end)
		end
	end
	--local phm = (wac.aircraft.cvars.doubleTick:GetBool() and 2 or 1)
	local phm = FrameTime()*66
	if self.UsePhysRotor then
		if self.topRotor2 and self.topRotor2.Phys and self.topRotor2.Phys:IsValid() then
			if self.RotorBlurModel then
				self.topRotor2.vis:SetColor(Color(255,255,255,math.Clamp(1.3-self.rotorRpm,0.1,1)*255))
			end
				-- top rotor physics
			local rotor = {}
			rotor.phys = self.topRotor2.Phys
			rotor.angVel = rotor.phys:GetAngleVelocity()
			rotor.upvel = self.topRotor2:WorldToLocal(self.topRotor2:GetVelocity()+self.topRotor2:GetPos()).z
			rotor.brake =
				math.Clamp(math.abs(rotor.angVel.z) - 2950, 0, 100)/10 -- RPM cap
				+ math.pow(math.Clamp(1500 - math.abs(rotor.angVel.z), 0, 1500)/900, 3)
				+ math.abs(rotor.angVel.z/10000)
				- (rotor.upvel - self.rotorRpm)*self.controls.throttle/1000
				rotor.targetAngVel =
				Vector(0, 0, math.pow(self.engineRpm,2)*self.TopRotor2.dir*10)
				- rotor.angVel*rotor.brake/200
				rotor.phys:AddAngleVelocity(rotor.targetAngVel)
		end
	end
	self.LastPhys = CurTime()

	if self.topRotor and IsValid(self.topRotor) and IsValid(self.topRotor.vis) then
		if self.rotorRpm > 0.6 and self.rotorRpm < 0.79 then
			self.topRotor.vis:SetBodygroup(1,1)
		elseif self.rotorRpm > 0.8 then
			self.topRotor.vis:SetBodygroup(1,2)
		elseif self.rotorRpm < 0.4 then
			self.topRotor.vis:SetBodygroup(1,0)
		end
	end
	
	if self.topRotor2 and IsValid(self.topRotor2) and IsValid(self.topRotor2.vis) then
		if self.rotorRpm > 0.6 and self.rotorRpm < 0.79 then
			self.topRotor2.vis:SetBodygroup(1,1)
		elseif self.rotorRpm > 0.8 then
			self.topRotor2.vis:SetBodygroup(1,2)
		elseif self.rotorRpm < 0.4 then
			self.topRotor2.vis:SetBodygroup(1,0)
		end
	end
end

function ENT:KillTopRotor()
	if !self.TopRotor2 then return end
	local e = self:addEntity("prop_physics")
	e:SetPos(self.topRotor2:GetPos())
	e:SetAngles(self.topRotor2:GetAngles())
	e:SetModel(self.TopRotor2.model)
	e:SetSkin(self.topRotor.vis:GetSkin())
	e:Spawn()
	local ph = e:GetPhysicsObject()
	e.wac_ignore=true
	if ph:IsValid() then
		ph:SetMass(1000)
		ph:EnableDrag(false)
		ph:AddAngleVelocity(self.topRotor2.Phys:GetAngleVelocity())
		ph:SetVelocity(self.topRotor2.Phys:GetAngleVelocity():Length()*self.topRotor2:GetUp()*0.5 + self.topRotor2:GetVelocity())
	end
	self.topRotor2:Remove()
	self.topRotor2 = nil
	e:SetNotSolid(true)
	timer.Simple(15, function()
		if !e or !e:IsValid() then return end
		e:Remove()
	end)
	
	self:base("wac_hc_base").KillTopRotor(self)
end