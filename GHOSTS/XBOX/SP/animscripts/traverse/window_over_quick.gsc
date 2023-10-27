/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: animscripts\traverse\window_over_quick.gsc
 * Game: Call of Duty: Ghosts
 * Platform: Console
 * Function Count: 2
 * Decompile Time: 37 ms
 * Timestamp: 10/27/2023 1:35:59 AM
*******************************************************************/

//Function Number: 1
func_4FDD()
{
	if(self.type == "dog")
	{
		animscripts/traverse/shared::func_2933("window_40",40);
		return;
	}

	func_4A37();
}

//Function Number: 2
func_4A37()
{
	var_00 = [];
	%traverse_window_quick;
	var_00["Cover Crouch"] = "traverseAnim";
	var_00["coverType"] = 36;
	var_00["traverse_window_death_start"][0] = %;
	var_00["animscripts/utility"][1] = %;
	lib_0ED8::func_696E(var_00);
}