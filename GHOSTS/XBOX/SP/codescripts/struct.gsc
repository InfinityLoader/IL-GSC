/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: codescripts\struct.gsc
 * Game: Call of Duty: Ghosts
 * Platform: Console
 * Function Count: 2
 * Decompile Time: 30 ms
 * Timestamp: 10/27/2023 1:38:29 AM
*******************************************************************/

//Function Number: 1
func_4655()
{
	level.struct = [];
}

//Function Number: 2
createstruct()
{
	var_00 = addstruct();
	level.struct[level.struct.size] = var_00;
	return var_00;
}