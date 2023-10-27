/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 6363.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: PC
 * Function Count: 1
 * Decompile Time: 0 ms
 * Timestamp: 10/27/2023 2:23:22 AM
*******************************************************************/

//Function Number: 1
main()
{
	var_00 = maps\_utility::create_vision_set_fog("so_survival_mp_village");
	var_00.startdist = 17346.26;
	var_00.halfwaydist = 32487.6;
	var_00.red = 0.583682;
	var_00.green = 0.52939;
	var_00.blue = 0.302793;
	var_00.maxopacity = 1;
	var_00.sunendfadeangle = 0;
	var_00.sunfogenabled = 0;
	maps\_utility::vision_set_fog_changes("so_survival_mp_village",0);
}