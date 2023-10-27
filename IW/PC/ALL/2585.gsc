/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 2585.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 8
 * Decompile Time: 1 ms
 * Timestamp: 10/27/2023 12:23:24 AM
*******************************************************************/

//Function Number: 1
func_12F5C(param_00)
{
	if(isdefined(level.var_13CD3) && isdefined(self.var_72BA))
	{
		lib_0A1B::func_2919();
		self [[ level.var_13CD3 ]]();
		return 0;
	}

	func_98E2();
	if(lib_0A1B::func_294B() || isdefined(lib_0A06::func_81F4()))
	{
		lib_0A1B::func_2919();
		return level.var_111AE;
	}

	var_01 = 0;
	var_02 = func_3EBC();
	if(isdefined(var_02))
	{
		if(var_02 != self.var_394)
		{
			var_01 = 1;
		}

		lib_0A1B::func_2970(var_02);
	}
	else
	{
		lib_0A1B::func_2919();
	}

	if(scripts\anim\utility_common::func_9D4D())
	{
		if(var_01)
		{
			if(isdefined(self.var_394) && !scripts\anim\utility_common::func_9F62(self.var_394) && isdefined(self.var_3135.var_FECD))
			{
				lib_0A06::func_FE5A(self.var_3135.var_FECD);
			}
		}

		if(isdefined(self.var_394) && scripts\anim\utility_common::func_9F62(self.var_394) && isdefined(self.var_3135.var_FECD) && !scripts\asm\shared_utility::func_9D50())
		{
			var_03 = undefined;
			if(isdefined(self.var_1198.var_FECD) && isdefined(self.var_1198.var_FECD.var_D699))
			{
				var_03 = distancesquared(self.origin,self.var_1198.var_FECD.var_D699);
			}
			else if(isdefined(self.var_10C))
			{
				var_03 = distancesquared(self.origin,self.var_10C.origin);
			}

			if(var_03 < 262144)
			{
				lib_0A06::func_FE5A(self.var_3135.var_FECD);
			}
		}
	}
	else if(isdefined(self.var_3135.var_FECD) && isdefined(self.var_3135.var_FECD.var_29AF) && self.var_3135.var_FECD.var_29AF)
	{
		lib_0A06::func_FE5A(self.var_3135.var_FECD);
	}

	return level.var_111AE;
}

//Function Number: 2
func_98E2()
{
	self.var_13CC3 = [];
	if(isdefined(self.var_D8E1) && self.var_D8E1 != "none")
	{
		self.var_13CC3[self.var_13CC3.size] = self.var_D8E1;
	}

	if(isdefined(self.var_F0C4) && self.var_F0C4 != "none")
	{
		self.var_13CC3[self.var_13CC3.size] = self.var_F0C4;
	}

	if(isdefined(self.var_101B4) && self.var_101B4 != "none")
	{
		self.var_13CC3[self.var_13CC3.size] = self.var_101B4;
	}
}

//Function Number: 3
func_3EBC()
{
	if(isdefined(self.var_72DE))
	{
		return "pistol";
	}

	if(isdefined(self.var_1198.var_5D3B))
	{
		return "pistol";
	}

	var_00 = 0;
	var_01 = undefined;
	foreach(var_03 in self.var_13CC3)
	{
		var_04 = weaponclass(var_03);
		var_05 = func_67D7(var_04,var_03);
		if(var_05 > var_00)
		{
			var_00 = var_05;
			var_01 = var_04;
		}
	}

	return var_01;
}

//Function Number: 4
func_67D7(param_00,param_01)
{
	if(param_00 == "pistol")
	{
		if(weaponclass(self.var_394) == "rocketlauncher" && self.var_1491.var_E5DE <= 0)
		{
			return 1000;
		}

		if(func_391A(undefined) != level.var_111AE)
		{
			return 0;
		}

		var_02 = scripts\anim\utility_common::func_9FCA();
		var_03 = undefined;
		if(isdefined(self.var_1198.var_FECD) && isdefined(self.var_1198.var_FECD.var_D699))
		{
			var_03 = distancesquared(self.origin,self.var_1198.var_FECD.var_D699);
		}
		else if(var_02 && isdefined(self.var_10C))
		{
			var_03 = distancesquared(self.origin,self.var_10C.origin);
		}

		if(isdefined(var_03))
		{
			var_04 = 409;
			var_05 = scripts\anim\utility_common::func_9D4D(0);
			if(var_05)
			{
				var_04 = 512;
			}

			if(var_02)
			{
				var_04 = var_04 + 36;
			}

			if(var_03 < var_04 * var_04)
			{
				if(var_05)
				{
					return 1000;
				}

				if(scripts\anim\utility_common::func_13112() && var_03 < 16384)
				{
					return 1000;
				}

				if(scripts\anim\utility_common::func_9FC5() && self.var_3250 != 0)
				{
					return 10;
				}

				return 1000;
			}
		}

		return 0;
	}
	else if(var_02 == "rocketlauncher")
	{
		if(self.var_1491.var_E5DE <= 0)
		{
			return 0;
		}

		return 100;
	}
	else
	{
		return 100;
	}

	return 100;
}

//Function Number: 5
func_9F5F(param_00)
{
	if(scripts\anim\utility_common::func_9D4D())
	{
		return level.var_111AE;
	}

	return level.var_6AD5;
}

//Function Number: 6
func_1311F(param_00)
{
	if(self.var_394 == self.var_101B4 && self.var_394 != "none")
	{
		return level.var_111AE;
	}

	return level.var_6AD5;
}

//Function Number: 7
func_100A7(param_00)
{
	if(func_1311F(param_00) == level.var_111AE)
	{
		return level.var_6AD5;
	}

	if(isdefined(self.var_72DE))
	{
		return level.var_111AE;
	}

	if(func_391A(param_00) != level.var_111AE)
	{
		return level.var_6AD5;
	}
}

//Function Number: 8
func_391A(param_00)
{
	if(isdefined(self.var_C009))
	{
		return level.var_6AD5;
	}

	if(lib_0A1B::func_2955())
	{
		return level.var_6AD5;
	}

	var_01 = lib_0A1B::func_2920();
	if(isdefined(var_01) && distance(self.origin,var_01.origin) < 16)
	{
		return level.var_6AD5;
	}

	if(isdefined(self.var_B55B))
	{
		return level.var_6AD5;
	}

	return level.var_111AE;
}