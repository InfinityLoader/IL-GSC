/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 3864.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 5
 * Decompile Time: 1 ms
 * Timestamp: 10/27/2023 12:31:03 AM
*******************************************************************/

//Function Number: 1
func_956A()
{
	level.var_83D2 = [];
	foreach(var_01 in ["_autosave_stealthcheck","_patrol_endon_spotted_flag","_spawner_stealth_default","_idle_call_idle_func"])
	{
		level.var_83D2[var_01] = ::func_83D6;
	}

	scripts\common\utility::flag_init("stealth_spotted");
	scripts\common\utility::flag_init("stealth_enabled");
	scripts\common\utility::flag_init("stealth_music_pause");
}

//Function Number: 2
func_83D6(param_00,param_01,param_02,param_03,param_04)
{
}

//Function Number: 3
func_10EBB(param_00)
{
	if(isdefined(self.var_10E6D) && isdefined(self.var_10E6D.var_74D5) && isdefined(self.var_10E6D.var_74D5[param_00]))
	{
		return self.var_10E6D.var_74D5[param_00];
	}

	if(isdefined(level.var_10E6D) && isdefined(level.var_10E6D.var_74D5))
	{
		return level.var_10E6D.var_74D5[param_00];
	}

	return undefined;
}

//Function Number: 4
func_10E8A(param_00,param_01,param_02,param_03)
{
	var_04 = func_10EBB(param_00);
	if(isdefined(var_04))
	{
		if(isdefined(param_03))
		{
			return self [[ var_04 ]](param_01,param_02,param_03);
		}
		else if(isdefined(param_02))
		{
			return self [[ var_04 ]](param_01,param_02);
		}
		else if(isdefined(param_01))
		{
			return self [[ var_04 ]](param_01);
		}
		else
		{
			return self [[ var_04 ]]();
		}
	}

	return undefined;
}

//Function Number: 5
func_10E8B(param_00,param_01,param_02,param_03)
{
	var_04 = func_10EBB(param_00);
	if(isdefined(var_04))
	{
		if(isdefined(param_03))
		{
			return self thread [[ var_04 ]](param_01,param_02,param_03);
		}
		else if(isdefined(param_02))
		{
			return self thread [[ var_04 ]](param_01,param_02);
		}
		else if(isdefined(param_01))
		{
			return self thread [[ var_04 ]](param_01);
		}
		else
		{
			return self thread [[ var_04 ]]();
		}
	}

	return undefined;
}