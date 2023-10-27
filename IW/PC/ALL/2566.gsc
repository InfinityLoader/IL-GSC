/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 2566.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 68
 * Decompile Time: 13 ms
 * Timestamp: 10/27/2023 12:23:21 AM
*******************************************************************/

//Function Number: 1
func_12E91(param_00)
{
	lib_0A1B::func_2970(weaponclass(self.var_D8E1));
	func_12F28(param_00);
	var_01 = lib_0A1A::func_233E("ai_notify","bulletwhizby");
	if(isdefined(var_01))
	{
		if(!isdefined(self.var_55B5))
		{
			var_02 = var_01.var_C8F0[0];
			var_03 = isdefined(var_02) && distancesquared(self.origin,var_02.origin) < 160000;
			if(var_03 || scripts\common\utility::func_4347())
			{
				lib_0A1B::func_2971(var_01);
			}
		}
	}
	else
	{
		var_04 = 100;
		var_01 = lib_0A1B::func_292F();
		if(!isdefined(var_01) || gettime() > var_01.var_7686 + var_04)
		{
			lib_0A1B::func_2971(undefined);
		}
	}

	self.var_1C4 = undefined;
	return level.var_111AE;
}

//Function Number: 2
func_FFC8()
{
	if(isdefined(self.var_7360))
	{
		return self.var_7360;
	}

	return 0;
}

//Function Number: 3
func_12E90(param_00)
{
	if(!isalive(self))
	{
		self.var_1491.var_10E19 = "death";
		return level.var_6AD5;
	}

	lib_0A1B::func_297E(func_8BEC(undefined) == level.var_111AE);
	if(scripts\anim\utility_common::func_9D4D())
	{
		self.var_1198.var_32D2 = 1;
	}
	else
	{
		self.var_1198.var_32D2 = undefined;
	}

	if(weaponclass(self.var_394) == "pistol")
	{
		lib_0A19::func_12F5C(param_00);
	}

	var_01 = func_7FD3();
	lib_0A1B::func_2968(var_01);
	if(lib_0A1B::func_2955())
	{
		self.var_1491.var_10E19 = "move";
	}
	else if(isdefined(lib_0A1B::func_2920()))
	{
		self.var_1491.var_10E19 = "cover";
	}
	else if(lib_0A1B::func_2941())
	{
		self.var_1491.var_10E19 = "combat";
	}
	else
	{
		self.var_1491.var_10E19 = "stop";
	}

	return level.var_111AE;
}

//Function Number: 4
func_12F64(param_00)
{
	var_01 = lib_0A1A::func_233E("ai_notify","bulletwhizby");
	if(isdefined(var_01) && isdefined(self.var_1491))
	{
		if(randomfloat(1) < self.var_1491.var_DD61)
		{
			lib_0A1B::func_2971(var_01);
		}
	}
	else
	{
		var_02 = 100;
		var_01 = lib_0A1B::func_292F();
		if(!isdefined(var_01) || gettime() > var_01.var_7686 + var_02)
		{
			lib_0A1B::func_2971(undefined);
		}
	}

	return level.var_111AE;
}

//Function Number: 5
func_12F28(param_00)
{
	var_01 = self [[ self.var_71A6 ]]();
	var_02 = lib_0A1B::func_292C();
	var_03 = [];
	var_03["prone"] = 0;
	var_03["crouch"] = 1;
	var_03["stand"] = 2;
	var_04 = lib_0A02::func_75();
	if(isdefined(self.var_233))
	{
		var_02 = "stand";
	}

	if(!isdefined(var_01))
	{
		var_01 = var_02;
	}

	if(var_04 == "casual" || var_04 == "casual_gun")
	{
		lib_0A1B::func_296A("stand");
	}
	else if(var_01 == "prone" && self.var_12BA4 == "c6")
	{
		lib_0A1B::func_296A("crouch");
	}
	else
	{
		if(var_03[var_01] < var_03[var_02])
		{
			var_02 = var_01;
		}
		else if(var_02 == "crouch" && var_03[var_01] > var_03["crouch"])
		{
			if(lib_0A1B::func_2940())
			{
				var_02 = "stand";
			}
		}

		lib_0A1B::func_296A(var_02);
	}

	return level.var_111AE;
}

//Function Number: 6
func_12E93(param_00)
{
	if(!isdefined(self.var_71D5))
	{
		return level.var_111AE;
	}

	var_01 = self [[ self.var_71D5 ]]();
	return var_01;
}

//Function Number: 7
func_7FD3()
{
	var_00 = self [[ self.var_71A8 ]]();
	return var_00;
}

//Function Number: 8
func_9E40(param_00)
{
	return func_8BEC(param_00);
}

//Function Number: 9
func_8BEC(param_00)
{
	if(isdefined(self.var_10C))
	{
		return level.var_111AE;
	}

	return level.var_6AD5;
}

//Function Number: 10
func_8C0B(param_00)
{
	if(!isdefined(self.var_10C))
	{
		return level.var_6AD5;
	}

	if(self method_805F(self.var_10C))
	{
		return level.var_111AE;
	}

	return level.var_6AD5;
}

//Function Number: 11
func_8BC8()
{
	var_00 = func_81F4();
	if(isdefined(var_00))
	{
		return 1;
	}

	if(!isdefined(self.var_394))
	{
		return 0;
	}

	if(self.var_3250 > 0 || isdefined(self.var_C08B))
	{
		return 1;
	}

	return 0;
}

//Function Number: 12
func_8BC6(param_00)
{
	if(func_8BC8())
	{
		return level.var_111AE;
	}

	return level.var_6AD5;
}

//Function Number: 13
func_9E8B(param_00,param_01)
{
	if(scripts\anim\utility_common::func_BE9E(param_01))
	{
		return level.var_111AE;
	}

	return level.var_6AD5;
}

//Function Number: 14
func_13D98(param_00,param_01)
{
	if(!isdefined(self.var_10C))
	{
		return level.var_6AD5;
	}

	if(distancesquared(self.origin,self.var_10C.origin) <= param_01 * param_01)
	{
		return level.var_111AE;
	}

	return level.var_6AD5;
}

//Function Number: 15
func_8BF6(param_00)
{
	if(self.var_162 > 0)
	{
		return level.var_111AE;
	}

	return level.var_6AD5;
}

//Function Number: 16
func_8C24(param_00)
{
	if(isdefined(self.var_166) && self.var_166 == "seeker")
	{
		if(self.var_162 > 0)
		{
			return level.var_111AE;
		}
	}

	return level.var_6AD5;
}

//Function Number: 17
func_B4EB(param_00)
{
	if(!isdefined(self.var_394))
	{
		return level.var_6AD5;
	}

	if(!func_10076())
	{
		return level.var_6AD5;
	}

	return level.var_111AE;
}

//Function Number: 18
func_12EC2(param_00)
{
	if(!isdefined(self.var_1C4) || self.var_1C4 != self.var_10C)
	{
		self.var_1C4 = self.var_10C;
	}

	return level.var_111AE;
}

//Function Number: 19
func_FE5A(param_00)
{
	param_00.var_29AF = undefined;
}

//Function Number: 20
func_FE5D(param_00)
{
	param_00.var_29AF = 1;
}

//Function Number: 21
func_FE6E(param_00)
{
	self.var_3135.var_FECD = spawnstruct();
	self.var_3135.var_FECD.var_1158F = param_00;
	self.var_3135.var_FECD.var_10DFF = gettime();
	self.var_3135.var_B117 = 0;
	self.var_1C4 = self.var_10C;
	self.var_299D = self.var_10C;
	var_01 = scripts\anim\utility_common::func_9D4D();
	if(var_01)
	{
		func_FE5D(self.var_3135.var_FECD);
		self.var_103BF = 0;
		self.var_103BA = 0;
	}
}

//Function Number: 22
func_FE83(param_00)
{
	if(isdefined(self.var_3135.var_FECD) && self.var_3135.var_FECD.var_1158F == param_00)
	{
		self.var_3135.var_FECD = undefined;
	}

	self.var_3135.var_B117 = 0;
	self.var_299D = undefined;
	lib_0A1B::func_2962(0);
}

//Function Number: 23
func_9D2E()
{
	if(isdefined(self.var_71AE))
	{
		return self [[ self.var_71AE ]]();
	}

	return 0;
}

//Function Number: 24
func_E259()
{
	if(isdefined(self.var_71CA))
	{
		return self [[ self.var_71CA ]]();
	}
}

//Function Number: 25
func_811C()
{
	if(isdefined(self.var_71A9))
	{
		return self [[ self.var_71A9 ]]();
	}

	return 0;
}

//Function Number: 26
func_81E2(param_00)
{
	if(isdefined(self.var_71AA))
	{
		return self [[ self.var_71AA ]](param_00);
	}

	return 0;
}

//Function Number: 27
func_FE88(param_00)
{
	if(lib_0A1A::func_232A("shoot","shoot_finished"))
	{
		return level.var_111AE;
	}

	var_01 = self.var_3135.var_FECD;
	var_02 = func_81F4();
	if(isdefined(self.var_10C) && !isplayer(self.var_10C) && var_01.var_10DFF < gettime())
	{
		var_03 = int(gettime() / 50);
		if(self getentitynumber() % 4 != var_03 % 4)
		{
			return level.var_E87A;
		}
	}

	if(isdefined(var_02))
	{
		var_04 = func_81E2(var_02);
		var_05 = anglestoforward(var_04);
		var_05 = rotatevector(var_05,self.angles);
		var_06 = func_811C();
		var_01.var_D699 = var_06 + var_05 * 512;
		var_01.var_65D3 = undefined;
	}
	else if(isdefined(self.var_8451))
	{
		var_01.var_D699 = self.var_8451;
		var_01.var_65D3 = undefined;
	}
	else if(self method_805F(self.var_10C))
	{
		var_01.var_D699 = self.var_10C method_815B();
		var_01.var_65D3 = self.var_10C;
	}
	else
	{
		return level.var_111AE;
	}

	if(!isdefined(var_01.var_C274))
	{
		var_01.var_C274 = "normal";
	}

	lib_0A1B::func_2983(var_01,self.var_10C);
	if(func_9D2E())
	{
		if(!self.var_3135.var_B117)
		{
			func_E259();
			func_3EF9(var_01);
			func_3EE3(var_01);
		}

		func_3EF8(var_01);
		self.var_3135.var_B117 = 1;
	}
	else
	{
		self.var_3135.var_B117 = 0;
	}

	if(!isdefined(var_01.var_D699) && !isdefined(var_01.var_65D3))
	{
		return level.var_111AE;
	}

	lib_0A1B::func_2962(self.var_3135.var_B117);
	return level.var_E87A;
}

//Function Number: 28
func_8BCE(param_00)
{
	if(self.var_394 == "none")
	{
		return 0;
	}

	return self.var_3250 >= weaponclipsize(self.var_394) * param_00;
}

//Function Number: 29
func_43EB(param_00)
{
	if(!isdefined(self.var_394) || self.var_394 == "none")
	{
		return level.var_6AD5;
	}

	if(!isdefined(self.var_10C))
	{
		if(!func_8BCE(0.5))
		{
			return level.var_111AE;
		}
	}

	if(!func_8BC8())
	{
		return level.var_111AE;
	}

	if(func_8BCE(0.1))
	{
		return level.var_6AD5;
	}

	if(isdefined(self.var_233))
	{
		if(isdefined(self.var_C0A0) && self.var_C0A0)
		{
			return level.var_6AD5;
		}

		if(isdefined(self.var_C0AD) && self.var_C0AD)
		{
			return level.var_6AD5;
		}

		if(!scripts\anim\utility_common::func_1311A())
		{
			return level.var_6AD5;
		}

		if(self method_841E() < 256)
		{
			return level.var_6AD5;
		}
	}

	if(isdefined(self.var_10C) && isdefined(self.var_101B4) && !scripts\common\utility::istrue(self.var_C009))
	{
		var_01 = 409;
		var_02 = distancesquared(self.origin,self.var_10C.origin);
		if(var_02 < var_01 * var_01)
		{
			return level.var_6AD5;
		}
	}

	return level.var_111AE;
}

//Function Number: 30
func_DF53(param_00)
{
	lib_0A1B::func_2969(1);
	self.var_3135.var_9928[param_00] = spawnstruct();
	self.var_3135.var_9928[param_00].var_2AB1 = isdefined(self.var_233);
	self.var_3135.var_9928[param_00].var_11901 = gettime() + 5000;
}

//Function Number: 31
func_DF55(param_00)
{
	lib_0A1B::func_2969(0);
	self.var_3135.var_9928[param_00] = undefined;
}

//Function Number: 32
func_DF4E()
{
	var_00 = weaponclipsize(self.var_394);
	self.var_3250 = int(var_00 * 0.5);
	self.var_3250 = int(clamp(self.var_3250,0,var_00));
}

//Function Number: 33
func_DF56(param_00)
{
	if(lib_0A1A::func_232A("reload","end"))
	{
		return level.var_111AE;
	}

	if(gettime() > self.var_3135.var_9928[param_00].var_11901)
	{
		return level.var_111AE;
	}

	var_01 = weaponclipsize(self.var_394);
	var_02 = isdefined(self.var_1198.var_32D2);
	if(!var_02 && self.var_3250 == var_01)
	{
		return level.var_111AE;
	}

	if(isdefined(self.var_C08B))
	{
		func_DF4E();
		return level.var_111AE;
	}

	if(isdefined(self.var_233) && !self.var_12A && !scripts\common\utility::func_167E())
	{
		func_DF4E();
		return level.var_111AE;
	}

	var_03 = self.var_3135.var_9928[param_00].var_2AB1;
	if(!var_03 && isdefined(self.var_233))
	{
		func_DF4E();
		return level.var_111AE;
	}

	return level.var_E87A;
}

//Function Number: 34
func_3EF9(param_00)
{
	var_01 = -3036;
	var_02 = 810000;
	var_03 = 2560000;
	var_04 = weaponclass(self.var_394);
	var_05 = func_81F4();
	var_06 = isdefined(var_05);
	if(isdefined(self.var_3135.var_FEDB))
	{
		var_07 = 0;
		if(isdefined(self.var_3135.var_FED8))
		{
			var_07 = self.var_3135.var_FED8;
		}

		return func_F840(param_00,self.var_3135.var_FEDB,var_07);
	}

	if(var_05 == "mg" || var_07)
	{
		return func_F840(var_01,"mg",0);
	}

	if(isdefined(var_01.var_65D3) && isdefined(var_01.var_65D3.var_10C) && isdefined(var_01.var_65D3.var_10C.var_2DC))
	{
		return func_F840(var_01,"single",0);
	}

	if(scripts\anim\utility_common::func_9D4D())
	{
		return func_F840(var_01,"single",0);
	}

	if(var_05 == "rocketlauncher" || var_05 == "pistol")
	{
		return func_F840(var_01,"single",0);
	}

	if(scripts\anim\utility_common::func_9F4F(self.var_394))
	{
		if(scripts\anim\utility_common::func_13C40())
		{
			return func_F840(var_01,"single",0);
		}
		else
		{
			return func_F840(var_01,"semi",0);
		}
	}

	if(var_05 == "grenade")
	{
		return func_F840(var_01,"single",0);
	}

	if(function_023C(self.var_394) > 0)
	{
		return func_F840(var_01,"burst",0);
	}

	var_08 = distancesquared(self method_815B(),var_01.var_D699);
	if(var_08 < var_02)
	{
		if(isdefined(var_01.var_65D3) && isdefined(var_01.var_65D3.var_B14F))
		{
			return func_F840(var_01,"single",0);
		}
		else
		{
			return func_F840(var_01,"full",0);
		}
	}
	else if(var_08 < var_03 || func_FFC6())
	{
		if(function_0248(self.var_394) || func_FFF6())
		{
			return func_F840(var_01,"semi",1);
		}
		else
		{
			return func_F840(var_01,"burst",1);
		}
	}
	else if(self.var_251 || var_08 < var_04)
	{
		if(func_FFF6())
		{
			return func_F840(var_01,"semi",0);
		}
		else
		{
			return func_F840(var_01,"burst",0);
		}
	}

	return func_F840(var_01,"single",0);
}

//Function Number: 35
func_F840(param_00,param_01,param_02)
{
	param_00.var_1119D = param_01;
	param_00.var_6B92 = param_02;
}

//Function Number: 36
func_FFC6()
{
	if(!isdefined(level.var_7683))
	{
		return 0;
	}

	return level.var_7683 == 3 && isplayer(self.var_10C);
}

//Function Number: 37
func_FFF6()
{
	if(weaponclass(self.var_394) != "rifle")
	{
		return 0;
	}

	if(self.team != "allies")
	{
		return 0;
	}

	var_00 = scripts\anim\utility_common::func_EA26(int(self.origin[1]),10000) + 2000;
	var_01 = int(self.origin[0]) + gettime();
	return var_01 % 2 * var_00 > var_00;
}

//Function Number: 38
func_81F4()
{
	if(isdefined(self.var_71AB))
	{
		return [[ self.var_71AB ]]();
	}
}

//Function Number: 39
func_4F68()
{
	var_00 = func_81F4();
	var_01 = isdefined(var_00);
	if(var_01 && isdefined(var_00.var_ED26))
	{
		var_02 = var_00.var_ED26;
	}
	else
	{
		var_02 = 0.5;
	}

	if(var_01 && isdefined(var_00.var_ED25))
	{
		var_03 = var_00.var_ED25 - var_02;
	}
	else
	{
		var_03 = 1.5;
	}

	var_04 = var_02 + randomfloat(var_03);
	return int(var_04 * 10);
}

//Function Number: 40
func_4F66()
{
	if(isdefined(self.var_71A0))
	{
		return [[ self.var_71A0 ]]();
	}
}

//Function Number: 41
func_3EE3(param_00)
{
	if(isdefined(self.var_10C) && distancesquared(self.origin,self.var_10C.origin) > 160000)
	{
		param_00.var_32BD = randomintrange(1,5);
	}
	else
	{
		param_00.var_32BD = 10;
	}

	if(param_00.var_1119D == "full")
	{
		param_00.var_FF0B = func_4F66();
		return;
	}

	if(param_00.var_1119D == "burst" || param_00.var_1119D == "semi")
	{
		param_00.var_FF0B = func_4F65(param_00);
		return;
	}

	if(param_00.var_1119D == "single")
	{
		param_00.var_FF0B = 1;
		return;
	}

	if(param_00.var_1119D == "mg")
	{
		param_00.var_FF0B = func_4F68();
		return;
	}
}

//Function Number: 42
func_4F65(param_00)
{
	var_01 = 0;
	var_02 = function_023C(self.var_394);
	if(var_02)
	{
		var_01 = var_02;
	}
	else if(scripts\anim\weaponlist::func_1311D())
	{
		var_01 = level.var_F217[randomint(level.var_F217.size)];
	}
	else if(param_00.var_6B92)
	{
		var_01 = level.var_6B93[randomint(level.var_6B93.size)];
	}
	else
	{
		var_01 = level.var_32BF[randomint(level.var_32BF.size)];
	}

	if(var_01 <= self.var_3250)
	{
		return var_01;
	}

	if(self.var_3250 <= 0)
	{
		return 1;
	}

	return self.var_3250;
}

//Function Number: 43
func_10076()
{
	if(isdefined(self.var_595D) && self.var_595D)
	{
		return 0;
	}

	if(!isdefined(self.var_10C))
	{
		return 0;
	}

	if(self.var_3250 == 0)
	{
		return 0;
	}

	if(!isdefined(self.var_394) || self.var_394 == "")
	{
		return 0;
	}

	if(self method_805F(self.var_10C))
	{
		scripts\anim\utility_common::func_5962();
		self.var_8451 = self.var_10C method_815B();
		return 1;
	}

	return scripts\anim\utility_common::func_3917();
}

//Function Number: 44
func_3EF8(param_00)
{
	if(isdefined(self.var_FED1))
	{
		if(!isdefined(self.var_10C))
		{
			param_00.var_D699 = self.var_FED1;
			self.var_FED1 = undefined;
		}
		else
		{
			self.var_FED1 = undefined;
		}
	}

	var_01 = func_FECA(param_00);
	if(isdefined(var_01) && var_01 == "retry")
	{
		var_01 = func_FECA(param_00);
	}
}

//Function Number: 45
func_FECA(param_00)
{
	if(param_00.var_C274 == "normal")
	{
		var_01 = func_FECB(param_00);
		return var_01;
	}

	if(scripts\anim\utility_common::func_10077())
	{
		var_01.var_C274 = "normal";
		return "retry";
	}

	var_02 = scripts\anim\utility_common::func_3917();
	if(var_01.var_C274 == "suppress" || self.team == "allies" && !isdefined(self.var_10C) && !var_02)
	{
		func_FECC(var_01,var_02);
	}
}

//Function Number: 46
func_FECB(param_00)
{
	if(!scripts\anim\utility_common::func_10077())
	{
		if(!isdefined(self.var_10C))
		{
			func_8C4D(param_00);
			return;
		}

		if((self.var_251 || randomint(5) > 0) && func_100A4())
		{
			param_00.var_C274 = "suppress";
		}
		else
		{
			param_00.var_C274 = "ambush";
		}

		return "retry";
	}

	func_F83F(param_00);
}

//Function Number: 47
func_100A4()
{
	return 1;
}

//Function Number: 48
func_F83F(param_00)
{
	param_00.var_65D3 = self.var_10C;
	param_00.var_D699 = param_00.var_65D3 method_815B();
}

//Function Number: 49
func_FECC(param_00,param_01)
{
	if(!param_01)
	{
		func_8C4D(param_00);
		return;
	}

	param_00.var_65D3 = undefined;
	param_00.var_D699 = func_7E90();
}

//Function Number: 50
func_7E90()
{
	return self.var_8451;
}

//Function Number: 51
func_8C4D(param_00)
{
	param_00.var_65D3 = undefined;
	param_00.var_D699 = undefined;
	param_00.var_1119D = "none";
	if(self.var_FC)
	{
		param_00.var_C274 = "ambush";
	}
}

//Function Number: 52
func_10026()
{
	if(level.var_18D5[self.team] > 0 && level.var_18D5[self.team] < level.var_18D6)
	{
		if(gettime() - level.var_A936[self.team] > 4000)
		{
			return 0;
		}

		var_00 = level.var_A933[self.team];
		if(var_00 == self)
		{
			return 0;
		}

		var_01 = isdefined(var_00) && distancesquared(self.origin,var_00.origin) < 65536;
		if((var_01 || distancesquared(self.origin,level.var_A935[self.team]) < 65536) && !isdefined(self.var_10C) || distancesquared(self.var_10C.origin,level.var_A934[self.team]) < 262144)
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 53
func_FFC2()
{
	if(self.var_132)
	{
		return 0;
	}

	if(scripts\common\utility::func_167E())
	{
		return 0;
	}

	if(!isdefined(self.var_10C))
	{
		return 0;
	}

	if(isdefined(self.var_233))
	{
		return 0;
	}

	if(weaponclass(self.var_394) == "mg")
	{
		return 0;
	}

	if(self.var_BC == "ambush" || self.var_BC == "ambush_nodes_only")
	{
		return 0;
	}

	if(isdefined(self.var_3135.var_C2))
	{
		return 0;
	}

	if(isdefined(self.script) && self.script == "cover_arrival")
	{
		return 0;
	}

	var_00 = vectornormalize(self.var_10C.origin - self.origin);
	var_01 = anglestoforward(self.angles);
	if(vectordot(var_00,var_01) < 0.5)
	{
		return 0;
	}

	if(self method_805F(self.var_10C) && self method_8061())
	{
		return 0;
	}

	return 1;
}

//Function Number: 54
func_2544(param_00)
{
	self.var_3135.var_9928[param_00] = 0;
}

//Function Number: 55
func_2542(param_00)
{
	if(isdefined(self.var_7196))
	{
		return self [[ self.var_7196 ]](param_00);
	}

	return level.var_6AD5;
}

//Function Number: 56
func_2545(param_00)
{
	self.var_3135.var_9928[param_00] = undefined;
}

//Function Number: 57
func_93B6(param_00)
{
	if(self method_8531())
	{
		return level.var_111AE;
	}

	return level.var_6AD5;
}

//Function Number: 58
func_2753(param_00)
{
	if(lib_0A1B::func_2955())
	{
		return level.var_6AD5;
	}

	var_01 = self method_8530(128);
	if(isdefined(var_01))
	{
		self method_8481(var_01);
		self.var_1198.var_2754 = gettime();
		return level.var_111AE;
	}

	return level.var_6AD5;
}

//Function Number: 59
func_1384E(param_00)
{
	var_01 = gettime();
	if(var_01 > self.var_1198.var_2754 + 100 && !isdefined(self.var_233))
	{
		return level.var_6AD5;
	}

	if(var_01 > self.var_1198.var_2754 + 5000)
	{
		return level.var_6AD5;
	}

	return level.var_E87A;
}

//Function Number: 60
func_275A(param_00)
{
	self method_8484();
	self.var_1198.var_2754 = undefined;
}

//Function Number: 61
func_24D4(param_00)
{
	if(!isdefined(self.var_F126))
	{
		return level.var_6AD5;
	}

	if(self.var_180)
	{
		return level.var_6AD5;
	}

	var_01 = distancesquared(self.var_F126.origin,self.origin);
	if(self method_805F(self.var_F126) && var_01 < 122500)
	{
		return level.var_111AE;
	}

	if(var_01 < 22500)
	{
		return level.var_111AE;
	}

	return level.var_6AD5;
}

//Function Number: 62
func_E84E(param_00)
{
	func_FE6E(param_00);
	self.var_C3BB = self.var_12E;
	self.var_C3B6 = self.var_BC;
	self.var_12E = self.var_F126;
	self.var_1C4 = self.var_F126;
	self.var_299D = self.var_F126;
	self.var_F126.var_3135.var_1152B = 1;
}

//Function Number: 63
func_13132(param_00)
{
	switch(param_00)
	{
		case "w2":
		case "w1":
		case "w0":
		case "omr":
		case "slt":
		case "5":
		case "4":
		case "3":
		case "2":
		case "0":
		case "1":
			return 1;
	}

	return 0;
}

//Function Number: 64
func_E84D(param_00)
{
	if(!isdefined(self.var_F126))
	{
		return level.var_6AD5;
	}

	if(self.var_12BA4 == "soldier")
	{
		var_01 = self.var_F126.origin;
		var_02 = vectornormalize(self.origin - var_01);
		var_03 = self.origin + var_02 * 200;
		var_04 = getclosestpointonnavmesh(var_03);
		self.var_BC = "no_cover";
		self method_8481(var_04);
	}
	else
	{
		self.var_BC = "no_cover";
		self method_8481(self.origin);
	}

	if(!isdefined(self.var_12E) || !isalive(self.var_12E) || self.var_12E != self.var_F126)
	{
		return level.var_111AE;
	}

	if(!isdefined(self.var_10C) || self.var_10C != self.var_12E)
	{
		return level.var_E87A;
	}

	var_05 = self.var_3135.var_FECD;
	if(self method_805F(self.var_10C))
	{
		var_05.var_D699 = self.var_10C method_815B();
		var_05.var_65D3 = self.var_10C;
	}
	else
	{
		return level.var_E87A;
	}

	if(!isdefined(self.var_F184))
	{
		self.var_F184 = 1;
		if(isdefined(self.var_46BC) && isdefined(self.var_C19D) && self.var_46BC == "UN" || self.var_46BC == "SD")
		{
			if(func_13132(self.var_C19D))
			{
				var_06 = self.var_46BC + "_" + self.var_C19D + "_reaction_seeker_attack";
				self playsound(var_06);
			}
		}

		func_DF4E();
	}

	if(!isdefined(var_05.var_C274))
	{
		var_05.var_C274 = "normal";
	}

	lib_0A1B::func_2983(var_05,self.var_10C);
	if(func_9D2E())
	{
		if(!self.var_3135.var_B117)
		{
			func_E259();
			func_3EF9(var_05);
			func_3EE3(var_05);
		}

		func_3EF8(var_05);
		self.var_3135.var_B117 = 1;
	}
	else
	{
		self.var_3135.var_B117 = 0;
	}

	if(!isdefined(var_05.var_D699) && !isdefined(var_05.var_65D3))
	{
		return level.var_111AE;
	}

	lib_0A1B::func_2962(self.var_3135.var_B117);
	return level.var_E87A;
}

//Function Number: 65
func_E84F(param_00)
{
	self method_8484();
	self.var_12E = self.var_C3BB;
	self.var_C3BB = undefined;
	self.var_BC = self.var_C3B6;
	self.var_C3B6 = undefined;
	self.var_F184 = undefined;
	func_FE83(param_00);
}

//Function Number: 66
func_12A82(param_00)
{
	if(isdefined(lib_0A1B::func_292D()))
	{
		return level.var_111AE;
	}

	return level.var_6AD5;
}

//Function Number: 67
func_8082()
{
	var_00 = self geteye();
	foreach(var_02 in level.players)
	{
		if(!self method_805F(var_02))
		{
			continue;
		}

		var_03 = var_02 geteye();
		var_04 = vectortoangles(var_00 - var_03);
		var_05 = anglestoforward(var_04);
		var_06 = var_02 getplayerangles();
		var_07 = anglestoforward(var_06);
		var_08 = vectordot(var_05,var_07);
		if(var_08 < 0.805)
		{
			continue;
		}

		if(scripts\common\utility::func_4347() && var_08 >= 0.996)
		{
			continue;
		}

		return var_02;
	}

	return undefined;
}

//Function Number: 68
func_12F1D(param_00)
{
	if(self.team != "axis")
	{
		return level.var_111AE;
	}

	if(isdefined(self.var_5583) && self.var_5583)
	{
		return level.var_111AE;
	}

	if(!scripts\anim\utility_common::func_9D4D())
	{
		return level.var_111AE;
	}

	var_01 = level.var_7649["sniper_glint"];
	if(!isdefined(var_01))
	{
		return level.var_111AE;
	}

	if(!isdefined(self.var_BF5C))
	{
		self.var_BF5C = gettime() + randomintrange(3000,5000);
	}

	if(!isdefined(self.var_10C) || !isalive(self.var_10C))
	{
		return level.var_111AE;
	}

	if(gettime() < self.var_BF5C)
	{
		return level.var_111AE;
	}

	self.var_BF5C = gettime() + 200;
	if(self.var_394 != self.var_D8E1)
	{
		return level.var_111AE;
	}

	var_02 = func_8082();
	if(!isdefined(var_02))
	{
		return level.var_111AE;
	}

	if(distancesquared(self.origin,var_02.origin) < 65536)
	{
		return level.var_111AE;
	}

	if(lib_0A1B::func_2985() && isdefined(self.var_1198.var_FECD.var_D699))
	{
		var_03 = self method_853C();
		var_04 = vectornormalize(self.var_1198.var_FECD.var_D699 - self geteye());
		var_05 = vectordot(var_03,var_04);
		if(var_05 < 0.906)
		{
			self.var_BF5C = undefined;
			return level.var_111AE;
		}
	}
	else
	{
		self.var_BF5C = undefined;
		return level.var_111AE;
	}

	playfxontag(var_01,self,"tag_flash");
	self.var_BF5C = gettime() + randomintrange(3000,5000);
	return level.var_111AE;
}