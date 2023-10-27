/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: animscripts\traverse\hms_greece_jump_over_36_down_208.gsc
 * Game: Call of Duty: Modern Warfare Remastered
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 44 ms
 * Timestamp: 10/27/2023 2:42:49 AM
*******************************************************************/

//Function Number: 1
main()
{
	hms_greece_jump_over_36_down_208();
}

//Function Number: 2
hms_greece_jump_over_36_down_208()
{
	var_00[0] = %hms_greece_traverse_upper_2_lower_floor_36_208;
	var_00[1] = %hms_greece_traverse_upper_2_lower_floor_36_208_b;
	var_01 = [];
	var_01["traverseAnim"] = var_00[randomint(var_00.size)];
	var_01["traverseHeight"] = 36;
	animscripts\traverse\shared::dotraverse(var_01);
}