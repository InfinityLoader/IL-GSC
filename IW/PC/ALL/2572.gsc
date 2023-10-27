/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 2572.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 7
 * Decompile Time: 5 ms
 * Timestamp: 10/27/2023 12:23:22 AM
*******************************************************************/

//Function Number: 1
func_10020(param_00)
{
	if(lib_0A1A::func_232A("grenade response","return throw",0))
	{
		return level.var_111AE;
	}

	return level.var_6AD5;
}

//Function Number: 2
func_85D3(param_00)
{
	if(lib_0A1A::func_232A("grenade response","return throw complete"))
	{
		return level.var_111AE;
	}

	lib_0A1B::func_2964(1);
	return level.var_E87A;
}

//Function Number: 3
func_85D4(param_00)
{
	lib_0A1B::func_2964(undefined);
}

//Function Number: 4
func_1001E(param_00)
{
	if(lib_0A1A::func_232A("grenade response","avoid",0))
	{
		return level.var_111AE;
	}

	return level.var_6AD5;
}

//Function Number: 5
func_85B0(param_00)
{
	var_01 = spawnstruct();
	var_01.var_6393 = gettime() + 10000;
	var_01.var_4767 = 0;
	self.var_3135.var_9928[param_00] = var_01;
	lib_0A1B::func_2963(1);
	lib_0A0A::func_41A3(param_00);
}

//Function Number: 6
func_85B1(param_00)
{
	self.var_3135.var_9928[param_00] = undefined;
	lib_0A1B::func_2963(undefined);
}

//Function Number: 7
func_85AF(param_00)
{
	var_01 = self.var_3135.var_9928[param_00];
	var_02 = gettime();
	if(!isdefined(var_01.var_85BA) && !isdefined(self.var_15F))
	{
		var_01.var_85BA = var_02;
	}

	if(lib_0A1A::func_232A("grenade dive","end"))
	{
		return level.var_111AE;
	}

	if(lib_0A1A::func_232A("grenade cower","end"))
	{
		var_01.var_4767 = 1;
		if(isdefined(var_01.var_85BA))
		{
			var_01.var_6393 = var_02;
		}
		else
		{
			var_03 = 3000;
			var_01.var_6393 = var_02 + var_03;
		}
	}

	if(var_01.var_4767)
	{
		if(isdefined(var_01.var_85BA) && var_02 - var_01.var_85BA > 500)
		{
			return level.var_111AE;
		}
	}
	else if(!isdefined(self.var_15F))
	{
		return level.var_111AE;
	}

	if(var_02 > var_01.var_6393)
	{
		return level.var_111AE;
	}

	return level.var_E87A;
}