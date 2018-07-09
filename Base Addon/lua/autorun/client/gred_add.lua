AddCSLuaFile()

-- Adding particles
game.AddParticles( "particles/doi_explosion_fx.pcf")
game.AddParticles( "particles/doi_explosion_fx_b.pcf")
game.AddParticles( "particles/doi_explosion_fx_c.pcf")
game.AddParticles( "particles/doi_explosion_fx_grenade.pcf")
game.AddParticles( "particles/doi_explosion_fx_new.pcf")
game.AddParticles( "particles/doi_impact_fx.pcf" )
game.AddParticles( "particles/doi_weapon_fx.pcf" )

game.AddParticles( "particles/gb_water.pcf")
game.AddParticles( "particles/gb5_100lb.pcf")
game.AddParticles( "particles/gb5_500lb.pcf")
game.AddParticles( "particles/gb5_1000lb.pcf")
game.AddParticles( "particles/gb5_jdam.pcf")
game.AddParticles( "particles/gb5_large_explosion.pcf")
game.AddParticles( "particles/gb5_napalm.pcf")
game.AddParticles( "particles/gb5_light_bomb.pcf")
game.AddParticles( "particles/gb5_high_explosive_2.pcf")
game.AddParticles( "particles/gb5_high_explosive.pcf")
game.AddParticles( "particles/neuro_tank_ap.pcf")

game.AddParticles( "particles/ins_rockettrail.pcf")
game.AddParticles( "particles/doi_rockettrail.pcf")
game.AddParticles( "particles/mnb_flamethrower.pcf")
game.AddParticles( "particles/impact_fx_ins.pcf" )
game.AddParticles( "particles/environment_fx.pcf")
game.AddParticles( "particles/water_impact.pcf")
game.AddParticles( "particles/explosion_fx_ins.pcf")
game.AddParticles( "particles/weapon_fx_tracers.pcf" )
game.AddParticles( "particles/weapon_fx_ins.pcf" )

game.AddParticles( "particles/gred_particles.pcf" )

-- Precaching main particles
PrecacheParticleSystem("gred_20mm")
PrecacheParticleSystem("gred_20mm_airburst")
PrecacheParticleSystem("30cal_impact")
PrecacheParticleSystem("doi_gunrun_impact")
PrecacheParticleSystem("doi_artillery_explosion")
PrecacheParticleSystem("doi_stuka_explosion")
PrecacheParticleSystem("gred_mortar_explosion")
PrecacheParticleSystem("gred_mortar_explosion")
PrecacheParticleSystem("ins_water_explosion")
-----------------------------------------------------------
-- Adding console vars
local GRED_SVAR = { FCVAR_REPLICATED, FCVAR_ARCHIVE, FCVAR_SERVER_CAN_EXECUTE, FCVAR_NOTIFY }

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
CreateConVar("gred_sv_bombs_nocustomexplosion"  ,  "0"  , GRED_SVAR)
CreateConVar("gred_sv_fire_effect"				,  "1"  , GRED_SVAR)
CreateConVar("gred_sv_multiple_fire_effects"	,  "1"  , GRED_SVAR)
CreateConVar("gred_sv_bullet_dmg"				,  "1"  , GRED_SVAR)
CreateConVar("gred_sv_bullet_radius"			,  "1"  , GRED_SVAR)
CreateConVar("gred_sv_soundspeed_divider"		,  "1"  , GRED_SVAR)

CreateConVar("gred_sv_nowaterimpacts"			,  "0"  , GRED_SVAR)
CreateConVar("gred_sv_insparticles"				,  "0"  , GRED_SVAR)
CreateConVar("gred_sv_noparticles_7mm"			,  "0"  , GRED_SVAR)
CreateConVar("gred_sv_noparticles_12mm"			,  "0"  , GRED_SVAR)
CreateConVar("gred_sv_noparticles_20mm"			,  "0"  , GRED_SVAR)
CreateConVar("gred_sv_noparticles_20mm"			,  "0"  , GRED_SVAR)
CreateConVar("gred_sv_noparticles_30mm"			,  "0"  , GRED_SVAR)
CreateConVar("gred_sv_altmuzzleeffect"			,  "0"  , GRED_SVAR)

CreateClientConVar("gred_cl_decals"			 	, "1" , true,true)
CreateClientConVar("gred_cl_sound_shake"		, "1" , true,true)

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
	
	if ply:IsListenServerHost() then
	CPanel:AddControl( "CheckBox", { Label = "Should all bombs unweld and unfreeze?", Command = "gred_sv_shockwave_unfreeze" } );
	
	CPanel:NumSlider( "Forcefield Max Range", "gred_sv_maxforcefield_range", 10, 10000, 0 );
	
	CPanel:NumSlider( "Sound muffling divider", "gred_sv_soundspeed_divider", 1, 3, 0 );
	end
	CPanel:AddControl( "CheckBox", { Label = "Should bombs leave decals behind?", Command = "gred_cl_decals" } );
	if ply:IsListenServerHost() then
	CPanel:AddControl( "CheckBox", { Label = "Should bombs be easily armed?", Command = "gred_sv_easyuse" } );
	
	CPanel:AddControl( "CheckBox", { Label = "Should bombs arm when hit or dropped?", Command = "gred_sv_fragility" } );
	end
	CPanel:AddControl( "CheckBox", { Label = "Should there be sound shake?", Command = "gred_cl_sound_shake" } );

	------------------------------PLANES SETTINGS-------------------------------
	local plane = vgui.Create( "DImageButton" );
	plane:SetImage( "hud/planes_settings.png" );
	plane:SetSize( 200, 80 );
	plane.DoClick = function()
		local psnd = Sound( table.Random(psounds) );
		surface.PlaySound( psnd );
	end
	CPanel:AddPanel( plane );
	
	if ply:IsListenServerHost() then
	CPanel:AddControl( "CheckBox", { Label = "Use old rockets?", Command = "gred_sv_oldrockets" } );
	
	CPanel:AddControl( "CheckBox", { Label = "Should jets be very fast?", Command = "gred_jets_speed" } );

	CPanel:AddControl( "CheckBox", { Label = "Use alternative fire particles?", Command = "gred_sv_fire_effect" } );
	
	CPanel:AddControl( "CheckBox", { Label = "Use multiple fire particles?", Command = "gred_sv_multiple_fire_effects" } );
	
	CPanel:AddControl( "CheckBox", { Label = "Use custom health system?", Command = "gred_sv_enablehealth" } );
	
	CPanel:AddControl( "CheckBox", { Label = "Use health per engine sysetm?", Command = "gred_sv_enableenginehealth" } );
	
	CPanel:NumSlider( "Default engine health", "gred_sv_healthslider", 1, 1000, 0 );
	
	------------------------------BULLETS SETTINGS-------------------------------
	
	CPanel:AddControl( "CheckBox", { Label = "Use an alternative muzzleflash?", Command = "gred_sv_altmuzzleeffect" } );
		
	CPanel:AddControl( "CheckBox", { Label = "Should 12mm MGs have a blast radius? (Kills tanks!)", Command = "gred_sv_12mm_he_impact" } );
		
	CPanel:AddControl( "CheckBox", { Label = "Should 7mm MGs have a blast radius? (Kills tanks!)", Command = "gred_sv_7mm_he_impact" } );
	
	CPanel:NumSlider( "Bullet damage multiplier","gred_sv_bullet_dmg",-10,10,2 );
	
	CPanel:NumSlider( "Bullet radius multiplier","gred_sv_bullet_radius",-10,10,2 );
	
	CPanel:NumSlider( "Tracer ammo apparition", "gred_sv_tracers", 0, 20, 0 );
	
	CPanel:AddControl( "CheckBox", { Label = "Use Insurgency impact effects for 7mm MGs?", Command = "gred_sv_insparticles" } );
		
	CPanel:AddControl( "CheckBox", { Label = "Disable impact effects for 7mm MGs?", Command = "gred_sv_noparticles_7mm" } );
		
	CPanel:AddControl( "CheckBox", { Label = "Disable impact effects for 12mm MGs?", Command = "gred_sv_noparticles_12mm" } );
		
	CPanel:AddControl( "CheckBox", { Label = "Disable impact effects for 20mm cannons?", Command = "gred_sv_noparticles_20mm" } );
		
	CPanel:AddControl( "CheckBox", { Label = "Disable impact effects for 30mm cannons?", Command = "gred_sv_noparticles_30mm" } );
		
	CPanel:AddControl( "CheckBox", { Label = "Disable water impact effects?", Command = "gred_sv_nowaterimpacts" } );
	end
end

hook.Add( "PopulateToolMenu", "gred_menu", function()
	spawnmenu.AddToolMenuOption( "Options", "Gredwitch's Base", "GredwitchSettings", "Settings", "", "", gredsettings )
end );

function PlayerSpawn(ply)
	ply:ChatPrint("[Gredwitch's Base] Thank you for using Gredwitch's addons!")
	ply:ChatPrint("[Gredwitch's Base] Current version is : 08072018")
end
hook.Add( "PlayerInitialSpawn", "gred_cl_chatprint_version",PlayerSpawn)