/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\anim\traverse\jump_across_100.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 141 ms
 * Timestamp: 10/26/2023 11:59:28 PM
*******************************************************************/

//Function Number: 1
main()
{
	if(self.type == "dog")
	{
		scripts\anim\traverse\shared::func_5869("window_40",20);
		return;
	}

	self.var_5270 = "stand";
	scripts\anim\utility::func_12E5F();
	self endon("killanimscript");
	self method_83C4("nogravity");
	self method_83C4("noclip");
	var_00 = self method_8148();
	self method_8221("face angle",var_00.angles[1]);
	var_01 = func_7814();
	self method_82E4("jumpanim",var_01,%body,1,0.1,1);
	scripts\anim\shared::func_592B("jumpanim");
}

//Function Number: 2
func_7814()
{
	var_00 = [];
	var_00[0] = %jump_across_100_spring;
	var_00[1] = %jump_across_100_lunge;
	var_00[2] = %jump_across_100_stumble;
	return var_00[randomint(var_00.size)];
}