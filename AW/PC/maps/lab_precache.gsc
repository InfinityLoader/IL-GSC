/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: lab_precache.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 1
 * Decompile Time: 27 ms
 * Timestamp: 4/22/2024 2:33:01 AM
*******************************************************************/

//Function Number: 1
main()
{
	common_scripts\utility::add_destructible_type_function("security_camera_scanner_destp",::destructible_scripts\security_camera_scanner_destp::main);
	common_scripts\utility::add_destructible_type_function("wall_firebox_destp",::destructible_scripts\wall_firebox_destp::main);
	destructible_scripts\security_camera_scanner_destp::main();
	destructible_scripts\wall_firebox_destp::main();
	vehicle_scripts\_cover_drone::main("vehicle_mobile_cover",undefined,"script_vehicle_cover_drone");
	vehicle_scripts\_ft101_tank::main("vehicle_ft101_tank","ft101_tank_physics","script_vehicle_ft101_tank_physics");
	vehicle_scripts\_hovertank::main("vehicle_mil_hovertank_ai",undefined,"script_vehicle_hovertank");
	vehicle_scripts\_littlebird::main("vehicle_mil_helicopter_littlebird_atlas_ai",undefined,"script_vehicle_littlebird_atlas_bench");
	vehicle_scripts\_pdrone::main("vehicle_atlas_assault_drone",undefined,"script_vehicle_pdrone_atlas_lab");
	vehicle_scripts\_razorback::main("vehicle_razorback",undefined,"script_vehicle_razorback");
	vehicle_scripts\_vrap::main("vehicle_mil_humvee",undefined,"script_vehicle_vrap");
	vehicle_scripts\_vrap::main("vehicle_mil_humvee","vrap_physics","script_vehicle_vrap_physics");
	vehicle_scripts\_xh9_warbird::main("vehicle_xh9_warbird_low",undefined,"script_vehicle_xh9_warbird_low_heavy_turret");
}