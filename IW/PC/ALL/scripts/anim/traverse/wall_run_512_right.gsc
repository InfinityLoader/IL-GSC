/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\anim\traverse\wall_run_512_right.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 3
 * Decompile Time: 201 ms
 * Timestamp: 10/26/2023 11:59:47 PM
*******************************************************************/

//Function Number: 1
main()
{
	func_138D3();
}

//Function Number: 2
func_138D3()
{
	var_00 = [];
	var_00["traverseAnim"] = func_7814();
	scripts\anim\traverse\shared::func_5AC3(var_00);
}

//Function Number: 3
func_7814()
{
	return %asteroid_wallrun_r;
}