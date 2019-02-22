if SERVER then 
	AddCSLuaFile() 
	resource.AddWorkshop(1131455085) -- Base addon
	local utilAddNetworkString = util.AddNetworkString
	utilAddNetworkString("gred_net_sound_lowsh")
	utilAddNetworkString("gred_net_message_ply")
	utilAddNetworkString("gred_net_bombs_decals")
	utilAddNetworkString("gred_net_nw_var")
end

-- Adding particles
local gameAddParticles = game.AddParticles
local PrecacheParticleSystem = PrecacheParticleSystem
local gameAddDecal = game.AddDecal
local GRED_SVAR = { FCVAR_REPLICATED, FCVAR_ARCHIVE, FCVAR_SERVER_CAN_EXECUTE, FCVAR_NOTIFY }
local CreateConVar = CreateConVar
local CreateClientConVar = CreateClientConVar
local tableinsert = table.insert

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
CreateConVar("gred_sv_lfs_healthmultiplier"		,  "1"  , GRED_SVAR)
CreateConVar("gred_sv_lfs_healthmultiplier_all"	,  "1"  , GRED_SVAR)
CreateConVar("gred_sv_lfs_normal_bullets"		,  "1"  , GRED_SVAR)
CreateConVar("gred_sv_wac_override"				,  "1"  , GRED_SVAR)

gred = gred or {}
gred.Calibre = {}
tableinsert(gred.Calibre,"wac_base_7mm")
tableinsert(gred.Calibre,"wac_base_12mm")
tableinsert(gred.Calibre,"wac_base_20mm")
tableinsert(gred.Calibre,"wac_base_30mm")
tableinsert(gred.Calibre,"wac_base_40mm")

-- if true then
gameAddParticles( "particles/doi_explosion_fx.pcf")
gameAddParticles( "particles/doi_explosion_fx_b.pcf")
gameAddParticles( "particles/doi_explosion_fx_c.pcf")
gameAddParticles( "particles/doi_explosion_fx_grenade.pcf")
gameAddParticles( "particles/doi_explosion_fx_new.pcf")
gameAddParticles( "particles/doi_impact_fx.pcf" )
gameAddParticles( "particles/doi_weapon_fx.pcf" )

gameAddParticles( "particles/gb_water.pcf")
gameAddParticles( "particles/gb5_100lb.pcf")
gameAddParticles( "particles/gb5_500lb.pcf")
gameAddParticles( "particles/gb5_1000lb.pcf")
gameAddParticles( "particles/gb5_jdam.pcf")
gameAddParticles( "particles/gb5_large_explosion.pcf")
gameAddParticles( "particles/gb5_napalm.pcf")
gameAddParticles( "particles/gb5_light_bomb.pcf")
gameAddParticles( "particles/gb5_high_explosive_2.pcf")
gameAddParticles( "particles/gb5_high_explosive.pcf")
gameAddParticles( "particles/gb5_fireboom.pcf")
gameAddParticles( "particles/neuro_tank_ap.pcf")

gameAddParticles( "particles/ins_rockettrail.pcf")
gameAddParticles( "particles/ammo_cache_ins.pcf")
gameAddParticles( "particles/doi_rockettrail.pcf")
gameAddParticles( "particles/mnb_flamethrower.pcf")
gameAddParticles( "particles/impact_fx_ins.pcf" )
gameAddParticles( "particles/environment_fx.pcf")
gameAddParticles( "particles/water_impact.pcf")
gameAddParticles( "particles/explosion_fx_ins.pcf")
gameAddParticles( "particles/weapon_fx_tracers.pcf" )
gameAddParticles( "particles/weapon_fx_ins.pcf" )

gameAddParticles( "particles/gred_particles.pcf" )
gameAddParticles( "particles/fire_01.pcf" )
gameAddParticles( "particles/doi_explosions_smoke.pcf" )
gameAddParticles( "particles/explosion_fx_ins_b.pcf" )
gameAddParticles( "particles/ins_smokegrenade.pcf" )
gameAddParticles( "particles/ww1_gas.pcf" )

-- Precaching main particles
gred.Particles = {}
tableinsert(gred.Particles,"gred_20mm")
tableinsert(gred.Particles,"gred_20mm_airburst")
tableinsert(gred.Particles,"gred_40mm")
tableinsert(gred.Particles,"gred_40mm_airburst")
tableinsert(gred.Particles,"30cal_impact")
tableinsert(gred.Particles,"fire_large_01")
tableinsert(gred.Particles,"30cal_impact")
tableinsert(gred.Particles,"doi_gunrun_impact")
tableinsert(gred.Particles,"doi_artillery_explosion")
tableinsert(gred.Particles,"doi_stuka_explosion")
tableinsert(gred.Particles,"gred_mortar_explosion")
tableinsert(gred.Particles,"gred_50mm")
tableinsert(gred.Particles,"ins_rpg_explosion")
tableinsert(gred.Particles,"ins_water_explosion")
tableinsert(gred.Particles,"fireboom_explosion_midair")
tableinsert(gred.Particles,"doi_petrol_explosion")

tableinsert(gred.Particles,"doi_impact_water")
tableinsert(gred.Particles,"impact_water")
tableinsert(gred.Particles,"water_small")
tableinsert(gred.Particles,"water_medium")
tableinsert(gred.Particles,"water_huge")

tableinsert(gred.Particles,"muzzleflash_sparks_variant_6")
tableinsert(gred.Particles,"muzzleflash_1p_glow")
tableinsert(gred.Particles,"muzzleflash_m590_1p_core")
tableinsert(gred.Particles,"muzzleflash_smoke_small_variant_1")
for i = 0,1 do
	if i == 1 then pcfD = "" else pcfD = "doi_" end
	tableinsert(gred.Particles,""..pcfD.."impact_concrete")
	tableinsert(gred.Particles,""..pcfD.."impact_dirt")
	tableinsert(gred.Particles,""..pcfD.."impact_glass")
	tableinsert(gred.Particles,""..pcfD.."impact_metal")
	tableinsert(gred.Particles,""..pcfD.."impact_sand")
	tableinsert(gred.Particles,""..pcfD.."impact_snow")
	tableinsert(gred.Particles,""..pcfD.."impact_leaves")
	tableinsert(gred.Particles,""..pcfD.."impact_wood")
	tableinsert(gred.Particles,""..pcfD.."impact_grass")
	tableinsert(gred.Particles,""..pcfD.."impact_tile")
	tableinsert(gred.Particles,""..pcfD.."impact_plastic")
	tableinsert(gred.Particles,""..pcfD.."impact_rock")
	tableinsert(gred.Particles,""..pcfD.."impact_gravel")
	tableinsert(gred.Particles,""..pcfD.."impact_mud")
	tableinsert(gred.Particles,""..pcfD.."impact_fruit")
	tableinsert(gred.Particles,""..pcfD.."impact_asphalt")
	tableinsert(gred.Particles,""..pcfD.."impact_cardboard")
	tableinsert(gred.Particles,""..pcfD.."impact_rubber")
	tableinsert(gred.Particles,""..pcfD.."impact_carpet")
	tableinsert(gred.Particles,""..pcfD.."impact_brick")
	tableinsert(gred.Particles,""..pcfD.."impact_leaves")
	tableinsert(gred.Particles,""..pcfD.."impact_paper")
	tableinsert(gred.Particles,""..pcfD.."impact_computer")
end

tableinsert(gred.Particles,"high_explosive_main_2")
tableinsert(gred.Particles,"high_explosive_air_2")
tableinsert(gred.Particles,"water_torpedo")
tableinsert(gred.Particles,"high_explosive_air")
tableinsert(gred.Particles,"napalm_explosion")
tableinsert(gred.Particles,"napalm_explosion_midair")
tableinsert(gred.Particles,"cloudmaker_ground")
tableinsert(gred.Particles,"1000lb_explosion")
tableinsert(gred.Particles,"500lb_air")
tableinsert(gred.Particles,"100lb_air")
tableinsert(gred.Particles,"500lb_ground")
tableinsert(gred.Particles,"rockettrail")
tableinsert(gred.Particles,"grenadetrail")
tableinsert(gred.Particles,"weapon_tracers_smoke")
tableinsert(gred.Particles,"gred_ap_impact")
tableinsert(gred.Particles,"doi_mortar_explosion")
tableinsert(gred.Particles,"doi_wparty_explosion")
tableinsert(gred.Particles,"doi_smoke_artillery")
tableinsert(gred.Particles,"doi_ceilingDust_large")
tableinsert(gred.Particles,"m203_smokegrenade")
tableinsert(gred.Particles,"doi_GASarty_explosion")
tableinsert(gred.Particles,"doi_compb_explosion")
tableinsert(gred.Particles,"doi_wpgrenade_explosion")
tableinsert(gred.Particles,"ins_c4_explosion")
tableinsert(gred.Particles,"doi_artillery_explosion_OLD")
tableinsert(gred.Particles,"gred_highcal_rocket_explosion")

tableinsert(gred.Particles,"muzzleflash_bar_3p")
tableinsert(gred.Particles,"muzzleflash_garand_3p")
tableinsert(gred.Particles,"muzzleflash_mg42_3p")
tableinsert(gred.Particles,"ins_weapon_at4_frontblast")
tableinsert(gred.Particles,"ins_weapon_rpg_dust")
tableinsert(gred.Particles,"gred_arti_muzzle_blast")
tableinsert(gred.Particles,"gred_mortar_explosion_smoke_ground")
tableinsert(gred.Particles,"weapon_muzzle_smoke")
tableinsert(gred.Particles,"ins_ammo_explosionOLD")
tableinsert(gred.Particles,"gred_ap_impact")
tableinsert(gred.Particles,"AP_impact_wall")
tableinsert(gred.Particles,"ins_m203_explosion")
for k,v in pairs(gred.Particles) do PrecacheParticleSystem(v) end


gameAddDecal( "scorch_small",		"decals/scorch_small" );
gameAddDecal( "scorch_medium",		"decals/scorch_medium" );
gameAddDecal( "scorch_big",			"decals/scorch_big" );
gameAddDecal( "scorch_huge",		"decals/scorch_huge" );
gameAddDecal( "scorch_gigantic",	"decals/scorch_gigantic" );
gameAddDecal( "scorch_x10",			"decals/scorch_x10" );


local filecount = 0
local foldercount = 0
local utilPrecacheModel = util.PrecacheModel
local precache = function( dir, flst ) -- .mdl file list precahcer
	for _, _f in ipairs( flst ) do
		util.PrecacheModel( dir.."/".._f )
		filecount = filecount + 1
	end
end

findDir = function( parent, direcotry, foot ) -- internal shit
	local flst, a = file.Find( parent.."/"..direcotry.."/"..foot, "GAME" )
	local b, dirs = file.Find( parent.."/"..direcotry.."/*", "GAME" )
	for k,v in ipairs(dirs) do
		findDir(parent.."/"..direcotry,v,foot)
		foldercount = foldercount + 1
	end
	precache( parent.."/"..direcotry, flst )
end

findDir( "models", "gredwitch", "*.mdl" )

print("[GREDWITCH'S BASE] Precached "..filecount.." files in "..foldercount.." folders.")

-- end

gred.AddonList = gred.AddonList or {}
tableinsert(gred.AddonList,1582297878) -- Materials

if CLIENT then
	
	net.Receive ("gred_net_message_ply",function()
		local ply = net.ReadEntity()
		local msg = net.ReadString()
		ply:PrintMessage(HUD_PRINTTALK,msg)
		-- ply:ChatPrint(msg)
	end)

	net.Receive("gred_net_bombs_decals",function()
		if GetConVar("gred_cl_decals"):GetInt() <= 0 then return end
		local decal = net.ReadString()
		local start = net.ReadVector()
		local hitpos = net.ReadVector()
		util.Decal(decal,start,hitpos)
	end)
	
	net.Receive("gred_net_sound_lowsh",function(len,pl)
		local sound = net.ReadString()
		LocalPlayer():GetViewEntity():EmitSound(sound)
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
	CreateClientConVar("gred_cl_enable_popups"	 	, "1" , true,false)
	CreateClientConVar("gred_cl_firstload"			, "1" , true,false)
	
	
	-- Adding the spawnmenu options
	
	local notdedicated = !game.IsDedicated()

	local function gred_settings_bullets(CPanel)
		CPanel:ClearControls()
		
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

	local function gred_settings_wac(CPanel)
		CPanel:ClearControls()
		
		local psounds={}
		psounds[1]="extras/american/outgoingstraferun1.ogg"
		psounds[2]="extras/american/outgoingstraferun2.ogg"
		psounds[3]="extras/american/outgoingstraferun3.ogg"
		psounds[4]="extras/american/outgoingstraferun4.ogg"
		psounds[5]="extras/american/outgoingstraferun5.ogg"
		Created = true;
		
		local plane = vgui.Create( "DImageButton" );
		plane:SetImage( "hud/planes_settings.png" );
		plane:SetSize( 200, 80 );
		plane.DoClick = function()
			local psnd = Sound( table.Random(psounds) );
			surface.PlaySound( psnd );
		end
		CPanel:AddPanel( plane );
		if notdedicated then
		
			CPanel:AddControl( "CheckBox", { Label = "Override the WAC base?", Command = "gred_sv_wac_override" } );
			
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
		
	end

	local function gred_settings_misc(CPanel)
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
		
		CPanel:AddControl( "CheckBox", { Label = "Use an alternative muzzleflash?", Command = "gred_cl_altmuzzleeffect" } );
		
		CPanel:AddControl( "CheckBox", { Label = "Enable pop ups about missing content?", Command = "gred_cl_enable_popups" } );
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
		if notdedicated then
		
			CPanel:NumSlider( "Aircraft health multiplier", "gred_sv_lfs_healthmultiplier", 1, 10, 2 );
			
			CPanel:AddControl( "CheckBox", { Label = "Should the health multiplier only apply to Gredwitch's LFS aircrafts?", Command = "gred_sv_lfs_healthmultiplier_all" } );
			
			CPanel:AddControl( "CheckBox", { Label = "Should bullets have their default damage? (OP)", Command = "gred_sv_lfs_normal_bullets" } );
			
		end
	end

	local function gred_settings_bombs(CPanel)
		CPanel:ClearControls()
		local sound = "extras/terrorist/allahu.mp3"
		
		Created = true;
		
		local logo = vgui.Create( "DImageButton" );
		logo:SetImage( "hud/bombs_settings.png" );
		logo:SetSize( 250, 250 );
		logo.DoClick = function()
			local snd = Sound( sound );
			surface.PlaySound( snd );
		end
		CPanel:AddPanel( logo );
		
		CPanel:AddControl( "CheckBox", { Label = "Should there be sound shake?", Command = "gred_cl_sound_shake" } );
		if notdedicated then
			CPanel:AddControl( "CheckBox", { Label = "Should all bombs unweld and unfreeze?", Command = "gred_sv_shockwave_unfreeze" } );
			
			CPanel:NumSlider( "Forcefield Max Range", "gred_sv_maxforcefield_range", 10, 10000, 0 );
			
			CPanel:NumSlider( "Sound muffling divider", "gred_sv_soundspeed_divider", 1, 3, 0 );
			
			CPanel:AddControl( "CheckBox", { Label = "Should bombs be easily armed?", Command = "gred_sv_easyuse" } );
			
			CPanel:AddControl( "CheckBox", { Label = "Should explosives be spawnable?", Command = "gred_sv_spawnable_bombs" } );
			
			CPanel:AddControl( "CheckBox", { Label = "Should bombs arm when hit or dropped?", Command = "gred_sv_fragility" } );
		end
			
		CPanel:AddControl( "CheckBox", { Label = "Should bombs leave decals behind?", Command = "gred_cl_decals" } );
		
	end
	
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
									"Bombs",
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
	end );

end

hook.Add("OnEntityCreated","gred_ent_override",function(ent)
	timer.Simple(0,function()
		if ent.LFS then
			if ent.Author == "Gredwitch" or GetConVar("gred_sv_lfs_healthmultiplier_all"):GetInt() == 1 then
				ent.MaxHealth = ent.MaxHealth * GetConVar("gred_sv_lfs_healthmultiplier"):GetFloat()
				ent.OldSetupDataTables = ent.SetupDataTables
				ent.SetupDataTables = function()
					ent:OldSetupDataTables()
					ent:NetworkVar( "Float",6, "HP", { KeyName = "health", Edit = { type = "Float", order = 2,min = 0, max = ent.MaxHealth, category = "Misc"} } )
				end
				ent:SetupDataTables()
				
				ent:SetHP(ent.MaxHealth)
			end
			
			
		-----------------------------------
		
		elseif ent.isWacAircraft then
			if GetConVar("gred_sv_wac_override"):GetInt() == 1 then
			-- if ent.Base == "wac_hc_base" then
				
				ent.Engines = 1
				ent.Sounds.Radio = ""
				ent.Sounds.crashsnd = ""
				ent.Sounds.bipsnd = "crash/bip_loop.wav"
				
				-- SHARED.LUA
				ent.addSounds = function(self)
					self.sounds = {}
					self.Sounds.crashsnd = "crash/crash_"..math.random(1,10)..".ogg" --ADDED BY THE GREDWITCH
					for name, value in pairs(self.Sounds) do
						if name != "BaseClass" then
							sound.Add({
								name = "wac."..self.ClassName.."."..name,
								channel = CHAN_STATIC,
								soundlevel = (name == "Blades" or name == "Engine") and 200 or 100,
								sound = value
							})
							self.sounds[name] = CreateSound(self, "wac."..self.ClassName.."."..name)
							if name == "Blades" then
								self.sounds[name]:SetSoundLevel(120)
							elseif name == "Engine" then
								self.sounds[name]:SetSoundLevel(110)
							elseif name == "Radio" and value != "" then --ADDED BY THE GREDWITCH (start)
								self.sounds[name]:SetSoundLevel(60)
							elseif name == "crashsnd" then
								self.sounds[name]:SetSoundLevel(120)
							elseif name == "bipsnd" then
								self.sounds[name]:SetSoundLevel(80) --ADDED BY THE GREDWITCH (end)
							end
						end
					end
				end
				
				if SERVER then -- INIT.LUA
					ent.addStuff = function(self)
						local HealthsliderVAR = GetConVar("gred_sv_healthslider"):GetInt()
						local HealthEnable = GetConVar("gred_sv_enablehealth"):GetInt()
						local EngineHealthEnable = GetConVar("gred_sv_enableenginehealth"):GetInt()
						local Healthslider = 100
						if HealthEnable == 1 and EngineHealthEnable == 1 then
							
							if HealthsliderVAR == nil or HealthsliderVAR <= 0 then 
								Healthslider = 100
							else 
								Healthslider = HealthsliderVAR
							end
							
							self.engineHealth = self.Engines*Healthslider
							self.EngineHealth = self.Engines*Healthslider
							
						elseif HealthEnable == 1 and EngineHealthEnable == 0 then
						
							if HealthsliderVAR == nil or HealthsliderVAR <= 0 then 
								Healthslider = 100
							else 
								Healthslider = HealthsliderVAR
							end
							
							self.Engines = 1
							self.engineHealth = Healthslider
							self.EngineHealth = Healthslider
						end
					end
					
					ent.GredExplode = function(self,speed,pos)
						if self.blewup then return end
						self.blewup = true
						local lasta=(self.LastDamageTaken<CurTime()+6 and self.LastAttacker or self.Entity)
						for k, p in pairs(self.passengers) do
							if p and p:IsValid() then
								p:TakeDamage(speed,lasta,self.Entity)
							end
						end
						self:TakeDamage(self.engineHealth)
						if GetConVar("gred_sv_wac_explosion"):GetInt() <= 0 then return end
						local radius = self:BoundingRadius()
						local hitang = Angle(0,self:GetAngles().y+90,0)
						local ent = ents.Create("shockwave_sound_lowsh")
						ent:SetPos(pos) 
						ent:Spawn()
						ent:Activate()
						ent:SetVar("GBOWNER", self)
						ent:SetVar("MAX_RANGE",50000)
						ent:SetVar("NOFARSOUND",0)
						ent:SetVar("SHOCKWAVE_INCREMENT",200)
						
						ent:SetVar("DELAY",0.01)
						ent:SetVar("SOUNDCLOSE","explosions/fuel_depot_explode_close.wav")
						ent:SetVar("SOUND","explosions/fuel_depot_explode_dist.wav")
						ent:SetVar("SOUNDFAR","explosions/fuel_depot_explode_far.wav")
						ent:SetVar("Shocktime", 0)
						
						local ent = ents.Create("shockwave_ent")
						ent:SetPos( pos ) 
						ent:Spawn()
						ent:Activate()
						ent:SetVar("DEFAULT_PHYSFORCE", self.DEFAULT_PHYSFORCE)
						ent:SetVar("DEFAULT_PHYSFORCE_PLYAIR", self.DEFAULT_PHYSFORCE_PLYAIR)
						ent:SetVar("DEFAULT_PHYSFORCE_PLYGROUND", self.DEFAULT_PHYSFORCE_PLYGROUND)
						ent:SetVar("GBOWNER", self.GBOWNER)
						ent:SetVar("SHOCKWAVEDAMAGE",1000)
						ent:SetVar("SHOCKWAVE_INCREMENT",50)
						ent:SetVar("DELAY",0.01)
						ent.trace=self.TraceLength
						ent.decal=self.Decal
						self:Remove()
						-- local effect = "doi_petrol_explosion"
						if radius <= 300 then
							local effectdata = EffectData()
							effectdata:SetOrigin(pos)
							effectdata:SetAngles(hitang)
							effectdata:SetFlags(1)
							effectdata:SetSurfaceProp(1)
							util.Effect("gred_particle_wac_explosion",effectdata)
							ent:SetVar("MAX_RANGE",600)
						elseif radius <= 500 then
							local effectdata = EffectData()
							effectdata:SetOrigin(pos)
							effectdata:SetAngles(hitang)
							effectdata:SetFlags(5)
							effectdata:SetSurfaceProp(1)
							util.Effect("gred_particle_wac_explosion",effectdata)
							
							ent:SetVar("MAX_RANGE",800)
						elseif radius <= 2000 then
							local effectdata = EffectData()
							effectdata:SetOrigin(pos)
							effectdata:SetAngles(hitang)
							effectdata:SetFlags(9)
							effectdata:SetSurfaceProp(1)
							util.Effect("gred_particle_wac_explosion",effectdata)
							ent:SetVar("MAX_RANGE",1000)
						end
					end
					
					ent.PhysicsCollide = function(self,cdat, phys)
						timer.Simple(0,function()
							if wac.aircraft.cvars.nodamage:GetInt() == 1 then
								return
							end
							if cdat.DeltaTime > 0.5 then
								local mass = cdat.HitObject:GetMass()
								if cdat.HitEntity:GetClass() == "worldspawn" then
									mass = 5000
								end
								local dmg = (cdat.Speed*cdat.Speed*math.Clamp(mass, 0, 5000))/10000000
								if !dmg or dmg < 1 then return end
								self:TakeDamage(dmg*15)
								if dmg > 2 then
									self.Entity:EmitSound("vehicles/v8/vehicle_impact_heavy"..math.random(1,4)..".wav")
									local lasta=(self.LastDamageTaken<CurTime()+6 and self.LastAttacker or self.Entity)
									for k, p in pairs(self.passengers) do
										if p and p:IsValid() then
											p:TakeDamage(dmg/5, lasta, self.Entity)
										end
									end
								end
							end
							-- ADDED BY THE GREDWITCH
							if (cdat.Speed > 1000 and !self.ShouldRotate) 
							or (cdat.Speed > 100 and self.ShouldRotate and !cdat.HitEntity.isWacRotor) 
							and (!cdat.HitEntity:IsPlayer() and!cdat.HitEntity:IsNPC() and !string.StartWith(cdat.HitEntity:GetClass(),"vfire")) then
								self:GredExplode(cdat.speed,cdat.HitPos)
							end
						end)
					end
				
					ent.Think = function(self)
						self:base("wac_hc_base").Think(self)
						-- START ADDED BY THE GREDWITCH
						if self.sounds.Radio then
							if self.active and GetConVar("gred_sv_wac_radio"):GetInt() == 1 then
								self.sounds.Radio:Play()
							else
								self.sounds.Radio:Stop()
							end
						end
						if self:WaterLevel() >= 2 and GetConVar("gred_sv_wac_explosion_water"):GetInt() >= 1 and !self.hascrashed then
							local pos = self:GetPos()
							local trdat   = {}
							trdat.start   = pos+Vector(0,0,4000)
							trdat.endpos  = pos
							trdat.filter  = self
							trdat.mask    = MASK_WATER + CONTENTS_TRANSLUCENT
							
							local tr = util.TraceLine(trdat)
							
							if tr.Hit then
								local ang = Angle(-90,0,0)
								local radius = self:BoundingRadius()
								local water = "ins_water_explosion"
								if radius <= 600 then
									local effectdata = EffectData()
									effectdata:SetOrigin(pos)
									effectdata:SetAngles(ang)
									effectdata:SetSurfaceProp(2)
									effectdata:SetFlags(1)
									util.Effect("gred_particle_wac_explosion",effectdata)
								else
									local effectdata = EffectData()
									effectdata:SetOrigin(pos)
									effectdata:SetAngles(ang)
									effectdata:SetSurfaceProp(2)
									effectdata:SetFlags(2)
									util.Effect("gred_particle_wac_explosion",effectdata)
								end
								local ent = ents.Create("shockwave_sound_lowsh")
								ent:SetPos(tr.HitPos) 
								ent:Spawn()
								ent:Activate()
								ent:SetVar("GBOWNER", self.Owner)
								ent:SetVar("MAX_RANGE",radius*self.Weight)
								ent:SetVar("NOFARSOUND",0)
								ent:SetVar("SHOCKWAVE_INCREMENT",200)
								ent:SetVar("DELAY",0.01)
								ent:SetVar("SOUNDCLOSE", "/explosions/aircraft_water_close.wav")
								ent:SetVar("SOUND", "/explosions/aircraft_water_dist.wav")
								ent:SetVar("SOUNDFAR", "/explosions/aircraft_water_far.wav")
								ent:SetVar("Shocktime", 0)
								local lasta=(self.LastDamageTaken<CurTime()+6 and self.LastAttacker or self.Entity)
								for k, p in pairs(self.passengers) do
									if p and p:IsValid() then
										p:TakeDamage(p:Health() + 20, lasta, self.Entity)
									end
								end
								self.hascrashed = true
								self:Remove()
							end
						end
						
						if self.ShouldRotate and self.backRotor and self.topRotor and self.Base != "wac_pl_base" and !self.disabled
						and self.rotorRpm > 0.2 and GetConVar("gred_sv_wac_heli_spin"):GetInt() >= 1 then
							local p = self:GetPhysicsObject()
							if p and IsValid(p) then
								if !self.sounds.crashsnd:IsPlaying() then
									self.sounds.crashsnd:Play()
								end
								self.sounds.bipsnd:Play()
								local m = p:GetMass()
								local v = p:GetAngleVelocity()
								local v1 = p:GetVelocity()
								-- if p:GetVelocity().z > -300 then
									-- p:AddVelocity(Vector(0,0,2*(m/1200)*-(15*self.rotorRpm)))
								-- end
								p:SetVelocity(Vector(v1.x,v1.y,-300))--2*(m/1200)*-(15*self.rotorRpm)))
								m = m/200
								if v.z < 150 then
									p:AddAngleVelocity(Vector(0,0,3*m))
								end
								if v.y > -50 then
									p:AddAngleVelocity(Vector(0,-10-m,0))
								end
								self:SetHover(true)
								self.controls.throttle = 0
								for k,v in pairs (self.wheels) do
									if !v.ph then
										v.ph = function(ent,data) 
											v.GredHitGround = true	
										end
										v:AddCallback("PhysicsCollide",v.ph)
									end
									if v.GredHitGround then
										self:GredExplode(500,self:GetPos())
									end
								end
							end
						else
							if !self.topRotor and self.sounds.crashsnd then
								self.sounds.crashsnd:Stop()
							end
						end
						
						-- END ADDED BY THE GREDWITCH
					end
					
					ent.GredIsOnGround = function(self,v)
						local p = v:GetPos()
						return util.QuickTrace(p,p-Vector(0,0,1)).Hit
					end
					
					ent.DamageEngine = function(self,amt)
						if wac.aircraft.cvars.nodamage:GetInt() == 1 then
							return
						end
						if self.disabled then return end
						self.engineHealth = self.engineHealth - amt

						if self.engineHealth < 80  then
							if !self.sounds.MinorAlarm:IsPlaying() then
								self.sounds.MinorAlarm:Play()
							end
							if !self.Smoke and self.engineHealth>0 then
								self.Smoke = self:CreateSmoke()
							end
							if self.engineHealth < 50 then
								if !self.sounds.LowHealth:IsPlaying() then
									self.sounds.LowHealth:Play()
								end
								f = math.random(0,GetConVar("gred_sv_wac_heli_spin_chance"):GetInt())
								if !self.ShouldRotate and f == 0 then
									self.OldGredUP = self:GetUp()
									self.ShouldRotate = true
								end
								
								
								if self.engineHealth < 20 and !self.EngineFire then
									local fire = ents.Create("env_fire")
									fire:SetPos(self:LocalToWorld(self.FirePos))
									fire:Spawn()
									fire:SetParent(self.Entity)
									if GetConVar("gred_sv_fire_effect"):GetInt() >= 1 then
										ParticleEffectAttach("fire_large_01", 1, fire, 0)
										if (GetConVar("gred_sv_multiple_fire_effects"):GetInt() >= 1) then
											if self.OtherRotors then 
												for i = 1,3 do
													if not self.OtherRotors[i] then return end
													ParticleEffectAttach("fire_large_01", 1, self.OtherRotors[i], 0)
												end
											end
											if self.OtherRotor then ParticleEffectAttach("fire_large_01", 1, self.OtherRotor, 0) end
											if self.rotor2 then ParticleEffectAttach("fire_large_01", 1, self.rotor2, 0) end
											if self.topRotor2 then ParticleEffectAttach("fire_large_01", 1, self.topRotor2, 0) end
										end
									elseif GetConVar("gred_sv_fire_effect"):GetInt() <= 0 then
										if GetConVar("gred_sv_multiple_fire_effects"):GetInt() >= 1 then
											if self.OtherRotors then
												for i = 1,3 do
													if not self.OtherRotors[i] then return end
													local fire = ents.Create("env_fire_trail")
													fire:SetPos(self:LocalToWorld(self.OtherRotorPos[i]))
													fire:Spawn()
													fire:SetParent(self.Entity)
												end
											else
												if self.OtherRotor then local pos = self:LocalToWorld(self.OtherRotorPos) end
												if self.rotor2 then local pos = self:LocalToWorld(self.rotorPos2) end
												if self.topRotor2 then local pos = self:LocalToWorld(self.TopRotor2.pos) end
												if pos then
													local fire = ents.Create("env_fire_trail")
													fire:SetPos(pos)
													fire:Spawn()
													fire:SetParent(self.Entity)
												end
											end
										end
									end
									self.sounds.LowHealth:Play()
									self.EngineFire = fire
								end
								if self.engineHealth < 10 and (!self.ShouldRotate or !self.blewup) then 
									self.engineDead = true 
									self:setEngine(false) 
								end

								if self.engineHealth < 0 and !self.disabled and (!self.ShouldRotate or !self.blewup) then
									self.disabled = true
									self.engineRpm = 0
									self.rotorRpm = 0
									local lasta=(self.LastDamageTaken<CurTime()+6 and self.LastAttacker or self.Entity)
									for k, p in pairs(self.passengers) do
										if p and p:IsValid() then
											p:TakeDamage(p:Health() + 20, lasta, self.Entity)
										end
									end

									for k,v in pairs(self.seats) do
										v:Remove()
									end
									self.passengers={}
									self:StopAllSounds()

									self:setVar("rotorRpm", 0)
									self:setVar("engineRpm", 0)
									self:setVar("up", 0)

									self.IgnoreDamage = false
									--[[ this affects the base class
										for name, vec in pairs(self.Aerodynamics.Rotation) do
											vec = VectorRand()*100
										end
										for name, vec in pairs(self.Aerodynamics.Lift) do
											vec = VectorRand()
										end
										self.Aerodynamics.Rail = Vector(0.5, 0.5, 0.5)
									]]
									local effectdata = EffectData()
									effectdata:SetStart(self.Entity:GetPos())
									effectdata:SetOrigin(self.Entity:GetPos())
									effectdata:SetScale(1)
									util.Effect("Explosion", effectdata)
									util.Effect("HelicopterMegaBomb", effectdata)
									util.Effect("cball_explode", effectdata)
									util.BlastDamage(self.Entity, self.Entity, self.Entity:GetPos(), 300, 300)
									self:setEngine(false)
									if self.Smoke then
										self.Smoke:Remove()
										self.Smoke=nil
									end
									if self.RotorWash then
										self.RotorWash:Remove()
										self.RotorWash=nil
									end
									if self:WaterLevel() >= 1 and GetConVar("gred_sv_wac_explosion_water"):GetInt() >= 1 then
										local pos = self:GetPos()
										local trdat   = {}
										trdat.start   = pos+Vector(0,0,4000)
										trdat.endpos  = pos
										trdat.filter  = self
										trdat.mask    = MASK_WATER + CONTENTS_TRANSLUCENT
											 
										local tr = util.TraceLine(trdat)
							
										if tr.Hit then
											local ang = Angle(-90,0,0)
											local radius = self:BoundingRadius()
											local water = "ins_water_explosion"
											if radius <= 600 then
												local effectdata = EffectData()
												effectdata:SetOrigin(tr.HitPos)
												effectdata:SetAngles(ang)
												effectdata:SetSurfaceProp(2)
												effectdata:SetFlags(1)
												util.Effect("gred_particle_wac_explosion",effectdata)
											else
												local effectdata = EffectData()
												effectdata:SetOrigin(tr.HitPos)
												effectdata:SetAngles(ang)
												effectdata:SetSurfaceProp(2)
												effectdata:SetFlags(2)
												util.Effect("gred_particle_wac_explosion",effectdata)
											end
											self.hascrashed = true
											self:Remove()
										end
									end
									--[[self:SetNWBool("locked", true)
									timer.Simple( 0.1, function() self:Remove() end)--]]
								end
							end
						end
						if self.Smoke then
							local rcol = math.Clamp(self.engineHealth*3.4, 0, 170)
							self.Smoke:SetKeyValue("rendercolor", rcol.." "..rcol.." "..rcol)
						end
						self:SetNWFloat("health", self.engineHealth)
					end
				end
				
				if CLIENT then -- CL_INIT.LUA
					ent.receiveInput = function(self,name, value, seat)
						if name == "FreeView" then
							local player = LocalPlayer()
							if value > 0.5 then
								-- ADDED BY GREDWITCH
								if self.Camera and seat == self.Camera.seat and seat != 1 then
									if !player:GetVehicle().useCamerazoom then player:GetVehicle().useCamerazoom = 0 end
									player:GetVehicle().useCamerazoom = player:GetVehicle().useCamerazoom + 1
									if player:GetVehicle().useCamerazoom > 3 then player:GetVehicle().useCamerazoom = 0 end
								else -- END
									player.wac.viewFree = true
								end -- ADDED BY GREDWITCH
							else
								if self.Camera and seat == self.Camera.seat and seat != 1 then
								else
									player.wac.viewFree = false
									player.wac_air_resetview = true
								end
							end
						elseif name == "Camera" then
							local player = LocalPlayer()
							if value > 0.5 then
								player:GetVehicle().useCamera = !player:GetVehicle().useCamera
								if self.Camera and seat == self.Camera.seat then player:GetVehicle().useCamerazoom = 0 end -- ADDED BY GREDWITCH
							end
						end
					end
					
					ent.viewCalcCamera = function(self,k, p, view)
						view.origin = self.camera:LocalToWorld(self.Camera.viewPos)
						view.angles = self.camera:GetAngles()
						
						-- ADDED BY GREDWITCH
						local zoom = p:GetVehicle().useCamerazoom
						if zoom then
							if zoom >= 1 then
								view.fov = view.fov - zoom*20
							end
						end	
						for k, t in pairs(self.Seats) do
							if k != "BaseClass" and self:getWeapon(k) then
								if self:getWeapon(k).HasLastShot then
									if self:getWeapon(k):GetIsShooting() then
										local ang = view.angles
										view.angles = view.angles + Angle(0,0,math.random(-2,2))
										timer.Simple(0.02,function() if IsValid(self) then
											view.angles = ang
											end
										end)
									end
								end
							end
						end
						-- END
						if self.viewTarget then
							self.viewTarget.angles = p:GetAimVector():Angle() - self:GetAngles()
						end
						self.viewPos = nil
						p.wac.lagAngles = Angle(0, 0, 0)
						p.wac.lagAccel = Vector(0, 0, 0)
						p.wac.lagAccelDelta = Vector(0, 0, 0)
						return view
					end
				end
				
				ent:addSounds()
			end
		
		elseif ent.ClassName == "wac_hc_rocket" then
			ent.Initialize = function(self)
				math.randomseed(CurTime())
				self.Entity:SetModel("models/weltensturm/wac/rockets/rocket01.mdl")
				self.Entity:PhysicsInit(SOLID_VPHYSICS)
				self.Entity:SetMoveType(MOVETYPE_VPHYSICS)
				self.Entity:SetSolid(SOLID_VPHYSICS)
				self.phys = self.Entity:GetPhysicsObject()
				if (self.phys:IsValid()) then
					self.phys:SetMass(400)
					self.phys:EnableGravity(false)
					self.phys:EnableCollisions(true)
					self.phys:EnableDrag(false)
					self.phys:Wake()
				end
				self.sound = CreateSound(self.Entity, "WAC/rocket_idle.wav")
				self.matType = MAT_DIRT
				self.hitAngle = Angle(270, 0, 0)
				if self.calcTarget then
					self.Speed = 70
				else
					self.Speed = 100
				end
			end
		end
	end)
end)
