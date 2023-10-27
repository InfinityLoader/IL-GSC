/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\anim\traverse\window_divethrough_36.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 168 ms
 * Timestamp: 10/26/2023 11:59:47 PM
*******************************************************************/

//Function Number: 1
main()
{
	if(self.type == "dog")
	{
		scripts\anim\traverse\shared::func_586D("window_40",40);
		return;
	}

	func_B0CC();
}

//Function Number: 2
func_B0CC()
{
	var_00 = [];
	var_00["traverseAnim"] = %traverse_window_m_2_dive;
	if(getdvarint("ai_iw7",0) == 0)
	{
		scripts\anim\traverse\shared::func_5AC3(var_00);
		return;
	}

	self waittill("killanimscript");
}