/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 3138.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 16
 * Decompile Time: 6 ms
 * Timestamp: 10/27/2023 12:26:14 AM
*******************************************************************/

//Function Number: 1
func_35A6(param_00,param_01,param_02,param_03)
{
	if(!isdefined(level.var_362A))
	{
		lib_0C41::func_3629();
	}

	self.allowpain = 0;
	self.var_2303.var_7360 = 0;
	self.var_2303.var_4C86 = spawnstruct();
	self.var_2303.var_7257 = spawnstruct();
	self.var_2303.var_7257.var_7254 = "invalid";
	self.var_2303.var_7257.time = 0;
	self.var_BC = "no_cover";
	self.var_163 = 0;
	self.var_1D0 = 1024;
	self.var_292 = 164;
	lib_0A1A::func_237B(1);
	self.var_1A48 = 1;
	self.var_1198.var_BD23 = "combat";
	self.var_1198.var_A983 = 0;
	self.var_1198.var_118FD = -99999;
	self.var_358 = 0.1;
	self.var_102 = 0;
	self.var_27F7 = 1;
	if(isdefined(self.var_13CC3))
	{
		self.var_13C83 = [];
		foreach(var_06, var_05 in self.var_13CC3)
		{
			self.var_13C83[var_06] = 1;
			self.var_3135.var_13C83[var_06] = 1;
		}
	}

	thread lib_0C46::func_3535();
	thread lib_0C46::func_3620();
	thread func_352E();
}

//Function Number: 2
func_352E()
{
	self endon("death");
	for(;;)
	{
		if(!isdefined(level.player.var_4759))
		{
			wait(1);
			continue;
		}

		if(isdefined(level.player.var_4759.var_19) && level.player.var_4759.var_19.size)
		{
			foreach(var_01 in level.player.var_4759.var_19)
			{
				if(distance2dsquared(self.origin,var_01.origin) <= squared(180))
				{
					scripts\sp\_coverwall::func_475C(var_01,1);
					wait(0.05);
				}
			}

			wait(0.5);
		}

		wait(0.25);
	}
}

//Function Number: 3
func_6C00()
{
}

//Function Number: 4
func_5B23(param_00,param_01)
{
	var_02 = 25;
	var_03 = anglestoforward(param_01) * var_02;
	var_04 = anglestoright(param_01) * var_02;
	var_05 = anglestoup(param_01) * var_02;
	func_1215(param_00,param_00 + var_03,(1,0,0));
	func_1215(param_00,param_00 + var_05,(0,1,0));
	func_1215(param_00,param_00 + var_04,(0,0,1));
}

//Function Number: 5
func_1215(param_00,param_01,param_02)
{
	var_03 = vectortoangles(param_01 - param_00);
	var_04 = length(param_01 - param_00);
	var_05 = anglestoforward(var_03);
	var_06 = var_05 * var_04;
	var_07 = 5;
	var_08 = var_05 * var_04 - var_07;
	var_09 = anglestoright(var_03);
	var_0A = var_09 * var_07 * -1;
	var_0B = var_09 * var_07;
}

//Function Number: 6
func_E75A(param_00,param_01)
{
	return (func_E756(param_00[0],param_01),func_E756(param_00[1],param_01),func_E756(param_00[2],param_01));
}

//Function Number: 7
func_E756(param_00,param_01)
{
	return int(param_00 * param_01) / param_01;
}

//Function Number: 8
func_35E3(param_00,param_01,param_02,param_03)
{
	if(issubstr(param_00,"_left"))
	{
		self.var_164D[param_00].var_10307 = "left";
		return;
	}

	if(issubstr(param_00,"_right"))
	{
		self.var_164D[param_00].var_10307 = "right";
		return;
	}
}

//Function Number: 9
func_3514(param_00,param_01,param_02,param_03)
{
	var_04 = self.var_164D[param_00].var_10307;
	if(!isdefined(var_04))
	{
		return 0;
	}

	if(!isdefined(self.var_13CC3[var_04]))
	{
		return 0;
	}

	return self.var_13CC3[var_04] == param_03;
}

//Function Number: 10
func_3518(param_00)
{
	var_01 = self.var_1198.var_FECD;
	if(!isdefined(var_01))
	{
		return 0;
	}

	foreach(var_04, var_03 in self.var_13CC3)
	{
		if(var_04 == param_00)
		{
			return isdefined(var_01.var_13CC3[var_04]);
		}
	}

	return 0;
}

//Function Number: 11
func_3519(param_00,param_01,param_02,param_03)
{
	return !func_351A(param_00,param_01,param_02,param_03);
}

//Function Number: 12
func_351A(param_00,param_01,param_02,param_03)
{
	var_04 = self.var_1198.var_FECD;
	if(!isdefined(var_04))
	{
		return 0;
	}

	var_05 = self.var_164D[param_00].var_10307;
	if(var_05 == "left")
	{
		var_06 = "left_arm";
	}
	else
	{
		var_06 = "right_arm";
	}

	if(lib_0A1B::func_9ED3(var_06))
	{
		return 0;
	}

	if(!isdefined(self.var_13CC3[var_05]) || self.var_13CC3[var_05] != param_03)
	{
		return 0;
	}

	return lib_0C08::func_10079(var_05);
}

//Function Number: 13
func_3515(param_00,param_01,param_02,param_03)
{
	return !func_3516(param_00,param_01,param_02,param_03);
}

//Function Number: 14
func_3516(param_00,param_01,param_02,param_03)
{
	var_04 = self.var_1198.var_FECD;
	if(!isdefined(var_04))
	{
		return 0;
	}

	var_05 = self.var_164D[param_00].var_10307;
	if(var_05 == "left")
	{
		var_06 = "left_arm";
	}
	else
	{
		var_06 = "right_arm";
	}

	if(lib_0A1B::func_9ED3(var_06))
	{
		return 0;
	}

	if(!isdefined(self.var_13CC3[var_05]) || self.var_13CC3[var_05] != param_03)
	{
		return 0;
	}

	return lib_0C08::func_A004(var_05);
}

//Function Number: 15
func_3517(param_00,param_01,param_02,param_03)
{
	var_04 = self.var_164D[param_00].var_4C1A;
	return !isdefined(var_04) || isdefined(var_04.var_2720);
}

//Function Number: 16
func_35AE(param_00,param_01,param_02,param_03)
{
	return lib_0A1B::func_9ED3(param_03);
}