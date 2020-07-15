--[[B15/07/2020
- Fixed a small error
- Fixed the latest news panel images not being 16/9
- Fixed the reload circle not being in the middle of the screen with some vehicles


If you want to stay updated about my other addons, make sure you join my group : https://steamcommunity.com/groups/gredcancer
If you are experiencing LUA errors, please make sure you are subscribed to everything that is required. If you do, uninstall / re-install the addons that have issues.
Make sure you have read the descriptions of my addons and that other people did not complain about the errors you are experiencing in the comments.

If you want to play with other people with exclusive addons I made, you can join my Sandbox server at havok.tech:27012 and join the Discord : https://discord.gg/eneGmMz

OLDER CHANGES

15/07/2020
- Fixed eyeangles not facing the correct direction when you enter a seat
- Fixed spawning on a slope breaking the camera
- Fixed errors related to timers
- Replaced "double tab walk to toggle the gun" with "hold walk to enter freeview"

13/07/2020
- Added missing shelltypes and calibers to the ammo box
- Fixed an error related to hatches
- Fixed an error related to bombs that could cause server crashes
- Fixed the player driving animations being overridden on all simfphys vehicles
- Fixed a client side error related to reload sounds
- Fixed client side shell entities from the killcam staying at the origin of the map
- Fixed shells not having the correct shell type model in the killcam
- Removed the debug prints
- Removed the warning about trailers reborn
- You can no longer change shell types if you only have 1

12/07/2020 - 10/07/2020

[HOTFIX #8]
- Fixed a conflict with old shitty addons

[HOTFIX #7]
- Added an option to rebind the Launch Smoke Grenade key

[HOTFIX #6]
- Added the simfphys hud font just in case
- Fix the conflicting addon warning always appearing
- Slightly optimized the code of the tracks

[HOTFIX #5]
- Added a warning that tells people that use the poorly coded trailer base that conflicts with the tanks to remove it
- Fixed shells dealing damage to tanks twice
- Fixed missing smoke particles

[HOTFIX #4]
- Added gred_sv_shockwave_unfreeze to the explosive options
- Fixed the missing 88mm gun sound
- Removed fire_01.pcf
- Replaced the 'Connect' button in the menu with 'Copy IP to clipboard'

[HOTFIX #3]
- Removed Ram Ranch
- Fixed an error when shells hit an unarmored vehicle
- Fixed an error with flame tanks when vFire is enabled
- Added an option to toggle vFire flame tanks in the options when vFire is enabled

[FEATURE REQUEST]
- Added an option to have unlimited machinegun ammo
- Added an option to disable the firstperson viewmodels (the goggles)

[HOTFIX #2]
- Fixed LFS planes using NoCollide constraints being broken
- Fixed tank resupplying not working

[HOTFIX]
- Fixed a lot of errors
- Fixed destructible planes being broken
- Fixed some flamethrower issues
- Increased mouse sensitivity in sight mode

- Fixed the Eye Angles resetting when you get in a tank
- Removed Press WALK to activate the turret
- Walk is now the freeview key
- Fixed the machineguns' muzzleflashes being behind tanks’ turrets while they move
- Made a new HUD for the tanks
- Added a viewport system
- New tank base system : tanks are now made with a table
- Added a new track sound system
- Made the tracks sound louder
- Reworked the way tanks turn
- Optimized the tanks a lot
- Added a loader system for every tanks
- Fixed player damage not working in vehicles
- Fixed shells glitching in the water
- Added a new elevation system (with new turret traverse and elevation sounds)
- Made a new options menu
- Added a hatch system - you can now open the hatches with the O key
- Fixed the keybinds triggering functions on all the seats
- Added a realistic normalisation system for the shells
- Made it so shells do not ricochet in mud, sand and snow
- Added a better War Thunder style ricochet system
- Added a new whistling system for the shells
- Shells will not whistle if they were shot way too close from you anymore
- Fixed the shell tracers emitters not being removed correctly
- Made it so the shells can have different tracer colours
- Fixed only one type of tank explosion triggering all the time
- Reduced the damage of the HEAT shells
- Fixed high velocity shells making tanks fly away
- Fixed “Clamping ApplyAbsVelocityImpulse on player”
- Removed screen shakes when explosives blow up in vehicles
- Vehicles now perform way better during lags
- Fixed shells crashing the server when hitting water
- Made it so you can zoom in sight mode (W)
- Re-coded the ammo box
- Several people can now use the ammo box at the same time
- Fixed shells not having correct bodygroups
- Recoded the way shells are loaded into the tank
- Fixed a major issues with the shells’ ballistics that was screwing drag coefficients and inertia up (The Tiger I E’s Panzergranate 39 was penetrating 96mm at 100m, it now pens 162mm at 100m)
- Added working smoke launchers to tanks (smoke projectile model by William)
- Shells now gets the tanks’ velocity added to their base velocity
- Optimized the physical bullets
- Added bullet impacts
- Improved the ricochet impact effects
- New armour system with realistic armour plate simulation
- When a shell hits a tank, the person who fired the shell will get a War Thunder style windows that shows if the shell went through or not
- Added double tap WALK to disable the turret
- Add traverse rate and elevation rate multipliers
- Mouse sensitivity in sight mode is now reduced based on the zoom of the sight
- Fixed the ammo box

27/05/2020
- Fixed possible exploits with the ammo box
- Fixed a shell error
- Replaced all the WT VMTs with patches

03/04/2020
- Removed the initialize hook since it's not being called in a lot of cases

28/03/2020
- Added more options about the damage of explosives
- Fixed the shells whisteling on servers forever

12/03/2020
- Added a global server side suspension system to fix the issues with tanks flying around on displacements
- Added a convar to use the broken suspension system that is actually more optimised and that works correctly on anything that isn't a displacement (basically on flat surfaces)
- Added damage multipliers for HEAT and APCR shells
- Removed useless debug code

01/03/2020
- Fixed the manual reload system for tanks being broken
- Made it so it says which gun you're currently using in the tank HUD
- Optimised some stuff related to client side keys convars

26/02/2020
- Fixed dynamites erroring when a bullet hits them
- Improved the shell damage calculation : shells will now do more damage depending on how small the vehicle is
- Made AP shells with a explosive filler more powerful

18/02/2020
- Added a 77mm shell
- Added missing 105mm shell types
- Added missing Flak 38 mag
- Fixed an issue that was making the shells whisteling forever
- Fixed a small error that could happen sometimes
- Fixed some clients timing out when joining a server
- Fixed the shells coming from the ammo box being too sensitive
- Fixed the HE shells not penetrating anything
- Fixed an issue with the tank damage calculation
- Made 20mm autocannons more powerful
- Increased the damage of APCR shells
- Optimised the huge shared autorun
- Optimised network traffic on client connection
- Optimised loading times
- Removed resource caching by default (you can enable it manually in the options)
- Removed the invalid bone spam to increase performance

26/01/2019
- Fixed a client side error with shells
- Fixed instant handbraking with tanks
- Fixed the bullet particles not having the correct speed
- Improved the bullet particles so they get bigger depending on their caliber
- Made it so a tip appears on your screen if you try to destroy a tank with HE rounds
- Made 30mm and 40mm bullets more powerful against tanks

21/01/2020
- Added inertia calculation
- Added an HE shell damage multiplier
- Added missing sshelltypes
- Decreased the mass of the ammobox
- Fixed the shells whisteling forever in multiplayer
- Fixed AP still doing damage on a non penetration while having the "damage on a non penetration" option disabled
- Fixed the shells unwelding vehicles' wheels (aka disabling tracks)
- Fixed explosives moving the seats
- Fixed shells and rockets glitching with water
- Fixed the DirectX check not working
- Gave a reason to exist to air-burst shells by giving them a bigger blast radius
- Made the rockets less sensitive as long as they are not armed
- Made the anti-tank shell damage multiplier work with HEAT rounds
- Made the Hellfire deal more damage
- Merged Gredwitch's Base (materials) and Gredwitch's Shared Tank Materials into Gredwitch's Base
- Tweaked the drag coefficient calculation

25/12/2019
- Added a way to translate the track textures from left to right or from up to down
- Added APHE shells
- Fixed a penetration issue with HE shells

12/12/2019
- Added a huge popup that tells people how to bind their walk key if they don't have it bound when they get in a simfphys vehicle
- Added gred_sv_shell_ap_lowpen_ap_damage to remove damage from AP shells in case of a non penetration
- Added gred_sv_shell_ap_lowpen_ap_damage to remove damage from HEAT shells in case of a non penetration
- Added a more or less working stabilizer feature
- Added a server side convar loader (this only works if the convars are changed from the spawnmenu)
- Added HEAT shells ; basically a mix between HE and AP shells
- Added APCR shells ; they don't do a lot of damage but they can hurt and kill crew members in case of a penetration
- Added APCBC shells ; basically AP shells but better
- Added even more tank shells but they're actually just AP shells
- Added a better penetration calculation system ; switched from Krupp's formula to De Marre's formula
- Added an impact angle calculation to the penetration system ; now you will have to aim
- Added a simfphys tank health multiplier
- Added a drag coefficient calculator ; shells will now fly realisticly through the air and won't loose speed as fast as before
- Added a blood explosion effect to the AP shells when they hit players and NPCs
- Added compatibility with VJ base tanks (hopefully)
- Fixed the shells sometimes spamming the ricochet effects
- Fixed the shells sometimes staying on the floor
- Fixed the shells sometimes whisteling forever
- Fixed the HUD of the tanks not showing on servers sometimes
- Fixed an error occuring during some explosions
- Optimised the shells

27/11/2019
- Fixed the shells staying on the ground and raping your ears by adding a max ricochet number of 3

24/11/2019
- Added gred_sv_shell_ap_lowpen_system
- Added gred_sv_shell_ap_lowpen_shoulddecreasedamage
- Added gred_sv_shell_ap_lowpen_maxricochetchance
- Added a new shell damage system ; Basically, when an AP shell hits a tank, the tank's average armor thickness will be calculated (Max tank's health divided by 100) and if the shell's penetration capability below it, then we will reduce the shell's damage depending on how big the difference between the armor thickness and the penetration capability is, and the shell will have a higher chance to ricochet depending at which angle you hit the tank
- Fixed the ammo box glitching out

14/11/2019
- Added a toggle tank gun binder to like toggle between a 128mm and a 75mm cannon
- Made it so tanks don't spam errors if the client doesn't have the model
- Fixed the debug print
- Fixed a rare shell error

09/11/2019
- Fixed the tanks flying away when they they get hit by an explosion
- Fixed the bombs
- Fixed an issue with the damage calculation for the AP shells
- Tweaked the tank turn code
- Optimised the CreateExplosion function

06/11/2019
- AP Shells can now ricochet on water
- Fixed bombs not destroying tanks
- Fixed shells bouncing back to you when they hit water
- Shells, rockets and bombs will now explode when they hit water

05/11/2019
- Added a tank health multiplier
- Fixed an annoying WAC error
- Fixed the HAB physbullet filter
- Updated the turn rate multiplier so it works better
- Removed the toggleable server side suspension check since they should always be checked server side

02/11/2019
- Added gred_sv_simfphys_turnrate_multplier for low tickrate servers
- Fixed a small issue with JDAMs
- Fixed the shell speed multiplier slider
- Fixed the out of date message appearing even if the addon is up to date
- Updated the tank turn code so the tanks turn better
- Updated the AP damage calculation so it's more realistic
- Updated the ricochet system
- Updated the Flak 36 particle so the smoke doesn't make you blind anymore

31/10/2019
- Added a sensitivity slider for the tank sights
- Fixed the circle in the tank sights
- Fixed the V1
- Removed the out of date warnings in multiplayer
- Renamed gred_sv_shellspeed_multiplier to gred_sv_shell_speed_multiplier

29/10/2019
- Added compatibility with Havok's Physical Bullet Module
- Added a ConVar to toggle tank crosshairs in 3rd person
- Added a ConVar to make tanks have 4 wheels instead of 6 (basically to improve performance)
- Added some bunch of LFS gunners functions
- Added an angle offset for the tank sights
- Added a tank neutral turn feature so my tanks won't have problem steering anymore
- Fixed base_shell: Changing collision rules within a callback is likely to cause crashes!
- Fixed shells not dealing a lot of damage to tanks that use simfphys.TankApplyDamage
- Fixed an error related to the shell tracer effect
- Removed the simfphys seat networking code
- Removed the "Should bullets damage tanks option" - Tanks now use simfphys.TankApplyDamage

21/10/2019
- Added a flamethrower particle
- Fixed an LFS error

20/10/2019
- Fixed an issue related to changelogs
- Fixed a simfphys error that could cause server crashes

15/10/2019
- Added an AP shell damage multiplier
- Added 37mm and 100mm shells to the ammo box
- Added a client side suspension system
- Added a warning about DirectX
- Fixed the shells sometime crashing the server
- Updated the 40mm muzzleflash particle

08/10/2019
- Fixed bullets damaging players in seats
- Fixed an ammobox issue
- Added gas shells support
- Fixed HE bullets dealing damage to tanks
- Made the bombs actually destroy tanks

06/10/2019
- Added a hint system for my simfphys tanks and my LFS aircrafts
- Added new ricochets sounds
- Fixed players not being able to enter my simfphys vehicles
- Fixed the manual simfphys reload system only adding HE rounds
- Fixed missing flame jet particle
- Fixed missing AP shell sounds
- Fixed the shell whistle sounds playing forever
- Fixed an EmitNow being nil
- Fixed the Panzer IV being Gredwitch's Base
- Tweaked the LFS aircraft parts destruction aerodynamics the you actually can't control them when they're destroyed

05/10/2019
[HOTFIX 2] Fixed le stinky poopoo
[HOTFIX] Fixed missing sounds and another stack overflow
- Fixed conflicts with some simfphys vehicles
- Fixed some simfphys global functions
- Fixed a stack overflow issue
- Fixed missing 12mm water impacts
- Fixed the emplacement pack's magazines not appearing in the ammo box

03/10/2019
[HOTFIX] Fixed lua errors when simfphys isn't installed / fixed thirdperson with simfphys vehicles
- Added some simfphys global functions for the upcoming tanks
- Added options to make simfphys tanks not take damage from bullets
- Cleaned a bunch of code in base_bomb and base_rocket
- Fixed the sliders not working correctly
- Fixed a conflict with MysterAC's particles
- Fixed explosives making tanks fly
- Moved gred_ammobox from the emplacement pack
- Optimised base_bombs
- Optimised bullets
- Optimised the convars
- Removed all of the shell entities
- Reworked base_shell : shells now deal realistic damage and won't bug out when they hit simfphys vehicles / shells can now do ricochets / added fancy tracers to shells / reworked the shell whistle sounds / the shells' mass, velocity and caliber are now taken into account to calculate the damage that will be delt

25/08/2019
- Fixed the DFrames showing too early
- Removed the 64 bit branch warnings

18/08/2019
- Hopefully fixed the bugs

16/08/2019
- Updated the GunnersTick function

15/08/2019
- Added gred_prop_part.lua and gred_prop_tail.lua
- Added a function that gets all the NPCs
- Added a version checker that screams at you when the addon is not up to date
- Added a window that shows you the latest changelogs
- Added a bunch of functions to centralize the code and maintain LFS aircrafts in a more efficient way
- Added ConVars : gred_sv_lfs_godmode and gred_sv_lfs_infinite_ammo
- Fixed a particle error
- Fixed the convars not toggleing on servers
- Fixed some issues with the LFS Health slider
- Updated the thumbnail

20/07/2019
- "Fixed" the "particle" error
- Updated the ConVar system
- Updated some functions

12/07/2019
- Added a warning that yells at players who use the 64 bits branch
- Fixed the tracers not matching the bullet speed
- Made the server side spawnmenu options toggleable by admins
- Rewrote the explosion function from scratch ; explosions shouldn't cause server crashes anymore
- Rewrote the shells so AP does damage to tanks and HE does less damage to tanks and so shells don't act like rockets anymore

26/06/2019
- Added gred_particle_tracer
- Fixed wac_base_grocket using the old sound system, creating errors
- Made a new physical bullet system that is fully optimised (basically no more lag while firing) with new tracer effects
- Optimised the explosion sound system so we don't use square roots anymore
- Optimised some net code
- Updated base_shell : the shells will now whistle correctly and better
- Updated wac_pod_gunner and wac_pod_mg : made them use the new physical bullet function
- Removed gred_base_bullet

10/06/2019
- Added new effects
- Rewrote the bombs explosion sound system from scratch - the time the explosion sounds will play now depend on how far the player is from the explosion
- Tweaked the WAC Hydra rocket
- Updated the bullet code

08/04/2019
- Added HAB Physbullet compatibility
- Added a 128mm shell
- Fixed a missing particle precache
- Updated some particles

23/02/2019
- Added a bunch of CEffectDatas : the particle effect spawning system has been updated, the effects don't use the Net Library anymore, which means that the servers will suffer less from the effects
- Cleaned up A LOT of code
- Fixed gb_shell_56mm having a 75mm shell explosion effect
- Updated the autorun files : added a particle table, optimized the loading times, fixed some WAC errors, updated the missing addons popup

10/02/2019
- Added a new way to override WAC so you don't have to install it in the legacy addons folder
- Added new convars to block popups, fixed LFS being shit and prevent WAC aircrafts from being overridden
- Added gb_shell_40mm
- Cleaned up some code
- Organized the spawnmenu options
- Removed unused files

28/12/2018
- Fixed missing Network String
- Fixed Physics Environnements

26/12/2018
- Updated BASE_BULLET : updated the code
- Updated gred_autorun_shared : precached some more particles
- Updated BASE_BOMB : fixed explosives creating smoke out of the void
- Updated ROCKET_HYDRA : the rocket will now work even if WAC isn't installed
- Updated HC_ROCKET : no errors will be created if WAC isn't installed anymore

03/12/2018
- Added brand new explosion effects
- Added gb_shell_152mm and gb_shell_152mm
- Added a file precache system
- Added the shell materials
- Added new brrt SFX
- Fixed the V1 sound not stopping
- Updated base_shell : added a shell whistle SFX
- Updated base_gas : fixed a bug

24/10/2018
- Updated base_rocket: Shells and rockets will now explode when they hit water
- Updated gred_base_bullet : Fixed the water impact effects not working / Removed useless variables
- Updated wac_hc_base : Fixed helicopters blowing up in mid air while going down
- Tweaked the explosives' decals so they can fit with their effect

03/10/2018
- Added some materials
- Added wac_hc_rocket : fixed the default wac rockets
- Fixed shockwave_ent's explosions making everything fucking up
- Fixed shockwave_sound_lowsh causing performance issues due to not 
- Fixed napalm and WP shells not being compatible with vFire
- Fixed the rockets and the shells pointing toward the ground a little bitremoving itself after playing the sound
- Updated gb_bomb_cbu
- Updated gb_bomb_cbubomblet
- Updated gb_shell_81mm : made it not spawnable
- Updated wac_hc_base : fixed WAC not working in peer to peer (again) / added a crash effect / added a zoom feature for cameras (press the freeview key)
- Updated gred_add / POD_MG / POD_GUNNER / POD_MIS / POD_GROCKET : added a button to use the default WAC stuff
- Updated POD_MIS : fixed missiles locking on the aircraft
- Updated BASE_BULLET : optimized the bullets / the bullets' speed is now affected by their weight (higher caliber = higher weight)
- Removed the artillery sweps as they are going to be uploaded in a different addon
- Removed unused base_dumb

23/10/2018
- Added base_gas
- Added gb_shell_gas
- Updated shockwave_ent : decals should now be client-side / fixed the rockets making everything fly away
- Updated base_bomb / base_rocket / base_shell / base_napalm : re-organized the bases to make them more optimized
- Updated all the shells / gb_bomb_sc100 / gb_bomb_fab250 : fixed non-working water explosion sounds
- Updated base_bullet : optimized the bullet
- Updated POD_GUNNER / POD_MG : optimized the fire functions
- Updated POD_GROCKET / POD_MIS : the rockets shouldn't collide with the aircrafts anymore
- Updated HC_ROCKET : fixed the rocket's speed
- Updated HC_BASE : Helicopters should now spin when their health is low / Made the explosion effects client-side
- Updated the spawnmenu options : server-side options are not showing anymore since you can only modify the convars with RCon
- Removed unused base_fire

04/09/2018
- Updated BASE_BULLET : Fixed writeInt error
- Updated GRED_ADD : Removed a hook and applied the physenv manually to the shells / Fixed a missing particle precache
- Updated shockwave_ent Fixed explosions making everything fly away forever
- Updated WAC_HC_BASE : Improved the radio sounds activation / Added a new water explosion effect when WAC aircrafts are crashing
- Updated BASE_SHELL : Physenv should now apply localy to prevent problems with other stuff

29/08/2018

- Added gred_sv_shellspeed_multiplier
- Added physics.lua / Updated gred_add : Made the addon override gmod's default max physics object velocities
- Added missing particle materials
- Fixed ROCKET_V1 : Fixed the engine sound not working
- Fixed BASE_DUMB : Fixed "Changing collision rules within a callback is likely to cause crashes!"
- Fixed the addon not overridding WAC
- Updated WAC_BASE_ROCKET : Made the particle effects client side only
- Updated BASE_BOMB : Made the particle effects client side only
- Updated BASE_ROCKET : Made the particle effects client side only
- Updated BASE_BULLET : Fixed some missing impact effects types / Fixed the bullets having a "crazy origin" / Fixed the bullets not dealing any damage and not having a radius when the dividers are below 1 / Removed useless if CLIENT in cl_init.lua
- Updated all the rockets to improve the neurotec compatibility
- Moved the shells from the Emplacement pack here

18/08/2018

- Updated BASE_BULLET : added a new optimized tracer system / added a 30mm time-fuze shell / made impact effects client only
/ added a new 40mm bullet
- Updated POD_MG : added compatibility for the new tracer system / made the muzzleflashes client only
- Updated POD_GUNNER : added compatibility for the new tracer system / removed outdated code / made the muzzleflashes client only
- Updated BOMB_2000GP : removed the debug message
- Updated BASE_BOMB : added an option to prevent bombs from being spawned
- Updated gred_particles : added two new 40mm effects
- Updated POD_JDAM / POD_GBOMB : added an option to prevent WAC aircrafts from carrying bombs
- Updated gred_add : added an option to disable the radio sounds / precached more particles / precached the bullet model
- Fixed a bug in shockwave_ent
- Fixed wac_hc_base : fixed an issue that was preventing the players from getting in an aircraft in multiplayer

16/07/2018
- Added a mortar white phosphorus artillery SWEP
- Added an artillery strike base to optimize the code
- Fixed dropped bombs flying away due to other bombs's explosions
- Fixed dropped bombs disappearing after the aircraft's destruction
- Fixed the artillery SWEPs
- Fixed explosion sounds not playing when switching to a camera
- Fixed the JDAMs not working on servers

10/07/2018
- Added working JDAMs
- Fixed dropping bombs making the aircraft fuck up
- Fixed a missing texture on the Mk 82
- Fixed the bullets being laggy
- Fixed the V1 start sound not following the rocket
- Most of the convars are now server side to prevent client lags and bugs

30/06/2018
- Added a new option to customize the explosion sounds muffle
- Fixed the Hydra 70 spawning without WAC being enabled
- Fixed a bunch of bugs related to WAC not being installed
- Fixed a bunch of serverside related things (including particles)
- Fixed some stuff related to the SWEPs
- Updated the particles

27/06/2018
- Fixed the particles not showing
- Fixed a typo in autorun/server/gred_add.lua

25/06/2018
- Added GRED_BASE_BULLET : optimized the bullets as much as possible
- Added editable bullet damage / radius
- Finally fixed stuff related to client-side / server-side convars
- Fixed the GBU-38 being as powerful as a 1000LB bomb
- Fixed the explosives rarely showing decals after being exploded
- Fixed some impact effects not working
- Fixed the guns not dealing any damage to NPCs
- Updated POD_GUNNER / POD_MG : optimized them as much as possible
- Updated POD_MIS : fixed the missiles not dealing any damage / added better Hellfire stuff
- Updated BASE_GROCKET : Hellfires are somewhat more OP / Fixed the missiles dealing no damage / Added new sounds and explosion effects
- Updated BASE_NAPALM : Updated some stuff so it can be used by WP rounds
- Updated the models paths
- Updated the particles
- Updated most of the deprecated "GetConVarNumber()" functions to "GetConVar():GetInt()"
- Updated BASE_ROCKET / BASE_BOMB
- Removed BASE_7MM / BASE_12MM / BASE_20MM / BASE_30MM

27/05/2018
- Fixed POD_GUNNER
- Fixed the bombing runs in gred_arti_ent
- Fixed the deleted rocket sound
- Fixed the Nebelwerfer artillery sounds not playing
- Fixed POD_MIS : fixed the Fire and Forget type of missile
- Fixed and updated the artillery sounds
- Fixed the missing mm1/box material error
- Removed unused POD_HELLFIRE and POD_HYDRA

24/05/2018
- Added gb_rocket_v1
- Added a new Nebelwerfer rocket model
- Fixed the mortar shell's collision model
- Fixed the water impacts spawning on your face
- Fixed some missing particles errors
- Fixed the artillery SWEPs
- Fixed error related to the bullet's ownership
- Updated POD_MG : fixed the sounds sometimes not playing / reduced the gun sounds's volume / updated the bullet spread with 20mm guns
- Updated POD_GBOMB : added compatibility with the V1 "Flying Bomb"
- Updated POD_GUNNER : updated the bullet spread with 20mm guns
- Updated BASE_ROCKET : reduced the firing sound volume
- Updated gred_convars / gred_stmenu : added a bunch of effects related options
- Updated BASE_7MM : fixed the radius not disabling with the options
- Updated BASE_20MM : updated the particles / added air burst stuff
- Updated gred_stmenu and gred_convars : switched some convars to client only
- Updated particles : fixed the Insurgency particles smoke, added my own particles
- Updated gb_rocket_105mm to gb_rocket_81mm
- Updated WAC_HC_BASE
- Upated the materials
- Removed useless POD_TURRET

15/04/2018
- Added gred_overwrite_wac : this should fix WAC not getting overridden
- Updated impact_fx_ins : smoke is now way less thick
- Updated gred_convars
- Updated gred_stmenu
- Updated POD_GBOMB : bombs shouldn't affect the aircraft's maniabillity anymore
- Updated BASE_ROCKET / BASE_GBOMB : fixed the Insurgency water explosion effect being in the wrong angle

08/04/2018
- Added a new 500LB GP model (thanks to damik)
- Updated particles : fixed the Day of Infamy and Insurgency particles being white
- Updated gred_stmenu
- Updated gred_convars
- Updated BASE_7MM : added compatibility with the Insurgency particles
- Updated POD_GROCKET / POD_MIS / POD_MG / POD_GUNNER : projectiles won't collide with the aircraft
- Updated materials

02/04/2018
- Updated BASE_7MM : buffed it and added an explosive damage options
- Updated gred_stmenu : fixed the whole spawnmenu options
- Updated BASE_ROCKET and BASE_BOMB : fixed "Changing collision rules within a callback is likely to cause crashes!" error
- Updated shockwave_sound_lowsh : reduced maximum sound range
- Updated shockwave_ent : fixed random errors
- Updated gred_convars

30/03/2018
- Added BASE_7MM
- Added a new 20mm effect
- Added a new Hellfire model (thanks to damik)
- Fixed shockwave_ent
- Updated BOMB_2000GP : changed explosion sound and renamed the spawn menu icon to 2000LB GP
- Updated BOMB_SC1000 : changed explosion sound
- Updated BASE_12MM : impact sound volume will now vary according to the guns fire rate
- Updated BASE_20MM : updated the impact effect and the impact sound effects
- Updated POD_MG and POD_GUNNER : the bullets will now be faster and the tracers will now look better
- Updated BASE_GROCKET : Updated the sounds and the effect
- Updated shockwave_sound_lowsh / every BOMB_ and every ROCKET_ : reworked the sound system
- Updated materials
- Updated gred_convars and gred_stmenu : added "realistic health" stuff
- Updated WAC_HC_BASE : added "realistic health" stuff and updated the maximum enter distance
- Updated particles : Day of Infamy and Insurgency effects will now look better, won't disapear and won't override each other
- Renamed BASE_MG to BASE_12MM
- Removed shockwave_sound_lowsh

06/02/2018
- Added a new FAB-250 model (from ECF pack)
- Added a 13cm Nebelwerfer rocket (model from Gbombs)
- Added a 105mm shell (model from Day of Infamy)
- Fixed artillery SWEPs
- Fixed binoculars model
- Fixed POD_GROCKET / POD_MG / BASE_20MM / BASE_30MM /BASE_MG : entities should not collide on the aircraft anymore
- Updated BOMB_BASE and BASE_ROCKET
- Updated every BOMB_ : removed useless code
- Removed RAPE SWEP

02/02/2018
- Added BOMB_1000GP (credits goes to damik for the model)
- Added a HVAR model (credits goes to damik for the model)
- Added BASE_ROCKET / ROCKET_HYDRA / ROCKET_HVAR / ROCKET_RP3
- Added BASE_NAPALM / BASE_FIRE / BOMB_MK77
- Added rocket sounds
- Added napalm sounds
- Fixed BOMB_CBU
- Fixed a server crash caused by fire particles
- Fixed fire particles not appearing on birotor and trirotor planes
- Fixed fire particles not appearing on birotor helicopters
- Fixed undestroyable Junkers Ju 52 due to fire particles
- Fixed impact earrape
- Updated POD_GROCKET
- Updated shockwave_ent
- Updated WAC_HC_BASE
- Updated WAC_PL_BASE : made gun sounds louder
- Updated gred_stmenu
- Updated gred_convars
- Updated particles / textures
- Updated sounds
- Updated BASE_MG / BASE_20MM / BASE_30MM / POD_MG / POD_GUNNER : tracers should only appear every X shots (default: 5)

02/01/2018
- Added gred_stmenu (base settings in the spawnmenu options)
- Added shockwave_sound_instant
- Added client-side CVars
- Updated bombs convars so it can be differentiated from Gbombs convars
- Updated decals, they should now work correctly
- Updated BASE_30MM / BASE_20MM / BASE_MG / POD_MG / POD_GUNNER : Added water partice effects and tracers are now visually bettter.
- Updated POD_GROCKET / BASE_GROCKET : Buffed the damage and added water particle effects / sounds
- Updated POD_GBOMB : fixed an issue that was making the whole map disapear / added admin code for infinite bombs
- Updated welcome message
- Updated water particle effects / textures
- Renamed gb5_convars / gb5_decals / gb5_main / gb5_physics / particles to gred_convars / gred_decals / gred_main / gred_physiscs / gred_particles
- Removed the ugly backdoor from gb5_main ( https://imgur.com/a/WtNJw )
- Removed useless SC500 model

23/12/2017
- Added Day of Infamy artillery sweps (testing)
- Added SHELL_105MM / SHELL_NEBELROCKET / BOMB_500GP / BOMB_2000GP / BOMB_SC1000
- Added gredwitch_addon_verify (to verify if the base addon is installed)
- Added 30mm impact sound
- Added WAC_HC_BASE : added better fire particles when the engine(s) is(are) on fire
- Added some materials for 1000Kg explosion
- Fixed 250GP model
- Fixed bombs radius
- Updated POD_MG
- Updated POD_GUNNER
- Updated POD_GBOMBS
- Updated shockwave_ent
- Updated particles
- Renamed BASE_HEROUNDS to BASE_MG

27/11/2017
- Added BASE_20MM and BASE_30MM
- Added BOMB_FAB250
- Added WAC_PL_BASE (fixes inside sounds)
- Updated POD_GBOMB (Bombs are now safer: they won't explode when the engine is destroyed)
- Updated BASE_BOMB
- Updated sounds
- Updated BOMB_250GP (fixed the model)
- Renamed BASE_HEROUNDS to BASE_MG
- Renamed POD_M2G to POD_MG
- Removed all the admin PODs

29/10/2017
- Added GBombs compatiblity with POD_GBOMB
- Added basic Gbombs base stuff (BASE_BOMB / SHOCKWAVE_ENT / SHOCKWAVE_SOUND_LOWSH )
- Added BOMB_250GP / BOMB_GBU12 / BOMB_GBU38 / BOMB_MK82 / BOMB_SC100 / BOMB_SC500
- Added Day of Infamy and Insurgency particle systems, materials / models
- Updated impact effect and replaced them by Day of Infamy gunrun impact effects
- Updated sounds
- Removed WAC_A10WARTHOGSHOT
- Removed WAC_BIG_IMPACT
- Removed WAC_GAU_IMPACT
- Removed WAC_AFTERBURNER
- Removed WAC_HEATWAVE

15/10/2017
- Added POD_MGUNNER (POD_GUNNER with green tracers)
- Added HAWX rocket models (testing)
- Added German and American radios
- Added POD_HYDRA (Hydra 70 pod with crosshair)
- Updated MG 17, added crosshair for gun camera
- Updated all of the PODs, merged init and cl_init to shared (if it was possible)
- Removed HC_HEROUNDSGAU4
- Removed POD_GHYDRA
- Removed POD_GMINIGUN
- Renamed POD_CANNON_GAU4 to POD_OPCANNON
- Renamed HC_HEROUNDS and HC_GROCKET to BASE_HEROUNDS and BASE_GROCKET
- Renamed POD_AIM7 to POD_MIS
--]]
