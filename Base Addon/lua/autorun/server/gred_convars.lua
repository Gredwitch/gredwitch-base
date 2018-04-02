AddCSLuaFile()

if GetConVar("gred_easyuse") == nil then
	CreateConVar("gred_easyuse", "1", { FCVAR_REPLICATED, FCVAR_ARCHIVE, FCVAR_NOTIFY } )
end

if GetConVar("gred_maxforcefield_range") == nil then
	CreateConVar("gred_maxforcefield_range", "5000", { FCVAR_REPLICATED, FCVAR_ARCHIVE, FCVAR_NOTIFY } )
end

if GetConVar("gred_fragility") == nil then
	CreateConVar("gred_fragility", "1", {FCVAR_REPLICATED, FCVAR_ARCHIVE, FCVAR_NOTIFY } )
end

if GetConVar("gred_shockwave_unfreeze") == nil then
	CreateConVar("gred_shockwave_unfreeze", "0", { FCVAR_REPLICATED, FCVAR_ARCHIVE, FCVAR_NOTIFY } )
end

if GetConVar("gred_decals") == nil then
	CreateClientConVar("gred_decals", "1", true,{ FCVAR_ARCHIVE } )
end

if GetConVar("gred_sound_shake") == nil then
	CreateConVar("gred_sound_shake", "1", { FCVAR_REPLICATED, FCVAR_ARCHIVE, FCVAR_NOTIFY } )
end

if GetConVar("gred_water_impact") == nil then
	CreateClientConVar("gred_water_impact", "1", true,{ FCVAR_ARCHIVE } )
end

if GetConVar("gred_12mm_he_impact") == nil then
	CreateConVar("gred_12mm_he_impact", "1", { FCVAR_REPLICATED, FCVAR_ARCHIVE, FCVAR_NOTIFY } )
end

if GetConVar("gred_7mm_he_impact") == nil then
	CreateConVar("gred_7mm_he_impact", "1", { FCVAR_REPLICATED, FCVAR_ARCHIVE, FCVAR_NOTIFY } )
end

if GetConVar("gred_tracers") == nil then
	CreateConVar("gred_tracers", "5", { FCVAR_REPLICATED, FCVAR_ARCHIVE, FCVAR_NOTIFY } )
end

if GetConVar("gred_oldrockets") == nil then
	CreateConVar("gred_oldrockets", "0", { FCVAR_REPLICATED, FCVAR_ARCHIVE, FCVAR_NOTIFY } )
end

if GetConVar("gred_jets_speed") == nil then
	CreateConVar("gred_jets_speed", "1", { FCVAR_REPLICATED, FCVAR_ARCHIVE, FCVAR_NOTIFY } )
end

if GetConVar("gred_fire_effect") == nil then
	CreateClientConVar("gred_fire_effect", "1", { FCVAR_REPLICATED, FCVAR_ARCHIVE, FCVAR_NOTIFY } )
end

if GetConVar("gred_multiple_fire_effect") == nil then
	CreateClientConVar("gred_multiple_fire_effects", "1", true,{ FCVAR_ARCHIVE } )
end

if GetConVar("gred_healthslider") == nil then
	CreateConVar("gred_healthslider", "100", { FCVAR_REPLICATED, FCVAR_ARCHIVE, FCVAR_NOTIFY } )
end

if GetConVar("gred_enablehealth") == nil then
	CreateConVar("gred_enablehealth", "1", { FCVAR_REPLICATED, FCVAR_ARCHIVE, FCVAR_NOTIFY } )
end

if GetConVar("gred_enableenginehealth") == nil then
	CreateConVar("gred_enableenginehealth", "1", { FCVAR_REPLICATED, FCVAR_ARCHIVE, FCVAR_NOTIFY } )
end