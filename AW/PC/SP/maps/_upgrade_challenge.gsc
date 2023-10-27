/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps/_upgrade_challenge.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 12
 * Decompile Time: 196 ms
 * Timestamp: 10/27/2023 2:01:15 AM
*******************************************************************/

//Function Number: 1
init()
{
	upgrade_init_tables();
	if(isdefined(level.player))
	{
		upgrade_init_player(level.player);
	}
}

//Function Number: 2
upgrade_init_tables()
{
	level.upgrade_chal_stat_map = [];
	level.upgrade_chal_stat_map["kills"] = "ch_kills";
	level.upgrade_chal_stat_map["headshots"] = "ch_headshots";
	level.upgrade_chal_stat_map["kills_grenades"] = "ch_frag_kills";
	level.upgrade_chal_stat_map["intel"] = "ch_intel";
	level.upgrade_chal_index = [];
	level.upgrade_chal_complete_messages = [];
	level.upgrade_chal_points_trackers = [];
	var_00 = 0;
	for(;;)
	{
		var_01 = int(tablelookupbyrow("sp/upgrade_challenges.csv",var_00,0));
		var_02 = tablelookupbyrow("sp/upgrade_challenges.csv",var_00,1);
		if(var_02 == "")
		{
			break;
		}

		level.upgrade_chal_index[var_02] = var_01;
		level.upgrade_chal_goal[var_01] = [];
		level.upgrade_chal_complete_messages[var_01] = tablelookupbyrow("sp/upgrade_challenges.csv",var_00,4);
		level.upgrade_chal_points_trackers[var_01] = 0;
		var_03 = 10;
		for(;;)
		{
			var_04 = int(tablelookupbyrow("sp/upgrade_challenges.csv",var_00,var_03));
			if(var_04 <= 0)
			{
				break;
			}

			level.upgrade_chal_goal[var_01][level.upgrade_chal_goal[var_01].size] = var_04;
			var_03++;
		}

		var_00++;
	}
}

//Function Number: 3
upgrade_init_player(param_00)
{
	param_00 maps\_player_stats::stat_notify_register_func(::upgrade_notify_stat);
	if(isdefined(level.upgrade_chal_index) && level.upgrade_chal_index.size > 0)
	{
		param_00.stats["upgradeChallengeStage"] = [];
		param_00.stats["upgradeChallengeProgress"] = [];
		if(!isdefined(param_00.stats["upgradePoints"]))
		{
			param_00.stats["upgradePoints"] = 0;
		}

		foreach(var_03, var_02 in level.upgrade_chal_stat_map)
		{
			param_00 upgrade_notify_stat(var_03,0);
		}
	}
}

//Function Number: 4
give_player_challenge_kill(param_00)
{
	upgrade_notify_stat("kills",param_00);
}

//Function Number: 5
give_player_challenge_headshot(param_00)
{
	upgrade_notify_stat("headshots",param_00);
	give_player_challenge_kill(param_00);
}

//Function Number: 6
give_player_challenge_frag(param_00)
{
	upgrade_notify_stat("kills_grenades",param_00);
	give_player_challenge_kill(param_00);
}

//Function Number: 7
upgrade_notify_stat(param_00,param_01)
{
	if(isdefined(level.upgrade_chal_stat_map) && isdefined(level.upgrade_chal_stat_map[param_00]))
	{
		if(!isdefined(level.upgrade_chal_index[level.upgrade_chal_stat_map[param_00]]))
		{
			return;
		}

		var_02 = level.upgrade_chal_index[level.upgrade_chal_stat_map[param_00]];
		var_03 = getomnvar("ui_pm_t_" + param_00);
		setomnvar("ui_pm_t_" + param_00,var_03 + param_01);
		if(param_00 == "intel")
		{
			var_04 = int(self getlocalplayerprofiledata("sp_upgradeChallengeStage_" + var_02));
			if(!isdefined(self.stats["upgradeChallengeStage"][param_00]))
			{
				self.stats["intelUpgradePoints"] = 0;
				setomnvar("ui_pm_g_start_intel",var_04);
			}

			self.stats["upgradeChallengeStage"][param_00] = var_04;
			var_05 = int(self getlocalplayerprofiledata("sp_upgradeChallengeProgress_" + var_02));
			if(!isdefined(self.stats["upgradeChallengeProgress"][param_00]))
			{
				setomnvar("ui_pm_p_start_intel",var_05);
			}

			self.stats["upgradeChallengeProgress"][param_00] = var_05;
		}
		else
		{
			var_04 = 0;
			if(!isdefined(self.stats["upgradeChallengeStage"][param_01]))
			{
				var_05 = int(self getlocalplayerprofiledata("sp_upgradeChallengeStage_" + var_03));
				self.stats["upgradeChallengeStage"][param_01] = var_05;
			}
			else
			{
				var_05 = self.stats["upgradeChallengeStage"][param_01];
			}

			var_05 = 0;
			if(!isdefined(self.stats["upgradeChallengeProgress"][param_00]))
			{
				var_05 = int(self getlocalplayerprofiledata("sp_upgradeChallengeProgress_" + var_02));
				self.stats["upgradeChallengeProgress"][param_00] = var_05;
			}
			else
			{
				var_05 = self.stats["upgradeChallengeProgress"][param_00];
			}
		}

		var_06 = level.upgrade_chal_goal[var_02].size - 1;
		var_07 = level.upgrade_chal_goal[var_02][var_06];
		if(var_04 >= var_06 && var_05 >= var_07)
		{
			setomnvar("ui_pm_g_" + param_00,level.upgrade_chal_goal[var_02][var_06]);
			setomnvar("ui_pm_p_" + param_00,var_07);
			return;
		}

		var_08 = level.upgrade_chal_goal[var_02][var_04];
		var_09 = var_05;
		var_05 = var_05 + param_01;
		var_0A = 0;
		while(var_04 <= var_06 && var_05 >= var_08 && !var_0A)
		{
			notifychallengecomplete(level.upgrade_chal_complete_messages[var_02]);
			if(param_00 == "intel")
			{
				upgrade_challenge_complete_for_intel(var_02);
			}
			else
			{
				upgrade_challenge_complete(var_02);
			}

			if(var_04 >= var_06 && var_05 >= var_07)
			{
				var_05 = var_07;
				var_0A = 1;
				continue;
			}

			var_05 = var_05 - var_08;
			var_04++;
			if(var_04 <= var_06)
			{
				var_08 = level.upgrade_chal_goal[var_02][var_04];
			}
		}

		self.stats["upgradeChallengeStage"][param_00] = var_04;
		self.stats["upgradeChallengeProgress"][param_00] = var_05;
		setomnvar("ui_pm_g_" + param_00,level.upgrade_chal_goal[var_02][var_04]);
		setomnvar("ui_pm_p_" + param_00,var_05);
		if(param_00 == "intel")
		{
			commit_exo_awards_stage_and_progress(param_00,1);
		}
	}
}

//Function Number: 8
upgrade_challenge_complete_for_intel(param_00,param_01)
{
	commit_exo_awards_upgrade_points_custom(1);
	self.stats["intelUpgradePoints"]++;
	level.upgrade_chal_points_trackers[param_00] = self.stats["intelUpgradePoints"];
	var_02 = tablelookupbyrow("sp/upgrade_challenges.csv",param_00,6);
	setomnvar(var_02,level.upgrade_chal_points_trackers[param_00]);
}

//Function Number: 9
upgrade_challenge_complete(param_00)
{
	if(!isdefined(self.stats["upgradePoints"]))
	{
		self.stats["upgradePoints"] = 0;
	}

	self.stats["upgradePoints"]++;
	level.upgrade_chal_points_trackers[param_00] = level.upgrade_chal_points_trackers[param_00] + 1;
	var_01 = tablelookupbyrow("sp/upgrade_challenges.csv",param_00,6);
	setomnvar(var_01,level.upgrade_chal_points_trackers[param_00]);
}

//Function Number: 10
commit_exo_awards_upgrade_points_custom(param_00)
{
	if(isdefined(level.player))
	{
		var_01 = level.player;
		var_02 = int(var_01 getlocalplayerprofiledata("sp_upgradePoints"));
		var_03 = var_02 + param_00;
		if(var_03 > var_02)
		{
			var_01 setlocalplayerprofiledata("sp_upgradePoints",var_03);
		}
	}
}

//Function Number: 11
commit_exo_awards_stage_and_progress(param_00,param_01)
{
	if(isdefined(level.player))
	{
		var_02 = level.player;
		var_03 = level.upgrade_chal_index[level.upgrade_chal_stat_map[param_00]];
		var_04 = 0;
		if(isdefined(var_02.stats["upgradeChallengeStage"][param_00]))
		{
			var_04 = var_02.stats["upgradeChallengeStage"][param_00];
			var_05 = int(var_02 getlocalplayerprofiledata("sp_upgradeChallengeStage_" + var_03));
			if(var_04 > var_05)
			{
				var_02 setlocalplayerprofiledata("sp_upgradeChallengeStage_" + var_03,var_04);
			}
		}

		var_06 = 0;
		if(isdefined(var_02.stats["upgradeChallengeProgress"][param_00]))
		{
			var_06 = var_02.stats["upgradeChallengeProgress"][param_00];
			var_07 = int(var_02 getlocalplayerprofiledata("sp_upgradeChallengeProgress_" + var_03));
			if(var_06 != var_07)
			{
				var_02 setlocalplayerprofiledata("sp_upgradeChallengeProgress_" + var_03,var_06);
			}
		}

		if(param_01)
		{
			updategamerprofileall();
		}
	}
}

//Function Number: 12
commit_exo_awards_upon_mission_success()
{
	if(isdefined(level.player))
	{
		var_00 = level.player;
		commit_exo_awards_upgrade_points_custom(var_00.stats["upgradePoints"]);
		if(isdefined(level.upgrade_chal_stat_map))
		{
			foreach(var_04, var_02 in level.upgrade_chal_stat_map)
			{
				if(var_04 == "intel")
				{
					continue;
				}

				var_03 = var_04;
				if(!isdefined(level.upgrade_chal_index[level.upgrade_chal_stat_map[var_03]]))
				{
					continue;
				}

				if(!isdefined(level.upgrade_chal_stat_map[var_03]))
				{
					continue;
				}

				commit_exo_awards_stage_and_progress(var_03,0);
			}
		}

		updategamerprofileall();
	}
}