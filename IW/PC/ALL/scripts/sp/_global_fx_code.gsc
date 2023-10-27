/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\sp\_global_fx_code.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 82 ms
 * Timestamp: 10/27/2023 12:24:29 AM
*******************************************************************/

//Function Number: 1
func_83D8(param_00,param_01,param_02,param_03,param_04)
{
	init();
	level.var_83D8[param_00] = param_03;
	var_05 = scripts\sp\_utility::func_8181(param_00,"targetname");
	if(!isdefined(var_05))
	{
		return;
	}

	if(!var_05.size)
	{
		return;
	}

	if(!isdefined(param_03))
	{
		param_03 = param_01;
	}

	if(!isdefined(param_02))
	{
		param_02 = randomfloatrange(-20,-15);
	}

	foreach(var_07 in var_05)
	{
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

		if(!isdefined(var_07.script_noteworthy))
		{
			continue;
		}

		var_09 = var_07.script_noteworthy;
		if(!isdefined(level.var_12C7[var_09]))
		{
			level.var_12C7[var_09] = [];
		}

		level.var_12C7[var_09][level.var_12C7[var_09].size] = var_08;
	}
}

//Function Number: 2
init()
{
	if(!scripts\common\utility::func_16F3("global_FX",::init))
	{
		return;
	}

	if(!isdefined(level._effect))
	{
		level._effect = [];
	}

	if(!isdefined(level.var_83D8))
	{
		level.var_83D8 = [];
	}

	level.var_12C7 = [];
}