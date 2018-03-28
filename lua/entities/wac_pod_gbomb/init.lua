AddCSLuaFile("shared.lua")
include("shared.lua")
if SERVER then
	function ENT:Initialize()
		self:base("wac_pod_base").Initialize(self)
		self.allbombs={}
		self:ReloadBombs()
	end
	
	function ENT:ReloadBombs()
		if self.aircraft.engineHealth <= 0 then return end
		self:SetAmmo(#self.Pods)
		self.bombs={}
		for k,v in pairs(self.Pods) do
			local bomb = ents.Create( self.Kind )
			bomb:SetPos(self.aircraft:LocalToWorld(v))
			bomb:SetCollisionGroup(20)
		    bomb:SetAngles(self.aircraft:GetAngles())
		    bomb:Spawn()
		    bomb:Activate()
			bomb.phys=bomb:GetPhysicsObject()
		    bomb.phys:SetMass(self.mass)
		    bomb.weld=constraint.Weld(bomb,self.aircraft,0,0,0,true)
		    self.bombs[#self.bombs+1]=bomb
			self.allbombs[#self.allbombs+1]=bomb
		end
		for a,b in pairs(self.bombs) do
			for c,d in pairs(self.bombs) do
				if not b==d then
					constraint.NoCollide(b,d,0,0)
				end
			end
		end
	end
end

function ENT:OnRemove()
	self:base("wac_pod_base").Initialize(self)
	if SERVER then
		if self.bombs then
			for k,v in pairs(self.allbombs) do
				if IsValid(v) then
					v:Remove()
					v=nil
				end
			end
		end
	end
end


if SERVER then
	function ENT:Think()
		self:base("wac_pod_base").Think(self)
		if self.aircraft.engineHealth <= 0 then
			self:OnRemove()
		end
		if self.bombs then
			local phm=FrameTime()*66
		end
		if self:GetAmmo()<=0 and self.Admin == 0 and not self.reloadtime and ((not self.mode and IsValid(self.aircraft) and self.aircraft:GetVelocity():Length()<=50) or self.mode) then
			self.reloadtime=CurTime()+self.reload
		elseif self.reloadtime and CurTime()>self.reloadtime and self.Admin == 0 then
			self.reloadtime=nil
			self:ReloadBombs()
		elseif self:GetAmmo()<=0 and self.Admin == 1 then
			self.reloadtime=nil
			self:ReloadBombs()
		end
	end
end


function ENT:dropBomb(bomb)
	local BaseClass = baseclass.Get( "base_bomb" )
	if !self:takeAmmo(1) then return end
	if not IsValid(bomb) then return end
	if bomb.weld then
		bomb.weld:Remove()
		bomb.weld=nil
		bomb.phys:AddAngleVelocity(Vector(5000,1000,5000))
	end
	bomb.ShouldExplodeOnImpact = true
	bomb.phys:AddVelocity(self.aircraft.phys:GetVelocity())
	self.aircraft:EmitSound(self.Sounds.fire)
	timer.Simple(1,function()
		if IsValid(bomb) then
			bomb.dropping=true
			bomb.Armed = true
		end
	end)
end


function ENT:fire()
	if self.Sequential then
		self.currentPod = self.currentPod or 1
		self:dropBomb(self.bombs[self.currentPod])
		self.currentPod = (self.currentPod == #self.bombs and 1 or self.currentPod + 1)
	else
		for k,v in pairs(self.bombs) do
			self:dropBomb(v)
		end
	end
end
