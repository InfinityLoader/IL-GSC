/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: animscripts\traverse\hms_greece_jump_across_164.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 45 ms
 * Timestamp: 10/27/2023 1:53:32 AM
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