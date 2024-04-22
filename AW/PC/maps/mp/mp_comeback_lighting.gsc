/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: mp\mp_comeback_lighting.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 1
 * Decompile Time: 35 ms
 * Timestamp: 4/22/2024 2:17:17 AM
*******************************************************************/

//Function Number: 1
main()
{
	setdvar("r_reflectionprobefog","1");
	setdvar("r_lightGridEnableTweaks","1");
	setdvar("r_lightGridIntensity","1.33");
	setdvar("r_gunSightColorEntityScale","7");
	setdvar("r_gunSightColorNoneScale","0.8");
	if(level.currentgen)
	{
		setdvar("r_intensity",1.15);
		setdvar("r_brightness",getdvar("r_brightness") + 0.07);
	}
}