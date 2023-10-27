/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\anim\traverse\zg_run330_and_jump160.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 3
 * Decompile Time: 180 ms
 * Timestamp: 10/26/2023 11:59:49 PM
*******************************************************************/

//Function Number: 1
main()
{
	func_13EF5();
}

//Function Number: 2
func_13EF5()
{
	var_00 = [];
	var_00["traverseAnim"] = func_7814();
	scripts\anim\traverse\shared::func_5AC3(var_00);
}

//Function Number: 3
func_7814()
{
	return %hm_zg_red_exposed_traversal_step_01;
}