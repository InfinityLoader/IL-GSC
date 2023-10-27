/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: animscripts\traverse\window_divethrough_36.gsc
 * Game: Call of Duty: Ghosts
 * Platform: Console
 * Function Count: 2
 * Decompile Time: 36 ms
 * Timestamp: 10/27/2023 1:35:58 AM
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
	%traverse_window_m_2_dive;
	var_00["traverseAnim"] = 1;
	var_00["traverseStopsAtEnd"] = 36;
	lib_7472::func_6176(var_00);
}