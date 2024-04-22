/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: traverse\jump_across_112_over_32.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 49 ms
 * Timestamp: 4/22/2024 1:59:25 AM
*******************************************************************/

//Function Number: 1
main()
{
	jump_across_112_over_32();
}

//Function Number: 2
jump_across_112_over_32()
{
	var_00 = [];
	var_00["traverseAnim"] = %jump_across_112_over_32;
	var_00["traverseHeight"] = 32;
	animscripts\traverse\shared::dotraverse(var_00);
}