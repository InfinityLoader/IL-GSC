/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 3145.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 13
 * Decompile Time: 13 ms
 * Timestamp: 10/27/2023 12:26:16 AM
*******************************************************************/

//Function Number: 1
func_3FCE(param_00,param_01,param_02,param_03)
{
	self.var_2303.var_7360 = 0;
	self.var_2303.var_4C86 = spawnstruct();
	self.var_2303.var_7257 = spawnstruct();
	self.var_2303.var_7257.var_7254 = "invalid";
	self.var_2303.var_7257.time = 0;
	self method_8504(0);
	self.var_282 = 0;
}

//Function Number: 2
func_3EC5(param_00,param_01,param_02)
{
	if(isdefined(self.var_2303.var_1269B))
	{
		var_03 = self.var_2303.var_1269B;
		if(param_01 == "trans_out_stand_idle")
		{
			self.var_2303.var_1269B = undefined;
		}

		return lib_0A1A::func_2358(param_01,var_03);
	}

	var_03 = lib_0A1E::func_235D(param_02);
	self.var_2303.var_1269B = var_03;
	return lib_0A1A::func_2358(param_01,var_03);
}

//Function Number: 3
func_3EC4(param_00,param_01,param_02)
{
	if(isdefined(self.var_2303.var_3FDC))
	{
		var_03 = self.var_2303.var_3FDC;
		if(param_01 == "trans_out_combat_react")
		{
			self.var_2303.var_3FDC = undefined;
		}

		return lib_0A1A::func_2358(param_01,var_03);
	}

	var_04 = self.var_2303.var_1269B;
	if(scripts\common\utility::func_4347())
	{
		var_05 = var_04 + "_a";
	}
	else
	{
		var_05 = var_05 + "_b";
	}

	self.var_2303.var_3FDC = var_05;
	return lib_0A1A::func_2358(param_02,var_05);
}

//Function Number: 4
func_3FD4(param_00,param_01,param_02,param_03)
{
	scripts\anim\combat::func_F296();
	var_04 = self.var_164D[param_00];
	if(isdefined(var_04.var_10E23) && var_04.var_10E23 == "trans_out_stand_idle")
	{
		childthread scripts\asm\shared_utility::func_FB04(param_01,param_02);
	}

	if(isdefined(self.var_205))
	{
		self.var_1198.var_AA3D = self.var_205;
	}

	lib_0A1E::func_235F(param_00,param_01,param_02,1);
}

//Function Number: 5
func_3FD3(param_00,param_01,param_02,param_03)
{
	self.var_282 = 1;
	lib_0C65::func_CEB5(param_00,param_01,param_02,param_03);
}

//Function Number: 6
func_3FD5(param_00,param_01,param_02,param_03)
{
	self.var_282 = 1;
	lib_0F3D::func_D4DD(param_00,param_01,param_02,param_03);
}

//Function Number: 7
func_3FD6(param_00,param_01,param_02,param_03)
{
	self.var_282 = 1;
	lib_0C65::func_D514(param_00,param_01,param_02,param_03);
}

//Function Number: 8
func_3FD1(param_00,param_01,param_02)
{
	self.var_282 = 0;
}

//Function Number: 9
func_A00A(param_00,param_01,param_02,param_03)
{
	return lib_0A1B::func_294E();
}

//Function Number: 10
func_3FE1(param_00,param_01,param_02,param_03)
{
	return lib_0A1B::func_291D() == param_03;
}

//Function Number: 11
func_FFE3(param_00,param_01,param_02,param_03)
{
	if(func_A00A() || lib_0A1B::func_291D() == "combat")
	{
		var_04 = self.var_2303.var_1269B;
		if(var_04 == "civ02" || var_04 == "civ04" || var_04 == "civ06" || var_04 == "civ07")
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 12
func_FFDF(param_00,param_01,param_02,param_03)
{
	if(lib_0A1B::func_291D() == "noncombat")
	{
		var_04 = self.var_2303.var_1269B;
		if(var_04 == "civ02" || var_04 == "civ04" || var_04 == "civ06" || var_04 == "civ07")
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 13
func_FFD2(param_00,param_01,param_02,param_03)
{
	self.var_2303.var_3FDC = undefined;
	return 1;
}