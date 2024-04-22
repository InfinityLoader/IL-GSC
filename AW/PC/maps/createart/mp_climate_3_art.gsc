/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: createart\mp_climate_3_art.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 1
 * Decompile Time: 21 ms
 * Timestamp: 4/22/2024 2:06:41 AM
*******************************************************************/

//Function Number: 1
main()
{
	level.tweakfile = 1;
	if(isusinghdr())
	{
		maps\createart\mp_climate_3_fog_hdr::setupfog();
	}
	else
	{
		maps\createart\mp_climate_3_fog::setupfog();
	}

	visionsetnaked("mp_climate_3",0);
}