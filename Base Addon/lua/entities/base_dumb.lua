AddCSLuaFile()
if SERVER then util.AddNetworkString("gred_net_gdumb_explosion_fx") end
if CLIENT then
	net.Receive("gred_net_gbombs_explosion_fx",function()
		ParticleEffect(net.ReadString(),net.ReadVector(),net.ReadAngle(),nil)
		if net.ReadBool() then
			ParticleEffect("doi_ceilingDust_large",net.ReadVector(),Angle(0,0,0),nil)
		end
	end)
end
DEFINE_BASECLASS( "base_anim" )

util.PrecacheSound( "BaseExplosionEffect.Sound" ) 

--[[
This is a base for vegetable entities which are not affected by bullets and shit.
OMFG STOP READING THIS!
--]]

local ExploSnds = {}
ExploSnds[1]                         =  "BaseExplosionEffect.Sound"

local Models = {}
Models[1]                            =  "model"

local damagesound                    =  "weapons/rpg/shotdown.wav"

ENT.Spawnable		            	 =  false         
ENT.AdminSpawnable		             =  false         

ENT.PrintName		                 =  "Name"       
ENT.Author			                 =  "Avatar natsu"     
ENT.Contact			                 =  "GTFO" 
ENT.Category                         =  "GTFO!"           

ENT.Model                            =  ""            
ENT.Effect                           =  ""            
ENT.EffectAir                        =  ""            
ENT.EffectWater                      =  ""           
ENT.ExplosionSound                   =  ""           
ENT.ParticleTrail                    =  ""
ENT.NBCEntity                        =  ""   

ENT.ShouldUnweld                     =  false        
ENT.ShouldIgnite                     =  false        
ENT.ShouldExplodeOnImpact            =  false        
ENT.Flamable                         =  false         
ENT.UseRandomSounds                  =  false             
ENT.UseRandomModels                  =  false
ENT.IsNBC                            =  false

ENT.ExplosionDamage                  =  0             
ENT.PhysForce                        =  0             
ENT.ExplosionRadius                  =  0             
ENT.SpecialRadius                    =  0             
ENT.MaxIgnitionTime                  =  5           
ENT.Life                             =  20            
ENT.MaxDelay                         =  2             
ENT.TraceLength                      =  500          
ENT.ImpactSpeed                      =  500          
ENT.Mass                             =  0                       
ENT.Shocktime                        =  1
ENT.RSound   						 =  1
ENT.GBOWNER                          =  nil             -- don't you fucking touch this.

ENT.DEFAULT_PHYSFORCE  = 0
ENT.DEFAULT_PHYSFORCE_PLYAIR  = 0
ENT.DEFAULT_PHYSFORCE_PLYGROUND = 0

function ENT:Initialize()
 if (SERVER) then
     self:LoadModel()
	 self:PhysicsInit( SOLID_VPHYSICS )
	 self:SetSolid( SOLID_VPHYSICS )
	 self:SetMoveType( MOVETYPE_VPHYSICS )
	 self:SetUseType( ONOFF_USE ) -- doesen't fucking work
	 local phys = self:GetPhysicsObject()
	 local skincount = self:SkinCount()
	 self.Armed = true
	 if (phys:IsValid()) then
		 phys:SetMass(self.Mass)
		 phys:Wake()
     end
	 if (skincount > 0) then
	     self:SetSkin(math.random(0,skincount))
	 end
	 self.Exploded = false
	end
end

function ENT:LoadModel()
     if self.UseRandomModels then
	     self:SetModel(table.Random(Models))
	 else
	     self:SetModel(self.Model)
	 end
end

function ENT:AddOnExplode()
end

function ENT:Explode()
	if !self.Exploded then return end
	local pos = self:LocalToWorld(self:OBBCenter())
	self:AddOnExplode()
	local ent = ents.Create("shockwave_ent")
	ent:SetPos( pos ) 
	ent:Spawn()
	ent:Activate()
	ent:SetVar("DEFAULT_PHYSFORCE", self.DEFAULT_PHYSFORCE)
	ent:SetVar("DEFAULT_PHYSFORCE_PLYAIR", self.DEFAULT_PHYSFORCE_PLYAIR)
	ent:SetVar("DEFAULT_PHYSFORCE_PLYGROUND", self.DEFAULT_PHYSFORCE_PLYGROUND)
	ent:SetVar("GBOWNER", self.GBOWNER)
	ent:SetVar("SHOCKWAVEDAMAGE",self.ExplosionDamage)
	ent:SetVar("MAX_RANGE",self.ExplosionRadius)
	ent:SetVar("SHOCKWAVE_INCREMENT",100)
	ent:SetVar("DELAY",0.01)
	ent.trace=self.TraceLength
	ent.decal=self.Decal
	
	net.Start("gred_net_gbombs_explosion_fx")
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
		end
		 
		if self.WaterExplosionSound == nil then else 
			self.ExplosionSound = self.WaterExplosionSound 
		end
		if self.WaterFarExplosionSound == nil then else  
			self.FarExplosionSound = self.WaterFarExplosionSound 
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
				net.WriteBool(true)
				net.WriteVector(pos-Vector(0,0,100))
			else
				net.WriteAngle(Angle(0,0,0))
			end
		else 
			net.WriteString(self.Effect)
			net.WriteVector(pos)
			if self.AngEffect then
				net.WriteAngle(Angle(-90,0,0))
			else
				net.WriteAngle(Angle(0,0,0))
			end
		end
    end
	net.Broadcast()
	
	local ent = ents.Create("shockwave_sound_lowsh")
	ent:SetPos( pos ) 
	ent:Spawn()
	ent:Activate()
	ent:SetVar("GBOWNER", self.GBOWNER)
	ent:SetVar("MAX_RANGE",self.ExplosionDamage*self.ExplosionRadius)
	if self.RSound == nil then ent:SetVar("NOFARSOUND",1) else
		ent:SetVar("NOFARSOUND",self.RSound) 
	end
	ent:SetVar("SHOCKWAVE_INCREMENT",200)
	
	ent:SetVar("DELAY",0.01)
	ent:SetVar("SOUNDCLOSE", self.ExplosionSound)
	ent:SetVar("SOUND", self.FarExplosionSound)
	ent:SetVar("SOUNDFAR", self.DistExplosionSound)
	ent:SetVar("Shocktime", 0)
	 
	 if self.IsNBC then
	     local nbc = ents.Create(self.NBCEntity)
		 nbc:SetVar("GBOWNER",self.GBOWNER)
		 nbc:SetPos(self:GetPos())
		 nbc:Spawn()
		 nbc:Activate()
	 end
     self:Remove()
end


function ENT:OnTakeDamage(dmginfo)
     if self.Exploded then return end
     self:TakePhysicsDamage(dmginfo)
	 
     if (self.Life <= 0) then return end

	 if self:IsValid() then
	     self.Life = self.Life - dmginfo:GetDamage()
		 if (self.Life <= self.Life/2) and !self.Exploded and self.Flamable then
		     self:Ignite(self.MaxDelay,0)
		 end
		 if (self.Life <= 0) then 
		     timer.Simple(math.Rand(0,self.MaxDelay),function()
			     if !self:IsValid() then return end 
			     self.Exploded = true
			     self:Explode()
			 end)
	     end
	end
end

function ENT:PhysicsCollide( data, physobj )
	timer.Simple(0,function()
		 if(self.Exploded) then return end
		 if(!self:IsValid()) then return end
		 if(self.Life <= 0) then return end

		 if self.ShouldExplodeOnImpact then
			 if (data.Speed > self.ImpactSpeed ) then
				 self.Exploded = true
				 self:Explode()
			 end
		 end
	end)
end

function ENT:OnRemove()
	 self:StopParticles()
end

if ( CLIENT ) then
     function ENT:Draw()
         self:DrawModel()
     end
end