/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: lagos_aud.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 234
 * Decompile Time: 3291 ms
 * Timestamp: 4/22/2024 2:33:25 AM
*******************************************************************/

//Function Number: 1
main()
{
	config_system();
	init_snd_flags();
	init_globals();
	launch_threads();
	thread launch_loops();
	create_level_envelop_arrays();
	precache_presets();
	register_snd_messages();
}

//Function Number: 2
config_system()
{
	soundscripts\_audio::set_stringtable_mapname("shg");
	soundscripts\_snd_filters::snd_set_occlusion("med_occlusion");
	soundscripts\_snd_timescale::snd_set_timescale("lagos_default");
	soundscripts\_audio_mix_manager::mm_add_submix("lagos_global_mix");
}

//Function Number: 3
init_snd_flags()
{
	common_scripts\utility::flag_init("aud_oncoming_truck_check");
}

//Function Number: 4
init_globals()
{
	level.aud.truck_swap = 0;
}

//Function Number: 5
launch_threads()
{
	if(soundscripts\_audio::aud_is_specops())
	{
		return;
	}

	thread setup_drone_intro_anims();
	thread setup_briefing_anims();
	thread setup_exo_door_kick_anims();
	thread setup_wall_climb_foley();
	thread setup_alley_wall_climb_foley();
	thread setup_roof_breach_anims();
	thread setup_harmonic_breach_anims();
	thread setup_pm_rescue_anims();
	thread setup_roundabout_rpg_fire_emitters();
	thread setup_roundabout_tanker_proxy_fire_emitters();
	thread setup_roundabout_point_source_dambs();
	thread setup_alley_anims();
	thread setup_alley_escape_breach();
	thread hostage_truck_fwy_notetrack_setup();
	thread bus_jumping_notetrack_setup();
	thread shore_pcap_notetrack_setup();
}

//Function Number: 6
launch_loops()
{
	if(level.currentgen && !istransientloaded("lagos_intro_tr"))
	{
		return;
	}

	common_scripts\utility::loop_fx_sound("lag_gov_rescue_computer_tone",(-52252,9133,480),1,"aud_stop_intro");
	common_scripts\utility::loop_fx_sound("lag_gov_rescue_computer_tone",(-52139,9126,480),1,"aud_stop_intro");
	common_scripts\utility::loop_fx_sound("lag_gov_rescue_computer_tone",(-52085,9128,482),1,"aud_stop_intro");
	if(level.currentgen)
	{
		level waittill("tff_pre_intro_to_middle");
		level notify("aud_stop_intro");
	}
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
	soundscripts\_snd::snd_register_message("start_intro_drone",::start_intro_drone);
	soundscripts\_snd::snd_register_message("start_intro_squad",::start_intro_squad);
	soundscripts\_snd::snd_register_message("start_government_building",::start_government_building);
	soundscripts\_snd::snd_register_message("start_pre_h_breach",::start_pre_h_breach);
	soundscripts\_snd::snd_register_message("start_post_h_breach",::start_post_h_breach);
	soundscripts\_snd::snd_register_message("start_roundabout",::start_roundabout);
	soundscripts\_snd::snd_register_message("start_alley1",::start_alley1);
	soundscripts\_snd::snd_register_message("start_oncoming_alley",::start_oncoming_alley);
	soundscripts\_snd::snd_register_message("start_alley2",::start_alley2);
	soundscripts\_snd::snd_register_message("start_flank_alley",::start_flank_alley);
	soundscripts\_snd::snd_register_message("start_traffic_frogger",::start_traffic_frogger);
	soundscripts\_snd::snd_register_message("start_traffic_traverse",::start_traffic_traverse);
	soundscripts\_snd::snd_register_message("start_middle_takedown",::start_middle_takedown);
	soundscripts\_snd::snd_register_message("start_post_middle_takedown",::start_post_middle_takedown);
	soundscripts\_snd::snd_register_message("start_van_takedown",::start_van_takedown);
	soundscripts\_snd::snd_register_message("start_van_takedown_underwater",::start_van_takedown_underwater);
	soundscripts\_snd::snd_register_message("start_shore_pcap",::start_shore_pcap);
	soundscripts\_snd::snd_register_message("start_outro",::start_outro);
	soundscripts\_snd::snd_register_message("intro_fly_drone_idle",::intro_fly_drone_idle);
	soundscripts\_snd::snd_register_message("fly_drone_picture_live",::fly_drone_picture_live);
	soundscripts\_snd::snd_register_message("fly_drone_camera_start_1",::fly_drone_camera_start_1);
	soundscripts\_snd::snd_register_message("fly_drone_camera_start_2",::fly_drone_camera_start_2);
	soundscripts\_snd::snd_register_message("fly_drone_activate",::fly_drone_activate);
	soundscripts\_snd::snd_register_message("start_intro_ambience",::start_intro_ambience);
	soundscripts\_snd::snd_register_message("lag_intro_vo_overlap_mix",::lag_intro_vo_overlap_mix);
	soundscripts\_snd::snd_register_message("opening_warbird",::opening_warbird);
	soundscripts\_snd::snd_register_message("vig_tram_setup_car",::vig_tram_setup_car);
	soundscripts\_snd::snd_register_message("plr_exo_door_kick",::plr_exo_door_kick);
	soundscripts\_snd::snd_register_message("gov_bldg_driveup",::gov_bldg_driveup);
	soundscripts\_snd::snd_register_message("aud_exo_climb_burke",::aud_exo_climb_burke);
	soundscripts\_snd::snd_register_message("exo_climb_pullup_start",::exo_climb_pullup_start);
	soundscripts\_snd::snd_register_message("exo_climb_right_swing_pressed",::exo_climb_right_swing_pressed);
	soundscripts\_snd::snd_register_message("exo_climb_left_swing_pressed",::exo_climb_left_swing_pressed);
	soundscripts\_snd::snd_register_message("gov_building_mute_device",::gov_building_mute_device);
	soundscripts\_snd::snd_register_message("rooftop_slo_mo_override",::rooftop_slo_mo_override);
	soundscripts\_snd::snd_register_message("hb_gun_away",::hb_gun_away);
	soundscripts\_snd::snd_register_message("hb_sensor_flash_on",::hb_sensor_flash_on);
	soundscripts\_snd::snd_register_message("hb_highlight_enable",::hb_highlight_enable);
	soundscripts\_snd::snd_register_message("hb_highlight_disable",::hb_highlight_disable);
	soundscripts\_snd::snd_register_message("hb_target_tagged",::hb_target_tagged);
	soundscripts\_snd::snd_register_message("hb_target_untagged",::hb_target_untagged);
	soundscripts\_snd::snd_register_message("hb_lock_targets",::hb_lock_targets);
	soundscripts\_snd::snd_register_message("hb_shots_fired",::hb_shots_fired);
	soundscripts\_snd::snd_register_message("hb_sensor_flash_off",::hb_sensor_flash_off);
	soundscripts\_snd::snd_register_message("pm_rescue_foley",::pm_rescue_foley);
	soundscripts\_snd::snd_register_message("leaving_gov_building_post_vo",::leaving_gov_building_post_vo);
	soundscripts\_snd::snd_register_message("roundabout_combat_started",::roundabout_combat_started);
	soundscripts\_snd::snd_register_message("roundabout_rpg_fire",::roundabout_rpg_fire);
	soundscripts\_snd::snd_register_message("roundabout_general_mayhem",::roundabout_general_mayhem);
	soundscripts\_snd::snd_register_message("roundabout_tanker_explosion",::roundabout_tanker_explosion);
	soundscripts\_snd::snd_register_message("crossing_into_alley",::crossing_into_alley);
	soundscripts\_snd::snd_register_message("roundabout_exited",::roundabout_exited);
	soundscripts\_snd::snd_register_message("alley_1_big_metal_gate",::alley_1_big_metal_gate);
	soundscripts\_snd::snd_register_message("oncoming_alley_truck",::oncoming_alley_truck);
	soundscripts\_snd::snd_register_message("lagos_technical_turret_fire",::lagos_technical_turret_fire);
	soundscripts\_snd::snd_register_message("truck_turret_flank_alley",::truck_turret_flank_alley);
	soundscripts\_snd::snd_register_message("truck_turret_flank_alley_drive_away",::truck_turret_flank_alley_drive_away);
	soundscripts\_snd::snd_register_message("frogger_vehicle_by",::frogger_vehicle_by);
	soundscripts\_snd::snd_register_message("traffic_traverse_fence_rip",::traffic_traverse_fence_rip);
	soundscripts\_snd::snd_register_message("handle_busses",::handle_busses);
	soundscripts\_snd::snd_register_message("lag_brk_onme_done",::lag_brk_onme_done);
	soundscripts\_snd::snd_register_message("lag_brk_nocleanshot_done",::lag_brk_nocleanshot_done);
	soundscripts\_snd::snd_register_message("traverse_start_jump_start_slowmo",::traverse_start_jump_start_slowmo);
	soundscripts\_snd::snd_register_message("traverse_start_jump_end_slowmo",::traverse_start_jump_end_slowmo);
	soundscripts\_snd::snd_register_message("bus_chase_suv_oneshots",::bus_chase_suv_oneshots);
	soundscripts\_snd::snd_register_message("bus_chase_suv_lose_control",::bus_chase_suv_lose_control);
	soundscripts\_snd::snd_register_message("bus_chase_suv_explode",::bus_chase_suv_explode);
	soundscripts\_snd::snd_register_message("notify_qte_prompt_and_slowmo",::notify_qte_prompt_and_slowmo);
	soundscripts\_snd::snd_register_message("lag_brk_stayclose_done",::lag_brk_stayclose_done);
	soundscripts\_snd::snd_register_message("middle_takedown_gun_up",::middle_takedown_gun_up);
	soundscripts\_snd::snd_register_message("truck_middle_dodge_slowmo_end",::truck_middle_dodge_slowmo_end);
	soundscripts\_snd::snd_register_message("truck_middle_jump_slowmo_end",::truck_middle_jump_slowmo_end);
	soundscripts\_snd::snd_register_message("truck_middle_punch_slowmo_end",::truck_middle_punch_slowmo_end);
	soundscripts\_snd::snd_register_message("truck_middle_jump2_slowmo_end",::truck_middle_jump2_slowmo_end);
	soundscripts\_snd::snd_register_message("lag_brk_takeoutsuv_done",::lag_brk_takeoutsuv_done);
	soundscripts\_snd::snd_register_message("truck_whipeout_anim_begin",::truck_whipeout_anim_begin);
	soundscripts\_snd::snd_register_message("spawn_traffic_helicopter",::spawn_traffic_helicopter);
	soundscripts\_snd::snd_register_message("chase_heli_fire",::chase_heli_fire);
	soundscripts\_snd::snd_register_message("final_takedown_abutton_hit",::final_takedown_abutton_hit);
	soundscripts\_snd::snd_register_message("hostage_truck_slomo_start_pt1",::hostage_truck_slomo_start_pt1);
	soundscripts\_snd::snd_register_message("final_takedown_xbutton_hit",::final_takedown_xbutton_hit);
	soundscripts\_snd::snd_register_message("final_takedown_gun_up",::final_takedown_gun_up);
	soundscripts\_snd::snd_register_message("hostage_truck_slomo_start_pt2",::hostage_truck_slomo_start_pt2);
	soundscripts\_snd::snd_register_message("hostage_truck_slomo_end_pt2",::hostage_truck_slomo_end_pt2);
	soundscripts\_snd::snd_register_message("underwater_sequence",::underwater_sequence);
	soundscripts\_snd::snd_register_message("underwater_rescue",::underwater_rescue);
	soundscripts\_snd::snd_register_message("lagos_swimming_into_stroke",::lagos_swimming_into_stroke);
	soundscripts\_snd::snd_register_message("lagos_swimming_stroke",::lagos_swimming_stroke);
	soundscripts\_snd::snd_register_message("lagos_swimming_drowning_start",::lagos_swimming_drowning_start);
	soundscripts\_snd::snd_register_message("shore_ending",::shore_ending);
	soundscripts\_snd::snd_register_message("lag_gl_end_logo",::lag_gl_end_logo);
	soundscripts\_snd::snd_register_message("temp_dog_bark",::temp_dog_bark);
}

//Function Number: 10
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

	switch(param_00)
	{
		case "enter_int_lobby":
			if(var_02 == "ext_alley")
			{
				soundscripts\_snd_playsound::snd_play_at("lag_walla_bank",(-52246,7423,324));
			}
			break;

		case "exit_int_lobby":
			if(var_03 == "int_lobby")
			{
			}
			break;

		case "enter_ext_roundabout":
			if(var_02 == "int_lobby")
			{
				thread roundabout_panic_walla();
			}
			break;
	}
}

//Function Number: 11
music(param_00,param_01)
{
	thread music_handler(param_00,param_01);
}

//Function Number: 12
music_handler(param_00,param_01)
{
	level notify("stop_current_music_thread");
	level endon("stop_current_music_thread");
	var_02 = 0.99;
	switch(param_00)
	{
		case "start_roundabout":
			music("leaving_gov_building_post_vo");
			break;

		case "leaving_gov_building_post_vo":
			soundscripts\_audio::aud_set_music_submix(0.7,0);
			wait(0.5);
			soundscripts\_audio_music::mus_play("lag_mus_roundabout",1);
			wait(0.5);
			soundscripts\_audio::aud_set_music_submix(1,30);
			level waittill("roundabout_lag_jkr_rpg");
			soundscripts\_audio_music::mus_stop(1);
			break;

		case "lag_brk_onme_done":
			soundscripts\_audio::aud_set_music_submix(1,0);
			soundscripts\_audio_music::mus_play("lag_mus_buschase_vamp_intro",3);
			break;

		case "lag_brk_nocleanshot_done":
			soundscripts\_audio::aud_set_music_submix(var_02 / 2,0);
			soundscripts\_audio_music::mus_play("lag_mus_buschase_hit",0,1);
			break;

		case "player_lands_on_first_bus":
			soundscripts\_audio::aud_set_music_submix(var_02,0);
			soundscripts\_audio_music::mus_play("lag_mus_buschase_main_lp1",0);
			break;

		case "bus_chase_lag_brk_stayclose_done":
			soundscripts\_audio::aud_set_music_submix(var_02,0);
			soundscripts\_audio_music::mus_play("lag_mus_buschase_main_end",0.25,3);
			break;

		case "lag_brk_takeoutsuv_done":
			soundscripts\_audio_music::mus_play("lag_mus_buschase_vamp",0,1);
			break;

		case "buschase_truck_crash_begin":
			soundscripts\_audio_music::mus_stop(1);
			break;

		case "buschase_truck_crash_end":
			soundscripts\_audio::aud_set_music_submix(var_02,0);
			soundscripts\_audio_music::mus_play("lag_mus_buschase_main_lp2",0);
			break;

		case "final_takedown_abutton_hit":
			soundscripts\_audio::aud_set_music_submix(var_02,0);
			soundscripts\_audio_music::mus_play("lag_mus_buschase_main_end",0,2);
			break;

		case "final_takedown_gun_up":
			soundscripts\_audio::aud_set_music_submix(var_02,0);
			soundscripts\_audio_music::mus_play("lag_mus_buschase_vamp",0,1);
			break;

		case "buschase_ending":
			soundscripts\_audio::aud_set_music_submix(var_02,0);
			soundscripts\_audio_music::mus_stop(5);
			var_03 = soundscripts\_snd_playsound::snd_play_2d("lag_mus_buschase_main_end",undefined,undefined,undefined,0.1);
			wait(0.05);
			var_03 scalevolume(1,3.2);
			break;

		default:
			soundscripts\_audio::aud_print_warning("\tMUSIC MESSAGE NOT HANDLED: " + param_00);
			break;
	}
}

//Function Number: 13
start_intro_drone()
{
}

//Function Number: 14
start_intro_squad()
{
	soundscripts\_audio_zone_manager::azm_start_zone("ext_walkway");
}

//Function Number: 15
start_government_building()
{
	soundscripts\_audio_zone_manager::azm_start_zone("ext_gov_reveal");
}

//Function Number: 16
start_pre_h_breach()
{
	soundscripts\_audio_zone_manager::azm_start_zone("int_gov_bldg");
}

//Function Number: 17
start_post_h_breach()
{
	soundscripts\_audio_zone_manager::azm_start_zone("int_gov_bldg");
}

//Function Number: 18
start_roundabout()
{
	soundscripts\_audio_zone_manager::azm_start_zone("ext_alley");
	music("start_roundabout");
}

//Function Number: 19
start_alley1()
{
	soundscripts\_audio_zone_manager::azm_start_zone("ext_alley_ambush");
}

//Function Number: 20
start_oncoming_alley()
{
	soundscripts\_audio_zone_manager::azm_start_zone("ext_alley_ambush");
}

//Function Number: 21
start_alley2()
{
	soundscripts\_audio_zone_manager::azm_start_zone("ext_bldg_3");
}

//Function Number: 22
start_flank_alley()
{
	soundscripts\_audio_zone_manager::azm_start_zone("ext_courtyard_battle_1");
}

//Function Number: 23
start_traffic_frogger()
{
	soundscripts\_audio_zone_manager::azm_start_zone("ext_courtyard_battle_2");
}

//Function Number: 24
start_traffic_traverse()
{
	soundscripts\_audio_zone_manager::azm_start_zone("ext_frogger");
}

//Function Number: 25
start_middle_takedown()
{
	soundscripts\_audio_zone_manager::azm_start_zone("ext_frogger");
	soundscripts\_snd_timescale::snd_set_timescale("lagos_timescale_override");
}

//Function Number: 26
start_post_middle_takedown()
{
	soundscripts\_audio_zone_manager::azm_start_zone("ext_frogger");
	level.aud.mus_lag_brk_takeoutsuv_done = 1;
	music("lag_brk_takeoutsuv_done");
}

//Function Number: 27
start_van_takedown()
{
	soundscripts\_audio_zone_manager::azm_start_zone("ext_frogger");
}

//Function Number: 28
start_van_takedown_underwater()
{
}

//Function Number: 29
start_outro()
{
}

//Function Number: 30
start_shore_pcap()
{
	soundscripts\_snd_filters::snd_set_occlusion("shores_pcap");
}

//Function Number: 31
intro_fly_drone_idle()
{
	soundscripts\_audio_mix_manager::mm_add_submix("lag_drone_intro",0.05);
	soundscripts\_snd_playsound::snd_play_2d("lag_intro_drone_no_feed","kill_static",0.05);
	soundscripts\_snd_playsound::snd_play_loop_2d("lag_intro_drone_static_loop","kill_static",0.1);
	thread stop_audio_intro_fly_drone_idle();
}

//Function Number: 32
stop_audio_intro_fly_drone_idle()
{
	if(level.currentgen && !istransientloaded("lagos_intro_tr"))
	{
		return;
	}

	if(level.currentgen)
	{
		level waittill("tff_pre_intro_to_middle");
		level notify("kill_static");
	}
}

//Function Number: 33
fly_drone_picture_live()
{
	level notify("kill_static");
	soundscripts\_snd_playsound::snd_play_2d("lag_intro_train_by_01");
	soundscripts\_snd_playsound::snd_play_2d("lag_intro_drone_mic_live");
	soundscripts\_snd_playsound::snd_play_2d("lag_intro_drone_picture_live");
	soundscripts\_snd_playsound::snd_play_loop_2d("lag_intro_drone_idle","kill_drone_idle_lp");
	soundscripts\_snd_playsound::snd_play_loop_2d("lag_intro_drone_amb","kill_exterior_amb");
}

//Function Number: 34
fly_drone_activate()
{
	level notify("kill_drone_idle_lp");
	soundscripts\_snd_playsound::snd_play_delayed_2d("lag_intro_drone_wind_up",1.2);
	soundscripts\_snd_playsound::snd_play_delayed_loop_2d("lag_intro_drone_motor",3,undefined,"kill_conf_loop");
}

//Function Number: 35
fly_drone_camera_start_1(param_00,param_01)
{
	level endon("FlyDroneCamera2");
	level waittill("DroneCameraAudioStart");
	thread kill_looping_drone_camera_sounds();
	var_02 = param_00.angles[1];
	if(var_02 < 0)
	{
		var_02 = var_02 + 360;
	}

	var_03 = param_01.angles[1];
	if(var_03 < 0)
	{
		var_03 = var_03 + 360;
	}

	var_04 = abs(var_02 - var_03);
	var_05 = 0;
	var_06 = 3.8;
	var_07 = 1.5;
	for(;;)
	{
		var_02 = param_00.angles[1];
		if(var_02 < 0)
		{
			var_02 = var_02 + 360;
		}

		var_03 = param_01.angles[1];
		if(var_03 < 0)
		{
			var_03 = var_03 + 360;
		}

		var_08 = abs(var_02 - var_03);
		if(abs(var_08 - var_04) > var_06 || abs(var_08 - var_04) > var_07 && length(param_01 getnormalizedcameramovements()) > 0.1)
		{
			if(!var_05)
			{
				var_05 = 1;
				soundscripts\_snd::snd_printlnbold("Start Drone Camera Move");
				soundscripts\_snd_playsound::snd_play_2d("lag_intro_drone_camera_servo","kill_drone_servo");
			}
		}
		else if(var_05)
		{
			var_05 = 0;
			soundscripts\_snd::snd_printlnbold("Stop Drone Camera Move");
			level notify("kill_drone_servo");
		}

		var_04 = var_08;
		wait 0.05;
	}
}

//Function Number: 36
fly_drone_camera_start_2(param_00,param_01)
{
	level endon("drone_control_complete");
	level notify("FlyDroneCamera2");
	var_02 = param_00.angles[1];
	if(var_02 < 0)
	{
		var_02 = var_02 + 360;
	}

	var_03 = param_01.angles[1];
	if(var_03 < 0)
	{
		var_03 = var_03 + 360;
	}

	var_04 = abs(var_02 - var_03);
	var_05 = param_01 getplayerangles()[0];
	var_06 = 0;
	var_07 = 2.8;
	var_08 = 1.75;
	for(;;)
	{
		var_02 = param_00.angles[1];
		if(var_02 < 0)
		{
			var_02 = var_02 + 360;
		}

		var_03 = param_01.angles[1];
		if(var_03 < 0)
		{
			var_03 = var_03 + 360;
		}

		var_09 = abs(var_02 - var_03);
		var_0A = param_01 getplayerangles()[0];
		if((abs(var_09 - var_04) > var_07 || abs(var_0A - var_05) > var_08) && length(param_01 getnormalizedcameramovements()) > 0.1)
		{
			if(!var_06)
			{
				var_06 = 1;
				soundscripts\_snd::snd_printlnbold("Start Drone Camera Move");
				soundscripts\_snd_playsound::snd_play_2d("lag_intro_drone_camera_servo","kill_drone_servo");
			}
		}
		else if(var_06)
		{
			var_06 = 0;
			soundscripts\_snd::snd_printlnbold("Stop Drone Camera Move");
			level notify("kill_drone_servo");
		}

		var_04 = var_09;
		var_05 = var_0A;
		wait 0.05;
	}
}

//Function Number: 37
kill_looping_drone_camera_sounds()
{
	level waittill("FlyDroneCamera2");
	soundscripts\_snd::snd_printlnbold("Ending FlyDrone Section 1");
	level notify("kill_drone_servo");
	level waittill("drone_control_complete");
	soundscripts\_snd::snd_printlnbold("Ending FlyDrone Section 2");
	level notify("kill_drone_servo");
}

//Function Number: 38
setup_drone_intro_anims()
{
	wait(0.05);
	if(level.nextgen || level.transient_zone == "intro")
	{
		maps\_anim::addnotetrack_customfunction("drone_intro","aud_drone_intro_bag_guy",::intro_bag_guy_start,"drop_bag");
		maps\_anim::addnotetrack_customfunction("drone_intro","aud_drone_intro_bag_guy_table",::intro_bag_guy_table,"drop_bag");
		maps\_anim::addnotetrack_customfunction("drone_intro","aud_drone_intro_bag_guy_walk_away",::intro_bag_guy_walk_away,"drop_bag");
		maps\_anim::addnotetrack_customfunction("drone_intro","aud_drone_intro_running_guy",::intro_running_guy,"run_into_room");
		maps\_anim::addnotetrack_customfunction("drone_intro","aud_drone_guy_4",::intro_bad_guy_4,"aim_forward");
		maps\_anim::addnotetrack_customfunction("drone_intro","aud_drone_guy_5",::intro_bad_guy_5,"guy_5");
		maps\_anim::addnotetrack_customfunction("drone_intro","aud_drone_guy_6",::intro_bad_guy_6,"guy_6");
		maps\_anim::addnotetrack_customfunction("kva_hostage_leader","aud_drone_hostage_leader",::intro_hostage_leader,"drone_opening");
		maps\_anim::addnotetrack_customfunction("kva_hostage_leader","aud_drone_hostage_leader_2",::intro_hostage_leader_2,"drone_opening");
		maps\_anim::addnotetrack_customfunction("kva_hostage_leader","aud_drone_hostage_leader_3",::intro_hostage_leader_3,"drone_opening");
		maps\_anim::addnotetrack_customfunction("kva_hostage_minister","aud_drone_prime_minister",::intro_prime_minister,"drone_opening");
		maps\_anim::addnotetrack_customfunction("kva_hostage_minister","aud_drone_prime_minister_2",::intro_prime_minister_2,"drone_opening");
		maps\_anim::addnotetrack_customfunction("kva_hostage_leader","aud_drone_hostage_executed",::intro_hostage_executed,"drone_opening");
	}
}

//Function Number: 39
intro_bag_guy_start(param_00)
{
	param_00 soundscripts\_snd_playsound::snd_play_linked("lag_intro_bag_guy_start");
	thread enter_window_whoosh();
}

//Function Number: 40
intro_bag_guy_table(param_00)
{
	param_00 soundscripts\_snd_playsound::snd_play_linked("lag_intro_bag_guy_table");
}

//Function Number: 41
intro_bag_guy_walk_away(param_00)
{
	param_00 soundscripts\_snd_playsound::snd_play_linked("lag_intro_bag_guy_walk_away");
}

//Function Number: 42
intro_running_guy(param_00)
{
	thread intro_quad_whoooshes();
	param_00 soundscripts\_snd_playsound::snd_play_linked("lag_intro_running_guy");
}

//Function Number: 43
enter_window_whoosh()
{
	soundscripts\_snd_playsound::snd_play_delayed_2d("lag_intro_enter_window",0.15);
	wait(0.15);
	soundscripts\_snd_playsound::snd_play_loop_2d("lag_intro_drone_amb_int","kill_office_loop",undefined,0.5);
	wait(0.5);
	level notify("kill_exterior_amb");
}

//Function Number: 44
intro_quad_whoooshes()
{
	soundscripts\_snd_playsound::snd_play_delayed_2d("lag_intro_whoosh_02",2.2);
	soundscripts\_snd_playsound::snd_play_delayed_2d("lag_intro_whoosh_03",3);
	soundscripts\_snd_playsound::snd_play_delayed_2d("lag_intro_whoosh_04",3.58);
	soundscripts\_snd_playsound::snd_play_delayed_2d("lag_intro_whoosh_05",5.2);
	soundscripts\_snd_playsound::snd_play_delayed_2d("lag_intro_whoosh_06",8.25);
	soundscripts\_snd_playsound::snd_play_delayed_2d("lag_intro_whoosh_07",9.5);
	soundscripts\_snd_playsound::snd_play_delayed_2d("lag_intro_whoosh_vent",10.7);
	soundscripts\_snd_playsound::snd_play_delayed_loop_2d("lag_intro_drone_amb_conf",10.7,undefined,"kill_conf_loop");
	wait(10.7);
	level notify("kill_office_loop");
}

//Function Number: 45
intro_bad_guy_4(param_00)
{
	param_00 soundscripts\_snd_playsound::snd_play_linked("lag_intro_guy_4");
}

//Function Number: 46
intro_bad_guy_5(param_00)
{
	param_00 soundscripts\_snd_playsound::snd_play_linked("lag_intro_guy_5");
}

//Function Number: 47
intro_bad_guy_6(param_00)
{
	param_00 soundscripts\_snd_playsound::snd_play_linked("lag_intro_guy_6");
}

//Function Number: 48
intro_hostage_leader(param_00)
{
	param_00 soundscripts\_snd_playsound::snd_play_linked("lag_intro_hostage_ldr_foley");
}

//Function Number: 49
intro_hostage_leader_2(param_00)
{
	param_00 soundscripts\_snd_playsound::snd_play_linked("lag_intro_hostage_ldr_foley_2");
}

//Function Number: 50
intro_hostage_leader_3(param_00)
{
	param_00 soundscripts\_snd_playsound::snd_play_linked("lag_intro_hostage_ldr_foley_3");
}

//Function Number: 51
intro_prime_minister(param_00)
{
	param_00 soundscripts\_snd_playsound::snd_play_linked("lag_intro_pm_foley");
}

//Function Number: 52
intro_prime_minister_2(param_00)
{
	param_00 soundscripts\_snd_playsound::snd_play_linked("lag_intro_pm_foley_2");
}

//Function Number: 53
intro_hostage_executed(param_00)
{
	param_00 soundscripts\_snd_playsound::snd_play_linked("lag_intro_hostage_execute");
	wait(9.46);
	soundscripts\_snd_playsound::snd_play_2d("lag_intro_kill_drone_feed");
	soundscripts\_audio_mix_manager::mm_clear_submix("lag_drone_intro",1);
}

//Function Number: 54
start_intro_ambience()
{
	soundscripts\_audio_zone_manager::azm_start_zone("ext_walkway");
	soundscripts\_snd_playsound::snd_play_loop_at("lag_walla_police_barricade",(-50565,14563,422),"stop_lag_walla_police_barricade",1,1,1);
}

//Function Number: 55
lag_intro_vo_overlap_mix()
{
	soundscripts\_audio_mix_manager::mm_add_submix("lag_intro_vo_overlap_mix",0.1);
	level waittill("lag_intro_vo_overlap_mix_done");
	soundscripts\_audio_mix_manager::mm_clear_submix("lag_intro_vo_overlap_mix",1);
}

//Function Number: 56
opening_warbird()
{
	level notify("kill_conf_loop");
	soundscripts\_audio_mix_manager::mm_add_submix("lagos_warbird_shutdown");
	soundscripts\_snd_playsound::snd_play_2d("warbird_shutdown_blades_front");
	soundscripts\_snd_playsound::snd_play_2d("warbird_shutdown_engine_front");
	soundscripts\_snd_playsound::snd_play_delayed_2d("warbird_shutdown_chop",5.09);
	soundscripts\_snd_playsound::snd_play_delayed_linked("warbird_shutdown_engine_3d",11.2);
	wait(18);
	soundscripts\_audio_mix_manager::mm_clear_submix("lagos_warbird_shutdown",5);
}

//Function Number: 57
setup_briefing_anims()
{
	wait(0.05);
	if(level.nextgen || level.transient_zone == "intro")
	{
		maps\_anim::addnotetrack_customfunction("burke","lag_gid_brief_start",::lag_gid_brief_start,"squad_opening");
		maps\_anim::addnotetrack_customfunction("burke","gideon_gun_prep",::gideon_gun_prep,"squad_opening");
		maps\_anim::addnotetrack_customfunction("burke","lag_gid_brief_equip",::lag_gid_brief_equip,"squad_opening");
		maps\_anim::addnotetrack_customfunction("joker","lag_joke_brief_equip_1",::lag_joke_brief_equip_1,"squad_opening");
		maps\_anim::addnotetrack_customfunction("joker","lag_joke_brief_radio",::lag_joke_brief_radio,"squad_opening");
		maps\_anim::addnotetrack_customfunction("joker","lag_joke_brief_equip_2",::lag_joke_brief_equip_2,"squad_opening");
		maps\_anim::addnotetrack_customfunction("joker","lag_joke_brief_wpn_check",::lag_joke_brief_wpn_check,"squad_opening");
		maps\_anim::addnotetrack_customfunction("joker","lag_joke_brief_equip_3",::lag_joke_brief_equip_3,"squad_opening");
		maps\_anim::addnotetrack_customfunction("joker","lag_joke_brief_approach_plr",::lag_joke_brief_approach_plr,"squad_opening");
		maps\_anim::addnotetrack_customfunction("ajani","lag_ajani_brief_start",::lag_ajani_brief_start,"squad_opening");
		maps\_anim::addnotetrack_customfunction("ajani","lag_ajani_brief_equip",::lag_ajani_brief_equip,"squad_opening");
	}
}

//Function Number: 58
lag_gid_brief_start(param_00)
{
	param_00 soundscripts\_snd_playsound::snd_play_linked("lag_gideon_brief_start");
}

//Function Number: 59
gideon_gun_prep(param_00)
{
	param_00 soundscripts\_snd_playsound::snd_play_linked("lag_gideon_brief_gun");
}

//Function Number: 60
lag_gid_brief_equip(param_00)
{
	param_00 soundscripts\_snd_playsound::snd_play_linked("lag_gideon_brief_equip");
}

//Function Number: 61
lag_joke_brief_equip_1(param_00)
{
	param_00 soundscripts\_snd_playsound::snd_play_linked("lag_joker_brief_equip_1");
}

//Function Number: 62
lag_joke_brief_radio(param_00)
{
	param_00 soundscripts\_snd_playsound::snd_play_linked("lag_joker_brief_radio");
}

//Function Number: 63
lag_joke_brief_equip_2(param_00)
{
	param_00 soundscripts\_snd_playsound::snd_play_linked("lag_joker_brief_equip_2");
}

//Function Number: 64
lag_joke_brief_wpn_check(param_00)
{
	param_00 soundscripts\_snd_playsound::snd_play_linked("lag_joker_brief_wpn_check");
}

//Function Number: 65
lag_joke_brief_equip_3(param_00)
{
	param_00 soundscripts\_snd_playsound::snd_play_linked("lag_joker_brief_equip_3");
}

//Function Number: 66
lag_joke_brief_approach_plr(param_00)
{
	param_00 soundscripts\_snd_playsound::snd_play_linked("lag_joker_brief_equip_to_plr");
}

//Function Number: 67
lag_ajani_brief_start(param_00)
{
}

//Function Number: 68
lag_ajani_brief_equip(param_00)
{
	param_00 soundscripts\_snd_playsound::snd_play_linked("lag_ajani_brief");
}

//Function Number: 69
vig_tram_setup_car(param_00,param_01)
{
	var_02 = self;
	param_01 = soundscripts\_audio::aud_get_optional_param(1,param_01);
	var_03 = 2;
	var_04 = 2;
	var_05 = "lag_tram_lp" + soundscripts\_snd::snd_new_guid();
	var_06 = var_02 soundscripts\_snd_playsound::snd_play_loop_linked("lag_tram_lp",var_05,var_03,var_04,param_01);
	var_02 thread monitor_tram(var_06,var_05);
	if(param_00)
	{
		if(!isdefined(level.aud.tramby_id))
		{
			level.aud.tramby_id = 1;
		}

		var_07 = "lag_tramby_0" + level.aud.tramby_id;
		level.aud.tramby_id = level.aud.tramby_id + 1;
		if(level.aud.tramby_id > 3)
		{
			level.aud.tramby_id = 1;
		}

		var_02 soundscripts\_snd_common::snd_waittill_within_radius(2800);
		var_08 = var_02 soundscripts\_snd_playsound::snd_play_linked(var_07,undefined,undefined,undefined,param_01);
	}
}

//Function Number: 70
monitor_tram(param_00,param_01,param_02)
{
	var_03 = self;
	var_04 = 0.05;
	var_05 = 0.6;
	var_06 = 0.6;
	var_07 = 0;
	var_08 = 0;
	var_09 = [[0,0.1],[1200,1]];
	param_02 = soundscripts\_audio::aud_get_optional_param(1,param_02);
	while(isdefined(param_00) && isdefined(var_03))
	{
		if(param_02)
		{
			var_0A = dopplerpitch(var_03.origin,var_03 maps\_shg_utility::get_differentiated_velocity(),level.player.origin,level.player maps\_shg_utility::get_differentiated_velocity(),var_05,var_06);
			param_00 scalepitch(var_0A,var_04);
		}

		var_08 = var_03 maps\_shg_utility::get_differentiated_speed();
		if(var_08 < var_07 && var_08 < 1)
		{
			level notify(param_01);
			break;
		}

		var_07 = var_08;
		wait(var_04);
		waittillframeend;
	}
}

//Function Number: 71
setup_exo_door_kick_anims()
{
	if(level.currentgen && level.transient_zone != "intro")
	{
		return;
	}

	maps\_anim::addnotetrack_customfunction("player_rig","exo_door_footstep_01",::exo_door_footstep_01,"exo_door");
	maps\_anim::addnotetrack_customfunction("player_rig","exo_door_footstep_02",::exo_door_footstep_02,"exo_door");
	maps\_anim::addnotetrack_customfunction("player_rig","exo_door_footstep_03",::exo_door_footstep_03,"exo_door");
	maps\_anim::addnotetrack_customfunction("player_rig","exo_door_footstep_04",::exo_door_footstep_04,"exo_door");
}

//Function Number: 72
plr_exo_door_kick()
{
	soundscripts\_audio_mix_manager::mm_add_submix("exo_door_kick",2);
	soundscripts\_snd_playsound::snd_play_delayed_2d("door_kick_foley",0.65);
	soundscripts\_snd_playsound::snd_play_delayed_2d("plr_door_kick_exo",0.82);
	soundscripts\_snd_playsound::snd_play_delayed_2d("plr_door_kick_impact",1.45);
	level notify("stop_lag_walla_police_barricade");
}

//Function Number: 73
exo_door_footstep_01(param_00)
{
	soundscripts\_snd_playsound::snd_play_delayed_2d("step_sprint_plr_default_r",0);
	soundscripts\_snd_playsound::snd_play_delayed_2d("gear_rattle_plr_sprint_r",0);
}

//Function Number: 74
exo_door_footstep_02(param_00)
{
	soundscripts\_snd_playsound::snd_play_delayed_2d("step_sprint_plr_default_l",0);
	soundscripts\_snd_playsound::snd_play_delayed_2d("gear_rattle_plr_sprint_l",0);
}

//Function Number: 75
exo_door_footstep_03(param_00)
{
	soundscripts\_snd_playsound::snd_play_delayed_2d("step_sprint_plr_default_r",0.05);
	soundscripts\_snd_playsound::snd_play_delayed_2d("gear_rattle_plr_sprint_r",0.05);
	soundscripts\_audio_mix_manager::mm_clear_submix("exo_door_kick",2);
}

//Function Number: 76
exo_door_footstep_04(param_00)
{
	soundscripts\_snd_playsound::snd_play_delayed_2d("step_run_plr_default_l",0.15);
	soundscripts\_snd_playsound::snd_play_delayed_2d("gear_rattle_plr_run_l",0.15);
}

//Function Number: 77
gov_bldg_driveup()
{
	var_00 = self;
	if(level.aud.truck_swap == 0)
	{
		level.aud.truck_swap = 1;
		var_00 soundscripts\_snd_playsound::snd_play_delayed_linked("lag_gov_driveup_01",1.7);
		return;
	}

	if(level.aud.truck_swap == 1)
	{
		var_00 soundscripts\_snd_playsound::snd_play_delayed_linked("lag_gov_driveup_02",9.2);
	}
}

//Function Number: 78
aud_exo_climb_burke(param_00)
{
	soundscripts\_audio_mix_manager::mm_add_submix("lagos_exo_climb",5);
	soundscripts\_snd_playsound::snd_play_delayed_2d("lag_exo_climb_burke",0.05);
}

//Function Number: 79
exo_climb_pullup_start(param_00)
{
	soundscripts\_snd_playsound::snd_play_delayed_2d("lag_exo_climb_start",7.45);
}

//Function Number: 80
exo_climb_right_swing_pressed(param_00)
{
}

//Function Number: 81
exo_climb_left_swing_pressed(param_00)
{
}

//Function Number: 82
setup_wall_climb_foley()
{
	if(level.currentgen && level.transient_zone != "intro")
	{
		return;
	}

	maps\_anim::addnotetrack_customfunction("player_rig","aud_exo_climb_gear_lt",::maps\_exo_climb::aud_exo_climb_gear_lt,"exo_climb_pullup_start");
	maps\_anim::addnotetrack_customfunction("player_rig","aud_exo_climb_windup_lt",::maps\_exo_climb::aud_exo_climb_windup_lt,"exo_climb_pullup_start");
	maps\_anim::addnotetrack_customfunction("player_rig","aud_exo_climb_hit_lt",::maps\_exo_climb::aud_exo_climb_hit_lt,"exo_climb_pullup_start");
	maps\_anim::addnotetrack_customfunction("player_rig","aud_exo_climb_gear_rt",::maps\_exo_climb::aud_exo_climb_gear_rt,"exo_climb_pullup_exit");
	maps\_anim::addnotetrack_customfunction("player_rig","aud_exo_climb_windup_lt",::maps\_exo_climb::aud_exo_climb_windup_lt,"exo_climb_pullup_exit");
	maps\_anim::addnotetrack_customfunction("player_rig","aud_exo_climb_windup_rt",::maps\_exo_climb::aud_exo_climb_windup_rt,"exo_climb_pullup_exit");
	maps\_anim::addnotetrack_customfunction("player_rig","aud_exo_climb_hit_lt",::maps\_exo_climb::aud_exo_climb_hit_lt,"exo_climb_pullup_exit");
	maps\_anim::addnotetrack_customfunction("player_rig","aud_exo_climb_hit_rt",::maps\_exo_climb::aud_exo_climb_hit_rt,"exo_climb_pullup_exit");
	maps\_anim::addnotetrack_customfunction("player_rig","lag_gov_wallpullup_exit",::lag_gov_wallpullup_exit,"exo_climb_pullup_exit");
	maps\_anim::addnotetrack_customfunction("player_rig","lag_gov_wallpullup_exit_foot",::lag_gov_wallpullup_exit_foot,"exo_climb_pullup_exit");
	maps\_anim::addnotetrack_customfunction("ajani","lag_npc_exo_climb_foley",::lag_npc_exo_climb_foley,"exo_climb_ajani");
}

//Function Number: 83
setup_alley_wall_climb_foley()
{
	maps\_anim::addnotetrack_customfunction("player_rig","aud_exo_climb_windup_lt",::maps\_exo_climb::aud_exo_climb_windup_lt,"flank_wall_climb");
	maps\_anim::addnotetrack_customfunction("player_rig","aud_exo_climb_windup_rt",::maps\_exo_climb::aud_exo_climb_windup_rt,"flank_wall_climb");
	maps\_anim::addnotetrack_customfunction("player_rig","aud_exo_climb_hit_lt",::maps\_exo_climb::aud_exo_climb_hit_lt,"flank_wall_climb");
	maps\_anim::addnotetrack_customfunction("player_rig","aud_exo_climb_hit_rt",::maps\_exo_climb::aud_exo_climb_hit_rt,"flank_wall_climb");
	maps\_anim::addnotetrack_customfunction("player_rig","aud_exo_climb_flank_over",::aud_exo_climb_flank_over,"flank_wall_climb");
	maps\_anim::addnotetrack_customfunction("player_rig","aud_exo_climb_flank_land",::aud_exo_climb_flank_land,"flank_wall_climb");
	maps\_anim::addnotetrack_customfunction("burke","aud_exo_climb_gideon_land",::aud_exo_climb_gideon_land,"flank_wall_climb");
}

//Function Number: 84
lag_gov_wallpullup_exit(param_00)
{
	soundscripts\_snd_playsound::snd_play_2d("lag_exo_climb_pullup_exit");
}

//Function Number: 85
lag_gov_wallpullup_exit_foot(param_00)
{
	soundscripts\_snd_playsound::snd_play_delayed_2d("lag_exo_climb_pullup_exit_foot",0);
	wait(3.5);
	soundscripts\_audio_mix_manager::mm_clear_submix("lagos_exo_climb");
}

//Function Number: 86
lag_npc_exo_climb_foley(param_00)
{
	param_00 soundscripts\_snd_playsound::snd_play_linked("lag_npc_exo_climb_foley");
}

//Function Number: 87
aud_exo_climb_flank_over(param_00)
{
	soundscripts\_snd_playsound::snd_play_2d("exo_climb_flank_climb_over");
}

//Function Number: 88
aud_exo_climb_flank_land(param_00)
{
	soundscripts\_snd_playsound::snd_play_2d("exo_climb_flank_land");
}

//Function Number: 89
aud_exo_climb_gideon_land(param_00)
{
	soundscripts\_snd_playsound::snd_play_2d("exo_climb_flank_land_gideon");
}

//Function Number: 90
gov_building_mute_device()
{
	var_00 = self;
	level.player enablecustomweaponcontext();
	enablesoundcontextoverride("mute");
	soundscripts\_snd_playsound::snd_play_delayed_2d("mute_device_activate",0.75);
	wait(1.25);
	var_00 thread soundscripts\_snd_common::snd_mute_device("mute_device",400,650,18,"mute_device");
	wait(18);
	common_scripts\utility::flag_set("flag_roof_breach_mute_complete");
	disablesoundcontextoverride("mute");
	level.player disablecustomweaponcontext();
}

//Function Number: 91
setup_roof_breach_anims()
{
	wait(0.05);
	if(level.nextgen || level.transient_zone == "intro")
	{
		maps\_anim::addnotetrack_customfunction("burke","roof_breach_burke_plant",::roof_breach_burke_plant,"roof_mute_breach_plant");
		maps\_anim::addnotetrack_customfunction("burke","laser_detonate",::roof_breach_laser_detonate,"roof_mute_breach_plant");
		maps\_anim::addnotetrack_customfunction("burke","breach_gideon_land",::breach_gideon_land,"roof_mute_breach_jumpdown");
		maps\_anim::addnotetrack_customfunction("joker","breach_joker_land",::breach_joker_land,"roof_mute_breach_jumpdown");
		maps\_anim::addnotetrack_customfunction("ajani","breach_ajani_land",::breach_ajani_land,"roof_mute_breach_jumpdown");
		maps\_anim::addnotetrack_customfunction("player_rig","breach_player_land",::breach_player_land,"roof_mute_breach_jumpdown");
	}
}

//Function Number: 92
roof_breach_burke_plant(param_00)
{
	soundscripts\_snd_playsound::snd_play_2d("lag_roof_burke_plant");
}

//Function Number: 93
roof_breach_laser_detonate(param_00)
{
	soundscripts\_snd_playsound::snd_play_2d("lag_roof_exp");
}

//Function Number: 94
rooftop_slo_mo_override()
{
	soundscripts\_snd_timescale::snd_set_timescale("lagos_timescale_override");
	soundscripts\_snd_playsound::snd_play_2d("lag_roof_slo_mo");
	wait(10);
	soundscripts\_snd_timescale::snd_set_timescale("lagos_default");
}

//Function Number: 95
breach_gideon_land(param_00)
{
	param_00 soundscripts\_snd_playsound::snd_play_linked("lag_roof_gid_land");
}

//Function Number: 96
breach_joker_land(param_00)
{
}

//Function Number: 97
breach_ajani_land(param_00)
{
	param_00 soundscripts\_snd_playsound::snd_play_linked("lag_roof_ajani_land");
}

//Function Number: 98
breach_player_land(param_00)
{
	soundscripts\_snd_playsound::snd_play_2d("lag_roof_player_land");
}

//Function Number: 99
hb_gun_away()
{
	soundscripts\_snd_playsound::snd_play_2d("lag_hb_gun_away");
}

//Function Number: 100
setup_harmonic_breach_anims()
{
	wait(0.05);
	if(level.currentgen && level.transient_zone != "intro")
	{
		return;
	}

	maps\_anim::addnotetrack_customfunction("joker","joker_harmonic_start",::hb_joker_start,"h_breach");
	maps\_anim::addnotetrack_customfunction("joker","joker_harmonic_catch",::hb_joker_catch,"h_breach");
	maps\_anim::addnotetrack_customfunction("joker","joker_harmonic_step_back",::hb_joker_step_back,"h_breach");
	maps\_anim::addnotetrack_customfunction("player_arms","player_harmonic_start",::hb_player_start,"h_breach");
	maps\_anim::addnotetrack_customfunction("player_arms","player_harmonic_plant_1",::hb_player_plant,"h_breach");
}

//Function Number: 101
hb_joker_start(param_00)
{
}

//Function Number: 102
hb_joker_catch(param_00)
{
	param_00 soundscripts\_snd_playsound::snd_play_linked("lag_hb_plant_joker");
}

//Function Number: 103
hb_joker_step_back(param_00)
{
}

//Function Number: 104
hb_player_start(param_00)
{
	soundscripts\_snd_playsound::snd_play_2d("lag_hb_equip_player");
}

//Function Number: 105
hb_player_plant(param_00)
{
	soundscripts\_snd_playsound::snd_play_2d("lag_hb_plant_player");
}

//Function Number: 106
hb_sensor_flash_on()
{
	level endon("BreachComplete");
	soundscripts\_audio_mix_manager::mm_add_submix("lag_harmonic_breach",0.5);
	soundscripts\_snd_playsound::snd_play_2d("lag_hb_activate");
	soundscripts\_snd_playsound::snd_play_loop_2d("lag_hb_loop","kill_hb_loop",1,0.5);
	soundscripts\_snd_playsound::snd_play_2d("lag_hb_radio_noise","kill_radio_transmission",0.05,0.05);
	level waittill("BreachFailed");
	level notify("kill_radio_transmission");
}

//Function Number: 107
hb_highlight_enable(param_00)
{
	soundscripts\_snd_playsound::snd_play_linked("lag_hb_highlight");
	soundscripts\_snd_playsound::snd_play_loop_linked("lag_hb_highlight_loop","kill_highlight_loop",0.05,0.05);
}

//Function Number: 108
hb_highlight_disable()
{
	level notify("kill_highlight_loop");
}

//Function Number: 109
hb_target_tagged(param_00)
{
	soundscripts\_snd_playsound::snd_play_linked("lag_hb_tag");
	level notify("kill_highlight_loop");
}

//Function Number: 110
hb_target_untagged(param_00)
{
	soundscripts\_snd_playsound::snd_play_loop_linked("lag_hb_highlight_loop","kill_highlight_loop",0.05,0.05);
}

//Function Number: 111
hb_lock_targets()
{
	soundscripts\_snd_playsound::snd_play_2d("lag_hb_target_lock");
}

//Function Number: 112
hb_shots_fired()
{
	soundscripts\_snd_playsound::snd_play_2d("lag_hb_bullet_hits");
	level notify("kill_radio_transmission");
	soundscripts\_audio_mix_manager::mm_add_submix("lag_harmonic_breach_vo");
	wait(3);
	soundscripts\_audio_mix_manager::mm_clear_submix("lag_harmonic_breach_vo");
}

//Function Number: 113
hb_sensor_flash_off()
{
	soundscripts\_snd_playsound::snd_play_2d("lag_hb_deactivate");
	level notify("kill_hb_loop");
	soundscripts\_audio_mix_manager::mm_clear_submix("lag_harmonic_breach",3);
}

//Function Number: 114
setup_pm_rescue_anims()
{
	wait(0.05);
	if(level.currentgen && level.transient_zone != "intro")
	{
		return;
	}

	maps\_anim::addnotetrack_customfunction("burke","h_breach_exo_kick",::h_breach_exo_kick,"h_breach_pt1");
	maps\_anim::addnotetrack_customfunction("kva_2","kva_crawling",::kva_crawling,"h_breach_pt1");
	maps\_anim::addnotetrack_customfunction("kva_2","kva_gets_shot",::kva_gets_shot,"h_breach_pt1");
}

//Function Number: 115
h_breach_exo_kick(param_00)
{
	param_00 soundscripts\_snd_playsound::snd_play_linked("lag_gideon_kick_door_exo");
	thread play_pm_rescue_walla();
}

//Function Number: 116
kva_crawling(param_00)
{
	param_00 soundscripts\_snd_playsound::snd_play_linked("lag_rescue_kva_crawl");
}

//Function Number: 117
kva_gets_shot(param_00)
{
	param_00 soundscripts\_snd_playsound::snd_play_delayed_linked("lag_rescue_kva_gets_shot",0.2);
}

//Function Number: 118
pm_rescue_foley()
{
	soundscripts\_snd_playsound::snd_play_delayed_2d("lag_rescue_pm_foley_misc_01",0);
	soundscripts\_snd_playsound::snd_play_delayed_2d("lag_rescue_pm_foley_misc_02",17.92);
	soundscripts\_snd_playsound::snd_play_delayed_2d("lag_rescue_pm_foley_misc_03",29.15);
	soundscripts\_snd_playsound::snd_play_delayed_2d("lag_rescue_pm_foley_footsteps_01",4.35);
	soundscripts\_snd_playsound::snd_play_delayed_2d("lag_rescue_pm_foley_footsteps_02",14.02);
	soundscripts\_snd_playsound::snd_play_delayed_2d("lag_rescue_pm_foley_footsteps_03",25.09);
	soundscripts\_snd_playsound::snd_play_delayed_2d("lag_rescue_pm_foley_hostage_bg_01",0);
	soundscripts\_snd_playsound::snd_play_delayed_2d("lag_rescue_pm_foley_cuffs_breaking_01",0.1);
	soundscripts\_snd_playsound::snd_play_delayed_2d("lag_rescue_pm_foley_gear_01",0);
	soundscripts\_snd_playsound::snd_play_delayed_2d("lag_rescue_pm_foley_gear_02",6.72);
	soundscripts\_snd_playsound::snd_play_delayed_2d("lag_rescue_pm_foley_gear_03",14.02);
	soundscripts\_snd_playsound::snd_play_delayed_2d("lag_rescue_pm_foley_gear_04",20.59);
	soundscripts\_snd_playsound::snd_play_delayed_2d("lag_rescue_pm_foley_gear_05",24.21);
	soundscripts\_snd_playsound::snd_play_delayed_2d("lag_rescue_pm_foley_pm_movement_01",0);
	soundscripts\_snd_playsound::snd_play_delayed_2d("lag_rescue_pm_xbuttonpush_01",0);
}

//Function Number: 119
play_pm_rescue_walla()
{
	wait(0.5);
	var_00 = soundscripts\_snd_playsound::snd_play_at("lag_walla_pm_rescue",(-52215,9177,494),"stop_lag_walla_pm_rescue",0,5);
	var_00 scalevolume(0.7,30);
	wait(30);
	level notify("stop_lag_walla_pm_rescue");
	soundscripts\_snd_playsound::snd_play_loop_at("lag_walla_pm_rescue_lp",(-52437,9214,494),"stop_lag_walla_pm_rescue_lp",5,5,1);
}

//Function Number: 120
leaving_gov_building_post_vo()
{
	wait(0.5);
	music("leaving_gov_building_post_vo");
	wait(60);
	level notify("stop_lag_walla_pm_rescue_lp");
}

//Function Number: 121
roundabout_general_mayhem()
{
	soundscripts\_audio_mix_manager::mm_add_submix("lag_roundabout_attack",0.05);
	wait(0.82);
	soundscripts\_snd_playsound::snd_play_2d("lag_rndabt_attack_init_explo");
	soundscripts\_snd_playsound::snd_play_2d("bus_van_crash_impact");
	wait(3);
	soundscripts\_audio_mix_manager::mm_add_submix("lag_roundabout_big_explo",0.05);
	soundscripts\_snd_playsound::snd_play_2d("lag_rndabt_attack_gen_explo");
	wait(1);
	soundscripts\_audio_mix_manager::mm_clear_submix("lag_roundabout_attack",0.5);
	wait(3);
	soundscripts\_audio_mix_manager::mm_clear_submix("lag_roundabout_big_explo");
}

//Function Number: 122
roundabout_rpg_fire()
{
	var_00 = self;
	var_00 soundscripts\_snd_playsound::snd_play_linked("lag_rndabt_rpg_incoming");
	var_01 = var_00.origin;
	while(isdefined(var_00))
	{
		var_01 = var_00.origin;
		wait(0.05);
	}

	soundscripts\_snd_playsound::snd_play_at("lag_rndabt_rpg_explo",var_01);
}

//Function Number: 123
setup_roundabout_rpg_fire_emitters()
{
	level waittill("aud_roundabout_combat_started");
	var_00 = 1;
	var_01 = 5;
	soundscripts\_snd_playsound::snd_play_loop_at("emt_fire_grnd_sizzle",(-52411,6121,259),"rpg_fire_loops_kill",var_00,var_01);
	soundscripts\_snd_playsound::snd_play_loop_at("emt_fire_grnd_chem",(-52411,6121,259),"rpg_fire_loops_kill",var_00,var_01);
	soundscripts\_snd_playsound::snd_play_loop_at("emt_fire_grnd_crckl",(-52411,6121,259),"rpg_fire_loops_kill",var_00,var_01);
	soundscripts\_snd_playsound::snd_play_loop_at("emt_fire_grnd_bys",(-52411,6121,259),"rpg_fire_loops_kill",var_00,var_01);
	soundscripts\_snd_playsound::snd_play_loop_at("emt_fire_grnd_roar_01",(-52411,6121,259),"rpg_fire_loops_kill",var_00,var_01);
	soundscripts\_snd_playsound::snd_play_loop_at("emt_fire_grnd_sizzle",(-52300,5952,230),"rpg_fire_loops_kill",var_00,var_01);
	soundscripts\_snd_playsound::snd_play_loop_at("emt_fire_grnd_chem",(-52300,5952,230),"rpg_fire_loops_kill",var_00,var_01);
	soundscripts\_snd_playsound::snd_play_loop_at("emt_fire_grnd_roar_02",(-52300,5952,230),"rpg_fire_loops_kill",var_00,var_01);
	soundscripts\_snd_playsound::snd_play_loop_at("emt_fire_grnd_sizzle",(-51747,5687,230),"rpg_fire_loops_kill",var_00,var_01);
	soundscripts\_snd_playsound::snd_play_loop_at("emt_fire_grnd_crckl",(-51747,5687,230),"rpg_fire_loops_kill",var_00,var_01);
	soundscripts\_snd_playsound::snd_play_loop_at("emt_fire_grnd_roar_01",(-51747,5687,230),"rpg_fire_loops_kill",var_00,var_01);
	soundscripts\_snd_playsound::snd_play_loop_at("emt_fire_grnd_sizzle",(-51662,5537,250),"rpg_fire_loops_kill",var_00,var_01);
	soundscripts\_snd_playsound::snd_play_loop_at("emt_fire_grnd_bys",(-51662,5537,250),"rpg_fire_loops_kill",var_00,var_01);
	soundscripts\_snd_playsound::snd_play_loop_at("emt_fire_grnd_roar_02",(-51662,5537,250),"rpg_fire_loops_kill",var_00,var_01);
	soundscripts\_snd_playsound::snd_play_loop_at("emt_fire_grnd_crckl",(-51531,5693,192),"rpg_fire_loops_kill",var_00,var_01);
	soundscripts\_snd_playsound::snd_play_loop_at("emt_fire_grnd_sizzle",(-51381,5675,192),"rpg_fire_loops_kill",var_00,var_01);
	soundscripts\_snd_playsound::snd_play_loop_at("emt_fire_grnd_chem",(-51535,5442,192),"rpg_fire_loops_kill",var_00,var_01);
	soundscripts\_snd_playsound::snd_play_loop_at("emt_fire_grnd_crckl",(-51401,5429,192),"rpg_fire_loops_kill",var_00,var_01);
	soundscripts\_snd_playsound::snd_play_loop_at("emt_fire_grnd_crckl",(-51517,4932,192),"rpg_fire_loops_kill",var_00,var_01);
}

//Function Number: 124
setup_roundabout_tanker_proxy_fire_emitters()
{
	level waittill("aud_roundabout_tanker_explosion");
	var_00 = 2;
	var_01 = 3;
	soundscripts\_snd_playsound::snd_play_loop_at("emt_fire_grnd_sizzle",(-51792,5204,237),"tanker_proxy_fire_loops_kill",var_00,var_01);
	soundscripts\_snd_playsound::snd_play_loop_at("emt_fire_grnd_chem",(-51792,5204,237),"tanker_proxy_fire_loops_kill",var_00,var_01);
	soundscripts\_snd_playsound::snd_play_loop_at("emt_fire_grnd_roar_02",(-51954,5010,237),"tanker_proxy_fire_loops_kill",var_00,var_01);
	soundscripts\_snd_playsound::snd_play_loop_at("emt_fire_grnd_crckl",(-51954,5010,237),"tanker_proxy_fire_loops_kill",var_00,var_01);
	soundscripts\_snd_playsound::snd_play_loop_at("emt_fire_grnd_roar_01",(-51753,4865,237),"tanker_proxy_fire_loops_kill",var_00,var_01);
	soundscripts\_snd_playsound::snd_play_loop_at("emt_fire_grnd_sizzle",(-51866,4693,237),"tanker_proxy_fire_loops_kill",var_00,var_01);
	soundscripts\_snd_playsound::snd_play_loop_at("emt_fire_grnd_roar_02",(-52090,4638,237),"tanker_proxy_fire_loops_kill",var_00,var_01);
	soundscripts\_snd_playsound::snd_play_loop_at("emt_fire_grnd_crckl",(-51517,4932,237),"tanker_proxy_fire_loops_kill",var_00,var_01);
	soundscripts\_snd_playsound::snd_play_loop_at("emt_fire_grnd_roar_01",(-52227,4773,237),"tanker_proxy_fire_loops_kill",var_00,var_01);
	soundscripts\_snd_playsound::snd_play_loop_at("emt_fire_grnd_crckl",(-52227,4773,237),"tanker_proxy_fire_loops_kill",var_00,var_01);
	soundscripts\_snd_playsound::snd_play_loop_at("emt_fire_grnd_crckl",(-52549,4595,237),"tanker_proxy_fire_loops_kill",var_00,var_01);
	soundscripts\_snd_playsound::snd_play_loop_at("emt_fire_grnd_bys",(-52549,4595,237),"tanker_proxy_fire_loops_kill",var_00,var_01);
	soundscripts\_snd_playsound::snd_play_loop_at("emt_fire_grnd_roar_02",(-52842,4545,237),"tanker_proxy_fire_loops_kill",var_00,var_01);
	soundscripts\_snd_playsound::snd_play_loop_at("emt_fire_grnd_sizzle",(-52842,4545,237),"tanker_proxy_fire_loops_kill",var_00,var_01);
	soundscripts\_snd_playsound::snd_play_loop_at("emt_fire_tanker_lrg",(-52365,4257,377),"all_fire_emitters_kill");
	soundscripts\_snd_playsound::snd_play_loop_at("emt_fire_grnd_sizzle",(-51889,4284,239),"all_fire_emitters_kill");
	soundscripts\_snd_playsound::snd_play_loop_at("emt_fire_grnd_chem",(-51889,4284,239),"all_fire_emitters_kill");
	soundscripts\_snd_playsound::snd_play_loop_at("emt_fire_grnd_crckl",(-51889,4284,239),"all_fire_emitters_kill");
	soundscripts\_snd_playsound::snd_play_loop_at("emt_fire_grnd_bys",(-51889,4284,239),"all_fire_emitters_kill");
	soundscripts\_snd_playsound::snd_play_loop_at("emt_fire_grnd_roar_01",(-51889,4284,239),"all_fire_emitters_kill");
	soundscripts\_snd_playsound::snd_play_loop_at("emt_fire_grnd_sizzle",(-52172,4316,239),"all_fire_emitters_kill");
	soundscripts\_snd_playsound::snd_play_loop_at("emt_fire_grnd_chem",(-52172,4316,239),"all_fire_emitters_kill");
	soundscripts\_snd_playsound::snd_play_loop_at("emt_fire_grnd_crckl",(-52172,4316,239),"all_fire_emitters_kill");
	soundscripts\_snd_playsound::snd_play_loop_at("emt_fire_grnd_bys",(-52172,4316,239),"all_fire_emitters_kill");
	soundscripts\_snd_playsound::snd_play_loop_at("emt_fire_grnd_roar_02",(-52172,4316,239),"all_fire_emitters_kill");
	soundscripts\_snd_playsound::snd_play_loop_at("emt_fire_grnd_sizzle",(-52372,4314,216),"all_fire_emitters_kill");
	soundscripts\_snd_playsound::snd_play_loop_at("emt_fire_grnd_crckl",(-52372,4314,216),"all_fire_emitters_kill");
	soundscripts\_snd_playsound::snd_play_loop_at("emt_fire_grnd_bys",(-52372,4314,216),"all_fire_emitters_kill");
	soundscripts\_snd_playsound::snd_play_loop_at("emt_fire_grnd_roar_01",(-52372,4314,216),"all_fire_emitters_kill");
	soundscripts\_snd_playsound::snd_play_loop_at("emt_fire_grnd_sizzle",(-51670,4442,209),"all_fire_emitters_kill");
	soundscripts\_snd_playsound::snd_play_loop_at("emt_fire_grnd_chem",(-51670,4442,209),"all_fire_emitters_kill");
	soundscripts\_snd_playsound::snd_play_loop_at("emt_fire_grnd_bys",(-51670,4442,209),"all_fire_emitters_kill");
	soundscripts\_snd_playsound::snd_play_loop_at("emt_fire_grnd_roar_02",(-51670,4442,209),"all_fire_emitters_kill");
	soundscripts\_snd_playsound::snd_play_loop_at("emt_fire_grnd_sizzle",(-51863,4482,209),"all_fire_emitters_kill");
	soundscripts\_snd_playsound::snd_play_loop_at("emt_fire_grnd_chem",(-51863,4482,209),"all_fire_emitters_kill");
	soundscripts\_snd_playsound::snd_play_loop_at("emt_fire_grnd_crckl",(-51863,4482,209),"all_fire_emitters_kill");
	soundscripts\_snd_playsound::snd_play_loop_at("emt_fire_grnd_roar_02",(-51863,4482,209),"all_fire_emitters_kill");
	soundscripts\_snd_playsound::snd_play_loop_at("emt_fire_grnd_sizzle",(-51907,4502,222),"all_fire_emitters_kill");
	soundscripts\_snd_playsound::snd_play_loop_at("emt_fire_grnd_chem",(-51907,4502,222),"all_fire_emitters_kill");
	soundscripts\_snd_playsound::snd_play_loop_at("emt_fire_grnd_crckl",(-51907,4502,222),"all_fire_emitters_kill");
	soundscripts\_snd_playsound::snd_play_loop_at("emt_fire_grnd_bys",(-51907,4502,222),"all_fire_emitters_kill");
	soundscripts\_snd_playsound::snd_play_loop_at("emt_fire_grnd_roar_02",(-51907,4502,222),"all_fire_emitters_kill");
	soundscripts\_snd_playsound::snd_play_loop_at("emt_fire_grnd_sizzle",(-51997,4414,228),"all_fire_emitters_kill");
	soundscripts\_snd_playsound::snd_play_loop_at("emt_fire_grnd_chem",(-51997,4414,228),"all_fire_emitters_kill");
	soundscripts\_snd_playsound::snd_play_loop_at("emt_fire_grnd_crckl",(-51997,4414,228),"all_fire_emitters_kill");
	soundscripts\_snd_playsound::snd_play_loop_at("emt_fire_grnd_bys",(-51997,4414,228),"all_fire_emitters_kill");
	soundscripts\_snd_playsound::snd_play_loop_at("emt_fire_grnd_roar_01",(-51997,4414,228),"all_fire_emitters_kill");
	soundscripts\_snd_playsound::snd_play_loop_at("emt_fire_grnd_sizzle",(-52603,4237,354),"all_fire_emitters_kill");
	soundscripts\_snd_playsound::snd_play_loop_at("emt_fire_grnd_chem",(-52603,4237,354),"all_fire_emitters_kill");
	soundscripts\_snd_playsound::snd_play_loop_at("emt_fire_grnd_bys",(-52603,4237,354),"all_fire_emitters_kill");
	soundscripts\_snd_playsound::snd_play_loop_at("emt_fire_grnd_roar_02",(-52603,4237,354),"all_fire_emitters_kill");
}

//Function Number: 125
setup_roundabout_point_source_dambs()
{
	level waittill("aud_roundabout_tanker_explosion");
	soundscripts\_audio_dynamic_ambi::damb_start_preset_at_point("damb_lag_fire_rain",(-51950,4876,275),"fire_rain_01");
	soundscripts\_audio_dynamic_ambi::damb_start_preset_at_point("damb_lag_fire_rain",(-51588,5296,275),"fire_rain_02");
	soundscripts\_audio_dynamic_ambi::damb_start_preset_at_point("damb_lag_fire_rain",(-51361,4806,275),"fire_rain_03");
	level waittill("tanker_proxy_fire_loops_kill");
	soundscripts\_audio_dynamic_ambi::damb_stop_preset_at_point("damb_lag_fire_rain","fire_rain_01",2);
	soundscripts\_audio_dynamic_ambi::damb_stop_preset_at_point("damb_lag_fire_rain","fire_rain_02",2);
	soundscripts\_audio_dynamic_ambi::damb_stop_preset_at_point("damb_lag_fire_rain","fire_rain_03",2);
}

//Function Number: 126
roundabout_panic_walla()
{
	thread roundabout_walla_flag_explosion();
	soundscripts\_snd_playsound::snd_play_loop_2d("lag_walla_rndabt_panic_tense","stop_lag_walla_rndabt_panic_tense",4,3,0.8);
	level waittill("aud_roundabout_combat_started");
	wait(1);
	var_00 = soundscripts\_snd_playsound::snd_play_2d("lag_walla_rndabt_panic_hi","stop_lag_walla_rndabt_panic_hi",0,4,1);
	level notify("stop_lag_walla_rndabt_panic_tense");
	wait(7);
	var_01 = soundscripts\_snd_playsound::snd_play_loop_2d("lag_walla_rndabt_panic_md","lag_walla_rndabt_panic_md",4,4,1);
	level notify("stop_lag_walla_rndabt_panic_hi");
	var_01 scalevolume(0.4,5);
	wait(10);
	var_02 = soundscripts\_snd_playsound::snd_play_loop_2d("lag_walla_rndabt_panic_dist","lag_walla_rndabt_panic_dist",4,60,0.5);
	level notify("lag_walla_rndabt_panic_md");
	soundscripts\_audio_mix_manager::mm_add_submix("lag_roundabout_combat");
	var_02 scalevolume(0.2,40);
	while(!isdefined(level.aud.tanker_exploded))
	{
		wait 0.05;
	}

	level notify("lag_walla_rndabt_panic_dist");
}

//Function Number: 127
roundabout_walla_flag_explosion()
{
	level waittill("aud_roundabout_tanker_explosion");
	level.aud.tanker_exploded = 1;
}

//Function Number: 128
roundabout_combat_started()
{
	soundscripts\_audio_zone_manager::azm_set_zone_streamed_ambience("ext_roundabout","amb_ext_traffic_combat");
	level notify("aud_roundabout_combat_started");
	wait(10);
	level notify("rpg_fire_loops_kill");
}

//Function Number: 129
roundabout_tanker_explosion()
{
	soundscripts\_snd_playsound::snd_play_delayed_2d("tanker_explosion_front",0);
	soundscripts\_snd_playsound::snd_play_delayed_2d("tanker_explosion_lfe",0);
	soundscripts\_snd_playsound::snd_play_delayed_2d("tanker_explosion_rear",0.25);
	level notify("aud_roundabout_tanker_explosion");
	soundscripts\_audio_mix_manager::mm_clear_submix("lag_roundabout_combat");
	wait(10);
	level notify("tanker_proxy_fire_loops_kill");
}

//Function Number: 130
crossing_into_alley()
{
	level notify("all_fire_emitters_kill");
}

//Function Number: 131
roundabout_exited()
{
	level notify("aud_roundabout_finished");
}

//Function Number: 132
alley_1_big_metal_gate()
{
	level.joker soundscripts\_snd_playsound::snd_play_delayed_linked("metalgate_open_foley_joker_01",0);
	level.joker soundscripts\_snd_playsound::snd_play_delayed_linked("metalgate_open_kick",1.294);
	level.joker soundscripts\_snd_playsound::snd_play_delayed_linked("metalgate_open_pull",3.491);
	level.joker soundscripts\_snd_playsound::snd_play_delayed_linked("metalgate_open_foley_joker_02",4.835);
}

//Function Number: 133
oncoming_alley_truck()
{
	var_00 = self;
	wait(1);
	var_00 soundscripts\_snd_playsound::snd_play_linked("lagos_oncoming_alley_truck_approach");
	var_00 thread truck_turret_listener();
	soundscripts\_audio_mix_manager::mm_add_submix("lagos_oncoming_truck_approach",3);
	common_scripts\utility::flag_wait("aud_oncoming_truck_check");
	if(common_scripts\utility::flag("flag_oncoming_player_junction"))
	{
		var_00 soundscripts\_snd_playsound::snd_play_linked("lagos_oncoming_alley_truck_front");
		wait(4);
		var_00 soundscripts\_snd_playsound::snd_play_linked("lagos_oncoming_alley_truck_away");
		wait(2);
		soundscripts\_audio_mix_manager::mm_clear_submix("lagos_oncoming_truck_approach",3);
		return;
	}

	var_00 soundscripts\_snd_playsound::snd_play_linked("lagos_oncoming_alley_truck_away");
	soundscripts\_audio_mix_manager::mm_clear_submix("lagos_oncoming_truck_approach",3);
}

//Function Number: 134
lagos_technical_turret_fire()
{
	self playsound("wpn_lagos_technical_npc");
}

//Function Number: 135
truck_turret_flank_alley(param_00)
{
	param_00 soundscripts\_snd_playsound::snd_play_linked("lagos_truck_flank_alley_move");
	param_00.mgturret[0] thread truck_turret_listener();
}

//Function Number: 136
setup_alley_escape_breach()
{
	maps\_anim::addnotetrack_customfunction("burke","lag_alley_gideon_shoulder_charge",::lag_alley_gideon_shoulder_charge,"burke_flank_kick_start");
}

//Function Number: 137
lag_alley_gideon_shoulder_charge(param_00)
{
	soundscripts\_audio_mix_manager::mm_add_submix("lag_gideon_shoulder_charge");
	param_00 soundscripts\_snd_playsound::snd_play_delayed_linked("lag_alley_gideon_shoulder_charge",0);
	wait(3);
	soundscripts\_audio_mix_manager::mm_clear_submix("lag_gideon_shoulder_charge");
}

//Function Number: 138
truck_turret_listener()
{
	while(!common_scripts\utility::flag("trigger_start_timed_lane_traffic"))
	{
		self waittill("turret_fire");
		self playsound("wpn_lagos_technical_npc");
	}
}

//Function Number: 139
truck_turret_flank_alley_drive_away(param_00)
{
	param_00 soundscripts\_snd_playsound::snd_play_linked("lagos_truck_flank_alley_away");
	wait(2);
	soundscripts\_snd_playsound::snd_play_at("lag_walla_flank_alley",(-47126,622,476));
}

//Function Number: 140
setup_alley_anims()
{
	wait(0.5);
	maps\_anim::addnotetrack_customfunction("burke","alley_gideon_slide",::alley_gideon_slide,"oncoming_alley_seq_enter");
}

//Function Number: 141
alley_gideon_slide(param_00)
{
	param_00 soundscripts\_snd_playsound::snd_play_linked("alley_gideon_slide");
}

//Function Number: 142
frogger_vehicle_by(param_00)
{
	var_01 = [];
	var_01[0] = 1700;
	var_02 = param_00.classname;
	var_03 = "";
	if(issubstr(var_02,"bus"))
	{
		var_03 = "lagos_bus";
	}
	else if(issubstr(var_02,"sportscar") || issubstr(var_02,"smartcar"))
	{
		var_03 = "lagos_car_sporty";
	}
	else if(issubstr(var_02,"truck"))
	{
		var_03 = "lagos_car_truck";
	}
	else if(issubstr(var_02,"workvan") || issubstr(var_02,"minivan"))
	{
		var_03 = "lagos_car_suv";
	}
	else
	{
		var_03 = "lagos_car_sedan";
	}

	param_00 soundscripts\_snd_common::snd_advanced_flyby_system(var_03,undefined,var_01);
}

//Function Number: 143
traffic_traverse_fence_rip()
{
	level.burke soundscripts\_snd_playsound::snd_play_delayed_linked("cut_through_fence",1.5);
	soundscripts\_snd_timescale::snd_set_timescale("lagos_timescale_override");
	thread aud_player_climb_to_ledge();
	soundscripts\_audio_mix_manager::mm_add_submix("lag_bus_chase");
}

//Function Number: 144
handle_busses(param_00)
{
	var_01 = [];
	var_02 = 2000;
	var_02 = var_02 * var_02;
	var_03 = 0;
	foreach(var_05 in param_00)
	{
		var_06 = spawnstruct();
		var_06.id = var_03;
		var_06.stop_notify = "handle_busses_stop_bus_" + var_03;
		var_06.veh_ent = var_05;
		var_06.snd_ent = undefined;
		var_01[var_01.size] = var_06;
	}

	for(;;)
	{
		foreach(var_09 in var_01)
		{
			var_0A = distance2dsquared(level.player.origin,var_09.veh_ent.origin);
			if(isdefined(var_09.snd_ent) && var_0A > var_02)
			{
				var_09.snd_ent = undefined;
				level notify(var_09.stop_notify);
				continue;
			}

			if(!isdefined(var_09.snd_ent) && var_0A < var_02)
			{
				var_09.snd_ent = var_09.veh_ent soundscripts\_snd_playsound::snd_play_loop_linked("lag_bus_loop",var_09.stop_notify);
			}
		}

		wait(0.25);
	}
}

//Function Number: 145
aud_player_climb_to_ledge()
{
	common_scripts\utility::flag_wait("flag_highway_ledge_climb_started");
	soundscripts\_snd_playsound::snd_play_delayed_2d("bus_burke_jump_slowmo_whoosh",10.9,1,"burke_jump_slowmo_stop",0,4);
	soundscripts\_snd_playsound::snd_play_delayed_2d("bus_burke_jump_slowmo_start",11.35,1,"burke_jump_slowmo_stop",0,4);
}

//Function Number: 146
hostage_truck_fwy_notetrack_setup()
{
	maps\_anim::addnotetrack_customfunction("hostage_truck_fence","hostage_truck_freeway_by",::hostage_truck_freeway_by,"hostage_truck_pass_fence");
}

//Function Number: 147
hostage_truck_freeway_by(param_00)
{
	soundscripts\_audio_mix_manager::mm_add_submix("lag_hostage_truck_freeway_by");
	soundscripts\_snd_playsound::snd_play_delayed_2d("lag_hostage_truck_by",0.25);
	wait(6);
	soundscripts\_audio_mix_manager::mm_clear_submix("lag_hostage_truck_freeway_by");
}

//Function Number: 148
lag_brk_onme_done()
{
	music("lag_brk_onme_done");
}

//Function Number: 149
lag_brk_nocleanshot_done()
{
	music("lag_brk_nocleanshot_done");
	common_scripts\utility::flag_wait("flag_highway_ledge_jump_started");
	soundscripts\_audio::aud_slomo_wait(2);
	music("player_lands_on_first_bus");
}

//Function Number: 150
notify_qte_prompt_and_slowmo()
{
	if(isdefined(level.aud.truck_dodge_qte))
	{
		soundscripts\_audio_mix_manager::mm_clear_submix("lag_mid_qte");
		soundscripts\_audio_mix_manager::mm_add_submix("lag_truck_dodge_slowmo_crash");
	}

	if(isdefined(level.aud.truck_jump_slowmo))
	{
		soundscripts\_audio_mix_manager::mm_clear_submix("lag_mid_qte_post_crash");
		soundscripts\_audio_mix_manager::mm_clear_submix("lag_bus_chase");
	}

	if(isdefined(level.aud.truck_punch_slowmo))
	{
		soundscripts\_audio_mix_manager::mm_add_submix("lag_truck_punch_slowmo");
		soundscripts\_snd_playsound::snd_play_delayed_2d("bus_truck_punch_slowmo_start",0,1,"truck_punch_slowmo_stop",0,3);
	}

	if(isdefined(level.aud.truck_to_bus_slowmo))
	{
		soundscripts\_audio_mix_manager::mm_add_submix("lag_truck_to_bus_slowmo");
		soundscripts\_snd_playsound::snd_play_delayed_2d("bus_truck_to_bus_slowmo_start",0,1,"truck_to_bus_slowmo_stop",0,3);
	}
}

//Function Number: 151
bus_jumping_notetrack_setup()
{
	if(level.currentgen && level.transient_zone != "outro")
	{
		level waittill("tff_post_alley_to_outro");
	}

	maps\_anim::addnotetrack_customfunction("burke","aud_burke_ledge_jump",::aud_burke_ledge_jump,"burke_traffic_start_pt2");
	maps\_anim::addnotetrack_customfunction("burke","aud_burke_bus1_land",::aud_burke_bus1_land,"burke_traffic_start_pt2");
	maps\_anim::addnotetrack_customfunction("player_rig","aud_player_bus1_exo_land",::aud_player_bus1_exo_land,"traffic_start_VM");
	maps\_anim::addnotetrack_customfunction("player_rig","aud_player_bus1_land",::aud_player_bus1_land,"traffic_start_VM");
	maps\_anim::addnotetrack_customfunction("player_arms","aud_player_bus_exo_jump",::aud_player_bus_exo_jump,"bus_jump_vm_a");
	maps\_anim::addnotetrack_customfunction("player_arms","aud_player_bus_exo_land",::aud_player_bus_exo_land,"bus_jump_vm_a");
	maps\_anim::addnotetrack_customfunction("player_arms","aud_player_bus_land",::aud_player_bus_land,"bus_jump_vm_a");
	maps\_anim::addnotetrack_customfunction("player_arms","aud_player_bus_exo_jump",::aud_player_bus_exo_jump,"bus_jump_vm_b");
	maps\_anim::addnotetrack_customfunction("player_arms","aud_player_bus_exo_land",::aud_player_bus_exo_land,"bus_jump_vm_b");
	maps\_anim::addnotetrack_customfunction("player_arms","aud_player_bus_land",::aud_player_bus_land,"bus_jump_vm_b");
	maps\_anim::addnotetrack_customfunction("player_arms","aud_player_bus_exo_jump",::aud_player_bus_exo_jump,"bus_jump_vm_c");
	maps\_anim::addnotetrack_customfunction("player_arms","aud_player_bus_exo_land",::aud_player_bus_exo_land,"bus_jump_vm_c");
	maps\_anim::addnotetrack_customfunction("player_arms","aud_player_bus_land",::aud_player_bus_land,"bus_jump_vm_c");
	maps\_anim::addnotetrack_customfunction("player_arms","aud_player_bus_jump_handplant",::aud_player_bus_jump_handplant,"bus_jump_vm_handplant");
	maps\_anim::addnotetrack_customfunction("kva_truck","lag_mid_qte_truck_01",::lag_mid_qte_truck_01,"truck_middle_takedown_pt1");
	maps\_anim::addnotetrack_customfunction("kva_truck","lag_mid_qte_truck_bounce",::lag_mid_qte_truck_bounce,"truck_middle_takedown_pt1");
	maps\_anim::addnotetrack_customfunction("kva_truck","lag_mid_qte_truck_skids",::lag_mid_qte_truck_skids,"truck_middle_takedown_pt1");
	maps\_anim::addnotetrack_customfunction("kva_truck","aud_truck_dodge_slowmo_whoosh",::aud_truck_dodge_slowmo_whoosh,"truck_middle_takedown_pt1");
	maps\_anim::addnotetrack_customfunction("kva_truck","aud_truck_dodge_slowmo_start",::aud_truck_dodge_slowmo_start,"truck_middle_takedown_pt1");
	maps\_anim::addnotetrack_customfunction("kva_truck","lag_mid_qte_impact",::lag_mid_qte_impact,"truck_middle_takedown_pt2");
	maps\_anim::addnotetrack_customfunction("kva_truck","lag_mid_qte_mtl_chunk",::lag_mid_qte_mtl_chunk,"truck_middle_takedown_pt2");
	maps\_anim::addnotetrack_customfunction("kva_truck","lag_mid_qte_truck_02",::lag_mid_qte_truck_02,"truck_middle_takedown_pt2");
	maps\_anim::addnotetrack_customfunction("player_rig","lag_mid_qte_foley_01a",::lag_mid_qte_foley_01a,"truck_middle_takedown_pt1");
	maps\_anim::addnotetrack_customfunction("player_rig","lag_mid_qte_foley_01b",::lag_mid_qte_foley_01b,"truck_middle_takedown_pt2");
	maps\_anim::addnotetrack_customfunction("player_rig","lag_mid_qte_foley_02",::lag_mid_qte_foley_02,"truck_middle_takedown_pt2");
	maps\_anim::addnotetrack_customfunction("player_rig","aud_truck_jump_slowmo",::aud_truck_jump_slowmo,"truck_middle_takedown_pt2");
	maps\_anim::addnotetrack_customfunction("player_rig","aud_player_jump_to_truck",::aud_player_jump_to_truck,"truck_middle_takedown_pt3");
	maps\_anim::addnotetrack_customfunction("player_rig","aud_player_bus_exo_land",::aud_player_bus_exo_land,"truck_middle_takedown_pt3");
	maps\_anim::addnotetrack_customfunction("player_rig","aud_player_land_on_truck",::aud_player_land_on_truck,"truck_middle_takedown_pt3");
	maps\_anim::addnotetrack_customfunction("player_rig","aud_truck_punch_slowmo",::aud_truck_punch_slowmo,"truck_middle_takedown_pt3");
	maps\_anim::addnotetrack_customfunction("player_rig","aud_player_exo_punch_metal_plate",::aud_player_exo_punch_metal_plate,"truck_middle_takedown_pt4");
	maps\_anim::addnotetrack_customfunction("player_rig","aud_player_throw_metal_plate",::aud_player_throw_metal_plate,"truck_middle_takedown_pt4");
	maps\_anim::addnotetrack_customfunction("player_rig","aud_player_exo_punch_driver",::aud_player_exo_punch_driver,"truck_middle_takedown_pt4");
	maps\_anim::addnotetrack_customfunction("player_rig","aud_player_throw_driver",::aud_player_throw_driver,"truck_middle_takedown_pt4");
	maps\_anim::addnotetrack_customfunction("player_rig","aud_player_climb_foley",::aud_player_climb_foley,"truck_middle_takedown_pt4");
	maps\_anim::addnotetrack_customfunction("player_rig","aud_player_jump_back_to_bus",::aud_player_jump_back_to_bus,"truck_middle_takedown_pt5");
	maps\_anim::addnotetrack_customfunction("player_rig","aud_player_bus_exo_land",::aud_player_bus_exo_land,"truck_middle_takedown_pt5");
	maps\_anim::addnotetrack_customfunction("player_rig","aud_player_land_back_on_bus",::aud_player_land_back_on_bus,"truck_middle_takedown_pt5");
	maps\_anim::addnotetrack_customfunction("kva_truck","aud_truck_hits_divider",::aud_truck_hits_divider,"truck_middle_takedown_pt5");
	maps\_anim::addnotetrack_customfunction("kva_truck","aud_truck_hits_ground",::aud_truck_hits_ground,"truck_middle_takedown_pt5");
	maps\_anim::addnotetrack_customfunction("player_rig","aud_player_grab_mirror",::aud_player_grab_mirror,"hostage_truck_takedown_pt2");
	maps\_anim::addnotetrack_customfunction("hostage_truck","aud_hostage_truck_tbone",::aud_hostage_truck_tbone,"hostage_truck_takedown_pt3");
	maps\_anim::addnotetrack_customfunction("hostage_truck","aud_hostage_truck_over_curb",::aud_hostage_truck_over_curb,"hostage_truck_takedown_pt3");
	maps\_anim::addnotetrack_customfunction("hostage_truck","aud_hostage_truck_over_edge",::aud_hostage_truck_over_edge,"hostage_truck_takedown_pt3");
	maps\_anim::addnotetrack_customfunction("hostage_truck","aud_hostage_truck_hits_water",::aud_hostage_truck_hits_water,"hostage_truck_takedown_pt3");
}

//Function Number: 152
traverse_start_jump_start_slowmo()
{
	soundscripts\_audio_mix_manager::mm_add_submix("lag_burke_jump_slowmo");
}

//Function Number: 153
aud_burke_ledge_jump(param_00)
{
}

//Function Number: 154
traverse_start_jump_end_slowmo()
{
	if(!isdefined(level.aud.traverse_start_jump_end_slowmo))
	{
		level.aud.traverse_start_jump_end_slowmo = 1;
		soundscripts\_audio::aud_slomo_wait(1);
		soundscripts\_audio_mix_manager::mm_clear_submix("lag_burke_jump_slowmo",2);
		level notify("burke_jump_slowmo_stop");
	}
}

//Function Number: 155
aud_player_bus1_exo_land(param_00)
{
	soundscripts\_snd_playsound::snd_play_2d("exo_jump_land");
}

//Function Number: 156
aud_burke_bus1_land(param_00)
{
}

//Function Number: 157
aud_player_bus1_land(param_00)
{
	soundscripts\_snd_playsound::snd_play_2d("exo_jump_land_vehicle");
	soundscripts\_snd_playsound::snd_play_delayed_2d("bus_initial_bus_shake",0.05);
}

//Function Number: 158
bus_chase_suv_oneshots()
{
	var_00 = self;
	var_00 soundscripts\_snd_playsound::snd_play_loop_linked("lag_suv_drive_lp",undefined,1);
}

//Function Number: 159
bus_chase_suv_lose_control()
{
	var_00 = self;
	var_01 = var_00.origin;
	soundscripts\_snd_playsound::snd_play_at("lag_suv_skid",var_01,"kill_skid_sound",undefined,0.1);
}

//Function Number: 160
bus_chase_suv_explode()
{
	var_00 = self;
	var_01 = var_00.origin;
	soundscripts\_snd_playsound::snd_play_at("lag_suv_explo",var_01);
	level notify("kill_skid_sound");
}

//Function Number: 161
aud_player_bus_exo_jump(param_00)
{
	soundscripts\_snd_playsound::snd_play_2d("exo_jump");
}

//Function Number: 162
aud_player_bus_exo_land(param_00)
{
	soundscripts\_snd_playsound::snd_play_2d("exo_jump_land");
}

//Function Number: 163
aud_player_bus_land(param_00)
{
	soundscripts\_snd_playsound::snd_play_2d("exo_jump_land_vehicle");
}

//Function Number: 164
aud_player_bus_jump_handplant(param_00)
{
}

//Function Number: 165
lag_brk_stayclose_done()
{
	level.player notifyonplayercommand("a_pressed","+gostand");
	level.player waittill("a_pressed");
	level.player notifyonplayercommandremove("a_pressed","+gostand");
	music("bus_chase_lag_brk_stayclose_done");
}

//Function Number: 166
lag_mid_qte_foley_01a(param_00)
{
	soundscripts\_audio_mix_manager::mm_add_submix("lag_mid_qte");
	soundscripts\_snd_common::snd_enable_soundcontextoverride("bullet_metal_vehicle");
	soundscripts\_snd_playsound::snd_play_delayed_2d("lag_mid_qte_foley_01a",0);
	soundscripts\_snd_playsound::snd_play_delayed_2d("lag_mid_qte_body_impact",1.8);
	level.aud.truck_dodge_qte = 1;
}

//Function Number: 167
lag_mid_qte_truck_01(param_00)
{
	soundscripts\_snd_playsound::snd_play_delayed_2d("lag_mid_qte_truck_01",0);
}

//Function Number: 168
middle_takedown_gun_up()
{
}

//Function Number: 169
lag_mid_qte_truck_bounce(param_00)
{
	soundscripts\_snd_playsound::snd_play_delayed_2d("lag_mid_qte_truck_bounce",0.155);
}

//Function Number: 170
lag_mid_qte_truck_skids(param_00)
{
	soundscripts\_snd_playsound::snd_play_delayed_2d("lag_mid_qte_truck_skids",0,0,"aud_mid_qte_skids_kill");
}

//Function Number: 171
aud_truck_dodge_slowmo_whoosh(param_00)
{
	soundscripts\_snd_playsound::snd_play_2d("bus_truck_dodge_slowmo_whoosh","bus_truck_dodge_slowmo_stop",0,3);
}

//Function Number: 172
aud_truck_dodge_slowmo_start(param_00)
{
	soundscripts\_snd_playsound::snd_play_2d("bus_truck_dodge_slowmo_start","bus_truck_dodge_slowmo_stop",0,3);
}

//Function Number: 173
truck_middle_dodge_slowmo_end()
{
	soundscripts\_audio_mix_manager::mm_clear_submix("lag_truck_dodge_slowmo_crash");
	level.aud.truck_dodge_qte = undefined;
	level notify("bus_truck_dodge_slowmo_stop");
}

//Function Number: 174
lag_mid_qte_impact(param_00)
{
	level notify("aud_mid_qte_skids_kill");
	soundscripts\_snd_playsound::snd_play_delayed_2d("lag_mid_qte_impact",0);
}

//Function Number: 175
lag_mid_qte_mtl_chunk(param_00)
{
	soundscripts\_snd_playsound::snd_play_delayed_2d("lag_mid_qte_mtl_chunk",1.1);
}

//Function Number: 176
lag_mid_qte_truck_02(param_00)
{
	soundscripts\_audio_mix_manager::mm_clear_submix("lag_truck_dodge_slowmo_crash");
	soundscripts\_audio_mix_manager::mm_add_submix("lag_mid_qte_post_crash");
	soundscripts\_snd_playsound::snd_play_delayed_2d("lag_mid_qte_truck_02",0);
}

//Function Number: 177
lag_mid_qte_foley_01b(param_00)
{
	soundscripts\_snd_playsound::snd_play_delayed_2d("lag_mid_qte_foley_01b",0);
}

//Function Number: 178
lag_mid_qte_foley_02(param_00)
{
	soundscripts\_snd_playsound::snd_play_delayed_2d("lag_mid_qte_foley_02",0);
}

//Function Number: 179
aud_truck_jump_slowmo(param_00)
{
	level.aud.truck_jump_slowmo = 1;
	soundscripts\_audio_mix_manager::mm_add_submix("lag_truck_exo_sequence");
	soundscripts\_audio_mix_manager::mm_add_submix("lag_truck_jump_slowmo",1.5);
	soundscripts\_snd_playsound::snd_play_delayed_2d("bus_truck_jump_slowmo_whoosh",0,1,"truck_jump_slowmo_stop",0,3);
	soundscripts\_snd_playsound::snd_play_delayed_2d("bus_truck_jump_slowmo_start",0.45,1,"truck_jump_slowmo_stop",0,3);
}

//Function Number: 180
truck_middle_jump_slowmo_end()
{
	level notify("truck_jump_slowmo_stop");
	level.aud.truck_jump_slowmo = undefined;
	soundscripts\_audio_mix_manager::mm_clear_submix("lag_truck_jump_slowmo",2);
	soundscripts\_snd_playsound::snd_play_2d("bus_truck_jump_engine");
}

//Function Number: 181
aud_player_jump_to_truck(param_00)
{
	soundscripts\_snd_playsound::snd_play_2d("exo_jump");
}

//Function Number: 182
aud_player_land_on_truck(param_00)
{
	soundscripts\_snd_playsound::snd_play_2d("exo_jump_land_truck");
	soundscripts\_snd_playsound::snd_play_delayed_2d("bus_truck_punch_exo",0.5);
	level.aud.truck_punch_slowmo = 1;
}

//Function Number: 183
aud_truck_punch_slowmo(param_00)
{
	soundscripts\_snd_playsound::snd_play_delayed_2d("bus_truck_punch_slowmo_whoosh",0.2,1,"truck_punch_slowmo_stop",0,3);
}

//Function Number: 184
truck_middle_punch_slowmo_end()
{
	soundscripts\_audio_mix_manager::mm_clear_submix("lag_truck_punch_slowmo",2);
	level notify("truck_punch_slowmo_stop");
	level.aud.truck_punch_slowmo = undefined;
}

//Function Number: 185
aud_player_exo_punch_metal_plate(param_00)
{
	soundscripts\_snd_playsound::snd_play_delayed_2d("bus_truck_punch_impact",0.05,1);
}

//Function Number: 186
aud_player_throw_metal_plate(param_00)
{
	soundscripts\_snd_playsound::snd_play_2d("bus_truck_windshield_rip");
	soundscripts\_snd_playsound::snd_play_2d("bus_truck_windshield_throw");
	soundscripts\_snd_playsound::snd_play_delayed_2d("bus_driver_punch_exo",2.05,1);
}

//Function Number: 187
aud_player_exo_punch_driver(param_00)
{
	soundscripts\_snd_playsound::snd_play_delayed_2d("bus_driver_punch_impact",0.05,1);
}

//Function Number: 188
aud_player_throw_driver(param_00)
{
	soundscripts\_snd_playsound::snd_play_delayed_2d("bus_driver_throw_exo_windup",0.8,1);
	soundscripts\_snd_playsound::snd_play_delayed_2d("bus_driver_throw_exo_release",1.3,1);
	soundscripts\_snd_playsound::snd_play_delayed_2d("bus_driver_throw_scream",1.55,1);
	soundscripts\_snd_playsound::snd_play_delayed_2d("bus_driver_pole_impact",2.2,1);
}

//Function Number: 189
aud_player_climb_foley(param_00)
{
	level.aud.truck_to_bus_slowmo = 1;
	soundscripts\_snd_playsound::snd_play_delayed_2d("bus_truck_climb_foley",0,1);
	soundscripts\_snd_playsound::snd_play_delayed_2d("bus_truck_to_bus_slowmo_whoosh",0.5,1,"truck_to_bus_slowmo_stop",0,3);
}

//Function Number: 190
truck_middle_jump2_slowmo_end()
{
	soundscripts\_audio_mix_manager::mm_clear_submix("lag_truck_to_bus_slowmo",2);
	level notify("truck_to_bus_slowmo_stop");
	level.aud.truck_to_bus_slowmo = undefined;
	soundscripts\_snd_playsound::snd_play_2d("bus_truck_crash_engine");
}

//Function Number: 191
aud_player_jump_back_to_bus(param_00)
{
	soundscripts\_snd_playsound::snd_play_2d("exo_jump");
	soundscripts\_snd_common::snd_disable_soundcontextoverride("bullet_metal_vehicle");
}

//Function Number: 192
aud_player_land_back_on_bus(param_00)
{
	soundscripts\_snd_playsound::snd_play_2d("exo_jump_land_vehicle");
	soundscripts\_snd_playsound::snd_play_delayed_2d("bus_truck_flip_impact",0.65,1);
}

//Function Number: 193
aud_truck_hits_divider(param_00)
{
	soundscripts\_snd_playsound::snd_play_delayed_2d("bus_truck_flip_glass",0.1,1);
}

//Function Number: 194
aud_truck_hits_ground(param_00)
{
	soundscripts\_snd_playsound::snd_play_2d("bus_truck_crash_impact");
	soundscripts\_snd_playsound::snd_play_delayed_2d("bus_truck_crash_impact_rears",0.55,1);
	soundscripts\_audio::aud_slomo_wait(1.5);
	soundscripts\_audio_mix_manager::mm_add_submix("lag_bus_chase");
	soundscripts\_audio_mix_manager::mm_clear_submix("lag_truck_exo_sequence");
}

//Function Number: 195
lag_brk_takeoutsuv_done()
{
	if(!isdefined(level.aud.mus_lag_brk_takeoutsuv_done))
	{
		level.aud.mus_lag_brk_takeoutsuv_done = 1;
		music("lag_brk_takeoutsuv_done");
	}
}

//Function Number: 196
truck_whipeout_anim_begin()
{
	soundscripts\_audio::aud_slomo_wait(2);
	music("buschase_truck_crash_begin");
	soundscripts\_audio::aud_slomo_wait(2);
	music("buschase_truck_crash_end");
}

//Function Number: 197
spawn_traffic_helicopter()
{
	self vehicle_turnengineoff();
	soundscripts\_audio_mix_manager::mm_add_submix("lag_bus_chase_helicopter");
	soundscripts\_snd_playsound::snd_play_linked("bus_chase_helicopter");
	self waittill("deathspin");
	soundscripts\_audio_mix_manager::mm_clear_submix("lag_bus_chase_helicopter");
	soundscripts\_audio_mix_manager::mm_add_submix("lag_bus_chase_helicopter_crash");
	soundscripts\_snd_playsound::snd_play_linked("bus_chase_heli_death_explo");
	soundscripts\_snd_playsound::snd_play_linked("bus_chase_heli_death_spin");
	soundscripts\_snd_playsound::snd_play_linked("bus_chase_heli_crash");
	wait(3);
	soundscripts\_audio_mix_manager::mm_clear_submix("lag_bus_chase_helicopter_crash",3);
}

//Function Number: 198
chase_heli_fire()
{
	self playsound("wpn_heli_guns_npc");
}

//Function Number: 199
final_takedown_abutton_hit()
{
	soundscripts\_snd_playsound::snd_play_2d("exo_jump");
	soundscripts\_snd_playsound::snd_play_delayed_2d("bus_van_jump_slowmo_whoosh",0.45,1,"van_jump_slowmo_stop",0,3);
	music("final_takedown_abutton_hit");
}

//Function Number: 200
hostage_truck_slomo_start_pt1()
{
	soundscripts\_audio_mix_manager::mm_clear_submix("lag_bus_chase");
	soundscripts\_audio_mix_manager::mm_add_submix("lag_van_jump_slowmo");
	soundscripts\_snd_playsound::snd_play_2d("bus_van_jump_slowmo_start","van_jump_slowmo_stop",0,3);
}

//Function Number: 201
final_takedown_xbutton_hit()
{
	level notify("van_jump_slowmo_stop");
	soundscripts\_audio_mix_manager::mm_clear_submix("lag_van_jump_slowmo",2);
	soundscripts\_audio_mix_manager::mm_add_submix("lag_van_takedown_sequence");
}

//Function Number: 202
aud_player_grab_mirror(param_00)
{
	soundscripts\_snd_playsound::snd_play_2d("bus_van_mirror_fall_foley");
	soundscripts\_snd_playsound::snd_play_delayed_2d("bus_van_mirror_fall_impact",1.3,1);
	soundscripts\_snd_playsound::snd_play_delayed_2d("bus_van_mirror_fall_engine",2.75,1);
	soundscripts\_snd_playsound::snd_play_delayed_2d("bus_van_shoot_slowmo_whoosh",4,1,"van_shoot_slowmo_stop",0,3);
}

//Function Number: 203
final_takedown_gun_up()
{
	music("final_takedown_gun_up");
	soundscripts\_audio::aud_slomo_wait(8);
	music("buschase_ending");
}

//Function Number: 204
hostage_truck_slomo_start_pt2()
{
	soundscripts\_audio_mix_manager::mm_add_submix("lag_van_shoot_slowmo");
	soundscripts\_snd_playsound::snd_play_2d("bus_van_shoot_slowmo_start","van_shoot_slowmo_stop",0,3);
}

//Function Number: 205
hostage_truck_slomo_end_pt2()
{
	level notify("van_shoot_slowmo_stop");
	soundscripts\_audio_mix_manager::mm_clear_submix("lag_van_shoot_slowmo",2);
	soundscripts\_snd_playsound::snd_play_2d("bus_van_shoot_lose_control");
	soundscripts\_snd_playsound::snd_play_delayed_2d("bus_van_pre_crash_engine",8.2,1);
	soundscripts\_audio::aud_slomo_wait(8.5);
	soundscripts\_audio_mix_manager::mm_clear_submix("lag_van_takedown_sequence",0.5);
	soundscripts\_audio_mix_manager::mm_add_submix("lag_van_crash_sequence",0.5);
}

//Function Number: 206
aud_hostage_truck_tbone(param_00)
{
	soundscripts\_snd_playsound::snd_play_2d("bus_van_crash_impact");
	soundscripts\_snd_playsound::snd_play_delayed_2d("bus_van_crash_grit",0.2,1);
	soundscripts\_snd_playsound::snd_play_delayed_2d("bus_van_crash_skids",0.45,1);
	soundscripts\_snd_playsound::snd_play_delayed_2d("bus_van_post_crash_engine",1.35,1);
}

//Function Number: 207
aud_hostage_truck_over_curb(param_00)
{
	soundscripts\_snd_playsound::snd_play_2d("bus_van_crash_median_barrels");
	soundscripts\_snd_playsound::snd_play_delayed_2d("bus_van_guardrail_impact",0.35,1);
}

//Function Number: 208
aud_hostage_truck_over_edge(param_00)
{
	soundscripts\_snd_playsound::snd_play_delayed_2d("bus_van_guardrail_fall_debris",0.15,1);
	soundscripts\_snd_playsound::snd_play_delayed_2d("bus_water_van_hit",2.35,1);
}

//Function Number: 209
aud_hostage_truck_hits_water(param_00)
{
	soundscripts\_snd_playsound::snd_play_delayed_2d("bus_water_player_pre_splash",0.25,1);
	soundscripts\_snd_playsound::snd_play_delayed_2d("bus_water_player_splash_fronts",0.3,1);
	soundscripts\_snd_playsound::snd_play_delayed_2d("bus_water_player_hit_underwater",0.4,1);
	wait(3);
	soundscripts\_audio_mix_manager::mm_clear_submix("lag_van_crash_sequence",3);
}

//Function Number: 210
underwater_sequence(param_00)
{
	soundscripts\_audio_mix_manager::mm_add_submix("lag_underwater",0.5);
	soundscripts\_snd_playsound::snd_play_loop_2d("lag_underwater_ambience","kill_underwater_ambience",0.5,1);
	param_00 soundscripts\_snd_playsound::snd_play_loop_linked("lag_underwater_truck_bubbles","kill_underwater_ambience",0.05,6);
}

//Function Number: 211
underwater_rescue()
{
	level notify("kill_underwater_ambience");
	soundscripts\_snd_playsound::snd_play_2d("lag_underwater_rescue","kill_underwater_rescue",0.05,5);
	level waittill("swimming_fade");
	level notify("kill_underwater_rescue");
}

//Function Number: 212
lagos_swimming_stroke()
{
	soundscripts\_snd_playsound::snd_play_2d("lag_underwater_swim_stroke");
}

//Function Number: 213
lagos_swimming_drowning_start()
{
	soundscripts\_snd_playsound::snd_play_2d("lag_underwater_drowning");
}

//Function Number: 214
lagos_swimming_into_stroke()
{
	soundscripts\_snd_playsound::snd_play_2d("lag_underwater_swim_stroke");
}

//Function Number: 215
shore_ending()
{
	soundscripts\_audio_zone_manager::azm_start_zone("lag_shore_pcap",3);
	soundscripts\_audio_mix_manager::mm_clear_submix("lag_underwater",0.5);
}

//Function Number: 216
shore_pcap_notetrack_setup()
{
	wait(0.05);
	if(level.currentgen && level.transient_zone != "outro")
	{
		level waittill("tff_post_alley_to_outro");
	}

	maps\_anim::addnotetrack_customfunction("player_rig","shore_plr_slapped",::shore_plr_slapped,"hostage_truck_takedown_pt5");
	maps\_anim::addnotetrack_customfunction("player_rig","shore_plr_tries_to_get_up",::shore_plr_tries_to_get_up,"hostage_truck_takedown_pt5");
	maps\_anim::addnotetrack_customfunction("player_rig","shore_plr_grab_wpn",::shore_plr_grab_wpn,"hostage_truck_takedown_pt5");
	maps\_anim::addnotetrack_customfunction("burke","lagos_shore_pcap_start",::lagos_shore_pcap_start,"hostage_truck_takedown_pt5");
	maps\_anim::addnotetrack_customfunction("burke","shore_gideon_slap_plr",::shore_gideon_slap_plr,"hostage_truck_takedown_pt5");
	maps\_anim::addnotetrack_customfunction("burke","shore_gideon_grab_plr",::shore_gideon_grab_plr,"hostage_truck_takedown_pt5");
	maps\_anim::addnotetrack_customfunction("burke","shore_gideon_turn",::shore_gideon_turn,"hostage_truck_takedown_pt5");
	maps\_anim::addnotetrack_customfunction("burke","shore_gideon_nudge",::shore_gideon_nudge,"hostage_truck_takedown_pt5");
	maps\_anim::addnotetrack_customfunction("burke","shore_gideon_moneys_worth",::shore_gideon_moneys_worth,"hostage_truck_takedown_pt5");
	maps\_anim::addnotetrack_customfunction("burke","shore_gideon_pickup_wpn",::shore_gideon_pickup_wpn,"hostage_truck_takedown_pt5");
	maps\_anim::addnotetrack_customfunction("burke","shore_gideon_stand",::shore_gideon_stand,"hostage_truck_takedown_pt5");
	maps\_anim::addnotetrack_customfunction("joker","shore_joker_run_in",::shore_joker_run_in,"hostage_truck_takedown_pt5");
	maps\_anim::addnotetrack_customfunction("joker","shore_joker_nudges_hostage",::shore_joker_nudges_hostage,"hostage_truck_takedown_pt5");
	maps\_anim::addnotetrack_customfunction("joker","shore_joker_helps_with_hostage",::shore_joker_helps_with_hostage,"hostage_truck_takedown_pt5");
	maps\_anim::addnotetrack_customfunction("ajani","shore_ajani_run_in",::shore_ajani_run_in,"hostage_truck_takedown_pt5");
	maps\_anim::addnotetrack_customfunction("ajani","shore_ajani_walks_away",::shore_ajani_walks_away,"hostage_truck_takedown_pt5");
}

//Function Number: 217
shore_plr_slapped(param_00)
{
	soundscripts\_audio_mix_manager::mm_add_submix("lag_ending_pcap_scene");
	soundscripts\_snd_playsound::snd_play_2d("lag_shore_plr_slapped");
}

//Function Number: 218
shore_plr_tries_to_get_up(param_00)
{
}

//Function Number: 219
shore_plr_grab_wpn(param_00)
{
	soundscripts\_snd_playsound::snd_play_2d("lag_shore_plr_wpn");
}

//Function Number: 220
lagos_shore_pcap_start(param_00)
{
}

//Function Number: 221
shore_gideon_slap_plr(param_00)
{
	soundscripts\_snd_playsound::snd_play_2d("lag_shore_gideon_slap");
}

//Function Number: 222
shore_gideon_grab_plr(param_00)
{
	param_00 soundscripts\_snd_playsound::snd_play_linked("lag_shore_gideon_grab_plr");
}

//Function Number: 223
shore_gideon_turn(param_00)
{
	param_00 soundscripts\_snd_playsound::snd_play_linked("lag_shore_gideon_turn");
}

//Function Number: 224
shore_gideon_nudge(param_00)
{
	param_00 soundscripts\_snd_playsound::snd_play_linked("lag_shore_gideon_nudge");
}

//Function Number: 225
shore_gideon_moneys_worth(param_00)
{
	param_00 soundscripts\_snd_playsound::snd_play_linked("lag_shore_gideon_moneys_worth");
}

//Function Number: 226
shore_gideon_pickup_wpn(param_00)
{
	param_00 soundscripts\_snd_playsound::snd_play_linked("lag_shore_gideon_wpn");
}

//Function Number: 227
shore_gideon_stand(param_00)
{
	param_00 soundscripts\_snd_playsound::snd_play_linked("lag_shore_gideon_stand");
}

//Function Number: 228
shore_joker_run_in(param_00)
{
	param_00 soundscripts\_snd_playsound::snd_play_linked("lag_shore_joker_enter");
}

//Function Number: 229
shore_joker_nudges_hostage(param_00)
{
	param_00 soundscripts\_snd_playsound::snd_play_linked("lag_shore_joker_nudge");
}

//Function Number: 230
shore_joker_helps_with_hostage(param_00)
{
	param_00 soundscripts\_snd_playsound::snd_play_linked("lag_shore_joker_help");
}

//Function Number: 231
shore_ajani_run_in(param_00)
{
	param_00 soundscripts\_snd_playsound::snd_play_linked("lag_shore_ajani_enter");
}

//Function Number: 232
shore_ajani_walks_away(param_00)
{
}

//Function Number: 233
lag_gl_end_logo()
{
	soundscripts\_snd_playsound::snd_play_2d("lag_gl_end_logo");
	soundscripts\_audio_mix_manager::mm_add_submix("lag_gl_end_logo");
}

//Function Number: 234
temp_dog_bark(param_00)
{
	param_00 soundscripts\_snd_playsound::snd_play_linked("lag_dog_bark");
}