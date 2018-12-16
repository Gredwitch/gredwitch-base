if not wac then return end

ENT.Base 			= "wac_pod_base"
ENT.Type 			= "anim"
ENT.PrintName 		= ""
ENT.Author 			= "Gredwitch"
ENT.Category 		= "Gredwitch's Stuff"
ENT.Contact 		= ""
ENT.Purpose 		= ""
ENT.Instructions 	= "end my life"
ENT.Spawnable		= false
ENT.AdminSpawnable	= false
ENT.Name 			= "Gredwitch's MG"
ENT.Ammo 			= 425
ENT.FireRate 		= 9999
ENT.Force 			= 200
ENT.ShootAng 		= Angle(0,0,0)
ENT.TkAmmo 			= 1
ENT.TracerColor 	= "Red"
ENT.BulletType 		= "wac_base_12mm"
ENT.Brrt 			= 0
ENT.Sounds = {
	shoot = "",
	stop = "",
}
if SERVER then util.AddNetworkString("gred_net_wac_mg_muzzle_fx")  end
function ENT:SetupDataTables()
	self:base("wac_pod_base").SetupDataTables(self)
	self:NetworkVar( "Vector", 0, "ShootPos" );
	self:NetworkVar( "Angle", 1, "ShootAng" );
end
function ENT:Initialize()
	self:base("wac_pod_base").Initialize(self)
	
	if tracer == nil then tracer = 0 end
	tracerConvar=GetConVar("gred_sv_tracers"):GetInt()
	ammovar=GetConVar("gred_sv_default_wac_munitions"):GetInt()
	if self.BulletType == "wac_base_7mm" then
		num = 0.5
	elseif self.BulletType == "wac_base_12mm" then
		num = 1
	elseif self.BulletType == "wac_base_20mm" then
		num = 1.4
	elseif self.BulletType == "wac_base_30mm" then
		num = 3
	end
end

function ENT:fireBullet(pos)
	if !self:takeAmmo(self.TkAmmo) then return end
	local ang = self.aircraft:GetAngles()
	if ammovar >= 1 then
		local bullet = {}
		bullet.Num = 1
		bullet.Src = self.aircraft:LocalToWorld(pos)
		bullet.Dir = self:GetForward()
		bullet.Spread = Vector(0.015,0.015,0)
		bullet.Tracer = 0
		bullet.Force = 5
		bullet.Damage = 20
		bullet.Attacker = self:getAttacker()
		self.aircraft:FireBullets(bullet)
	else
		local pos2=self.aircraft:LocalToWorld(pos+Vector(self.aircraft:GetVelocity():Length()*0.6,0,0))
		ang:Add(Angle(axis,axis,0) + Angle(math.Rand(-num,num), math.Rand(-num,num), math.Rand(-num,num)))
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
		b.gunRPM=self.FireRate
		b:Spawn()
		b:Activate()
		b.Filter = {self,self.aircraft,self.aircraft.entities}
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
	end
	net.Start("gred_net_wac_mg_muzzle_fx")
		net.WriteVector(self.aircraft:LocalToWorld(pos))
		net.WriteAngle(ang)
	net.Broadcast()
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
			timer.Create("gred_brrt",2.5, 1,function() self.aircraft:EmitSound("wac/a10/brrt_0"..math.random(1,4)..".wav",0,100, 1, CHAN_AUTO) end)
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