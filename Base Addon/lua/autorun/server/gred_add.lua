AddCSLuaFile()

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

CreateConVar("gred_sv_nowaterimpacts"			,  "1"  , GRED_SVAR)
CreateConVar("gred_sv_insparticles"				,  "1"  , GRED_SVAR)
CreateConVar("gred_sv_noparticles_7mm"			,  "1"  , GRED_SVAR)
CreateConVar("gred_sv_noparticles_12mm"			,  "1"  , GRED_SVAR)
CreateConVar("gred_sv_noparticles_20mm"			,  "1"  , GRED_SVAR)
CreateConVar("gred_sv_noparticles_20mm"			,  "1"  , GRED_SVAR)
CreateConVar("gred_sv_noparticles_30mm"			,  "1"  , GRED_SVAR)
CreateConVar("gred_sv_altmuzzleeffect"			,  "1"  , GRED_SVAR)

game.AddDecal( "scorch_small",					"decals/scorch_small" );
game.AddDecal( "scorch_medium",					"decals/scorch_medium" );
game.AddDecal( "scorch_big",					"decals/scorch_big" );
game.AddDecal( "scorch_big_2",					"decals/scorch_big_2" );
game.AddDecal( "scorch_big_3",					"decals/scorch_big_3" );