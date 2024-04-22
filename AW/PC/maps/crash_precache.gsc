/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: crash_precache.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 1
 * Decompile Time: 28 ms
 * Timestamp: 4/22/2024 2:27:18 AM
*******************************************************************/

//Function Number: 1
main()
{
	vehicle_scripts\_littlebird::main("vehicle_mil_helicopter_littlebird_ai",undefined,"script_vehicle_littlebird_sentinel");
	vehicle_scripts\_pdrone::main("vehicle_atlas_assault_drone_large",undefined,"script_vehicle_pdrone_atlas_large");
	vehicle_scripts\_razorback::main("vehicle_razorback",undefined,"script_vehicle_razorback_simple");
	vehicle_scripts\_walker_tank::main("vehicle_walker_tank",undefined,"script_vehicle_walker_tank");
	vehicle_scripts\_x4walker_wheels::main("vehicle_x4walker_wheels",undefined,"script_vehicle_x4walker_wheels");
	vehicle_scripts\_xh9_warbird::main("vehicle_xh9_warbird",undefined,"script_vehicle_xh9_warbird");
	vehicle_scripts\_xh9_warbird::main("vehicle_xh9_warbird_low",undefined,"script_vehicle_xh9_warbird_cheap");
}