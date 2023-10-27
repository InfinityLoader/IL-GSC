/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: animscripts\traverse\walk_casual.gsc
 * Game: Call of Duty: Modern Warfare Remastered
 * Platform: PC
 * Function Count: 1
 * Decompile Time: 30 ms
 * Timestamp: 10/27/2023 2:43:16 AM
*******************************************************************/

//Function Number: 1
main()
{
	var_00 = [];
	var_00["traverseAnim"] = %unarmed_walk_slow;
	var_00["traverseHeight"] = 0;
	animscripts\traverse\shared::dotraverse(var_00);
}