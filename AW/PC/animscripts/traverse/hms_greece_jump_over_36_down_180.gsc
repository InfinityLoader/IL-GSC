/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: traverse\hms_greece_jump_over_36_down_180.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 41 ms
 * Timestamp: 4/22/2024 1:59:20 AM
*******************************************************************/

//Function Number: 1
main()
{
	hms_greece_jump_over_36_down_180();
}

//Function Number: 2
hms_greece_jump_over_36_down_180()
{
	var_00[0] = %hms_greece_traverse_balcony_ledge_180;
	var_00[1] = %hms_greece_traverse_balcony_ledge_180_b;
	var_01 = [];
	var_01["traverseAnim"] = var_00[randomint(var_00.size)];
	var_01["traverseHeight"] = 36;
	animscripts\traverse\shared::dotraverse(var_01);
}