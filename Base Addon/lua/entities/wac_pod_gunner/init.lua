AddCSLuaFile("shared.lua")
include("shared.lua")


function ENT:Initialize()
	self:base("wac_pod_base").Initialize(self)
	self.sounds.spin:ChangePitch(0,0.1)
	self.sounds.spin:ChangeVolume(0,0.1)
	self.sounds.spin:Play()
	self:SetSpinSpeed(0)
	if tracer == nil then tracer = 0 end
	tracerConvar=GetConVarNumber("gred_tracers")
	self.basePodThink = self:base("wac_pod_base").Think
end

function ENT:fire()
	if !self:takeAmmo(self.TkAmmo) then return end
	local dir = self.aircraft:getCameraAngles():Forward()
	local pos = self.aircraft:LocalToWorld(self.ShootPos) + dir*self.ShootOffset.x
	local tr = util.QuickTrace(self:LocalToWorld(self.aircraft.Camera.pos) + dir*20, dir*999999999, {self, self.aircraft})
	local ang = (tr.HitPos - pos):Angle()
	local b = ents.Create(self.BulletType)
	if self.BulletType == "wac_base_12mm" then
		ang = ang + Angle(math.Rand(-0.5,0.5), math.Rand(-0.5,0.5), math.Rand(-0.5,0.5))
	elseif self.BulletType == "wac_base_12mm" then
		ang = ang + Angle(math.Rand(-1,1), math.Rand(-1,1), math.Rand(-1,1))
	elseif self.BulletType == "wac_base_20mm" then
		ang = ang + Angle(math.Rand(-2,2), math.Rand(-2,2), math.Rand(-2,2))
	elseif self.BulletType == "wac_base_30mm" then
		ang = ang + Angle(math.Rand(-3,3), math.Rand(-3,3), math.Rand(-3,3))
	end
	b:SetPos(pos)
	b:SetAngles(ang)
	if self.TracerColor == "Red" then b.col=Color(255,0,0) elseif self.TracerColor == "Green" then b.col=Color(0,255,0) end
	b.Speed=1000
	b.Size=0--13
	b.Width=0--1
	b.Damage=40
	b.Radius=70
	constraint.NoCollide(self.aircraft,b,0,0)
	constraint.NoCollide(self,b,0,0)
	constraint.NoCollide(self.aircraft.wheels[i],b,0,0)
	constraint.NoCollide(self.aircraft.camera,b,0,0)
	constraint.NoCollide(self.aircraft.topRotor,b,0,0)
	constraint.NoCollide(self.aircraft.topRotor2,b,0,0)
	constraint.NoCollide(self.aircraft.backRotor,b,0,0)
	constraint.NoCollide(self.aircraft.rotor,b,0,0)
	b.gunRPM=self.FireRate
	b:Spawn()
	if tracer >= tracerConvar then
		util.SpriteTrail(b, 0, Color(255,255,0), false, 5, 5, 0.05, 1/(15+1)*0.5, "trails/laser.vmt")
		util.SpriteTrail(b, 0, b.col, false, 13/2, 13/8, 13/350, 1/13/2*0.5, "trails/smoke.vmt")
		tracer = 0
	end
	b.Owner=self.seat
	local effectdata = EffectData()
	effectdata:SetOrigin(pos)
	effectdata:SetAngles(ang)
	effectdata:SetScale(1.5)
	self.sounds.shoot1p:Stop()
	self.sounds.shoot1p:Play()
	self.sounds.shoot1p:SetSoundLevel(110)
	self.sounds.shoot3p:Stop()
	self.sounds.shoot3p:Play()
	self.sounds.shoot3p:SetSoundLevel(110)
	util.Effect("MuzzleEffect", effectdata)
	--util.ScreenShake( self.aircraft:GetPos(), 100, 100, 0.3, 500 )
	tracer = tracer + 1
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

