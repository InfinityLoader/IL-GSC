/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: _urgent_walk.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 44 ms
 * Timestamp: 4/22/2024 2:23:35 AM
*******************************************************************/

//Function Number: 1
set_urgent_walk_anims()
{
	if(isdefined(self.isurgentwalk))
	{
		return;
	}

	maps\_utility::gun_remove();
	self.isurgentwalk = 1;
	self.dynamicturnscaling = 1;
	self.alertlevel = "noncombat";
	self.alertlevelint = 0;
	var_00 = ["exposed","exposed_crouch"];
	var_01[1] = %npc_urgent_walk_arrive_1;
	var_01[2] = %npc_urgent_walk_arrive_2;
	var_01[3] = %npc_urgent_walk_arrive_3;
	var_01[4] = %npc_urgent_walk_arrive_4;
	var_01[6] = %npc_urgent_walk_arrive_6;
	var_01[7] = %npc_urgent_walk_arrive_7;
	var_01[8] = %npc_urgent_walk_arrive_8;
	var_01[9] = %npc_urgent_walk_arrive_9;
	var_02[1] = %npc_urgent_walk_exit_1;
	var_02[2] = %npc_urgent_walk_exit_2;
	var_02[3] = %npc_urgent_walk_exit_3;
	var_02[4] = %npc_urgent_walk_exit_4;
	var_02[6] = %npc_urgent_walk_exit_6;
	var_02[7] = %npc_urgent_walk_exit_7;
	var_02[8] = %npc_urgent_walk_exit_8;
	var_02[9] = %npc_urgent_walk_exit_9;
	var_03[0] = %npc_urgent_walk_turn_2;
	var_03[1] = %npc_urgent_walk_turn_1;
	var_03[2] = %npc_urgent_walk_turn_4;
	var_03[3] = %npc_urgent_walk_turn_7;
	var_03[5] = %npc_urgent_walk_turn_9;
	var_03[6] = %npc_urgent_walk_turn_6;
	var_03[7] = %npc_urgent_walk_turn_3;
	var_03[8] = %npc_urgent_walk_turn_2;
	var_04 = [%npc_urgent_walk_twitch01_idle,%npc_urgent_walk_twitch02_idle,%npc_urgent_walk_twitch03_idle,%npc_urgent_walk_idle];
	maps\_utility::set_npc_anims("urgent_walk",%bet_unarmed_casual_walk01_gideon,%bet_unarmed_casual_walk01_gideon,var_04,var_01,var_02,var_00,var_03,var_03,undefined);
}

//Function Number: 2
clear_urgent_walk_anims()
{
	self.dynamicturnscaling = undefined;
	maps\_utility::clear_npc_anims("urgent_walk");
	maps\_utility::gun_recall();
}