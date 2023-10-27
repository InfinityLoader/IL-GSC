/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\killhouse_lighting.gsc
 * Game: Call of Duty: Modern Warfare Remastered
 * Platform: PC
 * Function Count: 4
 * Decompile Time: 84 ms
 * Timestamp: 10/27/2023 2:46:12 AM
*******************************************************************/

//Function Number: 1
main()
{
	init_level_lighting_flags();
	level.cheat_invert_override = "_bright";
	common_scripts\utility::flag_init("in_firerange_lighting_zone1");
	common_scripts\utility::flag_init("in_firerange_lighting_zone2");
	common_scripts\utility::flag_init("in_hangar3_lighting_zoneTower");
	common_scripts\utility::flag_init("in_hangar3_lighting_zoneHangarFloor");
	common_scripts\utility::flag_init("in_hangar3_lighting_zoneShipTopDeck");
	common_scripts\utility::flag_init("in_hangar3_lighting_zoneShipInterior1");
	common_scripts\utility::flag_init("in_hangar3_lighting_zoneShipInterior2");
	level.cheat_highcontrast_override = "_night";
	thread setup_dof_presets();
	thread set_level_lighting_values();
}

//Function Number: 2
init_level_lighting_flags()
{
}

//Function Number: 3
setup_dof_presets()
{
}

//Function Number: 4
set_level_lighting_values()
{
	maps\_utility::set_vision_set("killhouse_interior",0);
	maps\_utility::vision_set_fog_changes("killhouse_interior",0);
	level.player maps\_utility::set_light_set_player("killhouse_interior");
	level.player method_848C("clut_killhouse",0);
	setsaveddvar("fx_cast_shadow",0);
}