
include("shared.lua")
AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

ENT.EngineForce = 50
ENT.Weight = 5601
ENT.MaxEnterDistance = 100

function ENT:SpawnFunction(p, tr)
	if (!tr.Hit) then return end
	local e = ents.Create(ClassName)
	e:SetPos(tr.HitPos+Vector(0,0,10))
	e.Owner = p
	e:Spawn()
	e:Activate()
	e:ResetSequence("geardown")

	return e
end


function ENT:Initialize()
	self:base("wac_hc_base").Initialize(self)
	self.Value=0
	self.TargetValue=0
end




function ENT:PhysicsUpdate(ph)
	self:base("wac_hc_base").PhysicsUpdate(self,ph)
	
	if self:GetNWInt("seat_2_actwep") == 1 or self:GetNWInt("seat_1_actwep") == 1 then
		self.TargetValue=1
	else
		self.TargetValue=0
	end
	
	if not (self.Value==self.TargetValue) then
		self.Value = Lerp( 0.015, self.Value, self.TargetValue)
		self:SetPoseParameter("weapons",self.Value)
	end
	
	
	local geardown,t1=self:LookupSequence("geardown")
	local gearup,t2=self:LookupSequence("gearup")	
	local trace=util.QuickTrace(self:LocalToWorld(Vector(0,0,62)), self:LocalToWorld(Vector(0,0,50)), {self, self.wheels[1], self.wheels[2], self.wheels[3], self.rotor})
	local phys=self:GetPhysicsObject()
	if IsValid(phys) and not self.disabled then
		if self.rotorRpm>0.5 and phys:GetVelocity():Length() > 300 and trace.HitPos:Distance( self:LocalToWorld(Vector(0,0,10)) ) > 2150  and self:GetSequence() != gearup then
			self:ResetSequence(gearup) 
			self:SetPlaybackRate(1.0)
			self:SetBodygroup(1,1)
			for i=1,3 do 
				self.wheels[i]:SetRenderMode(RENDERMODE_TRANSALPHA)
				self.wheels[i]:SetColor(Color(255,255,255,0))
				self.wheels[i]:SetSolid(SOLID_NONE)
			end
		elseif trace.HitPos:Distance( self:LocalToWorld(Vector(0,0,10)) ) < 1900  and self:GetSequence() == gearup then
			self:ResetSequence(geardown)
			self:SetPlaybackRate(1.0)
			geardown,time1=self:LookupSequence("gearup")

			timer.Simple(time1,function()
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
end