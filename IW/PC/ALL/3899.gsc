/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 3899.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 18
 * Decompile Time: 11 ms
 * Timestamp: 10/27/2023 12:31:10 AM
*******************************************************************/

//Function Number: 1
func_CEB5(param_00,param_01,param_02,param_03)
{
	self endon(param_01 + "_finished");
	var_04 = lib_0A1D::func_2337(param_00,param_01);
	self.var_2303.var_4C86.var_697F = undefined;
	if(!isdefined(var_04))
	{
		lib_0A1A::func_2330(param_01,"code_move",undefined);
		return;
	}

	func_D53A(param_00,param_01,var_04,param_02);
	lib_0A1A::func_2330(param_01,"code_move",undefined);
}

//Function Number: 2
func_3E9F(param_00,param_01,param_02)
{
	if(!func_3E57())
	{
		return undefined;
	}

	var_03 = func_53CA(param_01);
	return var_03;
}

//Function Number: 3
func_8162(param_00)
{
	var_01 = [];
	if(lib_0A1A::func_2346(param_00,"1"))
	{
		var_01[7] = lib_0A1A::func_2358(param_00,"1");
	}

	if(lib_0A1A::func_2346(param_00,"2"))
	{
		var_01[0] = lib_0A1A::func_2358(param_00,"2");
		var_01[8] = var_01[0];
	}

	if(lib_0A1A::func_2346(param_00,"3"))
	{
		var_01[1] = lib_0A1A::func_2358(param_00,"3");
	}

	if(lib_0A1A::func_2346(param_00,"4"))
	{
		var_01[6] = lib_0A1A::func_2358(param_00,"4");
	}

	if(lib_0A1A::func_2346(param_00,"6"))
	{
		var_01[2] = lib_0A1A::func_2358(param_00,"6");
	}

	if(lib_0A1A::func_2346(param_00,"7"))
	{
		var_01[5] = lib_0A1A::func_2358(param_00,"7");
	}

	if(lib_0A1A::func_2346(param_00,"8"))
	{
		var_01[4] = lib_0A1A::func_2358(param_00,"8");
	}

	if(lib_0A1A::func_2346(param_00,"9"))
	{
		var_01[3] = lib_0A1A::func_2358(param_00,"9");
	}

	return var_01;
}

//Function Number: 4
func_53CA(param_00)
{
	var_01 = self method_8148();
	if(isdefined(var_01))
	{
		var_02 = var_01.origin;
	}
	else
	{
		var_02 = self.var_233;
	}

	var_03 = lib_0A1D::func_7EA3();
	var_04 = self method_813A();
	var_05 = vectortoangles(var_04);
	if(isdefined(var_03))
	{
		var_06 = var_03.angles;
	}
	else
	{
		var_06 = self.angles;
	}

	var_07 = angleclamp180(var_05[1] - self.angles[1]);
	var_08 = self getvelocity();
	if(length2dsquared(var_08) > 16)
	{
		var_09 = vectortoangles(var_08);
		if(abs(angleclamp180(var_09[1] - var_05[1])) < 45)
		{
			return;
		}
	}

	if(distancesquared(var_02,self.origin) < 22500)
	{
		return;
	}

	if(isdefined(self.var_2303.var_4C86) && isdefined(self.var_2303.var_4C86.var_697F))
	{
		var_0A = func_8162(self.var_2303.var_4C86.var_697F);
	}
	else
	{
		var_0A = func_8162(var_01);
	}

	var_0B = function_02F8(var_07);
	var_0C = undefined;
	var_0D = undefined;
	for(var_0E = 0;var_0E < var_0B.size;var_0E++)
	{
		var_0F = var_0B[var_0E];
		if(!isdefined(var_0A[var_0F]))
		{
			continue;
		}

		var_0C = self method_80FD(param_00,var_0A[var_0F]);
		var_10 = getmovedelta(var_0C);
		var_11 = rotatevector(var_10,self.angles) + self.origin;
		if(!navtrace(self.origin,var_11,self))
		{
			var_0D = var_0A[var_0F];
			break;
		}
	}

	return var_0D;
}

//Function Number: 5
func_D53A(param_00,param_01,param_02,param_03)
{
	self endon(param_01 + "_finished");
	var_04 = vectortoangles(self method_813A());
	var_05 = angleclamp180(var_04[1] - self.angles[1]);
	var_06 = self method_80FD(param_01,param_02);
	var_07 = getnotetracktimes(var_06,"code_move");
	var_08 = 1;
	if(var_07.size > 0)
	{
		var_08 = var_07[0];
	}

	var_09 = getangledelta3d(var_06,0,var_08);
	self method_8281("anim deltas");
	var_0A = angleclamp180(var_04[1] - var_09[1]);
	var_0B = (0,var_0A,0);
	self method_8289("face angle abs",var_0B);
	var_0C = getanimlength(var_06) * var_08;
	var_0D = 0.01 + abs(angleclamp180(var_05 - var_09[1])) / var_0C / 1000;
	if(var_0D < 0.01)
	{
		var_0D = 0.01;
	}

	self.var_D8C4 = self.var_358;
	self.var_358 = var_0D;
	lib_0A1D::func_2365(param_00,param_01,param_03,param_02,self.var_BCD6);
	self.var_358 = self.var_D8C4;
	self.var_D8C4 = undefined;
	self method_8281("code_move");
	self method_8289("face motion");
}

//Function Number: 6
func_3E57()
{
	if(!isdefined(self.var_233))
	{
		return 0;
	}

	if(!self method_8380())
	{
		return 0;
	}

	if(isdefined(self.var_10C) && lib_0A1B::func_298E())
	{
		return 0;
	}

	if(isdefined(self.var_55ED) && self.var_55ED)
	{
		return 0;
	}

	if(distancesquared(self.origin,self.var_233) < 10000)
	{
		return 0;
	}

	return 1;
}

//Function Number: 7
func_3B1F(param_00,param_01,param_02,param_03)
{
	if(!isdefined(param_03[2]) || !lib_0A1B::func_2956(param_03[2]))
	{
		return 0;
	}

	return func_FFF8(param_00,param_01,param_02,param_03);
}

//Function Number: 8
func_FFF8(param_00,param_01,param_02,param_03)
{
	if(isdefined(self.var_C189) && self.var_C189)
	{
		return 0;
	}

	if(isdefined(self.var_932E) && self.var_932E)
	{
		return 0;
	}

	var_04 = lib_0A1A::func_233B(param_00);
	var_05 = lib_0A1A::func_233F(var_04,"sharp_turn");
	if(!isdefined(var_05))
	{
		return 0;
	}

	var_06 = 100;
	var_07 = gettime();
	if(var_07 - var_05.var_7686 > var_06)
	{
		return 0;
	}

	if(isarray(param_03))
	{
		var_08 = param_03[0];
	}
	else
	{
		var_08 = var_04;
	}

	var_09 = var_05.var_C8F0[0];
	var_0A = var_05.var_C8F0[1];
	var_0B = func_371C(var_04,param_02,var_09,var_0A);
	if(!isdefined(var_0B))
	{
		return 0;
	}

	self.var_FC61 = var_0B;
	return 1;
}

//Function Number: 9
func_371C(param_00,param_01,param_02,param_03)
{
	var_04 = 10;
	if(param_03)
	{
		var_04 = 30;
	}

	var_05 = vectortoangles(param_02);
	var_06 = angleclamp180(var_05[1] - self.angles[1]);
	if(param_03)
	{
		if(abs(var_06) < 30)
		{
			return undefined;
		}
	}

	var_07 = function_02F8(var_06,var_04);
	if(scripts\common\utility::istrue(self.var_AB3F))
	{
		var_08 = func_8117(param_01,0);
	}
	else
	{
		var_08 = func_8117(param_02,1);
	}

	foreach(var_0A in var_07)
	{
		if(var_0A == 4)
		{
			continue;
		}

		if(var_0A < 0 || var_0A > 8)
		{
			continue;
		}

		var_0B = self method_80FD(param_01,var_08[var_0A]);
		var_0C = getangledelta(var_0B);
		var_0D = (0,angleclamp180(var_05[1] - var_0C),0);
		if(func_38B1(var_0B,var_0D,var_0A == 3 || var_0A == 5))
		{
			return var_08[var_0A];
		}
	}

	return undefined;
}

//Function Number: 10
func_3EF5(param_00,param_01,param_02,param_03)
{
	return self.var_FC61;
}

//Function Number: 11
func_D514(param_00,param_01,param_02,param_03)
{
	self endon(param_01 + "_finished");
	var_04 = lib_0A1D::func_2337(param_00,param_01);
	self.var_FC61 = undefined;
	lib_0A1D::func_237E("anim deltas");
	lib_0A1D::func_237F("face current");
	lib_0A1D::func_2365(param_00,param_01,param_02,var_04,self.var_BCD6);
	lib_0A1D::func_237E("code_move");
	lib_0A1D::func_237F("face motion");
}

//Function Number: 12
func_38B1(param_00,param_01,param_02)
{
	if(!isdefined(self.var_233))
	{
		return 0;
	}

	if(lib_0A1B::func_298E())
	{
		return 0;
	}

	var_03 = getnotetracktimes(param_00,"code_move");
	if(var_03.size == 0)
	{
		var_03[0] = 1;
	}

	var_04 = var_03[0];
	var_05 = getmovedelta(param_00,0,var_04);
	var_06 = self method_81E7(var_05);
	var_07 = self.var_233;
	var_08 = self method_8148();
	if(isdefined(var_08))
	{
		var_07 = var_08.origin;
	}

	if(isdefined(self.var_22F0))
	{
		if(squared(self.var_22F0) > distancesquared(var_07,var_06))
		{
			return 0;
		}
	}
	else if(distancesquared(var_07,var_06) < 7056)
	{
		return 0;
	}

	var_05 = getmovedelta(param_00,0,1);
	var_09 = self method_81E7(var_05);
	var_09 = var_06 + vectornormalize(var_09 - var_06) * 20;
	var_0A = navtrace(var_06,var_09,self);
	if(var_0A)
	{
		return 0;
	}

	if(isdefined(self.var_7198))
	{
		return self [[ self.var_7198 ]](param_00,param_01,param_02);
	}

	return 1;
}

//Function Number: 13
func_8118(param_00,param_01)
{
	var_02 = [];
	var_03 = "";
	if(isdefined(param_01) && param_01 && self.var_2303.var_7257.var_7254 == "right")
	{
		var_03 = "right";
	}
	else
	{
		var_03 = "left";
	}

	var_02[0] = lib_0A1A::func_2358(param_00,var_03 + "2");
	var_02[1] = lib_0A1A::func_2358(param_00,var_03 + "3");
	var_02[2] = lib_0A1A::func_2358(param_00,var_03 + "6");
	var_02[3] = lib_0A1A::func_2358(param_00,var_03 + "9");
	var_02[5] = lib_0A1A::func_2358(param_00,var_03 + "7");
	var_02[6] = lib_0A1A::func_2358(param_00,var_03 + "4");
	var_02[7] = lib_0A1A::func_2358(param_00,var_03 + "1");
	var_02[8] = lib_0A1A::func_2358(param_00,var_03 + "2");
	return var_02;
}

//Function Number: 14
func_8117(param_00,param_01)
{
	if(isdefined(self.var_7C54))
	{
		return [[ self.var_7C54 ]](param_00,param_01);
	}

	return func_8118(param_00,param_01);
}

//Function Number: 15
func_4EAB(param_00)
{
}

//Function Number: 16
func_D4E5(param_00,param_01,param_02,param_03)
{
	func_98A2(param_00,param_01,param_02,param_03);
	func_BCFC(param_00,param_01,param_02);
}

//Function Number: 17
func_98A2(param_00,param_01,param_02,param_03)
{
}

//Function Number: 18
func_BCFC(param_00,param_01,param_02)
{
	self endon(param_01 + "_finished");
	var_03 = lib_0A1A::func_2358(param_01,"f");
	var_04 = lib_0A1A::func_2358(param_01,"l");
	var_05 = lib_0A1A::func_2358(param_01,"r");
	var_06 = lib_0A1A::func_2358(param_01,"b");
	self method_8281("code_move");
	var_07 = -1;
	var_08 = -1;
	for(;;)
	{
		var_09 = scripts\anim\utility_common::func_DB51(self method_813E());
		if(var_09["back"] == 1)
		{
			var_08 = var_06;
		}
		else if(var_09["left"] == 1)
		{
			var_08 = var_04;
		}
		else if(var_09["right"] == 1)
		{
			var_08 = var_05;
		}
		else
		{
			var_08 = var_03;
		}

		if(var_08 != var_07)
		{
			self method_82AF(param_01,var_08);
		}

		var_07 = var_08;
		wait(0.25);
	}
}