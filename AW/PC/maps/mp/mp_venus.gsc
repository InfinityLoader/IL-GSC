/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: mp\mp_venus.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 6
 * Decompile Time: 100 ms
 * Timestamp: 4/22/2024 2:18:43 AM
*******************************************************************/

//Function Number: 1
main()
{
	maps\mp\mp_venus_precache::main();
	maps\createart\mp_venus_art::main();
	maps\mp\mp_venus_fx::main();
	maps\mp\_load::main();
	maps\mp\mp_venus_lighting::main();
	maps\mp\mp_venus_aud::main();
	level.aerial_pathnode_offset = 600;
	level.aerial_pathnode_group_connect_dist = 300;
	level.aerial_pathnodes_force_connect[0] = spawnstruct();
	level.aerial_pathnodes_force_connect[0].origin = (-618,-1166,1123);
	level.aerial_pathnodes_force_connect[0].radius = 250;
	level.aerial_pathnodes_force_connect[1] = spawnstruct();
	level.aerial_pathnodes_force_connect[1].origin = (-944,845,1245);
	level.aerial_pathnodes_force_connect[1].radius = 300;
	maps\mp\_compass::setupminimap("compass_map_mp_venus");
	game["attackers"] = "allies";
	game["defenders"] = "axis";
	maps\mp\_water::init();
	level.ospvisionset = "mp_venus_osp";
	level.warbirdvisionset = "mp_venus_osp";
	level.vulcanvisionset = "mp_venus_osp";
	var_00 = getnodearray("pool_nodes","targetname");
	foreach(var_02 in var_00)
	{
		nodesetnotusable(var_02,1);
	}

	level.orbitalsupportoverridefunc = ::venuscustomospfunc;
	thread venuscustomairstrike();
	thread handle_glass_pathing();
	level.goliath_bad_landing_volumes = getentarray("goliath_bad_landing_volume","targetname");
}

//Function Number: 2
venuscustomairstrike()
{
	if(!isdefined(level.airstrikeoverrides))
	{
		level.airstrikeoverrides = spawnstruct();
	}

	level.airstrikeoverrides.spawnheight = 2100;
}

//Function Number: 3
venuscustomospfunc()
{
	level.orbitalsupportoverrides.toparc = -39;
	level.orbitalsupportoverrides.spawnheight = 9563.06;
	if(level.currentgen)
	{
		level.orbitalsupportoverrides.leftarc = 20;
		level.orbitalsupportoverrides.rightarc = 20;
		level.orbitalsupportoverrides.toparc = -35;
		level.orbitalsupportoverrides.bottomarc = 60;
	}
}

//Function Number: 4
handle_glass_pathing()
{
	var_00 = getglassarray("skylights");
	var_01 = getentarray("skylights","targetname");
	var_02 = getentarray("glass_pathing","targetname");
	if(!isdefined(var_01))
	{
		return 0;
	}

	var_03 = 8;
	foreach(var_05 in var_00)
	{
		var_06 = getglassorigin(var_05);
		foreach(var_08 in var_01)
		{
			if(distance(var_06,var_08.origin) <= var_03)
			{
				var_08.glass_id = var_05;
				break;
			}
		}
	}

	common_scripts\utility::array_thread(var_01,::handle_pathing_on_glass);
}

//Function Number: 5
handle_pathing_on_glass()
{
	level endon("game_ended");
	var_00 = getent(self.target,"targetname");
	if(!isdefined(var_00))
	{
		return 0;
	}

	var_00 common_scripts\utility::trigger_off();
	var_00 connectpaths();
	waittill_glass_break(self.glass_id);
	var_00 common_scripts\utility::trigger_on();
	var_00 disconnectpaths();
	var_00 common_scripts\utility::trigger_off();
}

//Function Number: 6
waittill_glass_break(param_00)
{
	level endon("game_ended");
	for(;;)
	{
		if(isglassdestroyed(param_00))
		{
			return 1;
		}

		wait(0.05);
	}
}