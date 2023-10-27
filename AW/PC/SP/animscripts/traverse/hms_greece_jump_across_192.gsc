/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: animscripts\traverse\hms_greece_jump_across_192.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 48 ms
 * Timestamp: 10/27/2023 1:53:33 AM
*******************************************************************/

//Function Number: 1
main()
{
	hms_greece_jump_across_192();
}

//Function Number: 2
hms_greece_jump_across_192()
{
	var_00 = [];
	var_00[0] = %hms_greece_traverse_jumpacross192_01;
	var_00[1] = %hms_greece_traverse_jumpacross192_02;
	var_01 = [];
	var_01["traverseAnim"] = var_00[randomint(var_00.size)];
	animscripts\traverse\shared::dotraverse(var_01);
}