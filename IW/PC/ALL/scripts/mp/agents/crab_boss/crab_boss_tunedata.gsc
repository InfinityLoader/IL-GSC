/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\mp\agents\crab_boss\crab_boss_tunedata.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 3
 * Decompile Time: 193 ms
 * Timestamp: 10/27/2023 12:11:09 AM
*******************************************************************/

//Function Number: 1
setuptunedata()
{
	if(!isdefined(level.agenttunedata))
	{
		level.agenttunedata = [];
	}

	level.agenttunedata["crab_boss"] = spawnstruct();
	setupmytunedata(level.agenttunedata["crab_boss"]);
}

//Function Number: 2
setupmytunedata(param_00)
{
	param_00.beam_move_rate = 300;
	param_00.beam_tracking_rate = 250;
	param_00.beam_target_z_offset = 40;
	param_00.spawn_z_offset = 200;
	param_00.spawn_max_radius = 200;
	param_00.spawn_launch_angle = 60;
	param_00.spawn_launch_speed = 200;
	param_00.spawn_interval_min = 0.1;
	param_00.spawn_interval_max = 0.25;
	param_00.max_spawn_over_time_count = 6;
	param_00.egg_sac_spawn_fly_time = 5;
	param_00.egg_sac_bomb_fly_time = 5;
	param_00.egg_sac_toxic_spawn_fly_time = 3;
	param_00.roar_bomb_fly_time = 2;
	param_00.heal_duration = 3;
	param_00.spawn_target_positions = [];
	param_00.spawn_target_positions[param_00.spawn_target_positions.size] = (2570,2681,-106);
	param_00.spawn_target_positions[param_00.spawn_target_positions.size] = (2760,2353,-100);
	param_00.spawn_target_positions[param_00.spawn_target_positions.size] = (3493,2039,-75);
	param_00.spawn_target_positions[param_00.spawn_target_positions.size] = (3072,2242,4);
	param_00.spawn_target_positions[param_00.spawn_target_positions.size] = (3837,2380,68);
	param_00.spawn_target_positions[param_00.spawn_target_positions.size] = (4236,2838,-71);
	param_00.egg_sack_launching_tags = ["tag_egg_1","tag_egg_2","tag_egg_3","tag_egg_4","tag_egg_5","tag_egg_6","tag_egg_7","tag_egg_8","tag_egg_9","tag_egg_10","tag_egg_11","tag_egg_12","tag_egg_13","tag_egg_14","tag_egg_15","tag_egg_16","tag_egg_17","tag_egg_18","tag_egg_19","tag_egg_20","tag_egg_21","tag_egg_22","tag_egg_23","tag_egg_24","tag_egg_25","tag_egg_26","tag_egg_27","tag_egg_28","tag_egg_29","tag_egg_30"];
}

//Function Number: 3
gettunedata()
{
	return level.agenttunedata["crab_boss"];
}