/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: animscripts\traverse\step_up_24.gsc
 * Game: Call of Duty: Ghosts
 * Platform: Console
 * Function Count: 2
 * Decompile Time: 35 ms
 * Timestamp: 10/27/2023 1:35:55 AM
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
	%sw_traversal_suspension_on;
	var_00["traverseAnim"] = 24;
	lib_7472::func_6176(var_00);
}