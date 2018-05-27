--[[
15/10/2017 (10/15/2017)

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

29/10/2017 (10/27/2017)

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

27/11/2017 (11/27/2017)

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

23/12/2017 (12/20/2017)

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

02/01/2018 (02/01/2018)

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

02/02/2018 (02/02/2018)

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

06/02/2018 (02/06/2018)

- Added a new FAB-250 model (from ECF pack)
- Added a 13cm Nebelwerfer rocket (model from Gbombs)
- Added a 105mm shell (model from Day of Infamy)
- Fixed artillery SWEPs
- Fixed binoculars model
- Fixed POD_GROCKET / POD_MG / BASE_20MM / BASE_30MM /BASE_MG : entities should not collide on the aircraft anymore
- Updated BOMB_BASE and BASE_ROCKET
- Updated every BOMB_ : removed useless code
- Removed RAPE SWEP

30/03/2018 (03/30/2018)

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

02/04/2018 (04/02/2018)

- Updated BASE_7MM : buffed it and added an explosive damage options
- Updated gred_stmenu : fixed the whole spawnmenu options
- Updated BASE_ROCKET and BASE_BOMB : fixed "Changing collision rules within a callback is likely to cause crashes!" error
- Updated shockwave_sound_lowsh : reduced maximum sound range
- Updated shockwave_ent : fixed random errors
- Updated gred_convars

08/04/2018 (04/08/2018)

- Added a new 500LB GP model (thanks to damik)
- Updated particles : fixed the Day of Infamy and Insurgency particles being white
- Updated gred_stmenu
- Updated gred_convars
- Updated BASE_7MM : added compatibility with the Insurgency particles
- Updated POD_GROCKET / POD_MIS / POD_MG / POD_GUNNER : projectiles won't collide with the aircraft
- Updated materials

15/04/2018 (04/15/2018)

- Added gred_overwrite_wac : this should fix WAC not getting overridden
- Updated impact_fx_ins : smoke is now way less thick
- Updated gred_convars
- Updated gred_stmenu
- Updated POD_GBOMB : bombs shouldn't affect the aircraft's maniabillity anymore
- Updated BASE_ROCKET / BASE_GBOMB : fixed the Insurgency water explosion effect being in the wrong angle

24/05/2018 (05/24/2018)

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

27/05/2018 (05/27/2018)

- Fixed POD_GUNNER
- Fixed the deleted rocket sound
- Fixed the Nebelwerfer artillery sounds not playing
- Updated the artillery sounds
--]]