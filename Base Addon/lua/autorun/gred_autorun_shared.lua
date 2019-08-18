local util = util
local pairs = pairs
local table = table
local istable = istable
local IsInWorld = util.IsInWorld
local TraceLine = util.TraceLine
local QuickTrace = util.QuickTrace
local Effect = util.Effect
local MASK_ALL = MASK_ALL
local game = game
local gameAddParticles = game.AddParticles
local gameAddDecal = game.AddDecal
local PrecacheParticleSystem = PrecacheParticleSystem
local GRED_SVAR = { FCVAR_REPLICATED, FCVAR_ARCHIVE, FCVAR_SERVER_CAN_EXECUTE, FCVAR_NOTIFY }
local CreateConVar = CreateConVar
local CreateClientConVar = CreateClientConVar
local tableinsert = table.insert
local IsValid = IsValid
local DMG_BLAST = DMG_BLAST
local CLIENT = CLIENT

-- Adding particles
-- [[
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
CreateConVar("gred_sv_wac_override"				,  "1"  , GRED_SVAR)
CreateConVar("gred_sv_override_hab"				,  "0"  , GRED_SVAR)
CreateConVar("gred_sv_lfs_godmode"				,  "0"  , GRED_SVAR)
CreateConVar("gred_sv_lfs_infinite_ammo"		,  "0"  , GRED_SVAR)

gred = gred or {}
gred.AllNPCs = {}
gred.Calibre = {}
tableinsert(gred.Calibre,"wac_base_7mm")
tableinsert(gred.Calibre,"wac_base_12mm")
tableinsert(gred.Calibre,"wac_base_20mm")
tableinsert(gred.Calibre,"wac_base_30mm")
tableinsert(gred.Calibre,"wac_base_40mm")
gred.Mats = {
	default_silent			=	-1,
	floatingstandable		=	-1,
	no_decal				=	-1,
	
	boulder 				=	1,
	concrete				=	1,
	default					=	1,
	item					=	1,
	concrete_block			=	1,
	plaster					=	1,
	pottery					=	1,
	
	dirt					=	2,
			
	alienflesh				=	3,
	antlion					=	3,
	armorflesh				=	3,
	bloodyflesh				=	3,
	player					=	3,
	flesh					=	3,
	player_control_clip		=	3,
	zombieflesh				=	3,

	glass					=	4,
	ice						=	4,
	glassbottle				=	4,
	combine_glass			=	4,
		
	canister				=	5,
	chain					=	5,
	chainlink				=	5,
	combine_metal			=	5,
	crowbar					=	5,
	floating_metal_barrel	=	5,
	grenade					=	5,
	metal					=	5,
	metal_barrel			=	5,
	metal_bouncy			=	5,
	metal_Box				=	5,
	metal_seafloorcar		=	5,
	metalgrate				=	5,
	metalpanel				=	5,
	metalvent				=	5,
	metalvehicle			=	5,
	paintcan				=	5,
	roller					=	5,
	slipperymetal			=	5,
	solidmetal				=	5,
	strider					=	5,
	popcan					=	5,
	weapon					=	5,
		
	quicksand				=	6,
	sand					=	6,
	slipperyslime			=	6,
	antlionsand				=	6,
	
	snow					=	7,
		
	foliage					=	8,
	
	wood					=	9,
	wood_box				=	9,
	wood_crate 				=	9,
	wood_furniture			=	9,
	wood_lowDensity 		=	9,
	ladder 					=	9,
	wood_plank				=	9,
	wood_panel				=	9,
	wood_polid				=	9,
		
	grass					=	10,
	
	tile					=	11,
	ceiling_tile			=	11,
	
	plastic_barrel			=	12,
	plastic_barrel_buoyant	=	12,
	Plastic_Box				=	12,
	plastic					=	12,
	
	baserock 				=	13,
	rock					=	13,
	
	gravel					=	14,
	
	mud						=	15,
	
	watermelon				=	16,
		
	asphalt 				=	17,
	
	cardbaord 				=	18,
		
	rubber 					=	19,
	rubbertire 				=	19,
	slidingrubbertire 		=	19,
	slidingrubbertire_front =	19,
	slidingrubbertire_rear 	=	19,
	jeeptire 				=	19,
	brakingrubbertire 		=	19,
	
	carpet 					=	20,
	brakingrubbertire 		=	20,
	
	brick					=	21,
		
	foliage					=	22,
	
	paper 					=	23,
	papercup 				=	23,
		
	computer				=	24,
}

gred.Precache = function()
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
	tableinsert(gred.Particles,"ins_weapon_rpg_frontblast")
	tableinsert(gred.Particles,"gred_arti_muzzle_blast_alt")
	tableinsert(gred.Particles,"doi_wprocket_explosion")
	tableinsert(gred.Particles,"gred_tracers_red_7mm")
	tableinsert(gred.Particles,"gred_tracers_green_7mm")
	tableinsert(gred.Particles,"gred_tracers_white_7mm")
	tableinsert(gred.Particles,"gred_tracers_yellow_7mm")
	tableinsert(gred.Particles,"gred_tracers_red_12mm")
	tableinsert(gred.Particles,"gred_tracers_green_12mm")
	tableinsert(gred.Particles,"gred_tracers_white_12mm")
	tableinsert(gred.Particles,"gred_tracers_yellow_12mm")
	tableinsert(gred.Particles,"gred_tracers_red_20mm")
	tableinsert(gred.Particles,"gred_tracers_green_20mm")
	tableinsert(gred.Particles,"gred_tracers_white_20mm")
	tableinsert(gred.Particles,"gred_tracers_yellow_20mm")
	tableinsert(gred.Particles,"gred_tracers_red_30mm")
	tableinsert(gred.Particles,"gred_tracers_green_30mm")
	tableinsert(gred.Particles,"gred_tracers_white_30mm")
	tableinsert(gred.Particles,"gred_tracers_yellow_30mm")
	tableinsert(gred.Particles,"gred_tracers_red_40mm")
	tableinsert(gred.Particles,"gred_tracers_green_40mm")
	tableinsert(gred.Particles,"gred_tracers_white_40mm")
	tableinsert(gred.Particles,"gred_tracers_yellow_40mm")
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
			utilPrecacheModel( dir.."/".._f )
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
	timer.Simple(1,function()
		findDir( "models", "gredwitch", "*.mdl" )

		print("[GREDWITCH'S BASE] Precached "..filecount.." files in "..foldercount.." folders.")
	end)
end

gred.Precache()

gred.AddonList = gred.AddonList or {}
tableinsert(gred.AddonList,1582297878) -- Materials

if CLIENT then
	local ply = LocalPlayer()
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
	
	local Created

	local function gred_settings_bullets(CPanel)
		CPanel:ClearControls()
		
		-- if notdedicated then
			local this = CPanel:CheckBox("Should 12mm MGs have a blast radius? (Kills tanks!)","gred_sv_12mm_he_impact" );
			this.OnChange = function(this,val)
				val = val and 1 or 0
				gred.CheckConCommand("gred_sv_12mm_he_impact",val)
			end
					
			local this = CPanel:CheckBox("Should 7mm MGs have a blast radius? (Kills tanks!)","gred_sv_7mm_he_impact" );
			this.OnChange = function(this,val)
				val = val and 1 or 0
				gred.CheckConCommand("gred_sv_7mm_he_impact",val)
			end
			
			local this = CPanel:NumSlider( "Bullet damage multiplier","gred_sv_bullet_dmg",0,10,2 );
			this.ValueChanged = function(this,val)
				gred.CheckConCommand("gred_sv_bullet_dmg",val)
			end
			
			local this = CPanel:NumSlider( "Bullet radius multiplier","gred_sv_bullet_radius",0,10,2 );
			this.ValueChanged = function(this,val)
				gred.CheckConCommand("gred_sv_bullet_radius",val)
			end
			
			local this = CPanel:NumSlider( "Tracer ammo apparition", "gred_sv_tracers", 0, 20, 0 );
			this.ValueChanged = function(this,val)
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
			
			local this = CPanel:NumSlider( "Default engine health", "gred_sv_healthslider", 1, 1000, 0 );
			this.ValueChanged = function(this,val)
				gred.CheckConCommand("gred_sv_healthslider",val)
			end
			
			local this = CPanel:NumSlider( "Helicopter spin chance", "gred_sv_wac_heli_spin_chance", 1, 10, 0 );
			this.ValueChanged = function(this,val)
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
		
		CPanel:CheckBox("Use an alternative muzzleflash?","gred_cl_altmuzzleeffect");
		CPanel:CheckBox("Enable pop ups about missing content?","gred_cl_enable_popups");
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
		
			local this = CPanel:NumSlider( "Aircraft health multiplier", "gred_sv_lfs_healthmultiplier", 1, 10, 2 );
			this.ValueChanged = function(this,val)
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
		
		CPanel:CheckBox("Should there be sound shake?","gred_cl_sound_shake");
		
		-- if notdedicated then
			local this = CPanel:CheckBox("Should all bombs unweld and unfreeze?","gred_sv_shockwave_unfreeze");
			this.OnChange = function(this,val)
				val = val and 1 or 0
				gred.CheckConCommand("gred_sv_shockwave_unfreeze",val)
			end
			
			local this = CPanel:NumSlider( "Forcefield Max Range","gred_sv_maxforcefield_range", 10, 10000, 0 );
			this.ValueChanged = function(this,val)
				gred.CheckConCommand("gred_sv_maxforcefield_range",val)
			end
			
			local this = CPanel:NumSlider( "Sound muffling divider", "gred_sv_soundspeed_divider", 1, 3, 0 );
			this.ValueChanged = function(this,val)
				gred.CheckConCommand( "gred_sv_soundspeed_divider",val)
			end
		
			local this = CPanel:NumSlider( "Shell speed multiplier", "gred_sv_shellspeed_multiplier", 0, 3, 2 );
			this.ValueChanged = function(this,val)
				gred.CheckConCommand( "gred_sv_shellspeed_multiplier",val)
			end
			
			local this = CPanel:CheckBox("Should bombs be easily armed?","gred_sv_easyuse");
			this.OnChange = function(this,val)
				val = val and 1 or 0
				gred.CheckConCommand("gred_sv_easyuse",val)
			end
			
			local this = CPanel:CheckBox("Should explosives be spawnable?","gred_sv_spawnable_bombs");
			this.OnChange = function(this,val)
				val = val and 1 or 0
				gred.CheckConCommand("gred_sv_easyuse",val)
			end
			
			local this = CPanel:CheckBox("Should bombs arm when hit or dropped?","gred_sv_fragility");
			this.OnChange = function(this,val)
				val = val and 1 or 0
				gred.CheckConCommand("gred_sv_fragility",val)
			end
		-- end
			
		CPanel:CheckBox("Should bombs leave decals behind?","gred_cl_decals");
		
	end
	gred.CheckConCommand = function(cmd,val)
		net.Start("gred_net_checkconcommand")
			net.WriteString(cmd)
			net.WriteFloat(val)
		net.SendToServer()
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
	local function CheckForUpdates()
		local CURRENT_VERSION = ""
		local changelogs = file.Read("changelog.lua","LUA")
		for i = 1,15 do CURRENT_VERSION = CURRENT_VERSION..changelogs[i] end
		
		local GITHUB_VERSION = "" 
		local GitHub = http.Fetch("https://raw.githubusercontent.com/Gredwitch/gredwitch-base/master/Base%20Addon/lua/changelog.lua",function(body)
			if !body then return end
			for i = 1,15 do GITHUB_VERSION = GITHUB_VERSION..body[i] end
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
	if jit.arch != "x86" then
		local DFrame = vgui.Create("DFrame")
		DFrame:SetSize(ScrW()*0.9,ScrH()*0.9)
		DFrame:SetTitle("YOU ARE USING THE 64 BITS BRANCH WHICH IS BROKEN")
		DFrame:Center()
		DFrame:MakePopup()
		
		local DHTML = vgui.Create("DHTML",DFrame)
		DHTML:Dock(FILL)
		DHTML:OpenURL("https://steamcommunity.com/workshop/filedetails/discussion/1131455085/1640915206496660582/")
	end
	
	-- HAB PhysBullet compatibility
	timer.Simple(0.1,function()
		if hab then
			local MODULE = hab.Module.PhysBullet
			if MODULE then
				hab.hook("PhysBulletOnBulletCreateEffects_","gred_hab_physbullet_particle",function(ent,index,bullet,mode)
					local isGred = ent.ClassName == "gred_base_bullet" and not ent.fuckHavok
					if isGred then
						local effectdata = EffectData()
						effectdata:SetOrigin(bullet.Position)
						effectdata:SetFlags(table.KeyFromValue(gred.Calibre,ent.Caliber))
						local ang = bullet.tr.HitNormal:Angle()
						if ent.Caliber == "wac_base_7mm" then
							effectdata:SetSurfaceProp(gred.Mats[util.GetSurfacePropName(bullet.tr.SurfaceProps)] or 24,6)
							ang.p = ang.p + 90
							effectdata:SetAngles(ang)
						else
							if ent.Caliber == "wac_base_12mm" then
								sound.Play("impactsounds/gun_impact_"..math.random(1,14)..".wav",bullet.Position,100,100,0.5)
							elseif ent.Caliber == "wac_base_20mm" then
								sound.Play("impactsounds/20mm_0"..math.random(1,5)..".wav",bullet.Position,100,100,0.7)
							elseif ent.Caliber == "wac_base_30mm" then
								sound.Play("impactsounds/30mm_old.wav",bullet.Position,100,math.random(90,110),0.7)
							elseif ent.Caliber == "wac_base_40mm" then
								sound.Play("impactsounds/20mm_0"..math.random(1,5)..".wav",bullet.Position,100,100,0.7)
							end
							effectdata:SetSurfaceProp(0) 
							effectdata:SetAngles(ang)
						end
						effectdata:SetMaterialIndex(1)
						util.Effect("gred_particle_impact",effectdata)
					end
					return isGred and (HAB_BULLET_EF_NOPARTICLES) or (bullet.AmmoType == "GaussEnergy" and HAB_BULLET_EF_DISABLEEFFECT or HAB_BULLET_EF_NONE)
				end)
				
				function MODULE:CreateEffects( Ent, Index, Bullet, Mode )

					local e = Bullet.tr.Entity

					local flags = HAB_BULLET_EF_NONE
					local override = hook.Call( "PhysBulletOnBulletCreateEffects_", MODULE, Ent, Index, Bullet, Mode )
					if override then
					
						if override == HAB_BULLET_EF_DISABLEEFFECT then

							return

						else

							flags = flags + override

						end

					end
					
					local effectdata = EffectData( )
						effectdata:SetDamageType( Bullet.BulletType )
						effectdata:SetEntity( e ) -- hit ent
						effectdata:SetHitBox( Bullet.tr.HitGroup or -1 ) -- hitgroup
						effectdata:SetMagnitude( Bullet.Caliber ) -- caliber
						effectdata:SetNormal( Bullet.tr.HitNormal or Bullet.FlightDirection ) -- direction 1
						effectdata:SetOrigin( Bullet.Position ) -- position
						effectdata:SetScale( Bullet.Caliber / 64 ) -- size --EffectSize
						effectdata:SetStart( -( Bullet.tr.Normal or Bullet.FlightDirection ) ) -- direction 2
						effectdata:SetSurfaceProp( Bullet.Surf or 0 ) -- hit material
						effectdata:SetAttachment( Mode )
						effectdata:SetFlags( flags )
					util.Effect( "hab_physbullet_effects", effectdata )

				end
			end
		end
	end)
	
	net.Receive("gred_lfs_setparts",function()
		local self = net.ReadEntity()
		if not self then print("[F-86] ERROR! ENTITY NOT INITALIZED CLIENT SIDE! PLEASE, RE-SPAWN!") return end
		self.Parts = {}
		for k,v in pairs(net.ReadTable()) do
			self.Parts[k] = v
		end
	end)
	net.Receive("gred_lfs_remparts",function()
		local self = net.ReadEntity()
		local k = net.ReadString()
		
		self.EmitNow = self.EmitNow and self.EmitNow or {}
		if (k == "wing_l" or k == "wing_r") and self.EmitNow[k] != "CEASE" then
			self.EmitNow[k] = true
		end
		if self.Parts then
			self.Parts[k] = nil
		end
	end)

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
				if name == "__INVALIDBONE__" and (self.BoneBlackList and !self.BoneBlackList[i]) then
					print("["..self.ClassName.."] INVALID BONE : "..i)
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
	CheckForUpdates()
else
	resource.AddWorkshop(1131455085) -- Base addon
	
	local AddNetworkString = util.AddNetworkString
	AddNetworkString("gred_net_checkconcommand")
	AddNetworkString("gred_net_sound_lowsh")
	AddNetworkString("gred_net_message_ply")
	AddNetworkString("gred_net_bombs_decals")
	AddNetworkString("gred_net_nw_var")
	AddNetworkString("gred_lfs_setparts")
	AddNetworkString("gred_lfs_remparts")
	
	net.Receive("gred_net_checkconcommand",function(len,ply)
		local str = net.ReadString()
		local cvar = GetConVar(str)
		local val = net.ReadFloat()
		if !cvar then return end
		if !ply:IsAdmin() then return end
		cvar:SetFloat(val)
	end)
	local soundSpeed = 16797.9*16797.9 -- 320m/s
	
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
		local calcSelfAnglePitch = selfAngle.p*0.01
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
					-- pod = IsDriver and DriverSeat or pod
					
					IsShooting = IsShooting or gunner:KeyDown(IN_ATTACK)
					
					for C,att in pairs(v.att) do
						att = self:GetAttachment(att)
						if C == 1 then
							ang = v.AngleOperate(self:WorldToLocalAngles(pod:WorldToLocalAngles(gunner:EyeAngles())),IsDriver,selfAngle)
							ang.p = ang.p - (IsDriver and calcSelfAnglePitch or calcSelfAnglePitch)
							-- ang.y = ang.y - 0
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
		local ConVar = GetConVar("gred_sv_shockwave_unfreeze"):GetInt() >= 1
		net.Start("gred_net_bombs_decals")
			net.WriteString(decal and decal or "scorch_medium")
			net.WriteVector(pos)
			net.WriteVector(pos-Vector(0,0,trace))
		net.Broadcast()
		debugoverlay.Sphere(pos,radius,3, Color( 255, 255, 255 ))
		ply = IsValid(ply) and ply or bomb
		util.BlastDamage(bomb,ply,pos,radius,damage)
		for k,v in pairs(ents.FindInSphere(pos,radius)) do
			local v_pos = v:GetPos()
			
			local phys = v:GetPhysicsObject()
			local F_dir
			if IsValid(phys) then
				if !v.IsOnPlane then
					local F_ang = DEFAULT_PHYSFORCE
					local dist = (pos - v_pos):Length()
					local relation = math.Clamp((radius - dist) / radius, 0, 1)
					if not DEFAULT_PHYSFORCE == nil then
						F_dir = (v_pos - pos) * DEFAULT_PHYSFORCE
					else
						F_dir = (v_pos - pos) * 1
					end
					phys:AddAngleVelocity(Vector(F_ang, F_ang, F_ang) * relation)
					phys:AddVelocity(F_dir)
					if ConVar then
						if !v.isWacAircraft and !v.LFS then
							phys:Wake()
							phys:EnableMotion(true)
							constraint.RemoveAll(v)
						end
					end
					-- local class = v:GetClass()
					-- if class == "func_breakable" or class == "func_breakable_surf" or class == "func_physbox" then
						-- v:Fire("Break", 0)
					-- end
				end
			end
			if v:IsPlayer() then
				if !v:IsOnGround() then
					v:SetMoveType(MOVETYPE_WALK)
					if not DEFAULT_PHYSFORCE_PLYAIR == nil then
						F_dir = (v_pos - pos) * DEFAULT_PHYSFORCE_PLYAIR
					else
						F_dir = (v_pos - pos)
					end
					v:SetVelocity( F_dir )
				else
					v:SetMoveType( MOVETYPE_WALK )
					local F_ang = DEFAULT_PHYSFORCE_PLYGROUND
					if not DEFAULT_PHYSFORCE_PLYGROUND == nil then
						F_dir = (v_pos - pos) * DEFAULT_PHYSFORCE_PLYGROUND
					else
						F_dir = (v_pos - pos)
					end
					v:SetVelocity( F_dir )
				end
			end
		end
	end
	
	gred.CreateSound = function(pos,rsound,e1,e2,e3)
		local currange = 1000 / GetConVar("gred_sv_soundspeed_divider"):GetInt()
		
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
	
	local OverrideHAB = GetConVar("gred_sv_override_hab")
	local Tracers = GetConVar("gred_sv_tracers")
	local BulletDMG = GetConVar("gred_sv_bullet_dmg")
	local HE12MM = GetConVar("gred_sv_12mm_he_impact")
	local HE7MM = GetConVar("gred_sv_7mm_he_impact")
	local HERADIUS = GetConVar("gred_sv_bullet_radius")
	local SoundAdd = sound.Add
	local BulletID = 0
	local angle_zero = angle_zero
	local vector_zero = vector_zero
	
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
				util.BlastDamage(ply,ply,hitpos,radius,dmg)
			end
			if !NoParticle then
				local effectdata = EffectData()
				effectdata:SetOrigin(hitpos)
				effectdata:SetAngles(hitang)
				effectdata:SetFlags(table.KeyFromValue(gred.Calibre,cal))
				if cal == "wac_base_7mm" then
					effectdata:SetSurfaceProp(gred.Mats[util.GetSurfacePropName(tr.SurfaceProps)] or 24,6)
				else
					effectdata:SetSurfaceProp(0)
				end
				effectdata:SetMaterialIndex(1)
				Effect("gred_particle_impact",effectdata)
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
			end
			util.BlastDamage(ply,ply,hitpos,radius,dmg)
			if !NoParticle then
				local effectdata = EffectData()
				effectdata:SetOrigin(hitpos)
				if !HitSky then 
					effectdata:SetAngles(hitang)
					effectdata:SetSurfaceProp(0)
				else 
					effectdata:SetAngles(Angle(0,0,0))
					effectdata:SetSurfaceProp(1)
				end
				effectdata:SetMaterialIndex(1)
				effectdata:SetFlags(table.KeyFromValue(gred.Calibre,cal))
				util.Effect("gred_particle_impact",effectdata)
			end
		end
	end
	
	function gred.CreateBullet(ply,pos,ang,cal,filter,fusetime,NoBullet,tracer,dmg,radius)
		if hab and hab.Module.PhysBullet and OverrideHAB:GetInt() == 1 then
			--[[local bullet = {}
			bullet.Attacker = ply
			bullet.Callback = nil
			bullet.Tracer = Tracers:GetInt()
			if cal == "wac_base_12mm" then
				if self.CustomDMG and !OpBullets then
						self.Damage = self.Damage * BulletDMG:GetFloat()
				else
					self.Damage = 60 * BulletDMG:GetFloat()
				end
				if HE12MM:GetInt() >= 1 then 
					bullet.Damage = zero 
					-- util.BlastDamage(self, self.Owner,hitpos, self.Radius, self.Damage)
				else
					bullet.Damage = self.Damage
				end
				if self.col == "Green" then
					bullet.AmmoType = "hvap_127x108_ap"
				else
					bullet.AmmoType = "hvap_127x99_ap"
				end
			elseif self.Caliber == "wac_base_7mm" then
				if self.CustomDMG and !OpBullets then
					self.Damage = self.Damage *BulletDMG:GetFloat()
				else
					self.Damage = 40 * BulletDMG:GetFloat()
				end
				if HE7MM:GetInt() >= 1 then
					bullet.Damage = zero
					-- util.BlastDamage(self, self.Owner,hitpos, self.Radius, self.Damage)
				else
					bullet.Damage = self.Damage 
				end
				if self.col == "Green" then
					bullet.AmmoType = "hab_792x57"
				elseif self.col == "Yellow" then
					bullet.AmmoType = "hab_77x56"
				else
					bullet.AmmoType = "hab_762x63"
				end
			elseif self.Caliber == "wac_base_30mm" then
				if self.CustomDMG and !OpBullets then
					self.Damage = self.Damage * BulletDMG:GetFloat()
				else
					self.Damage = 100 * BulletDMG:GetFloat()
				end
				-- self:EmitSound("impactsounds/30mm_old.wav",100, math.random(90,110),1, CHAN_AUTO)
			elseif self.Caliber == "wac_base_20mm" then
				if self.CustomDMG and !OpBullets then
					self.Damage = self.Damage * BulletDMG:GetFloat()
				else
					self.Damage = 80 * BulletDMG:GetFloat()
				end
				-- self:EmitSound( "impactsounds/20mm_0"..math.random(1,5)..".wav",100, 100,0.7, CHAN_AUTO)
				bullet.AmmoType = "hvap_20x102_hei"
			else
				if self.CustomDMG and !OpBullets then
					self.Damage = self.Damage * BulletDMG:GetFloat()
				else
					self.Damage = 120 * BulletDMG:GetFloat()
				end
				-- self:EmitSound( "impactsounds/20mm_0"..math.random(1,5)..".wav",100, 100,0.7, CHAN_AUTO)
			end
			bullet.Force = 5
			bullet.HullSize = 0
			bullet.Num = 1
			bullet.Dir = self:GetForward()
			bullet.Spread = Vector(0)
			bullet.Src = self:GetPos()
			bullet.IgnoreEntity = {}
			for k,v in pairs(self.Filter) do tableinsert(bullet.IgnoreEntity,v) end
			
			self:FireBullets(bullet,false)--]]
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
				local effect = EffectData()
				effect:SetOrigin(pos)
				effect:SetFlags(CAL_TABLE[cal])
				effect:SetMaterialIndex(COL_TABLE[tracer])
				if expltime then
					-- d = v*t
					effect:SetStart(QuickTrace(pos,fwd*(fusetime*speed),filter).HitPos)
				else
					effect:SetStart(QuickTrace(pos,fwd*99999999999999,filter).HitPos)
				end
				Effect("gred_particle_tracer",effect)
			end
			timer.Create("gred_bullet_"..oldbullet,0,0,function()
				dif = pos + pos - oldpos
				oldpos = pos
				local tr = TraceLine({start = pos,endpos = dif,filter = filter,mask = MASK_ALL})
				if tr.MatType == 83 then
					local effectdata = EffectData()
					effectdata:SetOrigin(tr.HitPos)
					effectdata:SetAngles(Angle(0,0,0))
					effectdata:SetSurfaceProp(0)
					effectdata:SetMaterialIndex(0)
					effectdata:SetFlags(table.KeyFromValue(gred.Calibre,cal))
					Effect("gred_particle_impact",effectdata)
					
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

	local startsWith = string.StartWith
	local function IsSmall(k)
		return startsWith(k,"gear") or startsWith(k,"wheel") or startsWith(k,"airbrake")
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
		AddYaw = AddYaw or 0.09
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
			addYaw = !self.Parts.wing_l and addYaw - vel*AddYaw or addYaw + vel*(AddYaw*0.22)
		end
		if not self.Parts.aileron_l then
			if Roll < 0 then Roll = Roll*0.5 end
		end
		if not self.Parts.aileron_r then
			if Roll > 0 then Roll = Roll*0.5 end
		end
		Roll = Roll + addRoll
		Yaw = Yaw + addYaw
		return Pitch,Yaw,Roll,Stability,Stability,Stability
	end
	
	gred.PartThink = function(self,skin)
		if self.LOADED == 1 then
			local NoCollide = constraint.NoCollide
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
end

for i = 1,3 do
	sound.Add( 	{
		name = "GRED_VO_HOLE_LEFT_WING_0"..i,
		channel = CHAN_STATIC,
		volume = 1.0,
		level = 125,
		sound = "gredwitch/voice/eng_left_wing_v1_r"..i.."_t1_mood_high.wav"
	} )
	sound.Add( 	{
		name = "GRED_VO_HOLE_RIGHT_WING_0"..i,
		channel = CHAN_STATIC,
		volume = 1.0,
		level = 125,
		sound = "gredwitch/voice/eng_right_wing_v1_r"..i.."_t1_mood_high.wav"
	} )
	sound.Add( 	{
		name = "GRED_VO_BAILOUT_0"..i,
		channel = CHAN_STATIC,
		volume = 1.0,
		level = 90,
		sound = "gredwitch/voice/eng_bailout_v1_r"..i.."_t1_mood_high.wav"
	} )
end

local LFSInifniteAmmo = GetConVar("gred_sv_lfs_infinite_ammo")
local LFSGodmode = GetConVar("gred_sv_lfs_godmode")
local WACOverride = GetConVar("gred_sv_wac_override")
local healthmultiplier = GetConVar("gred_sv_lfs_healthmultiplier")
local healthmultiplier_all = GetConVar("gred_sv_lfs_healthmultiplier_all")
local nextRefil = 0.5
local bigNum = 999999

hook.Add("OnEntityCreated","gred_ent_override",function(ent)
	if ent:IsNPC() then
		table.insert(gred.AllNPCs,ent)
		return
	end
	timer.Simple(0,function()
	
		-----------------------------------
		
		if ent.isWacAircraft then
			if WACOverride:GetInt() == 1 then
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
						
						gred.CreateSound(pos,false,"explosions/fuel_depot_explode_close.wav","explosions/fuel_depot_explode_dist.wav","explosions/fuel_depot_explode_far.wav")
						
						self:Remove()
						if radius <= 300 then
							local effectdata = EffectData()
							effectdata:SetOrigin(pos)
							effectdata:SetAngles(hitang)
							effectdata:SetFlags(1)
							effectdata:SetSurfaceProp(1)
							util.Effect("gred_particle_wac_explosion",effectdata)
							radius = 600
						elseif radius <= 500 then
							local effectdata = EffectData()
							effectdata:SetOrigin(pos)
							effectdata:SetAngles(hitang)
							effectdata:SetFlags(5)
							effectdata:SetSurfaceProp(1)
							util.Effect("gred_particle_wac_explosion",effectdata)
							
							radius = 800
						elseif radius <= 2000 then
							local effectdata = EffectData()
							effectdata:SetOrigin(pos)
							effectdata:SetAngles(hitang)
							effectdata:SetFlags(9)
							effectdata:SetSurfaceProp(1)
							util.Effect("gred_particle_wac_explosion",effectdata)
							radius = 1000
						end
						gred.CreateExplosion(pos,radius,1000,self.Decal,self.TraceLength,self.GBOWNER,self,self.DEFAULT_PHYSFORCE,self.DEFAULT_PHYSFORCE_PLYGROUND,self.DEFAULT_PHYSFORCE_PLYAIR)
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
								
								gred.CreateSound(pos,false,"/explosions/aircraft_water_close.wav","/explosions/aircraft_water_dist.wav","/explosions/aircraft_water_far.wav")
								
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
		
		elseif ent.LFS then
			if ent.Author == "Gredwitch" or healthmultiplier_all:GetInt() == 1 then
				ent.MaxHealth = ent.MaxHealth * healthmultiplier:GetFloat()
				ent.OldSetupDataTables = ent.SetupDataTables
				ent.SetupDataTables = function()
					if ent.DataSet then return end
					ent.DataSet = true
					ent:OldSetupDataTables()
					ent:NetworkVar( "Float",6, "HP", { KeyName = "health", Edit = { type = "Float", order = 2,min = 0, max = ent.MaxHealth, category = "Misc"} } )
				end
				ent:SetupDataTables()
				
				ent:SetHP(ent.MaxHealth)
			end
			if LFSGodmode:GetInt() == 1 then
				ent.Explode = function() return end
				ent.OnTakeDamage = function() return end
				ent.CheckRotorClearance = function() return end
				ent.nextDFX = 999999999999
			end
			if !CLIENT then
				if LFSInifniteAmmo:GetInt() == 1 then
					local oldthink = ent.Think
					ent.Think = function(self)
						if nextRefil < CurTime() then
							if self.MaxPrimaryAmmo != -1 then
								self:SetAmmoPrimary(self.MaxPrimaryAmmo)
							end
							if self.MaxSecondaryAmmo != -1 then
								self:SetAmmoSecondary(self.MaxSecondaryAmmo)
							end
							if self.SetAmmoMGFF then
								self:SetAmmoMGFF(self.AmmoMGFF)
							end
							if self.SetAmmoCannon then
								self:SetAmmoCannon(self.AmmoCannon)
							end
						end
						return oldthink(self)
					end
				end
			end
		end
		if !CLIENT then
			if ent.ClassName == "wac_hc_rocket" then
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
			elseif ent.ClassName == "gred_prop_part" or ent.ClassName == "gred_prop_tail" then
				if LFSGodmode:GetInt() == 1 then
					ent.OnTakeDamage = function() return end
				end
			end
		end
	end)
end)

hook.Add("EntityRemoved","gred_ent_removed",function(ent)
	if ent:IsNPC() then
		table.RemoveByValue(gred.AllNPCs,ent)
		return
	end
end)
