/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: _stealth_corpse_system.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 10
 * Decompile Time: 153 ms
 * Timestamp: 4/22/2024 2:23:04 AM
*******************************************************************/

//Function Number: 1
stealth_corpse_system_main()
{
	stealth_corpse_system_init();
}

//Function Number: 2
stealth_corpse_system_init()
{
	common_scripts\utility::flag_init("_stealth_found_corpse");
	level._stealth.logic.corpse = spawnstruct();
	level._stealth.logic.corpse.last_pos = undefined;
	level._stealth.logic.corpse.distances = [];
	stealth_corpse_default_distances();
	level._stealth.logic.corpse.corpse_height = 6;
	stealth_corpse_default_forget_time();
	stealth_corpse_default_reset_time();
	level._stealth.behavior.corpse = spawnstruct();
}

//Function Number: 3
stealth_corpse_default_distances()
{
	var_00 = [];
	var_00["player_dist"] = 1500;
	var_00["sight_dist"] = 1500;
	var_00["detect_dist"] = 256;
	var_00["found_dist"] = 96;
	var_00["found_dog_dist"] = 50;
	stealth_corpse_set_distances(var_00);
}

//Function Number: 4
stealth_corpse_set_distances(param_00)
{
	foreach(var_03, var_02 in param_00)
	{
		level._stealth.logic.corpse.distances[var_03] = var_02;
	}

	level._stealth.logic.corpse.player_distsqrd = squared(level._stealth.logic.corpse.distances["player_dist"]);
	level._stealth.logic.corpse.sight_distsqrd = squared(level._stealth.logic.corpse.distances["sight_dist"]);
	level._stealth.logic.corpse.detect_distsqrd = squared(level._stealth.logic.corpse.distances["detect_dist"]);
	level._stealth.logic.corpse.found_distsqrd = squared(level._stealth.logic.corpse.distances["found_dist"]);
	level._stealth.logic.corpse.found_dog_distsqrd = squared(level._stealth.logic.corpse.distances["found_dog_dist"]);
}

//Function Number: 5
stealth_corpse_default_reset_time()
{
	stealth_corpse_set_reset_time(30);
}

//Function Number: 6
stealth_corpse_set_reset_time(param_00)
{
	level._stealth.logic.corpse.reset_time = param_00;
}

//Function Number: 7
stealth_corpse_default_forget_time()
{
	stealth_corpse_set_forget_time(60);
}

//Function Number: 8
stealth_corpse_set_forget_time(param_00)
{
	level._stealth.logic.corpse.forget_time = param_00;
}

//Function Number: 9
stealth_corpse_set_collect_func(param_00)
{
	level._stealth.logic.corpse.collect_func = param_00;
}

//Function Number: 10
stealth_corpse_default_collect_func()
{
	level._stealth.logic.corpse.collect_func = undefined;
}