/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\_colors.gsc
 * Game: Call of Duty: Modern Warfare Remastered
 * Platform: PC
 * Function Count: 67
 * Decompile Time: 1307 ms
 * Timestamp: 10/27/2023 2:47:24 AM
*******************************************************************/

//Function Number: 1
init_color_grouping(param_00)
{
	common_scripts\utility::flag_init("player_looks_away_from_spawner");
	common_scripts\utility::flag_init("friendly_spawner_locked");
	level.arrays_of_colorcoded_nodes = [];
	level.arrays_of_colorcoded_nodes["axis"] = [];
	level.arrays_of_colorcoded_nodes["allies"] = [];
	level.colorcoded_volumes = [];
	level.colorcoded_volumes["axis"] = [];
	level.colorcoded_volumes["allies"] = [];
	var_01 = [];
	var_01 = common_scripts\utility::array_combine(var_01,getentarray("trigger_multiple","classname"));
	var_01 = common_scripts\utility::array_combine(var_01,getentarray("trigger_radius","classname"));
	var_01 = common_scripts\utility::array_combine(var_01,getentarray("trigger_once","classname"));
	var_02 = getentarray("info_volume","classname");
	for(var_03 = 0;var_03 < param_00.size;var_03++)
	{
		if(isdefined(param_00[var_03].script_color_allies))
		{
			param_00[var_03] add_node_to_global_arrays(param_00[var_03].script_color_allies,"allies");
		}

		if(isdefined(param_00[var_03].script_color_axis))
		{
			param_00[var_03] add_node_to_global_arrays(param_00[var_03].script_color_axis,"axis");
		}
	}

	for(var_03 = 0;var_03 < var_01.size;var_03++)
	{
		if(isdefined(var_01[var_03].script_color_allies))
		{
			var_01[var_03] thread trigger_issues_orders(var_01[var_03].script_color_allies,"allies");
		}

		if(isdefined(var_01[var_03].script_color_axis))
		{
			var_01[var_03] thread trigger_issues_orders(var_01[var_03].script_color_axis,"axis");
		}
	}

	for(var_03 = 0;var_03 < var_02.size;var_03++)
	{
		if(isdefined(var_02[var_03].script_color_allies))
		{
			var_02[var_03] add_volume_to_global_arrays(var_02[var_03].script_color_allies,"allies");
		}

		if(isdefined(var_02[var_03].script_color_axis))
		{
			var_02[var_03] add_volume_to_global_arrays(var_02[var_03].script_color_allies,"axis");
		}
	}

	level.color_node_type_function = [];
	add_cover_node("BAD NODE");
	add_cover_node("Cover Stand");
	add_cover_node("Cover Crouch");
	add_cover_node("Cover Prone");
	add_cover_node("Cover Crouch Window");
	add_cover_node("Cover Right");
	add_cover_node("Cover Left");
	add_cover_node("Cover Wide Left");
	add_cover_node("Cover Wide Right");
	add_cover_node("Conceal Stand");
	add_cover_node("Conceal Crouch");
	add_cover_node("Conceal Prone");
	add_cover_node("Reacquire");
	add_cover_node("Balcony");
	add_cover_node("Scripted");
	add_cover_node("Begin");
	add_cover_node("End");
	add_cover_node("Turret");
	add_path_node("Guard");
	add_path_node("Path");
	level.colorlist = [];
	level.colorlist[level.colorlist.size] = "r";
	level.colorlist[level.colorlist.size] = "b";
	level.colorlist[level.colorlist.size] = "y";
	level.colorlist[level.colorlist.size] = "c";
	level.colorlist[level.colorlist.size] = "g";
	level.colorlist[level.colorlist.size] = "p";
	level.colorlist[level.colorlist.size] = "o";
	level.colorlist[level.colorlist.size] = "w";
	level.colorlist[level.colorlist.size] = "a";
	level.colorlist[level.colorlist.size] = "l";
	level.colorchecklist["red"] = "r";
	level.colorchecklist["r"] = "r";
	level.colorchecklist["blue"] = "b";
	level.colorchecklist["b"] = "b";
	level.colorchecklist["yellow"] = "y";
	level.colorchecklist["y"] = "y";
	level.colorchecklist["cyan"] = "c";
	level.colorchecklist["c"] = "c";
	level.colorchecklist["green"] = "g";
	level.colorchecklist["g"] = "g";
	level.colorchecklist["purple"] = "p";
	level.colorchecklist["p"] = "p";
	level.colorchecklist["orange"] = "o";
	level.colorchecklist["o"] = "o";
	level.colorchecklist["white"] = "w";
	level.colorchecklist["w"] = "w";
	level.colorchecklist["aqua"] = "a";
	level.colorchecklist["a"] = "a";
	level.colorchecklist["lime"] = "l";
	level.colorchecklist["l"] = "l";
	level.currentcolorforced = [];
	level.currentcolorforced["allies"] = [];
	level.currentcolorforced["axis"] = [];
	level.lastcolorforced = [];
	level.lastcolorforced["allies"] = [];
	level.lastcolorforced["axis"] = [];
	for(var_03 = 0;var_03 < level.colorlist.size;var_03++)
	{
		level.arrays_of_colorforced_ai["allies"][level.colorlist[var_03]] = [];
		level.arrays_of_colorforced_ai["axis"][level.colorlist[var_03]] = [];
		level.currentcolorforced["allies"][level.colorlist[var_03]] = undefined;
		level.currentcolorforced["axis"][level.colorlist[var_03]] = undefined;
	}

	thread player_color_node();
	if(getdvar("shownodecolors") == "1")
	{
		thread shownodecolors();
	}
}

//Function Number: 2
convert_color_to_short_string()
{
	self.script_forcecolor = level.colorchecklist[self.script_forcecolor];
}

//Function Number: 3
ai_picks_destination(param_00)
{
	if(isdefined(self.script_forcecolor))
	{
		convert_color_to_short_string();
		self.currentcolorcode = param_00;
		var_01 = self.script_forcecolor;
		level.arrays_of_colorforced_ai[self.team][var_01] = common_scripts\utility::array_add(level.arrays_of_colorforced_ai[self.team][var_01],self);
		thread goto_current_colorindex();
	}
}

//Function Number: 4
goto_current_colorindex()
{
	if(!isdefined(self.currentcolorcode))
	{
		return;
	}

	var_00 = level.arrays_of_colorcoded_nodes[self.team][self.currentcolorcode];
	left_color_node();
	if(!isalive(self))
	{
		return;
	}

	if(!maps\_utility::has_color())
	{
		return;
	}

	for(var_01 = 0;var_01 < var_00.size;var_01++)
	{
		var_02 = var_00[var_01];
		if(isalive(var_02.color_user) && var_02.color_user != level.player)
		{
			continue;
		}

		thread ai_sets_goal_with_delay(var_02);
		thread decrementcolorusers(var_02);
		return;
	}

	no_node_to_go_to();
}

//Function Number: 5
no_node_to_go_to()
{
}

//Function Number: 6
get_color_list()
{
	var_00 = [];
	var_00[var_00.size] = "r";
	var_00[var_00.size] = "b";
	var_00[var_00.size] = "y";
	var_00[var_00.size] = "c";
	var_00[var_00.size] = "g";
	var_00[var_00.size] = "p";
	var_00[var_00.size] = "o";
	var_00[var_00.size] = "w";
	var_00[var_00.size] = "a";
	var_00[var_00.size] = "l";
	return var_00;
}

//Function Number: 7
get_colorcodes_from_trigger(param_00,param_01)
{
	var_02 = strtok(param_00," ");
	var_03 = [];
	var_04 = [];
	var_05 = [];
	var_06 = get_color_list();
	for(var_07 = 0;var_07 < var_02.size;var_07++)
	{
		var_08 = undefined;
		for(var_09 = 0;var_09 < var_06.size;var_09++)
		{
			if(issubstr(var_02[var_07],var_06[var_09]))
			{
				var_08 = var_06[var_09];
				break;
			}
		}

		if(!isdefined(level.arrays_of_colorcoded_nodes[param_01][var_02[var_07]]))
		{
			continue;
		}

		var_04[var_08] = var_02[var_07];
		var_03[var_03.size] = var_08;
		var_05[var_05.size] = var_02[var_07];
	}

	var_02 = var_05;
	var_0A = [];
	var_0A["colorCodes"] = var_02;
	var_0A["colorCodesByColorIndex"] = var_04;
	var_0A["colors"] = var_03;
	return var_0A;
}

//Function Number: 8
trigger_issues_orders(param_00,param_01)
{
	var_02 = get_colorcodes_from_trigger(param_00,param_01);
	var_03 = var_02["colorCodes"];
	var_04 = var_02["colorCodesByColorIndex"];
	var_05 = var_02["colors"];
	for(;;)
	{
		self waittill("trigger");
		if(isdefined(self.activated_color_trigger))
		{
			self.activated_color_trigger = undefined;
			continue;
		}

		activate_color_trigger_internal(var_03,var_05,param_01,var_04);
	}
}

//Function Number: 9
activate_color_trigger(param_00)
{
	if(param_00 == "allies")
	{
		thread get_colorcodes_and_activate_trigger(self.script_color_allies,param_00);
		return;
	}

	thread get_colorcodes_and_activate_trigger(self.script_color_axis,param_00);
}

//Function Number: 10
get_colorcodes_and_activate_trigger(param_00,param_01)
{
	var_02 = get_colorcodes_from_trigger(param_00,param_01);
	var_03 = var_02["colorCodes"];
	var_04 = var_02["colorCodesByColorIndex"];
	var_05 = var_02["colors"];
	activate_color_trigger_internal(var_03,var_05,param_01,var_04);
}

//Function Number: 11
activate_color_trigger_internal(param_00,param_01,param_02,param_03)
{
	for(var_04 = 0;var_04 < param_00.size;var_04++)
	{
		if(!isdefined(level.arrays_of_colorcoded_spawners[param_02][param_00[var_04]]))
		{
			continue;
		}

		level.arrays_of_colorcoded_spawners[param_02][param_00[var_04]] = common_scripts\utility::array_removeundefined(level.arrays_of_colorcoded_spawners[param_02][param_00[var_04]]);
		for(var_05 = 0;var_05 < level.arrays_of_colorcoded_spawners[param_02][param_00[var_04]].size;var_05++)
		{
			level.arrays_of_colorcoded_spawners[param_02][param_00[var_04]][var_05].currentcolorcode = param_00[var_04];
		}
	}

	for(var_04 = 0;var_04 < param_01.size;var_04++)
	{
		level.arrays_of_colorforced_ai[param_02][param_01[var_04]] = maps\_utility::array_removedead(level.arrays_of_colorforced_ai[param_02][param_01[var_04]]);
		level.lastcolorforced[param_02][param_01[var_04]] = level.currentcolorforced[param_02][param_01[var_04]];
		level.currentcolorforced[param_02][param_01[var_04]] = param_03[param_01[var_04]];
	}

	var_06 = [];
	for(var_04 = 0;var_04 < param_00.size;var_04++)
	{
		if(same_color_code_as_last_time(param_02,param_01[var_04]))
		{
			continue;
		}

		var_07 = param_00[var_04];
		if(!isdefined(level.arrays_of_colorcoded_ai[param_02][var_07]))
		{
			continue;
		}

		var_06[var_07] = issue_leave_node_order_to_ai_and_get_ai(var_07,param_01[var_04],param_02);
	}

	for(var_04 = 0;var_04 < param_00.size;var_04++)
	{
		var_07 = param_00[var_04];
		if(!isdefined(var_06[var_07]))
		{
			continue;
		}

		if(same_color_code_as_last_time(param_02,param_01[var_04]))
		{
			continue;
		}

		if(!isdefined(level.arrays_of_colorcoded_ai[param_02][var_07]))
		{
			continue;
		}

		issue_color_order_to_ai(var_07,param_01[var_04],param_02,var_06[var_07]);
	}
}

//Function Number: 12
same_color_code_as_last_time(param_00,param_01)
{
	if(!isdefined(level.lastcolorforced[param_00][param_01]))
	{
		return 0;
	}

	return level.lastcolorforced[param_00][param_01] == level.currentcolorforced[param_00][param_01];
}

//Function Number: 13
process_cover_node_with_last_in_mind_allies(param_00,param_01)
{
	if(issubstr(param_00.script_color_allies,param_01))
	{
		self.cover_nodes_last[self.cover_nodes_last.size] = param_00;
		return;
	}

	self.cover_nodes_first[self.cover_nodes_first.size] = param_00;
}

//Function Number: 14
process_cover_node_with_last_in_mind_axis(param_00,param_01)
{
	if(issubstr(param_00.script_color_axis,param_01))
	{
		self.cover_nodes_last[self.cover_nodes_last.size] = param_00;
		return;
	}

	self.cover_nodes_first[self.cover_nodes_first.size] = param_00;
}

//Function Number: 15
process_cover_node(param_00,param_01)
{
	self.cover_nodes_first[self.cover_nodes_first.size] = param_00;
}

//Function Number: 16
process_path_node(param_00,param_01)
{
	self.path_nodes[self.path_nodes.size] = param_00;
}

//Function Number: 17
prioritize_colorcoded_nodes(param_00,param_01,param_02)
{
	var_03 = level.arrays_of_colorcoded_nodes[param_00][param_01];
	var_04 = spawnstruct();
	var_04.path_nodes = [];
	var_04.cover_nodes_first = [];
	var_04.cover_nodes_last = [];
	var_05 = isdefined(level.lastcolorforced[param_00][param_02]);
	for(var_06 = 0;var_06 < var_03.size;var_06++)
	{
		var_07 = var_03[var_06];
		var_04 [[ level.color_node_type_function[var_07.type][var_05][param_00] ]](var_07,level.lastcolorforced[param_00][param_02]);
	}

	var_04.cover_nodes_first = common_scripts\utility::array_randomize(var_04.cover_nodes_first);
	var_03 = var_04.cover_nodes_first;
	for(var_06 = 0;var_06 < var_04.cover_nodes_last.size;var_06++)
	{
		var_03[var_03.size] = var_04.cover_nodes_last[var_06];
	}

	for(var_06 = 0;var_06 < var_04.path_nodes.size;var_06++)
	{
		var_03[var_03.size] = var_04.path_nodes[var_06];
	}

	level.arrays_of_colorcoded_nodes[param_00][param_01] = var_03;
}

//Function Number: 18
get_prioritized_colorcoded_nodes(param_00,param_01,param_02)
{
	return level.arrays_of_colorcoded_nodes[param_00][param_01];
}

//Function Number: 19
issue_leave_node_order_to_ai_and_get_ai(param_00,param_01,param_02)
{
	level.arrays_of_colorcoded_ai[param_02][param_00] = maps\_utility::array_removedead(level.arrays_of_colorcoded_ai[param_02][param_00]);
	var_03 = level.arrays_of_colorcoded_ai[param_02][param_00];
	var_03 = common_scripts\utility::array_combine(var_03,level.arrays_of_colorforced_ai[param_02][param_01]);
	var_04 = [];
	for(var_05 = 0;var_05 < var_03.size;var_05++)
	{
		if(isdefined(var_03[var_05].currentcolorcode) && var_03[var_05].currentcolorcode == param_00)
		{
			continue;
		}

		var_04[var_04.size] = var_03[var_05];
	}

	var_03 = var_04;
	if(!var_03.size)
	{
		return;
	}

	for(var_05 = 0;var_05 < var_03.size;var_05++)
	{
		var_03[var_05] left_color_node();
	}

	return var_03;
}

//Function Number: 20
issue_color_order_to_ai(param_00,param_01,param_02,param_03)
{
	if(!param_03.size)
	{
		return;
	}

	var_04 = param_03;
	prioritize_colorcoded_nodes(param_02,param_00,param_01);
	var_05 = get_prioritized_colorcoded_nodes(param_02,param_00,param_01);
	if(!var_05.size)
	{
		return;
	}

	var_06 = maps\_utility::getdvarintdefault("ai_color_squadAssignmentOverride",0);
	var_07 = var_06 > 0;
	if(var_06 == 0)
	{
		var_08 = param_03[0] should_assign_nodes_intelligently_for_squad();
		foreach(var_0A in param_03)
		{
			var_0B = var_0A should_assign_nodes_intelligently_for_squad();
			if(var_0B)
			{
				var_07 = 1;
			}
		}

		var_0D = var_05[0] should_assign_nodes_intelligently_for_squad();
		foreach(var_0F in var_05)
		{
			var_10 = var_0F should_assign_nodes_intelligently_for_squad();
			if(var_10)
			{
				var_07 = 1;
			}
		}
	}

	var_12 = 0;
	var_13 = param_03.size;
	if(var_07)
	{
		var_12 = 1;
		var_14 = (0,0,0);
		foreach(var_0F in var_05)
		{
			var_14 = var_14 + var_0F.origin;
		}

		var_14 = var_14 / var_05.size;
		var_17 = (0,0,0);
		foreach(var_0A in param_03)
		{
			var_17 = var_17 + var_0A.origin;
		}

		var_17 = var_17 / param_03.size;
		param_03 = sortbydistance(param_03,var_14);
		var_05 = sortbydistance(var_05,var_17);
	}

	for(var_1A = 0;var_1A < var_05.size;var_1A++)
	{
		var_0F = var_05[var_1A];
		if(isalive(var_0F.color_user))
		{
			continue;
		}

		var_1B = undefined;
		var_1C = var_12;
		if(var_07)
		{
			var_1B = param_03[param_03.size - 1];
			var_1C = var_13 - var_12;
		}
		else
		{
			var_1B = common_scripts\utility::getclosest(var_0F.origin,param_03);
		}

		param_03 = common_scripts\utility::array_remove(param_03,var_1B);
		var_1B take_color_node(var_0F,param_00,self,var_1C);
		var_12++;
		if(!param_03.size)
		{
			return;
		}
	}
}

//Function Number: 21
take_color_node(param_00,param_01,param_02,param_03)
{
	self notify("stop_color_move");
	self.currentcolorcode = param_01;
	thread process_color_order_to_ai(param_00,param_02,param_03);
}

//Function Number: 22
assign_nodes_intelligently_for_squad(param_00)
{
	if(param_00)
	{
		self.script_color_assign_intelligently = 1;
		return;
	}

	self.script_color_assign_intelligently = undefined;
}

//Function Number: 23
assign_nodes_intelligently_for_team(param_00,param_01)
{
	if(!isdefined(level.team_assign_nodes_intelligently))
	{
		level.team_assign_nodes_intelligently = [];
	}

	level.team_assign_nodes_intelligently[param_00] = param_01;
	var_02 = getaiarray(param_00);
	for(var_03 = 0;var_03 < var_02.size;var_03++)
	{
		var_02[var_03].script_color_assign_intelligently = param_01;
	}
}

//Function Number: 24
setup_nodes_intelligently_from_team()
{
	if(!isdefined(level.team_assign_nodes_intelligently))
	{
		return;
	}

	if(!isdefined(level.team_assign_nodes_intelligently[self.team]))
	{
		return;
	}

	self.script_color_assign_intelligently = level.team_assign_nodes_intelligently[self.team];
}

//Function Number: 25
should_assign_nodes_intelligently_for_squad()
{
	return isdefined(self.script_color_assign_intelligently) && self.script_color_assign_intelligently;
}

//Function Number: 26
player_color_node()
{
	for(;;)
	{
		var_00 = undefined;
		if(!isdefined(level.player.node))
		{
			wait(0.05);
			continue;
		}

		var_01 = level.player.node.color_user;
		var_00 = level.player.node;
		var_00.color_user = level.player;
		for(;;)
		{
			if(!isdefined(level.player.node))
			{
				break;
			}

			if(level.player.node != var_00)
			{
				break;
			}

			wait(0.05);
		}

		var_00.color_user = undefined;
		var_00 color_node_finds_a_user();
	}
}

//Function Number: 27
color_node_finds_a_user()
{
	if(isdefined(self.script_color_allies))
	{
		color_node_finds_user_from_colorcodes(self.script_color_allies,"allies");
	}

	if(isdefined(self.script_color_axis))
	{
		color_node_finds_user_from_colorcodes(self.script_color_axis,"axis");
	}
}

//Function Number: 28
color_node_finds_user_from_colorcodes(param_00,param_01)
{
	if(isdefined(self.color_user))
	{
		return;
	}

	var_02 = strtok(param_00," ");
	common_scripts\utility::array_levelthread(var_02,::color_node_finds_user_for_colorcode,param_01);
}

//Function Number: 29
color_node_finds_user_for_colorcode(param_00,param_01)
{
	var_02 = param_00[0];
	if(!isdefined(level.currentcolorforced[param_01][var_02]))
	{
		return;
	}

	if(level.currentcolorforced[param_01][var_02] != param_00)
	{
		return;
	}

	var_03 = maps\_utility::get_force_color_guys(param_01,var_02);
	if(!var_03.size)
	{
		return;
	}

	for(var_04 = 0;var_04 < var_03.size;var_04++)
	{
		var_05 = var_03[var_04];
		if(var_05 occupies_colorcode(param_00))
		{
			continue;
		}

		var_05 take_color_node(self,param_00);
		return;
	}
}

//Function Number: 30
occupies_colorcode(param_00)
{
	if(!isdefined(self.currentcolorcode))
	{
		return 0;
	}

	return self.currentcolorcode == param_00;
}

//Function Number: 31
ai_sets_goal_with_delay(param_00)
{
	self endon("death");
	var_01 = my_current_node_delays();
	if(var_01)
	{
		self endon("stop_color_move");
		wait(var_01);
	}

	thread ai_sets_goal(param_00);
}

//Function Number: 32
ai_sets_goal(param_00)
{
	self notify("stop_going_to_node");
	set_goal_and_volume(param_00);
	var_01 = level.colorcoded_volumes[self.team][self.currentcolorcode];
	if(isdefined(self.script_careful))
	{
		thread careful_logic(param_00,var_01);
	}
}

//Function Number: 33
set_goal_and_volume(param_00)
{
	if(isdefined(self._colors_go_line))
	{
		thread maps\_anim::anim_single_queue(self,self._colors_go_line);
		self._colors_go_line = undefined;
	}

	self getgoalvolume(param_00);
	if(!self.fixednode)
	{
		self.goalradius = param_00.radius;
	}
	else if(isdefined(param_00.radius))
	{
		self.goalradius = param_00.radius;
	}

	var_01 = level.colorcoded_volumes[self.team][self.currentcolorcode];
	if(isdefined(var_01))
	{
		self setfixednodesafevolume(var_01);
	}
	else
	{
		self clearfixednodesafevolume();
	}

	if(isdefined(param_00.fixednodesaferadius))
	{
		self.fixednodesaferadius = param_00.fixednodesaferadius;
		return;
	}

	self.fixednodesaferadius = 64;
}

//Function Number: 34
careful_logic(param_00,param_01)
{
	self endon("death");
	self endon("stop_being_careful");
	self endon("stop_going_to_node");
	thread recover_from_careful_disable(param_00);
	for(;;)
	{
		wait_until_an_enemy_is_in_safe_area(param_00,param_01);
		use_big_goal_until_goal_is_safe(param_00,param_01);
		self.fixednode = 1;
		set_goal_and_volume(param_00);
	}
}

//Function Number: 35
recover_from_careful_disable(param_00)
{
	self endon("death");
	self endon("stop_going_to_node");
	self waittill("stop_being_careful");
	self.fixednode = 1;
	set_goal_and_volume(param_00);
}

//Function Number: 36
use_big_goal_until_goal_is_safe(param_00,param_01)
{
	self setgoalpos(self.origin);
	self.goalradius = 1024;
	self.fixednode = 0;
	if(isdefined(param_01))
	{
		for(;;)
		{
			wait(1);
			if(self isknownenemyinradius(param_00.origin,self.fixednodesaferadius))
			{
				continue;
			}

			if(self isknownenemyinvolume(param_01))
			{
				continue;
			}

			return;
		}

		return;
	}

	for(;;)
	{
		if(!isknownenemyinradius_tmp(param_00.origin,self.fixednodesaferadius))
		{
			return;
		}

		wait(1);
	}
}

//Function Number: 37
isknownenemyinradius_tmp(param_00,param_01)
{
	var_02 = getaiarray("axis");
	for(var_03 = 0;var_03 < var_02.size;var_03++)
	{
		if(distance2d(var_02[var_03].origin,param_00) < param_01)
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 38
wait_until_an_enemy_is_in_safe_area(param_00,param_01)
{
	if(isdefined(param_01))
	{
		for(;;)
		{
			if(self isknownenemyinradius(param_00.origin,self.fixednodesaferadius))
			{
				return;
			}

			if(self isknownenemyinvolume(param_01))
			{
				return;
			}

			wait(1);
		}

		return;
	}

	for(;;)
	{
		if(isknownenemyinradius_tmp(param_00.origin,self.fixednodesaferadius))
		{
			return;
		}

		wait(1);
	}
}

//Function Number: 39
my_current_node_delays()
{
	if(!isdefined(self.node))
	{
		return 0;
	}

	return self.node maps\_utility::script_delay();
}

//Function Number: 40
process_color_order_to_ai(param_00,param_01,param_02)
{
	thread decrementcolorusers(param_00);
	self endon("stop_color_move");
	self endon("death");
	if(isdefined(param_01))
	{
		param_01 maps\_utility::script_delay();
		if(isdefined(param_01.colordelayinfo))
		{
			var_03 = getarraykeys(param_01.colordelayinfo);
			if(common_scripts\utility::array_contains(var_03,self.script_forcecolor))
			{
				wait(param_01.colordelayinfo[self.script_forcecolor]);
			}
		}
	}

	if(!my_current_node_delays())
	{
		if(isdefined(param_02))
		{
			wait(param_02 * randomfloatrange(0.2,0.35));
		}
	}

	ai_sets_goal(param_00);
	self.color_ordered_node_assignment = param_00;
	for(;;)
	{
		self waittill("node_taken",var_04);
		if(var_04 == level.player)
		{
			wait(0.05);
		}

		param_00 = get_best_available_new_colored_node();
		if(isdefined(param_00))
		{
			if(isalive(self.color_node.color_user) && self.color_node.color_user == self)
			{
				self.color_node.color_user = undefined;
			}

			self.color_node = param_00;
			param_00.color_user = self;
			ai_sets_goal(param_00);
		}
	}
}

//Function Number: 41
get_best_available_colored_node()
{
	var_00 = level.currentcolorforced[self.team][self.script_forcecolor];
	var_01 = get_prioritized_colorcoded_nodes(self.team,var_00,self.script_forcecolor);
	for(var_02 = 0;var_02 < var_01.size;var_02++)
	{
		if(!isalive(var_01[var_02].color_user))
		{
			return var_01[var_02];
		}
	}
}

//Function Number: 42
get_best_available_new_colored_node()
{
	var_00 = level.currentcolorforced[self.team][self.script_forcecolor];
	var_01 = get_prioritized_colorcoded_nodes(self.team,var_00,self.script_forcecolor);
	for(var_02 = 0;var_02 < var_01.size;var_02++)
	{
		if(var_01[var_02] == self.color_node)
		{
			continue;
		}

		if(!isalive(var_01[var_02].color_user))
		{
			return var_01[var_02];
		}
	}
}

//Function Number: 43
process_stop_short_of_node(param_00)
{
	self endon("stopScript");
	self endon("death");
	if(isdefined(self.node))
	{
		return;
	}

	if(distance(param_00.origin,self.origin) < 32)
	{
		reached_node_but_could_not_claim_it(param_00);
		return;
	}

	var_01 = gettime();
	wait_for_killanimscript_or_time(1);
	var_02 = gettime();
	if(var_02 - var_01 >= 1000)
	{
		reached_node_but_could_not_claim_it(param_00);
	}
}

//Function Number: 44
wait_for_killanimscript_or_time(param_00)
{
	self endon("killanimscript");
	wait(param_00);
}

//Function Number: 45
reached_node_but_could_not_claim_it(param_00)
{
	var_01 = getaiarray();
	var_02 = undefined;
	for(var_03 = 0;var_03 < var_01.size;var_03++)
	{
		if(!isdefined(var_01[var_03].node))
		{
			continue;
		}

		if(var_01[var_03].node != param_00)
		{
			continue;
		}

		var_01[var_03] notify("eject_from_my_node");
		wait(1);
		self notify("eject_from_my_node");
		return 1;
	}

	return 0;
}

//Function Number: 46
decrementcolorusers(param_00)
{
	param_00.color_user = self;
	self.color_node = param_00;
	self endon("stop_color_move");
	self waittill("death");
	self.color_node.color_user = undefined;
}

//Function Number: 47
colorislegit(param_00)
{
	for(var_01 = 0;var_01 < level.colorlist.size;var_01++)
	{
		if(param_00 == level.colorlist[var_01])
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 48
add_volume_to_global_arrays(param_00,param_01)
{
	var_02 = strtok(param_00," ");
	for(var_03 = 0;var_03 < var_02.size;var_03++)
	{
		level.colorcoded_volumes[param_01][var_02[var_03]] = self;
	}
}

//Function Number: 49
add_node_to_global_arrays(param_00,param_01)
{
	self.color_user = undefined;
	var_02 = strtok(param_00," ");
	for(var_03 = 0;var_03 < var_02.size;var_03++)
	{
		if(isdefined(level.arrays_of_colorcoded_nodes[param_01]) && isdefined(level.arrays_of_colorcoded_nodes[param_01][var_02[var_03]]))
		{
			level.arrays_of_colorcoded_nodes[param_01][var_02[var_03]] = common_scripts\utility::array_add(level.arrays_of_colorcoded_nodes[param_01][var_02[var_03]],self);
			continue;
		}

		level.arrays_of_colorcoded_nodes[param_01][var_02[var_03]][0] = self;
		level.arrays_of_colorcoded_ai[param_01][var_02[var_03]] = [];
		level.arrays_of_colorcoded_spawners[param_01][var_02[var_03]] = [];
	}
}

//Function Number: 50
shownodecolors()
{
	common_scripts\utility::array_thread(getallnodes(),::nodethink);
}

//Function Number: 51
nodethink()
{
	var_00 = "";
	var_01 = "gg-";
	if(isdefined(self.script_color_allies))
	{
		var_00 = self.script_color_allies;
	}
	else if(isdefined(self.script_color_axis))
	{
		var_00 = self.script_color_axis;
		var_01 = "bg-";
	}

	if(var_00 == "")
	{
		return;
	}

	for(;;)
	{
		var_02 = maps\_utility::get_script_palette();
		var_03 = strtok(var_00," ");
		if(var_03.size > 1)
		{
		}
		else
		{
		}

		if(randomint(100) > 70)
		{
		}

		wait 0.05;
	}
}

//Function Number: 52
left_color_node()
{
	if(!isdefined(self.color_node))
	{
		return;
	}

	if(isdefined(self.color_node.color_user) && self.color_node.color_user == self)
	{
		self.color_node.color_user = undefined;
	}

	self.color_node = undefined;
	self notify("stop_color_move");
}

//Function Number: 53
getcolornumberarray()
{
	var_00 = [];
	if(issubstr(self.classname,"axis") || issubstr(self.classname,"enemy"))
	{
		var_00["team"] = "axis";
		var_00["colorTeam"] = self.script_color_axis;
	}

	if(issubstr(self.classname,"ally") || issubstr(self.classname,"civilian"))
	{
		var_00["team"] = "allies";
		var_00["colorTeam"] = self.script_color_allies;
	}

	if(!isdefined(var_00["colorTeam"]))
	{
		var_00 = undefined;
	}

	return var_00;
}

//Function Number: 54
removespawnerfromcolornumberarray()
{
	var_00 = getcolornumberarray();
	if(!isdefined(var_00))
	{
		return;
	}

	var_01 = var_00["team"];
	var_02 = var_00["colorTeam"];
	var_03 = strtok(var_02," ");
	for(var_04 = 0;var_04 < var_03.size;var_04++)
	{
		level.arrays_of_colorcoded_spawners[var_01][var_03[var_04]] = common_scripts\utility::array_remove(level.arrays_of_colorcoded_spawners[var_01][var_03[var_04]],self);
	}
}

//Function Number: 55
add_cover_node(param_00)
{
	level.color_node_type_function[param_00][1]["allies"] = ::process_cover_node_with_last_in_mind_allies;
	level.color_node_type_function[param_00][1]["axis"] = ::process_cover_node_with_last_in_mind_axis;
	level.color_node_type_function[param_00][0]["allies"] = ::process_cover_node;
	level.color_node_type_function[param_00][0]["axis"] = ::process_cover_node;
}

//Function Number: 56
add_path_node(param_00)
{
	level.color_node_type_function[param_00][1]["allies"] = ::process_path_node;
	level.color_node_type_function[param_00][0]["allies"] = ::process_path_node;
	level.color_node_type_function[param_00][1]["axis"] = ::process_path_node;
	level.color_node_type_function[param_00][0]["axis"] = ::process_path_node;
}

//Function Number: 57
colornode_spawn_reinforcement(param_00,param_01)
{
	level endon("kill_color_replacements");
	var_02 = spawn_hidden_reinforcement(param_00,param_01);
	if(isdefined(level.friendly_startup_thread))
	{
		var_02 thread [[ level.friendly_startup_thread ]]();
	}

	var_02 thread colornode_replace_on_death();
}

//Function Number: 58
colornode_replace_on_death()
{
	level endon("kill_color_replacements");
	self endon("_disable_reinforcement");
	if(isdefined(self.replace_on_death))
	{
		return;
	}

	self.replace_on_death = 1;
	var_00 = self.classname;
	var_01 = self.script_forcecolor;
	waittillframeend;
	if(isalive(self))
	{
		self waittill("death");
	}

	var_02 = level.current_color_order;
	if(!isdefined(self.script_forcecolor))
	{
		return;
	}

	thread colornode_spawn_reinforcement(var_00,self.script_forcecolor);
	if(isdefined(self) && isdefined(self.script_forcecolor))
	{
		var_01 = self.script_forcecolor;
	}

	if(isdefined(self) && isdefined(self.origin))
	{
		var_03 = self.origin;
	}

	for(;;)
	{
		if(get_color_from_order(var_01,var_02) == "none")
		{
			return;
		}

		var_04 = maps\_utility::get_force_color_guys("allies",var_02[var_01]);
		var_04 = maps\_utility::remove_heroes_from_array(var_04);
		var_04 = maps\_utility::remove_without_classname(var_04,var_00);
		if(!var_04.size)
		{
			wait(2);
			continue;
		}

		var_05 = common_scripts\utility::getclosest(level.player.origin,var_04);
		waittillframeend;
		if(!isalive(var_05))
		{
			continue;
		}

		var_05 maps\_utility::set_force_color(var_01);
		if(isdefined(level.friendly_promotion_thread))
		{
			var_05 [[ level.friendly_promotion_thread ]](var_01);
		}

		var_01 = var_02[var_01];
	}
}

//Function Number: 59
get_color_from_order(param_00,param_01)
{
	if(!isdefined(param_00))
	{
		return "none";
	}

	if(!isdefined(param_01))
	{
		return "none";
	}

	if(!isdefined(param_01[param_00]))
	{
		return "none";
	}

	return param_01[param_00];
}

//Function Number: 60
friendly_spawner_vision_checker()
{
	level.friendly_respawn_vision_checker_thread = 1;
	var_00 = 0;
	for(;;)
	{
		common_scripts\utility::flag_waitopen("respawn_friendlies");
		wait(1);
		if(!isdefined(level.respawn_spawner))
		{
			continue;
		}

		var_01 = level.respawn_spawner;
		var_02 = level.player.origin - var_01.origin;
		if(length(var_02) < 200)
		{
			player_sees_spawner();
			continue;
		}

		var_03 = anglestoforward((0,level.player getplayerangles()[1],0));
		var_04 = vectornormalize(var_02);
		var_05 = vectordot(var_03,var_04);
		if(var_05 < 0.2)
		{
			player_sees_spawner();
			continue;
		}

		var_00++;
		if(var_00 < 3)
		{
			continue;
		}

		common_scripts\utility::flag_set("player_looks_away_from_spawner");
	}
}

//Function Number: 61
get_color_spawner(param_00)
{
	if(!isdefined(param_00))
	{
		return level.respawn_spawner;
	}

	var_01 = getentarray("color_spawner","targetname");
	var_02 = [];
	for(var_03 = 0;var_03 < var_01.size;var_03++)
	{
		var_02[var_01[var_03].classname] = var_01[var_03];
	}

	var_04 = undefined;
	var_05 = getarraykeys(var_02);
	for(var_03 = 0;var_03 < var_05.size;var_03++)
	{
		if(!issubstr(var_02[var_05[var_03]].classname,param_00))
		{
			continue;
		}

		var_04 = var_02[var_05[var_03]];
		break;
	}

	if(!isdefined(var_04))
	{
		return level.respawn_spawner;
	}

	var_04.origin = level.respawn_spawner.origin;
	return var_04;
}

//Function Number: 62
spawn_hidden_reinforcement(param_00,param_01)
{
	level endon("kill_color_replacements");
	var_02 = undefined;
	for(;;)
	{
		if(!common_scripts\utility::flag("respawn_friendlies"))
		{
			if(!isdefined(level.friendly_respawn_vision_checker_thread))
			{
				thread friendly_spawner_vision_checker();
			}

			for(;;)
			{
				common_scripts\utility::flag_wait_either("player_looks_away_from_spawner","respawn_friendlies");
				common_scripts\utility::flag_waitopen("friendly_spawner_locked");
				if(common_scripts\utility::flag("player_looks_away_from_spawner") || common_scripts\utility::flag("respawn_friendlies"))
				{
					break;
				}
			}

			common_scripts\utility::flag_set("friendly_spawner_locked");
		}

		var_03 = get_color_spawner(param_00);
		var_03.count = 1;
		var_02 = var_03 stalingradspawn();
		if(maps\_utility::spawn_failed(var_02))
		{
			thread lock_spawner_for_awhile();
			wait(1);
			continue;
		}

		level notify("reinforcement_spawned",var_02);
		break;
	}

	for(;;)
	{
		if(!isdefined(param_01))
		{
			break;
		}

		if(get_color_from_order(param_01,level.current_color_order) == "none")
		{
			break;
		}

		param_01 = level.current_color_order[param_01];
	}

	if(isdefined(param_01))
	{
		var_02 maps\_utility::set_force_color(param_01);
	}

	var_02 setup_nodes_intelligently_from_team();
	thread lock_spawner_for_awhile();
	return var_02;
}

//Function Number: 63
lock_spawner_for_awhile()
{
	common_scripts\utility::flag_set("friendly_spawner_locked");
	wait(2);
	common_scripts\utility::flag_clear("friendly_spawner_locked");
}

//Function Number: 64
player_sees_spawner()
{
	var_00 = 0;
	common_scripts\utility::flag_clear("player_looks_away_from_spawner");
}

//Function Number: 65
kill_color_replacements()
{
	common_scripts\utility::flag_clear("friendly_spawner_locked");
	level notify("kill_color_replacements");
	var_00 = getaiarray();
	common_scripts\utility::array_thread(var_00,::remove_replace_on_death);
}

//Function Number: 66
remove_replace_on_death()
{
	self.replace_on_death = undefined;
}

//Function Number: 67
init_color_delay_info(param_00)
{
	if(!isdefined(param_00.script_parameters))
	{
		return;
	}

	if(!issubstr(param_00.script_parameters,"color_delays"))
	{
		return;
	}

	var_01 = strtok(param_00.script_parameters,":, ");
	var_02 = [];
	for(var_03 = 0;var_03 < var_01.size;var_03++)
	{
		if(var_01[var_03] == "color_delays")
		{
			continue;
		}

		if(!isdefined(var_01[var_03 + 1]))
		{
			return;
		}

		var_02[var_01[var_03]] = float(var_01[var_03 + 1]);
		var_03++;
	}

	param_00.colordelayinfo = var_02;
}