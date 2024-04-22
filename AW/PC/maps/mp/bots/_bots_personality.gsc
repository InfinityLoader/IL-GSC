/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: mp\bots\_bots_personality.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 24
 * Decompile Time: 350 ms
 * Timestamp: 4/22/2024 2:08:53 AM
*******************************************************************/

//Function Number: 1
setup_personalities()
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
	level.bot_personality_types_desired["active"] = 4;
	level.bot_personality_types_desired["stationary"] = 1;
	level.bot_pers_init = [];
	level.bot_pers_init["default"] = ::init_personality_default;
	level.bot_pers_init["camper"] = ::init_personality_camper;
	level.bot_pers_update["default"] = ::update_personality_default;
	level.bot_pers_update["camper"] = ::update_personality_camper;
}

//Function Number: 2
bot_assign_personality_functions()
{
	self.personality = self botgetpersonality();
	self.pers["personality"] = self.personality;
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
		return;
	}

	if(isdefined(self.pers["personality"]))
	{
		self botsetpersonality(self.pers["personality"]);
		return;
	}

	var_00 = self.team;
	if(!isdefined(var_00) && !isdefined(self.bot_team))
	{
		var_00 = self.pers["team"];
	}

	var_01 = [];
	var_02 = [];
	foreach(var_08, var_04 in level.bot_personality)
	{
		var_02[var_08] = 0;
		foreach(var_06 in var_04)
		{
			var_01[var_06] = 0;
		}
	}

	foreach(var_0A in level.participants)
	{
		if(maps\mp\_utility::isteamparticipant(var_0A) && isdefined(var_0A.team) && var_0A.team == var_00 && var_0A != self && isdefined(var_0A.has_balanced_personality))
		{
			var_06 = var_0A botgetpersonality();
			var_08 = level.bot_personality_type[var_06];
			var_01[var_06] = var_01[var_06] + 1;
			var_02[var_08] = var_02[var_08] + 1;
		}
	}

	var_0C = undefined;
	while(!isdefined(var_0C))
	{
		for(var_0D = level.bot_personality_types_desired;var_0D.size > 0;var_0D[var_0E] = undefined)
		{
			var_0E = maps\mp\bots\_bots_util::bot_get_string_index_for_integer(var_0D,randomint(var_0D.size));
			var_02[var_0E] = var_02[var_0E] - level.bot_personality_types_desired[var_0E];
			if(var_02[var_0E] < 0)
			{
				var_0C = var_0E;
				break;
			}
		}
	}

	var_0F = undefined;
	var_10 = undefined;
	var_11 = 9999;
	var_12 = undefined;
	var_13 = -9999;
	var_14 = common_scripts\utility::array_randomize(level.bot_personality[var_0C]);
	foreach(var_06 in var_14)
	{
		if(var_01[var_06] < var_11)
		{
			var_10 = var_06;
			var_11 = var_01[var_06];
		}

		if(var_01[var_06] > var_13)
		{
			var_12 = var_06;
			var_13 = var_01[var_06];
		}
	}

	if(var_13 - var_11 >= 2)
	{
		var_0F = var_10;
	}
	else
	{
		var_0F = common_scripts\utility::random(level.bot_personality[var_0C]);
	}

	if(self botgetpersonality() != var_0F)
	{
		self botsetpersonality(var_0F);
	}

	self.has_balanced_personality = 1;
}

//Function Number: 4
init_personality_camper()
{
	clear_camper_data();
}

//Function Number: 5
init_personality_default()
{
	clear_camper_data();
}

//Function Number: 6
update_personality_camper()
{
	if(should_select_new_ambush_point() && !maps\mp\bots\_bots_util::bot_is_defending() && !maps\mp\bots\_bots_util::bot_is_remote_or_linked())
	{
		var_00 = self botgetscriptgoaltype();
		var_01 = 0;
		if(!isdefined(self.camper_time_started_hunting))
		{
			self.camper_time_started_hunting = 0;
		}

		var_02 = var_00 == "hunt";
		var_03 = gettime() > self.camper_time_started_hunting + 10000;
		if((!var_02 || var_03) && !maps\mp\bots\_bots_util::bot_out_of_ammo())
		{
			if(!self bothasscriptgoal())
			{
				bot_random_path();
			}

			var_01 = find_camp_node();
			if(!var_01)
			{
				self.camper_time_started_hunting = gettime();
			}
		}

		if(isdefined(var_01) && var_01)
		{
			self.ambush_entrances = maps\mp\bots\_bots_util::bot_queued_process("bot_find_ambush_entrances",::bot_find_ambush_entrances,self.node_ambushing_from,1);
			var_04 = maps\mp\bots\_bots_strategy::bot_get_ambush_trap_item("trap_directional","trap","c4");
			if(isdefined(var_04))
			{
				var_05 = gettime();
				maps\mp\bots\_bots_strategy::bot_set_ambush_trap(var_04,self.ambush_entrances,self.node_ambushing_from,self.ambush_yaw);
				var_05 = gettime() - var_05;
				if(var_05 > 0 && isdefined(self.ambush_end) && isdefined(self.node_ambushing_from))
				{
					self.ambush_end = self.ambush_end + var_05;
					self.node_ambushing_from.bot_ambush_end = self.ambush_end + 10000;
				}
			}

			if(!maps\mp\bots\_bots_strategy::bot_has_tactical_goal() && !maps\mp\bots\_bots_util::bot_is_defending() && isdefined(self.node_ambushing_from))
			{
				self botsetscriptgoalnode(self.node_ambushing_from,"camp",self.ambush_yaw);
				thread clear_script_goal_on("bad_path","node_relinquished","out_of_ammo");
				thread watch_out_of_ammo();
				thread bot_add_ambush_time_delayed("clear_camper_data","goal");
				thread bot_watch_entrances_delayed("clear_camper_data","bot_add_ambush_time_delayed",self.ambush_entrances,self.ambush_yaw);
				childthread bot_try_trap_follower("clear_camper_data","goal");
				return;
			}

			return;
		}

		if(var_00 == "camp")
		{
			self botclearscriptgoal();
		}

		update_personality_default();
	}
}

//Function Number: 7
update_personality_default()
{
	var_00 = undefined;
	var_01 = self bothasscriptgoal();
	if(var_01)
	{
		var_00 = self botgetscriptgoal();
	}

	if(gettime() - self.lastspawntime > 5000)
	{
		bot_try_trap_follower();
	}

	if(!maps\mp\bots\_bots_strategy::bot_has_tactical_goal() && !maps\mp\bots\_bots_util::bot_is_remote_or_linked())
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
				var_07 = maps\mp\bots\_bots_strategy::bot_get_ambush_trap_item("trap_directional","trap");
				if(isdefined(var_07))
				{
					var_08 = self botgetscriptgoal();
					if(isdefined(var_08))
					{
						var_09 = getclosestnodeinsight(var_08);
						if(isdefined(var_09))
						{
							var_0A = bot_find_ambush_entrances(var_09,0);
							var_0B = maps\mp\bots\_bots_strategy::bot_set_ambush_trap(var_07,var_0A,var_09);
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
				return;
			}
		}
	}
}

//Function Number: 8
bot_try_trap_follower(param_00,param_01)
{
	self notify("bot_try_trap_follower");
	self endon("bot_try_trap_follower");
	self endon("death");
	self endon("disconnect");
	if(isdefined(param_00))
	{
		self endon(param_00);
	}

	self endon("node_relinquished");
	self endon("bad_path");
	if(isdefined(param_01))
	{
		self waittill(param_01);
	}

	var_02 = maps\mp\bots\_bots_strategy::bot_get_ambush_trap_item("trap_follower");
	if(isdefined(var_02) && self isonground())
	{
		var_03 = maps\mp\bots\_bots_util::bot_get_nodes_in_cone(300,600,0.7,1);
		if(var_03.size > 0)
		{
			self botpressbutton(var_02["item_action"]);
			common_scripts\utility::waittill_any_timeout(5,"grenade_fire","missile_fire");
		}
	}
}

//Function Number: 9
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
		var_07 = common_scripts\utility::waittill_any_return(param_00,param_01,param_02,param_03,param_04,"script_goal_changed");
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
				var_08 = maps\mp\bots\_bots_util::bot_vectors_are_equal(var_05,var_09);
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

//Function Number: 10
watch_out_of_ammo()
{
	self notify("watch_out_of_ammo");
	self endon("watch_out_of_ammo");
	self endon("death");
	self endon("disconnect");
	while(!maps\mp\bots\_bots_util::bot_out_of_ammo())
	{
		wait(0.5);
	}

	self notify("out_of_ammo");
}

//Function Number: 11
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

//Function Number: 12
bot_watch_entrances_delayed(param_00,param_01,param_02,param_03)
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
		childthread maps\mp\bots\_bots_util::bot_watch_nodes(param_02,param_03,0,self.ambush_end);
		childthread bot_monitor_watch_entrances_camp();
	}
}

//Function Number: 13
bot_monitor_watch_entrances_camp()
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

		maps\mp\bots\_bots_strategy::prioritize_watch_nodes_toward_enemies(0.5);
		wait(randomfloatrange(0.5,0.75));
	}
}

//Function Number: 14
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
				if(!maps\mp\bots\_bots_util::entrance_visible_from(var_06.origin,param_00.origin,"crouch"))
				{
					continue;
				}
			}

			var_02[var_02.size] = var_06;
		}
	}

	return var_02;
}

//Function Number: 15
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

//Function Number: 16
bot_filter_ambush_vicinity(param_00,param_01,param_02)
{
	var_03 = [];
	var_04 = [];
	var_05 = param_02 * param_02;
	if(level.teambased)
	{
		foreach(var_07 in level.participants)
		{
			if(!maps\mp\_utility::isreallyalive(var_07))
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

//Function Number: 17
clear_camper_data()
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

//Function Number: 18
should_select_new_ambush_point()
{
	if(maps\mp\bots\_bots_strategy::bot_has_tactical_goal())
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

//Function Number: 19
find_camp_node()
{
	self notify("find_camp_node");
	self endon("find_camp_node");
	return maps\mp\bots\_bots_util::bot_queued_process("find_camp_node_worker",::find_camp_node_worker);
}

//Function Number: 20
find_camp_node_worker()
{
	self notify("find_camp_node_worker");
	self endon("find_camp_node_worker");
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	clear_camper_data();
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

		if(isdefined(var_04))
		{
			var_05 = getzonenodeforindex(var_04);
			var_06 = getlinkednodes(var_05);
			if(var_06.size == 0)
			{
				var_04 = undefined;
			}
		}

		if(!isdefined(var_04))
		{
			var_07 = -1;
			var_08 = -1;
			for(var_09 = 0;var_09 < level.zonecount;var_09++)
			{
				var_05 = getzonenodeforindex(var_09);
				var_06 = getlinkednodes(var_05);
				if(var_06.size > 0)
				{
					var_0A = common_scripts\utility::random(getzonenodes(var_09));
					var_0B = isdefined(var_0A.targetname) && var_0A.targetname == "no_bot_random_path";
					if(!var_0B)
					{
						var_0C = distance2dsquared(getzoneorigin(var_09),self.origin);
						if(var_0C > var_07)
						{
							var_07 = var_0C;
							var_08 = var_09;
						}
					}
				}
			}

			var_04 = var_08;
		}

		var_0D = getzonepath(var_00,var_04);
		if(!isdefined(var_0D) || var_0D.size == 0)
		{
			return 0;
		}

		for(var_0E = 0;var_0E <= int(var_0D.size / 2);var_0E++)
		{
			var_01 = var_0D[var_0E];
			var_02 = var_0D[int(min(var_0E + 1,var_0D.size - 1))];
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

	var_0F = undefined;
	if(isdefined(var_01))
	{
		var_10 = 1;
		var_11 = 1;
		var_12 = 0;
		while(var_10)
		{
			var_13 = getzonenodesbydist(var_01,800 * var_11,1);
			if(var_13.size > 1024)
			{
				var_13 = getzonenodes(var_01,0);
			}

			wait(0.05);
			var_14 = randomint(100);
			if(var_14 < 66 && var_14 >= 33)
			{
				var_03 = (var_03[0],var_03[1] + 45,0);
			}
			else if(var_14 < 33)
			{
				var_03 = (var_03[0],var_03[1] - 45,0);
			}

			if(var_13.size > 0)
			{
				while(var_13.size > 1024)
				{
					var_13[var_13.size - 1] = undefined;
				}

				var_15 = int(clamp(var_13.size * 0.15,1,10));
				if(var_12)
				{
					var_13 = self botnodepickmultiple(var_13,var_15,var_15,"node_camp",anglestoforward(var_03),"lenient");
				}
				else
				{
					var_13 = self botnodepickmultiple(var_13,var_15,var_15,"node_camp",anglestoforward(var_03));
				}

				var_13 = bot_filter_ambush_inuse(var_13);
				if(!isdefined(self.can_camp_near_others) || !self.can_camp_near_others)
				{
					var_16 = 800;
					var_13 = bot_filter_ambush_vicinity(var_13,self,var_16);
				}

				if(var_13.size > 0)
				{
					var_0F = common_scripts\utility::random_weight_sorted(var_13);
				}
			}

			if(isdefined(var_0F))
			{
				var_10 = 0;
				continue;
			}

			if(isdefined(self.camping_needs_fallback_camp_location))
			{
				if(var_11 == 1 && !var_12)
				{
					var_11 = 3;
				}
				else if(var_11 == 3 && !var_12)
				{
					var_12 = 1;
				}
				else if(var_11 == 3 && var_12)
				{
					var_10 = 0;
				}

				continue;
			}

			var_10 = 0;
			if(var_10)
			{
				wait(0.05);
			}
		}
	}

	if(!isdefined(var_0F) || !self botnodeavailable(var_0F))
	{
		return 0;
	}

	self.node_ambushing_from = var_0F;
	self.ambush_end = gettime() + self.ambush_duration;
	self.node_ambushing_from.bot_ambush_end = self.ambush_end;
	self.ambush_yaw = var_03[1];
	return 1;
}

//Function Number: 21
find_ambush_node(param_00,param_01)
{
	clear_camper_data();
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

//Function Number: 22
bot_random_path()
{
	if(maps\mp\bots\_bots_util::bot_is_remote_or_linked())
	{
		return 0;
	}

	var_00 = level.bot_random_path_function[self.team];
	return self [[ var_00 ]]();
}

//Function Number: 23
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
		var_02 = maps\mp\bots\_bots_util::bot_recent_point_of_interest();
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

//Function Number: 24
bot_setup_callback_class()
{
	if(maps\mp\_utility::practiceroundgame())
	{
		return "practice" + randomintrange(1,6);
	}

	if(maps\mp\bots\_bots_loadout::bot_setup_loadout_callback())
	{
		return "callback";
	}

	return "class0";
}