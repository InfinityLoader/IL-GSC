/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: mp\mp_seoul2_lighting.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 46 ms
 * Timestamp: 4/22/2024 2:18:22 AM
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
		setdvar("r_disablelightsets",0);
	}
}