/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 2586.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 59
 * Decompile Time: 14 ms
 * Timestamp: 10/27/2023 12:23:24 AM
*******************************************************************/

//Function Number: 1
func_2343()
{
	if(isdefined(level.var_2303))
	{
		return;
	}

	anim.var_2303 = [];
}

//Function Number: 2
func_230B(param_00,param_01)
{
	func_2343();
	level.var_2303[param_00] = spawnstruct();
	level.var_2303[param_00].var_9881 = param_01;
	level.var_2303[param_00].var_10E2F = [];
	level.var_2303[param_00].var_F281 = [];
	anim.var_DEF5 = param_00;
}

//Function Number: 3
func_232E(param_00)
{
	return isdefined(level.var_2303) && isdefined(level.var_2303[param_00]);
}

//Function Number: 4
func_2327()
{
	anim.var_DEF5 = undefined;
	anim.var_DEF7 = undefined;
}

//Function Number: 5
func_2373(param_00,param_01)
{
	level.var_2303[level.var_DEF5].var_F281[param_00] = param_01;
}

//Function Number: 6
func_2374(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B,param_0C,param_0D,param_0E,param_0F,param_10,param_11,param_12,param_13,param_14,param_15)
{
	var_16 = level.var_2303[level.var_DEF5];
	var_16.var_10E2F[param_00] = spawnstruct();
	var_16.var_10E2F[param_00].var_7048 = param_01;
	var_16.var_10E2F[param_00].var_E88A = param_02;
	var_16.var_10E2F[param_00].var_71C5 = param_03;
	var_16.var_10E2F[param_00].var_71D2 = param_04;
	var_16.var_10E2F[param_00].var_116FB = param_05;
	var_16.var_10E2F[param_00].var_71A5 = param_06;
	var_16.var_10E2F[param_00].var_7DC8 = param_07;
	var_16.var_10E2F[param_00].var_1267B = [];
	var_16.var_10E2F[param_00].var_134 = param_08;
	var_16.var_10E2F[param_00].var_10B53 = param_09;
	var_16.var_10E2F[param_00].var_6A8B = param_0B;
	var_16.var_10E2F[param_00].var_C87F = param_0C;
	var_16.var_10E2F[param_00].var_C87C = param_0D;
	var_16.var_10E2F[param_00].var_4E6D = param_0E;
	var_16.var_10E2F[param_00].var_4E54 = param_0F;
	var_16.var_10E2F[param_00].var_D773 = param_10;
	var_16.var_10E2F[param_00].var_D772 = param_11;
	var_16.var_10E2F[param_00].var_116FA = param_12;
	var_16.var_10E2F[param_00].var_C704 = param_13;
	var_16.var_10E2F[param_00].var_1FBA = param_14;
	var_16.var_10E2F[param_00].var_C94B = param_15;
	var_16.var_10E2F[param_00].var_111AC = param_0A;
	anim.var_DEF7 = param_00;
}

//Function Number: 7
func_2375(param_00,param_01,param_02,param_03,param_04,param_05)
{
	var_06 = level.var_2303[level.var_DEF5];
	var_07 = spawnstruct();
	var_07.var_2B93 = param_01;
	var_07.var_71D1 = param_02;
	var_07.var_100B1 = param_03;
	var_07.var_11A1A = param_00;
	var_06.var_10E2F[level.var_DEF7].var_1267B[var_06.var_10E2F[level.var_DEF7].var_1267B.size] = var_07;
}

//Function Number: 8
func_232F(param_00,param_01,param_02)
{
	var_03 = spawnstruct();
	var_03.var_7686 = gettime();
	var_03.name = param_01;
	var_03.var_C8F0 = param_02;
	if(!isdefined(self.var_1198.var_2329[param_00]))
	{
		self.var_1198.var_2329[param_00] = [];
	}

	self.var_1198.var_2329[param_00][self.var_1198.var_2329[param_00].size] = var_03;
	if(isdefined(self.var_1198.var_2328[param_00]) && self.var_1198.var_2328[param_00] == param_01)
	{
		self.var_3135.var_72EB = 1;
		self.var_1198.var_2328[param_00] = undefined;
	}
}

//Function Number: 9
func_2351(param_00,param_01)
{
	var_02 = level.var_2303[param_00];
	self.var_164D[param_00] = spawnstruct();
	self.var_164D[param_00].var_4BC0 = undefined;
	if(param_01)
	{
		self.var_164D[param_00].var_2F3C = 1;
	}

	foreach(var_04 in var_02.var_F281)
	{
		self thread [[ var_04 ]](param_00);
	}

	func_238A(param_00,var_02.var_9881,0);
}

//Function Number: 10
func_234E()
{
	self.var_1198 = spawnstruct();
	self.var_1198.var_527D = "stand";
	self.var_1198.var_232D = [];
	self.var_1198.var_2329 = [];
	self.var_1198.var_2328 = [];
	self.var_1198.var_2FC8 = 0;
	self.var_1198.var_2AA6 = 0;
	self.var_1198.var_BD23 = "combat";
	self.var_1198.var_1FCD = 0;
	self.var_1198.var_1D64 = 0;
	self.var_1198.var_444A = 0;
}

//Function Number: 11
func_2317(param_00)
{
	if(isdefined(self.var_1198.var_232D[param_00]))
	{
		self.var_1198.var_232D[param_00] = undefined;
	}
}

//Function Number: 12
func_2388(param_00,param_01,param_02,param_03)
{
	self notify(param_01 + "_finished");
	func_2330(param_01,"ASM_Finished");
	if(isdefined(param_02.var_71D2))
	{
		self [[ param_02.var_71D2 ]](param_00,param_01,param_03);
	}

	if(isdefined(param_02.var_116FA))
	{
		func_232F(param_02.var_116FA,"end");
	}
}

//Function Number: 13
func_2387(param_00)
{
	var_01 = level.var_2303[param_00];
	var_02 = self.var_164D[param_00].var_4BC0;
	func_2388(param_00,var_02,var_01.var_10E2F[var_02],var_01.var_10E2F[var_02].var_116FB);
	self.var_164D[param_00] = undefined;
}

//Function Number: 14
func_238A(param_00,param_01,param_02,param_03,param_04,param_05)
{
	var_06 = level.var_2303[param_00];
	var_07 = var_06.var_10E2F[param_01];
	var_08 = self.var_164D[param_00];
	var_08.var_10E23 = var_08.var_4BC0;
	var_08.var_4BC0 = param_01;
	func_2317(param_01);
	self.var_2303.var_4E6E = undefined;
	var_09 = var_07.var_111AC;
	var_0A = undefined;
	if(isdefined(var_08.var_10E23))
	{
		var_0A = var_06.var_10E2F[var_08.var_10E23].var_111AC;
		if(isdefined(var_0A))
		{
			foreach(var_0C in var_0A)
			{
				if(!isdefined(var_09) || !scripts\common\utility::func_2286(var_09,var_0C))
				{
					func_2387(var_0C);
				}
			}
		}
	}

	if(isdefined(self.var_7195))
	{
		self [[ self.var_7195 ]](var_07);
	}

	self [[ self.var_718F ]](var_07);
	if(isdefined(var_08.var_2F3C) && var_08.var_2F3C)
	{
		self.var_34 = isdefined(var_07.var_C87F);
	}

	var_0E = undefined;
	if(isdefined(param_05))
	{
		var_0E = param_05;
	}
	else if(isdefined(var_07.var_E88A))
	{
		var_0E = var_07.var_E88A;
	}

	self thread [[ var_07.var_7048 ]](param_00,param_01,param_02,var_0E);
	if(isdefined(self.var_718D))
	{
		self [[ self.var_718D ]](param_00,var_08.var_10E23,param_01,param_02);
	}

	if(isdefined(self.var_718E))
	{
		self [[ self.var_718E ]](param_00,param_01);
	}

	if(isdefined(var_07.var_111AC))
	{
		foreach(var_0C in var_07.var_111AC)
		{
			if(!isdefined(var_0A) || !scripts\common\utility::func_2286(var_0A,var_0C))
			{
				func_2351(var_0C,0);
			}
		}
	}
}

//Function Number: 15
func_2341(param_00,param_01)
{
	if(isdefined(level.var_2303[param_00].var_10E2F[param_01].var_71C5))
	{
		return level.var_2303[param_00].var_10E2F[param_01].var_71C5;
	}

	return undefined;
}

//Function Number: 16
func_231E(param_00,param_01,param_02)
{
	if(isdefined(self.var_2303.var_4E6E))
	{
		var_03 = self.var_2303.var_4E6E.var_10E2C;
		var_04 = self.var_2303.var_4E6E.var_C8F0;
	}
	else
	{
		var_03 = var_03.var_4E6D;
		var_04 = param_02.var_4E54;
	}

	var_05 = level.var_2303[param_00].var_10E2F[var_03];
	func_2388(param_00,param_02,param_01,param_01.var_116FB);
	var_06 = var_03;
	if(isdefined(var_05.var_C94B) && var_05.var_C94B)
	{
		var_07 = func_2310(param_00,var_03,1);
		var_06 = var_07[0];
		var_08 = var_07[1];
	}

	func_238A(param_00,var_06,0.2,undefined,undefined,var_04);
}

//Function Number: 17
func_231B(param_00,param_01)
{
	var_02 = self.var_164D[param_00];
	if(!isdefined(var_02.var_4BC0))
	{
		return 0;
	}

	var_03 = level.var_2303[param_00].var_10E2F[var_02.var_4BC0].var_134;
	if(isdefined(var_03) && scripts\common\utility::func_2286(var_03,param_01))
	{
		return 1;
	}

	return 0;
}

//Function Number: 18
func_2384(param_00,param_01,param_02)
{
	var_03 = self.var_164D[param_00];
	var_04 = level.var_2303[param_00].var_10E2F[param_01].var_134;
	if(isdefined(var_04) && scripts\common\utility::func_2286(var_04,param_02))
	{
		return 1;
	}

	return 0;
}

//Function Number: 19
func_2331(param_00,param_01,param_02)
{
	if(!isdefined(self.var_1198.var_232D[param_00]))
	{
		self.var_1198.var_232D[param_00] = [];
	}

	var_03 = func_233F(param_00,param_01);
	if(!isdefined(var_03))
	{
		var_03 = spawnstruct();
	}

	var_03.var_7686 = gettime();
	var_03.var_C8F0 = param_02;
	self.var_1198.var_232D[param_00][param_01] = var_03;
	func_232F(param_00,param_01,param_02);
}

//Function Number: 20
func_2330(param_00,param_01,param_02)
{
	func_2331(param_00,param_01,param_02);
	if(param_01 == "anim_will_finish" || param_01 == "finish")
	{
		param_01 = "end";
		func_2331(param_00,param_01);
	}
}

//Function Number: 21
func_2304(param_00,param_01)
{
	self.var_1198.var_2328[param_00] = param_01;
}

//Function Number: 22
func_232A(param_00,param_01,param_02)
{
	if(isdefined(self.var_1198.var_2329[param_00]))
	{
		foreach(var_04 in self.var_1198.var_2329[param_00])
		{
			if(var_04.name == param_01)
			{
				return 1;
			}
		}
	}

	if(!isdefined(param_02) || param_02)
	{
		func_2304(param_00,param_01);
	}

	return 0;
}

//Function Number: 23
func_232C(param_00,param_01)
{
	var_02 = func_233F(param_00,param_01);
	if(isdefined(var_02))
	{
		if(var_02.var_7686 >= gettime() - 50)
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 24
func_233F(param_00,param_01)
{
	if(!isdefined(self.var_1198.var_232D[param_00]))
	{
		return undefined;
	}

	foreach(var_04, var_03 in self.var_1198.var_232D[param_00])
	{
		if(var_04 == param_01)
		{
			return var_03;
		}
	}

	return undefined;
}

//Function Number: 25
func_233E(param_00,param_01)
{
	if(!isdefined(self.var_1198.var_2329[param_00]) || self.var_1198.var_2329[param_00].size == 0)
	{
		return undefined;
	}

	foreach(var_03 in self.var_1198.var_2329[param_00])
	{
		if(var_03.name == param_01)
		{
			return var_03;
		}
	}

	return undefined;
}

//Function Number: 26
func_2314()
{
	self.var_1198.var_2329 = [];
}

//Function Number: 27
func_2383(param_00,param_01)
{
	if(!isdefined(self.var_2F39) || !self.var_2F39)
	{
		return 0;
	}

	if(isdefined(self.var_2303.var_2F3A) && self.var_2303.var_2F3A)
	{
		return 0;
	}

	if(!isalive(self))
	{
		return 0;
	}

	if(lib_0A1B::func_2938())
	{
		return 0;
	}

	if(isdefined(self.var_1198.var_3141))
	{
		return 0;
	}

	if(isdefined(self.var_B55B))
	{
		return 0;
	}

	return 1;
}

//Function Number: 28
func_2325(param_00,param_01,param_02)
{
	var_03 = 1;
	var_04 = param_01.var_D773;
	if(!isdefined(var_04))
	{
		var_04 = "powerdown_default";
	}

	func_2388(param_00,param_02,param_01,param_01.var_116FB);
	func_238A(param_00,var_04,var_03,undefined,undefined,param_01.var_D772);
}

//Function Number: 29
func_2354(param_00)
{
	foreach(var_02 in self.var_164D)
	{
		if(var_02.var_4BC0 == param_00)
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 30
func_232B(param_00,param_01)
{
	if(!isdefined(self.var_1198.var_232D[param_00]) || self.var_1198.var_232D[param_00].size == 0)
	{
		return 0;
	}

	foreach(var_04, var_03 in self.var_1198.var_232D[param_00])
	{
		if(var_04 == param_01)
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 31
func_68B0(param_00,param_01,param_02,param_03)
{
	return func_232B(param_01,param_03);
}

//Function Number: 32
func_666F(param_00,param_01,param_02,param_03)
{
	return func_232A(param_01,param_03);
}

//Function Number: 33
func_2310(param_00,param_01,param_02)
{
	var_03 = level.var_2303[param_00];
	var_04 = level.var_2303[param_00].var_10E2F[param_01];
	foreach(var_06 in var_04.var_1267B)
	{
		var_07 = var_06.var_11A1A;
		var_08 = self [[ var_06.var_71D1 ]](param_00,param_01,var_07,var_06.var_100B1);
		if(var_08)
		{
			var_09 = level.var_2303[param_00].var_10E2F[var_06.var_11A1A];
			var_0A = var_06.var_2B93;
			if(!isdefined(var_0A))
			{
				var_0A = 0.2;
			}

			if(isdefined(var_09.var_C94B) && var_09.var_C94B)
			{
				var_0B = func_2310(param_00,var_07,1);
				var_07 = var_0B[0];
				var_0A = var_0B[1];
			}

			if(isdefined(var_07))
			{
				if(!param_02)
				{
					func_2388(param_00,param_01,var_04,var_04.var_116FB);
					func_238A(param_00,var_07,var_0A);
				}

				return [var_07,var_0A];
			}
		}
	}

	return [undefined,undefined];
}

//Function Number: 34
func_237C(param_00,param_01)
{
	foreach(var_0A, var_03 in self.var_164D)
	{
		var_04 = var_03.var_4BC0;
		var_05 = level.var_2303[var_0A].var_10E2F[var_04];
		var_06 = level.var_2303[var_0A].var_10E2F[param_00];
		if(!isdefined(var_06))
		{
			continue;
		}

		var_07 = param_00;
		if(isdefined(var_06.var_C94B) && var_06.var_C94B)
		{
			var_08 = func_2310(var_0A,param_00,1);
			var_07 = var_08[0];
			var_09 = var_08[1];
			if(!isdefined(var_07))
			{
				continue;
			}
		}

		func_2388(var_0A,var_04,var_05,var_05.var_116FB);
		func_238A(var_0A,var_07,0.2,undefined,undefined,param_01);
	}
}

//Function Number: 35
func_2389()
{
	var_00 = self.var_164D[self.var_238F].var_4BC0;
	var_01 = level.var_2303[self.var_238F].var_10E2F[var_00];
	if(isdefined(self.var_7194))
	{
		if(self [[ self.var_7194 ]](self.var_238F,var_01))
		{
			func_231E(self.var_238F,var_01,var_00);
			return;
		}
	}

	if(func_2383(self.var_238F,var_01))
	{
		func_2325(self.var_238F,var_01,var_00);
		return;
	}

	var_03 = 0;
	foreach(var_09, var_05 in self.var_164D)
	{
		var_00 = var_05.var_4BC0;
		var_06 = func_2310(var_09,var_00,0);
		var_07 = var_06[0];
		var_08 = var_06[1];
		if(isdefined(var_07))
		{
			var_03 = 1;
		}

		if(var_03)
		{
			return;
		}
	}
}

//Function Number: 36
func_6A18(param_00,param_01,param_02,param_03)
{
	if(weaponclass(self.var_394) == "pistol")
	{
		if(weaponclass(self.var_D8E1) != "mg" && weaponclass(self.var_D8E1) != "rocketlauncher" && weaponclass(self.var_D8E1) != "pistol")
		{
			return 0;
		}
	}

	return func_BCE7(param_00,param_01,param_02,param_03);
}

//Function Number: 37
func_BCE7(param_00,param_01,param_02,param_03)
{
	if(isdefined(param_03) && func_233C() != param_03)
	{
		return 0;
	}

	return lib_0A1B::func_2955() && distancesquared(self.var_233,self.origin) > 4;
}

//Function Number: 38
func_C17F(param_00,param_01,param_02,param_03)
{
	return !func_BCE7(param_00,param_01,param_02,param_03);
}

//Function Number: 39
func_BCE8(param_00,param_01,param_02,param_03)
{
	if(isdefined(param_03))
	{
		var_04 = self [[ self.var_71A6 ]]();
		if(var_04 != param_03)
		{
			return 0;
		}
	}

	return func_BCE7(param_00,param_01,param_02,undefined);
}

//Function Number: 40
func_9E41(param_00,param_01,param_02,param_03)
{
	var_04 = undefined;
	if(isarray(param_03))
	{
		var_04 = param_03[0];
	}
	else
	{
		var_04 = param_03;
	}

	if(lib_0A1B::func_2941() != var_04)
	{
		return 0;
	}

	var_05 = undefined;
	if(isarray(param_03) && isdefined(param_03[1]))
	{
		var_05 = param_03[1];
	}

	return func_BCE7(param_00,param_01,param_02,var_05);
}

//Function Number: 41
func_233C()
{
	if(func_2353())
	{
		return "frantic";
	}
	else if(lib_0A1B::func_293B())
	{
		return "combat";
	}
	else if(isdefined(self.var_51E3) && self.var_51E3 == "cqb" && !isdefined(self.var_15F))
	{
		return "cqb";
	}

	return self.var_1198.var_BD23;
}

//Function Number: 42
func_238C()
{
	if(!isdefined(self.var_233) || distancesquared(self.origin,self.var_233) > 4096)
	{
		self.var_2303.var_7360 = lib_0A1B::func_293B();
	}
}

//Function Number: 43
func_2353()
{
	return self.var_2303.var_7360;
}

//Function Number: 44
func_2352()
{
	return isdefined(self.var_2303.var_4879);
}

//Function Number: 45
func_2379(param_00)
{
	self.var_2303.var_4879 = param_00;
}

//Function Number: 46
func_237A(param_00,param_01,param_02)
{
	self.var_2303.var_1FC5[param_00][param_01] = param_02;
}

//Function Number: 47
func_2316(param_00,param_01)
{
	if(func_234A(param_00,param_01))
	{
		self.var_2303.var_1FC5[param_00][param_01] = undefined;
	}
}

//Function Number: 48
func_234A(param_00,param_01)
{
	return isdefined(self.var_2303.var_1FC5[param_00]) && isdefined(self.var_2303.var_1FC5[param_00][param_01]);
}

//Function Number: 49
func_233D(param_00,param_01)
{
	return self.var_2303.var_1FC5[param_00][param_01];
}

//Function Number: 50
func_233A(param_00)
{
	var_01 = self.var_164D[param_00];
	return var_01.var_4BC0;
}

//Function Number: 51
func_2346(param_00,param_01)
{
	return self [[ self.var_7192 ]](param_00,param_01);
}

//Function Number: 52
func_2358(param_00,param_01)
{
	return self [[ self.var_7193 ]](param_00,param_01);
}

//Function Number: 53
func_2334(param_00,param_01,param_02)
{
	return self [[ self.var_7190 ]](param_00,param_01,param_02);
}

//Function Number: 54
func_235C(param_00,param_01,param_02,param_03)
{
	var_04 = "";
	if(isdefined(param_03))
	{
		var_04 = param_03;
	}

	if(param_02)
	{
		if(func_232C(param_01,"pass_left"))
		{
			var_05 = var_04 + "left";
		}
		else if(func_232C(param_02,"pass_right"))
		{
			var_05 = var_05 + "right";
		}
		else if(self.var_2303.var_7257.var_7254 == "right")
		{
			var_05 = var_05 + "right";
		}
		else
		{
			var_05 = var_05 + "left";
		}
	}
	else
	{
		var_05 = var_05;
	}

	if(func_2346(param_01,var_05 + param_00))
	{
		return func_2358(param_01,var_05 + param_00);
	}

	if(var_04 != var_05 && func_2346(param_01,var_04 + param_00))
	{
		return func_2358(param_01,var_04 + param_00);
	}

	return undefined;
}

//Function Number: 55
func_237B(param_00)
{
	if(getdvarint("ai_iw7",0) == 1)
	{
		self.var_BCD6 = param_00;
		return;
	}

	self.var_BCD6 = param_00;
}

//Function Number: 56
func_2340()
{
	return self.var_BCD6;
}

//Function Number: 57
func_231D(param_00,param_01,param_02,param_03)
{
	var_04 = level.var_2303[param_00].var_10E2F[param_02];
	self.var_2303.var_DCC7 = undefined;
	var_05 = 0;
	for(var_06 = 0;var_06 < var_04.var_1267B.size;var_06++)
	{
		var_07 = var_04.var_1267B[var_06].var_100B1;
		var_08 = var_07[1];
		for(var_09 = var_06 - 1;var_09 >= 0;var_09--)
		{
		}

		var_0A = 1;
		if(var_07.size > 2)
		{
			var_0A = var_07[3];
		}

		var_05 = var_05 + var_0A;
	}

	var_0B = randomfloat(var_05);
	var_0C = undefined;
	for(var_06 = 0;var_06 < var_04.var_1267B.size;var_06++)
	{
		var_0D = var_04.var_1267B[var_06];
		var_07 = var_0D.var_100B1;
		var_0C = var_07[1];
		var_0A = 1;
		if(var_07.size > 2)
		{
			var_0A = var_07[3];
		}

		if(var_0B < var_0A)
		{
			break;
		}
		else
		{
			var_0B = var_0B - var_0A;
		}
	}

	self.var_2303.var_DCC7 = param_00 + "_" + param_02 + "_" + var_0C;
	return 1;
}

//Function Number: 58
func_230C(param_00,param_01,param_02,param_03)
{
	var_04 = param_00 + "_" + param_01 + "_" + param_03[1];
	return var_04 == self.var_2303.var_DCC7;
}

//Function Number: 59
func_233B(param_00)
{
	return self.var_164D[param_00].var_4BC0;
}