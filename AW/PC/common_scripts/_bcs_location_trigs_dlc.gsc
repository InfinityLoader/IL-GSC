/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: _bcs_location_trigs_dlc.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 21
 * Decompile Time: 263 ms
 * Timestamp: 4/22/2024 2:02:51 AM
*******************************************************************/

//Function Number: 1
bcs_location_trigs_dlc_init()
{
	if(isdefined(level.dds) && isdefined(level.bcs_locations))
	{
		return;
	}

	level.bcs_location_mappings = [];
	bcs_dlc_location_trigger_mapping();
	bcs_dlc_trigs_assign_aliases();
	level.bcs_location_mappings = undefined;
	anim.locationlastcallouttimes = [];
}

//Function Number: 2
bcs_dlc_trigs_assign_aliases()
{
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

		var_06 = parselocationaliases(level.bcs_location_mappings[var_03.classname]);
		if(var_06.size > 1)
		{
			var_06 = common_scripts\utility::array_randomize(var_06);
		}

		var_03.locationaliases = var_06;
		level.bcs_locations[level.bcs_locations.size] = var_03;
	}

	anim.bcs_locations = var_01;
}

//Function Number: 3
parselocationaliases(param_00)
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
		var_03 = parselocationaliases(var_02);
		var_04 = parselocationaliases(param_01);
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
		level.bcs_location_mappings[param_00] = var_02;
		return;
	}

	level.bcs_location_mappings[var_09] = var_0A;
}

//Function Number: 5
bcs_dlc_location_trigger_mapping()
{
	if(!common_scripts\utility::issp())
	{
		clowntown_mp();
		torqued_mp();
		lost_mp();
		mp_urban();
		mp_climate_3();
		mp_perplex_1();
		mp_blackbox();
		mp_spark();
		mp_highrise2();
		mp_kremlin();
		mp_bigben2();
		mp_sector17();
		mp_seoul2();
		mp_liberty();
		mp_fracture();
		mp_lair();
	}
}

//Function Number: 6
mp_lair()
{
	add_bcs_location_mapping("trigger_multiple_bcs_mp_lair_plasma","lair_plasma");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_lair_offices","lair_offices");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_lair_bar","lair_bar");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_lair_patio","lair_patio");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_lair_dance","lair_dance");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_lair_hpad","lair_hpad");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_lair_wtower","lair_wtower");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_lair_court","lair_court");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_lair_fountain","lair_fountain");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_lair_spa","lair_spa");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_lair_etower","lair_etower");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_lair_deck","lair_deck");
}

//Function Number: 7
mp_fracture()
{
	add_bcs_location_mapping("trigger_multiple_bcs_mp_frac_fuel","frac_fuel");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_frac_base","frac_base");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_frac_exc_sites","frac_exc_sites");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_frac_shore","frac_shore");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_frac_obs_deck","frac_obs_deck");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_frac_crane","frac_crane");
}

//Function Number: 8
mp_liberty()
{
	add_bcs_location_mapping("trigger_multiple_bcs_mp_lib_parking","lib_parking");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_lib_trees","lib_trees");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_lib_medical","lib_medical");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_lib_sec","lib_sec");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_lib_sec_roof","lib_sec_roof");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_lib_monkeys","lib_monkeys");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_lib_catwalk","lib_catwalk");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_lib_camp","lib_camp");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_lib_res","lib_res");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_lib_ambu","lib_ambu");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_lib_hay","lib_hay");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_lib_loading","lib_loading");
}

//Function Number: 9
mp_seoul2()
{
	add_bcs_location_mapping("trigger_multiple_bcs_mp_se2_awn","se2_awn");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_se2_awn_blw","se2_awn_blw");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_se2_nom","se2_nom");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_se2_roof","se2_roof");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_se2_humvees","se2_humvees");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_se2_bus_area","se2_bus_area");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_se2_sak_fl2","se2_sak_fl2");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_se2_sak_fl1","se2_sak_fl1");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_se2_bar_fl2","se2_bar_fl2");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_se2_alley","se2_alley");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_se2_fork","se2_fork");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_se2_ddc","se2_ddc");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_se2_trailer","se2_trailer");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_se2_van","se2_van");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_se2_fish","se2_fish");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_se2_koi_fl2","se2_koi_fl2");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_se2_cargo","se2_cargo");
}

//Function Number: 10
mp_sector17()
{
	add_bcs_location_mapping("trigger_multiple_bcs_mp_sector17_entgate","sector17_entgate");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_sector17_bridge","sector17_bridge");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_sector17_alphabuild","sector17_alphabuild");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_sector17_alphapath","sector17_alphapath");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_sector17_centcont","sector17_centcont");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_sector17_hazmat","sector17_hazmat");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_sector17_airgate","sector17_airgate");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_sector17_forttop","sector17_forttop");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_sector17_fortbunk","sector17_fortbunk");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_sector17_forttunnel","sector17_forttunnel");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_sector17_bravobuild","sector17_bravobuild");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_sector17_bravolot","sector17_bravolot");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_sector17_charbuild","sector17_charbuild");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_sector17_rustbelt","sector17_rustbelt");
}

//Function Number: 11
mp_bigben2()
{
	add_bcs_location_mapping("trigger_multiple_bcs_mp_bigben_balcony","bigben_balcony");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_bigben_deck","bigben_deck");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_bigben_lodeck","bigben_lodeck");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_bigben_hallway","bigben_hallway");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_bigben_juncroom","bigben_juncroom");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_bigben_minideck","bigben_minideck");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_bigben_guns","bigben_guns");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_bigben_gunplat","bigben_gunplat");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_bigben_crates","bigben_crates");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_bigben_bridge","bigben_bridge");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_bigben_ramp","bigben_ramp");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_bigben_shore","bigben_shore");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_bigben_roof","bigben_roof");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_bigben_ticket","bigben_ticket");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_bigben_scrub","bigben_scrub");
}

//Function Number: 12
mp_kremlin()
{
	add_bcs_location_mapping("trigger_multiple_bcs_mp_kremlin_park","kremlin_park");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_kremlin_chkpoint","kremlin_chkpoint");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_kremlin_adminoffice","kremlin_adminoffice");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_kremlin_breach","kremlin_breach");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_kremlin_monument","kremlin_monument");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_kremlin_ecourtyard","kremlin_ecourtyard");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_kremlin_segallery","kremlin_segallery");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_kremlin_street","kremlin_street");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_kremlin_swgallery","kremlin_swgallery");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_kremlin_wcourt","kremlin_wcourt");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_kremlin_ngallery","kremlin_ngallery");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_kremlin_mainroom","kremlin_mainroom");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_kremlin_tower","kremlin_tower");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_kremlin_bridge","kremlin_bridge");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_kremlin_statue","kremlin_statue");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_kremlin_noverlook","kremlin_noverlook");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_kremlin_soverlook","kremlin_soverlook");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_kremlin_secourtyard","kremlin_secourtyard");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_kremlin_giftshop","kremlin_giftshop");
}

//Function Number: 13
mp_highrise2()
{
	add_bcs_location_mapping("trigger_multiple_bcs_mp_hrise_undrground","hrise_undrground");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_hrise_renbldg","hrise_renbldg");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_hrise_conbldg","hrise_conbldg");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_hrise_sidecrane","hrise_sidecrane");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_hrise_ovrcrane","hrise_ovrcrane");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_hrise_proproof","hrise_proproof");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_hrise_propground","hrise_propground");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_hrise_helopad","hrise_helopad");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_hrise_copter","hrise_copter");
}

//Function Number: 14
mp_climate_3()
{
	add_bcs_location_mapping("trigger_multiple_bcs_mp_cli_by_entr","cli_by_entr");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_cli_bywaterfall","cli_bywaterfall");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_cli_on_bridge","cli_on_bridge");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_cli_nr_br","cli_nr_br");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_cli_under_bridge","cli_under_bridge");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_cli_in_control","cli_in_control");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_cli_in_green","cli_in_green");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_cli_bygreen","cli_bygreen");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_cli_by_helo","cli_by_helo");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_cli_in_nurse","cli_in_nurse");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_cli_on_nur","cli_on_nur");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_cli_in_main","cli_in_main");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_cli_on_main","cli_on_main");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_cli_in_ravine","cli_in_ravine");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_cli_in_sewer","cli_in_sewer");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_cli_roof","cli_roof");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_cli_water","cli_water");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_cli_trees","cli_trees");
}

//Function Number: 15
mp_perplex_1()
{
	add_bcs_location_mapping("trigger_multiple_bcs_mp_per_atrium","per_atrium");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_per_roof","per_roof");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_per_on_gazebo","per_on_gazebo");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_per_in_gazebo","per_in_gazebo");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_per_ngaz","per_ngaz");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_per_on_bwalk","per_on_bwalk");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_per_in_rec","per_in_rec");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_per_by_center","per_by_center");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_per_on_rec","per_on_rec");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_per_in_office","per_in_office");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_per_on_office","per_on_office");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_per_by_office","per_by_office");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_per_in_gym","per_in_gym");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_per_on_gym","per_on_gym");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_per_nr_gym","per_nr_gym");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_per_whale","per_whale");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_per_on_apt","per_on_apt");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_per_in_apt","per_in_apt");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_per_by_apt","per_by_apt");
}

//Function Number: 16
mp_blackbox()
{
	add_bcs_location_mapping("trigger_multiple_bcs_mp_bla_cockpit","bla_cockpit");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_bla_by_cave","bla_by_cave");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_bla_in_cave","bla_in_cave");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_bla_midship","bla_midship");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_bla_cntr_plat","bla_cntr_plat");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_bla_engine","bla_engine");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_bla_cliffs","bla_cliffs");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_bla_wing","bla_wing");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_bla_catwalks","bla_catwalks");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_bla_tail","bla_tail");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_bla_spores","bla_spores");
}

//Function Number: 17
mp_spark()
{
	add_bcs_location_mapping("trigger_multiple_bcs_mp_sprk_train","sprk_train");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_sprk_fluid","sprk_fluid");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_sprk_drop","sprk_drop");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_sprk_rcs","sprk_rcs");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_sprk_scourt","sprk_scourt");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_sprk_aqua","sprk_aqua");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_sprk_ccs","sprk_ccs");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_sprk_ncourt","sprk_ncourt");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_sprk_ecs","sprk_ecs");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_sprk_office","sprk_office");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_sprk_topdep","sprk_topdep");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_sprk_gener","sprk_gener");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_sprk_ship","sprk_ship");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_sprk_security","sprk_security");
}

//Function Number: 18
clowntown_mp()
{
	add_bcs_location_mapping("trigger_multiple_bcs_mp_cltn_officeroof","cltn_officeroof");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_cltn_clownsign","cltn_clownsign");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_cltn_officeint","cltn_officeint");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_cltn_carwash","cltn_carwash");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_cltn_bridge","cltn_bridge");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_cltn_insidehotel","cltn_insidehotel");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_cltn_hotelroof","cltn_hotelroof");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_cltn_cemetery","cltn_cemetery");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_cltn_pool","cltn_pool");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_cltn_bathrooms","cltn_bathrooms");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_cltn_sewer","cltn_sewer");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_cltn_shed","cltn_shed");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_cltn_18wheeler","cltn_18wheeler");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_cltn_dumpster","cltn_dumpster");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_cltn_flatbed","cltn_flatbed");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_cltn_2ndstoryblcny","cltn_2ndstoryblcny");
}

//Function Number: 19
torqued_mp()
{
	add_bcs_location_mapping("trigger_multiple_bcs_mp_trq_tower","trq_tower");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_trq_oncarousel","trq_oncarousel");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_trq_bycarousel","trq_bycarousel");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_trq_upstairstrainstation","trq_upstairstrainstation");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_trq_downtrainstation","trq_downtrainstation");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_trq_ticketbooth","trq_ticketbooth");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_trq_bytrain","trq_bytrain");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_trq_ontrain","trq_ontrain");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_trq_christmastree","trq_christmastree");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_trq_office","trq_office");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_trq_overlook","trq_overlook");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_trq_lodge","trq_lodge");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_trq_skishop","trq_skishop");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_trq_bymarket","trq_bymarket");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_trq_onmarket","trq_onmarket");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_trq_awning","trq_awning");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_trq_snowbank","trq_snowbank");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_trq_snowtrench","trq_snowtrench");
}

//Function Number: 20
lost_mp()
{
	add_bcs_location_mapping("trigger_multiple_bcs_mp_lst_chemspill","lst_chemspill");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_lst_engineroom","lst_engineroom");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_lst_insphere","lst_insphere");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_lst_bysphere","lst_bysphere");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_lst_core","lst_core");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_lst_hallway","lst_hallway");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_lst_inpipe","lst_inpipe");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_lst_bypipe","lst_bypipe");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_lst_inchempool","lst_inchempool");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_lst_bychempool","lst_bychempool");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_lst_wastestorage","lst_wastestorage");
}

//Function Number: 21
mp_urban()
{
	add_bcs_location_mapping("trigger_multiple_bcs_mp_urb_int_tp","urb_int_tp");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_urb_lower_tp","urb_lower_tp");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_urb_back_tp","urb_back_tp");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_urb_int_construct","urb_int_construct");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_urb_lower_construct","urb_lower_construct");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_urb_complex","urb_complex");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_urb_west_complex","urb_west_complex");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_urb_west_complex_window","urb_west_complex_window");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_urb_east_complex","urb_east_complex");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_urb_east_complex_window","urb_east_complex_window");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_urb_plaza","urb_plaza");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_urb_plaza_stairs","urb_plaza_stairs");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_urb_crime_scene","urb_crime_scene");
	add_bcs_location_mapping("trigger_multiple_bcs_mp_urb_back_construct","urb_back_construct");
}