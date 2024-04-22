/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: mp\bots\_bots_gametype_dom.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 45
 * Decompile Time: 668 ms
 * Timestamp: 4/22/2024 2:08:39 AM
*******************************************************************/

//Function Number: 1
main()
{
	level.bot_ignore_precalc_paths = 0;
	if(level.currentgen)
	{
		level.bot_ignore_precalc_paths = 1;
	}

	setup_callbacks();
	setup_bot_dom();
	level thread maps\mp\bots\_bots_util::bot_monitor_enemy_camp_spots(::maps\mp\bots\_bots_util::bot_valid_camp_assassin);
}

//Function Number: 2
setup_callbacks()
{
	level.bot_funcs["crate_can_use"] = ::crate_can_use;
	level.bot_funcs["gametype_think"] = ::bot_dom_think;
	level.bot_funcs["should_start_cautious_approach"] = ::should_start_cautious_approach_dom;
	level.bot_funcs["leader_dialog"] = ::bot_dom_leader_dialog;
	if(!level.bot_ignore_precalc_paths)
	{
		level.bot_funcs["get_watch_node_chance"] = ::bot_dom_get_node_chance;
	}
}

//Function Number: 3
crate_can_use(param_00)
{
	if(isagent(self) && !isdefined(param_00.boxtype))
	{
		return 0;
	}

	if(!maps\mp\_utility::isteamparticipant(self))
	{
		return 1;
	}

	return maps\mp\bots\_bots_util::bot_is_protecting();
}

//Function Number: 4
monitor_zone_control()
{
	self notify("monitor_zone_control");
	self endon("monitor_zone_control");
	self endon("death");
	level endon("game_ended");
	for(;;)
	{
		wait(1);
		var_00 = maps\mp\gametypes\dom::getflagteam();
		if(var_00 != "neutral")
		{
			var_01 = getzonenearest(self.origin);
			if(isdefined(var_01))
			{
				botzonesetteam(var_01,var_00);
			}
		}
	}
}

//Function Number: 5
monitor_flag_ownership()
{
	self notify("monitor_flag_ownership");
	self endon("monitor_flag_ownership");
	self endon("death");
	level endon("game_ended");
	var_00 = maps\mp\gametypes\dom::getflagteam();
	for(;;)
	{
		var_01 = maps\mp\gametypes\dom::getflagteam();
		if(var_01 != var_00)
		{
			level notify("flag_changed_ownership");
		}

		var_00 = var_01;
		wait(0.05);
	}
}

//Function Number: 6
setup_bot_dom()
{
	maps\mp\bots\_bots_util::bot_waittill_bots_enabled(1);
	var_00 = bot_get_all_possible_flags();
	if(var_00.size > 3)
	{
		while(!isdefined(level.teleport_dom_finished_initializing))
		{
			wait(0.05);
		}

		var_01 = [];
		foreach(var_03 in var_00)
		{
			if(!isdefined(var_01[var_03.teleport_zone]))
			{
				var_01[var_03.teleport_zone] = [];
			}

			var_01[var_03.teleport_zone] = common_scripts\utility::array_add(var_01[var_03.teleport_zone],var_03);
		}

		foreach(var_07, var_06 in var_01)
		{
			level.entrance_points_finished_caching = 0;
			bot_cache_flag_distances(var_06);
			maps\mp\bots\_bots_gametype_common::bot_cache_entrances_to_gametype_array(var_06,var_07 + "_flag",level.bot_ignore_precalc_paths);
		}
	}
	else
	{
		maps\mp\bots\_bots_gametype_common::bot_cache_entrances_to_gametype_array(var_00,"flag",level.bot_ignore_precalc_paths);
		bot_cache_flag_distances(var_00);
		thread bot_wait_for_event_flag_swap(var_00);
	}

	foreach(var_03 in var_00)
	{
		var_03 thread monitor_zone_control();
		var_03 thread monitor_flag_ownership();
		if(var_03.script_label != "_a" && var_03.script_label != "_b" && var_03.script_label != "_c")
		{
		}

		var_03.nodes = getnodesintrigger(var_03);
		maps\mp\bots\_bots_gametype_common::bot_add_missing_nodes(var_03,var_03);
		var_03.last_time_secured["allies"] = 0;
		var_03.last_time_secured["axis"] = 0;
	}

	level.bot_dom_override_flag_targets = [];
	level.bot_dom_override_flag_targets["axis"] = [];
	level.bot_dom_override_flag_targets["allies"] = [];
	level.bot_gametype_precaching_done = 1;
}

//Function Number: 7
bot_wait_for_event_flag_swap(param_00)
{
	level endon("game_ended");
	level waittill("dom_flags_moved");
	maps\mp\bots\_bots_gametype_common::bot_cache_entrances_to_gametype_array(param_00,"flag",level.bot_ignore_precalc_paths,1);
	bot_cache_flag_distances(param_00);
	foreach(var_02 in param_00)
	{
		var_02.nodes = getnodesintrigger(var_02);
		maps\mp\bots\_bots_gametype_common::bot_add_missing_nodes(var_02,var_02);
	}

	foreach(var_05 in level.participants)
	{
		if(maps\mp\_utility::isaiteamparticipant(var_05))
		{
			var_05.force_new_goal = 1;
		}
	}
}

//Function Number: 8
bot_get_all_possible_flags()
{
	if(isdefined(level.all_dom_flags))
	{
		return level.all_dom_flags;
	}

	return level.flags;
}

//Function Number: 9
bot_cache_flag_distances(param_00)
{
	if(!isdefined(level.flag_distances))
	{
		level.flag_distances = [];
	}

	for(var_01 = 0;var_01 < param_00.size - 1;var_01++)
	{
		for(var_02 = var_01 + 1;var_02 < param_00.size;var_02++)
		{
			var_03 = distance(param_00[var_01].origin,param_00[var_02].origin);
			var_04 = get_flag_label(param_00[var_01]);
			var_05 = get_flag_label(param_00[var_02]);
			level.flag_distances[var_04][var_05] = var_03;
			level.flag_distances[var_05][var_04] = var_03;
		}
	}
}

//Function Number: 10
should_start_cautious_approach_dom(param_00)
{
	if(param_00)
	{
		if(self.current_flag maps\mp\gametypes\dom::getflagteam() == "neutral" && flag_has_never_been_captured(self.current_flag))
		{
			var_01 = get_closest_flag(self.lastspawnpoint.origin);
			if(var_01 == self.current_flag)
			{
				return 0;
			}
			else
			{
				var_02 = get_other_flag(var_01,self.current_flag);
				var_03 = distancesquared(var_01.origin,self.current_flag.origin);
				var_04 = distancesquared(var_02.origin,self.current_flag.origin);
				if(var_03 < var_04)
				{
					return 0;
				}
			}
		}
	}

	return maps\mp\bots\_bots_strategy::should_start_cautious_approach_default(param_00);
}

//Function Number: 11
bot_dom_debug_should_capture_all()
{
	return 0;
}

//Function Number: 12
bot_dom_debug_should_protect_all()
{
	return 0;
}

//Function Number: 13
bot_dom_think()
{
	self notify("bot_dom_think");
	self endon("bot_dom_think");
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	while(!isdefined(level.bot_gametype_precaching_done))
	{
		wait(0.05);
	}

	self.force_new_goal = 0;
	self.new_goal_time = 0;
	self.next_strat_level_check = 0;
	self botsetflag("separation",0);
	self botsetflag("grenade_objectives",1);
	self botsetflag("use_obj_path_style",1);
	for(;;)
	{
		maps\mp\bots\_bots_util::bot_update_camp_assassin();
		var_00 = gettime();
		if(var_00 > self.next_strat_level_check)
		{
			self.next_strat_level_check = gettime() + 10000;
			self.strategy_level = self botgetdifficultysetting("strategyLevel");
		}

		if(var_00 > self.new_goal_time || self.force_new_goal)
		{
			if(should_delay_flag_decision())
			{
				self.new_goal_time = var_00 + 5000;
			}
			else
			{
				self.force_new_goal = 0;
				bot_choose_flag();
				self.new_goal_time = var_00 + randomintrange(30000,45000);
			}
		}

		common_scripts\utility::waittill_notify_or_timeout("needs_new_flag_goal",1);
	}
}

//Function Number: 14
should_delay_flag_decision()
{
	if(self.force_new_goal)
	{
		return 0;
	}

	if(!maps\mp\bots\_bots_util::bot_is_capturing())
	{
		return 0;
	}

	if(self.current_flag maps\mp\gametypes\dom::getflagteam() == self.team)
	{
		return 0;
	}

	var_00 = get_flag_capture_radius();
	if(distancesquared(self.origin,self.current_flag.origin) < var_00 * 2 * var_00 * 2)
	{
		var_01 = get_ally_flags(self.team);
		if(var_01.size == 2 && !common_scripts\utility::array_contains(var_01,self.current_flag) && !bot_allowed_to_3_cap())
		{
			return 0;
		}

		return 1;
	}

	return 0;
}

//Function Number: 15
get_override_flag_targets()
{
	return level.bot_dom_override_flag_targets[self.team];
}

//Function Number: 16
has_override_flag_targets()
{
	var_00 = get_override_flag_targets();
	return var_00.size > 0;
}

//Function Number: 17
flag_has_been_captured_before(param_00)
{
	return !flag_has_never_been_captured(param_00);
}

//Function Number: 18
flag_has_never_been_captured(param_00)
{
	return param_00.useobj.firstcapture;
}

//Function Number: 19
bot_choose_flag()
{
	var_00 = undefined;
	var_01 = [];
	var_02 = [];
	var_03 = 1;
	var_04 = get_override_flag_targets();
	if(var_04.size > 0)
	{
		var_05 = var_04;
	}
	else
	{
		var_05 = level.flags;
	}

	for(var_06 = 0;var_06 < var_05.size;var_06++)
	{
		var_07 = var_05[var_06] maps\mp\gametypes\dom::getflagteam();
		if(var_03)
		{
			if(flag_has_been_captured_before(var_05[var_06]))
			{
				var_03 = 0;
			}
			else
			{
			}
		}

		if(var_07 != self.team)
		{
			var_01[var_01.size] = var_05[var_06];
			continue;
		}

		var_02[var_02.size] = var_05[var_06];
	}

	var_08 = undefined;
	if(var_01.size == 3)
	{
		var_08 = 1;
	}
	else if(var_01.size == 2)
	{
		if(var_02.size == 1)
		{
			if(!bot_should_defend_flag(var_02[0],1))
			{
				var_08 = 1;
			}
			else
			{
				var_08 = !bot_should_defend(0.34);
			}

			if(maps\mp\bots\_bots_util::bot_get_max_players_on_team(self.team) == 1)
			{
				var_08 = 1;
			}
		}
		else if(var_02.size == 0)
		{
			var_08 = 1;
		}
	}
	else if(var_01.size == 1)
	{
		if(var_02.size == 2)
		{
			if(bot_allowed_to_3_cap())
			{
				if(!bot_should_defend_flag(var_02[0],2) && !bot_should_defend_flag(var_02[1],2))
				{
					var_08 = 1;
				}
				else if(self.strategy_level == 0)
				{
					var_08 = !bot_should_defend(0.34);
				}
				else
				{
					var_08 = !bot_should_defend(0.5);
				}
			}
			else
			{
				var_08 = 0;
			}
		}
		else if(var_02.size == 1)
		{
			if(!bot_should_defend_flag(var_02[0],1))
			{
				var_08 = 1;
			}
			else
			{
				var_08 = !bot_should_defend(0.34);
			}
		}
		else if(var_02.size == 0)
		{
			var_08 = 1;
		}
	}
	else if(var_01.size == 0)
	{
		var_08 = 0;
	}

	if(var_08)
	{
		if(var_01.size > 1)
		{
			var_09 = common_scripts\utility::get_array_of_closest(self.origin,var_01);
		}
		else
		{
			var_09 = var_02;
		}

		if(var_03 && !has_override_flag_targets())
		{
			var_0A = get_num_allies_capturing_flag(var_09[0],1);
			if(var_0A < min_num_bots_assaulting_first_flag())
			{
				var_0B = 0;
			}
			else
			{
				var_0C = 20;
				var_0D = 65;
				var_0E = 15;
				if(self.strategy_level == 0)
				{
					var_0C = 50;
					var_0D = 25;
					var_0E = 25;
				}
				else if(self.strategy_level == 1)
				{
					var_0C = 40;
					var_0D = 40;
					var_0E = 20;
				}

				var_0F = randomint(100);
				if(var_0F < var_0C)
				{
					var_0B = 0;
				}
				else if(var_0F < var_0C + var_0D)
				{
					var_0B = 1;
				}
				else
				{
					var_0B = 2;
				}
			}

			var_10 = undefined;
			if(var_0B == 0)
			{
				var_10 = "critical";
			}

			capture_flag(var_09[var_0B],var_10);
			return;
		}

		if(var_10.size == 1)
		{
			var_03 = var_10[0];
		}
		else if(distancesquared(var_10[0].origin,self.origin) < 102400)
		{
			var_03 = var_10[0];
		}
		else
		{
			var_11 = [];
			var_12 = [];
			for(var_09 = 0;var_09 < var_10.size;var_09++)
			{
				var_13 = distance(var_10[var_09].origin,self.origin);
				var_12[var_09] = var_13;
				var_11[var_09] = var_13;
			}

			if(var_05.size == 1)
			{
				var_14 = 1.5;
				for(var_09 = 0;var_09 < var_11.size;var_09++)
				{
					var_11[var_09] = var_11[var_09] + level.flag_distances[get_flag_label(var_10[var_09])][get_flag_label(var_05[0])] * var_14;
				}
			}

			if(self.strategy_level == 0)
			{
				var_0F = randomint(100);
				if(var_0F < 50)
				{
					var_03 = var_10[0];
				}
				else if(var_0F < 50 + 50 / var_10.size - 1)
				{
					var_03 = var_10[1];
				}
				else
				{
					var_03 = var_10[2];
				}
			}
			else if(var_11.size == 2)
			{
				var_15[0] = 50;
				var_15[1] = 50;
				for(var_09 = 0;var_09 < var_10.size;var_09++)
				{
					if(var_11[var_09] < var_11[1 - var_09])
					{
						var_15[var_09] = var_15[var_09] + 20;
						var_15[1 - var_09] = var_15[1 - var_09] - 20;
					}

					if(var_12[var_09] < 640)
					{
						var_15[var_09] = var_15[var_09] + 15;
						var_15[1 - var_09] = var_15[1 - var_09] - 15;
					}

					if(var_10[var_09] maps\mp\gametypes\dom::getflagteam() == "neutral")
					{
						var_15[var_09] = var_15[var_09] + 15;
						var_15[1 - var_09] = var_15[1 - var_09] - 15;
					}
				}

				var_0F = randomint(100);
				if(var_0F < var_15[0])
				{
					var_03 = var_10[0];
				}
				else
				{
					var_03 = var_10[1];
				}
			}
			else if(var_11.size == 3)
			{
				var_15[0] = 34;
				var_15[1] = 33;
				var_15[2] = 33;
				for(var_09 = 0;var_09 < var_10.size;var_09++)
				{
					var_16 = var_09 + 1 % 3;
					var_17 = var_09 + 2 % 3;
					if(var_11[var_09] < var_11[var_16] && var_11[var_09] < var_11[var_17])
					{
						var_15[var_09] = var_15[var_09] + 36;
						var_15[var_16] = var_15[var_16] - 18;
						var_15[var_17] = var_15[var_17] - 18;
					}

					if(var_12[var_09] < 640)
					{
						var_15[var_09] = var_15[var_09] + 15;
						var_15[var_16] = var_15[var_16] - 7;
						var_15[var_17] = var_15[var_17] - 8;
					}

					if(var_10[var_09] maps\mp\gametypes\dom::getflagteam() == "neutral")
					{
						var_15[var_09] = var_15[var_09] + 15;
						var_15[var_16] = var_15[var_16] - 7;
						var_15[var_17] = var_15[var_17] - 8;
					}
				}

				var_0F = randomint(100);
				if(var_0F < var_15[0])
				{
					var_03 = var_10[0];
				}
				else if(var_0F < var_15[0] + var_15[1])
				{
					var_03 = var_10[1];
				}
				else
				{
					var_03 = var_10[2];
				}
			}
		}
	}
	else
	{
		if(var_05.size > 1)
		{
			var_18 = common_scripts\utility::get_array_of_closest(self.origin,var_05);
		}
		else
		{
			var_18 = var_06;
		}

		foreach(var_1A in var_18)
		{
			if(bot_should_defend_flag(var_1A,var_05.size))
			{
				var_03 = var_1A;
				break;
			}
		}

		if(!isdefined(var_03))
		{
			if(self.strategy_level == 0)
			{
				var_03 = var_05[0];
			}
			else if(var_18.size == 2)
			{
				var_1C = get_other_flag(var_18[0],var_18[1]);
				var_1D = common_scripts\utility::get_array_of_closest(var_1C.origin,var_18);
				var_0F = randomint(100);
				if(var_0F < 70)
				{
					var_03 = var_1D[0];
				}
				else
				{
					var_03 = var_1D[1];
				}
			}
			else
			{
				var_03 = var_18[0];
			}
		}
	}

	if(var_0B)
	{
		capture_flag(var_03);
		return;
	}

	defend_flag(var_03);
}

//Function Number: 20
min_num_bots_assaulting_first_flag()
{
	var_00 = maps\mp\bots\_bots_util::bot_get_max_players_on_team(self.team);
	return ceil(var_00 / 3);
}

//Function Number: 21
bot_allowed_to_3_cap()
{
	if(self.strategy_level == 0)
	{
		return 1;
	}

	var_00 = get_override_flag_targets();
	if(var_00.size == 3)
	{
		return 1;
	}

	var_01 = maps\mp\gametypes\_gamescore::_getteamscore(common_scripts\utility::get_enemy_team(self.team));
	var_02 = maps\mp\gametypes\_gamescore::_getteamscore(self.team);
	var_03 = 200 - var_01;
	var_04 = 200 - var_02;
	var_05 = var_04 * 0.5 > var_03;
	return var_05;
}

//Function Number: 22
bot_should_defend(param_00)
{
	if(randomfloat(1) < param_00)
	{
		return 1;
	}

	var_01 = level.bot_personality_type[self.personality];
	if(var_01 == "stationary")
	{
		return 1;
	}
	else if(var_01 == "active")
	{
		return 0;
	}
}

//Function Number: 23
capture_flag(param_00,param_01,param_02)
{
	self.current_flag = param_00;
	if(bot_dom_debug_should_protect_all())
	{
		var_03["override_goal_type"] = param_01;
		var_03["entrance_points_index"] = get_flag_label(param_00);
		maps\mp\bots\_bots_strategy::bot_protect_point(param_00.origin,get_flag_protect_radius(),var_03);
	}
	else
	{
		param_00["override_goal_type"] = param_02;
		var_03["entrance_points_index"] = get_flag_label(param_00);
		maps\mp\bots\_bots_strategy::bot_capture_zone(param_00.origin,param_00.nodes,param_00,var_03);
	}

	if(!isdefined(param_02) || !param_02)
	{
		thread monitor_flag_status(param_00);
	}
}

//Function Number: 24
defend_flag(param_00)
{
	self.current_flag = param_00;
	if(bot_dom_debug_should_capture_all())
	{
		var_01["entrance_points_index"] = get_flag_label(param_00);
		maps\mp\bots\_bots_strategy::bot_capture_zone(param_00.origin,param_00.nodes,param_00,var_01);
	}
	else
	{
		param_00["entrance_points_index"] = get_flag_label(var_01);
		var_01["nearest_node_to_center"] = param_00.nearest_node;
		maps\mp\bots\_bots_strategy::bot_protect_point(param_00.origin,get_flag_protect_radius(),var_01);
	}

	thread monitor_flag_status(param_00);
}

//Function Number: 25
get_flag_capture_radius()
{
	if(!isdefined(level.capture_radius))
	{
		level.capture_radius = 158;
	}

	return level.capture_radius;
}

//Function Number: 26
get_flag_protect_radius()
{
	if(!isdefined(level.protect_radius))
	{
		var_00 = self botgetworldsize();
		var_01 = var_00[0] + var_00[1] / 2;
		level.protect_radius = min(1000,var_01 / 3.5);
	}

	return level.protect_radius;
}

//Function Number: 27
bot_dom_leader_dialog(param_00,param_01)
{
	if(issubstr(param_00,"losing") && param_00 != "losing_score" && param_00 != "losing_time")
	{
		var_02 = getsubstr(param_00,param_00.size - 2);
		var_03 = get_specific_flag_by_label(var_02);
		if(bot_allow_to_capture_flag(var_03))
		{
			self botmemoryevent("known_enemy",undefined,var_03.origin);
			if(!isdefined(self.last_losing_flag_react) || gettime() - self.last_losing_flag_react > 10000)
			{
				if(maps\mp\bots\_bots_util::bot_is_protecting())
				{
					var_04 = distancesquared(self.origin,var_03.origin) < 490000;
					var_05 = bot_is_protecting_flag(var_03);
					if(var_04 || var_05)
					{
						capture_flag(var_03);
						self.last_losing_flag_react = gettime();
					}
				}
			}
		}
	}
	else if(issubstr(param_00,"secured"))
	{
		var_02 = getsubstr(param_00,param_00.size - 2);
		var_06 = get_specific_flag_by_label(var_02);
		var_06.last_time_secured[self.team] = gettime();
	}

	maps\mp\bots\_bots_util::bot_leader_dialog(param_00,param_01);
}

//Function Number: 28
bot_allow_to_capture_flag(param_00)
{
	var_01 = get_override_flag_targets();
	if(var_01.size == 0)
	{
		return 1;
	}

	if(common_scripts\utility::array_contains(var_01,param_00))
	{
		return 1;
	}

	return 0;
}

//Function Number: 29
monitor_flag_status(param_00)
{
	self notify("monitor_flag_status");
	self endon("monitor_flag_status");
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	var_01 = get_num_ally_flags(self.team);
	var_02 = get_flag_capture_radius() * get_flag_capture_radius();
	var_03 = get_flag_capture_radius() * 3 * get_flag_capture_radius() * 3;
	var_04 = 1;
	while(var_04)
	{
		var_05 = 0;
		var_06 = param_00 maps\mp\gametypes\dom::getflagteam();
		var_07 = get_num_ally_flags(self.team);
		var_08 = get_enemy_flags(self.team);
		if(maps\mp\bots\_bots_util::bot_is_capturing())
		{
			if(var_06 == self.team && param_00.useobj.claimteam == "none")
			{
				if(!bot_dom_debug_should_capture_all())
				{
					var_05 = 1;
				}
			}

			if(var_07 == 2 && var_06 != self.team && !bot_allowed_to_3_cap())
			{
				if(distancesquared(self.origin,param_00.origin) > var_02)
				{
					var_05 = 1;
				}
			}

			foreach(var_0A in var_08)
			{
				if(var_0A != param_00 && bot_allow_to_capture_flag(var_0A))
				{
					if(distancesquared(self.origin,var_0A.origin) < var_03)
					{
						var_05 = 1;
					}
				}
			}

			if(self istouching(param_00) && param_00.useobj.userate <= 0)
			{
				if(self bothasscriptgoal())
				{
					var_0C = self botgetscriptgoal();
					var_0D = self botgetscriptgoalradius();
					if(distancesquared(self.origin,var_0C) < squared(var_0D))
					{
						var_0E = self getnearestnode();
						if(isdefined(var_0E))
						{
							var_0F = undefined;
							foreach(var_11 in param_00.nodes)
							{
								if(!nodesvisible(var_11,var_0E,1))
								{
									var_0F = var_11.origin;
									break;
								}
							}

							if(isdefined(var_0F))
							{
								self.defense_investigate_specific_point = var_0F;
								self notify("defend_force_node_recalculation");
							}
						}
					}
				}
			}
		}

		if(maps\mp\bots\_bots_util::bot_is_protecting())
		{
			if(var_06 != self.team)
			{
				if(!bot_dom_debug_should_protect_all())
				{
					var_05 = 1;
				}
			}
			else if(var_07 == 1 && var_01 > 1)
			{
				var_05 = 1;
			}
		}

		var_01 = var_07;
		if(var_05)
		{
			self.force_new_goal = 1;
			var_04 = 0;
			self notify("needs_new_flag_goal");
			continue;
		}

		var_13 = level common_scripts\utility::waittill_notify_or_timeout_return("flag_changed_ownership",1 + randomfloatrange(0,2));
		if(!isdefined(var_13) && var_13 == "timeout")
		{
			var_14 = max(3 - self.strategy_level * 1 + randomfloatrange(-0.5,0.5),0);
			wait(var_14);
		}
	}
}

//Function Number: 30
bot_dom_get_node_chance(param_00)
{
	if(param_00 == self.node_closest_to_defend_center)
	{
		return 1;
	}

	if(!isdefined(self.current_flag))
	{
		return 1;
	}

	var_01 = 0;
	var_02 = get_flag_label(self.current_flag);
	var_03 = get_ally_flags(self.team);
	foreach(var_05 in var_03)
	{
		if(var_05 != self.current_flag)
		{
			var_01 = param_00 maps\mp\bots\_bots_util::node_is_on_path_from_labels(var_02,get_flag_label(var_05));
			if(var_01)
			{
				var_06 = get_other_flag(self.current_flag,var_05);
				var_07 = var_06 maps\mp\gametypes\dom::getflagteam();
				if(var_07 != self.team)
				{
					if(param_00 maps\mp\bots\_bots_util::node_is_on_path_from_labels(var_02,get_flag_label(var_06)))
					{
						var_01 = 0;
					}
				}
			}
		}
	}

	if(var_01)
	{
		return 0.2;
	}

	return 1;
}

//Function Number: 31
get_flag_label(param_00)
{
	var_01 = "";
	if(isdefined(param_00.teleport_zone))
	{
		var_01 = var_01 + param_00.teleport_zone + "_";
	}

	var_01 = var_01 + "flag" + param_00.script_label;
	return var_01;
}

//Function Number: 32
get_other_flag(param_00,param_01)
{
	for(var_02 = 0;var_02 < level.flags.size;var_02++)
	{
		if(level.flags[var_02] != param_00 && level.flags[var_02] != param_01)
		{
			return level.flags[var_02];
		}
	}
}

//Function Number: 33
get_specific_flag_by_letter(param_00)
{
	var_01 = "_" + tolower(param_00);
	get_specific_flag_by_label(var_01);
}

//Function Number: 34
get_specific_flag_by_label(param_00)
{
	for(var_01 = 0;var_01 < level.flags.size;var_01++)
	{
		if(level.flags[var_01].script_label == param_00)
		{
			return level.flags[var_01];
		}
	}
}

//Function Number: 35
get_closest_flag(param_00)
{
	var_01 = undefined;
	var_02 = undefined;
	foreach(var_04 in level.flags)
	{
		var_05 = distancesquared(var_04.origin,param_00);
		if(!isdefined(var_02) || var_05 < var_02)
		{
			var_01 = var_04;
			var_02 = var_05;
		}
	}

	return var_01;
}

//Function Number: 36
get_num_allies_capturing_flag(param_00,param_01)
{
	var_02 = 0;
	var_03 = get_flag_capture_radius();
	foreach(var_05 in level.participants)
	{
		if(!isdefined(var_05.team))
		{
			continue;
		}

		if(var_05.team == self.team && var_05 != self && maps\mp\_utility::isteamparticipant(var_05))
		{
			if(isai(var_05))
			{
				if(var_05 bot_is_capturing_flag(param_00))
				{
					var_02++;
				}

				continue;
			}

			if(!isdefined(param_01) || !param_01)
			{
				if(var_05 istouching(param_00))
				{
					var_02++;
				}
			}
		}
	}

	return var_02;
}

//Function Number: 37
bot_is_capturing_flag(param_00)
{
	if(!maps\mp\bots\_bots_util::bot_is_capturing())
	{
		return 0;
	}

	return bot_target_is_flag(param_00);
}

//Function Number: 38
bot_is_protecting_flag(param_00)
{
	if(!maps\mp\bots\_bots_util::bot_is_protecting())
	{
		return 0;
	}

	return bot_target_is_flag(param_00);
}

//Function Number: 39
bot_target_is_flag(param_00)
{
	return self.current_flag == param_00;
}

//Function Number: 40
get_num_ally_flags(param_00)
{
	var_01 = 0;
	for(var_02 = 0;var_02 < level.flags.size;var_02++)
	{
		var_03 = level.flags[var_02] maps\mp\gametypes\dom::getflagteam();
		if(var_03 == param_00)
		{
			var_01++;
		}
	}

	return var_01;
}

//Function Number: 41
get_enemy_flags(param_00)
{
	var_01 = [];
	for(var_02 = 0;var_02 < level.flags.size;var_02++)
	{
		var_03 = level.flags[var_02] maps\mp\gametypes\dom::getflagteam();
		if(var_03 == common_scripts\utility::get_enemy_team(param_00))
		{
			var_01 = common_scripts\utility::array_add(var_01,level.flags[var_02]);
		}
	}

	return var_01;
}

//Function Number: 42
get_ally_flags(param_00)
{
	var_01 = [];
	for(var_02 = 0;var_02 < level.flags.size;var_02++)
	{
		var_03 = level.flags[var_02] maps\mp\gametypes\dom::getflagteam();
		if(var_03 == param_00)
		{
			var_01 = common_scripts\utility::array_add(var_01,level.flags[var_02]);
		}
	}

	return var_01;
}

//Function Number: 43
bot_should_defend_flag(param_00,param_01)
{
	var_02 = get_max_num_defenders_wanted_per_flag(param_01);
	var_03 = get_players_defending_flag(param_00);
	return var_03.size < var_02;
}

//Function Number: 44
get_max_num_defenders_wanted_per_flag(param_00)
{
	var_01 = maps\mp\bots\_bots_util::bot_get_max_players_on_team(self.team);
	if(param_00 == 1)
	{
		return ceil(var_01 / 6);
	}

	return ceil(var_01 / 3);
}

//Function Number: 45
get_players_defending_flag(param_00)
{
	var_01 = get_flag_protect_radius();
	var_02 = [];
	foreach(var_04 in level.participants)
	{
		if(!isdefined(var_04.team))
		{
			continue;
		}

		if(var_04.team == self.team && var_04 != self && maps\mp\_utility::isteamparticipant(var_04))
		{
			if(isai(var_04))
			{
				if(var_04 bot_is_protecting_flag(param_00))
				{
					var_02 = common_scripts\utility::array_add(var_02,var_04);
				}

				continue;
			}

			var_05 = gettime() - param_00.last_time_secured[self.team];
			if(var_05 < 10000)
			{
				continue;
			}

			if(distancesquared(param_00.origin,var_04.origin) < var_01 * var_01)
			{
				var_02 = common_scripts\utility::array_add(var_02,var_04);
			}
		}
	}

	return var_02;
}