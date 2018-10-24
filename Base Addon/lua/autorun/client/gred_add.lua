AddCSLuaFile()

local GRED_SVAR = { FCVAR_REPLICATED, FCVAR_ARCHIVE, FCVAR_SERVER_CAN_EXECUTE, FCVAR_NOTIFY }
-- local GRED_SVAR = { FCVAR_REPLICATED }

CreateConVar("gred_sv_easyuse"					,  "1"  , GRED_SVAR)
CreateConVar("gred_sv_maxforcefield_range"		, "5000", GRED_SVAR)
CreateConVar("gred_sv_12mm_he_impact"			,  "1"  , GRED_SVAR)
CreateConVar("gred_sv_7mm_he_impact"			,  "1"  , GRED_SVAR)
CreateConVar("gred_sv_fragility"				,  "1"  , GRED_SVAR)
CreateConVar("gred_sv_shockwave_unfreeze"		,  "0"  , GRED_SVAR)
CreateConVar("gred_sv_tracers"					,  "5"  , GRED_SVAR)
CreateConVar("gred_sv_oldrockets"				,  "0"  , GRED_SVAR)
CreateConVar("gred_jets_speed"					,  "1"  , GRED_SVAR)
CreateConVar("gred_sv_healthslider"				, "100" , GRED_SVAR)
CreateConVar("gred_sv_enablehealth"				,  "1"  , GRED_SVAR)
CreateConVar("gred_sv_enableenginehealth"		,  "1"  , GRED_SVAR)
CreateConVar("gred_sv_fire_effect"				,  "1"  , GRED_SVAR)
CreateConVar("gred_sv_multiple_fire_effects"	,  "1"  , GRED_SVAR)
CreateConVar("gred_sv_bullet_dmg"				,  "1"  , GRED_SVAR)
CreateConVar("gred_sv_bullet_radius"			,  "1"  , GRED_SVAR)
CreateConVar("gred_sv_soundspeed_divider"		,  "1"  , GRED_SVAR)
-- CreateConVar("gred_sv_decals"					,  "1"  , GRED_SVAR)
CreateConVar("gred_sv_arti_spawnaltitude"		, "1000", GRED_SVAR)
CreateConVar("gred_sv_wac_radio"				,  "1"  , GRED_SVAR)
CreateConVar("gred_sv_spawnable_bombs"			,  "1"  , GRED_SVAR)
CreateConVar("gred_sv_wac_bombs"				,  "1"  , GRED_SVAR)
CreateConVar("gred_sv_shellspeed_multiplier"	,  "2"  , GRED_SVAR)
CreateConVar("gred_sv_wac_explosion_water"		,  "1"  , GRED_SVAR)
CreateConVar("gred_sv_default_wac_munitions"	,  "0"  , GRED_SVAR)
CreateConVar("gred_sv_wac_explosion"			,  "1"  , GRED_SVAR)
CreateConVar("gred_sv_wac_heli_spin"			,  "1"  , GRED_SVAR)
CreateConVar("gred_sv_wac_heli_spin_chance"		,  "0"  , GRED_SVAR)

CreateClientConVar("gred_cl_sound_shake"		, "1" , true,false)
CreateClientConVar("gred_cl_nowaterimpacts"		, "0" , true,false)
CreateClientConVar("gred_cl_insparticles"		, "0" , true,false)
CreateClientConVar("gred_cl_noparticles_7mm"	, "0" , true,false)
CreateClientConVar("gred_cl_noparticles_12mm"	, "0" , true,false)
CreateClientConVar("gred_cl_noparticles_20mm"	, "0" , true,false)
CreateClientConVar("gred_cl_noparticles_20mm"	, "0" , true,false)
CreateClientConVar("gred_cl_noparticles_30mm"	, "0" , true,false)
CreateClientConVar("gred_cl_noparticles_40mm"	, "0" , true,false)
CreateClientConVar("gred_cl_decals"				, "1" , true,false)
CreateClientConVar("gred_cl_altmuzzleeffect"	, "0" , true,false)
CreateClientConVar("gred_cl_wac_explosions" 	, "1" , true,false)

-----------------------------------------------------------
-- Adding the spawnmenu options
local function gredsettings(CPanel)
	CPanel:ClearControls()
	sounds={}
	sounds[1]="extras/terrorist/allahu.mp3"
	
	psounds={}
	psounds[1]="extras/american/outgoingstraferun1.ogg"
	psounds[2]="extras/american/outgoingstraferun2.ogg"
	psounds[3]="extras/american/outgoingstraferun3.ogg"
	psounds[4]="extras/american/outgoingstraferun4.ogg"
	psounds[5]="extras/american/outgoingstraferun5.ogg"
	Created = true;
	------------------------------BOMBS SETTINGS----------------------------------
	local logo = vgui.Create( "DImageButton" );
	logo:SetImage( "hud/bombs_settings.png" );
	logo:SetSize( 250, 250 );
	logo.DoClick = function()
		local snd = Sound( table.Random(sounds) );
		surface.PlaySound( snd );
	end
	CPanel:AddPanel( logo );
	
	CPanel:AddControl( "CheckBox", { Label = "Should there be sound shake?", Command = "gred_cl_sound_shake" } );
	local notdedicated = !game.IsDedicated()
	if notdedicated then
		CPanel:AddControl( "CheckBox", { Label = "Should all bombs unweld and unfreeze?", Command = "gred_sv_shockwave_unfreeze" } );
		
		CPanel:NumSlider( "Forcefield Max Range", "gred_sv_maxforcefield_range", 10, 10000, 0 );
		
		CPanel:NumSlider( "Sound muffling divider", "gred_sv_soundspeed_divider", 1, 3, 0 );
		
		CPanel:AddControl( "CheckBox", { Label = "Should bombs be easily armed?", Command = "gred_sv_easyuse" } );
		
		CPanel:AddControl( "CheckBox", { Label = "Should explosives be spawnable?", Command = "gred_sv_spawnable_bombs" } );
		
		CPanel:AddControl( "CheckBox", { Label = "Should bombs arm when hit or dropped?", Command = "gred_sv_fragility" } );
	end
		
	CPanel:AddControl( "CheckBox", { Label = "Should bombs leave decals behind?", Command = "gred_cl_decals" } );
	
	------------------------------PLANES SETTINGS-------------------------------
	local plane = vgui.Create( "DImageButton" );
	plane:SetImage( "hud/planes_settings.png" );
	plane:SetSize( 200, 80 );
	plane.DoClick = function()
		local psnd = Sound( table.Random(psounds) );
		surface.PlaySound( psnd );
	end
	CPanel:AddPanel( plane );
	if notdedicated then
	
		CPanel:AddControl( "CheckBox", { Label = "Use old rockets?", Command = "gred_sv_oldrockets" } );
		
		CPanel:AddControl( "CheckBox", { Label = "Enable bombs in aircrafts?", Command = "gred_sv_wac_bombs" } );
		
		CPanel:AddControl( "CheckBox", { Label = "Enable radio sounds?", Command = "gred_sv_wac_radio" } );
		
		CPanel:AddControl( "CheckBox", { Label = "Should jets be very fast?", Command = "gred_jets_speed" } );
		
		CPanel:AddControl( "CheckBox", { Label = "Should aircrafts crash underwater?", Command = "gred_sv_wac_explosion_water" } );
		
		CPanel:AddControl( "CheckBox", { Label = "Should aircrafts crash?", Command = "gred_sv_wac_explosion" } );
		
		CPanel:AddControl( "CheckBox", { Label = "Use the default WAC munitions?", Command = "gred_sv_default_wac_munitions" } );
	
		CPanel:AddControl( "CheckBox", { Label = "Should helicopters spin when their health is low?", Command = "gred_sv_wac_heli_spin" } );
		
		CPanel:AddControl( "CheckBox", { Label = "Use a custom health system?", Command = "gred_sv_enablehealth" } );
		
		CPanel:AddControl( "CheckBox", { Label = "Use a health per engine system?", Command = "gred_sv_enableenginehealth" } );
		
		CPanel:NumSlider( "Default engine health", "gred_sv_healthslider", 1, 1000, 0 );
		
		CPanel:NumSlider( "Helicopter spin chance", "gred_sv_wac_heli_spin_chance", 1, 10, 0 );
		
		CPanel:AddControl( "CheckBox", { Label = "Use alternative fire particles?", Command = "gred_sv_fire_effect" } );
			
		CPanel:AddControl( "CheckBox", { Label = "Use multiple fire particles?", Command = "gred_sv_multiple_fire_effects" } );
	end
	
	CPanel:AddControl( "CheckBox", { Label = "Enable explosion particles?", Command = "gred_cl_wac_explosions" } );
	------------------------------BULLETS SETTINGS-------------------------------
		
	CPanel:AddControl( "CheckBox", { Label = "Use an alternative muzzleflash?", Command = "gred_cl_altmuzzleeffect" } );
	
	if notdedicated then
		CPanel:AddControl( "CheckBox", { Label = "Should 12mm MGs have a blast radius? (Kills tanks!)", Command = "gred_sv_12mm_he_impact" } );
				
		CPanel:AddControl( "CheckBox", { Label = "Should 7mm MGs have a blast radius? (Kills tanks!)", Command = "gred_sv_7mm_he_impact" } );
		
		CPanel:NumSlider( "Bullet damage multiplier","gred_sv_bullet_dmg",0,10,2 );
		
		CPanel:NumSlider( "Bullet radius multiplier","gred_sv_bullet_radius",0,10,2 );
		
		CPanel:NumSlider( "Tracer ammo apparition", "gred_sv_tracers", 0, 20, 0 );
	end
	
	CPanel:AddControl( "CheckBox", { Label = "Use Insurgency impact effects for 7mm MGs?", Command = "gred_cl_insparticles" } );
			
	CPanel:AddControl( "CheckBox", { Label = "Disable impact effects for 7mm MGs?", Command = "gred_cl_noparticles_7mm" } );
			
	CPanel:AddControl( "CheckBox", { Label = "Disable impact effects for 12mm MGs?", Command = "gred_cl_noparticles_12mm" } );
		
	CPanel:AddControl( "CheckBox", { Label = "Disable impact effects for 20mm cannons?", Command = "gred_cl_noparticles_20mm" } );
			
	CPanel:AddControl( "CheckBox", { Label = "Disable impact effects for 30mm cannons?", Command = "gred_cl_noparticles_30mm" } );
		
	CPanel:AddControl( "CheckBox", { Label = "Disable impact effects for 40mm cannons?", Command = "gred_cl_noparticles_40mm" } );
			
	CPanel:AddControl( "CheckBox", { Label = "Disable water impact effects?", Command = "gred_cl_nowaterimpacts" } );
end

hook.Add( "PopulateToolMenu", "gred_menu", function()
	spawnmenu.AddToolMenuOption( "Options", "Gredwitch's Base", "GredwitchSettings", "Settings", "", "", gredsettings )
end );

function PlayerSpawn(ply)
	ply:ChatPrint("[Gredwitch's Base] Thank you for using Gredwitch's addons!")
	ply:ChatPrint("[Gredwitch's Base] Current version is : 08072018")
end
hook.Add( "PlayerInitialSpawn", "gred_cl_chatprint_version",PlayerSpawn)