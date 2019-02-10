if SERVER then AddCSLuaFile() end

-- Adding particles
game.AddParticles( "particles/doi_explosion_fx.pcf")
game.AddParticles( "particles/doi_explosion_fx_b.pcf")
game.AddParticles( "particles/doi_explosion_fx_c.pcf")
game.AddParticles( "particles/doi_explosion_fx_grenade.pcf")
game.AddParticles( "particles/doi_explosion_fx_new.pcf")
game.AddParticles( "particles/doi_impact_fx.pcf" )
game.AddParticles( "particles/doi_weapon_fx.pcf" )

game.AddParticles( "particles/gb_water.pcf")
game.AddParticles( "particles/gb5_100lb.pcf")
game.AddParticles( "particles/gb5_500lb.pcf")
game.AddParticles( "particles/gb5_1000lb.pcf")
game.AddParticles( "particles/gb5_jdam.pcf")
game.AddParticles( "particles/gb5_large_explosion.pcf")
game.AddParticles( "particles/gb5_napalm.pcf")
game.AddParticles( "particles/gb5_light_bomb.pcf")
game.AddParticles( "particles/gb5_high_explosive_2.pcf")
game.AddParticles( "particles/gb5_high_explosive.pcf")
game.AddParticles( "particles/gb5_fireboom.pcf")
game.AddParticles( "particles/neuro_tank_ap.pcf")

game.AddParticles( "particles/ins_rockettrail.pcf")
game.AddParticles( "particles/ammo_cache_ins.pcf")
game.AddParticles( "particles/doi_rockettrail.pcf")
game.AddParticles( "particles/mnb_flamethrower.pcf")
game.AddParticles( "particles/impact_fx_ins.pcf" )
game.AddParticles( "particles/environment_fx.pcf")
game.AddParticles( "particles/water_impact.pcf")
game.AddParticles( "particles/explosion_fx_ins.pcf")
game.AddParticles( "particles/weapon_fx_tracers.pcf" )
game.AddParticles( "particles/weapon_fx_ins.pcf" )

game.AddParticles( "particles/gred_particles.pcf" )
game.AddParticles( "particles/fire_01.pcf" )
game.AddParticles( "particles/doi_explosions_smoke.pcf" )
game.AddParticles( "particles/explosion_fx_ins_b.pcf" )
game.AddParticles( "particles/ins_smokegrenade.pcf" )
game.AddParticles( "particles/ww1_gas.pcf" )

-- Precaching main particles
PrecacheParticleSystem("gred_20mm")
PrecacheParticleSystem("gred_20mm_airburst")
PrecacheParticleSystem("gred_40mm")
PrecacheParticleSystem("gred_40mm_airburst")
PrecacheParticleSystem("30cal_impact")
PrecacheParticleSystem("fire_large_01")
PrecacheParticleSystem("30cal_impact")
PrecacheParticleSystem("doi_gunrun_impact")
PrecacheParticleSystem("doi_artillery_explosion")
PrecacheParticleSystem("doi_stuka_explosion")
PrecacheParticleSystem("gred_mortar_explosion")
PrecacheParticleSystem("gred_50mm")
PrecacheParticleSystem("ins_rpg_explosion")
PrecacheParticleSystem("ins_water_explosion")
PrecacheParticleSystem("fireboom_explosion_midair")
PrecacheParticleSystem("doi_petrol_explosion")

PrecacheParticleSystem("doi_impact_water")
PrecacheParticleSystem("impact_water")
PrecacheParticleSystem("water_small")
PrecacheParticleSystem("water_medium")
PrecacheParticleSystem("water_huge")

PrecacheParticleSystem("muzzleflash_sparks_variant_6")
PrecacheParticleSystem("muzzleflash_1p_glow")
PrecacheParticleSystem("muzzleflash_m590_1p_core")
PrecacheParticleSystem("muzzleflash_smoke_small_variant_1")
for i = 0,1 do
	if i == 1 then pcfD = "" else pcfD = "doi_" end
	PrecacheParticleSystem(""..pcfD.."impact_concrete")
	PrecacheParticleSystem(""..pcfD.."impact_dirt")
	PrecacheParticleSystem(""..pcfD.."impact_glass")
	PrecacheParticleSystem(""..pcfD.."impact_metal")
	PrecacheParticleSystem(""..pcfD.."impact_sand")
	PrecacheParticleSystem(""..pcfD.."impact_snow")
	PrecacheParticleSystem(""..pcfD.."impact_leaves")
	PrecacheParticleSystem(""..pcfD.."impact_wood")
	PrecacheParticleSystem(""..pcfD.."impact_grass")
	PrecacheParticleSystem(""..pcfD.."impact_tile")
	PrecacheParticleSystem(""..pcfD.."impact_plastic")
	PrecacheParticleSystem(""..pcfD.."impact_rock")
	PrecacheParticleSystem(""..pcfD.."impact_gravel")
	PrecacheParticleSystem(""..pcfD.."impact_mud")
	PrecacheParticleSystem(""..pcfD.."impact_fruit")
	PrecacheParticleSystem(""..pcfD.."impact_asphalt")
	PrecacheParticleSystem(""..pcfD.."impact_cardboard")
	PrecacheParticleSystem(""..pcfD.."impact_rubber")
	PrecacheParticleSystem(""..pcfD.."impact_carpet")
	PrecacheParticleSystem(""..pcfD.."impact_brick")
	PrecacheParticleSystem(""..pcfD.."impact_leaves")
	PrecacheParticleSystem(""..pcfD.."impact_paper")
	PrecacheParticleSystem(""..pcfD.."impact_computer")
end

PrecacheParticleSystem("high_explosive_main_2")
PrecacheParticleSystem("high_explosive_air_2")
PrecacheParticleSystem("water_torpedo")
PrecacheParticleSystem("high_explosive_air")
PrecacheParticleSystem("napalm_explosion")
PrecacheParticleSystem("napalm_explosion_midair")
PrecacheParticleSystem("cloudmaker_ground")
PrecacheParticleSystem("1000lb_explosion")
PrecacheParticleSystem("500lb_air")
PrecacheParticleSystem("100lb_air")
PrecacheParticleSystem("500lb_ground")
PrecacheParticleSystem("rockettrail")
PrecacheParticleSystem("grenadetrail")
PrecacheParticleSystem("weapon_tracers_smoke")
PrecacheParticleSystem("gred_ap_impact")
PrecacheParticleSystem("doi_mortar_explosion")
PrecacheParticleSystem("doi_wparty_explosion")
PrecacheParticleSystem("doi_smoke_artillery")
PrecacheParticleSystem("doi_ceilingDust_large")
PrecacheParticleSystem("m203_smokegrenade")
PrecacheParticleSystem("doi_GASarty_explosion")
PrecacheParticleSystem("doi_compb_explosion")
PrecacheParticleSystem("doi_wpgrenade_explosion")
PrecacheParticleSystem("ins_c4_explosion")
PrecacheParticleSystem("doi_artillery_explosion_OLD")
PrecacheParticleSystem("gred_highcal_rocket_explosion")

PrecacheParticleSystem("muzzleflash_bar_3p")
PrecacheParticleSystem("muzzleflash_garand_3p")
PrecacheParticleSystem("muzzleflash_mg42_3p")
PrecacheParticleSystem("ins_weapon_at4_frontblast")
PrecacheParticleSystem("ins_weapon_rpg_dust")
PrecacheParticleSystem("gred_arti_muzzle_blast")
PrecacheParticleSystem("gred_mortar_explosion_smoke_ground")
PrecacheParticleSystem("weapon_muzzle_smoke")
PrecacheParticleSystem("ins_ammo_explosionOLD")
PrecacheParticleSystem("gred_ap_impact")
PrecacheParticleSystem("AP_impact_wall")


game.AddDecal( "scorch_small",					"decals/scorch_small" );
game.AddDecal( "scorch_medium",					"decals/scorch_medium" );
game.AddDecal( "scorch_big",					"decals/scorch_big" );
game.AddDecal( "scorch_huge",					"decals/scorch_huge" );
game.AddDecal( "scorch_gigantic",				"decals/scorch_gigantic" );
game.AddDecal( "scorch_x10",					"decals/scorch_x10" );

local filecount = 0
local foldercount = 0

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

if SERVER then 
	util.AddNetworkString("gred_net_sound_lowsh")
	util.AddNetworkString("gred_net_explosion_fx")
	util.AddNetworkString("gred_net_impact_fx")
	util.AddNetworkString("gred_net_wac_explosion")
	util.AddNetworkString("gred_net_wac_fire")
	util.AddNetworkString("gred_net_message_ply")
	util.AddNetworkString("gred_net_bombs_decals")
	util.AddNetworkString("gred_net_nw_var")
	util.AddNetworkString("gred_net_wac_gunner_muzzle_fx")
	util.AddNetworkString("gred_net_wac_mg_muzzle_fx")
end

if CLIENT then
	net.Receive("gred_net_explosion_fx",function()
		ParticleEffect(net.ReadString(),net.ReadVector(),net.ReadAngle(),nil)
		if net.ReadBool() then
			ParticleEffect("doi_ceilingDust_large",net.ReadVector(),Angle(0,0,0),nil)
		end
	end)
	
	net.Receive("gred_net_impact_fx",function()
		if !net.ReadBool() then
			local cal = net.ReadString()
			if cal == "wac_base_7mm" then
				if GetConVar("gred_cl_noparticles_7mm"):GetInt() == 1 then return end
				if GetConVar("gred_cl_insparticles"):GetInt() == 1 then pcfD = "" else pcfD = "doi_" end
				local mat = net.ReadInt(6)
				if mat == 1 then
					ParticleEffect(""..pcfD.."impact_concrete",net.ReadVector(),net.ReadAngle(),nil)
				elseif mat == 2 then
					ParticleEffect(""..pcfD.."impact_dirt",net.ReadVector(),net.ReadAngle(),nil)
						
				elseif mat == 4 then
					ParticleEffect(""..pcfD.."impact_glass",net.ReadVector(),net.ReadAngle(),nil)
						
				elseif mat == 5 then
					ParticleEffect(""..pcfD.."impact_metal",net.ReadVector(),net.ReadAngle(),nil)
						
				elseif mat == 6 then
					ParticleEffect(""..pcfD.."impact_sand",net.ReadVector(),net.ReadAngle(),nil)
						
				elseif mat == 7 then
					ParticleEffect(""..pcfD.."impact_snow",net.ReadVector(),net.ReadAngle(),nil)
						
				elseif mat == 8 then
					ParticleEffect(""..pcfD.."impact_leaves",net.ReadVector(),net.ReadAngle(),nil)
						
				elseif mat == 9 then
					ParticleEffect(""..pcfD.."impact_wood",net.ReadVector(),net.ReadAngle(),nil)
						
				elseif mat == 10 then
					ParticleEffect(""..pcfD.."impact_grass",net.ReadVector(),net.ReadAngle(),nil)
						
				elseif mat == 11 then
					ParticleEffect(""..pcfD.."impact_tile",net.ReadVector(),net.ReadAngle(),nil)
						
				elseif mat == 12 then
					ParticleEffect(""..pcfD.."impact_plastic",net.ReadVector(),net.ReadAngle(),nil)
						
				elseif mat == 13 then
					ParticleEffect(""..pcfD.."impact_rock",net.ReadVector(),net.ReadAngle(),nil)
						
				elseif mat == 14 then
					ParticleEffect(""..pcfD.."impact_gravel",net.ReadVector(),net.ReadAngle(),nil)
						
				elseif mat == 15 then
					ParticleEffect(""..pcfD.."impact_mud",net.ReadVector(),net.ReadAngle(),nil)
					
				elseif mat == 16 then
					ParticleEffect(""..pcfD.."impact_fruit",net.ReadVector(),net.ReadAngle(),nil)
						
				elseif mat == 17 then
					ParticleEffect(""..pcfD.."impact_asphalt",net.ReadVector(),net.ReadAngle(),nil)
						
				elseif mat == 18 then
					ParticleEffect(""..pcfD.."impact_cardboard",net.ReadVector(),net.ReadAngle(),nil)
						
				elseif mat == 19 then
					ParticleEffect(""..pcfD.."impact_rubber",net.ReadVector(),net.ReadAngle(),nil)
						
				elseif mat == 20 then
					ParticleEffect(""..pcfD.."impact_carpet",net.ReadVector(),net.ReadAngle(),nil)
						
				elseif mat == 21 then
					ParticleEffect(""..pcfD.."impact_brick",net.ReadVector(),net.ReadAngle(),nil)
						
				elseif mat == 22 then
					ParticleEffect(""..pcfD.."impact_leaves",net.ReadVector(),net.ReadAngle(),nil)
						
				elseif mat == 23 then
					ParticleEffect(""..pcfD.."impact_paper",net.ReadVector(),net.ReadAngle(),nil)
						
				elseif mat == 24 then
					ParticleEffect(""..pcfD.."impact_computer",net.ReadVector(),net.ReadAngle(),nil)
				else
				
				end
					
			elseif cal == "wac_base_12mm" then
				if GetConVar("gred_cl_noparticles_12mm"):GetInt() == 1 then return end
				ParticleEffect("doi_gunrun_impact",net.ReadVector(),net.ReadAngle(),nil)
			elseif cal == "wac_base_20mm" then
				if GetConVar("gred_cl_noparticles_20mm"):GetInt() == 1 then return end
				
				if !net.ReadBool() then
					ParticleEffect("gred_20mm",net.ReadVector(),net.ReadAngle(),nil)
				else
					ParticleEffect("gred_20mm_airburst",net.ReadVector(),net.ReadAngle(),nil)
				end
			elseif cal == "wac_base_30mm" then
				if GetConVar("gred_cl_noparticles_30mm"):GetInt() == 1 then return end
				net.ReadBool()
				ParticleEffect("30cal_impact",net.ReadVector(),net.ReadAngle(),nil)
			elseif cal == "wac_base_40mm" then
				if GetConVar("gred_cl_noparticles_40mm"):GetInt() == 1 then return end
				if !net.ReadBool() then
					ParticleEffect("gred_40mm",net.ReadVector(),net.ReadAngle(),nil)
				else
					ParticleEffect("gred_40mm_airburst",net.ReadVector(),Angle(-90,0,0),nil)
				end
			end
		else
			if GetConVar("gred_cl_nowaterimpacts"):GetInt() == 1 then return end
			local cal = net.ReadString()
			if cal == "wac_base_7mm" then
				ParticleEffect("doi_impact_water",net.ReadVector(),Angle(-90,zero,zero),nil)
			elseif cal == "wac_base_12mm" then
				ParticleEffect("impact_water",net.ReadVector(),Angle(-90,zero,zero),nil)
			elseif cal == "wac_base_20mm" then
				ParticleEffect("water_small",net.ReadVector(),Angle(threeZ),nil)
			elseif cal == "wac_base_30mm" or cal == "wac_base_40mm" then
				ParticleEffect("water_medium",net.ReadVector(),Angle(threeZ),nil)
			end
		end
	end)

	net.Receive("gred_net_wac_fire", function()
		
	end)
	
	net.Receive("gred_net_wac_explosion", function()
		if GetConVar("gred_cl_wac_explosions"):GetInt() <= 0 then return end
		ParticleEffect(net.ReadString(),net.ReadVector(),net.ReadAngle(),nil)
	end)

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
	
	net.Receive("gred_net_wac_mg_muzzle_fx",function()
		if GetConVar("gred_cl_altmuzzleeffect"):GetInt() == 1 then
			local pos = net.ReadVector()
			local ang = net.ReadAngle()
			ParticleEffect("muzzleflash_sparks_variant_6",pos,ang,nil)
			ParticleEffect("muzzleflash_1p_glow",pos,ang,nil)
			ParticleEffect("muzzleflash_m590_1p_core",pos,ang,nil)
			ParticleEffect("muzzleflash_smoke_small_variant_1",pos,ang,nil)
		else
			local effectdata=EffectData()
			effectdata:SetOrigin(net.ReadVector())
			effectdata:SetAngles(net.ReadAngle())
			effectdata:SetEntity(self)
			effectdata:SetScale(1)
			util.Effect("MuzzleEffect", effectdata)
		end
	end)
	
	
	net.Receive("gred_net_wac_gunner_muzzle_fx",function()
		if GetConVar("gred_cl_altmuzzleeffect"):GetInt() == 1 then
			local pos = net.ReadVector()
			local ang = net.ReadAngle()
			ParticleEffect("muzzleflash_sparks_variant_6",pos,ang,nil)
			ParticleEffect("muzzleflash_1p_glow",pos,ang,nil)
			ParticleEffect("muzzleflash_m590_1p_core",pos,ang,nil)
			ParticleEffect("muzzleflash_smoke_small_variant_1",pos,ang,nil)
		else
			local effectdata=EffectData()
			effectdata:SetOrigin(net.ReadVector())
			effectdata:SetAngles(net.ReadAngle())
			effectdata:SetEntity(self)
			effectdata:SetScale(1)
			util.Effect("MuzzleEffect", effectdata)
		end
	end)
end

if CLIENT then
	timer.Simple(5,function()
		GredwitchBase=steamworks.ShouldMountAddon(1582297878) and steamworks.IsSubscribed(1582297878)
		if !GredwitchBase then
			GredFrame=vgui.Create('DFrame')
			GredFrame:SetTitle("Grediwtch's Base (materials) is not installed / enabled")
			GredFrame:SetSize(ScrW()*0.95, ScrH()*0.95)
			GredFrame:SetPos((ScrW() - GredFrame:GetWide()) / 2, (ScrH() - GredFrame:GetTall()) / 2)
			GredFrame:MakePopup()
			
			local h=vgui.Create('DHTML')
			h:SetParent(GredFrame)
			h:SetPos(GredFrame:GetWide()*0.005, GredFrame:GetTall()*0.03)
			local x,y = GredFrame:GetSize()
			h:SetSize(x*0.99,y*0.96)
			h:SetAllowLua(true)
			h:OpenURL('https://steamcommunity.com/sharedfiles/filedetails/?id=1582297878.html')
		end
	end)
end

-- hook.Add("Tick","gred_wac_think_override",function()
	-- for _,ent in pairs(ents.GetAll()) do
		-- if ent.Base == "wac_hc_base" and SERVER then
			-- if GetConVar("gred_sv_wac_override"):GetInt() == 1 then
				-- GredOverrideWacThink(ent)
			-- end
		-- end
	-- end
-- end)

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
						local effect = "doi_petrol_explosion"
						if radius <= 300 then
							net.Start("gred_net_wac_explosion")
								net.WriteString(effect)
								net.WriteVector(pos)
								net.WriteAngle(hitang)
							net.Broadcast()
							ent:SetVar("MAX_RANGE",600)
						elseif radius <= 500 then
							net.Start("gred_net_wac_explosion")
								net.WriteString(effect)
								net.WriteVector(pos)
								net.WriteAngle(hitang)
							net.Broadcast()
							net.Start("gred_net_wac_explosion")
								net.WriteString(effect)
								net.WriteVector(pos)
								net.WriteAngle(hitang+Angle(0,45,45))
							net.Broadcast()
							net.Start("gred_net_wac_explosion")
								net.WriteString(effect)
								net.WriteVector(pos)
								net.WriteAngle(hitang+Angle(0,-45,-45))
							net.Broadcast()
							net.Start("gred_net_wac_explosion")
								net.WriteString(effect)
								net.WriteVector(pos)
								net.WriteAngle(hitang+Angle(45,0,0))
							net.Broadcast()
							net.Start("gred_net_wac_explosion")
								net.WriteString(effect)
								net.WriteVector(pos)
								net.WriteAngle(hitang+Angle(-45,0,0))
							net.Broadcast()
							ent:SetVar("MAX_RANGE",800)
						elseif radius <= 2000 then
							net.Start("gred_net_wac_explosion")
								net.WriteString(effect)
								net.WriteVector(pos)
								net.WriteAngle(hitang)
							net.Broadcast()
							net.Start("gred_net_wac_explosion")
								net.WriteString(effect)
								net.WriteVector(pos)
								net.WriteAngle(hitang+Angle(0,45,45))
							net.Broadcast()
							net.Start("gred_net_wac_explosion")
								net.WriteString(effect)
								net.WriteVector(pos)
								net.WriteAngle(hitang+Angle(0,-45,-45))
							net.Broadcast()
							net.Start("gred_net_wac_explosion")
								net.WriteString(effect)
								net.WriteVector(pos)
								net.WriteAngle(hitang+Angle(45,0,0))
							net.Broadcast()
							net.Start("gred_net_wac_explosion")
								net.WriteString(effect)
								net.WriteVector(pos)
								net.WriteAngle(hitang+Angle(-45,0,0))
							net.Broadcast()
									
									
							net.Start("gred_net_wac_explosion")
								net.WriteString(effect)
								net.WriteVector(pos+Vector(math.random(-400,-250),math.random(-400,-250),0))
								net.WriteAngle(hitang)
							net.Broadcast()
							net.Start("gred_net_wac_explosion")
								net.WriteString(effect)
								net.WriteVector(pos+Vector(math.random(-400,250),math.random(-400,250),0))
								net.WriteAngle(hitang+Angle(0,45,45))
							net.Broadcast()
							net.Start("gred_net_wac_explosion")
								net.WriteString(effect)
								net.WriteVector(pos+Vector(math.random(400,-250),math.random(400,-250),0))
								net.WriteAngle(hitang+Angle(0,-45,-45))
							net.Broadcast()
							net.Start("gred_net_wac_explosion")
								net.WriteString(effect)
								net.WriteVector(pos+Vector(math.random(400,250),math.random(400,250),0))
								net.WriteAngle(hitang+Angle(45,0,0))
							net.Broadcast()
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
									net.Start("gred_net_wac_explosion")
										net.WriteString(water)
										net.WriteVector(tr.HitPos)
										net.WriteAngle(ang)
									net.Broadcast()
								else
									net.Start("gred_net_wac_explosion")
										net.WriteString(water)
										net.WriteVector(tr.HitPos+Vector(math.random(500,250),math.random(500,250),0))
										net.WriteAngle(ang)
									net.Broadcast()
									net.Start("gred_net_wac_explosion")
										net.WriteString(water)
										net.WriteVector(tr.HitPos+Vector(math.random(500,250),math.random(-500,-250),0))
										net.WriteAngle(ang)
									net.Broadcast()
									net.Start("gred_net_wac_explosion")
										net.WriteString(water)
										net.WriteVector(tr.HitPos+Vector(math.random(-500,-250),math.random(500,250),0))
										net.WriteAngle(ang)
									net.Broadcast()
									net.Start("gred_net_wac_explosion")
										net.WriteString(water)
										net.WriteVector(tr.HitPos+Vector(math.random(-500,-250),math.random(-500,-250),0))
										net.WriteAngle(ang)
									net.Broadcast()
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
						
						if self.ShouldRotate and self.topRotor and self.Base != "wac_pl_base" and !self.disabled
						and self.rotorRpm > 0.2 and GetConVar("gred_sv_wac_heli_spin"):GetInt() >= 1 then
							local p = self:GetPhysicsObject()
							if p and IsValid(p) then
								if !self.sounds.crashsnd:IsPlaying() then
									self.sounds.crashsnd:Play()
								end
								self.sounds.bipsnd:Play()
								
								local v = p:GetAngleVelocity()
								if v.z < 150 then
									p:AddAngleVelocity(Vector(0,0,10))
								end
								if p:GetVelocity().z > -300 then
									p:AddVelocity(Vector(0,0,7*-(15*self.rotorRpm)))
								end
								if v.y > -50 then
									p:AddAngleVelocity(Vector(0,-13,0))
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
											local water = "ins_water_explosion"
											if radius <= 600 then
												net.Start("gred_net_wac_explosion")
													net.WriteString(water)
													net.WriteVector(tr.HitPos)
													net.WriteAngle(ang)
												net.Broadcast()
											else
												net.Start("gred_net_wac_explosion")
													net.WriteString(water)
													net.WriteVector(tr.HitPos+Vector(math.random(500,250),math.random(500,250),0))
													net.WriteAngle(ang)
												net.Broadcast()
												net.Start("gred_net_wac_explosion")
													net.WriteString(water)
													net.WriteVector(tr.HitPos+Vector(math.random(500,250),math.random(-500,-250),0))
													net.WriteAngle(ang)
												net.Broadcast()
												net.Start("gred_net_wac_explosion")
													net.WriteString(water)
													net.WriteVector(tr.HitPos+Vector(math.random(-500,-250),math.random(500,250),0))
													net.WriteAngle(ang)
												net.Broadcast()
												net.Start("gred_net_wac_explosion")
													net.WriteString(water)
													net.WriteVector(tr.HitPos+Vector(math.random(-500,-250),math.random(-500,-250),0))
													net.WriteAngle(ang)
												net.Broadcast()
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