/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: createart\mp_dam_fog.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 39 ms
 * Timestamp: 4/22/2024 2:06:44 AM
*******************************************************************/

//Function Number: 1
main()
{
	var_00 = maps\mp\_art::create_vision_set_fog("mp_dam");
	var_00.startdist = 1050;
	var_00.halfwaydist = 34000;
	var_00.red = 0.8;
	var_00.green = 0.86;
	var_00.blue = 0.97;
	var_00.maxopacity = 0.17;
	var_00.transitiontime = 0;
	var_00.sunfogenabled = 0;
	var_00 = maps\mp\_art::create_vision_set_fog("mp_dam_underground");
	var_00.startdist = 500;
	var_00.halfwaydist = 5000;
	var_00.red = 0.83;
	var_00.green = 0.72;
	var_00.blue = 0.58;
	var_00.maxopacity = 0.4;
	var_00.transitiontime = 0;
	var_00.sunfogenabled = 0;
	var_00 = maps\mp\_art::create_vision_set_fog("mp_dam_interior");
	var_00.startdist = 1050;
	var_00.halfwaydist = 34000;
	var_00.red = 0.76;
	var_00.green = 0.89;
	var_00.blue = 0.88;
	var_00.maxopacity = 0.19;
	var_00.transitiontime = 0;
	var_00.sunfogenabled = 0;
}

//Function Number: 2
setupfog()
{
}