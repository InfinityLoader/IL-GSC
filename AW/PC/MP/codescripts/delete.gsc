/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: codescripts\delete.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 1
 * Decompile Time: 22 ms
 * Timestamp: 10/27/2023 1:40:12 AM
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