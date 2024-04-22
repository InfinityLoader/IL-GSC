/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: traverse\hms_greece_jump_over_32_down_192.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 40 ms
 * Timestamp: 4/22/2024 1:59:19 AM
*******************************************************************/

//Function Number: 1
main()
{
	hms_greece_jump_over_32_down_192();
}

//Function Number: 2
hms_greece_jump_over_32_down_192()
{
	var_00 = [];
	var_00["traverseAnim"] = %hms_greece_alleys_traversal_balconyledgedrop_32_192;
	var_00["traverseHeight"] = 32;
	animscripts\traverse\shared::dotraverse(var_00);
}