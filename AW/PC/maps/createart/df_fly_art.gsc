/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: createart\df_fly_art.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 1
 * Decompile Time: 23 ms
 * Timestamp: 4/22/2024 2:06:33 AM
*******************************************************************/

//Function Number: 1
main()
{
	level.tweakfile = 1;
	level.player = getentarray("player","classname")[0];
	if(isusinghdr())
	{
		maps\createart\df_fly_fog_hdr::main();
		return;
	}

	maps\createart\df_fly_fog::main();
}