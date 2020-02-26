AddCSLuaFile("gredwitch/gred_autorun_shared.lua")
include("gredwitch/gred_autorun_shared.lua")

local util = util
local pairs = pairs
local table = table
local istable = istable
local IsInWorld = util.IsInWorld
local TraceLine = util.TraceLine
local QuickTrace = util.QuickTrace
local Effect = util.Effect
local MASK_ALL = MASK_ALL
local tableinsert = table.insert
local IsValid = IsValid
local DMG_BLAST = DMG_BLAST

gred = gred or {}
gred.CVars = gred.CVars or {}


local AddNetworkString = util.AddNetworkString
AddNetworkString("gred_net_checkconcommand")
AddNetworkString("gred_net_check_binding_simfphys")
AddNetworkString("gred_net_sound_lowsh")
AddNetworkString("gred_net_message_ply")
AddNetworkString("gred_net_bombs_decals")
AddNetworkString("gred_net_nw_var")
AddNetworkString("gred_net_createtracer")
AddNetworkString("gred_net_createimpact")
AddNetworkString("gred_net_createparticle")
AddNetworkString("gred_net_impact")
AddNetworkString("gred_lfs_setparts")
AddNetworkString("gred_lfs_remparts")
AddNetworkString("gred_net_registertank")
AddNetworkString("gred_net_tank_setsight")
AddNetworkString("gred_net_send_ply_hint_key")
AddNetworkString("gred_net_send_ply_hint_simple")

local OverrideHAB 		= gred.CVars["gred_sv_override_hab"]
local Tracers 			= gred.CVars["gred_sv_tracers"]
local BulletDMG 		= gred.CVars["gred_sv_bullet_dmg"]
local HE12MM 			= gred.CVars["gred_sv_12mm_he_impact"]
local HE7MM 			= gred.CVars["gred_sv_7mm_he_impact"]
local HERADIUS 			= gred.CVars["gred_sv_bullet_radius"]
local SoundAdd 			= sound.Add
local NoCollide 		= constraint.NoCollide
local BulletID 			= 0
local angle_zero 		= angle_zero
local vector_zero 		= Vector(0,0,0)
local startsWith = string.StartWith
local soundSpeed = 18005.25*18005.25 -- 343m/s
local IN_USE = IN_USE
local CAL_TABLE = {
	["wac_base_7mm"] = 1,
	["wac_base_12mm"] = 2,
	["wac_base_20mm"] = 3,
	["wac_base_30mm"] = 4,
	["wac_base_40mm"] = 5,
}
local COL_TABLE = {
	["red"]    = 1,
	["green"]  = 2,
	["white"]  = 3,
	["yellow"] = 4,
}
local bad = {
	["prop_vehicle_prisoner_pod"] = true,
	["gmod_dynamite"] = true,
}
local badclass = {
	["gmod_sent_vehicle_fphysics_wheel"] = true,
	["prop_vehicle_prisoner_pod"] = true,
}

local opcal = {
	["wac_base_20mm"] = true,
	["wac_base_30mm"] = true,
	["wac_base_40mm"] = true,
}

local function CreateExplosion(ply,pos,radius,dmg,cal)
	local sqrR = radius*radius
	local dmginfo = DamageInfo()
	dmginfo:SetAttacker(ply)
	dmginfo:SetDamagePosition(pos)
	dmginfo:SetDamageType(CAL_TABLE[cal] > 2 and 64 or 2) -- DMG_BLAST or DMG_BULLET
	
	for k,v in pairs(ents.FindInSphere(pos,radius)) do
		if !(v.InVehicle and v:InVehicle()) and !bad[v:GetClass()] and (!(v.IsOnPlane and !v.Armed) or !v.IsOnPlane) then
			dmginfo:SetDamage(math.abs(1-math.Clamp(v:GetPos():DistToSqr(pos),0,sqrR)/sqrR)*(v.GRED_ISTANK and dmg * (opcal[cal] and 1 or 0.2) or dmg))
			v:TakeDamageInfo(dmginfo)
		end
	end
end

local function BulletExplode(ply,NoBullet,tr,cal,filter,ang,NoParticle,explodable,dmg,radius,fusetime)
	ply = IsValid(ply) and ply or Entity(0)
	local hitang
	local hitpos
	local HitSky = false
	if istable(tr) then -- if tr isn't a table, then it's a vector
		hitang = tr.HitNormal:Angle()
		hitpos = tr.HitPos
		if cal == "wac_base_7mm" then
			hitang:Add(Angle(90))
		end
		HitSky = tr.HitSky
	else
		hitang = angle_zero
		hitpos = tr
		HitSky = true
	end
	if not explodable then
		if HitSky then return end
		local shouldExplode = (cal == "wac_base_12mm" and  HE12MM:GetInt() == 1) or (cal == "wac_base_7mm" and  HE7MM:GetInt() == 1)
		if !NoBullet then
			local bullet = {}
			bullet["Attacker"] = ply
			bullet["Callback"] = nil
			bullet["Damage"] = shouldExplode and 0 or dmg
			bullet["Force"] = 5
			bullet["HullSize"] = 0
			bullet["Num"] = 1
			bullet["Tracer"] = 0
			bullet["AmmoType"] = nil
			bullet["TracerName"] = nil
			bullet["Dir"] = ang:Forward()
			bullet["Spread"] = vector_zero
			bullet["Src"] = hitpos
			bullet["IgnoreEntity"] = filter
			ply:FireBullets(bullet,false)
		end
		if shouldExplode then
			-- util.BlastDamage(ply,ply,hitpos,radius,dmg)
			CreateExplosion(ply,hitpos,radius,dmg,cal)
		end
		if !NoParticle then
			net.Start("gred_net_createimpact")
				-- local tab = {hitpos,hitang}
				net.WriteVector(hitpos)
				net.WriteAngle(hitang)
				if cal == "wac_base_7mm" then
					-- tableinsert(tab,gred.Mats[util.GetSurfacePropName(tr.SurfaceProps)] or 24)
					net.WriteInt(gred.Mats[util.GetSurfacePropName(tr.SurfaceProps)] or 24,4)
				else
					-- tableinsert(tab,0)
					net.WriteInt(0,4)
				end
				-- tableinsert(tab,1)
				net.WriteInt(1,4)
				-- tableinsert(tab,table.KeyFromValue(gred.Calibre,cal))
				net.WriteInt(table.KeyFromValue(gred.Calibre,cal),4)
				
				-- tab = util.TableToJSON(tab)
				-- net.WriteString(tab)
			net.Broadcast()
		end
		
		if cal == "wac_base_12mm" then
			sound.Play("impactsounds/gun_impact_"..math.random(1,14)..".wav",hitpos,75,100,0.5)
		end
	else
		if cal == "wac_base_30mm" then
			sound.Play("impactsounds/30mm_old.wav",hitpos,110,math.random(90,110),1)
		elseif cal == "wac_base_20mm" then
			sound.Play("impactsounds/20mm_0"..math.random(1,5)..".wav",hitpos,100,100,0.7)
		else
			sound.Play("impactsounds/20mm_0"..math.random(1,5)..".wav",hitpos,100,100,0.7)
		end
		if !HitSky and !NoBullet then
			local bullet = {}
			bullet.Damage = 0
			bullet.Attacker = ply
			bullet.Callback = nil
			bullet.Damage = 0
			bullet.Force = 100
			bullet.HullSize = 0
			bullet.Num = 1
			bullet.Tracer = 0
			bullet.AmmoType = nil
			bullet.TracerName = nil
			bullet.Dir = ang:Forward()
			bullet.Spread = vector_zero
			bullet.Src = hitpos
			bullet.IgnoreEntity = filter
			ply:FireBullets(bullet,false)
		else
			radius = radius * 2
		end
		CreateExplosion(ply,hitpos,radius,dmg,cal)
		-- util.BlastDamage(ply,ply,hitpos,radius,dmg)
		if !NoParticle then
			net.Start("gred_net_createimpact")
				net.WriteVector(hitpos)
				if !HitSky then 
					net.WriteAngle(hitang)
					net.WriteInt(0,4)
				else 
					net.WriteAngle(hitang)
					net.WriteInt(1,4)
				end
				net.WriteInt(1,4)
				net.WriteInt(table.KeyFromValue(gred.Calibre,cal),4)
			net.Broadcast()
		end
	end
end

local function GetSeatID(ply,ent)
	if !ent.pSeats then return end
	if ply == ent:GetDriver() then return 0 end
	for k,v in pairs(ent.pSeats) do
		if ply == v:GetDriver() then return k end
	end
end

local function IsSmall(k)
	return startsWith(k,"gear") or startsWith(k,"wheel") or startsWith(k,"airbrake")
end



gred.GunnersInit = function(self)
	local ATT
	local seat
	for k,v in pairs(self.Gunners) do
	
		v.tracer = 0
		v.UpdateTracers = function(self)
			v.tracer = v.tracer + 1
			if v.tracer >= self.TracerConvar:GetInt() then
				v.tracer = 0
				return "red"
			else
				return false
			end
		end
		for a,b in pairs(v.att) do
			v.att[a] = self:LookupAttachment(b)
		end
		seat = self:AddPassengerSeat(v.pos,v.ang)
		seat.Shoot = v.snd_loop and CreateSound(seat,v.snd_loop) or nil
		seat.Stop = v.snd_stop and CreateSound(seat,v.snd_stop) or nil
		self["SetGunnerSeat"..k](self,seat)
	end
end

gred.GunnersTick = function(self,Driver,DriverSeat,DriverFireGunners,ct,IsShooting)
	ct = ct and ct or CurTime()
	Driver = Driver and Driver or self:GetDriver()
	DriverSeat = DriverSeat and DriverSeat or self:GetDriverSeat()
	DriverFireGunners = DriverFireGunners != nil and DriverFireGunners or (IsValid(Driver) and Driver:lfsGetInput("FREELOOK") and Driver:KeyDown(IN_ATTACK))
	local ang
	local pod
	local gunner
	local gunnerValid
	local shootAng
	local tracer
	local gunnerpod
	local IsDriver
	local selfAngle = self:GetAngles()
	selfAngle:Normalize()
	for k,v in pairs(self.Gunners) do
		pod = self["GetGunnerSeat"..k](self)
		gunnerpod = pod
		if IsValid(pod) then
			gunner = pod:GetDriver()
			gunnerValid = IsValid(gunner)
			if gunnerValid or (!gunnerValid and DriverFireGunners) then
				gunner = gunnerValid and gunner or Driver
				IsDriver = gunner == Driver
				pod = IsDriver and DriverSeat or pod
				
				IsShooting = IsShooting or gunner:KeyDown(IN_ATTACK)
				
				for C,att in pairs(v.att) do
					att = self:GetAttachment(att)
					if C == 1 then
						ang = pod:WorldToLocalAngles(gunner:EyeAngles())
						ang:Normalize() 
						ang = v.AngleOperate(self:WorldToLocalAngles(ang),IsDriver,selfAngle)
						ang:Normalize()
						self:SetPoseParameter(v.poseparams[1],ang.p)
						self:SetPoseParameter(v.poseparams[2],ang.y)
						if (ang.y > v.maxang.y or ang.p > v.maxang.p or ang.y < v.minang.y or ang.p < v.minang.p) and DriverFireGunners then break end
						if IsShooting and v.nextshot <= ct then
							tracer = v.UpdateTracers(self)
						end
					end
					if IsShooting then
						v.IsShooting = true
						if gunnerpod.Stop then
							gunnerpod.Stop:Stop()
						else
							gunnerpod.Shoot:Stop()
						end
						gunnerpod.Shoot:Play()
						if v.nextshot <= ct then
							v.spread = v.spread and v.spread or 0.3
							shootAng = att.Ang + Angle(math.Rand(-v.spread,v.spread), math.Rand(-v.spread,v.spread), math.Rand(-v.spread,v.spread))
							
							gred.CreateBullet(gunner,att.Pos,shootAng,v.cal,self.FILTER,nil,false,tracer)
							
							local effectdata = EffectData()
							effectdata:SetFlags(self.MUZZLEEFFECT)
							effectdata:SetOrigin(att.Pos)
							effectdata:SetAngles(shootAng)
							effectdata:SetSurfaceProp(0)
							util.Effect("gred_particle_simple",effectdata)
							if C == #v.att or v.Sequential then
								v.nextshot = ct + v.delay
							end
						end
					else
						if v.IsShooting then
							v.IsShooting = false
							if gunnerpod.Stop then
								gunnerpod.Stop:Play()
								gunnerpod.Shoot:Stop()
							end
						end
					end
				end
			else
				if v.IsShooting then
					v.IsShooting = false
					if gunnerpod.Stop then
						gunnerpod.Stop:Play()
						gunnerpod.Shoot:Stop()
					end
				end
			end
		end
		
		pod = nil
		gunner = nil
	end
end

gred.HandleActiveGunners = function(self)
	local gpod
	local gunner
	for k,v in pairs(self.Gunners) do
		gpod = self["GetGunnerSeat"..k](self)
		if IsValid(gpod) then
			local Gunner = gpod:GetDriver()
			
			gunner = self["GetGunner"..k](self)
			if Gunner ~= gunner then
				self:SetGunner( Gunner )
				
				if IsValid( Gunner ) then
					Gunner:CrosshairEnable() 
				end
			end
		end
	end
end

gred.CreateExplosion = function(pos,radius,damage,decal,trace,ply,bomb,DEFAULT_PHYSFORCE,DEFAULT_PHYSFORCE_PLYGROUND,DEFAULT_PHYSFORCE_PLYAIR)
	local ConVar = gred.CVars["gred_sv_shockwave_unfreeze"]:GetInt() >= 1
	
	net.Start("gred_net_bombs_decals")
		net.WriteString(decal and decal or "scorch_medium")
		net.WriteVector(pos)
		net.WriteVector(pos-Vector(0,0,trace))
	net.Broadcast()
	
	debugoverlay.Sphere(pos,radius,3, Color( 255, 255, 255 ))
	
	local bombvalid = IsValid(bomb)
	ply = IsValid(ply) and ply or (bombvalid and bomb or Entity(0))
	util.BlastDamage(!bombvalid and ply or bomb,ply,pos,radius,damage)
	
	local v_pos
	local phys
	local F_dir
	local massmul
	
	for k,v in pairs(ents.FindInSphere(pos,radius)) do
		v_pos = v:GetPos()
		phys = v:GetPhysicsObject()
		
		if !badclass[v:GetClass()] and !v.IsOnPlane and IsValid(phys) and !IsValid(v:GetParent()) then
			massmul = 1/phys:GetMass()
			
			phys:AddAngleVelocity(Vector(DEFAULT_PHYSFORCE, DEFAULT_PHYSFORCE, DEFAULT_PHYSFORCE) * math.Clamp((radius - (pos - v_pos):Length()) / radius,0,1) * massmul)
			phys:AddVelocity((DEFAULT_PHYSFORCE and (v_pos - pos) * DEFAULT_PHYSFORCE or (v_pos - pos))*massmul)
			if ConVar and !v.isWacAircraft and !v.LFS then
				phys:Wake()
				phys:EnableMotion(true)
				if !(bomb.ShellType and simfphys and simfphys.IsCar(v)) then
					constraint.RemoveAll(v)
				end
			end
			
			-- local class = v:GetClass()
			-- if class == "func_breakable" or class == "func_breakable_surf" or class == "func_physbox" then
				-- v:Fire("Break", 0)
			-- end
		end
		
		if v:IsPlayer() then
			v:SetMoveType(MOVETYPE_WALK)
			v:SetVelocity(v:IsOnGround() and (!DEFAULT_PHYSFORCE_PLYGROUND and (v_pos - pos) or (v_pos - pos) * DEFAULT_PHYSFORCE_PLYGROUND) or (!DEFAULT_PHYSFORCE_PLYAIR and (v_pos - pos) or (v_pos - pos) * DEFAULT_PHYSFORCE_PLYAIR))
		end
	end
end

gred.CreateSound = function(pos,rsound,e1,e2,e3)
	local currange = 1000 / gred.CVars["gred_sv_soundspeed_divider"]:GetInt()
	
	local curRange_min = currange*5
	curRange_min = curRange_min*curRange_min
	local curRange_mid = currange*14
	curRange_mid = curRange_mid * curRange_mid
	local curRange_max = currange*40
	curRange_max = curRange_max * curRange_max
	
	for k,v in pairs(player.GetHumans()) do
		local ply = v:GetViewEntity()
		local distance = ply:GetPos():DistToSqr(pos)
		
		if distance <= curRange_min then
		
			if v:GetInfoNum("gred_sound_shake",1) == 1 then
				util.ScreenShake(v:GetPos(),9999999,55,1.5,50)
			end
			
			net.Start("gred_net_sound_lowsh")
				net.WriteString(e1)
			net.Send(v)
			
		elseif distance <= curRange_mid then
			timer.Simple(distance/soundSpeed,function()
				if v:GetInfoNum("gred_sound_shake",1) == 1 then
					util.ScreenShake(v:GetPos(),9999999,55,1.5,50)
				end
				net.Start("gred_net_sound_lowsh")
					net.WriteString(!rsound and e2 or e1)
				net.Send(v)
			end)
		elseif distance <= curRange_max then
			timer.Simple(distance/soundSpeed,function()
				net.Start("gred_net_sound_lowsh")
					net.WriteString(!rsound and e3 or e1)
				net.Send(v)
			end)
		end
	end
end

gred.CreateBullet = function(ply,pos,ang,cal,filter,fusetime,NoBullet,tracer,dmg,radius)
	if hab and hab.Module.PhysBullet and OverrideHAB:GetInt() == 0 then
		local bullet = {}
		bullet.AmmoType		= cal..(tracer and tracer or "")
		bullet.Num 			= 1
		bullet.Src 			= pos
		bullet.Dir 			= ang:Forward()
		bullet.Spread 		= vector_zero
		bullet.Tracer		= 0--tracer and 0 or 1
		bullet.IsNetworked	= true
		bullet.IgnoreEntity = filter
		bullet.Distance		= false
		bullet.Damage		= ((cal == "wac_base_7mm" and HE7MM:GetInt() >= 1) or (cal == "wac_base_12mm" and HE12MM:GetInt() >= 1)) and 0 or (dmg and dmg or (cal == "wac_base_7mm" and 40 or (cal == "wac_base_12mm" and 60 or (cal == "wac_base_20mm" and 80 or (cal == "wac_base_30mm" and 100 or (cal == "wac_base_40mm" and 120)))))) * BulletDMG:GetFloat()
		bullet.Force		= bullet.Damage*0.1
		ply:FirePhysicalBullets(bullet)
	else
		World = IsValid(World) or Entity(0)
		BulletID = BulletID + 1
		local ct = CurTime()
		local speed = cal == "wac_base_7mm" and 1500 or (cal == "wac_base_12mm" and 1300 or (cal == "wac_base_20mm" and 950 or (cal == "wac_base_30mm" and 830 or (cal == "wac_base_40mm" and 680))))
		local dmg = (dmg and dmg or (cal == "wac_base_7mm" and 40 or (cal == "wac_base_12mm" and 60 or (cal == "wac_base_20mm" and 80 or (cal == "wac_base_30mm" and 100 or (cal == "wac_base_40mm" and 120)))))) * BulletDMG:GetFloat()
		local radius = (radius and radius or 70) * HERADIUS:GetFloat()
		radius = (cal == "wac_base_7mm" and radius or (cal == "wac_base_12mm" and radius or (cal == "wac_base_20mm" and radius*2 or (cal == "wac_base_30mm" and radius*3 or (cal == "wac_base_40mm" and radius*4)))))
		local orpos = pos
		local expltime = fusetime and ct + fusetime or nil
		local fwd = ang:Forward()
		local oldpos = orpos - fwd * speed
		local explodable = cal == "wac_base_20mm" or cal == "wac_base_30mm" or cal == "wac_base_40mm"
		local dif
		local NoParticle
		local oldbullet = BulletID
		
		if tracer then
			net.Start("gred_net_createtracer")
				net.WriteVector(pos)
				net.WriteInt(CAL_TABLE[cal],4)
				net.WriteInt(COL_TABLE[tracer],4)
				net.WriteVector(expltime and QuickTrace(pos,fwd*(fusetime*speed),filter).HitPos or QuickTrace(pos,fwd*99999999999999,filter).HitPos)
			net.Broadcast()
		end
		timer.Create("gred_bullet_"..oldbullet,0,0,function()
			dif = pos + pos - oldpos
			oldpos = pos
			local tr = TraceLine({start = pos,endpos = dif,filter = filter,mask = MASK_ALL})
			if tr.MatType == 83 then
				net.Start("gred_net_createimpact")
					net.WriteVector(tr.HitPos)
					net.WriteAngle(angle_zero)
					net.WriteInt(0,4)
					net.WriteInt(0,4)
					net.WriteInt(table.KeyFromValue(gred.Calibre,cal),4)
				net.Broadcast()
				
				NoParticle = true
				sound.Play("impactsounds/water_bullet_impact_0"..math.random(1,5)..".wav",pos,75,100,1)
			end
			
			if tr.Hit then
				BulletExplode(ply,NoBullet,tr,cal,filter,ang,NoParticle,explodable,dmg,radius,fusetime)
				timer.Remove("gred_bullet_"..oldbullet)
				return
			else
				if !IsInWorld(dif) then
					if explodable then 
						BulletExplode(ply,NoBullet,tr,cal,filter,ang,NoParticle,explodable,dmg,radius,fusetime)
					end
					timer.Remove("gred_bullet_"..oldbullet)
				else
					pos = dif
				end
			end
			if expltime and CurTime() >= expltime then
				BulletExplode(ply,NoBullet,pos,cal,filter,ang,NoParticle,explodable,dmg,radius,fusetime)
				timer.Remove("gred_bullet_"..oldbullet)
				return
			end
		end)
	end
end

gred.InitAircraftParts = function(self,ForceToDestroy)
	self.Attachements = {}
	self.Parts = {}
	local tostring = tostring
	local pairs = pairs
	local GetModel = GetModel
	
	for k,v in pairs (self:GetAttachments()) do
		self.Attachements[v.name] = self:LookupAttachment(tostring(v.name))
	end
	for k,v in pairs(self.Attachements) do
		if k != "blister" then
			local ent = ents.Create("gred_prop_part")
			ent.ForceToDestroy = ForceToDestroy or 1000
			ent:SetModel(self:GetPartModelPath(k))
			ent:SetPos(self:GetAttachment(self.Attachements[k]).Pos)
			ent:SetAngles(self:GetAngles())
			ent:SetParent(self,self.Attachements[k])
			if k == "tail" then
				ent.MaxHealth = self.TailHealth and self.TailHealth or 1100
			elseif k == "wing_r" or k == "wing_l" then
				ent.MaxHealth = self.WingHealth and self.WingHealth or 600
				ent.Mass = 500
			elseif IsSmall(k) then
				ent.MaxHealth = self.SmallPartHealth and self.SmallPartHealth or 100
			else
				ent.MaxHealth = self.PartHealth and self.PartHealth or 350
			end
			ent.CurHealth = ent.MaxHealth
			ent:Spawn()
			ent:Activate()
			self.Parts[k] = ent
		end
	end
	self.GibModels = self.GibModels or {}
	self.FILTER = {self}
	for k,v in pairs(self.Parts) do
		table.insert(self.FILTER,v)
		v.Parts = self.Parts
		v.Plane = self
		self.GibModels[k] = v:GetModel()
		v.PartParent = self.PartParents[k] and self.Parts[self.PartParents[k]] or self
	end
	self.LOADED = 1
end

gred.PartCalcFlight = function(self,Pitch,Yaw,Roll,Stability,AddRoll,AddYaw)
	AddRoll = AddRoll or 0.3
	AddYaw = AddYaw or 0.2
	local addRoll = 0
	local addYaw = 0
	local vel = self:GetVelocity():Length()
	if not self.Parts.elevator then
		Pitch = 0
	end
	if not self.Parts.rudder then
		Yaw = 0
	end
	if not self.Parts.wing_l then
		addRoll = AddRoll*vel
		addYaw = vel*AddYaw
	end
	if not self.Parts.wing_r then
		addRoll = !self.Parts.wing_l and addRoll or -AddRoll*vel
		addYaw = !self.Parts.wing_l and addYaw*2 or -vel*AddYaw
		Pitch = !self.Parts.wing_l and addYaw or Pitch
	end
	if not self.Parts.aileron_l then
		if Roll < 0 then Roll = Roll*0.5 end
	end
	if not self.Parts.aileron_r then
		if Roll > 0 then Roll = Roll*0.5 end
	end
	if not self.Parts.tail then
		Pitch = AddYaw*vel*10
		addYaw = addYaw + Pitch*0.3
		addRoll = addRoll + addYaw
	end
	Roll = Roll + addRoll
	Yaw = Yaw + addYaw
	return Pitch,Yaw,Roll,Stability,Stability,Stability
end

gred.PartThink = function(self,skin)
	if self.LOADED == 1 then
		for k,v in pairs(self.Parts) do
			self:DeleteOnRemove(v)
			NoCollide(v,self,0,0)
			NoCollide(v,self.wheel_R,0,0)
			NoCollide(v,self.wheel_L,0,0)
			NoCollide(v,self.wheel_C,0,0)
			NoCollide(v,self.wheel_C_master,0,0)
			if k == "tail" or k == "wing_l" or k == "wing_r" then
				v:SetParent(nil)
				v:SetPos(self:GetAttachment(self.Attachements[k]).Pos)
				v.Weld = constraint.Weld(v,self,0,0,0,true,false)
			end
			for a,p in pairs(self.Parts) do
				NoCollide(v,p,0,0)
			end
			v.LOADED = true
			v.PartName = k
		end
		net.Start("gred_lfs_setparts")
			net.WriteEntity(self)
			net.WriteTable(self.Parts)
		net.Broadcast()
		self.LOADED = true
	end
	skin = skin and skin or self:GetSkin()
	for k,v in pairs(self.Parts) do
		if not IsValid(v) then
			if k == "wheel_c" or k == "wheel_b" then
				self.wheel_C:Remove()
				self.wheel_C_master:Remove()
			end
			if k == "wheel_r" then
				self.wheel_R:Remove()
			end
			if k == "wheel_l" then
				self.wheel_L:Remove()
			end
			net.Start("gred_lfs_remparts")
				net.WriteEntity(self)
				net.WriteString(k)
			net.Broadcast()
			self.Parts[k] = nil
			self.GibModels[k] = nil
			k = nil
		return end
		if !v.PartParent or !IsValid(v.PartParent) or v.PartParent.Destroyed then
			v.CurHealth = 0
			v.DONOTEMIT = true
		end
		if v.CurHealth <= v.MaxHealth/2 then
			if not table.HasValue(self.DamageSkin,skin) then
				v:SetSkin(skin+1)
			end
			if v.CurHealth <=0 then
				if k == "wheel_c" or k == "wheel_b" then
					self.wheel_C:Remove()
					self.wheel_C_master:Remove()
				end
				if k == "wheel_r" then
					self.wheel_R:Remove()
				end
				if k == "wheel_l" then
					self.wheel_L:Remove()
				end
				constraint.RemoveAll(v)
				if not v.DONOTEMIT then
					v:EmitSound("LFS_PART_DESTROYED_0"..math.random(1,3))
				end
				v:SetParent(nil)
				v:SetVelocity(self:GetVelocity())
				v.Destroyed = true
				self.Parts[k] = nil
				self.GibModels[k] = nil
			end
			net.Start("gred_lfs_remparts")
				net.WriteEntity(self)
				net.WriteString(k)
			net.Broadcast()
		else
			if table.HasValue(self.DamageSkin,skin) then
				v:SetSkin(skin-1)
			else
				v:SetSkin(skin)
			end
		end
	end
end

gred.HandleLandingGear = function(self,animName)
	if not self.CurSeq then
		self.CurSeq = self:GetSequenceName(self:GetSequence())
	end
	if self.CurSeq != animName then
		self:ResetSequence(animName)
		self.CurSeq = self:GetSequenceName(self:GetSequence())
	end
	self:SetCycle(self:GetLGear())
end

gred.CreateShell = function(pos,ang,ply,filter,caliber,shelltype,muzzlevelocity,mass,color,dmg,callback,tntequivalent,explosivemass,linearpenetration,normalization,CoreMass) -- EXPLOSIVE MASS AND TNT EQUIVALENT IN KILOGRAMS!
	local ent = ents.Create("base_shell")
	ent:SetPos(pos)
	ent:SetAngles(ang)
	ent:SetOwner(ply)
	ent.Caliber = caliber
	ent.ShellType = shelltype
	ent.MuzzleVelocity = muzzlevelocity
	ent.TNTEquivalent = tntequivalent
	ent.ExplosiveMass = explosivemass
	ent.LinearPenetration = linearpenetration
	ent.Normalization = normalization or 0
	ent.CoreMass = CoreMass
	ent.Mass = mass
	ent.Filter = filter
	ent.IsOnPlane = true
	ent.TracerColor = color or "white"
	ent.ExplosionDamageOverride = dmg
	
	if callback then
		callback(ent)
	end
	
	ent:Spawn()
	ent:Activate()
	ent:SetBodygroup(1,shelltype == "AP" and 0 or 1)
	
	for k,v in pairs(filter) do
		NoCollide(v,ent,0,0)
	end
	
	return ent
end

gred.TankInit = function(self,vehicle)
	vehicle.GRED_TANK = true
	vehicle:SetSkin(math.random(0,vehicle:SkinCount()))
	
	local tab = vehicle.pSeat and table.Copy(vehicle.pSeat) or {}
	table.insert(tab,vehicle:GetDriverSeat())
	
	timer.Simple(0.1,function()
		local shelltypes
		for _,seat in pairs(tab) do
			if seat:GetNWBool("HasCannon") then
				shelltypes = {}
				for K,V in pairs(seat.ShellTypes) do
					shelltypes[K] = {}
					for k,v in pairs(V) do
						table.insert(shelltypes[K],v.ShellType)
					end
				end
				seat:SetNWBool("simfphys_SpecialCam",true)
				seat:SetNWString("ShellTypes",util.TableToJSON(shelltypes))
			end
		end
	end)
	
	vehicle.TOQUECENTER_D = 0
	vehicle.TOQUECENTER_A = 0
	
	timer.Simple(1,function()
		if not IsValid(vehicle) then return end
		if not vehicle.VehicleData["filter"] then 
			print("[simfphys Armed Vehicle Pack] ERROR:TRACE FILTER IS INVALID. PLEASE UPDATE SIMFPHYS BASE") 
			return
		end
		local tab = gred.simfphys[vehicle:GetSpawn_List()]
		if tab.LeftTrackID != -1 and tab.RightTrackID != -1 then
			vehicle.HandBrakePower = 30
		end
		
		local health = math.ceil(vehicle:GetMaxHealth() * gred.CVars.gred_sv_simfphys_health_multplier:GetFloat())
		vehicle.MaxHealth = health
		vehicle:SetNWFloat("MaxHealth",health)
		vehicle:SetNWFloat("Health",health)
		vehicle:SetMaxHealth(health)
		vehicle:SetCurHealth(health)
		vehicle.WheelOnGround = function( ent )
			ent.FrontWheelPowered = ent:GetPowerDistribution() ~= 1
			ent.RearWheelPowered = ent:GetPowerDistribution() ~= -1
			
			for i = 1, table.Count( ent.Wheels ) do
				local Wheel = ent.Wheels[i]		
				if IsValid( Wheel ) then
					local dmgMul = Wheel:GetDamaged() and 0.5 or 1
					local surfacemul = simfphys.TractionData[Wheel:GetSurfaceMaterial():lower()]
					
					ent.VehicleData[ "SurfaceMul_" .. i ] = (surfacemul and math.max(surfacemul,0.001) or 1) * dmgMul
					
					local WheelPos = ent:LogicWheelPos( i )
					
					local WheelRadius = WheelPos.IsFrontWheel and ent.FrontWheelRadius or ent.RearWheelRadius
					local startpos = Wheel:GetPos()
					local dir = -ent.Up
					local len = WheelRadius + math.Clamp(-ent.Vel.z / 50,2.5,6)
					local HullSize = Vector(WheelRadius,WheelRadius,0)
					local tr = util.TraceHull( {
						start = startpos,
						endpos = startpos + dir * len,
						maxs = HullSize,
						mins = -HullSize,
						filter = ent.VehicleData["filter"]
					} )
					
					local onground = (self.IsOnGround and self:IsOnGround( vehicle )) and 1 or 0
					Wheel:SetOnGround( onground )
					ent.VehicleData[ "onGround_" .. i ] = onground
					
					if tr.Hit then
						Wheel:SetSpeed( Wheel.FX )
						Wheel:SetSkidSound( Wheel.skid )
						Wheel:SetSurfaceMaterial( util.GetSurfacePropName( tr.SurfaceProps ) )
					end
				end
			end
			
			local FrontOnGround = math.max(ent.VehicleData[ "onGround_1" ],ent.VehicleData[ "onGround_2" ])
			local RearOnGround = math.max(ent.VehicleData[ "onGround_3" ],ent.VehicleData[ "onGround_4" ])
			
			ent.DriveWheelsOnGround = math.max(ent.FrontWheelPowered and FrontOnGround or 0,ent.RearWheelPowered and RearOnGround or 0)
		end
		net.Start("gred_net_registertank")
			net.WriteEntity(vehicle)
		net.Broadcast()
		
		if tab and tab.UpdateSuspension_SV then
			local OldThink = vehicle.Think
			vehicle.Think = function(vehicle)
				tab.UpdateSuspension_SV(vehicle)
				return OldThink(vehicle)
			end
		end
	end)
end

gred.TankTurn = function(vehicle,MaxTurn,TorqueCenter,TorqueCenterRate,ForceMul)
	if vehicle:EngineActive() and vehicle.susOnGround then
		local phys = vehicle:GetPhysicsObject()
		if !IsValid(phys) then return end
		if !vehicle.ModelBounds then
			local mins,maxs = vehicle:GetModelBounds()
			vehicle.ModelBounds = {maxs = maxs,mins = mins}
		end
		local massvec
		local vel = phys:GetAngleVelocity()
		local gear = vehicle:GetGear()
		-- local mul = (ShouldNotGearMul or gear <= 2) and 1 or math.abs(gear-2)*0.5
		-- MaxTurn = MaxTurn * mul
		if gear == 2 and vehicle.NoIdleTurning then return end
		
		if gear > 3 then
			phys:ApplyForceOffset(vehicle:GetRight()*(vehicle.TOQUECENTER_D > vehicle.TOQUECENTER_A and -vehicle.TOQUECENTER_D or vehicle.TOQUECENTER_A)*ForceMul,Vector(0,0,vehicle.ModelBounds.maxs.z*0.5))
		end
		if math.abs(vel.z) <= MaxTurn then
			local var = gred.CVars.gred_sv_simfphys_turnrate_multplier:GetFloat()
			TorqueCenter = TorqueCenter * var
			TorqueCenterRate = TorqueCenterRate * var
			
			if (vehicle.PressedKeys.D and gear != 1) or (vehicle.PressedKeys.A and gear == 1) then
				massvec = Vector(0,0,phys:GetMass())
				vehicle.TOQUECENTER_D = math.Clamp(vehicle.TOQUECENTER_D+TorqueCenterRate,0,TorqueCenter)
				if gear == 2 then
					local torque = vehicle.TOQUECENTER_D*0.5
					vehicle.VehicleData["spin_3"] = vehicle.VehicleData[ "spin_3" ] + torque
					vehicle.VehicleData["spin_5"] = vehicle.VehicleData[ "spin_5" ] + torque
				end
				phys:ApplyTorqueCenter(massvec*-vehicle.TOQUECENTER_D)
			else
				vehicle.TOQUECENTER_D = 0
			end
			
			if (vehicle.PressedKeys.A and gear != 1) or (vehicle.PressedKeys.D and gear == 1) then
				massvec = massvec or Vector(0,0,phys:GetMass())
				vehicle.TOQUECENTER_A = math.Clamp(vehicle.TOQUECENTER_A+TorqueCenterRate,0,TorqueCenter)
				if gear == 2 then
					local torque = vehicle.TOQUECENTER_A*0.5
					vehicle.VehicleData["spin_4"] = vehicle.VehicleData[ "spin_4" ] + torque
					vehicle.VehicleData["spin_6"] = vehicle.VehicleData[ "spin_6" ] + torque
				end
				phys:ApplyTorqueCenter(massvec*vehicle.TOQUECENTER_A)
			else
				vehicle.TOQUECENTER_A = 0
			end
		end
		
		if !vehicle.PressedKeys.A and !vehicle.PressedKeys.D then
			massvec = massvec or Vector(0,0,phys:GetMass())
			phys:ApplyTorqueCenter(massvec*-vel.z)
		end
	end
end

gred.TankDestruction = function(ent,gib,ang,skin,pitch,yaw,CreateAmmoFire,StopAmmoFire,CreateExplosion,CreateTurret)
	--[[
		DESTRUCTION TYPES
		- 0 = Normal gib
		- 1 = Turret goes boom
		- 2 = Jet fire only
		- 3 = Jet fire and boom
		- 4 = Jet fire and boom and turret goes boom
		- 5 = Short jet fire and boom and turret goes boom
		- 6 = Turret and tank go boom
	]]
	
	if ent.DestructionType and ent.DestructionType != 0 then
		if ent.DestructionType == 1 then
			CreateTurret(gib,ang,pitch,yaw)
		elseif ent.DestructionType == 6 then
			local ang = gib:GetAngles()
			CreateExplosion(gib,ang)
			CreateTurret(gib,ang,pitch,yaw)
		else
			if ent.DestructionType == 2 then
				CreateAmmoFire(gib,ang)
				timer.Simple(4,function()
					if !IsValid(gib) then return end
					StopAmmoFire(gib)
					
					if IsValid(gib.particleeffect) then gib.particleeffect:Fire("Start") end
					if gib.FireSound then
						gib.FireSound:Play()
					end
				end)
			elseif ent.DestructionType == 3 then
				CreateAmmoFire(gib,ang)
				timer.Simple(math.Rand(2,3),function()
					if !IsValid(gib) then return end
					StopAmmoFire(gib)
					CreateExplosion(gib,gib:GetAngles())
					
					if IsValid(gib.particleeffect) then gib.particleeffect:Fire("Start") end
					if gib.FireSound then
						gib.FireSound:Play()
					end
				end)
			elseif ent.DestructionType == 4 then
				CreateAmmoFire(gib,ang)
				timer.Simple(math.Rand(2,3),function()
					if !IsValid(gib) then return end
					StopAmmoFire(gib)
					local ang = gib:GetAngles()
					CreateExplosion(gib,ang)
					CreateTurret(gib,ang,pitch,yaw)
					
					if IsValid(gib.particleeffect) then gib.particleeffect:Fire("Start") end
					if gib.FireSound then
						gib.FireSound:Play()
					end
				end)
			elseif ent.DestructionType == 5 then
				CreateAmmoFire(gib,ang)
				timer.Simple(math.Rand(0.5,1.3),function()
					if !IsValid(gib) then return end
					StopAmmoFire(gib)
					local ang = gib:GetAngles()
					CreateExplosion(gib,ang)
					CreateTurret(gib,ang,pitch,yaw)
					
					if IsValid(gib.particleeffect) then gib.particleeffect:Fire("Start") end
					if gib.FireSound then
						gib.FireSound:Play()
					end
				end)
			end
			local function RemoveGibFire(gib)
				if IsValid(gib) then
					if gib.particleeffect and IsValid(gib.particleeffect) then
						gib.particleeffect:Fire("Stop")
						gib:OnRemove()
					else
						timer.Simple(0.01,function()
							RemoveGibFire(gib)
						end)
					end
				end
			end
			timer.Simple(0.7,function()
				RemoveGibFire(gib)
			end)
		end
	end
end



numpad.Register("k_gred_shell",function(ply,ent,key,bool)
	if not IsValid(ply) or not IsValid(ent) then return false end
	ent[key] = bool
end)

numpad.Register("k_gred_sight",function(ply,ent,key,bool)
	if not IsValid(ply) or not IsValid(ent) then return false end
	ent[key] = bool
end)

numpad.Register("k_gred_gun",function(ply,ent,key,bool)
	if not IsValid(ply) or not IsValid(ent) then return false end
	ent[key] = bool
end)



hook.Add("KeyPress","gred_keypress_shellhold",function(ply,key)
	if key != IN_USE then return end
	timer.Simple(0,function()
		if !IsValid(ply) then return end
		local ent = ply:GetNWEntity("PickedUpObject")
		if !IsValid(ent) then return end
		if !ent:IsPlayerHolding() then 
			ply:SetNWEntity("PickedUpObject",Entity(0))
		end
	end)
end)

hook.Add("PlayerDeath","gred_playerdeath_shellhold",function(ply)
	ply:SetNWEntity("PickedUpObject",Entity(0))
end)

hook.Add("PlayerEnteredVehicle","gred_player_entervehicle_hint",function(ply,seat)
			ply.CHECKED_BINDING_SIMFPHYS = false
			ply.GRED_HINT_SIMFPHYS_01_DONE = false
	if (seat.vehiclebase or (ply.GetSimfphys and IsValid(ply:GetSimfphys()))) and seat:GetNWBool("HasCannon",false) then
		if !ply.CHECKED_BINDING_SIMFPHYS then
			net.Start("gred_net_check_binding_simfphys")
			net.Send(ply)
			ply.CHECKED_BINDING_SIMFPHYS = true
		elseif !ply.GRED_HINT_SIMFPHYS_01_DONE then
			timer.Simple(0.2,function()
				if !IsValid(ply) then return end
				net.Start("gred_net_send_ply_hint_key")
					net.WriteInt(ply:GetInfoNum("gred_cl_simfphys_key_togglesight",22),9)
					net.WriteString("' key to toggle the tank sight while the turret is activated")
				net.Send(ply)
				timer.Simple(5,function()
					if !IsValid(ply) then return end
					net.Start("gred_net_send_ply_hint_key")
						net.WriteInt(ply:GetInfoNum("gred_cl_simfphys_key_changeshell",21),9)
						net.WriteString("' key to toggle shell types - Use HE against infantry or unarmored vehicles and AP against armored vehicles")
					net.Send(ply)
					timer.Simple(5,function()
						if !IsValid(ply) then return end
						net.Start("gred_net_send_ply_hint_simple")
							net.WriteString("You can reload the tank by spawning an ammo box entity and by throwing the right shells at the tank")
						net.Send(ply)
						timer.Simple(5,function()
							if !IsValid(ply) then return end
							net.Start("gred_net_send_ply_hint_simple")
								net.WriteString("You can change the settings by going to the 'Gredwitch's Stuff' category in the top right 'Options' menu of the spawnmenu")
							net.Send(ply)
						end)
					end)
				end)
			end)
			ply.GRED_HINT_SIMFPHYS_01_DONE = true
		end
	elseif !ply.GRED_HINT_LFS_01_DONE and ply.lfsGetPlane then
		local plane = ply:lfsGetPlane()
		timer.Simple(0,function()
			if IsValid(ply) and IsValid(plane) and ply == plane:GetDriver() then
				net.Start("gred_net_send_ply_hint_simple")
					net.WriteString("Don't forget to check out the controls by going to the 'Controls' tab of the LFS Icon while holding the C key")
				net.Send(ply)
				timer.Simple(5,function()
					if !IsValid(ply) then return end
					net.Start("gred_net_send_ply_hint_simple")
						net.WriteString("You can change some settings by going to the 'Gredwitch's Stuff' category in the top right 'Options' menu of the spawnmenu")
					net.Send(ply)
				end)
				ply.GRED_HINT_LFS_01_DONE = true
			end
		end)
	end
end)

hook.Add("Initialize","gred_init_precache_sv",function()
	gred.Precache()
	if gred.CVars["gred_sv_resourceprecache"]:GetBool() then
		gred.PrecacheResources()
	end
	
	local TABLE = file.Read("gredwitch_base_config_sv.txt","DATA")
	if TABLE then
		TABLE = util.JSONToTable(TABLE)
		for k,v in pairs(TABLE) do
			if gred.CVars[k] then gred.CVars[k]:SetFloat(v) end
		end
	end
end)

net.Receive("gred_net_checkconcommand",function(len,ply)
	local str = net.ReadString()
	local cvar = gred.CVars[str]
	local val = net.ReadFloat()
	if !cvar then return end
	if !ply:IsAdmin() then return end
	cvar:SetFloat(val)
	
	local TABLE = file.Read("gredwitch_base_config_sv.txt","DATA")
	TABLE = TABLE and util.JSONToTable(TABLE) or {}
	TABLE[str] = val
	file.Write("gredwitch_base_config_sv.txt",util.TableToJSON(TABLE))
end)