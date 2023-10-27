/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: animscripts\traverse\window_divethrough_36.gsc
 * Game: Call of Duty: Modern Warfare Remastered
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 43 ms
 * Timestamp: 10/27/2023 2:43:20 AM
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