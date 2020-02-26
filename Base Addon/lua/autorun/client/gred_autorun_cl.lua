include("gredwitch/gred_autorun_shared.lua")

local util = util
local pairs = pairs
local table = table
local istable = istable
local TraceLine = util.TraceLine
local Effect = util.Effect
local MASK_ALL = MASK_ALL
local game = game
local PrecacheParticleSystem = PrecacheParticleSystem
local CreateConVar = CreateConVar
local CreateClientConVar = CreateClientConVar
local tableinsert = table.insert
local IsValid = IsValid
local ply = LocalPlayer()

gred = gred or {}
gred.simfphys = gred.simfphys or {}
gred.CVars = gred.CVars or {}

gred.CVars["gred_cl_resourceprecache"] 						= CreateClientConVar("gred_cl_resourceprecache"						, "0" ,true,false)
gred.CVars["gred_cl_sound_shake"] 							= CreateClientConVar("gred_cl_sound_shake"							, "1" ,true,false)
gred.CVars["gred_cl_nowaterimpacts"] 						= CreateClientConVar("gred_cl_nowaterimpacts"						, "0" ,true,false)
gred.CVars["gred_cl_insparticles"]		 					= CreateClientConVar("gred_cl_insparticles"							, "0" ,true,false)
gred.CVars["gred_cl_noparticles_7mm"] 						= CreateClientConVar("gred_cl_noparticles_7mm"						, "0" ,true,false)
gred.CVars["gred_cl_noparticles_12mm"] 						= CreateClientConVar("gred_cl_noparticles_12mm"						, "0" ,true,false)
gred.CVars["gred_cl_noparticles_20mm"] 						= CreateClientConVar("gred_cl_noparticles_20mm"						, "0" ,true,false)
gred.CVars["gred_cl_noparticles_30mm"] 						= CreateClientConVar("gred_cl_noparticles_30mm"						, "0" ,true,false)
gred.CVars["gred_cl_noparticles_40mm"] 						= CreateClientConVar("gred_cl_noparticles_40mm"						, "0" ,true,false)
gred.CVars["gred_cl_decals"] 								= CreateClientConVar("gred_cl_decals"								, "1" ,true,false)
gred.CVars["gred_cl_altmuzzleeffect"] 						= CreateClientConVar("gred_cl_altmuzzleeffect"						, "0" ,true,false)
gred.CVars["gred_cl_wac_explosions"] 						= CreateClientConVar("gred_cl_wac_explosions" 						, "1" ,true,false)
gred.CVars["gred_cl_enable_popups"] 						= CreateClientConVar("gred_cl_enable_popups"	 					, "1" ,true,false)
gred.CVars["gred_cl_firstload"] 							= CreateClientConVar("gred_cl_firstload"							, "1" ,true,false)
gred.CVars["gred_cl_simfphys_sightsensitivity"] 			= CreateClientConVar("gred_cl_simfphys_sightsensitivity"			,"0.25",true,false)
gred.CVars["gred_cl_simfphys_maxsuspensioncalcdistance"] 	= CreateClientConVar("gred_cl_simfphys_maxsuspensioncalcdistance"	, "85000000" ,true,false)

local TAB_PRESS = {FCVAR_ARCHIVE,FCVAR_USERINFO}
CreateConVar("gred_cl_simfphys_key_changeshell"			, "21",TAB_PRESS)
CreateConVar("gred_cl_simfphys_key_togglesight"			, "22",TAB_PRESS)
CreateConVar("gred_cl_simfphys_key_togglegun"			, "23",TAB_PRESS)

hook.Add("Initialize","gred_init_precache_cl",function()
	gred.Precache()
	if gred.CVars["gred_cl_resourceprecache"]:GetBool() then
		gred.PrecacheResources()
	end
end)

local Created
local NextThink = 0
local NextFind = 0
local id = 0
local SIMFPHYS_COLOR = Color(255,235,0)

local function GetTrackPos(ent,div,smoother) -- taken from simfphys (by Luna)
	local FT =  FrameTime()
	local spin_left = ent.trackspin_l and (-ent.trackspin_l / div) or 0
	local spin_right = ent.trackspin_r and (-ent.trackspin_r / div) or 0
	
	ent.sm_TrackDelta_L = ent.sm_TrackDelta_L and (ent.sm_TrackDelta_L + (spin_left - ent.sm_TrackDelta_L) * smoother) or 0
	ent.sm_TrackDelta_R = ent.sm_TrackDelta_R and (ent.sm_TrackDelta_R + (spin_right- ent.sm_TrackDelta_R) * smoother) or 0

	return {Left = ent.sm_TrackDelta_L,Right = ent.sm_TrackDelta_R}
end

local function GetAllTanks()
	local class
	for k,v in pairs(gred.simfphys) do
		v.entities = {}
	end
	for k,v in pairs(ents.FindByClass("gmod_sent_vehicle_fphysics_base")) do
		class = v:GetSpawn_List()
		if gred.simfphys[class] then
			tableinsert(gred.simfphys[class].entities,v)
		end
	end
end

local function RoundAngle(ang,decimals)
	ang.p = math.Round(ang.p,decimals)
	ang.r = math.Round(ang.r,decimals)
	return ang
end

local function DrawAmmoLeft(vehicle,scrW,scrH)
	local sizex = scrW * ((scrW / scrH) > (4/3) and 1 or 1.32)
	local s_xpos = scrW * 0.5 - sizex * 0.115 - sizex * 0.032
	local s_ypos = scrH - scrH * 0.092 - scrH * 0.02
	local curgun = vehicle:GetNWInt("CurGun",1)
	local shelltype = vehicle:GetNWInt(curgun.."ShellType",1)
	draw.SimpleText("SHELLTYPE: "..vehicle.shellTypes[curgun][shelltype]..(vehicle:GetNWBool("Reloading",false) and " [RELOADING]" or ""),"simfphysfont", s_xpos + sizex * 0.185, s_ypos + scrH*0.012 ,SIMFPHYS_COLOR,0,1)
	draw.SimpleText("AMMO: "..vehicle:GetNWInt(curgun.."CurAmmo"..shelltype,0),"simfphysfont", s_xpos + sizex * 0.185, s_ypos + scrH*0.035 ,SIMFPHYS_COLOR,0,1)
end

local function DrawWorldTip(text,pos,tipcol,font,offset)
	pos = pos:ToScreen()
	local black = Color(0,0,0,tipcol.a)
	
	local x = 0
	local y = 0
	local padding = 10
	
	surface.SetFont(font)
	local w,h = surface.GetTextSize(text)
	
	x = pos.x - w*0.5
	y = pos.y - h*0.5 - offset
	
	draw.RoundedBox(8, x-padding-2, y-padding-2, w+padding*2+4, h+padding*2+4, black)
	draw.RoundedBox( 8, x-padding, y-padding, w+padding*2, h+padding*2, tipcol )
	draw.DrawText(text,font,x+w/2,y,black,TEXT_ALIGN_CENTER)

end

local function DrawCircle( X, Y, radius ) -- copyright LunasFlightSchool™
	local segmentdist = 360 / ( 2 * math.pi * radius / 2 )
	
	for a = 0, 360 - segmentdist, segmentdist do
		surface.DrawLine( X + math.cos( math.rad( a ) ) * radius, Y - math.sin( math.rad( a ) ) * radius, X + math.cos( math.rad( a + segmentdist ) ) * radius, Y - math.sin( math.rad( a + segmentdist ) ) * radius )
	end
end

local function gred_settings_bullets(CPanel)
	CPanel:ClearControls()
	
	-- if notdedicated then
		local this = CPanel:CheckBox("Should 12mm MGs have a radius?","gred_sv_12mm_he_impact" );
		this.OnChange = function(this,val)
			val = val and 1 or 0
			gred.CheckConCommand("gred_sv_12mm_he_impact",val)
		end
				
		local this = CPanel:CheckBox("Should 7mm MGs have a radius?","gred_sv_7mm_he_impact" );
		this.OnChange = function(this,val)
			val = val and 1 or 0
			gred.CheckConCommand("gred_sv_7mm_he_impact",val)
		end
		
		local this = CPanel:NumSlider( "Bullet damage multiplier","gred_sv_bullet_dmg",0,10,2 );this.Scratch.OnValueChanged = function() this.ConVarChanging = true this:ValueChanged(this.Scratch:GetFloatValue()) this.ConVarChanging = false end
		this.OnValueChanged = function(this,val)
			if this.ConVarChanging then return end
			gred.CheckConCommand("gred_sv_bullet_dmg",val)
		end
		
		local this = CPanel:NumSlider( "Bullet radius multiplier","gred_sv_bullet_radius",0,10,2 );this.Scratch.OnValueChanged = function() this.ConVarChanging = true this:ValueChanged(this.Scratch:GetFloatValue()) this.ConVarChanging = false end
		this.OnValueChanged = function(this,val)
			if this.ConVarChanging then return end
			gred.CheckConCommand("gred_sv_bullet_radius",val)
		end
		
		local this = CPanel:NumSlider( "Tracer ammo apparition", "gred_sv_tracers", 0, 20, 0 );this.Scratch.OnValueChanged = function() this.ConVarChanging = true this:ValueChanged(this.Scratch:GetFloatValue()) this.ConVarChanging = false end
		this.OnValueChanged = function(this,val)
			if this.ConVarChanging then return end
			gred.CheckConCommand("gred_sv_tracers",val)
		end
		
		if hab and hab.Module.PhysBullet then
			local this = CPanel:CheckBox("Override Havok's physical bullets?","gred_sv_override_hab" );
			this.OnChange = function(this,val)
				val = val and 1 or 0
				gred.CheckConCommand("gred_sv_override_hab",val)
			end
		end
	-- end
	
	CPanel:CheckBox("Use Insurgency impact effects for 7mm MGs?","gred_cl_insparticles" );
	
	CPanel:CheckBox("Disable impact effects for 7mm MGs?","gred_cl_noparticles_7mm" );
	
	CPanel:CheckBox("Disable impact effects for 12mm MGs?","gred_cl_noparticles_12mm" );
	
	CPanel:CheckBox("Disable impact effects for 20mm cannons?","gred_cl_noparticles_20mm" );
	
	CPanel:CheckBox("Disable impact effects for 30mm cannons?","gred_cl_noparticles_30mm" );
	
	CPanel:CheckBox("Disable impact effects for 40mm cannons?","gred_cl_noparticles_40mm" );
	
	CPanel:CheckBox("Disable water impact effects?","gred_cl_nowaterimpacts" );
end

local function gred_settings_wac(CPanel)
	CPanel:ClearControls()
	
	CPanel:AddPanel( plane );
	-- if notdedicated then
	
		local this = CPanel:CheckBox("Override the WAC base?","gred_sv_wac_override");
		this.OnChange = function(this,val)
			val = val and 1 or 0
			gred.CheckConCommand("gred_sv_wac_override",val)
		end
		
		local this = CPanel:CheckBox("Use old rockets?","gred_sv_oldrockets");
		this.OnChange = function(this,val)
			val = val and 1 or 0
			gred.CheckConCommand("gred_sv_oldrockets",val)
		end
		
		local this = CPanel:CheckBox("Enable bombs in aircrafts?","gred_sv_wac_bombs");
		this.OnChange = function(this,val)
			val = val and 1 or 0
			gred.CheckConCommand("gred_sv_wac_bombs",val)
		end
		
		local this = CPanel:CheckBox("Enable radio sounds?","gred_sv_wac_radio");
		this.OnChange = function(this,val)
			val = val and 1 or 0
			gred.CheckConCommand("gred_sv_wac_radio",val)
		end
		
		local this = CPanel:CheckBox("Should jets be very fast?","gred_jets_speed");
		this.OnChange = function(this,val)
			val = val and 1 or 0
			gred.CheckConCommand("gred_jets_speed",val)
		end
		
		local this = CPanel:CheckBox("Should aircrafts crash underwater?","gred_sv_wac_explosion_water");
		this.OnChange = function(this,val)
			val = val and 1 or 0
			gred.CheckConCommand("gred_sv_wac_explosion_water",val)
		end
		
		local this = CPanel:CheckBox("Should aircrafts crash?","gred_sv_wac_explosion");
		this.OnChange = function(this,val)
			val = val and 1 or 0
			gred.CheckConCommand("gred_sv_wac_explosion",val)
		end
		
		local this = CPanel:CheckBox("Use the default WAC munitions?","gred_sv_default_wac_munitions");
		this.OnChange = function(this,val)
			val = val and 1 or 0
			gred.CheckConCommand("gred_sv_default_wac_munitions",val)
		end
	
		local this = CPanel:CheckBox("Should helicopters spin when their health is low?","gred_sv_wac_heli_spin");
		this.OnChange = function(this,val)
			val = val and 1 or 0
			gred.CheckConCommand("gred_sv_wac_heli_spin",val)
		end
		
		local this = CPanel:CheckBox("Use a custom health system?","gred_sv_enablehealth");
		this.OnChange = function(this,val)
			val = val and 1 or 0
			gred.CheckConCommand("gred_sv_enablehealth",val)
		end
		
		local this = CPanel:CheckBox("Use a health per engine system?","gred_sv_enableenginehealth");
		this.OnChange = function(this,val)
			val = val and 1 or 0
			gred.CheckConCommand("gred_sv_enableenginehealth",val)
		end
		
		local this = CPanel:NumSlider( "Default engine health", "gred_sv_healthslider", 1, 1000, 0 );this.Scratch.OnValueChanged = function() this.ConVarChanging = true this:ValueChanged(this.Scratch:GetFloatValue()) this.ConVarChanging = false end
		this.OnValueChanged = function(this,val)
			if this.ConVarChanging then return end
			gred.CheckConCommand("gred_sv_healthslider",val)
		end
		
		local this = CPanel:NumSlider( "Helicopter spin chance", "gred_sv_wac_heli_spin_chance", 1, 10, 0 );this.Scratch.OnValueChanged = function() this.ConVarChanging = true this:ValueChanged(this.Scratch:GetFloatValue()) this.ConVarChanging = false end
		this.OnValueChanged = function(this,val)
			if this.ConVarChanging then return end
			gred.CheckConCommand("gred_sv_wac_heli_spin_chance",val)
		end
		
		local this = CPanel:CheckBox("Use alternative fire particles?","gred_sv_fire_effect");
		this.OnChange = function(this,val)
			val = val and 1 or 0
			gred.CheckConCommand("gred_sv_fire_effect",val)
		end
			
		local this = CPanel:CheckBox("Use multiple fire particles?","gred_sv_multiple_fire_effects");
		this.OnChange = function(this,val)
			val = val and 1 or 0
			gred.CheckConCommand("gred_sv_multiple_fire_effects",val)
		end
	-- end
	
	CPanel:CheckBox("Enable explosion particles?","gred_cl_wac_explosions");
	
end

local function gred_settings_misc(CPanel)
	CPanel:ClearControls()
	
	Created = true;
	
	CPanel:CheckBox("Use an alternative muzzleflash?","gred_cl_altmuzzleeffect");
	CPanel:CheckBox("Enable pop ups about missing content?","gred_cl_enable_popups");
	CPanel:CheckBox("Auto-precache resources? (increases loading times & timeouts)","gred_cl_resourceprecache");
	local this = CPanel:CheckBox("(SERVER) Auto-precache resources? (increases server boot time)","gred_sv_resourceprecache");
	this.OnChange = function(this,val)
		val = val and 1 or 0
		gred.CheckConCommand("gred_sv_resourceprecache",val)
	end
end

local function gred_settings_simfphys(CPanel)
	CPanel:ClearControls()
	
	Created = true;
	
	local this = CPanel:CheckBox("Arcade mode","gred_sv_simfphys_arcade");
	local parent = this:GetParent()
	this.OnChange = function(this,val)
		val = val and 1 or 0
		gred.CheckConCommand("gred_sv_simfphys_arcade",val)
	end
	
	local this = CPanel:CheckBox("Infinite ammo","gred_sv_simfphys_infinite_ammo");
	local parent = this:GetParent()
	this.OnChange = function(this,val)
		val = val and 1 or 0
		gred.CheckConCommand("gred_sv_simfphys_infinite_ammo",val)
	end
	
	local this = CPanel:CheckBox("Enable 3rd person crosshair?","gred_sv_simfphys_enablecrosshair");
	local parent = this:GetParent()
	this.OnChange = function(this,val)
		val = val and 1 or 0
		gred.CheckConCommand("gred_sv_simfphys_enablecrosshair",val)
	end
	
	local this = CPanel:CheckBox("Use 4 wheels instead of 6 for tanks?","gred_sv_simfphys_lesswheels");
	local parent = this:GetParent()
	this.OnChange = function(this,val)
		val = val and 1 or 0
		gred.CheckConCommand("gred_sv_simfphys_lesswheels",val)
	end
	
	local this = CPanel:CheckBox("Spawn without ammo","gred_sv_simfphys_spawnwithoutammo");
	local parent = this:GetParent()
	this.OnChange = function(this,val)
		val = val and 1 or 0
		gred.CheckConCommand("gred_sv_simfphys_spawnwithoutammo",val)
	end
	
	local this = CPanel:NumSlider("Turn rate multipler", "gred_sv_simfphys_turnrate_multplier",0,3,2);
	this.Scratch.OnValueChanged = function() this.ConVarChanging = true this:ValueChanged(this.Scratch:GetFloatValue()) this.ConVarChanging = false end
	this.OnValueChanged = function(this,val)
		if this.ConVarChanging then return end
		gred.CheckConCommand( "gred_sv_simfphys_turnrate_multplier",val)
	end
	
	local this = CPanel:NumSlider("Health multipler", "gred_sv_simfphys_health_multplier",1,3,2);
	this.Scratch.OnValueChanged = function() this.ConVarChanging = true this:ValueChanged(this.Scratch:GetFloatValue()) this.ConVarChanging = false end
	this.OnValueChanged = function(this,val)
		if this.ConVarChanging then return end
		gred.CheckConCommand( "gred_sv_simfphys_health_multplier",val)
	end
	
	-- local this = CPanel:CheckBox("Should bullets damage tanks?","gred_sv_simfphys_bullet_dmg_tanks");
	-- local parent = this:GetParent()
	-- this.OnChange = function(this,val)
		-- val = val and 1 or 0
		-- gred.CheckConCommand("gred_sv_simfphys_bullet_dmg_tanks",val)
	-- end
	
	local DBinder = vgui.Create("DBinder")
	DBinder:SetValue(GetConVar("gred_cl_simfphys_key_changeshell"):GetInt())
	DBinder.OnChange = function(DBinder,key)
		GetConVar("gred_cl_simfphys_key_changeshell"):SetInt(key)
	end
	CPanel:AddItem(CPanel:Help("Toggle shell types"),DBinder)
	
	local DBinder = vgui.Create("DBinder")
	DBinder:SetValue(GetConVar("gred_cl_simfphys_key_togglesight"):GetInt())
	DBinder.OnChange = function(DBinder,key)
		GetConVar("gred_cl_simfphys_key_togglesight"):SetInt(key)
	end
	CPanel:AddItem(CPanel:Help("Toggle tank sight"),DBinder)
	
	local DBinder = vgui.Create("DBinder")
	DBinder:SetValue(GetConVar("gred_cl_simfphys_key_togglegun"):GetInt())
	DBinder.OnChange = function(DBinder,key)
		GetConVar("gred_cl_simfphys_key_togglegun"):SetInt(key)
	end
	CPanel:AddItem(CPanel:Help("Toggle tank gun"),DBinder)
	
	local this = CPanel:NumSlider("Sensitivity in sight mode","gred_cl_simfphys_sightsensitivity",0,1,2);this.Scratch.OnValueChanged = function() this.ConVarChanging = true this:ValueChanged(this.Scratch:GetFloatValue()) this.ConVarChanging = false end
	this.OnValueChanged = function(this,val)
		if this.ConVarChanging then return end
		GetConVar("gred_cl_simfphys_sightsensitivity"):SetInt(val)
	end
	
	local this = CPanel:NumSlider("Max suspension calculation distance","gred_cl_simfphys_maxsuspensioncalcdistance",0,300000000,0);this.Scratch.OnValueChanged = function() this.ConVarChanging = true this:ValueChanged(this.Scratch:GetFloatValue()) this.ConVarChanging = false end
	this.OnValueChanged = function(this,val)
		if this.ConVarChanging then return end
		GetConVar("gred_cl_simfphys_maxsuspensioncalcdistance"):SetInt(val)
	end
end

local function gred_settings_lfs(CPanel)
	CPanel:ClearControls()
	
	-- local msounds={}
	-- msounds[1]="extras/american/outgoingstraferun1.ogg"
	Created = true;
	
	-- local plane = vgui.Create( "DImageButton" );
	-- plane:SetImage( "hud/planes_settings.png" );
	-- plane:SetSize( 200, 80 );
	-- plane.DoClick = function()
		-- local psnd = Sound( table.Random(psounds) );
		-- surface.PlaySound( psnd );
	-- end
	-- CPanel:AddPanel( plane );
	-- if notdedicated then
	
		local this = CPanel:NumSlider( "Aircraft health multiplier", "gred_sv_lfs_healthmultiplier", 1, 10, 2 );this.Scratch.OnValueChanged = function() this.ConVarChanging = true this:ValueChanged(this.Scratch:GetFloatValue()) this.ConVarChanging = false end
		this.OnValueChanged = function(this,val)
			if this.ConVarChanging then return end
			gred.CheckConCommand("gred_sv_lfs_healthmultiplier",val)
		end
		
		local this = CPanel:CheckBox("Should the health multiplier only apply to Gredwitch's LFS aircrafts?","gred_sv_lfs_healthmultiplier_all");
		this.OnChange = function(this,val)
			val = val and 1 or 0
			gred.CheckConCommand("gred_sv_lfs_healthmultiplier_all",val)
		end
		
		local this = CPanel:CheckBox("Should LFS aircrafts be invincible?","gred_sv_lfs_godmode");
		this.OnChange = function(this,val)
			val = val and 1 or 0
			gred.CheckConCommand("gred_sv_lfs_godmode",val)
		end
		
		local this = CPanel:CheckBox("Should LFS aircrafts have infinite ammo?","gred_sv_lfs_infinite_ammo");
		this.OnChange = function(this,val)
			val = val and 1 or 0
			gred.CheckConCommand("gred_sv_lfs_infinite_ammo",val)
		end
		
	-- end
end

local function gred_settings_bombs(CPanel)
	CPanel:ClearControls()
	--[[local sound = "extras/terrorist/allahu.mp3"
	
	Created = true;
	
	local logo = vgui.Create( "DImageButton" );
	logo:SetImage( "hud/bombs_settings.png" );
	logo:SetSize( 250, 250 );
	logo.DoClick = function()
		local snd = Sound( sound );
		surface.PlaySound( snd );
	end
	CPanel:AddPanel( logo );--]]
	
	CPanel:CheckBox("Should there be sound shake when something explodes?","gred_cl_sound_shake");
	
	-- if notdedicated then
		local this = CPanel:CheckBox("Should explosions unweld and unfreeze?","gred_sv_shockwave_unfreeze");
		this.OnChange = function(this,val)
			val = val and 1 or 0
			gred.CheckConCommand("gred_sv_shockwave_unfreeze",val)
		end
		
		local this = CPanel:NumSlider( "Sound muffling divider", "gred_sv_soundspeed_divider", 1, 3, 0 );
		this.Scratch.OnValueChanged = function() this.ConVarChanging = true this:ValueChanged(this.Scratch:GetFloatValue()) this.ConVarChanging = false end
		this.OnValueChanged = function(this,val)
			if this.ConVarChanging then return end
			gred.CheckConCommand( "gred_sv_soundspeed_divider",val)
		end
	
		local this = CPanel:NumSlider( "Shell speed multiplier", "gred_sv_shell_speed_multiplier", 0.01, 1, 2 );
		this.Scratch.OnValueChanged = function() this.ConVarChanging = true this:ValueChanged(this.Scratch:GetFloatValue()) this.ConVarChanging = false end
		this.OnValueChanged = function(this,val)
			if this.ConVarChanging then return end
			gred.CheckConCommand( "gred_sv_shell_speed_multiplier",val)
		end
		local this = CPanel:NumSlider("Ricochet angle", "gred_sv_minricochetangle",50, 90, 1 );
		this.Scratch.OnValueChanged = function() this.ConVarChanging = true this:ValueChanged(this.Scratch:GetFloatValue()) this.ConVarChanging = false end
		this.OnValueChanged = function(this,val)
			if this.ConVarChanging then return end
			gred.CheckConCommand( "gred_sv_minricochetangle",val)
		end
		local this = CPanel:NumSlider("HE Shells damage multiplier", "gred_sv_shell_he_damagemultiplier",0,10,2);
		this.Scratch.OnValueChanged = function() this.ConVarChanging = true this:ValueChanged(this.Scratch:GetFloatValue()) this.ConVarChanging = false end
		this.OnValueChanged = function(this,val)
			if this.ConVarChanging then return end
			gred.CheckConCommand( "gred_sv_shell_he_damagemultiplier",val)
		end
		local this = CPanel:NumSlider("Anti-Tank Shells damage multiplier", "gred_sv_shell_ap_damagemultiplier",0,10,2);
		this.Scratch.OnValueChanged = function() this.ConVarChanging = true this:ValueChanged(this.Scratch:GetFloatValue()) this.ConVarChanging = false end
		this.OnValueChanged = function(this,val)
			if this.ConVarChanging then return end
			gred.CheckConCommand( "gred_sv_shell_ap_damagemultiplier",val)
		end
		local this = CPanel:NumSlider("Max non-penetration ricochet chance", "gred_sv_shell_ap_lowpen_maxricochetchance",0,1,2);
		this.Scratch.OnValueChanged = function() this.ConVarChanging = true this:ValueChanged(this.Scratch:GetFloatValue()) this.ConVarChanging = false end
		this.OnValueChanged = function(this,val)
			if this.ConVarChanging then return end
			gred.CheckConCommand( "gred_sv_shell_ap_lowpen_maxricochetchance",val)
		end
		
		local this = CPanel:CheckBox("Enable advanced non-penetration system?","gred_sv_shell_ap_lowpen_system");
		this.OnChange = function(this,val)
			val = val and 1 or 0
			gred.CheckConCommand("gred_sv_shell_ap_lowpen_system",val)
		end
		
		local this = CPanel:CheckBox("Should the non-penetration system decrease damage?","gred_sv_shell_ap_lowpen_shoulddecreasedamage");
		this.OnChange = function(this,val)
			val = val and 1 or 0
			gred.CheckConCommand("gred_sv_shell_ap_lowpen_shoulddecreasedamage",val)
		end
		
		local this = CPanel:CheckBox("Should the Anti-Tank shells deal no damage if there was no penetration?","gred_sv_shell_ap_lowpen_ap_damage");
		this.OnChange = function(this,val)
			val = val and 1 or 0
			gred.CheckConCommand("gred_sv_shell_ap_lowpen_ap_damage",val)
		end
		
		local this = CPanel:CheckBox("Should explosives be easily armed?","gred_sv_easyuse");
		this.OnChange = function(this,val)
			val = val and 1 or 0
			gred.CheckConCommand("gred_sv_easyuse",val)
		end
		
		local this = CPanel:CheckBox("Should explosives be spawnable?","gred_sv_spawnable_bombs");
		this.OnChange = function(this,val)
			val = val and 1 or 0
			gred.CheckConCommand("gred_sv_spawnable_bombs",val)
		end
		
		local this = CPanel:CheckBox("Should explosives arm when hit or dropped?","gred_sv_fragility");
		this.OnChange = function(this,val)
			val = val and 1 or 0
			gred.CheckConCommand("gred_sv_fragility",val)
		end
	-- end
		
	CPanel:CheckBox("Should explosives leave decals behind?","gred_cl_decals");
	
end

local function CheckForUpdates()
	local CURRENT_VERSION = ""
	local changelogs = file.Exists("changelog.lua","LUA") and file.Read("changelog.lua","LUA") or false
	changelogs = changelogs or (file.Exists("changelog.lua","lsv") and file.Read("changelog.lua","lsv") or "")
	for i = 1,14 do if !changelogs[i] then break end CURRENT_VERSION = CURRENT_VERSION..changelogs[i] end
	local GITHUB_VERSION = "" 
	local GitHub = http.Fetch("https://raw.githubusercontent.com/Gredwitch/gredwitch-base/master/Base%20Addon/lua/changelog.lua",function(body)
		if !body then return end
		for i = 1,14 do GITHUB_VERSION = GITHUB_VERSION..body[i] end
		if CURRENT_VERSION != GITHUB_VERSION then
			local DFrame = vgui.Create("DFrame")
			DFrame:SetSize(ScrW()*0.9,ScrH()*0.9)
			DFrame:SetTitle("GREDWITCH'S BASE IS OUT OF DATE. EXPECT LUA ERRORS!")
			DFrame:Center()
			DFrame:MakePopup()
			
			local DHTML = vgui.Create("DHTML",DFrame)
			DHTML:Dock(FILL)
			DHTML:OpenURL("https://steamcommunity.com/workshop/filedetails/discussion/1131455085/1640915206496685563/")
		end
	end)
	local exists = file.Exists("gredwitch_base.txt","DATA")
	if !exists or (exists and file.Read("gredwitch_base.txt","DATA") != CURRENT_VERSION) then
		local DFrame = vgui.Create("DFrame")
		DFrame:SetSize(ScrW()*0.5,ScrH()*0.5)
		DFrame:SetTitle("Gredwitch's Base : last update changelogs")
		DFrame:Center()
		DFrame:MakePopup()
		
		local DHTML = vgui.Create("DHTML",DFrame)
		DHTML:Dock(FILL)
		DHTML:OpenURL("https://raw.githubusercontent.com/Gredwitch/gredwitch-base/master/Base%20Addon/lua/changelog.lua")
		
		file.Write("gredwitch_base.txt",CURRENT_VERSION)
	end
end

local function CheckDXDiag()
	if GetConVar("mat_dxlevel"):GetInt() < 90 then
		local DFrame = vgui.Create("DFrame")
		DFrame:SetSize(ScrW()*0.9,ScrH()*0.9)
		DFrame:SetTitle("DXDIAG ERROR")
		DFrame:Center()
		DFrame:MakePopup()
		
		local DHTML = vgui.Create("DHTML",DFrame)
		DHTML:Dock(FILL)
		DHTML:OpenURL("https://steamcommunity.com/workshop/filedetails/discussion/1131455085/3166519278505386201/")
	end
end



gred.CheckConCommand = function(cmd,val)
	net.Start("gred_net_checkconcommand")
		net.WriteString(cmd)
		net.WriteFloat(val)
	net.SendToServer()
end

gred.UpdateBoneTable = function(self)
	if self.CreatingBones then return end
	self.Bones = nil
	timer.Simple(0,function()
		if !self or (self and !IsValid(self)) then return end
		if self.CreatingBones then return end
		self.CreatingBones = true
		self:SetLOD(0)
		self.Bones = {}
		local name
		for i=0, self:GetBoneCount()-1 do
			name = self:GetBoneName(i)
			if name == "__INVALIDBONE__" and ((self.BoneBlackList and !self.BoneBlackList[i]) or !self.BoneBlackList) and i != 0 then
				-- print("["..self.ClassName.."] INVALID BONE : "..i)
				self.Bones = nil
				break
			end
			self.Bones[name] = i
		end
		self:SetLOD(-1)
		self.CreatingBones = false
	end)
end

gred.ManipulateBoneAngles = function(self,bone,angle)
	if !self.Bones or (self.Bones and !self.Bones[bone]) then
		gred.UpdateBoneTable(self)
		return
	end
	
	self:ManipulateBoneAngles(self.Bones[bone],angle)
end

gred.ManipulateBonePosition = function(self,bone,pos)
	if !self.Bones or (self.Bones and !self.Bones[bone]) then
		gred.UpdateBoneTable(self)
		return
	end
	
	self:ManipulateBonePosition(self.Bones[bone],pos)
end

gred.ManipulateBoneScale = function(self,bone,scale)
	if !self.Bones or (self.Bones and !self.Bones[bone]) then
		gred.UpdateBoneTable(self)
		return
	end
	
	self:ManipulateBoneScale(self.Bones[bone],scale)
end

gred.HandleFlyBySound = function(self,ply,ct,minvel,maxdist,delay,snd)
	ply.NGPLAY = ply.NGPLAY or 0
	ply.lfsGetPlane = ply.lfsGetPlane or function() return nil end
	if ply:lfsGetPlane() != self and (ply.NGPLAY < ct) and self:GetEngineActive() then
		local vel = self:GetVelocity():Length()
		if vel >= minvel then
			local plypos = ply:GetPos()
			local pos = self:GetPos()
			local dist = pos:Distance(plypos)
			if dist < maxdist then
				ply.NGPLAY = ct + delay
				ply:EmitSound(snd)
			end
		end
	end
end

gred.HandleVoiceLines = function(self,ply,ct,hp)
	ply.lfsGetPlane = ply.lfsGetPlane or function() return nil end
	self.BumpSound = self.BumpSound or ct
	if self.BumpSound < ct then
		for k,v in pairs(self.SoundQueue) do
			ply:EmitSound(v)
			
			table.RemoveByValue(self.SoundQueue,v)
			self.BumpSound = ct + 4
			break
		end
	end
	
	if self.IsDead then
		local Driver = self:GetDriver()
		if self.CheckDriver and Driver != self.OldDriver and !IsValid(Driver) then
			for k,v in pairs(player.GetAll()) do
				if v:lfsGetAITeam() == self.OldDriver:lfsGetAITeam() and (IsValid(v:lfsGetPlane()) or v == self.OldDriver) then
					v:EmitSound("GRED_VO_BAILOUT_0"..math.random(1,3))
				end
			end
		end
		self.CheckDriver = true
		self.OldDriver = Driver
	end
	if ply:lfsGetPlane() == self then
		if self.EmitNow.wing_r and self.EmitNow.wing_r != "CEASE" then
			self.EmitNow.wing_r = "CEASE"
			table.insert(self.SoundQueue,"GRED_VO_HOLE_RIGHT_WING_0"..math.random(1,3))
		end
		if self.EmitNow.wing_l and self.EmitNow.wing_l != "CEASE" then
			self.EmitNow.wing_l = "CEASE"
			table.insert(self.SoundQueue,"GRED_VO_HOLE_LEFT_WING_0"..math.random(1,3))
		end
		if hp == 0 then
			self.IsDead = true
		end
	end
end

gred.LFSHUDPaintFilterParts = function(self)
	local partnum = {}
	local a = 1
	if self.Parts then
		for k,v in pairs(self.Parts) do
			partnum[a] = v
			a = a + 1
		end
	end
	partnum[a] = self
	
	return partnum
end

gred.CalcViewThirdPersonLFSParts = function(self,view,ply)
	view.origin = ply:EyePos()
	local Parent = ply:lfsGetPlane()
	local Pod = ply:GetVehicle()
	local radius = 550
	radius = radius + radius * Pod:GetCameraDistance()
	local TargetOrigin = view.origin - view.angles:Forward() * radius  + view.angles:Up() * radius * 0.2
	local WallOffset = 4
	local tr = util.TraceHull( {
		start = view.origin,
		endpos = TargetOrigin,
		filter = function( e )
			local c = e:GetClass()
			local collide = not c:StartWith( "prop_physics" ) and not c:StartWith( "prop_dynamic" ) and not c:StartWith( "prop_ragdoll" ) and not e:IsVehicle() and not c:StartWith( "gmod_" ) and not c:StartWith( "player" ) and not e.LFS and Parent:GetCalcViewFilter(e)
			
			return collide
		end,
		mins = Vector( -WallOffset, -WallOffset, -WallOffset ),
		maxs = Vector( WallOffset, WallOffset, WallOffset ),
	} )
	view.origin = tr.HitPos
	
	if tr.Hit and not tr.StartSolid then
		view.origin = view.origin + tr.HitNormal * WallOffset
	end
	
	return view
end

gred.GunnersInit = function(self)
	local ATT
	local seat
	for k,v in pairs(self.Gunners) do
		for a,b in pairs(v.att) do
			v.att[a] = self:LookupAttachment(b)
		end
	end
end

gred.GunnersDriverHUDPaint = function(self,ply)
	if !self.Initialized then
		gred.GunnersInit(self)
		self.Initialized = true
	end
	
	local att
	local tr
	local filter = self:GetCrosshairFilterEnts()
	local ScrW,ScrH = ScrW(),ScrH()
	local pparam1
	local pparam2
	local alpha
	
	for k,v in pairs(self.Gunners) do
		att = self:GetAttachment(v.att[1])
		tr = TraceLine({
			start = att.Pos,
			endpos = (att.Pos + att.Ang:Forward() * 50000),
			filter = filter
		})
		
		alpha = !IsValid(self["GetGunner"..k](self)) and 255 or 0
		
		pparam1,pparam2 = self:GetPoseParameter(v.poseparams[1]),self:GetPoseParameter(v.poseparams[2])
		
		if pparam1 == 1 or pparam2 == 1 or pparam1 == 0 or pparam2 == 0 then -- yea but shut up ok
			surface.SetDrawColor(255,0,0,alpha)
		else
			surface.SetDrawColor(0,255,0,alpha)
		end
		
		tr.ScreenPos = tr.HitPos:ToScreen()
		tr.ScreenPos.x = tr.ScreenPos.x > ScrW and tr.ScreenPosW or (tr.ScreenPos.x < 0 and 0 or tr.ScreenPos.x)
		tr.ScreenPos.y = tr.ScreenPos.y > ScrH and tr.ScreenPosH or (tr.ScreenPos.y < 0 and 0 or tr.ScreenPos.y)
		DrawCircle(tr.ScreenPos.x,tr.ScreenPos.y,5)
	end
end

gred.GunnersHUDPaint = function(self,ply)
	if !self.Initialized then
		gred.GunnersInit(self)
		self.Initialized = true
	end
	
	local att
	local tr
	local filter = self:GetCrosshairFilterEnts()
	local ScrW,ScrH = ScrW(),ScrH()
	local pparam1
	local pparam2
	local veh = ply:GetVehicle()
	for k,v in pairs(self.Gunners) do
		if veh == self["GetGunnerSeat"..k](self) then
			att = self:GetAttachment(v.att[1])
			tr = TraceLine({
				start = att.Pos,
				endpos = (att.Pos + att.Ang:Forward() * 50000),
				filter = filter
			})
			
			pparam1,pparam2 = self:GetPoseParameter(v.poseparams[1]),self:GetPoseParameter(v.poseparams[2])
			
			if pparam1 == 1 or pparam2 == 1 or pparam1 == 0 or pparam2 == 0 then -- yea but shut up ok
				surface.SetDrawColor(255,0,0,255)
			else
				surface.SetDrawColor(0,255,0,255)
			end
			
			tr.ScreenPos = tr.HitPos:ToScreen()
			tr.ScreenPos.x = tr.ScreenPos.x > ScrW and tr.ScreenPosW or (tr.ScreenPos.x < 0 and 0 or tr.ScreenPos.x)
			tr.ScreenPos.y = tr.ScreenPos.y > ScrH and tr.ScreenPosH or (tr.ScreenPos.y < 0 and 0 or tr.ScreenPos.y)
			DrawCircle(tr.ScreenPos.x,tr.ScreenPos.y,5)
			break
		end
	end
end



hook.Add("Think","gred_simfphys_managetanks",function()
	local ct = CurTime()
	if ct > NextThink then
		NextThink = ct + 0.02
		if ct > NextFind then
			NextFind = ct + 30
			GetAllTanks()
		end
		ply = IsValid(ply) and ply or LocalPlayer()
		local pos = ply:GetPos()
		local var = gred.CVars["gred_cl_simfphys_maxsuspensioncalcdistance"]:GetInt()
		for class,tab in pairs(gred.simfphys) do
			for k,v in pairs(tab.entities) do
				if IsValid(v) then
					if pos:DistToSqr(v:GetPos()) < var then
						if !v.GRED_INDEX then
							id = id + 1
							v.GRED_INDEX = id
						end
						if not v.wheel_left_mat then
							v.wheel_left_mat = CreateMaterial("gred_trackmat_"..class.."_"..v.GRED_INDEX.."_left","VertexLitGeneric",tab.trackTex)
						end

						if not v.wheel_right_mat then
							v.wheel_right_mat = CreateMaterial("gred_trackmat_"..class.."_"..v.GRED_INDEX.."_right","VertexLitGeneric",tab.trackTex)
						end
						local TrackPos = GetTrackPos(v,tab.div,tab.smoother)
						if tab.UpTranslate then
							v.wheel_left_mat:SetVector("$translate",Vector(0,0,TrackPos.Left))
							v.wheel_right_mat:SetVector("$translate",Vector(0,0,TrackPos.Right))
						elseif tab.RightTranslate then
							v.wheel_left_mat:SetVector("$translate",Vector(TrackPos.Left))
							v.wheel_right_mat:SetVector("$translate",Vector(TrackPos.Right))
						else
							v.wheel_left_mat:SetVector("$translate",Vector(0,TrackPos.Left))
							v.wheel_right_mat:SetVector("$translate",Vector(0,TrackPos.Right))
						end
						-- PrintTable(v:GetMaterials())
						if tab.SeparateTracks then
							if !IsValid(v.LeftTrack) then v.LeftTrack = v:GetNWEntity("LeftTrack") end
							if !IsValid(v.RightTrack) then v.RightTrack = v:GetNWEntity("RightTrack") end
							if !IsValid(v.RightTrack) or !IsValid(v.LeftTrack) then return end -- one last check just to be safe
							v.LeftTrack:SetSubMaterial(tab.LeftTrackID,"!gred_trackmat_"..class.."_"..v.GRED_INDEX.."_left") 
							v.RightTrack:SetSubMaterial(tab.RightTrackID,"!gred_trackmat_"..class.."_"..v.GRED_INDEX.."_right")
						else
							v:SetSubMaterial(tab.LeftTrackID,"!gred_trackmat_"..class.."_"..v.GRED_INDEX.."_left") 
							v:SetSubMaterial(tab.RightTrackID,"!gred_trackmat_"..class.."_"..v.GRED_INDEX.."_right")
						end
					end
				else
					table.remove(tab.entities,k)
				end
			end
		end
	end
end)

hook.Add( "PopulateToolMenu", "gred_menu", function()
	spawnmenu.AddToolMenuOption("Options",					-- Tab
								"Gredwitch's Stuff",		-- Sub-tab
								"gred_settings_bullets",	-- Identifier
								"Bullets",					-- Name of the sub-sub-tab
								"",							-- Command
								"",							-- Config (deprecated)
								gred_settings_bullets		-- Function
	)
	spawnmenu.AddToolMenuOption("Options",
								"Gredwitch's Stuff",
								"gred_settings_wac",
								"WAC",
								"",
								"",
								gred_settings_wac
	)
	spawnmenu.AddToolMenuOption("Options",
								"Gredwitch's Stuff",
								"gred_settings_lfs",
								"LFS",
								"",
								"",
								gred_settings_lfs
	)
	spawnmenu.AddToolMenuOption("Options",
								"Gredwitch's Stuff",
								"gred_settings_bombs",
								"Explosives",
								"",
								"",
								gred_settings_bombs
	)
	spawnmenu.AddToolMenuOption("Options",
								"Gredwitch's Stuff",
								"gred_settings_misc",
								"Misc",
								"",
								"",
								gred_settings_misc
	)
	spawnmenu.AddToolMenuOption("Options",
								"Gredwitch's Stuff",
								"gred_settings_simfphys",
								"Simfphys",
								"",
								"",
								gred_settings_simfphys
	)
end );

hook.Add("CalcView","gred_simfphys_tanksightview",function(ply,ang,pos)
	if !IsValid(ply) or !ply:Alive() or !ply:InVehicle() or ply:GetViewEntity() != ply then return end
	local vehicle = ply:GetVehicle()
	if not IsValid(vehicle) then return end
	local Base = ply.GetSimfphys and ply:GetSimfphys() or vehicle.vehiclebase
	if not IsValid(Base) then return end
	if !vehicle.GetThirdPersonMode or ply:GetViewEntity() ~= ply then return end
	if vehicle.GRED_USE_SIGHT and vehicle:GetThirdPersonMode() then 
		vehicle:SetThirdPersonMode(false)
	end
	if vehicle:GetNWBool("simfphys_SpecialCam") or not vehicle.GRED_USE_SIGHT or vehicle.GRED_SIGHT_ATT == 0 then return end
	
	local view = {
		origin = pos,
		drawviewer = false,
	}
	ply.simfphys_smooth_out = 0
	local attachment = Base:GetAttachment(vehicle.GRED_SIGHT_ATT)
	attachment.Ang = vehicle:GetNWBool("HasStabilizer") and RoundAngle(attachment.Ang,2) or attachment.Ang
	view.angles = attachment.Ang + vehicle.GRED_SIGHT_OFFSET_ANG
	view.origin = attachment.Pos + attachment.Ang:Forward() * vehicle.GRED_SIGHT_OFFSET.x  + attachment.Ang:Right() * vehicle.GRED_SIGHT_OFFSET.y  + attachment.Ang:Up() *  vehicle.GRED_SIGHT_OFFSET.z
	view.fov = vehicle:GetNWFloat("SightZoom",40)
	return view
end)

hook.Add("AdjustMouseSensitivity","gred_tank_sight",function(val)
	local ply = LocalPlayer()
	if not IsValid(ply) or not ply:Alive() then return end
	local vehicle = ply:GetVehicle()
	if not IsValid(vehicle) then return end
	if not vehicle.GRED_USE_SIGHT or vehicle.GRED_SIGHT_ATT == 0 then return end
	if !vehicle.GetThirdPersonMode then return end
	if vehicle:GetThirdPersonMode() then return end
	
	return gred.CVars.gred_cl_simfphys_sightsensitivity:GetFloat()
end)

hook.Add("HUDPaint","gred_simfphys_tanksighthud",function()
	local ply = LocalPlayer()
	if not IsValid(ply) or not ply:Alive() then return end
	if not ply:InVehicle() or ply:GetViewEntity() ~= ply then
		local obj = ply:GetNWEntity("PickedUpObject",nil)
		if !IsValid(obj) or obj.ClassName != "base_shell" then return end
		local pos = ply:GetPos()
		local sqr = 350*350
		for k,ent in pairs(ents.FindInSphere(pos,350)) do
			if ent.ClassName == "gmod_sent_vehicle_fphysics_base" then
				if ent.GRED_ISTANK == nil then 
					timer.Simple(0.4,function()
						if IsValid(ent) and ent.GRED_ISTANK == nil then
							ent.GRED_ISTANK = ent:GetNWBool("GRED_ISTANK")
						end
					end)
				end
				if ent.Seats == nil then
					ent.Seats = ent.pSeat and table.Copy(ent.pSeat) or {}
					table.insert(ent.Seats,ent:GetDriverSeat())
				end
				if ent.GRED_ISTANK and istable(ent.Seats) then
					local _,maxs = ent:GetModelBounds()
					maxs.x = 0
					maxs.y = 0
					local textpos = ent:LocalToWorld(maxs)
					local col = Color(100,100,100,math.Clamp((1 - pos:DistToSqr(textpos) / sqr) * 1200,0,255))
					local i = 0
					for a,seat in pairs(ent.Seats) do
						if IsValid(seat) and seat:GetNWBool("HasCannon") then
							seat.shellTypes = seat.shellTypes or util.JSONToTable(seat:GetNWString("ShellTypes"))
							seat.maxAmmo = seat.maxAmmo or seat:GetNWInt("1MaxAmmo",0)
							local curammo = 0
							local ammo
							local str = ""
							for A = 1,#seat.shellTypes do
								ammo = seat:GetNWInt("1CurAmmo"..A,0)
								curammo = curammo + ammo
								str = str..seat.shellTypes[A]..": "..ammo..(A == #seat.shellTypes and "" or "\n")
							end
							str = seat:GetNWInt("1Caliber",0).."mm cannon\nCapacity: "..curammo.."/"..seat.maxAmmo.."\n"..str
							DrawWorldTip(str,textpos,col,"GModWorldtip",150*i)
							i = i + 1
						end
					end
				end
			end
		end
		return
	end
	
	local vehicle = ply:GetVehicle()
	if not IsValid(vehicle) then return end
	local Base = ply.GetSimfphys and ply:GetSimfphys() or vehicle.vehiclebase
	if not IsValid(Base) then return end
	
	vehicle.shellTypes = vehicle.shellTypes or util.JSONToTable(vehicle:GetNWString("ShellTypes"))
	local scrW,scrH
	if vehicle.shellTypes and !vehicle.GRED_USE_SIGHT then
		scrW,scrH = ScrW(),ScrH()
		DrawAmmoLeft(vehicle,scrW,scrH)
	end
	if vehicle:GetNWBool("simfphys_SpecialCam") or not vehicle.GRED_USE_SIGHT or vehicle.GRED_SIGHT_ATT == 0 then return end
	if !vehicle.GetThirdPersonMode or ply:GetViewEntity() ~= ply then return end
	if vehicle:GetThirdPersonMode() then return end
	
	local ScrW,ScrH = scrW or ScrW(),scrH or ScrH()
	surface.SetDrawColor(255,255,255,255)
	surface.SetTexture(surface.GetTextureID(vehicle:GetNWString("SightTexture")))
	local zoom = 1
	surface.DrawTexturedRect((-(ScrW*zoom-ScrW)*0.5),(-(ScrW*zoom-ScrH)*0.5),ScrW*zoom,ScrW*zoom)
	
	if vehicle.shellTypes and vehicle.GRED_USE_SIGHT then
		DrawAmmoLeft(vehicle,ScrW,ScrH)
	end
	
	Base.GRED_FILTER_ENTS = Base.GRED_FILTER_ENTS or {
		Base,
	}
	local startpos = Base:GetAttachment(vehicle.GRED_SIGHT_ATT).Pos
	local scr = TraceLine({
		start = startpos,
		endpos = (startpos + ply:EyeAngles():Forward() * 50000),
		-- mask = MASK_WATER,
		filter = Base.GRED_FILTER_ENTS,
	}).HitPos:ToScreen()
	
	scr.x = scr.x > ScrW and ScrW or (scr.x < 0 and 0 or scr.x)
	scr.y = scr.y > ScrH and ScrH or (scr.y < 0 and 0 or scr.y)
	
	surface.SetDrawColor(255,255,255)
	DrawCircle(scr.x,scr.y,19)
	surface.SetDrawColor(0,0,0)
	DrawCircle(scr.x,scr.y,20)
	
	local scrW,scrH = ScrW*0.5,ScrH*0.518
	
	surface.SetDrawColor( 240, 200, 0, 255 ) 
	local Yaw = Base:GetPoseParameter( "turret_yaw" ) * 360 - 90
	
	local dX = math.cos( math.rad( -Yaw ) )
	local dY = math.sin( math.rad( -Yaw ) )
	local len = scrH * 0.04
	
	DrawCircle( scrW, scrH * 1.85, len )
	surface.DrawLine( scrW + dX * len, scrH * 1.85 + dY * len, scrW + dX * len * 3, scrH * 1.85 + dY * len * 3 )
	
	surface.DrawLine( scrW - len * 1.25, scrH * 1.85 - len * 2, scrW - len * 1.25, scrH * 1.85 + len * 2 )
	surface.DrawLine( scrW + len * 1.25, scrH * 1.85 - len * 2, scrW + len * 1.25, scrH * 1.85 + len * 2 )
	surface.DrawLine( scrW - len * 1.25, scrH * 1.85 - len * 2, scrW + len * 1.25, scrH * 1.85 - len * 2 )
	surface.DrawLine( scrW - len * 1.25, scrH * 1.85 + len * 2, scrW + len * 1.25, scrH * 1.85 + len * 2 )
end)



net.Receive("gred_net_tank_setsight",function()
	local ply = LocalPlayer()
	local pod = ply:GetVehicle()
	local offset = net.ReadVector()
	local att = net.ReadString()
	local angoffset = net.ReadAngle()
	if !IsValid(pod) then return end
	
	pod.GRED_SIGHT_OFFSET_ANG 	= angoffset
	pod.GRED_SIGHT_OFFSET 		= offset
	pod.GRED_SIGHT_ATT 			= ply:GetSimfphys():LookupAttachment(att)
	pod.GRED_USE_SIGHT 			= !pod.GRED_USE_SIGHT
end)

net.Receive("gred_lfs_setparts",function()
	local self = net.ReadEntity()
	if not self then print("[LFS] ERROR! ENTITY NOT INITALIZED CLIENT SIDE! PLEASE, RE-SPAWN!") return end
	self.Parts = {}
	for k,v in pairs(net.ReadTable()) do
		self.Parts[k] = v
	end
end)

net.Receive("gred_lfs_remparts",function()
	local self = net.ReadEntity()
	local k = net.ReadString()
	
	self.EmitNow = istable(self.EmitNow) and self.EmitNow or {}
	if self.EmitNow and (k == "wing_l" or k == "wing_r") and self.EmitNow[k] != "CEASE" then
		self.EmitNow[k] = true
	end
	if self.Parts then
		self.Parts[k] = nil
	end
end)

net.Receive("gred_net_registertank",function(length)
	local ent = net.ReadEntity()
	if not IsValid(ent) or !ent.GetSpawn_List then return end
	
	local tab = gred.simfphys[ent:GetSpawn_List()]
	tableinsert(tab.entities,ent)
	if tab.UpdateSuspension_CL and ent:GetModel() != "models/error.mdl" then
		local OldThink = ent.Think
		ent.Think = function(ent)
			OldThink(ent)
			tab.UpdateSuspension_CL(ent)
		end
	end
end)

net.Receive("gred_net_send_ply_hint_key",function()
	surface.PlaySound("ambient/water/drip"..math.random(1,4)..".wav")
	notification.AddLegacy("Press the '"..input.GetKeyName(net.ReadInt(9))..net.ReadString(),NOTIFY_HINT,10)
end)

net.Receive("gred_net_check_binding_simfphys",function()
	if input.LookupBinding("+walk") != nil then return end
	
	local DFrame = vgui.Create("DFrame")
	DFrame:SetSize(ScrW()*0.9,ScrH()*0.9)
	DFrame:Center()
	DFrame:MakePopup()
	DFrame:SetDraggable(false)
	DFrame:ShowCloseButton(false)
	DFrame:SetTitle("YOU DON'T HAVE YOUR +WALK KEY BOUND, WHICH IS REQUIRED IF YOU WANT THE TANK TURRET TO WORK")
	
	timer.Simple(3,function()
		if !IsValid(DFrame) then return end
		DFrame:ShowCloseButton(true)
	end)
	
	local DHTML = vgui.Create("DHTML",DFrame)
	DHTML:Dock(FILL)
	DHTML:OpenURL("https://steamuserimages-a.akamaihd.net/ugc/773983150582822983/8FAB41F8FDC796EF2033B0AF3379DF5734DDC150/")
	
end)

net.Receive("gred_net_send_ply_hint_simple",function()
	surface.PlaySound("ambient/water/drip"..math.random(1,4)..".wav")
	notification.AddLegacy(net.ReadString(),NOTIFY_HINT,10)
end)

net.Receive("gred_net_message_ply",function()
	ply = IsValid(ply) and ply or LocalPlayer()
	local msg = net.ReadString()
	ply:PrintMessage(HUD_PRINTTALK,msg)
end)

net.Receive("gred_net_bombs_decals",function()
	local decal = net.ReadString()
	local start = net.ReadVector()
	local hitpos = net.ReadVector()
	if GetConVar("gred_cl_decals"):GetInt() <= 0 then return end
	util.Decal(decal,start,hitpos)
end)

net.Receive("gred_net_sound_lowsh",function()
	ply = IsValid(ply) and ply or LocalPlayer()
	ply:GetViewEntity():EmitSound(net.ReadString())
end)

net.Receive("gred_net_nw_var",function()
	local self = net.ReadEntity()
	local str = net.ReadString()
	local t = net.ReadInt(4)
	if t == 1 then
		local val = net.ReadString()
		self:SetNWString(str,val)
	elseif t == 2 then
		local ent = net.ReadEntity()
		self:SetNWEntity(str,ent)
	elseif t == 3 then
		local table = net.ReadTable()
		self:SetNWTable(str,table)
	end
end)

net.Receive("gred_net_createtracer",function()
	local effect = EffectData()
	effect:SetOrigin(net.ReadVector())
	effect:SetFlags(net.ReadInt(4))
	effect:SetMaterialIndex(net.ReadInt(4))
	effect:SetStart(net.ReadVector())
	Effect("gred_particle_tracer",effect)
end)

net.Receive("gred_net_createimpact",function()
	-- local tab = util.JSONToTable(net.ReadString())
	-- local effectdata = EffectData()
	-- effectdata:SetOrigin(tab[1])
	-- effectdata:SetAngles(tab[2])
	-- effectdata:SetSurfaceProp(tab[3])
	-- effectdata:SetMaterialIndex(tab[4])
	-- effectdata:SetFlags(tab[5])
	-- Effect("gred_particle_impact",effectdata)
	
	local effectdata = EffectData()
	effectdata:SetOrigin(net.ReadVector())
	effectdata:SetAngles(net.ReadAngle())
	effectdata:SetSurfaceProp(net.ReadInt(4))
	effectdata:SetMaterialIndex(net.ReadInt(4))
	effectdata:SetFlags(net.ReadInt(4))
	Effect("gred_particle_impact",effectdata)
end)

net.Receive("gred_net_createparticle",function()
	local effectdata = EffectData()
	effectdata:SetFlags(table.KeyFromValue(gred.Particles,net.ReadString()))
	effectdata:SetOrigin(net.ReadVector())
	effectdata:SetAngles(net.ReadAngle())
	effectdata:SetSurfaceProp(net.ReadBool() and 1 or 0)
	Effect("gred_particle_simple",effectdata)
end)
		
timer.Simple(5,function()
	local singleplayerIPs = {
		["loopback"] = true,
		["0.0.0.0"] = true,
		["0.0.0.0:port"] = true,
	}
	if singleplayerIPs[game.GetIPAddress()] then
		CheckForUpdates()
	end
	CheckDXDiag()
end)
