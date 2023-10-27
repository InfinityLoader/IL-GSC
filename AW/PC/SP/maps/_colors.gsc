/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps/_colors.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 73
 * Decompile Time: 1133 ms
 * Timestamp: 10/27/2023 1:58:26 AM
*******************************************************************/

//Function Number: 1
init_color_grouping(param_00)
{
	level.colorlist = [];
	level.colorlist[level.colorlist.size] = "r";
	level.colorlist[level.colorlist.size] = "b";
	level.colorlist[level.colorlist.size] = "y";
	level.colorlist[level.colorlist.size] = "c";
	level.colorlist[level.colorlist.size] = "g";
	level.colorlist[level.colorlist.size] = "p";
	level.colorlist[level.colorlist.size] = "o";
	level.arrays_of_colorcoded_nodes = [];
	level.arrays_of_colorcoded_nodes["axis"] = [];
	level.arrays_of_colorcoded_nodes["allies"] = [];
	level.arrays_of_colorcoded_volumes = [];
	level.arrays_of_colorcoded_volumes["axis"] = [];
	level.arrays_of_colorcoded_volumes["allies"] = [];
	level.color_teams = [];
	level.color_teams["allies"] = "allies";
	level.color_teams["axis"] = "axis";
	level.color_teams["team3"] = "axis";
	level.color_teams["neutral"] = "neutral";
	var_01 = [];
	var_01 = common_scripts\utility::array_combine(var_01,getentarray("trigger_multiple","code_classname"));
	var_01 = common_scripts\utility::array_combine(var_01,getentarray("trigger_radius","code_classname"));
	var_01 = common_scripts\utility::array_combine(var_01,getentarray("trigger_once","code_classname"));
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
	add_cover_node("Cover Multi");
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
	add_path_node("Scripted");
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

	if(isdefined(level.colors_player_can_take_nodes))
	{
		thread player_color_node();
	}

	common_scripts\utility::flag_init("respawn_friendlies");
	common_scripts\utility::flag_init("respawn_enemies");
	common_scripts\utility::flag_init("friendly_spawner_locked");
	common_scripts\utility::flag_init("enemy_spawner_locked");
	common_scripts\utility::flag_init("player_looks_away_from_friendly_spawner");
	common_scripts\utility::flag_init("player_looks_away_from_enemy_spawner");
	level.respawn_friendlies_force_vision_check = 1;
	level.respawn_enemies_force_vision_check = 1;
	level.respawn_spawner_org = [];
	level.arrays_color_spawners = [];
	level.arrays_color_spawners["allies"] = [];
	level.arrays_color_spawners["axis"] = [];
	var_0F = getspawnerteamarray("allies");
	var_10 = getspawnerteamarray("team3");
	var_10 = common_scripts\utility::array_combine(getspawnerteamarray("axis"),var_10);
	foreach(var_12 in var_0F)
	{
		if(isdefined(var_12.script_noteworthy) && var_12.script_noteworthy == "color_spawner")
		{
			var_12 add_spawner_to_global_arrays("allies");
		}

		if(isdefined(var_12.script_parameters) && var_12.script_parameters == "color_replace")
		{
			var_12 thread add_replace_after_load_done();
		}
	}

	foreach(var_12 in var_10)
	{
		if(isdefined(var_12.script_noteworthy) && var_12.script_noteworthy == "color_spawner")
		{
			var_12 add_spawner_to_global_arrays("axis");
		}

		if(isdefined(var_12.script_parameters) && var_12.script_parameters == "color_replace")
		{
			var_12 thread add_replace_after_load_done();
		}
	}
}

//Function Number: 2
add_node_to_global_arrays(param_00,param_01)
{
	self.color_user = undefined;
	var_02 = strtok(param_00," ");
	var_02 = common_scripts\utility::array_remove_duplicates(var_02);
	foreach(var_04 in var_02)
	{
		if(isdefined(level.arrays_of_colorcoded_nodes[param_01]) && isdefined(level.arrays_of_colorcoded_nodes[param_01][var_04]))
		{
			level.arrays_of_colorcoded_nodes[param_01][var_04] = common_scripts\utility::array_add(level.arrays_of_colorcoded_nodes[param_01][var_04],self);
			continue;
		}

		level.arrays_of_colorcoded_nodes[param_01][var_04][0] = self;
	}
}

//Function Number: 3
add_volume_to_global_arrays(param_00,param_01)
{
	var_02 = strtok(param_00," ");
	var_02 = common_scripts\utility::array_remove_duplicates(var_02);
	foreach(var_04 in var_02)
	{
		level.arrays_of_colorcoded_volumes[param_01][var_04] = self;
	}
}

//Function Number: 4
add_cover_node(param_00)
{
	level.color_node_type_function[param_00][1]["allies"] = ::process_cover_node_with_last_in_mind_allies;
	level.color_node_type_function[param_00][1]["axis"] = ::process_cover_node_with_last_in_mind_axis;
	level.color_node_type_function[param_00][0]["allies"] = ::process_cover_node;
	level.color_node_type_function[param_00][0]["axis"] = ::process_cover_node;
}

//Function Number: 5
add_path_node(param_00)
{
	level.color_node_type_function[param_00][1]["allies"] = ::process_path_node;
	level.color_node_type_function[param_00][1]["axis"] = ::process_path_node;
	level.color_node_type_function[param_00][0]["allies"] = ::process_path_node;
	level.color_node_type_function[param_00][0]["axis"] = ::process_path_node;
}

//Function Number: 6
add_spawner_to_global_arrays(param_00)
{
	if(!isdefined(level.arrays_color_spawners[param_00][self.classname]))
	{
		level.arrays_color_spawners[param_00][self.classname] = [];
	}

	level.arrays_color_spawners[param_00][self.classname] = common_scripts\utility::array_add(level.arrays_color_spawners[param_00][self.classname],self);
}

//Function Number: 7
add_replace_after_load_done()
{
	self endon("death");
	level waittill("load_finished");
	maps\_utility::add_spawn_function(::colornode_replace_on_death);
}

//Function Number: 8
trigger_issues_orders(param_00,param_01)
{
	var_02 = get_colorcodes(param_00,param_01);
	var_03 = var_02["colorCodes"];
	var_04 = var_02["colorCodesByColorIndex"];
	var_05 = var_02["colors"];
	self endon("death");
	for(;;)
	{
		self waittill("trigger");
		activate_color_code_internal(var_03,var_05,param_01,var_04);
		if(isdefined(self.script_oneway) && self.script_oneway)
		{
			thread trigger_delete_target_chain();
		}
	}
}

//Function Number: 9
activate_color_code_internal(param_00,param_01,param_02,param_03)
{
	var_04 = [];
	foreach(var_06 in param_01)
	{
		var_07 = param_03[var_06];
		if(same_color_code_as_last_time(param_02,var_06,var_07))
		{
			continue;
		}

		level.arrays_of_colorforced_ai[param_02][var_06] = maps\_utility::array_removedead(level.arrays_of_colorforced_ai[param_02][var_06]);
		var_04[var_06] = issue_leave_node_order_to_ai_and_get_ai(var_07,var_06,param_02);
	}

	foreach(var_06 in param_01)
	{
		var_07 = param_03[var_06];
		if(same_color_code_as_last_time(param_02,var_06,var_07))
		{
			continue;
		}

		level.lastcolorforced[param_02][var_06] = level.currentcolorforced[param_02][var_06];
		level.currentcolorforced[param_02][var_06] = var_07;
		if(!isdefined(var_04[var_06]))
		{
			continue;
		}

		issue_color_order_to_ai(var_07,var_06,param_02,var_04[var_06]);
	}
}

//Function Number: 10
same_color_code_as_last_time(param_00,param_01,param_02)
{
	if(!isdefined(level.currentcolorforced[param_00][param_01]))
	{
		return 0;
	}

	return param_02 == level.currentcolorforced[param_00][param_01];
}

//Function Number: 11
issue_leave_node_order_to_ai_and_get_ai(param_00,param_01,param_02)
{
	var_03 = [];
	var_04 = level.arrays_of_colorforced_ai[param_02][param_01];
	foreach(var_06 in var_04)
	{
		if(isdefined(var_06.currentcolorcode) && var_06.currentcolorcode == param_00)
		{
			continue;
		}

		if(isdefined(var_06.force_color_driven_anim))
		{
			continue;
		}

		var_03[var_03.size] = var_06;
	}

	if(!var_03.size)
	{
		return;
	}

	common_scripts\utility::array_thread(var_03,::left_color_node);
	return var_03;
}

//Function Number: 12
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
}

//Function Number: 13
issue_color_order_to_ai(param_00,param_01,param_02,param_03)
{
	var_04 = [];
	if(isdefined(level.arrays_of_colorcoded_nodes[param_02][param_00]))
	{
		prioritize_colorcoded_nodes(param_02,param_00,param_01);
		var_04 = get_colorcoded_nodes(param_02,param_00);
	}
	else
	{
		var_05 = get_colorcoded_volume(param_02,param_00);
		common_scripts\utility::array_thread(param_03,::send_ai_to_colorvolume,var_05,param_00);
		return;
	}

	var_06 = 0;
	var_07 = undefined;
	while(var_04.size > 0)
	{
		var_05 = remove_nodes_with_users_from_array(var_05);
		var_08 = get_best_ai_match_for_highest_priority_node(var_05,var_04);
		if(!isdefined(var_08))
		{
			break;
		}

		var_04 = common_scripts\utility::array_remove(var_04,var_08["guy"]);
		var_07 = var_08["node"];
		var_05 = common_scripts\utility::array_remove(var_05,var_08["node"]);
		var_08["guy"] take_color_node(var_08["node"],param_01,self,var_06);
		var_06++;
	}

	if(isdefined(level.colors_player_can_take_nodes) && isdefined(var_07))
	{
		return;
	}

	if(isdefined(var_07))
	{
		return;
	}
}

//Function Number: 14
remove_nodes_with_users_from_array(param_00)
{
	for(var_01 = param_00.size - 1;var_01 >= 0;var_01--)
	{
		if(isdefined(param_00[var_01].color_user) && isalive(param_00[var_01].color_user))
		{
			param_00 = common_scripts\utility::array_remove(param_00,param_00[var_01]);
		}
	}

	return param_00;
}

//Function Number: 15
get_best_ai_match_for_highest_priority_node(param_00,param_01)
{
	var_02 = undefined;
	var_03 = undefined;
	var_04 = 999999999;
	if(!isdefined(param_00) || param_00.size <= 0)
	{
		return undefined;
	}

	var_05 = param_00[0].color_priority;
	for(var_06 = 0;var_06 < param_00.size;var_06++)
	{
		var_07 = param_00[var_06];
		if(var_07.color_priority > var_05)
		{
			break;
		}

		var_08 = common_scripts\utility::getclosest(var_07.origin,param_01);
		var_09 = distance(var_08.origin,var_07.origin);
		if(var_09 < var_04)
		{
			var_02 = var_07;
			var_03 = var_08;
			var_04 = var_09;
		}
	}

	if(isdefined(var_02))
	{
		var_0A = [];
		var_0A["guy"] = var_03;
		var_0A["node"] = var_02;
		return var_0A;
	}

	return undefined;
}

//Function Number: 16
take_color_node(param_00,param_01,param_02,param_03)
{
	self notify("stop_color_move");
	self notify("color_code_move_update",param_00);
	self.currentcolorcode = param_01;
	thread process_color_order_to_ai(param_00,param_02,param_03);
}

//Function Number: 17
process_color_order_to_ai(param_00,param_01,param_02)
{
	thread take_color_node_until_death(param_00);
	self endon("stop_color_move");
	self endon("death");
	if(isdefined(param_01) && issubstr(param_01.classname,"trigger"))
	{
		param_01 maps\_utility::script_delay();
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
		self waittill("node_taken",var_03);
		if(isplayer(var_03))
		{
			if(!isdefined(level.colors_player_can_take_nodes))
			{
				continue;
			}

			wait(0.05);
		}

		if(!isalive(var_03))
		{
			continue;
		}

		if(var_03 != self.color_node.color_user)
		{
			self.color_node.color_user = undefined;
		}

		self.color_node = undefined;
		param_00 = get_best_available_new_colored_node();
		if(isdefined(param_00))
		{
			if(isdefined(self.color_node))
			{
				if(isalive(self.color_node.color_user) && self.color_node.color_user == self)
				{
					self.color_node.color_user = undefined;
				}
			}

			self.color_node = param_00;
			param_00.color_user = self;
			ai_sets_goal(param_00);
			continue;
		}
	}
}

//Function Number: 18
ai_sets_goal(param_00)
{
	self notify("stop_going_to_node");
	self.fixednode = 1;
	set_color_goal_node(param_00);
	if(isdefined(self.script_careful) && self.script_careful == 1)
	{
		var_01 = level.arrays_of_colorcoded_volumes[get_team()][self.currentcolorcode];
		if(isdefined(var_01))
		{
			self setfixednodesafevolume(var_01);
		}
		else
		{
			self clearfixednodesafevolume();
		}

		thread careful_logic(param_00,var_01);
		return;
	}

	self clearfixednodesafevolume();
}

//Function Number: 19
set_color_goal_node(param_00)
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
	else if(param_00.type == "Scripted")
	{
		thread color_node_anim_at_node(param_00);
		return;
	}
	else
	{
		self setgoalnode(param_00);
		thread color_node_arrival_notifies(param_00);
	}

	if(isdefined(param_00.fixednodesaferadius))
	{
		self.fixednodesaferadius = param_00.fixednodesaferadius;
	}
	else if(isdefined(level.fixednodesaferadius_default))
	{
		self.fixednodesaferadius = level.fixednodesaferadius_default;
	}
	else
	{
		self.fixednodesaferadius = 64;
	}

	if(isdefined(param_00.radius) && param_00.radius > 0)
	{
		self.goalradius = param_00.radius;
	}
}

//Function Number: 20
color_node_anim_at_node(param_00)
{
	self endon("death");
	self endon("start_being_careful");
	self endon("stop_color_move");
	self.fixednode = 0;
	self.goalradius = level.default_goalradius;
	thread color_node_arrival_notifies(param_00);
	if(isdefined(param_00.script_forcegoal))
	{
		self.force_color_driven_anim = 1;
	}

	self.perforing_color_driven_anim = 1;
	param_00 maps\_anim::anim_reach_solo(self,param_00.script_animation);
	thread color_node_anim_at_node_animate(param_00);
}

//Function Number: 21
color_node_anim_at_node_animate(param_00)
{
	self endon("death");
	param_00 maps\_anim::anim_single_solo(self,param_00.script_animation);
	self.perforing_color_driven_anim = undefined;
	self.force_color_driven_anim = undefined;
	if(self.currentcolorcode != level.currentcolorforced[get_team()][self.script_forcecolor])
	{
		self.currentcolorcode = level.currentcolorforced[get_team()][self.script_forcecolor];
		thread goto_current_colorindex();
	}
}

//Function Number: 22
color_node_arrival_notifies(param_00)
{
	self endon("stop_color_move");
	for(;;)
	{
		self waittill("goal");
		if(!isdefined(self.being_careful) || !self.being_careful)
		{
			if(isdefined(param_00.script_flag_set))
			{
				common_scripts\utility::flag_set(param_00.script_flag_set);
			}

			if(isdefined(param_00.script_ent_flag_set))
			{
				maps\_utility::ent_flag_set(param_00.script_ent_flag_set);
			}

			if(isdefined(param_00.script_flag_clear))
			{
				common_scripts\utility::flag_clear(param_00.script_flag_clear);
			}

			if(isdefined(param_00.script_noteworthy))
			{
				self notify(param_00.script_noteworthy);
			}

			return;
		}
	}
}

//Function Number: 23
take_color_node_until_death(param_00)
{
	self endon("stop_color_move");
	param_00.color_user = self;
	self.color_node = param_00;
	self waittill("death");
	self.color_node.color_user = undefined;
}

//Function Number: 24
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

//Function Number: 25
clear_color_order_from_team(param_00,param_01)
{
	var_02 = undefined;
	foreach(var_02 in level.colorlist)
	{
		if(issubstr(param_00,var_02))
		{
			break;
		}

		var_02 = undefined;
	}

	level.currentcolorforced[param_01][var_02] = undefined;
	level.lastcolorforced[param_01][var_02] = undefined;
	var_05 = level.arrays_of_colorforced_ai[param_01][var_02];
	foreach(var_07 in var_05)
	{
		var_07.currentcolorcode = undefined;
	}
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
		if(!isdefined(var_01.perforing_color_driven_anim))
		{
			if(isdefined(var_01))
			{
				var_01 notify("node_taken",level.player);
			}

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
			continue;
		}

		wait(0.05);
	}
}

//Function Number: 27
careful_logic(param_00,param_01)
{
	self endon("death");
	self endon("stop_being_careful");
	self endon("stop_going_to_node");
	thread recover_from_careful_disable(param_00);
	for(;;)
	{
		wait_until_an_enemy_is_in_safe_area(param_00,param_01);
		self.being_careful = 1;
		self.perforing_color_driven_anim = undefined;
		self notify("start_being_careful");
		use_big_goal_until_goal_is_safe(param_00,param_01);
		self.being_careful = 0;
		self.fixednode = 1;
		set_color_goal_node(param_00);
	}
}

//Function Number: 28
recover_from_careful_disable(param_00)
{
	self endon("death");
	self endon("stop_going_to_node");
	self waittill("stop_being_careful");
	self.being_careful = 0;
	self.fixednode = 1;
	set_color_goal_node(param_00);
}

//Function Number: 29
wait_until_an_enemy_is_in_safe_area(param_00,param_01)
{
	for(;;)
	{
		if(self isknownenemyinradius(param_00.origin,self.fixednodesaferadius))
		{
			return;
		}

		if(isdefined(param_01) && self isknownenemyinvolume(param_01))
		{
			return;
		}

		wait(1);
	}
}

//Function Number: 30
use_big_goal_until_goal_is_safe(param_00,param_01)
{
	self setgoalpos(self.origin);
	if(isdefined(level.default_goalradius))
	{
		self.goalradius = level.default_goalradius;
	}
	else
	{
		self.goalradius = 1024;
	}

	self.fixednode = 0;
	for(;;)
	{
		wait(1);
		if(self isknownenemyinradius(param_00.origin,self.fixednodesaferadius))
		{
			continue;
		}

		if(isdefined(param_01) && self isknownenemyinvolume(param_01))
		{
			continue;
		}
	}
}

//Function Number: 31
process_cover_node_with_last_in_mind_allies(param_00,param_01)
{
	if(issubstr(param_00.script_color_allies,param_01))
	{
		param_00.color_priority = 2;
		self.cover_nodes_last[self.cover_nodes_last.size] = param_00;
		return;
	}

	param_00.color_priority = 1;
	self.cover_nodes_first[self.cover_nodes_first.size] = param_00;
}

//Function Number: 32
process_cover_node_with_last_in_mind_axis(param_00,param_01)
{
	if(issubstr(param_00.script_color_axis,param_01))
	{
		param_00.color_priority = 2;
		self.cover_nodes_last[self.cover_nodes_last.size] = param_00;
		return;
	}

	param_00.color_priority = 1;
	self.cover_nodes_first[self.cover_nodes_first.size] = param_00;
}

//Function Number: 33
process_cover_node(param_00,param_01)
{
	param_00.color_priority = 1;
	self.cover_nodes_first[self.cover_nodes_first.size] = param_00;
}

//Function Number: 34
process_path_node(param_00,param_01)
{
	param_00.color_priority = 3;
	self.path_nodes[self.path_nodes.size] = param_00;
}

//Function Number: 35
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
	var_08 = [];
	var_03 = [];
	foreach(var_07 in var_04.cover_nodes_first)
	{
		if(isdefined(var_07.script_colorlast))
		{
			var_07.color_priority = 4;
			var_08[var_08.size] = var_07;
			continue;
		}

		var_03[var_03.size] = var_07;
	}

	var_03 = common_scripts\utility::array_combine(var_03,var_04.cover_nodes_last);
	var_03 = common_scripts\utility::array_combine(var_03,var_04.path_nodes);
	var_03 = common_scripts\utility::array_combine(var_03,var_08);
	level.arrays_of_colorcoded_nodes[param_00][param_01] = var_03;
}

//Function Number: 36
get_best_available_new_colored_node()
{
	var_00 = level.currentcolorforced[get_team()][self.script_forcecolor];
	var_01 = get_colorcoded_nodes(get_team(),var_00);
	for(var_02 = 0;var_02 < var_01.size;var_02++)
	{
		if(!isalive(var_01[var_02].color_user))
		{
			return var_01[var_02];
		}
	}
}

//Function Number: 37
get_colorcodes(param_00,param_01)
{
	var_02 = strtok(param_00," ");
	var_02 = common_scripts\utility::array_remove_duplicates(var_02);
	var_03 = [];
	var_04 = [];
	var_05 = [];
	foreach(var_07 in var_02)
	{
		var_08 = undefined;
		foreach(var_08 in level.colorlist)
		{
			if(issubstr(var_07,var_08))
			{
				break;
			}

			var_08 = undefined;
		}

		if(!colorcode_is_used_in_map(param_01,var_07))
		{
			continue;
		}

		var_04[var_08] = var_07;
		var_03[var_03.size] = var_08;
		var_05[var_05.size] = var_07;
	}

	var_0C = [];
	var_0C["colorCodes"] = var_05;
	var_0C["colorCodesByColorIndex"] = var_04;
	var_0C["colors"] = var_03;
	return var_0C;
}

//Function Number: 38
colorcode_is_used_in_map(param_00,param_01)
{
	if(isdefined(level.arrays_of_colorcoded_nodes[param_00][param_01]))
	{
		return 1;
	}

	return isdefined(level.arrays_of_colorcoded_volumes[param_00][param_01]);
}

//Function Number: 39
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

		var_02 = getentarray(var_01.targetname,"target");
		var_01 = undefined;
		foreach(var_04 in var_02)
		{
			if(!isdefined(var_04.script_color_allies) && !isdefined(var_04.script_color_axis))
			{
				continue;
			}

			var_01 = var_04;
		}
	}

	maps\_utility::array_delete(var_00);
}

//Function Number: 40
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

//Function Number: 41
get_team(param_00)
{
	if(isdefined(self.team) && !isdefined(param_00))
	{
		param_00 = self.team;
	}

	return level.color_teams[param_00];
}

//Function Number: 42
get_colorcoded_nodes(param_00,param_01)
{
	return level.arrays_of_colorcoded_nodes[param_00][param_01];
}

//Function Number: 43
get_colorcoded_volume(param_00,param_01)
{
	return level.arrays_of_colorcoded_volumes[param_00][param_01];
}

//Function Number: 44
shortencolor(param_00)
{
	return level.colorchecklist[tolower(param_00)];
}

//Function Number: 45
my_current_node_delays()
{
	if(!isdefined(self.node))
	{
		return 0;
	}

	if(isdefined(self.script_color_delay_override))
	{
		wait(self.script_color_delay_override);
		return 1;
	}

	return self.node maps\_utility::script_delay();
}

//Function Number: 46
add_ai_to_colors(param_00,param_01)
{
	self notify("new_color_being_set");
	self endon("new_color_being_set");
	self endon("death");
	self.new_force_color_being_set = 1;
	var_02 = shortencolor(param_00);
	if(!isai(self))
	{
		set_force_color_spawner(var_02);
		return;
	}

	if(self.team == "allies")
	{
		self.pathenemyfightdist = 0;
		self.pathenemylookahead = 0;
	}

	self.script_color_axis = undefined;
	self.script_color_allies = undefined;
	self.old_forcecolor = undefined;
	var_03 = get_team();
	if(isdefined(self.script_forcecolor))
	{
		level.arrays_of_colorforced_ai[var_03][self.script_forcecolor] = common_scripts\utility::array_remove(level.arrays_of_colorforced_ai[var_03][self.script_forcecolor],self);
	}

	self.script_forcecolor = var_02;
	level.arrays_of_colorforced_ai[var_03][self.script_forcecolor] = common_scripts\utility::array_add(level.arrays_of_colorforced_ai[var_03][self.script_forcecolor],self);
	self.currentcolorcode = level.currentcolorforced[get_team()][self.script_forcecolor];
	if(isdefined(self.dontcolormove))
	{
		self.dontcolormove = undefined;
	}
	else if(isdefined(param_01))
	{
		thread ai_go_to_goal_before_colors(param_01);
	}
	else
	{
		thread goto_current_colorindex();
	}

	self.new_force_color_being_set = undefined;
	self notify("done_setting_new_color");
}

//Function Number: 47
ai_go_to_goal_before_colors(param_00)
{
	self endon("death");
	var_01 = self.goalradius;
	self.goalradius = 128;
	self setgoalpos(param_00);
	self waittill("goal");
	self.goalradius = var_01;
	thread goto_current_colorindex();
}

//Function Number: 48
remove_ai_from_colors()
{
	level.arrays_of_colorforced_ai[get_team()][self.script_forcecolor] = common_scripts\utility::array_remove(level.arrays_of_colorforced_ai[get_team()][self.script_forcecolor],self);
	left_color_node();
	self notify("stop_color_move");
	self.script_forcecolor = undefined;
	self.currentcolorcode = undefined;
	self.fixednode = 0;
	self.perforing_color_driven_anim = undefined;
	self.force_color_driven_anim = undefined;
}

//Function Number: 49
set_force_color_spawner(param_00)
{
	self.script_forcecolor = param_00;
	self.old_forcecolor = undefined;
}

//Function Number: 50
goto_current_colorindex()
{
	if(!isdefined(self.currentcolorcode))
	{
		return;
	}

	if(!isdefined(self.finished_spawning))
	{
		common_scripts\utility::waittill_either("finished spawning","death");
	}

	if(!isalive(self))
	{
		return;
	}

	left_color_node();
	var_00[0] = self;
	issue_color_order_to_ai(self.currentcolorcode,self.script_forcecolor,self.team,var_00);
}

//Function Number: 51
issue_color_orders_generic(param_00,param_01)
{
	var_02 = get_colorcodes(param_00,param_01);
	var_03 = var_02["colorCodes"];
	var_04 = var_02["colorCodesByColorIndex"];
	var_05 = var_02["colors"];
	activate_color_code_internal(var_03,var_05,param_01,var_04);
}

//Function Number: 52
get_color_volume_from_trigger_codes()
{
	var_00 = get_color_info_from_trigger();
	var_01 = var_00["team"];
	foreach(var_03 in var_00["codes"])
	{
		var_04 = level.arrays_of_colorcoded_volumes[var_01][var_03];
		if(isdefined(var_04))
		{
			return var_04;
		}
	}

	return undefined;
}

//Function Number: 53
get_color_nodes_from_trigger_codes()
{
	var_00 = get_color_info_from_trigger();
	var_01 = var_00["team"];
	foreach(var_03 in var_00["codes"])
	{
		var_04 = level.arrays_of_colorcoded_nodes[var_01][var_03];
		if(isdefined(var_04))
		{
			return var_04;
		}
	}

	return undefined;
}

//Function Number: 54
get_color_info_from_trigger()
{
	var_00 = "allies";
	if(isdefined(self.script_color_axis))
	{
		var_00 = "axis";
	}

	var_01 = [];
	if(var_00 == "allies")
	{
		var_02 = get_colorcodes(self.script_color_allies,"allies");
		var_01 = var_02["colorCodes"];
	}
	else
	{
		var_02 = get_colorcodes(self.script_color_axis,"axis");
		var_01 = var_02["colorCodes"];
	}

	var_03 = [];
	var_03["team"] = var_00;
	var_03["codes"] = var_01;
	return var_03;
}

//Function Number: 55
colornode_clear_promotion_order()
{
	level.current_color_order = [];
}

//Function Number: 56
colornode_set_promotion_order(param_00,param_01)
{
	if(!isdefined(level.current_color_order))
	{
		level.current_color_order = [];
	}

	param_00 = shortencolor(param_00);
	param_01 = shortencolor(param_01);
	level.current_color_order[param_00] = param_01;
	if(!isdefined(level.current_color_order[param_01]))
	{
		colornode_set_empty_promotion_order(param_01);
	}
}

//Function Number: 57
colornode_set_empty_promotion_order(param_00)
{
	if(!isdefined(level.current_color_order))
	{
		level.current_color_order = [];
	}

	level.current_color_order[param_00] = "none";
}

//Function Number: 58
get_color_to_promote_from_order(param_00)
{
	if(!isdefined(param_00))
	{
		return "none";
	}

	if(!isdefined(level.current_color_order))
	{
		return "none";
	}

	if(!isdefined(level.current_color_order[param_00]))
	{
		return "none";
	}

	return level.current_color_order[param_00];
}

//Function Number: 59
get_color_forced_ai(param_00,param_01)
{
	if(isdefined(level.arrays_of_colorforced_ai[param_00][param_01]))
	{
		level.arrays_of_colorforced_ai[param_00][param_01] = maps\_utility::array_removedead(level.arrays_of_colorforced_ai[param_00][param_01]);
		return level.arrays_of_colorforced_ai[param_00][param_01];
	}

	return undefined;
}

//Function Number: 60
colornode_set_respawn_point(param_00,param_01)
{
	if(param_01 == "allies" || param_01 == "axis")
	{
		level.respawn_spawner_org[param_01] = param_00;
		return;
	}

	level.respawn_spawner_org["allies"] = param_00;
	level.respawn_spawner_org["axis"] = param_00;
}

//Function Number: 61
colornode_spawn_reinforcement(param_00,param_01,param_02,param_03,param_04)
{
	level endon("kill_color_replacements");
	level endon("kill_hidden_reinforcement_waiting");
	var_05 = spawn_hidden_reinforcement(param_00,param_01,param_02,param_04);
	if(!isdefined(var_05))
	{
		var_06 = 0;
		if(param_00 == "allies" && common_scripts\utility::flag("respawn_friendlies"))
		{
			var_06 = 1;
		}
		else if(param_00 == "axis" && common_scripts\utility::flag("respawn_enemies"))
		{
			var_06 = 1;
		}

		if(var_06)
		{
		}

		return;
	}

	if(var_06.team == "allies" && isdefined(level.friendly_startup_thread))
	{
		var_06 thread [[ level.friendly_startup_thread ]]();
	}
	else if(var_06.team == "axis" && isdefined(level.enemy_startup_thread))
	{
		var_06 thread [[ level.enemy_startup_thread ]]();
	}

	if(isdefined(param_04) && param_04 == 1)
	{
		var_06 thread colornode_replace_on_death();
	}
}

//Function Number: 62
spawn_hidden_reinforcement(param_00,param_01,param_02,param_03)
{
	level endon("kill_color_replacements");
	level endon("kill_hidden_reinforcement_waiting");
	var_04 = undefined;
	if(param_00 == "allies" && !common_scripts\utility::flag("respawn_friendlies"))
	{
		return undefined;
	}

	if(param_00 == "axis" && !common_scripts\utility::flag("respawn_enemies"))
	{
		return undefined;
	}

	for(;;)
	{
		if(!respawn_reinforcements_without_vision_check(param_00))
		{
			if(!isdefined(level.friendly_respawn_vision_checker_thread))
			{
				thread spawner_vision_checker("allies");
			}

			if(!isdefined(level.enemy_respawn_vision_checker_thread))
			{
				thread spawner_vision_checker("axis");
			}

			for(;;)
			{
				wait_until_vision_check_satisfied_or_disabled(param_00);
				if(respawn_reinforcements_without_vision_check(param_00,1))
				{
					break;
				}

				wait(0.05);
			}
		}

		thread lock_spawner_for_awhile(param_00);
		var_05 = get_color_spawner(param_00,param_01);
		var_05.count = 1;
		var_06 = var_05.origin;
		var_05.origin = level.respawn_spawner_org[param_00];
		var_07 = undefined;
		if(isdefined(var_05.script_forcecolor))
		{
			var_07 = var_05.script_forcecolor;
			var_05.script_forcecolor = undefined;
		}

		var_04 = var_05 stalingradspawn();
		var_05.script_forcecolor = var_07;
		var_05.origin = var_06;
		if(maps\_utility::spawn_failed(var_04))
		{
			thread lock_spawner_for_awhile(param_00);
			wait(1);
			continue;
		}

		level notify("reinforcement_spawned",var_04);
		break;
	}

	var_04 add_ai_to_colors(param_02,param_03);
	return var_04;
}

//Function Number: 63
respawn_reinforcements_without_vision_check(param_00,param_01)
{
	if(!isdefined(param_01) || param_01 == 0)
	{
		if(param_00 == "allies" && isdefined(level.respawn_friendlies_force_vision_check))
		{
			return 0;
		}
		else if(param_00 == "axis" && isdefined(level.respawn_enemies_force_vision_check))
		{
			return 0;
		}
	}

	if(param_00 == "allies")
	{
		return common_scripts\utility::flag("respawn_friendlies") && !common_scripts\utility::flag("friendly_spawner_locked");
	}

	if(param_00 == "axis")
	{
		return common_scripts\utility::flag("respawn_enemies") && !common_scripts\utility::flag("enemy_spawner_locked");
	}
}

//Function Number: 64
wait_until_vision_check_satisfied_or_disabled(param_00)
{
	if(param_00 == "allies")
	{
		if(common_scripts\utility::flag("player_looks_away_from_friendly_spawner"))
		{
			return;
		}

		level endon("player_looks_away_from_friendly_spawner");
	}
	else
	{
		if(common_scripts\utility::flag("player_looks_away_from_enemy_spawner"))
		{
			return;
		}

		level endon("player_looks_away_from_enemy_spawner");
	}

	for(;;)
	{
		if(respawn_reinforcements_without_vision_check(param_00))
		{
			return;
		}

		wait(0.05);
	}
}

//Function Number: 65
spawner_vision_checker(param_00)
{
	if(param_00 == "allies")
	{
		level.friendly_respawn_vision_checker_thread = 1;
	}
	else
	{
		level.enemy_respawn_vision_checker_thread = 1;
	}

	var_01 = 0;
	for(;;)
	{
		wait(1);
		if(!isdefined(level.respawn_spawner_org[param_00]))
		{
			var_01 = 0;
			continue;
		}

		var_02 = level.respawn_spawner_org[param_00] - level.player.origin;
		if(length(var_02) < 200)
		{
			player_sees_spawner(param_00);
			var_01 = 0;
			continue;
		}

		var_03 = anglestoforward((0,level.player getplayerangles()[1],0));
		var_04 = vectornormalize(var_02);
		var_05 = vectordot(var_03,var_04);
		if(var_05 > 0.2)
		{
			var_06 = !sighttracepassed(level.player geteye(),level.respawn_spawner_org[param_00],0,level.player);
			if(var_06)
			{
				var_06 = !sighttracepassed(level.player geteye(),level.respawn_spawner_org[param_00] + (0,0,96),0,level.player);
			}

			if(!var_06)
			{
				player_sees_spawner(param_00);
				var_01 = 0;
				continue;
			}
		}

		var_01++;
		if(var_01 < 3)
		{
			continue;
		}

		player_does_not_see_spawner(param_00);
	}
}

//Function Number: 66
player_sees_spawner(param_00)
{
	if(param_00 == "allies")
	{
		common_scripts\utility::flag_clear("player_looks_away_from_friendly_spawner");
		return;
	}

	common_scripts\utility::flag_clear("player_looks_away_from_enemy_spawner");
}

//Function Number: 67
player_does_not_see_spawner(param_00)
{
	if(param_00 == "allies")
	{
		common_scripts\utility::flag_set("player_looks_away_from_friendly_spawner");
		return;
	}

	common_scripts\utility::flag_set("player_looks_away_from_enemy_spawner");
}

//Function Number: 68
get_color_spawner(param_00,param_01)
{
	if(isdefined(param_01) && isdefined(level.arrays_color_spawners[param_00][param_01]))
	{
		return common_scripts\utility::random(level.arrays_color_spawners[param_00][param_01]);
	}

	var_02 = getarraykeys(level.arrays_color_spawners[param_00]);
	var_03 = [];
	foreach(var_05 in var_02)
	{
		var_03 = common_scripts\utility::array_add(var_03,level.arrays_color_spawners[var_05]);
	}

	return common_scripts\utility::random(var_03);
}

//Function Number: 69
lock_spawner_for_awhile(param_00)
{
	level notify("stop_lock_spawner_for_team_" + param_00);
	level endon("stop_lock_spawner_for_team_" + param_00);
	if(param_00 == "allies")
	{
		common_scripts\utility::flag_set("friendly_spawner_locked");
	}
	else
	{
		common_scripts\utility::flag_set("enemy_spawner_locked");
	}

	if(param_00 == "allies" && isdefined(level.friendly_respawn_lock_func))
	{
		[[ level.friendly_respawn_lock_func ]]();
	}
	else if(param_00 == "axis" && isdefined(level.enemy_respawn_lock_func))
	{
		[[ level.enemy_respawn_lock_func ]]();
	}
	else
	{
		wait(2);
	}

	if(param_00 == "allies")
	{
		common_scripts\utility::flag_clear("friendly_spawner_locked");
		return;
	}

	common_scripts\utility::flag_clear("enemy_spawner_locked");
}

//Function Number: 70
colornode_replace_on_death()
{
	level endon("kill_color_replacements");
	self endon("_disable_reinforcement");
	if(isdefined(self.replace_on_death))
	{
		return;
	}

	self.replace_on_death = 1;
	waittillframeend;
	if(isalive(self))
	{
		self waittill("death");
	}

	if(isremovedentity(self))
	{
		return;
	}

	var_00 = self.classname;
	var_01 = self.script_forcecolor;
	var_02 = self.team;
	var_03 = self.origin;
	if(!isdefined(var_01))
	{
		return;
	}

	var_04 = get_color_to_promote_from_order(var_01);
	if(var_04 != "none")
	{
		for(;;)
		{
			var_05 = get_color_forced_ai(var_02,var_04);
			if(!isdefined(var_05))
			{
				break;
			}

			if(!isdefined(level.color_doesnt_care_about_heroes))
			{
				var_05 = maps\_utility::remove_heroes_from_array(var_05);
			}

			if(!isdefined(level.color_doesnt_care_about_classname))
			{
				var_05 = maps\_utility::remove_without_classname(var_05,var_00);
			}

			if(var_05.size <= 0)
			{
				break;
			}

			var_06 = common_scripts\utility::getclosest(var_03,var_05);
			if(!isalive(var_06))
			{
				continue;
			}

			var_07 = var_06.classname;
			var_04 = var_06.script_forcecolor;
			var_06 add_ai_to_colors(var_01,var_03);
			if(var_02 == "allies" && isdefined(level.friendly_promotion_thread))
			{
				var_06 [[ level.friendly_promotion_thread ]](var_01);
			}

			if(var_02 == "axis" && isdefined(level.enemy_promotion_thread))
			{
				var_06 [[ level.enemy_promotion_thread ]](var_01);
			}

			var_00 = var_07;
			var_01 = var_04;
			var_03 = var_06.origin;
			break;
		}
	}

	thread colornode_spawn_reinforcement(var_02,var_00,var_01,1,var_03);
}

//Function Number: 71
colornode_stop_replace_on_death_group(param_00,param_01)
{
	if(isdefined(param_01) && !colorislegit(param_01))
	{
	}

	foreach(var_03 in level.colorlist)
	{
		if(isdefined(param_01) && var_03 != param_01)
		{
			continue;
		}

		if((isdefined(param_00) && param_00 == "axis") || param_00 == "allies")
		{
			foreach(var_05 in level.arrays_of_colorforced_ai[param_00][var_03])
			{
				if(isalive(var_05))
				{
					var_05 notify("_disable_reinforcement");
				}
			}

			continue;
		}

		foreach(var_05 in level.arrays_of_colorforced_ai["axis"][var_03])
		{
			if(isalive(var_05))
			{
				var_05 notify("_disable_reinforcement");
			}
		}

		foreach(var_05 in level.arrays_of_colorforced_ai["allies"][var_03])
		{
			if(isalive(var_05))
			{
				var_05 notify("_disable_reinforcement");
			}
		}
	}
}

//Function Number: 72
kill_color_replacements()
{
	common_scripts\utility::flag_clear("friendly_spawner_locked");
	common_scripts\utility::flag_clear("enemy_spawner_locked");
	level notify("kill_color_replacements");
	var_00 = getaiarray();
	common_scripts\utility::array_thread(var_00,::remove_replace_on_death);
}

//Function Number: 73
remove_replace_on_death()
{
	self.replace_on_death = undefined;
}