/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: createart\mp_clowntown3_art.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 1
 * Decompile Time: 22 ms
 * Timestamp: 4/22/2024 2:06:42 AM
*******************************************************************/

//Function Number: 1
main()
{
	level.tweakfile = 1;
	if(isusinghdr())
	{
		maps\createart\mp_clowntown3_fog_hdr::setupfog();
	}
	else
	{
		maps\createart\mp_clowntown3_fog::setupfog();
	}

	visionsetnaked("mp_clowntown3",0);
}