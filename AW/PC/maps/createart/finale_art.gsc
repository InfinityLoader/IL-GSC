/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: createart\finale_art.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 1
 * Decompile Time: 23 ms
 * Timestamp: 4/22/2024 2:06:34 AM
*******************************************************************/

//Function Number: 1
main()
{
	level.tweakfile = 1;
	level.player = getentarray("player","classname")[0];
	if(isusinghdr())
	{
		maps\createart\finale_fog_hdr::main();
		return;
	}

	maps\createart\finale_fog::main();
}