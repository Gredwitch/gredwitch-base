AddCSLuaFile()
DEFINE_BASECLASS( "base_anim" )

local Models = {}
Models[1]                            =  "testmodel"

local damagesound                    =  "weapons/rpg/shotdown.wav"

ENT.Spawnable		            	 =  false
ENT.AdminSpawnable		             =  false

ENT.PrintName		                 =  "[BOMBS]Base bomb"
ENT.Author			                 =  "Gredwitch"
ENT.Contact			                 =  "contact.gredwitch@gmail.com"
ENT.Category                         =  "Gredwitch's Stuff"

ENT.Model                            =  ""

ENT.Effect                           =  ""
ENT.EffectAir                        =  ""
ENT.EffectWater                      =  ""

ENT.ArmSound                         =  ""
ENT.ActivationSound                  =  ""
ENT.AngEffect						 =	false

ENT.ExplosionSound                   =  ""
ENT.FarExplosionSound				 =  ""
ENT.DistExplosionSound				 =  ""

ENT.WaterExplosionSound				 =	nil
ENT.WaterFarExplosionSound			 =  nil

ENT.ShouldExplodeOnImpact            =  false
ENT.Flamable                         =  false
ENT.Timed                            =  false

ENT.Decal							 =	"scorch_medium"
ENT.ExplosionDamage                  =  0
ENT.ExplosionRadius                  =  0
ENT.MaxIgnitionTime                  =  5
ENT.Life                             =  20
ENT.MaxDelay                         =  2
ENT.TraceLength                      =  100
ENT.ImpactSpeed                      =  500
ENT.Mass                             =  0
ENT.ArmDelay                         =  0.5
ENT.Timer                            =  0
ENT.RSound   						 =  1
ENT.JDAM							 =  false
ENT.Smoke							 =	false

ENT.DEFAULT_PHYSFORCE                = 50
ENT.DEFAULT_PHYSFORCE_PLYAIR         = 500
ENT.DEFAULT_PHYSFORCE_PLYGROUND      = 5000
ENT.GBOWNER                          = nil

local SERVER = SERVER
--[[
[19:22]
| HT.S | Gredwitch:
	well actually
	that's a häck to make my shell travelling at 500m/s hit their target correctly
	function ENT:Initialize()
		local tbl = physenv.GetPerformanceSettings()
		tbl.MaxVelocity = 200000000
		physenv.SetPerformanceSettings(tbl)
	idk why i've thrown this in initialize

[19:23]
Luna:
	op
	i like the idea of your addon forcing everyones velocity limit to 200000000

[19:23]
| HT.S | Gredwitch:
	yea cuz why not
	you should do the same

[19:24]
Luna:
	will fix alot of peoples complains in simfphys comment section about too slow cars
	Lol
]]
function ENT:Initialize()
	local tbl = physenv.GetPerformanceSettings()
	tbl.MaxVelocity = 200000000
	physenv.SetPerformanceSettings(tbl)
	if SERVER then
		local spawnablebombs = gred.CVars["gred_sv_spawnable_bombs"]
		if spawnablebombs:GetInt() == 0 and not self.IsOnPlane then
			self:Remove()
			return
		end
		
		self:SetModel(self.Model)
		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetSolid(SOLID_VPHYSICS)
		self:SetMoveType(MOVETYPE_VPHYSICS)
		self:SetUseType(ONOFF_USE)
		local phys = self:GetPhysicsObject()
		local skincount = self:SkinCount()
		
		if (phys:IsValid()) then
			phys:SetMass(self.Mass)
			phys:Wake()
		end
		if (skincount > 0) then
			self:SetSkin(math.random(0,skincount))
		end
		self.Armed    = false
		self.Exploded = false
		self.Used	= false
		self.Arming   = false
		if self.GBOWNER == nil then self.GBOWNER = self.Owner else self.Owner = self.GBOWNER end
		self:AddOnInit()
	end
end

function ENT:AddOnInit() 
	if !(WireAddon == nil) then self.Inputs = Wire_CreateInputs(self, { "Arm", "Detonate" }) end
end

function ENT:PhysicsUpdate(ph)
	if self.Armed and self:WaterLevel() >= 1 and ph:GetVelocity():Length() >= self.ImpactSpeed then
		self.Exploded = true
		self:Explode()
		return
	end
	if not self.JDAM or not self.Armed then return end
	local pos = self:GetPos()
	local vel = self:WorldToLocal(pos+ph:GetVelocity())*0.4
	vel.x = 0
	local target = self.target:LocalToWorld(self.targetOffset)
	local dist = self:GetPos():Distance(target)
	
	local v = self:WorldToLocal(target + Vector(
		0, 0, math.Clamp((self:GetPos()*Vector(1,1,0)):Distance(target*Vector(1,1,0))/5 - 50, 0, 1000)
	)):GetNormal()
	v.y = math.Clamp(v.y*10,-1,1)*100
	v.z = math.Clamp(v.z*10,-1,1)*100
	ph:AddAngleVelocity(
		ph:GetAngleVelocity()*-0.4
		+ Vector(math.Rand(-1,1), math.Rand(-1,1), math.Rand(-1,1))*5
		+ Vector(0, -vel.z, vel.y)
		+ Vector(0,-v.z,v.y)
	)
	ph:AddVelocity(self:GetForward() - self:LocalToWorld(vel*Vector(0.1, 1, 1))+pos)
end

function ENT:TriggerInput(iname, value)
	if (!IsValid(self)) then return end
	if (iname == "Detonate") then
	   if (value >= 1) then
			if (!self.Exploded and self.Armed) then
				timer.Simple(math.Rand(0,self.MaxDelay),function()
					if !IsValid(self) then return end
				 self.Exploded = true
				   self:Explode()
				end)
			end
		end
	end
	if (iname == "Arm") then
	   if (value >= 1) then
		  if (!self.Exploded and !self.Armed and !self.Arming) then
				self:EmitSound(self.ActivationSound)
			 self:Arm()
		  end 
	   end
	end		
end 

function ENT:AddOnExplode() end

function ENT:AddOnThink() end

function ENT:Think()
	self:AddOnThink()
end

function ENT:Explode(pos)
	if !self.Exploded then return end
	pos = pos or self:LocalToWorld(self:OBBCenter())
	if self:AddOnExplode(pos) then self.Exploded = false return end
	if not self.Smoke then
		gred.CreateExplosion(pos,self.ExplosionRadius,self.ExplosionDamage,self.Decal,self.TraceLength,self.GBOWNER,self,self.DEFAULT_PHYSFORCE,self.DEFAULT_PHYSFORCE_PLYGROUND,self.DEFAULT_PHYSFORCE_PLYAIR)
	end
	net.Start("gred_net_createparticle")
	if(self:WaterLevel() >= 1) then
		local trdata   = {}
		local trlength = Vector(0,0,9000)

		trdata.start   = pos
		trdata.endpos  = trdata.start + trlength
		trdata.filter  = self
		local tr = util.TraceLine(trdata) 

		local trdat2   = {}
		trdat2.start   = tr.HitPos
		trdat2.endpos  = trdata.start - trlength
		trdat2.filter  = self
		trdat2.mask    = MASK_WATER + CONTENTS_TRANSLUCENT
			 
		local tr2 = util.TraceLine(trdat2)
		
		if tr2.Hit then
			net.WriteString(self.EffectWater)
			net.WriteVector(tr2.HitPos)
			if self.EffectWater == "ins_water_explosion" then
				net.WriteAngle(Angle(-90,0,0))
			else
				net.WriteAngle(Angle(0,0,0))
			end
			net.WriteBool(false)
		end
		if !self.Smoke then
			if self.WaterExplosionSound == nil then else 
				self.ExplosionSound = self.WaterExplosionSound 
			end
			if self.WaterFarExplosionSound == nil then else  
				self.FarExplosionSound = self.WaterFarExplosionSound 
			end
		end
	else
		local tracedata    = {}
		tracedata.start    = pos
		tracedata.endpos   = tracedata.start - Vector(0, 0, self.TraceLength)
		tracedata.filter   = self.Entity
				
		 local trace = util.TraceLine(tracedata)
		
		if trace.HitWorld then
			net.WriteString(self.Effect)
			net.WriteVector(pos)
			if self.AngEffect then
				net.WriteAngle(Angle(-90,0,0))
			else
				net.WriteAngle(Angle(0,0,0))
			end
			net.WriteBool(true)
		else
			net.WriteString(self.EffectAir)
			net.WriteVector(pos)
			if self.AngEffect then
				net.WriteAngle(Angle(-90,0,0))
			else
				net.WriteAngle(Angle(0,0,0))
			end
			net.WriteBool(false)
		end
    end
	net.Broadcast()
	
	gred.CreateSound(pos,self.RSound == 1,self.ExplosionSound,self.FarExplosionSound,self.DistExplosionSound)
	
	timer.Simple(0,function() self:Remove() end)
end

function ENT:OnTakeDamage(dmginfo)
	if self.Exploded then return end
	if dmginfo:IsDamageType(64) then return end
	
	self:TakePhysicsDamage(dmginfo)
	
	if self.Life <= 0 then return end
	
	if gred.CVars["gred_sv_fragility"]:GetInt() >= 1 then
		if !self.Armed and !self.Arming then
		    self:Arm()
		end
	end
	 
	if !self.Armed then return end

	self.Life = self.Life - dmginfo:GetDamage()
	if (self.Life <= self.Life*0.5) and !self.Exploded and self.Flamable then
		self:Ignite(self.MaxDelay,0)
	end
	if (self.Life <= 0) then 
		timer.Simple(math.Rand(0,self.MaxDelay),function()
			if !IsValid(self) then return end 
			self.Exploded = true
			self:Explode()
		end)
	end
end

function ENT:PhysicsCollide( data, physobj )
	if self.Exploded or self.Life <= 0 or data.Speed < self.ImpactSpeed then return end
	
	if gred.CVars["gred_sv_fragility"]:GetInt() >= 1 and !self.Arming and !self.Armed then
		self:EmitSound(damagesound)
		self:Arm()
	end
	
	if self.ShouldExplodeOnImpact and self.Armed then
		self.Exploded = true
		self:Explode(data.HitPos)
	end
end

function ENT:Arm()
	if self.Exploded or self.Armed then return end
	self.Arming = true
	self.Used = true
	
	timer.Simple(self.ArmDelay,function()
	    if !IsValid(self) then return end
	    self.Armed = true
		self.Arming = false
		self:EmitSound(self.ArmSound)
		if self.Timed or self.JDAM then
			if self.JDAM then self.Timer = 20 end
			timer.Simple(self.Timer,function()
				if !IsValid(self) then return end 
				timer.Simple(math.Rand(0,self.MaxDelay),function()
					if !IsValid(self) then return end 
					self.Exploded = true
					self:Explode()
				end)
		   end)
	    end
	end)
end	 

function ENT:Use( activator, caller )
	if !self.Exploded and gred.CVars["gred_sv_easyuse"]:GetInt() >= 1 and !self.Armed and !self.Used then
		self:EmitSound(self.ActivationSound)
		self:Arm()
	end
end

function ENT:OnRemove()
	 self:StopParticles()
	 self:StopSound("bombSND")
	-- Wire_Remove(self)
end

if !SERVER then
	function ENT:Draw()
	    self:DrawModel()
		if WireAddon then Wire_Render(self.Entity) end
	end
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