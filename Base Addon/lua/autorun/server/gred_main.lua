AddCSLuaFile()
util.AddNetworkString( "gred_cvar" )
util.AddNetworkString( "gred_net" )

TVIRUS_Easteregg=true

TOTAL_BOMBS = 0
net.Receive( "gred_cvar", function( len, pl ) 
	if( !pl:IsAdmin() ) then return end
	local cvar = net.ReadString();
	local val = net.ReadFloat();
	if( GetConVar( tostring( cvar ) ) == nil ) then return end
	if( GetConVarNumber( tostring( cvar ) ) == tonumber( val ) ) then return end

	game.ConsoleCommand( tostring( cvar ) .." ".. tostring( val ) .."\n" );

end );



function source_debug( ply, command)
	ply:ChatPrint("Engine Tickrate: \n"..tostring(1/engine.TickInterval()))
end
concommand.Add( "source_debug", source_debug )


function gb5_initial_spawn(ply, command, arguements, ClassName) --EDITED BY GREDWITCH, ORIGINAL GBOMBS 5 OWNER IS STEAM_0:1:34654275
		ply:ChatPrint("Welcome "..ply:Nick().." ! This awesome server is using Gredwitch's Addons!")
end 
hook.Add( "PlayerInitialSpawn", "playerInitialSpawn", gb5_initial_spawn )


function gb5_remove_debug( ply, command, args, ClassName)
	local ply_pos = ply:LocalToWorld(ply:OBBCenter())
	if args[3]=="all" or args[3]=="partial" then
		if args[3]=="all" then
			for k, v in pairs(ents.GetAll()) do
				if tostring(v:GetClass()) == tostring(args[1]) then
					v:Remove()
				end
			end
		elseif args[3]=="partial" then
			for k, v in pairs(ents.GetAll()) do
				if tostring(v:GetClass()) == tostring(args[1]) and args[3]!=nil then
					if math.random(0,math.Clamp(tonumber(args[4]),1,100))==0 then
						v:Remove()
					end
				end
			end		
		end
	else
		for k, v in pairs(ents.GetAll()) do
			if tostring(v:GetClass()) == tostring(args[1]) and (tonumber(v:EntIndex()) == tonumber(args[2])) then
				v:Remove()
			end
		end
	end

end
concommand.Add( "remove_debug", gb5_remove_debug )

function gb5_scan_debug( ply, command, args)
	
	for k, v in pairs(ents.GetAll()) do
		ply:ChatPrint("Entity "..tostring(v:GetClass()).." at index of "..tostring(v:EntIndex()).. " and owner of "..tostring(v:GetOwner()))
	end
	for k, v in pairs(player.GetAll()) do
		ply:ChatPrint("Player "..tostring(v:Nick()).." at index of "..tostring(v:EntIndex()))
	end
	ply:ChatPrint("END OF PLAYERS\n")

end
concommand.Add( "scan_debug", gb5_scan_debug )

function gb5_spawn_debug( ply, command, args)
	if args[1]==nil or args[2]==nil or args[3]==nil or args[4]==nil or args[5]==nil or args[6]==nil or args[7]==nil or args[8]==nil then return end
	local eye_trace = ply:GetEyeTrace().HitPos
	
	local mode, ent, ply, t, st, q, vars, sp = args[1], args[2], tonumber(args[3]), tonumber(args[4]), tonumber(args[5]), tonumber(args[6]), args[7], args[8]
	
	if table.Count(args)==0 then return end
	
	
	timer.Simple(t, function()
		for k, v in pairs(player.GetAll()) do
			if v:EntIndex()==ply then
				if not(tonumber(q)) then return end
				for i=0, q do
					timer.Simple(st*i, function()
						
						
						local ent = ents.Create(ent)
						
						if sp == "ply" then ent:SetPos(v:GetPos()) else ent:SetPos(eye_trace) end
						ent:Spawn()
						ent:Activate()
						ent:SetVar("GBOWNER", v)
						ent:SetOwner(v)
						
						if mode=="spawn_function" then 
				
							ent:SpawnFunction(v, v:GetEyeTrace())

							ent:Remove()
						end
						
					
						local var_table = string.Explode(",", vars)
						
						
						
						for index, variable in pairs(var_table) do
							local var_exploded = string.Explode("=", variable)
							local arg_processed = nil
							
							if var_exploded[2]=="true" then var_exploded[2]=true elseif var_exploded[2]=="false" then var_exploded[2]=false end -- bool check
							
							if var_exploded[2]!=true and var_exploded[2]!=false then 
								if string.StartWith(var_exploded[2], "ply_")==true then
									local ply_targ = tonumber(string.Explode("_", var_exploded[2])[2])
									if player.GetAll()[ply_targ]:IsValid()==false then return end
									
									var_exploded[2]=player.GetAll()[ply_targ]
				
								end
							end
							
							if ent:IsValid() then ent:SetVar(var_exploded[1],var_exploded[2]) end
							
							
						
						end
		

							
							
				
						
						
						
						
						
					end)
				end
			end
		end	
	end)

	

end
concommand.Add( "advspawn_debug", gb5_spawn_debug )
