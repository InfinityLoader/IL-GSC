/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: irons_estate_fx.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 5
 * Decompile Time: 93 ms
 * Timestamp: 4/22/2024 2:31:53 AM
*******************************************************************/

//Function Number: 1
main()
{
	precachefx();
	if(!getdvarint("r_reflectionProbeGenerate"))
	{
		maps\createfx\irons_estate_fx::main();
	}

	if(!isdefined(level.createfxent))
	{
		level.createfxent = [];
	}

	maps\_shg_fx::setup_shg_fx();
	thread maps\_shg_fx::fx_zone_watcher(7800,"msg_fx_zone_inner_courtyard");
	thread maps\_shg_fx::fx_zone_watcher(7700,"msg_fx_zone_outer_courtyard");
}

//Function Number: 2
precachefx()
{
	level._effect["ie_hangar_utility_light"] = loadfx("vfx/map/irons_estate/ie_hangar_utility_light");
	level._effect["ie_falling_leaves_runner"] = loadfx("vfx/map/irons_estate/ie_falling_leaves_runner");
	level._effect["ie_briefing_dim_lights"] = loadfx("vfx/map/irons_estate/ie_briefing_dim_lights");
	level._effect["ie_briefing_amb_smk"] = loadfx("vfx/map/irons_estate/ie_briefing_amb_smk");
	level._effect["ie_briefing_lights"] = loadfx("vfx/map/irons_estate/ie_briefing_lights");
	level._effect["ie_briefing_flare"] = loadfx("vfx/map/irons_estate/ie_briefing_flare");
	level._effect["ie_glow_landing"] = loadfx("vfx/map/irons_estate/ie_glow_landing");
	level._effect["ie_underwater_lights"] = loadfx("vfx/map/irons_estate/ie_underwater_lights");
	level._effect["ie_fly_cam"] = loadfx("vfx/map/irons_estate/ie_fly_cam");
	level._effect["ie_cormack_splash"] = loadfx("vfx/map/irons_estate/ie_cormack_splash");
	level._effect["ie_rndfountain_splashes"] = loadfx("vfx/map/irons_estate/ie_rndfountain_splashes");
	level._effect["ie_light_intro_dev"] = loadfx("vfx/map/irons_estate/ie_light_intro_dev");
	level._effect["ie_birds_scatter_runner"] = loadfx("vfx/map/irons_estate/ie_birds_scatter_runner");
	level._effect["ie_river_vista"] = loadfx("vfx/map/irons_estate/ie_river_vista");
	level._effect["ie_dive_cam"] = loadfx("vfx/map/irons_estate/ie_dive_cam");
	level._effect["ie_breather_bottle"] = loadfx("vfx/map/irons_estate/ie_breather_bottle");
	level._effect["ie_godray_security_small_red"] = loadfx("vfx/map/irons_estate/ie_godray_security_small_red");
	level._effect["ie_tennis_ring_inv"] = loadfx("vfx/map/irons_estate/ie_tennis_ring_inv");
	level._effect["ie_godray_security_small"] = loadfx("vfx/map/irons_estate/ie_godray_security_small");
	level._effect["ie_drone_hologram"] = loadfx("vfx/map/irons_estate/ie_drone_hologram");
	level._effect["ie_mist_rapids"] = loadfx("vfx/map/irons_estate/ie_mist_rapids");
	level._effect["ie_mist_intro_cave"] = loadfx("vfx/map/irons_estate/ie_mist_intro_cave");
	level._effect["ie_waterfall_trickle"] = loadfx("vfx/map/irons_estate/ie_waterfall_trickle");
	level._effect["ie_leaves_tornado_runner"] = loadfx("vfx/map/irons_estate/ie_leaves_tornado_runner");
	level._effect["ie_vapor"] = loadfx("vfx/map/irons_estate/ie_vapor");
	level._effect["ie_lightning"] = loadfx("vfx/map/irons_estate/ie_lightning");
	level._effect["ie_water_curtain_intro_far"] = loadfx("vfx/map/irons_estate/ie_water_curtain_intro_far");
	level._effect["ie_godray_security_top"] = loadfx("vfx/map/irons_estate/ie_godray_security_top");
	level._effect["ie_vtol_fill_grapple"] = loadfx("vfx/lights/irons_estate/ie_vtol_fill_grapple");
	level._effect["ie_bubble_trail_runner_feet_cm"] = loadfx("vfx/map/irons_estate/ie_bubble_trail_runner_feet_cm");
	level._effect["ie_underwater_env"] = loadfx("vfx/lights/irons_estate/ie_underwater_env");
	level._effect["bubble_water_grapple"] = loadfx("vfx/water/bubble_water_grapple");
	level._effect["ie_godray_security"] = loadfx("vfx/map/irons_estate/ie_godray_security");
	level._effect["grapple_kill_blood"] = loadfx("vfx/weaponimpact/grapple_kill_blood");
	level._effect["ie_fountain"] = loadfx("vfx/map/irons_estate/ie_fountain");
	level._effect["ie_insects_sml"] = loadfx("vfx/map/irons_estate/ie_insects_sml");
	level._effect["ie_sprinkler"] = loadfx("vfx/map/irons_estate/ie_sprinkler");
	level._effect["ie_moths_area_sml"] = loadfx("vfx/map/irons_estate/ie_moths_area_sml");
	level._effect["ie_bubble_breather_npc"] = loadfx("vfx/map/irons_estate/ie_bubble_breather_npc");
	level._effect["ie_bubble_trail_runner_cm"] = loadfx("vfx/map/irons_estate/ie_bubble_trail_runner_cm");
	level._effect["ie_lightbeam_vtol_landing"] = loadfx("vfx/map/irons_estate/ie_lightbeam_vtol_landing");
	level._effect["ie_bubble_trail_runner_lp"] = loadfx("vfx/map/irons_estate/ie_bubble_trail_runner_lp");
	level._effect["ie_dust_ground_fast"] = loadfx("vfx/map/irons_estate/ie_dust_ground_fast");
	level._effect["ie_dustonlens"] = loadfx("vfx/map/irons_estate/ie_dustonlens");
	level._effect["sparks_burst_electric_box"] = loadfx("vfx/explosion/sparks_burst_electric_box");
	level._effect["headlight_civhumvee_bright"] = loadfx("vfx/lights/headlight_civhumvee_bright");
	level._effect["water_splash_tire_gaz"] = loadfx("vfx/water/water_splash_tire_gaz");
	level._effect["ie_fireplace_gas_2"] = loadfx("vfx/map/irons_estate/ie_fireplace_gas_2");
	level._effect["ie_wind_debris_fast"] = loadfx("vfx/map/irons_estate/ie_wind_debris_fast");
	level._effect["ie_leaf_kickup_runner"] = loadfx("vfx/map/irons_estate/ie_leaf_kickup_runner");
	level._effect["ie_wind_debris_large"] = loadfx("vfx/map/irons_estate/ie_wind_debris_large");
	level._effect["ie_lightbeam_thin_lawn"] = loadfx("vfx/map/irons_estate/ie_lightbeam_thin_lawn");
	level._effect["ie_water_mist_low"] = loadfx("vfx/map/irons_estate/ie_water_mist_low");
	level._effect["ie_exo_hologram"] = loadfx("vfx/map/irons_estate/ie_exo_hologram");
	level._effect["ie_fireplace_gas"] = loadfx("vfx/map/irons_estate/ie_fireplace_gas");
	level._effect["ie_ambient_dust_outdoor"] = loadfx("vfx/map/irons_estate/ie_ambient_dust_outdoor");
	level._effect["grapple_cam"] = loadfx("vfx/map/irons_estate/grapple_cam");
	level._effect["ie_emp"] = loadfx("vfx/map/irons_estate/ie_emp");
	level._effect["ie_dust_roof_fast"] = loadfx("vfx/map/irons_estate/ie_dust_roof_fast");
	level._effect["ie_ball_impact"] = loadfx("vfx/map/irons_estate/ie_ball_impact");
	level._effect["ie_pool_splashes"] = loadfx("vfx/map/irons_estate/ie_pool_splashes");
	level._effect["ie_pool_waterfall"] = loadfx("vfx/map/irons_estate/ie_pool_waterfall");
	level._effect["ie_base_waterwall"] = loadfx("vfx/map/irons_estate/ie_base_waterwall");
	level._effect["ie_tennis_ring"] = loadfx("vfx/map/irons_estate/ie_tennis_ring");
	level._effect["ie_sprinkler_screen_drops"] = loadfx("vfx/map/irons_estate/ie_sprinkler_screen_drops");
	level._effect["ie_water_mist_1"] = loadfx("vfx/map/irons_estate/ie_water_mist_1");
	level._effect["ie_water_intro_splashes"] = loadfx("vfx/map/irons_estate/ie_water_intro_splashes");
	level._effect["ie_water_curtain_intro"] = loadfx("vfx/map/irons_estate/ie_water_curtain_intro");
	level._effect["ie_waterfall_a"] = loadfx("vfx/map/irons_estate/ie_waterfall_a");
	level._effect["ie_water_curtain_walkway_bottom"] = loadfx("vfx/map/irons_estate/ie_water_curtain_walkway_bottom");
	level._effect["ie_river_flow"] = loadfx("vfx/map/irons_estate/ie_river_flow");
	level._effect["ie_waterfall_d"] = loadfx("vfx/map/irons_estate/ie_waterfall_d");
	level._effect["ie_waterfall_splash_med"] = loadfx("vfx/map/irons_estate/ie_waterfall_splash_med");
	level._effect["ie_waterfall_splash_flow"] = loadfx("vfx/map/irons_estate/ie_waterfall_splash_flow");
	level._effect["ie_waterfall_thin_b"] = loadfx("vfx/map/irons_estate/ie_waterfall_thin_b");
	level._effect["ie_waterfall_sparklies"] = loadfx("vfx/map/irons_estate/ie_waterfall_sparklies");
	level._effect["ie_waterfall_fill_curve"] = loadfx("vfx/map/irons_estate/ie_waterfall_fill_curve");
	level._effect["ie_waterfall_thin"] = loadfx("vfx/map/irons_estate/ie_waterfall_thin");
	level._effect["ie_waterfall_back_a"] = loadfx("vfx/map/irons_estate/ie_waterfall_back_a");
	level._effect["ie_waterfall_b_edge"] = loadfx("vfx/map/irons_estate/ie_waterfall_b_edge");
	level._effect["ie_waterfall_mist"] = loadfx("vfx/map/irons_estate/ie_waterfall_mist");
	level._effect["ie_waterfall_edge"] = loadfx("vfx/map/irons_estate/ie_waterfall_edge");
	level._effect["ie_waterfall_c"] = loadfx("vfx/map/irons_estate/ie_waterfall_c");
	level._effect["ie_waterfall_b"] = loadfx("vfx/map/irons_estate/ie_waterfall_b");
	level._effect["ie_watergush_edge"] = loadfx("vfx/map/irons_estate/ie_watergush_edge");
	level._effect["ie_waterfall_intro_duo"] = loadfx("vfx/map/irons_estate/ie_waterfall_intro_duo");
	level._effect["ie_water_curtain_walkway"] = loadfx("vfx/map/irons_estate/ie_water_curtain_walkway");
	level._effect["ie_waterfall_lightbeam"] = loadfx("vfx/map/irons_estate/ie_waterfall_lightbeam");
	level._effect["ie_water_runoff_thick"] = loadfx("vfx/map/irons_estate/ie_water_runoff_thick");
	level._effect["ie_walkway_drops"] = loadfx("vfx/map/irons_estate/ie_walkway_drops");
	level._effect["ie_river_splashes"] = loadfx("vfx/map/irons_estate/ie_river_splashes");
	level._effect["ie_river_rapids"] = loadfx("vfx/map/irons_estate/ie_river_rapids");
	level._effect["ie_light_launcher"] = loadfx("vfx/map/irons_estate/ie_light_launcher");
	level._effect["welding_runner"] = loadfx("fx/misc/welding_runner");
	level._effect["ie_welding_runner"] = loadfx("vfx/map/irons_estate/ie_welding_runner");
	level._effect["ie_hangar_amb_smk"] = loadfx("vfx/map/irons_estate/ie_hangar_amb_smk");
	level._effect["ie_fall_clouds"] = loadfx("vfx/map/irons_estate/ie_fall_clouds");
	level._effect["flashlight"] = loadfx("fx/misc/flashlight");
	level._effect["drone_flashlight"] = loadfx("vfx/lights/light_flashlight");
	level._effect["ie_flashlight_spot"] = loadfx("vfx/map/irons_estate/ie_flashlight_spot");
	level._effect["laser"] = loadfx("vfx/props/claymore_laser");
	level._effect["ie_tennis_net_runner"] = loadfx("vfx/map/irons_estate/ie_tennis_net_runner");
	level._effect["ie_pool_foam"] = loadfx("vfx/map/irons_estate/ie_pool_foam");
	level._effect["ie_pool_ripple_runner"] = loadfx("vfx/map/irons_estate/ie_pool_ripple_runner");
	level._effect["ie_tub_bubblejet"] = loadfx("vfx/map/irons_estate/ie_tub_bubblejet");
	level._effect["ie_tub_foam"] = loadfx("vfx/map/irons_estate/ie_tub_foam");
	level._effect["ie_sauna_steam_vent"] = loadfx("vfx/map/irons_estate/ie_sauna_steam_vent");
	level._effect["ie_sauna_steam"] = loadfx("vfx/map/irons_estate/ie_sauna_steam");
	level._effect["ie_pool_steam"] = loadfx("vfx/map/irons_estate/ie_pool_steam");
	level._effect["ie_hand_pinky"] = loadfx("vfx/map/irons_estate/ie_hand_pinky");
	level._effect["ie_hand_palm"] = loadfx("vfx/map/irons_estate/ie_hand_palm");
	level._effect["ie_hand_ring"] = loadfx("vfx/map/irons_estate/ie_hand_ring");
	level._effect["ie_hand_middle"] = loadfx("vfx/map/irons_estate/ie_hand_middle");
	level._effect["ie_hand_thumb"] = loadfx("vfx/map/irons_estate/ie_hand_thumb");
	level._effect["ie_hand_fore"] = loadfx("vfx/map/irons_estate/ie_hand_fore");
	level._effect["headlight_gaz_bright"] = loadfx("vfx/lights/headlight_gaz_bright");
	level._effect["headlight_gaz_spotlight"] = loadfx("vfx/lights/headlight_gaz_spotlight");
	level._effect["ie_humvee_tail_l"] = loadfx("vfx/lights/irons_estate/ie_humvee_tail_l");
	level._effect["ie_humvee_tail_r"] = loadfx("vfx/lights/irons_estate/ie_humvee_tail_r");
	level._effect["ie_humvee_leaf_kickup"] = loadfx("vfx/map/irons_estate/ie_humvee_leaf_kickup");
	level._effect["civ_humvee_under_heat"] = loadfx("vfx/distortion/civ_humvee_under_heat");
	level._effect["ie_humvee_brake_r"] = loadfx("vfx/lights/irons_estate/ie_humvee_brake_r");
	level._effect["ie_humvee_brake_l"] = loadfx("vfx/lights/irons_estate/ie_humvee_brake_l");
	level._effect["ie_humvee_tail_l_v2"] = loadfx("vfx/lights/irons_estate/ie_humvee_tail_l_v2");
	level._effect["ie_humvee_tail_r_v2"] = loadfx("vfx/lights/irons_estate/ie_humvee_tail_r_v2");
	level._effect["ie_sports_tail"] = loadfx("vfx/lights/irons_estate/ie_sports_tail");
	level._effect["ie_sports_headlight"] = loadfx("vfx/lights/irons_estate/ie_sports_headlight");
	level._effect["ie_truck_headlight"] = loadfx("vfx/lights/irons_estate/ie_truck_headlight");
	level._effect["ie_truck_tail"] = loadfx("vfx/lights/irons_estate/ie_truck_tail");
	level._effect["ie_headlight_misc"] = loadfx("vfx/lights/irons_estate/ie_headlight_misc");
	level._effect["ie_civ_sedan_lights"] = loadfx("vfx/lights/irons_estate/ie_civ_sedan_lights");
	level._effect["ie_civ_sedan_headlight"] = loadfx("vfx/lights/irons_estate/ie_civ_sedan_headlight");
	level._effect["fallingwater_splash"] = loadfx("vfx/map/irons_estate/ie_intro_volume_splash");
	level._effect["fallingwater_splash_screen"] = loadfx("vfx/water/falling_water_volume_screen_splash");
	level._effect["sprinkler_splash"] = loadfx("vfx/water/sprinkler_splash");
	level._effect["ie_atlas_jet_exterior_lights"] = loadfx("vfx/map/irons_estate/ie_atlas_jet_exterior_lights");
	level._effect["ie_vtol_wtip_light_tail_red"] = loadfx("vfx/map/irons_estate/ie_vtol_wtip_light_tail_red");
	level._effect["ie_vtol_rotorwash_end"] = loadfx("vfx/map/irons_estate/ie_vtol_rotorwash_end");
	level._effect["ie_vtol_wtip_light_red_blink"] = loadfx("vfx/map/irons_estate/ie_vtol_wtip_light_red_blink");
	level._effect["vtol_engine"] = loadfx("vfx/map/irons_estate/vtol_engine");
	level._effect["vtol_exhaust_r"] = loadfx("vfx/vehicle/vtol_exhaust_r");
	level._effect["vtol_exhaust_l"] = loadfx("vfx/vehicle/vtol_exhaust_l");
	level._effect["vtol_engine_land"] = loadfx("vfx/map/irons_estate/vtol_engine_land");
	level._effect["ie_light_cool"] = loadfx("vfx/map/irons_estate/ie_light_cool");
	level._effect["ie_light_teal"] = loadfx("vfx/map/irons_estate/ie_light_teal");
	level._effect["ie_light_teal_briefing_knox"] = loadfx("vfx/map/irons_estate/ie_light_teal_briefing_knox");
	level._effect["ie_light_teal_cave_knox"] = loadfx("vfx/map/irons_estate/ie_light_teal_cave_knox");
	level._effect["ie_light_teal_recon_knox"] = loadfx("vfx/map/irons_estate/ie_light_teal_recon_knox");
	level._effect["ie_light_warm"] = loadfx("vfx/map/irons_estate/ie_light_warm");
	level._effect["ie_light_red_cormack_plane"] = loadfx("vfx/map/irons_estate/ie_light_red_cormack_plane");
	level._effect["boost_dust_npc"] = loadfx("vfx/smoke/jetpack_exhaust_npc");
	level._effect["boost_dust_impact_ground"] = loadfx("vfx/smoke/jetpack_ground_impact_runner");
}

//Function Number: 3
sec_godray()
{
	common_scripts\utility::flag_wait("security_center_enter_anim_done");
	common_scripts\_exploder::exploder(6668);
}

//Function Number: 4
drone_holo_on()
{
	wait(2);
	common_scripts\utility::flag_wait("security_center_hack_complete");
	common_scripts\_exploder::exploder(6622);
}

//Function Number: 5
hangar_fx()
{
	common_scripts\_exploder::exploder(9091);
}