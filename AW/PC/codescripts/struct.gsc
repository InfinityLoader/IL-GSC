/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: struct.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 32 ms
 * Timestamp: 4/22/2024 2:02:46 AM
*******************************************************************/

//Function Number: 1
initstructs()
{
	level.struct = [];
}

//Function Number: 2
createstruct()
{
	var_00 = spawnstruct();
	level.struct[level.struct.size] = var_00;
	return var_00;
}