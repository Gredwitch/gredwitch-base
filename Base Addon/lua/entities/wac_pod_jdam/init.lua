if not wac then return end

AddCSLuaFile("shared.lua")
include("shared.lua")

if SERVER then
	function ENT:Initialize()
		self:base("wac_pod_base").Initialize(self)
		self.baseThink = self:base("wac_pod_base").Think
		self.allbombs={}
		self:ReloadBombs()
	end
	
	function ENT:ReloadBombs()
		if self.aircraft.engineHealth <= 0 then return end
		if (GetConVar("gred_sv_spawnable_bombs"):GetInt() == 0 and not self.IsOnPlane) then
			self:Remove()
		end
		self:SetAmmo(#self.Pods)
		self.bombs={}
		for k,v in pairs(self.Pods) do
			local bomb = ents.Create( self.Kind )
			bomb.IsOnPlane = true
			bomb:SetPos(self.aircraft:LocalToWorld(v))
		    bomb:SetAngles(self.aircraft:GetAngles())
		    bomb:Spawn()
		    bomb:Activate()
		    bomb.weld=constraint.Weld(bomb,self.aircraft,0,0,0,true)
			bomb.phys=bomb:GetPhysicsObject()
			if !IsValid(bomb.phys) then return end
			bomb.phys:SetMass(1)
			bomb:SetCollisionGroup(20)
		    self.bombs[#self.bombs+1]=bomb
			self.allbombs[#self.allbombs+1]=bomb
		end
	end
	
	function ENT:Think()
		self:base("wac_pod_base").Think(self)
		if self.aircraft.engineHealth <= 0 then
			self:OnRemove()
		end
		if self.bombs then
			local phm=FrameTime()*66
		end
		local ang = self.aircraft:getCameraAngles()
		if ang then
			local pos = self.aircraft:LocalToWorld(self.aircraft.Camera.pos)
			local dir = ang:Forward()
			local tr = util.QuickTrace(pos+dir*20, dir*35400, self)
			if tr.Hit and !tr.HitSky then
				self:SetTarget(tr.Entity)
				self:SetTargetOffset(tr.Entity:WorldToLocal(tr.HitPos))
				canFire = true
			else
				canFire = false
			end
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

function ENT:OnRemove()
	self:base("wac_pod_base").Initialize(self)
	if SERVER then
		if self.bombs then
			for k,v in pairs(self.allbombs) do
				if IsValid(v) then
					if not v.dropping then
						v:Remove()
						v=nil
					end
				end
			end
		end
	end
end

function ENT:dropBomb(bomb)
	if !self:takeAmmo(1) then return end
	if not canFire then return end
	if not IsValid(bomb) then return end
	if bomb.weld then
		bomb.weld:Remove()
		bomb.weld=nil
	end
	self.aircraft:EmitSound(self.Sounds.fire)
	
	local vel = self.aircraft.phys:GetVelocity()
	bomb.phys:AddVelocity(vel)
	timer.Simple(0.01,function() if IsValid(bomb.phys) then bomb.phys:SetMass(bomb.Mass)  end end)
	local ply = self:getAttacker()
	bomb.GBOWNER = ply
	bomb.dropping=true
	bomb.Owner = ply
	bomb.JDAM = true
	bomb.target = self:GetTarget()
	bomb.targetOffset = self:GetTargetOffset()
	-- bomb:EmitSound("bombSND")
	
	timer.Simple(1, function()
		if IsValid(bomb) and IsValid(bomb.phys) then
			bomb.Armed = true
			bomb.ShouldExplodeOnImpact = true
			if self.Rocket == 1 then bomb:Launch() end
			bomb:SetCollisionGroup(0)
		end
	end)
end


function ENT:fire()
	if not canFire then return end
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
