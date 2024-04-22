/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: finale_fx.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 97
 * Decompile Time: 1397 ms
 * Timestamp: 4/22/2024 2:29:15 AM
*******************************************************************/

//Function Number: 1
main()
{
	precachefx();
	maps\createfx\finale_fx::main();
	set_lighting_values();
	maps\_shg_fx::setup_shg_fx();
	common_scripts\utility::flag_init("flag_intro_flyin_start");
	common_scripts\utility::flag_init("vfx_finale_flyin_start");
	common_scripts\utility::flag_init("fx_underwater_bullets_02");
	common_scripts\utility::flag_init("fx_underwater_bullets_03");
	common_scripts\utility::flag_init("fx_silo_breached");
	common_scripts\utility::flag_init("fx_silo_stairs");
	common_scripts\utility::flag_init("fx_stairs_drips");
	common_scripts\utility::flag_init("fx_stairs_mech");
	common_scripts\utility::flag_init("flag_vfx_missile_ignition_start");
	common_scripts\utility::flag_init("flag_vfx_missile_liftoff_start");
	common_scripts\utility::flag_init("flag_missile_ignition_start");
	common_scripts\utility::flag_init("flag_bridge_takedown_jump_complete");
	common_scripts\utility::flag_init("flag_balcony_tackle_success");
	common_scripts\utility::flag_init("flag_countdown_complete_mission_fail");
	thread maps\_shg_fx::fx_zone_watcher(500,"msg_fx_zone500_Underwater");
	thread maps\_shg_fx::fx_zone_watcher(800,"msg_fx_zone800_silo_intro");
	thread maps\_shg_fx::fx_zone_watcher(1000,"msg_fx_zone1000_inside_silo_area");
	thread maps\_shg_fx::fx_zone_watcher(1200,"msg_fx_zone1200_lobby");
	thread maps\_shg_fx::fx_zone_watcher(1500,"msg_fx_zone1500_will_room");
	thread maps\_shg_fx::fx_zone_watcher(2000,"msg_fx_zone2000_finale_roof");
	thread intro_flyin_ambient_aa_explosions();
	thread intro_flyin_ambient_window_glass_explosions();
	thread intro_ambient_aa_explosion_far();
	thread intro_flyin_ambient_explosion_midair_runner_single();
	thread dazed_sky_bridge_explosions();
	thread skybridge_ambient_explosions();
	thread skybridge_ambient_aa_explosions();
	thread end_roof_ambient_aa_explosions();
	thread end_roof_ambient_midair_runner_explosion_single();
	thread intro_city_ambient_fx();
	thread city_ambient_fx();
	thread underwater_ambient_fx();
	thread underwater_mech_footsteps();
	thread underwater_bullets();
	thread rooftop_bombshakes();
	thread ambient_smk_walkway();
	thread grand_finale_fx();
	thread rocket_fail_smoke();
	thread player_rocket();
}

//Function Number: 2
set_lighting_values()
{
	if(isusinghdr())
	{
		setsaveddvar("r_tonemap",2);
	}
}

//Function Number: 3
precachefx()
{
	level._effect["light_underwater_godray_beam_moving_med"] = loadfx("vfx/lights/finale/light_underwater_gdry_beam_move_med");
	level._effect["caustic_b_pa"] = loadfx("vfx/caustic/caustic_b_pa");
	level._effect["trash_underwater_current_rnr_lp"] = loadfx("vfx/water/trash_underwater_current_rnr_lp");
	level._effect["underwater_bubbles_canal"] = loadfx("vfx/map/betrayal/underwater_bubbles_canal");
	level._effect["underwater_bubbles_canal_fewer"] = loadfx("vfx/map/betrayal/underwater_bubbles_canal_fewer");
	level._effect["boat_edge_foam_sml"] = loadfx("vfx/water/boat_edge_foam_sml");
	level._effect["boat_edge_foam_lrg"] = loadfx("vfx/water/boat_edge_foam_lrg");
	level._effect["underwater_particulates_river"] = loadfx("vfx/map/betrayal/underwater_particulates_river");
	level._effect["underwater_murky_cloud"] = loadfx("vfx/map/finale/fin_underwater_murky_cloud");
	level._effect["underwater_bubbles_canal_angled"] = loadfx("vfx/map/finale/fin_underwater_bubbles_canal_angled");
	level._effect["underwater_concrete_falling_m"] = loadfx("vfx/map/finale/fin_underwater_concrete_falling_m");
	level._effect["underwater_concrete_falling_sml"] = loadfx("vfx/map/finale/fin_underwater_concrete_falling_sml");
	level._effect["underwater_murky_smk_linger"] = loadfx("vfx/map/finale/fin_underwater_murky_smk_linger");
	level._effect["water_edge_splashes_rnr"] = loadfx("vfx/water/water_edge_splashes_rnr");
	level._effect["water_object_impact_splash_large_cheap"] = loadfx("vfx/water/water_object_impact_splash_large_cheap");
	level._effect["mech_vm_water_splash"] = loadfx("vfx/water/mech_vm_water_splash");
	level._effect["underwater_bubble_vm_transition_fast"] = loadfx("vfx/water/underwater_bubble_vm_transition_fast");
	level._effect["bubble_trail_mech_runner_lp"] = loadfx("vfx/water/bubble_trail_mech_runner_lp");
	level._effect["underwater_surface_splash"] = loadfx("vfx/water/underwater_surface_splash");
	level._effect["bubble_geotrail_thick_xsml"] = loadfx("vfx/water/bubble_geotrail_thick_xsml");
	level._effect["bubble_trail_runner_lp"] = loadfx("vfx/water/bubble_trail_runner_lp");
	level._effect["bubble_geotrail_thick_med"] = loadfx("vfx/water/bubble_geotrail_thick_med");
	level._effect["underwater_bottom_impact_dirt"] = loadfx("vfx/water/underwater_bottom_impact_dirt");
	level._effect["underwater_bullet_trail_long_nofog"] = loadfx("vfx/water/underwater_bullet_trail_long_nofog");
	level._effect["fin_vm_underwater_hit_bottom"] = loadfx("vfx/map/finale/fin_vm_underwater_hit_bottom");
	level._effect["fin_gideon_mech_water_drip"] = loadfx("vfx/map/finale/fin_gideon_mech_water_drip");
	level._effect["fin_gideon_mech_water_drip_gun"] = loadfx("vfx/map/finale/fin_gideon_mech_water_drip_gun");
	level._effect["fin_gideon_mech_water_drip_rshoulder"] = loadfx("vfx/map/finale/fin_gideon_mech_water_drip_rshoulder");
	level._effect["fin_gideon_mech_water_drip_lshoulder"] = loadfx("vfx/map/finale/fin_gideon_mech_water_drip_lshoulder");
	level._effect["finale_sun_flare"] = loadfx("vfx/map/finale/finale_sun_flare");
	level._effect["finale_god_willroom"] = loadfx("vfx/lights/finale/finale_god_willroom");
	level._effect["finale_god_willroom_bright"] = loadfx("vfx/lights/finale/finale_god_willroom_bright");
	level._effect["finale_screen_god_willroom"] = loadfx("vfx/lights/finale/finale_screen_god_willroom");
	level._effect["fin_sconce_lens_sm"] = loadfx("vfx/lights/finale/fin_sconce_lens_sm");
	level._effect["fin_sconce_lens_sm2"] = loadfx("vfx/lights/finale/fin_sconce_lens_sm2");
	level._effect["fin_sconce_lens_sm3"] = loadfx("vfx/lights/finale/fin_sconce_lens_sm3");
	level._effect["finale_screen_god_willroom"] = loadfx("vfx/lights/finale/finale_screen_god_willroom");
	level._effect["fin_alarm_godray"] = loadfx("vfx/lights/finale/fin_alarm_godray");
	level._effect["fin_alarm_godray_red"] = loadfx("vfx/lights/finale/fin_alarm_godray_red");
	level._effect["fin_alarm_spot_red"] = loadfx("vfx/lights/finale/fin_alarm_spot_red");
	level._effect["fin_alarm_source_red"] = loadfx("vfx/lights/finale/fin_alarm_source_red");
	level._effect["fin_alarm_source_white"] = loadfx("vfx/lights/finale/fin_alarm_source_white");
	level._effect["smk_stacks_lp_sml_a"] = loadfx("vfx/smoke/smk_stacks_lp_sml_a");
	level._effect["smk_stacks_lp_med_a"] = loadfx("vfx/smoke/smk_stacks_lp_med_a");
	level._effect["smk_stacks_lp_lrg_a"] = loadfx("vfx/smoke/smk_stacks_lp_lrg_a");
	level._effect["smk_stacks_lp_lrg_unlit_a"] = loadfx("vfx/smoke/smk_stacks_lp_lrg_unlit_a");
	level._effect["fin_smk_stacks_lp_lrg_unlit_a"] = loadfx("vfx/map/finale/fin_smk_stacks_lp_lrg_unlit_a");
	level._effect["fire_vista_glow_lp_lrg_unlit"] = loadfx("vfx/fire/fire_vista_glow_lp_lrg_unlit");
	level._effect["fire_lp_m_blacksmk_tall"] = loadfx("vfx/fire/fire_lp_m_blacksmk_tall");
	level._effect["fire_lp_m_no_light"] = loadfx("vfx/fire/fire_lp_m_no_light");
	level._effect["fire_lp_l_blacksmk_thick_nonlit"] = loadfx("vfx/fire/fire_lp_l_blacksmk_thick_nonlit");
	level._effect["smoke_pillar_black_large_fast"] = loadfx("vfx/smoke/smoke_pillar_black_large_fast");
	level._effect["window_smk_dark_m"] = loadfx("vfx/smoke/window_smk_dark_m");
	level._effect["poison_gas_green_m"] = loadfx("vfx/smoke/poison_gas_green_m");
	level._effect["smoke_white_slow"] = loadfx("vfx/smoke/smoke_white_slow");
	level._effect["battlefield_smoke_m"] = loadfx("vfx/smoke/battlefield_smoke_m");
	level._effect["footstep_mech_underwater"] = loadfx("vfx/treadfx/footstep_mech_underwater");
	level._effect["footstep_mech_underwater_concrete"] = loadfx("vfx/treadfx/footstep_mech_underwater_concrete");
	level._effect["footstep_mech_water"] = loadfx("vfx/treadfx/footstep_mech_water");
	level._effect["wind_blowing_debris"] = loadfx("vfx/wind/wind_blowing_debris");
	level._effect["ash_ember_cloud_freq_lrg_loop"] = loadfx("vfx/ash/ash_ember_cloud_freq_lrg_loop");
	level._effect["steam_fall_slow_lp"] = loadfx("vfx/steam/steam_fall_slow_lp");
	level._effect["fin_silo_rocket_loading_steam_lp"] = loadfx("vfx/map/finale/fin_silo_rocket_loading_steam_lp");
	level._effect["fin_silo_edge_steam_bursts_lp"] = loadfx("vfx/map/finale/fin_silo_edge_steam_bursts_lp");
	level._effect["fin_silo_low_steam"] = loadfx("vfx/map/finale/fin_silo_low_steam");
	level._effect["fin_silo_catwalk_low_steam"] = loadfx("vfx/map/finale/fin_silo_catwalk_low_steam");
	level._effect["fin_fire_tunnel"] = loadfx("vfx/map/finale/fin_fire_tunnel");
	level._effect["fin_smoke_vent"] = loadfx("vfx/map/finale/fin_smoke_vent");
	level._effect["fin_fire_tunnel_constant"] = loadfx("vfx/map/finale/fin_fire_tunnel_constant");
	level._effect["fin_fireblast_tunnel_constant"] = loadfx("vfx/map/finale/fin_fireblast_tunnel_constant");
	level._effect["fin_fire_tunnel_constant_blue"] = loadfx("vfx/map/finale/fin_fire_tunnel_constant_blue");
	level._effect["fin_smoke_tunnel"] = loadfx("vfx/map/finale/fin_smoke_tunnel");
	level._effect["fin_smoke_tunnel_slow"] = loadfx("vfx/map/finale/fin_smoke_tunnel_slow");
	level._effect["fin_liquid_hydrogen_tunnel"] = loadfx("vfx/map/finale/fin_liquid_hydrogen_tunnel");
	level._effect["fin_rocket_thruster"] = loadfx("vfx/map/finale/fin_rocket_thruster");
	level._effect["fin_rocket_thruster_smoke"] = loadfx("vfx/map/finale/fin_rocket_thruster_smoke");
	level._effect["fin_rocket_thruster_sml"] = loadfx("vfx/map/finale/fin_rocket_thruster_sml");
	level._effect["fin_rocket_thruster_sml_idle"] = loadfx("vfx/map/finale/fin_rocket_thruster_sml_idle");
	level._effect["fin_rocket_thruster_blue_idle"] = loadfx("vfx/map/finale/fin_rocket_thruster_blue_idle");
	level._effect["fin_rocket_thruster_blue"] = loadfx("vfx/map/finale/fin_rocket_thruster_blue");
	level._effect["fin_rocket_ignition"] = loadfx("vfx/map/finale/fin_rocket_ignition");
	level._effect["fin_rocket_ignition_fire"] = loadfx("vfx/map/finale/fin_rocket_ignition_fire");
	level._effect["fin_rocket_ignition_spark"] = loadfx("vfx/map/finale/fin_rocket_ignition_spark");
	level._effect["fin_rocket_silo_explosion"] = loadfx("vfx/map/finale/fin_rocket_silo_explosion");
	level._effect["fin_metal_falling"] = loadfx("vfx/map/finale/fin_metal_falling");
	level._effect["electrical_sparks_runner"] = loadfx("vfx/explosion/electrical_sparks_runner");
	level._effect["fin_metal_falling_panel"] = loadfx("vfx/map/finale/fin_metal_falling_panel");
	level._effect["fin_metal_falling_close"] = loadfx("vfx/map/finale/fin_metal_falling_close");
	level._effect["steam_pipe_burst_sml"] = loadfx("vfx/steam/steam_pipe_burst_sml");
	level._effect["steam_pipe_leak_lrg"] = loadfx("vfx/steam/steam_pipe_leak_lrg");
	level._effect["fin_rocket_fail_smoke"] = loadfx("vfx/map/finale/fin_rocket_fail_smoke");
	level._effect["fin_rocket_fail_ember_burst"] = loadfx("vfx/map/finale/fin_rocket_fail_ember_burst");
	level._effect["fin_rocket_fail_sparks"] = loadfx("vfx/map/finale/fin_rocket_fail_sparks");
	level._effect["fin_rocket_fail_top_smoke"] = loadfx("vfx/map/finale/fin_rocket_fail_top_smoke");
	level._effect["fin_rocket_fail_damage"] = loadfx("vfx/map/finale/fin_rocket_fail_damage");
	level._effect["aa_explosion_runner_single"] = loadfx("vfx/explosion/aa_explosion_runner_single");
	level._effect["ambient_explosion_midair_runner_single"] = loadfx("vfx/explosion/ambient_explosion_midair_runner_single");
	level._effect["ambient_explosion_windowglass"] = loadfx("vfx/explosion/ambient_explosion_windowglass");
	level._effect["aa_flash_tracer_far_freq_rnr_lp"] = loadfx("vfx/explosion/aa_flash_tracer_far_freq_rnr_lp");
	level._effect["sparks_runner_lp_sml"] = loadfx("vfx/sparks/sparks_runner_lp_sml");
	level._effect["fin_door_kick_spark_burst_rnr"] = loadfx("vfx/map/finale/fin_door_kick_spark_burst_rnr");
	level._effect["sparks_burst_sm_d"] = loadfx("vfx/explosion/sparks_burst_sm_d");
	level._effect["fin_door_kick_dust"] = loadfx("vfx/map/finale/fin_door_kick_dust");
	level._effect["fin_door_kick_slide_sparks"] = loadfx("vfx/map/finale/fin_door_kick_slide_sparks");
	level._effect["fin_door_kick_lrg_dust"] = loadfx("vfx/map/finale/fin_door_kick_lrg_dust");
	level._effect["fin_door_kick_foot_dust"] = loadfx("vfx/map/finale/fin_door_kick_foot_dust");
	level._effect["mech_damage_sparks_lp"] = loadfx("vfx/sparks/mech_damage_sparks_lp");
	level._effect["fin_exhaust_hatch_open"] = loadfx("vfx/map/finale/fin_exhaust_hatch_open");
	level._effect["fin_exhaust_hatch_break"] = loadfx("vfx/map/finale/fin_exhaust_hatch_break");
	level._effect["fin_hatch_exhaust"] = loadfx("vfx/map/finale/fin_hatch_exhaust");
	level._effect["fin_hatch_exhaust_mech_land"] = loadfx("vfx/map/finale/fin_exhaust_hatch_mech_land");
	level._effect["fin_bar_hit_sparks"] = loadfx("vfx/map/finale/fin_bar_hit_sparks");
	level._effect["rpg_trail"] = loadfx("vfx/trail/smoketrail_rpg_sp");
	level._effect["rpg_muzzle"] = loadfx("vfx/muzzleflash/x4walker_wheels_rpg_fv");
	level._effect["rpg_explode"] = loadfx("vfx/explosion/ambient_explosion_midair_runner_single");
	level._effect["titan45_muzzle"] = loadfx("vfx/muzzleflash/generic_pistol_flash_view");
	level._effect["docks_heli_spotlight"] = loadfx("vfx/lights/finale/spotlight_heli_hdr");
	level._effect["lab_heli_spot_flare"] = loadfx("vfx/lensflare/finale/lab_heli_spot_flare");
	level._effect["player_light_med2"] = loadfx("vfx/lights/detroit/flashlight_spotlight_player_med2");
	level._effect["fin_exo_exit_glow_gideon"] = loadfx("vfx/map/finale/fin_exo_exit_glow_gideon");
	level._effect["fin_exo_exit_glow_vm"] = loadfx("vfx/map/finale/fin_exo_exit_glow_vm");
	level._effect["no_fx"] = loadfx("vfx/unique/no_fx");
	level._effect["dust_falling_light_sml_01"] = loadfx("vfx/dust/dust_falling_light_sml_01");
	level._effect["npc_dust_landing"] = loadfx("vfx/dust/npc_dust_landing");
	level._effect["fin_balcony_break_dust"] = loadfx("vfx/map/finale/fin_balcony_break_dust");
	level._effect["fin_balcony_falling_debris"] = loadfx("vfx/map/finale/fin_balcony_falling_debris");
	level._effect["fin_balcony_irons_tackle"] = loadfx("vfx/map/finale/fin_balcony_irons_tackle");
	level._effect["battlefield_smoke_m"] = loadfx("vfx/smoke/battlefield_smoke_m");
	level._effect["smk_obscure_low_thick_far_m"] = loadfx("vfx/smoke/smk_obscure_low_thick_far_m");
	level._effect["fin_roof_hang_fire_wide"] = loadfx("vfx/map/finale/fin_roof_hang_fire_wide");
	level._effect["fin_roof_hang_fire_xlrg"] = loadfx("vfx/map/finale/fin_roof_hang_fire_xlrg");
	level._effect["fin_roof_hang_fire_sm"] = loadfx("vfx/map/finale/fin_roof_hang_fire_sm");
	level._effect["func_glass_shatter_64x64"] = loadfx("vfx/code/func_glass_shatter_64x64");
	level._effect["glass_shatter_xlarge"] = loadfx("vfx/glass/glass_shatter_xlarge");
	level._effect["fin_falling_debris_01_lrg"] = loadfx("vfx/map/finale/fin_falling_debris_01_lrg");
	level._effect["fin_falling_debris_01_sml"] = loadfx("vfx/map/finale/fin_falling_debris_01_sml");
	level._effect["fin_irons_vector_field_lp"] = loadfx("vfx/map/finale/fin_irons_vector_field_lp");
	level._effect["embers_lp_lrg_vf"] = loadfx("vfx/fire/embers_lp_lrg_vf");
	level._effect["fin_player_arm_cut_sparks"] = loadfx("vfx/map/finale/fin_player_arm_cut_sparks");
	level._effect["fin_player_arm_cut_sparks_trail"] = loadfx("vfx/map/finale/fin_player_arm_cut_sparks_trail");
	level._effect["fin_player_arm_cut_spark_burst_single"] = loadfx("vfx/map/finale/fin_player_arm_cut_spark_burst_single");
	level._effect["fin_roof_building_explo"] = loadfx("vfx/map/finale/fin_roof_building_explo");
	level._effect["ambient_explosion_fireball_a_no_decal"] = loadfx("vfx/explosion/ambient_explosion_fireball_a_no_decal");
	level._effect["paper_sheet_explosion_blown_1"] = loadfx("vfx/wind/paper_sheet_explosion_blown_1");
	level._effect["paper_burst"] = loadfx("vfx/props/paper_burst");
	level._effect["paper_sheet_01_blowing"] = loadfx("vfx/wind/paper_sheet_01_blowing");
	level._effect["paper_scrap_windblown_runner_light"] = loadfx("vfx/wind/paper_scrap_windblown_runner_light");
	level._effect["fin_multi2_white_godray"] = loadfx("vfx/lights/finale/fin_multi2_white_godray");
	level._effect["fin_square_godray"] = loadfx("vfx/lights/finale/fin_square_godray");
	level._effect["fin_longlight_flare"] = loadfx("vfx/lights/finale/fin_longlight_flare");
	level._effect["fin_cool_can_sm"] = loadfx("vfx/lights/finale/fin_cool_can_sm");
	level._effect["fin_cool_can_norainbow_sm"] = loadfx("vfx/lights/finale/fin_cool_can_norainbow_sm");
	level._effect["fin_warm_can_sm"] = loadfx("vfx/lights/finale/fin_warm_can_sm");
	level._effect["fin_warm_can_norainbow_sm"] = loadfx("vfx/lights/finale/fin_warm_can_norainbow_sm");
	level._effect["fin_strips_flare"] = loadfx("vfx/lights/finale/fin_strips_flare");
	level._effect["fin_falldecal_flare"] = loadfx("vfx/lights/finale/fin_falldecal_flare");
	level._effect["fin_strips_orange_flare"] = loadfx("vfx/lights/finale/fin_strips_orange_flare");
	level._effect["fin_rectangle_flare"] = loadfx("vfx/lights/finale/fin_rectangle_flare");
	level._effect["fin_rectangle_blue_flare"] = loadfx("vfx/lights/finale/fin_rectangle_blue_flare");
	level._effect["fin_godray_bluewall_light"] = loadfx("vfx/lights/finale/fin_godray_bluewall_light");
	level._effect["fin_light_mech"] = loadfx("vfx/lights/finale/fin_light_mech");
	level._effect["fin_frame_light"] = loadfx("vfx/lights/finale/fin_frame_light");
	level._effect["fin_frame_light_rainbow"] = loadfx("vfx/lights/finale/fin_frame_light_rainbow");
	level._effect["fin_frame_light_sm"] = loadfx("vfx/lights/finale/fin_frame_light_sm");
	level._effect["fin_frame_light_corner"] = loadfx("vfx/lights/finale/fin_frame_light_corner");
	level._effect["fin_frame_light_xtra_sm"] = loadfx("vfx/lights/finale/fin_frame_light_xtra_sm");
}

//Function Number: 4
fx_cam_view_test()
{
	thread maps\_shg_fx::exploder_to_array(11);
}

//Function Number: 5
intro_city_ambient_fx()
{
	common_scripts\utility::flag_wait("flag_intro_flyin_start");
	common_scripts\_exploder::exploder(200);
	level waittill("msg_fx_zone500_Underwater");
	maps\_utility::stop_exploder(200);
}

//Function Number: 6
boat_small_static_foam()
{
	wait(0.1);
	playfxontag(common_scripts\utility::getfx("boat_edge_foam_sml"),self,"tag_origin");
}

//Function Number: 7
boat_large_static_foam()
{
	wait(0.1);
	playfxontag(common_scripts\utility::getfx("boat_edge_foam_lrg"),self,"tag_origin");
}

//Function Number: 8
intro_flyin_ambient_aa_explosions()
{
	common_scripts\utility::flag_wait("flag_intro_flyin_start");
	var_00 = [(-2454.92,-7780.1,4958.1),(-5471.64,-2899.99,5073.51),(4799.08,-12381,4792.19),(4474.52,-5322.62,6666.92),(-1198,980.487,5543.19),(5206.16,850.314,3753.17),(719.521,4879.09,3999.02),(3180.19,-7005.66,5725.13),(8415.42,-5756.05,6784.86),(13563.5,3264.46,6905.7),(8083.48,10718.6,6292.91),(10237,921.735,7455.87),(-2920.17,-9182.69,3185.09),(-6380.17,-7124.84,5415.17),(-10318.9,-3209.96,6495.42),(-9922.38,-4991.3,3478.46),(-8807.42,1650.15,4981.61),(-4780.44,4040.07,4967.68),(-255.872,9515.52,4520.4),(-1997.23,3363.41,5181.27),(7875.85,4622.89,5116.1),(8144.37,7460.45,4598.42),(835.423,-7068.41,3669.92),(-1745.43,-7102.71,4320.16),(8846.59,-11978.3,5640.06),(-4719.19,-6982.12,2304.75),(147.078,-8776.68,4122.01),(-1006.5,-10855,2850.71),(-1778.03,-4880.55,4015.16),(-2528.28,-2269.13,3771.46),(-4185.88,-1083.29,3323.03),(-8567.06,-2871.12,2920.15),(1948.42,3531.77,4921.3),(7505.36,-143.317,4331.95),(3702.64,-351.159,2336.68),(4255.83,-9032.68,6911.64),(4068.39,-9400.96,3404.24),(6515.71,-4612.6,5057.96),(-5689.55,136.262,3440.72),(5474.33,5218.2,5910.09),(1784.56,5763.77,3057.07),(-152.377,-5020.26,4705.18),(2778.77,-3205.19,3861.42),(-6306.18,-7763.11,2204.21),(-6995.58,2310.19,1484.51),(-5424.44,2234.91,2162.11)];
	var_01 = [(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0)];
	thread maps\_shg_fx::start_fx_by_view("aa_explosion_runner_single",var_00,0.5,5,"msg_fx_zone500_Underwater",0,var_01,"fin_bldg_exp_audio");
}

//Function Number: 9
intro_flyin_ambient_window_glass_explosions()
{
	common_scripts\utility::flag_wait("flag_intro_flyin_start");
	var_00 = [(2596.99,-8758.04,2083.16),(2571.24,-8791.01,1292.81),(2220.96,-8421.4,2298.6),(2240.07,-8431.33,1864.59),(5824.01,-9430.1,2911.5),(5691.65,-9485.05,2031.57),(5704.9,-9095.88,2435.54),(6961.25,-1642.83,2867.18),(6848.9,-777.202,3413.06),(7031.78,-1627.55,4046.94),(5773.96,-9081.06,1664.41),(-2341.32,-5626.44,3921.22),(6876.43,-562.218,2523.21),(-2515.2,-5793.97,2743.38),(-2334.34,-5193.08,3764.78),(-2356.22,-5567.57,3066.44),(-2358.34,-5197.77,4415.58),(3333.42,-8293.94,2315.27),(3292.68,-8371.5,1099.53),(-3486.26,-5832.53,3149.84),(-3167.81,-5919.42,2905.31),(2494.89,-8709.73,843.746),(5638.69,-9460.83,1417.38),(15623.5,4382.07,7285.68),(14516.8,-463.132,5529.97),(15578.3,2843.49,7169.2),(5323.83,-9489.94,1629.53),(-3625.12,-5703.24,2881.11),(-3616.28,-5161.99,2705.71),(14082.8,-687.374,5353.75),(15711,4434.88,6743.12),(16168.7,4533.86,7064.46)];
	var_01 = [(359.976,234.966,-179.9),(359.976,234.966,-179.9),(359.976,234.966,-179.9),(359.976,234.966,-179.9),(0,172.966,179.069),(0,172.966,179.069),(0,172.966,179.069),(0,172.966,179.069),(0,172.966,179.069),(7.72224,206.664,179.373),(0,172.966,179.069),(6.63368,359.434,-178.763),(354.781,147.287,179.171),(352.601,271.617,-179.578),(6.63368,359.434,-178.763),(6.63368,359.434,-178.763),(6.63368,359.434,-178.763),(327.995,325.323,-178.754),(328.337,320.396,-174.436),(352.601,271.617,-179.578),(352.601,271.617,-179.578),(359.976,234.966,-179.9),(0,172.966,179.069),(354.781,147.287,179.171),(354.781,147.287,179.171),(354.781,147.287,179.171),(0,172.966,179.069),(359.777,192.403,178.688),(359.777,192.403,178.688),(354.781,147.287,179.171),(354.781,147.287,179.171),(354.781,147.287,179.171)];
	thread maps\_shg_fx::start_fx_by_view("ambient_explosion_windowglass",var_00,1,3,"msg_fx_zone500_Underwater",0,var_01,"fin_glass_exp_aud");
}

//Function Number: 10
intro_flyin_ambient_explosion_midair_runner_single()
{
	common_scripts\utility::flag_wait("flag_intro_flyin_start");
	var_00 = [(2920.83,-12265.8,2733),(1807.56,-8186.17,3532.09),(5509.28,-7666.14,3714.36),(6201.14,-5691.79,2912.37),(4464.12,-5306.28,2174.13),(671.234,-7742.76,2219.7),(1440.25,-3785.91,2383.25),(-2624.45,-6585.79,2504.79),(-1696.04,-4395.29,3631.62),(-403.643,-2634.1,2630.86),(-6264.27,-7924.32,1903.38),(-7444.25,-2493.92,2652.64),(-6933.7,-4804,2866.51),(-3213.63,-1806.94,2863.91),(-4341.29,1353.27,2281.2),(-1627.81,3125.24,2793.1),(1652.44,-1047.18,2778.87),(3774.67,4866.04,2467.46),(7819.92,3528.87,3325.75),(8720.83,523.385,3213.65),(4878.87,-1781.28,2995.37),(4498.28,2488.85,3845.6),(6448.84,4859.83,2230.1),(5538.96,-10278.3,3738.66),(-2955.24,-10177.9,3359.71),(-2555.68,-11494.6,2525.14),(-8231.62,-6225.31,1949.88),(-6083.02,-686.309,1585.94),(-2412.96,1180.56,3428.81),(574.686,4431.86,3203.09),(7160.62,1537.08,3796.52),(3489.61,-3890.96,2793.97)];
	var_01 = [(359.976,234.966,-179.9),(359.976,234.966,-179.9),(359.976,234.966,-179.9),(359.976,234.966,-179.9),(359.976,234.966,-179.9),(359.976,234.966,-179.9),(359.976,234.966,-179.9),(359.976,234.966,-179.9),(353.976,234.955,-179.899),(353.976,234.955,-179.899),(353.976,234.955,-179.899),(353.976,234.955,-179.899),(353.976,234.955,-179.899),(353.976,234.955,-179.899),(353.976,234.955,-179.899),(353.976,234.955,-179.899),(353.976,234.955,-179.899),(353.976,234.955,-179.899),(353.976,234.955,-179.899),(353.976,234.955,-179.899),(353.976,234.955,-179.899),(353.976,234.955,-179.899),(353.976,234.955,-179.899),(353.976,234.955,-179.899),(353.976,234.955,-179.899),(359.976,234.966,-179.9),(359.976,234.966,-179.9),(353.976,234.955,-179.899),(353.976,234.955,-179.899),(353.976,234.955,-179.899),(353.976,234.955,-179.899),(359.976,234.966,-179.9)];
	thread maps\_shg_fx::start_fx_by_view("ambient_explosion_midair_runner_single",var_00,1,2,"msg_fx_zone500_Underwater",0,var_01,"fin_midair_exp_audio");
}

//Function Number: 11
intro_ambient_aa_explosion_far()
{
	common_scripts\utility::flag_wait("flag_intro_flyin_start");
	var_00 = [(-20709.7,7006.51,7384.32),(-12155.5,14574.4,7615.49),(-4746.41,33595.7,11458.9),(2171.17,23253.6,9135.3),(12542.7,21663.9,10294),(23052.2,29759.6,12262.1),(32476,29647.6,12340.9),(38176.2,21824.1,12351.2),(37434.6,5625.69,10649.5),(41133.5,-5095.2,8974.48),(32580.4,-7671.7,10405.1),(22666.6,-6058.22,7478.42),(14850.4,-5689.28,7780.63),(988.2,-5674.36,9147.01),(-8762.06,-13417.1,10163.2),(-16110,5320.32,9811.13),(6574.95,22482.6,15576.5),(-10984.4,25494.8,12167.5),(4192.07,35443.7,9076.95),(28466,41490.8,8472.42),(44751.3,31845.3,9327.56),(20759.5,-16059.6,10103.6),(-20709.7,7006.51,7384.32),(-12155.5,14574.4,7615.49),(-5816.52,22586.1,8252.17),(2171.17,23253.6,9135.3),(17983.3,34778.7,9581.79),(23052.2,29759.6,12262.1),(34944.1,38037.2,11943.4),(38176.2,21824.1,12351.2),(37434.6,5625.69,10649.5),(41133.5,-5095.2,8974.48),(32580.4,-7671.7,10405.1),(22666.6,-6058.22,7478.42),(14850.4,-5689.28,7780.63),(988.2,-5674.36,9147.01),(-8762.06,-13417.1,10163.2),(-16110,5320.32,9811.13),(-10984.4,25494.8,12167.5),(37378.4,10894,13417.7),(28466,41490.8,8472.42),(24797.1,21409.1,15903),(29166.1,13755.1,16104.9),(29935.2,5882.7,15755.8),(32882.9,4249.55,13377.9),(23348.9,-254.11,7077.4),(25453.5,4725.14,9915.49),(30701.7,-17608.1,10685.7),(24723.7,-5059.06,13512.3),(8949.99,-8142.81,10692),(13269,-18520,10405.5),(15535.9,-10212.5,12864.4),(8724.67,15363.3,21172.9),(20147.6,-11755.8,12842.8),(9796.33,-21568.3,3109.93),(13719.8,-22135.6,6617.46),(18560.3,-20030.6,8239.99),(17485.1,-18090.1,11821.6),(-12859.2,8230.77,12719.1),(-12908.6,11890.6,11377.3),(-2537.33,13181.9,15471.9),(-6837.14,-22935.2,5232.3),(-8759.47,-17350.7,4237.26),(-17303.1,-6264.24,5189.9),(-18414.6,-9516.75,6737.15),(-25115,-6355.32,11686.5),(-16123.4,-21915.4,5807.76),(-26736.4,3637.52,6931.8),(-13151.6,-24452.6,9545.35),(-16823.8,-16120.8,8461.8),(-16413.3,-1328.68,8614.96),(370.593,21368.5,14948.5)];
	var_01 = [(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0)];
	thread maps\_shg_fx::start_fx_by_view("aa_explosion_runner_single",var_00,0.5,2,"msg_fx_zone500_Underwater",0,var_01,"fin_water_exp_audio");
}

//Function Number: 12
player_canal_drop(param_00)
{
	soundscripts\_snd::snd_message("fin_flyin_splash");
	common_scripts\_exploder::exploder("mech_drop_canal_splash");
	var_01 = common_scripts\utility::spawn_tag_origin();
	var_01 linktoplayerview(level.player,"tag_origin",(0,0,-5),(0,0,0),1);
	playfxontag(common_scripts\utility::getfx("underwater_bubble_vm_transition_fast"),var_01,"tag_origin");
	wait(1.85);
	playfxontag(common_scripts\utility::getfx("fin_vm_underwater_hit_bottom"),var_01,"tag_origin");
	wait(2);
	var_01 delete();
}

//Function Number: 13
gideon_water_splash(param_00)
{
	wait(1.5);
	soundscripts\_snd::snd_message("fin_flyin_gideon_splash");
	common_scripts\_exploder::exploder("gideon_water_splash");
	playfxontag(common_scripts\utility::getfx("bubble_trail_runner_lp"),param_00,"j_SpineUpper");
	playfxontag(common_scripts\utility::getfx("bubble_geotrail_thick_med"),param_00,"J_ankle_ri");
	wait 0.05;
	playfxontag(common_scripts\utility::getfx("bubble_geotrail_thick_xsml"),param_00,"j_elbow_le");
	playfxontag(common_scripts\utility::getfx("bubble_geotrail_thick_xsml"),param_00,"j_elbow_ri");
	level waittill("gideon_hit_bottom");
	stopfxontag(common_scripts\utility::getfx("bubble_trail_runner_lp"),param_00,"j_SpineUpper");
	stopfxontag(common_scripts\utility::getfx("bubble_geotrail_thick_med"),param_00,"J_ankle_ri");
	wait 0.05;
	stopfxontag(common_scripts\utility::getfx("bubble_geotrail_thick_xsml"),param_00,"j_elbow_le");
	stopfxontag(common_scripts\utility::getfx("bubble_geotrail_thick_xsml"),param_00,"j_elbow_ri");
}

//Function Number: 14
gideon_water_splash_cg(param_00)
{
	wait(1.5);
	soundscripts\_snd::snd_message("fin_flyin_gideon_splash");
	common_scripts\_exploder::exploder("gideon_water_splash");
	var_01 = common_scripts\utility::spawn_tag_origin();
	var_01 linkto(param_00,"j_SpineUpper");
	var_02 = common_scripts\utility::spawn_tag_origin();
	var_02 linkto(param_00,"J_ankle_ri");
	var_03 = common_scripts\utility::spawn_tag_origin();
	var_03 linkto(param_00,"j_elbow_le");
	var_04 = common_scripts\utility::spawn_tag_origin();
	var_04 linkto(param_00,"j_elbow_ri");
	playfxontag(common_scripts\utility::getfx("bubble_trail_runner_lp"),var_01,"tag_origin");
	playfxontag(common_scripts\utility::getfx("bubble_geotrail_thick_med"),var_02,"tag_origin");
	wait 0.05;
	playfxontag(common_scripts\utility::getfx("bubble_geotrail_thick_xsml"),var_03,"tag_origin");
	playfxontag(common_scripts\utility::getfx("bubble_geotrail_thick_xsml"),var_04,"tag_origin");
	level waittill("gideon_hit_bottom");
	var_01 delete();
	var_02 delete();
	wait 0.05;
	var_03 delete();
	var_04 delete();
}

//Function Number: 15
gideon_canal_bottom(param_00)
{
	level notify("gideon_hit_bottom");
	common_scripts\_exploder::exploder("gideon_hit_bottom");
}

//Function Number: 16
underwater_ambient_fx()
{
	level waittill("msg_fx_zone500_Underwater");
	common_scripts\_exploder::exploder(500);
	common_scripts\_exploder::exploder(525);
	wait(10);
	common_scripts\_exploder::exploder(520);
	wait(15);
	maps\_utility::stop_exploder(520);
	maps\_utility::stop_exploder(525);
	level waittill("msg_fx_zone1000_inside_silo_area");
	maps\_utility::stop_exploder(500);
}

//Function Number: 17
underwater_bullets()
{
	level waittill("msg_fx_zone500_Underwater");
	thread underwater_bullets_vm();
	wait(0.75);
	thread underwater_bullets_500();
	thread underwater_bullets_530();
	thread underwater_bullets_540();
}

//Function Number: 18
underwater_bullets_vm()
{
	wait(0.45);
	wait(0.25);
	wait(0.5);
	common_scripts\_exploder::exploder(552);
	soundscripts\_snd::snd_message("fin_bullet_trails",552);
}

//Function Number: 19
underwater_bullets_500()
{
	var_00 = randomfloatrange(0.65,1.15);
	wait(1.5);
	common_scripts\_exploder::exploder(501);
	soundscripts\_snd::snd_message("fin_bullet_trails",501);
	thread bullet_cluster_01();
	wait(var_00);
	common_scripts\_exploder::exploder(502);
	soundscripts\_snd::snd_message("fin_bullet_trails",502);
	thread bullet_cluster_02();
	wait(var_00);
	common_scripts\_exploder::exploder(503);
	soundscripts\_snd::snd_message("fin_bullet_trails",503);
	thread bullet_cluster_03();
	wait(var_00);
	common_scripts\_exploder::exploder(504);
	soundscripts\_snd::snd_message("fin_bullet_trails",504);
	thread bullet_cluster_04();
	wait(var_00);
	common_scripts\_exploder::exploder(505);
	soundscripts\_snd::snd_message("fin_bullet_trails",505);
	wait(var_00);
	common_scripts\_exploder::exploder(506);
	soundscripts\_snd::snd_message("fin_bullet_trails",506);
	thread bullet_cluster_06();
	wait(var_00);
	common_scripts\_exploder::exploder(507);
	soundscripts\_snd::snd_message("fin_bullet_trails",507);
	thread bullet_cluster_07();
	wait(var_00);
	common_scripts\_exploder::exploder(508);
	soundscripts\_snd::snd_message("fin_bullet_trails",508);
	wait(var_00);
	common_scripts\_exploder::exploder(509);
	soundscripts\_snd::snd_message("fin_bullet_trails",509);
	wait(var_00);
	common_scripts\_exploder::exploder(510);
	soundscripts\_snd::snd_message("fin_bullet_trails",510);
	wait(var_00);
	common_scripts\_exploder::exploder(511);
	soundscripts\_snd::snd_message("fin_bullet_trails",511);
	wait(var_00);
	common_scripts\_exploder::exploder(512);
	soundscripts\_snd::snd_message("fin_bullet_trails",512);
	thread bullet_cluster_12();
	wait(var_00);
	common_scripts\_exploder::exploder(513);
	soundscripts\_snd::snd_message("fin_bullet_trails",513);
	wait(var_00);
	common_scripts\_exploder::exploder(514);
	soundscripts\_snd::snd_message("fin_bullet_trails",514);
	wait(var_00);
	common_scripts\_exploder::exploder(515);
	soundscripts\_snd::snd_message("fin_bullet_trails",515);
	thread bullet_cluster_15();
	wait(var_00);
	common_scripts\_exploder::exploder(516);
	soundscripts\_snd::snd_message("fin_bullet_trails",516);
	wait(var_00);
	common_scripts\_exploder::exploder(517);
	soundscripts\_snd::snd_message("fin_bullet_trails",517);
}

//Function Number: 20
bullet_cluster_01()
{
	var_00 = randomfloatrange(0.15,0.3);
	wait(var_00);
	common_scripts\_exploder::exploder("501a");
	soundscripts\_snd::snd_message("fin_bullet_trails","501a");
	wait(var_00);
	common_scripts\_exploder::exploder("501b");
	soundscripts\_snd::snd_message("fin_bullet_trails","501b");
}

//Function Number: 21
bullet_cluster_02()
{
	var_00 = randomfloatrange(0.15,0.3);
	wait(var_00);
	common_scripts\_exploder::exploder("502a");
	soundscripts\_snd::snd_message("fin_bullet_trails","502a");
	wait(var_00);
	common_scripts\_exploder::exploder("502b");
	soundscripts\_snd::snd_message("fin_bullet_trails","502b");
}

//Function Number: 22
bullet_cluster_03()
{
	var_00 = randomfloatrange(0.15,0.3);
	wait(var_00);
	common_scripts\_exploder::exploder("503a");
	soundscripts\_snd::snd_message("fin_bullet_trails","503a");
	wait(var_00);
	common_scripts\_exploder::exploder("503b");
	soundscripts\_snd::snd_message("fin_bullet_trails","503b");
}

//Function Number: 23
bullet_cluster_04()
{
	var_00 = randomfloatrange(0.15,0.3);
	wait(var_00);
	common_scripts\_exploder::exploder("504a");
	soundscripts\_snd::snd_message("fin_bullet_trails","504a");
}

//Function Number: 24
bullet_cluster_06()
{
	var_00 = randomfloatrange(0.15,0.3);
	wait(var_00);
	common_scripts\_exploder::exploder("506a");
	soundscripts\_snd::snd_message("fin_bullet_trails","506a");
	wait(var_00);
	common_scripts\_exploder::exploder("506b");
	soundscripts\_snd::snd_message("fin_bullet_trails","506b");
}

//Function Number: 25
bullet_cluster_07()
{
	var_00 = randomfloatrange(0.15,0.3);
	wait(var_00);
	common_scripts\_exploder::exploder("507a");
	soundscripts\_snd::snd_message("fin_bullet_trails","507a");
	wait(var_00);
	common_scripts\_exploder::exploder("507b");
	soundscripts\_snd::snd_message("fin_bullet_trails","507b");
}

//Function Number: 26
bullet_cluster_12()
{
	var_00 = randomfloatrange(0.15,0.3);
	wait(var_00);
	common_scripts\_exploder::exploder("512a");
	soundscripts\_snd::snd_message("fin_bullet_trails","512a");
	wait(var_00);
	common_scripts\_exploder::exploder("512b");
	soundscripts\_snd::snd_message("fin_bullet_trails","512b");
}

//Function Number: 27
bullet_cluster_15()
{
	var_00 = randomfloatrange(0.15,0.3);
	wait(var_00);
	common_scripts\_exploder::exploder("515a");
	soundscripts\_snd::snd_message("fin_bullet_trails","515a");
	wait(var_00);
	common_scripts\_exploder::exploder("515b");
	soundscripts\_snd::snd_message("fin_bullet_trails","515b");
}

//Function Number: 28
underwater_bullets_530()
{
	var_00 = randomfloatrange(0.5,1.5);
	common_scripts\utility::flag_wait("fx_underwater_bullets_02");
	common_scripts\_exploder::exploder(530);
	soundscripts\_snd::snd_message("fin_bullet_trails",530);
	wait(var_00);
	common_scripts\_exploder::exploder(531);
	soundscripts\_snd::snd_message("fin_bullet_trails",531);
	wait(var_00);
	common_scripts\_exploder::exploder(532);
	soundscripts\_snd::snd_message("fin_bullet_trails",532);
	thread bullet_cluster_32();
	wait(var_00);
	common_scripts\_exploder::exploder(533);
	soundscripts\_snd::snd_message("fin_bullet_trails",533);
	thread bullet_cluster_33();
	wait(var_00);
	common_scripts\_exploder::exploder(534);
	soundscripts\_snd::snd_message("fin_bullet_trails",534);
	wait(var_00);
	common_scripts\_exploder::exploder(535);
	soundscripts\_snd::snd_message("fin_bullet_trails",535);
	wait(var_00);
	common_scripts\_exploder::exploder(536);
	soundscripts\_snd::snd_message("fin_bullet_trails",536);
	thread bullet_cluster_36();
	wait(var_00);
	common_scripts\_exploder::exploder(537);
	soundscripts\_snd::snd_message("fin_bullet_trails",537);
	thread bullet_cluster_37();
}

//Function Number: 29
bullet_cluster_32()
{
	var_00 = randomfloatrange(0.15,0.3);
	wait(var_00);
	common_scripts\_exploder::exploder("532a");
	soundscripts\_snd::snd_message("fin_bullet_trails","532a");
	wait(var_00);
	common_scripts\_exploder::exploder("532b");
	soundscripts\_snd::snd_message("fin_bullet_trails","532b");
}

//Function Number: 30
bullet_cluster_33()
{
	var_00 = randomfloatrange(0.15,0.3);
	wait(var_00);
	common_scripts\_exploder::exploder("533a");
	soundscripts\_snd::snd_message("fin_bullet_trails","533a");
	wait(var_00);
	common_scripts\_exploder::exploder("533b");
	soundscripts\_snd::snd_message("fin_bullet_trails","533b");
}

//Function Number: 31
bullet_cluster_36()
{
	var_00 = randomfloatrange(0.15,0.3);
	wait(var_00);
	common_scripts\_exploder::exploder("536a");
	soundscripts\_snd::snd_message("fin_bullet_trails","536a");
	wait(var_00);
	common_scripts\_exploder::exploder("536b");
	soundscripts\_snd::snd_message("fin_bullet_trails","536b");
}

//Function Number: 32
bullet_cluster_37()
{
	var_00 = randomfloatrange(0.15,0.3);
	wait(var_00);
	common_scripts\_exploder::exploder("537a");
	soundscripts\_snd::snd_message("fin_bullet_trails","537a");
	wait(var_00);
	common_scripts\_exploder::exploder("537b");
	soundscripts\_snd::snd_message("fin_bullet_trails","537b");
}

//Function Number: 33
underwater_bullets_540()
{
	var_00 = randomfloatrange(2.25,3.5);
	common_scripts\utility::flag_wait("fx_underwater_bullets_03");
	common_scripts\_exploder::exploder(540);
	soundscripts\_snd::snd_message("fin_bullet_trails",540);
	thread bullet_cluster_40();
	wait(var_00);
	common_scripts\_exploder::exploder(541);
	soundscripts\_snd::snd_message("fin_bullet_trails",541);
	thread bullet_cluster_41();
	wait(var_00);
	common_scripts\_exploder::exploder(542);
	soundscripts\_snd::snd_message("fin_bullet_trails",542);
	wait(var_00);
	common_scripts\_exploder::exploder(543);
	soundscripts\_snd::snd_message("fin_bullet_trails",543);
	thread bullet_cluster_43();
	wait(var_00);
	common_scripts\_exploder::exploder(544);
	soundscripts\_snd::snd_message("fin_bullet_trails",544);
	wait(var_00);
	common_scripts\_exploder::exploder(545);
	soundscripts\_snd::snd_message("fin_bullet_trails",545);
	thread bullet_cluster_45();
}

//Function Number: 34
bullet_cluster_40()
{
	var_00 = randomfloatrange(0.15,0.3);
	wait(var_00);
	common_scripts\_exploder::exploder("540a");
	soundscripts\_snd::snd_message("fin_bullet_trails","540a");
	wait(var_00);
	common_scripts\_exploder::exploder("540b");
	soundscripts\_snd::snd_message("fin_bullet_trails","540b");
}

//Function Number: 35
bullet_cluster_41()
{
	var_00 = randomfloatrange(0.15,0.3);
	wait(var_00);
	common_scripts\_exploder::exploder("541a");
	soundscripts\_snd::snd_message("fin_bullet_trails","541a");
	wait(var_00);
	common_scripts\_exploder::exploder("541b");
	soundscripts\_snd::snd_message("fin_bullet_trails","541b");
}

//Function Number: 36
bullet_cluster_43()
{
	var_00 = randomfloatrange(0.15,0.3);
	wait(var_00);
	common_scripts\_exploder::exploder("543a");
	soundscripts\_snd::snd_message("fin_bullet_trails","543a");
	wait(var_00);
	common_scripts\_exploder::exploder("543b");
	soundscripts\_snd::snd_message("fin_bullet_trails","543b");
}

//Function Number: 37
bullet_cluster_45()
{
	var_00 = randomfloatrange(0.15,0.3);
	wait(var_00);
	common_scripts\_exploder::exploder("545a");
	soundscripts\_snd::snd_message("fin_bullet_trails","545a");
	wait(var_00);
	common_scripts\_exploder::exploder("545b");
	soundscripts\_snd::snd_message("fin_bullet_trails","545b");
}

//Function Number: 38
underwater_mech_footsteps()
{
	level waittill("msg_fx_zone500_Underwater");
	animscripts\utility::setnotetrackeffect("vfx_mech_footstepfx_rf","J_Ball_RI",undefined,common_scripts\utility::getfx("footstep_mech_underwater"));
	animscripts\utility::setnotetrackeffect("vfx_mech_footstepfx_lf","J_Ball_LE",undefined,common_scripts\utility::getfx("footstep_mech_underwater"));
	level.gideon thread gideon_mech_water_drips();
	if(level.nextgen)
	{
		level.gideon thread gideon_bubble_trail();
	}
	else
	{
		level.gideon thread gideon_bubble_trail_cg();
	}

	common_scripts\utility::flag_wait("fx_silo_breached");
	animscripts\utility::setnotetrackeffect("vfx_mech_footstepfx_rf","J_Ball_RI",undefined,common_scripts\utility::getfx("footstep_mech_underwater_concrete"));
	animscripts\utility::setnotetrackeffect("vfx_mech_footstepfx_lf","J_Ball_LE",undefined,common_scripts\utility::getfx("footstep_mech_underwater_concrete"));
	common_scripts\utility::flag_wait("fx_stairs_mech");
	animscripts\utility::setnotetrackeffect("vfx_mech_footstepfx_rf","J_Ball_RI",undefined,common_scripts\utility::getfx("no_fx"));
	animscripts\utility::setnotetrackeffect("vfx_mech_footstepfx_lf","J_Ball_LE",undefined,common_scripts\utility::getfx("no_fx"));
	common_scripts\utility::flag_wait("fx_silo_stairs");
	if(level.nextgen)
	{
		level.gideon thread kill_gideon_bubble_trail();
		return;
	}

	level.gideon thread kill_gideon_bubble_trail_cg();
}

//Function Number: 39
gideon_mech_water_drips()
{
	common_scripts\utility::flag_wait("fx_stairs_drips");
	level.gideon thread gideon_mech_footstep_splashes();
	soundscripts\_snd::snd_message("fin_gid_exit_water");
	wait(0.2);
	wait 0.05;
	playfxontag(common_scripts\utility::getfx("fin_gideon_mech_water_drip_rshoulder"),self,"J2_shoulderAmmo_R");
	playfxontag(common_scripts\utility::getfx("fin_gideon_mech_water_drip_lshoulder"),self,"J2_exoShoulderArmor_L1");
	wait 0.05;
	playfxontag(common_scripts\utility::getfx("fin_gideon_mech_water_drip_gun"),self,"TAG_BARREL");
	playfxontag(common_scripts\utility::getfx("fin_gideon_mech_water_drip"),self,"J_SpineLower");
	wait 0.05;
	playfxontag(common_scripts\utility::getfx("fin_gideon_mech_water_drip"),self,"J_Knee_LE");
	playfxontag(common_scripts\utility::getfx("fin_gideon_mech_water_drip"),self,"J_Elbow_RI");
	wait 0.05;
	playfxontag(common_scripts\utility::getfx("fin_gideon_mech_water_drip"),self,"J_Wrist_LE");
	playfxontag(common_scripts\utility::getfx("fin_gideon_mech_water_drip"),self,"J_Shoulder_RI");
	wait 0.05;
	playfxontag(common_scripts\utility::getfx("fin_gideon_mech_water_drip"),self,"J_Shoulder_LE");
}

//Function Number: 40
gideon_mech_footstep_splashes()
{
	wait(1);
	animscripts\utility::setnotetrackeffect("vfx_mech_footstepfx_rf","J_Ball_RI",undefined,common_scripts\utility::getfx("footstep_mech_water"));
	animscripts\utility::setnotetrackeffect("vfx_mech_footstepfx_lf","J_Ball_LE",undefined,common_scripts\utility::getfx("footstep_mech_water"));
	wait(3);
	animscripts\utility::setnotetrackeffect("vfx_mech_footstepfx_rf","J_Ball_RI",undefined,common_scripts\utility::getfx("no_fx"));
	animscripts\utility::setnotetrackeffect("vfx_mech_footstepfx_lf","J_Ball_LE",undefined,common_scripts\utility::getfx("no_fx"));
}

//Function Number: 41
gideon_bubble_trail()
{
	playfxontag(common_scripts\utility::getfx("bubble_trail_mech_runner_lp"),self,"J_Neck");
	wait 0.05;
	playfxontag(common_scripts\utility::getfx("bubble_trail_mech_runner_lp"),self,"J_Knee_LE");
	wait 0.05;
	playfxontag(common_scripts\utility::getfx("bubble_trail_mech_runner_lp"),self,"J_Elbow_LE");
	wait 0.05;
	playfxontag(common_scripts\utility::getfx("bubble_trail_mech_runner_lp"),self,"J_Elbow_RI");
}

//Function Number: 42
gideon_bubble_trail_cg()
{
	var_00 = common_scripts\utility::spawn_tag_origin();
	var_00 linkto(self,"J_Neck");
	self.neck_org = var_00;
	var_01 = common_scripts\utility::spawn_tag_origin();
	var_01 linkto(self,"J_Knee_LE");
	self.knee_l_org = var_01;
	var_02 = common_scripts\utility::spawn_tag_origin();
	var_02 linkto(self,"J_Elbow_LE");
	self.elbow_l_org = var_02;
	var_03 = common_scripts\utility::spawn_tag_origin();
	var_03 linkto(self,"J_Elbow_RI");
	self.elbow_r_org = var_03;
	playfxontag(common_scripts\utility::getfx("bubble_trail_mech_runner_lp"),var_00,"tag_origin");
	wait 0.05;
	playfxontag(common_scripts\utility::getfx("bubble_trail_mech_runner_lp"),var_01,"tag_origin");
	wait 0.05;
	playfxontag(common_scripts\utility::getfx("bubble_trail_mech_runner_lp"),var_02,"tag_origin");
	wait 0.05;
	playfxontag(common_scripts\utility::getfx("bubble_trail_mech_runner_lp"),var_03,"tag_origin");
}

//Function Number: 43
kill_gideon_bubble_trail()
{
	stopfxontag(common_scripts\utility::getfx("bubble_trail_mech_runner_lp"),self,"J_Neck");
	wait 0.05;
	stopfxontag(common_scripts\utility::getfx("bubble_trail_mech_runner_lp"),self,"J_Knee_LE");
	wait 0.05;
	stopfxontag(common_scripts\utility::getfx("bubble_trail_mech_runner_lp"),self,"J_Elbow_LE");
	wait 0.05;
	stopfxontag(common_scripts\utility::getfx("bubble_trail_mech_runner_lp"),self,"J_Elbow_RI");
}

//Function Number: 44
kill_gideon_bubble_trail_cg()
{
	self.neck_org delete();
	wait 0.05;
	self.knee_l_org delete();
	wait 0.05;
	self.elbow_l_org delete();
	wait 0.05;
	self.elbow_r_org delete();
}

//Function Number: 45
vfx_missile_loading(param_00)
{
	common_scripts\_exploder::exploder("missile_loading_steam");
	level waittill("missile_docking");
	maps\_utility::pauseexploder("missile_loading_steam");
}

//Function Number: 46
vfx_missile_docking_end(param_00)
{
	level notify("missile_docking");
}

//Function Number: 47
vfx_silo_corridor_lowering()
{
	common_scripts\_exploder::exploder("corridor_lower_steam");
	common_scripts\_exploder::exploder("ceiling_steam_bursts");
	wait(3.5);
	maps\_utility::pauseexploder("ceiling_steam_bursts");
	wait(3.5);
	maps\_utility::pauseexploder("corridor_lower_steam");
}

//Function Number: 48
vfx_catwalk_lowering()
{
	common_scripts\_exploder::exploder("steam_catwalk_dissipate");
	wait(1);
	common_scripts\_exploder::exploder("steam_catwalk_low");
	wait(6);
	maps\_utility::pauseexploder("steam_catwalk_dissipate");
	wait(2);
	maps\_utility::pauseexploder("steam_catwalk_low");
}

//Function Number: 49
rocket_fail_smoke()
{
	common_scripts\utility::flag_wait("flag_countdown_complete_mission_fail");
	wait(4);
	common_scripts\_exploder::exploder("rocket_fail_sparks_start");
	wait(4);
	common_scripts\_exploder::exploder("rocket_fail_start");
	maps\_utility::pauseexploder("rocket_fail_sparks_start");
	wait(0.3);
	common_scripts\_exploder::exploder("rocket_fail_smk");
}

//Function Number: 50
gideon_door_mech_kick(param_00)
{
	wait(0.05);
	common_scripts\_exploder::exploder("door_kick_01");
	wait(0.15);
	common_scripts\_exploder::exploder("door_kick_02");
	wait(0.2);
	common_scripts\_exploder::exploder("door_kick_03");
	common_scripts\_exploder::exploder("door_kick_04");
	wait(1);
	common_scripts\_exploder::exploder("door_kick_04");
}

//Function Number: 51
door_kick_smoke(param_00)
{
	playfxontag(common_scripts\utility::getfx("fin_door_kick_slide_sparks"),param_00,"TAG_ORIGIN_ANIMATED");
}

//Function Number: 52
exhaust_hatch_break_gideon(param_00)
{
	common_scripts\_exploder::exploder("bar_break_gid");
	wait(0.8);
	common_scripts\_exploder::exploder("bar_hit_ground_gid");
}

//Function Number: 53
exhaust_hatch_break_player(param_00)
{
	common_scripts\_exploder::exploder("bar_break_player");
	wait(1.7);
	common_scripts\_exploder::exploder("bar_hit_ground");
}

//Function Number: 54
exhaust_hatch_open(param_00)
{
	common_scripts\_exploder::exploder("hatch_open");
	wait(0.5);
	common_scripts\_exploder::exploder("hatch_exhaust");
	wait(5);
	maps\_utility::stop_exploder("hatch_exhaust");
}

//Function Number: 55
exhaust_hatch_land_player(param_00)
{
	var_01 = common_scripts\utility::spawn_tag_origin();
	var_01 linkto(param_00,"tag_origin",(0,0,0),(270,0,0));
	playfxontag(common_scripts\utility::getfx("fin_hatch_exhaust_mech_land"),var_01,"tag_origin");
	wait(2);
	var_01 delete();
}

//Function Number: 56
exhaust_hatch_land_gideon(param_00)
{
	var_01 = common_scripts\utility::spawn_tag_origin();
	var_01 linkto(param_00,"tag_origin",(0,0,0),(270,0,0));
	playfxontag(common_scripts\utility::getfx("fin_hatch_exhaust_mech_land"),var_01,"tag_origin");
	wait(3);
	var_01 delete();
}

//Function Number: 57
vfx_open_vent(param_00)
{
	wait(2);
	common_scripts\_exploder::exploder("vfx_open_vent");
	wait(1.6);
	maps\_utility::pauseexploder("vfx_open_vent");
}

//Function Number: 58
player_rocket()
{
	wait 0.05;
	common_scripts\utility::flag_wait("flag_exhaust_hatch_open");
	common_scripts\_exploder::exploder("liquid_hydrogen");
	level.player waittill("notetrack_vfx_ignition");
	common_scripts\_exploder::exploder("ignition_sparks");
	wait(1);
	common_scripts\_exploder::exploder("ignition_fire");
	wait(1.5);
	common_scripts\_exploder::exploder("fin_tunnel_smoke");
	maps\_utility::pauseexploder("liquid_hydrogen");
	maps\_utility::stop_exploder("ignition_sparks");
	var_00 = getent("missile_main_02","targetname");
	earthquake(0.3,2,var_00.origin,3000);
	level.player waittill("notetrack_vfx_blast");
	thread maps\finale_lighting::red_burn_lighting_fog();
	maps\_utility::stop_exploder("fin_tunnel_smoke");
	wait(0.1);
	common_scripts\_exploder::exploder("fin_red_thruster");
	wait(0.55);
	common_scripts\_exploder::exploder("red_thruster_constant");
	wait(0.5);
	maps\_utility::pauseexploder("fin_red_thruster");
	var_00 = getent("missile_main_02","targetname");
	earthquake(1,4,var_00.origin,3000);
	wait(0.5);
	common_scripts\_exploder::exploder("fin_yellow_thruster");
	maps\_utility::pauseexploder("red_thruster_constant");
	var_00 = getent("missile_main_02","targetname");
	earthquake(0.3,80,var_00.origin,3000);
	level.player waittill("notetrack_rocket_launch_start");
	maps\_utility::pauseexploder("fin_yellow_thruster");
	maps\_utility::pauseexploder("ignition_fire");
	common_scripts\_exploder::exploder("fire_tunnel_blue");
	thread maps\finale_lighting::cold_burn_lighting_fog();
	playfxontag(common_scripts\utility::getfx("fin_rocket_thruster_blue"),var_00,"missile");
	earthquake(0.4,3,var_00.origin,2000);
	wait(0.8);
	playfxontag(common_scripts\utility::getfx("fin_rocket_thruster_sml"),var_00,"tag_attach1");
	earthquake(0.3,2,var_00.origin,2000);
	wait(0.6);
	playfxontag(common_scripts\utility::getfx("fin_rocket_thruster_sml"),var_00,"tag_attach2");
	earthquake(0.3,2,var_00.origin,2000);
	wait(0.6);
	playfxontag(common_scripts\utility::getfx("fin_rocket_thruster_sml"),var_00,"tag_attach3");
	earthquake(0.3,2,var_00.origin,2000);
	wait(0.5);
	playfxontag(common_scripts\utility::getfx("fin_rocket_thruster_sml"),var_00,"tag_attach4");
	earthquake(0.3,2,var_00.origin,2000);
	wait(0.4);
	playfxontag(common_scripts\utility::getfx("fin_rocket_thruster_sml"),var_00,"tag_attach5");
	earthquake(0.3,3,var_00.origin,2000);
	wait(0.3);
	playfxontag(common_scripts\utility::getfx("fin_rocket_thruster_sml"),var_00,"tag_attach6");
	earthquake(0.2,40,var_00.origin,2000);
	common_scripts\utility::flag_wait("flag_obj_stop_missile_launch_complete");
	maps\_utility::pauseexploder("fire_tunnel_blue");
	common_scripts\_exploder::exploder("thruster_idle_smoke");
	playfxontag(common_scripts\utility::getfx("fin_rocket_thruster_blue_idle"),var_00,"missile");
	stopfxontag(common_scripts\utility::getfx("fin_rocket_thruster_blue"),var_00,"missile");
	wait(0.3);
	playfxontag(common_scripts\utility::getfx("fin_rocket_thruster_sml_idle"),var_00,"tag_attach1");
	stopfxontag(common_scripts\utility::getfx("fin_rocket_thruster_sml"),var_00,"tag_attach1");
	wait(0.3);
	playfxontag(common_scripts\utility::getfx("fin_rocket_thruster_sml_idle"),var_00,"tag_attach2");
	stopfxontag(common_scripts\utility::getfx("fin_rocket_thruster_sml"),var_00,"tag_attach2");
	wait(0.2);
	playfxontag(common_scripts\utility::getfx("fin_rocket_thruster_sml_idle"),var_00,"tag_attach3");
	stopfxontag(common_scripts\utility::getfx("fin_rocket_thruster_sml"),var_00,"tag_attach3");
	wait(0.2);
	playfxontag(common_scripts\utility::getfx("fin_rocket_thruster_sml_idle"),var_00,"tag_attach4");
	stopfxontag(common_scripts\utility::getfx("fin_rocket_thruster_sml"),var_00,"tag_attach4");
	wait(0.2);
	playfxontag(common_scripts\utility::getfx("fin_rocket_thruster_sml_idle"),var_00,"tag_attach5");
	stopfxontag(common_scripts\utility::getfx("fin_rocket_thruster_sml"),var_00,"tag_attach5");
	wait(0.2);
	playfxontag(common_scripts\utility::getfx("fin_rocket_thruster_sml_idle"),var_00,"tag_attach6");
	stopfxontag(common_scripts\utility::getfx("fin_rocket_thruster_sml"),var_00,"tag_attach6");
	thread silo_rocket_blowup();
}

//Function Number: 59
silo_rocket_blowup()
{
	common_scripts\utility::flag_wait("flag_obj_stop_missile_launch_complete");
	common_scripts\_exploder::exploder("silo_sparks");
	common_scripts\_exploder::exploder("metal_falling3");
	common_scripts\_exploder::exploder("steam_pipe_break1");
	common_scripts\_exploder::exploder("metal_close");
	wait(0.5);
	common_scripts\_exploder::exploder("metal_falling2");
	wait(2);
	common_scripts\_exploder::exploder("metal_falling1");
	common_scripts\_exploder::exploder("steam_leak");
	wait(0.5);
	common_scripts\_exploder::exploder("falling_panel_1");
	common_scripts\_exploder::exploder("steam_pipe_break1");
	wait(1);
	common_scripts\_exploder::exploder("falling_panel_2");
	common_scripts\_exploder::exploder("steam_pipe_break2");
	common_scripts\_exploder::exploder("metal_falling2");
	wait(0.5);
	common_scripts\_exploder::exploder("steam_pipe_break_3");
	common_scripts\_exploder::exploder("metal_falling3");
	wait(0.5);
	common_scripts\_exploder::exploder("steam_pipe_break1");
	wait(0.5);
	common_scripts\_exploder::exploder("steam_pipe_break2");
	wait(0.5);
	common_scripts\_exploder::exploder("steam_pipe_break_3");
	common_scripts\_exploder::exploder("metal_falling3");
	wait(0.3);
	common_scripts\_exploder::exploder("metal_falling1");
	common_scripts\_exploder::exploder("falling_panel_1");
	wait(5);
	maps\_utility::pauseexploder("steam_leak");
	wait(7);
	maps\_utility::pauseexploder("silo_sparks");
	common_scripts\_exploder::exploder("silo_fire");
	wait(3);
	common_scripts\_exploder::exploder("metal_falling4");
}

//Function Number: 60
view_clamping_unlock()
{
	wait(5);
	level.player playerlinktodelta(self,"tag_player",1,20,20,20,20,1);
}

//Function Number: 61
vfx_gideon_mech_sparks(param_00)
{
	playfxontag(common_scripts\utility::getfx("mech_damage_sparks_lp"),param_00,"j_elbow_ri");
	wait(0.5);
	playfxontag(common_scripts\utility::getfx("mech_damage_sparks_lp"),param_00,"j_SpineUpper");
	level waittill("stop_mech_effects");
	stopfxontag(common_scripts\utility::getfx("mech_damage_sparks_lp"),param_00,"j_elbow_ri");
	stopfxontag(common_scripts\utility::getfx("mech_damage_sparks_lp"),param_00,"j_SpineUpper");
}

//Function Number: 62
vfx_gideon_mech_rolls_over(param_00)
{
}

//Function Number: 63
vfx_vm_mech_sparks(param_00)
{
}

//Function Number: 64
vfx_vm_mech_stop_effects(param_00)
{
	level notify("stop_mech_effects");
}

//Function Number: 65
vfx_vm_mech_dmg_sparks(param_00)
{
	playfxontag(common_scripts\utility::getfx("mech_damage_sparks_lp"),param_00,"j_elbow_ri");
	level waittill("stop_vm_mech_dmg_exit_effects");
	stopfxontag(common_scripts\utility::getfx("mech_damage_sparks_lp"),param_00,"j_elbow_ri");
}

//Function Number: 66
vfx_vm_mech_dmg_stop(param_00)
{
	level notify("stop_vm_mech_dmg_exit_effects");
}

//Function Number: 67
city_ambient_fx()
{
	level waittill("sky_bridge_vfx");
	common_scripts\_exploder::exploder("1250");
	level waittill("msg_fx_zone1500_will_room");
	maps\_utility::stop_exploder("1250");
}

//Function Number: 68
lobby_ambient_aa_explosions()
{
	level waittill("msg_fx_zone1200_lobby");
	var_00 = [(19736.3,-81201.1,6196.13),(20326.3,-79994,6168.28),(20242.2,-81596,7343.56),(22233.2,-76351,6777.65),(20011.2,-78193.8,6131.02),(12361.5,-91154.7,9126.11),(8435.29,-90739,8148.44),(10200.3,-88663.2,6542.32),(12048.4,-87566,6595.51),(9218.16,-88224,8567.6),(12797.4,-89343.2,9535.41),(22749.1,-82353.5,6832.5),(13236.1,-87067,7096.58),(22476.3,-79821.1,7969.65),(10947.5,-86478.5,7118.63),(10868.1,-85830.2,7855.8)];
	var_01 = [(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0)];
	thread maps\_shg_fx::start_fx_by_view("aa_explosion_runner_single",var_00,1,4,"sky_bridge_vfx",0,var_01);
}

//Function Number: 69
lobby_ambient_explosion_midair_runner_single()
{
	level waittill("msg_fx_zone1200_lobby");
	var_00 = [(19877.2,-79864.8,6888.36),(19678.5,-77684.2,6791.43),(9107.69,-89243.1,6073.12),(12487.5,-92650.9,8446.7),(9298.35,-89098.5,9392.02),(14205.4,-85589.7,6770.85),(12860.9,-86394.9,6118.32),(13143.9,-88688.8,8805.71),(24161,-81664.9,6585.47),(20303.4,-82089.7,7262.87),(10241.6,-87617.2,7091.35),(19590.2,-77617.1,6095.31),(11175.6,-87714.1,6193.76),(11340.4,-86181.1,7414.02),(20793.7,-80326.9,5903.01),(20724.3,-78300,5931.67)];
	var_01 = [(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0)];
	thread maps\_shg_fx::start_fx_by_view("ambient_explosion_midair_runner_single",var_00,3,6,"msg_fx_zone1500_will_room",0,var_01);
}

//Function Number: 70
dazed_sky_bridge_explosions()
{
	level waittill("sky_bridge_vfx");
	wait(2.5);
	common_scripts\_exploder::exploder("1400");
	wait(0.3);
	common_scripts\_exploder::exploder("1445");
	wait(1.2);
	common_scripts\_exploder::exploder("1410");
	wait(1.4);
	common_scripts\_exploder::exploder("1400");
	common_scripts\_exploder::exploder("1440");
	wait(0.5);
	common_scripts\_exploder::exploder("1445");
	wait(0.8);
	common_scripts\_exploder::exploder("1440");
}

//Function Number: 71
skybridge_ambient_explosions()
{
	level waittill("sky_bridge_vfx");
	var_00 = [(4654.03,-102993,10692.7),(13108.2,-101759,9690.11),(736.915,-101098,9018.34),(15751.2,-102791,11452.8),(10144.1,-106871,11625.6),(2581.71,-100424,12561.6),(17300,-97559.2,8630.33),(9033.09,-97071.9,12803.7),(15428.6,-98442.5,13594.4),(5523.56,-104965,14269.9)];
	var_01 = [(7.85488,241.093,-174.052),(7.85488,241.093,-174.052),(7.85488,241.093,-174.052),(7.85488,241.093,-174.052),(7.85488,241.093,-174.052),(7.85488,241.093,-174.052),(7.85488,241.093,-174.052),(7.85488,241.093,-174.052),(7.85488,241.093,-174.052),(7.85488,241.093,-174.052)];
	thread maps\_shg_fx::start_fx_by_view("ambient_explosion_midair_runner_single",var_00,0.5,4,"msg_fx_zone1500_will_room",0,var_01);
}

//Function Number: 72
skybridge_ambient_aa_explosions()
{
	level waittill("sky_bridge_vfx");
	var_00 = [(2891.15,-103482,14244.9),(8019.56,-104272,15480),(3658.89,-90765.2,9855.59),(10137.5,-100169,16460.7),(15199.7,-108507,13215.5),(1598.96,-101172,16679.1),(14825.9,-100589,14981.1),(4983.57,-106438,20693.1),(20345.4,-104944,13060.4),(13528.8,-100043,18455.4),(1970.3,-110849,19329.2)];
	var_01 = [(7.85488,241.093,-174.052),(7.85488,241.093,-174.052),(7.85488,241.093,-174.052),(7.85488,241.093,-174.052),(7.85488,241.093,-174.052),(7.85488,241.093,-174.052),(7.85488,241.093,-174.052),(7.85488,241.093,-174.052),(7.85488,241.093,-174.052),(7.85488,241.093,-174.052),(7.85488,241.093,-174.052)];
	thread maps\_shg_fx::start_fx_by_view("aa_explosion_runner_single",var_00,1,3,"msg_fx_zone1500_will_room",0,var_01);
}

//Function Number: 73
vfx_irons_reveal_scene()
{
	level.player common_scripts\utility::delaycall(57.5,::playrumbleonentity,"artillery_rumble");
	wait(57);
	common_scripts\_exploder::exploder("falling_dust_irons");
	wait(0.55);
	for(var_00 = 0;var_00 < 3;var_00++)
	{
		level.player lightsetforplayer("finale_will_lit_dark");
		common_scripts\_exploder::kill_exploder("lighton");
		wait(randomfloatrange(0.05,0.1));
		common_scripts\_exploder::exploder("lighton");
		level.player lightsetforplayer("finale_will_lit");
		wait(randomfloatrange(0.05,0.1));
	}
}

//Function Number: 74
vfx_explosion_rumble_dust(param_00)
{
	level.player playrumbleonentity("artillery_rumble");
	common_scripts\_exploder::exploder("falling_dust_irons");
	wait(0.5);
	common_scripts\_exploder::exploder("falling_dust_irons_2");
}

//Function Number: 75
exo_release_vm_error_glow(param_00)
{
	playfxontag(common_scripts\utility::getfx("fin_exo_exit_glow_vm"),param_00,"J_Elbow_LE");
	wait(7);
	common_scripts\_exploder::kill_exploder("lighton");
}

//Function Number: 76
exo_release_gideon_error_glow()
{
	playfxontag(common_scripts\utility::getfx("fin_exo_exit_glow_gideon"),self,"J_Elbow_LE");
}

//Function Number: 77
rooftop_bombshakes()
{
	common_scripts\utility::flag_wait("msg_fx_zone2000_finale_roof");
	var_00 = common_scripts\utility::spawn_tag_origin();
	var_00.origin = self.player getorigin();
	var_00.angles = (270,0,-30);
	if(!isdefined(level.bombshake_interval))
	{
		level.bombshake_interval = 3;
		level.bombshake_interval_rand = 2;
	}

	for(;;)
	{
		common_scripts\utility::flag_waitopen("flag_bridge_takedown_jump_complete");
		if(common_scripts\utility::flag("msg_fx_zone2000_finale_roof"))
		{
			var_01 = 1008;
			var_00.origin = self.player getorigin();
			var_02 = bullettrace(self.player.origin + (0,0,12),self.player.origin + (0,0,1200),0,undefined);
			var_03 = distance(var_00.origin,var_02["position"]);
			if(var_03 < 200)
			{
				maps\_shg_fx::fx_bombshakes("dust_falling_light_sml_01","viewmodel_medium",0.127,2,0.3,0.53);
				level.player playrumbleonentity("artillery_rumble");
			}
		}

		var_04 = randomfloatrange(level.bombshake_interval_rand * -1,level.bombshake_interval_rand) + level.bombshake_interval;
		wait(var_04);
	}
}

//Function Number: 78
end_roof_ambient_aa_explosions()
{
	level waittill("msg_fx_zone2000_finale_roof");
	var_00 = [(28703.9,-88023.5,11551),(25077.8,-84256.8,12100.7),(28887.8,-79686.6,9774.34),(24696.7,-81974,12089.4),(22728,-80444.8,10428.3),(31915.3,-84699.8,14781.3),(25735.8,-88644.5,10002.1),(27265.4,-89793.7,11532.1),(24224,-91568,11330.7),(25254.6,-91533.8,10644.4),(24560.8,-92454.8,13595.9),(28707.7,-95667.6,10299.2),(23550.3,-79951.1,12258.5),(21190.7,-80163.7,11070.2),(19338.8,-79769.9,11707.2),(21419,-75094.7,10657),(17673.9,-76488.6,10542),(16869.9,-80385.9,11332.6),(26806.4,-91364.5,14506.9),(25643.1,-88129,12719.4),(14173.2,-78073.8,12742.2),(15887.1,-78018.1,13130.5),(14944.6,-75276.4,10847.7),(19736.1,-82553,11637.7),(17740.4,-80421,12633.4),(24259.9,-81211.7,14150.9),(27089.1,-95804.8,12968.9),(22356.6,-93927.5,12621.6),(30944.8,-79806.1,8693.74),(28123.8,-71647,9182.44),(31380.5,-74470.8,9871.97),(25359.1,-80539.9,10515.7),(36674.8,-93126.5,9679.31),(31733.7,-95108,9175.21),(25619.9,-86854,14161.5),(22226.9,-94309.3,10330.2),(21923.2,-95930.2,12235.1),(20882.5,-99521.3,14230.7),(19706.3,-90424.1,11999.8),(23950,-98925.1,9814.04),(17665,-94561.3,13209),(19034.6,-98377.5,10083.2),(16737.9,-97170.3,12966.1),(15529.7,-97697.8,14274.2),(14298.2,-97084.1,11167.8),(13709,-101641,13791.6),(15771.5,-95331.8,11045),(18642.5,-98693.9,12202.7),(12463.6,-99664.3,8967.25),(13636.4,-97820,10217.7),(10947.2,-97552.8,8803.92),(11118.4,-95462.6,10422)];
	var_01 = [(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0)];
	thread maps\_shg_fx::start_fx_by_view("aa_explosion_runner_single",var_00,1.2,4,"sky_bridge_vfx",0,var_01);
}

//Function Number: 79
end_roof_ambient_midair_runner_explosion_single()
{
	level waittill("msg_fx_zone2000_finale_roof");
	var_00 = [(32939.7,-89510,9355),(34815.8,-74121.7,8237.19),(28000.8,-92981.9,8373.73),(28787.3,-88340.4,12277.6),(24359.2,-95049.5,9609.53),(27131,-90919.9,10099.8),(20258.8,-98544.3,10971.9),(30443.6,-65642.4,12367.8),(43590.4,-95567.2,9375.89),(28369.5,-75757.4,11107.3),(18073,-104800,11254.5),(13845.2,-98679.2,9980.36),(19738.5,-75864,11766.2),(19040.4,-77124.1,8839.73),(22193.8,-98347.2,9323.64),(15987.4,-79446.2,8981.93),(15322.9,-74888.5,11718.7),(24732.2,-75238.4,8334.43),(11081.9,-96884.3,8672.88),(14884.7,-97183.7,8020.07),(12432,-98050.2,7523.47),(25484.1,-92778.2,11690.8)];
	var_01 = [(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0),(270,0,0)];
	thread maps\_shg_fx::start_fx_by_view("ambient_explosion_midair_runner_single",var_00,1.8,6,"sky_bridge_vfx",0,var_01);
}

//Function Number: 80
ambient_smk_walkway()
{
	common_scripts\utility::flag_wait("msg_fx_zone2000_finale_roof");
	common_scripts\_exploder::exploder("smk_walkway");
	common_scripts\utility::flag_wait("flag_balcony_tackle_success");
	maps\_utility::pauseexploder("smk_walkway");
}

//Function Number: 81
vfx_landing_dust_npc(param_00)
{
	wait(0.15);
	common_scripts\_exploder::exploder("dust_poof_landing");
}

//Function Number: 82
vfx_push_over_ledge(param_00)
{
}

//Function Number: 83
vfx_irons_tackle(param_00)
{
	common_scripts\_exploder::exploder("irons_tackle_dust");
	wait(3);
	maps\_utility::pauseexploder("irons_tackle_dust");
}

//Function Number: 84
vfx_balcony_break_through(param_00)
{
	common_scripts\_exploder::exploder("balcony_break_dust");
	level notify("balcony_break_through_complete");
	common_scripts\utility::flag_wait("flag_obj_irons_complete");
	maps\_utility::pauseexploder("balcony_break_dust");
}

//Function Number: 85
grand_finale_fx()
{
	common_scripts\utility::flag_wait("flag_bridge_takedown_jump_complete");
	thread grand_finale_fire_pool_fx();
	thread grand_finale_rooftop_explode();
	thread grand_finale_building_explosion_smk();
	if(level.nextgen)
	{
		thread grand_finale_iron_head_skin_override();
	}

	thread grand_finale_building_window_explosion_roofhang();
	thread grand_fianle_paper_blowing();
	thread grand_finale_ambientfx_atlas_logo();
}

//Function Number: 86
grand_finale_rooftop_explode()
{
	level waittill("vfx_rooftop_glass_explode");
	var_00 = randomfloatrange(0.05,0.15);
	wait(var_00);
	common_scripts\_exploder::exploder("roof_glass_shatter");
}

//Function Number: 87
grand_finale_building_explosion_smk()
{
	level waittill("vfx_rooftop_glass_explode");
	common_scripts\_exploder::exploder("building_explo");
}

//Function Number: 88
grand_fianle_paper_blowing()
{
	level waittill("balcony_break_through_complete");
	wait(1);
	common_scripts\_exploder::exploder("roofhang_paper_blowing_1");
	wait(1);
	common_scripts\_exploder::exploder("roofhang_paper_blowing_2");
}

//Function Number: 89
grand_finale_building_window_explosion_roofhang()
{
	level waittill("balcony_break_through_complete");
	wait(5.8);
	common_scripts\_exploder::exploder("roofhang_window_explo_1");
	wait(2.5);
	common_scripts\_exploder::exploder("roofhang_window_explo_2");
}

//Function Number: 90
grand_finale_fire_pool_fx()
{
	common_scripts\_exploder::exploder(3000);
}

//Function Number: 91
vfx_irons_fail_fall()
{
	common_scripts\_exploder::exploder("fail_falling_debris");
	playfxontag(common_scripts\utility::getfx("fin_irons_vector_field_lp"),level.irons,"j_SpineUpper");
	wait(4);
	common_scripts\_exploder::kill_exploder("fail_falling_debris");
	stopfxontag(common_scripts\utility::getfx("fin_irons_vector_field_lp"),level.irons,"j_SpineUpper");
}

//Function Number: 92
grand_finale_iron_head_skin_override()
{
	common_scripts\utility::flag_wait("flag_balcony_tackle_success");
	level.irons overridematerial("mtl_irons_head_wrinkle_tns","mtl_irons_head_wrinkle_finalehang_tns");
}

//Function Number: 93
grand_finale_ambientfx_atlas_logo()
{
	common_scripts\utility::flag_wait("flag_balcony_tackle_success");
	common_scripts\_exploder::exploder("3510");
}

//Function Number: 94
vfx_vm_arm_stab(param_00)
{
	wait(0.1);
	playfxontag(common_scripts\utility::getfx("fin_player_arm_cut_sparks"),param_00,"J_Elbow_LE");
	level waittill("kill_looping_arm_fx");
	stopfxontag(common_scripts\utility::getfx("fin_player_arm_cut_sparks"),param_00,"J_Elbow_LE");
}

//Function Number: 95
vfx_vm_arm_sever(param_00)
{
	playfxontag(common_scripts\utility::getfx("fin_player_arm_cut_spark_burst_single"),param_00,"J_Elbow_LE");
}

//Function Number: 96
vfx_arm_piece_fall(param_00)
{
	level notify("kill_looping_arm_fx");
	playfxontag(common_scripts\utility::getfx("fin_player_arm_cut_sparks_trail"),param_00,"J_Elbow_LE");
	wait(2);
	stopfxontag(common_scripts\utility::getfx("fin_player_arm_cut_sparks_trail"),param_00,"J_Elbow_LE");
}

//Function Number: 97
vfx_irons_fall_death(param_00)
{
}