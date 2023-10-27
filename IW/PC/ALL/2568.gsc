/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 2568.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 18
 * Decompile Time: 2 ms
 * Timestamp: 10/27/2023 12:23:21 AM
*******************************************************************/

//Function Number: 1
func_97EC(param_00)
{
	self.var_71A8 = ::func_7FD3;
	self.var_71AE = ::func_9D2E;
	self.var_71CA = ::func_E259;
	self.var_71A9 = ::func_811D;
	self.var_71AA = ::func_81E3;
	self.var_71A0 = ::func_4F67;
	self.var_71AB = ::func_81F4;
	self.var_71A6 = ::func_7EFC;
	self.var_7196 = ::func_2542;
	self.var_71BD = ::func_129AD;
	self.var_71BC = ::func_129AA;
	self.var_71CB = ::func_EB83;
	self.var_71D5 = ::func_12E93;
	self.var_71C7 = ::scripts\sp\_utility::func_D022;
	return level.var_111AE;
}

//Function Number: 2
func_103F5(param_00)
{
	if(isdefined(self.var_4D5D))
	{
		lib_0A15::func_FAA4();
		thread lib_0A1E::func_111A9();
		self.var_719D = ::func_103F3;
		self.var_8E1E = 1;
	}

	return level.var_111AE;
}

//Function Number: 3
func_E259()
{
	scripts\sp\_gameskill::func_E259();
}

//Function Number: 4
func_7FD3()
{
	if(isdefined(self.var_10AB7) && self.var_10AB7)
	{
		return "sprint";
	}

	if(scripts\anim\utility::func_FFDB())
	{
		return "cqb";
	}

	if(isdefined(self.var_527B))
	{
		return self.var_527B;
	}

	var_00 = lib_0A02::func_75();
	return var_00;
}

//Function Number: 5
func_9D2E()
{
	return lib_0A2B::func_1A3A();
}

//Function Number: 6
func_129AD()
{
	self method_81D6();
}

//Function Number: 7
func_129AA()
{
	self method_81D5();
}

//Function Number: 8
func_EB83(param_00)
{
	scripts\anim\face::func_EB83(param_00);
}

//Function Number: 9
func_811D()
{
	return scripts\anim\shared::func_811C();
}

//Function Number: 10
func_81E3(param_00)
{
	return param_00 method_851F();
}

//Function Number: 11
func_4F67()
{
	return scripts\anim\shared::func_4F66();
}

//Function Number: 12
func_7EFC()
{
	var_00 = undefined;
	var_01 = 1;
	var_02 = 1;
	var_03 = 1;
	if(isdefined(self.var_205) && scripts\asm\shared_utility::func_9D50())
	{
		var_01 = self.var_205 method_80B1("stand");
		var_02 = self.var_205 method_80B1("crouch");
		var_03 = self.var_205 method_80B1("prone");
	}
	else if(!lib_0A1B::func_2955() && isdefined(self.var_1198.var_FECD) && isdefined(self.var_1198.var_FECD.var_D699))
	{
		var_04 = distancesquared(self.origin,self.var_1198.var_FECD.var_D699);
		if(var_04 > 262144 && self method_81BF("crouch") && !scripts\common\utility::func_167E() && !scripts\anim\utility_common::func_9FCA())
		{
			if(sighttracepassed(self.origin + (0,0,32),self.var_1198.var_FECD.var_D699,0,undefined))
			{
				return "crouch";
			}
		}
	}

	for(;;)
	{
		if(self method_81BF("stand") && var_01)
		{
			return "stand";
		}

		if(self method_81BF("crouch") && var_02)
		{
			return "crouch";
		}

		if(self method_81BF("prone") && var_03)
		{
			return "prone";
		}

		if(!var_01 || !var_02 || !var_03)
		{
			var_01 = 1;
			var_02 = 1;
			var_03 = 1;
			continue;
		}

		break;
	}

	return "crouch";
}

//Function Number: 13
func_3DE5()
{
	if(!isdefined(level.var_A936[self.team]))
	{
		return 0;
	}

	if(lib_0A06::func_10026())
	{
		return 1;
	}

	if(gettime() - level.var_A936[self.team] < level.var_18D7)
	{
		return 0;
	}

	if(!issentient(self.var_10C))
	{
		return 0;
	}

	if(level.var_18D5[self.team])
	{
		level.var_18D5[self.team] = 0;
	}

	var_00 = isdefined(self.var_18CC) && self.var_18CC;
	if(!var_00 && function_0073(self.team) < function_0073(self.var_10C.team))
	{
		return 0;
	}

	return 1;
}

//Function Number: 14
func_2543()
{
	if(!self method_81A5(self.var_10C.origin))
	{
		return 0;
	}

	if(scripts\anim\utility_common::func_9E83())
	{
		return 0;
	}

	if(!func_3DE5())
	{
		return 0;
	}

	self method_80E6(0);
	if(self method_8254())
	{
		self.var_1A4 = 0;
		self.var_1A3 = 0;
		if(level.var_18D5[self.team] == 0)
		{
			level.var_A936[self.team] = gettime();
			level.var_A933[self.team] = self;
		}

		level.var_A935[self.team] = self.origin;
		level.var_A934[self.team] = self.var_10C.origin;
		level.var_18D5[self.team]++;
		return 1;
	}

	return 0;
}

//Function Number: 15
func_2542(param_00)
{
	if(!lib_0A06::func_FFC2())
	{
		return level.var_6AD5;
	}

	switch(self.var_3135.var_9928[param_00])
	{
		case 0:
			if(self method_8255(32))
			{
				return level.var_111AE;
			}
			break;

		case 3:
			if(self method_8255(64))
			{
				return level.var_111AE;
			}
			break;

		case 7:
			if(self method_8255(96))
			{
				return level.var_111AE;
			}
			break;

		case 11:
			if(func_2543())
			{
				return level.var_111AE;
			}
			break;

		case 15:
			self method_80EC();
			break;
	}

	self.var_3135.var_9928[param_00]++;
	if(self.var_3135.var_9928[param_00] > 60)
	{
		self.var_3135.var_9928[param_00] = 0;
	}

	return level.var_E87A;
}

//Function Number: 16
func_81F4()
{
	return self method_8164();
}

//Function Number: 17
func_12E93()
{
	if(self.var_12BA4 == "c6i" || scripts\common\utility::func_167E() || self.team == "neutral")
	{
		return level.var_111AE;
	}

	var_00 = gettime();
	if(!isdefined(self.var_1198.var_7362) || self.var_1198.var_7362 > var_00)
	{
		var_01 = function_0072(scripts\common\utility::func_7984(self.team));
		var_02 = 0;
		var_03 = 10000;
		var_04 = 4194304;
		var_05 = 5;
		self.var_1198.var_7362 = var_00 + 10000;
		self.var_1198.var_7366 = "combat";
		foreach(var_07 in var_01)
		{
			var_08 = distancesquared(self lastknownpos(var_07),self.origin);
			if(var_08 > var_04)
			{
				continue;
			}

			var_09 = gettime() - self lastknowntime(var_07);
			if(var_09 > var_03)
			{
				continue;
			}

			var_02++;
			if(var_07.var_12BA4 == "c8" || var_07.var_12BA4 == "c12")
			{
				self.var_1198.var_7366 = "frantic";
				break;
			}

			if(var_02 >= 3)
			{
				self.var_1198.var_7366 = "frantic";
				break;
			}
		}
	}

	return level.var_111AE;
}

//Function Number: 18
func_103F3(param_00)
{
	switch(param_00.var_22A)
	{
		case "helmet":
			if(isdefined(self.var_C065) && self.var_C065)
			{
			}
	
			if(isdefined(self.var_C554) && self.var_C554)
			{
			}
	
			lib_0C60::func_8E17();
			break;
	}
}