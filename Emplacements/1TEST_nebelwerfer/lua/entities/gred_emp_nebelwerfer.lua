AddCSLuaFile()
DEFINE_BASECLASS( "base_anim" )
ENT.Spawnable		            	=	true
ENT.AdminSpawnable		            =	true

ENT.PrintName		                =	"[EMP]Nebelwerfer 41"
ENT.Author			                =	"Gredwitch"
ENT.Contact			                =	"qhamitouche@gmail.com"
ENT.Category                        =	"Gredwitch's Stuff"
ENT.Ammo							=	6
ENT.Model                           =	"models/gredwitch/nebelwerfer/nebelwerfer.mdl"
ENT.Mass							=	21
ENT.ReloadTime						=	10
ENT.Dump							=	false

if (SERVER) then
	function ENT:SpawnFunction( ply, tr, ClassName )
			if (  !tr.Hit ) then return end
			local SpawnPos = tr.HitPos + tr.HitNormal * 16
			local ent = ents.Create( ClassName )
			ent:SetPos( SpawnPos )
			ent:Spawn()
			ent:Activate()
			ent:SetSkin(math.random(0,3))
			return ent
	end

	function ENT:Initialize()
		self:SetModel(self.Model)
		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetMoveType(MOVETYPE_VPHYSICS)
		self:SetSolid(SOLID_VPHYSICS)
		phys = self:GetPhysicsObject()
		if (IsValid(phys)) then
			phys:SetMass(self.Mass)
			phys:Wake()
		end
		self.nextUse=0
		local effectAng=Angle(180,90,0)
	end
		
	function ENT:Shoot()
		if self.nextUse>CurTime() or self.Ammo == 0 then return end
		print(self.Ammo)
		self.nextUse = CurTime()+1
		local pos = self:GetPos()
		local rang = self:GetAngles().r
		local ang = self:GetAngles()
		--[[if rang >= 0 and rang <= 90 then
			rocketpos = pos + Vector(0,200,50)
		elseif rang >= 90 and rang <= 180 then
			rocketpos = pos + Vector(0,0,50)
		elseif rang >= 180 and rang <= 270 then
			rocketpos = pos + Vector(0,-200,50)
		end--]]
		print(pos)
		local ent = ents.Create("gb_rocket_nebel")
		if self.Ammo==6 then ent:SetPos(pos+Vector(-10,123,45)) elseif self.Ammo==5 then ent:SetPos(pos+Vector(-4,120,60))
		elseif self.Ammo==4 then ent:SetPos(pos+Vector(5,120,60)) elseif self.Ammo==3 then ent:SetPos(pos+Vector(11,123,45))
		elseif self.Ammo==2 then ent:SetPos(pos+Vector(9.5,125,35)) elseif self.Ammo==1 then ent:SetPos(pos+Vector(-8.5,125,35)) end
		ent:SetAngles((Angle(-20,math.random(0,5),math.random(0,5))) + ang-Angle(0,-90,0)) 
		ent:SetOwner(caller)
		ent:Activate()
		ent:Spawn()
		ent:Launch()
		self.Ammo = self.Ammo - 1
		util.ScreenShake(pos, 30, 4, math.Rand(0.5, 0.8), 320)
		ParticleEffect("ins_weapon_rpg_backblast", pos,ang-Angle(0,90,0))
	end

	function ENT:Use(activator, caller)
		self.Dump = true
	end

	function ENT:Reload()
		self.nextUse = CurTime()+self.ReloadTime
		timer.Simple(self.ReloadTime, function() 
			self.Ammo = 6
			self.Dump = false
		end)
	end

	function ENT:Think()
			if self.Ammo < 0 then self.Ammo = 0 end
			if self.Ammo > 6 then self.Ammo = 6 end
			
			if self.Dump and self.Ammo>0 then
				self:Shoot()
				if self.Ammo==0 then self:Reload() end
			end
			self:NextThink(CurTime())
			return true
		end
elseif (CLIENT) then
	function ENT:Draw()
		self:DrawModel()
	end
end