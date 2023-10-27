/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: animscripts\traverse\iw6_traverse_over_40_a.gsc
 * Game: Call of Duty: Ghosts
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 58 ms
 * Timestamp: 10/27/2023 1:22:57 AM
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
	var_00["traverseAnim"] = %traverse_over_40_a_iw6;
	var_00["traverseToCoverAnim"] = %traverse40_2_cover;
	var_00["coverType"] = "Cover Crouch";
	var_00["traverseHeight"] = 40;
	var_00["interruptDeathAnim"][0] = animscripts/utility::func_ED8(%traverse40_death_start,%traverse40_death_start_2);
	var_00["interruptDeathAnim"][1] = animscripts/utility::func_ED8(%traverse40_death_end,%traverse40_death_end_2);
	animscripts/traverse/shared::func_2A1F(var_00);
}