/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\prologue_fx.gsc
 * Game: Call of Duty: Ghosts
 * Platform: Console
 * Function Count: 1
 * Decompile Time: 14 ms
 * Timestamp: 10/27/2023 1:38:10 AM
*******************************************************************/

//Function Number: 1
func_4FDD()
{
	if(!getdvarint("r_reflectionProbeGenerate"))
	{
		maps\createfx\prologue_fx::func_4FDD();
		maps\createfx\prologue_sound::func_4FDD();
	}
}