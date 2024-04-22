/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: createart\mp_kremlin_art.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 1
 * Decompile Time: 27 ms
 * Timestamp: 4/22/2024 2:06:50 AM
*******************************************************************/

//Function Number: 1
main()
{
	level.tweakfile = 1;
	if(isusinghdr())
	{
		maps\createart\mp_kremlin_fog_hdr::setupfog();
	}
	else
	{
		maps\createart\mp_kremlin_fog::setupfog();
	}

	visionsetnaked("mp_kremlin",0);
}