/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 1342.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 0 ms
 * Timestamp: 10/27/2023 1:57:06 AM
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