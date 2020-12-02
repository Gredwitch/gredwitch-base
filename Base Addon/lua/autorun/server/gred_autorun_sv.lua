AddCSLuaFile("gredwitch/gred_autorun_shared.lua")
AddCSLuaFile("gredwitch/gred_sh_simfphys_functions.lua")
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
AddNetworkString("gred_net_createwaterimpact")
AddNetworkString("gred_net_createtracer")
AddNetworkString("gred_net_createimpact")
AddNetworkString("gred_net_createparticle")
AddNetworkString("gred_lfs_setparts")
AddNetworkString("gred_lfs_remparts")
AddNetworkString("gred_net_send_ply_hint_key")
AddNetworkString("gred_net_send_ply_hint_simple")
AddNetworkString("gred_net_applyboolonsimfphys")
AddNetworkString("gred_net_applyboolonsimfphys_cl")
AddNetworkString("gred_net_applyfloatonsimfphys")
AddNetworkString("gred_net_applyfloatonsimfphys_cl")
AddNetworkString("gred_net_sound_new")

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
local startsWith 		= string.StartWith
local soundSpeed 		= 18005.25*18005.25 -- 343m/s
local IN_USE = IN_USE

local CAL_TABLE = {
	["wac_base_7mm"] = 1,
	["wac_base_12mm"] = 2,
	["wac_base_20mm"] = 3,
	["wac_base_30mm"] = 4,
	["wac_base_40mm"] = 5,
}
local COL_TABLE = {
	["none"]   = 0,
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

local function BulletExplode(ply,NoBullet,tr,cal,filter,ang,NoParticle,explodable,dmg,radius,fusetime,IsShared)
	ply = IsValid(ply) and ply or Entity(0)
	local hitang
	local hitpos
	local HitSky = false
	
	if istable(tr) then -- if tr isn't a table, then it's a vector
		hitang = tr.HitNormal:Angle()
		hitpos = tr.HitPos
		if cal == "wac_base_7mm" or cal == "wac_base_12mm" then
			hitang.p = hitang.p + 90
		end
		HitSky = tr.HitSky
	else
		hitang = angle_zero
		hitpos = tr
		HitSky = true
	end
	
	if not explodable then
		if HitSky then return end
		
		local shouldExplode = (cal == "wac_base_12mm" and  HE12MM:GetBool()) or (cal == "wac_base_7mm" and  HE7MM:GetBool())
		
		if !NoBullet then
			if IsValid(tr.Entity) and !shouldExplode and !filter[tr.Entity] and !table.HasValue(filter,tr.Entity) then
				local dmginfo = DamageInfo()
				dmginfo:SetAttacker(ply)
				dmginfo:SetDamage(dmg)
				dmginfo:SetDamagePosition(hitpos)
				dmginfo:SetDamageType(DMG_BULLET)
				tr.Entity:TakeDamageInfo(dmginfo)
			end
		end
		
		if shouldExplode then
			-- util.BlastDamage(ply,ply,hitpos,radius,dmg)
			CreateExplosion(ply,hitpos,radius,dmg,cal)
		end
		
		if not IsShared and not NoParticle then
			net.Start("gred_net_createimpact")
				net.WriteVector(hitpos)
				net.WriteAngle(hitang)
				-- if cal == "wac_base_7mm" then
					net.WriteUInt(gred.Mats[util.GetSurfacePropName(tr.SurfaceProps)] or 24,5)
				-- else
					-- net.WriteUInt(0,5)
				-- end
				net.WriteUInt(gred.CalTable[cal].ID,4)
			net.Broadcast()
		end
		
		-- if cal == "wac_base_12mm" then
			-- sound.Play("impactsounds/gun_impact_"..math.random(1,14)..".wav",hitpos,75,100,0.5)
		-- end
	else
		
		CreateExplosion(ply,hitpos,(HitSky or NoBullet) and radius * 2 or radius,dmg,cal)
		-- util.BlastDamage(ply,ply,hitpos,radius,dmg)
		
		if not IsShared then
			if cal == "wac_base_30mm" then
				sound.Play("impactsounds/30mm_old.wav",hitpos,110,math.random(90,110),1)
			else
				sound.Play("impactsounds/20mm_0"..math.random(1,5)..".wav",hitpos,100,100,0.7)
			end
			
			if not NoParticle then
				net.Start("gred_net_createimpact")
					net.WriteVector(hitpos)
					net.WriteAngle(hitang)
					net.WriteUInt(HitSky and 1 or 0,5)
					net.WriteUInt(gred.CalTable[cal].ID,4)
				net.Broadcast()
			end
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

gred.CreateExplosion = function(pos,radius,damage,decal,trace,ply,bomb,DEFAULT_PHYSFORCE,DEFAULT_PHYSFORCE_PLYGROUND,DEFAULT_PHYSFORCE_PLYAIR)
	local ConVar = gred.CVars["gred_sv_shockwave_unfreeze"]:GetBool()
	
	net.Start("gred_net_bombs_decals")
		net.WriteString(decal and decal or "scorch_medium")
		net.WriteVector(pos)
		net.WriteVector(pos-Vector(0,0,trace))
	net.Broadcast()
	
	-- debugoverlay.Sphere(pos,radius,3,color_white)
	
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
		
		if !badclass[v:GetClass()] and !v.IsOnPlane and IsValid(phys) and !IsValid(v:GetParent()) and not hook.Run("GredExplosionShouldPreventMove",v) then
			massmul = 1/phys:GetMass()
			
			phys:AddAngleVelocity(Vector(DEFAULT_PHYSFORCE, DEFAULT_PHYSFORCE, DEFAULT_PHYSFORCE) * math.Clamp((radius - (pos - v_pos):Length()) / radius,0,1) * massmul)
			phys:AddVelocity((DEFAULT_PHYSFORCE and (v_pos - pos) * DEFAULT_PHYSFORCE or (v_pos - pos))*massmul)
			
			if ConVar and !v.isWacAircraft and !v.LFS then
				phys:Wake()
				phys:EnableMotion(true)
				if !(bomb.ShellType and simfphys and simfphys.IsCar and simfphys.IsCar(v)) then
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

local tab = {}
gred.CreateSound = function(pos,rsound,e1,e2,e3)
	tab[1] = e1 or nil
	tab[2] = e2 or nil
	tab[3] = e3 or nil
	
	net.Start("gred_net_sound_new")
		net.WriteVector(pos)
		net.WriteTable(tab)
	net.Broadcast()
	
	-- local currange = 1000 / gred.CVars["gred_sv_soundspeed_divider"]:GetInt()
	
	-- local curRange_min = currange*5
	-- curRange_min = curRange_min*curRange_min
	-- local curRange_mid = currange*14
	-- curRange_mid = curRange_mid * curRange_mid
	-- local curRange_max = currange*40
	-- curRange_max = curRange_max * curRange_max
	
	-- for k,v in pairs(player.GetHumans()) do
		-- local ply = v:GetViewEntity()
		-- local distance = ply:GetPos():DistToSqr(pos)
		
		-- if distance <= curRange_min then
		
			-- if !v:InVehicle() and v:GetInfoNum("gred_sound_shake",1) == 1 then
				-- util.ScreenShake(v:GetPos(),9999999,55,1.5,50)
			-- end
			
			-- net.Start("gred_net_sound_lowsh")
				-- net.WriteString(e1)
			-- net.Send(v)
			
		-- elseif distance <= curRange_mid then
			-- timer.Simple(distance/soundSpeed,function()
				-- if !v:InVehicle() and v:GetInfoNum("gred_sound_shake",1) == 1 then
					-- util.ScreenShake(v:GetPos(),9999999,55,1.5,50)
				-- end
				-- net.Start("gred_net_sound_lowsh")
					-- net.WriteString(e2 and e2 or e1)
				-- net.Send(v)
			-- end)
		-- elseif distance <= curRange_max then
			-- timer.Simple(distance/soundSpeed,function()
				-- net.Start("gred_net_sound_lowsh")
					-- net.WriteString(e3 and e3 or (e2 and e2 or e1))
				-- net.Send(v)
			-- end)
		-- end
	-- end
end

local CurTime = CurTime

local phybullet = {}

gred.CreateBullet = function(ply,pos,ang,cal,filter,fusetime,NoBullet,tracer,dmg,radius,IsShared)
	if hab and hab.Module.PhysBullet and OverrideHAB:GetInt() == 0 then
		phybullet.AmmoType		= cal..(tracer and tracer or "")
		phybullet.Num 			= 1
		phybullet.Src 			= pos
		phybullet.Dir 			= ang:Forward()
		phybullet.Spread 		= vector_zero
		phybullet.Tracer		= 0--tracer and 0 or 1
		phybullet.IsNetworked	= not IsShared
		phybullet.IgnoreEntity = filter
		phybullet.Distance		= false
		phybullet.Damage		= ((cal == "wac_base_7mm" and HE7MM:GetBool()) or (cal == "wac_base_12mm" and HE12MM:GetBool())) and 0 or (dmg and dmg or (cal == "wac_base_7mm" and 40 or (cal == "wac_base_12mm" and 60 or (cal == "wac_base_20mm" and 80 or (cal == "wac_base_30mm" and 100 or (cal == "wac_base_40mm" and 120)))))) * BulletDMG:GetFloat()
		phybullet.Force		= phybullet.Damage*0.1
		
		ply:FirePhysicalBullets(phybullet)
	else
		World = IsValid(World) or Entity(0)
		BulletID = BulletID + 1
		
		local caltab = gred.CalTable[cal]
		local speed = caltab.Speed
		local dmg = (dmg or caltab.Damage) * BulletDMG:GetFloat()
		local radius = (radius or 70) * caltab.RadiusMul * HERADIUS:GetFloat()
		local expltime = fusetime and CurTime() + fusetime
		
		local fwd = ang:Forward()
		local explodable = caltab.Explodeable
		
		local dir = fwd * speed
		local endpos = pos + Vector()
		
		local NoParticle
		local oldbullet = BulletID
		
		-- net.Start("gred_net_createbullet")
			-- net.WriteVector(pos)
			-- net.WriteAngle(ang)
			-- net.WriteUInt(CAL_TABLE[cal],3)
			-- net.WriteUInt(COL_TABLE[tracer],3)
			-- net.WriteUInt(fusetime and math.floor(fusetime * 100) or 0,7)
		-- net.Broadcast()
		
		if COL_TABLE[tracer] and not IsShared then
			net.Start("gred_net_createtracer")
				net.WriteVector(pos)
				net.WriteUInt(CAL_TABLE[cal],3)
				net.WriteUInt(COL_TABLE[tracer],3)
				net.WriteVector(QuickTrace(pos,expltime and fwd*(fusetime*speed) or fwd*99999999999999,filter).HitPos)
			net.Broadcast()
		end
		
		local BulletTrTab = {}
		local tr
		
		BulletTrTab.filter = filter
		BulletTrTab.mask = MASK_SHOT
		
		local HitBreakable
		
		timer.Create("gred_bullet_"..oldbullet,0,0,function()
			endpos:Add(dir)
			
			BulletTrTab.start = pos
			BulletTrTab.endpos = endpos
			
			-- local lifetime = 3
			-- local color_red = Color(255,0,0)
			-- local add = ang:Right()*-100 * 0
			-- local debugpos = pos + add
			-- debugoverlay.Line(debugpos,endpos + add,lifetime,color_red)
			-- debugoverlay.Cross(debugpos,30,lifetime,color_red)
			-- debugoverlay.EntityTextAtPosition(debugpos,1,SysTime(),lifetime,color_red)
			
			tr = TraceLine(BulletTrTab)
			
			pos.x = endpos.x
			pos.y = endpos.y
			pos.z = endpos.z
			
			if not IsShared and tr.MatType == 83 then
				net.Start("gred_net_createwaterimpact")
					net.WriteVector(tr.HitPos)
					net.WriteUInt(caltab.ID,3)
				net.Broadcast()
				
				NoParticle = true
				sound.Play("impactsounds/water_bullet_impact_0"..math.random(1,5)..".wav",tr.HitPos,75,100,1)
			end
			
			HitBreakable = tr.Hit and IsValid(tr.Entity) and tr.Entity:GetClass() == "func_breakable"
			
			if HitBreakable then
				tr.Entity:Fire("break")
			end
			
			if tr.Hit and not HitBreakable then
				BulletExplode(ply,NoBullet,tr,cal,filter,ang,NoParticle,explodable,dmg,radius,fusetime,IsShared)
				timer.Remove("gred_bullet_"..oldbullet)
				return
			else
				if !IsInWorld(pos) then
					if explodable then 
						BulletExplode(ply,NoBullet,tr,cal,filter,ang,NoParticle,explodable,dmg,radius,fusetime,IsShared)
					end
					timer.Remove("gred_bullet_"..oldbullet)
				else
					pos = pos
				end
			end
			
			if expltime and CurTime() >= expltime then
				BulletExplode(ply,NoBullet,pos,cal,filter,ang,NoParticle,explodable,dmg,radius,fusetime,IsShared)
				timer.Remove("gred_bullet_"..oldbullet)
				return
			end
		end)
	end
end

gred.CreateShellOld = function(pos,ang,ply,filter,caliber,shelltype,muzzlevelocity,mass,color,dmg,callback,tntequivalent,explosivemass,linearpenetration,normalization,CoreMass,ForceDragCoef,DamageAdd) -- EXPLOSIVE MASS AND TNT EQUIVALENT IN KILOGRAMS!
	local ent = ents.Create("base_shell")
	ent:SetPos(pos)
	ent:SetAngles(ang)
	ent:SetOwner(ply)
	
	ent.Caliber = caliber or 75
	ent.ShellType = shelltype or "HE"
	ent.MuzzleVelocity = muzzlevelocity
	ent.TNTEquivalent = tntequivalent
	ent.ExplosiveMass = explosivemass
	ent.LinearPenetration = linearpenetration
	ent.Normalization = normalization
	ent.CoreMass = CoreMass
	ent.Mass = mass
	ent.DamageAdd = DamageAdd or 0
	ent.Filter = ent.Filter or {[ent] = true}
	
	for k,v in pairs(filter) do
		if IsEntity(k) then
			ent.Filter[k] = true
		elseif IsEntity(v) then
			ent.Filter[v] = true
		end
	end
	
	ent.IsOnPlane = true
	ent.ForceDragCoef = ForceDragCoef
	ent.TracerColor = color or "white"
	ent.ExplosionDamageOverride = dmg
	
	if callback then
		callback(ent)
	end
	
	ent:Spawn()
	ent:Activate()
	ent:SetBodygroup(1,ent.IS_AP[shelltype] and 0 or 1)
	
	return ent
end

local ShellCollisionFilter = {
	["gmod_sent_vehicle_fphysics_wheel"] = true,
}

hook.Add("ShouldCollide","gred_shells_collisions",function(ent1,ent2)
	if (ent1.IsRocket or ent1.IsShell) and (ShellCollisionFilter[ent2:GetClass()] or ent1.Filter[ent2] or ent1.Filter[ent2:GetClass()]) then
		return false
	end
end)

-- hook.Add("KeyPress","gred_keypress_shellhold",function(ply,key)
	-- if key != IN_USE then return end
	
	-- timer.Simple(0,function()
		-- if !IsValid(ply) then return end
		
		-- local ent = ply:GetNWEntity("PickedUpObject")
		-- if !IsValid(ent) then return end
		
		-- if !ent:IsPlayerHolding() then 
			-- ply:SetNWEntity("PickedUpObject",Entity(0))
		-- end
	-- end)
-- end)

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

net.Receive("gred_net_checkconcommand",function(len,ply)
	local str = net.ReadString()
	local val = net.ReadFloat()
	if !ply:IsAdmin() then return end
	local cvar = gred.CVars[str]
	if !cvar then return end
	cvar:SetFloat(val)
	
	local TABLE = file.Read("gredwitch_base_config_sv.txt","DATA")
	TABLE = TABLE and util.JSONToTable(TABLE) or {}
	TABLE[str] = val
	file.Write("gredwitch_base_config_sv.txt",util.TableToJSON(TABLE))
end)

net.Receive("gred_net_applyboolonsimfphys",function(len,ply)
	local str = net.ReadString()
	if !ply:IsAdmin() then return end
	local cvar = gred.CVars[str]
	if !cvar then return end
	local bool = cvar:GetBool()
	for k,v in pairs(gred.ActiveSimfphysVehicles) do
		v[str] = bool
	end
	
	net.Start("gred_net_applyboolonsimfphys_cl")
		net.WriteString(str)
	net.Broadcast()
end)

net.Receive("gred_net_applyfloatonsimfphys",function(len,ply)
	local str = net.ReadString()
	if !ply:IsAdmin() then return end
	local cvar = gred.CVars[str]
	if !cvar then return end
	local val = cvar:GetFloat()
	for k,v in pairs(gred.ActiveSimfphysVehicles) do
		v[str] = val
	end
	
	net.Start("gred_net_applyfloatonsimfphys_cl")
		net.WriteString(str)
	net.Broadcast()
end)

AddCSLuaFile("gredwitch/gred_cl_lfs_functions.lua")
AddCSLuaFile("gredwitch/gred_cl_simfphys_functions.lua")
AddCSLuaFile("gredwitch/gred_cl_menu.lua")
AddCSLuaFile("xml2lua/xml2lua.lua")
AddCSLuaFile("xml2lua/xmlparser.lua")
AddCSLuaFile("xml2lua/xmlhandler/dom.lua")
AddCSLuaFile("xml2lua/xmlhandler/print.lua")
AddCSLuaFile("xml2lua/xmlhandler/tree.lua")

include("gredwitch/gred_sv_lfs_functions.lua")
include("gredwitch/gred_sv_simfphys_functions.lua")
include("gredwitch/gred_sh_simfphys_functions.lua")


local kfbr = 1900^1.43
local MATH_PI = math.pi
local ONE_THIRD = 1/3
local CONE_LENGTH = 102.384225 -- millimeters
local CYLINDER_LENGTH = 107.866815 -- millimeters
local TO_METERS_PER_SEC = 1/3.6
local kfbrAPCR = 3000^1.43
local ShellRadiusSquared
local FlowRate
local CylinderLength



gred.GetPenetration = function(ShellType,TNTEquivalent,Caliber,Mass,CoreMass,vel)
	local Penetration = 0
	
	if not gred.IS_APCR[ShellType] then
		Penetration = (((vel^1.43)*(Mass^0.71))/(kfbr*((Caliber*0.01)^1.07)))*100*(TNTEquivalent < 0.65 and 1 or (TNTEquivalent < 1.6 and 1 + (TNTEquivalent-0.65)*-0.07/0.95 or (TNTEquivalent < 2 and 0.93 + (TNTEquivalent-1.6) * -0.03 / 0.4 or (TNTEquivalent < 3 and 0.9+(TNTEquivalent-2)*-0.05 or TNTEquivalent < 4 and 0.85+(TNTEquivalent-3)*-0.1 or 0.75))))*((ShellType == "APCBC" or ShellType == "APHECBC") and 1 or 0.9)
		
	else
		Penetration = ((vel^1.43)*((CoreMass + (((((CoreMass/Mass)*100) > 36.0) and 0.5 or 0.4) * (Mass - CoreMass)))^0.71))/(kfbrAPCR*((Caliber*0.0001)^1.07))
	end
	
	return Penetration
end

gred.CreateShell = function(pos,ang,ply,filter,Caliber,ShellType,MuzzleVelocity,Mass,color,dmg,callback,TNTEquivalent,ExplosiveMass,LinearPenetration,normalization,CoreMass,ForceDragCoef,DamageAdd)
	local done = false
	
	timer.Create("shell",0,0,function()
	local trtab = {
		start = pos + Vector(),
		starttime = CurTime(),
		filter = filter,
		mask = MASK_SHOT + CONTENTS_WATER,
	}
	
	local tr = {}
	
	
	
	------------------------------
	-- Shell penetration data
	
	
	ExplosiveMass = (!ExplosiveMass and TNTEquivalent) and (TNTEquivalent * Mass) * 0.01 or 0
	TNTEquivalent = !TNTEquivalent and (ExplosiveMass and (ExplosiveMass/Mass)*100 or 0) or TNTEquivalent
	
	
	-----------------------------
	-- Shell physical properties
	
	local caliberMul = Caliber / 75
	local ShellRadius = Caliber*0.5
	local ShellRadiusSquared = ShellRadius * ShellRadius
	
	local ShellLength = CONE_LENGTH * caliberMul
	local ShellArea = (ShellLength * 70.31355) * 0.5
	local ShellVolume = ONE_THIRD * MATH_PI * ShellRadiusSquared * ShellLength * caliberMul
	
	local Density = (Mass + (CoreMass or 0)) / ShellVolume -- p
	
	
	
	-----------------------------
	-- Environnment physics
	
	
	local Scale = 0.01
	local Ticks = 0
	local Gravity = 9.81 / 0.01905 -- GetConVar("sv_gravity"):GetInt()
	local AirDensity = 1.29 -- physenv.GetAirDensity()
	
	
	-----------------------------
	-- Shell physics
	
	
	local Inertia = Vector((Mass * ShellLength) * 0.5,(Mass * ShellRadiusSquared) * 0.5,(Mass * ShellRadiusSquared) / 12):Length()
	
	local OgiveCaliber = 2.24 * Caliber
	local FormCoef = (2 / OgiveCaliber) * math.sqrt((4 * Caliber - 1) / Caliber)
	local BallisticCoef = (Mass / (Caliber * Caliber * FormCoef)) * 10^-3
	
	local CurSpeed = (MuzzleVelocity / 0.01905)
	
	
	-----------------------------
	-- Flight data
	
	
	local vx = CurSpeed * math.cos(math.rad(ang.p))
	local vy = CurSpeed * math.sin(math.rad(ang.p))
	
	local magnitude = math.sqrt(vx*vx + vy*vy)
	local drag = BallisticCoef * magnitude*magnitude

	local ax = -(drag * math.cos(math.rad(ang.p))) / Mass
	local ay = -Gravity - (drag * math.sin(math.rad(ang.p))) / Mass
	
	local FlightData = {}
	
	-- local mu = 0.5 * BallisticCoef * ShellArea * AirDensity
	
	
	while not tr.Hit do
		debugoverlay.Cross(trtab.start,50,FrameTime()+0.05,Color(255,0,0),true)
		-- print(math.floor(ax))
		trtab.endpos = trtab.start + (ang:Forward() * vx * Scale)
		trtab.endpos.z = trtab.endpos.z + ay * Scale
		
		tr = util.TraceLine(trtab)
		
		table.insert(FlightData,tr.StartPos:Distance(tr.HitPos))
		 
		debugoverlay.Line(tr.StartPos,tr.HitPos,FrameTime()+0.05,Color(255,255,255,255),true)
		
		if tr.Hit then
			local FinalVelocity = math.sqrt(vx*vx + vy*vy)
			local FinalVelocityMeters = FinalVelocity * 0.01905
			
			local Penetration = LinearPenetration or gred.GetPenetration(ShellType,TNTEquivalent,Caliber,Mass,CoreMass,FinalVelocityMeters)
			
			local FullDistance = 0
			
			for k,v in pairs(FlightData) do
				FullDistance = FullDistance + v
			end
			
			if not done then
				local PenRem = (gred.IS_APCR[ShellType] and 16 or 2) * 0
				print(math.Round(Penetration,2) - PenRem.."mm",math.floor(FullDistance * 0.01905).."m",math.floor(FinalVelocityMeters).."m/s")
				-- print("vx:")
				-- PrintTable(vx)
				
				-- print(BallisticCoef,Gravity,Mass,MuzzleVelocity)
			end
			
			done = true
			
			break
		end
		
		trtab.start = trtab.endpos
		
		if math.floor(FlightVector:Length()) <= 0 then
			error("Shell's velocity is null")
			break
		end
		
		vx = vx + Scale * ax
		vy = vy + Scale * ay
		
		magnitude = math.sqrt(vx*vx + vy*vy)
		-- print(magnitude,Inertia*3)
		drag = BallisticCoef * magnitude*magnitude
		
		ax = -(drag * math.cos(math.rad(ang.p))) / Mass
		ay = -Gravity - (drag * math.sin(math.rad(ang.p))) / Mass
		
		Ticks = Ticks + 1
	end
	
	end)
	
	return ent
end

-- local BallisticCoef,Gravity,Mass,Speed,Scale = 0.050811153326163,600,6.8,740,1 
-- local BallisticCoef,Gravity,Mass,Speed,Scale = 0.005,9.8,1,80,0.5 

-- local ang = Angle()

-- local t = {0}
-- local vx = {Speed * math.cos(math.rad(ang.p))} 
-- local vy = {Speed * math.sin(math.rad(ang.p))}

-- local drag = BallisticCoef * Speed^2

-- local ax = {-(drag * math.cos(math.rad(ang.p))) / Mass}
-- local ay = {-Gravity - (drag * math.sin(math.rad(ang.p))) / Mass}


-- for Ticks = 1,10 do
	-- table.insert(t,t[Ticks] + Scale)
	
	-- table.insert(vx,vx[Ticks] + Scale * ax[Ticks])
	-- table.insert(vy,vy[Ticks] + Scale * ay[Ticks])
	
	-- local vel = math.sqrt(vx[Ticks + 1]^2 + vy[Ticks + 1]^2)
	-- local drag = BallisticCoef * vel^2
	
	-- table.insert(ax,-(drag * math.cos(math.rad(ang.p))) / Mass)
	-- table.insert(ay,-Gravity - (drag * math.sin(math.rad(ang.p))) / Mass)
-- end

-- print("vx")
-- PrintTable(vx)
-- print("ax")
-- PrintTable(ax)

gred.CreateShell = gred.CreateShellOld