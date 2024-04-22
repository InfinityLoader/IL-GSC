/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: createart\mp_blackbox_art.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 1
 * Decompile Time: 20 ms
 * Timestamp: 4/22/2024 2:06:40 AM
*******************************************************************/

//Function Number: 1
main()
{
	level.tweakfile = 1;
	if(isusinghdr())
	{
		maps\createart\mp_blackbox_fog_hdr::setupfog();
	}
	else
	{
		maps\createart\mp_blackbox_fog::setupfog();
	}

	visionsetnaked("mp_blackbox",0);
}