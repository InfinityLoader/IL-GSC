/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\_noder.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: Console
 * Function Count: 77
 * Decompile Time: 1362 ms
 * Timestamp: 10/27/2023 2:34:11 AM
*******************************************************************/

//Function Number: 1
main(param_00)
{
	if(!getdvarint("noder"))
	{
		return;
	}

	level.drone_paths = [];
	level.scr_anim["generic"]["node_cover_left"][0] = %cornercrl_reloada;
	level.scr_anim["generic"]["node_cover_left"][1] = %cornercrl_look_fast;
	level.scr_anim["generic"]["node_cover_left"][2] = %corner_standl_grenade_b;
	level.scr_anim["generic"]["node_cover_left"][3] = %corner_standl_flinch;
	level.scr_anim["generic"]["node_cover_left"][4] = %corner_standl_look_idle;
	level.scr_anim["generic"]["node_cover_left"][5] = %corner_standl_look_2_alert;
	level.scr_anim["generic"]["node_cover_right"][0] = %cornercrr_reloada;
	level.scr_anim["generic"]["node_cover_right"][1] = %corner_standr_grenade_b;
	level.scr_anim["generic"]["node_cover_right"][2] = %corner_standr_flinch;
	level.scr_anim["generic"]["node_cover_right"][3] = %corner_standr_look_idle;
	level.scr_anim["generic"]["node_cover_right"][4] = %corner_standr_look_2_alert;
	level.scr_anim["generic"]["node_cover_crouch"][0] = %covercrouch_hide_idle;
	level.scr_anim["generic"]["node_cover_crouch"][1] = %covercrouch_twitch_1;
	level.scr_anim["generic"]["node_cover_crouch"][2] = %covercrouch_hide_2_aim;
	level.scr_anim["generic"]["node_cover_crouch"][3] = %covercrouch_hide_2_aim;
	level.scr_anim["generic"]["node_cover_crouch"][4] = %covercrouch_hide_2_aim;
	level.scr_anim["generic"]["node_cover_crouch"][5] = %covercrouch_hide_look;
	level.scr_anim["generic"]["node_cover_crouch_window"][0] = %covercrouch_hide_idle;
	level.scr_anim["generic"]["node_cover_crouch_window"][1] = %covercrouch_twitch_1;
	level.scr_anim["generic"]["node_cover_crouch_window"][2] = %covercrouch_hide_2_aim;
	level.scr_anim["generic"]["node_cover_crouch_window"][3] = %covercrouch_hide_2_aim;
	level.scr_anim["generic"]["node_cover_crouch_window"][4] = %covercrouch_hide_2_aim;
	level.scr_anim["generic"]["node_cover_crouch_window"][5] = %covercrouch_hide_look;
	level.scr_anim["generic"]["node_cover_prone"][0] = %crouch_2_prone_firing;
	level.scr_anim["generic"]["node_cover_prone"][1] = %prone_2_crouch;
	level.scr_anim["generic"]["node_cover_prone"][2] = %prone_reload;
	level.scr_anim["generic"]["node_cover_stand"][0] = %coverstand_reloada;
	level.scr_anim["generic"]["node_concealment_crouch"][0] = %covercrouch_hide_idle;
	level.scr_anim["generic"]["node_concealment_crouch"][1] = %covercrouch_twitch_1;
	level.scr_anim["generic"]["node_concealment_crouch"][2] = %covercrouch_hide_2_aim;
	level.scr_anim["generic"]["node_concealment_crouch"][3] = %covercrouch_hide_2_aim;
	level.scr_anim["generic"]["node_concealment_crouch"][4] = %covercrouch_hide_2_aim;
	level.scr_anim["generic"]["node_concealment_crouch"][5] = %covercrouch_hide_look;
	level.scr_anim["generic"]["node_concealment_prone"][0] = %crouch_2_prone_firing;
	level.scr_anim["generic"]["node_concealment_prone"][1] = %prone_2_crouch;
	level.scr_anim["generic"]["node_concealment_prone"][2] = %prone_reload;
	level.scr_anim["generic"]["node_concealment_stand"][0] = %coverstand_reloada;
	level.node_offset = [];
	level.node_offset["node_cover_left"] = (0,90,0);
	level.node_offset["node_cover_right"] = (0,-90,0);
	level.node_offset["node_pathnode"] = (0,0,0);
	level.node_offset["node_cover_crouch"] = (0,0,0);
	level.node_offset["node_cover_crouch_window"] = (0,0,0);
	level.node_offset["node_cover_prone"] = (0,0,0);
	level.node_offset["node_cover_stand"] = (0,0,0);
	level.node_offset["node_concealment_crouch"] = (0,0,0);
	level.node_offset["node_concealment_prone"] = (0,0,0);
	level.node_offset["node_concealment_stand"] = (0,0,0);
	level.var_16E2 = 0;
	level.dronestruct = [];
	var_01 = getspawnerarray();
	level.dummyguy_index_max = 0;
	level.dummyguy = [];
	if(var_01.size)
	{
		var_02 = var_01[0];
		var_02 maps\_spawner::dronespawner_init();
		for(var_03 = 0;var_03 < 20;var_03++)
		{
			level.dummyguy[var_03] = maps\_spawner::func_16E7(var_02);
			level.dummyguy[var_03] notsolid();
			level.dummyguy[var_03] hide();
			level.dummyguy[var_03].dontdonotetracks = 1;
			level.dummyguy[var_03].dummyguyindex = var_03;
			level.dummynode[var_03] = spawn("script_origin",(0,0,0));
			level.dummynode[var_03].dummynode = 1;
			level.dummyguy_index_max++;
		}
	}

	level.var_16EA = 0;
	maps\_anim::init();
	var_04 = getentarray();
	foreach(var_06 in var_04)
	{
		if((isdefined(var_06.classname) && var_06.classname == "player") || isdefined(var_06.dontdonotetracks) || isdefined(var_06.dummynode))
		{
			continue;
		}

		if(isdefined(var_06))
		{
			var_06 delete();
		}
	}

	var_04 = undefined;
	level.place_node_radius = 64;
	level.place_node_group = [];
	level.var_16ED = "node_pathnode";
	level.placed_nodes = [];
	level.noder_heightoffset = (0,0,32);
	level.wall_look = 0;
	level.node_grid = 256;
	level.coliding_node = undefined;
	level.node_select_locked = 0;
	level.node_animation_preview = 1;
	add_node_type("node_pathnode",undefined);
	add_node_type("node_cover_crouch");
	add_node_type("node_cover_crouch_window");
	add_node_type("node_cover_left",-1);
	add_node_type("node_cover_right",1);
	add_node_type("node_cover_prone");
	add_node_type("node_cover_stand");
	add_node_type("node_concealment_crouch");
	add_node_type("node_concealment_prone");
	add_node_type("node_concealment_stand");
	thread hack_start();
	thread func_16CA();
	thread noder_init();
	common_scripts\utility::flag_wait("user_hud_active");
	thread func_1731();
	thread manage_nearnodes();
	level.drone_paths = [];
	var_08 = getallnodes();
	if(var_08.size)
	{
		level.player setorigin(maps\_utility::getclosest(level.player.origin,var_08).origin);
	}

	for(;;)
	{
		wait 0.05;
		level.player_view_trace = player_view_trace();
		func_1713(1);
	}
}

//Function Number: 2
hack_start()
{
	common_scripts\utility::flag_init("user_alive");
	while(!isdefined(get_mp_player()))
	{
		wait 0.05;
	}

	wait 0.05;
	level.noder_player = get_mp_player();
	level.noder_player takeallweapons();
	level.noder_player allowcrouch(0);
	level.noder_player allowjump(0);
	level.noder_player allowprone(0);
	common_scripts\utility::flag_set("user_alive");
}

//Function Number: 3
noder_init()
{
	level.preview_node = spawn("script_model",(0,0,0));
	precachemodel("node_preview");
	level.preview_node setmodel("node_preview");
	level.preview_node notsolid();
	level.selector_model = spawn("script_model",(0,0,0));
	level.selector_model setmodel("node_select");
	level.selector_model notsolid();
	level.selector_model hide();
	level.selected_node = undefined;
	setcurrentgroup(level.var_16ED);
	level.var_16ED = undefined;
	playerinit();
}

//Function Number: 4
hud_update_placed_model_count()
{
	level.hud_noder["helppm"].var_16D0 setvalue(level.placed_nodes.size);
	var_00 = 256;
	if(level.placed_nodes.size < var_00)
	{
		level.hud_noder["helppm"].var_16D0.color = (1,1,1);
		return;
	}

	var_01 = 1;
	var_02 = 1 - level.placed_nodes.size - var_00 / var_00;
	var_03 = var_02;
	level.hud_noder["helppm"].var_16D0.color = (var_01,var_02,var_03);
}

//Function Number: 5
controler_hud_add(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = 520;
	var_06 = 120;
	var_07 = 18;
	var_08 = 0.8;
	var_09 = 20;
	var_0A = 1.4;
	if(!isdefined(level.hud_noder) || !isdefined(level.hud_noder[param_00]))
	{
		level.hud_noder[param_00] = _newhudelem();
		var_0B = _newhudelem();
	}
	else
	{
		var_0B = level.hud_noder[param_01].var_16D0;
	}

	level.hud_noder[param_00].location = 0;
	level.hud_noder[param_00].alignx = "right";
	level.hud_noder[param_00].aligny = "middle";
	level.hud_noder[param_00].foreground = 1;
	level.hud_noder[param_00].fontscale = 1.5;
	level.hud_noder[param_00].sort = 20;
	level.hud_noder[param_00].alpha = var_08;
	level.hud_noder[param_00].x = var_05 + var_09;
	level.hud_noder[param_00].y = var_06 + param_01 * var_07;
	level.hud_noder[param_00] _settext(param_02);
	var_0B.location = 0;
	var_0B.alignx = "left";
	var_0B.aligny = "middle";
	var_0B.foreground = 1;
	var_0B.fontscale = var_0A;
	var_0B.sort = 20;
	var_0B.alpha = var_08;
	var_0B.x = var_05 + var_09;
	var_0B.y = var_06 + param_01 * var_07;
	if(isdefined(param_04))
	{
		var_0B setvalue(param_04);
	}

	if(isdefined(param_03))
	{
		var_0B _settext(param_03);
	}

	level.hud_noder[param_00].var_16D0 = var_0B;
}

//Function Number: 6
func_16CA()
{
	common_scripts\utility::flag_init("user_hud_active");
	common_scripts\utility::flag_wait("user_alive");
	var_00 = 17;
	var_01 = [];
	var_02 = 15;
	var_03 = int(var_00 / 2);
	var_04 = 240 + var_03 * var_02;
	var_05 = 0.7 / var_03;
	var_06 = var_05;
	for(var_07 = 0;var_07 < var_00;var_07++)
	{
		var_01[var_07] = _newhudelem();
		var_01[var_07].location = 0;
		var_01[var_07].alignx = "left";
		var_01[var_07].aligny = "middle";
		var_01[var_07].foreground = 1;
		var_01[var_07].fontscale = 2;
		var_01[var_07].sort = 20;
		if(var_07 == var_03)
		{
			var_01[var_07].alpha = 1;
		}
		else
		{
			var_01[var_07].alpha = var_06;
		}

		var_01[var_07].x = 0;
		var_01[var_07].y = var_04;
		var_01[var_07] _settext(".");
		if(var_07 == var_03)
		{
			var_05 = var_05 * -1;
		}

		var_06 = var_06 + var_05;
		var_04 = var_04 - var_02;
	}

	level.group_hudelems = var_01;
	var_08 = _newhudelem();
	var_08.location = 0;
	var_08.alignx = "left";
	var_08.aligny = "bottom";
	var_08.foreground = 1;
	var_08.fontscale = 2;
	var_08.sort = 20;
	var_08.alpha = 1;
	var_08.x = 320;
	var_08.y = 244;
	var_08 _settext(".");
	level.var_16CC = var_08;
	var_08 = _newhudelem();
	var_08.location = 0;
	var_08.alignx = "center";
	var_08.aligny = "bottom";
	var_08.foreground = 1;
	var_08.fontscale = 2;
	var_08.sort = 20;
	var_08.alpha = 0;
	var_08.x = 320;
	var_08.y = 244;
	var_08 setvalue(0);
	level.crosshair_value = var_08;
	var_09 = _newhudelem();
	var_09.location = 0;
	var_09.alignx = "center";
	var_09.aligny = "bottom";
	var_09.foreground = 1;
	var_09.fontscale = 2;
	var_09.sort = 20;
	var_09.alpha = 1;
	var_09.x = 320;
	var_09.y = 300;
	var_09 _settext("");
	level.selection_lock_indicator = var_09;
	var_0A = _newhudelem();
	var_0A.location = 0;
	var_0A.alignx = "center";
	var_0A.aligny = "bottom";
	var_0A.foreground = 1;
	var_0A.fontscale = 2;
	var_0A.sort = 20;
	var_0A.alpha = 1;
	var_0A.x = 320;
	var_0A.y = 300;
	var_0A _settext("");
	level.node_animation_preview_indicator = var_0A;
	var_0B = 550;
	var_0C = 120;
	var_0D = 18;
	var_0E = 1;
	var_0F = 0.8;
	var_10 = 20;
	var_11 = 1.4;
	controler_hud_add("helppm",1,"^5Placed Nodes: ",undefined,level.placed_nodes.size);
	controler_hud_add("gridsize",2,"^5Grid Size: ",undefined,level.node_grid);
	controler_hud_add("helpxy",6,"^4X/^3Y: ",undefined,level.place_node_radius);
	controler_hud_add("helpab",7,"^2A/^1B^7: ","-");
	controler_hud_add("helplsrs",8,"^8L^7/R Stick: ","-");
	controler_hud_add("helplbrb",9,"^8L^7/R Shoulder: ","-");
	controler_hud_add("helpdpu",10,"^8DPad U/^7D: ","-");
	controler_hud_add("helpdpl",11,"^8DPad L/^7R: ","-");
	controler_hud_add("helpF",17,"^8W: ","-");
	level.hud_noder["helpF"].x = var_0B - 450;
	level.hud_noder["helpF"].var_16D0.x = var_0B - 450;
	hint_buttons_main();
	common_scripts\utility::flag_set("user_hud_active");
}

//Function Number: 7
controler_hud_update_text(param_00,param_01)
{
	level.hud_noder[param_00].var_16D0 _settext(param_01);
}

//Function Number: 8
controler_hud_update_button(param_00,param_01)
{
	level.hud_noder[param_00] _settext(param_01);
}

//Function Number: 9
setcurrentgroup(param_00)
{
	common_scripts\utility::flag_wait("user_hud_active");
	level.place_node_current_group = param_00;
	var_01 = getarraykeys(level.place_node_group);
	var_02 = 0;
	var_03 = int(level.group_hudelems.size / 2);
	for(var_04 = 0;var_04 < var_01.size;var_04++)
	{
		if(var_01[var_04] == param_00)
		{
			var_02 = var_04;
			break;
		}
	}

	for(var_04 = 0;var_04 < level.group_hudelems.size;var_04++)
	{
		level.group_hudelems[var_04] clearalltextafterhudelem();
	}

	level.group_hudelems[var_03] _settext("^3" + func_171D(var_01[var_02]));
	for(var_04 = 1;var_04 < level.group_hudelems.size - var_03;var_04++)
	{
		if(var_02 - var_04 < 0)
		{
			level.group_hudelems[var_03 + var_04] _settext("-- --");
			continue;
		}

		level.group_hudelems[var_03 + var_04] _settext(func_171D(var_01[var_02 - var_04]));
	}

	for(var_04 = 1;var_04 < level.group_hudelems.size - var_03;var_04++)
	{
		if(var_02 + var_04 > var_01.size - 1)
		{
			level.group_hudelems[var_03 - var_04] _settext("-- --");
			continue;
		}

		level.group_hudelems[var_03 - var_04] _settext(func_171D(var_01[var_02 + var_04]));
	}

	param_00 = getcurrent_groupstruct();
	level.node_grid = param_00.grid_size;
	hud_update_gridsize();
}

//Function Number: 10
setgroup_up()
{
	var_00 = undefined;
	var_01 = getarraykeys(level.place_node_group);
	for(var_02 = 0;var_02 < var_01.size;var_02++)
	{
		if(var_01[var_02] == level.place_node_current_group)
		{
			var_00 = var_02 + 1;
			break;
		}
	}

	if(var_00 == var_01.size)
	{
		var_00 = 0;
	}

	setcurrentgroup(var_01[var_00]);
}

//Function Number: 11
setgroup_down()
{
	var_00 = undefined;
	var_01 = getarraykeys(level.place_node_group);
	for(var_02 = 0;var_02 < var_01.size;var_02++)
	{
		if(var_01[var_02] == level.place_node_current_group)
		{
			var_00 = var_02 - 1;
			break;
		}
	}

	if(var_00 < 0)
	{
		var_00 = var_01.size - 1;
	}

	setcurrentgroup(var_01[var_00]);
}

//Function Number: 12
add_node_type(param_00,param_01,param_02)
{
	if(!isdefined(param_01))
	{
		param_01 = 0;
	}

	if(!isdefined(param_02))
	{
		param_02 = 0;
	}

	precachemodel(param_00);
	if(!isdefined(level.place_node_group[param_00]))
	{
		var_03 = spawnstruct();
		var_03.wall_snap_direction = param_01;
		var_03.grid_size = param_02;
		level.place_node_group[param_00] = var_03;
	}

	level.place_node_group[param_00].model = param_00;
}

//Function Number: 13
playerinit()
{
	level.var_1706 = 950;
	common_scripts\utility::flag_wait("user_hud_active");
	level.noder_player takeallweapons();
	level.var_1707 = [];
	level.var_1708 = [];
	level.noder_player thread button_monitor();
	level.noder_player thread button_modifier();
	set_button_funcs_main();
	add_button_modifier_func(::set_button_funcs_quick_select,::func_1744,"BUTTON_LSTICK");
}

//Function Number: 14
button_modifier()
{
	for(;;)
	{
		foreach(var_02, var_01 in level.var_1707)
		{
			if(self buttonpressed(var_02))
			{
				[[ level.var_1707[var_02] ]]();
				while(self buttonpressed(var_02))
				{
					wait 0.05;
				}

				[[ level.button_modifier_release_func[var_02] ]]();
				wait 0.05;
			}
		}

		wait 0.05;
	}
}

//Function Number: 15
button_monitor()
{
	for(;;)
	{
		foreach(var_02, var_01 in level.var_1708)
		{
			if(self buttonpressed(var_02))
			{
				[[ level.var_1708[var_02] ]]();
				if(!level.button_func_isflow[var_02])
				{
					while(self buttonpressed(var_02))
					{
						wait 0.05;
					}
				}

				break;
			}
		}

		wait 0.05;
	}
}

//Function Number: 16
add_button_func(param_00,param_01,param_02)
{
	var_03 = [];
	level.var_1708[param_02] = param_00;
	level.button_func_isflow[param_02] = param_01;
}

//Function Number: 17
add_button_modifier_func(param_00,param_01,param_02)
{
	level.var_1707[param_02] = param_00;
	level.button_modifier_release_func[param_02] = param_01;
}

//Function Number: 18
deleteme()
{
	self delete();
}

//Function Number: 19
getcurrent_groupstruct()
{
	return level.place_node_group[level.place_node_current_group];
}

//Function Number: 20
get_wall_offset(param_00)
{
	var_01 = level.player_view_trace;
	var_02 = var_01["position"];
	var_03 = 16 * vectornormalize(var_01["normal"]);
	var_04 = var_02 + var_03;
	var_05 = find_corner_snap(var_04,param_00);
	if(isdefined(var_05))
	{
		var_04 = var_05;
	}

	return groundpos_loc(var_04) + level.noder_heightoffset;
}

//Function Number: 21
find_corner_snap(param_00,param_01)
{
	var_02 = getcurrent_groupstruct();
	var_03 = var_02.wall_snap_direction;
	if(var_03 == 0)
	{
		return;
	}

	var_04 = param_00;
	var_05 = var_04;
	var_06 = 32;
	var_07 = 16 * var_03 * vectornormalize(anglestoright(param_01));
	var_08 = 1;
	while(var_08 < 15)
	{
		var_04 = var_05;
		param_00 = var_04;
		var_09 = var_08 * var_06 * var_03 * vectornormalize(anglestoright(param_01));
		var_0A = bullettrace_but_not_nodes(param_00,param_00 + var_09,0);
		param_00 = param_00 + var_0A["fraction"] * var_09;
		if(var_0A["fraction"] < 1)
		{
			continue;
		}
		else
		{
		}

		var_04 = param_00;
		var_0B = 32 * vectornormalize(anglestoforward(param_01));
		var_0A = bullettrace_but_not_nodes(param_00,param_00 + var_0B,0);
		var_0C = var_0A["fraction"];
		if(var_0A["fraction"] == 1)
		{
			var_0C = 0.51;
		}

		param_00 = param_00 + var_0C * var_0B;
		if(var_0A["fraction"] < var_0C)
		{
			continue;
		}
		else
		{
		}

		var_04 = param_00;
		var_0D = var_09 * -1 - var_07;
		var_0A = bullettrace_but_not_nodes(param_00,param_00 + var_0D,0);
		param_00 = param_00 + var_0A["fraction"] * var_0D;
		if(var_0A["fraction"] > 0.99)
		{
			continue;
		}
		else
		{
		}

		var_0E = param_00;
		var_0F = var_0E + var_07 * -1 + var_0B * var_0C * -1;
		var_10 = var_0F + var_07 * 0.9;
		var_0A = bullettrace_but_not_nodes(var_10,var_10 + var_0B * 0.5,0);
		if(var_0A["fraction"] < 1)
		{
			var_0F = var_0A["position"] - var_0B * 0.5 + var_07 * -0.9;
		}

		return var_0F;
		var_0B++;
	}

	return undefined;
}

//Function Number: 22
func_1713(param_00)
{
	if(!isdefined(param_00))
	{
		param_00 = 0;
	}

	var_01 = level.player_view_trace;
	var_02 = common_scripts\utility::flat_angle(level.player getplayerangles());
	var_03 = var_01["position"] + level.noder_heightoffset;
	if(var_01["fraction"] == 1 || level.placed_nodes.size > level.var_1706)
	{
		level.preview_node hide();
		return;
	}

	if(is_player_looking_at_a_wall())
	{
		level.preview_node dontinterpolate();
		var_02 = vectortoangles(-1 * var_01["normal"]);
		var_03 = get_wall_offset(var_02);
	}
	else if(level.node_grid)
	{
		level.preview_node dontinterpolate();
		var_03 = func_1721(var_03);
		func_1723(var_03,param_00);
		var_02 = (0,0,0);
	}

	if(func_1725(var_03))
	{
		level.preview_node hide();
		select_coliding_node();
		return;
	}
	else if(node_is_touching(var_03))
	{
		select_coliding_node();
	}
	else
	{
		func_1730();
		level.preview_node show();
	}

	draw_lines_to_connectible_nodes(var_03);
	func_1714(var_03,var_02,param_00);
}

//Function Number: 23
func_1714(param_00,param_01,param_02)
{
	var_03 = getcurrent_groupstruct();
	if(param_02)
	{
		var_04 = level.preview_node;
		var_04.origin = param_00;
	}
	else
	{
		var_04 = spawn("script_model",param_01);
	}

	var_04 notsolid();
	if(!param_02)
	{
		var_04 setmodel(var_03.model);
	}

	var_04.angles = param_01;
	if(var_03.model == "node_pathnode")
	{
		var_04.angles = (0,0,0);
	}

	if(!param_02)
	{
		place_new_dummy_guy_and_animate_at_node(var_04);
		level.placed_nodes[level.placed_nodes.size] = var_04;
	}

	hud_update_placed_model_count();
}

//Function Number: 24
place_node_place_at_feet()
{
	var_00 = common_scripts\utility::flat_angle(level.noder_player getplayerangles());
	var_01 = groundpos_loc(level.noder_player.origin + (0,0,16)) + level.noder_heightoffset;
	if(func_1725(var_01))
	{
		return;
	}

	func_1714(var_01,var_00,0);
	hud_update_placed_model_count();
}

//Function Number: 25
get_mp_player()
{
	return getentarray("player","classname")[0];
}

//Function Number: 26
func_1717()
{
	var_00 = undefined;
	if(isdefined(level.selected_node))
	{
		var_00 = level.selected_node;
	}

	if(isdefined(level.player_view_trace["entity"]))
	{
		var_00 = level.player_view_trace["entity"];
		if(!issubstr(var_00.model,"node_"))
		{
			var_00 = undefined;
		}
	}

	if(!isdefined(var_00))
	{
		return;
	}

	level.var_1718 = common_scripts\utility::array_remove(level.var_1718,var_00);
	level.placed_nodes = common_scripts\utility::array_remove(level.placed_nodes,var_00);
	if(isdefined(var_00.has_dummy_guy))
	{
		var_00.has_dummy_guy hide();
		var_00.has_dummy_guy.is_hidden = 1;
	}

	var_00 delete();
	level.var_16E2 = 1;
	hud_update_placed_model_count();
}

//Function Number: 27
dump_nodes()
{
}

//Function Number: 28
player_view_trace()
{
	var_00 = 2000;
	var_01 = level.noder_player geteye();
	return bullettrace(var_01,var_01 + anglestoforward(level.noder_player getplayerangles()) * var_00,0,level.preview_node);
}

//Function Number: 29
is_player_looking_at_a_wall()
{
	if(!isdefined(level.player_view_trace["normal"]))
	{
		return 0;
	}

	if(traces_hitting_node(level.player_view_trace))
	{
		return 0;
	}

	var_00 = vectortoangles(level.player_view_trace["normal"]);
	var_01 = common_scripts\utility::flat_angle(var_00);
	if(vectordot(anglestoforward(var_01),anglestoforward(var_00)) == 1)
	{
		return 1;
	}

	return 0;
}

//Function Number: 30
func_171D(param_00)
{
	var_01 = "";
	for(var_02 = 5;var_02 < param_00.size;var_02++)
	{
		var_01 = var_01 + param_00[var_02];
	}

	return var_01;
}

//Function Number: 31
bullettrace_but_not_nodes(param_00,param_01,param_02,param_03)
{
	var_04 = bullettrace(param_00,param_01,param_02,param_03);
	if(traces_hitting_node(var_04))
	{
		var_04 = bullettrace(param_00,param_01,param_02,var_04["entity"]);
	}

	return var_04;
}

//Function Number: 32
traces_hitting_node(param_00)
{
	return isdefined(param_00["entity"]) && isdefined(param_00["entity"].model) && issubstr(param_00["entity"].model,"node_");
}

//Function Number: 33
groundpos_loc(param_00,param_01)
{
	if(!isdefined(param_01))
	{
		param_01 = -100000;
	}

	return bullettrace_but_not_nodes(param_00,param_00 + (0,0,param_01),0,self)["position"];
}

//Function Number: 34
func_1721(param_00)
{
	var_01 = level.node_grid;
	var_02 = snap_number_to_nearest_grid(param_00[0],var_01);
	var_03 = snap_number_to_nearest_grid(param_00[1],var_01);
	return groundpos_loc((var_02,var_03,param_00[2] + 32)) + level.noder_heightoffset;
}

//Function Number: 35
snap_number_to_nearest_grid(param_00,param_01)
{
	var_02 = param_00 / param_01;
	var_03 = int(var_02);
	var_04 = var_02 - var_03;
	if(var_04 < -0.5)
	{
		var_03--;
	}
	else if(var_04 > 0.5)
	{
		var_03++;
	}

	return var_03 * param_01;
}

//Function Number: 36
func_1723(param_00,param_01)
{
	var_02 = 1;
	var_03 = (0,1,0);
	param_00 = groundpos_loc(param_00);
	var_04 = param_00 + (0,0,level.node_grid);
	for(var_05 = var_02 * -1;var_05 < var_02 + 1;var_05++)
	{
		for(var_06 = var_02 * -1;var_06 < var_02 + 1;var_06++)
		{
			if(var_05 != var_02)
			{
			}

			if(var_06 != var_02)
			{
			}
		}
	}
}

//Function Number: 37
func_1724(param_00,param_01,param_02,param_03)
{
	var_04 = level.node_grid * -2;
	param_00 = groundpos_loc(param_00,var_04);
	param_01 = groundpos_loc(param_01,var_04);
}

//Function Number: 38
func_1725(param_00)
{
	var_01 = 0;
	var_02 = 68;
	var_03 = undefined;
	foreach(var_05 in level.placed_nodes)
	{
		var_06 = distance(param_00,var_05.origin);
		if(var_06 < 32)
		{
			var_01++;
			if(var_06 < 0.05)
			{
				var_01 = 6;
			}

			if(var_06 < var_02)
			{
				var_03 = var_05;
			}
		}
	}

	if(!isdefined(var_03))
	{
		return 0;
	}

	level.coliding_node = var_03;
	if(var_01 >= 2)
	{
		return 1;
	}

	return 0;
}

//Function Number: 39
node_is_touching(param_00)
{
	foreach(var_02 in level.placed_nodes)
	{
		if(distance(param_00,var_02.origin) < 32)
		{
			level.coliding_node = var_02;
			return 1;
		}
	}

	return 0;
}

//Function Number: 40
hud_update_gridsize()
{
	var_00 = "^7";
	if(level.node_grid != 0)
	{
		var_00 = "^1";
	}

	level.hud_noder["gridsize"].var_16D0 _settext(var_00 + level.node_grid);
}

//Function Number: 41
grid_up()
{
	if(!level.node_grid)
	{
		level.node_grid = 64;
	}

	level.node_grid = level.node_grid * 2;
	if(level.node_grid > 256)
	{
		level.node_grid = 256;
	}

	hud_update_gridsize();
}

//Function Number: 42
grid_down()
{
	if(!level.node_grid)
	{
		return;
	}

	level.node_grid = level.node_grid * 0.5;
	if(level.node_grid < 64)
	{
		level.node_grid = 0;
	}

	hud_update_gridsize();
}

//Function Number: 43
grid_toggle()
{
	if(level.node_grid == 256)
	{
		level.node_grid = 0;
	}
	else
	{
		level.node_grid = 256;
	}

	hud_update_gridsize();
}

//Function Number: 44
select_traced_node(param_00)
{
	select_node(param_00["entity"]);
}

//Function Number: 45
select_node(param_00)
{
	if(level.node_select_locked && isdefined(level.selected_node))
	{
		return;
	}

	place_new_dummy_guy_and_animate_at_node(param_00);
	level.selector_model dontinterpolate();
	level.selector_model.origin = param_00.origin;
	level.selector_model.angles = param_00.angles;
	level.selector_model show();
	level.selected_node = param_00;
}

//Function Number: 46
place_new_dummy_guy_and_animate_at_node(param_00)
{
	if(!level.dummyguy.size || isdefined(param_00.has_dummy_guy) || !node_has_animations(param_00))
	{
		return;
	}

	var_01 = fifo_dummyguy();
	if(isdefined(var_01.lastnode))
	{
		var_01.lastnode.has_dummy_guy = undefined;
	}

	var_01 thread func_1746(param_00);
}

//Function Number: 47
select_coliding_node()
{
	select_node(level.coliding_node);
}

//Function Number: 48
func_1730()
{
	if(level.node_select_locked && isdefined(level.selected_node))
	{
		return;
	}

	level.selector_model hide();
	level.selected_node = undefined;
}

//Function Number: 49
func_1731()
{
	for(;;)
	{
		if(!isdefined(level.selected_node))
		{
			wait 0.05;
			continue;
		}

		var_00 = level.selected_node.model;
		var_01 = anglestoright(level.player getplayerangles()) * var_00.size * -3;
		thread maps\_utility::debug_message(var_00,level.selected_node.origin + var_01,0.05);
		wait 0.05;
	}
}

//Function Number: 50
func_1733()
{
	if(level.node_select_locked)
	{
		level.selection_lock_indicator _settext("");
		level.node_select_locked = 0;
		return;
	}

	level.selection_lock_indicator _settext("^1Selection Lock On");
	level.node_select_locked = 1;
}

//Function Number: 51
set_button_funcs_main()
{
	clear_all_button_funcs();
	add_button_func(::dump_nodes,0,"w");
	add_button_func(::func_1717,0,"BUTTON_LSHLDR");
	add_button_func(::func_1713,0,"BUTTON_RSHLDR");
	add_button_func(::place_node_place_at_feet,0,"BUTTON_RSTICK");
	add_button_func(::setgroup_down,0,"BUTTON_X");
	add_button_func(::setgroup_up,0,"BUTTON_Y");
	add_button_func(::setgroup_down,0,"DPAD_UP");
	add_button_func(::setgroup_up,0,"DPAD_DOWN");
	add_button_func(::grid_toggle,0,"BUTTON_A");
	add_button_func(::toggle_animation_preview,0,"BUTTON_B");
}

//Function Number: 52
clear_all_button_funcs()
{
	level.var_1708 = [];
	level.button_func_isflow = [];
}

//Function Number: 53
func_1736()
{
	clear_all_button_funcs();
	add_button_func(::dump_nodes,0,"w");
	add_button_func(::select_node_cover_left,0,"BUTTON_LSHLDR");
	add_button_func(::select_node_cover_right,0,"BUTTON_RSHLDR");
	add_button_func(::select_node_pathnode,0,"BUTTON_LTRIG");
	add_button_func(::select_node_pathnode,0,"BUTTON_RTRIG");
	add_button_func(::select_node_pathnode,0,"BUTTON_RSTICK");
	add_button_func(::func_173B,0,"BUTTON_X");
	add_button_func(::select_node_cover_prone,0,"BUTTON_Y");
	add_button_func(::select_node_concealment_stand,0,"DPAD_UP");
	add_button_func(::select_node_concealment_prone,0,"DPAD_DOWN");
	add_button_func(::func_173E,0,"DPAD_RGIHT");
	add_button_func(::func_173D,0,"BUTTON_A");
	add_button_func(::select_node_cover_crouch,0,"BUTTON_B");
}

//Function Number: 54
func_1737()
{
	controler_hud_update_text("helpxy","^4Cover Crouch Window ^7/ ^3Prone");
	controler_hud_update_text("helpab","^2Cover Stand ^7/ ^1Crouch");
	controler_hud_update_text("helplsrs","^8 - ^7/ Pathnode");
	controler_hud_update_text("helplbrb","^8Cover Left ^7/ Right");
	controler_hud_update_text("helpdpl","^8Conceal - ^7/ Crouch");
	controler_hud_update_text("helpdpu","^8Conceal Stand ^7/ Prone");
}

//Function Number: 55
hint_buttons_main()
{
	controler_hud_update_text("helpxy","^4Node Type Up ^7/ ^3Down");
	controler_hud_update_text("helpab","^2Toggle Grid ^7/ ^1Anim Preview ");
	controler_hud_update_text("helplsrs","^8Quick Pick ^7/ Place at Player");
	controler_hud_update_text("helplbrb","^8Remove ^7/ Place");
	controler_hud_update_text("helpdpl","^8- ^7/ -");
	controler_hud_update_text("helpdpu","^8Node Type Up ^7/ Down");
	var_00 = "( dump ) ^3map_source / xenon_export/" + level.script + "_nodedump.map";
	controler_hud_update_text("helpF",var_00);
}

//Function Number: 56
select_node_cover_crouch()
{
	setcurrentgroup("node_cover_crouch");
}

//Function Number: 57
select_node_pathnode()
{
	setcurrentgroup("node_pathnode");
}

//Function Number: 58
func_173B()
{
	setcurrentgroup("node_cover_crouch_window");
}

//Function Number: 59
select_node_cover_prone()
{
	setcurrentgroup("node_cover_prone");
}

//Function Number: 60
func_173D()
{
	setcurrentgroup("node_cover_stand");
}

//Function Number: 61
func_173E()
{
	setcurrentgroup("node_concealment_crouch");
}

//Function Number: 62
select_node_concealment_prone()
{
	setcurrentgroup("node_concealment_prone");
}

//Function Number: 63
select_node_concealment_stand()
{
	setcurrentgroup("node_concealment_stand");
}

//Function Number: 64
select_node_cover_left()
{
	setcurrentgroup("node_cover_left");
}

//Function Number: 65
select_node_cover_right()
{
	setcurrentgroup("node_cover_right");
}

//Function Number: 66
set_button_funcs_quick_select()
{
	clear_all_button_funcs();
	func_1736();
	func_1737();
}

//Function Number: 67
func_1744()
{
	set_button_funcs_main();
	hint_buttons_main();
}

//Function Number: 68
_newhudelem()
{
	if(!isdefined(level.noder_elems))
	{
		level.noder_elems = [];
	}

	var_00 = newhudelem();
	level.noder_elems[level.noder_elems.size] = var_00;
	return var_00;
}

//Function Number: 69
_settext(param_00)
{
	self.realtext = param_00;
	foreach(var_02 in level.noder_elems)
	{
		if(isdefined(var_02.realtext))
		{
			var_02 settext(var_02.realtext);
		}
	}
}

//Function Number: 70
func_1746(param_00)
{
	var_01 = param_00.origin + (0,0,-32);
	var_02 = param_00.angles + level.node_offset[param_00.model];
	param_00.has_dummy_guy = self;
	self.lastnode = param_00;
	level.dummynode[self.dummyguyindex] notify("stop_loop");
	level.dummynode[self.dummyguyindex].origin = var_01;
	level.dummynode[self.dummyguyindex].angles = var_02;
	level.dummynode[self.dummyguyindex] dontinterpolate();
	self dontinterpolate();
	self show();
	self.is_hidden = 0;
	level.dummynode[self.dummyguyindex] maps\_anim::anim_generic_loop(self,param_00.model);
}

//Function Number: 71
fifo_dummyguy()
{
	level.var_16EA++;
	if(level.var_16EA == level.dummyguy_index_max)
	{
		level.var_16EA = 0;
	}

	var_00 = level.dummyguy[level.var_16EA];
	return var_00;
}

//Function Number: 72
node_has_animations(param_00)
{
	if(isdefined(level.scr_anim["generic"][param_00.model]))
	{
		return 1;
	}

	return 0;
}

//Function Number: 73
toggle_animation_preview()
{
	if(level.node_animation_preview)
	{
		level.node_animation_preview_indicator _settext("^1Anim Preview Off");
		level.node_animation_preview = 0;
		hide_all_dummyguys();
		return;
	}

	level.node_animation_preview_indicator _settext("");
	level.node_animation_preview = 1;
	show_all_dummyguys();
}

//Function Number: 74
hide_all_dummyguys()
{
	foreach(var_01 in level.dummyguy)
	{
		if(!isdefined(var_01.is_hidden) || !var_01.is_hidden)
		{
			var_01 hide();
		}
	}
}

//Function Number: 75
show_all_dummyguys()
{
	foreach(var_01 in level.dummyguy)
	{
		if(!isdefined(var_01.is_hidden) || !var_01.is_hidden)
		{
			var_01 show();
		}
	}
}

//Function Number: 76
draw_lines_to_connectible_nodes(param_00)
{
	foreach(var_02 in level.var_1718)
	{
		if(!isdefined(var_02.classname))
		{
			continue;
		}
	}
}

//Function Number: 77
manage_nearnodes()
{
	level endon("dump_nodes");
	level.var_1718 = [];
	var_00 = getallnodes();
	var_01 = 0;
	var_02 = 1000;
	var_03 = [];
	level.nearnodes_time = 0;
	wait 0.05;
	for(;;)
	{
		var_04 = var_00;
		foreach(var_06 in level.placed_nodes)
		{
			var_04[var_04.size] = var_06;
		}

		var_08 = level.placed_nodes.size;
		foreach(var_06 in var_04)
		{
			var_03[var_03.size] = var_06;
			var_01++;
			if(level.placed_nodes.size != var_08)
			{
				var_03 = [];
				var_01 = 0;
				break;
			}

			if(var_01 > var_02)
			{
				var_0A = [];
				foreach(var_0C in level.var_1718)
				{
					if(distancesquared((level.preview_node.origin[0],level.preview_node.origin[1],0),(var_0C.origin[0],var_0C.origin[1],0)) <= 65536)
					{
						var_0A[var_0A.size] = var_0C;
					}
				}

				var_0E = [];
				foreach(var_10 in var_03)
				{
					if(distancesquared((level.preview_node.origin[0],level.preview_node.origin[1],0),(var_10.origin[0],var_10.origin[1],0)) <= 65536)
					{
						var_0E[var_0E.size] = var_10;
					}
				}

				level.var_1718 = maps\_utility::array_merge(var_0E,var_0A);
				var_03 = [];
				var_01 = 0;
				wait 0.05;
				waittillframeend;
			}

			if(level.var_16E2)
			{
				level.var_16E2 = 0;
				var_03 = [];
				var_01 = 0;
				break;
			}
		}

		wait 0.05;
	}
}