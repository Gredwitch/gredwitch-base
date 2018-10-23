ENT.Type 			= "anim"
-- ENT.Base 			= "base_gmodentity"
ENT.Author 			= "Gredwich"
ENT.Category 		= ""
ENT.Spawnable		= false
ENT.AdminSpawnable  = false
ENT.FuzeTime		= 0
-- ENT.Caliber			= ""
ENT.tr				= nil
local zero = 0
local threeZ = zero,zero,zero
local audioSpecs = 100, 100,1, CHAN_AUTO
local null = ""

if SERVER then
	util.AddNetworkString("gred_net_impact_fx") 
end
