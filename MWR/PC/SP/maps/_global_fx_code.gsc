/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\_global_fx_code.gsc
 * Game: Call of Duty: Modern Warfare Remastered
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 40 ms
 * Timestamp: 10/27/2023 2:47:53 AM
*******************************************************************/

//Function Number: 1
global_fx(param_00,param_01,param_02,param_03,param_04)
{
	if(isdefined(level.global_fx_override[param_00]))
	{
		var_05 = level.global_fx_override[param_00];
		param_00 = var_05["targetname"];
		param_01 = var_05["fxFile"];
		param_02 = var_05["delay"];
		param_03 = var_05["fxName"];
		param_04 = var_05["soundalias"];
	}

	if(!isdefined(level._effect))
	{
		level._effect = [];
	}

	level.global_fx[param_00] = param_03;
	var_06 = maps\_utility::getstructarray_delete(param_00,"targetname");
	if(!isdefined(var_06))
	{
		return;
	}

	if(!var_06.size)
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

	foreach(var_08 in var_06)
	{
		if(!isdefined(level._effect[param_03]))
		{
			level._effect[param_03] = loadfx(param_01);
		}

		if(!isdefined(var_08.angles))
		{
			var_08.angles = (0,0,0);
		}

		var_09 = common_scripts\utility::createoneshoteffect(param_03);
		var_09.v["origin"] = var_08.origin;
		var_09.v["angles"] = var_08.angles;
		var_09.v["fxid"] = param_03;
		var_09.v["delay"] = param_02;
		if(isdefined(param_04))
		{
			var_09.v["soundalias"] = param_04;
		}

		if(!isdefined(var_08.script_noteworthy))
		{
			continue;
		}

		var_0A = var_08.script_noteworthy;
		if(!isdefined(level._global_fx_ents[var_0A]))
		{
			level._global_fx_ents[var_0A] = [];
		}

		level._global_fx_ents[var_0A][level._global_fx_ents[var_0A].size] = var_09;
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
	if(!isdefined(level.global_fx_override))
	{
		level.global_fx_override = [];
	}
}