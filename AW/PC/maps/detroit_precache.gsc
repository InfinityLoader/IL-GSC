/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: detroit_precache.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 1
 * Decompile Time: 38 ms
 * Timestamp: 4/22/2024 2:28:04 AM
*******************************************************************/

//Function Number: 1
main()
{
	vehicle_scripts\_gaz::main("vehicle_gaz_tigr_cleanup","gaz_tigr_cleanup","script_vehicle_gaz_tigr_cleanup");
	vehicle_scripts\_gaz::main("vehicle_gaz_tigr_paris","gaz_tigr_turret_physics_paris","script_vehicle_gaz_tigr_turret_physics_paris");
	vehicle_scripts\_jetbike::main("vehicle_mil_hoverbike_ai","jetbike_npc_physics","script_vehicle_jetbike_npc_physics");
	vehicle_scripts\_jetbike::main("vehicle_mil_hoverbike_ai","jetbike_npc_slow_physics","script_vehicle_jetbike_npc_slow_physics");
	vehicle_scripts\_jetbike::main("vehicle_mil_hoverbike_ai","jetbike_player_physics","script_vehicle_jetbike_player_physics");
	vehicle_scripts\_jetbike::main("vehicle_mil_hoverbike_ai","jetbike_rail_physics","script_vehicle_jetbike_rail_physics");
	vehicle_scripts\_littlebird::main("vehicle_mil_helicopter_littlebird_kva_ai",undefined,"script_vehicle_littlebird_kva_armed");
	vehicle_scripts\_xh9_warbird::main("vehicle_xh9_warbird",undefined,"script_vehicle_xh9_warbird");
	vehicle_scripts\_xh9_warbird::main("vehicle_xh9_warbird_low",undefined,"script_vehicle_xh9_warbird_low_no_turret_no_zipline");
}