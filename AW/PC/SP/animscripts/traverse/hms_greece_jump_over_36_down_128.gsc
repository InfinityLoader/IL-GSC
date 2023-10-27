/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: animscripts\traverse\hms_greece_jump_over_36_down_128.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 47 ms
 * Timestamp: 10/27/2023 1:53:36 AM
*******************************************************************/

//Function Number: 1
main()
{
	hms_greece_jump_over_36_down_128();
}

//Function Number: 2
hms_greece_jump_over_36_down_128()
{
	var_00[0] = %hms_greece_traverse_railing_drop_36_128;
	var_00[1] = %hms_greece_traverse_railing_drop_36_128_b;
	var_01 = [];
	var_01["traverseAnim"] = var_00[randomint(var_00.size)];
	var_01["traverseHeight"] = 36;
	animscripts\traverse\shared::dotraverse(var_01);
}