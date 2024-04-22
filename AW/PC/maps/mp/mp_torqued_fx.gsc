/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: mp\mp_torqued_fx.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 20
 * Decompile Time: 341 ms
 * Timestamp: 4/22/2024 2:18:38 AM
*******************************************************************/

//Function Number: 1
main()
{
	level._effect["fire_lp_s_base_no_embers"] = loadfx("vfx/fire/dlc/fire_lp_s_base_no_embers");
	level._effect["electrical_sparks_runner_no_impact_spawn"] = loadfx("vfx/explosion/electrical_sparks_runner_no_impact_spawn");
	level._effect["torqued_flou_flare_02"] = loadfx("vfx/map/mp_torqued/torqued_flou_flare_02");
	level._effect["torqued_flare_light_bulb_spot2"] = loadfx("vfx/lights/mp_torqued/torqued_flare_light_bulb_spot2");
	level._effect["torqued_flou_flare"] = loadfx("vfx/lights/mp_torqued/torqued_flou_flare");
	level._effect["mp_tor_river_mist"] = loadfx("vfx/map/mp_torqued/mp_tor_river_mist");
	level._effect["mp_tor_river_ice_chunks"] = loadfx("vfx/map/mp_torqued/mp_tor_river_ice_chunks");
	level._effect["glow_warm_lantern_lp"] = loadfx("vfx/lights/glow_warm_lantern_lp");
	level._effect["street_light_basic_glow"] = loadfx("vfx/lights/mp_torqued/street_light_basic_glow");
	level._effect["gondola_tower_sprite_light"] = loadfx("vfx/lights/mp_torqued/gondola_tower_sprite_light");
	level._effect["gondola_cabin_sprite_light"] = loadfx("vfx/lights/mp_torqued/gondola_cabin_sprite_light");
	level._effect["mp_tor_avalanche_impact_hide_view"] = loadfx("vfx/map/mp_torqued/mp_tor_avalanche_impact_hide_view");
	level._effect["mp_tor_avalanche_ground_splashes_sm"] = loadfx("vfx/map/mp_torqued/mp_tor_avalanche_ground_splashes_sm");
	level._effect["building_window_shatter_01_no_collision"] = loadfx("vfx/glass/building_window_shatter_01_no_collision");
	level._effect["steam_ambient_vents_light"] = loadfx("vfx/map/mp_dam/steam_ambient_vents_light");
	level._effect["avalanche_snow_wall"] = loadfx("vfx/snow/avalanche_snow_wall");
	level._effect["mp_tor_avalanche_snow_linger"] = loadfx("vfx/map/mp_torqued/mp_tor_avalanche_snow_linger");
	level._effect["mp_tor_avalanche_edge_runoff_2_stop"] = loadfx("vfx/map/mp_torqued/mp_tor_avalanche_edge_runoff_2_stop");
	level._effect["mp_tor_avalanche_edge_runoff_stop"] = loadfx("vfx/map/mp_torqued/mp_tor_avalanche_edge_runoff_stop");
	level._effect["mp_tor_avalanche_street_gust"] = loadfx("vfx/map/mp_torqued/mp_tor_avalanche_street_gust");
	level._effect["mp_tor_avalanche_edge_runoff_2"] = loadfx("vfx/map/mp_torqued/mp_tor_avalanche_edge_runoff_2");
	level._effect["mp_tor_avalanche_edge_runoff"] = loadfx("vfx/map/mp_torqued/mp_tor_avalanche_edge_runoff");
	level._effect["mp_tor_avalanche_ground_splashes"] = loadfx("vfx/map/mp_torqued/mp_tor_avalanche_ground_splashes");
	level._effect["electrical_sparks_runner"] = loadfx("vfx/explosion/electrical_sparks_runner");
	level._effect["mp_tor_avalanche_spill_over"] = loadfx("vfx/map/mp_torqued/mp_tor_avalanche_spill_over");
	level._effect["mp_tor_avalanche_init_snow_blast"] = loadfx("vfx/map/mp_torqued/mp_tor_avalanche_init_snow_blast");
	level._effect["mp_tor_snow_chunks_falling_2"] = loadfx("vfx/map/mp_torqued/mp_tor_snow_chunks_falling_2");
	level._effect["mp_tor_snow_chunks_fall_from_tree"] = loadfx("vfx/map/mp_torqued/mp_tor_snow_chunks_fall_from_tree");
	level._effect["birds_tree_flyout_noleaves"] = loadfx("vfx/animal/birds_tree_flyout_noleaves");
	level._effect["mp_tor_snow_chunks_falling"] = loadfx("vfx/map/mp_torqued/mp_tor_snow_chunks_falling");
	level._effect["falling_snow_lrg_runner"] = loadfx("vfx/snow/falling_snow_lrg_runner");
	level._effect["snow_light_wind_gust_runner"] = loadfx("vfx/snow/snow_light_wind_gust_runner");
	level._effect["snow_fall_particles"] = loadfx("vfx/snow/snow_fall_particles");
	level._effect["mp_torqued_event_hill_snow_i"] = loadfx("vfx/map/mp_torqued/mp_torqued_event_hill_snow_i");
	level._effect["mp_torqued_event_leaves"] = loadfx("vfx/map/mp_torqued/mp_torqued_event_leaves");
	level._effect["mp_torqued_event_metalhit"] = loadfx("vfx/map/mp_torqued/mp_torqued_event_metalhit");
	level._effect["torqued_killstreak_death"] = loadfx("vfx/map/mp_torqued/torqued_killstreak_death");
	level._effect["mp_torqued_electric_trail"] = loadfx("vfx/map/mp_torqued/mp_torqued_electric_trail");
	level._effect["mp_torqued_energy_trail"] = loadfx("vfx/map/mp_torqued/mp_torqued_energy_trail");
	level._effect["charged_shot_2_trail_blue"] = loadfx("vfx/trail/charged_shot_2_trail_blue");
	level._effect["mp_torqued_energy_impact"] = loadfx("vfx/map/mp_torqued/mp_torqued_energy_impact");
	level._effect["mp_torqued_shock_impact"] = loadfx("vfx/map/mp_torqued/mp_torqued_shock_impact");
	level._effect["birds_tree_flyout_sm"] = loadfx("vfx/animal/birds_tree_flyout_sm");
	level._effect["mp_torqued_paper_ground_linger"] = loadfx("vfx/map/mp_torqued/mp_torqued_paper_ground_linger");
	level._effect["fire_crawl_interior_wall_small"] = loadfx("vfx/fire/fire_crawl_interior_wall_small");
	level._effect["pine_needles_blowing"] = loadfx("vfx/wind/pine_needles_blowing");
	level._effect["ground_snow_drifts_flat_lp2"] = loadfx("vfx/snow/ground_snow_drifts_flat_lp2");
	level._effect["mp_torqued_dust_ambient_int"] = loadfx("vfx/map/mp_torqued/mp_torqued_dust_ambient_int");
	level._effect["dust_particles_sml"] = loadfx("vfx/dust/dust_particles_sml");
	level._effect["car_exhaust_winter"] = loadfx("vfx/smoke/car_exhaust_winter");
	level._effect["mail_blowing_04_looping"] = loadfx("vfx/wind/mail_blowing_04_looping");
	level._effect["bird_vulture_circle_runner_less"] = loadfx("vfx/animal/bird_vulture_circle_runner_less");
	level._effect["mp_gb_sparks_runner"] = loadfx("vfx/map/mp_greenband/mp_gb_sparks_runner");
	level._effect["mp_torqued_steam_int_vent"] = loadfx("vfx/map/mp_torqued/mp_torqued_steam_int_vent");
	level._effect["light_glow_white_square"] = loadfx("vfx/lights/global/light_glow_white_square");
	level._effect["mp_gb_light_uplight"] = loadfx("vfx/map/mp_torqued/mp_torqued_light_uplight");
	level._effect["trash_tornado_s_runner"] = loadfx("vfx/wind/trash_tornado_s_runner");
	level._effect["pine_needles_fall_2"] = loadfx("vfx/wind/pine_needles_fall_2");
	level._effect["steam_sm_street_cold"] = loadfx("vfx/steam/steam_sm_street_cold");
	level._effect["light_godray_torqued_train_01"] = loadfx("vfx/lights/light_godray_torqued_train_01");
	level._effect["mp_torqued_steam_int"] = loadfx("vfx/map/mp_torqued/mp_torqued_steam_int");
	level._effect["snow_blown_off_rocks_lp"] = loadfx("vfx/snow/snow_blown_off_rocks_lp");
	level._effect["mp_torqued_chimney"] = loadfx("vfx/map/mp_torqued/mp_torqued_chimney");
	level._effect["fire_lp_s_base"] = loadfx("vfx/fire/dlc/fire_lp_s_base");
	level._effect["lgtfix_construction_barrel_light"] = loadfx("vfx/lights/lgt_fixtures/lgtfix_construction_barrel_light");
	if(level.nextgen)
	{
		thread window_broken_hide_fx();
	}
}

//Function Number: 2
roof_falling_snow_chunk_fx()
{
	var_00 = level.dyneventavalanche.avalanchephase1time + level.dyneventavalanche.avalanchephase2time + level.dyneventavalanche.avalanchephase3time;
	wait 0.05;
	activateclientexploder(200);
	wait(var_00);
	stopclientexploder(200);
}

//Function Number: 3
snow_edge_runoff_fx()
{
	wait(1);
	activateclientexploder(202);
	wait(10);
	stopclientexploder(202);
}

//Function Number: 4
avalanche_fx()
{
	wait 0.05;
	activateclientexploder(199);
}

//Function Number: 5
avalanche_treeline_impact_fx()
{
	var_00 = level.dyneventavalanche.avalanchephase1time + level.dyneventavalanche.avalanchephase2time;
	wait 0.05;
	activateclientexploder(201);
	wait(var_00);
	stopclientexploder(201);
}

//Function Number: 6
avalanche_impact_fx()
{
	wait(9);
	activateclientexploder(204);
	wait(3);
	stopclientexploder(204);
	wait 0.05;
	activateclientexploder(210);
	wait(5);
	stopclientexploder(210);
}

//Function Number: 7
avalanche_hide_geo_fx()
{
	wait 0.05;
	activateclientexploder(211);
	wait(2);
	stopclientexploder(211);
}

//Function Number: 8
alley_snow_fx()
{
	wait(2);
	activateclientexploder(203);
	wait(7);
	stopclientexploder(203);
}

//Function Number: 9
electrical_spark_fx()
{
	var_00 = level.dyneventavalanche.avalanchephase1time + level.dyneventavalanche.avalanchephase2time + level.dyneventavalanche.avalanchephase3time;
	wait(var_00);
	activateclientexploder(205);
}

//Function Number: 10
snow_edge_runoff_stop_fx()
{
	var_00 = level.dyneventavalanche.avalanchephase1time + level.dyneventavalanche.avalanchephase2time + level.dyneventavalanche.avalanchephase3time;
	wait(var_00);
	activateclientexploder(206);
	wait(20);
	stopclientexploder(206);
}

//Function Number: 11
avalanche_snow_linger_fx()
{
	var_00 = level.dyneventavalanche.avalanchephase1time + level.dyneventavalanche.avalanchephase2time + level.dyneventavalanche.avalanchephase3time;
	wait(3);
	activateclientexploder(207);
	wait(30);
	stopclientexploder(207);
}

//Function Number: 12
window_broken_hide_fx()
{
	wait 0.05;
	var_00 = getentarray("window_broken","targetname");
	foreach(var_02 in var_00)
	{
		var_02 hide();
	}
}

//Function Number: 13
window_swap_fx()
{
	wait 0.05;
	var_00 = getentarray("window_intact","targetname");
	activateclientexploder(209);
	foreach(var_02 in var_00)
	{
		var_02 thread hide_window_script_delay();
	}
}

//Function Number: 14
hide_window_script_delay()
{
	wait(self.script_delay + 0.06);
	self hide();
}

//Function Number: 15
coffee_window_back_shatter()
{
	wait(0.25);
	var_00 = getglassarray("coffee_windows_back");
	foreach(var_02 in var_00)
	{
		var_03 = (-1115,478,1059);
		var_04 = getglassorigin(var_02);
		var_05 = var_04 - var_03;
		destroyglass(var_02,var_05);
	}
}

//Function Number: 16
coffee_window_front_shatter()
{
	wait(10.5);
	var_00 = getglassarray("coffee_windows_front");
	foreach(var_02 in var_00)
	{
		var_03 = (-1124,-91,951);
		var_04 = getglassorigin(var_02);
		var_05 = var_04 - var_03;
		destroyglass(var_02,var_05);
	}
}

//Function Number: 17
trq_window_front_shatter()
{
	wait(10.6);
	var_00 = getglassarray("trq_windows_front");
	foreach(var_02 in var_00)
	{
		var_03 = (-602,158,930);
		var_04 = getglassorigin(var_02);
		var_05 = var_04 - var_03;
		destroyglass(var_02,var_05);
	}
}

//Function Number: 18
boardstore_window_back_shatter()
{
	wait(0.4);
	var_00 = getglassarray("boardstore_windows_back");
	foreach(var_02 in var_00)
	{
		var_03 = (487,253,1143);
		var_04 = getglassorigin(var_02);
		var_05 = var_04 - var_03;
		destroyglass(var_02,var_05);
	}
}

//Function Number: 19
boardstore_window_front_shatter()
{
	wait(10.9);
	var_00 = getglassarray("boardstore_windows_front");
	foreach(var_02 in var_00)
	{
		var_03 = (400,128,1060);
		var_04 = getglassorigin(var_02);
		var_05 = var_04 - var_03;
		destroyglass(var_02,var_05);
	}
}

//Function Number: 20
lodge_window_front_shatter()
{
	wait(12.2);
	var_00 = getglassarray("lodge_windows_front");
	foreach(var_02 in var_00)
	{
		var_03 = (1566,243,947);
		var_04 = getglassorigin(var_02);
		var_05 = var_04 - var_03;
		destroyglass(var_02,var_05);
	}
}