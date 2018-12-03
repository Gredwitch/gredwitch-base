AddCSLuaFile()

DEFINE_BASECLASS( "base_fire" )


ENT.Base							 =	"base_anim"
ENT.Spawnable		            	 =  false
ENT.AdminSpawnable		             =  false     

ENT.PrintName		                 =  "Gas"        
ENT.Author			                 =  ""      
ENT.Contact			                 =  ""      

ENT.GBOWNER                          =  nil            
ENT.DAMAGE_MUL						 = 1
ENT.Radius							 = 1400
ENT.Lifetime						 = 18
ENT.Damage							 = 20,50
ENT.Rate							 = 0.5

if SERVER then
function ENT:Initialize()
	self:SetModel("models/mm1/box.mdl")
	self:SetSolid(SOLID_NONE)
	self:SetMoveType(MOVETYPE_NONE)
	self.Bursts = 0
	self.GBOWNER = self:GetVar("GBOWNER")
	self.DeathTime = CurTime() + self.Lifetime
end

function ENT:Think()
	if !self:IsValid() then return end
	local ct = CurTime()
	local dmg = DamageInfo()
	dmg:SetDamage(math.random(self.Damage))
	valid = IsValid(self.GBOWNER)
	ovalid = IsValid(self.Owner)
	if !valid and ovalid then self.GBOWNER = self.Owner
	elseif !valid and !ovalid then self.GBOWNER = self end
	dmg:SetAttacker(self.GBOWNER)
	-- debugoverlay.Sphere(self:GetPos(),self.Radius,self.Lifetime,Color( 255, 255, 255 )) 
	for k, v in ipairs(ents.FindInSphere(self:GetPos(),self.Radius)) do
		if v:IsPlayer() or v:IsNPC() and !v:GetNWBool("SH_GasMask") then
			if v:GetClass()=="npc_helicopter" then return end
			v:TakeDamageInfo(dmg)
		end
	end
	if ct >= self.DeathTime then self:Remove() end
	self:NextThink(ct + self.Rate)
end
end