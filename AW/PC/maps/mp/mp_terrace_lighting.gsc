/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: mp\mp_terrace_lighting.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 3
 * Decompile Time: 62 ms
 * Timestamp: 4/22/2024 2:18:30 AM
*******************************************************************/

//Function Number: 1
main()
{
	thread set_level_lighting_values();
}

//Function Number: 2
set_level_lighting_values()
{
	if(isusinghdr())
	{
		thread setup_lighting();
	}
}

//Function Number: 3
setup_lighting()
{
	setdvar("r_lightGridEnableTweaks",1);
	setdvar("r_lightGridIntensity",1.33);
	setdvar("r_gunSightColorEntityScale","7");
	setdvar("r_gunSightColorNoneScale","0.8");
}