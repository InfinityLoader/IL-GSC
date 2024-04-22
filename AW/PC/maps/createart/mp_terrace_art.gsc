/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: createart\mp_terrace_art.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 1
 * Decompile Time: 35 ms
 * Timestamp: 4/22/2024 2:07:08 AM
*******************************************************************/

//Function Number: 1
main()
{
	level.tweakfile = 1;
	if(isusinghdr())
	{
		maps\createart\mp_terrace_fog_hdr::setupfog();
	}
	else
	{
		maps\createart\mp_terrace_fog::setupfog();
	}

	visionsetnaked("mp_terrace",0);
}