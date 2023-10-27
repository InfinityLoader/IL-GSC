/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\_colors.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: PC
 * Function Count: 72
 * Decompile Time: 1191 ms
 * Timestamp: 10/27/2023 2:19:18 AM
*******************************************************************/

//Function Number: 1
init_color_grouping(param_00)
{
	common_scripts\utility::flag_init("player_looks_away_from_spawner");
	common_scripts\utility::flag_init("friendly_spawner_locked");
	level.arrays_of_colorcoded_nodes = [];
	level.arrays_of_colorcoded_nodes["axis"] = [];
	level.arrays_of_colorcoded_nodes["allies"] = [];
	level.arrays_of_colorcoded_volumes = [];
	level.arrays_of_colorcoded_volumes["axis"] = [];
	level.arrays_of_colorcoded_volumes["allies"] = [];
	var_01 = [];
	var_01 = common_scripts\utility::array_combine(var_01,getentarray("trigger_multiple","code_classname"));
	var_01 = common_scripts\utility::array_combine(var_01,getentarray("trigger_radius","code_classname"));
	var_01 = common_scripts\utility::array_combine(var_01,getentarray("trigger_once","code_classname"));
	level.color_teams = [];
	level.color_teams["allies"] = "allies";
	level.color_teams["axis"] = "axis";
	level.color_teams["team3"] = "axis";
	level.color_teams["neutral"] = "neutral";
	var_02 = getentarray("info_volume","code_classname");
	foreach(var_04 in param_00)
	{
		if(isdefined(var_04.script_color_allies))
		{
			var_04 add_node_to_global_arrays(var_04.script_color_allies,"allies");
		}

		if(isdefined(var_04.script_color_axis))
		{
			var_04 add_node_to_global_arrays(var_04.script_color_axis,"axis");
		}
	}

	foreach(var_07 in var_02)
	{
		if(isdefined(var_07.script_color_allies))
		{
			var_07 add_volume_to_global_arrays(var_07.script_color_allies,"allies");
		}

		if(isdefined(var_07.script_color_axis))
		{
			var_07 add_volume_to_global_arrays(var_07.script_color_axis,"axis");
		}
	}

	foreach(var_0A in var_01)
	{
		if(isdefined(var_0A.script_color_allies))
		{
			var_0A thread trigger_issues_orders(var_0A.script_color_allies,"allies");
		}

		if(isdefined(var_0A.script_color_axis))
		{
			var_0A thread trigger_issues_orders(var_0A.script_color_axis,"axis");
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
	add_path_node("Ambush");
	add_path_node("Guard");
	add_path_node("Path");
	add_path_node("Exposed");
	level.colorlist = [];
	level.colorlist[level.colorlist.size] = "r";
	level.colorlist[level.colorlist.size] = "b";
	level.colorlist[level.colorlist.size] = "y";
	level.colorlist[level.colorlist.size] = "c";
	level.colorlist[level.colorlist.size] = "g";
	level.colorlist[level.colorlist.size] = "p";
	level.colorlist[level.colorlist.size] = "o";
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
	level.currentcolorforced = [];
	level.currentcolorforced["allies"] = [];
	level.currentcolorforced["axis"] = [];
	level.lastcolorforced = [];
	level.lastcolorforced["allies"] = [];
	level.lastcolorforced["axis"] = [];
	foreach(var_0D in level.colorlist)
	{
		level.arrays_of_colorforced_ai["allies"][var_0D] = [];
		level.arrays_of_colorforced_ai["axis"][var_0D] = [];
		level.currentcolorforced["allies"][var_0D] = undefined;
		level.currentcolorforced["axis"][var_0D] = undefined;
	}

	thread player_color_node();
	var_0F = getspawnerteamarray("allies");
	level._color_friendly_spawners = [];
	foreach(var_11 in var_0F)
	{
		level._color_friendly_spawners[var_11.classname] = var_11;
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
		level.arrays_of_colorforced_ai[get_team()][var_01] = maps\_utility::array_add(level.arrays_of_colorforced_ai[get_team()][var_01],self);
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

	var_00 = level.arrays_of_colorcoded_nodes[get_team()][self.currentcolorcode];
	left_color_node();
	if(!isalive(self))
	{
		return;
	}

	if(!maps\_utility::has_color())
	{
		return;
	}

	if(!isdefined(var_00))
	{
		var_01 = level.arrays_of_colorcoded_volumes[get_team()][self.currentcolorcode];
		send_ai_to_colorvolume(var_01,self.currentcolorcode);
		return;
	}

	for(var_02 = 0;var_02 < var_01.size;var_02++)
	{
		var_03 = var_01[var_02];
		if(isalive(var_03.color_user) && !isplayer(var_03.color_user))
		{
			continue;
		}

		thread ai_sets_goal_with_delay(var_03);
		thread decrementcolorusers(var_03);
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
	return var_7B;
}

//Function Number: 7
array_remove_dupes(param_00)
{
	var_01 = [];
	foreach(var_03 in param_00)
	{
		var_01[var_03] = 1;
	}

	var_05 = [];
	foreach(var_08, var_07 in var_01)
	{
		var_05[var_05.size] = var_08;
	}

	return var_05;
}

//Function Number: 8
get_colorcodes_from_trigger(param_00,param_01)
{
	return get_colorcodes(param_00,param_01);
}

//Function Number: 9
get_colorcodes(param_00,param_01)
{
	var_02 = strtok(param_00," ");
	var_02 = array_remove_dupes(var_02);
	var_03 = [];
	var_04 = [];
	var_05 = [];
	var_06 = get_color_list();
	foreach(var_08 in var_02)
	{
		var_09 = undefined;
		foreach(var_09 in var_06)
		{
			if(issubstr(var_08,var_09))
			{
				break;
			}
		}

		if(!colorcode_is_used_in_map(param_01,var_08))
		{
			continue;
		}

		var_04[var_09] = var_08;
		var_03[var_03.size] = var_09;
		var_05[var_05.size] = var_08;
	}

	var_02 = var_05;
	var_0D = [];
	return var_7B;
}

//Function Number: 10
colorcode_is_used_in_map(param_00,param_01)
{
	if(isdefined(level.arrays_of_colorcoded_nodes[param_00][param_01]))
	{
		return 1;
	}

	return isdefined(level.arrays_of_colorcoded_volumes[param_00][param_01]);
}

//Function Number: 11
trigger_issues_orders(param_00,param_01)
{
	var_02 = get_colorcodes_from_trigger(param_00,param_01);
	var_03 = var_02["colorCodes"];
	var_04 = var_02["colorCodesByColorIndex"];
	var_05 = var_02["colors"];
	param_00 = undefined;
	self endon("death");
	for(;;)
	{
		self waittill("trigger");
		if(isdefined(self.activated_color_trigger))
		{
			self.activated_color_trigger = undefined;
			continue;
		}

		activate_color_trigger_internal(var_03,var_05,param_01,var_04);
		if(isdefined(self.script_oneway) && self.script_oneway)
		{
			thread trigger_delete_target_chain();
		}
	}
}

//Function Number: 12
trigger_delete_target_chain()
{
	var_00 = [];
	var_01 = self;
	while(isdefined(var_01))
	{
		var_00[var_00.size] = var_01;
		if(!isdefined(var_01.targetname))
		{
			break;
		}

		var_01 = getent(var_01.targetname,"target");
	}

	maps\_utility::array_delete(var_00);
}

//Function Number: 13
activate_color_trigger(param_00)
{
	if(param_00 == "allies")
	{
		thread get_colorcodes_and_activate_trigger(self.script_color_allies,param_00);
		return;
	}

	thread get_colorcodes_and_activate_trigger(self.script_color_axis,param_00);
}

//Function Number: 14
get_colorcodes_and_activate_trigger(param_00,param_01)
{
	var_02 = get_colorcodes_from_trigger(param_00,param_01);
	var_03 = var_02["colorCodes"];
	var_04 = var_02["colorCodesByColorIndex"];
	var_05 = var_02["colors"];
	activate_color_trigger_internal(var_03,var_05,param_01,var_04);
}

//Function Number: 15
activate_color_trigger_internal(param_00,param_01,param_02,param_03)
{
	return activate_color_code_internal(param_00,param_01,param_02,param_03);
}

//Function Number: 16
activate_color_code_internal(param_00,param_01,param_02,param_03)
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

	foreach(var_07 in param_01)
	{
		level.arrays_of_colorforced_ai[param_02][var_07] = maps\_utility::array_removedead(level.arrays_of_colorforced_ai[param_02][var_07]);
		level.lastcolorforced[param_02][var_07] = level.currentcolorforced[param_02][var_07];
		level.currentcolorforced[param_02][var_07] = param_03[var_07];
	}

	var_0B = [];
	for(var_04 = 0;var_04 < param_00.size;var_04++)
	{
		if(same_color_code_as_last_time(param_02,param_01[var_04]))
		{
			continue;
		}

		var_0C = param_00[var_04];
		if(!isdefined(level.arrays_of_colorcoded_ai[param_02][var_0C]))
		{
			continue;
		}

		var_0B[var_0C] = issue_leave_node_order_to_ai_and_get_ai(var_0C,param_01[var_04],param_02);
	}

	for(var_04 = 0;var_04 < param_00.size;var_04++)
	{
		var_0C = param_00[var_04];
		if(!isdefined(var_0B[var_0C]))
		{
			continue;
		}

		if(same_color_code_as_last_time(param_02,param_01[var_04]))
		{
			continue;
		}

		if(!isdefined(level.arrays_of_colorcoded_ai[param_02][var_0C]))
		{
			continue;
		}

		issue_color_order_to_ai(var_0C,param_01[var_04],param_02,var_0B[var_0C]);
	}
}

//Function Number: 17
same_color_code_as_last_time(param_00,param_01)
{
	if(!isdefined(level.lastcolorforced[param_00][param_01]))
	{
		return 0;
	}

	return level.lastcolorforced[param_00][param_01] == level.currentcolorforced[param_00][param_01];
}

//Function Number: 18
process_cover_node_with_last_in_mind_allies(param_00,param_01)
{
	if(issubstr(param_00.script_color_allies,param_01))
	{
		self.cover_nodes_last[self.cover_nodes_last.size] = param_00;
		return;
	}

	self.cover_nodes_first[self.cover_nodes_first.size] = param_00;
}

//Function Number: 19
process_cover_node_with_last_in_mind_axis(param_00,param_01)
{
	if(issubstr(param_00.script_color_axis,param_01))
	{
		self.cover_nodes_last[self.cover_nodes_last.size] = param_00;
		return;
	}

	self.cover_nodes_first[self.cover_nodes_first.size] = param_00;
}

//Function Number: 20
process_cover_node(param_00,param_01)
{
	self.cover_nodes_first[self.cover_nodes_first.size] = param_00;
}

//Function Number: 21
process_path_node(param_00,param_01)
{
	self.path_nodes[self.path_nodes.size] = param_00;
}

//Function Number: 22
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

	var_04.cover_nodes_first = maps\_utility::array_randomize(var_04.cover_nodes_first);
	var_08 = [];
	var_03 = [];
	foreach(var_0A, var_07 in var_04.cover_nodes_first)
	{
		if(isdefined(var_07.script_colorlast))
		{
			var_08[var_08.size] = var_07;
			var_03[var_0A] = undefined;
			continue;
		}

		var_03[var_03.size] = var_07;
	}

	for(var_06 = 0;var_06 < var_04.cover_nodes_last.size;var_06++)
	{
		var_03[var_03.size] = var_04.cover_nodes_last[var_06];
	}

	for(var_06 = 0;var_06 < var_04.path_nodes.size;var_06++)
	{
		var_03[var_03.size] = var_04.path_nodes[var_06];
	}

	foreach(var_07 in var_08)
	{
		var_03[var_03.size] = var_07;
	}

	level.arrays_of_colorcoded_nodes[param_00][param_01] = var_03;
}

//Function Number: 23
get_prioritized_colorcoded_nodes(param_00,param_01,param_02)
{
	return level.arrays_of_colorcoded_nodes[param_00][param_01];
}

//Function Number: 24
get_colorcoded_volume(param_00,param_01)
{
	return level.arrays_of_colorcoded_volumes[param_00][param_01];
}

//Function Number: 25
issue_leave_node_order_to_ai_and_get_ai(param_00,param_01,param_02)
{
	level.arrays_of_colorcoded_ai[param_02][param_00] = maps\_utility::array_removedead(level.arrays_of_colorcoded_ai[param_02][param_00]);
	var_03 = level.arrays_of_colorcoded_ai[param_02][param_00];
	var_03 = common_scripts\utility::array_combine(var_03,level.arrays_of_colorforced_ai[param_02][param_01]);
	var_04 = [];
	foreach(var_06 in var_03)
	{
		if(isdefined(var_06.currentcolorcode) && var_06.currentcolorcode == param_00)
		{
			continue;
		}

		var_04[var_04.size] = var_06;
	}

	var_03 = var_04;
	if(!var_03.size)
	{
		return;
	}

	common_scripts\utility::array_thread(var_03,::left_color_node);
	return var_03;
}

//Function Number: 26
send_ai_to_colorvolume(param_00,param_01)
{
	self notify("stop_color_move");
	self.currentcolorcode = param_01;
	if(isdefined(param_00.target))
	{
		var_02 = getnode(param_00.target,"targetname");
		if(isdefined(var_02))
		{
			self setgoalnode(var_02);
		}
	}

	self.fixednode = 0;
	self setgoalvolumeauto(param_00);
}

//Function Number: 27
issue_color_order_to_ai(param_00,param_01,param_02,param_03)
{
	var_04 = param_03;
	var_05 = [];
	if(isdefined(level.arrays_of_colorcoded_nodes[param_02][param_00]))
	{
		prioritize_colorcoded_nodes(param_02,param_00,param_01);
		var_05 = get_prioritized_colorcoded_nodes(param_02,param_00,param_01);
	}
	else
	{
		var_06 = get_colorcoded_volume(param_02,param_00);
		common_scripts\utility::array_thread(param_03,::send_ai_to_colorvolume,var_06,param_00);
	}

	var_07 = 0;
	var_08 = param_03.size;
	for(var_09 = 0;var_09 < var_05.size;var_09++)
	{
		var_0A = var_05[var_09];
		if(isalive(var_0A.color_user))
		{
			continue;
		}

		var_0B = maps\_utility::getclosest(var_0A.origin,param_03);
		param_03 = common_scripts\utility::array_remove(param_03,var_0B);
		var_0B take_color_node(var_0A,param_00,self,var_07);
		var_07++;
		if(!param_03.size)
		{
			return;
		}
	}
}

//Function Number: 28
take_color_node(param_00,param_01,param_02,param_03)
{
	self notify("stop_color_move");
	self.currentcolorcode = param_01;
	thread process_color_order_to_ai(param_00,param_02,param_03);
}

//Function Number: 29
player_color_node()
{
	for(;;)
	{
		var_00 = undefined;
		if(!isdefined(level.player.node))
		{
			wait 0.05;
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

			wait 0.05;
		}

		var_00.color_user = undefined;
		var_00 color_node_finds_a_user();
	}
}

//Function Number: 30
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

//Function Number: 31
color_node_finds_user_from_colorcodes(param_00,param_01)
{
	if(isdefined(self.color_user))
	{
		return;
	}

	var_02 = strtok(param_00," ");
	var_02 = array_remove_dupes(var_02);
	common_scripts\utility::array_levelthread(var_02,::color_node_finds_user_for_colorcode,param_01);
}

//Function Number: 32
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

//Function Number: 33
occupies_colorcode(param_00)
{
	if(!isdefined(self.currentcolorcode))
	{
		return 0;
	}

	return self.currentcolorcode == param_00;
}

//Function Number: 34
ai_sets_goal_with_delay(param_00)
{
	self endon("death");
	var_01 = my_current_node_delays();
	if(var_01)
	{
		self endon("stop_color_move");
		wait var_01;
	}

	thread ai_sets_goal(param_00);
}

//Function Number: 35
ai_sets_goal(param_00)
{
	self notify("stop_going_to_node");
	set_goal_and_volume(param_00);
	var_01 = level.arrays_of_colorcoded_volumes[get_team()][self.currentcolorcode];
	if(isdefined(self.script_careful))
	{
		thread careful_logic(param_00,var_01);
	}
}

//Function Number: 36
set_goal_and_volume(param_00)
{
	if(isdefined(self.colornode_func))
	{
		self thread [[ self.colornode_func ]](param_00);
	}

	if(isdefined(self._colors_go_line))
	{
		thread maps\_anim::anim_single_queue(self,self._colors_go_line);
		self._colors_go_line = undefined;
	}

	if(isdefined(self.colornode_setgoal_func))
	{
		self thread [[ self.colornode_setgoal_func ]](param_00);
	}
	else
	{
		self setgoalnode(param_00);
	}

	if(is_using_forcegoal_radius(param_00))
	{
		thread forcegoal_radius(param_00);
	}
	else if(param_00.radius > 0)
	{
		self.goalradius = param_00.radius;
	}

	var_01 = level.arrays_of_colorcoded_volumes[get_team()][self.currentcolorcode];
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

	if(isdefined(level.fixednodesaferadius_default))
	{
		self.fixednodesaferadius = level.fixednodesaferadius_default;
		return;
	}

	self.fixednodesaferadius = 64;
}

//Function Number: 37
is_using_forcegoal_radius(param_00)
{
	if(!isdefined(self.script_forcegoal))
	{
		return 0;
	}

	if(!self.script_forcegoal)
	{
		return 0;
	}

	if(!isdefined(param_00.fixednodesaferadius))
	{
		return 0;
	}

	if(self.fixednode)
	{
		return 0;
	}

	return 1;
}

//Function Number: 38
forcegoal_radius(param_00)
{
	self endon("death");
	self endon("stop_going_to_node");
	self.goalradius = param_00.fixednodesaferadius;
	common_scripts\utility::waittill_either("goal","damage");
	if(param_00.radius > 0)
	{
		self.goalradius = param_00.radius;
	}
}

//Function Number: 39
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

//Function Number: 40
recover_from_careful_disable(param_00)
{
	self endon("death");
	self endon("stop_going_to_node");
	self waittill("stop_being_careful");
	self.fixednode = 1;
	set_goal_and_volume(param_00);
}

//Function Number: 41
use_big_goal_until_goal_is_safe(param_00,param_01)
{
	self setgoalpos(self.origin);
	self.goalradius = 1024;
	self.fixednode = 0;
	if(isdefined(param_01))
	{
		for(;;)
		{
			wait 1;
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

		wait 1;
	}
}

//Function Number: 42
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

//Function Number: 43
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

			wait 1;
		}

		return;
	}

	for(;;)
	{
		if(isknownenemyinradius_tmp(param_00.origin,self.fixednodesaferadius))
		{
			return;
		}

		wait 1;
	}
}

//Function Number: 44
my_current_node_delays()
{
	if(!isdefined(self.node))
	{
		return 0;
	}

	return self.node maps\_utility::script_delay();
}

//Function Number: 45
process_color_order_to_ai(param_00,param_01,param_02)
{
	thread decrementcolorusers(param_00);
	self endon("stop_color_move");
	self endon("death");
	if(isdefined(param_01))
	{
		param_01 maps\_utility::script_delay();
	}

	if(!my_current_node_delays())
	{
		if(isdefined(param_02))
		{
			wait param_02 * randomfloatrange(0.2,0.35);
		}
	}

	ai_sets_goal(param_00);
	self.color_ordered_node_assignment = param_00;
	for(;;)
	{
		self waittill("node_taken",var_03);
		if(isplayer(var_03))
		{
			wait 0.05;
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

//Function Number: 46
get_best_available_colored_node()
{
	var_00 = level.currentcolorforced[get_team()][self.script_forcecolor];
	var_01 = get_prioritized_colorcoded_nodes(get_team(),var_00,self.script_forcecolor);
	for(var_02 = 0;var_02 < var_01.size;var_02++)
	{
		if(!isalive(var_01[var_02].color_user))
		{
			return var_01[var_02];
		}
	}
}

//Function Number: 47
get_best_available_new_colored_node()
{
	var_00 = level.currentcolorforced[get_team()][self.script_forcecolor];
	var_01 = get_prioritized_colorcoded_nodes(get_team(),var_00,self.script_forcecolor);
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

//Function Number: 48
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

//Function Number: 49
wait_for_killanimscript_or_time(param_00)
{
	self endon("killanimscript");
	wait param_00;
}

//Function Number: 50
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
		wait 1;
		self notify("eject_from_my_node");
		return 1;
	}

	return 0;
}

//Function Number: 51
decrementcolorusers(param_00)
{
	param_00.color_user = self;
	self.color_node = param_00;
	self endon("stop_color_move");
	self waittill("death");
	self.color_node.color_user = undefined;
}

//Function Number: 52
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

//Function Number: 53
add_volume_to_global_arrays(param_00,param_01)
{
	var_02 = strtok(param_00," ");
	var_02 = array_remove_dupes(var_02);
	foreach(var_04 in var_02)
	{
		level.arrays_of_colorcoded_volumes[param_01][var_04] = self;
		level.arrays_of_colorcoded_ai[param_01][var_04] = [];
		level.arrays_of_colorcoded_spawners[param_01][var_04] = [];
	}
}

//Function Number: 54
add_node_to_global_arrays(param_00,param_01)
{
	self.color_user = undefined;
	var_02 = strtok(param_00," ");
	var_02 = array_remove_dupes(var_02);
	foreach(var_04 in var_02)
	{
		if(isdefined(level.arrays_of_colorcoded_nodes[param_01]) && isdefined(level.arrays_of_colorcoded_nodes[param_01][var_04]))
		{
			level.arrays_of_colorcoded_nodes[param_01][var_04] = maps\_utility::array_add(level.arrays_of_colorcoded_nodes[param_01][var_04],self);
			continue;
		}

		level.arrays_of_colorcoded_nodes[param_01][var_04][0] = self;
		level.arrays_of_colorcoded_ai[param_01][var_04] = [];
		level.arrays_of_colorcoded_spawners[param_01][var_04] = [];
	}
}

//Function Number: 55
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

//Function Number: 56
getcolornumberarray()
{
	var_00 = [];
	if(issubstr(self.classname,"axis") || issubstr(self.classname,"enemy") || issubstr(self.classname,"team3"))
	{
	}

	if(issubstr(self.classname,"ally") || self.type == "civilian")
	{
	}

	if(!isdefined(var_7B["colorTeam"]))
	{
		var_7B = undefined;
	}

	return var_7B;
}

//Function Number: 57
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
	var_03 = array_remove_dupes(var_03);
	for(var_04 = 0;var_04 < var_03.size;var_04++)
	{
		level.arrays_of_colorcoded_spawners[var_01][var_03[var_04]] = common_scripts\utility::array_remove(level.arrays_of_colorcoded_spawners[var_01][var_03[var_04]],self);
	}
}

//Function Number: 58
add_cover_node(param_00)
{
	level.color_node_type_function[param_00][1]["allies"] = ::process_cover_node_with_last_in_mind_allies;
	level.color_node_type_function[param_00][1]["axis"] = ::process_cover_node_with_last_in_mind_axis;
	level.color_node_type_function[param_00][0]["allies"] = ::process_cover_node;
	level.color_node_type_function[param_00][0]["axis"] = ::process_cover_node;
}

//Function Number: 59
add_path_node(param_00)
{
	level.color_node_type_function[param_00][1]["allies"] = ::process_path_node;
	level.color_node_type_function[param_00][0]["allies"] = ::process_path_node;
	level.color_node_type_function[param_00][1]["axis"] = ::process_path_node;
	level.color_node_type_function[param_00][0]["axis"] = ::process_path_node;
}

//Function Number: 60
colornode_spawn_reinforcement(param_00,param_01)
{
	level endon("kill_color_replacements");
	level endon("kill_hidden_reinforcement_waiting");
	var_02 = spawn_hidden_reinforcement(param_00,param_01);
	if(isdefined(level.friendly_startup_thread))
	{
		var_02 thread [[ level.friendly_startup_thread ]]();
	}

	var_02 thread colornode_replace_on_death();
}

//Function Number: 61
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
		if(!isdefined(level.color_doesnt_care_about_heroes))
		{
			var_04 = maps\_utility::remove_heroes_from_array(var_04);
		}

		if(!isdefined(level.color_doesnt_care_about_classname))
		{
			var_04 = maps\_utility::remove_without_classname(var_04,var_00);
		}

		if(!var_04.size)
		{
			wait 2;
			continue;
		}

		var_05 = maps\_utility::getclosest(level.player.origin,var_04);
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

//Function Number: 62
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

//Function Number: 63
friendly_spawner_vision_checker()
{
	level.friendly_respawn_vision_checker_thread = 1;
	var_00 = 0;
	for(;;)
	{
		for(;;)
		{
			if(!respawn_friendlies_without_vision_check())
			{
				break;
			}

			wait 0.05;
		}

		wait 1;
		if(!isdefined(level.respawn_spawner_org))
		{
			continue;
		}

		var_01 = level.player.origin - level.respawn_spawner_org;
		if(length(var_01) < 200)
		{
			player_sees_spawner();
			continue;
		}

		var_02 = anglestoforward((0,level.player getplayerangles()[1],0));
		var_03 = vectornormalize(var_01);
		var_04 = vectordot(var_02,var_03);
		if(var_04 < 0.2)
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

//Function Number: 64
get_color_spawner(param_00)
{
	if(isdefined(param_00))
	{
		if(!isdefined(level._color_friendly_spawners[param_00]))
		{
			var_01 = getspawnerteamarray("allies");
			foreach(var_03 in var_01)
			{
				if(var_03.classname != param_00)
				{
					continue;
				}

				level._color_friendly_spawners[param_00] = var_03;
				break;
			}
		}
	}

	if(!isdefined(param_00))
	{
		var_03 = common_scripts\utility::random(level._color_friendly_spawners);
		if(!isdefined(var_03))
		{
			var_01 = [];
			foreach(var_06, var_03 in level._color_friendly_spawners)
			{
				if(isdefined(var_03))
				{
					var_01[var_06] = var_03;
				}
			}

			level._color_friendly_spawners = var_01;
			return common_scripts\utility::random(level._color_friendly_spawners);
		}

		return var_06;
	}

	return level._color_friendly_spawners[var_06];
}

//Function Number: 65
respawn_friendlies_without_vision_check()
{
	if(isdefined(level.respawn_friendlies_force_vision_check))
	{
		return 0;
	}

	return common_scripts\utility::flag("respawn_friendlies");
}

//Function Number: 66
wait_until_vision_check_satisfied_or_disabled()
{
	if(common_scripts\utility::flag("player_looks_away_from_spawner"))
	{
		return;
	}

	level endon("player_looks_away_from_spawner");
	for(;;)
	{
		if(respawn_friendlies_without_vision_check())
		{
			return;
		}

		wait 0.05;
	}
}

//Function Number: 67
spawn_hidden_reinforcement(param_00,param_01)
{
	level endon("kill_color_replacements");
	level endon("kill_hidden_reinforcement_waiting");
	var_02 = undefined;
	for(;;)
	{
		if(!respawn_friendlies_without_vision_check())
		{
			if(!isdefined(level.friendly_respawn_vision_checker_thread))
			{
				thread friendly_spawner_vision_checker();
			}

			for(;;)
			{
				wait_until_vision_check_satisfied_or_disabled();
				common_scripts\utility::flag_waitopen("friendly_spawner_locked");
				if(common_scripts\utility::flag("player_looks_away_from_spawner") || respawn_friendlies_without_vision_check())
				{
					break;
				}
			}

			common_scripts\utility::flag_set("friendly_spawner_locked");
		}

		var_03 = get_color_spawner(param_00);
		var_03.count = 1;
		var_04 = var_03.origin;
		var_03.origin = level.respawn_spawner_org;
		var_02 = var_03 stalingradspawn();
		var_03.origin = var_04;
		if(maps\_utility::spawn_failed(var_02))
		{
			thread lock_spawner_for_awhile();
			wait 1;
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

	thread lock_spawner_for_awhile();
	return var_02;
}

//Function Number: 68
lock_spawner_for_awhile()
{
	common_scripts\utility::flag_set("friendly_spawner_locked");
	if(isdefined(level.friendly_respawn_lock_func))
	{
		[[ level.friendly_respawn_lock_func ]]();
	}
	else
	{
		wait 2;
	}

	common_scripts\utility::flag_clear("friendly_spawner_locked");
}

//Function Number: 69
player_sees_spawner()
{
	var_00 = 0;
	common_scripts\utility::flag_clear("player_looks_away_from_spawner");
}

//Function Number: 70
kill_color_replacements()
{
	common_scripts\utility::flag_clear("friendly_spawner_locked");
	level notify("kill_color_replacements");
	var_00 = getaiarray();
	common_scripts\utility::array_thread(var_00,::remove_replace_on_death);
}

//Function Number: 71
remove_replace_on_death()
{
	self.replace_on_death = undefined;
}

//Function Number: 72
get_team(param_00)
{
	if(isdefined(self.team) && !isdefined(param_00))
	{
		param_00 = self.team;
	}

	return level.color_teams[param_00];
}