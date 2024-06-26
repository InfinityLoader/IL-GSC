/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: _global_fx_code.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 50 ms
 * Timestamp: 4/22/2024 2:21:07 AM
*******************************************************************/

//Function Number: 1
global_fx(param_00,param_01,param_02,param_03,param_04)
{
	if(!isdefined(level._effect))
	{
		level._effect = [];
	}

	level.global_fx[param_00] = param_03;
	var_05 = maps\_utility::getstructarray_delete(param_00,"targetname");
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
		var_08.v["origin"] = var_07.origin;
		var_08.v["angles"] = var_07.angles;
		var_08.v["fxid"] = param_03;
		var_08.v["delay"] = param_02;
		if(isdefined(param_04))
		{
			var_08.v["soundalias"] = param_04;
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
init()
{
	if(!isdefined(level.global_fx))
	{
		level.global_fx = [];
	}

	level._global_fx_ents = [];
}