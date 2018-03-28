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
	tracerConvar=GetConVarNumber("gred_tracers")
end

function ENT:fireBullet(pos)
	if !self:takeAmmo(self.TkAmmo) then return end
	if not self.seat then return end
	local pos2=self.aircraft:LocalToWorld(pos+Vector(self.aircraft:GetVelocity():Length()*0.6,0,0))
	--if ShootAng == Angle(0,0,0) then
		local ang=self.aircraft:GetAngles()+Angle(axis,axis,0)
	--[[else
		local ang=self.aircraft:GetAngles()+ShootAng
	end--]]
	--print(ShootAng)
	local b=ents.Create(self.BulletType)
	b:SetPos(pos2)
	if self.BulletType == "wac_base_mg" then
		ang = ang + Angle(math.Rand(-1,1), math.Rand(-1,1), math.Rand(-1,1))
	elseif self.BulletType == "wac_base_20mm" then
		ang = ang + Angle(math.Rand(-2,2), math.Rand(-2,2), math.Rand(-2,2))
	elseif self.BulletType == "wac_base_30mm" then
		ang = ang + Angle(math.Rand(-3,3), math.Rand(-3,3), math.Rand(-3,3))
	end
	b:SetAngles(ang)
	if self.TracerColor == "Red" then b.col=Color(248,152,29) 
	elseif self.TracerColor == "Green" then b.col=Color(0,255,0) 
	elseif self.TracerColor == "Yellow" then b.col=Color(0,255,0) 
	end
	b.Speed=1000
	b.Size=0--13
	b.Width=0--1
	b.Damage=40
	b.Radius=70
	b.sequential=self.Sequential
	b.npod=#self.Pods
	constraint.NoCollide(b,self.aircraft,0,0)
	b.gunRPM=self.FireRate
	b:Spawn()
	if tracer >= tracerConvar then
		util.SpriteTrail(b, 0, Color(255,255,0), false, 5, 5, 0.05, 1/(15+1)*0.5, "trails/laser.vmt")
		util.SpriteTrail(b, 0, b.col, false, 13/2, 13/8, 13/350, 1/13/2*0.5, "trails/smoke.vmt")
		--util.SpriteTrail(b, 0, b.col, false, 13/2, 13/8, 13/40, 1/13/2*0.5, "trails/smoke.vmt")	
		--util.SpriteTrail(b, 0, Color(255,255,0), false, 5, 0, 0.05, 1/(15+1)*0.5, "trails/laser.vmt")
		tracer = 0
	end
	b.Owner=self.seat
	local effectdata=EffectData()
	effectdata:SetOrigin(self:LocalToWorld(pos))
	effectdata:SetAngles(ang)
	effectdata:SetEntity(self)
	effectdata:SetScale(3)
	util.Effect("MuzzleEffect", effectdata)
	--util.ScreenShake( self.aircraft:GetPos(), 100, 100, 0.3, 500 )
	tracer = tracer + 1
end


function ENT:fire()
	if !self.shooting then
		self.shooting = true
		self.sounds.stop:Stop()
		self.sounds.shoot:Play()
		self.sounds.shoot:SetSoundLevel(130)
		self.sounds.stop:SetSoundLevel(130)
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
		self.sounds.shoot:SetSoundLevel(110)
		self.sounds.stop:SetSoundLevel(110)
		self.shooting = false
		if self.Brrt == 1 then
			timer.Simple(2.5, function() self.aircraft:EmitSound("wac/a10/brrt.wav",0, math.random(80,120), 1, CHAN_AUTO) end)											
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