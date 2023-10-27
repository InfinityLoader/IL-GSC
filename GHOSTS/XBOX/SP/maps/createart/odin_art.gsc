/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\createart\odin_art.gsc
 * Game: Call of Duty: Ghosts
 * Platform: Console
 * Function Count: 1
 * Decompile Time: 16 ms
 * Timestamp: 10/27/2023 1:38:18 AM
*******************************************************************/

//Function Number: 1
func_4FDD()
{
	level.var_854C = 1;
	level.player = getentarray("player","classname")[0];
	maps\createart\odin_fog::func_4FDD();
}