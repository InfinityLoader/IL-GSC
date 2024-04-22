/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: createart\irons_estate_fog.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 1
 * Decompile Time: 25 ms
 * Timestamp: 4/22/2024 2:06:37 AM
*******************************************************************/

//Function Number: 1
main()
{
	var_00 = maps\_utility::create_vision_set_fog("irons_estate");
	var_00.startdist = 900;
	var_00.halfwaydist = 2868.8;
	var_00.red = 0.55;
	var_00.green = 0.76;
	var_00.blue = 0.77;
	var_00.hdrcolorintensity = 5.24;
	var_00.maxopacity = 0.8;
	var_00.transitiontime = 0;
	var_00.sunfogenabled = 0;
	maps\_utility::vision_set_fog_changes("irons_estate",0);
}