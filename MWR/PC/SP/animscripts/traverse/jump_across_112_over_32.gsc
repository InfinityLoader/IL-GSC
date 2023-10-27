/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: animscripts\traverse\jump_across_112_over_32.gsc
 * Game: Call of Duty: Modern Warfare Remastered
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 57 ms
 * Timestamp: 10/27/2023 2:42:57 AM
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