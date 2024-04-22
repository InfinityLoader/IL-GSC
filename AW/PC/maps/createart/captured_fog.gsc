/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: createart\captured_fog.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 1
 * Decompile Time: 31 ms
 * Timestamp: 4/22/2024 2:06:30 AM
*******************************************************************/

//Function Number: 1
main()
{
	var_00 = maps\_utility::create_vision_set_fog("captured");
	var_00.startdist = 2048;
	var_00.halfwaydist = 25487.6;
	var_00.red = 0.583682;
	var_00.green = 0.52939;
	var_00.blue = 0.302793;
	var_00.maxopacity = 1;
	var_00.transitiontime = 0;
	var_00.sunfogenabled = 0;
	maps\_utility::vision_set_fog_changes("captured",0);
}