/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: codescripts\struct.gsc
 * Game: Call of Duty: Modern Warfare Remastered
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 33 ms
 * Timestamp: 10/27/2023 2:38:36 AM
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