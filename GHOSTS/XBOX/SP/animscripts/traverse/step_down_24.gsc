/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: animscripts\traverse\step_down_24.gsc
 * Game: Call of Duty: Ghosts
 * Platform: Console
 * Function Count: 2
 * Decompile Time: 35 ms
 * Timestamp: 10/27/2023 1:35:54 AM
*******************************************************************/

//Function Number: 1
func_4FDD()
{
	if(self.type == "dog")
	{
		animscripts/traverse/shared::dog_jump_down(7,0.7);
		return;
	}

	func_4370();
}

//Function Number: 2
func_4370()
{
	var_00 = [];
	%sw_traversal_suspension_off;
	lib_7472::func_6176(var_00);
}