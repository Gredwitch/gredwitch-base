if SERVER then AddCSLuaFile() end
if CLIENT then
	language.Add("allied_radiobattery", "Allied radio battery")
	language.Add("axis_radiobattery", "Axis radio battery")
end

game.AddAmmoType( {
	name = "Axis radio battery",
	dmgtype = DMG_BULLET
} )
game.AddAmmoType( {
	name = "Allied radio battery",
	dmgtype = DMG_BULLET
} )


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
game.AddParticles( "particles/neuro_tank_ap.pcf")

game.AddParticles( "particles/ins_rockettrail.pcf")
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


util.PrecacheModel("models/gredwitch/bullet.mdl")
