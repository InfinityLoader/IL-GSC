/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: animscripts\traverse\window_over_quick.gsc
 * Game: Call of Duty: Ghosts
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 48 ms
 * Timestamp: 10/27/2023 1:23:10 AM
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
	var_00["traverseAnim"] = %traverse_window_quick;
	var_00["coverType"] = "Cover Crouch";
	var_00["traverseHeight"] = 36;
	var_00["interruptDeathAnim"][0] = animscripts/utility::func_ED8(%traverse_window_death_start);
	var_00["interruptDeathAnim"][1] = animscripts/utility::func_ED8(%traverse_window_death_end);
	animscripts/traverse/shared::func_2A1F(var_00);
}