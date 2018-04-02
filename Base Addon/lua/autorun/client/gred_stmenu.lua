local Created = false;

-- concommand.Add( "gred_options_reset", function callback, function autoComplete=nil, string helpText=nil, number flags=0 ) 

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
	LocalPlayer().clicks = 0
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
	LocalPlayer().clicks = 0
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
	
	-- CPanel:Button( "Reset the options", "", vararg concmd args )
end




hook.Add( "PopulateToolMenu", "PopulateGbombsMenus", function()

	spawnmenu.AddToolMenuOption( "Options", "Gredwitch's Base", "GredwitchSettings", "Settings", "", "", gredsettings )

end );