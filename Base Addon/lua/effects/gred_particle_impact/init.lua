function EFFECT:Init(data)
	local pos = data:GetOrigin()
	local ang = data:GetAngles()
	local cal = gred.Calibre[data:GetFlags()]
	local isGroundImpact = data:GetMaterialIndex() == 1
	
	if isGroundImpact then
		if cal == "wac_base_7mm" then
			if GetConVar("gred_cl_noparticles_7mm"):GetInt() == 1 then return end
			if GetConVar("gred_cl_insparticles"):GetInt() == 1 then pcfD = "ins_" else pcfD = "doi_" end
			local mat = data:GetSurfaceProp()
			if mat == 1 then
				ParticleEffect(""..pcfD.."impact_concrete",pos,ang,nil)
			elseif mat == 2 then
				ParticleEffect(""..pcfD.."impact_dirt",pos,ang,nil)
					
			elseif mat == 4 then
				ParticleEffect(""..pcfD.."impact_glass",pos,ang,nil)
					
			elseif mat == 5 then
				ParticleEffect(""..pcfD.."impact_metal",pos,ang,nil)
					
			elseif mat == 6 then
				ParticleEffect(""..pcfD.."impact_sand",pos,ang,nil)
					
			elseif mat == 7 then
				ParticleEffect(""..pcfD.."impact_snow",pos,ang,nil)
					
			elseif mat == 8 then
				ParticleEffect(""..pcfD.."impact_leaves",pos,ang,nil)
					
			elseif mat == 9 then
				ParticleEffect(""..pcfD.."impact_wood",pos,ang,nil)
					
			elseif mat == 10 then
				ParticleEffect(""..pcfD.."impact_grass",pos,ang,nil)
					
			elseif mat == 11 then
				ParticleEffect(""..pcfD.."impact_tile",pos,ang,nil)
					
			elseif mat == 12 then
				ParticleEffect(""..pcfD.."impact_plastic",pos,ang,nil)
					
			elseif mat == 13 then
				ParticleEffect(""..pcfD.."impact_rock",pos,ang,nil)
					
			elseif mat == 14 then
				ParticleEffect(""..pcfD.."impact_gravel",pos,ang,nil)
					
			elseif mat == 15 then
				ParticleEffect(""..pcfD.."impact_mud",pos,ang,nil)
				
			elseif mat == 16 then
				ParticleEffect(""..pcfD.."impact_fruit",pos,ang,nil)
					
			elseif mat == 17 then
				ParticleEffect(""..pcfD.."impact_asphalt",pos,ang,nil)
					
			elseif mat == 18 then
				ParticleEffect(""..pcfD.."impact_cardboard",pos,ang,nil)
					
			elseif mat == 19 then
				ParticleEffect(""..pcfD.."impact_rubber",pos,ang,nil)
					
			elseif mat == 20 then
				ParticleEffect(""..pcfD.."impact_carpet",pos,ang,nil)
					
			elseif mat == 21 then
				ParticleEffect(""..pcfD.."impact_brick",pos,ang,nil)
					
			elseif mat == 22 then
				ParticleEffect(""..pcfD.."impact_leaves",pos,ang,nil)
					
			elseif mat == 23 then
				ParticleEffect(""..pcfD.."impact_paper",pos,ang,nil)
					
			elseif mat == 24 then
				ParticleEffect(""..pcfD.."impact_computer",pos,ang,nil)
			else
			
			end
		elseif cal == "wac_base_12mm" then
			if GetConVar("gred_cl_noparticles_12mm"):GetInt() == 1 then return end
			ParticleEffect("doi_gunrun_impact",pos,ang,nil)
		elseif cal == "wac_base_20mm" then
			if GetConVar("gred_cl_noparticles_20mm"):GetInt() == 1 then return end
			
			if data:GetSurfaceProp() == 0 then
				ParticleEffect("gred_20mm",pos,ang,nil)
			else
				ParticleEffect("gred_20mm_airburst",pos,Angle(90),nil)
			end
		elseif cal == "wac_base_30mm" then
			if GetConVar("gred_cl_noparticles_30mm"):GetInt() == 1 then return end
			ParticleEffect("30cal_impact",pos,ang,nil)
		elseif cal == "wac_base_40mm" then
			if GetConVar("gred_cl_noparticles_40mm"):GetInt() == 1 then return end
			if data:GetSurfaceProp() == 0 then
				ParticleEffect("gred_40mm",pos,ang,nil)
			else
				ParticleEffect("gred_40mm_airburst",pos,ang-Angle(90),nil)
			end
		end
	else
		if GetConVar("gred_cl_nowaterimpacts"):GetInt() == 1 then return end
		if cal == "wac_base_7mm" then
			ParticleEffect("doi_impact_water",pos,Angle(-90),nil)
		elseif cal == "wac_base_12mm" then
			ParticleEffect("ins_impact_water",pos,Angle(-90),nil)
		elseif cal == "wac_base_20mm" then
			ParticleEffect("water_small",pos,ang,nil)
		elseif cal == "wac_base_30mm" or cal == "wac_base_40mm" then
			ParticleEffect("water_medium",pos,ang,nil)
		end
	end
end

function EFFECT:Think()
	return false
end

function EFFECT:Render()
end