/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\anim\traverse\combatrun_forward_72.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 1
 * Decompile Time: 76 ms
 * Timestamp: 10/26/2023 11:59:24 PM
*******************************************************************/

//Function Number: 1
main()
{
	if(getdvarint("ai_iw7",0) == 1)
	{
		self waittill("killanimscript");
		return;
	}

	self.var_5270 = "stand";
	scripts\anim\utility::func_12E5F();
	self endon("killanimscript");
	self method_83C4("nogravity");
	self method_83C4("noclip");
	var_00 = self method_8148();
	self method_8221("face angle",var_00.angles[1]);
	self method_82E4("combatrun",%combatrun_forward,%body,1,0.1,1);
	wait(0.45);
	self method_83C4("gravity");
}