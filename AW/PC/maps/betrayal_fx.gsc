/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: betrayal_fx.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 55
 * Decompile Time: 824 ms
 * Timestamp: 4/22/2024 2:25:35 AM
*******************************************************************/

//Function Number: 1
main()
{
	precachefx();
	maps\createfx\betrayal_fx::main();
	maps\_shg_fx::setup_shg_fx();
	common_scripts\utility::flag_init("fx_setup_tree_birds");
	common_scripts\utility::flag_init("fx_tree_birds_flee");
	common_scripts\utility::flag_init("explode_flash");
	common_scripts\utility::flag_init("vfx_pipe_burst");
	common_scripts\utility::flag_init("kill_blood_fx");
	common_scripts\utility::flag_init("fx_roof_drones");
	common_scripts\utility::flag_init("kill_underwater_fx");
	common_scripts\utility::flag_init("bullet_trails_01");
	common_scripts\utility::flag_init("bullet_trails_02");
	common_scripts\utility::flag_init("bullet_trails_03");
	common_scripts\utility::flag_init("bullet_trails_04");
	common_scripts\utility::flag_init("bullet_trails_05");
	common_scripts\utility::flag_init("bullet_trails_06");
	common_scripts\utility::flag_init("bullet_trails_07");
	common_scripts\utility::flag_init("fx_shadow_birds");
	common_scripts\utility::flag_init("fx_window_birds_flee");
	thread maps\_shg_fx::fx_zone_watcher(1000,"msg_vfx_zone_1000_building_lobby","msg_vfx_zone_1000_roof_to_courtyard");
	thread maps\_shg_fx::fx_zone_watcher(1100,"msg_vfx_zone_1100_building_stairwell");
	thread maps\_shg_fx::fx_zone_watcher(2000,"msg_vfx_zone_2000_building_confrontation");
	thread maps\_shg_fx::fx_zone_watcher(3000,"msg_vfx_zone_3000_building_roof");
	thread maps\_shg_fx::fx_zone_watcher(4000,"msg_vfx_zone_4000_escape_slide","msg_vfx_zone_4000_escape_swim");
	thread maps\_shg_fx::fx_zone_watcher(4050,"msg_fx_zone_4050_sewer_transition_exit");
	thread maps\_shg_fx::fx_zone_watcher(5000,"msg_vfx_zone_5000_old_town_freerun");
	thread maps\_shg_fx::fx_zone_watcher(5100,"msg_vfx_zone_5100_old_town_drone_run");
	thread maps\_shg_fx::fx_zone_watcher(5200,"msg_vfx_zone_5200_old_town_docks");
	thread maps\_shg_fx::fx_zone_watcher(6000,"msg_vfx_zone_6000_boat_chase_start");
	thread maps\_shg_fx::fx_zone_watcher(6100,"msg_vfx_zone_6100_boat_chase_jump");
	thread maps\_shg_fx::fx_zone_watcher(6200,"msg_vfx_zone_6200_boat_chase_after_jump");
	thread maps\_shg_fx::fx_zone_watcher(7000,"msg_vfx_zone_7000_climb_floor1");
	thread maps\_shg_fx::fx_zone_watcher(7100,"msg_vfx_zone_7100_climb_floor2");
	thread maps\_shg_fx::fx_zone_watcher(7200,"msg_vfx_zone_7200_climb_finale");
	thread intro_birds();
	thread escape_hallway_steam();
	thread canal_underwater_bullet_trails();
	thread bird_shadow_after_sewer();
	thread birds_after_sewer();
}

//Function Number: 2
precachefx()
{
	level._effect["fire_lp_smk_s"] = loadfx("vfx/fire/fire_lp_smk_s");
	level._effect["leaves_small_fall_gentlewind"] = loadfx("vfx/wind/leaves_small_fall_gentlewind_far");
	level._effect["paper_scrap_windblown_runner_light_slw"] = loadfx("vfx/wind/paper_scrap_windblown_runner_light_slw");
	level._effect["dust_wind_blowing_ledge_rnr"] = loadfx("vfx/dust/dust_wind_blowing_ledge_rnr");
	level._effect["dust_wind_blowing_window_rnr"] = loadfx("vfx/dust/dust_wind_blowing_window_rnr");
	level._effect["dust_wind_blowing_fast_rnr"] = loadfx("vfx/dust/dust_wind_blowing_fast_rnr");
	level._effect["boat_explosion"] = loadfx("vfx/explosion/vehicle_civ_boat_explosion");
	level._effect["vehicle_boat_explo_underwater"] = loadfx("vfx/explosion/vehicle_boat_explosion_underwater");
	level._effect["boat_explosion_underwater"] = loadfx("vfx/explosion/ambient_explosion_underwater");
	level._effect["flashbang_no_model"] = loadfx("vfx/explosion/flashbang_no_model");
	level._effect["bet_irons_pistol_flash"] = loadfx("vfx/map/betrayal/bet_irons_pistol_flash");
	level._effect["bet_con_gun_shot_blood"] = loadfx("vfx/map/betrayal/bet_con_gun_shot_blood");
	level._effect["blood_drip_impact_med_oriented"] = loadfx("vfx/blood/blood_drip_impact_med_oriented");
	level._effect["blood_floor_impact_lrg_oriented"] = loadfx("vfx/blood/blood_floor_impact_lrg_oriented");
	level._effect["windows_hazy"] = loadfx("vfx/map/betrayal/windows_hazy");
	level._effect["low_dust_ambient_lp"] = loadfx("vfx/dust/low_dust_ambient_lp");
	level._effect["heat_distortion_l"] = loadfx("vfx/distortion/heat_distortion_l");
	level._effect["trash_tornado_s_runner"] = loadfx("vfx/wind/trash_tornado_s_runner");
	level._effect["dust_particles_sml"] = loadfx("vfx/dust/dust_particles_sml");
	level._effect["amb_dust_indoor_slw_light_lp"] = loadfx("vfx/dust/amb_dust_indoor_slw_light_lp");
	level._effect["amb_dust_indoor_slw_lp"] = loadfx("vfx/dust/amb_dust_indoor_slw_lp");
	level._effect["low_dust_wave"] = loadfx("vfx/dust/dust_low_wave_freq_runner");
	level._effect["lag_fence_dust_falling"] = loadfx("vfx/map/lagos/lag_fence_dust_falling_rotate");
	level._effect["dust_boat_impact_ground_underwater"] = loadfx("vfx/dust/dust_boat_impact_ground_underwater");
	level._effect["steam_vent_burst_lp"] = loadfx("vfx/steam/steam_vent_burst_lrg_01_lp");
	level._effect["leaves_floating_water"] = loadfx("vfx/water/leaves_floating_water");
	level._effect["fog_ambient_low"] = loadfx("vfx/fog/fog_ambient_low");
	level._effect["bet_gideon_scanner_beam"] = loadfx("vfx/map/betrayal/bet_gideon_scanner_beam");
	level._effect["bet_steam_vent_burst_spray"] = loadfx("vfx/map/betrayal/bet_steam_vent_burst_spray");
	level._effect["smk_burst_door_shut"] = loadfx("vfx/smoke/smk_burst_door_shut");
	level._effect["fog_ambient_directional"] = loadfx("vfx/fog/fog_ambient_directional");
	level._effect["fog_drone_swarm_kickup"] = loadfx("vfx/fog/fog_drone_swarm_kickup");
	level._effect["civ_group_idle_runner_light"] = loadfx("vfx/unique/civ_group_idle_runner_light");
	level._effect["civ_group_walk_rt_runner"] = loadfx("vfx/unique/civ_group_walk_rt_runner");
	level._effect["civ_group_walk_lt_runner"] = loadfx("vfx/unique/civ_group_walk_lt_runner");
	level._effect["low_dust_ambient_far_lp"] = loadfx("vfx/dust/low_dust_ambient_far_lp");
	level._effect["bet_dock_collapse_dust"] = loadfx("vfx/map/betrayal/bet_dock_collapse_dust");
	level._effect["bet_shallow_debris_physics"] = loadfx("vfx/map/betrayal/bet_shallow_debris_physics");
	level._effect["bet_scrambler_blinking_light"] = loadfx("vfx/map/betrayal/bet_scrambler_blinking_light");
	level._effect["screen_fx_plunge"] = loadfx("vfx/water/screen_fx_plunge");
	level._effect["screen_fx_emerge"] = loadfx("vfx/water/screen_fx_emerge");
	level._effect["screen_distort_splash_diveboat_crash"] = loadfx("vfx/distortion/screen_distort_splash_diveboat_crash");
	level._effect["glass_slam_body"] = loadfx("vfx/glass/glass_slam_body");
	level._effect["glass_throw"] = loadfx("vfx/glass/glass_throw");
	level._effect["glass_falling_m_runner"] = loadfx("vfx/glass/glass_falling_m_runner");
	level._effect["fx_sunflare_lsr2"] = loadfx("vfx/lensflare/betrayal/fx_sunflare_lsr2");
	level._effect["underwater_godray_beams_1"] = loadfx("vfx/map/betrayal/underwater_godray_beams_1");
	level._effect["caustic_b_pa"] = loadfx("vfx/caustic/caustic_b_pa");
	level._effect["caustic_b_small_pa"] = loadfx("vfx/caustic/caustic_b_small_pa");
	level._effect["caustic_c_pa"] = loadfx("vfx/caustic/caustic_c_pa");
	level._effect["water_splash_medium"] = loadfx("vfx/water/water_splash_medium");
	level._effect["bubble_geotrail_thick_xsml"] = loadfx("vfx/water/bubble_geotrail_thick_xsml");
	level._effect["bubble_trail_runner_cheap_lp"] = loadfx("vfx/water/bubble_trail_runner_cheap_lp");
	level._effect["water_splashes_radial_xsml"] = loadfx("vfx/water/water_splashes_radial_xsml");
	level._effect["bet_boat_bubble_trail"] = loadfx("vfx/map/betrayal/bet_boat_bubble_trail");
	level._effect["boat_sink_splashes"] = loadfx("vfx/water/water_boat_sink_splashes");
	level._effect["underwater_bubbles_canal"] = loadfx("vfx/map/betrayal/underwater_bubbles_canal");
	level._effect["underwater_bubbles_canal_fewer"] = loadfx("vfx/map/betrayal/underwater_bubbles_canal_fewer");
	level._effect["trash_underwater_current_rnr_lp"] = loadfx("vfx/water/trash_underwater_current_rnr_lp");
	level._effect["boat_edge_foam_sml"] = loadfx("vfx/water/boat_edge_foam_sml");
	level._effect["boat_edge_foam_lrg"] = loadfx("vfx/water/boat_edge_foam_lrg");
	level._effect["waterfall_edge_splatter_sml"] = loadfx("vfx/water/waterfall_edge_splatter_sml");
	level._effect["boat_wake_speedboat_front_splash_vm_fast"] = loadfx("vfx/water/boat_wake_speedboat_front_splash_vm_fast");
	level._effect["boat_wake_speedboat_front_splash_vm_slow"] = loadfx("vfx/water/boat_wake_speedboat_front_splash_vm_slow");
	level._effect["diveboat_front_splash_vm_submerge"] = loadfx("vfx/water/diveboat_front_splash_vm_submerge");
	level._effect["diveboat_front_splash_vm_emerge"] = loadfx("vfx/water/diveboat_front_splash_vm_emerge");
	level._effect["distortion_vm_transition_fast"] = loadfx("vfx/distortion/distortion_vm_transition_fast");
	level._effect["falling_water_drip_runner_fast"] = loadfx("vfx/water/falling_water_drip_runner_fast");
	level._effect["water_edge_splashes_rnr"] = loadfx("vfx/water/water_edge_splashes_rnr");
	level._effect["bubble_trail_lite_single_02"] = loadfx("vfx/water/bubble_trail_lite_single_02");
	level._effect["underwater_particulates_river_sml"] = loadfx("vfx/map/betrayal/underwater_particulates_river_sml");
	level._effect["underwater_bullet_trail_long"] = loadfx("vfx/water/underwater_bullet_trail_long");
	level._effect["underwater_bubbles_canal_sml"] = loadfx("vfx/map/betrayal/underwater_bubbles_canal_sml");
	level._effect["bet_boat_collision_building_after"] = loadfx("vfx/map/betrayal/bet_boat_collision_building_after");
	level._effect["bet_boat_collision_building_after_dripping"] = loadfx("vfx/map/betrayal/bet_boat_collision_building_after_drip");
	level._effect["bet_boat_collision_building_before"] = loadfx("vfx/map/betrayal/bet_boat_collision_building_before");
	level._effect["electrical_sparks_runner"] = loadfx("vfx/map/betrayal/bet_electrical_sparks_runner");
	level._effect["bet_crash_water_impact"] = loadfx("vfx/map/betrayal/bet_crash_water_impact");
	level._effect["bet_plans_dust_landing"] = loadfx("vfx/map/betrayal/bet_plans_dust_landing");
	level._effect["bet_boat_collision_smoke_over_water"] = loadfx("vfx/map/betrayal/bet_boat_collision_smoke_over_water");
	level._effect["boat_wake_speedboat_main_foam"] = loadfx("vfx/treadfx/boat_wake_speedboat_main_foam");
	level._effect["boat_wake_speedboat_main_foam_taxi"] = loadfx("vfx/treadfx/boat_wake_speedboat_main_foam_taxi");
	level._effect["boat_wake_speedboat_front_splash_slow"] = loadfx("vfx/treadfx/boat_wake_speedboat_front_splash_slow");
	level._effect["boat_wake_speedboat_front_splash_fast"] = loadfx("vfx/treadfx/boat_wake_speedboat_front_splash_fast");
	level._effect["boat_wake_diveboat_splash_fast"] = loadfx("vfx/treadfx/boat_wake_diveboat_splash_fast");
	level._effect["boat_wake_diveboat_splash_slow"] = loadfx("vfx/treadfx/boat_wake_diveboat_splash_slow");
	level._effect["boat_wake_yacht_main_foam_far"] = loadfx("vfx/treadfx/boat_wake_yacht_main_foam_far");
	level._effect["boat_wake_speedboat_main_foam_taxi_far"] = loadfx("vfx/treadfx/boat_wake_speedboat_main_foam_taxi_far");
	level._effect["boat_wake_yacht_front_splash_slow_far"] = loadfx("vfx/treadfx/boat_wake_yacht_front_splash_slow_far");
	level._effect["boat_wake_yacht_front_splash_fast_far"] = loadfx("vfx/treadfx/boat_wake_yacht_front_splash_fast_far");
	level._effect["light_ramp_godray_hazy_1_angled"] = loadfx("vfx/lights/lagos/light_ramp_godray_hazy_1_angled");
	level._effect["light_godray_hazy_betrayal"] = loadfx("vfx/lights/light_godray_hazy_betrayal");
	level._effect["light_godray_water_betrayal"] = loadfx("vfx/lights/light_godray_water_betrayal");
	level._effect["btr_emergency_light_pulse"] = loadfx("vfx/map/betrayal/btr_emergency_light_pulse");
	level._effect["btr_emergency_spritelight_pulse"] = loadfx("vfx/map/betrayal/btr_emergency_spritelight_pulse");
	level._effect["btr_emergency_nolight_pulse"] = loadfx("vfx/map/betrayal/btr_emergency_nolight_pulse");
	level._effect["bet_led_red_pulse"] = loadfx("vfx/map/betrayal/bet_led_red_pulse");
	level._effect["btr_confrontation_fill_light"] = loadfx("vfx/map/betrayal/btr_confrontation_fill_light");
	level._effect["btr_finale_fill_light"] = loadfx("vfx/map/betrayal/btr_finale_fill_light");
	level._effect["godray_ambient_outdoors_large"] = loadfx("vfx/map/greece/godray_ambient_outdoors_large");
	level._effect["godray_ambient_outdoors_med"] = loadfx("vfx/map/greece/godray_ambient_outdoors_med");
	level._effect["betrayal_steam_fill_utility_room"] = loadfx("vfx/steam/betrayal/betrayal_steam_fill_utility_room");
	level._effect["betrayal_overhead_fluor_steam_light"] = loadfx("vfx/lights/betrayal/betrayal_overhead_fluor_steam_light");
	level._effect["betrayal_overhead_fluor_steam_lighter"] = loadfx("vfx/lights/betrayal/betrayal_ovrhd_fluor_steam_lighter");
	level._effect["betrayal_overhead_spot_steam_light"] = loadfx("vfx/lights/betrayal/betrayal_overhead_spot_steam_light");
	level._effect["betrayal_overhead_point_steam_light"] = loadfx("vfx/lights/betrayal/betrayal_overhead_point_steam_light");
	level._effect["betrayal_emergency_backup_light_godray"] = loadfx("vfx/lights/betrayal/betrayal_emrgncy_bckup_light_godray");
	level._effect["betrayal_godray_beams_canal_1"] = loadfx("vfx/map/betrayal/betrayal_godray_beams_canal_1");
	level._effect["bet_gideon_scanner_beam_light"] = loadfx("vfx/map/betrayal/bet_gideon_scanner_beam_light");
	level._effect["bet_confrontation_screen_glows"] = loadfx("vfx/map/betrayal/bet_confrontation_screen_glows");
	level._effect["pigeon_fly_off"] = loadfx("vfx/map/betrayal/pigeon_fly_off");
	level._effect["bird_seagull_flock_large_group_loop"] = loadfx("vfx/animal/bird_seagull_flock_large_group_loop");
	level._effect["bird_vulture_circle_a_loop"] = loadfx("vfx/animal/bird_vulture_circle_a_loop");
	level._effect["bird_seagull_flock_flying_runner"] = loadfx("vfx/animal/bird_seagull_flock_flying_runner");
	level._effect["insects_flies_landing"] = loadfx("vfx/animal/insects_flies_landing");
	level._effect["pigeon_rand_idle_single"] = loadfx("vfx/animal/pigeon_rand_idle_single");
	level._effect["pigeon_fly_off_pos_y_runner"] = loadfx("vfx/animal/pigeon_fly_off_pos_y_runner");
	level._effect["bet_water_explosion_single"] = loadfx("vfx/map/betrayal/bet_water_explosion_single");
	level._effect["bullet_drop"] = loadfx("vfx/shelleject/exo_armor_minigun_shell_wv");
	level._effect["concrete_falling_over_water_lp"] = loadfx("vfx/rock/concrete_falling_over_water_lp");
	level._effect["concrete_falling_l_runner_b"] = loadfx("vfx/rock/concrete_falling_l_runner_b");
	level._effect["exo_r_glove_on"] = loadfx("vfx/ui/exo_r_gloves_engage");
	level._effect["exo_l_glove_on"] = loadfx("vfx/ui/exo_l_gloves_engage");
	level._effect["exo_r_glove_off"] = loadfx("vfx/ui/exo_r_gloves_disengage");
	level._effect["exo_l_glove_off"] = loadfx("vfx/ui/exo_l_gloves_disengage");
	level._effect["bet_dust_landing_hands"] = loadfx("vfx/map/betrayal/bet_dust_landing_hands");
	level._effect["bet_round_dust_landing"] = loadfx("vfx/map/betrayal/bet_round_dust_landing");
	level._effect["bet_ilona_dust_landing"] = loadfx("vfx/map/betrayal/bet_ilona_dust_landing");
	level._effect["bet_dust_landing"] = loadfx("vfx/map/betrayal/bet_dust_landing");
	level._effect["dust_blowing_ground_slow_light_lp"] = loadfx("vfx/dust/dust_blowing_ground_slow_light_lp");
	level._effect["dust_warbird_blowing_fast_thick_lp"] = loadfx("vfx/dust/dust_warbird_blowing_fast_thick_lp");
	level._effect["sparks_vm_lp_sml"] = loadfx("vfx/sparks/sparks_vm_lp_sml");
	level._effect["swarm_death_explosion"] = loadfx("vfx/explosion/vehicle_pdrone_explosion");
	level._effect["fire_suppression_spray"] = loadfx("vfx/water/water_sprinkler_spray_ceiling_lp");
	level._effect["underwater_particulates_river"] = loadfx("vfx/map/betrayal/underwater_particulates_river");
	level._effect["hovertank_anti_pers_muzzle_flash_vm"] = loadfx("vfx/muzzleflash/hovertank_anti_pers_muzzle_flash_vm");
	level._effect["hovertank_anti_pers_trail_rocket_2"] = loadfx("vfx/trail/hovertank_anti_pers_trail_rocket_2");
	level._effect["drone_beacon_red"] = loadfx("vfx/lights/light_drone_beacon_red");
}

//Function Number: 3
intro_birds()
{
	common_scripts\utility::flag_wait("fx_setup_tree_birds");
	maps\_shg_fx::setupledgefx("section_0");
	common_scripts\utility::flag_wait("fx_tree_birds_flee");
	maps\_shg_fx::swapfx("fx_tree_large_group","pigeon_fly_off_pos_y_runner",(0,0,0),0.1);
}

//Function Number: 4
treadfx_ai_boats_yacht_vista(param_00)
{
	param_00 thread ai_boat_water_foamfx("boat_wake_yacht_main_foam_far");
	param_00 ai_boat_bow_splash_fx("boat_wake_yacht_front_splash_fast_far","boat_wake_yacht_front_splash_slow_far",(0,0,0),(0,0,0));
}

//Function Number: 5
treadfx_ai_boats_taxi_vista(param_00)
{
	param_00 thread ai_boat_water_foamfx("boat_wake_speedboat_main_foam_taxi_far");
	param_00 ai_boat_bow_splash_fx("boat_wake_yacht_front_splash_fast_far","boat_wake_yacht_front_splash_slow_far",(-75,0,0),(0,0,0));
}

//Function Number: 6
gideon_arm_scan(param_00)
{
	common_scripts\_exploder::exploder(2010);
}

//Function Number: 7
scrambler_light(param_00)
{
	wait(1);
	common_scripts\_exploder::exploder(2102);
}

//Function Number: 8
scrambler_light_off(param_00)
{
	common_scripts\_exploder::kill_exploder(2102);
}

//Function Number: 9
confrontation_flashbang(param_00)
{
	common_scripts\_exploder::exploder(2008);
}

//Function Number: 10
confrontation_irons_gun_shot(param_00)
{
	playfxontag(common_scripts\utility::getfx("bet_irons_pistol_flash"),param_00,"tag_flash");
	soundscripts\_snd::snd_message("bet_holo_irons_shoot_pistol",param_00);
	common_scripts\utility::flag_wait("kill_blood_fx");
	killfxontag(common_scripts\utility::getfx("bet_irons_pistol_flash"),param_00,"tag_flash");
}

//Function Number: 11
confrontation_tech_blood(param_00)
{
	wait(0.25);
	playfxontag(common_scripts\utility::getfx("bet_con_gun_shot_blood"),param_00,"j_head");
	wait(0.05);
	common_scripts\_exploder::exploder(2009);
	wait(0.05);
	common_scripts\_exploder::exploder(2101);
	common_scripts\utility::flag_wait("kill_blood_fx");
	killfxontag(common_scripts\utility::getfx("bet_con_gun_shot_blood"),param_00,"j_head");
}

//Function Number: 12
confrontation_fx_cleanup()
{
	common_scripts\utility::flag_set("kill_blood_fx");
	common_scripts\_exploder::kill_exploder(2009);
	common_scripts\_exploder::kill_exploder(2101);
}

//Function Number: 13
escape_sprinklers_on(param_00)
{
	wait(0.25);
	common_scripts\_exploder::exploder(2001);
	soundscripts\_snd::snd_message("bet_conf_sprinkler",2001);
	wait(0.2);
	common_scripts\_exploder::exploder(2012);
	soundscripts\_snd::snd_message("bet_conf_sprinkler",2012);
	wait(0.35);
	common_scripts\_exploder::exploder(2013);
	soundscripts\_snd::snd_message("bet_conf_sprinkler",2013);
	wait(2.75);
	common_scripts\_exploder::exploder(2015);
	soundscripts\_snd::snd_message("bet_conf_sprinkler",2015);
	wait(0.5);
	common_scripts\_exploder::exploder(2014);
	soundscripts\_snd::snd_message("bet_conf_sprinkler",2016);
}

//Function Number: 14
escape_hallway_steam()
{
	common_scripts\utility::flag_wait("vfx_pipe_burst");
	wait(0.1);
	common_scripts\_exploder::exploder(2002);
	soundscripts\_snd::snd_message("bet_conf_steam_lp",2002);
	wait(0.15);
	common_scripts\_exploder::exploder(2003);
	soundscripts\_snd::snd_message("bet_conf_steam_lp",2003);
	wait(0.3);
	common_scripts\_exploder::exploder(2004);
	soundscripts\_snd::snd_message("bet_conf_steam_lp",2004);
	wait(0.5);
	common_scripts\_exploder::exploder(2005);
	soundscripts\_snd::snd_message("bet_conf_steam_lp",2005);
	wait(0.2);
	common_scripts\_exploder::exploder(2006);
	soundscripts\_snd::snd_message("bet_conf_steam_lp",2006);
	wait(0.45);
	common_scripts\_exploder::exploder(2007);
	soundscripts\_snd::snd_message("bet_conf_steam_lp",2007);
}

//Function Number: 15
escape_fire_door_slam_shut()
{
	common_scripts\_exploder::exploder(2020);
}

//Function Number: 16
escape_sprinklers_off()
{
	maps\_utility::stop_exploder(2001);
	maps\_utility::stop_exploder(2002);
	maps\_utility::stop_exploder(2003);
	maps\_utility::stop_exploder(2004);
	maps\_utility::stop_exploder(2005);
	maps\_utility::stop_exploder(2006);
	maps\_utility::stop_exploder(2007);
}

//Function Number: 17
escape_drone_door_open()
{
	common_scripts\_exploder::exploder(3002);
}

//Function Number: 18
pull_fence_dust(param_00)
{
	common_scripts\_exploder::exploder(3002);
}

//Function Number: 19
vm_glass_impact(param_00)
{
	wait(0.2);
	common_scripts\_exploder::exploder(1003);
}

//Function Number: 20
vm_water_impact(param_00)
{
	common_scripts\_exploder::exploder(1002);
	wait(0.2);
	common_scripts\_exploder::exploder(1010);
	wait(0.95);
	common_scripts\_exploder::exploder(1004);
	wait(0.65);
	thread underwater_bullets();
	playfxontag(common_scripts\utility::getfx("screen_fx_plunge"),param_00,"tag_origin");
	playfxontag(common_scripts\utility::getfx("bubble_trail_runner_cheap_lp"),param_00,"J_Wrist_RI");
	wait 0.05;
	playfxontag(common_scripts\utility::getfx("bubble_trail_runner_cheap_lp"),param_00,"J_Wrist_LE");
	playfxontag(common_scripts\utility::getfx("bubble_trail_runner_cheap_lp"),param_00,"tag_origin");
}

//Function Number: 21
ilana_glass_impact(param_00)
{
	common_scripts\_exploder::exploder(1005);
	common_scripts\_exploder::exploder(1001);
	playfxontag(common_scripts\utility::getfx("glass_slam_body"),param_00,"J_Hip_LE");
	wait(0.3);
	common_scripts\_exploder::exploder(1006);
	wait(0.2);
	common_scripts\_exploder::exploder(1006);
	wait(0.35);
	common_scripts\_exploder::exploder(1006);
}

//Function Number: 22
ilana_water_impact(param_00)
{
	playfxontag(common_scripts\utility::getfx("bubble_trail_runner_cheap_lp"),param_00,"J_Ankle_RI");
	playfxontag(common_scripts\utility::getfx("bubble_trail_runner_cheap_lp"),param_00,"J_Ankle_LE");
	wait 0.05;
	playfxontag(common_scripts\utility::getfx("bubble_geotrail_thick_xsml"),param_00,"J_Wrist_RI");
	playfxontag(common_scripts\utility::getfx("bubble_geotrail_thick_xsml"),param_00,"J_Wrist_LE");
	level.ilana thread ilana_swimming_bubbles();
	wait(3);
	stopfxontag(common_scripts\utility::getfx("bubble_trail_runner_cheap_lp"),param_00,"J_Ankle_RI");
	stopfxontag(common_scripts\utility::getfx("bubble_trail_runner_cheap_lp"),param_00,"J_Ankle_LE");
	wait(1.5);
	stopfxontag(common_scripts\utility::getfx("bubble_geotrail_thick_xsml"),param_00,"J_Wrist_RI");
	stopfxontag(common_scripts\utility::getfx("bubble_geotrail_thick_xsml"),param_00,"J_Wrist_LE");
}

//Function Number: 23
ilana_swimming_bubbles()
{
	wait(3.5);
	playfxontag(common_scripts\utility::getfx("bubble_trail_lite_single_02"),self,"J_Head");
	wait(1);
	playfxontag(common_scripts\utility::getfx("bubble_trail_lite_single_02"),self,"J_Head");
	wait(0.8);
	playfxontag(common_scripts\utility::getfx("bubble_trail_lite_single_02"),self,"J_Head");
	wait(0.55);
	playfxontag(common_scripts\utility::getfx("bubble_trail_lite_single_02"),self,"J_Head");
	wait(1.25);
	playfxontag(common_scripts\utility::getfx("bubble_trail_lite_single_02"),self,"J_Head");
	wait(1.8);
	playfxontag(common_scripts\utility::getfx("bubble_trail_lite_single_02"),self,"J_Head");
	wait(0.75);
	playfxontag(common_scripts\utility::getfx("bubble_trail_lite_single_02"),self,"J_Head");
	wait(1);
	playfxontag(common_scripts\utility::getfx("bubble_trail_lite_single_02"),self,"J_Head");
}

//Function Number: 24
underwater_bullets(param_00)
{
	wait(0.75);
	thread underwater_bullets_4100();
	wait(0.3);
	thread underwater_bullets_4200();
	wait(0.45);
	thread underwater_bullets_4300();
}

//Function Number: 25
underwater_bullets_4100()
{
	var_00 = randomfloatrange(0.2,0.5);
	common_scripts\_exploder::exploder(4101);
	soundscripts\_snd::snd_message("bet_swim_bullet_trails",4101);
	wait(var_00);
	common_scripts\_exploder::exploder(4102);
	soundscripts\_snd::snd_message("bet_swim_bullet_trails",4102);
	wait(var_00);
	common_scripts\_exploder::exploder(4103);
	soundscripts\_snd::snd_message("bet_swim_bullet_trails",4103);
	wait(var_00);
	common_scripts\_exploder::exploder(4104);
	soundscripts\_snd::snd_message("bet_swim_bullet_trails",4104);
	wait(var_00);
	common_scripts\_exploder::exploder(4105);
	soundscripts\_snd::snd_message("bet_swim_bullet_trails",4105);
	wait(var_00);
	common_scripts\_exploder::exploder(4105);
	soundscripts\_snd::snd_message("bet_swim_bullet_trails",4105);
}

//Function Number: 26
underwater_bullets_4200()
{
	var_00 = randomfloatrange(0.2,0.5);
	common_scripts\_exploder::exploder(4201);
	soundscripts\_snd::snd_message("bet_swim_bullet_trails",4201);
	wait(var_00);
	common_scripts\_exploder::exploder(4202);
	soundscripts\_snd::snd_message("bet_swim_bullet_trails",4202);
	wait(var_00);
	common_scripts\_exploder::exploder(4203);
	soundscripts\_snd::snd_message("bet_swim_bullet_trails",4203);
	wait(var_00);
	common_scripts\_exploder::exploder(4204);
	soundscripts\_snd::snd_message("bet_swim_bullet_trails",4204);
}

//Function Number: 27
underwater_bullets_4300()
{
	var_00 = randomfloatrange(0.2,0.5);
	common_scripts\_exploder::exploder(4300);
	soundscripts\_snd::snd_message("bet_swim_bullet_trails",4300);
	wait(var_00);
	common_scripts\_exploder::exploder(4301);
	soundscripts\_snd::snd_message("bet_swim_bullet_trails",4301);
	wait(var_00);
	common_scripts\_exploder::exploder(4302);
	soundscripts\_snd::snd_message("bet_swim_bullet_trails",4302);
	wait(var_00);
	common_scripts\_exploder::exploder(4303);
	soundscripts\_snd::snd_message("bet_swim_bullet_trails",4303);
	wait(var_00);
	common_scripts\_exploder::exploder(4304);
	soundscripts\_snd::snd_message("bet_swim_bullet_trails",4304);
}

//Function Number: 28
canal_boat_explosion(param_00)
{
	if(isdefined(self.underwater) && self.underwater)
	{
		playfxontag(level._effect["vehicle_boat_explo_underwater"],param_00,"tag_origin");
		wait(5);
		playfxontag(common_scripts\utility::getfx("bet_boat_bubble_trail"),param_00,"tag_origin");
		return;
	}

	playfxontag(level._effect["boat_explosion"],param_00,"tag_origin");
	wait(0.25);
	playfxontag(common_scripts\utility::getfx("boat_sink_splashes"),param_00,"tag_origin");
	wait(6);
	playfxontag(common_scripts\utility::getfx("bet_boat_bubble_trail"),param_00,"tag_origin");
}

//Function Number: 29
canal_boat_hit_bottom(param_00)
{
	playfxontag(common_scripts\utility::getfx("dust_boat_impact_ground_underwater"),param_00,"tag_origin");
	soundscripts\_snd::snd_message("bet_swim_boat_hit_bottom",param_00);
}

//Function Number: 30
canal_underwater_bullet_trails(param_00)
{
	param_00 = level.player;
	var_01 = randomfloatrange(0.2,0.5);
	common_scripts\utility::flag_wait("bullet_trails_01");
	if(isdefined(param_00.underwater) && param_00.underwater)
	{
		common_scripts\_exploder::exploder("bullet_trails_01a");
		soundscripts\_snd::snd_message("bet_swim_bullet_trails","bullet_trails_01a");
		wait(var_01);
		common_scripts\_exploder::exploder("bullet_trails_01b");
		soundscripts\_snd::snd_message("bet_swim_bullet_trails","bullet_trails_01b");
		wait(var_01);
		common_scripts\_exploder::exploder("bullet_trails_01c");
		soundscripts\_snd::snd_message("bet_swim_bullet_trails","bullet_trails_01c");
		wait(var_01);
		common_scripts\_exploder::exploder("bullet_trails_01d");
		soundscripts\_snd::snd_message("bet_swim_bullet_trails","bullet_trails_01d");
	}

	common_scripts\utility::flag_wait("bullet_trails_02");
	if(isdefined(param_00.underwater) && param_00.underwater)
	{
		common_scripts\_exploder::exploder("bullet_trails_02a");
		soundscripts\_snd::snd_message("bet_swim_bullet_trails","bullet_trails_02a");
		wait(var_01);
		common_scripts\_exploder::exploder("bullet_trails_02b");
		soundscripts\_snd::snd_message("bet_swim_bullet_trails","bullet_trails_02b");
		wait(var_01);
		common_scripts\_exploder::exploder("bullet_trails_02c");
		soundscripts\_snd::snd_message("bet_swim_bullet_trails","bullet_trails_02c");
	}

	common_scripts\utility::flag_wait("bullet_trails_03");
	if(isdefined(param_00.underwater) && param_00.underwater)
	{
		common_scripts\_exploder::exploder("bullet_trails_03a");
		soundscripts\_snd::snd_message("bet_swim_bullet_trails","bullet_trails_03a");
		wait(var_01);
		common_scripts\_exploder::exploder("bullet_trails_03b");
		soundscripts\_snd::snd_message("bet_swim_bullet_trails","bullet_trails_03b");
		wait(var_01);
		common_scripts\_exploder::exploder("bullet_trails_03c");
		soundscripts\_snd::snd_message("bet_swim_bullet_trails","bullet_trails_03c");
	}

	common_scripts\utility::flag_wait("bullet_trails_04");
	if(isdefined(param_00.underwater) && param_00.underwater)
	{
		common_scripts\_exploder::exploder("bullet_trails_04a");
		soundscripts\_snd::snd_message("bet_swim_bullet_trails","bullet_trails_04a");
		wait(var_01);
		common_scripts\_exploder::exploder("bullet_trails_04b");
		soundscripts\_snd::snd_message("bet_swim_bullet_trails","bullet_trails_04b");
		wait(var_01);
		common_scripts\_exploder::exploder("bullet_trails_04c");
		soundscripts\_snd::snd_message("bet_swim_bullet_trails","bullet_trails_04c");
	}

	common_scripts\utility::flag_wait("bullet_trails_05");
	if(isdefined(param_00.underwater) && param_00.underwater)
	{
		wait(var_01);
		common_scripts\_exploder::exploder("bullet_trails_05a");
		soundscripts\_snd::snd_message("bet_swim_bullet_trails","bullet_trails_05a");
		wait(var_01);
		common_scripts\_exploder::exploder("bullet_trails_05b");
		soundscripts\_snd::snd_message("bet_swim_bullet_trails","bullet_trails_05b");
	}

	common_scripts\utility::flag_wait("bullet_trails_06");
	if(isdefined(param_00.underwater) && param_00.underwater)
	{
		common_scripts\_exploder::exploder("bullet_trails_06a");
		soundscripts\_snd::snd_message("bet_swim_bullet_trails","bullet_trails_06a");
		wait(var_01);
		common_scripts\_exploder::exploder("bullet_trails_06b");
		soundscripts\_snd::snd_message("bet_swim_bullet_trails","bullet_trails_06b");
		wait(var_01);
		common_scripts\_exploder::exploder("bullet_trails_06c");
		soundscripts\_snd::snd_message("bet_swim_bullet_trails","bullet_trails_06c");
	}

	common_scripts\utility::flag_wait("bullet_trails_07");
	if(isdefined(param_00.underwater) && param_00.underwater)
	{
		common_scripts\_exploder::exploder("bullet_trails_07a");
		soundscripts\_snd::snd_message("bet_swim_bullet_trails","bullet_trails_07a");
		wait(var_01);
		common_scripts\_exploder::exploder("bullet_trails_07b");
		soundscripts\_snd::snd_message("bet_swim_bullet_trails","bullet_trails_07b");
		wait(var_01);
		common_scripts\_exploder::exploder("bullet_trails_07c");
		soundscripts\_snd::snd_message("bet_swim_bullet_trails","bullet_trails_07c");
	}
}

//Function Number: 31
canal_dock_destroy()
{
	common_scripts\_exploder::exploder(4020);
	soundscripts\_snd::snd_message("bet_swim_dock_explode",4020);
}

//Function Number: 32
birds_after_sewer()
{
	common_scripts\utility::flag_wait("fx_shadow_birds");
	maps\_shg_fx::setupledgefx("section_1");
	common_scripts\utility::flag_wait("fx_window_birds_flee");
	maps\_shg_fx::swapfx("fx_wire_large_group","pigeon_fly_off_pos_y_runner",(0,0,0),0.1);
}

//Function Number: 33
bird_shadow_after_sewer()
{
	common_scripts\utility::flag_wait("fx_shadow_birds");
	common_scripts\_exploder::exploder(5001);
}

//Function Number: 34
vm_boat_wake()
{
	level endon("flag_objective_boat_chase_complete");
	while(isdefined(self) && isalive(self))
	{
		var_00 = self vehicle_getspeed();
		if(self vehicle_diveboatissubmerged())
		{
			stopfxontag(common_scripts\utility::getfx("boat_wake_speedboat_front_splash_vm_fast"),self,"tag_fx_bow");
			stopfxontag(common_scripts\utility::getfx("boat_wake_speedboat_front_splash_vm_slow"),self,"tag_fx_bow");
		}
		else if(var_00 > 35)
		{
			playfxontag(common_scripts\utility::getfx("boat_wake_speedboat_front_splash_vm_fast"),self,"tag_fx_bow");
		}
		else if(var_00 <= 35 && var_00 >= 10)
		{
			playfxontag(common_scripts\utility::getfx("boat_wake_speedboat_front_splash_vm_slow"),self,"tag_fx_bow");
		}
		else if(var_00 < 10)
		{
		}

		wait(0.3);
	}
}

//Function Number: 35
vm_boat_submerge_fx()
{
	playfxontag(common_scripts\utility::getfx("diveboat_front_splash_vm_submerge"),self,"tag_fx_bow");
	wait 0.05;
	stopfxontag(common_scripts\utility::getfx("diveboat_front_splash_vm_emerge"),self,"tag_fx_bow");
}

//Function Number: 36
vm_boat_emerge_fx()
{
	killfxontag(common_scripts\utility::getfx("diveboat_front_splash_vm_submerge"),self,"tag_fx_bow");
	wait 0.05;
	playfxontag(common_scripts\utility::getfx("diveboat_front_splash_vm_emerge"),self,"tag_fx_bow");
}

//Function Number: 37
boat_small_static_foam()
{
	wait(0.1);
	playfxontag(common_scripts\utility::getfx("boat_edge_foam_sml"),self,"tag_origin");
}

//Function Number: 38
boat_large_static_foam()
{
	wait(0.1);
	playfxontag(common_scripts\utility::getfx("boat_edge_foam_lrg"),self,"tag_origin");
}

//Function Number: 39
treadfx_ai_boats_yacht(param_00)
{
	param_00 thread ai_boat_water_foamfx("boat_wake_speedboat_main_foam");
	param_00 ai_boat_bow_splash_fx("boat_wake_speedboat_front_splash_fast","boat_wake_speedboat_front_splash_slow",(0,0,0),(0,0,0));
}

//Function Number: 40
treadfx_ai_boats_taxi(param_00)
{
	param_00 thread ai_boat_water_foamfx("boat_wake_speedboat_main_foam_taxi");
	param_00 ai_boat_bow_splash_fx("boat_wake_speedboat_front_splash_fast","boat_wake_speedboat_front_splash_slow",(-75,0,0),(0,0,0));
}

//Function Number: 41
ai_boat_water_foamfx(param_00)
{
	self endon("death");
	var_01 = bullettrace(self.origin + (0,0,500),self.origin + (0,0,-100),0,self,0,0,0,0,0);
	if(isdefined(var_01["surfacetype"]) && issubstr(var_01["surfacetype"],"water"))
	{
		var_02 = var_01["position"];
	}
	else
	{
		var_02 = self.origin;
	}

	var_03 = common_scripts\utility::spawn_tag_origin();
	playfxontag(common_scripts\utility::getfx(param_00),var_03,"tag_origin");
	while(isalive(self) && isdefined(self))
	{
		var_03.origin = (self.origin[0],self.origin[1],var_02[2]);
		var_03.angles = (0,self.angles[1],0);
		wait(0.05);
	}

	stopfxontag(common_scripts\utility::getfx(param_00),var_03,"tag_origin");
	var_03 delete();
}

//Function Number: 42
ai_boat_bow_splash_fx(param_00,param_01,param_02,param_03)
{
	self endon("death");
	var_04 = common_scripts\utility::spawn_tag_origin();
	var_04 linkto(self,"tag_origin",(0,0,0) + param_02,(0,0,0) + param_03);
	while(isalive(self) && isdefined(self))
	{
		var_05 = self vehicle_getspeed();
		if(var_05 > 10)
		{
			playfxontag(common_scripts\utility::getfx(param_00),var_04,"tag_origin");
			wait(0.45);
			continue;
		}

		if(var_05 <= 10 && var_05 >= 3)
		{
			playfxontag(common_scripts\utility::getfx(param_01),var_04,"tag_origin");
			wait(0.45);
			continue;
		}

		if(var_05 < 3)
		{
			wait(0.45);
		}
	}

	wait(0.1);
	var_04 delete();
}

//Function Number: 43
boat_scene_bridge_collapse()
{
	common_scripts\utility::run_thread_on_targetname("start_crash_effects",::vm_crash_transition);
	common_scripts\_exploder::exploder("bridge_collapse");
	level waittill("boat_crash_end");
	common_scripts\_exploder::kill_exploder("bridge_collapse");
}

//Function Number: 44
vm_crash_transition()
{
	self waittill("trigger");
	if(isdefined(level.player_boat))
	{
		common_scripts\_exploder::exploder("splash_transition");
		playfxontag(common_scripts\utility::getfx("diveboat_front_splash_vm_emerge"),level.player_boat,"tag_fx_bow");
		thread quick_transition_flash();
		wait(0.3);
		playfxontag(common_scripts\utility::getfx("screen_distort_splash_diveboat_crash"),level.player_boat,"tag_fx_bow");
		wait(2);
		stopfxontag(common_scripts\utility::getfx("screen_distort_splash_diveboat_crash"),level.player_boat,"tag_fx_bow");
	}
}

//Function Number: 45
quick_transition_flash()
{
	var_00 = common_scripts\utility::spawn_tag_origin();
	var_00 linktoplayerview(level.player,"tag_origin",(10,0,0),(0,0,0),1);
	wait 0.05;
	playfxontag(common_scripts\utility::getfx("distortion_vm_transition_fast"),var_00,"tag_origin");
	wait(1.5);
	var_00 delete();
}

//Function Number: 46
vm_boat_crash_se_fx_start(param_00)
{
	level notify("stop_vm_boat_treadfx");
	wait(2.85);
	common_scripts\_exploder::exploder("boat_crash");
	soundscripts\_snd::snd_message("bet_boat_crash_bldg_impact");
}

//Function Number: 47
vm_boat_crash_se_whiteout(param_00)
{
	common_scripts\_exploder::exploder("boat_crash");
	wait(11);
	common_scripts\_exploder::exploder("player_plant");
	wait(2);
	common_scripts\_exploder::exploder("friendly_plant");
}

//Function Number: 48
vfx_vm_land_crane_edge(param_00)
{
	thread rooftop_ambient_dust();
	wait(0.2);
	playfxontag(common_scripts\utility::getfx("exo_l_glove_on"),param_00,"J_Wrist_LE");
	playfxontag(common_scripts\utility::getfx("exo_r_glove_on"),param_00,"J_Wrist_RI");
	wait(0.25);
	common_scripts\_exploder::exploder("crane_wall_edge");
	wait(0.5);
	playfxontag(common_scripts\utility::getfx("sparks_vm_lp_sml"),param_00,"j_ball_le");
	playfxontag(common_scripts\utility::getfx("sparks_vm_lp_sml"),param_00,"j_ball_ri");
	wait(1);
	stopfxontag(common_scripts\utility::getfx("exo_l_glove_on"),param_00,"J_Wrist_LE");
	stopfxontag(common_scripts\utility::getfx("sparks_vm_lp_sml"),param_00,"j_ball_le");
	playfxontag(common_scripts\utility::getfx("exo_l_glove_off"),param_00,"J_Wrist_LE");
	wait(1);
	playfxontag(common_scripts\utility::getfx("sparks_vm_lp_sml"),param_00,"j_ankle_le");
	playfxontag(common_scripts\utility::getfx("exo_r_glove_off"),param_00,"J_Wrist_RI");
	stopfxontag(common_scripts\utility::getfx("exo_r_glove_on"),param_00,"J_Wrist_RI");
	wait(1);
	stopfxontag(common_scripts\utility::getfx("sparks_vm_lp_sml"),param_00,"j_ankle_le");
	stopfxontag(common_scripts\utility::getfx("sparks_vm_lp_sml"),param_00,"j_ball_ri");
	level waittill("kill_glove_effects");
	stopfxontag(common_scripts\utility::getfx("exo_r_glove_off"),param_00,"J_Wrist_RI");
	stopfxontag(common_scripts\utility::getfx("exo_l_glove_off"),param_00,"J_Wrist_LE");
}

//Function Number: 49
vfx_vm_land_roof(param_00)
{
	common_scripts\_exploder::exploder("vm_dust_land");
	wait(2);
	level notify("kill_glove_effects");
}

//Function Number: 50
vfx_vm_land_roof_hands(param_00)
{
	common_scripts\_exploder::exploder("vm_lt_dust_hand_land");
}

//Function Number: 51
vfx_ilana_land_roof(param_00)
{
	common_scripts\_exploder::exploder("ilona_landing_dust");
}

//Function Number: 52
rooftop_ambient_dust()
{
	common_scripts\_exploder::exploder("rooftop_dust");
	level waittill("pause_slow_rooftop_dust");
	maps\_utility::pauseexploder("rooftop_dust");
	common_scripts\_exploder::exploder("warbird_kickup_dust");
	level waittill("start_rooftop_dust");
	maps\_utility::pauseexploder("warbird_kickup_dust");
	common_scripts\_exploder::exploder("rooftop_dust");
}

//Function Number: 53
vfx_warbird_dust_roof(param_00)
{
	level notify("pause_slow_rooftop_dust");
}

//Function Number: 54
vfx_joker_land_roof(param_00)
{
	common_scripts\_exploder::exploder("joker_dust_roof_land");
}

//Function Number: 55
vfx_gideon_land_roof(param_00)
{
	common_scripts\_exploder::exploder("gideon_dust_roof_land");
	wait(5);
	level notify("start_rooftop_dust");
}