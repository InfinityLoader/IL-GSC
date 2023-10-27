/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: animscripts\traverse\step_up_32.gsc
 * Game: Call of Duty: Ghosts
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 60 ms
 * Timestamp: 10/27/2023 1:23:05 AM
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
	var_00["traverseAnim"] = %ch_pragueb_7_5_crosscourt_aimantle_a;
	var_00["traverseHeight"] = 32;
	animscripts/traverse/shared::func_2A1F(var_00);
}