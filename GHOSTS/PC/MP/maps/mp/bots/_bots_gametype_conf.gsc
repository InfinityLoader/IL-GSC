/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\bots\_bots_gametype_conf.gsc
 * Game: Call of Duty: Ghosts
 * Platform: PC
 * Function Count: 16
 * Decompile Time: 311 ms
 * Timestamp: 10/27/2023 1:17:11 AM
*******************************************************************/

//Function Number: 1
func_4FDD()
{
	func_710C();
	setup_bot_conf();
}

//Function Number: 2
func_710C()
{
	level.bot_funcs["gametype_think"] = ::func_8FDE;
}

//Function Number: 3
setup_bot_conf()
{
	level.bot_tag_obj_radius = 200;
	level.bot_tag_allowable_jump_height = 38;
}

//Function Number: 4
func_8FDE()
{
	self notify("bot_conf_think");
	self endon("bot_conf_think");
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	self.next_time_check_tags = gettime() + 500;
	self.tags_seen = [];
	childthread func_9016();
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
			if(maps/mp/bots/_bots_util::func_16C0(self.tag_getting.curorigin,var_02))
			{
				if(self botpursuingscriptgoal())
				{
					var_01 = 1;
				}
			}
			else if(maps/mp/bots/_bots_strategy::bot_has_tactical_goal("kill_tag") && self.tag_getting maps\mp\gametypes\_gameobjects::func_19CA(self.team))
			{
				self.tag_getting = undefined;
				var_00 = 0;
			}
		}

		self botsetflag("force_sprint",var_01);
		self.tags_seen = func_9008(self.tags_seen);
		var_03 = func_8FE9(self.tags_seen,1);
		var_04 = isdefined(var_03);
		if((var_00 && !var_04) || !var_00 && var_04 || var_00 && var_04 && self.tag_getting != var_03)
		{
			self.tag_getting = var_03;
			self botclearscriptgoal();
			self notify("stop_camping_tag");
			maps/mp/bots/_bots_personality::func_1D01();
			maps/mp/bots/_bots_strategy::bot_abort_tactical_goal("kill_tag");
		}

		if(isdefined(self.tag_getting))
		{
			self.conf_camping_tag = 0;
			if(self.personality == "camper" && self.conf_camper_camp_tags)
			{
				self.conf_camping_tag = 1;
				if(maps/mp/bots/_bots_personality::func_748C())
				{
					if(maps/mp/bots/_bots_personality::func_325A(self.tag_getting.curorigin,1000))
					{
						childthread func_8FD6(self.tag_getting,"camp");
					}
					else
					{
						self.conf_camping_tag = 0;
					}
				}
			}

			if(!self.conf_camping_tag)
			{
				if(!maps/mp/bots/_bots_strategy::bot_has_tactical_goal("kill_tag"))
				{
					var_05 = spawnstruct();
					var_05.script_goal_type = "objective";
					var_05.objective_radius = level.bot_tag_obj_radius;
					maps/mp/bots/_bots_strategy::bot_new_tactical_goal("kill_tag",self.tag_getting.curorigin,25,var_05);
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
			var_07 = func_8FEB(1);
			self.tags_seen = func_8FDD(var_07,self.tags_seen);
		}

		wait(0.05);
	}
}

//Function Number: 5
func_8FDA(param_00)
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
						thread func_8FFC();
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
func_8FFC()
{
	self endon("death");
	self endon("disconnect");
	self botsetstance("stand");
	wait(1);
	self botpressbutton("jump");
	wait(1);
	self botsetstance("none");
}

//Function Number: 7
func_9016()
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
					thread func_9046(var_00);
					func_9588(var_00);
					if(var_00.on_path_grid)
					{
						var_01 = spawnstruct();
						var_01.origin = var_00.curorigin;
						var_01.tag = var_00;
						var_02[0] = var_01;
						self.tags_seen = func_8FDD(var_02,self.tags_seen);
					}
				}
			}
		}
	}
}

//Function Number: 8
func_8FDD(param_00,param_01)
{
	var_02 = param_01;
	foreach(var_04 in param_00)
	{
		var_05 = 0;
		foreach(var_07 in param_01)
		{
			if(var_04.tag == var_07.tag && maps/mp/bots/_bots_util::func_16C0(var_04.origin,var_07.origin))
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
func_8FFA(param_00,param_01,param_02)
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
			var_06 = common_scripts\utility::func_8E18(self.origin,self.angles,param_00.curorigin,param_02);
			if(var_06)
			{
				if(var_04)
				{
					thread func_9046(param_00);
					func_9588(param_00);
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
func_8FEB(param_00,param_01,param_02)
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
			if(var_07 maps\mp\gametypes\_gameobjects::func_19CA(self.team))
			{
				var_08 = 0;
				if(!param_00)
				{
					if(!isdefined(var_07.calculations_in_progress))
					{
						if(!isdefined(var_07.on_path_grid))
						{
							level thread func_9046(var_07);
							func_9588(var_07);
						}

						var_08 = distancesquared(self.origin,var_07.curorigin) < 1000000 && var_07.on_path_grid;
					}
				}
				else if(func_8FFA(var_07,var_03,var_04))
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
func_9046(param_00)
{
	param_00 endon("reset");
	param_00.calculations_in_progress = 1;
	param_00.on_path_grid = maps/mp/bots/_bots_util::bot_point_is_on_pathgrid(param_00.curorigin,undefined,level.bot_tag_allowable_jump_height + 55);
	param_00.calculations_in_progress = undefined;
}

//Function Number: 12
func_9588(param_00)
{
	while(!isdefined(param_00.on_path_grid))
	{
		wait(0.05);
	}
}

//Function Number: 13
func_8FE9(param_00,param_01)
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
				var_07 = distancesquared(var_05.tag.curorigin,self.origin);
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
func_9008(param_00)
{
	var_01 = [];
	foreach(var_03 in param_00)
	{
		if(var_03.tag maps\mp\gametypes\_gameobjects::func_19CA(self.team) && maps/mp/bots/_bots_util::func_16C0(var_03.tag.curorigin,var_03.origin))
		{
			if(!func_8FDA(var_03.tag) && var_03.tag.on_path_grid)
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
func_8FD6(param_00,param_01,param_02)
{
	self notify("bot_camp_tag");
	self endon("bot_camp_tag");
	self endon("stop_camping_tag");
	if(isdefined(param_02))
	{
		self endon(param_02);
	}

	self botsetscriptgoalnode(self.node_ambushing_from,param_01,self.ambush_yaw);
	var_03 = maps/mp/bots/_bots_util::bot_waittill_goal_or_fail();
	if(var_03 == "goal")
	{
		var_04 = param_00.nearest_node;
		if(isdefined(var_04))
		{
			var_05 = findentrances(self.origin);
			var_05 = common_scripts\utility::array_add(var_05,var_04);
			childthread maps/mp/bots/_bots_util::bot_watch_nodes(var_05);
		}
	}
}