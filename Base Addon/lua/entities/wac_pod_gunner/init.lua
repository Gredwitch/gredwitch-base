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
	if self.BulletType == "wac_base_7mm" then
		ang = ang + Angle(math.Rand(-0.5,0.5), math.Rand(-0.5,0.5), math.Rand(-0.5,0.5))
	elseif self.BulletType == "wac_base_12mm" then
		ang = ang + Angle(math.Rand(-1,1), math.Rand(-1,1), math.Rand(-1,1))
	elseif self.BulletType == "wac_base_20mm" then
		ang = ang + Angle(math.Rand(-1.4,1.4), math.Rand(-1.4,1.4), math.Rand(-1.4,1.4))
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
	if GetConVarNumber("gred_altmuzzleeffect") == 1 and (CLIENT or not game.IsDedicated()) then
		ParticleEffect("muzzleflash_sparks_variant_6",pos,ang,nil)
		ParticleEffect("muzzleflash_1p_glow",pos,ang,nil)
		ParticleEffect("muzzleflash_m590_1p_core",pos,ang,nil)
		ParticleEffect("muzzleflash_smoke_small_variant_1",pos,ang,nil)
	elseif GetConVarNumber("gred_altmuzzleeffect") == 0 and (CLIENT or not game.IsDedicated()) then
		local effectdata=EffectData()
		effectdata:SetOrigin(pos)
		effectdata:SetAngles(ang)
		effectdata:SetEntity(self.aircraft)
		effectdata:SetScale(3)
		util.Effect("MuzzleEffect", effectdata)
	end
	tracer = tracer + 1
	for _,e in pairs(self.aircraft.wheels) do
		if IsValid(e) then
		constraint.NoCollide(e,rocket,0,0)
		end
	end
	constraint.NoCollide(self.aircraft,rocket,0,0)
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

