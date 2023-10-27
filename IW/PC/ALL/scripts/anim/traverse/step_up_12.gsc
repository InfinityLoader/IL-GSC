/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\anim\traverse\step_up_12.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 1
 * Decompile Time: 74 ms
 * Timestamp: 10/26/2023 11:59:42 PM
*******************************************************************/

//Function Number: 1
main()
{
	self endon("killanimscript");
	var_00 = self method_8148();
	self method_8221("face angle",var_00.angles[1]);
	var_01 = var_00.var_126D4 - var_00.origin[2];
	var_02 = var_01;
	var_03 = 7;
	var_04 = (0,0,var_02 / var_03);
	var_05 = getdvarint("ai_iw7",0) != 0;
	if(var_05)
	{
		self method_8016("noclip");
	}
	else
	{
		self method_83C4("noclip");
	}

	for(var_06 = 0;var_06 < var_03;var_06++)
	{
		self method_83B9(self.origin + var_04);
		wait(0.05);
	}

	if(var_05)
	{
		self method_8016("gravity");
	}
	else
	{
		self method_83C4("gravity");
	}

	if(var_05)
	{
		self notify("external_traverse_complete");
	}
}