/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\mp\_crib.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 36
 * Decompile Time: 1856 ms
 * Timestamp: 10/27/2023 12:14:57 AM
*******************************************************************/

//Function Number: 1
init()
{
	precacheshellshock("frag_grenade_mp");
	func_DBDE();
	func_DBE3();
	func_1338C();
	func_D0F6();
}

//Function Number: 2
func_DBDE()
{
	func_BF26("main","player_view1_start","player_view1_end");
	var_00 = func_BF25("main","Primary Weapon","radial_weapons_primary",::func_157D);
	var_01 = func_BF25("main","Secondary Weapon","radial_weapons_secondary",::func_157E);
	var_02 = func_BF25("main","Gears","radial_gears",::func_1578);
	var_03 = func_BF25("main","Kill Streaks","radial_killstreaks",::func_1579);
	var_04 = func_BF25("main","Leaderboards","radial_leaderboards",::func_157A);
	func_BF26("gears","player_view2_start","player_view2_end");
	func_BF26("weapons_primary","player_view3_start","player_view3_end");
	func_BF26("weapons_secondary","player_view3_start","player_view3_end");
	func_BF26("killstreak","player_view4_start","player_view4_end");
	func_BF26("leaderboards","player_view5_start","player_view5_end");
}

//Function Number: 3
func_DBE3()
{
	foreach(var_01 in level.var_DBDF)
	{
		func_10417(var_01);
		for(var_02 = 0;var_02 < var_01.size;var_02++)
		{
			if(isdefined(var_01[var_02 + 1]))
			{
				var_03 = func_7FB4(var_01[var_02].var_D69A,var_01[var_02 + 1].var_D69A);
				var_01[var_02].var_62A6 = var_03;
				var_01[var_02 + 1].var_10BA0 = var_03;
				continue;
			}

			var_03 = func_7FB4(var_01[var_02].var_D69A,var_01[0].var_D69A) + 180;
			if(var_03 > 360)
			{
				var_03 = var_03 - 360;
			}

			var_01[var_02].var_62A6 = var_03;
			var_01[0].var_10BA0 = var_03;
		}
	}

	thread func_12F12();
	thread func_13B36();
	thread func_139A7();
	thread func_4F2A();
}

//Function Number: 4
func_4F2A()
{
	level endon("game_ended");
	level.var_4A6B = 1;
	for(;;)
	{
		if(!isdefined(level.var_C2C8))
		{
			wait(0.05);
			continue;
		}

		var_00 = 1;
		while(!level.var_C2C8 buttonpressed("BUTTON_Y"))
		{
			wait(0.05);
		}

		level.var_C2C8 playsound("mouse_click");
		if(var_00)
		{
			level.var_4A6B = level.var_4A6B * -1;
			var_00 = 0;
		}

		while(level.var_C2C8 buttonpressed("BUTTON_Y"))
		{
			wait(0.05);
		}
	}
}

//Function Number: 5
func_D0F6()
{
	level thread func_C56E();
	level thread func_E459();
}

//Function Number: 6
func_E459()
{
	level waittill("game_ended");
	setdvar("cg_draw2d",1);
}

//Function Number: 7
func_C56E()
{
	level waittill("connected",var_00);
	var_00 thread func_DD78();
	var_00 waittill("spawned_player");
	wait(1);
	var_00 method_83B7();
	setdvar("cg_draw2d",0);
	if(!isdefined(var_00))
	{
		return;
	}
	else
	{
		level.var_C2C8 = var_00;
	}

	var_00 thread func_7C17();
	func_13FC9("main");
}

//Function Number: 8
func_DD78()
{
	self endon("disconnect");
	var_00 = "autoassign";
	while(!isdefined(self.pers["team"]))
	{
		wait(0.05);
	}

	self notify("menuresponse",game["menu_team"],var_00);
	wait(0.5);
	var_01 = getarraykeys(level.var_400C);
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
		wait(0.1);
	}
}

//Function Number: 9
func_7C17()
{
	level endon("game_ended");
	self endon("disconnect");
	for(;;)
	{
		var_00 = self getnormalizedmovement();
		var_01 = vectortoangles(var_00);
		level.var_E77B = int(var_01[1]);
		wait(0.05);
	}
}

//Function Number: 10
func_BF26(param_00,param_01,param_02)
{
	if(isdefined(level.var_DBDF) && level.var_DBDF.size)
	{
	}

	var_03 = getent(param_02,"targetname");
	var_04 = vectornormalize(anglestoforward(var_03.angles)) * 40;
	level.var_DBDF[param_00] = [];
	level.var_DBE0[param_00]["view_start"] = param_01;
	level.var_DBE0[param_00]["view_pos"] = var_03.origin + var_04;
	level.var_DBE0[param_00]["player_view_pos"] = var_03.origin;
	level.var_DBE0[param_00]["view_angles"] = var_03.angles;
}

//Function Number: 11
func_BF25(param_00,param_01,param_02,param_03)
{
	var_04 = getent(param_02,"targetname");
	var_05 = func_80A9(param_00,var_04);
	var_06 = spawnstruct();
	var_06.var_D699 = var_04.origin;
	var_06.label = param_01;
	var_06.var_724E = 1;
	var_06.var_724D = (0.5,0.5,1);
	var_06.var_D69A = var_05;
	var_06.var_1577 = param_03;
	var_06.var_DC07 = 8;
	level.var_DBDF[param_00][level.var_DBDF[param_00].size] = var_06;
	return var_06;
}

//Function Number: 12
func_12F12()
{
	level endon("game_ended");
	for(;;)
	{
		if(!isdefined(level.var_DBDD))
		{
			wait(0.05);
			continue;
		}

		var_00 = level.var_1622;
		foreach(var_02 in level.var_DBDF[level.var_DBDD])
		{
			if(func_9E4E(var_02.var_10BA0,var_02.var_62A6))
			{
				level.var_1622 = var_02;
				continue;
			}

			var_02.var_724D = (0.5,0.5,1);
		}

		if(isdefined(level.var_1622))
		{
			level.var_1622.var_724D = (1,1,0.5);
			if(isdefined(var_00) && var_00 != level.var_1622)
			{
				level.var_C2C8 playsound("mouse_over");
			}
		}

		wait(0.05);
	}
}

//Function Number: 13
func_13B36()
{
	level endon("game_ended");
	for(;;)
	{
		if(!isdefined(level.var_C2C8))
		{
			wait(0.05);
			continue;
		}

		var_00 = 1;
		while(!level.var_C2C8 buttonpressed("BUTTON_A"))
		{
			wait(0.05);
		}

		level.var_C2C8 playsound("mouse_click");
		if(isdefined(level.var_1622) && var_00)
		{
			level.var_1622 notify("select_button_pressed");
			[[ level.var_1622.var_1577 ]]();
			var_00 = 0;
		}

		while(level.var_C2C8 buttonpressed("BUTTON_A"))
		{
			wait(0.05);
		}
	}
}

//Function Number: 14
func_139A7()
{
	level endon("game_ended");
	for(;;)
	{
		if(!isdefined(level.var_C2C8))
		{
			wait(0.05);
			continue;
		}

		var_00 = 1;
		while(!level.var_C2C8 buttonpressed("BUTTON_X"))
		{
			wait(0.05);
		}

		level.var_C2C8 playsound("mouse_click");
		if(var_00)
		{
			func_1576();
			var_00 = 0;
		}

		while(level.var_C2C8 buttonpressed("BUTTON_X"))
		{
			wait(0.05);
		}
	}
}

//Function Number: 15
func_10417(param_00)
{
	for(var_01 = 0;var_01 < param_00.size - 1;var_01++)
	{
		for(var_02 = 0;var_02 < param_00.size - 1 - var_01;var_02++)
		{
			if(param_00[var_02 + 1].var_D69A < param_00[var_02].var_D69A)
			{
				func_32EA(param_00[var_02],param_00[var_02 + 1]);
			}
		}
	}
}

//Function Number: 16
func_32EA(param_00,param_01)
{
	var_02 = param_00.var_D699;
	var_03 = param_00.label;
	var_04 = param_00.var_D69A;
	var_05 = param_00.var_1577;
	var_06 = param_00.var_DC07;
	param_00.var_D699 = param_01.var_D699;
	param_00.label = param_01.label;
	param_00.var_D69A = param_01.var_D69A;
	param_00.var_1577 = param_01.var_1577;
	param_00.var_DC07 = param_01.var_DC07;
	param_01.var_D699 = var_02;
	param_01.label = var_03;
	param_01.var_D69A = var_04;
	param_01.var_1577 = var_05;
	param_01.var_DC07 = var_06;
}

//Function Number: 17
func_5B5C(param_00)
{
	foreach(var_02 in level.var_DBDF[param_00])
	{
		var_02 thread func_5B5B(param_00);
	}
}

//Function Number: 18
func_5B5B(param_00)
{
	level endon("game_ended");
	self endon("remove_button");
	var_01 = level.var_DBE0[param_00]["view_pos"];
	var_02 = var_01 + func_DBDA(self.var_D69A,4);
	for(;;)
	{
		var_03 = (1,0,0);
		if(func_9E4E(self.var_10BA0,self.var_62A6))
		{
			var_03 = (1,1,0);
		}

		if(isdefined(level.var_4A6B) && level.var_4A6B > 0)
		{
			var_04 = var_01 + func_DBDA(level.var_E77B,2);
		}

		wait(0.05);
	}
}

//Function Number: 19
func_13FC9(param_00,param_01)
{
	level.var_1622 = undefined;
	if(isdefined(level.var_DBDD) && level.var_DBDD != "")
	{
		level.var_DBE1 = level.var_DBDD;
	}
	else
	{
		level.var_DBE1 = "main";
		level.var_DBDD = "main";
	}

	foreach(var_03 in level.var_DBDF[level.var_DBE1])
	{
		var_03 notify("remove_button");
	}

	if(isdefined(param_01) && param_01)
	{
		level.var_C2C8 func_83FD(level.var_DBE0[level.var_DBE1]["view_start"],param_00);
	}
	else
	{
		level.var_C2C8 func_83FC(level.var_DBE0[param_00]["view_start"]);
	}

	level thread func_5B5C(param_00);
	level.var_DBDD = param_00;
}

//Function Number: 20
func_80A9(param_00,param_01)
{
	var_02 = level.var_DBE0[param_00]["view_angles"];
	var_03 = level.var_DBE0[param_00]["view_pos"];
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
func_DBDA(param_00,param_01)
{
	var_02 = (270 - param_00,0,0);
	var_03 = anglestoforward(var_02);
	var_04 = vectornormalize(var_03);
	var_05 = var_04 * param_01;
	return var_05;
}

//Function Number: 22
func_7FB4(param_00,param_01)
{
	var_02 = param_00 + param_01 + 720 / 2 - 360;
	return var_02;
}

//Function Number: 23
func_9E4E(param_00,param_01)
{
	var_02 = level.var_E77B > param_00 && level.var_E77B < 360;
	var_03 = level.var_E77B > 0 && level.var_E77B < param_01;
	if(param_00 > param_01)
	{
		var_04 = var_02 || var_03;
	}
	else
	{
		var_04 = level.var_E77B > param_01 && level.var_E77B < var_02;
	}

	return var_04;
}

//Function Number: 24
func_1576()
{
	if(isdefined(level.var_DBDD) && level.var_DBDD != "main")
	{
		func_13FC9("main",1);
		return;
	}
}

//Function Number: 25
func_157D()
{
	iprintlnbold("action_weapons_primary");
	func_13FC9("weapons_primary");
}

//Function Number: 26
func_157E()
{
	iprintlnbold("action_weapons_secondary");
	func_13FC9("weapons_secondary");
}

//Function Number: 27
func_1578()
{
	iprintlnbold("action_gears");
	func_13FC9("gears");
}

//Function Number: 28
func_1579()
{
	iprintlnbold("action_killstreak");
	func_13FC9("killstreak");
}

//Function Number: 29
func_157A()
{
	iprintlnbold("action_leaderboards");
	func_13FC9("leaderboards");
}

//Function Number: 30
func_1338C()
{
	level.var_1338D = [];
	func_31AD("player_view1_start");
	func_31AD("player_view2_start");
	func_31AD("player_view3_start");
	func_31AD("player_view4_start");
	func_31AD("player_view5_start");
}

//Function Number: 31
func_31AD(param_00)
{
	level.var_1338D[param_00] = [];
	var_01 = getent(param_00,"targetname");
	level.var_1338D[param_00][level.var_1338D[param_00].size] = var_01;
	while(isdefined(var_01) && isdefined(var_01.target))
	{
		var_02 = getent(var_01.target,"targetname");
		level.var_1338D[param_00][level.var_1338D[param_00].size] = var_02;
		var_01 = var_02;
	}
}

//Function Number: 32
func_83FC(param_00)
{
	if(!isdefined(level.var_5F21))
	{
		var_01 = level.var_1338D[param_00][0];
		level.var_5F21 = spawn("script_model",var_01.origin);
		level.var_5F21.angles = var_01.angles;
		self setorigin(level.var_5F21.origin - (0,0,65));
		self linkto(level.var_5F21);
		wait(0.05);
		self setplayerangles(level.var_5F21.angles);
		thread func_7284();
	}

	var_02 = 1;
	var_03 = abs(distance(level.var_5F21.origin,level.var_1338D[param_00][level.var_1338D[param_00].size - 1].origin));
	var_02 = var_02 * var_03 / 1200;
	var_02 = max(var_02,0.1);
	var_04 = var_02;
	if(!1)
	{
		var_04 = var_04 * var_02 * level.var_1338D[param_00].size + 1;
	}

	thread func_2BD8(3,var_04);
	foreach(var_07, var_06 in level.var_1338D[param_00])
	{
		if(1)
		{
			if(var_07 != level.var_1338D[param_00].size - 1)
			{
				continue;
			}
		}

		level.var_5F21 moveto(var_06.origin,var_02,var_02 * 0.5,0);
		level.var_5F21 rotateto(var_06.angles,var_02,var_02 * 0.5,0);
		wait(var_02);
	}
}

//Function Number: 33
func_83FD(param_00,param_01)
{
	var_02 = 1;
	var_03 = abs(distance(level.var_5F21.origin,level.var_DBE0[param_01]["player_view_pos"]));
	var_02 = var_02 * var_03 / 1200;
	var_02 = max(var_02,0.1);
	var_04 = var_02;
	if(!1)
	{
		var_04 = var_04 * var_02 * level.var_1338D[param_00].size + 1;
	}

	thread func_2BD8(3,var_04);
	if(!1)
	{
		for(var_05 = level.var_1338D[param_00].size - 1;var_05 >= 0;var_05--)
		{
			var_06 = level.var_1338D[param_00][var_05];
			level.var_5F21 moveto(var_06.origin,var_02);
			level.var_5F21 rotateto(var_06.angles,var_02);
			wait(var_02);
		}
	}

	thread func_2BD8(3,var_02);
	var_07 = level.var_DBE0[param_01]["player_view_pos"];
	var_08 = level.var_DBE0[param_01]["view_angles"];
	level.var_5F21 moveto(var_07,var_02,var_02 * 0.5,0);
	level.var_5F21 rotateto(var_08,var_02,var_02 * 0.5,0);
	wait(var_02);
}

//Function Number: 34
func_126C0(param_00)
{
	self setblurforplayer(20,param_00 + 0.2 / 2);
	self setblurforplayer(0,param_00 + 0.2 / 2);
	self shellshock("frag_grenade_mp",param_00 + 0.2);
}

//Function Number: 35
func_2BD8(param_00,param_01)
{
	var_02 = int(param_01 / 0.05);
	for(var_03 = 0;var_03 < var_02;var_03++)
	{
		var_04 = var_03 / var_02;
		var_05 = sin(180 * var_04);
		var_06 = param_00 * var_05;
		setdvar("r_blur",var_06);
		wait(0.05);
	}

	setdvar("r_blur",0);
}

//Function Number: 36
func_7284()
{
	level endon("game_ended");
	self endon("disconnect");
	level.var_5F21 endon("remove_dummy");
	for(;;)
	{
		self setplayerangles(level.var_5F21.angles);
		wait(0.05);
	}
}