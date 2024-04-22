/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: traverse\window_over_40.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 52 ms
 * Timestamp: 4/22/2024 1:59:47 AM
*******************************************************************/

//Function Number: 1
main()
{
	if(self.type == "dog")
	{
		animscripts\traverse\shared::dog_wall_and_window_hop("window_40",40);
		return;
	}

	jump_through_window_human();
}

//Function Number: 2
jump_through_window_human()
{
	var_00 = [];
	var_00["traverseAnim"] = %traverse_window_m_2_run;
	var_00["traverseToCoverAnim"] = %traverse_window_m_2_stop;
	var_00["coverType"] = "Cover Crouch";
	var_00["traverseHeight"] = 36;
	var_00["interruptDeathAnim"][0] = animscripts\utility::array(%traverse_window_death_start);
	var_00["interruptDeathAnim"][1] = animscripts\utility::array(%traverse_window_death_end);
	animscripts\traverse\shared::dotraverse(var_00);
}