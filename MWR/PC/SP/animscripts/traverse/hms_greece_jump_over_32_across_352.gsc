/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: animscripts\traverse\hms_greece_jump_over_32_across_352.gsc
 * Game: Call of Duty: Modern Warfare Remastered
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 46 ms
 * Timestamp: 10/27/2023 2:42:45 AM
*******************************************************************/

//Function Number: 1
main()
{
	hms_greece_jump_over_32_across_352();
}

//Function Number: 2
hms_greece_jump_over_32_across_352()
{
	var_00 = [];
	var_00["traverseAnim"] = %hms_greece_traverse_balcony_custom_03;
	var_00["traverseHeight"] = 32;
	animscripts\traverse\shared::dotraverse(var_00);
}