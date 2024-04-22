/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: createart\mp_levity_art.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 1
 * Decompile Time: 26 ms
 * Timestamp: 4/22/2024 2:06:55 AM
*******************************************************************/

//Function Number: 1
main()
{
	level.tweakfile = 1;
	if(isusinghdr())
	{
		maps\createart\mp_levity_fog_hdr::setupfog();
	}
	else
	{
		maps\createart\mp_levity_fog::setupfog();
	}

	visionsetnaked("mp_levity",0);
}