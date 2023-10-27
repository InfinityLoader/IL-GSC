/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\common\createfx.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 125
 * Decompile Time: 5940 ms
 * Timestamp: 10/27/2023 12:03:15 AM
*******************************************************************/

//Function Number: 1
func_49AA(param_00,param_01)
{
	var_02 = spawnstruct();
	if(!isdefined(level.var_49C9))
	{
		level.var_49C9 = [];
	}

	level.var_49C9[level.var_49C9.size] = var_02;
	var_02.var_13125 = [];
	var_02.var_13125["type"] = param_00;
	var_02.var_13125["fxid"] = param_01;
	var_02.var_13125["angles"] = (0,0,0);
	var_02.var_13125["origin"] = (0,0,0);
	return var_02;
}

//Function Number: 2
func_7F81()
{
	return 0.5;
}

//Function Number: 3
func_8022()
{
	return -4;
}

//Function Number: 4
func_7EA6()
{
	return 0;
}

//Function Number: 5
func_7F1C()
{
	return 0.75;
}

//Function Number: 6
func_7F1B()
{
	return 2;
}

//Function Number: 7
func_49E7()
{
	var_00 = spawnstruct();
	if(!isdefined(level.var_49C9))
	{
		level.var_49C9 = [];
	}

	level.var_49C9[level.var_49C9.size] = var_00;
	var_00.var_13125 = [];
	var_00.var_13125["type"] = "soundfx";
	var_00.var_13125["fxid"] = "No FX";
	var_00.var_13125["soundalias"] = "nil";
	var_00.var_13125["angles"] = (0,0,0);
	var_00.var_13125["origin"] = (0,0,0);
	var_00.var_13125["server_culled"] = 1;
	if(getdvar("serverCulledSounds") != "1")
	{
		var_00.var_13125["server_culled"] = 0;
	}

	return var_00;
}

//Function Number: 8
func_49DD()
{
	var_00 = func_49E7();
	var_00.var_13125["type"] = "soundfx_interval";
	var_00.var_13125["delay_min"] = func_7F1C();
	var_00.var_13125["delay_max"] = func_7F1B();
	return var_00;
}

//Function Number: 9
func_49F4()
{
	if(!isdefined(level.var_49C9))
	{
		level.var_49C9 = [];
	}

	var_00 = func_49F5();
	level.var_49C9[level.var_49C9.size] = var_00;
	return var_00;
}

//Function Number: 10
func_49F5(param_00)
{
	if(!isdefined(param_00))
	{
		param_00 = spawnstruct();
		param_00.var_13125 = [];
	}

	param_00.var_13125["type"] = "exploder";
	param_00.var_13125["exploder_type"] = "normal";
	if(!isdefined(param_00.var_13125["fxid"]))
	{
		param_00.var_13125["fxid"] = "No FX";
	}

	if(!isdefined(param_00.var_13125["soundalias"]))
	{
		param_00.var_13125["soundalias"] = "nil";
	}

	if(!isdefined(param_00.var_13125["loopsound"]))
	{
		param_00.var_13125["loopsound"] = "nil";
	}

	if(!isdefined(param_00.var_13125["angles"]))
	{
		param_00.var_13125["angles"] = (0,0,0);
	}

	if(!isdefined(param_00.var_13125["origin"]))
	{
		param_00.var_13125["origin"] = (0,0,0);
	}

	if(!isdefined(param_00.var_13125["exploder"]))
	{
		param_00.var_13125["exploder"] = 1;
	}

	if(!isdefined(param_00.var_13125["flag"]))
	{
		param_00.var_13125["flag"] = "nil";
	}

	if(!isdefined(param_00.var_13125["delay"]) || param_00.var_13125["delay"] < 0)
	{
		param_00.var_13125["delay"] = func_7EA6();
	}

	return param_00;
}

//Function Number: 11
func_49AF(param_00,param_01)
{
	var_02 = scripts\common\utility::func_49AE(param_00);
	var_02.var_13125["exploder"] = param_01;
	return var_02;
}

//Function Number: 12
func_4A06(param_00)
{
	var_01 = spawnstruct();
	if(!isdefined(level.var_49C9))
	{
		level.var_49C9 = [];
	}

	level.var_49C9[level.var_49C9.size] = var_01;
	var_01.var_13125 = [];
	var_01.var_13125["origin"] = (0,0,0);
	var_01.var_13125["reactive_radius"] = 350;
	if(isdefined(param_00))
	{
		var_01.var_13125["fxid"] = param_00;
	}
	else
	{
		var_01.var_13125["fxid"] = "No FX";
	}

	var_01.var_13125["type"] = "reactive_fx";
	var_01.var_13125["soundalias"] = "nil";
	return var_01;
}

//Function Number: 13
func_F4AD(param_00,param_01)
{
	if(isdefined(level.var_49C2))
	{
		param_00 = param_00 + level.var_49C2;
	}

	self.var_13125["origin"] = param_00;
	self.var_13125["angles"] = param_01;
}

//Function Number: 14
func_F3BD()
{
	self.var_13125["up"] = anglestoup(self.var_13125["angles"]);
	self.var_13125["forward"] = anglestoforward(self.var_13125["angles"]);
}

//Function Number: 15
func_49B9()
{
	precacheshader("black");
	level.var_11B7 = spawnstruct();
	level.var_11B7.var_15F = spawn("script_origin",(0,0,0));
	level.var_11B7.var_15F.var_7542 = loadfx("vfx/core/expl/grenadeexp_default");
	level.var_11B7.var_15F.var_10453 = "frag_grenade_explode";
	level.var_11B7.var_15F.var_257 = 256;
	precachemodel("axis_guide_createfx_rot");
	precachemodel("axis_guide_createfx");
	scripts\common\utility::flag_init("createfx_saving");
	scripts\common\utility::flag_init("createfx_started");
	if(!isdefined(level.var_49B4))
	{
		level.var_49B4 = [];
	}

	level.var_49C1 = 0;
	wait(0.05);
	level notify("createfx_common_done");
}

//Function Number: 16
func_965E()
{
	level.var_11B7.var_F1BE = 0;
	level.var_11B7.var_F1BC = 0;
	level.var_11B7.var_F1BD = 0;
	level.var_11B7.var_F1C0 = 0;
	level.var_11B7.var_F1C1 = 0;
	level.var_11B7.var_F1C2 = 0;
	level.var_11B7.var_F1B2 = [];
	level.var_11B7.var_F1B3 = [];
	level.var_11B7.var_DCE1 = 1;
	level.var_11B7.var_10388 = 0;
	level.var_11B7.var_10386 = 0;
	level.var_11B7.var_10387 = [0,90,45,15];
	level.var_11B7.var_26F8 = 0;
	level.var_11B7.var_F191 = 0;
	level.var_11B7.var_5B6F = 1;
	level.var_11B7.var_D2C7 = getdvarfloat("g_speed");
	func_F54D();
}

//Function Number: 17
func_966D()
{
	level.var_11B7.var_AEF7 = [];
	level.var_11B7.var_AEF7["escape"] = 1;
	level.var_11B7.var_AEF7["BUTTON_LSHLDR"] = 1;
	level.var_11B7.var_AEF7["BUTTON_RSHLDR"] = 1;
	level.var_11B7.var_AEF7["mouse1"] = 1;
	level.var_11B7.var_AEF7["ctrl"] = 1;
}

//Function Number: 18
func_957F()
{
	var_00 = [];
	var_00["loopfx"]["selected"] = (1,1,0.2);
	var_00["loopfx"]["highlighted"] = (0.4,0.95,1);
	var_00["loopfx"]["default"] = (0.3,0.8,1);
	var_00["oneshotfx"]["selected"] = (1,1,0.2);
	var_00["oneshotfx"]["highlighted"] = (0.4,0.95,1);
	var_00["oneshotfx"]["default"] = (0.3,0.8,1);
	var_00["exploder"]["selected"] = (1,1,0.2);
	var_00["exploder"]["highlighted"] = (1,0.2,0.2);
	var_00["exploder"]["default"] = (1,0.1,0.1);
	var_00["rainfx"]["selected"] = (1,1,0.2);
	var_00["rainfx"]["highlighted"] = (0.95,0.4,0.95);
	var_00["rainfx"]["default"] = (0.78,0,0.73);
	var_00["soundfx"]["selected"] = (1,1,0.2);
	var_00["soundfx"]["highlighted"] = (0.5,1,0.75);
	var_00["soundfx"]["default"] = (0.2,0.9,0.2);
	var_00["soundfx_interval"]["selected"] = (1,1,0.2);
	var_00["soundfx_interval"]["highlighted"] = (0.5,1,0.75);
	var_00["soundfx_interval"]["default"] = (0.2,0.9,0.2);
	var_00["reactive_fx"]["selected"] = (1,1,0.2);
	var_00["reactive_fx"]["highlighted"] = (0.5,1,0.75);
	var_00["reactive_fx"]["default"] = (0.2,0.9,0.2);
	level.var_11B7.var_43AE = var_00;
}

//Function Number: 19
func_49CB()
{
	waittillframeend;
	wait(0.05);
	if(!isdefined(level._effect))
	{
		level._effect = [];
	}

	if(getdvar("createfx_map") == "")
	{
	}
	else if(getdvar("createfx_map") == scripts\common\utility::func_7CF1())
	{
		[[ level.var_74CF ]]();
	}

	func_9599();
	scripts\common\createfxmenu::func_967B();
	func_962A();
	func_9786();
	func_965E();
	func_966D();
	func_957F();
	level.player setclientomnvar("ui_hide_hud",1);
	setdvarifuninitialized("createfx_filter","");
	setdvarifuninitialized("createfx_vfxonly","0");
	if(getdvar("createfx_use_f4") == "")
	{
	}

	if(getdvar("createfx_no_autosave") == "")
	{
	}

	level.var_49BB = 1;
	level.var_A8A9 = undefined;
	level.var_32EF = [];
	var_00 = (0,0,0);
	scripts\common\utility::flag_set("createfx_started");
	if(!level.var_BD5D)
	{
		var_00 = level.player.origin;
	}

	var_01 = undefined;
	level.var_75DC = 0;
	scripts\common\createfxmenu::func_F796("none");
	level.var_49C6 = 0;
	level.var_49C0 = 0;
	foreach(var_03 in level.var_49C9)
	{
		var_03 func_D6CF();
	}

	thread func_5B3A();
	var_05 = undefined;
	thread func_49B6();
	for(;;)
	{
		var_06 = 0;
		var_07 = anglestoright(level.player getplayerangles());
		var_08 = anglestoforward(level.player getplayerangles());
		var_09 = anglestoup(level.player getplayerangles());
		var_0A = 0.85;
		var_0B = var_08 * 750;
		level.var_49C8 = bullettrace(level.player geteye(),level.player geteye() + var_0B,0,undefined);
		var_0C = undefined;
		level.var_32ED = [];
		level.var_32E1 = [];
		func_D962();
		var_0D = func_32E0("ctrl","BUTTON_LSHLDR");
		var_0E = func_32E0("shift");
		var_0F = func_32DF("mouse1","BUTTON_A");
		var_10 = func_32E0("mouse1","BUTTON_A");
		scripts\common\createfxmenu::func_48F1();
		var_11 = "F5";
		if(getdvarint("createfx_use_f4"))
		{
			var_11 = "F4";
		}

		if(func_32DF(var_11))
		{
		}

		if(getdvarint("scr_createfx_dump"))
		{
			func_772B();
		}

		if(func_32DF("F2"))
		{
			func_119B4();
		}

		if(func_32DF("z"))
		{
			func_119B3();
		}

		if(func_32DF("ins"))
		{
			func_990C();
		}

		if(func_32DF("del"))
		{
			func_518B();
		}

		if(func_32DF("escape"))
		{
			func_417F();
		}

		if(func_32DF("space"))
		{
			func_F4A9();
		}

		if(func_32DF("u"))
		{
			func_F192();
		}

		func_B933();
		if(!var_0D && !var_0E && func_32DF("g"))
		{
			func_F190("exploder");
			func_F190("flag");
		}

		if(var_0E)
		{
			if(func_32DF("g"))
			{
				func_846C();
			}
		}

		if(func_32E0("h","F1") && !level.var_BD5D)
		{
			func_100E3();
			wait(0.05);
			continue;
		}

		if(func_32DF("BUTTON_LSTICK"))
		{
			func_4641();
		}

		if(func_32DF("BUTTON_RSTICK"))
		{
			func_C94D();
		}

		if(var_0D)
		{
			if(func_32DF("c"))
			{
				func_4641();
			}

			if(func_32DF("v"))
			{
				func_C94D();
			}

			if(func_32DF("g"))
			{
				func_1071F();
			}
		}

		if(isdefined(level.var_11B7.var_F1B4))
		{
			scripts\common\createfxmenu::func_B66B();
		}

		for(var_12 = 0;var_12 < level.var_49C9.size;var_12++)
		{
			var_03 = level.var_49C9[var_12];
			var_13 = vectornormalize(var_03.var_13125["origin"] - level.player.origin + (0,0,55));
			var_14 = vectordot(var_08,var_13);
			if(var_14 < var_0A)
			{
				continue;
			}

			var_0A = var_14;
			var_0C = var_03;
		}

		level.var_7593 = var_0C;
		if(isdefined(var_0C))
		{
			if(isdefined(var_01))
			{
				if(var_01 != var_0C)
				{
					if(!func_65F2(var_01))
					{
						var_01 thread func_663E();
					}

					if(!func_65F2(var_0C))
					{
						var_0C thread func_663F();
					}
				}
			}
			else if(!func_65F2(var_0C))
			{
				var_0C thread func_663F();
			}
		}

		func_B2F9(var_0C,var_0F,var_10,var_0D,var_07);
		var_06 = func_895B(var_06);
		wait(0.05);
		if(var_06)
		{
			func_12E21();
		}

		if(!level.var_BD5D)
		{
			var_00 = [[ level.var_74D0 ]](var_00);
		}

		var_01 = var_0C;
		if(func_A902(var_05))
		{
			level.var_5FE0 = 0;
			func_417F();
			scripts\common\createfxmenu::func_F796("none");
		}

		if(level.var_11B7.var_F1B3.size)
		{
			var_05 = level.var_11B7.var_F1B3[level.var_11B7.var_F1B3.size - 1];
			continue;
		}

		var_05 = undefined;
	}
}

//Function Number: 20
func_B933()
{
	var_00 = 0;
	var_01 = func_32E0("ctrl");
	if(func_32E0("."))
	{
		if(var_01)
		{
			if(level.var_11B7.var_D2C7 < 190)
			{
				level.var_11B7.var_D2C7 = 190;
			}
			else
			{
				level.var_11B7.var_D2C7 = level.var_11B7.var_D2C7 + 10;
			}
		}
		else
		{
			level.var_11B7.var_D2C7 = level.var_11B7.var_D2C7 + 5;
		}

		var_00 = 1;
	}
	else if(func_32E0(","))
	{
		if(var_01)
		{
			if(level.var_11B7.var_D2C7 > 190)
			{
				level.var_11B7.var_D2C7 = 190;
			}
			else
			{
				level.var_11B7.var_D2C7 = level.var_11B7.var_D2C7 - 10;
			}
		}
		else
		{
			level.var_11B7.var_D2C7 = level.var_11B7.var_D2C7 - 5;
		}

		var_00 = 1;
	}

	if(var_00)
	{
		level.var_11B7.var_D2C7 = clamp(level.var_11B7.var_D2C7,5,500);
		[[ level.var_74CE ]]();
		func_F54D();
	}
}

//Function Number: 21
func_F54D()
{
	if(level.var_BD5D)
	{
		return;
	}

	if(!isdefined(level.var_11B7.var_D2CB))
	{
		var_00 = newhudelem();
		var_00.alignx = "right";
		var_00.foreground = 1;
		var_00.fontscale = 1.2;
		var_00.alpha = 0.2;
		var_00.x = 320;
		var_00.y = 420;
		var_01 = newhudelem();
		var_01.alignx = "left";
		var_01.foreground = 1;
		var_01.fontscale = 1.2;
		var_01.alpha = 0.2;
		var_01.x = 320;
		var_01.y = 420;
		var_00.var_9168 = var_01;
		level.var_11B7.var_D2CB = var_00;
	}

	level.var_11B7.var_D2CB.var_9168 setvalue(level.var_11B7.var_D2C7);
}

//Function Number: 22
func_119B4()
{
	level.var_49BB = !level.var_49BB;
}

//Function Number: 23
func_990C()
{
	scripts\common\createfxmenu::func_F796("creation");
	level.var_5FE0 = 0;
	func_4152();
	func_F3C4("Pick effect type to create:");
	func_F3C4("1. One Shot FX");
	if(!level.var_BD5D)
	{
		func_F3C4("2. Looping FX");
		func_F3C4("3. Looping sound");
		func_F3C4("4. Exploder");
		func_F3C4("5. One Shot Sound");
		func_F3C4("6. Reactive FX");
	}
	else
	{
		func_F3C4("2. Looping sound");
		func_F3C4("3. Exploder");
		func_F3C4("4. One Shot Sound");
		func_F3C4("5. Reactive FX");
	}

	func_F3C4("(c) Cancel >");
	func_F3C4("(x) Exit >");
}

//Function Number: 24
func_9BD2(param_00,param_01)
{
	if(param_01 != "")
	{
		if(isdefined(param_00.var_13125["type"]) && issubstr(param_00.var_13125["type"],param_01))
		{
			return 0;
		}
		else if(isdefined(param_00.var_13125["fxid"]) && issubstr(param_00.var_13125["fxid"],param_01))
		{
			return 0;
		}
		else if(isdefined(param_00.var_13125["soundalias"]) && issubstr(param_00.var_13125["soundalias"],param_01))
		{
			return 0;
		}

		return 1;
	}

	return 0;
}

//Function Number: 25
func_B2F9(param_00,param_01,param_02,param_03,param_04)
{
	if(!level.var_49BB)
	{
		return;
	}

	if(level.var_11B7.var_F191)
	{
		level.var_11B7.var_F191 = 0;
		param_00 = undefined;
	}
	else if(func_F193())
	{
		param_00 = undefined;
	}

	for(var_05 = 0;var_05 < level.var_49C9.size;var_05++)
	{
		var_06 = level.var_49C9[var_05];
		if(!var_06.var_5B7F)
		{
			continue;
		}

		if(func_9BD2(var_06,getdvar("createfx_filter")))
		{
			continue;
		}

		var_07 = getdvarfloat("createfx_scaleid");
		if(isdefined(param_00) && var_06 == param_00)
		{
			if(!scripts\common\createfxmenu::func_6634())
			{
				scripts\common\createfxmenu::func_56B8(var_06);
			}

			if(param_01)
			{
				var_08 = func_93FF(var_05);
				level.var_49C6 = !var_08;
				if(!param_03)
				{
					var_09 = level.var_11B7.var_F1B3.size;
					func_414D();
					if(var_08 && var_09 == 1)
					{
						func_F197(var_05,var_06);
					}
				}

				func_119B8(var_05,var_06);
			}
			else if(param_02)
			{
				if(param_03)
				{
					if(level.var_49C6)
					{
						func_F197(var_05,var_06);
					}

					if(!level.var_49C6)
					{
						func_5265(var_05,var_06);
					}
				}
			}

			var_0A = "highlighted";
		}
		else
		{
			var_0A = "default";
		}

		if(func_93FF(var_05))
		{
			var_0A = "selected";
		}

		var_06 func_49C5(var_0A,var_07,param_04);
	}
}

//Function Number: 26
func_5B55(param_00,param_01)
{
	var_02 = level.player method_816E();
	var_03 = level.player getplayerangles();
	var_04 = level.var_11B7.var_43AE[self.var_13125["type"]][param_01];
	var_05 = 0;
	var_06 = 1;
	var_07 = (0,0,0);
	var_08 = distancesquared(var_02,self.var_13125["origin"]) < -28672;
	if(var_08)
	{
		var_09 = distance(var_02,self.var_13125["origin"]);
		var_0A = var_09 / 176;
		var_05 = 1 - clamp(var_0A,0,1);
		var_06 = clamp(var_0A,0.333,1);
		var_0B = anglestoright(var_03) * -4;
		var_0C = anglestoup(var_03) * -4.666;
		var_07 = var_0B + var_0C;
	}

	if(var_05 > 0)
	{
		var_0D = scripts\common\utility::func_13D90(var_02,var_03,self.var_13125["origin"],0.422618);
		if(var_0D)
		{
			var_0E = 2;
			var_0F = 4;
			var_10 = anglestoforward(self.var_13125["angles"]);
			var_10 = var_10 * var_0F * param_00;
			var_11 = anglestoright(self.var_13125["angles"]) * -1;
			var_11 = var_11 * var_0F * param_00;
			var_12 = anglestoup(self.var_13125["angles"]);
			var_12 = var_12 * var_0F * param_00;
		}
	}
}

//Function Number: 27
func_49C5(param_00,param_01,param_02)
{
	func_5B55(param_01,param_00);
	if(self.var_11763 > 0)
	{
		var_03 = func_7BD9();
		var_04 = param_02 * var_03[0].size * -2.93;
		var_05 = level.var_11B7.var_43AE[self.var_13125["type"]][param_00];
		if(isdefined(self.var_9C80))
		{
			var_05 = (1,0.5,0);
		}

		var_06 = 15;
		foreach(var_08 in var_03)
		{
			var_06 = var_06 - 13;
		}

		if(isdefined(self.var_13125["reactive_radius"]))
		{
			if(self.var_13125["fxid"] == "No FX" && !getdvarint("createfx_vfxonly"))
			{
				return;
			}
		}
	}
}

//Function Number: 28
func_7BD9()
{
	switch(self.var_13125["type"])
	{
		case "reactive_fx":
			var_00[0] = "reactive sound: " + self.var_13125["soundalias"];
			if(!level.var_BD5D)
			{
				var_00[1] = "reactive FX: " + self.var_13125["fxid"];
			}
			return var_00;

		case "soundfx_interval":
		case "soundfx":
			return [self.var_13125["soundalias"]];

		default:
			return [self.var_13125["fxid"]];
	}
}

//Function Number: 29
func_F192()
{
	level.var_5FE0 = 0;
	func_4152();
	scripts\common\createfxmenu::func_F796("select_by_name");
	scripts\common\createfxmenu::func_5B3D();
}

//Function Number: 30
func_895B(param_00)
{
	if(level.var_11B7.var_F1B3.size > 0)
	{
		param_00 = func_F1B1(param_00);
		if(!func_4B92("selected_ents"))
		{
			func_BF18("selected_ents");
			func_F5CF("Selected Ent Mode");
			func_F5CF("Mode:","move");
			func_F5CF("Rate:",level.var_11B7.var_DCE1);
			func_F5CF("Snap2Normal:",level.var_11B7.var_10388);
			func_F5CF("Snap2Angle:",level.var_11B7.var_10387[level.var_11B7.var_10386]);
		}

		if(level.var_11B7.var_26F8 && level.var_11B7.var_F1B3.size > 0)
		{
			func_F5CF("Mode:","rotate");
			thread [[ level.var_74D2 ]]();
			if(func_32DF("enter","p"))
			{
				func_E1D4();
			}

			if(func_32DF("v"))
			{
				func_463B();
			}

			for(var_01 = 0;var_01 < level.var_11B7.var_F1B3.size;var_01++)
			{
				level.var_11B7.var_F1B3[var_01] func_5B23();
			}

			if(level.var_F1C0 != 0 || level.var_F1C2 != 0 || level.var_F1C1 != 0)
			{
				param_00 = 1;
			}
		}
		else
		{
			func_F5CF("Mode:","move");
			var_02 = func_7C49();
			for(var_01 = 0;var_01 < level.var_11B7.var_F1B3.size;var_01++)
			{
				var_03 = level.var_11B7.var_F1B3[var_01];
				if(isdefined(var_03.model))
				{
					continue;
				}

				var_03 func_5B32();
				var_03.var_13125["origin"] = var_03.var_13125["origin"] + var_02;
			}

			if(distance((0,0,0),var_02) > 0)
			{
				param_00 = 1;
			}
		}
	}
	else
	{
		func_4188();
	}

	return param_00;
}

//Function Number: 31
func_F1B1(param_00)
{
	if(func_32DF("shift","BUTTON_X"))
	{
		func_119B0();
	}

	func_B934();
	if(func_32DF("s"))
	{
		func_119CD();
	}

	if(func_32DF("r"))
	{
		func_119CC();
	}

	if(func_32DF("end","l"))
	{
		func_5D0B();
		param_00 = 1;
	}

	if(func_32DF("tab","BUTTON_RSHLDR"))
	{
		func_BC69();
		param_00 = 1;
	}

	if(func_32DF("e"))
	{
		func_45F4();
		param_00 = 1;
	}

	return param_00;
}

//Function Number: 32
func_B934()
{
	var_00 = func_32E0("shift");
	var_01 = func_32E0("ctrl");
	if(func_32DF("="))
	{
		if(var_00)
		{
			level.var_11B7.var_DCE1 = level.var_11B7.var_DCE1 + 1;
		}
		else if(var_01)
		{
			if(level.var_11B7.var_DCE1 < 1)
			{
				level.var_11B7.var_DCE1 = 1;
			}
			else
			{
				level.var_11B7.var_DCE1 = level.var_11B7.var_DCE1 + 10;
			}
		}
		else
		{
			level.var_11B7.var_DCE1 = level.var_11B7.var_DCE1 + 0.1;
		}
	}
	else if(func_32DF("-"))
	{
		if(var_00)
		{
			level.var_11B7.var_DCE1 = level.var_11B7.var_DCE1 - 1;
		}
		else if(var_01)
		{
			if(level.var_11B7.var_DCE1 > 1)
			{
				level.var_11B7.var_DCE1 = 1;
			}
			else
			{
				level.var_11B7.var_DCE1 = 0.1;
			}
		}
		else
		{
			level.var_11B7.var_DCE1 = level.var_11B7.var_DCE1 - 0.1;
		}
	}

	level.var_11B7.var_DCE1 = clamp(level.var_11B7.var_DCE1,0.1,100);
	func_F5CF("Rate:",level.var_11B7.var_DCE1);
}

//Function Number: 33
func_119B0()
{
	level.var_11B7.var_26F8 = !level.var_11B7.var_26F8;
}

//Function Number: 34
func_119CD()
{
	level.var_11B7.var_10388 = !level.var_11B7.var_10388;
	func_F5CF("Snap2Normal:",level.var_11B7.var_10388);
}

//Function Number: 35
func_119CC()
{
	level.var_11B7.var_10386 = level.var_11B7.var_10386 + 1;
	if(level.var_11B7.var_10386 >= level.var_11B7.var_10387.size)
	{
		level.var_11B7.var_10386 = 0;
	}

	func_F5CF("Snap2Angle:",level.var_11B7.var_10387[level.var_11B7.var_10386]);
}

//Function Number: 36
func_463B()
{
	level notify("new_ent_selection");
	for(var_00 = 0;var_00 < level.var_11B7.var_F1B3.size;var_00++)
	{
		var_01 = level.var_11B7.var_F1B3[var_00];
		var_01.var_13125["angles"] = level.var_11B7.var_F1B3[level.var_11B7.var_F1B3.size - 1].var_13125["angles"];
		var_01 func_F3BD();
	}

	func_12E21();
}

//Function Number: 37
func_E1D4()
{
	level notify("new_ent_selection");
	for(var_00 = 0;var_00 < level.var_11B7.var_F1B3.size;var_00++)
	{
		var_01 = level.var_11B7.var_F1B3[var_00];
		var_01.var_13125["angles"] = (0,0,0);
		var_01 func_F3BD();
	}

	func_12E21();
}

//Function Number: 38
func_A902(param_00)
{
	if(isdefined(param_00))
	{
		if(!scripts\common\createfxmenu::func_6634())
		{
			return 1;
		}
	}
	else
	{
		return scripts\common\createfxmenu::func_6634();
	}

	return param_00 != level.var_11B7.var_F1B3[level.var_11B7.var_F1B3.size - 1];
}

//Function Number: 39
func_5D0B()
{
	for(var_00 = 0;var_00 < level.var_11B7.var_F1B3.size;var_00++)
	{
		var_01 = level.var_11B7.var_F1B3[var_00];
		var_02 = bullettrace(var_01.var_13125["origin"],var_01.var_13125["origin"] + (0,0,-2048),0,undefined);
		var_01.var_13125["origin"] = var_02["position"];
	}
}

//Function Number: 40
func_F4A9()
{
	level notify("createfx_exploder_reset");
	var_00 = [];
	for(var_01 = 0;var_01 < level.var_11B7.var_F1B3.size;var_01++)
	{
		var_02 = level.var_11B7.var_F1B3[var_01];
		if(isdefined(var_02.var_13125["exploder"]))
		{
			var_00[var_02.var_13125["exploder"]] = 1;
		}
	}

	var_03 = getarraykeys(var_00);
	for(var_01 = 0;var_01 < var_03.size;var_01++)
	{
		scripts\common\utility::exploder(var_03[var_01]);
	}
}

//Function Number: 41
func_5B3A()
{
	var_00 = 0;
	if(getdvarint("createfx_drawdist") == 0)
	{
	}

	for(;;)
	{
		var_01 = getdvarint("createfx_drawdist");
		var_01 = var_01 * var_01;
		for(var_02 = 0;var_02 < level.var_49C9.size;var_02++)
		{
			var_03 = level.var_49C9[var_02];
			var_03.var_5B7F = distancesquared(level.player.origin,var_03.var_13125["origin"]) <= var_01;
			var_00++;
			if(var_00 > 100)
			{
				var_00 = 0;
				wait(0.05);
			}
		}

		if(level.var_49C9.size == 0)
		{
			wait(0.05);
		}
	}
}

//Function Number: 42
func_49B6()
{
	setdvarifuninitialized("createfx_autosave_time","300");
	for(;;)
	{
		wait(getdvarint("createfx_autosave_time"));
		scripts\common\utility::func_6E5A("createfx_saving");
		if(getdvarint("createfx_no_autosave"))
		{
			continue;
		}

		func_772B(1);
	}
}

//Function Number: 43
func_E70F(param_00,param_01)
{
	level endon("new_ent_selection");
	var_02 = 0.1;
	for(var_03 = 0;var_03 < var_02 * 20;var_03++)
	{
		if(level.var_F1C0 != 0)
		{
			param_00 method_8002(level.var_F1C0);
		}
		else if(level.var_F1C2 != 0)
		{
			param_00 method_8004(level.var_F1C2);
		}
		else
		{
			param_00 method_8003(level.var_F1C1);
		}

		wait(0.05);
		param_00 func_5B23();
		for(var_04 = 0;var_04 < level.var_11B7.var_F1B3.size;var_04++)
		{
			var_05 = level.var_11B7.var_F1B3[var_04];
			if(isdefined(var_05.model))
			{
				continue;
			}

			var_05.var_13125["origin"] = param_01[var_04].origin;
			var_05.var_13125["angles"] = param_01[var_04].angles;
		}
	}
}

//Function Number: 44
func_518B()
{
	if(level.var_49C0)
	{
		func_E087();
		return;
	}

	func_5191();
}

//Function Number: 45
func_E087()
{
	if(!isdefined(level.var_11B7.var_F1B4))
	{
		return;
	}

	var_00 = level.var_11B7.var_C6C0[level.var_11B7.var_F1B4]["name"];
	for(var_01 = 0;var_01 < level.var_49C9.size;var_01++)
	{
		var_02 = level.var_49C9[var_01];
		if(!func_65F2(var_02))
		{
			continue;
		}

		var_02 func_E064(var_00);
	}

	func_12E21();
	func_417F();
}

//Function Number: 46
func_E064(param_00)
{
	self.var_13125[param_00] = undefined;
}

//Function Number: 47
func_5191()
{
	var_00 = [];
	for(var_01 = 0;var_01 < level.var_49C9.size;var_01++)
	{
		var_02 = level.var_49C9[var_01];
		if(func_65F2(var_02))
		{
			if(isdefined(var_02.var_B066))
			{
				var_02.var_B066 stoploopsound();
				var_02.var_B066 delete();
			}

			if(isdefined(var_02.var_B051))
			{
				var_02.var_B051 delete();
			}

			var_02 notify("stop_loop");
			continue;
		}

		var_00[var_00.size] = var_02;
	}

	level.var_49C9 = var_00;
	level.var_11B7.var_F1B2 = [];
	level.var_11B7.var_F1B3 = [];
	func_4152();
	func_DFC8();
}

//Function Number: 48
func_BC69()
{
	var_00 = level.var_49C8["position"];
	if(level.var_11B7.var_F1B3.size <= 0)
	{
		return;
	}

	var_01 = func_7890(level.var_11B7.var_F1B3);
	var_02 = var_01 - var_00;
	for(var_03 = 0;var_03 < level.var_11B7.var_F1B3.size;var_03++)
	{
		var_04 = level.var_11B7.var_F1B3[var_03];
		if(isdefined(var_04.model))
		{
			continue;
		}

		var_04.var_13125["origin"] = var_04.var_13125["origin"] - var_02;
		if(level.var_11B7.var_10388)
		{
			if(isdefined(level.var_49C8["normal"]))
			{
				var_04.var_13125["angles"] = vectortoangles(level.var_49C8["normal"]);
			}
		}
	}
}

//Function Number: 49
func_45F4()
{
	if(level.var_11B7.var_F1B3.size < 1)
	{
		return;
	}

	var_00 = 0;
	foreach(var_02 in level.var_11B7.var_F1B3)
	{
		if(var_02.var_13125["type"] == "oneshotfx")
		{
			var_00 = 1;
			func_49F5(var_02);
			continue;
		}
	}

	if(var_00)
	{
		scripts\common\createfxmenu::func_F796("none");
		scripts\common\createfxmenu::func_56B8(scripts\common\createfxmenu::func_7A70());
	}
}

//Function Number: 50
func_F19D()
{
	func_F197(level.var_49C9.size - 1,level.var_49C9[level.var_49C9.size - 1]);
}

//Function Number: 51
func_F190(param_00)
{
	var_01 = [];
	foreach(var_03 in level.var_11B7.var_F1B3)
	{
		if(!isdefined(var_03.var_13125[param_00]))
		{
			continue;
		}

		var_04 = var_03.var_13125[param_00];
		var_01[var_04] = 1;
	}

	foreach(var_04, var_07 in var_01)
	{
		foreach(var_09, var_03 in level.var_49C9)
		{
			if(func_93FF(var_09))
			{
				continue;
			}

			if(!isdefined(var_03.var_13125[param_00]))
			{
				continue;
			}

			if(var_03.var_13125[param_00] != var_04)
			{
				continue;
			}

			func_F197(var_09,var_03);
		}
	}

	func_12E21();
}

//Function Number: 52
func_4641()
{
	if(level.var_11B7.var_F1B3.size <= 0)
	{
		return;
	}

	var_00 = [];
	for(var_01 = 0;var_01 < level.var_11B7.var_F1B3.size;var_01++)
	{
		var_02 = level.var_11B7.var_F1B3[var_01];
		var_03 = spawnstruct();
		var_03.var_13125 = var_02.var_13125;
		var_03 func_D6CF();
		var_00[var_00.size] = var_03;
	}

	level.var_110B2 = var_00;
}

//Function Number: 53
func_D6CF()
{
	self.var_11763 = 0;
	self.var_5B7F = 1;
}

//Function Number: 54
func_C94D()
{
	if(!isdefined(level.var_110B2))
	{
		return;
	}

	func_414D();
	for(var_00 = 0;var_00 < level.var_110B2.size;var_00++)
	{
		func_1694(level.var_110B2[var_00]);
	}

	func_BC69();
	func_12E21();
	level.var_110B2 = [];
	func_4641();
}

//Function Number: 55
func_1694(param_00)
{
	level.var_49C9[level.var_49C9.size] = param_00;
	func_F19D();
}

//Function Number: 56
func_7890(param_00)
{
	var_01 = (0,0,0);
	for(var_02 = 0;var_02 < param_00.size;var_02++)
	{
		var_01 = (var_01[0] + param_00[var_02].var_13125["origin"][0],var_01[1] + param_00[var_02].var_13125["origin"][1],var_01[2] + param_00[var_02].var_13125["origin"][2]);
	}

	return (var_01[0] / param_00.size,var_01[1] / param_00.size,var_01[2] / param_00.size);
}

//Function Number: 57
func_846C()
{
	var_00 = undefined;
	if(level.var_11B7.var_F1B3.size > 0)
	{
		var_00 = func_7890(level.var_11B7.var_F1B3);
	}
	else if(isdefined(level.var_7593))
	{
		var_00 = level.var_7593.var_13125["origin"];
	}

	if(!isdefined(var_00))
	{
		return;
	}

	var_01 = vectortoangles(level.player.origin - var_00);
	var_02 = var_00 + anglestoforward(var_01) * 200;
	level.player setorigin(var_02 + (0,0,-60));
	level.player setplayerangles(vectortoangles(var_00 - var_02));
}

//Function Number: 58
func_65DA()
{
	self endon("death");
	for(;;)
	{
		func_5B23();
		wait(0.05);
	}
}

//Function Number: 59
func_E73E()
{
	if(level.var_F1C1 != 0)
	{
		return 1;
	}

	if(level.var_F1C0 != 0)
	{
		return 1;
	}

	return level.var_F1C2 != 0;
}

//Function Number: 60
func_D8F8(param_00,param_01,param_02)
{
	for(var_03 = 0;var_03 < level.var_11B7.var_C6C0.size;var_03++)
	{
		var_04 = level.var_11B7.var_C6C0[var_03];
		var_05 = var_04["name"];
		if(!isdefined(param_00.var_13125[var_05]))
		{
			continue;
		}

		if(!scripts\common\createfxmenu::func_B3C8(var_04["mask"],param_00.var_13125["type"]))
		{
			continue;
		}

		if(!level.var_BD5D)
		{
			if(scripts\common\createfxmenu::func_B3C8("fx",param_00.var_13125["type"]) && var_05 == "fxid")
			{
				continue;
			}

			if(param_00.var_13125["type"] == "exploder" && var_05 == "exploder")
			{
				continue;
			}

			var_06 = param_00.var_13125["type"] + "/" + var_05;
			if(isdefined(level.var_11B7.var_504A[var_06]) && level.var_11B7.var_504A[var_06] == param_00.var_13125[var_05])
			{
				continue;
			}
		}

		if(var_04["type"] == "string")
		{
			var_07 = param_00.var_13125[var_05] + "";
			if(var_07 == "nil")
			{
				continue;
			}

			func_3BE9(param_01 + "ent.v[ \" + var_05 + "\" ] = \" + param_00.var_13125[var_05] + "\";");
			continue;
		}

		func_3BE9(param_01 + "ent.v[ \" + var_05 + "\" ] = " + param_00.var_13125[var_05] + ";");
	}
}

//Function Number: 61
func_663E()
{
	self notify("highlight change");
	self endon("highlight change");
	for(;;)
	{
		self.var_11763 = self.var_11763 * 0.85;
		self.var_11763 = self.var_11763 - 0.05;
		if(self.var_11763 < 0)
		{
			break;
		}

		wait(0.05);
	}

	self.var_11763 = 0;
}

//Function Number: 62
func_663F()
{
	self notify("highlight change");
	self endon("highlight change");
	for(;;)
	{
		self.var_11763 = self.var_11763 + 0.05;
		self.var_11763 = self.var_11763 * 1.25;
		if(self.var_11763 > 1)
		{
			break;
		}

		wait(0.05);
	}

	self.var_11763 = 1;
}

//Function Number: 63
func_417F()
{
	level.var_49C0 = 0;
	level.var_11B7.var_F1B4 = undefined;
	func_E1EF();
}

//Function Number: 64
func_E1EF()
{
	for(var_00 = 0;var_00 < level.var_11B7.var_917B;var_00++)
	{
		level.var_11B7.var_917E[var_00][0].color = (1,1,1);
	}
}

//Function Number: 65
func_119B8(param_00,param_01)
{
	if(isdefined(level.var_11B7.var_F1B2[param_00]))
	{
		func_5265(param_00,param_01);
		return;
	}

	func_F197(param_00,param_01);
}

//Function Number: 66
func_F197(param_00,param_01)
{
	if(isdefined(level.var_11B7.var_F1B2[param_00]))
	{
		return;
	}

	func_417F();
	level notify("new_ent_selection");
	param_01 thread func_663F();
	level.var_11B7.var_F1B2[param_00] = 1;
	level.var_11B7.var_F1B3[level.var_11B7.var_F1B3.size] = param_01;
}

//Function Number: 67
func_65EE(param_00)
{
	if(!isdefined(level.var_7593))
	{
		return 0;
	}

	return param_00 == level.var_7593;
}

//Function Number: 68
func_5265(param_00,param_01)
{
	if(!isdefined(level.var_11B7.var_F1B2[param_00]))
	{
		return;
	}

	func_417F();
	level notify("new_ent_selection");
	level.var_11B7.var_F1B2[param_00] = undefined;
	if(!func_65EE(param_01))
	{
		param_01 thread func_663E();
	}

	var_02 = [];
	for(var_03 = 0;var_03 < level.var_11B7.var_F1B3.size;var_03++)
	{
		if(level.var_11B7.var_F1B3[var_03] != param_01)
		{
			var_02[var_02.size] = level.var_11B7.var_F1B3[var_03];
		}
	}

	level.var_11B7.var_F1B3 = var_02;
}

//Function Number: 69
func_93FF(param_00)
{
	return isdefined(level.var_11B7.var_F1B2[param_00]);
}

//Function Number: 70
func_65F2(param_00)
{
	for(var_01 = 0;var_01 < level.var_11B7.var_F1B3.size;var_01++)
	{
		if(level.var_11B7.var_F1B3[var_01] == param_00)
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 71
func_414D()
{
	for(var_00 = 0;var_00 < level.var_11B7.var_F1B3.size;var_00++)
	{
		if(!func_65EE(level.var_11B7.var_F1B3[var_00]))
		{
			level.var_11B7.var_F1B3[var_00] thread func_663E();
		}
	}

	level.var_11B7.var_F1B2 = [];
	level.var_11B7.var_F1B3 = [];
}

//Function Number: 72
func_5B23()
{
}

//Function Number: 73
func_F2D5(param_00)
{
	if(!isdefined(level.var_11B7.var_55))
	{
		level.var_11B7.var_55 = spawn("script_model",(0,0,0));
		return;
	}

	if(level.var_11B7.var_55.model != param_00)
	{
		level.var_11B7.var_55 setmodel(param_00);
	}
}

//Function Number: 74
func_DFC8()
{
	if(!isdefined(level.var_11B7.var_55))
	{
		return;
	}

	level.var_11B7.var_55 delete();
}

//Function Number: 75
func_5B32()
{
}

//Function Number: 76
func_119B3()
{
	level.var_11B7.var_5B6F++;
	if(level.var_11B7.var_5B6F > 2)
	{
		level.var_11B7.var_5B6F = 0;
	}

	if(level.var_11B7.var_5B6F != 1)
	{
		func_DFC8();
	}
}

//Function Number: 77
func_49B7(param_00)
{
	thread func_49B8(param_00);
}

//Function Number: 78
func_49B8(param_00)
{
	level notify("new_createfx_centerprint");
	level endon("new_createfx_centerprint");
	wait(4.5);
}

//Function Number: 79
func_7C49()
{
	var_00 = level.player getplayerangles()[1];
	var_01 = (0,var_00,0);
	var_02 = anglestoright(var_01);
	var_03 = anglestoforward(var_01);
	var_04 = anglestoup(var_01);
	var_05 = 0;
	var_06 = level.var_11B7.var_DCE1;
	if(func_32EE("kp_uparrow","DPAD_UP"))
	{
		if(level.var_F1BC < 0)
		{
			level.var_F1BC = 0;
		}

		level.var_F1BC = level.var_F1BC + var_06;
	}
	else if(func_32EE("kp_downarrow","DPAD_DOWN"))
	{
		if(level.var_F1BC > 0)
		{
			level.var_F1BC = 0;
		}

		level.var_F1BC = level.var_F1BC - var_06;
	}
	else
	{
		level.var_F1BC = 0;
	}

	if(func_32EE("kp_rightarrow","DPAD_RIGHT"))
	{
		if(level.var_F1BD < 0)
		{
			level.var_F1BD = 0;
		}

		level.var_F1BD = level.var_F1BD + var_06;
	}
	else if(func_32EE("kp_leftarrow","DPAD_LEFT"))
	{
		if(level.var_F1BD > 0)
		{
			level.var_F1BD = 0;
		}

		level.var_F1BD = level.var_F1BD - var_06;
	}
	else
	{
		level.var_F1BD = 0;
	}

	if(func_32EE("BUTTON_Y"))
	{
		if(level.var_F1BE < 0)
		{
			level.var_F1BE = 0;
		}

		level.var_F1BE = level.var_F1BE + var_06;
	}
	else if(func_32EE("BUTTON_B"))
	{
		if(level.var_F1BE > 0)
		{
			level.var_F1BE = 0;
		}

		level.var_F1BE = level.var_F1BE - var_06;
	}
	else
	{
		level.var_F1BE = 0;
	}

	var_07 = (0,0,0);
	var_07 = var_07 + var_03 * level.var_F1BC;
	var_07 = var_07 + var_02 * level.var_F1BD;
	var_07 = var_07 + var_04 * level.var_F1BE;
	return var_07;
}

//Function Number: 80
func_F2AD()
{
	var_00 = level.var_11B7.var_DCE1;
	var_01 = level.var_11B7.var_10387[level.var_11B7.var_10386];
	if(var_01 != 0)
	{
		var_00 = 0;
	}

	if(func_32EE("kp_uparrow","DPAD_UP"))
	{
		if(level.var_F1C0 < 0)
		{
			level.var_F1C0 = 0;
		}

		level.var_F1C0 = level.var_F1C0 + var_01 + var_00;
	}
	else if(func_32EE("kp_downarrow","DPAD_DOWN"))
	{
		if(level.var_F1C0 > 0)
		{
			level.var_F1C0 = 0;
		}

		level.var_F1C0 = level.var_F1C0 - var_01 - var_00;
	}
	else
	{
		level.var_F1C0 = 0;
	}

	if(func_32EE("kp_leftarrow","DPAD_LEFT"))
	{
		if(level.var_F1C2 < 0)
		{
			level.var_F1C2 = 0;
		}

		level.var_F1C2 = level.var_F1C2 + var_01 + var_00;
	}
	else if(func_32EE("kp_rightarrow","DPAD_RIGHT"))
	{
		if(level.var_F1C2 > 0)
		{
			level.var_F1C2 = 0;
		}

		level.var_F1C2 = level.var_F1C2 - var_01 - var_00;
	}
	else
	{
		level.var_F1C2 = 0;
	}

	if(func_32EE("BUTTON_Y"))
	{
		if(level.var_F1C1 < 0)
		{
			level.var_F1C1 = 0;
		}

		level.var_F1C1 = level.var_F1C1 + var_01 + var_00;
		return;
	}

	if(func_32EE("BUTTON_B"))
	{
		if(level.var_F1C1 > 0)
		{
			level.var_F1C1 = 0;
		}

		level.var_F1C1 = level.var_F1C1 - var_01 - var_00;
		return;
	}

	level.var_F1C1 = 0;
}

//Function Number: 81
func_12E21()
{
	var_00 = 0;
	foreach(var_02 in level.var_11B7.var_F1B3)
	{
		if(var_02.var_13125["type"] == "reactive_fx")
		{
			var_00 = 1;
		}

		var_02 [[ level.var_74D3 ]]();
	}

	if(var_00)
	{
		func_DE71();
	}
}

//Function Number: 82
func_10FF7()
{
	if(isdefined(self.var_B051))
	{
		self.var_B051 delete();
	}

	func_1101A();
}

//Function Number: 83
func_1101A()
{
	self notify("stop_loop");
}

//Function Number: 84
func_74C7()
{
	if(!isdefined(level.var_1247))
	{
		var_00 = getarraykeys(level._effect);
	}
	else
	{
		var_00 = getarraykeys(level._effect);
		if(var_00.size == level.var_1247.size)
		{
			return level.var_1247;
		}
	}

	var_00 = scripts\common\utility::func_1D3A(var_00);
	level.var_1247 = var_00;
	return var_00;
}

//Function Number: 85
func_E2AB()
{
	func_10FF7();
	func_F3BD();
	switch(self.var_13125["type"])
	{
		case "oneshotfx":
			scripts\common\fx::func_496F();
			break;

		case "loopfx":
			scripts\common\fx::func_4916();
			break;

		case "soundfx":
			scripts\common\fx::func_4917();
			break;

		case "soundfx_interval":
			scripts\common\fx::func_4907();
			break;
	}
}

//Function Number: 86
func_DE71()
{
	level.var_128D.var_DD56 = undefined;
	foreach(var_01 in level.var_49C9)
	{
		if(var_01.var_13125["type"] == "reactive_fx")
		{
			var_01 func_F3BD();
			var_01 scripts\common\fx::func_1734();
		}
	}
}

//Function Number: 87
func_D978()
{
	if(level.var_75DC)
	{
		return;
	}

	func_F2AD();
	if(!func_E73E())
	{
		return;
	}

	level.var_75DC = 1;
	if(level.var_11B7.var_F1B3.size > 1)
	{
		var_00 = func_7890(level.var_11B7.var_F1B3);
		var_01 = spawn("script_origin",var_00);
		var_01.var_13125["angles"] = level.var_11B7.var_F1B3[0].var_13125["angles"];
		var_01.var_13125["origin"] = var_00;
		var_02 = [];
		for(var_03 = 0;var_03 < level.var_11B7.var_F1B3.size;var_03++)
		{
			var_02[var_03] = spawn("script_origin",level.var_11B7.var_F1B3[var_03].var_13125["origin"]);
			var_02[var_03].angles = level.var_11B7.var_F1B3[var_03].var_13125["angles"];
			var_02[var_03] linkto(var_01);
		}

		func_E70F(var_01,var_02);
		var_01 delete();
		for(var_03 = 0;var_03 < var_02.size;var_03++)
		{
			var_02[var_03] delete();
		}
	}
	else if(level.var_11B7.var_F1B3.size == 1)
	{
		var_04 = level.var_11B7.var_F1B3[0];
		var_02 = spawn("script_origin",(0,0,0));
		var_02.angles = var_04.var_13125["angles"];
		if(level.var_F1C0 != 0)
		{
			var_02 method_8002(level.var_F1C0);
		}
		else if(level.var_F1C2 != 0)
		{
			var_02 method_8004(level.var_F1C2);
		}
		else
		{
			var_02 method_8003(level.var_F1C1);
		}

		var_04.var_13125["angles"] = var_02.angles;
		var_02 delete();
		wait(0.05);
	}

	level.var_75DC = 0;
}

//Function Number: 88
func_1071F()
{
	playfx(level.var_11B7.var_15F.var_7542,level.var_49C8["position"]);
	level.var_11B7.var_15F playsound(level.var_11B7.var_15F.var_10453);
	radiusdamage(level.var_49C8["position"],level.var_11B7.var_15F.var_257,50,5,undefined,"MOD_EXPLOSIVE");
	level notify("code_damageradius",undefined,level.var_11B7.var_15F.var_257,level.var_49C8["position"]);
}

//Function Number: 89
func_100E3()
{
	func_4152();
	func_F3C4("Help:");
	func_F3C4("Insert          Insert entity");
	func_F3C4("L               Drop selected entities to the ground");
	func_F3C4("A               Add option to the selected entities");
	func_F3C4("P               Reset the rotation of the selected entities");
	func_F3C4("V               Copy the angles from the most recently selected fx onto all selected fx.");
	func_F3C4("Delete          Kill the selected entities");
	func_F3C4("ESCAPE          Cancel out of option-modify-mode, must have console open");
	func_F3C4("Ctrl-C          Copy");
	func_F3C4("Ctrl-V          Paste");
	func_F3C4("F2              Toggle createfx dot and text drawing");
	func_F3C4("F5              SAVES your work");
	func_F3C4("Dpad            Move selected entitise on X/Y or rotate pitch/yaw");
	func_F3C4("A button        Toggle the selection of the current entity");
	func_F3C4("X button        Toggle entity rotation mode");
	func_F3C4("Y button        Move selected entites up or rotate roll");
	func_F3C4("B button        Move selected entites down or rotate roll");
	func_F3C4("R Shoulder      Move selected entities to the cursor");
	func_F3C4("L Shoulder      Hold to select multiple entites");
	func_F3C4("L JoyClick      Copy");
	func_F3C4("R JoyClick      Paste");
	func_F3C4("N               UFO");
	func_F3C4("T               Toggle Timescale FAST");
	func_F3C4("Y               Toggle Timescale SLOW");
	func_F3C4("[               Toggle FX Visibility");
	func_F3C4("]               Toggle ShowTris");
	func_F3C4("F11             Toggle FX Profile");
}

//Function Number: 90
func_772B(param_00)
{
}

//Function Number: 91
func_13E01(param_00,param_01,param_02,param_03)
{
	var_04 = "\t";
	func_3BEB();
	func_3BE9("//_createfx generated. Do not touch!!");
	func_3BE9("#include scripts\\common\\utility;");
	func_3BE9("#include scripts\\common\\createfx;\n");
	func_3BE9("");
	func_3BE9("main()");
	func_3BE9("{");
	func_3BE9(var_04 + "// CreateFX " + param_01 + " entities placed: " + param_00.size);
	foreach(var_06 in param_00)
	{
		if(level.var_49C1 > 16)
		{
			level.var_49C1 = 0;
			wait(0.1);
		}

		level.var_49C1++;
		if(getdvarint("scr_map_exploder_dump"))
		{
			if(!isdefined(var_06.model))
			{
				continue;
			}
		}
		else if(isdefined(var_06.model))
		{
			continue;
		}

		if(var_06.var_13125["type"] == "oneshotfx")
		{
			func_3BE9(var_04 + "ent = createOneshotEffect( \" + var_06.var_13125["fxid"] + "\" );");
		}

		if(var_06.var_13125["type"] == "loopfx")
		{
			func_3BE9(var_04 + "ent = createLoopEffect( \" + var_06.var_13125["fxid"] + "\" );");
		}

		if(var_06.var_13125["type"] == "exploder")
		{
			if(isdefined(var_06.var_13125["exploder"]) && !level.var_BD5D)
			{
				func_3BE9(var_04 + "ent = createExploderEx( \" + var_06.var_13125["fxid"] + "\", \" + var_06.var_13125["exploder"] + "\" );");
			}
			else
			{
				func_3BE9(var_04 + "ent = createExploder( \" + var_06.var_13125["fxid"] + "\" );");
			}
		}

		if(var_06.var_13125["type"] == "soundfx")
		{
			func_3BE9(var_04 + "ent = createLoopSound();");
		}

		if(var_06.var_13125["type"] == "soundfx_interval")
		{
			func_3BE9(var_04 + "ent = createIntervalSound();");
		}

		if(var_06.var_13125["type"] == "reactive_fx")
		{
			if(param_01 == "fx" && var_06.var_13125["fxid"] != "No FX" && !level.var_BD5D)
			{
				func_3BE9(var_04 + "ent = createReactiveEnt( \" + var_06.var_13125["fxid"] + "\" );");
			}
			else if(param_01 == "sound" && var_06.var_13125["fxid"] == "No FX")
			{
				func_3BE9(var_04 + "ent = createReactiveEnt();");
			}
			else
			{
				continue;
			}
		}

		func_3BE9(var_04 + "ent set_origin_and_angles( " + var_06.var_13125["origin"] + ", " + var_06.var_13125["angles"] + " );");
		func_D8F8(var_06,var_04,param_02);
		func_3BE9("");
	}

	func_3BE9("}");
	func_3BE9(" ");
	func_3BEA(param_02,param_03,param_01);
}

//Function Number: 92
func_49B5()
{
	var_00 = 0.1;
	foreach(var_02 in level.var_49C9)
	{
		var_03 = [];
		var_04 = [];
		for(var_05 = 0;var_05 < 3;var_05++)
		{
			var_03[var_05] = var_02.var_13125["origin"][var_05];
			var_04[var_05] = var_02.var_13125["angles"][var_05];
			if(var_03[var_05] < var_00 && var_03[var_05] > var_00 * -1)
			{
				var_03[var_05] = 0;
			}

			if(var_04[var_05] < var_00 && var_04[var_05] > var_00 * -1)
			{
				var_04[var_05] = 0;
			}
		}

		var_02.var_13125["origin"] = (var_03[0],var_03[1],var_03[2]);
		var_02.var_13125["angles"] = (var_04[0],var_04[1],var_04[2]);
	}
}

//Function Number: 93
func_78F2(param_00)
{
	var_01 = func_78F3(param_00);
	var_02 = [];
	foreach(var_05, var_04 in var_01)
	{
		var_02[var_05] = [];
	}

	foreach(var_07 in level.var_49C9)
	{
		var_08 = 0;
		foreach(var_05, param_00 in var_01)
		{
			if(var_07.var_13125["type"] != param_00)
			{
				continue;
			}

			var_08 = 1;
			var_02[var_05][var_02[var_05].size] = var_07;
			break;
		}
	}

	var_0B = [];
	for(var_0C = 0;var_0C < var_01.size;var_0C++)
	{
		foreach(var_07 in var_02[var_0C])
		{
			var_0B[var_0B.size] = var_07;
		}
	}

	return var_0B;
}

//Function Number: 94
func_78F3(param_00)
{
	var_01 = [];
	if(param_00 == "fx")
	{
		var_01[0] = "oneshotfx";
		var_01[1] = "loopfx";
		var_01[2] = "exploder";
		var_01[3] = "reactive_fx";
	}
	else
	{
		var_01[0] = "soundfx";
		var_01[1] = "soundfx_interval";
		var_01[2] = "reactive_fx";
	}

	return var_01;
}

//Function Number: 95
func_3DC5(param_00,param_01)
{
	if(param_00.var_13125["fxid"] != "No FX" && param_01 == "fx")
	{
		return 1;
	}

	if(param_00.var_13125["fxid"] == "No FX" && param_01 == "sound")
	{
		return 1;
	}

	return 0;
}

//Function Number: 96
func_9BAD(param_00,param_01)
{
	var_02 = func_78F3(param_01);
	if(param_00.var_13125["type"] == "reactive_fx")
	{
		if(func_3DC5(param_00,param_01))
		{
			return 1;
		}
		else
		{
			return 0;
		}
	}

	foreach(var_04 in var_02)
	{
		if(param_00.var_13125["type"] == var_04)
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 97
func_49BF()
{
	var_00 = [];
	var_00[var_00.size] = "soundfx";
	var_00[var_00.size] = "oneshotfx";
	var_00[var_00.size] = "exploder";
	var_00[var_00.size] = "soundfx_interval";
	var_00[var_00.size] = "reactive_fx";
	if(!level.var_BD5D)
	{
		var_00[var_00.size] = "loopfx";
	}

	var_01 = [];
	foreach(var_04, var_03 in var_00)
	{
		var_01[var_04] = [];
	}

	foreach(var_06 in level.var_49C9)
	{
		var_07 = 0;
		foreach(var_04, var_09 in var_00)
		{
			if(var_06.var_13125["type"] != var_09)
			{
				continue;
			}

			var_07 = 1;
			var_01[var_04][var_01[var_04].size] = var_06;
			break;
		}
	}

	var_0B = [];
	for(var_0C = 0;var_0C < var_00.size;var_0C++)
	{
		foreach(var_06 in var_01[var_0C])
		{
			var_0B[var_0B.size] = var_06;
		}
	}

	level.var_49C9 = var_0B;
}

//Function Number: 98
func_3BEB()
{
	scripts\common\utility::func_6C05();
}

//Function Number: 99
func_3BE9(param_00)
{
	scripts\common\utility::fileprint_launcher(param_00);
}

//Function Number: 100
func_3BEA(param_00,param_01,param_02)
{
	var_03 = 1;
	if(param_01 != "" || param_00)
	{
		var_03 = 0;
	}

	if(scripts\common\utility::issp())
	{
		var_04 = scripts\common\utility::func_7CF1() + param_01 + "_" + param_02 + ".gsc";
		if(param_00)
		{
			var_04 = "backup_" + param_02 + ".gsc";
		}
	}
	else
	{
		var_04 = scripts\common\utility::func_7CF1() + param_02 + "_" + var_03 + ".gsc";
		if(param_00)
		{
			var_04 = "backup.gsc";
		}
	}

	var_05 = scripts\common\utility::func_7CF1();
	var_06 = func_7BF9();
	var_07 = func_79E2();
	scripts\common\utility::fileprint_launcher_end_file("/share/" + var_06 + "/scripts/" + var_07 + "/maps/" + var_05 + "/gen/" + var_04,var_03);
}

//Function Number: 101
func_7BF9()
{
	if(isdefined(level.var_49BA) && level.var_49BA)
	{
		return "devraw";
	}

	return "raw";
}

//Function Number: 102
func_79E2()
{
	if(scripts\common\utility::func_9D9A())
	{
		return "cp";
	}

	if(scripts\common\utility::issp())
	{
		return "sp";
	}

	return "mp";
}

//Function Number: 103
func_D962()
{
	func_16A8("mouse1");
	func_16A8("BUTTON_RSHLDR");
	func_16A8("BUTTON_LSHLDR");
	func_16A8("BUTTON_RSTICK");
	func_16A8("BUTTON_LSTICK");
	func_16A8("BUTTON_A");
	func_16A8("BUTTON_B");
	func_16A8("BUTTON_X");
	func_16A8("BUTTON_Y");
	func_16A8("DPAD_UP");
	func_16A8("DPAD_LEFT");
	func_16A8("DPAD_RIGHT");
	func_16A8("DPAD_DOWN");
	func_1704("shift");
	func_1704("ctrl");
	func_1704("escape");
	func_1704("F1");
	func_1704("F5");
	func_1704("F4");
	func_1704("F2");
	func_1704("a");
	func_1704("e");
	func_1704("g");
	func_1704("c");
	func_1704("h");
	func_1704("i");
	func_1704("k");
	func_1704("l");
	func_1704("m");
	func_1704("p");
	func_1704("r");
	func_1704("s");
	func_1704("u");
	func_1704("v");
	func_1704("x");
	func_1704("z");
	func_1704("del");
	func_1704("end");
	func_1704("tab");
	func_1704("ins");
	func_1704("add");
	func_1704("space");
	func_1704("enter");
	func_1704("1");
	func_1704("2");
	func_1704("3");
	func_1704("4");
	func_1704("5");
	func_1704("6");
	func_1704("7");
	func_1704("8");
	func_1704("9");
	func_1704("0");
	func_1704("-");
	func_1704("=");
	func_1704(",");
	func_1704(".");
	func_1704("[");
	func_1704("]");
	func_1704("leftarrow");
	func_1704("rightarrow");
	func_1704("uparrow");
	func_1704("downarrow");
}

//Function Number: 104
func_AEED(param_00)
{
	if(isdefined(level.var_11B7.var_AEF7[param_00]))
	{
		return 0;
	}

	return func_A55F(param_00);
}

//Function Number: 105
func_A55F(param_00)
{
	return level.var_49C0 && isdefined(level.var_32E1[param_00]);
}

//Function Number: 106
func_16A8(param_00)
{
	if(func_AEED(param_00))
	{
		return;
	}

	if(!isdefined(level.var_32EF[param_00]))
	{
		if(level.player buttonpressed(param_00))
		{
			level.var_32EF[param_00] = 1;
			level.var_32ED[param_00] = 1;
			return;
		}

		return;
	}

	if(!level.player buttonpressed(param_00))
	{
		level.var_32EF[param_00] = undefined;
	}
}

//Function Number: 107
func_1704(param_00)
{
	level.var_32E1[param_00] = 1;
	func_16A8(param_00);
}

//Function Number: 108
func_32EE(param_00,param_01)
{
	return func_32F6(param_00) || func_32F6(param_01);
}

//Function Number: 109
func_32F6(param_00)
{
	if(!isdefined(param_00))
	{
		return 0;
	}

	if(func_A55F(param_00))
	{
		return 0;
	}

	return level.player buttonpressed(param_00);
}

//Function Number: 110
func_32E0(param_00,param_01)
{
	if(isdefined(param_01))
	{
		if(isdefined(level.var_32EF[param_01]))
		{
			return 1;
		}
	}

	return isdefined(level.var_32EF[param_00]);
}

//Function Number: 111
func_32DF(param_00,param_01)
{
	if(isdefined(param_01))
	{
		if(isdefined(level.var_32ED[param_01]))
		{
			return 1;
		}
	}

	return isdefined(level.var_32ED[param_00]);
}

//Function Number: 112
func_962A()
{
	level.var_11B7.var_917E = [];
	level.var_11B7.var_917B = 30;
	if(level.var_BD5D)
	{
		level.var_11B7.var_917B = 16;
	}

	var_00 = [];
	var_01 = [];
	var_00[0] = 0;
	var_01[0] = 0;
	var_00[1] = 1;
	var_01[1] = 1;
	var_00[2] = -2;
	var_01[2] = 1;
	var_00[3] = 1;
	var_01[3] = -1;
	var_00[4] = -2;
	var_01[4] = -1;
	level.var_41E7 = newhudelem();
	level.var_41E7.alpha = 0;
	level.var_41E7.archived = 0;
	for(var_02 = 0;var_02 < level.var_11B7.var_917B;var_02++)
	{
		var_03 = [];
		for(var_04 = 0;var_04 < 1;var_04++)
		{
			var_05 = newhudelem();
			var_05.alignx = "left";
			var_05.archived = 0;
			var_05.var_AEC4 = 0;
			var_05.foreground = 1;
			var_05.fontscale = 1.4;
			var_05.sort = 20 - var_04;
			var_05.alpha = 1;
			var_05.x = 0 + var_00[var_04];
			var_05.y = 60 + var_01[var_04] + var_02 * 15;
			if(var_04 > 0)
			{
				var_05.color = (0,0,0);
			}

			var_03[var_03.size] = var_05;
		}

		level.var_11B7.var_917E[var_02] = var_03;
	}

	var_06 = newhudelem();
	var_06.archived = 0;
	var_06.alignx = "center";
	var_06.var_AEC4 = 0;
	var_06.foreground = 1;
	var_06.fontscale = 1.4;
	var_06.sort = 20;
	var_06.alpha = 1;
	var_06.x = 320;
	var_06.y = 40;
	level.var_49B7 = var_06;
}

//Function Number: 113
func_9599()
{
	var_00 = newhudelem();
	var_00.archived = 0;
	var_00.var_AEC4 = 0;
	var_00.alignx = "center";
	var_00.aligny = "middle";
	var_00.foreground = 1;
	var_00.fontscale = 1;
	var_00.sort = 20;
	var_00.alpha = 1;
	var_00.x = 320;
	var_00.y = 233;
}

//Function Number: 114
func_4152()
{
	level.var_41E7 method_806E();
	for(var_00 = 0;var_00 < level.var_11B7.var_917B;var_00++)
	{
		for(var_01 = 0;var_01 < 1;var_01++)
		{
		}
	}

	level.var_762B = 0;
}

//Function Number: 115
func_F3C4(param_00)
{
	for(var_01 = 0;var_01 < 1;var_01++)
	{
	}

	level.var_762B++;
}

//Function Number: 116
func_9786()
{
	if(!isdefined(level.var_11B7.var_119E2))
	{
		level.var_11B7.var_119E2 = [];
	}

	if(!isdefined(level.var_11B7.var_119E1))
	{
		level.var_11B7.var_119E1 = 1;
	}

	if(!isdefined(level.var_11B7.var_119E0))
	{
		level.var_11B7.var_119E0 = "";
	}
}

//Function Number: 117
func_BF18(param_00)
{
	foreach(var_03, var_02 in level.var_11B7.var_119E2)
	{
		if(isdefined(var_02.var_13154))
		{
			var_02.var_13154 destroy();
		}

		var_02 destroy();
		level.var_11B7.var_119E2[var_03] = undefined;
	}

	level.var_11B7.var_119E0 = param_00;
}

//Function Number: 118
func_4B92(param_00)
{
	return level.var_11B7.var_119E0 == param_00;
}

//Function Number: 119
func_4188()
{
	func_BF18("");
}

//Function Number: 120
func_BF19(param_00)
{
	var_01 = newhudelem();
	var_01.archived = 0;
	var_01.alignx = "left";
	var_01.var_AEC4 = 0;
	var_01.foreground = 1;
	var_01.fontscale = 1.2;
	var_01.alpha = 1;
	var_01.x = 0;
	var_01.y = 320 + param_00 * 15;
	return var_01;
}

//Function Number: 121
func_7D0A(param_00)
{
	if(isdefined(level.var_11B7.var_119E2[param_00]))
	{
		return level.var_11B7.var_119E2[param_00];
	}

	return undefined;
}

//Function Number: 122
func_F5CF(param_00,param_01)
{
	if(level.var_BD5D)
	{
		return;
	}

	var_02 = func_7D0A(param_00);
	if(!isdefined(var_02))
	{
		var_02 = func_BF19(level.var_11B7.var_119E2.size);
		level.var_11B7.var_119E2[param_00] = var_02;
		var_02.text = param_00;
	}

	if(isdefined(param_01))
	{
		if(isdefined(var_02.var_13154))
		{
			var_03 = var_02.var_13154;
		}
		else
		{
			var_03 = func_BF19(level.var_11B7.var_119E2.size);
			var_03.x = var_03.x + 100;
			var_03.y = var_02.y;
			var_02.var_13154 = var_03;
		}

		if(isdefined(var_03.text) && var_03.text == param_01)
		{
			return;
		}

		var_03.text = param_01;
	}
}

//Function Number: 123
func_F193()
{
	var_00 = getdvar("select_by_substring");
	if(var_00 == "")
	{
		return 0;
	}

	setdvar("select_by_substring","");
	var_01 = [];
	foreach(var_04, var_03 in level.var_49C9)
	{
		if(issubstr(var_03.var_13125["fxid"],var_00))
		{
			var_01[var_01.size] = var_04;
		}
	}

	if(var_01.size == 0)
	{
		return 0;
	}

	func_5264();
	func_F19B(var_01);
	foreach(var_06 in var_01)
	{
		var_03 = level.var_49C9[var_06];
		func_F197(var_06,var_03);
	}

	return 1;
}

//Function Number: 124
func_F19B(param_00)
{
	foreach(var_02 in param_00)
	{
		var_03 = level.var_49C9[var_02];
		func_F197(var_02,var_03);
	}
}

//Function Number: 125
func_5264()
{
	foreach(var_02, var_01 in level.var_11B7.var_F1B3)
	{
		func_5265(var_02,var_01);
	}
}