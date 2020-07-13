include("gredwitch/gred_autorun_shared.lua")

local util = util 
local pairs = pairs
local table = table
local istable = istable
local TraceLine = util.TraceLine
local Effect = util.Effect
local MASK_ALL = MASK_ALL
local game = game
local PrecacheParticleSystem = PrecacheParticleSystem
local CreateConVar = CreateConVar
local CreateClientConVar = CreateClientConVar
local tableinsert = table.insert
local IsValid = IsValid
local ply = LocalPlayer()

gred = gred or {}
gred.simfphys = gred.simfphys or {}
gred.CVars = gred.CVars or {}

gred.CVars["gred_cl_resourceprecache"] 						= CreateClientConVar("gred_cl_resourceprecache"						, "0" ,true,false)
gred.CVars["gred_cl_sound_shake"] 							= CreateClientConVar("gred_cl_sound_shake"							, "1" ,true,false)
gred.CVars["gred_cl_nowaterimpacts"] 						= CreateClientConVar("gred_cl_nowaterimpacts"						, "0" ,true,false)
gred.CVars["gred_cl_insparticles"]		 					= CreateClientConVar("gred_cl_insparticles"							, "0" ,true,false)
gred.CVars["gred_cl_noparticles_7mm"] 						= CreateClientConVar("gred_cl_noparticles_7mm"						, "0" ,true,false)
gred.CVars["gred_cl_noparticles_12mm"] 						= CreateClientConVar("gred_cl_noparticles_12mm"						, "0" ,true,false)
gred.CVars["gred_cl_noparticles_20mm"] 						= CreateClientConVar("gred_cl_noparticles_20mm"						, "0" ,true,false)
gred.CVars["gred_cl_noparticles_30mm"] 						= CreateClientConVar("gred_cl_noparticles_30mm"						, "0" ,true,false)
gred.CVars["gred_cl_noparticles_40mm"] 						= CreateClientConVar("gred_cl_noparticles_40mm"						, "0" ,true,false)
gred.CVars["gred_cl_decals"] 								= CreateClientConVar("gred_cl_decals"								, "1" ,true,false)
gred.CVars["gred_cl_altmuzzleeffect"] 						= CreateClientConVar("gred_cl_altmuzzleeffect"						, "0" ,true,false)
gred.CVars["gred_cl_wac_explosions"] 						= CreateClientConVar("gred_cl_wac_explosions" 						, "1" ,true,false)
gred.CVars["gred_cl_enable_popups"] 						= CreateClientConVar("gred_cl_enable_popups"	 					, "1" ,true,false)
gred.CVars["gred_cl_firstload"] 							= CreateClientConVar("gred_cl_firstload"							, "1" ,true,false)
gred.CVars["gred_cl_simfphys_enablecrosshair"]				= CreateClientConVar("gred_cl_simfphys_enablecrosshair"				, "1" ,true,false)
gred.CVars["gred_cl_simfphys_sightsensitivity"] 			= CreateClientConVar("gred_cl_simfphys_sightsensitivity"			,"0.25",true,false)
gred.CVars["gred_cl_simfphys_maxsuspensioncalcdistance"] 	= CreateClientConVar("gred_cl_simfphys_maxsuspensioncalcdistance"	, "85000000" ,true,false)
gred.CVars["gred_cl_simfphys_viewport_fovnodraw"] 			= CreateClientConVar("gred_cl_simfphys_viewport_fovnodraw"			,"15",true,false)
gred.CVars["gred_cl_simfphys_viewport_fovnodraw_vertical"] 	= CreateClientConVar("gred_cl_simfphys_viewport_fovnodraw_vertical"	,"0.75",true,false)
gred.CVars["gred_cl_simfphys_viewport_hq"] 					= CreateClientConVar("gred_cl_simfphys_viewport_hq"					,"0",true,false)
gred.CVars["gred_cl_simfphys_suspensions"] 					= CreateClientConVar("gred_cl_simfphys_suspensions"					, "1" ,true,false)
gred.CVars["gred_cl_simfphys_testviewports"] 				= CreateClientConVar("gred_cl_simfphys_testviewports"				, "0" ,true,false)
gred.CVars["gred_cl_favouritetab"] 							= CreateClientConVar("gred_cl_favouritetab"							, "HOME" ,true,false)
gred.CVars["gred_cl_shell_blur"] 							= CreateClientConVar("gred_cl_shell_blur"							, "1" ,true,false)
gred.CVars["gred_cl_shell_blur_invehicles"] 				= CreateClientConVar("gred_cl_shell_blur_invehicles"				, "1" ,true,false)
gred.CVars["gred_cl_shell_enable_killcam"] 					= CreateClientConVar("gred_cl_shell_enable_killcam"					, "1" ,true,false)

local TAB_PRESS = {FCVAR_ARCHIVE,FCVAR_USERINFO}
gred.CVars["gred_cl_simfphys_key_changeshell"]				= CreateConVar("gred_cl_simfphys_key_changeshell"			, "21",TAB_PRESS)
gred.CVars["gred_cl_simfphys_key_togglesight"]				= CreateConVar("gred_cl_simfphys_key_togglesight"			, "22",TAB_PRESS)
gred.CVars["gred_cl_simfphys_key_togglegun"]				= CreateConVar("gred_cl_simfphys_key_togglegun"				, "23",TAB_PRESS)
gred.CVars["gred_cl_simfphys_key_togglehatch"]				= CreateConVar("gred_cl_simfphys_key_togglehatch"			, "25",TAB_PRESS)
gred.CVars["gred_cl_simfphys_key_togglezoom"]				= CreateConVar("gred_cl_simfphys_key_togglezoom"			, "79",TAB_PRESS)
gred.CVars["gred_cl_simfphys_key_throwsmoke"]				= CreateConVar("gred_cl_simfphys_key_throwsmoke"			, "17",TAB_PRESS)

gred.Precache()
if gred.CVars["gred_cl_resourceprecache"]:GetBool() then
	gred.PrecacheResources()
end


local Created
local NextThink = 0
local NextFind = 0
local id = 0
local SIMFPHYS_COLOR = Color(255,235,0)

surface.CreateFont( "SIMFPHYS_ARMED_HUDFONT", {
	font = "Verdana",
	extended = false,
	size = 20,
	weight = 2000,
	blursize = 0,
	scanlines = 0,
	antialias = true,
	underline = false,
	italic = false,
	strikeout = false,
	symbol = false,
	rotary = false,
	shadow = true,
	additive = false,
	outline = false,
})

local function DrawCircle( X, Y, radius ) -- copyright LunasFlightSchool™
	local segmentdist = 360 / ( 2 * math.pi * radius / 2 )
	
	for a = 0, 360 - segmentdist, segmentdist do
		surface.DrawLine( X + math.cos( math.rad( a ) ) * radius, Y - math.sin( math.rad( a ) ) * radius, X + math.cos( math.rad( a + segmentdist ) ) * radius, Y - math.sin( math.rad( a + segmentdist ) ) * radius )
	end
end

local function gred_settings(CPanel)
	CPanel:ClearControls()
	
	local DButton = vgui.Create("DButton")
	DButton:SetText("Options..")
	DButton.DoClick = function(DButton)
		gred.OpenOptions()
	end
	CPanel:AddItem(DButton)
end

local function CheckForConflicts()
	if steamworks.IsSubscribed("2083101470") and steamworks.ShouldMountAddon("2083101470") then
		local DFrame = vgui.Create("DFrame")
		DFrame:SetSize(ScrW()*0.5,ScrH()*0.5)
		DFrame:SetTitle("Gredwitch's Base : CONFLICTING ADDON FOUND!! PLEASE REMOVE IT IF YOU WANT TO USE MY TANKS")
		DFrame:Center()
		DFrame:MakePopup()
		
		local DButton = vgui.Create("DButton",DFrame)
		DButton:Dock(FILL)
		DButton:SetText("UH OH, YOU HAVE '[simfphys] Trailers Reborn' INSTALLED!\nTHIS WILL CAUSE MAJOR ISSUES WITH GREDWITCH'S SIMFPHYS VEHICLES AND / OR OTHER SIMFPHYS VEHICLES! CLICK HERE TO OPEN THE ADDON PAGE AND REMOVE IT!")
		DButton.DoClick = function()
			gui.OpenURL("https://steamcommunity.com/sharedfiles/filedetails/?id=2083101470")
		end
	end
end

local function CheckForUpdates()
	local CURRENT_VERSION = ""
	local changelogs = file.Exists("changelog.lua","LUA") and file.Read("changelog.lua","LUA") or false
	changelogs = changelogs or (file.Exists("changelog.lua","lsv") and file.Read("changelog.lua","lsv") or "")
	for i = 1,14 do if !changelogs[i] then break end CURRENT_VERSION = CURRENT_VERSION..changelogs[i] end
	local GITHUB_VERSION = "" 
	local GitHub = http.Fetch("https://raw.githubusercontent.com/Gredwitch/gredwitch-base/master/Base%20Addon/lua/changelog.lua",function(body)
		if !body then return end
		for i = 1,14 do GITHUB_VERSION = GITHUB_VERSION..body[i] end
		if CURRENT_VERSION != GITHUB_VERSION then
			local DFrame = vgui.Create("DFrame")
			DFrame:SetSize(ScrW()*0.9,ScrH()*0.9)
			DFrame:SetTitle("GREDWITCH'S BASE IS OUT OF DATE. EXPECT LUA ERRORS!")
			DFrame:Center()
			DFrame:MakePopup()
			
			local DHTML = vgui.Create("DHTML",DFrame)
			DHTML:Dock(FILL)
			DHTML:OpenURL("https://steamcommunity.com/workshop/filedetails/discussion/1131455085/1640915206496685563/")
		end
	end)
	local exists = file.Exists("gredwitch_base.txt","DATA")
	if !exists or (exists and file.Read("gredwitch_base.txt","DATA") != CURRENT_VERSION) then
		local DFrame = vgui.Create("DFrame")
		DFrame:SetSize(ScrW()*0.5,ScrH()*0.5)
		DFrame:SetTitle("Gredwitch's Base : last update changelogs")
		DFrame:Center()
		DFrame:MakePopup()
		
		local DHTML = vgui.Create("DHTML",DFrame)
		DHTML:Dock(FILL)
		DHTML:OpenURL("https://raw.githubusercontent.com/Gredwitch/gredwitch-base/master/Base%20Addon/lua/changelog.lua")
		
		file.Write("gredwitch_base.txt",CURRENT_VERSION)
	end
end

local function CheckDXDiag()
	if GetConVar("mat_dxlevel"):GetInt() < 90 then
		local DFrame = vgui.Create("DFrame")
		DFrame:SetSize(ScrW()*0.9,ScrH()*0.9)
		DFrame:SetTitle("DXDIAG ERROR")
		DFrame:Center()
		DFrame:MakePopup()
		
		local DHTML = vgui.Create("DHTML",DFrame)
		DHTML:Dock(FILL)
		DHTML:OpenURL("https://steamcommunity.com/workshop/filedetails/discussion/1131455085/3166519278505386201/")
	end
end



gred.CheckConCommand = function(cmd,val)
	if !val or !cmd then return end
	net.Start("gred_net_checkconcommand")
		net.WriteString(cmd)
		net.WriteFloat(val)
	net.SendToServer()
end

gred.UpdateBoneTable = function(self)
	if self.CreatingBones then return end
	self.Bones = nil
	timer.Simple(0,function()
		if !self or (self and !IsValid(self)) then return end
		if self.CreatingBones then return end
		self.CreatingBones = true
		self:SetLOD(0)
		self.Bones = {}
		local name
		for i=0, self:GetBoneCount()-1 do
			name = self:GetBoneName(i)
			if name == "__INVALIDBONE__" and ((self.BoneBlackList and !self.BoneBlackList[i]) or !self.BoneBlackList) and i != 0 then
				-- print("["..self.ClassName.."] INVALID BONE : "..i)
				self.Bones = nil
				break
			end
			self.Bones[name] = i
		end
		self:SetLOD(-1)
		self.CreatingBones = false
	end)
end

gred.ManipulateBoneAngles = function(self,bone,angle)
	if !self.Bones or (self.Bones and !self.Bones[bone]) then
		gred.UpdateBoneTable(self)
		return
	end
	
	self:ManipulateBoneAngles(self.Bones[bone],angle)
end

gred.ManipulateBonePosition = function(self,bone,pos)
	if !self.Bones or (self.Bones and !self.Bones[bone]) then
		gred.UpdateBoneTable(self)
		return
	end
	
	self:ManipulateBonePosition(self.Bones[bone],pos)
end

gred.ManipulateBoneScale = function(self,bone,scale)
	if !self.Bones or (self.Bones and !self.Bones[bone]) then
		gred.UpdateBoneTable(self)
		return
	end
	
	self:ManipulateBoneScale(self.Bones[bone],scale)
end

gred.HandleFlyBySound = function(self,ply,ct,minvel,maxdist,delay,snd)
	ply.NGPLAY = ply.NGPLAY or 0
	ply.lfsGetPlane = ply.lfsGetPlane or function() return nil end
	if ply:lfsGetPlane() != self and (ply.NGPLAY < ct) and self:GetEngineActive() then
		local vel = self:GetVelocity():Length()
		if vel >= minvel then
			local plypos = ply:GetPos()
			local pos = self:GetPos()
			local dist = pos:Distance(plypos)
			if dist < maxdist then
				ply.NGPLAY = ct + delay
				ply:EmitSound(snd)
			end
		end
	end
end

gred.HandleVoiceLines = function(self,ply,ct,hp)
	ply.lfsGetPlane = ply.lfsGetPlane or function() return nil end
	self.BumpSound = self.BumpSound or ct
	if self.BumpSound < ct then
		for k,v in pairs(self.SoundQueue) do
			ply:EmitSound(v)
			
			table.RemoveByValue(self.SoundQueue,v)
			self.BumpSound = ct + 4
			break
		end
	end
	
	if self.IsDead then
		local Driver = self:GetDriver()
		if self.CheckDriver and Driver != self.OldDriver and !IsValid(Driver) then
			for k,v in pairs(player.GetAll()) do
				if v:lfsGetAITeam() == self.OldDriver:lfsGetAITeam() and (IsValid(v:lfsGetPlane()) or v == self.OldDriver) then
					v:EmitSound("GRED_VO_BAILOUT_0"..math.random(1,3))
				end
			end
		end
		self.CheckDriver = true
		self.OldDriver = Driver
	end
	if ply:lfsGetPlane() == self then
		if self.EmitNow.wing_r and self.EmitNow.wing_r != "CEASE" then
			self.EmitNow.wing_r = "CEASE"
			table.insert(self.SoundQueue,"GRED_VO_HOLE_RIGHT_WING_0"..math.random(1,3))
		end
		if self.EmitNow.wing_l and self.EmitNow.wing_l != "CEASE" then
			self.EmitNow.wing_l = "CEASE"
			table.insert(self.SoundQueue,"GRED_VO_HOLE_LEFT_WING_0"..math.random(1,3))
		end
		if hp == 0 then
			self.IsDead = true
		end
	end
end

gred.LFSHUDPaintFilterParts = function(self)
	local partnum = {}
	local a = 1
	if self.Parts then
		for k,v in pairs(self.Parts) do
			partnum[a] = v
			a = a + 1
		end
	end
	partnum[a] = self
	
	return partnum
end

gred.CalcViewThirdPersonLFSParts = function(self,view,ply)
	view.origin = ply:EyePos()
	local Parent = ply:lfsGetPlane()
	local Pod = ply:GetVehicle()
	local radius = 550
	radius = radius + radius * Pod:GetCameraDistance()
	local TargetOrigin = view.origin - view.angles:Forward() * radius  + view.angles:Up() * radius * 0.2
	local WallOffset = 4
	local tr = util.TraceHull( {
		start = view.origin,
		endpos = TargetOrigin,
		filter = function( e )
			local c = e:GetClass()
			local collide = not c:StartWith( "prop_physics" ) and not c:StartWith( "prop_dynamic" ) and not c:StartWith( "prop_ragdoll" ) and not e:IsVehicle() and not c:StartWith( "gmod_" ) and not c:StartWith( "player" ) and not e.LFS and Parent:GetCalcViewFilter(e)
			
			return collide
		end,
		mins = Vector( -WallOffset, -WallOffset, -WallOffset ),
		maxs = Vector( WallOffset, WallOffset, WallOffset ),
	} )
	view.origin = tr.HitPos
	
	if tr.Hit and not tr.StartSolid then
		view.origin = view.origin + tr.HitNormal * WallOffset
	end
	
	return view
end

gred.GunnersInit = function(self)
	local ATT
	local seat
	for k,v in pairs(self.Gunners) do
		for a,b in pairs(v.att) do
			v.att[a] = self:LookupAttachment(b)
		end
	end
end

gred.GunnersDriverHUDPaint = function(self,ply)
	if !self.Initialized then
		gred.GunnersInit(self)
		self.Initialized = true
	end
	
	local att
	local tr
	local filter = self:GetCrosshairFilterEnts()
	local ScrW,ScrH = ScrW(),ScrH()
	local pparam1
	local pparam2
	local alpha
	
	for k,v in pairs(self.Gunners) do
		att = self:GetAttachment(v.att[1])
		tr = TraceLine({
			start = att.Pos,
			endpos = (att.Pos + att.Ang:Forward() * 50000),
			filter = filter
		})
		
		alpha = !IsValid(self["GetGunner"..k](self)) and 255 or 0
		
		pparam1,pparam2 = self:GetPoseParameter(v.poseparams[1]),self:GetPoseParameter(v.poseparams[2])
		
		if pparam1 == 1 or pparam2 == 1 or pparam1 == 0 or pparam2 == 0 then -- yea but shut up ok
			surface.SetDrawColor(255,0,0,alpha)
		else
			surface.SetDrawColor(0,255,0,alpha)
		end
		
		tr.ScreenPos = tr.HitPos:ToScreen()
		tr.ScreenPos.x = tr.ScreenPos.x > ScrW and tr.ScreenPosW or (tr.ScreenPos.x < 0 and 0 or tr.ScreenPos.x)
		tr.ScreenPos.y = tr.ScreenPos.y > ScrH and tr.ScreenPosH or (tr.ScreenPos.y < 0 and 0 or tr.ScreenPos.y)
		DrawCircle(tr.ScreenPos.x,tr.ScreenPos.y,5)
	end
end

gred.GunnersHUDPaint = function(self,ply)
	if !self.Initialized then
		gred.GunnersInit(self)
		self.Initialized = true
	end
	
	local att
	local tr
	local filter = self:GetCrosshairFilterEnts()
	local ScrW,ScrH = ScrW(),ScrH()
	local pparam1
	local pparam2
	local veh = ply:GetVehicle()
	for k,v in pairs(self.Gunners) do
		if veh == self["GetGunnerSeat"..k](self) then
			att = self:GetAttachment(v.att[1])
			tr = TraceLine({
				start = att.Pos,
				endpos = (att.Pos + att.Ang:Forward() * 50000),
				filter = filter
			})
			
			pparam1,pparam2 = self:GetPoseParameter(v.poseparams[1]),self:GetPoseParameter(v.poseparams[2])
			
			if pparam1 == 1 or pparam2 == 1 or pparam1 == 0 or pparam2 == 0 then -- yea but shut up ok
				surface.SetDrawColor(255,0,0,255)
			else
				surface.SetDrawColor(0,255,0,255)
			end
			
			tr.ScreenPos = tr.HitPos:ToScreen()
			tr.ScreenPos.x = tr.ScreenPos.x > ScrW and tr.ScreenPosW or (tr.ScreenPos.x < 0 and 0 or tr.ScreenPos.x)
			tr.ScreenPos.y = tr.ScreenPos.y > ScrH and tr.ScreenPosH or (tr.ScreenPos.y < 0 and 0 or tr.ScreenPos.y)
			DrawCircle(tr.ScreenPos.x,tr.ScreenPos.y,5)
			break
		end
	end
end


hook.Add("PopulateToolMenu","gred_menu",function()
	spawnmenu.AddToolMenuOption("Options",
								"Gredwitch's Stuff",
								"gred_settings",
								"Options",
								"",
								"",
								gred_settings
	)
end)

local BulletID = 0

local CAL_TABLE = {
	[1] = "7mm",
	[2] = "12mm",
	[3] = "20mm",
	[4] = "30mm",
	[5] = "40mm",
}
local COL_TABLE = {
	[1] = "red",
	[2] = "green",
	[3] = "white",
	[4] = "yellow",
	-- [5] = "blue",
}

net.Receive("gred_net_createbullet",function()
	local pos = net.ReadVector()
	local ang = net.ReadAngle()
	local cal = net.ReadUInt(3)
	local tracer = net.ReadUInt(3)
	local caliber = CAL_TABLE[cal]
	local Tracer = COL_TABLE[tracer]
	local fusetime = net.ReadUInt(7) * 0.01
	
	local expltime = fusetime > 0 and fusetime and CurTime() + fusetime
	
	local caltab = gred.CalTable[caliber]
	local speed = caltab.Speed
	local fwd = ang:Forward()
	local oldpos = pos - fwd * speed
	local explodable = caltab.Explodeable
	local dif = Vector()
	local BulletTrTab = {}
	
	if Tracer then
		local effect = EffectData()
		effect:SetOrigin(pos)
		effect:SetFlags(cal)
		effect:SetMaterialIndex(tracer)
		effect:SetStart(util.QuickTrace(pos + fwd * 10,expltime and fwd*(fusetime*speed) or fwd*99999999999999,filter).HitPos)
	end
	
	Effect("gred_particle_tracer",effect)
	
	timer.Create("gred_bullet_"..BulletID,0,0,function()
		dif.x = pos.x + pos.x - oldpos.x
		dif.y = pos.y + pos.y - oldpos.y
		dif.z = pos.z + pos.z - oldpos.z
		
		BulletTrTab.start = pos
		BulletTrTab.endpos = dif
		BulletTrTab.filter = filter
		BulletTrTab.mask = MASK_ALL
		
		local tr = TraceLine(BulletTrTab)
	end)
	
	BulletID = BulletID + 1
end)

net.Receive("gred_lfs_setparts",function()
	local self = net.ReadEntity()
	if not self then print("[LFS] ERROR! ENTITY NOT INITALIZED CLIENT SIDE! PLEASE, RE-SPAWN!") return end
	self.Parts = {}
	for k,v in pairs(net.ReadTable()) do
		self.Parts[k] = v
	end
end)

net.Receive("gred_lfs_remparts",function()
	local self = net.ReadEntity()
	local k = net.ReadString()
	
	self.EmitNow = istable(self.EmitNow) and self.EmitNow or {}
	if self.EmitNow and (k == "wing_l" or k == "wing_r") and self.EmitNow[k] != "CEASE" then
		self.EmitNow[k] = true
	end
	if self.Parts then
		self.Parts[k] = nil
	end
end)

net.Receive("gred_net_send_ply_hint_key",function()
	surface.PlaySound("ambient/water/drip"..math.random(1,4)..".wav")
	notification.AddLegacy("Press the '"..input.GetKeyName(net.ReadInt(9))..net.ReadString(),NOTIFY_HINT,10)
end)

net.Receive("gred_net_check_binding_simfphys",function()
	if input.LookupBinding("+walk") != nil then return end
	
	local DFrame = vgui.Create("DFrame")
	DFrame:SetSize(ScrW()*0.9,ScrH()*0.9)
	DFrame:Center()
	DFrame:MakePopup()
	DFrame:SetDraggable(false)
	DFrame:ShowCloseButton(false)
	DFrame:SetTitle("YOU DON'T HAVE YOUR +WALK KEY BOUND, WHICH IS REQUIRED IF YOU WANT THE TANK TURRET TO WORK")
	
	timer.Simple(3,function()
		if !IsValid(DFrame) then return end
		DFrame:ShowCloseButton(true)
	end)
	
	local DHTML = vgui.Create("DHTML",DFrame)
	DHTML:Dock(FILL)
	DHTML:OpenURL("https://steamuserimages-a.akamaihd.net/ugc/773983150582822983/8FAB41F8FDC796EF2033B0AF3379DF5734DDC150/")
	
end)

net.Receive("gred_net_send_ply_hint_simple",function()
	surface.PlaySound("ambient/water/drip"..math.random(1,4)..".wav")
	notification.AddLegacy(net.ReadString(),NOTIFY_HINT,10)
end)

net.Receive("gred_net_message_ply",function()
	ply = IsValid(ply) and ply or LocalPlayer()
	local msg = net.ReadString()
	ply:PrintMessage(HUD_PRINTTALK,msg)
end)

net.Receive("gred_net_bombs_decals",function()
	local decal = net.ReadString()
	local start = net.ReadVector()
	local hitpos = net.ReadVector()
	if GetConVar("gred_cl_decals"):GetInt() <= 0 then return end
	util.Decal(decal,start,hitpos)
end)

net.Receive("gred_net_sound_lowsh",function()
	ply = IsValid(ply) and ply or LocalPlayer()
	ply:GetViewEntity():EmitSound(net.ReadString())
end)

net.Receive("gred_net_nw_var",function()
	local self = net.ReadEntity()
	local str = net.ReadString()
	local t = net.ReadInt(4)
	if t == 1 then
		local val = net.ReadString()
		self:SetNWString(str,val)
	elseif t == 2 then
		local ent = net.ReadEntity()
		self:SetNWEntity(str,ent)
	elseif t == 3 then
		local table = net.ReadTable()
		self:SetNWTable(str,table)
	end
end)

net.Receive("gred_net_createtracer",function()
	local effect = EffectData()
	effect:SetOrigin(net.ReadVector())
	effect:SetFlags(net.ReadUInt(3))
	effect:SetMaterialIndex(net.ReadUInt(3))
	effect:SetStart(net.ReadVector())
	Effect("gred_particle_tracer",effect)
end)

net.Receive("gred_net_createimpact",function()
	local effectdata = EffectData()
	effectdata:SetOrigin(net.ReadVector())
	effectdata:SetAngles(net.ReadAngle())
	effectdata:SetSurfaceProp(net.ReadUInt(5))
	effectdata:SetMaterialIndex(1)
	effectdata:SetFlags(net.ReadUInt(4))
	Effect("gred_particle_impact",effectdata)
end)

local angle_zero = Angle()

net.Receive("gred_net_createwaterimpact",function()
	local effectdata = EffectData()
	effectdata:SetOrigin(net.ReadVector())
	effectdata:SetAngles(angle_zero)
	effectdata:SetSurfaceProp(0)
	effectdata:SetMaterialIndex(0)
	effectdata:SetFlags(net.ReadUInt(3))
	Effect("gred_particle_impact",effectdata)
end)

net.Receive("gred_net_createparticle",function()
	local effectdata = EffectData()
	effectdata:SetFlags(table.KeyFromValue(gred.Particles,net.ReadString()))
	effectdata:SetOrigin(net.ReadVector())
	effectdata:SetAngles(net.ReadAngle())
	effectdata:SetSurfaceProp(net.ReadBool() and 1 or 0)
	Effect("gred_particle_simple",effectdata)
end)

net.Receive("gred_net_applyboolonsimfphys_cl",function()
	local str = net.ReadString()
	local cvar = gred.CVars[str]
	if !cvar then return end
	
	local bool = cvar:GetBool()
	
	for k,v in pairs(gred.ActiveSimfphysVehicles) do
		v[str] = bool
	end
end)

net.Receive("gred_net_applyfloatonsimfphys_cl",function()
	local str = net.ReadString()
	local cvar = gred.CVars[str]
	if !cvar then return end
	
	local val = cvar:GetFloat()
	
	for k,v in pairs(gred.ActiveSimfphysVehicles) do
		v[str] = val
	end
end)

timer.Simple(5,function()
	local singleplayerIPs = {
		["loopback"] = true,
		["0.0.0.0"] = true,
		["0.0.0.0:port"] = true,
	}
	if singleplayerIPs[game.GetIPAddress()] then
		CheckForUpdates()
		-- CheckForConflicts()
	end
	
	CheckDXDiag()
end)

include("gredwitch/gred_cl_simfphys_functions.lua")
include("gredwitch/gred_cl_menu.lua")