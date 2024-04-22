/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: createart\credits_s1_fog_hdr.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 1
 * Decompile Time: 21 ms
 * Timestamp: 4/22/2024 2:06:32 AM
*******************************************************************/

//Function Number: 1
main()
{
	var_00 = maps\_utility::create_vision_set_fog("credits_s1");
	var_00.startdist = 17346.26;
	var_00.halfwaydist = 32487.6;
	var_00.red = 0.583682;
	var_00.green = 0.52939;
	var_00.blue = 0.302793;
	var_00.maxopacity = 1;
	var_00.transitiontime = 0;
	var_00.sunfogenabled = 0;
	maps\_utility::vision_set_fog_changes("credits_s1",0);
}