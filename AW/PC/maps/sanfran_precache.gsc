/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: sanfran_precache.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 1
 * Decompile Time: 27 ms
 * Timestamp: 4/22/2024 2:35:55 AM
*******************************************************************/

//Function Number: 1
main()
{
	common_scripts\utility::add_destructible_type_function("vehicle_civ_domestic_sedan_01_glass",::destructible_scripts\vehicle_civ_domestic_sedan_01_glass::main);
	common_scripts\utility::add_destructible_type_function("vehicle_civ_domestic_sedan_taxi_glass",::destructible_scripts\vehicle_civ_domestic_sedan_taxi_glass::main);
	vehicle_scripts\_atlas_suv::main("vehicle_atlas_suv",undefined,"script_vehicle_atlas_suv");
	vehicle_scripts\_atlas_suv::main("vehicle_atlas_suv","atlas_suv_physics","script_vehicle_atlas_suv_physics");
	vehicle_scripts\_atlas_suv::main("vehicle_atlas_suv","atlas_suv_physics","script_vehicle_atlas_suv_physics_explode");
	vehicle_scripts\_atlas_van::main("vehicle_ind_van_utility_ai",undefined,"script_vehicle_atlas_van");
	vehicle_scripts\_atlas_van::main("vehicle_ind_van_utility_ai","atlas_van_physics","script_vehicle_atlas_van_physics");
	vehicle_scripts\_civ_domestic_bus::main("vehicle_civ_domestic_bus",undefined,"script_vehicle_civ_domestic_bus");
	vehicle_scripts\_civ_domestic_bus::main("vehicle_civ_domestic_bus","civ_domestic_bus_physics","script_vehicle_civ_domestic_bus_physics");
	vehicle_scripts\_civ_domestic_economy_ai::main("vehicle_civ_domestic_economy_ai","civ_domestic_economy_ai_physics","script_vehicle_civ_domestic_economy_ai_physics");
	vehicle_scripts\_civ_domestic_economy_ai::main("vehicle_civ_domestic_economy_clr02_ai","civ_domestic_economy_ai_physics","script_vehicle_civ_domestic_economy_clr02_ai_physics");
	vehicle_scripts\_civ_domestic_economy_ai::main("vehicle_civ_domestic_economy_clr03_ai","civ_domestic_economy_ai_physics","script_vehicle_civ_domestic_economy_clr03_ai_physics");
	vehicle_scripts\_civ_domestic_economy_ai::main("vehicle_civ_domestic_economy_clr04_ai","civ_domestic_economy_ai_physics","script_vehicle_civ_domestic_economy_clr04_ai_physics");
	vehicle_scripts\_civ_domestic_economy_ai::main("vehicle_civ_domestic_economy_clr05_ai","civ_domestic_economy_ai_physics","script_vehicle_civ_domestic_economy_clr05_ai_physics");
	vehicle_scripts\_civ_domestic_economy_ai::main("vehicle_civ_domestic_economy_clr06_ai","civ_domestic_economy_ai_physics","script_vehicle_civ_domestic_economy_clr06_ai_physics");
	vehicle_scripts\_civ_domestic_sedan_01::main("vehicle_civ_domestic_sedan_01","civ_domestic_sedan_01_physics","script_vehicle_civ_domestic_sedan_01_physics");
	vehicle_scripts\_civ_domestic_sedan_police::main("vehicle_civ_domestic_sedan_police",undefined,"script_vehicle_civ_domestic_sedan_police");
	vehicle_scripts\_civ_domestic_sedan_police::main("vehicle_civ_domestic_sedan_police","civ_domestic_sedan_police_physics","script_vehicle_civ_domestic_sedan_police_physics");
	vehicle_scripts\_civ_domestic_sedan_taxi_01::main("vehicle_civ_domestic_sedan_taxi_01","civ_domestic_sedan_taxi_01_physics","script_vehicle_civ_domestic_sedan_taxi_01_physics");
	vehicle_scripts\_civ_domestic_sedan_taxi_01::main("vehicle_civ_domestic_sedan_taxi_02","civ_domestic_sedan_taxi_01_physics","script_vehicle_civ_domestic_sedan_taxi_02_physics");
	vehicle_scripts\_civ_domestic_sportscar_01::main("vehicle_civ_domestic_sportscar_01","civ_domestic_sportscar_01_physics","script_vehicle_civ_domestic_sportscar_01_physics");
	vehicle_scripts\_civ_domestic_suv::main("vehicle_civ_domestic_suv","civ_domestic_suv_physics","script_vehicle_civ_domestic_suv_physics");
	vehicle_scripts\_civ_domestic_truck::main("vehicle_civ_domestic_truck",undefined,"script_vehicle_civ_domestic_truck");
	vehicle_scripts\_civ_domestic_truck::main("vehicle_civ_domestic_truck_blue","civ_domestic_truck_physics","script_vehicle_civ_domestic_truck_blue_physics");
	vehicle_scripts\_civ_domestic_truck::main("vehicle_civ_domestic_truck_gold","civ_domestic_truck_physics","script_vehicle_civ_domestic_truck_gold_physics");
	vehicle_scripts\_civ_domestic_truck::main("vehicle_civ_domestic_truck_grn","civ_domestic_truck_physics","script_vehicle_civ_domestic_truck_grn_physics");
	vehicle_scripts\_civ_domestic_truck::main("vehicle_civ_domestic_truck","civ_domestic_truck_physics","script_vehicle_civ_domestic_truck_physics");
	vehicle_scripts\_civ_full_size_pickup_01_ai::main("vehicle_civ_full_size_pickup_01_ai","civ_full_size_pickup_01_ai_physics","script_vehicle_civ_full_size_pickup_01_ai_physics");
	vehicle_scripts\_civ_smartcar::main("vehicle_civ_smartcar_02_red","civ_smartcar_physics","script_vehicle_civ_smartcar_02_red_physics");
	vehicle_scripts\_civ_workvan::main("vehicle_civ_workvan",undefined,"script_vehicle_civ_workvan");
	vehicle_scripts\_civ_workvan::main("vehicle_civ_workvan","civ_workvan_physics","script_vehicle_civ_workvan_physics");
	vehicle_scripts\_ind_semi_truck_fuel_tanker::main("vehicle_ind_semi_truck_fuel_tanker",undefined,"script_vehicle_ind_semi_truck_fuel_tanker");
	vehicle_scripts\_littlebird::main("vehicle_mil_helicopter_littlebird_ai",undefined,"script_vehicle_littlebird_sentinel_bench");
	vehicle_scripts\_pdrone::main("vehicle_atlas_assault_drone",undefined,"script_vehicle_pdrone_atlas");
	vehicle_scripts\_pdrone::main("vehicle_atlas_assault_drone_large",undefined,"script_vehicle_pdrone_atlas_large");
	vehicle_scripts\_pitbull::main("vehicle_pitbull","pitbull_physics","script_vehicle_pitbull_physics");
	vehicle_scripts\_pitbull::main("vehicle_vm_pitbull","pitbull_player_physics","script_vehicle_pitbull_player_physics");
}