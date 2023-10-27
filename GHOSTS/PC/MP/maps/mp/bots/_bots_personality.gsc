/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\bots\_bots_personality.gsc
 * Game: Call of Duty: Ghosts
 * Platform: PC
 * Function Count: 23
 * Decompile Time: 454 ms
 * Timestamp: 10/27/2023 1:17:38 AM
*******************************************************************/

//Function Number: 1
func_719E()
{
	level.bot_personality = [];
	level.bot_personality_list = [];
	level.bot_personality["active"][0] = "default";
	level.bot_personality["active"][1] = "run_and_gun";
	level.bot_personality["active"][2] = "cqb";
	level.bot_personality["stationary"][0] = "camper";
	level.bot_personality_type = [];
	foreach(var_05, var_01 in level.bot_personality)
	{
		foreach(var_03 in var_01)
		{
			level.bot_personality_type[var_03] = var_05;
			level.bot_personality_list[level.bot_personality_list.size] = var_03;
		}
	}

	level.bot_personality_types_desired = [];
	level.bot_personality_types_desired["active"] = 2;
	level.bot_personality_types_desired["stationary"] = 1;
	level.bot_pers_init = [];
	level.bot_pers_init["default"] = ::func_4585;
	level.bot_pers_init["camper"] = ::init_personality_camper;
	level.bot_pers_update["default"] = ::func_8699;
	level.bot_pers_update["camper"] = ::func_8698;
}

//Function Number: 2
func_157C()
{
	self.personality = self botgetpersonality();
	self.personality_init_function = level.bot_pers_init[self.personality];
	if(!isdefined(self.personality_init_function))
	{
		self.personality_init_function = level.bot_pers_init["default"];
	}

	self [[ self.personality_init_function ]]();
	self.personality_update_function = level.bot_pers_update[self.personality];
	if(!isdefined(self.personality_update_function))
	{
		self.personality_update_function = level.bot_pers_update["default"];
	}
}

//Function Number: 3
bot_balance_personality()
{
	if(isdefined(self.personalitymanuallyset) && self.personalitymanuallyset)
	{
	}

	if(maps\mp\_utility::bot_is_fireteam_mode())
	{
	}

	var_00 = [];
	var_01 = [];
	foreach(var_07, var_03 in level.bot_personality)
	{
		var_01[var_07] = 0;
		foreach(var_05 in var_03)
		{
			var_00[var_05] = 0;
		}
	}

	foreach(var_09 in level.players)
	{
		if(isbot(var_09) && isdefined(var_09.team) && var_09.team == self.team && var_09 != self && isdefined(var_09.has_balanced_personality))
		{
			var_05 = var_09 botgetpersonality();
			var_07 = level.bot_personality_type[var_05];
			var_00[var_05] = var_00[var_05] + 1;
			var_01[var_07] = var_01[var_07] + 1;
		}
	}

	var_0B = undefined;
	while(!isdefined(var_0B))
	{
		for(var_0C = level.bot_personality_types_desired;var_0C.size > 0;var_0C[var_0D] = undefined)
		{
			var_0D = maps/mp/bots/_bots_util::bot_get_string_index_for_integer(var_0C,randomint(var_0C.size));
			var_01[var_0D] = var_01[var_0D] - level.bot_personality_types_desired[var_0D];
			if(var_01[var_0D] < 0)
			{
				var_0B = var_0D;
				break;
			}
		}
	}

	var_0E = undefined;
	var_0F = undefined;
	var_10 = 9999;
	var_11 = undefined;
	var_12 = -9999;
	var_13 = common_scripts\utility::array_randomize(level.bot_personality[var_0B]);
	foreach(var_05 in var_13)
	{
		if(var_00[var_05] < var_10)
		{
			var_0F = var_05;
			var_10 = var_00[var_05];
		}

		if(var_00[var_05] > var_12)
		{
			var_11 = var_05;
			var_12 = var_00[var_05];
		}
	}

	if(var_12 - var_10 >= 2)
	{
		var_0E = var_0F;
	}
	else
	{
		var_0E = common_scripts\utility::func_6306(level.bot_personality[var_0B]);
	}

	if(self botgetpersonality() != var_0E)
	{
		self botsetpersonality(var_0E);
	}

	self.has_balanced_personality = 1;
}

//Function Number: 4
init_personality_camper()
{
	func_1D01();
}

//Function Number: 5
func_4585()
{
	func_1D01();
}

//Function Number: 6
func_8698()
{
	if(func_748C() && !maps/mp/bots/_bots_util::bot_is_defending() && !maps/mp/bots/_bots_util::bot_is_remote_or_linked())
	{
		var_00 = self botgetscriptgoaltype();
		var_01 = 0;
		if(!isdefined(self.camper_time_started_hunting))
		{
			self.camper_time_started_hunting = 0;
		}

		var_02 = var_00 == "hunt";
		var_03 = gettime() > self.camper_time_started_hunting + 10000;
		if((!var_02 || var_03) && !maps/mp/bots/_bots_util::bot_out_of_ammo())
		{
			if(!self bothasscriptgoal())
			{
				bot_random_path();
			}

			var_01 = func_325F();
			if(!var_01)
			{
				self.camper_time_started_hunting = gettime();
			}
		}

		if(isdefined(var_01) && var_01)
		{
			self.ambush_entrances = maps/mp/bots/_bots_util::bot_queued_process("bot_find_ambush_entrances",::bot_find_ambush_entrances,self.node_ambushing_from,1);
			var_04 = maps/mp/bots/_bots_strategy::func_15DE("trap_directional","trap","c4");
			if(isdefined(var_04))
			{
				var_05 = gettime();
				maps/mp/bots/_bots_strategy::bot_set_ambush_trap(var_04,self.ambush_entrances,self.node_ambushing_from,self.ambush_yaw);
				var_05 = gettime() - var_05;
				if(var_05 > 0 && isdefined(self.ambush_end) && isdefined(self.node_ambushing_from))
				{
					self.ambush_end = self.ambush_end + var_05;
					self.node_ambushing_from.bot_ambush_end = self.ambush_end + 10000;
				}
			}

			if(!maps/mp/bots/_bots_strategy::bot_has_tactical_goal() && !maps/mp/bots/_bots_util::bot_is_defending() && isdefined(self.node_ambushing_from))
			{
				self botsetscriptgoalnode(self.node_ambushing_from,"camp",self.ambush_yaw);
				thread clear_script_goal_on("bad_path","node_relinquished","out_of_ammo");
				thread func_8C9A();
				thread bot_add_ambush_time_delayed("clear_camper_data","goal");
				thread func_16C9("clear_camper_data","bot_add_ambush_time_delayed",self.ambush_entrances,self.ambush_yaw);
			}
		}

		if(var_00 == "camp")
		{
			self botclearscriptgoal();
		}

		func_8699();
	}
}

//Function Number: 7
func_8699()
{
	var_00 = undefined;
	var_01 = self bothasscriptgoal();
	if(var_01)
	{
		var_00 = self botgetscriptgoal();
	}

	if(!maps/mp/bots/_bots_strategy::bot_has_tactical_goal() && !maps/mp/bots/_bots_util::bot_is_remote_or_linked())
	{
		var_02 = undefined;
		var_03 = undefined;
		if(var_01)
		{
			var_02 = distancesquared(self.origin,var_00);
			var_03 = self botgetscriptgoalradius();
			var_04 = var_03 * 2;
			if(isdefined(self.bot_memory_goal) && var_02 < var_04 * var_04)
			{
				var_05 = botmemoryflags("investigated");
				botflagmemoryevents(0,gettime() - self.bot_memory_goal_time,1,self.bot_memory_goal,var_04,"kill",var_05,self);
				botflagmemoryevents(0,gettime() - self.bot_memory_goal_time,1,self.bot_memory_goal,var_04,"death",var_05,self);
				self.bot_memory_goal = undefined;
				self.bot_memory_goal_time = undefined;
			}
		}

		if(!var_01 || var_02 < var_03 * var_03)
		{
			var_06 = bot_random_path();
			if(var_06 && randomfloat(100) < 25)
			{
				var_07 = maps/mp/bots/_bots_strategy::func_15DE("trap_directional","trap");
				if(isdefined(var_07))
				{
					var_08 = self botgetscriptgoal();
					if(isdefined(var_08))
					{
						var_09 = getclosestnodeinsight(var_08);
						if(isdefined(var_09))
						{
							var_0A = maps/mp/bots/_bots_util::bot_queued_process("bot_find_ambush_entrances",::bot_find_ambush_entrances,var_09,0);
							var_0B = maps/mp/bots/_bots_strategy::bot_set_ambush_trap(var_07,var_0A,var_09);
							if(!isdefined(var_0B) || var_0B)
							{
								self botclearscriptgoal();
								var_06 = bot_random_path();
							}
						}
					}
				}
			}

			if(var_06)
			{
				thread clear_script_goal_on("enemy","bad_path","goal","node_relinquished","search_end");
			}
		}
	}
}

//Function Number: 8
clear_script_goal_on(param_00,param_01,param_02,param_03,param_04)
{
	self notify("clear_script_goal_on");
	self endon("clear_script_goal_on");
	self endon("death");
	self endon("disconnect");
	self endon("start_tactical_goal");
	var_05 = self botgetscriptgoal();
	var_06 = 1;
	while(var_06)
	{
		var_07 = common_scripts\utility::func_8B33(param_00,param_01,param_02,param_03,param_04,"script_goal_changed");
		var_06 = 0;
		var_08 = 1;
		if(var_07 == "node_relinquished" || var_07 == "goal" || var_07 == "script_goal_changed")
		{
			if(!self bothasscriptgoal())
			{
				var_08 = 0;
			}
			else
			{
				var_09 = self botgetscriptgoal();
				var_08 = maps/mp/bots/_bots_util::func_16C0(var_05,var_09);
			}
		}

		if(var_07 == "enemy" && isdefined(self.enemy))
		{
			var_08 = 0;
			var_06 = 1;
		}

		if(var_08)
		{
			self botclearscriptgoal();
		}
	}
}

//Function Number: 9
func_8C9A()
{
	self notify("watch_out_of_ammo");
	self endon("watch_out_of_ammo");
	self endon("death");
	self endon("disconnect");
	while(!maps/mp/bots/_bots_util::bot_out_of_ammo())
	{
		wait(0.5);
	}

	self notify("out_of_ammo");
}

//Function Number: 10
bot_add_ambush_time_delayed(param_00,param_01)
{
	self notify("bot_add_ambush_time_delayed");
	self endon("bot_add_ambush_time_delayed");
	self endon("death");
	self endon("disconnect");
	if(isdefined(param_00))
	{
		self endon(param_00);
	}

	self endon("node_relinquished");
	self endon("bad_path");
	var_02 = gettime();
	if(isdefined(param_01))
	{
		self waittill(param_01);
	}

	if(isdefined(self.ambush_end) && isdefined(self.node_ambushing_from))
	{
		self.ambush_end = self.ambush_end + gettime() - var_02;
		self.node_ambushing_from.bot_ambush_end = self.ambush_end + 10000;
	}

	self notify("bot_add_ambush_time_delayed");
}

//Function Number: 11
func_16C9(param_00,param_01,param_02,param_03)
{
	self notify("bot_watch_entrances_delayed");
	if(param_02.size > 0)
	{
		self endon("bot_watch_entrances_delayed");
		self endon("death");
		self endon("disconnect");
		self endon(param_00);
		self endon("node_relinquished");
		self endon("bad_path");
		if(isdefined(param_01))
		{
			self waittill(param_01);
		}

		self endon("path_enemy");
		childthread maps/mp/bots/_bots_util::bot_watch_nodes(param_02,param_03,0,self.ambush_end);
		childthread func_163E();
	}
}

//Function Number: 12
func_163E()
{
	self notify("bot_monitor_watch_entrances_camp");
	self endon("bot_monitor_watch_entrances_camp");
	self notify("bot_monitor_watch_entrances");
	self endon("bot_monitor_watch_entrances");
	self endon("disconnect");
	self endon("death");
	while(!isdefined(self.watch_nodes))
	{
		wait(0.05);
	}

	while(isdefined(self.watch_nodes))
	{
		foreach(var_01 in self.watch_nodes)
		{
			var_01.watch_node_chance[self.entity_number] = 1;
		}

		maps/mp/bots/_bots_strategy::prioritize_watch_nodes_toward_enemies(0.5);
		wait(randomfloatrange(0.5,0.75));
	}
}

//Function Number: 13
bot_find_ambush_entrances(param_00,param_01)
{
	self endon("disconnect");
	var_02 = [];
	var_03 = findentrances(param_00.origin);
	if(isdefined(var_03) && var_03.size > 0)
	{
		wait(0.05);
		var_04 = param_00.type != "Cover Stand" && param_00.type != "Conceal Stand";
		if(var_04 && param_01)
		{
			var_03 = self botnodescoremultiple(var_03,"node_exposure_vis",param_00.origin,"crouch");
		}

		foreach(var_06 in var_03)
		{
			if(distancesquared(self.origin,var_06.origin) < 90000)
			{
				continue;
			}

			if(var_04 && param_01)
			{
				wait(0.05);
				if(!maps/mp/bots/_bots_util::entrance_visible_from(var_06.origin,param_00.origin,"crouch"))
				{
					continue;
				}
			}

			var_02[var_02.size] = var_06;
		}
	}

	return var_02;
}

//Function Number: 14
bot_filter_ambush_inuse(param_00)
{
	var_01 = [];
	var_02 = gettime();
	var_03 = param_00.size;
	for(var_04 = 0;var_04 < var_03;var_04++)
	{
		var_05 = param_00[var_04];
		if(!isdefined(var_05.bot_ambush_end) || var_02 > var_05.bot_ambush_end)
		{
			var_01[var_01.size] = var_05;
		}
	}

	return var_01;
}

//Function Number: 15
bot_filter_ambush_vicinity(param_00,param_01,param_02)
{
	var_03 = [];
	var_04 = [];
	var_05 = param_02 * param_02;
	if(level.teambased)
	{
		foreach(var_07 in level.participants)
		{
			if(!maps\mp\_utility::func_4945(var_07))
			{
				continue;
			}

			if(!isdefined(var_07.team))
			{
				continue;
			}

			if(var_07.team == param_01.team && var_07 != param_01 && isdefined(var_07.node_ambushing_from))
			{
				var_04[var_04.size] = var_07.node_ambushing_from.origin;
			}
		}
	}

	var_09 = var_04.size;
	var_0A = param_00.size;
	for(var_0B = 0;var_0B < var_0A;var_0B++)
	{
		var_0C = 0;
		var_0D = param_00[var_0B];
		for(var_0E = 0;!var_0C && var_0E < var_09;var_0E++)
		{
			var_0F = distancesquared(var_04[var_0E],var_0D.origin);
			var_0C = var_0F < var_05;
		}

		if(!var_0C)
		{
			var_03[var_03.size] = var_0D;
		}
	}

	return var_03;
}

//Function Number: 16
func_1D01()
{
	self notify("clear_camper_data");
	if(isdefined(self.node_ambushing_from) && isdefined(self.node_ambushing_from.bot_ambush_end))
	{
		self.node_ambushing_from.bot_ambush_end = undefined;
	}

	self.node_ambushing_from = undefined;
	self.point_to_ambush = undefined;
	self.ambush_yaw = undefined;
	self.ambush_entrances = undefined;
	self.ambush_duration = randomintrange(20000,30000);
	self.ambush_end = -1;
}

//Function Number: 17
func_748C()
{
	if(maps/mp/bots/_bots_strategy::bot_has_tactical_goal())
	{
		return 0;
	}

	if(gettime() > self.ambush_end)
	{
		return 1;
	}

	if(!self bothasscriptgoal())
	{
		return 1;
	}

	return 0;
}

//Function Number: 18
func_325F()
{
	self notify("find_camp_node");
	self endon("find_camp_node");
	return maps/mp/bots/_bots_util::bot_queued_process("find_camp_node_worker",::find_camp_node_worker);
}

//Function Number: 19
find_camp_node_worker()
{
	self notify("find_camp_node_worker");
	self endon("find_camp_node_worker");
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	func_1D01();
	if(level.zonecount <= 0)
	{
		return 0;
	}

	var_00 = getzonenearest(self.origin);
	var_01 = undefined;
	var_02 = undefined;
	var_03 = self.angles;
	if(isdefined(var_00))
	{
		var_04 = botzonenearestcount(var_00,self.team,-1,"enemy_predict",">",0,"ally","<",1);
		if(!isdefined(var_04))
		{
			var_04 = botzonenearestcount(var_00,self.team,-1,"enemy_predict",">",0);
		}

		if(!isdefined(var_04))
		{
			var_05 = -1;
			var_06 = -1;
			for(var_07 = 0;var_07 < level.zonecount;var_07++)
			{
				var_08 = distance2dsquared(getzoneorigin(var_07),self.origin);
				if(var_08 > var_05)
				{
					var_05 = var_08;
					var_06 = var_07;
				}
			}

			var_04 = var_06;
		}

		var_09 = getzonepath(var_00,var_04);
		if(isdefined(var_09) && var_09.size > 0)
		{
			for(var_0A = 0;var_0A <= int(var_09.size / 2);var_0A++)
			{
				var_01 = var_09[var_0A];
				var_02 = var_09[int(min(var_0A + 1,var_09.size - 1))];
				if(botzonegetcount(var_02,self.team,"enemy_predict") != 0)
				{
					break;
				}
			}

			if(isdefined(var_01) && isdefined(var_02) && var_01 != var_02)
			{
				var_03 = getzoneorigin(var_02) - getzoneorigin(var_01);
				var_03 = vectortoangles(var_03);
			}
		}
	}

	var_0B = undefined;
	if(isdefined(var_01))
	{
		var_0C = 1;
		var_0D = 1;
		var_0E = 0;
		while(var_0C)
		{
			var_0F = getzonenodesbydist(var_01,800 * var_0D,1);
			if(var_0F.size > 1024)
			{
				var_0F = getzonenodes(var_01,0);
			}

			wait(0.05);
			var_10 = randomint(100);
			if(var_10 < 66 && var_10 >= 33)
			{
				var_03 = (var_03[0],var_03[1] + 45,0);
			}
			else if(var_10 < 33)
			{
				var_03 = (var_03[0],var_03[1] - 45,0);
			}

			if(var_0F.size > 0)
			{
				var_11 = int(min(max(1,var_0F.size * 0.15),5));
				if(var_0E)
				{
					var_0F = self botnodepickmultiple(var_0F,var_11,var_11,"node_camp",anglestoforward(var_03),"lenient");
				}
				else
				{
					var_0F = self botnodepickmultiple(var_0F,var_11,var_11,"node_camp",anglestoforward(var_03));
				}

				var_0F = bot_filter_ambush_inuse(var_0F);
				if(!isdefined(self.can_camp_near_others) || !self.can_camp_near_others)
				{
					var_12 = 800;
					var_0F = bot_filter_ambush_vicinity(var_0F,self,var_12);
				}

				if(var_0F.size > 0)
				{
					var_0B = common_scripts\utility::random_weight_sorted(var_0F);
				}
			}

			if(isdefined(var_0B))
			{
				var_0C = 0;
				continue;
			}

			if(isdefined(self.camping_needs_fallback_camp_location))
			{
				if(var_0D == 1 && !var_0E)
				{
					var_0D = 3;
				}
				else if(var_0D == 3 && !var_0E)
				{
					var_0E = 1;
				}
				else if(var_0D == 3 && var_0E)
				{
					var_0C = 0;
				}

				continue;
			}

			var_0C = 0;
			if(var_0C)
			{
				wait(0.05);
			}
		}
	}

	if(!isdefined(var_0B) || !self botnodeavailable(var_0B))
	{
		return 0;
	}

	self.node_ambushing_from = var_0B;
	self.ambush_end = gettime() + self.ambush_duration;
	self.node_ambushing_from.bot_ambush_end = self.ambush_end;
	self.ambush_yaw = var_03[1];
	return 1;
}

//Function Number: 20
func_325A(param_00,param_01)
{
	func_1D01();
	if(isdefined(param_00))
	{
		self.point_to_ambush = param_00;
	}
	else
	{
		var_02 = undefined;
		var_03 = getnodesinradius(self.origin,5000,0,2000);
		if(var_03.size > 0)
		{
			var_02 = self botnodepick(var_03,var_03.size * 0.25,"node_traffic");
		}

		if(isdefined(var_02))
		{
			self.point_to_ambush = var_02.origin;
		}
		else
		{
			return 0;
		}
	}

	var_04 = 2000;
	if(isdefined(param_01))
	{
		var_04 = param_01;
	}

	var_05 = getnodesinradius(self.point_to_ambush,var_04,0,1000);
	var_06 = undefined;
	if(var_05.size > 0)
	{
		var_07 = int(max(1,int(var_05.size * 0.15)));
		var_05 = self botnodepickmultiple(var_05,var_07,var_07,"node_ambush",self.point_to_ambush);
	}

	var_05 = bot_filter_ambush_inuse(var_05);
	if(var_05.size > 0)
	{
		var_06 = common_scripts\utility::random_weight_sorted(var_05);
	}

	if(!isdefined(var_06) || !self botnodeavailable(var_06))
	{
		return 0;
	}

	self.node_ambushing_from = var_06;
	self.ambush_end = gettime() + self.ambush_duration;
	self.node_ambushing_from.bot_ambush_end = self.ambush_end;
	var_08 = vectornormalize(self.point_to_ambush - self.node_ambushing_from.origin);
	var_09 = vectortoangles(var_08);
	self.ambush_yaw = var_09[1];
	return 1;
}

//Function Number: 21
bot_random_path()
{
	if(maps/mp/bots/_bots_util::bot_is_remote_or_linked())
	{
		return 0;
	}

	var_00 = level.bot_random_path_function[self.team];
	return self [[ var_00 ]]();
}

//Function Number: 22
bot_random_path_default()
{
	var_00 = 0;
	var_01 = 50;
	if(self.personality == "camper")
	{
		var_01 = 0;
	}

	var_02 = undefined;
	if(randomint(100) < var_01)
	{
		var_02 = maps/mp/bots/_bots_util::func_1672();
	}

	if(!isdefined(var_02))
	{
		var_03 = self botfindnoderandom();
		if(isdefined(var_03))
		{
			var_02 = var_03.origin;
		}
	}

	if(isdefined(var_02))
	{
		var_00 = self botsetscriptgoal(var_02,128,"hunt");
	}

	return var_00;
}

//Function Number: 23
bot_setup_callback_class()
{
	if(maps/mp/bots/_bots_loadout::func_1691())
	{
		return "callback";
	}

	return "class0";
}