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


util.PrecacheModel("models/gredwitch/bullet.mdl")

if SERVER then 
	util.AddNetworkString("gred_net_explosion_fx")
	util.AddNetworkString("gred_net_impact_fx")
	util.AddNetworkString("gred_net_wac_explosion")
	util.AddNetworkString("gred_net_wac_fire")
	util.AddNetworkString("gred_net_message_ply")
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
end