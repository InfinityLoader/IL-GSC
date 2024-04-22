/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: mp\mp_refraction_fx.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 6
 * Decompile Time: 129 ms
 * Timestamp: 4/22/2024 2:18:17 AM
*******************************************************************/

//Function Number: 1
main()
{
	level._effect["mp_ref_panel_lightray_lrg_nomist"] = loadfx("vfx/map/mp_refraction/mp_ref_panel_lightray_lrg_nomist");
	level._effect["falling_water_exterior_wide_near"] = loadfx("vfx/water/falling_water_exterior_wide_near");
	level._effect["rain_splash_sm_150x150_lp"] = loadfx("vfx/rain/rain_splash_sm_150x150_lp");
	level._effect["mp_ref_vista_lights"] = loadfx("vfx/map/mp_refraction/mp_ref_vista_lights");
	level._effect["falling_water_drip_central_fast"] = loadfx("vfx/water/falling_water_drip_central_fast");
	level._effect["turretUP_effect"] = loadfx("vfx/map/mp_refraction/mp_ref_turret_steam");
	level._effect["turretUP_effect2"] = loadfx("vfx/map/mp_refraction/mp_ref_turret_sparks");
	level._effect["lightning"] = loadfx("vfx/map/mp_refraction/lightning_mp_refraction");
	level._effect["rain_splash_sm_100x100_lp"] = loadfx("vfx/rain/rain_splash_sm_100x100_lp");
	level._effect["rain_splash_sm_200x200_lp"] = loadfx("vfx/rain/rain_splash_sm_200x200_lp");
	level._effect["rain_streak_highlights_1kx1k_lp"] = loadfx("vfx/rain/rain_streak_highlights_1kx1k_lp");
	level._effect["roof_edge_rain_mist_lp"] = loadfx("vfx/water/roof_edge_rain_mist_lp");
	level._effect["roof_edge_rain_mist_2_lp"] = loadfx("vfx/water/roof_edge_rain_mist_2_lp");
	level._effect["roof_edge_rain_mist_lrg_lp"] = loadfx("vfx/water/roof_edge_rain_mist_lrg_lp");
	level._effect["wind_gust_water_mist_distant_lrg"] = loadfx("vfx/wind/wind_gust_water_mist_distant_lrg");
	level._effect["falling_water_exterior_wide"] = loadfx("vfx/water/falling_water_exterior_wide");
	level._effect["falling_water_low_narrow_2"] = loadfx("vfx/water/falling_water_low_narrow_2");
	level._effect["water_runoff_narrow_splashes_lp"] = loadfx("vfx/rain/water_runoff_narrow_splashes_lp");
	level._effect["steam_column_rising"] = loadfx("vfx/steam/steam_column_rising");
	level._effect["rain_floorsheet_fast_600x200_lp"] = loadfx("vfx/rain/rain_floorsheet_fast_600x200_lp");
	level._effect["rain_floorsheet_fast_200x200_lp"] = loadfx("vfx/rain/rain_floorsheet_fast_200x200_lp");
	level._effect["mp_ref_elev_rain_inner"] = loadfx("vfx/map/mp_refraction/mp_ref_elev_rain_inner");
	level._effect["mp_ref_elev_rain_outer"] = loadfx("vfx/map/mp_refraction/mp_ref_elev_rain_outer");
	level._effect["steam_cylinder_lrg"] = loadfx("vfx/steam/steam_cylinder_lrg");
	level._effect["steam_pipe_burst_lp_sm"] = loadfx("vfx/steam/steam_pipe_burst_lp_sm");
	level._effect["water_edge_runoff_wide"] = loadfx("vfx/water/water_edge_runoff_wide");
	level._effect["water_edge_runoff_short"] = loadfx("vfx/water/water_edge_runoff_short");
	level._effect["rain_streaks_in_lt_sphere_flare"] = loadfx("vfx/rain/rain_streaks_in_lt_sphere_flare");
	level._effect["mp_ref_distant_lightning"] = loadfx("vfx/map/mp_refraction/mp_ref_distant_lightning");
	level._effect["mp_ref_distant_lightning_bolt"] = loadfx("vfx/map/mp_refraction/mp_ref_distant_lightning_bolt");
	level._effect["lt_soft_cool_glow"] = loadfx("vfx/lights/lt_soft_cool_glow");
	level._effect["mp_ref_elev_descend_sparks"] = loadfx("vfx/map/mp_refraction/mp_ref_elev_descend_sparks");
	level._effect["light_lock_light"] = loadfx("vfx/map/mp_refraction/mp_refraction_lock_light");
	level._effect["light_lock_light_spot"] = loadfx("vfx/map/mp_refraction/mp_refraction_lock_light_spot");
	level._effect["light_red_strobe_02"] = loadfx("vfx/lights/light_red_strobe_02");
	level._effect["mp_ref_elev_steam_release"] = loadfx("vfx/map/mp_refraction/mp_ref_elev_steam_release");
	level._effect["electrical_sparks_runner"] = loadfx("vfx/explosion/electrical_sparks_runner");
	level._effect["electrical_sparks_runner_2sec_30x30"] = loadfx("vfx/explosion/electrical_sparks_runner_2sec_30x30");
	level._effect["mp_ref_turret_steam_off"] = loadfx("vfx/map/mp_refraction/mp_ref_turret_steam_off");
	level._effect["steam_column_sm"] = loadfx("vfx/steam/steam_column_sm");
	level._effect["falling_water_wide_long_no_dist"] = loadfx("vfx/water/falling_water_wide_long_no_dist");
	level._effect["rain_splash_sm_80x6_lp"] = loadfx("vfx/rain/rain_splash_sm_80x6_lp");
	level._effect["rain_splash_sm_20x20_no_dist_lp"] = loadfx("vfx/rain/rain_splash_sm_20x20_no_dist_lp");
	level._effect["falling_water_narrow_long_no_dist"] = loadfx("vfx/water/falling_water_narrow_long_no_dist");
	level._effect["mp_ref_elevator_clouds"] = loadfx("vfx/map/mp_refraction/mp_ref_elevator_clouds");
	level._effect["tower_light_glow_red_steady"] = loadfx("vfx/lights/tower_light_glow_red_steady");
	level._effect["mp_ref_elev_water_trail"] = loadfx("vfx/map/mp_refraction/mp_ref_elev_water_trail");
	level._effect["steam_elev_landing_rise"] = loadfx("vfx/steam/steam_elev_landing_rise");
	level._effect["steam_elev_landing_crawl"] = loadfx("vfx/steam/steam_elev_landing_crawl");
	level._effect["soft_blue_omni_glow"] = loadfx("vfx/lensflare/soft_blue_omni_glow");
	level._effect["soft_red_omni_glow_light"] = loadfx("vfx/lights/mp_ref_soft_red_omni_glow_light");
	level._effect["elevator_shaft_lt_pulse"] = loadfx("vfx/lights/elevator_shaft_lt_pulse");
	level._effect["emergency_lt_red_off"] = loadfx("vfx/lights/emergency_lt_red_off");
	level._effect["emergency_lt_red_on"] = loadfx("vfx/lights/emergency_lt_red_on");
	level._effect["emergency_lt_red_pulse"] = loadfx("vfx/lights/emergency_lt_red_pulse");
	level._effect["sparks_burst_b"] = loadfx("vfx/explosion/sparks_burst_b");
	level._effect["steam_pipe_burst_thin"] = loadfx("vfx/steam/steam_pipe_burst_thin");
	level._effect["light_red_pulse_fast"] = loadfx("vfx/lights/light_red_pulse_fast");
	level._effect["rain_hilight_cylinder"] = loadfx("vfx/rain/rain_hilight_cylinder");
	level._effect["rain_hilight_long_volume"] = loadfx("vfx/rain/rain_hilight_long_volume");
	level._effect["mp_ref_light_fire_alarm_strobe_runner"] = loadfx("vfx/map/mp_refraction/mp_ref_light_fire_alarm_strobe_runner");
	level._effect["steam_sm_vent"] = loadfx("vfx/steam/steam_sm_vent");
	level._effect["rain_volume_windy"] = loadfx("vfx/rain/rain_volume_windy");
	level._effect["steam_sm_vent_slow"] = loadfx("vfx/steam/steam_sm_vent_slow");
	level._effect["mp_ref_ocean_fog"] = loadfx("vfx/map/mp_refraction/mp_ref_ocean_fog");
	level._effect["emergency_lt_red_pulse_lp"] = loadfx("vfx/lights/emergency_lt_red_pulse_lp");
	level._effect["mp_ref_mechanism_steam_light"] = loadfx("vfx/map/mp_refraction/mp_ref_mechanism_steam_light");
	level._effect["elevator_shaft_steam_light"] = loadfx("vfx/lights/elevator_shaft_steam_light");
	level._effect["mp_ref_panel_lightray_sm"] = loadfx("vfx/map/mp_refraction/mp_ref_panel_lightray_sm");
	level._effect["mp_ref_panel_lightray_lrg"] = loadfx("vfx/map/mp_refraction/mp_ref_panel_lightray_lrg");
	level._effect["mp_ref_rain_screen_splashes"] = loadfx("vfx/map/mp_refraction/mp_ref_rain_screen_splashes");
	level._effect["mp_ref_elev_single_lightray_1"] = loadfx("vfx/map/mp_refraction/mp_ref_elev_single_lightray_1");
	level._effect["mp_ref_elev_cylinderframe_lightray"] = loadfx("vfx/map/mp_refraction/mp_ref_elev_cylinderframe_lightray");
	level._effect["mp_ref_elev_frame_lightray"] = loadfx("vfx/map/mp_refraction/mp_ref_elev_frame_lightray");
	level._effect["mp_ref_door_decompress"] = loadfx("vfx/map/mp_refraction/mp_ref_door_decompress");
	level._effect["shutter_opening_steam"] = loadfx("vfx/steam/shutter_opening_steam");
	level._effect["mp_ref_elev_spring_steam"] = loadfx("vfx/map/mp_refraction/mp_ref_elev_spring_steam");
	level._effect["mp_ref_mech_arm_back_lights_pulse"] = loadfx("vfx/map/mp_refraction/mp_ref_mech_arm_back_lights_pulse");
	level._effect["mp_ref_mech_arm_lights_pulse"] = loadfx("vfx/map/mp_refraction/mp_ref_mech_arm_lights_pulse");
	level._effect["mp_ref_mech_arm_back_lights_on"] = loadfx("vfx/map/mp_refraction/mp_ref_mech_arm_back_lights_on");
	level._effect["mp_ref_mech_arm_lights_on"] = loadfx("vfx/map/mp_refraction/mp_ref_mech_arm_lights_on");
	level._effect["steam_wide_vent_burst"] = loadfx("vfx/steam/steam_wide_vent_burst");
	level._effect["mp_ref_elev_ascent_trail"] = loadfx("vfx/map/mp_refraction/mp_ref_elev_ascent_trail");
	level._effect["mp_ref_elev_descent_trail"] = loadfx("vfx/map/mp_refraction/mp_ref_elev_descent_trail");
	level._effect["rain_splash_sm_50x50_lp"] = loadfx("vfx/rain/rain_splash_sm_50x50_lp");
	level._effect["vehicle_damaged_sparks_l"] = loadfx("vfx/sparks/vehicle_damaged_sparks_l");
	level._effect["mp_ref_elev_cloud_opening"] = loadfx("vfx/map/mp_refraction/mp_ref_elev_cloud_opening");
	level._effect["mp_ref_elev_window_steam"] = loadfx("vfx/map/mp_refraction/mp_ref_elev_window_steam");
	level._effect["steam_cylinder_dissipate_near"] = loadfx("vfx/steam/steam_cylinder_dissipate_near");
	level._effect["steam_floor_dissipate_near"] = loadfx("vfx/steam/steam_floor_dissipate_near");
	level._effect["steam_hallway_dissipate"] = loadfx("vfx/steam/steam_hallway_dissipate");
	level._effect["steam_pipe_burst_near"] = loadfx("vfx/steam/steam_pipe_burst_near");
	thread lightning_bolt_fx();
	maps\mp\_utility::delaythread(0.1,::warning_sign_hide_fx);
}

//Function Number: 2
cleanout_unneeded_ents_for_createfx()
{
	var_00 = getentarray("elevator2","targetname");
	var_01 = 1;
	foreach(var_03 in var_00)
	{
		if(var_01)
		{
			var_01 = 0;
			continue;
		}

		var_03 delete();
	}

	var_05 = getentarray("elevator_ascend","targetname");
	var_01 = 1;
	foreach(var_03 in var_05)
	{
		if(var_01)
		{
			var_01 = 0;
			continue;
		}

		var_03 delete();
	}
}

//Function Number: 3
mechanism_center_lights_event_fx()
{
	wait(2);
}

//Function Number: 4
warning_sign_hide_fx()
{
	var_00 = getentarray("warning_signs","targetname");
	foreach(var_02 in var_00)
	{
		var_02 hide();
	}
}

//Function Number: 5
warning_sign_show_fx()
{
	var_00 = getentarray("warning_signs","targetname");
	foreach(var_02 in var_00)
	{
		var_02 show();
	}

	level thread common_scripts\_exploder::activate_clientside_exploder(210);
}

//Function Number: 6
lightning_bolt_fx()
{
	for(;;)
	{
		wait(randomfloatrange(2,6));
		var_00 = 220 + randomint(8);
		activateclientexploder(var_00);
	}
}