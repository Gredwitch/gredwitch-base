local light_table = {	
	ems_sounds = {"ambient/alarms/apc_alarm_loop1.wav"},
}
list.Set( "simfphys_lights", "capc_siren", light_table)

local light_table = {
	L_HeadLampPos = Vector(71.9,32.85,-5.59),
	L_HeadLampAng = Angle(15,0,0),
	R_HeadLampPos = Vector(71.9,-32.85,-5.59),
	R_HeadLampAng = Angle(15,0,0),

	L_RearLampPos =Vector(-94,29.08,3.7),
	L_RearLampAng = Angle(40,180,0),
	R_RearLampPos = Vector(-94,-29.08,3.7),
	R_RearLampAng = Angle(40,180,0),
	
	Headlight_sprites = { 
		Vector(71.9,32.85,-5.59),
		Vector(71.9,-32.85,-5.59)
	},
	Headlamp_sprites = { 
		Vector(76.36,26.72,-5.79),
		Vector(76.36,-26.72,-5.79)
	},
	Rearlight_sprites = {
		Vector(-94,34.39,3.7),
		Vector(-94,-34.39,3.7)
	},
	Brakelight_sprites = {
		Vector(-94,29.08,3.7),
		Vector(-94,-29.08,3.7)
	}
}
list.Set( "simfphys_vehicles", "gred_tiger", V )

local V = {
	Name = "DOD:S Tiger Tank BUFFED",
	Model = "models/blu/tanks/tiger.mdl",
	Class = "gmod_sent_vehicle_fphysics_base",
	Category = "Gredwitch's Stuff",
	SpawnOffset = Vector(0,0,60),
	SpawnAngleOffset = 90,

	Members = {
		Mass = 10000,
		AirFriction = 5,
		Inertia = Vector(14017.5,46543,47984.5),
		
		MaxHealth = 8000,
		
		IsArmored = true,
		
		FirstPersonViewPos = Vector(0,-50,15),
		
		FrontWheelRadius = 45,
		RearWheelRadius = 45,
		
		EnginePos = Vector(-79.66,0,72.21),
		
		CustomWheels = true,
		CustomSuspensionTravel = 10,
		
		CustomWheelModel = "models/props_c17/canisterchunk01g.mdl",
		
		CustomWheelPosFL = Vector(110,45,45),
		CustomWheelPosFR = Vector(110,-45,45),
		CustomWheelPosML = Vector(5,45,40),
		CustomWheelPosMR = Vector(5,-45,40),
		CustomWheelPosRL = Vector(-100,45,45),
		CustomWheelPosRR = Vector(-100,-45,45),
		CustomWheelAngleOffset = Angle(0,0,90),
		
		CustomMassCenter = Vector(0,0,5),
		
		CustomSteerAngle = 60,
		
		SeatOffset = Vector(70,0,55),
		SeatPitch = 0,
		SeatYaw = 90,
		
		ModelInfo = {
			WheelColor = Color(0,0,0,0),
		},
			
		ExhaustPositions = {
			{
				pos = Vector(-118,-16.62,72.6),
				ang = Angle(115,0,0)
			},
			{
				pos = Vector(-118,-16.62,72.6),
				ang = Angle(115,60,0)
			},
			{
				pos = Vector(-118,-16.62,72.6),
				ang = Angle(115,-60,0)
			},
			
			{
				pos = Vector(-118,16.62,72.6),
				ang = Angle(115,0,0)
			},
			{
				pos = Vector(-118,16.62,72.6),
				ang = Angle(115,60,0)
			},
			{
				pos = Vector(-118,16.62,72.6),
				ang = Angle(115,-60,0)
			},
		},

		
		PassengerSeats = {
			{
				pos = Vector(0,0,50),
				ang = Angle(0,-90,0)
			}
		},
		
		FrontHeight = 23,
		FrontConstant = 50000,
		FrontDamping = 6000,
		FrontRelativeDamping = 6000,
		
		RearHeight = 23,
		RearConstant = 50000,
		RearDamping = 6000,
		RearRelativeDamping = 6000,
		
		FastSteeringAngle = 14,
		SteeringFadeFastSpeed = 400,
		
		TurnSpeed = 6,
		
		MaxGrip = 800,
		Efficiency = 0.42,
		GripOffset = -300,
		BrakePower = 150,
		BulletProofTires = true,
		
		IdleRPM = 600,
		LimitRPM = 4500,
		PeakTorque = 320,
		PowerbandStart = 600,
		PowerbandEnd = 3500,
		Turbocharged = false,
		Supercharged = false,
		DoNotStall = true,
		
		FuelFillPos = Vector(-111.88,-0.14,59.15),
		FuelType = FUELTYPE_PETROL,
		FuelTankSize = 160,
		
		PowerBias = -0.5,
		
		EngineSoundPreset = 0,
		
		Sound_Idle = "simulated_vehicles/misc/nanjing_loop.wav",
		Sound_IdlePitch = 1,
		
		Sound_Mid = "simulated_vehicles/misc/m50.wav",
		Sound_MidPitch = 1,
		Sound_MidVolume = 1,
		Sound_MidFadeOutRPMpercent = 58,
		Sound_MidFadeOutRate = 0.476,
		
		Sound_High = "simulated_vehicles/tiger/tiger_high.wav",
		Sound_HighPitch = 0.75,
		Sound_HighVolume = 0.75,
		Sound_HighFadeInRPMpercent = 40,
		Sound_HighFadeInRate = 0.19,
		
		Sound_Throttle = "",
		Sound_ThrottlePitch = 0,
		Sound_ThrottleVolume = 0,
		
		snd_horn = "common/null.wav",
		
		ForceTransmission = 1,
		
		DifferentialGear = 0.2,
		Gears = {-0.1,0,0.05,0.07,0.09,0.11,0.13,0.16}
	}
}

list.Set( "simfphys_vehicles", "gred_sherman", V )

local V = {
	Name = "DOD:S Sherman Tank BUFFED",
	Model = "models/blu/tanks/sherman.mdl",
	Class = "gmod_sent_vehicle_fphysics_base",
	Category = "Gredwitch's Stuff",
	SpawnOffset = Vector(0,0,60),
	SpawnAngleOffset = 90,

	Members = {
		Mass = 8000,
		AirFriction = 7,
		Inertia = Vector(14000,47000,48000),
		
		MaxHealth = 6000,
		
		IsArmored = true,
		
		FirstPersonViewPos = Vector(0,-50,15),
		
		FrontWheelRadius = 40,
		RearWheelRadius = 40,
		
		EnginePos = Vector(-79.66,0,72.21),
		
		CustomWheels = true,
		CustomSuspensionTravel = 10,
		
		CustomWheelModel = "models/props_c17/canisterchunk01g.mdl",
		
		CustomWheelPosFL = Vector(100,35,50),
		CustomWheelPosFR = Vector(100,-35,50),
		CustomWheelPosML = Vector(-5,35,50),
		CustomWheelPosMR = Vector(-5,-35,50),
		CustomWheelPosRL = Vector(-110,35,50),
		CustomWheelPosRR = Vector(-110,-35,50),
		CustomWheelAngleOffset = Angle(0,0,90),
		
		CustomMassCenter = Vector(0,0,3),
		
		CustomSteerAngle = 60,
		
		SeatOffset = Vector(60,-20,55),
		SeatPitch = 0,
		SeatYaw = 90,
		
		ModelInfo = {
			WheelColor = Color(0,0,0,0),
		},
		
		ExhaustPositions = {
			{
				pos = Vector(-90.47,17.01,52.77),
				ang = Angle(180,0,0)
			},
			{
				pos = Vector(-90.47,-17.01,52.77),
				ang = Angle(180,0,0)
			},
		},

		
		PassengerSeats = {
			{
				pos = Vector(50,-20,30),
				ang = Angle(0,-90,0)
			}
		},
		
		FrontHeight = 20,
		FrontConstant = 50000,
		FrontDamping = 4000,
		FrontRelativeDamping = 4000,
		
		RearHeight = 20,
		RearConstant = 50000,
		RearDamping = 4000,
		RearRelativeDamping = 4000,
		
		FastSteeringAngle = 14,
		SteeringFadeFastSpeed = 400,
		
		TurnSpeed = 6,
		
		MaxGrip = 800,
		Efficiency = 0.85,
		GripOffset = -300,
		BrakePower = 150,
		BulletProofTires = true,
		
		IdleRPM = 600,
		LimitRPM = 4500,
		PeakTorque = 250,
		PowerbandStart = 600,
		PowerbandEnd = 3500,
		Turbocharged = false,
		Supercharged = false,
		DoNotStall = true,
		
		FuelFillPos = Vector(-46.03,-34.64,75.23),
		FuelType = FUELTYPE_PETROL,
		FuelTankSize = 160,
		
		PowerBias = -0.5,
		
		EngineSoundPreset = 0,
		
		Sound_Idle = "simulated_vehicles/sherman/idle.wav",
		Sound_IdlePitch = 1,
		
		Sound_Mid = "simulated_vehicles/sherman/low.wav",
		Sound_MidPitch = 1.3,
		Sound_MidVolume = 0.75,
		Sound_MidFadeOutRPMpercent = 50,
		Sound_MidFadeOutRate = 0.85,
		
		Sound_High = "simulated_vehicles/sherman/high.wav",
		Sound_HighPitch = 1,
		Sound_HighVolume = 1,
		Sound_HighFadeInRPMpercent = 20,
		Sound_HighFadeInRate = 0.2,
		
		Sound_Throttle = "",
		Sound_ThrottlePitch = 0,
		Sound_ThrottleVolume = 0,
		
		snd_horn = "common/null.wav",
		
		ForceTransmission = 1,
		
		DifferentialGear = 0.3,
		Gears = {-0.1,0,0.05,0.08,0.11,0.14,0.17}
	}
}

