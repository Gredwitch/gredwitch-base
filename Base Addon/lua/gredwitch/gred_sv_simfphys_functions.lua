
util.AddNetworkString("gred_net_simfphys_playerenteredseat_broadcast")
util.AddNetworkString("gred_net_simfphys_clearbonemanipulations")
util.AddNetworkString("gred_net_simfphys_playerenteredseat")
util.AddNetworkString("gred_net_simfphys_playerexitedseat")
util.AddNetworkString("gred_net_simfphys_update_tracks")

local angle_yaw_90 = Angle(0,90)
local angle_zero = Angle()
local vector_zero = Vector()

local Vector = Vector
local Angle = Angle

local ENTITY = FindMetaTable("Entity")
local GetPhysicsObject = ENTITY.GetPhysicsObject
local GetNWInt = ENTITY.GetNWInt
local SetNWBool = ENTITY.SetNWBool
local GetRight = ENTITY.GetRight
local GetUp = ENTITY.GetUp
local GetForward = ENTITY.GetForward
local SetPoseParameter = ENTITY.SetPoseParameter
local SetParent = ENTITY.SetParent
local SetAngles = ENTITY.SetAngles
local GetAngles = ENTITY.GetAngles
local SetPos = ENTITY.SetPos
local GetPos = ENTITY.GetPos
local EnityWorldToLocal = ENTITY.WorldToLocal
local EntityLocalToWorld = ENTITY.LocalToWorld
local LocalToWorldAngles = ENTITY.LocalToWorldAngles
local WorldToLocalAngles = ENTITY.WorldToLocalAngles
local GetAttachment = ENTITY.GetAttachment
local SetNWVector = ENTITY.SetNWVector
local SetNWString = ENTITY.SetNWString
local SetNWFloat = ENTITY.SetNWFloat
local SetNWInt = ENTITY.SetNWInt
local GetNWBool = ENTITY.GetNWBool
local GetNWInt = ENTITY.GetNWInt
local GetNWFloat = ENTITY.GetNWFloat
local GetNWVector = ENTITY.GetNWVector
local GetNWString = ENTITY.GetNWString
local GetClass = ENTITY.GetClass
local GetSurfaceMaterial = ENTITY.GetSurfaceMaterial
local RemoveCallOnRemove = ENTITY.RemoveCallOnRemove
local CallOnRemove = ENTITY.CallOnRemove
local GetPoseParameter = ENTITY.GetPoseParameter
local SetCollisionGroup = ENTITY.SetCollisionGroup
local TakeDamageInfo = ENTITY.TakeDamageInfo
local GetEyeAngles = ENTITY.EyeAngles
local GetParent = ENTITY.GetParent
local Ignite = ENTITY.Ignite

local VECTOR = FindMetaTable("Vector")
local LengthSqr = VECTOR.LengthSqr
local DistToSqr = VECTOR.DistToSqr

local PHYSOBJ = FindMetaTable("PhysObj")
local PhysGetVelocity = PHYSOBJ.GetVelocity
local GetAngleVelocity = PHYSOBJ.GetAngleVelocity
local ApplyForceOffset = PHYSOBJ.ApplyForceOffset
local ApplyTorqueCenter = PHYSOBJ.ApplyTorqueCenter
local ApplyForceCenter = PHYSOBJ.ApplyForceCenter
local GetMass = PHYSOBJ.GetMass

local PLAYER = FindMetaTable("Player")
local SetEyeAngles = PLAYER.SetEyeAngles
local GetSteamID = PLAYER.SteamID
local GetInfoNum = PLAYER.GetInfoNum
local KeyDown = PLAYER.KeyDown
local Ping = PLAYER.Ping

local ANGLE = FindMetaTable("Angle")
local Normalize = ANGLE.Normalize
local Forward = ANGLE.Forward

local CSoundPatch = FindMetaTable("CSoundPatch")
local CreateSound = CreateSound
local IsPlaying = CSoundPatch.IsPlaying
local ChangePitch = CSoundPatch.ChangePitch
local ChangeVolume = CSoundPatch.ChangeVolume
local GetVolume = CSoundPatch.GetVolume

local CTakeDamageInfo = FindMetaTable("CTakeDamageInfo")
local DamageInfo = DamageInfo
local SetAttacker = CTakeDamageInfo.SetAttacker
local SetInflictor = CTakeDamageInfo.SetInflictor
local SetDamageType = CTakeDamageInfo.SetDamageType
local SetDamage = CTakeDamageInfo.SetDamage

local netStart = net.Start
local netBroadcast = net.Broadcast
local netSend = net.Send
local netWriteEntity = net.WriteEntity
local netWriteInt = net.WriteInt
local netWriteUInt = net.WriteUInt

local TraceHull = util.TraceHull
local QuickTrace = util.QuickTrace
local GetSurfacePropName = util.GetSurfacePropName

local Round = math.Round
local Clamp = math.Clamp
local Rand = math.Rand
local ApproachAngle = math.ApproachAngle

local abs = math.abs
local max = math.max
local floor = math.floor
local random = math.random
local ceil = math.ceil
local sqrt = math.sqrt

local lower = string.lower

local LocalToWorld = LocalToWorld
local WorldToLocal = WorldToLocal
local pairs = pairs
local next = next
local CurTime = CurTime

local BadFlamethrowerClasses = {
	["prop_vehicle_prisoner_pod"] = true,
	["gmod_sent_vehicle_fphysics_attachment"] = true,
	["info_player_start"] = true,
	["info_particle_system"] = true,
	["phys_spring"] = true,
	["physgun_beam"] = true,
	["predicted_viewmodel"] = true,
	["entityflame"] = true,
	-- "gmod_sent_vehicle_fphysics_wheel" = true,
}
local BadDamageTypes = {
	[DMG_GENERIC] = true,
	[DMG_CRUSH] = true,
	[DMG_BULLET] = true,
	[DMG_SLASH] = true,
	[DMG_BURN] = true,
}
local ShellClass = {
	["wac_base_grocket"] = true,
	["base_shell"] = true,
	["base_rocket"] = true,
	["hvap_swep_rocket_barrage_he"] = true,
	["hvap_swep_rocket_barrage_smoke"] = true,
	["hvap_swep_rocket_bazooka_he"] = true,
	["hvap_swep_rocket_bazooka_heat"] = true,
	["hvap_swep_rocket_bazooka_wp"] = true,
	["hvap_swep_rocket_faust_heat"] = true,
	["hvap_swep_rocket_shrek_heat"] = true,
}
local SmokeSnds = { -- to clean
	"gred_emp/nebelwerfer/artillery_strike_smoke_close_01.wav",
	"gred_emp/nebelwerfer/artillery_strike_smoke_close_02.wav",
	"gred_emp/nebelwerfer/artillery_strike_smoke_close_03.wav",
	"gred_emp/nebelwerfer/artillery_strike_smoke_close_04.wav",
}

local tr_flame_tab = {}
local tr_wheel_tab = {}

for i = 1,11 do
	sound.Add({
		name = "GRED_SIMFPHYS_TURRET_KLANK_"..i,
		channel = CHAN_AUTO,
		volume = 1.0,
		level = 75,
		sound = "turret/turret_klank_"..(i < 10 and "0" or "")..i..".wav"
	})
end

for i = 1,2 do
	n = i == 1 and "primary" or "secondary"
	util.AddNetworkString("gred_net_simfphys_changeshelltype_"..(n).."_tankCannon")
	util.AddNetworkString("gred_net_simfphys_shoot_"..(n).."_tankCannon")
	util.AddNetworkString("gred_net_simfphys_shoot_"..(n).."_tankCannon")
	util.AddNetworkString("gred_net_simfphys_shoot_"..(n).."_machinegun")
	util.AddNetworkString("gred_net_simfphys_shoot_"..(n).."_machinegun_sequential")
	util.AddNetworkString("gred_net_simfphys_stop_"..(n).."_machinegun")
end

util.PrecacheModel("models/gredwitch/viewports/viewport_gunner.mdl")
util.PrecacheModel("models/gredwitch/viewports/viewport_driver.mdl")

gred.InitializeSimfphys = function(vehicle)
	-- if true then return end
	if gred.simfphys[vehicle.CachedSpawnList].trackTex then vehicle:Remove() end
	
	vehicle.SetPassenger = function(vehicle,ply)
		gred.TankSetPassenger(vehicle,ply,Mode)
	end
	
	timer.Simple(1,function()
		if not IsValid(vehicle) then return end
		if not vehicle.VehicleData["filter"] then 
			print("[simfphys Armed Vehicle Pack] ERROR:TRACE FILTER IS INVALID. PLEASE UPDATE SIMFPHYS BASE")
			vehicle:Remove()
			return
		end
		
		local ct
		
		local VehicleTab = gred.simfphys[vehicle.CachedSpawnList]
		local TracksTab = VehicleTab.Tracks
		local SusDataTab = VehicleTab.SusData
		local VehicleSeatTab = VehicleTab.Seats
		
		local TankSteerTab
		local MaxTurn
		local TurnTorqueCenter
		local TurnTorqueCenterRate
		local TurnForceMul
		
		
		if TracksTab then
			TankSteerTab = TracksTab.TankSteer
			if TankSteerTab then
				MaxTurn = TankSteerTab.MaxTurn
				TurnTorqueCenter = TankSteerTab.TurnTorqueCenter
				TurnTorqueCenterRate = TankSteerTab.TurnTorqueCenterRate
				TurnForceMul = TankSteerTab.TurnForceMul
			end
		end
		
		gred.TankInitVars(vehicle,VehicleTab,TracksTab,VehicleSeatTab)
		gred.TankInitHealth(vehicle)
		gred.TankInitArcadeMode(vehicle)
		
		local Mode = vehicle.Mode
		
		gred.TankInitSeats(vehicle,Mode,VehicleSeatTab)
		gred.TankInitTracks(vehicle,TracksTab,TankSteerTab)
		gred.TankInitSuspensions(vehicle,SusDataTab,TracksTab)
		gred.TankInitModules(vehicle,VehicleTab)
		
		local VehicleTabOnSVTick = VehicleTab.OnSVTick
		local gredHandleHandBrakeSound = gred.HandleHandBrakeSound
		local gredTankTurn = gred.TankTurn
		local gredHandleWheelSpin = gred.HandleWheelSpin
		local gredHandleSeats = gred.HandleSeats
		local gredTankUpdateSuspension = gred.TankUpdateSuspension
		local gredTankGetDriverLocalAngles = gred.TankGetDriverLocalAngles
		local vehicleOldThink = vehicle.OldThink
		
		vehicle.Think = function(vehicle)
			if vehicle.CachedHandBrakePower then
				vehicle.HandBrakePower = vehicle.CachedHandBrakePower -- FIXME
			end
			
			local WheelsLocked = vehicle.HandBrake > (vehicle.NeutralHandBrakePower or vehicle.HandBrakePower * 0.2)
			
			if VehicleTabOnSVTick then
				VehicleTabOnSVTick(vehicle)
			end
			
			if TracksTab then 
				if TankSteerTab then
					gredTankTurn(vehicle,MaxTurn,TurnTorqueCenter,TurnTorqueCenterRate,TurnForceMul,WheelsLocked)
				end
				if TracksTab.TrackSoundLevel then
					gredHandleHandBrakeSound(vehicle,WheelsLocked,vehicle:GetVelocity(),TracksTab)
				end
			end
			
			gredHandleWheelSpin(vehicle,WheelsLocked)
			ct = VehicleSeatTab and gredHandleSeats(vehicle,Mode,VehicleSeatTab,gredTankGetDriverLocalAngles)
			
			if SusDataTab then
				gredTankUpdateSuspension(vehicle,ct,SusDataTab)
				-- gred.TankModPhysics(vehicle,WheelsLocked,vel or vehicle:GetVelocity())
			end
			
			return vehicleOldThink(vehicle)
		end
		
		if VehicleTab.PostSVInit then
			VehicleTab.PostSVInit(vehicle)
		end
		
		vehicle.FullyInitialized = true
	end)
end

gred.TankInitVars = function(vehicle,VehicleTab,TracksTab,VehicleSeatTab) -- doesn't need to be optimized
	local OldThink = vehicle.Think
	-- local OldTouch = vehicle.Touch
	local mins,maxs = vehicle:GetModelBounds()
	local LengthVal = (maxs + mins):Length() * 0.5
	local OldCollide = vehicle.PhysicsCollide
	local OldDestroyed = vehicle.OnDestroyed
	local OldDamage = vehicle.OnTakeDamage
	local ModuleSystem = gred.CVars.gred_sv_simfphys_moduledamagesystem:GetBool()
	-- local phys = vehicle:GetPhysicsObject()
	-- local inflictor,gdmg,T,dmgtype
	
	vehicle.OldThink = vehicle.OldThink or OldThink
	
	vehicle.gred_sv_simfphys_testsuspensions = gred.CVars.gred_sv_simfphys_testsuspensions:GetBool()
	vehicle.gred_sv_simfphys_turnrate_multplier = gred.CVars.gred_sv_simfphys_turnrate_multplier:GetFloat()
	vehicle.gred_sv_simfphys_suspension_rate = gred.CVars.gred_sv_simfphys_suspension_rate:GetFloat()
	vehicle.gred_sv_simfphys_manualreloadsystem = gred.CVars.gred_sv_simfphys_manualreloadsystem:GetBool()
	vehicle.gred_sv_simfphys_infinite_ammo = gred.CVars.gred_sv_simfphys_infinite_ammo:GetBool()
	vehicle.gred_sv_simfphys_disable_viewmodels = gred.CVars.gred_sv_simfphys_disable_viewmodels:GetBool()
	vehicle.gred_sv_simfphys_infinite_mg_ammo = gred.CVars.gred_sv_simfphys_infinite_mg_ammo:GetBool()
	vehicle.gred_sv_simfphys_smokereloadtime = gred.CVars.gred_sv_simfphys_smokereloadtime:GetFloat()
	vehicle.gred_sv_simfphys_forcesynchronouselevation = gred.CVars.gred_sv_simfphys_forcesynchronouselevation:GetBool()
	vehicle.gred_sv_simfphys_traverse_speed_multiplier = gred.CVars.gred_sv_simfphys_traverse_speed_multiplier:GetFloat()
	vehicle.gred_sv_simfphys_elevation_speed_multiplier = gred.CVars.gred_sv_simfphys_elevation_speed_multiplier:GetFloat()
	vehicle.gred_sv_simfphys_moduledamagesystem = ModuleSystem
	
	vehicle.NextSuspension = 0
	vehicle.TOQUECENTER_D = 0
	vehicle.TOQUECENTER_A = 0
	vehicle.GRED_TANK = true
	
	vehicle.ModelBounds = {maxs = maxs,mins = mins}
	vehicle.Attachments = {}
	vehicle.MassVec = Vector(0,0,vehicle.Mass)
	vehicle.ForceOffsetVec = Vector(0,0,vehicle.ModelBounds.maxs.z*0.5)
	vehicle.ModelSize = vehicle.ModelBounds.maxs + vehicle.ModelBounds.mins
	vehicle.ModelSizeLength = vehicle.ModelSize:Length()
	vehicle.EntityIndex = vehicle:EntIndex()
	
	
	vehicle.CachedHandBrakePower = (TracksTab and TracksTab.HandBrakePower) and TracksTab.HandBrakePower or VehicleTab.HandBrakePower
	vehicle.NeutralHandBrakePower = vehicle.CachedHandBrakePower and vehicle.CachedHandBrakePower*0.2
	
	SetNWBool(vehicle,"simfphys_NoRacingHud",true)
	vehicle:SetSkin(random(0,vehicle:SkinCount()))
	
	vehicle.tr_table = {}
	
	vehicle.FILTER = ents.FindByClass("gmod_sent_vehicle_fphysics_wheel")
	table.Add(vehicle.FILTER,vehicle.pSeat)
	table.Add(vehicle.FILTER,vehicle.GhostWheels)
	table.Add(vehicle.FILTER,vehicle.Wheels)
	table.insert(vehicle.FILTER,vehicle)
	table.insert(vehicle.FILTER,vehicle:GetDriverSeat())
	table.insert(vehicle.FILTER,vehicle.SteerMaster)
	table.insert(vehicle.FILTER,vehicle.SteerMaster2)
	table.insert(vehicle.FILTER,vehicle.MassOffset)
	vehicle.FILTER_BYENT = {}
	local v
	for k = 1,#vehicle.FILTER do
		v = vehicle.FILTER[k]
		if v then
			vehicle.FILTER_BYENT[v] = true
		end
	end
	
	vehicle.GearsBackup = table.Copy(vehicle.Gears)
	vehicle.filterEntities = player.GetAll()
	table.Add(vehicle.filterEntities,vehicle.FILTER)
	-- PrintTable(vehicle.FILTER)
	
	vehicle.PhysicsCollide = function(ent,data,phy)
		if !(IsValid(data.HitEntity) and ShellClass[GetClass(data.HitEntity)]) then
			OldCollide(ent,data,phy)
		else
			if data.HitEntity.GetClass and data.HitEntity:GetClass() == "base_shell" and VehicleSeatTab then
				local seat
				local v
				
				for SeatID = 0,#VehicleSeatTab do
					v = VehicleSeatTab[SeatID]
					seat = SeatID == 0 and ent:GetDriverSeat() or (ent.pSeat and ent.pSeat[SeatID] or nil)
					
					if v and IsValid(seat) and v[ent.Mode] and v[ent.Mode].Primary then
						local WeaponTab
						
						for SlotID = 1,#v[ent.Mode].Primary do
							WeaponTab = v[ent.Mode].Primary[SlotID]
							
							if WeaponTab and WeaponTab.Type == "Cannon" and data.HitEntity.Caliber == WeaponTab.ShellTypes[1].Caliber then
								local Ammo
								local TotalAmmo = 0
								local ShellTypeID = false
								
								for ShellID = 1,#WeaponTab.ShellTypes do
									Ammo = GetNWInt(seat,SlotID.."CurAmmo"..ShellID,0)
									TotalAmmo = TotalAmmo + Ammo
									ShellTypeID = data.HitEntity.ShellType == WeaponTab.ShellTypes[ShellID].ShellType and ShellID or ShellTypeID
								end
								
								if ShellTypeID and TotalAmmo < WeaponTab.MaxAmmo then
									local NetworkVarName = SlotID.."CurAmmo"..ShellTypeID
									SetNWInt(seat,NetworkVarName,GetNWInt(seat,NetworkVarName,0) + 1)
									seat.Primary[SlotID].ShellTypes[ShellTypeID] = seat.Primary[SlotID].ShellTypes[ShellTypeID] + 1
									-- ent:EmitSound(seat.ReloadSound)
									data.HitEntity:Remove()
									
									return
								end
							end
						end
					end
				end
			end
		end
	end
	
	-- vehicle:SetMoveCollide(MOVECOLLIDE_FLY_CUSTOM)
	
	-- vehi
	
	vehicle.OnDestroyed = function(ent)
		if ModuleSystem then
			ent.DestructionType = ent.DestructionType or 0
		else
			local DMG = ent.DMGDelt and ent.DMGDelt or (ent.Gred_OldHP or ent.MaxHealth)
			local T = DMG/ent.MaxHealth
			
			if T >= 0.1 then
				if T >= 0.25 then
					if T >= 0.35 then
						if T >= 0.6 then
							ent.DestructionType = random(5,6)
						else
							ent.DestructionType = random(3,4)
						end
					else
						ent.DestructionType = random(2,3)
					end
				else
					ent.DestructionType = 1
				end
			else
				ent.DestructionType = 0
			end
		end
		OldDestroyed(ent)
	end
	
	vehicle.OnTakeDamage = function(ent,dmg)
		local inflictor = dmg:GetInflictor()
		
		if ModuleSystem and ((inflictor.ClassName == "simfphys_antitankmine" and dmg:GetDamageType() == DMG_DIRECT) or dmg:GetDamageType() == DMG_BLAST) then
			
			local Damage = dmg:GetDamage() * (inflictor.ShellType == "HE" and 0.1 or (inflictor.ClassName == "simfphys_antitankmine" and 0.3 or 1))
			local DamagePos = dmg:GetDamagePosition() - GetPos(ent)
			local D = Damage * 0.01
			SetNWInt(vehicle,"ModuleHealth_RightTrack_0",GetNWInt(vehicle,"ModuleHealth_RightTrack_0",100) - Round((Damage / abs(DamagePos:Length() + LengthVal)) * D))
			SetNWInt(vehicle,"ModuleHealth_LeftTrack_0",GetNWInt(vehicle,"ModuleHealth_LeftTrack_0",100) - Round((Damage / abs(DamagePos:Length())) * D))
			
			if inflictor.Base == "base_bomb" then
				dmg:SetDamage((Damage or dmg:GetDamage()) * 0.1)
			else
				if ent.IsArmored and ((!vehicle.DestructionType and !inflictor.ExplosionDamageOverride) or inflictor.ClassName == "simfphys_antitankmine") then
					return
				end
			end
			
			-- if (inflictor.ShellType and inflictor != vehicle.LastShellInflictor) or (inflictor.ShellType == "HE" and ((inflictor.Fraction and inflictor.Fraction >= 1 or !inflictor.Fraction) and !inflictor.ExplosionDamageOverride)) then
				-- return
			-- end
		else
			if ent.IsArmored and BadDamageTypes[dmg:GetDamageType()] then return end
			
			local inflictor = dmg:GetInflictor()
			local DMG = 0
			if ent.IsArmored and IsValid(inflictor) and (inflictor.GetClass and ShellClass[inflictor:GetClass()]) or ShellClass[inflictor.Base] then
				DMG = (
					(
						inflictor.ShellType == "HE" and 
						(inflictor.Fraction and inflictor.Fraction >= 1 or !inflictor.Fraction) and 
						!inflictor.ExplosionDamageOverride
					) or (
						gred.IS_HEAT[inflictor.ShellType] and inflictor.EntityHit != ent
					) 
					or dmg:GetDamageCustom() != inflictor:EntIndex()) and ((ShellClass[inflictor.Base] and not inflictor.IsShell) and dmg:GetDamage()*0.25 or  0) or dmg:GetDamage()
				
				local ply = dmg:GetAttacker()
				if DMG == 0 and inflictor.ShellType == "HE" and IsValid(ply) and ply:GetSimfphys() != ent then
					if ply.GRED_HE_WARN_ENTITY == ent then
						ply.GRED_HE_WARN_ENTITY = nil
						ply:PrintMessage(HUD_PRINTCENTER,"HE isn't meant to deal damage to tanks!")
					else
						ply.GRED_HE_WARN_ENTITY = ent
					end
				end
				
				SetDamage(dmg,DMG)
			end
			
			ent.Gred_OldHP 	= ent:GetCurHealth()
			ent.DMGDelt		= DMG
		end
		OldDamage(ent,dmg)
	end

	if !gred.SimfphysCalcMainActivityHack then
		local HookTab = hook.GetTable()
		
		if HookTab.CalcMainActivity and HookTab.CalcMainActivity.simfphysSeatActivityOverride then
			local simfphysSeatActivityOverride = HookTab.CalcMainActivity.simfphysSeatActivityOverride
			
			gred.SimfphysCalcMainActivityHack = simfphysSeatActivityOverride
			
			local CalcIdeal,CalcSeqOverride,HatchID,holdtype,seqid
			
			hook.Add("CalcMainActivity","simfphysSeatActivityOverride",function(ply)
				CalcIdeal,CalcSeqOverride = simfphysSeatActivityOverride(ply)
				
				if ply:GetVehicle():GetNWInt("HatchID",0) != 0 and CalcIdeal and CalcSeqOverride then
					ply.CalcSeqOverride = -1
					
					if ply:GetAllowWeaponsInVehicle() and IsValid(ply:GetActiveWeapon()) then
					
						holdtype = ply:GetActiveWeapon():GetHoldType()
						
						if holdtype == "smg" then 
							holdtype = "smg1"
						end

						seqid = ply:LookupSequence("sit_"..holdtype)
						
						if seqid != -1 then
							ply.CalcSeqOverride = seqid
						end
					end
					
					return ply.CalcIdeal,ply.CalcSeqOverride
				end
				
				return CalcIdeal,CalcSeqOverrid
			end)
		end
	end
		
end

gred.TankInitHealth = function(vehicle)
	local health = ceil(vehicle:GetMaxHealth() * gred.CVars.gred_sv_simfphys_health_multplier:GetFloat())
	vehicle.MaxHealth = health
	SetNWFloat(vehicle,"MaxHealth",health)
	vehicle:SetMaxHealth(health)
	SetNWFloat(vehicle,"Health",health)
	vehicle:SetCurHealth(health)
end

gred.TankInitArcadeMode = function(vehicle) -- doesn't need to be optimized
	vehicle.ArcadeMode = hook.Run("GredTankArcadeMode",vehicle,ArcadeMode,vehicle.CachedSpawnList)
	vehicle.ArcadeMode = vehicle.ArcadeMode == nil and gred.CVars.gred_sv_simfphys_arcade:GetBool() or ArcadeMode
	vehicle.Mode = vehicle.ArcadeMode and "ArcadeMode" or "NormalMode"
end

gred.TankInitSeats = function(vehicle,Mode,VehicleSeatTab) -- doesn't need to be optimized
	local seat
	local SeatTab
	
	if VehicleSeatTab then
		local tick = (1/FrameTime())
		local v
		
		for k = 0,#VehicleSeatTab do
			v = VehicleSeatTab[k]
			
			if v and v[Mode] then
				seat = k == 0 and vehicle:GetDriverSeat() or (vehicle.pSeat and vehicle.pSeat[k] or nil)
				
				if IsValid(seat) then
					SeatTab = v[Mode]
					
					if SeatTab.Attachment then
						vehicle.Attachments[SeatTab.Attachment] = vehicle.Attachments[SeatTab.Attachment] or vehicle:LookupAttachment(SeatTab.Attachment)
						SetParent(seat,vehicle,vehicle.Attachments[SeatTab.Attachment])
					end
					
					-- simfphys.RegisterCrosshair(seat,{
						-- Direction = SeatTab.MuzzleDirection,
						-- Attachment = SeatTab.MuzzleAttachment,
						-- Type = 2
					-- })
					
					seat.CurPrimaryShot = 0
					seat.CurSecondaryShot = 0
					seat.NextSetPos = 0
					seat.LastWalkPress = 0
					seat.LocalView = SeatTab.LocalView != nil and SeatTab.LocalView or ((SeatTab.ViewAttachment or SeatTab.Attachment) and true or false)
					-- simfphys.RegisterCamera(seat,SeatTab.FirstPersonViewPos,SeatTab.ThirdPersonViewPos,seat.LocalView,SeatTab.ViewAttachment)
					
					if SeatTab.Hatches then
						local SeatTab = SeatTab
						
						-- if k == 0 then
							-- seat:SetModel("models/nova/airboat_seat.mdl")
							-- seat:SetKeyValue("vehiclescript","scripts/vehicles/prisoner_pod.txt")
						-- end
						
						seat.ResetHatch = function(seat,SeatID,vehicle)
							gred.TankResetHatch(vehicle,seat,SeatID,vehicle,SeatTab)
						end
					end
					
					if SeatTab.TurretTraverseSpeed then
						seat.VAL_TurretHorizontal = 0
						seat.VAL_TurretVertical = 0
						
						if SeatTab.TurretTraverseSound then
							seat.TurretHorizontal = CreateSound(seat,SeatTab.TurretTraverseSound)
							seat.TurretHorizontal:SetSoundLevel(SeatTab.TurretTraverseSoundLevel)
							seat.TurretHorizontal:Play()
						end
						
						if SeatTab.TurretElevationSound then
							seat.TurretVertical = CreateSound(seat,SeatTab.TurretElevationSound)
							seat.TurretVertical:SetSoundLevel(SeatTab.TurretElevationSoundLevel)
							seat.TurretVertical:Play()
						end
						
						seat:CallOnRemove("StopTurretRotationSounds",function(seat)
							if seat.TurretHorizontal then seat.TurretHorizontal:Stop() end
							if seat.TurretVertical then seat.TurretVertical:Stop() end
						end)
						
						seat.TurretTraverseSpeed = (SeatTab.TurretTraverseSpeed / tick) * vehicle.gred_sv_simfphys_traverse_speed_multiplier
						seat.TurretElevationSpeed = (SeatTab.TurretElevationSpeed / tick) * vehicle.gred_sv_simfphys_elevation_speed_multiplier
					end
					
					seat.SynchronousElevation = SeatTab.SynchronousElevation or vehicle.gred_sv_simfphys_forcesynchronouselevation
					
					if SeatTab.SmokeLaunchers then
						SetNWInt(seat,"SmokeGrenades",#SeatTab.SmokeLaunchers)
						
						local v
						
						for k = 1,#SeatTab.SmokeLaunchers do
							v = SeatTab.SmokeLaunchers[k]
							
							if v then
								vehicle.Attachments[v] = vehicle.Attachments[v] or vehicle:LookupAttachment(v)
							end
						end
					end
					
					if SeatTab.Primary then
						seat.Primary = {}
						local WepID,WepTab
						
						for WepID = 1,#SeatTab.Primary do
							WepTab = SeatTab.Primary[WepID]
							if WepTab then
								seat.Primary[WepID] = {}
								gred.TankInitMuzzleAttachments(vehicle,seat,seat.Primary[WepID],WepTab,WepID)
							end
						end
					end
					
					if SeatTab.Secondary then
						if SeatTab.Secondary.Type == "Cannon" then
							ErrorNoHalt(vehicle.CachedSpawnList.." : '"..SeatTab.Secondary.Type.."' type secondary weapons are not supported!")
						else
							seat.Secondary = {}
							gred.TankInitMuzzleAttachments(vehicle,seat,seat.Secondary,SeatTab.Secondary)
						end
					end
				end
			end
		end
	end
end

gred.TankInitTracks = function(vehicle,TracksTab,TankSteerTab) -- doesn't need to be optimized
	if TracksTab and TracksTab.SeparateTracks then
		local pos,ang = GetPos(vehicle),vehicle:GetAngles()
		
		local ent = ents.Create("gred_prop_part")
		ent:SetPos(pos)
		ent:SetAngles(ang)
		
		ent.Model = TracksTab.RightTrackModel
		ent.PhysicsCollide = nil
		ent.Think = nil
		ent.OnTakeDamage = nil
		
		ent:Spawn()
		ent:Activate()
		
		ent:SetAutomaticFrameAdvance(true)
		ent:SetParent(vehicle)
		
		vehicle.RightTrack = ent
		vehicle:SetNWEntity("RightTrack",ent)
		
		local ent = ents.Create("gred_prop_part")
		ent:SetPos(pos)
		ent:SetAngles(ang)
		
		ent.Model = TracksTab.LeftTrackModel
		ent.PhysicsCollide = nil
		ent.Think = nil
		ent.OnTakeDamage = nil
		
		ent:Spawn()
		ent:Activate()
		
		ent:SetAutomaticFrameAdvance(true)
		ent:SetParent(vehicle)
		
		vehicle.LeftTrack = ent
		vehicle:SetNWEntity("LeftTrack",ent)
	end
	
	if TankSteerTab then
		-- if gred.CVars.gred_sv_simfphys_lesswheels:GetBool() then
			-- for index = 5,6 do
				-- vehicle.GhostWheels[index]:Remove()
				-- vehicle.GhostWheels[index] = nil
				-- vehicle.Wheels[index]:Remove()
				-- vehicle.Wheels[index] = nil
			-- end
		-- end
		local tab = {}
		vehicle.GetTransformedDirection = function(vehicle)
			tab.Forward = vehicle.Forward
			tab.Right = vehicle.Right
			tab.Forward2 = vehicle.Forward
			tab.Right2 = vehicle.Right
			return tab
		end
		
		vehicle.NoIdleTurning = !TankSteerTab.HasNeutralSteering
	end
end

gred.TankInitSuspensions = function(vehicle,SusDataTab,TracksTab) -- doesn't need to be optimized
	if SusDataTab then
		local v
		
		for k = 1,#SusDataTab do
			v = SusDataTab[k]
			if v then
				v.AttachmentID = (TracksTab and TracksTab.SeparateTracks and (k > #SusDataTab*0.5 and vehicle.RightTrack or vehicle.LeftTrack) or vehicle):LookupAttachment(v.Attachment)
			end
		end
		
		if not vehicle.SuspensionTable then
			vehicle.SuspensionTable = {}
			
			local vehent = vehicle.LeftTrack and vehicle.LeftTrack or vehicle
			
			for i = 1,#SusDataTab*0.5 do
				vehicle.SuspensionTable[i] = EnityWorldToLocal(vehicle,vehent:GetAttachment(SusDataTab[i].AttachmentID).Pos)
			end
			
			vehent = vehicle.RightTrack and vehicle.RightTrack or vehicle
			
			for i = 1 + #SusDataTab*0.5,#SusDataTab do
				vehicle.SuspensionTable[i] = EnityWorldToLocal(vehicle,vehent:GetAttachment(SusDataTab[i].AttachmentID).Pos)
			end
		end
		-- if not vehicle.SuspensionTables then
			-- vehicle.SuspensionTables = {{},{}}
			
			-- local vehent = vehicle.LeftTrack and vehicle.LeftTrack or vehicle
			
			-- vehicle.SuspensionTables[1].SuspensionPos = EnityWorldToLocal(vehicle,vehent:GetAttachment(SusDataTab[1].AttachmentID).Pos)
			-- vehicle.SuspensionTables[1].SuspensionMaxs = vehicle.SuspensionTables[1].SuspensionPos + vec
			-- vehicle.SuspensionTables[1].SuspensionMins = EnityWorldToLocal(vehicle,vehent:GetAttachment(SusDataTab[#SusDataTab*0.5].AttachmentID).Pos) - vec
			
			-- vehent = vehicle.RightTrack and vehicle.RightTrack or vehicle
			
			-- vehicle.SuspensionTables[2].SuspensionPos = EnityWorldToLocal(vehicle,vehent:GetAttachment(vehent:LookupAttachment(susTable[#susTable*0.5+1].attachment)).Pos) + vec
			-- vehicle.SuspensionTables[2].SuspensionMaxs = vehicle.SuspensionTables[2].SuspensionPos
			-- vehicle.SuspensionTables[2].SuspensionMins = EnityWorldToLocal(vehicle,vehent:GetAttachment(vehent:LookupAttachment(susTable[#susTable].attachment)).Pos) - vec
			
			-- for i = 1,2 do
				-- vehicle.SuspensionTables[i].SuspensionStart = Vector(vehicle.SuspensionTables[i].SuspensionMins.x,0,vehicle.SuspensionTables[i].SuspensionMins.z)
				-- vehicle.SuspensionTables[i].SuspensionEnd = Vector(vehicle.SuspensionTables[i].SuspensionMaxs.x,0,vehicle.SuspensionTables[i].SuspensionMaxs.z)
				
				-- vehicle.SuspensionTables[i].SuspensionMaxs.x = 0
				-- vehicle.SuspensionTables[i].SuspensionMaxs.z = 0
				
				-- vehicle.SuspensionTables[i].SuspensionMins.x = 0
				-- vehicle.SuspensionTables[i].SuspensionMins.z = susHeight
			-- end
		-- end
	end
end

gred.TankInitModules = function(vehicle,VehicleTab) -- doesn't need to be optimized
	local ModulesTab = VehicleTab.Armour and VehicleTab.Armour.Modules or nil
	if ModulesTab then
		vehicle.ModuleAttachments = {}
		local v
		for Name,Tab in pairs(ModulesTab) do
			for k = 1,#Tab do
				v = Tab[k]
				SetNWInt(vehicle,"ModuleHealth_"..Name.."_"..v.ID,100)
				vehicle:SetNWVarProxy("ModuleHealth_"..Name.."_"..v.ID,function(ent,name,oldval,newval)
					if oldval and oldval != newval then
						gred.ModuleHealthChanged(vehicle,Name,v.ID,name,newval,oldval)
					end
				end)
				if v and v.Attachment then
					vehicle.Attachments[v.Attachment] = vehicle.Attachments[v.Attachment] or vehicle:LookupAttachment(v.Attachment)
					vehicle.ModuleAttachments[v.Attachment] = vehicle.Attachments[v.Attachment]
				end
			end
		end
	end
end

gred.TankInitMuzzleAttachments = function(vehicle,seat,SeatSlotTab,WeaponTab,WepID) -- doesn't need to be optimized
	if WeaponTab.Type == "Custom" and WeaponTab.InitSV then
		if WeaponTab.InitSV(vehicle,seat,SeatSlotTab,WeaponTab,WepID) then return end
	end
	
	if WeaponTab.Muzzles then
		SeatSlotTab.Muzzles = {}
		SeatSlotTab.NextShot = 0
		SeatSlotTab.CurrentMuzzle = 1
		SeatSlotTab.UpdateTracers = {}
		SeatSlotTab.Tracers = {}
		
		local v
		for k = 1,#WeaponTab.Muzzles do
			v = WeaponTab.Muzzles[k]
			if v then
				vehicle.Attachments[v] = vehicle.Attachments[v] or vehicle:LookupAttachment(v)
				SeatSlotTab.Muzzles[k] = vehicle.Attachments[v]
				SeatSlotTab.Tracers[k] = 0
				SeatSlotTab.UpdateTracers[k] = function()
					SeatSlotTab.Tracers[k] = SeatSlotTab.Tracers[k] + 1
					if SeatSlotTab.Tracers[k] >= gred.CVars.gred_sv_tracers:GetInt() then
						SeatSlotTab.Tracers[k] = 0
						return WeaponTab.TracerColor
					else
						return false
					end
				end
			end
		end
		
		if WeaponTab.Type == "MG" or WeaponTab.Type == "RocketLauncher" then
			SeatSlotTab.FireRate = (60 / WeaponTab.FireRate) / (WeaponTab.Sequential and #WeaponTab.Muzzles or 1)
			SeatSlotTab.Ammo = WeaponTab.Ammo
			
			if WeaponTab.Type == "RocketLauncher" then
				SeatSlotTab.ReloadTime = WeaponTab.ReloadTime * gred.CVars.gred_sv_simfphys_reload_speed_multiplier:GetFloat()
			end
			
			if !WepID then
				SetNWInt(seat,"SecondaryAmmo",SeatSlotTab.Ammo)
			else
				SetNWInt(seat,WepID.."CurAmmo",SeatSlotTab.Ammo)
			end
		elseif WeaponTab.Type == "Flamethrower" then
			seat.FlameThrowerSound = CreateSound(vehicle,"gredwitch/flamethrower/flamethrower_looping.wav")
			seat.FlameThrowerSound:Stop()
			
			SeatSlotTab.BadFlamethrowerClasses = table.Copy(BadFlamethrowerClasses)
			
			SeatSlotTab.RayMins = Vector(-WeaponTab.RaySize,-WeaponTab.RaySize,-WeaponTab.RaySize)
			SeatSlotTab.RayMaxs = Vector(WeaponTab.RaySize,WeaponTab.RaySize,WeaponTab.RaySize)
			SeatSlotTab.FireBallMins = Vector(-WeaponTab.FireBallSize,-WeaponTab.FireBallSize,-WeaponTab.FireBallSize)
			SeatSlotTab.FireBallMaxs = Vector(WeaponTab.FireBallSize,WeaponTab.FireBallSize,WeaponTab.FireBallSize)
			SeatSlotTab.FireParticles = {}
			local v
			for k = 1,#WeaponTab.Muzzles do
				v = WeaponTab.Muzzles[k]
				if v then
					local att = GetAttachment(vehicle,SeatSlotTab.Muzzles[k])
					local FireParticle = ents.Create( "info_particle_system" )
					FireParticle:SetKeyValue("effect_name",WeaponTab.Effect)
					FireParticle:SetKeyValue("start_active",1)
					FireParticle:SetOwner(vehicle)
					FireParticle:SetPos(EntityLocalToWorld(vehicle,EnityWorldToLocal(vehicle,att.Pos) - Vector(30)))
					FireParticle:SetAngles(att.Ang)
					FireParticle:Spawn()
					FireParticle:Activate()
					FireParticle:SetParent(vehicle,SeatSlotTab.Muzzles[k])
					FireParticle:Fire("Stop")
					
					SeatSlotTab.FireParticles[k] = FireParticle
				end
			end
			
			if CreateVFireBall then
				SeatSlotTab.BadFlamethrowerClasses["gmod_sent_vehicle_fphysics_base"] = true
				-- SeatSlotTab.BadFlamethrowerClasses["gmod_sent_vehicle_fphysics_wheel"] = true
				if gred.CVars.gred_sv_simfphys_vfire_thrower:GetBool() then
					SeatSlotTab.ShouldNotFlamesBounce = true
					SeatSlotTab.ThrowFlames = function(SeatSlotTab,pos1,pos2,mins,maxs,time,dmg,DMG,shootOrigin,sqrdist,tr,ang)
						CreateVFireBall(time,100,shootOrigin,Forward(ang)*random(2400,2700),dmg:GetAttacker())
					end
				else
					SeatSlotTab.ThrowFlames = function(SeatSlotTab,pos1,pos2,mins,maxs,time,dmg,DMG,shootOrigin,sqrdist)
						local v
						local Ray = ents.FindAlongRay(pos1,pos2,mins,maxs)
						for k = 1,#Ray do
							v = Ray[k]
							if v and !vehicle.FILTER_BYENT[v] and GetParent(v) != vehicle and ((v.InVehicle and !v:InVehicle()) or !v.InVehicle) and !SeatSlotTab.BadFlamethrowerClasses[GetClass(v)] then
								Ignite(v,time)
							end
						end
					end
				end
			else
				SeatSlotTab.ThrowFlames = function(SeatSlotTab,pos1,pos2,mins,maxs,time,dmg,DMG,shootOrigin,sqrdist)
					local v
					local Ray = ents.FindAlongRay(pos1,pos2,mins,maxs)
					for k = 1,#Ray do
						v = Ray[k]
						if v and !vehicle.FILTER_BYENT[v] and GetParent(v) != vehicle and ((v.InVehicle and !v:InVehicle()) or !v.InVehicle) and !SeatSlotTab.BadFlamethrowerClasses[GetClass(v)] then
							Ignite(v,time)
							if !v.GRED_ISTANK then
								SetDamage(dmg,DistToSqr(DMG*GetPos(v),shootOrigin)/(sqrdist))
								TakeDamageInfo(v,dmg)
							end
						end
					end
				end
			end
		elseif WeaponTab.Type == "Cannon" and WepID then
			SeatSlotTab.NextShot = 0
			SeatSlotTab.CurShellID = 1
			SeatSlotTab.ShellTypes = {}
			SeatSlotTab.AmmoPerShell = floor(WeaponTab.MaxAmmo / #WeaponTab.ShellTypes)
			SeatSlotTab.ExtraAmmo = WeaponTab.MaxAmmo % #WeaponTab.ShellTypes
			SeatSlotTab.IsLoaded = true
			SeatSlotTab.ReloadTime = WeaponTab.ReloadTime * gred.CVars.gred_sv_simfphys_reload_speed_multiplier:GetFloat()
			
			if gred.CVars.gred_sv_simfphys_spawnwithoutammo:GetBool() then
				for k = 1,#WeaponTab.ShellTypes do
					SeatSlotTab.ShellTypes[k] = 0
				end
			else
				for k = 1,#WeaponTab.ShellTypes do
					SeatSlotTab.ShellTypes[k] = SeatSlotTab.AmmoPerShell
					SetNWInt(seat,WepID.."CurAmmo"..k,SeatSlotTab.ShellTypes[k] + (k == 1 and SeatSlotTab.ExtraAmmo or 0))
				end
			end
		end
	end
end



gred.HandleWheelSpin = function(vehicle,WheelsLocked,VAL1,VAL2)
	VAL1 = floor(vehicle.VehicleData["spin_4"] + vehicle.VehicleData["spin_6"])
	VAL2 = floor(vehicle.VehicleData["spin_3"] + vehicle.VehicleData["spin_5"])
	-- if vehicle.OLD_WHEELSPIN_VAL1 != VAL1 and vehicle.OLD_WHEELSPIN_VAL2 != VAL2 then
		if abs(VAL1) > 16383 or WheelsLocked then
			for i = 3,6 do
				vehicle.VehicleData["spin_"..i] = 0
			end
		end
		netStart("gred_net_simfphys_update_tracks",true)
			netWriteEntity(vehicle)
			netWriteInt(VAL1,15)
			netWriteInt(VAL2,15)
		netBroadcast()
	-- end
	-- vehicle.OLD_WHEELSPIN_VAL1 = VAL1
	-- vehicle.OLD_WHEELSPIN_VAL2 = VAL2
end

gred.HandleHandBrakeSound = function(vehicle,WheelsLocked,vel,TracksTab)
	if vehicle.susOnGround and floor(LengthSqr(vel)*0.00006) > 0 then
		if vehicle.OldHandBrake != WheelsLocked then
			if WheelsLocked then
				vehicle.HandBrakePower = TracksTab.HandBrakePower or vehicle.HandBrakePower
				if !vehicle.TrackRattleSound or !IsPlaying(vehicle.TrackRattleSound) then
					vehicle.TrackRattleSound = CreateSound(vehicle,"tracksounds/turn_rattle_0"..random(8)..".wav")
					vehicle.TrackRattleSound:SetSoundLevel(TracksTab.TrackSoundLevel)
					vehicle.TrackRattleSound:PlayEx(0,100)
					vehicle.TrackRattleSound:ChangeVolume(1,0.1)
					CallOnRemove(vehicle,"RemoveRattleSound",function(vehicle)
						if vehicle.TrackRattleSound then
							vehicle.TrackRattleSound:Stop()
						end
					end)
				end
			else
				if vehicle.TrackRattleSound and IsPlaying(vehicle.TrackRattleSound) then
					vehicle.TrackRattleSound:FadeOut(1)
				end
			end
		end
	else
		if vehicle.TrackRattleSound and IsPlaying(vehicle.TrackRattleSound) then
			vehicle.TrackRattleSound:FadeOut(1)
		end
	end
	vehicle.OldHandBrake = WheelsLocked
end

gred.HandleSeats = function(vehicle,Mode,VehicleSeatTab,gredTankGetDriverLocalAngles)
	-- if true then return end
	local ply
	local Angles
	local SlotID
	local InfoNum
	local pos,ang
	local vehang
	local IsShooting
	local CanShoot
	local IsKeyDown
	local HatchID
	local v
	local SeatTab
	local PoseParamTab
	local PrimaryTab
	local SecondaryTab
	local ChangedAngles
	local WalkDown
	
	local ct = CurTime()
	
	for k = 0,#VehicleSeatTab do
		v = VehicleSeatTab[k]
		SeatTab = v and v[Mode]
		
		if SeatTab then
			seat = k == 0 and vehicle:GetDriverSeat() or (vehicle.pSeat and vehicle.pSeat[k] or nil)
			
			if IsValid(seat) then
				if SeatTab.TurretTraverseSound then
					ChangePitch(seat.TurretHorizontal,seat.VAL_TurretHorizontal*SeatTab.TurretTraverseSoundPitch,0.3)
					ChangeVolume(seat.TurretHorizontal,seat.VAL_TurretHorizontal,0.5)
					
					if GetVolume(seat.TurretHorizontal) > 0.7 then
						if seat.OLD_VAL_TurretHorizontal != seat.VAL_TurretHorizontal and seat.VAL_TurretHorizontal == 1 then
							seat:EmitSound("GRED_SIMFPHYS_TURRET_KLANK_"..random(11))
						end
						
						seat.OLD_VAL_TurretHorizontal = seat.VAL_TurretHorizontal
					end
				end
				
				if SeatTab.TurretElevationSound then
					ChangePitch(seat.TurretVertical,seat.VAL_TurretVertical*SeatTab.TurretElevationSoundPitch,0.3)
					ChangeVolume(seat.TurretVertical,seat.VAL_TurretVertical)
				end
				
				seat.VAL_TurretHorizontal = 0
				seat.VAL_TurretVertical = 0
				ply = seat:GetDriver()
				
				if IsValid(ply) then
					SlotID = GetNWInt(seat,"SlotID",1)
					HatchID = GetNWInt(seat,"HatchID",0)
					PoseParamTab = SeatTab.PoseParameters
					
					if PoseParamTab then
						WalkDown = KeyDown(ply,IN_WALK)
						
						seat.PressingWalk = WalkDown
						
						-- if seat.PressingWalk and seat.PressingWalk != seat.OldPressingWalk then
							-- if seat.LastWalkPress + 0.17 + Ping(ply)*0.001 > ct then
								-- SetNWBool(seat,"TurretDisabled",!GetNWBool(seat,"TurretDisabled"))
							-- end
							
							-- seat.LastWalkPress = ct
						-- end
						
						if !GetNWBool(seat,"TurretDisabled") and !WalkDown then
							Angles = gred.TankGetDriverLocalAngles(vehicle,seat,SeatTab,ply,HatchID,PoseParamTab)
							
							if Angles then
								if PoseParamTab.Yaw then
									for PoseParam,Tab in pairs(PoseParamTab.Yaw) do
										ChangedAngles = (Tab.Offset and Tab.Offset != 0) and Angles + Angle(0,Tab.Offset) or Angles
										Normalize(ChangedAngles)
										SetPoseParameter(vehicle,PoseParam,(Tab.Invert and -ChangedAngles.y or ChangedAngles.y) * (Tab.Mul or 1))
									end
								end
								
								if PoseParamTab.Pitch then
									for PoseParam,Tab in pairs(PoseParamTab.Pitch) do
										ChangedAngles = (Tab.Offset and Tab.Offset != 0) and Angles + Angle(Tab.Offset) or Angles
										Normalize(ChangedAngles)
										SetPoseParameter(vehicle,PoseParam,(Tab.Invert and -ChangedAngles.p or ChangedAngles.p) * (Tab.Mul or 1))
									end
								end
							end
							
							if PoseParamTab.Custom then
								PoseParamTab.Custom(vehicle,seat,ply,Angles,ct,SlotID,SeatTab)
							end
						end
						
						seat.OldPressingWalk = seat.PressingWalk
					end
					
					if seat.NextSetPos < ct then -- stinky hack
						SetPos(ply,vector_zero)
						seat.NextSetPos = seat.NextSetPos + 2
					end
					
					if SeatTab.Hatches and #SeatTab.Hatches == 1 then
						local HatchTab = SeatTab.Hatches[1]
						
						if HatchTab.SeatAttachment then
							vehicle.Attachments[HatchTab.SeatAttachment] = vehicle.Attachments[HatchTab.SeatAttachment] or vehicle:LookupAttachment(HatchTab.SeatAttachment)
						end
						
						if seat.OldHatch and !seat.Hatch then
							gred.TankToggleHatch(seat,k,vehicle,ply,HatchID == 0 and 1 or 0,HatchID,SeatTab)
						end
						
						seat.OldHatch = seat.Hatch
					end
					
					if (SeatTab.RequiresHatch and SeatTab.RequiresHatch[HatchID] or (!SeatTab.RequiresHatch and HatchID == 0)) and SeatTab.IsLoader and vehicle.gred_sv_simfphys_manualreloadsystem and VehicleSeatTab[SeatTab.IsLoader] and VehicleSeatTab[SeatTab.IsLoader][Mode] and VehicleSeatTab[SeatTab.IsLoader][Mode].Primary then
						local Seat = SeatTab.IsLoader == 0 and vehicle.DriverSeat or vehicle.pSeat[SeatTab.IsLoader]
						local SeatSlotID = GetNWInt(seat,"SlotID",1)
						local LoadingPrimaryTab = VehicleSeatTab[SeatTab.IsLoader][Mode].Primary[SeatSlotID]
						
						if LoadingPrimaryTab then
							if seat.OldCannonShell and !seat.CannonShell and LoadingPrimaryTab.ShellTypes and #LoadingPrimaryTab.ShellTypes > 1 then
								local Shell = GetNWFloat(Seat,SeatSlotID.."ShellType",1) + 1
								
								if Shell > #LoadingPrimaryTab.ShellTypes then
									Shell = 1
								end
								
								Seat.Primary[SeatSlotID].NextShot = ct + Seat.Primary[SeatSlotID].ReloadTime
								Seat.Primary[SeatSlotID].CurShellID = Shell
								SetNWInt(Seat,SeatSlotID.."ShellType",Seat.Primary[SeatSlotID].CurShellID)
								SetNWFloat(Seat,SeatSlotID.."NextShot",Seat.Primary[SeatSlotID].NextShot)
								
								-- if LoadingPrimaryTab.OnShellTypeChanged then
									-- LoadingPrimaryTab.OnShellTypeChanged(vehicle,Seat,SeatTab.IsLoader,LoadingPrimaryTab,SeatSlotID)
								-- end
								
								if LoadingPrimaryTab.OnReload then
									LoadingPrimaryTab.OnReload(vehicle,Seat,SeatTab.IsLoader,LoadingPrimaryTab,Seat.Primary[SeatSlotID],SeatSlotID)
								end
							end
							
							seat.OldCannonShell = seat.CannonShell
							
							seat.Reload = KeyDown(ply,IN_RELOAD)
							
							if seat.OldReload and !seat.Reload then
								Seat.Primary[SeatSlotID].NextShot = ct + Seat.Primary[SeatSlotID].ReloadTime
								SetNWFloat(Seat,SeatSlotID.."NextShot",Seat.Primary[SeatSlotID].NextShot)
								
								if LoadingPrimaryTab.OnReload then
									LoadingPrimaryTab.OnReload(vehicle,Seat,SeatTab.IsLoader,LoadingPrimaryTab,Seat.Primary[SeatSlotID],SeatSlotID)
								end
							end
							
							seat.OldReload = seat.Reload
						end
					end
					
					if SeatTab.SmokeLaunchers then
						if seat.OldSmokeGrenade and !seat.SmokeGrenade then
							if gred.TankCanDeploySmoke(vehicle,seat,ply,ct,SeatTab,HatchID) then
								gred.TankDeploySmoke(vehicle,seat,SeatTab.SmokeLaunchers,SeatTab)
							end
						end
						
						seat.OldSmokeGrenade = seat.SmokeGrenade
					end
					
					PrimaryTab = SeatTab.Primary and SeatTab.Primary[SlotID] or nil
					
					if PrimaryTab then
						if !vehicle.gred_sv_simfphys_manualreloadsystem or PrimaryTab.AutoLoader then
							if seat.OldCannonShell and !seat.CannonShell and PrimaryTab.ShellTypes and #PrimaryTab.ShellTypes > 1 then
								local SeatSlotTab = SlotID and seat.Primary[SlotID] or seat.Secondary
								local Shell = GetNWFloat(seat,SlotID.."ShellType",1) + 1
								
								if Shell > #PrimaryTab.ShellTypes then
									Shell = 1
								end
								
								SeatSlotTab.NextShot = ct + SeatSlotTab.ReloadTime
								SeatSlotTab.CurShellID = Shell
								
								SetNWInt(seat,SlotID.."ShellType",SeatSlotTab.CurShellID)
								SetNWFloat(seat,SlotID.."NextShot",SeatSlotTab.NextShot)
								
								if PrimaryTab.OnReload then
									PrimaryTab.OnReload(vehicle,seat,SeatID,PrimaryTab,SeatSlotTab,SeatSlotID)
								end
							end
							
							seat.OldCannonShell = seat.CannonShell
						end
						
						CanShoot,IsShooting,IsKeyDown = nil,nil,KeyDown(ply,IN_ATTACK)
						
						if IsKeyDown then
							CanShoot,IsShooting = gred.TankCanShoot(vehicle,seat,ply,ct,SeatTab,PrimaryTab,SlotID,HatchID)
							
							if CanShoot then
								gred.TankStartShooting(vehicle,seat,ply,ct,SeatTab,PrimaryTab,k,SlotID)
								seat.PrimaryAttacking = true
								seat.CurPrimaryShot = seat.CurPrimaryShot + 1
							end
							
							seat:SetNWBool("IsPrimaryAttacking",true)
						end
						
						if (IsKeyDown and !IsShooting) or !IsKeyDown then
							if seat.PrimaryAttacking then
								gred.TankStopShooting(vehicle,seat,ply,ct,SeatTab,PrimaryTab,k,SlotID)
							end
							
							seat.PrimaryAttacking = false
							seat:SetNWBool("IsPrimaryAttacking",false)
						end
						
						if #SeatTab.Primary > 1 then
							if seat.OldSlotID and seat.OldSlotID != seat.SlotID then
								SlotID = SlotID + 1
								SlotID = SlotID > #SeatTab.Primary and 1 or SlotID
								SetNWInt(seat,"SlotID",SlotID)
							end
							
							seat.OldSlotID = seat.SlotID
						end
					end
					
					SecondaryTab = SeatTab.Secondary
					
					if SecondaryTab then
						CanShoot,IsShooting,IsKeyDown = nil,nil,KeyDown(ply,IN_ATTACK2)
						
						if IsKeyDown then
							CanShoot,IsShooting = gred.TankCanShoot(vehicle,seat,ply,ct,SeatTab,SecondaryTab,nil,HatchID)
							
							if CanShoot then
								gred.TankStartShooting(vehicle,seat,ply,ct,SeatTab,SecondaryTab,k)
								seat.SecondaryAttacking = true
								seat.CurSecondaryShot = seat.CurSecondaryShot + 1
							end
							
							seat:SetNWBool("IsSecondaryAttacking",true)
						end
						
						if (IsKeyDown and !IsShooting) or !IsKeyDown then
							if seat.SecondaryAttacking then
								gred.TankStopShooting(vehicle,seat,ply,ct,SeatTab,SecondaryTab,k)
							end
							
							seat.SecondaryAttacking = false
							seat:SetNWBool("IsSecondaryAttacking",false)
						end
					end
				else
					if seat.PrimaryAttacking then
						ID = 1
						gred.TankStopShooting(vehicle,seat,ply,ct,SeatTab,PrimaryTab,k,SlotID)
					end
					
					if seat.SecondaryAttacking then
						gred.TankStopShooting(vehicle,seat,ply,ct,SeatTab,SecondaryTab,k)
					end
					
					seat.PrimaryAttacking = false
					seat.SecondaryAttacking = false
					
					seat:SetNWBool("IsPrimaryAttacking",false)
					seat:SetNWBool("IsSecondaryAttacking",false)
					
					seat.CurPrimaryShot = 0
					seat.CurSecondaryShot = 0
				end
			end
		end
	end
	
	return ct
end

gred.ModuleHealthChanged = function(vehicle,Name,ID,VarName,NewVal,OldVal)
	if Name == "Ammo" then
		if NewVal <= 0 then
			local Ratio = OldVal / 100 
			vehicle.DestructionType = Ratio >= 0.5 and 6 or 4
			local dmg = DamageInfo()
			SetAttacker(dmg,vehicle.LastShellAttacker)
			SetInflictor(dmg,vehicle.LastShellInflictor)
			dmg:SetDamagePosition(dmg,vehicle.LastShellPos)
			SetDamage(dmg,vehicle:GetMaxHealth())
			SetDamageType(dmg,64) -- DMG_BLAST
			TakeDamageInfo(vehicle,dmg)
		end
	elseif Name == "Engine" then
		if vehicle:GetCurHealth() > 200 then
			local Health = max(200 + (vehicle:GetMaxHealth() * Clamp(NewVal / 100,0,1)),200)
			vehicle:SetCurHealth(Health)
			SetNWFloat(vehicle,"Health",Health)
			
			local dmg = DamageInfo()
			SetAttacker(dmg,vehicle.LastShellAttacker)
			SetInflictor(dmg,vehicle.LastShellInflictor)
			dmg:SetDamagePosition(vehicle.LastShellPos)
			SetDamage(dmg,0.1)
			SetDamageType(dmg,64) -- DMG_BLAST
			TakeDamageInfo(vehicle,dmg)
			
			if Name == "Engine" and (OldVal >= 30 and NewVal <= 0) then
				vehicle:Ignite(180)
			end
		end
	elseif Name == "Transmission" then
		for k,v in pairs(vehicle.Gears) do
			v = v * (NewVal / 100)
		end
	elseif Name == "LeftTrack" or Name == "RightTrack" then
		if OldVal <= 0 and NewVal > 0 then
			vehicle.PressedKeys.Space = false
		end
	elseif Name == "GunBreach" then
	
	elseif Name == "MG" then
		-- (vehicle.gred_sv_simfphys_moduledamagesystem and WeaponTab.GunBreachModule) and GetNWInt(vehicle,"ModuleHealth_GunBreach_"..WeaponTab.GunBreachModule,100) > 0 or !(vehicle.gred_sv_simfphys_moduledamagesystem and WeaponTab.GunBreachModule)
	end
end



gred.TankCanShoot = function(vehicle,seat,ply,ct,SeatTab,WeaponTab,SlotID,HatchID)
	local SeatSlotTab = SlotID and seat.Primary[SlotID] or seat.Secondary
	
	if WeaponTab.Type == "Cannon" then
		return gred.TankCanShootCannon(vehicle,seat,ply,ct,SeatTab,WeaponTab,SeatID,SeatSlotTab,SlotID,HatchID)
	elseif WeaponTab.Type == "MG" or WeaponTab.Type == "RocketLauncher"  then
		return gred.TankCanShootMG(vehicle,seat,ply,ct,SeatTab,WeaponTab,SeatID,SeatSlotTab,SlotID,HatchID)
	elseif WeaponTab.Type == "Flamethrower" then
		return gred.TankCanShootFlamethrower(vehicle,seat,ply,ct,SeatTab,WeaponTab,SeatID,SeatSlotTab,SlotID,HatchID)
	elseif WeaponTab.Type == "Custom" then
		return WeaponTab.CanShoot(vehicle,seat,ply,ct,SeatTab,WeaponTab,SeatID,SeatSlotTab,SlotID,HatchID)
	end
end

gred.TankStartShooting = function(vehicle,seat,ply,ct,SeatTab,WeaponTab,SeatID,SlotID)
	local SeatSlotTab = SlotID and seat.Primary[SlotID] or seat.Secondary
	if WeaponTab.Type == "Cannon" then
		gred.TankShootCannon(vehicle,seat,ply,ct,SeatTab,WeaponTab,SeatID,SeatSlotTab,SlotID)
	elseif WeaponTab.Type == "MG" then
		gred.TankShootMG(vehicle,seat,ply,ct,SeatTab,WeaponTab,SeatID,SeatSlotTab,SlotID)
	elseif WeaponTab.Type == "RocketLauncher"  then
		gred.TankShootRocketLauncher(vehicle,seat,ply,ct,SeatTab,WeaponTab,SeatID,SeatSlotTab,SlotID)
	elseif WeaponTab.Type == "Flamethrower" then
		gred.TankShootFlamethrower(vehicle,seat,ply,ct,SeatTab,WeaponTab,SeatID,SeatSlotTab,SlotID)
	elseif WeaponTab.Type == "Custom" then
		WeaponTab.Shoot(vehicle,seat,ply,ct,SeatTab,WeaponTab,SeatID,SeatSlotTab,SlotID)
	end
end

gred.TankStopShooting = function(vehicle,seat,ply,ct,SeatTab,WeaponTab,SeatID,SlotID)
	if !WeaponTab then return end
	local SeatSlotTab = SlotID and seat.Primary[SlotID] or seat.Secondary
	if WeaponTab.Type == "Cannon" then
		gred.TankStopCannon(vehicle,seat,ply,ct,SeatTab,WeaponTab,SeatID,SeatSlotTab,SlotID)
	elseif WeaponTab.Type == "MG" then
		gred.TankStopMG(vehicle,seat,ply,ct,SeatTab,WeaponTab,SeatID,SeatSlotTab,SlotID)
	elseif WeaponTab.Type == "Flamethrower" then
		gred.TankStopFlamethrower(vehicle,seat,ply,ct,SeatTab,WeaponTab,SeatID,SeatSlotTab,SlotID)
	elseif WeaponTab.Type == "Custom" then
		WeaponTab.Stop(vehicle,seat,ply,ct,SeatTab,WeaponTab,SeatID,SeatSlotTab,SlotID)
	end
end



gred.TankShootCannon = function(vehicle,seat,ply,ct,SeatTab,WeaponTab,SeatID,SeatSlotTab,SlotID)
	local v
	local ShellTab = WeaponTab.ShellTypes[SeatSlotTab.CurShellID]
	for k = 1,#SeatSlotTab.Muzzles do
		v = SeatSlotTab.Muzzles[k]
		if v then
			local att = GetAttachment(vehicle,v)
			
			if WeaponTab.ShootAnimation then
				vehicle:ResetSequence(WeaponTab.ShootAnimation)
			end

			if WeaponTab.PreFire then
				WeaponTab.PreFire(vehicle,seat,ply,ct,SeatTab,WeaponTab,SeatID,SeatSlotTab,SlotID,k,v,att)
			end
			
			local shell = gred.CreateShell(att.Pos,att.Ang,ply,vehicle.FILTER,ShellTab.Caliber,ShellTab.ShellType,ShellTab.MuzzleVelocity,ShellTab.Mass,ShellTab.TracerColor,ShellTab.CustomDamage,ShellTab.CallBack,ShellTab.TNTEquivalent,ShellTab.ExplosiveMass,ShellTab.LinearPenetration,ShellTab.Normalization,ShellTab.CoreMass,ShellTab.ForceDragCoef,ShellTab.DamageAdd,vehicle:GetVelocity())
			shell:Launch()
			
			ApplyForceOffset(GetPhysicsObject(vehicle),-Forward(att.Ang) * WeaponTab.RecoilForce,att.Pos)
			
			if !vehicle.gred_sv_simfphys_infinite_ammo then
				SeatSlotTab.ShellTypes[SeatSlotTab.CurShellID] = SeatSlotTab.ShellTypes[SeatSlotTab.CurShellID] - 1
				SetNWInt(seat,SlotID.."CurAmmo"..SeatSlotTab.CurShellID,SeatSlotTab.ShellTypes[SeatSlotTab.CurShellID])
			end
			
			if WeaponTab.OnFire then
				WeaponTab.OnFire(vehicle,seat,ply,ct,SeatTab,WeaponTab,SeatID,SeatSlotTab,SlotID,k,v,shell)
			end
			
			if SeatSlotTab.ShellTypes[SeatSlotTab.CurShellID] < 1 then break end
		end
	end
	if SeatSlotTab.ShellTypes[SeatSlotTab.CurShellID] > 0 then
		SeatSlotTab.NextShot = ct + ((vehicle.gred_sv_simfphys_manualreloadsystem and !WeaponTab.AutoLoader) and 99999999 or SeatSlotTab.ReloadTime)
		-- SeatSlotTab.NextShot = ct + WeaponTab.ReloadTime
		SetNWFloat(seat,SlotID.."NextShot",SeatSlotTab.NextShot)
	end
	
	SeatSlotTab.IsLoaded = false
	
	netStart("gred_net_simfphys_shoot_"..(SlotID and "primary" or "secondary").."_tankCannon")
		netWriteEntity(seat)
	netBroadcast()
	
	if SeatSlotTab.PostFire then
		SeatSlotTab.PostFire(vehicle,seat,ply,ct,SeatTab,WeaponTab,SeatID,SeatSlotTab,SlotID)
	end
end

gred.TankShootMG = function(vehicle,seat,ply,ct,SeatTab,WeaponTab,SeatID,SeatSlotTab,SlotID)
	if WeaponTab.Sequential then
		-- netStart("gred_net_simfphys_shoot_"..(SlotID and "primary" or "secondary").."_machinegun_sequential")
			-- netWriteEntity(seat)
			-- netWriteUInt(SeatSlotTab.CurrentMuzzle,5)
		-- netBroadcast()
		
		local att = GetAttachment(vehicle,SeatSlotTab.Muzzles[SeatSlotTab.CurrentMuzzle])
		gred.CreateBullet(ply,att.Pos,att.Ang + gred.TankGetRandomSpreadAngle(SeatID,vehicle,WeaponTab,SeatSlotTab.CurrentMuzzle),WeaponTab.Caliber,vehicle.FILTER,nil,nil,SeatSlotTab.UpdateTracers[SeatSlotTab.CurrentMuzzle](),nil,nil,true)
		
		if not vehicle.gred_sv_simfphys_infinite_mg_ammo then
			SeatSlotTab.Ammo = SeatSlotTab.Ammo - 1
		end
		
		if WeaponTab.OnShoot then
			WeaponTab.OnShoot(vehicle,seat,ply,ct,SeatTab,WeaponTab,SeatID,SeatSlotTab,SlotID,SeatSlotTab.CurrentMuzzle)
		end
		
		if SeatSlotTab.Ammo < 1 then
			if WeaponTab.Sounds.Reload then
				seat:EmitSound(WeaponTab.Sounds.Reload[random(#WeaponTab.Sounds.Reload)])
			end
			
			SeatSlotTab.IsReloading = true
			
			timer.Simple(WeaponTab.ReloadTime,function()
				if !IsValid(vehicle) then return end
				if !IsValid(seat) then return end
				
				SeatSlotTab.IsReloading = false
				SeatSlotTab.Ammo = WeaponTab.Ammo
				SetNWInt(seat,SlotID and SlotID.."CurAmmo" or "SecondaryAmmo",SeatSlotTab.Ammo)
			end)
		end
		
		SeatSlotTab.CurrentMuzzle = #WeaponTab.Muzzles < SeatSlotTab.CurrentMuzzle and SeatSlotTab.CurrentMuzzle + 1 or 1
	else
		-- netStart("gred_net_simfphys_shoot_"..(SlotID and "primary" or "secondary").."_machinegun")
			-- netWriteEntity(seat)
		-- netBroadcast()
		
		local att
		local v
		for k = 1,#WeaponTab.Muzzles do
			v = WeaponTab.Muzzles[k]
			
			if v then
				att = GetAttachment(vehicle,SeatSlotTab.Muzzles[k])
				gred.CreateBullet(ply,att.Pos,att.Ang + gred.TankGetRandomSpreadAngle(SeatID,vehicle,WeaponTab,k),WeaponTab.Caliber,vehicle.FILTER,nil,nil,SeatSlotTab.UpdateTracers[k](),nil,nil,true)
				
				if not vehicle.gred_sv_simfphys_infinite_mg_ammo then
					SeatSlotTab.Ammo = SeatSlotTab.Ammo - 1
				end
				
				if WeaponTab.OnShoot then
					WeaponTab.OnShoot(vehicle,seat,ply,ct,SeatTab,WeaponTab,SeatID,SeatSlotTab,SlotID,k)
				end
				
				if SeatSlotTab.Ammo < 1 then
					if WeaponTab.Sounds.Reload then 
						seat:EmitSound(WeaponTab.Sounds.Reload[random(#WeaponTab.Sounds.Reload)])
					end
					
					SeatSlotTab.IsReloading = true
					
					timer.Simple(WeaponTab.ReloadTime,function()
						if !IsValid(vehicle) then return end
						if !IsValid(seat) then return end
						
						SeatSlotTab.IsReloading = false
						SeatSlotTab.Ammo = WeaponTab.Ammo
						SetNWInt(seat,SlotID and SlotID.."CurAmmo" or "SecondaryAmmo",SeatSlotTab.Ammo)
					end)
					
					break
				end
			end
		end
	end
	
	SetNWInt(seat,SlotID and SlotID.."CurAmmo" or "SecondaryAmmo",SeatSlotTab.Ammo)
	
	SeatSlotTab.NextShot = ct + SeatSlotTab.FireRate
end

gred.TankShootRocketLauncher = function(vehicle,seat,ply,ct,SeatTab,WeaponTab,SeatID,SeatSlotTab,SlotID)
	if WeaponTab.Sequential then
		SeatSlotTab.CurrentMuzzle = (SlotID and seat.Primary[SlotID] or seat.Secondary).CurrentMuzzle and (SlotID and seat.Primary[SlotID] or seat.Secondary).CurrentMuzzle or 1
		SeatSlotTab.CurrentMuzzle = SeatSlotTab.CurrentMuzzle > #WeaponTab.Muzzles and 1 or SeatSlotTab.CurrentMuzzle
		
		netStart("gred_net_simfphys_shoot_"..(SlotID and "primary" or "secondary").."_machinegun_sequential")
			netWriteEntity(seat)
			netWriteUInt(SeatSlotTab.CurrentMuzzle,5)
		netBroadcast()
		
		local att = GetAttachment(vehicle,SeatSlotTab.Muzzles[SeatSlotTab.CurrentMuzzle])
		local ent = ents.Create(WeaponTab.Rocket)
		ent:SetPos(att.Pos)
		ent:SetAngles(att.Ang + Angle(math.random(-WeaponTab.Spread,WeaponTab.Spread),math.random(-WeaponTab.Spread,WeaponTab.Spread)))
		ent.Owner = ply
		ent:Spawn()
		ent:Activate()
		ent.StartSound = WeaponTab.SilenceRocket and "" or ent.StartSound
		ent:Launch()
		
		local phys = ent:GetPhysicsObject()
		
		if IsValid(phys) then
			phys:AddVelocity(vehicle:GetVelocity() + ent:GetForward() * ent.EnginePower * 0.1)
		end
		
		for k,v in pairs(vehicle.FILTER) do
			constraint.NoCollide(ent,v,0,0)
		end
		
		SeatSlotTab.CurrentMuzzle = SeatSlotTab.CurrentMuzzle + 1
		
		SeatSlotTab.Ammo = SeatSlotTab.Ammo - 1
		
		if WeaponTab.OnShoot then
			WeaponTab.OnShoot(vehicle,seat,ply,ct,SeatTab,WeaponTab,SeatID,SeatSlotTab,SlotID,SeatSlotTab.CurrentMuzzle,att,ent)
		end
		
		if SeatSlotTab.Ammo < 1 then
			if WeaponTab.Sounds.Reload then
				seat:EmitSound(WeaponTab.Sounds.Reload[random(#WeaponTab.Sounds.Reload)])
			end
			
			SeatSlotTab.IsReloading = true
			
			timer.Simple(SeatSlotTab.ReloadTime,function()
				if !IsValid(vehicle) then return end
				if !IsValid(seat) then return end
				
				SeatSlotTab.IsReloading = false
				SeatSlotTab.Ammo = WeaponTab.Ammo
				SetNWInt(seat,SlotID and SlotID.."CurAmmo" or "SecondaryAmmo",SeatSlotTab.Ammo)
				
				if WeaponTab.OnReload then
					WeaponTab.OnReload(vehicle,seat,ply,ct,SeatTab,WeaponTab,SeatID,SeatSlotTab,SlotID)
				end
			end)
		end
	else
		netStart("gred_net_simfphys_shoot_"..(SlotID and "primary" or "secondary").."_machinegun")
			netWriteEntity(seat)
		netBroadcast()
		
		local phys
		local att
		local ent
		local v
		for k = 1,#WeaponTab.Muzzles do
			v = WeaponTab.Muzzles[k]
			if v then
				att = GetAttachment(vehicle,SeatSlotTab.Muzzles[k])
				ent = ents.Create(WeaponTab.Rocket)
				ent:SetPos(att.Pos)
				ent:SetAngles(att.Ang + Angle(0,math.random(-WeaponTab.Spread,WeaponTab.Spread)))
				ent:Spawn()
				ent:Activate()
				ent.Owner = ply
				ent.StartSound = WeaponTab.SilenceRocket and "" or ent.StartSound
				ent:Launch()
				
				phys = ent:GetPhysicsObject()
				
				if IsValid(phys) then
					phys:AddVelocity(vehicle:GetVelocity() + ent:GetForward() * ent.EnginePower * 0.1)
				end
				
				for k,v in pairs(vehicle.FILTER) do
					constraint.NoCollide(ent,v,0,0)
				end
				
				SeatSlotTab.Ammo = SeatSlotTab.Ammo - 1
				
				if WeaponTab.OnShoot then
					WeaponTab.OnShoot(vehicle,seat,ply,ct,SeatTab,WeaponTab,SeatID,SeatSlotTab,SlotID,k,att,ent)
				end
				
				if SeatSlotTab.Ammo < 1 then
					if WeaponTab.Sounds.Reload then 
						seat:EmitSound(WeaponTab.Sounds.Reload[random(#WeaponTab.Sounds.Reload)])
					end
					
					SeatSlotTab.IsReloading = true
					
					timer.Simple(SeatSlotTab.ReloadTime,function()
						if !IsValid(vehicle) then return end
						if !IsValid(seat) then return end
						
						SeatSlotTab.IsReloading = false
						SeatSlotTab.Ammo = WeaponTab.Ammo
						SetNWInt(seat,SlotID and SlotID.."CurAmmo" or "SecondaryAmmo",SeatSlotTab.Ammo)
						
						if WeaponTab.OnReload then
							WeaponTab.OnReload(vehicle,seat,ply,ct,SeatTab,WeaponTab,SeatID,SeatSlotTab,SlotID)
						end
					end)
					
					break
				end
			end
		end
	end
	
	SetNWInt(seat,SlotID and SlotID.."CurAmmo" or "SecondaryAmmo",SeatSlotTab.Ammo)
	
	SeatSlotTab.NextShot = ct + SeatSlotTab.FireRate
end

gred.TankShootFlamethrower = function(vehicle,seat,ply,ct,SeatTab,WeaponTab,SeatID,SeatSlotTab,SlotID)
	local v
	if not ((SlotID and seat.PrimaryAttacking) or (!SlotID and seat.SecondaryAttacking)) then
		seat:EmitSound("gredwitch/flamethrower/flamethrower_start.wav")
		seat.FlameThrowerSound:Play()
		if !SeatSlotTab.ShouldNotFlamesBounce then 
			for k = 1,#SeatSlotTab.FireParticles do
				v = SeatSlotTab.FireParticles[k]
				if v then
					v:Fire("Start")
				end
			end
		end
		seat.DIST = 0
	end
	local v
	for k = 1,#WeaponTab.Muzzles do
		v = WeaponTab.Muzzles[k]
		if v then
			local att = GetAttachment(vehicle,SeatSlotTab.Muzzles[k])
			
			local dist = WeaponTab.FlameRange*seat.DIST
			seat.DIST = Clamp(seat.DIST+WeaponTab.FlameRate,0,1)
			local sqrdist = dist*dist
			local dmg = DamageInfo()
			
			tr_flame_tab.start = att.Pos
			tr_flame_tab.endpos = att.Pos + Forward(att.Ang)*dist
			tr_flame_tab.mins = SeatSlotTab.RayMins
			tr_flame_tab.maxs = SeatSlotTab.RayMaxs
			tr_flame_tab.filter = vehicle.FILTER
			tr_flame_tab.collisiongroup = COLLISION_GROUP_DEBRIS
			tr_flame_tab.mask = MASK_SOLID_BRUSHONLY
			local tr = TraceHull(tr_flame_tab)
			SetAttacker(dmg,ply)
			SetInflictor(dmg,vehicle)
			SetDamageType(dmg,8)
			
			SeatSlotTab:ThrowFlames(tr.StartPos,tr.HitPos,SeatSlotTab.FireBallMins,SeatSlotTab.FireBallMaxs,25,dmg,10,att.Pos,sqrdist,tr,att.Ang)
			
			if !SeatSlotTab.ShouldNotFlamesBounce then
				dist = Round(tr.StartPos:DistToSqr(tr.HitPos) - sqrdist)
				
				if dist >= 0 then return end
				dist = sqrt(abs(dist))
				
				local HITANG = tr.HitNormal:Angle()
				Normalize(HITANG)
				
				local DIR = Angle(att.Ang.p,att.Ang.y,att.Ang.r)
				DIR:Sub(HITANG)
				Normalize(DIR)
				DIR.y = (DIR.y > 0) and HITANG.y + 90 or HITANG.y - 90
				DIR.p = HITANG.p != 0 and -HITANG.p + 90 or DIR.p
				DIR.y = ((HITANG.p != 0 and HITANG.y == 0) or HITANG.y == 90) and att.Ang.y or DIR.y
				Normalize(DIR)
				
				tr_flame_tab.start = tr.HitPos
				tr_flame_tab.endpos = tr.HitPos + (Forward(DIR))*dist*Clamp((1-abs((att.Ang.y-DIR.y)/90)),0,0.35)*(1-abs(DIR.p/90))
				tr_flame_tab.mins = SeatSlotTab.RayMins
				tr_flame_tab.maxs = SeatSlotTab.RayMaxs
				tr_flame_tab.filter = vehicle.FILTER
				tr_flame_tab.collisiongroup = COLLISION_GROUP_DEBRIS
				tr_flame_tab.mask = MASK_SOLID_BRUSHONLY
				tr = TraceHull(tr_flame_tab)
				
				SeatSlotTab:ThrowFlames(tr.StartPos,tr.HitPos,SeatSlotTab.FireBallMins,SeatSlotTab.FireBallMaxs,20,dmg,7,att.Pos,sqrdist,true)
			end
		end
	end
end



gred.TankStopCannon = function(vehicle,seat,ply,ct,SeatTab,WeaponTab,SeatID,SeatSlotTab,SlotID)
	
end

gred.TankStopMG = function(vehicle,seat,ply,ct,SeatTab,WeaponTab,SeatID,SeatSlotTab,SlotID)
	-- if ((SlotID and seat.PrimaryAttacking) or (!SlotID and seat.SecondaryAttacking)) and (WeaponTab.Sounds.Loop or WeaponTab.Sounds.LoopInside or WeaponTab.Sounds.Stop or WeaponTab.Sounds.StopInside) then
		-- netStart("gred_net_simfphys_stop_"..(SlotID and "primary" or "secondary").."_machinegun")
			-- netWriteEntity(seat)
		-- netBroadcast()
	-- end
end

gred.TankStopFlamethrower = function(vehicle,seat,ply,ct,SeatTab,WeaponTab,SeatID,SeatSlotTab,SlotID)
	if !SeatSlotTab.ShouldNotFlamesBounce then 
		local v
		for k = 1,#SeatSlotTab.FireParticles do
			v = SeatSlotTab.FireParticles[k]
			if v then
				v:Fire("Stop")
			end
		end
	end
	seat.FlameThrowerSound:Stop()
	seat:EmitSound("gredwitch/flamethrower/flamethrower_end.wav")
end



gred.TankCanDeploySmoke = function(vehicle,seat,ply,ct,SeatTab,HatchID)
	return (SeatTab.RequiresHatch and SeatTab.RequiresHatch[HatchID] or (!SeatTab.RequiresHatch and HatchID == 0)) and GetNWInt(seat,"SmokeGrenades",0) > 0
end

gred.TankDeploySmoke = function(vehicle,seat,SmokeLaunchersTab,SeatTab)
	local SmokeCount = GetNWInt(seat,"SmokeGrenades",0)
	local SmokesLeft = SmokeCount - 1
	SetNWInt(seat,"SmokeGrenades",SmokesLeft)
	
	local att = GetAttachment(vehicle,vehicle.Attachments[SmokeLaunchersTab[SmokeCount]])
	local ent = ents.Create("prop_physics")
	ent:SetModel("models/props_junk/PopCan01a.mdl")
	ent:SetPos(att.Pos)
	ent:SetAngles(att.Ang)
	ent:Spawn()
	ent:Activate()
	
	ent:AddCallback("PhysicsCollide",function(ent,data)
		if ent.Hit then return end
		
		ent.Hit = true
		
		timer.Simple(0,function()
			if IsValid(ent) then
				ent:Remove()
			end
		end)
		
		local effectdata = EffectData()
		effectdata:SetFlags(table.KeyFromValue(gred.Particles,"m203_smokegrenade"))
		effectdata:SetOrigin(data.HitPos)
		effectdata:SetAngles(angle_zero)
		effectdata:SetSurfaceProp(0)
		util.Effect("gred_particle_simple",effectdata)
		
		ent:EmitSound(SmokeSnds[random(#SmokeSnds)],100)
	end)
	
	local phys = GetPhysicsObject(ent)
	
	if IsValid(phys) then
		ApplyForceCenter(phys,ent:GetForward()*1000 + vehicle:GetVelocity())
	end
	
	constraint.NoCollide(ent,vehicle,0,0)
	
	
	if SmokesLeft < 1 then
		timer.Create("gred_simfphys_tank_reload_smokes_"..vehicle.CachedSpawnList.."_"..vehicle.EntityIndex,vehicle.gred_sv_simfphys_smokereloadtime,1,function()
			if !IsValid(seat) then return end
			
			SetNWInt(seat,"SmokeGrenades",#SmokeLaunchersTab)
		end)
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
	ent.DestructionType = random(0,6)
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
				timer.Simple(Rand(2,3),function()
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
				timer.Simple(Rand(2,3),function()
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
				timer.Simple(Rand(0.5,1.3),function()
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

gred.TankTurn = function(vehicle,MaxTurn,TorqueCenter,TorqueCenterRate,ForceMul,WheelsLocked)
	if !WheelsLocked and vehicle.susOnGround then
		local phys = GetPhysicsObject(vehicle)
		if !IsValid(phys) then return end
		
		local LeftTrackDead = GetNWInt(vehicle,"ModuleHealth_LeftTrack_0",100) <= 0
		local RightTrackDead = GetNWInt(vehicle,"ModuleHealth_RightTrack_0",100) <= 0
		
		if LeftTrackDead and RightTrackDead then vehicle.PressedKeys.Space = true return end
		if (!vehicle:EngineActive() and LengthSqr(PhysGetVelocity(phys)) < 2000) and !LeftTrackDead and !RightTrackDead then return end
		
		local angvel = GetAngleVelocity(phys)
		local gear = vehicle:GetGear()
		
		if gear == 2 then
			if vehicle.NoIdleTurning then 
				return 
			end
			vehicle.PressedKeys.TestA = vehicle.PressedKeys.A
			vehicle.PressedKeys.TestD = vehicle.PressedKeys.D
		else
			if LeftTrackDead then
				vehicle.PressedKeys.TestA = true
				vehicle.PressedKeys.TestD = false
				TorqueCenterRate = abs(vehicle.ForwardSpeed*0.5)
				TorqueCenter = TorqueCenterRate
				MaxTurn = TorqueCenterRate
			else
				vehicle.PressedKeys.TestA = vehicle.PressedKeys.A
			end
			if RightTrackDead then
				vehicle.PressedKeys.TestD = true
				vehicle.PressedKeys.TestA = false
				TorqueCenterRate = abs(vehicle.ForwardSpeed*0.5)
				TorqueCenter = TorqueCenterRate
				MaxTurn = TorqueCenterRate
			else
				vehicle.PressedKeys.TestD = vehicle.PressedKeys.D
			end
		end
		
		ApplyForceOffset(phys,GetRight(vehicle)*-(vehicle.TOQUECENTER_D > vehicle.TOQUECENTER_A and vehicle.TOQUECENTER_D or -vehicle.TOQUECENTER_A)*ForceMul,vehicle.ForceOffsetVec)
		
		if abs(angvel.z) <= MaxTurn then
			local var = vehicle.gred_sv_simfphys_turnrate_multplier
			TorqueCenter = TorqueCenter * var
			TorqueCenterRate = TorqueCenterRate * var
			
			if (vehicle.PressedKeys.TestD and gear != 1) or (vehicle.PressedKeys.TestA and gear == 1) then
				local torque = vehicle.TOQUECENTER_D*0.05
				
				vehicle.TOQUECENTER_D = Clamp(vehicle.TOQUECENTER_D+TorqueCenterRate,0,TorqueCenter)
				
				vehicle.VehicleData["spin_3"] = vehicle.VehicleData[ "spin_3" ] + torque
				vehicle.VehicleData["spin_5"] = vehicle.VehicleData[ "spin_5" ] + torque
				
				ApplyTorqueCenter(phys,vehicle.MassVec *-vehicle.TOQUECENTER_D)
			else
				vehicle.TOQUECENTER_D = 0
			end
			
			if (vehicle.PressedKeys.TestA and gear != 1) or (vehicle.PressedKeys.TestD and gear == 1) then
				local torque = vehicle.TOQUECENTER_A*0.05
				
				vehicle.TOQUECENTER_A = Clamp(vehicle.TOQUECENTER_A+TorqueCenterRate,0,TorqueCenter)
				
				vehicle.VehicleData["spin_4"] = vehicle.VehicleData[ "spin_4" ] + torque
				vehicle.VehicleData["spin_6"] = vehicle.VehicleData[ "spin_6" ] + torque
				
				ApplyTorqueCenter(phys,vehicle.MassVec * vehicle.TOQUECENTER_A)
			else
				vehicle.TOQUECENTER_A = 0
			end
		end
		
		if !vehicle.PressedKeys.TestA and !vehicle.PressedKeys.TestD then
			ApplyTorqueCenter(phys,vehicle.MassVec * -angvel.z)
		end
	end
end

gred.TankToggleHatch = function(seat,SeatID,vehicle,ply,HatchID,OldHatch,SeatTab)
	if HatchID == 0 then
		seat:ResetHatch(SeatID,vehicle)
	else
		-- ply.TankManipulatedBones = true
		
		local HatchTab = SeatTab.Hatches[HatchID]
		
		if HatchTab.PoseParameters then
			local v
			
			for k = 1,#HatchTab.PoseParameters do
				v = HatchTab.PoseParameters[k]
				
				if v then
					SetPoseParameter(vehicle,v,1)
				end
			end
		end
		
		if HatchTab.SeatAttachment then
			SetNWBool(seat,"SpecialCam_LocalAngles",true)
			SetParent(seat,vehicle,vehicle.Attachments[HatchTab.SeatAttachment])
		else
			SetParent(seat,vehicle,SeatTab.Attachment and vehicle.Attachments[SeatTab.Attachment] or nil)
			SetNWBool(seat,"SpecialCam_LocalAngles",seat.LocalView)
		end
		
		SetCollisionGroup(ply,HatchTab.Inside and 10 or 5)
		
		if SeatID == 0 then
			local View = vehicle:SetupView()
			SetAngles(seat,View.ViewAng + HatchTab.AngOffset)
			SetPos(seat,EnityWorldToLocal(vehicle,GetPos(vehicle) + GetUp(seat) * (-34 + vehicle.SeatOffset.z) + GetRight(seat) * (vehicle.SeatOffset.y) + GetForward(seat) * (-6 + vehicle.SeatOffset.x)) + SeatTab.Hatches[1].PosOffset)
		else
			if SeatTab.Attachment then
				local att = GetAttachment(vehicle,vehicle.Attachments[SeatTab.Attachment])
				att.LPos,att.LAng = EnityWorldToLocal(vehicle,att.Pos),WorldToLocalAngles(vehicle,att.Ang)
				local Pos,Ang = LocalToWorld(vehicle.PassengerSeats[SeatID].pos - att.LPos,vehicle.PassengerSeats[SeatID].ang - att.LAng,att.LPos,att.LAng)
				SetPos(seat,vehicle.PassengerSeats[SeatID].pos - att.LPos + HatchTab.PosOffset)
				SetAngles(seat,LocalToWorldAngles(vehicle,Ang + HatchTab.AngOffset))
			else
				SetPos(seat,vehicle.PassengerSeats[SeatID].pos + HatchTab.PosOffset)
				SetAngles(seat,LocalToWorldAngles(vehicle,vehicle.PassengerSeats[SeatID].ang + HatchTab.AngOffset))
			end
		end
		
		if HatchTab.PlayerBoneManipulation then
			gred.ClearBoneManipulations(ply)
			gred.DoBoneManipulation(vehicle,seat,SeatID,ply,HatchTab.PlayerBoneManipulation,SeatTab)
		end
		
		if HatchTab.ViewPosOffset then
			SetNWVector(seat,"SpecialCam_Firstperson",HatchTab.ViewPosOffset)
		end
		
		if HatchTab.ViewAttachment then
			SetNWString(seat,"SpecialCam_Attachment",HatchTab.ViewAttachment)
		end
		
		SetNWBool(seat,"HatchID",HatchID)
	end
end

gred.TankGetDriverLocalAngles = function(vehicle,seat,SeatTab,ply,HatchID,PoseParamTab)
	if SeatTab.RequiresHatch and SeatTab.RequiresHatch[HatchID] or (!SeatTab.RequiresHatch and HatchID == 0) then
		
		local Angles
		
		-- if !seat.NoMouseAim then
			-- seat.GredSimfphysDesiredAngles = nil
			-- seat.GredSimfphysAimAngles = nil
			-- seat.GredSimfphysDesiredAngles = seat.GredSimfphysDesiredAngles or Angle()
			-- seat.GredSimfphysAimAngles = seat.GredSimfphysAimAngles or Angle()
			-- seat.GredSimfphysDesiredAngles.p = seat.GredSimfphysDesiredAngles.p + ply.GredSimfphysDesiredY * 0.05
			-- seat.GredSimfphysDesiredAngles.y = seat.GredSimfphysDesiredAngles.y + ply.GredSimfphysDesiredX * 0.25
			
			-- seat.GredSimfphysAimAngles.y = -seat.GredSimfphysDesiredAngles.y * 0.01
			-- seat.GredSimfphysAimAngles.p = seat.GredSimfphysDesiredAngles.p * 0.01
			-- seat.GredSimfphysAimAngles:Normalize()
			
			-- Angles = seat.GredSimfphysAimAngles
		-- else
			if SeatTab.CustomEyeAngles then
				Angles = SeatTab.CustomEyeAngles(vehicle,seat,SeatTab,ply,HatchID,PoseParamTab,Angles)
			else
				if SeatTab.UseRawAngles then
					if seat.LocalView then
						if SeatTab.UseSeatAngles then
							Angles = WorldToLocalAngles(seat,GetEyeAngles(ply)) - WorldToLocalAngles(vehicle,GetAngles(seat))
						else
							Angles = WorldToLocalAngles(seat,GetEyeAngles(ply))
						end
					else
						Angles = GetEyeAngles(ply)
					end
				else
					if seat.LocalView then
						if SeatTab.UseSeatAngles then
							Angles = WorldToLocalAngles(vehicle,WorldToLocalAngles(seat,GetEyeAngles(ply))) - WorldToLocalAngles(vehicle,GetAngles(seat))
						else
							Angles = WorldToLocalAngles(vehicle,WorldToLocalAngles(seat,GetEyeAngles(ply)))
						end
					else
						Angles = WorldToLocalAngles(vehicle,GetEyeAngles(ply))
					end
				end
			end
		-- end
		
		if SeatTab.TurretTraverseSpeed and SeatTab.TurretTraverseSpeed != 0 then
			local ShouldPlayRotationSound
			local Mul = 1
			
			if PoseParamTab.YawModuleName and PoseParamTab.YawModuleID then
				Mul = Clamp(GetNWInt(vehicle,"ModuleHealth_"..PoseParamTab.YawModuleName.."_"..PoseParamTab.YawModuleID,100) * 0.01,0,1)
			end
			
			if SeatTab.TraverseOffset then
				Angles.y = Angles.y + SeatTab.TraverseOffset
				Angles:Normalize()
			end
			
			Angles.y = Clamp(Angles.y,SeatTab.MinTraverse,SeatTab.MaxTraverse)
			
			ShouldPlayRotationSound = Mul > 0 and abs((Round(Angles.y,1) - (seat.sm_pp_yaw and Round(seat.sm_pp_yaw,1) or 0))) or 0
			seat.VAL_TurretHorizontal = (ShouldPlayRotationSound <= 0.3 or (ShouldPlayRotationSound >= 359.7 and ShouldPlayRotationSound <= 360)) and 0 or 1

			
			seat.sm_pp_yaw = seat.sm_pp_yaw and ApproachAngle(seat.sm_pp_yaw,Angles.y,seat.TurretTraverseSpeed*Mul) or 0
			seat.sm_pp_yaw = seat.sm_pp_yaw > 360 and 0 or seat.sm_pp_yaw < -360 and 0 or seat.sm_pp_yaw
			seat.sm_pp_pitch = seat.sm_pp_pitch or 0
			
			if seat.SynchronousElevation or (ShouldPlayRotationSound == 0 or ShouldPlayRotationSound == 360) then
				Angles.p = -Clamp(-Angles.p,SeatTab.MinElevation,SeatTab.MaxElevation)
				local val = ApproachAngle(seat.sm_pp_pitch,Angles.p,seat.TurretElevationSpeed)
				ShouldPlayRotationSound = Round(val - seat.sm_pp_pitch,1)
				
				seat.VAL_TurretVertical = (ShouldPlayRotationSound == 0) and 0 or 1
				seat.sm_pp_pitch = val
			else
				seat.VAL_TurretVertical = 0
			end
			Angles.p = seat.sm_pp_pitch
			Angles.y = seat.sm_pp_yaw
			Angles.r = 0
			Normalize(Angles)
		end
		
		return Angles
	else
		return nil
	end
end

gred.TankModPhysics = function(vehicle,WheelsLocked,vel)
	if WheelsLocked and vehicle.susOnGround then
		local phys = GetPhysicsObject(Vehicle)
		ApplyForceCenter(phys,-vel * GetMass(phys) * 0.1)
	end
end

gred.TankResetHatch = function(vehicle,seat,SeatID,vehicle,SeatTab)
	if !SeatTab then return end
	
	local ply = seat:GetDriver()
	
	if IsValid(ply) then
		SetCollisionGroup(ply,SeatTab.Outside and 5 or 10)
		gred.ClearBoneManipulations(ply)
		gred.DoBoneManipulation(vehicle,seat,SeatID,ply,nil,SeatTab)
	end
	
	SetParent(seat,vehicle,SeatTab.Attachment and vehicle.Attachments[SeatTab.Attachment] or nil)
	
	local HatchTab = SeatTab.Hatches and SeatTab.Hatches[GetNWInt(seat,"HatchID",0)]
	
	if SeatID == 0 then
		local View = vehicle:SetupView()
		SetAngles(seat,View.ViewAng)
		SetPos(seat,EnityWorldToLocal(vehicle,GetPos(vehicle) + GetUp(seat) * (-34 + vehicle.SeatOffset.z) + GetRight(seat) * (vehicle.SeatOffset.y) + GetForward(seat) * (-6 + vehicle.SeatOffset.x)))
	else
		if SeatTab.Attachment then
			local att = GetAttachment(vehicle,vehicle.Attachments[SeatTab.Attachment])
			
			if att then
				att.LPos,att.LAng = EnityWorldToLocal(vehicle,att.Pos),WorldToLocalAngles(vehicle,att.Ang)
				local Pos,Ang = LocalToWorld(vehicle.PassengerSeats[SeatID].pos - att.LPos,vehicle.PassengerSeats[SeatID].ang - att.LAng,att.LPos,att.LAng)
				SetPos(seat,PosH and vehicle.PassengerSeats[SeatID].pos - PosH - att.LPos or vehicle.PassengerSeats[SeatID].pos - att.LPos)
				SetAngles(seat,LocalToWorldAngles(vehicle,AngH and Ang - AngH or Ang))
			end
		else
			local PosH,AngH
			
			if HatchTab and HatchTab.SeatAttachment then
				local att = GetAttachment(vehicle,vehicle.Attachments[HatchTab.SeatAttachment])
				
				if att then
					att.LPos,att.LAng = EnityWorldToLocal(vehicle,att.Pos),WorldToLocalAngles(vehicle,att.Ang)
					PosH,AngH = WorldToLocal(vector_zero,angle_zero,att.LPos + HatchTab.PosOffset,att.LAng)
					AngH = LocalToWorldAngles(vehicle,vehicle.PassengerSeats[SeatID].ang - att.LAng)
				end
			end
			
			SetPos(seat,PosH or vehicle.PassengerSeats[SeatID].pos)
			SetAngles(seat,AngH or LocalToWorldAngles(vehicle,vehicle.PassengerSeats[SeatID].ang))
		end
	end
	
	
	if HatchTab then
		if HatchTab.PoseParameters then
			local v
			
			for k = 1,#HatchTab.PoseParameters do
				v = HatchTab.PoseParameters[k]
				
				if v then
					SetPoseParameter(vehicle,v,0)
				end
			end
		end
		
		if HatchTab.ViewPosOffset then
			SetNWVector(seat,"SpecialCam_Firstperson",SeatTab.FirstPersonViewPos or vector_zero)
		end
		
		if HatchTab.ViewAttachment then
			SetNWString(seat,"SpecialCam_Attachment",SeatTab.ViewAttachment or "")
		end
	end
	
	SetNWInt(seat,"HatchID",0)
end

gred.TankWheelOnGroundOverride = function(ent)
	local PowerDistribution = ent:GetPowerDistribution()
	local Wheel
	
	ent.FrontWheelPowered = PowerDistribution ~= 1
	ent.RearWheelPowered = PowerDistribution ~= -1
	
	for i = 1,#ent.Wheels do
		Wheel = ent.Wheels[i]		
		if IsValid(Wheel) then
			local surfacemul = simfphys.TractionData[lower(GetSurfaceMaterial(Wheel))]
			
			ent.VehicleData["SurfaceMul_" .. i ] = (surfacemul and max(surfacemul,0.001) or 1) * (Wheel:GetDamaged() and 0.5 or 1)
			
			-- local WheelPos = ent:LogicWheelPos(i)
			
			-- local WheelRadius = WheelPos.IsFrontWheel and ent.FrontWheelRadius or ent.RearWheelRadius
			-- local startpos = Wheel:GetPos()
			-- local dir = -ent.Up
			-- local len = WheelRadius + math.Clamp(-ent.Vel.z / 50,2.5,6)
			-- local HullSize = Vector(WheelRadius,WheelRadius,0)
			-- tr_wheel_tab.start = startpos
			-- tr_wheel_tab.endpos = startpos + dir * len
			-- tr_wheel_tab.maxs = HullSize
			-- tr_wheel_tab.mins = -HullSize
			-- tr_wheel_tab.filter = ent.filterEntities
			-- local tr = TraceHull(tr_wheel_tab)
			
			local onground = ent.susOnGround and 1 or 0
			Wheel:SetOnGround( onground )
			ent.VehicleData[ "onGround_" .. i ] = onground
			
			if ent.susOnGround then
				Wheel:SetSpeed( Wheel.FX )
				Wheel:SetSkidSound( Wheel.skid )
				if vehicle.LastSuspensionTrace and vehicle.LastSuspensionTrace.SurfacePropsName then Wheel:SetSurfaceMaterial(vehicle.LastSuspensionTrace.SurfacePropsName) end
			end
		end
	end
	
	local FrontOnGround = max(ent.VehicleData[ "onGround_1" ],ent.VehicleData[ "onGround_2" ])
	local RearOnGround = max(ent.VehicleData[ "onGround_3" ],ent.VehicleData[ "onGround_4" ])
	
	ent.DriveWheelsOnGround = max(ent.FrontWheelPowered and FrontOnGround or 0,ent.RearWheelPowered and RearOnGround or 0)
end

gred.TankUpdateSuspension = function(vehicle,ct,SusDataTab)
	ct = ct or CurTime()
	if vehicle.NextSuspension > ct then return end
	vehicle.NextSuspension = ct + vehicle.gred_sv_simfphys_suspension_rate
	-- if vehicle.gred_sv_simfphys_testsuspensions then
		
		-- local ang = vehicle:GetAngles()
		-- for i = 1,2 do
			-- vehicle.tr_table.maxs = vehicle.SuspensionTables[i].SuspensionMaxs * 1
			-- vehicle.tr_table.maxs:Rotate(ang)
			-- vehicle.tr_table.mins = vehicle.SuspensionTables[i].SuspensionMins * 1
			-- vehicle.tr_table.mins:Rotate(ang)
			-- vehicle.tr_table.filter = vehicle.filterEntities
			-- vehicle.tr_table.start = EntityLocalToWorld(vehicle,vehicle.SuspensionTables[i].SuspensionStart)
			-- vehicle.tr_table.endpos = EntityLocalToWorld(vehicle,vehicle.SuspensionTables[i].SuspensionEnd)
			
			-- debugoverlay.SweptBox(vehicle.tr_table.start,vehicle.tr_table.endpos,vehicle.tr_table.mins,vehicle.tr_table.maxs,Angle(),0.1,color_white)
			-- vehicle.susOnGround = TraceHull(vehicle.tr_table).Hit
			-- if vehicle.susOnGround then break end
		-- end
		
		-- local tr = TraceHull(vehicle.tr_table)
		-- local str = ""
		-- for k,v in pairs(tr) do
			-- if isbool(v) then
				-- str = str.." "..k.." "..tostring(v)
			-- end
		-- end
		-- print(str)
	-- else
		vehicle.tr_table.up = GetUp(vehicle) * SusDataTab[1].GroundHeight*0.8
		vehicle.tr_table.mins = SusDataTab[1].Mins
		vehicle.tr_table.maxs = SusDataTab[1].Maxs
		vehicle.tr_table.filter = vehicle.filterEntities
		-- PrintTable(vehicle.filterEntities)
		local v
		vehicle.susOnGround = false
		for k = 1,#vehicle.SuspensionTable do
			v = vehicle.SuspensionTable[k]
			if v then
				vehicle.tr_table.start = EntityLocalToWorld(vehicle,v)
				-- vehicle.tr_table.endpos = vehicle.tr_table.start + vehicle.tr_table.up
				-- vehicle.susOnGround = TraceHull(vehicle.tr_table).Hit
				-- debugoverlay.Line(vehicle.tr_table.start,vehicle.tr_table.endpos,0.2,color_white)
				
				vehicle.LastSuspensionTrace = QuickTrace(vehicle.tr_table.start,vehicle.tr_table.up,vehicle.tr_table.filter)
				vehicle.susOnGround = vehicle.LastSuspensionTrace.Hit
				
				if vehicle.susOnGround then break end
			end
		end
		if vehicle.LastSuspensionTrace then
			vehicle.LastSuspensionTrace.SurfacePropsName = GetSurfacePropName(vehicle.LastSuspensionTrace.SurfaceProps)
		end
	-- end
end



gred.TankRemovePlayerHooks = function(vehicle,seat,SeatID,ply,Mode,SteamID,SeatTab)
	SteamID = SteamID or GetSteamID(ply)
	
	RemoveCallOnRemove(vehicle,"RemoveHooks"..SteamID)
	
	hook.Remove("PlayerEnteredVehicle","gred_simfphys_PlayerEnteredVehicle_"..SteamID)
	hook.Remove("PlayerLeaveVehicle","gred_simfphys_PlayerLeaveVehicle_"..SteamID)
	hook.Remove("PlayerButtonDown","gred_simfphys_PlayerButtonDown_"..SteamID)
	hook.Remove("PlayerButtonUp","gred_simfphys_PlayerButtonUp_"..SteamID)
	
	seat.Driver = nil
	
	if IsValid(vehicle) then
		gred.TankResetHatch(vehicle,seat,SeatID,vehicle,SeatTab)
		
		table.remove(vehicle.FILTER,seat.LastPlayerFilterID)
		
		seat.LastPlayerFilterID = nil
	end
	
	if IsValid(ply) then
		-- ply:SetDSP(0)
		if ply.TankManipulatedBones then
			-- netStart("gred_net_simfphys_clearbonemanipulations")
				-- netWriteEntity(ply)
			-- netBroadcast()
			gred.ClearBoneManipulations(ply)
		end
		
		netStart("gred_net_simfphys_playerexitedseat")
		netSend(ply)
	end
end

gred.TankAddPlayerHooks = function(vehicle,seat,SeatID,ply,Mode,SteamID,SeatTab)
	hook.Add("PlayerEnteredVehicle","gred_simfphys_PlayerEnteredVehicle_"..SteamID,function(ply1,veh)
		if !IsValid(ply) then
			gred.TankRemovePlayerHooks(vehicle,seat,SeatID,ply,Mode,SteamID,SeatTab)
		elseif ply1 == ply then
			if ply:GetSimfphys() != vehicle then
				gred.TankRemovePlayerHooks(vehicle,seat,SeatID,ply,Mode,SteamID,SeatTab)
			else
				timer.Remove("CHANGESEATS_"..SteamID)
				gred.TankRemovePlayerHooks(vehicle,seat,SeatID,ply,Mode,SteamID,SeatTab)
				
				if veh == vehicle.DriverSeat then
					gred.TankPlayerEnteredSeat(vehicle,veh,0,ply,Mode)
				else
					local seatID = table.KeyFromValue(vehicle.pSeat,veh)
					
					if seatID then
						gred.TankPlayerEnteredSeat(vehicle,veh,seatID,ply,Mode)
					end
				end
			end
		end
	end)
	
	hook.Add("PlayerLeaveVehicle","gred_simfphys_PlayerLeaveVehicle_"..SteamID,function(ply1,veh)
		if !IsValid(ply) then
			gred.TankRemovePlayerHooks(vehicle,seat,SeatID,ply,Mode,SteamID,SeatTab)
		elseif ply1 == ply then
			timer.Create("CHANGESEATS_"..SteamID,0.04,1,function()
				if !IsValid(ply) or ply:GetSimfphys() != vehicle then
					gred.TankRemovePlayerHooks(vehicle,seat,SeatID,ply,Mode,SteamID,SeatTab)
				end
			end)
		end
	end)
end

gred.TankGetDirectionPoseParamName = function(DirectionPoseParamTab)
	for k,v in pairs(DirectionPoseParamTab) do
		if !v.Mul or v.Mul == 1 then
			return k
		end
	end
	
	return next(DirectionPoseParamTab)
end

gred.TankPlayerEnteredSeat = function(vehicle,seat,SeatID,ply,Mode)
	local SeatTab = gred.simfphys[vehicle.CachedSpawnList].Seats and gred.simfphys[vehicle.CachedSpawnList].Seats[SeatID] and gred.simfphys[vehicle.CachedSpawnList].Seats[SeatID][Mode]
	
	-- if SeatTab and SeatTab.PlayerBoneManipulation then
		-- netStart("gred_net_simfphys_playerenteredseat_broadcast")
			-- netWriteEntity(ply)
		-- netBroadcast()
		
		-- ply.TankManipulatedBones = SeatTab.PlayerBoneManipulation and true or false
	-- else
	if SeatTab and SeatTab.PlayerBoneManipulation then
		gred.ClearBoneManipulations(ply)
		gred.DoBoneManipulation(vehicle,seat,SeatID,ply,nil,SeatTab)
	end
	
	netStart("gred_net_simfphys_playerenteredseat")
	netSend(ply)
	-- end
	
	local SteamID = GetSteamID(ply)
	
	SetCollisionGroup(ply,SeatTab and SeatTab.Outside and 5 or 10)
	
	seat.LastPlayerFilterID = table.insert(vehicle.FILTER,ply)
	
	gred.TankAddPlayerHooks(vehicle,seat,SeatID,ply,Mode,SteamID,SeatTab)
	
	CallOnRemove(vehicle,"RemoveHooks"..SteamID,function(vehicle)
		gred.TankRemovePlayerHooks(vehicle,seat,SeatID,ply,Mode,SteamID,SeatTab)
	end)
	
	if SeatTab and SeatTab.PoseParameters and (SeatTab.PoseParameters.Yaw or SeatTab.PoseParameters.Pitch) then
		local Angles = Angle()
		
		if SeatTab.PoseParameters.Pitch then
			local Tab = gred.TankGetDirectionPoseParamName(SeatTab.PoseParameters.Pitch)
			Angles.p = GetPoseParameter(vehicle,Tab)
			Angles.p = (SeatTab.PoseParameters.Pitch[Tab].Invert and -Angles.p or Angles.p) - SeatTab.PoseParameters.Pitch[Tab].Offset
		else
			Angles.p = 0
		end
		
		if SeatTab.PoseParameters.Yaw then
			local Tab = gred.TankGetDirectionPoseParamName(SeatTab.PoseParameters.Yaw)
			Angles.y = GetPoseParameter(vehicle,Tab)
			Angles.y = (SeatTab.PoseParameters.Yaw[Tab].Invert and -Angles.y or Angles.y) - SeatTab.PoseParameters.Yaw[Tab].Offset
		else
			Angles.y = 0
		end
		
		-- if SeatTab.CustomEyeAngles then
			-- Angles = SeatTab.CustomGetEyeAngles(vehicle,seat,SeatTab,ply,HatchID,PoseParamTab,Angles)
		-- else
			-- if SeatTab.UseRawAngles then
				-- if seat.LocalView then
					-- if SeatTab.UseSeatAngles then
						-- Angles = WorldToLocalAngles(seat,Angles) - WorldToLocalAngles(vehicle,Angles)
					-- else
						-- Angles = WorldToLocalAngles(seat,Angles)
					-- end
				-- end
			-- else
				-- if seat.LocalView then
					-- if SeatTab.UseSeatAngles then
						-- Angles = WorldToLocalAngles(vehicle,WorldToLocalAngles(seat,Angles)) - WorldToLocalAngles(vehicle,GetAngles(seat))
					-- else
						-- Angles = WorldToLocalAngles(vehicle,WorldToLocalAngles(seat,Angles))
					-- end
				-- else
					-- Angles = Angle()
					-- print(Angles,vehicle:GetAngles())
				-- end
			-- end
		-- end
		
		
		
		timer.Simple(FrameTime()*3,function()
			if IsValid(ply) then
				if seat.LocalView then
					Angles = LocalToWorldAngles(vehicle,Angles)
					Angles.r = 0
					SetEyeAngles(ply,Angles)
				else
					Angles:Sub(WorldToLocalAngles(vehicle,GetAngles(seat)))
					Angles.r = 0
					SetEyeAngles(ply,Angles)
				end
			end
		end)
	else
		timer.Simple(FrameTime()*3,function()
			if IsValid(ply) then
				SetEyeAngles(ply,WorldToLocalAngles(seat,GetAngles(seat)) + angle_yaw_90)
			end
		end)
	end
	
	seat.PlayerButtons = {
		[GetInfoNum(ply,"gred_cl_simfphys_key_togglehatch",25)] = "Hatch",
		[GetInfoNum(ply,"gred_cl_simfphys_key_togglegun",22)] = "SlotID",
		[GetInfoNum(ply,"gred_cl_simfphys_key_changeshell",21)] = "CannonShell",
		[GetInfoNum(ply,"gred_cl_simfphys_key_throwsmoke",17)] = "SmokeGrenade",
	}
	seat.Driver = ply
	
	hook.Add("PlayerButtonDown","gred_simfphys_PlayerButtonDown_"..SteamID,function(ply,button)
		if seat.Driver and seat.Driver == ply and seat.PlayerButtons[button] then
			seat[seat.PlayerButtons[button]] = true
		end
	end)
	
	hook.Add("PlayerButtonUp","gred_simfphys_PlayerButtonUp_"..SteamID,function(ply,button)
		if seat.Driver and seat.Driver == ply and seat.PlayerButtons[button] then
			seat[seat.PlayerButtons[button]] = false
		end
	end)
end

gred.TankSetPassenger = function(self,ply,Mode) -- doesn't really need to be optimized
	if !self.FullyInitialized then return end
	if not IsValid(ply) then return end
	
	Mode = Mode or (self.ArcadeMode and "ArcadeMode" or "NormalMode")
	
	if not IsValid(self:GetDriver()) and not KeyDown(ply,IN_WALK) then
		ply:SetAllowWeaponsInVehicle(false)
		
		if IsValid(self.DriverSeat) then
			self:EnteringSequence(ply)
			ply:EnterVehicle(self.DriverSeat)
			gred.TankPlayerEnteredSeat(self,self.DriverSeat,0,ply,Mode)
		end
	else
		if self.PassengerSeats then
			local closestSeat = self:GetClosestSeat(ply)
			if not closestSeat or IsValid(closestSeat:GetDriver()) then
				for i = 1,#self.pSeat do
					if IsValid(self.pSeat[i]) then
						if not IsValid(self.pSeat[i]:GetDriver()) then
							ply:EnterVehicle(self.pSeat[i])
							gred.TankPlayerEnteredSeat(self,self.pSeat[i],i,ply,Mode)
							
							break
						end
					end
				end
			else
				ply:EnterVehicle(closestSeat)
				gred.TankPlayerEnteredSeat(self,closestSeat,table.KeyFromValue(self.pSeat,closestSeat),ply,Mode)
			end
		end
	end
end



gred.ClearBoneManipulations = function(ply)
	if !ply.TankManipulatedBones then return end
	-- PrintBones(ply)
	for k,v in pairs(ply.TankManipulatedBones) do
		ply:ManipulateBoneAngles(v,angle_zero)
	end
	
	ply.TankManipulatedBones = nil
end

gred.DoBoneManipulation = function(vehicle,seat,SeatID,ply,BoneTab,SeatTab)
	if SeatTab.PlayerBoneManipulation or BoneTab then
		local Bone
		ply.TankManipulatedBones = ply.TankManipulatedBones or {}
		
		for k,v in pairs(BoneTab or SeatTab.PlayerBoneManipulation) do
			Bone = ply:LookupBone(k)
			if Bone then
				ply.TankManipulatedBones[k] = Bone
				ply:ManipulateBoneAngles(Bone,v)
			end
		end
	end
end

hook.Add("PlayerDeath","gred_ply_extinguish_PlayerDeath",function(ply,ent)
	if IsValid(ent) and (ent.GetClass and ent:GetClass() or ent.ClassName) == "entityflame" then
		ent:Remove()
	end
	
	ply:Extinguish()
end)


------------------------------------------------------------------
--
--
-- SIMFPHYS OVERRIDE
--
--
------------------------------------------------------------------

hook.Remove("PlayerSpawn","gred_givesurrender_PlayerSpawn")
hook.Remove("OnEntityCreated","gred_OnEntityCreated_fixdamage")
hook.Remove("PlayerEnteredVehicle","gred_PlayerEnteredVehicle_overridegroup")
if true then return end -- disabled

local CommonSWEPs = {
	["cross_arms_swep"] = true,
	["surrender_animation_swep"] = true,
	["cross_arms_infront_swep"] = true,
	["cross_arms_swep"] = true,
}

local TEAMS = {
	[2] = 1,
	[3] = 1,
	[4] = 2,
	[5] = 2,
}
local SWEPs = {
	{
		["garde_a_vousv1.1"] = true,
	},
	{
		["garde_a_vousv1.2"] = true,
	},
}

local v

for k,v in pairs(SWEPs) do
	for K,V in pairs(CommonSWEPs) do
		v[K] = true
	end
end


hook.Add("PlayerSpawn","gred_givesurrender_PlayerSpawn",function(ply)
	timer.Simple(0.1,function()
		local Team = ply:Team()
		if TEAMS[Team] and SWEPs[TEAMS[Team]] then
			for k,v in pairs(SWEPs[TEAMS[Team]]) do
				ply:Give(k)
			end
		end
	end)
end)

hook.Add("PlayerEnteredVehicle","gred_PlayerEnteredVehicle_overridegroup",function(ply,vehicle)
	SetCollisionGroup(ply,COLLISION_GROUP_PLAYER)
end)

local Normals = {
	Vector(-1,1,1),
	Vector(-1,-1,1),
	Vector(-1,-1,-1),
	Vector(-1,1,-1),
	Vector(1,1,-1),
	Vector(1,-1,-1),
}
hook.Add("OnEntityCreated","gred_OnEntityCreated_fixdamage",function(ent)
	if ent.IsSimfphyscar then
		ent.OnTakeDamage = function(self,dmginfo)
			if not self:IsInitialized() then return end
			
			local Damage = dmginfo:GetDamage() 
			local DamagePos = dmginfo:GetDamagePosition() 
			local Type = dmginfo:GetDamageType()
			local Driver = self:GetDriver()
			
			self.LastAttacker = dmginfo:GetAttacker() 
			self.LastInflictor = dmginfo:GetInflictor()
			
			if simfphys.DamageEnabled then
				netStart( "simfphys_spritedamage" )
					netWriteEntity( self )
					net.WriteVector( EntityWorldToLocal(self, DamagePos ) ) 
					net.WriteBool( false ) 
				netBroadcast()
				
				self:ApplyDamage( Damage, Type )
			end
			
			if self.IsArmored then return end
			
			if Type == DMG_BULLET then
				local players = {}
				local num = 0
				
				if IsValid(Driver) then
					players[Driver] = true
					num = num + 1
				end
				
				if self.pSeat then
					for k,v in pairs(self.pSeat) do
						local d = v:GetDriver()
						if IsValid(d) then
							players[d] = true
							num = num + 1
						end
					end
				end
				
				
				if num > 0 then
					for _,vec in pairs(Normals) do
						local DamageEndPos = EntityLocalToWorld(self,EntityWorldToLocal(self,DamagePos) * vec)
						debugoverlay.Line(DamagePos,DamageEndPos,color_white,6)
						for k,v in pairs(ents.FindAlongRay(DamagePos,DamageEndPos)) do
							if players[v] then
								TakeDamageInfo(v,dmginfo)
							end
						end
					end
				end
			else
				if IsValid(Driver) then
					local Distance = (DamagePos - GetPos(Driver)):Length() 
					if (Distance < 40) then
						local Damage = (70 - Distance) / 22
						dmginfo:ScaleDamage( Damage )
						TakeDamageInfo(Driver, dmginfo )
						
						local effectdata = EffectData()
							effectdata:SetOrigin( DamagePos )
						util.Effect( "BloodImpact", effectdata, true, true )
					end
				end
				
				if self.PassengerSeats then
					for i = 1, table.Count( self.PassengerSeats ) do
						local Passenger = self.pSeat[i]:GetDriver()
						
						if IsValid(Passenger) then
							local Distance = (DamagePos - GetPos(Passenger)):Length()
							local Damage = (70 - Distance) / 22
							if (Distance < 40) then
								dmginfo:ScaleDamage( Damage )
								TakeDamageInfo(Passenger, dmginfo )
								
								local effectdata = EffectData()
									effectdata:SetOrigin( DamagePos )
								util.Effect( "BloodImpact", effectdata, true, true )
							end
						end
					end
				end
			end
		end
	end
end)
