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

	CPanel:AddControl( "CheckBox", { Label = "Use GBombs style explosion?", Command = "gred_bombs_nocustomexplosion" } );

	------------------------------PLANES SETTINGS-------------------------------
	local plane = vgui.Create( "DImageButton" );
	plane:SetImage( "hud/planes_settings.png" );
	plane:SetSize( 200, 80 );
	plane.DoClick = function()
		local psnd = Sound( table.Random(psounds) );
		surface.PlaySound( psnd );
	end
	CPanel:AddPanel( plane );
	
	
	CPanel:AddControl( "CheckBox", { Label = "Use old rockets?", Command = "gred_oldrockets" } );
	
	CPanel:AddControl( "CheckBox", { Label = "Should bombs affect the aircraft's maniabillity?", Command = "gred_bombs_mass" } );

	CPanel:AddControl( "CheckBox", { Label = "Should jets be very fast?", Command = "gred_jets_speed" } );

	CPanel:AddControl( "CheckBox", { Label = "Use alternative fire particles?", Command = "gred_fire_effect" } );
	
	CPanel:AddControl( "CheckBox", { Label = "Use multiple fire particles?", Command = "gred_multiple_fire_effects" } );
	
	CPanel:AddControl( "CheckBox", { Label = "Use custom health system?", Command = "gred_enablehealth" } );
	
	CPanel:AddControl( "CheckBox", { Label = "Use health per engine sysetm?", Command = "gred_enableenginehealth" } );
	
	CPanel:NumSlider( "Default engine health", "gred_healthslider", 1, 1000, 0 );
	
	------------------------------BULLETS SETTINGS-------------------------------
	
	
	CPanel:AddControl( "CheckBox", { Label = "Use an alternative muzzleflash?", Command = "gred_altmuzzleeffect" } );
	
	CPanel:AddControl( "CheckBox", { Label = "Should 12mm MGs have a blast radius? (Kills tanks!)", Command = "gred_12mm_he_impact" } );
	
	CPanel:AddControl( "CheckBox", { Label = "Should 7mm MGs have a blast radius? (Kills tanks!)", Command = "gred_7mm_he_impact" } );
	
	CPanel:NumSlider( "Tracer ammo apparition", "gred_tracers", 0, 20, 0 );
	
	CPanel:AddControl( "CheckBox", { Label = "Use Insurgency impact effects for 7mm MGs?", Command = "gred_insparticles" } );
	
	CPanel:AddControl( "CheckBox", { Label = "Disable impact effects for 7mm MGs?", Command = "gred_noparticles_7mm" } );
	
	CPanel:AddControl( "CheckBox", { Label = "Disable impact effects for 12mm MGs?", Command = "gred_noparticles_12mm" } );
	
	CPanel:AddControl( "CheckBox", { Label = "Disable impact effects for 20mm cannons?", Command = "gred_noparticles_20mm" } );
	
	CPanel:AddControl( "CheckBox", { Label = "Disable impact effects for 30mm cannons?", Command = "gred_noparticles_30mm" } );
	
	CPanel:AddControl( "CheckBox", { Label = "Disable water impact effects?", Command = "gred_water_impact" } );
end




hook.Add( "PopulateToolMenu", "PopulateGbombsMenus", function()

	spawnmenu.AddToolMenuOption( "Options", "Gredwitch's Base", "GredwitchSettings", "Settings", "", "", gredsettings )

end );