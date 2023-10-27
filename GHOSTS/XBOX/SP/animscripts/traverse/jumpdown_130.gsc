/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: animscripts\traverse\jumpdown_130.gsc
 * Game: Call of Duty: Ghosts
 * Platform: Console
 * Function Count: 2
 * Decompile Time: 37 ms
 * Timestamp: 10/27/2023 1:35:50 AM
*******************************************************************/

//Function Number: 1
func_4FDD()
{
	if(self.type == "dog")
	{
		animscripts/traverse/shared::dog_jump_down(7,0.7);
		return;
	}

	func_4A3F();
}

//Function Number: 2
func_4A3F()
{
	var_00 = [];
	%traverse_jumpdown_130;
	lib_7472::func_6176(var_00);
}