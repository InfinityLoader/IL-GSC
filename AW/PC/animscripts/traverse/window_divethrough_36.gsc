/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: traverse\window_divethrough_36.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 42 ms
 * Timestamp: 4/22/2024 1:59:46 AM
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
	var_00["traverseAnim"] = %traverse_window_m_2_dive;
	var_00["traverseStopsAtEnd"] = 1;
	var_00["traverseHeight"] = 36;
	animscripts\traverse\shared::dotraverse(var_00);
}