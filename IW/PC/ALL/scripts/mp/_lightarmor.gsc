/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\mp\_lightarmor.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 11
 * Decompile Time: 466 ms
 * Timestamp: 10/27/2023 12:20:46 AM
*******************************************************************/

//Function Number: 1
func_8C07(param_00)
{
	return func_7F73(param_00) > 0;
}

//Function Number: 2
func_7F73(param_00)
{
	if(isdefined(param_00.var_ACAE))
	{
		return param_00.var_ACAE;
	}

	return 0;
}

//Function Number: 3
func_F786(param_00,param_01,param_02,param_03)
{
	if(!isdefined(param_02))
	{
		param_02 = 1;
	}

	if(!isdefined(param_03))
	{
		param_03 = 1;
	}

	if(func_ACA6(param_00))
	{
		param_01 = 0;
		param_02 = 1;
	}

	var_04 = func_7F73(param_00);
	if(!param_02 && var_04 > param_01)
	{
		param_01 = var_04;
	}

	if(var_04 <= 0 && param_01 > 0)
	{
		func_ACA9(param_00,param_01,param_03);
		return;
	}

	if(var_04 > 0 && param_01 <= 0)
	{
		func_ACAC(param_00);
		return;
	}

	param_00.var_ACAE = param_01;
	if(isplayer(param_00) && var_04 <= param_01 && param_01 > 0 && param_03 == 1)
	{
		thread func_ACAA(param_00);
	}

	if(isplayer(param_00))
	{
		func_ACAD(param_00);
	}
}

//Function Number: 4
init()
{
	level._effect["lightArmor_persistent"] = loadfx("vfx/core/mp/core/vfx_uplink_carrier.vfx");
}

//Function Number: 5
func_ACA9(param_00,param_01,param_02)
{
	param_00 notify("lightArmor_set");
	param_00.var_ACAE = param_01;
	func_ACAD(param_00);
	thread func_ACA8(param_00);
	if(isplayer(param_00) && param_02 == 1)
	{
		thread func_ACAA(param_00);
	}
}

//Function Number: 6
func_ACAC(param_00)
{
	param_00 notify("lightArmor_unset");
	param_00.var_ACAE = undefined;
	func_ACAD(param_00);
	if(isplayer(param_00))
	{
		param_00 setscriptablepartstate("light_armor","neutral",0);
	}

	param_00 notify("remove_light_armor");
}

//Function Number: 7
func_ACA7(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A)
{
	var_0B = 0;
	var_0C = 0;
	var_0D = param_00.var_ACAE;
	if(!isdefined(param_0A))
	{
		param_0A = 1;
	}

	if(!var_0B)
	{
		if(param_04 == "MOD_FALLING" || param_04 == "MOD_MELEE")
		{
			var_0B = 1;
		}
	}

	if(!var_0B)
	{
		if(scripts\common\utility::func_9D74(param_04) && scripts\mp\_utility::func_9E27(param_05,param_08,param_04,param_01))
		{
			var_0B = 1;
		}
	}

	if(!var_0B)
	{
		if(param_04 == "MOD_IMPACT")
		{
			if(scripts\mp\_weapons::func_9FA9(param_05) || scripts\mp\_weapons::isaxeweapon(param_05))
			{
				var_0B = 1;
			}
		}
	}

	if(!var_0B)
	{
		if(function_0107(param_04))
		{
			if(isdefined(param_09) && isdefined(param_09.var_11180) && param_09.var_11180 == param_00)
			{
				var_0B = 1;
			}
		}
	}

	if(!var_0B)
	{
		if(scripts\mp\_utility::issuperdamagesource(param_05))
		{
			var_0B = 1;
		}
	}

	if(!var_0B)
	{
		var_0C = min(param_02 + param_03,param_00.var_ACAE);
		var_0D = var_0D - param_02 + param_03;
		if(!param_0A)
		{
			param_00.var_ACAE = param_00.var_ACAE - param_02 + param_03;
		}

		param_02 = 0;
		param_03 = 0;
		if(var_0D <= 0)
		{
			param_02 = abs(var_0D);
			param_03 = 0;
			if(!param_0A)
			{
				func_ACAC(param_00);
			}
		}
	}

	if(!param_0A)
	{
		func_ACAD(self);
	}

	if(var_0C > 0 && param_02 == 0)
	{
		param_02 = 1;
	}

	return [var_0C,param_02,param_03];
}

//Function Number: 8
func_ACA6(param_00)
{
	if(param_00 scripts\mp\_heavyarmor::func_8BFA())
	{
		return 1;
	}

	return 0;
}

//Function Number: 9
func_ACA8(param_00)
{
	param_00 endon("disconnect");
	param_00 endon("lightArmor_set");
	param_00 endon("lightArmor_unset");
	param_00 waittill("death");
	thread func_ACAC(param_00);
}

//Function Number: 10
func_ACAD(param_00)
{
	if(!isplayer(param_00))
	{
		return;
	}

	if(isdefined(level.var_3AEC))
	{
		param_00 setclientomnvar("ui_uplink_carrier_armor",int(func_7F73(param_00)));
	}
}

//Function Number: 11
func_ACAA(param_00)
{
	param_00 setscriptablepartstate("light_armor","active",0);
}