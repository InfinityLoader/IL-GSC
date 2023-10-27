/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps/seoul_precache.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 1
 * Decompile Time: 15 ms
 * Timestamp: 10/27/2023 2:02:40 AM
*******************************************************************/

//Function Number: 1
main()
{
	common_scripts\utility::add_destructible_type_function("vehicle_civ_domestic_sedan_01_glass",::destructible_scripts\vehicle_civ_domestic_sedan_01_glass::main);
	vehicle_scripts\_attack_drone_individual::main("vehicle_mil_attack_drone_static",undefined,"script_vehicle_attack_drone_individual");
	vehicle_scripts\_attack_drone_kamikaze::main("vehicle_mil_attack_drone_ai",undefined,"script_vehicle_attack_drone_kamikaze");
	vehicle_scripts\_attack_drone_queen::main("vehicle_mil_attack_drone_static",undefined,"script_vehicle_attack_drone_queen");
	vehicle_scripts\_ft101_tank::main("vehicle_ft101_tank",undefined,"script_vehicle_ft101_tank");
	vehicle_scripts\_havoc_missile_scripted::main("seo_delayed_missile","havoc_missile_scripted","script_vehicle_havoc_missile_scripted");
	vehicle_scripts\_littlebird::main("vehicle_mil_helicopter_littlebird_ai",undefined,"script_vehicle_littlebird_sentinel");
	vehicle_scripts\_mig29::main("vehicle_mig29_low",undefined,"script_vehicle_mig29_low_cheap");
	vehicle_scripts\_pitbull::main("vehicle_mil_avt_ai",undefined,"script_vehicle_mil_avt_ai");
	vehicle_scripts\_mil_cargo_truck::main("vehicle_mil_cargo_truck_ai",undefined,"script_vehicle_mil_cargo_truck");
	vehicle_scripts\_gaz::main("vehicle_mil_humvee_north_korean_01_ai",undefined,"script_vehicle_mil_humvee_north_korean_01_ai_turret");
	vehicle_scripts\_pdrone::main("vehicle_pdrone",undefined,"script_vehicle_pdrone");
	vehicle_scripts\_pdrone_security::main("base_drone_security_01","pdrone_security","script_vehicle_pdrone_security");
	vehicle_scripts\_pitbull::main("vehicle_pitbull","pitbull_physics_alt","script_vehicle_pitbull_physics_alt");
	vehicle_scripts\_razorback::main("vehicle_razorback_marine_ai",undefined,"script_vehicle_razorback_marine_ai");
	vehicle_scripts\_shrike::main("vehicle_airplane_shrike",undefined,"script_vehicle_shrike");
	vehicle_scripts\_sidewinder_scripted::main("mil_missle_sidewinder_01","sidewinder_scripted","script_vehicle_sidewinder_scripted");
	vehicle_scripts\_walker_tank::main("vehicle_walker_tank",undefined,"script_vehicle_walker_tank");
	vehicle_scripts\_x4walker_wheels_turret::main("vehicle_npc_x4walkerSplit_wheels",undefined,"script_vehicle_x4walker_wheels_turret");
	vehicle_scripts\_xh9_warbird::main("vehicle_xh9_warbird_low",undefined,"script_vehicle_xh9_warbird_cheap");
}