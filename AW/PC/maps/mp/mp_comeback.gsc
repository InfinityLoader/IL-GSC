/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: mp\mp_comeback.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 7
 * Decompile Time: 107 ms
 * Timestamp: 4/22/2024 2:17:16 AM
*******************************************************************/

//Function Number: 1
main()
{
	maps\mp\mp_comeback_precache::main();
	maps\createart\mp_comeback_art::main();
	maps\mp\mp_comeback_fx::main();
	maps\mp\_load::main();
	maps\mp\mp_comeback_lighting::main();
	maps\mp\mp_comeback_aud::main();
	level.aerial_pathnode_offset = 600;
	level.aerial_pathnode_group_connect_dist = 275;
	maps\mp\_compass::setupminimap("compass_map_mp_comeback");
	game["attackers"] = "allies";
	game["defenders"] = "axis";
	level.mapcustomkillstreakfunc = ::comebackcustomkillstreakfunc;
	level.orbitalsupportoverridefunc = ::comebackcustomospfunc;
	level thread init_ceiling_fans();
	level thread init_traffic();
	level.ospvisionset = "mp_comeback_osp";
	level.osplightset = "mp_comeback_osp";
	level.dronevisionset = "mp_comeback_drone";
	level.dronelightset = "mp_comeback_drone";
	level.warbirdvisionset = "mp_comeback_warbird";
	level.warbirdlightset = "mp_comeback_warbird";
	level.goliath_bad_landing_volumes = getentarray("goliath_bad_landing_volume","targetname");
	maps\mp\killstreaks\_aerial_utility::patchheliloopnode((-2172,364,1836),(-1472,364,1836));
}

//Function Number: 2
comebackcustomkillstreakfunc()
{
	level thread maps\mp\killstreaks\streak_mp_comeback::init();
}

//Function Number: 3
comebackcustomospfunc()
{
	if(level.currentgen)
	{
		level.orbitalsupportoverrides.spawnanglemin = 30;
		level.orbitalsupportoverrides.spawnanglemax = 90;
		level.orbitalsupportoverrides.spawnheight = 9541;
		level.orbitalsupportoverrides.leftarc = 15;
		level.orbitalsupportoverrides.rightarc = 15;
		level.orbitalsupportoverrides.toparc = -40;
		level.orbitalsupportoverrides.bottomarc = 60;
	}
}

//Function Number: 4
init_ceiling_fans()
{
	var_00 = getentarray("ceiling_fan","targetname");
	common_scripts\utility::array_thread(var_00,::ceiling_fan);
}

//Function Number: 5
ceiling_fan()
{
	var_00 = 1800;
	var_01 = randomfloatrange(700,750);
	for(;;)
	{
		self rotatevelocity((0,var_01,0),var_00);
		wait(var_00);
	}
}

//Function Number: 6
init_traffic()
{
	var_00 = [];
	for(var_01 = 1;var_01 <= 7;var_01++)
	{
		var_02 = "mp_comeback_vista_cars_0" + var_01;
		precachempanim(var_02);
		var_00[var_00.size] = var_02;
	}

	var_03 = getentarray("traffic","targetname");
	for(var_01 = 0;var_01 < var_03.size && var_00.size;var_01++)
	{
		var_03[var_01] thread run_traffic(var_00[var_01]);
	}
}

//Function Number: 7
run_traffic(param_00)
{
	self scriptmodelplayanimdeltamotionfrompos(param_00,(0,0,0),(0,0,0));
}