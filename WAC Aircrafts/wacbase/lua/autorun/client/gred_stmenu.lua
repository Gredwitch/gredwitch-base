local Created = false;

local function gredsettings( CPanel )
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
	
	local shockwave = CPanel:AddControl( "CheckBox", { Label = "Should all bombs unweld and unfreeze?", Command = "gred_shockwave_unfreeze" } );
	shockwave.OnChange = function( panel, bVal ) 
		if( LocalPlayer():IsSuperAdmin() and !Created ) then
			if( ( bVal and 1 or 0 ) == cvars.Number( "gred_shockwave_unfreeze" ) ) then return end
			net.Start( "gred_cvar" );
				net.WriteString( "gred_shockwave_unfreeze" );
				net.WriteFloat( bVal and 1 or 0 );
			net.SendToServer();
		end
	end
	
	local max_field = CPanel:NumSlider( "Forcefield Max Range", "", 10, 10000, 0 );
	max_field.Scratch.ConVarChanged = function() end
	max_field.OnValueChanged = function( panel, val )
		if( LocalPlayer():IsSuperAdmin() and !JustMade ) then
			net.Start( "gred_cvar" );
				net.WriteString( "gred_maxforcefield_range" );
				net.WriteFloat( math.Round( tonumber( val ) ) );
			net.SendToServer();
		end
	end
	
	local decals = CPanel:AddControl( "CheckBox", { Label = "Should bombs leave decals behind?", Command = "gred_decals" } );
	decals.OnChange = function( panel, bVal ) 
		if( LocalPlayer():IsSuperAdmin() and !Created ) then
			if( ( bVal and 1 or 0 ) == cvars.Number( "gred_shockwave_unfreeze" ) ) then return end
			net.Start( "gred_cvar" );
				net.WriteString( "gred_decals" );
				net.WriteFloat( bVal and 1 or 0 );
			net.SendToServer();
		end
	end
	
	local easyuse = CPanel:AddControl( "CheckBox", { Label = "Should bombs be easily armed?", Command = "gred_easyuse" } );
	easyuse.OnChange = function( panel, bVal ) 
		if( LocalPlayer():IsSuperAdmin() and !Created ) then
			if( ( bVal and 1 or 0 ) == cvars.Number( "gred_easyuse" ) ) then return end
			net.Start( "gred_cvar" );
				net.WriteString( "gred_easyuse" );
				net.WriteFloat( bVal and 1 or 0 );
			net.SendToServer();
		end
	end
	
	local fragility = CPanel:AddControl( "CheckBox", { Label = "Should bombs arm when hit or dropped?", Command = "gred_fragility" } );
	fragility.OnChange = function( panel, bVal ) 
		if( LocalPlayer():IsSuperAdmin() and !Created ) then
			if( ( bVal and 1 or 0 ) == cvars.Number( "gred_fragility" ) ) then return end
			net.Start( "gred_cvar" );
				net.WriteString( "gred_fragility" );
				net.WriteFloat( bVal and 1 or 0 );
			net.SendToServer();
		end
	end
	
	local sh = CPanel:AddControl( "CheckBox", { Label = "Should there be sound shake?", Command = "gred_sound_shake" } );
	sh.OnChange = function( panel, bVal ) 
		if( LocalPlayer():IsSuperAdmin() and !Created ) then
			if( ( bVal and 1 or 0 ) == cvars.Number( "gred_sound_shake" ) ) then return end
			net.Start( "gred_cvar" );
				net.WriteString( "gred_sound_shake" );
				net.WriteFloat( bVal and 1 or 0 );
			net.SendToServer();
		end
	end
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
	
	local watereffect = CPanel:AddControl( "CheckBox", { Label = "Shooting on water creates impact effects?", Command = "gred_water_impact" } );
	watereffect.OnChange = function( panel, bVal ) 
		if( ( bVal and 1 or 0 ) == cvars.Number( "gred_water_impact" ) ) then return end
		net.Start( "gred_cvar" );
			net.WriteString( "gred_water_impact" );
			net.WriteFloat( bVal and 1 or 0 );
		net.SendToServer();
	end
	
	local hebullet = CPanel:AddControl( "CheckBox", { Label = "Should light 12mm have a blast radius? (Kills tanks!)", Command = "gred_he_impact" } );
	hebullet.OnChange = function( panel, bVal ) 
		if( LocalPlayer():IsSuperAdmin() and !JustMade ) then
			if( ( bVal and 1 or 0 ) == cvars.Number( "gred_he_impact" ) ) then return end
			net.Start( "gred_cvar" );
				net.WriteString( "gred_he_impact" );
				net.WriteFloat( bVal and 1 or 0 );
			net.SendToServer();
		end
	end
	
	local tracers = CPanel:NumSlider( "Tracer ammo apparition", "", 0, 20, 0 );
	tracers.Scratch.ConVarChanged = function() end
	tracers.OnValueChanged = function( panel, val )
		if( LocalPlayer():IsSuperAdmin() and !JustMade ) then
			net.Start( "gred_cvar" );
				net.WriteString( "gred_tracers" );
				net.WriteFloat( math.Round( tonumber( val ) ) );
			net.SendToServer();
		end
	end
	
	local oldrockets = CPanel:AddControl( "CheckBox", { Label = "Use old rockets?", Command = "gred_oldrockets" } );
	hebullet.OnChange = function( panel, bVal ) 
		if( LocalPlayer():IsSuperAdmin() and !JustMade ) then
			if( ( bVal and 1 or 0 ) == cvars.Number( "gred_oldrockets" ) ) then return end
			net.Start( "gred_cvar" );
				net.WriteString( "gred_oldrockets" );
				net.WriteFloat( bVal and 1 or 0 );
			net.SendToServer();
		end
	end
	
	local jetspeed = CPanel:AddControl( "CheckBox", { Label = "Should jets be very fast?", Command = "gred_jets_speed" } );
	jetspeed.OnChange = function( panel, bVal ) 
		if( LocalPlayer():IsSuperAdmin() and !JustMade ) then
			if( ( bVal and 1 or 0 ) == cvars.Number( "gred_jets_speed" ) ) then return end
			net.Start( "gred_cvar" );
				net.WriteString( "gred_jets_speed" );
				net.WriteFloat( bVal and 1 or 0 );
			net.SendToServer();
		end
	end
	
	local fireparticle = CPanel:AddControl( "CheckBox", { Label = "Use alternative fire particles?", Command = "gred_fire_effect" } );
	fireparticle.OnChange = function( panel, bVal ) 
		if( LocalPlayer():IsSuperAdmin() and !JustMade ) then
			if( ( bVal and 1 or 0 ) == cvars.Number( "gred_fire_effect" ) ) then return end
			net.Start( "gred_cvar" );
				net.WriteString( "fireparticle" );
				net.WriteFloat( bVal and 1 or 0 );
			net.SendToServer();
		end
	end
	
	local fireparticles = CPanel:AddControl( "CheckBox", { Label = "Use multiple fire particles?", Command = "gred_multiple_fire_effects" } );
	fireparticles.OnChange = function( panel, bVal ) 
		if( LocalPlayer():IsSuperAdmin() and !JustMade ) then
			if( ( bVal and 1 or 0 ) == cvars.Number( "gred_multiple_fire_effects" ) ) then return end
			net.Start( "gred_cvar" );
				net.WriteString( "fireparticles" );
				net.WriteFloat( bVal and 1 or 0 );
			net.SendToServer();
		end
	end
	
	local chealth	= CPanel:AddControl( "CheckBox", { Label = "Use custom health system?", Command = "gred_enablehealth" } );
	chealth.OnChange = function( panel, bVal ) 
		if( LocalPlayer():IsSuperAdmin() and !JustMade ) then
			if( ( bVal and 1 or 0 ) == cvars.Number( "gred_enablehealth" ) ) then return end
			net.Start( "gred_cvar" );
				net.WriteString( "chealth" );
				net.WriteFloat( bVal and 1 or 0 );
			net.SendToServer();
		end
	end
	
	local ehealth	= CPanel:AddControl( "CheckBox", { Label = "Use health per engine sysetm?", Command = "gred_enableenginehealth" } );
	chealth.OnChange = function( panel, bVal ) 
		if( LocalPlayer():IsSuperAdmin() and !JustMade ) then
			if( ( bVal and 1 or 0 ) == cvars.Number( "gred_enableenginehealth" ) ) then return end
			net.Start( "gred_cvar" );
				net.WriteString( "chealth" );
				net.WriteFloat( bVal and 1 or 0 );
			net.SendToServer();
		end
	end
	
	local healths = CPanel:NumSlider( "Default engine health", "", 1, 1000, 0 );
	healths.Scratch.ConVarChanged = function() end
	healths.OnValueChanged = function( panel, val )
		if( LocalPlayer():IsSuperAdmin() and !JustMade ) then
			net.Start( "gred_cvar" );
				net.WriteString( "gred_healthslider" );
				net.WriteFloat( math.Round( tonumber( val ) ) );
			net.SendToServer();
		end
	end
	------------------------------USELESS SHIT-------------------------------
	timer.Simple( 0.1, function()
		
		if( sh ) then
			sh:SetValue( GetConVarNumber( "gred_sound_shake" ) );
		end
		
		if( easyuse ) then
			easyuse:SetValue( GetConVarNumber( "gred_easyuse" ) );
		end
		
		if( fragility ) then
			fragility:SetValue( GetConVarNumber( "gred_fragility" ) );
		end
		
		if( max_field ) then
			max_field:SetValue( GetConVarNumber( "gred_maxforcefield_range" ) );
		end
		
		if( shockwave ) then
			shockwave:SetValue( GetConVarNumber( "gred_shockwave_unfreeze" ) );
		end
		
		if( decals ) then
			decals:SetValue( GetConVarNumber( "gred_decals" ) );
		end
		
		if( watereffect ) then
			watereffect:SetValue( GetConVarNumber("gred_water_impact") );
		end
		
		if( hebullet ) then
			hebullet:SetValue( GetConVarNumber("gred_he_impact") );
		end
		
		if( tracers ) then
			tracers:SetValue( GetConVarNumber("gred_tracers") );
		end
		
		if( oldrockets ) then
			oldrockets:SetValue( GetConVarNumber("gred_oldrockets") );
		end
		
		if( jetspeed ) then
			jetspeed:SetValue( GetConVarNumber("gred_jets_speed") );
		end
		
		if( fireparticle ) then
			fireparticle:SetValue( GetConVarNumber("gred_fire_effect") );
		end
		
		if( fireparticles ) then
			fireparticles:SetValue( GetConVarNumber("gred_multiple_fire_effects") );
		end
		
		if( ehealth ) then
			ehealth:SetValue( GetConVarNumber("gred_enableenginehealth") );
		end
		
		if( chealth ) then
			chealth:SetValue( GetConVarNumber("gred_enablehealth") );
		end
		
		if( healths ) then
			healths:SetValue( GetConVarNumber("gred_healthslider") );
		end
		
		Created = false;

	end );

end




hook.Add( "PopulateToolMenu", "PopulateGbombsMenus", function()

	spawnmenu.AddToolMenuOption( "Options", "Gredwitch's Base", "GredwitchSettings", "Settings", "", "", gredsettings )

end );