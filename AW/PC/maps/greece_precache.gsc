/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: greece_precache.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 1
 * Decompile Time: 26 ms
 * Timestamp: 4/22/2024 2:31:08 AM
*******************************************************************/

//Function Number: 1
main()
{
	common_scripts\utility::add_destructible_type_function("vehicle_luxurysedan_2008",::destructible_scripts\vehicle_luxurysedan_2008::main);
	destructible_scripts\greece_spinning_displays::main();
	vehicle_scripts\_atlas_suv::main("vehicle_atlas_suv",undefined,"script_vehicle_atlas_suv");
	vehicle_scripts\_civ_domestic_sedan_01::main("vehicle_civ_domestic_sedan_01",undefined,"script_vehicle_civ_domestic_sedan_01");
	vehicle_scripts\_civ_domestic_sedan_01::main("vehicle_civ_domestic_sedan_01_slvr",undefined,"script_vehicle_civ_domestic_sedan_01_slvr");
	vehicle_scripts\_civ_domestic_sedan_taxi_01::main("vehicle_civ_domestic_sedan_taxi_02",undefined,"script_vehicle_civ_domestic_sedan_taxi_02");
	vehicle_scripts\_civ_domestic_sportscar_01::main("vehicle_civ_domestic_sportscar_01",undefined,"script_vehicle_civ_domestic_sportscar_01");
	vehicle_scripts\_civ_domestic_suv::main("vehicle_civ_domestic_suv",undefined,"script_vehicle_civ_domestic_suv");
	vehicle_scripts\_civ_full_size_technical::main("vehicle_civ_full_size_technical_clr02",undefined,"script_vehicle_civ_full_size_technical_clr02");
	vehicle_scripts\_civ_full_size_technical::main("vehicle_civ_full_size_technical_clr02","civ_full_size_technical_turret","script_vehicle_civ_full_size_technical_turret_clr02");
	vehicle_scripts\_civ_smartcar::main("vehicle_civ_smartcar",undefined,"script_vehicle_civ_smartcar");
	vehicle_scripts\_civ_smartcar::main("vehicle_civ_smartcar_02_red",undefined,"script_vehicle_civ_smartcar_02_red");
	vehicle_scripts\_civ_smartcar::main("vehicle_civ_smartcar_02_ylw",undefined,"script_vehicle_civ_smartcar_02_ylw");
	vehicle_scripts\_civ_workvan::main("vehicle_civ_workvan",undefined,"script_vehicle_civ_workvan");
	vehicle_scripts\_pdrone::main("vehicle_pdrone_kva",undefined,"script_vehicle_pdrone_kva");
}