/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: mp\mp_urban_lighting.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 1
 * Decompile Time: 28 ms
 * Timestamp: 4/22/2024 2:18:42 AM
*******************************************************************/

//Function Number: 1
main()
{
	setdvar("r_lightGridEnableTweaks",1);
	setdvar("r_lightGridIntensity",1.33);
	if(level.nextgen)
	{
		level.ospvisionset = "mp_urban_osp";
		level.osplightset = "mp_urban_osp";
		level.dronevisionset = "mp_urban_drone";
		level.dronelightset = "mp_urban_drone";
		level.warbirdvisionset = "mp_urban_warbird";
		level.warbirdlightset = "mp_urban_warbird";
	}
}