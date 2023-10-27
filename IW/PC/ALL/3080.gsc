/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 3080.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 93
 * Decompile Time: 38 ms
 * Timestamp: 10/27/2023 12:26:06 AM
*******************************************************************/

//Function Number: 1
func_7FD3()
{
	if(isdefined(self.var_10AB7) && self.var_10AB7)
	{
		return "sprint";
	}

	if(isdefined(self.var_527B))
	{
		return self.var_527B;
	}

	return lib_0A02::func_75();
}

//Function Number: 2
func_12E90(param_00)
{
	if(!isalive(self))
	{
		return level.var_6AD5;
	}

	lib_0A1B::func_2968(func_7FD3());
	return level.var_111AE;
}

//Function Number: 3
func_9D5B(param_00)
{
	if(self.var_290A)
	{
		return level.var_111AE;
	}

	return level.var_6AD5;
}

//Function Number: 4
func_3596()
{
	return ["left","right"];
}

//Function Number: 5
func_351D(param_00,param_01)
{
	if(!isdefined(param_01))
	{
		param_01 = 1;
	}

	self.var_3135.var_13C83[param_00] = param_01;
}

//Function Number: 6
func_357A()
{
	var_00 = [];
	var_01 = func_3596();
	foreach(var_03 in var_01)
	{
		if(func_8C3C(var_03))
		{
			var_00[var_00.size] = var_03;
		}
	}

	return var_00;
}

//Function Number: 7
func_357C()
{
	var_00 = [];
	var_01 = func_3596();
	foreach(var_03 in var_01)
	{
		if(func_8C3C(var_03) && func_9F5B(var_03))
		{
			var_00[var_00.size] = var_03;
		}
	}

	return var_00;
}

//Function Number: 8
func_357D()
{
	var_00 = [];
	var_01 = func_3596();
	foreach(var_03 in var_01)
	{
		if(func_8C3C(var_03) && func_9F5B(var_03))
		{
			var_04 = self.var_1198.var_FECD.var_13CC3[var_03];
			if(isdefined(var_04) && isdefined(var_04.var_3124) && var_04.var_3124 && isdefined(var_04.var_2AB9) && var_04.var_2AB9)
			{
				var_00[var_00.size] = var_03;
			}
		}
	}

	return var_00;
}

//Function Number: 9
func_8C3C(param_00)
{
	return isdefined(self.var_13CC3[param_00]);
}

//Function Number: 10
func_9F5B(param_00)
{
	if(!self.var_3135.var_13C83[param_00])
	{
		return 0;
	}

	return self.var_13C83[param_00];
}

//Function Number: 11
func_B2AB(param_00,param_01)
{
	var_02 = spawnstruct();
	var_02.var_10E19 = 0;
	var_02.var_1158D = param_01;
	if(self.var_13CC3[param_00] == "minigun")
	{
		var_02.var_71A2 = ::func_FEE5;
		var_02.var_DCE8 = 100;
	}
	else
	{
		var_02.var_71A2 = ::func_FEE9;
		var_02.var_DCE8 = 250;
		if(!isdefined(var_02.var_C241))
		{
			var_02.var_C241 = randomintrange(1,3);
		}
	}

	var_02.var_29A9 = 1;
	var_02.var_29A1 = 1;
	var_02.var_3124 = 1;
	var_02.var_2AB9 = 1;
	var_02.var_312A = 1;
	var_02.var_3139 = 0;
	return var_02;
}

//Function Number: 12
func_97EB(param_00)
{
	var_01 = spawnstruct();
	var_01.var_11590 = [];
	var_02 = func_357A();
	foreach(var_04 in var_02)
	{
		var_05 = func_B2AB(var_04,undefined);
		var_01.var_13CC3[var_04] = var_05;
	}

	var_01.var_A98F = gettime();
	var_01.var_A993 = gettime();
	self.var_1198.var_FECD = var_01;
	self.var_1D0 = 1024;
	if(!isdefined(self.var_3135.var_AA2E))
	{
		self.var_3135.var_AA2E = 0;
	}

	return level.var_111AE;
}

//Function Number: 13
func_40E9(param_00)
{
	if(isdefined(self.var_1198.var_FECD) && isdefined(self.var_1198.var_FECD.var_13CC3) && !isdefined(self.var_EF6D))
	{
		var_01 = func_3596();
		foreach(var_03 in var_01)
		{
			self.var_1198.var_FECD.var_13CC3[var_03] = undefined;
		}

		self.var_1198.var_FECD = undefined;
	}

	return level.var_111AE;
}

//Function Number: 14
func_12E77(param_00)
{
	if(isdefined(self.var_233))
	{
		self.var_3135.var_AA2E = gettime();
	}

	return level.var_111AE;
}

//Function Number: 15
func_FB1E(param_00,param_01)
{
	if(!isdefined(self.var_1198.var_FECD))
	{
		return level.var_6AD5;
	}

	self.var_1198.var_FECD.var_12F1C = param_01;
	return level.var_111AE;
}

//Function Number: 16
func_7E30(param_00)
{
	if(!isdefined(self.var_1198.var_FECD))
	{
		return undefined;
	}

	var_01 = gettime();
	var_02 = undefined;
	var_03 = 999999999;
	foreach(var_05 in func_357A())
	{
		var_06 = self.var_1198.var_FECD.var_13CC3[var_05];
		if(isdefined(var_06.var_65D3))
		{
			if(var_06.var_3124 || isdefined(param_00) && var_01 - var_06.var_A9AB <= param_00)
			{
				var_07 = distancesquared(self.origin,var_06.var_65D3.origin);
				if(var_07 < var_03)
				{
					var_03 = var_07;
					var_02 = var_06.var_65D3;
				}
			}

			continue;
		}

		if(isdefined(var_06.var_EF76) && var_06.var_EF76.size > 0)
		{
			foreach(var_09 in var_06.var_EF76)
			{
				if(isdefined(var_09))
				{
					var_07 = distancesquared(self.origin,var_09.origin);
					if(var_07 < var_03)
					{
						var_03 = var_07;
						var_02 = var_09;
					}
				}
			}
		}
	}

	return var_02;
}

//Function Number: 17
func_FE5F(param_00,param_01)
{
	self [[ param_00.var_71A2 ]](param_00,param_01);
}

//Function Number: 18
func_390B(param_00)
{
	var_01 = self.var_1198.var_FECD;
	var_02 = var_01.var_13CC3[param_00];
	if(!isdefined(var_02))
	{
		return 0;
	}

	var_03 = undefined;
	if(isdefined(var_02.var_EF76) && var_02.var_EF76.size > 0)
	{
		var_03 = var_02.var_EF76[0];
	}
	else if(isdefined(var_02.var_65D3))
	{
		var_03 = var_02.var_65D3;
	}

	if(isdefined(var_03))
	{
		return self method_805F(var_03);
	}

	return 1;
}

//Function Number: 19
func_8C27(param_00,param_01)
{
	if(!isdefined(param_01))
	{
		return 1;
	}

	var_02 = self.var_1198.var_FECD;
	var_03 = var_02.var_13CC3[param_00];
	if(!isdefined(var_03))
	{
		return 0;
	}

	var_04 = undefined;
	if(self.var_13CC3[param_00] == "minigun")
	{
		var_04 = lib_0C41::func_3587(param_00);
	}
	else if(self.var_13CC3[param_00] == "rocket")
	{
		var_04 = lib_0C41::func_3593(param_00,"top");
	}

	var_05 = 256;
	var_06 = param_01 - var_04;
	var_07 = length(var_06);
	if(var_07 > var_05)
	{
		var_08 = var_04 + var_06 / var_07 * 256;
	}
	else
	{
		var_08 = var_02;
	}

	return sighttracepassed(var_04,var_08,0,self);
}

//Function Number: 20
func_8BEC(param_00)
{
	if(!isdefined(param_00))
	{
		return 0;
	}

	if(!isdefined(param_00.var_65D3) && !isdefined(param_00.var_EF76) && !isdefined(param_00.var_D699))
	{
		return 0;
	}

	return 1;
}

//Function Number: 21
func_10076(param_00)
{
	if(isdefined(self.var_595D))
	{
		return level.var_6AD5;
	}

	if(!isdefined(self.var_10C))
	{
		return level.var_6AD5;
	}

	return level.var_111AE;
}

//Function Number: 22
func_FE7B(param_00,param_01)
{
	var_02 = self.var_1198.var_FECD;
	if(!isdefined(var_02.var_13CC3[param_00]))
	{
		return;
	}

	if(!isdefined(param_01) || !isdefined(var_02.var_13CC3[param_00].var_65D3) || var_02.var_13CC3[param_00].var_65D3 != param_01)
	{
		var_03 = func_B2AB(param_00,var_02.var_13CC3[param_00].var_1158D);
		var_02.var_13CC3[param_00].var_10E19 = -1;
		var_03.var_C249 = var_02.var_13CC3[param_00].var_C249;
		var_02.var_13CC3[param_00] = var_03;
		var_04 = gettime();
		var_03.var_656E = var_04;
		if(isdefined(param_01))
		{
			var_03.var_A97C = param_01.origin;
			var_03.var_A97D = var_04;
		}
	}

	var_05 = var_02.var_13CC3[param_00];
	var_05.var_65D3 = param_01;
}

//Function Number: 23
func_FE8B(param_00)
{
	var_01 = func_3596();
	var_02 = undefined;
	foreach(var_04 in var_01)
	{
		if(self.var_1198.var_FECD.var_13CC3[var_04] == param_00)
		{
			var_02 = var_04;
			break;
		}
	}

	var_06 = gettime();
	if(isdefined(param_00.var_65D3))
	{
		param_00.var_29A1 = self method_805F(param_00.var_65D3);
		param_00.var_3124 = self method_8296(param_00.var_65D3,1);
		if(issentient(param_00.var_65D3))
		{
			param_00.var_A9AB = self lastknowntime(param_00.var_65D3);
		}
		else
		{
			param_00.var_A9AB = var_06;
		}

		var_07 = 1024;
		var_08 = 500;
		if(var_06 > param_00.var_A97D + var_08)
		{
			if(distancesquared(param_00.var_65D3.origin,param_00.var_A97C) > var_07)
			{
				param_00.var_3139 = 0;
			}
			else
			{
				param_00.var_3139 = 1;
			}

			param_00.var_A97C = param_00.var_65D3.origin;
			param_00.var_A97D = var_06;
		}
	}
	else
	{
		param_00.var_29A1 = 1;
		param_00.var_3124 = 1;
		param_00.var_A9AB = var_06;
	}

	var_09 = self.var_13CC3[var_02] == "rocket";
	param_00.var_1A46 = func_FE67(param_00,var_09);
	param_00.var_1A47 = var_06;
	param_00.var_312A = param_00.var_3124;
	param_00.var_2AB9 = func_8C27(var_02,param_00.var_1A46);
}

//Function Number: 24
func_FE8C(param_00)
{
	var_01 = self.var_1198.var_FECD;
	if(isdefined(self.var_7212) && gettime() < self.var_7212)
	{
		if(func_9F5B("left"))
		{
			var_02 = level.player;
		}
		else
		{
			var_02 = undefined;
		}

		if(func_9F5B("right"))
		{
			var_03 = level.player;
		}
		else
		{
			var_03 = undefined;
		}
	}
	else
	{
		var_02 = self.var_10C;
		var_03 = self.var_10C;
		if(self.var_27F7)
		{
			if(func_8C3C("left") && func_9F5B("left") && func_8C3C("right") && func_9F5B("right"))
			{
				var_04 = self method_848B();
				if(isdefined(var_04) && var_04.size > 0)
				{
					var_05 = var_04[0];
					var_06 = self.var_10C.origin - self.origin;
					var_07 = var_05.origin - self.origin;
					var_08 = vectornormalize(var_07);
					var_09 = self.var_10C.origin + var_05.origin * 0.5;
					var_0A = vectornormalize(var_09 - self.origin);
					var_0B = vectortoangles(var_0A);
					var_0C = anglestoforward(self.angles);
					if(vectordot(var_0A,var_0C) > 0)
					{
						var_0D = anglestoright(var_0B);
						if(vectordot(var_08,var_0A) > 0)
						{
							var_0E = vectordot(var_0D,var_06);
							var_0F = vectordot(var_0D,var_07);
							if(var_0F > var_0E)
							{
								var_03 = var_05;
							}
							else
							{
								var_02 = var_05;
							}
						}
					}
				}
			}
		}

		if(!func_9F5B("left"))
		{
			var_02 = undefined;
		}
		else if(isdefined(var_01.var_13CC3["left"]) && isdefined(var_01.var_13CC3["left"].var_313A) && isdefined(var_01.var_13CC3["left"].var_65D3))
		{
			var_02 = var_01.var_13CC3["left"].var_65D3;
		}

		if(!func_9F5B("right"))
		{
			var_03 = undefined;
		}
		else if(isdefined(var_01.var_13CC3["right"]) && isdefined(var_01.var_13CC3["right"].var_313A) && isdefined(var_01.var_13CC3["right"].var_65D3))
		{
			var_03 = var_01.var_13CC3["right"].var_65D3;
		}
	}

	func_FE7B("left",var_02);
	func_FE7B("right",var_03);
	func_FE8B(var_01.var_13CC3["left"]);
	func_FE8B(var_01.var_13CC3["right"]);
	return level.var_111AE;
}

//Function Number: 25
func_FE7A(param_00)
{
	if(isdefined(param_00))
	{
		self.var_1198.var_FECD.var_BFB6 = param_00;
		return;
	}

	self.var_1198.var_FECD.var_BFB6 = gettime() + randomintrange(1000,1500);
}

//Function Number: 26
func_3873(param_00)
{
	setdvarifuninitialized("enable_c12_berserk",0);
	if(!getdvarint("enable_c12_berserk"))
	{
		return 0;
	}

	if(!isdefined(param_00.var_65D3))
	{
		return 0;
	}

	var_01 = self.var_1198.var_FECD;
	var_02 = ["left","right"];
	var_03 = undefined;
	foreach(var_05 in var_02)
	{
		if(var_01.var_13CC3[var_05] == param_00)
		{
			if(self.var_13CC3[var_05] != "minigun")
			{
				return 0;
			}

			var_03 = var_05;
			break;
		}
	}

	var_07 = "left";
	if(var_07 == var_03)
	{
		var_07 = "right";
	}

	if(!lib_0A1B::func_9ED3(var_07 + "_arm"))
	{
		return 0;
	}

	var_08 = gettime();
	if(!isdefined(var_01.var_BF71))
	{
		var_01.var_BF71 = var_08;
	}

	return var_08 >= var_01.var_BF71;
}

//Function Number: 27
func_FE79()
{
	var_00 = self.var_1198.var_FECD;
	if(isdefined(var_00))
	{
		var_00.var_BF71 = gettime() + randomintrange(10000,20000);
	}
}

//Function Number: 28
func_FE78(param_00)
{
	param_00.var_2763 = gettime() + 2000;
}

//Function Number: 29
func_FE63()
{
	var_00 = func_357A();
	foreach(var_02 in var_00)
	{
		if(self.var_13CC3[var_02] == "minigun")
		{
			return var_02;
		}
	}

	return undefined;
}

//Function Number: 30
func_FE65()
{
	var_00 = func_357A();
	foreach(var_02 in var_00)
	{
		if(self.var_13CC3[var_02] == "rocket")
		{
			return var_02;
		}
	}

	return undefined;
}

//Function Number: 31
func_FE68(param_00)
{
	if(isdefined(param_00.var_12BA4) && param_00.var_12BA4 == "c12")
	{
		return 1000;
	}

	if(scripts\sp\_vehicle::func_9FEF(param_00))
	{
		return 500;
	}

	return 10;
}

//Function Number: 32
func_FE62()
{
	var_00 = self.var_1198.var_FECD;
	var_01 = 0;
	var_02 = undefined;
	var_03 = func_357C();
	foreach(var_05 in var_03)
	{
		var_06 = var_00.var_13CC3[var_05];
		if(isdefined(var_06) && isdefined(var_06.var_65D3))
		{
			var_07 = func_FE68(var_06.var_65D3);
			if(var_07 > var_01)
			{
				var_02 = var_05;
				var_01 = var_07;
			}
		}
	}

	return var_02;
}

//Function Number: 33
func_41EC(param_00)
{
	return level.var_6AD5;
}

//Function Number: 34
func_FE8E(param_00)
{
	func_FE8C(param_00);
	var_01 = func_FE8D(param_00);
	func_FE8A(var_01);
	return level.var_111AE;
}

//Function Number: 35
func_FE8D(param_00)
{
	var_01 = self.var_1198.var_FECD;
	if(isdefined(self.var_9DD2) && self.var_9DD2)
	{
		return func_FE63();
	}

	if(isdefined(var_01.var_1675) && func_9F5B(var_01.var_1675))
	{
		var_02 = var_01.var_13CC3[var_01.var_1675];
		if(var_02.var_10E19 != 0)
		{
			return var_01.var_1675;
		}
	}

	var_03 = func_357D();
	if(var_03.size == 0)
	{
		return undefined;
	}

	var_04 = var_03;
	foreach(var_06 in var_03)
	{
		var_02 = var_01.var_13CC3[var_06];
		if(self.var_13CC3[var_06] == "rocket")
		{
			var_07 = var_02.var_65D3;
			if(isdefined(var_07))
			{
				if(distancesquared(var_07.origin,self.origin) < -25536)
				{
					var_04 = scripts\common\utility::func_22A9(var_04,var_06);
				}
				else if(!var_02.var_3139)
				{
					var_04 = scripts\common\utility::func_22A9(var_04,var_06);
				}
			}

			continue;
		}

		if(isdefined(var_01.var_1675) && var_01.var_1675 == var_06)
		{
			if(var_02.var_3124 && var_01.var_C24A >= 3)
			{
				var_04 = scripts\common\utility::func_22A9(var_04,var_06);
			}
		}
	}

	if(var_04.size == 0)
	{
		var_03 = func_357D();
		if(var_03.size > 0)
		{
			return var_03[randomint(var_03.size)];
		}

		return;
	}

	if(var_04.size == 1)
	{
		return var_04[0];
	}

	return var_04[randomint(var_04.size)];
}

//Function Number: 36
func_FE8A(param_00)
{
	var_01 = self.var_1198.var_FECD;
	var_02 = func_357A();
	foreach(var_04 in var_02)
	{
		if(!func_9F5B(var_04) && isdefined(var_01.var_13CC3[var_04]))
		{
			func_FE5F(var_01.var_13CC3[var_04],0);
		}
	}

	if(!isdefined(var_01.var_1675))
	{
		func_FE7A(gettime());
	}

	var_06 = isdefined(param_00);
	if(var_06 && isdefined(var_01.var_1675) && param_00 == var_01.var_1675)
	{
		if(var_01.var_13CC3[param_00].var_29A9 && !var_01.var_13CC3[param_00].var_29A1)
		{
			func_FE5F(var_01.var_13CC3[param_00],0);
		}
		else
		{
			if(var_01.var_13CC3[param_00].var_10E19 == 0)
			{
				if(!isdefined(var_01.var_BFB6))
				{
					func_FE7A();
				}

				if(gettime() > var_01.var_BFB6)
				{
					var_01.var_BFB6 = undefined;
					var_01.var_C24A++;
					func_FE5F(var_01.var_13CC3[param_00],1);
				}
			}

			return;
		}
	}

	var_02 = func_357A();
	foreach(var_08 in var_02)
	{
		if(!var_06 || var_08 != param_00)
		{
			var_09 = var_01.var_13CC3[var_08];
			func_FE5F(var_09,0);
		}
	}

	var_01.var_1675 = param_00;
	var_01.var_C24A = 0;
	if(var_06 && var_01.var_13CC3[param_00].var_29A1)
	{
		if(!isdefined(var_01.var_BFB6))
		{
			func_FE7A();
		}

		if(gettime() > var_01.var_BFB6)
		{
			var_09 = var_01.var_13CC3[param_00];
			var_01.var_C24A = 1;
			var_01.var_BFB6 = undefined;
			func_FE5F(var_09,1);
		}
	}
}

//Function Number: 37
func_10079(param_00)
{
	var_01 = self.var_1198.var_FECD.var_13CC3[param_00];
	if(!isdefined(var_01))
	{
		return 0;
	}

	return var_01.var_10E19 == 2 || var_01.var_10E19 == 3;
}

//Function Number: 38
func_9F7B(param_00)
{
	var_01 = self.var_1198.var_FECD.var_13CC3[param_00];
	if(!isdefined(var_01))
	{
		return 0;
	}

	return var_01.var_10E19 == 3;
}

//Function Number: 39
func_1391C(param_00)
{
	return param_00.var_10E19 == 3;
}

//Function Number: 40
func_A004(param_00)
{
	var_01 = self.var_1198.var_FECD.var_13CC3[param_00];
	if(!isdefined(var_01))
	{
		return 0;
	}

	return var_01.var_10E19 == 4;
}

//Function Number: 41
func_A005(param_00)
{
	var_01 = self.var_1198.var_FECD.var_12F1C;
	var_02 = self.var_1198.var_FECD.var_13CC3[var_01];
	if(!isdefined(var_02))
	{
		return level.var_6AD5;
	}

	if(var_02.var_10E19 == 0)
	{
		return level.var_6AD5;
	}

	return level.var_111AE;
}

//Function Number: 42
func_A006(param_00,param_01)
{
	var_02 = self.var_1198.var_FECD.var_12F1C;
	if(func_A007(var_02,param_01))
	{
		return level.var_111AE;
	}

	return level.var_6AD5;
}

//Function Number: 43
func_A007(param_00,param_01)
{
	if(!func_8C3C(param_00))
	{
		return 0;
	}

	if(self.var_13CC3[param_00] == param_01)
	{
		return 1;
	}

	return 0;
}

//Function Number: 44
func_FE66(param_00)
{
	if(!func_8C3C(param_00))
	{
		return undefined;
	}

	var_01 = self.var_1198.var_FECD;
	var_02 = var_01.var_13CC3[param_00];
	var_03 = self.var_13CC3[param_00] == "rocket";
	return func_FE67(var_02,var_03);
}

//Function Number: 45
func_FE67(param_00,param_01)
{
	if(param_00.var_10E19 == 4)
	{
		return self.origin + anglestoforward(self.angles) * 192;
	}

	if(isdefined(param_00.var_E5E0))
	{
		return param_00.var_E5E0;
	}

	if(isdefined(param_00.var_EF76))
	{
		var_02 = (0,0,0);
		var_03 = 0;
		foreach(var_07, var_05 in param_00.var_EF76)
		{
			if(isdefined(var_05))
			{
				if(param_01)
				{
					var_06 = var_05.origin;
				}
				else
				{
					var_06 = var_07 method_815B();
				}

				var_02 = var_02 + var_06;
				var_03++;
			}
		}

		if(var_03 == 0)
		{
			return undefined;
		}

		var_08 = var_02 / var_03;
		return var_08 + func_FE69(param_00,var_08);
	}

	if(isdefined(var_07.var_65D3))
	{
		var_09 = func_3596();
		var_0A = undefined;
		foreach(var_0C in var_09)
		{
			if(self.var_1198.var_FECD.var_13CC3[var_0C] == var_07)
			{
				var_0A = var_0C;
				break;
			}
		}

		if(self method_805F(var_07.var_65D3))
		{
			if(var_08)
			{
				return var_07.var_65D3.origin;
			}

			var_0E = var_07.var_65D3 method_815B();
			return var_0E + func_FE69(var_07,var_0E);
		}
		else
		{
			var_0E = self lastknownpos(var_08.var_65D3) + (0,0,60);
			return var_0E + func_FE69(var_07,var_0E);
		}
	}

	if(isdefined(var_08.var_D699))
	{
		return var_08.var_D699 + func_FE69(var_08,var_08.var_D699);
	}

	return undefined;
}

//Function Number: 46
func_FE69(param_00,param_01)
{
	if(!func_1391C(param_00))
	{
		return (0,0,0);
	}

	var_02 = gettime() - param_00.var_110D8 / 1000;
	var_03 = int(var_02 * 256);
	var_04 = var_03 % 256;
	if(var_04 > 128)
	{
		var_04 = 256 - var_04;
	}

	if(int(var_03 / 256) % 2)
	{
		var_04 = var_04 * -1;
	}

	return rotatevector((0,var_04,0),vectortoangles(self.origin - param_01));
}

//Function Number: 47
func_FEE6(param_00)
{
	var_01 = self.var_1198.var_FECD;
	var_02 = self.var_1198.var_FECD.var_12F1C;
	var_01.var_11590[param_00] = var_02;
	var_03 = var_01.var_13CC3[var_02];
	var_03.var_1158D = param_00;
	func_FEE5(var_03,1);
}

//Function Number: 48
func_FEE5(param_00,param_01)
{
	var_02 = -999;
	var_03 = param_00.var_10E19;
	if(!isdefined(var_03))
	{
		var_03 = var_02;
	}

	if(var_03 == param_01)
	{
		return;
	}

	param_00.var_10E19 = param_01;
	switch(param_01)
	{
		case 0:
			break;

		case 1:
			if(var_03 == 0)
			{
				param_00.var_DCE8 = 100;
				param_00.var_C21B = randomintrange(2,4);
				param_00.var_BF72 = gettime();
				param_00.var_927E = 0;
			}
			else if(var_03 == 2)
			{
				param_00.var_BF72 = gettime() + 1000;
			}
	
			func_FE78(param_00);
			break;

		case 2:
			param_00.var_927E++;
			param_00.var_32BC = gettime() + randomintrange(2000,4000);
			scripts\sp\_gameskill::func_F288();
			break;

		case 3:
			param_00.var_DCE8 = 33.33333;
			param_00.var_110D8 = gettime();
			param_00.var_32BC = gettime() + 12000;
			param_00.var_313A = 1;
			break;
	}
}

//Function Number: 49
func_FEE3(param_00)
{
	var_01 = self.var_1198.var_FECD;
	var_02 = var_01.var_12F1C;
	var_03 = var_01.var_13CC3[var_02];
	if(!func_8BEC(var_03))
	{
		func_FEE5(var_03,0);
		return level.var_111AE;
	}

	var_04 = gettime();
	if(var_04 > var_01.var_A993 + 30000)
	{
		func_128AE(var_02,var_03);
	}

	switch(var_03.var_10E19)
	{
		case 1:
			if(!isdefined(var_03.var_2763))
			{
				func_FE78(var_03);
			}
	
			if(var_04 > var_03.var_2763)
			{
				func_128AE(var_02,var_03);
				func_FEE5(var_03,0);
				return level.var_6AD5;
			}
	
			if(var_04 >= var_03.var_BF72 && func_9EA0(var_02,var_03.var_1A46))
			{
				var_05 = 1;
				if(var_03.var_29A9)
				{
					var_05 = func_390B(var_02);
				}
	
				if(var_05)
				{
					if(isdefined(self.var_3131))
					{
						func_FEE5(var_03,3);
					}
					else
					{
						func_FEE5(var_03,2);
					}
				}
			}
			break;

		case 2:
			if(var_04 >= var_03.var_32BC)
			{
				if(var_03.var_927E >= var_03.var_C21B)
				{
					func_FEE5(var_03,0);
					func_FE7A();
					return level.var_111AE;
				}
				else
				{
					func_FEE5(var_03,1);
				}
			}
			break;

		case 3:
			if(var_04 >= var_03.var_32BC)
			{
				func_FEE5(var_03,0);
				func_FE7A();
				return level.var_111AE;
			}
			break;

		case 0:
			return level.var_6AD5;
	}

	return level.var_E87A;
}

//Function Number: 50
func_FEE4(param_00)
{
	var_01 = self.var_1198.var_FECD;
	if(!isdefined(var_01))
	{
		return;
	}

	var_02 = var_01.var_11590[param_00];
	var_03 = var_01.var_13CC3[var_02];
	if(var_03.var_1158D == param_00)
	{
		func_FEE5(var_03,0);
	}
}

//Function Number: 51
func_FEE9(param_00,param_01)
{
	var_02 = param_00.var_10E19;
	if(var_02 == param_01)
	{
		return;
	}

	param_00.var_10E19 = param_01;
	if(param_01 == 1)
	{
		func_FE78(param_00);
	}

	if(param_01 == 2)
	{
		param_00.var_313A = 1;
		param_00.var_29A9 = 0;
		return;
	}

	param_00.var_313A = undefined;
	param_00.var_29A9 = 1;
}

//Function Number: 52
func_FEEA(param_00)
{
	var_01 = self.var_1198.var_FECD;
	var_02 = var_01.var_12F1C;
	var_01.var_11590[param_00] = var_02;
	var_03 = var_01.var_13CC3[var_02];
	var_03.var_1158D = param_00;
	var_03.var_10E19 = 1;
	if(isdefined(var_03.var_EF76))
	{
		var_03.var_C241 = var_03.var_EF76.size;
	}
	else
	{
		var_03.var_C241 = randomintrange(1,3);
	}

	var_03.var_DCE8 = 250;
	scripts\sp\_gameskill::func_F288();
	func_FE78(var_03);
}

//Function Number: 53
func_FEE7(param_00)
{
	var_01 = self.var_1198.var_FECD;
	var_02 = var_01.var_12F1C;
	var_03 = self.var_1198.var_FECD.var_13CC3[var_02];
	if(lib_0A1A::func_232A("rocket_shoot_complete",var_02))
	{
		func_FE7A();
		if(isdefined(var_03))
		{
			var_03.var_2720 = undefined;
		}

		return level.var_111AE;
	}

	var_04 = var_03.var_1A46;
	if(!isdefined(var_04))
	{
		return level.var_6AD5;
	}

	var_05 = gettime();
	if(var_05 > var_01.var_A993 + 30000)
	{
		func_128AE(var_02,var_03);
	}

	if(var_03.var_10E19 == 1)
	{
		if(!isdefined(var_03.var_2763))
		{
			func_FE78(var_03);
		}

		if(var_05 > var_03.var_2763)
		{
			func_128AE(var_02,var_03);
			func_FE5F(var_03,0);
			return level.var_6AD5;
		}
	}

	if(var_03.var_10E19 != 2)
	{
		if(distancesquared(self.origin,var_04) > 65536)
		{
			if(func_9F30(var_02,var_04))
			{
				var_06 = 1;
				if(var_03.var_29A9)
				{
					var_06 = var_03.var_2AB9;
				}

				if(var_06)
				{
					func_FE5F(var_03,2);
				}
			}
		}
	}

	return level.var_E87A;
}

//Function Number: 54
func_FEE8(param_00)
{
	var_01 = self.var_1198.var_FECD;
	if(!isdefined(var_01))
	{
		return;
	}

	var_02 = var_01.var_11590[param_00];
	if(!isdefined(var_02))
	{
		return;
	}

	var_03 = self.var_1198.var_FECD.var_13CC3[var_02];
	if(var_03.var_1158D == param_00)
	{
		var_03.var_10E19 = 0;
	}
}

//Function Number: 55
func_9F30(param_00,param_01)
{
	var_02 = lib_0C41::func_3593(param_00,"top");
	var_03 = lib_0C41::func_3592(param_00,"top");
	if(isdefined(self.var_E5C4))
	{
		var_04 = anglestoforward(var_03);
		var_04 = rotatevector(var_04,(self.var_E5C4,0,0));
		var_03 = vectortoangles(var_04);
	}

	var_05 = 15;
	var_06 = func_9FFA(var_02,var_03,param_01,var_05);
	if(var_06)
	{
		return 1;
	}

	if(isdefined(self.var_E5C4))
	{
		var_07 = lib_0C41::func_3628(param_00,"pitch","min");
		var_08 = lib_0C41::func_3628(param_00,"pitch","max");
		if(var_03[0] > var_07 - 3 || var_03[0] < var_08 + 3)
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 56
func_9EA0(param_00,param_01)
{
	var_02 = lib_0C41::func_3587(param_00);
	var_03 = lib_0C41::func_3585(param_00);
	var_04 = 15;
	return func_9FFA(var_02,var_03,param_01,var_04);
}

//Function Number: 57
func_9FFA(param_00,param_01,param_02,param_03)
{
	var_04 = vectornormalize(param_02 - param_00);
	var_05 = anglestoforward(param_01);
	var_06 = cos(param_03);
	return vectordot(var_04,var_05) >= var_06;
}

//Function Number: 58
func_8C23(param_00)
{
	if(isdefined(self.var_EF6D))
	{
		foreach(var_02 in self.var_EF6D)
		{
			var_03 = var_02.size;
			if(var_03 > 0)
			{
				for(var_04 = 0;var_04 < var_03;var_04++)
				{
					if(isdefined(var_02[var_04]))
					{
						return level.var_111AE;
					}
				}
			}
		}
	}

	return level.var_6AD5;
}

//Function Number: 59
func_FE90(param_00)
{
	var_01 = self.var_1198.var_FECD;
	var_02 = var_01.var_13CC3[param_00];
	func_FE8B(var_02);
	if(isdefined(var_01.var_BFB6))
	{
		if(gettime() < var_01.var_BFB6)
		{
			return;
		}
	}

	var_03 = 1;
	if(isdefined(var_02.var_EF76))
	{
		var_03 = !scripts\sp\_utility::func_2285(self.var_EF6D[param_00],var_02.var_EF76);
	}

	if(var_03)
	{
		var_04 = var_02.var_1158D;
		var_02.var_10E19 = -1;
		var_02 = func_B2AB(param_00,var_04);
		var_01.var_13CC3[param_00] = var_02;
	}

	var_02.var_EF76 = self.var_EF6D[param_00];
	var_02.var_EF77 = self.var_EF70[param_00];
	var_02.var_29A9 = self.var_EF6E[param_00];
	var_02.var_C241 = self.var_EF6D[param_00].size;
	if(!isdefined(var_02.var_656E))
	{
		var_02.var_656E = gettime();
	}

	func_FE8B(var_02);
	if(var_02.var_10E19 == 0)
	{
		func_FE5F(var_02,1);
	}
}

//Function Number: 60
func_FE8F(param_00)
{
	var_01 = self.var_1198.var_FECD;
	if(!isdefined(var_01))
	{
		func_97EB(undefined);
		var_01 = self.var_1198.var_FECD;
	}

	var_02 = func_357A();
	foreach(var_04 in var_02)
	{
		if(func_9F5B(var_04) && isdefined(self.var_EF6D[var_04]))
		{
			func_FE90(var_04);
			continue;
		}

		var_05 = self.var_1198.var_FECD.var_13CC3[var_04];
		if(isdefined(var_05))
		{
			func_FE5F(var_05,0);
		}
	}

	return level.var_111AE;
}

//Function Number: 61
func_F811(param_00)
{
	var_01 = getrandomnavpoint(self.origin,2048,self);
	self method_8481(var_01);
	self method_82EF((0,0,0));
	return level.var_111AE;
}

//Function Number: 62
func_1383A(param_00)
{
	if(isdefined(self.var_233))
	{
		return level.var_E87A;
	}

	self method_8484();
	return level.var_111AE;
}

//Function Number: 63
func_3906(param_00)
{
	var_01 = self.var_1198.var_FECD;
	var_02 = func_357C();
	foreach(var_04 in var_02)
	{
		var_05 = var_01.var_13CC3[var_04];
		if(isdefined(var_05))
		{
			if(isdefined(var_05.var_65D3))
			{
				if(self method_805F(var_05.var_65D3))
				{
					return level.var_111AE;
				}

				continue;
			}

			if(isdefined(var_05.var_EF76))
			{
				foreach(var_07 in var_05.var_EF76)
				{
					if(self method_805F(var_07))
					{
						return level.var_111AE;
					}
				}
			}
		}
	}

	return level.var_6AD5;
}

//Function Number: 64
func_8C25(param_00,param_01)
{
	var_02 = self.var_1198.var_FECD;
	var_03 = func_357C();
	foreach(var_05 in var_03)
	{
		var_06 = var_02.var_13CC3[var_05];
		if(isdefined(var_06))
		{
			if(isdefined(var_06.var_65D3))
			{
				if(self method_8296(var_06.var_65D3,param_01))
				{
					return level.var_111AE;
				}

				continue;
			}

			if(isdefined(var_06.var_EF76))
			{
				foreach(var_08 in var_06.var_EF76)
				{
					if(!function_02A6(var_06.var_65D3) || self method_8296(var_08,param_01))
					{
						return level.var_111AE;
					}
				}
			}
		}
	}

	return level.var_6AD5;
}

//Function Number: 65
func_2CD6(param_00)
{
	var_01 = 6000;
	var_02 = gettime();
	if(var_02 - self.var_3135.var_AA2E > var_01)
	{
		return level.var_111AE;
	}

	return level.var_6AD5;
}

//Function Number: 66
func_7FCB()
{
	var_00 = self.var_1198.var_FECD;
	var_01 = [];
	var_02 = func_357C();
	foreach(var_04 in var_02)
	{
		var_05 = var_00.var_13CC3[var_04];
		if(isdefined(var_05))
		{
			if(isdefined(var_05.var_65D3))
			{
				var_01[var_01.size] = var_05.var_65D3;
				continue;
			}

			if(isdefined(var_05.var_EF76))
			{
				foreach(var_07 in var_05.var_EF76)
				{
					var_01[var_01.size] = var_07;
				}
			}
		}
	}

	var_0A = undefined;
	var_0B = undefined;
	var_0C = 0;
	foreach(var_0E in var_01)
	{
		var_0F = self lastknowntime(var_0E);
		if(var_0F > var_0C)
		{
			var_0C = var_0F;
			var_0A = var_0E;
		}
	}

	return var_0A;
}

//Function Number: 67
func_B4EA(param_00)
{
	if(isdefined(self.var_233))
	{
		return level.var_6AD5;
	}

	if(self.script == "cover_arrival")
	{
		return level.var_6AD5;
	}

	if(gettime() - self.var_3135.var_AA2E < 1000)
	{
		return level.var_6AD5;
	}

	return level.var_111AE;
}

//Function Number: 68
func_80DC(param_00)
{
	if(isdefined(param_00))
	{
		var_01 = 24;
		if(!isdefined(self.var_DD25))
		{
			self.var_DD25 = 0;
		}

		var_02 = self lastknownpos(param_00);
		var_03 = 256 + self.var_DD25 * var_01;
		var_04 = getrandomnavpoints(var_02,var_03,1,self);
		if(!isdefined(var_04) || var_04.size == 0)
		{
			return undefined;
		}

		return var_04[0];
	}

	return undefined;
}

//Function Number: 69
func_4459(param_00,param_01,param_02)
{
	var_03 = distance2dsquared(param_02,param_00.origin);
	var_04 = distance2dsquared(param_02,param_01.origin);
	return var_03 < var_04;
}

//Function Number: 70
func_1043E(param_00,param_01)
{
	var_02 = param_01.origin;
	for(var_03 = 1;var_03 < param_00.size;var_03++)
	{
		var_04 = param_00[var_03];
		for(var_05 = var_03 - 1;var_05 >= 0;var_05--)
		{
			if(func_4459(param_00[var_05],var_04,var_02))
			{
				break;
			}

			param_00[var_05 + 1] = param_00[var_05];
		}

		param_00[var_05 + 1] = var_04;
	}

	return param_00;
}

//Function Number: 71
func_80DD(param_00)
{
	if(isdefined(param_00))
	{
		var_01 = param_00.var_205;
		if(!isdefined(var_01))
		{
			var_01 = getclosestnodeinsight(param_00.origin);
		}

		if(isdefined(var_01))
		{
			var_02 = getnodesinradius(self.origin,512,72,72);
			var_03 = [];
			var_04 = var_02.size;
			for(var_05 = 0;var_05 < var_04;var_05++)
			{
				var_06 = var_02[var_05];
				if(nodesvisible(var_06,var_01) && distance2dsquared(var_06.origin,param_00.origin) >= squared(256))
				{
					var_03[var_03.size] = var_06;
				}
			}

			if(var_03.size > 0)
			{
				var_07 = func_1043E(var_03,param_00);
				var_08 = var_07[0];
				var_09 = getclosestpointonnavmesh(var_08.origin,self);
				if(distance2dsquared(var_09,self.origin) > 16384)
				{
					return var_09;
				}
			}
		}
	}

	return undefined;
}

//Function Number: 72
func_F814(param_00)
{
	var_01 = func_7FCB();
	if(!self method_84BA() && !isdefined(var_01) || !self method_84BA(var_01.origin))
	{
		return level.var_6AD5;
	}

	if(isdefined(var_01))
	{
		var_02 = func_80DD(var_01);
		if(!isdefined(var_02))
		{
			var_02 = func_80DC(var_01);
		}

		if(isdefined(var_02))
		{
			self.var_6D = 128;
			self method_8481(var_02);
			self.var_1198.var_C974 = var_01;
			return level.var_111AE;
		}
	}

	return level.var_6AD5;
}

//Function Number: 73
func_12845(param_00)
{
	if(!isdefined(self.var_233))
	{
		return level.var_6AD5;
	}

	var_01 = self method_84B6();
	if(!isdefined(var_01) || distancesquared(var_01,self.origin) < 1296)
	{
		self method_841F();
		self method_8484();
		return level.var_6AD5;
	}

	self method_8481(var_01);
	return level.var_111AE;
}

//Function Number: 74
func_41D4(param_00)
{
	self.var_DD25 = undefined;
}

//Function Number: 75
func_9E1B(param_00)
{
	if(!isdefined(param_00))
	{
		return 0;
	}

	var_01 = self.var_1198.var_FECD;
	var_02 = func_357C();
	foreach(var_04 in var_02)
	{
		var_05 = var_01.var_13CC3[var_04];
		if(isdefined(var_05))
		{
			if(isdefined(var_05.var_65D3) && var_05.var_65D3 == param_00)
			{
				return 1;
			}
		}
	}

	return 0;
}

//Function Number: 76
func_213A()
{
	var_00 = self.var_1198.var_FECD;
	var_01 = 0;
	var_02 = anglestoforward(self.angles);
	var_03 = func_357C();
	foreach(var_05 in var_03)
	{
		var_06 = var_00.var_13CC3[var_05];
		if(isdefined(var_06) && isdefined(var_06.var_65D3))
		{
			var_07 = var_06.var_65D3.origin - self.origin;
			if(vectordot(var_07,var_02) < 0)
			{
				var_01 = 1;
				break;
			}
		}
	}

	return var_01;
}

//Function Number: 77
func_1382A(param_00)
{
	if(!isdefined(self.var_233))
	{
		return level.var_111AE;
	}

	if(func_3906(param_00) == level.var_111AE)
	{
		return level.var_111AE;
	}

	if(!isdefined(self.var_1198.var_C974))
	{
		return level.var_111AE;
	}

	if(!func_9E1B(self.var_1198.var_C974))
	{
		return level.var_111AE;
	}

	var_01 = self method_841E();
	if(var_01 < 175 && func_213A())
	{
		return level.var_111AE;
	}

	return level.var_E87A;
}

//Function Number: 78
func_41B3(param_00)
{
	if(isdefined(self.var_233))
	{
		var_01 = 84;
		var_02 = self method_845D(var_01);
		self method_8481(var_02);
	}

	return level.var_111AE;
}

//Function Number: 79
func_128A9(param_00)
{
	if(!self.var_3135.var_E5FA)
	{
		return level.var_6AD5;
	}

	if(lib_0A1B::func_294A())
	{
		return level.var_111AE;
	}

	if(isdefined(level.player.var_883D) && level.player.var_883D != "none")
	{
		return level.var_6AD5;
	}

	if(isdefined(self.var_30E7) && self.var_30E7)
	{
		return level.var_6AD5;
	}

	if(!isdefined(level.player))
	{
		return level.var_6AD5;
	}

	if(!isalive(level.player))
	{
		return level.var_6AD5;
	}

	if(self.team == level.player.team)
	{
		return level.var_6AD5;
	}

	if(distancesquared(level.player.origin,self.origin) > 90000)
	{
		return level.var_6AD5;
	}

	var_01 = undefined;
	if(lib_0A1B::func_2910("left"))
	{
		var_01 = "left";
	}
	else if(lib_0A1B::func_2910("right"))
	{
		var_01 = "right";
	}

	if(!isdefined(var_01))
	{
		return level.var_6AD5;
	}

	var_02 = anglestoright(self gettagangles("j_spineupper"));
	var_03 = level.player.origin - self gettagorigin("j_spineupper");
	var_04 = angleclamp180(vectortoyaw(var_03) - vectortoyaw(var_02));
	var_05 = 1;
	if(var_01 == "right")
	{
		var_05 = var_05 * -1;
	}

	var_06 = 0;
	if(func_1E76(var_04,var_05 * -60,var_05 * 60))
	{
		var_06 = 1;
		self.var_E5F8 = "front";
	}
	else if(func_1E76(var_04,var_05 * 60,var_05 * 120))
	{
		self.var_E5F8 = var_01;
	}
	else if(func_1E76(var_04,var_05 * -60,var_05 * -160))
	{
		var_06 = 1;
		if(var_01 == "left")
		{
			self.var_E5F8 = "right";
		}
		else
		{
			self.var_E5F8 = "left";
		}
	}
	else
	{
		self.var_E5F8 = "rear";
	}

	if(!func_9EFC(var_06))
	{
		return level.var_6AD5;
	}

	if(isdefined(self.var_B55B))
	{
		self notify("asm_stop_grabtargetthread");
	}

	lib_0A1B::func_2981(var_01);
	return level.var_111AE;
}

//Function Number: 80
func_1E76(param_00,param_01,param_02)
{
	return (param_00 >= param_01 && param_00 <= param_02) || param_00 <= param_01 && param_00 >= param_02;
}

//Function Number: 81
func_9EFC(param_00)
{
	var_01 = self gettagorigin("j_spineupper");
	var_02 = vectortoangles(anglestoright(self gettagangles("j_spineupper")));
	var_03 = var_01 + rotatevector((-20,0,30),var_02);
	var_04 = level.player geteye();
	if(var_04[2] < var_03[2] - 90)
	{
		return 0;
	}

	if(var_04[2] < var_03[2] && param_00 || level.player getvelocity()[2] < 1)
	{
		return 0;
	}

	if(var_04[2] > var_03[2] + 90)
	{
		return 0;
	}

	if(distance2dsquared(var_04,var_03) > 12000)
	{
		return 0;
	}

	if(!level.player scripts\common\trace::func_D307(level.player.origin,var_01,level.player.angles,[self,level.player]))
	{
		return 0;
	}

	return 1;
}

//Function Number: 82
func_4F40()
{
}

//Function Number: 83
func_4F3E()
{
}

//Function Number: 84
func_4F3D(param_00)
{
}

//Function Number: 85
func_4F3F(param_00,param_01,param_02)
{
}

//Function Number: 86
func_4F43()
{
}

//Function Number: 87
func_E602(param_00)
{
	if(isdefined(self.var_1198.var_E5FD) && !self.var_1198.var_E5FD)
	{
		if(isdefined(self.var_3135.var_E5FB))
		{
			self.var_3135.var_E5FB = undefined;
			self.var_6D = 32;
			self method_8481(self.origin);
		}

		if(isdefined(self.var_30EA))
		{
			lib_0A1B::func_2974(self.var_1198.var_E5FF,0);
		}

		self.var_1198.var_E5FF = undefined;
		self.var_1198.var_E5FD = undefined;
		return level.var_6AD5;
	}

	if(!isdefined(self.var_3135.var_E5FB))
	{
		var_01 = scripts\common\utility::getstructarray("c12_rodeo_struct","targetname");
		if(var_01.size == 0)
		{
			self.var_3135.var_E5FB = self.origin;
			self.var_6D = 32;
		}
		else
		{
			var_02 = sortbydistance(var_01,self.origin)[0];
			self.var_3135.var_E5FB = getclosestpointonnavmesh(var_02.origin,self);
			self.var_6D = max(var_02.var_257 - 180,32);
		}

		self method_8481(self.var_3135.var_E5FB);
	}

	return level.var_E87A;
}

//Function Number: 88
func_12F13(param_00)
{
	if(isdefined(self.var_3135.var_F1F8))
	{
		return level.var_E87A;
	}

	self notify("self_destruct");
	thread func_F1F8();
	thread func_F1FA();
	return level.var_E87A;
}

//Function Number: 89
func_F1F8()
{
	self endon("death");
	function_0277("c12_selfdestruct",-1,self,1024,1);
	self.ignoreme = 1;
	self.var_3135.var_F1F8 = 1;
	wait(0.2);
	playfxontag(level.var_7649["c12_selfdestruct_buildup"],self,"j_spineupper");
	self playsound("c12_selfdestruct_1beep","beep_done",1);
	self waittill("beep_done");
	func_F1FB();
	self.var_2303.var_F1FD = 1;
	self method_81D0(self.origin,level.player);
}

//Function Number: 90
func_F1FA()
{
	self endon("death");
	self.var_6D = 128;
	var_00 = self.origin;
	for(;;)
	{
		if(distance2dsquared(var_00,level.player.origin) > squared(self.var_6D))
		{
			var_00 = getclosestpointonnavmesh(level.player.origin,self);
			self method_8481(var_00);
		}

		wait(1);
	}
}

//Function Number: 91
func_F1FB()
{
	self endon("death");
	var_00 = 1;
	for(var_01 = 0;var_01 < 4;var_01++)
	{
		if(soundexists("c12_selfdestruct_beep"))
		{
			self playsound("c12_selfdestruct_beep");
			wait(0.8);
		}
		else
		{
			wait(1);
		}

		var_00 = var_00 - 0.2;
		var_00 = max(0,var_00);
		if(var_00 > 0)
		{
			wait(var_00);
		}
	}
}

//Function Number: 92
func_35AD(param_00,param_01)
{
	if(lib_0A1B::func_9ED3("right_arm") || lib_0A1B::func_9ED3("right_leg") || lib_0A1B::func_9ED3("left_leg"))
	{
		return 0;
	}

	if(lib_0A1B::func_294A())
	{
		return 0;
	}

	var_02 = self.var_10C;
	if(isdefined(param_00))
	{
		var_02 = param_00;
	}

	if(!isplayer(var_02))
	{
		return 0;
	}

	var_03 = vectortoyaw(var_02.origin - self.origin);
	if(abs(angleclamp180(var_03 - self.angles[1])) > 90)
	{
		return level.var_6AD5;
	}

	return lib_0A10::func_9E99(param_00,param_01);
}

//Function Number: 93
func_128AE(param_00,param_01)
{
	var_02 = self.var_1198.var_FECD;
	var_03 = gettime();
	if(isdefined(self.var_2303.var_2AD2))
	{
		var_02.var_A993 = var_03;
		return;
	}

	if(var_03 - var_02.var_A98F < 500)
	{
		return;
	}

	if(var_03 - var_02.var_A993 < 10000)
	{
		return;
	}

	if(!isdefined(param_01.var_65D3))
	{
		return;
	}

	var_04 = param_01.var_65D3;
	var_05 = var_04.origin - self.origin;
	var_06 = lengthsquared(var_05);
	if(var_06 < -25536)
	{
		return;
	}

	var_02.var_A98F = var_03;
	var_07 = 128;
	var_08 = sqrt(var_06);
	if(var_08 < 800)
	{
		var_07 = var_07 * 1 - 800 - var_08 / 800;
	}

	var_07 = randomfloat(var_07);
	var_09 = randomfloat(360);
	var_0A = var_04.origin + (var_07 * cos(var_09),var_07 * sin(var_09),0);
	if(param_00 == "left")
	{
		var_0B = "tag_brass_le";
	}
	else
	{
		var_0B = "tag_brass_ri";
	}

	var_0C = self gettagangles(var_0B);
	var_0D = self gettagorigin(var_0B) + rotatevector((0,-10,0),var_0C);
	var_0E = self method_81ED(var_0D,var_0A);
	if(isdefined(var_0E))
	{
		self playsound("c12_grenade_launch");
		var_0E makeunusable();
		var_02.var_A993 = var_03;
	}
}