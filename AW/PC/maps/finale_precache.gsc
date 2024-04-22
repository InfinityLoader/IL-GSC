/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: finale_precache.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 1
 * Decompile Time: 27 ms
 * Timestamp: 4/22/2024 2:29:22 AM
*******************************************************************/

//Function Number: 1
main()
{
	vehicle_scripts\_atlas_jet::main("atlas_fighter_jet",undefined,"script_vehicle_atlas_jet");
	vehicle_scripts\_diveboat::main("vehicle_mil_atlas_speedboat_ai","diveboat_ai","script_vehicle_diveboat_ai");
	vehicle_scripts\_littlebird::main("vehicle_mil_helicopter_littlebird_drone_ai",undefined,"script_vehicle_littlebird_drone_ai");
	vehicle_scripts\_razorback::main("vehicle_razorback",undefined,"script_vehicle_razorback");
	vehicle_scripts\_shrike::main("vehicle_airplane_shrike",undefined,"script_vehicle_shrike");
	vehicle_scripts\_vrap::main("vehicle_mil_humvee",undefined,"script_vehicle_vrap_turret");
	vehicle_scripts\_vrap::main("vehicle_mil_humvee","vrap_physics","script_vehicle_vrap_turret_physics");
	vehicle_scripts\_xh9_warbird::main("vehicle_xh9_warbird_low",undefined,"script_vehicle_xh9_warbird_cheap");
}