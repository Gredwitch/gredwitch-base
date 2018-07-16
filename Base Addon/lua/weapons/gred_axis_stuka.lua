AddCSLuaFile()
SWEP.Base 						= "gred_base_arti_swep"

SWEP.Spawnable					= true
SWEP.AdminSpawnable				= true

SWEP.Category					= "Gredwitch's SWEPs"
SWEP.Author						= "Gredwitch"
SWEP.Contact					= "qhamitouche@gmail.com"
SWEP.Purpose					= "Destroy the enemy"
SWEP.Instructions				= "Right ckick to look through the binoculars, left click to call in a strike."

SWEP.PrintName					= "[AXIS]Stuka Strike"
SWEP.strikedalay				= 5
SWEP.strikeentity     	  		= "gb_bomb_sc250"
SWEP.Primary.Ammo				= "Axis radio battery"
SWEP.ShellCount					= 1
SWEP.Team						= "Axis"
SWEP.StrikeString				= "Stuka"
SWEP.Bomber						= true

SWEP.SoundName					= "/radio/axis/stukadivebegin"
SWEP.SndPossibilities			= 5
SWEP.SndFormat					= ".ogg"

function SWEP:PrimaryAttack()
	if !self:CanPrimaryAttack() then return end
	
	self.Weapon:EmitSound(self.SoundName..(math.random(1,self.SndPossibilities))..self.SndFormat)
	self.Owner:ChatPrint("[GREDWITCH'S SWEPS]"..self.StrikeString.." strike begins in "..(self.strikedalay).." seconds")
	self.Weapon:SendWeaponAnim(ACT_VM_PRIMARYATTACK)
	self:TakePrimaryAmmo(1)
	
	if SERVER then
		local PlayerPos = self.Owner:GetShootPos()
		local PlayerAng = self.Owner:GetAimVector()
		
		local trace = {}
		trace.start = PlayerPos + PlayerAng*16
		trace.endpos = PlayerPos + PlayerAng*65536
		trace.filter = {self.Owner}
		local hitpos = util.TraceLine(trace).HitPos
		
		trace.start = hitpos + Vector(0,0,2048)
		trace.endpos = trace.start + Vector(0,0,6144)
		local traceRes = util.TraceLine(trace)
		local spawnpos
		
		local spawnpos
		if traceRes.Hit then
			spawnpos = traceRes.HitPos - Vector(0,0,64) + Vector(0,0,GetConVar("gred_sv_arti_spawnaltitude"):GetInt())
		else
			spawnpos = hitpos + Vector(0,0,GetConVar("gred_sv_arti_spawnaltitude"):GetInt())
		end
		
		local ArtiStrike = ents.Create("gred_arti_ent")
		ArtiStrike:SetPos(spawnpos)
		ArtiStrike.ShellType		= self.strikeentity
		ArtiStrike.Delay	    	= self.strikedalay
		ArtiStrike.ShellCount		= self.ShellCount
		ArtiStrike.RandomPos		= 0
		ArtiStrike.Owner			= self.Owner
		ArtiStrike.Team				= self.Team
		ArtiStrike.StrikeString 	= self.StrikeString
		ArtiStrike.FireRate			= self.ShellCount
		ArtiStrike.LoopTimerTime1	= 15
		ArtiStrike.LoopTimerTime2	= 15
		ArtiStrike:Spawn()
		ArtiStrike:Activate() 
	end
end