/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\anim\traverse\jump_across_72.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 1
 * Decompile Time: 73 ms
 * Timestamp: 10/26/2023 11:59:28 PM
*******************************************************************/

//Function Number: 1
main()
{
	if(self.type == "dog")
	{
		scripts\anim\traverse\shared::func_5869("wallhop",20);
		return;
	}

	self.var_5270 = "stand";
	scripts\anim\utility::func_12E5F();
	self endon("killanimscript");
	self method_83C4("nogravity");
	self method_83C4("noclip");
	var_00 = self method_8148();
	self method_8221("face angle",var_00.angles[1]);
	self method_82E4("jumpanim",%jump_across_72,%body,1,0.1,1);
	self waittillmatch("gravity on","jumpanim");
	self method_83C4("gravity");
	scripts\anim\shared::func_592B("jumpanim");
}