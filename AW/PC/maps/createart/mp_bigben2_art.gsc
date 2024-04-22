/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: createart\mp_bigben2_art.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 1
 * Decompile Time: 20 ms
 * Timestamp: 4/22/2024 2:06:39 AM
*******************************************************************/

//Function Number: 1
main()
{
	level.tweakfile = 1;
	if(isusinghdr())
	{
		maps\createart\mp_bigben2_fog_hdr::setupfog();
	}
	else
	{
		maps\createart\mp_bigben2_fog::setupfog();
	}

	visionsetnaked("mp_bigben2",0);
}