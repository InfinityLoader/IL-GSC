/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: animscripts\traverse\step_up_12.gsc
 * Game: Call of Duty: Ghosts
 * Platform: PC
 * Function Count: 1
 * Decompile Time: 41 ms
 * Timestamp: 10/27/2023 1:23:04 AM
*******************************************************************/

//Function Number: 1
func_4FDD()
{
	self endon("killanimscript");
	var_00 = self getnegotiationstartnode();
	self orientmode("face angle",var_00.angles[1]);
	var_01 = var_00.var_82CB - var_00.origin[2];
	var_02 = var_01;
	var_03 = 6;
	var_04 = (0,0,var_02 / var_03);
	self traversemode("noclip");
	for(var_05 = 0;var_05 < var_03;var_05++)
	{
		self teleport(self.origin + var_04);
		wait(0.05);
	}

	self traversemode("gravity");
}