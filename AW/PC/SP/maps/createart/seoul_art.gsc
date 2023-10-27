/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps/createart/seoul_art.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 1
 * Decompile Time: 14 ms
 * Timestamp: 10/27/2023 2:07:00 AM
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