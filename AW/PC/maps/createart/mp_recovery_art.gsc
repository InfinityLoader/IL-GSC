/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: createart\mp_recovery_art.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 1
 * Decompile Time: 37 ms
 * Timestamp: 4/22/2024 2:07:01 AM
*******************************************************************/

//Function Number: 1
main()
{
	level.tweakfile = 1;
	if(isusinghdr())
	{
		maps\createart\mp_recovery_fog_hdr::setupfog();
	}
	else
	{
		maps\createart\mp_recovery_fog::setupfog();
	}

	visionsetnaked("mp_recovery",0);
}