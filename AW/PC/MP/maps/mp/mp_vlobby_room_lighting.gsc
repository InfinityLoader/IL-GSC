/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\mp_vlobby_room_lighting.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 1
 * Decompile Time: 30 ms
 * Timestamp: 10/27/2023 1:46:51 AM
*******************************************************************/

//Function Number: 1
main()
{
	setdvar("r_lightGridEnableTweaks",1);
	setdvar("r_lightGridIntensity",1.33);
	setdvar("r_mpRimColor","0 0 0");
	setdvar("r_mpRimStrength","0");
	setdvar("r_mpRimDiffuseTint","0 0 0");
	setdvar("sm_spotshadowfadetime",0.01);
	setdvar("sm_spotLightScoreModelScale",0.3);
	setdvar("r_gunSightColorEntityScale","7");
	setdvar("r_gunSightColorNoneScale","0.8");
}