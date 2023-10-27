/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes\_playercards.gsc
 * Game: Call of Duty: WWII
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 28 ms
 * Timestamp: 10/27/2023 3:24:05 AM
*******************************************************************/

//Function Number: 1
func_00D5()
{
	level thread func_6B6C();
}

//Function Number: 2
func_6B6C()
{
	for(;;)
	{
		level waittill("connected",var_00);
		if(!isai(var_00))
		{
		}
	}
}