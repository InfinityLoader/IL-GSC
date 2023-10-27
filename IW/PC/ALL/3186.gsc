/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 3186.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 15
 * Decompile Time: 1 ms
 * Timestamp: 10/27/2023 12:26:28 AM
*******************************************************************/

//Function Number: 1
func_566E()
{
}

//Function Number: 2
func_F6C8(param_00,param_01)
{
	if(!isdefined(self.var_566C))
	{
		self.var_566C = spawnstruct();
	}

	self.var_566C.var_2C19 = param_00;
	self.var_566C.var_8EE5 = param_01;
	lib_0A1A::func_237C("dismember");
}

//Function Number: 3
func_41A7()
{
	if(isdefined(self.var_566C))
	{
		self.var_566C.var_2C19 = undefined;
		self.var_566C.var_8EE5 = undefined;
		self.var_566C = undefined;
	}
}

//Function Number: 4
func_54B9()
{
	if(self.var_566C.var_2C19 == 1)
	{
		return 1;
	}

	return 0;
}

//Function Number: 5
func_54B7()
{
	if(self.var_566C.var_2C19 == 2)
	{
		return 1;
	}

	return 0;
}

//Function Number: 6
func_54BA()
{
	if(self.var_566C.var_2C19 == 4)
	{
		return 1;
	}

	return 0;
}

//Function Number: 7
func_54B8()
{
	if(self.var_566C.var_2C19 == 8)
	{
		return 1;
	}

	return 0;
}

//Function Number: 8
func_54B6()
{
	if(self.var_566C.var_2C19 == 12)
	{
		return 1;
	}

	return 0;
}

//Function Number: 9
func_8C0D()
{
	if(!isdefined(self.var_566C))
	{
		return 0;
	}

	return 1;
}

//Function Number: 10
func_9E2E()
{
	return self.var_566C.var_8EE5;
}

//Function Number: 11
func_9EDD(param_00)
{
	if(!lib_0A1B::func_2955())
	{
		return 0;
	}

	return lib_0A1B::func_2956(param_00);
}

//Function Number: 12
func_CF1B(param_00,param_01,param_02,param_03)
{
	self endon(param_01 + "_finished");
	self endon("death");
	self endon("terminate_ai_threads");
	var_04 = lib_0A1D::func_2337(param_00,param_01);
	func_5815(param_01,var_04);
	func_41A7();
}

//Function Number: 13
func_5815(param_00,param_01)
{
	self endon(param_00 + "_finished");
	self endon("death");
	self endon("terminate_ai_threads");
	self method_8282(1,1);
	scripts\mp\agents\_scriptedagents::func_CED3(param_00,param_01,self.var_C081,"end");
}

//Function Number: 14
func_9EA5()
{
	if(!isdefined(self.var_B8BA))
	{
		return 0;
	}

	var_00 = self.var_B8BA & 1;
	return var_00 != 0;
}

//Function Number: 15
func_9EA4()
{
	if(!isdefined(self.var_B8BA))
	{
		return 0;
	}

	var_00 = self.var_B8BA & 2;
	return var_00 != 0;
}