AddCSLuaFile("shared.lua")
AddCSLuaFile("init.lua")
include("shared.lua")

-- I didn't make the WireMod code

local Normal = Vector(1,1,0)
local Normal2 = Vector(0.1,1,1)
local trlength = Vector(0,0,9000)
local angle_zero = Angle()
local angle_1 = Angle(-90,0,0)

function ENT:Initialize()
	if gred.CVars["gred_sv_spawnable_bombs"]:GetInt() == 0 and not self.IsOnPlane then
		self:Remove()
		return
	end
	
	self:DoPreInit()
	
	self:SetModel(self.Model)
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetUseType(ONOFF_USE)
	
	local phys = self:GetPhysicsObject()
	local skincount = self:SkinCount()
	
	if phys:IsValid() then
		phys:SetMass(self.Mass)
		self:InitPhysics(phys)
		phys:Wake()
	end
	
	self:SetSkin(math.random(0,skincount-1))
	self.CurLife = self.Life or 100
	self.Owner = IsValid(self.Owner) and self.Owner or self
	
	self:AddOnInit()
end

function ENT:AddOnInit() 
	if !(WireAddon == nil) then self.Inputs = Wire_CreateInputs(self, { "Arm", "Detonate" }) end
end

function ENT:DoPreInit()

end

function ENT:AddOnExplode() 
	
end

function ENT:AddOnThink() 
	
end

function ENT:InitPhysics(phys)

end

function ENT:PhysicsUpdate(ph)
	-- if self.Armed and self:WaterLevel() >= 1 and ph:GetVelocity():Length() >= self.ImpactSpeed then
		-- self.Exploded = true
		-- self:Explode()
		
		-- return
	-- end
	
	if not self.JDAM or not self.Armed then return end
	
	local pos = self:GetPos()
	local vel = self:WorldToLocal(pos+ph:GetVelocity())*0.4
	vel.x = 0
	local target = self.target:LocalToWorld(self.targetOffset)
	
	local v = self:WorldToLocal(target + Vector(0,0,math.Clamp((pos*Normal):Distance(target*Normal)/5 - 50,0,1000))):GetNormal()
	v.y = math.Clamp(v.y*10,-1,1)*100
	v.z = math.Clamp(v.z*10,-1,1)*100
	ph:AddAngleVelocity(
		ph:GetAngleVelocity()*-0.4
		+ Vector(math.Rand(-1,1), math.Rand(-1,1), math.Rand(-1,1))*5
		+ Vector(0,-vel.z,vel.y)
		+ Vector(0,-v.z,v.y)
	)
	ph:AddVelocity(self:GetForward() - self:LocalToWorld(vel*Normal2) + pos)
end

function ENT:TriggerInput(iname, value)
	if value >= 1 and not self.Exploded then
		if iname == "Detonate" and self.Armed then
			self:ExplodeCorrectly()
		elseif iname == "Arm" and not self.Armed and not self.Arming then
			self:EmitSound(self.ActivationSound)
			self:Arm()
		end	
	end
end 

function ENT:Think()
	self:AddOnThink()
end


function ENT:ExplodeCorrectly()
	if self.MaxDelay > 0 then
		timer.Simple(math.Rand(0,self.MaxDelay),function()
			if !IsValid(self) then return end
			
			self.Exploded = true
			self:Explode()
		end)
	else
		self.Exploded = true
		self:Explode()
	end
end

function ENT:Explode(pos)
	if !self.Exploded then return end
	
	pos = pos or self:LocalToWorld(self:OBBCenter())
	
	if self:AddOnExplode(pos) then
		self.Exploded = false 
		return 
	end
	
	if not self.Smoke then
		gred.CreateExplosion(pos,self.ExplosionRadius,self.ExplosionDamage * gred.CVars.gred_sv_shell_gp_he_damagemultiplier:GetFloat(),self.Decal,self.TraceLength,self.Owner,self,self.DEFAULT_PHYSFORCE,self.DEFAULT_PHYSFORCE_PLYGROUND,self.DEFAULT_PHYSFORCE_PLYAIR)
	end
	
	if not self.NO_EFFECT then
		net.Start("gred_net_createparticle")
		
		if self:WaterLevel() >= 1 then
			local tr = util.TraceLine({
				start   = util.TraceLine({
					start   = pos,
					endpos  = pos + trlength,
					filter  = self,
				}).HitPos,
				endpos  = pos - trlength,
				filter  = self,
				mask    = MASK_WATER + CONTENTS_TRANSLUCENT,
			})
			
			if tr.Hit then
				net.WriteString(self.EffectWater) -- FIXME : Optimize
				net.WriteVector(tr.HitPos)
				net.WriteAngle(self.EffectWater == "ins_water_explosion" and angle_1 or angle_zero)
				net.WriteBool(false)
			end
			
			if !self.Smoke then
				if self.WaterExplosionSound then 
					self.ExplosionSound = self.WaterExplosionSound 
				end
				if self.WaterFarExplosionSound then
					self.FarExplosionSound = self.WaterFarExplosionSound 
				end
			end
		else
			local tr = util.TraceLine({
			start    = pos,
			endpos   = pos - Vector(0,0,self.TraceLength),
			filter   = self})
			
			net.WriteString(tr.HitWorld and self.Effect or self.EffectAir) -- FIXME : Optimize
			net.WriteVector(pos)
			net.WriteAngle(self.AngEffect and angle_1 or angle_zero)
			net.WriteBool(tr.HitWorld)
		end
		
		net.Broadcast()
	end
	
	gred.CreateSound(pos,nil,self.ExplosionSound,self.FarExplosionSound,self.DistExplosionSound) -- FIXME : Replace self.RSound == 1 with an actual bool
	
	timer.Simple(0,function()
		if !IsValid(self) then return end
		
		self:Remove()
	end)
end

function ENT:OnTakeDamage(dmginfo)
	if self.Exploded then return end

	local inflictor = dmginfo:GetInflictor()
	
	if IsValid(inflictor) and inflictor.IsGredBomb then return end
	
	self:TakePhysicsDamage(dmginfo)
	
	if gred.CVars["gred_sv_fragility"]:GetBool() then
		self:Arm()
	end
	 
	if !self.Armed then return end

	self.CurLife = self.CurLife - dmginfo:GetDamage()
	
	if self.CurLife <= 0 then
		self:ExplodeCorrectly()
	elseif self.CurLife <= self.Life * 0.5 and !self.Exploded and self.Flamable then
		self:Ignite(self.MaxDelay,0)
	end
end

function ENT:PhysicsCollide( data, physobj )
	if self.Exploded or self.Life <= 0 or data.Speed < self.ImpactSpeed then return end
	
	if gred.CVars["gred_sv_fragility"]:GetBool() and !self.Arming and !self.Armed then
		self:EmitSound("weapons/rpg/shotdown.wav")
		self:Arm()
	end
	
	if self.ShouldExplodeOnImpact and self.Armed then
		self.Exploded = true
		self:Explode(data.HitPos)
	end
end

function ENT:Arm()
	if self.Exploded or self.Armed or self.Arming then return end
	
	self.Arming = true
	self.Used = true
	
	if self.ArmDelay and self.ArmDelay > 0 then
		timer.Simple(self.ArmDelay,function()
			if !IsValid(self) then return end
			
			self:ArmInternal()
		end)
	else
		self:ArmInternal()
	end
end

function ENT:ArmInternal()
	self.Armed = true
	self.Arming = false
	
	self:EmitSound(self.ArmSound)
	
	if self.Timed or self.JDAM then
		if self.JDAM then 
			self.Timer = 20 
		end
		
		timer.Simple(self.Timer,function()
			if !IsValid(self) then return end 
			
			self:ExplodeCorrectly()
		end)
	end
end

function ENT:Use( activator, caller )
	if !self.Exploded and gred.CVars["gred_sv_easyuse"]:GetBool() and !self.Armed and !self.Used then
		self:EmitSound(self.ActivationSound)
		self:Arm()
	end
end

function ENT:OnRemove()
	 self:StopParticles()
	-- Wire_Remove(self)
end

function ENT:OnRestore()
	Wire_Restored(self.Entity)
end

function ENT:BuildDupeInfo()
	return WireLib.BuildDupeInfo(self.Entity)
end

function ENT:ApplyDupeInfo(ply, ent, info, GetEntByID)
	WireLib.ApplyDupeInfo( ply, ent, info, GetEntByID )
end

function ENT:PrentityCopy()
	local DupeInfo = self:BuildDupeInfo()
	if(DupeInfo) then
	    duplicator.StorentityModifier(self,"WireDupeInfo",DupeInfo)
	end
end

function ENT:PostEntityPaste(Player,Ent,CreatedEntities)
	if(Ent.EntityMods and Ent.EntityMods.WireDupeInfo) then
	    Ent:ApplyDupeInfo(Player, Ent, Ent.EntityMods.WireDupeInfo, function(id) return CreatedEntities[id] end)
	end
end