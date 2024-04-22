/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: createart\lab_art.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 1
 * Decompile Time: 33 ms
 * Timestamp: 4/22/2024 2:06:38 AM
*******************************************************************/

//Function Number: 1
main()
{
	level.tweakfile = 1;
	level.player = getentarray("player","classname")[0];
	if(isusinghdr())
	{
		maps\createart\lab_fog_hdr::main();
		return;
	}

	maps\createart\lab_fog::main();
}