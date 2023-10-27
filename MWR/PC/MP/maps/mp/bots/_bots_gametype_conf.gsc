/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\bots\_bots_gametype_conf.gsc
 * Game: Call of Duty: Modern Warfare Remastered
 * Platform: PC
 * Function Count: 16
 * Decompile Time: 215 ms
 * Timestamp: 10/27/2023 2:37:08 AM
*******************************************************************/

//Function Number: 1
main()
{
	setup_callbacks();
	setup_bot_conf();
}

//Function Number: 2
setup_callbacks()
{
	level.bot_funcs["gametype_think"] = ::bot_conf_think;
}

//Function Number: 3
setup_bot_conf()
{
	level.bot_tag_obj_radius = 200;
	level.bot_tag_allowable_jump_height = 38;
	if(maps\mp\_utility::isaugmentedgamemode())
	{
		level.bot_tag_allowable_jump_height = level.bot_tag_allowable_jump_height + 170;
	}
}

//Function Number: 4
bot_conf_think()
{
	self notify("bot_conf_think");
	self endon("bot_conf_think");
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	self.next_time_check_tags = gettime() + 500;
	self.tags_seen = [];
	childthread bot_watch_new_tags();
	if(self.personality == "camper")
	{
		self.conf_camper_camp_tags = 0;
		if(!isdefined(self.conf_camping_tag))
		{
			self.conf_camping_tag = 0;
		}
	}

	for(;;)
	{
		var_00 = isdefined(self.tag_getting);
		var_01 = 0;
		if(var_00 && self bothasscriptgoal())
		{
			var_02 = self botgetscriptgoal();
			if(maps\mp\bots\_bots_util::bot_vectors_are_equal(self.tag_getting.ground_pos,var_02))
			{
				if(self botpursuingscriptgoal())
				{
					var_01 = 1;
				}
			}
			else if(maps\mp\bots\_bots_strategy::bot_has_tactical_goal("kill_tag") && self.tag_getting maps\mp\gametypes\_gameobjects::caninteractwith(self.team))
			{
				self.tag_getting = undefined;
				var_00 = 0;
			}
		}

		self botsetflag("force_sprint",var_01);
		self.tags_seen = bot_remove_invalid_tags(self.tags_seen);
		var_03 = bot_find_best_tag_from_array(self.tags_seen,1);
		var_04 = isdefined(var_03);
		if((var_00 && !var_04) || !var_00 && var_04 || var_00 && var_04 && self.tag_getting != var_03)
		{
			self.tag_getting = var_03;
			self botclearscriptgoal();
			self notify("stop_camping_tag");
			maps\mp\bots\_bots_personality::clear_camper_data();
			maps\mp\bots\_bots_strategy::bot_abort_tactical_goal("kill_tag");
		}

		if(isdefined(self.tag_getting))
		{
			self.conf_camping_tag = 0;
			if(self.personality == "camper" && self.conf_camper_camp_tags)
			{
				self.conf_camping_tag = 1;
				if(maps\mp\bots\_bots_personality::should_select_new_ambush_point())
				{
					if(maps\mp\bots\_bots_personality::find_ambush_node(self.tag_getting.ground_pos,1000))
					{
						childthread bot_camp_tag(self.tag_getting,"camp");
					}
					else
					{
						self.conf_camping_tag = 0;
					}
				}
			}

			if(!self.conf_camping_tag)
			{
				if(!maps\mp\bots\_bots_strategy::bot_has_tactical_goal("kill_tag"))
				{
					var_05 = spawnstruct();
					var_05.script_goal_type = "objective";
					var_05.objective_radius = level.bot_tag_obj_radius;
					maps\mp\bots\_bots_strategy::bot_new_tactical_goal("kill_tag",self.tag_getting.ground_pos,25,var_05);
				}
			}
		}

		var_06 = 0;
		if(isdefined(self.additional_tactical_logic_func))
		{
			var_06 = self [[ self.additional_tactical_logic_func ]]();
		}

		if(!isdefined(self.tag_getting))
		{
			if(!var_06)
			{
				self [[ self.personality_update_function ]]();
			}
		}

		if(gettime() > self.next_time_check_tags)
		{
			self.next_time_check_tags = gettime() + 500;
			var_07 = bot_find_visible_tags(1);
			self.tags_seen = bot_combine_tag_seen_arrays(var_07,self.tags_seen);
		}

		wait(0.05);
	}
}

//Function Number: 5
bot_check_tag_above_head(param_00)
{
	if(isdefined(param_00.on_path_grid) && param_00.on_path_grid)
	{
		var_01 = self.origin + (0,0,55);
		if(distance2dsquared(param_00.curorigin,var_01) < 144)
		{
			var_02 = param_00.curorigin[2] - var_01[2];
			if(var_02 > 0)
			{
				if(var_02 < level.bot_tag_allowable_jump_height)
				{
					if(!isdefined(self.last_time_jumped_for_tag))
					{
						self.last_time_jumped_for_tag = 0;
					}

					if(gettime() - self.last_time_jumped_for_tag > 3000)
					{
						self.last_time_jumped_for_tag = gettime();
						thread bot_jump_for_tag();
					}
				}
				else
				{
					param_00.on_path_grid = 0;
					return 1;
				}
			}
		}
	}

	return 0;
}

//Function Number: 6
bot_jump_for_tag()
{
	self endon("death");
	self endon("disconnect");
	self botsetstance("stand");
	wait(1);
	self botpressbutton("jump");
	wait(0.5);
	if(maps\mp\_utility::isaugmentedgamemode())
	{
		self botpressbutton("jump");
	}

	wait(0.5);
	self botsetstance("none");
}

//Function Number: 7
bot_watch_new_tags()
{
	for(;;)
	{
		level waittill("new_tag_spawned",var_00);
		self.next_time_check_tags = -1;
		if(isdefined(var_00))
		{
			if((isdefined(var_00.victim) && var_00.victim == self) || isdefined(var_00.attacker) && var_00.attacker == self)
			{
				if(!isdefined(var_00.on_path_grid) && !isdefined(var_00.calculations_in_progress))
				{
					thread calculate_tag_on_path_grid(var_00);
					waittill_tag_calculated_on_path_grid(var_00);
					if(var_00.on_path_grid)
					{
						var_01 = spawnstruct();
						var_01.origin = var_00.curorigin;
						var_01.tag = var_00;
						var_02[0] = var_01;
						self.tags_seen = bot_combine_tag_seen_arrays(var_02,self.tags_seen);
					}
				}
			}
		}
	}
}

//Function Number: 8
bot_combine_tag_seen_arrays(param_00,param_01)
{
	var_02 = param_01;
	foreach(var_04 in param_00)
	{
		var_05 = 0;
		foreach(var_07 in param_01)
		{
			if(var_04.tag == var_07.tag && maps\mp\bots\_bots_util::bot_vectors_are_equal(var_04.origin,var_07.origin))
			{
				var_05 = 1;
				break;
			}
		}

		if(!var_05)
		{
			var_02 = common_scripts\utility::array_add(var_02,var_04);
		}
	}

	return var_02;
}

//Function Number: 9
bot_is_tag_visible(param_00,param_01,param_02)
{
	if(!param_00.calculated_nearest_node)
	{
		param_00.nearest_node = getclosestnodeinsight(param_00.curorigin);
		param_00.calculated_nearest_node = 1;
	}

	if(isdefined(param_00.calculations_in_progress))
	{
		return 0;
	}

	var_03 = param_00.nearest_node;
	var_04 = !isdefined(param_00.on_path_grid);
	if(isdefined(var_03) && var_04 || param_00.on_path_grid)
	{
		var_05 = var_03 == param_01 || nodesvisible(var_03,param_01,1);
		if(var_05)
		{
			var_06 = common_scripts\utility::within_fov(self.origin,self getplayerangles(),param_00.curorigin,param_02);
			if(var_06)
			{
				if(var_04)
				{
					thread calculate_tag_on_path_grid(param_00);
					waittill_tag_calculated_on_path_grid(param_00);
					if(!param_00.on_path_grid)
					{
						return 0;
					}
				}

				return 1;
			}
		}
	}

	return 0;
}

//Function Number: 10
bot_find_visible_tags(param_00,param_01,param_02)
{
	var_03 = undefined;
	if(isdefined(param_01))
	{
		var_03 = param_01;
	}
	else
	{
		var_03 = self getnearestnode();
	}

	var_04 = undefined;
	if(isdefined(param_02))
	{
		var_04 = param_02;
	}
	else
	{
		var_04 = self botgetfovdot();
	}

	var_05 = [];
	if(isdefined(var_03))
	{
		foreach(var_07 in level.dogtags)
		{
			if(var_07 maps\mp\gametypes\_gameobjects::caninteractwith(self.team))
			{
				var_08 = 0;
				if(!param_00 || var_07.attacker == self)
				{
					if(!isdefined(var_07.calculations_in_progress))
					{
						if(!isdefined(var_07.on_path_grid))
						{
							level thread calculate_tag_on_path_grid(var_07);
							waittill_tag_calculated_on_path_grid(var_07);
						}

						var_08 = distancesquared(self.origin,var_07.ground_pos) < 1000000 && var_07.on_path_grid;
					}
				}
				else if(bot_is_tag_visible(var_07,var_03,var_04))
				{
					var_08 = 1;
				}

				if(var_08)
				{
					var_09 = spawnstruct();
					var_09.origin = var_07.curorigin;
					var_09.tag = var_07;
					var_05 = common_scripts\utility::array_add(var_05,var_09);
				}
			}
		}
	}

	return var_05;
}

//Function Number: 11
calculate_tag_on_path_grid(param_00)
{
	param_00 endon("reset");
	param_00.calculations_in_progress = 1;
	param_00.on_path_grid = maps\mp\bots\_bots_util::bot_point_is_on_pathgrid(param_00.curorigin,undefined,level.bot_tag_allowable_jump_height + 55);
	if(param_00.on_path_grid)
	{
		param_00.ground_pos = getgroundposition(param_00.curorigin,32);
		if(!isdefined(param_00.ground_pos))
		{
			param_00.on_path_grid = 0;
		}
	}

	param_00.calculations_in_progress = undefined;
}

//Function Number: 12
waittill_tag_calculated_on_path_grid(param_00)
{
	while(!isdefined(param_00.on_path_grid))
	{
		wait(0.05);
	}
}

//Function Number: 13
bot_find_best_tag_from_array(param_00,param_01)
{
	var_02 = undefined;
	if(param_00.size > 0)
	{
		var_03 = 1409865409;
		foreach(var_05 in param_00)
		{
			var_06 = get_num_allies_getting_tag(var_05.tag);
			if(!param_01 || var_06 < 2)
			{
				var_07 = distancesquared(var_05.tag.ground_pos,self.origin);
				if(var_07 < var_03)
				{
					var_02 = var_05.tag;
					var_03 = var_07;
				}
			}
		}
	}

	return var_02;
}

//Function Number: 14
bot_remove_invalid_tags(param_00)
{
	var_01 = [];
	foreach(var_03 in param_00)
	{
		if(var_03.tag maps\mp\gametypes\_gameobjects::caninteractwith(self.team) && maps\mp\bots\_bots_util::bot_vectors_are_equal(var_03.tag.curorigin,var_03.origin))
		{
			if(!bot_check_tag_above_head(var_03.tag) && var_03.tag.on_path_grid)
			{
				var_01 = common_scripts\utility::array_add(var_01,var_03);
			}
		}
	}

	return var_01;
}

//Function Number: 15
get_num_allies_getting_tag(param_00)
{
	var_01 = 0;
	foreach(var_03 in level.participants)
	{
		if(!isdefined(var_03.team))
		{
			continue;
		}

		if(var_03.team == self.team && var_03 != self)
		{
			if(isai(var_03))
			{
				if(isdefined(var_03.tag_getting) && var_03.tag_getting == param_00)
				{
					var_01++;
				}

				continue;
			}

			if(distancesquared(var_03.origin,param_00.curorigin) < 160000)
			{
				var_01++;
			}
		}
	}

	return var_01;
}

//Function Number: 16
bot_camp_tag(param_00,param_01,param_02)
{
	self notify("bot_camp_tag");
	self endon("bot_camp_tag");
	self endon("stop_camping_tag");
	if(isdefined(param_02))
	{
		self endon(param_02);
	}

	self botsetscriptgoalnode(self.node_ambushing_from,param_01,self.ambush_yaw);
	var_03 = maps\mp\bots\_bots_util::bot_waittill_goal_or_fail();
	if(var_03 == "goal")
	{
		var_04 = param_00.nearest_node;
		if(isdefined(var_04))
		{
			var_05 = findentrances(self.origin);
			var_05 = common_scripts\utility::array_add(var_05,var_04);
			childthread maps\mp\bots\_bots_util::bot_watch_nodes(var_05);
		}
	}
}