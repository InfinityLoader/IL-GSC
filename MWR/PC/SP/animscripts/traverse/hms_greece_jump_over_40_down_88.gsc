/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: animscripts\traverse\hms_greece_jump_over_40_down_88.gsc
 * Game: Call of Duty: Modern Warfare Remastered
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 63 ms
 * Timestamp: 10/27/2023 2:42:50 AM
*******************************************************************/

//Function Number: 1
main()
{
	hms_greece_jump_over_40_down_88();
}

//Function Number: 2
hms_greece_jump_over_40_down_88()
{
	var_00[0] = %hms_greece_traverse_upper_2_lower_floor_40_88;
	var_00[1] = %hms_greece_traverse_upper_2_lower_floor_40_88_b;
	var_01 = [];
	var_01["traverseAnim"] = var_00[randomint(var_00.size)];
	var_01["traverseHeight"] = 40;
	animscripts\traverse\shared::dotraverse(var_01);
}