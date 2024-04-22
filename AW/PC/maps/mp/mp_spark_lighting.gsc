/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: mp\mp_spark_lighting.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 1
 * Decompile Time: 30 ms
 * Timestamp: 4/22/2024 2:18:28 AM
*******************************************************************/

//Function Number: 1
main()
{
	setdvar("r_lightGridEnableTweaks",1);
	setdvar("r_lightGridIntensity",1.33);
	if(level.nextgen)
	{
		level.ospvisionset = "mp_spark_osp";
		level.osplightset = "mp_spark_osp";
		level.dronevisionset = "mp_spark_drone";
		level.dronelightset = "mp_spark_drone";
		level.warbirdvisionset = "mp_spark_warbird";
		level.warbirdlightset = "mp_spark_warbird";
		level.dnavisionset = "mp_spark_dna";
		setdvar("r_hemiAoEnable",0);
		return;
	}

	level.ospvisionset = "mp_spark_osp_cg";
	level.dronevisionset = "mp_spark_drone_cg";
	level.warbirdvisionset = "mp_spark_warbird_cg";
	level.dnavisionset = "mp_spark_dna_cg";
	setdvar("r_hemiAoEnable",0);
}