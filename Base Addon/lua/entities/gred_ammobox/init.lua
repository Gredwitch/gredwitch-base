AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

util.AddNetworkString("gred_net_ammobox_cl_gui")
util.AddNetworkString("gred_net_ammobox_sv_createshell")
util.AddNetworkString("gred_net_ammobox_sv_createammo")
util.AddNetworkString("gred_net_ammobox_sv_close")

local SpawnOffset = Vector(0,0,50)
local AmmoSpawnOffset = Vector(0,0,70)

net.Receive("gred_net_ammobox_sv_createammo",function(len,ply)
	local ModelPath = net.ReadString()
	local self = net.ReadEntity()
	local GunClass = net.ReadString()
	local BodygroupID = net.ReadUInt(1)
	local BodygroupValue = net.ReadUInt(1)
	
	if !IsValid(self) then return end
	if self:GetClass() != "gred_ammobox" then return end
	
	local ent = ents.Create("prop_physics")
	ent:SetPos(self:GetPos() + AmmoSpawnOffset)
	ent:SetModel(ModelPath)
	ent:SetBodygroup(BodygroupID,BodygroupValue)
	ent.gredGunEntity = GunClass
	ent:Spawn()
	ent:Activate()
	
	constraint.NoCollide(self,ent,0,0)
	
	local p = ent:GetPhysicsObject()
	if IsValid(p) then
		p:SetMass(35)
	end
	
	ply:PickupObject(ent)
	
	self:ResetSequence("close")
end)

ENT.Players = {}

net.Receive("gred_net_ammobox_sv_createshell",function(len,ply)
	local self = net.ReadEntity()
	
	if !IsValid(self) then return end
	
	if not self.Players[ply] then return end
	
	if ply:GetPos():Distance(self:GetPos()) > 300 then
		self.Players[ply] = false
		
		return
	end
	
	if self:GetClass() != "gred_ammobox" then return end
	
	local Shell = gred.CreateShell(self:GetPos() + AmmoSpawnOffset,
					self:GetAngles(),
					ply,
					self.FILTER,
					net.ReadUInt(8),
					net.ReadString(),
					500,
					1
	)
	
	Shell.ImpactSpeed = 1000
	
	timer.Simple(0.1,function()
		if !IsValid(Shell) then return end
		
		local phy = Shell:GetPhysicsObject()
		
		if IsValid(phy) then
			phy:EnableDrag(false)
			phy:Wake()
		end
		
		ply:PickupObject(Shell)
		-- Shell:Use(ply,self,2,1)
	end)
	
	self.Players[ply] = false
	
	self:ResetSequence("close")
end)

net.Receive("gred_net_ammobox_sv_close",function()
	local self = net.ReadEntity()
	if !IsValid(self) then return end
	if self:GetClass() != "gred_ammobox" then return end
	
	self.Players[ply] = false
	
	self:ResetSequence("close")
end)

function ENT:Initialize()
	self:SetModel(self.Model)
	self.Entity:PhysicsInit(SOLID_VPHYSICS)
	self.Entity:SetMoveType(MOVETYPE_VPHYSICS)
	self.Entity:SetSolid(SOLID_VPHYSICS)
	self.Entity:SetCollisionGroup(COLLISION_GROUP_NONE)
	self:SetUseType(SIMPLE_USE)
	
	local p = self:GetPhysicsObject()
	if IsValid(p) then
		p:Wake()
		p:SetMass(50)
	end
	
	self:SetPos(self:GetPos() + SpawnOffset)
	
	self.FILTER = {self}
end

function ENT:Use(ply,cal)
	if self.NextUse >= CurTime() then return end
	
	self.Players[ply] = true
	
	self:ResetSequence("open")
	
	net.Start("gred_net_ammobox_cl_gui")
			net.WriteEntity(self)
	net.Send(ply)
	
	self.NextUse = CurTime()+0.5
end

function ENT:OnTakeDamage(dmg)
	if not dmg:IsFallDamage() and dmg:GetDamage() > 5 then
		local n = dmg:GetDamage()
		if n < 0 then n = -n end
		self.Attacker = dmg:GetAttacker()
		self.CurLife = self.CurLife - dmg:GetDamage()
	end
end

function ENT:Explode()
	if self:GetInvincible() then return end
	if SERVER then
		local pos = self:GetPos()
		
		local effectdata = EffectData()
		effectdata:SetOrigin(pos+Vector(0,0,100))
		effectdata:SetFlags(table.KeyFromValue(gred.Particles,"ins_ammo_explosionOLD"))
		effectdata:SetAngles(Angle(0,90,0))
		util.Effect("gred_particle_simple",effectdata)
		
		gred.CreateExplosion(pos,self.ExplosionRadius,self.ExplosionDamage,self.Decal,self.TraceLength,self.Attacker,self,self.DEFAULT_PHYSFORCE,self.DEFAULT_PHYSFORCE_PLYGROUND,self.DEFAULT_PHYSFORCE_PLYAIR)
		
		gred.CreateSound(pos,false,self.ExplosionSound,self.FarExplosionSound,self.DistExplosionSound)
		self:Remove()
	end
end

function ENT:Think()
	if self.CurLife <= 0 then self:Explode() end
end