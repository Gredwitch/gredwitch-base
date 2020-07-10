ENT.Spawnable		            	=  false
ENT.AdminSpawnable		            =  false

ENT.PrintName		                =  "Gredwitch's Shell base"
ENT.Author			                =  "Gredwitch"
ENT.Contact			                =  "qhamitouche@gmail.com"
ENT.Category                        =  "Gredwitch's Stuff"
ENT.Base							=	"base_rocket"

ENT.Model							=	"models/gredwitch/bombs/75mm_shell.mdl"
ENT.IsShell							=	true
ENT.MuzzleVelocity					=	0
ENT.Caliber							=	0
ENT.RSound							=	0
ENT.ShellType						=	""
ENT.EffectWater						=	"ins_water_explosion"
ENT.Normalization					=	0
ENT.NextUse 						=	0

ENT.IS_AP = {
	["AP"] = true,
	["APC"] = true,
	["APBC"] = true,
	["APCBC"] = true,
	
	["APHE"] = true,
	["APHEBC"] = true,
	["APHECBC"] = true,
	
	["APCR"] = true,
	["APDS"] = true,
	["APFSDS"] = true,
}

ENT.IS_APHE = {
	["APHE"] = true,
	["APHEBC"] = true,
	["APHECBC"] = true,
}

ENT.IS_APCR = {
	["APCR"] = true,
	["APDS"] = true,
	["APFSDS"] = true,
}

ENT.IS_HEAT = {
	["HEAT"] = true,
	["HEATFS"] = true,
}

gred = gred or {}
gred.IS_AP = ENT.IS_AP
gred.IS_APHE = ENT.IS_APHE
gred.IS_APCR = ENT.IS_APCR
gred.IS_HEAT = ENT.IS_HEAT

ENT.SLOPE_MULTIPLIERS = { -- https://docs.google.com/spreadsheets/d/e/2PACX-1vTtcFbCkmSUgVO4MIjy0QsehaJ0Fn00pL7HE1x7utLO04rkHmimeGtcc1i92s4u1HgV2wV6TAaP0AVj/pubhtml?gid=0&single=true
	["APBC"] = {
		[10] = {
			["a"] = 1.039,
			["b"] = 0.01555,
		},
		[15] = {
			["a"] = 1.055,
			["b"] = 0.02315,
		},
		[20] = {
			["a"] = 1.077,
			["b"] = 0.03448,
		},
		[25] = {
			["a"] = 1.108,
			["b"] = 0.05134,
		},
		[30] = {
			["a"] = 1.155,
			["b"] = 0.0771,
		},
		[35] = {
			["a"] = 1.217,
			["b"] = 0.11384,
		},
		[40] = {
			["a"] = 1.313,
			["b"] = 0.16952,
		},
		[45] = {
			["a"] = 1.441,
			["b"] = 0.24604,
		},
		[50] = {
			["a"] = 1.682,
			["b"] = 0.3791,
		},
		[55] = {
			["a"] = 2.11,
			["b"] = 0.056444,
		},
		[60] = {
			["a"] = 3.497,
			["b"] = 1.07411,
		},
		[65] = {
			["a"] = 5.335,
			["b"] = 1.46188,
		},
		[70] = {
			["a"] = 9.477,
			["b"] = 1.8152,
		},
		[75] = {
			["a"] = 20.22,
			["b"] = 2.19155,
		},
		[80] = {
			["a"] = 56.2,
			["b"] = 2.5621,
		},
		[85] = {
			["a"] = 221.3,
			["b"] = 2.93265,
		},
	},
	["APCBC"] = {
		[10] = {
			["a"] = 1.0243,
			["b"] = 0.0225,
		},
		[15] = {
			["a"] = 1.0532,
			["b"] = 0.0327,
		},
		[20] = {
			["a"] = 1.1039,
			["b"] = 0.0454,
		},
		[25] = {
			["a"] = 1.1741,
			["b"] = 0.0549,
		},
		[30] = {
			["a"] = 1.2667,
			["b"] = 0.0655,
		},
		[35] = {
			["a"] = 1.3925,
			["b"] = 0.0993,
		},
		[40] = {
			["a"] = 1.5642,
			["b"] = 0.1388,
		},
		[45] = {
			["a"] = 1.7933,
			["b"] = 0.1655,
		},
		[50] = {
			["a"] = 2.1053,
			["b"] = 0.2035,
		},
		[55] = {
			["a"] = 2.5368,
			["b"] = 0.2427,
		},
		[60] = {
			["a"] = 3.0796,
			["b"] = 0.245,
		},
		[65] = {
			["a"] = 4.0041,
			["b"] = 0.3354,
		},
		[70] = {
			["a"] = 5.0803,
			["b"] = 0.3478,
		},
		[75] = {
			["a"] = 6.67445,
			["b"] = 0.3831,
		},
		[80] = {
			["a"] = 9.0598,
			["b"] = 0.4131,
		},
		[85] = {
			["a"] = 12.8207,
			["b"] = 0.455,
		},
	},
	["AP"] = {
		[10] = {
			["a"] = 0.98297,
			["b"] = 0.0637,
		},
		[15] = {
			["a"] = 1.00066,
			["b"] = 0.0969,
		},
		[20] = {
			["a"] = 1.0361,
			["b"] = 0.13561,
		},
		[25] = {
			["a"] = 1.1116,
			["b"] = 0.16164,
		},
		[30] = {
			["a"] = 1.2195,
			["b"] = 0.19702,
		},
		[35] = {
			["a"] = 1.3771,
			["b"] = 0.22456,
		},
		[40] = {
			["a"] = 1.6263,
			["b"] = 0.26313,
		},
		[45] = {
			["a"] = 2.0033,
			["b"] = 0.34171,
		},
		[50] = {
			["a"] = 2.6447,
			["b"] = 0.57353,
		},
		[55] = {
			["a"] = 3.231,
			["b"] = 0.69075,
		},
		[60] = {
			["a"] = 4.0708,
			["b"] = 0.81826,
		},
		[65] = {
			["a"] = 6.2655,
			["b"] = 0.9192,
		},
		[70] = {
			["a"] = 8.6492,
			["b"] = 1.00539,
		},
		[75] = {
			["a"] = 13.7512,
			["b"] = 1.074,
		},
		[80] = {
			["a"] = 21.8713,
			["b"] = 1.17973,
		},
		[85] = {
			["a"] = 34.4862,
			["b"] = 1.28631,
		},
	},
}
ENT.SLOPE_MULTIPLIERS.APHE = ENT.SLOPE_MULTIPLIERS.AP
ENT.SLOPE_MULTIPLIERS.APC = ENT.SLOPE_MULTIPLIERS.APCBC
ENT.SLOPE_MULTIPLIERS.APHECBC = ENT.SLOPE_MULTIPLIERS.APCBC
ENT.SLOPE_MULTIPLIERS.APHEBC = ENT.SLOPE_MULTIPLIERS.APBC

ENT.TRACERCOLOR_TO_INT = {
	["white"] = 1,
	["red"] = 2,
	["green"] = 3,
	["blue"] = 4,
	["yellow"] = 5,
}
ENT.TRACERCOLOR_TO_VECTOR = {
	Vector(255,255,255),
	Vector(255,0,0),
	Vector(0,255,0),
	Vector(0,0,255),
	Vector(255,255,255),
}



function ENT:SetupDataTables()
	self:NetworkVar("Bool",0,"Fired")
	self:NetworkVar("String",0,"ShellType")
	self:NetworkVar("Int",0,"TracerColor")
	self:NetworkVar("Int",1,"Caliber")
end
