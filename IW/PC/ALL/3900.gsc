/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 3900.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 25
 * Decompile Time: 3 ms
 * Timestamp: 10/27/2023 12:31:10 AM
*******************************************************************/

//Function Number: 1
func_5AC0()
{
	self endon("killanimscript");
	var_00 = self method_8148();
	var_01 = var_00.var_48;
	self notify("traverse_begin",var_01,var_00);
	self waittill("traverse_end");
}

//Function Number: 2
func_3E96(param_00,param_01,param_02)
{
	if(!isdefined(param_02))
	{
		return func_3EF4(param_00,param_01,param_02);
	}

	return lib_0A1A::func_2358(param_01,param_02);
}

//Function Number: 3
func_3EB8(param_00,param_01,param_02)
{
	return 0;
}

//Function Number: 4
func_3EF4(param_00,param_01,param_02)
{
	var_03 = self method_8100(param_01);
	if(var_03 == 1)
	{
		return 0;
	}

	return randomint(var_03);
}

//Function Number: 5
func_3EB6(param_00,param_01,param_02)
{
	return func_3E96(param_00,param_01,param_02);
}

//Function Number: 6
func_CEA8(param_00,param_01,param_02,param_03)
{
	lib_0A1D::func_2364(param_00,param_01,param_02,param_03);
}

//Function Number: 7
func_B050(param_00,param_01,param_02,param_03)
{
	lib_0A1D::func_235F(param_00,param_01,param_02,1);
}

//Function Number: 8
func_136B4(param_00,param_01,param_02)
{
	self endon(param_01 + "_finished");
	self method_84BD();
	self waittill("stop_soon");
	self.var_20EE = self method_813A();
	lib_0A1A::func_2330(param_01,"cover_approach",self.var_20EE);
}

//Function Number: 9
func_136CC(param_00,param_01,param_02)
{
	self endon(param_01 + "_finished");
	self waittill("path_set");
	var_03 = self method_813A();
	var_04 = [var_03,1];
	lib_0A1A::func_2330(param_01,"sharp_turn",var_04);
	thread func_136CC(param_00,param_01,param_02);
}

//Function Number: 10
func_136E7(param_00,param_01,param_02)
{
	self endon(param_01 + "_finished");
	self waittill("path_dir_change",var_03);
	var_04 = [var_03,1];
	lib_0A1A::func_2330(param_01,"sharp_turn",var_04);
	thread func_136E7(param_00,param_01,param_02);
}

//Function Number: 11
func_D4DD(param_00,param_01,param_02,param_03)
{
	thread func_136B4(param_00,param_01,param_03);
	thread func_136E7(param_00,param_01,param_03);
	thread func_136CC(param_00,param_01,param_03);
	var_04 = 1;
	if(isdefined(self.var_2303.var_BCD6))
	{
		var_04 = self.var_2303.var_BCD6;
	}
	else if(isdefined(self.var_BCD6))
	{
		var_04 = self.var_BCD6;
	}

	lib_0A1D::func_235F(param_00,param_01,param_02,var_04);
}

//Function Number: 12
func_FFB6(param_00,param_01,param_02,param_03)
{
	if(!func_100A3(param_00,param_01,param_02,param_03))
	{
		return 1;
	}

	if(!lib_0A1B::func_2956("combat"))
	{
		return 1;
	}

	if(lib_0A1B::func_2950(param_00,param_01,param_02,param_03))
	{
		return 1;
	}

	return 0;
}

//Function Number: 13
func_100A3(param_00,param_01,param_02,param_03)
{
	if(isdefined(param_03))
	{
		if(!lib_0A1B::func_2949(param_00,param_01,param_02,param_03))
		{
			return 0;
		}
	}

	if(self.var_1198.var_1D64)
	{
		return 0;
	}

	if(!lib_0A1B::func_2956("combat"))
	{
		return 0;
	}

	if(!lib_0A1B::func_298E())
	{
		return 0;
	}

	if(!isdefined(self.var_10C))
	{
		if(!isdefined(self.var_6571))
		{
			return 0;
		}
	}

	return 1;
}

//Function Number: 14
func_9DED(param_00)
{
	if(!isdefined(param_00))
	{
		param_00 = 0.5;
	}

	var_01 = anglestoforward(self.angles);
	var_02 = vectornormalize(self.var_10C.origin - self.origin);
	var_03 = vectordot(var_01,var_02);
	if(var_03 < param_00)
	{
		return 0;
	}

	return 1;
}

//Function Number: 15
func_9FFF()
{
	if(func_9D2E())
	{
		return 1;
	}

	return 0;
}

//Function Number: 16
func_10076(param_00,param_01,param_02,param_03)
{
	if(!lib_0A1B::func_291C())
	{
		return 0;
	}

	if(isdefined(self.var_10C))
	{
		if(!func_9DED() && !func_9FFF())
		{
			return 0;
		}

		if(!self method_805F(self.var_10C))
		{
			return 0;
		}
	}

	return 1;
}

//Function Number: 17
func_3EB3(param_00,param_01,param_02)
{
	var_03 = lib_0A1A::func_233C();
	if(lib_0A1A::func_234A(var_03,"idle"))
	{
		var_04 = lib_0A1A::func_233D(var_03,"idle");
		if(isarray(var_04))
		{
			return var_04[randomint(var_04.size)];
		}

		return var_04;
	}

	return func_3EAB(param_01,param_02,var_03);
}

//Function Number: 18
func_3EAB(param_00,param_01,param_02)
{
	if(isdefined(self.var_394))
	{
		var_03 = weaponclass(self.var_394);
	}
	else
	{
		var_03 = "none";
	}

	if(!lib_0A1A::func_2346(param_01,var_03 + param_02))
	{
		var_03 = "rifle";
	}

	return lib_0A1A::func_2358(param_01,var_03 + param_02);
}

//Function Number: 19
func_138E2()
{
	if(lib_0A1B::func_292C() == "crouch")
	{
		return 1;
	}

	return 0;
}

//Function Number: 20
func_811E(param_00)
{
	if(!isdefined(self.var_1198.var_FECD))
	{
		return undefined;
	}
	else if(isdefined(self.var_1198.var_FECD.var_65D3))
	{
		return self.var_1198.var_FECD.var_65D3 method_815B();
	}
	else if(isdefined(self.var_1198.var_FECD.var_D699))
	{
		return self.var_1198.var_FECD.var_D699;
	}
	else if(isdefined(self.var_10C))
	{
		return self.var_10C method_815B();
	}

	return undefined;
}

//Function Number: 21
func_811C()
{
	if(isdefined(self.var_130A9))
	{
		var_00 = self method_8143();
		return (var_00[0],var_00[1],self geteye()[2]);
	}

	return (self.origin[0],self.origin[1],self geteye()[2]);
}

//Function Number: 22
func_9D2E()
{
	if(!isdefined(self.var_1198.var_FECD.var_D699) && !isdefined(self.var_1198.var_FECD.var_65D3))
	{
		return 1;
	}

	var_00 = self method_8141();
	var_01 = func_811C();
	var_02 = func_811E(var_01);
	if(!isdefined(var_02))
	{
		return 0;
	}

	var_03 = vectortoangles(var_02 - var_01);
	var_04 = scripts\common\utility::func_152F(var_00[1] - var_03[1]);
	if(var_04 > level.var_1A52)
	{
		if(distancesquared(self geteye(),var_02) > level.var_1A50 || var_04 > level.var_1A51)
		{
		}
	}

	var_05 = func_7DA3();
	return scripts\common\utility::func_152F(var_00[0] - var_03[0]) <= var_05;
}

//Function Number: 23
func_7DA3()
{
	if(isdefined(self.var_1A44))
	{
		return self.var_1A44;
	}

	return level.var_1A44;
}

//Function Number: 24
func_CEC0(param_00,param_01,param_02)
{
}

//Function Number: 25
func_CEC1(param_00,param_01,param_02)
{
}