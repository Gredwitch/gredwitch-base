if not wac then return end

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
		    bomb:SetAngles(self.aircraft:GetAngles())
		    bomb:Spawn()
		    bomb:Activate()
			bomb.phys=bomb:GetPhysicsObject()
		    bomb.weld=constraint.Weld(bomb,self.aircraft,0,0,0,true)
			if GetConVar("gred_sv_bombs_mass"):GetInt() == 0 then
				bomb.phys:SetMass(1)
			end
			bomb:SetCollisionGroup(20)
		    self.bombs[#self.bombs+1]=bomb
			self.allbombs[#self.allbombs+1]=bomb
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
	if !self:takeAmmo(1) then return end
	if not IsValid(bomb) then return end
	if bomb.weld then
		bomb.weld:Remove()
		bomb.weld=nil
	end
	bomb.ShouldExplodeOnImpact = true
	self.aircraft:EmitSound(self.Sounds.fire)
	bomb.GBOWNER = self:getAttacker()
	bomb.Owner = self:getAttacker()
	
	bomb.phys:AddVelocity(self.aircraft.phys:GetVelocity())
	bomb.phys:SetMass(bomb.Mass)
	timer.Simple(1, function()
		if IsValid(bomb) and IsValid(bomb.phys) then
			bomb.dropping=true
			bomb.Armed = true
			if self.Rocket == 1 then bomb:Launch() end
			bomb:SetCollisionGroup(0)
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
