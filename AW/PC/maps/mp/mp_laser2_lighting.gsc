/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: mp\mp_laser2_lighting.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 1
 * Decompile Time: 29 ms
 * Timestamp: 4/22/2024 2:17:53 AM
*******************************************************************/

//Function Number: 1
main()
{
	setdvar("r_reflectionprobefog","1");
	setdvar("r_lightGridEnableTweaks","1");
	setdvar("r_lightGridIntensity","1.33");
	setdvar("r_volumeLightScatter","1");
	setdvar("r_volumeLightScatterUseTweaks","1");
	setdvar("r_volumeLightScatterAngularAtten",".34");
	setdvar("r_volumeLightScatterColor","0.97  0.98 0.96");
	setdvar("r_volumeLightScatterLinearAtten","1");
	setdvar("r_volumeLightScatterEV","12.7");
	setdvar("r_volumeLightScatterBackgroundDistance","200000");
	setdvar("r_gunSightColorEntityScale","7");
	setdvar("r_gunSightColorNoneScale","0.8");
	setdvar("r_mpRimColor","1 0.8 0.5");
	setdvar("r_mpRimStrength","0");
	setdvar("r_mpRimDiffuseTint","1 1 1");
	if(level.currentgen)
	{
		setdvar("r_intensity",1.15);
		setdvar("r_brightness",getdvar("r_brightness") + 0.07);
	}
}