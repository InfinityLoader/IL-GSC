/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: animscripts\traverse\stepup_52.gsc
 * Game: Call of Duty: Ghosts
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 53 ms
 * Timestamp: 10/27/2023 1:23:06 AM
*******************************************************************/

//Function Number: 1
func_4FDD()
{
	if(self.type == "dog")
	{
		animscripts/traverse/shared::func_28F2(52,5);
		return;
	}

	func_4F99();
}

//Function Number: 2
func_4F99()
{
	var_00 = [];
	var_00["traverseAnim"] = %traverse_stepup_52;
	var_00["traverseHeight"] = 52;
	animscripts/traverse/shared::func_2A1F(var_00);
}