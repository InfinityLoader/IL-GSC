/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\mp\agents\pamgrier\pamgrier_tunedata.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 3
 * Decompile Time: 191 ms
 * Timestamp: 10/27/2023 12:11:19 AM
*******************************************************************/

//Function Number: 1
setuptunedata()
{
	if(!isdefined(level.agenttunedata))
	{
		level.agenttunedata = [];
	}

	level.agenttunedata["pamgrier"] = spawnstruct();
	setuppamgriertunedata(level.agenttunedata["pamgrier"]);
}

//Function Number: 2
setuppamgriertunedata(param_00)
{
	param_00.min_time_between_attacks = 1000;
	param_00.max_time_between_attacks = 2000;
	param_00.min_chillin_time = 15000;
	param_00.max_chillin_time = 25000;
	param_00.max_non_chillin_time = 10000;
	param_00.chill_time_before_going_passive = 8;
	param_00.min_moving_pain_dist = 128;
	param_00.target_agent_types = [];
	param_00.target_agent_types[0] = "karatemaster";
	param_00.target_agent_types[1] = "generic_zombie";
	param_00.min_target_path_dist_to_goal = 100;
	param_00.teleport_behind_target_dist = 24;
	param_00.teleport_attack_dist_to_target = 50;
	param_00.telefrag_dist_sq = 1600;
	param_00.navmesh_correction_dist_sq = 16;
	param_00.player_too_close_teleport_dist_sq = 1600;
	param_00.max_teleports_per_chill = 3;
	param_00.melee_attack_range_sq = 30625;
	param_00.revive_right_offset = 32;
	param_00.revive_forward_offset = 60;
	param_00.max_revive_snapp_2d_dist_sq = 64;
	param_00.max_revive_snap_z_dist = 32;
	param_00.revive_wait_time = 2;
	param_00.min_time_between_revivals = 5000;
	param_00.min_time_between_revivals_solo = -5536;
	param_00.max_dist_to_revive_player_sq = 10000;
	param_00.max_time_to_attack_targets_when_player_needs_revive_ms = 4000;
	param_00.min_wait_time = 500;
	param_00.max_wait_time = 1000;
	param_00.min_wait_time_before_teleport = 1000;
	param_00.min_wait_for_twitch_time = 2;
	param_00.max_wait_for_twitch_time = 4.5;
}

//Function Number: 3
gettunedata()
{
	return level.agenttunedata["pamgrier"];
}