/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: lagos_fx.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 75
 * Decompile Time: 1076 ms
 * Timestamp: 4/22/2024 2:33:45 AM
*******************************************************************/

//Function Number: 1
main()
{
	precachefx();
	set_lighting_values();
	if(!getdvarint("r_reflectionProbeGenerate"))
	{
		maps\createfx\lagos_fx::main();
	}

	if(!isdefined(level.createfxent))
	{
		level.createfxent = [];
	}

	maps\_shg_fx::setup_shg_fx();
	init_smvals();
	common_scripts\utility::flag_init("flag_roundabout_spawn_vehicles");
	common_scripts\utility::flag_init("roundabout_combat_begin");
	common_scripts\utility::flag_init("roundabout_tanker_flash");
	common_scripts\utility::flag_init("tanker_explosion_done");
	common_scripts\utility::flag_init("kill_roundabout_flames");
	common_scripts\utility::flag_init("roundabout_combat_begin");
	common_scripts\utility::flag_init("alley1_oncoming_start");
	thread maps\_shg_fx::fx_zone_watcher(1000,"msg_fx_zone1_overpass");
	thread maps\_shg_fx::fx_zone_watcher(2000,"msg_fx_zone2_train_station");
	thread maps\_shg_fx::fx_zone_watcher(3000,"msg_fx_zone3_train_rooftop_entry","msg_fx_zone3b_train_rooftop_entry");
	thread maps\_shg_fx::fx_zone_watcher(4000,"msg_fx_zone4_government_building","msg_fx_zone4b_gov_building_exit");
	thread maps\_shg_fx::fx_zone_watcher(5000,"msg_fx_zone5_gov_back_street","msg_fx_zone3_train_rooftop_entry");
	thread maps\_shg_fx::fx_zone_watcher(6000,"msg_fx_zone6_roundabout");
	thread maps\_shg_fx::fx_zone_watcher(7000,"msg_fx_zone7_alley1","msg_fx_zone7b_alley1");
	thread maps\_shg_fx::fx_zone_watcher(8000,"msg_fx_zone8_recreationcenter","msg_fx_zone8b_recreationcenter");
	thread maps\_shg_fx::fx_zone_watcher(9000,"msg_fx_zone9a_market","msg_fx_zone9b_market");
	thread maps\_shg_fx::fx_zone_watcher(10000,"msg_fx_zone10a_froggercrossing","msg_fx_zone10b_froggercrossing");
	thread maps\_shg_fx::fx_zone_watcher(11000,"msg_fx_zone11a_freeway_start","msg_fx_zone11b_freeway_start");
	thread maps\_shg_fx::fx_zone_watcher(12000,"msg_fx_zone12_tunnel");
	thread maps\_shg_fx::fx_zone_watcher(13000,"msg_fx_zone13a_bus_takedown","msg_fx_zone13a_bus_takedown");
	thread maps\_shg_fx::fx_zone_watcher(14000,"msg_fx_zone14a_coast","msg_fx_zone14b_coast_van_transition");
	thread maps\_shg_fx::fx_zone_watcher(15000,"msg_fx_zone15a_van_takedown","msg_fx_zone15a_van_takedown","msg_fx_zone16_finale_underwater");
	thread maps\_shg_fx::fx_zone_watcher(16000,"msg_fx_zone16_finale_underwater");
	thread dust_settle_squad_intro();
	thread pigeons_rail_react_intro();
	thread pigeons_camera_view_zone3000();
	thread pigeons_ledges_react_roundabout();
	thread pigeons_flock_takeoff();
	thread pigeons_flyoff_alley1();
	thread vista_pigeons_alley1_market();
}

//Function Number: 2
init_smvals()
{
	setsaveddvar("fx_alphathreshold",7);
}

//Function Number: 3
precachefx()
{
	level._effect["flesh_hit"] = loadfx("vfx/weaponimpact/flesh_impact_body_fatal_exit");
	level._effect["tram_dust"] = loadfx("vfx/dust/dust_falling_subtle_tram_runner");
	level._effect["tram_sparks"] = loadfx("vfx/map/lagos/lag_tram_spark_runner");
	level._effect["gun_flash_kva_intro"] = loadfx("vfx/map/lagos/lag_intro_gun_flash");
	level._effect["gun_blood_impact_kva_intro"] = loadfx("vfx/map/lagos/lag_intro_gun_blood_impact");
	level._effect["gun_blood_splash_decal_kva_intro"] = loadfx("vfx/map/lagos/lag_intro_gun_blood_splat_place");
	level._effect["gun_blood_pool_decal_kva_intro"] = loadfx("vfx/map/lagos/lag_intro_gun_blood_pool_place");
	level._effect["blood_drip_sml_runner_edge_slw"] = loadfx("vfx/blood/blood_drip_sml_runner_edge_slw");
	level._effect["flies_intro_conf"] = loadfx("vfx/map/lagos/lag_intro_flies_conf");
	level._effect["heli_dust_settle_10s"] = loadfx("vfx/dust/heli_dust_settle_10s");
	level._effect["smoke_chimney_small_dark"] = loadfx("vfx/smoke/smoke_chimney_small_dark");
	level._effect["spark_exo_door_fast_sm"] = loadfx("vfx/sparks/spark_exo_door_fast_sm");
	level._effect["door_exo_breach_impact"] = loadfx("vfx/explosion/door_exo_breach_impact");
	level._effect["exo_door_hinge_piece"] = loadfx("vfx/props/exo_door_hinge_piece");
	level._effect["exo_door_impact_kick_dust"] = loadfx("vfx/dust/exo_door_impact_kick_dust");
	level._effect["exo_r_gloves_engage_slow"] = loadfx("vfx/ui/exo_r_gloves_engage_slow");
	level._effect["exo_l_gloves_engage_slow"] = loadfx("vfx/ui/exo_l_gloves_engage_slow");
	level._effect["exo_r_gloves_disengage"] = loadfx("vfx/ui/exo_r_gloves_disengage");
	level._effect["exo_l_gloves_disengage"] = loadfx("vfx/ui/exo_l_gloves_disengage");
	level._effect["dust_mag_r_glove_impact"] = loadfx("vfx/dust/dust_mag_r_glove_impact");
	level._effect["dust_mag_l_glove_impact"] = loadfx("vfx/dust/dust_mag_l_glove_impact");
	level._effect["lab_mute_device_plant_vm"] = loadfx("vfx/map/lab/lab_mute_device_plant_vm");
	level._effect["lab_mute_area_distort_player_view"] = loadfx("vfx/map/lab/lab_mute_area_distort_player_view");
	level._effect["lab_mute_device_lights"] = loadfx("vfx/map/lab/lab_mute_device_lights");
	level._effect["mute_breach_distort_vm_enter"] = loadfx("vfx/props/mute_breach_distort_vm_enter");
	level._effect["mute_breach_distort_vm_exit"] = loadfx("vfx/props/mute_breach_distort_vm_exit");
	level._effect["roof_breach_device_laser"] = loadfx("vfx/props/roof_breach_device_laser");
	level._effect["roof_breach_device_radial_blast_charges"] = loadfx("vfx/props/roof_breach_device_radial_blast_charges");
	level._effect["roof_breach_device_laser_cut_fast"] = loadfx("vfx/props/roof_breach_device_laser_cut_fast");
	level._effect["ground_concrete_breach_explosion"] = loadfx("vfx/map/lagos/lag_roof_breach_explosion");
	level._effect["ground_concrete_breach_burst_sml"] = loadfx("vfx/explosion/ground_concrete_breach_burst_sml");
	level._effect["ground_concrete_breach_burst_med"] = loadfx("vfx/explosion/ground_concrete_breach_burst_med");
	level._effect["ground_concrete_breach_burst_lrg"] = loadfx("vfx/explosion/ground_concrete_breach_burst_lrg");
	level._effect["dust_falling_edge_thick"] = loadfx("vfx/dust/dust_falling_edge_thick");
	level._effect["dust_falling_edge_light"] = loadfx("vfx/dust/dust_falling_edge_light");
	level._effect["dust_radial_spread_ground"] = loadfx("vfx/dust/dust_radial_spread_ground");
	level._effect["dust_radial_lingering"] = loadfx("vfx/dust/dust_radial_lingering_single");
	level._effect["dust_linger_shaft_slw_lp"] = loadfx("vfx/dust/dust_linger_shaft_slw_lp");
	level._effect["dust_falling_single_ceiling_tile"] = loadfx("vfx/dust/dust_falling_single_ceiling_tile");
	level._effect["lag_harmonic_breach_strip_single"] = loadfx("vfx/map/lagos/lag_harmonic_breach_strip_single");
	level._effect["lag_harmonic_breach_strip_single_off"] = loadfx("vfx/map/lagos/lag_harmonic_breach_strip_single_off");
	level._effect["lag_harmonic_breach_strip_single_flash"] = loadfx("vfx/map/lagos/lag_harmonic_breach_strip_single_flash");
	level._effect["lag_harmonic_breach_strip_single_bar_lp"] = loadfx("vfx/map/lagos/lag_harmonic_breach_strip_single_bar_lp");
	level._effect["lag_harmonic_breach_on_flash"] = loadfx("vfx/map/lagos/lag_harmonic_breach_on_flash");
	level._effect["lag_harmonic_breach_on_lp"] = loadfx("vfx/map/lagos/lag_harmonic_breach_on_lp");
	level._effect["lag_harmonic_breach_bullet_decal_1"] = loadfx("vfx/map/lagos/lag_hbreach_wood_decal_spawner");
	level._effect["lag_harmonic_breach_bullet_decal_2"] = loadfx("vfx/map/lagos/lag_hbreach_wood_decal_spawner");
	level._effect["lag_harmonic_breach_bullet_decal_3"] = loadfx("vfx/map/lagos/lag_hbreach_wood_decal_spawner");
	level._effect["lag_harmonic_breach_bullet_decal_4"] = loadfx("vfx/map/lagos/lag_hbreach_wood_decal_spawner");
	level._effect["lag_pm_handcuff_break"] = loadfx("vfx/map/lagos/lag_pm_handcuff_break");
	level._effect["roundabout_tanker_explosion_1"] = loadfx("vfx/map/lagos/lag_roundabout_tanker_explosion");
	level._effect["lag_roundabout_tanker_fireball_shockwave"] = loadfx("vfx/map/lagos/lag_roundabout_tanker_fireball_shockwave");
	level._effect["roundabout_tanker_explosion_smoke_fade_lp"] = loadfx("vfx/map/lagos/lag_roundabout_tanker_smk_fade_lp");
	level._effect["smk_low_linger_lp"] = loadfx("vfx/map/lagos/lag_smk_low_linger_lp");
	level._effect["molten_drip_med"] = loadfx("vfx/map/lagos/lag_fire_molten_drip_directional_med");
	level._effect["balcony_fire_lg"] = loadfx("vfx/map/lagos/lag_fire_balcony_lrg");
	level._effect["oil_spill_fire_lp_low"] = loadfx("vfx/map/sanfran_a/sfa_oil_spill_fire_lp_low");
	level._effect["oil_spill_fire_lp_tall"] = loadfx("vfx/map/lagos/lag_roundabout_fire_mid_lp");
	level._effect["fire_embers_mid_lp"] = loadfx("vfx/map/lagos/lag_roundabout_fire_embers_mid_lp");
	level._effect["fire_crawl_wall_lrg"] = loadfx("vfx/fire/fire_crawl_wall_lrg");
	level._effect["falling_burning_debris"] = loadfx("vfx/map/lagos/lag_fall_burning_debris_single");
	level._effect["dust_foot_slide"] = loadfx("vfx/dust/dust_slide_lp");
	level._effect["veh_dust_wheel_skid"] = loadfx("vfx/dust/veh_dust_wheel_skid");
	level._effect["tread_dirt_thick"] = loadfx("vfx/treadfx/tread_dirt_thick");
	level._effect["tread_dust_sedan_bright"] = loadfx("vfx/treadfx/tread_dust_sedan_bright");
	level._effect["veh_trail_dust"] = loadfx("vfx/trail/veh_dust_trail");
	level._effect["lag_gate_controlbox_broken"] = loadfx("vfx/map/lagos/lag_gate_controlbox_broken");
	level._effect["guy_jump_landing_impact"] = loadfx("vfx/smoke/guy_jump_landing_impact");
	level._effect["lag_gate_dust_falling"] = loadfx("vfx/map/lagos/lag_gate_dust_falling");
	level._effect["technical_muzzle_flash"] = loadfx("vfx/muzzleflash/50cal_flash_wv");
	level._effect["blood_impact_burst"] = loadfx("vfx/blood/blood_impact_burst");
	level._effect["lag_mtkdown_kva_truck_side_swipe"] = loadfx("vfx/map/lagos/lag_mtkdown_kva_truck_side_swipe");
	level._effect["lag_mtkdown_bus_impact"] = loadfx("vfx/map/lagos/lag_mtkdown_bus_impact");
	level._effect["lag_mtkdown_kva_truck_windshield_smash"] = loadfx("vfx/map/lagos/lag_mtkdown_kva_truck_windshield_smash");
	level._effect["lag_mtkdown_kva_truck_windshield_smash_smoke"] = loadfx("vfx/map/lagos/lag_mtkdown_kva_truck_windshield_smash_smoke");
	level._effect["lag_mtkdown_kva_truck_flip_collision"] = loadfx("vfx/map/lagos/lag_mtkdown_kva_truck_flip_collision");
	level._effect["lag_tkdown_concrete_piece_spurt_single_med"] = loadfx("vfx/map/lagos/lag_tkdown_concrete_piece_spurt_single_med");
	level._effect["lag_tkdown_kva_pickup_impact_concrete"] = loadfx("vfx/map/lagos/lag_tkdown_kva_pickup_impact_concrete");
	level._effect["lag_tkdown_kva_pickup_crash"] = loadfx("vfx/map/lagos/lag_tkdown_kva_pickup_crash");
	level._effect["lag_fence_dust_falling"] = loadfx("vfx/map/lagos/lag_fence_dust_falling");
	level._effect["dust_tread_fx"] = loadfx("vfx/treadfx/tread_dust_kva_truck");
	level._effect["single_wheel_brake_skid_asphalt"] = loadfx("vfx/treadfx/single_wheel_brake_skid_asphalt");
	level._effect["veh_collision_asphalt"] = loadfx("vfx/vehiclecollision/veh_collision_asphalt");
	level._effect["veh_collision_concrete"] = loadfx("vfx/vehiclecollision/veh_collision_concrete");
	level._effect["veh_collision_concrete_sml"] = loadfx("vfx/vehiclecollision/veh_collision_concrete_sml");
	level._effect["lag_tkdown_truck_blood_impact"] = loadfx("vfx/map/lagos/lag_tkdown_truck_blood_impact");
	level._effect["lag_tkdown_truck_rvmirror_snap"] = loadfx("vfx/map/lagos/lag_tkdown_truck_rvmirror_snap");
	level._effect["lag_truck_headon_impact"] = loadfx("vfx/map/lagos/lag_truck_headon_impact");
	level._effect["lag_tkdown_concrete_piece_spurt_single"] = loadfx("vfx/map/lagos/lag_tkdown_concrete_piece_spurt_single");
	level._effect["lag_tkdown_truck_bubble_trail"] = loadfx("vfx/map/lagos/lag_tkdown_truck_bubble_trail");
	level._effect["lag_tkdown_truck_bubble_trail_lrg"] = loadfx("vfx/map/lagos/lag_tkdown_truck_bubble_trail_lrg");
	level._effect["lag_tkdown_truck_latch_door_open"] = loadfx("vfx/map/lagos/lag_tkdown_truck_latch_door_open");
	level._effect["lag_tkdown_truck_latch_door_edge_lp"] = loadfx("vfx/map/lagos/lag_tkdown_truck_latch_door_edge_lp");
	level._effect["lag_tkdown_truck_underwater_splash"] = loadfx("vfx/map/lagos/lag_tkdown_truck_underwater_splash");
	level._effect["sparks_skid_asphalt_sml"] = loadfx("vfx/sparks/sparks_skid_asphalt_sml");
	level._effect["water_impact_lrg"] = loadfx("vfx/water/water_truck_impact_splash_lrg");
	level._effect["underwater_splash_foam"] = loadfx("vfx/water/underwater_splash_foam");
	level._effect["debris_falling_splashes_area"] = loadfx("vfx/water/debris_falling_splashes_area");
	level._effect["underwater_particulates_glitter"] = loadfx("vfx/water/underwater_particulates_glitter");
	level._effect["underwater_bubble_vm_transition_lp"] = loadfx("vfx/water/underwater_bubble_vm_transition_lp");
	level._effect["underwater_bubble_vm_transition_single"] = loadfx("vfx/water/underwater_bubble_vm_transition_single");
	level._effect["underwater_bubble_vm_gasping_breath"] = loadfx("vfx/water/underwater_bubble_vm_gasping_breath");
	level._effect["underwater_bubble_vm_death_blackout"] = loadfx("vfx/water/underwater_bubble_vm_death_blackout");
	level._effect["bubble_geotrail_thick_med"] = loadfx("vfx/water/bubble_geotrail_thick_med");
	level._effect["bubble_geotrail_thick_vm_child"] = loadfx("vfx/water/bubble_geotrail_thick_vm_child");
	level._effect["bubble_trail_runner_lp"] = loadfx("vfx/water/bubble_trail_runner_lp");
	level._effect["bubble_trail_runner_sml_lp"] = loadfx("vfx/water/bubble_trail_runner_sml_lp");
	level._effect["bubble_geotrail_thick_xsml"] = loadfx("vfx/water/bubble_geotrail_thick_xsml");
	level._effect["underwater_sinking_debris_runner"] = loadfx("vfx/water/underwater_sinking_debris_runner");
	level._effect["underwater_sinking_debris_single_03"] = loadfx("vfx/water/underwater_sinking_debris_single_03");
	level._effect["bubble_long_trail_slw_med"] = loadfx("vfx/water/bubble_long_trail_slw_med");
	level._effect["lag_underwater_murk_xlg_nofog"] = loadfx("vfx/map/lagos/lag_underwater_murk_xlrg_nofog");
	level._effect["lag_underwater_bubble_ring_lp"] = loadfx("vfx/map/lagos/lag_underwater_bubble_ring_lp");
	level._effect["lag_tkdown_truck_barrier_break"] = loadfx("vfx/map/lagos/lag_tkdown_truck_barrier_break");
	level._effect["screen_splash_distort"] = loadfx("vfx/distortion/screen_splash_distort_fast");
	level._effect["water_barrel_barriers_splash"] = loadfx("vfx/water/water_barrel_barriers_splash");
	level._effect["fish_school_side_large"] = loadfx("vfx/animal/fish_school_side_large");
	level._effect["fish_school_top_base"] = loadfx("vfx/animal/fish_school_top_base");
	level._effect["screen_wash_distort"] = loadfx("vfx/distortion/screen_splash_distort_wash");
	level._effect["shore_water_soaked_drip_runner"] = loadfx("vfx/map/lagos/lag_shore_water_soaked_drip_runner");
	level._effect["shore_water_soaked_drip_runner2"] = loadfx("vfx/map/lagos/lag_shore_water_soaked_drip_runner2");
	level._effect["shore_water_soaked_drip_runner2a"] = loadfx("vfx/map/lagos/lag_shore_water_soaked_drip_runner2a");
	level._effect["shore_water_soaked_drip_runner3"] = loadfx("vfx/map/lagos/lag_shore_water_soaked_drip_runner3");
	level._effect["animal_seagulls_flock_large_flying"] = loadfx("vfx/animal/bird_seagull_flock_flying_runner");
	level._effect["ambient_fog_coast"] = loadfx("vfx/map/lagos/lag_ambient_fog_coast");
	level._effect["shore_slap_splash"] = loadfx("vfx/map/lagos/lag_shore_slap_splash");
	level._effect["fire_lp_xs_base"] = loadfx("vfx/fire/fire_lp_xs_base");
	level._effect["blood_pool_spawner_small_fast"] = loadfx("vfx/blood/blood_pool_spawner_small_fast");
	level._effect["paper_burst"] = loadfx("vfx/props/paper_burst");
	level._effect["dust_car_stop"] = loadfx("vfx/map/lagos/dust_car_stop");
	level._effect["heat_distortion_l"] = loadfx("vfx/distortion/heat_distortion_l");
	level._effect["heat_distortion_mirage_med"] = loadfx("vfx/distortion/heat_distortion_mirage_med");
	level._effect["amb_dust_indoor_slw_lp"] = loadfx("vfx/dust/amb_dust_indoor_slw_lp");
	level._effect["amb_dust_indoor_slw_light_lp"] = loadfx("vfx/dust/amb_dust_indoor_slw_light_lp");
	level._effect["low_dust_ambient_lp"] = loadfx("vfx/dust/low_dust_ambient_lp");
	level._effect["smoke_blowing_fast_constant"] = loadfx("vfx/smoke/smoke_blowing_fast_constant");
	level._effect["low_dust_ambient_slw_lp"] = loadfx("vfx/dust/low_dust_ambient_slw_lp");
	level._effect["dust_blowing_fast"] = loadfx("vfx/dust/dust_blowing_fast");
	level._effect["smog_smoke_l"] = loadfx("vfx/dust/amb_dust_verylight");
	level._effect["leaves_small_fall_gentlewind"] = loadfx("vfx/wind/leaves_small_fall_gentlewind");
	level._effect["leaves_small_fall_nowind_light"] = loadfx("vfx/wind/leaves_small_fall_nowind_light");
	level._effect["leaves_falling_constant"] = loadfx("vfx/wind/leaves_falling_constant");
	level._effect["ambient_falling_leaves_far_lp"] = loadfx("vfx/wind/ambient_falling_leaves_far_lp");
	level._effect["ambient_rolling_ground_leaves_fast_runner"] = loadfx("vfx/wind/ambient_rolling_ground_leaves_fast_runner");
	level._effect["trash_wind_vf"] = loadfx("vfx/wind/trash_wind_vf");
	level._effect["paper_windblown_slw_constant"] = loadfx("vfx/wind/paper_windblown_slw_constant");
	level._effect["leaves_windblown_slw_constant"] = loadfx("vfx/wind/leaves_windblown_slw_constant");
	level._effect["wind_blowing_leaves_constant"] = loadfx("vfx/wind/wind_blowing_leaves_constant");
	level._effect["paper_scrap_windblown_runner_light_slw"] = loadfx("vfx/wind/paper_scrap_windblown_runner_light_slw");
	level._effect["low_dust_wave"] = loadfx("vfx/map/lagos/lag_low_dust_wave_runner");
	level._effect["insects_flies_landing"] = loadfx("vfx/animal/insects_flies_landing");
	level._effect["pigeon_flock_vista_runner"] = loadfx("vfx/animal/pigeon_flock_vista_runner");
	level._effect["pigeon_flap_rt_lp"] = loadfx("vfx/animal/pigeon_flap_rt_lp");
	level._effect["pigeon_peck_rt_lp"] = loadfx("vfx/animal/pigeon_peck_rt_lp");
	level._effect["pigeon_fly_off_pos_y_low_runner"] = loadfx("vfx/animal/pigeon_fly_off_pos_y_low_runner");
	level._effect["pigeon_fly_off_pos_y_runner"] = loadfx("vfx/animal/pigeon_fly_off_pos_y_runner");
	level._effect["pigeon_fly_off_neg_y_runner"] = loadfx("vfx/animal/pigeon_fly_off_neg_y_runner");
	level._effect["pigeon_flock_runner"] = loadfx("vfx/animal/pigeon_flock_runner");
	level._effect["pigeon_flock_runner_lp"] = loadfx("vfx/animal/pigeon_flock_runner_lp");
	level._effect["pigeon_flock_runner_lrg"] = loadfx("vfx/animal/pigeon_flock_runner_lrg");
	level._effect["pigeon_rand_idle_single"] = loadfx("vfx/animal/pigeon_rand_idle_single");
	level._effect["roach_flock_straight_lp_slw"] = loadfx("vfx/animal/roach_flock_straight_lp_slw");
	level._effect["smoke_chimney_small"] = loadfx("vfx/smoke/smoke_chimney_small");
	level._effect["steam_column_lp"] = loadfx("vfx/steam/steam_column_lp");
	level._effect["steam_column_white_sm"] = loadfx("vfx/steam/steam_column_white_sm");
	level._effect["steam_column_rising_far"] = loadfx("vfx/steam/steam_column_rising_far");
	level._effect["dust_particles_sml"] = loadfx("vfx/dust/dust_particles_sml");
	level._effect["trash_tornado_s"] = loadfx("vfx/wind/trash_tornado_s");
	level._effect["leaves_tornado_s"] = loadfx("vfx/wind/leaves_tornado_s");
	level._effect["wind_blowing_trash_constant"] = loadfx("vfx/wind/wind_blowing_trash_constant");
	level._effect["trash_tornado_s_runner"] = loadfx("vfx/wind/trash_tornado_s_runner");
	level._effect["leaves_tornado_s_runner"] = loadfx("vfx/wind/leaves_tornado_s_runner");
	level._effect["dust_blowing_ground_fast_constant"] = loadfx("vfx/dust/dust_blowing_ground_fast_constant");
	level._effect["lag_sun_flare"] = loadfx("vfx/map/lagos/lag_sun_flare");
	level._effect["lag_underwater_sun_flare"] = loadfx("vfx/map/lagos/lag_underwater_sun_flare");
	level._effect["light_godray_hazy_highway_side"] = loadfx("vfx/lights/light_godray_hazy_highway_side");
	level._effect["light_godray_hazy_highway_angled_side_long"] = loadfx("vfx/lights/light_godray_hazy_highway_angled_side_long");
	level._effect["light_godray_hazy_highway_angled_overpass_tall"] = loadfx("vfx/lights/light_godray_hazy_highway_angled_op_tall");
	level._effect["light_ramp_godray_hazy_1_angled"] = loadfx("vfx/lights/lagos/light_ramp_godray_hazy_1_angled");
	level._effect["light_godray_hazy_floor"] = loadfx("vfx/lights/lagos/light_godray_hazy_floor");
	level._effect["light_godray_hazy_indoor_nodust"] = loadfx("vfx/lights/lagos/light_godray_hazy_indoor_nodust");
	level._effect["light_godray_lobby"] = loadfx("vfx/map/lagos/lag_lobby_godray_window");
	level._effect["light_ramp_godray_intro"] = loadfx("vfx/lights/lagos/light_ramp_godray_intro");
	level._effect["light_blue_fill_hostage"] = loadfx("vfx/lights/lagos/light_blue_fill_hostage");
	level._effect["light_blue_fill_shoreline"] = loadfx("vfx/lights/lagos/light_blue_fill_shoreline");
	level._effect["light_warm_fill_shoreline"] = loadfx("vfx/lights/lagos/light_warm_fill_shoreline");
	level._effect["light_fill_exo"] = loadfx("vfx/lights/lagos/light_fill_exo");
	level._effect["light_blue_monitor"] = loadfx("vfx/lights/lagos/light_blue_monitor");
	level._effect["light_blue_monitor_hostage"] = loadfx("vfx/lights/lagos/light_blue_monitor_hostage");
	level._effect["light_blue_monitor_large"] = loadfx("vfx/lights/lagos/light_blue_monitor_large");
	level._effect["light_underwater_godray_beam_blurry_lrg"] = loadfx("vfx/lights/lagos/light_underwater_godray_beam_blurry_lrg");
	level._effect["light_underwater_godray_beam_moving_med"] = loadfx("vfx/lights/lagos/light_underwater_godray_beam_moving_med");
	level._effect["gold_building_flare"] = loadfx("vfx/lensflare/lagos/gold_building_flare");
	level._effect["hostage_room_flare"] = loadfx("vfx/lensflare/lagos/hostage_room_flare");
	level._effect["tunnel_light_flare"] = loadfx("vfx/lensflare/lagos/tunnel_light_flare");
}

//Function Number: 4
set_lighting_values()
{
	if(isusinghdr())
	{
		setsaveddvar("r_tonemap",2);
	}
}

//Function Number: 5
drone_intro_execution_gun_flash(param_00)
{
	playfxontag(common_scripts\utility::getfx("gun_flash_kva_intro"),param_00,"TAG_WEAPON_RIGHT");
	common_scripts\_exploder::exploder(10);
}

//Function Number: 6
dust_settle_squad_intro()
{
	level waittill("tram_start");
	common_scripts\_exploder::exploder("heli_dust_settle");
	common_scripts\_exploder::exploder("heli_dust_low");
	wait(6);
	common_scripts\_exploder::exploder("ambient_dust_lp");
	wait(10);
	maps\_utility::pauseexploder("heli_dust_low");
	wait(15);
	common_scripts\_exploder::kill_exploder("heli_dust_settle");
	common_scripts\_exploder::kill_exploder("heli_dust_low");
	common_scripts\utility::flag_wait("msg_fx_zone3_train_rooftop_entry");
	maps\_utility::pauseexploder("ambient_dust_lp");
}

//Function Number: 7
pigeons_rail_react_intro()
{
	level waittill("tram_start");
	maps\_shg_fx::setupledgefx("fx_zone1");
	level waittill("intro_walkway_go");
	maps\_shg_fx::swapfx("vfx_pigeon_intro","pigeon_fly_off_neg_y_runner",(0,0,0),0.1);
	wait(4);
	maps\_shg_fx::swapfx("vfx_pigeon_intro_crossway","pigeon_fly_off_neg_y_runner",(0,0,0),0.25);
}

//Function Number: 8
exo_door_kick(param_00)
{
	wait(0.25);
	playfxontag(common_scripts\utility::getfx("exo_door_impact_kick_dust"),param_00,"smash_pusher");
	wait(0.05);
	playfxontag(common_scripts\utility::getfx("exo_door_hinge_piece"),param_00,"smash_R");
	wait(10);
	stopfxontag(common_scripts\utility::getfx("exo_door_hinge_piece"),param_00,"smash_R");
	stopfxontag(common_scripts\utility::getfx("exo_door_impact_kick_dust"),param_00,"smash_pusher");
}

//Function Number: 9
exo_door_break(param_00)
{
	playfxontag(common_scripts\utility::getfx("door_exo_breach_impact"),param_00,"smash_pusher");
	wait(10);
	stopfxontag(common_scripts\utility::getfx("door_exo_breach_impact"),param_00,"smash_pusher");
}

//Function Number: 10
pigeons_camera_view_zone3000()
{
	common_scripts\utility::flag_wait("msg_fx_zone2_train_station");
	var_00 = [(-51893.4,12335.6,1143.03),(-53287.2,11359.1,1244.34),(-52160.6,11411.6,1783.72),(-49482.6,9896.68,1342.71),(-50370,10799,1225),(-53668.5,9382.25,1245.96),(-54590.9,11026.9,1121.91),(-48566.8,8800.03,734.885),(-50364.1,12368.1,1106.27)];
	var_01 = [(270,172.875,96.1244),(270,180,39.9991),(270,180,43.9992),(270,0,133.999),(270,0,160),(270,188.531,57.4673),(270,0,-154.002),(270,0,151.999),(270,3.57633,111.422)];
	thread maps\_shg_fx::start_fx_by_view("pigeon_flock_vista_runner",var_00,3,3,"msg_fx_zone4_government_building",0,var_01);
}

//Function Number: 11
player_mag_glove_activate_wallclimb(param_00)
{
	playfxontag(common_scripts\utility::getfx("exo_r_gloves_disengage"),param_00,"J_Wrist_RI");
	playfxontag(common_scripts\utility::getfx("exo_l_gloves_disengage"),param_00,"J_Wrist_LE");
}

//Function Number: 12
player_mag_glove_off(param_00)
{
	param_00 endon("death");
	killfxontag(common_scripts\utility::getfx("exo_r_gloves_engage_slow"),param_00,"J_Wrist_RI");
	killfxontag(common_scripts\utility::getfx("exo_l_gloves_engage_slow"),param_00,"J_Wrist_LE");
	wait 0.05;
	killfxontag(common_scripts\utility::getfx("exo_r_gloves_disengage"),param_00,"J_Wrist_RI");
	killfxontag(common_scripts\utility::getfx("exo_l_gloves_disengage"),param_00,"J_Wrist_LE");
	wait 0.05;
	killfxontag(common_scripts\utility::getfx("exo_r_gloves_engage"),param_00,"J_Wrist_RI");
	killfxontag(common_scripts\utility::getfx("exo_l_gloves_engage"),param_00,"J_Wrist_LE");
}

//Function Number: 13
player_hand_plant_lf_wallclimb(param_00)
{
	killfxontag(common_scripts\utility::getfx("exo_l_gloves_disengage"),param_00,"J_Wrist_LE");
	playfxontag(common_scripts\utility::getfx("exo_l_gloves_engage_slow"),param_00,"J_Wrist_LE");
	playfxontag(common_scripts\utility::getfx("dust_mag_l_glove_impact"),param_00,"J_Mid_LE_0");
}

//Function Number: 14
player_mag_glove_lglove_disengage(param_00)
{
	killfxontag(common_scripts\utility::getfx("exo_l_gloves_engage_slow"),param_00,"J_Wrist_LE");
	killfxontag(common_scripts\utility::getfx("exo_l_gloves_engage"),param_00,"J_Wrist_LE");
	playfxontag(common_scripts\utility::getfx("exo_l_gloves_disengage"),param_00,"J_Wrist_LE");
}

//Function Number: 15
player_hand_plant_rt_wallclimb(param_00)
{
	killfxontag(common_scripts\utility::getfx("exo_r_gloves_disengage"),param_00,"J_Wrist_RI");
	playfxontag(common_scripts\utility::getfx("exo_r_gloves_engage_slow"),param_00,"J_Wrist_RI");
	playfxontag(common_scripts\utility::getfx("dust_mag_r_glove_impact"),param_00,"J_Mid_RI_0");
}

//Function Number: 16
player_mag_glove_rglove_disengage(param_00)
{
	killfxontag(common_scripts\utility::getfx("exo_r_gloves_engage_slow"),param_00,"J_Wrist_RI");
	killfxontag(common_scripts\utility::getfx("exo_r_gloves_engage"),param_00,"J_Wrist_RI");
	playfxontag(common_scripts\utility::getfx("exo_r_gloves_disengage"),param_00,"J_Wrist_RI");
}

//Function Number: 17
burke_hand_plant_lf_wallclimb(param_00)
{
}

//Function Number: 18
burke_hand_plant_rt_wallclimb(param_00)
{
}

//Function Number: 19
bird_flyaway(param_00)
{
	wait(5);
	common_scripts\_exploder::exploder(3011);
}

//Function Number: 20
mute_device_plant_fx(param_00)
{
	playfxontag(common_scripts\utility::getfx("lab_mute_device_plant_vm"),param_00,"tag_vfx_attach");
	wait(0.15);
	playfxontag(common_scripts\utility::getfx("lab_mute_device_lights"),param_00,"spinner");
	wait(10);
	stopfxontag(common_scripts\utility::getfx("lab_mute_device_lights"),param_00,"spinner");
	stopfxontag(common_scripts\utility::getfx("lab_mute_device_plant_vm"),param_00,"tag_vfx_attach");
}

//Function Number: 21
roof_breach_device_plant_dust(param_00)
{
}

//Function Number: 22
roof_breach_device_area_mark(param_00)
{
	playfxontag(common_scripts\utility::getfx("roof_breach_device_laser"),param_00,"tag_fx");
	wait(0.4);
	playfxontag(common_scripts\utility::getfx("roof_breach_device_laser_cut_fast"),param_00,"tag_laser_1");
	playfxontag(common_scripts\utility::getfx("roof_breach_device_laser_cut_fast"),param_00,"tag_laser_2");
	playfxontag(common_scripts\utility::getfx("roof_breach_device_laser_cut_fast"),param_00,"tag_laser_3");
	playfxontag(common_scripts\utility::getfx("roof_breach_device_laser_cut_fast"),param_00,"tag_laser_4");
	wait(1);
	stopfxontag(common_scripts\utility::getfx("roof_breach_device_laser"),param_00,"tag_fx");
	level waittill("kill_fx_burnmarks");
	wait 0.05;
	killfxontag(common_scripts\utility::getfx("roof_breach_device_laser_cut_fast"),param_00,"tag_laser_1");
	killfxontag(common_scripts\utility::getfx("roof_breach_device_laser_cut_fast"),param_00,"tag_laser_2");
	killfxontag(common_scripts\utility::getfx("roof_breach_device_laser_cut_fast"),param_00,"tag_laser_3");
	killfxontag(common_scripts\utility::getfx("roof_breach_device_laser_cut_fast"),param_00,"tag_laser_4");
}

//Function Number: 23
roof_breach_device_plant_mini_charges(param_00)
{
	playfxontag(common_scripts\utility::getfx("roof_breach_device_radial_blast_charges"),param_00,"tag_fx");
	level notify("kill_fx_burnmarks");
	earthquake(0.5,0.5,level.player.origin,100);
}

//Function Number: 24
roof_breach_device_radial_sml_explosions(param_00)
{
}

//Function Number: 25
roof_breach_chunks_bursts(param_00)
{
	wait(0.2);
	playfxontag(common_scripts\utility::getfx("ground_concrete_breach_burst_lrg"),param_00,"jo_lag_govt_roof_chunk_02");
	playfxontag(common_scripts\utility::getfx("ground_concrete_breach_burst_lrg"),param_00,"jo_lag_govt_roof_chunk_03");
	playfxontag(common_scripts\utility::getfx("ground_concrete_breach_burst_lrg"),param_00,"jo_lag_govt_roof_chunk_05");
	playfxontag(common_scripts\utility::getfx("ground_concrete_breach_burst_lrg"),param_00,"jo_lag_govt_roof_chunk_06");
	wait 0.05;
	playfxontag(common_scripts\utility::getfx("ground_concrete_breach_burst_lrg"),param_00,"jo_lag_govt_roof_chunk_07");
	playfxontag(common_scripts\utility::getfx("ground_concrete_breach_burst_lrg"),param_00,"jo_lag_govt_roof_chunk_08");
	playfxontag(common_scripts\utility::getfx("ground_concrete_breach_burst_lrg"),param_00,"jo_lag_govt_roof_chunk_13");
	wait(0.1);
	playfxontag(common_scripts\utility::getfx("ground_concrete_breach_burst_med"),param_00,"jo_lag_govt_roof_chunk_12");
	playfxontag(common_scripts\utility::getfx("ground_concrete_breach_burst_med"),param_00,"jo_lag_govt_roof_chunk_15");
	playfxontag(common_scripts\utility::getfx("ground_concrete_breach_burst_med"),param_00,"jo_lag_govt_roof_chunk_16");
	playfxontag(common_scripts\utility::getfx("ground_concrete_breach_burst_med"),param_00,"jo_lag_govt_roof_chunk_18");
	wait 0.05;
	playfxontag(common_scripts\utility::getfx("ground_concrete_breach_burst_med"),param_00,"jo_lag_govt_roof_chunk_21");
	playfxontag(common_scripts\utility::getfx("ground_concrete_breach_burst_med"),param_00,"jo_lag_govt_roof_chunk_24");
	playfxontag(common_scripts\utility::getfx("ground_concrete_breach_burst_med"),param_00,"jo_lag_govt_roof_chunk_25");
	wait 0.05;
	playfxontag(common_scripts\utility::getfx("ground_concrete_breach_burst_sml"),param_00,"jo_lag_govt_roof_chunk_09");
	playfxontag(common_scripts\utility::getfx("ground_concrete_breach_burst_sml"),param_00,"jo_lag_govt_roof_chunk_10");
	playfxontag(common_scripts\utility::getfx("ground_concrete_breach_burst_sml"),param_00,"jo_lag_govt_roof_chunk_17");
	playfxontag(common_scripts\utility::getfx("ground_concrete_breach_burst_sml"),param_00,"jo_lag_govt_roof_chunk_20");
	wait 0.05;
	playfxontag(common_scripts\utility::getfx("ground_concrete_breach_burst_sml"),param_00,"jo_lag_govt_roof_chunk_22");
	wait(3.6);
	thread landing_dust_team();
	wait(3);
	stopfxontag(common_scripts\utility::getfx("ground_concrete_breach_burst_lrg"),param_00,"jo_lag_govt_roof_chunk_02");
	stopfxontag(common_scripts\utility::getfx("ground_concrete_breach_burst_lrg"),param_00,"jo_lag_govt_roof_chunk_03");
	stopfxontag(common_scripts\utility::getfx("ground_concrete_breach_burst_lrg"),param_00,"jo_lag_govt_roof_chunk_05");
	stopfxontag(common_scripts\utility::getfx("ground_concrete_breach_burst_lrg"),param_00,"jo_lag_govt_roof_chunk_06");
	wait 0.05;
	stopfxontag(common_scripts\utility::getfx("ground_concrete_breach_burst_lrg"),param_00,"jo_lag_govt_roof_chunk_07");
	stopfxontag(common_scripts\utility::getfx("ground_concrete_breach_burst_lrg"),param_00,"jo_lag_govt_roof_chunk_08");
	stopfxontag(common_scripts\utility::getfx("ground_concrete_breach_burst_lrg"),param_00,"jo_lag_govt_roof_chunk_13");
	stopfxontag(common_scripts\utility::getfx("ground_concrete_breach_burst_med"),param_00,"jo_lag_govt_roof_chunk_12");
	wait 0.05;
	stopfxontag(common_scripts\utility::getfx("ground_concrete_breach_burst_med"),param_00,"jo_lag_govt_roof_chunk_15");
	stopfxontag(common_scripts\utility::getfx("ground_concrete_breach_burst_med"),param_00,"jo_lag_govt_roof_chunk_16");
	stopfxontag(common_scripts\utility::getfx("ground_concrete_breach_burst_med"),param_00,"jo_lag_govt_roof_chunk_18");
	stopfxontag(common_scripts\utility::getfx("ground_concrete_breach_burst_med"),param_00,"jo_lag_govt_roof_chunk_21");
	wait 0.05;
	stopfxontag(common_scripts\utility::getfx("ground_concrete_breach_burst_med"),param_00,"jo_lag_govt_roof_chunk_24");
	stopfxontag(common_scripts\utility::getfx("ground_concrete_breach_burst_med"),param_00,"jo_lag_govt_roof_chunk_25");
	stopfxontag(common_scripts\utility::getfx("ground_concrete_breach_burst_sml"),param_00,"jo_lag_govt_roof_chunk_09");
	stopfxontag(common_scripts\utility::getfx("ground_concrete_breach_burst_sml"),param_00,"jo_lag_govt_roof_chunk_10");
	wait 0.05;
	stopfxontag(common_scripts\utility::getfx("ground_concrete_breach_burst_sml"),param_00,"jo_lag_govt_roof_chunk_17");
	stopfxontag(common_scripts\utility::getfx("ground_concrete_breach_burst_sml"),param_00,"jo_lag_govt_roof_chunk_20");
	stopfxontag(common_scripts\utility::getfx("ground_concrete_breach_burst_sml"),param_00,"jo_lag_govt_roof_chunk_22");
}

//Function Number: 26
landing_dust_team()
{
	wait(0.75);
	playfxontag(common_scripts\utility::getfx("dust_radial_spread_ground"),level.burke,"tag_origin");
	wait(0.5);
	playfxontag(common_scripts\utility::getfx("dust_radial_spread_ground"),level.ajani,"tag_origin");
}

//Function Number: 27
roof_breach_device_explosion(param_00)
{
	common_scripts\_exploder::exploder("breach_explosion");
	common_scripts\_exploder::exploder("dust_edge_thick");
	common_scripts\_exploder::exploder("dust_edge_front");
	wait(1);
	common_scripts\_exploder::exploder("dust_radial_lingering");
	common_scripts\_exploder::exploder("dust_linger_roof_hole");
	wait(2);
	common_scripts\_exploder::exploder("dust_particles");
	wait(2);
	common_scripts\_exploder::exploder("falling_ceiling_tile");
	wait(2);
	maps\_utility::pauseexploder("breach_explosion");
	maps\_utility::pauseexploder("dust_edge_thick");
	maps\_utility::pauseexploder("dust_edge_front");
	wait(8);
	maps\_utility::pauseexploder("dust_radial_lingering");
	common_scripts\_exploder::kill_exploder("breach_explosion");
	maps\_utility::pauseexploder("dust_particles");
	level waittill("BreachComplete");
	maps\_utility::pauseexploder("dust_particles");
	maps\_utility::pauseexploder("dust_linger_roof_hole");
	wait(8);
	common_scripts\_exploder::kill_exploder("dust_particles");
	common_scripts\_exploder::kill_exploder("falling_ceiling_tile");
	common_scripts\_exploder::kill_exploder("dust_linger_roof_hole");
}

//Function Number: 28
harmonic_breach_turn_on()
{
	maps\_utility::delaythread(0.1,::common_scripts\_exploder::exploder,"harmonic_intro_strips");
	maps\_utility::delaythread(1,::common_scripts\_exploder::exploder,"harmonic_breach_screen_on");
	level waittill("BreachComplete");
	wait(1);
	common_scripts\_exploder::kill_exploder("harmonic_breach_screen_on");
	common_scripts\_exploder::kill_exploder("harmonic_intro_strips");
	common_scripts\_exploder::exploder("harmonic_screen_flash");
	wait(0.25);
	common_scripts\_exploder::exploder("harmonic_screen_off");
	wait 0.05;
	common_scripts\_exploder::kill_exploder("harmonic_screen_flash");
	wait(3);
	level notify("kill_lcd_material");
	wait(6);
	common_scripts\_exploder::kill_exploder("harmonic_screen_off");
}

//Function Number: 29
harmonic_breach_flash_off()
{
	common_scripts\_exploder::exploder("harmonic_wall_flash");
}

//Function Number: 30
env_effects_hostage_room()
{
	common_scripts\_exploder::exploder("blood_decal");
	common_scripts\_exploder::exploder("room_lingering_smk");
	wait(4);
	common_scripts\_exploder::exploder("paper_burst_door_kick");
	level waittill("kill_conference_room_effects");
	common_scripts\_exploder::kill_exploder("room_lingering_smk");
	common_scripts\_exploder::kill_exploder("blood_decal");
	common_scripts\_exploder::kill_exploder("paper_burst_door_kick");
}

//Function Number: 31
handcuff_break_fx(param_00)
{
	playfxontag(common_scripts\utility::getfx("lag_pm_handcuff_break"),param_00,"tag_origin");
}

//Function Number: 32
dust_car_stop(param_00)
{
	param_00 waittill("reached_end_node");
	common_scripts\_exploder::exploder(5001);
	level notify("kill_conference_room_effects");
}

//Function Number: 33
roundabout_tanker_explosion()
{
	common_scripts\_exploder::exploder(6010);
	common_scripts\_exploder::exploder(6015);
	common_scripts\_exploder::exploder(6020);
	thread explosion_screen_flash();
	wait(1);
	common_scripts\_exploder::exploder(6021);
	wait(0.5);
	common_scripts\utility::flag_wait("kill_roundabout_flames");
	maps\_utility::pauseexploder(6010);
	maps\_utility::pauseexploder(6020);
	maps\_utility::pauseexploder(6021);
}

//Function Number: 34
explosion_screen_flash()
{
	common_scripts\utility::flag_set("roundabout_tanker_flash");
	level.player lightsetforplayer("lagos_roundabout_tanker_explosion");
	level.player setclutforplayer("clut_lagos_explosion",0.15);
	maps\_utility::vision_set_fog_changes("lagos_roundabout_tanker_explosion",0.08);
	wait(0.15);
	level.player lightsetforplayer("lagos_roundabout");
	level.player setclutforplayer("clut_lagos_roundabout",4);
	maps\_utility::vision_set_fog_changes("lagos_roundabout",0.75);
	common_scripts\utility::flag_set("tanker_explosion_done");
}

//Function Number: 35
pigeons_ledges_react_roundabout()
{
	common_scripts\utility::flag_wait("flag_roundabout_spawn_vehicles");
	maps\_shg_fx::setupledgefx("fx_zone6");
	common_scripts\utility::flag_wait("roundabout_combat_begin");
	wait(0.25);
	maps\_shg_fx::swapfx("fx_pigeon_overpass_ledge_far","pigeon_fly_off_pos_y_runner",(0,0,0),0.5);
	maps\_shg_fx::swapfx("fx_pigeon_overpass_ledge","pigeon_fly_off_pos_y_runner",(0,0,0),0.15);
	maps\_shg_fx::swapfx("fx_pigeon_building_roof_far","pigeon_fly_off_pos_y_runner",(0,0,0),0.15);
	maps\_shg_fx::swapfx("fx_pigeon_building_ledge","pigeon_fly_off_pos_y_runner",(0,0,0),0.15);
	maps\_shg_fx::swapfx("fx_pigeon_traffic_sign_ledge","pigeon_fly_off_pos_y_runner",(0,0,0),0.25);
	maps\_shg_fx::swapfx("fx_pigeon_fountain_monument","pigeon_fly_off_pos_y_low_runner",(0,0,0),0.05);
	maps\_shg_fx::swapfx("fx_pigeon_fountain_base_edge","pigeon_fly_off_pos_y_runner",(0,0,0),0.05);
}

//Function Number: 36
pigeons_flock_takeoff()
{
	common_scripts\utility::flag_wait("roundabout_combat_begin");
	common_scripts\_exploder::exploder("combat_flock_takeoff");
	wait(15);
	common_scripts\_exploder::kill_exploder("combat_flock_takeoff");
}

//Function Number: 37
pigeons_flyoff_alley1()
{
	level waittill("oncoming_go");
	maps\_shg_fx::setupledgefx("fx_zone7");
	level waittill("alley1_oncoming_fx");
	wait(1.75);
	maps\_shg_fx::swapfx("fx_pigeons_alley1_far","pigeon_fly_off_pos_y_runner",(45,0,30),0.2);
	wait(1);
	maps\_shg_fx::swapfx("fx_pigeons_alley1_close","pigeon_fly_off_pos_y_runner",(30,90,0),0.5);
}

//Function Number: 38
gate_controlbox_broken_fx(param_00)
{
	wait(0.1);
	playfxontag(common_scripts\utility::getfx("lag_gate_controlbox_broken"),param_00,"panelBox");
	wait(1.2);
	common_scripts\_exploder::exploder("gate_dust_falling");
}

//Function Number: 39
pull_fence_dust(param_00)
{
	wait(0.1);
	var_01 = common_scripts\utility::spawn_tag_origin();
	var_01 linkto(param_00,"tag_origin",(-78,0,88),(-90,0,0));
	playfxontag(common_scripts\utility::getfx("lag_fence_dust_falling"),var_01,"tag_origin");
}

//Function Number: 40
guy_jump_landing_puff(param_00)
{
	wait(0.2);
	var_01 = common_scripts\utility::spawn_tag_origin();
	var_01 linkto(param_00,"tag_origin",(0,0,9),(90,15,0));
	playfxontag(common_scripts\utility::getfx("guy_jump_landing_impact"),var_01,"tag_origin");
	wait(9);
	var_01 delete();
}

//Function Number: 41
vista_pigeons_alley1_market()
{
	common_scripts\utility::flag_wait_either("alley1_oncoming_start","msg_fx_zone8_recreationcenter");
	thread maps\_shg_fx::exploder_to_array(12);
	var_00 = [(-46713.5,3542.82,945.343),(-45592.5,3600.9,1155.3),(-47504,3855.55,895.125),(-47839.8,1572.01,849.537),(-48173,1032.6,904.365),(-46939.5,324.496,817.125),(-46313.5,-194.44,1055.14),(-47910.4,265.494,899.135),(-46925.6,1474.19,1228.12),(-46696,2669.63,959.955),(-46389.5,3813.8,869.748),(-44890.1,3729.2,712.27),(-45386.6,3484.48,657.968),(-44975.2,3505.28,902.054),(-46211.4,3678.51,748.553),(-46980.2,3722.23,853.378)];
	var_01 = [(270,0,-165),(270,0,174),(270,0,153),(270,225,25.9989),(270,180,66.999),(270,0,127.998),(270,0,154.998),(270,180,92.9972),(270,14.0362,88.9604),(270,14.0362,88.9604),(270,0,-165),(270,0,-169),(270,0,-179),(270,0,-179),(270,0,160),(270,0,175)];
	thread maps\_shg_fx::start_fx_by_view("pigeon_flock_vista_runner",var_00,4,4,"msg_fx_zone10a_froggercrossing",0,var_01);
}

//Function Number: 42
truck_dust_trail(param_00)
{
	playfxontag(common_scripts\utility::getfx("veh_trail_dust"),param_00,"tag_origin");
	wait(12);
	stopfxontag(common_scripts\utility::getfx("veh_trail_dust"),param_00,"tag_origin");
}

//Function Number: 43
truck_treadfx_wheels(param_00)
{
	playfxontag(common_scripts\utility::getfx("tread_dirt_thick"),param_00,"tag_wheel_front_left");
	playfxontag(common_scripts\utility::getfx("tread_dirt_thick"),param_00,"tag_wheel_front_right");
	level waittill("stop_nonvisible_treads");
	stopfxontag(common_scripts\utility::getfx("tread_dirt_thick"),param_00,"tag_wheel_front_left");
	stopfxontag(common_scripts\utility::getfx("tread_dirt_thick"),param_00,"tag_wheel_front_right");
}

//Function Number: 44
truck_treadfx_skid(param_00)
{
	var_01 = common_scripts\utility::spawn_tag_origin();
	var_02 = common_scripts\utility::spawn_tag_origin();
	playfxontag(common_scripts\utility::getfx("veh_dust_wheel_skid"),var_01,"tag_origin");
	var_01 linkto(param_00,"tag_wheel_front_left",(0,-8,3),(0,45,0));
	playfxontag(common_scripts\utility::getfx("veh_dust_wheel_skid"),var_02,"tag_origin");
	var_02 linkto(param_00,"tag_wheel_back_left",(10,-8,3),(0,45,0));
	wait(3.25);
	stopfxontag(common_scripts\utility::getfx("veh_dust_wheel_skid"),var_01,"tag_origin");
	stopfxontag(common_scripts\utility::getfx("veh_dust_wheel_skid"),var_02,"tag_origin");
	var_01 delete();
	var_02 delete();
}

//Function Number: 45
truck_treadfx_turn(param_00)
{
	level notify("stop_nonvisible_treads");
	wait 0.05;
	playfxontag(common_scripts\utility::getfx("tread_dirt_thick"),param_00,"tag_wheel_front_left");
	playfxontag(common_scripts\utility::getfx("tread_dirt_thick"),param_00,"tag_wheel_front_right");
	wait(3);
	playfxontag(common_scripts\utility::getfx("tread_dirt_thick"),param_00,"tag_wheel_back_right");
	stopfxontag(common_scripts\utility::getfx("tread_dirt_thick"),param_00,"tag_wheel_front_left");
	wait(4);
	stopfxontag(common_scripts\utility::getfx("tread_dirt_thick"),param_00,"tag_wheel_front_right");
	stopfxontag(common_scripts\utility::getfx("tread_dirt_thick"),param_00,"tag_wheel_back_right");
}

//Function Number: 46
gideon_slide_dust(param_00)
{
	playfxontag(common_scripts\utility::getfx("dust_foot_slide"),param_00,"tag_origin");
	wait(0.75);
	stopfxontag(common_scripts\utility::getfx("dust_foot_slide"),param_00,"tag_origin");
}

//Function Number: 47
middle_takedown_tread_fx()
{
	wait(2.5);
	playfxontag(common_scripts\utility::getfx("dust_tread_fx"),level.kva_truck,"TAG_WHEEL_BACK_RIGHT");
	playfxontag(common_scripts\utility::getfx("dust_tread_fx"),level.kva_truck,"TAG_WHEEL_BACK_LEFT");
	playfxontag(common_scripts\utility::getfx("dust_tread_fx"),level.player_bus,"TAG_WHEEL_BACK_LEFT");
	playfxontag(common_scripts\utility::getfx("dust_tread_fx"),level.player_bus,"TAG_WHEEL_FRONT_LEFT");
	level waittill("stop_middle_tkdown_tread_fx");
	stopfxontag(common_scripts\utility::getfx("dust_tread_fx"),level.kva_truck,"TAG_WHEEL_BACK_RIGHT");
	stopfxontag(common_scripts\utility::getfx("dust_tread_fx"),level.kva_truck,"TAG_WHEEL_BACK_LEFT");
	stopfxontag(common_scripts\utility::getfx("dust_tread_fx"),level.player_bus,"TAG_WHEEL_BACK_LEFT");
	stopfxontag(common_scripts\utility::getfx("dust_tread_fx"),level.player_bus,"TAG_WHEEL_FRONT_LEFT");
}

//Function Number: 48
kva_pickup_wheel_skid_ram(param_00)
{
	playfxontag(common_scripts\utility::getfx("single_wheel_brake_skid_asphalt"),param_00,"TAG_WHEEL_BACK_RIGHT");
	playfxontag(common_scripts\utility::getfx("single_wheel_brake_skid_asphalt"),param_00,"TAG_WHEEL_FRONT_right");
	wait(1.75);
	stopfxontag(common_scripts\utility::getfx("single_wheel_brake_skid_asphalt"),param_00,"TAG_WHEEL_BACK_RIGHT");
	stopfxontag(common_scripts\utility::getfx("single_wheel_brake_skid_asphalt"),param_00,"TAG_WHEEL_FRONT_RIGHT");
}

//Function Number: 49
kva_pickup_hit_bus(param_00)
{
	playfxontag(common_scripts\utility::getfx("lag_mtkdown_kva_truck_side_swipe"),param_00,"TAG_door_right_front");
	thread bus_kva_impact_sparks();
	wait(5);
	stopfxontag(common_scripts\utility::getfx("lag_mtkdown_kva_truck_side_swipe"),param_00,"TAG_door_right_front");
}

//Function Number: 50
bus_kva_impact_sparks()
{
	var_00 = common_scripts\utility::spawn_tag_origin();
	playfxontag(common_scripts\utility::getfx("lag_mtkdown_bus_impact"),var_00,"tag_origin");
	var_00 linkto(level.player_bus,"tag_origin",(55,58,40),(0,90,0));
	wait(5);
	stopfxontag(common_scripts\utility::getfx("lag_mtkdown_bus_impact"),var_00,"tag_origin");
	wait 0.05;
	var_00 delete();
}

//Function Number: 51
player_land_on_hood(param_00)
{
	playfxontag(common_scripts\utility::getfx("lag_mtkdown_kva_truck_windshield_smash_smoke"),param_00,"TAG_HOOD");
	wait(2.5);
	stopfxontag(common_scripts\utility::getfx("lag_mtkdown_kva_truck_windshield_smash_smoke"),param_00,"TAG_HOOD");
}

//Function Number: 52
kva_pickup_hit_windshield(param_00)
{
	playfxontag(common_scripts\utility::getfx("lag_mtkdown_kva_truck_windshield_smash"),param_00,"windowArmor_FL");
	wait(2.5);
	playfxontag(common_scripts\utility::getfx("lag_mtkdown_kva_truck_windshield_smash_smoke"),param_00,"tag_hood");
}

//Function Number: 53
kva_death_impact_post(param_00)
{
	common_scripts\_exploder::exploder("blood_impact_post");
	wait(3);
	maps\_utility::stop_exploder("blood_impact_post");
}

//Function Number: 54
kva_pickup_hit_divider_01(param_00)
{
	common_scripts\_exploder::exploder("divider_hit_01");
	wait(1.5);
	common_scripts\_exploder::exploder("divider_hit_02");
}

//Function Number: 55
kva_pickup_hit_divider_03(param_00)
{
	wait(0.8);
	playfxontag(common_scripts\utility::getfx("lag_mtkdown_kva_truck_flip_collision"),param_00,"tag_origin");
	common_scripts\_exploder::exploder("divider_hit_03");
	level notify("stop_middle_tkdown_tread_fx");
	wait(6);
	maps\_utility::stop_exploder("divider_hit_03");
}

//Function Number: 56
kva_pickup_flip_and_skid(param_00)
{
	wait(0.9);
	common_scripts\_exploder::exploder("pickup_asphalt_impact");
	wait(6);
	maps\_utility::stop_exploder("pickup_asphalt_impact");
}

//Function Number: 57
fake_tread_fx_hostage_truck(param_00)
{
	playfxontag(common_scripts\utility::getfx("dust_tread_fx"),param_00,"tag_wheel_front_right");
	playfxontag(common_scripts\utility::getfx("dust_tread_fx"),param_00,"tag_wheel_back_right");
	level waittill("kill_hostage_truck_tread_fx");
	stopfxontag(common_scripts\utility::getfx("dust_tread_fx"),param_00,"tag_wheel_front_right");
	stopfxontag(common_scripts\utility::getfx("dust_tread_fx"),param_00,"tag_wheel_back_right");
}

//Function Number: 58
truck_rearview_mirror_snap(param_00)
{
	playfxontag(common_scripts\utility::getfx("lag_tkdown_truck_rvmirror_snap"),param_00,"tag_mirror_right");
}

//Function Number: 59
vm_hand_sparks(param_00)
{
	playfxontag(common_scripts\utility::getfx("sparks_skid_asphalt_sml"),param_00,"J_Wrist_LE");
	wait(0.65);
	playfxontag(common_scripts\utility::getfx("sparks_skid_asphalt_sml"),param_00,"J_Wrist_LE");
}

//Function Number: 60
truck_headon_collision(param_00)
{
	wait(0.25);
	playfxontag(common_scripts\utility::getfx("lag_truck_headon_impact"),param_00,"tag_origin");
	wait(2);
	thread water_barrell_splash_screen_fx();
}

//Function Number: 61
water_barrell_splash_screen_fx()
{
	wait(0.5);
	common_scripts\_exploder::exploder("water_barrier_splash");
	wait(0.2);
	var_00 = common_scripts\utility::spawn_tag_origin();
	playfxontag(common_scripts\utility::getfx("screen_splash_distort"),var_00,"tag_origin");
	var_00 linktoplayerview(level.player,"tag_origin",(0,0,0),(0,0,0),1);
	wait(2.5);
	stopfxontag(common_scripts\utility::getfx("screen_splash_distort"),var_00,"tag_origin");
	common_scripts\_exploder::kill_exploder("water_barrier_splash");
	var_00 delete();
}

//Function Number: 62
truck_rail_impact(param_00)
{
	wait(0.5);
	playfxontag(common_scripts\utility::getfx("lag_tkdown_truck_barrier_break"),param_00,"tag_origin");
	common_scripts\_exploder::exploder("concrete_barrier_impact");
	common_scripts\_exploder::exploder("concrete_spurt_single");
	wait(1.25);
	common_scripts\_exploder::exploder("water_debris_splashes");
	level waittill("kill_above_water_splashes");
	stopfxontag(common_scripts\utility::getfx("lag_tkdown_truck_barrier_break"),param_00,"tag_origin");
	common_scripts\_exploder::kill_exploder("concrete_spurt_single");
	common_scripts\_exploder::kill_exploder("concrete_barrier_impact");
	common_scripts\_exploder::kill_exploder("water_debris_splashes");
}

//Function Number: 63
truck_water_impact(param_00)
{
	playfxontag(common_scripts\utility::getfx("underwater_splash_foam"),param_00,"tag_origin");
	common_scripts\_exploder::exploder("water_splash_lrg");
	level notify("kill_hostage_truck_tread_fx");
	wait(0.9);
	thread water_bubbles_transition_player_view();
	killfxontag(common_scripts\utility::getfx("underwater_splash_foam"),param_00,"tag_origin");
	level waittill("kill_above_water_splashes");
	common_scripts\_exploder::kill_exploder("water_splash_lrg");
}

//Function Number: 64
water_bubbles_transition_player_view()
{
	var_00 = common_scripts\utility::spawn_tag_origin();
	playfxontag(common_scripts\utility::getfx("underwater_bubble_vm_transition_lp"),var_00,"tag_origin");
	var_00 linktoplayerview(level.player,"tag_origin",(0,0,-5),(0,0,0),1);
	wait(0.25);
	level notify("kill_above_water_splashes");
	common_scripts\_exploder::exploder("underwater_splash");
	wait(2.5);
	stopfxontag(common_scripts\utility::getfx("underwater_bubble_vm_transition_lp"),var_00,"tag_origin");
	wait 0.05;
	var_00 delete();
}

//Function Number: 65
water_bubbles_truck_door()
{
	common_scripts\_exploder::exploder("godrays_underwater");
	common_scripts\_exploder::exploder("fish_school");
	common_scripts\_exploder::exploder("murky_bottom");
	common_scripts\_exploder::exploder("water_bubble_columns");
	common_scripts\_exploder::exploder("concrete_chunk_sinking");
	common_scripts\_exploder::exploder("water_bubble_ring");
	playfxontag(common_scripts\utility::getfx("lag_tkdown_truck_latch_door_edge_lp"),self,"tag_fx_door_edge");
	playfxontag(common_scripts\utility::getfx("lag_tkdown_truck_bubble_trail_lrg"),self,"tag_origin");
	playfxontag(common_scripts\utility::getfx("lag_tkdown_truck_bubble_trail"),self,"tag_origin");
	wait(2.5);
	playfxontag(common_scripts\utility::getfx("bubble_geotrail_thick_xsml"),self,"latch_jnt");
	level waittill("latch_opened");
	stopfxontag(common_scripts\utility::getfx("lag_tkdown_truck_latch_door_edge_lp"),self,"tag_fx_door_edge");
	stopfxontag(common_scripts\utility::getfx("lag_tkdown_truck_bubble_trail"),self,"tag_origin");
	stopfxontag(common_scripts\utility::getfx("bubble_geotrail_thick_xsml"),self,"latch_jnt");
	wait(1);
	killfxontag(common_scripts\utility::getfx("lag_tkdown_truck_bubble_trail_lrg"),self,"tag_origin");
	common_scripts\_exploder::kill_exploder("godrays_underwater");
	common_scripts\_exploder::kill_exploder("fish_school");
	common_scripts\_exploder::kill_exploder("murky_bottom");
	common_scripts\_exploder::kill_exploder("water_bubble_columns");
	common_scripts\_exploder::kill_exploder("concrete_chunk_sinking");
	common_scripts\_exploder::kill_exploder("water_bubble_ring");
}

//Function Number: 66
ambient_underwater_effects_rescue(param_00)
{
	wait(5);
	common_scripts\_exploder::exploder("fish_school_rescue");
	common_scripts\_exploder::exploder("water_bubbles_rescue");
	common_scripts\_exploder::exploder("water_bubble_column_rescue");
	common_scripts\_exploder::exploder("particulates_rescue");
	wait(2);
	common_scripts\_exploder::exploder("godrays_underwater_rescue");
	common_scripts\_exploder::exploder("godray_rescue_gideon");
	common_scripts\_exploder::exploder("concrete_chunk_sinking_rescue");
	common_scripts\_exploder::exploder("water_bubble_ring_rescue");
	level waittill("kill_underwater_effects");
	common_scripts\_exploder::kill_exploder("godrays_underwater_rescue");
	common_scripts\_exploder::kill_exploder("godray_rescue_gideon");
	common_scripts\_exploder::kill_exploder("fish_school_rescue");
	common_scripts\_exploder::kill_exploder("water_bubbles_rescue");
	common_scripts\_exploder::kill_exploder("water_bubble_column_rescue");
	common_scripts\_exploder::kill_exploder("concrete_chunk_sinking_rescue");
	common_scripts\_exploder::kill_exploder("water_bubble_ring_rescue");
	common_scripts\_exploder::kill_exploder("particulates_rescue");
}

//Function Number: 67
truck_latch_open_trail(param_00)
{
	level notify("truck_door_open");
	playfxontag(common_scripts\utility::getfx("bubble_trail_runner_lp"),param_00,"latch_jnt");
	var_01 = common_scripts\utility::spawn_tag_origin();
	var_01 linkto(param_00,"tag_origin",(-100,0,25),(0,180,0));
	playfxontag(common_scripts\utility::getfx("lag_tkdown_truck_latch_door_open"),var_01,"tag_origin");
	wait(0.75);
	stopfxontag(common_scripts\utility::getfx("bubble_trail_runner_lp"),param_00,"latch_jnt");
	wait(11.25);
	stopfxontag(common_scripts\utility::getfx("lag_tkdown_truck_latch_door_open"),var_01,"tag_origin");
	wait 0.05;
	var_01 delete();
}

//Function Number: 68
truck_cargo_door_open(param_00)
{
}

//Function Number: 69
hostage_drowned_bubble_trails(param_00)
{
	playfxontag(common_scripts\utility::getfx("bubble_trail_runner_lp"),param_00,"j_spineupper");
	wait(0.5);
	playfxontag(common_scripts\utility::getfx("bubble_geotrail_thick_xsml"),param_00,"j_head");
	playfxontag(common_scripts\utility::getfx("bubble_geotrail_thick_med"),param_00,"J_SpineLower");
	wait(2);
	stopfxontag(common_scripts\utility::getfx("bubble_geotrail_thick_xsml"),param_00,"j_head");
	stopfxontag(common_scripts\utility::getfx("bubble_trail_runner_lp"),param_00,"j_spineupper");
	stopfxontag(common_scripts\utility::getfx("bubble_geotrail_thick_med"),param_00,"J_SpineLower");
}

//Function Number: 70
gideon_bubble_trails(param_00)
{
	playfxontag(common_scripts\utility::getfx("bubble_trail_runner_lp"),param_00,"j_spineupper");
	playfxontag(common_scripts\utility::getfx("bubble_trail_runner_lp"),param_00,"J_Knee_ri");
	wait(2);
	stopfxontag(common_scripts\utility::getfx("bubble_trail_runner_lp"),param_00,"J_Knee_ri");
	wait(2);
	playfxontag(common_scripts\utility::getfx("bubble_trail_runner_sml_lp"),param_00,"j_wrist_ri");
	playfxontag(common_scripts\utility::getfx("bubble_geotrail_thick_med"),param_00,"j_knee_ri");
	playfxontag(common_scripts\utility::getfx("bubble_trail_runner_lp"),param_00,"J_Knee_le");
	wait 0.05;
	playfxontag(common_scripts\utility::getfx("bubble_geotrail_thick_xsml"),param_00,"j_ankle_le");
	wait(2.5);
	playfxontag(common_scripts\utility::getfx("bubble_trail_runner_sml_lp"),param_00,"j_wrist_le");
	stopfxontag(common_scripts\utility::getfx("bubble_geotrail_thick_med"),param_00,"j_knee_ri");
	stopfxontag(common_scripts\utility::getfx("bubble_geotrail_thick_xsml"),param_00,"j_ankle_le");
	wait(1);
	stopfxontag(common_scripts\utility::getfx("bubble_trail_runner_sml_lp"),param_00,"j_wrist_ri");
	stopfxontag(common_scripts\utility::getfx("bubble_trail_runner_lp"),param_00,"J_Knee_le");
	level waittill("kill_underwater_effects");
	wait(0.1);
	killfxontag(common_scripts\utility::getfx("bubble_trail_runner_lp"),param_00,"j_spineupper");
	killfxontag(common_scripts\utility::getfx("bubble_trail_runner_sml_lp"),param_00,"j_wrist_le");
}

//Function Number: 71
hostage_rescued_bubble_trails(param_00)
{
	playfxontag(common_scripts\utility::getfx("bubble_trail_runner_lp"),param_00,"j_spineupper");
	playfxontag(common_scripts\utility::getfx("bubble_geotrail_thick_xsml"),param_00,"j_ankle_le");
	playfxontag(common_scripts\utility::getfx("bubble_geotrail_thick_xsml"),param_00,"j_wrist_ri");
	wait(2);
	stopfxontag(common_scripts\utility::getfx("bubble_geotrail_thick_xsml"),param_00,"j_wrist_ri");
	wait(1);
	stopfxontag(common_scripts\utility::getfx("bubble_geotrail_thick_xsml"),param_00,"j_ankle_le");
	level waittill("kill_underwater_effects");
	wait(0.35);
	killfxontag(common_scripts\utility::getfx("bubble_trail_runner_lp"),param_00,"j_spineupper");
}

//Function Number: 72
gideon_swim_stroke_up(param_00)
{
	level endon("kill_underwater_effects");
	playfxontag(common_scripts\utility::getfx("bubble_geotrail_thick_xsml"),param_00,"j_wrist_le");
	playfxontag(common_scripts\utility::getfx("bubble_trail_runner_lp"),param_00,"j_spineupper");
	wait(1);
	playfxontag(common_scripts\utility::getfx("bubble_geotrail_thick_xsml"),param_00,"j_ankle_le");
	wait(2);
	stopfxontag(common_scripts\utility::getfx("bubble_geotrail_thick_xsml"),param_00,"j_wrist_le");
	wait(1);
	stopfxontag(common_scripts\utility::getfx("bubble_trail_runner_lp"),param_00,"j_spineupper");
	stopfxontag(common_scripts\utility::getfx("bubble_geotrail_thick_xsml"),param_00,"j_ankle_le");
}

//Function Number: 73
player_gasping_breath()
{
	var_00 = common_scripts\utility::spawn_tag_origin();
	var_00 linktoplayerview(level.player,"tag_origin",(0,0,0),(0,0,0),1);
	wait(2.5);
	playfxontag(common_scripts\utility::getfx("underwater_bubble_vm_gasping_breath"),var_00,"tag_origin");
	wait(3);
	playfxontag(common_scripts\utility::getfx("underwater_bubble_vm_gasping_breath"),var_00,"tag_origin");
	wait(2);
	playfxontag(common_scripts\utility::getfx("underwater_bubble_vm_gasping_breath"),var_00,"tag_origin");
	wait(1.5);
	killfxontag(common_scripts\utility::getfx("underwater_bubble_vm_gasping_breath"),var_00,"tag_origin");
	var_00 delete();
}

//Function Number: 74
player_drown_end_vm_transition()
{
	common_scripts\utility::flag_wait("player_swimming_drown");
	wait(4);
	var_00 = common_scripts\utility::spawn_tag_origin();
	var_00 linktoplayerview(level.player,"tag_origin",(0,0,0),(0,0,0),1);
	playfxontag(common_scripts\utility::getfx("underwater_bubble_vm_death_blackout"),var_00,"tag_origin");
	level waittill("kill_underwater_effects");
	killfxontag(common_scripts\utility::getfx("underwater_bubble_vm_death_blackout"),var_00,"tag_origin");
	wait(1.5);
	var_00 delete();
}

//Function Number: 75
vfx_shore_outro_start()
{
	level notify("kill_underwater_effects");
	common_scripts\_exploder::exploder(20);
	playfxontag(common_scripts\utility::getfx("shore_water_soaked_drip_runner"),level.burke,"J_Knee_RI");
	playfxontag(common_scripts\utility::getfx("shore_water_soaked_drip_runner"),level.burke,"J_Knee_RI");
	playfxontag(common_scripts\utility::getfx("shore_water_soaked_drip_runner"),level.burke,"J_Elbow_RI");
	wait 0.05;
	playfxontag(common_scripts\utility::getfx("shore_water_soaked_drip_runner"),level.burke,"J_Shoulder_LE");
	wait 0.05;
	playfxontag(common_scripts\utility::getfx("shore_water_soaked_drip_runner2"),level.burke,"J_SpineUpper");
	playfxontag(common_scripts\utility::getfx("shore_water_soaked_drip_runner"),level.hostage_1,"J_Shoulder_RI");
	wait 0.05;
	playfxontag(common_scripts\utility::getfx("shore_water_soaked_drip_runner"),level.hostage_1,"J_Elbow_RI");
	playfxontag(common_scripts\utility::getfx("shore_water_soaked_drip_runner"),level.hostage_1,"J_Wrist_RI");
	wait 0.05;
	playfxontag(common_scripts\utility::getfx("shore_water_soaked_drip_runner3"),level.hostage_1,"J_Head");
	wait(0.5);
	var_00 = common_scripts\utility::spawn_tag_origin();
	playfxontag(common_scripts\utility::getfx("screen_wash_distort"),var_00,"tag_origin");
	var_00 linktoplayerview(level.player,"tag_origin",(0,0,0),(0,0,0),1);
	wait(0.37);
	var_00 = common_scripts\utility::spawn_tag_origin();
	playfxontag(common_scripts\utility::getfx("shore_slap_splash"),var_00,"tag_origin");
	var_00 linktoplayerview(level.player,"tag_origin",(5,0,0),(0,0,0),1);
	wait(25);
	stopfxontag(common_scripts\utility::getfx("shore_water_soaked_drip_runner2"),level.burke,"J_SpineUpper");
	playfxontag(common_scripts\utility::getfx("shore_water_soaked_drip_runner2a"),level.burke,"J_SpineUpper");
}