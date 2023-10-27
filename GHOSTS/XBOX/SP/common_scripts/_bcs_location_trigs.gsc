/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: common_scripts\_bcs_location_trigs.gsc
 * Game: Call of Duty: Ghosts
 * Platform: Console
 * Function Count: 32
 * Decompile Time: 494 ms
 * Timestamp: 10/27/2023 1:38:31 AM
*******************************************************************/

//Function Number: 1
bcs_location_trigs_init()
{
	level.bcs_location_mappings = [];
	bcs_location_trigger_mapping();
	func_134F();
	level.bcs_location_mappings = undefined;
	anim.locationlastcallouttimes = [];
}

//Function Number: 2
func_134F()
{
	anim.bcs_locations = [];
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
		if(!isdefined(level.bcs_location_mappings[var_03.classname]))
		{
			continue;
		}

		var_06 = func_5AF1(level.bcs_location_mappings[var_03.classname]);
		if(var_06.size > 1)
		{
			var_06 = common_scripts\utility::array_randomize(var_06);
		}

		var_03.locationaliases = var_06;
	}

	anim.bcs_locations = var_01;
}

//Function Number: 3
func_5AF1(param_00)
{
	var_01 = strtok(param_00," ");
	return var_01;
}

//Function Number: 4
add_bcs_location_mapping(param_00,param_01)
{
	if(isdefined(level.bcs_location_mappings[param_00]))
	{
		var_02 = level.bcs_location_mappings[param_00];
		var_03 = func_5AF1(var_02);
		var_04 = func_5AF1(param_01);
		foreach(var_06 in var_04)
		{
			foreach(var_08 in var_03)
			{
				if(var_06 == var_08)
				{
				}
			}
		}

		var_02 = var_02 + " " + param_01;
		level.bcs_location_mappings[param_00] = var_02;
	}

	level.bcs_location_mappings[var_09] = var_0A;
}

//Function Number: 5
bcs_location_trigger_mapping()
{
	if(common_scripts\utility::issp())
	{
		func_3798();
		blackice_locations();
		carrier_locations();
		clockwork_locations();
		func_1F5D();
		func_2F1D();
		func_312B();
		flood_locations();
		homecoming_locations();
		func_4A6F();
		nml_locations();
		oilrocks_locations();
		func_8878();
	}

	func_61B7();
	func_1B3F();
	dart();
	func_31E3();
	func_3467();
	frag();
	hashima();
	func_4F3B();
	func_7577();
	func_7671();
	func_7727();
	func_7CD8();
	func_8C2A();
	func_8EA2();
}

//Function Number: 6
func_3798()
{
	add_bcs_location_mapping("trigger_multiple_bcs_generic_doorway_generic","doorway_generic");
	add_bcs_location_mapping("trigger_multiple_bcs_generic_window_generic","window_generic");
	add_bcs_location_mapping("trigger_multiple_bcs_generic_1stfloor_generic","1stfloor_generic");
	add_bcs_location_mapping("trigger_multiple_bcs_generic_1stfloor_doorway","1stfloor_doorway");
	add_bcs_location_mapping("trigger_multiple_bcs_generic_1stfloor_window","1stfloor_window");
	add_bcs_location_mapping("trigger_multiple_bcs_generic_2ndfloor_generic","2ndfloor_generic");
	add_bcs_location_mapping("trigger_multiple_bcs_generic_2ndfloor_window","2ndfloor_window");
	add_bcs_location_mapping("trigger_multiple_bcs_generic_rooftop","rooftop");
	add_bcs_location_mapping("trigger_multiple_bcs_generic_2ndfloor_balcony","2ndfloor_balcony");
}

//Function Number: 7
blackice_locations()
{
	add_bcs_location_mapping("trigger_multiple_bcs_blackice_airconditioner_generic","airconditioner_generic");
	add_bcs_location_mapping("trigger_multiple_bcs_blackice_crate_ammo","crate_ammo");
	add_bcs_location_mapping("trigger_multiple_bcs_blackice_bar_generic","bar_generic");
	add_bcs_location_mapping("trigger_multiple_bcs_blackice_barrels_generic","barrels_generic");
	add_bcs_location_mapping("trigger_multiple_bcs_blackice_bookshelf_generic","bookshelf_generic");
	add_bcs_location_mapping("trigger_multiple_bcs_blackice_bridge_generic","bridge_generic");
	add_bcs_location_mapping("trigger_multiple_bcs_blackice_cart_generic","cart_generic");
	add_bcs_location_mapping("trigger_multiple_bcs_blackice_couch_generic","couch_generic");
	add_bcs_location_mapping("trigger_multiple_bcs_blackice_crates_generic","crates_generic");
	add_bcs_location_mapping("trigger_multiple_bcs_blackice_engine_left","engine_left");
	add_bcs_location_mapping("trigger_multiple_bcs_blackice_engine_right","engine_right");
	add_bcs_location_mapping("trigger_multiple_bcs_blackice_fence_generic","fence_generic");
	add_bcs_location_mapping("trigger_multiple_bcs_blackice_forklift_generic","forklift_generic");
	add_bcs_location_mapping("trigger_multiple_bcs_blackice_generator_generic","generator_generic");
	add_bcs_location_mapping("trigger_multiple_bcs_blackice_loadingbay_generic","loadingbay_generic");
	add_bcs_location_mapping("trigger_multiple_bcs_blackice_pipes_generic","pipes_generic");
	add_bcs_location_mapping("trigger_multiple_bcs_blackice_platform_generic","platform_generic");
	add_bcs_location_mapping("trigger_multiple_bcs_blackice_pooltable_generic","pooltable_generic");
	add_bcs_location_mapping("trigger_multiple_bcs_blackice_porch_generic","porch_generic");
	add_bcs_location_mapping("trigger_multiple_bcs_blackice_ramp_generic","ramp_generic");
	add_bcs_location_mapping("trigger_multiple_bcs_blackice_building_red","building_red");
	add_bcs_location_mapping("trigger_multiple_bcs_blackice_snowbank_generic","snowbank_generic");
	add_bcs_location_mapping("trigger_multiple_bcs_blackice_snowmobile_generic","snowmobile_generic");
	add_bcs_location_mapping("trigger_multiple_bcs_blackice_tank_generic","tank_generic");
	add_bcs_location_mapping("trigger_multiple_bcs_blackice_tent_generic","tent_generic");
	add_bcs_location_mapping("trigger_multiple_bcs_blackice_tires_generic","tires_generic");
	add_bcs_location_mapping("trigger_multiple_bcs_blackice_catwalk_upper","catwalk_upper");
	add_bcs_location_mapping("trigger_multiple_bcs_blackice_deck_upper","deck_upper");
}

//Function Number: 8
carrier_locations()
{
	add_bcs_location_mapping("trigger_multiple_bcs_carrier_plane_jet","plane_jet");
	add_bcs_location_mapping("trigger_multiple_bcs_carrier_plane_f18","plane_f18");
	add_bcs_location_mapping("trigger_multiple_bcs_carrier_towcart_generic","towcart_generic");
	add_bcs_location_mapping("trigger_multiple_bcs_carrier_forklift_generic","forklift_generic");
	add_bcs_location_mapping("trigger_multiple_bcs_carrier_ohelo_osprey","ohelo_osprey");
	add_bcs_location_mapping("trigger_multiple_bcs_carrier_plane_generic","plane_generic");
	add_bcs_location_mapping("trigger_multiple_bcs_carrier_deck_outer","deck_outer");
	add_bcs_location_mapping("trigger_multiple_bcs_carrier_railing_generic","railing_generic");
}

//Function Number: 9
clockwork_locations()
{
	add_bcs_location_mapping("trigger_multiple_bcs_clockwork_pillar_generic","pillar_generic");
	add_bcs_location_mapping("trigger_multiple_bcs_clockwork_pool_generic","pool_generic");
	add_bcs_location_mapping("trigger_multiple_bcs_clockwork_tram_generic","tram_generic");
	add_bcs_location_mapping("trigger_multiple_bcs_clockwork_platform_generic","platform_generic");
	add_bcs_location_mapping("trigger_multiple_bcs_clockwork_platform_left","platform_left");
	add_bcs_location_mapping("trigger_multiple_bcs_clockwork_platform_right","platform_right");
	add_bcs_location_mapping("trigger_multiple_bcs_clockwork_stairs_left","stairs_left");
	add_bcs_location_mapping("trigger_multiple_bcs_clockwork_stairs_generic","stairs_generic");
	add_bcs_location_mapping("trigger_multiple_bcs_clockwork_stairs_right","stairs_right");
	add_bcs_location_mapping("trigger_multiple_bcs_clockwork_walkway_generic","walkway_generic");
	add_bcs_location_mapping("trigger_multiple_bcs_clockwork_walkway_left","walkway_left");
	add_bcs_location_mapping("trigger_multiple_bcs_clockwork_walkway_right","walkway_right");
	add_bcs_location_mapping("trigger_multiple_bcs_clockwork_ramp_main","ramp_main");
	add_bcs_location_mapping("trigger_multiple_bcs_clockwork_catwalk_generic","catwalk_generic");
	add_bcs_location_mapping("trigger_multiple_bcs_clockwork_pool_below","pool_below");
}

//Function Number: 10
func_1F5D()
{
	add_bcs_location_mapping("trigger_multiple_bcs_cornered_balcony_generic","balcony_generic");
	add_bcs_location_mapping("trigger_multiple_bcs_cornered_windows_generic","windows_generic");
	add_bcs_location_mapping("trigger_multiple_bcs_cornered_planter_generic","planter_generic");
	add_bcs_location_mapping("trigger_multiple_bcs_cornered_wall_back","wall_back");
	add_bcs_location_mapping("trigger_multiple_bcs_cornered_tree_generic","tree_generic");
	add_bcs_location_mapping("trigger_multiple_bcs_cornered_rocks_generic","rocks_generic");
	add_bcs_location_mapping("trigger_multiple_bcs_cornered_aquarium_generic","aquarium_generic");
}

//Function Number: 11
func_2F1D()
{
	add_bcs_location_mapping("trigger_multiple_bcs_enemyhq_conession_generic","conession_generic");
	add_bcs_location_mapping("trigger_multiple_bcs_enemyhq_counter_burgertown","counter_burgertown");
	add_bcs_location_mapping("trigger_multiple_bcs_enemyhq_concession_nate","concession_nate");
	add_bcs_location_mapping("trigger_multiple_bcs_enemyhq_stairs_top","stairs_top");
	add_bcs_location_mapping("trigger_multiple_bcs_enemyhq_walkway_generic","walkway_generic");
	add_bcs_location_mapping("trigger_multiple_bcs_enemyhq_rubble_pile","rubble_pile");
	add_bcs_location_mapping("trigger_multiple_bcs_enemyhq_statue_generic","statue_generic");
	add_bcs_location_mapping("trigger_multiple_bcs_enemyhq_counter_generic","counter_generic");
	add_bcs_location_mapping("trigger_multiple_bcs_enemyhq_pillar_generic","pillar_generic");
	add_bcs_location_mapping("trigger_multiple_bcs_enemyhq_cart_trash","cart_trash");
}

//Function Number: 12
func_312B()
{
	add_bcs_location_mapping("trigger_multiple_bcs_factory_lockerroom_generic","lockerroom_generic");
	add_bcs_location_mapping("trigger_multiple_bcs_factory_server_generic","server_generic");
	add_bcs_location_mapping("trigger_multiple_bcs_factory_secondfloor_generic","secondfloor_generic");
	add_bcs_location_mapping("trigger_multiple_bcs_factory_catwalk_generic","catwalk_generic");
	add_bcs_location_mapping("trigger_multiple_bcs_factory_acunit_generic","acunit_generic");
	add_bcs_location_mapping("trigger_multiple_bcs_factory_airduct_generic","airduct_generic");
}

//Function Number: 13
flood_locations()
{
	add_bcs_location_mapping("trigger_multiple_bcs_flood_tank_generic","tank_generic");
	add_bcs_location_mapping("trigger_multiple_bcs_flood_barrier_hesco","barrier_hesco");
	add_bcs_location_mapping("trigger_multiple_bcs_flood_planter_generic","planter_generic");
	add_bcs_location_mapping("trigger_multiple_bcs_flood_pillar_generic","pillar_generic");
	add_bcs_location_mapping("trigger_multiple_bcs_flood_truck_generic","truck_generic");
	add_bcs_location_mapping("trigger_multiple_bcs_flood_crates_generic","crates_generic");
	add_bcs_location_mapping("trigger_multiple_bcs_flood_duct_air","duct_air");
	add_bcs_location_mapping("trigger_multiple_bcs_flood_unit_ac","unit_ac");
	add_bcs_location_mapping("trigger_multiple_bcs_flood_walkway_generic","walkway_generic");
	add_bcs_location_mapping("trigger_multiple_bcs_flood_pit_rubble","pit_rubble");
	add_bcs_location_mapping("trigger_multiple_bcs_flood_car_generic","car_generic");
	add_bcs_location_mapping("trigger_multiple_bcs_flood_van_generic","van_generic");
}

//Function Number: 14
homecoming_locations()
{
	add_bcs_location_mapping("trigger_multiple_bcs_homecoming_crate_ammo","crate_ammo");
	add_bcs_location_mapping("trigger_multiple_bcs_homecoming_barrier_hesco","barrier_hesco");
	add_bcs_location_mapping("trigger_multiple_bcs_homecoming_shack_blue","shack_blue");
	add_bcs_location_mapping("trigger_multiple_bcs_homecoming_barrier_concrete","barrier_concrete");
	add_bcs_location_mapping("trigger_multiple_bcs_homecoming_statue_artemis","statue_artemis");
	add_bcs_location_mapping("trigger_multiple_bcs_homecoming_barrels_generic","barrels_generic");
	add_bcs_location_mapping("trigger_multiple_bcs_homecoming_crate_generic","crate_generic");
	add_bcs_location_mapping("trigger_multiple_bcs_homecoming_bulldozer_geenric","bulldozer_geenric");
	add_bcs_location_mapping("trigger_multiple_bcs_homecoming_towers_hesco","towers_hesco");
	add_bcs_location_mapping("trigger_multiple_bcs_homecoming_sandbags_generic","sandbags_generic");
	add_bcs_location_mapping("trigger_multiple_bcs_homecoming_pillar_generic","pillar_generic");
}

//Function Number: 15
func_4A6F()
{
	add_bcs_location_mapping("trigger_multiple_bcs_jungleghosts_rocks_generic","rocks_generic");
	add_bcs_location_mapping("trigger_multiple_bcs_jungleghosts_bridge_generic","bridge_generic");
	add_bcs_location_mapping("trigger_multiple_bcs_jungleghosts_fern_generic","fern_generic");
	add_bcs_location_mapping("trigger_multiple_bcs_jungleghosts_stream_generic","stream_generic");
	add_bcs_location_mapping("trigger_multiple_bcs_jungleghosts_log_generic","log_generic");
	add_bcs_location_mapping("trigger_multiple_bcs_jungleghosts_rock_generic","rock_generic");
	add_bcs_location_mapping("trigger_multiple_bcs_jungleghosts_stump_generic","stump_generic");
	add_bcs_location_mapping("trigger_multiple_bcs_jungleghosts_tree_generic","tree_generic");
}

//Function Number: 16
nml_locations()
{
	add_bcs_location_mapping("trigger_multiple_bcs_nml_dirt_generic","dirt_generic");
	add_bcs_location_mapping("trigger_multiple_bcs_nml_trailer_generic","trailer_generic");
	add_bcs_location_mapping("trigger_multiple_bcs_nml_building_blue","building_blue");
	add_bcs_location_mapping("trigger_multiple_bcs_nml_bridge_generic","bridge_generic");
	add_bcs_location_mapping("trigger_multiple_bcs_nml_garage_generic","garage_generic");
	add_bcs_location_mapping("trigger_multiple_bcs_nml_sandbags_generic","sandbags_generic");
}

//Function Number: 17
oilrocks_locations()
{
	add_bcs_location_mapping("trigger_multiple_bcs_oilrocks_garage_generic","garage_generic");
	add_bcs_location_mapping("trigger_multiple_bcs_oilrocks_rooftop_generic","rooftop_generic");
	add_bcs_location_mapping("trigger_multiple_bcs_oilrocks_catwalk_generic","catwalk_generic");
	add_bcs_location_mapping("trigger_multiple_bcs_oilrocks_trailer_generic","trailer_generic");
	add_bcs_location_mapping("trigger_multiple_bcs_oilrocks_stairway_generic","stairway_generic");
	add_bcs_location_mapping("trigger_multiple_bcs_oilrocks_barrels_generic","barrels_generic");
	add_bcs_location_mapping("trigger_multiple_bcs_oilrocks_crate_generic","crate_generic");
	add_bcs_location_mapping("trigger_multiple_bcs_oilrocks_can_trash","can_trash");
	add_bcs_location_mapping("trigger_multiple_bcs_oilrocks_roadblock_generic","roadblock_generic");
	add_bcs_location_mapping("trigger_multiple_bcs_oilrocks_pillar_generic","pillar_generic");
	add_bcs_location_mapping("trigger_multiple_bcs_oilrocks_hallway_generic","hallway_generic");
	add_bcs_location_mapping("trigger_multiple_bcs_oilrocks_forklift_generic","forklift_generic");
	add_bcs_location_mapping("trigger_multiple_bcs_oilrocks_can_oxygen","can_oxygen");
}

//Function Number: 18
func_8878()
{
	add_bcs_location_mapping("trigger_multiple_bcs_vegas_planter_generic","planter_generic");
	add_bcs_location_mapping("trigger_multiple_bcs_vegas_fountain_generic","fountain_generic");
	add_bcs_location_mapping("trigger_multiple_bcs_vegas_kiosk_generic","kiosk_generic");
	add_bcs_location_mapping("trigger_multiple_bcs_vegas_slotmachines_generic","slotmachines_generic");
	add_bcs_location_mapping("trigger_multiple_bcs_vegas_rubble_generic","rubble_generic");
	add_bcs_location_mapping("trigger_multiple_bcs_vegas_pokertable_generic","pokertable_generic");
	add_bcs_location_mapping("trigger_multiple_bcs_vegas_debris_generic","debris_generic");
	add_bcs_location_mapping("trigger_multiple_bcs_vegas_escalator_generic","escalator_generic");
	add_bcs_location_mapping("trigger_multiple_bcs_vegas_couch_generic","couch_generic");
	add_bcs_location_mapping("trigger_multiple_bcs_vegas_statue_generic","statue_generic");
	add_bcs_location_mapping("trigger_multiple_bcs_vegas_statue_left","statue_left");
	add_bcs_location_mapping("trigger_multiple_bcs_vegas_statue_right","statue_right");
	add_bcs_location_mapping("trigger_multiple_bcs_vegas_tram_generic","tram_generic");
	add_bcs_location_mapping("trigger_multiple_bcs_vegas_wall_left","wall_left");
	add_bcs_location_mapping("trigger_multiple_bcs_vegas_wall_right","wall_right");
	add_bcs_location_mapping("trigger_multiple_bcs_vegas_tree_generic","tree_generic");
	add_bcs_location_mapping("trigger_multiple_bcs_vegas_car_police","car_police");
	add_bcs_location_mapping("trigger_multiple_bcs_vegas_car_taxi","car_taxi");
	add_bcs_location_mapping("trigger_multiple_bcs_vegas_car_generic","car_generic");
}

//Function Number: 19
func_61B7()
{
	add_bcs_location_mapping("trigger_multiple_bcs_mp_prisonbreak_ridge","ridge");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_prisonbreak_constructionyard","constructionyard");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_prisonbreak_guardtower_generic","guardtower_generic");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_prisonbreak_guardtower_2ndfloor","guardtower_2ndfloor");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_prisonbreak_pipes_blue","pipes_blue");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_prisonbreak_securitystation","securitystation");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_prisonbreak_trailer_red","trailer_red");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_prisonbreak_trailer_blue","trailer_blue");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_prisonbreak_road","road");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_prisonbreak_river","river");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_prisonbreak_loggingcamp","loggingcamp");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_prisonbreak_catwalk","catwalk");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_prisonbreak_logstack","logstack");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_prisonbreak_tirestack","tirestack");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_prisonbreak_loggingtruck","loggingtruck");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_prisonbreak_bridge","bridge");
}

//Function Number: 20
func_1B3F()
{
	add_bcs_location_mapping("trigger_multiple_bcs_mp_chasm_garage_parking","garage_parking");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_chasm_cubicles","cubicles");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_chasm_kitchen","kitchen");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_chasm_elevator","elevator");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_chasm_stairway","stairway");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_chasm_skybridge","skybridge");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_chasm_diner","diner");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_chasm_road_main","road_main");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_chasm_rubble_pit","rubble_pit");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_chasm_restaurant","restaurant");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_chasm_hotel","hotel");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_chasm_bar_hotel","bar_hotel");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_chasm_underground","underground");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_chasm_subway","subway");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_chasm_waterpump","waterpump");
}

//Function Number: 21
dart()
{
	add_bcs_location_mapping("trigger_multiple_bcs_mp_dart_gasstation","gasstation");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_dart_autoshop_2ndfloor","autoshop_2ndfloor");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_dart_autoshop","autoshop");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_dart_pinkeez","pinkeez");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_dart_pinkeez_2ndfloor","pinkeez_2ndfloor");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_dart_alley_stripclub","alley_stripclub");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_dart_pawnshop","pawnshop");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_dart_shed_blue","shed_blue");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_dart_motel","motel");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_dart_bus_stripclub","bus_stripclub");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_dart_bus_motel","bus_motel");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_dart_diner","diner");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_dart_alley_convenience","alley_convenience");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_dart_intersection","intersection");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_dart_tank_gasstation","tank_gasstation");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_dart_tank_motel","tank_motel");
}

//Function Number: 22
func_31E3()
{
	add_bcs_location_mapping("trigger_multiple_bcs_mp_farenheit_road_main","road_main");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_farenheit_library","library");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_farenheit_grass_tall","grass_tall");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_farenheit_monument","monument");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_farenheit_trailer_red","trailer_red");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_farenheit_restaurant","restaurant");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_farenheit_underground","underground");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_farenheit_garage_parking","garage_parking");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_farenheit_bar","bar");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_farenheit_escalators","escalators");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_farenheit_bridge","bridge");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_farenheit_bridge_under","bridge_under");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_farenheit_reception","reception");
}

//Function Number: 23
func_3467()
{
	add_bcs_location_mapping("trigger_multiple_bcs_mp_flooded_garage_lower","garage_lower");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_flooded_garage_upper","garage_upper");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_flooded_courtyard","courtyard");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_flooded_patio","patio");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_flooded_restaurant","restaurant");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_flooded_bar","bar");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_flooded_kitchen","kitchen");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_flooded_skybridge","skybridge");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_flooded_storage_downstairs","storage_downstairs");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_flooded_building_office","building_office");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_flooded_breakroom","breakroom");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_flooded_lobby","lobby");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_flooded_newsstation","newsstation");
}

//Function Number: 24
frag()
{
	add_bcs_location_mapping("trigger_multiple_bcs_mp_frag_lumberyard","lumberyard");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_frag_containers","containers");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_frag_traintracks","traintracks");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_frag_distillery","distillery");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_frag_distillery_south","distillery_south");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_frag_distillery_north","distillery_north");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_frag_distillery_2ndfloor","distillery_2ndfloor");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_frag_sign_porter","sign_porter");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_frag_owens","owens");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_frag_owens_2ndfloor","owens_2ndfloor");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_frag_owens_3rdfloor","owens_3rdfloor");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_frag_pipes_high","pipes_high");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_frag_junkyard","junkyard");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_frag_warehouse","warehouse");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_frag_warehouse_2ndfloor","warehouse_2ndfloor");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_frag_warehouse_3rdfloor","warehouse_3rdfloor");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_frag_roof_broken","roof_broken");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_frag_wall_broken","wall_broken");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_frag_dumpster_blue","dumpster_blue");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_frag_dumpster_red","dumpster_red");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_frag_fence_metal","fence_metal");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_frag_window_broken","window_broken");
}

//Function Number: 25
hashima()
{
	add_bcs_location_mapping("trigger_multiple_bcs_mp_hashima_playground","playground");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_hashima_hangar","hangar");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_hashima_sam","sam");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_hashima_mine","mine");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_hashima_controlroom","controlroom");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_hashima_traintracks","traintracks");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_hashima_waterfall","waterfall");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_hashima_docks","docks");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_hashima_basement","basement");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_hashima_tower_water","tower_water");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_hashima_tower","tower");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_hashima_building_redbrick","building_redbrick");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_hashima_building_redbrick_2ndflr","building_redbrick_2ndflr");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_hashima_apartment","apartment");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_hashima_apartment_2ndfloor","apartment_2ndfloor");
}

//Function Number: 26
func_4F3B()
{
	add_bcs_location_mapping("trigger_multiple_bcs_mp_lonestar_helicopter_crashed","helicopter_crashed");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_lonestar_tent_fema","tent_fema");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_lonestar_carwash","carwash");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_lonestar_gasmain","gasmain");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_lonestar_kiosk","kiosk");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_lonestar_parking_garage","parking_garage");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_lonestar_burned_building","burned_building");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_lonestar_gasstation","gasstation");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_lonestar_rehab","rehab");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_lonestar_rehab_roof","rehab_roof");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_lonestar_skybridge","skybridge");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_lonestar_office_1stfloor","office_1stfloor");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_lonestar_office_2ndfloor","office_2ndfloor");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_lonestar_office_roof","office_roof");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_lonestar_ambulance_service_1stfloor","ambulance_service_1stfloor");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_lonestar_ambulance_service_2ndfloor","ambulance_service_2ndfloor");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_lonestar_hospital_collapsed","hospital_collapsed");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_lonestar_solarpanels","solarpanels");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_lonestar_garage_blue","garage_blue");
}

//Function Number: 27
func_7577()
{
	add_bcs_location_mapping("trigger_multiple_bcs_mp_skeleton_castle","castle");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_skeleton_mansion","mansion");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_skeleton_well","well");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_skeleton_hill","hill");
}

//Function Number: 28
func_7671()
{
	add_bcs_location_mapping("trigger_multiple_bcs_mp_snow_crashsite","crashsite");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_snow_canyon","canyon");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_snow_sawmill","sawmill");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_snow_waterwheel","waterwheel");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_snow_helicopter","helicopter");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_snow_shipwreck","shipwreck");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_snow_shipwreck_bow","shipwreck_bow");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_snow_ridge","ridge");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_snow_road_main","road_main");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_snow_totempole","totempole");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_snow_cabin","cabin");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_snow_boathouse","boathouse");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_snow_dock_fishing","dock_fishing");
}

//Function Number: 29
func_7727()
{
	add_bcs_location_mapping("trigger_multiple_bcs_mp_sovereign_catwalk_blue","catwalk_blue");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_sovereign_catwalk_yellow","catwalk_yellow");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_sovereign_centralcommand","centralcommand");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_sovereign_cleanroom","cleanroom");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_sovereign_warehouse","warehouse");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_sovereign_hologram","hologram");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_sovereign_assemblyline","assemblyline");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_sovereign_commanddeck","commanddeck");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_sovereign_serverroom","serverroom");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_sovereign_breakroom","breakroom");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_sovereign_shaft","shaft");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_sovereign_research","research");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_sovereign_office_2ndfloor","office_2ndfloor");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_sovereign_warehouse_2ndfloor","warehouse_2ndfloor");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_sovereign_crate","crate");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_sovereign_halogen","halogen");
}

//Function Number: 30
func_7CD8()
{
	add_bcs_location_mapping("trigger_multiple_bcs_mp_strikezone_bar","bar");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_strikezone_bar_behind","bar_behind");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_strikezone_backentrance","backentrance");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_strikezone_Ronnies_01","Ronnies_01");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_strikezone_proshop","proshop");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_strikezone_statue","statue");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_strikezone_skywalk","skywalk");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_strikezone_concessions","concessions");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_strikezone_atrium","atrium");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_strikezone_concourse_upper","concourse_upper");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_strikezone_concourse_lower","concourse_lower");
}

//Function Number: 31
func_8C2A()
{
	add_bcs_location_mapping("trigger_multiple_bcs_mp_warhawk_ambulancebay","ambulancebay");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_warhawk_bar","bar");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_warhawk_bakery","bakery");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_warhawk_loadingdock","loadingdock");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_warhawk_granary","granary");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_warhawk_icecream","icecream");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_warhawk_apartment","apartment");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_warhawk_loft","loft");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_warhawk_cityhall","cityhall");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_warhawk_postoffice","postoffice");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_warhawk_alley_fence","alley_fence");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_warhawk_backlot","backlot");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_warhawk_carport","carport");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_warhawk_hardwarestore","hardwarestore");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_warhawk_drugstore","drugstore");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_warhawk_trailer","trailer");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_warhawk_watertower","watertower");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_warhawk_repairshop","repairshop");
}

//Function Number: 32
func_8EA2()
{
	add_bcs_location_mapping("trigger_multiple_bcs_mp_zebra_sciencelab","sciencelab");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_zebra_radiostation","radiostation");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_zebra_hangar","hangar");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_zebra_guardtower","guardtower");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_zebra_bunker","bunker");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_zebra_solarpanels","solarpanels");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_zebra_hill","hill");
}