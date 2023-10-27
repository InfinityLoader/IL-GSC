/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 3170.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 23
 * Decompile Time: 38 ms
 * Timestamp: 10/27/2023 12:26:24 AM
*******************************************************************/

//Function Number: 1
func_811C()
{
	if(isdefined(self.var_130A9))
	{
		var_00 = self method_8143();
		return (var_00[0],var_00[1],self geteye()[2]);
	}

	return (self.origin[0],self.origin[1],self geteye()[2]);
}

//Function Number: 2
func_7AA3()
{
	var_00 = func_811C();
	return var_00;
}

//Function Number: 3
func_7AA2(param_00)
{
	var_01 = undefined;
	if(isdefined(self.var_1198.var_FECD))
	{
		var_01 = self.var_1198.var_FECD;
	}
	else if(isdefined(self.var_2303.var_FECD))
	{
		var_01 = self.var_2303.var_FECD;
	}

	if(!isdefined(var_01))
	{
		return undefined;
	}
	else if(isdefined(var_01.var_65D3))
	{
		return var_01.var_65D3 method_815B();
	}
	else if(isdefined(var_01.var_D699))
	{
		return var_01.var_D699;
	}

	return undefined;
}

//Function Number: 4
func_ADA1(param_00,param_01)
{
	self.var_2303.var_11A90.var_AD94 = lib_0A1E::func_2356(param_01,"aim_1");
	self.var_2303.var_11A90.var_AD95 = lib_0A1E::func_2356(param_01,"aim_2");
	self.var_2303.var_11A90.var_AD96 = lib_0A1E::func_2356(param_01,"aim_3");
	self.var_2303.var_11A90.var_AD97 = lib_0A1E::func_2356(param_01,"aim_4");
	self.var_2303.var_11A90.var_AD98 = lib_0A1E::func_2356(param_01,"aim_6");
	self.var_2303.var_11A90.var_AD99 = lib_0A1E::func_2356(param_01,"aim_7");
	self.var_2303.var_11A90.var_AD9A = lib_0A1E::func_2356(param_01,"aim_8");
	self.var_2303.var_11A90.var_AD9B = lib_0A1E::func_2356(param_01,"aim_9");
	self.var_2303.var_58EC = 1;
	self.var_2303.var_11A90.var_D890 = 0;
	var_02 = lib_0A1E::func_2356(param_01,"aim_knob");
	self method_82A2(var_02,1,0.2,1);
	self.var_268 = -80;
	self.var_1B7 = 80;
}

//Function Number: 5
func_CF03(param_00,param_01,param_02,param_03)
{
	self.var_1198.var_5D3B = undefined;
	thread lib_0A1E::func_235F(param_00,param_01,param_02,1,0);
	func_ADA1(param_00,param_01);
}

//Function Number: 6
func_4756(param_00,param_01,param_02)
{
	self.var_2303.var_58EC = 0;
	var_03 = lib_0A1E::func_2356(param_01,"aim_knob");
	self method_806F(var_03,0.2);
	self method_82D0();
	var_04 = self method_8164();
	if(isdefined(var_04) && var_04 == self.var_2303.var_129B9)
	{
		self method_83AF();
	}

	self.var_2303.var_129B9.origin = self.var_2303.var_12A7E;
	self.var_2303.var_129B9.angles = self.var_2303.var_12A57;
	self.var_2303.var_129B9 = undefined;
	self.var_2303.var_12A7E = undefined;
	self.var_2303.var_12A57 = undefined;
}

//Function Number: 7
func_4725(param_00,param_01,param_02)
{
	self.var_2303.var_58EC = 0;
	var_03 = lib_0A1E::func_2356(param_01,"aim_knob");
	self method_806F(var_03,0.2);
	self method_82D0();
}

//Function Number: 8
func_CEB3(param_00,param_01,param_02,param_03)
{
	self.var_1198.var_98F4 = undefined;
	func_AB30(self.var_394);
	lib_0A1E::func_2364(param_00,param_01,param_02);
}

//Function Number: 9
func_AB31(param_00,param_01)
{
	if(self method_81B7())
	{
		return "none";
	}

	self.var_1491.var_13CBB[param_01] = param_00;
	var_02 = function_00EA(param_00);
	var_03 = self gettagorigin("tag_weapon_right");
	var_04 = self gettagangles("tag_weapon_right");
	var_05 = spawn("script_model",var_03);
	var_05 setmodel(var_02);
	var_05.angles = var_04;
	self.var_1491.var_13CBB[param_01] = "none";
	self.var_1198.var_AB58 = var_05;
}

//Function Number: 10
func_AB30(param_00)
{
	scripts\anim\shared::func_5390();
	var_01 = self.var_39B[param_00].var_245;
	if(var_01 != "none")
	{
		thread func_AB31(param_00,var_01);
	}

	scripts\anim\shared::func_5398(param_00);
	if(param_00 == self.var_394)
	{
		self.var_394 = "none";
	}

	self.var_1198.var_5D3B = 1;
	scripts\anim\shared::func_12E61();
}

//Function Number: 11
func_12A82(param_00,param_01,param_02,param_03)
{
	return isdefined(lib_0A1B::func_292D());
}

//Function Number: 12
func_8BCD(param_00,param_01,param_02,param_03)
{
	return isdefined(self.var_2303.var_1310E) && self.var_2303.var_1310E;
}

//Function Number: 13
func_3E9E(param_00,param_01,param_02)
{
	if(isdefined(self.var_1198.var_5D3B))
	{
		return lib_0A1A::func_2358(param_01,"remount");
	}

	return lib_0A1A::func_2358(param_01,"default");
}

//Function Number: 14
func_CEB0(param_00,param_01,param_02,param_03)
{
	self.var_2303.var_1310E = 1;
	var_04 = lib_0A1B::func_292D();
	lib_0A1E::func_2366(param_00,param_01,param_02);
	self.var_2303.var_12A7E = var_04.origin;
	self.var_2303.var_12A57 = var_04.angles;
	self.var_2303.var_129B9 = var_04;
	self method_83D7(lib_0A1B::func_292D());
}

//Function Number: 15
func_C021(param_00,param_01,param_02,param_03)
{
	self.var_2303.var_1310E = 1;
	var_04 = lib_0A1B::func_292D();
	self.var_2303.var_12A7E = var_04.origin;
	self.var_2303.var_12A57 = var_04.angles;
	self.var_2303.var_129B9 = var_04;
	self method_83D7(lib_0A1B::func_292D());
}

//Function Number: 16
func_CEB2(param_00,param_01,param_02,param_03)
{
	self.var_2303.var_1310E = undefined;
	lib_0A1E::func_2364(param_00,param_01,param_02);
}

//Function Number: 17
func_FFE4(param_00,param_01,param_02,param_03)
{
	var_04 = isdefined(self.var_2303.var_1310E) && self.var_2303.var_1310E;
	if(var_04)
	{
		var_05 = self method_8164();
		var_06 = lib_0A1B::func_292D();
		var_07 = isdefined(var_05) && var_05 method_8165() == self;
		var_08 = var_07 && isdefined(var_06) && var_06 == var_05;
		return !var_08;
	}

	var_09 = lib_0A1A::func_BCE7(var_04,var_05,var_06,var_07);
	var_0A = scripts\asm\shared_utility::func_9D50();
	return var_09 || !var_0A;
}

//Function Number: 18
func_CEAF(param_00,param_01,param_02,param_03)
{
	if(isdefined(self.var_205))
	{
		self.var_1198.var_522F = self.var_205;
		self.var_1A4 = 1;
	}

	self.var_4C93 = ::func_C0C0;
	self.var_1198.var_98F4 = 1;
	var_04 = lib_0A1E::func_2336(param_00,param_01);
	if(isdefined(self.var_205))
	{
		if(isdefined(self.var_1198.var_5D3B))
		{
			self method_80F1(self.var_205.origin,self.angles);
			self method_8221("face angle",self.var_205.angles[1]);
		}
		else
		{
			var_05 = getangledelta(var_04);
			var_06 = self.var_205.angles[1] - var_05;
			self method_8221("face angle",var_06);
		}
	}
	else
	{
		self method_8221("face angle",self.angles[1]);
	}

	self endon(param_01 + "_finished");
	self method_806F(lib_0A1E::func_2339(),param_02);
	self method_82EA(param_01,var_04,1,param_02,1);
	lib_0A1E::func_2369(param_00,param_01,var_04);
	var_07 = lib_0A1E::func_231F(param_00,param_01,lib_0A1A::func_2341(param_00,param_01));
	if(var_07 == "end")
	{
		thread lib_0A1A::func_2310(param_00,param_01,0);
	}
}

//Function Number: 19
func_116E7(param_00,param_01,param_02)
{
	self.var_4C93 = undefined;
}

//Function Number: 20
func_CEB1(param_00,param_01,param_02,param_03)
{
	self.var_1198.var_522F = undefined;
	self.var_1198.var_98F4 = undefined;
	lib_0A1E::func_2364(param_00,param_01,param_02);
}

//Function Number: 21
func_C0C0(param_00,param_01,param_02,param_03)
{
	switch(param_00)
	{
		case "pistol_holster":
			scripts\anim\shared::func_CC2C(self.var_394,"none");
			break;

		case "lmg_pickup":
			self.var_1198.var_AB58 delete();
			self.var_1198.var_AB58 = undefined;
			scripts\anim\shared::func_CC2C(self.var_D8E1,"right");
			break;
	}
}

//Function Number: 22
func_B0E9(param_00,param_01,param_02,param_03)
{
	if(isdefined(self.var_205))
	{
		var_04 = self.var_205 method_8169();
		if(!scripts\common\utility::func_2286(var_04,"over"))
		{
			return param_03 == "high";
		}

		return param_03 == "stand";
	}

	return 0;
}

//Function Number: 23
func_527F(param_00,param_01,param_02,param_03)
{
	if(isdefined(self.var_1198.var_E1AF))
	{
		return self.var_1198.var_E1AF == param_03;
	}

	return 0;
}