include('shared.lua')
local zero = 0
local threeZ = zero,zero,zero
local audioSpecs = 100, 100,1, CHAN_AUTO
local null = ""

function ENT:Draw()
	self:DrawModel()
end

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