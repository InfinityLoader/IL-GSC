/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\anim\traverse\window_over_quick.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 357 ms
 * Timestamp: 10/26/2023 11:59:48 PM
*******************************************************************/

//Function Number: 1
main()
{
	if(self.type == "dog")
	{
		scripts\anim\traverse\shared::func_586D("window_40",40);
		return;
	}

	func_A4CC();
}

//Function Number: 2
func_A4CC()
{
	var_00 = [];
	var_00["traverseAnim"] = %traverse_window_quick;
	if(getdvarint("ai_iw7",0) == 0)
	{
		scripts\anim\traverse\shared::func_5AC3(var_00);
		return;
	}

	self waittill("killanimscript");
}