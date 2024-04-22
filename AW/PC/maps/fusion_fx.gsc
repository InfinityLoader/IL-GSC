/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: fusion_fx.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 92
 * Decompile Time: 1306 ms
 * Timestamp: 4/22/2024 2:30:06 AM
*******************************************************************/

//Function Number: 1
main()
{
	precachefx();
	maps\createfx\fusion_fx::main();
	if(!isdefined(level.createfxent))
	{
		level.createfxent = [];
	}

	set_lighting_values();
	set_reactive_motion_values();
	maps\_shg_fx::setup_shg_fx();
	common_scripts\utility::flag_init("fx_flak_intro");
	common_scripts\utility::flag_init("fx_cliff_heli_dust");
	common_scripts\utility::flag_init("fx_heli_rotorsmoke_start");
	common_scripts\utility::flag_init("fx_heli_rotorsmoke_stop");
	common_scripts\utility::flag_init("fx_warbird_hoverdust");
	common_scripts\utility::flag_init("fx_warbird_hit_tower");
	common_scripts\utility::flag_init("hangar_enemies");
	common_scripts\utility::flag_init("fx_ar_start");
	common_scripts\utility::flag_init("fx_ar_stop");
	common_scripts\utility::flag_init("cam_shake_start");
	common_scripts\utility::flag_init("cam_shake_stop");
	common_scripts\utility::flag_init("walker_death_anim_started");
	common_scripts\utility::flag_init("turbine_room_pre_explosion");
	common_scripts\utility::flag_init("reactor_light_rays");
	thread maps\_shg_fx::fx_zone_watcher(1000,"msg_vfx_zone1_intro");
	thread maps\_shg_fx::fx_zone_watcher(1100,"msg_vfx_zone1_zip_line");
	thread maps\_shg_fx::fx_zone_watcher(2000,"msg_vfx_zone2_courtyard");
	thread maps\_shg_fx::fx_zone_watcher(3000,"msg_vfx_zone3_interior_lobby");
	thread maps\_shg_fx::fx_zone_watcher(3100,"msg_vfx_zone3_lab_room_section_1");
	thread maps\_shg_fx::fx_zone_watcher(3200,"msg_vfx_zone3_lab_room_section_2");
	thread maps\_shg_fx::fx_zone_watcher(3300,"msg_vfx_zone3_reactor_room");
	thread maps\_shg_fx::fx_zone_watcher(3310,"msg_vfx_zone3_reactor_control_room");
	thread maps\_shg_fx::fx_zone_watcher(3400,"msg_vfx_zone3_elevator_ride");
	thread maps\_shg_fx::fx_zone_watcher(3500,"msg_vfx_zone3_turbine_room");
	thread maps\_shg_fx::fx_zone_watcher(3600,"msg_vfx_zone3_main_control_room");
	thread maps\_shg_fx::fx_zone_watcher(4000,"msg_vfx_zone4_control_room");
	thread maps\_shg_fx::fx_zone_watcher(5000,"msg_vfx_zone5_loading_zone");
	thread maps\_shg_fx::fx_zone_watcher(6000,"msg_vfx_zone6_cooling_towers");
	thread maps\_shg_fx::fx_zone_watcher(6900,"msg_vfx_zone6_9_pressure_explosion");
	thread maps\_shg_fx::fx_zone_watcher(7000,"msg_vfx_zone7_cooling_tower_explosion");
	thread treadfx_override();
	thread ambient_explosion_before_landing();
	thread ambient_large_pipe_effects_courtyard();
	thread ambient_explosion_courtyard();
	thread flak_intro_sequence();
	thread vfx_control_room_explo();
	thread dust_falling_control_room();
	thread ambient_gas_explosion_loading_zone();
	thread ambient_explosion_dirt_cooling_towers();
	thread ambient_explosion_fireball_cooling_towers();
	thread warbird_hoverdust();
	thread kill_all_env_fx();
	thread init_smvals();
	thread warbird_dropping_mobile_tuerret_camshake();
	thread intro_armap_moment();
	thread reactor_light_rays();
	thread kill_exterior_vfx();
	thread restart_exterior_vfx();
	thread start_smoke_pillar_black_large_fast_fx();
	thread start_smoke_pillar_gray_large_fast_fx();
	thread start_smoke_pillar_black_large_slow_fx();
}

//Function Number: 2
set_lighting_values()
{
	if(isusinghdr())
	{
		setsaveddvar("r_tonemap","1");
		if(isusingssao())
		{
		}
	}
}

//Function Number: 3
set_reactive_motion_values()
{
	setsaveddvar("r_reactiveMotionWindAmplitudeScale","0.3");
}

//Function Number: 4
precachefx()
{
	precacheshader("qr_mask");
	precacheshader("qr_noise");
	precacheshader("qr_anchor");
	precacheshader("qr_sledgehammer");
	precacheshader("ar_loadtext");
	level._effect["emp_reactor_robot_damage"] = loadfx("vfx/sparks/emp_drone_damage");
	level._effect["reactor_robot_death"] = loadfx("vfx/explosion/vehicle_pdrone_explosion");
	level._effect["rpg_trail"] = loadfx("vfx/trail/smoketrail_rpg_sp");
	level._effect["rpg_muzzle"] = loadfx("vfx/muzzleflash/x4walker_wheels_rpg_fv");
	level._effect["rpg_explode"] = loadfx("vfx/explosion/rocket_explosion_default");
	level._effect["mortar_explosion"] = loadfx("vfx/explosion/ambient_explosion_fireball");
	level._effect["ar_map"] = loadfx("vfx/map/fusion/fusion_intro_ar_map");
	level._effect["ar_map_dis"] = loadfx("vfx/map/fusion/fusion_intro_ar_map_dis");
	level._effect["ar_pathA"] = loadfx("vfx/map/fusion/fusion_intro_map_pathA");
	level._effect["ar_pathB"] = loadfx("vfx/map/fusion/fusion_intro_map_pathB");
	level._effect["ar_pathC"] = loadfx("vfx/map/fusion/fusion_intro_map_pathC");
	level._effect["ar_pathD"] = loadfx("vfx/map/fusion/fusion_intro_map_pathD");
	level._effect["wave_hit_large_runner"] = loadfx("vfx/water/wave_hit_large_runner");
	level._effect["wave_hit_large"] = loadfx("vfx/water/wave_hit_large");
	level._effect["wave_hit_large_02"] = loadfx("vfx/water/wave_hit_large_02");
	level._effect["wave_hit_large_03"] = loadfx("vfx/water/wave_hit_large_03");
	level._effect["wave_hit_mist_runner"] = loadfx("vfx/water/wave_hit_mist_runner");
	level._effect["wave_hit_mist_01"] = loadfx("vfx/water/wave_hit_mist_01");
	level._effect["wave_ocean_runner"] = loadfx("vfx/map/fusion/fusion_ocean_wave_runner");
	level._effect["missile_launch_smoke"] = loadfx("vfx/muzzleflash/missile_launch_smoke");
	level._effect["missile_launch_smoke_large"] = loadfx("vfx/muzzleflash/missile_launch_smoke_large");
	level._effect["smoketrail_groundtoair"] = loadfx("vfx/trail/smoketrail_groundtoair");
	level._effect["smoketrail_groundtoair_large"] = loadfx("vfx/trail/smoketrail_groundtoair_large");
	level._effect["aerial_explosion_heli_large"] = loadfx("vfx/explosion/vehicle_warbird_explosion_a");
	level._effect["heli_impact_concrete_large"] = loadfx("vfx/explosion/heli_concrete_impact_large");
	level._effect["vehicle_damaged_fire_m"] = loadfx("vfx/fire/vehicle_damaged_fire_m");
	level._effect["vehicle_damaged_rotorsmoke"] = loadfx("vfx/smoke/vehicle_damaged_rotorsmoke");
	level._effect["fusion_heli_hover_dust"] = loadfx("vfx/map/fusion/fusion_heli_hover_dust");
	level._effect["heli_dust_warbird_placed"] = loadfx("vfx/map/fusion/fusion_heli_dust_warbird_placed");
	level._effect["trail_concrete_dust_m"] = loadfx("vfx/trail/trail_concrete_dust_m");
	level._effect["fusion_warbird_interior_fire"] = loadfx("vfx/map/fusion/fusion_warbird_interior_fire");
	level._effect["flesh_hit"] = loadfx("vfx/weaponimpact/flesh_impact_body_fatal_exit");
	level._effect["fire_smoke_trail_verysmall"] = loadfx("vfx/fire/fire_smoke_trail_verysmall");
	level._effect["cooling_tower_smoke"] = loadfx("vfx/smoke/cooling_tower_smoke");
	level._effect["x4walker_drop_in_dust"] = loadfx("vfx/dust/x4walker_drop_in_dust");
	level._effect["walker_tank_rocket_wv"] = loadfx("vfx/muzzleflash/walker_tank_rocket_wv");
	level._effect["walker_tank_dying_fire"] = loadfx("vfx/fire/vehicle_walker_tank_dying_fire");
	level._effect["walker_tank_dying_fire_small"] = loadfx("vfx/fire/vehicle_walker_tank_dying_fire_small");
	level._effect["walker_footstep"] = loadfx("vfx/treadfx/footstep_walker_tank");
	level._effect["walker_explosion"] = loadfx("vfx/explosion/vehicle_walker_tank_explosion");
	level._effect["vehicle_destroyed_fire_m"] = loadfx("vfx/fire/vehicle_destroyed_fire_m");
	level._effect["vehicle_destroyed_smoke_white_m"] = loadfx("vfx/smoke/vehicle_destroyed_smoke_white_m");
	level._effect["vehicle_damaged_sparks_l"] = loadfx("vfx/sparks/vehicle_damaged_sparks_l");
	level._effect["mobile_turret_sparks"] = loadfx("vfx/sparks/vehicle_damaged_sparks_interior_small");
	level._effect["mobile_turret_fire_small"] = loadfx("vfx/fire/vehicle_damaged_fire_interior_small");
	level._effect["mobile_turret_fire_large"] = loadfx("vfx/fire/vehicle_damaged_fire_x4walker_vm");
	level._effect["mobile_turret_explosion"] = loadfx("vfx/explosion/vehicle_x4walker_explosion");
	level._effect["mobile_turret_ground_smoke"] = loadfx("vfx/map/fusion/fusion_mobile_turret_base_smoke");
	level._effect["fusion_vehicle_mobile_cover_explosion"] = loadfx("vfx/explosion/vehicle_mobile_cover_explosion");
	level._effect["fusion_vehicle_mobile_cover_explosion_01"] = loadfx("vfx/explosion/vehicle_mobile_cover_explosion_01");
	level._effect["tire_industrial_01_rubber"] = loadfx("vfx/destructible/tire_industrial_01_rubber");
	level._effect["concrete_impact_large_chunks"] = loadfx("vfx/explosion/concrete_impact_large_chunks");
	level._effect["parking_garage_chunk_impacts"] = loadfx("vfx/map/fusion/parking_garage_chunk_impacts");
	level._effect["fusion_garage_explosion_arms"] = loadfx("vfx/explosion/fusion_garage_explosion_arms");
	level._effect["trophy_explosion"] = loadfx("vfx/explosion/trophy_explosion");
	level._effect["trophy_ignition_smoke"] = loadfx("vfx/muzzleflash/x4walker_wheels_rpg_fv");
	level._effect["wind_blowing_debris"] = loadfx("vfx/wind/wind_blowing_debris");
	level._effect["fireball_smk_M"] = loadfx("vfx/fire/fireball_lp_smk_M");
	level._effect["fire_lp_m"] = loadfx("vfx/fire/fire_lp_m");
	level._effect["fire_lp_m_no_light"] = loadfx("vfx/fire/fire_lp_m_no_light");
	level._effect["fire_lp_s"] = loadfx("vfx/fire/fire_lp_s");
	level._effect["fire_lp_s_no_light"] = loadfx("vfx/fire/fire_lp_s_no_light");
	level._effect["fire_lp_xs_no_light"] = loadfx("vfx/fire/fire_lp_xs_no_light");
	level._effect["fire_lp_smk_s"] = loadfx("vfx/fire/fire_lp_smk_s");
	level._effect["battlefield_smoke_m"] = loadfx("vfx/smoke/battlefield_smoke_m");
	level._effect["battlefield_smoke_l"] = loadfx("vfx/smoke/battlefield_smoke_l");
	level._effect["battlefield_smoke_l_ground"] = loadfx("vfx/smoke/battlefield_smoke_l_ground");
	level._effect["amb_dust_verylight"] = loadfx("vfx/dust/amb_dust_verylight");
	level._effect["amb_dust_verylight_far"] = loadfx("vfx/dust/amb_dust_verylight_far");
	level._effect["amb_dust_dark"] = loadfx("vfx/dust/amb_dust_dark");
	level._effect["smoke_pillar_white_01"] = loadfx("vfx/smoke/smoke_pillar_white_01");
	level._effect["smoke_pillar_black_large_fast"] = loadfx("vfx/smoke/smoke_pillar_black_large_fast");
	level._effect["smoke_pillar_gray_large_fast"] = loadfx("vfx/smoke/smoke_pillar_gray_large_fast");
	level._effect["smoke_pillar_black_large_slow"] = loadfx("vfx/smoke/smoke_pillar_black_large_slow");
	level._effect["smoke_pillar_black_medium_slow"] = loadfx("vfx/smoke/smoke_pillar_black_medium_slow");
	level._effect["smoke_cloud_black_large"] = loadfx("vfx/smoke/smoke_cloud_black_large");
	level._effect["ambient_explosion_dirt_runner"] = loadfx("vfx/explosion/ambient_explosion_dirt_runner");
	level._effect["ambient_explosion_dirt_02"] = loadfx("vfx/explosion/ambient_explosion_dirt_02");
	level._effect["ambient_explosion_fireball"] = loadfx("vfx/explosion/ambient_explosion_fireball");
	level._effect["ambient_explosion_fireball_a_no_decal"] = loadfx("vfx/explosion/ambient_explosion_fireball_a_no_decal");
	level._effect["fast_blowing_dust"] = loadfx("vfx/dust/fast_blowing_dust");
	level._effect["distortion_warbird"] = loadfx("vfx/distortion/distortion_warbird");
	level._effect["warbird_rotor"] = loadfx("vfx/unique/warbird_rotor");
	level._effect["warbird_rotor_sm"] = loadfx("vfx/unique/warbird_rotor_sm");
	level._effect["aa_explosion_runner"] = loadfx("vfx/explosion/aa_explosion_runner");
	level._effect["aa_explosion_runner_single"] = loadfx("vfx/explosion/aa_explosion_runner_single");
	level._effect["aa_explosion_generic_01"] = loadfx("vfx/explosion/aa_explosion_generic_01");
	level._effect["aa_explosion_generic_02"] = loadfx("vfx/explosion/aa_explosion_generic_02");
	level._effect["fireball_smk_S"] = loadfx("vfx/fire/fireball_lp_smk_S");
	level._effect["cloud_bank"] = loadfx("vfx/wind/cloud_bank_ocean");
	level._effect["cloud_bank_large"] = loadfx("vfx/wind/cloud_bank_ocean_large");
	level._effect["cloud_bank_cliffedge_thin"] = loadfx("vfx/wind/cloud_bank_cliffedge_thin");
	level._effect["fog_distant_vista"] = loadfx("vfx/fog/fog_distant_vista");
	level._effect["electrical_sparks"] = loadfx("vfx/explosion/electrical_sparks");
	level._effect["electrical_sparks_runner"] = loadfx("vfx/explosion/electrical_sparks_runner");
	level._effect["electrical_sparks_runner_single_burst"] = loadfx("vfx/explosion/electrical_sparks_runner_single_burst");
	level._effect["dust_falling_light_runner"] = loadfx("vfx/dust/dust_falling_light_runner");
	level._effect["dust_falling_debris_runner"] = loadfx("vfx/dust/dust_falling_debris_runner");
	level._effect["dust_blowing_ground_fast_runner"] = loadfx("vfx/dust/dust_blowing_ground_fast_runner");
	level._effect["dust_blowing_ground_fast_01"] = loadfx("vfx/dust/dust_blowing_ground_fast_01");
	level._effect["dust_blowing_ground_fast_02"] = loadfx("vfx/dust/dust_blowing_ground_fast_02");
	level._effect["dust_falling_light_01"] = loadfx("vfx/dust/dust_falling_light_01");
	level._effect["dust_falling_light_02"] = loadfx("vfx/dust/dust_falling_light_02");
	level._effect["dust_falling_light_03"] = loadfx("vfx/dust/dust_falling_light_03");
	level._effect["dust_falling_debris_01_s"] = loadfx("vfx/dust/dust_falling_debris_01_s");
	level._effect["dust_falling_debris_02_s"] = loadfx("vfx/dust/dust_falling_debris_02_s");
	level._effect["dust_falling_debris_03_s"] = loadfx("vfx/dust/dust_falling_debris_03_s");
	level._effect["dust_falling_debris_04_s"] = loadfx("vfx/dust/dust_falling_debris_04_s");
	level._effect["dust_falling_debris_05"] = loadfx("vfx/dust/dust_falling_debris_05");
	level._effect["dust_falling_debris_s_runner"] = loadfx("vfx/dust/dust_falling_debris_s_runner");
	level._effect["firelp_med"] = loadfx("vfx/fire/firelp_med");
	level._effect["fire_pipe_large"] = loadfx("vfx/fire/fire_pipe_large");
	level._effect["fire_pipe_leak_med"] = loadfx("vfx/fire/fire_pipe_leak_med");
	level._effect["fire_pipe_leak_med_single"] = loadfx("vfx/fire/fire_pipe_leak_med_single");
	level._effect["steam_pipe_leak_sml"] = loadfx("vfx/steam/steam_pipe_leak_sml");
	level._effect["steam_pipe_leak_lrg"] = loadfx("vfx/steam/steam_pipe_leak_lrg");
	level._effect["steam_pipe_burst"] = loadfx("vfx/steam/steam_pipe_burst");
	level._effect["steam_fill_ground"] = loadfx("vfx/steam/steam_fill_ground");
	level._effect["steam_fill_area"] = loadfx("vfx/steam/steam_fill_area");
	level._effect["steam_fill_area_med"] = loadfx("vfx/steam/steam_fill_area_med");
	level._effect["ambient_explosion_gas_01"] = loadfx("vfx/explosion/ambient_explosion_gas_01");
	level._effect["ambient_explosion_gas_02"] = loadfx("vfx/explosion/ambient_explosion_gas_02");
	level._effect["window_smoke_very_large"] = loadfx("vfx/smoke/window_smoke_very_large");
	level._effect["room_smoke_black_ember_lrg"] = loadfx("vfx/smoke/room_smoke_black_ember_lrg");
	level._effect["glass_falling_debris_01"] = loadfx("vfx/glass/glass_falling_debris_01");
	level._effect["fusion_battlefield_smoke_l_shadow"] = loadfx("vfx/map/fusion/fusion_battlefield_smoke_l_shadow");
	level._effect["fusion_battlefield_smoke_l_light"] = loadfx("vfx/map/fusion/fusion_battlefield_smoke_l_light");
	level._effect["steam_surface_add"] = loadfx("vfx/steam/steam_surface_add");
	level._effect["amb_dust_patch_light"] = loadfx("vfx/dust/amb_dust_patch_light");
	level._effect["light_godray_beam_3"] = loadfx("vfx/lights/light_godray_beam_3");
	level._effect["dust_falling_light_06"] = loadfx("vfx/dust/dust_falling_light_06");
	level._effect["dust_impact_ground_sm"] = loadfx("vfx/dust/dust_impact_ground_sm");
	level._effect["light_dust_particles_small"] = loadfx("vfx/dust/light_dust_particles_sm");
	level._effect["amb_ground_dust"] = loadfx("vfx/dust/amb_ground_dust");
	level._effect["amb_ground_dust_sml"] = loadfx("vfx/dust/amb_ground_dust_sml");
	level._effect["fus_vent_air_flow"] = loadfx("vfx/map/fusion/fus_vent_air_flow");
	level._effect["fus_vent_streamers"] = loadfx("vfx/map/fusion/fus_vent_streamers");
	level._effect["fus_turbine_steam_volume_sm_lp"] = loadfx("vfx/map/fusion/fus_turbine_steam_volume_sm_lp");
	level._effect["fus_door_dust_ground"] = loadfx("vfx/map/fusion/fus_door_dust_ground");
	level._effect["fus_door_dust_top"] = loadfx("vfx/map/fusion/fus_door_dust_top");
	level._effect["pressure_explosion_ground_lrg_01"] = loadfx("vfx/explosion/pressure_explosion_ground_lrg_01");
	level._effect["pressure_explosion_ground_lrg_02"] = loadfx("vfx/explosion/pressure_explosion_ground_lrg_02");
	level._effect["steam_pipe_burst_looping_lrg_01"] = loadfx("vfx/steam/steam_pipe_burst_looping_lrg_01");
	level._effect["pressure_explosion_metal_lrg_01"] = loadfx("vfx/explosion/pressure_explosion_metal_lrg_01");
	level._effect["steam_pipe_burst_looping_lrg_02"] = loadfx("vfx/steam/steam_pipe_burst_looping_lrg_02");
	level._effect["dust_impact_ground_lrg"] = loadfx("vfx/dust/dust_impact_ground_lrg");
	level._effect["trail_steam_round_lrg"] = loadfx("vfx/trail/trail_steam_round_lrg");
	level._effect["trail_steam_round_lrg_runner"] = loadfx("vfx/trail/trail_steam_round_lrg_runner");
	level._effect["trail_spark_burst_explosion"] = loadfx("vfx/trail/trail_spark_burst_explosion");
	level._effect["impact_scorchmark_med"] = loadfx("vfx/fire/impact_scorchmark_med");
	level._effect["impact_scorchmark_sml"] = loadfx("vfx/fire/impact_scorchmark_sml");
	level._effect["impact_sparks_01"] = loadfx("vfx/explosion/impact_sparks_01");
	level._effect["fireball_explosion_directional_01"] = loadfx("vfx/explosion/fireball_explosion_directional_01");
	level._effect["vehicle_fireball_explosion_01"] = loadfx("vfx/explosion/vehicle_fireball_explosion_01");
	level._effect["fusion_end_armblood_init"] = loadfx("vfx/map/fusion/fusion_end_armblood_init");
	level._effect["fusion_end_armblood_bloodsquirts"] = loadfx("vfx/map/fusion/fusion_end_armblood_bloodsquirts");
	level._effect["blood_smear_oriented"] = loadfx("vfx/map/fusion/fusion_blood_smear_oriented");
	level._effect["fusion_end_rollingsmk"] = loadfx("vfx/map/fusion/fusion_end_rollingsmk");
	level._effect["fusion_end_rollingsmk_slow"] = loadfx("vfx/map/fusion/fusion_end_rollingsmk_slow");
	level._effect["fusion_end_rollingsmk_slow1"] = loadfx("vfx/map/fusion/fusion_end_rollingsmk_slow1");
	level._effect["fusion_end_rollingsmk_thick"] = loadfx("vfx/map/fusion/fusion_end_rollingsmk_thick");
	level._effect["fusion_end_grnd_init_explosion"] = loadfx("vfx/map/fusion/fusion_end_grnd_init_explo");
	level._effect["fusion_end_grnd_init_shkwv"] = loadfx("vfx/map/fusion/fusion_end_grnd_init_shkwv");
	level._effect["fusion_end_lingering_smk"] = loadfx("vfx/map/fusion/fusion_end_lingering_smk");
	level._effect["fusion_pressure_explo_leadup"] = loadfx("vfx/map/fusion/fusion_pressure_explo_leadup");
	level._effect["fusion_end_tower_explo"] = loadfx("vfx/map/fusion/fusion_end_tower_explo");
	level._effect["fusion_end_smk_emit"] = loadfx("vfx/map/fusion/fusion_end_smk_emit");
	level._effect["fusion_end_smk_lrg_emit"] = loadfx("vfx/map/fusion/fusion_end_smk_lrg_emit");
	level._effect["fusion_end_smk_med_emit"] = loadfx("vfx/map/fusion/fusion_end_smk_med_emit");
	level._effect["fusion_end_thick_smk_up"] = loadfx("vfx/map/fusion/fusion_end_thick_smk_up");
	level._effect["fusion_end_thick_smk_up_tall"] = loadfx("vfx/map/fusion/fusion_end_thick_smk_up_tall");
	level._effect["fusion_end_smk_donut"] = loadfx("vfx/map/fusion/fusion_end_smk_donut");
	level._effect["fusion_end_smk_donut_looping"] = loadfx("vfx/map/fusion/fusion_end_smk_donut_looping");
	level._effect["fusion_end_grnd_splinters_up"] = loadfx("vfx/map/fusion/fusion_end_grnd_splinters_up");
	level._effect["fusion_end_falling_rocks"] = loadfx("vfx/map/fusion/fusion_end_falling_rocks");
	level._effect["ash_cloud_freq_lrg_loop"] = loadfx("vfx/ash/ash_cloud_freq_lrg_loop");
	level._effect["fusion_end_tower_falling_dust"] = loadfx("vfx/map/fusion/fusion_end_tower_falling_dust");
	level._effect["fusion_end_tower_inital_crack"] = loadfx("vfx/map/fusion/fusion_end_tower_inital_crack");
	level._effect["fusion_end_thick_smk_vm"] = loadfx("vfx/map/fusion/fusion_end_thick_smk_vm");
	level._effect["fusion_end_falling_debris"] = loadfx("vfx/map/fusion/fusion_end_falling_debris");
	level._effect["fusion_end_falling_rock_sparkfoun"] = loadfx("vfx/map/fusion/fusion_end_falling_rock_sparkfoun");
	level._effect["fusion_end_smk_xlrg_emit"] = loadfx("vfx/map/fusion/fusion_end_smk_xlrg_emit");
	level._effect["fusion_end_smk_xxlrg_emit"] = loadfx("vfx/map/fusion/fusion_end_smk_xxlrg_emit");
	level._effect["fusion_end_pillar_burst"] = loadfx("vfx/map/fusion/fusion_end_pillar_burst");
	level._effect["fusion_drag_dust"] = loadfx("vfx/map/fusion/fusion_drag_dust");
	level._effect["fusion_falling_debris_tower"] = loadfx("vfx/map/fusion/fusion_falling_debris_tower");
	level._effect["fusion_end_bouncing_rocks"] = loadfx("vfx/map/fusion/fusion_end_bouncing_rocks");
	level._effect["concrete_impact_xl_chunks_smoky"] = loadfx("vfx/explosion/concrete_impact_xl_chunks_smoky");
	level._effect["light_spot_rim_burke_dopl"] = loadfx("vfx/lights/light_spot_rim_burke_dopl");
	level._effect["light_spot_key_burke_dopl"] = loadfx("vfx/lights/light_spot_key_burke_dopl");
	level._effect["light_spot_fill_burke_dopl"] = loadfx("vfx/lights/light_spot_fill_burke_dopl");
	level._effect["light_spot_fill_burke_fade_dopl"] = loadfx("vfx/lights/light_spot_fill_burke_fade_dopl");
	level._effect["lights_conelight_smokey"] = loadfx("vfx/lights/lights_conelight_smokey");
	level._effect["light_glow_teal"] = loadfx("vfx/lights/light_glow_teal");
	level._effect["light_glow_single_large"] = loadfx("vfx/lights/light_glow_single_large");
	level._effect["light_glow_single_large_offscreen"] = loadfx("vfx/lights/light_glow_single_large_offscreen");
	level._effect["light_firelight_lrg"] = loadfx("vfx/lights/light_firelight_lrg");
	level._effect["light_firelight_orange_lrg"] = loadfx("vfx/lights/light_firelight_orange_lrg");
	level._effect["light_godray_01"] = loadfx("vfx/lights/light_godray_beam_1");
	level._effect["light_godray_transp_lrg_01"] = loadfx("vfx/lights/light_godray_beam_transp_lrg_1");
	level._effect["light_godray_transp_lrg_03"] = loadfx("vfx/lights/light_godray_beam_transp_lrg_3");
	level._effect["light_godray_lrg_01"] = loadfx("vfx/lights/light_godray_beam_lrg_1");
	level._effect["light_godray_xtra_lrg_01"] = loadfx("vfx/lights/light_godray_beam_xtra_lrg_1");
	level._effect["light_godray_lrg_02"] = loadfx("vfx/lights/light_godray_beam_lrg_02");
	level._effect["light_godray_lrg_03"] = loadfx("vfx/lights/light_godray_beam_lrg_03");
	level._effect["light_dust_particles"] = loadfx("vfx/dust/light_dust_particles");
	level._effect["light_red_rotate"] = loadfx("vfx/lights/light_red_rotate_02");
	level._effect["light_red_strobe"] = loadfx("vfx/map/fusion/fus_light_red_strobe");
	level._effect["light_white_strobe"] = loadfx("vfx/lights/light_white_strobe");
	level._effect["light_godray_02"] = loadfx("vfx/lights/light_godray_beam_2");
	level._effect["light_godray_02_warbird"] = loadfx("vfx/lights/light_godray_beam_2_warbird_cg");
	level._effect["light_spot_blue"] = loadfx("vfx/lights/light_spot_blue");
	level._effect["light_point_blue"] = loadfx("vfx/lights/light_point_blue");
	level._effect["light_point_teal"] = loadfx("vfx/lights/light_point_teal");
	level._effect["light_spot_rim_burke"] = loadfx("vfx/lights/light_spot_rim_burke");
	level._effect["light_spot_rim_burke_fadeout"] = loadfx("vfx/lights/light_spot_rim_burke_fadeout");
	level._effect["light_spot_key_burke"] = loadfx("vfx/lights/light_spot_key_burke");
	level._effect["light_point_amber"] = loadfx("vfx/lights/light_point_amber");
	level._effect["fusion_light_point_amber_control"] = loadfx("vfx/map/fusion/fusion_light_point_amber_control");
	level._effect["fusion_light_point_blue_kiosk"] = loadfx("vfx/map/fusion/fusion_light_point_blue_kiosk");
	level._effect["fusion_light_fill_blue_kiosk"] = loadfx("vfx/lights/fusion/fusion_light_fill_blue_kiosk");
	level._effect["fusion_light_ctrl_room_monitor"] = loadfx("vfx/lights/fusion/fusion_light_ctrl_room_monitor");
	level._effect["fusion_light_ctrl_room_fill"] = loadfx("vfx/lights/fusion/fusion_light_ctrl_room_fill");
	level._effect["light_fire_alarm_strobe"] = loadfx("vfx/lights/light_fire_alarm_strobe");
	level._effect["fusion_light_fill_generic_glows"] = loadfx("vfx/lights/fusion/fusion_light_fill_generic_glows");
	level._effect["fusion_light_teal_security_cam"] = loadfx("vfx/lights/fusion/fusion_light_teal_security_cam");
	level._effect["fusion_light_point_blue_monitors"] = loadfx("vfx/map/fusion/fusion_light_point_blue_monitors");
	level._effect["fusion_light_white_monitor_lrg"] = loadfx("vfx/map/fusion/fusion_light_white_monitor_lrg");
	level._effect["fusion_reactor_light_glow_white"] = loadfx("vfx/map/fusion/fusion_reactor_light_glow_white");
	level._effect["fusion_reactor_light_glow_amber"] = loadfx("vfx/map/fusion/fusion_reactor_light_glow_amber");
	level._effect["fusion_light_yellow_rotate"] = loadfx("vfx/map/fusion/fusion_light_yellow_rotate");
	level._effect["fus_light_elevator_monitor"] = loadfx("vfx/lights/fusion/fus_light_elevator_monitor");
	level._effect["fusion_light_point_amber_finale"] = loadfx("vfx/map/fusion/fusion_light_point_amber_finale");
	level._effect["fusion_light_point_fill_finale"] = loadfx("vfx/map/fusion/fusion_light_point_fill_finale");
	level._effect["fusion_light_point_red_control"] = loadfx("vfx/map/fusion/fusion_light_point_red_control");
	level._effect["fusion_light_point_streetlamp_flicker"] = loadfx("vfx/map/fusion/fusion_light_point_streetlamp_flicker");
	level._effect["light_point_open_door"] = loadfx("vfx/lights/light_point_open_door");
	level._effect["light_point_cockpit"] = loadfx("vfx/lights/light_point_cockpit");
	level._effect["light_point_blue_sm"] = loadfx("vfx/lights/light_point_blue_sm");
	level._effect["light_point_blue_sm_far"] = loadfx("vfx/lights/light_point_blue_sm_far");
	level._effect["light_point_heli_interior_blink"] = loadfx("vfx/lights/light_point_heli_interior_blink");
	level._effect["light_haze_distant"] = loadfx("vfx/lights/light_haze_distant");
	level._effect["light_sunflare"] = loadfx("vfx/lights/fusion/fusion_light_sunflare");
	level._effect["warbird_shadow"] = loadfx("vfx/unique/warbird_shadow");
	level._effect["warbird_shadow_cloaked"] = loadfx("vfx/unique/warbird_shadow_cloaked");
	level._effect["light_streetlight_flare"] = loadfx("vfx/lights/light_streetlight_flare");
	level._effect["light_rays_moving_01"] = loadfx("vfx/lights/light_rays_moving_01");
	level._effect["light_rays_moving_02"] = loadfx("vfx/lights/light_rays_moving_02");
	level._effect["light_point_blue_mon_mid"] = loadfx("vfx/lights/light_point_blue_mon_mid");
	level._effect["light_point_blue_mon_left"] = loadfx("vfx/lights/light_point_blue_mon_left");
	level._effect["light_point_blue_mon_right"] = loadfx("vfx/lights/light_point_blue_mon_right");
	level._effect["light_explosion_flash"] = loadfx("vfx/lights/light_explosion_flash");
	level._effect["fus_turbine_floodlight_flare_01"] = loadfx("vfx/map/fusion/fus_turbine_floodlight_flare_01");
	level._effect["fus_hangar_floodlight_flare_01"] = loadfx("vfx/map/fusion/fus_hangar_floodlight_flare_01");
	level._effect["fus_lab_flourescent_flare"] = loadfx("vfx/map/fusion/fus_lab_flourescent_flare");
	level._effect["fusion_sun_flare"] = loadfx("vfx/map/fusion/fus_sun_flare");
	level._effect["fusion_light_heli_strobe_outro"] = loadfx("vfx/lights/fusion/fusion_light_heli_strobe_outro");
	level._effect["fus_light_red_strobe_02"] = loadfx("vfx/map/fusion/fus_light_red_strobe_02");
	level._effect["water_movement"] = loadfx("fx/water/player_water_wake");
	level._effect["steam_pipe_leak_sml"] = loadfx("vfx/steam/steam_pipe_leak_sml");
	level._effect["steam_pipe_leak_lrg"] = loadfx("vfx/steam/steam_pipe_leak_lrg");
	level._effect["steam_pipe_burst"] = loadfx("vfx/steam/steam_pipe_burst");
	level._effect["steam_fill_ground"] = loadfx("vfx/steam/steam_fill_ground");
	level._effect["steam_fill_area"] = loadfx("vfx/steam/steam_fill_area");
	level._effect["steam_fill_area_med"] = loadfx("vfx/steam/steam_fill_area_med");
	level._effect["door_explosion"] = loadfx("vfx/map/fusion/fusion_cntrl_rm_door_explosion");
	level._effect["control_room_glass_shatter"] = loadfx("vfx/map/fusion/fusion_cntrl_rm_glass_shatter");
	level._effect["control_room_fire_residual"] = loadfx("vfx/map/fusion/fusion_cntrl_rm_fire_residual");
	level._effect["turbine_explosion"] = loadfx("vfx/map/fusion/fus_turbine_explo_01");
	level._effect["turbine_explosion_initial_burst"] = loadfx("vfx/map/fusion/fus_turbine_explo_init_burst");
	level._effect["turbine_explosion_initial_burst_l"] = loadfx("vfx/map/fusion/fus_turbine_explo_init_burst_lp");
	level._effect["turbine_explosion_initial_burst_short"] = loadfx("vfx/map/fusion/fus_turbine_explo_init_burst_short");
	level._effect["turbine_explosion_initital_burst_short_2"] = loadfx("vfx/map/fusion/fus_turbine_explo_init_burst_short_2");
	level._effect["turbine_explosion_rear_blast"] = loadfx("vfx/map/fusion/fus_turbine_explo_rear_blast");
	level._effect["turbine_explosion_rear_blast_l"] = loadfx("vfx/map/fusion/fus_turbine_explo_rear_blast_lp");
	level._effect["turbine_explosion_rear_blast_small"] = loadfx("vfx/map/fusion/fus_turbine_explo_rear_blast_sm");
	level._effect["turbine_explosion_rear_blast_small_l"] = loadfx("vfx/map/fusion/fus_turbine_explo_rear_blast_sm_lp");
	level._effect["turbine_explosion_steam_volume_loop"] = loadfx("vfx/map/fusion/fus_turbine_explo_steam_volume_lp");
	level._effect["turbine_explosion_init_burst_spurt_r"] = loadfx("vfx/map/fusion/fus_turbine_explo_init_burst_spurt_r");
	level._effect["turbine_explo_damage"] = loadfx("vfx/map/fusion/fus_turbine_explo_damage");
	level._effect["light_dust_particles_far"] = loadfx("vfx/dust/light_dust_particles_far");
	level._effect["reactor_cntrl_rm_light_ray_1"] = loadfx("vfx/map/fusion/fus_reactor_cntrl_rm_light_ray_1");
	level._effect["turbine_rm_grnd_steam_lp"] = loadfx("vfx/map/fusion/fus_turbine_rm_grnd_steam_lp");
	level._effect["turbine_door_grnd_steam"] = loadfx("vfx/map/fusion/fus_turbine_door_grnd_steam");
	level._effect["dust_falling_light_05_runner"] = loadfx("vfx/dust/dust_falling_light_05_runner");
	level._effect["reactor_rm_reveal_dust"] = loadfx("vfx/map/fusion/fus_reactor_rm_reveal_dust");
	level._effect["reactor_rm_reveal_light_rays"] = loadfx("vfx/map/fusion/fus_reactor_rm_reveal_light_rays");
	level._effect["reactor_rm_reveal_light_rays_a"] = loadfx("vfx/map/fusion/fus_reactor_rm_reveal_light_rays_a");
	level._effect["reactor_rm_reveal_light_rays_b"] = loadfx("vfx/map/fusion/fus_reactor_rm_reveal_light_rays_b");
	level._effect["fus_crate_dust_fall"] = loadfx("vfx/map/fusion/fus_crate_dust_fall");
	level._effect["fus_crane_housing_dust"] = loadfx("vfx/map/fusion/fus_crane_housing_dust_a");
	level._effect["fus_crane_housing_dust_2"] = loadfx("vfx/map/fusion/fus_crane_housing_dust_b");
	level._effect["fus_crane_housing_dust_fall"] = loadfx("vfx/map/fusion/fus_crane_housing_dust_fall");
	level._effect["fus_crate_dust_lift"] = loadfx("vfx/map/fusion/fus_crate_dust_lift");
	level._effect["fus_crane_track_sparks"] = loadfx("vfx/map/fusion/fus_crane_track_sparks");
	level._effect["water_crawl"] = loadfx("vfx/water/water_crawl_runner");
	level._effect["turbine_steam_spray_lp"] = loadfx("vfx/map/fusion/fus_turbine_steam_spray_lp");
	level._effect["turbine_steam_volume_lp"] = loadfx("vfx/map/fusion/fus_turbine_steam_volume_lp");
	level._effect["lobby_screen_distort"] = loadfx("vfx/map/fusion/fus_lobby_screen_distort");
	level._effect["elevator_open_light_rays"] = loadfx("vfx/map/fusion/fus_elevator_open_light_rays");
	level._effect["fus_crane_light_red"] = loadfx("vfx/map/fusion/fus_crane_light_red");
	level._effect["fus_crane_light_green"] = loadfx("vfx/map/fusion/fus_crane_light_green");
	level._effect["elevator_player_slide_dust"] = loadfx("vfx/map/fusion/fus_elevator_player_slide_dust");
	level._effect["elevator_burke_slide_dust"] = loadfx("vfx/map/fusion/fus_elevator_burke_slide_dust");
	level._effect["fus_cover_deploy_impact"] = loadfx("vfx/map/fusion/fus_cover_deploy_impact");
	level._effect["amb_dust_verylight_fade"] = loadfx("vfx/dust/amb_dust_verylight_fade");
	level._effect["fus_amb_dust_reactor"] = loadfx("vfx/map/fusion/fus_amb_dust_reactor");
	level._effect["fus_turbine_dmg_smk"] = loadfx("vfx/map/fusion/fus_turbine_dmg_smk");
	level._effect["dust_falling_column_lp"] = loadfx("vfx/dust/dust_falling_column_lp");
}

//Function Number: 5
treadfx_override()
{
	waittillframeend;
	level.treadfx_maxheight = 2500;
	var_00[0] = "script_vehicle_xh9_warbird_no_turret";
	var_00[1] = "script_vehicle_xh9_warbird_stealth";
	var_00[2] = "script_vehicle_xh9_warbird_stealth_no_turret";
	var_00[3] = "script_vehicle_xh9_warbird_low";
	var_00[4] = "script_vehicle_xh9_warbird_low_no_zipline";
	var_00[5] = "script_vehicle_xh9_warbird_low_no_turret_no_zipline";
	var_01 = "vfx/treadfx/heli_dust_warbird";
	var_02 = "vfx/treadfx/heli_sand_wet_warbird";
	var_03 = "vfx/treadfx/heli_water_warbird";
	var_04 = "vfx/unique/no_fx";
	foreach(var_06 in var_00)
	{
		maps\_vehicle::set_vehicle_effect(var_06,"brick",var_01);
		maps\_vehicle::set_vehicle_effect(var_06,"bark",var_01);
		maps\_vehicle::set_vehicle_effect(var_06,"carpet",var_01);
		maps\_vehicle::set_vehicle_effect(var_06,"cloth",var_01);
		maps\_vehicle::set_vehicle_effect(var_06,"concrete",var_01);
		maps\_vehicle::set_vehicle_effect(var_06,"dirt",var_01);
		maps\_vehicle::set_vehicle_effect(var_06,"flesh",var_01);
		maps\_vehicle::set_vehicle_effect(var_06,"foliage",var_01);
		maps\_vehicle::set_vehicle_effect(var_06,"glass",var_01);
		maps\_vehicle::set_vehicle_effect(var_06,"grass",var_01);
		maps\_vehicle::set_vehicle_effect(var_06,"gravel",var_01);
		maps\_vehicle::set_vehicle_effect(var_06,"ice",var_01);
		maps\_vehicle::set_vehicle_effect(var_06,"metal",var_01);
		maps\_vehicle::set_vehicle_effect(var_06,"mud",var_02);
		maps\_vehicle::set_vehicle_effect(var_06,"paper",var_01);
		maps\_vehicle::set_vehicle_effect(var_06,"plaster",var_04);
		maps\_vehicle::set_vehicle_effect(var_06,"rock",var_01);
		maps\_vehicle::set_vehicle_effect(var_06,"sand",var_02);
		maps\_vehicle::set_vehicle_effect(var_06,"snow",var_01);
		maps\_vehicle::set_vehicle_effect(var_06,"water",var_03);
		maps\_vehicle::set_vehicle_effect(var_06,"wood",var_01);
		maps\_vehicle::set_vehicle_effect(var_06,"asphalt",var_01);
		maps\_vehicle::set_vehicle_effect(var_06,"ceramic",var_04);
		maps\_vehicle::set_vehicle_effect(var_06,"plastic",var_01);
		maps\_vehicle::set_vehicle_effect(var_06,"rubber",var_01);
		maps\_vehicle::set_vehicle_effect(var_06,"cushion",var_01);
		maps\_vehicle::set_vehicle_effect(var_06,"fruit",var_01);
		maps\_vehicle::set_vehicle_effect(var_06,"paintedmetal",var_04);
		maps\_vehicle::set_vehicle_effect(var_06,"riotshield",var_01);
		maps\_vehicle::set_vehicle_effect(var_06,"slush",var_01);
		maps\_vehicle::set_vehicle_effect(var_06,"default",var_01);
		maps\_vehicle::set_vehicle_effect(var_06,"none");
	}

	var_08[0] = "script_vehicle_xh9_warbird";
	foreach(var_06 in var_08)
	{
		maps\_vehicle::set_vehicle_effect(var_06,"brick",var_04);
		maps\_vehicle::set_vehicle_effect(var_06,"bark",var_04);
		maps\_vehicle::set_vehicle_effect(var_06,"carpet",var_04);
		maps\_vehicle::set_vehicle_effect(var_06,"cloth",var_04);
		maps\_vehicle::set_vehicle_effect(var_06,"concrete",var_04);
		maps\_vehicle::set_vehicle_effect(var_06,"dirt",var_04);
		maps\_vehicle::set_vehicle_effect(var_06,"flesh",var_04);
		maps\_vehicle::set_vehicle_effect(var_06,"foliage",var_04);
		maps\_vehicle::set_vehicle_effect(var_06,"glass",var_04);
		maps\_vehicle::set_vehicle_effect(var_06,"grass",var_04);
		maps\_vehicle::set_vehicle_effect(var_06,"gravel",var_04);
		maps\_vehicle::set_vehicle_effect(var_06,"ice",var_04);
		maps\_vehicle::set_vehicle_effect(var_06,"metal",var_04);
		maps\_vehicle::set_vehicle_effect(var_06,"mud",var_02);
		maps\_vehicle::set_vehicle_effect(var_06,"paper",var_04);
		maps\_vehicle::set_vehicle_effect(var_06,"asphalt",var_04);
		maps\_vehicle::set_vehicle_effect(var_06,"plaster",var_04);
		maps\_vehicle::set_vehicle_effect(var_06,"rock",var_04);
		maps\_vehicle::set_vehicle_effect(var_06,"sand",var_02);
		maps\_vehicle::set_vehicle_effect(var_06,"snow",var_04);
		maps\_vehicle::set_vehicle_effect(var_06,"water",var_03);
		maps\_vehicle::set_vehicle_effect(var_06,"wood",var_04);
		maps\_vehicle::set_vehicle_effect(var_06,"asphalt",var_04);
		maps\_vehicle::set_vehicle_effect(var_06,"ceramic",var_04);
		maps\_vehicle::set_vehicle_effect(var_06,"plastic",var_04);
		maps\_vehicle::set_vehicle_effect(var_06,"rubber",var_04);
		maps\_vehicle::set_vehicle_effect(var_06,"cushion",var_04);
		maps\_vehicle::set_vehicle_effect(var_06,"fruit",var_04);
		maps\_vehicle::set_vehicle_effect(var_06,"paintedmetal",var_04);
		maps\_vehicle::set_vehicle_effect(var_06,"riotshield",var_04);
		maps\_vehicle::set_vehicle_effect(var_06,"slush",var_04);
		maps\_vehicle::set_vehicle_effect(var_06,"default",var_04);
		maps\_vehicle::set_vehicle_effect(var_06,"none");
	}

	var_01 = "vfx/treadfx/x4walker_dust";
	maps\_vehicle::build_all_treadfx("script_vehicle_x4walker_wheels",var_01);
	maps\_vehicle::build_all_treadfx("script_vehicle_x4walker_wheels_physics",var_01);
	var_01 = "vfx/treadfx/heli_dust_warbird";
	maps\_vehicle::build_all_treadfx("script_vehicle_mi17_woodland_fly",var_01);
}

//Function Number: 6
intro_ar_sethud()
{
	self.x = 0;
	self.y = 0;
	self.splatter = 1;
	self.alignx = "center";
	self.aligny = "middle";
	self.foreground = 0;
	self.horzalign = "center";
	self.vertalign = "middle";
	self.alpha = 1;
}

//Function Number: 7
intro_ar_anchor_anim(param_00)
{
	var_01[0] = newclienthudelem(level.player);
	var_01[0] setshader("qr_anchor",30,30);
	var_01[0] intro_ar_sethud();
	var_01[0].sort = 9;
	var_01[0].x = -49;
	var_01[0].y = 49;
	var_01[1] = newclienthudelem(level.player);
	var_01[1] setshader("qr_anchor",30,30);
	var_01[1] intro_ar_sethud();
	var_01[1].sort = 9;
	var_01[1].x = -49;
	var_01[1].y = -49;
	var_01[2] = newclienthudelem(level.player);
	var_01[2] setshader("qr_anchor",30,30);
	var_01[2] intro_ar_sethud();
	var_01[2].sort = 9;
	var_01[2].x = 49;
	var_01[2].y = -49;
	var_01[3] = newclienthudelem(level.player);
	var_01[3] setshader("qr_anchor",30,30);
	var_01[3] intro_ar_sethud();
	var_01[3].sort = 9;
	var_01[3].x = 49;
	var_01[3].y = 49;
	for(var_02 = 0;var_02 < param_00 * 20;var_02++)
	{
		var_03 = float(var_02) / 20 - int(float(var_02) / 20);
		var_01[0].alpha = var_03;
		var_01[1].alpha = max(var_03 - 0.35,0) / 0.65;
		var_01[2].alpha = max(var_03 - 0.6,0) / 0.4;
		var_01[3].alpha = max(var_03 - 0.85,0) / 0.15;
		wait 0.05;
	}

	var_01[0] destroy();
	var_01[1] destroy();
	var_01[2] destroy();
	var_01[3] destroy();
}

//Function Number: 8
intro_ar_loadtext(param_00)
{
	var_01 = newclienthudelem(level.player);
	var_01 setshader("ar_loadtext",128,32);
	var_01 intro_ar_sethud();
	var_01.sort = 9;
	var_01.y = -96;
	for(var_02 = 0;var_02 < param_00 * 20;var_02++)
	{
		var_03 = float(var_02) / 20 - int(float(var_02) / 20);
		var_01.alpha = var_03;
		wait 0.05;
	}

	var_01 destroy();
}

//Function Number: 9
intro_ar_anim_shg(param_00)
{
	for(var_01 = 0;var_01 < 10;var_01++)
	{
		var_02 = float(var_01) / 10 - int(float(var_01) / 10);
		param_00.x = -380 * var_02;
		param_00.y = 186 * var_02;
		wait 0.05;
	}

	wait(20);
	for(var_01 = 0;var_01 < 20;var_01++)
	{
		var_02 = float(var_01) / 20 - int(float(var_01) / 20);
		param_00.alpha = 1 - var_02;
		wait 0.05;
	}

	param_00 destroy();
}

//Function Number: 10
intro_ar_load_screen()
{
}

//Function Number: 11
intro_ar_path_anim(param_00,param_01,param_02,param_03,param_04)
{
	wait(7);
	playfxontag(common_scripts\utility::getfx("ar_pathA"),param_01,"tag_origin");
	wait(1);
	playfxontag(common_scripts\utility::getfx("ar_pathB"),param_02,"tag_origin");
	wait(1);
	playfxontag(common_scripts\utility::getfx("ar_pathC"),param_03,"tag_origin");
	wait(1);
	playfxontag(common_scripts\utility::getfx("ar_pathD"),param_04,"tag_origin");
}

//Function Number: 12
intro_ar_scale_ssao(param_00,param_01)
{
	var_02 = getdvarfloat("r_ssaoStrength");
	var_03 = param_00 - var_02;
	var_04 = param_01 * 20;
	for(var_05 = 0;var_05 < var_04;var_05++)
	{
		var_06 = var_02 + var_03 * var_05 / var_04;
		setsaveddvar("r_ssaoStrength",var_06);
		wait 0.05;
	}

	setsaveddvar("r_ssaoStrength",param_00);
}

//Function Number: 13
intro_armap_moment()
{
	wait(1);
	if(!isdefined(level.start_point) || level.start_point != "fly_in_animated" && level.start_point != "fly_in_animated_part2")
	{
		return;
	}

	var_00 = getent("armap","targetname");
	var_01 = getent("armapshade","targetname");
	var_02 = getent("armapdist","targetname");
	var_03 = getent("armaplow","targetname");
	var_04 = common_scripts\utility::spawn_tag_origin();
	var_04.origin = var_01 gettagorigin("tag_fx");
	var_04.angles = var_01 gettagangles("tag_fx");
	var_04 linkto(var_01,"tag_fx");
	var_05 = common_scripts\utility::spawn_tag_origin();
	var_05.origin = var_01 gettagorigin("tag_pathA");
	var_05.angles = var_01 gettagangles("tag_pathA");
	var_05 linkto(var_01,"tag_pathA");
	var_06 = common_scripts\utility::spawn_tag_origin();
	var_06.origin = var_01 gettagorigin("tag_pathA1");
	var_06.angles = var_01 gettagangles("tag_pathA1");
	var_06 linkto(var_01,"tag_pathA1");
	var_07 = common_scripts\utility::spawn_tag_origin();
	var_07.origin = var_01 gettagorigin("tag_pathA2");
	var_07.angles = var_01 gettagangles("tag_pathA2");
	var_07 linkto(var_01,"tag_pathA2");
	var_08 = common_scripts\utility::spawn_tag_origin();
	var_08.origin = var_01 gettagorigin("tag_pathA3");
	var_08.angles = var_01 gettagangles("tag_pathA3");
	var_08 linkto(var_01,"tag_pathA3");
	var_01 overridereflectionprobe((10960,-112640,1912));
	var_03 overridereflectionprobe((10960,-112640,1912));
	var_00 overridereflectionprobe((10960,-112640,1912));
	var_01 setmaterialscriptparam(0,0);
	var_09 = getent("armapbox","targetname");
	var_0A = [];
	var_0A[0] = var_00;
	var_0A[0].animname = "ar_map";
	var_0A[0] maps\_utility::assign_animtree();
	var_0A[1] = var_01;
	var_0A[1].animname = "ar_map";
	var_0A[1] maps\_utility::assign_animtree();
	var_0A[2] = var_02;
	var_0A[2].animname = "ar_map";
	var_0A[2] maps\_utility::assign_animtree();
	var_0A[3] = var_03;
	var_0A[3].animname = "ar_map";
	var_0A[3] maps\_utility::assign_animtree();
	var_00 hide();
	var_01 hide();
	var_02 hide();
	var_03 hide();
	if(!isdefined("fusion_map_open"))
	{
		common_scripts\utility::flag_init("fusion_map_open");
	}

	common_scripts\utility::flag_wait("fusion_map_open");
	var_0B = level.warbird_a;
	var_0B maps\_anim::anim_first_frame(var_0A,"fly_in_intro","tag_ar_map");
	common_scripts\utility::flag_set("fx_ar_start");
	playfxontag(common_scripts\utility::getfx("ar_map"),var_04,"tag_origin");
	var_00 linkto(var_0B,"tag_ar_map");
	var_01 linkto(var_0B,"tag_ar_map");
	var_02 linkto(var_0B,"tag_ar_map");
	var_03 linkto(var_0B,"tag_ar_map");
	if(!isdefined("fusion_start_map_anim"))
	{
		common_scripts\utility::flag_init("fusion_start_map_anim");
	}

	if(!isdefined("fusion_stop_map_anim"))
	{
		common_scripts\utility::flag_init("fusion_stop_map_anim");
	}

	common_scripts\utility::flag_wait("fusion_start_map_anim");
	var_01 show();
	var_02 show();
	var_03 show();
	var_03 hidepart("body_4");
	var_03 hidepart("body_6");
	thread intro_ar_path_anim(var_00,var_05,var_06,var_07,var_08);
	thread intro_play_ar_anim(var_0B,var_0A);
	common_scripts\utility::flag_wait("fusion_map_target_01");
	var_03 showpart("body_4");
	common_scripts\utility::flag_wait("fusion_map_target_02");
	var_03 showpart("body_6");
	common_scripts\utility::flag_wait("fusion_stop_map_anim");
	var_00 hide();
	var_01 delete();
	var_02 delete();
	var_03 delete();
	var_04.origin = (0,0,0);
	var_05.origin = (0,0,0);
	var_06.origin = (0,0,0);
	var_07.origin = (0,0,0);
	var_08.origin = (0,0,0);
	stopfxontag(common_scripts\utility::getfx("ar_map"),var_04,"tag_origin");
	playfxontag(common_scripts\utility::getfx("ar_map_dis"),var_00,"tag_fx");
	wait(1);
	var_00 delete();
	var_04 delete();
	var_05 delete();
	var_06 delete();
	var_07 delete();
	var_08 delete();
	common_scripts\utility::flag_set("fx_ar_stop");
}

//Function Number: 14
intro_play_ar_anim(param_00,param_01)
{
	param_00 maps\_anim::anim_single(param_01,"fly_in_intro","tag_ar_map");
}

//Function Number: 15
flak_intro_sequence()
{
	common_scripts\utility::flag_wait("fx_flak_intro");
	common_scripts\_exploder::exploder(1019);
	common_scripts\_exploder::exploder(1028);
	common_scripts\_exploder::exploder(1023);
	wait(1);
	common_scripts\_exploder::exploder(1024);
	wait(1.5);
	common_scripts\_exploder::exploder(1025);
	wait(0.5);
	common_scripts\_exploder::exploder(1026);
	wait(3);
	common_scripts\_exploder::exploder(1027);
	wait(3);
	maps\_utility::pauseexploder(1019);
	maps\_utility::pauseexploder(1023);
	maps\_utility::pauseexploder(1024);
	maps\_utility::pauseexploder(1025);
	maps\_utility::pauseexploder(1026);
	maps\_utility::pauseexploder(1027);
	wait(12);
	maps\_utility::pauseexploder(1028);
}

//Function Number: 16
intro_fly_in_missile_hit_warbird(param_00)
{
	soundscripts\_snd::snd_message("missile_hit_warbird_b");
	var_01 = param_00 gettagorigin("jnt_wingSocket_L");
	playfx(common_scripts\utility::getfx("aerial_explosion_heli_large"),var_01);
	playfxontag(common_scripts\utility::getfx("light_explosion_flash"),level.warbird_a,"TAG_open_door");
	var_02 = common_scripts\utility::spawn_tag_origin();
	var_03 = (-18.957,66.128,-7.108);
	var_02 linkto(param_00,"body_animate_jnt",var_03,(0,0,0));
	playfxontag(common_scripts\utility::getfx("vehicle_damaged_fire_m"),var_02,"tag_origin");
	playfxontag(common_scripts\utility::getfx("vehicle_damaged_fire_m"),param_00,"TAG_STATIC_TAIL_ROTOR");
	playfxontag(common_scripts\utility::getfx("fusion_warbird_interior_fire"),param_00,"body_animate_jnt");
	common_scripts\utility::flag_wait("fx_heli_rotorsmoke_start");
	playfxontag(common_scripts\utility::getfx("vehicle_damaged_rotorsmoke"),param_00,"TAG_STATIC_MAIN_ROTOR_R");
	wait(0.4);
	stopfxontag(common_scripts\utility::getfx("vehicle_damaged_fire_m"),var_02,"tag_origin");
	common_scripts\utility::flag_wait("fx_warbird_hit_tower");
	stopfxontag(common_scripts\utility::getfx("vehicle_damaged_rotorsmoke"),param_00,"TAG_STATIC_MAIN_ROTOR_R");
	stopfxontag(common_scripts\utility::getfx("vehicle_damaged_fire_m"),param_00,"TAG_STATIC_TAIL_ROTOR");
	stopfxontag(common_scripts\utility::getfx("fusion_warbird_interior_fire"),param_00,"tag_origin");
	stopfxontag(common_scripts\utility::getfx("light_explosion_flash"),level.warbird_a,"TAG_open_door");
	if(level.currentgen)
	{
		level waittill("tff_pre_transition_intro_to_middle");
		var_02 delete();
		param_00 delete();
	}
}

//Function Number: 17
intro_fly_in_missile_hit_warbird_tower(param_00)
{
	soundscripts\_snd::snd_message("warbird_b_crash_tower");
	common_scripts\_exploder::exploder(5);
	common_scripts\utility::flag_set("fx_warbird_hit_tower");
}

//Function Number: 18
play_tower_debris_fx(param_00)
{
	common_scripts\utility::flag_wait("fx_warbird_hit_tower");
	wait(0.2);
	playfxontag(common_scripts\utility::getfx("trail_concrete_dust_m"),param_00,"jo_fus_tower_concrete_chunk_07");
	playfxontag(common_scripts\utility::getfx("trail_concrete_dust_m"),param_00,"jo_fus_tower_concrete_chunk_20");
	playfxontag(common_scripts\utility::getfx("trail_concrete_dust_m"),param_00,"jo_fus_tower_concrete_chunk_11");
	wait(4);
	stopfxontag(common_scripts\utility::getfx("trail_concrete_dust_m"),param_00,"jo_fus_tower_concrete_chunk_07");
	stopfxontag(common_scripts\utility::getfx("trail_concrete_dust_m"),param_00,"jo_fus_tower_concrete_chunk_20");
	stopfxontag(common_scripts\utility::getfx("trail_concrete_dust_m"),param_00,"jo_fus_tower_concrete_chunk_11");
}

//Function Number: 19
intro_fly_in_missile_hit_warbird_rotorsmoke(param_00)
{
	common_scripts\utility::flag_set("fx_heli_rotorsmoke_start");
}

//Function Number: 20
intro_fly_in_missile_hit_warbird_rotorsmoke_stop(param_00)
{
	common_scripts\utility::flag_set("fx_heli_rotorsmoke_stop");
}

//Function Number: 21
ambient_explosion_before_landing()
{
	level waittill("fly_in_missiles_scene_end");
	maps\_utility::delaythread(6.35,::common_scripts\_exploder::exploder,1111);
	maps\_utility::delaythread(11.25,::common_scripts\_exploder::exploder,1112);
	maps\_utility::delaythread(10.8,::common_scripts\_exploder::exploder,1113);
	maps\_utility::delaythread(12.35,::common_scripts\_exploder::exploder,1114);
	maps\_utility::delaythread(15.2,::common_scripts\_exploder::exploder,1115);
	maps\_utility::delaythread(17.7,::common_scripts\_exploder::exploder,1116);
	maps\_utility::delaythread(20.7,::common_scripts\_exploder::exploder,1117);
	maps\_utility::delaythread(26.5,::common_scripts\_exploder::exploder,1118);
	maps\_utility::delaythread(25.5,::common_scripts\_exploder::exploder,1119);
	maps\_utility::delaythread(26.5,::common_scripts\_exploder::exploder,1120);
	maps\_utility::delaythread(27,::common_scripts\_exploder::exploder,1121);
	maps\_utility::delaythread(27,::maps\_utility::pauseexploder,1119);
	maps\_utility::delaythread(27.75,::maps\_utility::pauseexploder,1120);
	maps\_utility::delaythread(27.75,::maps\_utility::pauseexploder,1121);
}

//Function Number: 22
mobile_turret_landing(param_00)
{
	common_scripts\_exploder::exploder("x4walker_landing");
}

//Function Number: 23
warbird_dropping_mobile_tuerret_camshake()
{
	common_scripts\utility::flag_wait("cam_shake_start");
	self endon("cam_shake_stop");
	var_00 = maps\_shg_fx::get_exploder_ent("x4walker_landing");
	var_01 = var_00.v["origin"];
	var_02 = 0.01;
	var_03 = 0;
	for(;;)
	{
		var_04 = distance2d(var_01,level.player.origin);
		var_05 = 0.2 * clamp(1 - var_04 / 3000,0.01,1) * var_02 / 2;
		var_06 = randomfloat(1) * 8 + 1;
		earthquake(var_05,var_06 / 10,var_01,5000);
		var_02 = clamp(var_02 + var_06 / 20,0.01,2);
		wait(var_06 / 20);
	}
}

//Function Number: 24
ambient_large_pipe_effects_courtyard()
{
	common_scripts\utility::flag_wait("fx_flak_intro");
	common_scripts\_exploder::exploder(1122);
	common_scripts\utility::flag_wait("msg_vfx_zone4_control_room");
	maps\_utility::pauseexploder(1122);
}

//Function Number: 25
ambient_explosion_courtyard()
{
	level endon("flag_walker_tank_on_mount");
	wait(0.75);
	if(level.currentgen)
	{
		var_00 = [(-2135.1,-3698.59,-64),(-738.545,-3005.74,-50),(-795.404,585.719,-64),(-1022.7,902.717,-62.1685),(-1479.69,606.371,-66.4426),(-2218.7,-1756.35,-64),(-1931.62,-1732.27,-72),(-2143.91,-1378.41,-67.8419),(-3106.98,-1156.51,-64.2818),(-1948.84,-3207.7,-60.2125),(-1723.4,-3073.26,-76.9196),(-601.993,-2740.76,73.8904),(-955.833,-2414.59,-72),(-800.89,-372.677,64.125),(-1101.12,-866.911,-72),(-1539.22,-988.012,-72),(-2390.12,356.47,-57.4423),(-2439.9,-660.093,-47.8124),(-1948.8,198.326,-72),(-1099.36,1027.41,-60.2436),(-2129.62,1400.37,-46.2778),(-2170.44,2009.04,-51.2272),(-1196.03,2478.15,-55.2367),(-832.627,-3001.28,-58),(-824.68,-4585.95,-69),(-1874.07,-2645.55,-72)];
	}
	else
	{
		var_00 = [(-2135.1,-3698.59,-64),(-1181.94,-3841.46,-72),(-738.545,-3005.74,-50),(-2049.48,-653.422,-64),(-795.404,585.719,-64),(-1022.7,902.717,-62.1685),(-917.762,761.175,-64),(-1479.69,606.371,-66.4426),(-2464.02,-1118.15,-64),(-2218.7,-1756.35,-64),(-2094.02,-1687.31,-63.8713),(-1931.62,-1732.27,-72),(-1957.58,-1154.64,-75.0965),(-2143.91,-1378.41,-67.8419),(-3387.4,-1368.2,-72),(-3106.98,-1156.51,-64.2818),(-1927.16,-3345.66,-42.5959),(-1948.84,-3207.7,-60.2125),(-1717.67,-3271.47,-94.9994),(-1723.4,-3073.26,-76.9196),(-1307.31,-2911.27,-61),(-601.993,-2740.76,73.8904),(-1038.27,-2213.41,-70.8464),(-955.833,-2414.59,-72),(-800.89,-372.677,64.125),(-1323.77,-1042.5,-61.2828),(-1101.12,-866.911,-72),(-1539.22,-988.012,-72),(-2506.34,669.644,-16.9688),(-2390.12,356.47,-57.4423),(-2194.72,-379.348,-64),(-2439.9,-660.093,-47.8124),(-1253.71,1533.15,-66.6647),(-1948.8,198.326,-72),(-1099.36,1027.41,-60.2436),(-2139.53,1605.81,-47.8953),(-2129.62,1400.37,-46.2778),(-2004.05,1230.47,-71.0872),(-2170.44,2009.04,-51.2272),(-1423.78,2737.93,-41.1722),(-1196.03,2478.15,-55.2367),(-1373.31,2350.54,14.5669),(-832.627,-3001.28,-58),(-2227.74,2582.45,-64),(-824.68,-4585.95,-69),(-750.72,-4358.39,-51),(-1874.07,-2645.55,-72)];
	}

	for(;;)
	{
		common_scripts\utility::flag_wait("msg_vfx_zone2_courtyard");
		if(level.currentgen)
		{
			var_01 = randomfloatrange(2.5,8.5) + 1;
		}
		else
		{
			var_01 = randomfloatrange(0.5,1.5) + 1;
		}

		wait(var_01);
		var_02 = [];
		var_03 = level.player getplayerangles();
		var_04 = vectornormalize(anglestoforward(var_03));
		var_05 = maps\_shg_fx::get_exploder_ent(2011);
		var_06 = -1;
		var_07 = [];
		for(var_08 = 0;var_08 < var_00.size;var_08++)
		{
			if(!isdefined(var_05))
			{
				continue;
			}

			if(distancesquared(level.player.origin,var_00[var_08]) < 262144)
			{
				continue;
			}

			var_09 = vectornormalize(var_00[var_08] - level.player.origin);
			if(vectordot(var_04,var_09) > 0.6)
			{
				var_06 = 1;
				var_07[var_07.size] = var_00[var_08];
				break;
			}
		}

		if(var_06 > 0)
		{
			var_0A = randomint(var_07.size);
			if(isdefined(var_0A))
			{
				var_05.v["origin"] = var_07[var_0A];
				if(isdefined(var_05.v["origin"]) && isdefined(var_05))
				{
					var_0B = 2011;
					ambient_explosion_play(var_07[var_0A],"explo_ambientExp_dirt",var_0B);
				}
			}

			wait(0.75);
		}
	}
}

//Function Number: 26
control_room_door_open_rt(param_00)
{
	common_scripts\_exploder::exploder(2800);
	wait(1.5);
	common_scripts\_exploder::exploder(2801);
}

//Function Number: 27
control_room_door_open_lt(param_00)
{
	common_scripts\_exploder::exploder(2801);
}

//Function Number: 28
vfx_control_room_explo()
{
	common_scripts\utility::flag_wait("control_room_explosion");
	var_00 = common_scripts\utility::getstruct("control_room_door_explosion_fx_org","targetname");
	playfx(common_scripts\utility::getfx("door_explosion"),var_00.origin);
	earthquake(2,0.5,var_00.origin,500);
	thread control_room_interior_vfx_on();
}

//Function Number: 29
control_room_interior_vfx_on()
{
	common_scripts\_exploder::exploder(4005);
}

//Function Number: 30
dust_falling_control_room()
{
	common_scripts\utility::flag_wait("control_room_explosion");
	common_scripts\_exploder::exploder(4010);
}

//Function Number: 31
ambient_gas_explosion_loading_zone()
{
	common_scripts\utility::flag_wait("hangar_enemies");
	common_scripts\utility::flag_waitopen("dialogue_playing");
	common_scripts\_exploder::exploder(5101);
	soundscripts\_snd::snd_message("pressure_explosion",5101);
	common_scripts\_exploder::exploder(5104);
	wait(0.5);
	common_scripts\utility::flag_waitopen("dialogue_playing");
	common_scripts\_exploder::exploder(5102);
	soundscripts\_snd::snd_message("hangar_explo_and_debris_01");
	wait(1);
	common_scripts\_exploder::exploder(5010);
	soundscripts\_snd::snd_message("snd_start_fire_steam");
	common_scripts\utility::flag_waitopen("dialogue_playing");
	common_scripts\_exploder::exploder(5103);
	soundscripts\_snd::snd_message("hangar_explo_and_debris_02",5103);
	common_scripts\utility::flag_wait("msg_vfx_zone7_cooling_tower_explosion");
	maps\_utility::pauseexploder(5010);
}

//Function Number: 32
ambient_explosion_dirt_cooling_towers()
{
	level endon("player_start_cooling_tower");
	if(level.currentgen)
	{
		var_00 = [(8957.59,7017.06,26.9421),(9834.7,8370.35,114.27),(11390,9530.37,-132.036),(9168.17,7216.31,85.8958),(7803.14,7801.35,-8),(10379.7,8239.65,306.156),(10309.8,9759.41,-35.0003),(10449.3,10832.8,-127.599),(10046.7,10779.7,-63.9351)];
	}
	else
	{
		var_00 = [(8957.59,7017.06,26.9421),(9659.96,8226.08,117.914),(9834.7,8370.35,114.27),(10194.9,9516.71,-8),(11390,9530.37,-132.036),(8927.76,6878.92,0.810944),(9168.17,7216.31,85.8958),(8937.92,7296.15,52.2326),(7803.14,7801.35,-8),(10356.8,8449.89,213.607),(10379.7,8239.65,306.156),(10596.6,8707.56,89.2881),(10309.8,9759.41,-35.0003),(10422.3,10575.1,-112.38),(10449.3,10832.8,-127.599),(9950.04,11151.1,-109.244),(10046.7,10779.7,-63.9351)];
	}

	for(;;)
	{
		common_scripts\utility::flag_wait("msg_vfx_zone6_cooling_towers");
		var_01 = randomfloatrange(1.5,3) + 1;
		wait(var_01);
		var_02 = [];
		var_03 = level.player getplayerangles();
		var_04 = vectornormalize(anglestoforward(var_03));
		var_05 = maps\_shg_fx::get_exploder_ent(2011);
		var_06 = -1;
		var_07 = [];
		for(var_08 = 0;var_08 < var_00.size;var_08++)
		{
			if(!isdefined(var_05))
			{
				continue;
			}

			if(distancesquared(level.player.origin,var_00[var_08]) < 262144)
			{
				continue;
			}

			var_09 = vectornormalize(var_00[var_08] - level.player.origin);
			if(vectordot(var_04,var_09) > 0.6)
			{
				var_06 = 1;
				var_07[var_07.size] = var_00[var_08];
				break;
			}
		}

		if(var_06 > 0)
		{
			var_0A = randomint(var_07.size);
			if(isdefined(var_0A))
			{
				var_05.v["origin"] = var_07[var_0A];
				if(isdefined(var_05.v["origin"]) && isdefined(var_05))
				{
					var_0B = 2011;
					ambient_explosion_play(var_07[var_0A],"explo_ambientExp_dirt",var_0B);
				}
			}

			wait(0.75);
		}
	}
}

//Function Number: 33
ambient_explosion_fireball_cooling_towers()
{
	level endon("player_start_cooling_tower");
	var_00 = [(7266.51,7360.84,-87.284),(9549.09,6211.15,5.91302),(8878.34,6721.48,-8),(10943.5,10231.7,-136),(10507.7,10992.2,-136),(10252.2,10559.4,-35.253),(10329,9553.58,-21.2638)];
	for(;;)
	{
		common_scripts\utility::flag_wait("msg_vfx_zone6_cooling_towers");
		var_01 = randomfloatrange(3,5) + 1;
		wait(var_01);
		var_02 = [];
		var_03 = level.player getplayerangles();
		var_04 = vectornormalize(anglestoforward(var_03));
		var_05 = maps\_shg_fx::get_exploder_ent(1111);
		var_06 = -1;
		var_07 = [];
		for(var_08 = 0;var_08 < var_00.size;var_08++)
		{
			if(!isdefined(var_05))
			{
				continue;
			}

			if(distancesquared(level.player.origin,var_00[var_08]) < 262144)
			{
				continue;
			}

			var_09 = vectornormalize(var_00[var_08] - level.player.origin);
			if(vectordot(var_04,var_09) > 0.6)
			{
				var_06 = 1;
				var_07[var_07.size] = var_00[var_08];
				break;
			}
		}

		if(var_06 > 0)
		{
			var_0A = randomint(var_07.size);
			if(isdefined(var_0A))
			{
				var_05.v["origin"] = var_07[var_0A];
				if(isdefined(var_05.v["origin"]) && isdefined(var_05))
				{
					var_0B = 1111;
					ambient_explosion_play(var_07[var_0A],"explo_ambientExp_fireball",var_0B);
				}
			}

			wait(0.75);
		}
	}
}

//Function Number: 34
ambient_explosion_play(param_00,param_01,param_02)
{
	switch(param_01)
	{
		case "explo_ambientExp_dirt":
			if(distance(param_00,level.player.origin) < 1800)
			{
				common_scripts\utility::flag_waitopen("dialogue_playing");
			}
	
			soundscripts\_snd::snd_message(param_01,param_00,param_02);
			break;

		case "explo_ambientExp_fireball":
			common_scripts\_exploder::exploder(param_02);
			soundscripts\_snd::snd_message(param_01,param_00);
			break;

		default:
			break;
	}
}

//Function Number: 35
warbird_hoverdust()
{
	common_scripts\utility::flag_wait("fx_flak_intro");
	stopfxontag(common_scripts\utility::getfx("fast_blowing_dust"),level.warbird_a,"TAG_outside_door");
	common_scripts\utility::flag_wait("fx_warbird_hoverdust");
	common_scripts\_exploder::exploder(1090);
	common_scripts\utility::flag_waitopen("fx_warbird_hoverdust");
	wait(8.5);
	maps\_utility::stop_exploder(1090);
}

//Function Number: 36
vfx_zipgun_fire(param_00)
{
	playfxontag(common_scripts\utility::getfx("harpoon_dust"),param_00,"jnt_harpoon");
	playfxontag(common_scripts\utility::getfx("zipline_flash_view"),param_00,"TAG_FLASH");
}

//Function Number: 37
kill_exterior_vfx()
{
	common_scripts\utility::flag_wait("msg_vfx_zone3_lab_room_section_1");
	thread stop_smoke_pillar_black_large_fast_fx();
	thread stop_smoke_pillar_gray_large_fast_fx();
	thread stop_smoke_pillar_black_large_slow_fx();
	foreach(var_01 in level.createfxent)
	{
		if(var_01.v["fxid"] == "fog_distant_vista" || var_01.v["type"] == "oneshotfx")
		{
			var_01 common_scripts\utility::pauseeffect();
		}
	}
}

//Function Number: 38
fx_elevator_descent_burke(param_00)
{
	common_scripts\_exploder::exploder(3350);
	playfxontag(common_scripts\utility::getfx("elevator_burke_slide_dust"),param_00,"j_wrist_le");
}

//Function Number: 39
reactor_light_rays()
{
	if(level.nextgen)
	{
		common_scripts\utility::flag_wait("reactor_light_rays");
		maps\_utility::pauseexploder(3302);
		maps\_utility::pauseexploder(3303);
		maps\_utility::pauseexploder(3304);
	}
}

//Function Number: 40
restart_exterior_vfx()
{
	common_scripts\utility::flag_wait("msg_vfx_zone4_control_room");
	thread start_smoke_pillar_black_large_fast_fx();
	thread start_smoke_pillar_gray_large_fast_fx();
	thread start_smoke_pillar_black_large_slow_fx();
}

//Function Number: 41
big_pipe_explosion_vfx_after_hangar()
{
	if(level.nextgen)
	{
		thread maps\fusion_lighting::enable_motion_blur_cooling_tower_explosions();
	}

	common_scripts\_exploder::exploder(6500);
	soundscripts\_snd::snd_message("pressure_explosion",6500);
	level.player playrumbleonentity("damage_heavy");
	earthquake(0.4,1,level.player.origin,200);
	wait(0.75);
	common_scripts\_exploder::exploder(6501);
	wait(0.15);
	common_scripts\_exploder::exploder(6502);
	common_scripts\_exploder::exploder(6503);
}

//Function Number: 42
underground_pipe_explosion_utility_truck_vfx(param_00)
{
	if(level.nextgen)
	{
		thread maps\fusion_lighting::enable_motion_blur_cooling_tower_explosions();
	}

	common_scripts\_exploder::exploder(6510);
	var_01 = 6510;
	common_scripts\utility::flag_set("cooling_tower_cart_explosion_lighting");
	level.player playrumbleonentity("damage_heavy");
	earthquake(0.55,1,level.player.origin,200);
	soundscripts\_snd::snd_message("fus_truck_flip_01",var_01);
	playfxontag(common_scripts\utility::getfx("trail_steam_round_lrg_runner"),self,"tag_origin");
	playfxontag(common_scripts\utility::getfx("trail_spark_burst_explosion"),self,"tag_origin");
	common_scripts\_exploder::exploder(6512);
	wait(1.75);
	common_scripts\_exploder::exploder(6511);
}

//Function Number: 43
underground_pipe_explosion_pickup_truck_vfx(param_00)
{
	if(level.nextgen)
	{
		thread maps\fusion_lighting::enable_motion_blur_cooling_tower_explosions();
	}

	common_scripts\_exploder::exploder(6520);
	var_01 = 6520;
	level.player playrumbleonentity("damage_heavy");
	earthquake(1,1,level.player.origin,200);
	soundscripts\_snd::snd_message("fus_truck_flip_02",var_01);
	playfxontag(common_scripts\utility::getfx("trail_steam_round_lrg_runner"),self,"tag_origin");
	common_scripts\_exploder::exploder(6522);
	wait(2.65);
	common_scripts\_exploder::exploder(6521);
}

//Function Number: 44
init_smvals()
{
	setsaveddvar("fx_alphathreshold",5);
	level waittill("big_moment_vfx_start");
	setsaveddvar("fx_alphathreshold",12);
}

//Function Number: 45
kill_all_env_fx()
{
	level waittill("big_moment_vfx_start");
	foreach(var_01 in level.createfxent)
	{
		if(var_01.v["type"] == "oneshotfx" || var_01.v["type"] == "exploder")
		{
			var_01 common_scripts\utility::pauseeffect();
		}
	}
}

//Function Number: 46
pressure_explosion_lead_up()
{
	maps\_utility::delaythread(0.05,::pressure_explosion_leadup_1);
	maps\_utility::delaythread(0.4,::pressure_explosion_leadup_4);
	maps\_utility::delaythread(0.75,::pressure_explosion_leadup_5);
	maps\_utility::delaythread(0.8,::pressure_explosion_leadup_6);
	maps\_utility::delaythread(0.95,::pressure_explosion_leadup_7);
	maps\_utility::delaythread(0.85,::big_moment_ending_vfx_tower_initial_crack);
}

//Function Number: 47
pressure_explosion_leadup_1()
{
	common_scripts\_exploder::exploder(7001);
	soundscripts\_snd::snd_message("pressure_explosion",7001);
	level.player playrumbleonentity("damage_heavy");
	earthquake(0.3,0.5,level.player.origin,500);
}

//Function Number: 48
pressure_explosion_leadup_2()
{
	common_scripts\_exploder::exploder(7002);
	soundscripts\_snd::snd_message("pressure_explosion",7002);
	level.player playrumbleonentity("damage_heavy");
	earthquake(0.3,0.5,level.player.origin,500);
}

//Function Number: 49
pressure_explosion_leadup_3()
{
	common_scripts\_exploder::exploder(7003);
	soundscripts\_snd::snd_message("pressure_explosion",7003);
	level.player playrumbleonentity("damage_heavy");
	earthquake(0.3,0.5,level.player.origin,500);
}

//Function Number: 50
pressure_explosion_leadup_4()
{
	common_scripts\_exploder::exploder(7004);
	soundscripts\_snd::snd_message("pressure_explosion",7004);
	level.player playrumbleonentity("damage_heavy");
	earthquake(0.3,0.5,level.player.origin,500);
}

//Function Number: 51
pressure_explosion_leadup_5()
{
	common_scripts\_exploder::exploder(7005);
	soundscripts\_snd::snd_message("pressure_explosion",7005);
	level.player playrumbleonentity("damage_heavy");
	earthquake(0.3,0.5,level.player.origin,500);
}

//Function Number: 52
pressure_explosion_leadup_6()
{
	common_scripts\_exploder::exploder(7006);
	soundscripts\_snd::snd_message("pressure_explosion",7006);
	level.player playrumbleonentity("damage_heavy");
	earthquake(0.3,0.5,level.player.origin,500);
}

//Function Number: 53
pressure_explosion_leadup_7()
{
	common_scripts\_exploder::exploder(7007);
	soundscripts\_snd::snd_message("pressure_explosion",7007);
	level.player playrumbleonentity("damage_heavy");
	earthquake(0.3,0.5,level.player.origin,500);
}

//Function Number: 54
big_moment_ending_vfx_tower_initial_crack()
{
	common_scripts\_exploder::exploder(7100);
}

//Function Number: 55
big_moment_ending_vfx(param_00)
{
	level notify("big_moment_vfx_start");
	maps\_utility::delaythread(0.05,::big_moment_ending_vfx_shockwave);
	maps\_utility::delaythread(0.1,::big_moment_ending_vfx_ground_buckling);
	maps\_utility::delaythread(1.75,::big_moment_ending_vfx_tower_explode);
	maps\_utility::delaythread(0.1,::big_moment_ending_vfx_trailing_dust,param_00);
	maps\_utility::delaythread(1,::big_moment_ending_vfx_tower_smoke_up);
	maps\_utility::delaythread(0.7,::big_moment_ending_vfx_ground_splinter_up);
	maps\_utility::delaythread(0.3,::big_moment_ending_vfx_falling_rock);
	maps\_utility::delaythread(1,::big_moment_ending_vfx_ash_fall);
	maps\_utility::delaythread(1,::big_moment_ending_vfx_rolling_smk);
	maps\_utility::delaythread(2,::big_moment_ending_vfx_thick_smk_vm);
	maps\_utility::delaythread(22,::big_moment_ending_vfx_falling_debris);
	maps\_utility::delaythread(26,::big_moment_ending_vfx_bouncing_rocks);
	maps\_utility::delaythread(6.3,::big_moment_ending_vfx_falling_debris_tower);
	maps\_utility::delaythread(6.7,::big_moment_ending_vfx_tower_pillar_left_burst);
	maps\_utility::delaythread(8.5,::big_moment_ending_vfx_tower_pillar_right_burst);
	maps\_utility::delaythread(10.5,::big_moment_ending_vfx_tower_middle_top_burst);
	maps\_utility::delaythread(13.5,::big_moment_ending_vfx_tower_top_left_burst);
	maps\_utility::delaythread(14.15,::big_moment_ending_vfx_tower_lower_left_burst);
	maps\_utility::delaythread(10.25,::big_moment_ending_vfx_tower_lower_right_burst);
	maps\_utility::delaythread(7.2,::big_moment_ending_vfx_tower_chunk_trailing_smk,param_00);
	maps\_utility::delaythread(6.1,::big_moment_ending_vfx_tower_fall_camshake);
	maps\_utility::delaythread(16.5,::big_moment_ending_vfx_tower_base_smk_looping);
	maps\_utility::delaythread(13.5,::big_moment_ending_vfx_tower_smoke_up_tall);
}

//Function Number: 56
big_moment_ending_vfx_shockwave()
{
	earthquake(0.2,0.2,level.player.origin,1000);
	common_scripts\_exploder::exploder(7101);
}

//Function Number: 57
big_moment_ending_vfx_ground_buckling()
{
	common_scripts\_exploder::exploder(7102);
	earthquake(0.9,0.2,level.player.origin,1000);
	wait(0.2);
	earthquake(0.4,0.2,level.player.origin,1000);
	wait(0.2);
	earthquake(0.15,5,level.player.origin,1000);
}

//Function Number: 58
big_moment_ending_vfx_tower_explode()
{
	common_scripts\_exploder::exploder(7103);
	earthquake(0.3,0.5,level.player.origin,1000);
	wait(0.5);
}

//Function Number: 59
big_moment_ending_vfx_trailing_dust(param_00)
{
	playfxontag(common_scripts\utility::getfx("fusion_end_smk_lrg_emit"),param_00["street"],"jo_street_shattered_37");
	playfxontag(common_scripts\utility::getfx("fusion_end_smk_emit"),param_00["street"],"jo_street_shattered_34");
	playfxontag(common_scripts\utility::getfx("fusion_end_smk_emit"),param_00["street"],"jo_street_shattered_35");
	playfxontag(common_scripts\utility::getfx("fusion_end_smk_lrg_emit"),param_00["street"],"jo_street_shattered_63");
	wait(0.05);
	playfxontag(common_scripts\utility::getfx("fusion_end_smk_lrg_emit"),param_00["street"],"jo_street_shattered_98");
	playfxontag(common_scripts\utility::getfx("fusion_end_smk_lrg_emit"),param_00["street"],"jo_street_shattered_44");
	playfxontag(common_scripts\utility::getfx("fusion_end_smk_emit"),param_00["street"],"jo_street_shattered_59");
	playfxontag(common_scripts\utility::getfx("fusion_end_smk_lrg_emit"),param_00["street"],"jo_street_shattered_69");
	wait(0.05);
	playfxontag(common_scripts\utility::getfx("fusion_end_smk_emit"),param_00["street"],"jo_street_shattered_70");
	playfxontag(common_scripts\utility::getfx("fusion_end_smk_emit"),param_00["street"],"jo_street_shattered_43");
	playfxontag(common_scripts\utility::getfx("fusion_end_smk_emit"),param_00["street"],"jo_street_shattered_14");
	playfxontag(common_scripts\utility::getfx("fusion_end_smk_lrg_emit"),param_00["street"],"jo_street_shattered_47");
	wait(0.05);
	playfxontag(common_scripts\utility::getfx("fusion_end_smk_lrg_emit"),param_00["street"],"jo_street_shattered_67");
	playfxontag(common_scripts\utility::getfx("fusion_end_smk_lrg_emit"),param_00["street"],"jo_street_shattered_55");
	playfxontag(common_scripts\utility::getfx("fusion_end_smk_lrg_emit"),param_00["street"],"jo_street_shattered_45");
	playfxontag(common_scripts\utility::getfx("fusion_end_smk_lrg_emit"),param_00["street"],"jo_street_shattered_37");
	wait(0.05);
	playfxontag(common_scripts\utility::getfx("fusion_end_smk_lrg_emit"),param_00["street"],"jo_street_shattered_84");
	playfxontag(common_scripts\utility::getfx("fusion_end_smk_lrg_emit"),param_00["street"],"jo_street_shattered_97");
	playfxontag(common_scripts\utility::getfx("fusion_end_smk_lrg_emit"),param_00["street"],"jo_street_shattered_60");
	playfxontag(common_scripts\utility::getfx("fusion_end_smk_lrg_emit"),param_00["street"],"jo_street_shattered_46");
	wait(0.05);
	playfxontag(common_scripts\utility::getfx("fusion_end_smk_lrg_emit"),param_00["street"],"jo_street_shattered_48");
	playfxontag(common_scripts\utility::getfx("fusion_end_smk_emit"),param_00["concrete_shattered"],"jo_concrete_shattered_piece_20");
	playfxontag(common_scripts\utility::getfx("fusion_end_smk_emit"),param_00["concrete_shattered"],"jo_concrete_shattered_piece_21");
	playfxontag(common_scripts\utility::getfx("fusion_end_smk_lrg_emit"),param_00["concrete_shattered"],"jo_concrete_shattered_piece_18");
	wait(0.05);
	playfxontag(common_scripts\utility::getfx("fusion_end_smk_emit"),param_00["concrete_shattered"],"jo_concrete_shattered_piece_8");
	wait(1);
	playfxontag(common_scripts\utility::getfx("fusion_end_smk_med_emit"),param_00["chunks"],"jo_lower_front_panel_section_4");
	playfxontag(common_scripts\utility::getfx("fusion_end_smk_med_emit"),param_00["chunks"],"jo_lower_front_panel_section_5");
}

//Function Number: 60
big_moment_ending_vfx_tower_smoke_up()
{
	common_scripts\_exploder::exploder(7104);
}

//Function Number: 61
big_moment_ending_vfx_tower_smoke_up_tall()
{
	maps\_utility::stop_exploder(7104);
	common_scripts\_exploder::exploder(7401);
}

//Function Number: 62
big_moment_ending_vfx_donut_smk()
{
	common_scripts\_exploder::exploder(7105);
}

//Function Number: 63
big_moment_ending_vfx_ground_splinter_up()
{
	common_scripts\_exploder::exploder(7106);
	wait(0.1);
	common_scripts\_exploder::exploder(7108);
	wait(0.15);
	common_scripts\_exploder::exploder(7109);
	wait(0.15);
	common_scripts\_exploder::exploder(7110);
	wait(0.15);
	common_scripts\_exploder::exploder(7111);
	wait(0.2);
	common_scripts\_exploder::exploder(7112);
}

//Function Number: 64
big_moment_ending_vfx_falling_rock()
{
	common_scripts\_exploder::exploder(7201);
}

//Function Number: 65
big_moment_ending_vfx_ash_fall()
{
	common_scripts\_exploder::exploder(7202);
}

//Function Number: 66
big_moment_ending_vfx_rolling_smk()
{
	common_scripts\_exploder::exploder(7203);
	wait(3);
	common_scripts\_exploder::exploder(7204);
	wait(0.5);
	maps\_utility::stop_exploder(7203);
	wait(12.6);
	common_scripts\_exploder::exploder(7211);
	maps\_utility::stop_exploder(7204);
	wait(5);
	common_scripts\_exploder::exploder(7204);
	wait(9.25);
	common_scripts\_exploder::exploder(7299);
	maps\_utility::stop_exploder(7204);
	thread big_moment_ending_vfx_warbird_dust();
}

//Function Number: 67
big_moment_ending_vfx_thick_smk_vm()
{
	var_00 = spawn("script_model",level.player.origin);
	var_00 setmodel("tag_origin");
	var_00 linkto(level.player);
	playfxontag(common_scripts\utility::getfx("fusion_end_thick_smk_vm"),var_00,"tag_origin");
	wait(4.5);
	stopfxontag(common_scripts\utility::getfx("fusion_end_thick_smk_vm"),var_00,"tag_origin");
	wait(11.5);
	playfxontag(common_scripts\utility::getfx("fusion_end_thick_smk_vm"),var_00,"tag_origin");
	wait(3);
	stopfxontag(common_scripts\utility::getfx("fusion_end_thick_smk_vm"),var_00,"tag_origin");
	var_00 delete();
}

//Function Number: 68
big_moment_ending_vfx_falling_debris()
{
	common_scripts\_exploder::exploder(7205);
	wait(8);
	common_scripts\_exploder::exploder(7206);
}

//Function Number: 69
big_moment_ending_vfx_bouncing_rocks()
{
	common_scripts\_exploder::exploder(7209);
}

//Function Number: 70
big_moment_ending_vfx_falling_debris_tower()
{
	common_scripts\_exploder::exploder(7207);
	wait(5);
	common_scripts\_exploder::exploder(7208);
}

//Function Number: 71
big_moment_ending_vfx_tower_pillar_left_burst()
{
	common_scripts\_exploder::exploder(7300);
	wait(3.6);
	common_scripts\_exploder::exploder(7402);
}

//Function Number: 72
big_moment_ending_vfx_tower_pillar_right_burst()
{
	common_scripts\_exploder::exploder(7301);
}

//Function Number: 73
big_moment_ending_vfx_tower_middle_top_burst()
{
	common_scripts\_exploder::exploder(7302);
}

//Function Number: 74
big_moment_ending_vfx_tower_top_left_burst()
{
	common_scripts\_exploder::exploder(7303);
}

//Function Number: 75
big_moment_ending_vfx_tower_lower_left_burst()
{
	common_scripts\_exploder::exploder(7304);
}

//Function Number: 76
big_moment_ending_vfx_tower_lower_right_burst()
{
	common_scripts\_exploder::exploder(7305);
}

//Function Number: 77
big_moment_ending_vfx_tower_base_smk_looping()
{
	common_scripts\_exploder::exploder(7400);
}

//Function Number: 78
big_moment_ending_vfx_tower_chunk_trailing_smk(param_00)
{
	playfxontag(common_scripts\utility::getfx("fusion_end_smk_xlrg_emit"),param_00["concrete_shattered"],"jo_concrete_shattered_piece_37a");
	playfxontag(common_scripts\utility::getfx("fusion_end_smk_xlrg_emit"),param_00["concrete_shattered2"],"jo_concrete_shattered_piece_60c");
	wait(2.7);
	playfxontag(common_scripts\utility::getfx("fusion_end_smk_xlrg_emit"),param_00["concrete_shattered"],"jo_concrete_shattered_piece_43a");
	playfxontag(common_scripts\utility::getfx("fusion_end_smk_xlrg_emit"),param_00["concrete_shattered2"],"jo_concrete_shattered_piece_68");
	wait(1);
	playfxontag(common_scripts\utility::getfx("fusion_end_smk_xlrg_emit"),param_00["concrete_shattered"],"jo_concrete_shattered_piece_35");
	playfxontag(common_scripts\utility::getfx("fusion_end_smk_xxlrg_emit"),param_00["concrete_shattered"],"jo_concrete_shattered_piece_36");
	playfxontag(common_scripts\utility::getfx("fusion_end_smk_xlrg_emit"),param_00["concrete_shattered"],"jo_concrete_shattered_piece_36a");
	wait(2.55);
	playfxontag(common_scripts\utility::getfx("fusion_end_smk_xlrg_emit"),param_00["concrete_shattered"],"jo_concrete_shattered_piece_37");
	playfxontag(common_scripts\utility::getfx("fusion_end_smk_xlrg_emit"),param_00["concrete_shattered"],"jo_concrete_shattered_piece_38a");
	playfxontag(common_scripts\utility::getfx("fusion_end_smk_xlrg_emit"),param_00["concrete_shattered"],"jo_concrete_shattered_piece_38b");
	playfxontag(common_scripts\utility::getfx("fusion_end_smk_xlrg_emit"),param_00["concrete_shattered2"],"jo_concrete_shattered_piece_73a");
	playfxontag(common_scripts\utility::getfx("fusion_end_smk_xlrg_emit"),param_00["concrete_shattered"],"jo_concrete_shattered_piece_37c");
	wait(0.25);
	playfxontag(common_scripts\utility::getfx("fusion_end_smk_xlrg_emit"),param_00["concrete_shattered2"],"jo_concrete_shattered_piece_72");
}

//Function Number: 79
big_moment_ending_vfx_tower_fall_camshake()
{
	earthquake(0.15,3.2,level.player.origin,1000);
	wait(3.1);
	earthquake(0.3,4.8,level.player.origin,1000);
	common_scripts\_exploder::exploder(7403);
	wait(4.7);
	earthquake(0.4,3,level.player.origin,1000);
	common_scripts\_exploder::exploder(7404);
	wait(2.9);
	earthquake(0.6,2.2,level.player.origin,1000);
	common_scripts\_exploder::exploder(7405);
}

//Function Number: 80
big_moment_ending_vfx_warbird_dust()
{
	common_scripts\_exploder::exploder("outro_warbird_dust");
}

//Function Number: 81
set_guy_on_fire()
{
	var_00 = spawnstruct();
	var_00.v["ent"] = self;
	var_00.v["fx"] = common_scripts\utility::getfx("fire_smoke_trail_verysmall");
	var_00.v["chain"] = "all";
	var_01 = 0.04;
	if(level.currentgen)
	{
		var_01 = 0.2;
	}

	var_00.v["looptime"] = var_01;
	maps\_shg_fx::play_fx_on_actor(var_00);
	if(level.nextgen)
	{
		level waittill("street_cleanup");
	}
	else
	{
		level waittill("tff_pre_transition_intro_to_middle");
	}

	level notify(self.model + "kill_fx_onactor");
}

//Function Number: 82
walker_dying_fx()
{
	common_scripts\utility::flag_set("walker_death_anim_started");
	self endon("death");
	for(var_00 = 0;var_00 < 37;var_00++)
	{
		playfxontag(common_scripts\utility::getfx("walker_tank_dying_fire_small"),self,"tag_fire");
		wait(0.1);
	}

	stopfxontag(common_scripts\utility::getfx("vehicle_damaged_sparks_l"),self,"TAG_SPARKS1");
	stopfxontag(common_scripts\utility::getfx("vehicle_damaged_sparks_l"),self,"TAG_SPARKS2");
	stopfxontag(common_scripts\utility::getfx("vehicle_damaged_sparks_l"),self,"TAG_SPARKS3");
	stopfxontag(common_scripts\utility::getfx("vehicle_damaged_sparks_l"),self,"TAG_SPARKS4");
	for(;;)
	{
		playfxontag(common_scripts\utility::getfx("walker_tank_dying_fire"),self,"tag_fire");
		wait(0.1);
	}
}

//Function Number: 83
walker_tank_footstep_left(param_00)
{
	playfxontag(common_scripts\utility::getfx("walker_footstep"),param_00,"frontWheelTread01_FL");
}

//Function Number: 84
walker_tank_footstep_right(param_00)
{
	playfxontag(common_scripts\utility::getfx("walker_footstep"),param_00,"frontWheelTread01_FR");
}

//Function Number: 85
walker_tank_footstep_left_rear(param_00)
{
	playfxontag(common_scripts\utility::getfx("walker_footstep"),param_00,"frontWheelTread05_KL");
}

//Function Number: 86
walker_tank_footstep_right_rear(param_00)
{
	playfxontag(common_scripts\utility::getfx("walker_footstep"),param_00,"frontWheelTread05_KR");
}

//Function Number: 87
start_smoke_pillar_black_large_fast_fx()
{
	if(level.currentgen)
	{
		var_00 = [(-1066.52,29042.7,3254.14),(13777.4,45770.1,2900.88)];
		var_01 = [(300,24,-90),(323.204,3.74876,84.8169)];
	}
	else
	{
		var_00 = [(-1066.52,29042.7,3254.14),(18709.6,32551.6,1771.69),(13777.4,45770.1,2900.88),(24840.4,25515.1,3500.52)];
		var_01 = [(300,24,-90),(286,26,-90),(323.204,3.74876,84.8169),(294.312,29.0954,-80.2449)];
	}

	level.smokepillar1 = [];
	for(var_02 = 0;var_02 < var_00.size;var_02++)
	{
		var_03 = anglestoforward(var_01[var_02]);
		var_04 = anglestoup(var_01[var_02]);
		level.smokepillar1[level.smokepillar1.size] = spawnfx(common_scripts\utility::getfx("smoke_pillar_black_large_fast"),var_00[var_02],var_03,var_04);
	}

	foreach(var_06 in level.smokepillar1)
	{
		triggerfx(var_06,55);
	}
}

//Function Number: 88
stop_smoke_pillar_black_large_fast_fx()
{
	foreach(var_01 in level.smokepillar1)
	{
		var_01 delete();
	}
}

//Function Number: 89
start_smoke_pillar_gray_large_fast_fx()
{
	var_00 = [(7442.65,34328.6,3101.13)];
	var_01 = [(294.312,29.0954,-80.2449)];
	level.smokepillar2 = [];
	for(var_02 = 0;var_02 < var_00.size;var_02++)
	{
		var_03 = anglestoforward(var_01[var_02]);
		var_04 = anglestoup(var_01[var_02]);
		level.smokepillar2[level.smokepillar2.size] = spawnfx(common_scripts\utility::getfx("smoke_pillar_gray_large_fast"),var_00[var_02],var_03,var_04);
	}

	foreach(var_06 in level.smokepillar2)
	{
		triggerfx(var_06,55);
	}
}

//Function Number: 90
stop_smoke_pillar_gray_large_fast_fx()
{
	foreach(var_01 in level.smokepillar2)
	{
		var_01 delete();
	}
}

//Function Number: 91
start_smoke_pillar_black_large_slow_fx()
{
	if(level.currentgen)
	{
		var_00 = [(5331.64,27346.8,2860.05)];
		var_01 = [(294,26,-90)];
	}
	else
	{
		var_00 = [(5331.64,27346.8,2860.05),(26342.9,15259.3,1438.33)];
		var_01 = [(294,26,-90),(294.312,29.0954,-168.245)];
	}

	level.smokepillar3 = [];
	for(var_02 = 0;var_02 < var_00.size;var_02++)
	{
		var_03 = anglestoforward(var_01[var_02]);
		var_04 = anglestoup(var_01[var_02]);
		level.smokepillar3[level.smokepillar3.size] = spawnfx(common_scripts\utility::getfx("smoke_pillar_black_large_slow"),var_00[var_02],var_03,var_04);
	}

	foreach(var_06 in level.smokepillar3)
	{
		triggerfx(var_06,55);
	}
}

//Function Number: 92
stop_smoke_pillar_black_large_slow_fx()
{
	foreach(var_01 in level.smokepillar3)
	{
		var_01 delete();
	}
}