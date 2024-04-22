/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: mp\mp_solar_lighting.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 46 ms
 * Timestamp: 4/22/2024 2:18:25 AM
*******************************************************************/

//Function Number: 1
main()
{
	setdvar("r_lightGridEnableTweaks",1);
	setdvar("r_lightGridIntensity",1.33);
	setdvar("r_gunSightColorEntityScale","7");
	setdvar("r_gunSightColorNoneScale","0.8");
	thread set_lighting_values();
}

//Function Number: 2
set_lighting_values()
{
	if(isusinghdr())
	{
		level waittill("connected",var_00);
	}
}