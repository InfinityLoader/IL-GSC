/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: codescripts\delete.gsc
 * Game: Call of Duty: Modern Warfare Remastered
 * Platform: PC
 * Function Count: 1
 * Decompile Time: 14 ms
 * Timestamp: 10/27/2023 2:38:36 AM
*******************************************************************/

//Function Number: 1
main()
{
	wait(0);
	if(isdefined(self))
	{
		self delete();
	}
}