
include("shared.lua")
AddCSLuaFile("shared.lua")
ENT.MaxEnterDistance = 500
ENT.Wheels = {
	{
		mdl="models/bf2/helicopters/mil mi-28/mi28_w1.mdl",
		pos=Vector(-586,1,52),
		friction=100,
		mass=200,
	},
	{
		mdl="models/bf2/helicopters/mil mi-28/mi28_w1.mdl",
		pos=Vector(-62,-55,20),
		friction=100,
		mass=200,
	},
	{
		mdl="models/bf2/helicopters/mil mi-28/mi28_w1.mdl",
		pos=Vector(-62,55,20),
		friction=100,
		mass=200,
	},
}
ENT.thirdPerson = {
	distance = 1100
}

function ENT:SpawnFunction(p, tr)
	if (!tr.Hit) then return end
	local e = ents.Create(ClassName)
	e:SetPos(tr.HitPos)
	e.Owner = p
	e:Spawn()
	e:Activate()
	return e
end

function ENT:Initialize()
	wac.aircraft.initialize()
	self.Entity:SetModel(self.Model)
	self.Entity:PhysicsInit(SOLID_VPHYSICS)
	self.Entity:SetMoveType(MOVETYPE_VPHYSICS)
	self.Entity:SetSolid(SOLID_VPHYSICS)
	self.phys = self:GetPhysicsObject()
	if self.phys:IsValid() then
		self.phys:SetMass(self.Weight)
		self.phys:Wake()
	end
	
	self.entities = {}
	
	self.OnRemoveEntities={}
	self.OnRemoveFunctions={}
	self.wheels = {}
	
	self.nextUpdate = 0
	self.LastDamageTaken=0
	self.wac_seatswitch = true
	self.rotorRpm = 0
	self.engineHealth = 400
	self:SetNWFloat("health", 100)
	self.LastActivated = 0
	self.NextWepSwitch = 0
	self.NextCamSwitch = 0
	self.engineRpm = 0
	self.LastPhys=0
	self.passengers={}
	
	self.controls = {
		throttle = -1,
		pitch = 0,
		yaw = 0,
		roll = 0,
	}

	self:addRotors()
	self:addSounds()
	self:addWheels()
	self:addWeapons()
	self:addSeats()
	self:addStuff()
	self:addNpcTargets()

	self.phys:EnableDrag(false)
	
end