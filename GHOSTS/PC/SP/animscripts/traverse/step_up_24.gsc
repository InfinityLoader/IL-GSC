/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: animscripts\traverse\step_up_24.gsc
 * Game: Call of Duty: Ghosts
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 48 ms
 * Timestamp: 10/27/2023 1:23:05 AM
*******************************************************************/

//Function Number: 1
func_4FDD()
{
	if(self.type == "dog")
	{
		animscripts/traverse/shared::func_28F2(24,5);
		return;
	}

	func_4370();
}

//Function Number: 2
func_4370()
{
	var_00 = [];
	var_00["traverseAnim"] = %sw_traversal_suspension_on;
	var_00["traverseHeight"] = 24;
	animscripts/traverse/shared::func_2A1F(var_00);
}