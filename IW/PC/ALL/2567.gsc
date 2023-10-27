/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 2567.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 9
 * Decompile Time: 1 ms
 * Timestamp: 10/27/2023 12:23:21 AM
*******************************************************************/

//Function Number: 1
func_B29B(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B,param_0C,param_0D)
{
	var_0E = [];
	if(isdefined(param_00))
	{
		var_0E[0] = param_00;
	}
	else
	{
		return var_0E;
	}

	if(isdefined(param_01))
	{
		var_0E[1] = param_01;
	}
	else
	{
		return var_0E;
	}

	if(isdefined(param_02))
	{
		var_0E[2] = param_02;
	}
	else
	{
		return var_0E;
	}

	if(isdefined(param_03))
	{
		var_0E[3] = param_03;
	}
	else
	{
		return var_0E;
	}

	if(isdefined(param_04))
	{
		var_0E[4] = param_04;
	}
	else
	{
		return var_0E;
	}

	if(isdefined(param_05))
	{
		var_0E[5] = param_05;
	}
	else
	{
		return var_0E;
	}

	if(isdefined(param_06))
	{
		var_0E[6] = param_06;
	}
	else
	{
		return var_0E;
	}

	if(isdefined(param_07))
	{
		var_0E[7] = param_07;
	}
	else
	{
		return var_0E;
	}

	if(isdefined(param_08))
	{
		var_0E[8] = param_08;
	}
	else
	{
		return var_0E;
	}

	if(isdefined(param_09))
	{
		var_0E[9] = param_09;
	}
	else
	{
		return var_0E;
	}

	if(isdefined(param_0A))
	{
		var_0E[10] = param_0A;
	}
	else
	{
		return var_0E;
	}

	if(isdefined(param_0B))
	{
		var_0E[11] = param_0B;
	}
	else
	{
		return var_0E;
	}

	if(isdefined(param_0C))
	{
		var_0E[12] = param_0C;
	}
	else
	{
		return var_0E;
	}

	if(isdefined(param_0D))
	{
		var_0E[13] = param_0D;
	}

	return var_0E;
}

//Function Number: 2
func_97ED(param_00)
{
	self.var_71A8 = ::func_7FD3;
	self.var_71AE = ::lib_0F3C::func_9D2E;
	self.var_71A0 = ::func_4F66;
	self.var_71A6 = ::func_7EFC;
	if(isdefined(self.var_394))
	{
		self.var_3250 = weaponclipsize(self.var_394);
		self.var_D8E1 = self.var_394;
	}
	else
	{
		self.var_3250 = 0;
		self.var_D8E1 = "none";
	}

	self.var_F0C4 = "none";
	self.var_101B4 = "none";
	anim.var_32BF = func_B29B(1,2,2,2,3,3,3,3,4,4,5);
	anim.var_6B93 = func_B29B(2,3,3,3,4,4,4,5,5);
	anim.var_F217 = func_B29B(1,2,2,3,3,4,4,4,4,5,5,5);
	if(!isdefined(level.var_FE9B))
	{
		anim.var_FE9B = ::func_FE9D;
	}

	if(!isdefined(level.var_FED3))
	{
		anim.var_FED3 = ::func_FED2;
	}

	self.var_A9ED = 0;
	self.var_504E = 55;
	self.var_129AF = 55;
	self.var_368 = -60;
	self.var_100 = 60;
	self.var_251 = 0;
	self.var_DCAF = 256;
	self.var_B781 = 750;
	if(self.team == "allies")
	{
		self.var_112CE = 0.5;
	}
	else
	{
		self.var_112CE = 0;
	}

	func_F724();
	return level.var_111AE;
}

//Function Number: 3
func_F724()
{
	anim.var_4717 = 55;
	anim.var_1A52 = 10;
	anim.var_1A50 = 4096;
	anim.var_1A51 = 45;
	anim.var_1A44 = 20;
	anim.var_C88B = 25;
	anim.var_C889 = level.var_1A50;
	anim.var_C88A = level.var_1A51;
	anim.var_C87D = 30;
	anim.var_B480 = 65;
	anim.var_B47F = 65;
}

//Function Number: 4
func_FA33()
{
	self.var_B4C3 = 130;
	self.var_E878 = 0.4615385;
	self.var_E876 = 0.3;
}

//Function Number: 5
func_7FD3()
{
	if(isdefined(self.var_10AB7) && self.var_10AB7)
	{
		return "sprint";
	}

	if(isdefined(self.var_15F) && isdefined(self.var_10C) && self.var_14F == 1)
	{
		if(distancesquared(self.origin,self.var_10C.origin) > 90000)
		{
			return "sprint";
		}
	}

	if(isdefined(self.var_527B))
	{
		return self.var_527B;
	}

	if(isdefined(self.var_10C) || isdefined(self.var_6571))
	{
		return "combat";
	}

	return "walk";
}

//Function Number: 6
func_4F66()
{
	var_00 = self.var_3250;
	if(weaponclass(self.var_394) == "mg")
	{
		var_01 = randomfloat(10);
		if(var_01 < 3)
		{
			var_00 = randomintrange(2,6);
		}
		else if(var_01 < 8)
		{
			var_00 = randomintrange(6,12);
		}
		else
		{
			var_00 = randomintrange(12,20);
		}
	}

	return var_00;
}

//Function Number: 7
func_FE9D(param_00)
{
	self.var_A9ED = gettime();
	var_01 = lib_0F3C::func_811C();
	var_02 = lib_0F3C::func_811E(var_01);
	func_FED2(var_02,param_00);
}

//Function Number: 8
func_FED2(param_00,param_01)
{
	self method_837B(1,param_00,1,0,1);
}

//Function Number: 9
func_7EFC()
{
	if(isdefined(self.var_205))
	{
		var_00 = self.var_205 method_812D();
		if(var_00 == "prone" && self.var_12BA4 == "c6")
		{
			var_00 = "crouch";
		}

		return var_00;
	}

	return undefined;
}