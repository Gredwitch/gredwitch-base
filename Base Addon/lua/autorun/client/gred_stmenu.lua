--[[	local gred_multiple_fire_effect = CreateClientConVar("gred_multiple_fire_effects", "1", true,{ FCVAR_ARCHIVE } )
	local gred_decals = CreateClientConVar("gred_decals", "1", true,{ FCVAR_ARCHIVE } )
	local gred_water_impact = CreateClientConVar("gred_water_impact", "1", true,{ FCVAR_ARCHIVE } )
	
	local gred_easyuse = CreateConVar("gred_easyuse", "1", { FCVAR_REPLICATED, FCVAR_ARCHIVE, FCVAR_NOTIFY } )
	local gred_maxforcefield_range = CreateConVar("gred_maxforcefield_range", "5000", { FCVAR_REPLICATED, FCVAR_ARCHIVE, FCVAR_NOTIFY } )
	local gred_fragility = CreateConVar("gred_fragility", "1", {FCVAR_REPLICATED, FCVAR_ARCHIVE, FCVAR_NOTIFY } )
	local gred_shockwave_unfreeze = CreateConVar("gred_shockwave_unfreeze", "1", { FCVAR_REPLICATED, FCVAR_ARCHIVE, FCVAR_NOTIFY } )
	local gred_sound_shake = CreateConVar("gred_sound_shake", "1", { FCVAR_REPLICATED, FCVAR_ARCHIVE, FCVAR_NOTIFY } )
	local gred_12mm_he_impact = CreateConVar("gred_12mm_he_impact", "1", { FCVAR_REPLICATED, FCVAR_ARCHIVE, FCVAR_NOTIFY } )
	local gred_7mm_he_impact = CreateConVar("gred_7mm_he_impact", "1", { FCVAR_REPLICATED, FCVAR_ARCHIVE, FCVAR_NOTIFY } )
	local gred_tracers = CreateConVar("gred_tracers", "5", { FCVAR_REPLICATED, FCVAR_ARCHIVE, FCVAR_NOTIFY } )
	local gred_oldrockets = CreateConVar("gred_oldrockets", "0", { FCVAR_REPLICATED, FCVAR_ARCHIVE, FCVAR_NOTIFY } )
	local gred_jets_speed = CreateConVar("gred_jets_speed", "1", { FCVAR_REPLICATED, FCVAR_ARCHIVE, FCVAR_NOTIFY } )
	local gred_fire_effect = CreateConVar("gred_fire_effect", "1", { FCVAR_REPLICATED, FCVAR_ARCHIVE, FCVAR_NOTIFY } )
	local gred_healthslider = CreateConVar("gred_healthslider", "100", { FCVAR_REPLICATED, FCVAR_ARCHIVE, FCVAR_NOTIFY } )
	local gred_enablehealth = CreateConVar("gred_enablehealth", "1", { FCVAR_REPLICATED, FCVAR_ARCHIVE, FCVAR_NOTIFY } )
	local gred_enableenginehealth = CreateConVar("gred_enableenginehealth", "1", { FCVAR_REPLICATED, FCVAR_ARCHIVE, FCVAR_NOTIFY } )
--]]
local function gredsettings( CPanel )
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
	
	CPanel:AddControl( "CheckBox", { Label = "Should all bombs unweld and unfreeze?", Command = "gred_shockwave_unfreeze" } );
	
	CPanel:NumSlider( "Forcefield Max Range", "gred_maxforcefield_range", 10, 10000, 0 );
	
	CPanel:AddControl( "CheckBox", { Label = "Should bombs leave decals behind?", Command = "gred_decals" } );
	
	CPanel:AddControl( "CheckBox", { Label = "Should bombs be easily armed?", Command = "gred_easyuse" } );
	
	CPanel:AddControl( "CheckBox", { Label = "Should bombs arm when hit or dropped?", Command = "gred_fragility" } );

	CPanel:AddControl( "CheckBox", { Label = "Should there be sound shake?", Command = "gred_sound_shake" } );

	------------------------------PLANE SETTINGS-------------------------------
	local plane = vgui.Create( "DImageButton" );
	plane:SetImage( "hud/planes_settings.png" );
	plane:SetSize( 200, 80 );
	plane.DoClick = function()
		local psnd = Sound( table.Random(psounds) );
		surface.PlaySound( psnd );
	end

	CPanel:AddPanel( plane );
	
	
	CPanel:NumSlider( "Tracer ammo apparition", "gred_tracers", 0, 20, 0 );
	
	CPanel:AddControl( "CheckBox", { Label = "Shooting on water creates impact effects?", Command = "gred_water_impact" } );
	
	CPanel:AddControl( "CheckBox", { Label = "Should 12mm MGs have a blast radius? (Kills tanks!)", Command = "gred_12mm_he_impact" } );
	
	CPanel:AddControl( "CheckBox", { Label = "Should 7mm MGs have a blast radius? (Kills tanks!)", Command = "gred_7mm_he_impact" } );
	
	CPanel:AddControl( "CheckBox", { Label = "Use old rockets?", Command = "gred_oldrockets" } );

	CPanel:AddControl( "CheckBox", { Label = "Should jets be very fast?", Command = "gred_jets_speed" } );

	CPanel:AddControl( "CheckBox", { Label = "Use alternative fire particles?", Command = "gred_fire_effect" } );
	
	CPanel:AddControl( "CheckBox", { Label = "Use multiple fire particles?", Command = "gred_multiple_fire_effects" } );
	
	CPanel:AddControl( "CheckBox", { Label = "Use custom health system?", Command = "gred_enablehealth" } );
	
	CPanel:AddControl( "CheckBox", { Label = "Use health per engine sysetm?", Command = "gred_enableenginehealth" } );
	
	CPanel:NumSlider( "Default engine health", "gred_healthslider", 1, 1000, 0 );
	--[[
	local reset = vgui.Create( "DImageButton" );
	reset:SetImage( "hud/options_reset.png" );
	reset:SetSize( 200, 100 );
	reset.DoClick = function()
		gred_maxforcefield_range:SetInt(5000)
		gred_fragility:SetInt(1)
		gred_shockwave_unfreeze:SetInt(1)
		gred_decals:SetInt(1)
		gred_sound_shake:SetInt(1)
		
		gred_water_impact:SetInt(1)
		gred_7mm_he_impact:SetInt(1)
		gred_tracers:SetInt(5)
		gred_oldrockets:SetInt(0)
		gred_jets_speed:SetInt(1)
		gred_fire_effect:SetInt(1)
		gred_multiple_fire_effect:SetInt(1)
		gred_healthslider:SetInt(100)
		gred_enablehealth:SetInt(1)
		gred_enableenginehealth:SetInt(1)
	end
	CPanel:AddPanel( reset );--]]
end




hook.Add( "PopulateToolMenu", "PopulateGbombsMenus", function()

	spawnmenu.AddToolMenuOption( "Options", "Gredwitch's Base", "GredwitchSettings", "Settings", "", "", gredsettings )

end );