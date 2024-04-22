/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: createart\mp_refraction_art.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 1
 * Decompile Time: 26 ms
 * Timestamp: 4/22/2024 2:07:02 AM
*******************************************************************/

//Function Number: 1
main()
{
	level.tweakfile = 1;
	if(isusinghdr())
	{
		maps\createart\mp_refraction_fog_hdr::setupfog();
	}
	else
	{
		maps\createart\mp_refraction_fog::setupfog();
	}

	visionsetnaked("mp_refraction",0);
}