/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 871.gsc
 * Game: Call of Duty: WWII
 * Platform: PC
 * Function Count: 16
 * Decompile Time: 5 ms
 * Timestamp: 10/27/2023 3:27:05 AM
*******************************************************************/

//Function Number: 1
func_8E3A(param_00,param_01,param_02,param_03)
{
	lib_0378::func_307C(param_00,param_02,param_03);
	lib_0378::func_307F(param_01);
	level.var_71D.var_7502 = [];
}

//Function Number: 2
snd_zmb_plr_dlg_play_line_on_each_player(param_00,param_01,param_02,param_03,param_04,param_05)
{
	foreach(var_07 in level.var_744A)
	{
		var_07 func_8E3D(param_00,param_01,param_02,param_03,param_04,param_05);
	}
}

//Function Number: 3
func_8E3C(param_00,param_01,param_02,param_03,param_04,param_05)
{
	return func_8EA3(param_00,param_01,param_02,param_03,undefined,param_04,param_05);
}

//Function Number: 4
func_8E3D(param_00,param_01,param_02,param_03,param_04,param_05)
{
	var_06 = "dlg_done_notify_" + lib_0378::func_8D86();
	var_07 = func_8EA3(param_00,param_01,param_02,param_03,var_06,param_04,param_05);
	if(!isdefined(var_07))
	{
		var_06 = undefined;
	}

	return var_06;
}

//Function Number: 5
func_8EA3(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	var_07 = self;
	if(common_scripts\utility::func_562E(var_07.var_324E))
	{
		return undefined;
	}

	var_08 = var_07 func_8E9F();
	if(isdefined(param_06))
	{
		var_08 = param_06;
	}

	if(isdefined(param_05) && param_05 == "_hi" || param_05 == "_md" || param_05 == "_lo")
	{
		var_09 = param_05;
	}
	else
	{
		var_09 = var_08 func_8EA0();
	}

	if(!isdefined(var_08) || !isdefined(var_09))
	{
		return undefined;
	}

	var_0A = var_08 + param_00 + var_09;
	if(function_0344(var_0A))
	{
		var_07 lib_0378::func_307E(var_0A,param_01,param_02,param_03,param_04);
		return 1;
	}
	else if(function_0344(var_08 + param_00))
	{
		var_07 lib_0378::func_307E(var_08 + param_00,param_01,param_02,param_03,param_04);
		return 1;
	}

	return undefined;
}

//Function Number: 6
func_8E38(param_00,param_01)
{
	level.var_71D.var_7502[param_00] = param_01;
}

//Function Number: 7
func_8E3B(param_00,param_01)
{
	var_02 = lib_0378::func_3083();
	var_03 = var_02 func_8EA1();
	var_04 = var_03[param_00];
	var_05 = self;
	var_06 = undefined;
	if(var_05.var_BC < 10)
	{
		lib_0378::func_8D64("EXITING CONV: Plr Health to Low");
		return;
	}

	var_07 = var_05.var_20D8;
	var_08 = var_02 lib_0378::func_307B(var_07);
	var_09 = var_04["primary"][var_08];
	if(!isdefined(var_09))
	{
		lib_0378::func_8D64("EXITING CONV: No line for: " + var_08);
		return;
	}

	var_0A = var_09[0];
	var_0B = var_09[1];
	var_0C = undefined;
	var_0D = undefined;
	var_0E = undefined;
	var_0F = undefined;
	var_10 = 10000000;
	foreach(var_12 in level.var_744A)
	{
		if(var_12 == var_05 || var_12.var_BC < 10)
		{
			continue;
		}

		var_13 = var_12.var_20D8;
		var_14 = var_02 lib_0378::func_307B(var_13);
		var_15 = var_04["secondary"][var_14];
		if(isdefined(var_15))
		{
			var_16 = distance(var_05.var_116,var_12.var_116);
			var_17 = 1;
			var_18 = 180;
			if(var_16 < 900 && var_16 < var_10 && var_05 common_scripts\utility::func_7237(var_12,var_17,var_18))
			{
				var_0F = var_12;
				var_10 = var_16;
				var_0C = var_15[0];
				var_0D = var_15[1];
			}
		}
	}

	if(isdefined(var_0F))
	{
		var_06 = var_0F;
		var_0E = var_10;
	}

	var_1A = var_05 func_8EA3(var_0A,var_06);
	if(!isdefined(var_1A))
	{
		return undefined;
	}

	if(isdefined(var_0B))
	{
		wait(var_0B);
	}

	if(isdefined(var_06))
	{
		var_06 func_8EA3(var_0C,var_05);
		if(isdefined(var_0D))
		{
			wait(var_0D);
		}
	}

	if(isstring(param_01))
	{
		self notify(param_01);
	}

	return 1;
}

//Function Number: 8
func_8E3E(param_00)
{
	level.var_71D.var_5FDF = param_00;
	level.var_71D.var_7501 = "zmb_" + param_00 + "_";
}

//Function Number: 9
func_8E39()
{
	var_00 = lib_0378::func_3083();
	return var_00 lib_0378::func_307B(self.var_20D8);
}

//Function Number: 10
func_8E43(param_00,param_01)
{
}

//Function Number: 11
func_8E42(param_00,param_01)
{
}

//Function Number: 12
func_8EA4(param_00)
{
	var_01 = undefined;
	if(function_0344(param_00 + "hi"))
	{
		var_01 = param_00 + "hi";
	}
	else if(function_0344(param_00 + "md"))
	{
		var_01 = param_00 + "md";
	}
	else if(function_0344(param_00 + "lo"))
	{
		var_01 = param_00 + "lo";
	}
	else if(function_0344(param_00))
	{
		var_01 = param_00;
	}

	return var_01;
}

//Function Number: 13
func_8EA1()
{
	return level.var_71D.var_7502;
}

//Function Number: 14
func_8EA2()
{
	return level.var_71D.var_5FDF;
}

//Function Number: 15
func_8E9F()
{
	var_00 = self;
	var_01 = var_00.var_20D8;
	if(!isdefined(var_01))
	{
		return undefined;
	}

	var_02 = lib_0378::func_307B(var_01);
	if(!isdefined(level.var_71D.var_7501))
	{
		return undefined;
	}

	return level.var_71D.var_7501 + var_02 + "_";
}

//Function Number: 16
func_8EA0(param_00,param_01)
{
	var_02 = "_md";
	var_03 = self;
	var_04 = var_03 lib_0366::func_8E14();
	var_05 = lib_0378::func_8D49(0,param_01);
	if(isdefined(param_00))
	{
		foreach(var_07 in param_00)
		{
			var_08 = var_07 lib_0366::func_8E14();
			var_04 = max(var_04,var_08);
		}
	}

	var_0A = 0.1;
	var_0B = 0.5;
	var_0C = 299.7;
	var_0D = 599.4;
	if(var_04 < var_0A && var_05 < var_0C)
	{
		var_02 = "_lo";
	}
	else if(var_04 > var_0B || var_05 > var_0D)
	{
		var_02 = "_hi";
	}

	return var_02;
}