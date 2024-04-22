/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: traverse\iw6_traverse_over_40_a.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 42 ms
 * Timestamp: 4/22/2024 1:59:24 AM
*******************************************************************/

//Function Number: 1
main()
{
	if(self.type == "dog")
	{
		animscripts\traverse\shared::dog_wall_and_window_hop("window_40",40);
		return;
	}

	low_wall_human();
}

//Function Number: 2
low_wall_human()
{
	var_00 = [];
	var_00["traverseAnim"] = %traverse_over_40_a_iw6;
	var_00["traverseToCoverAnim"] = %traverse40_2_cover;
	var_00["coverType"] = "Cover Crouch";
	var_00["traverseHeight"] = 40;
	var_00["interruptDeathAnim"][0] = animscripts\utility::array(%traverse40_death_start,%traverse40_death_start_2);
	var_00["interruptDeathAnim"][1] = animscripts\utility::array(%traverse40_death_end,%traverse40_death_end_2);
	animscripts\traverse\shared::dotraverse(var_00);
}