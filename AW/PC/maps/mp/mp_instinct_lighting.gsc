/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: mp\mp_instinct_lighting.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 1
 * Decompile Time: 33 ms
 * Timestamp: 4/22/2024 2:17:34 AM
*******************************************************************/

//Function Number: 1
main()
{
	setdvar("r_lightGridEnableTweaks",1);
	setdvar("r_lightGridIntensity",1.33);
	setdvar("r_volumeLightScatterUseTweaks","1");
	setdvar("r_lightGridEnableTweaks","1");
	setdvar("r_lightGridIntensity","1.33");
	setdvar("r_volumeLightScatter","1");
	setdvar("r_volumeLightScatterUseTweaks","1");
	setdvar("r_volumeLightScatterAngularAtten",".05");
	setdvar("r_volumeLightScatterColor",".96  0.96 0.94");
	setdvar("r_volumeLightScatterLinearAtten","1");
	setdvar("r_volumeLightScatterEV","14");
	setdvar("r_mpRimColor",".8 .8 .6 0");
	setdvar("r_mpRimStrength","0");
	setdvar("r_mpRimDiffuseTint","1.2 1.5 1.5");
	setdvar("r_gunSightColorEntityScale","7");
	setdvar("r_gunSightColorNoneScale","0.8");
	if(level.currentgen)
	{
		setdvar("r_dof_tweak",2);
	}
}