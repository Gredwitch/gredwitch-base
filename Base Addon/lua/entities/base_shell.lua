AddCSLuaFile()
DEFINE_BASECLASS( "base_rocket" )

local materials = {
	canister				=	1,
	chain					=	1,
	chainlink				=	1,
	combine_metal			=	1,
	crowbar					=	1,
	floating_metal_barrel	=	1,
	grenade					=	1,
	metal					=	1,
	metal_barrel			=	1,
	metal_bouncy			=	1,
	Metal_Box				=	1,
	metal_seafloorcar		=	1,
	metalgrate				=	1,
	metalpanel				=	1,
	metalvent				=	1,
	metalvehicle			=	1,
	paintcan				=	1,
	roller					=	1,
	slipperymetal			=	1,
	solidmetal				=	1,
	strider					=	1,
	weapon					=	1,
	
	wood					=	2,
	wood_Box				=	2,
	wood_Crate 				=	2,
	wood_Furniture			=	2,
	wood_LowDensity 		=	2,
	wood_Plank				=	2,
	wood_Panel				=	2,
	wood_Solid				=	2,
}
local damagesound                    =  "weapons/rpg/shotdown.wav"

local SmokeSnds = {}
SmokeSnds[1]                         =  "gred_emp/nebelwerfer/artillery_strike_smoke_close_01.wav"
SmokeSnds[2]                         =  "gred_emp/nebelwerfer/artillery_strike_smoke_close_02.wav"
SmokeSnds[3]                         =  "gred_emp/nebelwerfer/artillery_strike_smoke_close_03.wav"
SmokeSnds[4]                         =  "gred_emp/nebelwerfer/artillery_strike_smoke_close_04.wav"

local APSounds = {}
APSounds[1]							 =  "impactsounds/ap_impact_01.wav"
APSounds[2]							 =  "impactsounds/ap_impact_02.wav"
APSounds[3]							 =  "impactsounds/ap_impact_03.wav"
APSounds[4]							 =  "impactsounds/ap_impact_04.wav"

local APWoodSounds = {}
APWoodSounds[1]							 =  "impactsounds/ap_impact_wood_01.wav"
APWoodSounds[2]							 =  "impactsounds/ap_impact_wood_02.wav"
APWoodSounds[3]							 =  "impactsounds/ap_impact_wood_03.wav"
APWoodSounds[4]							 =  "impactsounds/ap_impact_wood_04.wav"

local APSoundsDist = {}
APSoundsDist[1]							 =  "impactsounds/ap_impact_dist_01.wav"
APSoundsDist[2]							 =  "impactsounds/ap_impact_dist_02.wav"
APSoundsDist[3]							 =  "impactsounds/ap_impact_dist_03.wav"

local APMetalSounds = {}
APMetalSounds[1]							 =  "impactsounds/ap_impact_metal_01.wav"
APMetalSounds[2]							 =  "impactsounds/ap_impact_metal_02.wav"
APMetalSounds[3]							 =  "impactsounds/ap_impact_metal_03.wav"

ENT.Spawnable		            	 =  false
ENT.AdminSpawnable		             =  false

ENT.PrintName		                 =  "Gredwitch's Shell base"
ENT.Author			                 =  "Gredwitch"
ENT.Contact			                 =  "qhamitouche@gmail.com"
ENT.Category                         =  "Gredwitch's Stuff"

ENT.TOBEPRINTED						 =	0

ENT.Model                            =  ""
ENT.Effect                           =  ""
ENT.EffectAir                        =  ""
ENT.EffectWater                      =  ""
ENT.RocketTrail						 =	"grenadetrail"
    
ENT.NextUse							 =	0
ENT.ExplosionSound                   =  ENT.ExplosionSound
ENT.FarExplosionSound				 =  ENT.ExplosionSound
ENT.DistExplosionSound				 =  ENT.ExplosionSound
ENT.AngEffect						 =	false

ENT.WaterExplosionSound				 =	nil
ENT.WaterFarExplosionSound			 =  nil
    
ENT.StartSound                       =  ""
ENT.ArmSound                         =  ""
ENT.ActivationSound                  =  ""
ENT.EngineSound                      =  ""--"Missile.Ignite"
ENT.NBCEntity                        =  ""

ENT.ShouldUnweld                     =  false
ENT.ShouldIgnite                     =  false
ENT.UseRandomSounds                  =  false
ENT.SmartLaunch                      =  true
ENT.Timed                            =  false
ENT.IsNBC                            =  false

ENT.AP								 =  false
ENT.ExplosionDamage                  =  0
ENT.ExplosionRadius                  =  0
ENT.PhysForce                        =  ENT.ExplosionRadius / ENT.ExplosionDamage
ENT.SpecialRadius                    =  ENT.ExplosionDamage / ENT.ExplosionRadius
ENT.Life                             =  20
ENT.TraceLength                      =  25
ENT.ImpactSpeed                      =  50
ENT.Mass                             =  0
ENT.EnginePower                      =  200
ENT.FuelBurnoutTime                  =  0.7
ENT.IgnitionDelay                    =  0
ENT.RotationalForce                  =  0
ENT.ArmDelay                         =  0
ENT.ForceOrientation                 =  "NORMAL"
ENT.Timer                            =  0
ENT.Smoke							 =  false

ENT.RSound   						 =  1
ENT.ModelSize						 =	1
ENT.PlyPickup						 =	nil

ENT.GBOWNER                          =  nil             -- don't you fucking touch this.

function ENT:SetupDataTables()
	self:NetworkVar("Bool",0,"Fired")
	self:NetworkVar("Bool",1,"IsAP")
end

function ENT:AddOnInit()
	local m = GetConVar("gred_sv_shellspeed_multiplier"):GetFloat()
	if m > 0 then
		self.EnginePower = self.EnginePower * m
	end
	if !self.AP then 
		self:SetBodygroup(1,1)
		net.Start("gred_net_nw_var")
			net.WriteEntity(self)
			net.WriteString("ap")
			net.WriteInt(1,4)
			net.WriteString("false")
		net.Broadcast()
	else
		net.Start("gred_net_nw_var")
			net.WriteEntity(self)
			net.WriteString("ap")
			net.WriteInt(1,4)
			net.WriteString("true")
		net.Broadcast()
	end
	self:SetIsAP(self.AP)
	self:SetModelScale(self.ModelSize)
	if !(WireAddon == nil) then self.Inputs = Wire_CreateInputs(self, { "Arm", "Detonate", "Launch" }) end
end
local baseclass = baseclass.Get("base_rocket")
function ENT:Launch()
	baseclass.Launch(self)
	self:SetFired(self.Fired)
end

function ENT:AddOnExplode(pos) 
	if self.Smoke then
		self.ExplosionSound = table.Random(SmokeSnds)
		self.FarExplosionSound = self.ExplosionSound
		self.DistExplosionSound = ""
		self.RSound = 0
		self.Effect = self.SmokeEffect
		self.EffectAir = self.SmokeEffect
	elseif self.AP then
		self.Effect = "gred_ap_impact"
		self.EffectAir = "gred_ap_impact"
		self.ExplosionRadius = 100
		self.ExplosionDamage = self.APDamage
		self.PhysForce = 10
		self.Decal = "scorch_small"
	end
	if self:WaterLevel() < 1 then
		if self.AP then
			self.EffectAir = "AP_impact_wall"
			local fwd = self:GetForward()
			local tr = util.QuickTrace(pos - fwd*2,pos + pos-self:GetAngles():Forward()*1000,self.Entity)
			local hitmat = util.GetSurfacePropName(tr.SurfaceProps)
			if materials[hitmat] == 1 then
				self.Effect = "AP_impact_wall"
				self.ExplosionSound = table.Random(APMetalSounds)
				self.FarExplosionSound = table.Random(APMetalSounds)
				pos = tr.HitPos+(fwd*2)
			elseif materials[hitmat] == 2 then
				self.ExplosionSound = table.Random(APWoodSounds)
				self.FarExplosionSound = table.Random(APWoodSounds)
			else
				self.ExplosionSound = table.Random(APSounds)
				self.FarExplosionSound = table.Random(APSounds)
			end
		end
	end
end

function ENT:Use( activator, caller )
	local ct = CurTime()
	if self.NextUse >= ct then return end
    if(self.Exploded) then return end
	if(self.Dumb) then return end
	if self:IsPlayerHolding() then return end
	activator:PickupObject(self)
	self.PlyPickup = activator
	self.NextUse = ct + 0.1
end

function ENT:OnRemove()
	if self.PlyPickup != nil then
		self.PlyPickup:DropObject()
	end
    self:StopSound(self.EngineSound)
	self:StopParticles()
end

if CLIENT then
	local ply
	function ENT:Initialize()
		ply = LocalPlayer()
		self.shouldOwnerNotHearSnd = false
		self.snd = {}
		self.snd["wiz"] = CreateSound(self,"bomb/tank_shellwhiz.wav")
		self.snd["trail"] = CreateSound(self,"bomb/shell_trail.wav")
		timer.Simple(0.1,function()
			if !self:GetIsAP() then
				self.snd["wiz_mortar"] = CreateSound(self,"bomb/shellwhiz_mortar_"..math.random(1,2)..".wav")
			end
		end)
	end
	function ENT:Think()
		if !self.snd then self:Initialize() end
		if !self:GetFired() then return end
		local e = ply:GetViewEntity()
		if (e != self.GBOWNER and e != self.Owner) or self.shouldOwnerHearSnd then
			local pos=e:GetPos()
			local spos=self:GetPos()
			local val1=(pos:DistToSqr(spos+e:GetVelocity())-pos:DistToSqr(spos+self:GetVelocity()))*0.01
			local pitch = math.Clamp(val1, 0, 200)
			local volume = math.Clamp(pitch, 0,1)
			for k,v in pairs (self.snd) do
				v:Play()
				v:ChangePitch(pitch,math.random(3,10))
				v:ChangeVolume(volume,0.1)
				v:SetSoundLevel(140)
			end
		else
			for k,v in pairs (self.snd) do
				v:Stop()
			end
		end
	end
		
	function ENT:OnRemove()
		if self.snd then 
			for k,v in pairs (self.snd) do
				v:Stop()
				v = nil
			end
		end
	end
end