/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 474.gsc
 * Game: Call of Duty: WWII
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 1 ms
 * Timestamp: 10/27/2023 3:26:07 AM
*******************************************************************/

//Function Number: 1
func_00F9()
{
	wait(0);
	if(isdefined(self))
	{
		self delete();
	}
}

//Function Number: 2
func_0044()
{
	self endon("death");
	wait 0.05;
	self delete();
}