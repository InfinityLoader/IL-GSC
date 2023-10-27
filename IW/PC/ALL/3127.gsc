/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 3127.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 10
 * Decompile Time: 2 ms
 * Timestamp: 10/27/2023 12:26:12 AM
*******************************************************************/

//Function Number: 1
func_3EE5(param_00,param_01,param_02)
{
	return lib_0F3C::func_3EF4(param_00,param_01,param_02);
}

//Function Number: 2
func_3EE6(param_00,param_01,param_02)
{
	return lib_0F3C::func_3EF4(param_00,param_01,param_02);
}

//Function Number: 3
func_3EE7(param_00,param_01,param_02)
{
	return lib_0F3C::func_3EF4(param_00,param_01,param_02);
}

//Function Number: 4
func_3EEB(param_00,param_01,param_02)
{
	return lib_0F3C::func_3EF4(param_00,param_01,param_02);
}

//Function Number: 5
func_3EEC(param_00,param_01,param_02)
{
	return lib_0F3C::func_3EF4(param_00,param_01,param_02);
}

//Function Number: 6
func_3EE8(param_00,param_01,param_02)
{
	return lib_0F3C::func_3EF4(param_00,param_01,param_02);
}

//Function Number: 7
func_CF04(param_00,param_01,param_02,param_03)
{
}

//Function Number: 8
func_D4EE(param_00,param_01,param_02,param_03)
{
	self endon("death");
	self endon("terminate_ai_threads");
	var_04 = level.var_2303[param_00].var_10E2F[param_01].var_71A5;
	var_05 = self [[ var_04 ]](param_00,param_01,param_03);
	if(isdefined(self.var_233))
	{
		self method_8281("anim deltas");
		self method_8289("face angle abs",self.angles);
	}

	lib_0A1D::func_2365(param_00,param_01,param_02,var_05);
	func_6CE0(param_00,param_01,param_03);
}

//Function Number: 9
func_6CE0(param_00,param_01,param_02)
{
	self notify("killanimscript");
	var_03 = level.var_2303[param_00].var_10E2F[param_01];
	var_04 = param_02;
	if(!isdefined(var_04))
	{
		if(isdefined(var_03.var_1267B) && var_03.var_1267B.size > 0)
		{
			return;
		}

		var_04 = "exposed_idle";
	}

	lib_0A1A::func_2388(param_00,param_01,var_03,var_03.var_116FB);
	lib_0A1A::func_238A(param_00,var_04,0.2,undefined,undefined,undefined);
}

//Function Number: 10
func_4109(param_00,param_01,param_02)
{
}