/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\anim\traverse\iw6_stepup_32.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 3
 * Decompile Time: 148 ms
 * Timestamp: 10/26/2023 11:59:27 PM
*******************************************************************/

//Function Number: 1
main()
{
	func_B0CC();
}

//Function Number: 2
func_B0CC()
{
	var_00 = [];
	var_00["traverseAnim"] = func_7814();
	if(getdvarint("ai_iw7",0) == 0)
	{
		scripts\anim\traverse\shared::func_5AC3(var_00);
		return;
	}

	self waittill("killanimscript");
}

//Function Number: 3
func_7814()
{
	return %flood_traverse_stepup_32_v1;
}