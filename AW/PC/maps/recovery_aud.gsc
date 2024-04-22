/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: recovery_aud.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 256
 * Decompile Time: 3663 ms
 * Timestamp: 4/22/2024 2:34:26 AM
*******************************************************************/

//Function Number: 1
main()
{
	config_system();
	init_snd_flags();
	init_globals();
	launch_threads();
	launch_loops();
	create_level_envelop_arrays();
	precache_presets();
	register_snd_messages();
}

//Function Number: 2
register_snd_messages()
{
	soundscripts\_snd::snd_register_message("snd_zone_handler",::zone_handler);
	soundscripts\_snd::snd_register_message("snd_music_handler",::music_handler);
	soundscripts\_snd::snd_register_message("start_funeral",::start_funeral);
	soundscripts\_snd::snd_register_message("start_training_01",::start_training_01);
	soundscripts\_snd::snd_register_message("start_training_01_lodge",::start_training_01_lodge);
	soundscripts\_snd::snd_register_message("start_training_01_lodge_breach",::start_training_01_lodge_breach);
	soundscripts\_snd::snd_register_message("start_training_01_lodge_exit",::start_training_01_lodge_exit);
	soundscripts\_snd::snd_register_message("start_training_01_golf_course",::start_training_01_golf_course);
	soundscripts\_snd::snd_register_message("start_training_01_end",::start_training_01_end);
	soundscripts\_snd::snd_register_message("start_tour_ride",::start_tour_ride);
	soundscripts\_snd::snd_register_message("start_tour_exo",::start_tour_exo);
	soundscripts\_snd::snd_register_message("start_tour_exo_exit",::start_tour_exo_exit);
	soundscripts\_snd::snd_register_message("start_tour_firing_range",::start_tour_firing_range);
	soundscripts\_snd::snd_register_message("start_tour_augmented_reality",::start_tour_augmented_reality);
	soundscripts\_snd::snd_register_message("start_tour_end",::start_tour_end);
	soundscripts\_snd::snd_register_message("start_training_02",::start_training_02);
	soundscripts\_snd::snd_register_message("start_training_02_lodge",::start_training_02_lodge);
	soundscripts\_snd::snd_register_message("start_training_02_lodge_breach",::start_training_02_lodge_breach);
	soundscripts\_snd::snd_register_message("start_training_02_lodge_exit",::start_training_02_lodge_exit);
	soundscripts\_snd::snd_register_message("start_training_02_golf_course",::start_training_02_golf_course);
	soundscripts\_snd::snd_register_message("start_training_02_end",::start_training_02_end);
	soundscripts\_snd::snd_register_message("camp_david_thunder_transition",::camp_david_thunder_transition);
	soundscripts\_snd::snd_register_message("camp_david_reload_malfunction",::camp_david_reload_malfunction);
	soundscripts\_snd::snd_register_message("rec_s2_door_guy_ambush",::rec_s2_door_guy_ambush);
	soundscripts\_snd::snd_register_message("camp_david_training_mute_device",::camp_david_training_mute_device);
	soundscripts\_snd::snd_register_message("rec_mute_breach_slo_mo1",::rec_mute_breach_slo_mo1);
	soundscripts\_snd::snd_register_message("rec_chair_kva_gets_shot",::rec_chair_kva_gets_shot);
	soundscripts\_snd::snd_register_message("rec_kva_with_president_gets_shot",::rec_kva_with_president_gets_shot);
	soundscripts\_snd::snd_register_message("rec_s1_president_killed",::rec_s1_president_killed);
	soundscripts\_snd::snd_register_message("rec_bathroom_guy",::rec_bathroom_guy);
	soundscripts\_snd::snd_register_message("rec_plr_kills_president",::rec_plr_kills_president);
	soundscripts\_snd::snd_register_message("rec_s1_drones_fly_by",::rec_s1_drones_fly_by);
	soundscripts\_snd::snd_register_message("rec_s1_drones_attack",::rec_s1_drones_attack);
	soundscripts\_snd::snd_register_message("rec_drone_scanner",::rec_drone_scanner);
	soundscripts\_snd::snd_register_message("patio_flashbang",::patio_flashbang);
	soundscripts\_snd::snd_register_message("rec_train1_stealth_car_spawn",::rec_train1_stealth_car_spawn);
	soundscripts\_snd::snd_register_message("rec_train1_stealth_car_stop",::rec_train1_stealth_car_stop);
	soundscripts\_snd::snd_register_message("s1_popping_smoke",::s1_popping_smoke);
	soundscripts\_snd::snd_register_message("rec_train1_exfil_car_start",::rec_train1_exfil_car_start);
	soundscripts\_snd::snd_register_message("rec_train1_end",::rec_train1_end);
	soundscripts\_snd::snd_register_message("tour_jeep_startup",::tour_jeep_startup);
	soundscripts\_snd::snd_register_message("rec_tour_vtol_takeoff_spawn",::rec_tour_vtol_takeoff_spawn);
	soundscripts\_snd::snd_register_message("rec_littlebird_formation_spawn",::rec_littlebird_formation_spawn);
	soundscripts\_snd::snd_register_message("rec_tour_vehicle_1_start",::rec_tour_vehicle_1_start);
	soundscripts\_snd::snd_register_message("civ_domestic_truck_spawn",::civ_domestic_truck_spawn);
	soundscripts\_snd::snd_register_message("attack_drone_flybys_audio",::attack_drone_flybys_audio);
	soundscripts\_snd::snd_register_message("tour_drones_fly_by",::tour_drones_fly_by);
	soundscripts\_snd::snd_register_message("vrap_spawn",::vrap_spawn);
	soundscripts\_snd::snd_register_message("tour_littlebird_lander",::tour_littlebird_lander);
	soundscripts\_snd::snd_register_message("rec_tour_titan_gate_plr_open",::rec_tour_titan_gate_plr_open);
	soundscripts\_snd::snd_register_message("rec_tour_titan_1_start",::rec_tour_titan_1_start);
	soundscripts\_snd::snd_register_message("rec_tour_escort_jeep_start",::rec_tour_escort_jeep_start);
	soundscripts\_snd::snd_register_message("rec_tour_titan_2_walk_anim_start",::rec_tour_titan_2_walk_anim_start);
	soundscripts\_snd::snd_register_message("tour_hangar_drones",::tour_hangar_drones);
	soundscripts\_snd::snd_register_message("rec_tour_end_jeep_gate_plr_open",::rec_tour_end_jeep_gate_plr_open);
	soundscripts\_snd::snd_register_message("rec_tour_end_jeep_gate_plr_close",::rec_tour_end_jeep_gate_plr_close);
	soundscripts\_snd::snd_register_message("rec_tour_npc_jeep_exit_gate_open",::rec_tour_npc_jeep_exit_gate_open);
	soundscripts\_snd::snd_register_message("rec_tour_npc_jeep_exit_gate_close",::rec_tour_npc_jeep_exit_gate_close);
	soundscripts\_snd::snd_register_message("tour_littlebird_ambient",::tour_littlebird_ambient);
	soundscripts\_snd::snd_register_message("rec_exo_arm_repair_attempt_01_npc",::rec_exo_arm_repair_attempt_01_npc);
	soundscripts\_snd::snd_register_message("rec_exo_arm_repair_attempt_02_npc",::rec_exo_arm_repair_attempt_02_npc);
	soundscripts\_snd::snd_register_message("rec_exo_arm_repair_attempt_03_npc",::rec_exo_arm_repair_attempt_03_npc);
	soundscripts\_snd::snd_register_message("exo_repair_movement",::exo_repair_movement);
	soundscripts\_snd::snd_register_message("exo_repair_weight_updates",::exo_repair_weight_updates);
	soundscripts\_snd::snd_register_message("exo_repair_movement_stop",::exo_repair_movement_stop);
	soundscripts\_snd::snd_register_message("rec_exo_arm_repair_attempt_exit_npc",::rec_exo_arm_repair_attempt_exit_npc);
	soundscripts\_snd::snd_register_message("tour_base_ambient_vehicle_01",::tour_base_ambient_vehicle_01);
	soundscripts\_snd::snd_register_message("exo_drone_flby",::exo_drone_flby);
	soundscripts\_snd::snd_register_message("shooting_range_transition1",::shooting_range_transition1);
	soundscripts\_snd::snd_register_message("shooting_range_panels_up",::shooting_range_panels_up);
	soundscripts\_snd::snd_register_message("shooting_range_enemy_spawn",::shooting_range_enemy_spawn);
	soundscripts\_snd::snd_register_message("shooting_range_target_despawn",::shooting_range_target_despawn);
	soundscripts\_snd::snd_register_message("shooting_range_enemy_shot",::shooting_range_enemy_shot);
	soundscripts\_snd::snd_register_message("shooting_range_friendly_spawn",::shooting_range_friendly_spawn);
	soundscripts\_snd::snd_register_message("shooting_range_friendly_shot",::shooting_range_friendly_shot);
	soundscripts\_snd::snd_register_message("shooting_range_transition2",::shooting_range_transition2);
	soundscripts\_snd::snd_register_message("shooting_range_transition3",::shooting_range_transition3);
	soundscripts\_snd::snd_register_message("shooting_range_panels_down",::shooting_range_panels_down);
	soundscripts\_snd::snd_register_message("tour_base_ambient_vehicle_02",::tour_base_ambient_vehicle_02);
	soundscripts\_snd::snd_register_message("smart_grenade_target_flip",::smart_grenade_target_flip);
	soundscripts\_snd::snd_register_message("smart_grenade_target_move",::smart_grenade_target_move);
	soundscripts\_snd::snd_register_message("smart_grenade_target_move_back",::smart_grenade_target_move_back);
	soundscripts\_snd::snd_register_message("smart_grenade_target_hit",::smart_grenade_target_hit);
	soundscripts\_snd::snd_register_message("smart_grenade_target_shot",::smart_grenade_target_shot);
	soundscripts\_snd::snd_register_message("smart_grenade_target_flip_down",::smart_grenade_target_flip_down);
	soundscripts\_snd::snd_register_message("smart_grenade_target_expire",::smart_grenade_target_expire);
	soundscripts\_snd::snd_register_message("rec_readyroom_elevator_left_hatch_back",::rec_readyroom_elevator_left_hatch_back);
	soundscripts\_snd::snd_register_message("rec_readyroom_elevator_left_hatch_front",::rec_readyroom_elevator_left_hatch_front);
	soundscripts\_snd::snd_register_message("rec_s2_breach_gun_holster",::rec_s2_breach_gun_holster);
	soundscripts\_snd::snd_register_message("rec_slomo_audio_handler",::rec_slomo_audio_handler);
	soundscripts\_snd::snd_register_message("rec_s2_breach_slo_mo",::rec_s2_breach_slo_mo);
	soundscripts\_snd::snd_register_message("rec_slomo_kill_bad_guy",::rec_slomo_kill_bad_guy);
	soundscripts\_snd::snd_register_message("aud_training_s2_potus_ziptie_release",::aud_training_s2_potus_ziptie_release);
	soundscripts\_snd::snd_register_message("rec_s2_drones_attack",::rec_s2_drones_attack);
	soundscripts\_snd::snd_register_message("rec_player_drone_start",::rec_player_drone_start);
	soundscripts\_snd::snd_register_message("rec_player_drone_end",::rec_player_drone_end);
	soundscripts\_snd::snd_register_message("snd_player_drone_deploy",::snd_player_drone_deploy);
	soundscripts\_snd::snd_register_message("snd_player_drone_wrist_panel",::snd_player_drone_wrist_panel);
	soundscripts\_snd::snd_register_message("snd_player_drone_enter_drone_pov",::snd_player_drone_enter_drone_pov);
	soundscripts\_snd::snd_register_message("rec_train2_exfil_car_start",::rec_train2_exfil_car_start);
	soundscripts\_snd::snd_register_message("rec_train2_exfil_car_end",::rec_train2_exfil_car_end);
	soundscripts\_snd::snd_register_message("rec_train2_ambush_car_1",::rec_train2_ambush_car_1);
	soundscripts\_snd::snd_register_message("rec_train2_ambush_car_2",::rec_train2_ambush_car_2);
	soundscripts\_snd::snd_register_message("rec_star_trek_door_open",::rec_star_trek_door_open);
	soundscripts\_snd::snd_register_message("rec_star_trek_door_close",::rec_star_trek_door_close);
	soundscripts\_snd::snd_register_message("temp_dog_bark",::temp_dog_bark);
}

//Function Number: 3
register_notetracks()
{
	wait 0.05;
	maps\_anim::addnotetrack_customfunction("irons","eulogy_irons_stand",::eulogy_irons_stand,"rec_funeral_eulogy_ends_irons");
	maps\_anim::addnotetrack_customfunction("irons","eulogy_irons_touch",::eulogy_irons_touch,"rec_funeral_eulogy_ends_irons");
	maps\_anim::addnotetrack_customfunction("irons","eulogy_irons_leave",::eulogy_irons_leave,"rec_funeral_eulogy_ends_irons");
	maps\_anim::addnotetrack_customfunction("irons","atlascard_irons_turn",::atlascard_irons_turn,"rec_funeral_altascard_irons");
	maps\_anim::addnotetrack_customfunction("irons","atlascard_irons_walk",::atlascard_irons_walk,"rec_funeral_altascard_irons");
	maps\_anim::addnotetrack_customfunction("irons","atlascard_irons_handshake",::atlascard_irons_handshake,"rec_funeral_altascard_irons");
	maps\_anim::addnotetrack_customfunction("irons","atlascard_irons_place_hand",::atlascard_irons_place_hand,"rec_funeral_altascard_irons");
	maps\_anim::addnotetrack_customfunction("irons","atlascard_irons_tap",::atlascard_irons_tap,"rec_funeral_altascard_irons");
	maps\_anim::addnotetrack_customfunction("irons","atlascard_irons_grab_card",::atlascard_irons_grab_card,"rec_funeral_altascard_irons");
	maps\_anim::addnotetrack_customfunction("irons","atlascard_irons_leave",::atlascard_irons_leave,"rec_funeral_altascard_irons");
	maps\_anim::addnotetrack_customfunction("cormack","eulogy_cormack_approach",::eulogy_cormack_approach,"rec_funeral_eulogy_ends_cormack");
	maps\_anim::addnotetrack_customfunction("cormack","eulogy_cormack_touch",::eulogy_cormack_touch,"rec_funeral_eulogy_ends_cormack");
	maps\_anim::addnotetrack_customfunction("cormack","eulogy_cormack_leave",::eulogy_cormack_leave,"rec_funeral_eulogy_ends_cormack");
	maps\_anim::addnotetrack_customfunction("cormack","atlascard_cormack_walk",::atlascard_cormack_walk,"rec_funeral_altascard_cormack");
	maps\_anim::addnotetrack_customfunction("player_rig_funeral","eulogy_player_touch",::eulogy_player_touch,"rec_funeral_walktocar_vm");
	maps\_anim::addnotetrack_customfunction("player_rig","campdavid_player_arm_reveal",::campdavid_player_arm_reveal,"rec_campdavid_intro");
	maps\_anim::addnotetrack_customfunction("joker","rec_threat01_joker_start",::rec_threat01_joker_start,"training_s1_threat_guy_open");
	maps\_anim::addnotetrack_customfunction("joker","rec_threat01_joker_kick",::rec_threat01_joker_kick,"training_s1_threat_guy_out");
	maps\_anim::addnotetrack_customfunction("joker","rec_mute01_joker_start",::rec_mute01_joker_start,"training_s1_exo_breach_joker_start");
	maps\_anim::addnotetrack_customfunction("joker","rec_mute01_joker_breach",::rec_mute01_joker_breach,"training_s1_exo_breach_joker_start");
	maps\_anim::addnotetrack_customfunction("joker","rec_mute01_joker_run",::rec_mute01_joker_run,"training_s1_exo_breach_joker_start");
	maps\_anim::addnotetrack_customfunction("joker","rec_mute01_joker_kick",::rec_mute01_joker_kick,"training_s1_exo_breach_joker_start");
	maps\_anim::addnotetrack_customfunction("joker","rec_mute01_joker_turn",::rec_mute01_joker_turn,"training_s1_exo_breach_joker_start");
	maps\_anim::addnotetrack_customfunction("generic","rec_mute01_kva_with_gun_killed",::rec_mute01_kva_with_gun_killed,"training_s1_exo_breach_kva1_success");
	maps\_anim::addnotetrack_customfunction("generic","rec_mute01_kva_kicked",::rec_mute01_kva_kicked,"training_s1_exo_breach_kva3_start");
	maps\_anim::addnotetrack_customfunction("generic","rec_mute01_kva_hits_wall",::rec_mute01_kva_hits_wall,"training_s1_exo_breach_kva3_start");
	maps\_anim::addnotetrack_customfunction("generic","rec_mute01_chair_kva_killed",::rec_mute01_chair_kva_killed,"training_s1_exo_breach_kva2_start");
	maps\_anim::addnotetrack_customfunction("joker","rec_mute01_potus_free",::rec_mute01_potus_free,"training_s1_exo_breach_joker_release");
	maps\_anim::addnotetrack_customfunction("joker","rec_training01_lodge_stealth_exit_start",::rec_training01_lodge_stealth_exit_start,"training_s1_patio_joker_door_slow_in");
	maps\_anim::addnotetrack_customfunction("joker","rec_training01_lodge_stealth_open",::rec_training01_lodge_stealth_open,"training_s1_patio_joker_door_slow_open");
	maps\_anim::addnotetrack_customfunction("joker","rec_training01_lodge_stealth_exit_end",::rec_training01_lodge_stealth_exit_end,"training_s1_patio_joker_door_slow_out");
	maps\_anim::addnotetrack_customfunction("player_rig","training_01_end_player_arm_malfunction",::training_01_end_player_arm_malfunction,"training_s1_player_end");
	maps\_anim::addnotetrack_customfunction("player_rig","training_01_end_player_punched",::training_01_end_player_punched,"training_s1_player_end");
	maps\_anim::addnotetrack_customfunction("player_rig","training_01_end_player_helped_up",::training_01_end_player_helped_up,"training_s1_player_end");
	maps\_anim::addnotetrack_customfunction("player_rig","training_01_end_player_arm_up",::training_01_end_player_arm_up,"training_s1_player_end");
	maps\_anim::addnotetrack_customfunction("player_rig","training_01_end_player_enters_jeep",::training_01_end_player_enters_jeep,"training_s1_player_end_jeep_enter");
	maps\_anim::addnotetrack_customfunction("player_rig","training_01_end_player_moves_to_seat",::training_01_end_player_moves_to_seat,"training_s1_player_end_jeep_enter");
	maps\_anim::addnotetrack_customfunction("player_rig","training_01_end_player_sits",::training_01_end_player_sits,"training_s1_player_end_jeep_enter");
	maps\_anim::addnotetrack_customfunction("gideon","training_01_end_gideon_walk",::training_01_end_gideon_walk,"training_s1_gideon_end");
	maps\_anim::addnotetrack_customfunction("gideon","training_01_end_gideon_punch",::training_01_end_gideon_punch,"training_s1_gideon_end");
	maps\_anim::addnotetrack_customfunction("gideon","training_01_end_gideon_pulls_gun",::training_01_end_gideon_pulls_gun,"training_s1_gideon_end");
	maps\_anim::addnotetrack_customfunction("gideon","training_01_end_gideon_shoots_potus",::training_01_end_gideon_shoots_potus,"training_s1_gideon_end");
	maps\_anim::addnotetrack_customfunction("gideon","training_01_end_gideon_to_player",::training_01_end_gideon_to_player,"training_s1_gideon_end");
	maps\_anim::addnotetrack_customfunction("gideon","training_01_end_gideon_mask",::training_01_end_gideon_mask,"training_s1_gideon_end");
	maps\_anim::addnotetrack_customfunction("gideon","training_01_end_gideon_gun_away",::training_01_end_gideon_gun_away,"training_s1_gideon_end");
	maps\_anim::addnotetrack_customfunction("gideon","training_01_end_gideon_helps_up_plr",::training_01_end_gideon_helps_up_plr,"training_s1_gideon_end");
	maps\_anim::addnotetrack_customfunction("gideon","training_01_end_gideon_grabs_arm",::training_01_end_gideon_grabs_arm,"training_s1_gideon_end");
	maps\_anim::addnotetrack_customfunction("gideon","training_01_end_gideon_idles",::training_01_end_gideon_idles,"training_s1_gideon_end");
	maps\_anim::addnotetrack_customfunction("gideon","training_01_end_gideon_walks_away",::training_01_end_gideon_walks_away,"training_s1_gideon_end");
	maps\_anim::addnotetrack_customfunction("gideon","training_01_end_gideon_enter_jeep",::training_01_end_gideon_enter_jeep,"training_s1_gideon_end_enter");
	maps\_anim::addnotetrack_customfunction("irons","training_01_end_irons_exit_jeep",::training_01_end_irons_exit_jeep,"training_s1_irons_end");
	maps\_anim::addnotetrack_customfunction("irons","training_01_end_irons_hand_on_shoulder",::training_01_end_irons_hand_on_shoulder,"training_s1_irons_end");
	maps\_anim::addnotetrack_customfunction("irons","training_01_end_irons_walk_away",::training_01_end_irons_walk_away,"training_s1_irons_end");
	maps\_anim::addnotetrack_customfunction("irons","training_01_end_irons_enter_jeep",::training_01_end_irons_enter_jeep,"training_s1_irons_end");
	maps\_anim::addnotetrack_customfunction("president","training_01_end_potus_threatened",::training_01_end_potus_threatened,"training_s1_president_end");
	maps\_anim::addnotetrack_customfunction("president","training_01_end_potus_shot",::training_01_end_potus_shot,"training_s1_president_end");
	maps\_anim::addnotetrack_customfunction("president","training_01_end_potus_gets_up",::training_01_end_potus_gets_up,"training_s1_president_end");
	maps\_anim::addnotetrack_customfunction("driver","training_01_end_driver_seat_movement",::training_01_end_driver_seat_movement,"training_s1_driver_end_enter");
	maps\_anim::addnotetrack_customfunction("driver","training_01_end_driver_gear_shift",::training_01_end_driver_gear_shift,"training_s1_driver_end_enter");
	maps\_anim::addnotetrack_customfunction("jeep","rec_training1_jeep_enter",::rec_training1_jeep_enter,"training_s1_vehicle_tour_end");
	maps\_anim::addnotetrack_customfunction("jeep","rec_training1_jeep_arrive",::rec_training1_jeep_arrive,"training_s1_vehicle_tour_end");
	maps\_anim::addnotetrack_customfunction("jeep","rec_training1_jeep_irons_door_open",::rec_training1_jeep_irons_door_open,"training_s1_vehicle_tour_end");
	maps\_anim::addnotetrack_customfunction("jeep","rec_training1_jeep_irons_door_close",::rec_training1_jeep_irons_door_close,"training_s1_vehicle_tour_end");
	maps\_anim::addnotetrack_customfunction("jeep","rec_training1_jeep_player_door_close",::rec_training1_jeep_player_door_close,"training_s1_vehicle_tour_end_enter");
	maps\_anim::addnotetrack_customfunction("irons","rec_tour_ride_irons_turns_to_plr",::rec_tour_ride_irons_turns_to_plr,"rec_tour_ride_c_pt1");
	maps\_anim::addnotetrack_customfunction("irons","rec_tour_ride_irons_gestures",::rec_tour_ride_irons_gestures,"rec_tour_ride_c_pt1");
	maps\_anim::addnotetrack_customfunction("irons","rec_tour_ride_irons_waves",::rec_tour_ride_irons_waves,"rec_tour_ride_c_pt1");
	maps\_anim::addnotetrack_customfunction("player_rig","rec_tour_ride_plr_door",::rec_tour_ride_plr_door,"rec_tour_ride_c_pt1");
	maps\_anim::addnotetrack_customfunction("player_rig","rec_tour_ride_plr_exits_jeep",::rec_tour_ride_plr_exits_jeep,"rec_tour_ride_c_pt1");
	maps\_anim::addnotetrack_customfunction("gideon","rec_tour_ride_gid_hand_on_door",::rec_tour_ride_gid_hand_on_door,"rec_tour_ride_c_pt1");
	maps\_anim::addnotetrack_customfunction("gideon","rec_tour_ride_gid_exits_jeep",::rec_tour_ride_gid_exits_jeep,"rec_tour_ride_c_pt1");
	maps\_anim::addnotetrack_customfunction("driver","rec_tour_ride_driver_gear_shift",::rec_tour_ride_driver_gear_shift,"rec_tour_ride_c_pt1");
	maps\_anim::addnotetrack_customfunction("jeep","rec_tour_ride_veh_rightdoor_open",::rec_tour_ride_veh_rightdoor_open,"rec_tour_ride_c_pt1_jeep");
	maps\_anim::addnotetrack_customfunction("jeep","rec_tour_ride_veh_leftdoor_open",::rec_tour_ride_veh_leftdoor_open,"rec_tour_ride_c_pt1_jeep");
	maps\_anim::addnotetrack_customfunction("jeep","rec_tour_ride_veh_rightdoor_close",::rec_tour_ride_veh_rightdoor_close,"rec_tour_ride_c_pt1_jeep");
	maps\_anim::addnotetrack_customfunction("jeep","rec_tour_ride_veh_leftdoor_close",::rec_tour_ride_veh_leftdoor_close,"rec_tour_ride_c_pt1_jeep");
	maps\_anim::addnotetrack_customfunction("pusher_1","audio_push_1_box_pickup",::audio_push_1_box_pickup,"rec_atlas_push_idle");
	maps\_anim::addnotetrack_customfunction("pusher_1","audio_push_1_box_drop",::audio_push_1_box_drop,"rec_atlas_push_idle");
	maps\_anim::addnotetrack_customfunction("pusher_1","audio_push_1_box_push",::audio_push_1_box_push,"rec_atlas_push_idle");
	maps\_anim::addnotetrack_customfunction("pusher_1","audio_push_1_crane_move_1",::audio_push_1_crane_move_1,"rec_atlas_push_idle");
	maps\_anim::addnotetrack_customfunction("pusher_1","audio_push_1_crane_move_2",::audio_push_1_crane_move_2,"rec_atlas_push_idle");
	maps\_anim::addnotetrack_customfunction("pusher_1","audio_push_1_crane_move_3",::audio_push_1_crane_move_3,"rec_atlas_push_idle");
	maps\_anim::addnotetrack_customfunction("pusher_2","audio_push_2_box_pickup",::audio_push_2_box_pickup,"rec_atlas_push_idle");
	maps\_anim::addnotetrack_customfunction("pusher_2","audio_push_2_box_drop",::audio_push_2_box_drop,"rec_atlas_push_idle");
	maps\_anim::addnotetrack_customfunction("pusher_2","audio_push_2_box_push",::audio_push_2_box_push,"rec_atlas_push_idle");
	maps\_anim::addnotetrack_customfunction("pusher_2","audio_push_2_crane_move_1",::audio_push_2_crane_move_1,"rec_atlas_push_idle");
	maps\_anim::addnotetrack_customfunction("pusher_2","audio_push_2_crane_move_2",::audio_push_2_crane_move_2,"rec_atlas_push_idle");
	maps\_anim::addnotetrack_customfunction("pusher_2","audio_push_2_crane_move_3",::audio_push_2_crane_move_3,"rec_atlas_push_idle");
	maps\_anim::addnotetrack_customfunction("climber_1","exo_climb_start",::exo_climb_start,"rec_atlas_climb_guy02");
	maps\_anim::addnotetrack_customfunction("player_rig_repair","exo_repair_vm_sit",::exo_repair_vm_sit,"rec_exo_arm_repair_vm");
	maps\_anim::addnotetrack_customfunction("player_rig_repair","exo_repair_vm_place_arm",::exo_repair_vm_place_arm,"rec_exo_arm_repair_vm");
	maps\_anim::addnotetrack_customfunction("animated_desk","exo_repair_desk_unfold",::exo_repair_desk_unfold,"rec_exo_arm_repair_chair_unfold_desk");
	maps\_anim::addnotetrack_customfunction("animated_desk","repair_desk_harness_close",::repair_desk_harness_close,"rec_exo_arm_repair_desk");
	maps\_anim::addnotetrack_customfunction("animated_desk","repair_desk_grab_needle",::repair_desk_grab_needle,"rec_exo_arm_repair_desk");
	maps\_anim::addnotetrack_customfunction("animated_desk","repair_desk_align_needle",::repair_desk_align_needle,"rec_exo_arm_repair_desk");
	maps\_anim::addnotetrack_customfunction("animated_desk","repair_desk_push_needle",::repair_desk_push_needle,"rec_exo_arm_repair_desk");
	maps\_anim::addnotetrack_customfunction("animated_desk","repair_desk_remove_needle",::repair_desk_remove_needle,"rec_exo_arm_repair_exit_desk");
	maps\_anim::addnotetrack_customfunction("animated_desk","repair_desk_harness_release",::repair_desk_harness_release,"rec_exo_arm_repair_exit_desk");
	maps\_anim::addnotetrack_customfunction("player_rig_repair","exo_repair_vm_lift_arm",::exo_repair_vm_lift_arm,"rec_exo_arm_repair_attempt_exit_vm");
	maps\_anim::addnotetrack_customfunction("player_rig_repair","exo_repair_vm_test_hand",::exo_repair_vm_test_hand,"rec_exo_arm_repair_attempt_exit_vm");
	maps\_anim::addnotetrack_customfunction("wrestler_1","audio_start_wrestling_exo_guy",::audio_start_wrestling_exo_guy,"rec_atlas_wrestling_idle");
	maps\_anim::addnotetrack_customfunction("wrestler_2","audio_start_wrestling_guy2",::audio_start_wrestling_guy2,"rec_atlas_wrestling_idle");
	maps\_anim::addnotetrack_customfunction("wrestler_3","audio_start_wrestling_guy3",::audio_start_wrestling_guy3,"rec_atlas_wrestling_idle");
	maps\_anim::addnotetrack_customfunction("wrestler_4","audio_start_wrestling_guy4",::audio_start_wrestling_guy4,"rec_atlas_wrestling_idle");
	maps\_anim::addnotetrack_customfunction("wrestler_5","audio_start_wrestling_guy5",::audio_start_wrestling_guy5,"rec_atlas_wrestling_idle");
	maps\_anim::addnotetrack_customfunction("gideon","rec_readyroom_gideon_pushes_button",::rec_readyroom_gideon_pushes_button,"rec_readyroom_seq");
	maps\_anim::addnotetrack_customfunction("ready_room_elevator_right","rec_readyroom_elevator_right_open",::rec_readyroom_elevator_right_open,"rec_readyroom_seq");
	maps\_anim::addnotetrack_customfunction("ready_room_elevator_right","rec_readyroom_elevator_right_close",::rec_readyroom_elevator_right_close,"rec_readyroom_up_elevator_right");
	maps\_anim::addnotetrack_customfunction("ready_room_elevator_right","rec_readyroom_elevator_right_up",::rec_readyroom_elevator_right_up,"rec_readyroom_up_elevator_right");
	maps\_anim::addnotetrack_customfunction("ready_room_elevator_right","rec_readyroom_elevator_right_open2",::rec_readyroom_elevator_right_open2,"rec_readyroom_up_elevator_right");
	maps\_anim::addnotetrack_customfunction("ready_room_elevator_left","rec_readyroom_elevator_left_open",::rec_readyroom_elevator_left_open,"rec_readyroom_elevator_left_open");
	maps\_anim::addnotetrack_customfunction("ready_room_elevator_left","rec_readyroom_elevator_left_close",::rec_readyroom_elevator_left_close,"rec_readyroom_seq");
	maps\_anim::addnotetrack_customfunction("ready_room_elevator_left","rec_readyroom_elevator_left_up",::rec_readyroom_elevator_left_up,"rec_readyroom_seq");
	maps\_anim::addnotetrack_customfunction("ready_room_elevator_left","rec_readyroom_elevator_left_open2",::rec_readyroom_elevator_left_open2,"rec_readyroom_seq");
	maps\_anim::addnotetrack_customfunction("player_rig","rec_player_exo_breach_start",::rec_player_exo_breach_start,"training_s2_breach");
	maps\_anim::addnotetrack_customfunction("player_rig","rec_s2_exfil_car_plr_start",::rec_s2_exfil_car_plr_start,"training_s2_player_end");
	maps\_anim::addnotetrack_customfunction("player_rig","rec_s2_exfil_car_plr_help_potus",::rec_s2_exfil_car_plr_help_potus,"training_s2_player_end");
	maps\_anim::addnotetrack_customfunction("player_rig","rec_s2_exfil_car_plr_hand",::rec_s2_exfil_car_plr_hand,"training_s2_player_end");
	maps\_anim::addnotetrack_customfunction("president","rec_s2_exfil_potus_start",::rec_s2_exfil_potus_start,"training_s2_president_end");
	maps\_anim::addnotetrack_customfunction("president","rec_s2_exfil_potus_enter_car",::rec_s2_exfil_potus_enter_car,"training_s2_president_end");
	maps\_anim::addnotetrack_customfunction("irons","training_2_irons_ending",::training_2_irons_ending,"training_s2_irons_helicopter");
	maps\_anim::addnotetrack_customfunction("warbird","rec_t2_warbird_start",::rec_t2_warbird_start,"warbird_landing");
	maps\_anim::addnotetrack_customfunction("warbird","rec_t2_warbird_decloak",::rec_t2_warbird_decloak,"warbird_landing");
	maps\_anim::addnotetrack_customfunction("warbird","rec_t2_warbird_land",::rec_t2_warbird_land,"warbird_landing");
	maps\_anim::addnotetrack_customfunction("warbird","rec_t2_warbird_door_open",::rec_t2_warbird_door_open,"warbird_takeoff");
	maps\_anim::addnotetrack_customfunction("joker","rec_guy_doubledoor_breach_start",::rec_guy_doubledoor_breach_start,"training_s1_patio_joker_door_out");
	maps\_anim::addnotetrack_customfunction("gideon","rec_guy_doubledoor_breach_start",::rec_guy_doubledoor_breach_start,"training_s2_patio_gideon_door_out");
}

//Function Number: 4
config_system()
{
	soundscripts\_audio::set_stringtable_mapname("shg");
	soundscripts\_snd_filters::snd_set_occlusion("med_occlusion");
	soundscripts\_audio_mix_manager::mm_add_submix("recovery_global_mix");
}

//Function Number: 5
init_snd_flags()
{
	common_scripts\utility::flag_init("aud_auto_combat_music");
	common_scripts\utility::flag_set("aud_auto_combat_music");
	level.player maps\_utility::ent_flag_init("overdrive_on");
}

//Function Number: 6
init_globals()
{
	level.aud.last_repair_weights = [];
	level.aud.repair_weights = [];
}

//Function Number: 7
launch_threads()
{
	thread rec_funeral_21_gun_salute();
	thread setup_funeral_ambi_fade();
	thread setup_lightning_transition();
	thread register_notetracks();
	thread setup_training_01_end_ambi_swap();
	thread setup_training_01_end_compound_ambi_emitter();
	thread play_vrap_sounds();
	thread rec_tour_hangar_background();
	thread setup_training_02_breach_smartglass();
}

//Function Number: 8
launch_loops()
{
	soundscripts\_snd_playsound::snd_play_loop_at("emt_rec_cpu_rack_lp",(-4464,3413,37));
	soundscripts\_snd_playsound::snd_play_loop_at("emt_rec_cpu_rack_lp",(-4694,4488,37));
	soundscripts\_snd_playsound::snd_play_loop_at("emt_rec_floor_fan_lp",(-4587,2980,69));
	soundscripts\_snd_playsound::snd_play_loop_at("emt_rec_floor_fan_lp",(-4985,2977,69));
	soundscripts\_snd_playsound::snd_play_loop_at("emt_rec_floor_fan_lp",(-4964,3415,69));
	soundscripts\_snd_playsound::snd_play_loop_at("emt_rec_floor_fan_lp",(-4796,3721,33));
	soundscripts\_snd_playsound::snd_play_loop_at("emt_rec_floor_fan_lp",(-4796,3721,33));
	soundscripts\_snd_playsound::snd_play_loop_at("emt_rec_cpu_rack_lp",(-5830,4007,35));
	soundscripts\_snd_playsound::snd_play_loop_at("emt_rec_cpu_hdd_lp",(-5810,3763,35));
	soundscripts\_snd_playsound::snd_play_loop_at("emt_rec_light_buzz_lp",(-5824,4028,152));
	soundscripts\_snd_playsound::snd_play_loop_at("emt_rec_light_buzz_lp",(-5833,3751,152));
	soundscripts\_snd_playsound::snd_play_loop_at("emt_rec_light_buzz_lp",(-6020,3815,157));
	soundscripts\_snd_playsound::snd_play_loop_at("emt_rec_cpu_rack_lp",(-3163,-301,-76));
	soundscripts\_snd_playsound::snd_play_loop_at("emt_rec_cpu_rack_lp",(-2973,-595,-76));
	soundscripts\_snd_playsound::snd_play_delayed_loop_at("emt_rec_cpu_rack_lp",2,undefined,(-3163,-301,-76));
	soundscripts\_snd_playsound::snd_play_delayed_loop_at("emt_rec_cpu_rack_lp",4,undefined,(-3327,-411,-96));
	soundscripts\_snd_playsound::snd_play_loop_at("emt_rec_cpu_hdd_lp",(-3163,-301,-76));
	soundscripts\_snd_playsound::snd_play_delayed_loop_at("emt_rec_cpu_hdd_lp",4,undefined,(-3327,-411,-96));
	soundscripts\_snd_playsound::snd_play_delayed_loop_at("emt_rec_cpu_hdd_lp",7,undefined,(-3327,-501,-96));
}

//Function Number: 9
create_level_envelop_arrays()
{
	level.aud.envs = [];
	level.aud.envs["example_envelop"] = [[0,0],[0.082,0.426],[0.238,0.736],[0.408,0.844],[0.756,0.953],[1,1]];
	level.aud.envs["player_drone_pitch"] = [[0,0.75],[15,0.9],[30,1.1]];
	level.aud.envs["player_drone_volume"] = [[0,0.5],[15,0.9],[30,1]];
}

//Function Number: 10
precache_presets()
{
}

//Function Number: 11
zone_handler(param_00,param_01)
{
	var_02 = "";
	var_03 = "";
	if(getsubstr(param_00,0,6) == "enter_")
	{
		var_02 = param_01;
	}
	else if(getsubstr(param_00,0,5) == "exit_")
	{
		var_03 = param_01;
	}

	if(var_03 == "ext_atlas_base" || var_03 == "ext_lodge")
	{
		soundsettraceflags("weapons");
		soundsettraceflags("tactical");
		soundsettraceflags("vehicles");
		soundsettraceflags("foley");
	}

	if(var_03 == "int_training_facility_lobby" || var_03 == "int_training_facility" || var_03 == "int_training_facility_02" || var_03 == "int_operating_room" || var_03 == "int_firing_range_stairway" || var_03 == "int_firing_range" || var_03 == "int_weapons_room" || var_03 == "int_lodge")
	{
		soundsettraceflags("weapons","locational","solid","glass","translucent","clipshot","playerclip","structural");
		soundsettraceflags("tactical","locational","solid","glass","translucent","clipshot","playerclip","structural");
		soundsettraceflags("vehicles","locational","solid","glass","translucent","clipshot","playerclip","structural");
		soundsettraceflags("foley","locational","solid","glass","translucent","clipshot","playerclip","structural");
	}
}

//Function Number: 12
music(param_00,param_01)
{
	thread music_handler(param_00,param_01);
}

//Function Number: 13
music_handler(param_00,param_01)
{
	level notify("stop_current_music_thread");
	level endon("stop_current_music_thread");
	var_02 = 0.4;
	var_03 = 0.3;
	var_04 = 0;
	var_05 = 0;
	var_06 = 0;
	switch(param_00)
	{
		case "rec_funeral_eulogy_ends_irons":
			soundscripts\_audio::aud_set_music_submix(1,0);
			wait(14);
			soundscripts\_audio_music::mus_play("rec_mus_funeral",4);
			break;

		case "start_intro_stealth":
			soundscripts\_audio::aud_set_music_submix(var_02,0);
			wait(1);
			soundscripts\_audio_music::mus_play("rec_mus_intro_stealth",10);
			for(;;)
			{
				var_06 = common_scripts\utility::flag("aud_auto_combat_music");
				if(soundscripts\_snd_common::snd_get_num_enemies_aware() > 0)
				{
					if(!var_05 && var_06)
					{
						soundscripts\_audio::aud_set_music_submix(var_03,10);
						soundscripts\_audio_music::mus_play("rec_mus_intro_combat_lp",3);
						var_04 = 0;
						var_05 = 1;
					}
					else
					{
						soundscripts\_audio::aud_set_music_submix(0,4);
						var_04 = 0;
						var_05 = 0;
					}
				}
				else if(!var_04)
				{
					soundscripts\_audio::aud_set_music_submix(var_02,10);
					soundscripts\_audio_music::mus_play("rec_mus_intro_stealth",3);
					var_04 = 1;
					var_05 = 0;
				}
	
				wait(1);
			}
			break;

		case "intro_approaching_north_access_road":
			soundscripts\_snd_common::snd_wait_for_enemies_see_player();
			wait(1);
			soundscripts\_audio::aud_set_music_submix(var_03,8);
			soundscripts\_audio_music::mus_play("rec_mus_intro_combat_lp",5);
			break;

		case "rec_sim_reveal_gideon":
			soundscripts\_audio::aud_set_music_submix(0.75,4);
			wait(4.5);
			soundscripts\_audio_music::mus_play("rec_mus_intro_combat_end",1,2);
			level waittill("rec_gdn_noexcuseforequipmentfailure_done");
			soundscripts\_audio_music::mus_play("rec_mus_sim1_end");
			break;

		case "rec_mus_tour_ride_end":
			var_07 = param_01;
			soundscripts\_audio_mix_manager::mm_add_submix("rec_base_entrance_vo",var_07);
			soundscripts\_audio::aud_set_music_submix(0.45,param_01);
			wait(param_01);
			soundscripts\_audio_music::mus_play("rec_mus_tour_ride_end",2);
			level waittill("sound_done_rec_irs_nowgogetthatarm");
			soundscripts\_audio_mix_manager::mm_clear_submix("rec_base_entrance_vo",3);
			break;

		case "firing_range_activating":
			soundscripts\_audio::aud_set_music_submix(0.6,1);
			soundscripts\_audio_music::mus_play("rec_firing_range_lp",2);
			break;

		case "firing_range_deactivating":
			soundscripts\_audio::aud_set_music_submix(0.6,1);
			soundscripts\_audio_music::mus_play("rec_firing_range_end",2);
			break;

		case "grenade_range_begin_phase1":
			soundscripts\_audio::aud_set_music_submix(0.8,1);
			soundscripts\_audio_music::mus_play("rec_grnd_trnng_01_lp",2);
			break;

		case "grenade_range_begin_phase2":
			soundscripts\_audio::aud_set_music_submix(0.75,1);
			soundscripts\_audio_music::mus_play("rec_grnd_trnng_02_lp",2);
			break;

		case "grenade_range_end_phase2":
			soundscripts\_audio::aud_set_music_submix(0.75,1);
			soundscripts\_audio_music::mus_play("rec_grnd_trnng_02_end",2);
			break;

		case "sim2_complete":
			soundscripts\_audio::aud_set_music_submix(0.75,1);
			soundscripts\_audio_music::mus_play("rec_grnd_trnng_02_lp",6);
			break;

		case "final_combat":
			soundscripts\_audio::aud_set_music_submix(0.75,1);
			soundscripts\_audio_music::mus_play("rec_grnd_trnng_02_end",2);
			break;

		case "rec_level_ending":
			soundscripts\_audio::aud_set_music_submix(0.4,0);
			wait(0.05);
			soundscripts\_audio_music::mus_play("rec_mus_level_ending",2);
			break;

		default:
			soundscripts\_audio::aud_print_warning("\tMUSIC MESSAGE NOT HANDLED: " + param_00);
			break;
	}
}

//Function Number: 14
start_funeral()
{
	soundscripts\_audio_zone_manager::azm_start_zone("ext_funeral");
	thread funeral_submix_handler();
	soundscripts\_snd_playsound::snd_play_loop_at("walla_funeral",(6504,-43267,132),"stop_walla_funeral",6,4);
}

//Function Number: 15
start_training_01()
{
	soundscripts\_audio_zone_manager::azm_start_zone("ext_lodge");
}

//Function Number: 16
start_training_01_lodge()
{
	soundscripts\_audio_zone_manager::azm_start_zone("int_lodge");
	music("start_intro_stealth");
}

//Function Number: 17
start_training_01_lodge_breach()
{
	soundscripts\_audio_zone_manager::azm_start_zone("int_lodge");
	music("start_intro_stealth");
}

//Function Number: 18
start_training_01_lodge_exit()
{
	soundscripts\_audio_zone_manager::azm_start_zone("int_lodge");
	music("start_intro_stealth");
}

//Function Number: 19
start_training_01_golf_course()
{
	soundscripts\_audio_zone_manager::azm_start_zone("ext_lodge");
	music("start_intro_stealth");
}

//Function Number: 20
start_training_01_end()
{
	soundscripts\_audio_zone_manager::azm_start_zone("ext_exfil");
}

//Function Number: 21
start_tour_ride()
{
	soundscripts\_audio_zone_manager::azm_start_zone("ext_exfil");
}

//Function Number: 22
start_tour_exo()
{
	soundscripts\_audio_zone_manager::azm_start_zone("ext_atlas_base");
}

//Function Number: 23
start_tour_exo_exit()
{
	soundscripts\_audio_zone_manager::azm_start_zone("int_training_facility");
}

//Function Number: 24
start_tour_firing_range()
{
	soundscripts\_audio_zone_manager::azm_start_zone("ext_atlas_base");
}

//Function Number: 25
start_tour_augmented_reality()
{
	soundscripts\_audio_zone_manager::azm_start_zone("ext_atlas_base");
}

//Function Number: 26
start_tour_end()
{
	soundscripts\_audio_zone_manager::azm_start_zone("ext_atlas_base");
}

//Function Number: 27
start_training_02()
{
	soundscripts\_audio_zone_manager::azm_start_zone("ext_lodge");
}

//Function Number: 28
start_training_02_lodge()
{
	soundscripts\_audio_zone_manager::azm_start_zone("int_lodge");
}

//Function Number: 29
start_training_02_lodge_breach()
{
	soundscripts\_audio_zone_manager::azm_start_zone("int_lodge");
}

//Function Number: 30
start_training_02_lodge_exit()
{
	soundscripts\_audio_zone_manager::azm_start_zone("int_lodge");
}

//Function Number: 31
start_training_02_golf_course()
{
	soundscripts\_audio_zone_manager::azm_start_zone("ext_lodge");
	music("sim2_complete");
}

//Function Number: 32
start_training_02_end()
{
	soundscripts\_audio_zone_manager::azm_start_zone("ext_exfil");
	music("sim2_complete");
}

//Function Number: 33
funeral_submix_handler()
{
	wait 0.05;
	soundscripts\_audio_mix_manager::mm_add_submix("rec_funeral");
	level waittill("funeral_done");
	soundscripts\_audio_mix_manager::mm_clear_submix("rec_funeral");
}

//Function Number: 34
eulogy_irons_stand(param_00)
{
	soundscripts\_snd::snd_slate("eulogy_irons_stand");
	param_00 soundscripts\_snd_playsound::snd_play_delayed_linked("rec_eulogy_irons_stand",0);
}

//Function Number: 35
eulogy_irons_touch(param_00)
{
	soundscripts\_snd::snd_slate("eulogy_irons_touch");
	param_00 soundscripts\_snd_playsound::snd_play_delayed_linked("rec_eulogy_irons_touch",0);
}

//Function Number: 36
eulogy_irons_leave(param_00)
{
	soundscripts\_snd::snd_slate("eulogy_irons_leave");
	param_00 soundscripts\_snd_playsound::snd_play_delayed_linked("rec_eulogy_irons_leave",0);
}

//Function Number: 37
eulogy_cormack_approach(param_00)
{
	soundscripts\_snd::snd_slate("eulogy_cormack_approach");
	param_00 soundscripts\_snd_playsound::snd_play_delayed_linked("rec_eulogy_cormack_approach",0);
}

//Function Number: 38
eulogy_cormack_touch(param_00)
{
	soundscripts\_snd::snd_slate("eulogy_cormack_touch");
	param_00 soundscripts\_snd_playsound::snd_play_delayed_linked("rec_eulogy_cormack_touch",0);
}

//Function Number: 39
eulogy_cormack_leave(param_00)
{
	soundscripts\_snd::snd_slate("eulogy_cormack_leave");
	param_00 soundscripts\_snd_playsound::snd_play_delayed_linked("rec_eulogy_cormack_leave",0);
}

//Function Number: 40
eulogy_player_touch(param_00)
{
	soundscripts\_snd::snd_slate("eulogy_player_touch");
	soundscripts\_snd_playsound::snd_play_delayed_2d("rec_eulogy_player_touch",0.4);
	soundscripts\_snd_playsound::snd_play_delayed_2d("rec_eulogy_player_release",0.07);
}

//Function Number: 41
atlascard_cormack_walk(param_00)
{
	soundscripts\_snd::snd_slate("atlascard_cormack_walk");
	param_00 soundscripts\_snd_playsound::snd_play_delayed_linked("rec_atlascard_cormack_walk",0);
}

//Function Number: 42
atlascard_irons_turn(param_00)
{
	soundscripts\_snd::snd_slate("atlascard_irons_turn");
}

//Function Number: 43
atlascard_irons_walk(param_00)
{
	soundscripts\_snd::snd_slate("atlascard_irons_walk");
	param_00 soundscripts\_snd_playsound::snd_play_delayed_linked("rec_atlascard_irons_walk",0);
}

//Function Number: 44
atlascard_irons_handshake(param_00)
{
	soundscripts\_snd::snd_slate("atlascard_irons_handshake");
	param_00 soundscripts\_snd_playsound::snd_play_delayed_linked("rec_atlascard_irons_handshake",0);
}

//Function Number: 45
atlascard_irons_place_hand(param_00)
{
	soundscripts\_snd::snd_slate("atlascard_irons_place_hand");
	param_00 soundscripts\_snd_playsound::snd_play_delayed_linked("rec_atlascard_irons_place_hand",0);
	param_00 soundscripts\_snd_playsound::snd_play_delayed_linked("rec_atlascard_irons_place_hand_fs",0.3);
}

//Function Number: 46
atlascard_irons_tap(param_00)
{
	soundscripts\_snd::snd_slate("atlascard_irons_tap");
	level notify("aud_start_21_gun_salute");
	param_00 soundscripts\_snd_playsound::snd_play_delayed_linked("rec_atlascard_irons_tap",0);
}

//Function Number: 47
atlascard_irons_grab_card(param_00)
{
	soundscripts\_snd::snd_slate("atlascard_irons_grab_card");
	param_00 soundscripts\_snd_playsound::snd_play_delayed_linked("rec_atlascard_irons_grabs_card",0);
}

//Function Number: 48
atlascard_irons_leave(param_00)
{
	soundscripts\_snd::snd_slate("atlascard_irons_leave");
	param_00 soundscripts\_snd_playsound::snd_play_delayed_linked("rec_atlascard_irons_leave",0);
}

//Function Number: 49
rec_funeral_21_gun_salute()
{
	level waittill("aud_start_21_gun_salute");
	soundscripts\_audio_mix_manager::mm_add_submix("rec_funeral_salute");
	maps\_utility::delaythread(10,::maps\recovery_utility::play_rumble_funeral_gun_salute);
	soundscripts\_snd::snd_slate("21_gun_salute");
	soundscripts\_snd_playsound::snd_play_delayed_2d("rec_funeral_salute_vo_01",7);
	soundscripts\_snd_playsound::snd_play_delayed_2d("rec_funeral_salute_foley_02",9);
	soundscripts\_snd_playsound::snd_play_delayed_2d("rec_funeral_salute_vo_02",10);
	soundscripts\_snd_playsound::snd_play_delayed_2d("rec_funeral_salute_shot_02",10);
	soundscripts\_snd_playsound::snd_play_delayed_2d("rec_funeral_salute_vo_03",14);
	soundscripts\_snd_playsound::snd_play_delayed_2d("rec_funeral_salute_foley_03",16);
	soundscripts\_snd_playsound::snd_play_delayed_2d("rec_funeral_salute_shot_03",14);
	soundscripts\_snd_playsound::snd_play_delayed_2d("rec_funeral_salute_thunder",18);
	level notify("stop_walla_funeral");
	soundscripts\_audio_mix_manager::mm_clear_submix("rec_funeral_salute");
	soundscripts\_audio_mix_manager::mm_clear_submix("rec_funeral_ambi_fade",10);
}

//Function Number: 50
campdavid_player_arm_reveal(param_00)
{
	soundscripts\_snd::snd_printlnbold("SLATE: campdavid_player_arm_reveal");
	soundscripts\_snd_playsound::snd_play_delayed_2d("arm_reveal_exo",0.2);
	soundscripts\_snd_playsound::snd_play_delayed_2d("arm_reveal_gun",2.35);
}

//Function Number: 51
rec_threat01_joker_start(param_00)
{
	param_00 soundscripts\_snd_playsound::snd_play_delayed_linked("rec_threat_joker_steps",0);
	param_00 soundscripts\_snd_playsound::snd_play_delayed_linked("rec_threat_joker_gear",0);
	param_00 soundscripts\_snd_playsound::snd_play_delayed_linked("rec_threat_joker_door",0);
}

//Function Number: 52
rec_threat01_joker_kick(param_00)
{
	param_00 soundscripts\_snd_playsound::snd_play_delayed_linked("rec_threat_kick_joker_steps",0);
	param_00 soundscripts\_snd_playsound::snd_play_delayed_linked("rec_threat_kick_joker_gear",0);
	soundscripts\_audio_mix_manager::mm_add_submix("rec_threat_breach_foley");
	param_00 soundscripts\_snd_playsound::snd_play_delayed_linked("rec_threat_kick_joker_windup",0);
	param_00 soundscripts\_snd_playsound::snd_play_delayed_linked("rec_threat_kick_joker_door",0.1);
	param_00 soundscripts\_snd_playsound::snd_play_delayed_linked("rec_threat_kick_joker_door_otherside",0.1);
	wait(5);
	soundscripts\_audio_mix_manager::mm_clear_submix("rec_threat_breach_foley");
}

//Function Number: 53
rec_mute01_joker_start(param_00)
{
	param_00 soundscripts\_snd_playsound::snd_play_linked("rec_mute_01_joker_start");
}

//Function Number: 54
rec_mute01_joker_breach(param_00)
{
	soundscripts\_snd_playsound::snd_play_2d("rec_mute_01_joker_breach");
	soundscripts\_audio_mix_manager::mm_add_submix("mute_charge_loop_management",0.5);
}

//Function Number: 55
camp_david_training_mute_device(param_00,param_01)
{
	var_02 = self;
	soundscripts\_audio_mix_manager::mm_add_submix("rec_s1_mute_breach");
	soundscripts\_snd_timescale::snd_set_timescale("all_off");
	level.player enablecustomweaponcontext();
	soundscripts\_snd_common::snd_enable_soundcontextoverride("mute");
	soundscripts\_snd_playsound::snd_play_delayed_2d("mute_device_activate",0.5);
	wait(1.25);
	var_02 thread soundscripts\_snd_common::snd_mute_device("mute_device",param_00,param_00 + 250,param_01,"mute_device");
	var_02 thread aud_stop_training_mute_device();
}

//Function Number: 56
aud_stop_training_mute_device()
{
	level waittill("training_s1_breach_enemy_dead");
	soundscripts\_snd_common::snd_disable_soundcontextoverride("mute");
	level.player disablecustomweaponcontext();
	self notify("turn_off");
	soundscripts\_audio_mix_manager::mm_clear_submix("rec_s1_mute_breach");
}

//Function Number: 57
rec_mute01_joker_run(param_00)
{
}

//Function Number: 58
rec_mute01_joker_kick(param_00)
{
	soundscripts\_snd_playsound::snd_play_2d("rec_mute_01_joker_kick");
}

//Function Number: 59
rec_mute_breach_slo_mo1(param_00)
{
	soundscripts\_snd_playsound::snd_play_2d("rec_mute_slo_mo","kill_slo_mo",undefined,0.5);
	wait(param_00);
	level notify("kill_wall_hit_sound");
	soundscripts\_snd_timescale::snd_set_timescale("all_on");
}

//Function Number: 60
rec_chair_kva_gets_shot(param_00)
{
	soundscripts\_snd_playsound::snd_play_at("bullet_flesh_slo_mo",param_00);
}

//Function Number: 61
rec_kva_with_president_gets_shot(param_00)
{
	soundscripts\_snd_playsound::snd_play_at("bullet_flesh_slo_mo",param_00);
}

//Function Number: 62
rec_mute01_joker_turn(param_00)
{
}

//Function Number: 63
rec_mute01_kva_with_gun_killed(param_00)
{
}

//Function Number: 64
rec_mute01_kva_kicked(param_00)
{
	wait(1.25);
	level notify("kill_slo_mo");
}

//Function Number: 65
rec_mute01_kva_hits_wall(param_00)
{
	param_00 soundscripts\_snd_playsound::snd_play_linked("rec_mute_01_kva_hits_wall","kill_wall_hit_sound");
	soundscripts\_snd_playsound::snd_play_loop_at("emt_rec_cabin_sglass_brkn_lp",(-2908,-5304,376),"stop_electronic_emitters_sim_01",1,1);
	soundscripts\_audio_mix_manager::mm_clear_submix("mute_charge_loop_management");
}

//Function Number: 66
rec_mute01_chair_kva_killed(param_00)
{
}

//Function Number: 67
rec_mute01_potus_free(param_00)
{
	soundscripts\_audio_mix_manager::mm_add_submix("rec_joker_potus_rescue");
	param_00 soundscripts\_snd_playsound::snd_play_delayed_linked("rec_joker_training_01_potus_rescue",1.25);
	wait(8);
	soundscripts\_audio_mix_manager::mm_clear_submix("rec_joker_potus_rescue");
}

//Function Number: 68
rec_s1_president_killed()
{
	if(isdefined(level.president))
	{
		level.president soundscripts\_snd_playsound::snd_play_linked("bullet_flesh_slo_mo");
	}
}

//Function Number: 69
rec_bathroom_guy(param_00)
{
	param_00 soundscripts\_snd_playsound::snd_play_linked("rec_mute_01_bathroom_guy");
}

//Function Number: 70
rec_plr_kills_president(param_00)
{
	soundscripts\_snd_playsound::snd_play_at("bullet_flesh_slo_mo",param_00);
}

//Function Number: 71
rec_training01_lodge_stealth_exit_start(param_00)
{
	param_00 soundscripts\_snd_playsound::snd_play_delayed_linked("rec_stealth_exit_joker_steps",8.6);
	param_00 soundscripts\_snd_playsound::snd_play_delayed_linked("rec_stealth_exit_joker_gear",8.3);
	param_00 soundscripts\_snd_playsound::snd_play_delayed_linked("rec_stealth_exit_joker_texture",8.3);
	param_00 soundscripts\_snd_playsound::snd_play_delayed_linked("rec_stealth_exit_joker_door",8.6);
}

//Function Number: 72
rec_training01_lodge_stealth_open(param_00)
{
}

//Function Number: 73
rec_training01_lodge_stealth_exit_end(param_00)
{
}

//Function Number: 74
rec_s1_drones_fly_by(param_00)
{
	soundscripts\_snd::snd_printlnbold("Drone Flyby 1 Start");
	var_01 = param_00[0];
	soundscripts\_audio_mix_manager::mm_add_submix("training_1_drone_patrol");
	var_02 = "kill_fly_by_on_attack" + soundscripts\_snd::snd_new_guid();
	var_01 soundscripts\_snd_playsound::snd_play_linked("rec_s1_drone_patrol_flyby",var_02);
	thread rec_s1_drones_wait_for_attack(var_02);
	wait(25);
	soundscripts\_audio_mix_manager::mm_clear_submix("training_1_drone_patrol");
	level notify("s1_drones_complete");
}

//Function Number: 75
rec_s1_drones_wait_for_attack(param_00)
{
	level endon("s1_drones_complete");
	level waittill("s1_drones_attacking");
	level notify(param_00);
}

//Function Number: 76
rec_s1_drones_attack(param_00)
{
	soundscripts\_snd::snd_printlnbold("Drone Flyby 1 Turn");
	var_01 = param_00[0];
	if(!isalive(var_01))
	{
		if(isalive(param_00[1]))
		{
			var_01 = param_00[1];
		}
		else if(isalive(param_00[2]))
		{
			var_01 = param_00[2];
		}
		else
		{
			return;
		}
	}

	var_01 soundscripts\_snd_playsound::snd_play_linked("rec_s1_drone_alert");
	wait(3);
	soundscripts\_audio_mix_manager::mm_clear_submix("training_1_drone_patrol");
	soundscripts\_audio_mix_manager::mm_add_submix("training_1_drone_patrol_attack");
	level notify("s1_drones_attacking");
	if(!isalive(var_01))
	{
		if(isalive(param_00[1]))
		{
			var_01 = param_00[1];
		}
		else if(isalive(param_00[2]))
		{
			var_01 = param_00[2];
		}
		else
		{
			return;
		}
	}

	var_01 soundscripts\_snd_playsound::snd_play_linked("rec_s1_drone_attack");
	foreach(var_03 in param_00)
	{
		if(isdefined(var_03) && !isremovedentity(var_03))
		{
			var_03 waittill("death");
		}
	}

	soundscripts\_audio_mix_manager::mm_clear_submix("training_1_drone_patrol_attack");
}

//Function Number: 77
rec_drone_scanner()
{
	soundscripts\_snd::snd_printlnbold("Drone Flyby 1 Scan");
	wait(1.6);
	soundscripts\_snd_playsound::snd_play_linked("rec_s1_drone_patrol_scan");
}

//Function Number: 78
patio_flashbang(param_00,param_01)
{
	wait(param_00);
	soundscripts\_snd_playsound::snd_play_at("rec_s1_flash_bang",param_01);
}

//Function Number: 79
rec_train1_stealth_car_spawn(param_00)
{
	param_00 soundscripts\_snd_playsound::snd_play_linked("rec_train_1_stealth_car_engine","stealth_car_alerted");
	param_00 soundscripts\_snd_playsound::snd_play_linked("rec_train_1_stealth_car_sfx","stealth_car_alerted");
}

//Function Number: 80
rec_train1_stealth_car_stop(param_00)
{
	level notify("stealth_car_alerted");
	param_00 soundscripts\_snd_playsound::snd_play_linked("rec_train_1_stealth_car_stop_engine");
	param_00 soundscripts\_snd_playsound::snd_play_linked("rec_train_1_stealth_car_stop_sfx");
	param_00 soundscripts\_snd_playsound::snd_play_linked("rec_train_1_stealth_car_stop_lfe");
}

//Function Number: 81
s1_popping_smoke(param_00)
{
	soundscripts\_snd_playsound::snd_play_at("wpn_smoke_grenade_exp",param_00);
}

//Function Number: 82
rec_train1_exfil_car_start(param_00)
{
	soundscripts\_audio_mix_manager::mm_add_submix("1st_time_exfil_truck");
	param_00 soundscripts\_snd_playsound::snd_play_linked("rec_train_1_exfil_car_enter_engine");
	param_00 soundscripts\_snd_playsound::snd_play_delayed_loop_linked("rec_train_1_exfil_car_idle_loop",5.372,0,"exfil_loop_stop");
}

//Function Number: 83
training_01_end_player_arm_malfunction(param_00)
{
	soundscripts\_snd::snd_printlnbold("SLATE: car door arm malfunctions");
	soundscripts\_audio_mix_manager::mm_clear_submix("1st_time_exfil_truck");
	soundscripts\_audio_mix_manager::mm_add_submix("training_1_end_scene",2);
	soundscripts\_snd_playsound::snd_play_delayed_2d("rec_train_1_end_plr_try_handle",0.1);
	soundscripts\_snd_playsound::snd_play_delayed_2d("arm_door_malfunction_exo",1.45);
	level notify("stop_electronic_emitters_sim_01");
}

//Function Number: 84
training_01_end_gideon_walk(param_00)
{
	param_00 soundscripts\_snd_playsound::snd_play_linked("rec_train_1_end_gideon_emerge");
	soundscripts\_snd_playsound::snd_play_2d("rec_train_1_end_branch_snap");
}

//Function Number: 85
training_01_end_player_punched(param_00)
{
	soundscripts\_snd_playsound::snd_play_2d("rec_train_1_end_plr_fall");
	level notify("stop_rain_quads");
}

//Function Number: 86
training_01_end_gideon_punch(param_00)
{
	soundscripts\_snd_playsound::snd_play_2d("rec_train_1_end_gideon_punch");
}

//Function Number: 87
training_01_end_potus_threatened(param_00)
{
}

//Function Number: 88
training_01_end_gideon_pulls_gun(param_00)
{
	soundscripts\_snd_playsound::snd_play_2d("rec_train_1_end_gideon_gun_draw");
}

//Function Number: 89
training_01_end_potus_shot(param_00)
{
	param_00 soundscripts\_snd_playsound::snd_play_linked("rec_train_1_end_potus_shot");
}

//Function Number: 90
training_01_end_gideon_shoots_potus(param_00)
{
	soundscripts\_snd_playsound::snd_play_2d("rec_train_1_end_gideon_gun_shot");
}

//Function Number: 91
training_01_end_gideon_to_player(param_00)
{
	soundscripts\_snd_playsound::snd_play_2d("rec_train_1_end_gideon_to_plr");
}

//Function Number: 92
training_01_end_gideon_mask(param_00)
{
}

//Function Number: 93
training_01_end_gideon_gun_away(param_00)
{
	soundscripts\_snd_playsound::snd_play_2d("rec_train_1_end_gideon_gun_away");
}

//Function Number: 94
rec_train1_end()
{
	soundscripts\_snd_playsound::snd_play_delayed_2d("rec_train_1_end_reveal_reset",2.782);
	soundscripts\_snd_playsound::snd_play_delayed_2d("rec_train_1_end_reveal_door",5.464);
	soundscripts\_snd_playsound::snd_play_delayed_2d("rec_train_1_end_reveal_amb1",4.952);
	soundscripts\_snd_playsound::snd_play_delayed_2d("rec_train_1_end_reveal_amb2",35.29);
	if(isdefined(level.escape_vehicle))
	{
		level.escape_vehicle soundscripts\_snd_playsound::snd_play_delayed_linked("rec_train_1_exfil_car_shutoff",5);
	}

	wait(5);
	level notify("exfil_loop_stop");
}

//Function Number: 95
tour_jeep_startup()
{
	soundscripts\_snd::snd_slate("tour_jeep_startup");
	level.cart soundscripts\_snd_playsound::snd_play_linked("rec_tour_jeep_start");
	wait(3.43);
	level.cart soundscripts\_snd_playsound::snd_play_loop_linked("rec_tour_jeep_idle_lp","rec_tour_jeep_idle_stop",undefined,1);
}

//Function Number: 96
training_01_end_potus_gets_up(param_00)
{
	param_00 soundscripts\_snd_playsound::snd_play_delayed_linked("rec_train_1_end_potus_getup",0.5);
	level notify("start_compound_ambi_emitter");
}

//Function Number: 97
training_01_end_player_helped_up(param_00)
{
}

//Function Number: 98
training_01_end_gideon_helps_up_plr(param_00)
{
	soundscripts\_snd::snd_slate("training_01_end_gideon_helps_up_plr");
	soundscripts\_snd_playsound::snd_play_2d("rec_train_1_end_gideon_help_up");
	soundscripts\_snd_playsound::snd_play_delayed_2d("rec_train_1_end_plr_getup",0.75);
}

//Function Number: 99
training_01_end_irons_exit_jeep(param_00)
{
	soundscripts\_snd::snd_slate("training_01_end_irons_exit_jeep");
	param_00 soundscripts\_snd_playsound::snd_play_linked("rec_train_1_end_irons_arrives");
}

//Function Number: 100
training_01_end_player_arm_up(param_00)
{
	soundscripts\_snd::snd_slate("training_01_end_player_arm_up");
	soundscripts\_snd_playsound::snd_play_2d("rec_train_1_end_plr_arm_up");
}

//Function Number: 101
training_01_end_gideon_grabs_arm(param_00)
{
	soundscripts\_snd::snd_slate("training_01_end_gideon_grabs_arm");
	soundscripts\_snd_playsound::snd_play_2d("rec_train_1_end_gideon_arm_grab");
}

//Function Number: 102
training_01_end_gideon_idles(param_00)
{
	soundscripts\_snd::snd_slate("training_01_end_gideon_idles");
}

//Function Number: 103
training_01_end_irons_hand_on_shoulder(param_00)
{
	soundscripts\_snd::snd_slate("training_01_end_irons_hand_on_shoulder");
	param_00 soundscripts\_snd_playsound::snd_play_linked("rec_train_1_end_irons_shoulder");
}

//Function Number: 104
training_01_end_gideon_walks_away(param_00)
{
	soundscripts\_snd::snd_slate("training_01_end_gideon_walks_away");
	param_00 soundscripts\_snd_playsound::snd_play_linked("rec_train_1_end_gideon_to_jeep");
}

//Function Number: 105
training_01_end_irons_walk_away(param_00)
{
	soundscripts\_snd::snd_slate("training_01_end_irons_walks_away");
	param_00 soundscripts\_snd_playsound::snd_play_linked("rec_train_1_end_irons_returns");
}

//Function Number: 106
training_01_end_irons_enter_jeep(param_00)
{
	soundscripts\_snd::snd_slate("training_01_end_Irons_enter_jeep");
	param_00 soundscripts\_snd_playsound::snd_play_linked("rec_train_1_end_irons_in_jeep");
}

//Function Number: 107
training_01_end_player_enters_jeep(param_00)
{
	soundscripts\_snd::snd_slate("training_01_end_player_enters_jeep");
	soundscripts\_snd_playsound::snd_play_2d("rec_train_1_end_plr_jeep_enter");
	soundscripts\_audio_mix_manager::mm_add_submix("irons_jeep_tour");
	soundscripts\_audio_mix_manager::mm_clear_submix("rec_training_01_ambis",15);
}

//Function Number: 108
training_01_end_driver_seat_movement(param_00)
{
	soundscripts\_snd::snd_slate("training_01_end_driver_seat_movement");
}

//Function Number: 109
training_01_end_player_moves_to_seat(param_00)
{
	soundscripts\_snd::snd_slate("training_01_end_player_moves_to_seat");
}

//Function Number: 110
training_01_end_player_sits(param_00)
{
	soundscripts\_snd::snd_slate("training_01_end_player_sits");
}

//Function Number: 111
training_01_end_gideon_enter_jeep(param_00)
{
	soundscripts\_snd::snd_slate("training_01_end_gideon_enter_jeep");
	param_00 soundscripts\_snd_playsound::snd_play_linked("rec_train_1_end_gideon_jeep_enter");
}

//Function Number: 112
training_01_end_driver_gear_shift(param_00)
{
	soundscripts\_snd::snd_slate("training_01_end_driver_gear_shift");
	param_00 soundscripts\_snd_playsound::snd_play_linked("rec_train_1_end_driver_gear");
	soundscripts\_audio_mix_manager::mm_clear_submix("training_1_end_scene");
}

//Function Number: 113
rec_training1_jeep_enter(param_00)
{
	soundscripts\_snd::snd_slate("rec_training1_jeep_enter");
	soundscripts\_snd_playsound::snd_play_2d("rec_tour_jeep_enter_sfx");
	soundscripts\_snd_playsound::snd_play_2d("rec_tour_jeep_enter_eng");
}

//Function Number: 114
rec_training1_jeep_arrive(param_00)
{
	soundscripts\_snd::snd_slate("rec_training1_jeep_arrive");
}

//Function Number: 115
rec_training1_jeep_irons_door_open(param_00)
{
	soundscripts\_snd::snd_slate("rec_training1_jeep_irons_door_open");
}

//Function Number: 116
rec_training1_jeep_irons_door_close(param_00)
{
	soundscripts\_snd::snd_slate("rec_training1_jeep_irons_door_close");
}

//Function Number: 117
rec_training1_jeep_player_door_close(param_00)
{
	soundscripts\_snd::snd_slate("rec_training1_jeep_player_door_close");
}

//Function Number: 118
rec_tour_ride_driver_gear_shift(param_00)
{
	soundscripts\_snd::snd_slate("SLATE: rec_tour_ride_driver_gear_shift");
}

//Function Number: 119
rec_tour_ride_veh_rightdoor_open(param_00)
{
	soundscripts\_snd::snd_slate("SLATE: rec_tour_ride_veh_rightdoor_open");
}

//Function Number: 120
rec_tour_ride_veh_leftdoor_open(param_00)
{
	soundscripts\_snd::snd_slate("SLATE: rec_tour_ride_veh_leftdoor_open");
}

//Function Number: 121
rec_tour_ride_veh_rightdoor_close(param_00)
{
	soundscripts\_snd::snd_slate("SLATE: rec_tour_ride_veh_rightdoor_close");
}

//Function Number: 122
rec_tour_vtol_takeoff_spawn(param_00)
{
	soundscripts\_snd::snd_printlnbold("SLATE: rec_tour_vtol_takeoff_spawn");
	param_00 soundscripts\_snd_playsound::snd_play_delayed_linked("rec_tour_warbird_takeoff",3.05);
}

//Function Number: 123
rec_littlebird_formation_spawn(param_00)
{
	if(param_00.vehicle_spawner.targetname == "littlebird_formation")
	{
		soundscripts\_snd::snd_printlnbold("SLATE: rec_littlebird_formation_spawn");
		return;
	}

	if(param_00.vehicle_spawner.targetname == "pf4_auto2369")
	{
		soundscripts\_snd::snd_printlnbold("SLATE: rec_littlebird_flyover");
		param_00 soundscripts\_snd_playsound::snd_play_delayed_linked("rec_tour_lb_flyby",2.8);
	}
}

//Function Number: 124
rec_tour_vehicle_1_start(param_00)
{
	soundscripts\_snd::snd_printlnbold("rec_tour_vehicle_1_start");
	level notify("rec_tour_jeep_idle_stop");
	level.cart soundscripts\_snd_playsound::snd_play_2d("rec_tour_jeep_sfx_front");
	level.cart soundscripts\_snd_playsound::snd_play_2d("rec_tour_jeep_sfx_rear");
	level.cart soundscripts\_snd_playsound::snd_play_2d("rec_tour_jeep_eng");
	param_00 soundscripts\_snd_playsound::snd_play_delayed_linked("rec_tour_civi_sedan",16.149);
}

//Function Number: 125
civ_domestic_truck_spawn(param_00)
{
	soundscripts\_snd::snd_printlnbold("civ_domestic_truck_spawn");
	soundscripts\_snd_playsound::snd_play_delayed_2d("rec_tour_civi_truck_front",7.273);
	soundscripts\_snd_playsound::snd_play_delayed_2d("rec_tour_civi_truck_rear",7.273);
}

//Function Number: 126
tour_drones_fly_by()
{
	soundscripts\_snd::snd_slate("tour_drones_fly_by");
	var_00 = self;
	var_00 soundscripts\_snd_playsound::snd_play_linked("rec_tour_three_drones_fly_by");
}

//Function Number: 127
attack_drone_flybys_audio()
{
	var_00 = "rec_tour_drone_flyby";
	var_01 = [];
	var_01[0] = 800;
	var_02 = [];
	var_02[0] = 20;
	var_02[1] = 5;
	thread soundscripts\_snd_common::snd_advanced_flyby_system(var_00,undefined,var_01,var_02,1,undefined,undefined,3,2);
}

//Function Number: 128
rec_tour_ride_irons_turns_to_plr(param_00)
{
	soundscripts\_snd::snd_slate("rec_tour_ride_irons_turns_to_plr");
	param_00 soundscripts\_snd_playsound::snd_play_linked("rec_tour_end_irons_turn");
}

//Function Number: 129
tour_littlebird_lander(param_00)
{
	soundscripts\_snd::snd_printlnbold("tour_littlebird_lander");
	wait(1.3);
	soundscripts\_snd_playsound::snd_play_2d("rec_tour_lb_lander_fronts");
	param_00 soundscripts\_snd_playsound::snd_play_linked("rec_tour_lb_lander_ent");
}

//Function Number: 130
vrap_spawn(param_00)
{
	level notify("aud_new_vrap",param_00);
}

//Function Number: 131
rec_tour_titan_gate_plr_open(param_00)
{
	soundscripts\_snd::snd_slate("Gate that the player drives through as the Titan passes by opens.");
	param_00 soundscripts\_snd_playsound::snd_play_delayed_linked("rec_tour_gate_locks",0);
	param_00 soundscripts\_snd_playsound::snd_play_delayed_linked("rec_tour_gate_move",0.1);
	param_00 soundscripts\_snd_playsound::snd_play_delayed_linked("rec_tour_gate_buzzer",0);
}

//Function Number: 132
rec_tour_titan_1_start(param_00)
{
	soundscripts\_snd::snd_printlnbold("rec_tour_titan_1_start");
	param_00 soundscripts\_snd_playsound::snd_play_delayed_linked("rec_base_titan_drive_by",0);
}

//Function Number: 133
rec_tour_escort_jeep_start(param_00)
{
	soundscripts\_snd::snd_printlnbold("rec_tour_escort_jeep_start");
}

//Function Number: 134
rec_tour_ride_irons_gestures(param_00)
{
	param_00 soundscripts\_snd_playsound::snd_play_linked("rec_tour_end_irons_gesture");
}

//Function Number: 135
rec_tour_titan_2_walk_anim_start(param_00)
{
	soundscripts\_snd::snd_printlnbold("rec_tour_titan_2_walk_anim_start");
	var_01 = param_00 soundscripts\_snd_playsound::snd_play_delayed_linked("walker_walking_mech",0.2);
	wait(12.5);
	var_01 unlink();
}

//Function Number: 136
rec_tour_hangar_background()
{
	var_00 = (-64,8793,232);
	common_scripts\utility::flag_wait("flag_titan_crossing");
	soundscripts\_snd_playsound::snd_play_delayed_at("rec_tour_hangar_background",var_00,14.25,undefined,"kill_hangar_emitters");
	level waittill("sounddone");
	level notify("kill_hangar_emitters");
}

//Function Number: 137
tour_hangar_drones(param_00)
{
	var_01 = param_00[0];
	var_02 = param_00[3];
	var_03 = param_00[8];
	var_04 = param_00[11];
	var_01 soundscripts\_snd_playsound::snd_play_linked("rec_tour_hangar_drone_land_01");
	var_02 soundscripts\_snd_playsound::snd_play_linked("rec_tour_hangar_drone_land_02");
	var_03 soundscripts\_snd_playsound::snd_play_linked("rec_tour_hangar_drone_land_03");
	var_04 soundscripts\_snd_playsound::snd_play_linked("rec_tour_hangar_drone_land_04");
	wait(13);
	soundscripts\_audio_mix_manager::mm_add_submix("irons_jeep_tour_exit_hanger",3);
}

//Function Number: 138
rec_tour_end_jeep_gate_plr_open(param_00)
{
	soundscripts\_snd::snd_slate("Gate that the player drives through at the end of the tour opens.");
	param_00 soundscripts\_snd_playsound::snd_play_delayed_linked("rec_tour_gate_locks",0);
	param_00 soundscripts\_snd_playsound::snd_play_delayed_linked("rec_tour_gate_move",0.1);
	param_00 soundscripts\_snd_playsound::snd_play_delayed_linked("rec_tour_gate_buzzer",0);
}

//Function Number: 139
rec_tour_end_jeep_gate_plr_close(param_00)
{
	soundscripts\_snd::snd_slate("Gate that the player drives through at the end of the tour closes.");
}

//Function Number: 140
rec_tour_ride_irons_waves(param_00)
{
	param_00 soundscripts\_snd_playsound::snd_play_linked("rec_tour_end_irons_wave");
}

//Function Number: 141
rec_tour_npc_jeep_exit_gate_open(param_00)
{
	soundscripts\_snd::snd_slate("Gate that the NPCs drive through opens.");
}

//Function Number: 142
rec_tour_npc_jeep_exit_gate_close(param_00)
{
	soundscripts\_snd::snd_slate("Gate that the NPCs drive through closes.");
}

//Function Number: 143
tour_littlebird_ambient(param_00)
{
	soundscripts\_snd::snd_printlnbold("tour_littlebird_ambient");
}

//Function Number: 144
rec_tour_ride_gid_hand_on_door(param_00)
{
	param_00 soundscripts\_snd_playsound::snd_play_linked("rec_tour_end_gid_open_door");
}

//Function Number: 145
rec_tour_ride_gid_exits_jeep(param_00)
{
	param_00 soundscripts\_snd_playsound::snd_play_linked("rec_tour_end_gid_exit_jeep");
}

//Function Number: 146
rec_tour_ride_plr_door(param_00)
{
	soundscripts\_snd_playsound::snd_play_2d("rec_tour_end_plr_open_door");
}

//Function Number: 147
rec_tour_ride_plr_exits_jeep(param_00)
{
	soundscripts\_snd_playsound::snd_play_2d("rec_tour_end_plr_exit_jeep");
	soundscripts\_audio_mix_manager::mm_clear_submix("irons_jeep_tour_exit_hanger",5);
}

//Function Number: 148
rec_tour_ride_veh_leftdoor_close(param_00)
{
	soundscripts\_snd::snd_slate("SLATE: rec_tour_ride_veh_leftdoor_close");
	level.cart soundscripts\_snd_playsound::snd_play_linked("rec_tour_jeep_exit_sfx");
	soundscripts\_audio_mix_manager::mm_clear_submix("irons_jeep_tour");
}

//Function Number: 149
audio_push_1_box_pickup(param_00)
{
	param_00 soundscripts\_snd_playsound::snd_play_linked("rec_pusher_box_pickup");
}

//Function Number: 150
audio_push_1_box_drop(param_00)
{
	param_00 soundscripts\_snd_playsound::snd_play_linked("rec_pusher_box_drop");
}

//Function Number: 151
audio_push_1_box_push(param_00)
{
	param_00 soundscripts\_snd_playsound::snd_play_linked("rec_pusher_box_push");
}

//Function Number: 152
audio_push_1_crane_move_1(param_00)
{
	param_00 soundscripts\_snd_playsound::snd_play_linked("rec_pusher_01_crane_move_01");
}

//Function Number: 153
audio_push_1_crane_move_2(param_00)
{
	param_00 soundscripts\_snd_playsound::snd_play_linked("rec_pusher_01_crane_move_02");
}

//Function Number: 154
audio_push_1_crane_move_3(param_00)
{
	param_00 soundscripts\_snd_playsound::snd_play_linked("rec_pusher_01_crane_move_03");
}

//Function Number: 155
audio_push_2_box_pickup(param_00)
{
	param_00 soundscripts\_snd_playsound::snd_play_linked("rec_pusher_box_pickup");
}

//Function Number: 156
audio_push_2_box_drop(param_00)
{
	param_00 soundscripts\_snd_playsound::snd_play_linked("rec_pusher_box_drop");
}

//Function Number: 157
audio_push_2_box_push(param_00)
{
	param_00 soundscripts\_snd_playsound::snd_play_linked("rec_pusher_box_push");
}

//Function Number: 158
audio_push_2_crane_move_1(param_00)
{
	param_00 soundscripts\_snd_playsound::snd_play_linked("rec_pusher_02_crane_move_01");
}

//Function Number: 159
audio_push_2_crane_move_2(param_00)
{
	param_00 soundscripts\_snd_playsound::snd_play_linked("rec_pusher_02_crane_move_02");
}

//Function Number: 160
audio_push_2_crane_move_3(param_00)
{
	param_00 soundscripts\_snd_playsound::snd_play_linked("rec_pusher_02_crane_move_03");
}

//Function Number: 161
exo_climb_start(param_00)
{
	param_00 soundscripts\_snd_playsound::snd_play_linked("rec_tour_exo_climb");
}

//Function Number: 162
exo_repair_vm_sit(param_00)
{
	soundscripts\_snd::snd_printlnbold("SLATE: exo_repair_vm_sit");
}

//Function Number: 163
exo_repair_vm_place_arm(param_00)
{
	soundscripts\_snd::snd_printlnbold("SLATE: exo_repair_vm_place_arm");
}

//Function Number: 164
exo_repair_desk_unfold(param_00)
{
	soundscripts\_snd::snd_printlnbold("SLATE: exo_repair_desk_unfold");
	soundscripts\_snd_playsound::snd_play_at("arm_bench_door_open",(-6483.47,3861.26,29.793));
	common_scripts\utility::flag_wait("tour_exo_arm");
	soundscripts\_snd_playsound::snd_play_delayed_2d("arm_bench_sit_foley",0.1);
}

//Function Number: 165
repair_desk_harness_close(param_00)
{
	soundscripts\_snd::snd_printlnbold("SLATE: repair_desk_harness_close");
	soundscripts\_snd_playsound::snd_play_delayed_2d("arm_bench_harness_close",0.5);
	soundscripts\_snd_playsound::snd_play_delayed_2d("arm_bench_grab_insert_needle",3.7);
}

//Function Number: 166
repair_desk_grab_needle(param_00)
{
	soundscripts\_snd::snd_printlnbold("SLATE: repair_desk_grab_needle");
}

//Function Number: 167
repair_desk_align_needle(param_00)
{
	soundscripts\_snd::snd_printlnbold("SLATE: repair_desk_align_needle");
}

//Function Number: 168
repair_desk_push_needle(param_00)
{
	soundscripts\_snd::snd_printlnbold("SLATE: repair_desk_push_needle");
}

//Function Number: 169
rec_exo_arm_repair_attempt_01_npc()
{
	soundscripts\_snd::snd_printlnbold("SLATE: rec_exo_arm_repair_attempt_01_npc");
	soundscripts\_snd_playsound::snd_play_delayed_2d("arm_bench_lab_tech_computer_01",0.05);
}

//Function Number: 170
rec_exo_arm_repair_attempt_02_npc()
{
	soundscripts\_snd::snd_printlnbold("SLATE: rec_exo_arm_repair_attempt_02_npc");
	soundscripts\_snd_playsound::snd_play_delayed_2d("arm_bench_lab_tech_computer_02",0.05);
}

//Function Number: 171
rec_exo_arm_repair_attempt_03_npc()
{
	soundscripts\_snd::snd_printlnbold("SLATE: rec_exo_arm_repair_attempt_03_npc");
	soundscripts\_snd_playsound::snd_play_delayed_2d("arm_bench_lab_tech_computer_03",0.75);
}

//Function Number: 172
exo_repair_movement(param_00)
{
	level endon("audio_repair_done");
	var_01 = 0;
	var_02 = 0;
	for(;;)
	{
		level waittill("audio_repair_weights_updated");
		if(level.aud.repair_weights["anim_up"] - 0.1 > level.aud.last_repair_weights["anim_up"] || level.aud.repair_weights["anim_down"] + 0.1 < level.aud.last_repair_weights["anim_down"])
		{
			if(var_02 == 1)
			{
				soundscripts\_snd::snd_printlnbold("Exo Repair - Stop Up");
				soundscripts\_snd::snd_printlnbold("Exo Repair - Start Down");
				play_exo_repair_movement_sound(param_00);
				var_02 = -1;
			}
			else if(var_02 == 0)
			{
				soundscripts\_snd::snd_printlnbold("Exo Repair - Start Down");
				play_exo_repair_movement_sound(param_00);
				var_02 = -1;
			}
		}
		else if(level.aud.repair_weights["anim_down"] - 0.1 > level.aud.last_repair_weights["anim_down"] || level.aud.repair_weights["anim_up"] + 0.1 < level.aud.last_repair_weights["anim_up"])
		{
			if(var_02 == -1)
			{
				soundscripts\_snd::snd_printlnbold("Exo Repair - Stop Down");
				soundscripts\_snd::snd_printlnbold("Exo Repair - Start Up");
				play_exo_repair_movement_sound(param_00);
				var_02 = 1;
			}
			else if(var_02 == 0)
			{
				soundscripts\_snd::snd_printlnbold("Exo Repair - Start Up");
				play_exo_repair_movement_sound(param_00);
				var_02 = 1;
			}
		}
		else
		{
			if(var_02 == 1)
			{
				soundscripts\_snd::snd_printlnbold("Exo Repair - Stop Up");
			}
			else if(var_02 == -1)
			{
				soundscripts\_snd::snd_printlnbold("Exp Repair - Stop Down");
			}

			var_02 = 0;
		}

		if(level.aud.repair_weights["anim_left"] - 0.1 > level.aud.last_repair_weights["anim_left"] || level.aud.repair_weights["anim_right"] + 0.1 < level.aud.last_repair_weights["anim_right"])
		{
			if(var_01 == 1)
			{
				soundscripts\_snd::snd_printlnbold("Exo Repair - Stop Right");
				soundscripts\_snd::snd_printlnbold("Exo Repair - Start Left");
				play_exo_repair_movement_sound(param_00);
				var_01 = -1;
			}
			else if(var_01 == 0)
			{
				soundscripts\_snd::snd_printlnbold("Exo Repair - Start Left");
				play_exo_repair_movement_sound(param_00);
				var_01 = -1;
			}

			continue;
		}

		if(level.aud.repair_weights["anim_right"] - 0.1 > level.aud.last_repair_weights["anim_right"] || level.aud.repair_weights["anim_left"] + 0.1 < level.aud.last_repair_weights["anim_left"])
		{
			if(var_01 == -1)
			{
				soundscripts\_snd::snd_printlnbold("Exo Repair - Stop Left");
				soundscripts\_snd::snd_printlnbold("Exo Repair - Start Right");
				play_exo_repair_movement_sound(param_00);
				var_01 = 1;
			}
			else if(var_01 == 0)
			{
				soundscripts\_snd::snd_printlnbold("Exo Repair - Start Right");
				play_exo_repair_movement_sound(param_00);
				var_01 = 1;
			}

			continue;
		}

		if(var_01 == 1)
		{
			soundscripts\_snd::snd_printlnbold("Exo Repair - Stop Right");
		}
		else if(var_01 == -1)
		{
			soundscripts\_snd::snd_printlnbold("Exp Repair - Stop Left");
		}

		var_01 = 0;
	}
}

//Function Number: 173
exo_repair_weight_updates(param_00)
{
	if(level.aud.last_repair_weights.size == 0)
	{
		level.aud.last_repair_weights = param_00;
	}
	else
	{
		level.aud.last_repair_weights = level.aud.repair_weights;
	}

	level.aud.repair_weights = param_00;
	level notify("audio_repair_weights_updated");
}

//Function Number: 174
exo_repair_movement_stop()
{
	level notify("audio_repair_done");
}

//Function Number: 175
play_exo_repair_movement_sound(param_00)
{
	switch(param_00)
	{
		case 1:
			soundscripts\_snd_playsound::snd_play_2d("arm_bench_knuckle_move");
			break;

		case 2:
			if(randomint(100) > 25)
			{
				soundscripts\_snd_playsound::snd_play_2d("arm_bench_finger_move");
			}
			break;

		case 3:
			if(randomint(100) > 25)
			{
				soundscripts\_snd_playsound::snd_play_2d("arm_bench_hand_move");
			}
			break;

		default:
			break;
	}
}

//Function Number: 176
rec_exo_arm_repair_attempt_exit_npc()
{
	soundscripts\_snd::snd_printlnbold("SLATE: repair_desk_remove_needle");
	soundscripts\_snd_playsound::snd_play_delayed_2d("arm_bench_remove_needle",1.4);
}

//Function Number: 177
repair_desk_remove_needle(param_00)
{
	soundscripts\_snd::snd_printlnbold("SLATE: repair_desk_remove_needle");
}

//Function Number: 178
repair_desk_harness_release(param_00)
{
	soundscripts\_snd::snd_printlnbold("SLATE: repair_desk_harness_release");
	soundscripts\_snd_playsound::snd_play_delayed_2d("arm_bench_remove_arm_exo",0.65);
}

//Function Number: 179
exo_repair_vm_lift_arm(param_00)
{
	soundscripts\_snd::snd_printlnbold("SLATE: exo_repair_vm_lift_arm");
}

//Function Number: 180
exo_repair_vm_test_hand(param_00)
{
	soundscripts\_snd::snd_printlnbold("SLATE: exo_repair_vm_test_hand");
}

//Function Number: 181
audio_start_wrestling_exo_guy(param_00)
{
	param_00 soundscripts\_snd_playsound::snd_play_linked("rec_tour_exo_sparring_guy_exo");
}

//Function Number: 182
audio_start_wrestling_guy2(param_00)
{
	param_00 soundscripts\_snd_playsound::snd_play_linked("rec_tour_exo_sparring_guy1");
}

//Function Number: 183
audio_start_wrestling_guy3(param_00)
{
	param_00 soundscripts\_snd_playsound::snd_play_linked("rec_tour_exo_sparring_guy2");
}

//Function Number: 184
audio_start_wrestling_guy4(param_00)
{
	param_00 soundscripts\_snd_playsound::snd_play_linked("rec_tour_exo_sparring_guy3");
}

//Function Number: 185
audio_start_wrestling_guy5(param_00)
{
	param_00 soundscripts\_snd_playsound::snd_play_linked("rec_tour_exo_sparring_guy4");
}

//Function Number: 186
exo_drone_flby(param_00)
{
	soundscripts\_audio_mix_manager::mm_add_submix("tour_drones_2");
	param_00 = self;
	param_00 soundscripts\_snd_playsound::snd_play_linked("rec_exo_fac_exit_drones_fly_by");
	wait(12);
	soundscripts\_audio_mix_manager::mm_clear_submix("tour_drones_2");
}

//Function Number: 187
tour_base_ambient_vehicle_01(param_00)
{
	param_00 soundscripts\_snd_playsound::snd_play_linked("rec_walking_tour_vehicle1");
}

//Function Number: 188
shooting_range_transition1(param_00)
{
	thread shooting_range_overdrive_watcher();
	soundscripts\_audio_mix_manager::mm_add_submix("rec_shooting_range");
	param_00 soundscripts\_snd_playsound::snd_play_delayed_linked("rec_shooting_range_appear",0);
	param_00 soundscripts\_snd_playsound::snd_play_delayed_linked("rec_shooting_range_panels_bell",3);
}

//Function Number: 189
shooting_range_panels_up(param_00)
{
	soundscripts\_snd_playsound::snd_play_delayed_2d("rec_shooting_range_panels_up",0);
}

//Function Number: 190
shooting_range_enemy_spawn(param_00)
{
	param_00 soundscripts\_snd_playsound::snd_play_delayed_linked("rec_shooting_range_red_appear",0);
}

//Function Number: 191
shooting_range_target_despawn()
{
	var_00 = self;
	var_00 soundscripts\_snd_playsound::snd_play_delayed_linked("rec_shooting_range_disappear",0);
}

//Function Number: 192
shooting_range_enemy_shot(param_00,param_01)
{
	param_00 soundscripts\_snd_playsound::snd_play_delayed_linked("rec_shooting_range_red_hit",0);
}

//Function Number: 193
shooting_range_friendly_spawn(param_00)
{
	param_00 soundscripts\_snd_playsound::snd_play_delayed_linked("rec_shooting_range_green_appear",0);
}

//Function Number: 194
shooting_range_friendly_shot(param_00,param_01)
{
	param_00 soundscripts\_snd_playsound::snd_play_delayed_linked("rec_shooting_range_green_hit",0);
}

//Function Number: 195
shooting_range_transition2(param_00)
{
	param_00 soundscripts\_snd_playsound::snd_play_delayed_linked("rec_shooting_range_appear",0);
}

//Function Number: 196
shooting_range_transition3(param_00)
{
	param_00 soundscripts\_snd_playsound::snd_play_delayed_linked("rec_shooting_range_appear",0);
}

//Function Number: 197
shooting_range_panels_down(param_00)
{
	soundscripts\_snd_playsound::snd_play_delayed_2d("rec_shooting_range_panels_down",0);
	level waittill("sounddone");
}

//Function Number: 198
tour_base_ambient_vehicle_02(param_00)
{
	param_00 soundscripts\_snd_playsound::snd_play_linked("rec_walking_tour_vehicle2");
	soundscripts\_audio_mix_manager::mm_clear_submix("rec_shooting_range");
	level notify("aud_shooting_range_complete");
}

//Function Number: 199
smart_grenade_target_flip()
{
	soundscripts\_snd::snd_slate("smart_grenade_target_flip");
	soundscripts\_snd_playsound::snd_play_linked("rec_ar_target_up");
}

//Function Number: 200
smart_grenade_target_move(param_00)
{
	var_01 = "stop_target_move" + soundscripts\_snd::snd_new_guid();
	var_02 = 0.31;
	soundscripts\_snd::snd_slate("smart_grenade_target_move");
	soundscripts\_snd_playsound::snd_play_loop_linked("rec_ar_target_move_lp",var_01);
	wait(param_00 - var_02);
	level notify(var_01);
	soundscripts\_snd_playsound::snd_play_linked("rec_ar_target_cod");
}

//Function Number: 201
smart_grenade_target_move_back(param_00)
{
	var_01 = "stop_target_move" + soundscripts\_snd::snd_new_guid();
	var_02 = 0.31;
	soundscripts\_snd::snd_slate("smart_grenade_target_move_back");
	soundscripts\_snd_playsound::snd_play_loop_linked("rec_ar_target_move_back_lp",var_01);
	wait(param_00 - var_02);
	level notify(var_01);
	soundscripts\_snd_playsound::snd_play_linked("rec_ar_target_cod");
}

//Function Number: 202
smart_grenade_target_hit()
{
	soundscripts\_snd::snd_slate("smart_grenade_target_hit");
}

//Function Number: 203
smart_grenade_target_shot()
{
	soundscripts\_snd::snd_slate("smart_grenade_target_shot");
}

//Function Number: 204
smart_grenade_target_flip_down()
{
	soundscripts\_snd::snd_slate("smart_grenade_target_flip_down");
	soundscripts\_snd_playsound::snd_play_linked("rec_ar_target_down");
}

//Function Number: 205
smart_grenade_target_expire()
{
	if(self.hit_type == "none")
	{
		soundscripts\_snd::snd_slate("smart_grenade_target_expire");
		soundscripts\_snd_playsound::snd_play_linked("rec_ar_target_down");
	}
}

//Function Number: 206
rec_readyroom_gideon_pushes_button(param_00)
{
	soundscripts\_snd::snd_slate("rec_readyroom_gideon_pushes_button");
	param_00 soundscripts\_snd_playsound::snd_play_delayed_linked("rec_rr_int_gideon_button",0.01);
}

//Function Number: 207
rec_readyroom_elevator_right_open(param_00)
{
	soundscripts\_audio_mix_manager::mm_add_submix("rec_readyroom_elevator");
	soundscripts\_snd::snd_slate("rec_readyroom_elevator_right_open");
	param_00 soundscripts\_snd_playsound::snd_play_delayed_linked("rec_rr_int_gates_close",0.4);
}

//Function Number: 208
rec_readyroom_elevator_right_close(param_00)
{
	soundscripts\_snd::snd_slate("rec_readyroom_elevator_right_close");
}

//Function Number: 209
rec_readyroom_elevator_right_up(param_00)
{
	soundscripts\_snd::snd_slate("rec_readyroom_elevator_right_up");
}

//Function Number: 210
rec_readyroom_elevator_right_open2(param_00)
{
	soundscripts\_snd::snd_slate("rec_readyroom_elevator_right_open2");
	param_00 soundscripts\_snd_playsound::snd_play_delayed_linked("rec_rr_ext_gates_open",0.15);
}

//Function Number: 211
rec_readyroom_elevator_left_open(param_00)
{
	soundscripts\_snd::snd_slate("rec_readyroom_elevator_left_open");
	param_00 soundscripts\_snd_playsound::snd_play_delayed_linked("rec_rr_int_gates_open",0.4);
}

//Function Number: 212
rec_readyroom_elevator_left_close(param_00)
{
	soundscripts\_snd::snd_slate("rec_readyroom_elevator_left_close");
	param_00 soundscripts\_snd_playsound::snd_play_delayed_linked("rec_rr_int_gates_close",0);
}

//Function Number: 213
rec_readyroom_elevator_left_up(param_00)
{
	soundscripts\_snd::snd_slate("rec_readyroom_elevator_left_up");
	soundscripts\_snd_playsound::snd_play_delayed_2d("rec_rr_int_elevator_start",0);
	soundscripts\_snd_playsound::snd_play_delayed_2d("rec_rr_int_elevator_move",1.2);
	soundscripts\_snd_playsound::snd_play_delayed_2d("rec_rr_ext_elevator_alarm",5.6);
	soundscripts\_snd_playsound::snd_play_delayed_2d("rec_rr_int_elevator_stop",12.7);
}

//Function Number: 214
rec_readyroom_elevator_left_hatch_back(param_00)
{
	param_00 soundscripts\_snd_playsound::snd_play_delayed_linked("rec_rr_int_elevator_hatch_open",0);
	param_00 soundscripts\_snd_playsound::snd_play_delayed_linked("rec_rr_int_elevator_hatch_impact",2.88);
}

//Function Number: 215
rec_readyroom_elevator_left_hatch_front(param_00)
{
	param_00 soundscripts\_snd_playsound::snd_play_delayed_linked("rec_rr_int_elevator_hatch_impact",2.88);
}

//Function Number: 216
rec_readyroom_elevator_left_open2(param_00)
{
	soundscripts\_snd::snd_slate("rec_readyroom_elevator_left_open2");
	param_00 soundscripts\_snd_playsound::snd_play_delayed_linked("rec_rr_ext_gates_open",0);
	wait(2);
	soundscripts\_audio_mix_manager::mm_clear_submix("rec_readyroom_elevator");
}

//Function Number: 217
rec_s2_door_guy_ambush()
{
	var_00 = self;
	soundscripts\_audio_mix_manager::mm_add_submix("door_guy_ambush");
	var_00 soundscripts\_snd_playsound::snd_play_linked("rec_s2_door_guy_ambush");
	wait(3);
	soundscripts\_audio_mix_manager::mm_clear_submix("door_guy_ambush");
}

//Function Number: 218
rec_s2_breach_gun_holster()
{
	soundscripts\_snd_playsound::snd_play_2d("wpn_med_holster_plr");
}

//Function Number: 219
rec_player_exo_breach_start(param_00)
{
	soundscripts\_snd::snd_printlnbold("SLATE: rec_player_exo_breach_start");
	soundscripts\_audio_mix_manager::mm_add_submix("training_2_breach");
	soundscripts\_snd_timescale::snd_set_timescale("slomo_timescale");
	soundscripts\_snd_playsound::snd_play_2d("rec_s2_breach_slomo_swing");
}

//Function Number: 220
rec_slomo_audio_handler()
{
	soundscripts\_snd_playsound::snd_play_2d("rec_s2_breach");
}

//Function Number: 221
rec_s2_breach_slo_mo(param_00)
{
	soundscripts\_audio_mix_manager::mm_add_submix("slomo");
	level.player enablecustomweaponcontext();
	soundscripts\_snd_common::snd_enable_soundcontextoverride("slomo");
	wait(0.05);
	soundscripts\_snd_playsound::snd_play_loop_2d("overdrive_loop","kill_slo_mo2",0.25,0.5);
	wait(param_00);
	soundscripts\_snd_playsound::snd_play_2d("rec_exit_slo_mo");
	wait(0.5);
	level notify("kill_slo_mo2");
	soundscripts\_snd_common::snd_disable_soundcontextoverride("slomo");
	level.player disablecustomweaponcontext();
	soundscripts\_snd_timescale::snd_set_timescale("all_on");
	soundscripts\_audio_mix_manager::mm_clear_submix("slomo");
	soundscripts\_audio_mix_manager::mm_clear_submix("training_2_breach");
}

//Function Number: 222
rec_slomo_kill_bad_guy(param_00)
{
	soundscripts\_snd_playsound::snd_play_at("bullet_flesh_slo_mo",param_00);
}

//Function Number: 223
aud_training_s2_potus_ziptie_release()
{
	soundscripts\_snd::snd_slate("potus_ziptie_cut");
	level.gideon soundscripts\_snd_playsound::snd_play_delayed_linked("rec_s2_breach_ziptie_cut",5);
}

//Function Number: 224
rec_s2_drones_attack(param_00)
{
	soundscripts\_snd::snd_printlnbold("Drone Flyby 2 Turn");
	var_01 = param_00[0];
	if(!isalive(var_01))
	{
		if(isalive(param_00[1]))
		{
			var_01 = param_00[1];
		}
		else if(isalive(param_00[2]))
		{
			var_01 = param_00[2];
		}
		else
		{
			return;
		}
	}

	var_01 soundscripts\_snd_playsound::snd_play_linked("rec_s1_drone_alert");
	level notify("s1_drones_attacking");
	var_01 soundscripts\_snd_playsound::snd_play_linked("rec_s1_drone_attack");
}

//Function Number: 225
rec_player_drone_start(param_00)
{
	soundscripts\_audio_mix_manager::mm_add_submix("s2_playable_drone");
	level endon("pdrone_end");
	var_01 = param_00.origin;
	var_02 = level.player playerads();
	var_03 = 0;
	for(;;)
	{
		var_04 = param_00.origin;
		var_05 = level.player playerads();
		var_06 = abs(length(var_04 - var_01));
		var_07 = var_05 - var_02;
		if(var_07 > 0)
		{
			if(var_03 != -1)
			{
				soundscripts\_snd_playsound::snd_play_2d("wpn_wasp_scope_zoom_out");
				var_03 = -1;
			}
		}
		else if(var_07 < 0)
		{
			if(var_03 != 1)
			{
				level.aud.zoominsound = soundscripts\_snd_playsound::snd_play_2d("wpn_wasp_scope_zoom_in","stop_zoominsound",0,0.25);
				var_03 = 1;
			}
		}
		else if(var_03 != 0)
		{
			level notify("stop_zoominsound");
			var_03 = 0;
		}

		var_01 = var_04;
		var_02 = var_05;
		wait 0.05;
	}
}

//Function Number: 226
rec_player_drone_end()
{
	level notify("pdrone_end");
	soundscripts\_audio_mix_manager::mm_clear_submix("s2_playable_drone");
	soundscripts\_audio_mix_manager::mm_clear_submix("drone_deploy");
}

//Function Number: 227
snd_player_drone_deploy(param_00)
{
	soundscripts\_audio_mix_manager::mm_add_submix("drone_deploy");
	soundscripts\_snd_playsound::snd_play_delayed_2d("assault_drone_deploy",0.2);
	soundscripts\_snd_playsound::snd_play_delayed_2d("assault_drone_wrist_panel",3.63);
	wait(2.75);
	soundscripts\_snd_playsound::snd_play_at("assault_drone_start",param_00.origin,"kill_player_op_drone_ext_loop",undefined,1.5);
}

//Function Number: 228
snd_player_drone_wrist_panel()
{
}

//Function Number: 229
snd_player_drone_enter_drone_pov()
{
	soundscripts\_snd_playsound::snd_play_2d("assault_drone_start_pov");
}

//Function Number: 230
rec_s2_exfil_car_plr_start(param_00)
{
	soundscripts\_snd_playsound::snd_play_2d("rec_s2_exfil_plr_start");
}

//Function Number: 231
rec_s2_exfil_car_plr_help_potus(param_00)
{
	soundscripts\_snd_playsound::snd_play_2d("rec_s2_exfil_plr_help");
}

//Function Number: 232
rec_s2_exfil_car_plr_hand(param_00)
{
	soundscripts\_snd_playsound::snd_play_2d("rec_s2_exfil_plr_hand");
}

//Function Number: 233
rec_s2_exfil_potus_start(param_00)
{
	param_00 soundscripts\_snd_playsound::snd_play_linked("rec_s2_exfil_potus_start");
}

//Function Number: 234
rec_s2_exfil_potus_enter_car(param_00)
{
	param_00 soundscripts\_snd_playsound::snd_play_linked("rec_s2_exfil_potus_car");
}

//Function Number: 235
rec_train2_exfil_car_start(param_00)
{
	param_00 soundscripts\_snd_playsound::snd_play_delayed_linked("rec_train_2_exfil_car_enter_engine",0);
	param_00 soundscripts\_snd_playsound::snd_play_delayed_linked("rec_train_2_exfil_car_sfx_enter",0);
	param_00 soundscripts\_snd_playsound::snd_play_delayed_linked("rec_train_2_exfil_car_puddle_enter",0);
	param_00 soundscripts\_snd_playsound::snd_play_delayed_loop_linked("rec_train_2_exfil_car_idle_loop",5.205,0,"exfil_car_exit");
}

//Function Number: 236
rec_train2_exfil_car_end(param_00)
{
	soundscripts\_snd::snd_printlnbold("rec_train2_exfil_car_end");
	soundscripts\_audio_mix_manager::mm_add_submix("s2_exfil_drones");
	level notify("exfil_car_exit");
	param_00 soundscripts\_snd_playsound::snd_play_delayed_linked("rec_train_2_exfil_car_exit_engine",0);
	param_00 soundscripts\_snd_playsound::snd_play_delayed_linked("rec_train_2_exfil_car_sfx_exit",8.182);
}

//Function Number: 237
rec_train2_ambush_car_2(param_00)
{
	wait 0.05;
	param_00 soundscripts\_snd_playsound::snd_play_linked("rec_train_2_ambush_1_eng");
	param_00 soundscripts\_snd_playsound::snd_play_linked("rec_train_2_ambush_1_sfx");
}

//Function Number: 238
rec_train2_ambush_car_1(param_00)
{
	wait(2.402);
	param_00 soundscripts\_snd_playsound::snd_play_linked("rec_train_2_ambush_2_eng");
	param_00 soundscripts\_snd_playsound::snd_play_linked("rec_train_2_ambush_2_sfx");
}

//Function Number: 239
rec_t2_warbird_start(param_00)
{
	level endon("aud_irons_warbird_shutdown");
	soundscripts\_snd::snd_printlnbold("SLATE: rec_t2_warbird_start");
	soundscripts\_audio_mix_manager::mm_add_submix("ending_warbird_pcap");
	param_00 soundscripts\_snd_playsound::snd_play_linked("rec_ending_irons_warbird_flyover");
	param_00 soundscripts\_snd_playsound::snd_play_delayed_linked("rec_ending_irons_warbird_landing",3.05);
	wait(15);
	param_00 soundscripts\_snd_playsound::snd_play_loop_linked("rec_ending_irons_warbird_idle_lp","aud_irons_warbird_shutdown",5,20);
}

//Function Number: 240
rec_t2_warbird_decloak(param_00)
{
	soundscripts\_snd::snd_printlnbold("SLATE: rec_t2_warbird_decloak");
}

//Function Number: 241
rec_t2_warbird_land(param_00)
{
	soundscripts\_snd::snd_printlnbold("SLATE: rec_t2_warbird_land");
	soundscripts\_audio_mix_manager::mm_clear_submix("s2_exfil_drones");
}

//Function Number: 242
rec_t2_warbird_door_open(param_00)
{
	level notify("aud_irons_warbird_shutdown");
	soundscripts\_snd::snd_printlnbold("SLATE: rec_t2_warbird_door_open");
	param_00 soundscripts\_snd_playsound::snd_play_linked("warbird_door_mech_a");
	param_00 soundscripts\_snd_playsound::snd_play_linked("warbird_door_mech_b");
	param_00 soundscripts\_snd_playsound::snd_play_linked("rec_ending_irons_warbird_shutdown");
}

//Function Number: 243
training_2_irons_ending(param_00)
{
	soundscripts\_snd::snd_printlnbold("SLATE: training_2_irons_ending");
}

//Function Number: 244
camp_david_thunder_transition()
{
	soundscripts\_snd_playsound::snd_play_delayed_2d("arm_thunder_gun_turn_gear",0.75);
}

//Function Number: 245
camp_david_reload_malfunction(param_00,param_01)
{
	soundscripts\_snd::snd_printlnbold("SLATE: Malfunction: " + param_00 + " : " + param_01);
	switch(param_00)
	{
		case 1:
			soundscripts\_snd_playsound::snd_play_delayed_2d("arm_malfunction_type1",0.2);
			soundscripts\_snd_playsound::snd_play_delayed_2d("rec_wpn_bal27_magout",3.2);
			soundscripts\_snd_playsound::snd_play_delayed_2d("rec_wpn_bal27_maggrab",3.5);
			soundscripts\_snd_playsound::snd_play_delayed_2d("rec_wpn_bal27_magin",4.26);
			soundscripts\_snd_playsound::snd_play_delayed_2d("rec_wpn_bal27_magsmack",4.5);
			break;

		case 2:
			soundscripts\_snd_playsound::snd_play_delayed_2d("arm_malfunction_type2",0.267);
			soundscripts\_snd_playsound::snd_play_delayed_2d("rec_wpn_bal27_magout",2.8);
			soundscripts\_snd_playsound::snd_play_delayed_2d("rec_wpn_bal27_maggrab",2.7);
			soundscripts\_snd_playsound::snd_play_delayed_2d("rec_wpn_bal27_magin",3.59);
			soundscripts\_snd_playsound::snd_play_delayed_2d("rec_wpn_bal27_magsmack",3.9);
			break;

		case 3:
			soundscripts\_snd_playsound::snd_play_delayed_2d("arm_malfunction_type1",0.26);
			break;

		case 4:
			soundscripts\_snd_playsound::snd_play_delayed_2d("arm_malfunction_type2",0.202);
			break;

		case 5:
			soundscripts\_snd_playsound::snd_play_delayed_2d("arm_malfunction_type1",0);
			soundscripts\_snd_playsound::snd_play_delayed_2d("rec_wpn_ak12_magout",3.6);
			soundscripts\_snd_playsound::snd_play_delayed_2d("rec_wpn_ak12_magin",4.5);
			break;

		case 6:
			soundscripts\_snd_playsound::snd_play_delayed_2d("arm_malfunction_type2",0.198);
			soundscripts\_snd_playsound::snd_play_delayed_2d("rec_wpn_ak12_magout",3.6);
			soundscripts\_snd_playsound::snd_play_delayed_2d("rec_wpn_ak12_magin",4.3);
			break;

		case 7:
			soundscripts\_snd_playsound::snd_play_delayed_2d("arm_malfunction_type1",0.191);
			break;

		case 8:
			soundscripts\_snd_playsound::snd_play_delayed_2d("arm_malfunction_type2",0.02);
			break;

		case 9:
			soundscripts\_snd_playsound::snd_play_delayed_2d("arm_malfunction_type1",0);
			soundscripts\_snd_playsound::snd_play_delayed_2d("rec_wpn_rhino_magout",3.2);
			soundscripts\_snd_playsound::snd_play_delayed_2d("rec_wpn_rhino_magin",4.5);
			break;

		case 10:
			soundscripts\_snd_playsound::snd_play_delayed_2d("arm_malfunction_type2",0.2);
			soundscripts\_snd_playsound::snd_play_delayed_2d("rec_wpn_rhino_magout",2.7);
			soundscripts\_snd_playsound::snd_play_delayed_2d("rec_wpn_rhino_magin",4);
			break;

		case 11:
			soundscripts\_snd_playsound::snd_play_delayed_2d("arm_malfunction_type1",0);
			break;

		case 12:
			soundscripts\_snd_playsound::snd_play_delayed_2d("arm_malfunction_type2",0.081);
			break;

		default:
			break;
	}
}

//Function Number: 246
rec_guy_doubledoor_breach_start(param_00)
{
	if(level.joker == param_00)
	{
		soundscripts\_snd::snd_printlnbold("SLATE: rec_guy_doubledoor_breach_start - Joker");
		param_00 soundscripts\_snd_playsound::snd_play_delayed_linked("rec_assault_exit_joker_steps",2.45);
		param_00 soundscripts\_snd_playsound::snd_play_delayed_linked("rec_assault_exit_joker_gear",2.45);
		soundscripts\_audio_mix_manager::mm_add_submix("rec_assault_exit_joker");
		param_00 soundscripts\_snd_playsound::snd_play_delayed_linked("rec_assault_exit_joker_texture",2.45);
		param_00 soundscripts\_snd_playsound::snd_play_delayed_linked("rec_assault_exit_joker_door",2.45);
		wait(10);
		soundscripts\_audio_mix_manager::mm_clear_submix("rec_assault_exit_joker");
		return;
	}

	if(level.gideon == param_00)
	{
		soundscripts\_snd::snd_printlnbold("SLATE: rec_guy_doubledoor_breach_start - Gideon");
		param_00 soundscripts\_snd_playsound::snd_play_delayed_linked("rec_assault_exit_gideon_steps",2.45);
		param_00 soundscripts\_snd_playsound::snd_play_delayed_linked("rec_assault_exit_gideon_gear",2.45);
		soundscripts\_audio_mix_manager::mm_add_submix("rec_assault_exit_gideon");
		param_00 soundscripts\_snd_playsound::snd_play_delayed_linked("rec_assault_exit_gideon_texture",2.45);
		param_00 soundscripts\_snd_playsound::snd_play_delayed_linked("rec_assault_exit_gideon_door",2.45);
		wait(10);
		soundscripts\_audio_mix_manager::mm_clear_submix("rec_assault_exit_gideon");
	}
}

//Function Number: 247
rec_star_trek_door_open(param_00,param_01)
{
	level endon("aud_door_closing_" + param_00.targetname);
	level notify("aud_door_opening_" + param_00.targetname);
	soundscripts\_snd_playsound::snd_play_at("rec_star_trek_door_open_movement",param_00.origin + param_01.origin / 2,"aud_door_closing_" + param_00.targetname);
	wait(0.45);
	soundscripts\_snd_playsound::snd_play_at("rec_star_trek_door_open_impact",param_00.origin + param_01.origin / 2);
}

//Function Number: 248
rec_star_trek_door_close(param_00,param_01)
{
	level endon("aud_door_opening_" + param_00.targetname);
	level notify("aud_door_closing_" + param_00.targetname);
	soundscripts\_snd_playsound::snd_play_at("rec_star_trek_door_close_movement",param_00.origin + param_01.origin / 2,"aud_door_opening_" + param_00.targetname);
	wait(0.45);
	soundscripts\_snd_playsound::snd_play_at("rec_star_trek_door_close_impact",param_00.origin + param_01.origin / 2);
}

//Function Number: 249
setup_funeral_ambi_fade()
{
	common_scripts\utility::flag_wait("eulogy_complete");
	soundscripts\_audio_mix_manager::mm_add_submix("rec_funeral_ambi_fade",10);
}

//Function Number: 250
setup_lightning_transition()
{
	common_scripts\utility::flag_wait("player_proximity_irons");
	var_00 = soundscripts\_audio_zone_manager::azm_get_current_zone();
	if(var_00 == "ext_funeral")
	{
		common_scripts\utility::flag_wait("training_start_area_lighting");
		soundscripts\_audio_zone_manager::azm_stop_zone(var_00,0.5);
		soundscripts\_audio_zone_manager::azm_start_zone("ext_lodge",0.5);
	}
}

//Function Number: 251
setup_training_01_end_ambi_swap()
{
	level waittill("stop_rain_quads");
	soundscripts\_snd_playsound::snd_play_loop_at("rec_training_rain_ending",(1182,-2019,63),"stop_rain_emitters",2,5);
	soundscripts\_audio_mix_manager::mm_add_submix("rec_training_01_ambis",8);
	wait(7);
	var_00 = soundscripts\_audio_zone_manager::azm_get_current_zone();
	if(var_00 == "ext_exfil")
	{
		wait(10);
		soundscripts\_audio_zone_manager::azm_set_zone_streamed_ambience("ext_exfil","amb_ext_compound",10);
	}

	common_scripts\utility::flag_wait("flag_obj_base_start");
	soundscripts\_audio_zone_manager::azm_set_zone_streamed_ambience("ext_exfil","amb_ext_forest_rain");
	level notify("stop_rain_emitters");
}

//Function Number: 252
setup_training_01_end_compound_ambi_emitter()
{
	level waittill("start_compound_ambi_emitter");
	soundscripts\_snd_playsound::snd_play_loop_at("rec_training_ext_compound",(537,9,224),"stop_rain_emitters",9,5);
}

//Function Number: 253
play_vrap_sounds()
{
	if(!isdefined(level.aud.vrapcount))
	{
		level.aud.vrapcount = 0;
	}

	for(;;)
	{
		level waittill("aud_new_vrap",var_00);
		level.aud.vrapcount = level.aud.vrapcount + 1;
		switch(level.aud.vrapcount)
		{
			case 1:
				soundscripts\_snd::snd_printlnbold("vrap_1_spawn");
				break;
	
			case 2:
				soundscripts\_snd::snd_printlnbold("vrap_2_spawn");
				break;
	
			default:
				soundscripts\_snd::snd_printlnbold("Move vraps than we know what to do with");
				break;
		}

		wait 0.05;
	}
}

//Function Number: 254
shooting_range_overdrive_watcher()
{
	level endon("aud_shooting_range_complete");
	for(;;)
	{
		level.player maps\_utility::ent_flag_wait("overdrive_on");
		wait(0.25);
		soundscripts\_audio_mix_manager::mm_add_submix("rec_shooting_range_overdrive");
		level.player maps\_utility::ent_flag_waitopen("overdrive_on");
		soundscripts\_audio_mix_manager::mm_clear_submix("rec_shooting_range_overdrive");
		wait 0.05;
	}
}

//Function Number: 255
setup_training_02_breach_smartglass()
{
	common_scripts\utility::flag_wait("training_s2_start_charge");
	soundscripts\_snd_playsound::snd_play_loop_at("emt_rec_cabin_sglass_brkn_lp",(-2908,-5304,376),"stop_electronic_emitters_sim_02",1,1);
}

//Function Number: 256
temp_dog_bark(param_00)
{
	param_00 soundscripts\_snd_playsound::snd_play_linked("lag_dog_bark");
}