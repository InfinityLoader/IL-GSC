/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: codescripts\delete.gsc
 * Game: Call of Duty: Ghosts
 * Platform: PC
 * Function Count: 1
 * Decompile Time: 15 ms
 * Timestamp: 10/27/2023 1:26:22 AM
*******************************************************************/

//Function Number: 1
func_4FDD()
{
	wait(0);
	if(isdefined(self))
	{
		self delete();
	}
}