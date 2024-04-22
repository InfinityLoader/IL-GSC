/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: createart\mp_prison_fog.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 40 ms
 * Timestamp: 4/22/2024 2:07:00 AM
*******************************************************************/

//Function Number: 1
main()
{
	var_00 = maps\mp\_art::create_vision_set_fog("mp_prison");
	var_00.startdist = 993.748;
	var_00.halfwaydist = 5378.7;
	var_00.red = 0.329026;
	var_00.green = 0.251596;
	var_00.blue = 0.202793;
	var_00.maxopacity = 0.261429;
	var_00.transitiontime = 0;
	var_00.sunfogenabled = 0;
}

//Function Number: 2
setupfog()
{
}