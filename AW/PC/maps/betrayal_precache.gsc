/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: betrayal_precache.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 1
 * Decompile Time: 27 ms
 * Timestamp: 4/22/2024 2:25:39 AM
*******************************************************************/

//Function Number: 1
main()
{
	vehicle_scripts\_attack_drone_kamikaze::main("vehicle_mil_attack_drone_ai",undefined,"script_vehicle_attack_drone_kamikaze");
	vehicle_scripts\_attack_drone_queen::main("vehicle_mil_attack_drone_static",undefined,"script_vehicle_attack_drone_queen");
	vehicle_scripts\_civ_boat::main("vehicle_civ_watertaxi_01","civ_domestic_boat","script_vehicle_civ_domestic_watertaxi");
	vehicle_scripts\_civ_boat::main("vehicle_civ_yacht_01","civ_domestic_boat","script_vehicle_civ_domestic_yacht_01");
	vehicle_scripts\_civ_boat::main("vehicle_civ_yacht_02","civ_domestic_boat","script_vehicle_civ_domestic_yacht_02");
	vehicle_scripts\_civ_boat::main("vehicle_civ_yacht_03","civ_domestic_boat","script_vehicle_civ_domestic_yacht_03");
	vehicle_scripts\_diveboat::main("vehicle_mil_atlas_speedboat_ai","diveboat_player","script_vehicle_diveboat_player");
	vehicle_scripts\_littlebird::main("vehicle_mil_helicopter_littlebird_atlas_ai",undefined,"script_vehicle_littlebird_atlas");
	vehicle_scripts\_littlebird::main("vehicle_mil_helicopter_littlebird_atlas_ai",undefined,"script_vehicle_littlebird_atlas_bench");
	vehicle_scripts\_pdrone::main("vehicle_atlas_assault_drone",undefined,"script_vehicle_pdrone_atlas");
	vehicle_scripts\_shrike::main("vehicle_airplane_shrike",undefined,"script_vehicle_shrike");
	vehicle_scripts\_xh9_warbird::main("vehicle_xh9_warbird",undefined,"script_vehicle_xh9_warbird");
	vehicle_scripts\_xh9_warbird::main("vehicle_xh9_warbird_low",undefined,"script_vehicle_xh9_warbird_cheap");
	vehicle_scripts\_xh9_warbird::main("vehicle_xh9_warbird_interior_low",undefined,"script_vehicle_xh9_warbird_low_interior");
	vehicle_scripts\_xh9_warbird::main("vehicle_xh9_warbird_interior_low",undefined,"script_vehicle_xh9_warbird_low_interior_no_cloak_no_zipline_recovery");
}