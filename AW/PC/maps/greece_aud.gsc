/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: greece_aud.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 245
 * Decompile Time: 3566 ms
 * Timestamp: 4/22/2024 2:30:34 AM
*******************************************************************/

//Function Number: 1
main()
{
	config_system();
	init_snd_flags();
	init_globals();
	launch_threads();
	launch_loops();
	thread launch_line_emitters();
	create_level_envelop_arrays();
	precache_presets();
	register_snd_messages();
}

//Function Number: 2
config_system()
{
	level._snd.context_overrides = [["mute",0],["slomo",0],["deathsdoor",0],["mhunt_safehouse_exit",0]];
	soundscripts\_audio::set_stringtable_mapname("shg");
	soundscripts\_snd_filters::snd_set_occlusion("med_occlusion");
	soundscripts\_snd_timescale::snd_set_timescale("mhunt_global");
}

//Function Number: 3
init_snd_flags()
{
	common_scripts\utility::flag_init("aud_hades_door_breach");
}

//Function Number: 4
init_globals()
{
	level._snd.context_overrides = [["mute",0],["slomo",0],["deathsdoor",0],["mhunt_safehouse_exit",0]];
}

//Function Number: 5
launch_threads()
{
	if(soundscripts\_audio::aud_is_specops())
	{
		return;
	}

	thread footstep_environmental_elements();
	var_00 = getent("audio_safehouse_int","targetname");
	var_00 thread safehouse_int_trigger_think();
	var_01 = getent("audio_safehouse_first_floor","targetname");
	var_01 thread first_floor_trigger_think();
	var_02 = getent("audio_safehouse_second_floor","targetname");
	var_02 thread second_floor_trigger_think();
	var_03 = getent("mhunt_trans_alleys_end_alley","targetname");
	var_03 thread trans_alleys_end_alley_trigger();
	var_04 = getent("mhunt_trans_alleys_end_corner","targetname");
	var_04 thread trans_alleys_end_corner_trigger();
	var_05 = getent("audio_alley_halfway_point","targetname");
	var_05 thread alleys_rpg_music_backup_trigger();
	var_06 = getent("mhunt_int_back_alleys_to_sniper_scramble","targetname");
	var_06 thread alley_ending_point_trigger();
	var_07 = getentarray("sniper_interior_trigger","targetname");
	thread sniper_interior_trigger_think(var_07);
	var_08 = getentarray("audio_hotel_broken_glass_pile","targetname");
	thread hotel_glass_footstep_think(var_08);
	var_09 = getent("audio_hotel_crowd_panic_wait","targetname");
	var_09 thread hotel_crowd_panic_trigger();
	var_0A = getent("audio_restaurant_water_floor","targetname");
	thread restaurant_wet_floor_think(var_0A);
}

//Function Number: 6
launch_loops()
{
	common_scripts\utility::loop_fx_sound("amb_mhunt_cafe_beach_lp",(21668,70325,-563),1);
	common_scripts\utility::loop_fx_sound("amb_greece_church_bells_lp",(22651,71204,-563),1);
	common_scripts\utility::loop_fx_sound("amb_mhunt_mrkt_walla_lp_01",(22440,69334,-615),1);
	common_scripts\utility::loop_fx_sound("amb_mhunt_mrkt_walla_lp_02",(22830,69946,-563),1);
	common_scripts\utility::loop_fx_sound("amb_mhunt_mrkt_walla_lp_03",(22354,70451,-563),1);
	common_scripts\utility::loop_fx_sound("amb_mhunt_mrkt_shoppers_lp",(22867,69544,-615),1);
	common_scripts\utility::loop_fx_sound("amb_mhunt_mrkt_fountain_lp",(22542,70444,-572),1);
	common_scripts\utility::loop_fx_sound("amb_greece_insects_lp",(24262,68908,-551),1);
	common_scripts\utility::loop_fx_sound("amb_greece_flies_swarm_lp",(24054,69007,-500),1);
	common_scripts\utility::loop_fx_sound("amb_greece_city_traffic_lp_01",(24584,69156,-414),1);
	common_scripts\utility::loop_fx_sound("amb_greece_electric_meter_lp",(23600,69473,-564),1);
	common_scripts\utility::loop_fx_sound("amb_greece_electric_meter_lp",(23675,69349,-564),1);
	common_scripts\utility::loop_fx_sound("amb_greece_electric_meter_lp",(23791,68890,-360),1);
	common_scripts\utility::loop_fx_sound("amb_greece_electric_meter_lp",(24070,69503,-515),1);
	common_scripts\utility::loop_fx_sound("amb_greece_electric_meter_lp",(23956,69253,-511),1);
	common_scripts\utility::loop_fx_sound("amb_greece_electric_meter_lp",(24398,69010,-505),1);
	common_scripts\utility::loop_fx_sound("radio_transmission_lp",(23364,68637,-177),1);
	common_scripts\utility::loop_fx_sound("computer_pulse_lp",(23649,68705,-177),1);
	common_scripts\utility::loop_fx_sound("computer_beeps_lp",(23237,68895,-177),1);
	common_scripts\utility::loop_fx_sound("water_fountain_lrg_dist_lp",(-19741,-47764,-422),1);
	common_scripts\utility::loop_fx_sound("kva_suv_idle",(-20295,-44429,-121),1);
	common_scripts\utility::loop_fx_sound("kva_suv_idle",(-19614,-43306,209),1);
	common_scripts\utility::loop_fx_sound("vistor_center_fountain",(22601,73786,-963),1);
	common_scripts\utility::loop_fx_sound("hotel_ext_ac_unit",(24115,76797,-1141),1);
	common_scripts\utility::loop_fx_sound("gondola_plaza_fountain",(23178,78161,-1509),1);
	common_scripts\utility::loop_fx_sound("fire_destroyed_car",(21118,80511,-1330),1);
	common_scripts\utility::loop_fx_sound("fire_dead_body",(20878,81943,-1365),1);
	common_scripts\utility::loop_fx_sound("fire_destroyed_car_finale",(19979,82466,-1658),1);
	common_scripts\utility::loop_fx_sound("amb_mhunt_hydrant_spray",(19439,82115,-1665),1);
}

//Function Number: 7
launch_line_emitters()
{
	wait(0.1);
	thread soundscripts\_audio::aud_play_line_emitter("cc_flag_01","flag_flap_lp",(-18569,-46931,452),(-18994,-46725,452));
	thread soundscripts\_audio::aud_play_line_emitter("finale_hydrant","amb_mhunt_hydrant_splatter",(19439,82115,-1665),(19443,81889,-1665));
}

//Function Number: 8
create_level_envelop_arrays()
{
	level.aud.envs = [];
	level.aud.envs["example_envelop"] = [[0,0],[0.082,0.426],[0.238,0.736],[0.408,0.844],[0.756,0.953],[1,1]];
	level.aud.envs["sniper_drone_hover_spd2vol"] = [[0,0.5],[30,0.7]];
	level.aud.envs["sniper_drone_hover_spd2pch"] = [[0,1],[30,1.2]];
	level.aud.envs["sniper_drone_lfe_spd2vol"] = [[0,0.4],[30,0.8]];
	level.aud.envs["sniper_drone_lfe_spd2pch"] = [[0,1],[30,1.2]];
	level.aud.envs["sniper_drone_fly_spd2vol"] = [[2,0],[8,0],[30,1]];
	level.aud.envs["sniper_drone_fly_spd2pch"] = [[8,1],[30,1.05]];
	level.aud.envs["sniper_drone_look_spd2vol"] = [[0.09,0],[0.1,1],[1,1]];
	level.aud.envs["sniper_drone_look_hover_spd2vol"] = [[2,1],[8,0]];
	level.aud.envs["snipe_report_volume"] = [[700,0.6],[900,0.7],[1150,0.8],[1350,0.9],[1600,1]];
	level.aud.envs["snipe_report_delay"] = [[750,0],[900,0],[1200,0.1],[1600,0.2],[1800,0.3]];
}

//Function Number: 9
precache_presets()
{
}

//Function Number: 10
register_snd_messages()
{
	soundscripts\_snd::snd_register_message("snd_zone_handler",::zone_handler);
	soundscripts\_snd::snd_register_message("snd_music_handler",::music_handler);
	soundscripts\_snd::snd_register_message("start_safehouse_intro_checkpoint",::start_safehouse_intro_checkpoint);
	soundscripts\_snd::snd_register_message("start_safehouse_follow_checkpoint",::start_safehouse_follow_checkpoint);
	soundscripts\_snd::snd_register_message("start_safehouse_xslice_checkpoint",::start_safehouse_xslice_checkpoint);
	soundscripts\_snd::snd_register_message("start_safehouse_clear_checkpoint",::start_safehouse_clear_checkpoint);
	soundscripts\_snd::snd_register_message("start_safehouse_transition_checkpoint",::start_safehouse_transition_checkpoint);
	soundscripts\_snd::snd_register_message("start_conf_center_intro_checkpoint",::start_conf_center_intro_checkpoint);
	soundscripts\_snd::snd_register_message("start_conf_center_support1_checkpoint",::start_conf_center_support1_checkpoint);
	soundscripts\_snd::snd_register_message("start_conf_center_support2_checkpoint",::start_conf_center_support2_checkpoint);
	soundscripts\_snd::snd_register_message("start_conf_center_support3_checkpoint",::start_conf_center_support3_checkpoint);
	soundscripts\_snd::snd_register_message("start_conf_center_kill_checkpoint",::start_conf_center_kill_checkpoint);
	soundscripts\_snd::snd_register_message("start_conf_center_combat_checkpoint",::start_conf_center_combat_checkpoint);
	soundscripts\_snd::snd_register_message("start_conf_center_outro_checkpoint",::start_conf_center_outro_checkpoint);
	soundscripts\_snd::snd_register_message("start_safehouse_exit_checkpoint",::start_safehouse_exit_checkpoint);
	soundscripts\_snd::snd_register_message("start_alleys_transition_checkpoint",::start_alleys_transition_checkpoint);
	soundscripts\_snd::snd_register_message("start_alleys_checkpoint",::start_alleys_checkpoint);
	soundscripts\_snd::snd_register_message("start_sniper_scramble_intro_checkpoint",::start_sniper_scramble_intro_checkpoint);
	soundscripts\_snd::snd_register_message("start_sniper_scramble_hotel_checkpoint",::start_sniper_scramble_hotel_checkpoint);
	soundscripts\_snd::snd_register_message("start_sniper_scramble_drones_checkpoint",::start_sniper_scramble_drones_checkpoint);
	soundscripts\_snd::snd_register_message("start_sniper_scramble_finale_checkpoint",::start_sniper_scramble_finale_checkpoint);
	soundscripts\_snd::snd_register_message("start_ending_ambush_checkpoint",::start_ending_ambush_checkpoint);
	soundscripts\_snd::snd_register_message("start_ending_fight_checkpoint",::start_ending_fight_checkpoint);
	soundscripts\_snd::snd_register_message("start_ending_hades_checkpoint",::start_ending_hades_checkpoint);
	soundscripts\_snd::snd_register_message("mhunt_cafe_cam_enter_front",::mhunt_cafe_cam_enter_front);
	soundscripts\_snd::snd_register_message("mhunt_cafe_cam_exit_front",::mhunt_cafe_cam_exit_front);
	soundscripts\_snd::snd_register_message("mhunt_cafe_cam_scan_target",::mhunt_cafe_cam_scan_target);
	soundscripts\_snd::snd_register_message("mhunt_cafe_cam_scan_start",::mhunt_cafe_cam_scan_start);
	soundscripts\_snd::snd_register_message("mhunt_cafe_cam_scan_stop",::mhunt_cafe_cam_scan_stop);
	soundscripts\_snd::snd_register_message("mhunt_cafe_cam_scan_fail",::mhunt_cafe_cam_scan_fail);
	soundscripts\_snd::snd_register_message("mhunt_cafe_cam_scan_get",::mhunt_cafe_cam_scan_get);
	soundscripts\_snd::snd_register_message("mhunt_cafe_cam_zoom_in",::mhunt_cafe_cam_zoom_in);
	soundscripts\_snd::snd_register_message("mhunt_cafe_cam_zoom_out",::mhunt_cafe_cam_zoom_out);
	soundscripts\_snd::snd_register_message("mhunt_cafe_cam_switch",::mhunt_cafe_cam_switch);
	soundscripts\_snd::snd_register_message("mhunt_cafe_cam1_switch",::mhunt_cafe_cam1_switch);
	soundscripts\_snd::snd_register_message("mhunt_cafe_cam2_switch",::mhunt_cafe_cam2_switch);
	soundscripts\_snd::snd_register_message("mhunt_cafe_cam3_switch",::mhunt_cafe_cam3_switch);
	soundscripts\_snd::snd_register_message("mhunt_cafe_cam4_switch",::mhunt_cafe_cam4_switch);
	soundscripts\_snd::snd_register_message("start_kva_follow_music",::start_kva_follow_music);
	soundscripts\_snd::snd_register_message("start_kva_assault_music",::start_kva_assault_music);
	soundscripts\_snd::snd_register_message("mhunt_melee_keycard_tkdwn",::mhunt_melee_keycard_tkdwn);
	soundscripts\_snd::snd_register_message("start_threat_grenade_mixer",::start_threat_grenade_mixer);
	soundscripts\_snd::snd_register_message("start_safehouse_stealth_music",::start_safehouse_stealth_music);
	soundscripts\_snd::snd_register_message("mhunt_tv_broadcast",::mhunt_tv_broadcast);
	soundscripts\_snd::snd_register_message("mhunt_tv_dest_expl",::mhunt_tv_dest_expl);
	soundscripts\_snd::snd_register_message("start_safehouse_stairs_music",::start_safehouse_stairs_music);
	soundscripts\_snd::snd_register_message("start_videochat_screen_turn_on",::start_videochat_screen_turn_on);
	soundscripts\_snd::snd_register_message("start_videochat_screen_turn_off",::start_videochat_screen_turn_off);
	soundscripts\_snd::snd_register_message("start_safehouse_guard_03_music",::start_safehouse_guard_03_music);
	soundscripts\_snd::snd_register_message("safehouse_exo_trans_fade_out",::safehouse_exo_trans_fade_out);
	soundscripts\_snd::snd_register_message("start_safehouse_exo_trans_music",::start_safehouse_exo_trans_music);
	soundscripts\_snd::snd_register_message("safehouse_exo_trans_fade_in",::safehouse_exo_trans_fade_in);
	soundscripts\_snd::snd_register_message("balcony_sniper_drone_idle",::balcony_sniper_drone_idle);
	soundscripts\_snd::snd_register_message("wasp_cloak_on",::wasp_cloak_on);
	soundscripts\_snd::snd_register_message("drone_control_pad_end",::drone_control_pad_end);
	soundscripts\_snd::snd_register_message("start_sniper_drone_deploy",::start_sniper_drone_deploy);
	soundscripts\_snd::snd_register_message("start_sniper_drone",::start_sniper_drone);
	soundscripts\_snd::snd_register_message("stop_sniper_drone",::stop_sniper_drone);
	soundscripts\_snd::snd_register_message("start_sniper_drone_zoom",::start_sniper_drone_zoom);
	soundscripts\_snd::snd_register_message("stop_sniper_drone_zoom",::stop_sniper_drone_zoom);
	soundscripts\_snd::snd_register_message("unmute_wasp_oneshots",::unmute_wasp_oneshots);
	soundscripts\_snd::snd_register_message("sniper_drone_dry_fire",::sniper_drone_dry_fire);
	soundscripts\_snd::snd_register_message("start_veh_moving_truck",::start_veh_moving_truck);
	soundscripts\_snd::snd_register_message("veh_moving_truck_chkpt",::veh_moving_truck_chkpt);
	soundscripts\_snd::snd_register_message("cc_kva_alerted_walla",::cc_kva_alerted_walla);
	soundscripts\_snd::snd_register_message("start_tower_bells",::start_tower_bells);
	soundscripts\_snd::snd_register_message("start_gate_breach_music",::start_gate_breach_music);
	soundscripts\_snd::snd_register_message("start_burke_ambush_slomo",::start_burke_ambush_slomo);
	soundscripts\_snd::snd_register_message("stop_burke_ambush_slomo",::stop_burke_ambush_slomo);
	soundscripts\_snd::snd_register_message("npc_shoots_pool_enemy",::npc_shoots_pool_enemy);
	soundscripts\_snd::snd_register_message("atrium_breach_signal_start",::atrium_breach_signal_start);
	soundscripts\_snd::snd_register_message("start_atrium_breach_music",::start_atrium_breach_music);
	soundscripts\_snd::snd_register_message("start_atrium_fight",::start_atrium_fight);
	soundscripts\_snd::snd_register_message("stop_atrium_fight",::stop_atrium_fight);
	soundscripts\_snd::snd_register_message("atrium_timer_expire",::atrium_timer_expire);
	soundscripts\_snd::snd_register_message("parking_lot_runners",::parking_lot_runners);
	soundscripts\_snd::snd_register_message("parking_lot_clear",::parking_lot_clear);
	soundscripts\_snd::snd_register_message("start_car_alarm",::start_car_alarm);
	soundscripts\_snd::snd_register_message("stop_car_alarm",::stop_car_alarm);
	soundscripts\_snd::snd_register_message("start_hades_transition",::start_hades_transition);
	soundscripts\_snd::snd_register_message("begin_kill_hades_sequence",::begin_kill_hades_sequence);
	soundscripts\_snd::snd_register_message("start_hades_double_stinger",::start_hades_double_stinger);
	soundscripts\_snd::snd_register_message("hades_is_dead",::hades_is_dead);
	soundscripts\_snd::snd_register_message("start_hades_breach",::start_hades_breach);
	soundscripts\_snd::snd_register_message("start_hades_breach_door",::start_hades_breach_door);
	soundscripts\_snd::snd_register_message("start_hades_flashbang",::start_hades_flashbang);
	soundscripts\_snd::snd_register_message("hades_rigged_walla",::hades_rigged_walla);
	soundscripts\_snd::snd_register_message("hades_explosion_slowmo_start",::hades_explosion_slowmo_start);
	soundscripts\_snd::snd_register_message("hades_explosion_slowmo_end",::hades_explosion_slowmo_end);
	soundscripts\_snd::snd_register_message("wasp_cloak_off",::wasp_cloak_off);
	soundscripts\_snd::snd_register_message("start_wasp_flicker",::start_wasp_flicker);
	soundscripts\_snd::snd_register_message("start_cc_open_combat",::start_cc_open_combat);
	soundscripts\_snd::snd_register_message("mhunt_cc_assault_veh_01_approach",::mhunt_cc_assault_veh_01_approach);
	soundscripts\_snd::snd_register_message("cc_technical_turret_fire",::cc_technical_turret_fire);
	soundscripts\_snd::snd_register_message("mhunt_cc_parked_car_expl",::mhunt_cc_parked_car_expl);
	soundscripts\_snd::snd_register_message("mhunt_cc_assault_veh_02_approach",::mhunt_cc_assault_veh_02_approach);
	soundscripts\_snd::snd_register_message("mhunt_cc_assault_veh_03_approach",::mhunt_cc_assault_veh_03_approach);
	soundscripts\_snd::snd_register_message("mhunt_cc_hades_veh_escape",::mhunt_cc_hades_veh_escape);
	soundscripts\_snd::snd_register_message("start_kdrone_launch",::start_kdrone_launch);
	soundscripts\_snd::snd_register_message("start_kdrone_loop",::start_kdrone_loop);
	soundscripts\_snd::snd_register_message("start_wasp_missile_warning",::start_wasp_missile_warning);
	soundscripts\_snd::snd_register_message("stop_wasp_missile_warning",::stop_wasp_missile_warning);
	soundscripts\_snd::snd_register_message("kamikaze_drone_explo",::kamikaze_drone_explo);
	soundscripts\_snd::snd_register_message("start_sniper_drone_death",::start_sniper_drone_death);
	soundscripts\_snd::snd_register_message("start_wasp_death_explo",::start_wasp_death_explo);
	soundscripts\_snd::snd_register_message("sniper_drone_dmg_fire",::sniper_drone_dmg_fire);
	soundscripts\_snd::snd_register_message("start_drone_death_static",::start_drone_death_static);
	soundscripts\_snd::snd_register_message("stop_drone_death_static",::stop_drone_death_static);
	soundscripts\_snd::snd_register_message("mhunt_safehouse_cc_expl_distant",::mhunt_safehouse_cc_expl_distant);
	soundscripts\_snd::snd_register_message("safehouse_escape_music",::safehouse_escape_music);
	soundscripts\_snd::snd_register_message("safehouse_sonic_destruct",::safehouse_sonic_destruct);
	soundscripts\_snd::snd_register_message("start_sonic_attack_mix",::start_sonic_attack_mix);
	soundscripts\_snd::snd_register_message("tunnel_runner_walla",::tunnel_runner_walla);
	soundscripts\_snd::snd_register_message("start_trans_to_alleys_panic",::start_trans_to_alleys_panic);
	soundscripts\_snd::snd_register_message("stop_trans_to_alleys_panic",::stop_trans_to_alleys_panic);
	soundscripts\_snd::snd_register_message("walla_bridge_runners",::walla_bridge_runners);
	soundscripts\_snd::snd_register_message("smoking_civ_panic",::smoking_civ_panic);
	soundscripts\_snd::snd_register_message("civ_panic_door_run_in",::civ_panic_door_run_in);
	soundscripts\_snd::snd_register_message("trans_civ_01_flee_kva",::trans_civ_01_flee_kva);
	soundscripts\_snd::snd_register_message("trans_civ_03_flee_kva",::trans_civ_03_flee_kva);
	soundscripts\_snd::snd_register_message("start_alleys_combat_music",::start_alleys_combat_music);
	soundscripts\_snd::snd_register_message("alleys_rpg_fight_music",::alleys_rpg_fight_music);
	soundscripts\_snd::snd_register_message("stop_alleys_emergency_audio",::stop_alleys_emergency_audio);
	soundscripts\_snd::snd_register_message("alleys_music_end",::alleys_music_end);
	soundscripts\_snd::snd_register_message("windmill_sniper_shot",::windmill_sniper_shot);
	soundscripts\_snd::snd_register_message("windmill_sniper_shot_multi",::windmill_sniper_shot_multi);
	soundscripts\_snd::snd_register_message("windmill_sniper_shot_whizby",::windmill_sniper_shot_whizby);
	soundscripts\_snd::snd_register_message("mhunt_snpr_blood_impact_splat",::mhunt_snpr_blood_impact_splat);
	soundscripts\_snd::snd_register_message("scramble_amb_siren_loop",::scramble_amb_siren_loop);
	soundscripts\_snd::snd_register_message("start_sniper_scramble_music",::start_sniper_scramble_music);
	soundscripts\_snd::snd_register_message("patio_intro_civ_death",::patio_intro_civ_death);
	soundscripts\_snd::snd_register_message("patio_civ_01_cower",::patio_civ_01_cower);
	soundscripts\_snd::snd_register_message("patio_civ_03_scream",::patio_civ_03_scream);
	soundscripts\_snd::snd_register_message("gap_jump_squib_occlusion",::gap_jump_squib_occlusion);
	soundscripts\_snd::snd_register_message("hotel_crowd_panic_walla",::hotel_crowd_panic_walla);
	soundscripts\_snd::snd_register_message("hotel_female_01_hallway",::hotel_female_01_hallway);
	soundscripts\_snd::snd_register_message("hotel_civ_04_death",::hotel_civ_04_death);
	soundscripts\_snd::snd_register_message("sniper_suppression_hit_alert",::sniper_suppression_hit_alert);
	soundscripts\_snd::snd_register_message("pool_civ_01_cower_setup",::pool_civ_01_cower_setup);
	soundscripts\_snd::snd_register_message("pool_civ_01_cower",::pool_civ_01_cower);
	soundscripts\_snd::snd_register_message("drone_civ_02_flee",::drone_civ_02_flee);
	soundscripts\_snd::snd_register_message("mhunt_snpr_dest_cafe_wall",::mhunt_snpr_dest_cafe_wall);
	soundscripts\_snd::snd_register_message("gondola_movement_loops",::gondola_movement_loops);
	soundscripts\_snd::snd_register_message("start_swarm_drones_context",::start_swarm_drones_context);
	soundscripts\_snd::snd_register_message("restaurant_doors_open",::restaurant_doors_open);
	soundscripts\_snd::snd_register_message("restaurant_door_civ_killed",::restaurant_door_civ_killed);
	soundscripts\_snd::snd_register_message("restaurant_civ_03_cower",::restaurant_civ_03_cower);
	soundscripts\_snd::snd_register_message("restaurant_fish_tank_destruct",::restaurant_fish_tank_destruct);
	soundscripts\_snd::snd_register_message("ally_shoot_rpg_at_drones",::ally_shoot_rpg_at_drones);
	soundscripts\_snd::snd_register_message("finale_civ_04_cower",::finale_civ_04_cower);
	soundscripts\_snd::snd_register_message("manga_rocket_trail",::manga_rocket_trail);
	soundscripts\_snd::snd_register_message("manga_rocket_explosion",::manga_rocket_explosion);
	soundscripts\_snd::snd_register_message("stingerm7_shoot_tower",::stingerm7_shoot_tower);
	soundscripts\_snd::snd_register_message("mhunt_snpr_tower_collapse",::mhunt_snpr_tower_collapse);
	soundscripts\_snd::snd_register_message("stop_swarm_drones_context",::stop_swarm_drones_context);
	soundscripts\_snd::snd_register_message("exit_truck_fire",::exit_truck_fire);
	soundscripts\_snd::snd_register_message("start_finale_transition_music",::start_finale_transition_music);
	soundscripts\_snd::snd_register_message("finale_street_crowd",::finale_street_crowd);
	soundscripts\_snd::snd_register_message("player_place_ied_foley",::player_place_ied_foley);
	soundscripts\_snd::snd_register_message("start_ied_convoy_ambush_expl",::start_ied_convoy_ambush_expl);
	soundscripts\_snd::snd_register_message("start_ied_convoy_slomo_end",::start_ied_convoy_slomo_end);
	soundscripts\_snd::snd_register_message("stop_ied_convoy_ambush_expl",::stop_ied_convoy_ambush_expl);
	soundscripts\_snd::snd_register_message("convoy_crash_emitters",::convoy_crash_emitters);
	soundscripts\_snd::snd_register_message("convoy_truck_explosion",::convoy_truck_explosion);
	soundscripts\_snd::snd_register_message("enemy_on_fire",::enemy_on_fire);
	soundscripts\_snd::snd_register_message("start_finale_fight_music",::start_finale_fight_music);
	soundscripts\_snd::snd_register_message("stop_finale_fight_music",::stop_finale_fight_music);
	soundscripts\_snd::snd_register_message("start_hades_suv_extraction",::start_hades_suv_extraction);
	soundscripts\_snd::snd_register_message("stop_hades_suv_extraction",::stop_hades_suv_extraction);
	soundscripts\_snd::snd_register_message("start_finale_suv_damage",::start_finale_suv_damage);
	soundscripts\_snd::snd_register_message("start_finale_h2h_music",::start_finale_h2h_music);
	soundscripts\_snd::snd_register_message("start_exo_sonic_attack_fail",::start_exo_sonic_attack_fail);
	soundscripts\_snd::snd_register_message("hades_throat_slash",::hades_throat_slash);
	soundscripts\_snd::snd_register_message("start_hades_kill_interact_fail",::start_hades_kill_interact_fail);
	soundscripts\_snd::snd_register_message("mhunt_level_end",::mhunt_level_end);
}

//Function Number: 11
zone_handler(param_00,param_01)
{
}

//Function Number: 12
music_handler(param_00,param_01)
{
	switch(param_00)
	{
		case "start_kva_shadow":
			soundscripts\_audio::aud_set_music_submix(0.8,0);
			soundscripts\_audio_music::mus_play("mhunt_mus_safehouse_follow",0,0.5);
			break;

		case "start_kva_ambush":
			soundscripts\_audio::aud_set_music_submix(0,4);
			break;

		case "start_kva_ambush_over":
			soundscripts\_audio::aud_set_music_submix(0.8,4);
			break;

		case "start_safehouse_hades_call_kill":
			soundscripts\_audio_music::mus_stop(5);
			break;

		case "start_conference_stealth":
			soundscripts\_audio::aud_set_music_submix(1,0);
			soundscripts\_audio_music::mus_play("mhunt_mus_conference_stealth");
			break;

		case "start_burke_ambush_slomo":
			soundscripts\_audio::aud_set_music_submix(0,3);
			break;

		case "stop_burke_ambush_slomo":
			wait(2);
			soundscripts\_audio::aud_set_music_submix(1,3);
			break;

		case "stop_atrium_fight":
			wait(4);
			soundscripts\_audio_music::mus_stop(9);
			break;

		case "start_hades_double_stinger":
			soundscripts\_audio::aud_set_music_submix(0.9,0);
			soundscripts\_audio_music::mus_play("mhunt_mus_conference_stinger");
			break;

		case "start_conference_battle":
			wait(2);
			soundscripts\_audio::aud_set_music_submix(0.7,0);
			soundscripts\_snd_playsound::snd_play_2d("mhunt_mus_conference_battle_in");
			soundscripts\_audio_music::mus_play("mhunt_mus_conference_battle",0,0);
			break;

		case "start_sniper_drone_death":
			wait(1.2);
			soundscripts\_audio::aud_set_music_submix(0.7,0);
			soundscripts\_audio_music::mus_play("mhunt_mus_conference_battle_out",0,0);
			break;

		case "start_safehouse_escape":
			soundscripts\_audio::aud_set_music_submix(0.8,0);
			soundscripts\_audio_music::mus_play("mhunt_mus_safehouse_escape");
			break;

		case "start_safehouse_gate_bash":
			soundscripts\_audio_music::mus_stop(12);
			break;

		case "start_alleys_combat":
			soundscripts\_audio::aud_set_music_submix(0.5,0);
			soundscripts\_snd_playsound::snd_play_2d("mhunt_mus_alleys_combat_in","",0.25);
			soundscripts\_audio_music::mus_play("mhunt_mus_alleys_combat",0,0.25);
			break;

		case "stop_alleys_combat":
			wait(5.5);
			soundscripts\_audio_music::mus_play("mhunt_mus_alleys_combat_out",0,0);
			break;

		case "start_sniper_scramble":
			wait(0.6);
			soundscripts\_audio::aud_set_music_submix(0.6,0);
			soundscripts\_snd_playsound::snd_play_2d("mhunt_mus_sniper_scramble_in");
			soundscripts\_audio_music::mus_play("mhunt_mus_sniper_scramble_patio",0,0);
			break;

		case "start_scramble_hotel":
			soundscripts\_audio::aud_set_music_submix(0.6,0);
			soundscripts\_audio_music::mus_play("mhunt_mus_sniper_scramble");
			break;

		case "start_scramble_tower_collapse":
			soundscripts\_audio_music::mus_stop(6);
			break;

		case "start_transition_to_finale":
			soundscripts\_audio::aud_set_music_submix(0.7,0);
			soundscripts\_audio_music::mus_play("mhunt_mus_tower_collapsed");
			break;

		case "start_truck_drive_in_ied":
			soundscripts\_audio_music::mus_stop(4);
			break;

		case "start_finale_fight_music":
			soundscripts\_audio::aud_set_music_submix(0.7,0);
			soundscripts\_audio_music::mus_play("mhunt_mus_finale_fight",0,0.25);
			break;

		case "stop_finale_fight_music":
			soundscripts\_audio_music::mus_play("mhunt_mus_finale_fight_out",0,0);
			break;

		case "start_finale_h2h_music":
			soundscripts\_snd_playsound::snd_play_2d("mhunt_mus_finale_h2h_in");
			soundscripts\_audio_music::mus_play("mhunt_mus_finale_h2h_combat",0,0);
			break;

		case "stop_finale_h2h_music":
			soundscripts\_snd_playsound::snd_play_2d("mhunt_mus_finale_h2h_end");
			soundscripts\_audio_music::mus_stop(0.2);
			break;

		case "start_finale_irons_knows":
			soundscripts\_audio_music::mus_play("mhunt_mus_finale_irons_knows",0,0);
			break;

		default:
			soundscripts\_audio::aud_print_warning("\tMUSIC MESSAGE NOT HANDLED: " + param_00);
			break;
	}
}

//Function Number: 13
start_safehouse_intro_checkpoint(param_00)
{
	soundscripts\_audio_zone_manager::azm_start_zone("mhunt_ext_cafe_patio");
	thread cafe_market_damb();
	thread safehouse_backyard_damb();
	thread cafe_market_music_play();
}

//Function Number: 14
start_safehouse_follow_checkpoint(param_00)
{
	soundscripts\_audio_zone_manager::azm_start_zone("mhunt_ext_cafe_patio");
	thread cafe_market_damb();
	thread safehouse_backyard_damb();
	thread cafe_market_moped_away();
	thread cafe_market_plane_flyover();
}

//Function Number: 15
start_safehouse_xslice_checkpoint(param_00)
{
	soundscripts\_audio_zone_manager::azm_start_zone("mhunt_ext_safehouse_courtyard");
	soundscripts\_snd::snd_music_message("start_kva_shadow");
	thread cafe_market_damb();
	thread safehouse_backyard_damb();
}

//Function Number: 16
start_safehouse_clear_checkpoint(param_00)
{
	soundscripts\_audio_zone_manager::azm_start_zone("mhunt_ext_safehouse_courtyard");
	soundscripts\_snd::snd_music_message("start_kva_shadow");
	thread cafe_market_damb();
	thread safehouse_backyard_damb();
}

//Function Number: 17
start_safehouse_transition_checkpoint(param_00)
{
	soundscripts\_audio_zone_manager::azm_start_zone("mhunt_int_safehouse_floor_2");
	soundscripts\_snd::snd_music_message("start_exo_trans_music");
	thread cafe_market_damb();
	thread safehouse_backyard_damb();
}

//Function Number: 18
start_conf_center_intro_checkpoint(param_00)
{
	soundscripts\_audio_zone_manager::azm_start_zone("mhunt_int_safehouse_balcony");
	soundscripts\_snd::snd_music_message("start_exo_trans_music");
	thread cafe_market_damb();
	thread safehouse_backyard_damb();
}

//Function Number: 19
start_conf_center_support1_checkpoint(param_00)
{
	soundscripts\_audio_zone_manager::azm_start_zone("mhunt_ext_drone_conf_center");
	level.aud.support_01_checkpoint = 1;
}

//Function Number: 20
start_conf_center_support2_checkpoint(param_00)
{
	soundscripts\_audio_zone_manager::azm_start_zone("mhunt_ext_drone_conf_center");
	soundscripts\_snd_timescale::snd_set_timescale("mhunt_balcony_takedown");
	wait(0.05);
	soundscripts\_snd::snd_music_message("start_conference_stealth");
	level notify("moving_truck_checkpoint");
}

//Function Number: 21
start_conf_center_support3_checkpoint(param_00)
{
	soundscripts\_audio_zone_manager::azm_start_zone("mhunt_ext_drone_conf_center");
	soundscripts\_snd::snd_music_message("start_conference_stealth");
	level notify("moving_truck_checkpoint");
}

//Function Number: 22
start_conf_center_kill_checkpoint(param_00)
{
	soundscripts\_audio_zone_manager::azm_start_zone("mhunt_ext_drone_conf_center");
	soundscripts\_snd::snd_music_message("start_cc_kill_checkpoint");
	level notify("moving_truck_checkpoint");
}

//Function Number: 23
start_conf_center_combat_checkpoint(param_00)
{
	soundscripts\_snd::snd_music_message("start_conference_battle");
	level notify("moving_truck_checkpoint");
	thread conference_center_fire();
	thread conference_center_explo_zone();
}

//Function Number: 24
start_conf_center_outro_checkpoint(param_00)
{
	soundscripts\_snd::snd_music_message("start_conference_battle");
	level notify("moving_truck_checkpoint");
	thread conference_center_fire();
	thread conference_center_explo_zone();
}

//Function Number: 25
start_safehouse_exit_checkpoint(param_00)
{
	soundscripts\_snd_common::snd_enable_soundcontextoverride("mhunt_safehouse_exit");
	soundscripts\_audio_zone_manager::azm_start_zone("mhunt_int_safehouse_balcony");
	thread safehouse_balcony_siren();
}

//Function Number: 26
start_alleys_transition_checkpoint(param_00)
{
	soundscripts\_audio_zone_manager::azm_start_zone("mhunt_ext_back_alleys_main");
	soundscripts\_snd::snd_message("start_trans_to_alleys_panic");
}

//Function Number: 27
start_alleys_checkpoint(param_00)
{
	soundscripts\_audio_zone_manager::azm_start_zone("mhunt_ext_back_alleys_main");
	soundscripts\_snd::snd_music_message("start_alleys_combat");
	thread alleys_distant_standard_siren_loop();
	thread alleys_distant_emergency_siren_blasts();
}

//Function Number: 28
start_sniper_scramble_intro_checkpoint(param_00)
{
	soundscripts\_audio_zone_manager::azm_start_zone("mhunt_int_back_alleys_stripmall_upr_flr");
}

//Function Number: 29
start_sniper_scramble_hotel_checkpoint(param_00)
{
	soundscripts\_snd::snd_music_message("start_sniper_scramble");
	soundscripts\_audio_zone_manager::azm_start_zone("mhunt_int_sniper_long_hall");
	thread hotel_crowd_panic_walla_chkpt();
	level notify("start_hotel_glass_think");
}

//Function Number: 30
start_sniper_scramble_drones_checkpoint(param_00)
{
	soundscripts\_snd::snd_music_message("start_sniper_scramble");
	soundscripts\_audio_zone_manager::azm_start_zone("mhunt_ext_sniper_courtyard");
	thread scramble_amb_siren_loop();
}

//Function Number: 31
start_sniper_scramble_finale_checkpoint(param_00)
{
	soundscripts\_snd::snd_music_message("start_sniper_scramble");
	soundscripts\_audio_zone_manager::azm_start_zone("mhunt_int_sniper_restaurant");
	thread scramble_amb_siren_loop();
}

//Function Number: 32
start_ending_ambush_checkpoint(param_00)
{
	soundscripts\_audio_zone_manager::azm_start_zone("mhunt_ext_sniper_main_street");
	soundscripts\_snd::snd_music_message("start_transition_to_finale");
	thread scramble_amb_siren_loop();
	thread finale_street_crowd();
}

//Function Number: 33
start_ending_fight_checkpoint(param_00)
{
	soundscripts\_snd::snd_music_message("start_finale_fight_music");
	soundscripts\_audio_zone_manager::azm_start_zone("mhunt_ext_sniper_main_street");
	thread convoy_crash_emitters();
	thread scramble_amb_siren_loop();
}

//Function Number: 34
start_ending_hades_checkpoint(param_00)
{
	soundscripts\_audio_zone_manager::azm_start_zone("mhunt_ext_sniper_main_street");
	thread convoy_crash_emitters();
	thread scramble_amb_siren_loop();
}

//Function Number: 35
cafe_market_damb()
{
	level endon("end_cafe_market_pre_cc");
	if(isdefined(level.aud.cafe_market_damb) && level.aud.cafe_market_damb)
	{
		return;
	}

	level.aud.cafe_market_damb = 1;
	soundscripts\_audio_dynamic_ambi::damb_start_preset_at_point("mhunt_mrkt_vendor_shout",(22566,70538,-563),"mhunt_mrkt_vendor_shout_01");
	soundscripts\_audio_dynamic_ambi::damb_start_preset_at_point("mhunt_cafe_boat_horn",(21776,70183,-563),"mhunt_cafe_boat_horn_01");
	soundscripts\_audio_dynamic_ambi::damb_start_preset_at_point("mhunt_mrkt_bike_bells",(22256,70437,-563),"mhunt_mrkt_bike_bells_01");
	soundscripts\_audio_dynamic_ambi::damb_start_preset_at_point("mhunt_cafe_seagulls",(22007,70307,-563),"mhunt_cafe_seagulls");
	soundscripts\_audio_dynamic_ambi::damb_start_preset_at_point("mhunt_safehouse_bird_call",(23100,69660,-440),"mhunt_bird_call_01");
	soundscripts\_audio_dynamic_ambi::damb_start_preset_at_point("mhunt_mrkt_murmur",(22566,70538,-563),"mhunt_mrkt_murmur_01");
}

//Function Number: 36
stop_cafe_market_damb()
{
	level notify("end_cafe_market_pre_cc");
}

//Function Number: 37
cafe_market_moped_away()
{
	wait(randomfloatrange(37,45));
	soundscripts\_snd_playsound::snd_play_at("amb_mhunt_veh_moped_away",(22787,70314,-563));
}

//Function Number: 38
cafe_market_plane_flyover()
{
	wait(randomfloatrange(17,21));
	soundscripts\_snd_playsound::snd_play_at("amb_mhunt_veh_plane_by",(22816,69821,-563));
}

//Function Number: 39
cafe_market_music_play()
{
	wait(randomfloatrange(1,2));
	soundscripts\_snd_playsound::snd_play_at("amb_mhunt_cafe_muzak",(22193,69637,-563),"stop_cafe_muzak",0,1);
}

//Function Number: 40
cafe_market_music_stop()
{
	level notify("stop_cafe_muzak");
}

//Function Number: 41
mhunt_cafe_cam_enter_front()
{
	level.player enablefocus(20,30,1,0);
	soundscripts\_snd_playsound::snd_play_2d("mhunt_cafe_cam_enter_front");
	soundscripts\_audio_mix_manager::mm_add_submix("mhunt_cafe_security_cam_zoom_out");
}

//Function Number: 42
start_cafe_cam_mvmnt_loops()
{
	level endon("stop_cam_mvmnt_loops");
	var_00 = 0;
	var_01 = 0;
	var_02 = level.player getplayerangles();
	if(!isdefined(level.aud.looklp))
	{
		level.aud.looklp = soundscripts\_snd_playsound::snd_play_loop_2d("mhunt_cafe_cam_mvmnt_lp","stop_cam_mvmnt_loops",0,0.1,0);
	}

	for(;;)
	{
		wait 0.05;
		waittillframeend;
		var_03 = level.player getnormalizedcameramovements();
		var_04 = max(abs(var_03[0]),abs(var_03[1]));
		if(var_04 - var_01 > 0)
		{
			var_01 = var_01 + 0.15 * var_04 - var_01;
		}
		else
		{
			var_01 = var_01 + 1 * var_04 - var_01;
		}

		var_05 = level.player getplayerangles();
		var_06 = abs(var_05[0] - var_02[0]) > 0.1 || abs(var_05[1] - var_02[1]) > 0.1;
		if(!var_06)
		{
			var_01 = 0;
		}

		if(var_01 > 0.05 && !var_00)
		{
			var_00 = 1;
			level.aud.start_look = soundscripts\_snd_playsound::snd_play_2d("mhunt_cafe_cam_mvmnt_start");
		}
		else if(var_01 <= 0.05 && var_00)
		{
			var_00 = 0;
			level.aud.stop_look = soundscripts\_snd_playsound::snd_play_2d("mhunt_cafe_cam_mvmnt_stop");
		}

		if(isdefined(level.aud.looklp))
		{
			var_07 = soundscripts\_snd::snd_map(var_01,level.aud.envs["sniper_drone_look_spd2vol"]);
			level.aud.looklp scalevolume(var_07);
		}

		var_02 = level.player getplayerangles();
	}
}

//Function Number: 43
mhunt_cafe_cam_scan_target()
{
	if(isdefined(level.aud.camera_scan) && level.aud.camera_scan)
	{
		return;
	}

	level.aud.camera_scan = 1;
	soundscripts\_snd_playsound::snd_play_2d("mhunt_cafe_cam_scan_target");
	wait(0.525);
	level.aud.camera_scan = 0;
}

//Function Number: 44
mhunt_cafe_cam_scan_start()
{
	if(!isdefined(level.aud.cam_scan_lp))
	{
		level.aud.cam_scan_lp = soundscripts\_snd_playsound::snd_play_loop_2d("mhunt_cafe_cam_scan_lp","stop_cam_lp",0,0.1);
	}
}

//Function Number: 45
mhunt_cafe_cam_scan_stop()
{
	if(isdefined(level.aud.cam_scan_lp))
	{
		level notify("stop_cam_lp");
	}
}

//Function Number: 46
mhunt_cafe_cam_scan_fail()
{
	soundscripts\_snd_playsound::snd_play_2d("mhunt_cafe_cam_scan_fail");
}

//Function Number: 47
mhunt_cafe_cam_scan_get()
{
	soundscripts\_snd_playsound::snd_play_2d("mhunt_cafe_cam_scan_get");
	thread cafe_market_music_stop();
}

//Function Number: 48
mhunt_cafe_cam_zoom_in()
{
	if(isdefined(level.aud.cam_zoom_in))
	{
		level notify("stop_cam_zoom_out");
	}

	level.aud.cam_zoom_in = soundscripts\_snd_playsound::snd_play_2d("mhunt_cafe_cam_zoom_in","stop_cam_zoom_in",0,0.12);
	level.player enablefocus(20,30,0.125,1);
	soundscripts\_audio_mix_manager::mm_add_submix("mhunt_cafe_security_cam_zoom_in");
	soundscripts\_audio_mix_manager::mm_clear_submix("mhunt_cafe_security_cam_zoom_out");
}

//Function Number: 49
mhunt_cafe_cam_zoom_out()
{
	if(isdefined(level.aud.cam_zoom_out))
	{
		level notify("stop_cam_zoom_in");
	}

	level.aud.cam_zoom_out = soundscripts\_snd_playsound::snd_play_2d("mhunt_cafe_cam_zoom_out","stop_cam_zoom_out",0,0.12);
	level.player enablefocus(20,30,1,1);
	soundscripts\_audio_mix_manager::mm_add_submix("mhunt_cafe_security_cam_zoom_out");
	soundscripts\_audio_mix_manager::mm_clear_submix("mhunt_cafe_security_cam_zoom_in");
}

//Function Number: 50
mhunt_cafe_cam_switch()
{
	soundscripts\_snd_playsound::snd_play_2d("mhunt_cafe_cam_switch");
}

//Function Number: 51
mhunt_cafe_cam1_switch()
{
	if(isdefined(level.aud.cameraloop))
	{
		level.aud.cameraloop soundscripts\_snd_playsound::snd_stop_sound();
		level.aud.cameraloop = undefined;
		level notify("stop_cam_mvmnt_loops");
	}

	level.aud.cameraloop = soundscripts\_snd_playsound::snd_play_loop_at("mhunt_cafe_cam_amb_01_lp",(22478,70629,-535),undefined,0.15,0.15);
	wait(0.15);
	thread start_cafe_cam_mvmnt_loops();
}

//Function Number: 52
mhunt_cafe_cam2_switch()
{
	if(isdefined(level.aud.cameraloop))
	{
		level.aud.cameraloop soundscripts\_snd_playsound::snd_stop_sound();
		level.aud.cameraloop = undefined;
		level notify("stop_cam_mvmnt_loops");
	}

	level.aud.cameraloop = soundscripts\_snd_playsound::snd_play_loop_at("mhunt_cafe_cam_amb_02_lp",(22768,70184,-580),undefined,0.15,0.15);
	wait(0.15);
	thread start_cafe_cam_mvmnt_loops();
}

//Function Number: 53
mhunt_cafe_cam3_switch()
{
	if(isdefined(level.aud.cameraloop))
	{
		level.aud.cameraloop soundscripts\_snd_playsound::snd_stop_sound();
		level.aud.cameraloop = undefined;
		level notify("stop_cam_mvmnt_loops");
	}

	level.aud.cameraloop = soundscripts\_snd_playsound::snd_play_loop_at("mhunt_cafe_cam_amb_03_lp",(22827,701192,-555),undefined,0.15,0.15);
	wait(0.15);
	thread start_cafe_cam_mvmnt_loops();
}

//Function Number: 54
mhunt_cafe_cam4_switch()
{
	if(isdefined(level.aud.cameraloop))
	{
		level.aud.cameraloop soundscripts\_snd_playsound::snd_stop_sound();
		level.aud.cameraloop = undefined;
		level notify("stop_cam_mvmnt_loops");
	}

	level.aud.cameraloop = soundscripts\_snd_playsound::snd_play_loop_at("mhunt_cafe_cam_amb_04_lp",(22460,70497,-556),undefined,0.15,0.15);
	wait(0.15);
	thread start_cafe_cam_mvmnt_loops();
}

//Function Number: 55
mhunt_cafe_cam_exit_front()
{
	level.player disablefocus(2);
	soundscripts\_snd_playsound::snd_play_2d("mhunt_cafe_cam_exit_front");
	soundscripts\_audio_mix_manager::mm_clear_submix("mhunt_cafe_security_cam_zoom_out");
	soundscripts\_audio_mix_manager::mm_clear_submix("mhunt_cafe_security_cam_zoom_in");
	if(isdefined(level.aud.cameraloop))
	{
		level.aud.cameraloop soundscripts\_snd_playsound::snd_stop_sound();
		level.aud.cameraloop = undefined;
		level notify("stop_cam_mvmnt_loops");
	}
}

//Function Number: 56
safehouse_backyard_damb()
{
	soundscripts\_audio_dynamic_ambi::damb_start_preset_at_point("mhunt_safehouse_dog_bark",(24008,69800,-510),"greece_dog_bark_01");
	soundscripts\_audio_dynamic_ambi::damb_start_preset_at_point("mhunt_safehouse_ac_liq_drops",(23585,69398,-567),"amb_greece_ac_liq_drops_01");
	soundscripts\_audio_dynamic_ambi::damb_start_preset_at_point("mhunt_safehouse_ac_liq_drops",(24039,69305,-504),"amb_greece_ac_liq_drops_02");
	soundscripts\_audio_dynamic_ambi::damb_start_preset_at_point("mhunt_safehouse_ac_liq_drops",(23814,68960,-356),"amb_greece_ac_liq_drops_03");
}

//Function Number: 57
start_kva_follow_music()
{
	soundscripts\_snd::snd_music_message("start_kva_shadow");
}

//Function Number: 58
start_kva_assault_music()
{
	wait(3);
	soundscripts\_snd::snd_music_message("start_kva_ambush");
}

//Function Number: 59
start_safehouse_stealth_music()
{
	wait(6);
	soundscripts\_snd::snd_music_message("start_kva_ambush_over");
}

//Function Number: 60
start_safehouse_stairs_music()
{
	soundscripts\_snd::snd_music_message("start_safehouse_hades_call_kill");
}

//Function Number: 61
start_safehouse_guard_03_music()
{
	soundscripts\_snd::snd_music_message("start_kva_takedown_03_music");
}

//Function Number: 62
start_safehouse_exo_trans_music()
{
	soundscripts\_snd::snd_music_message("start_exo_trans_music");
}

//Function Number: 63
safehouse_int_trigger_think()
{
	for(;;)
	{
		if(!isdefined(level.aud.ac_duct_01))
		{
			level.aud.ac_duct_01 = aud_create_entity((23902,69585,-362));
			level.aud.ac_duct_01 aud_fade_in("amb_greece_ac_duct_ext_lp",0.5,1);
		}

		if(!isdefined(level.aud.ac_duct_02))
		{
			level.aud.ac_duct_02 = aud_create_entity((24330,69153,-362));
			level.aud.ac_duct_02 aud_fade_in("amb_greece_ac_duct_ext_lp",0.5,1);
		}

		self waittill("trigger",var_00);
		if(isdefined(level.aud.ac_duct_01))
		{
			level.aud.ac_duct_01 aud_fade_out(0.5);
			level.aud.ac_duct_01 = undefined;
		}

		if(isdefined(level.aud.ac_duct_02))
		{
			level.aud.ac_duct_02 aud_fade_out(0.5);
			level.aud.ac_duct_02 = undefined;
		}

		while(self istouching(var_00))
		{
			wait(0.05);
		}
	}
}

//Function Number: 64
mhunt_melee_keycard_tkdwn()
{
	soundscripts\_snd_playsound::snd_play_2d("mhunt_melee_keycard_tkdwn");
}

//Function Number: 65
start_threat_grenade_mixer()
{
	level.player waittill("threat_grenade_marking_started");
	wait(1.25);
	soundscripts\_audio_mix_manager::mm_add_submix("mhunt_ilana_threat_grenade");
	soundscripts\_snd_playsound::snd_play_at("wpn_paint_grenade_exp",(23790,68703,-394));
	wait(2);
	soundscripts\_audio_mix_manager::mm_clear_submix("mhunt_ilana_threat_grenade");
}

//Function Number: 66
mhunt_tv_broadcast()
{
	if(!isdefined(level.aud.tv_broadcast_lp))
	{
		level.aud.tv_broadcast_lp = soundscripts\_snd_playsound::snd_play_loop_at("mhunt_tv_broadcast_lp",(23692,69307,-314),"stop_mhunt_broadcast",3,0.1);
		level.aud.tv_broadcast_lp scalevolume(0,3);
	}
}

//Function Number: 67
mhunt_tv_dest_expl()
{
	level notify("stop_mhunt_broadcast");
	var_00 = aud_create_linked_entity(self);
	var_00 aud_play("mhunt_tv_dest_expl");
	level.aud.tv_destroyed = 1;
	wait(0.5);
	level.aud.tv_dest_lp = aud_create_linked_entity(self);
	level.aud.tv_dest_lp aud_play("mhunt_tv_dest_lp",1);
}

//Function Number: 68
start_videochat_screen_turn_on()
{
	soundscripts\_snd_playsound::snd_play_at("mhunt_videochat_screen_on",(23654,68702,-181));
}

//Function Number: 69
start_videochat_screen_turn_off()
{
	wait(0.75);
	soundscripts\_snd_playsound::snd_play_at("mhunt_videochat_screen_off",(23654,68702,-181));
}

//Function Number: 70
safehouse_exo_trans_fade_out()
{
	soundscripts\_audio_mix_manager::mm_add_submix("mhunt_bag_drop",5.5);
}

//Function Number: 71
safehouse_exo_trans_fade_in()
{
	soundscripts\_audio_mix_manager::mm_clear_submix("mhunt_bag_drop",1);
}

//Function Number: 72
first_floor_trigger_think()
{
	for(;;)
	{
		self waittill("trigger",var_00);
		if(!isdefined(level.aud.ac_duct))
		{
			level.aud.ac_duct = aud_create_entity((23600,68534,-337));
			level.aud.ac_duct aud_fade_in("amb_greece_ac_duct_int_lp",0.5,1);
		}

		if(!isdefined(level.aud.generator))
		{
			level.aud.generator = aud_create_entity((23550,68618,-389));
			level.aud.generator aud_fade_in("amb_greece_generator_sm_lp",2,1);
		}

		if(isdefined(level.aud.tv_broadcast_lp))
		{
			level.aud.tv_broadcast_lp scalevolume(1,3);
		}

		if(isdefined(level.aud.tv_dest_lp))
		{
			level.aud.tv_dest_lp scalevolume(0,1);
		}

		while(self istouching(var_00))
		{
			wait(0.05);
		}

		if(isdefined(level.aud.ac_duct))
		{
			level.aud.ac_duct aud_fade_out(0.5);
			level.aud.ac_duct = undefined;
		}

		if(isdefined(level.aud.generator))
		{
			level.aud.generator aud_fade_out(2);
			level.aud.generator = undefined;
		}

		if(isdefined(level.aud.tv_broadcast_lp))
		{
			level.aud.tv_broadcast_lp scalevolume(0,3);
		}

		if(isdefined(level.aud.tv_dest_lp))
		{
			level.aud.tv_dest_lp scalevolume(0,1);
		}

		wait(0.05);
	}
}

//Function Number: 73
second_floor_trigger_think()
{
	for(;;)
	{
		self waittill("trigger",var_00);
		if(!isdefined(level.aud.cpu_transmission))
		{
			level.aud.cpu_transmission = aud_create_entity((23373,68627,-140));
			level.aud.cpu_transmission aud_fade_in("amb_mech_computer_transmission_lp",0.5,1);
		}

		if(!isdefined(level.aud.elec_hub_01))
		{
			level.aud.elec_hub_01 = aud_create_entity((23523,68977,-157));
			level.aud.elec_hub_01 aud_fade_in("amb_mach_elec_hub_lp",0.5,1);
		}

		if(!isdefined(level.aud.server_unit_01))
		{
			level.aud.server_unit_01 = aud_create_entity((23202,68726,-202));
			level.aud.server_unit_01 aud_fade_in("amb_mach_server_unit_lp",0.5,1);
		}

		if(!isdefined(level.aud.server_unit_02))
		{
			level.aud.server_unit_02 = aud_create_entity((23468,68663,-169));
			level.aud.server_unit_02 aud_fade_in("amb_mach_server_unit_lp",0.5,1);
		}

		if(!isdefined(level.aud.terminal_hum_01))
		{
			level.aud.terminal_hum_01 = aud_create_entity((23277,68656,-179));
			level.aud.terminal_hum_01 aud_fade_in("amb_mach_terminal_hum_lp",0.5,1);
		}

		if(!isdefined(level.aud.terminal_hum_02))
		{
			level.aud.terminal_hum_02 = aud_create_entity((23228,68897,-179));
			level.aud.terminal_hum_02 aud_fade_in("amb_mach_terminal_hum_lp",0.5,1);
		}

		while(self istouching(var_00))
		{
			wait(0.05);
		}

		if(isdefined(level.aud.circuit_breaker))
		{
			level.aud.cpu_transmission aud_fade_out(1);
			level.aud.cpu_transmission = undefined;
		}

		if(isdefined(level.aud.elec_hub_01))
		{
			level.aud.elec_hub_01 aud_fade_out(1);
			level.aud.elec_hub_01 = undefined;
		}

		if(isdefined(level.aud.server_unit_01))
		{
			level.aud.server_unit_01 aud_fade_out(1);
			level.aud.server_unit_01 = undefined;
		}

		if(isdefined(level.aud.server_unit_02))
		{
			level.aud.server_unit_02 aud_fade_out(1);
			level.aud.server_unit_02 = undefined;
		}

		if(isdefined(level.aud.terminal_hum_01))
		{
			level.aud.terminal_hum_01 aud_fade_out(0.5);
			level.aud.terminal_hum_01 = undefined;
		}

		if(isdefined(level.aud.terminal_hum_02))
		{
			level.aud.terminal_hum_02 aud_fade_out(0.5);
			level.aud.terminal_hum_02 = undefined;
		}

		wait(0.05);
	}
}

//Function Number: 74
start_sniper_drone_deploy()
{
	maps\_anim::addnotetrack_customfunction("sniper_drone","aud_start_drone_deploy",::start_drone_deploy_anim,"drone_launch");
}

//Function Number: 75
balcony_sniper_drone_idle(param_00)
{
	param_00 soundscripts\_snd_playsound::snd_play_loop_linked("balcony_wasp_idle_lp","stop_balcony_idle_loop",1,2.3);
}

//Function Number: 76
start_drone_deploy_anim(param_00)
{
	thread balcony_sniper_drone_idle_cleanup();
	wait(1.8);
	param_00 soundscripts\_snd_playsound::snd_play_linked("balcony_wasp_deploy");
	wait(3.2);
	thread balcony_drone_foliage();
	wait(1.8);
	param_00 soundscripts\_snd_playsound::snd_play_linked("balcony_wasp_away");
	thread stop_cafe_market_damb();
}

//Function Number: 77
wasp_cloak_on()
{
	soundscripts\_snd_playsound::snd_play_delayed_linked("balcony_wasp_cloak_on",0.25);
}

//Function Number: 78
balcony_sniper_drone_idle_cleanup()
{
	wait(2.3);
	level notify("stop_balcony_idle_loop");
}

//Function Number: 79
balcony_drone_foliage()
{
	wait(0.8);
	soundscripts\_snd_playsound::snd_play_at("balcony_drone_foliage",(23594,69364,-197));
}

//Function Number: 80
drone_control_pad_end()
{
	soundscripts\_snd::snd_music_message("safehouse_fade_out");
	soundscripts\_snd_playsound::snd_play_2d("wasp_intro_transition");
	soundscripts\_audio_mix_manager::mm_add_submix("mhunt_cc_transition");
	wait(0.5);
	soundscripts\_audio_mix_manager::mm_clear_submix("mhunt_cc_transition");
	wait(2);
	soundscripts\_audio_mix_manager::mm_add_submix("mhunt_wasp_mute_oneshots");
}

//Function Number: 81
start_sniper_drone()
{
	soundscripts\_audio_zone_manager::azm_start_zone("mhunt_ext_drone_conf_center");
	soundscripts\_audio_mix_manager::mm_add_submix("mhunt_sniper_drone_control");
	soundscripts\_audio_mix_manager::mm_add_submix("mhunt_sniper_drone_zoom_out");
	level notify("stop_sniper_drone_npc");
	thread start_sniper_drone_loops();
}

//Function Number: 82
start_sniper_drone_loops()
{
	var_00 = gettime() - 1;
	var_01 = level.player.sniperdronelink.origin;
	var_02 = "hover";
	var_03 = 0;
	var_04 = 0;
	var_05 = 0;
	var_06 = 0;
	if(!isdefined(level.aud.hoverlp))
	{
		level.aud.hoverlp = level.player.sniperdronelink soundscripts\_snd_playsound::snd_play_loop_linked("veh_wasp_idle_lp","sniper_drone_hoverlp",0,0.1,0);
	}

	if(!isdefined(level.aud.lfelp))
	{
		level.aud.lfelp = level.player.sniperdronelink soundscripts\_snd_playsound::snd_play_loop_linked("veh_wasp_idle_lfe","sniper_drone_lfelp",0,0.1,0);
	}

	if(!isdefined(level.aud.flylp))
	{
		level.aud.flylp = level.player.sniperdronelink soundscripts\_snd_playsound::snd_play_loop_linked("veh_wasp_drive_med_lp","sniper_drone_flylp",0,0.1,0);
	}

	if(!isdefined(level.aud.looklp))
	{
		level.aud.looklp = level.player.sniperdronelink soundscripts\_snd_playsound::snd_play_loop_linked("veh_wasp_look_lp","sniper_drone_looklp",0,0.1,0);
	}

	for(;;)
	{
		waittillframeend;
		if(!isdefined(level.player.sniperdronelink))
		{
			break;
		}

		var_07 = gettime();
		var_08 = 1000 / var_07 - var_00;
		var_09 = level.player.sniperdronelink.origin - var_01;
		var_0A = length(var_09) * var_08 * 0.05681818;
		var_0B = var_0A - var_04;
		var_04 = var_04 + 0.6 * var_0B;
		var_01 = level.player.sniperdronelink.origin;
		var_00 = var_07;
		var_0C = level.player getnormalizedcameramovements();
		var_0D = max(abs(var_0C[0]),abs(var_0C[1]));
		var_05 = var_05 + 0.6 * var_0D - var_05;
		var_0E = maps\greece_code::calculateleftstickdeadzone();
		var_0F = max(abs(var_0E[0]),abs(var_0E[1]));
		var_06 = var_06 + 0.6 * var_0F - var_06;
		if(var_06 > 0.1 && var_02 == "hover" && !isdefined(level.aud.start_fly))
		{
			var_02 = "transition";
			level.aud.start_fly = level.player.sniperdronelink soundscripts\_snd_playsound::snd_play_linked("veh_wasp_drive_med_start");
		}
		else if(var_06 <= 0.2 && var_02 == "flying" && !isdefined(level.aud.stop_fly))
		{
			var_02 = "transition";
			level.aud.stop_fly = level.player.sniperdronelink soundscripts\_snd_playsound::snd_play_linked("veh_wasp_drive_med_stop");
		}
		else if(var_06 > 0.2)
		{
			var_02 = "flying";
		}
		else if(var_06 <= 0.1)
		{
			var_02 = "hover";
		}

		if(var_05 > 0.1 && var_04 <= 2 && !var_03)
		{
			var_03 = 1;
			level.aud.start_look = level.player.sniperdronelink soundscripts\_snd_playsound::snd_play_linked("veh_wasp_look_start");
		}
		else if((var_05 <= 0.1 || var_04 > 2) && var_03)
		{
			var_03 = 0;
			level.aud.stop_look = level.player.sniperdronelink soundscripts\_snd_playsound::snd_play_linked("veh_wasp_look_stop");
		}

		if(isdefined(level.aud.hoverlp))
		{
			var_10 = soundscripts\_snd::snd_map(var_04,level.aud.envs["sniper_drone_hover_spd2vol"]);
			level.aud.hoverlp scalevolume(var_10);
			var_11 = soundscripts\_snd::snd_map(var_04,level.aud.envs["sniper_drone_hover_spd2pch"]);
			level.aud.hoverlp scalepitch(var_11);
		}

		if(isdefined(level.aud.lfelp))
		{
			var_12 = soundscripts\_snd::snd_map(var_04,level.aud.envs["sniper_drone_lfe_spd2vol"]);
			level.aud.lfelp scalevolume(var_12);
			var_13 = soundscripts\_snd::snd_map(var_04,level.aud.envs["sniper_drone_lfe_spd2pch"]);
			level.aud.lfelp scalepitch(var_13);
		}

		if(isdefined(level.aud.flylp))
		{
			var_14 = soundscripts\_snd::snd_map(var_04,level.aud.envs["sniper_drone_fly_spd2vol"]);
			level.aud.flylp scalevolume(var_14);
			var_15 = soundscripts\_snd::snd_map(var_04,level.aud.envs["sniper_drone_fly_spd2pch"]);
			level.aud.flylp scalepitch(var_15);
		}

		if(isdefined(level.aud.looklp))
		{
			var_16 = soundscripts\_snd::snd_map(var_05,level.aud.envs["sniper_drone_look_spd2vol"]) * soundscripts\_snd::snd_map(var_04,level.aud.envs["sniper_drone_look_hover_spd2vol"]);
			level.aud.looklp scalevolume(var_16);
		}

		wait(0.05);
	}
}

//Function Number: 83
stop_sniper_drone()
{
	soundscripts\_audio_zone_manager::azm_start_zone("mhunt_int_safehouse_balcony");
	soundscripts\_audio_mix_manager::mm_clear_submix("mhunt_sniper_drone_control");
}

//Function Number: 84
start_sniper_drone_zoom()
{
	level.aud.zoomout = 0;
	if(isdefined(level.aud.zoomin) && level.aud.zoomin)
	{
		return;
	}

	soundscripts\_audio_mix_manager::mm_add_submix("mhunt_sniper_drone_zoom_in");
	soundscripts\_audio_mix_manager::mm_clear_submix("mhunt_sniper_drone_zoom_out");
	maps\_utility::enable_damagefeedback_snd();
	level.aud.zoomin = 1;
	level.aud.zoominsound = soundscripts\_snd_playsound::snd_play_2d("wpn_wasp_scope_zoom_in","stop_zoominsound",0,0.25);
}

//Function Number: 85
stop_sniper_drone_zoom()
{
	level.aud.zoomin = 0;
	if(isdefined(level.aud.zoomout) && level.aud.zoomout)
	{
		return;
	}

	soundscripts\_audio_mix_manager::mm_add_submix("mhunt_sniper_drone_zoom_out");
	soundscripts\_audio_mix_manager::mm_clear_submix("mhunt_sniper_drone_zoom_in");
	maps\_utility::disable_damagefeedback_snd();
	level.aud.zoomout = 1;
	soundscripts\_snd_playsound::snd_play_2d("wpn_wasp_scope_zoom_out");
	if(isdefined(level.aud.zoominsound))
	{
		level notify("stop_zoominsound");
	}
}

//Function Number: 86
unmute_wasp_oneshots()
{
	soundscripts\_audio_mix_manager::mm_clear_submix("mhunt_wasp_mute_oneshots");
}

//Function Number: 87
sniper_drone_dry_fire()
{
	if(isdefined(level.aud.dry_fire) && level.aud.dry_fire)
	{
		return;
	}

	level.aud.dry_fire = 1;
	soundscripts\_snd_playsound::snd_play_2d("wpn_wasp_dry_fire");
	wait(0.3);
	level.aud.dry_fire = 0;
}

//Function Number: 88
start_veh_moving_truck(param_00)
{
	if(isdefined(level.aud.truckaudio) && level.aud.truckaudio)
	{
		return;
	}

	if(isdefined(level.aud.support_01_checkpoint) && level.aud.support_01_checkpoint)
	{
		veh_moving_truck_support_01_chkpt(param_00);
		return;
	}

	level.aud.truckaudio = 1;
	thread duck_moving_truck_drive();
	var_01 = param_00 soundscripts\_snd_playsound::snd_play_loop_linked("moving_truck_drive","stop_moving_truck_drive",1,0.5);
	level waittill("audio_resume_moving_truck");
	wait(1.5);
	level notify("stop_moving_truck_drive");
	var_02 = param_00 soundscripts\_snd_playsound::snd_play_linked("moving_truck_approach");
	wait(5);
	var_02 = param_00 soundscripts\_snd_playsound::snd_play_linked("moving_truck_brakes");
	if(!isdefined(level.aud.movingtruckidle))
	{
		level.aud.movingtruckidle = param_00 soundscripts\_snd_playsound::snd_play_loop_linked("moving_truck_idle","stop_moving_truck_idle",0.5,0.25);
		return;
	}
}

//Function Number: 89
veh_moving_truck_support_01_chkpt(param_00)
{
	wait(0.05);
	var_01 = param_00 soundscripts\_snd_playsound::snd_play_loop_linked("moving_truck_drive","stop_moving_truck_drive",1,0.5);
	wait(3);
	level notify("stop_moving_truck_drive");
	var_02 = param_00 soundscripts\_snd_playsound::snd_play_linked("moving_truck_approach");
	wait(3.5);
	var_02 = param_00 soundscripts\_snd_playsound::snd_play_linked("moving_truck_brakes");
	if(!isdefined(level.aud.movingtruckidle))
	{
		level.aud.movingtruckidle = param_00 soundscripts\_snd_playsound::snd_play_loop_linked("moving_truck_idle","stop_moving_truck_idle",0.5,0.25);
	}
}

//Function Number: 90
veh_moving_truck_chkpt(param_00)
{
	level waittill("moving_truck_checkpoint");
	if(!isdefined(level.aud.movingtruckidle))
	{
		level.aud.movingtruckidle = param_00 soundscripts\_snd_playsound::snd_play_loop_linked("moving_truck_idle","stop_moving_truck_idle",0.25,0.25);
	}
}

//Function Number: 91
duck_moving_truck_drive()
{
	wait(6);
	soundscripts\_audio_mix_manager::mm_add_submix("mhunt_duck_moving_truck");
	level waittill("audio_resume_moving_truck");
	soundscripts\_audio_mix_manager::mm_clear_submix("mhunt_duck_moving_truck");
}

//Function Number: 92
cc_kva_alerted_walla()
{
	soundscripts\_snd_playsound::snd_play_2d("walla_kva_alerted","stop_kva_walla",0,2);
}

//Function Number: 93
start_tower_bells()
{
}

//Function Number: 94
start_gate_breach_music()
{
	soundscripts\_snd_timescale::snd_set_timescale("mhunt_balcony_takedown");
	wait(1);
	soundscripts\_snd::snd_music_message("start_conference_stealth");
}

//Function Number: 95
start_burke_ambush_slomo()
{
	level.player enablecustomweaponcontext();
	soundscripts\_snd_common::snd_enable_soundcontextoverride("slomo");
	soundscripts\_snd::snd_music_message("start_burke_ambush_slomo");
	soundscripts\_audio_mix_manager::mm_add_submix("mhunt_burke_ambush");
	soundscripts\_snd_playsound::snd_play_2d("burke_ambush_door_start");
}

//Function Number: 96
stop_burke_ambush_slomo()
{
	soundscripts\_snd::snd_music_message("stop_burke_ambush_slomo");
	soundscripts\_snd_playsound::snd_play_2d("burke_ambush_door_stop");
	wait(0.25);
	soundscripts\_audio_mix_manager::mm_clear_submix("mhunt_burke_ambush");
	soundscripts\_snd_common::snd_disable_soundcontextoverride("slomo");
	level.player disablecustomweaponcontext();
}

//Function Number: 97
npc_shoots_pool_enemy()
{
	soundscripts\_snd_playsound::snd_play_linked("pool_npc_shoot");
}

//Function Number: 98
atrium_breach_signal_start()
{
	if(isdefined(level.aud.breach_signal) && level.aud.breach_signal)
	{
		return;
	}

	level.aud.breach_signal = 1;
	soundscripts\_snd_playsound::snd_play_2d("mute_breach_signal");
}

//Function Number: 99
start_atrium_breach_music()
{
	soundscripts\_snd::snd_music_message("start_atrium_fight_music");
}

//Function Number: 100
start_atrium_fight()
{
	soundscripts\_audio_mix_manager::mm_add_submix("mhunt_mute_fight");
	soundscripts\_snd_playsound::snd_play_2d("mute_breach_activate");
	wait(0.7);
	soundscripts\_snd_playsound::snd_play_2d("mute_breach_explo");
}

//Function Number: 101
stop_atrium_fight()
{
	soundscripts\_snd::snd_music_message("stop_atrium_fight");
	soundscripts\_audio_mix_manager::mm_clear_submix("mhunt_mute_fight");
}

//Function Number: 102
atrium_timer_expire()
{
	soundscripts\_audio_mix_manager::mm_clear_submix("mhunt_mute_fight");
}

//Function Number: 103
parking_lot_runners()
{
}

//Function Number: 104
parking_lot_clear()
{
	soundscripts\_snd::snd_music_message("parking_lot_clear");
}

//Function Number: 105
start_car_alarm(param_00)
{
	level endon("stop_car_alarm");
	if(isdefined(level.aud.car_alarm_horn_01) && level.aud.car_alarm_horn_01)
	{
		return;
	}

	level.aud.car_alarm_horn_01 = 1;
	for(;;)
	{
		param_00 thread soundscripts\_snd_playsound::snd_play_linked("car_alarm_horn_01");
		wait(1.08);
	}
}

//Function Number: 106
stop_car_alarm()
{
	wait(3);
	level notify("stop_car_alarm");
	wait(0.5);
	soundscripts\_snd_playsound::snd_play_linked("car_alarm_horn_chirp");
}

//Function Number: 107
start_hades_transition()
{
	wait(1);
	soundscripts\_snd::snd_music_message("start_hades_sequence");
}

//Function Number: 108
begin_kill_hades_sequence()
{
	maps\_anim::addnotetrack_customfunction("infiltratorburke","audio_building_explo",::conference_center_explo,"cc_breach");
	maps\_anim::addnotetrack_customfunction("infiltrator1","audio_hades_breach_sequence",::start_hades_breach_npc,"cc_breach");
}

//Function Number: 109
start_hades_double_stinger()
{
	wait(1.3);
	soundscripts\_snd::snd_music_message("start_hades_double_stinger");
}

//Function Number: 110
hades_is_dead()
{
	level.confhades soundscripts\_snd_playsound::snd_play_linked("hades_death_glass_squib");
	soundscripts\_snd::snd_music_message("start_hades_breach");
	soundscripts\_snd_playsound::snd_play_delayed_2d("walla_hades_death",0.3);
	wait(0.7);
	soundscripts\_snd_playsound::snd_play_2d("hades_death_bodyfall");
}

//Function Number: 111
start_hades_breach()
{
	common_scripts\utility::flag_set("aud_hades_door_breach");
}

//Function Number: 112
start_hades_breach_door(param_00)
{
	common_scripts\utility::flag_wait("aud_hades_door_breach");
	wait(0.98);
	param_00 soundscripts\_snd_playsound::snd_play_linked("hades_breach_door");
}

//Function Number: 113
start_hades_flashbang(param_00)
{
	param_00 soundscripts\_snd_playsound::snd_play_linked("hades_breach_flashbang");
	soundscripts\_snd_timescale::snd_set_timescale("mhunt_hades_explosion");
}

//Function Number: 114
start_hades_breach_npc(param_00)
{
	thread start_hades_breach_npc1();
	thread start_hades_breach_npc2();
	thread start_hades_breach_guard();
	soundscripts\_snd_playsound::snd_play_delayed_2d("hades_npc_grenade",0.8);
	soundscripts\_snd_playsound::snd_play_delayed_2d("hades_npc_fire",3.2);
	soundscripts\_snd_playsound::snd_play_delayed_2d("hades_npc_walk_01",3.3);
	soundscripts\_snd_playsound::snd_play_delayed_2d("hades_npc_walk_02",13.18);
	soundscripts\_snd_playsound::snd_play_delayed_2d("hades_npc_dive",15.05);
}

//Function Number: 115
start_hades_breach_npc1()
{
	soundscripts\_snd_playsound::snd_play_delayed_2d("hades_npc1_walk",3.62);
	soundscripts\_snd_playsound::snd_play_delayed_2d("hades_npc1_jump",15.62);
}

//Function Number: 116
start_hades_breach_npc2()
{
	soundscripts\_snd_playsound::snd_play_delayed_2d("hades_npc2_walk_01",3.77);
	soundscripts\_snd_playsound::snd_play_delayed_2d("hades_npc2_kick",7.22);
	soundscripts\_snd_playsound::snd_play_delayed_2d("hades_npc2_up",14.36);
	soundscripts\_snd_playsound::snd_play_delayed_2d("hades_npc2_walk_02",15.75);
	soundscripts\_snd_playsound::snd_play_delayed_2d("hades_npc2_gun_drop",16.45);
}

//Function Number: 117
start_hades_breach_guard()
{
	soundscripts\_snd_playsound::snd_play_delayed_2d("guard_death_gun_drop",3.5);
	soundscripts\_snd_playsound::snd_play_delayed_2d("guard_death_bodyfall",3.75);
}

//Function Number: 118
hades_rigged_walla()
{
	soundscripts\_snd_playsound::snd_play_delayed_2d("walla_hades_bomb",5.8,0,"stop_bomb_walla",0,0.25);
}

//Function Number: 119
conference_center_explo(param_00)
{
	wait(1.5);
	soundscripts\_snd_playsound::snd_play_2d("conference_center_explode");
	level notify("stop_bomb_walla");
	soundscripts\_audio_mix_manager::mm_add_submix("mhunt_conf_center_explo");
	soundscripts\_audio_zone_manager::azm_start_zone("mhunt_ext_drone_conf_center_explo");
}

//Function Number: 120
conference_center_explo_zone()
{
	wait(0.25);
	soundscripts\_audio_zone_manager::azm_start_zone("mhunt_ext_drone_conf_center_explo");
}

//Function Number: 121
hades_explosion_slowmo_start()
{
}

//Function Number: 122
start_wasp_flicker()
{
	soundscripts\_snd_playsound::snd_play_2d("wasp_static_flicker");
}

//Function Number: 123
hades_explosion_slowmo_end()
{
	soundscripts\_audio_mix_manager::mm_clear_submix("mhunt_conf_center_explo");
	thread conference_center_fire();
	thread post_explosion_alarms();
	wait(1);
	soundscripts\_snd::snd_music_message("start_hades_post_explosion");
}

//Function Number: 124
conference_center_fire()
{
	if(isdefined(level.aud.ccfire) && level.aud.ccfire)
	{
		return;
	}

	level.aud.ccfire = soundscripts\_snd_playsound::snd_play_loop_at("conference_center_fire",(-20472,-46629,200),"stop_conference_center_fire",0.5,0.25);
}

//Function Number: 125
post_explosion_alarms()
{
	soundscripts\_snd_playsound::snd_play_loop_at("post_explo_car_alarm_01",(-18620,-43837,253),"stop_post_explo_car_alarm_01",0,3);
	soundscripts\_snd_playsound::snd_play_loop_at("post_explo_car_alarm_02",(-15682,-46731,589),"stop_post_explo_car_alarm_02",0,3);
	wait(20);
	level notify("stop_post_explo_car_alarm_01");
	level.aud.siren_distant = soundscripts\_snd_playsound::snd_play_loop_at("post_explo_siren",(-15685,-46735,589),"stop_post_explo_siren",20,1);
	wait(15);
	level notify("stop_post_explo_car_alarm_02");
}

//Function Number: 126
wasp_cloak_off()
{
	if(isdefined(level.aud.drone_cloak_off) && level.aud.drone_cloak_off)
	{
		return;
	}

	level.aud.drone_cloak_off = 1;
	soundscripts\_snd_playsound::snd_play_2d("wasp_cloak_off");
}

//Function Number: 127
start_cc_open_combat()
{
	wait(0.75);
	soundscripts\_snd::snd_music_message("start_conference_battle");
}

//Function Number: 128
mhunt_cc_assault_veh_01_approach()
{
	var_00 = aud_create_linked_entity(self);
	var_00 aud_play("mhunt_cc_assault_veh_01_approach");
}

//Function Number: 129
cc_technical_turret_fire(param_00)
{
	level endon("start_wasp_death_spin");
	for(;;)
	{
		param_00 waittill("turret_fire");
		param_00 soundscripts\_snd_playsound::snd_play("truck_turret_fire");
	}
}

//Function Number: 130
mhunt_cc_parked_car_expl()
{
	soundscripts\_audio_mix_manager::mm_add_submix("mhunt_parked_car_explo");
	var_00 = aud_create_linked_entity(self);
	var_00 aud_play("mhunt_cc_parked_car_expl");
	wait(1.5);
	soundscripts\_audio_mix_manager::mm_clear_submix("mhunt_parked_car_explo");
}

//Function Number: 131
mhunt_cc_assault_veh_02_approach()
{
	var_00 = aud_create_linked_entity(self);
	var_00 aud_play("mhunt_cc_assault_veh_02_approach");
}

//Function Number: 132
mhunt_cc_assault_veh_03_approach()
{
	wait(2.8);
	var_00 = aud_create_linked_entity(self);
	var_00 aud_play("mhunt_cc_assault_veh_03_approach");
}

//Function Number: 133
mhunt_cc_hades_veh_escape()
{
	var_00 = aud_create_linked_entity(self);
	var_00 aud_play("mhunt_cc_hades_veh_escape");
}

//Function Number: 134
start_kdrone_launch(param_00)
{
	param_00 soundscripts\_snd_playsound::snd_play_linked("kdrone_launch");
}

//Function Number: 135
start_kdrone_loop(param_00)
{
	param_00 soundscripts\_snd_playsound::snd_play_loop_linked("veh_kdrone_fly_armed_lp");
}

//Function Number: 136
start_wasp_missile_warning()
{
	soundscripts\_snd_playsound::snd_play_loop_at("wasp_death_warning_beep",(0,0,0),"stop_wasp_death_warning_beep");
}

//Function Number: 137
stop_wasp_missile_warning()
{
	level notify("stop_wasp_death_warning_beep");
}

//Function Number: 138
kamikaze_drone_explo(param_00)
{
	soundscripts\_snd_playsound::snd_play_at("kdrone_explo_death",param_00.origin);
}

//Function Number: 139
start_sniper_drone_death()
{
	if(isdefined(level.aud.drone_explo) && level.aud.drone_explo)
	{
		return;
	}

	level.aud.drone_explo = 1;
	soundscripts\_snd::snd_music_message("start_sniper_drone_death");
	soundscripts\_audio_mix_manager::mm_add_submix("mhunt_sniper_drone_death_spin");
	soundscripts\_snd_playsound::snd_play_2d("wasp_death_spin");
	level notify("start_wasp_death_spin");
	soundscripts\_snd_common::snd_enable_soundcontextoverride("mhunt_safehouse_exit");
	if(isdefined(level.aud.siren_distant))
	{
		level notify("stop_post_explo_siren");
	}
}

//Function Number: 140
start_wasp_death_explo()
{
	soundscripts\_snd_playsound::snd_play_2d("wasp_death_glass_explo");
}

//Function Number: 141
sniper_drone_dmg_fire()
{
	if(isdefined(level.aud.damaged_fire) && level.aud.damaged_fire)
	{
		return;
	}

	level.aud.damaged_fire = 1;
	soundscripts\_snd_playsound::snd_play_2d("wpn_wasp_shot_dmg");
	wait(0.5);
	level.aud.damaged_fire = 0;
}

//Function Number: 142
start_drone_death_static()
{
	soundscripts\_audio_mix_manager::mm_add_submix("mhunt_sniper_drone_death");
	soundscripts\_snd_playsound::snd_play_loop_at("wasp_death_static",(0,0,0),"stop_wasp_death_static");
	level notify("stop_moving_truck_idle");
	level notify("stop_conference_center_fire");
	thread safehouse_balcony_siren();
	maps\_utility::enable_damagefeedback_snd();
	wait(5);
	soundscripts\_audio_mix_manager::mm_clear_submix("mhunt_sniper_drone_death_spin");
	soundscripts\_audio_mix_manager::mm_clear_submix("mhunt_sniper_drone_death");
}

//Function Number: 143
stop_drone_death_static()
{
	level notify("stop_wasp_death_static");
}

//Function Number: 144
safehouse_balcony_siren()
{
	if(isdefined(level.aud.balcony_siren) && level.aud.balcony_siren)
	{
		return;
	}

	level.aud.balcony_siren = 1;
	soundscripts\_snd_playsound::snd_play_loop_at("balcony_dist_siren",(23742,70235,12),"stop_balcony_siren",0.25,8);
	soundscripts\_snd_playsound::snd_play_loop_at("mhunt_alley_civ_screams_dist_lp",(22691,70289,-180),"stop_civ_screams_dist",3,3);
}

//Function Number: 145
mhunt_safehouse_cc_expl_distant()
{
	soundscripts\_snd_playsound::snd_play_at("mhunt_safehouse_cc_expl_distant",(23539,69457,-180));
}

//Function Number: 146
safehouse_escape_music()
{
	soundscripts\_snd::snd_music_message("start_safehouse_escape");
}

//Function Number: 147
safehouse_sonic_destruct()
{
	if(isdefined(level.aud.sonic_destruct) && level.aud.sonic_destruct)
	{
		return;
	}

	level.aud.sonic_destruct = 1;
	soundscripts\_snd_playsound::snd_play_delayed_at("sonic_destruction",(23706,69119,-355),0.25);
}

//Function Number: 148
tunnel_runner_walla()
{
	soundscripts\_snd_playsound::snd_play_delayed_at("walla_gate_runner",(24036,70193,-612),0.35);
	soundscripts\_snd_playsound::snd_play_loop_at("walla_trans_alleys_screaming",(25678,70882,-788),"stop_trans_to_alleys_panic",1,24);
	soundscripts\_snd_playsound::snd_play_delayed_at("walla_alley_way",(25225,70171,-676),9);
}

//Function Number: 149
start_trans_to_alleys_panic()
{
	thread alleys_distant_standard_siren_loop();
	thread alleys_distant_emergency_siren_blasts();
}

//Function Number: 150
walla_bridge_runners()
{
	soundscripts\_snd_playsound::snd_play_delayed_at("walla_upper_walkway",(24582,70099,-505),1.25);
}

//Function Number: 151
stop_trans_to_alleys_panic()
{
	level notify("stop_trans_to_alleys_panic");
}

//Function Number: 152
smoking_civ_panic(param_00)
{
	param_00 endon("death");
	if(isdefined(level.aud.smoking_civ) && level.aud.smoking_civ)
	{
		return;
	}

	for(;;)
	{
		level.aud.smoking_civ = 1;
		soundscripts\_snd_playsound::snd_play_at("grk_cm1_cower",param_00.origin);
		wait(3.5);
	}
}

//Function Number: 153
civ_panic_door_run_in(param_00)
{
	param_00 thread civilian_panic_distance_check("grk_cm2_breathe","",250,300);
}

//Function Number: 154
trans_civ_01_flee_kva(param_00)
{
	param_00 thread civilian_panic_distance_check("grk_cm3_scream","",50,100);
}

//Function Number: 155
trans_civ_03_flee_kva(param_00)
{
	param_00 thread civilian_panic_distance_check("grk_cm3_surprise","",600,700);
}

//Function Number: 156
start_alleys_combat_music()
{
	soundscripts\_snd::snd_music_message("start_alleys_combat");
	thread alleys_distant_euro_siren_loop();
}

//Function Number: 157
trans_alleys_end_alley_trigger()
{
	self waittill("trigger",var_00);
	thread trans_alleys_scripted_female_scream();
	thread trans_alleys_end_scripted_enemy_gunshots();
}

//Function Number: 158
trans_alleys_scripted_female_scream()
{
	if(isdefined(level.aud.trans_alleys_female_scream) && level.aud.trans_alleys_female_scream)
	{
		return;
	}

	level.aud.trans_alleys_female_scream = 1;
	wait(randomfloatrange(2,3));
	soundscripts\_snd_playsound::snd_play_at("walla_corner_screams",(25516,70811,-840));
}

//Function Number: 159
trans_alleys_end_scripted_enemy_gunshots()
{
	if(isdefined(level.aud.trans_alleys_corner_shot) && level.aud.trans_alleys_corner_shot)
	{
		return;
	}
	else
	{
		level.aud.trans_alleys_corner_shot = 1;
		for(var_00 = 0;var_00 < 6;var_00 = var_00 + 1)
		{
			soundscripts\_snd_playsound::snd_play_at("wpn_sn6_npc",(25426,70805,-838));
			wait(0.1);
		}
	}

	wait(0.5);
	while(var_00 < 13)
	{
		soundscripts\_snd_playsound::snd_play_at("wpn_sn6_npc",(25426,70805,-838));
		wait(0.1);
		var_00 = var_00 + 1;
	}
}

//Function Number: 160
trans_alleys_end_corner_trigger()
{
	self waittill("trigger",var_00);
	thread start_alleys_music();
	soundscripts\_snd::snd_message("stop_trans_to_alleys_panic");
}

//Function Number: 161
start_sonic_attack_mix()
{
	soundscripts\_snd_filters::snd_fade_in_filter("mhunt_alleys_sonic_attack",0.25);
	wait(1.5);
	soundscripts\_snd_filters::snd_fade_out_filter(3);
}

//Function Number: 162
start_alleys_music()
{
	if(isdefined(level.aud.trans_alleys_corner) && level.aud.trans_alleys_corner)
	{
		return;
	}

	level.aud.trans_alleys_corner = 1;
	wait(1);
	soundscripts\_snd::snd_music_message("start_back_alley_music_mid");
}

//Function Number: 163
alleys_distant_euro_siren_loop()
{
	level endon("stop_alley_emergency_responders");
	if(isdefined(level.aud.euro_siren_setup) && level.aud.euro_siren_setup)
	{
		return;
	}

	level.aud.euro_siren_setup = 1;
	for(;;)
	{
		level.aud.euro_siren_01 = soundscripts\_snd_playsound::snd_play_loop_at("euro_siren_lp_01",(25389,72394,-133),"stop_euro_siren_lp_01",30,20);
		wait(30);
		wait(randomfloatrange(8,15));
		level notify("stop_euro_siren_lp_01");
		wait(30);
		wait(randomfloatrange(10,15));
	}
}

//Function Number: 164
alleys_distant_standard_siren_loop()
{
	level endon("stop_alley_emergency_responders");
	if(isdefined(level.aud.standard_siren_setup) && level.aud.standard_siren_setup)
	{
		return;
	}

	level.aud.standard_siren_setup = 1;
	level.aud.standard_siren_01 = soundscripts\_snd_playsound::snd_play_loop_at("standard_siren_lp_01",(0,0,0),"stop_standard_siren_lp_01",1,45);
	wait(60);
	level notify("stop_standard_siren_lp_01");
	wait(45);
	for(;;)
	{
		level.aud.standard_siren_01 = soundscripts\_snd_playsound::snd_play_loop_at("standard_siren_lp_01",(0,0,0),"stop_standard_siren_lp_01",30,45);
		wait(30);
		wait(randomfloatrange(45,90));
		level notify("stop_standard_siren_lp_01");
		wait(45);
		wait(randomfloatrange(10,15));
	}
}

//Function Number: 165
alleys_distant_emergency_siren_blasts()
{
	level endon("stop_alley_emergency_responders");
	if(isdefined(level.aud.emergency_siren_blasts) && level.aud.emergency_siren_blasts)
	{
		return;
	}

	level.aud.emergency_siren_blasts = 1;
	soundscripts\_audio_dynamic_ambi::damb_start_preset_at_point("mhunt_alleys_emergency_siren_blasts",(25998,70590,397),"siren_blasts_dist_01");
	soundscripts\_audio_dynamic_ambi::damb_start_preset_at_point("mhunt_alleys_emergency_horn_dist",(24336,71635,16),"horn_blasts_dist_01");
}

//Function Number: 166
alleys_rpg_fight_music()
{
	if(isdefined(level.aud.alleys_rpg_music) && level.aud.alleys_rpg_music)
	{
		return;
	}

	level.aud.alleys_rpg_music = 1;
	wait(0.5);
	soundscripts\_snd::snd_music_message("start_back_alley_music_hi");
	level notify("stop_balcony_siren");
}

//Function Number: 167
alleys_rpg_music_backup_trigger()
{
	self waittill("trigger",var_00);
	if(isdefined(level.aud.alleys_rpg_music) && level.aud.alleys_rpg_music)
	{
		return;
	}

	level.aud.alleys_rpg_music = 1;
	soundscripts\_snd::snd_music_message("start_back_alley_music_hi");
}

//Function Number: 168
stop_alleys_emergency_audio()
{
	level notify("stop_alley_emergency_responders");
	level notify("stop_balcony_siren");
	level notify("stop_civ_screams_dist");
	soundscripts\_audio_dynamic_ambi::damb_stop_preset_at_point("mhunt_alleys_emergency_siren_blasts","siren_blasts_dist_01",1);
	soundscripts\_audio_dynamic_ambi::damb_stop_preset_at_point("mhunt_alleys_emergency_horn_dist","horn_blasts_dist_01",1);
	if(isdefined(level.aud.standard_siren_01))
	{
		level notify("stop_standard_siren_lp_01");
	}

	if(isdefined(level.aud.euro_siren_01))
	{
		level notify("stop_euro_siren_lp_01");
	}

	wait(15);
}

//Function Number: 169
alleys_music_end()
{
	soundscripts\_snd::snd_music_message("stop_alleys_combat");
}

//Function Number: 170
alley_ending_point_trigger()
{
	self waittill("trigger",var_00);
	if(isdefined(level.aud.alleys_end_music) && level.aud.alleys_end_music)
	{
		return;
	}

	level.aud.alleys_end_music = 1;
}

//Function Number: 171
sniper_interior_trigger_think(param_00)
{
	if(!isdefined(param_00))
	{
		return;
	}

	for(;;)
	{
		level.aud.playerinside = 0;
		foreach(var_02 in param_00)
		{
			if(level.player istouching(var_02))
			{
				level.aud.playerinside = 1;
				break;
			}
		}

		wait(0.2);
	}
}

//Function Number: 172
windmill_sniper_shot(param_00)
{
	soundscripts\_snd::snd_message("windmill_sniper_shot_whizby",level.sniperpos.origin,param_00);
	if(isdefined(level.aud.snipershot))
	{
		level notify("stop_snipershot");
	}

	var_01 = distance(level.player.origin,level.sniperpos.origin);
	if(var_01 < 4500)
	{
		if(level.aud.playerinside)
		{
			var_02 = "mhunt_snpr_near_int_front_01";
		}
		else
		{
			var_02 = "mhunt_snpr_near_ext_front_01";
		}
	}
	else if(level.aud.playerinside)
	{
		wait(0.19);
		var_02 = "mhunt_snpr_far_int_front_01";
	}
	else
	{
		wait(0.19);
		var_02 = "mhunt_snpr_far_ext_front_01";
	}

	level.aud.snipershot = soundscripts\_snd_playsound::snd_play_at(var_02,(20250,81380,-712),"stop_snipershot",0,1);
	level notify("shot_fired_civ_reaction");
}

//Function Number: 173
windmill_sniper_shot_multi(param_00)
{
	soundscripts\_snd::snd_message("windmill_sniper_shot_whizby",level.sniperpos.origin,param_00);
	if(isdefined(level.aud.snipershot_multi))
	{
		level notify("stop_snipershot_multi");
	}

	var_01 = distance(level.player.origin,level.sniperpos.origin);
	if(var_01 < 4500)
	{
		if(level.aud.playerinside)
		{
			var_02 = "mhunt_snpr_near_int_front_01";
		}
		else
		{
			var_02 = "mhunt_snpr_near_ext_front_01";
		}
	}
	else if(level.aud.playerinside)
	{
		wait(0.19);
		var_02 = "mhunt_snpr_far_int_front_01";
	}
	else
	{
		wait(0.19);
		var_02 = "mhunt_snpr_far_ext_front_01";
	}

	level.aud.snipershot_multi = soundscripts\_snd_playsound::snd_play_at(var_02,(20250,81380,-712),"stop_snipershot_multi",0,1);
	level notify("shot_fired_civ_reaction");
}

//Function Number: 174
mhunt_snpr_blood_impact_splat()
{
	var_00 = aud_create_linked_entity(self);
	var_00 aud_play("sniper_npc_flesh_squib");
}

//Function Number: 175
windmill_sniper_shot_whizby(param_00,param_01)
{
	var_02 = param_00;
	var_03 = param_01;
	thread aud_windmill_sniper_whizby(var_02,var_03);
}

//Function Number: 176
aud_windmill_sniper_whizby(param_00,param_01)
{
	var_02 = soundscripts\_snd_playsound::snd_play_at("mhunt_snpr_bullet_whizby",param_00);
	var_02 moveto(param_01,0.1);
}

//Function Number: 177
scramble_amb_siren_loop()
{
	level endon("stop_scramble_emergency_responders");
	if(isdefined(level.aud.scramble_siren_setup) && level.aud.scramble_siren_setup)
	{
		return;
	}

	level.aud.scramble_siren_setup = 1;
	level.aud.scramble_siren_01 = soundscripts\_snd_playsound::snd_play_loop_at("scramble_siren_lp_01",(24520,78014,-114),"stop_scramble_siren_lp_01",1,20);
	wait(30);
	level notify("stop_scramble_siren_lp_01");
	wait(25);
	for(;;)
	{
		level.aud.scramble_siren_01 = soundscripts\_snd_playsound::snd_play_loop_at("scramble_siren_lp_01",(24520,78014,-114),"stop_scramble_siren_lp_01",15,30);
		wait(30);
		wait(randomfloatrange(45,90));
		level notify("stop_scramble_siren_lp_01");
		wait(30);
		wait(randomfloatrange(10,15));
	}
}

//Function Number: 178
start_sniper_scramble_music()
{
	soundscripts\_snd::snd_music_message("start_sniper_scramble");
}

//Function Number: 179
stop_scramble_emergency_audio()
{
	level notify("stop_scramble_emergency_responders");
	if(isdefined(level.aud.scramble_siren_01))
	{
		level notify("stop_scramble_siren_lp_01");
	}
}

//Function Number: 180
patio_intro_civ_death(param_00)
{
	level waittill("ScramblePatioCivShot");
	soundscripts\_audio_mix_manager::mm_add_submix("mhunt_ss_intro_civ_shot");
	soundscripts\_snd_playsound::snd_play_at("sniper_npc_head_shot",param_00.origin);
	wait(0.3);
	soundscripts\_audio_mix_manager::mm_clear_submix("mhunt_ss_intro_civ_shot");
	level notify("start_hotel_glass_think");
	soundscripts\_snd_playsound::snd_play_delayed_at("patio_intro_screams",(22760,75180,-829),0.4);
}

//Function Number: 181
patio_civ_01_cower(param_00)
{
	param_00 endon("death");
	for(;;)
	{
		level waittill("shot_fired_civ_reaction");
		if(isdefined(level.aud.patio_male_01_mumble) && level.aud.patio_male_01_mumble)
		{
			return;
		}
		else
		{
			level.aud.patio_male_01_mumble = 1;
			soundscripts\_snd_playsound::snd_play_at("grk_cm1_cower",param_00.origin);
			wait(3.5);
			level.aud.patio_male_01_mumble = 0;
		}
	}
}

//Function Number: 182
patio_civ_03_scream(param_00)
{
	level waittill("ScramblePatioCivShot");
	wait(randomfloatrange(2,4));
	soundscripts\_snd_playsound::snd_play_at("grk_cf1_scream",param_00.origin);
}

//Function Number: 183
gap_jump_squib_occlusion()
{
	soundscripts\_snd_filters::snd_set_occlusion("scramble_gap_jump");
}

//Function Number: 184
hotel_glass_footstep_think(param_00)
{
	level endon("stop_hotel_glass_think");
	level waittill("start_hotel_glass_think");
	if(!isdefined(param_00))
	{
		return;
	}

	for(;;)
	{
		level.aud.broken_glass = 0;
		foreach(var_02 in param_00)
		{
			if(level.player istouching(var_02))
			{
				level.aud.broken_glass = 1;
				break;
			}
		}

		wait(0.2);
	}
}

//Function Number: 185
hotel_crowd_panic_trigger()
{
	self waittill("trigger",var_00);
	if(isdefined(level.aud.hotel_crowd_panic_trigger) && level.aud.hotel_crowd_panic_trigger)
	{
		return;
	}

	level.aud.hotel_crowd_panic_trigger = 1;
	level notify("start_hotel_panic_02");
}

//Function Number: 186
hotel_crowd_panic_walla()
{
	soundscripts\_snd::snd_music_message("start_scramble_hotel");
	wait(6);
	soundscripts\_snd_playsound::snd_play_at("hotel_panic_walla_01",(23682,76444,-1039));
	level waittill("start_hotel_panic_02");
	soundscripts\_snd_playsound::snd_play_at("hotel_panic_walla_02",(23682,76444,-1039));
	wait(5.18);
	soundscripts\_snd_playsound::snd_play_at("hotel_panic_walla_03",(23682,76444,-1039));
}

//Function Number: 187
hotel_crowd_panic_walla_chkpt()
{
	soundscripts\_snd_playsound::snd_play_at("hotel_panic_walla_01",(23682,76444,-1039));
	level waittill("start_hotel_panic_02");
	soundscripts\_snd_playsound::snd_play_at("hotel_panic_walla_02",(23682,76444,-1039));
	wait(5.18);
	soundscripts\_snd_playsound::snd_play_at("hotel_panic_walla_03",(23682,76444,-1039));
}

//Function Number: 188
hotel_female_01_hallway(param_00)
{
	param_00 endon("death");
	level endon("start_jump_out_hotel_window");
	if(isdefined(level.aud.hotel_female_01_hallway) && level.aud.hotel_female_01_hallway)
	{
		return;
	}

	level.aud.hotel_female_01_hallway = 1;
	level waittill("start_hotel_panic_02");
	wait(2);
	for(;;)
	{
		soundscripts\_snd_playsound::snd_play_at("grk_cf1_cry",param_00.origin);
		wait(4);
	}
}

//Function Number: 189
hotel_civ_04_death(param_00)
{
	param_00 endon("goal");
	level endon("start_jump_out_hotel_window");
	param_00 waittill("death");
	soundscripts\_snd_playsound::snd_play_at("grk_cf1_death",param_00.origin);
}

//Function Number: 190
sniper_suppression_hit_alert()
{
	soundscripts\_snd_playsound::snd_play_delayed_2d("SP_hit_alert_npc",0);
}

//Function Number: 191
pool_civ_01_cower_setup()
{
	level notify("start_jump_out_hotel_window");
	thread pool_civ_wounded_woman();
	thread pool_walla_scream();
}

//Function Number: 192
pool_civ_01_cower(param_00)
{
	param_00 endon("death");
	level waittill("start_jump_out_hotel_window");
	wait(2.5);
	if(isdefined(level.aud.pool_male_01_cower) && level.aud.pool_male_01_cower)
	{
		return;
	}

	level.aud.pool_male_01_cower = 1;
	soundscripts\_snd_playsound::snd_play_at("grk_cm2_cower",param_00.origin);
}

//Function Number: 193
pool_civ_wounded_woman()
{
	if(isdefined(level.aud.pool_female_wounded) && level.aud.pool_female_wounded)
	{
		return;
	}

	level.aud.pool_female_wounded = 1;
	var_00 = spawn("script_origin",(23601,77253,-1203));
	var_00 civilian_panic_distance_check("grk_cf2_cry","",200,300);
	wait(10);
	var_00 delete();
}

//Function Number: 194
pool_walla_scream()
{
	soundscripts\_snd_playsound::snd_play_delayed_at("post_window_drop_screams",(23465,77076,-1191),3);
}

//Function Number: 195
drone_civ_02_flee(param_00)
{
	param_00 endon("death");
	level endon("audio_kva_drones_dead");
	if(isdefined(level.aud.drone_female_02_flee) && level.aud.drone_female_02_flee)
	{
		return;
	}

	level.aud.drone_female_02_flee = 1;
	level waittill("audio_kva_drones_inbound");
	wait(1);
	for(;;)
	{
		soundscripts\_snd_playsound::snd_play_at("grk_cf1_cry",param_00.origin);
		wait(8);
	}
}

//Function Number: 196
mhunt_snpr_dest_cafe_wall(param_00)
{
	soundscripts\_snd_playsound::snd_play_at("mhunt_snpr_dest_cafe_wall",param_00.origin);
	level notify("stop_hotel_glass_think");
}

//Function Number: 197
gondola_movement_loops(param_00)
{
	foreach(var_02 in param_00)
	{
		var_02 soundscripts\_snd_playsound::snd_play_loop_linked("gondola_lp","stop_gondola_audio");
	}
}

//Function Number: 198
start_swarm_drones_context()
{
	changewhizbyautosimparams(0,0,0,0,0,0);
}

//Function Number: 199
restaurant_doors_open(param_00)
{
	soundscripts\_snd_playsound::snd_play_at("restaurant_door_open",param_00.origin);
}

//Function Number: 200
restaurant_door_civ_killed(param_00)
{
	soundscripts\_snd_playsound::snd_play_at("restaurant_door_civ_shot",param_00.origin);
	wait(0.88);
	soundscripts\_snd_playsound::snd_play_at("restaurant_door_civ_fall",param_00.origin);
}

//Function Number: 201
restaurant_civ_03_cower(param_00)
{
	param_00 thread civilian_panic_distance_check("grk_cf1_scream","rest_civ_03_killed",200,300);
	param_00 waittill("death");
	level notify("rest_civ_03_killed");
}

//Function Number: 202
restaurant_wet_floor_think(param_00)
{
	level endon("audio_stop_restaurant_think");
	level waittill("fish_tank_destroyed");
	if(!isdefined(param_00))
	{
		return;
	}

	for(;;)
	{
		if(level.player istouching(param_00))
		{
			level.aud.restaurant_water = 1;
		}
		else
		{
			level.aud.restaurant_water = 0;
		}

		wait(0.2);
	}
}

//Function Number: 203
restaurant_fish_tank_destruct(param_00)
{
	soundscripts\_snd_playsound::snd_play_at("fish_tank_destruct",param_00.origin);
	soundscripts\_snd_playsound::snd_play_loop_at("fish_tank_destroyed_drip",param_00.origin,"stop_fish_tank_drip",1,1);
	wait(1);
	level notify("fish_tank_destroyed");
}

//Function Number: 204
ally_shoot_rpg_at_drones(param_00)
{
	if(isdefined(level.aud.rpg_shoot_dist) && level.aud.rpg_shoot_dist)
	{
		return;
	}

	level.aud.rpg_shoot_dist = 1;
	soundscripts\_audio_mix_manager::mm_add_submix("mhunt_stingerm7_fire");
	soundscripts\_snd_playsound::snd_play_at("ally_shoot_m7_dist",param_00.origin);
	wait(0.8);
	soundscripts\_audio_mix_manager::mm_clear_submix("mhunt_stingerm7_fire");
}

//Function Number: 205
finale_civ_04_cower(param_00)
{
	param_00 thread civilian_panic_distance_check("grk_cm2_cower_cry","finale_civ_04_killed",200,250);
	param_00 waittill("death");
	level notify("finale_civ_04_killed");
}

//Function Number: 206
manga_rocket_trail(param_00)
{
	param_00 playloopsound("wpn_stingerm7_loop");
}

//Function Number: 207
manga_rocket_explosion(param_00)
{
	soundscripts\_snd_playsound::snd_play_at("wpn_stingerm7_proj_impact",param_00.origin);
	param_00 stoploopsound();
}

//Function Number: 208
stingerm7_shoot_tower()
{
	if(isdefined(level.aud.rpg_shoot) && level.aud.rpg_shoot)
	{
		return;
	}

	level.aud.rpg_shoot = 1;
	soundscripts\_snd::snd_music_message("start_scramble_tower_collapse");
	soundscripts\_audio_mix_manager::mm_add_submix("mhunt_stingerm7_fire");
	soundscripts\_snd_playsound::snd_play_2d("mhunt_m7_shoot");
	wait(0.8);
	soundscripts\_audio_mix_manager::mm_clear_submix("mhunt_stingerm7_fire");
}

//Function Number: 209
mhunt_snpr_tower_collapse()
{
	soundscripts\_snd_playsound::snd_play_at("mhunt_snpr_tower_expl_front",(20250,81380,-712));
	soundscripts\_snd_playsound::snd_play_at("mhunt_snpr_tower_expl_rear",(22350,79275,-712));
	wait(1);
	soundscripts\_snd_playsound::snd_play_at("mhunt_snpr_tower_collapse_front",(20250,81380,-712));
	soundscripts\_snd_playsound::snd_play_at("mhunt_snpr_tower_collapse_rear",(22350,79275,-712));
	wait(2);
	soundscripts\_snd::snd_music_message("start_sniper_tower_collapse_music");
}

//Function Number: 210
stop_swarm_drones_context()
{
	changewhizbyautosimparams(0,0,0,0,1,1);
}

//Function Number: 211
exit_truck_fire(param_00)
{
	if(isdefined(level.aud.exit_truck_fire) && level.aud.exit_truck_fire)
	{
		return;
	}

	level.aud.exit_truck_fire = 1;
	param_00 soundscripts\_snd_playsound::snd_play_loop_linked("fire_exit_truck");
}

//Function Number: 212
start_finale_transition_music()
{
	soundscripts\_snd::snd_music_message("start_transition_to_finale");
}

//Function Number: 213
finale_street_crowd()
{
	wait(2);
	soundscripts\_snd_playsound::snd_play_loop_at("street_crowd_gathering",(21642,82518,-1398),"stop_finale_crowd_walla",2,0.3);
	level waittill("EndingFinaleCivsFlee");
	wait(0.55);
	soundscripts\_snd_playsound::snd_play_at("street_crowd_scream",(21642,82518,-1398));
	level notify("stop_finale_crowd_walla");
}

//Function Number: 214
player_place_ied_foley()
{
	soundscripts\_snd_playsound::snd_play_delayed_2d("ied_foley_placement",0.15);
	thread player_ied_footsteps_left();
	thread player_ied_footsteps_right();
}

//Function Number: 215
player_ied_footsteps_left()
{
	level endon("stop_ied_footstep_loop");
	for(;;)
	{
		level waittill("vm_ied_footstep_left");
		soundscripts\_snd_playsound::snd_play_2d("gear_rattle_plr_run_l");
		soundscripts\_snd_playsound::snd_play_2d("step_run_plr_default_l");
	}
}

//Function Number: 216
player_ied_footsteps_right()
{
	level endon("stop_ied_footstep_loop");
	for(;;)
	{
		level waittill("vm_ied_footstep_right");
		soundscripts\_snd_playsound::snd_play_2d("gear_rattle_plr_run_r");
		soundscripts\_snd_playsound::snd_play_2d("step_run_plr_default_r");
	}
}

//Function Number: 217
start_ied_convoy_ambush_expl()
{
	soundscripts\_audio_mix_manager::mm_add_submix("mhunt_ied_ambush_slomo");
	wait(0.1);
	soundscripts\_snd_playsound::snd_play_2d("mhunt_ied_convoy_slomo_start","stop_ambush_slomo",0.18,0.13);
	level notify("stop_ied_footstep_loop");
}

//Function Number: 218
start_ied_convoy_slomo_end()
{
	soundscripts\_snd_playsound::snd_play_2d("mhunt_ied_convoy_slomo_stop");
}

//Function Number: 219
stop_ied_convoy_ambush_expl()
{
	soundscripts\_snd::snd_music_message("start_truck_drive_in_ied");
	soundscripts\_audio_mix_manager::mm_clear_submix("mhunt_ied_ambush_slomo",0.3);
	level notify("stop_ambush_slomo");
}

//Function Number: 220
convoy_crash_emitters()
{
	soundscripts\_snd_playsound::snd_play_loop_at("fire_convoy_truck_01",(20855,82318,-1433),"stop_convoy_crash_emitters");
	soundscripts\_snd_playsound::snd_play_loop_at("steam_convoy_truck_02",(20369,82253,-1601),"stop_convoy_crash_emitters");
	soundscripts\_snd_playsound::snd_play_loop_at("pings_convoy_truck_02",(20382,82337,-1599),"stop_convoy_crash_emitters");
	soundscripts\_snd_playsound::snd_play_loop_at("steam_convoy_truck_03",(19076,82406,-1667),"stop_convoy_crash_emitters");
	soundscripts\_snd_playsound::snd_play_loop_at("pings_convoy_truck_02",(19012,82456,-1654),"stop_convoy_crash_emitters");
}

//Function Number: 221
convoy_truck_explosion(param_00)
{
	soundscripts\_snd_playsound::snd_play_at("lag_rndabt_car_large_explo",param_00.origin);
}

//Function Number: 222
enemy_on_fire()
{
	self endon("death");
	var_00 = soundscripts\_snd_playsound::snd_play_loop_at("fire_dead_body",self.origin);
	for(;;)
	{
		var_00 moveto(self.origin,0.05);
		wait(0.05);
	}
}

//Function Number: 223
start_finale_fight_music()
{
	wait(2.3);
	soundscripts\_snd::snd_music_message("start_finale_fight_music");
}

//Function Number: 224
stop_finale_fight_music()
{
	soundscripts\_snd::snd_music_message("stop_finale_fight_music");
}

//Function Number: 225
start_hades_suv_extraction()
{
	level.player enablecustomweaponcontext();
	soundscripts\_snd_common::snd_enable_soundcontextoverride("slomo");
	soundscripts\_audio_mix_manager::mm_add_submix("mhunt_suv_charge_plyr_slomo");
	soundscripts\_snd_playsound::snd_play_2d("mhunt_hades_suv_slomo_start","stop_suv_slomo",0.18,0.13);
}

//Function Number: 226
stop_hades_suv_extraction()
{
	soundscripts\_snd_common::snd_disable_soundcontextoverride("slomo");
	level.player disablecustomweaponcontext();
	soundscripts\_audio_mix_manager::mm_clear_submix("mhunt_suv_charge_plyr_slomo");
	level notify("stop_suv_slomo");
	soundscripts\_snd_playsound::snd_play_2d("mhunt_hades_suv_slomo_stop");
}

//Function Number: 227
start_finale_suv_damage()
{
	wait(3);
	soundscripts\_snd_playsound::snd_play_loop_at("mhunt_finale_suv_fire_lp",(19270,81691,-1665),"",0.25);
	soundscripts\_snd_playsound::snd_play_loop_at("mhunt_finale_suv_hiss_lp",(19306,81695,-1665),"",2);
	soundscripts\_snd_playsound::snd_play_loop_at("mhunt_finale_suv_pings_lp",(19334,81680,-1665),"",0.5);
}

//Function Number: 228
start_finale_h2h_music()
{
	wait(5);
	soundscripts\_snd::snd_music_message("start_finale_h2h_music");
}

//Function Number: 229
start_exo_sonic_attack_fail()
{
	soundscripts\_snd_playsound::snd_play_2d("mhunt_exo_sonic_attack_fail");
}

//Function Number: 230
hades_throat_slash()
{
	thread stop_finale_h2h_music();
	thread irons_knows_music();
}

//Function Number: 231
start_hades_kill_interact_fail()
{
	soundscripts\_audio_mix_manager::mm_add_submix("mhunt_hades_revenge");
	thread stop_finale_h2h_music();
}

//Function Number: 232
stop_finale_h2h_music()
{
	if(isdefined(level.aud.hades_end_mx) && level.aud.hades_end_mx)
	{
		return;
	}

	level.aud.hades_end_mx = 1;
	soundscripts\_snd::snd_music_message("stop_finale_h2h_music");
}

//Function Number: 233
irons_knows_music()
{
	level waittill("start_hades_awake_music");
	wait(0.2);
	soundscripts\_snd::snd_music_message("start_finale_irons_knows");
}

//Function Number: 234
mhunt_level_end()
{
	soundscripts\_audio_mix_manager::mm_add_submix("mhunt_level_fade_out");
}

//Function Number: 235
aud_create_entity(param_00)
{
	return spawn("script_origin",param_00);
}

//Function Number: 236
aud_create_linked_entity(param_00,param_01)
{
	var_02 = spawn("script_origin",param_00.origin);
	if(isdefined(param_01))
	{
		var_02 linkto(param_00,"",param_01,(0,0,0));
	}
	else
	{
		var_02 linkto(param_00);
	}

	return var_02;
}

//Function Number: 237
aud_play(param_00,param_01)
{
	var_02 = 0;
	if(isdefined(param_01))
	{
		var_02 = param_01;
	}

	if(var_02)
	{
		self playloopsound(param_00);
		return;
	}

	self playsound(param_00,"sounddone");
	aud_delete_on_sounddone();
}

//Function Number: 238
aud_fade_in(param_00,param_01,param_02)
{
	var_03 = 0;
	if(isdefined(param_02))
	{
		var_03 = param_02;
	}

	if(var_03)
	{
		self playloopsound(param_00);
	}
	else
	{
		self playsound(param_00,"sounddone");
		aud_delete_on_sounddone();
	}

	if(param_01 > 0)
	{
		thread audx_fade_in_internal(param_01);
	}
}

//Function Number: 239
audx_fade_in_internal(param_00)
{
	self scalevolume(0);
	wait(0.05);
	if(!isdefined(self))
	{
		return;
	}

	self scalevolume(1,param_00);
}

//Function Number: 240
aud_fade_out(param_00)
{
	thread audx_fade_out_internal(param_00);
}

//Function Number: 241
audx_fade_out_internal(param_00)
{
	self scalevolume(0,param_00);
	wait(param_00 + 0.05);
	if(!isdefined(self))
	{
		return;
	}

	self stopsounds();
	self stoploopsound();
	wait(0.05);
	if(!isdefined(self))
	{
		return;
	}

	self delete();
}

//Function Number: 242
aud_delete_on_sounddone()
{
	thread audx_delete_on_sounddone_internal();
}

//Function Number: 243
audx_delete_on_sounddone_internal()
{
	self endon("death");
	self waittill("sounddone");
	if(!isdefined(self))
	{
		return;
	}

	self delete();
}

//Function Number: 244
civilian_panic_distance_check(param_00,param_01,param_02,param_03)
{
	self endon("death");
	for(;;)
	{
		var_04 = distance(level.player.origin,self.origin);
		var_05 = randomintrange(param_02,param_03);
		if(var_04 <= var_05)
		{
			soundscripts\_snd_playsound::snd_play_at(param_00,self.origin,param_01);
			return;
		}

		wait(0.25);
	}
}

//Function Number: 245
footstep_environmental_elements()
{
	level.player endon("death");
	for(;;)
	{
		level.player waittill("foley",var_00,var_01,var_02);
		switch(var_00)
		{
			case "stationarycrouchscuff":
				break;
	
			case "stationaryscuff":
				break;
	
			case "crouchscuff":
				break;
	
			case "runscuff":
				break;
	
			case "sprintscuff":
				break;
	
			case "prone":
				break;
	
			case "crouchwalk":
				break;
	
			case "crouchrun":
				break;
	
			case "walk":
				if(isdefined(level.aud.broken_glass) && level.aud.broken_glass == 1)
				{
					soundscripts\_snd_playsound::snd_play_2d("mh_step_walk_plr_glass");
				}
				else if(isdefined(level.aud.restaurant_water) && level.aud.restaurant_water == 1)
				{
					if(var_02)
					{
						soundscripts\_snd_playsound::snd_play_2d("mh_step_walk_plr_water_l");
					}
					else
					{
						soundscripts\_snd_playsound::snd_play_2d("mh_step_walk_plr_water_r");
					}
				}
				break;
	
			case "run":
				if(isdefined(level.aud.broken_glass) && level.aud.broken_glass == 1)
				{
					soundscripts\_snd_playsound::snd_play_2d("mh_step_run_plr_glass");
				}
				else if(isdefined(level.aud.restaurant_water) && level.aud.restaurant_water == 1)
				{
					if(var_02)
					{
						soundscripts\_snd_playsound::snd_play_2d("mh_step_run_plr_water_l");
					}
					else
					{
						soundscripts\_snd_playsound::snd_play_2d("mh_step_run_plr_water_r");
					}
				}
				break;
	
			case "sprint":
				if(isdefined(level.aud.broken_glass) && level.aud.broken_glass == 1)
				{
					soundscripts\_snd_playsound::snd_play_2d("mh_step_sprint_plr_glass");
				}
				else if(isdefined(level.aud.restaurant_water) && level.aud.restaurant_water == 1)
				{
					if(var_02)
					{
						soundscripts\_snd_playsound::snd_play_2d("mh_step_sprint_plr_water_l");
					}
					else
					{
						soundscripts\_snd_playsound::snd_play_2d("mh_step_sprint_plr_water_r");
					}
				}
				break;
	
			case "jump":
				break;
	
			case "lightland":
				if(isdefined(level.aud.broken_glass) && level.aud.broken_glass == 1)
				{
					soundscripts\_snd_playsound::snd_play_2d("mh_step_land_plr_lt_glass");
				}
				else if(isdefined(level.aud.restaurant_water) && level.aud.restaurant_water == 1)
				{
					soundscripts\_snd_playsound::snd_play_2d("mh_step_land_plr_lt_water");
				}
				break;
	
			case "mediumland":
				if(isdefined(level.aud.broken_glass) && level.aud.broken_glass == 1)
				{
					soundscripts\_snd_playsound::snd_play_2d("mh_step_land_plr_med_glass");
				}
				else if(isdefined(level.aud.restaurant_water) && level.aud.restaurant_water == 1)
				{
					soundscripts\_snd_playsound::snd_play_2d("mh_step_land_plr_med_water");
				}
				break;
	
			case "heavyland":
				if(isdefined(level.aud.broken_glass) && level.aud.broken_glass == 1)
				{
					soundscripts\_snd_playsound::snd_play_2d("mh_step_land_plr_hv_glass");
				}
				else if(isdefined(level.aud.restaurant_water) && level.aud.restaurant_water == 1)
				{
					soundscripts\_snd_playsound::snd_play_2d("mh_step_land_plr_hv_water");
				}
				break;
	
			case "damageland":
				break;
	
			case "mantleuphigh":
				break;
	
			case "mantleupmedium":
				break;
	
			case "mantleuplow":
				break;
	
			case "mantleoverhigh":
				break;
	
			case "mantleovermedium":
				break;
	
			case "mantleoverlow":
				break;
		}
	}
}