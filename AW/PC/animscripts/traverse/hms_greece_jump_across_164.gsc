/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: traverse\hms_greece_jump_across_164.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 41 ms
 * Timestamp: 4/22/2024 1:59:17 AM
*******************************************************************/

//Function Number: 1
main()
{
	hms_greece_jump_across_164();
}

//Function Number: 2
hms_greece_jump_across_164()
{
	var_00 = [];
	var_00["traverseAnim"] = %hms_greece_gap_jump_164_npc;
	animscripts\traverse\shared::dotraverse(var_00);
}