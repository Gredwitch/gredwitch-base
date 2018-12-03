AddCSLuaFile()

DEFINE_BASECLASS( "base_anim" )

ENT.Spawnable		            	 =  false
ENT.AdminSpawnable		             =  false     

ENT.PrintName		                 =  ""        
ENT.Author			                 =  ""      
ENT.Contact			                 =  ""      

ENT.GBOWNER                          =  nil            
ENT.MAX_RANGE                        = 0
ENT.SHOCKWAVE_INCREMENT              = 0
ENT.DELAY                            = 0
ENT.NOFARSOUND                       = 0
ENT.SOUND                            = ""
ENT.SOUNDFAR                         = ""
ENT.SOUNDCLOSE                       = ""



function ENT:Initialize()
     if (SERVER) then
		 self.FILTER                           = {}
         self:SetModel("models/mm1/box.mdl")
	     self:SetSolid( SOLID_NONE )
	     self:SetMoveType( MOVETYPE_NONE )
	     self:SetUseType( ONOFF_USE ) 
		 self.Bursts		 = 0
		 self.CURRENTRANGE	 = 0
		 self.GBOWNER		 = self:GetVar("GBOWNER")
		 self.NOFARSOUND	 = self:GetVar("NOFARSOUND")
		 
		 self.SOUNDCLOSE 	 = self:GetVar("SOUNDCLOSE")
		 self.SOUND 		 = self:GetVar("SOUND")
		 self.SOUNDFAR  	 = self:GetVar("SOUNDFAR")
     end
end


function ENT:Think()
    if (SERVER) then
		if !self:IsValid() then return end
		local pos = self:GetPos()
		self.CURRENTRANGE = (self.CURRENTRANGE+(self.SHOCKWAVE_INCREMENT*5)) / GetConVar("gred_sv_soundspeed_divider"):GetInt()
		for k, v in pairs(ents.FindInSphere(pos,(self.CURRENTRANGE*5))) do
			 if v:IsPlayer() then
			 
				if !(table.HasValue(self.FILTER,v)) then
					if v:GetInfoNum("gred_sound_shake",1) == 1 then
						util.ScreenShake(v:GetPos(),9999999,55,1.5,50)
					end
					net.Start("gred_net_sound_lowsh")
						net.WriteString(self.SOUNDCLOSE)
					net.Send(v)
					v:SetNWString("sound", self.SOUNDCLOSE)
					table.insert(self.FILTER, v)
				end
			end
		end
		for k, v in pairs(ents.FindInSphere(pos,self.CURRENTRANGE*14)) do 
			if v:IsPlayer() then
				if !(table.HasValue(self.FILTER,v)) then
					if self.NOFARSOUND == 0 then
						net.Start("gred_net_sound_lowsh")
							net.WriteString(self.SOUND)
						net.Send(v)
						v:SetNWString("sound", self.SOUND)
					elseif self.NOFARSOUND == 1 then
						net.Start("gred_net_sound_lowsh")
							net.WriteString(self.SOUNDCLOSE)
						net.Send(v)
						v:SetNWString("sound", self.SOUNDCLOSE)
					end
					table.insert(self.FILTER, v)
					if v:GetInfoNum("gred_sound_shake",1) == 1 then
						util.ScreenShake(v:GetPos(),9999999,55,1.5,50)
					end
				end
			end
		end
		for k, v in pairs(ents.FindInSphere(pos,self.CURRENTRANGE+(self.CURRENTRANGE*40))) do
			 if v:IsPlayer() then
				if !(table.HasValue(self.FILTER,v)) then
					if self.NOFARSOUND == 0 then
							net.Start("gred_net_sound_lowsh")
								net.WriteString(self.SOUNDFAR)
							net.Send(v)
							v:SetNWString("sound", self.SOUNDFAR)
					elseif self.NOFARSOUND == 1 then
							net.Start("gred_net_sound_lowsh")
								net.WriteString(self.SOUNDCLOSE)
							net.Send(v)
							v:SetNWString("sound", self.SOUNDCLOSE)
					end
					table.insert(self.FILTER, v)
				end
			end
		end
		self:Remove()
	end
end

function ENT:OnRemove()
	if SERVER then
		if self.FILTER==nil then return end
		for k, v in pairs(self.FILTER) do
			if !v:IsValid() then return end
			v:SetNWBool("waiting", true)
		end
	end
end

function ENT:Draw()
     return false
end