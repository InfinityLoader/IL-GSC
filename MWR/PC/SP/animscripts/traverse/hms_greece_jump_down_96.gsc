/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: animscripts\traverse\hms_greece_jump_down_96.gsc
 * Game: Call of Duty: Modern Warfare Remastered
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 43 ms
 * Timestamp: 10/27/2023 2:42:44 AM
*******************************************************************/

//Function Number: 1
main()
{
	hms_greece_jump_down_96();
}

//Function Number: 2
hms_greece_jump_down_96()
{
	var_00 = [];
	var_00[0] = %hms_greece_traverse_jumpdown96_01;
	var_00[1] = %hms_greece_traverse_jumpdown96_02;
	var_01 = [];
	var_01["traverseAnim"] = var_00[randomint(var_00.size)];
	animscripts\traverse\shared::dotraverse(var_01);
}