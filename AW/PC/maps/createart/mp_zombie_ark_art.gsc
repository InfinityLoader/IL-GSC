/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: createart\mp_zombie_ark_art.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 1
 * Decompile Time: 29 ms
 * Timestamp: 4/22/2024 2:07:14 AM
*******************************************************************/

//Function Number: 1
main()
{
	level.tweakfile = 1;
	if(isusinghdr())
	{
		maps\createart\mp_zombie_ark_fog_hdr::setupfog();
	}
	else
	{
		maps\createart\mp_zombie_ark_fog::setupfog();
	}

	visionsetnaked("mp_zombie_ark",0);
}