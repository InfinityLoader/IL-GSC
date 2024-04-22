/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: mp\mp_prison_lighting.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 49 ms
 * Timestamp: 4/22/2024 2:18:10 AM
*******************************************************************/

//Function Number: 1
main()
{
	setdvar("r_lightGridEnableTweaks",1);
	setdvar("r_lightGridIntensity",1.33);
	setdvar("r_mpRimColor","0.8 0.6 0.3");
	setdvar("r_mpRimStrength","10");
	setdvar("r_mpRimDiffuseTint","1.5 1.5 1.5");
	setdvar("r_gunSightColorEntityScale","7");
	setdvar("r_gunSightColorNoneScale","0.8");
	if(level.currentgen)
	{
		setdvar("r_specularcolorscale",1);
	}

	maps\mp\_mp_lights::init();
}

//Function Number: 2
fire_flicker()
{
	maps\mp\_mp_lights::play_flickerlight_preset("fire","fire_flicker",3000);
}