/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps/createart/mp_venus_fog.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 29 ms
 * Timestamp: 10/27/2023 1:48:20 AM
*******************************************************************/

//Function Number: 1
main()
{
	var_00 = maps\mp\_art::create_vision_set_fog("mp_venus");
	var_00.startdist = 17346.26;
	var_00.halfwaydist = 32487.6;
	var_00.red = 0.583682;
	var_00.green = 0.52939;
	var_00.blue = 0.302793;
	var_00.maxopacity = 1;
	var_00.transitiontime = 0;
	var_00.sunfogenabled = 0;
}

//Function Number: 2
setupfog()
{
}