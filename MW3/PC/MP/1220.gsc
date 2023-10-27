/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 1220.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: PC
 * Function Count: 36
 * Decompile Time: 21 ms
 * Timestamp: 10/27/2023 2:15:22 AM
*******************************************************************/

//Function Number: 1
init()
{
	precacheshellshock("frag_grenade_mp");
	func_3831();
	func_3832();
	func_385A();
	player_init();
}

//Function Number: 2
func_3831()
{
	func_383E("main","player_view1_start","player_view1_end");
	var_00 = func_3840("main","Primary Weapon","radial_weapons_primary",::func_3855);
	var_01 = func_3840("main","Secondary Weapon","radial_weapons_secondary",::func_3856);
	var_02 = func_3840("main","Gears","radial_gears",::func_3857);
	var_03 = func_3840("main","Kill Streaks","radial_killstreaks",::func_3858);
	var_04 = func_3840("main","Leaderboards","radial_leaderboards",::func_3859);
	func_383E("gears","player_view2_start","player_view2_end");
	func_383E("weapons_primary","player_view3_start","player_view3_end");
	func_383E("weapons_secondary","player_view3_start","player_view3_end");
	func_383E("killstreak","player_view4_start","player_view4_end");
	func_383E("leaderboards","player_view5_start","player_view5_end");
}

//Function Number: 3
func_3832()
{
	foreach(var_01 in level.var_3833)
	{
		func_384A(var_01);
		for(var_02 = 0;var_02 < var_01.size;var_02++)
		{
			if(isdefined(var_01[var_02 + 1]))
			{
				var_03 = func_3852(var_01[var_02].var_3834,var_01[var_02 + 1].var_3834);
				var_01[var_02].var_3835 = var_03;
				var_01[var_02 + 1].var_3836 = var_03;
				continue;
			}

			var_03 = func_3852(var_01[var_02].var_3834,var_01[0].var_3834) + 180;
			if(var_03 > 360)
			{
				var_03 = var_03 - 360;
			}

			var_01[var_02].var_3835 = var_03;
			var_01[0].var_3836 = var_03;
		}
	}

	thread func_3845();
	thread func_3848();
	thread func_3849();
	thread func_3837();
}

//Function Number: 4
func_3837()
{
	level endon("game_ended");
	level.var_3838 = 1;
	for(;;)
	{
		if(!isdefined(level.var_3839))
		{
			wait 0.05;
			continue;
		}

		var_00 = 1;
		while(!level.var_3839 buttonpressed("BUTTON_Y"))
		{
			wait 0.05;
		}

		level.var_3839 playsound("mouse_click");
		if(var_00)
		{
			level.var_3838 = level.var_3838 * -1;
			var_00 = 0;
		}

		while(level.var_3839 buttonpressed("BUTTON_Y"))
		{
			wait 0.05;
		}
	}
}

//Function Number: 5
player_init()
{
	level thread onplayerconnect();
	level thread func_383A();
}

//Function Number: 6
func_383A()
{
	level waittill("game_ended");
	setdvar("cg_draw2d",1);
}

//Function Number: 7
onplayerconnect()
{
	level waittill("connected",var_00);
	var_00 thread func_383B();
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
		level.var_3839 = var_00;
	}

	var_00 thread func_383C();
	func_384E("main");
}

//Function Number: 8
func_383B()
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
func_383C()
{
	level endon("game_ended");
	self endon("disconnect");
	for(;;)
	{
		var_00 = self getnormalizedmovement();
		var_01 = vectortoangles(var_00);
		level.var_383D = int(var_01[1]);
		wait 0.05;
	}
}

//Function Number: 10
func_383E(param_00,param_01,param_02)
{
	if(isdefined(level.var_3833) && level.var_3833.size)
	{
	}

	var_03 = getent(param_02,"targetname");
	var_04 = vectornormalize(anglestoforward(var_03.angles)) * 40;
	level.var_3833[param_00] = [];
	level.var_383F[param_00]["view_start"] = param_01;
	level.var_383F[param_00]["view_pos"] = var_03.origin + var_04;
	level.var_383F[param_00]["player_view_pos"] = var_03.origin;
	level.var_383F[param_00]["view_angles"] = var_03.angles;
}

//Function Number: 11
func_3840(param_00,param_01,param_02,param_03)
{
	var_04 = getent(param_02,"targetname");
	var_05 = func_3850(param_00,var_04);
	var_06 = spawnstruct();
	var_06.pos = var_04.origin;
	var_06.label = param_01;
	var_06.var_3841 = 1;
	var_06.var_3842 = (0.5,0.5,1);
	var_06.var_3834 = var_05;
	var_06.var_3843 = param_03;
	var_06.var_3844 = 8;
	level.var_3833[param_00][level.var_3833[param_00].size] = var_06;
	return var_06;
}

//Function Number: 12
func_3845()
{
	level endon("game_ended");
	for(;;)
	{
		if(!isdefined(level.var_3846))
		{
			wait 0.05;
			continue;
		}

		var_00 = level.var_3847;
		foreach(var_02 in level.var_3833[level.var_3846])
		{
			if(func_3853(var_02.var_3836,var_02.var_3835))
			{
				level.var_3847 = var_02;
				continue;
			}

			var_02.var_3842 = (0.5,0.5,1);
		}

		if(isdefined(level.var_3847))
		{
			level.var_3847.var_3842 = (1,1,0.5);
			if(isdefined(var_00) && var_00 != level.var_3847)
			{
				level.var_3839 playsound("mouse_over");
			}
		}

		wait 0.05;
	}
}

//Function Number: 13
func_3848()
{
	level endon("game_ended");
	for(;;)
	{
		if(!isdefined(level.var_3839))
		{
			wait 0.05;
			continue;
		}

		var_00 = 1;
		while(!level.var_3839 buttonpressed("BUTTON_A"))
		{
			wait 0.05;
		}

		level.var_3839 playsound("mouse_click");
		if(isdefined(level.var_3847) && var_00)
		{
			level.var_3847 notify("select_button_pressed");
			[[ level.var_3847.var_3843 ]]();
			var_00 = 0;
		}

		while(level.var_3839 buttonpressed("BUTTON_A"))
		{
			wait 0.05;
		}
	}
}

//Function Number: 14
func_3849()
{
	level endon("game_ended");
	for(;;)
	{
		if(!isdefined(level.var_3839))
		{
			wait 0.05;
			continue;
		}

		var_00 = 1;
		while(!level.var_3839 buttonpressed("BUTTON_X"))
		{
			wait 0.05;
		}

		level.var_3839 playsound("mouse_click");
		if(var_00)
		{
			func_3854();
			var_00 = 0;
		}

		while(level.var_3839 buttonpressed("BUTTON_X"))
		{
			wait 0.05;
		}
	}
}

//Function Number: 15
func_384A(param_00)
{
	for(var_01 = 0;var_01 < param_00.size - 1;var_01++)
	{
		for(var_02 = 0;var_02 < param_00.size - 1 - var_01;var_02++)
		{
			if(param_00[var_02 + 1].var_3834 < param_00[var_02].var_3834)
			{
				func_384B(param_00[var_02],param_00[var_02 + 1]);
			}
		}
	}
}

//Function Number: 16
func_384B(param_00,param_01)
{
	var_02 = param_00.pos;
	var_03 = param_00.label;
	var_04 = param_00.var_3834;
	var_05 = param_00.var_3843;
	var_06 = param_00.var_3844;
	param_00.pos = param_01.pos;
	param_00.label = param_01.label;
	param_00.var_3834 = param_01.var_3834;
	param_00.var_3843 = param_01.var_3843;
	param_00.var_3844 = param_01.var_3844;
	param_01.pos = var_02;
	param_01.label = var_03;
	param_01.var_3834 = var_04;
	param_01.var_3843 = var_05;
	param_01.var_3844 = var_06;
}

//Function Number: 17
func_384C(param_00)
{
	foreach(var_02 in level.var_3833[param_00])
	{
		var_02 thread func_384D(param_00);
	}
}

//Function Number: 18
func_384D(param_00)
{
	level endon("game_ended");
	self endon("remove_button");
	var_01 = level.var_383F[param_00]["view_pos"];
	var_02 = var_01 + func_3851(self.var_3834,4);
	for(;;)
	{
		var_03 = (1,0,0);
		if(func_3853(self.var_3836,self.var_3835))
		{
			var_03 = (1,1,0);
		}

		if(isdefined(level.var_3838) && level.var_3838 > 0)
		{
			var_04 = var_01 + func_3851(level.var_383D,2);
		}

		wait 0.05;
	}
}

//Function Number: 19
func_384E(param_00,param_01)
{
	level.var_3847 = undefined;
	if(isdefined(level.var_3846) && level.var_3846 != "")
	{
		level.var_384F = level.var_3846;
	}
	else
	{
		level.var_384F = "main";
		level.var_3846 = "main";
	}

	foreach(var_03 in level.var_3833[level.var_384F])
	{
		var_03 notify("remove_button");
	}

	if(isdefined(param_01) && param_01)
	{
		level.var_3839 func_385F(level.var_383F[level.var_384F]["view_start"],param_00);
	}
	else
	{
		level.var_3839 func_385D(level.var_383F[param_00]["view_start"]);
	}

	level thread func_384C(param_00);
	level.var_3846 = param_00;
}

//Function Number: 20
func_3850(param_00,param_01)
{
	var_02 = level.var_383F[param_00]["view_angles"];
	var_03 = level.var_383F[param_00]["view_pos"];
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
func_3851(param_00,param_01)
{
	var_02 = (270 - param_00,0,0);
	var_03 = anglestoforward(var_02);
	var_04 = vectornormalize(var_03);
	var_05 = var_04 * param_01;
	return var_05;
}

//Function Number: 22
func_3852(param_00,param_01)
{
	var_02 = param_00 + param_01 + 720 / 2 - 360;
	return var_02;
}

//Function Number: 23
func_3853(param_00,param_01)
{
	var_02 = level.var_383D > param_00 && level.var_383D < 360;
	var_03 = level.var_383D > 0 && level.var_383D < param_01;
	if(param_00 > param_01)
	{
		var_04 = var_02 || var_03;
	}
	else
	{
		var_04 = level.var_383D > param_01 && level.var_383D < var_02;
	}

	return var_04;
}

//Function Number: 24
func_3854()
{
	if(isdefined(level.var_3846) && level.var_3846 != "main")
	{
		func_384E("main",1);
		return;
	}
}

//Function Number: 25
func_3855()
{
	iprintlnbold("action_weapons_primary");
	func_384E("weapons_primary");
}

//Function Number: 26
func_3856()
{
	iprintlnbold("action_weapons_secondary");
	func_384E("weapons_secondary");
}

//Function Number: 27
func_3857()
{
	iprintlnbold("action_gears");
	func_384E("gears");
}

//Function Number: 28
func_3858()
{
	iprintlnbold("action_killstreak");
	func_384E("killstreak");
}

//Function Number: 29
func_3859()
{
	iprintlnbold("action_leaderboards");
	func_384E("leaderboards");
}

//Function Number: 30
func_385A()
{
	level.var_385B = [];
	func_385C("player_view1_start");
	func_385C("player_view2_start");
	func_385C("player_view3_start");
	func_385C("player_view4_start");
	func_385C("player_view5_start");
}

//Function Number: 31
func_385C(param_00)
{
	level.var_385B[param_00] = [];
	var_01 = getent(param_00,"targetname");
	level.var_385B[param_00][level.var_385B[param_00].size] = var_01;
	while(isdefined(var_01) && isdefined(var_01.target))
	{
		var_02 = getent(var_01.target,"targetname");
		level.var_385B[param_00][level.var_385B[param_00].size] = var_02;
		var_01 = var_02;
	}
}

//Function Number: 32
func_385D(param_00)
{
	if(!isdefined(level.var_385E))
	{
		var_01 = level.var_385B[param_00][0];
		level.var_385E = spawn("script_model",var_01.origin);
		level.var_385E.angles = var_01.angles;
		self setorigin(level.var_385E.origin - (0,0,65));
		self linkto(level.var_385E);
		wait 0.05;
		self setplayerangles(level.var_385E.angles);
		thread func_3862();
	}

	var_02 = 1;
	var_03 = abs(distance(level.var_385E.origin,level.var_385B[param_00][level.var_385B[param_00].size - 1].origin));
	var_02 = var_02 * var_03 / 1200;
	var_02 = max(var_02,0.1);
	var_04 = var_02;
	if(!1)
	{
		var_04 = var_04 * var_02 * level.var_385B[param_00].size + 1;
	}

	thread func_3861(3,var_04);
	foreach(var_07, var_06 in level.var_385B[param_00])
	{
		if(1)
		{
			if(var_07 != level.var_385B[param_00].size - 1)
			{
				continue;
			}
		}

		level.var_385E moveto(var_06.origin,var_02,var_02 * 0.5,0);
		level.var_385E rotateto(var_06.angles,var_02,var_02 * 0.5,0);
		wait var_02;
	}
}

//Function Number: 33
func_385F(param_00,param_01)
{
	var_02 = 1;
	var_03 = abs(distance(level.var_385E.origin,level.var_383F[param_01]["player_view_pos"]));
	var_02 = var_02 * var_03 / 1200;
	var_02 = max(var_02,0.1);
	var_04 = var_02;
	if(!1)
	{
		var_04 = var_04 * var_02 * level.var_385B[param_00].size + 1;
	}

	thread func_3861(3,var_04);
	if(!1)
	{
		for(var_05 = level.var_385B[param_00].size - 1;var_05 >= 0;var_05--)
		{
			var_06 = level.var_385B[param_00][var_05];
			level.var_385E moveto(var_06.origin,var_02);
			level.var_385E rotateto(var_06.angles,var_02);
			wait var_02;
		}
	}

	thread func_3861(3,var_02);
	var_07 = level.var_383F[param_01]["player_view_pos"];
	var_08 = level.var_383F[param_01]["view_angles"];
	level.var_385E moveto(var_07,var_02,var_02 * 0.5,0);
	level.var_385E rotateto(var_08,var_02,var_02 * 0.5,0);
	wait var_02;
}

//Function Number: 34
func_3860(param_00)
{
	self setblurforplayer(20,param_00 + 0.2 / 2);
	self setblurforplayer(0,param_00 + 0.2 / 2);
	self shellshock("frag_grenade_mp",param_00 + 0.2);
}

//Function Number: 35
func_3861(param_00,param_01)
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
func_3862()
{
	level endon("game_ended");
	self endon("disconnect");
	level.var_385E endon("remove_dummy");
	for(;;)
	{
		self setplayerangles(level.var_385E.angles);
		wait 0.05;
	}
}