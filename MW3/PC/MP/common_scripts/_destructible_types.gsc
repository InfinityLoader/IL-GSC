/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: common_scripts\_destructible_types.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: PC
 * Function Count: 161
 * Decompile Time: 2627 ms
 * Timestamp: 10/27/2023 2:17:01 AM
*******************************************************************/

//Function Number: 1
maketype(param_00)
{
	var_01 = getinfoindex(param_00);
	if(var_01 >= 0)
	{
		return var_01;
	}

	switch(param_00)
	{
		case "rus_vx_gas_canister":
			dest_pb_planter(param_00);
			break;

		case "prop_ac_prs_enm_barge_a_1":
			prop_ac_prs_enm_barge_a_1();
			break;

		case "prop_ac_prs_enm_barge_a_2":
			prop_ac_prs_enm_barge_a_2();
			break;

		case "prop_ac_prs_enm_con_digger_a":
			prop_ac_prs_enm_con_digger_a();
			break;

		case "prop_ac_prs_enm_con_dump_truck_a":
			prop_ac_prs_enm_con_dump_truck_a();
			break;

		case "prop_ac_prs_enm_fuel_tank_a":
			prop_ac_prs_enm_fuel_tank_a();
			break;

		case "vehicle_jeep":
			vehicle_uaz_fabric(param_00);
			break;

		case "vehicle_uaz_van_destructible":
			vehicle_subcompact(param_00);
			break;

		case "prop_ac_prs_enm_hanger_a":
			prop_ac_prs_enm_hanger_a();
			break;

		case "prop_ac_prs_enm_maz_a":
			prop_ac_prs_enm_maz_a();
			break;

		case "prop_ac_prs_enm_mi26_halo_a":
			prop_ac_prs_enm_mi26_halo_a();
			break;

		case "prop_ac_prs_enm_mstas_a":
			prop_ac_prs_enm_mstas_a();
			break;

		case "prop_ac_prs_enm_radar_maz_a":
			prop_ac_prs_enm_radar_maz_a();
			break;

		case "prop_ac_prs_enm_s300v_a":
			prop_ac_prs_enm_s300v_a();
			break;

		case "prop_ac_prs_enm_storage_bld_a_1":
			prop_ac_prs_enm_storage_bld_a_1();
			break;

		case "prop_ac_prs_enm_storage_bld_a_2":
			prop_ac_prs_enm_storage_bld_a_2();
			break;

		case "prop_ac_prs_enm_storage_bld_b":
			prop_ac_prs_enm_storage_bld_b();
			break;

		case "vehicle_semi_truck":
			vehicle_mig29_landed();
			break;

		case "prop_ac_prs_enm_tent_a":
			prop_ac_prs_enm_tent_a();
			break;

		case "prop_ac_prs_enm_tent_b":
			prop_ac_prs_enm_tent_b();
			break;

		case "prop_ac_prs_enm_tent_c":
			prop_ac_prs_enm_tent_c();
			break;

		case "prop_ac_prs_enm_truck_a":
			prop_ac_prs_enm_truck_a();
			break;

		case "prop_ac_prs_enm_cargo_crate_a_1":
			prop_ac_prs_enm_cargo_crate_a_1();
			break;

		case "prop_ac_prs_enm_cargo_crate_a_2":
			prop_ac_prs_enm_cargo_crate_a_2();
			break;

		case "prop_ac_prs_enm_crates_a_1":
			prop_ac_prs_enm_crates_a_1();
			break;

		case "prop_ac_prs_enm_crates_a_2":
			prop_ac_prs_enm_crates_a_2();
			break;

		case "prop_ac_prs_enm_crates_b_1":
			prop_ac_prs_enm_crates_b_1();
			break;

		case "prop_ac_prs_enm_crates_b_2":
			prop_ac_prs_enm_crates_b_2();
			break;

		case "prop_ac_prs_enm_mobile_crane_a":
			prop_ac_prs_enm_mobile_crane_a();
			break;

		case "prop_ac_prs_enm_landing_craft_a":
			prop_ac_prs_enm_landing_craft_a();
			break;

		case "prop_ac_prs_enm_speed_boat_a":
			prop_ac_prs_enm_speed_boat_a();
			break;

		case "prop_ac_prs_prp_satellite_dish_a_dish":
			prop_ac_prs_prp_satellite_dish_a_dish();
			break;

		case "prop_ac_prs_fps_hc_extc_balcony_a1":
			prop_ac_prs_fps_hc_extc_balcony_a1();
			break;

		case "prop_ac_prs_fps_hc_extc_balcony_a2":
			prop_ac_prs_fps_hc_extc_balcony_a2();
			break;

		case "prop_ac_prs_fps_hc_extc_balcony_a3":
			prop_ac_prs_fps_hc_extc_balcony_a3();
			break;

		case "prop_ac_prs_fps_hc_extc_balcony_b1":
			prop_ac_prs_fps_hc_extc_balcony_b1();
			break;

		case "prop_ac_prs_fps_hc_extc_balcony_b2":
			prop_ac_prs_fps_hc_extc_balcony_b2();
			break;

		case "prop_ac_prs_fps_hc_extc_balcony_b3":
			prop_ac_prs_fps_hc_extc_balcony_b3();
			break;

		case "prop_ac_prs_fps_hc_extc_balcony_c1":
			prop_ac_prs_fps_hc_extc_balcony_c1();
			break;

		case "prop_ac_prs_fps_hc_extc_balcony_c2":
			prop_ac_prs_fps_hc_extc_balcony_c2();
			break;

		case "prop_ac_prs_fps_hc_extc_column_b_a1":
			prop_ac_prs_fps_hc_extc_column_b_a1();
			break;

		case "prop_ac_prs_fps_hc_extc_column_b_a2":
			prop_ac_prs_fps_hc_extc_column_b_a2();
			break;

		case "prop_ac_prs_fps_hc_extc_column_b_a3":
			prop_ac_prs_fps_hc_extc_column_b_a3();
			break;

		case "prop_ac_prs_fps_hc_extc_column_t_a1":
			prop_ac_prs_fps_hc_extc_column_t_a1();
			break;

		case "prop_ac_prs_fps_hc_extc_column_t_a2":
			prop_ac_prs_fps_hc_extc_column_t_a2();
			break;

		case "prop_ac_prs_fps_hc_extc_column_t_a3":
			prop_ac_prs_fps_hc_extc_column_t_a3();
			break;

		case "prop_ac_prs_enm_missile_boat_a":
			prop_ac_prs_enm_missile_boat_a();
			break;

		case "toy_glass120x110":
			toy_glass("120x110");
			break;

		case "vehicle_mini_destructible_blue":
			get_precached_animtree("blue");
			break;

		case "vehicle_mini_destructible_gray":
			get_precached_animtree("gray");
			break;

		case "vehicle_mini_destructible_white":
			get_precached_animtree("white");
			break;

		case "vehicle_mini_destructible_red":
			get_precached_animtree("red");
			break;

		case "toy_glass120x44":
			toy_glass("120x44");
			break;

		case "toy_glass56x59":
			toy_glass("56x59");
			break;

		case "toy_glass74x110":
			toy_glass("74x110");
			break;

		case "toy_glass74x44":
			toy_glass("74x44");
			break;

		case "toy_dt_mirror":
			toy_dt_mirror("");
			break;

		case "toy_dt_mirror_large":
			toy_dt_mirror("_large");
			break;

		case "toy_icbm_consolemonitor1":
			toy_icbm_consolemonitor("1");
			break;

		case "toy_icbm_consolemonitor2":
			toy_icbm_consolemonitor("2");
			break;

		case "toy_icbm_consolemonitor3":
			toy_icbm_consolemonitor("3");
			break;

		case "toy_icbm_consolemonitor4":
			toy_icbm_consolemonitor("4");
			break;

		case "toy_icbm_consolemonitor5":
			toy_icbm_consolemonitor("5");
			break;

		case "toy_icbm_consolemonitor6":
			toy_icbm_consolemonitor("6");
			break;

		case "toy_tubetv_tv1":
			toy_tubetv_("tv1");
			break;

		case "toy_tubetv_tv2":
			toy_tubetv_("tv2");
			break;

		case "toy_tv_flatscreen_01":
			toy_tvs_flatscreen("01","");
			break;

		case "toy_tv_flatscreen_02":
			toy_tvs_flatscreen("02","");
			break;

		case "toy_tv_flatscreen_wallmount_01":
			toy_tvs_flatscreen("01","wallmount_");
			break;

		case "toy_tv_flatscreen_wallmount_01_sturdy":
			toy_tvs_flatscreen_sturdy("01","wallmount_");
			break;

		case "toy_tv_flatscreen_wallmount_02":
			toy_tvs_flatscreen("02","wallmount_");
			break;

		case "toy_transformer_ratnest01":
			toy_transformer_ratnest01(param_00);
			break;

		case "toy_transformer_small01":
			toy_transformer_small01(param_00);
			break;

		case "toy_generator":
			toy_generator(param_00);
			break;

		case "toy_generator_on":
			toy_generator_on(param_00);
			break;

		case "toy_oxygen_tank_01":
			toy_oxygen_tank("01");
			break;

		case "toy_oxygen_tank_02":
			toy_oxygen_tank("02");
			break;

		case "toy_electricbox2":
			toy_electricbox2(param_00);
			break;

		case "toy_electricbox4":
			toy_electricbox4(param_00);
			break;

		case "toy_airconditioner":
			toy_airconditioner(param_00);
			break;

		case "toy_ceiling_fan":
			toy_ceiling_fan(param_00);
			break;

		case "toy_wall_fan":
			toy_wall_fan(param_00);
			break;

		case "toy_propane_tank02":
			toy_propane_tank02(param_00);
			break;

		case "toy_propane_tank02_small":
			toy_propane_tank02_small(param_00);
			break;

		case "toy_copier":
			toy_copier(param_00);
			break;

		case "toy_firehydrant":
			toy_firehydrant(param_00);
			break;

		case "toy_parkingmeter":
			toy_parkingmeter(param_00);
			break;

		case "toy_mailbox":
			toy_mailbox(param_00);
			break;

		case "toy_mailbox2_black":
			toy_mailbox2("black");
			break;

		case "toy_mailbox2_green":
			toy_mailbox2("green");
			break;

		case "toy_mailbox2_yellow":
			toy_mailbox2("yellow");
			break;

		case "toy_newspaper_stand_red":
			toy_newspaper_stand_red(param_00);
			break;

		case "toy_newspaper_stand_blue":
			toy_newspaper_stand_blue(param_00);
			break;

		case "toy_filecabinet":
			toy_filecabinet(param_00);
			break;

		case "toy_trashbin_01":
			toy_trashbin_01(param_00);
			break;

		case "toy_trashbin_02":
			toy_trashbin_02(param_00);
			break;

		case "toy_trashbag1_white":
			toy_trashbag1("white");
			break;

		case "toy_trashbag1_black":
			toy_trashbag1("black");
			break;

		case "toy_trashbag1_green":
			toy_trashbag1("green");
			break;

		case "toy_recyclebin_01":
			toy_recyclebin_01(param_00);
			break;

		case "toy_trashcan_metal_closed":
			toy_trashcan_metal_closed(param_00);
			break;

		case "toy_water_collector":
			toy_water_collector(param_00);
			break;

		case "toy_foliage_tree_oak_1":
			toy_foliage_tree_oak_1(param_00);
			break;

		case "toy_paris_tree_plane_large":
			toy_paris_tree_plane_large(param_00);
			break;

		case "toy_usa_gas_station_trash_bin_01":
			toy_usa_gas_station_trash_bin_01(param_00);
			break;

		case "toy_usa_gas_station_trash_bin_02":
			toy_usa_gas_station_trash_bin_02(param_00);
			break;

		case "toy_light_ceiling_round":
			toy_light_ceiling_round(param_00);
			break;

		case "toy_light_ceiling_fluorescent":
			toy_light_ceiling_fluorescent(param_00);
			break;

		case "toy_light_ceiling_fluorescent_spotlight":
			toy_light_ceiling_fluorescent_spotlight(param_00);
			break;

		case "toy_light_ceiling_fluorescent_single":
			toy_light_ceiling_fluorescent_single(param_00);
			break;

		case "toy_light_ceiling_fluorescent_single_spotlight":
			toy_light_ceiling_fluorescent_single_spotlight(param_00);
			break;

		case "toy_bookstore_bookstand4_books":
			toy_bookstore_bookstand4_books(param_00);
			break;

		case "toy_locker_double":
			toy_locker_double(param_00);
			break;

		case "toy_chicken":
			toy_chicken("");
			break;

		case "toy_chicken_white":
			toy_chicken("_white");
			break;

		case "toy_chicken_black_white":
			toy_chicken("_black_white");
			break;

		case "toy_luggage_01":
			toy_hide_with_fx("toy_luggage_01","luggage1_lod0","maps/hijack/luggage_1_des_hjk",120);
			break;

		case "toy_luggage_02":
			toy_hide_with_fx("toy_luggage_02","luggage2_lod0","maps/hijack/luggage_2_des_hjk",120);
			break;

		case "toy_luggage_03":
			toy_hide_with_fx("toy_luggage_03","luggage3_lod0","maps/hijack/luggage_3_des_hjk",120);
			break;

		case "toy_luggage_04":
			toy_hide_with_fx("toy_luggage_04","luggage4_lod0","maps/hijack/luggage_4_des_hjk",120);
			break;

		case "toy_com_cardboardbox_dusty_05":
			toy_hide_with_fx("toy_com_cardboardbox_dusty_05","cardboardbox_5_lod0","props/cardboardbox01_snacks_exp",30);
			break;

		case "toy_com_cardboardboxshortclosed_1":
			toy_hide_with_fx("toy_com_cardboardboxshortclosed_1","cardboardboxshortclosed_1_lod0","props/cardboardboxshortclosed_snacks_exp",30);
			break;

		case "intro_gate_column_02_dest_01":
			toy_intro_concrete_chipaway("intro_gate_column_02_dest_01",12);
			break;

		case "intro_concrete_junkyardwall_01":
			toy_intro_concrete_chipaway("intro_concrete_junkyardwall_01",9);
			break;

		case "intro_concrete_kneehighwall_01":
			toy_intro_concrete_chipaway("intro_concrete_kneehighwall_01",8);
			break;

		case "dub_lobby_fish_sculpture_left_orange":
			toy_dubai_fish_sculpture("dub_lobby_fish_sculpture_left_orange","orange",40);
			break;

		case "dub_lobby_fish_sculpture_right_orange":
			toy_dubai_fish_sculpture("dub_lobby_fish_sculpture_right_orange","orange",40);
			break;

		case "dub_lobby_fish_sculpture_left_blue":
			toy_dubai_fish_sculpture("dub_lobby_fish_sculpture_left_blue","blue",45);
			break;

		case "dub_lobby_fish_sculpture_right_blue":
			toy_dubai_fish_sculpture("dub_lobby_fish_sculpture_right_blue","blue",45);
			break;

		case "dub_lobby_fish_sculpture_left_purple":
			toy_dubai_fish_sculpture("dub_lobby_fish_sculpture_left_purple","purple",39);
			break;

		case "dub_lobby_fish_sculpture_right_purple":
			toy_dubai_fish_sculpture("dub_lobby_fish_sculpture_right_purple","purple",39);
			break;

		case "vehicle_ac130_80s_sedan1_yel":
			vehicle_ac130_80s_sedan1("yel");
			break;

		case "vehicle_bus_destructible":
			vehicle_bus_destructible(param_00);
			break;

		case "vehicle_80s_sedan1_green":
			vehicle_80s_sedan1("green");
			break;

		case "vehicle_80s_sedan1_red":
			vehicle_80s_sedan1("red");
			break;

		case "vehicle_80s_sedan1_silv":
			vehicle_80s_sedan1("silv");
			break;

		case "vehicle_80s_sedan1_tan":
			vehicle_80s_sedan1("tan");
			break;

		case "vehicle_80s_sedan1_yel":
			vehicle_80s_sedan1("yel");
			break;

		case "vehicle_80s_sedan1_brn":
			vehicle_80s_sedan1("brn");
			break;

		case "vehicle_80s_hatch1_green":
			vehicle_80s_hatch1("green");
			break;

		case "vehicle_80s_hatch1_red":
			vehicle_80s_hatch1("red");
			break;

		case "vehicle_80s_hatch1_silv":
			vehicle_80s_hatch1("silv");
			break;

		case "vehicle_80s_hatch1_tan":
			vehicle_80s_hatch1("tan");
			break;

		case "vehicle_80s_hatch1_yel":
			vehicle_80s_hatch1("yel");
			break;

		case "vehicle_80s_hatch1_brn":
			vehicle_80s_hatch1("brn");
			break;

		case "vehicle_80s_hatch2_green":
			vehicle_80s_hatch2("green");
			break;

		case "vehicle_80s_hatch2_red":
			vehicle_80s_hatch2("red");
			break;

		case "vehicle_80s_hatch2_silv":
			vehicle_80s_hatch2("silv");
			break;

		case "vehicle_80s_hatch2_tan":
			vehicle_80s_hatch2("tan");
			break;

		case "vehicle_80s_hatch2_yel":
			vehicle_80s_hatch2("yel");
			break;

		case "vehicle_80s_hatch2_brn":
			vehicle_80s_hatch2("brn");
			break;

		case "vehicle_80s_wagon1_green":
			vehicle_80s_wagon1("green");
			break;

		case "vehicle_80s_wagon1_red":
			vehicle_80s_wagon1("red");
			break;

		case "vehicle_80s_wagon1_silv":
			vehicle_80s_wagon1("silv");
			break;

		case "vehicle_80s_wagon1_tan":
			vehicle_80s_wagon1("tan");
			break;

		case "vehicle_80s_wagon1_yel":
			vehicle_80s_wagon1("yel");
			break;

		case "vehicle_80s_wagon1_brn":
			vehicle_80s_wagon1("brn");
			break;

		case "vehicle_civ_car_a_1":
			vehicle_civ_car_a(1);
			break;

		case "vehicle_civ_car_a_2":
			vehicle_civ_car_a(2);
			break;

		case "vehicle_civ_car_a_3":
			vehicle_civ_car_a(3);
			break;

		case "vehicle_civ_car_a_4":
			vehicle_civ_car_a(4);
			break;

		case "vehicle_civ_car_a_5":
			vehicle_civ_car_a(5);
			break;

		case "vehicle_civ_car_a_6":
			vehicle_civ_car_a(6);
			break;

		case "vehicle_civ_car_a_7":
			vehicle_civ_car_a(7);
			break;

		case "vehicle_civ_car_a_8":
			vehicle_civ_car_a(8);
			break;

		case "vehicle_civ_car_a_9":
			vehicle_civ_car_a(9);
			break;

		case "vehicle_civ_car_a_10":
			vehicle_civ_car_a(10);
			break;

		case "vehicle_civ_car_a_11":
			vehicle_civ_car_a(11);
			break;

		case "vehicle_civ_car_a_12":
			vehicle_civ_car_a(12);
			break;

		case "vehicle_civ_car_a_13":
			vehicle_civ_car_a(13);
			break;

		case "vehicle_small_hatch_blue":
			vehicle_small_hatch("blue");
			break;

		case "vehicle_london_cab_black":
			vehicle_london_cab_black();
			break;

		case "vehicle_small_hatch_green":
			vehicle_small_hatch("green");
			break;

		case "vehicle_small_hatch_turq":
			vehicle_small_hatch("turq");
			break;

		case "vehicle_small_hatch_white":
			vehicle_small_hatch("white");
			break;

		case "vehicle_pickup":
			vehicle_pickup(param_00);
			break;

		case "vehicle_hummer":
			vehicle_hummer(param_00);
			break;

		case "vehicle_gaz":
			vehicle_t72(param_00);
			break;

		case "vehicle_gaz_harbor":
			vehicle_btr(param_00);
			break;

		case "vehicle_moving_truck_thai":
		case "vehicle_moving_truck":
			vehicle_gaz_harbor(param_00);
			break;

		case "vehicle_subway_cart":
			vehicle_bm21(param_00);
			break;

		case "vehicle_subway_cart_windows":
			vehicle_subway_cart(param_00);
			break;

		case "vehicle_subway_cart_windows_small":
			create_vehicle_subway_cart_window_single(param_00);
			break;

		case "vehicle_bm21_mobile_bed":
			vehicle_gaz(param_00,"vehicle_bm21_mobile_bed_dstry");
			break;

		case "vehicle_bm21_cover":
			vehicle_gaz(param_00,"vehicle_bm21_mobile_cover_dstry");
			break;

		case "vehicle_luxurysedan_2008":
			vehicle_subway_cart_windows("");
			break;

		case "vehicle_luxurysedan_2008_gray":
			vehicle_subway_cart_windows("_gray");
			break;

		case "vehicle_luxurysedan_2008_white":
			vehicle_subway_cart_windows("_white");
			break;

		case "vehicle_uk_truck":
			vehicle_coupe(param_00);
			break;

		case "vehicle_uk_police_estate":
			vehicle_mini(param_00);
			break;

		case "vehicle_uaz_winter":
			vehicle_uk_truck(param_00);
			break;

		case "vehicle_uaz_fabric":
			vehicle_uk_police_estate(param_00);
			break;

		case "vehicle_uaz_hardtop":
			vehicle_uaz_winter(param_00);
			break;

		case "vehicle_uaz_open":
			vehicle_jeep(param_00);
			break;

		case "vehicle_india_suv_w":
			vehicle_india_rickshaw("w");
			break;

		case "vehicle_india_suv_b":
			vehicle_india_rickshaw("b");
			break;

		case "vehicle_india_compact_destructible_gray":
			vehicle_jeep_dusty("gray");
			break;

		case "vehicle_india_compact_destructible_red":
			vehicle_jeep_dusty("red");
			break;

		case "vehicle_india_compact_destructible_brown":
			vehicle_jeep_dusty("brown");
			break;

		case "vehicle_india_compact_destructible_blue":
			vehicle_jeep_dusty("blue");
			break;

		case "vehicle_tuk_tuk":
			vehicle_india_compact_destructible(param_00);
			break;

		case "vehicle_india_rickshaw":
			vehicle_uaz_open(param_00);
			break;

		case "vehicle_policecar":
			vehicle_tuk_tuk(param_00);
			break;

		case "vehicle_policecar_russia":
			vehicle_india_suv(param_00);
			break;

		case "vehicle_taxi":
			vehicle_policecar(param_00);
			break;

		case "vehicle_taxi_dubai":
			vehicle_policecar_russia(param_00);
			break;

		case "vehicle_mig29_landed":
			vehicle_subway_cart_windows_small(param_00);
			break;

		case "vehicle_mack_truck_short_snow":
			vehicle_luxurysedan("snow");
			break;

		case "vehicle_mack_truck_short_green":
			vehicle_luxurysedan("green");
			break;

		case "vehicle_mack_truck_short_white":
			vehicle_luxurysedan("white");
			break;

		case "vehicle_motorcycle_01":
			vehicle_mack_truck_short("01");
			break;

		case "vehicle_motorcycle_02":
			vehicle_mack_truck_short("02");
			break;

		case "vehicle_scooter_vespa":
			vehicle_semi_truck("vehicle_scooter_vespa");
			break;

		case "vehicle_subcompact_black":
			vehicle_motorcycle("black");
			break;

		case "vehicle_subcompact_blue":
			vehicle_motorcycle("blue");
			break;

		case "vehicle_subcompact_dark_gray":
			vehicle_motorcycle("dark_gray");
			break;

		case "vehicle_subcompact_deep_blue":
			vehicle_motorcycle("deep_blue");
			break;

		case "vehicle_subcompact_gold":
			vehicle_motorcycle("gold");
			break;

		case "vehicle_subcompact_gray":
			vehicle_motorcycle("gray");
			break;

		case "vehicle_subcompact_green":
			vehicle_motorcycle("green");
			break;

		case "vehicle_subcompact_mica":
			vehicle_motorcycle("mica");
			break;

		case "vehicle_subcompact_slate":
			vehicle_motorcycle("slate");
			break;

		case "vehicle_subcompact_tan":
			vehicle_motorcycle("tan");
			break;

		case "vehicle_subcompact_white":
			vehicle_motorcycle("white");
			break;

		case "vehicle_coupe_black":
			get_precached_anim("black");
			break;

		case "vehicle_coupe_blue":
			get_precached_anim("blue");
			break;

		case "vehicle_coupe_dark_gray":
			get_precached_anim("dark_gray");
			break;

		case "vehicle_coupe_deep_blue":
			get_precached_anim("deep_blue");
			break;

		case "vehicle_coupe_gold":
			get_precached_anim("gold");
			break;

		case "vehicle_coupe_gray":
			get_precached_anim("gray");
			break;

		case "vehicle_coupe_green":
			get_precached_anim("green");
			break;

		case "vehicle_coupe_mica":
			get_precached_anim("mica");
			break;

		case "vehicle_coupe_slate":
			get_precached_anim("slate");
			break;

		case "vehicle_coupe_tan":
			get_precached_anim("tan");
			break;

		case "vehicle_coupe_white":
			get_precached_anim("white");
			break;

		case "vehicle_van_black":
			vehicle_scooter("black");
			break;

		case "vehicle_van_blue":
			vehicle_scooter("blue");
			break;

		case "vehicle_van_dark_gray":
			vehicle_scooter("dark_gray");
			break;

		case "vehicle_van_deep_blue":
			vehicle_scooter("deep_blue");
			break;

		case "vehicle_van_gold":
			vehicle_scooter("gold");
			break;

		case "vehicle_van_gray":
			vehicle_scooter("gray");
			break;

		case "vehicle_van_green":
			vehicle_scooter("green");
			break;

		case "vehicle_van_mica":
			vehicle_scooter("mica");
			break;

		case "vehicle_van_slate":
			vehicle_scooter("slate");
			break;

		case "vehicle_van_tan":
			vehicle_scooter("tan");
			break;

		case "vehicle_van_white":
			vehicle_scooter("white");
			break;

		case "vehicle_suburban":
			vehicle_van_iw5(param_00,"");
			break;

		case "vehicle_suburban_beige":
			vehicle_van_iw5(param_00,"_beige");
			break;

		case "vehicle_suburban_dull":
			vehicle_van_iw5(param_00,"_dull");
			break;

		case "vehicle_suburban_red":
			vehicle_van_iw5(param_00,"_red");
			break;

		case "vehicle_snowmobile":
			vehicle_delivery_theme_park_truck_destructible(param_00);
			break;

		case "destructible_gaspump":
			vehicle_suburban(param_00);
			break;

		case "destructible_electrical_transformer_large":
			vehicle_snowmobile(param_00);
			break;

		case "toy_new_dlc_destructible":
			toy_glass("120x110");
			break;

		case "toy_security_camera":
			vehicle_taxi(param_00);
			break;

		case "toy_building_collapse_paris_ac130":
			vehicle_taxi_dubai(param_00);
			break;

		case "toy_poison_gas_attack":
			toy_security_camera(param_00);
			break;

		case "toy_arcade_machine_1":
			toy_building_collapse_paris_ac130("_1");
			break;

		case "toy_arcade_machine_2":
			toy_building_collapse_paris_ac130("_2");
			break;

		case "toy_pinball_machine_1":
			toy_poison_gas_attack("_1");
			break;

		case "toy_pinball_machine_2":
			toy_poison_gas_attack("_2");
			break;

		case "toy_fortune_machine":
			toy_arcade_machine(param_00);
			break;

		case "toy_trashcan_clown":
			toy_pinball_machine(param_00);
			break;

		case "toy_afrShanty1":
			toy_fortune_machine(param_00);
			break;

		case "vehicle_slava_ny_harbor_zonea":
			toy_trashcan_clown(param_00);
			break;

		case "rooftop_skylight_destructible":
			toy_afrshanty1(param_00);
			break;

		case "satellite_dish_big_destructible":
			vehicle_slava_ny_harbor_zonea(param_00);
			break;

		case "berlin_hotel_lights_ceiling1":
			dest_onestate(param_00,"berlin_hotel_lights_ceiling1_destroyed");
			break;

		case "berlin_hotel_lights_ceiling1_off":
			dest_onestate(param_00,"berlin_hotel_lights_ceiling1_destroyed");
			break;

		case "berlin_hotel_lights_wall1":
			rooftop_skylight_destructible(param_00,"berlin_hotel_lights_wall1_destroyed","misc/light_blowout_wall2_runner");
			break;

		case "berlin_hotel_lights_wall1_off":
			rooftop_skylight_destructible(param_00,"berlin_hotel_lights_wall1_destroyed","misc/light_blowout_wall2_runner");
			break;

		case "berlin_hotel_lights_wall2":
			rooftop_skylight_destructible(param_00,"berlin_hotel_lights_wall2_destroyed","misc/light_blowout_wall_runner");
			break;

		case "berlin_hotel_lights_wall2_off":
			rooftop_skylight_destructible(param_00,"berlin_hotel_lights_wall2_destroyed","misc/light_blowout_wall_runner");
			break;

		case "pb_cubical_planter":
			satellite_dish_big_destructible(param_00,"pb_cubical_planter_dam","explosions/brick_chunk");
			break;

		case "vehicle_delivery_theme_park_truck_destructible":
			vehicle_uaz_van(param_00);
			break;

		case "vehicle_van_sas_dark_destructable":
			vehicle_van("vehicle_van_sas_dark");
			break;

		case "vehicle_uk_police_van_destructable":
			vehicle_van("vehicle_uk_police_van");
			break;

		case "vehicle_jeep_dusty":
			vehicle_uaz_hardtop(param_00);
			break;

		default:
			break;
	}

	var_01 = getinfoindex(param_00);
	return var_01;
}

//Function Number: 2
getinfoindex(param_00)
{
	if(!isdefined(level.destructible_type))
	{
		return -1;
	}

	if(level.destructible_type.size == 0)
	{
		return -1;
	}

	for(var_01 = 0;var_01 < level.destructible_type.size;var_01++)
	{
		if(param_00 == level.destructible_type[var_01].v["type"])
		{
			return var_01;
		}
	}

	return -1;
}

//Function Number: 3
prop_ac_prs_enm_barge_a_1()
{
	common_scripts\_destructible::destructible_create("prop_ac_prs_enm_barge_a_1","tag_origin",250,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_state("tag_origin","ac_prs_enm_barge_a_1_dam_animated",250,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_anim(destructible_gaspump("paris_ac130_barge_sink"),destructible_electrical_transformer_large("paris_ac130_barge_sink"),"setanim");
	common_scripts\_destructible::destructible_fx(undefined,"impacts/105mm_water_impact_fast",0);
	common_scripts\_destructible::destructible_explode(4000,5000,150,250,50,300,undefined,undefined,0.3,500);
}

//Function Number: 4
prop_ac_prs_enm_barge_a_2()
{
	common_scripts\_destructible::destructible_create("prop_ac_prs_enm_barge_a_2","tag_origin",250,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_state("tag_origin","ac_prs_enm_barge_a_2_dam_animated",250,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_anim(destructible_gaspump("paris_ac130_barge_sink"),destructible_electrical_transformer_large("paris_ac130_barge_sink"),"setanim");
	common_scripts\_destructible::destructible_fx(undefined,"impacts/105mm_water_impact_fast",0);
	common_scripts\_destructible::destructible_explode(4000,5000,150,250,50,300,undefined,undefined,0.3,500);
}

//Function Number: 5
prop_ac_prs_enm_con_digger_a()
{
	common_scripts\_destructible::destructible_create("prop_ac_prs_enm_con_digger_a","ac_prs_enm_con_digger_a_lod_0",250,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_state("ac_prs_enm_con_digger_a_dam_lod0","ac_prs_enm_con_digger_a_dam",250,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_fx(undefined,"explosions/building_explosion_paris_ac130",0);
	common_scripts\_destructible::destructible_explode(4000,5000,150,250,50,300,undefined,undefined,0.3,500);
}

//Function Number: 6
prop_ac_prs_enm_con_dump_truck_a()
{
	common_scripts\_destructible::destructible_create("prop_ac_prs_enm_con_dump_truck_a","ac_prs_enm_con_dump_truck_a_lod0",250,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_state("ac_prs_enm_con_dump_truck_a_destroyed_lod0","ac_prs_enm_con_dump_truck_a_dam",250,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_fx(undefined,"explosions/building_explosion_paris_ac130",0);
	common_scripts\_destructible::destructible_explode(4000,5000,150,250,50,300,undefined,undefined,0.3,500);
}

//Function Number: 7
prop_ac_prs_enm_fuel_tank_a()
{
	common_scripts\_destructible::destructible_create("prop_ac_prs_enm_fuel_tank_a","ac_prs_enm_fuel_tank_a_lod0",250,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_state("ac_prs_enm_fuel_tank_a_dam_lod0","ac_prs_enm_fuel_tank_a_dam",250,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_fx(undefined,"explosions/fuel_storage",0);
	common_scripts\_destructible::destructible_explode(4000,5000,150,250,50,300,undefined,undefined,0.3,500);
}

//Function Number: 8
prop_ac_prs_enm_hanger_a()
{
	common_scripts\_destructible::destructible_create("prop_ac_prs_enm_hanger_a","ac_prs_enm_hanger_a_lod0",250,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_state("ac_prs_enm_hanger_a_dam_lod0","ac_prs_enm_hanger_a_dam",250,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_fx(undefined,"explosions/building_explosion_paris_ac130",0);
}

//Function Number: 9
prop_ac_prs_enm_maz_a()
{
	common_scripts\_destructible::destructible_create("prop_ac_prs_enm_maz_a","ac_prs_enm_maz_a",250,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_state("ac_prs_enm_maz_a_dam3","ac_prs_enm_maz_a_dam",250,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_fx(undefined,"explosions/building_explosion_paris_ac130",0);
	common_scripts\_destructible::destructible_fx(undefined,"explosions/ac_prs_fx_flir_debris_explosion_a",0);
	common_scripts\_destructible::destructible_explode(4000,5000,150,250,50,300,undefined,undefined,0.3,500);
}

//Function Number: 10
prop_ac_prs_enm_mi26_halo_a()
{
	common_scripts\_destructible::destructible_create("prop_ac_prs_enm_mi26_halo_a","ac_prs_enm_mi26_halo_a_lod0",250,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_state("polySurface80","ac_prs_enm_mi26_halo_a_dam",250,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_fx(undefined,"explosions/helicopter_explosion_mi26_halo",0);
	common_scripts\_destructible::destructible_explode(4000,5000,150,250,50,300,undefined,undefined,0.3,500);
}

//Function Number: 11
prop_ac_prs_enm_mstas_a()
{
	common_scripts\_destructible::destructible_create("prop_ac_prs_enm_mstas_a","ac_prs_enm_mstas_a_lod0",250,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_state("ac_prs_enm_mstas_a_dam_lod0","ac_prs_enm_mstas_a_dam",250,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_fx(undefined,"explosions/ac_prs_fx_flir_debris_explosion_a",0);
	common_scripts\_destructible::destructible_fx(undefined,"explosions/ac_prs_fx_debris_explosion_fire_a",0);
	common_scripts\_destructible::destructible_explode(4000,5000,150,250,50,300,undefined,undefined,0.3,500);
}

//Function Number: 12
prop_ac_prs_enm_radar_maz_a()
{
	common_scripts\_destructible::destructible_create("prop_ac_prs_enm_radar_maz_a","tag_origin",250,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_state("tag_origin","ac_prs_enm_radar_maz_a",250,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_anim(destructible_gaspump("ac130_radartower_crash"),destructible_electrical_transformer_large("ac130_radartower_crash"),"setanim");
	common_scripts\_destructible::destructible_fx(undefined,"explosions/building_explosion_paris_ac130",0);
	common_scripts\_destructible::destructible_explode(4000,5000,150,250,50,300,undefined,undefined,0.3,500);
}

//Function Number: 13
prop_ac_prs_enm_s300v_a()
{
	common_scripts\_destructible::destructible_create("prop_ac_prs_enm_s300v_a","ac_prs_enm_s300v",250,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_state("ac_prs_enm_s300v_dam","ac_prs_enm_s300v_dam",250,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_fx(undefined,"explosions/vehicle_explosion_sam",0);
	common_scripts\_destructible::destructible_explode(4000,5000,150,250,50,300,undefined,undefined,0.3,500);
}

//Function Number: 14
prop_ac_prs_enm_storage_bld_a_1()
{
	common_scripts\_destructible::destructible_create("prop_ac_prs_enm_storage_bld_a_1","p_ac_prs_enm_storage_bld_a_1",250,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_state("p_ac_prs_enm_storage_bld_a_1_dam","ac_prs_enm_storage_bld_a_1_dam",250,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_fx(undefined,"explosions/building_explosion_paris_ac130",0);
	common_scripts\_destructible::destructible_fx(undefined,"explosions/ac_prs_fx_flir_debris_explosion_a",0);
}

//Function Number: 15
prop_ac_prs_enm_storage_bld_a_2()
{
	common_scripts\_destructible::destructible_create("prop_ac_prs_enm_storage_bld_a_2","p_ac_prs_enm_storage_bld_a_2",250,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_state("p_ac_prs_enm_storage_bld_a_2_dam","ac_prs_enm_storage_bld_a_2_dam",250,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_fx(undefined,"explosions/building_explosion_paris_ac130",0);
	common_scripts\_destructible::destructible_fx(undefined,"explosions/ac_prs_fx_flir_debris_explosion_a",0);
}

//Function Number: 16
prop_ac_prs_enm_storage_bld_b()
{
	common_scripts\_destructible::destructible_create("prop_ac_prs_enm_storage_bld_b","p_ac_prs_enm_storage_bld_b",250,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_state("p_ac_prs_enm_storage_bld_b_dam","ac_prs_enm_storage_bld_b_dam",250,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_fx(undefined,"explosions/building_explosion_paris_ac130",0);
	common_scripts\_destructible::destructible_fx(undefined,"explosions/ac_prs_fx_flir_debris_explosion_max_a",0);
}

//Function Number: 17
prop_ac_prs_enm_tent_a()
{
	common_scripts\_destructible::destructible_create("prop_ac_prs_enm_tent_a","ac_prs_enm_tent_a_lod0",250,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_state("polySurface1","ac_prs_enm_tent_a_dam1",250,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_fx(undefined,"explosions/tent_collapse",0);
}

//Function Number: 18
prop_ac_prs_enm_tent_b()
{
	common_scripts\_destructible::destructible_create("prop_ac_prs_enm_tent_b","ac_prs_enm_tent_b_lod0",250,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_state("ac_prs_enm_tent_b_lod1","ac_prs_enm_tent_b_dam1",250,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_fx(undefined,"explosions/tent_collapse",0);
}

//Function Number: 19
prop_ac_prs_enm_tent_c()
{
	common_scripts\_destructible::destructible_create("prop_ac_prs_enm_tent_c","ac_prs_enm_tent_c_lod0",250,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_state("ac_prs_enm_tent_c_lod1","ac_prs_enm_tent_c_dam1",250,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_fx(undefined,"explosions/tent_collapse",0);
}

//Function Number: 20
prop_ac_prs_enm_truck_a()
{
	common_scripts\_destructible::destructible_create("prop_ac_prs_enm_truck_a","ac_prs_enm_truck_a_lod0",250,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_state("ac_prs_enm_truck_a_dam_lod0","ac_prs_enm_truck_a_dam",250,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_fx(undefined,"explosions/building_explosion_paris_ac130",0);
	common_scripts\_destructible::destructible_fx(undefined,"explosions/ac_prs_fx_flir_debris_explosion_a",0);
	common_scripts\_destructible::destructible_explode(4000,5000,150,250,50,300,undefined,undefined,0.3,500);
}

//Function Number: 21
prop_ac_prs_enm_cargo_crate_a_1()
{
	common_scripts\_destructible::destructible_create("prop_ac_prs_enm_cargo_crate_a_1","ac_prs_enm_cargo_crate_a_1_lod0",250,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_state("ac_prs_enm_cargo_crate_a_1_lod0","ac_prs_enm_cargo_crate_a_1_dam",250,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_fx(undefined,"explosions/building_explosion_paris_ac130",0);
	common_scripts\_destructible::destructible_explode(4000,5000,150,250,50,300,undefined,undefined,0.3,500);
}

//Function Number: 22
prop_ac_prs_enm_cargo_crate_a_2()
{
	common_scripts\_destructible::destructible_create("prop_ac_prs_enm_cargo_crate_a_2","ac_prs_enm_cargo_crate_a_2_lod0",250,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_state("ac_prs_enm_cargo_crate_a_2_lod0","ac_prs_enm_cargo_crate_a_2_dam",250,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_fx(undefined,"explosions/building_explosion_paris_ac130",0);
	common_scripts\_destructible::destructible_explode(4000,5000,150,250,50,300,undefined,undefined,0.3,500);
}

//Function Number: 23
prop_ac_prs_enm_crates_a_1()
{
	common_scripts\_destructible::destructible_create("prop_ac_prs_enm_crates_a_1","ac_prs_enm_crates_a_1_lod0",250,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_state("ac_prs_enm_crates_a_1_dam_lod0","ac_prs_enm_crates_a_1_dam",250,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_fx(undefined,"explosions/ac_prs_fx_enm_crates_a_explosion_1",0);
}

//Function Number: 24
prop_ac_prs_enm_crates_a_2()
{
	common_scripts\_destructible::destructible_create("prop_ac_prs_enm_crates_a_2","ac_prs_enm_crates_a_2_lod0",250,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_state("ac_prs_enm_crates_a_2_dam_lod0","ac_prs_enm_crates_a_2_dam",250,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_fx(undefined,"explosions/ac_prs_fx_enm_crates_a_explosion_1",0);
}

//Function Number: 25
prop_ac_prs_enm_crates_b_1()
{
	common_scripts\_destructible::destructible_create("prop_ac_prs_enm_crates_b_1","ac_prs_enm_crates_b_1_lod0",250,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_state("ac_prs_enm_crates_b_1_dam_lod0","ac_prs_enm_crates_b_1_dam",250,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_fx(undefined,"explosions/ac_prs_fx_enm_crates_b_explosion_1",0);
}

//Function Number: 26
prop_ac_prs_enm_crates_b_2()
{
	common_scripts\_destructible::destructible_create("prop_ac_prs_enm_crates_b_2","ac_prs_enm_crates_b_2_lod0",250,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_state("ac_prs_enm_crates_b_2_dam_lod0","ac_prs_enm_crates_b_2_dam",250,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_fx(undefined,"explosions/ac_prs_fx_enm_crates_b_explosion_1",0);
}

//Function Number: 27
prop_ac_prs_enm_mobile_crane_a()
{
	common_scripts\_destructible::destructible_create("prop_ac_prs_enm_mobile_crane_a","ac_prs_enm_mobile_crane_a_lod0",250,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_state("ac_prs_enm_mobile_crane_a_dam_lod0","ac_prs_enm_mobile_crane_a_dam",250,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_fx(undefined,"explosions/building_explosion_paris_ac130",0);
	common_scripts\_destructible::destructible_explode(4000,5000,150,250,50,300,undefined,undefined,0.3,500);
}

//Function Number: 28
prop_ac_prs_enm_landing_craft_a()
{
	common_scripts\_destructible::destructible_create("prop_ac_prs_enm_landing_craft_a","ac_prs_enm_landing_craft_a_lod0",250,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_state("tag_origin","ac_prs_enm_landing_craft_a_dam",250,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_fx(undefined,"explosions/building_explosion_paris_ac130",0);
	common_scripts\_destructible::destructible_explode(4000,5000,150,250,50,300,undefined,undefined,0.3,500);
}

//Function Number: 29
prop_ac_prs_enm_speed_boat_a()
{
	common_scripts\_destructible::destructible_create("prop_ac_prs_enm_speed_boat_a","ac_prs_enm_speed_boat_a",250,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_state("ac_prs_prp_metal_debris_a_01_lod0","ac_prs_prp_metal_debris_a_01",250,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_fx(undefined,"explosions/building_explosion_paris_ac130",0);
	common_scripts\_destructible::destructible_explode(4000,5000,150,250,50,300,undefined,undefined,0.3,500);
}

//Function Number: 30
prop_ac_prs_prp_satellite_dish_a_dish()
{
	common_scripts\_destructible::destructible_create("prop_ac_prs_prp_satellite_dish_a_dish","ac_prs_prp_satellite_dish_a_dish_lod0",250,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_state("ac_prs_prp_metal_debris_a_01_lod0","ac_prs_prp_metal_debris_a_01",250,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_fx(undefined,"explosions/ac_prs_fx_dust_explosion_a",0);
	common_scripts\_destructible::destructible_explode(4000,5000,150,250,50,300,undefined,undefined,0.3,500);
}

//Function Number: 31
prop_ac_prs_fps_hc_extc_balcony_a1()
{
	common_scripts\_destructible::destructible_create("prop_ac_prs_fps_hc_extc_balcony_a1","ac_prs_fps_hc_extc_balcony_a_lod0",80,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_state("ac_prs_fps_hc_extc_balcony_a_dam1_lod0","ac_prs_fps_hc_extc_balcony_a_dam1",250,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_fx(undefined,"explosions/ac_prs_fx_dust_explosion_a",0);
	common_scripts\_destructible::destructible_fx(undefined,"explosions/ac_prs_fps_extc_balcony_a_explosion_1",0);
}

//Function Number: 32
prop_ac_prs_fps_hc_extc_balcony_a2()
{
	common_scripts\_destructible::destructible_create("prop_ac_prs_fps_hc_extc_balcony_a2","ac_prs_fps_hc_extc_balcony_a_lod0",80,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_state("ac_prs_fps_hc_extc_balcony_a_dam2_lod0","ac_prs_fps_hc_extc_balcony_a_dam2",250,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_fx(undefined,"explosions/ac_prs_fx_dust_explosion_a",0);
	common_scripts\_destructible::destructible_fx(undefined,"explosions/ac_prs_fps_extc_balcony_a_explosion_1",0);
}

//Function Number: 33
prop_ac_prs_fps_hc_extc_balcony_a3()
{
	common_scripts\_destructible::destructible_create("prop_ac_prs_fps_hc_extc_balcony_a3","ac_prs_fps_hc_extc_balcony_a_lod0",80,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_state("ac_prs_fps_hc_extc_balcony_a_dam3_lod0","ac_prs_fps_hc_extc_balcony_a_dam3",250,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_fx(undefined,"explosions/ac_prs_fx_dust_explosion_a",0);
	common_scripts\_destructible::destructible_fx(undefined,"explosions/ac_prs_fps_extc_balcony_a_explosion_1",0);
}

//Function Number: 34
prop_ac_prs_fps_hc_extc_balcony_b1()
{
	common_scripts\_destructible::destructible_create("prop_ac_prs_fps_hc_extc_balcony_b1","ac_prs_fps_hc_extc_balcony_b_lod0",80,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_state("ac_prs_fps_hc_extc_balcony_b_dam1_lod0","ac_prs_fps_hc_extc_balcony_b_dam1",250,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_fx(undefined,"explosions/ac_prs_fx_dust_explosion_a",0);
	common_scripts\_destructible::destructible_fx(undefined,"explosions/ac_prs_fps_extc_balcony_b_explosion_1",0);
}

//Function Number: 35
prop_ac_prs_fps_hc_extc_balcony_b2()
{
	common_scripts\_destructible::destructible_create("prop_ac_prs_fps_hc_extc_balcony_b2","ac_prs_fps_hc_extc_balcony_b_lod0",80,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_state("ac_prs_fps_hc_extc_balcony_b_dam2_lod0","ac_prs_fps_hc_extc_balcony_b_dam2",250,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_fx(undefined,"explosions/ac_prs_fx_dust_explosion_a",0);
	common_scripts\_destructible::destructible_fx(undefined,"explosions/ac_prs_fps_extc_balcony_b_explosion_1",0);
}

//Function Number: 36
prop_ac_prs_fps_hc_extc_balcony_b3()
{
	common_scripts\_destructible::destructible_create("prop_ac_prs_fps_hc_extc_balcony_b3","ac_prs_fps_hc_extc_balcony_b_lod0",80,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_state("ac_prs_fps_hc_extc_balcony_b_dam3_lod0","ac_prs_fps_hc_extc_balcony_b_dam3",250,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_fx(undefined,"explosions/ac_prs_fx_dust_explosion_a",0);
	common_scripts\_destructible::destructible_fx(undefined,"explosions/ac_prs_fps_extc_balcony_b_explosion_1",0);
}

//Function Number: 37
prop_ac_prs_fps_hc_extc_balcony_c1()
{
	common_scripts\_destructible::destructible_create("prop_ac_prs_fps_hc_extc_balcony_c1","ac_prs_fps_hc_extc_balcony_c_lod0",80,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_state("ac_prs_fps_hc_extc_balcony_c_dam1_lod0","ac_prs_fps_hc_extc_balcony_c_dam1",250,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_fx(undefined,"explosions/ac_prs_fx_dust_explosion_a",0);
	common_scripts\_destructible::destructible_fx(undefined,"explosions/ac_prs_fps_extc_balcony_c_explosion_1",0);
}

//Function Number: 38
prop_ac_prs_fps_hc_extc_balcony_c2()
{
	common_scripts\_destructible::destructible_create("prop_ac_prs_fps_hc_extc_balcony_c2","ac_prs_fps_hc_extc_balcony_c_lod0",80,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_state("ac_prs_fps_hc_extc_balcony_c_dam2_lod0","ac_prs_fps_hc_extc_balcony_c_dam2",250,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_fx(undefined,"explosions/ac_prs_fx_dust_explosion_a",0);
	common_scripts\_destructible::destructible_fx(undefined,"explosions/ac_prs_fps_extc_balcony_c_explosion_2",0);
}

//Function Number: 39
prop_ac_prs_fps_hc_extc_column_b_a1()
{
	common_scripts\_destructible::destructible_create("prop_ac_prs_fps_hc_extc_column_b_a1","ac_prs_fps_hc_extc_column_b_a_lod0",80,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_state("ac_prs_fps_hc_extc_column_b_a_dam1_lod0","ac_prs_fps_hc_extc_column_b_a_dam1",250,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_fx(undefined,"explosions/ac_prs_fx_dust_explosion_a",0);
	common_scripts\_destructible::destructible_fx(undefined,"explosions/ac_prs_fps_extc_balcony_c_explosion_2",0);
}

//Function Number: 40
prop_ac_prs_fps_hc_extc_column_b_a2()
{
	common_scripts\_destructible::destructible_create("prop_ac_prs_fps_hc_extc_column_b_a2","ac_prs_fps_hc_extc_column_b_a_lod0",80,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_state("ac_prs_fps_hc_extc_column_b_a_dam2_lod0","ac_prs_fps_hc_extc_column_b_a_dam2",250,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_fx(undefined,"explosions/ac_prs_fx_dust_explosion_a",0);
	common_scripts\_destructible::destructible_fx(undefined,"explosions/ac_prs_fps_extc_balcony_c_explosion_2",0);
}

//Function Number: 41
prop_ac_prs_fps_hc_extc_column_b_a3()
{
	common_scripts\_destructible::destructible_create("prop_ac_prs_fps_hc_extc_column_b_a3","ac_prs_fps_hc_extc_column_b_a_lod0",80,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_state("ac_prs_fps_hc_extc_column_b_a_dam3_lod0","ac_prs_fps_hc_extc_column_b_a_dam3",250,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_fx(undefined,"explosions/ac_prs_fx_dust_explosion_a",0);
	common_scripts\_destructible::destructible_fx(undefined,"explosions/ac_prs_fps_extc_balcony_c_explosion_2",0);
}

//Function Number: 42
prop_ac_prs_fps_hc_extc_column_t_a1()
{
	common_scripts\_destructible::destructible_create("prop_ac_prs_fps_hc_extc_column_t_a1","ac_prs_fps_hc_extc_column_t_a_lod0",80,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_state("ac_prs_fps_hc_extc_column_t_a_dam1_lod0","ac_prs_fps_hc_extc_column_t_a_dam1",250,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_fx(undefined,"explosions/ac_prs_fx_dust_explosion_a",0);
	common_scripts\_destructible::destructible_fx(undefined,"explosions/ac_prs_fps_extc_balcony_c_explosion_2",0);
}

//Function Number: 43
prop_ac_prs_fps_hc_extc_column_t_a2()
{
	common_scripts\_destructible::destructible_create("prop_ac_prs_fps_hc_extc_column_t_a2","ac_prs_fps_hc_extc_column_t_a_lod0",80,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_state("ac_prs_fps_hc_extc_column_t_a_dam2_lod0","ac_prs_fps_hc_extc_column_t_a_dam2",250,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_fx(undefined,"explosions/ac_prs_fx_dust_explosion_a",0);
	common_scripts\_destructible::destructible_fx(undefined,"explosions/ac_prs_fps_extc_balcony_c_explosion_2",0);
}

//Function Number: 44
prop_ac_prs_fps_hc_extc_column_t_a3()
{
	common_scripts\_destructible::destructible_create("prop_ac_prs_fps_hc_extc_column_t_a3","ac_prs_fps_hc_extc_column_t_a_lod0",80,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_state("ac_prs_fps_hc_extc_column_t_a_dam3_lod0","ac_prs_fps_hc_extc_column_t_a_dam3",250,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_fx(undefined,"explosions/ac_prs_fx_dust_explosion_a",0);
	common_scripts\_destructible::destructible_fx(undefined,"explosions/ac_prs_fps_extc_balcony_c_explosion_2",0);
}

//Function Number: 45
prop_ac_prs_enm_missile_boat_a()
{
	common_scripts\_destructible::destructible_create("prop_ac_prs_enm_missile_boat_a","tag_origin",250,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_state("tag_origin","ac_prs_enm_missile_boat_a",250,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_anim(destructible_gaspump("paris_ac130_ship_sink"),destructible_electrical_transformer_large("paris_ac130_ship_sink"),"setanim");
	common_scripts\_destructible::destructible_fx(undefined,"impacts/105mm_water_impact_fast",0);
	common_scripts\_destructible::destructible_explode(4000,5000,150,250,50,300,undefined,undefined,0.3,500);
}

//Function Number: 46
toy_glass(param_00)
{
	common_scripts\_destructible::destructible_create("toy_glass" + param_00,"tag_origin",50);
	common_scripts\_destructible::destructible_splash_damage_scaler(5);
	common_scripts\_destructible::destructible_sound("building_glass_shatter");
	var_01 = "tag_glass";
	common_scripts\_destructible::destructible_part(var_01,undefined,40,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01 + "_d",undefined,200,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx(var_01,"props/highrise_glass_" + param_00);
	common_scripts\_destructible::destructible_sound("building_glass_blowout");
	common_scripts\_destructible::destructible_state(var_01 + "_des",undefined,100,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx(var_01,"props/highrise_glass_" + param_00 + "_edge");
	common_scripts\_destructible::destructible_sound("building_glass_blowout");
	common_scripts\_destructible::destructible_state(undefined);
}

//Function Number: 47
toy_dt_mirror(param_00)
{
	common_scripts\_destructible::destructible_create("toy_dt_mirror" + param_00,"tag_origin",150,undefined,32);
	common_scripts\_destructible::destructible_splash_damage_scaler(5);
	common_scripts\_destructible::destructible_fx("tag_fx","props/mirror_shatter" + param_00);
	common_scripts\_destructible::destructible_sound("mirror_shatter");
	common_scripts\_destructible::destructible_state("tag_origin","dt_mirror" + param_00 + "_dam",150,undefined);
	common_scripts\_destructible::destructible_fx("tag_fx","props/mirror_dt_panel" + param_00 + "_broken");
	common_scripts\_destructible::destructible_explode(1000,2000,32,32,32,48,undefined,0);
	common_scripts\_destructible::destructible_state("tag_origin","dt_mirror" + param_00 + "_des",150,undefined);
}

//Function Number: 48
toy_icbm_consolemonitor(param_00)
{
	common_scripts\_destructible::destructible_create("toy_icbm_consolemonitor" + param_00,"television2_lod04",1,undefined,32);
	common_scripts\_destructible::destructible_splash_damage_scaler(1);
	common_scripts\_destructible::destructible_fx("television2_lod04","explosions/tv_explosion");
	common_scripts\_destructible::destructible_sound("tv_shot_burst","television2_lod04");
	common_scripts\_destructible::destructible_explode(20,2000,9,9,3,3,undefined,12);
	common_scripts\_destructible::destructible_state("television2_lod04","hjk_icbm_consolemonitor7",undefined,undefined,"no_melee");
}

//Function Number: 49
toy_tubetv_(param_00)
{
	common_scripts\_destructible::destructible_create("toy_tubetv_" + param_00,"tag_origin",1,undefined,32);
	common_scripts\_destructible::destructible_splash_damage_scaler(1);
	common_scripts\_destructible::destructible_fx("tag_fx","explosions/tv_explosion");
	common_scripts\_destructible::destructible_sound("tv_shot_burst");
	common_scripts\_destructible::destructible_explode(20,2000,9,9,3,3,undefined,12);
	common_scripts\_destructible::destructible_state(undefined,"com_" + param_00 + "_d",undefined,undefined,"no_melee");
}

//Function Number: 50
toy_tvs_flatscreen(param_00,param_01)
{
	common_scripts\_destructible::destructible_create("toy_tv_flatscreen_" + param_01 + param_00,"tag_origin",1,undefined,32);
	common_scripts\_destructible::destructible_splash_damage_scaler(1);
	common_scripts\_destructible::destructible_fx("tag_fx","explosions/tv_flatscreen_explosion");
	common_scripts\_destructible::destructible_sound("tv_shot_burst");
	common_scripts\_destructible::destructible_explode(20,2000,10,10,3,3,undefined,15);
	common_scripts\_destructible::destructible_state(undefined,"ma_flatscreen_tv_" + param_01 + "broken_" + param_00,200,undefined,"no_melee");
}

//Function Number: 51
toy_tvs_flatscreen_sturdy(param_00,param_01)
{
	common_scripts\_destructible::destructible_create("toy_tv_flatscreen_" + param_01 + param_00 + "_sturdy","tag_origin",1,undefined,1280);
	common_scripts\_destructible::destructible_splash_damage_scaler(0.5);
	common_scripts\_destructible::destructible_fx("tag_fx","explosions/tv_flatscreen_explosion_cheap");
	common_scripts\_destructible::destructible_sound("tv_shot_burst");
	common_scripts\_destructible::destructible_explode(20,2000,10,10,3,3,undefined,15);
	common_scripts\_destructible::destructible_state(undefined,"ma_flatscreen_tv_" + param_01 + "broken_" + param_00,200,undefined,"no_melee");
}

//Function Number: 52
toy_transformer_ratnest01(param_00)
{
	common_scripts\_destructible::destructible_create(param_00,"tag_origin",75,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_splash_damage_scaler(15);
	common_scripts\_destructible::destructible_loopfx("tag_fx","smoke/car_damage_whitesmoke",0.4);
	common_scripts\_destructible::destructible_state(undefined,undefined,75,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_fx","smoke/car_damage_blacksmoke",0.4);
	common_scripts\_destructible::destructible_state(undefined,undefined,150,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_sparks","explosions/transformer_spark_runner",0.5);
	common_scripts\_destructible::destructible_loopsound("transformer_spark_loop");
	common_scripts\_destructible::destructible_healthdrain(24,0.2);
	common_scripts\_destructible::destructible_state(undefined,undefined,250,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_sparks","explosions/transformer_spark_runner",0.5);
	common_scripts\_destructible::destructible_loopfx("tag_fx","fire/transformer_blacksmoke_fire",0.4);
	common_scripts\_destructible::destructible_sound("transformer01_flareup_med");
	common_scripts\_destructible::destructible_loopsound("transformer_spark_loop");
	common_scripts\_destructible::destructible_healthdrain(24,0.2,150,"allies");
	common_scripts\_destructible::destructible_state(undefined,undefined,400,undefined,5,"no_melee");
	common_scripts\_destructible::destructible_fx("tag_fx","explosions/transformer_explosion",0);
	common_scripts\_destructible::destructible_fx("tag_fx","fire/firelp_small_pm");
	common_scripts\_destructible::destructible_sound("transformer01_explode");
	common_scripts\_destructible::destructible_explode(7000,8000,150,256,16,100,undefined,0);
	common_scripts\_destructible::destructible_state(undefined,"utility_transformer_ratnest01_dest",undefined,undefined,"no_melee");
}

//Function Number: 53
toy_transformer_small01(param_00)
{
	common_scripts\_destructible::destructible_create(param_00,"tag_origin",75,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_splash_damage_scaler(15);
	common_scripts\_destructible::destructible_loopfx("tag_fx","smoke/car_damage_whitesmoke",0.4);
	common_scripts\_destructible::destructible_state(undefined,undefined,75,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_fx","smoke/car_damage_blacksmoke",0.4);
	common_scripts\_destructible::destructible_state(undefined,undefined,150,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_fx","explosions/transformer_spark_runner",0.5);
	common_scripts\_destructible::destructible_loopsound("transformer_spark_loop");
	common_scripts\_destructible::destructible_healthdrain(24,0.2);
	common_scripts\_destructible::destructible_state(undefined,undefined,250,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_fx","explosions/transformer_spark_runner",0.5);
	common_scripts\_destructible::destructible_loopfx("tag_fx","fire/transformer_small_blacksmoke_fire",0.4);
	common_scripts\_destructible::destructible_sound("transformer01_flareup_med");
	common_scripts\_destructible::destructible_loopsound("transformer_spark_loop");
	common_scripts\_destructible::destructible_healthdrain(24,0.2,150,"allies");
	common_scripts\_destructible::destructible_state(undefined,undefined,400,undefined,5,"no_melee");
	common_scripts\_destructible::destructible_fx("tag_fx","explosions/transformer_explosion",0);
	common_scripts\_destructible::destructible_fx("tag_fx","fire/firelp_small_pm");
	common_scripts\_destructible::destructible_sound("transformer01_explode");
	common_scripts\_destructible::destructible_explode(7000,8000,150,256,16,100,undefined,0);
	common_scripts\_destructible::destructible_state(undefined,"utility_transformer_small01_dest",undefined,undefined,"no_melee");
}

//Function Number: 54
toy_generator(param_00)
{
	common_scripts\_destructible::destructible_create(param_00,"tag_bounce",75,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_splash_damage_scaler(15);
	common_scripts\_destructible::destructible_loopfx("tag_fx2","smoke/generator_damage_whitesmoke",0.4);
	common_scripts\_destructible::destructible_state(undefined,undefined,75,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_fx2","smoke/generator_damage_blacksmoke",0.4);
	common_scripts\_destructible::destructible_state(undefined,undefined,250,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_fx2","smoke/generator_damage_blacksmoke",0.4);
	common_scripts\_destructible::destructible_loopfx("tag_fx4","explosions/generator_spark_runner",0.9);
	common_scripts\_destructible::destructible_loopfx("tag_fx3","explosions/generator_spark_runner",0.6123);
	common_scripts\_destructible::destructible_loopsound("generator_spark_loop");
	common_scripts\_destructible::destructible_healthdrain(24,0.2,64,"allies");
	common_scripts\_destructible::destructible_state(undefined,undefined,400,undefined,5,"no_melee");
	common_scripts\_destructible::destructible_fx("tag_fx","explosions/generator_explosion",1);
	common_scripts\_destructible::destructible_fx("tag_fx","fire/generator_des_fire",1);
	common_scripts\_destructible::destructible_sound("generator01_explode");
	common_scripts\_destructible::destructible_explode(7000,8000,128,128,16,50,undefined,0);
	common_scripts\_destructible::destructible_anim(destructible_gaspump("enerator_explode"),#animtree,"setanimknob",undefined,undefined,"generator_explode");
	common_scripts\_destructible::destructible_state(undefined,"machinery_generator_des",undefined,undefined,"no_melee");
}

//Function Number: 55
toy_generator_on(param_00)
{
	common_scripts\_destructible::destructible_create(param_00,"tag_bounce",0,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_splash_damage_scaler(15);
	common_scripts\_destructible::destructible_loopfx("tag_fx2","smoke/generator_exhaust",0.4);
	common_scripts\_destructible::destructible_anim(destructible_gaspump("enerator_vibration"),#animtree,"setanimknob",undefined,undefined,"generator_vibration");
	common_scripts\_destructible::destructible_loopsound("generator_running");
	common_scripts\_destructible::destructible_state("tag_origin","machinery_generator",150);
	common_scripts\_destructible::destructible_loopfx("tag_fx2","smoke/generator_damage_whitesmoke",0.4);
	common_scripts\_destructible::destructible_loopsound("generator_running");
	common_scripts\_destructible::destructible_state(undefined,undefined,75,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_fx2","smoke/generator_damage_blacksmoke",0.4);
	common_scripts\_destructible::destructible_loopsound("generator_damage_loop");
	common_scripts\_destructible::destructible_state(undefined,undefined,250,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_fx2","smoke/generator_damage_blacksmoke",0.4);
	common_scripts\_destructible::destructible_loopfx("tag_fx4","explosions/generator_spark_runner",0.9);
	common_scripts\_destructible::destructible_loopfx("tag_fx3","explosions/generator_spark_runner",0.6123);
	common_scripts\_destructible::destructible_loopsound("generator_spark_loop");
	common_scripts\_destructible::destructible_loopsound("generator_damage_loop");
	common_scripts\_destructible::destructible_healthdrain(24,0.2,64,"allies");
	common_scripts\_destructible::destructible_state(undefined,undefined,400,undefined,5,"no_melee");
	common_scripts\_destructible::destructible_fx("tag_fx","explosions/generator_explosion",0);
	common_scripts\_destructible::destructible_fx("tag_fx","fire/generator_des_fire");
	common_scripts\_destructible::destructible_sound("generator01_explode");
	common_scripts\_destructible::destructible_explode(7000,8000,128,128,16,50,undefined,0);
	common_scripts\_destructible::destructible_anim(destructible_gaspump("enerator_explode"),#animtree,"setanimknob",undefined,0,"generator_explode");
	common_scripts\_destructible::destructible_anim(destructible_gaspump("enerator_explode_02"),#animtree,"setanimknob",undefined,0,"generator_explode_02");
	common_scripts\_destructible::destructible_anim(destructible_gaspump("enerator_explode_03"),#animtree,"setanimknob",undefined,0,"generator_explode_03");
	common_scripts\_destructible::destructible_state(undefined,"machinery_generator_des",undefined,undefined,"no_melee");
}

//Function Number: 56
toy_oxygen_tank(param_00)
{
	common_scripts\_destructible::destructible_create("toy_oxygen_tank_" + param_00,"tag_origin",150,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_healthdrain(12,0.2,64,"allies");
	common_scripts\_destructible::destructible_loopsound("oxygen_tank_leak_loop");
	common_scripts\_destructible::destructible_fx("tag_cap","props/oxygen_tank" + param_00 + "_cap");
	common_scripts\_destructible::destructible_loopfx("tag_cap","distortion/oxygen_tank_leak",0.4);
	common_scripts\_destructible::destructible_state(undefined,"machinery_oxygen_tank" + param_00 + "_dam",300,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_fx("tag_fx","explosions/oxygen_tank" + param_00 + "_explosion",0);
	common_scripts\_destructible::destructible_sound("oxygen_tank_explode");
	common_scripts\_destructible::destructible_explode(7000,8000,150,256,16,150,undefined,32);
	common_scripts\_destructible::destructible_state(undefined,"machinery_oxygen_tank" + param_00 + "_des",undefined,undefined,"no_melee");
}

//Function Number: 57
toy_electricbox2(param_00)
{
	common_scripts\_destructible::destructible_create(param_00,"tag_origin",150,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_splash_damage_scaler(15);
	common_scripts\_destructible::destructible_fx("tag_fx","props/electricbox4_explode",undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_sound("exp_fusebox_sparks");
	common_scripts\_destructible::destructible_explode(1000,2000,32,32,32,48,undefined,0);
	common_scripts\_destructible::destructible_state(undefined,"me_electricbox2_dest",undefined,undefined,"no_melee");
	common_scripts\_destructible::destructible_part("tag_fx","me_electricbox2_door",undefined,undefined,undefined,undefined,1,1);
	common_scripts\_destructible::destructible_part("tag_door_upper","me_electricbox2_door_upper",undefined,undefined,undefined,undefined,1,1);
}

//Function Number: 58
toy_electricbox4(param_00)
{
	common_scripts\_destructible::destructible_create(param_00,"tag_origin",150,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_splash_damage_scaler(15);
	common_scripts\_destructible::destructible_fx("tag_fx","props/electricbox4_explode",undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_sound("exp_fusebox_sparks");
	common_scripts\_destructible::destructible_explode(20,2000,32,32,32,48,undefined,0);
	common_scripts\_destructible::destructible_state(undefined,"me_electricbox4_dest",undefined,undefined,"no_melee");
	common_scripts\_destructible::destructible_part("tag_fx","me_electricbox4_door",undefined,undefined,undefined,undefined,1,1);
}

//Function Number: 59
toy_airconditioner(param_00)
{
	common_scripts\_destructible::destructible_create(param_00,"tag_origin",0,undefined,32);
	common_scripts\_destructible::destructible_anim(destructible_gaspump("x_airconditioner_fan"),#animtree,"setanimknob",undefined,undefined,"ex_airconditioner_fan");
	common_scripts\_destructible::destructible_loopsound("airconditioner_running_loop");
	common_scripts\_destructible::destructible_state("tag_origin","com_ex_airconditioner",300);
	common_scripts\_destructible::destructible_fx("tag_fx","explosions/airconditioner_ex_explode",undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_sound("airconditioner_burst");
	common_scripts\_destructible::destructible_explode(1000,2000,32,32,32,48,undefined,0);
	common_scripts\_destructible::destructible_state(undefined,"com_ex_airconditioner_dam",undefined,undefined,"no_melee");
	common_scripts\_destructible::destructible_part("tag_fx","com_ex_airconditioner_fan",undefined,undefined,undefined,undefined,1,1);
}

//Function Number: 60
toy_ceiling_fan(param_00)
{
	common_scripts\_destructible::destructible_create(param_00,"tag_origin",0,undefined,32);
	common_scripts\_destructible::destructible_anim(destructible_gaspump("e_fanceil1_spin"),#animtree,"setanimknob",undefined,undefined,"me_fanceil1_spin");
	common_scripts\_destructible::destructible_state("tag_origin","me_fanceil1",150);
	common_scripts\_destructible::destructible_anim(destructible_gaspump("e_fanceil1_spin_stop"),#animtree,"setanimknob",undefined,undefined,"me_fanceil1_spin_stop");
	common_scripts\_destructible::destructible_fx("tag_fx","explosions/ceiling_fan_explosion");
	common_scripts\_destructible::destructible_sound("ceiling_fan_sparks");
	common_scripts\_destructible::destructible_explode(1000,2000,32,32,5,32,undefined,0);
	common_scripts\_destructible::destructible_state(undefined,"me_fanceil1_des",undefined,undefined,"no_melee");
	common_scripts\_destructible::destructible_part("tag_fx",undefined,150,undefined,undefined,undefined,1);
}

//Function Number: 61
toy_wall_fan(param_00)
{
	common_scripts\_destructible::destructible_create(param_00,"tag_swivel",0,undefined,32);
	common_scripts\_destructible::destructible_anim(destructible_gaspump("all_fan_rotate"),#animtree,"setanimknob",undefined,undefined,"wall_fan_rotate");
	common_scripts\_destructible::destructible_loopsound("wall_fan_fanning");
	common_scripts\_destructible::destructible_state("tag_wobble","cs_wallfan1",150);
	common_scripts\_destructible::destructible_anim(destructible_gaspump("all_fan_stop"),#animtree,"setanimknob",undefined,undefined,"wall_fan_wobble");
	common_scripts\_destructible::destructible_fx("tag_fx","explosions/wallfan_explosion_dmg");
	common_scripts\_destructible::destructible_sound("wall_fan_sparks");
	common_scripts\_destructible::destructible_state("tag_wobble","cs_wallfan1",150,undefined,"no_melee");
	common_scripts\_destructible::destructible_fx("tag_fx","explosions/wallfan_explosion_des");
	common_scripts\_destructible::destructible_sound("wall_fan_break");
	common_scripts\_destructible::destructible_state(undefined,"cs_wallfan1_dmg",undefined,undefined,"no_melee");
}

//Function Number: 62
toy_propane_tank02(param_00)
{
	common_scripts\_destructible::destructible_create(param_00,"tag_origin",50,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_splash_damage_scaler(5);
	common_scripts\_destructible::destructible_state(undefined,undefined,350,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_loopsound("propanetank02_gas_leak_loop");
	common_scripts\_destructible::destructible_loopfx("tag_cap","distortion/propane_cap_distortion",0.1);
	common_scripts\_destructible::destructible_state(undefined,undefined,350,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_cap","fire/propane_capfire_leak",0.1);
	common_scripts\_destructible::destructible_sound("propanetank02_flareup_med");
	common_scripts\_destructible::destructible_loopsound("propanetank02_fire_med");
	common_scripts\_destructible::destructible_healthdrain(12,0.2,300,"allies");
	common_scripts\_destructible::destructible_state(undefined,undefined,150,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_physics("tag_cap",(50,0,0));
	common_scripts\_destructible::destructible_loopfx("tag_cap","fire/propane_capfire",0.6);
	common_scripts\_destructible::destructible_fx("tag_valve","fire/propane_valvefire_flareup");
	common_scripts\_destructible::destructible_physics("tag_valve",(50,0,0));
	common_scripts\_destructible::destructible_fx("tag_cap","fire/propane_capfire_flareup");
	common_scripts\_destructible::destructible_loopfx("tag_valve","fire/propane_valvefire",0.1);
	common_scripts\_destructible::destructible_sound("propanetank02_flareup2_med");
	common_scripts\_destructible::destructible_loopsound("propanetank02_fire_med");
	common_scripts\_destructible::destructible_state(undefined,undefined,150,undefined,5,"no_melee");
	common_scripts\_destructible::destructible_fx("tag_fx","fire/propane_small_fire");
	common_scripts\_destructible::destructible_fx("tag_fx","explosions/propane_large_exp_fireball");
	common_scripts\_destructible::destructible_fx("tag_fx","explosions/propane_large_exp",0);
	common_scripts\_destructible::destructible_sound("propanetank02_explode");
	common_scripts\_destructible::destructible_loopsound("propanetank02_fire_blown_med");
	common_scripts\_destructible::destructible_explode(7000,8000,600,600,32,300);
	common_scripts\_destructible::destructible_state(undefined,"com_propane_tank02_DES",undefined,undefined,"no_melee");
	common_scripts\_destructible::destructible_part("tag_valve","com_propane_tank02_valve");
	common_scripts\_destructible::destructible_part("tag_cap","com_propane_tank02_cap");
}

//Function Number: 63
toy_propane_tank02_small(param_00)
{
	common_scripts\_destructible::destructible_create(param_00,"tag_origin",50,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_splash_damage_scaler(10);
	common_scripts\_destructible::destructible_state(undefined,undefined,350,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_loopsound("propanetank02_gas_leak_loop");
	common_scripts\_destructible::destructible_loopfx("tag_cap","distortion/propane_cap_distortion",0.1);
	common_scripts\_destructible::destructible_state(undefined,undefined,350,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_cap","fire/propane_capfire_leak",0.1);
	common_scripts\_destructible::destructible_sound("propanetank02_flareup_med");
	common_scripts\_destructible::destructible_loopsound("propanetank02_fire_med");
	common_scripts\_destructible::destructible_healthdrain(12,0.2,210,"allies");
	common_scripts\_destructible::destructible_state(undefined,undefined,200,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_physics("tag_cap",(50,0,0));
	common_scripts\_destructible::destructible_loopfx("tag_cap","fire/propane_capfire",0.6);
	common_scripts\_destructible::destructible_fx("tag_valve","fire/propane_valvefire_flareup");
	common_scripts\_destructible::destructible_physics("tag_valve",(50,0,0));
	common_scripts\_destructible::destructible_fx("tag_cap","fire/propane_capfire_flareup");
	common_scripts\_destructible::destructible_loopfx("tag_valve","fire/propane_valvefire",0.1);
	common_scripts\_destructible::destructible_sound("propanetank02_flareup_med");
	common_scripts\_destructible::destructible_loopsound("propanetank02_fire_med");
	common_scripts\_destructible::destructible_state(undefined,undefined,200,undefined,5,"no_melee");
	common_scripts\_destructible::destructible_fx("tag_fx","fire/propane_small_fire");
	common_scripts\_destructible::destructible_fx("tag_fx","explosions/propane_large_exp",0);
	common_scripts\_destructible::destructible_sound("propanetank02_explode");
	common_scripts\_destructible::destructible_explode(7000,8000,400,400,32,100);
	common_scripts\_destructible::destructible_state(undefined,"com_propane_tank02_small_DES",undefined,undefined,"no_melee");
	common_scripts\_destructible::destructible_part("tag_valve","com_propane_tank02_small_valve");
	common_scripts\_destructible::destructible_part("tag_cap","com_propane_tank02_small_cap");
}

//Function Number: 64
toy_copier(param_00)
{
	common_scripts\_destructible::destructible_create(param_00,"tag_body",250,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_splash_damage_scaler(15);
	common_scripts\_destructible::destructible_loopfx("tag_left_feeder","smoke/car_damage_whitesmoke",0.4);
	common_scripts\_destructible::destructible_state(undefined,undefined,250,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_left_feeder","smoke/car_damage_blacksmoke",0.4);
	common_scripts\_destructible::destructible_state(undefined,undefined,500,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_fx","props/photocopier_sparks",3);
	common_scripts\_destructible::destructible_loopsound("copier_spark_loop");
	common_scripts\_destructible::destructible_healthdrain(12,0.2);
	common_scripts\_destructible::destructible_state(undefined,undefined,800,undefined,5,"no_melee");
	common_scripts\_destructible::destructible_fx("tag_fx","props/photocopier_exp",0);
	common_scripts\_destructible::destructible_fx("tag_fx","props/photocopier_fire");
	common_scripts\_destructible::destructible_sound("copier_exp");
	common_scripts\_destructible::destructible_loopsound("copier_fire_loop");
	common_scripts\_destructible::destructible_explode(7000,8000,96,96,32,48);
	common_scripts\_destructible::destructible_state(undefined,"prop_photocopier_destroyed",undefined,undefined,"no_melee");
	common_scripts\_destructible::destructible_part("tag_left_feeder","prop_photocopier_destroyed_left_feeder",4,undefined,undefined,undefined,1,1);
	common_scripts\_destructible::destructible_part("tag_right_shelf","prop_photocopier_destroyed_right_shelf",4,undefined,undefined,undefined,1,1);
	common_scripts\_destructible::destructible_part("tag_top","prop_photocopier_destroyed_top",4,undefined,undefined,undefined,1,1);
}

//Function Number: 65
toy_firehydrant(param_00)
{
	common_scripts\_destructible::destructible_create(param_00,"tag_origin",250,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_splash_damage_scaler(11);
	common_scripts\_destructible::destructible_state(undefined,undefined,500,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_cap","props/firehydrant_leak",0.1);
	common_scripts\_destructible::destructible_loopsound("firehydrant_spray_loop");
	common_scripts\_destructible::destructible_healthdrain(12,0.2);
	common_scripts\_destructible::destructible_state(undefined,undefined,800,undefined,5,"no_melee");
	common_scripts\_destructible::destructible_fx("tag_fx","props/firehydrant_exp",0);
	common_scripts\_destructible::destructible_fx("tag_fx","props/firehydrant_spray_10sec",0);
	common_scripts\_destructible::destructible_sound("firehydrant_burst");
	common_scripts\_destructible::destructible_explode(17000,18000,96,96,32,48);
	common_scripts\_destructible::destructible_state(undefined,"com_firehydrant_dest",undefined,undefined,"no_melee");
	common_scripts\_destructible::destructible_part("tag_fx","com_firehydrant_dam",undefined,undefined,undefined,undefined,1,1);
	common_scripts\_destructible::destructible_part("tag_cap","com_firehydrant_cap",undefined,undefined,undefined,undefined,1,1);
}

//Function Number: 66
toy_parkingmeter(param_00)
{
	common_scripts\_destructible::destructible_create(param_00,"tag_meter",120);
	common_scripts\_destructible::destructible_fx("tag_fx","props/parking_meter_coins",1,common_scripts\_destructible::damage_not("splash"));
	common_scripts\_destructible::destructible_fx("tag_fx","props/parking_meter_coins_exploded",1,"splash");
	common_scripts\_destructible::destructible_sound("exp_parking_meter_sweet");
	common_scripts\_destructible::destructible_explode(2800,3000,64,64,0,0,1);
	common_scripts\_destructible::destructible_state(undefined,"com_parkingmeter_damaged",20,undefined,undefined,"splash");
	common_scripts\_destructible::destructible_state(undefined,"com_parkingmeter_destroyed",undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_part("tag_cap","com_parkingmeter_cap",undefined,undefined,undefined,undefined,1,1);
}

//Function Number: 67
toy_mailbox(param_00)
{
	common_scripts\_destructible::destructible_create(param_00,"tag_origin",200);
	common_scripts\_destructible::destructible_fx("tag_fx","props/mail_box_explode",1);
	common_scripts\_destructible::destructible_sound("exp_mailbox_sweet");
	common_scripts\_destructible::destructible_explode(100,2000,64,64,0,0);
	common_scripts\_destructible::destructible_state("tag_origin","com_mailbox_dam");
	common_scripts\_destructible::destructible_part("tag_door","com_mailbox_door",undefined,undefined,undefined,undefined,1,1);
	common_scripts\_destructible::destructible_part("tag_flag","com_mailbox_flag",undefined,undefined,undefined,undefined,1,1);
}

//Function Number: 68
toy_mailbox2(param_00)
{
	common_scripts\_destructible::destructible_create("toy_mailbox2_" + param_00,"tag_origin",120);
	common_scripts\_destructible::destructible_fx("tag_fx","props/mail_box_explode",1,common_scripts\_destructible::damage_not("splash"));
	common_scripts\_destructible::destructible_fx("tag_fx","props/mail_box_explode",1,"splash");
	common_scripts\_destructible::destructible_sound("exp_mailbox_sweet");
	common_scripts\_destructible::destructible_explode(2800,3000,64,64,0,0,1);
	common_scripts\_destructible::destructible_state(undefined,"mailbox_" + param_00 + "_dam",20,undefined,undefined,"splash");
	common_scripts\_destructible::destructible_state(undefined,"mailbox_black_dest",undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_part("tag_door","mailbox_" + param_00 + "_door",undefined,undefined,undefined,undefined,1,1);
	common_scripts\_destructible::destructible_part("tag_flag","mailbox_black_flag",undefined,undefined,undefined,undefined,1,1);
}

//Function Number: 69
toy_newspaper_stand_red(param_00)
{
	common_scripts\_destructible::destructible_create(param_00,"tag_origin",120);
	common_scripts\_destructible::destructible_fx("tag_door","props/news_stand_paper_spill",1,common_scripts\_destructible::damage_not("splash"));
	common_scripts\_destructible::destructible_sound("exp_newspaper_box");
	common_scripts\_destructible::destructible_explode(2500,2501,64,64,0,0,1);
	common_scripts\_destructible::destructible_state(undefined,"com_newspaperbox_red_dam",20,undefined,undefined,"splash");
	common_scripts\_destructible::destructible_fx("tag_fx","props/news_stand_explosion",1,"splash");
	common_scripts\_destructible::destructible_state(undefined,"com_newspaperbox_red_des",undefined,undefined,undefined,undefined,undefined,0);
	common_scripts\_destructible::destructible_part("tag_door","com_newspaperbox_red_door",undefined,undefined,undefined,undefined,1,1);
}

//Function Number: 70
toy_newspaper_stand_blue(param_00)
{
	common_scripts\_destructible::destructible_create(param_00,"tag_origin",120);
	common_scripts\_destructible::destructible_fx("tag_door","props/news_stand_paper_spill_shatter",1,common_scripts\_destructible::damage_not("splash"));
	common_scripts\_destructible::destructible_sound("exp_newspaper_box");
	common_scripts\_destructible::destructible_explode(800,2001,64,64,0,0,1);
	common_scripts\_destructible::destructible_state(undefined,"com_newspaperbox_blue_dam",20,undefined,undefined,"splash");
	common_scripts\_destructible::destructible_fx("tag_fx","props/news_stand_explosion",1,"splash");
	common_scripts\_destructible::destructible_state(undefined,"com_newspaperbox_blue_des",undefined,undefined,undefined,undefined,undefined,0);
	common_scripts\_destructible::destructible_part("tag_door","com_newspaperbox_blue_door",undefined,undefined,undefined,undefined,1,1);
}

//Function Number: 71
toy_filecabinet(param_00)
{
	common_scripts\_destructible::destructible_create(param_00,"tag_origin",120);
	common_scripts\_destructible::destructible_fx("tag_drawer_lower","props/filecabinet_dam",1,common_scripts\_destructible::damage_not("splash"));
	common_scripts\_destructible::destructible_sound("exp_filecabinet");
	common_scripts\_destructible::destructible_state(undefined,"com_filecabinetblackclosed_dam",20,undefined,undefined,"splash");
	common_scripts\_destructible::destructible_fx("tag_drawer_upper","props/filecabinet_des",1,"splash");
	common_scripts\_destructible::destructible_sound("exp_filecabinet");
	common_scripts\_destructible::destructible_physics("tag_drawer_upper",(50,-10,5));
	common_scripts\_destructible::destructible_state(undefined,"com_filecabinetblackclosed_des",undefined,undefined,undefined,undefined,undefined,0);
	common_scripts\_destructible::destructible_part("tag_drawer_upper","com_filecabinetblackclosed_drawer",undefined,undefined,undefined,undefined,1,1);
}

//Function Number: 72
toy_trashbin_01(param_00)
{
	common_scripts\_destructible::destructible_create(param_00,"tag_origin",120,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_fx("tag_fx","props/garbage_spew_des",1,"splash");
	common_scripts\_destructible::destructible_fx("tag_fx","props/garbage_spew",1,common_scripts\_destructible::damage_not("splash"));
	common_scripts\_destructible::destructible_sound("exp_trashcan_sweet");
	common_scripts\_destructible::destructible_explode(1300,1351,1,1,10,20);
	common_scripts\_destructible::destructible_state(undefined,"com_trashbin01_dmg",undefined,undefined,undefined,undefined,undefined,0);
	common_scripts\_destructible::destructible_part("tag_fx","com_trashbin01_lid",undefined,undefined,undefined,undefined,1,1);
}

//Function Number: 73
toy_trashbin_02(param_00)
{
	common_scripts\_destructible::destructible_create(param_00,"tag_origin",120,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_fx("tag_fx","props/garbage_spew_des",1,"splash");
	common_scripts\_destructible::destructible_fx("tag_fx","props/garbage_spew",1,common_scripts\_destructible::damage_not("splash"));
	common_scripts\_destructible::destructible_sound("exp_trashcan_sweet");
	common_scripts\_destructible::destructible_explode(600,800,1,1,10,20);
	common_scripts\_destructible::destructible_state(undefined,"com_trashbin02_dmg",undefined,undefined,undefined,undefined,undefined,0);
	common_scripts\_destructible::destructible_part("tag_fx","com_trashbin02_lid",undefined,undefined,undefined,undefined,1,1);
}

//Function Number: 74
toy_trashbag1(param_00)
{
	common_scripts\_destructible::destructible_create("toy_trashbag1_" + param_00,"tag_origin",120,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_fx("tag_fx","props/trashbag_" + param_00);
	common_scripts\_destructible::destructible_state(undefined,"com_trashbag1_" + param_00 + "_dsr",undefined,undefined,undefined,undefined,undefined,0);
}

//Function Number: 75
toy_recyclebin_01(param_00)
{
	common_scripts\_destructible::destructible_create(param_00,"tag_origin",120,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_fx("tag_fx","props/garbage_spew_des",1,"splash");
	common_scripts\_destructible::destructible_fx("tag_fx","props/garbage_spew",1,common_scripts\_destructible::damage_not("splash"));
	common_scripts\_destructible::destructible_sound("exp_trashcan_sweet");
	common_scripts\_destructible::destructible_explode(600,651,1,1,10,20);
	common_scripts\_destructible::destructible_state(undefined,"com_recyclebin01_dmg",undefined,undefined,undefined,undefined,undefined,0);
	common_scripts\_destructible::destructible_part("tag_fx","com_recyclebin01_lid",undefined,undefined,undefined,undefined,1,1);
}

//Function Number: 76
toy_trashcan_metal_closed(param_00)
{
	common_scripts\_destructible::destructible_create(param_00,"tag_origin",120,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_fx("tag_fx","props/garbage_spew_des",1,"splash");
	common_scripts\_destructible::destructible_fx("tag_fx","props/garbage_spew",1,common_scripts\_destructible::damage_not("splash"));
	common_scripts\_destructible::destructible_sound("exp_trashcan_sweet");
	common_scripts\_destructible::destructible_explode(600,651,1,1,10,20);
	common_scripts\_destructible::destructible_state(undefined,"com_trashcan_metal_with_trash",undefined,undefined,undefined,undefined,undefined,0);
	common_scripts\_destructible::destructible_part("tag_fx","com_trashcan_metalLID",undefined,undefined,undefined,undefined,1,1);
}

//Function Number: 77
toy_water_collector(param_00)
{
	common_scripts\_destructible::destructible_create(param_00,"tag_origin",220,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_fx("tag_fx","explosions/water_collector_explosion");
	common_scripts\_destructible::destructible_sound("water_collector_splash");
	common_scripts\_destructible::destructible_explode(500,800,32,32,1,10,undefined,32);
	common_scripts\_destructible::destructible_state(undefined,"utility_water_collector_base_dest",undefined,undefined,"no_melee",undefined,undefined,0);
	common_scripts\_destructible::destructible_part("tag_lid",undefined,220,undefined,undefined,"no_melee",1);
	common_scripts\_destructible::destructible_state(undefined);
}

//Function Number: 78
toy_foliage_tree_oak_1(param_00)
{
	common_scripts\_destructible::destructible_create(param_00,"tag_origin",120,undefined,32,"splash");
	common_scripts\_destructible::destructible_fx("tag_fx","explosions/tree_trunk_explosion_oak_1",1,"splash");
	common_scripts\_destructible::destructible_sound("large_oak_tree_impact");
	common_scripts\_destructible::destructible_sound("large_oak_tree_fall");
	common_scripts\_destructible::destructible_explode(600,651,1,1,10,20);
	common_scripts\_destructible::destructible_state(undefined,"foliage_tree_oak_1_destroyed_trunk",undefined,undefined,undefined,undefined,undefined,0);
}

//Function Number: 79
toy_paris_tree_plane_large(param_00)
{
	common_scripts\_destructible::destructible_create(param_00,"tag_origin",250,undefined,32,"splash");
	common_scripts\_destructible::destructible_fx("tag_origin","props/paris_tree_plane_destruct");
	common_scripts\_destructible::destructible_explode(100,351,150,350,100,200,undefined,undefined,undefined,undefined,(-400,0,80),0.7);
	common_scripts\_destructible::destructible_state(undefined,"foliage_paris_tree_plane_broken",undefined,undefined,undefined,undefined,undefined,0);
}

//Function Number: 80
toy_usa_gas_station_trash_bin_01(param_00)
{
	common_scripts\_destructible::destructible_create(param_00,"tag_origin",120,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_fx("tag_fx","props/garbage_spew_des",1,"splash");
	common_scripts\_destructible::destructible_fx("tag_fx","props/garbage_spew",1,common_scripts\_destructible::damage_not("splash"));
	common_scripts\_destructible::destructible_explode(600,651,1,1,10,20);
	common_scripts\_destructible::destructible_state(undefined,"usa_gas_station_trash_bin_01_base",undefined,undefined,undefined,undefined,undefined,0);
	common_scripts\_destructible::destructible_part("tag_fx","usa_gas_station_trash_bin_01_lid",undefined,undefined,undefined,undefined,1,1);
}

//Function Number: 81
toy_usa_gas_station_trash_bin_02(param_00)
{
	common_scripts\_destructible::destructible_create(param_00,"tag_origin",120,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_fx("tag_fx_high","props/garbage_spew_des",1,"splash");
	common_scripts\_destructible::destructible_fx("tag_fx_high","props/garbage_spew",1,common_scripts\_destructible::damage_not("splash"));
	common_scripts\_destructible::destructible_explode(600,651,1,1,10,20);
	common_scripts\_destructible::destructible_state(undefined,"usa_gas_station_trash_bin_02_base",undefined,undefined,undefined,undefined,undefined,0);
	common_scripts\_destructible::destructible_part("tag_fx_high","usa_gas_station_trash_bin_02_lid",undefined,undefined,undefined,undefined,1,1);
}

//Function Number: 82
toy_light_ceiling_round(param_00)
{
	common_scripts\_destructible::destructible_create(param_00,"tag_origin",150,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_splash_damage_scaler(15);
	common_scripts\_destructible::destructible_lights_out(16);
	common_scripts\_destructible::destructible_fx("tag_fx","misc/light_blowout_runner");
	common_scripts\_destructible::destructible_state(undefined,"com_light_ceiling_round_off",undefined,undefined,"no_melee");
}

//Function Number: 83
toy_light_ceiling_fluorescent(param_00)
{
	common_scripts\_destructible::destructible_create(param_00,"tag_origin",150,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_splash_damage_scaler(15);
	common_scripts\_destructible::destructible_fx("tag_fx","misc/light_fluorescent_blowout_runner");
	common_scripts\_destructible::destructible_fx("tag_swing_fx","misc/light_blowout_swinging_runner");
	common_scripts\_destructible::destructible_lights_out(16);
	common_scripts\_destructible::destructible_explode(20,2000,64,64,40,80);
	common_scripts\_destructible::destructible_anim(destructible_gaspump("ight_fluorescent_swing"),#animtree,"setanimknob",undefined,0,"light_fluorescent_swing");
	common_scripts\_destructible::destructible_sound("fluorescent_light_fall",undefined,0);
	common_scripts\_destructible::destructible_sound("fluorescent_light_bulb",undefined,0);
	common_scripts\_destructible::destructible_anim(destructible_gaspump("ight_fluorescent_swing_02"),#animtree,"setanimknob",undefined,1,"light_fluorescent_swing_02");
	common_scripts\_destructible::destructible_sound("fluorescent_light_fall",undefined,1);
	common_scripts\_destructible::destructible_sound("fluorescent_light_bulb",undefined,1);
	common_scripts\_destructible::destructible_anim(destructible_gaspump("ight_fluorescent_null"),#animtree,"setanimknob",undefined,2,"light_fluorescent_null");
	common_scripts\_destructible::destructible_state(undefined,"me_lightfluohang_double_destroyed",undefined,undefined,"no_melee");
}

//Function Number: 84
toy_light_ceiling_fluorescent_spotlight(param_00)
{
	common_scripts\_destructible::destructible_create(param_00,"tag_origin",150,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_splash_damage_scaler(15);
	common_scripts\_destructible::destructible_sound("fluorescent_light_bulb");
	common_scripts\_destructible::destructible_fx("tag_fx","misc/light_fluorescent_blowout_runner");
	common_scripts\_destructible::destructible_fx("tag_swing_fx","misc/light_blowout_swinging_runner");
	common_scripts\_destructible::destructible_lights_out(16);
	common_scripts\_destructible::destructible_explode(20,2000,64,64,40,80);
	common_scripts\_destructible::destructible_anim(destructible_gaspump("ight_fluorescent_swing"),#animtree,"setanimknob",undefined,0,"light_fluorescent_swing");
	common_scripts\_destructible::destructible_sound("fluorescent_light_fall",undefined,0);
	common_scripts\_destructible::destructible_sound("fluorescent_light_bulb",undefined,0);
	common_scripts\_destructible::destructible_spotlight("tag_swing_r_far");
	common_scripts\_destructible::destructible_sound("fluorescent_light_fall");
	common_scripts\_destructible::destructible_state(undefined,"me_lightfluohang_double_destroyed",undefined,undefined,"no_melee");
}

//Function Number: 85
toy_light_ceiling_fluorescent_single(param_00)
{
	common_scripts\_destructible::destructible_create(param_00,"tag_origin",150,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_splash_damage_scaler(15);
	common_scripts\_destructible::destructible_fx("tag_fx","misc/light_fluorescent_single_blowout_runner");
	common_scripts\_destructible::destructible_fx("tag_swing_center_fx","misc/light_blowout_swinging_runner");
	common_scripts\_destructible::destructible_fx("tag_swing_center_fx_far","misc/light_blowout_swinging_runner");
	common_scripts\_destructible::destructible_lights_out(32);
	common_scripts\_destructible::destructible_explode(20,2000,64,64,40,80);
	common_scripts\_destructible::destructible_anim(destructible_gaspump("ight_fluorescent_single_swing"),#animtree,"setanimknob",undefined,0,"light_fluorescent_single_swing");
	common_scripts\_destructible::destructible_sound("fluorescent_light_fall",undefined,0);
	common_scripts\_destructible::destructible_sound("fluorescent_light_bulb",undefined,0);
	common_scripts\_destructible::destructible_anim(destructible_gaspump("ight_fluorescent_single_swing_02"),#animtree,"setanimknob",undefined,1,"light_fluorescent_single_swing_02");
	common_scripts\_destructible::destructible_sound("fluorescent_light_hinge",undefined,1);
	common_scripts\_destructible::destructible_sound("fluorescent_light_bulb",undefined,1);
	common_scripts\_destructible::destructible_anim(destructible_gaspump("ight_fluorescent_single_swing_03"),#animtree,"setanimknob",undefined,2,"light_fluorescent_single_swing_03");
	common_scripts\_destructible::destructible_sound("fluorescent_light_fall",undefined,2);
	common_scripts\_destructible::destructible_sound("fluorescent_light_bulb",undefined,2);
	common_scripts\_destructible::destructible_anim(destructible_gaspump("ight_fluorescent_single_null"),#animtree,"setanimknob",undefined,3,"light_fluorescent_single_null");
	common_scripts\_destructible::destructible_state(undefined,"me_lightfluohang_single_destroyed",undefined,undefined,"no_melee");
}

//Function Number: 86
toy_light_ceiling_fluorescent_single_spotlight(param_00)
{
	common_scripts\_destructible::destructible_create(param_00,"tag_origin",150,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_splash_damage_scaler(15);
	common_scripts\_destructible::destructible_lights_out(16);
	common_scripts\_destructible::destructible_sound("fluorescent_light_bulb");
	common_scripts\_destructible::destructible_fx("tag_fx","misc/light_fluorescent_single_blowout_runner");
	common_scripts\_destructible::destructible_fx("tag_swing_center_fx","misc/light_blowout_swinging_runner");
	common_scripts\_destructible::destructible_fx("tag_swing_center_fx_far","misc/light_blowout_swinging_runner");
	common_scripts\_destructible::destructible_explode(20,2000,64,64,40,80);
	common_scripts\_destructible::destructible_anim(destructible_gaspump("ight_fluorescent_single_swing_02"),#animtree,"setanimknob",undefined,undefined,"light_fluorescent_single_swing_02");
	common_scripts\_destructible::destructible_sound("fluorescent_light_fall");
	common_scripts\_destructible::destructible_spotlight("tag_swing_center_fx_far");
	common_scripts\_destructible::destructible_state(undefined,"me_lightfluohang_single_destroyed",undefined,undefined,"no_melee");
}

//Function Number: 87
toy_bookstore_bookstand4_books(param_00)
{
	common_scripts\_destructible::destructible_create(param_00,"tag_origin",200,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_splash_damage_scaler(7);
	common_scripts\_destructible::destructible_fx("tag_fx","props/bookshelf4_dmg",1,common_scripts\_destructible::damage_not("splash"));
	common_scripts\_destructible::destructible_state(undefined,"bookstore_bookstand4",100,undefined,undefined,"splash");
	common_scripts\_destructible::destructible_fx("tag_fx","props/bookshelf4_des",1,"splash");
	common_scripts\_destructible::destructible_explode(2000,3800,32,32,1,5,undefined,0);
	common_scripts\_destructible::destructible_state(undefined,"bookstore_bookstand4_null",undefined,undefined,undefined,undefined,undefined,0);
}

//Function Number: 88
toy_locker_double(param_00)
{
	common_scripts\_destructible::destructible_create(param_00,"tag_origin",150,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_anim(destructible_gaspump("ocker_broken_both_doors_1"),#animtree,"setanimknob",undefined,0,"locker_broken_both_doors_1");
	common_scripts\_destructible::destructible_fx("tag_fx","props/locker_double_des_02_right",undefined,undefined,0);
	common_scripts\_destructible::destructible_sound("lockers_fast",undefined,0);
	common_scripts\_destructible::destructible_anim(destructible_gaspump("ocker_broken_both_doors_2"),#animtree,"setanimknob",undefined,1,"locker_broken_both_doors_2");
	common_scripts\_destructible::destructible_fx("tag_fx","props/locker_double_des_01_left",undefined,undefined,1);
	common_scripts\_destructible::destructible_sound("lockers_fast",undefined,1);
	common_scripts\_destructible::destructible_anim(destructible_gaspump("ocker_broken_both_doors_4"),#animtree,"setanimknob",undefined,2,"locker_broken_both_doors_4");
	common_scripts\_destructible::destructible_fx("tag_fx","props/locker_double_des_03_both",undefined,undefined,2);
	common_scripts\_destructible::destructible_sound("lockers_double",undefined,2);
	common_scripts\_destructible::destructible_anim(destructible_gaspump("ocker_broken_door1_fast"),#animtree,"setanimknob",undefined,3,"locker_broken_door1_fast");
	common_scripts\_destructible::destructible_fx("tag_fx","props/locker_double_des_01_left",undefined,undefined,3);
	common_scripts\_destructible::destructible_sound("lockers_fast",undefined,3);
	common_scripts\_destructible::destructible_anim(destructible_gaspump("ocker_broken_door2_fast"),#animtree,"setanimknob",undefined,4,"locker_broken_door2_fast");
	common_scripts\_destructible::destructible_fx("tag_fx","props/locker_double_des_02_right",undefined,undefined,4);
	common_scripts\_destructible::destructible_sound("lockers_fast",undefined,4);
	common_scripts\_destructible::destructible_anim(destructible_gaspump("ocker_broken_both_doors_3"),#animtree,"setanimknob",undefined,5,"locker_broken_both_doors_3");
	common_scripts\_destructible::destructible_fx("tag_fx","misc/no_effect",undefined,undefined,5);
	common_scripts\_destructible::destructible_sound("lockers_minor",undefined,5);
	common_scripts\_destructible::destructible_anim(destructible_gaspump("ocker_broken_door1_slow"),#animtree,"setanimknob",undefined,6,"locker_broken_door1_slow");
	common_scripts\_destructible::destructible_fx("tag_fx","misc/no_effect",undefined,undefined,6);
	common_scripts\_destructible::destructible_sound("lockers_minor",undefined,6);
	common_scripts\_destructible::destructible_anim(destructible_gaspump("ocker_broken_door2_slow"),#animtree,"setanimknob",undefined,7,"locker_broken_door2_slow");
	common_scripts\_destructible::destructible_fx("tag_fx","misc/no_effect",undefined,undefined,7);
	common_scripts\_destructible::destructible_sound("lockers_minor",undefined,7);
	common_scripts\_destructible::destructible_state(undefined,"com_locker_double_destroyed",undefined,undefined,"no_melee");
}

//Function Number: 89
toy_dubai_fish_sculpture(param_00,param_01,param_02)
{
	common_scripts\_destructible::destructible_create(param_00,"tag_origin",200000000,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_splash_damage_scaler(2);
	for(var_03 = 1;var_03 <= param_02;var_03++)
	{
		common_scripts\_destructible::destructible_part("tag_" + param_01 + "_" + var_03,param_00,10);
		common_scripts\_destructible::destructible_fx("tag_" + param_01 + "_" + var_03,"props/dub_fish_" + param_01 + "_shatter");
		common_scripts\_destructible::destructible_state(undefined);
	}
}

//Function Number: 90
toy_intro_concrete_chipaway(param_00,param_01)
{
	common_scripts\_destructible::destructible_create(param_00,"tag_origin",200000000,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_state("tag_origin",param_00,undefined,undefined,"no_melee");
	for(var_02 = 1;var_02 <= param_01;var_02++)
	{
		common_scripts\_destructible::destructible_part("tag_chunk_" + var_02,param_00,200,undefined,undefined,"no_splash");
		common_scripts\_destructible::destructible_splash_damage_scaler(0.01);
		common_scripts\_destructible::destructible_fx("tag_chunk_" + var_02,"props/intro_wall_chunk_exp");
		common_scripts\_destructible::destructible_state(undefined);
	}
}

//Function Number: 91
toy_chicken(param_00)
{
	common_scripts\_destructible::destructible_create("toy_chicken" + param_00,"tag_origin",0,undefined,32);
	common_scripts\_destructible::destructible_anim(destructible_gaspump("hicken_cage_loop_01"),#animtree,"setanimknob",undefined,0,"chicken_cage_loop_01",1.6);
	common_scripts\_destructible::destructible_anim(destructible_gaspump("hicken_cage_loop_02"),#animtree,"setanimknob",undefined,1,"chicken_cage_loop_02",1.6);
	common_scripts\_destructible::destructible_loopsound("animal_chicken_idle_loop");
	common_scripts\_destructible::destructible_state("tag_origin","chicken" + param_00,25);
	common_scripts\_destructible::destructible_fx("tag_origin","props/chicken_exp" + param_00);
	common_scripts\_destructible::destructible_anim(destructible_gaspump("hicken_cage_death"),#animtree,"setanimknob",undefined,0,"chicken_cage_death");
	common_scripts\_destructible::destructible_anim(destructible_gaspump("hicken_cage_death_02"),#animtree,"setanimknob",undefined,1,"chicken_cage_death_02");
	common_scripts\_destructible::destructible_sound("animal_chicken_death");
	common_scripts\_destructible::destructible_state(undefined,"chicken" + param_00,undefined,undefined,"no_melee");
}

//Function Number: 92
toy_hide_with_fx(param_00,param_01,param_02,param_03)
{
	common_scripts\_destructible::destructible_create(param_00,param_01,param_03);
	common_scripts\_destructible::destructible_fx("tag_origin",param_02);
	common_scripts\_destructible::destructible_state("tag_origin","generic_prop_raven");
}

//Function Number: 93
vehicle_ac130_80s_sedan1(param_00)
{
	common_scripts\_destructible::destructible_create("vehicle_ac130_80s_sedan1_" + param_00,"tag_body",250,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_hood_fx","smoke/car_damage_whitesmoke",0.4);
	common_scripts\_destructible::destructible_state(undefined,undefined,200,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_hood_fx","smoke/car_damage_blacksmoke",0.4);
	common_scripts\_destructible::destructible_state(undefined,undefined,100,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_hood_fx","smoke/car_damage_blacksmoke_fire",0.4);
	common_scripts\_destructible::destructible_sound("fire_vehicle_flareup_med");
	common_scripts\_destructible::destructible_loopsound("fire_vehicle_med");
	common_scripts\_destructible::destructible_state(undefined,undefined,300,"player_only",32,"no_melee");
	common_scripts\_destructible::destructible_loopsound("fire_vehicle_med");
	common_scripts\_destructible::destructible_state(undefined,undefined,400,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_fx("tag_death_fx","explosions/small_vehicle_explosion",0);
	common_scripts\_destructible::destructible_sound("car_explode");
	common_scripts\_destructible::destructible_explode(4000,5000,150,250,50,300,undefined,undefined,0.3,500);
	lib_0D89::func_6F6E(%F,#animtree,"setanimknob",undefined,undefined,"vehicle_80s_sedan1_destroy");
	common_scripts\_destructible::destructible_state(undefined,"vehicle_80s_sedan1_" + param_00 + "_destroyed",undefined,32,"_melee");
	var_01 = "tag_hood";
	common_scripts\_destructible::destructible_part(var_01,"vehicle_80s_sedan1_" + param_00 + "_hood",undefined,undefined,undefined,undefined,1,2.5);
	var_01 = "tag_trunk";
	common_scripts\_destructible::destructible_part(var_01,"vehicle_80s_sedan1_" + param_00 + "_trunk",undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_part("left_wheel_01_jnt",undefined,20,undefined,undefined,"no_melee");
	lib_0D89::func_7562(%F,#animtree,"setanim");
	common_scripts\_destructible::destructible_sound("veh_tire_deflate","llet");
	common_scripts\_destructible::destructible_part("left_wheel_02_jnt",undefined,20,undefined,undefined,"no_melee");
	lib_0D89::func_7562(%F,#animtree,"setanim");
	common_scripts\_destructible::destructible_sound("veh_tire_deflate","llet");
	common_scripts\_destructible::destructible_part("right_wheel_01_jnt","vehicle_80s_sedan1_" + param_00 + "_wheel_LF",20,undefined,undefined,"no_melee",undefined,1.7);
	lib_0D89::func_7562(%F,#animtree,"setanim");
	common_scripts\_destructible::destructible_sound("veh_tire_deflate","llet");
	common_scripts\_destructible::destructible_part("right_wheel_02_jnt","vehicle_80s_sedan1_" + param_00 + "_wheel_LF",20,undefined,undefined,"no_melee",undefined,2.3);
	lib_0D89::func_7562(%F,#animtree,"setanim");
	common_scripts\_destructible::destructible_sound("veh_tire_deflate","llet");
	common_scripts\_destructible::destructible_part("tag_door_left_front",undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_part("tag_door_left_back",undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_part("tag_door_right_front","vehicle_80s_sedan1_" + param_00 + "_door_RF",undefined,undefined,undefined,undefined,1,1);
	common_scripts\_destructible::destructible_part("tag_door_right_back","vehicle_80s_sedan1_" + param_00 + "_door_RB",undefined,undefined,undefined,undefined,1,1);
	var_01 = "tag_glass_front";
	common_scripts\_destructible::destructible_part(var_01,undefined,40,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01 + "_d",undefined,60,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_front_fx","props/car_glass_large");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_glass_back";
	common_scripts\_destructible::destructible_part(var_01,undefined,40,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01 + "_d",undefined,60,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_back_fx","props/car_glass_large");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_glass_left_front";
	common_scripts\_destructible::destructible_part(var_01,undefined,20,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01 + "_d",undefined,60,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_left_front_fx","props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_glass_right_front";
	common_scripts\_destructible::destructible_part(var_01,undefined,20,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01 + "_d",undefined,60,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_right_front_fx","props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_glass_left_back";
	common_scripts\_destructible::destructible_part(var_01,undefined,20,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01 + "_d",undefined,60,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_left_back_fx","props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_glass_right_back";
	common_scripts\_destructible::destructible_part(var_01,undefined,20,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01 + "_d",undefined,60,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_right_back_fx","props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_light_left_front";
	common_scripts\_destructible::destructible_part(var_01,undefined,20,undefined,undefined,undefined,0.5);
	common_scripts\_destructible::destructible_fx(var_01,"props/car_glass_headlight");
	common_scripts\_destructible::destructible_sound("veh_glass_break_small");
	common_scripts\_destructible::destructible_state(var_01 + "_d");
	var_01 = "tag_light_right_front";
	common_scripts\_destructible::destructible_part(var_01,undefined,20,undefined,undefined,undefined,0.5);
	common_scripts\_destructible::destructible_fx(var_01,"props/car_glass_headlight");
	common_scripts\_destructible::destructible_sound("veh_glass_break_small");
	common_scripts\_destructible::destructible_state(var_01 + "_d");
	var_01 = "tag_light_left_back";
	common_scripts\_destructible::destructible_part(var_01,undefined,20);
	common_scripts\_destructible::destructible_fx(var_01,"props/car_glass_brakelight");
	common_scripts\_destructible::destructible_sound("veh_glass_break_small");
	common_scripts\_destructible::destructible_state(var_01 + "_d");
	var_01 = "tag_light_right_back";
	common_scripts\_destructible::destructible_part(var_01,undefined,20);
	common_scripts\_destructible::destructible_fx(var_01,"props/car_glass_brakelight");
	common_scripts\_destructible::destructible_sound("veh_glass_break_small");
	common_scripts\_destructible::destructible_state(var_01 + "_d");
	common_scripts\_destructible::destructible_part("tag_bumper_front","vehicle_80s_sedan1_" + param_00 + "_bumper_F",undefined,undefined,undefined,undefined,1,1);
	common_scripts\_destructible::destructible_part("tag_bumper_back","vehicle_80s_sedan1_" + param_00 + "_bumper_B",undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_part("tag_mirror_left","vehicle_80s_sedan1_" + param_00 + "_mirror_L",40,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_physics();
	common_scripts\_destructible::destructible_part("tag_mirror_right","vehicle_80s_sedan1_" + param_00 + "_mirror_R",40,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_physics();
}

//Function Number: 94
vehicle_bus_destructible(param_00)
{
	common_scripts\_destructible::destructible_create(param_00,"tag_body",250,undefined,32,"no_melee");
	var_01 = "tag_window_front_left";
	common_scripts\_destructible::destructible_part(var_01,undefined,99,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01 + "_d",undefined,200,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx(var_01,"props/car_glass_large");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_window_front_right";
	common_scripts\_destructible::destructible_part(var_01,undefined,99,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01 + "_d",undefined,200,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx(var_01,"props/car_glass_large");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_window_driver";
	common_scripts\_destructible::destructible_part(var_01,undefined,99,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01 + "_d",undefined,200,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx(var_01,"props/car_glass_large");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_window_back";
	common_scripts\_destructible::destructible_part(var_01,undefined,99,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01 + "_d",undefined,200,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx(var_01,"props/car_glass_large");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_window_side_1";
	common_scripts\_destructible::destructible_part(var_01,undefined,99,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01 + "_d",undefined,200,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx(var_01,"props/car_glass_large");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_window_side_2";
	common_scripts\_destructible::destructible_part(var_01,undefined,99,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01 + "_d",undefined,200,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx(var_01,"props/car_glass_large");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_window_side_3";
	common_scripts\_destructible::destructible_part(var_01,undefined,99,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01 + "_d",undefined,200,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx(var_01,"props/car_glass_large");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_window_side_4";
	common_scripts\_destructible::destructible_part(var_01,undefined,99,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01 + "_d",undefined,200,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx(var_01,"props/car_glass_large");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_window_side_5";
	common_scripts\_destructible::destructible_part(var_01,undefined,99,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01 + "_d",undefined,200,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx(var_01,"props/car_glass_large");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_window_side_6";
	common_scripts\_destructible::destructible_part(var_01,undefined,99,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01 + "_d",undefined,200,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx(var_01,"props/car_glass_large");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_window_side_7";
	common_scripts\_destructible::destructible_part(var_01,undefined,99,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01 + "_d",undefined,200,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx(var_01,"props/car_glass_large");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_window_side_8";
	common_scripts\_destructible::destructible_part(var_01,undefined,99,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01 + "_d",undefined,200,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx(var_01,"props/car_glass_large");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_window_side_9";
	common_scripts\_destructible::destructible_part(var_01,undefined,99,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01 + "_d",undefined,200,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx(var_01,"props/car_glass_large");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_window_side_10";
	common_scripts\_destructible::destructible_part(var_01,undefined,99,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01 + "_d",undefined,200,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx(var_01,"props/car_glass_large");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_window_side_11";
	common_scripts\_destructible::destructible_part(var_01,undefined,99,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01 + "_d",undefined,200,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx(var_01,"props/car_glass_large");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
}

//Function Number: 95
vehicle_80s_sedan1(param_00)
{
	common_scripts\_destructible::destructible_create("vehicle_80s_sedan1_" + param_00,"tag_body",250,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_hood_fx","smoke/car_damage_whitesmoke",0.4);
	common_scripts\_destructible::destructible_state(undefined,undefined,200,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_hood_fx","smoke/car_damage_blacksmoke",0.4);
	common_scripts\_destructible::destructible_state(undefined,undefined,100,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_hood_fx","smoke/car_damage_blacksmoke_fire",0.4);
	common_scripts\_destructible::destructible_sound("fire_vehicle_flareup_med");
	common_scripts\_destructible::destructible_loopsound("fire_vehicle_med");
	common_scripts\_destructible::destructible_healthdrain(12,0.2,150,"allies");
	common_scripts\_destructible::destructible_state(undefined,undefined,300,"player_only",32,"no_melee");
	common_scripts\_destructible::destructible_loopsound("fire_vehicle_med");
	common_scripts\_destructible::destructible_state(undefined,undefined,400,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_fx("tag_death_fx","explosions/small_vehicle_explosion",0);
	common_scripts\_destructible::destructible_sound("car_explode");
	common_scripts\_destructible::destructible_explode(4000,5000,150,250,50,300,undefined,undefined,0.3,500);
	lib_0D89::func_6F6E(%F,#animtree,"setanimknob",undefined,undefined,"vehicle_80s_sedan1_destroy");
	common_scripts\_destructible::destructible_state(undefined,"vehicle_80s_sedan1_" + param_00 + "_destroyed",undefined,32,"_melee");
	var_01 = "tag_hood";
	common_scripts\_destructible::destructible_part(var_01,"vehicle_80s_sedan1_" + param_00 + "_hood",undefined,undefined,undefined,undefined,1,2.5);
	var_01 = "tag_trunk";
	common_scripts\_destructible::destructible_part(var_01,"vehicle_80s_sedan1_" + param_00 + "_trunk",undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_part("left_wheel_01_jnt",undefined,20,undefined,undefined,"no_melee");
	lib_0D89::func_7562(%F,#animtree,"setanim");
	common_scripts\_destructible::destructible_sound("veh_tire_deflate","llet");
	common_scripts\_destructible::destructible_part("left_wheel_02_jnt",undefined,20,undefined,undefined,"no_melee");
	lib_0D89::func_7562(%F,#animtree,"setanim");
	common_scripts\_destructible::destructible_sound("veh_tire_deflate","llet");
	common_scripts\_destructible::destructible_part("right_wheel_01_jnt","vehicle_80s_sedan1_" + param_00 + "_wheel_LF",20,undefined,undefined,"no_melee",undefined,1.7);
	lib_0D89::func_7562(%F,#animtree,"setanim");
	common_scripts\_destructible::destructible_sound("veh_tire_deflate","llet");
	common_scripts\_destructible::destructible_part("right_wheel_02_jnt","vehicle_80s_sedan1_" + param_00 + "_wheel_LF",20,undefined,undefined,"no_melee",undefined,2.3);
	lib_0D89::func_7562(%F,#animtree,"setanim");
	common_scripts\_destructible::destructible_sound("veh_tire_deflate","llet");
	common_scripts\_destructible::destructible_part("tag_door_left_front",undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_part("tag_door_left_back",undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_part("tag_door_right_front","vehicle_80s_sedan1_" + param_00 + "_door_RF",undefined,undefined,undefined,undefined,1,1);
	common_scripts\_destructible::destructible_part("tag_door_right_back","vehicle_80s_sedan1_" + param_00 + "_door_RB",undefined,undefined,undefined,undefined,1,1);
	var_01 = "tag_glass_front";
	common_scripts\_destructible::destructible_part(var_01,undefined,40,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01 + "_d",undefined,60,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_front_fx","props/car_glass_large");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_glass_back";
	common_scripts\_destructible::destructible_part(var_01,undefined,40,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01 + "_d",undefined,60,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_back_fx","props/car_glass_large");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_glass_left_front";
	common_scripts\_destructible::destructible_part(var_01,undefined,20,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01 + "_d",undefined,60,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_left_front_fx","props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_glass_right_front";
	common_scripts\_destructible::destructible_part(var_01,undefined,20,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01 + "_d",undefined,60,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_right_front_fx","props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_glass_left_back";
	common_scripts\_destructible::destructible_part(var_01,undefined,20,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01 + "_d",undefined,60,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_left_back_fx","props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_glass_right_back";
	common_scripts\_destructible::destructible_part(var_01,undefined,20,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01 + "_d",undefined,60,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_right_back_fx","props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_light_left_front";
	common_scripts\_destructible::destructible_part(var_01,undefined,20,undefined,undefined,undefined,0.5);
	common_scripts\_destructible::destructible_fx(var_01,"props/car_glass_headlight");
	common_scripts\_destructible::destructible_sound("veh_glass_break_small");
	common_scripts\_destructible::destructible_state(var_01 + "_d");
	var_01 = "tag_light_right_front";
	common_scripts\_destructible::destructible_part(var_01,undefined,20,undefined,undefined,undefined,0.5);
	common_scripts\_destructible::destructible_fx(var_01,"props/car_glass_headlight");
	common_scripts\_destructible::destructible_sound("veh_glass_break_small");
	common_scripts\_destructible::destructible_state(var_01 + "_d");
	var_01 = "tag_light_left_back";
	common_scripts\_destructible::destructible_part(var_01,undefined,20);
	common_scripts\_destructible::destructible_fx(var_01,"props/car_glass_brakelight");
	common_scripts\_destructible::destructible_sound("veh_glass_break_small");
	common_scripts\_destructible::destructible_state(var_01 + "_d");
	var_01 = "tag_light_right_back";
	common_scripts\_destructible::destructible_part(var_01,undefined,20);
	common_scripts\_destructible::destructible_fx(var_01,"props/car_glass_brakelight");
	common_scripts\_destructible::destructible_sound("veh_glass_break_small");
	common_scripts\_destructible::destructible_state(var_01 + "_d");
	common_scripts\_destructible::destructible_part("tag_bumper_front","vehicle_80s_sedan1_" + param_00 + "_bumper_F",undefined,undefined,undefined,undefined,1,1);
	common_scripts\_destructible::destructible_part("tag_bumper_back","vehicle_80s_sedan1_" + param_00 + "_bumper_B",undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_part("tag_mirror_left","vehicle_80s_sedan1_" + param_00 + "_mirror_L",40,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_physics();
	common_scripts\_destructible::destructible_part("tag_mirror_right","vehicle_80s_sedan1_" + param_00 + "_mirror_R",40,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_physics();
}

//Function Number: 96
vehicle_80s_hatch1(param_00)
{
	common_scripts\_destructible::destructible_create("vehicle_80s_hatch1_" + param_00,"tag_body",250,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_hood_fx","smoke/car_damage_whitesmoke",0.4);
	common_scripts\_destructible::destructible_state(undefined,undefined,200,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_hood_fx","smoke/car_damage_blacksmoke",0.4);
	common_scripts\_destructible::destructible_state(undefined,undefined,100,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_hood_fx","smoke/car_damage_blacksmoke_fire",0.4);
	common_scripts\_destructible::destructible_sound("fire_vehicle_flareup_med");
	common_scripts\_destructible::destructible_loopsound("fire_vehicle_med");
	common_scripts\_destructible::destructible_healthdrain(12,0.2,150,"allies");
	common_scripts\_destructible::destructible_state(undefined,undefined,300,"player_only",32,"no_melee");
	common_scripts\_destructible::destructible_loopsound("fire_vehicle_med");
	common_scripts\_destructible::destructible_state(undefined,undefined,400,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_fx("tag_death_fx","explosions/small_vehicle_explosion",0);
	common_scripts\_destructible::destructible_sound("car_explode");
	common_scripts\_destructible::destructible_explode(4000,5000,150,250,50,300,undefined,undefined,0.3,500);
	lib_0D89::func_6F6E(%F,#animtree,"setanimknob",undefined,undefined,"vehicle_80s_sedan1_destroy");
	common_scripts\_destructible::destructible_state(undefined,"vehicle_80s_hatch1_" + param_00 + "_destroyed",undefined,32,"_melee");
	var_01 = "tag_hood";
	common_scripts\_destructible::destructible_part(var_01,"vehicle_80s_hatch1_" + param_00 + "_hood",800,undefined,undefined,undefined,1,1.5);
	common_scripts\_destructible::destructible_part("left_wheel_01_jnt","vehicle_80s_hatch1_" + param_00 + "_wheel_LF",20,undefined,undefined,"no_melee",undefined,1.7);
	lib_0D89::func_7562(%F,#animtree,"setanim");
	common_scripts\_destructible::destructible_sound("veh_tire_deflate","llet");
	common_scripts\_destructible::destructible_part("left_wheel_02_jnt",undefined,20,undefined,undefined,"no_melee");
	lib_0D89::func_7562(%F,#animtree,"setanim");
	common_scripts\_destructible::destructible_sound("veh_tire_deflate","llet");
	common_scripts\_destructible::destructible_part("right_wheel_01_jnt","vehicle_80s_hatch1_" + param_00 + "_wheel_LF",20,undefined,undefined,"no_melee",undefined,1.7);
	lib_0D89::func_7562(%F,#animtree,"setanim");
	common_scripts\_destructible::destructible_sound("veh_tire_deflate","llet");
	common_scripts\_destructible::destructible_part("right_wheel_02_jnt",undefined,20,undefined,undefined,"no_melee");
	lib_0D89::func_7562(%F,#animtree,"setanim");
	common_scripts\_destructible::destructible_sound("veh_tire_deflate","llet");
	common_scripts\_destructible::destructible_part("tag_door_left_front",undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_part("tag_door_right_front","vehicle_80s_hatch1_" + param_00 + "_door_RF",undefined,undefined,undefined,undefined,1,1);
	var_01 = "tag_glass_front";
	common_scripts\_destructible::destructible_part(var_01,undefined,10,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01 + "_d",undefined,60,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_front_fx","props/car_glass_large");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_glass_back";
	common_scripts\_destructible::destructible_part(var_01,undefined,10,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01 + "_d",undefined,60,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_back_fx","props/car_glass_large");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_glass_left_front";
	common_scripts\_destructible::destructible_part(var_01,undefined,10,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01 + "_d",undefined,60,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_left_front_fx","props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_glass_right_front";
	common_scripts\_destructible::destructible_part(var_01,undefined,10,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01 + "_d",undefined,60,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_right_front_fx","props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_glass_left_back";
	common_scripts\_destructible::destructible_part(var_01,undefined,10,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01 + "_d",undefined,60,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_left_back_fx","props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_glass_right_back";
	common_scripts\_destructible::destructible_part(var_01,undefined,10,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01 + "_d",undefined,60,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_right_back_fx","props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_light_left_front";
	common_scripts\_destructible::destructible_part(var_01,undefined,20,undefined,undefined,undefined,0.5);
	common_scripts\_destructible::destructible_fx(var_01,"props/car_glass_headlight");
	common_scripts\_destructible::destructible_sound("veh_glass_break_small");
	common_scripts\_destructible::destructible_state(var_01 + "_d");
	var_01 = "tag_light_right_front";
	common_scripts\_destructible::destructible_part(var_01,undefined,20,undefined,undefined,undefined,0.5);
	common_scripts\_destructible::destructible_fx(var_01,"props/car_glass_headlight");
	common_scripts\_destructible::destructible_sound("veh_glass_break_small");
	common_scripts\_destructible::destructible_state(var_01 + "_d");
	var_01 = "tag_light_left_back";
	common_scripts\_destructible::destructible_part(var_01,undefined,20);
	common_scripts\_destructible::destructible_fx(var_01,"props/car_glass_brakelight");
	common_scripts\_destructible::destructible_sound("veh_glass_break_small");
	common_scripts\_destructible::destructible_state(var_01 + "_d");
	var_01 = "tag_light_right_back";
	common_scripts\_destructible::destructible_part(var_01,undefined,20);
	common_scripts\_destructible::destructible_fx(var_01,"props/car_glass_brakelight");
	common_scripts\_destructible::destructible_sound("veh_glass_break_small");
	common_scripts\_destructible::destructible_state(var_01 + "_d");
	common_scripts\_destructible::destructible_part("tag_bumper_front");
	common_scripts\_destructible::destructible_part("tag_bumper_back");
	common_scripts\_destructible::destructible_part("tag_mirror_left","vehicle_80s_hatch1_" + param_00 + "_mirror_L",40);
	common_scripts\_destructible::destructible_physics();
	common_scripts\_destructible::destructible_part("tag_mirror_right","vehicle_80s_hatch1_" + param_00 + "_mirror_R",40);
	common_scripts\_destructible::destructible_physics();
}

//Function Number: 97
vehicle_80s_hatch2(param_00)
{
	common_scripts\_destructible::destructible_create("vehicle_80s_hatch2_" + param_00,"tag_body",250,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_hood_fx","smoke/car_damage_whitesmoke",0.4);
	common_scripts\_destructible::destructible_state(undefined,undefined,200,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_hood_fx","smoke/car_damage_blacksmoke",0.4);
	common_scripts\_destructible::destructible_state(undefined,undefined,100,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_hood_fx","smoke/car_damage_blacksmoke_fire",0.4);
	common_scripts\_destructible::destructible_sound("fire_vehicle_flareup_med");
	common_scripts\_destructible::destructible_loopsound("fire_vehicle_med");
	common_scripts\_destructible::destructible_healthdrain(12,0.2,150,"allies");
	common_scripts\_destructible::destructible_state(undefined,undefined,300,"player_only",32,"no_melee");
	common_scripts\_destructible::destructible_loopsound("fire_vehicle_med");
	common_scripts\_destructible::destructible_state(undefined,undefined,400,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_fx("tag_death_fx","explosions/small_vehicle_explosion",0);
	common_scripts\_destructible::destructible_sound("car_explode");
	common_scripts\_destructible::destructible_explode(4000,5000,150,250,50,300,undefined,undefined,0.3,500);
	lib_0D89::func_6F6E(%F,#animtree,"setanimknob",undefined,undefined,"vehicle_80s_sedan1_destroy");
	common_scripts\_destructible::destructible_state(undefined,"vehicle_80s_hatch2_" + param_00 + "_destroyed",undefined,32,"_melee");
	var_01 = "tag_hood";
	common_scripts\_destructible::destructible_part(var_01,"vehicle_80s_hatch2_" + param_00 + "_hood",800,undefined,undefined,undefined,1,1.5);
	common_scripts\_destructible::destructible_part("left_wheel_01_jnt","vehicle_80s_hatch2_" + param_00 + "_wheel_LF",20,undefined,undefined,"no_melee",undefined,1.7);
	lib_0D89::func_7562(%F,#animtree,"setanim");
	common_scripts\_destructible::destructible_sound("veh_tire_deflate","llet");
	common_scripts\_destructible::destructible_part("left_wheel_02_jnt",undefined,20,undefined,undefined,"no_melee");
	lib_0D89::func_7562(%F,#animtree,"setanim");
	common_scripts\_destructible::destructible_sound("veh_tire_deflate","llet");
	common_scripts\_destructible::destructible_part("right_wheel_01_jnt","vehicle_80s_hatch2_" + param_00 + "_wheel_LF",20,undefined,undefined,"no_melee",undefined,1.7);
	lib_0D89::func_7562(%F,#animtree,"setanim");
	common_scripts\_destructible::destructible_sound("veh_tire_deflate","llet");
	common_scripts\_destructible::destructible_part("right_wheel_02_jnt",undefined,20,undefined,undefined,"no_melee");
	lib_0D89::func_7562(%F,#animtree,"setanim");
	common_scripts\_destructible::destructible_sound("veh_tire_deflate","llet");
	common_scripts\_destructible::destructible_part("tag_door_left_front",undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_part("tag_door_right_front","vehicle_80s_hatch2_" + param_00 + "_door_RF",undefined,undefined,undefined,undefined,1,1);
	var_01 = "tag_glass_front";
	common_scripts\_destructible::destructible_part(var_01,undefined,40,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01 + "_d",undefined,60,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_front_fx","props/car_glass_large");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_glass_back";
	common_scripts\_destructible::destructible_part(var_01,undefined,40,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01 + "_d",undefined,60,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_back_fx","props/car_glass_large");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_glass_left_front";
	common_scripts\_destructible::destructible_part(var_01,undefined,20,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01 + "_d",undefined,60,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_left_front_fx","props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_glass_right_front";
	common_scripts\_destructible::destructible_part(var_01,undefined,20,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01 + "_d",undefined,60,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_right_front_fx","props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_glass_left_back";
	common_scripts\_destructible::destructible_part(var_01,undefined,20,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01 + "_d",undefined,60,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_left_back_fx","props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_glass_right_back";
	common_scripts\_destructible::destructible_part(var_01,undefined,20,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01 + "_d",undefined,60,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_right_back_fx","props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_light_left_front";
	common_scripts\_destructible::destructible_part(var_01,undefined,20,undefined,undefined,undefined,0.5);
	common_scripts\_destructible::destructible_fx(var_01,"props/car_glass_headlight");
	common_scripts\_destructible::destructible_sound("veh_glass_break_small");
	common_scripts\_destructible::destructible_state(var_01 + "_d");
	var_01 = "tag_light_right_front";
	common_scripts\_destructible::destructible_part(var_01,undefined,20,undefined,undefined,undefined,0.5);
	common_scripts\_destructible::destructible_fx(var_01,"props/car_glass_headlight");
	common_scripts\_destructible::destructible_sound("veh_glass_break_small");
	common_scripts\_destructible::destructible_state(var_01 + "_d");
	var_01 = "tag_light_left_back";
	common_scripts\_destructible::destructible_part(var_01,undefined,20);
	common_scripts\_destructible::destructible_fx(var_01,"props/car_glass_brakelight");
	common_scripts\_destructible::destructible_sound("veh_glass_break_small");
	common_scripts\_destructible::destructible_state(var_01 + "_d");
	var_01 = "tag_light_right_back";
	common_scripts\_destructible::destructible_part(var_01,undefined,20);
	common_scripts\_destructible::destructible_fx(var_01,"props/car_glass_brakelight");
	common_scripts\_destructible::destructible_sound("veh_glass_break_small");
	common_scripts\_destructible::destructible_state(var_01 + "_d");
	common_scripts\_destructible::destructible_part("tag_bumper_front");
	common_scripts\_destructible::destructible_part("tag_bumper_back");
	common_scripts\_destructible::destructible_part("tag_mirror_left","vehicle_80s_hatch2_" + param_00 + "_mirror_L",40);
	common_scripts\_destructible::destructible_physics();
	common_scripts\_destructible::destructible_part("tag_mirror_right","vehicle_80s_hatch2_" + param_00 + "_mirror_R",40);
	common_scripts\_destructible::destructible_physics();
}

//Function Number: 98
vehicle_80s_wagon1(param_00)
{
	common_scripts\_destructible::destructible_create("vehicle_80s_wagon1_" + param_00,"tag_body",250,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_hood_fx","smoke/car_damage_whitesmoke",0.4);
	common_scripts\_destructible::destructible_state(undefined,undefined,200,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_hood_fx","smoke/car_damage_blacksmoke",0.4);
	common_scripts\_destructible::destructible_state(undefined,undefined,100,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_hood_fx","smoke/car_damage_blacksmoke_fire",0.4);
	common_scripts\_destructible::destructible_sound("fire_vehicle_flareup_med");
	common_scripts\_destructible::destructible_loopsound("fire_vehicle_med");
	common_scripts\_destructible::destructible_healthdrain(12,0.2,150,"allies");
	common_scripts\_destructible::destructible_state(undefined,undefined,300,"player_only",32,"no_melee");
	common_scripts\_destructible::destructible_loopsound("fire_vehicle_med");
	common_scripts\_destructible::destructible_state(undefined,undefined,400,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_fx("tag_death_fx","explosions/small_vehicle_explosion",0);
	common_scripts\_destructible::destructible_sound("car_explode");
	common_scripts\_destructible::destructible_explode(4000,5000,150,250,50,300,undefined,undefined,0.3,500);
	lib_0D89::func_6F6E(%F,#animtree,"setanimknob",undefined,undefined,"vehicle_80s_sedan1_destroy");
	common_scripts\_destructible::destructible_state(undefined,"vehicle_80s_wagon1_" + param_00 + "_destroyed",undefined,32,"_melee");
	var_01 = "tag_hood";
	common_scripts\_destructible::destructible_part(var_01,"vehicle_80s_wagon1_" + param_00 + "_hood",800,undefined,undefined,undefined,1,1.5);
	common_scripts\_destructible::destructible_part("left_wheel_01_jnt",undefined,20,undefined,undefined,"no_melee");
	lib_0D89::func_7562(%F,#animtree,"setanim");
	common_scripts\_destructible::destructible_sound("veh_tire_deflate","llet");
	common_scripts\_destructible::destructible_part("left_wheel_02_jnt","vehicle_80s_wagon1_" + param_00 + "_wheel_LF",20,undefined,undefined,"no_melee",undefined,1.7);
	lib_0D89::func_7562(%F,#animtree,"setanim");
	common_scripts\_destructible::destructible_sound("veh_tire_deflate","llet");
	common_scripts\_destructible::destructible_part("right_wheel_01_jnt",undefined,20,undefined,undefined,"no_melee");
	lib_0D89::func_7562(%F,#animtree,"setanim");
	common_scripts\_destructible::destructible_sound("veh_tire_deflate","llet");
	common_scripts\_destructible::destructible_part("right_wheel_02_jnt","vehicle_80s_wagon1_" + param_00 + "_wheel_LF",20,undefined,undefined,"no_melee",undefined,1.7);
	lib_0D89::func_7562(%F,#animtree,"setanim");
	common_scripts\_destructible::destructible_sound("veh_tire_deflate","llet");
	common_scripts\_destructible::destructible_part("tag_door_left_front",undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_part("tag_door_left_back",undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_part("tag_door_right_front",undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_part("tag_door_right_back","vehicle_80s_wagon1_" + param_00 + "_door_RB",undefined,undefined,undefined,undefined,1,1);
	var_01 = "tag_glass_front";
	common_scripts\_destructible::destructible_part(var_01,undefined,40,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01 + "_d",undefined,60,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_front_fx","props/car_glass_large");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_glass_back";
	common_scripts\_destructible::destructible_part(var_01,undefined,40,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01 + "_d",undefined,60,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_back_fx","props/car_glass_large");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_glass_left_front";
	common_scripts\_destructible::destructible_part(var_01,undefined,20,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01 + "_d",undefined,60,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_left_front_fx","props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_glass_right_front";
	common_scripts\_destructible::destructible_part(var_01,undefined,20,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01 + "_d",undefined,60,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_right_front_fx","props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_glass_left_back";
	common_scripts\_destructible::destructible_part(var_01,undefined,20,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01 + "_d",undefined,60,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_left_back_fx","props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_glass_right_back";
	common_scripts\_destructible::destructible_part(var_01,undefined,20,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01 + "_d",undefined,60,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_right_back_fx","props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_glass_left_back2";
	common_scripts\_destructible::destructible_part(var_01,undefined,20,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01 + "_d",undefined,60,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_left_back2_fx","props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_glass_right_back2";
	common_scripts\_destructible::destructible_part(var_01,undefined,20,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01 + "_d",undefined,60,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_right_back2_fx","props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_light_left_front";
	common_scripts\_destructible::destructible_part(var_01,undefined,20,undefined,undefined,undefined,0.5);
	common_scripts\_destructible::destructible_fx(var_01,"props/car_glass_headlight");
	common_scripts\_destructible::destructible_sound("veh_glass_break_small");
	common_scripts\_destructible::destructible_state(var_01 + "_d");
	var_01 = "tag_light_right_front";
	common_scripts\_destructible::destructible_part(var_01,undefined,20,undefined,undefined,undefined,0.5);
	common_scripts\_destructible::destructible_fx(var_01,"props/car_glass_headlight");
	common_scripts\_destructible::destructible_sound("veh_glass_break_small");
	common_scripts\_destructible::destructible_state(var_01 + "_d");
	var_01 = "tag_light_left_back";
	common_scripts\_destructible::destructible_part(var_01,undefined,20);
	common_scripts\_destructible::destructible_fx(var_01,"props/car_glass_brakelight");
	common_scripts\_destructible::destructible_sound("veh_glass_break_small");
	common_scripts\_destructible::destructible_state(var_01 + "_d");
	var_01 = "tag_light_right_back";
	common_scripts\_destructible::destructible_part(var_01,undefined,20);
	common_scripts\_destructible::destructible_fx(var_01,"props/car_glass_brakelight");
	common_scripts\_destructible::destructible_sound("veh_glass_break_small");
	common_scripts\_destructible::destructible_state(var_01 + "_d");
	common_scripts\_destructible::destructible_part("tag_bumper_front","vehicle_80s_wagon1_" + param_00 + "_bumper_F",undefined,undefined,undefined,undefined,1,0.7);
	common_scripts\_destructible::destructible_part("tag_bumper_back",undefined,undefined,undefined,undefined,undefined,undefined,0.6);
	common_scripts\_destructible::destructible_part("tag_mirror_left","vehicle_80s_wagon1_" + param_00 + "_mirror_L",40);
	common_scripts\_destructible::destructible_physics();
	common_scripts\_destructible::destructible_part("tag_mirror_right","vehicle_80s_wagon1_" + param_00 + "_mirror_R",40);
	common_scripts\_destructible::destructible_physics();
}

//Function Number: 99
vehicle_civ_car_a(param_00)
{
	common_scripts\_destructible::destructible_create("vehicle_civ_car_a_" + param_00,"ac_prs_veh_civ_car_a_" + param_00 + "_lod0",250,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_state("ac_prs_veh_civ_car_a_dam" + param_00 + "_lod0","ac_prs_veh_civ_car_a_dam" + param_00,250,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_fx(undefined,"explosions/small_vehicle_explosion_ac130",0);
	common_scripts\_destructible::destructible_sound("car_explode");
	common_scripts\_destructible::destructible_explode(4000,5000,150,250,50,300,undefined,undefined,0.3,500);
}

//Function Number: 100
vehicle_small_hatch(param_00)
{
	common_scripts\_destructible::destructible_create("vehicle_small_hatch_" + param_00,"tag_body",250,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_hood_fx","smoke/car_damage_whitesmoke",0.4);
	common_scripts\_destructible::destructible_state(undefined,undefined,200,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_hood_fx","smoke/car_damage_blacksmoke",0.4);
	common_scripts\_destructible::destructible_state(undefined,undefined,100,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_hood_fx","smoke/car_damage_blacksmoke_fire",0.4);
	common_scripts\_destructible::destructible_sound("fire_vehicle_flareup_med");
	common_scripts\_destructible::destructible_loopsound("fire_vehicle_med");
	common_scripts\_destructible::destructible_healthdrain(15,0.25,150,"allies");
	common_scripts\_destructible::destructible_state(undefined,undefined,300,"player_only",32,"no_melee");
	common_scripts\_destructible::destructible_loopsound("fire_vehicle_med");
	common_scripts\_destructible::destructible_state(undefined,undefined,400,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_fx("tag_death_fx","explosions/small_vehicle_explosion",0);
	common_scripts\_destructible::destructible_sound("car_explode");
	common_scripts\_destructible::destructible_explode(4000,5000,150,250,50,300,undefined,undefined,0.3,500);
	lib_0D89::func_6F6E(%F,#animtree,"setanimknob",undefined,undefined,"vehicle_80s_sedan1_destroy");
	common_scripts\_destructible::destructible_state(undefined,"vehicle_small_hatch_" + param_00 + "_destroyed",undefined,32,"_melee");
	var_01 = "tag_hood";
	common_scripts\_destructible::destructible_part(var_01,"vehicle_small_hatch_" + param_00 + "_hood",800,undefined,undefined,undefined,1,1.5);
	common_scripts\_destructible::destructible_part("left_wheel_01_jnt",undefined,20,undefined,undefined,"no_melee");
	lib_0D89::func_7562(%F,#animtree,"setanim");
	common_scripts\_destructible::destructible_sound("veh_tire_deflate","llet");
	common_scripts\_destructible::destructible_part("left_wheel_02_jnt",undefined,20,undefined,undefined,"no_melee");
	lib_0D89::func_7562(%F,#animtree,"setanim");
	common_scripts\_destructible::destructible_sound("veh_tire_deflate","llet");
	common_scripts\_destructible::destructible_part("right_wheel_01_jnt",undefined,20,undefined,undefined,"no_melee");
	lib_0D89::func_7562(%F,#animtree,"setanim");
	common_scripts\_destructible::destructible_sound("veh_tire_deflate","llet");
	common_scripts\_destructible::destructible_part("right_wheel_02_jnt",undefined,20,undefined,undefined,"no_melee");
	lib_0D89::func_7562(%F,#animtree,"setanim");
	common_scripts\_destructible::destructible_sound("veh_tire_deflate","llet");
	common_scripts\_destructible::destructible_part("tag_door_left_front","vehicle_small_hatch_" + param_00 + "_door_LF",undefined,undefined,undefined,undefined,1,1);
	common_scripts\_destructible::destructible_part("tag_door_right_front","vehicle_small_hatch_" + param_00 + "_door_RF",undefined,undefined,undefined,undefined,1,1);
	var_01 = "tag_glass_front";
	common_scripts\_destructible::destructible_part(var_01,undefined,40,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01 + "_d",undefined,60,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_front_fx","props/car_glass_large");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_glass_back";
	common_scripts\_destructible::destructible_part(var_01,undefined,40,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01 + "_d",undefined,60,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_back_fx","props/car_glass_large");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_glass_left_front";
	common_scripts\_destructible::destructible_part(var_01,undefined,20,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01 + "_d",undefined,60,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_left_front_fx","props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_glass_right_front";
	common_scripts\_destructible::destructible_part(var_01,undefined,20,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01 + "_d",undefined,60,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_right_front_fx","props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_glass_left_back";
	common_scripts\_destructible::destructible_part(var_01,undefined,20,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01 + "_d",undefined,60,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_left_back_fx","props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_glass_right_back";
	common_scripts\_destructible::destructible_part(var_01,undefined,20,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01 + "_d",undefined,60,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_right_back_fx","props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_light_left_front";
	common_scripts\_destructible::destructible_part(var_01,undefined,20,undefined,undefined,undefined,0.5);
	common_scripts\_destructible::destructible_fx(var_01,"props/car_glass_headlight");
	common_scripts\_destructible::destructible_sound("veh_glass_break_small");
	common_scripts\_destructible::destructible_state(var_01 + "_d");
	var_01 = "tag_light_right_front";
	common_scripts\_destructible::destructible_part(var_01,undefined,20,undefined,undefined,undefined,0.5);
	common_scripts\_destructible::destructible_fx(var_01,"props/car_glass_headlight");
	common_scripts\_destructible::destructible_sound("veh_glass_break_small");
	common_scripts\_destructible::destructible_state(var_01 + "_d");
	var_01 = "tag_light_left_back";
	common_scripts\_destructible::destructible_part(var_01,undefined,20,undefined,undefined,undefined,0.5);
	common_scripts\_destructible::destructible_fx(var_01,"props/car_glass_brakelight");
	common_scripts\_destructible::destructible_sound("veh_glass_break_small");
	common_scripts\_destructible::destructible_state(var_01 + "_d");
	var_01 = "tag_light_right_back";
	common_scripts\_destructible::destructible_part(var_01,undefined,20,undefined,undefined,undefined,0.5);
	common_scripts\_destructible::destructible_fx(var_01,"props/car_glass_brakelight");
	common_scripts\_destructible::destructible_sound("veh_glass_break_small");
	common_scripts\_destructible::destructible_state(var_01 + "_d");
	common_scripts\_destructible::destructible_part("tag_bumper_front",undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_part("tag_bumper_back",undefined,undefined,undefined,undefined,undefined,0.5);
	common_scripts\_destructible::destructible_part("tag_mirror_left","vehicle_small_hatch_" + param_00 + "_mirror_L",40,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_physics();
	common_scripts\_destructible::destructible_part("tag_mirror_right","vehicle_small_hatch_" + param_00 + "_mirror_R",40,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_physics();
}

//Function Number: 101
vehicle_london_cab_black()
{
	common_scripts\_destructible::destructible_create("vehicle_london_cab_black","tag_body",250,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_hood_fx","smoke/car_damage_whitesmoke",0.4);
	common_scripts\_destructible::destructible_state(undefined,undefined,200,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_hood_fx","smoke/car_damage_blacksmoke",0.4);
	common_scripts\_destructible::destructible_state(undefined,undefined,100,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_hood_fx","smoke/car_damage_blacksmoke_fire",0.4);
	common_scripts\_destructible::destructible_sound("fire_vehicle_flareup_med");
	common_scripts\_destructible::destructible_loopsound("fire_vehicle_med");
	common_scripts\_destructible::destructible_healthdrain(15,0.25,150,"allies");
	common_scripts\_destructible::destructible_state(undefined,undefined,300,"player_only",32,"no_melee");
	common_scripts\_destructible::destructible_loopsound("fire_vehicle_med");
	common_scripts\_destructible::destructible_state(undefined,undefined,400,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_fx("tag_death_fx","explosions/small_vehicle_explosion",0);
	common_scripts\_destructible::destructible_sound("car_explode");
	common_scripts\_destructible::destructible_explode(4000,5000,150,250,50,300,undefined,undefined,0.3,500);
	lib_0D89::func_6F6E(%F,#animtree,"setanimknob",undefined,undefined,"vehicle_80s_sedan1_destroy");
	common_scripts\_destructible::destructible_state(undefined,"vehicle_london_cab_destroyed",undefined,32,"_melee");
	var_00 = "tag_hood";
	common_scripts\_destructible::destructible_part(var_00,"vehicle_london_cab_hood",800,undefined,undefined,undefined,1,1.5);
	common_scripts\_destructible::destructible_part("left_wheel_01_jnt","vehicle_london_cab_wheel_lf",20,undefined,undefined,"no_melee",undefined,1);
	lib_0D89::func_7562(%F,#animtree,"setanim");
	common_scripts\_destructible::destructible_sound("veh_tire_deflate","llet");
	common_scripts\_destructible::destructible_part("left_wheel_02_jnt",undefined,20,undefined,undefined,"no_melee");
	lib_0D89::func_7562(%F,#animtree,"setanim");
	common_scripts\_destructible::destructible_sound("veh_tire_deflate","llet");
	common_scripts\_destructible::destructible_part("right_wheel_01_jnt","vehicle_london_cab_wheel_lf",20,undefined,undefined,"no_melee",undefined,1);
	lib_0D89::func_7562(%F,#animtree,"setanim");
	common_scripts\_destructible::destructible_sound("veh_tire_deflate","llet");
	common_scripts\_destructible::destructible_part("right_wheel_02_jnt","vehicle_london_cab_wheel_lf",20,undefined,undefined,"no_melee",undefined,1);
	lib_0D89::func_7562(%F,#animtree,"setanim");
	common_scripts\_destructible::destructible_sound("veh_tire_deflate","llet");
	common_scripts\_destructible::destructible_part("tag_door_left_front","vehicle_london_cab_door_lb",undefined,undefined,undefined,undefined,1,1);
	common_scripts\_destructible::destructible_part("tag_door_right_front","vehicle_london_cab_door_lb",undefined,undefined,undefined,undefined,1,1);
	var_00 = "tag_glass_front";
	common_scripts\_destructible::destructible_part(var_00,undefined,40,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_00 + "_d",undefined,60,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx(var_00 + "_fx","props/car_glass_large");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_00 = "tag_center_glass";
	common_scripts\_destructible::destructible_part(var_00,undefined,40,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_00 + "_d",undefined,60,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx(var_00 + "_fx","props/car_glass_large");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_00 = "tag_glass_back";
	common_scripts\_destructible::destructible_part(var_00,undefined,40,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_00 + "_d",undefined,60,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx(var_00 + "_fx","props/car_glass_large");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_00 = "tag_glass_left_front";
	common_scripts\_destructible::destructible_part(var_00,undefined,20,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_00 + "_d",undefined,60,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx(var_00 + "_fx","props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_00 = "tag_glass_right_front";
	common_scripts\_destructible::destructible_part(var_00,undefined,20,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_00 + "_d",undefined,60,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx(var_00 + "_fx","props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_00 = "tag_glass_left_back";
	common_scripts\_destructible::destructible_part(var_00,undefined,20,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_00 + "_d",undefined,60,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx(var_00 + "_fx","props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_00 = "tag_glass_right_back";
	common_scripts\_destructible::destructible_part(var_00,undefined,20,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_00 + "_d",undefined,60,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx(var_00 + "_fx","props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_00 = "tag_glass_left_back_02";
	common_scripts\_destructible::destructible_part(var_00,undefined,20,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_00 + "_d",undefined,60,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx(var_00 + "_fx","props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_00 = "tag_glass_right_back_02";
	common_scripts\_destructible::destructible_part(var_00,undefined,20,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_00 + "_d",undefined,60,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx(var_00 + "_fx","props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_00 = "tag_light_left_front";
	common_scripts\_destructible::destructible_part(var_00,undefined,20,undefined,undefined,undefined,0.5);
	common_scripts\_destructible::destructible_fx(var_00,"props/car_glass_headlight");
	common_scripts\_destructible::destructible_sound("veh_glass_break_small");
	common_scripts\_destructible::destructible_state(var_00 + "_d");
	var_00 = "tag_light_right_front";
	common_scripts\_destructible::destructible_part(var_00,undefined,20,undefined,undefined,undefined,0.5);
	common_scripts\_destructible::destructible_fx(var_00,"props/car_glass_headlight");
	common_scripts\_destructible::destructible_sound("veh_glass_break_small");
	common_scripts\_destructible::destructible_state(var_00 + "_d");
	common_scripts\_destructible::destructible_part("tag_bumper_front",undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_part("tag_bumper_back",undefined,undefined,undefined,undefined,undefined,0.5);
	common_scripts\_destructible::destructible_part("tag_mirror_left","vehicle_london_cab_mirror_l",40,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_physics();
	common_scripts\_destructible::destructible_part("tag_mirror_right","vehicle_london_cab_mirror_r",40,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_physics();
}

//Function Number: 102
vehicle_pickup(param_00)
{
	common_scripts\_destructible::destructible_create(param_00,"tag_body",300,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_hood_fx","smoke/car_damage_whitesmoke",0.4);
	common_scripts\_destructible::destructible_state(undefined,undefined,200,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_hood_fx","smoke/car_damage_blacksmoke",0.4);
	common_scripts\_destructible::destructible_state(undefined,undefined,100,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_hood_fx","smoke/car_damage_blacksmoke_fire",0.4);
	common_scripts\_destructible::destructible_sound("fire_vehicle_flareup_med");
	common_scripts\_destructible::destructible_loopsound("fire_vehicle_med");
	common_scripts\_destructible::destructible_healthdrain(15,0.25,210,"allies");
	common_scripts\_destructible::destructible_state(undefined,undefined,300,"player_only",32,"no_melee");
	common_scripts\_destructible::destructible_loopsound("fire_vehicle_med");
	common_scripts\_destructible::destructible_state(undefined,undefined,400,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_fx("tag_death_fx","explosions/small_vehicle_explosion",0);
	common_scripts\_destructible::destructible_sound("car_explode");
	common_scripts\_destructible::destructible_explode(4000,5000,210,250,50,300,undefined,undefined,0.3,500);
	lib_0D89::func_6F6E(%F,#animtree,"setanimknob",undefined,undefined,"vehicle_80s_sedan1_destroy");
	common_scripts\_destructible::destructible_state(undefined,"vehicle_pickup_destroyed",undefined,32,"_melee");
	var_01 = "tag_hood";
	common_scripts\_destructible::destructible_part(var_01,"vehicle_pickup_hood",800,undefined,undefined,undefined,1,2.5);
	common_scripts\_destructible::destructible_part("left_wheel_01_jnt",undefined,20,undefined,undefined,"no_melee");
	lib_0D89::func_7562(%F,#animtree,"setanim");
	common_scripts\_destructible::destructible_sound("veh_tire_deflate","llet");
	common_scripts\_destructible::destructible_part("left_wheel_02_jnt",undefined,20,undefined,undefined,"no_melee");
	lib_0D89::func_7562(%F,#animtree,"setanim");
	common_scripts\_destructible::destructible_sound("veh_tire_deflate","llet");
	common_scripts\_destructible::destructible_part("right_wheel_01_jnt",undefined,20,undefined,undefined,"no_melee");
	lib_0D89::func_7562(%F,#animtree,"setanim");
	common_scripts\_destructible::destructible_sound("veh_tire_deflate","llet");
	common_scripts\_destructible::destructible_part("right_wheel_02_jnt",undefined,20,undefined,undefined,"no_melee");
	lib_0D89::func_7562(%F,#animtree,"setanim");
	common_scripts\_destructible::destructible_sound("veh_tire_deflate","llet");
	common_scripts\_destructible::destructible_part("tag_door_left_front","vehicle_pickup_door_LF",undefined,undefined,undefined,undefined,1,1);
	common_scripts\_destructible::destructible_part("tag_door_right_front","vehicle_pickup_door_RF",undefined,undefined,undefined,undefined,1,1);
	var_01 = "tag_glass_front";
	common_scripts\_destructible::destructible_part(var_01,undefined,40,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01 + "_d",undefined,60,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_front_fx","props/car_glass_large");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_glass_back";
	common_scripts\_destructible::destructible_part(var_01,undefined,40,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01 + "_d",undefined,60,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_back_fx","props/car_glass_large");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_glass_left_front";
	common_scripts\_destructible::destructible_part(var_01,undefined,20,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01 + "_d",undefined,60,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_left_front_fx","props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_glass_right_front";
	common_scripts\_destructible::destructible_part(var_01,undefined,20,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01 + "_d",undefined,60,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_right_front_fx","props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_glass_left_back";
	common_scripts\_destructible::destructible_part(var_01,undefined,20,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01 + "_d",undefined,60,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_left_back_fx","props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_glass_right_back";
	common_scripts\_destructible::destructible_part(var_01,undefined,20,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01 + "_d",undefined,60,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_right_back_fx","props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_light_left_front";
	common_scripts\_destructible::destructible_part(var_01,undefined,20,undefined,undefined,undefined,0.5);
	common_scripts\_destructible::destructible_fx(var_01,"props/car_glass_headlight");
	common_scripts\_destructible::destructible_sound("veh_glass_break_small");
	common_scripts\_destructible::destructible_state(var_01 + "_d");
	var_01 = "tag_light_right_front";
	common_scripts\_destructible::destructible_part(var_01,undefined,20,undefined,undefined,undefined,0.5);
	common_scripts\_destructible::destructible_fx(var_01,"props/car_glass_headlight");
	common_scripts\_destructible::destructible_sound("veh_glass_break_small");
	common_scripts\_destructible::destructible_state(var_01 + "_d");
	var_01 = "tag_light_left_back";
	common_scripts\_destructible::destructible_part(var_01,undefined,20);
	common_scripts\_destructible::destructible_fx(var_01,"props/car_glass_brakelight");
	common_scripts\_destructible::destructible_sound("veh_glass_break_small");
	common_scripts\_destructible::destructible_state(var_01 + "_d");
	var_01 = "tag_light_right_back";
	common_scripts\_destructible::destructible_part(var_01,undefined,20);
	common_scripts\_destructible::destructible_fx(var_01,"props/car_glass_brakelight");
	common_scripts\_destructible::destructible_sound("veh_glass_break_small");
	common_scripts\_destructible::destructible_state(var_01 + "_d");
	common_scripts\_destructible::destructible_part("tag_bumper_front",undefined,undefined,undefined,undefined,undefined,1,1);
	common_scripts\_destructible::destructible_part("tag_bumper_back",undefined,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_part("tag_mirror_left","vehicle_pickup_mirror_L",40,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_physics();
	common_scripts\_destructible::destructible_part("tag_mirror_right","vehicle_pickup_mirror_R",40,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_physics();
}

//Function Number: 103
vehicle_hummer(param_00)
{
	common_scripts\_destructible::destructible_create(param_00,"tag_body",400,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_hood_fx","smoke/car_damage_whitesmoke",0.4);
	common_scripts\_destructible::destructible_state(undefined,undefined,400,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_hood_fx","smoke/car_damage_blacksmoke",0.4);
	common_scripts\_destructible::destructible_state(undefined,undefined,200,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_hood_fx","smoke/car_damage_blacksmoke_fire",0.4);
	common_scripts\_destructible::destructible_sound("fire_vehicle_flareup_med");
	common_scripts\_destructible::destructible_loopsound("fire_vehicle_med");
	common_scripts\_destructible::destructible_healthdrain(15,0.25,210,"allies");
	common_scripts\_destructible::destructible_state(undefined,undefined,300,"player_only",32,"no_melee");
	common_scripts\_destructible::destructible_loopsound("fire_vehicle_med");
	common_scripts\_destructible::destructible_state(undefined,undefined,400,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_fx("tag_deathfx","explosions/vehicle_explosion_hummer",0);
	common_scripts\_destructible::destructible_sound("car_explode");
	common_scripts\_destructible::destructible_explode(4000,5000,210,250,50,300,undefined,undefined,0.3,500);
	lib_0D89::func_6F6E(%F,#animtree,"setanimknob",undefined,undefined,"vehicle_80s_sedan1_destroy");
	common_scripts\_destructible::destructible_state(undefined,"vehicle_hummer_destroyed",undefined,32,"_melee");
	common_scripts\_destructible::destructible_part("left_wheel_01_jnt",undefined,20,undefined,undefined,"no_melee");
	lib_0D89::func_7562(%F,#animtree,"setanim");
	common_scripts\_destructible::destructible_sound("veh_tire_deflate","llet");
	common_scripts\_destructible::destructible_part("left_wheel_02_jnt",undefined,20,undefined,undefined,"no_melee");
	lib_0D89::func_7562(%F,#animtree,"setanim");
	common_scripts\_destructible::destructible_sound("veh_tire_deflate","llet");
	common_scripts\_destructible::destructible_part("right_wheel_01_jnt",undefined,20,undefined,undefined,"no_melee");
	lib_0D89::func_7562(%F,#animtree,"setanim");
	common_scripts\_destructible::destructible_sound("veh_tire_deflate","llet");
	common_scripts\_destructible::destructible_part("right_wheel_02_jnt",undefined,20,undefined,undefined,"no_melee");
	lib_0D89::func_7562(%F,#animtree,"setanim");
	common_scripts\_destructible::destructible_sound("veh_tire_deflate","llet");
	var_01 = "tag_glass_front";
	common_scripts\_destructible::destructible_part(var_01,undefined,40,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01 + "_d",undefined,60,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_front_fx","props/car_glass_large");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_glass_left_front";
	common_scripts\_destructible::destructible_part(var_01,undefined,20,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01 + "_d",undefined,60,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_left_front_fx","props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_glass_right_front";
	common_scripts\_destructible::destructible_part(var_01,undefined,20,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01 + "_d",undefined,60,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_right_front_fx","props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_glass_left_back";
	common_scripts\_destructible::destructible_part(var_01,undefined,20,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01 + "_d",undefined,60,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_left_back_fx","props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_glass_right_back";
	common_scripts\_destructible::destructible_part(var_01,undefined,20,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01 + "_d",undefined,60,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_right_back_fx","props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
}

//Function Number: 104
vehicle_t72(param_00)
{
	common_scripts\_destructible::destructible_create(param_00,"tag_body",400,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_hood_fx","smoke/car_damage_whitesmoke",0.4);
	common_scripts\_destructible::destructible_state(undefined,undefined,400,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_hood_fx","smoke/car_damage_blacksmoke",0.4);
	common_scripts\_destructible::destructible_state(undefined,undefined,200,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_hood_fx","smoke/car_damage_blacksmoke_fire_gaz",0.4);
	common_scripts\_destructible::destructible_sound("fire_vehicle_flareup_med");
	common_scripts\_destructible::destructible_loopsound("fire_vehicle_med");
	common_scripts\_destructible::destructible_healthdrain(15,0.25,210,"allies");
	common_scripts\_destructible::destructible_state(undefined,undefined,300,"player_only",32,"no_melee");
	common_scripts\_destructible::destructible_loopsound("fire_vehicle_med");
	common_scripts\_destructible::destructible_state(undefined,undefined,400,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_fx("tag_deathfx","explosions/vehicle_explosion_gaz",0);
	common_scripts\_destructible::destructible_sound("car_explode");
	common_scripts\_destructible::destructible_explode(4000,5000,210,250,50,300,undefined,undefined,0.3,500);
	lib_0D89::func_6F6E(%F,#animtree,"setanimknob",undefined,undefined,"vehicle_80s_sedan1_destroy");
	common_scripts\_destructible::destructible_state(undefined,"vehicle_gaz_tigr_harbor_destroyed",undefined,32,"_melee");
	common_scripts\_destructible::destructible_part("left_wheel_01_jnt",undefined,20,undefined,undefined,"no_melee");
	lib_0D89::func_7562(%F,#animtree,"setanim");
	common_scripts\_destructible::destructible_sound("veh_tire_deflate","llet");
	common_scripts\_destructible::destructible_part("left_wheel_02_jnt",undefined,20,undefined,undefined,"no_melee");
	lib_0D89::func_7562(%F,#animtree,"setanim");
	common_scripts\_destructible::destructible_sound("veh_tire_deflate","llet");
	common_scripts\_destructible::destructible_part("right_wheel_01_jnt",undefined,20,undefined,undefined,"no_melee");
	lib_0D89::func_7562(%F,#animtree,"setanim");
	common_scripts\_destructible::destructible_sound("veh_tire_deflate","llet");
	common_scripts\_destructible::destructible_part("right_wheel_02_jnt",undefined,20,undefined,undefined,"no_melee");
	lib_0D89::func_7562(%F,#animtree,"setanim");
	common_scripts\_destructible::destructible_sound("veh_tire_deflate","llet");
	var_01 = "tag_glass_front";
	common_scripts\_destructible::destructible_part(var_01,undefined,40,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01 + "_d",undefined,60,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_front_fx","props/car_glass_large");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_glass_left_front";
	common_scripts\_destructible::destructible_part(var_01,undefined,20,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01 + "_d",undefined,60,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_left_front_fx","props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_glass_right_front";
	common_scripts\_destructible::destructible_part(var_01,undefined,20,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01 + "_d",undefined,60,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_right_front_fx","props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_glass_left_mid";
	common_scripts\_destructible::destructible_part(var_01,undefined,20,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01 + "_d",undefined,60,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_left_mid_fx","props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_glass_right_mid";
	common_scripts\_destructible::destructible_part(var_01,undefined,20,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01 + "_d",undefined,60,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_right_mid_fx","props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_glass_left_back";
	common_scripts\_destructible::destructible_part(var_01,undefined,20,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01 + "_d",undefined,60,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_left_back_fx","props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_glass_right_back";
	common_scripts\_destructible::destructible_part(var_01,undefined,20,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01 + "_d",undefined,60,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_right_back_fx","props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_glass_back_left";
	common_scripts\_destructible::destructible_part(var_01,undefined,20,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01 + "_d",undefined,60,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_back_left_fx","props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_glass_back_right";
	common_scripts\_destructible::destructible_part(var_01,undefined,20,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01 + "_d",undefined,60,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_back_right_fx","props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
}

//Function Number: 105
vehicle_btr(param_00)
{
	common_scripts\_destructible::destructible_create(param_00,"tag_body",100,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_hood_fx","smoke/car_damage_whitesmoke_moving",0.1);
	common_scripts\_destructible::destructible_state(undefined,undefined,400,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_hood_fx","smoke/car_damage_blacksmoke_fire_gaz_moving",0.4);
	common_scripts\_destructible::destructible_sound("fire_vehicle_flareup_med");
	common_scripts\_destructible::destructible_loopsound("fire_vehicle_med");
	common_scripts\_destructible::destructible_healthdrain(25,0.25,210,"allies");
	common_scripts\_destructible::destructible_state(undefined,undefined,1000,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_fx("tag_deathfx","explosions/vehicle_explosion_gaz",0);
	common_scripts\_destructible::destructible_sound("car_explode");
	common_scripts\_destructible::destructible_explode(4000,5000,210,250,50,300,undefined,undefined,0.3,500);
	common_scripts\_destructible::destructible_state(undefined,"vehicle_gaz_tigr_paris_destroyed",undefined,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_part("tag_frontbumper",undefined,50,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_hood_fx","props/vehicle_gaz_frontBumper",0);
	common_scripts\_destructible::destructible_loopfx("tag_hood_fx","smoke/car_damage_blacksmoke_moving",0.1);
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_glass_front";
	common_scripts\_destructible::destructible_part(var_01,undefined,40,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01 + "_d",undefined,10,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_front_fx","props/car_glass_large_moving");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_glass_left_front";
	common_scripts\_destructible::destructible_part(var_01,undefined,20,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01 + "_d",undefined,60,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_left_front_fx","props/car_glass_med_moving");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_glass_right_front";
	common_scripts\_destructible::destructible_part(var_01,undefined,20,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01 + "_d",undefined,60,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_right_front_fx","props/car_glass_med_moving");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_glass_left_mid";
	common_scripts\_destructible::destructible_part(var_01,undefined,20,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01 + "_d",undefined,60,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_left_mid_fx","props/car_glass_med_moving");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_glass_right_mid";
	common_scripts\_destructible::destructible_part(var_01,undefined,20,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01 + "_d",undefined,60,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_right_mid_fx","props/car_glass_med_moving");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_glass_left_back";
	common_scripts\_destructible::destructible_part(var_01,undefined,20,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01 + "_d",undefined,60,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_left_back_fx","props/car_glass_med_moving");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_glass_right_back";
	common_scripts\_destructible::destructible_part(var_01,undefined,20,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01 + "_d",undefined,60,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_right_back_fx","props/car_glass_med_moving");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_glass_back_left";
	common_scripts\_destructible::destructible_part(var_01,undefined,20,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01 + "_d",undefined,60,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_back_left_fx","props/car_glass_med_moving");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_glass_back_right";
	common_scripts\_destructible::destructible_part(var_01,undefined,20,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01 + "_d",undefined,60,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_back_right_fx","props/car_glass_med_moving");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
}

//Function Number: 106
vehicle_gaz(param_00,param_01)
{
	common_scripts\_destructible::destructible_create(param_00,"tag_body",300,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_hood_fx","smoke/car_damage_whitesmoke",0.4);
	common_scripts\_destructible::destructible_state(undefined,undefined,200,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_hood_fx","smoke/car_damage_blacksmoke",0.4);
	common_scripts\_destructible::destructible_state(undefined,undefined,100,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_hood_fx","smoke/car_damage_blacksmoke_fire",0.4);
	common_scripts\_destructible::destructible_sound("fire_vehicle_flareup_med");
	common_scripts\_destructible::destructible_loopsound("fire_vehicle_med");
	common_scripts\_destructible::destructible_healthdrain(15,0.25,210,"allies");
	common_scripts\_destructible::destructible_state(undefined,undefined,300,"player_only",32,"no_melee");
	common_scripts\_destructible::destructible_loopsound("fire_vehicle_med");
	common_scripts\_destructible::destructible_state(undefined,undefined,400,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_fx("tag_deathfx","explosions/small_vehicle_explosion",0);
	common_scripts\_destructible::destructible_sound("car_explode");
	common_scripts\_destructible::destructible_explode(4000,5000,210,250,50,300,undefined,undefined,0.3,500);
	lib_0D89::func_6F6E(%F,#animtree,"setanimknob",undefined,undefined,"vehicle_80s_sedan1_destroy");
	common_scripts\_destructible::destructible_state(undefined,param_01,undefined,32,"_melee");
	common_scripts\_destructible::destructible_part("left_wheel_01_jnt",undefined,20,undefined,undefined,"no_melee");
	lib_0D89::func_7562(%F,#animtree,"setanim");
	common_scripts\_destructible::destructible_sound("veh_tire_deflate","llet");
	common_scripts\_destructible::destructible_part("left_wheel_02_jnt",undefined,20,undefined,undefined,"no_melee");
	lib_0D89::func_7562(%F,#animtree,"setanim");
	common_scripts\_destructible::destructible_sound("veh_tire_deflate","llet");
	common_scripts\_destructible::destructible_part("right_wheel_01_jnt",undefined,20,undefined,undefined,"no_melee");
	lib_0D89::func_7562(%F,#animtree,"setanim");
	common_scripts\_destructible::destructible_sound("veh_tire_deflate","llet");
	common_scripts\_destructible::destructible_part("right_wheel_02_jnt",undefined,20,undefined,undefined,"no_melee");
	lib_0D89::func_7562(%F,#animtree,"setanim");
	common_scripts\_destructible::destructible_sound("veh_tire_deflate","llet");
	var_02 = "tag_glass_front";
	common_scripts\_destructible::destructible_part(var_02,undefined,40,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_02 + "_d",undefined,60,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_front_fx","props/car_glass_large");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_02 = "tag_glass_back";
	common_scripts\_destructible::destructible_part(var_02,undefined,40,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_02 + "_d",undefined,60,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_back_fx","props/car_glass_large");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_02 = "tag_glass_left_front";
	common_scripts\_destructible::destructible_part(var_02,undefined,20,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_02 + "_d",undefined,60,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_left_front_fx","props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_02 = "tag_glass_right_front";
	common_scripts\_destructible::destructible_part(var_02,undefined,20,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_02 + "_d",undefined,60,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_right_front_fx","props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
}

//Function Number: 107
vehicle_gaz_harbor(param_00)
{
	common_scripts\_destructible::destructible_create(param_00,"tag_body",300,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_hood_fx","smoke/car_damage_whitesmoke",0.4);
	common_scripts\_destructible::destructible_state(undefined,undefined,200,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_hood_fx","smoke/car_damage_blacksmoke",0.4);
	common_scripts\_destructible::destructible_state(undefined,undefined,100,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_hood_fx","smoke/car_damage_blacksmoke_fire",0.4);
	common_scripts\_destructible::destructible_sound("fire_vehicle_flareup_med");
	common_scripts\_destructible::destructible_loopsound("fire_vehicle_med");
	common_scripts\_destructible::destructible_healthdrain(15,0.25,210,"allies");
	common_scripts\_destructible::destructible_state(undefined,undefined,300,"player_only",32,"no_melee");
	common_scripts\_destructible::destructible_loopsound("fire_vehicle_med");
	common_scripts\_destructible::destructible_state(undefined,undefined,400,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_fx("tag_death_fx","explosions/vehicle_explosion_medium",0);
	common_scripts\_destructible::destructible_sound("car_explode");
	common_scripts\_destructible::destructible_explode(4000,5000,210,250,50,300,undefined,undefined,0.3,500);
	lib_0D89::func_6576(%F,#animtree,"setanimknob",undefined,undefined,"vehicle_80s_sedan1_destroy");
	if(param_00 == "hicle_moving_truck")
	{
		common_scripts\_destructible::destructible_state(undefined,"vehicle_moving_truck_dst",undefined,32,"no_melee");
	}
	else
	{
		common_scripts\_destructible::destructible_state(undefined,"vehicle_moving_truck_thai_dst",undefined,32,"no_melee");
	}

	common_scripts\_destructible::destructible_part("left_wheel_01_jnt",undefined,20,undefined,undefined,"no_melee");
	lib_0D89::func_7562(%F,#animtree,"setanim");
	common_scripts\_destructible::destructible_sound("veh_tire_deflate","llet");
	common_scripts\_destructible::destructible_part("left_wheel_02_jnt",undefined,20,undefined,undefined,"no_melee");
	lib_0D89::func_7562(%F,#animtree,"setanim");
	common_scripts\_destructible::destructible_sound("veh_tire_deflate","llet");
	common_scripts\_destructible::destructible_part("right_wheel_01_jnt",undefined,20,undefined,undefined,"no_melee");
	lib_0D89::func_7562(%F,#animtree,"setanim");
	common_scripts\_destructible::destructible_sound("veh_tire_deflate","llet");
	common_scripts\_destructible::destructible_part("right_wheel_02_jnt",undefined,20,undefined,undefined,"no_melee");
	lib_0D89::func_7562(%F,#animtree,"setanim");
	common_scripts\_destructible::destructible_sound("veh_tire_deflate","llet");
	var_01 = "tag_glass_front";
	common_scripts\_destructible::destructible_part(var_01,undefined,40,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01 + "_d",undefined,60,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_front_fx","props/car_glass_large");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_glass_left_front";
	common_scripts\_destructible::destructible_part(var_01,undefined,20,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01 + "_d",undefined,60,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_left_front_fx","props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_glass_right_front";
	common_scripts\_destructible::destructible_part(var_01,undefined,20,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01 + "_d",undefined,60,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_right_front_fx","props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
}

//Function Number: 108
vehicle_bm21(param_00)
{
	common_scripts\_destructible::destructible_create(param_00,"tag_origin",undefined,undefined,32,"no_melee");
	vehicle_moving_truck("TAG_WINDOW_SMALL_02_RI",1,"props/car_glass_subway_tall");
	vehicle_moving_truck("TAG_WINDOW_SMALL_03_RI",1,"props/car_glass_subway_tall");
	vehicle_moving_truck("TAG_WINDOW_SMALL_04_RI",1,"props/car_glass_subway_tall");
	vehicle_moving_truck("TAG_WINDOW_SMALL_05_RI",1,"props/car_glass_subway_tall");
	vehicle_moving_truck("TAG_WINDOW_SMALL_02_LE",1,"props/car_glass_subway_tall");
	vehicle_moving_truck("TAG_WINDOW_SMALL_03_LE",1,"props/car_glass_subway_tall");
	vehicle_moving_truck("TAG_WINDOW_SMALL_04_LE",1,"props/car_glass_subway_tall");
	vehicle_moving_truck("TAG_WINDOW_SMALL_05_LE",1,"props/car_glass_subway_tall");
}

//Function Number: 109
vehicle_moving_truck(param_00,param_01,param_02)
{
	common_scripts\_destructible::destructible_part(param_00,undefined,140,undefined,undefined,undefined,undefined,undefined,1);
	if(param_01)
	{
		common_scripts\_destructible::destructible_state(param_00 + "_D",undefined,80,undefined,undefined,undefined,1);
	}

	common_scripts\_destructible::destructible_fx(param_00,param_02);
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
}

//Function Number: 110
vehicle_subway_cart(param_00)
{
	common_scripts\_destructible::destructible_create(param_00,"tag_origin",undefined,undefined,32,"no_melee");
	vehicle_moving_truck("TAG_FRONT_WINDOW",1,"props/car_glass_subway_tall");
	vehicle_moving_truck("TAG_WINDOW_01_LE",1,"props/car_glass_subway_large");
	vehicle_moving_truck("TAG_WINDOW_03_LE",1,"props/car_glass_subway_large");
	vehicle_moving_truck("TAG_WINDOW_04_LE",1,"props/car_glass_subway_large");
	vehicle_moving_truck("TAG_WINDOW_07_LE",1,"props/car_glass_subway_large");
	vehicle_moving_truck("TAG_WINDOW_08_LE",1,"props/car_glass_subway_large");
	vehicle_moving_truck("TAG_WINDOW_011_LE",1,"props/car_glass_subway_large");
	vehicle_moving_truck("TAG_WINDOW_012_LE",1,"props/car_glass_subway_large");
	vehicle_moving_truck("TAG_WINDOW_014_LE",1,"props/car_glass_subway_tall");
	vehicle_moving_truck("TAG_WINDOW_01_RI",1,"props/car_glass_subway_large");
	vehicle_moving_truck("TAG_WINDOW_03_RI",1,"props/car_glass_subway_large");
	vehicle_moving_truck("TAG_WINDOW_04_RI",1,"props/car_glass_subway_large");
	vehicle_moving_truck("TAG_WINDOW_07_RI",1,"props/car_glass_subway_large");
	vehicle_moving_truck("TAG_WINDOW_08_RI",1,"props/car_glass_subway_large");
	vehicle_moving_truck("TAG_WINDOW_011_RI",1,"props/car_glass_subway_large");
	vehicle_moving_truck("TAG_WINDOW_012_RI",1,"props/car_glass_subway_large");
	vehicle_moving_truck("TAG_WINDOW_014_RI",1,"props/car_glass_subway_tall");
}

//Function Number: 111
create_vehicle_subway_cart_window_single(param_00)
{
	common_scripts\_destructible::destructible_create(param_00,"tag_origin",undefined,undefined,32,"no_melee");
	vehicle_moving_truck("TAG_WINDOW_SMALL_01_LE",1,"props/car_glass_subway_large");
	vehicle_moving_truck("TAG_WINDOW_SMALL_06_LE",1,"props/car_glass_subway_large");
	vehicle_moving_truck("TAG_WINDOW_SMALL_01_RI",1,"props/car_glass_subway_large");
	vehicle_moving_truck("TAG_WINDOW_SMALL_06_RI",1,"props/car_glass_subway_large");
}

//Function Number: 112
vehicle_subway_cart_windows(param_00)
{
	common_scripts\_destructible::destructible_create("vehicle_luxurysedan_2008" + param_00,"tag_body",250,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_hood_fx","smoke/car_damage_whitesmoke",0.4);
	common_scripts\_destructible::destructible_car_alarm();
	common_scripts\_destructible::destructible_state(undefined,undefined,200,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_hood_fx","smoke/car_damage_blacksmoke",0.4);
	common_scripts\_destructible::destructible_state(undefined,undefined,100,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_hood_fx","smoke/car_damage_blacksmoke_fire",0.4);
	common_scripts\_destructible::destructible_sound("fire_vehicle_flareup_med");
	common_scripts\_destructible::destructible_loopsound("fire_vehicle_med");
	common_scripts\_destructible::destructible_healthdrain(15,0.25,210,"allies");
	common_scripts\_destructible::destructible_state(undefined,undefined,300,"player_only",32,"no_melee");
	common_scripts\_destructible::destructible_loopsound("fire_vehicle_med");
	common_scripts\_destructible::destructible_state(undefined,undefined,400,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_fx("tag_death_fx","explosions/small_vehicle_explosion",0);
	common_scripts\_destructible::destructible_sound("car_explode");
	common_scripts\_destructible::destructible_explode(4000,5000,210,250,50,300,undefined,undefined,0.3,500);
	lib_0D89::func_6F6E(%F,#animtree,"setanimknob",undefined,undefined,"vehicle_80s_sedan1_destroy");
	common_scripts\_destructible::destructible_state(undefined,"vehicle_luxurysedan_2008" + param_00 + "_destroy",undefined,32,"_melee");
	var_01 = "tag_hood";
	common_scripts\_destructible::destructible_part(var_01,"vehicle_luxurysedan_2008" + param_00 + "_hood",800,undefined,undefined,undefined,1,2.5);
	common_scripts\_destructible::destructible_part("left_wheel_01_jnt","vehicle_luxurysedan_2008" + param_00 + "_wheel_LF",20,undefined,undefined,"no_melee",undefined,1.7);
	lib_0D89::func_7562(%F,#animtree,"setanim");
	common_scripts\_destructible::destructible_sound("veh_tire_deflate","llet");
	common_scripts\_destructible::destructible_car_alarm();
	common_scripts\_destructible::destructible_part("left_wheel_02_jnt","vehicle_luxurysedan_2008" + param_00 + "_wheel_LF",20,undefined,undefined,"no_melee",undefined,1.7);
	lib_0D89::func_7562(%F,#animtree,"setanim");
	common_scripts\_destructible::destructible_sound("veh_tire_deflate","llet");
	common_scripts\_destructible::destructible_car_alarm();
	common_scripts\_destructible::destructible_part("right_wheel_01_jnt","vehicle_luxurysedan_2008" + param_00 + "_wheel_LF",20,undefined,undefined,"no_melee",undefined,1.7);
	lib_0D89::func_7562(%F,#animtree,"setanim");
	common_scripts\_destructible::destructible_sound("veh_tire_deflate","llet");
	common_scripts\_destructible::destructible_car_alarm();
	common_scripts\_destructible::destructible_part("right_wheel_02_jnt","vehicle_luxurysedan_2008" + param_00 + "_wheel_LF",20,undefined,undefined,"no_melee",undefined,1.7);
	lib_0D89::func_7562(%F,#animtree,"setanim");
	common_scripts\_destructible::destructible_sound("veh_tire_deflate","llet");
	common_scripts\_destructible::destructible_car_alarm();
	common_scripts\_destructible::destructible_part("tag_door_left_front","vehicle_luxurysedan_2008" + param_00 + "_door_LF",undefined,undefined,undefined,undefined,1,1);
	common_scripts\_destructible::destructible_part("tag_door_right_front","vehicle_luxurysedan_2008" + param_00 + "_door_RF",undefined,undefined,undefined,undefined,1,1);
	common_scripts\_destructible::destructible_part("tag_door_left_back","vehicle_luxurysedan_2008" + param_00 + "_door_LB",undefined,undefined,undefined,undefined,1,1);
	common_scripts\_destructible::destructible_part("tag_door_right_back","vehicle_luxurysedan_2008" + param_00 + "_door_RB",undefined,undefined,undefined,undefined,1,1);
	var_01 = "tag_glass_front";
	common_scripts\_destructible::destructible_part(var_01,undefined,40,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01 + "_d",undefined,60,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_front_fx","props/car_glass_large");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_car_alarm();
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_glass_back";
	common_scripts\_destructible::destructible_part(var_01,undefined,40,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01 + "_d",undefined,60,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_back_fx","props/car_glass_large");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_car_alarm();
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_glass_left_front";
	common_scripts\_destructible::destructible_part(var_01,undefined,20,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01 + "_d",undefined,60,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_left_front_fx","props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_car_alarm();
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_glass_right_front";
	common_scripts\_destructible::destructible_part(var_01,undefined,20,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01 + "_d",undefined,60,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_right_front_fx","props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_car_alarm();
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_glass_left_back";
	common_scripts\_destructible::destructible_part(var_01,undefined,20,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01 + "_d",undefined,60,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_left_back_fx","props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_car_alarm();
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_glass_right_back";
	common_scripts\_destructible::destructible_part(var_01,undefined,20,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01 + "_d",undefined,60,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_right_back_fx","props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_car_alarm();
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_light_left_front";
	common_scripts\_destructible::destructible_part(var_01,undefined,20,undefined,undefined,undefined,0.5);
	common_scripts\_destructible::destructible_fx(var_01,"props/car_glass_headlight");
	common_scripts\_destructible::destructible_sound("veh_glass_break_small");
	common_scripts\_destructible::destructible_state(var_01 + "_d");
	var_01 = "tag_light_right_front";
	common_scripts\_destructible::destructible_part(var_01,undefined,20,undefined,undefined,undefined,0.5);
	common_scripts\_destructible::destructible_fx(var_01,"props/car_glass_headlight");
	common_scripts\_destructible::destructible_sound("veh_glass_break_small");
	common_scripts\_destructible::destructible_state(var_01 + "_d");
	common_scripts\_destructible::destructible_part("tag_mirror_left","vehicle_luxurysedan_2008" + param_00 + "_mirror_L",40,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_physics();
	common_scripts\_destructible::destructible_part("tag_mirror_right","vehicle_luxurysedan_2008" + param_00 + "_mirror_R",40,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_physics();
}

//Function Number: 113
vehicle_subway_cart_windows_small(param_00)
{
	common_scripts\_destructible::destructible_create(param_00,"TAG_ORIGIN",250,undefined,32,"splash");
	common_scripts\_destructible::destructible_splash_damage_scaler(11);
	common_scripts\_destructible::destructible_loopfx("TAG_front_fire","smoke/car_damage_whitesmoke",0.4);
	common_scripts\_destructible::destructible_loopfx("TAG_rear_fire","smoke/car_damage_whitesmoke",0.4);
	common_scripts\_destructible::destructible_state(undefined,undefined,200,undefined,32,"splash");
	common_scripts\_destructible::destructible_loopfx("TAG_front_fire","smoke/car_damage_blacksmoke",0.4);
	common_scripts\_destructible::destructible_loopfx("TAG_rear_fire","smoke/car_damage_blacksmoke",0.4);
	common_scripts\_destructible::destructible_state(undefined,undefined,100,undefined,32,"splash");
	common_scripts\_destructible::destructible_loopfx("TAG_front_fire","smoke/airplane_damage_blacksmoke_fire",0.4);
	common_scripts\_destructible::destructible_loopfx("TAG_rear_fire","smoke/airplane_damage_blacksmoke_fire",0.4);
	common_scripts\_destructible::destructible_sound("fire_vehicle_flareup_med");
	common_scripts\_destructible::destructible_loopsound("fire_vehicle_med");
	common_scripts\_destructible::destructible_healthdrain(15,0.25,512,"allies");
	common_scripts\_destructible::destructible_state(undefined,undefined,300,"player_only",32,"splash");
	common_scripts\_destructible::destructible_loopsound("fire_vehicle_med");
	common_scripts\_destructible::destructible_state(undefined,undefined,400,undefined,32,"splash");
	common_scripts\_destructible::destructible_fx("TAG_FX","explosions/vehicle_explosion_mig29",0);
	common_scripts\_destructible::destructible_sound("car_explode");
	common_scripts\_destructible::destructible_explode(8000,10000,512,512,50,300,undefined,undefined,0.4,1000);
	lib_0D89::func_7073(%F,#animtree,"setanimknob",undefined,undefined,"vehicle_mig29_destroy");
	common_scripts\_destructible::destructible_state(undefined,"vehicle_mig29_v2_dest",undefined,32,"lash");
	common_scripts\_destructible::destructible_part("TAG_COCKPIT","vehicle_mig29_dest_cockpit",40,undefined,undefined,undefined,undefined,1);
}

//Function Number: 114
vehicle_luxurysedan(param_00)
{
	common_scripts\_destructible::destructible_create("vehicle_mack_truck_short_" + param_00,"tag_body",250,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_hood_fx","smoke/car_damage_whitesmoke",0.4);
	common_scripts\_destructible::destructible_state(undefined,undefined,200,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_hood_fx","smoke/car_damage_blacksmoke",0.4);
	common_scripts\_destructible::destructible_state(undefined,undefined,100,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_hood_fx","smoke/mack_truck_damage_blacksmoke_fire",0.4);
	common_scripts\_destructible::destructible_loopfx("tag_gastank","smoke/motorcycle_damage_blacksmoke_fire",0.4);
	common_scripts\_destructible::destructible_sound("mack_truck_flareup_med");
	common_scripts\_destructible::destructible_loopsound("mack_truck_fire_med");
	common_scripts\_destructible::destructible_healthdrain(15,0.25,300,"allies");
	common_scripts\_destructible::destructible_state(undefined,undefined,300,"player_only",32,"no_melee");
	common_scripts\_destructible::destructible_loopsound("mack_truck_fire_med");
	common_scripts\_destructible::destructible_state(undefined,undefined,400,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_gastank","smoke/motorcycle_damage_blacksmoke_fire",0.4);
	common_scripts\_destructible::destructible_fx("tag_cab_fire","fire/firelp_med_pm");
	common_scripts\_destructible::destructible_fx("tag_death_fx","explosions/propane_large_exp",0);
	common_scripts\_destructible::destructible_sound("mack_truck_explode");
	common_scripts\_destructible::destructible_loopsound("mack_truck_fire_med");
	common_scripts\_destructible::destructible_explode(8000,10000,512,512,100,400,undefined,undefined,0.4,1000);
	common_scripts\_destructible::destructible_state(undefined,"vehicle_mack_truck_short_" + param_00 + "_destroy",undefined,32,"no_melee");
	common_scripts\_destructible::destructible_part("left_wheel_01_jnt","vehicle_mack_truck_short_" + param_00 + "_wheel_lf",20,undefined,undefined,"no_melee",undefined,8);
	common_scripts\_destructible::destructible_part("left_wheel_02_jnt","vehicle_mack_truck_short_" + param_00 + "_wheel_lf",20,undefined,undefined,"no_melee",undefined,81);
	common_scripts\_destructible::destructible_part("left_wheel_03_jnt","vehicle_mack_truck_short_" + param_00 + "_wheel_lf",20,undefined,undefined,"no_melee",undefined,8);
	common_scripts\_destructible::destructible_part("tag_door_left_front","vehicle_mack_truck_short_" + param_00 + "_door_lf",undefined,undefined,undefined,undefined,1,1);
	var_01 = "tag_glass_front";
	common_scripts\_destructible::destructible_part(var_01,undefined,40,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01 + "_d",undefined,60,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_front_fx","props/car_glass_large");
	common_scripts\_destructible::destructible_sound("mack_truck_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_glass_back";
	common_scripts\_destructible::destructible_part(var_01,undefined,40,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01 + "_d",undefined,60,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_back_fx","props/car_glass_large");
	common_scripts\_destructible::destructible_sound("mack_truck_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_glass_left_front";
	common_scripts\_destructible::destructible_part(var_01,undefined,20,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01 + "_d",undefined,60,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_left_front_fx","props/car_glass_med");
	common_scripts\_destructible::destructible_sound("mack_truck_glass_break_small");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_glass_right_front";
	common_scripts\_destructible::destructible_part(var_01,undefined,20,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01 + "_d",undefined,60,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_right_front_fx","props/car_glass_med");
	common_scripts\_destructible::destructible_sound("mack_truck_glass_break_small");
	common_scripts\_destructible::destructible_state(undefined);
}

//Function Number: 115
vehicle_mig29_landed()
{
	common_scripts\_destructible::destructible_create("vehicle_semi_truck","tag_body",250,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_hood_fx","smoke/car_damage_whitesmoke",0.4);
	common_scripts\_destructible::destructible_state(undefined,undefined,200,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_hood_fx","smoke/car_damage_blacksmoke",0.4);
	common_scripts\_destructible::destructible_state(undefined,undefined,100,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_hood_fx","smoke/mack_truck_damage_blacksmoke_fire",0.4);
	common_scripts\_destructible::destructible_loopfx("tag_gastank","smoke/motorcycle_damage_blacksmoke_fire",0.4);
	common_scripts\_destructible::destructible_sound("mack_truck_flareup_med");
	common_scripts\_destructible::destructible_loopsound("mack_truck_fire_med");
	common_scripts\_destructible::destructible_healthdrain(15,0.25,300,"allies");
	common_scripts\_destructible::destructible_state(undefined,undefined,300,"player_only",32,"no_melee");
	common_scripts\_destructible::destructible_loopsound("mack_truck_fire_med");
	common_scripts\_destructible::destructible_state(undefined,undefined,400,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_gastank","smoke/motorcycle_damage_blacksmoke_fire",0.4);
	common_scripts\_destructible::destructible_fx("tag_cab_fire","fire/firelp_med_pm");
	common_scripts\_destructible::destructible_fx("tag_death_fx","explosions/propane_large_exp",0);
	common_scripts\_destructible::destructible_sound("mack_truck_explode");
	common_scripts\_destructible::destructible_loopsound("mack_truck_fire_med");
	common_scripts\_destructible::destructible_explode(8000,10000,512,512,100,400,undefined,undefined,0.4,1000);
	common_scripts\_destructible::destructible_state(undefined,"vehicle_semi_truck_destroyed",undefined,32,"no_melee");
	common_scripts\_destructible::destructible_part("left_wheel_01_jnt","vehicle_semi_truck_wheel_lf",20,undefined,undefined,"no_melee",undefined,81);
	common_scripts\_destructible::destructible_part("left_wheel_02_jnt","vehicle_semi_truck_wheel_lf",20,undefined,undefined,"no_melee",undefined,81);
	common_scripts\_destructible::destructible_part("left_wheel_03_jnt","vehicle_semi_truck_wheel_lf",20,undefined,undefined,"no_melee",undefined,81);
	common_scripts\_destructible::destructible_part("tag_door_left_front","vehicle_semi_truck_door_lf",undefined,undefined,undefined,undefined,1,1);
	var_00 = "tag_glass_front";
	common_scripts\_destructible::destructible_part(var_00,undefined,40,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_00 + "_d",undefined,60,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx(var_00 + "_fx","props/car_glass_large");
	common_scripts\_destructible::destructible_sound("mack_truck_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_00 = "tag_glass_back";
	common_scripts\_destructible::destructible_part(var_00,undefined,40,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_00 + "_d",undefined,60,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx(var_00 + "_fx","props/car_glass_large");
	common_scripts\_destructible::destructible_sound("mack_truck_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_00 = "tag_glass_left_front";
	common_scripts\_destructible::destructible_part(var_00,undefined,20,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_00 + "_d",undefined,60,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx(var_00 + "_fx","props/car_glass_large");
	common_scripts\_destructible::destructible_sound("mack_truck_glass_break_small");
	common_scripts\_destructible::destructible_state(undefined);
	var_00 = "tag_glass_right_front";
	common_scripts\_destructible::destructible_part(var_00,undefined,20,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_00 + "_d",undefined,60,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_right_front_fx","props/car_glass_med");
	common_scripts\_destructible::destructible_sound("mack_truck_glass_break_small");
	common_scripts\_destructible::destructible_state(undefined);
	var_00 = "tag_glass_left_back";
	common_scripts\_destructible::destructible_part(var_00,undefined,20,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_00 + "_d",undefined,60,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx(var_00 + "_fx","props/car_glass_large");
	common_scripts\_destructible::destructible_sound("mack_truck_glass_break_small");
	common_scripts\_destructible::destructible_state(undefined);
	var_00 = "tag_glass_right_back";
	common_scripts\_destructible::destructible_part(var_00,undefined,20,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_00 + "_d",undefined,60,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_right_front_fx","props/car_glass_med");
	common_scripts\_destructible::destructible_sound("mack_truck_glass_break_small");
	common_scripts\_destructible::destructible_state(undefined);
}

//Function Number: 116
vehicle_mack_truck_short(param_00)
{
	var_01 = undefined;
	var_01 = destructible_gaspump("vehicle_motorcycle_destroy_" + param_00);
	common_scripts\_destructible::destructible_create("vehicle_motorcycle_" + param_00,"body_animate_jnt",250,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_death_fx","smoke/car_damage_whitesmoke",0.4);
	common_scripts\_destructible::destructible_state(undefined,undefined,200,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_death_fx","smoke/car_damage_blacksmoke",0.4);
	common_scripts\_destructible::destructible_state(undefined,undefined,100,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_death_fx","smoke/motorcycle_damage_blacksmoke_fire",0.4);
	common_scripts\_destructible::destructible_sound("fire_vehicle_flareup_med");
	common_scripts\_destructible::destructible_loopsound("fire_vehicle_med");
	common_scripts\_destructible::destructible_healthdrain(15,0.25,128,"allies");
	common_scripts\_destructible::destructible_state(undefined,undefined,300,"player_only",32,"no_melee");
	common_scripts\_destructible::destructible_loopsound("fire_vehicle_med");
	common_scripts\_destructible::destructible_state(undefined,undefined,400,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_fx("tag_death_fx","explosions/small_vehicle_explosion",0);
	common_scripts\_destructible::destructible_sound("car_explode");
	common_scripts\_destructible::destructible_explode(3000,4000,128,150,50,300);
	lib_8900::func_6E0D(var_01,#animtree,"setanimknob",undefined,undefined,"vehicle_motorcycle_destroy_" + param_00);
	common_scripts\_destructible::destructible_state(undefined,"vehicle_motorcycle_" + param_00 + "_destroy",undefined,32,"o_melee");
	common_scripts\_destructible::destructible_part("front_wheel","vehicle_motorcycle_01_front_wheel_d",20,undefined,undefined,"no_melee",undefined,1.7);
	common_scripts\_destructible::destructible_part("rear_wheel","vehicle_motorcycle_01_rear_wheel_d",20,undefined,undefined,"no_melee",undefined,1.7);
}

//Function Number: 117
vehicle_semi_truck(param_00)
{
	common_scripts\_destructible::destructible_create(param_00,"tag_origin",100,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_state(undefined,undefined,100,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_engine","smoke/car_damage_blacksmoke",0.4);
	common_scripts\_destructible::destructible_state(undefined,undefined,200,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_engine","smoke/scooter_damage_blacksmoke_fire",0.4);
	common_scripts\_destructible::destructible_sound("fire_vehicle_flareup_med");
	common_scripts\_destructible::destructible_loopsound("fire_vehicle_med");
	common_scripts\_destructible::destructible_healthdrain(15,0.25,128,"allies");
	common_scripts\_destructible::destructible_state(undefined,undefined,150,"player_only",32,"no_melee");
	common_scripts\_destructible::destructible_loopsound("fire_vehicle_med");
	common_scripts\_destructible::destructible_state(undefined,undefined,400,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_fx("tag_death_fx","explosions/vehicle_explosion_scooter",0);
	common_scripts\_destructible::destructible_sound("car_explode");
	common_scripts\_destructible::destructible_explode(3000,4000,128,150,50,300);
	common_scripts\_destructible::destructible_state(undefined,"vehicle_scooter_vespa_destroyed",undefined,32,"no_melee");
}

//Function Number: 118
vehicle_motorcycle(param_00)
{
	common_scripts\_destructible::destructible_create("vehicle_subcompact_" + param_00,"tag_body",250,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_hood_fx","smoke/car_damage_whitesmoke",0.4);
	common_scripts\_destructible::destructible_state(undefined,undefined,200,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_hood_fx","smoke/car_damage_blacksmoke",0.4);
	common_scripts\_destructible::destructible_state(undefined,undefined,100,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_hood_fx","smoke/car_damage_blacksmoke_fire",0.4);
	common_scripts\_destructible::destructible_sound("fire_vehicle_flareup_med");
	common_scripts\_destructible::destructible_loopsound("fire_vehicle_med");
	common_scripts\_destructible::destructible_healthdrain(12,0.2,150,"allies");
	common_scripts\_destructible::destructible_state(undefined,undefined,300,"player_only",32,"no_melee");
	common_scripts\_destructible::destructible_loopsound("fire_vehicle_med");
	common_scripts\_destructible::destructible_state(undefined,undefined,400,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_fx("tag_death_fx","explosions/small_vehicle_explosion",0);
	common_scripts\_destructible::destructible_sound("car_explode");
	common_scripts\_destructible::destructible_explode(4000,5000,150,250,50,300,undefined,0,0.3,500);
	lib_0D89::func_6F6E(%F,#animtree,"setanimknob",undefined,undefined,"vehicle_80s_sedan1_destroy");
	common_scripts\_destructible::destructible_state(undefined,"vehicle_subcompact_" + param_00 + "_destroyed",undefined,32,"_melee");
	common_scripts\_destructible::destructible_part("left_wheel_01_jnt",undefined,20,undefined,undefined,"no_melee");
	lib_0D89::func_7562(%F,#animtree,"setanim");
	common_scripts\_destructible::destructible_sound("veh_tire_deflate","llet");
	common_scripts\_destructible::destructible_part("right_wheel_01_jnt",undefined,20,undefined,undefined,"no_melee");
	lib_0D89::func_7562(%F,#animtree,"setanim");
	common_scripts\_destructible::destructible_sound("veh_tire_deflate","llet");
	common_scripts\_destructible::destructible_part("left_wheel_02_jnt","vehicle_subcompact_wheel_lf",20,undefined,undefined,"no_melee",undefined,1.7);
	lib_0D89::func_7562(%F,#animtree,"setanim");
	common_scripts\_destructible::destructible_sound("veh_tire_deflate","llet");
	common_scripts\_destructible::destructible_part("right_wheel_02_jnt","vehicle_subcompact_wheel_lf",20,undefined,undefined,"no_melee",undefined,2.3);
	lib_0D89::func_7562(%F,#animtree,"setanim");
	common_scripts\_destructible::destructible_sound("veh_tire_deflate","llet");
	common_scripts\_destructible::destructible_part("tag_door_left_back","vehicle_subcompact_" + param_00 + "_door_LB",undefined,undefined,undefined,undefined,1,1);
	common_scripts\_destructible::destructible_part("tag_door_right_back","vehicle_subcompact_" + param_00 + "_door_RB",undefined,undefined,undefined,undefined,1,1);
	var_01 = "tag_glass_front";
	common_scripts\_destructible::destructible_part(var_01,undefined,40,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01 + "_d",undefined,60,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_front_fx","props/car_glass_large");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_glass_back";
	common_scripts\_destructible::destructible_part(var_01,undefined,40,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01 + "_d",undefined,60,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_back_fx","props/car_glass_large");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_glass_left_front";
	common_scripts\_destructible::destructible_part(var_01,undefined,20,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01 + "_d",undefined,60,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_left_front_fx","props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_glass_right_front";
	common_scripts\_destructible::destructible_part(var_01,undefined,20,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01 + "_d",undefined,60,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_right_front_fx","props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_glass_left_back";
	common_scripts\_destructible::destructible_part(var_01,undefined,20,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01 + "_d",undefined,60,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_left_back_fx","props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_glass_right_back";
	common_scripts\_destructible::destructible_part(var_01,undefined,20,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01 + "_d",undefined,60,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_right_back_fx","props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_light_left_front";
	common_scripts\_destructible::destructible_part(var_01,undefined,20,undefined,undefined,undefined,0.5);
	common_scripts\_destructible::destructible_fx(var_01,"props/car_glass_headlight");
	common_scripts\_destructible::destructible_sound("veh_glass_break_small");
	common_scripts\_destructible::destructible_state(var_01 + "_d");
	var_01 = "tag_light_right_front";
	common_scripts\_destructible::destructible_part(var_01,undefined,20,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01 + "_d",undefined,60,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx(var_01,"props/car_glass_headlight");
	common_scripts\_destructible::destructible_sound("veh_glass_break_small");
	common_scripts\_destructible::destructible_state(var_01 + "_d");
	common_scripts\_destructible::destructible_part("tag_mirror_left","vehicle_subcompact_" + param_00 + "_mirror_L",40,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_physics();
	common_scripts\_destructible::destructible_part("tag_mirror_right","vehicle_subcompact_" + param_00 + "_mirror_R",40,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_physics();
}

//Function Number: 119
vehicle_scooter(param_00)
{
	common_scripts\_destructible::destructible_create("vehicle_van_" + param_00,"tag_body",250,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_hood_fx","smoke/car_damage_whitesmoke",0.4);
	common_scripts\_destructible::destructible_state(undefined,undefined,200,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_hood_fx","smoke/car_damage_blacksmoke",0.4);
	common_scripts\_destructible::destructible_state(undefined,undefined,100,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_hood_fx","smoke/car_damage_blacksmoke_fire",0.4);
	common_scripts\_destructible::destructible_sound("fire_vehicle_flareup_med");
	common_scripts\_destructible::destructible_loopsound("fire_vehicle_med");
	common_scripts\_destructible::destructible_healthdrain(12,0.2,210,"allies");
	common_scripts\_destructible::destructible_state(undefined,undefined,300,"player_only",32,"no_melee");
	common_scripts\_destructible::destructible_loopsound("fire_vehicle_med");
	common_scripts\_destructible::destructible_state(undefined,undefined,400,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_fx("tag_death_fx","explosions/small_vehicle_explosion",0);
	common_scripts\_destructible::destructible_sound("car_explode");
	common_scripts\_destructible::destructible_explode(4000,5000,200,250,50,300,undefined,undefined,0.3,500);
	lib_0D89::func_6F6E(%F,#animtree,"setanimknob",undefined,undefined,"vehicle_80s_sedan1_destroy");
	common_scripts\_destructible::destructible_state(undefined,"vehicle_van_" + param_00 + "_destroyed",undefined,32,"_melee");
	var_01 = "tag_hood";
	common_scripts\_destructible::destructible_part(var_01,"vehicle_van_" + param_00 + "_hood",undefined,undefined,undefined,undefined,1,2.5);
	common_scripts\_destructible::destructible_part("left_wheel_01_jnt","vehicle_van_wheel_lf",20,undefined,undefined,"no_melee",undefined,2.3);
	lib_0D89::func_7562(%F,#animtree,"setanim");
	common_scripts\_destructible::destructible_sound("veh_tire_deflate","llet");
	common_scripts\_destructible::destructible_part("right_wheel_01_jnt","vehicle_van_wheel_lf",20,undefined,undefined,"no_melee",undefined,2.3);
	lib_0D89::func_7562(%F,#animtree,"setanim");
	common_scripts\_destructible::destructible_sound("veh_tire_deflate","llet");
	common_scripts\_destructible::destructible_part("left_wheel_02_jnt",undefined,20,undefined,undefined,"no_melee");
	lib_0D89::func_7562(%F,#animtree,"setanim");
	common_scripts\_destructible::destructible_sound("veh_tire_deflate","llet");
	common_scripts\_destructible::destructible_part("right_wheel_02_jnt",undefined,20,undefined,undefined,"no_melee");
	lib_0D89::func_7562(%F,#animtree,"setanim");
	common_scripts\_destructible::destructible_sound("veh_tire_deflate","llet");
	common_scripts\_destructible::destructible_part("tag_door_right_back","vehicle_van_" + param_00 + "_door_RB",undefined,undefined,undefined,undefined,1,1);
	var_01 = "tag_glass_front";
	common_scripts\_destructible::destructible_part(var_01,undefined,40,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01 + "_d",undefined,60,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx(var_01 + "_fx","props/car_glass_large");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_glass_back";
	common_scripts\_destructible::destructible_part(var_01,undefined,40,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01 + "_d",undefined,60,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx(var_01 + "_fx","props/car_glass_large");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_glass_left_front";
	common_scripts\_destructible::destructible_part(var_01,undefined,20,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01 + "_d",undefined,60,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx(var_01 + "_fx","props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_glass_right_front";
	common_scripts\_destructible::destructible_part(var_01,undefined,20,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01 + "_d",undefined,60,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx(var_01 + "_fx","props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_glass_left_back";
	common_scripts\_destructible::destructible_part(var_01,undefined,20,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01 + "_d",undefined,60,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx(var_01 + "_fx","props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_glass_right_back";
	common_scripts\_destructible::destructible_part(var_01,undefined,20,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01 + "_d",undefined,60,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx(var_01 + "_fx","props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_glass_left_back_02";
	common_scripts\_destructible::destructible_part(var_01,undefined,20,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01 + "_d",undefined,60,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_left_back_02_fx","props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_glass_right_back_02";
	common_scripts\_destructible::destructible_part(var_01,undefined,20,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01 + "_d",undefined,60,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_right_back_02_fx","props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_light_left_front";
	common_scripts\_destructible::destructible_part(var_01,undefined,20,undefined,undefined,undefined,0.5);
	common_scripts\_destructible::destructible_fx(var_01,"props/car_glass_headlight");
	common_scripts\_destructible::destructible_sound("veh_glass_break_small");
	common_scripts\_destructible::destructible_state(var_01 + "_d");
	var_01 = "tag_light_right_front";
	common_scripts\_destructible::destructible_part(var_01,undefined,20,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01 + "_d",undefined,60,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx(var_01,"props/car_glass_headlight");
	common_scripts\_destructible::destructible_sound("veh_glass_break_small");
	common_scripts\_destructible::destructible_state(var_01 + "_d");
	common_scripts\_destructible::destructible_part("tag_mirror_left","vehicle_van_" + param_00 + "_mirror_L",40,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_physics();
	common_scripts\_destructible::destructible_part("tag_mirror_right","vehicle_van_" + param_00 + "_mirror_R",40,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_physics();
}

//Function Number: 120
vehicle_subcompact(param_00)
{
	common_scripts\_destructible::destructible_create(param_00,"tag_body",250,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_hood_fx","smoke/car_damage_whitesmoke",0.4);
	common_scripts\_destructible::destructible_state(undefined,undefined,200,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_hood_fx","smoke/car_damage_blacksmoke",0.4);
	common_scripts\_destructible::destructible_state(undefined,undefined,100,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_hood_fx","smoke/car_damage_blacksmoke_fire",0.4);
	common_scripts\_destructible::destructible_sound("fire_vehicle_flareup_med");
	common_scripts\_destructible::destructible_loopsound("fire_vehicle_med");
	common_scripts\_destructible::destructible_healthdrain(12,0.2,210,"allies");
	common_scripts\_destructible::destructible_state(undefined,undefined,300,"player_only",32,"no_melee");
	common_scripts\_destructible::destructible_loopsound("fire_vehicle_med");
	common_scripts\_destructible::destructible_state(undefined,undefined,400,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_fx("tag_death_fx","explosions/small_vehicle_explosion",0);
	common_scripts\_destructible::destructible_sound("car_explode");
	common_scripts\_destructible::destructible_explode(4000,5000,200,250,50,300,undefined,undefined,0.3,500);
	lib_0D89::func_6F6E(%F,#animtree,"setanimknob",undefined,undefined,"vehicle_80s_sedan1_destroy");
	common_scripts\_destructible::destructible_state(undefined,"vehicle_uaz_van_destroyed",undefined,32,"_melee");
	common_scripts\_destructible::destructible_part("left_wheel_01_jnt","vehicle_uaz_van_wheel_lf",20,undefined,undefined,"no_melee",undefined,2.3);
	lib_0D89::func_7562(%F,#animtree,"setanim");
	common_scripts\_destructible::destructible_sound("veh_tire_deflate","llet");
	common_scripts\_destructible::destructible_part("right_wheel_01_jnt",undefined,20,undefined,undefined,"no_melee");
	lib_0D89::func_7562(%F,#animtree,"setanim");
	common_scripts\_destructible::destructible_sound("veh_tire_deflate","llet");
	common_scripts\_destructible::destructible_part("left_wheel_02_jnt",undefined,20,undefined,undefined,"no_melee");
	lib_0D89::func_7562(%F,#animtree,"setanim");
	common_scripts\_destructible::destructible_sound("veh_tire_deflate","llet");
	common_scripts\_destructible::destructible_part("right_wheel_02_jnt","vehicle_uaz_van_wheel_lf",20,undefined,undefined,"no_melee",undefined,1.6);
	lib_0D89::func_7562(%F,#animtree,"setanim");
	common_scripts\_destructible::destructible_sound("veh_tire_deflate","llet");
	var_01 = "tag_glass_front";
	common_scripts\_destructible::destructible_part(var_01,undefined,40,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01 + "_d",undefined,60,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx(var_01 + "_fx","props/car_glass_large");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_glass_left_front";
	common_scripts\_destructible::destructible_part(var_01,undefined,20,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01 + "_d",undefined,60,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx(var_01 + "_fx","props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_glass_right_front";
	common_scripts\_destructible::destructible_part(var_01,undefined,20,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01 + "_d",undefined,60,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx(var_01 + "_fx","props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_glass_left_back";
	common_scripts\_destructible::destructible_part(var_01,undefined,20,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01 + "_d",undefined,60,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx(var_01 + "_fx","props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_glass_right_back";
	common_scripts\_destructible::destructible_part(var_01,undefined,20,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01 + "_d",undefined,60,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx(var_01 + "_fx","props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
}

//Function Number: 121
vehicle_van(param_00)
{
	common_scripts\_destructible::destructible_create(param_00 + "_destructable","tag_body",250,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_hood_fx","smoke/car_damage_whitesmoke",0.4);
	common_scripts\_destructible::destructible_state(undefined,undefined,200,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_hood_fx","smoke/car_damage_blacksmoke",0.4);
	common_scripts\_destructible::destructible_state(undefined,undefined,100,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_hood_fx","smoke/car_damage_blacksmoke_fire",0.4);
	common_scripts\_destructible::destructible_sound("fire_vehicle_flareup_med");
	common_scripts\_destructible::destructible_loopsound("fire_vehicle_med");
	common_scripts\_destructible::destructible_healthdrain(12,0.2,210,"allies");
	common_scripts\_destructible::destructible_state(undefined,undefined,300,"player_only",32,"no_melee");
	common_scripts\_destructible::destructible_loopsound("fire_vehicle_med");
	common_scripts\_destructible::destructible_state(undefined,undefined,400,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_fx("TAG_DEATH_FX","explosions/vehicle_explosion_medium",0);
	common_scripts\_destructible::destructible_sound("car_explode");
	common_scripts\_destructible::destructible_explode(4000,5000,200,250,50,300,undefined,undefined,0.3,500);
	lib_0D89::func_6F6E(%F,#animtree,"setanimknob",undefined,undefined,"vehicle_80s_sedan1_destroy");
	common_scripts\_destructible::destructible_state(undefined,param_00 + "_destroyed",undefined,32,"_melee");
	common_scripts\_destructible::destructible_part("left_wheel_01_jnt",param_00 + "_wheel_lf",20,undefined,undefined,"no_melee",1,1);
	lib_0D89::func_7562(%F,#animtree,"setanim");
	common_scripts\_destructible::destructible_sound("veh_tire_deflate","llet");
	common_scripts\_destructible::destructible_part("left_wheel_02_jnt",param_00 + "_wheel_lf",20,undefined,undefined,"no_melee",1,1);
	lib_0D89::func_7562(%F,#animtree,"setanim");
	common_scripts\_destructible::destructible_sound("veh_tire_deflate","llet");
	common_scripts\_destructible::destructible_part("right_wheel_01_jnt",param_00 + "_wheel_lf",20,undefined,undefined,"no_melee",1,1);
	lib_0D89::func_7562(%F,#animtree,"setanim");
	common_scripts\_destructible::destructible_sound("veh_tire_deflate","llet");
	common_scripts\_destructible::destructible_part("right_wheel_02_jnt",param_00 + "_wheel_lf",20,undefined,undefined,"no_melee",1,1);
	lib_0D89::func_7562(%F,#animtree,"setanim");
	common_scripts\_destructible::destructible_sound("veh_tire_deflate","llet");
	var_01 = "tag_glass_front";
	common_scripts\_destructible::destructible_part(var_01,undefined,40,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01 + "_d",undefined,60,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx(var_01 + "_fx","props/car_glass_large");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_glass_back";
	common_scripts\_destructible::destructible_part(var_01,undefined,40,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01 + "_d",undefined,60,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx(var_01 + "_fx","props/car_glass_large");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_glass_left_front";
	common_scripts\_destructible::destructible_part(var_01,undefined,20,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01 + "_d",undefined,60,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx(var_01 + "_fx","props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_glass_right_front";
	common_scripts\_destructible::destructible_part(var_01,undefined,20,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01 + "_d",undefined,60,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx(var_01 + "_fx","props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_light_left_front";
	common_scripts\_destructible::destructible_part(var_01,undefined,20,undefined,undefined,undefined,0.5);
	common_scripts\_destructible::destructible_fx(var_01,"props/car_glass_headlight");
	common_scripts\_destructible::destructible_sound("veh_glass_break_small");
	common_scripts\_destructible::destructible_state(var_01 + "_d");
	var_01 = "tag_light_right_front";
	common_scripts\_destructible::destructible_part(var_01,undefined,20,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01 + "_d",undefined,60,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx(var_01,"props/car_glass_headlight");
	common_scripts\_destructible::destructible_sound("veh_glass_break_small");
	common_scripts\_destructible::destructible_state(var_01 + "_d");
	var_01 = "tag_glass_left_back";
	common_scripts\_destructible::destructible_part(var_01,undefined,20,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01 + "_d",undefined,60,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx(var_01 + "_fx","props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_glass_right_back";
	common_scripts\_destructible::destructible_part(var_01,undefined,20,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01 + "_d",undefined,60,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx(var_01 + "_fx","props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	common_scripts\_destructible::destructible_part("tag_mirror_left",param_00 + "_mirror_lf",40,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_physics();
	common_scripts\_destructible::destructible_part("tag_mirror_right",param_00 + "_mirror_rf",40,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_physics();
}

//Function Number: 122
vehicle_uaz_van(param_00)
{
	common_scripts\_destructible::destructible_create(param_00,"tag_body",250,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_loopfx("TAG_HOOD_FX","smoke/car_damage_whitesmoke",0.4);
	common_scripts\_destructible::destructible_state(undefined,undefined,200,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_loopfx("TAG_HOOD_FX","smoke/car_damage_blacksmoke",0.4);
	common_scripts\_destructible::destructible_state(undefined,undefined,100,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_loopfx("TAG_HOOD_FX","smoke/car_damage_blacksmoke_fire",0.4);
	common_scripts\_destructible::destructible_sound("fire_vehicle_flareup_med");
	common_scripts\_destructible::destructible_loopsound("fire_vehicle_med");
	common_scripts\_destructible::destructible_healthdrain(12,0.2,210,"allies");
	common_scripts\_destructible::destructible_state(undefined,undefined,300,"player_only",32,"no_melee");
	common_scripts\_destructible::destructible_loopsound("fire_vehicle_med");
	common_scripts\_destructible::destructible_state(undefined,undefined,400,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_fx("TAG_DEATH_FX","explosions/vehicle_explosion_medium",0);
	common_scripts\_destructible::destructible_sound("car_explode");
	common_scripts\_destructible::destructible_explode(4000,5000,200,250,50,300,undefined,undefined,0.3,500);
	lib_0D89::func_6F6E(%F,#animtree,"setanimknob",undefined,undefined,"vehicle_80s_sedan1_destroy");
	common_scripts\_destructible::destructible_state(undefined,"vehicle_delivery_theme_park_truck_destroyed",undefined,32,"_melee");
	common_scripts\_destructible::destructible_part("left_wheel_01_jnt","vehicle_van_sas_dark_wheel_lf",20,undefined,undefined,"no_melee",1,2.7);
	lib_0D89::func_7562(%F,#animtree,"setanim");
	common_scripts\_destructible::destructible_sound("veh_tire_deflate","llet");
	common_scripts\_destructible::destructible_part("left_wheel_02_jnt",undefined,20,undefined,undefined,"no_melee",1,1);
	lib_0D89::func_7562(%F,#animtree,"setanim");
	common_scripts\_destructible::destructible_sound("veh_tire_deflate","llet");
	common_scripts\_destructible::destructible_part("right_wheel_01_jnt",undefined,20,undefined,undefined,"no_melee",1,1);
	lib_0D89::func_7562(%F,#animtree,"setanim");
	common_scripts\_destructible::destructible_sound("veh_tire_deflate","llet");
	common_scripts\_destructible::destructible_part("right_wheel_02_jnt",undefined,20,undefined,undefined,"no_melee",1,1);
	lib_0D89::func_7562(%F,#animtree,"setanim");
	common_scripts\_destructible::destructible_sound("veh_tire_deflate","llet");
	var_01 = "TAG_GLASS_FRONT1";
	common_scripts\_destructible::destructible_part(var_01,undefined,40,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01 + "_d",undefined,60,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx(var_01 + "_fx","props/car_glass_large");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "TAG_GLASS_FRONT2";
	common_scripts\_destructible::destructible_part(var_01,undefined,40,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01 + "_d",undefined,60,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx(var_01 + "_fx","props/car_glass_large");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "TAG_GLASS_LEFT_BACK";
	common_scripts\_destructible::destructible_part(var_01,undefined,40,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01 + "_d",undefined,60,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx(var_01 + "_fx","props/car_glass_large");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "TAG_GLASS_LEFT_FRONT";
	common_scripts\_destructible::destructible_part(var_01,undefined,20,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01 + "_d",undefined,60,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx(var_01 + "_fx","props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "TAG_GLASS_RIGHT_FRONT";
	common_scripts\_destructible::destructible_part(var_01,undefined,20,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01 + "_d",undefined,60,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx(var_01 + "_fx","props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "TAG_GLASS_RIGHT_BACK";
	common_scripts\_destructible::destructible_part(var_01,undefined,20,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01 + "_d",undefined,60,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx(var_01 + "_fx","props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
}

//Function Number: 123
vehicle_van_iw5(param_00,param_01)
{
	common_scripts\_destructible::destructible_create(param_00,"tag_body",250,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_hood_fx","smoke/car_damage_whitesmoke",0.4);
	common_scripts\_destructible::destructible_car_alarm();
	common_scripts\_destructible::destructible_state(undefined,undefined,200,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_hood_fx","smoke/car_damage_blacksmoke",0.4);
	common_scripts\_destructible::destructible_state(undefined,undefined,100,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_hood_fx","smoke/car_damage_blacksmoke_fire",0.4);
	common_scripts\_destructible::destructible_sound("fire_vehicle_flareup_med");
	common_scripts\_destructible::destructible_loopsound("fire_vehicle_med");
	common_scripts\_destructible::destructible_healthdrain(12,0.2,210,"allies");
	common_scripts\_destructible::destructible_state(undefined,undefined,300,"player_only",32,"no_melee");
	common_scripts\_destructible::destructible_loopsound("fire_vehicle_med");
	common_scripts\_destructible::destructible_state(undefined,undefined,400,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_fx("tag_death_fx","explosions/small_vehicle_explosion",0);
	common_scripts\_destructible::destructible_sound("car_explode");
	common_scripts\_destructible::destructible_explode(4000,5000,300,300,50,300,undefined,undefined,0.3,500);
	lib_0D89::func_6F6E(%F,#animtree,"setanimknob",undefined,undefined,"vehicle_80s_sedan1_destroy");
	common_scripts\_destructible::destructible_state(undefined,"vehicle_suburban_destroyed" + param_01,undefined,32,"_melee");
	common_scripts\_destructible::destructible_part("left_wheel_01_jnt",undefined,20,undefined,undefined,"no_melee");
	lib_0D89::func_7562(%F,#animtree,"setanim");
	common_scripts\_destructible::destructible_sound("veh_tire_deflate","llet");
	common_scripts\_destructible::destructible_car_alarm();
	common_scripts\_destructible::destructible_part("right_wheel_01_jnt","vehicle_suburban_wheel_rf",20,undefined,undefined,"no_melee",undefined,2.3);
	lib_0D89::func_7562(%F,#animtree,"setanim");
	common_scripts\_destructible::destructible_sound("veh_tire_deflate","llet");
	common_scripts\_destructible::destructible_car_alarm();
	common_scripts\_destructible::destructible_part("left_wheel_02_jnt","vehicle_suburban_wheel_rf",20,undefined,undefined,"no_melee",undefined,2.3);
	lib_0D89::func_7562(%F,#animtree,"setanim");
	common_scripts\_destructible::destructible_sound("veh_tire_deflate","llet");
	common_scripts\_destructible::destructible_car_alarm();
	common_scripts\_destructible::destructible_part("right_wheel_02_jnt",undefined,20,undefined,undefined,"no_melee");
	lib_0D89::func_7562(%F,#animtree,"setanim");
	common_scripts\_destructible::destructible_sound("veh_tire_deflate","llet");
	common_scripts\_destructible::destructible_car_alarm();
	common_scripts\_destructible::destructible_part("tag_door_left_back","vehicle_suburban_door_lb" + param_01,undefined,undefined,undefined,undefined,1,1);
	var_02 = "tag_glass_front";
	common_scripts\_destructible::destructible_part(var_02,undefined,40,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_02 + "_d",undefined,60,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx(var_02 + "_fx","props/car_glass_large");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_car_alarm();
	common_scripts\_destructible::destructible_state(undefined);
	var_02 = "tag_glass_back";
	common_scripts\_destructible::destructible_part(var_02,undefined,40,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_02 + "_d",undefined,60,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx(var_02 + "_fx","props/car_glass_large");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_car_alarm();
	common_scripts\_destructible::destructible_state(undefined);
	var_02 = "tag_center_glass";
	common_scripts\_destructible::destructible_part(var_02,undefined,40,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_02 + "_d",undefined,60,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx(var_02 + "_fx","props/car_glass_large");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_car_alarm();
	common_scripts\_destructible::destructible_state(undefined);
	var_02 = "tag_glass_left_front";
	common_scripts\_destructible::destructible_part(var_02,undefined,20,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_02 + "_d",undefined,60,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx(var_02 + "_fx","props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_car_alarm();
	common_scripts\_destructible::destructible_state(undefined);
	var_02 = "tag_glass_right_front";
	common_scripts\_destructible::destructible_part(var_02,undefined,20,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_02 + "_d",undefined,60,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx(var_02 + "_fx","props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_car_alarm();
	common_scripts\_destructible::destructible_state(undefined);
	var_02 = "tag_glass_left_back";
	common_scripts\_destructible::destructible_part(var_02,undefined,20,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_02 + "_d",undefined,60,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx(var_02 + "_fx","props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_car_alarm();
	common_scripts\_destructible::destructible_state(undefined);
	var_02 = "tag_glass_right_back";
	common_scripts\_destructible::destructible_part(var_02,undefined,20,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_02 + "_d",undefined,60,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx(var_02 + "_fx","props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_car_alarm();
	common_scripts\_destructible::destructible_state(undefined);
	var_02 = "tag_glass_left_back_02";
	common_scripts\_destructible::destructible_part(var_02,undefined,20,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_02 + "_d",undefined,60,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_left_back_02_fx","props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_car_alarm();
	common_scripts\_destructible::destructible_state(undefined);
	var_02 = "tag_glass_right_back_02";
	common_scripts\_destructible::destructible_part(var_02,undefined,20,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_02 + "_d",undefined,60,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_right_back_02_fx","props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_car_alarm();
	common_scripts\_destructible::destructible_state(undefined);
	var_02 = "tag_light_left_front";
	common_scripts\_destructible::destructible_part(var_02,undefined,20,undefined,undefined,undefined,0.5);
	common_scripts\_destructible::destructible_fx(var_02,"props/car_glass_headlight");
	common_scripts\_destructible::destructible_sound("veh_glass_break_small");
	common_scripts\_destructible::destructible_car_alarm();
	common_scripts\_destructible::destructible_state(var_02 + "_d");
	var_02 = "tag_light_right_front";
	common_scripts\_destructible::destructible_part(var_02,undefined,20,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_02 + "_d",undefined,60,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx(var_02,"props/car_glass_headlight");
	common_scripts\_destructible::destructible_sound("veh_glass_break_small");
	common_scripts\_destructible::destructible_car_alarm();
	common_scripts\_destructible::destructible_state(var_02 + "_d");
}

//Function Number: 124
vehicle_delivery_theme_park_truck_destructible(param_00)
{
	common_scripts\_destructible::destructible_create(param_00,"tag_body",250,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_hood_fx","smoke/car_damage_whitesmoke",0.4);
	common_scripts\_destructible::destructible_state(undefined,undefined,200,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_hood_fx","smoke/car_damage_blacksmoke",0.4);
	common_scripts\_destructible::destructible_state(undefined,undefined,100,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_hood_fx","smoke/snowmobile_damage_blacksmoke_fire",0.4);
	common_scripts\_destructible::destructible_sound("fire_vehicle_flareup_med");
	common_scripts\_destructible::destructible_loopsound("fire_vehicle_med");
	common_scripts\_destructible::destructible_healthdrain(15,0.25,150,"allies");
	common_scripts\_destructible::destructible_state(undefined,undefined,300,"player_only",32,"no_melee");
	common_scripts\_destructible::destructible_loopsound("fire_vehicle_med");
	common_scripts\_destructible::destructible_state(undefined,undefined,400,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_fx("tag_death_fx","explosions/small_vehicle_explosion",0);
	common_scripts\_destructible::destructible_sound("car_explode");
	common_scripts\_destructible::destructible_explode(4000,5000,150,150,50,300,undefined,undefined,0.3,500);
	common_scripts\_destructible::destructible_anim(destructible_gaspump("ehicle_snowmobile_destroy_01"),#animtree,"setanimknob",undefined,undefined,"vehicle_snowmobile_destroy_01");
	common_scripts\_destructible::destructible_state(undefined,"vehicle_snowmobile_destroyed",undefined,32,"no_melee");
	var_01 = "right_wheel_01_jnt";
	common_scripts\_destructible::destructible_part(var_01,"vehicle_snowmobile_ski_right",800,undefined,undefined,undefined,1,2.5);
	common_scripts\_destructible::destructible_part("TAG_BAG_CENTER","vehicle_snowmobile_bag_center",undefined,undefined,undefined,undefined,1,2);
	common_scripts\_destructible::destructible_part("TAG_BAG_LEFT","vehicle_snowmobile_bag_left",undefined,undefined,undefined,undefined,1,2);
	common_scripts\_destructible::destructible_part("TAG_BAG_RIGHT","vehicle_snowmobile_bag_right",undefined,undefined,undefined,undefined,1,2);
	var_01 = "tag_glass_front";
	common_scripts\_destructible::destructible_part(var_01,undefined,40,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01 + "_d",undefined,60,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_front_fx","props/car_glass_large");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
}

//Function Number: 125
vehicle_suburban(param_00)
{
	common_scripts\_destructible::destructible_create(param_00,"tag_origin",150,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_splash_damage_scaler(15);
	common_scripts\_destructible::destructible_loopfx("tag_death_fx","smoke/car_damage_whitesmoke",0.4);
	common_scripts\_destructible::destructible_state(undefined,undefined,150,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_death_fx","smoke/car_damage_blacksmoke",0.4);
	common_scripts\_destructible::destructible_state(undefined,undefined,250,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_death_fx","fire/gas_pump_fire_damage",0.4);
	common_scripts\_destructible::destructible_sound("gaspump01_flareup_med");
	common_scripts\_destructible::destructible_loopsound("gaspump01_fire_med");
	common_scripts\_destructible::destructible_healthdrain(12,0.2,210,"allies");
	common_scripts\_destructible::destructible_state(undefined,undefined,300,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_death_fx","fire/gas_pump_fire_damage",0.4);
	common_scripts\_destructible::destructible_loopsound("gaspump01_fire_med");
	common_scripts\_destructible::destructible_healthdrain(12,0.2,210,"allies");
	common_scripts\_destructible::destructible_sound("gaspump01_flareup_med");
	common_scripts\_destructible::destructible_loopfx("tag_fx","fire/gas_pump_fire_handle",0.05);
	lib_0D89::func_6F6E(%F,#animtree,"setanimknob",undefined,undefined,"gaspump01_hose");
	common_scripts\_destructible::destructible_state(undefined,undefined,400,undefined,5,"_melee");
	common_scripts\_destructible::destructible_fx("tag_death_fx","explosions/gas_pump_exp",0);
	common_scripts\_destructible::destructible_sound("gaspump01_explode");
	common_scripts\_destructible::destructible_explode(6000,8000,210,300,50,300,undefined,undefined,0.3,500);
	common_scripts\_destructible::destructible_state(undefined,"furniture_gaspump01_destroyed",undefined,undefined,"no_melee");
	common_scripts\_destructible::destructible_part("tag_panel_front01","furniture_gaspump01_panel01",80,undefined,undefined,undefined,1,1,undefined,1);
	common_scripts\_destructible::destructible_physics();
	common_scripts\_destructible::destructible_part("tag_panel_front02","furniture_gaspump01_panel02",40,undefined,undefined,undefined,1,1);
	common_scripts\_destructible::destructible_physics();
	common_scripts\_destructible::destructible_part("tag_panel_front03","furniture_gaspump01_panel03",40,undefined,undefined,undefined,1,1);
	common_scripts\_destructible::destructible_sound("exp_gaspump_sparks");
	common_scripts\_destructible::destructible_fx("tag_panel_front03","props/electricbox4_explode");
	common_scripts\_destructible::destructible_physics();
	common_scripts\_destructible::destructible_part("tag_panel_back01","furniture_gaspump01_panel01",110,undefined,undefined,undefined,1,1,undefined,1);
	common_scripts\_destructible::destructible_physics();
	common_scripts\_destructible::destructible_part("tag_panel_back02","furniture_gaspump01_panel02",40,undefined,undefined,undefined,1,1);
	common_scripts\_destructible::destructible_physics();
	common_scripts\_destructible::destructible_part("tag_panel_back03","furniture_gaspump01_panel03",40,undefined,undefined,undefined,1,1);
	common_scripts\_destructible::destructible_sound("exp_gaspump_sparks");
	common_scripts\_destructible::destructible_fx("tag_panel_back03","props/electricbox4_explode");
	common_scripts\_destructible::destructible_physics();
}

//Function Number: 126
vehicle_snowmobile(param_00)
{
	common_scripts\_destructible::destructible_create(param_00,"tag_origin",1500,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_splash_damage_scaler(2);
	common_scripts\_destructible::destructible_loopsound("electrical_transformer_sparks");
	common_scripts\_destructible::destructible_loopfx("tag_fx","explosions/electrical_transformer_spark_runner",0.8);
	common_scripts\_destructible::destructible_healthdrain(12,0.2,210,"allies");
	common_scripts\_destructible::destructible_state(undefined,undefined,500,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_loopsound("electrical_transformer_sparks");
	common_scripts\_destructible::destructible_fx("tag_fx_junction","explosions/generator_sparks_c",0);
	common_scripts\_destructible::destructible_loopfx("tag_fx_junction","fire/electrical_transformer_blacksmoke_fire",0.4);
	common_scripts\_destructible::destructible_loopfx("tag_fx","explosions/electrical_transformer_spark_runner",0.8);
	common_scripts\_destructible::destructible_healthdrain(12,0.2,210,"allies");
	common_scripts\_destructible::destructible_state(undefined,undefined,300,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_loopsound("electrical_transformer_sparks");
	common_scripts\_destructible::destructible_loopfx("tag_fx_junction","fire/electrical_transformer_blacksmoke_fire",0.4);
	common_scripts\_destructible::destructible_loopfx("tag_fx","explosions/electrical_transformer_spark_runner",0.8);
	common_scripts\_destructible::destructible_loopfx("tag_fx_valve","explosions/generator_spark_runner",0.6);
	common_scripts\_destructible::destructible_healthdrain(12,0.2,210,"allies");
	common_scripts\_destructible::destructible_state(undefined,undefined,500,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_fx("tag_death_fx","explosions/electrical_transformer_explosion",0);
	common_scripts\_destructible::destructible_sound("electrical_transformer01_explode");
	common_scripts\_destructible::destructible_explode(6000,8000,210,300,20,300,undefined,undefined,0.3,500);
	common_scripts\_destructible::destructible_state(undefined,"com_electrical_transformer_large_des",undefined,undefined,"no_melee");
	common_scripts\_destructible::destructible_part("tag_door1","com_electrical_transformer_large_dam_door1",1500,undefined,undefined,undefined,0,1,undefined,1);
	common_scripts\_destructible::destructible_sound("electrical_transformer01_explode_detail");
	common_scripts\_destructible::destructible_fx("tag_door1","explosions/generator_explosion");
	common_scripts\_destructible::destructible_physics();
	common_scripts\_destructible::destructible_part("tag_door2","com_electrical_transformer_large_dam_door2",150,undefined,undefined,undefined,0,1,undefined,1);
	common_scripts\_destructible::destructible_physics();
	common_scripts\_destructible::destructible_part("tag_door3","com_electrical_transformer_large_dam_door3",150,undefined,undefined,undefined,0,1,undefined,1);
	common_scripts\_destructible::destructible_physics();
	common_scripts\_destructible::destructible_part("tag_door4","com_electrical_transformer_large_dam_door4",150,undefined,undefined,undefined,0,1,undefined,1);
	common_scripts\_destructible::destructible_physics();
	common_scripts\_destructible::destructible_part("tag_door5","com_electrical_transformer_large_dam_door5",1500,undefined,undefined,undefined,0,1,undefined,1);
	common_scripts\_destructible::destructible_sound("electrical_transformer01_explode_detail");
	common_scripts\_destructible::destructible_fx("tag_door5","explosions/generator_explosion");
	common_scripts\_destructible::destructible_physics();
	common_scripts\_destructible::destructible_part("tag_door6","com_electrical_transformer_large_dam_door6",150,undefined,undefined,undefined,0,1,undefined,1);
	common_scripts\_destructible::destructible_physics();
	common_scripts\_destructible::destructible_part("tag_door7","com_electrical_transformer_large_dam_door7",150,undefined,undefined,undefined,0,1,undefined,1);
	common_scripts\_destructible::destructible_loopsound("electrical_transformer_sparks");
	common_scripts\_destructible::destructible_fx("tag_door7","props/electricbox4_explode");
	common_scripts\_destructible::destructible_physics();
}

//Function Number: 127
destructible_gaspump(param_00)
{
	return level.var_E13[param_00];
}

//Function Number: 128
destructible_electrical_transformer_large(param_00)
{
	return level.var_E15[param_00];
}

//Function Number: 129
get_precached_anim(param_00)
{
	common_scripts\_destructible::destructible_create("vehicle_coupe_" + param_00,"tag_body",250,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_hood_fx","smoke/car_damage_whitesmoke",0.4);
	common_scripts\_destructible::destructible_state(undefined,undefined,200,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_hood_fx","smoke/car_damage_blacksmoke",0.4);
	common_scripts\_destructible::destructible_state(undefined,undefined,100,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_hood_fx","smoke/car_damage_blacksmoke_fire",0.4);
	common_scripts\_destructible::destructible_sound("fire_vehicle_flareup_med");
	common_scripts\_destructible::destructible_loopsound("fire_vehicle_med");
	common_scripts\_destructible::destructible_healthdrain(12,0.2,150,"allies");
	common_scripts\_destructible::destructible_state(undefined,undefined,300,"player_only",32,"no_melee");
	common_scripts\_destructible::destructible_loopsound("fire_vehicle_med");
	common_scripts\_destructible::destructible_state(undefined,undefined,400,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_fx("tag_death_fx","explosions/small_vehicle_explosion",0);
	common_scripts\_destructible::destructible_sound("car_explode");
	common_scripts\_destructible::destructible_explode(4000,5000,150,250,50,300,undefined,undefined,0.3,500);
	lib_0D89::func_6F6E(%F,#animtree,"setanimknob",undefined,undefined,"vehicle_80s_sedan1_destroy");
	common_scripts\_destructible::destructible_state(undefined,"vehicle_coupe_" + param_00 + "_destroyed",undefined,32,"_melee");
	common_scripts\_destructible::destructible_part("left_wheel_01_jnt",undefined,20,undefined,undefined,"no_melee");
	lib_0D89::func_7562(%F,#animtree,"setanim",1);
	common_scripts\_destructible::destructible_sound("veh_tire_deflate","llet");
	common_scripts\_destructible::destructible_part("right_wheel_01_jnt",undefined,20,undefined,undefined,"no_melee");
	lib_0D89::func_7562(%F,#animtree,"setanim",1);
	common_scripts\_destructible::destructible_sound("veh_tire_deflate","llet");
	common_scripts\_destructible::destructible_part("left_wheel_02_jnt",undefined,20,undefined,undefined,"no_melee");
	lib_0D89::func_7562(%F,#animtree,"setanim",1);
	common_scripts\_destructible::destructible_sound("veh_tire_deflate","llet");
	common_scripts\_destructible::destructible_part("right_wheel_02_jnt","vehicle_coupe_wheel_lf",20,undefined,undefined,"no_melee",undefined,2.3);
	lib_0D89::func_7562(%F,#animtree,"setanim",1);
	common_scripts\_destructible::destructible_sound("veh_tire_deflate","llet");
	common_scripts\_destructible::destructible_part("tag_door_left_front","vehicle_coupe_" + param_00 + "_door_LF",undefined,undefined,undefined,undefined,1,1);
	common_scripts\_destructible::destructible_part("tag_spoiler","vehicle_coupe_" + param_00 + "_spoiler",undefined,undefined,undefined,undefined,1,2);
	var_01 = "tag_glass_front";
	common_scripts\_destructible::destructible_part(var_01,undefined,40,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01 + "_d",undefined,60,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_front_fx","props/car_glass_large");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_glass_back";
	common_scripts\_destructible::destructible_part(var_01,undefined,40,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01 + "_d",undefined,60,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_back_fx","props/car_glass_large");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_glass_left_front";
	common_scripts\_destructible::destructible_part(var_01,undefined,20,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01 + "_d",undefined,60,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_left_front_fx","props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_glass_right_front";
	common_scripts\_destructible::destructible_part(var_01,undefined,20,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01 + "_d",undefined,60,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_right_front_fx","props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_glass_left_back";
	common_scripts\_destructible::destructible_part(var_01,undefined,20,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01 + "_d",undefined,60,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_left_back_fx","props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_glass_right_back";
	common_scripts\_destructible::destructible_part(var_01,undefined,20,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01 + "_d",undefined,60,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_right_back_fx","props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_light_left_front";
	common_scripts\_destructible::destructible_part(var_01,undefined,20,undefined,undefined,undefined,0.5);
	common_scripts\_destructible::destructible_fx(var_01,"props/car_glass_headlight");
	common_scripts\_destructible::destructible_sound("veh_glass_break_small");
	common_scripts\_destructible::destructible_state(var_01 + "_d");
	var_01 = "tag_light_right_front";
	common_scripts\_destructible::destructible_part(var_01,undefined,20,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01 + "_d",undefined,60,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx(var_01,"props/car_glass_headlight");
	common_scripts\_destructible::destructible_sound("veh_glass_break_small");
	common_scripts\_destructible::destructible_part("tag_mirror_left","vehicle_coupe_" + param_00 + "_mirror_L",40,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_physics();
	common_scripts\_destructible::destructible_part("tag_mirror_right","vehicle_coupe_" + param_00 + "_mirror_R",40,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_physics();
}

//Function Number: 130
get_precached_animtree(param_00)
{
	common_scripts\_destructible::destructible_create("vehicle_mini_destructible_" + param_00,"tag_body",250,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_hood_fx","smoke/car_damage_whitesmoke",0.4);
	common_scripts\_destructible::destructible_state(undefined,undefined,200,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_hood_fx","smoke/car_damage_blacksmoke",0.4);
	common_scripts\_destructible::destructible_state(undefined,undefined,100,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_hood_fx","smoke/car_damage_blacksmoke_fire",0.4);
	common_scripts\_destructible::destructible_sound("fire_vehicle_flareup_med");
	common_scripts\_destructible::destructible_loopsound("fire_vehicle_med");
	common_scripts\_destructible::destructible_healthdrain(12,0.2,150,"allies");
	common_scripts\_destructible::destructible_state(undefined,undefined,300,"player_only",32,"no_melee");
	common_scripts\_destructible::destructible_loopsound("fire_vehicle_med");
	common_scripts\_destructible::destructible_state(undefined,undefined,400,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_fx("tag_death_fx","explosions/small_vehicle_explosion",0);
	common_scripts\_destructible::destructible_sound("car_explode");
	common_scripts\_destructible::destructible_explode(4000,5000,150,250,50,300,undefined,undefined,0.3,500);
	lib_0D89::func_6F6E(%F,#animtree,"setanimknob",undefined,undefined,"vehicle_80s_sedan1_destroy");
	common_scripts\_destructible::destructible_state(undefined,"vehicle_mini_destroyed_" + param_00,undefined,32,"_melee");
	common_scripts\_destructible::destructible_part("left_wheel_01_jnt",undefined,20,undefined,undefined,"no_melee");
	lib_0D89::func_7562(%F,#animtree,"setanim",1);
	common_scripts\_destructible::destructible_sound("veh_tire_deflate","llet");
	common_scripts\_destructible::destructible_part("right_wheel_01_jnt",undefined,20,undefined,undefined,"no_melee");
	lib_0D89::func_7562(%F,#animtree,"setanim",1);
	common_scripts\_destructible::destructible_sound("veh_tire_deflate","llet");
	common_scripts\_destructible::destructible_part("left_wheel_02_jnt",undefined,20,undefined,undefined,"no_melee");
	lib_0D89::func_7562(%F,#animtree,"setanim",1);
	common_scripts\_destructible::destructible_sound("veh_tire_deflate","llet");
	common_scripts\_destructible::destructible_part("right_wheel_02_jnt",undefined,20,undefined,undefined,"no_melee",undefined,2.3);
	lib_0D89::func_7562(%F,#animtree,"setanim",1);
	common_scripts\_destructible::destructible_sound("veh_tire_deflate","llet");
	var_01 = "TAG_GLASS_FRONT";
	common_scripts\_destructible::destructible_part(var_01,undefined,40,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01 + "_D",undefined,60,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_front_fx","props/car_glass_large");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_glass_back";
	common_scripts\_destructible::destructible_part(var_01,undefined,40,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01 + "_d",undefined,60,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_back_fx","props/car_glass_large");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_glass_left_front";
	common_scripts\_destructible::destructible_part(var_01,undefined,20,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01 + "_d",undefined,60,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_left_front_fx","props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_glass_right_front";
	common_scripts\_destructible::destructible_part(var_01,undefined,20,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01 + "_d",undefined,60,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_right_front_fx","props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_glass_left_back";
	common_scripts\_destructible::destructible_part(var_01,undefined,20,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01 + "_d",undefined,60,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_left_back_fx","props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_glass_right_back";
	common_scripts\_destructible::destructible_part(var_01,undefined,20,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01 + "_d",undefined,60,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_right_back_fx","props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_light_left_front";
	common_scripts\_destructible::destructible_part(var_01,undefined,20,undefined,undefined,undefined,0.5);
	common_scripts\_destructible::destructible_fx(var_01,"props/car_glass_headlight");
	common_scripts\_destructible::destructible_sound("veh_glass_break_small");
	common_scripts\_destructible::destructible_state(var_01 + "_d");
	var_01 = "tag_light_right_front";
	common_scripts\_destructible::destructible_part(var_01,undefined,20,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01 + "_d",undefined,60,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx(var_01,"props/car_glass_headlight");
	common_scripts\_destructible::destructible_sound("veh_glass_break_small");
	common_scripts\_destructible::destructible_part("tag_mirror_left","vehicle_mini_mirror_lf",40,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_physics();
	common_scripts\_destructible::destructible_part("tag_mirror_right","vehicle_mini_mirror_rf",40,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_physics();
}

//Function Number: 131
vehicle_coupe(param_00)
{
	common_scripts\_destructible::destructible_create(param_00,"tag_body",250,undefined,32,"no_melee");
	var_01 = "TAG_GLASS_FRONT";
	common_scripts\_destructible::destructible_part(var_01,undefined,40,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01 + "_D",undefined,60,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_front_fx","props/car_glass_large");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "TAG_GLASS_BACK";
	common_scripts\_destructible::destructible_part(var_01,undefined,40,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01 + "_D",undefined,60,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_back_fx","props/car_glass_large");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "TAG_GLASS_LEFT_FRONT";
	common_scripts\_destructible::destructible_part(var_01,undefined,20,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01 + "_D",undefined,60,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_left_front_fx","props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "TAG_GLASS_RIGHT_FRONT";
	common_scripts\_destructible::destructible_part(var_01,undefined,20,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01 + "_D",undefined,60,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_right_front_fx","props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	common_scripts\_destructible::destructible_part("left_wheel_01_jnt",undefined,20,undefined,undefined,"no_melee");
	lib_0D89::func_7562(%F,#animtree,"setanim");
	common_scripts\_destructible::destructible_sound("veh_tire_deflate","llet");
	common_scripts\_destructible::destructible_part("left_wheel_02_jnt",undefined,20,undefined,undefined,"no_melee");
	lib_0D89::func_7562(%F,#animtree,"setanim");
	common_scripts\_destructible::destructible_sound("veh_tire_deflate","llet");
	common_scripts\_destructible::destructible_part("right_wheel_01_jnt",undefined,20,undefined,undefined,"no_melee");
	lib_0D89::func_7562(%F,#animtree,"setanim");
	common_scripts\_destructible::destructible_sound("veh_tire_deflate","llet");
	common_scripts\_destructible::destructible_part("right_wheel_02_jnt",undefined,20,undefined,undefined,"no_melee");
	lib_0D89::func_7562(%F,#animtree,"setanim");
	common_scripts\_destructible::destructible_sound("veh_tire_deflate","llet");
}

//Function Number: 132
vehicle_mini(param_00)
{
	common_scripts\_destructible::destructible_create(param_00,"tag_body",250,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_hood_fx","smoke/car_damage_whitesmoke",0.4);
	common_scripts\_destructible::destructible_state(undefined,undefined,200,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_hood_fx","smoke/car_damage_blacksmoke",0.4);
	common_scripts\_destructible::destructible_state(undefined,undefined,100,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_hood_fx","smoke/car_damage_blacksmoke_fire",0.4);
	common_scripts\_destructible::destructible_sound("fire_vehicle_flareup_med");
	common_scripts\_destructible::destructible_loopsound("fire_vehicle_med");
	common_scripts\_destructible::destructible_healthdrain(15,0.25,210,"allies");
	common_scripts\_destructible::destructible_state(undefined,undefined,300,"player_only",32,"no_melee");
	common_scripts\_destructible::destructible_loopsound("fire_vehicle_med");
	common_scripts\_destructible::destructible_state(undefined,undefined,400,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_fx("tag_death_fx","explosions/small_vehicle_explosion",0);
	common_scripts\_destructible::destructible_sound("car_explode");
	common_scripts\_destructible::destructible_explode(4000,5000,200,250,50,300,undefined,undefined,0.3,500);
	lib_0D89::func_6F6E(%F,#animtree,"setanimknob",undefined,undefined,"vehicle_80s_sedan1_destroy");
	common_scripts\_destructible::destructible_state(undefined,"uk_police_estate_destroyed",undefined,32,"_melee");
	common_scripts\_destructible::destructible_part("left_wheel_01_jnt","uk_police_estate_wheel_lf",20,undefined,undefined,"no_melee",undefined,1);
	lib_0D89::func_7562(%F,#animtree,"setanim",1);
	common_scripts\_destructible::destructible_sound("veh_tire_deflate","llet");
	common_scripts\_destructible::destructible_part("left_wheel_02_jnt","uk_police_estate_wheel_lf",20,undefined,undefined,"no_melee");
	lib_0D89::func_7562(%F,#animtree,"setanim",1);
	common_scripts\_destructible::destructible_sound("veh_tire_deflate","llet");
	common_scripts\_destructible::destructible_part("right_wheel_01_jnt","uk_police_estate_wheel_lf",20,undefined,undefined,"no_melee",undefined,10);
	lib_0D89::func_7562(%F,#animtree,"setanim",1);
	common_scripts\_destructible::destructible_sound("veh_tire_deflate","llet");
	common_scripts\_destructible::destructible_part("right_wheel_02_jnt","uk_police_estate_wheel_lf",20,undefined,undefined,"no_melee");
	lib_0D89::func_7562(%F,#animtree,"setanim",1);
	common_scripts\_destructible::destructible_sound("veh_tire_deflate","llet");
	var_01 = "TAG_GLASS_FRONT";
	common_scripts\_destructible::destructible_part(var_01,undefined,40,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01 + "_D",undefined,60,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_front_fx","props/car_glass_large");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "TAG_GLASS_BACK";
	common_scripts\_destructible::destructible_part(var_01,undefined,40,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01 + "_D",undefined,60,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_back_fx","props/car_glass_large");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "TAG_GLASS_LEFT_FRONT";
	common_scripts\_destructible::destructible_part(var_01,undefined,20,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01 + "_D",undefined,60,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_left_front_fx","props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "TAG_GLASS_RIGHT_FRONT";
	common_scripts\_destructible::destructible_part(var_01,undefined,20,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01 + "_D",undefined,60,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_right_front_fx","props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "TAG_GLASS_LEFT_BACK";
	common_scripts\_destructible::destructible_part(var_01,undefined,20,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01 + "_D",undefined,60,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_left_front_fx","props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "TAG_GLASS_RIGHT_BACK";
	common_scripts\_destructible::destructible_part(var_01,undefined,20,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01 + "_D",undefined,60,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_right_front_fx","props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "TAG_GLASS_LEFT_BACK_02";
	common_scripts\_destructible::destructible_part(var_01,undefined,20,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01 + "_D",undefined,60,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_left_front_fx","props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "TAG_GLASS_RIGHT_BACK_02";
	common_scripts\_destructible::destructible_part(var_01,undefined,20,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01 + "_D",undefined,60,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_right_front_fx","props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
}

//Function Number: 133
vehicle_uk_truck(param_00)
{
	common_scripts\_destructible::destructible_create(param_00,"tag_body",250,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_hood_fx","smoke/car_damage_whitesmoke",0.4);
	common_scripts\_destructible::destructible_state(undefined,undefined,200,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_hood_fx","smoke/car_damage_blacksmoke",0.4);
	common_scripts\_destructible::destructible_state(undefined,undefined,100,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_hood_fx","smoke/car_damage_blacksmoke_fire",0.4);
	common_scripts\_destructible::destructible_sound("fire_vehicle_flareup_med");
	common_scripts\_destructible::destructible_loopsound("fire_vehicle_med");
	common_scripts\_destructible::destructible_healthdrain(15,0.25,210,"allies");
	common_scripts\_destructible::destructible_state(undefined,undefined,300,"player_only",32,"no_melee");
	common_scripts\_destructible::destructible_loopsound("fire_vehicle_med");
	common_scripts\_destructible::destructible_state(undefined,undefined,400,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_fx("tag_death_fx","explosions/small_vehicle_explosion",0);
	common_scripts\_destructible::destructible_sound("car_explode");
	common_scripts\_destructible::destructible_explode(4000,5000,200,250,50,300,undefined,undefined,0.3,500);
	lib_0D89::func_6F6E(%F,#animtree,"setanimknob",undefined,undefined,"vehicle_80s_sedan1_destroy");
	common_scripts\_destructible::destructible_state(undefined,"vehicle_uaz_winter_destroy",undefined,32,"_melee");
	common_scripts\_destructible::destructible_part("left_wheel_01_jnt","vehicle_uaz_wheel_LF_d",20,undefined,undefined,"no_melee",undefined,1);
	lib_0D89::func_7562(%F,#animtree,"setanim",1);
	common_scripts\_destructible::destructible_sound("veh_tire_deflate","llet");
	common_scripts\_destructible::destructible_part("left_wheel_02_jnt","vehicle_uaz_wheel_LF_d",20,undefined,undefined,"no_melee");
	lib_0D89::func_7562(%F,#animtree,"setanim",1);
	common_scripts\_destructible::destructible_sound("veh_tire_deflate","llet");
	common_scripts\_destructible::destructible_part("right_wheel_01_jnt","vehicle_uaz_wheel_RF_d",20,undefined,undefined,"no_melee",undefined,10);
	lib_0D89::func_7562(%F,#animtree,"setanim",1);
	common_scripts\_destructible::destructible_sound("veh_tire_deflate","llet");
	common_scripts\_destructible::destructible_part("right_wheel_02_jnt","vehicle_uaz_wheel_RF_d",20,undefined,undefined,"no_melee");
	lib_0D89::func_7562(%F,#animtree,"setanim",1);
	common_scripts\_destructible::destructible_sound("veh_tire_deflate","llet");
	var_01 = "tag_glass_front";
	common_scripts\_destructible::destructible_part(var_01,undefined,40,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01 + "_d",undefined,60,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_front_fx","props/car_glass_large");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_glass_back";
	common_scripts\_destructible::destructible_part(var_01,undefined,40,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01 + "_d",undefined,60,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_back_fx","props/car_glass_large");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_glass_left_front";
	common_scripts\_destructible::destructible_part(var_01,undefined,20,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01 + "_d",undefined,60,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_left_front_fx","props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_glass_right_front";
	common_scripts\_destructible::destructible_part(var_01,undefined,20,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01 + "_d",undefined,60,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_right_front_fx","props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_glass_left_back";
	common_scripts\_destructible::destructible_part(var_01,undefined,20,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01 + "_d",undefined,60,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_left_back_fx","props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_glass_right_back";
	common_scripts\_destructible::destructible_part(var_01,undefined,20,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01 + "_d",undefined,60,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_right_back_fx","props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_glass_left_back_02";
	common_scripts\_destructible::destructible_part(var_01,undefined,20,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01 + "_d",undefined,60,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_left_back_02_fx","props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_glass_right_back_02";
	common_scripts\_destructible::destructible_part(var_01,undefined,20,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01 + "_d",undefined,60,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_right_back_02_fx","props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_light_left_front";
	common_scripts\_destructible::destructible_part(var_01,undefined,20,undefined,undefined,undefined,0.5);
	common_scripts\_destructible::destructible_fx(var_01,"props/car_glass_headlight");
	common_scripts\_destructible::destructible_sound("veh_glass_break_small");
	common_scripts\_destructible::destructible_state(var_01 + "_d");
	var_01 = "tag_light_right_front";
	common_scripts\_destructible::destructible_part(var_01,undefined,20,undefined,undefined,undefined,0.5);
	common_scripts\_destructible::destructible_fx(var_01,"props/car_glass_headlight");
	common_scripts\_destructible::destructible_sound("veh_glass_break_small");
	common_scripts\_destructible::destructible_state(var_01 + "_d");
	common_scripts\_destructible::destructible_part("tag_mirror_left","vehicle_uaz_winter_mirror_L",40,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_physics();
	common_scripts\_destructible::destructible_part("tag_mirror_right","vehicle_uaz_winter_mirror_R",40,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_physics();
}

//Function Number: 134
vehicle_uk_police_estate(param_00)
{
	common_scripts\_destructible::destructible_create(param_00,"tag_body",250,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_hood_fx","smoke/car_damage_whitesmoke",0.4);
	common_scripts\_destructible::destructible_state(undefined,undefined,200,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_hood_fx","smoke/car_damage_blacksmoke",0.4);
	common_scripts\_destructible::destructible_state(undefined,undefined,100,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_hood_fx","smoke/car_damage_blacksmoke_fire",0.4);
	common_scripts\_destructible::destructible_sound("fire_vehicle_flareup_med");
	common_scripts\_destructible::destructible_loopsound("fire_vehicle_med");
	common_scripts\_destructible::destructible_healthdrain(15,0.25,210,"allies");
	common_scripts\_destructible::destructible_state(undefined,undefined,300,"player_only",32,"no_melee");
	common_scripts\_destructible::destructible_loopsound("fire_vehicle_med");
	common_scripts\_destructible::destructible_state(undefined,undefined,400,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_fx("tag_death_fx","explosions/small_vehicle_explosion",0);
	common_scripts\_destructible::destructible_sound("car_explode");
	common_scripts\_destructible::destructible_explode(4000,5000,200,250,50,300,undefined,undefined,0.3,500);
	lib_0D89::func_6F6E(%F,#animtree,"setanimknob",undefined,undefined,"vehicle_80s_sedan1_destroy");
	common_scripts\_destructible::destructible_state(undefined,"vehicle_uaz_fabric_dsr",undefined,32,"_melee");
	common_scripts\_destructible::destructible_part("left_wheel_01_jnt","vehicle_uaz_wheel_LF_d",20,undefined,undefined,"no_melee");
	lib_0D89::func_7562(%F,#animtree,"setanim",1);
	common_scripts\_destructible::destructible_sound("veh_tire_deflate","llet");
	common_scripts\_destructible::destructible_part("left_wheel_02_jnt","vehicle_uaz_wheel_LF_d",20,undefined,undefined,"no_melee");
	lib_0D89::func_7562(%F,#animtree,"setanim",1);
	common_scripts\_destructible::destructible_sound("veh_tire_deflate","llet");
	common_scripts\_destructible::destructible_part("right_wheel_01_jnt","vehicle_uaz_wheel_RF_d",20,undefined,undefined,"no_melee");
	lib_0D89::func_7562(%F,#animtree,"setanim",1);
	common_scripts\_destructible::destructible_sound("veh_tire_deflate","llet");
	common_scripts\_destructible::destructible_part("right_wheel_02_jnt","vehicle_uaz_wheel_RF_d",20,undefined,undefined,"no_melee");
	lib_0D89::func_7562(%F,#animtree,"setanim",1);
	common_scripts\_destructible::destructible_sound("veh_tire_deflate","llet");
	var_01 = "tag_glass_front";
	common_scripts\_destructible::destructible_part(var_01,undefined,40,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01 + "_d",undefined,60,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_front_fx","props/car_glass_large");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_glass_back";
	common_scripts\_destructible::destructible_part(var_01,undefined,40,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01 + "_d",undefined,60,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_back_fx","props/car_glass_large");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_glass_left_front";
	common_scripts\_destructible::destructible_part(var_01,undefined,20,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01 + "_d",undefined,60,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_left_front_fx","props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_glass_right_front";
	common_scripts\_destructible::destructible_part(var_01,undefined,20,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01 + "_d",undefined,60,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_right_front_fx","props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_glass_left_back";
	common_scripts\_destructible::destructible_part(var_01,undefined,20,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01 + "_d",undefined,60,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_left_back_fx","props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_glass_right_back";
	common_scripts\_destructible::destructible_part(var_01,undefined,20,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01 + "_d",undefined,60,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_right_back_fx","props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_light_left_front";
	common_scripts\_destructible::destructible_part(var_01,undefined,20,undefined,undefined,undefined,0.5);
	common_scripts\_destructible::destructible_fx(var_01,"props/car_glass_headlight");
	common_scripts\_destructible::destructible_sound("veh_glass_break_small");
	common_scripts\_destructible::destructible_state(var_01 + "_d");
	var_01 = "tag_light_right_front";
	common_scripts\_destructible::destructible_part(var_01,undefined,20,undefined,undefined,undefined,0.5);
	common_scripts\_destructible::destructible_fx(var_01,"props/car_glass_headlight");
	common_scripts\_destructible::destructible_sound("veh_glass_break_small");
	common_scripts\_destructible::destructible_state(var_01 + "_d");
	common_scripts\_destructible::destructible_part("tag_mirror_left","vehicle_uaz_mirror_L",40,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_physics();
	common_scripts\_destructible::destructible_part("tag_mirror_right","vehicle_uaz_mirror_R",40,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_physics();
}

//Function Number: 135
vehicle_uaz_winter(param_00)
{
	common_scripts\_destructible::destructible_create(param_00,"tag_body",250,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_hood_fx","smoke/car_damage_whitesmoke",0.4);
	common_scripts\_destructible::destructible_state(undefined,undefined,200,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_hood_fx","smoke/car_damage_blacksmoke",0.4);
	common_scripts\_destructible::destructible_state(undefined,undefined,100,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_hood_fx","smoke/car_damage_blacksmoke_fire",0.4);
	common_scripts\_destructible::destructible_sound("fire_vehicle_flareup_med");
	common_scripts\_destructible::destructible_loopsound("fire_vehicle_med");
	common_scripts\_destructible::destructible_healthdrain(15,0.25,210,"allies");
	common_scripts\_destructible::destructible_state(undefined,undefined,300,"player_only",32,"no_melee");
	common_scripts\_destructible::destructible_loopsound("fire_vehicle_med");
	common_scripts\_destructible::destructible_state(undefined,undefined,400,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_fx("tag_death_fx","explosions/small_vehicle_explosion",0);
	common_scripts\_destructible::destructible_sound("car_explode");
	common_scripts\_destructible::destructible_explode(4000,5000,200,250,50,300,undefined,undefined,0.3,500);
	lib_0D89::func_6F6E(%F,#animtree,"setanimknob",undefined,undefined,"vehicle_80s_sedan1_destroy");
	common_scripts\_destructible::destructible_state(undefined,"vehicle_uaz_hardtop_dsr",undefined,32,"_melee");
	common_scripts\_destructible::destructible_part("left_wheel_01_jnt","vehicle_uaz_wheel_LF_d",20,undefined,undefined,"no_melee");
	lib_0D89::func_7562(%F,#animtree,"setanim",1);
	common_scripts\_destructible::destructible_sound("veh_tire_deflate","llet");
	common_scripts\_destructible::destructible_part("left_wheel_02_jnt","vehicle_uaz_wheel_LF_d",20,undefined,undefined,"no_melee");
	lib_0D89::func_7562(%F,#animtree,"setanim",1);
	common_scripts\_destructible::destructible_sound("veh_tire_deflate","llet");
	common_scripts\_destructible::destructible_part("right_wheel_01_jnt","vehicle_uaz_wheel_RF_d",20,undefined,undefined,"no_melee");
	lib_0D89::func_7562(%F,#animtree,"setanim",1);
	common_scripts\_destructible::destructible_sound("veh_tire_deflate","llet");
	common_scripts\_destructible::destructible_part("right_wheel_02_jnt","vehicle_uaz_wheel_RF_d",20,undefined,undefined,"no_melee");
	lib_0D89::func_7562(%F,#animtree,"setanim",1);
	common_scripts\_destructible::destructible_sound("veh_tire_deflate","llet");
	var_01 = "tag_glass_front";
	common_scripts\_destructible::destructible_part(var_01,undefined,40,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01 + "_d",undefined,60,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_front_fx","props/car_glass_large");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_glass_back";
	common_scripts\_destructible::destructible_part(var_01,undefined,40,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01 + "_d",undefined,60,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_back_fx","props/car_glass_large");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_glass_left_front";
	common_scripts\_destructible::destructible_part(var_01,undefined,20,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01 + "_d",undefined,60,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_left_front_fx","props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_glass_right_front";
	common_scripts\_destructible::destructible_part(var_01,undefined,20,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01 + "_d",undefined,60,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_right_front_fx","props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_glass_left_back";
	common_scripts\_destructible::destructible_part(var_01,undefined,20,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01 + "_d",undefined,60,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_left_back_fx","props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_glass_right_back";
	common_scripts\_destructible::destructible_part(var_01,undefined,20,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01 + "_d",undefined,60,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_right_back_fx","props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_glass_left_back_02";
	common_scripts\_destructible::destructible_part(var_01,undefined,20,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01 + "_d",undefined,60,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_left_back_02_fx","props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_glass_right_back_02";
	common_scripts\_destructible::destructible_part(var_01,undefined,20,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01 + "_d",undefined,60,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_right_back_02_fx","props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_light_left_front";
	common_scripts\_destructible::destructible_part(var_01,undefined,20,undefined,undefined,undefined,0.5);
	common_scripts\_destructible::destructible_fx(var_01,"props/car_glass_headlight");
	common_scripts\_destructible::destructible_sound("veh_glass_break_small");
	common_scripts\_destructible::destructible_state(var_01 + "_d");
	var_01 = "tag_light_right_front";
	common_scripts\_destructible::destructible_part(var_01,undefined,20,undefined,undefined,undefined,0.5);
	common_scripts\_destructible::destructible_fx(var_01,"props/car_glass_headlight");
	common_scripts\_destructible::destructible_sound("veh_glass_break_small");
	common_scripts\_destructible::destructible_state(var_01 + "_d");
	common_scripts\_destructible::destructible_part("tag_mirror_left","vehicle_uaz_mirror_L",40,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_physics();
	common_scripts\_destructible::destructible_part("tag_mirror_right","vehicle_uaz_mirror_R",40,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_physics();
}

//Function Number: 136
vehicle_uaz_fabric(param_00)
{
	common_scripts\_destructible::destructible_create(param_00,"tag_body",250,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_hood_fx","smoke/car_damage_whitesmoke",0.4);
	common_scripts\_destructible::destructible_state(undefined,undefined,200,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_hood_fx","smoke/car_damage_blacksmoke",0.4);
	common_scripts\_destructible::destructible_state(undefined,undefined,100,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_hood_fx","smoke/car_damage_blacksmoke_fire",0.4);
	common_scripts\_destructible::destructible_sound("fire_vehicle_flareup_med");
	common_scripts\_destructible::destructible_loopsound("fire_vehicle_med");
	common_scripts\_destructible::destructible_healthdrain(15,0.25,210,"allies");
	common_scripts\_destructible::destructible_state(undefined,undefined,300,"player_only",32,"no_melee");
	common_scripts\_destructible::destructible_loopsound("fire_vehicle_med");
	common_scripts\_destructible::destructible_state(undefined,undefined,400,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_fx("tag_death_fx","explosions/small_vehicle_explosion",0);
	common_scripts\_destructible::destructible_sound("car_explode");
	common_scripts\_destructible::destructible_explode(4000,5000,200,250,50,300,undefined,undefined,0.3,500);
	lib_0D89::func_6F6E(%F,#animtree,"setanimknob",undefined,undefined,"vehicle_80s_sedan1_destroy");
	common_scripts\_destructible::destructible_state(undefined,"vehicle_jeep_destroyed",undefined,32,"_melee");
	common_scripts\_destructible::destructible_part("left_wheel_01_jnt",undefined,20,undefined,undefined,"no_melee");
	lib_0D89::func_7562(%F,#animtree,"setanim",1);
	common_scripts\_destructible::destructible_sound("veh_tire_deflate","llet");
	common_scripts\_destructible::destructible_part("left_wheel_02_jnt","vehicle_jeep_wheel_lf",20,undefined,undefined,"no_melee",undefined,2.7);
	lib_0D89::func_7562(%F,#animtree,"setanim",1);
	common_scripts\_destructible::destructible_sound("veh_tire_deflate","llet");
	common_scripts\_destructible::destructible_part("right_wheel_01_jnt","vehicle_jeep_wheel_lf",20,undefined,undefined,"no_melee",undefined,2.7);
	lib_0D89::func_7562(%F,#animtree,"setanim",1);
	common_scripts\_destructible::destructible_sound("veh_tire_deflate","llet");
	common_scripts\_destructible::destructible_part("right_wheel_02_jnt",undefined,20,undefined,undefined,"no_melee");
	lib_0D89::func_7562(%F,#animtree,"setanim",1);
	common_scripts\_destructible::destructible_sound("veh_tire_deflate","llet");
	var_01 = "tag_glass_front";
	common_scripts\_destructible::destructible_part(var_01,undefined,40,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01 + "_d",undefined,60,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_front_fx","props/car_glass_large");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_light_left_front";
	common_scripts\_destructible::destructible_part(var_01,undefined,20,undefined,undefined,undefined,0.5);
	common_scripts\_destructible::destructible_fx(var_01,"props/car_glass_headlight");
	common_scripts\_destructible::destructible_sound("veh_glass_break_small");
	common_scripts\_destructible::destructible_state(var_01 + "_d");
	var_01 = "tag_light_right_front";
	common_scripts\_destructible::destructible_part(var_01,undefined,20,undefined,undefined,undefined,0.5);
	common_scripts\_destructible::destructible_fx(var_01,"props/car_glass_headlight");
	common_scripts\_destructible::destructible_sound("veh_glass_break_small");
	common_scripts\_destructible::destructible_state(var_01 + "_d");
}

//Function Number: 137
vehicle_uaz_hardtop(param_00)
{
	common_scripts\_destructible::destructible_create(param_00,"tag_body",250,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_hood_fx","smoke/car_damage_whitesmoke",0.4);
	common_scripts\_destructible::destructible_state(undefined,undefined,200,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_hood_fx","smoke/car_damage_blacksmoke",0.4);
	common_scripts\_destructible::destructible_state(undefined,undefined,100,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_hood_fx","smoke/car_damage_blacksmoke_fire",0.4);
	common_scripts\_destructible::destructible_sound("fire_vehicle_flareup_med");
	common_scripts\_destructible::destructible_loopsound("fire_vehicle_med");
	common_scripts\_destructible::destructible_healthdrain(15,0.25,210,"allies");
	common_scripts\_destructible::destructible_state(undefined,undefined,300,"player_only",32,"no_melee");
	common_scripts\_destructible::destructible_loopsound("fire_vehicle_med");
	common_scripts\_destructible::destructible_state(undefined,undefined,400,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_fx("tag_death_fx","explosions/small_vehicle_explosion",0);
	common_scripts\_destructible::destructible_sound("car_explode");
	common_scripts\_destructible::destructible_explode(4000,5000,200,250,50,300,undefined,undefined,0.3,500);
	lib_0D89::func_6F6E(%F,#animtree,"setanimknob",undefined,undefined,"vehicle_80s_sedan1_destroy");
	common_scripts\_destructible::destructible_state(undefined,"vehicle_jeep_destroyed",undefined,32,"_melee");
	common_scripts\_destructible::destructible_part("left_wheel_01_jnt",undefined,20,undefined,undefined,"no_melee");
	lib_0D89::func_7562(%F,#animtree,"setanim",1);
	common_scripts\_destructible::destructible_sound("veh_tire_deflate","llet");
	common_scripts\_destructible::destructible_part("left_wheel_02_jnt","vehicle_jeep_wheel_lf",20,undefined,undefined,"no_melee",undefined,2.7);
	lib_0D89::func_7562(%F,#animtree,"setanim",1);
	common_scripts\_destructible::destructible_sound("veh_tire_deflate","llet");
	common_scripts\_destructible::destructible_part("right_wheel_01_jnt","vehicle_jeep_wheel_lf",20,undefined,undefined,"no_melee",undefined,2.7);
	lib_0D89::func_7562(%F,#animtree,"setanim",1);
	common_scripts\_destructible::destructible_sound("veh_tire_deflate","llet");
	common_scripts\_destructible::destructible_part("right_wheel_02_jnt",undefined,20,undefined,undefined,"no_melee");
	lib_0D89::func_7562(%F,#animtree,"setanim",1);
	common_scripts\_destructible::destructible_sound("veh_tire_deflate","llet");
	var_01 = "tag_glass_front";
	common_scripts\_destructible::destructible_part(var_01,undefined,40,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01 + "_d",undefined,60,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_front_fx","props/car_glass_large");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_light_left_front";
	common_scripts\_destructible::destructible_part(var_01,undefined,20,undefined,undefined,undefined,0.5);
	common_scripts\_destructible::destructible_fx(var_01,"props/car_glass_headlight");
	common_scripts\_destructible::destructible_sound("veh_glass_break_small");
	common_scripts\_destructible::destructible_state(var_01 + "_d");
	var_01 = "tag_light_right_front";
	common_scripts\_destructible::destructible_part(var_01,undefined,20,undefined,undefined,undefined,0.5);
	common_scripts\_destructible::destructible_fx(var_01,"props/car_glass_headlight");
	common_scripts\_destructible::destructible_sound("veh_glass_break_small");
	common_scripts\_destructible::destructible_state(var_01 + "_d");
}

//Function Number: 138
vehicle_jeep(param_00)
{
	common_scripts\_destructible::destructible_create(param_00,"tag_body",250,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_hood_fx","smoke/car_damage_whitesmoke",0.4);
	common_scripts\_destructible::destructible_state(undefined,undefined,200,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_hood_fx","smoke/car_damage_blacksmoke",0.4);
	common_scripts\_destructible::destructible_state(undefined,undefined,100,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_hood_fx","smoke/car_damage_blacksmoke_fire",0.4);
	common_scripts\_destructible::destructible_sound("fire_vehicle_flareup_med");
	common_scripts\_destructible::destructible_loopsound("fire_vehicle_med");
	common_scripts\_destructible::destructible_healthdrain(15,0.25,210,"allies");
	common_scripts\_destructible::destructible_state(undefined,undefined,300,"player_only",32,"no_melee");
	common_scripts\_destructible::destructible_loopsound("fire_vehicle_med");
	common_scripts\_destructible::destructible_state(undefined,undefined,400,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_fx("tag_death_fx","explosions/small_vehicle_explosion",0);
	common_scripts\_destructible::destructible_sound("car_explode");
	common_scripts\_destructible::destructible_explode(4000,5000,200,250,50,300,undefined,undefined,0.3,500);
	lib_0D89::func_6F6E(%F,#animtree,"setanimknob",undefined,undefined,"vehicle_80s_sedan1_destroy");
	common_scripts\_destructible::destructible_state(undefined,"vehicle_uaz_open_dsr",undefined,32,"_melee");
	common_scripts\_destructible::destructible_part("left_wheel_01_jnt","vehicle_uaz_wheel_LF_d",20,undefined,undefined,"no_melee");
	lib_0D89::func_7562(%F,#animtree,"setanim",1);
	common_scripts\_destructible::destructible_sound("veh_tire_deflate","llet");
	common_scripts\_destructible::destructible_part("left_wheel_02_jnt","vehicle_uaz_wheel_LF_d",20,undefined,undefined,"no_melee");
	lib_0D89::func_7562(%F,#animtree,"setanim",1);
	common_scripts\_destructible::destructible_sound("veh_tire_deflate","llet");
	common_scripts\_destructible::destructible_part("right_wheel_01_jnt","vehicle_uaz_wheel_LF_d",20,undefined,undefined,"no_melee");
	lib_0D89::func_7562(%F,#animtree,"setanim",1);
	common_scripts\_destructible::destructible_sound("veh_tire_deflate","llet");
	common_scripts\_destructible::destructible_part("right_wheel_02_jnt","vehicle_uaz_wheel_LF_d",20,undefined,undefined,"no_melee");
	lib_0D89::func_7562(%F,#animtree,"setanim",1);
	common_scripts\_destructible::destructible_sound("veh_tire_deflate","llet");
	var_01 = "tag_glass_front";
	common_scripts\_destructible::destructible_part(var_01,undefined,40,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01 + "_d",undefined,60,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_front_fx","props/car_glass_large");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_glass_back";
	common_scripts\_destructible::destructible_part(var_01,undefined,40,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01 + "_d",undefined,60,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_back_fx","props/car_glass_large");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_glass_left_front";
	common_scripts\_destructible::destructible_part(var_01,undefined,20,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01 + "_d",undefined,60,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_left_front_fx","props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_glass_right_front";
	common_scripts\_destructible::destructible_part(var_01,undefined,20,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01 + "_d",undefined,60,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_right_front_fx","props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_glass_left_back";
	common_scripts\_destructible::destructible_part(var_01,undefined,20,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01 + "_d",undefined,60,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_left_back_fx","props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_glass_right_back";
	common_scripts\_destructible::destructible_part(var_01,undefined,20,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01 + "_d",undefined,60,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_right_back_fx","props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_glass_left_back_02";
	common_scripts\_destructible::destructible_part(var_01,undefined,20,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01 + "_d",undefined,60,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_left_back_02_fx","props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_glass_right_back_02";
	common_scripts\_destructible::destructible_part(var_01,undefined,20,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01 + "_d",undefined,60,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_right_back_02_fx","props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_light_left_front";
	common_scripts\_destructible::destructible_part(var_01,undefined,20,undefined,undefined,undefined,0.5);
	common_scripts\_destructible::destructible_fx(var_01,"props/car_glass_headlight");
	common_scripts\_destructible::destructible_sound("veh_glass_break_small");
	common_scripts\_destructible::destructible_state(var_01 + "_d");
	var_01 = "tag_light_right_front";
	common_scripts\_destructible::destructible_part(var_01,undefined,20,undefined,undefined,undefined,0.5);
	common_scripts\_destructible::destructible_fx(var_01,"props/car_glass_headlight");
	common_scripts\_destructible::destructible_sound("veh_glass_break_small");
	common_scripts\_destructible::destructible_state(var_01 + "_d");
	common_scripts\_destructible::destructible_part("tag_mirror_left","vehicle_uaz_mirror_L",40,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_physics();
	common_scripts\_destructible::destructible_part("tag_mirror_right","vehicle_uaz_mirror_R",40,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_physics();
}

//Function Number: 139
vehicle_jeep_dusty(param_00)
{
	common_scripts\_destructible::destructible_create("vehicle_india_compact_destructible_" + param_00,"tag_body",250,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_hood_fx","smoke/car_damage_whitesmoke",0.4);
	common_scripts\_destructible::destructible_state(undefined,undefined,200,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_hood_fx","smoke/car_damage_blacksmoke",0.4);
	common_scripts\_destructible::destructible_state(undefined,undefined,100,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_hood_fx","smoke/car_damage_blacksmoke_fire",0.4);
	common_scripts\_destructible::destructible_sound("fire_vehicle_flareup_med");
	common_scripts\_destructible::destructible_loopsound("fire_vehicle_med");
	common_scripts\_destructible::destructible_healthdrain(15,0.25,210,"allies");
	common_scripts\_destructible::destructible_state(undefined,undefined,300,"player_only",32,"no_melee");
	common_scripts\_destructible::destructible_loopsound("fire_vehicle_med");
	common_scripts\_destructible::destructible_state(undefined,undefined,400,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_fx("tag_death_fx","explosions/india_compact_explosion",0);
	common_scripts\_destructible::destructible_sound("car_explode");
	common_scripts\_destructible::destructible_explode(4000,5000,200,250,50,300,undefined,undefined,0.3,500);
	lib_0D89::func_6F6E(%F,#animtree,"setanimknob",undefined,undefined,"vehicle_80s_sedan1_destroy");
	common_scripts\_destructible::destructible_state(undefined,"vehicle_india_compact_destroyed_" + param_00,undefined,32,"_melee");
	common_scripts\_destructible::destructible_part("left_wheel_01_jnt",undefined,20,undefined,undefined,"no_melee");
	lib_0D89::func_7562(%F,#animtree,"setanim",1);
	common_scripts\_destructible::destructible_sound("veh_tire_deflate","llet");
	common_scripts\_destructible::destructible_part("left_wheel_02_jnt","vehicle_india_compact_wheel_lf_d",20,undefined,undefined,"no_melee",undefined,1.2);
	lib_0D89::func_7562(%F,#animtree,"setanim",1);
	common_scripts\_destructible::destructible_sound("veh_tire_deflate","llet");
	common_scripts\_destructible::destructible_part("right_wheel_01_jnt",undefined,20,undefined,undefined,"no_melee");
	lib_0D89::func_7562(%F,#animtree,"setanim",1);
	common_scripts\_destructible::destructible_sound("veh_tire_deflate","llet");
	common_scripts\_destructible::destructible_part("right_wheel_02_jnt",undefined,20,undefined,undefined,"no_melee");
	lib_0D89::func_7562(%F,#animtree,"setanim",1);
	common_scripts\_destructible::destructible_sound("veh_tire_deflate","llet");
	var_01 = "tag_glass_front";
	common_scripts\_destructible::destructible_part(var_01,undefined,40,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01 + "_d",undefined,60,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_front_fx","props/car_glass_large");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_glass_back";
	common_scripts\_destructible::destructible_part(var_01,undefined,40,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01 + "_d",undefined,60,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_back_fx","props/car_glass_large");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_glass_left_front";
	common_scripts\_destructible::destructible_part(var_01,undefined,20,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01 + "_d",undefined,60,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_left_front_fx","props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_glass_right_front";
	common_scripts\_destructible::destructible_part(var_01,undefined,20,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01 + "_d",undefined,60,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_right_front_fx","props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_glass_left_back";
	common_scripts\_destructible::destructible_part(var_01,undefined,20,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01 + "_d",undefined,60,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_left_back_fx","props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_glass_right_back";
	common_scripts\_destructible::destructible_part(var_01,undefined,20,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01 + "_d",undefined,60,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_right_back_fx","props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_glass_left_back_02";
	common_scripts\_destructible::destructible_part(var_01,undefined,20,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01 + "_d",undefined,60,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_left_back_02_fx","props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_glass_right_back_02";
	common_scripts\_destructible::destructible_part(var_01,undefined,20,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01 + "_d",undefined,60,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_right_back_02_fx","props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_light_left_front";
	common_scripts\_destructible::destructible_part(var_01,undefined,20,undefined,undefined,undefined,0.5);
	common_scripts\_destructible::destructible_fx(var_01,"props/car_glass_headlight");
	common_scripts\_destructible::destructible_sound("veh_glass_break_small");
	common_scripts\_destructible::destructible_state(var_01 + "_d");
	var_01 = "tag_light_right_front";
	common_scripts\_destructible::destructible_part(var_01,undefined,20,undefined,undefined,undefined,0.5);
	common_scripts\_destructible::destructible_fx(var_01,"props/car_glass_headlight");
	common_scripts\_destructible::destructible_sound("veh_glass_break_small");
	common_scripts\_destructible::destructible_state(var_01 + "_d");
	common_scripts\_destructible::destructible_part("tag_mirror_left","vehicle_india_compact_mirror_l",40,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_physics();
	common_scripts\_destructible::destructible_part("tag_mirror_right","vehicle_india_compact_mirror_r",40,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_physics();
}

//Function Number: 140
vehicle_uaz_open(param_00)
{
	common_scripts\_destructible::destructible_create(param_00,"tag_body",250,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_hood_fx","smoke/car_damage_whitesmoke",0.4);
	common_scripts\_destructible::destructible_state(undefined,undefined,200,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_hood_fx","smoke/car_damage_blacksmoke",0.4);
	common_scripts\_destructible::destructible_state(undefined,undefined,100,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_hood_fx","smoke/rickshaw_damage_blacksmoke_fire",0.4);
	common_scripts\_destructible::destructible_sound("fire_vehicle_flareup_med");
	common_scripts\_destructible::destructible_loopsound("fire_vehicle_med");
	common_scripts\_destructible::destructible_healthdrain(15,0.25,210,"allies");
	common_scripts\_destructible::destructible_state(undefined,undefined,300,"player_only",32,"no_melee");
	common_scripts\_destructible::destructible_loopsound("fire_vehicle_med");
	common_scripts\_destructible::destructible_state(undefined,undefined,400,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_fx("tag_deathfx","explosions/india_rickshaw_explosion",0);
	common_scripts\_destructible::destructible_sound("car_explode");
	common_scripts\_destructible::destructible_explode(4000,5000,200,250,50,300,undefined,undefined,0.3,500);
	lib_0D89::func_6F6E(%F,#animtree,"setanimknob",undefined,undefined,"vehicle_80s_sedan1_destroy");
	common_scripts\_destructible::destructible_state(undefined,"india_vehicle_rksw_d",undefined,32,"_melee");
	var_01 = "tag_glass_front";
	common_scripts\_destructible::destructible_part(var_01,undefined,30,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01 + "_d",undefined,60,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_front_fx","props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_glass_left_front_02";
	common_scripts\_destructible::destructible_part(var_01,undefined,20,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01 + "_d",undefined,60,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_left_front_02_fx","props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_glass_right_front_02";
	common_scripts\_destructible::destructible_part(var_01,undefined,20,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01 + "_d",undefined,60,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_right_front_02_fx","props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	common_scripts\_destructible::destructible_part("tag_headlight_left","intro_vehicle_rksw_light_d",40,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_physics();
}

//Function Number: 141
vehicle_india_compact_destructible(param_00)
{
	common_scripts\_destructible::destructible_create(param_00,"tag_body",250,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_hood_fx","smoke/car_damage_whitesmoke",0.4);
	common_scripts\_destructible::destructible_state(undefined,undefined,200,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_hood_fx","smoke/car_damage_blacksmoke",0.4);
	common_scripts\_destructible::destructible_state(undefined,undefined,100,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_hood_fx","smoke/rickshaw_damage_blacksmoke_fire",0.4);
	common_scripts\_destructible::destructible_sound("fire_vehicle_flareup_med");
	common_scripts\_destructible::destructible_loopsound("fire_vehicle_med");
	common_scripts\_destructible::destructible_healthdrain(15,0.25,210,"allies");
	common_scripts\_destructible::destructible_state(undefined,undefined,300,"player_only",32,"no_melee");
	common_scripts\_destructible::destructible_loopsound("fire_vehicle_med");
	common_scripts\_destructible::destructible_state(undefined,undefined,400,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_fx("tag_death_fx","explosions/india_rickshaw_explosion",0);
	common_scripts\_destructible::destructible_sound("car_explode");
	common_scripts\_destructible::destructible_explode(4000,5000,200,250,50,300,undefined,undefined,0.3,500);
	lib_0D89::func_6F6E(%F,#animtree,"setanimknob",undefined,undefined,"vehicle_80s_sedan1_destroy");
	common_scripts\_destructible::destructible_state(undefined,"vehicle_tuk_tuk_destroyed",undefined,32,"_melee");
	var_01 = "tag_glass_front";
	common_scripts\_destructible::destructible_part(var_01,undefined,30,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01 + "_d",undefined,60,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_front_fx","props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_glass_back";
	common_scripts\_destructible::destructible_part(var_01,undefined,30,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01 + "_d",undefined,60,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_front_fx","props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_glass_left_front";
	common_scripts\_destructible::destructible_part(var_01,undefined,20,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01 + "_d",undefined,60,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx(var_01 + "_fx","props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_glass_right_front";
	common_scripts\_destructible::destructible_part(var_01,undefined,20,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01 + "_d",undefined,60,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx(var_01 + "_fx","props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	common_scripts\_destructible::destructible_part("tag_door_left_front","vehicle_tuk_tuk_door_left",undefined,undefined,undefined,undefined,1,1);
	common_scripts\_destructible::destructible_part("tag_door_left_front","vehicle_tuk_tuk_door_right",undefined,undefined,undefined,undefined,1,1);
	common_scripts\_destructible::destructible_part("tag_mirror_left","vehicle_tuk_tuk_mirror",10,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_physics();
}

//Function Number: 142
vehicle_india_rickshaw(param_00)
{
	common_scripts\_destructible::destructible_create("vehicle_india_suv_" + param_00,"tag_body",250,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_hood_fx","smoke/car_damage_whitesmoke",0.4);
	common_scripts\_destructible::destructible_state(undefined,undefined,200,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_hood_fx","smoke/car_damage_blacksmoke",0.4);
	common_scripts\_destructible::destructible_state(undefined,undefined,100,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_hood_fx","smoke/car_damage_blacksmoke_fire",0.4);
	common_scripts\_destructible::destructible_sound("fire_vehicle_flareup_med");
	common_scripts\_destructible::destructible_loopsound("fire_vehicle_med");
	common_scripts\_destructible::destructible_healthdrain(15,0.25,210,"allies");
	common_scripts\_destructible::destructible_state(undefined,undefined,300,"player_only",32,"no_melee");
	common_scripts\_destructible::destructible_loopsound("fire_vehicle_med");
	common_scripts\_destructible::destructible_state(undefined,undefined,400,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_fx("tag_deathfx","explosions/small_vehicle_explosion",0);
	common_scripts\_destructible::destructible_sound("car_explode");
	common_scripts\_destructible::destructible_explode(4000,5000,200,250,50,300,undefined,undefined,0.3,500);
	lib_0D89::func_6F6E(%F,#animtree,"setanimknob",undefined,undefined,"vehicle_80s_sedan1_destroy");
	common_scripts\_destructible::destructible_state(undefined,"vehicle_india_suv_" + param_00 + "_dsr",undefined,32,"_melee");
	common_scripts\_destructible::destructible_part("left_wheel_01_jnt","vehicle_india_suv_wheel_lf_d",20,undefined,undefined,"no_melee");
	lib_0D89::func_7562(%F,#animtree,"setanim",1);
	common_scripts\_destructible::destructible_sound("veh_tire_deflate","llet");
	common_scripts\_destructible::destructible_part("left_wheel_02_jnt","vehicle_india_suv_wheel_lf_d",20,undefined,undefined,"no_melee");
	lib_0D89::func_7562(%F,#animtree,"setanim",1);
	common_scripts\_destructible::destructible_sound("veh_tire_deflate","llet");
	common_scripts\_destructible::destructible_part("right_wheel_01_jnt","vehicle_india_suv_wheel_rf_d",20,undefined,undefined,"no_melee");
	lib_0D89::func_7562(%F,#animtree,"setanim",1);
	common_scripts\_destructible::destructible_sound("veh_tire_deflate","llet");
	common_scripts\_destructible::destructible_part("right_wheel_02_jnt","vehicle_india_suv_wheel_rf_d",20,undefined,undefined,"no_melee");
	lib_0D89::func_7562(%F,#animtree,"setanim",1);
	common_scripts\_destructible::destructible_sound("veh_tire_deflate","llet");
	var_01 = "tag_glass_front";
	common_scripts\_destructible::destructible_part(var_01,undefined,40,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01 + "_d",undefined,60,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_front_fx","props/car_glass_large");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_glass_back";
	common_scripts\_destructible::destructible_part(var_01,undefined,40,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01 + "_d",undefined,60,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_back_fx","props/car_glass_large");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_glass_left_front";
	common_scripts\_destructible::destructible_part(var_01,undefined,20,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01 + "_d",undefined,60,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_left_front_fx","props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_glass_right_front";
	common_scripts\_destructible::destructible_part(var_01,undefined,20,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01 + "_d",undefined,60,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_right_front_fx","props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_glass_left_back";
	common_scripts\_destructible::destructible_part(var_01,undefined,20,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01 + "_d",undefined,60,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_left_back_fx","props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_glass_right_back";
	common_scripts\_destructible::destructible_part(var_01,undefined,20,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01 + "_d",undefined,60,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_right_back_fx","props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_glass_left_back_02";
	common_scripts\_destructible::destructible_part(var_01,undefined,20,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01 + "_d",undefined,60,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_left_back_02_fx","props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_glass_right_back_02";
	common_scripts\_destructible::destructible_part(var_01,undefined,20,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01 + "_d",undefined,60,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_right_back_02_fx","props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_light_left_front";
	common_scripts\_destructible::destructible_part(var_01,undefined,20,undefined,undefined,undefined,0.5);
	common_scripts\_destructible::destructible_fx(var_01,"props/car_glass_headlight");
	common_scripts\_destructible::destructible_sound("veh_glass_break_small");
	common_scripts\_destructible::destructible_state(var_01 + "_d");
	var_01 = "tag_light_right_front";
	common_scripts\_destructible::destructible_part(var_01,undefined,20,undefined,undefined,undefined,0.5);
	common_scripts\_destructible::destructible_fx(var_01,"props/car_glass_headlight");
	common_scripts\_destructible::destructible_sound("veh_glass_break_small");
	common_scripts\_destructible::destructible_state(var_01 + "_d");
	var_01 = "tag_light_left_back";
	common_scripts\_destructible::destructible_part(var_01,undefined,20,undefined,undefined,undefined,0.5);
	common_scripts\_destructible::destructible_fx(var_01,"props/car_glass_brakelight");
	common_scripts\_destructible::destructible_sound("veh_glass_break_small");
	common_scripts\_destructible::destructible_state(var_01 + "_d");
	var_01 = "tag_light_right_back";
	common_scripts\_destructible::destructible_part(var_01,undefined,20,undefined,undefined,undefined,0.5);
	common_scripts\_destructible::destructible_fx(var_01,"props/car_glass_brakelight");
	common_scripts\_destructible::destructible_sound("veh_glass_break_small");
	common_scripts\_destructible::destructible_state(var_01 + "_d");
	common_scripts\_destructible::destructible_part("tag_mirror_left","vehicle_uaz_mirror_L",40,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_physics();
	common_scripts\_destructible::destructible_part("tag_mirror_right","vehicle_uaz_mirror_R",40,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_physics();
}

//Function Number: 143
vehicle_tuk_tuk(param_00)
{
	common_scripts\_destructible::destructible_create(param_00,"tag_body",250,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_hood_fx","smoke/car_damage_whitesmoke",0.4);
	common_scripts\_destructible::destructible_state(undefined,undefined,200,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_hood_fx","smoke/car_damage_blacksmoke",0.4);
	common_scripts\_destructible::destructible_state(undefined,undefined,100,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_hood_fx","smoke/car_damage_blacksmoke_fire",0.4);
	common_scripts\_destructible::destructible_sound("fire_vehicle_flareup_med");
	common_scripts\_destructible::destructible_loopsound("fire_vehicle_med");
	common_scripts\_destructible::destructible_healthdrain(15,0.25,210,"allies");
	common_scripts\_destructible::destructible_state(undefined,undefined,300,"player_only",32,"no_melee");
	common_scripts\_destructible::destructible_loopsound("fire_vehicle_med");
	common_scripts\_destructible::destructible_state(undefined,undefined,400,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_fx("tag_death_fx","explosions/small_vehicle_explosion",0);
	common_scripts\_destructible::destructible_sound("car_explode_police");
	common_scripts\_destructible::destructible_explode(4000,5000,200,250,50,300,undefined,undefined,0.3,500);
	lib_0D89::func_6F6E(%F,#animtree,"setanimknob",undefined,undefined,"vehicle_80s_sedan1_destroy");
	common_scripts\_destructible::destructible_state(undefined,"vehicle_policecar_lapd_destroy",undefined,32,"_melee");
	common_scripts\_destructible::destructible_part("left_wheel_01_jnt","vehicle_policecar_lapd_wheel_LF",20,undefined,undefined,"no_melee",undefined,1.7);
	lib_0D89::func_7562(%F,#animtree,"setanim");
	common_scripts\_destructible::destructible_sound("veh_tire_deflate","llet");
	common_scripts\_destructible::destructible_part("left_wheel_02_jnt","vehicle_policecar_lapd_wheel_LF",20,undefined,undefined,"no_melee",undefined,1.7);
	lib_0D89::func_7562(%F,#animtree,"setanim");
	common_scripts\_destructible::destructible_sound("veh_tire_deflate","llet");
	common_scripts\_destructible::destructible_part("right_wheel_01_jnt","vehicle_policecar_lapd_wheel_LF",20,undefined,undefined,"no_melee",undefined,1.7);
	lib_0D89::func_7562(%F,#animtree,"setanim");
	common_scripts\_destructible::destructible_sound("veh_tire_deflate","llet");
	common_scripts\_destructible::destructible_part("right_wheel_02_jnt","vehicle_policecar_lapd_wheel_LF",20,undefined,undefined,"no_melee");
	lib_0D89::func_7562(%F,#animtree,"setanim");
	common_scripts\_destructible::destructible_sound("veh_tire_deflate","llet");
	common_scripts\_destructible::destructible_part("tag_door_left_front","vehicle_policecar_lapd_door_LF",undefined,undefined,undefined,undefined,1,1);
	common_scripts\_destructible::destructible_part("tag_door_right_front","vehicle_policecar_lapd_door_RF",undefined,undefined,undefined,undefined,1,1);
	common_scripts\_destructible::destructible_part("tag_door_left_back","vehicle_policecar_lapd_door_LB",undefined,undefined,undefined,undefined,1,1);
	var_01 = "tag_glass_front";
	common_scripts\_destructible::destructible_part(var_01,undefined,40,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01 + "_d",undefined,60,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_front_fx","props/car_glass_large");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_glass_back";
	common_scripts\_destructible::destructible_part(var_01,undefined,40,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01 + "_d",undefined,60,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_back_fx","props/car_glass_large");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_center_glass";
	common_scripts\_destructible::destructible_part(var_01,undefined,40,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01 + "_d",undefined,60,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("TAG_CENTER_GLASS_FX","props/car_glass_large");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_glass_left_front";
	common_scripts\_destructible::destructible_part(var_01,undefined,20,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01 + "_d",undefined,60,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_left_front_fx","props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_glass_right_front";
	common_scripts\_destructible::destructible_part(var_01,undefined,20,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01 + "_d",undefined,60,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_right_front_fx","props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_glass_left_back";
	common_scripts\_destructible::destructible_part(var_01,undefined,20,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01 + "_d",undefined,60,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_left_back_fx","props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_glass_right_back";
	common_scripts\_destructible::destructible_part(var_01,undefined,20,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01 + "_d",undefined,60,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_right_back_fx","props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_light_left_front";
	common_scripts\_destructible::destructible_part(var_01,undefined,20,undefined,undefined,undefined,0.5);
	common_scripts\_destructible::destructible_fx(var_01,"props/car_glass_headlight");
	common_scripts\_destructible::destructible_sound("veh_glass_break_small");
	common_scripts\_destructible::destructible_state(var_01 + "_d");
	var_01 = "tag_light_right_front";
	common_scripts\_destructible::destructible_part(var_01,undefined,20,undefined,undefined,undefined,0.5);
	common_scripts\_destructible::destructible_fx(var_01,"props/car_glass_headlight");
	common_scripts\_destructible::destructible_sound("veh_glass_break_small");
	common_scripts\_destructible::destructible_state(var_01 + "_d");
	common_scripts\_destructible::destructible_part("tag_mirror_left","vehicle_policecar_lapd_mirror_L",40,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_physics();
	common_scripts\_destructible::destructible_part("tag_mirror_right","vehicle_policecar_lapd_mirror_R",40,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_physics();
}

//Function Number: 144
vehicle_india_suv(param_00)
{
	common_scripts\_destructible::destructible_create(param_00,"tag_body",250,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_hood_fx","smoke/car_damage_whitesmoke",0.4);
	common_scripts\_destructible::destructible_state(undefined,undefined,200,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_hood_fx","smoke/car_damage_blacksmoke",0.4);
	common_scripts\_destructible::destructible_state(undefined,undefined,100,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_hood_fx","smoke/car_damage_blacksmoke_fire",0.4);
	common_scripts\_destructible::destructible_sound("fire_vehicle_flareup_med");
	common_scripts\_destructible::destructible_loopsound("fire_vehicle_med");
	common_scripts\_destructible::destructible_healthdrain(15,0.25,210,"allies");
	common_scripts\_destructible::destructible_state(undefined,undefined,300,"player_only",32,"no_melee");
	common_scripts\_destructible::destructible_loopsound("fire_vehicle_med");
	common_scripts\_destructible::destructible_state(undefined,undefined,400,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_fx("tag_death_fx","explosions/small_vehicle_explosion",0);
	common_scripts\_destructible::destructible_sound("car_explode_police");
	common_scripts\_destructible::destructible_explode(4000,5000,200,250,50,300,undefined,undefined,0.3,500);
	lib_0D89::func_6F6E(%F,#animtree,"setanimknob",undefined,undefined,"vehicle_80s_sedan1_destroy");
	common_scripts\_destructible::destructible_state(undefined,"vehicle_policecar_russia_destroy",undefined,32,"_melee");
	common_scripts\_destructible::destructible_part("left_wheel_01_jnt","vehicle_policecar_russia_wheel_LF",20,undefined,undefined,"no_melee",undefined,1.7);
	lib_0D89::func_7562(%F,#animtree,"setanim");
	common_scripts\_destructible::destructible_sound("veh_tire_deflate","llet");
	common_scripts\_destructible::destructible_part("left_wheel_02_jnt","vehicle_policecar_russia_wheel_LF",20,undefined,undefined,"no_melee",undefined,1.7);
	lib_0D89::func_7562(%F,#animtree,"setanim");
	common_scripts\_destructible::destructible_sound("veh_tire_deflate","llet");
	common_scripts\_destructible::destructible_part("right_wheel_01_jnt","vehicle_policecar_russia_wheel_LF",20,undefined,undefined,"no_melee",undefined,1.7);
	lib_0D89::func_7562(%F,#animtree,"setanim");
	common_scripts\_destructible::destructible_sound("veh_tire_deflate","llet");
	common_scripts\_destructible::destructible_part("right_wheel_02_jnt","vehicle_policecar_russia_wheel_LF",20,undefined,undefined,"no_melee");
	lib_0D89::func_7562(%F,#animtree,"setanim");
	common_scripts\_destructible::destructible_sound("veh_tire_deflate","llet");
	common_scripts\_destructible::destructible_part("tag_door_left_front","vehicle_policecar_russia_door_LF",undefined,undefined,undefined,undefined,1,1);
	common_scripts\_destructible::destructible_part("tag_door_right_front","vehicle_policecar_russia_door_RF",undefined,undefined,undefined,undefined,1,1);
	common_scripts\_destructible::destructible_part("tag_door_left_back","vehicle_policecar_russia_door_LB",undefined,undefined,undefined,undefined,1,1);
	var_01 = "tag_glass_front";
	common_scripts\_destructible::destructible_part(var_01,undefined,40,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01 + "_d",undefined,60,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_front_fx","props/car_glass_large");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_glass_back";
	common_scripts\_destructible::destructible_part(var_01,undefined,40,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01 + "_d",undefined,60,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_back_fx","props/car_glass_large");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_center_glass";
	common_scripts\_destructible::destructible_part(var_01,undefined,40,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01 + "_d",undefined,60,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("TAG_CENTER_GLASS_FX","props/car_glass_large");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_glass_left_front";
	common_scripts\_destructible::destructible_part(var_01,undefined,20,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01 + "_d",undefined,60,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_left_front_fx","props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_glass_right_front";
	common_scripts\_destructible::destructible_part(var_01,undefined,20,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01 + "_d",undefined,60,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_right_front_fx","props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_glass_left_back";
	common_scripts\_destructible::destructible_part(var_01,undefined,20,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01 + "_d",undefined,60,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_left_back_fx","props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_glass_right_back";
	common_scripts\_destructible::destructible_part(var_01,undefined,20,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01 + "_d",undefined,60,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_right_back_fx","props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_light_left_front";
	common_scripts\_destructible::destructible_part(var_01,undefined,20,undefined,undefined,undefined,0.5);
	common_scripts\_destructible::destructible_fx(var_01,"props/car_glass_headlight");
	common_scripts\_destructible::destructible_sound("veh_glass_break_small");
	common_scripts\_destructible::destructible_state(var_01 + "_d");
	var_01 = "tag_light_right_front";
	common_scripts\_destructible::destructible_part(var_01,undefined,20,undefined,undefined,undefined,0.5);
	common_scripts\_destructible::destructible_fx(var_01,"props/car_glass_headlight");
	common_scripts\_destructible::destructible_sound("veh_glass_break_small");
	common_scripts\_destructible::destructible_state(var_01 + "_d");
	common_scripts\_destructible::destructible_part("tag_mirror_left","vehicle_policecar_russia_mirror_L",40,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_physics();
	common_scripts\_destructible::destructible_part("tag_mirror_right","vehicle_policecar_russia_mirror_R",40,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_physics();
}

//Function Number: 145
vehicle_policecar(param_00)
{
	common_scripts\_destructible::destructible_create(param_00,"tag_body",250,undefined,32,"no_melee");
	common_scripts\_destructible::random_dynamic_attachment("tag_ad","vehicle_taxi_rooftop_ad_base","vehicle_taxi_rooftop_ad_1");
	common_scripts\_destructible::random_dynamic_attachment("tag_ad","vehicle_taxi_rooftop_ad_base","vehicle_taxi_rooftop_ad_2");
	common_scripts\_destructible::random_dynamic_attachment("tag_ad","vehicle_taxi_rooftop_ad_base","vehicle_taxi_rooftop_ad_3");
	common_scripts\_destructible::random_dynamic_attachment("tag_ad","vehicle_taxi_rooftop_ad_base","vehicle_taxi_rooftop_ad_4");
	common_scripts\_destructible::random_dynamic_attachment("tag_ad","vehicle_taxi_toplight",undefined,"taxi_ad_clip");
	common_scripts\_destructible::destructible_loopfx("tag_hood_fx","smoke/car_damage_whitesmoke",0.4);
	common_scripts\_destructible::destructible_car_alarm();
	common_scripts\_destructible::destructible_state(undefined,undefined,200,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_hood_fx","smoke/car_damage_blacksmoke",0.4);
	common_scripts\_destructible::destructible_state(undefined,undefined,100,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_hood_fx","smoke/car_damage_blacksmoke_fire",0.4);
	common_scripts\_destructible::destructible_sound("fire_vehicle_flareup_med");
	common_scripts\_destructible::destructible_loopsound("fire_vehicle_med");
	common_scripts\_destructible::destructible_healthdrain(15,0.25,210,"allies");
	common_scripts\_destructible::destructible_state(undefined,undefined,300,"player_only",32,"no_melee");
	common_scripts\_destructible::destructible_loopsound("fire_vehicle_med");
	common_scripts\_destructible::destructible_state(undefined,undefined,400,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_fx("tag_death_fx","explosions/small_vehicle_explosion",0);
	common_scripts\_destructible::destructible_sound("car_explode");
	common_scripts\_destructible::destructible_explode(4000,5000,200,250,50,300,undefined,undefined,0.3,500);
	lib_0D89::func_6F6E(%F,#animtree,"setanimknob",undefined,undefined,"vehicle_80s_sedan1_destroy");
	common_scripts\_destructible::destructible_state(undefined,"vehicle_taxi_yellow_destroy",undefined,32,"_melee");
	common_scripts\_destructible::destructible_part("left_wheel_01_jnt",undefined,20,undefined,undefined,"no_melee");
	lib_0D89::func_7562(%F,#animtree,"setanim");
	common_scripts\_destructible::destructible_sound("veh_tire_deflate","llet");
	common_scripts\_destructible::destructible_car_alarm();
	common_scripts\_destructible::destructible_part("left_wheel_02_jnt",undefined,20,undefined,undefined,"no_melee",undefined,1.7);
	lib_0D89::func_7562(%F,#animtree,"setanim");
	common_scripts\_destructible::destructible_sound("veh_tire_deflate","llet");
	common_scripts\_destructible::destructible_car_alarm();
	common_scripts\_destructible::destructible_part("right_wheel_01_jnt",undefined,20,undefined,undefined,"no_melee",undefined,1.7);
	lib_0D89::func_7562(%F,#animtree,"setanim");
	common_scripts\_destructible::destructible_sound("veh_tire_deflate","llet");
	common_scripts\_destructible::destructible_car_alarm();
	common_scripts\_destructible::destructible_part("right_wheel_02_jnt",undefined,20,undefined,undefined,"no_melee");
	lib_0D89::func_7562(%F,#animtree,"setanim");
	common_scripts\_destructible::destructible_sound("veh_tire_deflate","llet");
	common_scripts\_destructible::destructible_car_alarm();
	var_01 = "TAG_CENTER_GLASS";
	common_scripts\_destructible::destructible_part(var_01,undefined,40,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01 + "_d",undefined,60,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_front_fx","props/car_glass_large");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_car_alarm();
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_glass_front";
	common_scripts\_destructible::destructible_part(var_01,undefined,40,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01 + "_d",undefined,60,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_front_fx","props/car_glass_large");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_car_alarm();
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_glass_back";
	common_scripts\_destructible::destructible_part(var_01,undefined,40,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01 + "_d",undefined,60,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_back_fx","props/car_glass_large");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_car_alarm();
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_glass_left_front";
	common_scripts\_destructible::destructible_part(var_01,undefined,20,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01 + "_d",undefined,60,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_left_front_fx","props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_car_alarm();
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_glass_right_front";
	common_scripts\_destructible::destructible_part(var_01,undefined,20,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01 + "_d",undefined,60,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_right_front_fx","props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_car_alarm();
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_glass_left_back";
	common_scripts\_destructible::destructible_part(var_01,undefined,20,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01 + "_d",undefined,60,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_left_back_fx","props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_car_alarm();
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_glass_right_back";
	common_scripts\_destructible::destructible_part(var_01,undefined,20,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01 + "_d",undefined,60,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_right_back_fx","props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_car_alarm();
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_light_left_front";
	common_scripts\_destructible::destructible_part(var_01,undefined,20,undefined,undefined,undefined,0.5);
	common_scripts\_destructible::destructible_fx(var_01,"props/car_glass_headlight");
	common_scripts\_destructible::destructible_sound("veh_glass_break_small");
	common_scripts\_destructible::destructible_state(var_01 + "_d");
	var_01 = "tag_light_right_front";
	common_scripts\_destructible::destructible_part(var_01,undefined,20,undefined,undefined,undefined,0.5);
	common_scripts\_destructible::destructible_fx(var_01,"props/car_glass_headlight");
	common_scripts\_destructible::destructible_sound("veh_glass_break_small");
	common_scripts\_destructible::destructible_state(var_01 + "_d");
	common_scripts\_destructible::destructible_part("tag_mirror_left","vehicle_taxi_mirror_l",40,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_physics();
	common_scripts\_destructible::destructible_part("tag_mirror_right","vehicle_taxi_mirror_r",40,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_physics();
}

//Function Number: 146
vehicle_policecar_russia(param_00)
{
	common_scripts\_destructible::destructible_create(param_00,"tag_body",250,undefined,32,"no_melee");
	common_scripts\_destructible::random_dynamic_attachment("tag_ad","vehicle_taxi_toplight_dubai",undefined,"taxi_ad_clip");
	common_scripts\_destructible::destructible_loopfx("tag_hood_fx","smoke/car_damage_whitesmoke",0.4);
	common_scripts\_destructible::destructible_car_alarm();
	common_scripts\_destructible::destructible_state(undefined,undefined,200,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_hood_fx","smoke/car_damage_blacksmoke",0.4);
	common_scripts\_destructible::destructible_state(undefined,undefined,100,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_hood_fx","smoke/car_damage_blacksmoke_fire",0.4);
	common_scripts\_destructible::destructible_sound("fire_vehicle_flareup_med");
	common_scripts\_destructible::destructible_loopsound("fire_vehicle_med");
	common_scripts\_destructible::destructible_healthdrain(15,0.25,210,"allies");
	common_scripts\_destructible::destructible_state(undefined,undefined,300,"player_only",32,"no_melee");
	common_scripts\_destructible::destructible_loopsound("fire_vehicle_med");
	common_scripts\_destructible::destructible_state(undefined,undefined,400,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_fx("tag_death_fx","explosions/small_vehicle_explosion",0);
	common_scripts\_destructible::destructible_sound("car_explode");
	common_scripts\_destructible::destructible_explode(4000,5000,200,250,50,300,undefined,undefined,0.3,500);
	lib_0D89::func_6F6E(%F,#animtree,"setanimknob",undefined,undefined,"vehicle_80s_sedan1_destroy");
	common_scripts\_destructible::destructible_state(undefined,"vehicle_taxi_yellow_destroy_dubai",undefined,32,"_melee");
	common_scripts\_destructible::destructible_part("left_wheel_01_jnt",undefined,20,undefined,undefined,"no_melee");
	lib_0D89::func_7562(%F,#animtree,"setanim");
	common_scripts\_destructible::destructible_sound("veh_tire_deflate","llet");
	common_scripts\_destructible::destructible_car_alarm();
	common_scripts\_destructible::destructible_part("left_wheel_02_jnt",undefined,20,undefined,undefined,"no_melee",undefined,1.7);
	lib_0D89::func_7562(%F,#animtree,"setanim");
	common_scripts\_destructible::destructible_sound("veh_tire_deflate","llet");
	common_scripts\_destructible::destructible_car_alarm();
	common_scripts\_destructible::destructible_part("right_wheel_01_jnt",undefined,20,undefined,undefined,"no_melee",undefined,1.7);
	lib_0D89::func_7562(%F,#animtree,"setanim");
	common_scripts\_destructible::destructible_sound("veh_tire_deflate","llet");
	common_scripts\_destructible::destructible_car_alarm();
	common_scripts\_destructible::destructible_part("right_wheel_02_jnt",undefined,20,undefined,undefined,"no_melee");
	lib_0D89::func_7562(%F,#animtree,"setanim");
	common_scripts\_destructible::destructible_sound("veh_tire_deflate","llet");
	common_scripts\_destructible::destructible_car_alarm();
	var_01 = "TAG_CENTER_GLASS";
	common_scripts\_destructible::destructible_part(var_01,undefined,40,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01 + "_d",undefined,60,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_front_fx","props/car_glass_large");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_car_alarm();
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_glass_front";
	common_scripts\_destructible::destructible_part(var_01,undefined,40,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01 + "_d",undefined,60,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_front_fx","props/car_glass_large");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_car_alarm();
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_glass_back";
	common_scripts\_destructible::destructible_part(var_01,undefined,40,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01 + "_d",undefined,60,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_back_fx","props/car_glass_large");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_car_alarm();
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_glass_left_front";
	common_scripts\_destructible::destructible_part(var_01,undefined,20,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01 + "_d",undefined,60,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_left_front_fx","props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_car_alarm();
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_glass_right_front";
	common_scripts\_destructible::destructible_part(var_01,undefined,20,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01 + "_d",undefined,60,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_right_front_fx","props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_car_alarm();
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_glass_left_back";
	common_scripts\_destructible::destructible_part(var_01,undefined,20,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01 + "_d",undefined,60,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_left_back_fx","props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_car_alarm();
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_glass_right_back";
	common_scripts\_destructible::destructible_part(var_01,undefined,20,undefined,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_state(var_01 + "_d",undefined,60,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_glass_right_back_fx","props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_car_alarm();
	common_scripts\_destructible::destructible_state(undefined);
	var_01 = "tag_light_left_front";
	common_scripts\_destructible::destructible_part(var_01,undefined,20,undefined,undefined,undefined,0.5);
	common_scripts\_destructible::destructible_fx(var_01,"props/car_glass_headlight");
	common_scripts\_destructible::destructible_sound("veh_glass_break_small");
	common_scripts\_destructible::destructible_state(var_01 + "_d");
	var_01 = "tag_light_right_front";
	common_scripts\_destructible::destructible_part(var_01,undefined,20,undefined,undefined,undefined,0.5);
	common_scripts\_destructible::destructible_fx(var_01,"props/car_glass_headlight");
	common_scripts\_destructible::destructible_sound("veh_glass_break_small");
	common_scripts\_destructible::destructible_state(var_01 + "_d");
	common_scripts\_destructible::destructible_part("tag_mirror_left","vehicle_taxi_mirror_l",40,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_physics();
	common_scripts\_destructible::destructible_part("tag_mirror_right","vehicle_taxi_mirror_r",40,undefined,undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_physics();
}

//Function Number: 147
vehicle_taxi(param_00)
{
	common_scripts\_destructible::destructible_create(param_00,"tag_camera_tilt",0,undefined,32);
	common_scripts\_destructible::destructible_anim(destructible_gaspump("ecurity_camera_idle"),#animtree,"setanimknob",undefined,undefined,"security_camera_idle");
	common_scripts\_destructible::destructible_state("tag_camera_tilt","com_security_camera_tilt_animated",75);
	common_scripts\_destructible::destructible_anim(destructible_gaspump("ecurity_camera_destroy"),#animtree,"setanimknob",undefined,undefined,"security_camera_destroy");
	common_scripts\_destructible::destructible_fx("tag_fx","props/security_camera_explosion_moving");
	common_scripts\_destructible::destructible_sound("security_camera_sparks");
	common_scripts\_destructible::destructible_state(undefined,"com_security_camera_d_tilt_animated",undefined,undefined,"no_melee");
}

//Function Number: 148
vehicle_taxi_dubai(param_00)
{
	common_scripts\_destructible::destructible_create(param_00,"tag_origin",100,undefined,32);
	common_scripts\_destructible::destructible_anim(destructible_gaspump("c130_building_collapse"),#animtree,"setanimknob",undefined,undefined,"ac130_building_collapse");
	common_scripts\_destructible::destructible_fx("tag_fx","misc/building_collapse_paris_ac130");
	common_scripts\_destructible::destructible_fx("tag_fx_base","misc/building_collapse_paris_ac130_ground");
	common_scripts\_destructible::destructible_fx("tag_fx_crack","misc/building_collapse_paris_ac130_cracks");
	common_scripts\_destructible::destructible_state(undefined,"building_collapse_paris_ac130_dest",undefined,undefined,"no_melee");
}

//Function Number: 149
toy_security_camera(param_00)
{
	common_scripts\_destructible::destructible_create(param_00,"tag_origin",100,undefined,32);
	common_scripts\_destructible::destructible_anim(destructible_gaspump("ondon_gas_attack"),#animtree,"setanimknob",undefined,undefined,"london_gas_attack");
	common_scripts\_destructible::destructible_fx("tag_origin","smoke/poison_gas_attack");
	common_scripts\_destructible::destructible_state(undefined,"fx_gas_attack",undefined,undefined,"no_melee");
}

//Function Number: 150
toy_building_collapse_paris_ac130(param_00)
{
	common_scripts\_destructible::destructible_create("toy_arcade_machine" + param_00,"tag_origin",0,undefined,32);
	common_scripts\_destructible::destructible_state("tag_origin","arcade_machine" + param_00,75);
	common_scripts\_destructible::destructible_fx("tag_fx","props/arcade_machine_exp");
	common_scripts\_destructible::destructible_fx("tag_fx2","props/arcade_machine_coins");
	common_scripts\_destructible::destructible_sound("arcade_machine_destroy");
	common_scripts\_destructible::destructible_state(undefined,"arcade_machine" + param_00 + "_des",undefined,undefined,"no_melee");
}

//Function Number: 151
toy_poison_gas_attack(param_00)
{
	common_scripts\_destructible::destructible_create("toy_pinball_machine" + param_00,"tag_origin",0,undefined,32);
	common_scripts\_destructible::destructible_state("tag_origin","pinball_machine" + param_00,75);
	common_scripts\_destructible::destructible_fx("tag_fx","props/pinball_machine_exp",undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_fx2","props/arcade_machine_coins");
	common_scripts\_destructible::destructible_fx("tag_fx3","props/pinball_machine_glass");
	common_scripts\_destructible::destructible_sound("pinball_machine_destroy");
	common_scripts\_destructible::destructible_state(undefined,"pinball_machine" + param_00 + "_des",undefined,undefined,"no_melee");
}

//Function Number: 152
toy_arcade_machine(param_00)
{
	common_scripts\_destructible::destructible_create(param_00,"tag_origin",0,undefined,32);
	common_scripts\_destructible::destructible_loopsound("fortune_machine_idle");
	common_scripts\_destructible::destructible_loopfx("J_Eye_RI","props/fortune_machine_glow_eyes",2.9);
	common_scripts\_destructible::destructible_loopfx("J_Eye_LE","props/fortune_machine_glow_eyes",2.9);
	common_scripts\_destructible::destructible_loopfx("tag_fx3","props/fortune_machine_glow_ball",4);
	common_scripts\_destructible::destructible_anim(destructible_gaspump("ortune_machine_anim"),#animtree,"setanimknob",undefined,undefined,"fortune_machine_anim");
	common_scripts\_destructible::destructible_state("tag_origin","fortune_machine",75);
	common_scripts\_destructible::destructible_fx("tag_fx","props/fortune_machine_exp",undefined,undefined,undefined,1);
	common_scripts\_destructible::destructible_fx("tag_fx2","props/fortune_machine_tickets");
	common_scripts\_destructible::destructible_sound("pinball_machine_destroy");
	common_scripts\_destructible::destructible_anim(destructible_gaspump("ortune_machine_des"),#animtree,"setanimknob",undefined,undefined,"fortune_machine_des");
	common_scripts\_destructible::destructible_explode(20,2000,20,20,40,40,undefined,64);
	common_scripts\_destructible::destructible_state(undefined,"fortune_machine_des",undefined,undefined,"no_melee");
}

//Function Number: 153
toy_pinball_machine(param_00)
{
	common_scripts\_destructible::destructible_create(param_00,"tag_origin",120,undefined,32);
	common_scripts\_destructible::destructible_fx("tag_fx","props/garbage_spew_des",1,"splash");
	common_scripts\_destructible::destructible_fx("tag_fx","props/garbage_spew",1,common_scripts\_destructible::damage_not("splash"));
	common_scripts\_destructible::destructible_sound("exp_trashcan_sweet");
	common_scripts\_destructible::destructible_explode(600,651,1,1,10,20);
	common_scripts\_destructible::destructible_state("tag_origin","trashcan_clown_base",undefined,undefined,undefined,undefined,undefined,0);
	common_scripts\_destructible::destructible_part("tag_fx","trashcan_clown_lid",undefined,undefined,undefined,undefined,1,1);
}

//Function Number: 154
toy_fortune_machine(param_00)
{
	common_scripts\_destructible::destructible_create(param_00,"tag_origin",25,undefined,32);
	common_scripts\_destructible::destructible_fx("tag_origin","dust/dust_shanty_explode");
	common_scripts\_destructible::destructible_anim(destructible_gaspump("fr_shanty01_explode"),#animtree,"setanimknob",undefined,undefined,"afr_shanty01_explode");
	common_scripts\_destructible::destructible_state(undefined,"afr_shanty01",undefined,undefined,"no_melee");
}

//Function Number: 155
toy_trashcan_clown(param_00)
{
	common_scripts\_destructible::destructible_create(param_00,"tag_origin",1,undefined,32);
	common_scripts\_destructible::destructible_anim(destructible_gaspump("y_harbor_slava_r2a_des"),#animtree,"setanim");
	common_scripts\_destructible::destructible_fx("tag_explosionA","maps/ny_harbor/ny_battleship_explosion");
	common_scripts\_destructible::destructible_fx("tag_explosionB","maps/ny_harbor/ny_battleship_explosion");
}

//Function Number: 156
toy_afrshanty1(param_00)
{
	common_scripts\_destructible::destructible_create(param_00,"tag_origin",5,undefined,undefined);
	common_scripts\_destructible::destructible_fx("tag_fx1","props/skylight_destroyed_windowglass");
	common_scripts\_destructible::destructible_fx("tag_fx4","props/skylight_destroyed_windowglass");
	common_scripts\_destructible::destructible_fx("tag_fx7","props/skylight_destroyed_windowglass");
	common_scripts\_destructible::destructible_fx("tag_fx4","props/skylight_destroyed_pit");
	common_scripts\_destructible::destructible_state("tag_origin","ny_rooftop_skylight_destroyed",undefined,undefined,"no_melee");
}

//Function Number: 157
vehicle_slava_ny_harbor_zonea(param_00)
{
	common_scripts\_destructible::destructible_create(param_00,"tag_origin",150,undefined,32);
	common_scripts\_destructible::destructible_fx("tag_origin","props/satellite_dish_big_des");
	common_scripts\_destructible::destructible_state("tag_origin","com_satellite_dish_big_destroyed",undefined,undefined,"no_melee");
}

//Function Number: 158
rooftop_skylight_destructible(param_00,param_01,param_02,param_03)
{
	common_scripts\_destructible::destructible_create(param_00,"tag_origin",150,undefined,32);
	common_scripts\_destructible::destructible_fx("tag_fx",param_02);
	common_scripts\_destructible::destructible_state("tag_origin",param_01,undefined,undefined,"no_meele");
	if(isdefined(param_03))
	{
		common_scripts\_destructible::destructible_sound(param_03);
	}
}

//Function Number: 159
satellite_dish_big_destructible(param_00,param_01,param_02,param_03)
{
	common_scripts\_destructible::destructible_create(param_00,"tag_origin",1150,undefined,32);
	common_scripts\_destructible::destructible_state("tag_origin",param_01,undefined,undefined,"no_meele");
	common_scripts\_destructible::destructible_fx("tag_fx",param_02);
	common_scripts\_destructible::destructible_fx("tag_fx",param_02);
}

//Function Number: 160
dest_onestate(param_00,param_01)
{
	common_scripts\_destructible::destructible_create(param_00,"tag_origin",150,undefined,32);
	common_scripts\_destructible::destructible_fx("tag_fx","misc/light_blowout_ceiling");
	common_scripts\_destructible::destructible_fx("tag_fx_wire","misc/light_blowout_wire_spark");
	common_scripts\_destructible::destructible_state("tag_origin",param_01,undefined,undefined,"no_meele");
}

//Function Number: 161
dest_pb_planter(param_00)
{
	common_scripts\_destructible::destructible_create(param_00,"tag_origin",250,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_state("tag_origin","rus_vx_gas_canister_destroyed",250,undefined,32,"no_melee");
	common_scripts\_destructible::destructible_fx(undefined,"explosions/rus_vx_gas_canister",0);
	common_scripts\_destructible::destructible_explode(7000,8000,150,256,16,150,undefined);
}