/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\mp\_global_fx_code.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 1
 * Decompile Time: 67 ms
 * Timestamp: 10/27/2023 12:20:30 AM
*******************************************************************/

//Function Number: 1
func_83D8(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = scripts\common\utility::getstructarray(param_00,"targetname");
	if(var_05.size <= 0)
	{
		return;
	}

	if(!isdefined(param_02))
	{
		param_02 = randomfloatrange(-20,-15);
	}

	if(!isdefined(param_03))
	{
		param_03 = param_01;
	}

	foreach(var_07 in var_05)
	{
		if(!isdefined(level._effect))
		{
			level._effect = [];
		}

		if(!isdefined(level._effect[param_03]))
		{
			level._effect[param_03] = loadfx(param_01);
		}

		if(!isdefined(var_07.angles))
		{
			var_07.angles = (0,0,0);
		}

		var_08 = scripts\common\utility::func_49FA(param_03);
		var_08.var_13125["origin"] = var_07.origin;
		var_08.var_13125["angles"] = var_07.angles;
		var_08.var_13125["fxid"] = param_03;
		var_08.var_13125["delay"] = param_02;
		if(isdefined(param_04))
		{
			var_08.var_13125["soundalias"] = param_04;
		}
	}
}