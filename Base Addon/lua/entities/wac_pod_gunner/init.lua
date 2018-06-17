AddCSLuaFile("shared.lua")
include("shared.lua")


function ENT:Initialize()
	self:base("wac_pod_base").Initialize(self)
	self.sounds.spin:ChangePitch(0,0.1)
	self.sounds.spin:ChangeVolume(0,0.1)
	self.sounds.spin:Play()
	self:SetSpinSpeed(0)
	
	if tracer == nil then tracer = 0 end
	tracerConvar=GetConVar("gred_sv_tracers"):GetInt()
	LAN = GetConVar("gred_sv_lan"):GetInt()
	
	bcolor = Color(255,255,0)
	num1   = 5
	num2   = 0.05
	num3   = 1 / (15 + 1)
	num4   = 13 / 2
	num5   = 13 / 8
	num6   = 13 / 350
	num7   = 1 / 13 / 2 * 0.5
	
	if	   self.TracerColor == "Red" then tracercolor=Color(255,0,0) 
	elseif self.TracerColor == "Green" then tracercolor=Color(0,255,0) 
	elseif self.TracerColor == "Yellow" then tracercolor=Color(0,255,0) 
	end
	
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
	b.Owner=self.seat
	
	if tracer >= tracerConvar then
		util.SpriteTrail(b, 0, bcolor, false, num1, num1, num2, num3, "trails/laser.vmt")
		util.SpriteTrail(b, 0, b.col, false, num4, num5, num6, num7, "trails/smoke.vmt")
		tracer = 0
	end
	tracer = tracer + 1
	
	if LAN == 1 then
		if GetConVar("gred_altmuzzleeffect"):GetInt() == 1 then
			ParticleEffect("muzzleflash_sparks_variant_6",pos,ang,nil)
			ParticleEffect("muzzleflash_1p_glow",pos,ang,nil)
			ParticleEffect("muzzleflash_m590_1p_core",pos,ang,nil)
			ParticleEffect("muzzleflash_smoke_small_variant_1",pos,ang,nil)
		else
			local effectdata=EffectData()
			effectdata:SetOrigin(pos)
			effectdata:SetAngles(ang)
			effectdata:SetEntity(self.aircraft)
			effectdata:SetScale(3)
			util.Effect("MuzzleEffect", effectdata)
		end
	elseif CLIENT then
		local ply = LocalPlayer()
		if tonumber(ply:GetInfo("gred_altmuzzleeffect",0)) == 1 then
			ParticleEffect("muzzleflash_sparks_variant_6",pos,ang,nil)
			ParticleEffect("muzzleflash_1p_glow",pos,ang,nil)
			ParticleEffect("muzzleflash_m590_1p_core",pos,ang,nil)
			ParticleEffect("muzzleflash_smoke_small_variant_1",pos,ang,nil)
		else
			local effectdata=EffectData()
			effectdata:SetOrigin(pos)
			effectdata:SetAngles(ang)
			effectdata:SetEntity(self.aircraft)
			effectdata:SetScale(1)
			util.Effect("MuzzleEffect", effectdata)
		end
	end
	
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

