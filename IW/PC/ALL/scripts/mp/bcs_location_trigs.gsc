/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\mp\bcs_location_trigs.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 33
 * Decompile Time: 1271 ms
 * Timestamp: 10/27/2023 12:22:32 AM
*******************************************************************/

//Function Number: 1
func_29BB()
{
	if(!isdefined(level.var_29B9))
	{
		level.var_29B9 = [];
	}

	func_29BA();
	func_29C7();
	level.var_29B9 = undefined;
	anim.var_AECC = [];
}

//Function Number: 2
func_29C7()
{
	if(!isdefined(level.var_29BC))
	{
		anim.var_29BC = [];
	}

	var_00 = getentarray();
	var_01 = [];
	foreach(var_03 in var_00)
	{
		if(isdefined(var_03.classname) && issubstr(var_03.classname,"trigger_multiple_bcs"))
		{
			var_01[var_01.size] = var_03;
		}
	}

	foreach(var_03 in var_01)
	{
		if(!isdefined(level.var_29B9[var_03.classname]))
		{
			continue;
		}

		var_06 = func_C908(level.var_29B9[var_03.classname]);
		if(var_06.size > 1)
		{
			var_06 = scripts\common\utility::array_randomize(var_06);
		}

		var_03.var_AECB = var_06;
	}

	anim.var_29BC = scripts\common\utility::array_combine(level.var_29BC,var_01);
}

//Function Number: 3
func_C908(param_00)
{
	var_01 = strtok(param_00," ");
	return var_01;
}

//Function Number: 4
func_169E(param_00,param_01)
{
	if(isdefined(level.var_29B9[param_00]))
	{
		var_02 = level.var_29B9[param_00];
		var_03 = func_C908(var_02);
		var_04 = func_C908(param_01);
		foreach(var_06 in var_04)
		{
			foreach(var_08 in var_03)
			{
				if(var_06 == var_08)
				{
					return;
				}
			}
		}

		var_02 = var_02 + " " + param_01;
		level.var_29B9[param_00] = var_02;
		return;
	}

	level.var_29B9[var_09] = var_0A;
}

//Function Number: 5
func_29BA()
{
	geneva();
	neon();
	prime();
	afghan();
	func_B2FD();
	flip();
	junk();
	marsoasis();
	nova();
	paris();
	pixel();
	overflow();
	hawkwar();
	rally();
	func_5238();
	codphish();
}

//Function Number: 6
metropolis()
{
	func_169E("trigger_multiple_bcs_mp_metropolis_room_bathroom","room_bathroom");
	func_169E("trigger_multiple_bcs_mp_metropolis_generator_generic","generator_generic");
	func_169E("trigger_multiple_bcs_mp_metropolis_tunnel_generic","tunnel_generic");
	func_169E("trigger_multiple_bcs_mp_metropolis_train_generic","train_generic");
	func_169E("trigger_multiple_bcs_mp_metropolis_station_charging","station_charging");
	func_169E("trigger_multiple_bcs_mp_metropolis_alley_generic","alley_generic");
	func_169E("trigger_multiple_bcs_mp_metropolis_van_news","van_news");
	func_169E("trigger_multiple_bcs_mp_metropolis_station_central","station_central");
	func_169E("trigger_multiple_bcs_mp_metropolis_park_generic","park_generic");
	func_169E("trigger_multiple_bcs_mp_metropolis_slums_generic","slums_generic");
	func_169E("trigger_multiple_bcs_mp_metropolis_building_bbq","building_bbq");
	func_169E("trigger_multiple_bcs_mp_metropolis_lobby_generic","lobby_generic");
	func_169E("trigger_multiple_bcs_mp_metropolis_car_fire","car_fire");
	func_169E("trigger_multiple_bcs_mp_metropolis_rack_bikes","rack_bikes");
	func_169E("trigger_multiple_bcs_mp_metropolis_screen_big","screen_big");
	func_169E("trigger_multiple_bcs_mp_metropolis_building_steakhouse","building_steakhouse");
	func_169E("trigger_multiple_bcs_mp_metropolis_droppod_generic","droppod_generic");
	func_169E("trigger_multiple_bcs_mp_metropolis_tree_glow","tree_glow");
	func_169E("trigger_multiple_bcs_mp_metropolis_car_generic","car_generic");
}

//Function Number: 7
quarry()
{
	func_169E("trigger_multiple_bcs_mp_quarry_crates_red","crates_red");
	func_169E("trigger_multiple_bcs_mp_quarry_crates_generic","crates_generic");
	func_169E("trigger_multiple_bcs_mp_quarry_quarters_crew","quarters_crew");
	func_169E("trigger_multiple_bcs_mp_quarry_barrels_yellow","barrels_yellow");
	func_169E("trigger_multiple_bcs_mp_quarry_room_rechall","room_rechall");
	func_169E("trigger_multiple_bcs_mp_quarry_room_cafeteria","room_cafeteria");
	func_169E("trigger_multiple_bcs_mp_quarry_room_canteen","room_canteen");
	func_169E("trigger_multiple_bcs_mp_quarry_tunnel_underground","tunnel_underground");
	func_169E("trigger_multiple_bcs_mp_quarry_tunnel_maintenance","tunnel_maintenance");
	func_169E("trigger_multiple_bcs_mp_quarry_underpass_generic","underpass_generic");
	func_169E("trigger_multiple_bcs_mp_quarry_tunnel_access","tunnel_access");
	func_169E("trigger_multiple_bcs_mp_quarry_crawlspace_generic","crawlspace_generic");
	func_169E("trigger_multiple_bcs_mp_quarry_overpass_generic","overpass_generic");
	func_169E("trigger_multiple_bcs_mp_quarry_tires_generic","tires_generic");
	func_169E("trigger_multiple_bcs_mp_quarry_fence_generic","fence_generic");
	func_169E("trigger_multiple_bcs_mp_quarry_vehicle_dumptruck","vehicle_dumptruck");
	func_169E("trigger_multiple_bcs_mp_quarry_vehicle_bigtruck","vehicle_bigtruck");
	func_169E("trigger_multiple_bcs_mp_quarry_room_repairbay","room_repairbay");
	func_169E("trigger_multiple_bcs_mp_quarry_room_motorpool","room_motorpool");
	func_169E("trigger_multiple_bcs_mp_quarry_robots_generic","robots_generic");
	func_169E("trigger_multiple_bcs_mp_quarry_rocks_generic","rocks_generic");
	func_169E("trigger_multiple_bcs_mp_quarry_rockcrusher_generic","rockcrusher_generic");
	func_169E("trigger_multiple_bcs_mp_quarry_deck_lower","deck_lower");
	func_169E("trigger_multiple_bcs_mp_quarry_room_readyroom","room_readyroom");
	func_169E("trigger_multiple_bcs_mp_quarry_room_fillingstation","room_fillingstation");
	func_169E("trigger_multiple_bcs_mp_quarry_room_cleanroom","room_cleanroom");
}

//Function Number: 8
breakneck()
{
	func_169E("trigger_multiple_bcs_mp_breakneck_hallway_officersquarter","hallway_officersquarter");
	func_169E("trigger_multiple_bcs_mp_breakneck_hallway_bridge","hallway_bridge");
	func_169E("trigger_multiple_bcs_mp_breakneck_room_server","room_server");
	func_169E("trigger_multiple_bcs_mp_breakneck_portmissionbay_one","portmissionbay_one");
	func_169E("trigger_multiple_bcs_mp_breakneck_loadingdock_one","loadingdock_one");
	func_169E("trigger_multiple_bcs_mp_breakneck_hangar_one","hangar_one");
	func_169E("trigger_multiple_bcs_mp_breakneck_readyroom_officers","readyroom_officers");
	func_169E("trigger_multiple_bcs_mp_breakneck_readyroom_one","readyroom_one");
	func_169E("trigger_multiple_bcs_mp_breakneck_readyroom_blue","readyroom_blue");
	func_169E("trigger_multiple_bcs_mp_breakneck_navigation_holo","navigation_holo");
	func_169E("trigger_multiple_bcs_mp_breakneck_room_briefing","room_briefing");
	func_169E("trigger_multiple_bcs_mp_breakneck_kitchen_generic","kitchen_generic");
	func_169E("trigger_multiple_bcs_mp_breakneck_elevators_port","elevators_port");
	func_169E("trigger_multiple_bcs_mp_breakneck_gundeck_port","gundeck_port");
	func_169E("trigger_multiple_bcs_mp_breakneck_hall_dining","hall_dining");
	func_169E("trigger_multiple_bcs_mp_breakneck_area_common","area_common");
	func_169E("trigger_multiple_bcs_mp_breakneck_berths_crew","berths_crew");
	func_169E("trigger_multiple_bcs_mp_breakneck_quarters_enlisted","quarters_enlisted");
	func_169E("trigger_multiple_bcs_mp_breakneck_readyroom_crew","readyroom_crew");
	func_169E("trigger_multiple_bcs_mp_breakneck_readyroom_two","readyroom_two");
	func_169E("trigger_multiple_bcs_mp_breakneck_readyroom_red","readyroom_red");
	func_169E("trigger_multiple_bcs_mp_breakneck_portmissionbay_two","portmissionbay_two");
	func_169E("trigger_multiple_bcs_mp_breakneck_loadingdock_two","loadingdock_two");
	func_169E("trigger_multiple_bcs_mp_breakneck_hangar_two","hangar_two");
	func_169E("trigger_multiple_bcs_mp_breakneck_command_control","command_control");
	func_169E("trigger_multiple_bcs_mp_breakneck_command_shipdefense","command_shipdefense");
	func_169E("trigger_multiple_bcs_mp_breakneck_armory_generic","armory_generic");
	func_169E("trigger_multiple_bcs_mp_breakneck_armorylift_generic","armorylift_generic");
	func_169E("trigger_multiple_bcs_mp_breakneck_room_armament","room_armament");
	func_169E("trigger_multiple_bcs_mp_breakneck_room_weaponstorage","room_weaponstorage");
}

//Function Number: 9
desert()
{
	func_169E("trigger_multiple_bcs_mp_desert_pod_2","pod_2");
	func_169E("trigger_multiple_bcs_mp_desert_pod_yellow","pod_yellow");
	func_169E("trigger_multiple_bcs_mp_desert_bridge_generic","bridge_generic");
	func_169E("trigger_multiple_bcs_mp_desert_pod_1","pod_1");
	func_169E("trigger_multiple_bcs_mp_desert_pod_blue","pod_blue");
	func_169E("trigger_multiple_bcs_mp_desert_window_pod","window_pod");
	func_169E("trigger_multiple_bcs_mp_desert_cave_sniper","cave_sniper");
	func_169E("trigger_multiple_bcs_mp_desert_turret_destroyed","turret_destroyed");
	func_169E("trigger_multiple_bcs_mp_desert_panels_solar","panels_solar");
	func_169E("trigger_multiple_bcs_mp_desert_jackal_crashed","jackal_crashed");
	func_169E("trigger_multiple_bcs_mp_desert_window_generic","window_generic");
	func_169E("trigger_multiple_bcs_mp_desert_wall_run","wall_run");
	func_169E("trigger_multiple_bcs_mp_desert_engine_giant","engine_giant");
	func_169E("trigger_multiple_bcs_mp_desert_hallway_ship","hallway_ship");
	func_169E("trigger_multiple_bcs_mp_desert_cargobay_generic","cargobay_generic");
	func_169E("trigger_multiple_bcs_mp_desert_screen_generic","screen_generic");
	func_169E("trigger_multiple_bcs_mp_desert_stairs_generic","stairs_generic");
	func_169E("trigger_multiple_bcs_mp_desert_area_yard","area_yard");
}

//Function Number: 10
divide()
{
	func_169E("trigger_multiple_bcs_mp_divide_building_cargohangar","building_cargohangar");
	func_169E("trigger_multiple_bcs_mp_divide_controls_hangar","controls_hangar");
	func_169E("trigger_multiple_bcs_mp_divide_room_drillcontrol","room_drillcontrol");
	func_169E("trigger_multiple_bcs_mp_divide_deck_observation","deck_observation");
	func_169E("trigger_multiple_bcs_mp_divide_room_lockerroom","room_lockerroom");
	func_169E("trigger_multiple_bcs_mp_divide_turbine_generic","turbine_generic");
	func_169E("trigger_multiple_bcs_mp_divide_lava_pipe","lava_pipe");
	func_169E("trigger_multiple_bcs_mp_divide_building_processing","building_processing");
	func_169E("trigger_multiple_bcs_mp_divide_skybridge_generic","skybridge_generic");
	func_169E("trigger_multiple_bcs_mp_divide_drill_generic","drill_generic");
	func_169E("trigger_multiple_bcs_mp_divide_wallrun_digsite","wallrun_digsite");
	func_169E("trigger_multiple_bcs_mp_divide_building_shiphang","building_shiphang");
}

//Function Number: 11
func_6B6E()
{
	func_169E("trigger_multiple_bcs_mp_fallen_shop_icecream","shop_icecream");
	func_169E("trigger_multiple_bcs_mp_fallen_movietheater_generic","movietheater_generic");
	func_169E("trigger_multiple_bcs_mp_fallen_store_hardware","store_hardware");
	func_169E("trigger_multiple_bcs_mp_fallen_church_generic","church_generic");
	func_169E("trigger_multiple_bcs_mp_fallen_mainstreet_generic","mainstreet_generic");
	func_169E("trigger_multiple_bcs_mp_fallen_mainstreet_underpass","mainstreet_underpass");
	func_169E("trigger_multiple_bcs_mp_fallen_bowlingalley_generic","bowlingalley_generic");
	func_169E("trigger_multiple_bcs_mp_fallen_policestation_generic","policestation_generic");
	func_169E("trigger_multiple_bcs_mp_fallen_field_baseball","field_baseball");
	func_169E("trigger_multiple_bcs_mp_fallen_fieldhouse_generic","fieldhouse_generic");
	func_169E("trigger_multiple_bcs_mp_fallen_station","station");
	func_169E("trigger_multiple_bcs_mp_fallen_station_ticketcounter","station_ticketcounter");
	func_169E("trigger_multiple_bcs_mp_fallen_station_departures","station_departures");
	func_169E("trigger_multiple_bcs_mp_fallen_station_foodcourt","station_foodcourt");
	func_169E("trigger_multiple_bcs_mp_fallen_station_arrivals","station_arrivals");
	func_169E("trigger_multiple_bcs_mp_fallen_silo_generic","silo_generic");
	func_169E("trigger_multiple_bcs_mp_fallen_greenhouse_generic","greenhouse_generic");
	func_169E("trigger_multiple_bcs_mp_fallen_farmersmarket_generic","farmersmarket_generic");
	func_169E("trigger_multiple_bcs_mp_fallen_farmhouse_generic","farmhouse_generic");
	func_169E("trigger_multiple_bcs_mp_fallen_barn_generic","barn_generic");
}

//Function Number: 12
frontier()
{
	func_169E("trigger_multiple_bcs_mp_frontier_room_briefing","room_briefing");
	func_169E("trigger_multiple_bcs_mp_frontier_room_bunk","room_bunk");
	func_169E("trigger_multiple_bcs_mp_frontier_room_command","room_command");
	func_169E("trigger_multiple_bcs_mp_frontier_pods_escape","pods_escape");
	func_169E("trigger_multiple_bcs_mp_frontier_lounge_generic","lounge_generic");
	func_169E("trigger_multiple_bcs_mp_frontier_hallway_lower","hallway_lower");
	func_169E("trigger_multiple_bcs_mp_frontier_room_medbay","room_medbay");
	func_169E("trigger_multiple_bcs_mp_frontier_hall_mess","hall_mess");
	func_169E("trigger_multiple_bcs_mp_frontier_lab_hydro","lab_hydro");
	func_169E("trigger_multiple_bcs_mp_frontier_hallway_main","hallway_main");
	func_169E("trigger_multiple_bcs_mp_frontier_lift_yellow","lift_yellow");
	func_169E("trigger_multiple_bcs_mp_frontier_lift_blue","lift_blue");
	func_169E("trigger_multiple_bcs_mp_frontier_tunnel_service","tunnel_service");
	func_169E("trigger_multiple_bcs_mp_frontier_stairwell_generic","stairwell_generic");
	func_169E("trigger_multiple_bcs_mp_frontier_ramp_generic","ramp_generic");
	func_169E("trigger_multiple_bcs_mp_frontier_room_control","room_control");
}

//Function Number: 13
parkour()
{
	func_169E("trigger_multiple_bcs_mp_parkour_watertank_generic","helipad_generic");
	func_169E("trigger_multiple_bcs_mp_parkour_watertank_generic","watertank_generic");
	func_169E("trigger_multiple_bcs_mp_parkour_whirlpool","whirlpool");
	func_169E("trigger_multiple_bcs_mp_parkour_window_washroom","window_washroom");
	func_169E("trigger_multiple_bcs_mp_parkour_vehicle_dropship","vehicle_dropship");
	func_169E("trigger_multiple_bcs_mp_parkour_bodies_dead","bodies_dead");
	func_169E("trigger_multiple_bcs_mp_parkour_room_barracks","room_barracks");
	func_169E("trigger_multiple_bcs_mp_parkour_window_generic","window_generic");
	func_169E("trigger_multiple_bcs_mp_parkour_crates_generic","crates_generic");
	func_169E("trigger_multiple_bcs_mp_parkour_cave_generic","cave_generic");
	func_169E("trigger_multiple_bcs_mp_parkour_cryo_prisoners","cryo_prisoners");
	func_169E("trigger_multiple_bcs_mp_parkour_vehicle_truck","vehicle_truck");
	func_169E("trigger_multiple_bcs_mp_parkour_room_shipping","room_shipping");
	func_169E("trigger_multiple_bcs_mp_parkour_barrels_generic","barrels_generic");
	func_169E("trigger_multiple_bcs_mp_parkour_roof_mid","roof_mid");
	func_169E("trigger_multiple_bcs_mp_parkour_building_round","building_round");
	func_169E("trigger_multiple_bcs_mp_parkour_room_wet","room_wet");
	func_169E("trigger_multiple_bcs_mp_parkour_balcony_generic","balcony_generic");
	func_169E("trigger_multiple_bcs_mp_parkour_wall_run","wall_run");
	func_169E("trigger_multiple_bcs_mp_parkour_cellblock_generic","cellblock_generic");
	func_169E("trigger_multiple_bcs_mp_parkour_building_medpod","building_medpod");
	func_169E("trigger_multiple_bcs_mp_parkour_window_medbay","window_medbay");
}

//Function Number: 14
proto()
{
	func_169E("trigger_multiple_bcs_mp_proto_dock_loading","dock_loading");
	func_169E("trigger_multiple_bcs_mp_proto_room_security","room_security");
	func_169E("trigger_multiple_bcs_mp_proto_entrance_generic","entrance_generic");
	func_169E("trigger_multiple_bcs_mp_proto_bay_robot","bay_robot");
	func_169E("trigger_multiple_bcs_mp_proto_sub_launch","sub_launch");
	func_169E("trigger_multiple_bcs_mp_proto_pump_water","pump_water");
	func_169E("trigger_multiple_bcs_mp_proto_building_comms","building_comms");
	func_169E("trigger_multiple_bcs_mp_proto_blocks_ice","catwalk_generic");
	func_169E("trigger_multiple_bcs_mp_proto_blocks_ice","blocks_ice");
	func_169E("trigger_multiple_bcs_mp_proto_area_construction","area_construction");
	func_169E("trigger_multiple_bcs_mp_proto_jackal_control","jackal_control");
	func_169E("trigger_multiple_bcs_mp_proto_crate_stack","crate_stack");
	func_169E("trigger_multiple_bcs_mp_proto_grinder_ice","grinder_ice");
}

//Function Number: 15
riot()
{
	func_169E("trigger_multiple_bcs_mp_riot_building_church","building_church");
	func_169E("trigger_multiple_bcs_mp_riot_wall_destroyed","wall_destroyed");
	func_169E("trigger_multiple_bcs_mp_riot_courtyard_generic","courtyard_generic");
	func_169E("trigger_multiple_bcs_mp_riot_garden_beer","garden_beer");
	func_169E("trigger_multiple_bcs_mp_riot_statue_generic","statue_generic");
	func_169E("trigger_multiple_bcs_mp_riot_stairs_archway","stairs_archway");
	func_169E("trigger_multiple_bcs_mp_riot_bikeshop_interior","bikeshop_interior");
	func_169E("trigger_multiple_bcs_mp_riot_scaffolding_generic","scaffolding_generic");
	func_169E("trigger_multiple_bcs_mp_riot_vehicle_apc","vehicle_apc");
	func_169E("trigger_multiple_bcs_mp_riot_vehicle_sailboat","vehicle_sailboat");
	func_169E("trigger_multiple_bcs_mp_riot_building_castle","building_castle");
	func_169E("trigger_multiple_bcs_mp_riot_vehicle_bus","vehicle_bus");
	func_169E("trigger_multiple_bcs_mp_riot_room_bar","room_bar");
	func_169E("trigger_multiple_bcs_mp_riot_hallway_generic","hallway_generic");
	func_169E("trigger_multiple_bcs_mp_riot_lobby_hotel","lobby_hotel");
	func_169E("trigger_multiple_bcs_mp_riot_room_hotel","room_hotel");
	func_169E("trigger_multiple_bcs_mp_riot_rooftop_generic","rooftop_generic");
	func_169E("trigger_multiple_bcs_mp_riot_vehicle_policecar","vehicle_policecar");
	func_169E("trigger_multiple_bcs_mp_riot_tunnel_generic","tunnel_generic");
	func_169E("trigger_multiple_bcs_mp_riot_docks_upper","docks_upper");
	func_169E("trigger_multiple_bcs_mp_riot_waterfront_generic","waterfront_generic");
}

//Function Number: 16
rivet()
{
	func_169E("trigger_multiple_bcs_mp_rivet_dock_yellow","dock_yellow");
	func_169E("trigger_multiple_bcs_mp_rivet_ship_bow","ship_bow");
	func_169E("trigger_multiple_bcs_mp_rivet_dock_blue","dock_blue");
	func_169E("trigger_multiple_bcs_mp_rivet_room_chemstorage","room_chemstorage");
	func_169E("trigger_multiple_bcs_mp_rivet_area_hosing","area_hosing");
	func_169E("trigger_multiple_bcs_mp_rivet_area_cleaning","area_cleaning");
	func_169E("trigger_multiple_bcs_mp_rivet_path_center","path_center");
	func_169E("trigger_multiple_bcs_mp_rivet_rocket_generic","rocket_generic");
	func_169E("trigger_multiple_bcs_mp_rivet_loadingzone_generic","loadingzone_generic");
	func_169E("trigger_multiple_bcs_mp_rivet_area_warehouseload","area_warehouseload");
	func_169E("trigger_multiple_bcs_mp_rivet_rocket_engine","rocket_engine");
	func_169E("trigger_multiple_bcs_mp_rivet_catwalk_yellow","catwalk_yellow");
	func_169E("trigger_multiple_bcs_mp_rivet_airlock_generic","airlock_generic");
	func_169E("trigger_multiple_bcs_mp_rivet_catwalk_blue","catwalk_blue");
	func_169E("trigger_multiple_bcs_mp_rivet_hallway_west","hallway_west");
	func_169E("trigger_multiple_bcs_mp_rivet_building_yellow","building_yellow");
	func_169E("trigger_multiple_bcs_mp_rivet_building_fabrication","building_fabrication");
	func_169E("trigger_multiple_bcs_mp_rivet_overlook_fabrication","overlook_fabrication");
	func_169E("trigger_multiple_bcs_mp_rivet_building_blue","building_blue");
	func_169E("trigger_multiple_bcs_mp_rivet_building_warehouse","building_warehouse");
	func_169E("trigger_multiple_bcs_mp_rivet_door_garage","door_garage");
}

//Function Number: 17
skyway()
{
	func_169E("trigger_multiple_bcs_mp_skyway_area_checkpoint","area_checkpoint");
	func_169E("trigger_multiple_bcs_mp_skyway_area_security","area_security");
	func_169E("trigger_multiple_bcs_mp_skyway_area_luggagecheck","area_luggagecheck");
	func_169E("trigger_multiple_bcs_mp_skyway_desk_desk","desk_desk");
	func_169E("trigger_multiple_bcs_mp_skyway_tree_generic","tree_generic");
	func_169E("trigger_multiple_bcs_mp_skyway_store_gift","store_gift");
	func_169E("trigger_multiple_bcs_mp_skyway_store_book","store_book");
	func_169E("trigger_multiple_bcs_mp_skyway_jetway_generic","jetway_generic");
	func_169E("trigger_multiple_bcs_mp_skyway_corridor_generic","corridor_generic");
	func_169E("trigger_multiple_bcs_mp_skyway_store_sushi","store_sushi");
	func_169E("trigger_multiple_bcs_mp_skyway_area_dining","area_dining");
	func_169E("trigger_multiple_bcs_mp_skyway_room_restroom","room_restroom");
	func_169E("trigger_multiple_bcs_mp_skyway_fountain_generic","fountain_generic");
	func_169E("trigger_multiple_bcs_mp_skyway_fountain_stairs","fountain_stairs");
	func_169E("trigger_multiple_bcs_mp_skyway_vehicle_crane","vehicle_crane");
	func_169E("trigger_multiple_bcs_mp_skyway_statue_astronaut","statue_astronaut");
	func_169E("trigger_multiple_bcs_mp_skyway_stair_car","stair_car");
	func_169E("trigger_multiple_bcs_mp_skyway_room_control","room_control");
	func_169E("trigger_multiple_bcs_mp_skyway_turret_generic","turret_generic");
	func_169E("trigger_multiple_bcs_mp_skyway_shuttle_ramp","shuttle_ramp");
	func_169E("trigger_multiple_bcs_mp_skyway_shuttle_cockpit","shuttle_cockpit");
	func_169E("trigger_multiple_bcs_mp_skyway_tarmac_generic","tarmac_generic");
}

//Function Number: 18
geneva()
{
	func_169E("trigger_multiple_bcs_mp_geneva_masq_shop","masq_shop");
	func_169E("trigger_multiple_bcs_mp_geneva_statue_plaza","statue_plaza");
	func_169E("trigger_multiple_bcs_mp_geneva_well","well");
	func_169E("trigger_multiple_bcs_mp_geneva_well_inside","well_inside");
	func_169E("trigger_multiple_bcs_mp_geneva_restaurant_outside","restaurant_outside");
	func_169E("trigger_multiple_bcs_mp_geneva_gelato_parlor","gelato_parlor");
	func_169E("trigger_multiple_bcs_mp_geneva_fountain","fountain");
	func_169E("trigger_multiple_bcs_mp_geneva_fruit_stand","fruit_stand");
	func_169E("trigger_multiple_bcs_mp_geneva_monument","monument");
	func_169E("trigger_multiple_bcs_mp_geneva_gandolas","gandolas");
	func_169E("trigger_multiple_bcs_mp_geneva_bank_outside","bank_outside");
	func_169E("trigger_multiple_bcs_mp_geneva_atms","atms");
	func_169E("trigger_multiple_bcs_mp_geneva_church_inside","church_inside");
	func_169E("trigger_multiple_bcs_mp_geneva_travelagency_wndw","travelagency_wndw");
	func_169E("trigger_multiple_bcs_mp_geneva_travelagency_inside","travelagency_inside");
	func_169E("trigger_multiple_bcs_mp_geneva_doubledoors","doubledoors");
	func_169E("trigger_multiple_bcs_mp_geneva_boat","informatioboatn_desk");
	func_169E("trigger_multiple_bcs_mp_geneva_canal_shop","canal_shop");
	func_169E("trigger_multiple_bcs_mp_geneva_canal","canal");
	func_169E("trigger_multiple_bcs_mp_geneva_garden","garden");
	func_169E("trigger_multiple_bcs_mp_geneva_stairs","stairs");
	func_169E("trigger_multiple_bcs_mp_geneva_newsstand","newsstand");
	func_169E("trigger_multiple_bcs_mp_geneva_kiosk","kiosk");
	func_169E("trigger_multiple_bcs_mp_geneva_lamppost","lamppost");
	func_169E("trigger_multiple_bcs_mp_geneva_altar","altar");
	func_169E("trigger_multiple_bcs_mp_geneva_candles","candles");
	func_169E("trigger_multiple_bcs_mp_geneva_window","window");
	func_169E("trigger_multiple_bcs_mp_geneva_tables","tables");
	func_169E("trigger_multiple_bcs_mp_geneva_arches","arches");
}

//Function Number: 19
prime()
{
	func_169E("trigger_multiple_bcs_mp_prime_barbershop","barbershop");
	func_169E("trigger_multiple_bcs_mp_prime_market","market");
	func_169E("trigger_multiple_bcs_mp_prime_pharmacy_2ndflr","pharmacy_2ndflr");
	func_169E("trigger_multiple_bcs_mp_prime_statue_plaza","statue_plaza");
	func_169E("trigger_multiple_bcs_mp_prime_policestation_outside","policestation_outside");
	func_169E("trigger_multiple_bcs_mp_prime_subway_inside","subway_inside");
	func_169E("trigger_multiple_bcs_mp_prime_subway_outside","subway_outside");
	func_169E("trigger_multiple_bcs_mp_prime_bridge_under","bridge_under");
	func_169E("trigger_multiple_bcs_mp_prime_crane","crane");
	func_169E("trigger_multiple_bcs_mp_prime_plaza","plaza");
	func_169E("trigger_multiple_bcs_mp_prime_docks","docks");
	func_169E("trigger_multiple_bcs_mp_prime_store_2ndflr","store_2ndflr");
	func_169E("trigger_multiple_bcs_mp_prime_store_1stflr","store_1stflr");
	func_169E("trigger_multiple_bcs_mp_prime_firehouse_inside","firehouse_inside");
	func_169E("trigger_multiple_bcs_mp_prime_firehouse_outside","firehouse_outside");
	func_169E("trigger_multiple_bcs_mp_prime_diner_above","diner_above");
	func_169E("trigger_multiple_bcs_mp_prime_scaffolding","scaffolding");
	func_169E("trigger_multiple_bcs_mp_prime_fuelcans","fuelcans");
	func_169E("trigger_multiple_bcs_mp_prime_subway_tunnel","subway_tunnel");
}

//Function Number: 20
neon()
{
	func_169E("trigger_multiple_bcs_mp_neon_theater","theater");
	func_169E("trigger_multiple_bcs_mp_neon_nightclub","nightclub");
	func_169E("trigger_multiple_bcs_mp_neon_parking_lot","parking_lot");
	func_169E("trigger_multiple_bcs_mp_neon_pharmacy","pharmacy");
	func_169E("trigger_multiple_bcs_mp_neon_hospital","hospital");
	func_169E("trigger_multiple_bcs_mp_neon_stairway","stairway");
	func_169E("trigger_multiple_bcs_mp_neon_canopy","canopy");
	func_169E("trigger_multiple_bcs_mp_neon_policestation_inside","policestation_inside");
	func_169E("trigger_multiple_bcs_mp_neon_policestation_balcony","policestation_balcony");
	func_169E("trigger_multiple_bcs_mp_neon_policestation_outside","policestation_outside");
	func_169E("trigger_multiple_bcs_mp_neon_cityhall_inside","cityhall_inside");
	func_169E("trigger_multiple_bcs_mp_neon_cityhall_outside","cityhall_outside");
	func_169E("trigger_multiple_bcs_mp_neon_bank_outside","bank_outside");
	func_169E("trigger_multiple_bcs_mp_neon_apts_2ndflr","apts_2ndflr");
	func_169E("trigger_multiple_bcs_mp_neon_apts_outside","apts_outside");
	func_169E("trigger_multiple_bcs_mp_neon_hotel_outside","hotel_outside");
	func_169E("trigger_multiple_bcs_mp_neon_market","market");
	func_169E("trigger_multiple_bcs_mp_neon_firetruck","firetruck");
	func_169E("trigger_multiple_bcs_mp_neon_ambulance","ambulance");
}

//Function Number: 21
afghan()
{
	func_169E("trigger_multiple_bcs_mp_afghan_large_pipes","large_pipes");
	func_169E("trigger_multiple_bcs_mp_afghan_hydroponics","hydroponics");
	func_169E("trigger_multiple_bcs_mp_afghan_garden","garden");
	func_169E("trigger_multiple_bcs_mp_afghan_control_room","control_room");
	func_169E("trigger_multiple_bcs_mp_afghan_bunker","bunker");
	func_169E("trigger_multiple_bcs_mp_afghan_servers","servers");
	func_169E("trigger_multiple_bcs_mp_afghan_crash_site","crash_site");
	func_169E("trigger_multiple_bcs_mp_afghan_cockpit","cockpit");
	func_169E("trigger_multiple_bcs_mp_afghan_tail_section","tail_section");
	func_169E("trigger_multiple_bcs_mp_afghan_generator","generator");
	func_169E("trigger_multiple_bcs_mp_afghan_aaguns","aaguns");
	func_169E("trigger_multiple_bcs_mp_afghan_overlook","overlook");
	func_169E("trigger_multiple_bcs_mp_afghan_broken_stairs","broken_stairs");
	func_169E("trigger_multiple_bcs_mp_afghan_satellite_dish","satellite_dish");
	func_169E("trigger_multiple_bcs_mp_afghan_cavern","cavern");
	func_169E("trigger_multiple_bcs_mp_afghan_atmogen","atmogen");
	func_169E("trigger_multiple_bcs_mp_afghan_vehicle_ent","vehicle_ent");
	func_169E("trigger_multiple_bcs_mp_afghan_vehicles","vehicles");
	func_169E("trigger_multiple_bcs_mp_afghan_pump_station","pump_station");
}

//Function Number: 22
func_B2FD()
{
	func_169E("trigger_multiple_bcs_mp_mansion_shark","shark");
	func_169E("trigger_multiple_bcs_mp_mansion_room_security","room_security");
	func_169E("trigger_multiple_bcs_mp_mansion_vases_antique","vases_antique");
	func_169E("trigger_multiple_bcs_mp_mansion_garden","garden");
	func_169E("trigger_multiple_bcs_mp_mansion_station_foodcourt","station_foodcourt");
	func_169E("trigger_multiple_bcs_mp_mansion_room_bathroom","room_bathroom");
	func_169E("trigger_multiple_bcs_mp_mansion_station_ticketcounter","station_ticketcounter");
	func_169E("trigger_multiple_bcs_mp_mansion_room_storage","room_storage");
	func_169E("trigger_multiple_bcs_mp_mansion_store_gift","store_gift");
	func_169E("trigger_multiple_bcs_mp_mansion_room_fist","store_gift");
	func_169E("trigger_multiple_bcs_mp_mansion_room_library","room_library");
	func_169E("trigger_multiple_bcs_mp_mansion_courtyard_generic","courtyard_generic");
}

//Function Number: 23
flip()
{
	func_169E("trigger_multiple_bcs_mp_flip_docks","docks");
	func_169E("trigger_multiple_bcs_mp_flip_statue_head","statue_head");
	func_169E("trigger_multiple_bcs_mp_flip_penthouse","penthouse");
	func_169E("trigger_multiple_bcs_mp_flip_lobby_tower","lobby_tower");
	func_169E("trigger_multiple_bcs_mp_flip_car_gold","car_gold");
	func_169E("trigger_multiple_bcs_mp_flip_garden_rooftop","garden_rooftop");
	func_169E("trigger_multiple_bcs_mp_flip_tubes_generic","tubes_generic");
	func_169E("trigger_multiple_bcs_mp_flip_sign_building","sign_building");
	func_169E("trigger_multiple_bcs_mp_flip_elevator","elevator");
	func_169E("trigger_multiple_bcs_mp_flip_fan_ventilation","fan_ventilation");
	func_169E("trigger_multiple_bcs_mp_flip_control_docking","control_docking");
	func_169E("trigger_multiple_bcs_mp_flip_fountain_runner","fountain_runner");
	func_169E("trigger_multiple_bcs_mp_flip_fountain_2nd","fountain_2nd");
	func_169E("trigger_multiple_bcs_mp_flip_fountain_generic","fountain_generic");
	func_169E("trigger_multiple_bcs_mp_flip_statue_lion","statue_lion");
	func_169E("trigger_multiple_bcs_mp_flip_screen_generic","screen_generic");
}

//Function Number: 24
junk()
{
	func_169E("trigger_multiple_bcs_mp_junk_crane_blue","crane_blue");
	func_169E("trigger_multiple_bcs_mp_junk_room_control","room_control");
	func_169E("trigger_multiple_bcs_mp_junk_fuselage_interior","fuselage_interior");
	func_169E("trigger_multiple_bcs_mp_junk_tunnel_generic","tunnel_generic");
	func_169E("trigger_multiple_bcs_mp_junk_crane_orange","crane_orange");
	func_169E("trigger_multiple_bcs_mp_junk_compactor_interior","compactor_interior");
	func_169E("trigger_multiple_bcs_mp_junk_compactor_wallrun","compactor_wallrun");
	func_169E("trigger_multiple_bcs_mp_junk_gate_front","gate_front");
	func_169E("trigger_multiple_bcs_mp_junk_room_security","room_security");
	func_169E("trigger_multiple_bcs_mp_junk_room_grindercontrol","room_grindercontrol");
	func_169E("trigger_multiple_bcs_mp_junk_quarters_crew","quarters_crew");
	func_169E("trigger_multiple_bcs_mp_junk_area_maintenance","area_maintenance");
	func_169E("trigger_multiple_bcs_mp_junk_comm_center","comm_center");
	func_169E("trigger_multiple_bcs_mp_junk_grinder_ice","grinder_ice");
	func_169E("trigger_multiple_bcs_mp_junk_magnet_scrap","magnet_scrap");
	func_169E("trigger_multiple_bcs_mp_junk_vehicle_mooncrawler","vehicle_mooncrawler");
	func_169E("trigger_multiple_bcs_mp_junk_vehicle_bulldozer","vehicle_bulldozer");
	func_169E("trigger_multiple_bcs_mp_junk_building_rotunda","building_rotunda");
	func_169E("trigger_multiple_bcs_mp_junk_pod_communication","pod_communication");
	func_169E("trigger_multiple_bcs_mp_junk_vehicle_dropship","vehicle_dropship");
	func_169E("trigger_multiple_bcs_mp_junk_tires_generic","tires_generic");
	func_169E("trigger_multiple_bcs_mp_junk_crane","crane");
}

//Function Number: 25
marsoasis()
{
	func_169E("trigger_multiple_bcs_mp_marsoasis_waterfall_generic","waterfall_generic");
	func_169E("trigger_multiple_bcs_mp_marsoasis_truck_generic","truck_generic");
	func_169E("trigger_multiple_bcs_mp_marsoasis_table_gaming","table_gaming");
	func_169E("trigger_multiple_bcs_mp_marsoasis_building_casino","building_casino");
	func_169E("trigger_multiple_bcs_mp_marsoasis_room_bar","room_bar");
	func_169E("trigger_multiple_bcs_mp_marsoasis_slot_machine","slot_machine");
	func_169E("trigger_multiple_bcs_mp_marsoasis_lounge_generic","lounge_generic");
	func_169E("trigger_multiple_bcs_mp_marsoasis_overlook","overlook");
	func_169E("trigger_multiple_bcs_mp_marsoasis_window_generic","window_generic");
	func_169E("trigger_multiple_bcs_mp_marsoasis_shop_dive","shop_dive");
	func_169E("trigger_multiple_bcs_mp_marsoasis_directory_generic","directory_generic");
	func_169E("trigger_multiple_bcs_mp_marsoasis_desk_front","desk_front");
	func_169E("trigger_multiple_bcs_mp_marsoasis_elevators_port","elevators_port");
	func_169E("trigger_multiple_bcs_mp_marsoasis_aquarium_generic","aquarium_generic");
	func_169E("trigger_multiple_bcs_mp_marsoasis_cliff_side","cliff_side");
	func_169E("trigger_multiple_bcs_mp_marsoasis_spa_interior","spa_interior");
	func_169E("trigger_multiple_bcs_mp_marsoasis_hot_springs","hot_springs");
	func_169E("trigger_multiple_bcs_mp_marsoasis_pods_generic","pods_generic");
	func_169E("trigger_multiple_bcs_mp_marsoasis_river_generic","river_generic");
	func_169E("trigger_multiple_bcs_mp_marsoasis_hotel_entrance","hotel_entrance");
	func_169E("trigger_multiple_bcs_mp_marsoasis_luggage_generic","luggage_generic");
	func_169E("trigger_multiple_bcs_mp_marsoasis_elevator","elevator");
}

//Function Number: 26
nova()
{
	func_169E("trigger_multiple_bcs_mp_nova_lighthouse_generic","lighthouse_generic");
	func_169E("trigger_multiple_bcs_mp_nova_lighthouse_bridge","lighthouse_bridge");
	func_169E("trigger_multiple_bcs_mp_nova_beach_generic","beach_generic");
	func_169E("trigger_multiple_bcs_mp_nova_lumberyard_generic","lumberyard_generic");
	func_169E("trigger_multiple_bcs_mp_nova_market","market");
	func_169E("trigger_multiple_bcs_mp_nova_market_food","market_food");
	func_169E("trigger_multiple_bcs_mp_nova_market_square","market_square");
	func_169E("trigger_multiple_bcs_mp_nova_trading_post","trading_post");
	func_169E("trigger_multiple_bcs_mp_nova_downedship_generic","downedship_generic");
	func_169E("trigger_multiple_bcs_mp_nova_downedship_interior","downedship_interior");
	func_169E("trigger_multiple_bcs_mp_nova_residential_interior","residential_interior");
	func_169E("trigger_multiple_bcs_mp_nova_apartments_container","apartments_container");
	func_169E("trigger_multiple_bcs_mp_nova_outhouse_generic","outhouse_generic");
	func_169E("trigger_multiple_bcs_mp_nova_outhouse_generic","room_engine");
	func_169E("trigger_multiple_bcs_mp_nova_greenhouse_generic","greenhouse_generic");
	func_169E("trigger_multiple_bcs_mp_nova_hydroponics","hydroponics");
	func_169E("trigger_multiple_bcs_mp_nova_farm_generic","farm_generic");
	func_169E("trigger_multiple_bcs_mp_nova_restaurant_outside","restaurant_outside");
	func_169E("trigger_multiple_bcs_mp_nova_oil_spill","oil_spill");
	func_169E("trigger_multiple_bcs_mp_nova_oil_tanks","oil_tanks");
	func_169E("trigger_multiple_bcs_mp_nova_broiler_generic","broiler_generic");
	func_169E("trigger_multiple_bcs_mp_nova_pier_generic","pier_generic");
	func_169E("trigger_multiple_bcs_mp_nova_large_pipes","large_pipes");
	func_169E("trigger_multiple_bcs_mp_nova_sewer_wall","sewer_wall");
	func_169E("trigger_multiple_bcs_mp_nova_sewer_generic","sewer_generic");
	func_169E("trigger_multiple_bcs_mp_nova_pump_station","pump_station");
}

//Function Number: 27
paris()
{
	func_169E("trigger_multiple_bcs_mp_paris_gallows_generic","gallows_generic");
	func_169E("trigger_multiple_bcs_mp_paris_waterwell_generic","waterwell_generic");
	func_169E("trigger_multiple_bcs_mp_paris_church_generic","church_generic");
	func_169E("trigger_multiple_bcs_mp_paris_building_church","building_church");
	func_169E("trigger_multiple_bcs_mp_paris_church_inside","church_inside");
	func_169E("trigger_multiple_bcs_mp_paris_tower_radio","tower_radio");
	func_169E("trigger_multiple_bcs_mp_paris_gazebo_generic","gazebo_generic");
	func_169E("trigger_multiple_bcs_mp_paris_tanks_water","tanks_water");
	func_169E("trigger_multiple_bcs_mp_paris_room_cellar","room_cellar");
	func_169E("trigger_multiple_bcs_mp_paris_gate_green","gate_green");
	func_169E("trigger_multiple_bcs_mp_paris_archway_generic","archway_generic");
	func_169E("trigger_multiple_bcs_mp_paris_sandbags_generic","sandbags_generic");
	func_169E("trigger_multiple_bcs_mp_paris_balcony_generic","balcony_generic");
	func_169E("trigger_multiple_bcs_mp_paris_wall_destroyed","wall_destroyed");
	func_169E("trigger_multiple_bcs_mp_paris_pile_log","pile_log");
	func_169E("trigger_multiple_bcs_mp_paris_wire_barbed","wire_barbed");
	func_169E("trigger_multiple_bcs_mp_paris_building_wrecked","building_wrecked");
	func_169E("trigger_multiple_bcs_mp_paris_building_jail","building_jail");
	func_169E("trigger_multiple_bcs_mp_paris_building_inn","building_inn");
	func_169E("trigger_multiple_bcs_mp_paris_building_lodge","building_lodge");
}

//Function Number: 28
pixel()
{
	func_169E("trigger_multiple_bcs_mp_pixel_dragon_giant","dragon_giant");
	func_169E("trigger_multiple_bcs_mp_pixel_skull_dino","skull_dino");
	func_169E("trigger_multiple_bcs_mp_pixel_catapult_generic","catapult_generic");
	func_169E("trigger_multiple_bcs_mp_pixel_range_archery","range_archery");
	func_169E("trigger_multiple_bcs_mp_pixel_tents_generic","tents_generic");
	func_169E("trigger_multiple_bcs_mp_pixel_forest_dark","forest_dark");
	func_169E("trigger_multiple_bcs_mp_pixel_haystacks_generic","haystacks_generic");
	func_169E("trigger_multiple_bcs_mp_pixel_building_windmill","building_windmill");
	func_169E("trigger_multiple_bcs_mp_pixel_archway_castle","archway_castle");
	func_169E("trigger_multiple_bcs_mp_pixel_stairs_castle","stairs_castle");
	func_169E("trigger_multiple_bcs_mp_pixel_doorway_castle","doorway_castle");
	func_169E("trigger_multiple_bcs_mp_pixel_obelisk_generic","obelisk_generic");
	func_169E("trigger_multiple_bcs_mp_pixel_tomb_generic","tomb_generic");
	func_169E("trigger_multiple_bcs_mp_pixel_fountain_generic","fountain_generic");
	func_169E("trigger_multiple_bcs_mp_pixel_tiki_hut","tiki_hut");
	func_169E("trigger_multiple_bcs_mp_pixel_statues_tiki","statues_tiki");
	func_169E("trigger_multiple_bcs_mp_pixel_stairs_temple","stairs_temple");
	func_169E("trigger_multiple_bcs_mp_pixel_arch_donut","arch_donut");
	func_169E("trigger_multiple_bcs_mp_pixel_statue_icecreamcone","statue_icecreamcone");
	func_169E("trigger_multiple_bcs_mp_pixel_station_foodcourt","station_foodcourt");
	func_169E("trigger_multiple_bcs_mp_pixel_barrels_generic","barrels_generic");
	func_169E("trigger_multiple_bcs_mp_pixel_window_office","window_office");
	func_169E("trigger_multiple_bcs_mp_pixel_arcade_generic","arcade_generic");
	func_169E("trigger_multiple_bcs_mp_pixel_breakroom_generic","breakroom_generic");
}

//Function Number: 29
overflow()
{
	func_169E("trigger_multiple_bcs_mp_overflow_breakroom_generic","breakroom_generic");
	func_169E("trigger_multiple_bcs_mp_overflow_droppod_generic","droppod_generic");
	func_169E("trigger_multiple_bcs_mp_overflow_building_droppod","building_droppod");
	func_169E("trigger_multiple_bcs_mp_overflow_parkinglot","parkinglot");
	func_169E("trigger_multiple_bcs_mp_overflow_backlot_generic","backlot_generic");
	func_169E("trigger_multiple_bcs_mp_overflow_door_garage","door_garage");
	func_169E("trigger_multiple_bcs_mp_overflow_cliff_side","cliff_side");
	func_169E("trigger_multiple_bcs_mp_overflow_cliff_generic","cliff_generic");
	func_169E("trigger_multiple_bcs_mp_overflow_alleyway_generic","alleyway_generic");
	func_169E("trigger_multiple_bcs_mp_overflow_tunnel_generic","tunnel_generic");
	func_169E("trigger_multiple_bcs_mp_overflow_street_collapsed","street_collapsed");
	func_169E("trigger_multiple_bcs_mp_overflow_firetruck","firetruck");
	func_169E("trigger_multiple_bcs_mp_overflow_vehicle_bus","vehicle_bus");
	func_169E("trigger_multiple_bcs_mp_overflow_theater","theater");
	func_169E("trigger_multiple_bcs_mp_overflow_theater_lobby","theater_lobby");
	func_169E("trigger_multiple_bcs_mp_overflow_theater_entrance","theater_entrance");
	func_169E("trigger_multiple_bcs_mp_overflow_murderscene_generic","murderscene_generic");
	func_169E("trigger_multiple_bcs_mp_overflow_vehicle_dropship","vehicle_dropship");
	func_169E("trigger_multiple_bcs_mp_overflow_shipwreck_generic","shipwreck_generic");
	func_169E("trigger_multiple_bcs_mp_overflow_terrace_generic","terrace_generic");
	func_169E("trigger_multiple_bcs_mp_overflow_hotdogstand_generic","hotdogstand_generic");
	func_169E("trigger_multiple_bcs_mp_overflow_underpass_generic","underpass_generic");
	func_169E("trigger_multiple_bcs_mp_overflow_window_generic","window_generic");
	func_169E("trigger_multiple_bcs_mp_overflow_wall_run","wall_run");
	func_169E("trigger_multiple_bcs_mp_overflow_room_bathroom","room_bathroom");
	func_169E("trigger_multiple_bcs_mp_overflow_elevators_port","elevators_port");
}

//Function Number: 30
hawkwar()
{
	func_169E("trigger_multiple_bcs_mp_hawkwar_antiques","antiques");
	func_169E("trigger_multiple_bcs_mp_hawkwar_bar","bar");
	func_169E("trigger_multiple_bcs_mp_hawkwar_icecream","icecream");
	func_169E("trigger_multiple_bcs_mp_hawkwar_mill_outside","mill_outside");
	func_169E("trigger_multiple_bcs_mp_hawkwar_postoffice_inside","postoffice_inside");
	func_169E("trigger_multiple_bcs_mp_hawkwar_apartment_inside","apartment_inside");
	func_169E("trigger_multiple_bcs_mp_hawkwar_headquarters","headquarters");
	func_169E("trigger_multiple_bcs_mp_hawkwar_assembly_line","assembly_line");
	func_169E("trigger_multiple_bcs_mp_hawkwar_firetruck","firetruck");
	func_169E("trigger_multiple_bcs_mp_hawkwar_intersection","intersection");
	func_169E("trigger_multiple_bcs_mp_hawkwar_alley","alley");
	func_169E("trigger_multiple_bcs_mp_hawkwar_shops","shops");
	func_169E("trigger_multiple_bcs_mp_hawkwar_roadwork","roadwork");
	func_169E("trigger_multiple_bcs_mp_hawkwar_hardware","hardware");
	func_169E("trigger_multiple_bcs_mp_hawkwar_watertower","watertower");
	func_169E("trigger_multiple_bcs_mp_hawkwar_bakery","bakery");
	func_169E("trigger_multiple_bcs_mp_hawkwar_maintenance_area","maintenance_area");
	func_169E("trigger_multiple_bcs_mp_hawkwar_restoration","restoration");
	func_169E("trigger_multiple_bcs_mp_hawkwar_encoding","encoding");
	func_169E("trigger_multiple_bcs_mp_hawkwar_behavioral","behavioral");
	func_169E("trigger_multiple_bcs_mp_hawkwar_parts","parts");
	func_169E("trigger_multiple_bcs_mp_hawkwar_storage","storage");
	func_169E("trigger_multiple_bcs_mp_hawkwar_barbershop","barbershop");
}

//Function Number: 31
func_5238()
{
	func_169E("trigger_multiple_bcs_mp_depot_ship","ship");
	func_169E("trigger_multiple_bcs_mp_depot_warehouse","warehouse");
	func_169E("trigger_multiple_bcs_mp_depot_repairshop","repairshop");
	func_169E("trigger_multiple_bcs_mp_depot_restaurant_outside","restaurant_outside");
	func_169E("trigger_multiple_bcs_mp_depot_construction","construction");
	func_169E("trigger_multiple_bcs_mp_depot_market","market");
	func_169E("trigger_multiple_bcs_mp_depot_alley","alley");
	func_169E("trigger_multiple_bcs_mp_depot_garage_outside","garage_outside");
	func_169E("trigger_multiple_bcs_mp_depot_office","office");
	func_169E("trigger_multiple_bcs_mp_depot_pulley","pulley");
	func_169E("trigger_multiple_bcs_mp_depot_silos","silos");
	func_169E("trigger_multiple_bcs_mp_depot_trains","trains");
	func_169E("trigger_multiple_bcs_mp_depot_market_entrance","market_entrance");
	func_169E("trigger_multiple_bcs_mp_depot_monorail","monorail");
	func_169E("trigger_multiple_bcs_mp_depot_rooftop","rooftop");
	func_169E("trigger_multiple_bcs_mp_depot_mainstreet","mainstreet");
}

//Function Number: 32
rally()
{
	func_169E("trigger_multiple_bcs_mp_rally_diner_outside","diner_outside");
	func_169E("trigger_multiple_bcs_mp_rally_gasstation","gasstation");
	func_169E("trigger_multiple_bcs_mp_rally_bleachers","bleachers");
	func_169E("trigger_multiple_bcs_mp_rally_stage","stage");
	func_169E("trigger_multiple_bcs_mp_rally_soundbooth","soundbooth");
	func_169E("trigger_multiple_bcs_mp_rally_snackshop","snackshop");
	func_169E("trigger_multiple_bcs_mp_rally_burninator","burninator");
	func_169E("trigger_multiple_bcs_mp_rally_bigtruck","big_truck");
	func_169E("trigger_multiple_bcs_mp_rally_bar","bar");
	func_169E("trigger_multiple_bcs_mp_rally_bridge","bridge");
	func_169E("trigger_multiple_bcs_mp_rally_junkyard","junkyard");
	func_169E("trigger_multiple_bcs_mp_rally_spillway","spillway");
	func_169E("trigger_multiple_bcs_mp_rally_pumproom","pumproom");
	func_169E("trigger_multiple_bcs_mp_rally_control_window","control_window");
	func_169E("trigger_multiple_bcs_mp_rally_riverbed","riverbed");
	func_169E("trigger_multiple_bcs_mp_rally_dam","dam");
	func_169E("trigger_multiple_bcs_mp_rally_office","office");
	func_169E("trigger_multiple_bcs_mp_rally_parkinglot","parkinglot");
	func_169E("trigger_multiple_bcs_mp_rally_cliffside","cliffside");
	func_169E("trigger_multiple_bcs_mp_rally_drain","drain");
	func_169E("trigger_multiple_bcs_mp_rally_trucks","trucks");
	func_169E("trigger_multiple_bcs_mp_rally_bus","bus");
	func_169E("trigger_multiple_bcs_mp_rally_van","van");
	func_169E("trigger_multiple_bcs_mp_rally_balcony","balcony");
	func_169E("trigger_multiple_bcs_mp_rally_fire","fire");
	func_169E("trigger_multiple_bcs_mp_rally_fence","fence");
}

//Function Number: 33
codphish()
{
	func_169E("trigger_multiple_bcs_mp_codphish_cliffside","cliffside");
	func_169E("trigger_multiple_bcs_mp_codphish_awning","awning");
	func_169E("trigger_multiple_bcs_mp_codphish_terrace","terrace");
	func_169E("trigger_multiple_bcs_mp_codphish_terrace","terrace");
	func_169E("trigger_multiple_bcs_mp_codphish_valet","valet");
	func_169E("trigger_multiple_bcs_mp_codphish_lobby","lobby");
	func_169E("trigger_multiple_bcs_mp_codphish_lobby_entrance","lobby_entrance");
	func_169E("trigger_multiple_bcs_mp_codphish_oaktree","oaktree");
	func_169E("trigger_multiple_bcs_mp_codphish_cafe","cafe");
	func_169E("trigger_multiple_bcs_mp_codphish_cafe_kiosk","cafe_kiosk");
	func_169E("trigger_multiple_bcs_mp_codphish_waterfall_kiosk","waterfall_kiosk");
	func_169E("trigger_multiple_bcs_mp_codphish_bridge","bridge");
	func_169E("trigger_multiple_bcs_mp_codphish_lowerbridge","lowerbridge");
	func_169E("trigger_multiple_bcs_mp_codphish_underpass","underpass");
	func_169E("trigger_multiple_bcs_mp_codphish_waterfall","waterfall");
	func_169E("trigger_multiple_bcs_mp_codphish_elevators","elevators");
	func_169E("trigger_multiple_bcs_mp_codphish_monument","monument");
	func_169E("trigger_multiple_bcs_mp_codphish_cinema","cinema");
	func_169E("trigger_multiple_bcs_mp_codphish_observatory","observatory");
	func_169E("trigger_multiple_bcs_mp_codphish_mannequins","mannequins");
	func_169E("trigger_multiple_bcs_mp_codphish_turnstiles","turnstiles");
	func_169E("trigger_multiple_bcs_mp_codphish_sushi_restaurant","sushi_restaurant");
	func_169E("trigger_multiple_bcs_mp_codphish_nightclub_inside","nightclub_inside");
	func_169E("trigger_multiple_bcs_mp_codphish_restrooms","restrooms");
	func_169E("trigger_multiple_bcs_mp_codphish_apartments_inside","apartments_inside");
	func_169E("trigger_multiple_bcs_mp_codphish_apartments_outside","apartments_outside");
	func_169E("trigger_multiple_bcs_mp_codphish_gym","gym");
	func_169E("trigger_multiple_bcs_mp_codphish_hallway","hallway");
	func_169E("trigger_multiple_bcs_mp_codphish_vending_machines","vending_machines");
	func_169E("trigger_multiple_bcs_mp_codphish_commonroom","commonroom");
	func_169E("trigger_multiple_bcs_mp_codphish_stairs","stairs");
	func_169E("trigger_multiple_bcs_mp_codphish_fountain","fountain");
	func_169E("trigger_multiple_bcs_mp_codphish_balcony","balcony");
	func_169E("trigger_multiple_bcs_mp_codphish_restaurant_outside","restaurant_outside");
}