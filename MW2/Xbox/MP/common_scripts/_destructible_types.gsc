/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: common_scripts\_destructible_types.gsc
 * Game: Call of Duty: Modern Warfare 2
 * Platform: Xbox
*******************************************************************/

maketype(destructibletype)
{
	infoindex = getinfoindex(destructibletype);
	if(infoindex >= 0)
	{
		return infoindex;
	}

	switch(destructibletype)
	{
		case "toy_glass120x110":
			toy_glass("120x110");
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

		case "toy_tubetv_tv1":
			toy_tubetv_("tv1");
			break;

		case "toy_tubetv_tv2":
			toy_tubetv_("tv2");
			break;

		case "toy_tv_flatscreen_01":
			toy_tvs_flatscreen("01", "");
			break;

		case "toy_tv_flatscreen_02":
			toy_tvs_flatscreen("02", "");
			break;

		case "toy_tv_flatscreen_wallmount_01":
			toy_tvs_flatscreen("01", "wallmount_");
			break;

		case "toy_tv_flatscreen_wallmount_02":
			toy_tvs_flatscreen("02", "wallmount_");
			break;

		case "toy_transformer_ratnest01":
			toy_transformer_ratnest01(destructibletype);
			break;

		case "toy_transformer_small01":
			toy_transformer_small01(destructibletype);
			break;

		case "toy_generator":
			toy_generator(destructibletype);
			break;

		case "toy_generator_on":
			toy_generator_on(destructibletype);
			break;

		case "toy_oxygen_tank_01":
			toy_oxygen_tank("01");
			break;

		case "toy_oxygen_tank_02":
			toy_oxygen_tank("02");
			break;

		case "toy_electricbox2":
			toy_electricbox2(destructibletype);
			break;

		case "toy_electricbox4":
			toy_electricbox4(destructibletype);
			break;

		case "toy_airconditioner":
			toy_airconditioner(destructibletype);
			break;

		case "toy_ceiling_fan":
			toy_ceiling_fan(destructibletype);
			break;

		case "toy_wall_fan":
			toy_wall_fan(destructibletype);
			break;

		case "toy_propane_tank02":
			toy_propane_tank02(destructibletype);
			break;

		case "toy_propane_tank02_small":
			toy_propane_tank02_small(destructibletype);
			break;

		case "toy_copier":
			toy_copier(destructibletype);
			break;

		case "toy_firehydrant":
			toy_firehydrant(destructibletype);
			break;

		case "toy_parkingmeter":
			toy_parkingmeter(destructibletype);
			break;

		case "toy_mailbox":
			toy_mailbox(destructibletype);
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
			toy_newspaper_stand_red(destructibletype);
			break;

		case "toy_newspaper_stand_blue":
			toy_newspaper_stand_blue(destructibletype);
			break;

		case "toy_filecabinet":
			toy_filecabinet(destructibletype);
			break;

		case "toy_trashbin_01":
			toy_trashbin_01(destructibletype);
			break;

		case "toy_trashbin_02":
			toy_trashbin_02(destructibletype);
			break;

		case "toy_recyclebin_01":
			toy_recyclebin_01(destructibletype);
			break;

		case "toy_trashcan_metal_closed":
			toy_trashcan_metal_closed(destructibletype);
			break;

		case "toy_water_collector":
			toy_water_collector(destructibletype);
			break;

		case "toy_foliage_tree_oak_1":
			toy_foliage_tree_oak_1(destructibletype);
			break;

		case "toy_usa_gas_station_trash_bin_01":
			toy_usa_gas_station_trash_bin_01(destructibletype);
			break;

		case "toy_usa_gas_station_trash_bin_02":
			toy_usa_gas_station_trash_bin_02(destructibletype);
			break;

		case "toy_light_ceiling_round":
			toy_light_ceiling_round(destructibletype);
			break;

		case "toy_light_ceiling_fluorescent":
			toy_light_ceiling_fluorescent(destructibletype);
			break;

		case "toy_light_ceiling_fluorescent_spotlight":
			toy_light_ceiling_fluorescent_spotlight(destructibletype);
			break;

		case "toy_light_ceiling_fluorescent_single":
			toy_light_ceiling_fluorescent_single(destructibletype);
			break;

		case "toy_light_ceiling_fluorescent_single_spotlight":
			toy_light_ceiling_fluorescent_single_spotlight(destructibletype);
			break;

		case "toy_bookstore_bookstand4_books":
			toy_bookstore_bookstand4_books(destructibletype);
			break;

		case "toy_locker_double":
			toy_locker_double(destructibletype);
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

		case "vehicle_bus_destructible":
			vehicle_bus_destructible();
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

		case "vehicle_small_hatch_blue":
			vehicle_small_hatch("blue");
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
			vehicle_pickup(destructibletype);
			break;

		case "vehicle_hummer":
			vehicle_hummer(destructibletype);
			break;

		case "vehicle_moving_truck":
			vehicle_moving_truck(destructibletype);
			break;

		case "vehicle_bm21_mobile_bed":
			vehicle_bm21(destructibletype, "vehicle_bm21_mobile_bed_dstry");
			break;

		case "vehicle_bm21_cover":
			vehicle_bm21(destructibletype, "vehicle_bm21_mobile_cover_dstry");
			break;

		case "vehicle_luxurysedan_2008":
			vehicle_luxurysedan("");
			break;

		case "vehicle_luxurysedan_2008_gray":
			vehicle_luxurysedan("_gray");
			break;

		case "vehicle_luxurysedan_2008_white":
			vehicle_luxurysedan("_white");
			break;

		case "vehicle_uaz_winter":
			vehicle_uaz_winter(destructibletype);
			break;

		case "vehicle_uaz_fabric":
			vehicle_uaz_fabric(destructibletype);
			break;

		case "vehicle_uaz_hardtop":
			vehicle_uaz_hardtop(destructibletype);
			break;

		case "vehicle_uaz_open":
			vehicle_uaz_open(destructibletype);
			break;

		case "vehicle_policecar":
			vehicle_policecar(destructibletype);
			break;

		case "vehicle_policecar_russia":
			vehicle_policecar_russia(destructibletype);
			break;

		case "vehicle_taxi":
			vehicle_taxi(destructibletype);
			break;

		case "vehicle_mig29_landed":
			vehicle_mig29_landed(destructibletype);
			break;

		case "vehicle_mack_truck_short_snow":
			vehicle_mack_truck_short("snow");
			break;

		case "vehicle_mack_truck_short_green":
			vehicle_mack_truck_short("green");
			break;

		case "vehicle_mack_truck_short_white":
			vehicle_mack_truck_short("white");
			break;

		case "vehicle_motorcycle_01":
			vehicle_motorcycle("01");
			break;

		case "vehicle_motorcycle_02":
			vehicle_motorcycle("02");
			break;

		case "vehicle_subcompact_black":
			vehicle_subcompact("black");
			break;

		case "vehicle_subcompact_blue":
			vehicle_subcompact("blue");
			break;

		case "vehicle_subcompact_dark_gray":
			vehicle_subcompact("dark_gray");
			break;

		case "vehicle_subcompact_deep_blue":
			vehicle_subcompact("deep_blue");
			break;

		case "vehicle_subcompact_gold":
			vehicle_subcompact("gold");
			break;

		case "vehicle_subcompact_gray":
			vehicle_subcompact("gray");
			break;

		case "vehicle_subcompact_green":
			vehicle_subcompact("green");
			break;

		case "vehicle_subcompact_mica":
			vehicle_subcompact("mica");
			break;

		case "vehicle_subcompact_slate":
			vehicle_subcompact("slate");
			break;

		case "vehicle_subcompact_tan":
			vehicle_subcompact("tan");
			break;

		case "vehicle_subcompact_white":
			vehicle_subcompact("white");
			break;

		case "vehicle_coupe_black":
			vehicle_coupe("black");
			break;

		case "vehicle_coupe_blue":
			vehicle_coupe("blue");
			break;

		case "vehicle_coupe_dark_gray":
			vehicle_coupe("dark_gray");
			break;

		case "vehicle_coupe_deep_blue":
			vehicle_coupe("deep_blue");
			break;

		case "vehicle_coupe_gold":
			vehicle_coupe("gold");
			break;

		case "vehicle_coupe_gray":
			vehicle_coupe("gray");
			break;

		case "vehicle_coupe_green":
			vehicle_coupe("green");
			break;

		case "vehicle_coupe_mica":
			vehicle_coupe("mica");
			break;

		case "vehicle_coupe_slate":
			vehicle_coupe("slate");
			break;

		case "vehicle_coupe_tan":
			vehicle_coupe("tan");
			break;

		case "vehicle_coupe_white":
			vehicle_coupe("white");
			break;

		case "vehicle_van_black":
			vehicle_van("black");
			break;

		case "vehicle_van_blue":
			vehicle_van("blue");
			break;

		case "vehicle_van_dark_gray":
			vehicle_van("dark_gray");
			break;

		case "vehicle_van_deep_blue":
			vehicle_van("deep_blue");
			break;

		case "vehicle_van_gold":
			vehicle_van("gold");
			break;

		case "vehicle_van_gray":
			vehicle_van("gray");
			break;

		case "vehicle_van_green":
			vehicle_van("green");
			break;

		case "vehicle_van_mica":
			vehicle_van("mica");
			break;

		case "vehicle_van_slate":
			vehicle_van("slate");
			break;

		case "vehicle_van_tan":
			vehicle_van("tan");
			break;

		case "vehicle_van_white":
			vehicle_van("white");
			break;

		case "vehicle_suburban":
			vehicle_suburban(destructibletype, "");
			break;

		case "vehicle_suburban_beige":
			vehicle_suburban(destructibletype, "_beige");
			break;

		case "vehicle_suburban_dull":
			vehicle_suburban(destructibletype, "_dull");
			break;

		case "vehicle_suburban_red":
			vehicle_suburban(destructibletype, "_red");
			break;

		case "vehicle_snowmobile":
			vehicle_snowmobile(destructibletype);
			break;

		case "destructible_gaspump":
			destructible_gaspump(destructibletype);
			break;

		case "destructible_electrical_transformer_large":
			destructible_electrical_transformer_large(destructibletype);
			break;

		default:
			break;
	}

	infoindex = getinfoindex(destructibletype);
	return infoindex;
}

getinfoindex(destructibletype)
{
	if(!isdefined(level.destructible_type))
	{
		return -1;
	}

	if(level.destructible_type.size == 0)
	{
		return -1;
	}

	for(i = 0;i < level.destructible_type.size;i++)
	{
		if(destructibletype == level.destructible_type[i].v["type"])
		{
			return i;
		}
	}

	return -1;
}

toy_glass(size)
{
	common_scripts\_destructible::destructible_create("toy_glass" + size, "tag_origin", 50);
	common_scripts\_destructible::destructible_splash_damage_scaler(5);
	common_scripts\_destructible::destructible_sound("building_glass_shatter");
	tag = "tag_glass";
	common_scripts\_destructible::destructible_part(tag, undefined, 40, undefined, undefined, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_state(tag + "_d", undefined, 200, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_fx(tag, "props/highrise_glass_" + size);
	common_scripts\_destructible::destructible_sound("building_glass_blowout");
	common_scripts\_destructible::destructible_state(tag + "_des", undefined, 100, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_fx(tag, "props/highrise_glass_" + size + "_edge");
	common_scripts\_destructible::destructible_sound("building_glass_blowout");
	common_scripts\_destructible::destructible_state(undefined);
}

toy_dt_mirror(size)
{
	common_scripts\_destructible::destructible_create("toy_dt_mirror" + size, "tag_origin", 150, undefined, 32);
	common_scripts\_destructible::destructible_splash_damage_scaler(5);
	common_scripts\_destructible::destructible_fx("tag_fx", "props/mirror_shatter" + size);
	common_scripts\_destructible::destructible_sound("mirror_shatter");
	common_scripts\_destructible::destructible_state("tag_origin", "dt_mirror" + size + "_dam", 150, undefined);
	common_scripts\_destructible::destructible_fx("tag_fx", "props/mirror_dt_panel" + size + "_broken");
	common_scripts\_destructible::destructible_explode(1000, 2000, 32, 32, 32, 48, undefined, 0);
	common_scripts\_destructible::destructible_state("tag_origin", "dt_mirror" + size + "_des", 150, undefined);
}

toy_tubetv_(param_98F)
{
	common_scripts\_destructible::destructible_create("toy_tubetv_" + param_98F, "tag_origin", 1, undefined, 32);
	common_scripts\_destructible::destructible_splash_damage_scaler(1);
	common_scripts\_destructible::destructible_fx("tag_fx", "explosions/tv_explosion");
	common_scripts\_destructible::destructible_sound("tv_shot_burst");
	common_scripts\_destructible::destructible_explode(20, 2000, 9, 9, 3, 3, undefined, 12);
	common_scripts\_destructible::destructible_state(undefined, "com_" + param_98F + "_d", undefined, undefined, "no_melee");
}

toy_tvs_flatscreen(param_98F, param_990)
{
	common_scripts\_destructible::destructible_create("toy_tv_flatscreen_" + param_990 + param_98F, "tag_origin", 1, undefined, 32);
	common_scripts\_destructible::destructible_splash_damage_scaler(1);
	common_scripts\_destructible::destructible_fx("tag_fx", "explosions/tv_flatscreen_explosion");
	common_scripts\_destructible::destructible_sound("tv_shot_burst");
	common_scripts\_destructible::destructible_explode(20, 2000, 10, 10, 3, 3, undefined, 15);
	common_scripts\_destructible::destructible_state(undefined, "ma_flatscreen_tv_" + param_990 + "broken_" + param_98F, 200, undefined, "no_melee");
}

toy_transformer_ratnest01(destructibletype)
{
	common_scripts\_destructible::destructible_create(destructibletype, "tag_origin", 75, undefined, 32, "no_melee");
	common_scripts\_destructible::destructible_splash_damage_scaler(15);
	common_scripts\_destructible::destructible_loopfx("tag_fx", "smoke/car_damage_whitesmoke", 0.4);
	common_scripts\_destructible::destructible_state(undefined, undefined, 75, undefined, 32, "no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_fx", "smoke/car_damage_blacksmoke", 0.4);
	common_scripts\_destructible::destructible_state(undefined, undefined, 150, undefined, 32, "no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_sparks", "explosions/transformer_spark_runner", 0.5);
	common_scripts\_destructible::destructible_loopsound("transformer_spark_loop");
	common_scripts\_destructible::destructible_healthdrain(24, 0.2);
	common_scripts\_destructible::destructible_state(undefined, undefined, 250, undefined, 32, "no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_sparks", "explosions/transformer_spark_runner", 0.5);
	common_scripts\_destructible::destructible_loopfx("tag_fx", "fire/transformer_blacksmoke_fire", 0.4);
	common_scripts\_destructible::destructible_sound("transformer01_flareup_med");
	common_scripts\_destructible::destructible_loopsound("transformer_spark_loop");
	common_scripts\_destructible::destructible_healthdrain(24, 0.2, 150, "allies");
	common_scripts\_destructible::destructible_state(undefined, undefined, 400, undefined, 5, "no_melee");
	common_scripts\_destructible::destructible_fx("tag_fx", "explosions/transformer_explosion", 0);
	common_scripts\_destructible::destructible_fx("tag_fx", "fire/firelp_small_pm");
	common_scripts\_destructible::destructible_sound("transformer01_explode");
	common_scripts\_destructible::destructible_explode(7000, 8000, 150, 256, 16, 100, undefined, 0);
	common_scripts\_destructible::destructible_state(undefined, "utility_transformer_ratnest01_dest", undefined, undefined, "no_melee");
}

toy_transformer_small01(destructibletype)
{
	common_scripts\_destructible::destructible_create(destructibletype, "tag_origin", 75, undefined, 32, "no_melee");
	common_scripts\_destructible::destructible_splash_damage_scaler(15);
	common_scripts\_destructible::destructible_loopfx("tag_fx", "smoke/car_damage_whitesmoke", 0.4);
	common_scripts\_destructible::destructible_state(undefined, undefined, 75, undefined, 32, "no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_fx", "smoke/car_damage_blacksmoke", 0.4);
	common_scripts\_destructible::destructible_state(undefined, undefined, 150, undefined, 32, "no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_fx", "explosions/transformer_spark_runner", 0.5);
	common_scripts\_destructible::destructible_loopsound("transformer_spark_loop");
	common_scripts\_destructible::destructible_healthdrain(24, 0.2);
	common_scripts\_destructible::destructible_state(undefined, undefined, 250, undefined, 32, "no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_fx", "explosions/transformer_spark_runner", 0.5);
	common_scripts\_destructible::destructible_loopfx("tag_fx", "fire/transformer_small_blacksmoke_fire", 0.4);
	common_scripts\_destructible::destructible_sound("transformer01_flareup_med");
	common_scripts\_destructible::destructible_loopsound("transformer_spark_loop");
	common_scripts\_destructible::destructible_healthdrain(24, 0.2, 150, "allies");
	common_scripts\_destructible::destructible_state(undefined, undefined, 400, undefined, 5, "no_melee");
	common_scripts\_destructible::destructible_fx("tag_fx", "explosions/transformer_explosion", 0);
	common_scripts\_destructible::destructible_fx("tag_fx", "fire/firelp_small_pm");
	common_scripts\_destructible::destructible_sound("transformer01_explode");
	common_scripts\_destructible::destructible_explode(7000, 8000, 150, 256, 16, 100, undefined, 0);
	common_scripts\_destructible::destructible_state(undefined, "utility_transformer_small01_dest", undefined, undefined, "no_melee");
}

toy_generator(destructibletype)
{
	common_scripts\_destructible::destructible_create(destructibletype, "tag_bounce", 75, undefined, 32, "no_melee");
	common_scripts\_destructible::destructible_splash_damage_scaler(15);
	common_scripts\_destructible::destructible_loopfx("tag_fx2", "smoke/generator_damage_whitesmoke", 0.4);
	common_scripts\_destructible::destructible_state(undefined, undefined, 75, undefined, 32, "no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_fx2", "smoke/generator_damage_blacksmoke", 0.4);
	common_scripts\_destructible::destructible_state(undefined, undefined, 250, undefined, 32, "no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_fx2", "smoke/generator_damage_blacksmoke", 0.4);
	common_scripts\_destructible::destructible_loopfx("tag_fx4", "explosions/generator_spark_runner", 0.9);
	common_scripts\_destructible::destructible_loopfx("tag_fx3", "explosions/generator_spark_runner", 0.6123);
	common_scripts\_destructible::destructible_loopsound("generator_spark_loop");
	common_scripts\_destructible::destructible_healthdrain(24, 0.2, 64, "allies");
	common_scripts\_destructible::destructible_state(undefined, undefined, 400, undefined, 5, "no_melee");
	common_scripts\_destructible::destructible_fx("tag_fx", "explosions/generator_explosion", 0);
	common_scripts\_destructible::destructible_fx("tag_fx", "fire/generator_des_fire");
	common_scripts\_destructible::destructible_sound("generator01_explode");
	common_scripts\_destructible::destructible_explode(7000, 8000, 128, 128, 16, 50, undefined, 0);
	common_scripts\_destructible::destructible_anim(get_precached_anim("generator_explode"), 1, "setanimknob", undefined, undefined, "generator_explode");
	common_scripts\_destructible::destructible_state(undefined, "machinery_generator_des", undefined, undefined, "no_melee");
}

toy_generator_on(destructibletype)
{
	common_scripts\_destructible::destructible_create(destructibletype, "tag_bounce", 0, undefined, 32, "no_melee");
	common_scripts\_destructible::destructible_splash_damage_scaler(15);
	common_scripts\_destructible::destructible_loopfx("tag_fx2", "smoke/generator_exhaust", 0.4);
	common_scripts\_destructible::destructible_anim(get_precached_anim("generator_vibration"), 1, "setanimknob", undefined, undefined, "generator_vibration");
	common_scripts\_destructible::destructible_loopsound("generator_running");
	common_scripts\_destructible::destructible_state("tag_origin", "machinery_generator", 150);
	common_scripts\_destructible::destructible_loopfx("tag_fx2", "smoke/generator_damage_whitesmoke", 0.4);
	common_scripts\_destructible::destructible_loopsound("generator_running");
	common_scripts\_destructible::destructible_state(undefined, undefined, 75, undefined, 32, "no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_fx2", "smoke/generator_damage_blacksmoke", 0.4);
	common_scripts\_destructible::destructible_loopsound("generator_damage_loop");
	common_scripts\_destructible::destructible_state(undefined, undefined, 250, undefined, 32, "no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_fx2", "smoke/generator_damage_blacksmoke", 0.4);
	common_scripts\_destructible::destructible_loopfx("tag_fx4", "explosions/generator_spark_runner", 0.9);
	common_scripts\_destructible::destructible_loopfx("tag_fx3", "explosions/generator_spark_runner", 0.6123);
	common_scripts\_destructible::destructible_loopsound("generator_spark_loop");
	common_scripts\_destructible::destructible_loopsound("generator_damage_loop");
	common_scripts\_destructible::destructible_healthdrain(24, 0.2, 64, "allies");
	common_scripts\_destructible::destructible_state(undefined, undefined, 400, undefined, 5, "no_melee");
	common_scripts\_destructible::destructible_fx("tag_fx", "explosions/generator_explosion", 0);
	common_scripts\_destructible::destructible_fx("tag_fx", "fire/generator_des_fire");
	common_scripts\_destructible::destructible_sound("generator01_explode");
	common_scripts\_destructible::destructible_explode(7000, 8000, 128, 128, 16, 50, undefined, 0);
	common_scripts\_destructible::destructible_anim(get_precached_anim("generator_explode"), 1, "setanimknob", undefined, 0, "generator_explode");
	common_scripts\_destructible::destructible_anim(get_precached_anim("generator_explode_02"), 1, "setanimknob", undefined, 0, "generator_explode_02");
	common_scripts\_destructible::destructible_anim(get_precached_anim("generator_explode_03"), 1, "setanimknob", undefined, 0, "generator_explode_03");
	common_scripts\_destructible::destructible_state(undefined, "machinery_generator_des", undefined, undefined, "no_melee");
}

toy_oxygen_tank(param_98F)
{
	common_scripts\_destructible::destructible_create("toy_oxygen_tank_" + param_98F, "tag_origin", 150, undefined, 32, "no_melee");
	common_scripts\_destructible::destructible_healthdrain(12, 0.2, 64, "allies");
	common_scripts\_destructible::destructible_loopsound("oxygen_tank_leak_loop");
	common_scripts\_destructible::destructible_fx("tag_cap", "props/oxygen_tank" + param_98F + "_cap");
	common_scripts\_destructible::destructible_loopfx("tag_cap", "distortion/oxygen_tank_leak", 0.4);
	common_scripts\_destructible::destructible_state(undefined, "machinery_oxygen_tank" + param_98F + "_dam", 300, undefined, 32, "no_melee");
	common_scripts\_destructible::destructible_fx("tag_fx", "explosions/oxygen_tank" + param_98F + "_explosion", 0);
	common_scripts\_destructible::destructible_sound("oxygen_tank_explode");
	common_scripts\_destructible::destructible_explode(7000, 8000, 150, 256, 16, 150, undefined, 32);
	common_scripts\_destructible::destructible_state(undefined, "machinery_oxygen_tank" + param_98F + "_des", undefined, undefined, "no_melee");
}

toy_electricbox2(destructibletype)
{
	common_scripts\_destructible::destructible_create(destructibletype, "tag_origin", 150, undefined, 32, "no_melee");
	common_scripts\_destructible::destructible_splash_damage_scaler(15);
	common_scripts\_destructible::destructible_fx("tag_fx", "props/electricbox4_explode", undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_sound("exp_fusebox_sparks");
	common_scripts\_destructible::destructible_explode(1000, 2000, 32, 32, 32, 48, undefined, 0);
	common_scripts\_destructible::destructible_state(undefined, "me_electricbox2_dest", undefined, undefined, "no_melee");
	common_scripts\_destructible::destructible_part("tag_fx", "me_electricbox2_door", undefined, undefined, undefined, undefined, 1, 1);
	common_scripts\_destructible::destructible_part("tag_door_upper", "me_electricbox2_door_upper", undefined, undefined, undefined, undefined, 1, 1);
}

toy_electricbox4(destructibletype)
{
	common_scripts\_destructible::destructible_create(destructibletype, "tag_origin", 150, undefined, 32, "no_melee");
	common_scripts\_destructible::destructible_splash_damage_scaler(15);
	common_scripts\_destructible::destructible_fx("tag_fx", "props/electricbox4_explode", undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_sound("exp_fusebox_sparks");
	common_scripts\_destructible::destructible_explode(20, 2000, 32, 32, 32, 48, undefined, 0);
	common_scripts\_destructible::destructible_state(undefined, "me_electricbox4_dest", undefined, undefined, "no_melee");
	common_scripts\_destructible::destructible_part("tag_fx", "me_electricbox4_door", undefined, undefined, undefined, undefined, 1, 1);
}

toy_airconditioner(destructibletype)
{
	common_scripts\_destructible::destructible_create(destructibletype, "tag_origin", 0, undefined, 32);
	common_scripts\_destructible::destructible_anim(get_precached_anim("ex_airconditioner_fan"), 1, "setanimknob", undefined, undefined, "ex_airconditioner_fan");
	common_scripts\_destructible::destructible_loopsound("airconditioner_running_loop");
	common_scripts\_destructible::destructible_state("tag_origin", "com_ex_airconditioner", 300);
	common_scripts\_destructible::destructible_fx("tag_fx", "explosions/airconditioner_ex_explode", undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_sound("airconditioner_burst");
	common_scripts\_destructible::destructible_explode(1000, 2000, 32, 32, 32, 48, undefined, 0);
	common_scripts\_destructible::destructible_state(undefined, "com_ex_airconditioner_dam", undefined, undefined, "no_melee");
	common_scripts\_destructible::destructible_part("tag_fx", "com_ex_airconditioner_fan", undefined, undefined, undefined, undefined, 1, 1);
}

toy_ceiling_fan(destructibletype)
{
	common_scripts\_destructible::destructible_create(destructibletype, "tag_origin", 0, undefined, 32);
	common_scripts\_destructible::destructible_anim(get_precached_anim("me_fanceil1_spin"), 1, "setanimknob", undefined, undefined, "me_fanceil1_spin");
	common_scripts\_destructible::destructible_state("tag_origin", "me_fanceil1", 150);
	common_scripts\_destructible::destructible_anim(get_precached_anim("me_fanceil1_spin_stop"), 1, "setanimknob", undefined, undefined, "me_fanceil1_spin_stop");
	common_scripts\_destructible::destructible_fx("tag_fx", "explosions/ceiling_fan_explosion");
	common_scripts\_destructible::destructible_sound("ceiling_fan_sparks");
	common_scripts\_destructible::destructible_explode(1000, 2000, 32, 32, 5, 32, undefined, 0);
	common_scripts\_destructible::destructible_state(undefined, "me_fanceil1_des", undefined, undefined, "no_melee");
	common_scripts\_destructible::destructible_part("tag_fx", undefined, 150, undefined, undefined, undefined, 1);
}

toy_wall_fan(destructibletype)
{
	common_scripts\_destructible::destructible_create(destructibletype, "tag_swivel", 0, undefined, 32);
	common_scripts\_destructible::destructible_anim(get_precached_anim("wall_fan_rotate"), 1, "setanimknob", undefined, undefined, "wall_fan_rotate");
	common_scripts\_destructible::destructible_loopsound("wall_fan_fanning");
	common_scripts\_destructible::destructible_state("tag_wobble", "cs_wallfan1", 150);
	common_scripts\_destructible::destructible_anim(get_precached_anim("wall_fan_stop"), 1, "setanimknob", undefined, undefined, "wall_fan_wobble");
	common_scripts\_destructible::destructible_fx("tag_fx", "explosions/wallfan_explosion_dmg");
	common_scripts\_destructible::destructible_sound("wall_fan_sparks");
	common_scripts\_destructible::destructible_state("tag_wobble", "cs_wallfan1", 150, undefined, "no_melee");
	common_scripts\_destructible::destructible_fx("tag_fx", "explosions/wallfan_explosion_des");
	common_scripts\_destructible::destructible_sound("wall_fan_break");
	common_scripts\_destructible::destructible_state(undefined, "cs_wallfan1_dmg", undefined, undefined, "no_melee");
}

toy_propane_tank02(destructibletype)
{
	common_scripts\_destructible::destructible_create(destructibletype, "tag_origin", 50, undefined, 32, "no_melee");
	common_scripts\_destructible::destructible_splash_damage_scaler(5);
	common_scripts\_destructible::destructible_state(undefined, undefined, 350, undefined, 32, "no_melee");
	common_scripts\_destructible::destructible_loopsound("propanetank02_gas_leak_loop");
	common_scripts\_destructible::destructible_loopfx("tag_cap", "distortion/propane_cap_distortion", 0.1);
	common_scripts\_destructible::destructible_state(undefined, undefined, 350, undefined, 32, "no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_cap", "fire/propane_capfire_leak", 0.1);
	common_scripts\_destructible::destructible_sound("propanetank02_flareup_med");
	common_scripts\_destructible::destructible_loopsound("propanetank02_fire_med");
	common_scripts\_destructible::destructible_healthdrain(12, 0.2, 300, "allies");
	common_scripts\_destructible::destructible_state(undefined, undefined, 150, undefined, 32, "no_melee");
	common_scripts\_destructible::destructible_physics("tag_cap", (50,0,0));
	common_scripts\_destructible::destructible_loopfx("tag_cap", "fire/propane_capfire", 0.6);
	common_scripts\_destructible::destructible_fx("tag_valve", "fire/propane_valvefire_flareup");
	common_scripts\_destructible::destructible_physics("tag_valve", (50,0,0));
	common_scripts\_destructible::destructible_fx("tag_cap", "fire/propane_capfire_flareup");
	common_scripts\_destructible::destructible_loopfx("tag_valve", "fire/propane_valvefire", 0.1);
	common_scripts\_destructible::destructible_sound("propanetank02_flareup2_med");
	common_scripts\_destructible::destructible_loopsound("propanetank02_fire_med");
	common_scripts\_destructible::destructible_state(undefined, undefined, 150, undefined, 5, "no_melee");
	common_scripts\_destructible::destructible_fx("tag_fx", "fire/propane_small_fire");
	common_scripts\_destructible::destructible_fx("tag_fx", "explosions/propane_large_exp_fireball");
	common_scripts\_destructible::destructible_fx("tag_fx", "explosions/propane_large_exp", 0);
	common_scripts\_destructible::destructible_sound("propanetank02_explode");
	common_scripts\_destructible::destructible_loopsound("propanetank02_fire_blown_med");
	common_scripts\_destructible::destructible_explode(7000, 8000, 600, 600, 32, 300);
	common_scripts\_destructible::destructible_state(undefined, "com_propane_tank02_DES", undefined, undefined, "no_melee");
	common_scripts\_destructible::destructible_part("tag_valve", "com_propane_tank02_valve");
	common_scripts\_destructible::destructible_part("tag_cap", "com_propane_tank02_cap");
}

toy_propane_tank02_small(destructibletype)
{
	common_scripts\_destructible::destructible_create(destructibletype, "tag_origin", 50, undefined, 32, "no_melee");
	common_scripts\_destructible::destructible_splash_damage_scaler(10);
	common_scripts\_destructible::destructible_state(undefined, undefined, 350, undefined, 32, "no_melee");
	common_scripts\_destructible::destructible_loopsound("propanetank02_gas_leak_loop");
	common_scripts\_destructible::destructible_loopfx("tag_cap", "distortion/propane_cap_distortion", 0.1);
	common_scripts\_destructible::destructible_state(undefined, undefined, 350, undefined, 32, "no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_cap", "fire/propane_capfire_leak", 0.1);
	common_scripts\_destructible::destructible_sound("propanetank02_flareup_med");
	common_scripts\_destructible::destructible_loopsound("propanetank02_fire_med");
	common_scripts\_destructible::destructible_healthdrain(12, 0.2, 210, "allies");
	common_scripts\_destructible::destructible_state(undefined, undefined, 200, undefined, 32, "no_melee");
	common_scripts\_destructible::destructible_physics("tag_cap", (50,0,0));
	common_scripts\_destructible::destructible_loopfx("tag_cap", "fire/propane_capfire", 0.6);
	common_scripts\_destructible::destructible_fx("tag_valve", "fire/propane_valvefire_flareup");
	common_scripts\_destructible::destructible_physics("tag_valve", (50,0,0));
	common_scripts\_destructible::destructible_fx("tag_cap", "fire/propane_capfire_flareup");
	common_scripts\_destructible::destructible_loopfx("tag_valve", "fire/propane_valvefire", 0.1);
	common_scripts\_destructible::destructible_sound("propanetank02_flareup_med");
	common_scripts\_destructible::destructible_loopsound("propanetank02_fire_med");
	common_scripts\_destructible::destructible_state(undefined, undefined, 200, undefined, 5, "no_melee");
	common_scripts\_destructible::destructible_fx("tag_fx", "fire/propane_small_fire");
	common_scripts\_destructible::destructible_fx("tag_fx", "explosions/propane_large_exp", 0);
	common_scripts\_destructible::destructible_sound("propanetank02_explode");
	common_scripts\_destructible::destructible_explode(7000, 8000, 400, 400, 32, 100);
	common_scripts\_destructible::destructible_state(undefined, "com_propane_tank02_small_DES", undefined, undefined, "no_melee");
	common_scripts\_destructible::destructible_part("tag_valve", "com_propane_tank02_small_valve");
	common_scripts\_destructible::destructible_part("tag_cap", "com_propane_tank02_small_cap");
}

toy_copier(destructibletype)
{
	common_scripts\_destructible::destructible_create(destructibletype, "tag_body", 250, undefined, 32, "no_melee");
	common_scripts\_destructible::destructible_splash_damage_scaler(15);
	common_scripts\_destructible::destructible_loopfx("tag_left_feeder", "smoke/car_damage_whitesmoke", 0.4);
	common_scripts\_destructible::destructible_state(undefined, undefined, 250, undefined, 32, "no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_left_feeder", "smoke/car_damage_blacksmoke", 0.4);
	common_scripts\_destructible::destructible_state(undefined, undefined, 500, undefined, 32, "no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_fx", "props/photocopier_sparks", 3);
	common_scripts\_destructible::destructible_loopsound("copier_spark_loop");
	common_scripts\_destructible::destructible_healthdrain(12, 0.2);
	common_scripts\_destructible::destructible_state(undefined, undefined, 800, undefined, 5, "no_melee");
	common_scripts\_destructible::destructible_fx("tag_fx", "props/photocopier_exp", 0);
	common_scripts\_destructible::destructible_fx("tag_fx", "props/photocopier_fire");
	common_scripts\_destructible::destructible_sound("copier_exp");
	common_scripts\_destructible::destructible_loopsound("copier_fire_loop");
	common_scripts\_destructible::destructible_explode(7000, 8000, 96, 96, 32, 48);
	common_scripts\_destructible::destructible_state(undefined, "prop_photocopier_destroyed", undefined, undefined, "no_melee");
	common_scripts\_destructible::destructible_part("tag_left_feeder", "prop_photocopier_destroyed_left_feeder", 4, undefined, undefined, undefined, 1, 1);
	common_scripts\_destructible::destructible_part("tag_right_shelf", "prop_photocopier_destroyed_right_shelf", 4, undefined, undefined, undefined, 1, 1);
	common_scripts\_destructible::destructible_part("tag_top", "prop_photocopier_destroyed_top", 4, undefined, undefined, undefined, 1, 1);
}

toy_firehydrant(destructibletype)
{
	common_scripts\_destructible::destructible_create(destructibletype, "tag_origin", 250, undefined, 32, "no_melee");
	common_scripts\_destructible::destructible_splash_damage_scaler(11);
	common_scripts\_destructible::destructible_state(undefined, undefined, 500, undefined, 32, "no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_cap", "props/firehydrant_leak", 0.1);
	common_scripts\_destructible::destructible_loopsound("firehydrant_spray_loop");
	common_scripts\_destructible::destructible_healthdrain(12, 0.2);
	common_scripts\_destructible::destructible_state(undefined, undefined, 800, undefined, 5, "no_melee");
	common_scripts\_destructible::destructible_fx("tag_fx", "props/firehydrant_exp", 0);
	common_scripts\_destructible::destructible_fx("tag_fx", "props/firehydrant_spray_10sec", 0);
	common_scripts\_destructible::destructible_sound("firehydrant_burst");
	common_scripts\_destructible::destructible_explode(17000, 18000, 96, 96, 32, 48);
	common_scripts\_destructible::destructible_state(undefined, "com_firehydrant_dest", undefined, undefined, "no_melee");
	common_scripts\_destructible::destructible_part("tag_fx", "com_firehydrant_dam", undefined, undefined, undefined, undefined, 1, 1);
	common_scripts\_destructible::destructible_part("tag_cap", "com_firehydrant_cap", undefined, undefined, undefined, undefined, 1, 1);
}

toy_parkingmeter(destructibletype)
{
	common_scripts\_destructible::destructible_create(destructibletype, "tag_meter", 120);
	common_scripts\_destructible::destructible_fx("tag_fx", "props/parking_meter_coins", 1, common_scripts\_destructible::damage_not("splash"));
	common_scripts\_destructible::destructible_fx("tag_fx", "props/parking_meter_coins_exploded", 1, "splash");
	common_scripts\_destructible::destructible_sound("exp_parking_meter_sweet");
	common_scripts\_destructible::destructible_explode(2800, 3000, 64, 64, 0, 0, 1);
	common_scripts\_destructible::destructible_state(undefined, "com_parkingmeter_damaged", 20, undefined, undefined, "splash");
	common_scripts\_destructible::destructible_state(undefined, "com_parkingmeter_destroyed", undefined, undefined, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_part("tag_cap", "com_parkingmeter_cap", undefined, undefined, undefined, undefined, 1, 1);
}

toy_mailbox(destructibletype)
{
	common_scripts\_destructible::destructible_create(destructibletype, "tag_origin", 200);
	common_scripts\_destructible::destructible_fx("tag_fx", "props/mail_box_explode", 1);
	common_scripts\_destructible::destructible_sound("exp_mailbox_sweet");
	common_scripts\_destructible::destructible_explode(100, 2000, 64, 64, 0, 0);
	common_scripts\_destructible::destructible_state("tag_origin", "com_mailbox_dam");
	common_scripts\_destructible::destructible_part("tag_door", "com_mailbox_door", undefined, undefined, undefined, undefined, 1, 1);
	common_scripts\_destructible::destructible_part("tag_flag", "com_mailbox_flag", undefined, undefined, undefined, undefined, 1, 1);
}

toy_mailbox2(color)
{
	common_scripts\_destructible::destructible_create("toy_mailbox2_" + color, "tag_origin", 120);
	common_scripts\_destructible::destructible_fx("tag_fx", "props/mail_box_explode", 1, common_scripts\_destructible::damage_not("splash"));
	common_scripts\_destructible::destructible_fx("tag_fx", "props/mail_box_explode", 1, "splash");
	common_scripts\_destructible::destructible_sound("exp_mailbox_sweet");
	common_scripts\_destructible::destructible_explode(2800, 3000, 64, 64, 0, 0, 1);
	common_scripts\_destructible::destructible_state(undefined, "mailbox_" + color + "_dam", 20, undefined, undefined, "splash");
	common_scripts\_destructible::destructible_state(undefined, "mailbox_black_dest", undefined, undefined, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_part("tag_door", "mailbox_" + color + "_door", undefined, undefined, undefined, undefined, 1, 1);
	common_scripts\_destructible::destructible_part("tag_flag", "mailbox_black_flag", undefined, undefined, undefined, undefined, 1, 1);
}

toy_newspaper_stand_red(destructibletype)
{
	common_scripts\_destructible::destructible_create(destructibletype, "tag_origin", 120);
	common_scripts\_destructible::destructible_fx("tag_door", "props/news_stand_paper_spill", 1, common_scripts\_destructible::damage_not("splash"));
	common_scripts\_destructible::destructible_sound("exp_newspaper_box");
	common_scripts\_destructible::destructible_explode(2500, 2501, 64, 64, 0, 0, 1);
	common_scripts\_destructible::destructible_state(undefined, "com_newspaperbox_red_dam", 20, undefined, undefined, "splash");
	common_scripts\_destructible::destructible_fx("tag_fx", "props/news_stand_explosion", 1, "splash");
	common_scripts\_destructible::destructible_state(undefined, "com_newspaperbox_red_des", undefined, undefined, undefined, undefined, undefined, 0);
	common_scripts\_destructible::destructible_part("tag_door", "com_newspaperbox_red_door", undefined, undefined, undefined, undefined, 1, 1);
}

toy_newspaper_stand_blue(destructibletype)
{
	common_scripts\_destructible::destructible_create(destructibletype, "tag_origin", 120);
	common_scripts\_destructible::destructible_fx("tag_door", "props/news_stand_paper_spill_shatter", 1, common_scripts\_destructible::damage_not("splash"));
	common_scripts\_destructible::destructible_sound("exp_newspaper_box");
	common_scripts\_destructible::destructible_explode(800, 2001, 64, 64, 0, 0, 1);
	common_scripts\_destructible::destructible_state(undefined, "com_newspaperbox_blue_dam", 20, undefined, undefined, "splash");
	common_scripts\_destructible::destructible_fx("tag_fx", "props/news_stand_explosion", 1, "splash");
	common_scripts\_destructible::destructible_state(undefined, "com_newspaperbox_blue_des", undefined, undefined, undefined, undefined, undefined, 0);
	common_scripts\_destructible::destructible_part("tag_door", "com_newspaperbox_blue_door", undefined, undefined, undefined, undefined, 1, 1);
}

toy_filecabinet(destructibletype)
{
	common_scripts\_destructible::destructible_create(destructibletype, "tag_origin", 120);
	common_scripts\_destructible::destructible_fx("tag_drawer_lower", "props/filecabinet_dam", 1, common_scripts\_destructible::damage_not("splash"));
	common_scripts\_destructible::destructible_sound("exp_filecabinet");
	common_scripts\_destructible::destructible_state(undefined, "com_filecabinetblackclosed_dam", 20, undefined, undefined, "splash");
	common_scripts\_destructible::destructible_fx("tag_drawer_upper", "props/filecabinet_des", 1, "splash");
	common_scripts\_destructible::destructible_sound("exp_filecabinet");
	common_scripts\_destructible::destructible_physics("tag_drawer_upper", (50,-10,5));
	common_scripts\_destructible::destructible_state(undefined, "com_filecabinetblackclosed_des", undefined, undefined, undefined, undefined, undefined, 0);
	common_scripts\_destructible::destructible_part("tag_drawer_upper", "com_filecabinetblackclosed_drawer", undefined, undefined, undefined, undefined, 1, 1);
}

toy_trashbin_01(destructibletype)
{
	common_scripts\_destructible::destructible_create(destructibletype, "tag_origin", 120, undefined, 32, "no_melee");
	common_scripts\_destructible::destructible_fx("tag_fx", "props/garbage_spew_des", 1, "splash");
	common_scripts\_destructible::destructible_fx("tag_fx", "props/garbage_spew", 1, common_scripts\_destructible::damage_not("splash"));
	common_scripts\_destructible::destructible_sound("exp_trashcan_sweet");
	common_scripts\_destructible::destructible_explode(1300, 1351, 1, 1, 10, 20);
	common_scripts\_destructible::destructible_state(undefined, "com_trashbin01_dmg", undefined, undefined, undefined, undefined, undefined, 0);
	common_scripts\_destructible::destructible_part("tag_fx", "com_trashbin01_lid", undefined, undefined, undefined, undefined, 1, 1);
}

toy_trashbin_02(destructibletype)
{
	common_scripts\_destructible::destructible_create(destructibletype, "tag_origin", 120, undefined, 32, "no_melee");
	common_scripts\_destructible::destructible_fx("tag_fx", "props/garbage_spew_des", 1, "splash");
	common_scripts\_destructible::destructible_fx("tag_fx", "props/garbage_spew", 1, common_scripts\_destructible::damage_not("splash"));
	common_scripts\_destructible::destructible_sound("exp_trashcan_sweet");
	common_scripts\_destructible::destructible_explode(600, 800, 1, 1, 10, 20);
	common_scripts\_destructible::destructible_state(undefined, "com_trashbin02_dmg", undefined, undefined, undefined, undefined, undefined, 0);
	common_scripts\_destructible::destructible_part("tag_fx", "com_trashbin02_lid", undefined, undefined, undefined, undefined, 1, 1);
}

toy_recyclebin_01(destructibletype)
{
	common_scripts\_destructible::destructible_create(destructibletype, "tag_origin", 120, undefined, 32, "no_melee");
	common_scripts\_destructible::destructible_fx("tag_fx", "props/garbage_spew_des", 1, "splash");
	common_scripts\_destructible::destructible_fx("tag_fx", "props/garbage_spew", 1, common_scripts\_destructible::damage_not("splash"));
	common_scripts\_destructible::destructible_sound("exp_trashcan_sweet");
	common_scripts\_destructible::destructible_explode(600, 651, 1, 1, 10, 20);
	common_scripts\_destructible::destructible_state(undefined, "com_recyclebin01_dmg", undefined, undefined, undefined, undefined, undefined, 0);
	common_scripts\_destructible::destructible_part("tag_fx", "com_recyclebin01_lid", undefined, undefined, undefined, undefined, 1, 1);
}

toy_trashcan_metal_closed(destructibletype)
{
	common_scripts\_destructible::destructible_create(destructibletype, "tag_origin", 120, undefined, 32, "no_melee");
	common_scripts\_destructible::destructible_fx("tag_fx", "props/garbage_spew_des", 1, "splash");
	common_scripts\_destructible::destructible_fx("tag_fx", "props/garbage_spew", 1, common_scripts\_destructible::damage_not("splash"));
	common_scripts\_destructible::destructible_sound("exp_trashcan_sweet");
	common_scripts\_destructible::destructible_explode(600, 651, 1, 1, 10, 20);
	common_scripts\_destructible::destructible_state(undefined, "com_trashcan_metal_with_trash", undefined, undefined, undefined, undefined, undefined, 0);
	common_scripts\_destructible::destructible_part("tag_fx", "com_trashcan_metalLID", undefined, undefined, undefined, undefined, 1, 1);
}

toy_water_collector(destructibletype)
{
	common_scripts\_destructible::destructible_create(destructibletype, "tag_origin", 220, undefined, 32, "no_melee");
	common_scripts\_destructible::destructible_fx("tag_fx", "explosions/water_collector_explosion");
	common_scripts\_destructible::destructible_sound("water_collector_splash");
	common_scripts\_destructible::destructible_explode(500, 800, 32, 32, 1, 10, undefined, 32);
	common_scripts\_destructible::destructible_state(undefined, "utility_water_collector_base_dest", undefined, undefined, "no_melee", undefined, undefined, 0);
	common_scripts\_destructible::destructible_part("tag_lid", undefined, 220, undefined, undefined, "no_melee", 1);
	common_scripts\_destructible::destructible_state(undefined);
}

toy_foliage_tree_oak_1(destructibletype)
{
	common_scripts\_destructible::destructible_create(destructibletype, "tag_origin", 120, undefined, 32, "splash");
	common_scripts\_destructible::destructible_fx("tag_fx", "explosions/tree_trunk_explosion_oak_1", 1, "splash");
	common_scripts\_destructible::destructible_sound("large_oak_tree_impact");
	common_scripts\_destructible::destructible_sound("large_oak_tree_fall");
	common_scripts\_destructible::destructible_explode(600, 651, 1, 1, 10, 20);
	common_scripts\_destructible::destructible_state(undefined, "foliage_tree_oak_1_destroyed_trunk", undefined, undefined, undefined, undefined, undefined, 0);
}

toy_usa_gas_station_trash_bin_01(destructibletype)
{
	common_scripts\_destructible::destructible_create(destructibletype, "tag_origin", 120, undefined, 32, "no_melee");
	common_scripts\_destructible::destructible_fx("tag_fx", "props/garbage_spew_des", 1, "splash");
	common_scripts\_destructible::destructible_fx("tag_fx", "props/garbage_spew", 1, common_scripts\_destructible::damage_not("splash"));
	common_scripts\_destructible::destructible_explode(600, 651, 1, 1, 10, 20);
	common_scripts\_destructible::destructible_state(undefined, "usa_gas_station_trash_bin_01_base", undefined, undefined, undefined, undefined, undefined, 0);
	common_scripts\_destructible::destructible_part("tag_fx", "usa_gas_station_trash_bin_01_lid", undefined, undefined, undefined, undefined, 1, 1);
}

toy_usa_gas_station_trash_bin_02(destructibletype)
{
	common_scripts\_destructible::destructible_create(destructibletype, "tag_origin", 120, undefined, 32, "no_melee");
	common_scripts\_destructible::destructible_fx("tag_fx_high", "props/garbage_spew_des", 1, "splash");
	common_scripts\_destructible::destructible_fx("tag_fx_high", "props/garbage_spew", 1, common_scripts\_destructible::damage_not("splash"));
	common_scripts\_destructible::destructible_explode(600, 651, 1, 1, 10, 20);
	common_scripts\_destructible::destructible_state(undefined, "usa_gas_station_trash_bin_02_base", undefined, undefined, undefined, undefined, undefined, 0);
	common_scripts\_destructible::destructible_part("tag_fx_high", "usa_gas_station_trash_bin_02_lid", undefined, undefined, undefined, undefined, 1, 1);
}

toy_light_ceiling_round(destructibletype)
{
	common_scripts\_destructible::destructible_create(destructibletype, "tag_origin", 150, undefined, 32, "no_melee");
	common_scripts\_destructible::destructible_splash_damage_scaler(15);
	common_scripts\_destructible::destructible_lights_out(16);
	common_scripts\_destructible::destructible_fx("tag_fx", "misc/light_blowout_runner");
	common_scripts\_destructible::destructible_state(undefined, "com_light_ceiling_round_off", undefined, undefined, "no_melee");
}

toy_light_ceiling_fluorescent(destructibletype)
{
	common_scripts\_destructible::destructible_create(destructibletype, "tag_origin", 150, undefined, 32, "no_melee");
	common_scripts\_destructible::destructible_splash_damage_scaler(15);
	common_scripts\_destructible::destructible_fx("tag_fx", "misc/light_fluorescent_blowout_runner");
	common_scripts\_destructible::destructible_fx("tag_swing_fx", "misc/light_blowout_swinging_runner");
	common_scripts\_destructible::destructible_lights_out(16);
	common_scripts\_destructible::destructible_explode(20, 2000, 64, 64, 40, 80);
	common_scripts\_destructible::destructible_anim(get_precached_anim("light_fluorescent_swing"), 1, "setanimknob", undefined, 0, "light_fluorescent_swing");
	common_scripts\_destructible::destructible_sound("fluorescent_light_fall", undefined, 0);
	common_scripts\_destructible::destructible_sound("fluorescent_light_bulb", undefined, 0);
	common_scripts\_destructible::destructible_anim(get_precached_anim("light_fluorescent_swing_02"), 1, "setanimknob", undefined, 1, "light_fluorescent_swing_02");
	common_scripts\_destructible::destructible_sound("fluorescent_light_fall", undefined, 1);
	common_scripts\_destructible::destructible_sound("fluorescent_light_bulb", undefined, 1);
	common_scripts\_destructible::destructible_anim(get_precached_anim("light_fluorescent_null"), 1, "setanimknob", undefined, 2, "light_fluorescent_null");
	common_scripts\_destructible::destructible_state(undefined, "me_lightfluohang_double_destroyed", undefined, undefined, "no_melee");
}

toy_light_ceiling_fluorescent_spotlight(destructibletype)
{
	common_scripts\_destructible::destructible_create(destructibletype, "tag_origin", 150, undefined, 32, "no_melee");
	common_scripts\_destructible::destructible_splash_damage_scaler(15);
	common_scripts\_destructible::destructible_sound("fluorescent_light_bulb");
	common_scripts\_destructible::destructible_fx("tag_fx", "misc/light_fluorescent_blowout_runner");
	common_scripts\_destructible::destructible_fx("tag_swing_fx", "misc/light_blowout_swinging_runner");
	common_scripts\_destructible::destructible_lights_out(16);
	common_scripts\_destructible::destructible_explode(20, 2000, 64, 64, 40, 80);
	common_scripts\_destructible::destructible_anim(get_precached_anim("light_fluorescent_swing"), 1, "setanimknob", undefined, 0, "light_fluorescent_swing");
	common_scripts\_destructible::destructible_sound("fluorescent_light_fall", undefined, 0);
	common_scripts\_destructible::destructible_sound("fluorescent_light_bulb", undefined, 0);
	common_scripts\_destructible::destructible_spotlight("tag_swing_r_far");
	common_scripts\_destructible::destructible_sound("fluorescent_light_fall");
	common_scripts\_destructible::destructible_state(undefined, "me_lightfluohang_double_destroyed", undefined, undefined, "no_melee");
}

toy_light_ceiling_fluorescent_single(destructibletype)
{
	common_scripts\_destructible::destructible_create(destructibletype, "tag_origin", 150, undefined, 32, "no_melee");
	common_scripts\_destructible::destructible_splash_damage_scaler(15);
	common_scripts\_destructible::destructible_fx("tag_fx", "misc/light_fluorescent_single_blowout_runner");
	common_scripts\_destructible::destructible_fx("tag_swing_center_fx", "misc/light_blowout_swinging_runner");
	common_scripts\_destructible::destructible_fx("tag_swing_center_fx_far", "misc/light_blowout_swinging_runner");
	common_scripts\_destructible::destructible_explode(20, 2000, 64, 64, 40, 80);
	common_scripts\_destructible::destructible_anim(get_precached_anim("light_fluorescent_single_swing"), 1, "setanimknob", undefined, 0, "light_fluorescent_single_swing");
	common_scripts\_destructible::destructible_sound("fluorescent_light_fall", undefined, 0);
	common_scripts\_destructible::destructible_sound("fluorescent_light_bulb", undefined, 0);
	common_scripts\_destructible::destructible_anim(get_precached_anim("light_fluorescent_single_swing_02"), 1, "setanimknob", undefined, 1, "light_fluorescent_single_swing_02");
	common_scripts\_destructible::destructible_sound("fluorescent_light_hinge", undefined, 1);
	common_scripts\_destructible::destructible_sound("fluorescent_light_bulb", undefined, 1);
	common_scripts\_destructible::destructible_anim(get_precached_anim("light_fluorescent_single_swing_03"), 1, "setanimknob", undefined, 2, "light_fluorescent_single_swing_03");
	common_scripts\_destructible::destructible_sound("fluorescent_light_fall", undefined, 2);
	common_scripts\_destructible::destructible_sound("fluorescent_light_bulb", undefined, 2);
	common_scripts\_destructible::destructible_anim(get_precached_anim("light_fluorescent_single_null"), 1, "setanimknob", undefined, 3, "light_fluorescent_single_null");
	common_scripts\_destructible::destructible_state(undefined, "me_lightfluohang_single_destroyed", undefined, undefined, "no_melee");
}

toy_light_ceiling_fluorescent_single_spotlight(destructibletype)
{
	common_scripts\_destructible::destructible_create(destructibletype, "tag_origin", 150, undefined, 32, "no_melee");
	common_scripts\_destructible::destructible_splash_damage_scaler(15);
	common_scripts\_destructible::destructible_lights_out(16);
	common_scripts\_destructible::destructible_sound("fluorescent_light_bulb");
	common_scripts\_destructible::destructible_fx("tag_fx", "misc/light_fluorescent_single_blowout_runner");
	common_scripts\_destructible::destructible_fx("tag_swing_center_fx", "misc/light_blowout_swinging_runner");
	common_scripts\_destructible::destructible_fx("tag_swing_center_fx_far", "misc/light_blowout_swinging_runner");
	common_scripts\_destructible::destructible_explode(20, 2000, 64, 64, 40, 80);
	common_scripts\_destructible::destructible_anim(get_precached_anim("light_fluorescent_single_swing_02"), 1, "setanimknob", undefined, undefined, "light_fluorescent_single_swing_02");
	common_scripts\_destructible::destructible_sound("fluorescent_light_fall");
	common_scripts\_destructible::destructible_spotlight("tag_swing_center_fx_far");
	common_scripts\_destructible::destructible_state(undefined, "me_lightfluohang_single_destroyed", undefined, undefined, "no_melee");
}

toy_bookstore_bookstand4_books(destructibletype)
{
	common_scripts\_destructible::destructible_create(destructibletype, "tag_origin", 200, undefined, 32, "no_melee");
	common_scripts\_destructible::destructible_splash_damage_scaler(7);
	common_scripts\_destructible::destructible_fx("tag_fx", "props/bookshelf4_dmg", 1, common_scripts\_destructible::damage_not("splash"));
	common_scripts\_destructible::destructible_state(undefined, "bookstore_bookstand4", 100, undefined, undefined, "splash");
	common_scripts\_destructible::destructible_fx("tag_fx", "props/bookshelf4_des", 1, "splash");
	common_scripts\_destructible::destructible_explode(2000, 3800, 32, 32, 1, 5, undefined, 0);
	common_scripts\_destructible::destructible_state(undefined, "bookstore_bookstand4_null", undefined, undefined, undefined, undefined, undefined, 0);
}

toy_locker_double(destructibletype)
{
	common_scripts\_destructible::destructible_create(destructibletype, "tag_origin", 150, undefined, 32, "no_melee");
	common_scripts\_destructible::destructible_anim(get_precached_anim("locker_broken_both_doors_1"), 1, "setanimknob", undefined, 0, "locker_broken_both_doors_1");
	common_scripts\_destructible::destructible_fx("tag_fx", "props/locker_double_des_02_right", undefined, undefined, 0);
	common_scripts\_destructible::destructible_sound("lockers_fast", undefined, 0);
	common_scripts\_destructible::destructible_anim(get_precached_anim("locker_broken_both_doors_2"), 1, "setanimknob", undefined, 1, "locker_broken_both_doors_2");
	common_scripts\_destructible::destructible_fx("tag_fx", "props/locker_double_des_01_left", undefined, undefined, 1);
	common_scripts\_destructible::destructible_sound("lockers_fast", undefined, 1);
	common_scripts\_destructible::destructible_anim(get_precached_anim("locker_broken_both_doors_4"), 1, "setanimknob", undefined, 2, "locker_broken_both_doors_4");
	common_scripts\_destructible::destructible_fx("tag_fx", "props/locker_double_des_03_both", undefined, undefined, 2);
	common_scripts\_destructible::destructible_sound("lockers_double", undefined, 2);
	common_scripts\_destructible::destructible_anim(get_precached_anim("locker_broken_door1_fast"), 1, "setanimknob", undefined, 3, "locker_broken_door1_fast");
	common_scripts\_destructible::destructible_fx("tag_fx", "props/locker_double_des_01_left", undefined, undefined, 3);
	common_scripts\_destructible::destructible_sound("lockers_fast", undefined, 3);
	common_scripts\_destructible::destructible_anim(get_precached_anim("locker_broken_door2_fast"), 1, "setanimknob", undefined, 4, "locker_broken_door2_fast");
	common_scripts\_destructible::destructible_fx("tag_fx", "props/locker_double_des_02_right", undefined, undefined, 4);
	common_scripts\_destructible::destructible_sound("lockers_fast", undefined, 4);
	common_scripts\_destructible::destructible_anim(get_precached_anim("locker_broken_both_doors_3"), 1, "setanimknob", undefined, 5, "locker_broken_both_doors_3");
	common_scripts\_destructible::destructible_fx("tag_fx", "misc/no_effect", undefined, undefined, 5);
	common_scripts\_destructible::destructible_sound("lockers_minor", undefined, 5);
	common_scripts\_destructible::destructible_anim(get_precached_anim("locker_broken_door1_slow"), 1, "setanimknob", undefined, 6, "locker_broken_door1_slow");
	common_scripts\_destructible::destructible_fx("tag_fx", "misc/no_effect", undefined, undefined, 6);
	common_scripts\_destructible::destructible_sound("lockers_minor", undefined, 6);
	common_scripts\_destructible::destructible_anim(get_precached_anim("locker_broken_door2_slow"), 1, "setanimknob", undefined, 7, "locker_broken_door2_slow");
	common_scripts\_destructible::destructible_fx("tag_fx", "misc/no_effect", undefined, undefined, 7);
	common_scripts\_destructible::destructible_sound("lockers_minor", undefined, 7);
	common_scripts\_destructible::destructible_state(undefined, "com_locker_double_destroyed", undefined, undefined, "no_melee");
}

toy_chicken(param_98F)
{
	common_scripts\_destructible::destructible_create("toy_chicken" + param_98F, "tag_origin", 0, undefined, 32);
	common_scripts\_destructible::destructible_anim(get_precached_anim("chicken_cage_loop_01"), 1, "setanimknob", undefined, 0, "chicken_cage_loop_01", 1.6);
	common_scripts\_destructible::destructible_anim(get_precached_anim("chicken_cage_loop_02"), 1, "setanimknob", undefined, 1, "chicken_cage_loop_02", 1.6);
	common_scripts\_destructible::destructible_loopsound("animal_chicken_idle_loop");
	common_scripts\_destructible::destructible_state("tag_origin", "chicken" + param_98F, 25);
	common_scripts\_destructible::destructible_fx("tag_origin", "props/chicken_exp" + param_98F);
	common_scripts\_destructible::destructible_anim(get_precached_anim("chicken_cage_death"), 1, "setanimknob", undefined, 0, "chicken_cage_death");
	common_scripts\_destructible::destructible_anim(get_precached_anim("chicken_cage_death_02"), 1, "setanimknob", undefined, 1, "chicken_cage_death_02");
	common_scripts\_destructible::destructible_sound("animal_chicken_death");
	common_scripts\_destructible::destructible_state(undefined, "chicken" + param_98F, undefined, undefined, "no_melee");
}

vehicle_bus_destructible()
{
	common_scripts\_destructible::destructible_create("vehicle_bus_destructible");
	tag = "tag_window_front_left";
	common_scripts\_destructible::destructible_part(tag, undefined, 99, undefined, undefined, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_state(tag + "_d", undefined, 200, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_fx(tag, "props/car_glass_large");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	tag = "tag_window_front_right";
	common_scripts\_destructible::destructible_part(tag, undefined, 99, undefined, undefined, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_state(tag + "_d", undefined, 200, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_fx(tag, "props/car_glass_large");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	tag = "tag_window_driver";
	common_scripts\_destructible::destructible_part(tag, undefined, 99, undefined, undefined, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_state(tag + "_d", undefined, 200, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_fx(tag, "props/car_glass_large");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	tag = "tag_window_back";
	common_scripts\_destructible::destructible_part(tag, undefined, 99, undefined, undefined, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_state(tag + "_d", undefined, 200, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_fx(tag, "props/car_glass_large");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	tag = "tag_window_side_1";
	common_scripts\_destructible::destructible_part(tag, undefined, 99, undefined, undefined, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_state(tag + "_d", undefined, 200, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_fx(tag, "props/car_glass_large");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	tag = "tag_window_side_2";
	common_scripts\_destructible::destructible_part(tag, undefined, 99, undefined, undefined, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_state(tag + "_d", undefined, 200, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_fx(tag, "props/car_glass_large");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	tag = "tag_window_side_3";
	common_scripts\_destructible::destructible_part(tag, undefined, 99, undefined, undefined, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_state(tag + "_d", undefined, 200, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_fx(tag, "props/car_glass_large");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	tag = "tag_window_side_4";
	common_scripts\_destructible::destructible_part(tag, undefined, 99, undefined, undefined, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_state(tag + "_d", undefined, 200, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_fx(tag, "props/car_glass_large");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	tag = "tag_window_side_5";
	common_scripts\_destructible::destructible_part(tag, undefined, 99, undefined, undefined, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_state(tag + "_d", undefined, 200, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_fx(tag, "props/car_glass_large");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	tag = "tag_window_side_6";
	common_scripts\_destructible::destructible_part(tag, undefined, 99, undefined, undefined, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_state(tag + "_d", undefined, 200, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_fx(tag, "props/car_glass_large");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	tag = "tag_window_side_7";
	common_scripts\_destructible::destructible_part(tag, undefined, 99, undefined, undefined, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_state(tag + "_d", undefined, 200, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_fx(tag, "props/car_glass_large");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	tag = "tag_window_side_8";
	common_scripts\_destructible::destructible_part(tag, undefined, 99, undefined, undefined, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_state(tag + "_d", undefined, 200, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_fx(tag, "props/car_glass_large");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	tag = "tag_window_side_9";
	common_scripts\_destructible::destructible_part(tag, undefined, 99, undefined, undefined, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_state(tag + "_d", undefined, 200, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_fx(tag, "props/car_glass_large");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	tag = "tag_window_side_10";
	common_scripts\_destructible::destructible_part(tag, undefined, 99, undefined, undefined, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_state(tag + "_d", undefined, 200, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_fx(tag, "props/car_glass_large");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	tag = "tag_window_side_11";
	common_scripts\_destructible::destructible_part(tag, undefined, 99, undefined, undefined, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_state(tag + "_d", undefined, 200, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_fx(tag, "props/car_glass_large");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
}

vehicle_80s_sedan1(color)
{
	common_scripts\_destructible::destructible_create("vehicle_80s_sedan1_" + color, "tag_body", 250, undefined, 32, "no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_hood_fx", "smoke/car_damage_whitesmoke", 0.4);
	common_scripts\_destructible::destructible_state(undefined, undefined, 200, undefined, 32, "no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_hood_fx", "smoke/car_damage_blacksmoke", 0.4);
	common_scripts\_destructible::destructible_state(undefined, undefined, 100, undefined, 32, "no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_hood_fx", "smoke/car_damage_blacksmoke_fire", 0.4);
	common_scripts\_destructible::destructible_sound("fire_vehicle_flareup_med");
	common_scripts\_destructible::destructible_loopsound("fire_vehicle_med");
	common_scripts\_destructible::destructible_healthdrain(12, 0.2, 150, "allies");
	common_scripts\_destructible::destructible_state(undefined, undefined, 300, "player_only", 32, "no_melee");
	common_scripts\_destructible::destructible_loopsound("fire_vehicle_med");
	common_scripts\_destructible::destructible_state(undefined, undefined, 400, undefined, 32, "no_melee");
	common_scripts\_destructible::destructible_fx("tag_death_fx", "explosions/small_vehicle_explosion", 0);
	common_scripts\_destructible::destructible_sound("car_explode");
	common_scripts\_destructible::destructible_explode(4000, 5000, 150, 250, 50, 300, undefined, undefined, 0.3, 500);
	common_scripts\_destructible::destructible_anim(%anim_0020, 1, "setanimknob", undefined, undefined, "vehicle_80s_sedan1_destroy");
	common_scripts\_destructible::destructible_state(undefined, "vehicle_80s_sedan1_" + color + "_destroyed", undefined, 32, "no_melee");
	tag = "tag_hood";
	common_scripts\_destructible::destructible_part(tag, "vehicle_80s_sedan1_" + color + "_hood", undefined, undefined, undefined, undefined, 1, 2.5);
	tag = "tag_trunk";
	common_scripts\_destructible::destructible_part(tag, "vehicle_80s_sedan1_" + color + "_trunk", undefined, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_part("left_wheel_01_jnt", undefined, 20, undefined, undefined, "no_melee");
	common_scripts\_destructible::destructible_anim(%anim_0023, 1, "setanim");
	common_scripts\_destructible::destructible_sound("veh_tire_deflate", "bullet");
	common_scripts\_destructible::destructible_part("left_wheel_02_jnt", undefined, 20, undefined, undefined, "no_melee");
	common_scripts\_destructible::destructible_anim(%anim_0024, 1, "setanim");
	common_scripts\_destructible::destructible_sound("veh_tire_deflate", "bullet");
	common_scripts\_destructible::destructible_part("right_wheel_01_jnt", "vehicle_80s_sedan1_" + color + "_wheel_LF", 20, undefined, undefined, "no_melee", undefined, 1.7);
	common_scripts\_destructible::destructible_anim(%anim_0021, 1, "setanim");
	common_scripts\_destructible::destructible_sound("veh_tire_deflate", "bullet");
	common_scripts\_destructible::destructible_part("right_wheel_02_jnt", "vehicle_80s_sedan1_" + color + "_wheel_LF", 20, undefined, undefined, "no_melee", undefined, 2.3);
	common_scripts\_destructible::destructible_anim(%anim_0022, 1, "setanim");
	common_scripts\_destructible::destructible_sound("veh_tire_deflate", "bullet");
	common_scripts\_destructible::destructible_part("tag_door_left_front", undefined, undefined, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_part("tag_door_left_back", undefined, undefined, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_part("tag_door_right_front", "vehicle_80s_sedan1_" + color + "_door_RF", undefined, undefined, undefined, undefined, 1, 1);
	common_scripts\_destructible::destructible_part("tag_door_right_back", "vehicle_80s_sedan1_" + color + "_door_RB", undefined, undefined, undefined, undefined, 1, 1);
	tag = "tag_glass_front";
	common_scripts\_destructible::destructible_part(tag, undefined, 40, undefined, undefined, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_state(tag + "_d", undefined, 60, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_fx("tag_glass_front_fx", "props/car_glass_large");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	tag = "tag_glass_back";
	common_scripts\_destructible::destructible_part(tag, undefined, 40, undefined, undefined, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_state(tag + "_d", undefined, 60, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_fx("tag_glass_back_fx", "props/car_glass_large");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	tag = "tag_glass_left_front";
	common_scripts\_destructible::destructible_part(tag, undefined, 20, undefined, undefined, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_state(tag + "_d", undefined, 60, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_fx("tag_glass_left_front_fx", "props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	tag = "tag_glass_right_front";
	common_scripts\_destructible::destructible_part(tag, undefined, 20, undefined, undefined, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_state(tag + "_d", undefined, 60, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_fx("tag_glass_right_front_fx", "props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	tag = "tag_glass_left_back";
	common_scripts\_destructible::destructible_part(tag, undefined, 20, undefined, undefined, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_state(tag + "_d", undefined, 60, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_fx("tag_glass_left_back_fx", "props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	tag = "tag_glass_right_back";
	common_scripts\_destructible::destructible_part(tag, undefined, 20, undefined, undefined, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_state(tag + "_d", undefined, 60, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_fx("tag_glass_right_back_fx", "props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	tag = "tag_light_left_front";
	common_scripts\_destructible::destructible_part(tag, undefined, 20, undefined, undefined, undefined, 0.5);
	common_scripts\_destructible::destructible_fx(tag, "props/car_glass_headlight");
	common_scripts\_destructible::destructible_sound("veh_glass_break_small");
	common_scripts\_destructible::destructible_state(tag + "_d");
	tag = "tag_light_right_front";
	common_scripts\_destructible::destructible_part(tag, undefined, 20, undefined, undefined, undefined, 0.5);
	common_scripts\_destructible::destructible_fx(tag, "props/car_glass_headlight");
	common_scripts\_destructible::destructible_sound("veh_glass_break_small");
	common_scripts\_destructible::destructible_state(tag + "_d");
	tag = "tag_light_left_back";
	common_scripts\_destructible::destructible_part(tag, undefined, 20);
	common_scripts\_destructible::destructible_fx(tag, "props/car_glass_brakelight");
	common_scripts\_destructible::destructible_sound("veh_glass_break_small");
	common_scripts\_destructible::destructible_state(tag + "_d");
	tag = "tag_light_right_back";
	common_scripts\_destructible::destructible_part(tag, undefined, 20);
	common_scripts\_destructible::destructible_fx(tag, "props/car_glass_brakelight");
	common_scripts\_destructible::destructible_sound("veh_glass_break_small");
	common_scripts\_destructible::destructible_state(tag + "_d");
	common_scripts\_destructible::destructible_part("tag_bumper_front", "vehicle_80s_sedan1_" + color + "_bumper_F", undefined, undefined, undefined, undefined, 1, 1);
	common_scripts\_destructible::destructible_part("tag_bumper_back", "vehicle_80s_sedan1_" + color + "_bumper_B", undefined, undefined, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_part("tag_mirror_left", "vehicle_80s_sedan1_" + color + "_mirror_L", 40, undefined, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_physics();
	common_scripts\_destructible::destructible_part("tag_mirror_right", "vehicle_80s_sedan1_" + color + "_mirror_R", 40, undefined, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_physics();
}

vehicle_80s_hatch1(color)
{
	common_scripts\_destructible::destructible_create("vehicle_80s_hatch1_" + color, "tag_body", 250, undefined, 32, "no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_hood_fx", "smoke/car_damage_whitesmoke", 0.4);
	common_scripts\_destructible::destructible_state(undefined, undefined, 200, undefined, 32, "no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_hood_fx", "smoke/car_damage_blacksmoke", 0.4);
	common_scripts\_destructible::destructible_state(undefined, undefined, 100, undefined, 32, "no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_hood_fx", "smoke/car_damage_blacksmoke_fire", 0.4);
	common_scripts\_destructible::destructible_sound("fire_vehicle_flareup_med");
	common_scripts\_destructible::destructible_loopsound("fire_vehicle_med");
	common_scripts\_destructible::destructible_healthdrain(12, 0.2, 150, "allies");
	common_scripts\_destructible::destructible_state(undefined, undefined, 300, "player_only", 32, "no_melee");
	common_scripts\_destructible::destructible_loopsound("fire_vehicle_med");
	common_scripts\_destructible::destructible_state(undefined, undefined, 400, undefined, 32, "no_melee");
	common_scripts\_destructible::destructible_fx("tag_death_fx", "explosions/small_vehicle_explosion", 0);
	common_scripts\_destructible::destructible_sound("car_explode");
	common_scripts\_destructible::destructible_explode(4000, 5000, 150, 250, 50, 300, undefined, undefined, 0.3, 500);
	common_scripts\_destructible::destructible_anim(%anim_0020, 1, "setanimknob", undefined, undefined, "vehicle_80s_sedan1_destroy");
	common_scripts\_destructible::destructible_state(undefined, "vehicle_80s_hatch1_" + color + "_destroyed", undefined, 32, "no_melee");
	tag = "tag_hood";
	common_scripts\_destructible::destructible_part(tag, "vehicle_80s_hatch1_" + color + "_hood", 800, undefined, undefined, undefined, 1, 1.5);
	common_scripts\_destructible::destructible_part("left_wheel_01_jnt", "vehicle_80s_hatch1_" + color + "_wheel_LF", 20, undefined, undefined, "no_melee", undefined, 1.7);
	common_scripts\_destructible::destructible_anim(%anim_0023, 1, "setanim");
	common_scripts\_destructible::destructible_sound("veh_tire_deflate", "bullet");
	common_scripts\_destructible::destructible_part("left_wheel_02_jnt", undefined, 20, undefined, undefined, "no_melee");
	common_scripts\_destructible::destructible_anim(%anim_0024, 1, "setanim");
	common_scripts\_destructible::destructible_sound("veh_tire_deflate", "bullet");
	common_scripts\_destructible::destructible_part("right_wheel_01_jnt", "vehicle_80s_hatch1_" + color + "_wheel_LF", 20, undefined, undefined, "no_melee", undefined, 1.7);
	common_scripts\_destructible::destructible_anim(%anim_0021, 1, "setanim");
	common_scripts\_destructible::destructible_sound("veh_tire_deflate", "bullet");
	common_scripts\_destructible::destructible_part("right_wheel_02_jnt", undefined, 20, undefined, undefined, "no_melee");
	common_scripts\_destructible::destructible_anim(%anim_0022, 1, "setanim");
	common_scripts\_destructible::destructible_sound("veh_tire_deflate", "bullet");
	common_scripts\_destructible::destructible_part("tag_door_left_front", undefined, undefined, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_part("tag_door_right_front", "vehicle_80s_hatch1_" + color + "_door_RF", undefined, undefined, undefined, undefined, 1, 1);
	tag = "tag_glass_front";
	common_scripts\_destructible::destructible_part(tag, undefined, 10, undefined, undefined, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_state(tag + "_d", undefined, 60, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_fx("tag_glass_front_fx", "props/car_glass_large");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	tag = "tag_glass_back";
	common_scripts\_destructible::destructible_part(tag, undefined, 10, undefined, undefined, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_state(tag + "_d", undefined, 60, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_fx("tag_glass_back_fx", "props/car_glass_large");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	tag = "tag_glass_left_front";
	common_scripts\_destructible::destructible_part(tag, undefined, 10, undefined, undefined, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_state(tag + "_d", undefined, 60, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_fx("tag_glass_left_front_fx", "props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	tag = "tag_glass_right_front";
	common_scripts\_destructible::destructible_part(tag, undefined, 10, undefined, undefined, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_state(tag + "_d", undefined, 60, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_fx("tag_glass_right_front_fx", "props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	tag = "tag_glass_left_back";
	common_scripts\_destructible::destructible_part(tag, undefined, 10, undefined, undefined, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_state(tag + "_d", undefined, 60, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_fx("tag_glass_left_back_fx", "props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	tag = "tag_glass_right_back";
	common_scripts\_destructible::destructible_part(tag, undefined, 10, undefined, undefined, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_state(tag + "_d", undefined, 60, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_fx("tag_glass_right_back_fx", "props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	tag = "tag_light_left_front";
	common_scripts\_destructible::destructible_part(tag, undefined, 20, undefined, undefined, undefined, 0.5);
	common_scripts\_destructible::destructible_fx(tag, "props/car_glass_headlight");
	common_scripts\_destructible::destructible_sound("veh_glass_break_small");
	common_scripts\_destructible::destructible_state(tag + "_d");
	tag = "tag_light_right_front";
	common_scripts\_destructible::destructible_part(tag, undefined, 20, undefined, undefined, undefined, 0.5);
	common_scripts\_destructible::destructible_fx(tag, "props/car_glass_headlight");
	common_scripts\_destructible::destructible_sound("veh_glass_break_small");
	common_scripts\_destructible::destructible_state(tag + "_d");
	tag = "tag_light_left_back";
	common_scripts\_destructible::destructible_part(tag, undefined, 20);
	common_scripts\_destructible::destructible_fx(tag, "props/car_glass_brakelight");
	common_scripts\_destructible::destructible_sound("veh_glass_break_small");
	common_scripts\_destructible::destructible_state(tag + "_d");
	tag = "tag_light_right_back";
	common_scripts\_destructible::destructible_part(tag, undefined, 20);
	common_scripts\_destructible::destructible_fx(tag, "props/car_glass_brakelight");
	common_scripts\_destructible::destructible_sound("veh_glass_break_small");
	common_scripts\_destructible::destructible_state(tag + "_d");
	common_scripts\_destructible::destructible_part("tag_bumper_front");
	common_scripts\_destructible::destructible_part("tag_bumper_back");
	common_scripts\_destructible::destructible_part("tag_mirror_left", "vehicle_80s_hatch1_" + color + "_mirror_L", 40);
	common_scripts\_destructible::destructible_physics();
	common_scripts\_destructible::destructible_part("tag_mirror_right", "vehicle_80s_hatch1_" + color + "_mirror_R", 40);
	common_scripts\_destructible::destructible_physics();
}

vehicle_80s_hatch2(color)
{
	common_scripts\_destructible::destructible_create("vehicle_80s_hatch2_" + color, "tag_body", 250, undefined, 32, "no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_hood_fx", "smoke/car_damage_whitesmoke", 0.4);
	common_scripts\_destructible::destructible_state(undefined, undefined, 200, undefined, 32, "no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_hood_fx", "smoke/car_damage_blacksmoke", 0.4);
	common_scripts\_destructible::destructible_state(undefined, undefined, 100, undefined, 32, "no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_hood_fx", "smoke/car_damage_blacksmoke_fire", 0.4);
	common_scripts\_destructible::destructible_sound("fire_vehicle_flareup_med");
	common_scripts\_destructible::destructible_loopsound("fire_vehicle_med");
	common_scripts\_destructible::destructible_healthdrain(12, 0.2, 150, "allies");
	common_scripts\_destructible::destructible_state(undefined, undefined, 300, "player_only", 32, "no_melee");
	common_scripts\_destructible::destructible_loopsound("fire_vehicle_med");
	common_scripts\_destructible::destructible_state(undefined, undefined, 400, undefined, 32, "no_melee");
	common_scripts\_destructible::destructible_fx("tag_death_fx", "explosions/small_vehicle_explosion", 0);
	common_scripts\_destructible::destructible_sound("car_explode");
	common_scripts\_destructible::destructible_explode(4000, 5000, 150, 250, 50, 300, undefined, undefined, 0.3, 500);
	common_scripts\_destructible::destructible_anim(%anim_0020, 1, "setanimknob", undefined, undefined, "vehicle_80s_sedan1_destroy");
	common_scripts\_destructible::destructible_state(undefined, "vehicle_80s_hatch2_" + color + "_destroyed", undefined, 32, "no_melee");
	tag = "tag_hood";
	common_scripts\_destructible::destructible_part(tag, "vehicle_80s_hatch2_" + color + "_hood", 800, undefined, undefined, undefined, 1, 1.5);
	common_scripts\_destructible::destructible_part("left_wheel_01_jnt", "vehicle_80s_hatch2_" + color + "_wheel_LF", 20, undefined, undefined, "no_melee", undefined, 1.7);
	common_scripts\_destructible::destructible_anim(%anim_0023, 1, "setanim");
	common_scripts\_destructible::destructible_sound("veh_tire_deflate", "bullet");
	common_scripts\_destructible::destructible_part("left_wheel_02_jnt", undefined, 20, undefined, undefined, "no_melee");
	common_scripts\_destructible::destructible_anim(%anim_0024, 1, "setanim");
	common_scripts\_destructible::destructible_sound("veh_tire_deflate", "bullet");
	common_scripts\_destructible::destructible_part("right_wheel_01_jnt", "vehicle_80s_hatch2_" + color + "_wheel_LF", 20, undefined, undefined, "no_melee", undefined, 1.7);
	common_scripts\_destructible::destructible_anim(%anim_0021, 1, "setanim");
	common_scripts\_destructible::destructible_sound("veh_tire_deflate", "bullet");
	common_scripts\_destructible::destructible_part("right_wheel_02_jnt", undefined, 20, undefined, undefined, "no_melee");
	common_scripts\_destructible::destructible_anim(%anim_0022, 1, "setanim");
	common_scripts\_destructible::destructible_sound("veh_tire_deflate", "bullet");
	common_scripts\_destructible::destructible_part("tag_door_left_front", undefined, undefined, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_part("tag_door_right_front", "vehicle_80s_hatch2_" + color + "_door_RF", undefined, undefined, undefined, undefined, 1, 1);
	tag = "tag_glass_front";
	common_scripts\_destructible::destructible_part(tag, undefined, 40, undefined, undefined, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_state(tag + "_d", undefined, 60, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_fx("tag_glass_front_fx", "props/car_glass_large");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	tag = "tag_glass_back";
	common_scripts\_destructible::destructible_part(tag, undefined, 40, undefined, undefined, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_state(tag + "_d", undefined, 60, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_fx("tag_glass_back_fx", "props/car_glass_large");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	tag = "tag_glass_left_front";
	common_scripts\_destructible::destructible_part(tag, undefined, 20, undefined, undefined, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_state(tag + "_d", undefined, 60, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_fx("tag_glass_left_front_fx", "props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	tag = "tag_glass_right_front";
	common_scripts\_destructible::destructible_part(tag, undefined, 20, undefined, undefined, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_state(tag + "_d", undefined, 60, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_fx("tag_glass_right_front_fx", "props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	tag = "tag_glass_left_back";
	common_scripts\_destructible::destructible_part(tag, undefined, 20, undefined, undefined, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_state(tag + "_d", undefined, 60, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_fx("tag_glass_left_back_fx", "props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	tag = "tag_glass_right_back";
	common_scripts\_destructible::destructible_part(tag, undefined, 20, undefined, undefined, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_state(tag + "_d", undefined, 60, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_fx("tag_glass_right_back_fx", "props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	tag = "tag_light_left_front";
	common_scripts\_destructible::destructible_part(tag, undefined, 20, undefined, undefined, undefined, 0.5);
	common_scripts\_destructible::destructible_fx(tag, "props/car_glass_headlight");
	common_scripts\_destructible::destructible_sound("veh_glass_break_small");
	common_scripts\_destructible::destructible_state(tag + "_d");
	tag = "tag_light_right_front";
	common_scripts\_destructible::destructible_part(tag, undefined, 20, undefined, undefined, undefined, 0.5);
	common_scripts\_destructible::destructible_fx(tag, "props/car_glass_headlight");
	common_scripts\_destructible::destructible_sound("veh_glass_break_small");
	common_scripts\_destructible::destructible_state(tag + "_d");
	tag = "tag_light_left_back";
	common_scripts\_destructible::destructible_part(tag, undefined, 20);
	common_scripts\_destructible::destructible_fx(tag, "props/car_glass_brakelight");
	common_scripts\_destructible::destructible_sound("veh_glass_break_small");
	common_scripts\_destructible::destructible_state(tag + "_d");
	tag = "tag_light_right_back";
	common_scripts\_destructible::destructible_part(tag, undefined, 20);
	common_scripts\_destructible::destructible_fx(tag, "props/car_glass_brakelight");
	common_scripts\_destructible::destructible_sound("veh_glass_break_small");
	common_scripts\_destructible::destructible_state(tag + "_d");
	common_scripts\_destructible::destructible_part("tag_bumper_front");
	common_scripts\_destructible::destructible_part("tag_bumper_back");
	common_scripts\_destructible::destructible_part("tag_mirror_left", "vehicle_80s_hatch2_" + color + "_mirror_L", 40);
	common_scripts\_destructible::destructible_physics();
	common_scripts\_destructible::destructible_part("tag_mirror_right", "vehicle_80s_hatch2_" + color + "_mirror_R", 40);
	common_scripts\_destructible::destructible_physics();
}

vehicle_80s_wagon1(color)
{
	common_scripts\_destructible::destructible_create("vehicle_80s_wagon1_" + color, "tag_body", 250, undefined, 32, "no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_hood_fx", "smoke/car_damage_whitesmoke", 0.4);
	common_scripts\_destructible::destructible_state(undefined, undefined, 200, undefined, 32, "no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_hood_fx", "smoke/car_damage_blacksmoke", 0.4);
	common_scripts\_destructible::destructible_state(undefined, undefined, 100, undefined, 32, "no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_hood_fx", "smoke/car_damage_blacksmoke_fire", 0.4);
	common_scripts\_destructible::destructible_sound("fire_vehicle_flareup_med");
	common_scripts\_destructible::destructible_loopsound("fire_vehicle_med");
	common_scripts\_destructible::destructible_healthdrain(12, 0.2, 150, "allies");
	common_scripts\_destructible::destructible_state(undefined, undefined, 300, "player_only", 32, "no_melee");
	common_scripts\_destructible::destructible_loopsound("fire_vehicle_med");
	common_scripts\_destructible::destructible_state(undefined, undefined, 400, undefined, 32, "no_melee");
	common_scripts\_destructible::destructible_fx("tag_death_fx", "explosions/small_vehicle_explosion", 0);
	common_scripts\_destructible::destructible_sound("car_explode");
	common_scripts\_destructible::destructible_explode(4000, 5000, 150, 250, 50, 300, undefined, undefined, 0.3, 500);
	common_scripts\_destructible::destructible_anim(%anim_0020, 1, "setanimknob", undefined, undefined, "vehicle_80s_sedan1_destroy");
	common_scripts\_destructible::destructible_state(undefined, "vehicle_80s_wagon1_" + color + "_destroyed", undefined, 32, "no_melee");
	tag = "tag_hood";
	common_scripts\_destructible::destructible_part(tag, "vehicle_80s_wagon1_" + color + "_hood", 800, undefined, undefined, undefined, 1, 1.5);
	common_scripts\_destructible::destructible_part("left_wheel_01_jnt", undefined, 20, undefined, undefined, "no_melee");
	common_scripts\_destructible::destructible_anim(%anim_0023, 1, "setanim");
	common_scripts\_destructible::destructible_sound("veh_tire_deflate", "bullet");
	common_scripts\_destructible::destructible_part("left_wheel_02_jnt", "vehicle_80s_wagon1_" + color + "_wheel_LF", 20, undefined, undefined, "no_melee", undefined, 1.7);
	common_scripts\_destructible::destructible_anim(%anim_0024, 1, "setanim");
	common_scripts\_destructible::destructible_sound("veh_tire_deflate", "bullet");
	common_scripts\_destructible::destructible_part("right_wheel_01_jnt", undefined, 20, undefined, undefined, "no_melee");
	common_scripts\_destructible::destructible_anim(%anim_0021, 1, "setanim");
	common_scripts\_destructible::destructible_sound("veh_tire_deflate", "bullet");
	common_scripts\_destructible::destructible_part("right_wheel_02_jnt", "vehicle_80s_wagon1_" + color + "_wheel_LF", 20, undefined, undefined, "no_melee", undefined, 1.7);
	common_scripts\_destructible::destructible_anim(%anim_0022, 1, "setanim");
	common_scripts\_destructible::destructible_sound("veh_tire_deflate", "bullet");
	common_scripts\_destructible::destructible_part("tag_door_left_front", undefined, undefined, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_part("tag_door_left_back", undefined, undefined, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_part("tag_door_right_front", undefined, undefined, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_part("tag_door_right_back", "vehicle_80s_wagon1_" + color + "_door_RB", undefined, undefined, undefined, undefined, 1, 1);
	tag = "tag_glass_front";
	common_scripts\_destructible::destructible_part(tag, undefined, 40, undefined, undefined, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_state(tag + "_d", undefined, 60, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_fx("tag_glass_front_fx", "props/car_glass_large");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	tag = "tag_glass_back";
	common_scripts\_destructible::destructible_part(tag, undefined, 40, undefined, undefined, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_state(tag + "_d", undefined, 60, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_fx("tag_glass_back_fx", "props/car_glass_large");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	tag = "tag_glass_left_front";
	common_scripts\_destructible::destructible_part(tag, undefined, 20, undefined, undefined, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_state(tag + "_d", undefined, 60, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_fx("tag_glass_left_front_fx", "props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	tag = "tag_glass_right_front";
	common_scripts\_destructible::destructible_part(tag, undefined, 20, undefined, undefined, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_state(tag + "_d", undefined, 60, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_fx("tag_glass_right_front_fx", "props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	tag = "tag_glass_left_back";
	common_scripts\_destructible::destructible_part(tag, undefined, 20, undefined, undefined, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_state(tag + "_d", undefined, 60, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_fx("tag_glass_left_back_fx", "props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	tag = "tag_glass_right_back";
	common_scripts\_destructible::destructible_part(tag, undefined, 20, undefined, undefined, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_state(tag + "_d", undefined, 60, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_fx("tag_glass_right_back_fx", "props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	tag = "tag_glass_left_back2";
	common_scripts\_destructible::destructible_part(tag, undefined, 20, undefined, undefined, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_state(tag + "_d", undefined, 60, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_fx("tag_glass_left_back2_fx", "props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	tag = "tag_glass_right_back2";
	common_scripts\_destructible::destructible_part(tag, undefined, 20, undefined, undefined, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_state(tag + "_d", undefined, 60, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_fx("tag_glass_right_back2_fx", "props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	tag = "tag_light_left_front";
	common_scripts\_destructible::destructible_part(tag, undefined, 20, undefined, undefined, undefined, 0.5);
	common_scripts\_destructible::destructible_fx(tag, "props/car_glass_headlight");
	common_scripts\_destructible::destructible_sound("veh_glass_break_small");
	common_scripts\_destructible::destructible_state(tag + "_d");
	tag = "tag_light_right_front";
	common_scripts\_destructible::destructible_part(tag, undefined, 20, undefined, undefined, undefined, 0.5);
	common_scripts\_destructible::destructible_fx(tag, "props/car_glass_headlight");
	common_scripts\_destructible::destructible_sound("veh_glass_break_small");
	common_scripts\_destructible::destructible_state(tag + "_d");
	tag = "tag_light_left_back";
	common_scripts\_destructible::destructible_part(tag, undefined, 20);
	common_scripts\_destructible::destructible_fx(tag, "props/car_glass_brakelight");
	common_scripts\_destructible::destructible_sound("veh_glass_break_small");
	common_scripts\_destructible::destructible_state(tag + "_d");
	tag = "tag_light_right_back";
	common_scripts\_destructible::destructible_part(tag, undefined, 20);
	common_scripts\_destructible::destructible_fx(tag, "props/car_glass_brakelight");
	common_scripts\_destructible::destructible_sound("veh_glass_break_small");
	common_scripts\_destructible::destructible_state(tag + "_d");
	common_scripts\_destructible::destructible_part("tag_bumper_front", "vehicle_80s_wagon1_" + color + "_bumper_F", undefined, undefined, undefined, undefined, 1, 0.7);
	common_scripts\_destructible::destructible_part("tag_bumper_back", undefined, undefined, undefined, undefined, undefined, undefined, 0.6);
	common_scripts\_destructible::destructible_part("tag_mirror_left", "vehicle_80s_wagon1_" + color + "_mirror_L", 40);
	common_scripts\_destructible::destructible_physics();
	common_scripts\_destructible::destructible_part("tag_mirror_right", "vehicle_80s_wagon1_" + color + "_mirror_R", 40);
	common_scripts\_destructible::destructible_physics();
}

vehicle_small_hatch(color)
{
	common_scripts\_destructible::destructible_create("vehicle_small_hatch_" + color, "tag_body", 250, undefined, 32, "no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_hood_fx", "smoke/car_damage_whitesmoke", 0.4);
	common_scripts\_destructible::destructible_state(undefined, undefined, 200, undefined, 32, "no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_hood_fx", "smoke/car_damage_blacksmoke", 0.4);
	common_scripts\_destructible::destructible_state(undefined, undefined, 100, undefined, 32, "no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_hood_fx", "smoke/car_damage_blacksmoke_fire", 0.4);
	common_scripts\_destructible::destructible_sound("fire_vehicle_flareup_med");
	common_scripts\_destructible::destructible_loopsound("fire_vehicle_med");
	common_scripts\_destructible::destructible_healthdrain(15, 0.25, 150, "allies");
	common_scripts\_destructible::destructible_state(undefined, undefined, 300, "player_only", 32, "no_melee");
	common_scripts\_destructible::destructible_loopsound("fire_vehicle_med");
	common_scripts\_destructible::destructible_state(undefined, undefined, 400, undefined, 32, "no_melee");
	common_scripts\_destructible::destructible_fx("tag_death_fx", "explosions/small_vehicle_explosion", 0);
	common_scripts\_destructible::destructible_sound("car_explode");
	common_scripts\_destructible::destructible_explode(4000, 5000, 150, 250, 50, 300, undefined, undefined, 0.3, 500);
	common_scripts\_destructible::destructible_anim(%anim_0020, 1, "setanimknob", undefined, undefined, "vehicle_80s_sedan1_destroy");
	common_scripts\_destructible::destructible_state(undefined, "vehicle_small_hatch_" + color + "_destroyed", undefined, 32, "no_melee");
	tag = "tag_hood";
	common_scripts\_destructible::destructible_part(tag, "vehicle_small_hatch_" + color + "_hood", 800, undefined, undefined, undefined, 1, 1.5);
	common_scripts\_destructible::destructible_part("left_wheel_01_jnt", undefined, 20, undefined, undefined, "no_melee");
	common_scripts\_destructible::destructible_anim(%anim_0023, 1, "setanim");
	common_scripts\_destructible::destructible_sound("veh_tire_deflate", "bullet");
	common_scripts\_destructible::destructible_part("left_wheel_02_jnt", undefined, 20, undefined, undefined, "no_melee");
	common_scripts\_destructible::destructible_anim(%anim_0024, 1, "setanim");
	common_scripts\_destructible::destructible_sound("veh_tire_deflate", "bullet");
	common_scripts\_destructible::destructible_part("right_wheel_01_jnt", undefined, 20, undefined, undefined, "no_melee");
	common_scripts\_destructible::destructible_anim(%anim_0021, 1, "setanim");
	common_scripts\_destructible::destructible_sound("veh_tire_deflate", "bullet");
	common_scripts\_destructible::destructible_part("right_wheel_02_jnt", undefined, 20, undefined, undefined, "no_melee");
	common_scripts\_destructible::destructible_anim(%anim_0022, 1, "setanim");
	common_scripts\_destructible::destructible_sound("veh_tire_deflate", "bullet");
	common_scripts\_destructible::destructible_part("tag_door_left_front", "vehicle_small_hatch_" + color + "_door_LF", undefined, undefined, undefined, undefined, 1, 1);
	common_scripts\_destructible::destructible_part("tag_door_right_front", "vehicle_small_hatch_" + color + "_door_RF", undefined, undefined, undefined, undefined, 1, 1);
	tag = "tag_glass_front";
	common_scripts\_destructible::destructible_part(tag, undefined, 40, undefined, undefined, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_state(tag + "_d", undefined, 60, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_fx("tag_glass_front_fx", "props/car_glass_large");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	tag = "tag_glass_back";
	common_scripts\_destructible::destructible_part(tag, undefined, 40, undefined, undefined, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_state(tag + "_d", undefined, 60, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_fx("tag_glass_back_fx", "props/car_glass_large");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	tag = "tag_glass_left_front";
	common_scripts\_destructible::destructible_part(tag, undefined, 20, undefined, undefined, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_state(tag + "_d", undefined, 60, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_fx("tag_glass_left_front_fx", "props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	tag = "tag_glass_right_front";
	common_scripts\_destructible::destructible_part(tag, undefined, 20, undefined, undefined, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_state(tag + "_d", undefined, 60, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_fx("tag_glass_right_front_fx", "props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	tag = "tag_glass_left_back";
	common_scripts\_destructible::destructible_part(tag, undefined, 20, undefined, undefined, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_state(tag + "_d", undefined, 60, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_fx("tag_glass_left_back_fx", "props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	tag = "tag_glass_right_back";
	common_scripts\_destructible::destructible_part(tag, undefined, 20, undefined, undefined, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_state(tag + "_d", undefined, 60, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_fx("tag_glass_right_back_fx", "props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	tag = "tag_light_left_front";
	common_scripts\_destructible::destructible_part(tag, undefined, 20, undefined, undefined, undefined, 0.5);
	common_scripts\_destructible::destructible_fx(tag, "props/car_glass_headlight");
	common_scripts\_destructible::destructible_sound("veh_glass_break_small");
	common_scripts\_destructible::destructible_state(tag + "_d");
	tag = "tag_light_right_front";
	common_scripts\_destructible::destructible_part(tag, undefined, 20, undefined, undefined, undefined, 0.5);
	common_scripts\_destructible::destructible_fx(tag, "props/car_glass_headlight");
	common_scripts\_destructible::destructible_sound("veh_glass_break_small");
	common_scripts\_destructible::destructible_state(tag + "_d");
	tag = "tag_light_left_back";
	common_scripts\_destructible::destructible_part(tag, undefined, 20, undefined, undefined, undefined, 0.5);
	common_scripts\_destructible::destructible_fx(tag, "props/car_glass_brakelight");
	common_scripts\_destructible::destructible_sound("veh_glass_break_small");
	common_scripts\_destructible::destructible_state(tag + "_d");
	tag = "tag_light_right_back";
	common_scripts\_destructible::destructible_part(tag, undefined, 20, undefined, undefined, undefined, 0.5);
	common_scripts\_destructible::destructible_fx(tag, "props/car_glass_brakelight");
	common_scripts\_destructible::destructible_sound("veh_glass_break_small");
	common_scripts\_destructible::destructible_state(tag + "_d");
	common_scripts\_destructible::destructible_part("tag_bumper_front", undefined, undefined, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_part("tag_bumper_back", undefined, undefined, undefined, undefined, undefined, 0.5);
	common_scripts\_destructible::destructible_part("tag_mirror_left", "vehicle_small_hatch_" + color + "_mirror_L", 40, undefined, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_physics();
	common_scripts\_destructible::destructible_part("tag_mirror_right", "vehicle_small_hatch_" + color + "_mirror_R", 40, undefined, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_physics();
}

vehicle_pickup(destructibletype)
{
	common_scripts\_destructible::destructible_create(destructibletype, "tag_body", 300, undefined, 32, "no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_hood_fx", "smoke/car_damage_whitesmoke", 0.4);
	common_scripts\_destructible::destructible_state(undefined, undefined, 200, undefined, 32, "no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_hood_fx", "smoke/car_damage_blacksmoke", 0.4);
	common_scripts\_destructible::destructible_state(undefined, undefined, 100, undefined, 32, "no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_hood_fx", "smoke/car_damage_blacksmoke_fire", 0.4);
	common_scripts\_destructible::destructible_sound("fire_vehicle_flareup_med");
	common_scripts\_destructible::destructible_loopsound("fire_vehicle_med");
	common_scripts\_destructible::destructible_healthdrain(15, 0.25, 210, "allies");
	common_scripts\_destructible::destructible_state(undefined, undefined, 300, "player_only", 32, "no_melee");
	common_scripts\_destructible::destructible_loopsound("fire_vehicle_med");
	common_scripts\_destructible::destructible_state(undefined, undefined, 400, undefined, 32, "no_melee");
	common_scripts\_destructible::destructible_fx("tag_death_fx", "explosions/small_vehicle_explosion", 0);
	common_scripts\_destructible::destructible_sound("car_explode");
	common_scripts\_destructible::destructible_explode(4000, 5000, 210, 250, 50, 300, undefined, undefined, 0.3, 500);
	common_scripts\_destructible::destructible_anim(%anim_0020, 1, "setanimknob", undefined, undefined, "vehicle_80s_sedan1_destroy");
	common_scripts\_destructible::destructible_state(undefined, "vehicle_pickup_destroyed", undefined, 32, "no_melee");
	tag = "tag_hood";
	common_scripts\_destructible::destructible_part(tag, "vehicle_pickup_hood", 800, undefined, undefined, undefined, 1, 2.5);
	common_scripts\_destructible::destructible_part("left_wheel_01_jnt", undefined, 20, undefined, undefined, "no_melee");
	common_scripts\_destructible::destructible_anim(%anim_0023, 1, "setanim");
	common_scripts\_destructible::destructible_sound("veh_tire_deflate", "bullet");
	common_scripts\_destructible::destructible_part("left_wheel_02_jnt", undefined, 20, undefined, undefined, "no_melee");
	common_scripts\_destructible::destructible_anim(%anim_0024, 1, "setanim");
	common_scripts\_destructible::destructible_sound("veh_tire_deflate", "bullet");
	common_scripts\_destructible::destructible_part("right_wheel_01_jnt", undefined, 20, undefined, undefined, "no_melee");
	common_scripts\_destructible::destructible_anim(%anim_0021, 1, "setanim");
	common_scripts\_destructible::destructible_sound("veh_tire_deflate", "bullet");
	common_scripts\_destructible::destructible_part("right_wheel_02_jnt", undefined, 20, undefined, undefined, "no_melee");
	common_scripts\_destructible::destructible_anim(%anim_0022, 1, "setanim");
	common_scripts\_destructible::destructible_sound("veh_tire_deflate", "bullet");
	common_scripts\_destructible::destructible_part("tag_door_left_front", "vehicle_pickup_door_LF", undefined, undefined, undefined, undefined, 1, 1);
	common_scripts\_destructible::destructible_part("tag_door_right_front", "vehicle_pickup_door_RF", undefined, undefined, undefined, undefined, 1, 1);
	tag = "tag_glass_front";
	common_scripts\_destructible::destructible_part(tag, undefined, 40, undefined, undefined, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_state(tag + "_d", undefined, 60, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_fx("tag_glass_front_fx", "props/car_glass_large");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	tag = "tag_glass_back";
	common_scripts\_destructible::destructible_part(tag, undefined, 40, undefined, undefined, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_state(tag + "_d", undefined, 60, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_fx("tag_glass_back_fx", "props/car_glass_large");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	tag = "tag_glass_left_front";
	common_scripts\_destructible::destructible_part(tag, undefined, 20, undefined, undefined, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_state(tag + "_d", undefined, 60, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_fx("tag_glass_left_front_fx", "props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	tag = "tag_glass_right_front";
	common_scripts\_destructible::destructible_part(tag, undefined, 20, undefined, undefined, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_state(tag + "_d", undefined, 60, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_fx("tag_glass_right_front_fx", "props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	tag = "tag_glass_left_back";
	common_scripts\_destructible::destructible_part(tag, undefined, 20, undefined, undefined, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_state(tag + "_d", undefined, 60, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_fx("tag_glass_left_back_fx", "props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	tag = "tag_glass_right_back";
	common_scripts\_destructible::destructible_part(tag, undefined, 20, undefined, undefined, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_state(tag + "_d", undefined, 60, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_fx("tag_glass_right_back_fx", "props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	tag = "tag_light_left_front";
	common_scripts\_destructible::destructible_part(tag, undefined, 20, undefined, undefined, undefined, 0.5);
	common_scripts\_destructible::destructible_fx(tag, "props/car_glass_headlight");
	common_scripts\_destructible::destructible_sound("veh_glass_break_small");
	common_scripts\_destructible::destructible_state(tag + "_d");
	tag = "tag_light_right_front";
	common_scripts\_destructible::destructible_part(tag, undefined, 20, undefined, undefined, undefined, 0.5);
	common_scripts\_destructible::destructible_fx(tag, "props/car_glass_headlight");
	common_scripts\_destructible::destructible_sound("veh_glass_break_small");
	common_scripts\_destructible::destructible_state(tag + "_d");
	tag = "tag_light_left_back";
	common_scripts\_destructible::destructible_part(tag, undefined, 20);
	common_scripts\_destructible::destructible_fx(tag, "props/car_glass_brakelight");
	common_scripts\_destructible::destructible_sound("veh_glass_break_small");
	common_scripts\_destructible::destructible_state(tag + "_d");
	tag = "tag_light_right_back";
	common_scripts\_destructible::destructible_part(tag, undefined, 20);
	common_scripts\_destructible::destructible_fx(tag, "props/car_glass_brakelight");
	common_scripts\_destructible::destructible_sound("veh_glass_break_small");
	common_scripts\_destructible::destructible_state(tag + "_d");
	common_scripts\_destructible::destructible_part("tag_bumper_front", undefined, undefined, undefined, undefined, undefined, 1, 1);
	common_scripts\_destructible::destructible_part("tag_bumper_back", undefined, undefined, undefined, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_part("tag_mirror_left", "vehicle_pickup_mirror_L", 40, undefined, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_physics();
	common_scripts\_destructible::destructible_part("tag_mirror_right", "vehicle_pickup_mirror_R", 40, undefined, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_physics();
}

vehicle_hummer(destructibletype)
{
	common_scripts\_destructible::destructible_create(destructibletype, "tag_body", 400, undefined, 32, "no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_hood_fx", "smoke/car_damage_whitesmoke", 0.4);
	common_scripts\_destructible::destructible_state(undefined, undefined, 400, undefined, 32, "no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_hood_fx", "smoke/car_damage_blacksmoke", 0.4);
	common_scripts\_destructible::destructible_state(undefined, undefined, 200, undefined, 32, "no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_hood_fx", "smoke/car_damage_blacksmoke_fire", 0.4);
	common_scripts\_destructible::destructible_sound("fire_vehicle_flareup_med");
	common_scripts\_destructible::destructible_loopsound("fire_vehicle_med");
	common_scripts\_destructible::destructible_healthdrain(15, 0.25, 210, "allies");
	common_scripts\_destructible::destructible_state(undefined, undefined, 300, "player_only", 32, "no_melee");
	common_scripts\_destructible::destructible_loopsound("fire_vehicle_med");
	common_scripts\_destructible::destructible_state(undefined, undefined, 400, undefined, 32, "no_melee");
	common_scripts\_destructible::destructible_fx("tag_deathfx", "explosions/vehicle_explosion_hummer", 0);
	common_scripts\_destructible::destructible_sound("car_explode");
	common_scripts\_destructible::destructible_explode(4000, 5000, 210, 250, 50, 300, undefined, undefined, 0.3, 500);
	common_scripts\_destructible::destructible_anim(%anim_0020, 1, "setanimknob", undefined, undefined, "vehicle_80s_sedan1_destroy");
	common_scripts\_destructible::destructible_state(undefined, "vehicle_hummer_destroyed", undefined, 32, "no_melee");
	common_scripts\_destructible::destructible_part("left_wheel_01_jnt", undefined, 20, undefined, undefined, "no_melee");
	common_scripts\_destructible::destructible_anim(%anim_0023, 1, "setanim");
	common_scripts\_destructible::destructible_sound("veh_tire_deflate", "bullet");
	common_scripts\_destructible::destructible_part("left_wheel_02_jnt", undefined, 20, undefined, undefined, "no_melee");
	common_scripts\_destructible::destructible_anim(%anim_0024, 1, "setanim");
	common_scripts\_destructible::destructible_sound("veh_tire_deflate", "bullet");
	common_scripts\_destructible::destructible_part("right_wheel_01_jnt", undefined, 20, undefined, undefined, "no_melee");
	common_scripts\_destructible::destructible_anim(%anim_0021, 1, "setanim");
	common_scripts\_destructible::destructible_sound("veh_tire_deflate", "bullet");
	common_scripts\_destructible::destructible_part("right_wheel_02_jnt", undefined, 20, undefined, undefined, "no_melee");
	common_scripts\_destructible::destructible_anim(%anim_0022, 1, "setanim");
	common_scripts\_destructible::destructible_sound("veh_tire_deflate", "bullet");
	tag = "tag_glass_front";
	common_scripts\_destructible::destructible_part(tag, undefined, 40, undefined, undefined, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_state(tag + "_d", undefined, 60, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_fx("tag_glass_front_fx", "props/car_glass_large");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	tag = "tag_glass_left_front";
	common_scripts\_destructible::destructible_part(tag, undefined, 20, undefined, undefined, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_state(tag + "_d", undefined, 60, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_fx("tag_glass_left_front_fx", "props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	tag = "tag_glass_right_front";
	common_scripts\_destructible::destructible_part(tag, undefined, 20, undefined, undefined, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_state(tag + "_d", undefined, 60, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_fx("tag_glass_right_front_fx", "props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	tag = "tag_glass_left_back";
	common_scripts\_destructible::destructible_part(tag, undefined, 20, undefined, undefined, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_state(tag + "_d", undefined, 60, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_fx("tag_glass_left_back_fx", "props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	tag = "tag_glass_right_back";
	common_scripts\_destructible::destructible_part(tag, undefined, 20, undefined, undefined, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_state(tag + "_d", undefined, 60, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_fx("tag_glass_right_back_fx", "props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
}

vehicle_bm21(destructibletype, param_991)
{
	common_scripts\_destructible::destructible_create(destructibletype, "tag_body", 300, undefined, 32, "no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_hood_fx", "smoke/car_damage_whitesmoke", 0.4);
	common_scripts\_destructible::destructible_state(undefined, undefined, 200, undefined, 32, "no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_hood_fx", "smoke/car_damage_blacksmoke", 0.4);
	common_scripts\_destructible::destructible_state(undefined, undefined, 100, undefined, 32, "no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_hood_fx", "smoke/car_damage_blacksmoke_fire", 0.4);
	common_scripts\_destructible::destructible_sound("fire_vehicle_flareup_med");
	common_scripts\_destructible::destructible_loopsound("fire_vehicle_med");
	common_scripts\_destructible::destructible_healthdrain(15, 0.25, 210, "allies");
	common_scripts\_destructible::destructible_state(undefined, undefined, 300, "player_only", 32, "no_melee");
	common_scripts\_destructible::destructible_loopsound("fire_vehicle_med");
	common_scripts\_destructible::destructible_state(undefined, undefined, 400, undefined, 32, "no_melee");
	common_scripts\_destructible::destructible_fx("tag_deathfx", "explosions/small_vehicle_explosion", 0);
	common_scripts\_destructible::destructible_sound("car_explode");
	common_scripts\_destructible::destructible_explode(4000, 5000, 210, 250, 50, 300, undefined, undefined, 0.3, 500);
	common_scripts\_destructible::destructible_anim(%anim_0020, 1, "setanimknob", undefined, undefined, "vehicle_80s_sedan1_destroy");
	common_scripts\_destructible::destructible_state(undefined, param_991, undefined, 32, "no_melee");
	common_scripts\_destructible::destructible_part("left_wheel_01_jnt", undefined, 20, undefined, undefined, "no_melee");
	common_scripts\_destructible::destructible_anim(%anim_0023, 1, "setanim");
	common_scripts\_destructible::destructible_sound("veh_tire_deflate", "bullet");
	common_scripts\_destructible::destructible_part("left_wheel_02_jnt", undefined, 20, undefined, undefined, "no_melee");
	common_scripts\_destructible::destructible_anim(%anim_0024, 1, "setanim");
	common_scripts\_destructible::destructible_sound("veh_tire_deflate", "bullet");
	common_scripts\_destructible::destructible_part("right_wheel_01_jnt", undefined, 20, undefined, undefined, "no_melee");
	common_scripts\_destructible::destructible_anim(%anim_0021, 1, "setanim");
	common_scripts\_destructible::destructible_sound("veh_tire_deflate", "bullet");
	common_scripts\_destructible::destructible_part("right_wheel_02_jnt", undefined, 20, undefined, undefined, "no_melee");
	common_scripts\_destructible::destructible_anim(%anim_0022, 1, "setanim");
	common_scripts\_destructible::destructible_sound("veh_tire_deflate", "bullet");
	tag = "tag_glass_front";
	common_scripts\_destructible::destructible_part(tag, undefined, 40, undefined, undefined, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_state(tag + "_d", undefined, 60, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_fx("tag_glass_front_fx", "props/car_glass_large");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	tag = "tag_glass_back";
	common_scripts\_destructible::destructible_part(tag, undefined, 40, undefined, undefined, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_state(tag + "_d", undefined, 60, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_fx("tag_glass_back_fx", "props/car_glass_large");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	tag = "tag_glass_left_front";
	common_scripts\_destructible::destructible_part(tag, undefined, 20, undefined, undefined, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_state(tag + "_d", undefined, 60, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_fx("tag_glass_left_front_fx", "props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	tag = "tag_glass_right_front";
	common_scripts\_destructible::destructible_part(tag, undefined, 20, undefined, undefined, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_state(tag + "_d", undefined, 60, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_fx("tag_glass_right_front_fx", "props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
}

vehicle_moving_truck(destructibletype)
{
	common_scripts\_destructible::destructible_create(destructibletype, "tag_body", 300, undefined, 32, "no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_hood_fx", "smoke/car_damage_whitesmoke", 0.4);
	common_scripts\_destructible::destructible_state(undefined, undefined, 200, undefined, 32, "no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_hood_fx", "smoke/car_damage_blacksmoke", 0.4);
	common_scripts\_destructible::destructible_state(undefined, undefined, 100, undefined, 32, "no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_hood_fx", "smoke/car_damage_blacksmoke_fire", 0.4);
	common_scripts\_destructible::destructible_sound("fire_vehicle_flareup_med");
	common_scripts\_destructible::destructible_loopsound("fire_vehicle_med");
	common_scripts\_destructible::destructible_healthdrain(15, 0.25, 210, "allies");
	common_scripts\_destructible::destructible_state(undefined, undefined, 300, "player_only", 32, "no_melee");
	common_scripts\_destructible::destructible_loopsound("fire_vehicle_med");
	common_scripts\_destructible::destructible_state(undefined, undefined, 400, undefined, 32, "no_melee");
	common_scripts\_destructible::destructible_fx("tag_death_fx", "explosions/vehicle_explosion_medium", 0);
	common_scripts\_destructible::destructible_sound("car_explode");
	common_scripts\_destructible::destructible_explode(4000, 5000, 210, 250, 50, 300, undefined, undefined, 0.3, 500);
	common_scripts\_destructible::destructible_anim(%anim_0020, 1, "setanimknob", undefined, undefined, "vehicle_80s_sedan1_destroy");
	common_scripts\_destructible::destructible_state(undefined, "vehicle_moving_truck_dst", undefined, 32, "no_melee");
	common_scripts\_destructible::destructible_part("left_wheel_01_jnt", undefined, 20, undefined, undefined, "no_melee");
	common_scripts\_destructible::destructible_anim(%anim_0023, 1, "setanim");
	common_scripts\_destructible::destructible_sound("veh_tire_deflate", "bullet");
	common_scripts\_destructible::destructible_part("left_wheel_02_jnt", undefined, 20, undefined, undefined, "no_melee");
	common_scripts\_destructible::destructible_anim(%anim_0024, 1, "setanim");
	common_scripts\_destructible::destructible_sound("veh_tire_deflate", "bullet");
	common_scripts\_destructible::destructible_part("right_wheel_01_jnt", undefined, 20, undefined, undefined, "no_melee");
	common_scripts\_destructible::destructible_anim(%anim_0021, 1, "setanim");
	common_scripts\_destructible::destructible_sound("veh_tire_deflate", "bullet");
	common_scripts\_destructible::destructible_part("right_wheel_02_jnt", undefined, 20, undefined, undefined, "no_melee");
	common_scripts\_destructible::destructible_anim(%anim_0022, 1, "setanim");
	common_scripts\_destructible::destructible_sound("veh_tire_deflate", "bullet");
	tag = "tag_glass_front";
	common_scripts\_destructible::destructible_part(tag, undefined, 40, undefined, undefined, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_state(tag + "_d", undefined, 60, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_fx("tag_glass_front_fx", "props/car_glass_large");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	tag = "tag_glass_left_front";
	common_scripts\_destructible::destructible_part(tag, undefined, 20, undefined, undefined, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_state(tag + "_d", undefined, 60, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_fx("tag_glass_left_front_fx", "props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	tag = "tag_glass_right_front";
	common_scripts\_destructible::destructible_part(tag, undefined, 20, undefined, undefined, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_state(tag + "_d", undefined, 60, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_fx("tag_glass_right_front_fx", "props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
}

vehicle_luxurysedan(color)
{
	common_scripts\_destructible::destructible_create("vehicle_luxurysedan_2008" + color, "tag_body", 250, undefined, 32, "no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_hood_fx", "smoke/car_damage_whitesmoke", 0.4);
	common_scripts\_destructible::destructible_car_alarm();
	common_scripts\_destructible::destructible_state(undefined, undefined, 200, undefined, 32, "no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_hood_fx", "smoke/car_damage_blacksmoke", 0.4);
	common_scripts\_destructible::destructible_state(undefined, undefined, 100, undefined, 32, "no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_hood_fx", "smoke/car_damage_blacksmoke_fire", 0.4);
	common_scripts\_destructible::destructible_sound("fire_vehicle_flareup_med");
	common_scripts\_destructible::destructible_loopsound("fire_vehicle_med");
	common_scripts\_destructible::destructible_healthdrain(15, 0.25, 210, "allies");
	common_scripts\_destructible::destructible_state(undefined, undefined, 300, "player_only", 32, "no_melee");
	common_scripts\_destructible::destructible_loopsound("fire_vehicle_med");
	common_scripts\_destructible::destructible_state(undefined, undefined, 400, undefined, 32, "no_melee");
	common_scripts\_destructible::destructible_fx("tag_death_fx", "explosions/small_vehicle_explosion", 0);
	common_scripts\_destructible::destructible_sound("car_explode");
	common_scripts\_destructible::destructible_explode(4000, 5000, 210, 250, 50, 300, undefined, undefined, 0.3, 500);
	common_scripts\_destructible::destructible_anim(%anim_0020, 1, "setanimknob", undefined, undefined, "vehicle_80s_sedan1_destroy");
	common_scripts\_destructible::destructible_state(undefined, "vehicle_luxurysedan_2008" + color + "_destroy", undefined, 32, "no_melee");
	tag = "tag_hood";
	common_scripts\_destructible::destructible_part(tag, "vehicle_luxurysedan_2008" + color + "_hood", 800, undefined, undefined, undefined, 1, 2.5);
	common_scripts\_destructible::destructible_part("left_wheel_01_jnt", "vehicle_luxurysedan_2008" + color + "_wheel_LF", 20, undefined, undefined, "no_melee", undefined, 1.7);
	common_scripts\_destructible::destructible_anim(%anim_0023, 1, "setanim");
	common_scripts\_destructible::destructible_sound("veh_tire_deflate", "bullet");
	common_scripts\_destructible::destructible_car_alarm();
	common_scripts\_destructible::destructible_part("left_wheel_02_jnt", "vehicle_luxurysedan_2008" + color + "_wheel_LF", 20, undefined, undefined, "no_melee", undefined, 1.7);
	common_scripts\_destructible::destructible_anim(%anim_0024, 1, "setanim");
	common_scripts\_destructible::destructible_sound("veh_tire_deflate", "bullet");
	common_scripts\_destructible::destructible_car_alarm();
	common_scripts\_destructible::destructible_part("right_wheel_01_jnt", "vehicle_luxurysedan_2008" + color + "_wheel_LF", 20, undefined, undefined, "no_melee", undefined, 1.7);
	common_scripts\_destructible::destructible_anim(%anim_0021, 1, "setanim");
	common_scripts\_destructible::destructible_sound("veh_tire_deflate", "bullet");
	common_scripts\_destructible::destructible_car_alarm();
	common_scripts\_destructible::destructible_part("right_wheel_02_jnt", "vehicle_luxurysedan_2008" + color + "_wheel_LF", 20, undefined, undefined, "no_melee", undefined, 1.7);
	common_scripts\_destructible::destructible_anim(%anim_0022, 1, "setanim");
	common_scripts\_destructible::destructible_sound("veh_tire_deflate", "bullet");
	common_scripts\_destructible::destructible_car_alarm();
	common_scripts\_destructible::destructible_part("tag_door_left_front", "vehicle_luxurysedan_2008" + color + "_door_LF", undefined, undefined, undefined, undefined, 1, 1);
	common_scripts\_destructible::destructible_part("tag_door_right_front", "vehicle_luxurysedan_2008" + color + "_door_RF", undefined, undefined, undefined, undefined, 1, 1);
	common_scripts\_destructible::destructible_part("tag_door_left_back", "vehicle_luxurysedan_2008" + color + "_door_LB", undefined, undefined, undefined, undefined, 1, 1);
	common_scripts\_destructible::destructible_part("tag_door_right_back", "vehicle_luxurysedan_2008" + color + "_door_RB", undefined, undefined, undefined, undefined, 1, 1);
	tag = "tag_glass_front";
	common_scripts\_destructible::destructible_part(tag, undefined, 40, undefined, undefined, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_state(tag + "_d", undefined, 60, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_fx("tag_glass_front_fx", "props/car_glass_large");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_car_alarm();
	common_scripts\_destructible::destructible_state(undefined);
	tag = "tag_glass_back";
	common_scripts\_destructible::destructible_part(tag, undefined, 40, undefined, undefined, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_state(tag + "_d", undefined, 60, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_fx("tag_glass_back_fx", "props/car_glass_large");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_car_alarm();
	common_scripts\_destructible::destructible_state(undefined);
	tag = "tag_glass_left_front";
	common_scripts\_destructible::destructible_part(tag, undefined, 20, undefined, undefined, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_state(tag + "_d", undefined, 60, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_fx("tag_glass_left_front_fx", "props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_car_alarm();
	common_scripts\_destructible::destructible_state(undefined);
	tag = "tag_glass_right_front";
	common_scripts\_destructible::destructible_part(tag, undefined, 20, undefined, undefined, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_state(tag + "_d", undefined, 60, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_fx("tag_glass_right_front_fx", "props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_car_alarm();
	common_scripts\_destructible::destructible_state(undefined);
	tag = "tag_glass_left_back";
	common_scripts\_destructible::destructible_part(tag, undefined, 20, undefined, undefined, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_state(tag + "_d", undefined, 60, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_fx("tag_glass_left_back_fx", "props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_car_alarm();
	common_scripts\_destructible::destructible_state(undefined);
	tag = "tag_glass_right_back";
	common_scripts\_destructible::destructible_part(tag, undefined, 20, undefined, undefined, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_state(tag + "_d", undefined, 60, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_fx("tag_glass_right_back_fx", "props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_car_alarm();
	common_scripts\_destructible::destructible_state(undefined);
	tag = "tag_light_left_front";
	common_scripts\_destructible::destructible_part(tag, undefined, 20, undefined, undefined, undefined, 0.5);
	common_scripts\_destructible::destructible_fx(tag, "props/car_glass_headlight");
	common_scripts\_destructible::destructible_sound("veh_glass_break_small");
	common_scripts\_destructible::destructible_state(tag + "_d");
	tag = "tag_light_right_front";
	common_scripts\_destructible::destructible_part(tag, undefined, 20, undefined, undefined, undefined, 0.5);
	common_scripts\_destructible::destructible_fx(tag, "props/car_glass_headlight");
	common_scripts\_destructible::destructible_sound("veh_glass_break_small");
	common_scripts\_destructible::destructible_state(tag + "_d");
	common_scripts\_destructible::destructible_part("tag_mirror_left", "vehicle_luxurysedan_2008" + color + "_mirror_L", 40, undefined, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_physics();
	common_scripts\_destructible::destructible_part("tag_mirror_right", "vehicle_luxurysedan_2008" + color + "_mirror_R", 40, undefined, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_physics();
}

vehicle_mig29_landed(destructibletype)
{
	common_scripts\_destructible::destructible_create(destructibletype, "TAG_ORIGIN", 250, undefined, 32, "splash");
	common_scripts\_destructible::destructible_splash_damage_scaler(11);
	common_scripts\_destructible::destructible_loopfx("TAG_front_fire", "smoke/car_damage_whitesmoke", 0.4);
	common_scripts\_destructible::destructible_loopfx("TAG_rear_fire", "smoke/car_damage_whitesmoke", 0.4);
	common_scripts\_destructible::destructible_state(undefined, undefined, 200, undefined, 32, "splash");
	common_scripts\_destructible::destructible_loopfx("TAG_front_fire", "smoke/car_damage_blacksmoke", 0.4);
	common_scripts\_destructible::destructible_loopfx("TAG_rear_fire", "smoke/car_damage_blacksmoke", 0.4);
	common_scripts\_destructible::destructible_state(undefined, undefined, 100, undefined, 32, "splash");
	common_scripts\_destructible::destructible_loopfx("TAG_front_fire", "smoke/airplane_damage_blacksmoke_fire", 0.4);
	common_scripts\_destructible::destructible_loopfx("TAG_rear_fire", "smoke/airplane_damage_blacksmoke_fire", 0.4);
	common_scripts\_destructible::destructible_sound("fire_vehicle_flareup_med");
	common_scripts\_destructible::destructible_loopsound("fire_vehicle_med");
	common_scripts\_destructible::destructible_healthdrain(15, 0.25, 512, "allies");
	common_scripts\_destructible::destructible_state(undefined, undefined, 300, "player_only", 32, "splash");
	common_scripts\_destructible::destructible_loopsound("fire_vehicle_med");
	common_scripts\_destructible::destructible_state(undefined, undefined, 400, undefined, 32, "splash");
	common_scripts\_destructible::destructible_fx("TAG_FX", "explosions/vehicle_explosion_mig29", 0);
	common_scripts\_destructible::destructible_sound("car_explode");
	common_scripts\_destructible::destructible_explode(8000, 10000, 512, 512, 50, 300, undefined, undefined, 0.4, 1000);
	common_scripts\_destructible::destructible_anim(%anim_001F, 1, "setanimknob", undefined, undefined, "vehicle_mig29_destroy");
	common_scripts\_destructible::destructible_state(undefined, "vehicle_mig29_v2_dest", undefined, 32, "splash");
	common_scripts\_destructible::destructible_part("TAG_COCKPIT", "vehicle_mig29_dest_cockpit", 40, undefined, undefined, undefined, undefined, 1);
}

vehicle_mack_truck_short(color)
{
	common_scripts\_destructible::destructible_create("vehicle_mack_truck_short_" + color, "tag_body", 250, undefined, 32, "no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_hood_fx", "smoke/car_damage_whitesmoke", 0.4);
	common_scripts\_destructible::destructible_state(undefined, undefined, 200, undefined, 32, "no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_hood_fx", "smoke/car_damage_blacksmoke", 0.4);
	common_scripts\_destructible::destructible_state(undefined, undefined, 100, undefined, 32, "no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_hood_fx", "smoke/mack_truck_damage_blacksmoke_fire", 0.4);
	common_scripts\_destructible::destructible_loopfx("tag_gastank", "smoke/motorcycle_damage_blacksmoke_fire", 0.4);
	common_scripts\_destructible::destructible_sound("mack_truck_flareup_med");
	common_scripts\_destructible::destructible_loopsound("mack_truck_fire_med");
	common_scripts\_destructible::destructible_healthdrain(15, 0.25, 300, "allies");
	common_scripts\_destructible::destructible_state(undefined, undefined, 300, "player_only", 32, "no_melee");
	common_scripts\_destructible::destructible_loopsound("mack_truck_fire_med");
	common_scripts\_destructible::destructible_state(undefined, undefined, 400, undefined, 32, "no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_gastank", "smoke/motorcycle_damage_blacksmoke_fire", 0.4);
	common_scripts\_destructible::destructible_fx("tag_cab_fire", "fire/firelp_med_pm");
	common_scripts\_destructible::destructible_fx("tag_death_fx", "explosions/propane_large_exp", 0);
	common_scripts\_destructible::destructible_sound("mack_truck_explode");
	common_scripts\_destructible::destructible_loopsound("fire_metal_large");
	common_scripts\_destructible::destructible_explode(8000, 10000, 512, 512, 100, 400, undefined, undefined, 0.4, 1000);
	common_scripts\_destructible::destructible_state(undefined, "vehicle_mack_truck_short_" + color + "_destroy", undefined, 32, "no_melee");
	common_scripts\_destructible::destructible_part("left_wheel_01_jnt", "vehicle_mack_truck_short_" + color + "_wheel_lf", 20, undefined, undefined, "no_melee", undefined, 8);
	common_scripts\_destructible::destructible_part("left_wheel_02_jnt", "vehicle_mack_truck_short_" + color + "_wheel_lf", 20, undefined, undefined, "no_melee", undefined, 81);
	common_scripts\_destructible::destructible_part("left_wheel_03_jnt", "vehicle_mack_truck_short_" + color + "_wheel_lf", 20, undefined, undefined, "no_melee", undefined, 8);
	common_scripts\_destructible::destructible_part("tag_door_left_front", "vehicle_mack_truck_short_" + color + "_door_lf", undefined, undefined, undefined, undefined, 1, 1);
	tag = "tag_glass_front";
	common_scripts\_destructible::destructible_part(tag, undefined, 40, undefined, undefined, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_state(tag + "_d", undefined, 60, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_fx("tag_glass_front_fx", "props/car_glass_large");
	common_scripts\_destructible::destructible_sound("mack_truck_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	tag = "tag_glass_back";
	common_scripts\_destructible::destructible_part(tag, undefined, 40, undefined, undefined, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_state(tag + "_d", undefined, 60, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_fx("tag_glass_back_fx", "props/car_glass_large");
	common_scripts\_destructible::destructible_sound("mack_truck_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	tag = "tag_glass_left_front";
	common_scripts\_destructible::destructible_part(tag, undefined, 20, undefined, undefined, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_state(tag + "_d", undefined, 60, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_fx("tag_glass_left_front_fx", "props/car_glass_med");
	common_scripts\_destructible::destructible_sound("mack_truck_glass_break_small");
	common_scripts\_destructible::destructible_state(undefined);
	tag = "tag_glass_right_front";
	common_scripts\_destructible::destructible_part(tag, undefined, 20, undefined, undefined, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_state(tag + "_d", undefined, 60, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_fx("tag_glass_right_front_fx", "props/car_glass_med");
	common_scripts\_destructible::destructible_sound("mack_truck_glass_break_small");
	common_scripts\_destructible::destructible_state(undefined);
}

vehicle_motorcycle(param_992)
{
	explode_anim = undefined;
	explode_anim = get_precached_anim("vehicle_motorcycle_destroy_" + param_992);
	common_scripts\_destructible::destructible_create("vehicle_motorcycle_" + param_992, "body_animate_jnt", 250, undefined, 32, "no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_death_fx", "smoke/car_damage_whitesmoke", 0.4);
	common_scripts\_destructible::destructible_state(undefined, undefined, 200, undefined, 32, "no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_death_fx", "smoke/car_damage_blacksmoke", 0.4);
	common_scripts\_destructible::destructible_state(undefined, undefined, 100, undefined, 32, "no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_death_fx", "smoke/motorcycle_damage_blacksmoke_fire", 0.4);
	common_scripts\_destructible::destructible_sound("fire_vehicle_flareup_med");
	common_scripts\_destructible::destructible_loopsound("fire_vehicle_med");
	common_scripts\_destructible::destructible_healthdrain(15, 0.25, 128, "allies");
	common_scripts\_destructible::destructible_state(undefined, undefined, 300, "player_only", 32, "no_melee");
	common_scripts\_destructible::destructible_loopsound("fire_vehicle_med");
	common_scripts\_destructible::destructible_state(undefined, undefined, 400, undefined, 32, "no_melee");
	common_scripts\_destructible::destructible_fx("tag_death_fx", "explosions/small_vehicle_explosion", 0);
	common_scripts\_destructible::destructible_sound("car_explode");
	common_scripts\_destructible::destructible_explode(3000, 4000, 128, 150, 50, 300);
	common_scripts\_destructible::destructible_anim(explode_anim, 1, "setanimknob", undefined, undefined, "vehicle_motorcycle_destroy_" + param_992);
	common_scripts\_destructible::destructible_state(undefined, "vehicle_motorcycle_" + param_992 + "_destroy", undefined, 32, "no_melee");
	common_scripts\_destructible::destructible_part("front_wheel", "vehicle_motorcycle_01_front_wheel_d", 20, undefined, undefined, "no_melee", undefined, 1.7);
	common_scripts\_destructible::destructible_part("rear_wheel", "vehicle_motorcycle_01_rear_wheel_d", 20, undefined, undefined, "no_melee", undefined, 1.7);
}

vehicle_subcompact(color)
{
	common_scripts\_destructible::destructible_create("vehicle_subcompact_" + color, "tag_body", 250, undefined, 32, "no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_hood_fx", "smoke/car_damage_whitesmoke", 0.4);
	common_scripts\_destructible::destructible_state(undefined, undefined, 200, undefined, 32, "no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_hood_fx", "smoke/car_damage_blacksmoke", 0.4);
	common_scripts\_destructible::destructible_state(undefined, undefined, 100, undefined, 32, "no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_hood_fx", "smoke/car_damage_blacksmoke_fire", 0.4);
	common_scripts\_destructible::destructible_sound("fire_vehicle_flareup_med");
	common_scripts\_destructible::destructible_loopsound("fire_vehicle_med");
	common_scripts\_destructible::destructible_healthdrain(12, 0.2, 150, "allies");
	common_scripts\_destructible::destructible_state(undefined, undefined, 300, "player_only", 32, "no_melee");
	common_scripts\_destructible::destructible_loopsound("fire_vehicle_med");
	common_scripts\_destructible::destructible_state(undefined, undefined, 400, undefined, 32, "no_melee");
	common_scripts\_destructible::destructible_fx("tag_death_fx", "explosions/small_vehicle_explosion", 0);
	common_scripts\_destructible::destructible_sound("car_explode");
	common_scripts\_destructible::destructible_explode(4000, 5000, 150, 250, 50, 300, undefined, 0, 0.3, 500);
	common_scripts\_destructible::destructible_anim(%anim_0020, 1, "setanimknob", undefined, undefined, "vehicle_80s_sedan1_destroy");
	common_scripts\_destructible::destructible_state(undefined, "vehicle_subcompact_" + color + "_destroyed", undefined, 32, "no_melee");
	common_scripts\_destructible::destructible_part("left_wheel_01_jnt", undefined, 20, undefined, undefined, "no_melee");
	common_scripts\_destructible::destructible_anim(%anim_0023, 1, "setanim");
	common_scripts\_destructible::destructible_sound("veh_tire_deflate", "bullet");
	common_scripts\_destructible::destructible_part("right_wheel_01_jnt", undefined, 20, undefined, undefined, "no_melee");
	common_scripts\_destructible::destructible_anim(%anim_0021, 1, "setanim");
	common_scripts\_destructible::destructible_sound("veh_tire_deflate", "bullet");
	common_scripts\_destructible::destructible_part("left_wheel_02_jnt", "vehicle_subcompact_wheel_lf", 20, undefined, undefined, "no_melee", undefined, 1.7);
	common_scripts\_destructible::destructible_anim(%anim_0024, 1, "setanim");
	common_scripts\_destructible::destructible_sound("veh_tire_deflate", "bullet");
	common_scripts\_destructible::destructible_part("right_wheel_02_jnt", "vehicle_subcompact_wheel_lf", 20, undefined, undefined, "no_melee", undefined, 2.3);
	common_scripts\_destructible::destructible_anim(%anim_0022, 1, "setanim");
	common_scripts\_destructible::destructible_sound("veh_tire_deflate", "bullet");
	common_scripts\_destructible::destructible_part("tag_door_left_back", "vehicle_subcompact_" + color + "_door_LB", undefined, undefined, undefined, undefined, 1, 1);
	common_scripts\_destructible::destructible_part("tag_door_right_back", "vehicle_subcompact_" + color + "_door_RB", undefined, undefined, undefined, undefined, 1, 1);
	tag = "tag_glass_front";
	common_scripts\_destructible::destructible_part(tag, undefined, 40, undefined, undefined, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_state(tag + "_d", undefined, 60, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_fx("tag_glass_front_fx", "props/car_glass_large");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	tag = "tag_glass_back";
	common_scripts\_destructible::destructible_part(tag, undefined, 40, undefined, undefined, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_state(tag + "_d", undefined, 60, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_fx("tag_glass_back_fx", "props/car_glass_large");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	tag = "tag_glass_left_front";
	common_scripts\_destructible::destructible_part(tag, undefined, 20, undefined, undefined, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_state(tag + "_d", undefined, 60, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_fx("tag_glass_left_front_fx", "props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	tag = "tag_glass_right_front";
	common_scripts\_destructible::destructible_part(tag, undefined, 20, undefined, undefined, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_state(tag + "_d", undefined, 60, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_fx("tag_glass_right_front_fx", "props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	tag = "tag_glass_left_back";
	common_scripts\_destructible::destructible_part(tag, undefined, 20, undefined, undefined, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_state(tag + "_d", undefined, 60, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_fx("tag_glass_left_back_fx", "props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	tag = "tag_glass_right_back";
	common_scripts\_destructible::destructible_part(tag, undefined, 20, undefined, undefined, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_state(tag + "_d", undefined, 60, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_fx("tag_glass_right_back_fx", "props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	tag = "tag_light_left_front";
	common_scripts\_destructible::destructible_part(tag, undefined, 20, undefined, undefined, undefined, 0.5);
	common_scripts\_destructible::destructible_fx(tag, "props/car_glass_headlight");
	common_scripts\_destructible::destructible_sound("veh_glass_break_small");
	common_scripts\_destructible::destructible_state(tag + "_d");
	tag = "tag_light_right_front";
	common_scripts\_destructible::destructible_part(tag, undefined, 20, undefined, undefined, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_state(tag + "_d", undefined, 60, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_fx(tag, "props/car_glass_headlight");
	common_scripts\_destructible::destructible_sound("veh_glass_break_small");
	common_scripts\_destructible::destructible_state(tag + "_d");
	common_scripts\_destructible::destructible_part("tag_mirror_left", "vehicle_subcompact_" + color + "_mirror_L", 40, undefined, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_physics();
	common_scripts\_destructible::destructible_part("tag_mirror_right", "vehicle_subcompact_" + color + "_mirror_R", 40, undefined, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_physics();
}

vehicle_van(color)
{
	common_scripts\_destructible::destructible_create("vehicle_van_" + color, "tag_body", 250, undefined, 32, "no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_hood_fx", "smoke/car_damage_whitesmoke", 0.4);
	common_scripts\_destructible::destructible_state(undefined, undefined, 200, undefined, 32, "no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_hood_fx", "smoke/car_damage_blacksmoke", 0.4);
	common_scripts\_destructible::destructible_state(undefined, undefined, 100, undefined, 32, "no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_hood_fx", "smoke/car_damage_blacksmoke_fire", 0.4);
	common_scripts\_destructible::destructible_sound("fire_vehicle_flareup_med");
	common_scripts\_destructible::destructible_loopsound("fire_vehicle_med");
	common_scripts\_destructible::destructible_healthdrain(12, 0.2, 210, "allies");
	common_scripts\_destructible::destructible_state(undefined, undefined, 300, "player_only", 32, "no_melee");
	common_scripts\_destructible::destructible_loopsound("fire_vehicle_med");
	common_scripts\_destructible::destructible_state(undefined, undefined, 400, undefined, 32, "no_melee");
	common_scripts\_destructible::destructible_fx("tag_death_fx", "explosions/small_vehicle_explosion", 0);
	common_scripts\_destructible::destructible_sound("car_explode");
	common_scripts\_destructible::destructible_explode(4000, 5000, 200, 250, 50, 300, undefined, undefined, 0.3, 500);
	common_scripts\_destructible::destructible_anim(%anim_0020, 1, "setanimknob", undefined, undefined, "vehicle_80s_sedan1_destroy");
	common_scripts\_destructible::destructible_state(undefined, "vehicle_van_" + color + "_destroyed", undefined, 32, "no_melee");
	tag = "tag_hood";
	common_scripts\_destructible::destructible_part(tag, "vehicle_van_" + color + "_hood", undefined, undefined, undefined, undefined, 1, 2.5);
	common_scripts\_destructible::destructible_part("left_wheel_01_jnt", "vehicle_van_wheel_lf", 20, undefined, undefined, "no_melee", undefined, 2.3);
	common_scripts\_destructible::destructible_anim(%anim_0023, 1, "setanim");
	common_scripts\_destructible::destructible_sound("veh_tire_deflate", "bullet");
	common_scripts\_destructible::destructible_part("right_wheel_01_jnt", "vehicle_van_wheel_lf", 20, undefined, undefined, "no_melee", undefined, 2.3);
	common_scripts\_destructible::destructible_anim(%anim_0021, 1, "setanim");
	common_scripts\_destructible::destructible_sound("veh_tire_deflate", "bullet");
	common_scripts\_destructible::destructible_part("left_wheel_02_jnt", undefined, 20, undefined, undefined, "no_melee");
	common_scripts\_destructible::destructible_anim(%anim_0024, 1, "setanim");
	common_scripts\_destructible::destructible_sound("veh_tire_deflate", "bullet");
	common_scripts\_destructible::destructible_part("right_wheel_02_jnt", undefined, 20, undefined, undefined, "no_melee");
	common_scripts\_destructible::destructible_anim(%anim_0022, 1, "setanim");
	common_scripts\_destructible::destructible_sound("veh_tire_deflate", "bullet");
	common_scripts\_destructible::destructible_part("tag_door_right_back", "vehicle_van_" + color + "_door_RB", undefined, undefined, undefined, undefined, 1, 1);
	tag = "tag_glass_front";
	common_scripts\_destructible::destructible_part(tag, undefined, 40, undefined, undefined, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_state(tag + "_d", undefined, 60, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_fx(tag + "_fx", "props/car_glass_large");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	tag = "tag_glass_back";
	common_scripts\_destructible::destructible_part(tag, undefined, 40, undefined, undefined, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_state(tag + "_d", undefined, 60, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_fx(tag + "_fx", "props/car_glass_large");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	tag = "tag_glass_left_front";
	common_scripts\_destructible::destructible_part(tag, undefined, 20, undefined, undefined, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_state(tag + "_d", undefined, 60, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_fx(tag + "_fx", "props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	tag = "tag_glass_right_front";
	common_scripts\_destructible::destructible_part(tag, undefined, 20, undefined, undefined, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_state(tag + "_d", undefined, 60, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_fx(tag + "_fx", "props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	tag = "tag_glass_left_back";
	common_scripts\_destructible::destructible_part(tag, undefined, 20, undefined, undefined, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_state(tag + "_d", undefined, 60, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_fx(tag + "_fx", "props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	tag = "tag_glass_right_back";
	common_scripts\_destructible::destructible_part(tag, undefined, 20, undefined, undefined, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_state(tag + "_d", undefined, 60, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_fx(tag + "_fx", "props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	tag = "tag_glass_left_back_02";
	common_scripts\_destructible::destructible_part(tag, undefined, 20, undefined, undefined, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_state(tag + "_d", undefined, 60, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_fx("tag_glass_left_back_02_fx", "props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	tag = "tag_glass_right_back_02";
	common_scripts\_destructible::destructible_part(tag, undefined, 20, undefined, undefined, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_state(tag + "_d", undefined, 60, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_fx("tag_glass_right_back_02_fx", "props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	tag = "tag_light_left_front";
	common_scripts\_destructible::destructible_part(tag, undefined, 20, undefined, undefined, undefined, 0.5);
	common_scripts\_destructible::destructible_fx(tag, "props/car_glass_headlight");
	common_scripts\_destructible::destructible_sound("veh_glass_break_small");
	common_scripts\_destructible::destructible_state(tag + "_d");
	tag = "tag_light_right_front";
	common_scripts\_destructible::destructible_part(tag, undefined, 20, undefined, undefined, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_state(tag + "_d", undefined, 60, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_fx(tag, "props/car_glass_headlight");
	common_scripts\_destructible::destructible_sound("veh_glass_break_small");
	common_scripts\_destructible::destructible_state(tag + "_d");
	common_scripts\_destructible::destructible_part("tag_mirror_left", "vehicle_van_" + color + "_mirror_L", 40, undefined, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_physics();
	common_scripts\_destructible::destructible_part("tag_mirror_right", "vehicle_van_" + color + "_mirror_R", 40, undefined, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_physics();
}

vehicle_suburban(destructibletype, color)
{
	common_scripts\_destructible::destructible_create(destructibletype, "tag_body", 250, undefined, 32, "no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_hood_fx", "smoke/car_damage_whitesmoke", 0.4);
	common_scripts\_destructible::destructible_car_alarm();
	common_scripts\_destructible::destructible_state(undefined, undefined, 200, undefined, 32, "no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_hood_fx", "smoke/car_damage_blacksmoke", 0.4);
	common_scripts\_destructible::destructible_state(undefined, undefined, 100, undefined, 32, "no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_hood_fx", "smoke/car_damage_blacksmoke_fire", 0.4);
	common_scripts\_destructible::destructible_sound("fire_vehicle_flareup_med");
	common_scripts\_destructible::destructible_loopsound("fire_vehicle_med");
	common_scripts\_destructible::destructible_healthdrain(12, 0.2, 210, "allies");
	common_scripts\_destructible::destructible_state(undefined, undefined, 300, "player_only", 32, "no_melee");
	common_scripts\_destructible::destructible_loopsound("fire_vehicle_med");
	common_scripts\_destructible::destructible_state(undefined, undefined, 400, undefined, 32, "no_melee");
	common_scripts\_destructible::destructible_fx("tag_death_fx", "explosions/small_vehicle_explosion", 0);
	common_scripts\_destructible::destructible_sound("car_explode");
	common_scripts\_destructible::destructible_explode(4000, 5000, 300, 300, 50, 300, undefined, undefined, 0.3, 500);
	common_scripts\_destructible::destructible_anim(%anim_0020, 1, "setanimknob", undefined, undefined, "vehicle_80s_sedan1_destroy");
	common_scripts\_destructible::destructible_state(undefined, "vehicle_suburban_destroyed" + color, undefined, 32, "no_melee");
	common_scripts\_destructible::destructible_part("left_wheel_01_jnt", undefined, 20, undefined, undefined, "no_melee");
	common_scripts\_destructible::destructible_anim(%anim_0023, 1, "setanim");
	common_scripts\_destructible::destructible_sound("veh_tire_deflate", "bullet");
	common_scripts\_destructible::destructible_car_alarm();
	common_scripts\_destructible::destructible_part("right_wheel_01_jnt", "vehicle_suburban_wheel_rf", 20, undefined, undefined, "no_melee", undefined, 2.3);
	common_scripts\_destructible::destructible_anim(%anim_0021, 1, "setanim");
	common_scripts\_destructible::destructible_sound("veh_tire_deflate", "bullet");
	common_scripts\_destructible::destructible_car_alarm();
	common_scripts\_destructible::destructible_part("left_wheel_02_jnt", "vehicle_suburban_wheel_rf", 20, undefined, undefined, "no_melee", undefined, 2.3);
	common_scripts\_destructible::destructible_anim(%anim_0024, 1, "setanim");
	common_scripts\_destructible::destructible_sound("veh_tire_deflate", "bullet");
	common_scripts\_destructible::destructible_car_alarm();
	common_scripts\_destructible::destructible_part("right_wheel_02_jnt", undefined, 20, undefined, undefined, "no_melee");
	common_scripts\_destructible::destructible_anim(%anim_0022, 1, "setanim");
	common_scripts\_destructible::destructible_sound("veh_tire_deflate", "bullet");
	common_scripts\_destructible::destructible_car_alarm();
	common_scripts\_destructible::destructible_part("tag_door_left_back", "vehicle_suburban_door_lb" + color, undefined, undefined, undefined, undefined, 1, 1);
	tag = "tag_glass_front";
	common_scripts\_destructible::destructible_part(tag, undefined, 40, undefined, undefined, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_state(tag + "_d", undefined, 60, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_fx(tag + "_fx", "props/car_glass_large");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_car_alarm();
	common_scripts\_destructible::destructible_state(undefined);
	tag = "tag_glass_back";
	common_scripts\_destructible::destructible_part(tag, undefined, 40, undefined, undefined, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_state(tag + "_d", undefined, 60, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_fx(tag + "_fx", "props/car_glass_large");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_car_alarm();
	common_scripts\_destructible::destructible_state(undefined);
	tag = "tag_center_glass";
	common_scripts\_destructible::destructible_part(tag, undefined, 40, undefined, undefined, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_state(tag + "_d", undefined, 60, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_fx(tag + "_fx", "props/car_glass_large");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_car_alarm();
	common_scripts\_destructible::destructible_state(undefined);
	tag = "tag_glass_left_front";
	common_scripts\_destructible::destructible_part(tag, undefined, 20, undefined, undefined, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_state(tag + "_d", undefined, 60, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_fx(tag + "_fx", "props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_car_alarm();
	common_scripts\_destructible::destructible_state(undefined);
	tag = "tag_glass_right_front";
	common_scripts\_destructible::destructible_part(tag, undefined, 20, undefined, undefined, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_state(tag + "_d", undefined, 60, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_fx(tag + "_fx", "props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_car_alarm();
	common_scripts\_destructible::destructible_state(undefined);
	tag = "tag_glass_left_back";
	common_scripts\_destructible::destructible_part(tag, undefined, 20, undefined, undefined, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_state(tag + "_d", undefined, 60, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_fx(tag + "_fx", "props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_car_alarm();
	common_scripts\_destructible::destructible_state(undefined);
	tag = "tag_glass_right_back";
	common_scripts\_destructible::destructible_part(tag, undefined, 20, undefined, undefined, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_state(tag + "_d", undefined, 60, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_fx(tag + "_fx", "props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_car_alarm();
	common_scripts\_destructible::destructible_state(undefined);
	tag = "tag_glass_left_back_02";
	common_scripts\_destructible::destructible_part(tag, undefined, 20, undefined, undefined, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_state(tag + "_d", undefined, 60, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_fx("tag_glass_left_back_02_fx", "props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_car_alarm();
	common_scripts\_destructible::destructible_state(undefined);
	tag = "tag_glass_right_back_02";
	common_scripts\_destructible::destructible_part(tag, undefined, 20, undefined, undefined, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_state(tag + "_d", undefined, 60, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_fx("tag_glass_right_back_02_fx", "props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_car_alarm();
	common_scripts\_destructible::destructible_state(undefined);
	tag = "tag_light_left_front";
	common_scripts\_destructible::destructible_part(tag, undefined, 20, undefined, undefined, undefined, 0.5);
	common_scripts\_destructible::destructible_fx(tag, "props/car_glass_headlight");
	common_scripts\_destructible::destructible_sound("veh_glass_break_small");
	common_scripts\_destructible::destructible_car_alarm();
	common_scripts\_destructible::destructible_state(tag + "_d");
	tag = "tag_light_right_front";
	common_scripts\_destructible::destructible_part(tag, undefined, 20, undefined, undefined, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_state(tag + "_d", undefined, 60, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_fx(tag, "props/car_glass_headlight");
	common_scripts\_destructible::destructible_sound("veh_glass_break_small");
	common_scripts\_destructible::destructible_car_alarm();
	common_scripts\_destructible::destructible_state(tag + "_d");
}

vehicle_snowmobile(destructibletype)
{
	common_scripts\_destructible::destructible_create(destructibletype, "tag_body", 250, undefined, 32, "no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_hood_fx", "smoke/car_damage_whitesmoke", 0.4);
	common_scripts\_destructible::destructible_state(undefined, undefined, 200, undefined, 32, "no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_hood_fx", "smoke/car_damage_blacksmoke", 0.4);
	common_scripts\_destructible::destructible_state(undefined, undefined, 100, undefined, 32, "no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_hood_fx", "smoke/snowmobile_damage_blacksmoke_fire", 0.4);
	common_scripts\_destructible::destructible_sound("fire_vehicle_flareup_med");
	common_scripts\_destructible::destructible_loopsound("fire_vehicle_med");
	common_scripts\_destructible::destructible_healthdrain(15, 0.25, 150, "allies");
	common_scripts\_destructible::destructible_state(undefined, undefined, 300, "player_only", 32, "no_melee");
	common_scripts\_destructible::destructible_loopsound("fire_vehicle_med");
	common_scripts\_destructible::destructible_state(undefined, undefined, 400, undefined, 32, "no_melee");
	common_scripts\_destructible::destructible_fx("tag_death_fx", "explosions/small_vehicle_explosion", 0);
	common_scripts\_destructible::destructible_sound("car_explode");
	common_scripts\_destructible::destructible_explode(4000, 5000, 150, 150, 50, 300, undefined, undefined, 0.3, 500);
	common_scripts\_destructible::destructible_anim(get_precached_anim("vehicle_snowmobile_destroy_01"), 1, "setanimknob", undefined, undefined, "vehicle_snowmobile_destroy_01");
	common_scripts\_destructible::destructible_state(undefined, "vehicle_snowmobile_destroyed", undefined, 32, "no_melee");
	tag = "right_wheel_01_jnt";
	common_scripts\_destructible::destructible_part(tag, "vehicle_snowmobile_ski_right", 800, undefined, undefined, undefined, 1, 2.5);
	common_scripts\_destructible::destructible_part("TAG_BAG_CENTER", "vehicle_snowmobile_bag_center", undefined, undefined, undefined, undefined, 1, 2);
	common_scripts\_destructible::destructible_part("TAG_BAG_LEFT", "vehicle_snowmobile_bag_left", undefined, undefined, undefined, undefined, 1, 2);
	common_scripts\_destructible::destructible_part("TAG_BAG_RIGHT", "vehicle_snowmobile_bag_right", undefined, undefined, undefined, undefined, 1, 2);
	tag = "tag_glass_front";
	common_scripts\_destructible::destructible_part(tag, undefined, 40, undefined, undefined, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_state(tag + "_d", undefined, 60, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_fx("tag_glass_front_fx", "props/car_glass_large");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
}

destructible_gaspump(destructibletype)
{
	common_scripts\_destructible::destructible_create(destructibletype, "tag_origin", 150, undefined, 32, "no_melee");
	common_scripts\_destructible::destructible_splash_damage_scaler(15);
	common_scripts\_destructible::destructible_loopfx("tag_death_fx", "smoke/car_damage_whitesmoke", 0.4);
	common_scripts\_destructible::destructible_state(undefined, undefined, 150, undefined, 32, "no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_death_fx", "smoke/car_damage_blacksmoke", 0.4);
	common_scripts\_destructible::destructible_state(undefined, undefined, 250, undefined, 32, "no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_death_fx", "fire/gas_pump_fire_damage", 0.4);
	common_scripts\_destructible::destructible_sound("gaspump01_flareup_med");
	common_scripts\_destructible::destructible_loopsound("gaspump01_fire_med");
	common_scripts\_destructible::destructible_healthdrain(12, 0.2, 210, "allies");
	common_scripts\_destructible::destructible_state(undefined, undefined, 300, undefined, 32, "no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_death_fx", "fire/gas_pump_fire_damage", 0.4);
	common_scripts\_destructible::destructible_loopsound("gaspump01_fire_med");
	common_scripts\_destructible::destructible_healthdrain(12, 0.2, 210, "allies");
	common_scripts\_destructible::destructible_sound("gaspump01_flareup_med");
	common_scripts\_destructible::destructible_loopfx("tag_fx", "fire/gas_pump_fire_handle", 0.05);
	common_scripts\_destructible::destructible_anim(%anim_0017, 1, "setanimknob", undefined, undefined, "gaspump01_hose");
	common_scripts\_destructible::destructible_state(undefined, undefined, 400, undefined, 5, "no_melee");
	common_scripts\_destructible::destructible_fx("tag_death_fx", "explosions/gas_pump_exp", 0);
	common_scripts\_destructible::destructible_sound("gaspump01_explode");
	common_scripts\_destructible::destructible_explode(6000, 8000, 210, 300, 50, 300, undefined, undefined, 0.3, 500);
	common_scripts\_destructible::destructible_state(undefined, "furniture_gaspump01_destroyed", undefined, undefined, "no_melee");
	common_scripts\_destructible::destructible_part("tag_panel_front01", "furniture_gaspump01_panel01", 80, undefined, undefined, undefined, 1, 1, undefined, 1);
	common_scripts\_destructible::destructible_physics();
	common_scripts\_destructible::destructible_part("tag_panel_front02", "furniture_gaspump01_panel02", 40, undefined, undefined, undefined, 1, 1);
	common_scripts\_destructible::destructible_physics();
	common_scripts\_destructible::destructible_part("tag_panel_front03", "furniture_gaspump01_panel03", 40, undefined, undefined, undefined, 1, 1);
	common_scripts\_destructible::destructible_sound("exp_gaspump_sparks");
	common_scripts\_destructible::destructible_fx("tag_panel_front03", "props/electricbox4_explode");
	common_scripts\_destructible::destructible_physics();
	common_scripts\_destructible::destructible_part("tag_panel_back01", "furniture_gaspump01_panel01", 110, undefined, undefined, undefined, 1, 1, undefined, 1);
	common_scripts\_destructible::destructible_physics();
	common_scripts\_destructible::destructible_part("tag_panel_back02", "furniture_gaspump01_panel02", 40, undefined, undefined, undefined, 1, 1);
	common_scripts\_destructible::destructible_physics();
	common_scripts\_destructible::destructible_part("tag_panel_back03", "furniture_gaspump01_panel03", 40, undefined, undefined, undefined, 1, 1);
	common_scripts\_destructible::destructible_sound("exp_gaspump_sparks");
	common_scripts\_destructible::destructible_fx("tag_panel_back03", "props/electricbox4_explode");
	common_scripts\_destructible::destructible_physics();
}

destructible_electrical_transformer_large(destructibletype)
{
	common_scripts\_destructible::destructible_create(destructibletype, "tag_origin", 1500, undefined, 32, "no_melee");
	common_scripts\_destructible::destructible_splash_damage_scaler(2);
	common_scripts\_destructible::destructible_loopsound("electrical_transformer_sparks");
	common_scripts\_destructible::destructible_loopfx("tag_fx", "explosions/electrical_transformer_spark_runner", 0.8);
	common_scripts\_destructible::destructible_healthdrain(12, 0.2, 210, "allies");
	common_scripts\_destructible::destructible_state(undefined, undefined, 500, undefined, 32, "no_melee");
	common_scripts\_destructible::destructible_loopsound("electrical_transformer_sparks");
	common_scripts\_destructible::destructible_fx("tag_fx_junction", "explosions/generator_sparks_c", 0);
	common_scripts\_destructible::destructible_loopfx("tag_fx_junction", "fire/electrical_transformer_blacksmoke_fire", 0.4);
	common_scripts\_destructible::destructible_loopfx("tag_fx", "explosions/electrical_transformer_spark_runner", 0.8);
	common_scripts\_destructible::destructible_healthdrain(12, 0.2, 210, "allies");
	common_scripts\_destructible::destructible_state(undefined, undefined, 300, undefined, 32, "no_melee");
	common_scripts\_destructible::destructible_loopsound("electrical_transformer_sparks");
	common_scripts\_destructible::destructible_loopfx("tag_fx_junction", "fire/electrical_transformer_blacksmoke_fire", 0.4);
	common_scripts\_destructible::destructible_loopfx("tag_fx", "explosions/electrical_transformer_spark_runner", 0.8);
	common_scripts\_destructible::destructible_loopfx("tag_fx_valve", "explosions/generator_spark_runner", 0.6);
	common_scripts\_destructible::destructible_healthdrain(12, 0.2, 210, "allies");
	common_scripts\_destructible::destructible_state(undefined, undefined, 500, undefined, 32, "no_melee");
	common_scripts\_destructible::destructible_fx("tag_death_fx", "explosions/electrical_transformer_explosion", 0);
	common_scripts\_destructible::destructible_sound("electrical_transformer01_explode");
	common_scripts\_destructible::destructible_explode(6000, 8000, 210, 300, 20, 300, undefined, undefined, 0.3, 500);
	common_scripts\_destructible::destructible_state(undefined, "com_electrical_transformer_large_des", undefined, undefined, "no_melee");
	common_scripts\_destructible::destructible_part("tag_door1", "com_electrical_transformer_large_dam_door1", 1500, undefined, undefined, undefined, 0, 1, undefined, 1);
	common_scripts\_destructible::destructible_sound("electrical_transformer01_explode_detail");
	common_scripts\_destructible::destructible_fx("tag_door1", "explosions/generator_explosion");
	common_scripts\_destructible::destructible_physics();
	common_scripts\_destructible::destructible_part("tag_door2", "com_electrical_transformer_large_dam_door2", 150, undefined, undefined, undefined, 0, 1, undefined, 1);
	common_scripts\_destructible::destructible_physics();
	common_scripts\_destructible::destructible_part("tag_door3", "com_electrical_transformer_large_dam_door3", 150, undefined, undefined, undefined, 0, 1, undefined, 1);
	common_scripts\_destructible::destructible_physics();
	common_scripts\_destructible::destructible_part("tag_door4", "com_electrical_transformer_large_dam_door4", 150, undefined, undefined, undefined, 0, 1, undefined, 1);
	common_scripts\_destructible::destructible_physics();
	common_scripts\_destructible::destructible_part("tag_door5", "com_electrical_transformer_large_dam_door5", 1500, undefined, undefined, undefined, 0, 1, undefined, 1);
	common_scripts\_destructible::destructible_sound("electrical_transformer01_explode_detail");
	common_scripts\_destructible::destructible_fx("tag_door5", "explosions/generator_explosion");
	common_scripts\_destructible::destructible_physics();
	common_scripts\_destructible::destructible_part("tag_door6", "com_electrical_transformer_large_dam_door6", 150, undefined, undefined, undefined, 0, 1, undefined, 1);
	common_scripts\_destructible::destructible_physics();
	common_scripts\_destructible::destructible_part("tag_door7", "com_electrical_transformer_large_dam_door7", 150, undefined, undefined, undefined, 0, 1, undefined, 1);
	common_scripts\_destructible::destructible_loopsound("electrical_transformer_sparks");
	common_scripts\_destructible::destructible_fx("tag_door7", "props/electricbox4_explode");
	common_scripts\_destructible::destructible_physics();
}

get_precached_anim(animname)
{
	return level._destructible_preanims[animname];
}

vehicle_coupe(color)
{
	common_scripts\_destructible::destructible_create("vehicle_coupe_" + color, "tag_body", 250, undefined, 32, "no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_hood_fx", "smoke/car_damage_whitesmoke", 0.4);
	common_scripts\_destructible::destructible_state(undefined, undefined, 200, undefined, 32, "no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_hood_fx", "smoke/car_damage_blacksmoke", 0.4);
	common_scripts\_destructible::destructible_state(undefined, undefined, 100, undefined, 32, "no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_hood_fx", "smoke/car_damage_blacksmoke_fire", 0.4);
	common_scripts\_destructible::destructible_sound("fire_vehicle_flareup_med");
	common_scripts\_destructible::destructible_loopsound("fire_vehicle_med");
	common_scripts\_destructible::destructible_healthdrain(12, 0.2, 150, "allies");
	common_scripts\_destructible::destructible_state(undefined, undefined, 300, "player_only", 32, "no_melee");
	common_scripts\_destructible::destructible_loopsound("fire_vehicle_med");
	common_scripts\_destructible::destructible_state(undefined, undefined, 400, undefined, 32, "no_melee");
	common_scripts\_destructible::destructible_fx("tag_death_fx", "explosions/small_vehicle_explosion", 0);
	common_scripts\_destructible::destructible_sound("car_explode");
	common_scripts\_destructible::destructible_explode(4000, 5000, 150, 250, 50, 300, undefined, undefined, 0.3, 500);
	common_scripts\_destructible::destructible_anim(%anim_0001, 2, "setanimknob", undefined, undefined, "vehicle_80s_sedan1_destroy");
	common_scripts\_destructible::destructible_state(undefined, "vehicle_coupe_" + color + "_destroyed", undefined, 32, "no_melee");
	common_scripts\_destructible::destructible_part("left_wheel_01_jnt", undefined, 20, undefined, undefined, "no_melee");
	common_scripts\_destructible::destructible_anim(%anim_0005, 2, "setanim", 1);
	common_scripts\_destructible::destructible_sound("veh_tire_deflate", "bullet");
	common_scripts\_destructible::destructible_part("right_wheel_01_jnt", undefined, 20, undefined, undefined, "no_melee");
	common_scripts\_destructible::destructible_anim(%anim_0003, 2, "setanim", 1);
	common_scripts\_destructible::destructible_sound("veh_tire_deflate", "bullet");
	common_scripts\_destructible::destructible_part("left_wheel_02_jnt", undefined, 20, undefined, undefined, "no_melee");
	common_scripts\_destructible::destructible_anim(%anim_0004, 2, "setanim", 1);
	common_scripts\_destructible::destructible_sound("veh_tire_deflate", "bullet");
	common_scripts\_destructible::destructible_part("right_wheel_02_jnt", "vehicle_coupe_wheel_lf", 20, undefined, undefined, "no_melee", undefined, 2.3);
	common_scripts\_destructible::destructible_anim(%anim_0002, 2, "setanim", 1);
	common_scripts\_destructible::destructible_sound("veh_tire_deflate", "bullet");
	common_scripts\_destructible::destructible_part("tag_door_left_front", "vehicle_coupe_" + color + "_door_LF", undefined, undefined, undefined, undefined, 1, 1);
	common_scripts\_destructible::destructible_part("tag_spoiler", "vehicle_coupe_" + color + "_spoiler", undefined, undefined, undefined, undefined, 1, 2);
	tag = "tag_glass_front";
	common_scripts\_destructible::destructible_part(tag, undefined, 40, undefined, undefined, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_state(tag + "_d", undefined, 60, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_fx("tag_glass_front_fx", "props/car_glass_large");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	tag = "tag_glass_back";
	common_scripts\_destructible::destructible_part(tag, undefined, 40, undefined, undefined, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_state(tag + "_d", undefined, 60, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_fx("tag_glass_back_fx", "props/car_glass_large");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	tag = "tag_glass_left_front";
	common_scripts\_destructible::destructible_part(tag, undefined, 20, undefined, undefined, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_state(tag + "_d", undefined, 60, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_fx("tag_glass_left_front_fx", "props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	tag = "tag_glass_right_front";
	common_scripts\_destructible::destructible_part(tag, undefined, 20, undefined, undefined, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_state(tag + "_d", undefined, 60, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_fx("tag_glass_right_front_fx", "props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	tag = "tag_glass_left_back";
	common_scripts\_destructible::destructible_part(tag, undefined, 20, undefined, undefined, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_state(tag + "_d", undefined, 60, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_fx("tag_glass_left_back_fx", "props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	tag = "tag_glass_right_back";
	common_scripts\_destructible::destructible_part(tag, undefined, 20, undefined, undefined, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_state(tag + "_d", undefined, 60, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_fx("tag_glass_right_back_fx", "props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	tag = "tag_light_left_front";
	common_scripts\_destructible::destructible_part(tag, undefined, 20, undefined, undefined, undefined, 0.5);
	common_scripts\_destructible::destructible_fx(tag, "props/car_glass_headlight");
	common_scripts\_destructible::destructible_sound("veh_glass_break_small");
	common_scripts\_destructible::destructible_state(tag + "_d");
	tag = "tag_light_right_front";
	common_scripts\_destructible::destructible_part(tag, undefined, 20, undefined, undefined, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_state(tag + "_d", undefined, 60, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_fx(tag, "props/car_glass_headlight");
	common_scripts\_destructible::destructible_sound("veh_glass_break_small");
	common_scripts\_destructible::destructible_part("tag_mirror_left", "vehicle_coupe_" + color + "_mirror_L", 40, undefined, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_physics();
	common_scripts\_destructible::destructible_part("tag_mirror_right", "vehicle_coupe_" + color + "_mirror_R", 40, undefined, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_physics();
}

vehicle_uaz_winter(destructibletype)
{
	common_scripts\_destructible::destructible_create(destructibletype, "tag_body", 250, undefined, 32, "no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_hood_fx", "smoke/car_damage_whitesmoke", 0.4);
	common_scripts\_destructible::destructible_state(undefined, undefined, 200, undefined, 32, "no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_hood_fx", "smoke/car_damage_blacksmoke", 0.4);
	common_scripts\_destructible::destructible_state(undefined, undefined, 100, undefined, 32, "no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_hood_fx", "smoke/car_damage_blacksmoke_fire", 0.4);
	common_scripts\_destructible::destructible_sound("fire_vehicle_flareup_med");
	common_scripts\_destructible::destructible_loopsound("fire_vehicle_med");
	common_scripts\_destructible::destructible_healthdrain(15, 0.25, 210, "allies");
	common_scripts\_destructible::destructible_state(undefined, undefined, 300, "player_only", 32, "no_melee");
	common_scripts\_destructible::destructible_loopsound("fire_vehicle_med");
	common_scripts\_destructible::destructible_state(undefined, undefined, 400, undefined, 32, "no_melee");
	common_scripts\_destructible::destructible_fx("tag_death_fx", "explosions/small_vehicle_explosion", 0);
	common_scripts\_destructible::destructible_sound("car_explode");
	common_scripts\_destructible::destructible_explode(4000, 5000, 200, 250, 50, 300, undefined, undefined, 0.3, 500);
	common_scripts\_destructible::destructible_anim(%anim_0001, 2, "setanimknob", undefined, undefined, "vehicle_80s_sedan1_destroy");
	common_scripts\_destructible::destructible_state(undefined, "vehicle_uaz_winter_destroy", undefined, 32, "no_melee");
	common_scripts\_destructible::destructible_part("left_wheel_01_jnt", "vehicle_uaz_wheel_LF_d", 20, undefined, undefined, "no_melee", undefined, 1);
	common_scripts\_destructible::destructible_anim(%anim_0005, 2, "setanim", 1);
	common_scripts\_destructible::destructible_sound("veh_tire_deflate", "bullet");
	common_scripts\_destructible::destructible_part("left_wheel_02_jnt", "vehicle_uaz_wheel_LF_d", 20, undefined, undefined, "no_melee");
	common_scripts\_destructible::destructible_anim(%anim_0004, 2, "setanim", 1);
	common_scripts\_destructible::destructible_sound("veh_tire_deflate", "bullet");
	common_scripts\_destructible::destructible_part("right_wheel_01_jnt", "vehicle_uaz_wheel_RF_d", 20, undefined, undefined, "no_melee", undefined, 10);
	common_scripts\_destructible::destructible_anim(%anim_0003, 2, "setanim", 1);
	common_scripts\_destructible::destructible_sound("veh_tire_deflate", "bullet");
	common_scripts\_destructible::destructible_part("right_wheel_02_jnt", "vehicle_uaz_wheel_RF_d", 20, undefined, undefined, "no_melee");
	common_scripts\_destructible::destructible_anim(%anim_0002, 2, "setanim", 1);
	common_scripts\_destructible::destructible_sound("veh_tire_deflate", "bullet");
	tag = "tag_glass_front";
	common_scripts\_destructible::destructible_part(tag, undefined, 40, undefined, undefined, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_state(tag + "_d", undefined, 60, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_fx("tag_glass_front_fx", "props/car_glass_large");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	tag = "tag_glass_back";
	common_scripts\_destructible::destructible_part(tag, undefined, 40, undefined, undefined, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_state(tag + "_d", undefined, 60, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_fx("tag_glass_back_fx", "props/car_glass_large");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	tag = "tag_glass_left_front";
	common_scripts\_destructible::destructible_part(tag, undefined, 20, undefined, undefined, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_state(tag + "_d", undefined, 60, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_fx("tag_glass_left_front_fx", "props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	tag = "tag_glass_right_front";
	common_scripts\_destructible::destructible_part(tag, undefined, 20, undefined, undefined, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_state(tag + "_d", undefined, 60, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_fx("tag_glass_right_front_fx", "props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	tag = "tag_glass_left_back";
	common_scripts\_destructible::destructible_part(tag, undefined, 20, undefined, undefined, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_state(tag + "_d", undefined, 60, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_fx("tag_glass_left_back_fx", "props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	tag = "tag_glass_right_back";
	common_scripts\_destructible::destructible_part(tag, undefined, 20, undefined, undefined, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_state(tag + "_d", undefined, 60, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_fx("tag_glass_right_back_fx", "props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	tag = "tag_glass_left_back_02";
	common_scripts\_destructible::destructible_part(tag, undefined, 20, undefined, undefined, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_state(tag + "_d", undefined, 60, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_fx("tag_glass_left_back_02_fx", "props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	tag = "tag_glass_right_back_02";
	common_scripts\_destructible::destructible_part(tag, undefined, 20, undefined, undefined, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_state(tag + "_d", undefined, 60, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_fx("tag_glass_right_back_02_fx", "props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	tag = "tag_light_left_front";
	common_scripts\_destructible::destructible_part(tag, undefined, 20, undefined, undefined, undefined, 0.5);
	common_scripts\_destructible::destructible_fx(tag, "props/car_glass_headlight");
	common_scripts\_destructible::destructible_sound("veh_glass_break_small");
	common_scripts\_destructible::destructible_state(tag + "_d");
	tag = "tag_light_right_front";
	common_scripts\_destructible::destructible_part(tag, undefined, 20, undefined, undefined, undefined, 0.5);
	common_scripts\_destructible::destructible_fx(tag, "props/car_glass_headlight");
	common_scripts\_destructible::destructible_sound("veh_glass_break_small");
	common_scripts\_destructible::destructible_state(tag + "_d");
	common_scripts\_destructible::destructible_part("tag_mirror_left", "vehicle_uaz_winter_mirror_L", 40, undefined, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_physics();
	common_scripts\_destructible::destructible_part("tag_mirror_right", "vehicle_uaz_winter_mirror_R", 40, undefined, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_physics();
}

vehicle_uaz_fabric(destructibletype)
{
	common_scripts\_destructible::destructible_create(destructibletype, "tag_body", 250, undefined, 32, "no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_hood_fx", "smoke/car_damage_whitesmoke", 0.4);
	common_scripts\_destructible::destructible_state(undefined, undefined, 200, undefined, 32, "no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_hood_fx", "smoke/car_damage_blacksmoke", 0.4);
	common_scripts\_destructible::destructible_state(undefined, undefined, 100, undefined, 32, "no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_hood_fx", "smoke/car_damage_blacksmoke_fire", 0.4);
	common_scripts\_destructible::destructible_sound("fire_vehicle_flareup_med");
	common_scripts\_destructible::destructible_loopsound("fire_vehicle_med");
	common_scripts\_destructible::destructible_healthdrain(15, 0.25, 210, "allies");
	common_scripts\_destructible::destructible_state(undefined, undefined, 300, "player_only", 32, "no_melee");
	common_scripts\_destructible::destructible_loopsound("fire_vehicle_med");
	common_scripts\_destructible::destructible_state(undefined, undefined, 400, undefined, 32, "no_melee");
	common_scripts\_destructible::destructible_fx("tag_death_fx", "explosions/small_vehicle_explosion", 0);
	common_scripts\_destructible::destructible_sound("car_explode");
	common_scripts\_destructible::destructible_explode(4000, 5000, 200, 250, 50, 300, undefined, undefined, 0.3, 500);
	common_scripts\_destructible::destructible_anim(%anim_0001, 2, "setanimknob", undefined, undefined, "vehicle_80s_sedan1_destroy");
	common_scripts\_destructible::destructible_state(undefined, "vehicle_uaz_fabric_dsr", undefined, 32, "no_melee");
	common_scripts\_destructible::destructible_part("left_wheel_01_jnt", "vehicle_uaz_wheel_LF_d", 20, undefined, undefined, "no_melee");
	common_scripts\_destructible::destructible_anim(%anim_0005, 2, "setanim", 1);
	common_scripts\_destructible::destructible_sound("veh_tire_deflate", "bullet");
	common_scripts\_destructible::destructible_part("left_wheel_02_jnt", "vehicle_uaz_wheel_LF_d", 20, undefined, undefined, "no_melee");
	common_scripts\_destructible::destructible_anim(%anim_0004, 2, "setanim", 1);
	common_scripts\_destructible::destructible_sound("veh_tire_deflate", "bullet");
	common_scripts\_destructible::destructible_part("right_wheel_01_jnt", "vehicle_uaz_wheel_RF_d", 20, undefined, undefined, "no_melee");
	common_scripts\_destructible::destructible_anim(%anim_0003, 2, "setanim", 1);
	common_scripts\_destructible::destructible_sound("veh_tire_deflate", "bullet");
	common_scripts\_destructible::destructible_part("right_wheel_02_jnt", "vehicle_uaz_wheel_RF_d", 20, undefined, undefined, "no_melee");
	common_scripts\_destructible::destructible_anim(%anim_0002, 2, "setanim", 1);
	common_scripts\_destructible::destructible_sound("veh_tire_deflate", "bullet");
	tag = "tag_glass_front";
	common_scripts\_destructible::destructible_part(tag, undefined, 40, undefined, undefined, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_state(tag + "_d", undefined, 60, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_fx("tag_glass_front_fx", "props/car_glass_large");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	tag = "tag_glass_back";
	common_scripts\_destructible::destructible_part(tag, undefined, 40, undefined, undefined, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_state(tag + "_d", undefined, 60, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_fx("tag_glass_back_fx", "props/car_glass_large");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	tag = "tag_glass_left_front";
	common_scripts\_destructible::destructible_part(tag, undefined, 20, undefined, undefined, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_state(tag + "_d", undefined, 60, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_fx("tag_glass_left_front_fx", "props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	tag = "tag_glass_right_front";
	common_scripts\_destructible::destructible_part(tag, undefined, 20, undefined, undefined, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_state(tag + "_d", undefined, 60, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_fx("tag_glass_right_front_fx", "props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	tag = "tag_glass_left_back";
	common_scripts\_destructible::destructible_part(tag, undefined, 20, undefined, undefined, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_state(tag + "_d", undefined, 60, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_fx("tag_glass_left_back_fx", "props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	tag = "tag_glass_right_back";
	common_scripts\_destructible::destructible_part(tag, undefined, 20, undefined, undefined, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_state(tag + "_d", undefined, 60, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_fx("tag_glass_right_back_fx", "props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	tag = "tag_light_left_front";
	common_scripts\_destructible::destructible_part(tag, undefined, 20, undefined, undefined, undefined, 0.5);
	common_scripts\_destructible::destructible_fx(tag, "props/car_glass_headlight");
	common_scripts\_destructible::destructible_sound("veh_glass_break_small");
	common_scripts\_destructible::destructible_state(tag + "_d");
	tag = "tag_light_right_front";
	common_scripts\_destructible::destructible_part(tag, undefined, 20, undefined, undefined, undefined, 0.5);
	common_scripts\_destructible::destructible_fx(tag, "props/car_glass_headlight");
	common_scripts\_destructible::destructible_sound("veh_glass_break_small");
	common_scripts\_destructible::destructible_state(tag + "_d");
	common_scripts\_destructible::destructible_part("tag_mirror_left", "vehicle_uaz_mirror_L", 40, undefined, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_physics();
	common_scripts\_destructible::destructible_part("tag_mirror_right", "vehicle_uaz_mirror_R", 40, undefined, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_physics();
}

vehicle_uaz_hardtop(destructibletype)
{
	common_scripts\_destructible::destructible_create(destructibletype, "tag_body", 250, undefined, 32, "no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_hood_fx", "smoke/car_damage_whitesmoke", 0.4);
	common_scripts\_destructible::destructible_state(undefined, undefined, 200, undefined, 32, "no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_hood_fx", "smoke/car_damage_blacksmoke", 0.4);
	common_scripts\_destructible::destructible_state(undefined, undefined, 100, undefined, 32, "no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_hood_fx", "smoke/car_damage_blacksmoke_fire", 0.4);
	common_scripts\_destructible::destructible_sound("fire_vehicle_flareup_med");
	common_scripts\_destructible::destructible_loopsound("fire_vehicle_med");
	common_scripts\_destructible::destructible_healthdrain(15, 0.25, 210, "allies");
	common_scripts\_destructible::destructible_state(undefined, undefined, 300, "player_only", 32, "no_melee");
	common_scripts\_destructible::destructible_loopsound("fire_vehicle_med");
	common_scripts\_destructible::destructible_state(undefined, undefined, 400, undefined, 32, "no_melee");
	common_scripts\_destructible::destructible_fx("tag_death_fx", "explosions/small_vehicle_explosion", 0);
	common_scripts\_destructible::destructible_sound("car_explode");
	common_scripts\_destructible::destructible_explode(4000, 5000, 200, 250, 50, 300, undefined, undefined, 0.3, 500);
	common_scripts\_destructible::destructible_anim(%anim_0001, 2, "setanimknob", undefined, undefined, "vehicle_80s_sedan1_destroy");
	common_scripts\_destructible::destructible_state(undefined, "vehicle_uaz_hardtop_dsr", undefined, 32, "no_melee");
	common_scripts\_destructible::destructible_part("left_wheel_01_jnt", "vehicle_uaz_wheel_LF_d", 20, undefined, undefined, "no_melee");
	common_scripts\_destructible::destructible_anim(%anim_0005, 2, "setanim", 1);
	common_scripts\_destructible::destructible_sound("veh_tire_deflate", "bullet");
	common_scripts\_destructible::destructible_part("left_wheel_02_jnt", "vehicle_uaz_wheel_LF_d", 20, undefined, undefined, "no_melee");
	common_scripts\_destructible::destructible_anim(%anim_0004, 2, "setanim", 1);
	common_scripts\_destructible::destructible_sound("veh_tire_deflate", "bullet");
	common_scripts\_destructible::destructible_part("right_wheel_01_jnt", "vehicle_uaz_wheel_RF_d", 20, undefined, undefined, "no_melee");
	common_scripts\_destructible::destructible_anim(%anim_0003, 2, "setanim", 1);
	common_scripts\_destructible::destructible_sound("veh_tire_deflate", "bullet");
	common_scripts\_destructible::destructible_part("right_wheel_02_jnt", "vehicle_uaz_wheel_RF_d", 20, undefined, undefined, "no_melee");
	common_scripts\_destructible::destructible_anim(%anim_0002, 2, "setanim", 1);
	common_scripts\_destructible::destructible_sound("veh_tire_deflate", "bullet");
	tag = "tag_glass_front";
	common_scripts\_destructible::destructible_part(tag, undefined, 40, undefined, undefined, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_state(tag + "_d", undefined, 60, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_fx("tag_glass_front_fx", "props/car_glass_large");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	tag = "tag_glass_back";
	common_scripts\_destructible::destructible_part(tag, undefined, 40, undefined, undefined, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_state(tag + "_d", undefined, 60, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_fx("tag_glass_back_fx", "props/car_glass_large");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	tag = "tag_glass_left_front";
	common_scripts\_destructible::destructible_part(tag, undefined, 20, undefined, undefined, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_state(tag + "_d", undefined, 60, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_fx("tag_glass_left_front_fx", "props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	tag = "tag_glass_right_front";
	common_scripts\_destructible::destructible_part(tag, undefined, 20, undefined, undefined, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_state(tag + "_d", undefined, 60, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_fx("tag_glass_right_front_fx", "props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	tag = "tag_glass_left_back";
	common_scripts\_destructible::destructible_part(tag, undefined, 20, undefined, undefined, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_state(tag + "_d", undefined, 60, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_fx("tag_glass_left_back_fx", "props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	tag = "tag_glass_right_back";
	common_scripts\_destructible::destructible_part(tag, undefined, 20, undefined, undefined, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_state(tag + "_d", undefined, 60, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_fx("tag_glass_right_back_fx", "props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	tag = "tag_glass_left_back2";
	common_scripts\_destructible::destructible_part(tag, undefined, 20, undefined, undefined, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_state(tag + "_d", undefined, 60, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_fx("tag_glass_left_back2_fx", "props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	tag = "tag_glass_right_back2";
	common_scripts\_destructible::destructible_part(tag, undefined, 20, undefined, undefined, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_state(tag + "_d", undefined, 60, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_fx("tag_glass_right_back2_fx", "props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	tag = "tag_light_left_front";
	common_scripts\_destructible::destructible_part(tag, undefined, 20, undefined, undefined, undefined, 0.5);
	common_scripts\_destructible::destructible_fx(tag, "props/car_glass_headlight");
	common_scripts\_destructible::destructible_sound("veh_glass_break_small");
	common_scripts\_destructible::destructible_state(tag + "_d");
	tag = "tag_light_right_front";
	common_scripts\_destructible::destructible_part(tag, undefined, 20, undefined, undefined, undefined, 0.5);
	common_scripts\_destructible::destructible_fx(tag, "props/car_glass_headlight");
	common_scripts\_destructible::destructible_sound("veh_glass_break_small");
	common_scripts\_destructible::destructible_state(tag + "_d");
	common_scripts\_destructible::destructible_part("tag_mirror_left", "vehicle_uaz_mirror_L", 40, undefined, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_physics();
	common_scripts\_destructible::destructible_part("tag_mirror_right", "vehicle_uaz_mirror_R", 40, undefined, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_physics();
}

vehicle_uaz_open(destructibletype)
{
	common_scripts\_destructible::destructible_create(destructibletype, "tag_body", 250, undefined, 32, "no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_hood_fx", "smoke/car_damage_whitesmoke", 0.4);
	common_scripts\_destructible::destructible_state(undefined, undefined, 200, undefined, 32, "no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_hood_fx", "smoke/car_damage_blacksmoke", 0.4);
	common_scripts\_destructible::destructible_state(undefined, undefined, 100, undefined, 32, "no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_hood_fx", "smoke/car_damage_blacksmoke_fire", 0.4);
	common_scripts\_destructible::destructible_sound("fire_vehicle_flareup_med");
	common_scripts\_destructible::destructible_loopsound("fire_vehicle_med");
	common_scripts\_destructible::destructible_healthdrain(15, 0.25, 210, "allies");
	common_scripts\_destructible::destructible_state(undefined, undefined, 300, "player_only", 32, "no_melee");
	common_scripts\_destructible::destructible_loopsound("fire_vehicle_med");
	common_scripts\_destructible::destructible_state(undefined, undefined, 400, undefined, 32, "no_melee");
	common_scripts\_destructible::destructible_fx("tag_death_fx", "explosions/small_vehicle_explosion", 0);
	common_scripts\_destructible::destructible_sound("car_explode");
	common_scripts\_destructible::destructible_explode(4000, 5000, 200, 250, 50, 300, undefined, undefined, 0.3, 500);
	common_scripts\_destructible::destructible_anim(%anim_0001, 2, "setanimknob", undefined, undefined, "vehicle_80s_sedan1_destroy");
	common_scripts\_destructible::destructible_state(undefined, "vehicle_uaz_open_dsr", undefined, 32, "no_melee");
	common_scripts\_destructible::destructible_part("left_wheel_01_jnt", "vehicle_uaz_wheel_LF_d", 20, undefined, undefined, "no_melee");
	common_scripts\_destructible::destructible_anim(%anim_0005, 2, "setanim", 1);
	common_scripts\_destructible::destructible_sound("veh_tire_deflate", "bullet");
	common_scripts\_destructible::destructible_part("left_wheel_02_jnt", "vehicle_uaz_wheel_LF_d", 20, undefined, undefined, "no_melee");
	common_scripts\_destructible::destructible_anim(%anim_0004, 2, "setanim", 1);
	common_scripts\_destructible::destructible_sound("veh_tire_deflate", "bullet");
	common_scripts\_destructible::destructible_part("right_wheel_01_jnt", "vehicle_uaz_wheel_LF_d", 20, undefined, undefined, "no_melee");
	common_scripts\_destructible::destructible_anim(%anim_0003, 2, "setanim", 1);
	common_scripts\_destructible::destructible_sound("veh_tire_deflate", "bullet");
	common_scripts\_destructible::destructible_part("right_wheel_02_jnt", "vehicle_uaz_wheel_LF_d", 20, undefined, undefined, "no_melee");
	common_scripts\_destructible::destructible_anim(%anim_0002, 2, "setanim", 1);
	common_scripts\_destructible::destructible_sound("veh_tire_deflate", "bullet");
	tag = "tag_glass_front";
	common_scripts\_destructible::destructible_part(tag, undefined, 40, undefined, undefined, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_state(tag + "_d", undefined, 60, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_fx("tag_glass_front_fx", "props/car_glass_large");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	tag = "tag_glass_back";
	common_scripts\_destructible::destructible_part(tag, undefined, 40, undefined, undefined, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_state(tag + "_d", undefined, 60, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_fx("tag_glass_back_fx", "props/car_glass_large");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	tag = "tag_glass_left_front";
	common_scripts\_destructible::destructible_part(tag, undefined, 20, undefined, undefined, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_state(tag + "_d", undefined, 60, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_fx("tag_glass_left_front_fx", "props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	tag = "tag_glass_right_front";
	common_scripts\_destructible::destructible_part(tag, undefined, 20, undefined, undefined, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_state(tag + "_d", undefined, 60, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_fx("tag_glass_right_front_fx", "props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	tag = "tag_glass_left_back";
	common_scripts\_destructible::destructible_part(tag, undefined, 20, undefined, undefined, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_state(tag + "_d", undefined, 60, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_fx("tag_glass_left_back_fx", "props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	tag = "tag_glass_right_back";
	common_scripts\_destructible::destructible_part(tag, undefined, 20, undefined, undefined, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_state(tag + "_d", undefined, 60, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_fx("tag_glass_right_back_fx", "props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	tag = "tag_glass_left_back_02";
	common_scripts\_destructible::destructible_part(tag, undefined, 20, undefined, undefined, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_state(tag + "_d", undefined, 60, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_fx("tag_glass_left_back_02_fx", "props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	tag = "tag_glass_right_back_02";
	common_scripts\_destructible::destructible_part(tag, undefined, 20, undefined, undefined, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_state(tag + "_d", undefined, 60, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_fx("tag_glass_right_back_02_fx", "props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	tag = "tag_light_left_front";
	common_scripts\_destructible::destructible_part(tag, undefined, 20, undefined, undefined, undefined, 0.5);
	common_scripts\_destructible::destructible_fx(tag, "props/car_glass_headlight");
	common_scripts\_destructible::destructible_sound("veh_glass_break_small");
	common_scripts\_destructible::destructible_state(tag + "_d");
	tag = "tag_light_right_front";
	common_scripts\_destructible::destructible_part(tag, undefined, 20, undefined, undefined, undefined, 0.5);
	common_scripts\_destructible::destructible_fx(tag, "props/car_glass_headlight");
	common_scripts\_destructible::destructible_sound("veh_glass_break_small");
	common_scripts\_destructible::destructible_state(tag + "_d");
	common_scripts\_destructible::destructible_part("tag_mirror_left", "vehicle_uaz_mirror_L", 40, undefined, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_physics();
	common_scripts\_destructible::destructible_part("tag_mirror_right", "vehicle_uaz_mirror_R", 40, undefined, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_physics();
}

vehicle_policecar(destructibletype)
{
	common_scripts\_destructible::destructible_create(destructibletype, "tag_body", 250, undefined, 32, "no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_hood_fx", "smoke/car_damage_whitesmoke", 0.4);
	common_scripts\_destructible::destructible_state(undefined, undefined, 200, undefined, 32, "no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_hood_fx", "smoke/car_damage_blacksmoke", 0.4);
	common_scripts\_destructible::destructible_state(undefined, undefined, 100, undefined, 32, "no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_hood_fx", "smoke/car_damage_blacksmoke_fire", 0.4);
	common_scripts\_destructible::destructible_sound("fire_vehicle_flareup_med");
	common_scripts\_destructible::destructible_loopsound("fire_vehicle_med");
	common_scripts\_destructible::destructible_healthdrain(15, 0.25, 210, "allies");
	common_scripts\_destructible::destructible_state(undefined, undefined, 300, "player_only", 32, "no_melee");
	common_scripts\_destructible::destructible_loopsound("fire_vehicle_med");
	common_scripts\_destructible::destructible_state(undefined, undefined, 400, undefined, 32, "no_melee");
	common_scripts\_destructible::destructible_fx("tag_death_fx", "explosions/small_vehicle_explosion", 0);
	common_scripts\_destructible::destructible_sound("car_explode_police");
	common_scripts\_destructible::destructible_explode(4000, 5000, 200, 250, 50, 300, undefined, undefined, 0.3, 500);
	common_scripts\_destructible::destructible_anim(%anim_0001, 2, "setanimknob", undefined, undefined, "vehicle_80s_sedan1_destroy");
	common_scripts\_destructible::destructible_state(undefined, "vehicle_policecar_lapd_destroy", undefined, 32, "no_melee");
	common_scripts\_destructible::destructible_part("left_wheel_01_jnt", "vehicle_policecar_lapd_wheel_LF", 20, undefined, undefined, "no_melee", undefined, 1.7);
	common_scripts\_destructible::destructible_anim(%anim_0005, 2, "setanim");
	common_scripts\_destructible::destructible_sound("veh_tire_deflate", "bullet");
	common_scripts\_destructible::destructible_part("left_wheel_02_jnt", "vehicle_policecar_lapd_wheel_LF", 20, undefined, undefined, "no_melee", undefined, 1.7);
	common_scripts\_destructible::destructible_anim(%anim_0004, 2, "setanim");
	common_scripts\_destructible::destructible_sound("veh_tire_deflate", "bullet");
	common_scripts\_destructible::destructible_part("right_wheel_01_jnt", "vehicle_policecar_lapd_wheel_LF", 20, undefined, undefined, "no_melee", undefined, 1.7);
	common_scripts\_destructible::destructible_anim(%anim_0003, 2, "setanim");
	common_scripts\_destructible::destructible_sound("veh_tire_deflate", "bullet");
	common_scripts\_destructible::destructible_part("right_wheel_02_jnt", "vehicle_policecar_lapd_wheel_LF", 20, undefined, undefined, "no_melee");
	common_scripts\_destructible::destructible_anim(%anim_0002, 2, "setanim");
	common_scripts\_destructible::destructible_sound("veh_tire_deflate", "bullet");
	common_scripts\_destructible::destructible_part("tag_door_left_front", "vehicle_policecar_lapd_door_LF", undefined, undefined, undefined, undefined, 1, 1);
	common_scripts\_destructible::destructible_part("tag_door_right_front", "vehicle_policecar_lapd_door_RF", undefined, undefined, undefined, undefined, 1, 1);
	common_scripts\_destructible::destructible_part("tag_door_left_back", "vehicle_policecar_lapd_door_LB", undefined, undefined, undefined, undefined, 1, 1);
	tag = "tag_glass_front";
	common_scripts\_destructible::destructible_part(tag, undefined, 40, undefined, undefined, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_state(tag + "_d", undefined, 60, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_fx("tag_glass_front_fx", "props/car_glass_large");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	tag = "tag_glass_back";
	common_scripts\_destructible::destructible_part(tag, undefined, 40, undefined, undefined, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_state(tag + "_d", undefined, 60, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_fx("tag_glass_back_fx", "props/car_glass_large");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	tag = "tag_center_glass";
	common_scripts\_destructible::destructible_part(tag, undefined, 40, undefined, undefined, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_state(tag + "_d", undefined, 60, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_fx("TAG_CENTER_GLASS_FX", "props/car_glass_large");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	tag = "tag_glass_left_front";
	common_scripts\_destructible::destructible_part(tag, undefined, 20, undefined, undefined, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_state(tag + "_d", undefined, 60, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_fx("tag_glass_left_front_fx", "props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	tag = "tag_glass_right_front";
	common_scripts\_destructible::destructible_part(tag, undefined, 20, undefined, undefined, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_state(tag + "_d", undefined, 60, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_fx("tag_glass_right_front_fx", "props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	tag = "tag_glass_left_back";
	common_scripts\_destructible::destructible_part(tag, undefined, 20, undefined, undefined, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_state(tag + "_d", undefined, 60, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_fx("tag_glass_left_back_fx", "props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	tag = "tag_glass_right_back";
	common_scripts\_destructible::destructible_part(tag, undefined, 20, undefined, undefined, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_state(tag + "_d", undefined, 60, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_fx("tag_glass_right_back_fx", "props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	tag = "tag_light_left_front";
	common_scripts\_destructible::destructible_part(tag, undefined, 20, undefined, undefined, undefined, 0.5);
	common_scripts\_destructible::destructible_fx(tag, "props/car_glass_headlight");
	common_scripts\_destructible::destructible_sound("veh_glass_break_small");
	common_scripts\_destructible::destructible_state(tag + "_d");
	tag = "tag_light_right_front";
	common_scripts\_destructible::destructible_part(tag, undefined, 20, undefined, undefined, undefined, 0.5);
	common_scripts\_destructible::destructible_fx(tag, "props/car_glass_headlight");
	common_scripts\_destructible::destructible_sound("veh_glass_break_small");
	common_scripts\_destructible::destructible_state(tag + "_d");
	common_scripts\_destructible::destructible_part("tag_mirror_left", "vehicle_policecar_lapd_mirror_L", 40, undefined, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_physics();
	common_scripts\_destructible::destructible_part("tag_mirror_right", "vehicle_policecar_lapd_mirror_R", 40, undefined, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_physics();
}

vehicle_policecar_russia(destructibletype)
{
	common_scripts\_destructible::destructible_create(destructibletype, "tag_body", 250, undefined, 32, "no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_hood_fx", "smoke/car_damage_whitesmoke", 0.4);
	common_scripts\_destructible::destructible_state(undefined, undefined, 200, undefined, 32, "no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_hood_fx", "smoke/car_damage_blacksmoke", 0.4);
	common_scripts\_destructible::destructible_state(undefined, undefined, 100, undefined, 32, "no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_hood_fx", "smoke/car_damage_blacksmoke_fire", 0.4);
	common_scripts\_destructible::destructible_sound("fire_vehicle_flareup_med");
	common_scripts\_destructible::destructible_loopsound("fire_vehicle_med");
	common_scripts\_destructible::destructible_healthdrain(15, 0.25, 210, "allies");
	common_scripts\_destructible::destructible_state(undefined, undefined, 300, "player_only", 32, "no_melee");
	common_scripts\_destructible::destructible_loopsound("fire_vehicle_med");
	common_scripts\_destructible::destructible_state(undefined, undefined, 400, undefined, 32, "no_melee");
	common_scripts\_destructible::destructible_fx("tag_death_fx", "explosions/small_vehicle_explosion", 0);
	common_scripts\_destructible::destructible_sound("car_explode_police");
	common_scripts\_destructible::destructible_explode(4000, 5000, 200, 250, 50, 300, undefined, undefined, 0.3, 500);
	common_scripts\_destructible::destructible_anim(%anim_0001, 2, "setanimknob", undefined, undefined, "vehicle_80s_sedan1_destroy");
	common_scripts\_destructible::destructible_state(undefined, "vehicle_policecar_russia_destroy", undefined, 32, "no_melee");
	common_scripts\_destructible::destructible_part("left_wheel_01_jnt", "vehicle_policecar_russia_wheel_LF", 20, undefined, undefined, "no_melee", undefined, 1.7);
	common_scripts\_destructible::destructible_anim(%anim_0005, 2, "setanim");
	common_scripts\_destructible::destructible_sound("veh_tire_deflate", "bullet");
	common_scripts\_destructible::destructible_part("left_wheel_02_jnt", "vehicle_policecar_russia_wheel_LF", 20, undefined, undefined, "no_melee", undefined, 1.7);
	common_scripts\_destructible::destructible_anim(%anim_0004, 2, "setanim");
	common_scripts\_destructible::destructible_sound("veh_tire_deflate", "bullet");
	common_scripts\_destructible::destructible_part("right_wheel_01_jnt", "vehicle_policecar_russia_wheel_LF", 20, undefined, undefined, "no_melee", undefined, 1.7);
	common_scripts\_destructible::destructible_anim(%anim_0003, 2, "setanim");
	common_scripts\_destructible::destructible_sound("veh_tire_deflate", "bullet");
	common_scripts\_destructible::destructible_part("right_wheel_02_jnt", "vehicle_policecar_russia_wheel_LF", 20, undefined, undefined, "no_melee");
	common_scripts\_destructible::destructible_anim(%anim_0002, 2, "setanim");
	common_scripts\_destructible::destructible_sound("veh_tire_deflate", "bullet");
	common_scripts\_destructible::destructible_part("tag_door_left_front", "vehicle_policecar_russia_door_LF", undefined, undefined, undefined, undefined, 1, 1);
	common_scripts\_destructible::destructible_part("tag_door_right_front", "vehicle_policecar_russia_door_RF", undefined, undefined, undefined, undefined, 1, 1);
	common_scripts\_destructible::destructible_part("tag_door_left_back", "vehicle_policecar_russia_door_LB", undefined, undefined, undefined, undefined, 1, 1);
	tag = "tag_glass_front";
	common_scripts\_destructible::destructible_part(tag, undefined, 40, undefined, undefined, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_state(tag + "_d", undefined, 60, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_fx("tag_glass_front_fx", "props/car_glass_large");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	tag = "tag_glass_back";
	common_scripts\_destructible::destructible_part(tag, undefined, 40, undefined, undefined, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_state(tag + "_d", undefined, 60, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_fx("tag_glass_back_fx", "props/car_glass_large");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	tag = "tag_center_glass";
	common_scripts\_destructible::destructible_part(tag, undefined, 40, undefined, undefined, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_state(tag + "_d", undefined, 60, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_fx("TAG_CENTER_GLASS_FX", "props/car_glass_large");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	tag = "tag_glass_left_front";
	common_scripts\_destructible::destructible_part(tag, undefined, 20, undefined, undefined, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_state(tag + "_d", undefined, 60, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_fx("tag_glass_left_front_fx", "props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	tag = "tag_glass_right_front";
	common_scripts\_destructible::destructible_part(tag, undefined, 20, undefined, undefined, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_state(tag + "_d", undefined, 60, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_fx("tag_glass_right_front_fx", "props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	tag = "tag_glass_left_back";
	common_scripts\_destructible::destructible_part(tag, undefined, 20, undefined, undefined, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_state(tag + "_d", undefined, 60, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_fx("tag_glass_left_back_fx", "props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	tag = "tag_glass_right_back";
	common_scripts\_destructible::destructible_part(tag, undefined, 20, undefined, undefined, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_state(tag + "_d", undefined, 60, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_fx("tag_glass_right_back_fx", "props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_state(undefined);
	tag = "tag_light_left_front";
	common_scripts\_destructible::destructible_part(tag, undefined, 20, undefined, undefined, undefined, 0.5);
	common_scripts\_destructible::destructible_fx(tag, "props/car_glass_headlight");
	common_scripts\_destructible::destructible_sound("veh_glass_break_small");
	common_scripts\_destructible::destructible_state(tag + "_d");
	tag = "tag_light_right_front";
	common_scripts\_destructible::destructible_part(tag, undefined, 20, undefined, undefined, undefined, 0.5);
	common_scripts\_destructible::destructible_fx(tag, "props/car_glass_headlight");
	common_scripts\_destructible::destructible_sound("veh_glass_break_small");
	common_scripts\_destructible::destructible_state(tag + "_d");
	common_scripts\_destructible::destructible_part("tag_mirror_left", "vehicle_policecar_russia_mirror_L", 40, undefined, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_physics();
	common_scripts\_destructible::destructible_part("tag_mirror_right", "vehicle_policecar_russia_mirror_R", 40, undefined, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_physics();
}

vehicle_taxi(destructibletype)
{
	common_scripts\_destructible::destructible_create(destructibletype, "tag_body", 250, undefined, 32, "no_melee");
	common_scripts\_destructible::random_dynamic_attachment("tag_ad", "vehicle_taxi_rooftop_ad_base", "vehicle_taxi_rooftop_ad_1");
	common_scripts\_destructible::random_dynamic_attachment("tag_ad", "vehicle_taxi_rooftop_ad_base", "vehicle_taxi_rooftop_ad_2");
	common_scripts\_destructible::random_dynamic_attachment("tag_ad", "vehicle_taxi_rooftop_ad_base", "vehicle_taxi_rooftop_ad_3");
	common_scripts\_destructible::random_dynamic_attachment("tag_ad", "vehicle_taxi_rooftop_ad_base", "vehicle_taxi_rooftop_ad_4");
	common_scripts\_destructible::random_dynamic_attachment("tag_ad", "vehicle_taxi_toplight", undefined, "taxi_ad_clip");
	common_scripts\_destructible::destructible_loopfx("tag_hood_fx", "smoke/car_damage_whitesmoke", 0.4);
	common_scripts\_destructible::destructible_car_alarm();
	common_scripts\_destructible::destructible_state(undefined, undefined, 200, undefined, 32, "no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_hood_fx", "smoke/car_damage_blacksmoke", 0.4);
	common_scripts\_destructible::destructible_state(undefined, undefined, 100, undefined, 32, "no_melee");
	common_scripts\_destructible::destructible_loopfx("tag_hood_fx", "smoke/car_damage_blacksmoke_fire", 0.4);
	common_scripts\_destructible::destructible_sound("fire_vehicle_flareup_med");
	common_scripts\_destructible::destructible_loopsound("fire_vehicle_med");
	common_scripts\_destructible::destructible_healthdrain(15, 0.25, 210, "allies");
	common_scripts\_destructible::destructible_state(undefined, undefined, 300, "player_only", 32, "no_melee");
	common_scripts\_destructible::destructible_loopsound("fire_vehicle_med");
	common_scripts\_destructible::destructible_state(undefined, undefined, 400, undefined, 32, "no_melee");
	common_scripts\_destructible::destructible_fx("tag_death_fx", "explosions/small_vehicle_explosion", 0);
	common_scripts\_destructible::destructible_sound("car_explode");
	common_scripts\_destructible::destructible_explode(4000, 5000, 200, 250, 50, 300, undefined, undefined, 0.3, 500);
	common_scripts\_destructible::destructible_anim(%anim_0001, 2, "setanimknob", undefined, undefined, "vehicle_80s_sedan1_destroy");
	common_scripts\_destructible::destructible_state(undefined, "vehicle_taxi_yellow_destroy", undefined, 32, "no_melee");
	common_scripts\_destructible::destructible_part("left_wheel_01_jnt", "vehicle_taxi_wheel_LF", 20, undefined, undefined, "no_melee");
	common_scripts\_destructible::destructible_anim(%anim_0005, 2, "setanim");
	common_scripts\_destructible::destructible_sound("veh_tire_deflate", "bullet");
	common_scripts\_destructible::destructible_car_alarm();
	common_scripts\_destructible::destructible_part("left_wheel_02_jnt", "vehicle_taxi_wheel_LF", 20, undefined, undefined, "no_melee", undefined, 1.7);
	common_scripts\_destructible::destructible_anim(%anim_0004, 2, "setanim");
	common_scripts\_destructible::destructible_sound("veh_tire_deflate", "bullet");
	common_scripts\_destructible::destructible_car_alarm();
	common_scripts\_destructible::destructible_part("right_wheel_01_jnt", "vehicle_taxi_wheel_LF", 20, undefined, undefined, "no_melee", undefined, 1.7);
	common_scripts\_destructible::destructible_anim(%anim_0003, 2, "setanim");
	common_scripts\_destructible::destructible_sound("veh_tire_deflate", "bullet");
	common_scripts\_destructible::destructible_car_alarm();
	common_scripts\_destructible::destructible_part("right_wheel_02_jnt", "vehicle_taxi_wheel_LF", 20, undefined, undefined, "no_melee");
	common_scripts\_destructible::destructible_anim(%anim_0002, 2, "setanim");
	common_scripts\_destructible::destructible_sound("veh_tire_deflate", "bullet");
	common_scripts\_destructible::destructible_car_alarm();
	tag = "tag_glass_front";
	common_scripts\_destructible::destructible_part(tag, undefined, 40, undefined, undefined, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_state(tag + "_d", undefined, 60, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_fx("tag_glass_front_fx", "props/car_glass_large");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_car_alarm();
	common_scripts\_destructible::destructible_state(undefined);
	tag = "tag_glass_back";
	common_scripts\_destructible::destructible_part(tag, undefined, 40, undefined, undefined, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_state(tag + "_d", undefined, 60, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_fx("tag_glass_back_fx", "props/car_glass_large");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_car_alarm();
	common_scripts\_destructible::destructible_state(undefined);
	tag = "tag_center_glass";
	common_scripts\_destructible::destructible_part(tag, undefined, 40, undefined, undefined, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_state(tag + "_d", undefined, 60, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_fx("TAG_CENTER_GLASS_FX", "props/car_glass_large");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_car_alarm();
	common_scripts\_destructible::destructible_state(undefined);
	tag = "tag_glass_left_front";
	common_scripts\_destructible::destructible_part(tag, undefined, 20, undefined, undefined, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_state(tag + "_d", undefined, 60, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_fx("tag_glass_left_front_fx", "props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_car_alarm();
	common_scripts\_destructible::destructible_state(undefined);
	tag = "tag_glass_right_front";
	common_scripts\_destructible::destructible_part(tag, undefined, 20, undefined, undefined, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_state(tag + "_d", undefined, 60, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_fx("tag_glass_right_front_fx", "props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_car_alarm();
	common_scripts\_destructible::destructible_state(undefined);
	tag = "tag_glass_left_back";
	common_scripts\_destructible::destructible_part(tag, undefined, 20, undefined, undefined, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_state(tag + "_d", undefined, 60, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_fx("tag_glass_left_back_fx", "props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_car_alarm();
	common_scripts\_destructible::destructible_state(undefined);
	tag = "tag_glass_right_back";
	common_scripts\_destructible::destructible_part(tag, undefined, 20, undefined, undefined, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_state(tag + "_d", undefined, 60, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_fx("tag_glass_right_back_fx", "props/car_glass_med");
	common_scripts\_destructible::destructible_sound("veh_glass_break_large");
	common_scripts\_destructible::destructible_car_alarm();
	common_scripts\_destructible::destructible_state(undefined);
	tag = "tag_light_left_front";
	common_scripts\_destructible::destructible_part(tag, undefined, 20, undefined, undefined, undefined, 0.5);
	common_scripts\_destructible::destructible_fx(tag, "props/car_glass_headlight");
	common_scripts\_destructible::destructible_sound("veh_glass_break_small");
	common_scripts\_destructible::destructible_state(tag + "_d");
	tag = "tag_light_right_front";
	common_scripts\_destructible::destructible_part(tag, undefined, 20, undefined, undefined, undefined, 0.5);
	common_scripts\_destructible::destructible_fx(tag, "props/car_glass_headlight");
	common_scripts\_destructible::destructible_sound("veh_glass_break_small");
	common_scripts\_destructible::destructible_state(tag + "_d");
	common_scripts\_destructible::destructible_part("tag_mirror_left", "vehicle_taxi_mirror_L", 40, undefined, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_physics();
	common_scripts\_destructible::destructible_part("tag_mirror_right", "vehicle_taxi_mirror_R", 40, undefined, undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_physics();
}