AddCSLuaFile()

function gb5_physics()
Msg("\n|Gredwitch's copy of Gbombs 5 physics module initialized!")
Msg("\n|If you don't want this, delete the gred_physics.lua file\n")

phys = {}
phys.MaxVelocity = 5000
phys.MaxAngularVelocity = 3636.3637695313
physenv.SetPerformanceSettings(phys)

end

hook.Add( "InitPostEntity", "gred_physics", gred_physics )