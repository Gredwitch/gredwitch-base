 
if CLIENT then
	language.Add("allied_radiobattery", "Allied radio battery")
	language.Add("axis_radiobattery", "Axis radio battery")
end



game.AddAmmoType( {
	name = "Axis radio battery",
	dmgtype = DMG_BULLET
} )
game.AddAmmoType( {
	name = "Allied radio battery",
	dmgtype = DMG_BULLET
} )
