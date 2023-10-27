/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: animscripts\traverse\window_divethrough_36.gsc
 * Game: Call of Duty: Ghosts
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 63 ms
 * Timestamp: 10/27/2023 1:23:09 AM
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
	var_00["traverseAnim"] = %traverse_window_m_2_dive;
	var_00["traverseStopsAtEnd"] = 1;
	var_00["traverseHeight"] = 36;
	animscripts/traverse/shared::func_2A1F(var_00);
}