/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps/createart/seoul_fog.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 1
 * Decompile Time: 14 ms
 * Timestamp: 10/27/2023 2:07:00 AM
*******************************************************************/

//Function Number: 1
main()
{
	var_00 = maps\_utility::create_vision_set_fog("seoul");
	var_00.startdist = 17346.26;
	var_00.halfwaydist = 32487.6;
	var_00.red = 0.583682;
	var_00.green = 0.52939;
	var_00.blue = 0.302793;
	var_00.maxopacity = 0;
	var_00.transitiontime = 0;
	var_00.sunfogenabled = 0;
	var_00 = maps\_utility::create_vision_set_fog("seoul_hotel_interior");
	var_00.startdist = 17346.26;
	var_00.halfwaydist = 32487.6;
	var_00.red = 0.583682;
	var_00.green = 0.52939;
	var_00.blue = 0.302793;
	var_00.maxopacity = 0;
	var_00.transitiontime = 0;
	var_00.sunfogenabled = 0;
	var_00 = maps\_utility::create_vision_set_fog("seoul_space_entry");
	var_00.startdist = 17346.26;
	var_00.halfwaydist = 32487.6;
	var_00.red = 0.583682;
	var_00.green = 0.52939;
	var_00.blue = 0.302793;
	var_00.maxopacity = 0;
	var_00.transitiontime = 0;
	var_00.sunfogenabled = 0;
	var_00 = maps\_utility::create_vision_set_fog("seoul_space_black");
	var_00.startdist = 150;
	var_00.halfwaydist = 200;
	var_00.red = 0;
	var_00.green = 0;
	var_00.blue = 0;
	var_00.maxopacity = 1;
	var_00.transitiontime = 0;
	var_00.sunfogenabled = 0;
	var_00 = maps\_utility::create_vision_set_fog("seoul_space_white");
	var_00.startdist = 150;
	var_00.halfwaydist = 200;
	var_00.red = 1;
	var_00.green = 1;
	var_00.blue = 1;
	var_00.maxopacity = 1;
	var_00.transitiontime = 0;
	var_00.sunfogenabled = 0;
	var_00 = maps\_utility::create_vision_set_fog("seoul_space_orange");
	var_00.startdist = 100;
	var_00.halfwaydist = 300;
	var_00.red = 1;
	var_00.green = 0.7734;
	var_00.blue = 0.6;
	var_00.maxopacity = 1;
	var_00.transitiontime = 0;
	var_00.sunfogenabled = 0;
	var_00 = maps\_utility::create_vision_set_fog("seoul_bigwar_intersection");
	var_00.startdist = 1000;
	var_00.halfwaydist = 10000;
	var_00.red = 0.7;
	var_00.green = 0.72;
	var_00.blue = 0.75;
	var_00.maxopacity = 0.7;
	var_00.transitiontime = 0;
	var_00.sunfogenabled = 0;
	var_00 = maps\_utility::create_vision_set_fog("seoul_final_street");
	var_00.startdist = 50;
	var_00.halfwaydist = 1000;
	var_00.red = 0.4;
	var_00.green = 0.42;
	var_00.blue = 0.45;
	var_00.maxopacity = 1;
	var_00.transitiontime = 0;
	var_00.sunfogenabled = 0;
	var_00 = maps\_utility::create_vision_set_fog("seoul_smart_missile_attack");
	var_00.startdist = 0;
	var_00.halfwaydist = 1800;
	var_00.red = 0.7;
	var_00.green = 0.72;
	var_00.blue = 0.75;
	var_00.maxopacity = 1;
	var_00.transitiontime = 0;
	var_00.sunfogenabled = 0;
	var_00 = maps\_utility::create_vision_set_fog("seoul_shopping_district_outdoors");
	var_00.startdist = 100.26;
	var_00.halfwaydist = 6000.6;
	var_00.red = 0.583682;
	var_00.green = 0.52939;
	var_00.blue = 0.302793;
	var_00.maxopacity = 1;
	var_00.transitiontime = 0;
	var_00.sunfogenabled = 0;
	maps\_utility::vision_set_fog_changes("seoul",0);
}