/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\common\bcs_location_trigs.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 18
 * Decompile Time: 913 ms
 * Timestamp: 10/27/2023 12:03:08 AM
*******************************************************************/

//Function Number: 1
func_29BB()
{
	level.var_29B9 = [];
	func_29BA();
	func_29C7();
	level.var_29B9 = undefined;
	anim.var_AECC = [];
}

//Function Number: 2
func_29C7()
{
	anim.var_29BC = [];
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

	anim.var_29BC = var_01;
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
	if(scripts\common\utility::issp())
	{
		func_104AC();
		return;
	}

	metropolis();
	quarry();
	breakneck();
	desert();
	divide();
	func_6B6E();
	frontier();
	parkour();
	riot();
	rivet();
	proto();
	skyway();
}

//Function Number: 6
func_104AC()
{
	func_169E("trigger_multiple_bcs_sp_doorway","doorway_generic");
	func_169E("trigger_multiple_bcs_sp_window_generic","window_generic");
	func_169E("trigger_multiple_bcs_sp_1stfloor","1stfloor_generic");
	func_169E("trigger_multiple_bcs_sp_2ndfloor","2ndfloor_generic");
	func_169E("trigger_multiple_bcs_sp_rooftop","rooftop_generic");
	func_169E("trigger_multiple_bcs_sp_balcony_generic","balcony_generic");
	func_169E("trigger_multiple_bcs_sp_bridge","bridge_generic");
	func_169E("trigger_multiple_bcs_sp_catwalk","catwalk_generic");
	func_169E("trigger_multiple_bcs_sp_crates_generic","crates_generic");
	func_169E("trigger_multiple_bcs_sp_hallway","hallway_generic");
	func_169E("trigger_multiple_bcs_sp_pillar","pillar_generic");
	func_169E("trigger_multiple_bcs_sp_pipes_generic","pipes_generic");
	func_169E("trigger_multiple_bcs_sp_railings","railings_generic");
	func_169E("trigger_multiple_bcs_sp_bar","bar_generic");
	func_169E("trigger_multiple_bcs_sp_cafe","cafe_generic");
	func_169E("trigger_multiple_bcs_sp_counter","counter_generic");
	func_169E("trigger_multiple_bcs_sp_elevator","elevator_generic");
	func_169E("trigger_multiple_bcs_sp_fountain","fountain_generic");
	func_169E("trigger_multiple_bcs_sp_generator","generator_generic");
	func_169E("trigger_multiple_bcs_sp_loadingbay","loadingbay_generic");
	func_169E("trigger_multiple_bcs_sp_ramp_generic","ramp_generic");
	func_169E("trigger_multiple_bcs_sp_stairs","stairs_generic");
	func_169E("trigger_multiple_bcs_sp_statue","statue_generic");
	func_169E("trigger_multiple_bcs_sp_turbines","turbines_generic");
	func_169E("trigger_multiple_bcs_sp_wall_generic","wall_generic");
	func_169E("trigger_multiple_bcs_sp_courtyard","courtyard_generic");
	func_169E("trigger_multiple_bcs_sp_street_generic","street_generic");
	func_169E("trigger_multiple_bcs_sp_planter","planter_generic");
	func_169E("trigger_multiple_bcs_sp_bench","bench_generic");
	func_169E("trigger_multiple_bcs_sp_boats","boats_generic");
	func_169E("trigger_multiple_bcs_sp_ladder","ladder_generic");
	func_169E("trigger_multiple_bcs_sp_tables","tables_generic");
	func_169E("trigger_multiple_bcs_sp_sign_generic","sign_generic");
	func_169E("trigger_multiple_bcs_sp_barricade_multiple","barricades_generic");
	func_169E("trigger_multiple_bcs_sp_garage","garage_generic");
	func_169E("trigger_multiple_bcs_sp_trench","trench_generic");
	func_169E("trigger_multiple_sp_rock","rock_generic");
	func_169E("trigger_multiple_bcs_sp_crater","crater_generic");
	func_169E("trigger_multiple_bcs_sp_trees","trees_generic");
	func_169E("trigger_multiple_bcs_sp_rubble","rubble_generic");
	func_169E("trigger_multiple_bcs_sp_dropship","dropship_generic");
	func_169E("trigger_multiple_bcs_sp_bookstore","bookstore_generic");
	func_169E("trigger_multiple_bcs_sp_bus","bus_generic");
	func_169E("trigger_multiple_bcs_sp_shop_kiosk","kiosk_generic");
	func_169E("trigger_multiple_bcs_sp_solarpanels","solarpanels_generic");
	func_169E("trigger_multiple_bcs_sp_aagun","aagun_generic");
	func_169E("trigger_multiple_bcs_sp_stairway","stairway_generic");
	func_169E("trigger_multiple_bcs_sp_foodcourt","foodcourt_generic");
	func_169E("trigger_multiple_bcs_sp_railcar","railcar_generic");
	func_169E("trigger_multiple_bcs_sp_droppod","droppod_generic");
	func_169E("trigger_multiple_bcs_sp_shop_generic","shop_generic");
	func_169E("trigger_multiple_bcs_sp_vendingmachine","vendingmachine_generic");
	func_169E("trigger_multiple_bcs_sp_lounge","lounge_generic");
	func_169E("trigger_multiple_bcs_sp_checkpoint","checkpoint_generic");
	func_169E("trigger_multiple_bcs_sp_hangar","hangar_generic");
	func_169E("trigger_multiple_bcs_sp_deck_upper","deck_upper");
	func_169E("trigger_multiple_bcs_sp_ramp_main","ramp_main");
	func_169E("trigger_multiple_bcs_sp_drill_heads","drill_heads");
	func_169E("trigger_multiple_bcs_sp_street_end","street_end");
	func_169E("trigger_multiple_bcs_sp_sign_parking","parking_sign");
	func_169E("trigger_multiple_bcs_sp_sign_yield","yield_sign");
	func_169E("trigger_multiple_bcs_sp_3rd_floor","3rdfloor");
	func_169E("trigger_multiple_bcs_sp_vehicle_van","vehicle_van");
	func_169E("trigger_multiple_bcs_sp_banner_blue","banner_blue");
	func_169E("trigger_multiple_bcs_sp_building_destroyed","building_destroyed");
	func_169E("trigger_multiple_bcs_sp_conveyor_belt","conveyor_belt");
	func_169E("trigger_multiple_bcs_sp_door_security","security_door");
	func_169E("trigger_multiple_bcs_sp_trash_cans","trash_cans");
	func_169E("trigger_multiple_bcs_sp_door_report","door_report");
	func_169E("trigger_multiple_bcs_sp_door_1stfloor_report","door_1st_report");
	func_169E("trigger_multiple_bcs_sp_door_2ndfloor_report","door_2nd_report");
	func_169E("trigger_multiple_bcs_sp_window_3rdfloor","window_3rdfloor");
	func_169E("trigger_multiple_bcs_sp_window_1stfloor_report","wndw_1st_report");
	func_169E("trigger_multiple_bcs_sp_window_2ndfloor_report","wndw_2nd_report");
	func_169E("trigger_multiple_bcs_sp_floor_1st_report","1st_report");
	func_169E("trigger_multiple_bcs_sp_floor_2nd_report","2nd_report");
	func_169E("trigger_multiple_bcs_sp_fuel_tanks","fuel_tanks");
	func_169E("trigger_multiple_bcs_sp_barrier_concrete","concrete_barrier");
	func_169E("trigger_multiple_bcs_sp_barrels_yellow","barrels_yellow");
	func_169E("trigger_multiple_bcs_sp_barrels_generic","barrels_generic");
	func_169E("trigger_multiple_bcs_sp_barrels_blue","barrels_blue");
	func_169E("trigger_multiple_bcs_sp_oildrum","oildrum_generic");
	func_169E("trigger_multiple_bcs_sp_balcony_2ndfloor","balcony_2ndfloor");
	func_169E("trigger_multiple_bcs_sp_vent","vent_generic");
	func_169E("trigger_multiple_bcs_sp_controlpanel","controlpanel_generic");
	func_169E("trigger_multiple_bcs_sp_lockers","lockers_generic");
	func_169E("trigger_multiple_bcs_sp_container_stacked","container_stacked");
	func_169E("trigger_multiple_bcs_sp_container_shipping","container_shipping");
	func_169E("trigger_multiple_bcs_sp_crates_plastic","crates_plastic");
	func_169E("trigger_multiple_bcs_sp_crates_pile","crates_pile");
	func_169E("trigger_multiple_bcs_sp_crates_white","crates_white");
	func_169E("trigger_multiple_bcs_sp_crates_ammo","crate_ammo");
	func_169E("trigger_multiple_bcs_sp_commandcenter","commandcenter_generic");
	func_169E("trigger_multiple_bcs_sp_rack_missile","rack_missile");
	func_169E("trigger_multiple_bcs_sp_pipes_gas","pipes_gas");
	func_169E("trigger_multiple_bcs_sp_vehicle_atv","vehicle_atv");
	func_169E("trigger_multiple_bcs_sp_wall_low","wall_low");
	func_169E("trigger_multiple_bcs_sp_boulder_generic","boulder_generic");
	func_169E("trigger_multiple_bcs_sp_boulder_gap","boulder_gap");
	func_169E("trigger_multiple_bcs_sp_vehicle_tram","vehicle_tram");
	func_169E("trigger_multiple_bcs_sp_shop_dutyfree","shop_dutyfree");
	func_169E("trigger_multiple_bcs_sp_shop_jewelry","shop_jewelry");
	func_169E("trigger_multiple_bcs_sp_cart_luggage","cart_luggage");
	func_169E("trigger_multiple_bcs_sp_vehicle_forklift","vehicle_forklift");
	func_169E("trigger_multiple_bcs_sp_servers","servers_generic");
	func_169E("trigger_multiple_bcs_sp_vehicle_transport","vehicle_transport");
	func_169E("trigger_multiple_bcs_sp_wall_stone","wall_stone");
	func_169E("trigger_multiple_bcs_sp_wall_brick","wall_brick");
	func_169E("trigger_multiple_bcs_sp_barricade_single","barricades_generic");
	func_169E("trigger_multiple_bcs_sp_bushes","bushes_generic");
	func_169E("trigger_multiple_bcs_sp_tower_control","tower_control");
	func_169E("trigger_multiple_bcs_sp_missile_launcher","missile_launcher");
	func_169E("trigger_multiple_bcs_sp_tower_radar","tower_radar");
	func_169E("trigger_multiple_bcs_sp_satdish","satdish_generic");
	func_169E("trigger_multiple_bcs_sp_door_cargo","door_cargo");
	func_169E("trigger_multiple_bcs_sp_gun_big","gun_big");
	func_169E("trigger_multiple_bcs_sp_deck_lower","deck_lower");
	func_169E("trigger_multiple_bcs_sp_side_port","side_port");
	func_169E("trigger_multiple_bcs_sp_tower_generic","tower_generic");
	func_169E("trigger_multiple_bcs_sp_dropshipbay","dropshipbay_generic");
	func_169E("trigger_multiple_bcs_sp_roomcontrol","room_control");
	func_169E("trigger_multiple_bcs_sp_terminal","terminal_generic");
	func_169E("trigger_multiple_bcs_sp_radar","radar_generic");
	func_169E("trigger_multiple_bcs_sp_wheelhouse","wheelhouse_generic");
	func_169E("trigger_multiple_bcs_sp_deck_2nd","deck_2nd");
	func_169E("trigger_multiple_bcs_sp_missile_rack","missile_rack");
	func_169E("trigger_multiple_bcs_sp_below","below_generic");
	func_169E("trigger_multiple_bcs_sp_hatch","hatch_generic");
	func_169E("trigger_multiple_bcs_sp_bulkheads","bulkheads_generic");
	func_169E("trigger_multiple_bcs_sp_topside","topside_generic");
	func_169E("trigger_multiple_bcs_sp_debris","debris_generic");
	func_169E("trigger_multiple_bcs_sp_above","above_generic");
	func_169E("trigger_multiple_bcs_sp_missile_silos","missile_silos");
	func_169E("trigger_multiple_bcs_sp_deck_gun","deck_gun");
	func_169E("trigger_multiple_bcs_sp_torpedo_mag","torpedo_mag");
	func_169E("trigger_multiple_bcs_sp_airlock","airlock_generic");
	func_169E("trigger_multiple_bcs_sp_cargobay","cargobay_generic");
	func_169E("trigger_multiple_bcs_sp_controlcenter","controlcenter_generic");
	func_169E("trigger_multiple_bcs_sp_armory","armory_generic");
	func_169E("trigger_multiple_bcs_sp_rack_ordnance","rack_ordnance");
	func_169E("trigger_multiple_bcs_sp_vault","vault_generic");
	func_169E("trigger_multiple_bcs_sp_pipes_orange","pipes_orange");
	func_169E("trigger_multiple_bcs_sp_console","console_generic");
	func_169E("trigger_multiple_bcs_sp_gurney","gurney_generic");
	func_169E("trigger_multiple_bcs_sp_scanner_body","scanner_body");
	func_169E("trigger_multiple_bcs_sp_bed","bed_generic");
	func_169E("trigger_multiple_bcs_sp_refinery","refinery_generic");
	func_169E("trigger_multiple_bcs_sp_tank_fuel","tank_fuel");
	func_169E("trigger_multiple_bcs_sp_roof_vents","roof_vents");
	func_169E("trigger_multiple_bcs_sp_truck_cargo","truck_cargo");
	func_169E("trigger_multiple_bcs_sp_drill_generic","drill_generic");
}

//Function Number: 7
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

//Function Number: 8
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

//Function Number: 9
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

//Function Number: 10
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

//Function Number: 11
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

//Function Number: 12
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

//Function Number: 13
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

//Function Number: 14
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

//Function Number: 15
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

//Function Number: 16
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

//Function Number: 17
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

//Function Number: 18
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