/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: createart\mp_sector17_art.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 1
 * Decompile Time: 28 ms
 * Timestamp: 4/22/2024 2:07:03 AM
*******************************************************************/

//Function Number: 1
main()
{
	level.tweakfile = 1;
	if(isusinghdr())
	{
		maps\createart\mp_sector17_fog_hdr::setupfog();
	}
	else
	{
		maps\createart\mp_sector17_fog::setupfog();
	}

	visionsetnaked("mp_sector17",0);
}