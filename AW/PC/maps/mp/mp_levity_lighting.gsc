/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: mp\mp_levity_lighting.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 1
 * Decompile Time: 28 ms
 * Timestamp: 4/22/2024 2:17:55 AM
*******************************************************************/

//Function Number: 1
main()
{
	setdvar("r_lightGridEnableTweaks",1);
	setdvar("r_lightGridIntensity",1.33);
	setdvar("r_mpRimColor",".7 .9 1");
	setdvar("r_mpRimStrength","7");
	setdvar("r_mpRimDiffuseTint",".77 .85 1.1");
	setdvar("r_gunSightColorEntityScale","7");
	setdvar("r_gunSightColorNoneScale","0.8");
	if(level.currentgen)
	{
		level.ospvisionset = "mp_levity_osp";
		level.osplightset = "mp_levity_osp";
		level.warbirdvisionset = "mp_levity_warbird";
		level.warbirdlightset = "mp_levity_warbird";
		level.dronevisionset = "mp_levity_drone";
		level.dronelightset = "mp_levity_drone";
	}
}