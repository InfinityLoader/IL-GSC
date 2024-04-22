/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: greece_fx.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 3
 * Decompile Time: 69 ms
 * Timestamp: 4/22/2024 2:31:04 AM
*******************************************************************/

//Function Number: 1
main()
{
	level._effect["greece_fishtank_bubbles"] = loadfx("vfx/water/greece_fishtank_bubbles");
	precachefx();
	if(!getdvarint("r_reflectionProbeGenerate"))
	{
		maps\createfx\greece_fx::main();
		maps\_shg_fx::setup_shg_fx();
		thread maps\_shg_fx::fx_zone_watcher(5000,"msg_fx_zone5000");
		thread maps\_shg_fx::fx_zone_watcher(6000,"msg_fx_zone6000");
		thread maps\_shg_fx::fx_zone_watcher(7000,"msg_fx_zone7000");
		thread maps\_shg_fx::fx_zone_watcher(8000,"msg_fx_zone8000");
	}
}

//Function Number: 2
precachefx()
{
	level._effect["water_tower_steam"] = loadfx("vfx/map/greece/water_tower_steam");
	level._effect["greece_lobstertank_splash_child"] = loadfx("vfx/water/greece_lobstertank_splash_child");
	level._effect["greece_lobstertank_splash_des"] = loadfx("vfx/water/greece_lobstertank_splash_des");
	level._effect["greece_fountain_splash_lrg"] = loadfx("vfx/water/greece_fountain_splash_lrg");
	level._effect["greece_fountain_splash_sml"] = loadfx("vfx/water/greece_fountain_splash_sml");
	level._effect["light_yellow_fill"] = loadfx("vfx/lights/greece/light_yellow_fill");
	level._effect["light_white_flicker"] = loadfx("vfx/lights/greece/light_white_flicker");
	level._effect["light_flare_spot_small"] = loadfx("vfx/map/greece/greece_flare_light_bulb_spot");
	level._effect["light_flare_spot_small2"] = loadfx("vfx/map/greece/greece_flare_light_bulb_spot2");
	level._effect["light_flare_spot_small_crevice"] = loadfx("vfx/map/greece/greece_flare_light_bulb_spot_crevice");
	level._effect["flare_light_pulse_blue_dim"] = loadfx("vfx/map/greece/greece_light_pulse_blue_dim");
	level._effect["flare_light_blue_dim"] = loadfx("vfx/map/greece/greece_flare_light_blue_dim");
	level._effect["destp_penholder_dyndst"] = loadfx("vfx/destructible/destp_penholder_dyndst");
	level._effect["distortion_drone_fisheye_lens"] = loadfx("vfx/distortion/distortion_drone_fisheye_lens");
	level._effect["godray_ambient_grates_small"] = loadfx("vfx/map/greece/godray_ambient_grates_sm");
	level._effect["godray_ambient_grates_med"] = loadfx("vfx/map/greece/godray_ambient_grates_med");
	level._effect["godray_ambient_grates_large"] = loadfx("vfx/map/greece/godray_ambient_grates_large");
	level._effect["godray_ambient_outdoors_med"] = loadfx("vfx/map/greece/godray_ambient_outdoors_med");
	level._effect["godray_ambient_outdoors2_med"] = loadfx("vfx/map/greece/godray_ambient_outdoors2_med");
	level._effect["godray_ambient_outdoors_large"] = loadfx("vfx/map/greece/godray_ambient_outdoors_large");
	level._effect["godray_foliage_med"] = loadfx("vfx/map/greece/godray_foliage_med");
	level._effect["godray_foliage_large"] = loadfx("vfx/map/greece/godray_foliage_large");
	level._effect["godray_foliage_large_short"] = loadfx("vfx/map/greece/godray_foliage_large_short");
	level._effect["godray_window_small_short"] = loadfx("vfx/map/greece/godray_window_small_short");
	level._effect["godray_window_small_short_particles"] = loadfx("vfx/map/greece/godray_window_small_short_particles");
	level._effect["godray_window_small_narrow"] = loadfx("vfx/map/greece/godray_window_small_narrow");
	level._effect["glow_window_ambient_small"] = loadfx("vfx/map/greece/greece_window_glow_ambient_small");
	level._effect["glow_window_ambient_small2"] = loadfx("vfx/map/greece/greece_window_glow_ambient_small2");
	level._effect["glow_window_ambient_crevice"] = loadfx("vfx/map/greece/greece_window_glow_ambient_crevice");
	level._effect["glow_window_ambient_crevice2"] = loadfx("vfx/map/greece/greece_window_glow_ambient_crevice2");
	level._effect["glow_window_ambient_med"] = loadfx("vfx/map/greece/greece_window_glow_ambient_med");
	level._effect["glow_window_ambient_med2"] = loadfx("vfx/map/greece/greece_window_glow_ambient_med2");
	level._effect["glow_computer_red_blink"] = loadfx("vfx/lights/computer_light_red_blink_xsmall");
	level._effect["glow_computer_green_blink"] = loadfx("vfx/lights/computer_light_green_blink_xsmall");
	level._effect["glow_computer_blue_blink"] = loadfx("vfx/lights/computer_light_blue_blink_xsmall");
	level._effect["glow_bulb_1"] = loadfx("vfx/map/greece/greece_flare_light_bulb_1");
	level._effect["glow_bulb_2_cc"] = loadfx("vfx/map/greece/greece_flare_light_bulb_2_cc");
	level._effect["glow_bulb_3_cc"] = loadfx("vfx/map/greece/greece_flare_light_bulb_3_cc");
	level._effect["glow_bulb_4_cc"] = loadfx("vfx/map/greece/greece_flare_light_bulb_4_cc");
	level._effect["light_cuc_monitor_1"] = loadfx("vfx/lights/light_spot_cuc_monitor_1");
	level._effect["light_cuc_monitor_2_med"] = loadfx("vfx/lights/light_spot_cuc_monitor_2_med");
	level._effect["light_beacon_rotate_red"] = loadfx("vfx/lights/light_red_rotate_01");
	level._effect["light_area_fill_01"] = loadfx("vfx/lights/greece/light_area_fill_small_01");
	level._effect["clouds_ambient_lg_orientedb"] = loadfx("vfx/map/greece/ambient_cloud_mist_lg_orientedb");
	level._effect["clouds_ambient_lg_orienteda"] = loadfx("vfx/map/greece/ambient_cloud_mist_lg_orienteda");
	level._effect["clouds_ambient_lg_oriented2b"] = loadfx("vfx/map/greece/ambient_cloud_mist_lg_oriented2b");
	level._effect["clouds_ambient_lg_oriented2a"] = loadfx("vfx/map/greece/ambient_cloud_mist_lg_oriented2a");
	level._effect["clouds_ambient_vista_fog"] = loadfx("vfx/map/greece/ambient_cloud_fog_layer_1");
	level._effect["clouds_ambient_local_fog"] = loadfx("vfx/map/greece/ambient_cloud_fog_area_local");
	level._effect["clouds_ambient_lg_top"] = loadfx("vfx/map/greece/ambient_cloud_mist_lg_top");
	level._effect["clouds_ambient_lg_top_rays"] = loadfx("vfx/map/greece/ambient_cloud_mist_lg_top_rays");
	level._effect["clouds_ambient_lg_top_shadow"] = loadfx("vfx/map/greece/ambient_cloud_mist_lg_top_shadow");
	level._effect["clouds_ambient_lg_oriented2_cc"] = loadfx("vfx/map/greece/ambient_cloud_mist_lg_oriented2_cc");
	level._effect["dust_ambient_interior"] = loadfx("vfx/map/greece/dust_ambient_interior");
	level._effect["dust_ambient_street"] = loadfx("vfx/map/greece/dust_ambient_street");
	level._effect["dust_ambient_street_blowing"] = loadfx("vfx/map/greece/dust_ambient_street_blowing_runner");
	level._effect["wind_gust_particles"] = loadfx("vfx/wind/ambient_wind_particles");
	level._effect["wind_gust_particles_distant"] = loadfx("vfx/wind/ambient_wind_particles_distant");
	level._effect["steam_chimney_small"] = loadfx("vfx/steam/steam_chimney_breeze_small");
	level._effect["ac_fan_distortion"] = loadfx("vfx/map/greece/ac_fan_distortion");
	level._effect["foliage_ambient_wind"] = loadfx("vfx/wind/ambient_foliage_runner");
	level._effect["foliage_ambient_leaves"] = loadfx("vfx/wind/ambient_wind_leaves_runner");
	level._effect["foliage_rolling_leaves"] = loadfx("vfx/wind/ambient_rolling_ground_leaves");
	level._effect["animal_fruitflies_flying"] = loadfx("vfx/animal/insects_fruitflies_flying");
	level._effect["animal_seagulls_flock_large_flying"] = loadfx("vfx/animal/bird_seagull_flock_flying_runner");
	level._effect["waterfall_wide"] = loadfx("vfx/water/falling_water_exterior_wide");
	level._effect["waterfall_wide_short"] = loadfx("vfx/water/falling_water_exterior_short_wide");
	level._effect["waterfall_wide_splash"] = loadfx("vfx/map/greece/greece_waterfall_splash_medium");
	level._effect["waterfall_splash_flow_small"] = loadfx("vfx/map/greece/greece_waterfall_splash_flow_small");
	level._effect["ocean_wave_runner"] = loadfx("vfx/map/greece/greece_ocean_wave_runner");
	level._effect["ocean_splash_runner"] = loadfx("vfx/map/greece/greece_ocean_splash_runner");
	level._effect["mirage_distortion_medium"] = loadfx("vfx/distortion/heat_distortion_mirage_med");
	level._effect["water_drip_single"] = loadfx("vfx/water/falling_water_drip_line_sm_runner_fast");
	level._effect["water_gutter_flow_slow"] = loadfx("vfx/water/water_flow_rain_gutter_slow_small");
	level._effect["water_gutter_splash"] = loadfx("vfx/water/water_flow_rain_gutter_splash_sm_loop");
	level._effect["water_gutter_splash2"] = loadfx("vfx/water/water_flow_rain_gutter_splash2_sm_loop");
	level._effect["smoke_grenade_emitter"] = loadfx("vfx/map/greece/greece_smoke_grenade_emitter_white");
	level._effect["boat_waves_speedboat_circle"] = loadfx("vfx/water/boat_waves_speedboat_circle");
	level._effect["boat_waves_speedboat_greece"] = loadfx("vfx/water/boat_waves_speedboat_greece");
	level._effect["sunflare"] = loadfx("vfx/lensflare/fx_sunflare_greece_2");
	level._effect["sunflare_dim"] = loadfx("vfx/lensflare/fx_sunflare_greece_dim");
	level._effect["blood_impact_splat"] = loadfx("vfx/map/greece/greece_flesh_impact_blood_splat_ap");
	level._effect["blood_impact_splat_sm"] = loadfx("vfx/map/greece/greece_flesh_blood_no_splash");
	level._effect["tablet_touch_green"] = loadfx("vfx/map/greece/greece_tablet_touch_green");
	level._effect["tablet_touch_green2"] = loadfx("vfx/map/greece/greece_tablet_touch_green2");
	level._effect["tablet_touch_red"] = loadfx("vfx/map/greece/greece_tablet_touch_red");
	level._effect["tablet_touch_red2"] = loadfx("vfx/map/greece/greece_tablet_touch_red2");
	level._effect["na45_beacon"] = loadfx("vfx/test/na45_beacon");
	level._effect["broom_sweeping_dust"] = loadfx("vfx/map/greece/greece_broom_sweep_dust");
	level._effect["safehouse_dust_trail_drag"] = loadfx("vfx/map/greece/greece_dust_trail_drag");
	level._effect["safehouse_character_dust_impact"] = loadfx("vfx/map/greece/greece_character_dust_impact");
	level._effect["safehouse_character_dust_impact2"] = loadfx("vfx/map/greece/greece_character_dust_impact2");
	level._effect["safehouse_character_dust_impact3"] = loadfx("vfx/map/greece/greece_character_dust_impact3");
	level._effect["ending_door_dust_impact"] = loadfx("vfx/map/greece/greece_door_dust_impact");
	level._effect["safehouse_drone_prep_dustoff"] = loadfx("vfx/map/greece/greece_debris_dust_off_xsm");
	level._effect["safehouse_drone_prep_dust_impact"] = loadfx("vfx/map/greece/greece_debris_dust_impact_xsm");
	level._effect["safehouse_drone_draft_plants"] = loadfx("vfx/map/greece/greece_drone_draft_plants_runner");
	level._effect["playing_cards_flying_01"] = loadfx("vfx/props/playing_cards_flying_01");
	level._effect["gate_bashing_burst"] = loadfx("vfx/map/greece/greece_safehouse_gate_burst");
	level._effect["gate_bashing_burst_hinges"] = loadfx("vfx/map/greece/greece_safehouse_gate_burst_hinges");
	level._effect["gate_bashing_burst_ceiling"] = loadfx("vfx/map/greece/greece_safehouse_gate_burst_ceiling");
	level._effect["gate_bashing_burst_ceiling2"] = loadfx("vfx/map/greece/greece_safehouse_gate_burst_ceiling2");
	level._effect["cc_blood_pool_water"] = loadfx("vfx/map/greece/greece_blood_pool_water");
	level._effect["cc_building_character_water_drip_runner"] = loadfx("vfx/map/greece/greece_water_soaked_drip_runner");
	level._effect["cc_building_water_splash"] = loadfx("vfx/water/water_object_impact_splash_light");
	level._effect["cc_building_explosion_main"] = loadfx("vfx/map/greece/greece_explosion_cc_runner");
	level._effect["cc_building_explosion_fire"] = loadfx("vfx/map/greece/greece_fire_ground_03");
	level._effect["cc_building_explosion_fire_lg"] = loadfx("vfx/map/greece/greece_fire_ground_03_lg");
	level._effect["cc_building_explosion_smoke_large"] = loadfx("vfx/map/greece/greece_explosion_cc_stg03");
	level._effect["cc_building_explosion_smoke_small"] = loadfx("vfx/map/greece/greece_explosion_cc_stg03a");
	level._effect["cc_building_explosion_smoke_xlarge"] = loadfx("vfx/map/greece/greece_explosion_cc_stg03_lg");
	level._effect["cc_building_explosion_smoke_xlarge_a"] = loadfx("vfx/map/greece/greece_explosion_cc_stg03a_lg");
	level._effect["cc_building_explosion_burst_1"] = loadfx("vfx/map/greece/greece_explosion_cc_burst1_lg");
	level._effect["cc_building_explosion_burst_2"] = loadfx("vfx/map/greece/greece_explosion_cc_burst2");
	level._effect["cc_building_explosion_burst_2a"] = loadfx("vfx/map/greece/greece_explosion_cc_burst2a");
	level._effect["cc_building_explosion_burst_2b"] = loadfx("vfx/map/greece/greece_explosion_cc_burst2b");
	level._effect["cc_building_explosion_roof_shock"] = loadfx("vfx/map/greece/greece_cc_roof_shock");
	level._effect["cc_building_explosion_glass_shock"] = loadfx("vfx/map/greece/greece_cc_glass_shock");
	level._effect["cc_building_explosion_glass_shock2"] = loadfx("vfx/map/greece/greece_cc_glass_shock2");
	level._effect["cc_building_explosion_glass_shock3"] = loadfx("vfx/map/greece/greece_cc_glass_shock3");
	level._effect["cc_building_explosion_glass_shatter"] = loadfx("vfx/map/greece/greece_cc_glass_shatter");
	level._effect["cc_building_smoke_window_small"] = loadfx("vfx/map/greece/greece_interior_smoke_window_sm");
	level._effect["cc_building_smoke_window_large"] = loadfx("vfx/map/greece/greece_interior_smoke_window_lg");
	level._effect["cc_building_smoke_filler"] = loadfx("vfx/map/greece/greece_interior_smoke_filler");
	level._effect["cc_building_gate_breach_explosion"] = loadfx("vfx/map/greece/greece_gate_breach_explosion");
	level._effect["cc_building_mute_charge_burst"] = loadfx("vfx/map/greece/greece_mute_charge_burst");
	level._effect["cc_building_explosion_papers"] = loadfx("vfx/wind/paper_sheet_explosion_blown_1");
	level._effect["civ_group_idle_runner_light"] = loadfx("vfx/unique/civ_group_idle_runner_light");
	level._effect["window_glass_shatter"] = loadfx("vfx/map/greece/greece_window_glass_shatter");
	level._effect["window_glass_shatter2"] = loadfx("vfx/map/greece/greece_window_glass_shatter2");
	level._effect["railgun_impact_burst1"] = loadfx("vfx/map/greece/greece_railgun_impact_burst_debris");
	level._effect["railgun_projectile_trail"] = loadfx("vfx/map/greece/greece_sniper_railgun_tracer");
	level._effect["water_splash_debris"] = loadfx("vfx/map/greece/greece_water_firehydrant_splash2");
	level._effect["sniper_tower_explosion_main"] = loadfx("vfx/map/greece/greece_explosion_sniper_tower_stg1");
	level._effect["sniper_tower_explosion_burst"] = loadfx("vfx/map/greece/greece_explosion_sniper_tower_burst");
	level._effect["sniper_tower_explosion_burst1"] = loadfx("vfx/map/greece/greece_explosion_sniper_tower_burst1");
	level._effect["sniper_tower_explosion_burst3"] = loadfx("vfx/map/greece/greece_explosion_sniper_tower_burst3");
	level._effect["sniper_tower_explosion_burst4"] = loadfx("vfx/map/greece/greece_explosion_sniper_tower_burst4");
	level._effect["sniper_tower_explosion_smoke"] = loadfx("vfx/map/greece/greece_explosion_sniper_tower_smoke");
	level._effect["sniper_tower_explosion_smoke2"] = loadfx("vfx/map/greece/greece_explosion_sniper_tower_smoke2");
	level._effect["sniper_tower_explosion_fire"] = loadfx("vfx/map/greece/greece_explosion_sniper_tower_fire");
	level._effect["sniper_tower_explosion_shock"] = loadfx("vfx/map/greece/greece_explosion_sniper_tower_shock");
	level._effect["sniper_tower_explosion_debris_1"] = loadfx("vfx/map/greece/greece_explosion_sniper_tower_debris_1");
	level._effect["sniper_tower_explosion_debris_2"] = loadfx("vfx/map/greece/greece_explosion_sniper_tower_debris_2");
	level._effect["sniper_tower_explosion_debris_3"] = loadfx("vfx/map/greece/greece_explosion_sniper_tower_debris_3");
	level._effect["sniper_tower_debris_smoke_trail"] = loadfx("vfx/map/greece/greece_smokedust_trail_emit_05");
	level._effect["vehicle_fire_med"] = loadfx("vfx/map/greece/greece_vehicle_fire_med");
	level._effect["vehicle_fire_small"] = loadfx("vfx/map/greece/greece_vehicle_fire_small");
	level._effect["character_fire_torso"] = loadfx("vfx/map/greece/greece_character_onfire_torso");
	level._effect["character_fire_torso2"] = loadfx("vfx/map/greece/greece_character_onfire_torso2");
	level._effect["sniper_door_hit"] = loadfx("vfx/map/greece/greece_railgun_impact_door");
	level._effect["ending_shop_crash_burst"] = loadfx("vfx/map/greece/greece_ending_shop_crash_burst");
	level._effect["ending_shop_crash_impact"] = loadfx("vfx/map/greece/greece_ending_shop_crash_impact");
	level._effect["ending_shop_crash_dust"] = loadfx("vfx/map/greece/greece_ending_shop_crash_dust");
	level._effect["smoldering_smoke_1"] = loadfx("vfx/map/greece/greece_explo_smoke_smoldering_1");
	level._effect["smoldering_smoke_2"] = loadfx("vfx/map/greece/greece_explo_smoke_smoldering_2");
	level._effect["fire_hydrant_water_gush"] = loadfx("vfx/map/greece/greece_water_gush_firehydrant");
	level._effect["wind_blowing_debris"] = loadfx("vfx/map/greece/greece_wind_blowing_debris");
	level._effect["wind_blowing_foliage_dense"] = loadfx("vfx/map/greece/greece_ambient_foliage_runner_dense");
	level._effect["dust_falling_debris_runner"] = loadfx("vfx/map/greece/greece_dust_falling_debris_runner");
	level._effect["ending_hades_blood_pool_place"] = loadfx("vfx/map/greece/greece_blood_pool_place");
	level._effect["knife_block_sparks"] = loadfx("vfx/map/greece/greece_knife_block_sparks");
}

//Function Number: 3
visitorcentergatebashfx()
{
	common_scripts\_exploder::exploder(141);
}