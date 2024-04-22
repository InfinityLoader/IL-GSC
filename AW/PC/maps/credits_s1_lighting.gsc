/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: credits_s1_lighting.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 53 ms
 * Timestamp: 4/22/2024 2:27:26 AM
*******************************************************************/

//Function Number: 1
main()
{
	set_level_lighting_values();
}

//Function Number: 2
set_level_lighting_values()
{
	if(isusinghdr())
	{
		setsaveddvar("r_disablelightsets",0);
	}
}