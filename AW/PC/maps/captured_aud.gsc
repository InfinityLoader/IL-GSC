/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: captured_aud.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 272
 * Decompile Time: 3988 ms
 * Timestamp: 4/22/2024 2:26:09 AM
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
config_system()
{
	soundscripts\_audio::set_stringtable_mapname("shg");
	soundscripts\_snd_filters::snd_set_occlusion("med_occlusion");
}

//Function Number: 3
init_snd_flags()
{
	common_scripts\utility::flag_init("flag_stop_caravan_sfx");
	common_scripts\utility::flag_init("flag_stop_intro_music");
	common_scripts\utility::flag_init("flag_start_interrogation_music_pt2");
}

//Function Number: 4
init_globals()
{
	level.incin_amb = spawn("script_origin",(0,0,0));
	level.aud.incin_close = spawn("script_origin",(0,0,3));
	level.aud.cart_push = spawn("script_origin",(0,0,2));
	level.aud.cart_push2 = spawn("script_origin",(0,0,2));
	level.aud.cart = spawn("script_origin",(0,0,1));
	level.aud.cart_first_time = 1;
	level.aud.flame_loop = 0;
	level.aud.flame_loop2 = 0;
	level.aud.limp_footsteps = 0;
	level.aud.s2_walk_footsteps = 0;
	level.aud.mech_error_timeout = 0;
	level.aud.cell_prisoners_trig = 0;
	level.aud.incin_burst = spawn("script_origin",(7986,-13424,-1675));
	level.aud.incin_burst2 = spawn("script_origin",(7851,-13394,-1685));
	level.aud.living_gate = 0;
}

//Function Number: 5
launch_threads()
{
	if(soundscripts\_audio::aud_is_specops())
	{
		return;
	}

	thread aud_captured_foley_override_handler();
	thread aud_captured_setup_anims();
	var_00 = getent("trigger_darkness","targetname");
	var_00 thread trigger_darkness();
}

//Function Number: 6
launch_loops()
{
}

//Function Number: 7
create_level_envelop_arrays()
{
	level.aud.envs = [];
	level.aud.envs["example_envelop"] = [[0,0],[0.082,0.426],[0.238,0.736],[0.408,0.844],[0.756,0.953],[1,1]];
}

//Function Number: 8
precache_presets()
{
}

//Function Number: 9
register_snd_messages()
{
	soundscripts\_snd::snd_register_message("snd_zone_handler",::zone_handler);
	soundscripts\_snd::snd_register_message("snd_music_handler",::music_handler);
	soundscripts\_snd::snd_register_message("start_intro_drive",::start_intro_drive);
	soundscripts\_snd::snd_register_message("start_s1_elevator",::start_s1_elevator);
	soundscripts\_snd::snd_register_message("start_s2_walk",::start_s2_walk);
	soundscripts\_snd::snd_register_message("start_escape",::start_escape);
	soundscripts\_snd::snd_register_message("start_s2_elevator",::start_s2_elevator);
	soundscripts\_snd::snd_register_message("start_test_chamber",::start_test_chamber);
	soundscripts\_snd::snd_register_message("start_halls_to_autopsy",::start_halls_to_autopsy);
	soundscripts\_snd::snd_register_message("start_trolley",::start_trolley);
	soundscripts\_snd::snd_register_message("start_battle_to_heli",::start_battle_to_heli);
	soundscripts\_snd::snd_register_message("aud_intro_heli_flyover",::aud_intro_heli_flyover);
	soundscripts\_snd::snd_register_message("scn_truck_sounds",::scn_truck_sounds);
	soundscripts\_snd::snd_register_message("entrance_alarm",::entrance_alarm);
	soundscripts\_snd::snd_register_message("entrance_alarm_fast2",::entrance_alarm_fast2);
	soundscripts\_snd::snd_register_message("entrance_alarm_fast",::entrance_alarm_fast);
	soundscripts\_snd::snd_register_message("entrance_vo_01",::entrance_vo_01);
	soundscripts\_snd::snd_register_message("entrance_vo_03",::entrance_vo_03);
	soundscripts\_snd::snd_register_message("aud_intro_caravan_passby",::aud_intro_caravan_passby);
	soundscripts\_snd::snd_register_message("aud_intro_caravan_mute",::aud_intro_caravan_mute);
	soundscripts\_snd::snd_register_message("aud_intro_caravan_unmute",::aud_intro_caravan_unmute);
	soundscripts\_snd::snd_register_message("aud_mech_idle_sfx",::aud_mech_idle_sfx);
	soundscripts\_snd::snd_register_message("aud_intro_to_elev_walla",::aud_intro_to_elev_walla);
	soundscripts\_snd::snd_register_message("aud_stop_cormack_foley",::aud_stop_cormack_foley);
	soundscripts\_snd::snd_register_message("s2_elevator_door_open_top",::s2_elevator_door_open_top);
	soundscripts\_snd::snd_register_message("s2_elevator_ride_down",::s2_elevator_ride_down);
	soundscripts\_snd::snd_register_message("s2_elevator_door_open",::s2_elevator_door_open);
	soundscripts\_snd::snd_register_message("s2_elevator_door_close",::s2_elevator_door_close);
	soundscripts\_snd::snd_register_message("aud_s2walk_trigger_start",::aud_s2walk_trigger_start);
	soundscripts\_snd::snd_register_message("s2_prison_amb",::s2_prison_amb);
	soundscripts\_snd::snd_register_message("aud_plr_hit",::aud_plr_hit);
	soundscripts\_snd::snd_register_message("aud_plr_hit_vo_move_forward",::aud_plr_hit_vo_move_forward);
	soundscripts\_snd::snd_register_message("aud_plr_hit_vo_move_back",::aud_plr_hit_vo_move_back);
	soundscripts\_snd::snd_register_message("aud_plr_hit_vo_look",::aud_plr_hit_vo_look);
	soundscripts\_snd::snd_register_message("aud_plr_hit_vo_line",::aud_plr_hit_vo_line);
	soundscripts\_snd::snd_register_message("aud_ambient_animations",::aud_ambient_animations);
	soundscripts\_snd::snd_register_message("s2_walk_vo_execution",::s2_walk_vo_execution);
	soundscripts\_snd::snd_register_message("s2_walk_execution_PA",::s2_walk_execution_pa);
	soundscripts\_snd::snd_register_message("aud_s2walk_emitters",::aud_s2walk_emitters);
	soundscripts\_snd::snd_register_message("aud_s2walk_alarm_tone_lp",::aud_s2walk_alarm_tone_lp);
	soundscripts\_snd::snd_register_message("aud_s2walk_flyby_1",::aud_s2walk_flyby_1);
	soundscripts\_snd::snd_register_message("aud_s2walk_door_open",::aud_s2walk_door_open);
	soundscripts\_snd::snd_register_message("aud_s2walk_door_close",::aud_s2walk_door_close);
	soundscripts\_snd::snd_register_message("aud_s2walk_prisoner_2_beating",::aud_s2walk_prisoner_2_beating);
	soundscripts\_snd::snd_register_message("aud_s2walk_execution_kneeling_prisoners",::aud_s2walk_execution_kneeling_prisoners);
	soundscripts\_snd::snd_register_message("aud_s2walk_execution_fire",::aud_s2walk_execution_fire);
	soundscripts\_snd::snd_register_message("aud_s2walk_loudspeaker2_line1",::aud_s2walk_loudspeaker2_line1);
	soundscripts\_snd::snd_register_message("aud_s2walk_loudspeaker2_line2",::aud_s2walk_loudspeaker2_line2);
	soundscripts\_snd::snd_register_message("aud_s2walk_cell_prisoners",::aud_s2walk_cell_prisoners);
	soundscripts\_snd::snd_register_message("aud_s2walk_guard_radios",::aud_s2walk_guard_radios);
	soundscripts\_snd::snd_register_message("aud_s2walk_cells_foley_mix",::aud_s2walk_cells_foley_mix);
	soundscripts\_snd::snd_register_message("aud_s2walk_clear_foley_mix",::aud_s2walk_clear_foley_mix);
	soundscripts\_snd::snd_register_message("aud_s2walk_temp_guard_VO",::aud_s2walk_temp_guard_vo);
	soundscripts\_snd::snd_register_message("aud_s2walk_guard_hip_radio",::aud_s2walk_guard_hip_radio);
	soundscripts\_snd::snd_register_message("aud_s2walk_yard_prisoners_whimpering",::aud_s2walk_yard_prisoners_whimpering);
	soundscripts\_snd::snd_register_message("aud_incin_flame_loop_2",::aud_incin_flame_loop_2);
	soundscripts\_snd::snd_register_message("aud_trolley_music",::aud_trolley_music);
	soundscripts\_snd::snd_register_message("aud_interrogation_music_pt1",::aud_interrogation_music_pt1);
	soundscripts\_snd::snd_register_message("aud_interrogation_music_pt2",::aud_interrogation_music_pt2);
	soundscripts\_snd::snd_register_message("aud_interrogation_scene",::aud_interrogation_scene);
	soundscripts\_snd::snd_register_message("aud_cap_interrogation_transition_vo",::aud_cap_interrogation_transition_vo);
	soundscripts\_snd::snd_register_message("aud_rescue_drone",::aud_rescue_drone);
	soundscripts\_snd::snd_register_message("aud_red_light",::aud_red_light);
	soundscripts\_snd::snd_register_message("aud_escape_doctor_bodybag",::aud_escape_doctor_bodybag);
	soundscripts\_snd::snd_register_message("aud_escape_guard_takedown_door",::aud_escape_guard_takedown_door);
	soundscripts\_snd::snd_register_message("aud_escape_keycard",::aud_escape_keycard);
	soundscripts\_snd::snd_register_message("aud_limp_on",::aud_limp_on);
	soundscripts\_snd::snd_register_message("aud_limp_exo",::aud_limp_exo);
	soundscripts\_snd::snd_register_message("aud_limp_off",::aud_limp_off);
	soundscripts\_snd::snd_register_message("aud_stop_headspace_ambience",::aud_stop_headspace_ambience);
	soundscripts\_snd::snd_register_message("aud_play_horror_ambience",::aud_play_horror_ambience);
	soundscripts\_snd::snd_register_message("aud_stop_horror_ambience",::aud_stop_horror_ambience);
	soundscripts\_snd::snd_register_message("aud_escape_give_gun_exo",::aud_escape_give_gun_exo);
	soundscripts\_snd::snd_register_message("aud_onearm_weapon_swap",::aud_onearm_weapon_swap);
	soundscripts\_snd::snd_register_message("aud_cap_45_onearm_toss",::aud_cap_45_onearm_toss);
	soundscripts\_snd::snd_register_message("aud_cap_sml_onearm_toss",::aud_cap_sml_onearm_toss);
	soundscripts\_snd::snd_register_message("aud_separation_logic",::aud_separation_logic);
	soundscripts\_snd::snd_register_message("aud_separation_elevator",::aud_separation_elevator);
	soundscripts\_snd::snd_register_message("aud_separation_door",::aud_separation_door);
	soundscripts\_snd::snd_register_message("start_indoor_alarms",::start_courtyard_alarms);
	soundscripts\_snd::snd_register_message("start_indoor_alarms_2",::start_post_courtyard_interior_alarms);
	soundscripts\_snd::snd_register_message("aud_gideon_test_chamber_stair_door",::aud_gideon_test_chamber_stair_door);
	soundscripts\_snd::snd_register_message("aud_gideon_test_chamber_climb_stairs_1",::aud_gideon_test_chamber_climb_stairs_1);
	soundscripts\_snd::snd_register_message("aud_observation_guard_radio",::aud_observation_guard_radio);
	soundscripts\_snd::snd_register_message("aud_zap_scene",::aud_zap_scene);
	soundscripts\_snd::snd_register_message("aud_alarm_submix",::aud_alarm_submix);
	soundscripts\_snd::snd_register_message("aud_morgue_bodybag_line_emt",::aud_morgue_bodybag_line_emt);
	soundscripts\_snd::snd_register_message("aud_morgue_bodybag_doors",::aud_morgue_bodybag_doors);
	soundscripts\_snd::snd_register_message("aud_morgue_computer_door_entry_sfx",::aud_morgue_computer_door_entry_sfx);
	soundscripts\_snd::snd_register_message("aud_autopsy_knife_pry_door",::aud_autopsy_knife_pry_door);
	soundscripts\_snd::snd_register_message("aud_autopsy_entrance",::aud_autopsy_entrance);
	soundscripts\_snd::snd_register_message("aud_autopsy_entrance_vo",::aud_autopsy_entrance_vo);
	soundscripts\_snd::snd_register_message("aud_hatch_gideon",::aud_hatch_gideon);
	soundscripts\_snd::snd_register_message("incinerator_dialogue",::incinerator_dialogue);
	soundscripts\_snd::snd_register_message("incinerator_dialogue_2",::incinerator_dialogue_2);
	soundscripts\_snd::snd_register_message("start_incinerator",::start_incinerator);
	soundscripts\_snd::snd_register_message("aud_incin_blackout",::aud_incin_blackout);
	soundscripts\_snd::snd_register_message("aud_incin_pipe_grab",::aud_incin_pipe_grab);
	soundscripts\_snd::snd_register_message("aud_incin_pipe_burst",::aud_incin_pipe_burst);
	soundscripts\_snd::snd_register_message("aud_incin_pilot_light",::aud_incin_pilot_light);
	soundscripts\_snd::snd_register_message("aud_incin_pilot_light1",::aud_incin_pilot_light1);
	soundscripts\_snd::snd_register_message("aud_incin_pilot_light2",::aud_incin_pilot_light2);
	soundscripts\_snd::snd_register_message("aud_incin_pilot_light3",::aud_incin_pilot_light3);
	soundscripts\_snd::snd_register_message("aud_incin_pilot_light4",::aud_incin_pilot_light4);
	soundscripts\_snd::snd_register_message("aud_incin_pilot_light5",::aud_incin_pilot_light5);
	soundscripts\_snd::snd_register_message("aud_incin_cart_start",::aud_incin_cart_start);
	soundscripts\_snd::snd_register_message("aud_incin_cart_push",::aud_incin_cart_push);
	soundscripts\_snd::snd_register_message("aud_incin_cart_push_stop",::aud_incin_cart_push_stop);
	soundscripts\_snd::snd_register_message("aud_incin_cart_done",::aud_incin_cart_done);
	soundscripts\_snd::snd_register_message("aud_incin_amb_kill",::aud_incin_amb_kill);
	soundscripts\_snd::snd_register_message("aud_incin_flame_loop",::aud_incin_flame_loop);
	soundscripts\_snd::snd_register_message("incineration_escape_logic",::incineration_escape_logic);
	soundscripts\_snd::snd_register_message("aud_incin_after",::aud_incin_after);
	soundscripts\_snd::snd_register_message("aud_incin_after_loop1",::aud_incin_after_loop1);
	soundscripts\_snd::snd_register_message("start_outdoor_alarms",::start_post_courtyard_ext_alarms);
	soundscripts\_snd::snd_register_message("stop_post_courtyard_ext_alarms_2",::stop_post_courtyard_ext_alarms_2);
	soundscripts\_snd::snd_register_message("aud_heli_battle_flyover",::aud_heli_battle_flyover);
	soundscripts\_snd::snd_register_message("aud_heli_manticore_flyover",::aud_heli_manticore_flyover);
	soundscripts\_snd::snd_register_message("aud_manticore_crane",::aud_manticore_crane);
	soundscripts\_snd::snd_register_message("aud_cap_escape_to_heli_truck_1",::aud_cap_escape_to_heli_truck_1);
	soundscripts\_snd::snd_register_message("aud_cap_escape_to_heli_truck_2",::aud_cap_escape_to_heli_truck_2);
	soundscripts\_snd::snd_register_message("aud_wakeup_mech_cooldown_pings",::aud_wakeup_mech_cooldown_pings);
	soundscripts\_snd::snd_register_message("aud_spark_1",::aud_spark_1);
	soundscripts\_snd::snd_register_message("aud_spark_2",::aud_spark_2);
	soundscripts\_snd::snd_register_message("aud_spark_3",::aud_spark_3);
	soundscripts\_snd::snd_register_message("aud_spark_4",::aud_spark_4);
	soundscripts\_snd::snd_register_message("aud_spark_5",::aud_spark_5);
	soundscripts\_snd::snd_register_message("aud_wakeup_mix",::aud_wakeup_mix);
	soundscripts\_snd::snd_register_message("start_mech",::start_mech);
	soundscripts\_snd::snd_register_message("aud_mech_jump",::aud_mech_jump);
	soundscripts\_snd::snd_register_message("aud_mech_trucks_enter",::aud_mech_trucks_enter);
	soundscripts\_snd::snd_register_message("aud_mech1_bg_truck",::aud_mech1_bg_truck);
	soundscripts\_snd::snd_register_message("vrap_explode",::vrap_explode);
	soundscripts\_snd::snd_register_message("aud_mech_crush_guy",::aud_mech_crush_guy);
	soundscripts\_snd::snd_register_message("aud_mech_panic_walla_watcher",::aud_mech_panic_walla_watcher);
	soundscripts\_snd::snd_register_message("aud_stop_mech_panic_walla_watcher",::aud_stop_mech_panic_walla_watcher);
	soundscripts\_snd::snd_register_message("aud_plr_inside_mech",::aud_plr_inside_mech);
	soundscripts\_snd::snd_register_message("aud_mech_missile_fire",::aud_mech_missile_fire);
	soundscripts\_snd::snd_register_message("mech_wall_smash",::mech_wall_smash);
	soundscripts\_snd::snd_register_message("mech_wall_smash_3d",::mech_wall_smash_3d);
	soundscripts\_snd::snd_register_message("mech_warehouse_door_smash",::mech_warehouse_door_smash);
	soundscripts\_snd::snd_register_message("mech_scan",::mech_scan);
	soundscripts\_snd::snd_register_message("mech_weapon_offline",::mech_weapon_offline);
	soundscripts\_snd::snd_register_message("aud_warehouse_roof_machines_line",::aud_warehouse_roof_machines_line);
	soundscripts\_snd::snd_register_message("aud_warehouse_roof_machines",::aud_warehouse_roof_machines);
	soundscripts\_snd::snd_register_message("aud_warehouse_mech_lift",::aud_warehouse_mech_lift);
	soundscripts\_snd::snd_register_message("aud_warehouse_mech_lift_alarm",::aud_warehouse_mech_lift_alarm);
	soundscripts\_snd::snd_register_message("aud_warehouse_mech_lift_vo",::aud_warehouse_mech_lift_vo);
	soundscripts\_snd::snd_register_message("scn_cap_mech_door_closes",::scn_cap_mech_door_closes);
	soundscripts\_snd::snd_register_message("scn_cap_mech_door_grab",::scn_cap_mech_door_grab);
	soundscripts\_snd::snd_register_message("aud_mech_obj_move",::aud_mech_obj_move);
	soundscripts\_snd::snd_register_message("aud_mech_obj_move_wait",::aud_mech_obj_move_wait);
	soundscripts\_snd::snd_register_message("aud_mech_obj_move_end",::aud_mech_obj_move_end);
	soundscripts\_snd::snd_register_message("aud_door",::aud_door);
	soundscripts\_snd::snd_register_message("aud_heli_escape_idle_sfx",::aud_heli_escape_idle_sfx);
	soundscripts\_snd::snd_register_message("aud_crash_wakeup_sfx",::aud_crash_wakeup_sfx);
}

//Function Number: 10
zone_handler(param_00,param_01)
{
	switch(param_00)
	{
	}
}

//Function Number: 11
music_handler(param_00,param_01)
{
	switch(param_00)
	{
		case "mus_captured_intro":
			soundscripts\_audio_music::mus_play("mus_captured_intro",4);
			common_scripts\utility::flag_wait("flag_stop_intro_music");
			wait(3);
			soundscripts\_audio_music::mus_stop(4);
			break;

		case "mus_captured_trolley":
			wait(0.7);
			soundscripts\_audio::aud_set_music_submix(1.5,0);
			soundscripts\_audio_music::mus_play("mus_captured_trolley",0);
			wait(13);
			soundscripts\_audio::aud_set_music_submix(1,4);
			break;

		case "mus_captured_interrogation":
			wait(0.3);
			soundscripts\_audio_music::mus_play("mus_captured_interrogation_pt1",0);
			common_scripts\utility::flag_wait("flag_start_interrogation_music_pt2");
			wait(0.5);
			soundscripts\_audio_music::mus_play("mus_captured_interrogation_pt2",0,20);
			wait(18);
			soundscripts\_audio::aud_set_music_submix(10,3);
			wait(12);
			soundscripts\_audio::aud_set_music_submix(1,3);
			break;

		case "mus_captured_escape":
			wait(9.5);
			soundscripts\_audio_music::mus_play("mus_captured_escape",0);
			break;

		case "mus_captured_escape_end":
			maps\_utility::music_stop(3);
			break;

		case "mus_captured_test_chamber":
			soundscripts\_audio_music::mus_play("mus_captured_test_chamber",0);
			break;

		case "mus_captured_halls":
			wait(1.5);
			soundscripts\_audio_music::mus_play("mus_captured_halls",0);
			break;

		case "mus_captured_halls_end":
			common_scripts\utility::flag_wait("flag_ah_combat_done");
			maps\_utility::music_stop(4);
			soundscripts\_audio_zone_manager::azm_start_zone("morgue_2",1);
			break;

		case "mus_captured_incinerator":
			soundscripts\_audio_music::mus_play("mus_captured_incinerator",0);
			break;

		case "mus_captured_mech":
			wait(2);
			soundscripts\_audio_music::mus_play("mus_captured_mech",0);
			break;

		case "mus_captured_mech_end":
			soundscripts\_audio_music::mus_play("mus_captured_mech_end",1);
			break;

		default:
			soundscripts\_audio::aud_print_warning("\tMUSIC MESSAGE NOT HANDLED: " + param_00);
			break;
	}
}

//Function Number: 12
start_intro_drive()
{
	soundscripts\_audio_zone_manager::azm_start_zone("intro_drive",1);
}

//Function Number: 13
start_s1_elevator()
{
	soundscripts\_audio_zone_manager::azm_start_zone("s2_walk",1);
}

//Function Number: 14
start_s2_walk()
{
	soundscripts\_audio_zone_manager::azm_start_zone("s1_elevator",1);
}

//Function Number: 15
start_s2_elevator()
{
	soundscripts\_audio_zone_manager::azm_start_zone("s2_elevator",1);
}

//Function Number: 16
start_escape()
{
	soundscripts\_audio_zone_manager::azm_start_zone("pre_stair_hall",1);
}

//Function Number: 17
start_test_chamber()
{
	soundscripts\_audio_zone_manager::azm_start_zone("pre_stair_hall",1);
}

//Function Number: 18
start_halls_to_autopsy()
{
	soundscripts\_audio_zone_manager::azm_start_zone("test_chamber",1);
}

//Function Number: 19
start_trolley()
{
	soundscripts\_audio_zone_manager::azm_start_zone("trolley",1);
}

//Function Number: 20
start_incinerator()
{
	soundscripts\_snd::snd_message("aud_incin_blackout");
}

//Function Number: 21
start_battle_to_heli()
{
	soundscripts\_audio_zone_manager::azm_start_zone("pre_run_to_heli",1);
}

//Function Number: 22
scn_truck_sounds()
{
	level.player soundscripts\_snd_playsound::snd_play_2d("scn_intro_drive_lr");
}

//Function Number: 23
aud_intro_truck_gate(param_00)
{
	level.player soundscripts\_snd_playsound::snd_play_2d("scn_intro_truck_underpass_lr");
}

//Function Number: 24
aud_intro_truck_passby_01(param_00)
{
	level.player soundscripts\_snd_playsound::snd_play_2d("scn_intro_truck_passby_01");
}

//Function Number: 25
aud_intro_truck_passby_02(param_00)
{
	level.player soundscripts\_snd_playsound::snd_play_2d("scn_intro_truck_passby_02");
	soundscripts\_snd::snd_message("aud_intro_caravan_mute");
}

//Function Number: 26
aud_intro_truck_stop(param_00)
{
	level.player soundscripts\_snd_playsound::snd_play_2d("scn_intro_drive_stop_lr");
}

//Function Number: 27
aud_intro_heli_flyover()
{
}

//Function Number: 28
aud_intro_caravan_passby()
{
	wait(7);
	if(!common_scripts\utility::flag("flag_entered_s1elevator"))
	{
		soundscripts\_snd_playsound::snd_play_at("scn_intro_truck_caravan_passby",(5073,-4905,61));
	}
}

//Function Number: 29
aud_intro_caravan_mute()
{
	soundscripts\_audio_mix_manager::mm_add_submix("intro_caravan_mute");
}

//Function Number: 30
aud_intro_caravan_unmute()
{
	soundscripts\_audio_mix_manager::mm_clear_submix("intro_caravan_mute",2);
	common_scripts\utility::flag_wait("flag_entered_s1elevator");
	soundscripts\_audio_mix_manager::mm_add_submix("intro_caravan_mute");
	wait(10);
	soundscripts\_audio_mix_manager::mm_clear_submix("intro_caravan_mute");
}

//Function Number: 31
aud_intro_to_elev_walla()
{
	wait(16);
	soundscripts\_snd_playsound::snd_play_loop_at("emt_intro_to_elev_walla_lp",(4719,-4602,147),"kill_intro_to_elev_walla",2,2);
}

//Function Number: 32
aud_mech_idle_sfx()
{
	var_00 = getent("aud_mech_idle_sfx","targetname");
	var_00 waittill("trigger");
	soundscripts\_snd_playsound::snd_play_at("scn_intro_mech_idle",(5429,-5418,36));
}

//Function Number: 33
entrance_alarm()
{
}

//Function Number: 34
entrance_alarm_fast2()
{
}

//Function Number: 35
entrance_alarm_fast()
{
	soundscripts\_snd_playsound::snd_play_at("captured_entrance_alarm",(5409,-5208,299));
}

//Function Number: 36
entrance_vo_01()
{
	wait(11);
	soundscripts\_snd_playsound::snd_play_at("cap_ls1_nowenteringgateb",(3893,-1872,287));
	wait(0.2);
	soundscripts\_snd_playsound::snd_play_at("cap_ls1_nowenteringgateb",(3561,-2057,287));
	wait(8.8);
	soundscripts\_snd_playsound::snd_play_at("cap_ls1_clearentrypermitted",(3893,-1872,287));
}

//Function Number: 37
entrance_vo_03()
{
	wait(12.5);
	wait(0.2);
	soundscripts\_snd_playsound::snd_play_at("cap_ls1_compliancewithcamp",(6368,-3196,604));
	wait(6.2);
	wait(0.2);
	soundscripts\_snd_playsound::snd_play_at("cap_ls1_noncompliancewith2_alt01",(6368,-3196,604));
	wait(7.2);
	soundscripts\_snd_playsound::snd_play_at("cap_ls1_failuretoreportnon_alt01",(4188,-3173,422));
	wait(0.2);
	soundscripts\_snd_playsound::snd_play_at("cap_ls1_failuretoreportnon_alt01",(6368,-3196,604));
}

//Function Number: 38
aud_stop_cormack_foley()
{
	wait(1.5);
	level notify("stop_cormack_foley");
	soundscripts\_audio_mix_manager::mm_add_submix("s2_walk_pre_start");
}

//Function Number: 39
aud_ambient_animations(param_00)
{
	switch(param_00)
	{
		case "cap_s2_walk_stake_inmate_01":
			soundscripts\_snd::snd_message("aud_s2walk_yard_prisoners_whimpering");
			break;

		case "cap_s2_walk_pitexecutions_01":
			break;

		case "cap_s2_walk_beating_prisoner2":
			soundscripts\_snd::snd_message("aud_s2walk_prisoner_2_beating");
			break;
	}
}

//Function Number: 40
s2_elevator_door_open_top()
{
	soundscripts\_snd_playsound::snd_play_linked("scn_cap_elevator_open");
}

//Function Number: 41
s2_elevator_ride_down()
{
	level notify("kill_intro_to_elev_walla");
	soundscripts\_snd_playsound::snd_play_delayed_2d("scn_cap_intro_elevator_ride_lr",2.669,undefined,"s2_elevator_stop_sfx");
	soundscripts\_snd_playsound::snd_play_delayed_2d("scn_cap_intro_elevator_ride_mtl_lr",7.642,undefined,"s2_elevator_stop_sfx");
}

//Function Number: 42
s2_elevator_door_open()
{
	common_scripts\utility::flag_set("flag_stop_intro_music");
	thread s2_walk_footsteps();
	soundscripts\_audio_mix_manager::mm_clear_submix("s2_walk_pre_start");
}

//Function Number: 43
s2_walk_footsteps()
{
	level.aud.s2_walk_footsteps = 1;
	soundscripts\_audio_mix_manager::mm_add_submix("s2_walk_footsteps");
	common_scripts\utility::flag_wait("flag_s2walk_end");
	level.aud.s2_walk_footsteps = 0;
	soundscripts\_audio_mix_manager::mm_clear_submix("s2_walk_footsteps");
}

//Function Number: 44
s2_elevator_door_close()
{
	soundscripts\_snd_playsound::snd_play_delayed_at("scn_cap_elevator_open",(5481,-5808,-548),4);
}

//Function Number: 45
s2_prison_amb()
{
	var_00 = getent("s2_cell_prisoner_trigger_on","targetname");
	var_00 waittill("trigger");
}

//Function Number: 46
aud_plr_hit()
{
	level.player soundscripts\_snd_playsound::snd_play_2d("scn_plr_hit_s2walk");
}

//Function Number: 47
aud_plr_hit_vo_move_forward()
{
}

//Function Number: 48
aud_plr_hit_vo_move_back()
{
}

//Function Number: 49
aud_plr_hit_vo_look()
{
}

//Function Number: 50
aud_plr_hit_vo_line()
{
}

//Function Number: 51
s2_walk_vo_execution()
{
	wait(6);
	soundscripts\_snd::snd_message("s2_walk_execution_PA");
	wait(17);
	wait(4.75);
	soundscripts\_snd::snd_message("aud_s2walk_execution_fire");
}

//Function Number: 52
s2_walk_execution_pa()
{
	soundscripts\_snd_playsound::snd_play_at("cap_gr6_prisonerslineup",(6681,-6169,-375));
	soundscripts\_snd_playsound::snd_play_delayed_at("cap_gr6_prisonerslineup",(7258,-7272,-375),0.2);
	wait(5.18);
	soundscripts\_snd_playsound::snd_play_at("cap_gr6_stepdownintothe",(6681,-6169,-375));
	soundscripts\_snd_playsound::snd_play_delayed_at("cap_gr6_stepdownintothe",(7258,-7272,-375),0.2);
	wait(5);
	soundscripts\_snd_playsound::snd_play_at("cap_gr6_liefacedown",(6681,-6169,-375));
	soundscripts\_snd_playsound::snd_play_delayed_at("cap_gr6_liefacedown",(7258,-7272,-375),0.2);
	wait(3.08);
	soundscripts\_snd_playsound::snd_play_at("cap_gr6_facesdown",(6681,-6169,-375));
	soundscripts\_snd_playsound::snd_play_delayed_at("cap_gr6_facesdown",(7258,-7272,-375),0.2);
	wait(3.02);
	soundscripts\_snd_playsound::snd_play_at("cap_gr6_nobursts",(6681,-6169,-375));
	soundscripts\_snd_playsound::snd_play_delayed_at("cap_gr6_nobursts",(7258,-7272,-375),0.2);
	wait(1.18);
	soundscripts\_snd_playsound::snd_play_at("cap_gr6_singleselect",(6681,-6169,-375));
	soundscripts\_snd_playsound::snd_play_delayed_at("cap_gr6_singleselect",(7258,-7272,-375),0.2);
	wait(3.2);
	soundscripts\_snd_playsound::snd_play_at("cap_gr6_fire",(6681,-6169,-375));
	soundscripts\_snd_playsound::snd_play_delayed_at("cap_gr6_fire",(7258,-7272,-375),0.2);
	wait(2.14);
	soundscripts\_snd_playsound::snd_play_at("cap_gr6_nextgrouplineup",(6681,-6169,-375));
	soundscripts\_snd_playsound::snd_play_delayed_at("cap_gr6_nextgrouplineup",(7258,-7272,-375),0.2);
	wait(2.1);
	soundscripts\_snd_playsound::snd_play_at("cap_gr6_stepdownintothe2",(6681,-6169,-375));
	soundscripts\_snd_playsound::snd_play_delayed_at("cap_gr6_stepdownintothe2",(7258,-7272,-375),0.2);
	wait(3.04);
	soundscripts\_snd_playsound::snd_play_at("cap_gr6_shouldertoshoulder2",(6681,-6169,-375));
	soundscripts\_snd_playsound::snd_play_delayed_at("cap_gr6_shouldertoshoulder2",(7258,-7272,-375),0.2);
	wait(3.1);
	soundscripts\_snd_playsound::snd_play_at("cap_gr6_facedown2",(6681,-6169,-375));
	soundscripts\_snd_playsound::snd_play_delayed_at("cap_gr6_facedown2",(7258,-7272,-375),0.2);
	wait(3.1);
	soundscripts\_snd_playsound::snd_play_at("cap_gr6_prisonerslineup2",(6681,-6169,-375));
	soundscripts\_snd_playsound::snd_play_delayed_at("cap_gr6_prisonerslineup2",(7258,-7272,-375),0.2);
	wait(5.2);
	soundscripts\_snd_playsound::snd_play_at("cap_gr6_stepdownintothe3",(6681,-6169,-375));
	soundscripts\_snd_playsound::snd_play_delayed_at("cap_gr6_stepdownintothe3",(7258,-7272,-375),0.2);
	common_scripts\utility::flag_wait("flag_s2walk_near_end");
	wait(4);
	soundscripts\_snd_playsound::snd_play_at("cap_gr6_liefacedown2",(6681,-6169,-375));
	soundscripts\_snd_playsound::snd_play_delayed_at("cap_gr6_liefacedown2",(7258,-7272,-375),0.2);
}

//Function Number: 53
aud_s2walk_trigger_start()
{
	var_00 = getent("s2walk_celldoor_trigger","targetname");
	var_00 waittill("trigger");
	soundscripts\_snd::snd_message("aud_s2walk_cells_foley_mix");
	soundscripts\_audio_zone_manager::azm_start_zone("s2_walk_cell",0.1);
	wait(1.5);
	soundscripts\_snd::snd_message("aud_s2walk_door_close");
}

//Function Number: 54
aud_s2walk_emitters()
{
	var_00 = soundscripts\_snd_playsound::snd_play_loop_at("scn_s2walk_fire_trench",(6691,-7051,-592),"snd_fire_trench_clear",0,3.5);
	wait(2);
	soundscripts\_snd_playsound::snd_play_at("emt_buzzer",(6180,-5970,-504));
	soundscripts\_snd_playsound::snd_play_loop_at("emt_cap_s2walk_yard_walla_lp",(6732,-6787,-564),"prisoners_death");
	level notify("start_helicopter_fly");
	soundscripts\_snd_playsound::snd_play_at("scn_captured_s2_heli_flyover",(6133,-6375,-387));
	wait(5.7);
	soundscripts\_snd::snd_message("aud_s2walk_alarm_tone_lp");
	wait(2.7);
	wait(5.8);
	wait(4.5);
	wait(1.3);
	soundscripts\_snd_playsound::snd_play_at("emt_buzzer",(5960,-6926,-512));
	thread snd_trench_fire_off(var_00);
	wait(22.5);
	soundscripts\_snd::snd_message("aud_s2walk_flyby_1");
}

//Function Number: 55
aud_s2walk_temp_guard_vo(param_00)
{
}

//Function Number: 56
snd_trench_fire_off(param_00)
{
	wait(6);
	level notify("snd_fire_trench_clear");
}

//Function Number: 57
aud_s2walk_flyby_1()
{
	level notify("start_helicopter_fly");
	level.player playsound("scn_captured_s2_warbird_flyover");
	wait(2);
	level.player playsound("scn_captured_s2_heli_dust_lr");
}

//Function Number: 58
aud_s2walk_alarm_tone_lp()
{
	soundscripts\_snd_playsound::snd_play_loop_at("scn_captured_s2_alarm_tone",(6160,-7477,-358),"snd_alarm_tone_stop",4,0.2);
	wait(17);
	level notify("snd_alarm_tone_stop");
}

//Function Number: 59
aud_s2walk_prisoner_2_beating()
{
	soundscripts\_snd_playsound::snd_play_delayed_at("cap_pr10_oof",(6096.3,-6252.4,-554.8),14.8);
	soundscripts\_snd_playsound::snd_play_delayed_at("cap_pr10_argh",(6096.3,-6252.4,-554.8),16);
}

//Function Number: 60
aud_s2walk_execution_kneeling_prisoners()
{
	wait(2);
}

//Function Number: 61
aud_s2walk_execution_fire()
{
	level notify("prisoners_death");
	soundscripts\_snd_playsound::snd_play_at("scn_captured_s2_execution",(6645,-6535,-550));
}

//Function Number: 62
aud_s2walk_door_open()
{
	soundscripts\_snd_playsound::snd_play_linked("scn_captured_s2_door_open");
}

//Function Number: 63
aud_s2walk_door_close()
{
	level.player playsound("scn_captured_s2_door_close");
}

//Function Number: 64
aud_s2walk_loudspeaker2_line1()
{
	soundscripts\_snd_playsound::snd_play_delayed_at("cap_ls2_proceedinorderby",(5485,-6287.7,-391),4);
}

//Function Number: 65
aud_s2walk_loudspeaker2_line2()
{
	soundscripts\_snd_playsound::snd_play_at("cap_ls2_proceedinorderby2",(5191,-7727,-404));
	soundscripts\_snd_playsound::snd_play_delayed_at("cap_ls2_proceedinorderby2",(5547,-7717,-415),0.2);
}

//Function Number: 66
aud_s2walk_guard_radios()
{
	wait(6);
	soundscripts\_snd_playsound::snd_play_at("emt_cap_s2walk_guard_radiowalla_1",(6026,-5942,-556));
	wait(7);
	soundscripts\_snd_playsound::snd_play_at("emt_cap_s2walk_guard_radiowalla_2",(6118,-6172,-556));
	wait(29);
	soundscripts\_snd_playsound::snd_play_at("emt_cap_s2walk_guard_radiowalla_4",(5525,-6913,-393));
}

//Function Number: 67
aud_s2walk_cell_prisoners(param_00)
{
	if(level.aud.cell_prisoners_trig == 0)
	{
		level.aud.cell_prisoners_trig = 1;
		soundscripts\_snd_playsound::snd_play_loop_at("emt_cap_s2walk_cell_walla_lp",(5586.6,-6934.24,-548.2));
		soundscripts\_snd_playsound::snd_play_at("emt_s2_cell_01_l",(5861,-6998,-545));
		soundscripts\_snd_playsound::snd_play_delayed_at("emt_s2_cell_01_R",(5855,-6854,-545),4.114);
		soundscripts\_snd_playsound::snd_play_delayed_at("emt_cap_s2walk_cellprisoner_1",(5855,-6854,-545),2.3);
		soundscripts\_snd_playsound::snd_play_delayed_at("emt_s2_cell_02_R",(5733,-6850,-545),6.3);
		soundscripts\_snd_playsound::snd_play_delayed_at("emt_cap_s2walk_cellprisoner_2",(5733,-6850,-545),6.3);
		soundscripts\_snd_playsound::snd_play_delayed_at("emt_s2_cell_02_l",(5613,-7028,-545),5);
		soundscripts\_snd_playsound::snd_play_delayed_at("emt_s2_cell_03_R",(5603,-6856,-545),7.9);
		soundscripts\_snd_playsound::snd_play_delayed_at("emt_cap_s2walk_cellprisoner_3",(5603,-6856,-545),7.9);
		soundscripts\_snd_playsound::snd_play_delayed_at("emt_s2_cell_03_l",(5492,-7002,-545),12.3);
		soundscripts\_snd_playsound::snd_play_delayed_at("emt_cap_s2walk_cellprisoner_4",(5492,-7002,-545),12.3);
		wait(12);
		soundscripts\_audio_mix_manager::mm_add_submix("s2walk_cells_walla_down");
	}
}

//Function Number: 68
aud_s2walk_guard_hip_radio(param_00)
{
	param_00 soundscripts\_snd_playsound::snd_play_linked("cap_gr9_copythatprisoners");
}

//Function Number: 69
aud_s2walk_cells_foley_mix()
{
	wait(2.5);
	soundscripts\_audio_mix_manager::mm_add_submix("s2walk_cells_foley");
}

//Function Number: 70
aud_s2walk_clear_foley_mix()
{
	soundscripts\_audio_mix_manager::mm_clear_submix("s2walk_cells_foley");
	soundscripts\_audio_mix_manager::mm_clear_submix("s2walk_cells_walla_down");
}

//Function Number: 71
aud_s2walk_yard_prisoners_whimpering()
{
	wait(2);
	soundscripts\_snd_playsound::snd_play_at("cap_pr7_painfulgroan",(5200,-7433.2,-587.2));
	soundscripts\_snd_playsound::snd_play_delayed_at("cap_pr8_pleasewater",(5533.5,-7558.5,-587.2),1);
	soundscripts\_snd_playsound::snd_play_delayed_at("cap_pr9_coughgroan",(5676,-7549.9,-601.5),1);
}

//Function Number: 72
aud_cap_s2_trolley_sfx_01(param_00)
{
	level.player soundscripts\_snd_playsound::snd_play_2d("scn_captured_trolley_01");
}

//Function Number: 73
aud_cap_s2_trolley_sfx_02(param_00)
{
	level.player soundscripts\_snd_playsound::snd_play_2d("scn_captured_trolley_02");
	soundscripts\_audio_mix_manager::mm_add_submix("trolley_mix");
}

//Function Number: 74
aud_cap_s2_trolley_sfx_03(param_00)
{
	level.player soundscripts\_snd_playsound::snd_play_2d("scn_captured_trolley_03");
	wait(1.5);
	soundscripts\_audio_mix_manager::mm_clear_submix("trolley_mix");
	soundscripts\_audio_mix_manager::mm_add_submix("trolley_mix_2");
}

//Function Number: 75
aud_cap_s2_trolley_sfx_03_crk(param_00)
{
	param_00 soundscripts\_snd_playsound::snd_play_linked("scn_captured_trolley_03_crk");
}

//Function Number: 76
aud_cap_s2_trolley_sfx_04(param_00)
{
	level.player soundscripts\_snd_playsound::snd_play_2d("scn_captured_trolley_04");
}

//Function Number: 77
aud_cap_s2_trolley_sfx_05(param_00)
{
	level.player soundscripts\_snd_playsound::snd_play_2d("scn_captured_trolley_05");
}

//Function Number: 78
aud_cap_s2_trolley_sfx_06(param_00)
{
	level.player soundscripts\_snd_playsound::snd_play_2d("scn_captured_trolley_06");
}

//Function Number: 79
aud_cap_s2_trolley_sfx_07(param_00)
{
	level.player soundscripts\_snd_playsound::snd_play_2d("scn_captured_trolley_07");
	wait(0.5);
	soundscripts\_audio_mix_manager::mm_clear_submix("trolley_mix_2");
	soundscripts\_audio_mix_manager::mm_add_submix("trolley_mix_3");
}

//Function Number: 80
aud_cap_s2_trolley_sfx_08(param_00)
{
	level.player soundscripts\_snd_playsound::snd_play_2d("scn_captured_trolley_08");
}

//Function Number: 81
aud_cap_s2_trolley_sfx_09(param_00)
{
	level.player soundscripts\_snd_playsound::snd_play_2d("scn_captured_trolley_09");
}

//Function Number: 82
aud_cap_s2_trolley_sfx_10(param_00)
{
	level.player soundscripts\_snd_playsound::snd_play_2d("scn_captured_trolley_10");
	wait(7);
	soundscripts\_audio_mix_manager::mm_clear_submix("trolley_mix_3",1);
}

//Function Number: 83
aud_limp_on()
{
	level.aud.limp_footsteps = 1;
	soundscripts\_audio_mix_manager::mm_add_submix("limp_footsteps");
}

//Function Number: 84
aud_limp_exo()
{
	level.aud.limp_footsteps = 1;
	soundscripts\_audio_mix_manager::mm_clear_submix("limp_footsteps");
	wait(0.5);
	soundscripts\_audio_mix_manager::mm_add_submix("limp_footsteps_exo");
}

//Function Number: 85
aud_limp_off()
{
	level.aud.limp_footsteps = 0;
	soundscripts\_audio_mix_manager::mm_clear_submix("limp_footsteps_exo");
}

//Function Number: 86
aud_rescue_sfx_a(param_00)
{
	level.player soundscripts\_snd_playsound::snd_play_2d("scn_captured_rescue_a_lr");
}

//Function Number: 87
aud_rescue_sfx_b(param_00)
{
	level.player soundscripts\_snd_playsound::snd_play_2d("scn_captured_rescue_b_lr");
}

//Function Number: 88
aud_rescue_sfx_c(param_00)
{
	level.player soundscripts\_snd_playsound::snd_play_2d("scn_captured_rescue_c_lr");
}

//Function Number: 89
aud_rescue_sfx_d(param_00)
{
	level.player soundscripts\_snd_playsound::snd_play_2d("scn_captured_rescue_d_lr");
}

//Function Number: 90
aud_rescue_sfx_e(param_00)
{
	level.player soundscripts\_snd_playsound::snd_play_2d("scn_captured_rescue_e_lr");
}

//Function Number: 91
aud_rescue_sfx_f(param_00)
{
	level.player soundscripts\_snd_playsound::snd_play_2d("scn_captured_rescue_f_lr");
}

//Function Number: 92
aud_rescue_sfx_g(param_00)
{
	level.player soundscripts\_snd_playsound::snd_play_2d("scn_captured_rescue_g_lr");
}

//Function Number: 93
aud_rescue_drone(param_00)
{
	soundscripts\_audio_zone_manager::azm_start_zone("escape",3);
	soundscripts\_audio_mix_manager::mm_add_submix("rescue_vign");
	wait(3);
	level.player soundscripts\_snd_playsound::snd_play_2d("scn_captured_rescue_low_lr");
	wait(33);
	soundscripts\_audio_mix_manager::mm_clear_submix("rescue_vign");
}

//Function Number: 94
aud_red_light()
{
	wait(1.3);
	soundscripts\_snd_playsound::snd_play_at("scn_cap_esc_red_light",(5246,-10374,-1679));
}

//Function Number: 95
aud_stop_headspace_ambience()
{
	wait(7);
	soundscripts\_audio_zone_manager::azm_set_zone_streamed_ambience("body_hall","amb_captured_hallways_lr",4);
	soundscripts\_audio_zone_manager::azm_set_zone_reverb("body_hall","captured_hall",1);
}

//Function Number: 96
aud_play_horror_ambience()
{
	soundscripts\_audio_zone_manager::azm_set_zone_streamed_ambience("decontam","amb_captured_horror_lr",0.5);
}

//Function Number: 97
aud_stop_horror_ambience()
{
	soundscripts\_audio_zone_manager::azm_set_zone_streamed_ambience("test_chamber","amb_captured_hallways_lr",5);
}

//Function Number: 98
aud_escape_doctor_bodybag()
{
	soundscripts\_snd_playsound::snd_play_at("scn_cap_esc_door_open",(5273,-10314,-1708));
	wait(1.45);
	soundscripts\_snd_playsound::snd_play_at("scn_cap_esc_doctor_bodybag",(5273,-10314,-1708));
	wait(6.1);
	soundscripts\_snd_playsound::snd_play_at("scn_cap_esc_door_shut",(5273,-10314,-1708));
}

//Function Number: 99
aud_s3escape_doctor_radio(param_00)
{
	param_00 soundscripts\_snd_playsound::snd_play_linked("emt_cap_escape_doctor_radiowalla","doctor_door_closed");
	wait(7.35);
	level notify("doctor_door_closed");
}

//Function Number: 100
aud_escape_give_gun_exo()
{
	maps\_utility::play_sound_on_entity("scn_cap_esc_give_gun");
}

//Function Number: 101
aud_onearm_weapon_swap(param_00)
{
	if(param_00 == "iw5_titan45onearm_sp_xmags")
	{
		level.player playsound("wpn_handgun_raise_plr_onearm");
		return;
	}

	level.player playsound("wpn_sml_raise_plr_onearm");
}

//Function Number: 102
aud_cap_45_onearm_toss()
{
	level.player playsound("wpn_handgun_onearm_toss");
}

//Function Number: 103
aud_cap_sml_onearm_toss()
{
	level.player playsound("wpn_sml_onearm_toss");
}

//Function Number: 104
aud_morgue_bodybag_line_emt()
{
	var_00 = "emt_morgue_bag_mvmt_lp";
	thread soundscripts\_audio::aud_play_line_emitter("moving_bags_01",var_00,(5328,-13249,-1527),(4785,-13249,-1527));
	thread soundscripts\_audio::aud_play_line_emitter("moving_bags_02",var_00,(5328,-13301,-1527),(5328,-14645,-1527));
	thread soundscripts\_audio::aud_play_line_emitter("moving_bags_03",var_00,(4640,-12019,-1527),(4640,-12550,-1527));
}

//Function Number: 105
aud_morgue_bodybag_doors(param_00)
{
	if(param_00 == "open")
	{
		var_01 = "scn_morgue_bb_door_open";
	}
	else
	{
		var_01 = "scn_morgue_bb_door_close";
	}

	var_02 = 0;
	foreach(var_04 in self.doors)
	{
		var_02++;
		if(var_02 % 2 == 0)
		{
			soundscripts\_snd_playsound::snd_play_at(var_01,var_04.open);
		}
	}
}

//Function Number: 106
aud_escape_guard_takedown_door()
{
	soundscripts\_snd_playsound::snd_play_at("scn_cap_ally_guard_door",(5250,-10490,-1708));
}

//Function Number: 107
aud_escape_keycard(param_00)
{
	switch(param_00)
	{
		case "control_room":
			soundscripts\_snd_playsound::snd_play_at("scn_cap_keycard_swipe",(5012,-10738,-1708));
			wait(0.2);
			soundscripts\_snd_playsound::snd_play_at("scn_cap_keycard_accept",(5012,-10738,-1708));
			break;

		case "exit_door":
			soundscripts\_snd_playsound::snd_play_at("scn_cap_keycard_swipe",(4438,-10740,-1708));
			wait(0.2);
			soundscripts\_snd_playsound::snd_play_at("scn_cap_keycard_accept",(4438,-10740,-1708));
			break;

		case "tc_stairs_door":
			soundscripts\_snd_playsound::snd_play_at("scn_cap_keycard_swipe",(3890,-10702,-1708));
			wait(0.2);
			soundscripts\_snd_playsound::snd_play_at("scn_cap_keycard_accept",(3890,-10702,-1708));
			break;
	}
}

//Function Number: 108
aud_morgue_computer_door_entry_sfx()
{
	soundscripts\_snd_playsound::snd_play_at("scn_morgue_comp_beep_01",(5469,-14436,-1584));
	wait(0.4);
	soundscripts\_snd_playsound::snd_play_at("scn_morgue_comp_beep_02",(5469,-14436,-1584));
}

//Function Number: 109
aud_separation_logic()
{
	soundscripts\_snd_playsound::snd_play_2d("scn_separ_console_plr");
}

//Function Number: 110
aud_separation_elevator()
{
	wait(0.5);
	soundscripts\_snd_playsound::snd_play_at("scn_separ_elevator_open",(4731,-10977,-1697));
}

//Function Number: 111
aud_separation_door()
{
	soundscripts\_snd_playsound::snd_play_at("scn_separ_large_door_close",(4754,-10874,-1697));
}

//Function Number: 112
aud_observation_guard_radio()
{
	wait(14);
	soundscripts\_snd_playsound::snd_play_at("emt_cap_test_chamber_radiowalla",(3998,-11305,-1516));
}

//Function Number: 113
aud_zap_scene()
{
	soundscripts\_snd_playsound::snd_play_at("scn_cap_zap_door_close",(4368.5,-12011.9,-1611.9));
	wait(1.85);
	soundscripts\_snd_playsound::snd_play_at("scn_cap_zap_glow1",(4439,-11943,-1595));
	soundscripts\_snd_playsound::snd_play_at("scn_cap_zap_glow2",(4295,-11937,-1595));
	soundscripts\_snd_playsound::snd_play_2d("scn_cap_zap");
	thread aud_zap_logic_change();
	soundscripts\_snd_playsound::snd_play_delayed_at("scn_cap_zap_door_open",(4363.1,-11895.5,-1611.9),4.1);
	soundscripts\_snd_playsound::snd_play_delayed_at("cap_sri_sequencing",(4370,-11919,-1553),0.8);
	soundscripts\_snd_playsound::snd_play_delayed_at("cap_sri_cleared",(4370,-11919,-1553),3.5);
	level notify("stop_courtyard_alarms");
	soundscripts\_snd::snd_message("aud_alarm_submix");
}

//Function Number: 114
aud_zap_logic_change()
{
	wait(2);
	soundscripts\_audio_zone_manager::azm_start_zone("decontam_headspace",0);
	wait(1);
	soundscripts\_audio_zone_manager::azm_start_zone("test_chamber",6);
	wait(1);
	soundscripts\_snd::snd_music_message("mus_captured_test_chamber");
	soundscripts\_snd::snd_message("aud_play_horror_ambience");
}

//Function Number: 115
aud_autopsy_knife_pry_door(param_00)
{
	if(param_00 == "handgun")
	{
		level.player soundscripts\_snd_playsound::snd_play_linked("scn_autopsy_door_knife_intro");
		level.player soundscripts\_snd_playsound::snd_play_linked("wpn_handgun_onearm_toss_autopsy");
		return;
	}

	level.player soundscripts\_snd_playsound::snd_play_linked("wpn_sml_onearm_toss_autopsy");
}

//Function Number: 116
aud_autopsy_entrance()
{
	soundscripts\_snd::snd_message("aud_autopsy_entrance_vo");
	level.ally soundscripts\_snd_playsound::snd_play_linked("scn_autopsy_entrance_foley");
	soundscripts\_snd_playsound::snd_play_delayed_at("scn_autopsy_entrance_doors",(5672,-14546,-1572),0.9);
	soundscripts\_snd_playsound::snd_play_delayed_at("scn_autopsy_door_r",(5708,-14633,-1572),2.6);
	soundscripts\_snd_playsound::snd_play_delayed_at("scn_autopsy_door_l",(5719,-14452,-1572),2.7);
	soundscripts\_snd_playsound::snd_play_delayed_at("scn_autopsy_entrance_punch",(5812,-14607,-1572),4.2);
	soundscripts\_snd_playsound::snd_play_delayed_at("scn_autopsy_sci_fall",(5812,-14607,-1572),4.5);
	soundscripts\_snd_playsound::snd_play_delayed_at("scn_autopsy_dist_table",(6388,-14634,-1572),5.8);
}

//Function Number: 117
aud_autopsy_entrance_vo()
{
	wait(2.2);
	soundscripts\_snd_playsound::snd_play_at("cap_sc1_ahhheytakeiteasy",(5812,-14607,-1572));
	soundscripts\_snd_playsound::snd_play_delayed_at("cap_sc2_ahhohmygod",(5898,-14849,-1572),3.5);
	soundscripts\_snd_playsound::snd_play_delayed_at("cap_sc3_ahhscaredreaction",(6079,-14577,-1572),3.2);
	soundscripts\_snd_playsound::snd_play_delayed_at("cap_sc5_ahhscaredreaction",(6394,-14861,-1572),3.5);
	soundscripts\_snd_playsound::snd_play_delayed_at("cap_sc4_ahhscaredreaction",(6383,-14634,-1572),3.5);
	soundscripts\_snd_playsound::snd_play_delayed_loop_at("cap_sc5_whimpering",10,0,(6394,-14861,-1572),"stop_mumbling");
	soundscripts\_snd_playsound::snd_play_delayed_loop_at("cap_sc4_whimpering",10,0,(6383,-14634,-1572),"stop_mumbling");
}

//Function Number: 118
aud_gun_throw_logic(param_00)
{
	level notify("stop_mumbling");
	var_01 = soundscripts\_snd_playsound::snd_play_at("scn_autopsy_doc_gun",(6853,-14726,-1551));
	var_01 moveto((6564,-14805,-1567),0.8);
	var_02 = soundscripts\_snd_playsound::snd_play_at("scn_autopsy_doc_gun_2",(6445,-14871,-1626));
	wait(0.541);
	var_02 moveto((6162,-14851,-1612),1.5);
	wait(4);
	thread start_autopsy_alarm();
}

//Function Number: 119
aud_hatch_plr(param_00)
{
	soundscripts\_snd_playsound::snd_play_2d("scn_autopsy_hatch_plr");
}

//Function Number: 120
aud_hatch_gideon()
{
	soundscripts\_snd_playsound::snd_play_at("scn_autopsy_doc_gid_05",(6983,-14793,-1571));
}

//Function Number: 121
trigger_darkness()
{
	self waittill("trigger");
	soundscripts\_audio_zone_manager::azm_start_zone("incinerator_int_vol_down",0);
	wait(1.6);
	soundscripts\_snd_playsound::snd_play_2d("scn_incinerator_black_lr");
	soundscripts\_snd::snd_message("incinerator_dialogue");
	level notify("stop_autopsy_alarm");
	level notify("stop_stop_post_courtyard_alarms");
}

//Function Number: 122
aud_incin_blackout()
{
	wait(8.35);
	soundscripts\_snd::snd_message("aud_incin_pilot_light");
	wait(7.5);
	soundscripts\_audio_zone_manager::azm_start_zone("incinerator_int_vol_up",1);
}

//Function Number: 123
incinerator_dialogue()
{
	wait(0.5);
	soundscripts\_snd_playsound::snd_play_2d("cap_plr_argh");
	wait(1.7);
	soundscripts\_snd_playsound::snd_play_2d("cap_gdn_wherearewe");
	wait(3.7);
	soundscripts\_snd_playsound::snd_play_at("cap_gdn_holdonillgetalight",(7582,-13441,-1678));
}

//Function Number: 124
incinerator_dialogue_2()
{
	wait(3.8);
}

//Function Number: 125
aud_incin_pilot_light()
{
	wait(0.1);
	soundscripts\_snd_playsound::snd_play_at("incineration_pilot_light",(7651,-13427,-1675));
	soundscripts\_snd_playsound::snd_play_2d("scn_incinerator_main_lr");
	thread aud_play_dust();
	wait(2.45);
	soundscripts\_snd::snd_message("aud_incin_pilot_light1");
}

//Function Number: 126
aud_play_dust()
{
	wait(0.2);
	soundscripts\_snd_playsound::snd_play_2d("scn_incinerator_main_dust_lr");
}

//Function Number: 127
aud_incin_pilot_light1()
{
	soundscripts\_snd_playsound::snd_play_at("incineration_pilot_light_2",(7851,-13394,-1685));
	wait(1);
	soundscripts\_snd::snd_message("aud_incin_pilot_light2");
}

//Function Number: 128
aud_incin_pilot_light2()
{
	soundscripts\_snd_playsound::snd_play_at("incineration_pilot_light_3",(8106,-13393,-1685));
	wait(0.75);
	soundscripts\_snd::snd_message("aud_incin_pilot_light3");
}

//Function Number: 129
aud_incin_pilot_light3()
{
	soundscripts\_snd_playsound::snd_play_at("incineration_pilot_light_4",(8296,-13396,-1685));
	wait(0.65);
	soundscripts\_snd::snd_message("aud_incin_pilot_light4");
}

//Function Number: 130
aud_incin_pilot_light4()
{
	soundscripts\_snd_playsound::snd_play_at("incineration_pilot_light_5",(8424,-13397,-1685));
	wait(0.5);
	soundscripts\_snd::snd_message("aud_incin_pilot_light5");
}

//Function Number: 131
aud_incin_pilot_light5()
{
	soundscripts\_snd_playsound::snd_play_at("incineration_pilot_light_6",(8617,-13397,-1685));
	level.aud.incin_burst soundscripts\_snd_playsound::snd_play_linked("incineration_burst_2d");
	thread aud_close_sounds();
	soundscripts\_snd::snd_message("aud_incin_flame_loop");
}

//Function Number: 132
aud_close_sounds()
{
	wait(1.66);
	level.aud.incin_close = soundscripts\_snd_playsound::snd_play_loop_2d("amb_incin_above_lr");
}

//Function Number: 133
aud_incin_flame_loop()
{
	while(level.aud.flame_loop == 0)
	{
		wait(8.508);
		if(level.aud.flame_loop == 0)
		{
			level.aud.incin_burst soundscripts\_snd_playsound::snd_play_linked("incineration_burst");
		}
	}
}

//Function Number: 134
aud_incin_cart_start()
{
	wait(0.5);
}

//Function Number: 135
aud_incin_cart_push()
{
	if(isdefined(level.aud.cart_first_time) && level.aud.cart_first_time == 1)
	{
		level.aud.cart_push2 scalevolume(1,0);
		level.aud.cart_push soundscripts\_snd_playsound::snd_play_linked("scn_incin_cart_start");
		level.aud.cart_push2 soundscripts\_snd_playsound::snd_play_loop("scn_incin_cart_start_middle");
		level.aud.cart_first_time = 0;
		return;
	}

	level.aud.cart_push2 scalevolume(1,0);
}

//Function Number: 136
aud_incin_cart_push_stop()
{
	if(isdefined(level.aud.cart_push2))
	{
		level.aud.cart_push2 scalevolume(0,0);
	}
}

//Function Number: 137
aud_incin_cart_done()
{
	wait(1);
	thread aud_stop_sound_logic();
	wait(1.4);
	soundscripts\_snd::snd_message("incineration_escape_logic");
}

//Function Number: 138
aud_stop_sound_logic()
{
	wait(0.4);
	level.aud.cart_push2 scalevolume(0,1);
	level.aud.cart soundscripts\_snd_playsound::snd_play_2d("scn_incin_cart_end");
	wait(1.4);
	level.aud.cart_push2 stoploopsound();
	wait(0.1);
	level.aud.cart_push2 delete();
}

//Function Number: 139
incineration_escape_logic()
{
	wait(5.8);
	thread snd_scalevo_flame_logic();
	level.aud.flame_loop = 1;
	soundscripts\_snd_playsound::snd_play_2d("incineration_burst_escape");
	soundscripts\_snd::snd_message("aud_incin_flame_loop_2");
	wait(1.85);
	soundscripts\_snd_playsound::snd_play_2d("incineration_burst_escape_body");
}

//Function Number: 140
snd_scalevo_flame_logic()
{
	level.aud.incin_burst scalevolume(0,5);
	wait(1);
	level.aud.incin_burst stopsounds();
	soundscripts\_audio_zone_manager::azm_start_zone("incinerator_underground",0.5);
	level.aud.incin_close scalevolume(0,1);
	wait(1);
	level.aud.incin_close stoploopsound();
	wait(0.1);
	level.aud.incin_close delete();
}

//Function Number: 141
aud_incin_flame_loop_2()
{
	level.aud.incin_burst2 soundscripts\_snd_playsound::snd_play_linked("incineration_burst_escape_end");
	level.aud.incin_burst2 scalevolume(0,0);
	thread aud_incin_flame_logic_first_burst();
	while(level.aud.flame_loop2 == 0)
	{
		wait(8.508);
		if(level.aud.flame_loop2 == 0)
		{
			level.aud.incin_burst2 soundscripts\_snd_playsound::snd_play_linked("incineration_burst");
		}
	}
}

//Function Number: 142
aud_incin_flame_logic_first_burst()
{
	wait(0.8);
	level.aud.incin_burst2 scalevolume(1,2);
}

//Function Number: 143
aud_incin_pipe_grab()
{
	wait(0.1);
	soundscripts\_audio_music::mus_stop(2);
	thread scale_flame_sound_logic2();
	level.aud.flame_loop2 = 1;
	wait(1);
	soundscripts\_audio_zone_manager::azm_start_zone("incinerator_ext",1);
	wait(1.5);
	soundscripts\_snd_playsound::snd_play_2d("scn_incinerator_pipe_fireball_lr");
}

//Function Number: 144
scale_flame_sound_logic2()
{
	wait(1);
	level.aud.incin_burst2 scalevolume(0,2);
	wait(2);
	level.aud.incin_burst2 stopsounds();
}

//Function Number: 145
aud_incin_pipe_burst()
{
	soundscripts\_snd_playsound::snd_play_2d("scn_incinerator_pipe_expl");
	soundscripts\_snd_playsound::snd_play_2d("scn_incinerator_pipe_expl_trans");
	soundscripts\_snd::snd_message("aud_incin_after");
}

//Function Number: 146
aud_incin_amb_kill()
{
	level.incin_amb stoploopsound();
	wait(0.1);
	level.incin_amb delete();
}

//Function Number: 147
aud_incin_after()
{
	wait(5);
	soundscripts\_snd::snd_message("aud_incin_after_loop1");
}

//Function Number: 148
aud_incin_after_loop1()
{
	soundscripts\_snd_playsound::snd_play_loop_at("emt_afterincin_engine_01",(7986,-13440,-1759));
	soundscripts\_snd_playsound::snd_play_loop_at("emt_afterincin_engine_02",(8570,-13576,-1670));
	soundscripts\_snd_playsound::snd_play_loop_at("emt_afterincin_engine_03",(8273,-13504,-1712));
	soundscripts\_snd_playsound::snd_play_loop_at("emt_afterincin_engine_04",(8575,-13579,-1670));
	soundscripts\_snd_playsound::snd_play_loop_at("emt_afterincin_engine_05",(8146,-13426,-1759));
	soundscripts\_snd_playsound::snd_play_loop_at("emt_afterincin_engine_09",(7954,-13601,-1692));
	thread aud_engine_wait();
}

//Function Number: 149
aud_engine_wait()
{
	wait(1);
	soundscripts\_snd_playsound::snd_play_loop_at("emt_afterincin_engine_06",(7959,-13650,-1769));
	soundscripts\_snd_playsound::snd_play_loop_at("emt_afterincin_engine_08",(8301,-13490,-1692));
	wait(1.4);
	soundscripts\_snd_playsound::snd_play_loop_at("emt_afterincin_engine_10",(8301,-13490,-1692));
}

//Function Number: 150
aud_heli_battle_flyover()
{
	var_00 = self;
	var_00 vehicle_turnengineoff();
	wait(1.6);
	var_00 thread soundscripts\_snd_playsound::snd_play_linked("scn_cap_bh_heli_flyover");
	wait(11);
	var_00 soundscripts\_snd_playsound::snd_play_loop_linked("scn_cap_bh_heli_hover",undefined,2,1);
}

//Function Number: 151
aud_heli_manticore_flyover()
{
	var_00 = self;
	var_00 vehicle_turnengineoff();
	var_00 thread soundscripts\_snd_playsound::snd_play_linked("scn_cap_manticore_heli_flyover");
	soundscripts\_snd_playsound::snd_play_at("scn_cap_manticore_flyover_rattle_r",(11884,-13713,-1808));
	soundscripts\_snd_playsound::snd_play_at("scn_cap_manticore_flyover_rattle_l",(11846,-13514,-1808));
	soundscripts\_snd_playsound::snd_play_at("scn_cap_manticore_flyover_rattle_b",(11595,-13524,-1808));
	thread stop_post_courtyard_ext_alarms_2();
}

//Function Number: 152
aud_manticore_crane()
{
	soundscripts\_snd_playsound::snd_play_at("scn_cap_manticore_crane",(12140,-13782,-1819));
}

//Function Number: 153
aud_cap_escape_to_heli_truck_1()
{
	if(isarray(self))
	{
		foreach(var_01 in self)
		{
			if(!isdefined(var_01))
			{
				return;
			}

			if(isremovedentity(var_01))
			{
				return;
			}

			if(var_01 maps\_vehicle::isvehicle())
			{
				var_01 thread soundscripts\_snd_playsound::snd_play_linked("scn_cap_escape_to_heli_truck_1");
			}

			wait(5.7);
			soundscripts\_snd_playsound::snd_play_at("scn_cap_runtoheli_truck1_door_open",(12498.9,-12865.8,-1974));
			wait(3.3);
			soundscripts\_snd_playsound::snd_play_at("scn_cap_runtoheli_truck1_guard_land",(12439.8,-12877.7,-2003.3));
			wait(0.3);
			soundscripts\_snd_playsound::snd_play_at("scn_cap_runtoheli_truck1_door_close",(12498.9,-12865.8,-1974));
			return;
		}
	}
}

//Function Number: 154
aud_cap_escape_to_heli_truck_2()
{
	if(isarray(self))
	{
		foreach(var_01 in self)
		{
			if(!isdefined(var_01))
			{
				return;
			}

			if(isremovedentity(var_01))
			{
				return;
			}

			if(var_01 maps\_vehicle::isvehicle())
			{
				wait(4);
			}

			var_01 thread soundscripts\_snd_playsound::snd_play_linked("scn_cap_escape_to_heli_truck_2");
			wait(11.2);
			soundscripts\_snd_playsound::snd_play_at("scn_cap_runtoheli_truck2_door_open",(11885.3,-12632.6,-1959.3));
			wait(2.2);
			soundscripts\_snd_playsound::snd_play_at("scn_cap_runtoheli_truck2_guard_land",(11870.9,-12718.2,-2021.1));
			wait(0.6);
			soundscripts\_snd_playsound::snd_play_at("scn_cap_runtoheli_truck2_door_close",(11885.3,-12632.6,-1959.3));
			return;
		}
	}
}

//Function Number: 155
stop_post_courtyard_ext_alarms_2()
{
	level notify("stop_post_courtyard_ext_alarms_2");
}

//Function Number: 156
aud_heli_escape_idle_sfx()
{
	wait(8);
	soundscripts\_snd_playsound::snd_play_loop_linked("scn_cap_heli_idle_engine","stop_heli_loop",2,3);
	soundscripts\_snd_playsound::snd_play_loop_linked("scn_cap_heli_idle_chop","stop_heli_loop",2,3);
	common_scripts\utility::flag_wait("flag_heliride_warbird_mount");
	level notify("stop_heli_loop");
}

//Function Number: 157
aud_cap_heli_sfx_01(param_00)
{
	soundscripts\_audio_zone_manager::azm_start_zone("heli_ride",2);
	level.player soundscripts\_snd_playsound::snd_play_2d("scn_cap_heli_01_lr");
}

//Function Number: 158
aud_cap_heli_sfx_02(param_00)
{
	level.player soundscripts\_snd_playsound::snd_play_2d("scn_cap_heli_02_lr");
}

//Function Number: 159
aud_cap_heli_sfx_03(param_00)
{
	level.player soundscripts\_snd_playsound::snd_play_2d("scn_cap_heli_03_lr");
}

//Function Number: 160
aud_cap_heli_sfx_04(param_00)
{
	level.player soundscripts\_snd_playsound::snd_play_2d("scn_cap_heli_04_lr");
}

//Function Number: 161
aud_cap_heli_sfx_05(param_00)
{
	soundscripts\_snd_timescale::snd_set_timescale("captured_timescale_override");
	level.player soundscripts\_snd_playsound::snd_play_2d("scn_cap_heli_05_lr");
}

//Function Number: 162
aud_cap_heli_sfx_06(param_00)
{
	level.player soundscripts\_snd_playsound::snd_play_2d("scn_cap_heli_06_lr");
	wait(5);
	soundscripts\_snd::snd_message("aud_crash_wakeup_sfx");
	wait(1);
	soundscripts\_snd_timescale::snd_set_timescale("captured_default");
}

//Function Number: 163
aud_crash_wakeup_sfx()
{
	wait(0.5);
	level.player soundscripts\_snd_playsound::snd_play_2d("scn_cap_heli_wakeup_lr");
}

//Function Number: 164
aud_wakeup_mix()
{
	soundscripts\_audio_zone_manager::azm_start_zone("wake_up_before",0);
}

//Function Number: 165
aud_wakeup_amb(param_00)
{
	soundscripts\_audio_zone_manager::azm_start_zone("wake_up",4);
}

//Function Number: 166
aud_wakeup_mech_cooldown_pings()
{
	soundscripts\_snd_playsound::snd_play_loop_at("emt_cap_metal_cool_pings",(10663,-5838,492),"flag_getting_into_mech",1,1);
}

//Function Number: 167
aud_spark_1()
{
	soundscripts\_snd_playsound::snd_play_2d("scn_wakeup_mech_sparks");
}

//Function Number: 168
aud_spark_2()
{
	soundscripts\_snd_playsound::snd_play_2d("scn_wakeup_mech_sparks2");
}

//Function Number: 169
aud_spark_3()
{
	soundscripts\_snd_playsound::snd_play_2d("scn_wakeup_mech_sparks3");
}

//Function Number: 170
start_mech()
{
	soundscripts\_audio_zone_manager::azm_start_zone("mech_into",2);
	wait(22);
	soundscripts\_snd::snd_message("aud_plr_inside_mech");
}

//Function Number: 171
aud_spark_4()
{
	soundscripts\_snd_playsound::snd_play_2d("scn_mech_entr_spark_01");
}

//Function Number: 172
aud_spark_5()
{
	soundscripts\_snd_playsound::snd_play_2d("scn_mech_entr_spark_02");
}

//Function Number: 173
aud_into_mech_missle(param_00)
{
	soundscripts\_snd_playsound::snd_play_2d("scn_mech_rocket");
}

//Function Number: 174
aud_plr_inside_mech()
{
	soundscripts\_audio_zone_manager::azm_start_zone("captured_int_mech",1);
}

//Function Number: 175
aud_mech_missile_fire()
{
	soundscripts\_snd_playsound::snd_play_2d("wpn_mech_missiles");
}

//Function Number: 176
aud_mech_jump()
{
	soundscripts\_snd_playsound::snd_play_2d("scn_mech_jump_dirt_lr");
	soundscripts\_snd_playsound::snd_play_2d("scn_mech_jump_mech_lr");
	soundscripts\_snd::snd_message("aud_mech1_bg_truck");
}

//Function Number: 177
aud_mech1_bg_truck()
{
	wait(7);
	soundscripts\_snd_playsound::snd_play_at("scn_mech1_suv_arrival_2",(9658,-4469,349.1));
}

//Function Number: 178
aud_mech_trucks_enter(param_00)
{
	var_01 = self;
	if(issubstr(self.script_noteworthy,"mb1"))
	{
		switch(param_00)
		{
			case 1:
				var_01 thread soundscripts\_snd_playsound::snd_play_linked("scn_mech1_suv_arrival_1");
				break;

			case 2:
				wait(0.1);
				break;
		}
	}

	if(issubstr(self.script_noteworthy,"mb2"))
	{
		switch(param_00)
		{
			case 1:
				wait(1.3);
				var_01 thread soundscripts\_snd_playsound::snd_play_linked("scn_mech2_suv_arrival_3");
				break;

			case 2:
				wait(1);
				var_01 thread soundscripts\_snd_playsound::snd_play_linked("scn_mech2_suv_arrival_4");
				break;
		}
	}
}

//Function Number: 179
vrap_explode()
{
	self waittill("explode");
	self playsound("atlas_van_explo");
	var_00 = spawnstruct();
	if(level.currentgen)
	{
		var_00.explo_shot_array_ = [["exp_generic_explo_shot_04",0],["exp_generic_explo_shot_07",0],["exp_generic_explo_shot_10",0],["exp_generic_explo_shot_12",0],["exp_generic_explo_shot_13",0],["exp_generic_explo_shot_20",0],["exp_generic_explo_shot_22",0]];
	}
	else
	{
		var_00.explo_shot_array_ = [["exp_generic_explo_shot_01",0],["exp_generic_explo_shot_02",0],["exp_generic_explo_shot_03",0],["exp_generic_explo_shot_04",0],["exp_generic_explo_shot_05",0],["exp_generic_explo_shot_06",0],["exp_generic_explo_shot_07",0]];
	}

	var_00.pos = self.origin;
	var_00.explo_tail_alias_ = "exp_generic_random_accent";
	var_00.explo_debris_alias_ = "exp_fireball";
	var_00.explo_delay_chance_ = 100;
	var_00.shake_dist_threshold_ = 1500;
	var_00.ground_zero_dist_threshold_ = 500;
	soundscripts\_snd_common::snd_ambient_explosion(var_00);
}

//Function Number: 180
aud_mech_crush_guy(param_00)
{
	var_01 = "generic_death_enemy_" + randomintrange(1,8);
	soundscripts\_snd_playsound::snd_play_at("generic_npc_kick_body",param_00.origin);
	wait(0.1);
	soundscripts\_snd_playsound::snd_play_at(var_01,param_00.origin);
}

//Function Number: 181
aud_mech_panic_walla_watcher()
{
	level endon("stop_panic_watcher");
	var_00 = 1;
	for(;;)
	{
		if(!isdefined(level._mb.civilians["civ_mb1_foot"]) || level._mb.civilians["civ_mb1_foot"].size == 0)
		{
			wait(0.05);
			continue;
		}

		var_01 = 0;
		foreach(var_03 in level._mb.civilians["civ_mb1_foot"])
		{
			if(isalive(var_03) && issubstr(var_03.classname,"hardhat"))
			{
				if(distance(var_03.origin,level.player.origin) < 550 && var_01 == 0)
				{
					var_04 = randomfloatrange(0,10);
					if(var_04 > 8 || var_00 == 1)
					{
						var_03 soundscripts\_snd_playsound::snd_play_linked("emt_mech_civ_walla_ss");
						var_01 = 1;
						if(var_00 == 1)
						{
							var_00 = 0;
						}
					}
				}
			}
		}

		wait(5);
	}
}

//Function Number: 182
aud_stop_mech_panic_walla_watcher()
{
	level notify("stop_panic_watcher");
}

//Function Number: 183
mech_wall_smash()
{
	level.player soundscripts\_snd_playsound::snd_play_2d("mech_wall_smash");
}

//Function Number: 184
mech_wall_smash_3d(param_00)
{
	soundscripts\_snd_playsound::snd_play_at("mech_wall_smash_3d",param_00);
}

//Function Number: 185
mech_warehouse_door_smash()
{
	level.player soundscripts\_snd_playsound::snd_play_2d("mech_warehouse_smash");
}

//Function Number: 186
mech_scan()
{
	level.player soundscripts\_snd_playsound::snd_play_2d("mech_scan");
}

//Function Number: 187
mech_weapon_offline()
{
	if(level.aud.mech_error_timeout == 0)
	{
		level.player soundscripts\_snd_playsound::snd_play_2d("wpn_mech_offline");
		level.aud.mech_error_timeout = 1;
		wait(1.5);
		level.aud.mech_error_timeout = 0;
	}
}

//Function Number: 188
aud_warehouse_roof_machines_line()
{
	thread soundscripts\_audio::aud_play_line_emitter("emt_warehouse_crane_01_motor_lp","emt_warehouse_crane_01_motor_lp",(9774,-325,387),(8279,-323,387));
}

//Function Number: 189
aud_warehouse_roof_machines(param_00)
{
	thread common_scripts\utility::play_loop_sound_on_entity("emt_warehouse_crane_01_lp",(0,0,-20));
	wait(param_00);
	common_scripts\utility::stop_loop_sound_on_entity("emt_warehouse_crane_01_lp");
}

//Function Number: 190
aud_warehouse_mech_lift()
{
	thread soundscripts\_snd_playsound::snd_play_delayed_linked("scn_cap_mech_rise",0,0,undefined,undefined,undefined,undefined,(0,0,130));
	level notify("stop_panic_watcher");
}

//Function Number: 191
aud_warehouse_mech_lift_alarm()
{
	var_00 = [[0,1],[79.5249,1],[194.9644,0.8796],[305.2732,0.733],[377.1021,0.5916],[446.3658,0.4293],[513.0641,0.2408],[579.7625,0.1047],[700.3325,0.01],[1080,0]];
	var_01 = [[0,0.1],[284.7506,0.3],[495.1069,0.4974],[625.9382,0.4293],[728.5511,0.2984],[823.4679,0.1937],[845.8195,0.1099],[900,0.04]];
	thread alarm_enable((8991,603,470),0.2,"alarm_av_09_int_near",var_00,"alarm_av_09_int_far",var_01,"stop_mech_alarms");
	wait(12);
	level notify("stop_mech_alarms");
}

//Function Number: 192
aud_warehouse_mech_lift_vo()
{
	soundscripts\_snd_playsound::snd_play_delayed_at("cap_ls3_warningloadingplatform",(9185,965,448),1);
}

//Function Number: 193
scn_cap_mech_door_closes()
{
	soundscripts\_snd_playsound::snd_play_at("scn_cap_mech_door_closes",(8266,2937,202));
}

//Function Number: 194
scn_cap_mech_door_grab()
{
	soundscripts\_snd_playsound::snd_play_2d("scn_cap_mech_door_grab");
	soundscripts\_audio::aud_set_music_submix(0.5,2);
	wait(2.7);
	soundscripts\_snd_playsound::snd_play_2d("scn_cap_mech_door_grab02");
}

//Function Number: 195
aud_mech_obj_move(param_00)
{
	if(param_00 == "anim_exit_gatelift_1")
	{
		soundscripts\_snd_playsound::snd_play_2d("scn_cap_mech_door_lift_start");
		level.aud.living_gate = 1;
		soundscripts\_snd_playsound::snd_play_loop_2d("scn_cap_mech_door_lift_lp","kill_mech_lift_loop");
		soundscripts\_snd_playsound::snd_play_loop_2d("scn_cap_mech_door_spark_lp","kill_mech_lift_loop");
	}
}

//Function Number: 196
aud_mech_obj_move_wait()
{
	if(level.aud.living_gate == 1)
	{
		soundscripts\_snd_playsound::snd_play_2d("scn_cap_mech_door_closed");
		level notify("kill_mech_lift_loop");
		level.aud.living_gate = 0;
	}
}

//Function Number: 197
aud_mech_obj_move_end()
{
	soundscripts\_snd_playsound::snd_play_2d("scn_cap_mech_door_opened");
	level notify("kill_mech_lift_loop");
	soundscripts\_audio::aud_set_music_submix(1,5);
}

//Function Number: 198
snd_end_01(param_00)
{
	soundscripts\_snd_playsound::snd_play_2d("scn_mech_end_01_lr");
	soundscripts\_audio_zone_manager::azm_start_zone("mech_end_scene_1",1);
	wait(2.261);
	soundscripts\_snd_playsound::snd_play_2d("scn_mech_end_02_lr");
	wait(0.469);
	wait(4.675);
	soundscripts\_snd_playsound::snd_play_2d("scn_mech_end_03_lr");
	wait(10.182);
	soundscripts\_snd_playsound::snd_play_2d("scn_mech_end_04_lr");
	soundscripts\_audio_zone_manager::azm_start_zone("mech_end_scene_2",2);
	wait(4.701);
	soundscripts\_snd::snd_music_message("mus_captured_mech_end");
	wait(1.627);
	soundscripts\_snd_playsound::snd_play_2d("scn_mech_end_05a_lr");
	wait(10.283);
	soundscripts\_snd_playsound::snd_play_2d("scn_mech_end_05_lr");
}

//Function Number: 199
aud_captured_foley_override_handler()
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
				if(level.aud.limp_footsteps == 1)
				{
					if(var_02)
					{
						if(common_scripts\utility::flag("aud_glass_footsteps"))
						{
							soundscripts\_snd_playsound::snd_play_2d("gear_rattle_plr_limp_l");
							soundscripts\_snd_playsound::snd_play_2d("limp_prone_plr_brkglass_l");
						}
						else if(soundexists("limp_prone_plr_" + var_01 + "_l"))
						{
							soundscripts\_snd_playsound::snd_play_2d("gear_rattle_plr_limp_l");
							soundscripts\_snd_playsound::snd_play_2d("limp_prone_plr_" + var_01 + "_l");
						}
						else
						{
							soundscripts\_snd_playsound::snd_play_2d("gear_rattle_plr_limp_l");
							soundscripts\_snd_playsound::snd_play_2d("limp_prone_plr_default_l");
						}
					}
					else if(common_scripts\utility::flag("aud_glass_footsteps"))
					{
						soundscripts\_snd_playsound::snd_play_2d("gear_rattle_plr_limp_r");
						soundscripts\_snd_playsound::snd_play_2d("limp_prone_plr_brkglass_r");
					}
					else if(soundexists("limp_prone_plr_" + var_01 + "_r"))
					{
						soundscripts\_snd_playsound::snd_play_2d("gear_rattle_plr_limp_r");
						soundscripts\_snd_playsound::snd_play_2d("limp_prone_plr_" + var_01 + "_r");
					}
					else
					{
						soundscripts\_snd_playsound::snd_play_2d("gear_rattle_plr_limp_r");
						soundscripts\_snd_playsound::snd_play_2d("limp_prone_plr_default_r");
					}
				}
				break;
	
			case "crouchwalk":
				if(level.aud.limp_footsteps == 1)
				{
					soundscripts\_snd_playsound::snd_play_2d("gear_rattle_plr_limp_l");
					wait(0.1);
					if(common_scripts\utility::flag("aud_glass_footsteps"))
					{
						soundscripts\_snd_playsound::snd_play_2d("limp_walk_plr_brkglass_l");
					}
					else if(soundexists("limp_walk_plr_" + var_01 + "_l"))
					{
						soundscripts\_snd_playsound::snd_play_2d("limp_walk_plr_" + var_01 + "_l");
					}
					else
					{
						soundscripts\_snd_playsound::snd_play_2d("limp_walk_plr_default_l");
					}
		
					wait(0.1);
					soundscripts\_snd_playsound::snd_play_2d("gear_rattle_plr_limp_r");
					wait(0.1);
					if(common_scripts\utility::flag("aud_glass_footsteps"))
					{
						soundscripts\_snd_playsound::snd_play_2d("limp_walk_plr_brkglass_r");
					}
					else if(soundexists("limp_walk_plr_" + var_01 + "_l"))
					{
						soundscripts\_snd_playsound::snd_play_2d("limp_walk_plr_" + var_01 + "_r");
					}
					else
					{
						soundscripts\_snd_playsound::snd_play_2d("limp_walk_plr_default_r");
					}
				}
				break;
	
			case "crouchrun":
				if(level.aud.limp_footsteps == 1)
				{
					if(soundexists("limp_run_plr_" + var_01 + "_l"))
					{
						soundscripts\_snd_playsound::snd_play_2d("gear_rattle_plr_limp_l");
						wait(0.1);
						soundscripts\_snd_playsound::snd_play_2d("limp_run_plr_" + var_01 + "_l");
						wait(0.1);
						soundscripts\_snd_playsound::snd_play_2d("gear_rattle_plr_limp_r");
						wait(0.1);
						soundscripts\_snd_playsound::snd_play_2d("limp_run_plr_" + var_01 + "_r");
					}
					else
					{
						soundscripts\_snd_playsound::snd_play_2d("gear_rattle_plr_limp_l");
						wait(0.1);
						soundscripts\_snd_playsound::snd_play_2d("limp_run_plr_default_l");
						wait(0.1);
						soundscripts\_snd_playsound::snd_play_2d("gear_rattle_plr_limp_r");
						wait(0.1);
						soundscripts\_snd_playsound::snd_play_2d("limp_run_plr_default_r");
					}
				}
				break;
	
			case "walk":
				if(level.aud.limp_footsteps == 1)
				{
					soundscripts\_snd_playsound::snd_play_2d("gear_rattle_plr_limp_l");
					wait(0.1);
					if(common_scripts\utility::flag("aud_glass_footsteps"))
					{
						soundscripts\_snd_playsound::snd_play_2d("limp_walk_plr_brkglass_l");
					}
					else if(soundexists("limp_" + var_00 + "_plr_" + var_01 + "_l"))
					{
						soundscripts\_snd_playsound::snd_play_2d("limp_" + var_00 + "_plr_" + var_01 + "_l");
					}
					else
					{
						soundscripts\_snd_playsound::snd_play_2d("limp_walk_plr_default_l");
					}
		
					wait(0.1);
					soundscripts\_snd_playsound::snd_play_2d("gear_rattle_plr_limp_r");
					wait(0.1);
					if(common_scripts\utility::flag("aud_glass_footsteps"))
					{
						soundscripts\_snd_playsound::snd_play_2d("limp_walk_plr_brkglass_r");
					}
					else if(soundexists("limp_" + var_00 + "_plr_" + var_01 + "_l"))
					{
						soundscripts\_snd_playsound::snd_play_2d("limp_" + var_00 + "_plr_" + var_01 + "_r");
					}
					else
					{
						soundscripts\_snd_playsound::snd_play_2d("limp_walk_plr_default_r");
					}
				}
				else if(level.aud.s2_walk_footsteps == 1)
				{
					if(var_02)
					{
						soundscripts\_snd_playsound::snd_play_2d("gear_rattle_plr_s2_l");
						wait(0.1);
						soundscripts\_snd_playsound::snd_play_2d("s2_walk_plr_default_l");
						wait(0.1);
					}
					else
					{
						soundscripts\_snd_playsound::snd_play_2d("gear_rattle_plr_s2_r");
						wait(0.1);
						soundscripts\_snd_playsound::snd_play_2d("s2_walk_plr_default_r");
						wait(0.1);
					}
				}
				break;
	
			case "run":
				if(level.aud.limp_footsteps == 1)
				{
					if(soundexists("limp_run_plr_" + var_01 + "_l"))
					{
						soundscripts\_snd_playsound::snd_play_2d("gear_limp_plr_run_l");
						wait(0.1);
						soundscripts\_snd_playsound::snd_play_2d("limp_run_plr_" + var_01 + "_l");
						wait(0.1);
						soundscripts\_snd_playsound::snd_play_2d("gear_limp_plr_run_r");
						soundscripts\_snd_playsound::snd_play_2d("limp_run_plr_" + var_01 + "_r");
					}
					else
					{
						soundscripts\_snd_playsound::snd_play_2d("gear_limp_plr_run_l");
						wait(0.1);
						soundscripts\_snd_playsound::snd_play_2d("limp_run_plr_default_l");
						wait(0.1);
						soundscripts\_snd_playsound::snd_play_2d("gear_limp_plr_run_r");
						soundscripts\_snd_playsound::snd_play_2d("limp_run_plr_default_r");
					}
				}
				break;
	
			case "sprint":
				if(level.aud.limp_footsteps == 1)
				{
					if(soundexists("limp_run_plr_" + var_01 + "_l"))
					{
						soundscripts\_snd_playsound::snd_play_2d("gear_limp_plr_run_l");
						wait(0.1);
						soundscripts\_snd_playsound::snd_play_2d("limp_run_plr_" + var_01 + "_l");
						wait(0.1);
						soundscripts\_snd_playsound::snd_play_2d("gear_limp_plr_run_r");
						soundscripts\_snd_playsound::snd_play_2d("limp_run_plr_" + var_01 + "_r");
					}
					else
					{
						soundscripts\_snd_playsound::snd_play_2d("gear_limp_plr_run_l");
						wait(0.1);
						soundscripts\_snd_playsound::snd_play_2d("limp_run_plr_default_l");
						wait(0.1);
						soundscripts\_snd_playsound::snd_play_2d("gear_limp_plr_run_r");
						soundscripts\_snd_playsound::snd_play_2d("limp_run_plr_default_r");
					}
				}
				break;
	
			case "jump":
				if(level.aud.limp_footsteps == 1)
				{
					if(common_scripts\utility::flag("aud_glass_footsteps"))
					{
						soundscripts\_snd_playsound::snd_play_2d("gear_rattle_plr_limp_l");
						soundscripts\_snd_playsound::snd_play_2d("limp_jump_plr_glass");
					}
					else if(soundexists("limp_jump_plr_" + var_01))
					{
						soundscripts\_snd_playsound::snd_play_2d("gear_rattle_plr_limp_l");
						soundscripts\_snd_playsound::snd_play_2d("limp_jump_plr_" + var_01);
					}
					else
					{
						soundscripts\_snd_playsound::snd_play_2d("gear_rattle_plr_limp_l");
						soundscripts\_snd_playsound::snd_play_2d("limp_jump_plr_default");
					}
				}
				break;
	
			case "lightland":
				if(level.aud.limp_footsteps == 1)
				{
					if(soundexists("limp_land_plr_med_" + var_01))
					{
						soundscripts\_snd_playsound::snd_play_2d("gear_rattle_plr_limp_l");
						soundscripts\_snd_playsound::snd_play_2d("limp_land_plr_med_" + var_01);
					}
					else
					{
						soundscripts\_snd_playsound::snd_play_2d("gear_rattle_plr_limp_l");
						soundscripts\_snd_playsound::snd_play_2d("limp_land_plr_med_default");
					}
				}
				break;
	
			case "mediumland":
				if(level.aud.limp_footsteps == 1)
				{
					if(soundexists("limp_land_plr_med_" + var_01))
					{
						soundscripts\_snd_playsound::snd_play_2d("gear_rattle_plr_limp_l");
						soundscripts\_snd_playsound::snd_play_2d("limp_land_plr_med_" + var_01);
					}
					else
					{
						soundscripts\_snd_playsound::snd_play_2d("gear_rattle_plr_limp_l");
						soundscripts\_snd_playsound::snd_play_2d("limp_land_plr_med_default");
					}
				}
				break;
	
			case "heavyland":
				if(level.aud.limp_footsteps == 1)
				{
					if(soundexists("limp_land_plr_med_" + var_01))
					{
						soundscripts\_snd_playsound::snd_play_2d("gear_rattle_plr_limp_l");
						soundscripts\_snd_playsound::snd_play_2d("limp_land_plr_med_" + var_01);
					}
					else
					{
						soundscripts\_snd_playsound::snd_play_2d("gear_rattle_plr_limp_l");
						soundscripts\_snd_playsound::snd_play_2d("limp_land_plr_med_default");
					}
				}
				break;
	
			case "damageland":
				if(level.aud.limp_footsteps == 1)
				{
					if(soundexists("limp_land_plr_med_" + var_01))
					{
						soundscripts\_snd_playsound::snd_play_2d("gear_rattle_plr_limp_l");
						soundscripts\_snd_playsound::snd_play_2d("limp_land_plr_med_" + var_01);
					}
					else
					{
						soundscripts\_snd_playsound::snd_play_2d("gear_rattle_plr_limp_l");
						soundscripts\_snd_playsound::snd_play_2d("limp_land_plr_med_default");
					}
				}
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

//Function Number: 200
aud_captured_setup_anims()
{
	maps\_anim::addnotetrack_customfunction("ally_0","aud_cap_s1_drive_gideon_truck_gate",::aud_intro_truck_gate);
	maps\_anim::addnotetrack_customfunction("ally_0","aud_cap_s1_drive_gideon_truck_passby_01",::aud_intro_truck_passby_01);
	maps\_anim::addnotetrack_customfunction("ally_0","aud_cap_s1_drive_gideon_truck_passby_02",::aud_intro_truck_passby_02);
	maps\_anim::addnotetrack_customfunction("ally_0","aud_cap_s1_drive_gideon_truck_stop",::aud_intro_truck_stop);
	maps\_anim::addnotetrack_customfunction("guard_3","aud_s1_elevator_guard_foley",::aud_s1_elevator_guard_foley);
	maps\_anim::addnotetrack_customfunction("general_1","aud_s1_elevator_boss_foley",::aud_s1_elevator_boss_foley);
	maps\_anim::addnotetrack_customfunction("ally_2","aud_s1_elevator_cormack_foley",::aud_s1_elevator_cormack_foley);
	maps\_anim::addnotetrack_customfunction("ally_2","aud_s1_elevator_kick_1",::aud_s1_elevator_kick_1);
	maps\_anim::addnotetrack_customfunction("ally_2","aud_s1_elevator_kick_2",::aud_s1_elevator_kick_2);
	maps\_anim::addnotetrack_customfunction("ally_0","aud_s2walk_start_gideon_foley",::aud_s2walk_start_gideon_foley);
	maps\_anim::addnotetrack_customfunction("ally_2","aud_s2walk_start_cormack_foley",::aud_s2walk_start_cormack_foley);
	maps\_anim::addnotetrack_customfunction("ally_1","aud_s2walk_start_ilona_foley",::aud_s2walk_start_ilona_foley);
	maps\_anim::addnotetrack_customfunction("ally_0","aud_s2walk_start_gideon_bodyfall",::aud_s2walk_start_gideon_bodyfall);
	maps\_anim::addnotetrack_customfunction("guard_1","aud_s2walk_start_guard_1_foley",::aud_s2walk_start_guard_1_foley);
	maps\_anim::addnotetrack_customfunction("guard_1","aud_s2walk_start_guard_1_grabpush",::aud_s2walk_start_guard_1_grabpush);
	maps\_anim::addnotetrack_customfunction("guard_2","aud_s2walk_start_guard_2_foley",::aud_s2walk_start_guard_2_foley);
	maps\_anim::addnotetrack_customfunction("guard_2","aud_s2walk_start_guard_2_grabpush",::aud_s2walk_start_guard_2_grabpush);
	maps\_anim::addnotetrack_customfunction("guard_2","aud_s2walk_start_guard_2_grab",::aud_s2walk_start_guard_2_grab);
	maps\_anim::addnotetrack_customfunction("guard_2","aud_s2walk_start_guard_2_push",::aud_s2walk_start_guard_2_push);
	maps\_anim::addnotetrack_customfunction("guard_3","aud_s2walk_start_guard_3_foley",::aud_s2walk_start_guard_3_foley);
	maps\_anim::addnotetrack_customfunction("guard_3","aud_s2walk_start_guard_3_walkup_foley",::aud_s2walk_start_guard_3_walkup_foley);
	maps\_anim::addnotetrack_customfunction("player_rig_noexo","aud_s2walk_start_player_foley",::aud_s2walk_start_player_foley);
	maps\_anim::addnotetrack_customfunction("ally_2","aud_s2walk_cormack_punched",::aud_s2walk_cormack_punched);
	maps\_anim::addnotetrack_customfunction("ally_1","aud_s2walk_ilona_push",::aud_s2walk_ilona_push);
	maps\_anim::addnotetrack_customfunction("exterior_ambient_prisoner","ambient_cell_prisoner_audio",::aud_s2walk_cell_prisoners);
	maps\_anim::addnotetrack_customfunction("guard_end","aud_guard_3_foley_01",::aud_s2walk_guard_3_foley_01);
	maps\_anim::addnotetrack_customfunction("guard_end","aud_guard_3_foley_02",::aud_s2walk_guard_3_foley_02);
	maps\_anim::addnotetrack_customfunction("ally_2","aud_cap_s2_trolley_sfx_01",::aud_cap_s2_trolley_sfx_01);
	maps\_anim::addnotetrack_customfunction("ally_2","aud_cap_s2_trolley_sfx_02",::aud_cap_s2_trolley_sfx_02);
	maps\_anim::addnotetrack_customfunction("ally_2","aud_cap_s2_trolley_sfx_03",::aud_cap_s2_trolley_sfx_03);
	maps\_anim::addnotetrack_customfunction("ally_2","aud_cap_s2_trolley_sfx_03_crk",::aud_cap_s2_trolley_sfx_03_crk);
	maps\_anim::addnotetrack_customfunction("ally_2","aud_cap_s2_trolley_sfx_04",::aud_cap_s2_trolley_sfx_04);
	maps\_anim::addnotetrack_customfunction("ally_2","aud_cap_s2_trolley_sfx_05",::aud_cap_s2_trolley_sfx_05);
	maps\_anim::addnotetrack_customfunction("ally_2","aud_cap_s2_trolley_sfx_06",::aud_cap_s2_trolley_sfx_06);
	maps\_anim::addnotetrack_customfunction("ally_2","aud_cap_s2_trolley_sfx_07",::aud_cap_s2_trolley_sfx_07);
	maps\_anim::addnotetrack_customfunction("ally_2","aud_cap_s2_trolley_sfx_08",::aud_cap_s2_trolley_sfx_08);
	maps\_anim::addnotetrack_customfunction("ally_2","aud_cap_s2_trolley_sfx_09",::aud_cap_s2_trolley_sfx_09);
	maps\_anim::addnotetrack_customfunction("ally_2","aud_cap_s2_trolley_sfx_10",::aud_cap_s2_trolley_sfx_10);
	maps\_anim::addnotetrack_customfunction("irons","interrogation_music_start",::aud_interrogation_music_pt1);
	maps\_anim::addnotetrack_customfunction("irons","interrogation_music_pt2",::aud_interrogation_music_pt2);
	maps\_anim::addnotetrack_customfunction("ally_0","aud_cap_s1_rescue_sfx_a",::aud_rescue_sfx_a);
	maps\_anim::addnotetrack_customfunction("ally_0","aud_cap_s1_rescue_sfx_b",::aud_rescue_sfx_b);
	maps\_anim::addnotetrack_customfunction("ally_0","aud_cap_s1_rescue_sfx_c",::aud_rescue_sfx_c);
	maps\_anim::addnotetrack_customfunction("ally_0","aud_cap_s1_rescue_sfx_d",::aud_rescue_sfx_d);
	maps\_anim::addnotetrack_customfunction("ally_0","aud_cap_s1_rescue_sfx_e",::aud_rescue_sfx_e);
	maps\_anim::addnotetrack_customfunction("ally_0","aud_cap_s1_rescue_sfx_f",::aud_rescue_sfx_f);
	maps\_anim::addnotetrack_customfunction("ally_0","aud_cap_s1_rescue_sfx_g",::aud_rescue_sfx_g);
	maps\_anim::addnotetrack_customfunction("ally_0","trolley_music_start",::aud_trolley_music);
	maps\_anim::addnotetrack_customfunction("ally_1","ilana_carmack_rescue_01",::aud_ilana_carmack_rescue_01);
	maps\_anim::addnotetrack_customfunction("ally_1","ilana_carmack_escape_hallway",::aud_ilana_carmack_escape_hallway);
	maps\_anim::addnotetrack_customfunction("ally_1","ilana_carmack_escape_hallway_end",::aud_ilana_carmack_escape_hallway_end);
	maps\_anim::addnotetrack_customfunction("ally_1","ilana_carmack_escape_takedown",::aud_ilana_carmack_escape_takedown);
	maps\_anim::addnotetrack_customfunction("ally_1","ilana_carmack_escape_controlroom",::aud_ilana_carmack_escape_controlroom);
	maps\_anim::addnotetrack_customfunction("ally_1","ilana_carmack_escape_controlroom_attack",::aud_ilana_carmack_escape_controlroom_attack);
	maps\_anim::addnotetrack_customfunction("doctor","aud_gun_throw_logic",::aud_gun_throw_logic);
	maps\_anim::addnotetrack_customfunction("ally_0","gideon_test_chamber_ascend_start",::aud_gideon_test_chamber_ascend_start);
	maps\_anim::addnotetrack_customfunction("ally_0","gideon_test_chamber_stair_door",::aud_gideon_test_chamber_stair_door);
	maps\_anim::addnotetrack_customfunction("ally_0","gideon_test_chamber_climb_stairs_1",::aud_gideon_test_chamber_climb_stairs_1);
	maps\_anim::addnotetrack_customfunction("ally_0","gideon_test_chamber_climb_stairs_2",::aud_gideon_test_chamber_climb_stairs_2);
	maps\_anim::addnotetrack_customfunction("scientist_4","lab_tech_desk_bump",::aud_lab_tech_desk_bump);
	maps\_anim::addnotetrack_customfunction("scientist_1","lab_tech_chair_startle_1",::aud_lab_tech_chair_startle_1);
	maps\_anim::addnotetrack_customfunction("scientist_2","lab_tech_chair_startle_2",::aud_lab_tech_chair_startle_2);
	maps\_anim::addnotetrack_customfunction("ally_0","gideon_test_chamber_descend_stairs",::aud_gideon_test_chamber_descend_stairs);
	maps\_anim::addnotetrack_customfunction("ally_0","gideon_test_chamber_descend_stairs_2",::aud_gideon_test_chamber_descend_stairs_2);
	maps\_anim::addnotetrack_customfunction("ally_0","gideon_test_chamber_security",::aud_gideon_test_chamber_security);
	maps\_anim::addnotetrack_customfunction("ally_0","gideon_autopsy_halls_start",::aud_gideon_autopsy_halls_start);
	maps\_anim::addnotetrack_customfunction("ally_0","aud_cap_incinerator_crawl_loop_gideon_230",::maps\captured_vo::cap_incinerator_crawl_loop_01);
	maps\_anim::addnotetrack_customfunction("ally_0","aud_gideon_test_chamber_bodybag_1",::aud_gideon_test_chamber_bodybag_1,"tc_enter_test");
	maps\_anim::addnotetrack_customfunction("ally_0","aud_gideon_test_chamber_bodybag_2",::aud_gideon_test_chamber_bodybag_2,"tc_enter_test");
	maps\_anim::addnotetrack_customfunction("op_alarm","hazmat_guy_foley",::aud_hazmat_guy_foley);
	maps\_anim::addnotetrack_customfunction("op_alarm","hazmat_guy_pushes_alarm",::aud_hazmat_guy_pushes_alarm);
	maps\_anim::addnotetrack_customfunction("ally_0","gideon_test_chamber_door_kick",::aud_gideon_test_chamber_door_kick);
	maps\_anim::addnotetrack_customfunction("ally_0","gideon_heli_runout_start",::aud_gideon_heli_runout_start);
	maps\_anim::addnotetrack_customfunction("ally_0","gideon_heli_runout_door_kick",::aud_gideon_heli_runout_kick);
	maps\_anim::addnotetrack_customfunction("player_rig","aud_hatch_plr",::aud_hatch_plr);
	maps\_anim::addnotetrack_customfunction("player_rig","aud_cap_heli_sfx_01",::aud_cap_heli_sfx_01);
	maps\_anim::addnotetrack_customfunction("player_rig","aud_cap_heli_sfx_02",::aud_cap_heli_sfx_02);
	maps\_anim::addnotetrack_customfunction("player_rig","aud_cap_heli_sfx_03",::aud_cap_heli_sfx_03);
	maps\_anim::addnotetrack_customfunction("player_rig","aud_cap_heli_sfx_04",::aud_cap_heli_sfx_04);
	maps\_anim::addnotetrack_customfunction("player_rig","aud_cap_heli_sfx_05",::aud_cap_heli_sfx_05);
	maps\_anim::addnotetrack_customfunction("player_rig","aud_cap_heli_sfx_06",::aud_cap_heli_sfx_06);
}

//Function Number: 201
aud_s1_elevator_guard_foley(param_00)
{
	param_00 soundscripts\_snd_playsound::snd_play_linked("scn_s1_elev_guard_foley");
}

//Function Number: 202
aud_s1_elevator_boss_foley(param_00)
{
	param_00 soundscripts\_snd_playsound::snd_play_linked("scn_s1_elev_boss_foley");
}

//Function Number: 203
aud_s1_elevator_cormack_foley(param_00)
{
	param_00 soundscripts\_snd_playsound::snd_play_linked("scn_s1_elev_cormack_foley","stop_cormack_foley");
}

//Function Number: 204
aud_s1_elevator_kick_1(param_00)
{
	soundscripts\_snd_playsound::snd_play_at("scn_s1_elev_kick_01",(5423.8,-5280.5,36.2));
}

//Function Number: 205
aud_s1_elevator_kick_2(param_00)
{
	soundscripts\_snd_playsound::snd_play_at("scn_s1_elev_kick_02",(5423.8,-5280.5,36.2));
}

//Function Number: 206
aud_s2walk_start_gideon_foley(param_00)
{
	param_00 soundscripts\_snd_playsound::snd_play_linked("scn_s2walk_start_gideon_foley");
}

//Function Number: 207
aud_s2walk_start_cormack_foley(param_00)
{
	param_00 soundscripts\_snd_playsound::snd_play_linked("scn_s2walk_start_cormack_foley");
}

//Function Number: 208
aud_s2walk_start_ilona_foley(param_00)
{
	param_00 soundscripts\_snd_playsound::snd_play_linked("scn_s2walk_start_ilona_foley");
}

//Function Number: 209
aud_s2walk_start_gideon_bodyfall(param_00)
{
	level notify("s2_elevator_stop_sfx");
	param_00 soundscripts\_snd_playsound::snd_play_linked("scn_s1_elev_gid_out");
}

//Function Number: 210
aud_s2walk_start_guard_1_foley(param_00)
{
	param_00 soundscripts\_snd_playsound::snd_play_linked("scn_s2walk_start_guard_1_foley");
}

//Function Number: 211
aud_s2walk_start_guard_1_grabpush(param_00)
{
	param_00 soundscripts\_snd_playsound::snd_play_linked("scn_s2walk_start_guard_1_grab_push");
}

//Function Number: 212
aud_s2walk_start_guard_2_foley(param_00)
{
	param_00 soundscripts\_snd_playsound::snd_play_linked("scn_s2walk_start_guard_2_foley");
}

//Function Number: 213
aud_s2walk_start_guard_2_grabpush(param_00)
{
	param_00 soundscripts\_snd_playsound::snd_play_linked("scn_s2walk_start_guard_2_grab_push");
}

//Function Number: 214
aud_s2walk_start_guard_2_grab(param_00)
{
	param_00 soundscripts\_snd_playsound::snd_play_linked("scn_s2walk_start_guard_2_grab");
}

//Function Number: 215
aud_s2walk_start_guard_2_push(param_00)
{
	param_00 soundscripts\_snd_playsound::snd_play_linked("scn_s2walk_start_guard_2_push");
}

//Function Number: 216
aud_s2walk_start_guard_3_foley(param_00)
{
	param_00 soundscripts\_snd_playsound::snd_play_linked("scn_s2walk_start_guard_3_foley");
}

//Function Number: 217
aud_s2walk_start_guard_3_walkup_foley(param_00)
{
	param_00 soundscripts\_snd_playsound::snd_play_linked("scn_s2walk_start_guard_3_walkup_foley");
}

//Function Number: 218
aud_s2walk_start_player_foley(param_00)
{
	level.player soundscripts\_snd_playsound::snd_play_2d("scn_s1_elev_plr_out");
}

//Function Number: 219
aud_s2walk_guard_3_foley_01(param_00)
{
	param_00 soundscripts\_snd_playsound::snd_play_linked("scn_s2_walk_guard_cloth_01");
}

//Function Number: 220
aud_s2walk_guard_3_foley_02(param_00)
{
	param_00 soundscripts\_snd_playsound::snd_play_linked("scn_s2_walk_guard_cloth_02");
}

//Function Number: 221
aud_s2walk_cormack_punched(param_00)
{
	param_00 soundscripts\_snd_playsound::snd_play_linked("scn_s2_walk_cormack_punched");
	param_00 soundscripts\_snd_playsound::snd_play_linked("scn_s2_walk_cormack_punch_exertion");
	wait(1.05);
	param_00 soundscripts\_snd_playsound::snd_play_linked("scn_s2_walk_cormack_punch_exertion_2");
}

//Function Number: 222
aud_s2walk_ilona_push(param_00)
{
	param_00 soundscripts\_snd_playsound::snd_play_linked("scn_s2_walk_ilona_push");
	param_00 soundscripts\_snd_playsound::snd_play_linked("scn_s2_walk_ilona_stumble");
	wait(2.16);
	param_00 soundscripts\_snd_playsound::snd_play_linked("scn_s2_walk_cormack_push");
	param_00 soundscripts\_snd_playsound::snd_play_linked("scn_s2_walk_cormack_punched");
}

//Function Number: 223
aud_trolley_music(param_00)
{
	soundscripts\_snd::snd_music_message("mus_captured_trolley");
}

//Function Number: 224
aud_interrogation_music_pt1(param_00)
{
	soundscripts\_snd::snd_music_message("mus_captured_interrogation");
}

//Function Number: 225
aud_interrogation_music_pt2(param_00)
{
	common_scripts\utility::flag_set("flag_start_interrogation_music_pt2");
}

//Function Number: 226
aud_interrogation_scene()
{
	soundscripts\_audio_zone_manager::azm_start_zone("interrogation",0);
	wait(0.02);
	level.player soundscripts\_snd_playsound::snd_play_linked("scn_cap_interrogation_bg_lr");
}

//Function Number: 227
aud_cap_interrogation_transition_vo()
{
	level.player soundscripts\_snd_playsound::snd_play_2d("cap_ls3_cleanupcrewtomedical");
}

//Function Number: 228
aud_ilana_carmack_rescue_01(param_00)
{
	param_00 soundscripts\_snd_playsound::snd_play_linked("scn_cap_ila_rescue_01");
}

//Function Number: 229
aud_ilana_carmack_escape_hallway(param_00)
{
	param_00 soundscripts\_snd_playsound::snd_play_linked("scn_cap_ila_escape_hallway");
}

//Function Number: 230
aud_ilana_carmack_escape_hallway_end(param_00)
{
	param_00 soundscripts\_snd_playsound::snd_play_linked("scn_cap_ila_escape_hallway_end");
}

//Function Number: 231
aud_ilana_carmack_escape_takedown(param_00)
{
	param_00 soundscripts\_snd_playsound::snd_play_linked("scn_cap_ila_escape_takedown");
}

//Function Number: 232
aud_ilana_carmack_escape_controlroom(param_00)
{
	param_00 soundscripts\_snd_playsound::snd_play_linked("scn_cap_ila_escape_controlroom");
}

//Function Number: 233
aud_ilana_carmack_escape_controlroom_attack(param_00)
{
	param_00 soundscripts\_snd_playsound::snd_play_linked("scn_cap_ila_escape_controlroom_attack");
}

//Function Number: 234
aud_gideon_test_chamber_ascend_start(param_00)
{
	soundscripts\_snd::snd_message("aud_gideon_test_chamber_stair_door",param_00);
	soundscripts\_snd::snd_message("aud_gideon_test_chamber_climb_stairs_1",param_00);
}

//Function Number: 235
aud_gideon_test_chamber_stair_door(param_00)
{
	wait(2.87);
	soundscripts\_snd_playsound::snd_play_at("scn_cap_gdn_test_stair_door",(3895,-10650,-1708));
	wait(1.48);
	soundscripts\_snd_playsound::snd_play_at("scn_cap_gdn_test_stair_door_hit",(3824,-10677,-1700));
}

//Function Number: 236
aud_gideon_test_chamber_climb_stairs_1(param_00)
{
	level.ally soundscripts\_snd_playsound::snd_play_linked("scn_cap_gdn_test_stair_climb_1");
}

//Function Number: 237
aud_gideon_test_chamber_climb_stairs_2(param_00)
{
	level.ally soundscripts\_snd_playsound::snd_play_linked("scn_cap_gdn_test_stair_climb_2");
}

//Function Number: 238
aud_lab_tech_desk_bump(param_00)
{
	soundscripts\_snd_playsound::snd_play_at("scn_cap_lab_tech_desk_bump",(3886.5,-10844.5,-1515.9));
}

//Function Number: 239
aud_lab_tech_chair_startle_1(param_00)
{
	param_00 soundscripts\_snd_playsound::snd_play_linked("scn_lab_tech_chair_startle_01");
}

//Function Number: 240
aud_lab_tech_chair_startle_2(param_00)
{
	param_00 soundscripts\_snd_playsound::snd_play_linked("scn_lab_tech_chair_startle_02");
}

//Function Number: 241
aud_gideon_test_chamber_descend_stairs(param_00)
{
	level.ally soundscripts\_snd_playsound::snd_play_linked("scn_cap_gdn_test_stair_descend_gear_1");
}

//Function Number: 242
aud_gideon_test_chamber_descend_stairs_2(param_00)
{
	level.ally soundscripts\_snd_playsound::snd_play_linked("scn_cap_gdn_test_stair_descend_gear_2");
}

//Function Number: 243
aud_gideon_test_chamber_security(param_00)
{
	thread aud_ally_card_swipe((4410,-11886.8,-1611.9));
	wait(0.2);
	thread aud_ally_card_error((4410,-11886.8,-1611.9));
}

//Function Number: 244
aud_ally_card_accept(param_00)
{
	soundscripts\_snd_playsound::snd_play_at("scn_cap_keycard_accept",param_00);
}

//Function Number: 245
aud_ally_card_error(param_00)
{
	soundscripts\_snd_playsound::snd_play_at("scn_cap_zap_door_fail_beep",param_00);
}

//Function Number: 246
aud_ally_card_swipe(param_00)
{
	soundscripts\_snd_playsound::snd_play_at("scn_cap_keycard_swipe",param_00);
}

//Function Number: 247
aud_gideon_autopsy_halls_start(param_00)
{
	level.ally soundscripts\_snd_playsound::snd_play_linked("scn_cap_test_chamber_gideon_gear");
}

//Function Number: 248
aud_gideon_test_chamber_bodybag_1(param_00)
{
	soundscripts\_snd_playsound::snd_play_at("scn_cap_test_chamber_gideon_bodybag1",(4494,-11736,-1612));
}

//Function Number: 249
aud_gideon_test_chamber_bodybag_2(param_00)
{
	soundscripts\_snd_playsound::snd_play_at("scn_cap_test_chamber_gideon_bodybag2",(4487,-11672,-1612));
}

//Function Number: 250
aud_gideon_test_chamber_door_kick(param_00)
{
	soundscripts\_snd_playsound::snd_play_at("scn_cap_test_chamber_door_kick",(4745,-11541,-1612));
	soundscripts\_audio_mix_manager::mm_clear_submix("captured_alarm_down",1);
}

//Function Number: 251
aud_alarm_submix()
{
	soundscripts\_audio_mix_manager::mm_add_submix("captured_alarm_down");
}

//Function Number: 252
aud_hazmat_guy_foley(param_00)
{
	param_00 soundscripts\_snd_playsound::snd_play_linked("scn_cap_guy_hitting_alarm_foley");
}

//Function Number: 253
aud_hazmat_guy_pushes_alarm(param_00)
{
	param_00 soundscripts\_snd_playsound::snd_play_linked("scn_cap_guy_hitting_alarm");
}

//Function Number: 254
aud_gideon_heli_runout_start(param_00)
{
	level.ally soundscripts\_snd_playsound::snd_play_linked("scn_cap_manticore_gideon_gear");
}

//Function Number: 255
aud_gideon_heli_runout_kick(param_00)
{
	soundscripts\_snd_playsound::snd_play_at("scn_cap_manticore_doorkick",(11778,-13499,-1820));
}

//Function Number: 256
start_courtyard_alarms()
{
	var_00 = [[0,1],[79.5249,1],[194.9644,0.8796],[305.2732,0.733],[377.1021,0.5916],[446.3658,0.4293],[513.0641,0.2408],[579.7625,0.1047],[700.3325,0.01],[1080,0]];
	var_01 = [[0,0.1],[284.7506,0.3],[495.1069,0.4974],[625.9382,0.4293],[728.5511,0.2984],[823.4679,0.1937],[845.8195,0.1099],[900,0.04]];
	thread alarm_enable((3898,-10628,-1635),0.6,"alarm_av_04_int_near",var_00,"alarm_av_04_int_far",var_01,"stop_courtyard_alarms");
	thread alarm_enable((4029,-10662,-1450),0.6,"alarm_av_01_int_near",var_00,"alarm_av_01_int_far",var_01,"stop_courtyard_alarms");
	thread aud_pa_announc_01();
}

//Function Number: 257
start_post_courtyard_interior_alarms()
{
	var_00 = [[0,1],[79.5249,1],[194.9644,0.8796],[305.2732,0.733],[377.1021,0.5916],[446.3658,0.4293],[513.0641,0.2408],[579.7625,0.1047],[700.3325,0.01],[1080,0]];
	var_01 = [[0,0.25],[284.7506,0.5],[495.1069,0.4974],[625.9382,0.4293],[728.5511,0.2984],[823.4679,0.1937],[915.8195,0.1099],[1080,0.1]];
	thread alarm_enable((5212,-12366,-1513),0.6,"alarm_av_04_int_near",var_00,"alarm_av_04_int_far",var_01,"stop_stop_post_courtyard_alarms");
	thread alarm_enable((4779,-13145,-1516),0.6,"alarm_av_01_int_near",var_00,"alarm_av_01_int_far",var_01,"stop_stop_post_courtyard_alarms");
	thread aud_pa_announc_02();
}

//Function Number: 258
start_post_courtyard_ext_alarms()
{
	var_00 = [[0,1],[79.5249,1],[194.9644,0.9796],[305.2732,0.933],[377.1021,0.8916],[446.3658,0.7293],[600.0641,0.6408],[800.7625,0.6],[1000.333,0.5],[1500,0]];
	var_01 = [[0,0.25],[284.7506,0.5],[495.1069,0.3974],[625.9382,0.3293],[728.5511,0.2],[823.4679,0.15],[1050.819,0.1],[1200,0]];
	wait(2);
	thread alarm_enable((9951,-14004,-1792),0.6,"alarm_06_int_near",var_00,"alarm_06_int_far",var_01,"stop_post_courtyard_ext_alarms_2");
	thread start_post_courtyard_ext_alarms_2();
}

//Function Number: 259
start_post_courtyard_ext_alarms_2()
{
	var_00 = [[0,1],[79.5249,1],[194.9644,0.8796],[305.2732,0.733],[325,0.5916],[350,0.4293],[400,0.2408],[600,0.1047],[700,0.05],[800,0]];
	var_01 = [[0,0.2],[284.7506,0.1],[495.1069,0],[625.9382,0],[680,0],[725,0],[750,0],[800,0]];
}

//Function Number: 260
start_autopsy_alarm()
{
	var_00 = [[0,1],[79.5249,1],[194.9644,0.8796],[305.2732,0.733],[325,0.5916],[350,0.4293],[400,0.2408],[600,0.1047],[700,0.05],[800,0]];
	var_01 = [[0,0.3],[284.7506,0.3],[495.1069,0.3],[625.9382,0.3],[680,0.2],[725,0.2],[750,0.1],[800,0]];
	wait(2.5);
	thread aud_pa_announc_03();
}

//Function Number: 261
alarm_enable(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07)
{
	if(!isdefined(level.aud.alarm_guid))
	{
		level.aud.alarm_guid = 0;
	}

	var_08 = "stop_" + param_02 + "_" + level.aud.alarm_guid;
	level.aud.alarm_guid++;
	thread alarm_start(param_00,param_01,param_02,param_03,param_04,param_05,var_08,param_07);
	level waittill(param_06);
	level notify(var_08);
}

//Function Number: 262
alarm_start(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07)
{
	level endon(param_06);
	var_08 = 0;
	var_09 = 1;
	param_07 = soundscripts\_audio::aud_get_optional_param(0,param_07);
	var_0A = spawnstruct();
	var_0A.emitter_origin = param_00;
	var_0A.volume = param_01;
	var_0A.update_rate = 0.1;
	var_0A.alarm_is_playing = 0;
	var_0A.loop_fade_time = 1;
	var_0A.stop_notify_string = param_06;
	var_0A.loops = [alarm_create_loops(param_02,param_03,var_0A.loop_fade_time),alarm_create_loops(param_04,param_05,var_0A.loop_fade_time)];
	var_0A thread alarm_monitor_cleanup();
	var_0B = var_0A.loops[0].env.size;
	var_0C = var_0A.loops[0].env[var_0B - 1];
	var_0D = var_0C[0];
	for(;;)
	{
		var_0A.curr_dist = distance(level.player.origin,param_00);
		if(!var_0A.alarm_is_playing && param_07 == var_08 || param_07 == var_09 && var_0A.curr_dist <= var_0D)
		{
			var_0A thread alarm_start_loops();
		}
		else if(var_0A.alarm_is_playing && param_07 == var_09 && var_0A.curr_dist > var_0D)
		{
			var_0A thread alarm_stop_loops();
		}
		else if(var_0A.curr_dist <= var_0D)
		{
			var_0A alarm_update_loops();
		}

		wait(var_0A.update_rate);
	}
}

//Function Number: 263
alarm_create_loops(param_00,param_01,param_02)
{
	var_03 = spawnstruct();
	var_03.alias = param_00;
	var_03.env = param_01;
	var_03.fade_time = param_02;
	return var_03;
}

//Function Number: 264
alarm_start_loops()
{
	var_00 = self;
	var_01 = var_00.loops[0].env.size;
	var_02 = var_00.loops[0].env[var_01 - 1];
	var_03 = var_02[1];
	foreach(var_05 in var_00.loops)
	{
		var_05.ent = spawn("script_origin",var_00.emitter_origin);
		var_05.ent scalevolume(var_03,0);
		var_05.ent soundscripts\_snd_playsound::snd_play_loop(var_05.alias);
	}

	var_00.alarm_is_playing = 1;
}

//Function Number: 265
alarm_stop_loops()
{
	var_00 = self;
	var_00.alarm_is_playing = 0;
	var_01 = [];
	foreach(var_03 in var_00.loops)
	{
		var_04 = var_03.ent;
		var_03.ent = undefined;
		if(isdefined(var_04))
		{
			var_04 scalevolume(0,var_00.loop_fade_time);
			var_01[var_01.size] = var_04;
		}
	}

	wait(var_00.loop_fade_time);
	foreach(var_04 in var_01)
	{
		if(isdefined(var_04))
		{
			var_04 soundscripts\_snd_playsound::snd_stop_sound();
			var_04 delete();
		}
	}
}

//Function Number: 266
alarm_update_loops()
{
	var_00 = self;
	if(var_00.alarm_is_playing)
	{
		foreach(var_02 in var_00.loops)
		{
			if(isdefined(var_02.ent))
			{
				var_03 = piecewiselinearlookup(var_00.curr_dist,var_02.env);
				var_02.ent scalevolume(var_03 * var_00.volume,var_00.update_rate);
			}
		}
	}
}

//Function Number: 267
alarm_monitor_cleanup()
{
	var_00 = self;
	level waittill(var_00.stop_notify_string);
	var_00 alarm_stop_loops();
}

//Function Number: 268
aud_pa_announc_01()
{
	level endon("stop_courtyard_alarms");
	var_00 = (4708,-10827,-1615);
	var_01 = (4138,-10796,-1634);
	wait(4);
	for(;;)
	{
		soundscripts\_snd_playsound::snd_play_at("cap_ls3_alertthisisnota",var_00);
		soundscripts\_snd_playsound::snd_play_at("cap_ls3_alertthisisnota",var_01);
		wait(randomfloatrange(10,14));
		soundscripts\_snd_playsound::snd_play_at("cap_ls3_irepeatprisoners",var_00);
		soundscripts\_snd_playsound::snd_play_at("cap_ls3_irepeatprisoners",var_01);
		wait(randomfloatrange(10,14));
		soundscripts\_snd_playsound::snd_play_at("cap_ls3_prisonersarearmed",var_00);
		soundscripts\_snd_playsound::snd_play_at("cap_ls3_prisonersarearmed",var_01);
		wait(randomfloatrange(10,14));
		soundscripts\_snd_playsound::snd_play_at("cap_ls3_prisonershaveescaped",var_00);
		soundscripts\_snd_playsound::snd_play_at("cap_ls3_prisonershaveescaped",var_01);
		wait(randomfloatrange(10,14));
		soundscripts\_snd_playsound::snd_play_at("cap_ls3_irepeatprisoners2",var_00);
		soundscripts\_snd_playsound::snd_play_at("cap_ls3_irepeatprisoners2",var_01);
		wait(randomfloatrange(10,14));
		soundscripts\_snd_playsound::snd_play_at("cap_ls3_shootonsightthey",var_00);
		soundscripts\_snd_playsound::snd_play_at("cap_ls3_shootonsightthey",var_01);
		wait(randomfloatrange(10,14));
		soundscripts\_snd_playsound::snd_play_at("cap_ls3_shoottokillprisoners",var_00);
		soundscripts\_snd_playsound::snd_play_at("cap_ls3_shoottokillprisoners",var_01);
		wait(randomfloatrange(10,14));
	}
}

//Function Number: 269
aud_pa_announc_02()
{
	level endon("stop_stop_post_courtyard_alarms");
	var_00 = (4963,-11974,-1505);
	var_01 = (4851,-13274,-1508);
	for(;;)
	{
		soundscripts\_snd_playsound::snd_play_at("cap_ls3_prisonersareheading",var_00);
		soundscripts\_snd_playsound::snd_play_at("cap_ls3_prisonersareheading",var_01);
		wait(randomfloatrange(8,12));
		soundscripts\_snd_playsound::snd_play_at("cap_ls3_alertthisisnota",var_00);
		soundscripts\_snd_playsound::snd_play_at("cap_ls3_alertthisisnota",var_01);
		wait(randomfloatrange(8,12));
		soundscripts\_snd_playsound::snd_play_at("cap_ls3_irepeatprisoners",var_00);
		soundscripts\_snd_playsound::snd_play_at("cap_ls3_irepeatprisoners",var_01);
		wait(randomfloatrange(8,12));
		soundscripts\_snd_playsound::snd_play_at("cap_ls3_prisonersarearmed",var_00);
		soundscripts\_snd_playsound::snd_play_at("cap_ls3_prisonersarearmed",var_01);
		wait(randomfloatrange(8,12));
		soundscripts\_snd_playsound::snd_play_at("cap_ls3_prisonershaveescaped",var_00);
		soundscripts\_snd_playsound::snd_play_at("cap_ls3_prisonershaveescaped",var_01);
		wait(randomfloatrange(8,12));
		soundscripts\_snd_playsound::snd_play_at("cap_ls3_irepeatprisoners2",var_00);
		soundscripts\_snd_playsound::snd_play_at("cap_ls3_irepeatprisoners2",var_01);
		wait(randomfloatrange(8,12));
		soundscripts\_snd_playsound::snd_play_at("cap_ls3_shootonsightthey",var_00);
		soundscripts\_snd_playsound::snd_play_at("cap_ls3_shootonsightthey",var_01);
		wait(randomfloatrange(8,12));
		soundscripts\_snd_playsound::snd_play_at("cap_ls3_shoottokillprisoners",var_00);
		soundscripts\_snd_playsound::snd_play_at("cap_ls3_shoottokillprisoners",var_01);
		wait(randomfloatrange(8,12));
	}
}

//Function Number: 270
aud_pa_announc_03()
{
	level endon("stop_autopsy_alarm");
	var_00 = (5884,-14710,-1463);
	wait(1.5);
	for(;;)
	{
		wait(1.5);
		soundscripts\_snd_playsound::snd_play_at("cap_ls3_shootonsightthey",var_00);
		wait(randomfloatrange(3,4));
		soundscripts\_snd_playsound::snd_play_at("cap_ls3_prisonersareheading",var_00);
		wait(randomfloatrange(3,4));
		soundscripts\_snd_playsound::snd_play_at("cap_ls3_shoottokillprisoners",var_00);
		wait(randomfloatrange(3,4));
	}
}

//Function Number: 271
aud_pa_announc_04()
{
	level endon("stop_post_courtyard_ext_alarms_2");
	var_00 = (10740,-14474,-1484);
	var_01 = (11294,-12971,-1629);
	for(;;)
	{
		soundscripts\_snd_playsound::snd_play_at("cap_ls3_alertthisisnota",var_00);
		soundscripts\_snd_playsound::snd_play_at("cap_ls3_alertthisisnota",var_01);
		wait(randomfloatrange(8,12));
		soundscripts\_snd_playsound::snd_play_at("cap_ls3_irepeatprisoners",var_00);
		soundscripts\_snd_playsound::snd_play_at("cap_ls3_irepeatprisoners",var_01);
		wait(randomfloatrange(8,12));
		soundscripts\_snd_playsound::snd_play_at("cap_ls3_prisonersarearmed",var_00);
		soundscripts\_snd_playsound::snd_play_at("cap_ls3_prisonersarearmed",var_01);
		wait(randomfloatrange(8,12));
		soundscripts\_snd_playsound::snd_play_at("cap_ls3_prisonershaveescaped",var_00);
		soundscripts\_snd_playsound::snd_play_at("cap_ls3_prisonershaveescaped",var_01);
		wait(randomfloatrange(8,12));
		soundscripts\_snd_playsound::snd_play_at("cap_ls3_irepeatprisoners2",var_00);
		soundscripts\_snd_playsound::snd_play_at("cap_ls3_irepeatprisoners2",var_01);
		wait(randomfloatrange(8,12));
		soundscripts\_snd_playsound::snd_play_at("cap_ls3_shootonsightthey",var_00);
		soundscripts\_snd_playsound::snd_play_at("cap_ls3_shootonsightthey",var_01);
		wait(randomfloatrange(8,12));
		soundscripts\_snd_playsound::snd_play_at("cap_ls3_shoottokillprisoners",var_00);
		soundscripts\_snd_playsound::snd_play_at("cap_ls3_shoottokillprisoners",var_01);
		wait(randomfloatrange(8,12));
	}
}

//Function Number: 272
aud_door(param_00,param_01)
{
	if(!isdefined(param_00))
	{
		iprintlnbold("Door");
		return;
	}

	switch(param_00)
	{
		case "rescue":
			wait(0.1);
			soundscripts\_snd_playsound::snd_play_at("scn_cap_rescue_door",(5225,-9935,-1700));
			break;

		case "control_rm":
			if(param_01 == "open")
			{
				soundscripts\_snd_playsound::snd_play_at("scn_cap_door_control",(5013,-10703,-1700));
			}
			else if(param_01 == "close")
			{
			}
			break;

		case "control_rm_exit":
			if(param_01 == "open")
			{
				wait(0.2);
				soundscripts\_snd_playsound::snd_play_at("scn_cap_door_control_fast",(4444,-10696,-1700));
			}
			else if(param_01 == "close")
			{
				soundscripts\_snd_playsound::snd_play_at("scn_cap_door_01_close",(4444,-10696,-1700));
			}
			break;

		case "test_chamber":
			soundscripts\_snd_playsound::snd_play_at("scn_cap_door_02_open",(3984,-11175,-1520));
			break;

		case "test_chamber_side":
			if(param_01 == "open")
			{
				soundscripts\_snd_playsound::snd_play_at("scn_cap_door_02_open",(3884,-11067,-1520));
			}
			else if(param_01 == "close")
			{
				soundscripts\_snd_playsound::snd_play_at("scn_cap_door_02_close",(3884,-11067,-1520));
			}
			break;

		case "test_chamber_exit":
			if(param_01 == "open")
			{
				soundscripts\_snd_playsound::snd_play_at("scn_cap_door_01_open",(4149,-11837,-1520));
			}
			else if(param_01 == "close")
			{
			}
			break;

		case "test_chamber_stairwell":
			if(param_01 == "close")
			{
				soundscripts\_snd_playsound::snd_play_at("scn_autopsy_door_l",(3863,-10632,-1708));
			}
			break;

		case "morgue_doors":
			if(param_01 == "open")
			{
				soundscripts\_snd_playsound::snd_play_at("scn_cap_door_02_open",(4964,-13134,-1572));
			}
			else if(param_01 == "close")
			{
				soundscripts\_snd_playsound::snd_play_at("scn_cap_door_02_open",(4964,-13134,-1572));
			}
			break;

		case "autopsy_pre_doors":
			if(param_01 == "open")
			{
				soundscripts\_snd_playsound::snd_play_at("scn_cap_door_02_open",(5509,-14536,-1572));
			}
			else if(param_01 == "close")
			{
				soundscripts\_snd_playsound::snd_play_at("scn_cap_door_02_close",(5509,-14536,-1572));
			}
			break;

		case "yard_doors":
			if(param_01 == "open")
			{
				soundscripts\_snd_playsound::snd_play_at("scn_cap_door_02_open",(11432,-13607,-1820));
			}
			else if(param_01 == "close")
			{
				soundscripts\_snd_playsound::snd_play_at("scn_cap_door_02_close",(11432,-13607,-1820));
			}
			break;

		case "post_incin":
			if(param_01 == "open")
			{
				wait(0.13);
				soundscripts\_snd_playsound::snd_play_at("scn_cap_door_post_incin_open",(9239,-14294,-1820));
			}
			else if(param_01 == "close")
			{
				wait(0.2);
				soundscripts\_snd_playsound::snd_play_at("scn_cap_door_post_incin_close",(9239,-14294,-1820));
			}
			break;

		case "battle_to_heli":
			if(param_01 == "open")
			{
				wait(0.13);
				soundscripts\_snd_playsound::snd_play_at("scn_cap_door_battle_to_heli",(10056,-14043,-1959));
			}
			break;

		default:
			break;
	}
}