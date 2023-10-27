/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes\_playercards.gsc
 * Game: Call of Duty: Ghosts
 * Platform: Console
 * Function Count: 2
 * Decompile Time: 34 ms
 * Timestamp: 10/27/2023 1:31:24 AM
*******************************************************************/

//Function Number: 1
func_44DF()
{
	level thread func_595D();
}

//Function Number: 2
func_595D()
{
	for(;;)
	{
		level waittill("connected",var_00);
		if(!isai(var_00))
		{
			var_00.playercardpatch = var_00 getcacplayerdata("patch");
			var_00.playercardpatchbacking = var_00 getcacplayerdata("patchbacking");
			var_00.playercardbackground = var_00 getcacplayerdata("background");
		}
	}
}