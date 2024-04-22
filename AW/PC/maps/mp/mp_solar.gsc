/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: mp\mp_solar.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 6
 * Decompile Time: 103 ms
 * Timestamp: 4/22/2024 2:18:23 AM
*******************************************************************/

//Function Number: 1
main()
{
	maps\mp\mp_solar_precache::main();
	maps\createart\mp_solar_art::main();
	maps\mp\mp_solar_fx::main();
	maps\mp\mp_solar_aud::main();
	maps\mp\mp_solar_lighting::main();
	maps\mp\_load::main();
	maps\mp\_compass::setupminimap("compass_map_mp_solar");
	game["attackers"] = "allies";
	game["defenders"] = "axis";
	level.mapcustomkillstreakfunc = ::solarcustomkillstreakfunc;
	level thread setup_audio();
	level.orbitalsupportoverridefunc = ::solarpaladinoverrides;
	level thread init_fans();
	level.ospvisionset = "mp_solar_osp";
	level.osplightset = "mp_solar_osp";
	level.warbirdvisionset = "mp_solar_warbird";
	level.warbirdlightset = "mp_solar_warbird";
	level.dronevisionset = "mp_solar_drone";
	level.dronelightset = "mp_solar_drone";
	if(level.nextgen)
	{
		setdvar("sm_polygonOffsetPreset",2);
	}

	maps\mp\_water::init();
}

//Function Number: 2
solarcustomkillstreakfunc()
{
	level thread maps\mp\killstreaks\streak_mp_solar::init();
}

//Function Number: 3
setup_audio()
{
	ambientplay("amb_mp_solar_ext");
}

//Function Number: 4
solarpaladinoverrides()
{
	level.orbitalsupportoverrides.spawnheight = 9079;
}

//Function Number: 5
init_fans()
{
	var_00 = getentarray("solar_fan","targetname");
	common_scripts\utility::array_thread(var_00,::run_fan);
}

//Function Number: 6
run_fan()
{
	var_00 = 1800;
	var_01 = randomfloatrange(700,750);
	for(;;)
	{
		self rotatevelocity((var_01,0,0),var_00);
		wait(var_00);
	}
}