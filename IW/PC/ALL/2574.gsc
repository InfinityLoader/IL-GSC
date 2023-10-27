/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 2574.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 27
 * Decompile Time: 10 ms
 * Timestamp: 10/27/2023 12:23:22 AM
*******************************************************************/

//Function Number: 1
func_B602(param_00)
{
	self endon("melee_finished");
	self waittill("terminate_ai_threads");
	lib_0A1B::func_2916();
}

//Function Number: 2
func_B599(param_00,param_01)
{
	if(!isdefined(param_01))
	{
		param_01 = self.var_10C;
	}

	if(isdefined(self.var_B55B))
	{
		func_B580();
	}

	lib_0A1B::func_297F(param_01);
	self.var_B55B.var_1158F = param_00;
	param_01.var_B55B.var_1158F = param_00;
	return level.var_111AE;
}

//Function Number: 3
func_B580()
{
	self method_8484();
	if(isdefined(self.var_B55B))
	{
		if(isdefined(self.var_B55B.target))
		{
			self.var_B55B.target.var_B55B = undefined;
		}

		self.var_B55B = undefined;
	}
}

//Function Number: 4
func_3914(param_00)
{
	if(isdefined(self.var_B55B))
	{
		return 0;
	}

	if(!isdefined(self.var_B5E4) || !self.var_B5E4)
	{
		return 0;
	}

	if(!isdefined(param_00.var_B55B))
	{
		return 0;
	}

	var_01 = param_00.var_B55B.var_C92C;
	if(!isdefined(var_01) || !isdefined(var_01.var_B55B))
	{
		return 0;
	}

	if(isdefined(var_01.var_B55B.var_29A8))
	{
		return 0;
	}

	var_02 = distance(param_00.origin,self.origin);
	var_03 = distance(param_00.origin,var_01.origin);
	if(var_02 + 48 > var_03)
	{
		return 0;
	}

	return 1;
}

//Function Number: 5
func_9E96(param_00)
{
	var_01 = self.var_10C;
	if(isdefined(param_00))
	{
		var_01 = param_00;
	}

	if(isdefined(self.var_5966))
	{
		return 0;
	}

	if(isdefined(self.var_3135.var_38E1))
	{
		return 0;
	}

	if(!isdefined(var_01))
	{
		return 0;
	}

	if(isdefined(var_01.var_5966))
	{
		return 0;
	}

	if(isdefined(self.var_1412) && !func_38CD())
	{
		return 0;
	}

	if(func_9DD1(var_01))
	{
		if(!func_3914(var_01))
		{
			return 0;
		}
	}

	return 1;
}

//Function Number: 6
func_10039(param_00,param_01)
{
	if(!isdefined(param_01))
	{
		param_01 = self.var_10C;
	}

	if(!func_9E96(param_01))
	{
		return level.var_6AD5;
	}

	if(![[ self.var_71AF ]](param_01,1))
	{
		return level.var_6AD5;
	}

	if(!func_9E98(param_01))
	{
		return level.var_6AD5;
	}

	return level.var_111AE;
}

//Function Number: 7
func_9896(param_00)
{
	self.var_3135.var_9928[param_00] = spawnstruct();
	self.var_3135.var_9928[param_00].var_11901 = gettime();
	self.var_3135.var_9928[param_00].var_312F = 0;
	if(isplayer(self.var_B55B.target))
	{
		self.var_3135.var_9928[param_00].var_163 = self.var_163;
		self.var_163 = 0;
	}

	lib_0A1B::func_2965(self.var_B55B.target);
	if(isdefined(self.var_71BF))
	{
		self [[ self.var_71BF ]]();
	}

	if(!isdefined(self.var_B5DA) && isplayer(self.var_B55B.target) && !self.var_B55B.target isonground())
	{
		self.var_B55B.var_2720 = 1;
	}

	self method_841F();
	if(isai(self.var_B55B.target))
	{
		self.var_B55B.target method_841F();
	}
}

//Function Number: 8
func_5903(param_00)
{
	if(!isdefined(self.var_B55B))
	{
		return level.var_6AD5;
	}

	if(isdefined(self.var_B55B.var_2720))
	{
		return level.var_6AD5;
	}

	if(lib_0A1A::func_232A("melee_attack","end"))
	{
		return level.var_111AE;
	}

	if(lib_0A1A::func_232A("melee_attack","begin",0))
	{
		self.var_3135.var_9928[param_00].var_312F = 1;
		self.var_3135.var_9928[param_00].var_11901 = gettime() + 10000;
	}

	if(!self.var_3135.var_9928[param_00].var_312F)
	{
		if(!isdefined(self.var_B55B.target) || !isalive(self.var_B55B.target))
		{
			return level.var_6AD5;
		}
	}

	if(gettime() > self.var_3135.var_9928[param_00].var_11901 + 2000)
	{
		self.var_B55B.var_2720 = 1;
		return level.var_6AD5;
	}

	if(isdefined(self.var_B55B.target) && !isplayer(self.var_B55B.target) && self.var_B55B.target lib_0A1B::func_2938())
	{
		return level.var_6AD5;
	}

	return level.var_E87A;
}

//Function Number: 9
func_41C6(param_00)
{
	lib_0A1B::func_2914();
	if(isdefined(self.var_B55B) && !isdefined(self.var_B55B.var_312F))
	{
		if(isdefined(self.var_B55B.target))
		{
			self.var_B55B.target.var_B55B = undefined;
		}

		self.var_B55B = undefined;
	}

	if(isdefined(self.var_3135.var_9928[param_00].var_163))
	{
		self.var_163 = self.var_3135.var_9928[param_00].var_163;
	}

	self.var_3135.var_9928[param_00] = undefined;
}

//Function Number: 10
func_B5C3(param_00)
{
	if(isdefined(self.var_10C) && isdefined(self.var_10C.var_B55B))
	{
		if(isdefined(self.var_10C.var_B55B.var_C92C))
		{
			self.var_10C.var_B55B.var_C92C func_B580();
		}
		else
		{
			self.var_10C func_B580();
		}
	}

	return level.var_111AE;
}

//Function Number: 11
func_B653(param_00)
{
	func_B599(param_00);
	if(isdefined(self.var_71C2))
	{
		self [[ self.var_71C2 ]](param_00);
	}

	thread func_B602(self.var_10C);
}

//Function Number: 12
func_B655(param_00)
{
	lib_0A1B::func_2914();
	func_B580();
	if(isdefined(self.var_71C3))
	{
		self [[ self.var_71C3 ]](param_00);
	}
}

//Function Number: 13
func_B657(param_00)
{
	if(!isdefined(self.var_B55B.target) || !isalive(self.var_B55B.target))
	{
		return level.var_6AD5;
	}

	if(lib_0A1A::func_232A("melee_attack","end"))
	{
		return level.var_111AE;
	}

	lib_0A1B::func_2965(self.var_B55B.target);
	return level.var_E87A;
}

//Function Number: 14
func_B5B4(param_00,param_01)
{
	if(!isdefined(anim))
	{
		return;
	}

	if(!isdefined(level.var_B5F5))
	{
		return;
	}

	if(!isdefined(param_00))
	{
		return;
	}

	if(!isdefined(param_01))
	{
		param_01 = 1;
	}

	if(isplayer(self.var_B55B.target) && isdefined(level.var_B5F6[self.var_12BA4]))
	{
		level.var_B5F7[self.var_12BA4] = gettime() + level.var_B5F6[self.var_12BA4] * param_01;
		return;
	}

	if(isdefined(level.var_B5F5[self.var_12BA4]))
	{
		level.var_B5F8[self.var_12BA4] = gettime() + level.var_B5F5[self.var_12BA4] * param_01;
	}
}

//Function Number: 15
func_B5E8(param_00)
{
	self.var_B55B.var_3D2C = 1;
	if(isdefined(self.var_71C0))
	{
		self [[ self.var_71C0 ]](param_00);
	}

	func_B5B4(self.var_12BA4,3);
	self.var_3135.var_9928[param_00] = spawnstruct();
	self.var_3135.var_9928[param_00].var_3E30 = gettime() + 100;
	self.var_3135.var_9928[param_00].var_11901 = gettime() + 4000;
	self.var_3135.var_9928[param_00].var_6572 = self.var_10C.origin;
	if(isplayer(self.var_B55B.target))
	{
		self.var_3135.var_9928[param_00].var_163 = self.var_163;
		self.var_163 = 0;
	}

	self.var_1D5 = 64;
}

//Function Number: 16
func_B5EE(param_00)
{
	if(isdefined(self.var_B55B))
	{
		func_B5B4(self.var_12BA4,0);
	}

	if(isdefined(self.var_B55B) && isdefined(self.var_B55B.var_2720) || !isdefined(self.var_B55B.var_29A8))
	{
		func_B580();
	}

	self method_8484();
	self.var_1D5 = 0;
	if(isdefined(self.var_3135.var_9928[param_00].var_163))
	{
		self.var_163 = self.var_3135.var_9928[param_00].var_163;
	}

	lib_0A1B::func_2913();
	if(isdefined(self.var_71C1))
	{
		self [[ self.var_71C1 ]](param_00);
	}

	self.var_3135.var_9928[param_00] = undefined;
}

//Function Number: 17
func_7FAB(param_00)
{
	if(isplayer(param_00))
	{
		var_01 = self.meleechargedistvsplayer;
	}
	else
	{
		var_01 = self.meleechargedist;
	}

	if(!lib_0A06::func_8BC8())
	{
		var_01 = var_01 * self.meleechargedistreloadmultiplier;
	}

	return var_01;
}

//Function Number: 18
func_B5B5()
{
	if(!isdefined(self.var_B55B))
	{
		return 1;
	}

	var_00 = self.var_B55B.target;
	if(!isdefined(var_00))
	{
		return 1;
	}

	if(!isalive(var_00))
	{
		return 1;
	}

	if(!isplayer(var_00) && var_00 lib_0A1B::func_2938())
	{
		return 1;
	}

	return 0;
}

//Function Number: 19
func_B5EB()
{
	if(func_B5B5())
	{
		return 1;
	}

	if(isdefined(self.var_3135.var_38E1))
	{
		return 1;
	}

	if(isdefined(self.var_B55B.var_2720))
	{
		return 1;
	}

	var_00 = self.var_B55B.target;
	if(isdefined(var_00.var_C337) && var_00.var_C337.var_19)
	{
		if(isai(var_00) || !isdefined(self.var_B5DC) || !self.var_B5DC)
		{
			return 1;
		}
	}

	if(isdefined(self.var_10C) && var_00 != self.var_10C)
	{
		return 1;
	}

	if(lib_0A1A::func_232A("melee_charge_state","end"))
	{
		return 1;
	}

	return 0;
}

//Function Number: 20
func_B5E7(param_00)
{
	self.var_BF90 = gettime() + 1500;
	self.var_A985 = param_00;
}

//Function Number: 21
func_B5EA(param_00,param_01)
{
	var_02 = self.var_3135.var_9928[param_00].var_1157A;
	if(!isdefined(var_02))
	{
		return 0;
	}

	if(isdefined(self.var_233) && distance2dsquared(self.var_233,self.origin) > 16)
	{
		return 0;
	}

	return distancesquared(var_02,param_01) < 4;
}

//Function Number: 22
func_B5F0(param_00)
{
	if(func_B5EB())
	{
		if(isdefined(self.var_B55B))
		{
			self.var_B55B.var_2720 = 1;
		}

		return level.var_6AD5;
	}

	var_01 = self.meleerangesq;
	if(!isdefined(var_01))
	{
		var_01 = 4096;
	}

	var_02 = self.var_B55B.target;
	if(isdefined(self.var_B5DA) || isdefined(self.var_B621))
	{
		var_03 = distance2dsquared(var_02.origin,self.origin);
	}
	else
	{
		var_03 = distancesquared(var_03.origin,self.origin);
	}

	var_04 = func_7FAB(var_02) + 24;
	var_05 = var_04 * var_04;
	if(var_03 > var_05)
	{
		self.var_B55B.var_2720 = 1;
		return level.var_6AD5;
	}

	if(isplayer(var_02))
	{
		var_06 = getclosestpointonnavmesh(var_02.origin,self);
	}
	else
	{
		var_06 = var_03 method_84AC();
	}

	var_07 = var_01;
	var_08 = length(self.var_381);
	if(var_08 > 1)
	{
		var_07 = squared(sqrt(var_01) + var_08 * 0.1);
	}

	if(var_03 <= var_07)
	{
		if(isplayer(var_02))
		{
			if(scripts\common\utility::func_B616())
			{
				return level.var_E87A;
			}
		}

		var_09 = 18;
		if(isdefined(self.var_2C0) && self.var_2C0 != "none" && isplayer(var_02))
		{
			var_09 = 32;
		}

		if(isdefined(self.var_B621) || abs(self.origin[2] - var_02.origin[2]) < var_09)
		{
			var_0A = self method_84AC();
			if(self [[ self.var_7199 ]](var_0A,var_06))
			{
				self.var_B55B.var_29A8 = 1;
				return level.var_111AE;
			}
		}
	}

	if(self.var_2748 || gettime() > self.var_3135.var_9928[param_00].var_3E30 && !isdefined(self.var_233))
	{
		func_B5E7(var_02);
		self.var_B55B.var_2720 = 1;
		return level.var_6AD5;
	}

	if(!isdefined(self.var_B55B.var_2AC7) || !self.var_B55B.var_2AC7)
	{
		if(gettime() >= self.var_3135.var_9928[param_00].var_11901)
		{
			func_B5E7(var_02);
			self.var_B55B.var_2720 = 1;
			return level.var_6AD5;
		}
	}

	if(!isdefined(self.var_B55B.var_2AC6) || !self.var_B55B.var_2AC6)
	{
		if(isdefined(self.var_B5DA))
		{
			var_0B = distance2dsquared(var_02.origin,self.var_3135.var_9928[param_00].var_6572);
		}
		else
		{
			var_0B = distancesquared(var_03.origin,self.var_3135.var_9928[var_01].var_6572);
		}

		if(var_0B > 16384)
		{
			func_B5E7(var_02);
			self.var_B55B.var_2720 = 1;
			return level.var_6AD5;
		}
	}

	var_0C = max(sqrt(var_01) - 24,0);
	var_0D = vectornormalize(self.origin - var_02.origin);
	var_0E = var_02.origin + var_0D * var_0C;
	var_0F = 36;
	if(isdefined(self.var_B64F))
	{
		var_0F = self.var_B64F;
	}

	var_10 = 1;
	if(!func_B5EA(param_00,var_0E))
	{
		var_11 = getclosestpointonnavmesh(var_0E,self);
		var_10 = distance2dsquared(var_0E,var_11) > var_0F;
		if(!var_10)
		{
			var_10 = !self [[ self.var_7199 ]](var_11,var_06);
		}
	}

	if(var_10 && isdefined(self.var_B651) && self.var_B651)
	{
		if(isdefined(var_02.var_205))
		{
			if(scripts\common\utility::func_9EB4(var_02.var_205))
			{
				var_12 = function_02D3(var_02.var_205.angles);
				var_0E = var_02.var_205.origin + var_12 * var_0C;
			}
			else if(scripts\common\utility::func_9EB7(var_02.var_205))
			{
				var_13 = anglestoright(var_02.var_205.angles);
				var_0E = var_02.var_205.origin + var_13 * var_0C;
			}
			else
			{
				var_14 = anglestoforward(var_02.var_205.angles);
				var_0E = var_02.var_205.origin - var_14 * var_0C;
			}

			if(!func_B5EA(param_00,var_0E))
			{
				var_11 = getclosestpointonnavmesh(var_0E,self);
				var_10 = distance2dsquared(var_0E,var_11) > var_0F;
			}
		}

		if(var_10)
		{
			var_0E = var_02.origin - var_0D * var_0C;
			if(!func_B5EA(param_00,var_0E))
			{
				var_11 = getclosestpointonnavmesh(var_0E,self);
				var_10 = distance2dsquared(var_0E,var_11) > var_0F;
			}
		}

		if(var_10)
		{
			var_0E = var_06;
			var_10 = 0;
		}
	}

	if(var_10)
	{
		func_B5E7(var_02);
		self.var_B55B.var_2720 = 1;
		return level.var_6AD5;
	}

	self method_8481(var_0E);
	self.var_6D = 6;
	self.var_3135.var_9928[param_00].var_1157A = var_0E;
	lib_0A1B::func_2966(var_02,var_0E);
	return level.var_E87A;
}

//Function Number: 23
func_8198(param_00)
{
	var_01 = param_00.origin;
	var_02 = param_00.origin - self.origin;
	var_02 = vectornormalize(var_02);
	var_01 = var_01 - var_02 * self.meleeactorboundsradius;
	var_03 = getclosestpointonnavmesh(var_01,self);
	if(abs(var_01[2] - var_03[2]) > self.maxzdiff)
	{
		return undefined;
	}

	var_04 = navtrace(self.origin,var_03,self,1);
	var_05 = var_04["fraction"];
	if(var_05 < self.var_1548)
	{
		return undefined;
	}

	return var_03;
}

//Function Number: 24
func_38CD()
{
	if(isdefined(self.var_65DB) && isdefined(self.var_65DB["_stealth_enabled"]) && self.var_65DB["_stealth_enabled"])
	{
		if(isdefined(self.var_65DB["_stealth_attack"]) && !self.var_65DB["_stealth_attack"])
		{
			return 0;
		}
	}

	return level.var_111AE;
}

//Function Number: 25
func_9DD1(param_00)
{
	var_01 = self.var_10C;
	if(isdefined(param_00))
	{
		var_01 = param_00;
	}

	if(isdefined(self.var_B55B))
	{
		return 1;
	}

	if(isdefined(var_01.var_B55B))
	{
		return 1;
	}

	return 0;
}

//Function Number: 26
func_9E98(param_00)
{
	if(abs(param_00.origin[2] - self.origin[2]) > self.var_B627)
	{
		return 0;
	}

	var_01 = func_7FAB(param_00);
	var_02 = var_01 * var_01;
	var_03 = distancesquared(self.origin,param_00.origin);
	return var_03 <= var_02;
}

//Function Number: 27
func_9E9A(param_00,param_01)
{
	if(isdefined(self.var_5966))
	{
		return 0;
	}

	if(!isdefined(param_00))
	{
		return 0;
	}

	if(isdefined(param_00.var_5966))
	{
		return 0;
	}

	if(!isalive(self))
	{
		return 0;
	}

	if(!isalive(param_00))
	{
		return 0;
	}

	return 1;
}