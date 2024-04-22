/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: mp\mp_sector17_lighting.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 1
 * Decompile Time: 29 ms
 * Timestamp: 4/22/2024 2:18:20 AM
*******************************************************************/

//Function Number: 1
main()
{
	setdvar("r_lightGridEnableTweaks",1);
	setdvar("r_lightGridIntensity",1.33);
	if(level.nextgen)
	{
		level.ospvisionset = "mp_sector17_osp";
		level.osplightset = "mp_sector17_osp";
		level.dronevisionset = "mp_sector17_drone";
		level.dronelightset = "mp_sector17_drone";
		level.warbirdvisionset = "mp_sector17_warbird";
		level.warbirdlightset = "mp_sector17_warbird";
	}
}