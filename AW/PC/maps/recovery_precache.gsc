/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: recovery_precache.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 1
 * Decompile Time: 28 ms
 * Timestamp: 4/22/2024 2:34:45 AM
*******************************************************************/

//Function Number: 1
main()
{
	common_scripts\utility::add_destructible_type_function("wall_firebox_destp",::destructible_scripts\wall_firebox_destp::main);
	destructible_scripts\wall_firebox_destp::main();
	vehicle_scripts\_civ_domestic_sedan_01::main("vehicle_civ_domestic_sedan_01_slvr",undefined,"script_vehicle_civ_domestic_sedan_01_slvr");
	vehicle_scripts\_civ_domestic_truck::main("vehicle_civ_domestic_truck_blue",undefined,"script_vehicle_civ_domestic_truck_blue");
	vehicle_scripts\_ft101_tank::main("vehicle_ft101_tank",undefined,"script_vehicle_ft101_tank");
	vehicle_scripts\_littlebird::main("vehicle_mil_helicopter_littlebird_atlas_ai",undefined,"script_vehicle_littlebird_atlas");
	vehicle_scripts\_pitbull::main("vehicle_mil_avt_ai",undefined,"script_vehicle_mil_avt_ai");
	vehicle_scripts\_gaz::main("vehicle_mil_gaz_ai",undefined,"script_vehicle_mil_gaz_ai");
	vehicle_scripts\_gaz::main("vehicle_mil_gaz_ai",undefined,"script_vehicle_mil_gaz_ai_turret");
	vehicle_scripts\_gaz::main("vehicle_mil_gaz_ai",undefined,"script_vehicle_mil_gaz_ai_turret_recovery");
	vehicle_scripts\_pdrone::main("vehicle_atlas_assault_drone",undefined,"script_vehicle_pdrone_atlas_lab");
	vehicle_scripts\_pdrone::main("vehicle_atlas_assault_drone_large",undefined,"script_vehicle_pdrone_atlas_large");
	vehicle_scripts\_pdrone::main("vehicle_pdrone_kva",undefined,"script_vehicle_pdrone_kva");
	vehicle_scripts\_pdrone_player::main("vehicle_atlas_assault_drone",undefined,"script_vehicle_pdrone_player");
	vehicle_scripts\_walker_tank::main("vehicle_walker_tank",undefined,"script_vehicle_walker_tank");
	vehicle_scripts\_chinese_brave_warrior::main("vehicle_mil_atlas_jeep_ai",undefined,"script_vehicle_warrior_atlas");
	vehicle_scripts\_xh9_warbird::main("vehicle_xh9_warbird",undefined,"script_vehicle_xh9_warbird_heavy_turret_no_cloak_no_zipline_no_treadfx_recovery");
	vehicle_scripts\_xh9_warbird::main("vehicle_xh9_warbird_interior_low",undefined,"script_vehicle_xh9_warbird_low_interior_no_cloak_no_zipline_recovery");
	vehicle_scripts\_xh9_warbird::main("vehicle_xh9_warbird",undefined,"script_vehicle_xh9_warbird_no_cloak_no_zipline_recovery");
}