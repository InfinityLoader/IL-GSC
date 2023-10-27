/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 3403.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 1
 * Decompile Time: 0 ms
 * Timestamp: 10/27/2023 12:27:04 AM
*******************************************************************/

//Function Number: 1
func_53E3()
{
	var_00 = undefined;
	foreach(var_02 in level.players)
	{
		if(var_02 ishost())
		{
			var_00 = var_02;
			break;
		}
	}

	return var_00;
}