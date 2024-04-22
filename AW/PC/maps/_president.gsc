/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: _president.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 3
 * Decompile Time: 53 ms
 * Timestamp: 4/22/2024 2:22:26 AM
*******************************************************************/

//Function Number: 1
delicate_flower()
{
	self endon("death");
	var_00 = 0;
	for(;;)
	{
		self waittill("damage",var_01,var_02,var_03,var_04,var_05);
		var_00 = var_00 + var_01;
		if(var_05 == "MOD_IMPACT")
		{
			continue;
		}

		if(var_00 < 5)
		{
			continue;
		}

		if(isplayer(var_02))
		{
			break;
		}
	}

	if(self.damageshield)
	{
		maps\_utility::stop_magic_bullet_shield();
	}

	setdvar("ui_deadquote",&"RECOVERY_PRESIDENT_MURDERED");
	thread maps\_utility::missionfailedwrapper();
	self kill();
}

//Function Number: 2
set_president_anims()
{
	if(isdefined(self.ispresident))
	{
		return;
	}

	self.ispresident = 1;
	self.team = "allies";
	self.type = "human";
	self.alertlevel = "noncombat";
	self.alertlevelint = 0;
	self.a.disablepain = 1;
	self pushplayer(1);
	thread delicate_flower();
	maps\_utility::gun_remove();
	var_00 = ["exposed","exposed_crouch"];
	var_01[1] = %rec_president_walk_arrive_1;
	var_01[2] = %rec_president_walk_arrive_2;
	var_01[3] = %rec_president_walk_arrive_3;
	var_01[4] = %rec_president_walk_arrive_4;
	var_01[6] = %rec_president_walk_arrive_6;
	var_01[7] = %rec_president_walk_arrive_7;
	var_01[8] = %rec_president_walk_arrive_8;
	var_01[9] = %rec_president_walk_arrive_9;
	var_02[1] = %rec_president_walk_exit_1;
	var_02[2] = %rec_president_walk_exit_2;
	var_02[3] = %rec_president_walk_exit_3;
	var_02[4] = %rec_president_walk_exit_4;
	var_02[6] = %rec_president_walk_exit_6;
	var_02[7] = %rec_president_walk_exit_7;
	var_02[8] = %rec_president_walk_exit_8;
	var_02[9] = %rec_president_walk_exit_9;
	var_03[0] = %rec_president_run_turn_2;
	var_03[1] = %rec_president_run_turn_1;
	var_03[2] = %rec_president_run_turn_4;
	var_03[3] = %rec_president_run_turn_7;
	var_03[5] = %rec_president_run_turn_9;
	var_03[6] = %rec_president_run_turn_6;
	var_03[7] = %rec_president_run_turn_3;
	var_03[8] = %rec_president_run_turn_2;
	var_04["stairs_down"] = %rec_stairs_run_down;
	var_04["stairs_down_in"] = %rec_stairs_run_down_in;
	var_04["stairs_down_out"] = %rec_stairs_run_down_out;
	maps\_utility::set_npc_anims("president",%rec_president_run,%rec_president_run,[%rec_president_crouch_idle],var_01,var_02,var_00,var_03,var_03,var_04);
}

//Function Number: 3
clear_president_anims()
{
	maps\_utility::clear_npc_anims("president");
}