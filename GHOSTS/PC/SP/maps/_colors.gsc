/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\_colors.gsc
 * Game: Call of Duty: Ghosts
 * Platform: PC
 * Function Count: 72
 * Decompile Time: 1191 ms
 * Timestamp: 10/27/2023 1:27:23 AM
*******************************************************************/

//Function Number: 1
init_color_grouping(param_00)
{
	common_scripts\utility::func_3385("player_looks_away_from_spawner");
	common_scripts\utility::func_3385("friendly_spawner_locked");
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
		if(isdefined(var_04.var_6B66))
		{
			var_04 func_08AD(var_04.var_6B66,"allies");
		}

		if(isdefined(var_04.script_color_axis))
		{
			var_04 func_08AD(var_04.script_color_axis,"axis");
		}
	}

	foreach(var_07 in var_02)
	{
		if(isdefined(var_07.var_6B66))
		{
			var_07 add_volume_to_global_arrays(var_07.var_6B66,"allies");
		}

		if(isdefined(var_07.script_color_axis))
		{
			var_07 add_volume_to_global_arrays(var_07.script_color_axis,"axis");
		}
	}

	foreach(var_0A in var_01)
	{
		if(isdefined(var_0A.var_6B66))
		{
			var_0A thread func_835F(var_0A.var_6B66,"allies");
		}

		if(isdefined(var_0A.script_color_axis))
		{
			var_0A thread func_835F(var_0A.script_color_axis,"axis");
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
	func_08B2("Ambush");
	func_08B2("Guard");
	func_08B2("Path");
	func_08B2("Exposed");
	level.colorlist = [];
	level.colorlist[level.colorlist.size] = "r";
	level.colorlist[level.colorlist.size] = "b";
	level.colorlist[level.colorlist.size] = "y";
	level.colorlist[level.colorlist.size] = "c";
	level.colorlist[level.colorlist.size] = "g";
	level.colorlist[level.colorlist.size] = "p";
	level.colorlist[level.colorlist.size] = "o";
	level.var_1E13["red"] = "r";
	level.var_1E13["r"] = "r";
	level.var_1E13["blue"] = "b";
	level.var_1E13["b"] = "b";
	level.var_1E13["yellow"] = "y";
	level.var_1E13["y"] = "y";
	level.var_1E13["cyan"] = "c";
	level.var_1E13["c"] = "c";
	level.var_1E13["green"] = "g";
	level.var_1E13["g"] = "g";
	level.var_1E13["purple"] = "p";
	level.var_1E13["p"] = "p";
	level.var_1E13["orange"] = "o";
	level.var_1E13["o"] = "o";
	level.currentcolorforced = [];
	level.currentcolorforced["allies"] = [];
	level.currentcolorforced["axis"] = [];
	level.var_4C4F = [];
	level.var_4C4F["allies"] = [];
	level.var_4C4F["axis"] = [];
	foreach(var_0D in level.colorlist)
	{
		level.arrays_of_colorforced_ai["allies"][var_0D] = [];
		level.arrays_of_colorforced_ai["axis"][var_0D] = [];
		level.currentcolorforced["allies"][var_0D] = undefined;
		level.currentcolorforced["axis"][var_0D] = undefined;
	}

	thread func_5DA8();
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
	self.var_6BCF = level.var_1E13[self.var_6BCF];
}

//Function Number: 3
ai_picks_destination(param_00)
{
	if(isdefined(self.var_6BCF))
	{
		convert_color_to_short_string();
		self.currentcolorcode = param_00;
		var_01 = self.var_6BCF;
		level.arrays_of_colorforced_ai[func_39C5()][var_01] = common_scripts\utility::array_add(level.arrays_of_colorforced_ai[func_39C5()][var_01],self);
		thread func_3D86();
	}
}

//Function Number: 4
func_3D86()
{
	if(!isdefined(self.currentcolorcode))
	{
	}

	var_00 = level.arrays_of_colorcoded_nodes[func_39C5()][self.currentcolorcode];
	func_4D55();
	if(!isalive(self))
	{
	}

	if(!maps\_utility::func_3FD6())
	{
	}

	if(!isdefined(var_00))
	{
		var_01 = level.arrays_of_colorcoded_volumes[func_39C5()][self.currentcolorcode];
		func_6D8F(var_01,self.currentcolorcode);
	}

	for(var_02 = 0;var_02 < var_01.size;var_02++)
	{
		var_03 = var_01[var_02];
		if(isalive(var_03.color_user) && !isplayer(var_03.color_user))
		{
			continue;
		}

		thread func_0A12(var_03);
		thread decrementcolorusers(var_03);
	}

	func_5628();
}

//Function Number: 5
func_5628()
{
}

//Function Number: 6
func_381C()
{
	var_00 = [];
	var_00[var_00.size] = "r";
	var_00[var_00.size] = "b";
	var_00[var_00.size] = "y";
	var_00[var_00.size] = "c";
	var_00[var_00.size] = "g";
	var_00[var_00.size] = "p";
	var_00[var_00.size] = "o";
	return var_00;
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
func_3823(param_00,param_01)
{
	return func_3821(param_00,param_01);
}

//Function Number: 9
func_3821(param_00,param_01)
{
	var_02 = strtok(param_00," ");
	var_02 = array_remove_dupes(var_02);
	var_03 = [];
	var_04 = [];
	var_05 = [];
	var_06 = func_381C();
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

		if(!func_1E14(param_01,var_08))
		{
			continue;
		}

		var_04[var_09] = var_08;
		var_03[var_03.size] = var_09;
		var_05[var_05.size] = var_08;
	}

	var_02 = var_05;
	var_0D = [];
	var_0D["colorCodes"] = var_02;
	var_0D["colorCodesByColorIndex"] = var_04;
	var_0D["colors"] = var_03;
	return var_0D;
}

//Function Number: 10
func_1E14(param_00,param_01)
{
	if(isdefined(level.arrays_of_colorcoded_nodes[param_00][param_01]))
	{
		return 1;
	}

	return isdefined(level.arrays_of_colorcoded_volumes[param_00][param_01]);
}

//Function Number: 11
func_835F(param_00,param_01)
{
	var_02 = func_3823(param_00,param_01);
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

		func_0814(var_03,var_05,param_01,var_04);
		if(isdefined(self.script_oneway) && self.script_oneway)
		{
			thread func_8339();
		}
	}
}

//Function Number: 12
func_8339()
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
			if(!isdefined(var_04.var_6B66) && !isdefined(var_04.script_color_axis))
			{
				continue;
			}

			var_01 = var_04;
		}
	}

	maps\_utility::array_delete(var_00);
}

//Function Number: 13
activate_color_trigger(param_00)
{
	if(param_00 == "allies")
	{
		thread get_colorcodes_and_activate_trigger(self.var_6B66,param_00);
	}

	thread get_colorcodes_and_activate_trigger(self.script_color_axis,param_00);
}

//Function Number: 14
get_colorcodes_and_activate_trigger(param_00,param_01)
{
	var_02 = func_3823(param_00,param_01);
	var_03 = var_02["colorCodes"];
	var_04 = var_02["colorCodesByColorIndex"];
	var_05 = var_02["colors"];
	func_0814(var_03,var_05,param_01,var_04);
}

//Function Number: 15
func_0814(param_00,param_01,param_02,param_03)
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
		level.var_4C4F[param_02][var_07] = level.currentcolorforced[param_02][var_07];
		level.currentcolorforced[param_02][var_07] = param_03[var_07];
	}

	var_0B = [];
	for(var_04 = 0;var_04 < param_00.size;var_04++)
	{
		if(func_6A13(param_02,param_01[var_04]))
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

		if(func_6A13(param_02,param_01[var_04]))
		{
			continue;
		}

		if(!isdefined(level.arrays_of_colorcoded_ai[param_02][var_0C]))
		{
			continue;
		}

		func_4974(var_0C,param_01[var_04],param_02,var_0B[var_0C]);
	}
}

//Function Number: 17
func_6A13(param_00,param_01)
{
	if(!isdefined(level.var_4C4F[param_00][param_01]))
	{
		return 0;
	}

	return level.var_4C4F[param_00][param_01] == level.currentcolorforced[param_00][param_01];
}

//Function Number: 18
func_61C1(param_00,param_01)
{
	if(issubstr(param_00.var_6B66,param_01))
	{
		self.var_1FA6[self.var_1FA6.size] = param_00;
	}

	self.var_1FA5[self.var_1FA5.size] = param_00;
}

//Function Number: 19
func_61C2(param_00,param_01)
{
	if(issubstr(param_00.script_color_axis,param_01))
	{
		self.var_1FA6[self.var_1FA6.size] = param_00;
	}

	self.var_1FA5[self.var_1FA5.size] = param_00;
}

//Function Number: 20
func_61C0(param_00,param_01)
{
	self.var_1FA5[self.var_1FA5.size] = param_00;
}

//Function Number: 21
func_61C9(param_00,param_01)
{
	self.var_5B27[self.var_5B27.size] = param_00;
}

//Function Number: 22
func_61B4(param_00,param_01,param_02)
{
	var_03 = level.arrays_of_colorcoded_nodes[param_00][param_01];
	var_04 = spawnstruct();
	var_04.var_5B27 = [];
	var_04.var_1FA5 = [];
	var_04.var_1FA6 = [];
	var_05 = isdefined(level.var_4C4F[param_00][param_02]);
	for(var_06 = 0;var_06 < var_03.size;var_06++)
	{
		var_07 = var_03[var_06];
		var_04 [[ level.color_node_type_function[var_07.type][var_05][param_00] ]](var_07,level.var_4C4F[param_00][param_02]);
	}

	var_04.var_1FA5 = common_scripts\utility::array_randomize(var_04.var_1FA5);
	var_08 = [];
	var_03 = [];
	foreach(var_0A, var_07 in var_04.var_1FA5)
	{
		if(isdefined(var_07.var_6B6A))
		{
			var_08[var_08.size] = var_07;
			var_03[var_0A] = undefined;
			continue;
		}

		var_03[var_03.size] = var_07;
	}

	for(var_06 = 0;var_06 < var_04.var_1FA6.size;var_06++)
	{
		var_03[var_03.size] = var_04.var_1FA6[var_06];
	}

	for(var_06 = 0;var_06 < var_04.var_5B27.size;var_06++)
	{
		var_03[var_03.size] = var_04.var_5B27[var_06];
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
	}

	common_scripts\utility::func_F1B(var_03,::func_4D55);
	return var_03;
}

//Function Number: 26
func_6D8F(param_00,param_01)
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
func_4974(param_00,param_01,param_02,param_03)
{
	var_04 = param_03;
	var_05 = [];
	if(isdefined(level.arrays_of_colorcoded_nodes[param_02][param_00]))
	{
		func_61B4(param_02,param_00,param_01);
		var_05 = get_prioritized_colorcoded_nodes(param_02,param_00,param_01);
	}
	else
	{
		var_06 = get_colorcoded_volume(param_02,param_00);
		common_scripts\utility::func_F1B(param_03,::func_6D8F,var_06,param_00);
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

		var_0B = common_scripts\utility::func_3A56(var_0A.origin,param_03);
		param_03 = common_scripts\utility::array_remove(param_03,var_0B);
		var_0B func_7E78(var_0A,param_00,self,var_07);
		var_07++;
		if(!param_03.size)
		{
		}
	}
}

//Function Number: 28
func_7E78(param_00,param_01,param_02,param_03)
{
	self notify("stop_color_move");
	self.currentcolorcode = param_01;
	thread func_61BF(param_00,param_02,param_03);
}

//Function Number: 29
func_5DA8()
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
		var_00 func_1E06();
	}
}

//Function Number: 30
func_1E06()
{
	if(isdefined(self.var_6B66))
	{
		color_node_finds_user_from_colorcodes(self.var_6B66,"allies");
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
	}

	var_02 = strtok(param_00," ");
	var_02 = array_remove_dupes(var_02);
	common_scripts\utility::array_levelthread(var_02,::func_1E07,param_01);
}

//Function Number: 32
func_1E07(param_00,param_01)
{
	var_02 = param_00[0];
	if(!isdefined(level.currentcolorforced[param_01][var_02]))
	{
	}

	if(level.currentcolorforced[param_01][var_02] != param_00)
	{
	}

	var_03 = maps\_utility::get_force_color_guys(param_01,var_02);
	for(var_04 = 0;var_04 < var_03.size;var_04++)
	{
		var_05 = var_03[var_04];
		if(var_05 func_57F2(param_00))
		{
			continue;
		}

		var_05 func_7E78(self,param_00);
	}
}

//Function Number: 33
func_57F2(param_00)
{
	if(!isdefined(self.currentcolorcode))
	{
		return 0;
	}

	return self.currentcolorcode == param_00;
}

//Function Number: 34
func_0A12(param_00)
{
	self endon("death");
	self endon("stop_color_move");
	func_5549();
	thread ai_sets_goal(param_00);
}

//Function Number: 35
ai_sets_goal(param_00)
{
	self notify("stop_going_to_node");
	func_6EF3(param_00);
	var_01 = level.arrays_of_colorcoded_volumes[func_39C5()][self.currentcolorcode];
	if(isdefined(self.var_6B5E))
	{
		thread func_1A36(param_00,var_01);
	}
}

//Function Number: 36
func_6EF3(param_00)
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

	if(func_484E(param_00))
	{
		thread forcegoal_radius(param_00);
	}
	else if(isdefined(param_00.radius) && param_00.radius > 0)
	{
		self.goalradius = param_00.radius;
	}

	var_01 = level.arrays_of_colorcoded_volumes[func_39C5()][self.currentcolorcode];
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
	}

	if(isdefined(level.var_3374))
	{
		self.fixednodesaferadius = level.var_3374;
	}

	self.fixednodesaferadius = 64;
}

//Function Number: 37
func_484E(param_00)
{
	if(!isdefined(self.var_6BD2))
	{
		return 0;
	}

	if(!self.var_6BD2)
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
	common_scripts\utility::func_8B4F("goal","damage");
	if(isdefined(param_00.radius) && param_00.radius > 0)
	{
		self.goalradius = param_00.radius;
	}
}

//Function Number: 39
func_1A36(param_00,param_01)
{
	self endon("death");
	self endon("stop_being_careful");
	self endon("stop_going_to_node");
	thread recover_from_careful_disable(param_00);
	for(;;)
	{
		func_8AC2(param_00,param_01);
		func_8778(param_00,param_01);
		self.fixednode = 1;
		func_6EF3(param_00);
	}
}

//Function Number: 40
recover_from_careful_disable(param_00)
{
	self endon("death");
	self endon("stop_going_to_node");
	self waittill("stop_being_careful");
	self.fixednode = 1;
	func_6EF3(param_00);
}

//Function Number: 41
func_8778(param_00,param_01)
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
		}
	}

	for(;;)
	{
		if(!func_48F9(param_00.origin,self.fixednodesaferadius))
		{
		}

		wait(1);
	}
}

//Function Number: 42
func_48F9(param_00,param_01)
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
func_8AC2(param_00,param_01)
{
	if(isdefined(param_01))
	{
		for(;;)
		{
			if(self isknownenemyinradius(param_00.origin,self.fixednodesaferadius))
			{
			}

			if(self isknownenemyinvolume(param_01))
			{
			}

			wait(1);
		}
	}

	for(;;)
	{
		if(func_48F9(param_00.origin,self.fixednodesaferadius))
		{
		}

		wait(1);
	}
}

//Function Number: 44
func_5549()
{
	if(!isdefined(self.node))
	{
		return 0;
	}

	if(isdefined(self.var_6B69))
	{
		wait(self.var_6B69);
		return 1;
	}

	return self.node maps\_utility::script_delay();
}

//Function Number: 45
func_61BF(param_00,param_01,param_02)
{
	thread decrementcolorusers(param_00);
	self endon("stop_color_move");
	self endon("death");
	if(isdefined(param_01))
	{
		param_01 maps\_utility::script_delay();
	}

	if(!func_5549())
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
			wait(0.05);
		}

		param_00 = func_37E7();
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
func_37E6()
{
	var_00 = level.currentcolorforced[func_39C5()][self.var_6BCF];
	var_01 = get_prioritized_colorcoded_nodes(func_39C5(),var_00,self.var_6BCF);
	for(var_02 = 0;var_02 < var_01.size;var_02++)
	{
		if(!isalive(var_01[var_02].color_user))
		{
			return var_01[var_02];
		}
	}
}

//Function Number: 47
func_37E7()
{
	var_00 = level.currentcolorforced[func_39C5()][self.var_6BCF];
	var_01 = get_prioritized_colorcoded_nodes(func_39C5(),var_00,self.var_6BCF);
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
func_61CB(param_00)
{
	self endon("stopScript");
	self endon("death");
	if(isdefined(self.node))
	{
	}

	if(distance(param_00.origin,self.origin) < 32)
	{
		func_63A7(param_00);
	}

	var_01 = gettime();
	func_8A86(1);
	var_02 = gettime();
	if(var_02 - var_01 >= 1000)
	{
		func_63A7(param_00);
	}
}

//Function Number: 49
func_8A86(param_00)
{
	self endon("killanimscript");
	wait(param_00);
}

//Function Number: 50
func_63A7(param_00)
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
func_08AD(param_00,param_01)
{
	self.color_user = undefined;
	var_02 = strtok(param_00," ");
	var_02 = array_remove_dupes(var_02);
	foreach(var_04 in var_02)
	{
		if(isdefined(level.arrays_of_colorcoded_nodes[param_01]) && isdefined(level.arrays_of_colorcoded_nodes[param_01][var_04]))
		{
			level.arrays_of_colorcoded_nodes[param_01][var_04] = common_scripts\utility::array_add(level.arrays_of_colorcoded_nodes[param_01][var_04],self);
			continue;
		}

		level.arrays_of_colorcoded_nodes[param_01][var_04][0] = self;
		level.arrays_of_colorcoded_ai[param_01][var_04] = [];
		level.arrays_of_colorcoded_spawners[param_01][var_04] = [];
	}
}

//Function Number: 55
func_4D55()
{
	if(!isdefined(self.color_node))
	{
	}

	if(isdefined(self.color_node.color_user) && self.color_node.color_user == self)
	{
		self.color_node.color_user = undefined;
	}

	self.color_node = undefined;
	self notify("stop_color_move");
}

//Function Number: 56
func_3A5F()
{
	var_00 = [];
	if(issubstr(self.classname,"axis") || issubstr(self.classname,"enemy") || issubstr(self.classname,"team3"))
	{
		var_00["team"] = "axis";
		var_00["colorTeam"] = self.script_color_axis;
	}

	if(issubstr(self.classname,"ally") || self.type == "civilian")
	{
		var_00["team"] = "allies";
		var_00["colorTeam"] = self.var_6B66;
	}

	if(!isdefined(var_00["colorTeam"]))
	{
		var_00 = undefined;
	}

	return var_00;
}

//Function Number: 57
func_65AF()
{
	var_00 = func_3A5F();
	if(!isdefined(var_00))
	{
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
	level.color_node_type_function[param_00][1]["allies"] = ::func_61C1;
	level.color_node_type_function[param_00][1]["axis"] = ::func_61C2;
	level.color_node_type_function[param_00][0]["allies"] = ::func_61C0;
	level.color_node_type_function[param_00][0]["axis"] = ::func_61C0;
}

//Function Number: 59
func_08B2(param_00)
{
	level.color_node_type_function[param_00][1]["allies"] = ::func_61C9;
	level.color_node_type_function[param_00][0]["allies"] = ::func_61C9;
	level.color_node_type_function[param_00][1]["axis"] = ::func_61C9;
	level.color_node_type_function[param_00][0]["axis"] = ::func_61C9;
}

//Function Number: 60
func_1E1C(param_00,param_01)
{
	level endon("kill_color_replacements");
	level endon("kill_hidden_reinforcement_waiting");
	var_02 = func_77D9(param_00,param_01);
	if(isdefined(level.var_3561))
	{
		var_02 thread [[ level.var_3561 ]]();
	}

	var_02 thread func_1E1A();
}

//Function Number: 61
func_1E1A()
{
	level endon("kill_color_replacements");
	self endon("_disable_reinforcement");
	if(isdefined(self.var_65C2))
	{
	}

	self.var_65C2 = 1;
	var_00 = self.classname;
	var_01 = self.var_6BCF;
	waittillframeend;
	if(isalive(self))
	{
		self waittill("death");
	}

	var_02 = level.current_color_order;
	if(!isdefined(self.var_6BCF))
	{
	}

	thread func_1E1C(var_00,self.var_6BCF);
	if(isdefined(self) && isdefined(self.var_6BCF))
	{
		var_01 = self.var_6BCF;
	}

	if(isdefined(self) && isdefined(self.origin))
	{
		var_03 = self.origin;
	}

	for(;;)
	{
		if(func_3818(var_01,var_02) == "none")
		{
		}

		var_04 = maps\_utility::get_force_color_guys("allies",var_02[var_01]);
		if(!isdefined(level.color_doesnt_care_about_heroes))
		{
			var_04 = maps\_utility::func_6535(var_04);
		}

		if(!isdefined(level.color_doesnt_care_about_classname))
		{
			var_04 = maps\_utility::remove_without_classname(var_04,var_00);
		}

		if(!var_04.size)
		{
			wait(2);
			continue;
		}

		var_05 = common_scripts\utility::func_3A56(level.player.origin,var_04);
		waittillframeend;
		if(!isalive(var_05))
		{
			continue;
		}

		var_05 maps\_utility::func_6EDF(var_01);
		if(isdefined(level.friendly_promotion_thread))
		{
			var_05 [[ level.friendly_promotion_thread ]](var_01);
		}

		var_01 = var_02[var_01];
	}
}

//Function Number: 62
func_3818(param_00,param_01)
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
func_3557()
{
	level.friendly_respawn_vision_checker_thread = 1;
	var_00 = 0;
	for(;;)
	{
		for(;;)
		{
			if(!func_662B())
			{
				break;
			}

			wait(0.05);
		}

		wait(1);
		if(!isdefined(level.respawn_spawner_org))
		{
			continue;
		}

		var_01 = level.player.origin - level.respawn_spawner_org;
		if(length(var_01) < 200)
		{
			func_5EFF();
			continue;
		}

		var_02 = anglestoforward((0,level.player getplayerangles()[1],0));
		var_03 = vectornormalize(var_01);
		var_04 = vectordot(var_02,var_03);
		if(var_04 < 0.2)
		{
			func_5EFF();
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
func_381E(param_00)
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
		var_03 = common_scripts\utility::func_6306(level._color_friendly_spawners);
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
			return common_scripts\utility::func_6306(level._color_friendly_spawners);
		}

		return var_06;
	}

	return level._color_friendly_spawners[var_06];
}

//Function Number: 65
func_662B()
{
	if(isdefined(level.respawn_friendlies_force_vision_check))
	{
		return 0;
	}

	return common_scripts\utility::flag("respawn_friendlies");
}

//Function Number: 66
func_8AC6()
{
	if(common_scripts\utility::flag("player_looks_away_from_spawner"))
	{
	}

	level endon("player_looks_away_from_spawner");
	for(;;)
	{
		if(func_662B())
		{
		}

		wait(0.05);
	}
}

//Function Number: 67
func_77D9(param_00,param_01)
{
	level endon("kill_color_replacements");
	level endon("kill_hidden_reinforcement_waiting");
	var_02 = undefined;
	for(;;)
	{
		if(!func_662B())
		{
			if(!isdefined(level.friendly_respawn_vision_checker_thread))
			{
				thread func_3557();
			}

			for(;;)
			{
				func_8AC6();
				common_scripts\utility::func_33A0("friendly_spawner_locked");
				if(common_scripts\utility::flag("player_looks_away_from_spawner") || func_662B())
				{
					break;
				}
			}

			common_scripts\utility::flag_set("friendly_spawner_locked");
		}

		var_03 = func_381E(param_00);
		var_03.count = 1;
		var_04 = var_03.origin;
		var_03.origin = level.respawn_spawner_org;
		var_02 = var_03 stalingradspawn();
		var_03.origin = var_04;
		if(maps\_utility::func_77BE(var_02))
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

		if(func_3818(param_01,level.current_color_order) == "none")
		{
			break;
		}

		param_01 = level.current_color_order[param_01];
	}

	if(isdefined(param_01))
	{
		var_02 maps\_utility::func_6EDF(param_01);
	}

	thread lock_spawner_for_awhile();
	return var_02;
}

//Function Number: 68
lock_spawner_for_awhile()
{
	common_scripts\utility::flag_set("friendly_spawner_locked");
	if(isdefined(level.var_354F))
	{
		[[ level.var_354F ]]();
	}
	else
	{
		wait(2);
	}

	common_scripts\utility::func_337C("friendly_spawner_locked");
}

//Function Number: 69
func_5EFF()
{
	var_00 = 0;
	common_scripts\utility::func_337C("player_looks_away_from_spawner");
}

//Function Number: 70
func_4AC3()
{
	common_scripts\utility::func_337C("friendly_spawner_locked");
	level notify("kill_color_replacements");
	var_00 = getaiarray();
	common_scripts\utility::func_F1B(var_00,::func_654F);
}

//Function Number: 71
func_654F()
{
	self.var_65C2 = undefined;
}

//Function Number: 72
func_39C5(param_00)
{
	if(isdefined(self.team) && !isdefined(param_00))
	{
		param_00 = self.team;
	}

	return level.color_teams[param_00];
}