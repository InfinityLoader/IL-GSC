/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 3896.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 9
 * Decompile Time: 2 ms
 * Timestamp: 10/27/2023 12:31:09 AM
*******************************************************************/

//Function Number: 1
func_B063(param_00,param_01,param_02,param_03)
{
	self setscriptablepartstate("run","active",0);
	self method_828A("gravity");
	lib_0A1D::func_2364(param_00,param_01,param_02,1.3);
}

//Function Number: 2
func_F173(param_00,param_01,param_02,param_03)
{
	self setscriptablepartstate("run","activeEnd",0);
}

//Function Number: 3
func_F178(param_00,param_01,param_02,param_03)
{
	self.var_9FB2 = 0;
	self setscriptablepartstate("jump","activeEnd",0);
}

//Function Number: 4
func_D560(param_00,param_01,param_02,param_03)
{
	self endon("death");
	self.var_9FB2 = 1;
	self setscriptablepartstate("jump","active",0);
	var_04 = self method_8148();
	var_05 = self method_8145();
	self method_828A("noclip");
	self method_8289("face angle abs",var_04.angles);
	self method_8281("anim deltas");
	self method_8282(1,1);
	var_06 = var_05.origin - var_04.origin;
	var_07 = self method_80FD(param_01,0);
	var_08 = getanimlength(var_07);
	var_09 = getmovedelta(var_07);
	self method_827B(self.origin,var_05.origin,var_08);
	self method_82AF(param_01,0);
	wait(var_08);
	self method_828A("gravity");
	self notify("traverse_end");
	func_11701(param_00,param_01);
}

//Function Number: 5
func_D562(param_00,param_01,param_02,param_03)
{
	self endon("death");
	var_04 = self method_8148();
	var_05 = self method_8145();
	self method_828A("noclip");
	self method_8289("face angle abs",var_04.angles);
	self method_8281("anim deltas");
	self method_8282(1,1);
	var_06 = var_05.origin - var_04.origin;
	var_07 = self method_80FD(param_01,0);
	var_08 = getanimlength(var_07);
	self method_82AF(param_01,0);
	var_09 = undefined;
	var_0A = var_04.origin[2] - var_05.origin[2];
	if(var_0A < -16)
	{
		var_09 = var_05.origin + (0,0,32);
		self method_827B(self.origin,var_09,var_08);
		wait(var_08);
		self method_82AF(param_01,1);
	}
	else if(var_0A > 16)
	{
		var_09 = (var_05.origin[0],var_05.origin[1],var_04.origin[2]);
		self method_827B(self.origin,var_09,var_08 * 0.5);
		wait(var_08 * 0.5);
	}
	else
	{
		self method_827B(self.origin,var_05.origin,var_08);
		wait(var_08);
	}

	self method_828A("gravity");
	self notify("traverse_end");
	func_11701(param_00,param_01);
}

//Function Number: 6
func_BBC2(param_00)
{
	self endon("stop_motion_hack");
	for(;;)
	{
		self setorigin(param_00.origin,1);
		self.angles = param_00.angles;
		wait(0.05);
	}
}

//Function Number: 7
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
	lib_0A1A::func_238A(param_00,var_03,0,undefined,undefined,undefined);
	self notify("killanimscript");
}

//Function Number: 8
func_F16E(param_00,param_01,param_02,param_03)
{
	self notify("terminate_ai_threads");
	self notify("killanimscript");
}

//Function Number: 9
func_9DEE(param_00,param_01,param_02,param_03)
{
	if(!isdefined(self.var_233))
	{
		return 0;
	}

	var_04 = anglestoforward(self.angles);
	var_05 = vectortoangles(var_04);
	var_06 = vectordot(vectornormalize((var_04[0],var_04[1],0)),anglestoforward(self.angles));
	var_07 = 0.966;
	return var_06 > var_07;
}