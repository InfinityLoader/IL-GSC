/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: animscripts\traverse\step_up_32.gsc
 * Game: Call of Duty: Ghosts
 * Platform: Console
 * Function Count: 2
 * Decompile Time: 34 ms
 * Timestamp: 10/27/2023 1:35:55 AM
*******************************************************************/

//Function Number: 1
func_4FDD()
{
	if(self.type == "dog")
	{
		animscripts/traverse/shared::func_28F2(32,5);
		return;
	}

	func_4F99();
}

//Function Number: 2
func_4F99()
{
	var_00 = [];
	%ch_pragueb_7_5_crosscourt_aimantle_a;
	var_00["traverseAnim"] = 32;
	lib_7472::func_6176(var_00);
}