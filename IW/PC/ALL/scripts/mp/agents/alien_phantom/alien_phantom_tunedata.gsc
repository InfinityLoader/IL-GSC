/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\mp\agents\alien_phantom\alien_phantom_tunedata.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 145 ms
 * Timestamp: 10/27/2023 12:11:06 AM
*******************************************************************/

//Function Number: 1
setuptunedata()
{
	if(!isdefined(level.agenttunedata))
	{
		level.agenttunedata = [];
	}

	level.agenttunedata["alien_phantom"] = spawnstruct();
	setupmytunedata(level.agenttunedata["alien_phantom"]);
}

//Function Number: 2
setupmytunedata(param_00)
{
	scripts\mp\agents\alien_goon\alien_goon_tunedata::setupmytunedata(param_00);
	param_00.goon_health_multiplier = 7;
	param_00.force_melee_attack_damage_radius_sq = 1024;
	param_00.teleport_chance = 100;
	param_00.min_dist_to_teleport_sq = 90000;
	param_00.max_leap_distance_sq = 1000000;
}