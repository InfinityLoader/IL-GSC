/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: mp\mp_torqued_lighting.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 1
 * Decompile Time: 32 ms
 * Timestamp: 4/22/2024 2:18:38 AM
*******************************************************************/

//Function Number: 1
main()
{
	setdvar("r_reflectionprobefog","1");
	setdvar("r_lightGridEnableTweaks","1");
	setdvar("r_lightGridIntensity","1.33");
	setdvar("r_volumeLightScatter","0");
	setdvar("r_volumeLightScatterUseTweaks","1");
	setdvar("r_volumeLightScatterAngularAtten",".34");
	setdvar("r_volumeLightScatterColor","0 0 0");
	setdvar("r_volumeLightScatterLinearAtten","1");
	setdvar("r_volumeLightScatterEV","1");
	setdvar("r_volumeLightScatterBackgroundDistance","200000");
	setdvar("r_mpRimColor",".75 0.8 0.8");
	setdvar("r_mpRimStrength","9");
	setdvar("r_mpRimDiffuseTint",".7 .7 .7");
	setdvar("r_gunSightColorEntityScale","7");
	setdvar("r_gunSightColorNoneScale","0.8");
	if(level.currentgen)
	{
		setdvar("r_intensity",1.15);
		setdvar("r_brightness",getdvar("r_brightness") + 0.07);
	}
}