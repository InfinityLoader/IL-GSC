/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: createart\mp_refraction_fog.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 41 ms
 * Timestamp: 4/22/2024 2:07:02 AM
*******************************************************************/

//Function Number: 1
main()
{
	var_00 = maps\mp\_art::create_vision_set_fog("mp_refraction");
	var_00.startdist = 786;
	var_00.halfwaydist = 55000;
	var_00.red = 0.586;
	var_00.green = 0.833;
	var_00.blue = 0.817;
	var_00.maxopacity = 0.5;
	var_00.transitiontime = 0;
	var_00.sunfogenabled = 0;
}

//Function Number: 2
setupfog()
{
}