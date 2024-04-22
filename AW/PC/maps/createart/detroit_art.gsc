/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: createart\detroit_art.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 1
 * Decompile Time: 20 ms
 * Timestamp: 4/22/2024 2:06:32 AM
*******************************************************************/

//Function Number: 1
main()
{
	level.tweakfile = 1;
	level.player = getentarray("player","classname")[0];
	if(isusinghdr())
	{
		maps\createart\detroit_fog_hdr::main();
		return;
	}

	maps\createart\detroit_fog::main();
}