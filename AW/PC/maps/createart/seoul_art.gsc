/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: createart\seoul_art.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 1
 * Decompile Time: 26 ms
 * Timestamp: 4/22/2024 2:07:22 AM
*******************************************************************/

//Function Number: 1
main()
{
	level.tweakfile = 1;
	level.player = getentarray("player","classname")[0];
	if(isusinghdr())
	{
		maps\createart\seoul_fog_hdr::main();
		return;
	}

	maps\createart\seoul_fog::main();
}