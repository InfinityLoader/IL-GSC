/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 2570.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 78
 * Decompile Time: 21 ms
 * Timestamp: 10/27/2023 12:23:22 AM
*******************************************************************/

//Function Number: 1
func_97EF(param_00)
{
	self.var_3135.var_C2 = spawnstruct();
	self.var_3135.var_C2.var_4C28 = "none";
	self.var_3135.var_C2.var_205 = self.var_205;
	self.var_3135.var_C2.var_10DFF = gettime();
	self.var_3135.var_C2.var_BF8A = gettime() + randomintrange(3000,7000);
	self.var_1198.var_AA3D = self.var_205;
	if(isdefined(self.var_1198.var_522F))
	{
	}

	lib_0A06::func_12F28(param_00);
	if(self.var_205.type == "Cover Prone" || self.var_205.type == "Conceal Prone")
	{
		lib_0A1B::func_296A("prone");
	}

	lib_0A1B::func_2976(self.var_3135.var_C2.var_205);
	self.var_46A6 = self.origin;
	if(!isdefined(self.var_3135.var_C2.var_BFA5) || !isdefined(self.var_1198.var_10171))
	{
		func_F7B4();
	}

	func_F7B0();
	return level.var_111AE;
}

//Function Number: 2
func_41A3(param_00)
{
	if(lib_0A1B::func_2932())
	{
		lib_0A1B::func_2976(undefined);
		lib_0A1B::func_2961("hide");
		self.var_1198.var_522F = undefined;
		if(isdefined(self.var_233))
		{
			var_01 = "stand";
			if(isdefined(self.var_71A6))
			{
				var_01 = self [[ self.var_71A6 ]]();
			}

			lib_0A1B::func_296A(var_01);
		}

		lib_0A1B::func_295E(undefined);
		self.var_3135.var_C2 = undefined;
		self.var_BF7F = gettime() + 1000 + randomintrange(0,self.var_C4);
		lib_0A1B::func_2983(undefined);
	}

	return level.var_111AE;
}

//Function Number: 3
func_4746(param_00,param_01)
{
	func_F6A4(param_01);
	return level.var_111AE;
}

//Function Number: 4
func_F6A4(param_00)
{
	if(param_00 == "hide" && self.var_3135.var_C2.var_4C28 == "exposed" || self.var_3135.var_C2.var_4C28 == "none")
	{
		func_9815();
	}

	lib_0A1B::func_2961(param_00);
	self.var_3135.var_C2.var_4C28 = param_00;
}

//Function Number: 5
func_7E42()
{
	return self.var_3135.var_C2.var_4C28;
}

//Function Number: 6
func_9D71(param_00)
{
	return gettime() > self.var_3135.var_BF89;
}

//Function Number: 7
func_F7B0(param_00)
{
	if(self.var_12BA4 == "c6")
	{
		var_01 = 0;
		if(isdefined(self.var_10C))
		{
			var_02 = distance(self.var_10C.origin,self.origin);
			if(var_02 > self.var_112 && var_02 < self.var_110)
			{
				var_01 = 1;
			}
		}

		if(var_01)
		{
			self.var_3135.var_BF89 = gettime() + randomintrange(6000,11000);
			return;
		}

		self.var_3135.var_BF89 = gettime() + randomintrange(2000,3000);
		return;
	}

	if(scripts\common\utility::func_167E())
	{
		if(!isdefined(param_00))
		{
			if(isdefined(self.var_3135.var_C2) && isdefined(self.var_3135.var_C2.var_205))
			{
				if(scripts\asm\shared_utility::func_C04A(self.var_3135.var_C2.var_205))
				{
					param_00 = 1;
				}
			}
		}

		if(scripts\common\utility::istrue(param_00))
		{
			self.var_3135.var_BF89 = gettime() + randomintrange(5000,9000);
			return;
		}

		self.var_3135.var_BF89 = gettime() + randomintrange(7000,13000);
		return;
	}

	self.var_3135.var_BF89 = gettime() + randomintrange(6000,11000);
}

//Function Number: 8
func_BD18(param_00)
{
	if(isdefined(self.var_71C4))
	{
		self [[ self.var_71C4 ]](param_00);
	}
}

//Function Number: 9
func_10037(param_00)
{
	if(isdefined(self.var_71CF))
	{
		return self [[ self.var_71CF ]](param_00);
	}

	return level.var_6AD5;
}

//Function Number: 10
func_B01D(param_00)
{
	if(isdefined(self.var_71BE))
	{
		return self [[ self.var_71BE ]](param_00);
	}

	return level.var_6AD5;
}

//Function Number: 11
func_13059(param_00)
{
	var_01 = self.var_1A4;
	var_02 = self.var_1A3;
	self.var_1A4 = 0;
	self.var_1A3 = 0;
	if(self method_83D4(param_00,0))
	{
		func_BD18(param_00);
		return 1;
	}
	else
	{
	}

	self.var_1A4 = var_01;
	self.var_1A3 = var_02;
	return 0;
}

//Function Number: 12
func_470D()
{
	if(self.var_132 || self.var_FC)
	{
		return 0;
	}

	if(gettime() < self.var_3135.var_BF89)
	{
		return 0;
	}

	if(!isdefined(self.var_10C))
	{
		return 0;
	}

	var_00 = self.var_3135.var_C2;
	if(var_00.var_4C28 == "hide" || isdefined(self.var_280A))
	{
		if(!isdefined(self.var_1198.var_522F) || !func_9D96(self.var_1198.var_522F))
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 13
func_B019(param_00)
{
	if(func_470D())
	{
		var_01 = func_B01A(self.var_3135.var_C2.var_205);
		if(var_01)
		{
			self.var_3135.var_BF89 = gettime() + 1000;
			thread scripts\anim\battlechatter_ai::func_67D2();
		}
		else
		{
			func_F7B0();
		}
	}

	return level.var_111AE;
}

//Function Number: 14
func_B01A(param_00)
{
	if(self.script == "cover_arrival")
	{
		return 0;
	}

	var_01 = self method_80E3();
	if(isdefined(var_01))
	{
		if(!isdefined(self.var_205) || var_01 != self.var_205 || isdefined(param_00) && var_01 != param_00)
		{
			if(func_13059(var_01))
			{
				return 1;
			}
		}
	}

	return 0;
}

//Function Number: 15
func_6A0D()
{
	if(self.var_132 || self.var_FC)
	{
		return 0;
	}

	if(isdefined(self.var_3135.var_C2))
	{
		return 0;
	}

	if(!isdefined(self.var_1198.var_AA3D))
	{
		return 0;
	}

	return 1;
}

//Function Number: 16
func_12E92(param_00)
{
	if(func_6A0D())
	{
		if(!scripts\common\utility::func_167E() && isdefined(self.var_233) && distancesquared(self.var_233,self.origin) > 4)
		{
			self.var_1198.var_AA3D = undefined;
			self.var_3135.var_BF89 = undefined;
		}
		else if(isdefined(self.var_205) && self.var_205 != self.var_1198.var_AA3D)
		{
			self.var_1198.var_AA3D = undefined;
			self.var_3135.var_BF89 = undefined;
		}
		else
		{
			if(!isdefined(self.var_3135.var_BF89))
			{
				func_F7B0(1);
			}

			if(gettime() >= self.var_3135.var_BF89)
			{
				var_01 = func_B01A(self.var_1198.var_AA3D);
				if(var_01)
				{
					func_F7B0(1);
				}
				else
				{
					self.var_3135.var_BF89 = gettime() + 1000;
				}
			}
		}
	}

	return level.var_111AE;
}

//Function Number: 17
func_12D78(param_00)
{
	var_01 = self.var_3135.var_C2.var_205;
	return level.var_111AE;
}

//Function Number: 18
func_12DDF(param_00)
{
	return level.var_111AE;
}

//Function Number: 19
func_389B(param_00)
{
	switch(param_00.type)
	{
		case "Cover Stand":
		case "Cover Crouch":
		case "Cover Stand 3D":
			return 1;

		default:
			return 0;
	}

	return 0;
}

//Function Number: 20
func_8BEB(param_00)
{
	return isdefined(self.var_1198.var_5D3B) && isdefined(self.var_1198.var_522F) && self.var_1198.var_522F == param_00;
}

//Function Number: 21
func_FFE1(param_00)
{
	var_01 = isdefined(self.var_205) && func_8BEB(self.var_205) && func_389B(self.var_205);
	var_02 = scripts\anim\utility_common::func_13112() || isdefined(lib_0A1B::func_292D()) || var_01;
	if(var_02)
	{
		return level.var_111AE;
	}

	return level.var_6AD5;
}

//Function Number: 22
func_12EA7(param_00)
{
	func_F6A4("hide");
	return level.var_111AE;
}

//Function Number: 23
func_9D96(param_00)
{
	return self method_8199(param_00) || scripts\common\utility::istrue(self.var_9327);
}

//Function Number: 24
func_9D98()
{
	return self method_8199() || scripts\common\utility::istrue(self.var_9327);
}

//Function Number: 25
func_9E43(param_00)
{
	if(!isdefined(self.var_205) || self.var_205.type == "Path" || self.var_205.type == "Exposed" || scripts\common\utility::func_9EB8(self.var_205))
	{
		return level.var_6AD5;
	}

	var_01 = 16;
	if(isdefined(self.var_233))
	{
		if(distancesquared(self.var_233,self.origin) > var_01)
		{
			return level.var_6AD5;
		}
	}
	else if(self.var_1A4)
	{
		var_01 = 3600;
	}
	else if(isdefined(self.var_1198.var_522F) && self.var_205 == self.var_1198.var_522F)
	{
		var_01 = 576;
	}
	else
	{
		var_01 = 225;
	}

	var_02 = undefined;
	if(scripts\common\utility::func_167E())
	{
		var_02 = distancesquared(self.origin,self.var_205.origin);
	}
	else
	{
		if(abs(self.origin[2] - self.var_205.origin[2]) > 80)
		{
			return level.var_6AD5;
		}

		var_02 = distance2dsquared(self.origin,self.var_205.origin);
	}

	if(var_02 > var_01)
	{
		return level.var_6AD5;
	}

	if(isdefined(self.var_3135.var_C2))
	{
		if(!isdefined(self.var_3135.var_C2.var_205))
		{
			return level.var_6AD5;
		}

		if(self.var_3135.var_C2.var_205 != self.var_205)
		{
			return level.var_6AD5;
		}

		if(isdefined(self.var_10C))
		{
			var_03 = 0;
			if(func_FFCB())
			{
				var_03 = func_9D99(self.var_3135.var_C2.var_205);
			}
			else
			{
				var_03 = func_9D98();
			}

			if(!var_03 && !func_6E03())
			{
				return level.var_6AD5;
			}
		}
	}
	else if(isdefined(self.var_10C))
	{
		if(!func_9D98() && !func_6E03())
		{
			return level.var_6AD5;
		}
	}

	return level.var_111AE;
}

//Function Number: 26
func_6E03()
{
	if(!self.var_132)
	{
		return 0;
	}

	if(isdefined(self.var_10C.var_205) && !nodesvisible(self.var_205,self.var_10C.var_205))
	{
		return 1;
	}

	if(!self method_8296(self.var_10C,8))
	{
		return 1;
	}

	if(scripts\common\utility::func_167E())
	{
		return 1;
	}

	if(distancesquared(self.origin,self.var_10C.origin) > 4096)
	{
		var_00 = (0,0,50);
		var_01 = vectornormalize(self.var_10C.origin - self.origin);
		var_02 = self.origin + var_00;
		var_03 = var_02 + var_01 * 64;
		return !bullettracepassed(var_02,var_03,0,self);
	}

	return 0;
}

//Function Number: 27
func_FFCB()
{
	return weaponclass(self.var_394) == "mg" || func_8BEB(self.var_3135.var_C2.var_205);
}

//Function Number: 28
func_9D99(param_00)
{
	if(!isdefined(self.var_10C) || !isdefined(self.var_205))
	{
		return 0;
	}

	var_01 = param_00.angles[1] - vectortoyaw(self.var_10C.origin - param_00.origin);
	var_01 = angleclamp180(var_01);
	if(var_01 < 0)
	{
		var_01 = -1 * var_01;
	}

	if(var_01 <= self.var_1B7)
	{
		return 1;
	}

	return 0;
}

//Function Number: 29
func_10067(param_00,param_01)
{
	var_02 = level.var_111AE;
	var_03 = level.var_6AD5;
	if(self.var_3250 > weaponclipsize(self.var_394) * param_01)
	{
		return var_03;
	}

	thread scripts\anim\battlechatter_ai::func_67D4();
	return var_02;
}

//Function Number: 30
func_98C1(param_00)
{
	func_9815();
}

//Function Number: 31
func_4742(param_00)
{
	if(lib_0A1A::func_232A("reload","end"))
	{
		return level.var_6AD5;
	}

	lib_0A1B::func_2969(1);
	func_F6A4("hide");
	return level.var_E87A;
}

//Function Number: 32
func_116FD(param_00)
{
	lib_0A1B::func_2969(0);
}

//Function Number: 33
func_9814(param_00)
{
	func_F6A4("hide");
	if(isdefined(self.var_10C) && !isdefined(self.var_3135.var_C2.var_3C5B))
	{
		func_F6A2();
	}
}

//Function Number: 34
func_4721(param_00)
{
	func_F6A4("hide");
	if(isdefined(self.var_10C) && !func_9D98())
	{
		self.var_3135.var_BF89 = self.var_3135.var_BF89 - 1000;
	}

	return level.var_111AE;
}

//Function Number: 35
func_F7D9(param_00)
{
	var_01 = 2500;
	var_02 = 3500;
	self.var_3135.var_C2.var_C9FB = gettime() + randomintrange(var_01,var_02);
}

//Function Number: 36
func_9815()
{
	var_00 = gettime();
	self.var_3135.var_C2.var_11934 = var_00;
	func_F7D9(1);
}

//Function Number: 37
func_116F7(param_00)
{
}

//Function Number: 38
func_9D97(param_00)
{
	if(isdefined(self.var_280A))
	{
		return level.var_6AD5;
	}

	if(scripts\anim\utility_common::func_9F8F())
	{
		return level.var_111AE;
	}

	return level.var_6AD5;
}

//Function Number: 39
func_38CB(param_00)
{
	var_01 = self.var_205.type;
	if(var_01 == "Cover Left")
	{
		return level.var_111AE;
	}
	else if(var_01 == "Cover Right")
	{
		return level.var_111AE;
	}
	else if(var_01 == "Cover Stand" || var_01 == "Cover Stand 3D")
	{
		var_02 = self.var_205 method_8169();
		foreach(var_04 in var_02)
		{
			if(var_04 == "over")
			{
				return level.var_111AE;
			}
		}

		return level.var_111AE;
	}
	else if(var_05 == "Cover Prone" || var_05 == "Conceal Prone")
	{
		return level.var_6AD5;
	}

	return level.var_6AD5;
}

//Function Number: 40
func_10038(param_00)
{
	if(func_7E42() != "hide")
	{
		return level.var_6AD5;
	}

	if(self.var_FC)
	{
		return level.var_6AD5;
	}

	if(!isdefined(self.var_3135.var_C2.var_11934))
	{
		return level.var_6AD5;
	}

	if(!isdefined(self.var_3135.var_C2.var_C9FB))
	{
		return level.var_6AD5;
	}

	if(gettime() < self.var_3135.var_C2.var_C9FB)
	{
		return level.var_6AD5;
	}

	return level.var_111AE;
}

//Function Number: 41
func_9894(param_00)
{
	var_01 = 500;
	var_02 = 1500;
	var_03 = gettime();
	self.var_3135.var_C2.var_B026 = var_03;
	self.var_3135.var_C2.var_B016 = randomintrange(var_01,var_02);
	self.var_3135.var_C2.var_B012 = 3000;
}

//Function Number: 42
func_116F9(param_00)
{
	if(isdefined(self.var_3135.var_C2))
	{
		func_F7D9(0);
	}
}

//Function Number: 43
func_4726(param_00)
{
	func_F6A4("look");
	var_01 = self.var_3135.var_C2.var_B026;
	var_02 = self.var_3135.var_C2.var_B016;
	var_03 = self.var_3135.var_C2.var_B012;
	if(isdefined(self.var_233))
	{
		return level.var_111AE;
	}

	var_04 = gettime();
	if(lib_0A1A::func_232A("cover_trans","end"))
	{
		var_03 = var_04 - var_01;
	}

	if(var_04 - var_01 > var_03 + var_02)
	{
		return level.var_111AE;
	}

	return level.var_E87A;
}

//Function Number: 44
func_38E8(param_00)
{
	var_01 = self.var_205.type;
	if(scripts\common\utility::func_9EB3(self.var_205))
	{
		return level.var_111AE;
	}
	else if(var_01 == "Cover Stand" || var_01 == "Cover Stand 3D")
	{
		var_02 = self.var_205 method_8169();
		foreach(var_04 in var_02)
		{
			if(var_04 == "over")
			{
				return level.var_111AE;
			}
		}

		return level.var_6AD5;
	}
	else if(var_05 == "Cover Right")
	{
		if(self.var_1491.var_D6A5 == "stand")
		{
			return level.var_111AE;
		}
		else
		{
			return level.var_6AD5;
		}
	}
	else if(var_05 == "Cover Left")
	{
		return level.var_111AE;
	}
	else if(var_05 == "Cover 3D")
	{
		return level.var_111AE;
	}

	return level.var_6AD5;
}

//Function Number: 45
func_473E(param_00)
{
	func_F6A4("peek");
	if(lib_0A1A::func_232A("cover_peek","end"))
	{
		return level.var_111AE;
	}

	return level.var_E87A;
}

//Function Number: 46
func_116FC(param_00)
{
	if(isdefined(self.var_3135.var_C2))
	{
		func_F6A4("hide");
		func_F7D9(0);
	}
}

//Function Number: 47
func_BDF3(param_00)
{
	if(!isdefined(self.var_205) && self.var_1491.var_D6A5 == "prone")
	{
		return level.var_111AE;
	}

	if(self.var_205.type == "Conceal Prone" || self.var_205.type == "Cover Prone")
	{
		if(self.var_1491.var_D6A5 != "prone" || lib_0A1B::func_292C() != "prone")
		{
			return level.var_111AE;
		}

		return level.var_6AD5;
	}

	if(!self method_81BF(self.var_1491.var_D6A5))
	{
		return level.var_111AE;
	}

	var_01 = undefined;
	if(self.var_205 method_80B1("stand") && !self.var_205 method_80B1("crouch"))
	{
		var_01 = "stand";
	}
	else if(self.var_205 method_80B1("crouch") && !self.var_205 method_80B1("stand"))
	{
		var_01 = "crouch";
	}

	if(isdefined(var_01))
	{
		lib_0A1B::func_296A(var_01);
	}

	return level.var_6AD5;
}

//Function Number: 48
func_FFD1(param_00)
{
	if(!isdefined(self.var_10C))
	{
		return level.var_6AD5;
	}

	if(isdefined(self.var_DC5C) && self.var_1491.var_D6A5 == "stand")
	{
		return level.var_6AD5;
	}

	if(self.var_205.type != "Cover Right" && self.var_205.type != "Cover Left")
	{
		return level.var_6AD5;
	}

	if(scripts\common\utility::func_9EB2(self.var_205))
	{
		return level.var_6AD5;
	}

	if(self.var_1491.var_D6A5 == "stand" && !self.var_205 method_80B1("crouch"))
	{
		return level.var_6AD5;
	}

	if(self.var_1491.var_D6A5 == "crouch" && !self.var_205 method_80B1("stand"))
	{
		return level.var_6AD5;
	}

	if(!isdefined(self.var_3135.var_C2.var_3C5B))
	{
		func_F6A2();
	}

	if(gettime() < self.var_3135.var_C2.var_3C5B)
	{
		return level.var_6AD5;
	}

	return level.var_111AE;
}

//Function Number: 49
func_F6A2()
{
	self.var_3135.var_C2.var_3C5B = gettime() + randomintrange(5000,20000);
}

//Function Number: 50
func_97E4(param_00)
{
	func_F6A2();
	self.var_1491.var_D892 = undefined;
	var_01 = undefined;
	if((self.var_1491.var_D6A5 != "prone" || lib_0A1B::func_292C() != "prone") && isdefined(self.var_205) && self.var_205.type == "Conceal Prone" || self.var_205.type == "Cover Prone")
	{
		var_01 = "prone";
	}
	else
	{
		var_02 = ["stand","crouch","prone"];
		for(var_03 = 0;var_03 < var_02.size;var_03++)
		{
			var_04 = var_02[var_03];
			if(self method_81BF(var_04))
			{
				var_01 = var_04;
				break;
			}
		}
	}

	lib_0A1B::func_296A(var_01);
	self.var_3135.var_C2.var_3C5C = gettime();
}

//Function Number: 51
func_4712(param_00)
{
	if(lib_0A1A::func_232A("cover_stance_trans","end"))
	{
		return level.var_111AE;
	}

	var_01 = 5000;
	var_02 = self.var_3135.var_C2.var_3C5C;
	if(gettime() - var_02 > var_01)
	{
		return level.var_111AE;
	}

	if(self.var_1491.var_D6A5 == lib_0A1B::func_292C())
	{
		return level.var_111AE;
	}

	return level.var_E87A;
}

//Function Number: 52
func_116F1(param_00)
{
	lib_0A1B::func_296A(self.var_1491.var_D6A5);
}

//Function Number: 53
func_7E40(param_00,param_01)
{
	if(param_00.type == "Cover Right")
	{
		if(param_01 == "stand")
		{
			return [-180,12,-40,0,-180,-38];
		}

		return [-180,12,-40,0,-180,-31];
	}

	if(param_00.type == "Cover Left")
	{
		if(param_01 == "stand")
		{
			return [-14,180,0,40,38,180];
		}

		return [-14,180,0,40,31,180];
	}

	return [-45,45,0,0,0,0];
}

//Function Number: 54
func_77C3(param_00,param_01)
{
	if(param_00.type == "Cover 3D")
	{
		return [-65,45,-55,55];
	}

	return [-45,45,-45,45];
}

//Function Number: 55
func_8C20(param_00)
{
	var_01 = 36;
	var_02 = param_00.origin;
	if(scripts\common\utility::func_9EB7(param_00))
	{
		var_02 = var_02 + anglestoright(param_00.angles) * var_01;
	}
	else
	{
		var_02 = var_02 + function_02D3(param_00.angles) * var_01;
	}

	return self method_8200(var_02,0,0);
}

//Function Number: 56
func_4749(param_00)
{
	if(self.script == "cover_arrival" || self.script == "move")
	{
		return level.var_6AD5;
	}

	if(isdefined(self.var_280A))
	{
		return level.var_111AE;
	}

	if(!isdefined(self.var_10C))
	{
		return level.var_6AD5;
	}

	if(scripts\common\utility::func_167E() && scripts\common\utility::func_9EB1(self.var_205))
	{
		if(scripts\common\utility::func_9EB8(self.var_205))
		{
			return level.var_111AE;
		}

		var_01 = scripts\asm\shared_utility::func_7FF6(self.var_205,0);
		var_02 = angleclamp180(self.angles[0] - var_01[0]);
		var_03 = angleclamp180(self.angles[1] - var_01[1]);
		var_04 = angleclamp180(self.angles[2] - var_01[2]);
		if(abs(var_02) > 5 || abs(var_03) > 5 || abs(var_04) > 5)
		{
			return level.var_6AD5;
		}

		var_05 = self.var_10C.origin + scripts\anim\utility_common::func_7E8D() / 2;
		var_06 = var_05 - self.origin;
		var_07 = rotatevectorinverted(var_06,self.var_205.angles);
		var_08 = vectortoangles(var_07);
		var_02 = angleclamp180(var_08[0]);
		var_03 = angleclamp180(var_08[1]);
		var_09 = func_77C3(self.var_205,self.var_1491.var_D6A5);
		if(var_02 > var_09[1] || var_02 < var_09[0])
		{
			return level.var_6AD5;
		}

		if(var_03 > var_09[3] || var_03 < var_09[2])
		{
			return level.var_6AD5;
		}

		return level.var_111AE;
	}

	var_0A = func_7E40(self.var_205,self.var_1491.var_D6A5);
	var_0B = self.var_205.origin + scripts\anim\utility_common::func_7FFC(self.var_205);
	var_06 = self.var_10C.origin - var_0B;
	var_0C = vectortoangles(var_0B);
	var_08 = angleclamp180(var_0C[1] - self.var_205.angles[1]);
	if(var_08[0] <= var_0C && var_0C <= var_08[1])
	{
		if((scripts\common\utility::func_9EB7(self.var_205) && var_0C > var_08[3]) || scripts\common\utility::func_9EB4(self.var_205) && var_0C < var_08[2])
		{
			if(!func_8C20(self.var_205))
			{
				return level.var_6AD5;
			}
		}

		return level.var_111AE;
	}

	return level.var_6AD5;
}

//Function Number: 57
func_9803(param_00)
{
	if(func_7E42() != "exposed")
	{
		self.var_3135.var_C2.var_11933 = gettime() + 3000;
	}

	self.var_3135.var_FECD = spawnstruct();
	self.var_3135.var_FECD.var_1158F = param_00;
	self.var_3135.var_B117 = 0;
	var_01 = scripts\anim\utility_common::func_9D4D();
	if(var_01)
	{
		lib_0A06::func_FE5D(self.var_3135.var_FECD);
	}
}

//Function Number: 58
func_116F4(param_00)
{
	if(isdefined(self.var_3135.var_FECD) && self.var_3135.var_FECD.var_1158F == param_00)
	{
		self.var_3135.var_FECD = undefined;
		self.var_3135.var_B117 = undefined;
	}

	lib_0A1B::func_2962(0);
	lib_0A1B::func_2983(undefined);
}

//Function Number: 59
func_38C5()
{
	if(weaponclass(self.var_394) == "rocketlauncher")
	{
		return 0;
	}

	return 1;
}

//Function Number: 60
func_4B0B(param_00,param_01)
{
	var_02 = ["exposed","left","right"];
	var_03 = [(0,0,46),(0,0,0),(0,0,0)];
	var_04 = [(0,0,0),(0,32,36),(0,-32,36)];
	var_05 = [(0,0,36),(0,0,0),(0,0,0)];
	if(isdefined(self.var_1198.var_FEF0) && self.var_1198.var_FEF0 == param_00)
	{
		return self.var_1198.var_FEEF;
	}

	var_06 = [];
	var_07 = undefined;
	switch(param_00.type)
	{
		case "Cover Stand":
		case "Conceal Stand":
			var_07 = var_03;
			break;

		case "Cover Crouch Window":
		case "Cover Crouch":
		case "Conceal Crouch":
			var_07 = var_04;
			break;

		case "Cover Left":
		case "Cover Right":
			var_07 = var_05;
			break;

		default:
			return param_01;
	}

	foreach(var_09 in param_01)
	{
		if(var_09 == "full exposed")
		{
			var_06[var_06.size] = "full exposed";
			continue;
		}

		for(var_0A = 0;var_0A < var_02.size;var_0A++)
		{
			if(var_02[var_0A] == var_09)
			{
				break;
			}
		}

		var_0B = var_07[var_0A];
		var_0C = rotatevector(var_0B,param_00.angles) + param_00.origin;
		var_0D = anglestoforward(param_00.angles);
		var_0E = var_0C + var_0D * 32;
		if(sighttracepassed(var_0C,var_0E,0,undefined))
		{
			var_06[var_06.size] = var_09;
			continue;
		}
	}

	self.var_1198.var_FEF0 = param_00;
	self.var_1198.var_FEEF = var_06;
	return var_06;
}

//Function Number: 61
func_471E(param_00)
{
	if(!isdefined(self.var_10C))
	{
		return level.var_6AD5;
	}

	var_01 = self getentitynumber() * 3 % 1000;
	var_02 = 8000 + var_01;
	var_03 = 5000 + var_01;
	var_04 = 1000;
	if(lib_0A1A::func_232A("cover_trans","end"))
	{
		self.var_3135.var_C2.var_11933 = gettime();
	}

	var_05 = self.var_3135.var_C2.var_11933;
	var_06 = gettime() - var_05;
	var_07 = self.var_3135.var_C2.var_205;
	if(isdefined(self.var_280A))
	{
		func_4748(param_00);
		if(scripts\common\utility::func_9EB4(var_07) || scripts\common\utility::func_9EB7(var_07))
		{
			lib_0A1B::func_295E("B");
		}
		else
		{
			lib_0A1B::func_295E("full exposed");
		}

		func_F6A4("exposed");
		if(func_10067(param_00,0) == level.var_111AE)
		{
			lib_0A1B::func_2969(1);
		}
		else
		{
			lib_0A1B::func_2969(0);
		}

		return level.var_E87A;
	}

	if(func_10067(param_00,0) == level.var_111AE && var_06 > var_04)
	{
		return level.var_6AD5;
	}

	var_08 = undefined;
	var_09 = undefined;
	var_0A = undefined;
	if(scripts\common\utility::func_167E())
	{
		var_0B = self.var_10C.origin + scripts\anim\utility_common::func_7E8D() / 2;
		var_0C = var_0B - self geteye();
		if(scripts\common\utility::func_9EB8(var_07))
		{
			var_0A = vectortoangles(var_0C);
		}
		else if(scripts\common\utility::func_9EB1(var_07))
		{
			var_08 = func_77C3(var_07,self.var_1491.var_D6A5);
			var_0C = rotatevectorinverted(var_0C,var_07.angles);
			var_0A = vectortoangles(var_0C);
			var_0D = angleclamp180(var_0A[0]);
			var_0E = angleclamp180(var_0A[1]);
			if(var_0D > var_08[1] || var_0D < var_08[0])
			{
				return level.var_6AD5;
			}

			if(var_0E > var_08[3] || var_0E < var_08[2])
			{
				return level.var_6AD5;
			}
		}
	}
	else
	{
		var_09 = func_7E40(var_08,self.var_1491.var_D6A5);
		var_0F = var_08.origin + scripts\anim\utility_common::func_7FFC(var_08);
		var_0C = scripts\anim\utility_common::func_7E8D() - var_0F;
		var_0A = vectortoangles(var_0C);
		var_09 = angleclamp180(var_0A[1] - var_07.angles[1]);
		if(var_09 < var_08[0] || var_09 > var_08[1])
		{
			return level.var_6AD5;
		}
	}

	var_10 = func_4748(param_00);
	if(!isdefined(self.var_3135.var_FECD.var_29AF))
	{
		if(!var_10)
		{
			if(var_06 > var_03)
			{
				return level.var_6AD5;
			}
		}
		else if(var_06 > var_02)
		{
			return level.var_6AD5;
		}
	}

	if(scripts\common\utility::func_9EB4(var_07) || scripts\common\utility::func_9EB7(var_07))
	{
		var_11 = lib_0A1B::func_2929();
		var_12 = func_7E42() == "exposed";
		var_13 = !isdefined(var_11) || var_12;
		if(!var_13)
		{
			var_13 = randomint(100) < 20;
		}

		var_14 = isdefined(var_11) && var_11 == "lean" && var_12;
		var_15 = [];
		if(func_38C5() && var_08[2] <= var_09 && var_09 <= var_08[3])
		{
			if(var_14)
			{
				lib_0A1B::func_295E("lean");
				return level.var_E87A;
			}
			else if(!var_12 && var_13 || var_11 != "lean")
			{
				var_15[var_15.size] = "lean";
			}
		}
		else if(var_14)
		{
			return level.var_6AD5;
		}

		if(isdefined(var_11) && func_7E42() == "exposed")
		{
			if(var_11 == "A")
			{
				var_08[4] = var_08[4] - 5;
				var_08[5] = var_08[5] + 5;
			}
			else
			{
				var_08[4] = var_08[4] + 5;
				var_08[5] = var_08[5] - 5;
			}
		}

		if(var_08[4] <= var_09 && var_09 <= var_08[5])
		{
			if(var_13 || var_11 != "A")
			{
				var_15[var_15.size] = "A";
			}
		}
		else if(var_13 || var_11 != "B")
		{
			if(func_8C20(var_07))
			{
				var_15[var_15.size] = "B";
			}
			else if(var_15.size == 0)
			{
				return level.var_6AD5;
			}
		}

		var_16 = undefined;
		if(var_15.size == 0)
		{
			var_16 = var_11;
		}
		else
		{
			var_16 = var_15[randomint(var_15.size)];
		}

		lib_0A1B::func_295E(var_16);
	}
	else if(var_08.type == "Cover 3D")
	{
		var_11 = lib_0A1B::func_2929();
		if(!isdefined(var_11) || func_7E42() != "exposed")
		{
			lib_0A1B::func_295E("exposed");
		}
	}
	else
	{
		var_11 = lib_0A1B::func_2929();
		var_17 = lib_0A1B::func_294C();
		if(!isdefined(var_11) || func_7E42() != "exposed")
		{
			var_16 = undefined;
			if(scripts\common\utility::func_9EB3(var_07))
			{
				var_18 = scripts\anim\utility_common::func_7E8D();
				var_19 = angleclamp180(var_0A[0]);
				if(var_19 > 25 || var_19 > 10 && var_17)
				{
					var_16 = "leanover";
				}
				else if(var_19 > 10)
				{
					var_16 = "full exposed";
				}
			}

			if(!isdefined(var_16))
			{
				var_1A = var_07 method_8169();
				var_15 = ["full exposed"];
				foreach(var_1C in var_1A)
				{
					if(var_1C == "over")
					{
						var_15[var_15.size] = "exposed";
						continue;
					}

					if(function_02FA(var_07,var_1C))
					{
						var_15[var_15.size] = var_1C;
					}
				}

				if(var_17)
				{
					var_15 = func_4B0B(var_07,var_15);
				}

				var_16 = var_15[randomint(var_15.size)];
			}

			lib_0A1B::func_295E(var_16);
		}
	}

	func_F6A4("exposed");
	return level.var_E87A;
}

//Function Number: 62
func_4748(param_00)
{
	var_01 = lib_0A06::func_10076();
	if(!var_01)
	{
		return 0;
	}

	var_02 = self.var_3135.var_FECD;
	if(self method_805F(self.var_10C))
	{
		var_02.var_D699 = self.var_10C method_815B();
		var_02.var_65D3 = self.var_10C;
	}
	else
	{
		var_02.var_D699 = self.var_8451;
		var_02.var_65D3 = undefined;
	}

	if(!isdefined(var_02.var_C274))
	{
		var_02.var_C274 = "normal";
	}

	lib_0A1B::func_2983(var_02,self.var_10C);
	if(lib_0A06::func_9D2E())
	{
		if(!self.var_3135.var_B117)
		{
			lib_0A06::func_E259();
			lib_0A06::func_3EF9(var_02);
			lib_0A06::func_3EE3(var_02);
		}

		lib_0A06::func_3EF8(var_02);
		self.var_3135.var_B117 = 1;
	}
	else
	{
		self.var_3135.var_B117 = 0;
	}

	if(!isdefined(var_02.var_D699) && !isdefined(var_02.var_65D3))
	{
		self.var_3135.var_B117 = 0;
		lib_0A1B::func_2962(0);
		return 0;
	}

	lib_0A1B::func_2962(self.var_3135.var_B117);
	return 1;
}

//Function Number: 63
func_9DDA(param_00)
{
	if(!isdefined(self.var_10C))
	{
		return level.var_6AD5;
	}

	if(distancesquared(self.var_10C.origin,self.var_46A6) < 256)
	{
		return level.var_6AD5;
	}

	if(scripts\anim\utility_common::func_3908())
	{
		return level.var_111AE;
	}

	return level.var_6AD5;
}

//Function Number: 64
func_F7B4()
{
	if(isdefined(self.var_3135.var_C2))
	{
		self.var_3135.var_C2.var_BFA5 = gettime() + randomintrange(3000,12000);
	}
}

//Function Number: 65
func_3875()
{
	if(self.team == "allies")
	{
		return 0;
	}

	if(self.var_12BA4 == "c6")
	{
		return 0;
	}

	if(!scripts\anim\weaponlist::func_1310F())
	{
		return 0;
	}

	if(weaponclass(self.var_394) == "mg")
	{
		return 0;
	}

	if(isdefined(self.var_5507) && self.var_5507 == 1)
	{
		return 0;
	}

	if(isdefined(self.var_3135.var_C2.var_205.var_EE79) && self.var_3135.var_C2.var_205.var_EE79 == "no_blindfire")
	{
		return 0;
	}

	var_00 = self.var_3135.var_C2.var_205.type;
	switch(var_00)
	{
		case "Cover Right":
			return self.var_1491.var_D6A5 == "stand";

		case "Cover Left":
			return self.var_1491.var_D6A5 == "stand";

		case "Cover Prone":
		case "Conceal Prone":
		case "Conceal Stand":
		case "Conceal Crouch":
			return 0;

		case "Cover Stand":
			var_01 = self.var_205 method_8169();
			for(var_02 = 0;var_02 < var_01.size;var_02++)
			{
				if(var_01[var_02] == "over")
				{
					return 1;
				}
			}
			return 0;
	}

	return 1;
}

//Function Number: 66
func_FFCC(param_00)
{
	if(!func_3875())
	{
		return level.var_6AD5;
	}

	if(gettime() < self.var_3135.var_C2.var_BFA5)
	{
		return level.var_6AD5;
	}

	if(!func_9DDA() && !scripts\anim\utility_common::func_3918())
	{
		return level.var_6AD5;
	}

	return level.var_111AE;
}

//Function Number: 67
func_4711(param_00)
{
	if(lib_0A1A::func_232A("cover_blindfire","end"))
	{
		return level.var_111AE;
	}

	lib_0A1B::func_295D(1);
	return level.var_E87A;
}

//Function Number: 68
func_116F0(param_00)
{
	lib_0A1B::func_295D(0);
	func_F7B4();
}

//Function Number: 69
func_100AD(param_00)
{
	if(!isdefined(self.var_10C))
	{
		return level.var_6AD5;
	}

	if(self.var_162 <= 0)
	{
		return level.var_6AD5;
	}

	if(self.var_166 == "none")
	{
		return level.var_6AD5;
	}

	if(isdefined(self.var_10C) && isdefined(self.var_10C.var_5963))
	{
		return level.var_6AD5;
	}

	var_01 = self.var_3135.var_C2.var_205;
	if(var_01.type == "Cover Prone" || var_01.type == "Conceal Prone")
	{
		return level.var_6AD5;
	}

	if(scripts\common\utility::istrue(self.var_C062))
	{
		return level.var_6AD5;
	}

	var_02 = self.var_10C;
	var_03 = anglestoforward(var_01.angles);
	var_04 = var_02.origin - self.origin;
	var_05 = lengthsquared(var_04);
	var_06 = 2560000;
	if(var_05 > var_06)
	{
		return level.var_6AD5;
	}

	var_07 = vectornormalize(var_04);
	if(vectordot(var_03,var_07) < 0)
	{
		return level.var_6AD5;
	}

	var_08 = 0.4;
	var_09 = gettime();
	if(isdefined(self.var_3135.var_C2.var_A992) && var_09 < self.var_3135.var_C2.var_A992 + var_08)
	{
		return level.var_6AD5;
	}

	self.var_3135.var_C2.var_A992 = var_09;
	if(self.var_FC && !scripts\anim\utility_common::func_DDC9())
	{
		return level.var_6AD5;
	}

	if(isdefined(self.var_595D) || isdefined(var_02.var_5951))
	{
		return level.var_6AD5;
	}

	lib_0A18::func_F62B(self.var_10C);
	if(!lib_0A18::func_85B5(var_02))
	{
		return level.var_6AD5;
	}

	if(scripts\anim\utility_common::func_3908())
	{
		if(!self method_81A2(var_02,var_02.origin))
		{
			return level.var_6AD5;
		}

		return level.var_111AE;
	}

	if(scripts\anim\utility_common::func_3918())
	{
		return level.var_111AE;
	}

	if(!self method_81A2(var_02,var_02.origin))
	{
		return level.var_6AD5;
	}

	return level.var_111AE;
}

//Function Number: 70
func_98DB(param_00)
{
	lib_0A1B::func_296C(1,self.var_10C);
	func_F6A4("hide");
	self.var_3135.var_9928[param_00] = gettime() + 3000;
}

//Function Number: 71
func_474F(param_00)
{
	if(lib_0A1A::func_232A("throwgrenade","end"))
	{
		return level.var_111AE;
	}

	if(lib_0A1A::func_232A("throwgrenade","start",0))
	{
		self.var_3135.var_9928[param_00] = self.var_3135.var_9928[param_00] + 10000;
	}

	if(gettime() > self.var_3135.var_9928[param_00])
	{
		return level.var_6AD5;
	}

	return level.var_E87A;
}

//Function Number: 72
func_11700(param_00)
{
	lib_0A1B::func_296C(0);
	self.var_3135.var_9928[param_00] = undefined;
}

//Function Number: 73
func_6574(param_00)
{
	if(!isdefined(param_00))
	{
		return 0;
	}

	if(param_00 scripts\common\utility::func_9DFB())
	{
		return 1;
	}

	if(isplayer(param_00))
	{
		if(isdefined(param_00.health) && param_00.health < param_00.maxhealth)
		{
			return 1;
		}
	}
	else if(isai(param_00) && param_00 scripts\anim\utility_common::func_9F8F())
	{
		return 1;
	}

	if(isdefined(param_00.var_9F21) && param_00.var_9F21)
	{
		return 1;
	}

	return 0;
}

//Function Number: 74
func_B4ED(param_00,param_01)
{
	if(isdefined(self.var_29CF) && self.var_29CF)
	{
		return level.var_6AD5;
	}

	if(!isdefined(self.var_10C))
	{
		return level.var_6AD5;
	}

	if(!isdefined(self.var_205))
	{
		return level.var_6AD5;
	}

	if(scripts\common\utility::func_9EB2(self.var_205))
	{
		return level.var_6AD5;
	}

	if(self.var_132 || self.var_FC || self.var_1A3)
	{
		return level.var_6AD5;
	}

	if(isdefined(self.var_1198.var_474D) && self.var_1198.var_474D != "hide")
	{
		return level.var_6AD5;
	}

	var_02 = 16;
	if(!isdefined(self.var_233))
	{
		var_02 = 3600;
	}

	if(distancesquared(self.origin,self.var_205.origin) > var_02)
	{
		return level.var_6AD5;
	}

	var_03 = gettime();
	if(isdefined(self.var_1198.var_1016E) && var_03 < self.var_1198.var_1016E + 500)
	{
		return level.var_6AD5;
	}

	if(var_03 < self.var_3135.var_C2.var_BF8A)
	{
		return level.var_6AD5;
	}

	if(isdefined(param_01) && param_01)
	{
		if(randomint(3) == 0)
		{
			return level.var_6AD5;
		}
	}

	return level.var_111AE;
}

//Function Number: 75
func_2546(param_00)
{
	var_01 = self method_80E8();
	if(!isdefined(var_01))
	{
		return level.var_6AD5;
	}

	if(var_01 == self.var_205 || var_01 == self.var_3135.var_C2.var_205)
	{
		return level.var_6AD5;
	}

	if(distancesquared(self.var_205.origin,var_01.origin) < 16)
	{
		return level.var_6AD5;
	}

	var_02 = self.var_1A4;
	self.var_1A4 = 0;
	var_03 = self method_83D4(var_01);
	if(!var_03)
	{
		self.var_1A4 = var_02;
		return level.var_6AD5;
	}

	self.var_1198.var_10171 = var_01;
	self.var_1198.var_1016E = gettime();
	self.var_1198.var_1016B = self.var_3135.var_C2.var_205;
	return level.var_E87A;
}

//Function Number: 76
func_453E(param_00)
{
	if(isdefined(self.var_3135.var_C2) && weaponclass(self.var_394) == "mg" && isdefined(self.var_10C) && distancesquared(self.origin,self.var_10C.origin) < 65536)
	{
		if(isdefined(self.var_101B4))
		{
			lib_0A1B::func_2970(weaponclass(self.var_101B4));
		}
	}

	return level.var_111AE;
}

//Function Number: 77
func_12E5D(param_00)
{
	if(isdefined(self.var_280A))
	{
		if(self.health < self.maxhealth * 0.75)
		{
			self.var_280A = undefined;
		}
		else if(isdefined(self.var_1198.var_EF3B) && self.var_1198.var_EF3B.size >= 2)
		{
			self.var_280A = undefined;
		}
	}

	return level.var_111AE;
}

//Function Number: 78
func_9D40(param_00)
{
	return isdefined(self.var_280A);
}