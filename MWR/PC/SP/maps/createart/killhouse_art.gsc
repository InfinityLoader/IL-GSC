/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\createart\killhouse_art.gsc
 * Game: Call of Duty: Modern Warfare Remastered
 * Platform: PC
 * Function Count: 1
 * Decompile Time: 31 ms
 * Timestamp: 10/27/2023 2:45:30 AM
*******************************************************************/

//Function Number: 1
main()
{
	level.tweakfile = 1;
	level.player = getentarray("player","classname")[0];
	if(isusinghdr())
	{
		maps\createart\killhouse_fog_hdr::main();
		return;
	}

	maps\createart\killhouse_fog::main();
}