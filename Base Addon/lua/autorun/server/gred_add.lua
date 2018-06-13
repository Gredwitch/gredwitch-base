AddCSLuaFile()

local GRED_SVAR = { FCVAR_REPLICATED,FCVAR_ARCHIVE, FCVAR_SERVER_CAN_EXECUTE, FCVAR_NOTIFY }

CreateConVar("gred_easyuse"					,  "1"  , GRED_SVAR)
CreateConVar("gred_maxforcefield_range"		, "5000", GRED_SVAR)
CreateConVar("gred_12mm_he_impact"			,  "1"  , GRED_SVAR)
CreateConVar("gred_7mm_he_impact"			,  "1"  , GRED_SVAR)
CreateConVar("gred_fragility"				,  "1"  , GRED_SVAR)
CreateConVar("gred_shockwave_unfreeze"		,  "0"  , GRED_SVAR)
CreateConVar("gred_tracers"					,  "5"  , GRED_SVAR)
CreateConVar("gred_oldrockets"				,  "0"  , GRED_SVAR)
CreateConVar("gred_jets_speed"				,  "1"  , GRED_SVAR)
CreateConVar("gred_healthslider"			, "100" , GRED_SVAR)
CreateConVar("gred_enablehealth"			,  "1"  , GRED_SVAR)
CreateConVar("gred_enableenginehealth"		,  "1"  , GRED_SVAR)
CreateConVar("gred_bombs_mass"				,  "0"  , GRED_SVAR)
CreateConVar("gred_bombs_nocustomexplosion" ,  "0"  , GRED_SVAR)
CreateConVar("gred_fire_effect"				,  "1"  , GRED_SVAR)
CreateConVar("gred_multiple_fire_effects"	,  "1"  , GRED_SVAR)

game.AddDecal( "scorch_small",					"decals/scorch_small" );
game.AddDecal( "scorch_medium",					"decals/scorch_medium" );
game.AddDecal( "scorch_big",					"decals/scorch_big" );
game.AddDecal( "scorch_big_2",					"decals/scorch_big_2" );
game.AddDecal( "scorch_big_3",					"decals/scorch_big_3" );
