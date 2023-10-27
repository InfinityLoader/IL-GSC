/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 3130.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 18
 * Decompile Time: 4 ms
 * Timestamp: 10/27/2023 12:26:13 AM
*******************************************************************/

//Function Number: 1
func_D55D(param_00,param_01,param_02,param_03)
{
}

//Function Number: 2
func_D566(param_00,param_01,param_02,param_03)
{
	func_D564(param_00,param_01,param_02);
}

//Function Number: 3
func_D560(param_00,param_01,param_02,param_03)
{
	func_D563(param_00,param_01,param_02,param_03);
}

//Function Number: 4
func_D55E(param_00,param_01,param_02,param_03)
{
}

//Function Number: 5
func_D563(param_00,param_01,param_02,param_03)
{
	self endon("death");
	self endon("terminate_ai_threads");
	var_04 = self method_8148();
	var_05 = self method_8146();
	self method_828A("noclip");
	self method_8289("face angle abs",var_04.angles);
	self method_8281("anim deltas");
	self method_8282(1,1);
	var_06 = var_05 - var_04.origin;
	var_07 = self method_80FD(param_01,0);
	var_08 = getanimlength(var_07);
	var_09 = getmovedelta(var_07);
	var_0A = length(var_09);
	var_0B = length(var_05 - self.origin);
	var_0C = var_08 * var_0B / var_0A;
	self method_827B(self.origin,var_05,var_0C);
	self method_82AF(param_01,0);
	wait(var_0C);
	self method_828A("gravity");
	self notify("traverse_end");
	func_11701(param_00,param_01);
}

//Function Number: 6
playtraverseanim_gravity(param_00,param_01,param_02,param_03)
{
	self endon("death");
	self endon("terminate_ai_threads");
	var_04 = self method_8148();
	var_05 = self method_8146();
	self method_828A("noclip");
	self method_8289("face angle abs",var_04.angles);
	self method_8281("anim deltas");
	self method_8282(1,1);
	var_06 = self method_80FD(param_01,0);
	var_07 = getanimlength(var_06);
	thread lib_0F3C::func_CEA8(param_00,param_01,param_02);
	wait(var_07 * 0.4);
	self method_828A("gravity");
	wait(var_07 * 0.6);
	self notify("traverse_end");
	func_11701(param_00,param_01);
}

//Function Number: 7
func_D564(param_00,param_01,param_02,param_03)
{
	self endon("death");
	self endon("terminate_ai_threads");
	var_04 = self method_8148();
	var_05 = self method_8146();
	self method_828A("noclip");
	self method_8289("face angle abs",var_04.angles);
	self method_8281("anim deltas");
	self method_8282(1,1);
	var_06 = self method_80FD(param_01,0);
	lib_0F3C::func_CEA8(param_00,param_01,param_02);
	self method_828A("gravity");
	self notify("traverse_end");
	func_11701(param_00,param_01);
}

//Function Number: 8
func_D55C(param_00,param_01,param_02,param_03)
{
	func_D564(param_00,param_01,param_02,param_03);
}

//Function Number: 9
func_11701(param_00,param_01)
{
	var_02 = level.var_2303[param_00].var_10E2F[param_01];
	var_03 = undefined;
	if(isarray(var_02.var_116FB))
	{
		var_03 = var_02.var_116FB[0];
	}
	else
	{
		var_03 = var_02.var_116FB;
	}

	lib_0A1A::func_2388(param_00,param_01,var_02,var_02.var_116FB);
	lib_0A1A::func_238A(param_00,var_03,0.2,undefined,undefined,undefined);
	self notify("killanimscript");
}

//Function Number: 10
func_11661(param_00)
{
}

//Function Number: 11
func_11662(param_00,param_01,param_02,param_03)
{
}

//Function Number: 12
func_89F8(param_00)
{
}

//Function Number: 13
func_89F6()
{
}

//Function Number: 14
func_89F5()
{
}

//Function Number: 15
func_89F7()
{
}

//Function Number: 16
func_6CE5(param_00)
{
}

//Function Number: 17
func_126D2(param_00,param_01,param_02)
{
	self unlink();
	self.var_DC1A = undefined;
}

//Function Number: 18
func_D565(param_00,param_01,param_02,param_03)
{
}