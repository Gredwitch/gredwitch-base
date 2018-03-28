AddCSLuaFile()

local materials={		

	[MAT_CONCRETE]		=	1,
	[MAT_WARPSHIELD]	=	1,
	[MAT_DEFAULT]		=	1,
	[MAT_EGGSHELL]		=	1,
	
	[MAT_DIRT]			=	2,
	
	[MAT_ALIENFLESH]	=	3,
	[MAT_ANTLION]		=	3,
	[MAT_BLOODYFLESH]	=	3,
	[MAT_FLESH]			=	3,
	
	[MAT_GLASS]			=	4,
	
	[MAT_METAL]			=	5,
	[MAT_CLIP]			=	5,
	[MAT_COMPUTER]		=	5,
	[MAT_VENT]			=	5,
	[MAT_GRATE]			=	5,
	
	[MAT_SAND]			=	6,
	
	[MAT_SNOW]			=	7,
	
	[MAT_SLOSH]			=	8,
	
	[MAT_WOOD]			=	9,
	[MAT_FOLIAGE]		=	9,
	
	[MAT_GRASS]			=	10,
	
	[MAT_TILE]			=	11,
	
	[MAT_PLASTIC]		=	12,
}

local sounds={

	[1] = "impactsounds/7mm_concrete_01",
	[2] = "impactsounds/7mm_dirt_01",
	[3] = "impactsounds/7mm_flesh_01",
	[4] = "impactsounds/7mm_glass_01",
	[5] = "impactsounds/7mm_metal_01",
	[6] = "impactsounds/7mm_sand_01",
	[7] = "impactsounds/7mm_snow_01",
	[8] = "impactsounds/water_bullet_impact_01",
	[9] = "impactsounds/7mm_wood_01",
}

function EFFECT:Init(data)

	local HitEnt = data:GetEntity()
	self.Pos = data:GetOrigin()
	self.Ang = data:GetAngles() + Angle(270,0,0)
	local HitMat = data:GetSurfaceProp()

	self.Fancy = true
	if     materials[HitMat] == 1 then
		self:Concrete()
	elseif materials[HitMat] == 2 then
		self:Dirt()
	elseif materials[HitMat] == 3 then
		self:Blood()
	elseif materials[HitMat] == 4 then
		self:Glass()
	elseif materials[HitMat] == 5 then
		self:Metal()
	elseif materials[HitMat] == 6 then
		self:Sand()
	elseif materials[HitMat] == 7 then
		self:Snow()
	elseif materials[HitMat] == 8 then
		self:Water()
	elseif materials[HitMat] == 9 then
		self:Wood()
	elseif materials[HitMat] == 10 then
		self:Grass()
	elseif materials[HitMat] == 11 then
		self:Tile()
	elseif materials[HitMat] == 12 then
		self:Plastic()
	else
		self:Asphalt()
	end
	print(materials[HitMat])
end

function EFFECT:Concrete()
	ParticleEffect("doi_impact_concrete",self.Pos,self.Ang,nil)
end
 
function EFFECT:Dirt()
	ParticleEffect("doi_impact_dirt",self.Pos,self.Ang,nil)
	
end

function EFFECT:Blood()
	--ParticleEffect("doi_impact_glass",self.Pos,self.Ang,nil)
end

function EFFECT:Glass()
	ParticleEffect("doi_impact_glass",self.Pos,self.Ang,nil)
end

function EFFECT:Metal()
	ParticleEffect("doi_impact_metal",self.Pos,self.Ang,nil)
end

function EFFECT:Sand()
	ParticleEffect("doi_impact_sand",self.Pos,self.Ang,nil)
end

function EFFECT:Snow()
	ParticleEffect("doi_impact_snow",self.Pos,self.Ang,nil)
end

function EFFECT:Water()
	ParticleEffect("doi_impact_water",self.Pos,self.Ang,nil)
end

function EFFECT:Wood()
	ParticleEffect("doi_impact_wood",self.Pos,self.Ang,nil)
end

function EFFECT:Grass()
	ParticleEffect("doi_impact_grass",self.Pos,self.Ang,nil)
end

function EFFECT:Tile()
	ParticleEffect("doi_impact_tile",self.Pos,self.Ang,nil)
end

function EFFECT:Plastic()
	ParticleEffect("doi_impact_plastic",self.Pos,self.Ang,nil)
end

function EFFECT:Asphalt()
	ParticleEffect("doi_impact_asphalt",self.Pos,self.Ang,nil)
end

function EFFECT:Think() return false end
function EFFECT:Render() 			 end
