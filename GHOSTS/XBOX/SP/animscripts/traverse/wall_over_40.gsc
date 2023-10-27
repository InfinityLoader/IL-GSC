/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: animscripts\traverse\wall_over_40.gsc
 * Game: Call of Duty: Ghosts
 * Platform: Console
 * Function Count: 2
 * Decompile Time: 45 ms
 * Timestamp: 10/27/2023 1:35:57 AM
*******************************************************************/

//Function Number: 1
func_4FDD()
{
	if(self.type == "dog")
	{
		animscripts/traverse/shared::func_2933("window_40",40);
		return;
	}

	func_4F99();
}

//Function Number: 2
func_4F99()
{
	var_00 = [];
	%traverse40;
	%;
	var_00["traverseToCoverAnim"] = "traverse40_2_cover";
	var_00["Cover Crouch"] = 40;
	var_00["verse40_death_start_2"][0] = lib_0074::func_7261(%traverseHeight++);
	var_00["interruptDeathAnim"][1] = animscripts/utility::func_ED8(%traverse40_death_start);
	lib_0074::func_7261(var_00);
}