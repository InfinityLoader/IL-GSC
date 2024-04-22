/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: sanfran_b_precache.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 1
 * Decompile Time: 26 ms
 * Timestamp: 4/22/2024 2:35:33 AM
*******************************************************************/

//Function Number: 1
main()
{
	vehicle_scripts\_atlas_piranha::main("vehicle_speedboat_piranha",undefined,"script_vehicle_atlas_piranha","warbird_turret");
	vehicle_scripts\_littlebird::main("vehicle_mil_helicopter_littlebird_ai",undefined,"script_vehicle_littlebird_sentinel_bench");
	vehicle_scripts\_pdrone::main("vehicle_atlas_assault_drone",undefined,"script_vehicle_pdrone_atlas");
	vehicle_scripts\_pdrone::main("vehicle_atlas_assault_drone_large",undefined,"script_vehicle_pdrone_atlas_large");
	vehicle_scripts\_shrike::main("vehicle_airplane_shrike",undefined,"script_vehicle_shrike");
	vehicle_scripts\_xh9_warbird::main("vehicle_xh9_warbird_low",undefined,"script_vehicle_xh9_warbird_low_heavy_turret");
	vehicle_scripts\_xh9_warbird::main("vehicle_xh9_warbird_interior_low",undefined,"script_vehicle_xh9_warbird_low_interior");
}