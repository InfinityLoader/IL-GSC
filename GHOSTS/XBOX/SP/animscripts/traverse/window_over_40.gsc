/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: animscripts\traverse\window_over_40.gsc
 * Game: Call of Duty: Ghosts
 * Platform: Console
 * Function Count: 2
 * Decompile Time: 35 ms
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
	%traverse_window_m_2_run;
	%;
	var_00["traverseToCoverAnim"] = "traverse_window_m_2_stop";
	var_00["Cover Crouch"] = 36;
	var_00[""][0] = %traverseHeight;
	var_00[""][1] = %;
	lib_616E::run_player_out_of_bounds(var_00);
}