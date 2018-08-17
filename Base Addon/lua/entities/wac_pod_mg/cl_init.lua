include("shared.lua")

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