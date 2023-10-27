/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\code\delete.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 1
 * Decompile Time: 85 ms
 * Timestamp: 10/27/2023 12:03:07 AM
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