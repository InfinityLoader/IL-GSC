/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 3086.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 0 ms
 * Timestamp: 10/27/2023 12:26:07 AM
*******************************************************************/

//Function Number: 1
func_97E6(param_00)
{
	if(isdefined(self.var_3135.var_9882))
	{
		return level.var_111AE;
	}

	self.var_1198.var_3FEC = "noncombat";
	self.var_1198.var_3FED = gettime();
	self.var_3135.var_9882 = 1;
	return level.var_111AE;
}

//Function Number: 2
func_12E8F(param_00)
{
	var_01 = lib_0A1A::func_233E("ai_notify","bulletwhizby");
	if(isdefined(var_01))
	{
		if(!isdefined(self.var_55B5))
		{
			var_02 = var_01.var_C8F0[0];
			var_03 = isdefined(var_02) && distancesquared(self.origin,var_02.origin) < 262144;
			if(var_03 || scripts\common\utility::func_4347())
			{
				lib_0A1B::func_2975("combat");
				lib_0A1B::func_2971(var_01);
				return level.var_111AE;
			}
		}
	}
	else
	{
		var_04 = 5000;
		var_01 = lib_0A1B::func_292F();
		if(!isdefined(var_01) || gettime() > var_01.var_7686 + var_04)
		{
			lib_0A1B::func_2971(undefined);
		}
	}

	var_05 = function_0072("axis");
	foreach(var_07 in var_05)
	{
		if(distancesquared(var_07.origin,self.origin) < 262144)
		{
			lib_0A1B::func_2975("combat");
			return level.var_111AE;
		}
	}

	if(lib_0A1B::func_291D() == "combat" && gettime() - lib_0A1B::func_291E() >= 10000)
	{
		lib_0A1B::func_2975("noncombat");
	}

	return level.var_111AE;
}