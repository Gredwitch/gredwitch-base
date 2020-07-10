gred.GunnersInit = function(self)
	local ATT
	local seat
	for k,v in pairs(self.Gunners) do
	
		v.tracer = 0
		v.UpdateTracers = function(self)
			v.tracer = v.tracer + 1
			if v.tracer >= self.TracerConvar:GetInt() then
				v.tracer = 0
				return "red"
			else
				return false
			end
		end
		for a,b in pairs(v.att) do
			v.att[a] = self:LookupAttachment(b)
		end
		seat = self:AddPassengerSeat(v.pos,v.ang)
		seat.Shoot = v.snd_loop and CreateSound(seat,v.snd_loop) or nil
		seat.Stop = v.snd_stop and CreateSound(seat,v.snd_stop) or nil
		self["SetGunnerSeat"..k](self,seat)
	end
end

gred.GunnersTick = function(self,Driver,DriverSeat,DriverFireGunners,ct,IsShooting)
	ct = ct and ct or CurTime()
	Driver = Driver and Driver or self:GetDriver()
	DriverSeat = DriverSeat and DriverSeat or self:GetDriverSeat()
	DriverFireGunners = DriverFireGunners != nil and DriverFireGunners or (IsValid(Driver) and Driver:lfsGetInput("FREELOOK") and Driver:KeyDown(IN_ATTACK))
	local ang
	local pod
	local gunner
	local gunnerValid
	local shootAng
	local tracer
	local gunnerpod
	local IsDriver
	local selfAngle = self:GetAngles()
	selfAngle:Normalize()
	for k,v in pairs(self.Gunners) do
		pod = self["GetGunnerSeat"..k](self)
		gunnerpod = pod
		if IsValid(pod) then
			gunner = pod:GetDriver()
			gunnerValid = IsValid(gunner)
			if gunnerValid or (!gunnerValid and DriverFireGunners) then
				gunner = gunnerValid and gunner or Driver
				IsDriver = gunner == Driver
				pod = IsDriver and DriverSeat or pod
				
				IsShooting = IsShooting or gunner:KeyDown(IN_ATTACK)
				
				for C,att in pairs(v.att) do
					att = self:GetAttachment(att)
					if C == 1 then
						ang = pod:WorldToLocalAngles(gunner:EyeAngles())
						ang:Normalize() 
						ang = v.AngleOperate(self:WorldToLocalAngles(ang),IsDriver,selfAngle)
						ang:Normalize()
						self:SetPoseParameter(v.poseparams[1],ang.p)
						self:SetPoseParameter(v.poseparams[2],ang.y)
						if (ang.y > v.maxang.y or ang.p > v.maxang.p or ang.y < v.minang.y or ang.p < v.minang.p) and DriverFireGunners then break end
						if IsShooting and v.nextshot <= ct then
							tracer = v.UpdateTracers(self)
						end
					end
					if IsShooting then
						v.IsShooting = true
						if gunnerpod.Stop then
							gunnerpod.Stop:Stop()
						else
							gunnerpod.Shoot:Stop()
						end
						gunnerpod.Shoot:Play()
						if v.nextshot <= ct then
							v.spread = v.spread and v.spread or 0.3
							shootAng = att.Ang + Angle(math.Rand(-v.spread,v.spread), math.Rand(-v.spread,v.spread), math.Rand(-v.spread,v.spread))
							
							gred.CreateBullet(gunner,att.Pos,shootAng,v.cal,self.FILTER,nil,false,tracer)
							
							local effectdata = EffectData()
							effectdata:SetFlags(self.MUZZLEEFFECT)
							effectdata:SetOrigin(att.Pos)
							effectdata:SetAngles(shootAng)
							effectdata:SetSurfaceProp(0)
							util.Effect("gred_particle_simple",effectdata)
							if C == #v.att or v.Sequential then
								v.nextshot = ct + v.delay
							end
						end
					else
						if v.IsShooting then
							v.IsShooting = false
							if gunnerpod.Stop then
								gunnerpod.Stop:Play()
								gunnerpod.Shoot:Stop()
							end
						end
					end
				end
			else
				if v.IsShooting then
					v.IsShooting = false
					if gunnerpod.Stop then
						gunnerpod.Stop:Play()
						gunnerpod.Shoot:Stop()
					end
				end
			end
		end
		
		pod = nil
		gunner = nil
	end
end

gred.HandleActiveGunners = function(self)
	local gpod
	local gunner
	for k,v in pairs(self.Gunners) do
		gpod = self["GetGunnerSeat"..k](self)
		if IsValid(gpod) then
			local Gunner = gpod:GetDriver()
			
			gunner = self["GetGunner"..k](self)
			if Gunner ~= gunner then
				self:SetGunner( Gunner )
				
				if IsValid( Gunner ) then
					Gunner:CrosshairEnable() 
				end
			end
		end
	end
end

gred.InitAircraftParts = function(self,ForceToDestroy)
	self.Attachements = {}
	self.Parts = {}
	local tostring = tostring
	local pairs = pairs
	local GetModel = GetModel
	
	for k,v in pairs (self:GetAttachments()) do
		self.Attachements[v.name] = self:LookupAttachment(tostring(v.name))
	end
	for k,v in pairs(self.Attachements) do
		if k != "blister" then
			local ent = ents.Create("gred_prop_part")
			ent.ForceToDestroy = ForceToDestroy or 1000
			ent:SetModel(self:GetPartModelPath(k))
			ent:SetPos(self:GetAttachment(self.Attachements[k]).Pos)
			ent:SetAngles(self:GetAngles())
			ent:SetParent(self,self.Attachements[k])
			if k == "tail" then
				ent.MaxHealth = self.TailHealth and self.TailHealth or 1100
			elseif k == "wing_r" or k == "wing_l" then
				ent.MaxHealth = self.WingHealth and self.WingHealth or 600
				ent.Mass = 500
			elseif IsSmall(k) then
				ent.MaxHealth = self.SmallPartHealth and self.SmallPartHealth or 100
			else
				ent.MaxHealth = self.PartHealth and self.PartHealth or 350
			end
			ent.CurHealth = ent.MaxHealth
			ent:Spawn()
			ent:Activate()
			self.Parts[k] = ent
		end
	end
	self.GibModels = self.GibModels or {}
	self.FILTER = {self}
	for k,v in pairs(self.Parts) do
		table.insert(self.FILTER,v)
		v.Parts = self.Parts
		v.Plane = self
		self.GibModels[k] = v:GetModel()
		v.PartParent = self.PartParents[k] and self.Parts[self.PartParents[k]] or self
	end
	self.LOADED = 1
end

gred.PartCalcFlight = function(self,Pitch,Yaw,Roll,Stability,AddRoll,AddYaw)
	AddRoll = AddRoll or 0.3
	AddYaw = AddYaw or 0.2
	local addRoll = 0
	local addYaw = 0
	local vel = self:GetVelocity():Length()
	if not self.Parts.elevator then
		Pitch = 0
	end
	if not self.Parts.rudder then
		Yaw = 0
	end
	if not self.Parts.wing_l then
		addRoll = AddRoll*vel
		addYaw = vel*AddYaw
	end
	if not self.Parts.wing_r then
		addRoll = !self.Parts.wing_l and addRoll or -AddRoll*vel
		addYaw = !self.Parts.wing_l and addYaw*2 or -vel*AddYaw
		Pitch = !self.Parts.wing_l and addYaw or Pitch
	end
	if not self.Parts.aileron_l then
		if Roll < 0 then Roll = Roll*0.5 end
	end
	if not self.Parts.aileron_r then
		if Roll > 0 then Roll = Roll*0.5 end
	end
	if not self.Parts.tail then
		Pitch = AddYaw*vel*10
		addYaw = addYaw + Pitch*0.3
		addRoll = addRoll + addYaw
	end
	Roll = Roll + addRoll
	Yaw = Yaw + addYaw
	return Pitch,Yaw,Roll,Stability,Stability,Stability
end

gred.PartThink = function(self,skin)
	if self.LOADED == 1 then
		for k,v in pairs(self.Parts) do
			self:DeleteOnRemove(v)
			NoCollide(v,self,0,0)
			NoCollide(v,self.wheel_R,0,0)
			NoCollide(v,self.wheel_L,0,0)
			NoCollide(v,self.wheel_C,0,0)
			NoCollide(v,self.wheel_C_master,0,0)
			if k == "tail" or k == "wing_l" or k == "wing_r" then
				v:SetParent(nil)
				v:SetPos(self:GetAttachment(self.Attachements[k]).Pos)
				v.Weld = constraint.Weld(v,self,0,0,0,true,false)
			end
			for a,p in pairs(self.Parts) do
				NoCollide(v,p,0,0)
			end
			v.LOADED = true
			v.PartName = k
		end
		net.Start("gred_lfs_setparts")
			net.WriteEntity(self)
			net.WriteTable(self.Parts)
		net.Broadcast()
		self.LOADED = true
	end
	skin = skin and skin or self:GetSkin()
	for k,v in pairs(self.Parts) do
		if not IsValid(v) then
			if k == "wheel_c" or k == "wheel_b" then
				self.wheel_C:Remove()
				self.wheel_C_master:Remove()
			end
			if k == "wheel_r" then
				self.wheel_R:Remove()
			end
			if k == "wheel_l" then
				self.wheel_L:Remove()
			end
			net.Start("gred_lfs_remparts")
				net.WriteEntity(self)
				net.WriteString(k)
			net.Broadcast()
			self.Parts[k] = nil
			self.GibModels[k] = nil
			k = nil
		return end
		if !v.PartParent or !IsValid(v.PartParent) or v.PartParent.Destroyed then
			v.CurHealth = 0
			v.DONOTEMIT = true
		end
		if v.CurHealth <= v.MaxHealth/2 then
			if not table.HasValue(self.DamageSkin,skin) then
				v:SetSkin(skin+1)
			end
			if v.CurHealth <=0 then
				if k == "wheel_c" or k == "wheel_b" then
					self.wheel_C:Remove()
					self.wheel_C_master:Remove()
				end
				if k == "wheel_r" then
					self.wheel_R:Remove()
				end
				if k == "wheel_l" then
					self.wheel_L:Remove()
				end
				constraint.RemoveAll(v)
				if not v.DONOTEMIT then
					v:EmitSound("LFS_PART_DESTROYED_0"..math.random(1,3))
				end
				v:SetParent(nil)
				v:SetVelocity(self:GetVelocity())
				v.Destroyed = true
				self.Parts[k] = nil
				self.GibModels[k] = nil
			end
			net.Start("gred_lfs_remparts")
				net.WriteEntity(self)
				net.WriteString(k)
			net.Broadcast()
		else
			if table.HasValue(self.DamageSkin,skin) then
				v:SetSkin(skin-1)
			else
				v:SetSkin(skin)
			end
		end
	end
end

gred.HandleLandingGear = function(self,animName)
	if not self.CurSeq then
		self.CurSeq = self:GetSequenceName(self:GetSequence())
	end
	if self.CurSeq != animName then
		self:ResetSequence(animName)
		self.CurSeq = self:GetSequenceName(self:GetSequence())
	end
	self:SetCycle(self:GetLGear())
end
