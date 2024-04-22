/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: mp\mp_seoul2.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 9
 * Decompile Time: 156 ms
 * Timestamp: 4/22/2024 2:18:21 AM
*******************************************************************/

//Function Number: 1
main()
{
	level.callbackstartgametype = ::seoul2_callbackstartgametype;
	maps\mp\mp_seoul2_precache::main();
	maps\createart\mp_seoul2_art::main();
	maps\mp\mp_seoul2_fx::main();
	maps\mp\_load::main();
	maps\mp\mp_seoul2_lighting::main();
	maps\mp\mp_seoul2_aud::main();
	maps\mp\_compass::setupminimap("compass_map_mp_seoul2");
	game["attackers"] = "allies";
	game["defenders"] = "axis";
	level.mapcustomkillstreakfunc = ::seoul2customkillstreakfunc;
	level thread seoul2customairstrikeheight();
	level thread setup_physics_objects();
	level thread setupsupportdropvolumes();
	level.orbitallaseroverridefunc = ::seoulcustomorbitallaserfunc;
	level.orbitalsupportoverridefunc = ::seoulcustomospfunc;
	level.ospvisionset = "mp_seoul2_osp";
	level.osplightset = "mp_seoul2_osp";
	level.warbirdvisionset = "mp_seoul2_osp";
	level.warbirdlightset = "mp_seoul2_osp";
	level.vulcanvisionset = "mp_seoul2_osp";
	level.vulcanlightset = "mp_seoul2_osp";
	level.dronevisionset = "mp_seoul2_osp";
	level.dronelightset = "mp_seoul2_osp";
	level.swarmvisionset = "mp_seoul2_osp";
	level.swarmlightset = "mp_seoul2_osp";
	if(level.nextgen)
	{
		level thread drone_anims();
	}
}

//Function Number: 2
seoul2_callbackstartgametype()
{
	maps\mp\gametypes\_gamelogic::callback_startgametype();
	common_scripts\_bcs_location_trigs_dlc::bcs_location_trigs_dlc_init();
}

//Function Number: 3
setup_physics_objects()
{
	var_00 = getentarray("physics_lanterns","targetname");
	var_01 = getentarray("physics_alley_lights","targetname");
	foreach(var_03 in var_01)
	{
		var_03 method_856C(1);
	}

	foreach(var_06 in var_00)
	{
		var_06 method_856C(1);
	}
}

//Function Number: 4
seoul2customkillstreakfunc()
{
	level thread maps\mp\killstreaks\streak_mp_seoul2::streak_init();
}

//Function Number: 5
seoul2customairstrikeheight()
{
	if(!isdefined(level.airstrikeoverrides))
	{
		level.airstrikeoverrides = spawnstruct();
	}

	level.airstrikeoverrides.spawnheight = 5000;
	level.remote_missile_height_override = 18000;
}

//Function Number: 6
seoulcustomorbitallaserfunc()
{
	level.orbitallaseroverrides.spawnheight = 3000;
}

//Function Number: 7
seoulcustomospfunc()
{
	level.orbitalsupportoverrides.spawnradius = 4500;
	level.orbitalsupportoverrides.spawnheight = 8000;
	level.orbitalsupportoverrides.leftarc = 25;
	level.orbitalsupportoverrides.rightarc = 25;
	level.orbitalsupportoverrides.toparc = -40;
	level.orbitalsupportoverrides.bottomarc = 70;
}

//Function Number: 8
setupsupportdropvolumes()
{
	var_00 = getent("badplace_trigs","targetname");
	while(!isdefined(level.orbital_util_covered_volumes))
	{
		wait 0.05;
	}

	level.orbital_util_covered_volumes[level.orbital_util_covered_volumes.size] = var_00;
	while(!isdefined(level.goliath_bad_landing_volumes))
	{
		wait 0.05;
	}

	level.goliath_bad_landing_volumes[level.goliath_bad_landing_volumes.size] = var_00;
}

//Function Number: 9
drone_anims()
{
	var_00 = getent("drone_cleaner_01","targetname");
	maps\mp\_audio::scriptmodelplayanimwithnotify_uniquename(var_00,"lost_repair_drone_standby_idle02","drone_cleaner_01_notify","aud_lost_drone_idle_02","mp_seoul2_drone_idle_02","aud_drone_01_end_01","aud_drone_01_end_02","aud_drone_01_end_03");
	var_00 thread maps\mp\mp_seoul2_fx::play_drill_fx();
	var_01 = getent("drone_cleaner_02","targetname");
	maps\mp\_audio::scriptmodelplayanimwithnotify_uniquename(var_01,"lost_repair_drone_standby_idle03","drone_cleaner_02_notify","aud_lost_drone_idle_03","mp_seoul2_drone_idle_03","aud_drone_02_end_01","aud_drone_02_end_02","aud_drone_02_end_03");
	var_02 = getent("drone_cleaner_03","targetname");
	maps\mp\_audio::scriptmodelplayanimwithnotify_uniquename(var_02,"lost_repair_drone_standby_idle03","drone_cleaner_03_notify","aud_lost_drone_idle_03","mp_seoul2_drone_idle_03b","aud_drone_03_end_01","aud_drone_03_end_02","aud_drone_03_end_03");
}