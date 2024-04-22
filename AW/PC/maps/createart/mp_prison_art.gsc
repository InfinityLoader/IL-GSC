/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: createart\mp_prison_art.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 1
 * Decompile Time: 29 ms
 * Timestamp: 4/22/2024 2:07:00 AM
*******************************************************************/

//Function Number: 1
main()
{
	level.tweakfile = 1;
	if(isusinghdr())
	{
		maps\createart\mp_prison_fog_hdr::setupfog();
	}
	else
	{
		maps\createart\mp_prison_fog::setupfog();
	}

	visionsetnaked("mp_prison",0);
}