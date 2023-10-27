/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\createart\mp_bog_art.gsc
 * Game: Call of Duty: Modern Warfare Remastered
 * Platform: PC
 * Function Count: 1
 * Decompile Time: 37 ms
 * Timestamp: 10/27/2023 2:36:42 AM
*******************************************************************/

//Function Number: 1
main()
{
	level.tweakfile = 1;
	if(isusinghdr())
	{
		maps\createart\mp_bog_fog_hdr::setupfog();
	}
	else
	{
		maps\createart\mp_bog_fog::setupfog();
	}

	visionsetnaked("mp_bog",0);
}