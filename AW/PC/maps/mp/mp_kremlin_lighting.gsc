/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: mp\mp_kremlin_lighting.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 39 ms
 * Timestamp: 4/22/2024 2:17:39 AM
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