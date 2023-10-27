/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\bots\_bots_gametype_dom.gsc
 * Game: Call of Duty: Ghosts
 * Platform: Console
 * Function Count: 45
 * Decompile Time: 829 ms
 * Timestamp: 10/27/2023 1:28:27 AM
*******************************************************************/

//Function Number: 1
func_4FDD()
{
	func_710C();
	func_945B();
	level thread maps/mp/bots/_bots_util::func_163B(::maps/mp/bots/_bots_util::bot_valid_camp_assassin);
}

//Function Number: 2
func_710C()
{
	level.bot_funcs["crate_can_use"] = ::crate_can_use;
	level.bot_funcs["gametype_think"] = ::func_8FE6;
	level.bot_funcs["should_start_cautious_approach"] = ::func_9484;
	level.bot_funcs["leader_dialog"] = ::func_8FE4;
	level.bot_funcs["get_watch_node_chance"] = ::func_8FE3;
	level.bot_funcs["commander_gametype_tactics"] = ::bot_dom_apply_commander_tactics;
}

//Function Number: 3
func_8FF7(param_00)
{
	var_01 = 90000;
	if(maps/mp/bots/_bots_util::bot_is_defending() && function_0210(param_00,self.bot_defending_center) < var_01)
	{
		return 1;
	}

	if(self bothasscriptgoal())
	{
		var_02 = self botgetscriptgoal();
		if(function_0210(param_00,var_02) < var_01)
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 4
func_90A2(param_00)
{
	if(isbot(self))
	{
		if(!isdefined(level.smartglass_commander) || self.owner != level.smartglass_commander)
		{
			return crate_can_use();
		}

		if(!isdefined(param_00.boxtype) && maps/mp/bots/_bots_util::bot_crate_is_command_goal(param_00))
		{
			return func_8FF7(param_00.origin);
		}

		return 0;
	}

	return crate_can_use(param_00);
}

//Function Number: 5
crate_can_use(param_00)
{
	if(isbot(self) && !isdefined(param_00.boxtype))
	{
		return 0;
	}

	if(!maps\mp\_utility::func_4984(self))
	{
		return 1;
	}

	return maps/mp/bots/_bots_util::func_1604();
}

//Function Number: 6
bot_dom_apply_commander_tactics(param_00)
{
	var_01 = 0;
	switch(param_00)
	{
		case "tactic_none":
			level.bot_dom_override_flag_targets[self.team] = [];
			var_01 = 1;
			break;

		case "tactic_dom_holdA":
			level.bot_dom_override_flag_targets[self.team] = [];
			level.bot_dom_override_flag_targets[self.team][0] = func_91D3("A");
			var_01 = 1;
			break;

		case "tactic_dom_holdB":
			level.bot_dom_override_flag_targets[self.team] = [];
			level.bot_dom_override_flag_targets[self.team][0] = func_91D3("B");
			var_01 = 1;
			break;

		case "tactic_dom_holdC":
			level.bot_dom_override_flag_targets[self.team] = [];
			level.bot_dom_override_flag_targets[self.team][0] = func_91D3("C");
			var_01 = 1;
			break;

		case "tactic_dom_holdAB":
			level.bot_dom_override_flag_targets[self.team] = [];
			level.bot_dom_override_flag_targets[self.team][0] = func_91D3("A");
			level.bot_dom_override_flag_targets[self.team][1] = func_91D3("B");
			var_01 = 1;
			break;

		case "tactic_dom_holdBC":
			level.bot_dom_override_flag_targets[self.team] = [];
			level.bot_dom_override_flag_targets[self.team][0] = func_91D3("B");
			level.bot_dom_override_flag_targets[self.team][1] = func_91D3("C");
			var_01 = 1;
			break;

		case "tactic_dom_holdAC":
			level.bot_dom_override_flag_targets[self.team] = [];
			level.bot_dom_override_flag_targets[self.team][0] = func_91D3("A");
			level.bot_dom_override_flag_targets[self.team][1] = func_91D3("C");
			var_01 = 1;
			break;

		case "tactic_dom_holdABC":
			level.bot_dom_override_flag_targets[self.team] = [];
			level.bot_dom_override_flag_targets[self.team][0] = func_91D3("A");
			level.bot_dom_override_flag_targets[self.team][1] = func_91D3("B");
			level.bot_dom_override_flag_targets[self.team][2] = func_91D3("C");
			var_01 = 1;
			break;
	}

	if(var_01)
	{
		foreach(var_03 in level.participants)
		{
			if(!isdefined(var_03.team))
			{
				continue;
			}

			if(maps\mp\_utility::func_486C(var_03) && var_03.team == self.team)
			{
				var_03.force_new_goal = 1;
			}
		}
	}
}

//Function Number: 7
func_9344()
{
	self notify("monitor_zone_control");
	self endon("monitor_zone_control");
	self endon("death");
	level endon("game_ended");
	for(;;)
	{
		wait(1);
		var_00 = maps/mp/gametypes/dom::func_3AAB();
		if(var_00 != "neutral")
		{
			var_01 = getzonecount(self.origin);
			if(isdefined(var_01))
			{
				botzonegetcount(var_01,var_00);
			}
		}
	}
}

//Function Number: 8
monitor_flag_ownership()
{
	self notify("monitor_flag_ownership");
	self endon("monitor_flag_ownership");
	self endon("death");
	level endon("game_ended");
	var_00 = maps/mp/gametypes/dom::func_3AAB();
	for(;;)
	{
		var_01 = maps/mp/gametypes/dom::func_3AAB();
		if(var_01 != var_00)
		{
			level notify("flag_changed_ownership");
		}

		var_00 = var_01;
		wait(0.05);
	}
}

//Function Number: 9
func_945B()
{
	var_00 = func_8FED();
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
			maps/mp/bots/_bots_util::bot_cache_entrances_to_flags_or_radios(var_06,var_07 + "_flag");
		}
	}
	else
	{
		maps/mp/bots/_bots_util::bot_cache_entrances_to_flags_or_radios(var_00,"flag");
		bot_cache_flag_distances(var_00);
	}

	foreach(var_03 in var_00)
	{
		var_03 thread func_9344();
		var_03 thread monitor_flag_ownership();
		if(var_03.script_label != "_a" && var_03.script_label != "_b" && var_03.script_label != "_c")
		{
		}

		var_03.nodes = botgetclosestnavigablepoint(var_03);
		func_8F36(var_03);
	}

	level.bot_dom_override_flag_targets = [];
	level.bot_dom_override_flag_targets["axis"] = [];
	level.bot_dom_override_flag_targets["allies"] = [];
	level.bot_gametype_precaching_done = 1;
}

//Function Number: 10
func_8FED()
{
	if(isdefined(level.all_dom_flags))
	{
		return level.all_dom_flags;
	}

	return level.flags;
}

//Function Number: 11
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
			var_04 = func_91A0(param_00[var_01]);
			var_05 = func_91A0(param_00[var_02]);
			level.flag_distances[var_04][var_05] = var_03;
			level.flag_distances[var_05][var_04] = var_03;
		}
	}
}

//Function Number: 12
func_8F36(param_00)
{
	if(param_00.classname == "trigger_radius")
	{
		var_01 = getnodesinradius(param_00.origin,param_00.radius,0,100);
		var_02 = common_scripts\utility::array_remove_array(var_01,param_00.nodes);
		if(var_02.size > 0)
		{
			param_00.nodes = common_scripts\utility::array_combine(param_00.nodes,var_02);
		}
	}

	if(param_00.classname == "trigger_multiple")
	{
		var_03[0] = param_00 getpointinbounds(1,1,1);
		var_03[1] = param_00 getpointinbounds(1,1,-1);
		var_03[2] = param_00 getpointinbounds(1,-1,1);
		var_03[3] = param_00 getpointinbounds(1,-1,-1);
		var_03[4] = param_00 getpointinbounds(-1,1,1);
		var_03[5] = param_00 getpointinbounds(-1,1,-1);
		var_03[6] = param_00 getpointinbounds(-1,-1,1);
		var_03[7] = param_00 getpointinbounds(-1,-1,-1);
		var_04 = 0;
		foreach(var_06 in var_03)
		{
			var_07 = distance(var_06,param_00.origin);
			if(var_07 > var_04)
			{
				var_04 = var_07;
			}
		}

		var_01 = getnodesinradius(param_00.origin,var_04,0,100);
		foreach(var_0A in var_01)
		{
			if(!adddebugcommand(var_0A.origin,param_00))
			{
				if(adddebugcommand(var_0A.origin + (0,0,40),param_00) || adddebugcommand(var_0A.origin + (0,0,80),param_00) || adddebugcommand(var_0A.origin + (0,0,120),param_00))
				{
					param_00.nodes = common_scripts\utility::array_add(param_00.nodes,var_0A);
				}
			}
		}
	}
}

//Function Number: 13
func_9484(param_00)
{
	if(param_00)
	{
		if(self.current_flag maps/mp/gametypes/dom::func_3AAB() == "neutral" && func_9163(self.current_flag))
		{
			var_01 = func_918E(self.lastspawnpoint.origin);
			if(var_01 == self.current_flag)
			{
				return 0;
			}
			else
			{
				var_02 = func_91B6(var_01,self.current_flag);
				var_03 = distancesquared(var_01.origin,self.current_flag.origin);
				var_04 = distancesquared(var_02.origin,self.current_flag.origin);
				if(var_03 < var_04)
				{
					return 0;
				}
			}
		}
	}

	return maps/mp/bots/_bots_strategy::func_7490(param_00);
}

//Function Number: 14
func_8FE1()
{
	return 0;
}

//Function Number: 15
func_8FE2()
{
	return 0;
}

//Function Number: 16
func_8FE6()
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
		maps/mp/bots/_bots_util::func_16B7();
		var_00 = gettime();
		if(var_00 > self.next_strat_level_check)
		{
			self.next_strat_level_check = gettime() + 10000;
			self.strategy_level = self botgetdifficultysetting("strategyLevel");
		}

		if(var_00 > self.new_goal_time || self.force_new_goal)
		{
			if(func_947F())
			{
				self.new_goal_time = var_00 + 5000;
			}
			else
			{
				self.force_new_goal = 0;
				func_8FDB();
				self.new_goal_time = var_00 + randomintrange(30000,-20536);
			}
		}

		common_scripts\utility::waittill_notify_or_timeout("needs_new_flag_goal",1);
	}
}

//Function Number: 17
func_947F()
{
	if(self.force_new_goal)
	{
		return 0;
	}

	if(!maps/mp/bots/_bots_util::bot_is_capturing())
	{
		return 0;
	}

	if(self.current_flag maps/mp/gametypes/dom::func_3AAB() == self.team)
	{
		return 0;
	}

	var_00 = func_919F();
	if(distancesquared(self.origin,self.current_flag.origin) < var_00 * 2 * var_00 * 2)
	{
		var_01 = func_9189(self.team);
		if(var_01.size == 2 && !common_scripts\utility::array_contains(var_01,self.current_flag) && !func_8FD2())
		{
			return 0;
		}

		return 1;
	}

	return 0;
}

//Function Number: 18
func_91B7()
{
	return level.bot_dom_override_flag_targets[self.team];
}

//Function Number: 19
func_9228()
{
	var_00 = func_91B7();
	return var_00.size > 0;
}

//Function Number: 20
func_9162(param_00)
{
	return !func_9163(param_00);
}

//Function Number: 21
func_9163(param_00)
{
	return param_00.useobj.firstcapture;
}

//Function Number: 22
func_8FDB()
{
	var_00 = undefined;
	var_01 = [];
	var_02 = [];
	var_03 = 1;
	var_04 = func_91B7();
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
		var_07 = var_05[var_06] maps/mp/gametypes/dom::func_3AAB();
		if(var_03)
		{
			if(func_9162(var_05[var_06]))
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
			if(!func_9010(var_02[0],1))
			{
				var_08 = 1;
			}
			else
			{
				var_08 = !func_900F(0.34);
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
			if(func_8FD2())
			{
				if(!func_9010(var_02[0],2) && !func_9010(var_02[1],2))
				{
					var_08 = 1;
				}
				else if(self.strategy_level == 0)
				{
					var_08 = !func_900F(0.34);
				}
				else
				{
					var_08 = !func_900F(0.5);
				}
			}
			else
			{
				var_08 = 0;
			}
		}
		else if(var_02.size == 1)
		{
			if(!func_9010(var_02[0],1))
			{
				var_08 = 1;
			}
			else
			{
				var_08 = !func_900F(0.34);
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
			var_09 = common_scripts\utility::func_37D5(self.origin,var_01);
		}
		else
		{
			var_09 = var_02;
		}

		if(var_03 && !func_9228())
		{
			var_0A = get_num_allies_capturing_flag(var_09[0],1);
			if(var_0A < 2)
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

			func_9053(var_09[var_0B],var_10);
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
					var_11[var_09] = var_11[var_09] + level.flag_distances[func_91A0(var_10[var_09])][func_91A0(var_05[0])] * var_14;
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

					if(var_10[var_09] maps/mp/gametypes/dom::func_3AAB() == "neutral")
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

					if(var_10[var_09] maps/mp/gametypes/dom::func_3AAB() == "neutral")
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
			var_18 = common_scripts\utility::func_37D5(self.origin,var_05);
		}
		else
		{
			var_18 = var_06;
		}

		foreach(var_1A in var_18)
		{
			if(func_9010(var_1A,var_05.size))
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
				var_1C = func_91B6(var_18[0],var_18[1]);
				var_1D = common_scripts\utility::func_37D5(var_1C.origin,var_18);
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
		func_9053(var_03);
	}

	func_90E1(var_03);
}

//Function Number: 23
func_8FD2()
{
	if(self.strategy_level == 0)
	{
		return 1;
	}

	var_00 = func_91B7();
	if(var_00.size == 3)
	{
		return 1;
	}

	var_01 = maps\mp\gametypes\_gamescore::func_6A3(common_scripts\utility::func_386F(self.team));
	var_02 = maps\mp\gametypes\_gamescore::func_6A3(self.team);
	var_03 = 200 - var_01;
	var_04 = 200 - var_02;
	var_05 = var_04 * 0.5 > var_03;
	return var_05;
}

//Function Number: 24
func_900F(param_00)
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

//Function Number: 25
func_9053(param_00,param_01,param_02)
{
	self.current_flag = param_00;
	if(func_8FE2())
	{
		var_03["override_goal_type"] = param_01;
		var_03["entrance_points_index"] = func_91A0(param_00);
		maps/mp/bots/_bots_strategy::bot_protect_point(param_00.origin,func_91A1(),var_03);
	}
	else
	{
		param_00["override_goal_type"] = param_02;
		var_03["entrance_points_index"] = func_91A0(param_00);
		maps/mp/bots/_bots_strategy::bot_capture_zone(param_00.origin,param_00.nodes,param_00,var_03);
	}

	if(!isdefined(param_02) || !param_02)
	{
		thread func_933F(param_00);
	}
}

//Function Number: 26
func_90E1(param_00)
{
	self.current_flag = param_00;
	if(func_8FE1())
	{
		var_01["entrance_points_index"] = func_91A0(param_00);
		maps/mp/bots/_bots_strategy::bot_capture_zone(param_00.origin,param_00.nodes,param_00,var_01);
	}
	else
	{
		param_00["entrance_points_index"] = func_91A0(var_01);
		var_01["nearest_node"] = param_00.nearest_node;
		maps/mp/bots/_bots_strategy::bot_protect_point(param_00.origin,func_91A1(),var_01);
	}

	thread func_933F(param_00);
}

//Function Number: 27
func_919F()
{
	if(!isdefined(level.capture_radius))
	{
		level.capture_radius = 158;
	}

	return level.capture_radius;
}

//Function Number: 28
func_91A1()
{
	if(!isdefined(level.protect_radius))
	{
		var_00 = self botgetworldsize();
		var_01 = var_00[0] + var_00[1] / 2;
		level.protect_radius = min(1000,var_01 / 3.5);
	}

	return level.protect_radius;
}

//Function Number: 29
func_8FE4(param_00,param_01)
{
	if(issubstr(param_00,"losing"))
	{
		var_02 = getsubstr(param_00,param_00.size - 2);
		var_03 = undefined;
		for(var_04 = 0;var_04 < level.flags.size;var_04++)
		{
			if(var_02 == level.flags[var_04].script_label)
			{
				var_03 = level.flags[var_04];
			}
		}

		if(isdefined(var_03) && func_8FD1(var_03))
		{
			self botmemoryevent("known_enemy",undefined,var_03.origin);
			if(!isdefined(self.last_losing_flag_react) || gettime() - self.last_losing_flag_react > 10000)
			{
				if(maps/mp/bots/_bots_util::func_1604())
				{
					if(distancesquared(self.origin,var_03.origin) < 490000)
					{
						func_9053(var_03);
						self.last_losing_flag_react = gettime();
					}
				}
			}
		}
	}

	maps/mp/bots/_bots_util::func_161D(param_00,param_01);
}

//Function Number: 30
func_8FD1(param_00)
{
	var_01 = func_91B7();
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

//Function Number: 31
func_933F(param_00)
{
	self notify("monitor_flag_status");
	self endon("monitor_flag_status");
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	var_01 = func_91B5(self.team);
	var_02 = func_919F() * func_919F();
	var_03 = func_919F() * 3 * func_919F() * 3;
	var_04 = 1;
	while(var_04)
	{
		var_05 = 0;
		var_06 = param_00 maps/mp/gametypes/dom::func_3AAB();
		var_07 = func_91B5(self.team);
		var_08 = func_919C(self.team);
		if(maps/mp/bots/_bots_util::bot_is_capturing())
		{
			if(var_06 == self.team && param_00.useobj.claimteam == "none")
			{
				if(!func_8FE1())
				{
					var_05 = 1;
				}
			}

			if(var_07 == 2 && var_06 != self.team && !func_8FD2())
			{
				if(distancesquared(self.origin,param_00.origin) > var_02)
				{
					var_05 = 1;
				}
			}

			foreach(var_0A in var_08)
			{
				if(var_0A != param_00 && func_8FD1(var_0A))
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
								if(!getnodesintrigger(var_11,var_0E))
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

		if(maps/mp/bots/_bots_util::func_1604())
		{
			if(var_06 != self.team)
			{
				if(!func_8FE2())
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

		var_13 = level common_scripts\utility::func_8B7E("flag_changed_ownership",1 + randomfloatrange(0,2));
		if(!isdefined(var_13) && var_13 == "timeout")
		{
			var_14 = max(3 - self.strategy_level * 1 + randomfloatrange(-0.5,0.5),0);
			wait(var_14);
		}
	}
}

//Function Number: 32
func_8FE3(param_00)
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
	var_02 = func_91A0(self.current_flag);
	var_03 = func_9189(self.team);
	foreach(var_05 in var_03)
	{
		if(var_05 != self.current_flag)
		{
			var_01 = param_00 maps/mp/bots/_bots_util::func_5645(var_02,func_91A0(var_05));
			if(var_01)
			{
				var_06 = func_91B6(self.current_flag,var_05);
				var_07 = var_06 maps/mp/gametypes/dom::func_3AAB();
				if(var_07 != self.team)
				{
					if(param_00 maps/mp/bots/_bots_util::func_5645(var_02,func_91A0(var_06)))
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

//Function Number: 33
func_91A0(param_00)
{
	var_01 = "";
	if(isdefined(param_00.teleport_zone))
	{
		var_01 = var_01 + param_00.teleport_zone + "_";
	}

	var_01 = var_01 + "flag" + param_00.script_label;
	return var_01;
}

//Function Number: 34
func_91B6(param_00,param_01)
{
	for(var_02 = 0;var_02 < level.flags.size;var_02++)
	{
		if(level.flags[var_02] != param_00 && level.flags[var_02] != param_01)
		{
			return level.flags[var_02];
		}
	}
}

//Function Number: 35
func_91D3(param_00)
{
	param_00 = "_" + tolower(param_00);
	for(var_01 = 0;var_01 < level.flags.size;var_01++)
	{
		if(level.flags[var_01].script_label == param_00)
		{
			return level.flags[var_01];
		}
	}
}

//Function Number: 36
func_918E(param_00)
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

//Function Number: 37
get_num_allies_capturing_flag(param_00,param_01)
{
	var_02 = 0;
	var_03 = func_919F();
	foreach(var_05 in level.participants)
	{
		if(!isdefined(var_05.team))
		{
			continue;
		}

		if(var_05.team == self.team && var_05 != self && maps\mp\_utility::func_4984(var_05))
		{
			if(isai(var_05))
			{
				if(var_05 func_8FF8(param_00))
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

//Function Number: 38
func_8FF8(param_00)
{
	if(!maps/mp/bots/_bots_util::bot_is_capturing())
	{
		return 0;
	}

	return func_9015(param_00);
}

//Function Number: 39
func_8FF9(param_00)
{
	if(!maps/mp/bots/_bots_util::func_1604())
	{
		return 0;
	}

	return func_9015(param_00);
}

//Function Number: 40
func_9015(param_00)
{
	return self.current_flag == param_00;
}

//Function Number: 41
func_91B5(param_00)
{
	var_01 = 0;
	for(var_02 = 0;var_02 < level.flags.size;var_02++)
	{
		var_03 = level.flags[var_02] maps/mp/gametypes/dom::func_3AAB();
		if(var_03 == param_00)
		{
			var_01++;
		}
	}

	return var_01;
}

//Function Number: 42
func_919C(param_00)
{
	var_01 = [];
	for(var_02 = 0;var_02 < level.flags.size;var_02++)
	{
		var_03 = level.flags[var_02] maps/mp/gametypes/dom::func_3AAB();
		if(var_03 == common_scripts\utility::func_386F(param_00))
		{
			var_01 = common_scripts\utility::array_add(var_01,level.flags[var_02]);
		}
	}

	return var_01;
}

//Function Number: 43
func_9189(param_00)
{
	var_01 = [];
	for(var_02 = 0;var_02 < level.flags.size;var_02++)
	{
		var_03 = level.flags[var_02] maps/mp/gametypes/dom::func_3AAB();
		if(var_03 == param_00)
		{
			var_01 = common_scripts\utility::array_add(var_01,level.flags[var_02]);
		}
	}

	return var_01;
}

//Function Number: 44
func_9010(param_00,param_01)
{
	if(param_01 == 1)
	{
		var_02 = 1;
	}
	else
	{
		var_02 = 2;
	}

	var_03 = func_918B(param_00);
	return var_03.size < var_02;
}

//Function Number: 45
func_918B(param_00)
{
	var_01 = func_91A1();
	var_02 = [];
	foreach(var_04 in level.participants)
	{
		if(!isdefined(var_04.team))
		{
			continue;
		}

		if(var_04.team == self.team && var_04 != self && maps\mp\_utility::func_4984(var_04))
		{
			if(isai(var_04))
			{
				if(var_04 func_8FF9(param_00))
				{
					var_02 = common_scripts\utility::array_add(var_02,var_04);
				}

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