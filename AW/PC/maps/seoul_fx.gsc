/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: seoul_fx.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 124
 * Decompile Time: 1746 ms
 * Timestamp: 4/22/2024 2:37:01 AM
*******************************************************************/

//Function Number: 1
main()
{
	precachefx();
	maps\createfx\seoul_fx::main();
	maps\_shg_fx::setup_shg_fx();
	level.treadfx_maxheight = 1000;
	common_scripts\utility::flag_init("vfx_seoul_intro_start");
	common_scripts\utility::flag_init("vfx_start_drop_pod_intro_phase_2b");
	common_scripts\utility::flag_init("msg_kill_vista_effects");
	common_scripts\utility::flag_init("vfx_msg_finale_sequence_start");
	common_scripts\utility::flag_init("performingarts_exit_explosions");
	common_scripts\utility::flag_init("midjump_pipe_burst");
	common_scripts\utility::flag_init("fx_prepipe_burst_debris");
	thread maps\_shg_fx::fx_zone_watcher(500,"msg_fx_zone0_apartment_intro_vista");
	thread maps\_shg_fx::fx_zone_watcher(1000,"msg_fx_zone1_apartment_exit","msg_fx_zone1a_top_upper_mid_drop");
	thread maps\_shg_fx::fx_zone_watcher(1200,"msg_fx_zone1b_upper_mid_apartment");
	thread maps\_shg_fx::fx_zone_watcher(1400,"msg_fx_zone1c_mid_lower_drop","msg_fx_zone1d_mid_lower_drop_exit");
	thread maps\_shg_fx::fx_zone_watcher(1600,"msg_fx_zone1e_mid_lower_apartment","msg_fx_zone1f_lower_apartment_exit_drop");
	thread maps\_shg_fx::fx_zone_watcher(1800,"msg_fx_zone1g_building_ground_floor","msg_fx_zone1h_building_ground_floor_exit");
	thread maps\_shg_fx::fx_zone_watcher(2000,"msg_fx_zone2_forward_operating_base","msg_fx_zone2b_forward_operating_base_transition");
	thread maps\_shg_fx::fx_zone_watcher(2200,"msg_fx_zone2c_base_transition_exit","msg_fx_zone2d_drone_swarm_street");
	thread maps\_shg_fx::fx_zone_watcher(2400,"msg_fx_zone2e_exo_push_intersection","msg_fx_zone2f_performing_arts_front_streets");
	thread maps\_shg_fx::fx_zone_watcher(3000,"msg_fx_zone3_performing_arts_entrance","msg_fx_zone3a_performing_arts_exit");
	thread maps\_shg_fx::fx_zone_watcher(3600,"msg_fx_zone3b_transition_lobby","msg_fx_zone3c_transition_office_building");
	thread maps\_shg_fx::fx_zone_watcher(4000,"msg_fx_zone4_sinkhole_traverse","msg_fx_zone4a_sinkhole_exit");
	thread maps\_shg_fx::fx_zone_watcher(5000,"msg_fx_zone5_subway_traverse","msg_fx_zone5a_subway_ceiling_breach");
	thread maps\_shg_fx::fx_zone_watcher(6000,"msg_fx_zone6_escalator_exit_shopping","msg_fx_zone6a_shopping_district_street");
	thread maps\_shg_fx::fx_zone_watcher(6400,"msg_fx_zone6b_shopping_narrow_alley","msg_fx_zone6c_shopping_narrow_alley_exit");
	thread maps\_shg_fx::fx_zone_watcher(7000,"msg_fx_zone7_2nd_floor_building_overview","msg_fx_zone7a_river_bridge_section");
	thread intro_drop_pod_se_start();
	thread intro_drop_pod_se_phase_2b_start();
	thread vista_ambientfx_double_layer_missile_hit();
	thread vista_ambientfx_aa_explosion();
	thread vista_ambientfx_midair_explosion();
	thread intro_apt_vf_debris();
	thread ambient_fires_inside_building();
	thread ambient_building_fires_fob_drone_swarm();
	thread operating_base_ambientfx_aa_explosion();
	thread operating_base_ambientfx_midair_explosion();
	thread operating_base_ambientfx_ground_fireball_explosion();
	thread operating_base_ambientfx_ground_dirt_explosion();
	thread operating_base_ambientfx_window_glass_explosion();
	thread drone_street_lights();
	thread player_perarts_jump_explosions();
	thread player_presinkhole_jump_pipeburst();
	thread player_presinkhole_debris();
	thread sinkhole_ambientfx_aa_explosions();
	thread sinkhole_ambientfx_windowglass_explosions();
	thread sinkhole_ambientfx_midair_explosions();
	thread subway_bombshakes();
	thread subway_exit_lights();
	thread shoping_district_ambientfx_aa_explosion();
	thread shoping_district_ambientfx_midair_explosion();
	thread shoping_district_ambientfx_windowglass_explosion();
	thread seo_outro_wp_env_fx_start();
	thread finale_section_ambientfx_aa_explosions();
	thread finale_section_ambientfx_midair_explosions();
	thread finale_section_ambientfx_windowglass_explosion();
	thread treadfx_override();
}

//Function Number: 2
precachefx()
{
	level._effect["flashlight"] = loadfx("vfx/lights/flashlight_recovery");
	level._effect["flesh_hit"] = loadfx("vfx/weaponimpact/flesh_impact_body_fatal_exit");
	level._effect["fire_vista_lp_lrg_blacksmk_thick"] = loadfx("vfx/fire/fire_vista_lp_lrg_blacksmk_thick");
	level._effect["fire_vista_lp_med_blacksmk_thick"] = loadfx("vfx/fire/fire_vista_lp_med_blacksmk_thick");
	level._effect["fire_vista_glow_lp_lrg_unlit"] = loadfx("vfx/fire/fire_vista_glow_lp_lrg_unlit");
	level._effect["fire_vista_glow_lp_med_unlit_pos"] = loadfx("vfx/fire/fire_vista_glow_lp_med_unlit_pos");
	level._effect["fire_vista_glow_lp_lrg_unlit_pos"] = loadfx("vfx/fire/fire_vista_glow_lp_lrg_unlit_pos");
	level._effect["fire_vista_lp_xsml_unlit"] = loadfx("vfx/fire/fire_vista_lp_xsml_unlit");
	level._effect["fire_vista_lp_sml_unlit"] = loadfx("vfx/fire/fire_vista_lp_sml_unlit");
	level._effect["fire_vista_lp_med_unlit"] = loadfx("vfx/fire/fire_vista_lp_med_unlit");
	level._effect["fire_vista_lp_lrg_unlit"] = loadfx("vfx/fire/fire_vista_lp_lrg_unlit");
	level._effect["seo_vista_smk_column_giant"] = loadfx("vfx/map/seoul/seo_vista_smk_column_giant");
	level._effect["smk_plume_lp_lrg_unlit"] = loadfx("vfx/smoke/smk_plume_lp_lrg_unlit");
	level._effect["smk_plume_lp_xlrg_unlit"] = loadfx("vfx/smoke/smk_plume_lp_xlrg_unlit");
	level._effect["smoke_grey_column_spot_directional_lg"] = loadfx("vfx/smoke/smoke_grey_column_spot_directional_lg");
	level._effect["fire_wrap_post_sml"] = loadfx("vfx/fire/fire_wrap_post_sml");
	level._effect["fire_wrap_post_med"] = loadfx("vfx/fire/fire_wrap_post_med");
	level._effect["fire_wrap_post_lrg"] = loadfx("vfx/fire/fire_wrap_post_lrg");
	level._effect["fire_ceiling_edge_med"] = loadfx("vfx/fire/fire_ceiling_edge_med");
	level._effect["fire_ceiling_md_slow"] = loadfx("vfx/fire/fire_ceiling_md_slow");
	level._effect["fire_lp_m_whitesmk"] = loadfx("vfx/fire/fire_lp_m_whitesmk");
	level._effect["fire_lp_m"] = loadfx("vfx/fire/fire_lp_m");
	level._effect["fire_lp_m_no_light"] = loadfx("vfx/fire/fire_lp_m_no_light");
	level._effect["fire_lp_s"] = loadfx("vfx/fire/fire_lp_s");
	level._effect["fire_lp_s_no_light"] = loadfx("vfx/fire/fire_lp_s_no_light");
	level._effect["fire_lp_xs_light"] = loadfx("vfx/fire/fire_lp_xs_light");
	level._effect["fire_lp_xs_no_light"] = loadfx("vfx/fire/fire_lp_xs_no_light");
	level._effect["fire_lp_smk_s"] = loadfx("vfx/fire/fire_lp_smk_s");
	level._effect["fire_lp_smk_s_light"] = loadfx("vfx/fire/fire_lp_smk_s_light");
	level._effect["fire_falling_runner_line_200"] = loadfx("vfx/fire/fire_falling_runner_line_200");
	level._effect["fire_falling_runner_point"] = loadfx("vfx/fire/fire_falling_runner_point");
	level._effect["fire_lp_s_base"] = loadfx("vfx/fire/fire_lp_s_base");
	level._effect["fire_lp_m_light_blacksmk"] = loadfx("vfx/fire/fire_lp_m_light_blacksmk");
	level._effect["fire_pipe_leak_sml_runner"] = loadfx("vfx/fire/fire_pipe_leak_sml_runner");
	level._effect["fire_fallingdebris_smoky"] = loadfx("vfx/fire/fire_fallingdebris_smoky");
	level._effect["fire_rocks_fallingdebris"] = loadfx("vfx/fire/fire_rocks_fallingdebris");
	level._effect["fire_pipe_burst_sml"] = loadfx("vfx/fire/fire_pipe_burst_sml");
	level._effect["fire_fallingdebris_boulder"] = loadfx("vfx/fire/fire_fallingdebris_boulder");
	level._effect["fire_lp_s_sprite_light"] = loadfx("vfx/fire/fire_lp_s_sprite_light");
	level._effect["fire_lp_s_whitesmk"] = loadfx("vfx/fire/fire_lp_s_whitesmk");
	level._effect["fire_window_glow_lp_sml_unlit_pos"] = loadfx("vfx/fire/fire_window_glow_lp_sml_unlit_pos");
	level._effect["fire_window_glow_lp_med_unlit_pos"] = loadfx("vfx/fire/fire_window_glow_lp_med_unlit_pos");
	level._effect["fire_window_glow_lp_med_unlit_pos_2"] = loadfx("vfx/fire/fire_window_glow_lp_med_unlit_pos_2");
	level._effect["seo_intro_fire_smk_aerial_view_r"] = loadfx("vfx/map/seoul/seo_intro_fire_smk_aerial_view_r");
	level._effect["aa_explosion_runner_single"] = loadfx("vfx/explosion/aa_explosion_runner_single");
	level._effect["ambient_explosion_midair_runner_single"] = loadfx("vfx/explosion/ambient_explosion_midair_runner_single");
	level._effect["seo_ambexplo_air_nonlit_parent"] = loadfx("vfx/map/seoul/seo_ambexplo_air_nonlit_parent");
	level._effect["aa_flash_tracer_far_freq_rnr_lp"] = loadfx("vfx/explosion/aa_flash_tracer_far_freq_rnr_lp");
	level._effect["ambient_explosion_fireball"] = loadfx("vfx/explosion/ambient_explosion_fireball");
	level._effect["ambient_explosion_dirt_runner"] = loadfx("vfx/explosion/ambient_explosion_dirt_runner");
	level._effect["ambient_explosion_windowglass"] = loadfx("vfx/explosion/ambient_explosion_windowglass");
	level._effect["ambient_explosion_midair_c"] = loadfx("vfx/explosion/ambient_explosion_midair_c");
	level._effect["fireball_explosion_cluster_parent_01"] = loadfx("vfx/explosion/fireball_explosion_cluster_parent_01");
	level._effect["ash_ember_cloud_freq_lrg_loop"] = loadfx("vfx/ash/ash_ember_cloud_freq_lrg_loop");
	level._effect["ash_ember_indoor_runner"] = loadfx("vfx/ash/ash_ember_indoor_runner");
	level._effect["ash_ember_cloud_freq_sml_loop"] = loadfx("vfx/ash/ash_ember_cloud_freq_sml_loop");
	level._effect["electrical_sparks_runner"] = loadfx("vfx/explosion/electrical_sparks_runner");
	level._effect["sparks_burst_a_nolight"] = loadfx("vfx/explosion/sparks_burst_a_nolight");
	level._effect["screen_sparks"] = loadfx("vfx/sparks/lrg_elevator_frame_sparks");
	level._effect["glass_shatter_large"] = loadfx("vfx/glass/glass_shatter_large");
	level._effect["glass_shatter_xlarge"] = loadfx("vfx/glass/glass_shatter_xlarge");
	level._effect["glass_falling_m_runner"] = loadfx("vfx/glass/glass_falling_m_runner");
	level._effect["large_glass_1"] = loadfx("vfx/weaponimpact/large_glass_1");
	level._effect["seo_suv_doorshield_hit"] = loadfx("vfx/map/seoul/seo_suv_doorshield_hit");
	level._effect["seo_suv_doorshield_hit_break"] = loadfx("vfx/map/seoul/seo_suv_doorshield_hit_break");
	level._effect["falling_water_exterior_wide_lrg"] = loadfx("vfx/water/falling_water_exterior_wide_lrg");
	level._effect["fallingwater_splash"] = loadfx("vfx/water/falling_water_volume_splash_l");
	level._effect["fallingwater_splash_screen"] = loadfx("vfx/water/falling_water_volume_screen_splash");
	level._effect["plastic_bag_blowing_runner_lp"] = loadfx("vfx/wind/plastic_bag_blowing_runner_lp");
	level._effect["wind_blowing_debris"] = loadfx("vfx/wind/wind_blowing_debris");
	level._effect["wind_blowing_leaves_constant"] = loadfx("vfx/wind/wind_blowing_leaves_constant");
	level._effect["seo_building_glow_blue_unlit_wn"] = loadfx("vfx/map/seoul/seo_building_glow_blue_unlit_wn");
	level._effect["seo_steam_ambient_vents"] = loadfx("vfx/map/seoul/seo_steam_ambient_vents");
	level._effect["seo_amb_smk_oriented_lp"] = loadfx("vfx/map/seoul/seo_amb_smk_oriented_lp");
	level._effect["battlefield_smoke_m_thick"] = loadfx("vfx/smoke/battlefield_smoke_m_thick");
	level._effect["smk_obscure_low_thick_far_m"] = loadfx("vfx/smoke/smk_obscure_low_thick_far_m");
	level._effect["smk_stacks_lp_sml_a"] = loadfx("vfx/smoke/smk_stacks_lp_sml_a");
	level._effect["smk_stacks_lp_med_a"] = loadfx("vfx/smoke/smk_stacks_lp_med_a");
	level._effect["smk_stacks_lp_lrg_a"] = loadfx("vfx/smoke/smk_stacks_lp_lrg_a");
	level._effect["smk_stack_single_01_lp_med_unlit"] = loadfx("vfx/smoke/smk_stack_single_01_lp_med_unlit");
	level._effect["smk_stack_single_01_lp_sml_unlit"] = loadfx("vfx/smoke/smk_stack_single_01_lp_sml_unlit");
	level._effect["smk_stack_single_02_lp_med_unlit_b"] = loadfx("vfx/smoke/smk_stack_single_02_lp_med_unlit_b");
	level._effect["smk_stack_single_02_lp_sml_unlit"] = loadfx("vfx/smoke/smk_stack_single_02_lp_sml_unlit");
	level._effect["smk_ground_single_01_lp_lrg_unlit"] = loadfx("vfx/smoke/smk_ground_single_01_lp_lrg_unlit");
	level._effect["smk_ground_single_01_lp_med_unlit"] = loadfx("vfx/smoke/smk_ground_single_01_lp_med_unlit");
	level._effect["smk_ground_single_01_lp_med_unlit_b"] = loadfx("vfx/smoke/smk_ground_single_01_lp_med_unlit_b");
	level._effect["smk_stacks_lp_lrg_unlit_a"] = loadfx("vfx/smoke/smk_stacks_lp_lrg_unlit_a");
	level._effect["smk_stacks_lp_lrg_unlit_c"] = loadfx("vfx/smoke/smk_stacks_lp_lrg_unlit_c");
	level._effect["smk_stacks_lp_med_unlit"] = loadfx("vfx/smoke/smk_stacks_lp_med_unlit");
	level._effect["smk_stacks_lp_med_unlit_a"] = loadfx("vfx/smoke/smk_stacks_lp_med_unlit_a");
	level._effect["smk_stacks_lp_med_unlit_b"] = loadfx("vfx/smoke/smk_stacks_lp_med_unlit_b");
	level._effect["smk_stacks_lp_med_unlit_c"] = loadfx("vfx/smoke/smk_stacks_lp_med_unlit_c");
	level._effect["smk_stacks_lp_sml_unlit_a"] = loadfx("vfx/smoke/smk_stacks_lp_sml_unlit_a");
	level._effect["smk_stacks_lp_sml_unlit_b"] = loadfx("vfx/smoke/smk_stacks_lp_sml_unlit_b");
	level._effect["smk_wispy_low_lp"] = loadfx("vfx/smoke/smk_wispy_low_lp");
	level._effect["smoldering_smk_ground_fast_s"] = loadfx("vfx/smoke/smoldering_smk_ground_fast_s");
	level._effect["smoldering_smk_ground_vista_unlit_a"] = loadfx("vfx/smoke/smoldering_smk_ground_vista_unlit_a");
	level._effect["smoldering_smk_ground_vista_unlit_b"] = loadfx("vfx/smoke/smoldering_smk_ground_vista_unlit_b");
	level._effect["smoldering_smk_ground_xlrg_unlit"] = loadfx("vfx/smoke/smoldering_smk_ground_xlrg_unlit");
	level._effect["smoldering_smk_ground_xlrg_unlit_b"] = loadfx("vfx/smoke/smoldering_smk_ground_xlrg_unlit_b");
	level._effect["smoldering_smk_ground_lrg_unlit"] = loadfx("vfx/smoke/smoldering_smk_ground_lrg_unlit");
	level._effect["smoldering_smk_ground_lrg_unlit_b"] = loadfx("vfx/smoke/smoldering_smk_ground_lrg_unlit_b");
	level._effect["smoldering_smk_direction_fast_m"] = loadfx("vfx/smoke/smoldering_smk_direction_fast_m");
	level._effect["smoldering_smk_direction_fast_s"] = loadfx("vfx/smoke/smoldering_smk_direction_fast_s");
	level._effect["smoldering_smk_direction_s"] = loadfx("vfx/smoke/smoldering_smk_direction_s");
	level._effect["smk_window_fire_glow_lp_sml"] = loadfx("vfx/smoke/smk_window_fire_glow_lp_sml");
	level._effect["window_smk_dark_m"] = loadfx("vfx/smoke/window_smk_dark_m");
	level._effect["smoldering_smk_direction_fast_vf"] = loadfx("vfx/smoke/smoldering_smk_direction_fast_vf");
	level._effect["smoldering_smk_dir_wide_slow"] = loadfx("vfx/smoke/smoldering_smk_dir_wide_slow");
	level._effect["steam_pipe_leak_interior_sm"] = loadfx("vfx/steam/steam_pipe_leak_interior_sm");
	level._effect["steam_pipe_leak_lrg"] = loadfx("vfx/steam/steam_pipe_leak_lrg");
	level._effect["steam_column_large"] = loadfx("vfx/steam/steam_column_large");
	level._effect["steam_pipe_burst_sml"] = loadfx("vfx/steam/steam_pipe_burst_sml");
	level._effect["cigarette_smk"] = loadfx("vfx/smoke/cigarette_smk");
	level._effect["cigarette_smk_light"] = loadfx("vfx/smoke/cigarette_smk_light");
	level._effect["waterfall_wave_01"] = loadfx("vfx/water/waterfall_wave_01");
	level._effect["waterfall_edge_splatter"] = loadfx("vfx/water/waterfall_edge_splatter");
	level._effect["waterfall_edge_splatter_narrow"] = loadfx("vfx/water/waterfall_edge_splatter_narrow");
	level._effect["waterfall_edge_splatter_single"] = loadfx("vfx/water/waterfall_edge_splatter_single");
	level._effect["foam_small_distributer"] = loadfx("vfx/water/foam_small_distributer");
	level._effect["waterfall_foam_edge"] = loadfx("vfx/water/waterfall_foam_edge");
	level._effect["splash_single"] = loadfx("vfx/water/splash_single");
	level._effect["ripple_flow_distortion"] = loadfx("vfx/water/ripple_flow_distortion");
	level._effect["foam_flowing"] = loadfx("vfx/water/foam_flowing");
	level._effect["seo_water_fountain_low"] = loadfx("vfx/map/seoul/seo_water_fountain_low");
	level._effect["ripple_distortion_half_square"] = loadfx("vfx/water/ripple_distortion_half_square");
	level._effect["water_curtain_leak_thin"] = loadfx("vfx/rain/water_curtain_leak_thin");
	level._effect["seo_dust_ambient_interior"] = loadfx("vfx/map/seoul/seo_dust_ambient_interior");
	level._effect["seo_dust_ambient_interior_ground"] = loadfx("vfx/map/seoul/seo_dust_ambient_interior_ground");
	level._effect["dust_falling_debris_runner"] = loadfx("vfx/dust/dust_falling_debris_runner");
	level._effect["dust_falling_debris_01"] = loadfx("vfx/dust/dust_falling_debris_01");
	level._effect["dust_harpoon_impact"] = loadfx("vfx/dust/dust_harpoon_impact");
	level._effect["rocks_falling_s_cheap_runner"] = loadfx("vfx/rock/rocks_falling_s_cheap_runner");
	level._effect["rocks_falling_s_cheap_child_a"] = loadfx("vfx/rock/rocks_falling_s_cheap_child_a");
	level._effect["rocks_falling_m_runner"] = loadfx("vfx/rock/rocks_falling_m_runner");
	level._effect["rocks_falling_l_runner"] = loadfx("vfx/rock/rocks_falling_l_runner");
	level._effect["rocks_falling_xl_runner"] = loadfx("vfx/rock/rocks_falling_xl_runner");
	level._effect["concrete_falling_explode"] = loadfx("vfx/rock/concrete_falling_explode");
	level._effect["rocks_falling_lrg_runner"] = loadfx("vfx/rock/rocks_falling_lrg_runner");
	level._effect["rocks_falling_variety_runner"] = loadfx("vfx/rock/rocks_falling_variety_runner");
	level._effect["rocks_falling_variety"] = loadfx("vfx/rock/rocks_falling_variety");
	level._effect["concrete_falling_l_runner"] = loadfx("vfx/rock/concrete_falling_l_runner");
	level._effect["warbird_harpoon_spiral"] = loadfx("vfx/vehicle/warbird_harpoon_spiral");
	level._effect["warbird_zip_rope_glow"] = loadfx("vfx/vehicle/warbird_zip_rope_glow");
	level._effect["footstep_mech"] = loadfx("vfx/treadfx/footstep_mech");
	level._effect["seo_intro_cloud_puff"] = loadfx("vfx/map/seoul/seo_intro_cloud_puff");
	level._effect["seo_intro_cloud_blocker"] = loadfx("vfx/map/seoul/seo_intro_cloud_blocker");
	level._effect["seo_intro_exit_cloud"] = loadfx("vfx/map/seoul/seo_intro_exit_cloud");
	level._effect["seo_intro_extra_clouds"] = loadfx("vfx/map/seoul/seo_intro_extra_clouds");
	level._effect["seo_intro_pod_spinout"] = loadfx("vfx/map/seoul/seo_intro_pod_spinout");
	level._effect["seo_intro_droppod_blimp_detach"] = loadfx("vfx/map/seoul/seo_intro_droppod_blimp_detach");
	level._effect["seo_intro_blimp_explo1"] = loadfx("vfx/map/seoul/seo_intro_blimp_explo1");
	level._effect["seo_intro_blimp_explo2"] = loadfx("vfx/map/seoul/seo_intro_blimp_explo2");
	level._effect["seo_intro_blimp_fire"] = loadfx("vfx/map/seoul/seo_intro_blimp_fire");
	level._effect["seo_intro_misl_trail"] = loadfx("vfx/map/seoul/seo_intro_misl_trail");
	level._effect["seo_intro_ambient_missiles_runner"] = loadfx("vfx/map/seoul/seo_intro_ambient_missiles_runner");
	level._effect["seo_intro_ambient_missiles_runner_explode"] = loadfx("vfx/map/seoul/seo_intro_ambient_missiles_runner_explode");
	level._effect["seo_intro_ambexplo_flak_runner"] = loadfx("vfx/map/seoul/seo_intro_ambexplo_flak_runner");
	level._effect["seo_intro_ambexplo_flak_mid_runner"] = loadfx("vfx/map/seoul/seo_intro_ambexplo_flak_mid_runner");
	level._effect["seo_intro_ambexplo_flak_near_runner"] = loadfx("vfx/map/seoul/seo_intro_ambexplo_flak_near_runner");
	level._effect["seo_intro_grnd_xplo_runner"] = loadfx("vfx/map/seoul/seo_intro_grnd_xplo_runner");
	level._effect["seo_intro_ambient_glow"] = loadfx("vfx/map/seoul/seo_intro_ambient_glow");
	level._effect["seo_intro_sinkhole_explo"] = loadfx("vfx/map/seoul/seo_intro_sinkhole_explo");
	level._effect["seo_intro_misl_hit_pod"] = loadfx("vfx/map/seoul/seo_intro_misl_hit_pod");
	level._effect["seo_intro_pod_debris"] = loadfx("vfx/map/seoul/seo_intro_pod_debris");
	level._effect["seo_intro_missile_hit_pod_sparks"] = loadfx("vfx/map/seoul/seo_intro_missile_hit_pod_sparks");
	level._effect["seo_intro_pod_wind_streaks"] = loadfx("vfx/map/seoul/seo_intro_pod_wind_streaks");
	level._effect["seo_intro_pod_hit_building"] = loadfx("vfx/map/seoul/seo_intro_pod_hit_building");
	level._effect["seo_intro_pod_exit_building"] = loadfx("vfx/map/seoul/seo_intro_pod_exit_building");
	level._effect["seo_intro_building_piece_spurt_single"] = loadfx("vfx/map/seoul/seo_intro_building_piece_spurt_single");
	level._effect["seo_intro_vm_exit_dust_landing"] = loadfx("vfx/map/seoul/seo_intro_vm_exit_dust_landing");
	level._effect["vf_radial_pulse_out_med"] = loadfx("vfx/vectorfield/vf_radial_pulse_out_med");
	level._effect["seo_razorback_exhaust_vf"] = loadfx("vfx/map/seoul/seo_razorback_exhaust_vf");
	level._effect["embers_lp_med_vf"] = loadfx("vfx/fire/embers_lp_med_vf");
	level._effect["embers_low_lp_med_vf"] = loadfx("vfx/fire/embers_low_lp_med_vf");
	level._effect["fire_fast_lp_sml_vf"] = loadfx("vfx/fire/fire_fast_lp_sml_vf");
	level._effect["trash_blowing_lp_fast_vf"] = loadfx("vfx/wind/trash_blowing_lp_fast_vf");
	level._effect["ash_lp_med_vf"] = loadfx("vfx/ash/ash_lp_med_vf");
	level._effect["seo_cormack_landing_dust"] = loadfx("vfx/map/seoul/seo_cormack_landing_dust");
	level._effect["seo_intro_indoor_dpod_smk_low"] = loadfx("vfx/map/seoul/seo_intro_indoor_dpod_smk_low");
	level._effect["seo_intro_cormack_jump_sparks"] = loadfx("vfx/map/seoul/seo_intro_cormack_jump_sparks");
	level._effect["seo_intro_drop_pod_smoke_out"] = loadfx("vfx/map/seoul/seo_intro_drop_pod_smoke_out");
	level._effect["glass_falling_m_runner_no_physics"] = loadfx("vfx/glass/glass_falling_m_runner_no_physics");
	level._effect["glass_falling_s"] = loadfx("vfx/glass/glass_falling_s");
	level._effect["seo_pod_fall_debris_intro"] = loadfx("vfx/map/seoul/seo_pod_fall_debris_intro");
	level._effect["wood_plank_single_fall_a"] = loadfx("vfx/explosion/wood_plank_single_fall_a");
	level._effect["wood_plank_single_fall_b"] = loadfx("vfx/explosion/wood_plank_single_fall_b");
	level._effect["seo_intro_drop_pod_vm_motionline"] = loadfx("vfx/map/seoul/seo_intro_drop_pod_vm_motionline");
	level._effect["weaponplf_cannon_muzzle"] = loadfx("vfx/muzzleflash/weaponplf_cannon_muzzle");
	level._effect["weaponplf_trail_missile_runner"] = loadfx("vfx/trail/weaponplf_trail_missile_runner");
	level._effect["razorback_muzzleflash"] = loadfx("vfx/muzzleflash/razorback_turret_flash_wv");
	level._effect["razorback_death_explosion"] = loadfx("vfx/explosion/vehicle_walker_tank_explosion");
	level._effect["drop_pod_hovering_thruster"] = loadfx("vfx/trail/drop_pod_hovering_thruster");
	level._effect["drop_pod_hovering_thruster_short"] = loadfx("vfx/trail/drop_pod_hovering_thruster_short");
	level._effect["drop_pod_hovering_thruster_idle"] = loadfx("vfx/trail/drop_pod_hovering_thruster_idle");
	level._effect["drop_pod_hovering_side_spray"] = loadfx("vfx/trail/drop_pod_hovering_side_spray");
	level._effect["ambient_drop_pod_runner"] = loadfx("vfx/props/ambient_drop_pod_runner");
	level._effect["seo_smoke_inside_droppod"] = loadfx("vfx/map/seoul/seo_smoke_inside_droppod");
	level._effect["seo_spark_droppod_door"] = loadfx("vfx/map/seoul/seo_spark_droppod_door");
	level._effect["seo_dust_droppod_door"] = loadfx("vfx/map/seoul/seo_dust_droppod_door");
	level._effect["drop_pod_landing_impact_ground"] = loadfx("vfx/smoke/drop_pod_landing_impact_ground");
	level._effect["seo_intro_smoke_droppod_door_kick"] = loadfx("vfx/map/seoul/seo_intro_smoke_droppod_door_kick");
	level._effect["seo_intro_smoke_droppod_door_trail"] = loadfx("vfx/map/seoul/seo_intro_smoke_droppod_door_trail");
	level._effect["seo_intro_smoke_droppod_door_middle"] = loadfx("vfx/map/seoul/seo_intro_smoke_droppod_door_middle");
	level._effect["seo_intro_drop_pod_thrusters"] = loadfx("vfx/trail/seo_intro_drop_pod_thrusters");
	level._effect["seo_intro_smoke_droppod_at_door_L"] = loadfx("vfx/map/seoul/seo_intro_smoke_droppod_at_door_L");
	level._effect["seo_intro_smk_droppod_at_door"] = loadfx("vfx/map/seoul/seo_intro_smk_droppod_at_door");
	level._effect["seo_intro_smoke_droppod_at_door_R"] = loadfx("vfx/map/seoul/seo_intro_smoke_droppod_at_door_R");
	level._effect["seo_intro_smoke_droppod_door_linger"] = loadfx("vfx/map/seoul/seo_intro_smoke_droppod_door_linger");
	level._effect["tread_dust_ft101_tank"] = loadfx("vfx/treadfx/tread_dust_ft101_tank");
	level._effect["tread_dust_trucks"] = loadfx("vfx/treadfx/tread_dust_trucks");
	level._effect["titan_tread_impact"] = loadfx("vfx/treadfx/titan_tread_impact");
	level._effect["rocks_falling_m"] = loadfx("vfx/rock/rocks_falling_m");
	level._effect["titan_tread_dust"] = loadfx("vfx/treadfx/titan_tread_dust");
	level._effect["titan_smk_kickup"] = loadfx("vfx/smoke/titan_smk_kickup");
	level._effect["titan_tread_kickup_front"] = loadfx("vfx/treadfx/titan_tread_kickup_front");
	level._effect["titan_tread_kickup_back"] = loadfx("vfx/treadfx/titan_tread_kickup_back");
	level._effect["mobile_turret_sparks"] = loadfx("vfx/sparks/vehicle_damaged_sparks_interior_small");
	level._effect["mobile_turret_smoke"] = loadfx("vfx/smoke/vehicle_damaged_smoke_interior");
	level._effect["mobile_turret_fire_small"] = loadfx("vfx/fire/vehicle_damaged_fire_interior_small");
	level._effect["mobile_turret_fire_large"] = loadfx("vfx/fire/vehicle_damaged_fire_x4walker_vm");
	level._effect["mobile_turret_explosion"] = loadfx("vfx/explosion/vehicle_x4walker_explosion");
	level._effect["mobile_turret_ground_smoke"] = loadfx("vfx/map/fusion/fusion_mobile_turret_base_smoke");
	level._effect["seo_mobile_turret_emp"] = loadfx("vfx/map/seoul/seo_mobile_turret_emp");
	level._effect["suv_door_break"] = loadfx("vfx/props/suv_door_break");
	level._effect["landass_exhaust_smk_rt_npc"] = loadfx("vfx/smoke/landass_exhaust_smk_rt_npc");
	level._effect["landass_exhaust_smk_lf_npc"] = loadfx("vfx/smoke/landass_exhaust_smk_lf_npc");
	level._effect["landass_exhaust_smk_rt_npc"] = loadfx("vfx/smoke/landass_exhaust_smk_rt_npc");
	level._effect["landass_exhaust_smk_lf_npc"] = loadfx("vfx/smoke/landass_exhaust_smk_lf_npc");
	level._effect["landass_impact_smk_rnr"] = loadfx("vfx/smoke/landass_impact_smk_rnr");
	level._effect["landass_exhaust_smk_vm"] = loadfx("vfx/smoke/landass_exhaust_smk_vm");
	level._effect["landass_impact_smk_vm"] = loadfx("vfx/smoke/landass_impact_smk_vm");
	level._effect["seo_drones_car_explo"] = loadfx("vfx/map/seoul/seo_drones_car_explo");
	level._effect["seo_car_explo_fire_trail"] = loadfx("vfx/map/seoul/seo_car_explo_fire_trail");
	level._effect["drone_swarm_damage_spark"] = loadfx("vfx/sparks/drone_swarm_damage_spark");
	level._effect["drone_search_lt"] = loadfx("vfx/lights/drone_search_lt");
	level._effect["drone_scan_seoul"] = loadfx("vfx/map/seoul/seo_drone_scan");
	level._effect["weaponplf_tread_smk_powerup"] = loadfx("vfx/map/seoul/weaponplf_tread_smk_powerup");
	level._effect["weaponplf_tread_smk"] = loadfx("vfx/map/seoul/weaponplf_tread_smk");
	level._effect["weaponplf_tread_smk_sinkhole"] = loadfx("vfx/map/seoul/weaponplf_tread_smk_sinkhole");
	level._effect["seo_outro_wp_explo_initial"] = loadfx("vfx/map/seoul/seo_outro_wp_explo_initial");
	level._effect["seo_outro_wp_explo_belly1"] = loadfx("vfx/map/seoul/seo_outro_wp_explo_belly1");
	level._effect["seo_outro_wp_explo_belly2"] = loadfx("vfx/map/seoul/seo_outro_wp_explo_belly2");
	level._effect["seo_outro_wp_explo_belly2_chd"] = loadfx("vfx/map/seoul/seo_outro_wp_explo_belly2_chd");
	level._effect["seo_outro_wp_explo_tail"] = loadfx("vfx/map/seoul/seo_outro_wp_explo_tail");
	level._effect["seo_outro_wp_explo_tail_shkwv_grnd"] = loadfx("vfx/map/seoul/seo_outro_wp_explo_tail_shkwv_grnd");
	level._effect["seo_outro_wp_explo_tail_shkwv"] = loadfx("vfx/map/seoul/seo_outro_wp_explo_tail_shkwv");
	level._effect["seo_outro_wp_explo_wing"] = loadfx("vfx/map/seoul/seo_outro_wp_explo_wing");
	level._effect["fusion_end_falling_rock_sparkfoun"] = loadfx("vfx/map/fusion/fusion_end_falling_rock_sparkfoun");
	level._effect["seo_outro_grnd_smk_gush"] = loadfx("vfx/map/seoul/seo_outro_grnd_smk_gush");
	level._effect["seo_outro_grnd_smk_linger"] = loadfx("vfx/map/seoul/seo_outro_grnd_smk_linger");
	level._effect["seo_outro_grnd_smk_settle"] = loadfx("vfx/map/seoul/seo_outro_grnd_smk_settle");
	level._effect["seo_outro_thick_smk_vm"] = loadfx("vfx/map/seoul/seo_outro_thick_smk_vm");
	level._effect["fusion_end_armblood_bloodsquirts"] = loadfx("vfx/map/fusion/fusion_end_armblood_bloodsquirts");
	level._effect["fusion_blood_smear_oriented"] = loadfx("vfx/map/fusion/fusion_blood_smear_oriented");
	level._effect["fusion_drag_dust"] = loadfx("vfx/map/fusion/fusion_drag_dust");
	level._effect["light_carmack_drag_cg"] = loadfx("vfx/lights/seoul/seo_spot_carmack_end_cg");
	level._effect["light_carmack_drag1_cg"] = loadfx("vfx/lights/seoul/seo_spot_carmack_end1_cg");
	level._effect["light_carmack_drag1_cg_runner"] = loadfx("vfx/lights/seoul/seo_spot_carmack_end1_cg_runner");
	level._effect["light_carmack_drag2_cg"] = loadfx("vfx/lights/seoul/seo_spot_carmack_end2_cg");
	level._effect["cg_fx_light_scene_mall"] = loadfx("vfx/lights/seoul/seo_fx_light_scene_mall_cg");
	level._effect["cg_fx_light_scene_mall1"] = loadfx("vfx/lights/seoul/seo_fx_light_scene_mall1_cg");
	level._effect["cg_fx_light_scene_mall2"] = loadfx("vfx/lights/seoul/seo_fx_light_scene_mall2_cg");
	level._effect["cg_fx_light_scene_subway"] = loadfx("vfx/lights/seoul/seo_fx_light_scene_subway_cg");
	level._effect["sign_glow_med_unlit_wn"] = loadfx("vfx/lights/seoul/sign_glow_med_unlit_wn");
	level._effect["beam_glow_lrg_unlit_wn"] = loadfx("vfx/lights/seoul/beam_glow_lrg_unlit_wn");
	level._effect["light_red_point_intro"] = loadfx("vfx/lights/seoul/light_red_point_intro");
	level._effect["light_orange_point_intro"] = loadfx("vfx/lights/seoul/light_orange_point_intro");
	level._effect["light_red_point"] = loadfx("vfx/lights/seoul/light_red_point");
	level._effect["light_red_spot"] = loadfx("vfx/lights/seoul/light_red_spot");
	level._effect["seoul_fluorescent_smoke_dim"] = loadfx("vfx/lights/seoul/seoul_fluorescent_smoke_dim");
	level._effect["seoul_blue_fluorescent_smoke"] = loadfx("vfx/lights/seoul/seoul_blue_fluorescent_smoke");
	level._effect["pod_light_spot_blue"] = loadfx("vfx/lights/seoul/pod_light_spot_blue");
	level._effect["pod_light_spot_blue_dimmer"] = loadfx("vfx/lights/seoul/pod_light_spot_blue_dimmer");
	level._effect["pod_blue_bounce"] = loadfx("vfx/lights/seoul/pod_blue_bounce");
	level._effect["pod_blue_bounce_dim"] = loadfx("vfx/lights/seoul/pod_blue_bounce_dim");
	level._effect["seoul_godray_atrium"] = loadfx("vfx/lights/seoul/seoul_godray_atrium");
	level._effect["light_yellow_spot"] = loadfx("vfx/lights/seoul/light_yellow_spot");
	level._effect["light_yellow_spot2"] = loadfx("vfx/lights/seoul/light_yellow_spot2");
	level._effect["light_pod_screen"] = loadfx("vfx/lights/seoul/light_pod_screen");
	level._effect["pod_emissive_yellow"] = loadfx("vfx/lights/seoul/pod_emissive_yellow");
	level._effect["seo_emergency_orange_godray"] = loadfx("vfx/lights/seoul/seo_emergency_orange_godray");
	level._effect["seo_white_godray"] = loadfx("vfx/lights/seoul/seo_white_godray");
	level._effect["seo_canlight_white_godray"] = loadfx("vfx/lights/seoul/seo_canlight_white_godray");
	level._effect["large_godray_screen"] = loadfx("vfx/lights/seoul/large_godray_screen");
	level._effect["seo_large_white_godray"] = loadfx("vfx/lights/seoul/seo_large_white_godray");
	level._effect["seo_large_canal_flare"] = loadfx("vfx/lights/seoul/seo_large_canal_flare");
	level._effect["seo_lens_pod"] = loadfx("vfx/lights/seoul/seo_lens_pod");
	level._effect["seo_stand_white_godray"] = loadfx("vfx/lights/seoul/seo_stand_white_godray");
	level._effect["seo_light_stadium"] = loadfx("vfx/lights/seoul/seo_light_stadium");
	level._effect["light_cine_fire"] = loadfx("vfx/lights/seoul/light_cine_fire");
	level._effect["light_cine_fire_point"] = loadfx("vfx/lights/seoul/light_cine_fire_point");
	level._effect["seo_led_streetlight_haze_2"] = loadfx("vfx/map/seoul/seo_led_streetlight_haze_2");
	level._effect["fire_lp_s_canal_sprite_light"] = loadfx("vfx/lights/seoul/fire_lp_s_canal_sprite_light");
	level._effect["seo_light_godray3"] = loadfx("vfx/lights/seoul/seo_light_godray3");
	level._effect["seo_light_godray_red"] = loadfx("vfx/lights/seoul/seo_light_godray_red");
	level._effect["seo_light_godray_redwin"] = loadfx("vfx/lights/seoul/seo_light_godray_redwin");
	level._effect["seo_light_godray_white"] = loadfx("vfx/lights/seoul/seo_light_godray_white");
	level._effect["seo_sconce_lens_sm"] = loadfx("vfx/lights/seoul/seo_sconce_lens_sm");
	level._effect["light_blink_red"] = loadfx("vfx/lights/seoul/light_blink_red");
	level._effect["light_left_cormack_run"] = loadfx("vfx/lights/seoul/light_left_cormack_run");
	level._effect["light_cine_fire_small"] = loadfx("vfx/lights/seoul/light_cine_fire_small");
	level._effect["light_green_spot"] = loadfx("vfx/lights/seoul/light_green_spot");
	level._effect["green_fill"] = loadfx("vfx/lights/seoul/green_fill");
	level._effect["light_left_key_spot"] = loadfx("vfx/lights/seoul/light_left_key_spot");
	level._effect["light_right_fill"] = loadfx("vfx/lights/seoul/light_right_fill");
	level._effect["light_hole_point"] = loadfx("vfx/lights/seoul/light_hole_point");
	level._effect["light_top_key_spot"] = loadfx("vfx/lights/seoul/light_top_key_spot");
	level._effect["light_left_shut_spot"] = loadfx("vfx/lights/seoul/light_left_shut_spot");
	level._effect["seoul_heli_spot_flare"] = loadfx("vfx/lights/seoul/seoul_heli_spot_flare");
	level._effect["spotlight_chopper"] = loadfx("vfx/lights/seoul/seoul_heli_spot_flare");
	level._effect["red_fill"] = loadfx("vfx/lights/seoul/red_fill");
	level._effect["red_fill_landing"] = loadfx("vfx/lights/seoul/red_fill_landing");
	level._effect["red_fill_landing_dim"] = loadfx("vfx/lights/seoul/red_fill_landing_dim");
	level._effect["light_left_cormack_fx_c"] = loadfx("vfx/lights/seoul/light_left_cormack_fx_c");
	level._effect["pod_godray"] = loadfx("vfx/lights/seoul/pod_godray");
	level._effect["light_left_shut_fill"] = loadfx("vfx/lights/seoul/light_left_shut_fill");
	level._effect["light_face_rim_r"] = loadfx("vfx/lights/seoul/light_face_rim_r");
	level._effect["light_face_cormack_r"] = loadfx("vfx/lights/seoul/light_face_cormack_r");
	level._effect["light_face_rim_r_stug"] = loadfx("vfx/lights/seoul/light_face_rim_r_stug");
	level._effect["light_cine_fire_cormack"] = loadfx("vfx/lights/seoul/light_cine_fire_cormack");
	level._effect["light_left_prepanel_rim"] = loadfx("vfx/lights/seoul/light_left_prepanel_rim");
	level._effect["light_left_shut_mad"] = loadfx("vfx/lights/seoul/light_left_shut_mad");
	level._effect["light_left_shut_blink"] = loadfx("vfx/lights/seoul/light_left_shut_blink");
	level._effect["light_cine_fire_mwpspec"] = loadfx("vfx/lights/seoul/light_cine_fire_mwpspec");
	level._effect["light_fire_cormackeye_spec"] = loadfx("vfx/lights/seoul/light_fire_cormackeye_spec");
	level._effect["seo_train_l_godray"] = loadfx("vfx/lights/seoul/seo_train_l_godray");
	level._effect["seo_train_s_godray"] = loadfx("vfx/lights/seoul/seo_train_s_godray");
	level._effect["seo_train_m_godray"] = loadfx("vfx/lights/seoul/seo_train_m_godray");
	level._effect["seo_light_godray_drop"] = loadfx("vfx/lights/seoul/seo_light_godray_drop");
	level._effect["seo_light_godray_bar"] = loadfx("vfx/lights/seoul/seo_light_godray_bar");
	level._effect["seo_orange_godray1"] = loadfx("vfx/lights/seoul/seo_orange_godray1");
	level._effect["seo_flou_ground_godray"] = loadfx("vfx/lights/seoul/seo_flou_ground_godray");
	level._effect["seo_flou_sh_godray"] = loadfx("vfx/lights/seoul/seo_flou_sh_godray");
	level._effect["seo_flou_warm_godray"] = loadfx("vfx/lights/seoul/seo_flou_warm_godray");
	level._effect["seo_firealarm_godray"] = loadfx("vfx/lights/seoul/seo_firealarm_godray");
	level._effect["seo_can_smk_godray"] = loadfx("vfx/lights/seoul/seo_can_smk_godray");
	level._effect["seo_can_bridge_godray"] = loadfx("vfx/lights/seoul/seo_can_bridge_godray");
	level._effect["seo_train_rear_godray"] = loadfx("vfx/lights/seoul/seo_train_rear_godray");
	level._effect["seo_flou_sh2_godray"] = loadfx("vfx/lights/seoul/seo_flou_sh2_godray");
	level._effect["seo_sconce_dim_sm"] = loadfx("vfx/lights/seoul/seo_sconce_dim_sm");
	level._effect["seo_sconce_blue_sm"] = loadfx("vfx/lights/seoul/seo_sconce_blue_sm");
	level._effect["seo_white_lantern"] = loadfx("vfx/lights/seoul/seo_white_lantern");
	level._effect["seo_car_headlight_on"] = loadfx("vfx/lights/seoul/seo_car_headlight_on");
	level._effect["seo_wall_blue_strong"] = loadfx("vfx/lights/seoul/seo_wall_blue_strong");
	level._effect["seo_subwayscreen_flare"] = loadfx("vfx/lights/seoul/seo_subwayscreen_flare");
	level._effect["seo_subwayscreen_sm_flare"] = loadfx("vfx/lights/seoul/seo_subwayscreen_sm_flare");
	level._effect["seo_subwaypillar_flare"] = loadfx("vfx/lights/seoul/seo_subwaypillar_flare");
	level._effect["seo_vendingmachine_flare"] = loadfx("vfx/lights/seoul/seo_vendingmachine_flare");
	level._effect["seo_white_circ_dim"] = loadfx("vfx/lights/seoul/seo_white_circ_dim");
	level._effect["iw5_attackdronegunseoul"] = loadfx("vfx/muzzleflash/drone_swarm_tracer");
	level._effect["roof_breach_device_radial_blast_charges"] = loadfx("vfx/props/roof_breach_device_radial_blast_charges");
	level._effect["ground_concrete_breach_explosion_under"] = loadfx("vfx/explosion/ground_concrete_breach_explosion_under");
	level._effect["roof_breach_device_laser_mini_burst_bsr"] = loadfx("vfx/props/roof_breach_device_laser_mini_burst_bsr");
	level._effect["dust_falling_edge_radial"] = loadfx("vfx/dust/dust_falling_edge_radial");
	level._effect["lag_roof_breach_explosion_backside"] = loadfx("vfx/map/lagos/lag_roof_breach_explosion_backside");
	level._effect["breach_downward_people_land"] = loadfx("vfx/treadfx/breach_downward_people_land");
	level._effect["breach_downward_cement_land"] = loadfx("vfx/treadfx/breach_downward_cement_land");
}

//Function Number: 3
fx_cam_view_test()
{
	thread maps\_shg_fx::exploder_to_array(2);
}

//Function Number: 4
intro_drop_pod_se_start()
{
	thread intro_pod_drop();
	thread intro_drop_pod_vm_motionline();
}

//Function Number: 5
intro_pod_drop()
{
	wait(43);
	common_scripts\_exploder::exploder("95");
	common_scripts\_exploder::exploder("97");
	wait(5);
	maps\_utility::stop_exploder("95");
	maps\_utility::stop_exploder("97");
}

//Function Number: 6
intro_drop_pod_vm_motionline()
{
	level waittill("droppod_blimp_detach");
	wait(0.9);
	playfxontag(common_scripts\utility::getfx("seo_intro_drop_pod_vm_motionline"),level.pod_screen,"tag_origin");
}

//Function Number: 7
intro_droppod_blimp_detach01(param_00)
{
	level notify("droppod_blimp_detach");
	wait(0.8);
	var_01 = common_scripts\utility::spawn_tag_origin();
	var_01 linkto(param_00,"hatch3a",(0,0,150),(90,0,0));
	playfxontag(common_scripts\utility::getfx("seo_intro_droppod_blimp_detach"),var_01,"tag_origin");
	wait(0.6);
	playfxontag(common_scripts\utility::getfx("seo_intro_droppod_blimp_detach"),var_01,"tag_origin");
	wait(5);
	var_01 delete();
}

//Function Number: 8
intro_droppod_blimp_detach02(param_00)
{
	wait(0.35);
	var_01 = common_scripts\utility::spawn_tag_origin();
	var_01 linkto(param_00,"hatch4a",(0,0,150),(90,0,0));
	playfxontag(common_scripts\utility::getfx("seo_intro_droppod_blimp_detach"),var_01,"tag_origin");
	wait(5);
	var_01 delete();
}

//Function Number: 9
intro_blimp_missile(param_00)
{
	wait(1);
	param_00 soundscripts\_snd::snd_message("droppod_intro_blimp_missile");
	playfxontag(common_scripts\utility::getfx("seo_intro_misl_trail"),param_00,"tag_origin");
	common_scripts\_exploder::exploder("100");
}

//Function Number: 10
intro_blimp_missile_trail_delete(param_00)
{
	wait(5);
	stopfxontag(common_scripts\utility::getfx("seo_intro_misl_trail"),param_00,"tag_origin");
}

//Function Number: 11
intro_blimp_explode(param_00)
{
	var_01 = common_scripts\utility::spawn_tag_origin();
	var_01 linkto(param_00,"lock4",(900,-550,0),(90,0,0));
	param_00 soundscripts\_snd::snd_message("droppod_intro_blimp_explode");
	playfxontag(common_scripts\utility::getfx("seo_intro_blimp_explo1"),var_01,"tag_origin");
	playfxontag(common_scripts\utility::getfx("seo_intro_blimp_fire"),var_01,"tag_origin");
	var_02 = common_scripts\utility::spawn_tag_origin();
	var_02 linkto(param_00,"lock4",(300,-200,0),(90,0,0));
	playfxontag(common_scripts\utility::getfx("seo_intro_blimp_fire"),var_02,"tag_origin");
	var_03 = common_scripts\utility::spawn_tag_origin();
	var_03 linkto(param_00,"lock4",(500,-600,0),(90,0,0));
	playfxontag(common_scripts\utility::getfx("seo_intro_blimp_fire"),var_03,"tag_origin");
	wait(1.6);
	playfxontag(common_scripts\utility::getfx("seo_intro_blimp_explo2"),param_00,"lock8");
	thread intro_blimp_explode2(param_00);
	wait(1);
	var_02 delete();
	var_03 delete();
	wait(4);
	var_01 delete();
}

//Function Number: 12
intro_blimp_explode2(param_00)
{
	var_01 = common_scripts\utility::spawn_tag_origin();
	var_01 linkto(param_00,"lock4",(300,0,0),(90,0,0));
	playfxontag(common_scripts\utility::getfx("seo_intro_blimp_explo2"),var_01,"tag_origin");
	wait(0.4);
	playfxontag(common_scripts\utility::getfx("seo_intro_blimp_explo2"),param_00,"lock6");
	thread intro_blimp_explode3(param_00);
	wait(0.8);
	playfxontag(common_scripts\utility::getfx("seo_intro_blimp_explo2"),var_01,"tag_origin");
	playfxontag(common_scripts\utility::getfx("seo_intro_blimp_explo2"),param_00,"tag_flash_40mm");
	wait(2);
	var_01 delete();
}

//Function Number: 13
intro_blimp_explode3(param_00)
{
	var_01 = common_scripts\utility::spawn_tag_origin();
	var_01 linkto(param_00,"lock4",(-500,200,0),(90,0,0));
	playfxontag(common_scripts\utility::getfx("seo_intro_blimp_explo2"),var_01,"tag_origin");
	wait(0.3);
	playfxontag(common_scripts\utility::getfx("seo_intro_blimp_explo2"),param_00,"lock4");
	thread intro_blimp_explode4(param_00);
	wait(0.3);
	playfxontag(common_scripts\utility::getfx("seo_intro_blimp_explo2"),var_01,"tag_origin");
	wait(0.3);
	playfxontag(common_scripts\utility::getfx("seo_intro_blimp_explo2"),param_00,"tag_flash_105mm");
	wait(2);
	var_01 delete();
}

//Function Number: 14
intro_blimp_explode4(param_00)
{
	var_01 = common_scripts\utility::spawn_tag_origin();
	var_01 linkto(param_00,"tag_flash_flares",(0,0,150),(90,0,0));
	playfxontag(common_scripts\utility::getfx("seo_intro_blimp_explo2"),var_01,"tag_origin");
	wait(0.3);
	thread intro_blimp_explode5(param_00);
	playfxontag(common_scripts\utility::getfx("seo_intro_blimp_explo2"),param_00,"tag_flash_flares");
	wait(0.2);
	playfxontag(common_scripts\utility::getfx("seo_intro_blimp_explo2"),param_00,"tag_flash_25mm");
	wait(5);
	var_01 delete();
}

//Function Number: 15
intro_blimp_explode5(param_00)
{
	var_01 = common_scripts\utility::spawn_tag_origin();
	var_01 linkto(param_00,"tag_flash_flares",(0,0,300),(90,0,0));
	playfxontag(common_scripts\utility::getfx("seo_intro_blimp_explo2"),var_01,"tag_origin");
	wait(0.3);
	playfxontag(common_scripts\utility::getfx("seo_intro_blimp_explo2"),var_01,"tag_origin");
	wait(5);
	var_01 delete();
}

//Function Number: 16
droppod_rt_spinout(param_00)
{
	var_01 = common_scripts\utility::spawn_tag_origin();
	var_01 linkto(param_00,"slider02",(0,0,20),(180,0,15));
	playfxontag(common_scripts\utility::getfx("seo_intro_pod_spinout"),var_01,"tag_origin");
	var_02 = common_scripts\utility::spawn_tag_origin();
	var_02 linkto(param_00,"jetlid01",(-15,0,70),(75,0,0));
	playfxontag(common_scripts\utility::getfx("drop_pod_hovering_side_spray"),var_02,"tag_origin");
	wait(0.3);
	stopfxontag(common_scripts\utility::getfx("drop_pod_hovering_side_spray"),var_02,"tag_origin");
	wait(0.2);
	playfxontag(common_scripts\utility::getfx("drop_pod_hovering_thruster"),param_00,"tag_fx");
	wait(0.3);
	playfxontag(common_scripts\utility::getfx("seo_intro_pod_spinout"),var_01,"tag_origin");
	var_03 = common_scripts\utility::spawn_tag_origin();
	var_03 linkto(param_00,"jetlid02",(-15,0,70),(75,0,0));
	playfxontag(common_scripts\utility::getfx("drop_pod_hovering_side_spray"),var_03,"tag_origin");
	wait(0.3);
	stopfxontag(common_scripts\utility::getfx("drop_pod_hovering_side_spray"),var_03,"tag_origin");
	wait(0.2);
	playfxontag(common_scripts\utility::getfx("drop_pod_hovering_side_spray"),var_03,"tag_origin");
	wait(0.5);
	playfxontag(common_scripts\utility::getfx("seo_intro_pod_spinout"),var_01,"tag_origin");
	wait(1);
	stopfxontag(common_scripts\utility::getfx("drop_pod_hovering_thruster"),param_00,"tag_fx");
	wait(5);
	var_01 delete();
	var_02 delete();
	var_03 delete();
}

//Function Number: 17
droppod_lt_spinout(param_00)
{
	playfxontag(common_scripts\utility::getfx("drop_pod_hovering_thruster"),param_00,"tag_fx");
	var_01 = common_scripts\utility::spawn_tag_origin();
	var_01 linkto(param_00,"jetlid01",(-15,0,70),(75,0,0));
	playfxontag(common_scripts\utility::getfx("drop_pod_hovering_side_spray"),var_01,"tag_origin");
	wait(0.5);
	stopfxontag(common_scripts\utility::getfx("drop_pod_hovering_side_spray"),var_01,"tag_origin");
	var_02 = common_scripts\utility::spawn_tag_origin();
	var_02 linkto(param_00,"jetlid02",(-15,0,70),(75,0,0));
	playfxontag(common_scripts\utility::getfx("drop_pod_hovering_side_spray"),var_02,"tag_origin");
	wait(0.3);
	stopfxontag(common_scripts\utility::getfx("drop_pod_hovering_side_spray"),var_02,"tag_origin");
	wait(0.2);
	playfxontag(common_scripts\utility::getfx("drop_pod_hovering_side_spray"),var_02,"tag_origin");
	wait(0.3);
	stopfxontag(common_scripts\utility::getfx("drop_pod_hovering_side_spray"),var_02,"tag_origin");
	stopfxontag(common_scripts\utility::getfx("drop_pod_hovering_thruster"),param_00,"tag_fx");
	wait(2);
	var_01 delete();
	var_02 delete();
}

//Function Number: 18
main_pod_jets(param_00)
{
	var_01 = common_scripts\utility::spawn_tag_origin();
	var_01 linkto(param_00,"jetlid01",(-15,0,80),(75,0,0));
	param_00 soundscripts\_snd::snd_message("droppod_main_pod_jets");
	playfxontag(common_scripts\utility::getfx("drop_pod_hovering_side_spray"),var_01,"tag_origin");
	wait(0.2);
	stopfxontag(common_scripts\utility::getfx("drop_pod_hovering_side_spray"),var_01,"tag_origin");
	wait(0.6);
	playfxontag(common_scripts\utility::getfx("drop_pod_hovering_side_spray"),var_01,"tag_origin");
	wait(0.2);
	stopfxontag(common_scripts\utility::getfx("drop_pod_hovering_side_spray"),var_01,"tag_origin");
	wait(0.5);
	playfxontag(common_scripts\utility::getfx("drop_pod_hovering_side_spray"),var_01,"tag_origin");
	wait(0.2);
	stopfxontag(common_scripts\utility::getfx("drop_pod_hovering_side_spray"),var_01,"tag_origin");
	var_02 = common_scripts\utility::spawn_tag_origin();
	var_02 linkto(param_00,"jetlid02",(-15,0,80),(75,0,0));
	playfxontag(common_scripts\utility::getfx("drop_pod_hovering_side_spray"),var_02,"tag_origin");
	wait(0.3);
	stopfxontag(common_scripts\utility::getfx("drop_pod_hovering_side_spray"),var_02,"tag_origin");
	wait(0.2);
	playfxontag(common_scripts\utility::getfx("drop_pod_hovering_side_spray"),var_02,"tag_origin");
	wait(0.5);
	stopfxontag(common_scripts\utility::getfx("drop_pod_hovering_side_spray"),var_02,"tag_origin");
	wait(0.3);
	playfxontag(common_scripts\utility::getfx("drop_pod_hovering_side_spray"),var_02,"tag_origin");
	wait(0.3);
	stopfxontag(common_scripts\utility::getfx("drop_pod_hovering_side_spray"),var_02,"tag_origin");
	wait(1.5);
	var_03 = common_scripts\utility::spawn_tag_origin();
	var_03 linkto(param_00,"tag_roof",(0,0,20),(90,0,15));
	playfxontag(common_scripts\utility::getfx("seo_intro_extra_clouds"),var_03,"tag_origin");
	level waittill("stop_extra_clouds");
	stopfxontag(common_scripts\utility::getfx("seo_intro_extra_clouds"),var_03,"tag_origin");
	var_03 delete();
	wait(2);
	var_01 delete();
	var_02 delete();
}

//Function Number: 19
intro_bottom_droppod(param_00)
{
	playfxontag(common_scripts\utility::getfx("drop_pod_hovering_thruster"),param_00,"tag_fx");
	wait(1);
	stopfxontag(common_scripts\utility::getfx("drop_pod_hovering_thruster"),param_00,"tag_fx");
}

//Function Number: 20
intro_droppod_thrusters(param_00)
{
	foreach(var_02 in param_00)
	{
		wait 0.05;
		playfxontag(common_scripts\utility::getfx("seo_intro_drop_pod_thrusters"),var_02,"tag_fx");
		var_02 thread intro_droppod_thrusters_stop();
	}
}

//Function Number: 21
intro_drop_pod_se_phase_2b_start()
{
	common_scripts\utility::flag_wait("vfx_start_drop_pod_intro_phase_2b");
	thread intro_cloud();
	thread intro_ground_explosion_fx();
	thread intro_flak_explosion_fx();
	thread intro_mid_flak_explosion_fx();
	thread intro_near_flak_explosion_fx();
	thread intro_aerial_fire_fx();
}

//Function Number: 22
extra_cloud_cover_start(param_00)
{
	common_scripts\_exploder::exploder("105");
	wait(0.5);
	common_scripts\_exploder::exploder("150");
}

//Function Number: 23
intro_cloud()
{
	wait(4.6);
	thread intro_ambient_missiles();
	maps\_utility::stop_exploder("100");
	wait(1);
	common_scripts\_exploder::exploder("110");
}

//Function Number: 24
extra_cloud_cover_end(param_00)
{
	level notify("stop_extra_clouds");
}

//Function Number: 25
intro_ambient_missiles()
{
	wait(0.05);
	common_scripts\_exploder::exploder("intro_amb_misl");
	wait(11);
	common_scripts\_exploder::kill_exploder("intro_amb_misl");
	maps\_utility::pauseexploder("150");
	maps\_utility::pauseexploder("110");
	maps\_utility::pauseexploder("105");
}

//Function Number: 26
intro_droppod_thrusters_stop()
{
	level waittill("msg_emergency_door_close");
	stopfxontag(common_scripts\utility::getfx("seo_intro_drop_pod_thrusters"),self,"tag_fx");
}

//Function Number: 27
intro_aerial_fire_fx()
{
	wait(8);
	common_scripts\_exploder::exploder("aerial_fire");
	level waittill("flak_fx_stop");
	common_scripts\_exploder::kill_exploder("aerial_fire");
}

//Function Number: 28
intro_ground_explosion_fx()
{
	wait(8);
	common_scripts\_exploder::exploder("intro_ground_explosions");
	level waittill("flak_fx_stop");
	common_scripts\_exploder::kill_exploder("intro_ground_explosions");
}

//Function Number: 29
intro_flak_explosion_fx()
{
	wait(8);
	common_scripts\_exploder::exploder("intro_ambient_flak");
	wait(3);
	common_scripts\_exploder::kill_exploder("intro_ambient_flak");
}

//Function Number: 30
intro_mid_flak_explosion_fx()
{
	wait(4);
	common_scripts\_exploder::exploder("intro_ambient_flak_mid");
	wait(5);
	common_scripts\_exploder::kill_exploder("intro_ambient_flak_mid");
}

//Function Number: 31
intro_near_flak_explosion_fx()
{
	wait(12.5);
	common_scripts\_exploder::exploder("intro_ambient_flak_near");
	wait(20);
	common_scripts\_exploder::kill_exploder("intro_ambient_flak_near");
	level notify("flak_fx_stop");
}

//Function Number: 32
intro_missile_trail(param_00)
{
	playfxontag(common_scripts\utility::getfx("seo_intro_misl_trail"),param_00,"tag_origin");
}

//Function Number: 33
intro_missile_trail_delete(param_00)
{
	stopfxontag(common_scripts\utility::getfx("seo_intro_misl_trail"),param_00,"tag_origin");
}

//Function Number: 34
intro_sinkhole_explo(param_00)
{
	common_scripts\_exploder::exploder("sinkhole_explo");
	level notify("msg_intro_sinkhole_explo");
}

//Function Number: 35
intro_missile_hit_pod(param_00)
{
	level notify("intro_missile_hit_pod");
	level notify("missle_hit");
	playfxontag(common_scripts\utility::getfx("seo_intro_misl_hit_pod"),param_00,"door_F");
	playfxontag(common_scripts\utility::getfx("seo_intro_smoke_droppod_door_trail"),param_00,"door_F");
	wait(0.4);
	wait(2.2);
	stopfxontag(common_scripts\utility::getfx("seo_intro_misl_hit_pod"),param_00,"door_F");
	killfxontag(common_scripts\utility::getfx("seo_intro_smoke_droppod_door_trail"),param_00,"door_F");
}

//Function Number: 36
intro_pod_door_flyout(param_00)
{
	wait(0.5);
	var_01 = common_scripts\utility::spawn_tag_origin();
	var_01 linkto(param_00,"emergencyShield_dam_F",(68,-5,16),(0,4,180));
	playfxontag(common_scripts\utility::getfx("seo_intro_smoke_droppod_at_door_L"),var_01,"tag_origin");
	wait(1);
	var_02 = common_scripts\utility::spawn_tag_origin();
	var_02 linkto(param_00,"emergencyShield_dam_F",(0,0,0),(0,-25.5,0));
	playfxontag(common_scripts\utility::getfx("seo_intro_smoke_droppod_door_middle"),var_02,"tag_origin");
	wait(1);
	var_03 = common_scripts\utility::spawn_tag_origin();
	var_03 linkto(param_00,"emergencyShield_dam_F",(40,-60,10),(170,120,180));
	playfxontag(common_scripts\utility::getfx("seo_intro_smoke_droppod_at_door_R"),var_03,"tag_origin");
	wait(7);
	stopfxontag(common_scripts\utility::getfx("seo_intro_smoke_droppod_at_door_L"),var_01,"tag_origin");
	stopfxontag(common_scripts\utility::getfx("seo_intro_smoke_droppod_at_door_R"),var_03,"tag_origin");
	var_04 = common_scripts\utility::spawn_tag_origin();
	var_04 linkto(param_00,"emergencyShield_dam_F",(68,-5,16),(0,4,180));
	playfxontag(common_scripts\utility::getfx("seo_intro_smk_droppod_at_door"),var_04,"tag_origin");
	var_05 = common_scripts\utility::spawn_tag_origin();
	var_05 linkto(param_00,"emergencyShield_dam_F",(40,-60,10),(170,120,180));
	playfxontag(common_scripts\utility::getfx("seo_intro_smk_droppod_at_door"),var_05,"tag_origin");
	wait(4);
	playfxontag(common_scripts\utility::getfx("seo_intro_smoke_droppod_door_linger"),param_00,"emergencyShield_dam_F");
	stopfxontag(common_scripts\utility::getfx("seo_intro_smk_droppod_at_door"),var_04,"tag_origin");
	stopfxontag(common_scripts\utility::getfx("seo_intro_smk_droppod_at_door"),var_05,"tag_origin");
	wait(2);
	stopfxontag(common_scripts\utility::getfx("seo_intro_smoke_droppod_door_middle"),var_02,"tag_origin");
	wait(5);
	stopfxontag(common_scripts\utility::getfx("seo_intro_smoke_droppod_door_linger"),param_00,"emergencyShield_dam_F");
	wait(3);
	var_02 delete();
	var_01 delete();
	var_03 delete();
	var_04 delete();
	var_05 delete();
}

//Function Number: 37
intro_pod_emergency_door_close(param_00)
{
	level notify("msg_emergency_door_close");
}

//Function Number: 38
intro_droppod_velocity_streaks(param_00)
{
	common_scripts\_exploder::exploder(425);
	var_01 = common_scripts\utility::spawn_tag_origin();
	var_01 linkto(param_00,"tag_roof",(0,0,20),(90,0,0));
	wait(2.75);
	playfxontag(common_scripts\utility::getfx("seo_intro_pod_wind_streaks"),var_01,"tag_origin");
	level waittill("pod_hit_first_building");
	killfxontag(common_scripts\utility::getfx("seo_intro_pod_wind_streaks"),var_01,"tag_origin");
	common_scripts\_exploder::kill_exploder(425);
	wait 0.05;
	var_01 delete();
}

//Function Number: 39
intro_pod_hit_building1(param_00)
{
	cinematicingameloop("drop_pod_glass_damaged");
	level notify("pod_hit_first_building");
	var_01 = common_scripts\utility::spawn_tag_origin();
	var_01 linkto(param_00,"tag_roof",(-60,0,-20),(60,0,15));
	playfxontag(common_scripts\utility::getfx("seo_intro_missile_hit_pod_sparks"),var_01,"tag_origin");
	var_01 = common_scripts\utility::spawn_tag_origin();
	var_01 linkto(param_00,"tag_roof",(-30,50,-20),(60,0,15));
	playfxontag(common_scripts\utility::getfx("seo_intro_missile_hit_pod_sparks"),var_01,"tag_origin");
	var_02 = common_scripts\utility::spawn_tag_origin();
	var_02 linkto(param_00,"tag_roof",(0,0,20),(90,0,15));
	playfxontag(common_scripts\utility::getfx("seo_intro_pod_hit_building"),var_02,"tag_origin");
	level waittill("hit_3");
	playfxontag(common_scripts\utility::getfx("seo_intro_pod_exit_building"),var_02,"tag_origin");
	stopfxontag(common_scripts\utility::getfx("seo_intro_pod_hit_building"),var_02,"tag_origin");
	wait(3);
	thread final_pod_crash_fast(param_00);
	level waittill("pod_land_apartment");
	killfxontag(common_scripts\utility::getfx("seo_intro_pod_exit_building"),var_02,"tag_origin");
	wait 0.05;
	var_02 delete();
	wait(5.5);
	killfxontag(common_scripts\utility::getfx("seo_intro_missile_hit_pod_sparks"),var_01,"tag_origin");
	wait 0.05;
	var_01 delete();
}

//Function Number: 40
final_pod_crash_fast(param_00)
{
	var_01 = common_scripts\utility::spawn_tag_origin();
	var_01 linkto(param_00,"tag_roof",(0,0,0),(90,-120,0));
	wait 0.05;
	playfxontag(common_scripts\utility::getfx("seo_intro_pod_hit_building"),var_01,"tag_origin");
	level waittill("pod_land_apartment");
	wait(1);
	killfxontag(common_scripts\utility::getfx("seo_intro_pod_hit_building"),var_01,"tag_origin");
	var_01 delete();
}

//Function Number: 41
intro_pod_hit_building1_flr1(param_00)
{
}

//Function Number: 42
intro_pod_hit_building1_flr2(param_00)
{
}

//Function Number: 43
intro_pod_hit_building1_flr3(param_00)
{
	level notify("hit_3");
}

//Function Number: 44
intro_pod_exit_building1(param_00)
{
	common_scripts\_exploder::exploder(426);
	level notify("hit_exit");
	wait(0.5);
	common_scripts\_exploder::exploder("building_piece_exit");
	level waittill("pod_land_apartment");
	common_scripts\_exploder::kill_exploder(426);
}

//Function Number: 45
intro_pod_hit_building_2(param_00)
{
	level notify("intro_pod_crash_end");
}

//Function Number: 46
intro_pod_hit_apartment(param_00)
{
	level notify("pod_land_apartment");
	playfxontag(common_scripts\utility::getfx("seo_intro_indoor_dpod_smk_low"),param_00,"tag_seat03");
	level waittill("player_drop_pod_door_kick");
	stopfxontag(common_scripts\utility::getfx("seo_intro_indoor_dpod_smk_low"),param_00,"tag_seat03");
}

//Function Number: 47
player_drop_pod_se_door_kick(param_00)
{
	level notify("player_drop_pod_door_kick");
	var_01 = common_scripts\utility::spawn_tag_origin();
	var_01 linkto(param_00,"emergencyShield_F",(0,-55,44),(0,0,0));
	playfxontag(common_scripts\utility::getfx("seo_intro_smoke_droppod_door_kick"),var_01,"tag_origin");
	common_scripts\_exploder::exploder("cormack_land");
	common_scripts\_exploder::exploder("cormack_sparks_pod_exit");
	wait(1.5);
	common_scripts\_exploder::exploder("cormack_smk_pod_exit");
	playfxontag(common_scripts\utility::getfx("seo_intro_smoke_droppod_door_trail"),param_00,"emergencyShield_F");
	level waittill("cormack_pod_exit_land");
	wait(1.5);
	maps\_utility::pauseexploder("cormack_smk_pod_exit");
	wait(6.5);
	maps\_utility::pauseexploder("cormack_sparks_pod_exit");
	maps\_utility::pauseexploder("cormack_land");
	stopfxontag(common_scripts\utility::getfx("seo_intro_smoke_droppod_door_trail"),param_00,"emergencyShield_F");
	stopfxontag(common_scripts\utility::getfx("seo_intro_smoke_droppod_door_kick"),var_01,"tag_origin");
	var_01 delete();
}

//Function Number: 48
cormack_pod_exit_impact(param_00)
{
	wait(0.95);
	level notify("cormack_pod_exit_land");
	common_scripts\_exploder::exploder("cormack_land_pulse");
	wait(1.5);
	common_scripts\_exploder::exploder("cormack_land_ground_smk");
	wait(5);
	maps\_utility::pauseexploder("cormack_land_ground_smk");
	wait(2.5);
	maps\_utility::pauseexploder("cormack_land_pulse");
}

//Function Number: 49
vfx_vm_exit_pod_start(param_00)
{
	wait(1.15);
	common_scripts\_exploder::exploder("player_land_dust");
	wait(2.85);
	common_scripts\_exploder::exploder("plank_a_fall");
	wait(0.5);
	common_scripts\_exploder::exploder("plank_b_fall");
	wait(3);
	common_scripts\_exploder::kill_exploder("player_land_dust");
	common_scripts\_exploder::kill_exploder("plank_a_fall");
	common_scripts\_exploder::kill_exploder("plank_b_fall");
}

//Function Number: 50
vista_ambientfx_double_layer_missile_hit()
{
	level waittill("player_drop_pod_door_kick");
	common_scripts\_exploder::exploder(514);
	maps\_utility::delaythread(0.5,::common_scripts\_exploder::exploder,513);
	maps\_utility::delaythread(1.15,::common_scripts\_exploder::exploder,510);
	soundscripts\_snd::snd_message("vista_rockets_first_impact",1.15);
	maps\_utility::delaythread(2.95,::common_scripts\_exploder::exploder,511);
	soundscripts\_snd::snd_message("vista_rockets_pod_door_view_01",2.95);
	maps\_utility::delaythread(3.8,::common_scripts\_exploder::exploder,512);
	soundscripts\_snd::snd_message("vista_rockets_pod_door_view_02",3.8);
	maps\_utility::delaythread(12.5,::common_scripts\_exploder::exploder,"planks_exit_pod");
	maps\_utility::delaythread(15,::vista_ambientfx_double_layer_missile_hit_loop);
	level waittill("reduce_falling_debris");
	maps\_utility::pauseexploder(514);
	maps\_utility::pauseexploder(513);
	wait(3);
	common_scripts\_exploder::kill_exploder("falling_planks_delayed");
}

//Function Number: 51
drop_pod_falling_debris(param_00)
{
	level notify("reduce_falling_debris");
	common_scripts\_exploder::exploder(516);
	common_scripts\_exploder::exploder("pod_fall_impact");
	common_scripts\_exploder::exploder("falling_pod_debris_delayed");
	wait(5.5);
	level notify("razorback_close_flyby");
	wait(3);
	maps\_utility::pauseexploder(516);
	wait(5);
	common_scripts\_exploder::kill_exploder(516);
}

//Function Number: 52
intro_apt_vf_debris()
{
	level waittill("player_drop_pod_door_kick");
	common_scripts\_exploder::exploder(550);
	common_scripts\_exploder::exploder(515);
	level waittill("razorback_close_flyby");
	maps\_utility::pauseexploder(550);
	wait(0.75);
	common_scripts\_exploder::exploder(518);
	wait(8.5);
	common_scripts\_exploder::exploder(550);
	maps\_utility::pauseexploder(518);
	maps\_utility::pauseexploder(515);
	common_scripts\utility::flag_wait("msg_kill_vista_effects");
	common_scripts\_exploder::kill_exploder(550);
	common_scripts\_exploder::kill_exploder(515);
	common_scripts\_exploder::kill_exploder(518);
}

//Function Number: 53
vista_warbird_fx(param_00)
{
	wait(0.2);
	var_01 = common_scripts\utility::spawn_tag_origin();
	var_01 linkto(param_00,"tag_origin",(750,0,0),(0,0,0));
	playfxontag(common_scripts\utility::getfx("seo_razorback_exhaust_vf"),var_01,"tag_origin");
	wait(9);
	killfxontag(common_scripts\utility::getfx("seo_razorback_exhaust_vf"),var_01,"tag_origin");
	wait 0.05;
	var_01 delete();
}

//Function Number: 54
vista_ambientfx_double_layer_missile_hit_loop()
{
	var_00 = [(37248.2,11820.8,2832.98),(42894.8,11372.5,2636.31),(50210.3,7562.85,6234.84),(42945.4,16874.8,7070.59),(47271.8,17453.9,3275.53),(55936.1,16433.1,3075.32),(41088.6,18506.4,3162.44),(41037.4,9530.78,2647.4),(64600.3,11066.8,5988.08),(68266.5,9232.31,10543.4),(61068,21072.8,10409.5),(58484.8,14175.9,2703.13),(71723.3,21651.3,5131.44),(61325.8,24560.5,6457.22),(52646.4,23999.2,7516.02),(39111.7,24757.6,5517.17),(46374.5,28799.3,3683.44),(40163.2,11633.8,2290.26),(50784.9,9634.92,4900.63),(43719.5,9752.69,2862.97),(50655.5,17477.7,2757.8),(42948.9,16174.9,1684.26)];
	var_01 = [(317.274,60.7162,-46.4446),(274.462,357.336,4.59093),(306.344,252.53,103.22),(301.463,347.926,21.8169),(286.056,261.911,129.895),(270.546,145.779,-115.708),(301.599,103.103,-75.5526),(286.184,267.974,111.448),(303.312,45.6195,-28.0795),(302.324,79.2434,-51.389),(301.842,328.002,50.7682),(299.039,26.4457,0),(304.256,44.4485,-14.5408),(320.809,68.0427,-30.5504),(313.019,41.1473,-11.9552),(300.192,79.293,-40.3705),(277.964,105.548,-64.6276),(300.893,45.364,-35.6416),(295.026,64.115,-56.164),(299.972,36.3014,-6.28162),(298.237,74.2218,-38.4403),(309.786,323.003,64.0178)];
	var_02 = 1.5;
	var_03 = 3;
	if(level.currentgen)
	{
		var_02 = 4;
		var_03 = 6;
	}

	thread maps\_shg_fx::start_fx_by_view("seo_ambexplo_air_nonlit_parent",var_00,var_02,var_03,"msg_kill_vista_effects",0,var_01,"vista_rockets");
}

//Function Number: 55
vista_ambientfx_aa_explosion()
{
	level waittill("vfx_player_control_after_pod_landed");
	var_00 = [(36210.7,14652.2,8160.87),(45354.8,14997.1,6843.54),(55689.4,25130.3,10717),(56449.7,17452.6,10262.1),(60257.2,15120.5,8782.32),(64128.6,19351.3,8901.14),(40725,10289.6,5116.15),(44382.5,10950.9,6366.63),(48337.3,9971.63,6199.79),(38822.9,12839.3,6901.36),(41024,12310,7177.62),(39944.9,20751.3,6313.89),(39069.8,23746.1,8848.57),(41151.6,21098.4,7912.78),(56550.7,12867,6430.22),(34102.9,14415.8,5333.08),(39061.1,19159.6,9122.57),(47962.6,7612.31,5788.81),(37904.4,11664.2,8489.08),(31800.7,16054.5,7325.43),(44536.2,3999.14,7857.06),(44649.5,3417.86,11396.8)];
	var_01 = [(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0)];
	var_02 = 2;
	var_03 = 2;
	if(level.currentgen)
	{
		var_02 = 4;
		var_03 = 4;
	}

	thread maps\_shg_fx::start_fx_by_view("aa_explosion_runner_single",var_00,var_02,var_03,"msg_kill_vista_effects",1,var_01,"seo_vista_amb_explos");
}

//Function Number: 56
vista_ambientfx_midair_explosion()
{
	level waittill("vfx_player_control_after_pod_landed");
	var_00 = [(38645.5,18055.3,4353.43),(50704.9,14364.3,3561.84),(43778.1,15611.2,3936.31),(35991.2,14052.8,3841.32),(44244.7,7213.38,4468.32),(43302.9,10371.4,3629.11),(49811,11470.7,5095.18),(50682,17398.6,5364.78),(45054.1,12724.6,7652.58),(36045.1,17432.6,5536.12),(41472.1,13800.8,7226.16),(39003.7,7673.85,6069.51)];
	var_01 = [(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0)];
	var_02 = 3;
	var_03 = 3;
	if(level.currentgen)
	{
		var_02 = 5;
		var_03 = 5;
	}

	thread maps\_shg_fx::start_fx_by_view("ambient_explosion_midair_runner_single",var_00,var_02,var_03,"msg_kill_vista_effects",1,var_01,"midair_exp_audio");
}

//Function Number: 57
ambient_fires_inside_building()
{
	common_scripts\utility::flag_wait_any("msg_fx_zone1_apartment_exit","msg_fx_zone1a_top_upper_mid_drop","msg_fx_zone1c_mid_lower_drop","msg_fx_zone1d_mid_lower_drop_exit","msg_fx_zone1e_mid_lower_apartment","msg_fx_zone1f_lower_apartment_exit_drop");
	common_scripts\_exploder::exploder(1050);
	common_scripts\utility::flag_wait("msg_fx_zone2c_base_transition_exit");
	common_scripts\_exploder::kill_exploder(1050);
}

//Function Number: 58
treadfx_override()
{
	wait(1);
	var_00[0] = "script_vehicle_mil_cargo_truck";
	var_01[0] = "script_vehicle_ft101_tank";
	var_02 = "vfx/treadfx/tread_dust_ft101_tank";
	var_03 = "vfx/treadfx/tread_dust_trucks";
	foreach(var_05 in var_01)
	{
		maps\_vehicle::set_vehicle_effect(var_05,"brick",var_02);
		maps\_vehicle::set_vehicle_effect(var_05,"bark",var_02);
		maps\_vehicle::set_vehicle_effect(var_05,"carpet",var_02);
		maps\_vehicle::set_vehicle_effect(var_05,"cloth",var_02);
		maps\_vehicle::set_vehicle_effect(var_05,"concrete",var_02);
		maps\_vehicle::set_vehicle_effect(var_05,"dirt",var_02);
		maps\_vehicle::set_vehicle_effect(var_05,"flesh",var_02);
		maps\_vehicle::set_vehicle_effect(var_05,"foliage",var_02);
		maps\_vehicle::set_vehicle_effect(var_05,"glass",var_02);
		maps\_vehicle::set_vehicle_effect(var_05,"grass",var_02);
		maps\_vehicle::set_vehicle_effect(var_05,"gravel",var_02);
		maps\_vehicle::set_vehicle_effect(var_05,"ice",var_02);
		maps\_vehicle::set_vehicle_effect(var_05,"metal",var_02);
		maps\_vehicle::set_vehicle_effect(var_05,"mud",var_02);
		maps\_vehicle::set_vehicle_effect(var_05,"paper",var_02);
		maps\_vehicle::set_vehicle_effect(var_05,"plaster",var_02);
		maps\_vehicle::set_vehicle_effect(var_05,"rock",var_02);
		maps\_vehicle::set_vehicle_effect(var_05,"sand",var_02);
		maps\_vehicle::set_vehicle_effect(var_05,"snow",var_02);
		maps\_vehicle::set_vehicle_effect(var_05,"water",var_02);
		maps\_vehicle::set_vehicle_effect(var_05,"wood",var_02);
		maps\_vehicle::set_vehicle_effect(var_05,"asphalt",var_02);
		maps\_vehicle::set_vehicle_effect(var_05,"ceramic",var_02);
		maps\_vehicle::set_vehicle_effect(var_05,"plastic",var_02);
		maps\_vehicle::set_vehicle_effect(var_05,"rubber",var_02);
		maps\_vehicle::set_vehicle_effect(var_05,"cushion",var_02);
		maps\_vehicle::set_vehicle_effect(var_05,"fruit",var_02);
		maps\_vehicle::set_vehicle_effect(var_05,"paintedmetal",var_02);
		maps\_vehicle::set_vehicle_effect(var_05,"riotshield",var_02);
		maps\_vehicle::set_vehicle_effect(var_05,"slush",var_02);
		maps\_vehicle::set_vehicle_effect(var_05,"default",var_02);
	}

	foreach(var_05 in var_00)
	{
		maps\_vehicle::set_vehicle_effect(var_05,"brick",var_03);
		maps\_vehicle::set_vehicle_effect(var_05,"bark",var_03);
		maps\_vehicle::set_vehicle_effect(var_05,"carpet",var_03);
		maps\_vehicle::set_vehicle_effect(var_05,"cloth",var_03);
		maps\_vehicle::set_vehicle_effect(var_05,"concrete",var_03);
		maps\_vehicle::set_vehicle_effect(var_05,"dirt",var_03);
		maps\_vehicle::set_vehicle_effect(var_05,"flesh",var_03);
		maps\_vehicle::set_vehicle_effect(var_05,"foliage",var_03);
		maps\_vehicle::set_vehicle_effect(var_05,"glass",var_03);
		maps\_vehicle::set_vehicle_effect(var_05,"grass",var_03);
		maps\_vehicle::set_vehicle_effect(var_05,"gravel",var_03);
		maps\_vehicle::set_vehicle_effect(var_05,"ice",var_03);
		maps\_vehicle::set_vehicle_effect(var_05,"metal",var_03);
		maps\_vehicle::set_vehicle_effect(var_05,"mud",var_03);
		maps\_vehicle::set_vehicle_effect(var_05,"paper",var_03);
		maps\_vehicle::set_vehicle_effect(var_05,"plaster",var_03);
		maps\_vehicle::set_vehicle_effect(var_05,"rock",var_03);
		maps\_vehicle::set_vehicle_effect(var_05,"sand",var_03);
		maps\_vehicle::set_vehicle_effect(var_05,"snow",var_03);
		maps\_vehicle::set_vehicle_effect(var_05,"water",var_03);
		maps\_vehicle::set_vehicle_effect(var_05,"wood",var_03);
		maps\_vehicle::set_vehicle_effect(var_05,"asphalt",var_03);
		maps\_vehicle::set_vehicle_effect(var_05,"ceramic",var_03);
		maps\_vehicle::set_vehicle_effect(var_05,"plastic",var_03);
		maps\_vehicle::set_vehicle_effect(var_05,"rubber",var_03);
		maps\_vehicle::set_vehicle_effect(var_05,"cushion",var_03);
		maps\_vehicle::set_vehicle_effect(var_05,"fruit",var_03);
		maps\_vehicle::set_vehicle_effect(var_05,"paintedmetal",var_03);
		maps\_vehicle::set_vehicle_effect(var_05,"riotshield",var_03);
		maps\_vehicle::set_vehicle_effect(var_05,"slush",var_03);
		maps\_vehicle::set_vehicle_effect(var_05,"default",var_03);
	}
}

//Function Number: 59
ambient_building_fires_fob_drone_swarm()
{
	common_scripts\utility::flag_wait_either("msg_fx_zone1g_building_ground_floor","msg_fx_zone1h_building_ground_floor_exit");
	common_scripts\_exploder::exploder(2050);
	common_scripts\utility::flag_wait("msg_fx_zone2f_performing_arts_front_streets");
	common_scripts\_exploder::kill_exploder(2050);
}

//Function Number: 60
drop_pod_fx_start(param_00)
{
	maps\_utility::delaythread(0,::drop_pod_thrusters,param_00);
	maps\_utility::delaythread(2.4,::drop_pod_ground_impact,param_00);
	maps\_utility::delaythread(2.97,::drop_pod_door_spark,param_00);
}

//Function Number: 61
drop_pod_thrusters(param_00)
{
	playfxontag(common_scripts\utility::getfx("drop_pod_hovering_thruster"),param_00,"tag_fx");
	playfxontag(common_scripts\utility::getfx("light_red_point"),param_00,"body_animate_joint");
	var_01 = common_scripts\utility::spawn_tag_origin();
	var_01 linkto(param_00,"jetlid01",(-15,0,-15),(-75,0,0));
	playfxontag(common_scripts\utility::getfx("drop_pod_hovering_side_spray"),var_01,"tag_origin");
	var_02 = common_scripts\utility::spawn_tag_origin();
	var_02 linkto(param_00,"jetlid02",(-15,0,-15),(-75,0,0));
	playfxontag(common_scripts\utility::getfx("drop_pod_hovering_side_spray"),var_02,"tag_origin");
	var_03 = common_scripts\utility::spawn_tag_origin();
	var_03 linkto(param_00,"jetlid03",(-15,0,-15),(-75,0,0));
	playfxontag(common_scripts\utility::getfx("drop_pod_hovering_side_spray"),var_03,"tag_origin");
	wait(1.5);
	stopfxontag(common_scripts\utility::getfx("drop_pod_hovering_thruster"),param_00,"tag_fx");
	playfxontag(common_scripts\utility::getfx("drop_pod_hovering_thruster_short"),param_00,"tag_fx");
	wait(0.5);
	stopfxontag(common_scripts\utility::getfx("drop_pod_hovering_thruster_short"),param_00,"tag_fx");
	playfxontag(common_scripts\utility::getfx("drop_pod_hovering_thruster_idle"),param_00,"tag_fx");
	wait(0.4);
	stopfxontag(common_scripts\utility::getfx("drop_pod_hovering_side_spray"),var_01,"tag_origin");
	stopfxontag(common_scripts\utility::getfx("drop_pod_hovering_side_spray"),var_02,"tag_origin");
	stopfxontag(common_scripts\utility::getfx("drop_pod_hovering_side_spray"),var_03,"tag_origin");
	stopfxontag(common_scripts\utility::getfx("drop_pod_hovering_thruster_idle"),param_00,"tag_fx");
	wait(1);
	var_01 delete();
	var_02 delete();
	var_03 delete();
}

//Function Number: 62
drop_pod_ground_impact(param_00)
{
	playfxontag(common_scripts\utility::getfx("drop_pod_landing_impact_ground"),param_00,"tag_fx");
	earthquake(0.2,2.4,param_00.origin,1600);
}

//Function Number: 63
drop_pod_door_spark(param_00)
{
	playfxontag(common_scripts\utility::getfx("seo_smoke_inside_droppod"),param_00,"tag_fx");
	wait(0.08);
	var_01 = common_scripts\utility::spawn_tag_origin();
	var_01 linkto(param_00,"door_l",(0,-22,18),(0,0,0));
	playfxontag(common_scripts\utility::getfx("seo_spark_droppod_door"),var_01,"tag_origin");
	wait(0.2);
	playfxontag(common_scripts\utility::getfx("seo_dust_droppod_door"),var_01,"tag_origin");
	wait(0.3);
	stopfxontag(common_scripts\utility::getfx("seo_spark_droppod_door"),var_01,"tag_origin");
	wait(8);
	stopfxontag(common_scripts\utility::getfx("seo_dust_droppod_door"),var_01,"tag_origin");
	wait(9);
	var_01 delete();
}

//Function Number: 64
operating_base_ambientfx_aa_explosion()
{
	common_scripts\utility::flag_wait("msg_fx_zone1g_building_ground_floor");
	var_00 = [(39706.8,7364.95,3787.97),(41744.8,6513.87,5167.98),(36254.4,6589.42,5594.72),(41582.5,7218.63,6263.39),(38666.2,6430.67,5577.53),(33116.6,10478.5,5283.48),(32457.3,10173.9,4658.38),(33590.3,10802.5,4932.49),(32603.2,12523.4,4942.57),(33250.6,14258.6,5101.59),(32441.1,15134.6,5009.57),(33170.5,13396.3,5996.27),(32664.2,8327.6,4427.43),(32007.2,7017.7,4131.72),(30808.1,6205.91,4167.07),(29659.3,6757.48,4177.66),(28831.3,7264.32,4163.3),(27636.6,7206.11,4163.36),(24964,6014.37,3873.08),(24150.9,6594.85,3831.86),(22737,7299.3,4529.88),(21922.2,7626.72,3826.67),(22561.7,7526.72,3050.05),(23974.3,7550.19,5021.09),(24663.2,7743.52,5601.32),(29432.6,7745.94,5281.9),(28065.7,8004.78,5236.24),(32873.9,7562.23,6214.77),(33852.2,12597.1,5455.86),(21424.8,7414.86,3347.97),(33463.8,4498.81,3967.99),(33558.7,2352.95,4582.99),(33783.4,2800.75,3716.83),(32525.4,2849.96,5304.87),(33344.1,353.564,4846.05),(33425.9,-444.337,3927.48),(33776.2,-1330.47,3498.71),(33223.4,-2106.21,2997.18),(33724.3,4524.73,4941.85)];
	var_01 = [(325,270,90.0001),(325,270,90.0001),(325,270,90.0001),(325,270,90.0001),(325,270,90.0001),(325,270,90.0001),(325,270,90.0001),(325,270,90.0001),(325,270,90.0001),(325,270,90.0001),(325,270,90.0001),(325,270,90.0001),(325,270,90.0001),(325,270,90.0001),(325,270,90.0001),(325,270,90.0001),(325,270,90.0001),(325,270,90.0001),(325,270,90.0001),(325,270,90.0001),(325,270,90.0001),(325,270,90.0001),(325,270,90.0001),(325,270,90.0001),(325,270,90.0001),(325,270,90.0001),(325,270,90.0001),(325,270,90.0001),(325,270,90.0001),(325,270,90.0001),(325,270,90.0001),(325,270,90.0001),(325,270,90.0001),(325,270,90.0001),(325,270,90.0001),(325,270,90.0001),(325,270,90.0001),(325,270,90.0001),(325,270,90.0001)];
	var_02 = 2;
	var_03 = 3;
	if(level.currentgen)
	{
		var_02 = 3;
		var_03 = 4;
	}

	thread maps\_shg_fx::start_fx_by_view("aa_explosion_runner_single",var_00,var_02,var_03,"drone_swarm_spawning",1,var_01,"seo_ambient_ground_explosions");
}

//Function Number: 65
operating_base_ambientfx_midair_explosion()
{
	common_scripts\utility::flag_wait("msg_fx_zone1g_building_ground_floor");
	var_00 = [(42737.4,7729.02,6388.53),(41670.3,6273.3,4241.59),(39106.2,7632.25,7039.9),(46053.3,5782.94,8297.88),(34995,7098.67,7360.77),(33486.7,4304.55,5200.59),(30754.7,788.31,6882.38),(34145.8,-4333.05,4327.99),(33407,-5682.39,3219.17),(33257.4,-7407.13,6830.06),(33093.7,2112.89,4909.4),(25475.1,6304.97,6153.4),(27725.5,7809.92,4876.12),(24778,7117.3,4404.86),(28958.4,8758.86,4007.37),(23607.4,6859.45,2602.75),(21591.3,7663.32,4476.6),(31026.2,7151.62,5116.4),(32940.4,8497.24,3642.05),(32977.2,9761.04,3754.89),(33478.3,12149.7,4476.57),(32211.4,19975.9,6028.53),(33100.2,15269.4,3311.98),(36125.3,6636.09,4551.85),(34034.3,1021.8,3706.59),(37648.6,7012.36,4205.99)];
	var_01 = [(325,270,90.0001),(325,270,90.0001),(325,270,90.0001),(325,270,90.0001),(325,270,90.0001),(325,270,90.0001),(325,270,90.0001),(325,270,90.0001),(325,270,90.0001),(325,270,90.0001),(325,270,90.0001),(325,270,90.0001),(325,270,90.0001),(325,270,90.0001),(325,270,90.0001),(325,270,90.0001),(325,270,90.0001),(325,270,90.0001),(325,270,90.0001),(325,270,90.0001),(325,270,90.0001),(325,270,156),(325,270,156),(325,270,90.0001),(325,270,90.0001),(325,270,90.0001)];
	var_02 = 4;
	var_03 = 4;
	if(level.currentgen)
	{
		var_02 = 6;
		var_03 = 6;
	}

	thread maps\_shg_fx::start_fx_by_view("ambient_explosion_midair_runner_single",var_00,var_02,var_02,"drone_swarm_spawning",1,var_01,"midair_exp_audio");
}

//Function Number: 66
operating_base_ambientfx_ground_fireball_explosion()
{
	common_scripts\utility::flag_wait("msg_fx_zone1g_building_ground_floor");
	var_00 = [(33804.2,4314.53,1320.13),(33315.4,3566.97,1318),(35060.3,7155.24,1313.7),(33335.2,10154.7,1318),(31464.5,6406.76,1622.03),(31122,7724.05,1425.83),(28311.1,6502.85,1332.66),(29088.4,7718.85,1320.7),(27895.2,6849.89,1363.14),(27098.8,7447.25,1316.52),(25533.8,6682.31,1322.75),(33974.3,5589.48,1320.13),(35646.8,7660.74,1320.12),(36321.3,7648.72,1320.13),(36228.9,7200.14,1316.25),(32958.1,8910.46,1320.13),(33726.3,4534.13,1312.13),(33306.1,4379.92,1317.81),(33336.2,4967.27,1318)];
	var_01 = [(272.896,355.302,2.88336),(272.896,355.302,2.88336),(272.896,355.302,2.88336),(272.896,355.302,2.88336),(272.896,355.302,2.88336),(272.896,355.302,2.88336),(272.896,355.302,2.88336),(272.896,355.302,2.88336),(272.896,355.302,2.88336),(272.896,355.302,2.88336),(272.896,355.302,2.88336),(272.896,355.302,2.88336),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0)];
	var_02 = 3;
	var_03 = 5;
	if(level.currentgen)
	{
		var_02 = 4;
		var_03 = 6;
	}

	thread maps\_shg_fx::start_fx_by_view("ambient_explosion_fireball",var_00,var_02,var_03,"drone_swarm_spawning",0,var_01,"seo_fireball_explosions");
}

//Function Number: 67
operating_base_ambientfx_ground_dirt_explosion()
{
	common_scripts\utility::flag_wait("msg_fx_zone1g_building_ground_floor");
	var_00 = [(32978.9,8247.27,1320),(32777.9,7756.39,1312),(32320.2,7485.5,1395.12),(31433.6,6541.24,1574.92),(32491.7,7188.83,1323.86),(31585.4,6892,1504.03),(30967.6,7795.14,1413.85),(30654.4,7190,1333.07),(29524.9,6533.67,1320.13),(28911.4,7745.67,1320.13),(28252.6,6627.92,1313.66),(28515.9,6486.84,1320.13),(27688.5,6603.75,1313.59),(27336.9,7529.39,1369.23),(27280.8,7332.12,1324.61),(27494.9,6901.42,1316.58),(28732.9,6743.7,1313.85),(34174.8,7099.23,1313.31),(33028,5890.05,1320),(33472.1,9206.64,1318),(34533.8,6910.23,1313.31),(34591,6737.23,1313.31),(34824,7529.23,1313.31)];
	var_01 = [(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0)];
	var_02 = 2;
	var_03 = 3;
	if(level.currentgen)
	{
		var_02 = 3;
		var_03 = 4;
	}

	thread maps\_shg_fx::start_fx_by_view("ambient_explosion_dirt_runner",var_00,var_02,var_03,"drone_swarm_spawning",0,var_01,"seo_dirt_explosions","incoming_complete");
}

//Function Number: 68
operating_base_ambientfx_window_glass_explosion()
{
	common_scripts\utility::flag_wait("msg_fx_zone1g_building_ground_floor");
	var_00 = [(32931.3,5616.93,2719.08),(32570,6181.42,2948.47),(34025.2,4354.23,2631.91),(32665.6,4382.96,2298.41),(29272.1,8064.89,2048.39),(28665.4,7942.02,2392.9),(26774.5,7944.2,2586.02),(26051.9,6356.72,2193.5),(25635.9,6385.51,2699.67),(28033.9,6300.82,2824.07),(30223.4,6351.25,2240.46),(30554.5,6353.28,1846.43),(32587.1,6135.25,2369.42),(32876.2,9549.66,2233.43),(34023.7,10241.4,2297.48),(32760.9,11850.4,2883.07),(32743.8,10777.9,3250.45),(32650.4,4699.09,1914.55),(26641.2,6386.28,3307.7),(22061.6,8231.4,3009.29),(21902.4,6410.12,3757.95),(18738,7665.49,3650.76),(30647.2,7907.05,2851.39),(31019.7,7927.87,2965.9),(31576.3,7912.18,2864.32),(36165.9,6344.76,2026.09),(35160.6,6421.99,2074.39),(35689.7,6331.95,2157.65),(37016.2,6261.39,2263.9),(38398.8,6376.39,2056.88),(38342.4,6347.33,2752.26),(39136.6,6408.72,2625.55),(38532.3,7688.76,2618.67),(37528,7676.56,2840.73),(37685.5,7683.24,1838.28),(36206.2,7846.29,2126.38),(35055,7814.41,2131.69),(32518.3,7963.73,2378.12),(29260.6,5917.3,2657.11),(29270.1,5349.32,4455.93),(29242.9,5968.4,5022.47),(25929.4,6388.23,3619.89),(32627.1,3342.02,3713.88)];
	var_01 = [(8.81446,37.6413,84.4919),(358.261,44.9997,0),(359.376,168.015,-2.93494),(0,0,0),(0,270,0),(0,270,0),(348,270,0),(0,90,0),(0,90,0),(332.717,56.3284,17.9036),(0,90,0),(341.117,72.9015,3.77778),(0,45.0002,0),(0,342,0),(353.762,171.025,-16.386),(331.559,341.076,-29.1803),(345.445,336.787,-22.6363),(0,0,0),(10.1661,59.7082,164.756),(329.176,274.248,-1.64365),(10.0916,220.803,0),(339.668,356.573,-6.13818),(0,270,0),(0,270,0),(0,270,0),(358.499,107.523,22.001),(0,90,0),(0,90,0),(352.938,105.261,22.17),(358.499,107.523,22.001),(358.499,107.523,22.001),(358.499,107.523,22.001),(352.98,266.114,-20.9557),(352.98,266.114,-20.9557),(352.98,266.114,-20.9557),(352.98,266.114,-20.9557),(352.98,266.114,-20.9557),(4.98596,278.572,-15.7912),(16.1828,3.75614,3.46789),(16.1828,3.75614,3.46789),(16.1828,3.75614,3.46789),(0.315703,78.2339,13.579),(354,82.9987,0)];
	var_02 = 2;
	var_03 = 3;
	if(level.currentgen)
	{
		var_02 = 2;
		var_03 = 4;
	}

	thread maps\_shg_fx::start_fx_by_view("ambient_explosion_windowglass",var_00,var_02,var_03,"drone_swarm_spawning",0,var_01,"midair_exp_glass");
}

//Function Number: 69
titan_camera_shake(param_00)
{
	earthquake(0.2,1.8,param_00.origin,1600);
	wait(1);
	earthquake(0.2,1.8,param_00.origin,1600);
}

//Function Number: 70
titan_impact_fx_fl(param_00)
{
	param_00 endon("death");
	common_scripts\_exploder::exploder(2054);
	wait(0.08);
	playfxontag(common_scripts\utility::getfx("titan_tread_impact"),param_00,"frontWheelTread07_FL");
	common_scripts\_exploder::exploder(2100);
	earthquake(0.3,1.8,param_00.origin,1600);
	wait(2.5);
	common_scripts\_exploder::exploder(2010);
	playfxontag(common_scripts\utility::getfx("rocks_falling_m"),param_00,"frontWheelTread07_FL");
	wait(1);
	common_scripts\_exploder::exploder(2065);
	common_scripts\_exploder::exploder(2150);
	wait(1.5);
	playfxontag(common_scripts\utility::getfx("titan_tread_impact"),param_00,"frontWheelTread07_FL");
	earthquake(0.3,1.8,param_00.origin,1600);
	wait(4.5);
	playfxontag(common_scripts\utility::getfx("titan_tread_impact"),param_00,"frontWheelTread07_FL");
	earthquake(0.2,1.8,param_00.origin,1600);
	wait(4);
	playfxontag(common_scripts\utility::getfx("titan_tread_impact"),param_00,"frontWheelTread07_FL");
	earthquake(0.2,1.8,param_00.origin,800);
	wait(3);
	playfxontag(common_scripts\utility::getfx("titan_tread_impact"),param_00,"frontWheelTread07_FL");
	earthquake(0.2,1.8,param_00.origin,800);
	wait(1);
	playfxontag(common_scripts\utility::getfx("titan_tread_impact"),param_00,"frontWheelTread07_FL");
	earthquake(0.2,1.8,param_00.origin,800);
	wait(4.9);
	playfxontag(common_scripts\utility::getfx("titan_tread_impact"),param_00,"frontWheelTread07_FL");
	earthquake(0.2,1.8,param_00.origin,800);
	wait(4.8);
	thread titan_tank_tread(param_00);
}

//Function Number: 71
titan_impact_fx_fr(param_00)
{
	param_00 endon("death");
	wait(0.2);
	playfxontag(common_scripts\utility::getfx("titan_tread_impact"),param_00,"frontWheelTread07_FR");
	earthquake(0.3,1.8,param_00.origin,2000);
	wait(2);
	common_scripts\_exploder::exploder(2055);
	wait(2.5);
	playfxontag(common_scripts\utility::getfx("titan_tread_impact"),param_00,"frontWheelTread07_FR");
	earthquake(0.3,1.8,param_00.origin,1600);
	common_scripts\_exploder::exploder(2025);
	common_scripts\_exploder::exploder(2060);
	thread titan_walker_explosions();
	wait(4.5);
	playfxontag(common_scripts\utility::getfx("titan_tread_impact"),param_00,"frontWheelTread07_FR");
	earthquake(0.2,1.8,param_00.origin,1600);
	wait(4.5);
	playfxontag(common_scripts\utility::getfx("titan_tread_impact"),param_00,"frontWheelTread07_FR");
	earthquake(0.2,1.8,param_00.origin,800);
	wait(4.3);
	playfxontag(common_scripts\utility::getfx("titan_tread_impact"),param_00,"frontWheelTread07_FR");
	earthquake(0.2,1.8,param_00.origin,800);
	wait(4.3);
	playfxontag(common_scripts\utility::getfx("titan_tread_impact"),param_00,"frontWheelTread07_FR");
	earthquake(0.2,1.8,param_00.origin,800);
	wait(4.4);
	playfxontag(common_scripts\utility::getfx("titan_tread_impact"),param_00,"frontWheelTread07_FR");
	earthquake(0.2,1.8,param_00.origin,800);
}

//Function Number: 72
titan_impact_fx_rr(param_00)
{
	param_00 endon("death");
	common_scripts\_exploder::exploder(2026);
	wait(0.1);
	playfxontag(common_scripts\utility::getfx("titan_tread_impact"),param_00,"frontWheelTread06_KR");
	common_scripts\_exploder::exploder(2055);
	earthquake(0.2,1.8,param_00.origin,1600);
	wait(1.5);
	common_scripts\_exploder::exploder(2025);
	wait(0.3);
	playfxontag(common_scripts\utility::getfx("titan_tread_impact"),param_00,"frontWheelTread06_KR");
	earthquake(0.2,1.8,param_00.origin,1600);
	common_scripts\_exploder::exploder(2060);
	wait(4.4);
	playfxontag(common_scripts\utility::getfx("titan_tread_impact"),param_00,"frontWheelTread06_KR");
	earthquake(0.2,1.8,param_00.origin,1600);
	wait(4.4);
	playfxontag(common_scripts\utility::getfx("titan_tread_impact"),param_00,"frontWheelTread06_KR");
	earthquake(0.2,1.8,param_00.origin,800);
	wait(4.4);
	playfxontag(common_scripts\utility::getfx("titan_tread_impact"),param_00,"frontWheelTread06_KR");
	earthquake(0.2,1.8,param_00.origin,800);
	wait(4);
	playfxontag(common_scripts\utility::getfx("titan_tread_impact"),param_00,"frontWheelTread06_KR");
	earthquake(0.2,1.8,param_00.origin,800);
	common_scripts\_exploder::exploder(2026);
}

//Function Number: 73
titan_impact_fx_rl(param_00)
{
	param_00 endon("death");
	playfxontag(common_scripts\utility::getfx("titan_tread_impact"),param_00,"frontWheelTread06_KL");
	earthquake(0.2,1.8,param_00.origin,1600);
	wait(0.8);
	common_scripts\_exploder::exploder(2054);
	wait(1.5);
	common_scripts\_exploder::exploder(2100);
	wait(0.5);
	common_scripts\_exploder::exploder(2010);
	wait(2);
	playfxontag(common_scripts\utility::getfx("titan_tread_impact"),param_00,"frontWheelTread06_KL");
	earthquake(0.2,1.8,param_00.origin,1600);
	common_scripts\_exploder::exploder(2150);
}

//Function Number: 74
titan_walker_explosions()
{
	common_scripts\_exploder::exploder(2053);
	soundscripts\_snd::snd_message("titan_walker_explo",2053);
	wait(0.3);
	common_scripts\_exploder::exploder(2052);
	soundscripts\_snd::snd_message("titan_walker_explo",2052);
	wait(0.2);
	common_scripts\_exploder::exploder(2051);
	soundscripts\_snd::snd_message("titan_walker_explo",2051);
	wait(0.2);
	common_scripts\_exploder::exploder(2056);
	soundscripts\_snd::snd_message("titan_walker_explo",2056);
}

//Function Number: 75
titan_tank_tread(param_00)
{
	if(!isdefined(param_00))
	{
		return;
	}

	param_00 endon("death");
	var_01 = common_scripts\utility::spawn_tag_origin();
	var_01 linkto(param_00,"ankle_fr",(-50,0,10),(0,0,0));
	playfxontag(common_scripts\utility::getfx("titan_tread_kickup_front"),var_01,"tag_origin");
	playfxontag(common_scripts\utility::getfx("titan_tread_kickup_front"),param_00,"frontwheeltread05_fl");
	wait(0.5);
	if(!isdefined(param_00))
	{
		return;
	}

	playfxontag(common_scripts\utility::getfx("titan_tread_kickup_back"),param_00,"ankle_KR");
	playfxontag(common_scripts\utility::getfx("titan_tread_kickup_back"),param_00,"ankle_Kl");
}

//Function Number: 76
drone_street_lights()
{
	common_scripts\utility::flag_wait("msg_fx_zone2d_drone_swarm_street");
	common_scripts\_exploder::exploder("seo_street_lights");
	common_scripts\utility::flag_wait("msg_fx_zone4_sinkhole_traverse");
	common_scripts\_exploder::kill_exploder("seo_street_lights");
}

//Function Number: 77
drone_search_light_fx()
{
	wait(0.1);
	playfxontag(common_scripts\utility::getfx("drone_beacon_red_slow_nolight"),self,"TAG_FX_BEACON_0");
	playfxontag(common_scripts\utility::getfx("drone_beacon_red_slow_nolight"),self,"TAG_FX_BEACON_1");
	playfxontag(common_scripts\utility::getfx("drone_beacon_red_fast"),self,"TAG_FX_BEACON_2");
}

//Function Number: 78
drone_spot_light(param_00)
{
	if(isalive(self))
	{
		playfxontag(common_scripts\utility::getfx("drone_search_lt"),param_00,"tag_origin");
	}
}

//Function Number: 79
car_door_snap_will(param_00)
{
	common_scripts\_exploder::exploder(2220);
}

//Function Number: 80
car_door_snap_player(param_00)
{
}

//Function Number: 81
exo_truck_push(param_00)
{
}

//Function Number: 82
cormack_perarts_jump_explosions(param_00)
{
	wait(1.1);
	common_scripts\_exploder::exploder(3629);
	wait(1.3);
	common_scripts\_exploder::exploder(3626);
	soundscripts\_snd::snd_message("seo_per_arts_jump_explo_3",3626);
	wait(0.15);
	common_scripts\_exploder::exploder(3627);
	soundscripts\_snd::snd_message("seo_per_arts_jump_explo_3",3627);
	wait(2.3);
	common_scripts\_exploder::exploder(3623);
	soundscripts\_snd::snd_message("seo_per_arts_jump_explo_3",3623);
}

//Function Number: 83
will_perarts_jump_explosions(param_00)
{
	wait(1.9);
	common_scripts\_exploder::exploder(3622);
	soundscripts\_snd::snd_message("seo_per_arts_jump_explo_3",3622);
	wait(2.65);
	wait(6.65);
	common_scripts\_exploder::exploder(3621);
	soundscripts\_snd::snd_message("seo_per_arts_jump_explo_3",3621);
}

//Function Number: 84
player_perarts_jump_explosions()
{
	common_scripts\utility::flag_wait("performingarts_exit_explosions");
	common_scripts\_exploder::exploder(3631);
	common_scripts\_exploder::exploder(3622);
	wait(0.17);
	common_scripts\_exploder::exploder(3624);
	soundscripts\_snd::snd_message("seo_per_arts_jump_explo_3",3624);
	common_scripts\_exploder::exploder(3628);
	soundscripts\_snd::snd_message("seo_per_arts_jump_explo_3",3628);
	wait(1.05);
	common_scripts\_exploder::exploder(3626);
	soundscripts\_snd::snd_message("seo_per_arts_jump_explo_3",3626);
	wait(2.65);
	common_scripts\_exploder::exploder(3623);
	soundscripts\_snd::snd_message("seo_per_arts_jump_explo_3",3623);
	wait(3.35);
	common_scripts\_exploder::exploder(3625);
	soundscripts\_snd::snd_message("seo_per_arts_jump_explo_3",3625);
}

//Function Number: 85
player_presinkhole_jump_pipeburst()
{
	common_scripts\utility::flag_wait("midjump_pipe_burst");
	maps\_utility::delaythread(0.35,::common_scripts\_exploder::exploder,4023);
}

//Function Number: 86
player_presinkhole_debris()
{
	common_scripts\utility::flag_wait("fx_prepipe_burst_debris");
	common_scripts\_exploder::exploder(4024);
}

//Function Number: 87
weaponplf_flyby_dustfx_sinkhole(param_00)
{
	wait(3);
	var_01 = common_scripts\utility::spawn_tag_origin();
	var_01 linkto(param_00,"tag_origin",(0,-500,-50),(90,0,0));
	playfxontag(common_scripts\utility::getfx("weaponplf_tread_smk_sinkhole"),var_01,"TAG_ORIGIN");
	wait(10);
	stopfxontag(common_scripts\utility::getfx("weaponplf_tread_smk_sinkhole"),var_01,"TAG_ORIGIN");
	wait 0.05;
	var_01 delete();
}

//Function Number: 88
sinkhole_ambientfx_aa_explosions()
{
	common_scripts\utility::flag_wait("msg_fx_zone3b_transition_lobby");
	var_00 = [(22502.7,14535.2,4702.46),(23569.3,13543.8,4432.45),(23931.9,16851.7,9235.49),(23609.5,11498.4,5512.78),(21458.8,15618,4870.65),(23189.1,18027.9,5984.3),(22752.5,11295.8,2996.73),(22876.8,19240.9,4358.8),(20954.3,16291.2,3522.39),(22649,13195,3076.32),(22143.9,20790.7,7324.31),(23167.1,15297.2,5433.97),(25200.6,10847.7,3849.67),(22754,12019,3286.13),(23876.1,19712.5,6844.53),(23963.6,15975.5,3751.77),(23271.3,10070.4,4623.79),(23810.8,13616.4,7628.76),(23873.7,17237,3108.3),(22784.4,16459,4049.49),(22914.7,14416.8,3772.56),(23464.1,15291.1,3508.37),(23608.1,19241.3,3205.12)];
	var_01 = [(270,0,0),(276,90.0005,-90.0005),(276,90.0005,-90.0005),(270,0,0),(276,90.0005,-90.0005),(276,90.0005,-90.0005),(270,0,0),(276,90.0005,-90.0005),(276,90.0005,-90.0005),(270,0,0),(276,90.0005,-90.0005),(276,90.0005,-90.0005),(276,90.0005,-90.0005),(276,90.0005,-90.0005),(276,90.0005,-90.0005),(276,90.0005,-90.0005),(276,90.0005,-90.0005),(276,90.0005,-90.0005),(276,90.0005,-90.0005),(270,0,0),(270,0,0),(270,0,0),(276,90.0005,-90.0005)];
	var_02 = 1;
	var_03 = 4;
	if(level.currentgen)
	{
		var_02 = 2;
		var_03 = 6;
	}

	thread maps\_shg_fx::start_fx_by_view("aa_explosion_runner_single",var_00,var_02,var_03,"msg_fx_zone5_subway_traverse",0,var_01,"seo_ambient_ground_explosions");
}

//Function Number: 89
sinkhole_ambientfx_midair_explosions()
{
	common_scripts\utility::flag_wait("msg_fx_zone3b_transition_lobby");
	var_00 = [(19561.7,14358.8,7855.85),(23381.2,16616.7,7193.57),(23065.7,12406.3,5605.04),(25865.7,16393.7,6140.61),(19781.9,16340.8,4896.5),(23344.2,11032.9,3512.27),(24393.1,20192.7,6396.58),(22130,14220.2,8568.02),(22927.8,20117.1,4441.94),(22355.5,18627.7,5889.03),(19868.2,17651.6,7869.9),(24004.8,13214.9,7180.08)];
	var_01 = [(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,6.99978)];
	var_02 = 4;
	var_03 = 6;
	if(level.currentgen)
	{
		var_02 = 6;
		var_03 = 9;
	}

	thread maps\_shg_fx::start_fx_by_view("ambient_explosion_midair_runner_single",var_00,var_02,var_03,"msg_fx_zone5_subway_traverse",0,var_01,"midair_exp_audio");
}

//Function Number: 90
sinkhole_ambientfx_windowglass_explosions()
{
	common_scripts\utility::flag_wait("msg_fx_zone3b_transition_lobby");
	var_00 = [(22343.4,17036.6,3069.37),(22172.6,16485.1,2483.94),(22203.7,15300.9,3269.26),(22440.7,14812.2,2346.9),(22357.7,18189.7,2126.12),(22047.6,12777,3498.63),(22020,13418.3,2452.88),(22185.1,11180.9,2212.87),(22294.2,12043.5,2770.86),(24190.8,13868,1968.74),(24153.6,13588.5,2910.74),(24508.8,18607.7,2682.51),(24408.8,15682.3,2504.3),(24696.9,15438.7,3157.09),(24652.9,14321.2,3128.48),(24594.1,14878.8,3737.88),(24023.3,11849.2,3155.23),(24064.7,12434.5,4098.73),(24619.5,16973.7,3836.94),(22337.8,16722.5,1979.63),(22463.8,18570.7,2909.95),(24592.3,17357.2,2865.81),(24367.8,16711.8,1921.14),(24048.3,12936.8,2648.72),(22066.7,12835.6,1896.32),(22012.2,13439.8,3999.76),(22000.9,12068.9,4253.05),(24568.1,19250.7,3805.39),(24631.9,18304.1,4223.44),(24624,15029.7,2318.68),(24184.1,13858,3652.21),(24316.5,15847.1,1708.52),(22412.8,18576.2,3798.64),(28349.1,20105.6,5557.89),(28127.4,21234.2,4239.43),(27913.8,20186.6,3736.27),(24865.8,16770,3634.88),(22185.5,16647.2,3843.66)];
	var_01 = [(310.604,18.851,88.3745),(298.033,267.236,92.1158),(292.04,93.8968,88.0517),(292.04,93.8968,88.0517),(287.076,0.838317,87.211),(303.635,4.6619,84.5934),(303.635,4.6619,84.5934),(303.635,4.6619,84.5934),(303.635,4.6619,84.5934),(288.289,154.274,73.4309),(291.94,161.811,95.2791),(287.877,187.986,91.4042),(283.88,238.568,96.9997),(288.77,153.77,58.0726),(286.655,138.812,130.331),(286.655,138.812,129.332),(291.94,161.811,95.2791),(291.94,161.811,95.2791),(303.515,194.988,106.637),(284.035,4.87632,81.9537),(287.076,0.838317,87.211),(287.877,187.986,91.4042),(287.935,194.492,116.213),(291.94,161.811,95.2791),(303.635,4.6619,84.5934),(303.635,4.6619,84.5934),(303.635,4.6619,84.5934),(287.877,187.986,91.4042),(294.99,195.508,166.571),(286.655,138.812,130.331),(294.928,162.465,79.6783),(283.729,3.60388,-95.1458),(279.836,63.3974,60.694),(279.836,63.3974,60.694),(279.836,63.3974,60.694),(279.836,63.3974,60.694),(298.594,290.405,51.0204),(305.777,273.643,94.1099)];
	var_02 = 2;
	var_03 = 4;
	if(level.currentgen)
	{
		var_02 = 3;
		var_03 = 5;
	}

	thread maps\_shg_fx::start_fx_by_view("ambient_explosion_windowglass",var_00,var_02,var_03,"msg_fx_zone5_subway_traverse",0,var_01,"midair_exp_glass_audio");
}

//Function Number: 91
subway_bombshakes()
{
	common_scripts\utility::flag_wait("msg_fx_zone5_subway_traverse");
	var_00 = common_scripts\utility::spawn_tag_origin();
	var_00.origin = self.player getorigin();
	var_00.angles = (270,0,-45);
	if(!isdefined(level.bombshake_interval))
	{
		level.bombshake_interval = 6;
		level.bombshake_interval_rand = 5;
	}

	for(;;)
	{
		common_scripts\utility::flag_waitopen("msg_fx_zone6_escalator_exit_shopping");
		if(common_scripts\utility::flag("msg_fx_zone5_subway_traverse"))
		{
			var_01 = 1008;
			var_00.origin = self.player getorigin();
			var_02 = bullettrace(self.player.origin + (0,0,12),self.player.origin + (0,0,1200),0,undefined);
			var_03 = distance(var_00.origin,var_02["position"]);
			if(var_03 < 200)
			{
				soundscripts\_snd::snd_message("subway_bomb_shake");
				maps\_shg_fx::fx_bombshakes("dust_falling_debris_01","viewmodel_medium",0.127,2,0.3,0.53);
			}
		}

		var_04 = randomfloatrange(level.bombshake_interval_rand * -1,level.bombshake_interval_rand) + level.bombshake_interval;
		wait(var_04);
	}
}

//Function Number: 92
cigarette_light(param_00)
{
	wait(0.9);
	playfxontag(common_scripts\utility::getfx("cigarette_smk_light"),param_00,"tag_inhand");
}

//Function Number: 93
roof_breach_anticipation_fx()
{
	common_scripts\_exploder::exploder("breach_downward_anticipation");
}

//Function Number: 94
roof_breach_fx(param_00)
{
	common_scripts\_exploder::exploder("breach_downward");
}

//Function Number: 95
subway_exit_lights()
{
	common_scripts\utility::flag_wait("msg_fx_zone5a_subway_ceiling_breach");
	common_scripts\_exploder::exploder("exp_subway_exit_lights");
	common_scripts\utility::flag_wait("msg_fx_zone6b_shopping_narrow_alley");
	common_scripts\_exploder::kill_exploder("exp_subway_exit_lights");
}

//Function Number: 96
shoping_district_ambientfx_aa_explosion()
{
	common_scripts\utility::flag_wait("msg_fx_zone6_escalator_exit_shopping");
	var_00 = [(20673,20552.3,5258.69),(16666.5,19927.5,5624.46),(21245.6,17719.7,6303.46),(16756.2,20503.4,4837.3),(18491.4,16908,6126.36),(18569.9,22409.7,5052.01),(14798.6,20316.1,5253.98),(14657.8,18393.6,4916.39),(12132.3,19611.8,5915.53),(20007.2,18634.3,5165.69),(14305.3,25295.4,4464.22),(29463.4,22093.2,8050.42),(18561.1,19191.7,6940.02),(15632.8,22799.3,5405.85),(17033.3,22724.6,5456.83),(20090.5,17090.6,6104.45),(19207.1,19760.4,4969.31),(18897.9,17861.2,5336.73),(17643.6,17975.9,6187.16),(17001.1,16779.1,6292.83),(15251.6,17846,7191.07),(16847.6,18875.3,5501.05),(17855.1,20501.1,6919.57),(13104.7,17787.2,5501.51)];
	var_01 = [(276,90.0005,-90.0005),(276,90.0005,-90.0005),(276,90.0005,-90.0005),(276,90.0005,-90.0005),(276,90.0005,-90.0005),(276,90.0005,-90.0005),(276,90.0005,-90.0005),(276,90.0005,-90.0005),(276,90.0005,-90.0005),(276,90.0005,-90.0005),(276,90.0005,-90.0005),(276,90.0005,-90.0005),(276,90.0005,-90.0005),(276,90.0005,-90.0005),(276,90.0005,-90.0005),(276,90.0005,-90.0005),(276,90.0005,-90.0005),(276,90.0005,-90.0005),(276,90.0005,-90.0005),(276,90.0005,-90.0005),(276,90.0005,-90.0005),(276,90.0005,-90.0005),(276,90.0005,-90.0005),(276,90.0005,-90.0005)];
	thread maps\_shg_fx::start_fx_by_view("aa_explosion_runner_single",var_00,1,3,"msg_fx_zone7_2nd_floor_building_overview",0,var_01,"midair_exp_audio");
}

//Function Number: 97
shoping_district_ambientfx_midair_explosion()
{
	common_scripts\utility::flag_wait("msg_fx_zone6_escalator_exit_shopping");
	var_00 = [(19698.9,19061.8,4994.42),(16272.7,17077.3,5378.53),(19962.5,17044.7,3240.4),(21958.1,17690.8,5018.19),(18329.5,15896.8,5149.17),(14360.9,18246.4,3706.19),(17554.9,19976.5,6951.65),(21203.4,20643.3,5438.43),(15766.9,17676,4229.81),(15413.4,21719.1,4376.28),(12066.6,20949.7,6861.5),(16252.1,15202,4464.51),(19142.6,20042.1,4181.94),(15920.4,19633.7,4839.31),(18169.2,18171.3,3759.21),(16947.5,19661.9,3291.84),(19693.6,21307.6,3165.27),(16979,21159.9,3305.99),(18195.2,19631.7,2727.43)];
	var_01 = [(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0)];
	thread maps\_shg_fx::start_fx_by_view("ambient_explosion_midair_runner_single",var_00,2,6,"msg_fx_zone7_2nd_floor_building_overview",0,var_01,"midair_exp_audio");
}

//Function Number: 98
shoping_district_ambientfx_windowglass_explosion()
{
	common_scripts\utility::flag_wait("msg_fx_zone6_escalator_exit_shopping");
	var_00 = [(21256.3,18920,3139.02),(21211.7,19250.9,4038.3),(21816.9,24241.2,8481.06),(20870.5,24707,7494.13),(21665.4,24274.2,7237.97),(21674.1,24316.8,5412.25),(21021.4,24598.8,4718.75),(18360.9,23149.9,4130),(19322.4,23652.2,3644.22),(21225.3,18717.2,3988.18),(15650.6,17890.7,2754.44)];
	var_01 = [(280.925,191.431,108.251),(328.557,150.211,115.126),(293.35,214.205,141.894),(324.639,218.62,127.313),(321.525,215.797,127.517),(316.622,277.568,85.2917),(316.622,277.568,85.2917),(316.622,277.568,72.2915),(309.544,330.429,80.3149),(299.522,184.568,85.3982),(331.685,153.042,47.3377)];
	thread maps\_shg_fx::start_fx_by_view("ambient_explosion_windowglass",var_00,4,6,"msg_fx_zone7_2nd_floor_building_overview",0,var_01,"midair_exp_glass_audio");
}

//Function Number: 99
finale_section_ambientfx_aa_explosions()
{
	common_scripts\utility::flag_wait_either("msg_fx_zone6c_shopping_narrow_alley_exit","msg_fx_zone7a_river_bridge_section");
	var_00 = [(12431.1,12576.9,8783.14),(14626.6,10870.8,8119.9),(15463.7,16073,6953.69),(11650.4,5070.67,13850.5),(17318.1,10948.2,9019.02),(15441.5,12155.2,9941.41),(13402.1,14222.8,9419.67),(12420.2,4810.7,7381.18),(10668,8474.19,8755.28),(9917.63,13071,7428.28),(14005.1,6816.15,7743.88),(16073.1,17814.4,10676.4),(13915.6,23666.5,7903.39),(11897.9,17635.4,9189.77),(15475.6,20298.5,8304),(11863.2,23952.4,8688.29),(14068,19318.3,10154.4),(15242.7,21766.1,8557.51),(15980.4,26742.7,10634),(14260.2,16894.5,9020.28),(11998.8,27001.9,8699.55),(13579.3,24356.8,13129.5),(10664.1,22312.4,8812.91),(12126,20590.5,9714.14),(9937.39,18404,8112.56),(19180.9,15064.9,8444.62),(18922.1,18112.4,8507.56),(17232.1,21468.7,8186.15),(17225.8,23311.3,7854.24),(18939.6,20768.4,7319.95)];
	var_01 = [(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0)];
	thread maps\_shg_fx::start_fx_by_view("aa_explosion_runner_single",var_00,2,2,"vfx_msg_finale_sequence_start",0,var_01,"midair_exp_audio");
}

//Function Number: 100
finale_section_ambientfx_midair_explosions()
{
	common_scripts\utility::flag_wait_either("msg_fx_zone6c_shopping_narrow_alley_exit","msg_fx_zone7a_river_bridge_section");
	var_00 = [(10288,11149.9,8990.21),(14904.5,16254.5,8744.91),(11646.3,15481,10575.1),(13675.9,8786.67,8276.05),(13984.2,14953.1,6852.29),(14066.7,20287.7,7487.64),(12236.4,25389.6,7936.21),(15650.5,24106.5,7137.24),(17262.6,13677.1,7151.88),(13008.3,28962.6,6886.35),(12218.3,21998.7,6269.24),(12365.2,19180.3,6293.49),(17399.7,4509.52,11575.1)];
	var_01 = [(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0)];
	thread maps\_shg_fx::start_fx_by_view("ambient_explosion_midair_runner_single",var_00,3,4,"vfx_msg_finale_sequence_start",0,var_01,"midair_exp_audio");
}

//Function Number: 101
finale_section_ambientfx_windowglass_explosion()
{
	common_scripts\utility::flag_wait_either("msg_fx_zone6c_shopping_narrow_alley_exit","msg_fx_zone7a_river_bridge_section");
	var_00 = [(15233,22259.9,2633.39),(14905.9,22895.4,2528.2),(15399.9,12863.1,4254.42),(15005.4,15053.4,2333.12),(11852.1,17118.4,3141.86),(11479.3,17482.5,2851.47),(12485.6,18934,2843.64),(12496.4,20687.8,2750.16),(12758,25518.1,4411.36),(12293,24950.3,3693.35),(13022.1,22910.7,2304.19),(15381.9,12819.4,3538.38),(14943.3,16066.7,2276.28)];
	var_01 = [(343,270,90.0001),(358.405,173.57,77.431),(0.463395,168.668,171.77),(0.463395,168.668,171.77),(357.841,0.550404,-172.042),(359.027,82.9455,-179.455),(1.02538,268.945,178.559),(359.027,82.9455,-179.455),(357.841,0.550404,-172.042),(343,270,90.0001),(357.841,0.550404,-172.042),(0.463395,168.668,171.77),(0.463395,168.668,171.77)];
	thread maps\_shg_fx::start_fx_by_view("ambient_explosion_windowglass",var_00,4,6,"vfx_msg_finale_sequence_start",0,var_01,"midair_exp_glass_audio");
}

//Function Number: 102
harpoon_launch_effects(param_00)
{
	playfxontag(common_scripts\utility::getfx("warbird_harpoon_spiral"),param_00,"jnt_harpoon");
	playfxontag(common_scripts\utility::getfx("warbird_zip_rope_glow"),param_00,"harpoonCableBend");
}

//Function Number: 103
weapon_platform_fire_1(param_00)
{
	playfxontag(common_scripts\utility::getfx("weaponplf_cannon_muzzle"),param_00,"launcherBarrel_T");
}

//Function Number: 104
weapon_platform_fire_2(param_00)
{
	playfxontag(common_scripts\utility::getfx("weaponplf_cannon_muzzle"),param_00,"launcherBarrel_R");
}

//Function Number: 105
weapon_platform_fire_3(param_00)
{
	playfxontag(common_scripts\utility::getfx("weaponplf_cannon_muzzle"),param_00,"launcherBarrel_L");
}

//Function Number: 106
seo_outro_wp_env_fx_start()
{
	common_scripts\utility::flag_wait("msg_fx_zone7a_river_bridge_section");
	common_scripts\_exploder::exploder(10000);
	if(level.currentgen)
	{
		level.weapon_platform_rigged = getent("canal_weapon_platform","targetname");
		level.weapon_platform_rigged.animname = "weapon_platform";
		playfxontag(common_scripts\utility::getfx("light_carmack_drag1_cg_runner"),level.weapon_platform_rigged,"TAG_ORIGIN");
	}
}

//Function Number: 107
seo_outro_wp_wp_powerup(param_00)
{
	playfxontag(common_scripts\utility::getfx("weaponplf_tread_smk_powerup"),param_00,"TAG_ORIGIN");
	level waittill("wp_takeoff_start");
	stopfxontag(common_scripts\utility::getfx("weaponplf_tread_smk_powerup"),param_00,"TAG_ORIGIN");
}

//Function Number: 108
seo_outro_wp_take_off_start(param_00)
{
	level notify("wp_takeoff_start");
	playfxontag(common_scripts\utility::getfx("weaponplf_tread_smk"),param_00,"TAG_ORIGIN");
	level waittill("wp_init_explo_start");
	stopfxontag(common_scripts\utility::getfx("weaponplf_tread_smk"),param_00,"TAG_ORIGIN");
}

//Function Number: 109
seo_outro_wp_explo_sequence_start(param_00)
{
	maps\_utility::delaythread(0,::seo_outro_wp_init_explo,param_00);
	maps\_utility::delaythread(0,::seo_outro_pause_env_fx);
	maps\_utility::delaythread(2.1,::seo_outro_wp_belly_explo_1,param_00);
	maps\_utility::delaythread(2.95,::seo_outro_wp_wing_fall_off,param_00);
	maps\_utility::delaythread(3.15,::seo_outro_wp_belly_explo_2,param_00);
	maps\_utility::delaythread(3.9,::seo_outro_wp_belly_explo_2_end,param_00);
	maps\_utility::delaythread(4.85,::seo_outro_wp_tail_explo_shockwave,param_00);
	maps\_utility::delaythread(4.95,::seo_outro_wp_tail_explo_shockwave_ground);
	maps\_utility::delaythread(5.2,::seo_outro_wp_tail_explo,param_00);
	maps\_utility::delaythread(5.2,::seo_outro_rolling_smk);
	maps\_utility::delaythread(6.5,::seo_outro_falling_debris);
	maps\_utility::delaythread(7.5,::seo_outro_tire_fire);
}

//Function Number: 110
seo_outro_wp_init_explo(param_00)
{
	level notify("wp_init_explo_start");
	var_01 = common_scripts\utility::spawn_tag_origin();
	var_01 linkto(param_00,"tag_left_rim",(0,0,0),(-120,0,270));
	playfxontag(common_scripts\utility::getfx("seo_outro_wp_explo_initial"),var_01,"tag_origin");
	var_01 soundscripts\_snd::snd_message("seo_finale_wp_init_explo");
	wait(3);
	stopfxontag(common_scripts\utility::getfx("seo_outro_wp_explo_initial"),var_01,"tag_origin");
	var_01 delete();
}

//Function Number: 111
seo_outro_pause_env_fx()
{
	maps\_utility::pauseexploder(10000);
	wait(3);
	common_scripts\_exploder::exploder(10040);
}

//Function Number: 112
seo_outro_wp_belly_explo_1(param_00)
{
	var_01 = common_scripts\utility::spawn_tag_origin();
	var_01 linkto(param_00,"launcherLift",(80,-500,-230),(90,0,90));
	playfxontag(common_scripts\utility::getfx("seo_outro_wp_explo_belly1"),var_01,"tag_origin");
	var_01 soundscripts\_snd::snd_message("seo_finale_wp_belly_explo");
	level waittill("wp_final_explo");
	var_01 delete();
}

//Function Number: 113
seo_outro_wp_belly_explo_2(param_00)
{
	var_01 = common_scripts\utility::spawn_tag_origin();
	var_01 linkto(param_00,"launcherLift",(-20,-200,-230),(90,0,90));
	playfxontag(common_scripts\utility::getfx("seo_outro_wp_explo_belly2"),var_01,"tag_origin");
	level waittill("wp_final_explo");
	var_01 delete();
}

//Function Number: 114
seo_outro_wp_belly_explo_2_end(param_00)
{
	var_01 = common_scripts\utility::spawn_tag_origin();
	var_01 linkto(param_00,"tailWheelPitch",(0,115,-20),(50,90,0));
	playfxontag(common_scripts\utility::getfx("seo_outro_wp_explo_belly2_chd"),var_01,"tag_origin");
	level waittill("wp_final_explo");
	var_01 delete();
}

//Function Number: 115
seo_outro_wp_wing_fall_off(param_00)
{
	var_01 = common_scripts\utility::spawn_tag_origin();
	var_01 linkto(param_00,"wing_R",(0,120,0),(0,90,0));
	playfxontag(common_scripts\utility::getfx("seo_outro_wp_explo_wing"),var_01,"tag_origin");
	var_01 soundscripts\_snd::snd_message("seo_finale_wp_wing_explo");
	level waittill("wp_final_explo");
	var_01 delete();
}

//Function Number: 116
seo_outro_wp_tail_explo_shockwave(param_00)
{
	level notify("wp_final_explo");
	var_01 = common_scripts\utility::spawn_tag_origin();
	var_01 linkto(param_00,"tag_body",(-200,0,0),(0,160,0));
	playfxontag(common_scripts\utility::getfx("seo_outro_wp_explo_tail_shkwv"),var_01,"tag_origin");
	wait(5);
	var_01 delete();
}

//Function Number: 117
seo_outro_wp_tail_explo_shockwave_ground()
{
	common_scripts\_exploder::exploder("outro_grnd_shkwv");
}

//Function Number: 118
seo_outro_wp_tail_explo(param_00)
{
	var_01 = common_scripts\utility::spawn_tag_origin();
	var_01 linkto(param_00,"launcherLift",(0,270,0),(0,90,0));
	playfxontag(common_scripts\utility::getfx("seo_outro_wp_explo_tail"),var_01,"tag_origin");
	var_01 soundscripts\_snd::snd_message("seo_finale_wp_big_explo");
	wait(10);
	var_01 delete();
}

//Function Number: 119
seo_outro_rolling_smk()
{
	maps\_utility::delaythread(0,::common_scripts\_exploder::exploder,"outro_grnd_smk_gush");
	maps\_utility::delaythread(1.75,::seo_outro_thick_smk_vm);
	maps\_utility::delaythread(1.9,::common_scripts\_exploder::exploder,"outro_grnd_smk_linger");
	maps\_utility::delaythread(7,::common_scripts\_exploder::exploder,"outro_grnd_smk_settle");
}

//Function Number: 120
seo_outro_thick_smk_vm()
{
	var_00 = spawn("script_model",level.player.origin);
	var_00 setmodel("tag_origin");
	var_00 linkto(level.player);
	playfxontag(common_scripts\utility::getfx("seo_outro_thick_smk_vm"),var_00,"tag_origin");
	wait(20);
	stopfxontag(common_scripts\utility::getfx("seo_outro_thick_smk_vm"),var_00,"tag_origin");
	var_00 delete();
}

//Function Number: 121
seo_outro_falling_debris()
{
	maps\_utility::delaythread(3,::common_scripts\_exploder::exploder,"outro_rock_fall");
	maps\_utility::delaythread(5,::common_scripts\_exploder::exploder,"outro_glass_fall");
	maps\_utility::delaythread(0,::common_scripts\_exploder::exploder,"outro_ash");
	maps\_utility::delaythread(7,::maps\_utility::pauseexploder,"outro_rock_fall");
}

//Function Number: 122
seo_outro_tire_fire()
{
	common_scripts\_exploder::exploder(10050);
}

//Function Number: 123
outro_vm_arm_blood_init(param_00)
{
	var_01 = 1900;
	var_02 = 680;
	var_03 = var_01 - var_02 / 30;
	wait(var_03);
	var_04 = common_scripts\utility::spawn_tag_origin();
	var_04 linkto(param_00[1],"j_clavicle_le",(16,0,0),(0,0,0));
	playfxontag(common_scripts\utility::getfx("fusion_blood_smear_oriented"),var_04,"tag_origin");
	var_05 = param_00[2] gettagorigin("shoulder_L");
	var_05 = var_05 + (0,1.5,0);
	playfx(common_scripts\utility::getfx("fusion_end_armblood_bloodsquirts"),var_05,(0,0,1),(0,1,0));
}

//Function Number: 124
outro_vm_body_drag_dust(param_00)
{
	playfxontag(common_scripts\utility::getfx("fusion_drag_dust"),param_00,"J_Ankle_LE");
	playfxontag(common_scripts\utility::getfx("fusion_drag_dust"),param_00,"J_Ankle_RI");
}