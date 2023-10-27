/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 2571.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 12
 * Decompile Time: 2 ms
 * Timestamp: 10/27/2023 12:23:22 AM
*******************************************************************/

//Function Number: 1
func_98C9(param_00)
{
	if(!isdefined(self.var_1198.var_EF3B))
	{
		self.var_1198.var_EF3B = [];
	}

	if(!isdefined(self.var_1198.var_EF3B[param_00]))
	{
		self.var_1198.var_EF3B[param_00] = spawnstruct();
		self.var_1198.var_EF3B[param_00].var_10E19 = "normal";
	}
}

//Function Number: 2
func_F591(param_00,param_01)
{
	if(self.var_1198.var_EF3B[param_00].var_10E19 == "dismember")
	{
		return;
	}

	if(self.var_1198.var_EF3B[param_00].var_10E19 != "normal" && param_01 != "dismember")
	{
		self.var_1198.var_EF3B[param_00].var_10E19 = self.var_1198.var_EF3B[param_00].var_10E19 + "_both";
	}
	else
	{
		self.var_1198.var_EF3B[param_00].var_10E19 = param_01;
	}

	self.var_1198.var_EF3B[param_00].time = gettime();
}

//Function Number: 3
func_F592(param_00,param_01,param_02)
{
	self endon("entitydeleted");
	func_F591(param_00,param_01);
	if(isdefined(param_02))
	{
		wait(param_02);
	}

	if(isdefined(self.var_EF39))
	{
		return 1;
	}

	var_03 = self.var_1198.var_EF3B[param_00].var_10E19;
	if(isdefined(level.var_5667[self.var_12BA4]))
	{
		if(param_00 != "head" && var_03 != "dismember")
		{
			if(func_13077(self.var_12BA4))
			{
				var_03 = var_03 + "_lite";
			}
		}
	}

	self setscriptablepartstate(param_00,var_03);
}

//Function Number: 4
func_F6C9(param_00)
{
	var_01 = param_00 + "_dism_fx";
	var_02 = func_7C35(param_00);
	if(var_02 == "normal")
	{
		var_02 = "undamaged";
	}
	else if(issubstr(var_02,"_both"))
	{
		var_02 = "dmg_both";
	}

	if(!isdefined(level.var_93A9) && isdefined(level.var_5667[self.var_12BA4]))
	{
		if(param_00 != "head")
		{
			if(func_13077(self.var_12BA4))
			{
				var_02 = var_02 + "_lite";
			}
		}
	}

	self setscriptablepartstate(var_01,var_02);
}

//Function Number: 5
func_13077(param_00)
{
	var_01 = [];
	for(var_02 = 0;var_02 < level.var_5667[param_00].size;var_02++)
	{
		if(gettime() - level.var_5667[param_00][var_02] > 1000)
		{
			continue;
		}

		var_01[var_01.size] = level.var_5667[param_00][var_02];
	}

	if(var_01.size < 0)
	{
		var_01[var_01.size] = gettime();
		level.var_5667[param_00] = var_01;
		return 0;
	}

	level.var_5667[param_00] = var_01;
	return 1;
}

//Function Number: 6
func_7C35(param_00)
{
	if(!isdefined(self.var_1198.var_EF3B))
	{
		return "normal";
	}

	if(!isdefined(self.var_1198.var_EF3B[param_00]))
	{
		return "normal";
	}

	return self.var_1198.var_EF3B[param_00].var_10E19;
}

//Function Number: 7
func_2040()
{
	if(func_7C35("left_leg") == "dismember" || func_7C35("right_leg") == "dismember")
	{
		return 1;
	}

	return 0;
}

//Function Number: 8
func_2EE2()
{
	if(func_7C35("left_leg") == "dismember" && func_7C35("right_leg") == "dismember")
	{
		return 1;
	}

	return 0;
}

//Function Number: 9
func_203F()
{
	if(func_7C35("left_arm") == "dismember" || func_7C35("right_arm") == "dismember")
	{
		return 1;
	}

	return 0;
}

//Function Number: 10
func_E52D()
{
	if(func_7C35("right_arm") == "dismember")
	{
		return 1;
	}

	return 0;
}

//Function Number: 11
func_AB53()
{
	if(func_7C35("left_arm") == "dismember")
	{
		return 1;
	}

	return 0;
}

//Function Number: 12
func_2EE1()
{
	if(func_7C35("left_arm") == "dismember" && func_7C35("right_arm") == "dismember")
	{
		return 1;
	}

	return 0;
}