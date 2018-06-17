ENT.Base = "wac_pod_base"
ENT.Type = "anim"
ENT.PrintName = ""
ENT.Author = wac.author
ENT.Category = wac.aircraft.spawnCategoryC
ENT.Contact = ""
ENT.Purpose = ""
ENT.Instructions = "end my life"
ENT.Spawnable = false
ENT.AdminSpawnable = false
ENT.Name = "Gredwitch's MG"
ENT.Ammo = 425
ENT.FireRate = 9999
ENT.Force = 200
ENT.ShootAng = Angle(0,0,0)
ENT.TkAmmo = 1
ENT.TracerColor = "Red"
ENT.BulletType = "wac_base_12mm"
ENT.Brrt = 0
ENT.Sounds = {
	shoot = "",
	stop = "",
}
function ENT:Initialize()
	self:base("wac_pod_base").Initialize(self)
	
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
end

function ENT:fireBullet(pos)
	if !self:takeAmmo(self.TkAmmo) then return end
	if not self.seat then return end
	local pos2=self.aircraft:LocalToWorld(pos+Vector(self.aircraft:GetVelocity():Length()*0.6,0,0))
	
	if self.BulletType == "wac_base_7mm" then
		spread = Angle(math.Rand(-0.5,0.5), math.Rand(-0.5,0.5), math.Rand(-0.5,0.5))
	elseif self.BulletType == "wac_base_12mm" then
		spread = Angle(math.Rand(-1,1), math.Rand(-1,1), math.Rand(-1,1))
	elseif self.BulletType == "wac_base_20mm" then
		spread = Angle(math.Rand(-1.4,1.4), math.Rand(-1.4,1.4), math.Rand(-1.4,1.4))
	elseif self.BulletType == "wac_base_30mm" then
		spread = Angle(math.Rand(-3,3), math.Rand(-3,3), math.Rand(-3,3))
	end
	
	local ang = self.aircraft:GetAngles()+Angle(axis,axis,0) + spread
	local b=ents.Create("gred_base_bullet")
	b:SetPos(pos2)
	b:SetAngles(ang)
	b.col = tracercolor
	b.Speed=1000
	b.Caliber = self.BulletType
	b.Size=0
	b.Width=0
	b.Damage=40
	b.Radius=70
	b.sequential=self.Sequential
	b.npod=#self.Pods
	constraint.NoCollide(b,self.aircraft,0,0)
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
	
	LtWPOS = self:LocalToWorld(pos)
	if LAN == 1 then
		if GetConVar("gred_altmuzzleeffect"):GetInt() == 1 then
			ParticleEffect("muzzleflash_sparks_variant_6",LtWPOS,ang,nil)
			ParticleEffect("muzzleflash_1p_glow",LtWPOS,ang,nil)
			ParticleEffect("muzzleflash_m590_1p_core",LtWPOS,ang,nil)
			ParticleEffect("muzzleflash_smoke_small_variant_1",LtWPOS,ang,nil)
		else
			local effectdata=EffectData()
			effectdata:SetOrigin(LtWPOS)
			effectdata:SetAngles(ang)
			effectdata:SetEntity(self.aircraft)
			effectdata:SetScale(3)
			util.Effect("MuzzleEffect", effectdata)
		end
	elseif CLIENT then
		local ply = LocalPlayer()
		if tonumber(ply:GetInfo("gred_altmuzzleeffect",0)) == 1 then
			ParticleEffect("muzzleflash_sparks_variant_6",LtWPOS,ang,nil)
			ParticleEffect("muzzleflash_1p_glow",LtWPOS,ang,nil)
			ParticleEffect("muzzleflash_m590_1p_core",LtWPOS,ang,nil)
			ParticleEffect("muzzleflash_smoke_small_variant_1",LtWPOS,ang,nil)
		else
			local effectdata=EffectData()
			effectdata:SetOrigin(LtWPOS)
			effectdata:SetAngles(ang)
			effectdata:SetEntity(self.aircraft)
			effectdata:SetScale(3)
			util.Effect("MuzzleEffect", effectdata)
		end
	end
	
	for _,e in pairs(self.aircraft.wheels) do
		if IsValid(e) then
			constraint.NoCollide(e,b,0,0)
		end
	end
	constraint.NoCollide(self.aircraft,b,0,0)
end


function ENT:fire()
	if !self.shooting then
		self.shooting = true
		self.sounds.shoot:SetSoundLevel(100)
		self.sounds.stop:SetSoundLevel(100)
		self.sounds.stop:Stop()
		self.sounds.shoot:Play()
	end
	if self.Sequential then
		self.currentPod = self.currentPod or 1
		self:fireBullet(self.Pods[self.currentPod], self:GetAngles())
		self.currentPod = (self.currentPod == #self.Pods and 1 or self.currentPod + 1)
	else
	    for _, v in pairs(self.Pods) do
	    	self:fireBullet(v)
	    end
    	self:SetNextShot(self:GetLastShot() + 60/self.FireRate)
    end
end

function ENT:stop()
	if self.shooting then
		self.sounds.shoot:Stop()
		self.sounds.stop:Play()
		self.shooting = false
		if self.Brrt == 1 then
			timer.Create("gred_brrt",2.5, 1,function() self.aircraft:EmitSound("wac/a10/brrt.wav",0, math.random(80,120), 1, CHAN_AUTO) end)
			self:CallOnRemove(("StopBrrt"), function() timer.Remove("gred_brrt") end)
		end
	end
end
function ENT:drawCrosshair()
	surface.SetDrawColor(255,255,255,150)
	local center = {x=ScrW()/2, y=ScrH()/2}
	surface.DrawLine(center.x+10, center.y, center.x+30, center.y)
	surface.DrawLine(center.x-30, center.y, center.x-10, center.y)
	surface.DrawLine(center.x, center.y+10, center.x, center.y+30)
	surface.DrawLine(center.x, center.y-30, center.x, center.y-10)
	surface.DrawOutlinedRect(center.x-10, center.y-10, 20, 20)
	surface.DrawOutlinedRect(center.x-11, center.y-11, 22, 22)
end