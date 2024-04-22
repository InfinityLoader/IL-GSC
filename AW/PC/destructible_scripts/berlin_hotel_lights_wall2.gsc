/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: berlin_hotel_lights_wall2.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 31 ms
 * Timestamp: 4/22/2024 2:03:24 AM
*******************************************************************/

//Function Number: 1
main()
{
	dest_onestate("berlin_hotel_lights_wall2","berlin_hotel_lights_wall2_destroyed","fx/misc/light_blowout_wall_runner");
}

//Function Number: 2
dest_onestate(param_00,param_01,param_02,param_03)
{
	common_scripts\_destructible::destructible_create(param_00,"tag_origin",150,undefined,32);
	common_scripts\_destructible::destructible_fx("tag_fx",param_02);
	common_scripts\_destructible::destructible_state("tag_origin",param_01,undefined,undefined,"no_meele");
	if(isdefined(param_03))
	{
		common_scripts\_destructible::destructible_sound(param_03);
	}
}