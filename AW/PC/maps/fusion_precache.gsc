/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: fusion_precache.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 1
 * Decompile Time: 27 ms
 * Timestamp: 4/22/2024 2:30:11 AM
*******************************************************************/

//Function Number: 1
main()
{
	common_scripts\utility::add_destructible_type_function("computer_01_destp",::destructible_scripts\computer_01_destp::main);
	common_scripts\utility::add_destructible_type_function("powerbox_112x64_01_green_destp",::destructible_scripts\powerbox_112x64_01_green_destp::main);
	destructible_scripts\computer_01_destp::main();
	destructible_scripts\powerbox_112x64_01_green_destp::main();
	vehicle_scripts\_atlas_jet::main("atlas_fighter_jet",undefined,"script_vehicle_atlas_jet");
	vehicle_scripts\_cover_drone::main("vehicle_mobile_cover",undefined,"script_vehicle_cover_drone");
	vehicle_scripts\_gaz::main("vehicle_mil_gaz_ai",undefined,"script_vehicle_mil_gaz_ai_turret");
	vehicle_scripts\_mi17::main("vehicle_mil_mi17",undefined,"script_vehicle_mil_mi17");
	vehicle_scripts\_pdrone::main("vehicle_pdrone",undefined,"script_vehicle_pdrone");
	vehicle_scripts\_pdrone::main("vehicle_pdrone_kva",undefined,"script_vehicle_pdrone_kva");
	vehicle_scripts\_pdrone_player::main("vehicle_atlas_assault_drone",undefined,"script_vehicle_pdrone_player");
	vehicle_scripts\_walker_tank::main("vehicle_walker_tank",undefined,"script_vehicle_walker_tank");
	vehicle_scripts\_x4walker_wheels::main("vehicle_x4walker_wheels",undefined,"script_vehicle_x4walker_wheels");
	vehicle_scripts\_x4walker_wheels_turret::main("vehicle_npc_x4walkerSplit_wheels",undefined,"script_vehicle_x4walker_wheels_turret_explosive");
	vehicle_scripts\_xh9_warbird::main("vehicle_xh9_warbird",undefined,"script_vehicle_xh9_warbird");
	vehicle_scripts\_xh9_warbird::main("vehicle_xh9_warbird_low",undefined,"script_vehicle_xh9_warbird_low");
	vehicle_scripts\_xh9_warbird::main("vehicle_xh9_warbird_low",undefined,"script_vehicle_xh9_warbird_low_no_turret_no_zipline");
	vehicle_scripts\_xh9_warbird::main("vehicle_xh9_warbird",undefined,"script_vehicle_xh9_warbird_no_turret");
	vehicle_scripts\_xh9_warbird::main("vehicle_xh9_warbird_stealth",undefined,"script_vehicle_xh9_warbird_stealth");
}