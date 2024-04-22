/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: createart\mp_dam_art.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 1
 * Decompile Time: 22 ms
 * Timestamp: 4/22/2024 2:06:44 AM
*******************************************************************/

//Function Number: 1
main()
{
	level.tweakfile = 1;
	if(isusinghdr())
	{
		maps\createart\mp_dam_fog_hdr::setupfog();
	}
	else
	{
		maps\createart\mp_dam_fog::setupfog();
	}

	visionsetnaked("mp_dam",0);
}