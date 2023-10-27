/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: common_scripts\_createfx.gsc
 * Game: Call of Duty: WWII
 * Platform: PC
 * Function Count: 148
 * Decompile Time: 2539 ms
 * Timestamp: 10/27/2023 3:26:19 AM
*******************************************************************/

//Function Number: 1
func_8F48()
{
	return getdvar("scr_createfx_type","0") == "2";
}

//Function Number: 2
func_3F75()
{
	return getdvar("scr_createfx_type","0") == "1";
}

//Function Number: 3
func_9BC1(param_00)
{
	if(isdefined(level.var_9BA2))
	{
		if(!isdefined(level.var_9BA3))
		{
			level.var_9BA3 = [];
		}

		level.var_9BA3[level.var_9BA3.size] = level.var_9BA2.var_A265;
	}

	level.var_9BA2 = param_00;
}

//Function Number: 4
func_27E5(param_00,param_01)
{
	var_02 = spawnstruct();
	if(func_8F48())
	{
		func_9BC1(var_02);
	}
	else
	{
		if(!isdefined(level.var_2804))
		{
			level.var_2804 = [];
		}

		level.var_2804[level.var_2804.size] = var_02;
	}

	var_02.var_A265 = [];
	var_02.var_A265["type"] = param_00;
	var_02.var_A265["fxid"] = param_01;
	var_02.var_A265["angles"] = (0,0,0);
	var_02.var_A265["origin"] = (0,0,0);
	var_02.var_33DB = 1;
	if(isdefined(param_01) && isdefined(level.var_2802))
	{
		var_03 = level.var_2802[param_01];
		if(!isdefined(var_03))
		{
			var_03 = [];
		}

		var_03[var_03.size] = var_02;
		level.var_2802[param_01] = var_03;
	}

	return var_02;
}

//Function Number: 5
func_4566()
{
	return 0.5;
}

//Function Number: 6
func_45D9()
{
	return -15;
}

//Function Number: 7
func_44D0()
{
	return 0;
}

//Function Number: 8
func_4528()
{
	return 0.75;
}

//Function Number: 9
func_4527()
{
	return 2;
}

//Function Number: 10
func_2815()
{
	var_00 = spawnstruct();
	if(func_3F75())
	{
		func_9BC1(var_00);
	}
	else
	{
		if(!isdefined(level.var_2804))
		{
			level.var_2804 = [];
		}

		level.var_2804[level.var_2804.size] = var_00;
	}

	var_00.var_A265 = [];
	var_00.var_A265["type"] = "soundfx";
	var_00.var_A265["fxid"] = "No FX";
	var_00.var_A265["soundalias"] = "nil";
	var_00.var_A265["angles"] = (0,0,0);
	var_00.var_A265["origin"] = (0,0,0);
	var_00.var_A265["server_culled"] = 1;
	if(getdvar("1189") != "1")
	{
		var_00.var_A265["server_culled"] = 0;
	}

	var_00.var_33DB = 1;
	return var_00;
}

//Function Number: 11
func_280F()
{
	var_00 = func_2815();
	var_00.var_A265["type"] = "soundfx_interval";
	var_00.var_A265["delay_min"] = func_4528();
	var_00.var_A265["delay_max"] = func_4527();
	return var_00;
}

//Function Number: 12
func_27E4()
{
	var_00 = spawnstruct();
	if(func_3F75())
	{
		func_9BC1(var_00);
	}
	else
	{
		if(!isdefined(level.var_2804))
		{
			level.var_2804 = [];
		}

		level.var_2804[level.var_2804.size] = var_00;
	}

	var_00.var_A265 = [];
	var_00.var_A265["origin"] = (0,0,0);
	var_00.var_A265["dynamic_distance"] = 1000;
	var_00.var_A265["fxid"] = "No FX";
	var_00.var_A265["type"] = "soundfx_dynamic";
	var_00.var_A265["ambiencename"] = "nil";
	return var_00;
}

//Function Number: 13
func_281A()
{
	var_00 = spawnstruct();
	if(func_3F75())
	{
		func_9BC1(var_00);
	}
	else
	{
		if(!isdefined(level.var_2804))
		{
			level.var_2804 = [];
		}

		level.var_2804[level.var_2804.size] = var_00;
	}

	var_00.var_A265 = [];
	var_00.var_A265["type"] = "exploder";
	var_00.var_A265["fxid"] = "No FX";
	var_00.var_A265["soundalias"] = "nil";
	var_00.var_A265["loopsound"] = "nil";
	var_00.var_A265["angles"] = (0,0,0);
	var_00.var_A265["origin"] = (0,0,0);
	var_00.var_A265["exploder"] = 1;
	var_00.var_A265["flag"] = "nil";
	var_00.var_A265["exploder_type"] = "normal";
	var_00.var_33DB = 1;
	return var_00;
}

//Function Number: 14
func_27E8(param_00,param_01)
{
	var_02 = common_scripts\utility::func_27E7(param_00);
	var_02.var_A265["exploder"] = param_01;
	return var_02;
}

//Function Number: 15
func_2824()
{
	var_00 = spawnstruct();
	if(func_8F48())
	{
		func_9BC1(var_00);
	}
	else
	{
		if(!isdefined(level.var_2804))
		{
			level.var_2804 = [];
		}

		level.var_2804[level.var_2804.size] = var_00;
	}

	var_00.var_A265 = [];
	var_00.var_A265["origin"] = (0,0,0);
	var_00.var_A265["reactive_radius"] = 200;
	var_00.var_A265["fxid"] = "No FX";
	var_00.var_A265["type"] = "reactive_fx";
	var_00.var_A265["soundalias"] = "nil";
	return var_00;
}

//Function Number: 16
func_8543(param_00,param_01)
{
	if(isdefined(level.var_27FF))
	{
		param_00 = param_00 + level.var_27FF;
	}

	self.var_A265["origin"] = param_00;
	self.var_A265["angles"] = param_01;
}

//Function Number: 17
func_84A8()
{
	self.var_A265["up"] = anglestoup(self.var_A265["angles"]);
	self.var_A265["forward"] = anglestoforward(self.var_A265["angles"]);
}

//Function Number: 18
func_2619()
{
	setdvarifuninitialized("curr_exp_num",1);
	var_00 = getdvarint("curr_exp_num");
	for(var_01 = 0;var_01 < level.var_5ED.var_83A3.size;var_01++)
	{
		var_02 = level.var_5ED.var_83A3[var_01];
		if(var_02.var_A265["type"] == "oneshotfx")
		{
			function_014E(var_02.var_5EED,1);
			wait 0.05;
			var_02 common_scripts\utility::func_6F21();
			var_02.var_A265["type"] = "exploder";
			var_02.var_A265["exploder"] = var_00;
			var_02.var_A265["delay"] = 0;
			var_02.var_A265["exploder_type"] = "normal";
			var_02 common_scripts\utility::func_894();
			continue;
		}

		if(var_02.var_A265["type"] == "exploder")
		{
			function_014E(var_02.var_5EED,1);
			wait 0.05;
			var_02.var_A265["type"] = "oneshotfx";
			var_02 func_7CAB("exploder");
			var_02.var_A265["delay"] = -15;
			var_02 func_7CAB("exploder_type");
		}
	}

	level.var_5ED.var_5991 = 1;
}

//Function Number: 19
func_27F4()
{
	level.var_5ED = spawnstruct();
	level.var_5ED.var_B1 = spawn("script_origin",(0,0,0));
	level.var_5ED.var_B1.var_3F2F = loadfx("vfx/explosion/frag_grenade_default");
	level.var_5ED.var_B1.var_8F2C = "null";
	level.var_5ED.var_B1.var_14F = 256;
	wait 0.05;
	common_scripts\utility::func_3C87("createfx_saving");
	common_scripts\utility::func_3C87("createfx_started");
	if(!isdefined(level.var_27EE))
	{
		level.var_27EE = [];
	}

	level.var_27FD = 0;
	setdvar("ui_hidehud","1");
	level notify("createfx_common_done");
}

//Function Number: 20
func_51F6()
{
	level.var_5ED.var_83AA = 0;
	level.var_5ED.var_83A8 = 0;
	level.var_5ED.var_83A9 = 0;
	level.var_5ED.var_83AB = 0;
	level.var_5ED.var_83AC = 0;
	level.var_5ED.var_83AD = 0;
	level.var_5ED.var_83A2 = [];
	level.var_5ED.var_83A3 = [];
	level.var_5ED.var_5991 = 0;
	level.var_5ED.var_8C29 = 0;
	level.var_5ED.var_8BF0 = 0;
	level.var_5ED.var_7A76 = 1;
	level.var_5ED.var_8CFC = 0;
	level.var_5ED.var_8CFE = 0;
	level.var_5ED.var_5E43 = 0;
	level.var_5ED.var_1486 = 0;
	level.var_5ED.var_838D = 0;
	level.var_5ED.var_7332 = getdvarfloat("5502");
}

//Function Number: 21
func_51FE()
{
	level.var_5ED.var_5E6F = [];
	level.var_5ED.var_5E6F["escape"] = 1;
	level.var_5ED.var_5E6F["BUTTON_LSHLDR"] = 1;
	level.var_5ED.var_5E6F["BUTTON_RSHLDR"] = 1;
	level.var_5ED.var_5E6F["mouse1"] = 1;
	level.var_5ED.var_5E6F["ctrl"] = 1;
}

//Function Number: 22
func_5194()
{
	var_00 = [];
	var_00["loopfx"]["selected"] = (1,1,0.2);
	var_00["loopfx"]["highlighted"] = (0.4,0.95,1);
	var_00["loopfx"]["default"] = (0.3,0.8,1);
	var_00["oneshotfx"]["selected"] = (1,1,0.2);
	var_00["oneshotfx"]["highlighted"] = (0.3,0.6,1);
	var_00["oneshotfx"]["default"] = (0.1,0.2,1);
	var_00["exploder"]["selected"] = (1,1,0.2);
	var_00["exploder"]["highlighted"] = (1,0.2,0.2);
	var_00["exploder"]["default"] = (1,0.1,0.1);
	var_00["rainfx"]["selected"] = (1,1,0.2);
	var_00["rainfx"]["highlighted"] = (0.95,0.4,0.95);
	var_00["rainfx"]["default"] = (0.78,0,0.73);
	var_00["soundfx"]["selected"] = (1,1,0.2);
	var_00["soundfx"]["highlighted"] = (0.2,1,0.2);
	var_00["soundfx"]["default"] = (0.1,1,0.1);
	var_00["soundfx_interval"]["selected"] = (1,1,0.2);
	var_00["soundfx_interval"]["highlighted"] = (0.3,1,0.3);
	var_00["soundfx_interval"]["default"] = (0.1,1,0.1);
	var_00["reactive_fx"]["selected"] = (1,1,0.2);
	var_00["reactive_fx"]["highlighted"] = (0.5,1,0.75);
	var_00["reactive_fx"]["default"] = (0.2,0.9,0.2);
	var_00["soundfx_dynamic"]["selected"] = (1,1,0.2);
	var_00["soundfx_dynamic"]["highlighted"] = (0.3,1,0.3);
	var_00["soundfx_dynamic"]["default"] = (0.1,1,0.1);
	level.var_5ED.var_2508 = var_00;
}

//Function Number: 23
func_1B6D()
{
	if(level.var_64F8)
	{
		for(;;)
		{
			if(level.var_5ED.var_8BF0)
			{
			}

			wait(0.1);
		}
	}
}

//Function Number: 24
func_2808()
{
	waittillframeend;
	wait 0.05;
	wait(10);
	if(!isdefined(level.var_611))
	{
		level.var_611 = [];
	}

	if(getdvar("5855") == "")
	{
	}
	else if(getdvar("5855") == common_scripts\utility::func_4381())
	{
		[[ level.var_3F0C ]]();
	}

	func_51A1();
	common_scripts\_createfxmenu::func_5205();
	func_51E1();
	func_5272();
	func_51A1();
	func_51F6();
	func_51FE();
	func_5194();
	if(getdvar("createfx_use_f4") == "")
	{
	}

	if(getdvar("createfx_no_autosave") == "")
	{
	}

	level.var_27F5 = 1;
	level.var_5B1E = undefined;
	level.var_1DDB = [];
	var_00 = (0,0,0);
	common_scripts\utility::func_3C8F("createfx_started");
	if(!level.var_64F8)
	{
		var_00 = level.var_721C.var_116;
	}

	var_01 = undefined;
	level.var_3F4F = 0;
	common_scripts\_createfxmenu::func_86C9("none");
	level.var_2801 = 0;
	level.var_27FB = 0;
	foreach(var_03 in level.var_2804)
	{
		var_03 func_75BE();
	}

	thread func_33B3();
	var_05 = undefined;
	thread func_27F0();
	level.var_27FC = 0;
	thread func_805C();
	thread func_8875();
	thread func_1B6D();
	thread func_0646();
	for(;;)
	{
		level.var_721C notify("releasepadmonitors","createfx");
		var_06 = 0;
		var_07 = anglestoright(level.var_721C getangles());
		var_08 = anglestoforward(level.var_721C getangles());
		var_09 = anglestoup(level.var_721C getangles());
		var_0A = 0.85;
		var_0B = var_08 * 750;
		level.var_2803 = bullettrace(level.var_721C geteye(),level.var_721C geteye() + var_0B,0,undefined);
		var_0C = undefined;
		level.var_1DD8 = [];
		level.var_1DD0 = [];
		func_7745();
		var_0D = func_1DCF("ctrl","BUTTON_LSHLDR");
		var_0E = func_1DCE("mouse1","BUTTON_A");
		var_0F = func_1DCF("mouse1","BUTTON_A");
		var_10 = func_1DCF("shift");
		common_scripts\_createfxmenu::func_279D();
		var_11 = "F5";
		if(getdvarint("createfx_use_f4"))
		{
			var_11 = "F4";
		}

		if(func_1DCE(var_11))
		{
		}

		if(getdvarint("scr_createfx_dump"))
		{
			func_4014();
		}

		if(func_1DCE("F2"))
		{
			func_9A6E();
		}

		if(func_1DCE("ins"))
		{
			func_53C8();
		}

		if(func_1DCE("del"))
		{
			func_2D24();
		}

		if(func_1DCE("escape"))
		{
			func_23CB();
		}

		if(func_1DCE("rightarrow","space") && !level.var_27FE)
		{
			func_8541();
		}

		if(func_1DCE("leftarrow") && !level.var_27FE)
		{
			func_9E8B();
		}

		if(func_1DCE("f"))
		{
			func_3E70();
		}

		if(func_1DCE("j") && !var_10)
		{
			func_5984("next");
		}

		if(func_1DCE("j") && var_10)
		{
			func_5984("prev");
		}

		if(func_1DCE("u"))
		{
			func_838E();
		}

		if(func_1DCE("c"))
		{
			func_2619();
		}

		if(func_1DCE("v"))
		{
			func_8C29();
		}

		if(func_1DCE("b"))
		{
			func_8BF0();
		}

		if(func_1DCE("r") && var_10)
		{
			func_7A4E();
		}

		func_62A4();
		if(!var_0D && func_1DCE("g"))
		{
			func_838B("exploder");
			func_838B("flag");
			func_838C("fxid");
		}

		if(func_1DCE("h","F1"))
		{
			func_8BCE();
		}

		if(func_1DCE("BUTTON_LSTICK"))
		{
			func_2666();
		}

		if(func_1DCE("BUTTON_RSTICK"))
		{
			func_6EB6();
		}

		if(func_1DCE("z"))
		{
			func_A01B();
		}

		if(func_1DCE("z") && var_10)
		{
			func_7B4F();
		}

		if(var_0D)
		{
			if(func_1DCE("c"))
			{
				func_2666();
			}

			if(func_1DCE("v"))
			{
				func_6EB6();
			}

			if(func_1DCE("g"))
			{
				func_8FBB();
			}
		}

		if(isdefined(level.var_5ED.var_83A4))
		{
			common_scripts\_createfxmenu::func_610E();
		}

		for(var_12 = 0;var_12 < level.var_2804.size;var_12++)
		{
			var_03 = level.var_2804[var_12];
			var_13 = level.var_721C getvieworigin();
			var_14 = vectornormalize(var_03.var_A265["origin"] - var_13);
			var_15 = vectordot(var_08,var_14);
			if(var_15 < var_0A)
			{
				continue;
			}

			var_0A = var_15;
			var_0C = var_03;
		}

		level.var_3F43 = var_0C;
		if(isdefined(var_0C))
		{
			if(isdefined(var_01))
			{
				if(var_01 != var_0C)
				{
					if(!func_37A8(var_01))
					{
						var_01 thread func_37CA();
					}

					if(!func_37A8(var_0C))
					{
						var_0C thread func_37CB();
					}
				}
			}
			else if(!func_37A8(var_0C))
			{
				var_0C thread func_37CB();
			}
		}

		func_5FCF(var_0C,var_0E,var_0F,var_0D,var_07);
		var_06 = func_4A5A(var_06);
		wait 0.05;
		if(var_06)
		{
			func_A0CA();
		}

		if(!level.var_64F8)
		{
			var_00 = [[ level.var_3F0D ]](var_00);
		}

		var_01 = var_0C;
		if(func_5B47(var_05))
		{
			level.var_359D = 0;
			func_23CB();
			common_scripts\_createfxmenu::func_86C9("none");
		}

		if(level.var_5ED.var_83A3.size)
		{
			var_05 = level.var_5ED.var_83A3[level.var_5ED.var_83A3.size - 1];
			continue;
		}

		var_05 = undefined;
	}
}

//Function Number: 25
func_62A4()
{
	var_00 = 0;
	var_01 = func_1DCF("ctrl");
	if(func_1DCF("."))
	{
		if(var_01)
		{
			if(level.var_5ED.var_7332 < 190)
			{
				level.var_5ED.var_7332 = 190;
			}
			else
			{
				level.var_5ED.var_7332 = level.var_5ED.var_7332 + 10;
			}
		}
		else
		{
			level.var_5ED.var_7332 = level.var_5ED.var_7332 + 5;
		}

		var_00 = 1;
	}
	else if(func_1DCF(","))
	{
		if(var_01)
		{
			if(level.var_5ED.var_7332 > 190)
			{
				level.var_5ED.var_7332 = 190;
			}
			else
			{
				level.var_5ED.var_7332 = level.var_5ED.var_7332 - 10;
			}
		}
		else
		{
			level.var_5ED.var_7332 = level.var_5ED.var_7332 - 5;
		}

		var_00 = 1;
	}

	if(var_00)
	{
		level.var_5ED.var_7332 = clamp(level.var_5ED.var_7332,5,500);
		[[ level.var_3F0B ]]();
	}
}

//Function Number: 26
func_9A6E()
{
	level.var_27F5 = !level.var_27F5;
}

//Function Number: 27
func_53C8()
{
	common_scripts\_createfxmenu::func_86C9("creation");
	level.var_359D = 0;
	func_23BA();
	func_84AD("Pick effect type to create:");
	func_84AD("1. One Shot FX");
	func_84AD("2. Looping FX");
	func_84AD("3. Looping sound");
	func_84AD("4. Exploder");
	func_84AD("5. One Shot Sound");
	func_84AD("6. Reactive Sound");
	func_84AD("7. Dynamic Ambience");
	func_84AD("(x) Exit >");
}

//Function Number: 28
func_5573(param_00,param_01)
{
	if(param_01 != "")
	{
		if(isdefined(param_00.var_A265["type"]) && issubstr(param_00.var_A265["type"],param_01))
		{
			return 0;
		}
		else if(isdefined(param_00.var_A265["fxid"]) && issubstr(param_00.var_A265["fxid"],param_01))
		{
			return 0;
		}
		else if(isdefined(param_00.var_A265["soundalias"]) && issubstr(param_00.var_A265["soundalias"],param_01))
		{
			return 0;
		}
		else if(isdefined(param_00.var_A265["exploder"]) && issubstr(param_00.var_A265["exploder"],param_01))
		{
			return 0;
		}

		return 1;
	}

	return 0;
}

//Function Number: 29
func_5FCF(param_00,param_01,param_02,param_03,param_04)
{
	if(!level.var_27F5)
	{
		return;
	}

	if(level.var_5ED.var_838D)
	{
		level.var_5ED.var_838D = 0;
		param_00 = undefined;
	}
	else if(func_838F())
	{
		param_00 = undefined;
	}

	for(var_05 = 0;var_05 < level.var_2804.size;var_05++)
	{
		var_06 = level.var_2804[var_05];
		if(!var_06.var_33DB)
		{
			continue;
		}

		if(func_5573(var_06,getdvar("createfx_filter")))
		{
			continue;
		}

		var_07 = getdvarfloat("createfx_scaleid");
		if(isdefined(param_00) && var_06 == param_00)
		{
			if(!common_scripts\_createfxmenu::func_37C4())
			{
				common_scripts\_createfxmenu::func_2FF6(var_06);
			}

			if(param_01)
			{
				var_08 = func_5102(var_05);
				level.var_27F9 = 0;
				level.var_2801 = !var_08;
				if(!param_03)
				{
					var_09 = level.var_5ED.var_83A3.size;
					func_23B6();
					if(var_08 && var_09 == 1)
					{
						func_8390(var_05,var_06);
					}
				}

				func_9A6F(var_05,var_06);
			}
			else if(param_02)
			{
				if(param_03)
				{
					if(level.var_2801)
					{
						func_8390(var_05,var_06);
					}

					if(!level.var_2801)
					{
						func_2D94(var_05,var_06);
					}
				}
			}

			var_0A = "highlighted";
		}
		else
		{
			var_0A = "default";
		}

		if(func_5102(var_05))
		{
			var_0A = "selected";
		}

		var_06 func_2800(var_0A,var_07,param_04);
	}
}

//Function Number: 30
func_33C3(param_00,param_01)
{
	var_02 = level.var_721C getvieworigin();
	var_03 = level.var_721C getangles();
	var_04 = level.var_5ED.var_2508[self.var_A265["type"]][param_01];
	var_05 = 0;
	var_06 = 1;
	var_07 = (0,0,0);
	var_08 = int(max(16,getdvarfloat("createfx_crosshairdrawdist")));
	var_09 = int(max(16,getdvarfloat("createfx_accuratedrawdist")));
	var_0A = var_09 * var_09;
	var_0B = distancesquared(var_02,self.var_A265["origin"]) < var_0A * param_00;
	if(var_0B)
	{
		var_0C = distance(var_02,self.var_A265["origin"]);
		var_0D = var_0C / var_08 - 16;
		var_05 = 1 - clamp(var_0D,0,1);
		var_06 = clamp(var_0D,0.333,1);
		var_0E = anglestoright(var_03) * -2.5 * param_00;
		var_0F = anglestoup(var_03) * -3.5 * param_00;
		var_07 = var_0E + var_0F;
	}

	if(var_05 > 0)
	{
		var_10 = common_scripts\utility::func_AA4A(var_02,var_03,self.var_A265["origin"],0.422618);
		if(var_10)
		{
			var_11 = 2;
			var_12 = 4;
			var_13 = anglestoforward(self.var_A265["angles"]);
			var_13 = var_13 * var_12 * param_00;
			var_14 = anglestoright(self.var_A265["angles"]) * -1;
			var_14 = var_14 * var_12 * param_00;
			var_15 = anglestoup(self.var_A265["angles"]);
			var_15 = var_15 * var_12 * param_00;
			var_16 = 0.333;
			var_17 = var_04 * (var_16,var_16,var_16) + (1,0,0);
			var_18 = var_04 * (var_16,var_16,var_16) + (0,1,0);
			var_19 = var_04 * (var_16,var_16,var_16) + (0,0,1);
		}
	}
}

//Function Number: 31
func_2800(param_00,param_01,param_02)
{
	if(getdvarint("fx_showLightGridSampleOffset") != 0)
	{
		var_03 = getdvarfloat("4525");
		var_04 = anglestoforward(self.var_A265["angles"]) * var_03;
	}

	func_33C3(param_01,param_00);
	if(self.var_9929 > 0)
	{
		var_05 = func_42CE();
		var_06 = param_02 * var_05.size * -2.93 * param_01;
		var_07 = level.var_5ED.var_2508[self.var_A265["type"]][param_00];
		if(isdefined(self.var_55E4))
		{
			var_07 = (1,0.5,0);
		}

		if(isdefined(self.var_A265["reactive_radius"]))
		{
			return;
		}

		if(isdefined(self.var_A265["dynamic_distance"]))
		{
			return;
		}
	}
}

//Function Number: 32
func_42CE()
{
	switch(self.var_A265["type"])
	{
		case "reactive_fx":
			return "reactive: " + self.var_A265["soundalias"];

		case "soundfx_interval":
			return self.var_A265["soundalias"];

		case "soundfx_dynamic":
			return "dynamic: " + self.var_A265["ambiencename"];

		case "soundfx":
			return self.var_A265["soundalias"];

		case "exploder":
			if(isdefined(self.var_A265["soundalias"]) && self.var_A265["soundalias"] != "nil")
			{
				if(self.var_A265["fxid"] == "No FX")
				{
					return "@)) " + self.var_A265["soundalias"];
				}
				else
				{
					return self.var_A265["fxid"] + " @))";
				}
			}
			else
			{
				return self.var_A265["fxid"];
			}
	
			break;

		case "oneshotfx":
			if(isdefined(self.var_A265["soundalias"]) && self.var_A265["soundalias"] != "nil")
			{
				return self.var_A265["fxid"] + " @))";
			}
			else
			{
				return self.var_A265["fxid"];
			}
	
			break;

		default:
			return self.var_A265["fxid"];
	}
}

//Function Number: 33
func_838E()
{
	level.var_359D = 0;
	func_23BA();
	common_scripts\_createfxmenu::func_86C9("select_by_name");
	common_scripts\_createfxmenu::func_33B6();
}

//Function Number: 34
func_8C29()
{
	if(level.var_5ED.var_8C29)
	{
	}
	else
	{
	}

	level.var_5ED.var_8C29 = !level.var_5ED.var_8C29;
}

//Function Number: 35
func_8BF0()
{
	if(level.var_64F8)
	{
		level.var_5ED.var_8BF0 = !level.var_5ED.var_8BF0;
	}
}

//Function Number: 36
func_4A5A(param_00)
{
	if(level.var_5ED.var_83A3.size > 0 && level.var_27F9 == 0)
	{
		param_00 = func_83A1(param_00);
		if(!func_2906("selected_ents"))
		{
			func_6691("selected_ents");
		}

		if(!isdefined(level.var_5ED.var_7A77))
		{
			level.var_5ED.var_7A77 = "";
		}

		func_85A6("Rate",level.var_5ED.var_7A77);
		if(level.var_5ED.var_8CFC)
		{
			var_01 = "on";
			var_02 = (0,1,0);
		}
		else
		{
			var_01 = "off";
			var_02 = (0.5,0.5,0.5);
		}

		func_85A6("Snap2Normal( S ):",var_01,var_02);
		if(level.var_5ED.var_8CFE)
		{
			var_03 = "on";
			var_04 = (0,1,0);
		}
		else
		{
			var_03 = "off";
			var_04 = (0.5,0.5,0.5);
		}

		func_85A6("90deg Snap( L ):",var_03,var_04);
		if(level.var_5ED.var_5E43)
		{
			var_05 = "on";
			var_06 = (0,1,0);
		}
		else
		{
			var_05 = "off";
			var_06 = (0.5,0.5,0.5);
		}

		func_85A6("Local Rotation( R ):",var_05,var_06);
		func_85A6("Selection:",func_7E32());
		func_85A6("Camera Speed( </>):",level.var_5ED.var_7332);
		if(!level.var_64F8)
		{
			func_85A6("Dist To Cam",level.var_5ED.var_83B0);
		}

		if(level.var_5ED.var_1486 && level.var_5ED.var_83A3.size > 0)
		{
			level.var_5ED.var_7A77 = "of Rotation( -/+ ): " + level.var_5ED.var_7A76;
			thread [[ level.var_3F0E ]]();
			if(func_1DCE("p"))
			{
				func_7D2B();
			}

			if(func_1DCE("o"))
			{
				func_0B60();
			}

			if(func_1DCE("i"))
			{
				func_2662();
			}

			for(var_07 = 0;var_07 < level.var_5ED.var_83A3.size;var_07++)
			{
				level.var_5ED.var_83A3[var_07] func_33A1();
			}

			if(level.var_83AB != 0 || level.var_83AD != 0 || level.var_83AC != 0)
			{
				param_00 = 1;
			}
		}
		else
		{
			level.var_5ED.var_7A77 = "of Movement( -/+ ): " + level.var_5ED.var_7A76;
			var_08 = func_431D();
			for(var_07 = 0;var_07 < level.var_5ED.var_83A3.size;var_07++)
			{
				var_09 = level.var_5ED.var_83A3[var_07];
				if(isdefined(var_09.var_106))
				{
					continue;
				}

				if(level.var_64F8 && func_55E9(var_09.var_A265["origin"] + var_08) != 1)
				{
					func_27F1("Can\'t place FX outisde map bounds");
					var_08 = (0,0,0);
				}

				var_09.var_A265["origin"] = var_09.var_A265["origin"] + var_08;
			}

			if(distance((0,0,0),var_08) > 0)
			{
				thread func_805C();
				level.var_27FC = 0;
				param_00 = 1;
			}
		}
	}
	else
	{
		func_23D2();
	}

	return param_00;
}

//Function Number: 37
func_83A1(param_00)
{
	var_01 = func_1DCF("shift");
	if(func_1DCE("BUTTON_X"))
	{
		func_9A6D();
	}

	func_62A5();
	func_A163();
	if(func_1DCE("s"))
	{
		func_9A7A();
	}

	if(func_1DCE("l"))
	{
		func_9A7B();
	}

	if(func_1DCE("r") && !var_01)
	{
		func_9A75();
	}

	if(func_1DCE("end"))
	{
		func_348A();
		param_00 = 1;
	}

	if(func_1DCE("tab","BUTTON_RSHLDR"))
	{
		func_648C();
		param_00 = 1;
	}

	return param_00;
}

//Function Number: 38
func_62A5()
{
	var_00 = func_1DCF("shift");
	var_01 = func_1DCF("ctrl");
	if(func_1DCE("="))
	{
		if(var_00)
		{
			level.var_5ED.var_7A76 = level.var_5ED.var_7A76 + 0.025;
		}
		else if(var_01)
		{
			if(level.var_5ED.var_7A76 < 1)
			{
				level.var_5ED.var_7A76 = 1;
			}
			else
			{
				level.var_5ED.var_7A76 = level.var_5ED.var_7A76 + 10;
			}
		}
		else
		{
			level.var_5ED.var_7A76 = level.var_5ED.var_7A76 + 0.1;
		}
	}
	else if(func_1DCE("-"))
	{
		if(var_00)
		{
			level.var_5ED.var_7A76 = level.var_5ED.var_7A76 - 0.025;
		}
		else if(var_01)
		{
			if(level.var_5ED.var_7A76 > 1)
			{
				level.var_5ED.var_7A76 = 1;
			}
			else
			{
				level.var_5ED.var_7A76 = 0.1;
			}
		}
		else
		{
			level.var_5ED.var_7A76 = level.var_5ED.var_7A76 - 0.1;
		}
	}

	level.var_5ED.var_7A76 = clamp(level.var_5ED.var_7A76,0.025,100);
}

//Function Number: 39
func_9A6D()
{
	level.var_5ED.var_1486 = !level.var_5ED.var_1486;
}

//Function Number: 40
func_9A7A()
{
	level.var_5ED.var_8CFC = !level.var_5ED.var_8CFC;
	if(level.var_5ED.var_8CFC)
	{
		var_00 = "on";
		var_01 = (0,1,0);
	}
	else
	{
		var_00 = "off";
		var_01 = (0.5,0.5,0.5);
	}

	func_85A6("Snap2Normal( S ):",var_00,var_01);
}

//Function Number: 41
func_9A7B()
{
	level.var_5ED.var_8CFE = !level.var_5ED.var_8CFE;
	if(level.var_5ED.var_8CFE)
	{
		var_00 = "on";
		var_01 = (0,1,0);
	}
	else
	{
		var_00 = "off";
		var_01 = (0.5,0.5,0.5);
	}

	func_85A6("90deg Snap( L ):",var_00,var_01);
}

//Function Number: 42
func_9A75()
{
	level.var_5ED.var_5E43 = !level.var_5ED.var_5E43;
	if(level.var_5ED.var_5E43)
	{
		var_00 = "on";
		var_01 = (0,1,0);
	}
	else
	{
		var_00 = "off";
		var_01 = (0.5,0.5,0.5);
	}

	func_85A6("Local Rotation( R ):",var_00,var_01);
}

//Function Number: 43
func_A163()
{
	if(level.var_5ED.var_83A3.size < 1)
	{
		level.var_5ED.var_83B0 = 0;
		return;
	}

	if(level.var_5ED.var_83A3.size == 1)
	{
		var_00 = level.var_5ED.var_83A3[0].var_A265["origin"];
	}
	else
	{
		var_00 = func_40ED(level.var_5ED.var_83A3);
	}

	level.var_5ED.var_83B0 = distance(var_00,level.var_721C geteye());
}

//Function Number: 44
func_7E32()
{
	if(level.var_5ED.var_83A3.size < 1)
	{
		return "";
	}

	if(level.var_5ED.var_83A3.size == 1)
	{
		var_00 = "fxid";
		if(level.var_5ED.var_83A3[0].var_A265["fxid"] == "No FX")
		{
			if(isdefined(level.var_5ED.var_83A3[0].var_A265["soundalias"]) && level.var_5ED.var_83A3[0].var_A265["soundalias"] != "null")
			{
				var_00 = "soundalias";
			}
			else if(isdefined(level.var_5ED.var_83A3[0].var_A265["ambiencename"]) && level.var_5ED.var_83A3[0].var_A265["ambiencename"] != "null")
			{
				var_00 = "ambiencename";
			}
		}

		var_01 = level.var_5ED.var_83A3[0].var_A265[var_00];
		var_02 = [];
		foreach(var_05, var_04 in level.var_2804)
		{
			if(isdefined(var_04.var_A265[var_00]) && issubstr(var_04.var_A265[var_00],var_01))
			{
				if(var_00 == "soundalias")
				{
					if(var_04.var_A265["type"] == "soundfx_interval" || var_04.var_A265["type"] == "soundfx")
					{
						var_02[var_02.size] = var_05;
					}

					continue;
				}

				var_02[var_02.size] = var_05;
			}
		}

		var_06 = 0;
		if(var_02.size > 1)
		{
			for(var_05 = 0;var_05 < var_02.size;var_05++)
			{
				if(level.var_2804[var_02[var_05]] == level.var_5ED.var_83A3[0])
				{
					var_06 = var_05;
				}
			}
		}

		return var_06 + 1 + " of " + var_02.size + " placed";
	}

	return level.var_5ED.var_83A3.size + " entities";
}

//Function Number: 45
func_2662()
{
	thread func_805C();
	level notify("new_ent_selection");
	for(var_00 = 0;var_00 < level.var_5ED.var_83A3.size;var_00++)
	{
		var_01 = level.var_5ED.var_83A3[var_00];
		var_01.var_A265["angles"] = level.var_5ED.var_83A3[level.var_5ED.var_83A3.size - 1].var_A265["angles"];
		var_01 func_84A8();
	}

	func_A0CA();
	level.var_27FC = 0;
}

//Function Number: 46
func_0B60()
{
	thread func_805C();
	level notify("new_ent_selection");
	var_00 = level.var_5ED.var_83A3[level.var_5ED.var_83A3.size - 1];
	if(level.var_5ED.var_83A3.size == 1 && !level.var_64F8)
	{
		var_01 = level.var_5ED.var_83A3[0];
		var_02 = vectortoangles(-1 * [[ level.var_3F0F ]]());
		var_01.var_A265["angles"] = var_02;
		var_01 func_84A8();
	}
	else
	{
		for(var_03 = 0;var_03 < level.var_5ED.var_83A3.size - 1;var_03++)
		{
			var_01 = level.var_5ED.var_83A3[var_03];
			var_02 = vectortoangles(var_00.var_A265["origin"] - var_01.var_A265["origin"]);
			var_01.var_A265["angles"] = var_02;
			var_01 func_84A8();
		}
	}

	func_A0CA();
	level.var_27FC = 0;
}

//Function Number: 47
func_7A4E()
{
	thread func_805C();
	level notify("new_ent_selection");
	for(var_00 = 0;var_00 < level.var_5ED.var_83A3.size;var_00++)
	{
		var_01 = level.var_5ED.var_83A3[var_00];
		var_01.var_A265["delay"] = randomfloatrange(-30,-1);
	}

	func_A0CA();
	level.var_27FC = 0;
}

//Function Number: 48
func_7D2B()
{
	level notify("new_ent_selection");
	thread func_805C();
	for(var_00 = 0;var_00 < level.var_5ED.var_83A3.size;var_00++)
	{
		var_01 = level.var_5ED.var_83A3[var_00];
		var_01.var_A265["angles"] = (0,0,0);
		var_01 func_84A8();
	}

	func_A0CA();
	level.var_27FC = 0;
}

//Function Number: 49
func_5B47(param_00)
{
	if(isdefined(param_00))
	{
		if(!common_scripts\_createfxmenu::func_37C4())
		{
			return 1;
		}
	}
	else
	{
		return common_scripts\_createfxmenu::func_37C4();
	}

	return param_00 != level.var_5ED.var_83A3[level.var_5ED.var_83A3.size - 1];
}

//Function Number: 50
func_348A()
{
	thread func_805C();
	for(var_00 = 0;var_00 < level.var_5ED.var_83A3.size;var_00++)
	{
		var_01 = level.var_5ED.var_83A3[var_00];
		var_02 = bullettrace(var_01.var_A265["origin"],var_01.var_A265["origin"] + (0,0,-2048),0,undefined);
		var_01.var_A265["origin"] = var_02["position"];
	}

	level.var_27FC = 0;
}

//Function Number: 51
func_8541()
{
	level notify("createfx_exploder_reset");
	var_00 = [];
	for(var_01 = 0;var_01 < level.var_5ED.var_83A3.size;var_01++)
	{
		var_02 = level.var_5ED.var_83A3[var_01];
		if(isdefined(var_02.var_A265["exploder"]))
		{
			var_00[var_02.var_A265["exploder"]] = 1;
		}
	}

	var_03 = getarraykeys(var_00);
	for(var_01 = 0;var_01 < var_03.size;var_01++)
	{
		common_scripts\_exploder::func_392A(var_03[var_01]);
	}
}

//Function Number: 52
func_9E8B()
{
	level notify("createfx_exploder_reset");
	var_00 = [];
	for(var_01 = 0;var_01 < level.var_5ED.var_83A3.size;var_01++)
	{
		var_02 = level.var_5ED.var_83A3[var_01];
		if(isdefined(var_02.var_A265["exploder"]))
		{
			var_00[var_02.var_A265["exploder"]] = 1;
		}
	}

	var_03 = getarraykeys(var_00);
	for(var_01 = 0;var_01 < var_03.size;var_01++)
	{
		common_scripts\_exploder::func_5A01(var_03[var_01]);
	}
}

//Function Number: 53
func_33B3()
{
	var_00 = 0;
	if(getdvarint("createfx_drawdist") == 0)
	{
	}

	for(;;)
	{
		var_01 = getdvarint("createfx_drawdist");
		var_01 = var_01 * var_01;
		for(var_02 = 0;var_02 < level.var_2804.size;var_02++)
		{
			var_03 = level.var_2804[var_02];
			var_03.var_33DB = distancesquared(level.var_721C.var_116,var_03.var_A265["origin"]) <= var_01;
			var_00++;
			if(var_00 > 100)
			{
				var_00 = 0;
				wait 0.05;
			}
		}

		if(level.var_2804.size == 0)
		{
			wait 0.05;
		}
	}
}

//Function Number: 54
func_27F0()
{
	setdvarifuninitialized("createfx_autosave_time","300");
	for(;;)
	{
		wait(getdvarint("createfx_autosave_time"));
		common_scripts\utility::func_3CA9("createfx_saving");
		if(getdvarint("createfx_no_autosave"))
		{
			continue;
		}

		func_4014(1);
	}
}

//Function Number: 55
func_7EE2(param_00,param_01)
{
	level endon("new_ent_selection");
	var_02 = 0.1;
	for(var_03 = 0;var_03 < var_02 * 20;var_03++)
	{
		if(level.var_83AB != 0)
		{
			param_00 addpitch(level.var_83AB);
		}
		else if(level.var_83AC != 0)
		{
			param_00 addyaw(level.var_83AC);
		}
		else
		{
			param_00 addroll(level.var_83AD);
		}

		wait 0.05;
		param_00 func_33A1();
		for(var_04 = 0;var_04 < level.var_5ED.var_83A3.size;var_04++)
		{
			var_05 = level.var_5ED.var_83A3[var_04];
			if(isdefined(var_05.var_106))
			{
				continue;
			}

			var_05.var_A265["origin"] = param_01[var_04].var_116;
			var_05.var_A265["angles"] = param_01[var_04].var_1D;
		}
	}
}

//Function Number: 56
func_2D24()
{
	if(level.var_27FB)
	{
		func_7CB4();
		return;
	}

	func_2D27();
}

//Function Number: 57
func_7CB4()
{
	if(!isdefined(level.var_5ED.var_83A4))
	{
		return;
	}

	var_00 = level.var_5ED.var_6C1E[level.var_5ED.var_83A4]["name"];
	for(var_01 = 0;var_01 < level.var_2804.size;var_01++)
	{
		var_02 = level.var_2804[var_01];
		if(!func_37A8(var_02))
		{
			continue;
		}

		var_02 func_7CAB(var_00);
	}

	func_A0CA();
	func_23CB();
}

//Function Number: 58
func_7CAB(param_00)
{
	self.var_A265[param_00] = undefined;
}

//Function Number: 59
func_2D27()
{
	func_805C();
	var_00 = [];
	for(var_01 = 0;var_01 < level.var_2804.size;var_01++)
	{
		var_02 = level.var_2804[var_01];
		if(func_37A8(var_02))
		{
			var_02 func_93D7();
			if(isdefined(var_02.var_5EED))
			{
				var_02.var_5EED delete();
			}

			var_02 notify("stop_loop");
			continue;
		}

		var_00[var_00.size] = var_02;
	}

	level.var_2804 = var_00;
	level.var_5ED.var_83A2 = [];
	level.var_5ED.var_83A3 = [];
	func_23BA();
	func_805A();
}

//Function Number: 60
func_648C()
{
	thread func_805C();
	var_00 = level.var_2803["position"];
	if(level.var_5ED.var_83A3.size <= 0)
	{
		return;
	}

	if(level.var_64F8 && func_55E9(var_00) != 1)
	{
		func_27F1("Can\'t Place FX Outside Map Bounds");
		return;
	}

	var_01 = func_40ED(level.var_5ED.var_83A3);
	var_02 = var_01 - var_00;
	for(var_03 = 0;var_03 < level.var_5ED.var_83A3.size;var_03++)
	{
		var_04 = level.var_5ED.var_83A3[var_03];
		if(isdefined(var_04.var_106))
		{
			continue;
		}

		var_04.var_A265["origin"] = var_04.var_A265["origin"] - var_02;
		if(level.var_5ED.var_8CFC)
		{
			if(isdefined(level.var_2803["normal"]))
			{
				var_04.var_A265["angles"] = vectortoangles(level.var_2803["normal"]);
			}
		}
	}

	level.var_27FC = 0;
}

//Function Number: 61
func_8392()
{
	func_8390(level.var_2804.size - 1,level.var_2804[level.var_2804.size - 1]);
}

//Function Number: 62
func_7D27()
{
	var_00 = [];
	for(var_01 = 0;var_01 < level.var_2804.size;var_01++)
	{
		if(func_5102(var_01))
		{
			var_00[var_00.size] = var_01;
		}
	}

	func_23B6();
	func_8391(var_00);
}

//Function Number: 63
func_838B(param_00)
{
	var_01 = [];
	foreach(var_03 in level.var_5ED.var_83A3)
	{
		if(!isdefined(var_03.var_A265[param_00]))
		{
			continue;
		}

		var_04 = var_03.var_A265[param_00];
		var_01[var_04] = 1;
	}

	foreach(var_04, var_07 in var_01)
	{
		foreach(var_09, var_03 in level.var_2804)
		{
			if(func_5102(var_09))
			{
				continue;
			}

			if(!isdefined(var_03.var_A265[param_00]))
			{
				continue;
			}

			if(var_03.var_A265[param_00] != var_04)
			{
				continue;
			}

			func_8390(var_09,var_03);
		}
	}

	func_A0CA();
}

//Function Number: 64
func_838C(param_00)
{
	var_01 = [];
	foreach(var_03 in level.var_5ED.var_83A3)
	{
		if(!isdefined(var_03.var_A265[param_00]) || var_03.var_A265["type"] != "oneshotfx")
		{
			continue;
		}

		var_04 = var_03.var_A265[param_00];
		var_01[var_04] = 1;
	}

	foreach(var_04, var_07 in var_01)
	{
		foreach(var_09, var_03 in level.var_2804)
		{
			if(func_5102(var_09))
			{
				continue;
			}

			if(!isdefined(var_03.var_A265[param_00]))
			{
				continue;
			}

			if(var_03.var_A265[param_00] != var_04)
			{
				continue;
			}

			func_8390(var_09,var_03);
		}
	}

	func_A0CA();
}

//Function Number: 65
func_2666()
{
	if(level.var_5ED.var_83A3.size <= 0)
	{
		return;
	}

	var_00 = [];
	for(var_01 = 0;var_01 < level.var_5ED.var_83A3.size;var_01++)
	{
		var_02 = level.var_5ED.var_83A3[var_01];
		var_03 = spawnstruct();
		var_03.var_A265 = var_02.var_A265;
		var_03 func_75BE();
		var_00[var_00.size] = var_03;
	}

	level.var_9425 = var_00;
}

//Function Number: 66
func_75BE()
{
	self.var_9929 = 0;
	self.var_33DB = 1;
}

//Function Number: 67
func_6EB6()
{
	if(!isdefined(level.var_9425))
	{
		return;
	}

	func_23B6();
	for(var_00 = 0;var_00 < level.var_9425.size;var_00++)
	{
		func_08FE(level.var_9425[var_00]);
	}

	func_648C();
	func_A0CA();
	level.var_9425 = [];
	func_2666();
}

//Function Number: 68
func_08FE(param_00)
{
	level.var_2804[level.var_2804.size] = param_00;
	func_8392();
}

//Function Number: 69
func_40ED(param_00)
{
	var_01 = (0,0,0);
	for(var_02 = 0;var_02 < param_00.size;var_02++)
	{
		var_01 = (var_01[0] + param_00[var_02].var_A265["origin"][0],var_01[1] + param_00[var_02].var_A265["origin"][1],var_01[2] + param_00[var_02].var_A265["origin"][2]);
	}

	return (var_01[0] / param_00.size,var_01[1] / param_00.size,var_01[2] / param_00.size);
}

//Function Number: 70
func_42D8(param_00)
{
	var_01 = param_00[0].var_A265["origin"];
	var_02 = param_00[0].var_A265["origin"];
	var_03 = var_01[0];
	var_04 = var_01[1];
	var_05 = var_01[2];
	var_06 = var_02[0];
	var_07 = var_02[1];
	var_08 = var_02[2];
	for(var_09 = 0;var_09 < param_00.size;var_09++)
	{
		var_0A = param_00[var_09].var_A265["origin"];
		if(var_0A[0] < var_01[0])
		{
			var_03 = var_0A[0];
		}

		if(var_0A[0] > var_02[0])
		{
			var_06 = var_0A[0];
		}

		if(var_0A[1] < var_01[1])
		{
			var_04 = var_0A[1];
		}

		if(var_0A[1] > var_02[1])
		{
			var_07 = var_0A[1];
		}

		if(var_0A[2] < var_01[2])
		{
			var_05 = var_0A[2];
		}

		if(var_0A[2] > var_02[2])
		{
			var_08 = var_0A[2];
		}
	}

	var_01 = (var_03,var_04,var_05);
	var_02 = (var_06,var_07,var_08);
	var_0B = distance(var_02,var_01);
	return var_0B;
}

//Function Number: 71
func_3793()
{
	self endon("death");
	for(;;)
	{
		func_33A1();
		wait 0.05;
	}
}

//Function Number: 72
func_7EF3()
{
	if(level.var_83AC != 0)
	{
		return 1;
	}

	if(level.var_83AB != 0)
	{
		return 1;
	}

	return level.var_83AD != 0;
}

//Function Number: 73
gator_mouth_hint_func(param_00,param_01,param_02)
{
	for(var_03 = 0;var_03 < level.var_5ED.var_6C1E.size;var_03++)
	{
		var_04 = level.var_5ED.var_6C1E[var_03];
		if(isdefined(var_04["nowrite"]) && var_04["nowrite"])
		{
			continue;
		}

		var_05 = var_04["name"];
		if(!isdefined(param_00.var_A265[var_05]))
		{
			continue;
		}

		if(!common_scripts\_createfxmenu::func_6015(var_04["mask"],param_00.var_A265["type"]))
		{
			continue;
		}

		if(!level.var_64F8)
		{
			if(common_scripts\_createfxmenu::func_6015("fx",param_00.var_A265["type"]) && var_05 == "fxid")
			{
				continue;
			}

			if(param_00.var_A265["type"] == "exploder" && var_05 == "exploder")
			{
				continue;
			}

			var_06 = param_00.var_A265["type"] + "/" + var_05;
			if(isdefined(level.var_5ED.var_2BD2[var_06]) && level.var_5ED.var_2BD2[var_06] == param_00.var_A265[var_05])
			{
				continue;
			}
		}

		if(var_04["type"] == "string")
		{
			var_07 = param_00.var_A265[var_05] + "";
			if(var_07 == "nil")
			{
				continue;
			}

			if(var_05 == "platform" && var_07 == "all")
			{
				continue;
			}

			func_208A(param_01 + "ent.v[ \" + var_05 + "\" ] = \" + param_00.var_A265[var_05] + "\";");
			continue;
		}

		func_208A(param_01 + "ent.v[ \" + var_05 + "\" ] = " + param_00.var_A265[var_05] + ";");
	}
}

//Function Number: 74
func_37CA()
{
	self notify("highlight change");
	self endon("highlight change");
	for(;;)
	{
		self.var_9929 = self.var_9929 * 0.85;
		self.var_9929 = self.var_9929 - 0.05;
		if(self.var_9929 < 0)
		{
			break;
		}

		wait 0.05;
	}

	self.var_9929 = 0;
}

//Function Number: 75
func_37CB()
{
	self notify("highlight change");
	self endon("highlight change");
	for(;;)
	{
		self.var_9929 = self.var_9929 + 0.05;
		self.var_9929 = self.var_9929 * 1.25;
		if(self.var_9929 > 1)
		{
			break;
		}

		wait 0.05;
	}

	self.var_9929 = 1;
}

//Function Number: 76
func_23CB()
{
	level.var_27FB = 0;
	level.var_5ED.var_83A4 = undefined;
	func_7D35();
}

//Function Number: 77
func_7D35()
{
	for(var_00 = 0;var_00 < level.var_5ED.var_4F6C;var_00++)
	{
		level.var_5ED.var_4F6E[var_00].var_56 = (1,1,1);
	}
}

//Function Number: 78
func_9A6F(param_00,param_01)
{
	if(isdefined(level.var_5ED.var_83A2[param_00]))
	{
		func_2D94(param_00,param_01);
		return;
	}

	func_8390(param_00,param_01);
}

//Function Number: 79
func_8390(param_00,param_01)
{
	if(isdefined(level.var_5ED.var_83A2[param_00]))
	{
		return;
	}

	func_23CB();
	level notify("new_ent_selection");
	param_01 thread func_37CB();
	level.var_5ED.var_83A2[param_00] = 1;
	level.var_5ED.var_83A3[level.var_5ED.var_83A3.size] = param_01;
	level.var_27FE = 0;
}

//Function Number: 80
func_37A7(param_00)
{
	if(!isdefined(level.var_3F43))
	{
		return 0;
	}

	return param_00 == level.var_3F43;
}

//Function Number: 81
func_2D94(param_00,param_01)
{
	if(!isdefined(level.var_5ED.var_83A2[param_00]))
	{
		return;
	}

	func_23CB();
	level notify("new_ent_selection");
	level.var_5ED.var_83A2[param_00] = undefined;
	if(!func_37A7(param_01))
	{
		param_01 thread func_37CA();
	}

	var_02 = [];
	for(var_03 = 0;var_03 < level.var_5ED.var_83A3.size;var_03++)
	{
		if(level.var_5ED.var_83A3[var_03] != param_01)
		{
			var_02[var_02.size] = level.var_5ED.var_83A3[var_03];
		}
	}

	level.var_5ED.var_83A3 = var_02;
}

//Function Number: 82
func_5102(param_00)
{
	return isdefined(level.var_5ED.var_83A2[param_00]);
}

//Function Number: 83
func_37A8(param_00)
{
	for(var_01 = 0;var_01 < level.var_5ED.var_83A3.size;var_01++)
	{
		if(level.var_5ED.var_83A3[var_01] == param_00)
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 84
func_23B6()
{
	for(var_00 = 0;var_00 < level.var_5ED.var_83A3.size;var_00++)
	{
		if(!func_37A7(level.var_5ED.var_83A3[var_00]))
		{
			level.var_5ED.var_83A3[var_00] thread func_37CA();
		}
	}

	level.var_5ED.var_83A2 = [];
	level.var_5ED.var_83A3 = [];
}

//Function Number: 85
func_33A1()
{
}

//Function Number: 86
func_33B1()
{
}

//Function Number: 87
func_27F1(param_00)
{
	thread func_27F2(param_00);
}

//Function Number: 88
func_27F2(param_00)
{
	level notify("new_createfx_centerprint");
	level endon("new_createfx_centerprint");
	wait(4.5);
}

//Function Number: 89
func_431D()
{
	var_00 = level.var_721C getangles()[1];
	var_01 = (0,var_00,0);
	var_02 = anglestoright(var_01);
	var_03 = anglestoforward(var_01);
	var_04 = anglestoup(var_01);
	var_05 = 0;
	var_06 = level.var_5ED.var_7A76;
	if(func_1DD9("DPAD_UP"))
	{
		if(level.var_83A8 < 0)
		{
			level.var_83A8 = 0;
		}

		level.var_83A8 = level.var_83A8 + var_06;
	}
	else if(func_1DD9("DPAD_DOWN"))
	{
		if(level.var_83A8 > 0)
		{
			level.var_83A8 = 0;
		}

		level.var_83A8 = level.var_83A8 - var_06;
	}
	else
	{
		level.var_83A8 = 0;
	}

	if(func_1DD9("DPAD_RIGHT"))
	{
		if(level.var_83A9 < 0)
		{
			level.var_83A9 = 0;
		}

		level.var_83A9 = level.var_83A9 + var_06;
	}
	else if(func_1DD9("DPAD_LEFT"))
	{
		if(level.var_83A9 > 0)
		{
			level.var_83A9 = 0;
		}

		level.var_83A9 = level.var_83A9 - var_06;
	}
	else
	{
		level.var_83A9 = 0;
	}

	if(func_1DD9("BUTTON_Y"))
	{
		if(level.var_83AA < 0)
		{
			level.var_83AA = 0;
		}

		level.var_83AA = level.var_83AA + var_06;
	}
	else if(func_1DD9("BUTTON_B"))
	{
		if(level.var_83AA > 0)
		{
			level.var_83AA = 0;
		}

		level.var_83AA = level.var_83AA - var_06;
	}
	else
	{
		level.var_83AA = 0;
	}

	var_07 = (0,0,0);
	var_07 = var_07 + var_03 * level.var_83A8;
	var_07 = var_07 + var_02 * level.var_83A9;
	var_07 = var_07 + var_04 * level.var_83AA;
	return var_07;
}

//Function Number: 90
func_840E()
{
	if(!level.var_5ED.var_8CFE)
	{
		var_00 = level.var_5ED.var_7A76;
	}
	else
	{
		var_00 = 90;
	}

	if(func_1DD9("kp_uparrow","DPAD_UP"))
	{
		if(level.var_83AB < 0)
		{
			level.var_83AB = 0;
		}

		level.var_83AB = level.var_83AB + var_00;
	}
	else if(func_1DD9("kp_downarrow","DPAD_DOWN"))
	{
		if(level.var_83AB > 0)
		{
			level.var_83AB = 0;
		}

		level.var_83AB = level.var_83AB - var_00;
	}
	else
	{
		level.var_83AB = 0;
	}

	if(func_1DD9("DPAD_LEFT"))
	{
		if(level.var_83AD < 0)
		{
			level.var_83AD = 0;
		}

		level.var_83AD = level.var_83AD + var_00;
	}
	else if(func_1DD9("DPAD_RIGHT"))
	{
		if(level.var_83AD > 0)
		{
			level.var_83AD = 0;
		}

		level.var_83AD = level.var_83AD - var_00;
	}
	else
	{
		level.var_83AD = 0;
	}

	if(func_1DD9("BUTTON_Y"))
	{
		if(level.var_83AC < 0)
		{
			level.var_83AC = 0;
		}

		level.var_83AC = level.var_83AC + var_00;
		return;
	}

	if(func_1DD9("BUTTON_B"))
	{
		if(level.var_83AC > 0)
		{
			level.var_83AC = 0;
		}

		level.var_83AC = level.var_83AC - var_00;
		return;
	}

	level.var_83AC = 0;
}

//Function Number: 91
func_A0CA()
{
	var_00 = 0;
	foreach(var_02 in level.var_5ED.var_83A3)
	{
		if(var_02.var_A265["type"] == "reactive_fx")
		{
			var_00 = 1;
		}

		var_02 [[ level.var_3F10 ]]();
	}

	if(var_00)
	{
		func_7B8E();
	}
}

//Function Number: 92
func_93CD()
{
	if(isdefined(self.var_5EED))
	{
		self.var_5EED delete();
	}

	func_93D7();
}

//Function Number: 93
func_93D7()
{
	self notify("stop_loop");
	common_scripts\utility::func_3F51();
}

//Function Number: 94
func_3F06()
{
	if(!isdefined(level.var_612))
	{
		var_00 = getarraykeys(level.var_611);
	}
	else
	{
		var_00 = getarraykeys(level.var_611);
		if(var_00.size == level.var_612.size)
		{
			return level.var_612;
		}
	}

	var_00 = common_scripts\utility::func_C9E(var_00);
	level.var_612 = var_00;
	return var_00;
}

//Function Number: 95
func_7DCD()
{
	func_93CD();
	func_84A8();
	switch(self.var_A265["type"])
	{
		case "loopfx":
			common_scripts\_fx::func_27A7();
			break;

		case "oneshotfx":
			common_scripts\_fx::func_27C2();
			break;

		case "soundfx":
			common_scripts\_fx::func_27A8();
			break;

		case "soundfx_interval":
			common_scripts\_fx::func_27A1();
			break;

		case "soundfx_dynamic":
			common_scripts\_fx::func_2794();
			break;
	}
}

//Function Number: 96
func_7B8E()
{
	level.var_62E.var_7AAD = undefined;
	foreach(var_01 in level.var_2804)
	{
		if(var_01.var_A265["type"] == "reactive_fx")
		{
			var_01 func_84A8();
			var_01 common_scripts\_fx::func_958();
		}
	}
}

//Function Number: 97
func_774A()
{
	if(level.var_3F4F)
	{
		thread func_805C();
		level.var_27FC = 0;
		return;
	}

	func_840E();
	if(!func_7EF3())
	{
		return;
	}

	level.var_3F4F = 1;
	if(level.var_5ED.var_83A3.size > 1 && !level.var_5ED.var_5E43)
	{
		var_00 = func_40ED(level.var_5ED.var_83A3);
		var_01 = spawn("script_origin",var_00);
		var_01.var_A265["angles"] = level.var_5ED.var_83A3[0].var_A265["angles"];
		var_01.var_A265["origin"] = var_00;
		var_02 = [];
		for(var_03 = 0;var_03 < level.var_5ED.var_83A3.size;var_03++)
		{
			var_02[var_03] = spawn("script_origin",level.var_5ED.var_83A3[var_03].var_A265["origin"]);
			var_02[var_03].var_1D = level.var_5ED.var_83A3[var_03].var_A265["angles"];
			var_02[var_03] method_8449(var_01);
		}

		func_7EE2(var_01,var_02);
		var_01 delete();
		for(var_03 = 0;var_03 < var_02.size;var_03++)
		{
			var_02[var_03] delete();
		}
	}
	else if(level.var_5ED.var_83A3.size > 0)
	{
		foreach(var_05 in level.var_5ED.var_83A3)
		{
			var_02 = spawn("script_origin",(0,0,0));
			var_02.var_1D = var_05.var_A265["angles"];
			if(level.var_83AB != 0)
			{
				var_02 addpitch(level.var_83AB);
			}
			else if(level.var_83AD != 0)
			{
				var_02 addyaw(level.var_83AD);
			}
			else
			{
				var_02 addroll(level.var_83AC);
			}

			var_05.var_A265["angles"] = var_02.var_1D;
			var_02 delete();
		}

		wait 0.05;
	}

	level.var_3F4F = 0;
}

//Function Number: 98
func_8FBB()
{
	playfx(level.var_5ED.var_B1.var_3F2F,level.var_2803["position"]);
	level.var_5ED.var_B1 method_8617(level.var_5ED.var_B1.var_8F2C);
	radiusdamage(level.var_2803["position"],level.var_5ED.var_B1.var_14F,50,5,undefined,"MOD_EXPLOSIVE");
	level notify("code_damageradius",undefined,level.var_5ED.var_B1.var_14F,level.var_2803["position"]);
}

//Function Number: 99
func_8BCE()
{
	if(level.var_27F9 == 1)
	{
		func_23BA();
		level.var_27F9 = 0;
		level.var_27FE = 0;
		func_7D27();
	}
	else
	{
		level.var_27F9 = 1;
		level.var_27FE = 1;
		common_scripts\_createfxmenu::func_33B8();
		thread common_scripts\_createfxmenu::func_4CAF();
		func_23D2();
	}

	wait(0.2);
}

//Function Number: 100
func_4014(param_00)
{
}

//Function Number: 101
func_AAB7(param_00,param_01)
{
	var_02 = "\t";
	if(getdvarint("scr_map_exploder_dump"))
	{
		if(!isdefined(param_00.var_106))
		{
			return;
		}
	}
	else if(isdefined(param_00.var_106))
	{
		return;
	}

	if(param_00.var_A265["type"] == "loopfx")
	{
		func_208A(var_02 + "ent = createLoopEffect( \" + param_00.var_A265["fxid"] + "\" );");
	}

	if(param_00.var_A265["type"] == "oneshotfx")
	{
		func_208A(var_02 + "ent = createOneshotEffect( \" + param_00.var_A265["fxid"] + "\" );");
	}

	if(param_00.var_A265["type"] == "exploder")
	{
		if(isdefined(param_00.var_A265["exploder"]) && !level.var_64F8)
		{
			func_208A(var_02 + "ent = createExploderEx( \" + param_00.var_A265["fxid"] + "\", \" + param_00.var_A265["exploder"] + "\" );");
		}
		else
		{
			func_208A(var_02 + "ent = createExploder( \" + param_00.var_A265["fxid"] + "\" );");
		}
	}

	if(param_00.var_A265["type"] == "soundfx")
	{
		func_208A(var_02 + "ent = createLoopSound();");
	}

	if(param_00.var_A265["type"] == "soundfx_interval")
	{
		func_208A(var_02 + "ent = createIntervalSound();");
	}

	if(param_00.var_A265["type"] == "reactive_fx")
	{
		func_208A(var_02 + "ent = createReactiveEnt();");
	}

	if(param_00.var_A265["type"] == "soundfx_dynamic")
	{
		func_208A(var_02 + "ent = createDynamicAmbience();");
	}

	func_208A(var_02 + "ent set_origin_and_angles( " + param_00.var_A265["origin"] + ", " + param_00.var_A265["angles"] + " );");
	gator_mouth_hint_func(param_00,var_02,param_01);
	func_208A("");
}

//Function Number: 102
func_AAB8(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = "\t";
	func_208C();
	func_208A("//_createfx generated. Do not touch!!");
	func_208A("#include common_scripts\\utility;");
	func_208A("#include common_scripts\\_createfx;\n");
	func_208A("");
	func_208A("main()");
	func_208A("{");
	var_06 = param_00.size;
	if(isdefined(param_04))
	{
		var_07 = 0;
		foreach(var_09 in param_04)
		{
			if(!isdefined(var_09["radiant"]))
			{
				var_07++;
			}
		}

		var_06 = var_06 + var_07;
	}

	func_208A(var_05 + "// CreateFX " + param_01 + " entities placed: " + var_06);
	foreach(var_0C in param_00)
	{
		if(level.var_27FD > 16)
		{
			level.var_27FD = 0;
			wait(0.1);
		}

		level.var_27FD++;
		func_AAB7(var_0C,param_02);
	}

	if(isdefined(param_04))
	{
		foreach(var_09 in param_04)
		{
			if(level.var_27FD > 16)
			{
				level.var_27FD = 0;
				wait(0.1);
			}

			if(!isdefined(var_09["radiant"]))
			{
				level.var_27FD++;
				var_0C = spawnstruct();
				var_0C.var_A265 = var_09;
				func_AAB7(var_0C,param_02);
			}
		}
	}

	func_208A("}");
	func_208A(" ");
	func_208B(param_02,param_03,param_01);
}

//Function Number: 103
func_27EF()
{
	var_00 = 0.1;
	foreach(var_02 in level.var_2804)
	{
		var_03 = [];
		var_04 = [];
		for(var_05 = 0;var_05 < 3;var_05++)
		{
			var_03[var_05] = var_02.var_A265["origin"][var_05];
			var_04[var_05] = var_02.var_A265["angles"][var_05];
			if(var_03[var_05] < var_00 && var_03[var_05] > var_00 * -1)
			{
				var_03[var_05] = 0;
			}

			if(var_04[var_05] < var_00 && var_04[var_05] > var_00 * -1)
			{
				var_04[var_05] = 0;
			}
		}

		var_02.var_A265["origin"] = (var_03[0],var_03[1],var_03[2]);
		var_02.var_A265["angles"] = (var_04[0],var_04[1],var_04[2]);
	}
}

//Function Number: 104
func_4125(param_00)
{
	var_01 = func_4126(param_00);
	var_02 = [];
	foreach(var_05, var_04 in var_01)
	{
		var_02[var_05] = [];
	}

	foreach(var_07 in level.var_2804)
	{
		var_08 = 0;
		foreach(var_05, param_00 in var_01)
		{
			if(var_07.var_A265["type"] != param_00)
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

//Function Number: 105
func_4126(param_00)
{
	var_01 = [];
	if(param_00 == "fx")
	{
		var_01[0] = "loopfx";
		var_01[1] = "oneshotfx";
		var_01[2] = "exploder";
	}
	else
	{
		var_01[0] = "soundfx";
		var_01[1] = "soundfx_interval";
		var_01[2] = "reactive_fx";
		var_01[3] = "soundfx_dynamic";
	}

	return var_01;
}

//Function Number: 106
func_5556(param_00,param_01)
{
	var_02 = func_4126(param_01);
	foreach(var_04 in var_02)
	{
		if(param_00.var_A265["type"] == var_04)
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 107
func_27F8()
{
	var_00 = [];
	var_00[0] = "soundfx";
	var_00[1] = "loopfx";
	var_00[2] = "oneshotfx";
	var_00[3] = "exploder";
	var_00[4] = "soundfx_interval";
	var_00[5] = "reactive_fx";
	var_00[6] = "soundfx_dynamic";
	var_01 = [];
	foreach(var_04, var_03 in var_00)
	{
		var_01[var_04] = [];
	}

	foreach(var_06 in level.var_2804)
	{
		var_07 = 0;
		foreach(var_04, var_09 in var_00)
		{
			if(var_06.var_A265["type"] != var_09)
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

	level.var_2804 = var_0B;
}

//Function Number: 108
func_208C()
{
	common_scripts\utility::func_3AB5();
}

//Function Number: 109
func_208A(param_00)
{
	common_scripts\utility::func_3AB3(param_00);
}

//Function Number: 110
func_208B(param_00,param_01,param_02)
{
	var_03 = 1;
	if(param_01 != "" || param_00)
	{
		var_03 = 0;
	}

	if(common_scripts\utility::func_57D7())
	{
		var_04 = common_scripts\utility::func_4381() + param_01 + "_" + param_02 + ".gsc";
		if(param_00)
		{
			var_04 = "backup_" + param_02 + ".gsc";
		}
	}
	else
	{
		var_04 = common_scripts\utility::func_4381() + param_02 + "_" + var_03 + ".gsc";
		if(param_00)
		{
			var_04 = "backup.gsc";
		}
	}

	common_scripts\utility::func_3AB4("/share/raw/maps/createfx/" + var_04,var_03);
}

//Function Number: 111
func_7745()
{
	func_0905("mouse1");
	func_0905("BUTTON_RSHLDR");
	func_0905("BUTTON_LSHLDR");
	func_0905("BUTTON_RSTICK");
	func_0905("BUTTON_LSTICK");
	func_0905("BUTTON_A");
	func_0905("BUTTON_B");
	func_0905("BUTTON_X");
	func_0905("BUTTON_Y");
	func_0905("DPAD_UP");
	func_0905("DPAD_LEFT");
	func_0905("DPAD_RIGHT");
	func_0905("DPAD_DOWN");
	func_0938("shift");
	func_0938("ctrl");
	func_0938("escape");
	func_0938("F1");
	func_0938("F5");
	func_0938("F4");
	func_0938("F2");
	func_0938("a");
	func_0938("b");
	func_0938("g");
	func_0938("c");
	func_0938("h");
	func_0938("i");
	func_0938("j");
	func_0938("f");
	func_0938("k");
	func_0938("l");
	func_0938("m");
	func_0938("o");
	func_0938("p");
	func_0938("r");
	func_0938("s");
	func_0938("u");
	func_0938("v");
	func_0938("x");
	func_0938("y");
	func_0938("z");
	func_0938("del");
	func_0938("end");
	func_0938("tab");
	func_0938("ins");
	func_0938("add");
	func_0938("space");
	func_0938("enter");
	func_0938("1");
	func_0938("2");
	func_0938("3");
	func_0938("4");
	func_0938("5");
	func_0938("6");
	func_0938("7");
	func_0938("8");
	func_0938("9");
	func_0938("0");
	func_0938("-");
	func_0938("=");
	func_0938(",");
	func_0938(".");
	func_0938("[");
	func_0938("]");
	func_0938("leftarrow");
	func_0938("rightarrow");
	func_0938("uparrow");
	func_0938("downarrow");
}

//Function Number: 112
func_5E6A(param_00)
{
	if(isdefined(level.var_5ED.var_5E6F[param_00]))
	{
		return 0;
	}

	return func_5996(param_00);
}

//Function Number: 113
func_5996(param_00)
{
	return level.var_27FB && isdefined(level.var_1DD0[param_00]);
}

//Function Number: 114
func_0905(param_00)
{
	if(func_5E6A(param_00))
	{
		return;
	}

	if(!isdefined(level.var_1DDB[param_00]))
	{
		if(level.var_721C buttonpresseddevonly(param_00))
		{
			level.var_1DDB[param_00] = 1;
			level.var_1DD8[param_00] = 1;
			return;
		}

		return;
	}

	if(!level.var_721C buttonpresseddevonly(param_00))
	{
		level.var_1DDB[param_00] = undefined;
	}
}

//Function Number: 115
func_0938(param_00)
{
	level.var_1DD0[param_00] = 1;
	func_0905(param_00);
}

//Function Number: 116
func_1DD9(param_00,param_01)
{
	return func_1DDE(param_00) || func_1DDE(param_01);
}

//Function Number: 117
func_1DDE(param_00)
{
	if(!isdefined(param_00))
	{
		return 0;
	}

	if(func_5996(param_00))
	{
		return 0;
	}

	return level.var_721C buttonpresseddevonly(param_00);
}

//Function Number: 118
func_1DCF(param_00,param_01)
{
	if(isdefined(param_01))
	{
		if(isdefined(level.var_1DDB[param_01]))
		{
			return 1;
		}
	}

	return isdefined(level.var_1DDB[param_00]);
}

//Function Number: 119
func_1DCE(param_00,param_01)
{
	if(isdefined(param_01))
	{
		if(isdefined(level.var_1DD8[param_01]))
		{
			return 1;
		}
	}

	return isdefined(level.var_1DD8[param_00]);
}

//Function Number: 120
func_51E1()
{
	level.var_5ED.var_4F6E = [];
	level.var_5ED.var_4F6C = 20;
	level.var_2411 = newhudelem();
	level.var_2411.var_18 = 0;
	for(var_00 = 0;var_00 < level.var_5ED.var_4F6C;var_00++)
	{
		var_01 = newhudelem();
		var_01.accuracy = "left";
		var_01.var_5E55 = 0;
		var_01.var_A0 = 1;
		var_01.var_9B = 1.4;
		var_01.ignoreme = 20;
		var_01.var_18 = 1;
		var_01.var_1D7 = 60 + var_00 * 15;
		level.var_5ED.var_4F6E[var_00] = var_01;
	}

	var_01 = newhudelem();
	var_01.accuracy = "center";
	var_01.var_5E55 = 0;
	var_01.var_A0 = 1;
	var_01.var_9B = 1.4;
	var_01.ignoreme = 20;
	var_01.var_18 = 1;
	var_01.var_56 = (1,1,0);
	var_01.maxsightdistsqrd = 320;
	var_01.var_1D7 = 240;
	level.var_27F1 = var_01;
}

//Function Number: 121
func_51A1()
{
	var_00 = newhudelem();
	var_00.var_5E55 = 0;
	var_00.accuracy = "center";
	var_00.var_11 = "middle";
	var_00.var_A0 = 1;
	var_00.var_9B = 2;
	var_00.ignoreme = 20;
	var_00.var_18 = 1;
	var_00.maxsightdistsqrd = 320;
	var_00.var_1D7 = 233;
}

//Function Number: 122
func_23BA()
{
	level.var_2411 clearalltextafterhudelem();
	for(var_00 = 0;var_00 < level.var_5ED.var_4F6C;var_00++)
	{
	}

	level.var_3F72 = 0;
}

//Function Number: 123
func_84AD(param_00)
{
	level.var_3F72++;
}

//Function Number: 124
func_5272()
{
	if(!isdefined(level.var_5ED.var_9A91))
	{
		level.var_5ED.var_9A91 = [];
	}

	if(!isdefined(level.var_5ED.var_9A90))
	{
		level.var_5ED.var_9A90 = 1;
	}

	if(!isdefined(level.var_5ED.var_9A8F))
	{
		level.var_5ED.var_9A8F = "";
	}
}

//Function Number: 125
func_6691(param_00)
{
	foreach(var_03, var_02 in level.var_5ED.var_9A91)
	{
		if(isdefined(var_02.var_A282))
		{
			var_02.var_A282 destroy();
		}

		var_02 destroy();
		level.var_5ED.var_9A91[var_03] = undefined;
	}

	level.var_5ED.var_9A8F = param_00;
}

//Function Number: 126
func_2906(param_00)
{
	return level.var_5ED.var_9A8F == param_00;
}

//Function Number: 127
func_23D2()
{
	func_6691("");
}

//Function Number: 128
func_6692(param_00)
{
	var_01 = newhudelem();
	var_01.accuracy = "left";
	var_01.var_5E55 = 0;
	var_01.var_A0 = 1;
	var_01.var_9B = 1.2;
	var_01.var_18 = 1;
	var_01.maxsightdistsqrd = 0;
	var_01.var_1D7 = 320 + param_00 * 15;
	return var_01;
}

//Function Number: 129
func_4386(param_00)
{
	if(isdefined(level.var_5ED.var_9A91[param_00]))
	{
		return level.var_5ED.var_9A91[param_00];
	}

	return undefined;
}

//Function Number: 130
func_85A6(param_00,param_01,param_02)
{
	var_03 = func_4386(param_00);
	if(!isdefined(var_03))
	{
		var_03 = func_6692(level.var_5ED.var_9A91.size);
		level.var_5ED.var_9A91[param_00] = var_03;
		var_03.var_991F = param_00;
	}

	if(isdefined(param_01))
	{
		if(!isdefined(param_02))
		{
			param_02 = (1,1,1);
		}

		var_03.var_56 = param_02;
	}
}

//Function Number: 131
func_838F()
{
	var_00 = getdvar("select_by_substring");
	if(var_00 == "")
	{
		return 0;
	}

	setdvar("select_by_substring","");
	var_01 = [];
	foreach(var_04, var_03 in level.var_2804)
	{
		if(issubstr(var_03.var_A265["fxid"],var_00))
		{
			var_01[var_01.size] = var_04;
		}
	}

	if(var_01.size == 0)
	{
		return 0;
	}

	func_2D93();
	func_8391(var_01);
	foreach(var_06 in var_01)
	{
		var_03 = level.var_2804[var_06];
		func_8390(var_06,var_03);
	}

	return 1;
}

//Function Number: 132
func_8391(param_00)
{
	foreach(var_02 in param_00)
	{
		var_03 = level.var_2804[var_02];
		func_8390(var_02,var_03);
	}
}

//Function Number: 133
func_2D93()
{
	foreach(var_01 in level.var_5ED.var_83A3)
	{
		var_02 = func_44C7(var_01);
		func_2D94(var_02,var_01);
	}
}

//Function Number: 134
func_8875()
{
	wait(0.5);
	for(;;)
	{
		level.var_27FC = level.var_27FC + 0.05;
		if(level.var_27FC == 0.15)
		{
			foreach(var_01 in level.var_5ED.var_83A3)
			{
				if(var_01.var_A265["type"] == "exploder")
				{
					var_01 common_scripts\utility::func_894();
				}
			}

			common_scripts\_createfxmenu::func_2FF2();
			func_805A();
		}

		if(level.var_27FC == 0.05)
		{
			var_01 = common_scripts\_createfxmenu::func_41E4();
			common_scripts\_createfxmenu::func_2FF2();
		}

		wait 0.05;
	}
}

//Function Number: 135
func_3E70()
{
	if(level.var_5ED.var_83A3.size < 1)
	{
		return;
	}

	if(level.var_5ED.var_83A3.size > 1)
	{
		var_00 = func_40ED(level.var_5ED.var_83A3);
		var_01 = func_42D8(level.var_5ED.var_83A3) + 200;
	}
	else
	{
		var_00 = level.var_5ED.var_83A3[0].var_A265["origin"];
		var_01 = 200;
	}

	var_02 = anglestoforward(level.var_721C getangles());
	var_03 = var_02 * -1 * var_01;
	var_04 = level.var_721C geteye();
	var_05 = var_04 - level.var_721C.var_116;
	level.var_721C setorigin(var_00 + var_03 - var_05);
}

//Function Number: 136
func_5984(param_00)
{
	if(level.var_5ED.var_83A3.size < 1)
	{
		return;
	}

	var_01 = "fxid";
	if(level.var_5ED.var_83A3[0].var_A265["fxid"] == "No FX" && level.var_5ED.var_83A3[0].var_A265["soundalias"] != "null")
	{
		var_01 = "soundalias";
	}

	var_02 = level.var_5ED.var_83A3[0].var_A265[var_01];
	var_03 = [];
	foreach(var_06, var_05 in level.var_2804)
	{
		if(isdefined(var_05.var_A265[var_01]) && issubstr(var_05.var_A265[var_01],var_02))
		{
			if(var_01 == "soundalias")
			{
				if(var_05.var_A265["type"] == "soundfx_interval" || var_05.var_A265["type"] == "soundfx")
				{
					var_03[var_03.size] = var_06;
				}

				continue;
			}

			var_03[var_03.size] = var_06;
		}
	}

	var_07 = 0;
	if(var_03.size > 1)
	{
		for(var_06 = 0;var_06 < var_03.size;var_06++)
		{
			if(level.var_2804[var_03[var_06]] == level.var_5ED.var_83A3[0])
			{
				var_07 = var_06;
			}
		}

		if(var_07 >= var_03.size - 1 && param_00 == "next")
		{
			var_08 = var_03[0];
		}
		else if(var_08 == 0 && var_01 == "prev")
		{
			var_08 = var_04[var_04.size - 1];
		}
		else if(var_01 == "next")
		{
			var_08 = var_04[var_08 + 1];
		}
		else
		{
			var_08 = var_04[var_08 - 1];
		}

		func_2D93();
		func_8390(var_08,level.var_2804[var_08]);
		func_3E70();
	}
}

//Function Number: 137
func_239F()
{
	foreach(var_01 in level.var_2804)
	{
		if(isdefined(var_01.var_5EED))
		{
			var_01.var_5EED delete();
		}

		var_01 func_93D7();
	}
}

//Function Number: 138
func_7DCF()
{
	foreach(var_01 in level.var_2804)
	{
		if(var_01.var_A265["type"] == "oneshotfx")
		{
			var_01 func_7DCD();
		}
	}
}

//Function Number: 139
func_7DD0()
{
	foreach(var_01 in level.var_5ED.var_83A3)
	{
		if(isdefined(var_01) && var_01.var_A265["type"] == "exploder")
		{
			var_01 common_scripts\utility::func_894();
		}
	}
}

//Function Number: 140
func_805C()
{
	if(isdefined(level.var_2804) && level.var_27FC > 0.15)
	{
		level.var_2806 = func_266A(level.var_2804);
	}
}

//Function Number: 141
func_805A()
{
	if(isdefined(level.var_2804))
	{
		level.var_2805 = func_266A(level.var_2804);
	}
}

//Function Number: 142
func_A01B()
{
	if(isdefined(level.var_2806))
	{
		func_239F();
		level.var_2804 = [];
		level.var_2804 = func_266A(level.var_2806);
		func_23BA();
		func_7D27();
		func_7DCF();
		func_7DD0();
	}
}

//Function Number: 143
func_7B4F()
{
	if(isdefined(level.var_2805))
	{
		func_239F();
		level.var_2804 = [];
		level.var_2804 = func_266A(level.var_2805);
		func_23BA();
		func_7D27();
		func_7DCF();
		func_7DD0();
	}
}

//Function Number: 144
func_266A(param_00)
{
	var_01 = [];
	if(param_00.size > 0)
	{
		for(var_02 = 0;var_02 < param_00.size;var_02++)
		{
			var_03 = spawnstruct();
			if(isdefined(param_00[var_02].var_A265))
			{
				var_03.var_A265 = [];
				var_03.var_A265["type"] = param_00[var_02].var_A265["type"];
				var_03.var_A265["fxid"] = param_00[var_02].var_A265["fxid"];
				var_03.var_A265["soundalias"] = param_00[var_02].var_A265["soundalias"];
				var_03.var_A265["loopsound"] = param_00[var_02].var_A265["loopsound"];
				var_03.var_A265["angles"] = param_00[var_02].var_A265["angles"];
				var_03.var_A265["origin"] = param_00[var_02].var_A265["origin"];
				var_03.var_A265["exploder"] = param_00[var_02].var_A265["exploder"];
				var_03.var_A265["flag"] = param_00[var_02].var_A265["flag"];
				var_03.var_A265["exploder_type"] = param_00[var_02].var_A265["exploder_type"];
				var_03.var_A265["server_culled"] = param_00[var_02].var_A265["server_culled"];
				var_03.var_A265["delay_min"] = param_00[var_02].var_A265["delay_min"];
				var_03.var_A265["delay_max"] = param_00[var_02].var_A265["delay_max"];
				var_03.var_A265["delay"] = param_00[var_02].var_A265["delay"];
				var_03.var_A265["forward"] = param_00[var_02].var_A265["forward"];
				var_03.var_A265["up"] = param_00[var_02].var_A265["up"];
				var_01[var_02] = var_03;
			}

			var_01[var_02].var_33DB = param_00[var_02].var_33DB;
			var_01[var_02].var_9929 = param_00[var_02].var_9929;
		}
	}

	return var_01;
}

//Function Number: 145
func_7CE2(param_00)
{
	var_01 = [];
	foreach(var_03 in level.var_2804)
	{
		if(isdefined(var_03.var_106) && var_03.var_106 == param_00)
		{
			continue;
		}

		var_01[var_01.size] = var_03;
	}

	level.var_2804 = var_01;
}

//Function Number: 146
func_44C7(param_00)
{
	for(var_01 = 0;var_01 < level.var_2804.size;var_01++)
	{
		if(param_00 == level.var_2804[var_01])
		{
			return var_01;
		}
	}
}

//Function Number: 147
func_55E9(param_00)
{
	var_01 = level.var_5FEB - (32768,32768,32768);
	var_02 = level.var_5FEB + (32768,32768,32768);
	var_03 = param_00[0] > var_01[0] && param_00[0] < var_02[0];
	var_04 = param_00[1] > var_01[1] && param_00[1] < var_02[1];
	var_05 = param_00[2] > var_01[2] && param_00[2] < var_02[2];
	if(var_03 && var_04 && var_05)
	{
		return 1;
	}

	return 0;
}

//Function Number: 148
func_0646()
{
	wait(0.25);
	level.var_5ED.var_83A3 = [];
	for(var_00 = 0;var_00 < level.var_2804.size;var_00++)
	{
		var_01 = level.var_2804[var_00];
		if(isdefined(var_01.var_A265["type"]) == 0)
		{
			continue;
		}

		if(var_01.var_A265["type"] == "soundfx")
		{
			level.var_5ED.var_83A3[level.var_5ED.var_83A3.size] = var_01;
		}
	}

	func_A0CA();
	level.var_5ED.var_83A3 = [];
}