/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps/createart/mp_venus_art.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 1
 * Decompile Time: 14 ms
 * Timestamp: 10/27/2023 1:48:20 AM
*******************************************************************/

//Function Number: 1
main()
{
	level.tweakfile = 1;
	if(isusinghdr())
	{
		maps\createart\mp_venus_fog_hdr::setupfog();
	}
	else
	{
		maps\createart\mp_venus_fog::setupfog();
	}

	visionsetnaked("mp_venus",0);
}