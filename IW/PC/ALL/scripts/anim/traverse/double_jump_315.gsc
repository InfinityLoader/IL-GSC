/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\anim\traverse\double_jump_315.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 3
 * Decompile Time: 166 ms
 * Timestamp: 10/26/2023 11:59:24 PM
*******************************************************************/

//Function Number: 1
main()
{
	func_5AD0();
}

//Function Number: 2
func_5AD0()
{
	var_00 = [];
	var_00["traverseAnim"] = func_7814();
	scripts\anim\traverse\shared::func_5AC3(var_00);
}

//Function Number: 3
func_7814()
{
	return %traverse_doublejump_315;
}