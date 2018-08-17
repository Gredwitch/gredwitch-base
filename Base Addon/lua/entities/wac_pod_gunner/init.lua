if not wac then return end

AddCSLuaFile("shared.lua")
AddCSLuaFile("cl_init.lua")
include("shared.lua")

function ENT:Initialize()
	self:base("wac_pod_base").Initialize(self)
	self.sounds.spin:ChangePitch(0,0.1)
	self.sounds.spin:ChangeVolume(0,0.1)
	self.sounds.spin:Play()
	self:SetSpinSpeed(0)
	
	if tracer == nil then tracer = 0 end
	tracerConvar=GetConVar("gred_sv_tracers"):GetInt()
	
	self.basePodThink = self:base("wac_pod_base").Think
end

function ENT:fire()
	if !self:takeAmmo(self.TkAmmo) then return end
	local dir = self.aircraft:getCameraAngles():Forward()
	local pos = self.aircraft:LocalToWorld(self.ShootPos) + dir*self.ShootOffset.x
	local tr = util.QuickTrace(self:LocalToWorld(self.aircraft.Camera.pos) + dir*20, dir*999999999, {self, self.aircraft})
	
	if self.BulletType == "wac_base_7mm" then
		spread = Angle(math.Rand(-0.5,0.5), math.Rand(-0.5,0.5), math.Rand(-0.5,0.5))
	elseif self.BulletType == "wac_base_12mm" then
		spread = Angle(math.Rand(-1,1), math.Rand(-1,1), math.Rand(-1,1))
	elseif self.BulletType == "wac_base_20mm" then
		spread = Angle(math.Rand(-1.4,1.4), math.Rand(-1.4,1.4), math.Rand(-1.4,1.4))
	elseif self.BulletType == "wac_base_30mm" then
		spread = Angle(math.Rand(-3,3), math.Rand(-3,3), math.Rand(-3,3))
	end
	
	local ang = (tr.HitPos - pos):Angle() + spread
	local b = ents.Create("gred_base_bullet")
	b:SetPos(pos)
	b:SetAngles(ang)
	b.Speed=1000
	b.Size=0
	b.col = tracercolor
	b.Caliber = self.BulletType
	b.Width=0
	b.Damage=40
	b.Radius=70
	b.gunRPM=self.FireRate
	b:Spawn()
	b:Activate()
	b.Owner=self:getAttacker()
	
	if tracer >= GetConVarNumber("gred_sv_tracers") then
		if self.Color == "Red" then
			b:SetSkin(1)
		elseif self.Color == "Green" then
			b:SetSkin(3)
		elseif self.Color == "Yellow" then
			b:SetSkin(0)
		end
		b:SetModelScale(20)
		tracer = 0
	else b.noTracer = true end
	tracer = tracer + 1
	
	net.Start("gred_net_wac_gunner_muzzle_fx")
		net.WriteVector(pos)
		net.WriteAngle(ang)
	net.Broadcast()
	
	for _,e in pairs(self.aircraft.wheels) do
		if IsValid(e) then
			constraint.NoCollide(e,b,0,0)
		end
	end
	constraint.NoCollide(self.aircraft,b,0,0)
	
	self.sounds.shoot1p:Stop()
	self.sounds.shoot1p:Play()
	self.sounds.shoot1p:SetSoundLevel(110)
	self.sounds.shoot3p:Stop()
	self.sounds.shoot3p:Play()
	self.sounds.shoot3p:SetSoundLevel(110)
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

