/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\_crib.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: Console
 * Function Count: 36
 * Decompile Time: 573 ms
 * Timestamp: 10/27/2023 2:28:58 AM
*******************************************************************/

//Function Number: 1
init()
{
	precacheshellshock("frag_grenade_mp");
	radial_button_definitions();
	radial_init();
	func_3384();
	func_18B7();
}

//Function Number: 2
radial_button_definitions()
{
	func_3368("main","player_view1_start","player_view1_end");
	var_00 = func_336A("main","Primary Weapon","radial_weapons_primary",::func_337F);
	var_01 = func_336A("main","Secondary Weapon","radial_weapons_secondary",::func_3380);
	var_02 = func_336A("main","Gears","radial_gears",::action_gears);
	var_03 = func_336A("main","Kill Streaks","radial_killstreaks",::func_3382);
	var_04 = func_336A("main","Leaderboards","radial_leaderboards",::func_3383);
	func_3368("gears","player_view2_start","player_view2_end");
	func_3368("weapons_primary","player_view3_start","player_view3_end");
	func_3368("weapons_secondary","player_view3_start","player_view3_end");
	func_3368("killstreak","player_view4_start","player_view4_end");
	func_3368("leaderboards","player_view5_start","player_view5_end");
}

//Function Number: 3
radial_init()
{
	foreach(var_01 in level.radial_button_group)
	{
		func_3374(var_01);
		for(var_02 = 0;var_02 < var_01.size;var_02++)
		{
			if(isdefined(var_01[var_02 + 1]))
			{
				var_03 = getmidangle(var_01[var_02].var_335E,var_01[var_02 + 1].var_335E);
				var_01[var_02].end_angle = var_03;
				var_01[var_02 + 1].var_3360 = var_03;
				continue;
			}

			var_03 = getmidangle(var_01[var_02].var_335E,var_01[0].var_335E) + 180;
			if(var_03 > 360)
			{
				var_03 = var_03 - 360;
			}

			var_01[var_02].end_angle = var_03;
			var_01[0].var_3360 = var_03;
		}
	}

	thread updateselectedbutton();
	thread watchselectbuttonpress();
	thread func_3373();
	thread func_3361();
}

//Function Number: 4
func_3361()
{
	level endon("game_ended");
	level.var_3362 = 1;
	for(;;)
	{
		if(!isdefined(level.observer))
		{
			wait 0.05;
			continue;
		}

		var_00 = 1;
		while(!level.observer buttonpressed("BUTTON_Y"))
		{
			wait 0.05;
		}

		level.observer playsound("mouse_click");
		if(var_00)
		{
			level.var_3362 = level.var_3362 * -1;
			var_00 = 0;
		}

		while(level.observer buttonpressed("BUTTON_Y"))
		{
			wait 0.05;
		}
	}
}

//Function Number: 5
func_18B7()
{
	level thread onplayerconnect();
	level thread func_3364();
}

//Function Number: 6
func_3364()
{
	level waittill("game_ended");
	setdvar("cg_draw2d",1);
}

//Function Number: 7
onplayerconnect()
{
	level waittill("connected",var_00);
	var_00 thread func_3365();
	var_00 waittill("spawned_player");
	wait 1;
	var_00 takeallweapons();
	setdvar("cg_draw2d",0);
	if(!isdefined(var_00))
	{
		return;
	}
	else
	{
		level.observer = var_00;
	}

	var_00 thread func_3366();
	zoom_to_radial_menu("main");
}

//Function Number: 8
func_3365()
{
	self endon("disconnect");
	var_00 = "autoassign";
	while(!isdefined(self.pers["team"]))
	{
		wait 0.05;
	}

	self notify("menuresponse",game["menu_team"],var_00);
	wait 0.5;
	var_01 = getarraykeys(level.classmap);
	var_02 = [];
	for(var_03 = 0;var_03 < var_01.size;var_03++)
	{
		if(!issubstr(var_01[var_03],"custom"))
		{
			var_02[var_02.size] = var_01[var_03];
		}
	}

	for(;;)
	{
		var_04 = var_02[0];
		self notify("menuresponse","changeclass",var_04);
		self waittill("spawned_player");
		wait 0.1;
	}
}

//Function Number: 9
func_3366()
{
	level endon("game_ended");
	self endon("disconnect");
	for(;;)
	{
		var_00 = self getnormalizedmovement();
		var_01 = vectortoangles(var_00);
		level.rs_angle = int(var_01[1]);
		wait 0.05;
	}
}

//Function Number: 10
func_3368(param_00,param_01,param_02)
{
	if(isdefined(level.radial_button_group) && level.radial_button_group.size)
	{
	}

	var_03 = getent(param_02,"targetname");
	var_04 = vectornormalize(anglestoforward(var_03.angles)) * 40;
	level.radial_button_group[param_00] = [];
	level.var_3369[param_00]["view_start"] = param_01;
	level.var_3369[param_00]["view_pos"] = var_03.origin + var_04;
	level.var_3369[param_00]["player_view_pos"] = var_03.origin;
	level.var_3369[param_00]["view_angles"] = var_03.angles;
}

//Function Number: 11
func_336A(param_00,param_01,param_02,param_03)
{
	var_04 = getent(param_02,"targetname");
	var_05 = func_337A(param_00,var_04);
	var_06 = spawnstruct();
	var_06.pos = var_04.origin;
	var_06.label = param_01;
	var_06.font_size = 1;
	var_06.font_color = (0.5,0.5,1);
	var_06.var_335E = var_05;
	var_06.action_func = param_03;
	var_06.var_336E = 8;
	level.radial_button_group[param_00][level.radial_button_group[param_00].size] = var_06;
	return var_06;
}

//Function Number: 12
updateselectedbutton()
{
	level endon("game_ended");
	for(;;)
	{
		if(!isdefined(level.radial_button_current_group))
		{
			wait 0.05;
			continue;
		}

		var_00 = level.var_3371;
		foreach(var_02 in level.radial_button_group[level.radial_button_current_group])
		{
			if(func_337D(var_02.var_3360,var_02.end_angle))
			{
				level.var_3371 = var_02;
				continue;
			}

			var_02.font_color = (0.5,0.5,1);
		}

		if(isdefined(level.var_3371))
		{
			level.var_3371.font_color = (1,1,0.5);
			if(isdefined(var_00) && var_00 != level.var_3371)
			{
				level.observer playsound("mouse_over");
			}
		}

		wait 0.05;
	}
}

//Function Number: 13
watchselectbuttonpress()
{
	level endon("game_ended");
	for(;;)
	{
		if(!isdefined(level.observer))
		{
			wait 0.05;
			continue;
		}

		var_00 = 1;
		while(!level.observer buttonpressed("BUTTON_A"))
		{
			wait 0.05;
		}

		level.observer playsound("mouse_click");
		if(isdefined(level.var_3371) && var_00)
		{
			level.var_3371 notify("select_button_pressed");
			[[ level.var_3371.action_func ]]();
			var_00 = 0;
		}

		while(level.observer buttonpressed("BUTTON_A"))
		{
			wait 0.05;
		}
	}
}

//Function Number: 14
func_3373()
{
	level endon("game_ended");
	for(;;)
	{
		if(!isdefined(level.observer))
		{
			wait 0.05;
			continue;
		}

		var_00 = 1;
		while(!level.observer buttonpressed("BUTTON_X"))
		{
			wait 0.05;
		}

		level.observer playsound("mouse_click");
		if(var_00)
		{
			action_back();
			var_00 = 0;
		}

		while(level.observer buttonpressed("BUTTON_X"))
		{
			wait 0.05;
		}
	}
}

//Function Number: 15
func_3374(param_00)
{
	for(var_01 = 0;var_01 < param_00.size - 1;var_01++)
	{
		for(var_02 = 0;var_02 < param_00.size - 1 - var_01;var_02++)
		{
			if(param_00[var_02 + 1].var_335E < param_00[var_02].var_335E)
			{
				func_3375(param_00[var_02],param_00[var_02 + 1]);
			}
		}
	}
}

//Function Number: 16
func_3375(param_00,param_01)
{
	var_02 = param_00.pos;
	var_03 = param_00.label;
	var_04 = param_00.var_335E;
	var_05 = param_00.action_func;
	var_06 = param_00.var_336E;
	param_00.pos = param_01.pos;
	param_00.label = param_01.label;
	param_00.var_335E = param_01.var_335E;
	param_00.action_func = param_01.action_func;
	param_00.var_336E = param_01.var_336E;
	param_01.pos = var_02;
	param_01.label = var_03;
	param_01.var_335E = var_04;
	param_01.action_func = var_05;
	param_01.var_336E = var_06;
}

//Function Number: 17
draw_radial_buttons(param_00)
{
	foreach(var_02 in level.radial_button_group[param_00])
	{
		var_02 thread draw_radial_button(param_00);
	}
}

//Function Number: 18
draw_radial_button(param_00)
{
	level endon("game_ended");
	self endon("remove_button");
	var_01 = level.var_3369[param_00]["view_pos"];
	var_02 = var_01 + func_337B(self.var_335E,4);
	for(;;)
	{
		var_03 = (1,0,0);
		if(func_337D(self.var_3360,self.end_angle))
		{
			var_03 = (1,1,0);
		}

		if(isdefined(level.var_3362) && level.var_3362 > 0)
		{
			var_04 = var_01 + func_337B(level.rs_angle,2);
		}

		wait 0.05;
	}
}

//Function Number: 19
zoom_to_radial_menu(param_00,param_01)
{
	level.var_3371 = undefined;
	if(isdefined(level.radial_button_current_group) && level.radial_button_current_group != "")
	{
		level.var_3379 = level.radial_button_current_group;
	}
	else
	{
		level.var_3379 = "main";
		level.radial_button_current_group = "main";
	}

	foreach(var_03 in level.radial_button_group[level.var_3379])
	{
		var_03 notify("remove_button");
	}

	if(isdefined(param_01) && param_01)
	{
		level.observer func_3389(level.var_3369[level.var_3379]["view_start"],param_00);
	}
	else
	{
		level.observer go_path_by_targetname(level.var_3369[param_00]["view_start"]);
	}

	level thread draw_radial_buttons(param_00);
	level.radial_button_current_group = param_00;
}

//Function Number: 20
func_337A(param_00,param_01)
{
	var_02 = level.var_3369[param_00]["view_angles"];
	var_03 = level.var_3369[param_00]["view_pos"];
	var_03 = var_03 + vectornormalize(anglestoforward(var_02)) * 40;
	var_04 = anglestoforward(var_02);
	var_05 = vectornormalize(anglestoup(var_02));
	var_06 = param_01.angles;
	var_07 = param_01.origin;
	var_08 = vectornormalize(vectorfromlinetopoint(var_03,var_03 + var_04,var_07));
	var_09 = acos(vectordot(var_08,var_05));
	if(vectordot(anglestoright(var_02),var_08) < 0)
	{
		var_09 = 360 - var_09;
	}

	return var_09;
}

//Function Number: 21
func_337B(param_00,param_01)
{
	var_02 = (270 - param_00,0,0);
	var_03 = anglestoforward(var_02);
	var_04 = vectornormalize(var_03);
	var_05 = var_04 * param_01;
	return var_05;
}

//Function Number: 22
getmidangle(param_00,param_01)
{
	var_02 = param_00 + param_01 + 720 / 2 - 360;
	return var_02;
}

//Function Number: 23
func_337D(param_00,param_01)
{
	var_02 = level.rs_angle > param_00 && level.rs_angle < 360;
	var_03 = level.rs_angle > 0 && level.rs_angle < param_01;
	if(param_00 > param_01)
	{
		var_04 = var_02 || var_03;
	}
	else
	{
		var_04 = level.rs_angle > param_01 && level.rs_angle < var_02;
	}

	return var_04;
}

//Function Number: 24
action_back()
{
	if(isdefined(level.radial_button_current_group) && level.radial_button_current_group != "main")
	{
		zoom_to_radial_menu("main",1);
		return;
	}
}

//Function Number: 25
func_337F()
{
	iprintlnbold("action_weapons_primary");
	zoom_to_radial_menu("weapons_primary");
}

//Function Number: 26
func_3380()
{
	iprintlnbold("action_weapons_secondary");
	zoom_to_radial_menu("weapons_secondary");
}

//Function Number: 27
action_gears()
{
	iprintlnbold("action_gears");
	zoom_to_radial_menu("gears");
}

//Function Number: 28
func_3382()
{
	iprintlnbold("action_killstreak");
	zoom_to_radial_menu("killstreak");
}

//Function Number: 29
func_3383()
{
	iprintlnbold("action_leaderboards");
	zoom_to_radial_menu("leaderboards");
}

//Function Number: 30
func_3384()
{
	level.view_paths = [];
	build_path_by_targetname("player_view1_start");
	build_path_by_targetname("player_view2_start");
	build_path_by_targetname("player_view3_start");
	build_path_by_targetname("player_view4_start");
	build_path_by_targetname("player_view5_start");
}

//Function Number: 31
build_path_by_targetname(param_00)
{
	level.view_paths[param_00] = [];
	var_01 = getent(param_00,"targetname");
	level.view_paths[param_00][level.view_paths[param_00].size] = var_01;
	while(isdefined(var_01) && isdefined(var_01.target))
	{
		var_02 = getent(var_01.target,"targetname");
		level.view_paths[param_00][level.view_paths[param_00].size] = var_02;
		var_01 = var_02;
	}
}

//Function Number: 32
go_path_by_targetname(param_00)
{
	if(!isdefined(level.dummy_mover))
	{
		var_01 = level.view_paths[param_00][0];
		level.dummy_mover = spawn("script_model",var_01.origin);
		level.dummy_mover.angles = var_01.angles;
		self setorigin(level.dummy_mover.origin - (0,0,65));
		self linkto(level.dummy_mover);
		wait 0.05;
		self setplayerangles(level.dummy_mover.angles);
		thread func_338C();
	}

	var_02 = 1;
	var_03 = abs(distance(level.dummy_mover.origin,level.view_paths[param_00][level.view_paths[param_00].size - 1].origin));
	var_02 = var_02 * var_03 / 1200;
	var_02 = max(var_02,0.1);
	var_04 = var_02;
	if(!1)
	{
		var_04 = var_04 * var_02 * level.view_paths[param_00].size + 1;
	}

	thread func_338B(3,var_04);
	foreach(var_07, var_06 in level.view_paths[param_00])
	{
		if(1)
		{
			if(var_07 != level.view_paths[param_00].size - 1)
			{
				continue;
			}
		}

		level.dummy_mover moveto(var_06.origin,var_02,var_02 * 0.5,0);
		level.dummy_mover rotateto(var_06.angles,var_02,var_02 * 0.5,0);
		wait var_02;
	}
}

//Function Number: 33
func_3389(param_00,param_01)
{
	var_02 = 1;
	var_03 = abs(distance(level.dummy_mover.origin,level.var_3369[param_01]["player_view_pos"]));
	var_02 = var_02 * var_03 / 1200;
	var_02 = max(var_02,0.1);
	var_04 = var_02;
	if(!1)
	{
		var_04 = var_04 * var_02 * level.view_paths[param_00].size + 1;
	}

	thread func_338B(3,var_04);
	if(!1)
	{
		for(var_05 = level.view_paths[param_00].size - 1;var_05 >= 0;var_05--)
		{
			var_06 = level.view_paths[param_00][var_05];
			level.dummy_mover moveto(var_06.origin,var_02);
			level.dummy_mover rotateto(var_06.angles,var_02);
			wait var_02;
		}
	}

	thread func_338B(3,var_02);
	var_07 = level.var_3369[param_01]["player_view_pos"];
	var_08 = level.var_3369[param_01]["view_angles"];
	level.dummy_mover moveto(var_07,var_02,var_02 * 0.5,0);
	level.dummy_mover rotateto(var_08,var_02,var_02 * 0.5,0);
	wait var_02;
}

//Function Number: 34
func_338A(param_00)
{
	self setblurforplayer(20,param_00 + 0.2 / 2);
	self setblurforplayer(0,param_00 + 0.2 / 2);
	self shellshock("frag_grenade_mp",param_00 + 0.2);
}

//Function Number: 35
func_338B(param_00,param_01)
{
	var_02 = int(param_01 / 0.05);
	for(var_03 = 0;var_03 < var_02;var_03++)
	{
		var_04 = var_03 / var_02;
		var_05 = sin(180 * var_04);
		var_06 = param_00 * var_05;
		setdvar("r_blur",var_06);
		wait 0.05;
	}

	setdvar("r_blur",0);
}

//Function Number: 36
func_338C()
{
	level endon("game_ended");
	self endon("disconnect");
	level.dummy_mover endon("remove_dummy");
	for(;;)
	{
		self setplayerangles(level.dummy_mover.angles);
		wait 0.05;
	}
}