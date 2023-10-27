/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 3128.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 19
 * Decompile Time: 3 ms
 * Timestamp: 10/27/2023 12:26:13 AM
*******************************************************************/

//Function Number: 1
func_33FF(param_00,param_01,param_02,param_03)
{
	self.var_2303.var_7257 = spawnstruct();
	self.var_2303.var_7257.var_7254 = "invalid";
	self.var_2303.var_7257.time = 0;
	self.var_2303.var_4C86 = spawnstruct();
	self.var_2303.var_7360 = 0;
	self.var_2303.var_77C1 = spawnstruct();
	func_98A7();
}

//Function Number: 2
func_98A7()
{
	if(isdefined(level.var_C05A))
	{
		return;
	}

	var_00 = [];
	var_00["Cover Left"] = 90;
	var_00["Cover Right"] = -90;
	anim.var_C05A = var_00;
	var_00 = [];
	var_00["Cover Left"] = 90;
	var_00["Cover Right"] = 180;
	anim.var_7365 = var_00;
}

//Function Number: 3
func_10088(param_00,param_01,param_02,param_03)
{
	if(lib_0A1B::func_2941())
	{
		return 0;
	}

	if(isdefined(self.var_6571))
	{
		return 0;
	}

	return 1;
}

//Function Number: 4
func_D46D(param_00,param_01,param_02,param_03)
{
	lib_0A1D::func_2364(param_00,param_01,param_02);
}

//Function Number: 5
func_0260(param_00,param_01,param_02,param_03)
{
	self endon("reload_terminate");
	self endon(param_01 + "_finished");
	var_04 = lib_0A1D::func_2337(param_00,param_01);
	lib_0A1D::func_2365(param_00,param_01,param_02,var_04);
	scripts\anim\weaponlist::func_DE4D();
	lib_0A1A::func_2330(param_01,"reload_finished");
}

//Function Number: 6
func_100A9(param_00,param_01,param_02,param_03)
{
	var_04 = lib_0A1B::func_292E();
	if(!isdefined(var_04))
	{
		return 0;
	}

	if(weaponclass(self.var_394) == var_04)
	{
		return 0;
	}

	return 1;
}

//Function Number: 7
func_BEA0(param_00,param_01,param_02,param_03)
{
	var_04 = undefined;
	if(isdefined(self.var_1198.var_FECD) && isdefined(self.var_1198.var_FECD.var_65D3))
	{
		var_04 = self.var_1198.var_FECD.var_65D3.origin;
	}
	else if(isdefined(self.var_1198.var_FECD) && isdefined(self.var_1198.var_FECD.var_D699))
	{
		var_04 = self.var_1198.var_FECD.var_D699;
	}
	else if(isdefined(self.var_10C))
	{
		var_04 = self.var_10C.origin;
	}

	if(!isdefined(var_04))
	{
		return 0;
	}

	var_05 = self.angles[1] - vectortoyaw(var_04 - self.origin);
	var_06 = distancesquared(self.origin,var_04);
	if(var_06 < 65536)
	{
		var_07 = sqrt(var_06);
		if(var_07 > 3)
		{
			var_05 = var_05 + asin(-3 / var_07);
		}
	}

	if(abs(angleclamp180(var_05)) > self.var_129AF)
	{
		return 1;
	}

	return 0;
}

//Function Number: 8
func_81DE()
{
	var_00 = 0.25;
	var_01 = undefined;
	var_02 = undefined;
	if(isdefined(self.var_1198.var_FECD))
	{
		if(isdefined(self.var_1198.var_FECD.var_65D3))
		{
			var_01 = self.var_1198.var_FECD.var_65D3;
		}
		else if(isdefined(self.var_1198.var_FECD.var_D699))
		{
			var_02 = self.var_1198.var_FECD.var_D699;
		}
	}

	if(isdefined(self.var_10C))
	{
		if(!isdefined(var_01) && !isdefined(var_02))
		{
			var_01 = self.var_10C;
		}
	}

	if(isdefined(var_01) && !issentient(var_01))
	{
		var_00 = 1.5;
	}

	var_03 = scripts\common\utility::func_8094(var_00,var_01,var_02);
	return var_03;
}

//Function Number: 9
func_3F0A(param_00,param_01,param_02)
{
	var_03 = func_81DE();
	if(var_03 < 0)
	{
		var_04 = "right";
	}
	else
	{
		var_04 = "left";
	}

	var_03 = abs(var_03);
	var_05 = 0;
	if(var_03 > 157.5)
	{
		var_05 = 180;
	}
	else if(var_03 > 112.5)
	{
		var_05 = 135;
	}
	else if(var_03 > 67.5)
	{
		var_05 = 90;
	}
	else
	{
		var_05 = 45;
	}

	var_06 = var_04 + "_" + var_05;
	var_07 = lib_0A1A::func_2358(param_01,var_06);
	var_08 = self method_8101(param_01,var_07);
	return var_07;
}

//Function Number: 10
func_116FF(param_00,param_01,param_02,param_03)
{
}

//Function Number: 11
func_D56A(param_00,param_01,param_02,param_03)
{
	self endon(param_01 + "_finished");
	var_04 = lib_0A1D::func_2337(param_00,param_01);
	var_05 = self.var_233;
	self method_8289("face angle abs",self.angles);
	self method_8281("anim deltas");
	lib_0A1D::func_2365(param_00,param_01,param_02,var_04);
	if(!isdefined(var_05) && isdefined(self.var_233))
	{
		self method_841F();
	}

	lib_0A1D::func_237F("face current");
	lib_0A1D::func_237E("code_move");
}

//Function Number: 12
func_1007E(param_00,param_01,param_02,param_03)
{
	var_04 = !lib_0A1B::func_2955() && scripts\asm\shared_utility::func_9D50();
	if(!var_04)
	{
		return 0;
	}

	if(!isdefined(self.var_205))
	{
		return 0;
	}

	if(!isdefined(param_03))
	{
		return 1;
	}

	return lib_0F3A::func_9D4C(param_00,param_01,param_02,param_03);
}

//Function Number: 13
func_CECB(param_00,param_01,param_02,param_03)
{
	self endon(param_01 + "finished");
	var_04 = lib_0A1B::func_292E();
	var_05 = lib_0A1D::func_2337(param_00,param_01);
	lib_0A1D::func_2365(param_00,param_01,param_02,var_05);
	self notify("switched_to_sidearm");
}

//Function Number: 14
func_D4B2(param_00,param_01,param_02,param_03)
{
	self method_828A("noclip");
	var_04 = lib_0A1D::func_2337(param_00,param_01);
	lib_0A1D::func_2365(param_00,param_01,param_02,var_04,1);
}

//Function Number: 15
func_D4B3(param_00,param_01,param_02,param_03)
{
	self method_828A("noclip");
	var_04 = lib_0A1D::func_2337(param_00,param_01);
	lib_0A1D::func_2365(param_00,param_01,param_02,var_04,0.001);
}

//Function Number: 16
func_FFEF(param_00,param_01,param_02,param_03)
{
	if(isdefined(self.var_FFEF))
	{
		return 1;
	}

	return 0;
}

//Function Number: 17
func_FFF3(param_00,param_01,param_02,param_03)
{
	return isdefined(self.var_FFF3);
}

//Function Number: 18
func_D4EC(param_00,param_01,param_02,param_03)
{
	self endon(param_01 + "finished");
	self method_828A("noclip");
	self method_8289("face angle abs",level.var_BEAB.angles);
	wait(0.5);
	lib_0F3C::func_CEA8(param_00,param_01,param_02,param_03);
}

//Function Number: 19
func_116EC(param_00,param_01,param_02,param_03)
{
	self notify("introanim_done");
	self method_828A("gravity");
}