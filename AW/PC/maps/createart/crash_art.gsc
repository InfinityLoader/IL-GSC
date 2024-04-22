/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: createart\crash_art.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 1
 * Decompile Time: 23 ms
 * Timestamp: 4/22/2024 2:06:30 AM
*******************************************************************/

//Function Number: 1
main()
{
	level.tweakfile = 1;
	level.player = getentarray("player","classname")[0];
	if(isusinghdr())
	{
		maps\createart\crash_fog_hdr::main();
		return;
	}

	maps\createart\crash_fog::main();
}