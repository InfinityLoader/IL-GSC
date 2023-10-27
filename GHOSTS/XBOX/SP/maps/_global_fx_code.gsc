/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\_global_fx_code.gsc
 * Game: Call of Duty: Ghosts
 * Platform: Console
 * Function Count: 2
 * Decompile Time: 28 ms
 * Timestamp: 10/27/2023 1:39:51 AM
*******************************************************************/

//Function Number: 1
func_3D2D(param_00,param_01,param_02,param_03,param_04)
{
	if(!isdefined(level._effect))
	{
		level._effect = [];
	}

	level.var_3D2D[param_00] = param_03;
	var_05 = maps\_utility::func_3C1B(param_00,"targetname");
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

		var_08 = common_scripts\utility::createoneshoteffect(param_03);
		var_08.var_880E["origin"] = var_07.origin;
		var_08.var_880E["angles"] = var_07.angles;
		var_08.var_880E["fxid"] = param_03;
		var_08.var_880E["delay"] = param_02;
		if(isdefined(param_04))
		{
			var_08.var_880E["soundalias"] = param_04;
		}

		if(!isdefined(var_07.script_noteworthy))
		{
			continue;
		}

		var_09 = var_07.script_noteworthy;
		if(!isdefined(level._global_fx_ents[var_09]))
		{
			level._global_fx_ents[var_09] = [];
		}

		level._global_fx_ents[var_09][level._global_fx_ents[var_09].size] = var_08;
	}
}

//Function Number: 2
func_44DF()
{
	if(!isdefined(level.var_3D2D))
	{
		level.var_3D2D = [];
	}

	level._global_fx_ents = [];
}