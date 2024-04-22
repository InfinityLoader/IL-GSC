/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: detroit_aud.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 290
 * Decompile Time: 4255 ms
 * Timestamp: 4/22/2024 2:27:45 AM
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
	soundscripts\_snd::snd_register_message("start_refugee_camp",::start_refugee_camp);
	soundscripts\_snd::snd_register_message("start_drive_in",::start_drive_in);
	soundscripts\_snd::snd_register_message("start_school",::start_school);
	soundscripts\_snd::snd_register_message("start_school_interior",::start_school_interior);
	soundscripts\_snd::snd_register_message("start_school_before_fall",::start_school_before_fall);
	soundscripts\_snd::snd_register_message("start_school_basement",::start_school_basement);
	soundscripts\_snd::snd_register_message("start_school_wall_grab",::start_school_wall_grab);
	soundscripts\_snd::snd_register_message("start_alleyway",::start_alleyway);
	soundscripts\_snd::snd_register_message("start_office",::start_office);
	soundscripts\_snd::snd_register_message("start_exopush",::start_exopush);
	soundscripts\_snd::snd_register_message("start_hospital",::start_hospital);
	soundscripts\_snd::snd_register_message("start_hospital_capture_animation",::start_hospital_capture_animation);
	soundscripts\_snd::snd_register_message("start_sentinel_reveal",::start_sentinel_reveal);
	soundscripts\_snd::snd_register_message("start_exit_drive",::start_exit_drive);
	soundscripts\_snd::snd_register_message("weather_report",::weather_report);
	soundscripts\_snd::snd_register_message("lightning_strike",::lightning_strike);
	soundscripts\_snd::snd_register_message("play_maglev_train_path",::play_maglev_train_path);
	soundscripts\_snd::snd_register_message("opening_start",::opening_start);
	soundscripts\_snd::snd_register_message("level_intro_cinematic",::level_intro_cinematic);
	soundscripts\_snd::snd_register_message("begin_refugee_walk",::begin_refugee_walk);
	soundscripts\_snd::snd_register_message("begin_intro_conversation",::begin_intro_conversation);
	soundscripts\_snd::snd_register_message("start_stage_dialog",::start_stage_dialog);
	soundscripts\_snd::snd_register_message("jetbike_intro",::jetbike_intro);
	soundscripts\_snd::snd_register_message("refugee_butress_down",::refugee_butress_down);
	soundscripts\_snd::snd_register_message("gate_lightning",::gate_lightning);
	soundscripts\_snd::snd_register_message("drive_in_done",::drive_in_done);
	soundscripts\_snd::snd_register_message("begin_on_foot_segment",::begin_on_foot_segment);
	soundscripts\_snd::snd_register_message("walk_to_school",::walk_to_school);
	soundscripts\_snd::snd_register_message("horror_fluorescent_break",::horror_fluorescent_break);
	soundscripts\_snd::snd_register_message("horror_burke_gets_up_after_tile",::horror_burke_gets_up_after_tile);
	soundscripts\_snd::snd_register_message("horror_burk_opens_bodies_room_door",::horror_burk_opens_bodies_room_door);
	soundscripts\_snd::snd_register_message("body_room_exit",::body_room_exit);
	soundscripts\_snd::snd_register_message("finish_bodies_room_burke",::finish_bodies_room_burke);
	soundscripts\_snd::snd_register_message("horror_ghost_runs_by_door",::horror_ghost_runs_by_door);
	soundscripts\_snd::snd_register_message("school_upthestairs",::school_upthestairs);
	soundscripts\_snd::snd_register_message("burke_startle_stairs",::burke_startle_stairs);
	soundscripts\_snd::snd_register_message("player_shimmy_intro",::player_shimmy_intro);
	soundscripts\_snd::snd_register_message("school_fall",::school_fall);
	soundscripts\_snd::snd_register_message("school_fall_into_basement",::school_fall_into_basement);
	soundscripts\_snd::snd_register_message("basement_investigate",::basement_investigate);
	soundscripts\_snd::snd_register_message("kva_basement_idle_start",::kva_basement_idle_start);
	soundscripts\_snd::snd_register_message("steam_burst_valve_started",::steam_burst_valve_started);
	soundscripts\_snd::snd_register_message("wall_pull_animation_begin",::wall_pull_animation_begin);
	soundscripts\_snd::snd_register_message("wall_pull_slowmo",::wall_pull_slowmo);
	soundscripts\_snd::snd_register_message("detroit_kva_bauerdoyoureadme",::detroit_kva_bauerdoyoureadme);
	soundscripts\_snd::snd_register_message("train_scare",::train_scare);
	soundscripts\_snd::snd_register_message("school_lightning_strike",::school_lightning_strike);
	soundscripts\_snd::snd_register_message("kva_knife_takedown_scene_begin",::kva_knife_takedown_scene_begin);
	soundscripts\_snd::snd_register_message("mus_alley_combat",::mus_alley_combat);
	soundscripts\_snd::snd_register_message("temp_dog_bark",::temp_dog_bark);
	soundscripts\_snd::snd_register_message("office_reunion_dialogue",::office_reunion_dialogue);
	soundscripts\_snd::snd_register_message("hospital_breach_gun_away",::hospital_breach_gun_away);
	soundscripts\_snd::snd_register_message("hostpital_breach_start",::hostpital_breach_start);
	soundscripts\_snd::snd_register_message("push_dude_into_shelves",::push_dude_into_shelves);
	soundscripts\_snd::snd_register_message("breach_bad_guy2_gets_shot",::breach_bad_guy2_gets_shot);
	soundscripts\_snd::snd_register_message("shoot_dude_through_window",::shoot_dude_through_window);
	soundscripts\_snd::snd_register_message("breach_slo_mo_exit",::breach_slo_mo_exit);
	soundscripts\_snd::snd_register_message("capture_doctor_scene_start",::capture_doctor_scene_start);
	soundscripts\_snd::snd_register_message("office_skylights_breakable",::office_skylights_breakable);
	soundscripts\_snd::snd_register_message("begin_exo_push",::begin_exo_push);
	soundscripts\_snd::snd_register_message("ambulance_push_attach",::ambulance_push_attach);
	soundscripts\_snd::snd_register_message("ambulance_push_active",::ambulance_push_active);
	soundscripts\_snd::snd_register_message("ambulance_push_step_away",::ambulance_push_step_away);
	soundscripts\_snd::snd_register_message("ambulance_push_idle",::ambulance_push_idle);
	soundscripts\_snd::snd_register_message("ambulance_push_sequence_end",::ambulance_push_sequence_end);
	soundscripts\_snd::snd_register_message("hospital_flashbang1",::hospital_flashbang1);
	soundscripts\_snd::snd_register_message("hospital_flashbang2",::hospital_flashbang2);
	soundscripts\_snd::snd_register_message("hospital_flashbang3",::hospital_flashbang3);
	soundscripts\_snd::snd_register_message("det_hospital_gate_close",::det_hospital_gate_close);
	soundscripts\_snd::snd_register_message("det_start_doctor_breathing",::det_start_doctor_breathing);
	soundscripts\_snd::snd_register_message("reveal_scene_start",::reveal_scene_start);
	soundscripts\_snd::snd_register_message("reveal_explosion",::reveal_explosion);
	soundscripts\_snd::snd_register_message("sent_guy_1_decloak",::sent_guy_1_decloak);
	soundscripts\_snd::snd_register_message("sent_guy_2_decloak",::sent_guy_2_decloak);
	soundscripts\_snd::snd_register_message("sent_guy_3_decloak",::sent_guy_3_decloak);
	soundscripts\_snd::snd_register_message("det_knx_thatsclassifiedmate",::det_knx_thatsclassifiedmate);
	soundscripts\_snd::snd_register_message("sentinel_reveal_final_vo",::sentinel_reveal_final_vo);
	soundscripts\_snd::snd_register_message("aud_impact_system_jetbike",::aud_impact_system_jetbike);
	soundscripts\_snd::snd_register_message("exit_ride_jetbike_mount_player",::exit_ride_jetbike_mount_player);
	soundscripts\_snd::snd_register_message("gaz_store_shootout_drive",::gaz_store_shootout_drive);
	soundscripts\_snd::snd_register_message("warehouse_chase_vehicle_02",::warehouse_chase_vehicle_02);
	soundscripts\_snd::snd_register_message("warehouse_chase_vehicle_03",::warehouse_chase_vehicle_03);
	soundscripts\_snd::snd_register_message("warehouse_chase_vehicle_04",::warehouse_chase_vehicle_04);
	soundscripts\_snd::snd_register_message("warehouse_car_shots",::warehouse_car_shots);
	soundscripts\_snd::snd_register_message("gaz_water_crash_01",::gaz_water_crash_01);
	soundscripts\_snd::snd_register_message("gaz_water_crash_02",::gaz_water_crash_02);
	soundscripts\_snd::snd_register_message("exit_drive_rpgs",::exit_drive_rpgs);
	soundscripts\_snd::snd_register_message("exitdrive_chopper_initial",::exitdrive_chopper_initial);
	soundscripts\_snd::snd_register_message("exitdrive_chopper_initial_gopath",::exitdrive_chopper_initial_gopath);
	soundscripts\_snd::snd_register_message("exitdrive_chopper_tracks_1",::exitdrive_chopper_tracks_1);
	soundscripts\_snd::snd_register_message("exitdrive_chopper_tracks_1_gopath",::exitdrive_chopper_tracks_1_gopath);
	soundscripts\_snd::snd_register_message("exitdrive_chopper_final",::exitdrive_chopper_final);
	soundscripts\_snd::snd_register_message("exitdrive_chopper_final_gopath",::exitdrive_chopper_final_gopath);
	soundscripts\_snd::snd_register_message("collapsing_buttress_missile",::collapsing_buttress_missile);
	soundscripts\_snd::snd_register_message("collapsing_buttress_01",::collapsing_buttress_01);
	soundscripts\_snd::snd_register_message("collapsing_buttress_02",::collapsing_buttress_02);
	soundscripts\_snd::snd_register_message("collapsing_buttress_03",::collapsing_buttress_03);
	soundscripts\_snd::snd_register_message("exit_train_by",::exit_train_by);
	soundscripts\_snd::snd_register_message("exit_drive_ending_begin",::exit_drive_ending_begin);
	soundscripts\_snd::snd_register_message("gaz_water_crashed",::gaz_water_crashed);
	soundscripts\_snd::snd_register_message("exit_drive_rpgs",::exit_drive_rpgs);
	soundscripts\_snd::snd_register_message("exitdrive_chopper_initial",::exitdrive_chopper_initial);
	soundscripts\_snd::snd_register_message("exitdrive_chopper_initial_gopath",::exitdrive_chopper_initial_gopath);
	soundscripts\_snd::snd_register_message("exitdrive_chopper_tracks_1",::exitdrive_chopper_tracks_1);
	soundscripts\_snd::snd_register_message("exitdrive_chopper_tracks_1_gopath",::exitdrive_chopper_tracks_1_gopath);
	soundscripts\_snd::snd_register_message("exitdrive_chopper_final",::exitdrive_chopper_final);
	soundscripts\_snd::snd_register_message("exitdrive_chopper_final_gopath",::exitdrive_chopper_final_gopath);
	soundscripts\_snd::snd_register_message("collapsing_buttress_missile",::collapsing_buttress_missile);
	soundscripts\_snd::snd_register_message("collapsing_buttress_01",::collapsing_buttress_01);
	soundscripts\_snd::snd_register_message("collapsing_buttress_02",::collapsing_buttress_02);
	soundscripts\_snd::snd_register_message("collapsing_buttress_03",::collapsing_buttress_03);
	soundscripts\_snd::snd_register_message("exit_train_by",::exit_train_by);
	soundscripts\_snd::snd_register_message("exit_drive_ending_begin",::exit_drive_ending_begin);
	soundscripts\_snd::snd_register_message("chopper_final_explo",::chopper_final_explo);
	soundscripts\_snd::snd_register_message("det_gl_end_logo",::det_gl_end_logo);
	soundscripts\_snd::snd_register_message("e3_demo_fade_out",::e3_demo_fade_out);
	soundscripts\_snd::snd_register_message("e3_demo_fade_in",::e3_demo_fade_in);
	soundscripts\_snd::snd_register_message("e3_demo_clear_basement_footsteps",::e3_demo_clear_basement_footsteps);
}

//Function Number: 3
config_system()
{
	soundscripts\_audio::set_stringtable_mapname("shg");
	soundscripts\_snd_filters::snd_set_occlusion("med_occlusion");
	soundscripts\_snd_timescale::snd_set_timescale("detroit_default");
	soundscripts\_audio_mix_manager::mm_add_submix("det_global");
}

//Function Number: 4
init_snd_flags()
{
	common_scripts\utility::flag_init("aud_parking_garage_enter");
	common_scripts\utility::flag_init("aud_parking_garage_exit");
	common_scripts\utility::flag_init("aud_school_entrance");
	common_scripts\utility::flag_init("aud_school_bsmnt_stairs_start");
	common_scripts\utility::flag_init("aud_school_bsmnt_stairs_end");
	common_scripts\utility::flag_init("aud_school_exit");
	common_scripts\utility::flag_init("aud_courtyard_flood_start");
	common_scripts\utility::flag_init("aud_courtyard_flood_end");
	common_scripts\utility::flag_init("aud_horror_fluorescent_break");
	common_scripts\utility::flag_init("aud_wallpull_begin");
	common_scripts\utility::flag_init("aud_wallpull_success");
	common_scripts\utility::flag_init("aud_maglev_train_path_disabled");
}

//Function Number: 5
aud_flag_handler()
{
	common_scripts\utility::flag_wait("aud_parking_garage_enter");
	common_scripts\utility::flag_wait("aud_parking_garage_exit");
	common_scripts\utility::flag_wait("aud_school_entrance");
	common_scripts\utility::flag_wait("aud_school_bsmnt_stairs_start");
	common_scripts\utility::flag_wait("aud_school_bsmnt_stairs_end");
	common_scripts\utility::flag_wait("aud_school_exit");
	common_scripts\utility::flag_wait("aud_courtyard_flood_start");
	common_scripts\utility::flag_wait("aud_courtyard_flood_end");
}

//Function Number: 6
init_globals()
{
	level.aud.ams_enabled = 0;
	level.aud.amb_pushing = 0;
}

//Function Number: 7
launch_threads()
{
	if(soundscripts\_audio::aud_is_specops())
	{
		return;
	}

	thread setup_gideon_intro_foley();
	thread setup_det_intro_catch_anims();
	thread setup_hoverbike_meet_up_notetracks();
	thread player_fall_zone_swap();
	thread aud_flag_handler();
	thread start_point_source_dambs();
	thread setup_decon_gate_anims();
	thread setup_entrance_gate_anims();
	thread setup_jetbike_motorpool_anims();
	thread setup_jetbike_checkpoint_anims();
	thread jetbikes_arrive_at_school();
	thread aud_det_foley_override_handler();
	thread setup_school_shimmy_anims();
	thread setup_wall_pull_anims();
	thread setup_fence_climb_anims();
	thread setup_hospital_post_breach_anims();
	thread setup_sentinel_reveal_anims();
	thread setup_exit_ride_anims();
	thread setup_ending_anims();
	thread setup_chopper_crash_anims();
	thread setup_end_gate();
}

//Function Number: 8
player_fall_zone_swap()
{
	common_scripts\utility::flag_wait("flag_player_shimmy_start");
	wait(0.5);
	soundscripts\_audio_zone_manager::azm_start_zone("dtrt_int_school_floor_1",1);
}

//Function Number: 9
launch_loops()
{
	thread launch_intro_loops();
	thread launch_intro_ride_loops();
	thread launch_school_street_loops();
	thread launch_school_interior_loops();
	thread launch_office_loops();
}

//Function Number: 10
launch_intro_loops()
{
	if(level.currentgen && !issubstr(level.transient_zone,"intro"))
	{
		level waittill("detroit_intro_tr");
		wait(0.05);
	}

	common_scripts\utility::loop_fx_sound("det_walla_start",(-14077,11309,-4),1,"aud_stop_intro");
	common_scripts\utility::loop_fx_sound("det_walla_fence_left",(-13471,10711,-4),1,"aud_stop_intro");
	common_scripts\utility::loop_fx_sound("det_walla_fence_right",(-14137,9868,-4),1,"aud_stop_intro");
	common_scripts\utility::loop_fx_sound("det_walla_food_truck",(-13571,9159,-4),1,"aud_stop_intro");
	common_scripts\utility::loop_fx_sound("det_walla_stage",(-12791,9098,-32),1,"aud_stop_intro");
	common_scripts\utility::loop_fx_sound("emt_ext_tarp_rustle",(-14268,9863,78),1,"aud_stop_intro");
	common_scripts\utility::loop_fx_sound("emt_ext_tarp_rustle",(-14068,9219,482),1,"aud_stop_intro");
	common_scripts\utility::loop_fx_sound("emt_ext_wind_lrg",(-13840,11244,23),1,"aud_stop_intro");
	common_scripts\utility::loop_fx_sound("emt_ext_wind_lrg",(-13796,10474,17),1,"aud_stop_intro");
	common_scripts\utility::loop_fx_sound("emt_ext_wind_lrg",(-13714,9965,0),1,"aud_stop_intro");
	if(level.currentgen)
	{
		level waittill("tff_pre_intro_to_middle");
		level notify("aud_stop_intro");
	}
}

//Function Number: 11
launch_intro_ride_loops()
{
	if(level.currentgen && !issubstr(level.transient_zone,"_gate"))
	{
		level waittill("tff_post_gatetrans_entry");
		wait(0.05);
	}

	common_scripts\utility::loop_fx_sound("emt_ext_wind_lrg",(-7742,6106,40),1,"aud_stop_intro_ride");
	common_scripts\utility::loop_fx_sound("emt_ext_water_on_concrete_high_01",(-7906,8496,-68),1,"aud_stop_intro_ride");
	common_scripts\utility::loop_fx_sound("emt_ext_water_on_concrete_high_02",(-7830,8072,-68),1,"aud_stop_intro_ride");
	common_scripts\utility::loop_fx_sound("emt_ext_water_on_concrete_high_02",(-5842,9796,-81),1,"aud_stop_intro_ride");
	common_scripts\utility::loop_fx_sound("emt_ext_water_on_water_high_01",(-7602,9383,-68),1,"aud_stop_intro_ride");
	common_scripts\utility::loop_fx_sound("emt_ext_water_on_water_high_02",(-7587,10017,-68),1,"aud_stop_intro_ride");
	common_scripts\utility::loop_fx_sound("emt_ext_water_on_water_low_02",(-7332,9844,-39),1,"aud_stop_intro_ride");
	common_scripts\utility::loop_fx_sound("emt_rain_into_pool_drippy_lp_01",(-7602,9383,-68),1,"aud_stop_intro_ride");
	common_scripts\utility::loop_fx_sound("emt_rain_into_pool_drippy_lp_02",(-7332,9844,-39),1,"aud_stop_intro_ride");
	common_scripts\utility::loop_fx_sound("emt_rain_into_pool_drippy_lp_01",(-4416,9518,-71),1,"aud_stop_intro_ride");
	common_scripts\utility::loop_fx_sound("emt_rain_into_pool_drippy_lp_01",(-7315,9618,-100),1,"aud_stop_intro_ride");
	common_scripts\utility::loop_fx_sound("emt_ext_water_on_water_high_02",(-5164,9688,-81),1,"aud_stop_intro_ride");
	common_scripts\utility::loop_fx_sound("emt_rain_into_pool_drippy_lp_02",(-4815,9834,-81),1,"aud_stop_intro_ride");
	common_scripts\utility::loop_fx_sound("emt_ext_water_on_water_med_02",(-7248,8942,-68),1,"aud_stop_intro_ride");
	common_scripts\utility::loop_fx_sound("emt_ext_water_on_water_high_01",(-7121,9380,-68),1,"aud_stop_intro_ride");
	common_scripts\utility::loop_fx_sound("emt_ext_water_on_water_low_03",(-7124,9052,-68),1,"aud_stop_intro_ride");
	common_scripts\utility::loop_fx_sound("emt_ext_water_on_concrete_high_03",(-6992,8929,-68),1,"aud_stop_intro_ride");
	common_scripts\utility::loop_fx_sound("emt_ext_water_on_water_high_02",(-6437,9417,-104),1,"aud_stop_intro_ride");
	common_scripts\utility::loop_fx_sound("emt_ext_water_on_concrete_high_03",(-5885,9338,-59),1,"aud_stop_intro_ride");
	common_scripts\utility::loop_fx_sound("emt_rain_into_pool_drippy_lp_01",(-6992,8929,-68),1,"aud_stop_intro_ride");
	common_scripts\utility::loop_fx_sound("emt_rain_into_pool_drippy_lp_02",(-7121,9380,-68),1,"aud_stop_intro_ride");
	if(level.currentgen)
	{
		level waittill("tff_pre_middle_remove_gatetrans");
		level notify("aud_stop_intro_ride");
	}
}

//Function Number: 12
launch_school_street_loops()
{
	if(level.currentgen && !issubstr(level.transient_zone,"middle"))
	{
		level waittill("tff_post_intro_to_middle");
		wait(0.05);
	}

	common_scripts\utility::loop_fx_sound("emt_ext_eerie_parking_garage_wind",(-4737,8822,-232),1);
	common_scripts\utility::loop_fx_sound("emt_ext_eerie_parking_garage_wind",(-4225,7158,-289),1);
	common_scripts\utility::loop_fx_sound("emt_ext_eerie_parking_garage_wind",(-3570,7163,-93),1);
	soundscripts\_snd_playsound::snd_play_loop_at("emt_water_garage",(-5239,8796,-248),"snd_water_garage_clear",2,2);
	soundscripts\_snd_playsound::snd_play_loop_at("emt_water_garage",(-3153,7729,-249),"snd_water_garage_clear",2,2);
	soundscripts\_snd_playsound::snd_play_loop_at("emt_water_garage",(-4189,7022,-199),"snd_water_garage_clear",2,2);
	common_scripts\utility::loop_fx_sound("emt_rain_on_tarp_01",(-2596,9175,-68),1);
	common_scripts\utility::loop_fx_sound("emt_rain_on_tarp_01",(-2670,9249,-89),1);
	common_scripts\utility::loop_fx_sound("emt_rain_on_tarp_01",(-2569,9314,-89),1);
	common_scripts\utility::loop_fx_sound("emt_rain_on_mailbox_01",(-2733,9206,-89),1);
	common_scripts\utility::loop_fx_sound("emt_rain_on_tarp_02",(-2432,9184,-37),1);
	common_scripts\utility::loop_fx_sound("emt_ext_water_on_concrete_med_01",(-3193,7032,-117),1);
	common_scripts\utility::loop_fx_sound("emt_ext_water_on_concrete_low_02",(-3036,7551,-117),1);
	common_scripts\utility::loop_fx_sound("emt_ext_water_on_concrete_high_03",(-2541,7071,-127),1);
	common_scripts\utility::loop_fx_sound("emt_ext_water_on_concrete_low_03",(-2409,7380,-114),1);
	common_scripts\utility::loop_fx_sound("emt_ext_tarp_rustle",(-2638,7461,-86),1);
	common_scripts\utility::loop_fx_sound("emt_ext_tarp_rustle",(-2638,7683,-86),1);
	common_scripts\utility::loop_fx_sound("emt_ext_tarp_rustle",(-2638,7787,-86),1);
	common_scripts\utility::loop_fx_sound("emt_ext_tarp_rustle",(-2640,7987,-86),1);
	common_scripts\utility::loop_fx_sound("emt_ext_tarp_rustle",(-2632,8233,-99),1);
	common_scripts\utility::loop_fx_sound("emt_ext_tarp_rustle",(-2631,8311,-99),1);
	common_scripts\utility::loop_fx_sound("emt_ext_tarp_rustle",(-2601,8744,-88),1);
}

//Function Number: 13
launch_school_interior_loops()
{
	if(level.currentgen && !issubstr(level.transient_zone,"_school"))
	{
		level waittill("tff_post_middle_add_school");
		wait(0.05);
	}

	common_scripts\utility::loop_fx_sound("emt_ext_eerie_whistling_wind1",(-2287,8995,-10),1,"aud_stop_school_interior");
	common_scripts\utility::loop_fx_sound("emt_int_eerie_howling_wind1",(-2029,9704,-10),1,"aud_stop_school_interior");
	common_scripts\utility::loop_fx_sound("emt_rain_thru_roof_to_puddle",(-1399,9399,-28),1,"aud_stop_school_interior");
	common_scripts\utility::loop_fx_sound("emt_int_eerie_howling_wind2",(-1520,9370,277),1,"aud_stop_school_interior");
	common_scripts\utility::loop_fx_sound("emt_int_eerie_howling_wind1",(-2029,9704,-10),1,"aud_stop_school_interior");
	common_scripts\utility::loop_fx_sound("emt_int_tarp_sml",(-1455,9403,4),1,"aud_stop_school_interior");
	common_scripts\utility::loop_fx_sound("corpse_room_flies",(-1038,9602,9),1,"aud_stop_school_interior");
	common_scripts\utility::loop_fx_sound("corpse_room_flies",(-844,9741,9),1,"aud_stop_school_interior");
	common_scripts\utility::loop_fx_sound("emt_int_horror_wind_low",(-686,9804,-10),1,"aud_stop_school_interior");
	common_scripts\utility::loop_fx_sound("emt_int_horror_wind_high",(-686,9804,-10),1,"aud_stop_school_interior");
	common_scripts\utility::loop_fx_sound("emt_int_bsmnt_drips_pool_lp_01",(-1215,9382,-187),1,"aud_stop_school_interior");
	common_scripts\utility::loop_fx_sound("emt_int_bsmnt_drips_pool_lp_01",(-1026,9359,-187),1,"aud_stop_school_interior");
	common_scripts\utility::loop_fx_sound("emt_int_bsmnt_drips_pool_lp_02",(-802,9435,-187),1,"aud_stop_school_interior");
	common_scripts\utility::loop_fx_sound("emt_int_bsmnt_drips_pool_lp_01",(-958,9141,-187),1,"aud_stop_school_interior");
	common_scripts\utility::loop_fx_sound("emt_int_bsmnt_drips_pool_lp_02",(-1076,9252,-187),1,"aud_stop_school_interior");
	common_scripts\utility::loop_fx_sound("emt_int_bsmnt_drips_pool_lp_01",(-878,9066,-158),1,"aud_stop_school_interior");
	common_scripts\utility::loop_fx_sound("emt_int_bsmnt_drips_pool_lp_02",(-1032,9061,-158),1,"aud_stop_school_interior");
	common_scripts\utility::loop_fx_sound("corpse_room_flies",(-1049,9709,-10),1,"aud_stop_school_interior");
	common_scripts\utility::loop_fx_sound("corpse_room_flies",(-799,9432,-138),1,"aud_stop_school_interior");
	common_scripts\utility::loop_fx_sound("corpse_room_flies",(-802,9463,-145),1,"aud_stop_school_interior");
	common_scripts\utility::loop_fx_sound("emt_int_horror_wind_high",(-603,9660,146),1,"aud_stop_school_interior");
	common_scripts\utility::loop_fx_sound("emt_int_horror_wind_low",(-603,9660,146),1,"aud_stop_school_interior");
	common_scripts\utility::loop_fx_sound("emt_int_exp_rain",(-603,9660,146),1,"aud_stop_school_interior");
	common_scripts\utility::loop_fx_sound("emt_int_horror_wind_high",(-764,9984,146),1,"aud_stop_school_interior");
	common_scripts\utility::loop_fx_sound("emt_int_horror_wind_low",(-764,9984,146),1,"aud_stop_school_interior");
	common_scripts\utility::loop_fx_sound("emt_int_exp_rain",(-603,9660,146),1,"aud_stop_school_interior");
	common_scripts\utility::loop_fx_sound("emt_int_horror_wind_high",(-970,9965,172),1,"aud_stop_school_interior");
	common_scripts\utility::loop_fx_sound("emt_int_horror_wind_low",(-970,9965,172),1,"aud_stop_school_interior");
	common_scripts\utility::loop_fx_sound("emt_int_exp_rain",(-603,9660,146),1,"aud_stop_school_interior");
	common_scripts\utility::loop_fx_sound("emt_int_horror_wind_low",(-1420,9885,157),1,"aud_stop_school_interior");
	common_scripts\utility::loop_fx_sound("emt_int_exp_rain",(-603,9660,146),1,"aud_stop_school_interior");
	common_scripts\utility::loop_fx_sound("emt_int_horror_wind_low",(-2340,9474,166),1,"aud_stop_school_interior");
	common_scripts\utility::loop_fx_sound("emt_int_horror_wind_high",(-2340,9474,166),1,"aud_stop_school_interior");
	common_scripts\utility::loop_fx_sound("emt_int_exp_rain",(-603,9660,146),1,"aud_stop_school_interior");
	common_scripts\utility::loop_fx_sound("emt_int_horror_wind_low",(-764,9807,146),1,"aud_stop_school_interior");
	common_scripts\utility::loop_fx_sound("emt_int_horror_wind_high",(-764,9807,146),1,"aud_stop_school_interior");
	common_scripts\utility::loop_fx_sound("emt_int_horror_wind_high",(-970,9965,172),1,"aud_stop_school_interior");
	common_scripts\utility::loop_fx_sound("emt_int_exp_rain",(-603,9660,146),1,"aud_stop_school_interior");
	common_scripts\utility::loop_fx_sound("emt_int_exp_rain",(-2253,9473,165),1,"aud_stop_school_interior");
	common_scripts\utility::loop_fx_sound("emt_int_exp_rain",(-2253,9277,165),1,"aud_stop_school_interior");
	common_scripts\utility::loop_fx_sound("emt_int_exp_rain",(-2295,9105,189),1,"aud_stop_school_interior");
	common_scripts\utility::loop_fx_sound("emt_int_exp_rain",(-2295,8864,189),1,"aud_stop_school_interior");
	if(level.currentgen)
	{
		level waittill("tff_pre_middle_remove_school");
		level notify("aud_stop_school_interior");
	}
}

//Function Number: 14
launch_office_loops()
{
	if(level.currentgen && !issubstr(level.transient_zone,"_nightclub"))
	{
		level waittill("tff_post_middle_add_nightclub");
		wait(0.05);
	}

	common_scripts\utility::loop_fx_sound("office_skylight_rain_lp",(-1171,4342,-79),1,"aud_stop_office");
	common_scripts\utility::loop_fx_sound("emt_rain_thru_roof_to_puddle",(-1171,4342,-79),1,"aud_stop_office");
	if(level.currentgen)
	{
		level waittill("tff_pre_middle_remove_nightclub");
		level notify("aud_stop_office");
	}
}

//Function Number: 15
start_point_source_dambs()
{
	thread launch_intro_point_source_dambs();
	thread launch_school_street_point_source_dambs();
	thread launch_school_interior_point_source_dambs();
}

//Function Number: 16
launch_intro_point_source_dambs()
{
}

//Function Number: 17
launch_school_street_point_source_dambs()
{
	if(level.currentgen && !issubstr(level.transient_zone,"middle"))
	{
		level waittill("tff_post_intro_to_middle");
		wait(0.05);
	}

	soundscripts\_audio_dynamic_ambi::damb_start_preset_at_point("dtrt_school_chain_link_fence_tarps",(-2607,8227,-89),"outside_school1");
	soundscripts\_audio_dynamic_ambi::damb_start_preset_at_point("dtrt_school_chain_link_fence_tarps",(-2601,8346,-89),"outside_school2");
	soundscripts\_audio_dynamic_ambi::damb_start_preset_at_point("dtrt_school_chain_link_fence_tarps",(-2601,8443,-89),"outside_school3");
	soundscripts\_audio_dynamic_ambi::damb_start_preset_at_point("dtrt_school_chain_link_fence_tarps",(-2601,8745,-88),"outside_school4");
	soundscripts\_audio_dynamic_ambi::damb_start_preset_at_point("dtrt_school_chain_link_fence_tarps",(-2564,8853,-85),"outside_school5");
	soundscripts\_audio_dynamic_ambi::damb_start_preset_at_point("dtrt_school_chain_link_fence_tarps",(-2655,7487,-97),"outside_school1");
	soundscripts\_audio_dynamic_ambi::damb_start_preset_at_point("dtrt_school_chain_link_fence_tarps",(-2655,7646,-97),"outside_school2");
	soundscripts\_audio_dynamic_ambi::damb_start_preset_at_point("dtrt_school_chain_link_fence_tarps",(-2656,7830,-95),"outside_school3");
	soundscripts\_audio_dynamic_ambi::damb_start_preset_at_point("dtrt_school_chain_link_fence_tarps",(-2655,7967,-91),"outside_school4");
	soundscripts\_audio_dynamic_ambi::damb_start_preset_at_point("dtrt_school_chain_link_fence_tarps",(-2538,8092,-89),"outside_school5");
	soundscripts\_audio_dynamic_ambi::damb_start_preset_at_point("dtrt_school_chain_link_fence_tarps",(-2378,8092,-89),"outside_school6");
}

//Function Number: 18
launch_school_interior_point_source_dambs()
{
	if(level.currentgen && !issubstr(level.transient_zone,"_school"))
	{
		level waittill("tff_post_middle_add_school");
		wait(0.05);
	}

	soundscripts\_audio_dynamic_ambi::damb_start_preset_at_point("det_int_wisp_gusts",(-686,9804,-10),"bodies");
	soundscripts\_audio_dynamic_ambi::damb_start_preset_at_point("dtrt_school_wind_gusts",(-603,9660,146),"window_01");
	soundscripts\_audio_dynamic_ambi::damb_start_preset_at_point("det_int_wisp_gusts",(-764,9807,146),"window_02");
	soundscripts\_audio_dynamic_ambi::damb_start_preset_at_point("dtrt_school_wind_gusts",(-970,9965,172),"window_03");
	soundscripts\_audio_dynamic_ambi::damb_start_preset_at_point("det_int_wisp_gusts",(-2340,9474,166),"train_01");
	soundscripts\_audio_dynamic_ambi::damb_start_preset_at_point("det_int_wisp_gusts",(-2304,9273,166),"train_02");
	soundscripts\_audio_dynamic_ambi::damb_start_preset_at_point("dtrt_school_wind_gusts",(-2336,8936,189),"train_03_sml");
	soundscripts\_audio_dynamic_ambi::damb_start_preset_at_point("det_int_wisp_gusts",(-852,9335,-10),"before_staircase");
	soundscripts\_audio_dynamic_ambi::damb_start_preset_at_point("damb_det_bsmnt",(-1215,9382,-187),"drips_01");
	soundscripts\_audio_dynamic_ambi::damb_start_preset_at_point("damb_det_bsmnt",(-1026,9359,-187),"drips_02");
	soundscripts\_audio_dynamic_ambi::damb_start_preset_at_point("damb_det_bsmnt",(-802,9435,-187),"drips_03");
	soundscripts\_audio_dynamic_ambi::damb_start_preset_at_point("damb_det_bsmnt",(-958,9141,-187),"drips_04");
	soundscripts\_audio_dynamic_ambi::damb_start_preset_at_point("damb_det_bsmnt",(-1076,9252,-187),"drips_05");
	if(level.currentgen)
	{
		level waittill("tff_pre_middle_remove_school");
		soundscripts\_audio_dynamic_ambi::damb_stop_preset_at_point("det_int_wisp_gusts","bodies");
		soundscripts\_audio_dynamic_ambi::damb_stop_preset_at_point("dtrt_school_wind_gusts","window_01");
		soundscripts\_audio_dynamic_ambi::damb_stop_preset_at_point("det_int_wisp_gusts","window_02");
		soundscripts\_audio_dynamic_ambi::damb_stop_preset_at_point("dtrt_school_wind_gusts","window_03");
		soundscripts\_audio_dynamic_ambi::damb_stop_preset_at_point("det_int_wisp_gusts","train_01");
		soundscripts\_audio_dynamic_ambi::damb_stop_preset_at_point("det_int_wisp_gusts","train_02");
		soundscripts\_audio_dynamic_ambi::damb_stop_preset_at_point("dtrt_school_wind_gusts","train_03_sml");
		soundscripts\_audio_dynamic_ambi::damb_stop_preset_at_point("det_int_wisp_gusts","before_staircase");
		soundscripts\_audio_dynamic_ambi::damb_stop_preset_at_point("damb_det_bsmnt","drips_01");
		soundscripts\_audio_dynamic_ambi::damb_stop_preset_at_point("damb_det_bsmnt","drips_02");
		soundscripts\_audio_dynamic_ambi::damb_stop_preset_at_point("damb_det_bsmnt","drips_03");
		soundscripts\_audio_dynamic_ambi::damb_stop_preset_at_point("damb_det_bsmnt","drips_04");
		soundscripts\_audio_dynamic_ambi::damb_stop_preset_at_point("damb_det_bsmnt","drips_05");
	}
}

//Function Number: 19
create_level_envelop_arrays()
{
	level.aud.envs = [];
	level.aud.envs["example_envelop"] = [[0,0],[0.082,0.426],[0.238,0.736],[0.408,0.844],[0.756,0.953],[1,1]];
	level.aud.envs["gaz_strafe_whizybys"] = [[0,0],[1,1]];
}

//Function Number: 20
precache_presets()
{
}

//Function Number: 21
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
		case "exit_dtrt_ext_deserted_street_school":
			if(var_03 == "dtrt_ext_deserted_street_school")
			{
				level notify("snd_water_garage_clear");
			}
			break;

		case "enter_dtrt_ext_deserted_street_school":
			if(var_02 == "dtrt_ext_deserted_street_school")
			{
				soundscripts\_snd_playsound::snd_play_loop_at("emt_water_garage",(-5239,8796,-248),"snd_water_garage_clear",2,2);
				soundscripts\_snd_playsound::snd_play_loop_at("emt_water_garage",(-3153,7729,-249),"snd_water_garage_clear",2,2);
				soundscripts\_snd_playsound::snd_play_loop_at("emt_water_garage",(-4189,7022,-199),"snd_water_garage_clear",2,2);
			}
			break;

		case "enter_dtrt_int_school_floor_1":
			if(var_02 == "dtrt_ext_deserted_street_school")
			{
				music("entering_school_from_deserted_street");
				var_04 = (-1793,9421,22);
				thread start_fuorescent_light_hum(var_04);
				thread monitor_fuorescent_light_dist(var_04);
				soundscripts\_audio_mix_manager::mm_add_submix("det_school_fs_override");
				level.aud.in_school = 1;
			}
			break;

		case "exit_dtrt_int_school_floor_1":
			if(var_03 == "dtrt_int_school_floor_1")
			{
				level notify("kill_temp_outside_school_wind_loop");
				soundscripts\_audio_mix_manager::mm_add_submix("det_school_fs_override");
			}
	
			if(var_03 == "dtrt_ext_deserted_street_school")
			{
				level.aud.in_school = 0;
				soundscripts\_audio_mix_manager::mm_clear_submix("det_school_fs_override");
			}
			break;

		case "exit_dtrt_int_school_floor_1_bodies_room":
			if(var_03 == "dtrt_int_school_floor_1_bodies_room")
			{
				music("school_floor_1_bodies_room");
			}
			break;

		case "exit_dtrt_int_school_exit_room":
			if(var_03 == "dtrt_int_school_exit_room")
			{
				music("school");
			}
			break;

		case "enter_dtrt_int_school_basement_stairs":
			if(var_02 == "dtrt_int_school_basement")
			{
				level.aud.in_school = 1;
				level.aud.in_basement = 0;
				music("exit_basement");
			}
			break;

		case "exit_dtrt_int_school_basement_stairs":
			if(var_03 == "dtrt_int_school_basement")
			{
				level.aud.in_school = 0;
				level.aud.in_basement = 1;
			}
			break;

		case "enter_dtrt_ext_streets_alleyway":
			if(var_02 == "dtrt_int_school_exit_room")
			{
				level.aud.in_school = 0;
				soundscripts\_audio_mix_manager::mm_clear_submix("det_school_fs_override");
			}
			break;

		case "exit_dtrt_ext_streets_alleyway":
			if(var_03 == "dtrt_int_school_exit_room")
			{
				level.aud.in_school = 1;
				soundscripts\_audio_mix_manager::mm_add_submix("det_school_fs_override");
			}
			break;

		case "enter_dtrt_int_abandoned_bank":
			if(var_02 == "dtrt_ext_streets_alleyway")
			{
				soundscripts\_audio_mix_manager::mm_clear_submix("alley_combat_trains_down");
				soundscripts\_audio_mix_manager::mm_add_submix("alley_combat_trains_off");
			}
			else if(var_02 == "dtrt_int_abandoned_bank")
			{
				soundscripts\_audio_mix_manager::mm_clear_submix("alley_combat_trains_off");
				soundscripts\_audio_mix_manager::mm_clear_submix("alley_combat_trains_down");
			}
			break;

		case "enter_dtrt_ext_train_tracks":
			if(var_02 == "dtrt_int_hospital_exit_stairwell")
			{
				soundscripts\_audio_mix_manager::mm_clear_submix("alley_combat_trains_down");
				soundscripts\_audio_mix_manager::mm_clear_submix("alley_combat_trains_off");
			}
	
			break;
	}
}

//Function Number: 22
music(param_00,param_01)
{
	thread music_handler(param_00,param_01);
}

//Function Number: 23
music_handler(param_00,param_01)
{
	level notify("stop_current_music_thread");
	level endon("stop_current_music_thread");
	var_02 = 0.7;
	var_03 = 0.2;
	var_04 = 0.5;
	switch(param_00)
	{
		case "start_refugee_camp":
			music("refugee_camp");
			break;

		case "start_drive_in":
			music("refugee_camp");
			break;

		case "start_school":
			music("off",param_01);
			break;

		case "start_school_interior":
			music("off",param_01);
			break;

		case "start_school_before_fall":
			music("off",param_01);
			break;

		case "start_school_basement":
			music("off",param_01);
			break;

		case "start_school_wall_grab":
			music("school_floor_1_bodies_room");
			break;

		case "start_alleyway":
			music("mus_pre_alley_combat");
			break;

		case "start_office":
			music("mus_alley_combat");
			break;

		case "start_exopush":
			music("off");
			break;

		case "start_hospital":
			music("off");
			break;

		case "start_hospital_capture_animation":
			music("off");
			break;

		case "start_sentinel_reveal":
			music("off");
			break;

		case "start_exit_drive":
			music("mus_pre_exit_drive");
			break;

		case "off":
			soundscripts\_audio_music::mus_stop(param_01);
			break;

		case "refugee_camp":
			soundscripts\_audio::aud_set_music_submix(var_02,0);
			wait(10);
			soundscripts\_audio_music::mus_play("det_mus_refugee_camp",0.5);
			break;

		case "begin_intro_conversation":
			soundscripts\_audio::aud_set_music_submix(var_02 * 0.45,1);
			break;

		case "end_intro_conversation":
			soundscripts\_audio::aud_set_music_submix(var_02 * 0.8,3);
			break;

		case "end_refugee_camp_civ_convo_01":
			soundscripts\_audio_music::mus_stop(45);
			break;

		case "jetbike_intro":
			mus_auto_submixer("off",1,3);
			soundscripts\_audio_music::mus_stop(3);
			break;

		case "drive_in_done":
			mus_auto_submixer("off",1,3);
			soundscripts\_audio_music::mus_stop(5);
			break;

		case "begin_on_foot_segment":
			mus_auto_submixer("off",1,3);
			soundscripts\_audio_music::mus_stop(5);
			break;

		case "walk_to_school":
			wait(3);
			soundscripts\_audio::aud_set_music_submix(1,1);
			soundscripts\_audio_music::mus_play("det_mus_walk_to_the_school",8);
			break;

		case "entering_school_from_deserted_street":
			break;

		case "horror_burke_gets_up_after_tile":
			mus_auto_submixer("off",0.25,9);
			soundscripts\_audio_music::mus_play("det_mus_horror_lp_01",14);
			break;

		case "horror_burk_door_open_end":
			soundscripts\_audio::aud_set_music_submix(0.25,0);
			soundscripts\_audio_music::mus_play("det_mus_horror_lp_02_end",0,3);
			break;

		case "school_floor_1_bodies_room":
			mus_auto_submixer("off",var_03 * 2,3);
			wait(0.5);
			soundscripts\_audio_music::mus_play("det_mus_school");
			wait(10);
			soundscripts\_audio::aud_set_music_submix(var_03,15);
			break;

		case "finish_bodies_room_burke":
			soundscripts\_audio::aud_set_music_submix(var_03 / 2,5);
			break;

		case "body_room_exit":
			soundscripts\_audio_music::mus_stop(4);
			soundscripts\_audio::aud_set_music_submix(var_03,4);
			break;

		case "school_upthestairs":
			soundscripts\_audio::aud_set_music_submix(var_03,1);
			soundscripts\_audio_music::mus_play("det_mus_low_tension1",5);
			break;

		case "horror_ghost_runs_by_door":
			break;

		case "burke_beam_bend":
			soundscripts\_audio_music::mus_stop(8);
			break;

		case "school_fall_into_basement":
			soundscripts\_audio_music::mus_stop(1);
			break;

		case "exit_basement":
			mus_auto_submixer("off",var_03,0);
			soundscripts\_audio_music::mus_play("det_mus_low_tension3",5);
			break;

		case "wallpull":
			mus_auto_submixer("off",1,0);
			soundscripts\_audio_music::mus_play("det_mus_wallpull",0,0);
			wait(1);
			soundscripts\_audio::aud_set_music_submix(0.5,3);
			break;

		case "mus_pre_alley_combat":
			mus_auto_submixer("off",0.5,10);
			soundscripts\_audio_music::mus_play("det_mus_am_battlecry_perc1c",10,3);
			break;

		case "mus_alley_combat":
			wait(1);
			mus_auto_submixer("on",1,0,"npc_count");
			soundscripts\_audio_music::mus_play("det_mus_am_battlecry_lp",0,1);
			break;

		case "office_reunion_dialogue":
			soundscripts\_audio_music::mus_play("det_mus_am_battlecry_end",0,1);
			wait(10);
			mus_auto_submixer("off",1,10);
			break;

		case "mus_pre_van_push":
			mus_auto_submixer("off",0.6,0);
			soundscripts\_audio_music::mus_play("det_mus_am_battlecry_end",0,1);
			break;

		case "mus_sounddone_det_gdn_mitchellonme":
			soundscripts\_audio::aud_set_music_submix(0.25,0);
			wait(0.25);
			soundscripts\_audio_music::mus_play("det_mus_high_tension1",0);
			break;

		case "det_sent_rev_explo":
			soundscripts\_audio_music::mus_stop(0.1);
			break;

		case "mus_pre_exit_drive":
			mus_auto_submixer("off",0.7,0);
			soundscripts\_audio_music::mus_play("det_mus_high_tension1",12);
			break;

		case "mus_exit_drive":
			wait(1);
			mus_auto_submixer("off",1.3,1);
			soundscripts\_audio_music::mus_play("det_mus_exit_drive",1,3);
			break;

		case "mus_end_exit_drive":
			soundscripts\_audio_music::mus_stop(3);
			break;

		case "mus_det_ending_win":
			soundscripts\_audio::aud_set_music_submix(0.6,0.05);
			wait(0.05);
			soundscripts\_audio_music::mus_play("det_mus_ending_win");
			break;

		default:
			soundscripts\_audio::aud_print_warning("\tMUSIC MESSAGE NOT HANDLED: " + param_00);
			break;
	}
}

//Function Number: 24
mus_auto_submixer(param_00,param_01,param_02,param_03)
{
	thread mus_auto_submixer_thread(param_00,param_01,param_02,param_03);
}

//Function Number: 25
mus_auto_submixer_thread(param_00,param_01,param_02,param_03)
{
	level notify("kill_mus_auto_submixer");
	level endon("kill_mus_auto_submixer");
	param_00 = soundscripts\_audio::aud_get_optional_param("on",param_00);
	param_01 = soundscripts\_audio::aud_get_optional_param(1,param_01);
	param_02 = soundscripts\_audio::aud_get_optional_param(1,param_02);
	param_03 = soundscripts\_audio::aud_get_optional_param("plr_speed",param_03);
	if(param_00 == "off")
	{
		soundscripts\_audio::aud_set_music_submix(param_01,param_02);
		return;
	}

	var_04 = 0.25;
	if(param_03 == "plr_speed")
	{
		var_05 = [[0,0],[10,1]];
		var_06 = 0.15;
		var_07 = 0.02;
		var_08 = 10;
		var_09 = 17.6;
		for(;;)
		{
			var_0A = length(level.player getvelocity()) / var_09;
			if(getdvarint("print_player_speed"))
			{
				iprintln(var_0A);
			}

			if(var_0A > var_08)
			{
				var_0B = var_06;
			}
			else
			{
				var_0B = var_07;
			}

			var_08 = var_08 + var_0B * var_0A - var_08;
			var_0C = piecewiselinearlookup(var_08,var_05);
			var_0C = var_0C * param_01;
			soundscripts\_audio::aud_set_music_submix(var_0C,var_04);
			wait(var_04);
		}

		return;
	}

	if(param_03 == "npc_count")
	{
		var_0D = [[0,0.4],[10,1]];
		var_06 = 0.3;
		var_07 = 0.3;
		var_0E = 0;
		for(;;)
		{
			var_0F = 0;
			var_10 = getaiarray("bad_guys");
			foreach(var_12 in var_10)
			{
				if(isdefined(var_12.alertlevelint) && var_12.alertlevelint >= 3)
				{
					var_0F++;
				}
			}

			if(getdvarint("snd_det_print_npc_count"))
			{
				iprintln(var_0F);
			}

			if(var_0F > var_0E)
			{
				var_0B = var_06;
			}
			else
			{
				var_0B = var_07;
			}

			var_0E = var_0E + var_0B * var_0F - var_0E;
			var_0C = piecewiselinearlookup(var_0E,var_0D);
			var_0C = var_0C * param_01;
			soundscripts\_audio::aud_set_music_submix(var_0C,var_04);
			wait(var_04);
		}
	}
}

//Function Number: 26
auto_combat_music(param_00)
{
	level endon("stop_current_music_thread");
	var_01 = 0.25;
	var_02 = 0;
	param_00 = soundscripts\_audio::aud_get_optional_param(1,param_00);
	mus_auto_submixer("off",param_00,1);
	for(;;)
	{
		var_03 = mus_get_combat_count();
		if(var_03 != var_02)
		{
			var_02 = var_03;
			if(var_03 > 0)
			{
				soundscripts\_audio::aud_set_music_submix(param_00,1);
				soundscripts\_audio_music::mus_play("det_mus_generic_combat",1,3);
			}
			else
			{
				soundscripts\_audio::aud_set_music_submix(param_00 * 0.66,10);
				soundscripts\_audio_music::mus_play("det_mus_high_tension1",10,10);
			}
		}

		wait(var_01);
	}
}

//Function Number: 27
mus_get_combat_count()
{
	var_00 = 0;
	var_01 = 0;
	var_02 = getaiarray("bad_guys");
	foreach(var_04 in var_02)
	{
		if(isdefined(var_04.alertlevelint) && var_04.alertlevelint >= 3)
		{
			var_01++;
		}
	}

	return var_01;
}

//Function Number: 28
start_refugee_camp(param_00)
{
	soundscripts\_audio_zone_manager::azm_start_zone("dtrt_ext_refugee_camp",0.5);
	music("start_refugee_camp");
}

//Function Number: 29
start_drive_in(param_00)
{
	soundscripts\_audio_zone_manager::azm_start_zone("dtrt_ext_refugee_camp",0.5);
	music("start_drive_in");
}

//Function Number: 30
start_school(param_00)
{
	soundscripts\_audio_zone_manager::azm_start_zone("dtrt_int_parking_garage",0.5);
	music("start_school");
}

//Function Number: 31
start_school_interior(param_00)
{
	soundscripts\_audio_zone_manager::azm_start_zone("dtrt_ext_deserted_street_school",0.5);
	music("start_school_interior");
}

//Function Number: 32
start_school_before_fall(param_00)
{
	soundscripts\_audio_zone_manager::azm_start_zone("dtrt_int_school_floor_3",0.5);
	music("start_school_before_fall");
	level.aud.in_school = 1;
	soundscripts\_audio_mix_manager::mm_add_submix("det_school_fs_override");
}

//Function Number: 33
start_school_basement(param_00)
{
	soundscripts\_audio_zone_manager::azm_start_zone("dtrt_int_school_basement",0.5);
	music("start_school_basement");
	level.aud.in_school = 0;
	level.aud.in_basement = 1;
	soundscripts\_audio_mix_manager::mm_add_submix("det_school_fs_override");
}

//Function Number: 34
start_school_wall_grab(param_00)
{
	soundscripts\_audio_zone_manager::azm_start_zone("dtrt_int_school_floor_2",0.5);
	music("start_school_wall_grab");
	level.aud.in_school = 1;
	soundscripts\_audio_mix_manager::mm_add_submix("det_school_fs_override");
	maps\_utility::delaythread(1,::setup_wallpull);
}

//Function Number: 35
start_alleyway(param_00)
{
	soundscripts\_audio_zone_manager::azm_start_zone("dtrt_int_school_exit_room",0.5);
	music("start_alleyway");
	level.aud.in_school = 1;
	soundscripts\_audio_mix_manager::mm_add_submix("dtrt_school_fs_override");
}

//Function Number: 36
start_office(param_00)
{
	soundscripts\_audio_zone_manager::azm_start_zone("dtrt_int_abandoned_bank",0.5);
	music("start_office");
}

//Function Number: 37
start_exopush(param_00)
{
	soundscripts\_audio_zone_manager::azm_start_zone("dtrt_ext_streets_clean",0.5);
	music("start_exopush");
}

//Function Number: 38
start_hospital(param_00)
{
	soundscripts\_audio_zone_manager::azm_start_zone("dtrt_ext_streets_clean",0.5);
	music("start_hospital");
}

//Function Number: 39
start_hospital_capture_animation(param_00)
{
	soundscripts\_audio_zone_manager::azm_start_zone("dtrt_int_hospital_office_hallway",0.5);
	music("start_hospital_capture_animation");
}

//Function Number: 40
start_sentinel_reveal(param_00)
{
	soundscripts\_audio_zone_manager::azm_start_zone("dtrt_ext_train_tracks",0.5);
	music("start_sentinel_reveal");
}

//Function Number: 41
start_exit_drive(param_00)
{
	soundscripts\_audio_zone_manager::azm_start_zone("dtrt_int_sent_stairs",0.5);
	music("start_exit_drive");
}

//Function Number: 42
opening_start()
{
	soundscripts\_audio_mix_manager::mm_add_submix("det_opening_warbird",0.05);
	soundscripts\_snd_playsound::snd_play_delayed_2d("det_intro_door_mech_a",0.1);
	soundscripts\_snd_playsound::snd_play_delayed_2d("det_intro_door_mech_b",0.1);
	soundscripts\_snd_playsound::snd_play_delayed_2d("det_intro_door_decompress",0.1);
	soundscripts\_snd_playsound::snd_play_delayed_2d("det_intro_door_wind",0.1);
	soundscripts\_snd_playsound::snd_play_delayed_2d("det_intro_warbird_blades",0.1);
	soundscripts\_snd_playsound::snd_play_delayed_2d("det_intro_warbird_engine",3.1);
	soundscripts\_snd_playsound::snd_play_delayed_2d("det_intro_warbird_chop",6.15);
	soundscripts\_snd_playsound::snd_play_delayed_2d("det_intro_warbird_flyaway",9);
	wait(4);
	soundscripts\_audio_mix_manager::mm_clear_submix("det_opening_warbird");
	soundscripts\_audio_mix_manager::mm_add_submix("det_opening_pcap_scene");
	wait(14);
	soundscripts\_audio_mix_manager::mm_clear_submix("det_opening_pcap_scene",5);
}

//Function Number: 43
level_intro_cinematic(param_00)
{
}

//Function Number: 44
begin_refugee_walk(param_00)
{
}

//Function Number: 45
begin_intro_conversation()
{
	soundscripts\_audio_mix_manager::mm_add_submix("intro_conversation");
	music("begin_intro_conversation");
	level waittill("end_intro_conversation");
	soundscripts\_audio_mix_manager::mm_clear_submix("intro_conversation");
	music("end_intro_conversation");
}

//Function Number: 46
start_stage_dialog()
{
	var_00 = ["detroit_atr_youllbewontbeable","detroit_atr_onceyourdnaisin","detroit_atr_ifyouhaveaquestion","detroit_atr_remembernothinghappensunlessyou","detroit_atr_weappreciateyourpatience","detroit_atr_sectorsathroughfwill","detroit_atr_werereopeningthesectorc","detroit_atr_iknowyouallhave","detroit_atr_werelookingatarolling"];
	var_01 = [14.07,12.19,3.18,10.25,4.21,7.27,3.29,6.09,2.2];
	var_02 = (-12584,9182,48);
	common_scripts\utility::flag_set("flag_stage_dialogue_start_audio");
	for(var_03 = 0;var_03 < var_00.size;var_03++)
	{
		var_04 = var_00[var_03] + "_near";
		var_05 = soundscripts\_snd_playsound::snd_play_at(var_04,var_02);
		var_04 = var_00[var_03] + "_far";
		var_06 = soundscripts\_snd_playsound::snd_play_delayed_2d(var_04,0.2,undefined,undefined,undefined,undefined,0.45);
		var_06 thread monitor_pa_dist(var_02);
		wait(var_01[var_03]);
		wait(1);
	}

	common_scripts\utility::flag_set("flag_stage_dialogue_end_audio");
}

//Function Number: 47
monitor_pa_dist(param_00)
{
	self endon("death");
	self endon("sounddone");
	var_01 = [[360,0],[3600,1]];
	for(;;)
	{
		var_02 = distance2d(param_00,level.player.origin);
		var_03 = soundscripts\_snd::snd_map(var_02,var_01);
		self scalevolume(var_03);
		wait(0.2);
	}
}

//Function Number: 48
setup_decon_gate_anims()
{
	if(level.currentgen && !issubstr(level.transient_zone,"intro"))
	{
		level waittill("detroit_intro_tr");
	}

	maps\_anim::addnotetrack_customfunction("decon_gate","front_door_close",::scanner_front_door_close,"decon_scanner_front");
	maps\_anim::addnotetrack_customfunction("decon_gate","rear_door_close",::scanner_rear_door_close,"decon_scanner_back");
	maps\_anim::addnotetrack_customfunction("decon_gate","scanner_forward",::scanner_forward,"decon_scanner_back");
	maps\_anim::addnotetrack_customfunction("decon_gate","scanner_back",::scanner_return,"decon_scanner_back");
	maps\_anim::addnotetrack_customfunction("decon_gate","front_door_open",::scanner_front_door_open,"decon_scanner_back");
	maps\_anim::addnotetrack_customfunction("bones","bones_high_five",::bones_high_five,"gate_decon_b");
}

//Function Number: 49
scanner_front_door_close(param_00)
{
	soundscripts\_audio_mix_manager::mm_add_submix("det_decon_scanner");
	soundscripts\_audio_zone_manager::azm_set_reverb_enable(0);
	soundscripts\_audio_reverb::rvb_start_preset("det_decon_scanner_open",0.5);
	soundscripts\_snd_playsound::snd_play_at("decon_scanner_front_door_cl",(-12341,7197,-34));
}

//Function Number: 50
scanner_rear_door_close(param_00)
{
	soundscripts\_audio_reverb::rvb_start_preset("det_decon_scanner_closed",0.5);
	soundscripts\_snd_playsound::snd_play_at("decon_scanner_back_door_cl",(-12354,7460,-34));
}

//Function Number: 51
scanner_forward(param_00)
{
	thread scanner_beam();
	var_01 = soundscripts\_snd_playsound::snd_play_at("decon_scanner_device_front_left",(-12301,7215,-34));
	var_02 = soundscripts\_snd_playsound::snd_play_at("decon_scanner_device_front_right",(-12403,7214,-34));
	var_03 = soundscripts\_snd_playsound::snd_play_at("decon_scanner_device_rear_left",(-12302,7445,-34));
	var_04 = soundscripts\_snd_playsound::snd_play_at("decon_scanner_device_rear_right",(-12405,7452,-34));
	var_01 moveto((-12301,7308,-34),3,0.5,0.5);
	var_02 moveto((-12403,7302,-34),3,0.5,0.5);
	var_03 moveto((-12302,7353,-34),3,0.5,0.5);
	var_04 moveto((-12403,7356,-34),3,0.5,0.5);
}

//Function Number: 52
scanner_return(param_00)
{
	var_01 = soundscripts\_snd_playsound::snd_play_at("decon_scanner_device_front_left_return",(-12301,7308,-34));
	var_02 = soundscripts\_snd_playsound::snd_play_at("decon_scanner_device_front_right_return",(-12403,7302,-34));
	var_03 = soundscripts\_snd_playsound::snd_play_at("decon_scanner_device_rear_left_return",(-12302,7353,-34));
	var_04 = soundscripts\_snd_playsound::snd_play_at("decon_scanner_device_rear_right_return",(-12403,7356,-34));
	var_01 moveto((-12301,7215,-34),3,0.5,0.5);
	var_02 moveto((-12403,7214,-34),3,0.5,0.5);
	var_03 moveto((-12302,7445,-34),3,0.5,0.5);
	var_04 moveto((-12405,7452,-34),3,0.5,0.5);
}

//Function Number: 53
scanner_beam()
{
	var_00 = soundscripts\_snd_playsound::snd_play_at("decon_scanner_beam",(-12354,7213,-34));
	var_01 = soundscripts\_snd_playsound::snd_play_at("decon_scanner_beam",(-12352,7444,-34));
	var_00 moveto((-12354,7310,-34),3.2,0.5,0.5);
	var_01 moveto((-12352,7358,-34),3.2,0.5,0.5);
	wait(3.21);
	if(isdefined(var_00))
	{
		var_00 moveto((-12354,7213,-34),3.2,0.5,0.5);
	}

	if(isdefined(var_01))
	{
		var_01 moveto((-12352,7444,-34),3.2,0.5,0.5);
	}
}

//Function Number: 54
scanner_front_door_open(param_00)
{
	var_01 = soundscripts\_snd_playsound::snd_play_at("decon_scanner_front_door_open",(-12341,7197,-34));
	maps\_utility::delaythread(3,::soundscripts\_audio_reverb::rvb_start_preset,"det_refugee_camp",4);
	maps\_utility::delaythread(3.1,::soundscripts\_audio_zone_manager::azm_set_reverb_enable,1);
	var_01 waittill("sounddone");
	soundscripts\_audio_mix_manager::mm_clear_submix("det_decon_scanner");
}

//Function Number: 55
setup_entrance_gate_anims()
{
	if(level.currentgen && !issubstr(level.transient_zone,"_intro"))
	{
		level waittill("wait_forever_I_dont_care_its_already_happened");
	}

	maps\_anim::addnotetrack_customfunction("decon_gate","front_door_close",::entrance_scanner_front_door_close,"det_gate_decon_station");
	maps\_anim::addnotetrack_customfunction("decon_gate","front_door_open",::entrance_scanner_front_door_open,"det_gate_decon_station");
	maps\_anim::addnotetrack_customfunction("decon_gate","back_door_close",::entrance_scanner_back_door_close,"det_gate_decon_station");
	maps\_anim::addnotetrack_customfunction("decon_gate","back_door_open",::entrance_scanner_back_door_open,"det_gate_decon_station");
	maps\_anim::addnotetrack_customfunction("decon_gate","scanner_running",::entrance_scanner_running,"det_gate_decon_station");
}

//Function Number: 56
entrance_scanner_front_door_close(param_00)
{
	soundscripts\_snd_playsound::snd_play_at("entrance_gate_door_cl",(-12205,7204,-34));
}

//Function Number: 57
entrance_scanner_front_door_open(param_00)
{
	soundscripts\_snd_playsound::snd_play_at("entrance_gate_door_op",(-12205,7204,-34));
}

//Function Number: 58
entrance_scanner_back_door_close(param_00)
{
	soundscripts\_snd_playsound::snd_play_at("entrance_gate_door_cl",(-12200,7451,-34));
}

//Function Number: 59
entrance_scanner_back_door_open(param_00)
{
	soundscripts\_snd_playsound::snd_play_at("entrance_gate_door_op",(-12200,7451,-34));
}

//Function Number: 60
entrance_scanner_running(param_00)
{
	soundscripts\_snd_playsound::snd_play_at("entrance_gate_scanner",(-12174,7329,-34));
}

//Function Number: 61
bones_high_five(param_00)
{
	param_00 soundscripts\_snd_playsound::snd_play_linked("det_bones_high_five");
}

//Function Number: 62
setup_jetbike_motorpool_anims()
{
	maps\_anim::addnotetrack_customfunction("player_bike","player_bike_wing_flaps",::player_bike_wing_flaps,"hoverbike_mount");
	maps\_anim::addnotetrack_customfunction("player_bike","player_bike_wing_flaps_left",::player_bike_wing_flaps_left,"hoverbike_mount_left");
	maps\_anim::addnotetrack_customfunction("burke","burke_mounts_bike",::burke_mounts_bike,"hoverbike_mount");
	maps\_anim::addnotetrack_customfunction("burke","burke_powers_up_bike",::burke_powers_up_bike,"hoverbike_mount");
}

//Function Number: 63
player_bike_wing_flaps(param_00)
{
	soundscripts\_snd_playsound::snd_play_2d("camp_jtbk_start_servos");
}

//Function Number: 64
player_bike_wing_flaps_left(param_00)
{
	soundscripts\_snd_playsound::snd_play_2d("camp_jtbk_start_servos");
}

//Function Number: 65
burke_mounts_bike(param_00)
{
	param_00 soundscripts\_snd_playsound::snd_play_linked("camp_jtbk_burke_mount");
}

//Function Number: 66
burke_powers_up_bike(param_00)
{
	param_00 soundscripts\_snd_playsound::snd_play_linked("camp_jtbk_burke_start_engine");
}

//Function Number: 67
jetbike_intro(param_00)
{
	music("jetbike_intro");
	maps\_utility::delaythread(1.5,::jetbike_intro_hover_npc_bikes);
	soundscripts\_audio_mix_manager::mm_add_submix("det_motorpool_meet_up");
	if(param_00 == "left_anim")
	{
		soundscripts\_snd_playsound::snd_play_2d("det_jtbk_ridein_part1_accent_plr");
		level.joker soundscripts\_snd_playsound::snd_play_linked("det_jtbk_ridein_part1_accent_jok");
		soundscripts\_snd_playsound::snd_play_delayed_2d("camp_jtbk_mount_foley",0.2);
		soundscripts\_snd_playsound::snd_play_delayed_2d("camp_jtbk_ignition_foley",4.5);
		soundscripts\_snd_playsound::snd_play_delayed_2d("camp_jtbk_ignition",4.5);
		maps\_utility::delaythread(4.5,::jetbike_intro_hover_player_bike);
		return;
	}

	if(param_00 == "right_anim")
	{
		soundscripts\_snd_playsound::snd_play_2d("det_jtbk_ridein_part1_accent_plr");
		level.joker soundscripts\_snd_playsound::snd_play_linked("det_jtbk_ridein_part1_accent_jok");
		soundscripts\_snd_playsound::snd_play_delayed_2d("camp_jtbk_mount_foley",0);
		soundscripts\_snd_playsound::snd_play_delayed_2d("camp_jtbk_ignition_foley",4.6);
		soundscripts\_snd_playsound::snd_play_delayed_2d("camp_jtbk_ignition",4.6);
		maps\_utility::delaythread(4.6,::jetbike_intro_hover_player_bike);
	}
}

//Function Number: 68
jetbike_intro_hover_npc_bikes()
{
	soundscripts\_audio_mix_manager::mm_add_submix("det_jetbike_ridein");
	level.burke_bike maps\_utility::ent_flag_set("jetbike_is_hovering");
	level.joker_bike maps\_utility::ent_flag_set("jetbike_is_hovering");
	level.bones_bike maps\_utility::ent_flag_set("jetbike_is_hovering");
}

//Function Number: 69
jetbike_intro_hover_player_bike()
{
	level.player_bike maps\_utility::ent_flag_set("jetbike_is_hovering");
}

//Function Number: 70
setup_jetbike_checkpoint_anims()
{
	if(level.currentgen && !issubstr(level.transient_zone,"_gate"))
	{
		level waittill("tff_post_gatetrans_entry");
	}

	maps\_anim::addnotetrack_customfunction("burke","burke_hoverbike_land",::burke_gate_jtbk_land,"hoverbike_meet_up");
	maps\_anim::addnotetrack_customfunction("burke","burke_hoverbike_lift",::burke_gate_jtbk_lift,"hoverbike_meet_up");
	maps\_anim::addnotetrack_customfunction("joker","joker_hoverbike_land",::joker_gate_jtbk_land,"hoverbike_meet_up");
	maps\_anim::addnotetrack_customfunction("joker","joker_hoverbike_lift",::joker_gate_jtbk_lift,"hoverbike_meet_up");
	maps\_anim::addnotetrack_customfunction("bones","bones_hoverbike_land",::bones_gate_jtbk_land,"hoverbike_meet_up");
	maps\_anim::addnotetrack_customfunction("bones","bones_hoverbike_lift",::bones_gate_jtbk_lift,"hoverbike_meet_up");
}

//Function Number: 71
burke_gate_jtbk_land(param_00)
{
	param_00 soundscripts\_snd_playsound::snd_play_linked("det_chkpnt_jtbk_burke_land");
}

//Function Number: 72
burke_gate_jtbk_lift(param_00)
{
	param_00 soundscripts\_snd_playsound::snd_play_linked("det_chkpnt_jtbk_burke_lift");
}

//Function Number: 73
joker_gate_jtbk_land(param_00)
{
	param_00 soundscripts\_snd_playsound::snd_play_linked("det_chkpnt_jtbk_joker_land");
}

//Function Number: 74
joker_gate_jtbk_lift(param_00)
{
	param_00 soundscripts\_snd_playsound::snd_play_linked("det_chkpnt_jtbk_joker_lift");
}

//Function Number: 75
bones_gate_jtbk_land(param_00)
{
	param_00 soundscripts\_snd_playsound::snd_play_linked("det_chkpnt_jtbk_bones_land");
}

//Function Number: 76
bones_gate_jtbk_lift(param_00)
{
	param_00 soundscripts\_snd_playsound::snd_play_linked("det_chkpnt_jtbk_bones_lift");
}

//Function Number: 77
refugee_butress_down()
{
	if(isdefined(level.aud.refugee_butress_down_time) && gettime() - level.aud.refugee_butress_down_time < 1)
	{
		return;
	}

	level.aud.refugee_butress_down_time = gettime();
	soundscripts\_snd_playsound::snd_play_delayed_linked("barricade_lower_hydro",0);
	soundscripts\_snd_playsound::snd_play_delayed_linked("barricade_lower_cmprsr",0.113);
	soundscripts\_snd_playsound::snd_play_delayed_linked("barricade_lower_impact",0.7);
	soundscripts\_snd_playsound::snd_play_delayed_linked("barricade_lower_lfe",0.7);
	soundscripts\_snd_playsound::snd_play_delayed_linked("barricade_lower_far",0.9);
}

//Function Number: 78
gate_lightning()
{
	wait(0.5);
	soundscripts\_audio_mix_manager::mm_add_submix("det_gate_lightning",0.5);
	soundscripts\_snd_playsound::snd_play_2d("det_gate_lightning");
	wait(2);
	soundscripts\_audio_mix_manager::mm_clear_submix("det_gate_lightning",4);
	soundscripts\_audio_zone_manager::azm_set_zone_streamed_ambience(soundscripts\_audio_zone_manager::azm_get_current_zone(),"quad_ext_rain_mech_gate",6.5);
	soundscripts\_audio_mix_manager::mm_add_submix("det_mech_gate_ambi");
}

//Function Number: 79
setup_gideon_intro_foley()
{
	if(level.currentgen && level.transient_zone == "intro")
	{
		for(;;)
		{
			if(istransientloaded("detroit_introa_tr"))
			{
				break;
			}

			wait(0.25);
		}
	}

	if(level.currentgen && level.transient_zone != "intro")
	{
		level waittill("some_bs_that_will_never_happen_used_to_deal_with_start_points");
	}

	maps\_anim::addnotetrack_customfunction("burke","det_intro_gideon_foley_pt1",::det_intro_gideon_foley_pt1,"level_intro_cinematic");
	maps\_anim::addnotetrack_customfunction("burke","det_intro_gideon_foley_pt2",::det_intro_gideon_foley_pt2,"level_intro_cinematic");
	maps\_anim::addnotetrack_customfunction("burke","det_intro_gideon_foley_pt3",::det_intro_gideon_foley_pt3,"level_intro_cinematic");
}

//Function Number: 80
det_intro_gideon_foley_pt1(param_00)
{
	soundscripts\_snd_playsound::snd_play_2d("det_intro_gideon_foley_pt1");
}

//Function Number: 81
det_intro_gideon_foley_pt2(param_00)
{
	soundscripts\_snd_playsound::snd_play_2d("det_intro_gideon_foley_pt2");
}

//Function Number: 82
det_intro_gideon_foley_pt3(param_00)
{
	param_00 soundscripts\_snd_playsound::snd_play_linked("det_intro_gideon_foley_pt3");
}

//Function Number: 83
setup_det_intro_catch_anims()
{
	maps\_anim::addnotetrack_customfunction("drone_civs","start_det_catch_guy_01",::start_det_catch_guy_01,"baseball1");
	maps\_anim::addnotetrack_customfunction("drone_civs","det_catch_guy_01_pt_02",::det_catch_guy_01_pt_02,"baseball1");
	maps\_anim::addnotetrack_customfunction("drone_civs","det_catch_guy_01_pt_03",::det_catch_guy_01_pt_03,"baseball1");
	maps\_anim::addnotetrack_customfunction("drone_civs","det_catch_guy_01_ball_drop",::det_catch_guy_01_ball_drop,"baseball1");
	maps\_anim::addnotetrack_customfunction("drone_civs","det_catch_guy_01_pt_04",::det_catch_guy_01_pt_04,"baseball1");
	maps\_anim::addnotetrack_customfunction("drone_civs","det_catch_guy_01_pt_05",::det_catch_guy_01_pt_05,"baseball1");
	maps\_anim::addnotetrack_customfunction("drone_civs","start_det_catch_guy_02",::start_det_catch_guy_02,"baseball2");
	maps\_anim::addnotetrack_customfunction("drone_civs","det_catch_guy_02_pt_02",::det_catch_guy_02_pt_02,"baseball2");
	maps\_anim::addnotetrack_customfunction("drone_civs","det_catch_guy_02_pt_03",::det_catch_guy_02_pt_03,"baseball2");
	maps\_anim::addnotetrack_customfunction("drone_civs","det_catch_guy_02_pt_04",::det_catch_guy_02_pt_04,"baseball2");
	maps\_anim::addnotetrack_customfunction("drone_civs","det_catch_guy_02_pt_05",::det_catch_guy_02_pt_05,"baseball2");
}

//Function Number: 84
start_det_catch_guy_01(param_00)
{
	param_00 soundscripts\_snd_playsound::snd_play_linked("det_intro_catch_guy_01");
}

//Function Number: 85
det_catch_guy_01_pt_02(param_00)
{
	param_00 soundscripts\_snd_playsound::snd_play_linked("det_intro_catch_guy_01_pt_02");
}

//Function Number: 86
det_catch_guy_01_pt_03(param_00)
{
	param_00 soundscripts\_snd_playsound::snd_play_linked("det_intro_catch_guy_01_pt_03");
}

//Function Number: 87
det_catch_guy_01_ball_drop(param_00)
{
	param_00 soundscripts\_snd_playsound::snd_play_linked("det_intro_catch_guy_01_ball_drop");
}

//Function Number: 88
det_catch_guy_01_pt_04(param_00)
{
	param_00 soundscripts\_snd_playsound::snd_play_linked("det_intro_catch_guy_01_pt_04");
}

//Function Number: 89
det_catch_guy_01_pt_05(param_00)
{
	param_00 soundscripts\_snd_playsound::snd_play_linked("det_intro_catch_guy_01_pt_05");
}

//Function Number: 90
start_det_catch_guy_02(param_00)
{
	param_00 soundscripts\_snd_playsound::snd_play_linked("det_intro_catch_guy_02");
}

//Function Number: 91
det_catch_guy_02_pt_02(param_00)
{
	param_00 soundscripts\_snd_playsound::snd_play_linked("det_intro_catch_guy_02_pt_02");
}

//Function Number: 92
det_catch_guy_02_pt_03(param_00)
{
	param_00 soundscripts\_snd_playsound::snd_play_linked("det_intro_catch_guy_02_pt_03");
}

//Function Number: 93
det_catch_guy_02_pt_04(param_00)
{
	param_00 soundscripts\_snd_playsound::snd_play_linked("det_intro_catch_guy_02_pt_04");
}

//Function Number: 94
det_catch_guy_02_pt_05(param_00)
{
	param_00 soundscripts\_snd_playsound::snd_play_linked("det_intro_catch_guy_02_pt_05");
}

//Function Number: 95
setup_hoverbike_meet_up_notetracks()
{
	if(level.currentgen && !issubstr(level.transient_zone,"_gate"))
	{
		level waittill("tff_post_gatetrans_entry");
	}

	maps\_anim::addnotetrack_customfunction("mech1","aud_mech_scanner",::aud_mech_scanner,"hoverbike_meet_up");
	maps\_anim::addnotetrack_customfunction("entrance_gate","aud_big_gate_pre_open",::aud_big_gate_pre_open,"hoverbike_meet_up");
	maps\_anim::addnotetrack_customfunction("entrance_gate","aud_big_gate_open_stage_1",::aud_big_gate_open_stage_1,"hoverbike_meet_up");
	maps\_anim::addnotetrack_customfunction("entrance_gate","aud_big_gate_stop_stage_1",::aud_big_gate_stop_stage_1,"hoverbike_meet_up");
	maps\_anim::addnotetrack_customfunction("entrance_gate","aud_big_gate_open_stage_2",::aud_big_gate_open_stage_2,"hoverbike_meet_up");
	maps\_anim::addnotetrack_customfunction("entrance_gate","aud_big_gate_stop_stage_2",::aud_big_gate_stop_stage_2,"hoverbike_meet_up");
}

//Function Number: 96
aud_mech_scanner(param_00)
{
	param_00 soundscripts\_snd_playsound::snd_play_linked("det_mech_scanner");
}

//Function Number: 97
aud_big_gate_pre_open(param_00)
{
	soundscripts\_snd_playsound::snd_play_2d("det_jtbk_ridein_part2_accent_plr");
	level.joker soundscripts\_snd_playsound::snd_play_linked("det_jtbk_ridein_part2_accent_jok");
	wait(0.1);
	soundscripts\_snd_playsound::snd_play_delayed_2d("big_gate_buzzer",1.2);
	soundscripts\_snd_playsound::snd_play_delayed_2d("big_gate_movement_stage_1",1.25);
}

//Function Number: 98
aud_big_gate_open_stage_1(param_00)
{
	wait(0.1);
	soundscripts\_snd_playsound::snd_play_delayed_2d("big_gate_alarm_2x",0.05);
	soundscripts\_snd_playsound::snd_play_delayed_2d("big_gate_horn",1.25);
	soundscripts\_snd_playsound::snd_play_delayed_2d("big_gate_lock_stage_1",3.35);
	soundscripts\_snd_playsound::snd_play_delayed_2d("big_gate_lfe_impact_1",4.35);
}

//Function Number: 99
aud_big_gate_stop_stage_1(param_00)
{
	wait(0.1);
	soundscripts\_snd_playsound::snd_play_delayed_2d("big_gate_movement_stage_2",0.05);
}

//Function Number: 100
aud_big_gate_open_stage_2(param_00)
{
	soundscripts\_snd_playsound::snd_play_delayed_2d("big_gate_movement_stage_2_rear",2);
	soundscripts\_snd_playsound::snd_play_delayed_2d("big_gate_lock_stage_2",5.1);
	soundscripts\_snd_playsound::snd_play_delayed_2d("big_gate_lfe_impact_2",5.15);
}

//Function Number: 101
aud_big_gate_stop_stage_2(param_00)
{
	soundscripts\_audio_mix_manager::mm_clear_submix("det_motorpool_meet_up",5);
	soundscripts\_audio_mix_manager::mm_clear_submix("det_mech_gate_ambi");
}

//Function Number: 102
drive_in_done()
{
	music("drive_in_done");
}

//Function Number: 103
jetbikes_arrive_at_school()
{
	common_scripts\utility::flag_wait("aud_parking_garage_exit");
	level.burke soundscripts\_snd_playsound::snd_play_delayed_linked("det_school_jtbk_burke_land",1);
	level.joker soundscripts\_snd_playsound::snd_play_delayed_linked("det_school_jtbk_joker_land",1.4);
	level.bones soundscripts\_snd_playsound::snd_play_delayed_linked("det_school_jtbk_bones_land",2.3);
	soundscripts\_snd_playsound::snd_play_delayed_2d("det_jtbk_school_land",2.25);
	wait(10);
	soundscripts\_audio_mix_manager::mm_clear_submix("det_jetbike_ridein");
}

//Function Number: 104
setup_fence_climb_anims()
{
	if(level.currentgen && !issubstr(level.transient_zone,"middle"))
	{
		level waittill("tff_post_intro_to_middle");
	}

	maps\_anim::addnotetrack_customfunction("joker","climb_fence_joker_01",::climb_fence_joker_01,"bike_dismount");
	maps\_anim::addnotetrack_customfunction("joker","climb_fence_joker_02",::climb_fence_joker_02,"bike_dismount");
	maps\_anim::addnotetrack_customfunction("joker","climb_fence_joker_03",::climb_fence_joker_03,"bike_dismount");
	maps\_anim::addnotetrack_customfunction("joker","climb_fence_joker_04",::climb_fence_joker_04,"bike_dismount");
	maps\_anim::addnotetrack_customfunction("joker","climb_fence_joker_05",::climb_fence_joker_05,"bike_dismount");
	maps\_anim::addnotetrack_customfunction("joker","climb_fence_joker_06",::climb_fence_joker_06,"bike_dismount");
	maps\_anim::addnotetrack_customfunction("joker","climb_fence_joker_07",::climb_fence_joker_07,"bike_dismount");
	maps\_anim::addnotetrack_customfunction("joker","climb_fence_joker_08",::climb_fence_joker_08,"bike_dismount");
	maps\_anim::addnotetrack_customfunction("joker","climb_fence_joker_09",::climb_fence_joker_09,"bike_dismount");
	maps\_anim::addnotetrack_customfunction("joker","climb_fence_joker_10",::climb_fence_joker_10,"bike_dismount");
	maps\_anim::addnotetrack_customfunction("bones","climb_fence_torres_01",::climb_fence_torres_01,"bike_dismount");
	maps\_anim::addnotetrack_customfunction("bones","climb_fence_torres_02",::climb_fence_torres_02,"bike_dismount");
	maps\_anim::addnotetrack_customfunction("bones","climb_fence_torres_03",::climb_fence_torres_03,"bike_dismount");
	maps\_anim::addnotetrack_customfunction("bones","climb_fence_torres_04",::climb_fence_torres_04,"bike_dismount");
	maps\_anim::addnotetrack_customfunction("bones","climb_fence_torres_05",::climb_fence_torres_05,"bike_dismount");
	maps\_anim::addnotetrack_customfunction("bones","climb_fence_torres_06",::climb_fence_torres_06,"bike_dismount");
	maps\_anim::addnotetrack_customfunction("bones","climb_fence_torres_07",::climb_fence_torres_07,"bike_dismount");
	maps\_anim::addnotetrack_customfunction("bones","climb_fence_torres_08",::climb_fence_torres_08,"bike_dismount");
	maps\_anim::addnotetrack_customfunction("bones","climb_fence_torres_09",::climb_fence_torres_09,"bike_dismount");
	maps\_anim::addnotetrack_customfunction("bones","climb_fence_torres_10",::climb_fence_torres_10,"bike_dismount");
}

//Function Number: 105
climb_fence_joker_01(param_00)
{
	param_00 soundscripts\_snd_playsound::snd_play_linked("climb_fence_joker_01");
}

//Function Number: 106
climb_fence_joker_02(param_00)
{
	param_00 soundscripts\_snd_playsound::snd_play_linked("climb_fence_joker_02");
}

//Function Number: 107
climb_fence_joker_03(param_00)
{
	param_00 soundscripts\_snd_playsound::snd_play_linked("climb_fence_joker_03");
}

//Function Number: 108
climb_fence_joker_04(param_00)
{
	param_00 soundscripts\_snd_playsound::snd_play_linked("climb_fence_joker_04");
}

//Function Number: 109
climb_fence_joker_05(param_00)
{
	param_00 soundscripts\_snd_playsound::snd_play_linked("climb_fence_joker_05");
}

//Function Number: 110
climb_fence_joker_06(param_00)
{
	param_00 soundscripts\_snd_playsound::snd_play_linked("climb_fence_joker_06");
}

//Function Number: 111
climb_fence_joker_07(param_00)
{
	param_00 soundscripts\_snd_playsound::snd_play_linked("climb_fence_joker_07");
}

//Function Number: 112
climb_fence_joker_08(param_00)
{
	param_00 soundscripts\_snd_playsound::snd_play_linked("climb_fence_joker_08");
}

//Function Number: 113
climb_fence_joker_09(param_00)
{
	param_00 soundscripts\_snd_playsound::snd_play_linked("climb_fence_joker_09");
}

//Function Number: 114
climb_fence_joker_10(param_00)
{
	param_00 soundscripts\_snd_playsound::snd_play_linked("climb_fence_joker_10");
}

//Function Number: 115
climb_fence_torres_01(param_00)
{
	param_00 soundscripts\_snd_playsound::snd_play_linked("climb_fence_torres_01");
}

//Function Number: 116
climb_fence_torres_02(param_00)
{
	param_00 soundscripts\_snd_playsound::snd_play_linked("climb_fence_torres_02");
}

//Function Number: 117
climb_fence_torres_03(param_00)
{
	param_00 soundscripts\_snd_playsound::snd_play_linked("climb_fence_torres_03");
}

//Function Number: 118
climb_fence_torres_04(param_00)
{
	param_00 soundscripts\_snd_playsound::snd_play_linked("climb_fence_torres_04");
}

//Function Number: 119
climb_fence_torres_05(param_00)
{
	param_00 soundscripts\_snd_playsound::snd_play_linked("climb_fence_torres_05");
}

//Function Number: 120
climb_fence_torres_06(param_00)
{
	param_00 soundscripts\_snd_playsound::snd_play_linked("climb_fence_torres_06");
}

//Function Number: 121
climb_fence_torres_07(param_00)
{
	param_00 soundscripts\_snd_playsound::snd_play_linked("climb_fence_torres_07");
}

//Function Number: 122
climb_fence_torres_08(param_00)
{
	param_00 soundscripts\_snd_playsound::snd_play_linked("climb_fence_torres_08");
}

//Function Number: 123
climb_fence_torres_09(param_00)
{
	param_00 soundscripts\_snd_playsound::snd_play_linked("climb_fence_torres_09");
}

//Function Number: 124
climb_fence_torres_10(param_00)
{
	param_00 soundscripts\_snd_playsound::snd_play_linked("climb_fence_torres_10");
}

//Function Number: 125
begin_on_foot_segment()
{
	music("begin_on_foot_segment");
}

//Function Number: 126
weather_report(param_00)
{
	switch(param_00)
	{
		case "drizzle":
			break;

		case "med_rain":
			break;

		case "heavy_rain":
			break;

		case "heavy_speedy_rain":
			break;
	}
}

//Function Number: 127
lightning_strike()
{
	var_00 = self;
	wait(0.5);
	var_00 soundscripts\_snd_playsound::snd_play_linked("generic_lightning_strike");
	thread setup_wallpull();
}

//Function Number: 128
play_maglev_train_path()
{
	if(common_scripts\utility::flag("aud_maglev_train_path_disabled"))
	{
		return;
	}

	var_00 = self;
	var_01 = 1.5;
	var_02 = 4;
	var_03 = soundscripts\_snd_playsound::snd_play_loop_linked("maglev_train_lp",undefined,var_01,var_02);
	var_00 thread dopplerize_train(var_03);
	if(!isdefined(level.aud.maglev_by_school_sweetener_num))
	{
		level.aud.maglev_by_school_sweetener_num = 1;
	}

	var_04 = "maglev_by_school_swt" + level.aud.maglev_by_school_sweetener_num;
	level.aud.maglev_by_school_sweetener_num = level.aud.maglev_by_school_sweetener_num + 1;
	if(level.aud.maglev_by_school_sweetener_num > 3)
	{
		level.aud.maglev_by_school_sweetener_num = 1;
	}

	if(var_00 soundscripts\_snd_common::snd_waittill_within_radius(2800,0))
	{
		if(isdefined(var_00))
		{
			var_00 soundscripts\_snd_playsound::snd_play_delayed_linked("maglev_by_school_main",0,undefined,undefined,0,4);
			var_00 soundscripts\_snd_playsound::snd_play_delayed_linked(var_04,0.4,undefined,undefined,0,4);
		}
	}
}

//Function Number: 129
dopplerize_train(param_00)
{
	var_01 = self;
	var_02 = 0.05;
	var_03 = 1;
	var_04 = 1;
	while(isdefined(param_00) && isdefined(var_01))
	{
		var_05 = dopplerpitch(var_01.origin,var_01 maps\_shg_utility::get_differentiated_velocity(),level.player.origin,level.player maps\_shg_utility::get_differentiated_velocity(),var_03,var_04);
		param_00 scalepitch(var_05,var_02);
		wait(var_02);
		waittillframeend;
	}
}

//Function Number: 130
walk_to_school()
{
	music("walk_to_school");
}

//Function Number: 131
start_fuorescent_light_hum(param_00)
{
	var_01 = spawn("script_origin",param_00);
	var_01 soundscripts\_snd_playsound::snd_play_loop("school_fluorescent_hum");
	common_scripts\utility::flag_wait("aud_horror_fluorescent_break");
	var_01 scalevolume(0,0.25);
	wait(0.25);
	var_01 stopsounds();
	var_01 delete();
}

//Function Number: 132
monitor_fuorescent_light_dist(param_00)
{
	var_01 = 0.1;
	var_02 = distance2d(level.burke.origin,param_00);
	var_03 = [[36,0.4],[var_02,1]];
	var_04 = soundscripts\_audio::aud_get_ambi_submix();
	var_05 = soundscripts\_audio::aud_get_music_submix();
	var_06 = distance2d(level.player.origin,param_00);
	var_07 = 0;
	while(!common_scripts\utility::flag("aud_horror_fluorescent_break"))
	{
		var_06 = distance2d(level.burke.origin,param_00);
		var_08 = soundscripts\_snd::snd_map(var_06,var_03);
		soundscripts\_audio::aud_set_ambi_submix(var_04 * var_08,var_01);
		if(var_08 < var_07)
		{
			soundscripts\_audio::aud_set_music_submix(var_05 * var_08,var_01);
		}

		var_07 = var_08;
		wait(0.05);
	}

	soundscripts\_audio_music::mus_stop(1);
	wait(3);
	soundscripts\_audio::aud_set_ambi_submix(var_04,30);
}

//Function Number: 133
horror_fluorescent_break()
{
	soundscripts\_audio_mix_manager::mm_add_submix("det_bulb_break_gag");
	var_00 = self;
	var_00 soundscripts\_snd_playsound::snd_play_linked("school_fluorescent_break");
	common_scripts\utility::flag_set("aud_horror_fluorescent_break");
	var_00 waittill("sounddone");
	soundscripts\_audio_mix_manager::mm_add_submix("det_bulb_break_gag");
}

//Function Number: 134
horror_burke_gets_up_after_tile()
{
	music("horror_burke_gets_up_after_tile");
}

//Function Number: 135
horror_burk_opens_bodies_room_door()
{
	thread horror_burk_opens_bodies_room_door_sfx();
	thread horror_burk_opens_bodies_room_door_mus();
}

//Function Number: 136
horror_burk_opens_bodies_room_door_sfx()
{
	var_00 = (-1529,9494,-10);
	soundscripts\_snd_playsound::snd_play_delayed_at("enter_bodies_room_latch",var_00,2.8);
	soundscripts\_snd_playsound::snd_play_delayed_at("enter_bodies_room_door0",var_00,2.8);
	soundscripts\_snd_playsound::snd_play_delayed_at("enter_bodies_room_door1",var_00,5.4);
	soundscripts\_snd_playsound::snd_play_delayed_at("enter_bodies_room_door2",var_00,8.8);
	soundscripts\_snd_playsound::snd_play_delayed_at("enter_bodies_room_door_kick",var_00,8.8);
}

//Function Number: 137
horror_burk_opens_bodies_room_door_mus()
{
	var_00 = 8.75;
	var_01 = spawn("script_origin",(0,0,0));
	var_01 scalevolume(0,0);
	var_01 soundscripts\_snd_playsound::snd_play_loop("det_mus_horror_lp_02");
	var_01 scalevolume(0.75,var_00);
	wait(var_00);
	music("horror_burk_door_open_end");
	level notify("horror_burk_door_open_end");
	var_01 scalevolume(0,5);
	wait(5);
	var_01 stopsounds();
	var_01 delete();
}

//Function Number: 138
body_room_exit()
{
	soundscripts\_snd_playsound::snd_play_delayed_2d("exit_bodies_room_door",2);
	soundscripts\_snd_playsound::snd_play_delayed_2d("exit_bodies_room_door_debris",2.5);
	soundscripts\_snd_playsound::snd_play_delayed_2d("exit_bodies_room_bump",4.5);
	music("body_room_exit");
}

//Function Number: 139
finish_bodies_room_burke()
{
	music("finish_bodies_room_burke");
}

//Function Number: 140
horror_ghost_runs_by_door()
{
	wait(3);
	wait(8);
	music("post_horror_ghost_runs_by_door");
}

//Function Number: 141
school_upthestairs()
{
	music("school_upthestairs");
}

//Function Number: 142
burke_startle_stairs()
{
	soundscripts\_snd_playsound::snd_play_at("burke_startle_stairs",(-1049,9336,278));
}

//Function Number: 143
train_scare()
{
	var_00 = "stop_school_train_scare";
	var_01 = soundscripts\_snd_playsound::snd_play_2d("school_train_scare",var_00,5,6);
	var_01 soundscripts\_snd_playsound::snd_play_set_cleanup_msg("Train Scare");
	wait(7);
	level notify(var_00);
}

//Function Number: 144
school_lightning_strike()
{
	var_00 = self;
	var_00 soundscripts\_snd_playsound::snd_play_linked("generic_lightning_strike");
}

//Function Number: 145
setup_wallpull()
{
	var_00 = soundscripts\_audio_zone_manager::azm_get_current_zone();
	if(var_00 == "dtrt_int_school_floor_2" && !isdefined(level.aud.setup_wallpull))
	{
		level.aud.setup_wallpull = 1;
	}
	else
	{
		return;
	}

	var_01 = 4;
	var_02 = 0.1;
	var_03 = (-1778,8629,129);
	var_04 = [[36,0.01],[750,1]];
	var_05 = soundscripts\_audio::aud_get_music_submix();
	var_06 = soundscripts\_audio::aud_get_ambi_submix();
	var_07 = distance2d(level.player.origin,var_03);
	var_08 = soundscripts\_snd::snd_map(var_07,var_04);
	soundscripts\_audio::aud_set_music_submix(var_05 * var_08,var_01);
	soundscripts\_audio::aud_set_ambi_submix(var_06 * var_08,var_01);
	wait(var_01);
	while(!common_scripts\utility::flag("aud_wallpull_begin"))
	{
		var_07 = distance2d(level.player.origin,var_03);
		var_08 = soundscripts\_snd::snd_map(var_07,var_04);
		soundscripts\_audio::aud_set_music_submix(var_05 * var_08,var_02);
		soundscripts\_audio::aud_set_ambi_submix(var_06 * var_08,var_02);
		wait(0.05);
	}

	soundscripts\_audio::aud_set_ambi_submix(var_06,0);
}

//Function Number: 146
kva_knife_takedown_scene_begin()
{
	music("mus_pre_alley_combat");
}

//Function Number: 147
mus_alley_combat(param_00)
{
	music("mus_alley_combat");
	soundscripts\_audio_mix_manager::mm_add_submix("alley_combat_trains_down");
}

//Function Number: 148
temp_dog_bark(param_00)
{
	param_00 soundscripts\_snd_playsound::snd_play_linked("lag_dog_bark");
}

//Function Number: 149
office_reunion_dialogue()
{
	music("office_reunion_dialogue");
}

//Function Number: 150
player_shimmy_intro(param_00)
{
	soundscripts\_audio_mix_manager::mm_add_submix("det_school_shimmy");
	if(param_00 == "short_version")
	{
		soundscripts\_snd_playsound::snd_play_2d("det_school_shimmy_into_short");
		return;
	}

	if(param_00 == "long_version")
	{
		soundscripts\_snd_playsound::snd_play_2d("det_school_shimmy_into_long");
	}
}

//Function Number: 151
setup_school_shimmy_anims()
{
	if(level.currentgen && !issubstr(level.transient_zone,"_school"))
	{
		level waittill("tff_post_middle_add_school");
	}

	maps\_anim::addnotetrack_customfunction("school_blockage","burke_beam_bend",::burke_beam_bend,"burke_wall_walk");
	maps\_anim::addnotetrack_customfunction("burke","burke_shimmy_1",::burke_shimmy_1,"burke_wall_walk");
	maps\_anim::addnotetrack_customfunction("burke","burke_shimmy_2",::burke_shimmy_2,"burke_shimmey_wait_idle_out");
	maps\_anim::addnotetrack_customfunction("burke","burke_shimmy_2b",::burke_shimmy_2b,"burke_shimmey_wait_idle_out");
	maps\_anim::addnotetrack_customfunction("world_body","shimmy_2",::player_shimmy_2,"school_fall_shuffle_pt2");
	maps\_anim::addnotetrack_customfunction("world_body","shimmy_4",::player_shimmy_4,"school_fall_shuffle_pt4");
	maps\_anim::addnotetrack_customfunction("world_body","shimmy_1",::player_shimmy_1,"school_fall_shuffle_pt1");
	maps\_anim::addnotetrack_customfunction("world_body","shimmy_3",::player_shimmy_3,"school_fall_shuffle_pt3");
}

//Function Number: 152
burke_beam_bend(param_00)
{
	param_00 soundscripts\_snd_playsound::snd_play_linked("det_school_beam_bend");
	music("burke_beam_bend");
}

//Function Number: 153
burke_shimmy_1(param_00)
{
	param_00 soundscripts\_snd_playsound::snd_play_linked("det_school_shimmy_burke_1",undefined,undefined,undefined,undefined,(0,0,-10));
}

//Function Number: 154
burke_shimmy_2(param_00)
{
	param_00 soundscripts\_snd_playsound::snd_play_linked("det_school_shimmy_burke_2",undefined,undefined,undefined,undefined,(0,0,-10));
	soundscripts\_snd_playsound::snd_play_at("det_school_shimmy_burke_beam",(-1374,9388,83));
}

//Function Number: 155
burke_shimmy_2b(param_00)
{
	param_00 soundscripts\_snd_playsound::snd_play_linked("det_school_shimmy_burke_2b",undefined,undefined,undefined,undefined,(0,0,-10));
}

//Function Number: 156
player_shimmy_1(param_00)
{
	soundscripts\_snd_playsound::snd_play_2d("det_school_shimmy_1");
}

//Function Number: 157
player_shimmy_2(param_00)
{
	soundscripts\_snd_playsound::snd_play_2d("det_school_shimmy_2");
}

//Function Number: 158
player_shimmy_3(param_00)
{
	soundscripts\_snd_playsound::snd_play_2d("det_school_shimmy_3");
}

//Function Number: 159
player_shimmy_4(param_00)
{
	soundscripts\_snd_playsound::snd_play_2d("det_school_shimmy_4");
	soundscripts\_audio_mix_manager::mm_clear_submix("det_school_shimmy");
}

//Function Number: 160
school_fall()
{
	soundscripts\_audio_mix_manager::mm_add_submix("det_school_fall",2);
	soundscripts\_snd_playsound::snd_play_2d("det_school_fall");
}

//Function Number: 161
school_fall_into_basement()
{
	music("school_fall_into_basement");
	soundscripts\_snd_playsound::snd_play_2d("det_school_fall_into_basement");
	wait(2);
	soundscripts\_audio_mix_manager::mm_clear_submix("det_school_fall",3);
	wait(3);
	soundscripts\_audio_mix_manager::mm_add_submix("det_school_fs_override",0.5);
	level.aud.in_basement = 1;
	level.aud.in_school = 0;
}

//Function Number: 162
basement_investigate()
{
	var_00 = self;
	var_01 = (-970,9111,-143);
	soundscripts\_audio_mix_manager::mm_add_submix("det_steam_guy");
	var_00 soundscripts\_snd_playsound::snd_play_delayed_linked("basement_steam_guy_fs2",0);
	soundscripts\_snd_playsound::snd_play_delayed_at("basement_steam_guy_steam",var_01,0);
	wait(8.409);
	if(common_scripts\utility::flag("kill_the_valve_anim"))
	{
		soundscripts\_audio_mix_manager::mm_clear_submix("det_steam_guy");
		return;
	}

	soundscripts\_snd_playsound::snd_play_at("basement_steam_guy_valve1",var_01);
	wait(2.5);
	if(common_scripts\utility::flag("kill_the_valve_anim"))
	{
		soundscripts\_audio_mix_manager::mm_clear_submix("det_steam_guy");
		return;
	}

	soundscripts\_snd_playsound::snd_play_at("basement_steam_guy_valve2",var_01);
	wait(2);
	if(common_scripts\utility::flag("kill_the_valve_anim"))
	{
		soundscripts\_audio_mix_manager::mm_clear_submix("det_steam_guy");
		return;
	}

	if(isalive(var_00))
	{
		var_00 soundscripts\_snd_playsound::snd_play_linked("basement_steam_guy_fs3");
	}

	wait(20);
	if(!common_scripts\utility::flag("kill_the_valve_anim"))
	{
		soundscripts\_audio_mix_manager::mm_clear_submix("det_steam_guy");
	}
}

//Function Number: 163
kva_basement_idle_start()
{
	soundscripts\_snd::snd_println("kva_basement_idle_start");
}

//Function Number: 164
steam_burst_valve_started()
{
	soundscripts\_snd::snd_println("steam_burst_valve_started");
}

//Function Number: 165
setup_wall_pull_anims()
{
	if(level.currentgen && !issubstr(level.transient_zone,"_school"))
	{
		level waittill("tff_post_middle_add_school");
	}

	maps\_anim::addnotetrack_customfunction("world_body","grab_n_stab_foley1_grabs_vox1",::grab_n_stab_foley1_grabs_vox1,"wall_pull");
	maps\_anim::addnotetrack_customfunction("world_body","grab_n_stab_kick_impact_vox2",::grab_n_stab_kick_impact_vox2,"wall_pull");
	maps\_anim::addnotetrack_customfunction("world_body","grab_n_stab_brick_snap",::grab_n_stab_brick_snap,"wall_pull");
	maps\_anim::addnotetrack_customfunction("world_body","grab_n_stab_brick_impact_with_lfe_glass",::grab_n_stab_brick_impact_with_lfe_glass,"wall_pull");
	maps\_anim::addnotetrack_customfunction("world_body","grab_n_stab_vox3",::grab_n_stab_vox3,"wall_pull");
	maps\_anim::addnotetrack_customfunction("world_body","grab_n_stab_body_fall_with_lfe",::grab_n_stab_body_fall_with_lfe,"wall_pull");
	maps\_anim::addnotetrack_customfunction("world_body","grab_n_stab_knife1",::grab_n_stab_knife1,"wall_pull");
	maps\_anim::addnotetrack_customfunction("world_body","grab_n_stab_foley2",::grab_n_stab_foley2,"wall_pull");
	maps\_anim::addnotetrack_customfunction("world_body","grab_n_stab_knife2",::grab_n_stab_knife2,"wall_pull");
	maps\_anim::addnotetrack_customfunction("world_body","grab_n_stab_knife3",::grab_n_stab_knife3,"wall_pull");
	maps\_anim::addnotetrack_customfunction("world_body","grab_n_stab_knife4",::grab_n_stab_knife4,"wall_pull");
	maps\_anim::addnotetrack_customfunction("world_body","grab_n_stab_knife5",::grab_n_stab_knife5,"wall_pull");
}

//Function Number: 166
grab_n_stab_foley1_grabs_vox1(param_00)
{
	common_scripts\utility::flag_set("aud_wallpull_begin");
	soundscripts\_snd_playsound::snd_play_2d("grab_n_stab_foley1");
	soundscripts\_snd_playsound::snd_play_2d("grab_n_stab_grabs");
	soundscripts\_snd_playsound::snd_play_2d("grab_n_stab_vox1");
}

//Function Number: 167
grab_n_stab_kick_impact_vox2(param_00)
{
	soundscripts\_snd_playsound::snd_play_2d("grab_n_stab_kick_impact");
	soundscripts\_snd_playsound::snd_play_2d("grab_n_stab_vox2");
}

//Function Number: 168
grab_n_stab_brick_snap(param_00)
{
	soundscripts\_snd_playsound::snd_play_2d("grab_n_stab_brick_snap");
}

//Function Number: 169
grab_n_stab_brick_impact_with_lfe_glass(param_00)
{
	soundscripts\_snd_playsound::snd_play_2d("grab_n_stab_brick_impact");
	soundscripts\_snd_playsound::snd_play_2d("grab_n_stab_brick_impact_lfe");
	soundscripts\_snd_playsound::snd_play_2d("grab_n_stab_glass");
}

//Function Number: 170
grab_n_stab_vox3(param_00)
{
	soundscripts\_snd_playsound::snd_play_2d("grab_n_stab_vox3");
}

//Function Number: 171
grab_n_stab_body_fall_with_lfe(param_00)
{
	soundscripts\_snd_playsound::snd_play_2d("grab_n_stab_body_fall");
	soundscripts\_snd_playsound::snd_play_2d("grab_n_stab_body_fall_lfe");
}

//Function Number: 172
grab_n_stab_knife1(param_00)
{
	soundscripts\_snd_playsound::snd_play_2d("grab_n_stab_knife1");
}

//Function Number: 173
grab_n_stab_foley2(param_00)
{
	soundscripts\_snd_playsound::snd_play_2d("grab_n_stab_foley2");
}

//Function Number: 174
grab_n_stab_knife2(param_00)
{
	soundscripts\_snd_playsound::snd_play_2d("grab_n_stab_knife2");
}

//Function Number: 175
grab_n_stab_knife3(param_00)
{
	soundscripts\_snd_playsound::snd_play_2d("grab_n_stab_knife3");
}

//Function Number: 176
grab_n_stab_knife4(param_00)
{
	soundscripts\_snd_playsound::snd_play_2d("grab_n_stab_knife4");
}

//Function Number: 177
grab_n_stab_knife5(param_00)
{
	soundscripts\_snd_playsound::snd_play_2d("grab_n_stab_knife5");
}

//Function Number: 178
setup_hospital_post_breach_anims()
{
	if(level.currentgen && !issubstr(level.transient_zone,"_hospital"))
	{
		level waittill("tff_post_middle_add_hospital");
	}

	maps\_anim::addnotetrack_customfunction("doctor","hospital_post_breach_01",::hospital_post_breach_01,"doctor_capture");
	maps\_anim::addnotetrack_customfunction("doctor","hospital_post_breach_02",::hospital_post_breach_02,"doctor_capture");
	maps\_anim::addnotetrack_customfunction("doctor","hospital_post_breach_03",::hospital_post_breach_03,"doctor_capture");
	maps\_anim::addnotetrack_customfunction("doctor","hospital_post_breach_04",::hospital_post_breach_04,"doctor_capture");
	maps\_anim::addnotetrack_customfunction("doctor","hospital_post_breach_05",::hospital_post_breach_05,"doctor_capture");
	maps\_anim::addnotetrack_customfunction("doctor","det_doc_roll_over",::det_doc_roll_over,"carry_doc_lift");
	maps\_anim::addnotetrack_customfunction("doctor","det_doc_picked_up",::det_doc_picked_up,"carry_doc_lift");
}

//Function Number: 179
hospital_post_breach_01(param_00)
{
	soundscripts\_audio_mix_manager::mm_add_submix("det_post_hospital_breach");
	det_stop_doctor_breathing();
	soundscripts\_snd_playsound::snd_play_2d("wpn_med_holster_plr");
	soundscripts\_snd_playsound::snd_play_2d("det_post_breach_01");
}

//Function Number: 180
hospital_post_breach_02(param_00)
{
	wait(0.1);
	soundscripts\_snd_playsound::snd_play_2d("det_post_breach_02");
	soundscripts\_snd_playsound::snd_play_2d("det_post_breach_02_punch");
	soundscripts\_snd_playsound::snd_play_2d("det_post_breach_02_punch_lfe");
}

//Function Number: 181
hospital_post_breach_03(param_00)
{
	wait(0.1);
	soundscripts\_snd_playsound::snd_play_2d("det_post_breach_03");
}

//Function Number: 182
hospital_post_breach_04(param_00)
{
	wait(0.1);
	soundscripts\_snd_playsound::snd_play_2d("det_post_breach_04");
}

//Function Number: 183
hospital_post_breach_05(param_00)
{
	wait(0.1);
	soundscripts\_snd_playsound::snd_play_2d("det_post_breach_05");
}

//Function Number: 184
det_doc_roll_over(param_00)
{
	param_00 soundscripts\_snd_playsound::snd_play_linked("det_post_breach_doctor_roll");
}

//Function Number: 185
det_doc_picked_up(param_00)
{
	param_00 soundscripts\_snd_playsound::snd_play_linked("det_post_breach_doctor_pickup");
	wait(2);
	soundscripts\_audio_mix_manager::mm_clear_submix("det_post_hospital_breach",1);
}

//Function Number: 186
wall_pull_animation_begin()
{
	soundscripts\_audio_mix_manager::mm_add_submix("det_wallpull",0.5);
	soundscripts\_snd_timescale::snd_set_timescale("wall_pull");
	music("wallpull");
	wait(20);
	soundscripts\_audio_mix_manager::mm_clear_submix("det_wallpull",3);
	soundscripts\_snd_timescale::snd_set_timescale("detroit_default");
}

//Function Number: 187
wall_pull_slowmo(param_00)
{
	if(param_00 == "begin")
	{
		soundscripts\_audio_mix_manager::mm_add_submix("det_wallpull_slowmo",1);
		soundscripts\_snd_playsound::snd_play_2d("wallpull_slowmo_in");
		soundscripts\_snd_playsound::snd_play_2d("wallpull_slowmo_body","wallpull_slomo_stop_notify",0,0.5,0.6);
		return;
	}

	if(param_00 == "end")
	{
		level notify("wallpull_slomo_stop_notify");
		soundscripts\_audio_mix_manager::mm_clear_submix("det_wallpull_slowmo",1);
		soundscripts\_snd_playsound::snd_play_2d("wallpull_slowmo_out");
		common_scripts\utility::flag_set("aud_wallpull_success");
		return;
	}

	if(param_00 == "fail")
	{
		soundscripts\_audio_mix_manager::mm_add_submix("mute_all",3);
		return;
	}
}

//Function Number: 188
detroit_kva_bauerdoyoureadme()
{
	soundscripts\_snd_playsound::snd_play_at("detroit_kva_bauerdoyoureadme",(-1784,8758,83));
}

//Function Number: 189
hospital_breach_gun_away()
{
	soundscripts\_snd_playsound::snd_play_2d("det_breach_gun_away");
}

//Function Number: 190
hostpital_breach_start()
{
	soundscripts\_snd_timescale::snd_set_timescale("detroit_breach");
	level.player enablecustomweaponcontext();
	enablesoundcontextoverride("slomo");
	soundscripts\_snd_playsound::snd_play_2d("det_breach_door");
	wait(1);
	soundscripts\_audio_mix_manager::mm_add_submix("det_hospital_breach",1);
	soundscripts\_snd_playsound::snd_play_loop_2d("overdrive_loop","kill_breach_loop");
}

//Function Number: 191
breach_slo_mo_exit()
{
	soundscripts\_snd_playsound::snd_play_2d("slo_mo_exit");
	soundscripts\_snd_timescale::snd_set_timescale("detroit_default");
	disablesoundcontextoverride("slomo");
	level.player disablecustomweaponcontext();
	level notify("kill_breach_loop");
	soundscripts\_audio_mix_manager::mm_clear_submix("det_hospital_breach",2);
}

//Function Number: 192
push_dude_into_shelves()
{
	soundscripts\_snd_playsound::snd_play_2d("det_breach_punch_dude");
}

//Function Number: 193
breach_bad_guy2_gets_shot()
{
	soundscripts\_snd_playsound::snd_play_linked("det_breach_shoot_dude");
}

//Function Number: 194
shoot_dude_through_window()
{
	soundscripts\_snd_playsound::snd_play_delayed_linked("det_breach_window_dude",0.1);
}

//Function Number: 195
capture_doctor_scene_start()
{
}

//Function Number: 196
office_skylights_breakable(param_00)
{
	var_01 = param_00.origin;
	thread soundscripts\_snd_playsound::snd_play_at("office_skylight_break",var_01);
	var_02 = bullettrace(var_01,var_01 + (0,0,-10000),0);
	var_03 = var_02["position"];
	wait(0.2);
	thread soundscripts\_snd_playsound::snd_play_at("office_skylight_debris",var_03);
	wait(0.2);
	thread soundscripts\_snd_playsound::snd_play_at("office_skylight_debris_shatters",var_03);
}

//Function Number: 197
begin_exo_push()
{
	changewhizbyautosimparams(0,0,0,0,-4,2);
	soundscripts\_audio_mix_manager::mm_add_submix("det_ambulance_push");
	thread end_exo_push();
}

//Function Number: 198
ambulance_push_attach(param_00)
{
	thread soundscripts\_snd_playsound::snd_play_2d("det_amb_push_attach");
	soundscripts\_snd_playsound::snd_play_delayed_2d("pc_exo_strength_hi",0.5);
}

//Function Number: 199
amb_push_oneshots()
{
	level endon("aud_amb_push_stopped");
	level waittill("aud_amb_push_active");
	for(;;)
	{
		var_00 = randomintrange(1,3);
		wait(var_00);
		thread soundscripts\_snd_playsound::snd_play_2d("det_amb_push_random_oneshot");
	}
}

//Function Number: 200
ambulance_push_active()
{
	var_00 = self;
	if(level.aud.amb_pushing == 0)
	{
		level.player soundscripts\_snd_playsound::snd_play_2d("det_amb_push_start");
		thread amb_push_oneshots();
		soundscripts\_snd_common::snd_enable_soundcontextoverride("bullet_metal_vehicle");
	}

	level.aud.amb_pushing = 1;
	level notify("aud_amb_push_active");
	var_00 scalevolume(1,0.1);
	var_00 playloopsound("det_amb_push_body_lp");
}

//Function Number: 201
ambulance_push_step_away()
{
	var_00 = self;
	var_00 scalevolume(0,0.4);
	thread soundscripts\_snd_playsound::snd_play_2d("det_amb_push_detach");
	level.aud.amb_pushing = 0;
	level notify("aud_amb_push_stopped");
	wait(0.5);
	var_00 stopsounds();
	var_00 stoploopsound();
	soundscripts\_snd_common::snd_disable_soundcontextoverride("bullet_metal_vehicle");
}

//Function Number: 202
ambulance_push_idle()
{
	var_00 = self;
	if(level.aud.amb_pushing == 1)
	{
		level.player soundscripts\_snd_playsound::snd_play_2d("det_amb_push_stop");
	}

	var_00 scalevolume(0,0.4);
	level.aud.amb_pushing = 0;
	level notify("aud_amb_push_stopped");
}

//Function Number: 203
ambulance_push_sequence_end()
{
	var_00 = self;
	thread soundscripts\_snd_playsound::snd_play_2d("det_amb_push_end");
	var_00 scalevolume(0,0.2);
	level.aud.amb_pushing = 0;
	level notify("aud_amb_push_stopped");
	wait(0.2);
	var_00 stoploopsound();
}

//Function Number: 204
end_exo_push()
{
	common_scripts\utility::flag_wait("exo_push_arrived");
	changewhizbyautosimparams(0,0,0,0,1,1);
	soundscripts\_audio_mix_manager::mm_clear_submix("det_ambulance_push");
}

//Function Number: 205
hospital_flashbang1(param_00,param_01)
{
	wait(param_00);
	soundscripts\_snd_playsound::snd_play_at("det_hopital_flash_bang",param_01);
	soundscripts\_snd::snd_slate("hospital_flashbang1");
}

//Function Number: 206
hospital_flashbang2(param_00,param_01)
{
	wait(param_00);
	soundscripts\_snd_playsound::snd_play_at("det_hopital_flash_bang",param_01);
	soundscripts\_snd::snd_slate("hospital_flashbang2");
}

//Function Number: 207
hospital_flashbang3(param_00,param_01)
{
	wait(param_00);
	soundscripts\_snd_playsound::snd_play_at("det_hopital_flash_bang",param_01);
	soundscripts\_snd::snd_slate("hospital_flashbang3");
}

//Function Number: 208
det_hospital_gate_close()
{
	var_00 = self;
	var_00 soundscripts\_snd_playsound::snd_play_linked("det_hospital_gate");
}

//Function Number: 209
det_start_doctor_breathing(param_00)
{
	param_00 soundscripts\_snd_playsound::snd_play_loop_linked("detroit_dcr_breathing","det_doctor_stop_breathing");
}

//Function Number: 210
det_stop_doctor_breathing()
{
	level notify("det_doctor_stop_breathing");
}

//Function Number: 211
reveal_scene_start()
{
	var_00 = getent("animated_bouncing_betty","targetname");
	soundscripts\_snd_timescale::snd_set_timescale("sent_reveal");
	soundscripts\_audio_mix_manager::mm_add_submix("det_sentinel_reveal",0.05);
	var_00 soundscripts\_snd_playsound::snd_play_linked("det_sent_rev_betty_arm");
}

//Function Number: 212
reveal_explosion()
{
	music("det_sent_rev_explo");
	soundscripts\_snd_playsound::snd_play_2d("det_sent_rev_explo");
	soundscripts\_snd_playsound::snd_play_delayed_2d("det_sent_rev_gunfire",6.8,1);
	soundscripts\_snd_playsound::snd_play_delayed_2d("det_sent_rev_bullet_hits",6.8,1);
}

//Function Number: 213
setup_sentinel_reveal_anims()
{
	if(level.currentgen && !issubstr(level.transient_zone,"_hospital"))
	{
		level waittill("tff_post_middle_add_hospital");
	}

	maps\_anim::addnotetrack_customfunction("kva1","kva_guy1_footsteps",::kva_guy1_footsteps,"sentinel_kva_reveal");
	maps\_anim::addnotetrack_customfunction("kva1","kva_guy1_gets_shot",::kva_guy1_gets_shot,"sentinel_kva_reveal");
	maps\_anim::addnotetrack_customfunction("kva2","kva_guy2_footsteps",::kva_guy2_footsteps,"sentinel_kva_reveal");
	maps\_anim::addnotetrack_customfunction("kva2","kva_guy2_gets_shot",::kva_guy2_gets_shot,"sentinel_kva_reveal");
	maps\_anim::addnotetrack_customfunction("kva3","kva_guy3_footsteps",::kva_guy3_footsteps,"sentinel_kva_reveal");
	maps\_anim::addnotetrack_customfunction("kva3","kva_guy3_gets_shot",::kva_guy3_gets_shot,"sentinel_kva_reveal");
	maps\_anim::addnotetrack_customfunction("guy1","sent_guy_1_footsteps",::sent_guy_1_footsteps,"sentinel_kva_reveal");
	maps\_anim::addnotetrack_customfunction("guy1","sent_guy1_out_of_slo_mo_foley",::sent_guy_1_footsteps_part2,"sentinel_kva_reveal");
	maps\_anim::addnotetrack_customfunction("guy1","sent_guy1_footsteps2",::sent_guy_1_footsteps_part3,"sentinel_kva_reveal");
	maps\_anim::addnotetrack_customfunction("guy2","sent_guy2_footsteps",::sent_guy_2_footsteps,"sentinel_kva_reveal");
	maps\_anim::addnotetrack_customfunction("guy3","sent_guy3_footsteps",::sent_guy_3_footsteps,"sentinel_kva_reveal");
	maps\_anim::addnotetrack_customfunction("guy1","sent_guy1_mask_up",::sent_guy1_mask_up,"sentinel_kva_reveal");
	maps\_anim::addnotetrack_customfunction("guy1","sent_guy1_mask_down",::sent_guy1_mask_down,"sentinel_kva_reveal");
	maps\_anim::addnotetrack_customfunction("guy1","sent_guy1_cloak",::sent_guy1_cloak,"sentinel_kva_reveal");
	maps\_anim::addnotetrack_customfunction("burke","burke_knocked_to_ground",::burke_knocked_to_ground,"sentinel_kva_reveal");
	maps\_anim::addnotetrack_customfunction("burke","burke_gets_up",::burke_gets_up,"sentinel_kva_reveal");
	maps\_anim::addnotetrack_customfunction("burke","burke_feet01",::burke_feet01,"sentinel_kva_reveal");
	maps\_anim::addnotetrack_customfunction("burke","burke_alert",::burke_alert,"sentinel_kva_reveal");
	maps\_anim::addnotetrack_customfunction("burke","burke_exit",::burke_exit,"sentinel_kva_reveal");
}

//Function Number: 214
kva_guy1_footsteps(param_00)
{
	param_00 soundscripts\_snd_playsound::snd_play_linked("det_sent_rev_badguy01_feet");
}

//Function Number: 215
kva_guy1_gets_shot(param_00)
{
	soundscripts\_snd_playsound::snd_play_2d("det_sent_rev_badguy01_shot");
}

//Function Number: 216
kva_guy2_footsteps(param_00)
{
	param_00 soundscripts\_snd_playsound::snd_play_linked("det_sent_rev_badguy02_feet");
}

//Function Number: 217
kva_guy2_gets_shot(param_00)
{
	soundscripts\_snd_playsound::snd_play_2d("det_sent_rev_badguy02_shot");
}

//Function Number: 218
kva_guy3_footsteps(param_00)
{
	param_00 soundscripts\_snd_playsound::snd_play_linked("det_sent_rev_badguy03_feet");
}

//Function Number: 219
kva_guy3_gets_shot(param_00)
{
	soundscripts\_snd_playsound::snd_play_2d("det_sent_rev_badguy03_shot");
}

//Function Number: 220
sent_guy_1_footsteps(param_00)
{
	param_00 soundscripts\_snd_playsound::snd_play_linked("det_sent_rev_goodguy01_feet1");
}

//Function Number: 221
sent_guy_1_footsteps_part2(param_00)
{
	param_00 soundscripts\_snd_playsound::snd_play_linked("det_sent_rev_goodguy01_feet2");
}

//Function Number: 222
sent_guy_1_footsteps_part3(param_00)
{
	param_00 soundscripts\_snd_playsound::snd_play_linked("det_sent_rev_goodguy01_feet3");
}

//Function Number: 223
sent_guy_2_footsteps(param_00)
{
	param_00 soundscripts\_snd_playsound::snd_play_linked("det_sent_rev_goodguy02_feet");
}

//Function Number: 224
sent_guy_3_footsteps(param_00)
{
	param_00 soundscripts\_snd_playsound::snd_play_linked("det_sent_rev_goodguy03_feet");
}

//Function Number: 225
sent_guy_2_decloak()
{
	soundscripts\_snd_playsound::snd_play_linked("det_sent_rev_goodguy02_uncloak");
	if(level.currentgen)
	{
		soundscripts\_audio_mix_manager::mm_clear_submix("det_sentinel_reveal",5);
	}
}

//Function Number: 226
sent_guy_3_decloak()
{
	soundscripts\_audio_mix_manager::mm_clear_submix("det_sentinel_reveal",5);
	soundscripts\_snd_playsound::snd_play_linked("det_sent_rev_goodguy03_uncloak");
}

//Function Number: 227
det_knx_thatsclassifiedmate()
{
	soundscripts\_audio_mix_manager::mm_add_submix("det_post_sentinel_reveal",0.1);
}

//Function Number: 228
sentinel_reveal_final_vo()
{
	music("mus_pre_exit_drive");
}

//Function Number: 229
sent_guy_1_decloak()
{
	soundscripts\_snd_playsound::snd_play_linked("det_sent_rev_goodguy01_uncloak");
	soundscripts\_snd_timescale::snd_set_timescale("detroit_default");
}

//Function Number: 230
sent_guy1_mask_up(param_00)
{
	param_00 soundscripts\_snd_playsound::snd_play_linked("det_sent_rev_goodguy01_mask_open");
}

//Function Number: 231
sent_guy1_mask_down(param_00)
{
	param_00 soundscripts\_snd_playsound::snd_play_linked("det_sent_rev_goodguy01_mask_close");
	surprise_attack();
}

//Function Number: 232
sent_guy1_cloak(param_00)
{
	param_00 soundscripts\_snd_playsound::snd_play_linked("det_sent_rev_goodguy01_cloak");
}

//Function Number: 233
burke_knocked_to_ground(param_00)
{
	param_00 soundscripts\_snd_playsound::snd_play_linked("det_sent_rev_burke_fall");
}

//Function Number: 234
burke_gets_up(param_00)
{
	param_00 soundscripts\_snd_playsound::snd_play_linked("det_sent_rev_burke_get_up");
}

//Function Number: 235
burke_feet01(param_00)
{
	param_00 soundscripts\_snd_playsound::snd_play_linked("det_sent_rev_burke_limp");
}

//Function Number: 236
burke_alert(param_00)
{
	param_00 soundscripts\_snd_playsound::snd_play_linked("det_sent_rev_burke_alert");
}

//Function Number: 237
burke_exit(param_00)
{
	param_00 soundscripts\_snd_playsound::snd_play_linked("det_sent_rev_burke_exit");
}

//Function Number: 238
surprise_attack()
{
	soundscripts\_snd_playsound::snd_play_2d("det_sent_rev_surprise_attack");
}

//Function Number: 239
aud_impact_system_jetbike(param_00)
{
	var_01 = [];
	var_01["Debug"] = 0;
	var_01["VehicleID"] = "jbike_impact";
	var_01["PV_MinVelocityThreshold"] = 125;
	var_01["PV_MaxVelocity"] = 800;
	var_01["PV_NumVelocityRanges"] = 3;
	var_01["PV_MaxSmlVelocity"] = 200;
	var_01["PV_MaxMedVelocity"] = 375;
	var_01["PV_MaxLrgVelocity"] = 800;
	var_01["NPC_MinVelocityThreshold"] = 25;
	var_01["NPC_MaxVelocity"] = 800;
	var_01["NPC_NumVelocityRanges"] = 3;
	var_01["NPC_MaxSmlVelocity"] = 100;
	var_01["NPC_MaxMedVelocity"] = 400;
	var_01["NPC_MaxLrgVelocity"] = 800;
	var_01["MinLFEVolumeThreshold"] = 0;
	var_01["FallVelMultiplier"] = 2;
	var_01["MinTimeThreshold"] = 350;
	var_01["ScrapeEnabled"] = 0;
	var_01["ScrapeSeperationTime"] = 0.5;
	var_01["ScrapeFadeOutTime"] = 0.5;
	var_01["ScrapeUpdateRate"] = 0.05;
	var_01["TireSkidProbability"] = 0;
	var_01["MaxDistanceThreshold"] = 6000;
	var_01["MedVolMin"] = 0.7;
	var_01["LrgVolMin"] = 1;
	var_01["NonPlayerImpVolReduction"] = 0;
	soundscripts\_snd_common::snd_play_vehicle_collision(param_00,var_01);
}

//Function Number: 240
setup_exit_ride_anims()
{
	if(level.currentgen && !issubstr(level.transient_zone,"middle"))
	{
		level waittill("tff_post_intro_to_middle");
	}

	maps\_anim::addnotetrack_customfunction("burke","aud_exitride_burke_start",::exit_ride_burke_start,"det_exit_drive_starting_anim_1");
	maps\_anim::addnotetrack_customfunction("burke","aud_exitride_burke_door_open",::exit_ride_burke_door_open,"det_exit_drive_starting_anim_1");
	maps\_anim::addnotetrack_customfunction("burke","aud_exitride_burke_mount",::exit_ride_burke_mount,"det_exit_drive_starting_anim_1");
	maps\_anim::addnotetrack_customfunction("burke","aud_exitride_burke_away",::exit_ride_burke_away,"det_exit_drive_starting_anim_2");
	maps\_anim::addnotetrack_customfunction("joker","aud_exitride_joker_start",::exit_ride_joker_start,"det_exit_drive_starting_anim_2");
}

//Function Number: 241
exit_ride_burke_start(param_00)
{
	param_00 soundscripts\_snd_playsound::snd_play_linked("exit_ride_burke_feet",undefined,undefined,undefined,undefined,(0,0,-10));
	soundscripts\_audio_mix_manager::mm_clear_submix("det_post_sentinel_reveal",3);
}

//Function Number: 242
exit_ride_burke_door_open(param_00)
{
	param_00 soundscripts\_snd_playsound::snd_play_linked("exit_ride_burke_door");
}

//Function Number: 243
exit_ride_burke_mount(param_00)
{
	param_00 soundscripts\_snd_playsound::snd_play_linked("exit_ride_burke_mount");
}

//Function Number: 244
exit_ride_burke_away(param_00)
{
	param_00 soundscripts\_snd_playsound::snd_play_linked("exit_ride_burke_away");
}

//Function Number: 245
exit_ride_joker_start(param_00)
{
	param_00 soundscripts\_snd_playsound::snd_play_linked("exit_ride_joker_feet",undefined,undefined,undefined,undefined,(0,0,-10));
}

//Function Number: 246
exit_ride_jetbike_mount_player()
{
	soundscripts\_audio_mix_manager::mm_add_submix("det_exit_ride_intro");
	soundscripts\_snd_playsound::snd_play_2d("exit_ride_player_foley");
	wait(6);
	soundscripts\_snd_playsound::snd_play_2d("exit_ride_player_ignition");
	wait(4);
	soundscripts\_audio_mix_manager::mm_clear_submix("det_exit_ride_intro",2);
	soundscripts\_audio_mix_manager::mm_add_submix("det_exit_ride_jetbikes",1);
}

//Function Number: 247
gaz_store_shootout_drive(param_00)
{
	var_01 = self;
	var_01 soundscripts\_snd_playsound::snd_play_linked("det_gaz_strafe_driveby_01");
}

//Function Number: 248
warehouse_chase_vehicle_02()
{
	var_00 = self;
	var_00 soundscripts\_snd_playsound::snd_play_linked("det_gaz_strafe_driveby_01");
}

//Function Number: 249
warehouse_chase_vehicle_03()
{
	var_00 = self;
	var_00 soundscripts\_snd_playsound::snd_play_linked("det_gaz_strafe_driveby_02");
}

//Function Number: 250
warehouse_chase_vehicle_04()
{
	var_00 = self;
}

//Function Number: 251
warehouse_car_shots(param_00)
{
	var_01 = self;
	var_01 endon("death");
	var_02 = 0.05;
	var_01 soundscripts\_snd_playsound::snd_play_loop_linked("wpn_wraith_turret_npc_lp",param_00);
	var_03 = spawn("script_origin",level.jetbike maps\_shg_design_tools::offset_position_from_tag("forward","tag_origin",500));
	var_04 = var_03 soundscripts\_snd_playsound::snd_play_loop_linked("det_gaz_strafe_bullets_lp",param_00);
	var_05 = var_03 soundscripts\_snd_playsound::snd_play_loop_linked("det_gaz_strafe_bullets_metal_lp",param_00);
	thread warehouse_one_shots_glass(param_00);
	thread warehouse_one_shots_rock(param_00);
	while(isdefined(var_01))
	{
		var_06 = distance(var_01.origin,level.player.origin);
		var_07 = soundscripts\_snd::snd_map(var_06,level.aud.envs["gaz_strafe_whizybys"]);
		var_08 = level.jetbike maps\_shg_design_tools::offset_position_from_tag("forward","tag_origin",500);
		var_03 moveto(var_08,var_02);
		if(isdefined(var_04))
		{
			var_04 scalevolume(var_07,var_02);
		}

		if(isdefined(var_05))
		{
			var_05 scalevolume(var_07,var_02);
		}

		wait(var_02);
	}

	var_03 delete();
}

//Function Number: 252
warehouse_one_shots_glass(param_00)
{
	level endon(param_00);
	for(;;)
	{
		var_01 = randomintrange(1,2);
		wait(var_01);
		level.player thread soundscripts\_snd_playsound::snd_play_linked("det_gaz_strafe_random_shots_glass");
		wait(0.05);
	}
}

//Function Number: 253
warehouse_one_shots_rock(param_00)
{
	level endon(param_00);
	for(;;)
	{
		var_01 = randomintrange(2,5);
		level.player thread soundscripts\_snd_playsound::snd_play_linked("det_gaz_strafe_random_shots_rock");
		wait(var_01);
	}
}

//Function Number: 254
exit_drive_rpgs()
{
	var_00 = self;
	var_00 soundscripts\_snd_playsound::snd_play_loop_linked("det_rpg_attack_lp");
	var_00 thread exit_drive_rpgs_flyby();
	var_00 waittill("explode");
	if(isdefined(var_00))
	{
		thread soundscripts\_snd_playsound::snd_play_at("det_rpg_attack_exp",self.origin);
		thread soundscripts\_snd_playsound::snd_play_at("det_rpg_attack_debris",self.origin);
	}
}

//Function Number: 255
exit_drive_rpgs_flyby()
{
	var_00 = self;
	var_01 = 900;
	while(isdefined(var_00))
	{
		var_02 = distance(var_00.origin,level.player.origin);
		if(var_02 < var_01)
		{
			var_00 soundscripts\_snd_playsound::snd_play_linked("det_rpg_attack_flyby");
			break;
		}

		wait(0.05);
	}
}

//Function Number: 256
exitdrive_chopper_initial()
{
}

//Function Number: 257
exitdrive_chopper_initial_gopath()
{
	soundscripts\_audio_mix_manager::mm_add_submix("det_exit_ride_littlebirds",1);
	var_00 = self;
	var_00 vehicle_turnengineoff();
	var_00 soundscripts\_snd_playsound::snd_play_linked("det_littlebird_exitride_first");
}

//Function Number: 258
exitdrive_chopper_tracks_1()
{
	var_00 = "LB-track:  ";
	var_01 = "littlebird_flyby";
	var_02 = [];
	var_02[0] = 3100;
	var_03 = [];
	var_03[0] = 75;
	thread soundscripts\_snd_common::snd_advanced_flyby_system(var_01,undefined,var_02,var_03,1);
}

//Function Number: 259
exitdrive_chopper_tracks_1_gopath()
{
	var_00 = self;
	var_00 soundscripts\_snd_playsound::snd_play_linked("littlebird_med_incoming",undefined,undefined,0.6);
}

//Function Number: 260
gaz_water_crash_01()
{
	var_00 = self;
	var_00 soundscripts\_snd_playsound::snd_play_linked("det_gaz_strafe_driveby_02","aud_gaz_water_crashed");
}

//Function Number: 261
gaz_water_crash_02()
{
	var_00 = self;
	var_00 soundscripts\_snd_playsound::snd_play_linked("det_gaz_strafe_driveby_01","aud_gaz_water_crashed");
}

//Function Number: 262
gaz_water_crashed(param_00)
{
	var_01 = self;
	var_01 soundscripts\_snd_playsound::snd_play_linked("det_gaz_watercrash");
	wait(0.1);
	param_00 soundscripts\_snd_playsound::snd_play_linked("det_gaz_watercrash");
	level notify("aud_gaz_water_crashed");
}

//Function Number: 263
exitdrive_chopper_final()
{
}

//Function Number: 264
exitdrive_chopper_final_gopath()
{
	var_00 = self;
	var_00 vehicle_turnengineoff();
	var_00 soundscripts\_snd_playsound::snd_play_linked("det_littlebird_exitride_last");
	wait(25);
	soundscripts\_audio_mix_manager::mm_clear_submix("det_exit_ride_littlebirds",3);
}

//Function Number: 265
collapsing_buttress_missile()
{
	var_00 = self;
	var_00 soundscripts\_snd_playsound::snd_play_loop_linked("det_rpg_attack_lp");
	var_00 thread collapsing_buttress_missile_flyby();
	var_00 waittill("explode");
	if(isdefined(var_00))
	{
		thread soundscripts\_snd_playsound::snd_play_at("det_rpg_attack_exp",self.origin);
		thread soundscripts\_snd_playsound::snd_play_at("det_rpg_attack_debris",self.origin);
	}
}

//Function Number: 266
collapsing_buttress_missile_flyby()
{
	var_00 = self;
	var_01 = 900;
	while(isdefined(var_00))
	{
		var_02 = distance(var_00.origin,level.player.origin);
		if(var_02 < var_01)
		{
			var_00 soundscripts\_snd_playsound::snd_play_linked("det_rpg_attack_flyby");
			break;
		}

		wait(0.05);
	}
}

//Function Number: 267
collapsing_buttress_01()
{
	var_00 = (-7808,15430,-2);
	thread soundscripts\_snd_playsound::snd_play_at("det_buttress_collapse_impact",var_00);
}

//Function Number: 268
collapsing_buttress_02()
{
	var_00 = (-7822,14051,-11);
	thread soundscripts\_snd_playsound::snd_play_at("det_buttress_collapse_impact_02",var_00);
}

//Function Number: 269
collapsing_buttress_03()
{
	var_00 = (-7841,12406,-11);
	thread soundscripts\_snd_playsound::snd_play_at("det_buttress_collapse_impact",var_00);
}

//Function Number: 270
exit_train_by(param_00)
{
	var_01 = self;
	common_scripts\utility::flag_set("aud_maglev_train_path_disabled");
	switch(param_00)
	{
		case 1:
			soundscripts\_audio_mix_manager::mm_add_submix("det_exit_ride_maglev_trains");
			soundscripts\_audio_mix_manager::mm_add_submix("det_exit_ride_homestretch_bike_down1");
			soundscripts\_snd_playsound::snd_play_delayed_linked("det_exit_train1",1.66);
			soundscripts\_snd_playsound::snd_play_delayed_linked("det_exit_train1_horn",1.66);
			soundscripts\_snd_playsound::snd_play_delayed_linked("det_exit_train1_lfe",2.06);
			break;

		case 2:
			soundscripts\_snd_playsound::snd_play_delayed_linked("det_exit_train2",1.13);
			soundscripts\_snd_playsound::snd_play_delayed_linked("det_exit_train2_lfe",2.13);
			break;

		case 3:
			var_02 = (-5636,6974,475);
			thread exit_train_by_train3_loop(var_02);
			thread exit_train_by_train3_whoosh(var_02);
			soundscripts\_audio_mix_manager::mm_clear_submix("det_exit_ride_homestretch_bike_down1",15);
			soundscripts\_audio_mix_manager::mm_add_submix("det_exit_ride_homestretch_bike_down2",15);
			break;
	}
}

//Function Number: 271
exit_train_by_train3_loop(param_00)
{
	var_01 = "exit_train3_loop";
	var_02 = [[540,1],[1080,0.1]];
	var_03 = soundscripts\_snd::snd_map(distance2d(level.player.origin,param_00),var_02);
	wait(2.13);
	var_04 = soundscripts\_snd_playsound::snd_play_loop_at("det_exit_train3_bart",param_00,var_01,0.5,1,var_03);
	var_05 = soundscripts\_snd_playsound::snd_play_loop_at("det_exit_train3_hum",param_00,var_01,0.5,1,var_03);
	var_06 = soundscripts\_snd_playsound::snd_play_loop_at("det_exit_train3_lfe",param_00,var_01,0.5,1,var_03);
	var_07 = 100000;
	var_08 = distance2d(level.player.origin,param_00);
	for(var_09 = var_07 - var_08 > 0;var_09;var_09 = var_07 - var_08 > 0)
	{
		var_03 = soundscripts\_snd::snd_map(var_08,var_02);
		var_04 scalevolume(var_03);
		var_05 scalevolume(var_03);
		var_06 scalevolume(var_03);
		wait(0.1);
		var_07 = var_08;
		var_08 = distance2d(level.player.origin,param_00);
	}

	level notify(var_01);
	wait(3);
	soundscripts\_audio_mix_manager::mm_clear_submix("det_exit_ride_maglev_trains");
}

//Function Number: 272
exit_train_by_train3_whoosh(param_00)
{
	var_01 = 100000;
	var_02 = distance2d(level.player.origin,param_00);
	var_03 = var_01 - var_02 > 0;
	while(var_03)
	{
		wait(0.1);
		var_01 = var_02;
		var_02 = distance2d(level.player.origin,param_00);
		var_03 = var_01 - var_02 > 0;
		if(var_02 < 200)
		{
			break;
		}
	}

	soundscripts\_snd_playsound::snd_play_at("det_exit_train3_whoosh",level.player.origin);
}

//Function Number: 273
exit_drive_ending_begin()
{
	soundscripts\_audio_mix_manager::mm_add_submix("det_final_cinematic");
	soundscripts\_snd_playsound::snd_play_2d("det_ending_bike_approach");
}

//Function Number: 274
setup_ending_anims()
{
	if(level.currentgen && !issubstr(level.transient_zone,"_outro"))
	{
		level waittill("tff_post_remove_hospital_add_exit");
	}

	maps\_anim::addnotetrack_customfunction("player_bike","ending_player_bike_braking",::ending_player_bike_braking,"det_exit_drive_ending");
	maps\_anim::addnotetrack_customfunction("joker_bike","ending_joker_bike_flyby",::ending_joker_bike_flyby,"det_exit_drive_ending");
	maps\_anim::addnotetrack_customfunction("bones_bike","ending_bones_bike_flyby",::ending_bones_bike_flyby,"det_exit_drive_ending");
}

//Function Number: 275
ending_player_bike_braking(param_00)
{
	soundscripts\_snd_playsound::snd_play_2d("det_ending_plr_bike_braking");
	music("mus_end_exit_drive");
}

//Function Number: 276
ending_joker_bike_flyby(param_00)
{
	soundscripts\_snd_playsound::snd_play_2d("det_ending_squad_bikes_fly_by");
}

//Function Number: 277
ending_bones_bike_flyby(param_00)
{
}

//Function Number: 278
setup_chopper_crash_anims()
{
	if(level.currentgen && !issubstr(level.transient_zone,"_outro"))
	{
		level waittill("tff_post_remove_hospital_add_exit");
	}

	maps\_anim::addnotetrack_customfunction("littlebird","det_end_chopper_approach",::det_end_chopper_approach,"det_exit_drive_ending");
	maps\_anim::addnotetrack_customfunction("littlebird","det_end_chopper_crash_start",::det_end_chopper_crash_start,"det_exit_drive_ending");
	maps\_anim::addnotetrack_customfunction("littlebird","det_end_chopper_tumble",::det_end_chopper_tumble,"det_exit_drive_ending");
	maps\_anim::addnotetrack_customfunction("littlebird","det_end_chopper_tumble_2",::det_end_chopper_tumble_2,"det_exit_drive_ending");
}

//Function Number: 279
det_end_chopper_approach(param_00)
{
}

//Function Number: 280
det_end_chopper_crash_start(param_00)
{
	soundscripts\_snd_playsound::snd_play_2d("det_ending_heli_initial_explo");
}

//Function Number: 281
det_end_chopper_tumble(param_00)
{
	soundscripts\_snd_playsound::snd_play_2d("det_ending_heli_tumble1");
}

//Function Number: 282
det_end_chopper_tumble_2(param_00)
{
	soundscripts\_snd_playsound::snd_play_2d("det_ending_heli_tumble2");
	music("mus_det_ending_win");
}

//Function Number: 283
chopper_final_explo()
{
	soundscripts\_snd_playsound::snd_play_2d("det_ending_heli_big_explo");
}

//Function Number: 284
setup_end_gate()
{
	if(level.currentgen && !issubstr(level.transient_zone,"_outro"))
	{
		level waittill("tff_post_remove_hospital_add_exit");
	}

	maps\_anim::addnotetrack_customfunction("gate","det_end_gate_close",::det_end_gate_close,"det_exit_drive_ending");
}

//Function Number: 285
det_end_gate_close(param_00)
{
	soundscripts\_snd_playsound::snd_play_delayed_2d("det_ending_big_gate_close",0);
}

//Function Number: 286
det_gl_end_logo()
{
	soundscripts\_snd_playsound::snd_play_2d("det_gl_end_logo");
	soundscripts\_audio_mix_manager::mm_add_submix("det_gl_end_logo");
}

//Function Number: 287
e3_demo_fade_out()
{
	soundscripts\_audio_mix_manager::mm_add_submix("mute_all",3);
}

//Function Number: 288
e3_demo_fade_in()
{
	soundscripts\_audio_mix_manager::mm_add_submix("mute_all");
	wait(0.05);
	soundscripts\_audio_mix_manager::mm_clear_submix("mute_all",2);
	soundscripts\_audio_mix_manager::mm_clear_submix("alley_combat_trains_off");
}

//Function Number: 289
e3_demo_clear_basement_footsteps()
{
	level.aud.in_basement = 0;
}

//Function Number: 290
aud_det_foley_override_handler()
{
	level.player endon("death");
	for(;;)
	{
		level.player waittill("foley",var_00,var_01,var_02);
		switch(var_00)
		{
			case "stationarycrouchscuff":
				if(isdefined(level.aud.in_school) && level.aud.in_school == 1)
				{
					soundscripts\_snd_playsound::snd_play_2d("fs_det_school_plr_scuff");
				}
				break;
	
			case "stationaryscuff":
				if(isdefined(level.aud.in_school) && level.aud.in_school == 1)
				{
					soundscripts\_snd_playsound::snd_play_2d("fs_det_school_plr_scuff");
				}
				break;
	
			case "crouchscuff":
				if(isdefined(level.aud.in_school) && level.aud.in_school == 1)
				{
					soundscripts\_snd_playsound::snd_play_2d("fs_det_school_plr_scuff");
				}
				break;
	
			case "runscuff":
				if(isdefined(level.aud.in_school) && level.aud.in_school == 1)
				{
					soundscripts\_snd_playsound::snd_play_2d("fs_det_school_plr_scuff");
				}
				break;
	
			case "sprintscuff":
				if(isdefined(level.aud.in_school) && level.aud.in_school == 1)
				{
					soundscripts\_snd_playsound::snd_play_2d("fs_det_school_plr_scuff");
				}
				break;
	
			case "prone":
				if(isdefined(level.aud.in_school) && level.aud.in_school == 1)
				{
					if(var_02)
					{
						soundscripts\_snd_playsound::snd_play_2d("fs_det_school_plr_prone_l");
					}
					else
					{
						soundscripts\_snd_playsound::snd_play_2d("fs_det_school_plr_prone_r");
					}
				}
				else if(isdefined(level.aud.in_basement) && level.aud.in_basement == 1)
				{
					if(var_02)
					{
						soundscripts\_snd_playsound::snd_play_2d("fs_det_bsmt_wtr_plr_walk_l");
					}
					else
					{
						soundscripts\_snd_playsound::snd_play_2d("fs_det_bsmt_wtr_plr_walk_r");
					}
				}
				break;
	
			case "crouchwalk":
				if(isdefined(level.aud.in_school) && level.aud.in_school == 1)
				{
					if(var_02)
					{
						soundscripts\_snd_playsound::snd_play_2d("fs_det_school_plr_walk_l");
					}
					else
					{
						soundscripts\_snd_playsound::snd_play_2d("fs_det_school_plr_walk_r");
					}
				}
				else if(isdefined(level.aud.in_basement) && level.aud.in_basement == 1)
				{
					if(var_02)
					{
						soundscripts\_snd_playsound::snd_play_2d("fs_det_bsmt_wtr_plr_walk_l");
					}
					else
					{
						soundscripts\_snd_playsound::snd_play_2d("fs_det_bsmt_wtr_plr_walk_r");
					}
				}
				break;
	
			case "crouchrun":
				if(isdefined(level.aud.in_school) && level.aud.in_school == 1)
				{
					if(var_02)
					{
						soundscripts\_snd_playsound::snd_play_2d("fs_det_school_plr_run_l");
					}
					else
					{
						soundscripts\_snd_playsound::snd_play_2d("fs_det_school_plr_run_r");
					}
				}
				else if(isdefined(level.aud.in_basement) && level.aud.in_basement == 1)
				{
					if(var_02)
					{
						soundscripts\_snd_playsound::snd_play_2d("fs_det_bsmt_wtr_plr_walk_l");
					}
					else
					{
						soundscripts\_snd_playsound::snd_play_2d("fs_det_bsmt_wtr_plr_walk_r");
					}
				}
				break;
	
			case "walk":
				if(isdefined(level.aud.in_school) && level.aud.in_school == 1)
				{
					if(var_02)
					{
						soundscripts\_snd_playsound::snd_play_2d("fs_det_school_plr_walk_l");
					}
					else
					{
						soundscripts\_snd_playsound::snd_play_2d("fs_det_school_plr_walk_r");
					}
				}
				else if(isdefined(level.aud.in_basement) && level.aud.in_basement == 1)
				{
					if(var_02)
					{
						soundscripts\_snd_playsound::snd_play_2d("fs_det_bsmt_wtr_plr_walk_l");
					}
					else
					{
						soundscripts\_snd_playsound::snd_play_2d("fs_det_bsmt_wtr_plr_walk_r");
					}
				}
				break;
	
			case "run":
				if(isdefined(level.aud.in_school) && level.aud.in_school == 1)
				{
					if(var_02)
					{
						soundscripts\_snd_playsound::snd_play_2d("fs_det_school_plr_run_l");
					}
					else
					{
						soundscripts\_snd_playsound::snd_play_2d("fs_det_school_plr_run_r");
					}
				}
				else if(isdefined(level.aud.in_basement) && level.aud.in_basement == 1)
				{
					if(var_02)
					{
						soundscripts\_snd_playsound::snd_play_2d("fs_det_bsmt_wtr_plr_run_l");
					}
					else
					{
						soundscripts\_snd_playsound::snd_play_2d("fs_det_bsmt_wtr_plr_run_r");
					}
				}
				break;
	
			case "sprint":
				if(isdefined(level.aud.in_school) && level.aud.in_school == 1)
				{
					if(var_02)
					{
						soundscripts\_snd_playsound::snd_play_2d("fs_det_school_plr_sprint_l");
					}
					else
					{
						soundscripts\_snd_playsound::snd_play_2d("fs_det_school_plr_sprint_r");
					}
				}
				else if(isdefined(level.aud.in_basement) && level.aud.in_basement == 1)
				{
					if(var_02)
					{
						soundscripts\_snd_playsound::snd_play_2d("fs_det_bsmt_wtr_plr_sprint_l");
					}
					else
					{
						soundscripts\_snd_playsound::snd_play_2d("fs_det_bsmt_wtr_plr_sprint_r");
					}
				}
				break;
	
			case "jump":
				break;
	
			case "lightland":
				if(isdefined(level.aud.in_school) && level.aud.in_school == 1)
				{
					soundscripts\_snd_playsound::snd_play_2d("fs_det_school_plr_land_lt");
				}
				else if(isdefined(level.aud.in_basement) && level.aud.in_basement == 1)
				{
					soundscripts\_snd_playsound::snd_play_2d("fs_det_bsmt_wtr_plr_land_lt");
				}
				break;
	
			case "mediumland":
				if(isdefined(level.aud.in_school) && level.aud.in_school == 1)
				{
					soundscripts\_snd_playsound::snd_play_2d("fs_det_school_plr_land_med");
				}
				else if(isdefined(level.aud.in_basement) && level.aud.in_basement == 1)
				{
					soundscripts\_snd_playsound::snd_play_2d("fs_det_bsmt_wtr_plr_land_med");
				}
				break;
	
			case "heavyland":
				if(isdefined(level.aud.in_school) && level.aud.in_school == 1)
				{
					soundscripts\_snd_playsound::snd_play_2d("fs_det_school_plr_land_hv");
				}
				else if(isdefined(level.aud.in_basement) && level.aud.in_basement == 1)
				{
					soundscripts\_snd_playsound::snd_play_2d("fs_det_bsmt_wtr_plr_land_hv");
				}
				break;
	
			case "damageland":
				if(isdefined(level.aud.in_school) && level.aud.in_school == 1)
				{
					soundscripts\_snd_playsound::snd_play_2d("fs_det_school_plr_land_hv_dam");
				}
				else if(isdefined(level.aud.in_basement) && level.aud.in_basement == 1)
				{
					soundscripts\_snd_playsound::snd_play_2d("fs_det_bsmt_wtr_plr_land_hv_dam");
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