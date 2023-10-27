/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 3191.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 18
 * Decompile Time: 2 ms
 * Timestamp: 10/27/2023 12:26:30 AM
*******************************************************************/

//Function Number: 1
func_13F64()
{
	if(lib_0A1B::func_2956("fly"))
	{
		return 1;
	}

	return 0;
}

//Function Number: 2
func_13F66()
{
	if(lib_0A1B::func_2953())
	{
		return 1;
	}

	return 0;
}

//Function Number: 3
func_13F67()
{
	if(lib_0A1B::func_2956("entangled"))
	{
		return 1;
	}

	return 0;
}

//Function Number: 4
func_13F68()
{
	if(lib_0C2D::func_7ED5() == "launched")
	{
		return 1;
	}

	return 0;
}

//Function Number: 5
func_13F65()
{
	if(!isdefined(self.var_8272))
	{
		return 0;
	}

	if(lib_0C2D::func_7ED5() == "entangled")
	{
		return 0;
	}

	var_00 = self.var_8272 - self.origin;
	var_01 = func_36EE(var_00);
	if(isdefined(var_01))
	{
		self.var_6FF5 = var_01;
		return 1;
	}

	return 0;
}

//Function Number: 6
func_13F6D(param_00,param_01,param_02,param_03)
{
	if(isdefined(self.var_13F2C))
	{
		func_1299A(self.var_13F2C.origin);
	}

	func_CECF(param_00,param_01,param_02,param_03);
	self notify("ghost_played_melee_anim");
}

//Function Number: 7
func_13F63(param_00,param_01,param_02,param_03)
{
	if(param_00 == "hit")
	{
		if(!isdefined(self.var_13F2C))
		{
			return;
		}

		if(!scripts\cp\_utility::func_9F19(self.var_13F2C))
		{
			return;
		}

		if(self.var_13F2C scripts\cp\_utility::func_9E3A())
		{
			return;
		}

		if(lib_0F74::func_1002C(self.var_13F2C))
		{
			return;
		}

		if(distancesquared(self.var_13F2C.origin,self.origin) > 9216)
		{
			return;
		}

		self.var_13F2C dodamage(45,self.origin,self,self,"MOD_MELEE");
	}
}

//Function Number: 8
func_13F6C(param_00,param_01,param_02,param_03)
{
	func_CECF(param_00,param_01,param_02,param_03);
}

//Function Number: 9
func_13F6A(param_00,param_01,param_02,param_03)
{
	func_CECF(param_00,param_01,param_02,param_03);
}

//Function Number: 10
func_826A(param_00,param_01,param_02,param_03,param_04)
{
	self endon(param_01 + "_finished");
	if(!isdefined(param_03))
	{
		param_03 = 1;
	}

	self.var_4BDC = param_01;
	var_05 = lib_0A1D::func_2337(param_00,param_01);
	self.var_4BDB = var_05;
	var_06 = lib_0A1A::func_2341(param_00,param_01);
	for(;;)
	{
		self method_82AF(param_01,var_05,param_03);
		scripts\mp\agents\_scriptedagents::func_1384C(param_01,"end",param_01,var_05,var_06);
	}
}

//Function Number: 11
func_13F6E(param_00,param_01,param_02,param_03)
{
}

//Function Number: 12
func_13F62()
{
	self endon("death");
	for(;;)
	{
		scripts\common\utility::func_136F7();
		if(isdefined(self.var_8272))
		{
			func_1299A(self.var_8272);
		}
	}
}

//Function Number: 13
func_13F6B(param_00,param_01,param_02,param_03)
{
	func_CECF(param_00,param_01,param_02,param_03);
	if(isdefined(self.var_8272))
	{
		func_1299A(self.var_8272);
	}
}

//Function Number: 14
func_36EE(param_00)
{
	var_01 = 10;
	var_02 = vectortoangles(param_00);
	var_03 = angleclamp180(var_02[1] - self.angles[1]);
	var_04 = function_02F9(var_03,var_01);
	if(var_04 == 4 || var_04 < 0 || var_04 > 8)
	{
		return undefined;
	}

	var_05 = func_79C4();
	return var_05[var_04];
}

//Function Number: 15
func_13F61(param_00,param_01,param_02,param_03)
{
	return self.var_6FF5;
}

//Function Number: 16
func_79C4()
{
	var_00 = [];
	var_00[0] = 0;
	var_00[1] = 1;
	var_00[2] = 2;
	var_00[3] = 3;
	var_00[5] = 4;
	var_00[6] = 5;
	var_00[7] = 6;
	var_00[8] = 7;
	return var_00;
}

//Function Number: 17
func_1299A(param_00)
{
	var_01 = param_00 - self.origin;
	self method_8289("face angle abs",vectortoangles(var_01));
	self.angles = vectortoangles(var_01);
}

//Function Number: 18
func_CECF(param_00,param_01,param_02,param_03)
{
	self endon(param_01 + "_finished");
	var_04 = lib_0A1D::func_2337(param_00,param_01);
	var_05 = lib_0A1A::func_2341(param_00,param_01);
	self.var_4BDC = param_01;
	self.var_4BDB = var_04;
	scripts\mp\agents\_scriptedagents::func_CED2(param_01,var_04,self.var_1FC6,param_01,"end",var_05);
}