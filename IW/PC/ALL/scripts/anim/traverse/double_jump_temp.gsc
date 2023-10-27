/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\anim\traverse\double_jump_temp.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 3
 * Decompile Time: 154 ms
 * Timestamp: 10/26/2023 11:59:25 PM
*******************************************************************/

//Function Number: 1
main()
{
	if(isdefined(self.var_12BA4) && self.var_12BA4 == "c12")
	{
		return;
	}

	if(getdvarint("ai_iw7",0) == 1)
	{
		self endon("killanimscript");
		self endon("death");
		wait(0.05);
		return;
	}

	func_5AD2();
}

//Function Number: 2
func_5AD2()
{
	self endon("killanimscript");
	self endon("death");
	self.var_DC1A = 1;
	var_00 = self method_8148();
	var_01 = self method_8145();
	var_00.var_126D4 = var_00.var_126D4 - 44;
	var_02 = [];
	if(var_00.var_126D4 > var_01.origin[2])
	{
		var_03 = var_00.origin[0] + var_01.origin[0] * 0.5;
		var_04 = var_00.origin[1] + var_01.origin[1] * 0.5;
		var_02[var_02.size] = (var_03,var_04,var_00.var_126D4);
	}

	var_02[var_02.size] = var_01.origin;
	var_05 = spawn("script_model",var_00.origin);
	var_05 setmodel("tag_origin");
	var_05.angles = var_00.angles;
	self method_8221("face angle",var_00.angles[1]);
	var_06 = 1.63;
	self method_806F(%body,0.2);
	self method_82E7("traverseAnim",%traverse_doublejump,1,0.2,1);
	childthread func_11629(var_05);
	thread scripts\anim\shared::func_592B("traverseAnim",::scripts\anim\traverse\shared::func_89F8);
	foreach(var_08 in var_02)
	{
		var_09 = var_06 / var_02.size;
		var_05 moveto(var_08,var_09);
		var_05 waittill("movedone");
	}

	self notify("double_jumped");
	self.var_DC1A = undefined;
	var_05 delete();
}

//Function Number: 3
func_11629(param_00)
{
	self endon("double_jumped");
	for(;;)
	{
		self method_80F1(param_00.origin,param_00.angles,10000);
		wait(0.05);
	}
}