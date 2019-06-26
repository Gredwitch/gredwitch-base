if not wac then return end

AddCSLuaFile("shared.lua")
AddCSLuaFile("cl_init.lua")
include("shared.lua")

local tracers = 0
local num = 0
function ENT:Initialize()
	self:base("wac_pod_base").Initialize(self)
	self.sounds.spin:ChangePitch(0,0.1)
	self.sounds.spin:ChangeVolume(0,0.1)
	self.sounds.spin:Play()
	self:SetSpinSpeed(0)
	if !self.sounds.stop1p then
		self.sounds.stop1p = CreateSound(self,"extras/null.wav")
	end
	self.sounds.stop1p:SetSoundLevel(self.sounds.shoot1p:GetSoundLevel())
	if !self.sounds.stop3p then
		self.sounds.stop3p = CreateSound(self,"extras/null1.wav")
	end
	self.sounds.stop3p:SetSoundLevel(110)
	if tracer == nil then tracer = 0 end
	self.TracerConvar = GetConVar("gred_sv_tracers"):GetInt()
	ammovar = GetConVar("gred_sv_default_wac_munitions"):GetInt()
	if ammovar >= 1 then
		num = 1
	else
		if self.BulletType == "wac_base_7mm" then
			num = 0.5
		elseif self.BulletType == "wac_base_12mm" then
			num = 1
		elseif self.BulletType == "wac_base_20mm" then
			num = 1.4
		elseif self.BulletType == "wac_base_30mm" then
			num = 2
		end
	end
	self.TracerColor = string.lower(self.TracerColor)
	if SERVER then
		self.FILTER = {self,self.aircraft}
		for k,v in pairs(self.aircraft.entities) do
			table.insert(self.FILTER,v)
		end
	end
	
	self.basePodThink = self:base("wac_pod_base").Think
end

function ENT:fire()
	if !self:takeAmmo(self.TkAmmo) then return end
	local camAng = self.aircraft:getCameraAngles()
	local dir = camAng:Forward()
	local pos = self.aircraft:LocalToWorld(self.ShootPos) + dir*self.ShootOffset.x
	if ammovar >= 1 then
		local tr = util.QuickTrace(self:LocalToWorld(self.aircraft.Camera.pos) + dir*20, dir*999999999, {self, self.aircraft})
		local b = ents.Create("wac_hc_hebullet")
		local ang = (tr.HitPos - pos):Angle() + Angle(math.Rand(-num,num), math.Rand(-num,num), math.Rand(-num,num))*self.Spray
		b:SetPos(pos)
		b:SetAngles(ang)
		b.col = Color(255,200,100)
		b.Speed = 400
		b.Size = 0
		b.Width = 0
		b:Spawn()
		b.Owner = self:getAttacker()
		b.Explode = function(self,tr)
			if self.Exploded then return end
			self.Exploded = true
			if not tr.HitSky then
				local bt = {}
				bt.Src 		= self:GetPos()
				bt.Dir 		= tr.Normal
				bt.Force	= 30
				bt.Damage	= 60
				bt.Tracer	= 0
				b.Owner:FireBullets(bt)
				local explode = ents.Create("env_physexplosion")
				explode:SetPos(tr.HitPos)
				explode:Spawn()
				explode:SetKeyValue("magnitude", 60)
				explode:SetKeyValue("radius", 10)
				explode:SetKeyValue("spawnflags", "19")
				explode:Fire("Explode", 0, 0)
				timer.Simple(5,function() if IsValid(self) then explode:Remove() end end)
				util.BlastDamage(self, self.Owner, tr.HitPos, 40, 20)
				local ed = EffectData()
				ed:SetEntity(self)
				ed:SetAngles(tr.HitNormal:Angle())
				ed:SetOrigin(tr.HitPos)
				ed:SetScale(30)
				util.Effect("wac_impact_m197",ed)
			end
			self.Entity:Remove()
		end
	else
		local ang = camAng + Angle(math.Rand(-num,num), math.Rand(-num,num), math.Rand(-num,num))
		gred.CreateBullet(self:getAttacker(),pos,ang,self.BulletType,self.FILTER,nil,false,self:UpdateTracers())
		
		local effectdata = EffectData()
		effectdata:SetOrigin(self:LocalToWorld(pos))
		effectdata:SetAngles(ang)
		effectdata:SetEntity(self)
		util.Effect("gred_particle_aircraft_muzzle",effectdata)
	end
	
	if self.Loop then
		if !self:GetIsShooting() then
			self.sounds.shoot1p:Play()
			self.sounds.shoot3p:Play()
			self.sounds.shoot3p:SetSoundLevel(130)
		end
	else
		self.sounds.shoot1p:Stop()
		self.sounds.shoot1p:Play()
		self.sounds.shoot3p:Stop()
		self.sounds.shoot3p:Play()
		self.sounds.shoot3p:SetSoundLevel(130)
	end
	self:SetIsShooting(true)
end

function ENT:UpdateTracers()
	tracers = tracers + 1
	if tracers >= self.TracerConvar then
		tracers = 0
		return self.TracerColor
	else
		return false
	end
end

function ENT:stop()
	if self:GetIsShooting() then
		self.sounds.shoot1p:Stop()
		self.sounds.shoot3p:Stop()
		self.sounds.stop1p:Stop()
		self.sounds.stop1p:Play()
		self.sounds.stop3p:Stop()
		self.sounds.stop3p:Play()
		self:SetIsShooting(false)
	end
end

function ENT:canFire()
	return self:GetSpinSpeed() > 0.8
end

function ENT:Think()
	local s = math.Clamp(self:GetSpinSpeed() + (self.shouldShoot and FrameTime() or -FrameTime())*6, 0, 1)
	self:SetSpinSpeed(s)
	self.sounds.spin:ChangeVolume(s*100, 0.1)
	self.sounds.spin:ChangePitch(s*100, 0.1)
	return self:basePodThink()
end

