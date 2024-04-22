/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: lab_aud.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 264
 * Decompile Time: 3890 ms
 * Timestamp: 4/22/2024 2:32:35 AM
*******************************************************************/

//Function Number: 1
main()
{
	config_system();
	init_snd_flags();
	init_globals();
	launch_threads();
	thread launch_loops();
	thread launch_line_emitters();
	create_level_envelop_arrays();
	init_level_arrays();
	precache_presets();
	thread maps\lab_vo::init_pcap_vo();
	common_scripts\utility::array_thread(getentarray("vrap_placed","script_noteworthy"),::aud_jeep_death_listener);
	register_snd_messages();
}

//Function Number: 2
config_system()
{
	soundscripts\_audio::set_stringtable_mapname("shg");
	soundscripts\_snd_filters::snd_set_occlusion("med_occlusion");
	soundscripts\_audio_mix_manager::mm_add_submix("lab_global_mix");
	if(getdvarint("snd_enable_damagefeedback"))
	{
		maps\_utility::enable_damagefeedback_snd();
	}
}

//Function Number: 3
init_snd_flags()
{
	common_scripts\utility::flag_init("truck_takedown_burke_done");
	common_scripts\utility::flag_init("aud_player_entering_river");
	common_scripts\utility::flag_init("aud_river_shallow_water");
	common_scripts\utility::flag_init("aud_lab_phone_start");
	common_scripts\utility::flag_init("aud_start_jammer");
	common_scripts\utility::flag_init("aud_balcony_aircraft");
	common_scripts\utility::flag_init("aud_hangar_light_hum_start");
}

//Function Number: 4
init_globals()
{
	level.aud.rope_started = 0;
}

//Function Number: 5
launch_threads()
{
	if(soundscripts\_audio::aud_is_specops())
	{
		return;
	}

	thread aud_handle_river_sfx();
	thread damb_animal_sfx_offset();
	thread aud_forest_ambient_loops();
	thread aud_lab_foley_override_handler();
	thread setup_burke_river_cross_notetracks();
	thread setup_deer_notetracks();
	thread setup_gideon_climb_notetracks();
	thread setup_player_takedown_notetracks();
	thread setup_npc_cloak_button_anims();
	thread aud_handle_clearing_dambs();
	thread aud_handle_river_progress_flags();
	thread aud_handle_river_shallow_flag();
	thread setup_cormack_meetup_scene_notetracks();
	thread setup_server_room_scene_notetracks();
	thread setup_hangar_notetracks();
	thread set_up_tank_exit_anims();
	thread lab_exfil_detonate_anims();
}

//Function Number: 6
launch_loops()
{
	if(level.currentgen && !istransientloaded("lab_intro_audio_tr"))
	{
		return;
	}

	common_scripts\utility::loop_fx_sound("heli_fire_lrg_lp",(-11258,-1660,3),1,"aud_stop_intro");
	common_scripts\utility::loop_fx_sound("grass_fire_lp_03",(-10123,-1664,27),1,"aud_stop_intro");
	common_scripts\utility::loop_fx_sound("grass_fire_lp_01",(-10501,-1636,-3),1,"aud_stop_intro");
	common_scripts\utility::loop_fx_sound("grass_fire_lp_03",(-10752,-1645,-12),1,"aud_stop_intro");
	common_scripts\utility::loop_fx_sound("grass_fire_lp_02",(-10609,-1506,-17),1,"aud_stop_intro");
	common_scripts\utility::loop_fx_sound("emt_waterfall_sml_lp_lyr_01",(-9813,3497,-389),1,"aud_stop_intro");
	common_scripts\utility::loop_fx_sound("emt_foliage_lp",(-9481,4846,44),1,"aud_stop_intro");
	common_scripts\utility::loop_fx_sound("emt_foliage_lp",(-8584,4722,-42),1,"aud_stop_intro");
	common_scripts\utility::loop_fx_sound("emt_foliage_lp",(-8855,5311,-5),1,"aud_stop_intro");
	common_scripts\utility::loop_fx_sound("emt_clearing_foliage_lp",(-15543,9251,536),1,"aud_stop_intro");
	common_scripts\utility::loop_fx_sound("emt_clearing_foliage_lp",(-14812,8798,337),1,"aud_stop_intro");
	common_scripts\utility::loop_fx_sound("emt_clearing_foliage_lp",(-15012,8733,576),1,"aud_stop_intro");
	common_scripts\utility::loop_fx_sound("emt_clearing_foliage_lp",(-15122,9460,105),1,"aud_stop_intro");
	if(level.currentgen)
	{
		level waittill("tff_pre_intro_audio_to_middle");
		level notify("aud_stop_intro");
	}
}

//Function Number: 7
launch_line_emitters()
{
	if(level.currentgen && !istransientloaded("lab_intro_audio_tr"))
	{
		return;
	}

	wait(0.1);
	thread soundscripts\_audio::aud_play_line_emitter("stream_lab_01","lab_stream_flow_line_lp",(-12585,15542,-1447),(-12820,15320,-1447),undefined,0);
	thread soundscripts\_audio::aud_play_line_emitter("stream_lab_02","lab_stream_flow_line_lp",(-12190,15632,-1447),(-12665,15609,-1447),undefined,0);
	thread soundscripts\_audio::aud_play_line_emitter("stream_lab_03","lab_stream_drain",(-11757,15774,-1440),(-12070,15703,-1447),undefined,0);
	thread soundscripts\_audio::aud_play_line_emitter("stream_lab_04","lab_stream_flow_lp",(-12820,15327,-1440),(-13022,15115,-1440),undefined,0);
	if(level.currentgen)
	{
		level waittill("tff_pre_intro_audio_to_middle");
		soundscripts\_audio::aud_stop_line_emitter("stream_lab_01");
		soundscripts\_audio::aud_stop_line_emitter("stream_lab_02");
		soundscripts\_audio::aud_stop_line_emitter("stream_lab_03");
		soundscripts\_audio::aud_stop_line_emitter("stream_lab_04");
	}
}

//Function Number: 8
aud_handle_river_sfx()
{
	if(level.currentgen && !istransientloaded("lab_intro_audio_tr"))
	{
		return;
	}

	var_00 = (-9716,3329,-502);
	var_01 = (-7836,3283,-502);
	thread soundscripts\_audio::aud_play_line_emitter("river_emitter","emt_river_lrg_lp_lyr_01",var_00,var_01);
	if(level.currentgen)
	{
		level waittill("tff_pre_intro_audio_to_middle");
		soundscripts\_audio::aud_stop_line_emitter("river_emitter");
	}
}

//Function Number: 9
create_level_envelop_arrays()
{
	level.aud.envs = [];
	level.aud.envs["example_envelop"] = [[0,0],[0.082,0.426],[0.238,0.736],[0.408,0.844],[0.756,0.953],[1,1]];
	level.aud.envs["snipe_report_volume"] = [[700,0.6],[900,0.7],[1150,0.8],[1350,0.9],[1600,1]];
	level.aud.envs["snipe_report_delay"] = [[750,0],[900,0],[1200,0.1],[1600,0.2],[1800,0.3]];
	level.aud.envs["player_speed_to_music_vol"] = [[0,0],[10,1]];
	level.aud.envs["dog_bark_percentage"] = [[0,0],[0.5,0],[17,100]];
}

//Function Number: 10
init_level_arrays()
{
	level.aud.sniper = [];
	level.aud.sniper["surfaces"] = ["dirt","wood","water","grass"];
}

//Function Number: 11
precache_presets()
{
}

//Function Number: 12
register_snd_messages()
{
	soundscripts\_snd::snd_register_message("snd_zone_handler",::zone_handler);
	soundscripts\_snd::snd_register_message("snd_music_handler",::music_handler);
	soundscripts\_snd::snd_register_message("start_crash",::start_crash);
	soundscripts\_snd::snd_register_message("start_forest",::start_forest);
	soundscripts\_snd::snd_register_message("start_forest_takedown",::start_forest_takedown);
	soundscripts\_snd::snd_register_message("start_logging_road",::start_logging_road);
	soundscripts\_snd::snd_register_message("start_mech_march",::start_mech_march);
	soundscripts\_snd::snd_register_message("start_cliff_rappel",::start_cliff_rappel);
	soundscripts\_snd::snd_register_message("start_facility_breach",::start_facility_breach);
	soundscripts\_snd::snd_register_message("start_server_room",::start_server_room);
	soundscripts\_snd::snd_register_message("start_research_facility_bridge",::start_research_facility_bridge);
	soundscripts\_snd::snd_register_message("start_foam_room",::start_foam_room);
	soundscripts\_snd::snd_register_message("start_courtyard",::start_courtyard);
	soundscripts\_snd::snd_register_message("start_courtyard_jammer",::start_courtyard_jammer);
	soundscripts\_snd::snd_register_message("start_tank_hangar",::start_tank_hangar);
	soundscripts\_snd::snd_register_message("start_tank_board",::start_tank_board);
	soundscripts\_snd::snd_register_message("start_tank_road",::start_tank_road);
	soundscripts\_snd::snd_register_message("start_tank_field",::start_tank_field);
	soundscripts\_snd::snd_register_message("start_exfil",::start_exfil);
	soundscripts\_snd::snd_register_message("aud_lab_intro_screen",::aud_lab_intro_screen);
	soundscripts\_snd::snd_register_message("aud_helo_spotlight_spawn",::aud_helo_spotlight_spawn);
	soundscripts\_snd::snd_register_message("aud_burke_intro_anim",::aud_burke_intro_anim);
	soundscripts\_snd::snd_register_message("hud_malfunction",::hud_malfunction);
	soundscripts\_snd::snd_register_message("player_reaches_shack",::player_reaches_shack);
	soundscripts\_snd::snd_register_message("chopper_sniper_shot",::chopper_sniper_shot);
	soundscripts\_snd::snd_register_message("aud_shack_explode_whizby",::aud_shack_explode_whizby);
	soundscripts\_snd::snd_register_message("aud_shack_explode",::aud_shack_explode);
	soundscripts\_snd::snd_register_message("aud_burke_stumble_run",::aud_burke_stumble_run);
	soundscripts\_snd::snd_register_message("aud_burke_step_over_log",::aud_burke_step_over_log);
	soundscripts\_snd::snd_register_message("aud_burke_tree_cover_01",::aud_burke_tree_cover_01);
	soundscripts\_snd::snd_register_message("aud_burke_stumble_knee",::aud_burke_stumble_knee);
	soundscripts\_snd::snd_register_message("burke_hill_slide",::burke_hill_slide);
	soundscripts\_snd::snd_register_message("aud_player_hill_slide",::aud_player_hill_slide);
	soundscripts\_snd::snd_register_message("aud_burke_hill_slide_stump",::aud_burke_hill_slide_stump);
	soundscripts\_snd::snd_register_message("aud_burke_river_over_log",::aud_burke_river_over_log);
	soundscripts\_snd::snd_register_message("forest_climb_wall_start",::forest_climb_wall_start);
	soundscripts\_snd::snd_register_message("aud_burke_wall_climb",::aud_burke_wall_climb);
	soundscripts\_snd::snd_register_message("aud_player_wall_climb_01",::aud_player_wall_climb_01);
	soundscripts\_snd::snd_register_message("aud_player_wall_climb_02",::aud_player_wall_climb_02);
	soundscripts\_snd::snd_register_message("aud_player_wall_climb_03",::aud_player_wall_climb_03);
	soundscripts\_snd::snd_register_message("aud_player_wall_climb_04",::aud_player_wall_climb_04);
	soundscripts\_snd::snd_register_message("aud_player_wall_climb_05",::aud_player_wall_climb_05);
	soundscripts\_snd::snd_register_message("player_cloak_on",::player_cloak_on);
	soundscripts\_snd::snd_register_message("wall_climb_cloak_activate",::wall_climb_cloak_activate);
	soundscripts\_snd::snd_register_message("wall_climb_last_jump",::wall_climb_last_jump);
	soundscripts\_snd::snd_register_message("burke_run_slide",::burke_run_slide);
	soundscripts\_snd::snd_register_message("deer_foliage_rustle",::deer_sequence);
	soundscripts\_snd::snd_register_message("random_dog_barks",::random_dog_barks);
	soundscripts\_snd::snd_register_message("burke_slide_02",::burke_slide_02);
	soundscripts\_snd::snd_register_message("player_forest_takedown",::player_forest_takedown);
	soundscripts\_snd::snd_register_message("burke_forest_takedown",::burke_forest_takedown);
	soundscripts\_snd::snd_register_message("takedown_01_complete",::takedown_01_complete);
	soundscripts\_snd::snd_register_message("combat_forest_patrols_start",::combat_forest_patrols_start);
	soundscripts\_snd::snd_register_message("flank_right_dialogue",::flank_right_dialogue);
	soundscripts\_snd::snd_register_message("gaz_01_dist_by",::gaz_01_dist_by);
	soundscripts\_snd::snd_register_message("gaz_02_dist_by",::gaz_02_dist_by);
	soundscripts\_snd::snd_register_message("gaz_03_close_by",::gaz_03_close_by);
	soundscripts\_snd::snd_register_message("burke_solo_takedown",::burke_solo_takedown);
	soundscripts\_snd::snd_register_message("aud_vrap_mute_start",::aud_vrap_mute_start);
	soundscripts\_snd::snd_register_message("lab_brk_illtakedriver",::lab_brk_illtakedriver);
	soundscripts\_snd::snd_register_message("truck_takedown_radio",::truck_takedown_radio);
	soundscripts\_snd::snd_register_message("truck_takedown",::truck_takedown);
	soundscripts\_snd::snd_register_message("takedown_truck_lights_off",::takedown_truck_lights_off);
	soundscripts\_snd::snd_register_message("vehicle_takedown_01_complete",::vehicle_takedown_01_complete);
	soundscripts\_snd::snd_register_message("aud_patrol_helo_debris_sfx",::aud_patrol_helo_debris_sfx);
	soundscripts\_snd::snd_register_message("gaz_04_slow_by",::gaz_04_slow_by);
	soundscripts\_snd::snd_register_message("gaz_05_slow_by",::gaz_05_slow_by);
	soundscripts\_snd::snd_register_message("forest_mech_spawn",::forest_mech_spawn);
	soundscripts\_snd::snd_register_message("skr_distant_pull_up_and_scan",::skr_distant_pull_up_and_scan);
	soundscripts\_snd::snd_register_message("start_seeker_audio",::start_seeker_audio);
	soundscripts\_snd::snd_register_message("start_fixed_scanner_audio",::start_fixed_scanner_audio);
	soundscripts\_snd::snd_register_message("seeker_clear",::seeker_clear);
	soundscripts\_snd::snd_register_message("aud_burke_nearing_cliff",::aud_burke_nearing_cliff);
	soundscripts\_snd::snd_register_message("aud_rappel_player_hookup",::aud_rappel_player_hookup);
	soundscripts\_snd::snd_register_message("aud_rappel_player_movement_start",::aud_rappel_player_movement_start);
	soundscripts\_snd::snd_register_message("aud_rappel_player_movement_stop",::aud_rappel_player_movement_stop);
	soundscripts\_snd::snd_register_message("player_rappel_complete",::aud_player_rappel_complete);
	soundscripts\_snd::snd_register_message("lab_mute_gun_holster",::lab_mute_gun_holster);
	soundscripts\_snd::snd_register_message("aud_facility_breach_start",::aud_facility_breach_start);
	soundscripts\_snd::snd_register_message("aud_lab_ambient_emitters",::aud_lab_ambient_emitters);
	soundscripts\_snd::snd_register_message("begin_pcap_vo_lab_serverroom_cormack",::begin_pcap_vo_lab_serverroom_cormack);
	soundscripts\_snd::snd_register_message("open_server_room_door",::open_server_room_door);
	soundscripts\_snd::snd_register_message("aud_server_room_door_crack",::aud_server_room_door_crack);
	soundscripts\_snd::snd_register_message("aud_server_room_door_kick",::aud_server_room_door_kick);
	soundscripts\_snd::snd_register_message("aud_server_room_door_enter",::aud_server_room_door_enter);
	soundscripts\_snd::snd_register_message("aud_player_computer_gl_timing_fix",::aud_player_computer_gl_timing_fix);
	soundscripts\_snd::snd_register_message("research_building_combat_complete",::research_building_combat_complete);
	soundscripts\_snd::snd_register_message("aud_foam_room_emitters",::aud_foam_room_emitters);
	soundscripts\_snd::snd_register_message("foam_room_crmk_plant_these_frvs",::foam_room_crmk_plant_these_frvs);
	soundscripts\_snd::snd_register_message("neutralize_bio_weapons_complete",::neutralize_bio_weapons_complete);
	soundscripts\_snd::snd_register_message("player_plant_frb",::player_plant_frb);
	soundscripts\_snd::snd_register_message("foam_room_door_close",::foam_room_door_close);
	soundscripts\_snd::snd_register_message("door2courtyard_open",::door2courtyard_open);
	soundscripts\_snd::snd_register_message("foam_room_complete_dialogue",::foam_room_complete_dialogue);
	soundscripts\_snd::snd_register_message("aud_ctyard_vrap01",::aud_ctyard_vrap01);
	soundscripts\_snd::snd_register_message("aud_ctyard_vrap02",::aud_ctyard_vrap02);
	soundscripts\_snd::snd_register_message("aud_ctyard_vrap04",::aud_ctyard_vrap04);
	soundscripts\_snd::snd_register_message("aud_ctyard_vrap05",::aud_ctyard_vrap05);
	soundscripts\_snd::snd_register_message("courtyard_hangar_mech_01_spawned",::courtyard_hangar_mech_01_spawned);
	soundscripts\_snd::snd_register_message("courtyard_door_hack_start_dialogue",::courtyard_door_hack_start_dialogue);
	soundscripts\_snd::snd_register_message("courtyard_start_dish",::courtyard_start_dish);
	soundscripts\_snd::snd_register_message("courtyard_defend_start",::courtyard_defend_start);
	soundscripts\_snd::snd_register_message("courtyard_end_jammer",::courtyard_end_jammer);
	soundscripts\_snd::snd_register_message("aud_courtyard_hangar_door_close",::aud_courtyard_hangar_door_close);
	soundscripts\_snd::snd_register_message("aud_courtyard_hangar_door_hack",::aud_courtyard_hangar_door_hack);
	soundscripts\_snd::snd_register_message("aud_courtyard_hangar_door_hack_idle",::aud_courtyard_hangar_door_hack_idle);
	soundscripts\_snd::snd_register_message("aud_courtyard_hangar_door_open",::aud_courtyard_hangar_door_open);
	soundscripts\_snd::snd_register_message("courtyard_hangar_door_close_rpg",::courtyard_hangar_door_close_rpg);
	soundscripts\_snd::snd_register_message("aud_post_courtyard_emitters",::aud_post_courtyard_emitters);
	soundscripts\_snd::snd_register_message("current_gen_hangar_door_open",::current_gen_hangar_door_open);
	soundscripts\_snd::snd_register_message("hangar_lights_on",::hangar_lights_on);
	soundscripts\_snd::snd_register_message("hover_tank_startup_sequence",::hover_tank_startup_sequence);
	soundscripts\_snd::snd_register_message("hovertank_enter",::hovertank_enter);
	soundscripts\_snd::snd_register_message("aud_player_gets_in_tank",::aud_player_gets_in_tank);
	soundscripts\_snd::snd_register_message("aud_impact_system_hovertank",::aud_impact_system_hovertank);
	soundscripts\_snd::snd_register_message("aud_tank_section_vehicles_spawned",::aud_tank_section_vehicles_spawned);
	soundscripts\_snd::snd_register_message("boxtruck_explode",::boxtruck_explode);
	soundscripts\_snd::snd_register_message("warbird_emp_death",::warbird_emp_death);
	soundscripts\_snd::snd_register_message("log_pile_collapse",::log_pile_collapse);
	soundscripts\_snd::snd_register_message("tank_shack_destruct",::tank_shack_destruct);
	soundscripts\_snd::snd_register_message("tank_disabled",::tank_disabled);
	soundscripts\_snd::snd_register_message("tank_exit",::tank_exit);
	soundscripts\_snd::snd_register_message("lab_exfil_missile_strike",::lab_exfil_missile_strike);
	soundscripts\_snd::snd_register_message("razorback_land",::razorback_land);
	soundscripts\_snd::snd_register_message("tank_exfil_charges",::tank_exfil_charges_going_off);
	soundscripts\_snd::snd_register_message("tank_exfil_detonate",::tank_exfil_detonate);
	soundscripts\_snd::snd_register_message("lab_e3_end_logo",::lab_e3_end_logo);
	soundscripts\_snd::snd_register_message("aud_start_exfil_foley",::aud_start_exfil_foley);
	soundscripts\_snd::snd_register_message("e3_demo_fade_out",::e3_demo_fade_out);
	soundscripts\_snd::snd_register_message("e3_demo_clear_alarm",::e3_demo_clear_alarm);
	soundscripts\_snd::snd_register_message("e3_demo_fade_in",::e3_demo_fade_in);
}

//Function Number: 13
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
		case "enter_lab_ext_forest_ent":
			if(var_02 == "lab_ext_field")
			{
				level.aud.in_river = 1;
				level.aud.opening_run = 0;
				soundscripts\_audio_mix_manager::mm_clear_submix("lab_opening_chase");
			}
			else if(var_02 == "lab_ext_forest_ent")
			{
				level.aud.in_river = 1;
			}
			break;

		case "exit_lab_ext_forest_ent":
			if(var_03 == "lab_ext_field")
			{
				level.aud.in_river = 0;
			}
			else if(var_03 == "lab_ext_forest_ent")
			{
				level.aud.in_river = 0;
			}
			break;

		case "exit_lab_ext_smoking_balcony":
			level notify("stop_courtyard_alarms");
			soundscripts\_snd_filters::snd_fade_out_filter(0.5);
			break;
	}
}

//Function Number: 14
music(param_00,param_01)
{
	thread music_handler(param_00,param_01);
}

//Function Number: 15
music_handler(param_00,param_01)
{
	level notify("exit_music_thread");
	level endon("exit_music_thread");
	var_02 = 0.75;
	var_03 = 0.4;
	var_04 = 0.95;
	var_05 = 0.5;
	var_06 = 0.4;
	var_07 = 0.3;
	var_08 = 0.7;
	var_09 = 0.45;
	switch(param_00)
	{
		case "mus_lab_intro_black_done":
			soundscripts\_audio::aud_set_music_submix(var_02);
			wait(5.5);
			soundscripts\_audio_music::mus_play("mus_lab_intro_lp",0.6);
			break;

		case "player_cloak_on":
			soundscripts\_audio_music::mus_play("mus_lab_intro_end",0.1,1);
			break;

		case "mus_forest_stealth":
			break;

		case "flank_right_dialogue":
			break;

		case "lab_brk_illtakedriver":
			soundscripts\_audio_music::mus_stop(8);
			break;

		case "vehicle_takedown_01_complete":
			break;

		case "mus_forest_mech_march":
			soundscripts\_audio_mix_manager::mm_add_submix("lab_mech_march",1.5);
			mus_submixer("off");
			soundscripts\_audio::aud_set_music_submix(var_04,2.5);
			soundscripts\_audio_music::mus_play("mus_forest_mech_march",0,2);
			wait(1);
			wait(17);
			soundscripts\_audio::aud_set_music_submix(0,14);
			soundscripts\_audio_mix_manager::mm_clear_submix("lab_mech_march",4);
			break;

		case "seeker_clear":
			soundscripts\_audio_music::mus_stop(15);
			break;

		case "begin_pcap_vo_lab_serverroom_cormack":
			mus_submixer("off");
			soundscripts\_audio::aud_set_music_submix(0.1);
			soundscripts\_audio_music::mus_play("mus_lab_combat1_intro",0.2);
			wait(0.1);
			soundscripts\_audio::aud_set_music_submix(var_05,45);
			break;

		case "open_server_room_door":
			soundscripts\_audio_music::mus_play("mus_lab_combat1_body",0,4);
			soundscripts\_audio::aud_set_music_submix(var_05,2);
			wait(128);
			soundscripts\_audio_music::mus_play("mus_lab_combat1_vamp1",0,4);
			break;

		case "research_building_combat_complete":
			soundscripts\_audio::aud_set_music_submix(var_05,2);
			soundscripts\_audio_music::mus_play("mus_lab_combat1_vamp2",0,1);
			break;

		case "foam_room_crmk_plant_these_frvs":
			soundscripts\_audio::aud_set_music_submix(var_05,2);
			soundscripts\_audio_music::mus_play("mus_lab_combat1_vamp3",1,1);
			wait(0.1);
			soundscripts\_audio::aud_set_music_submix(0.2,2);
			break;

		case "neutralize_bio_weapons_complete":
			soundscripts\_audio::aud_set_music_submix(var_05,2);
			soundscripts\_audio_music::mus_play("mus_lab_combat1_end",0,0.5);
			break;

		case "begin_courtyard_combat":
			soundscripts\_audio_mix_manager::mm_add_submix("lab_courtyard_quads_low",10);
			soundscripts\_audio::aud_set_music_submix(var_06,1);
			soundscripts\_audio_music::mus_play("mus_lab_combat2_lp",10);
			break;

		case "pre_mech_vrap":
			soundscripts\_audio_mix_manager::mm_clear_submix("lab_courtyard_quads_low",3);
			soundscripts\_audio::aud_set_music_submix(0.1,5);
			wait(2);
			soundscripts\_audio_music::mus_play("mus_lab_combat2_end",1,1);
			break;

		case "courtyard_hangar_mech_01_spawned":
			soundscripts\_audio_mix_manager::mm_add_submix("lab_courtyard_quads_low",3);
			soundscripts\_audio_mix_manager::mm_add_submix("lab_courtyard_alarms_low",3);
			soundscripts\_audio::aud_set_music_submix(var_08,0);
			soundscripts\_audio_music::mus_play("mus_lab_courtyard_ast1",0);
			break;

		case "courtyard_door_hack_start_dialogue":
			soundscripts\_audio_mix_manager::mm_clear_submix("lab_courtyard_quads_low",5);
			soundscripts\_audio_mix_manager::mm_clear_submix("lab_courtyard_alarms_low",5);
			soundscripts\_audio_music::mus_stop(5);
			wait(1);
			soundscripts\_audio::aud_set_music_submix(var_06,10);
			soundscripts\_audio_music::mus_play("mus_lab_combat3_lp",10);
			break;

		case "courtyard_defend_start":
			break;

		case "courtyard_hangar_door_close":
			soundscripts\_audio::aud_set_music_submix(var_07,1);
			soundscripts\_audio_music::mus_play("mus_lab_combat3_end",0,1);
			break;

		case "tank_reveal":
			soundscripts\_audio::aud_set_music_submix(0.6,0.5);
			soundscripts\_audio_music::mus_play("mus_lab_tank_reveal",0);
			wait(8);
			soundscripts\_audio::aud_set_music_submix(0.4,3);
			break;

		case "hover_tank_startup":
			break;

		case "begin_tank_combat":
			soundscripts\_audio::aud_set_music_submix(var_09,0);
			soundscripts\_audio_music::mus_play("mus_lab_tank_combat",0);
			break;

		case "end_tank_combat":
			soundscripts\_audio_music::mus_stop(5);
			break;

		case "lab_finale":
			soundscripts\_audio::aud_set_music_submix(0.6,0.1);
			wait(0.1);
			soundscripts\_audio_music::mus_play("mus_lab_finale",5);
			break;

		default:
			if(getdvarint("snd_validate_music_messages"))
			{
			}
			break;
	}
}

//Function Number: 16
mus_submixer(param_00,param_01)
{
	param_00 = soundscripts\_audio::aud_get_optional_param("on",param_00);
	param_01 = soundscripts\_audio::aud_get_optional_param(1,param_01);
	if(param_00 == "off")
	{
		level notify("kill_mus_submixer");
		return;
	}

	thread mus_submixer_thread(param_01);
}

//Function Number: 17
mus_submixer_thread(param_00)
{
	level notify("kill_mus_submixer");
	level endon("kill_mus_submixer");
	var_01 = 0.25;
	var_02 = 0.1;
	var_03 = 0.02;
	var_04 = 0;
	var_05 = 17.6;
	for(;;)
	{
		var_06 = length(level.player getvelocity()) / var_05;
		if(getdvarint("print_player_speed"))
		{
			iprintln(var_06);
		}

		if(var_06 > var_04)
		{
			var_07 = var_02;
		}
		else
		{
			var_07 = var_03;
		}

		var_04 = var_04 + var_07 * var_06 - var_04;
		var_08 = piecewiselinearlookup(var_04,level.aud.envs["player_speed_to_music_vol"]);
		soundscripts\_audio::aud_set_music_submix(var_08 * param_00,var_01);
		wait(var_01);
	}
}

//Function Number: 18
start_crash()
{
	soundscripts\_audio_zone_manager::azm_start_zone("lab_ext_field",1);
	soundscripts\_audio_mix_manager::mm_add_submix("lab_intro_black");
	wait(0.05);
	soundscripts\_audio_mix_manager::mm_add_submix("lab_heli_sniper");
	level.aud.opening_run = 1;
	soundscripts\_audio_mix_manager::mm_add_submix("lab_opening_chase");
}

//Function Number: 19
start_forest()
{
	soundscripts\_audio_zone_manager::azm_start_zone("lab_ext_forest_ent",1);
	music("mus_lab_intro_black_done");
}

//Function Number: 20
start_forest_takedown()
{
	soundscripts\_audio_zone_manager::azm_start_zone("lab_ext_forest",1);
	common_scripts\utility::flag_set("snd_cloak_is_enabled");
}

//Function Number: 21
start_logging_road()
{
	soundscripts\_audio_zone_manager::azm_start_zone("lab_ext_forest",1);
	common_scripts\utility::flag_set("snd_cloak_is_enabled");
}

//Function Number: 22
start_mech_march()
{
	soundscripts\_audio_zone_manager::azm_start_zone("lab_ext_forest",1);
	common_scripts\utility::flag_set("snd_cloak_is_enabled");
}

//Function Number: 23
start_cliff_rappel()
{
	soundscripts\_audio_zone_manager::azm_start_zone("lab_ext_forest",1);
}

//Function Number: 24
start_facility_breach()
{
	soundscripts\_audio_zone_manager::azm_start_zone("lab_ext_infil",1);
}

//Function Number: 25
start_server_room()
{
	soundscripts\_audio_zone_manager::azm_start_zone("lab_int_main",1);
	thread aud_lab_ambient_emitters();
}

//Function Number: 26
start_research_facility_bridge()
{
	soundscripts\_audio_zone_manager::azm_start_zone("lab_int_main",1);
	music("open_server_room_door");
	start_interior_alarms();
}

//Function Number: 27
start_foam_room()
{
	soundscripts\_audio_zone_manager::azm_start_zone("lab_int_main",1);
	music("research_building_combat_complete");
	soundscripts\_audio_mix_manager::mm_add_submix("lab_neutralize_bio_weapons_complete",1);
	start_interior_alarms();
	thread aud_foam_room_emitters();
}

//Function Number: 28
start_courtyard()
{
	soundscripts\_audio_zone_manager::azm_start_zone("lab_int_main",1);
	soundscripts\_audio_mix_manager::mm_add_submix("lab_neutralize_bio_weapons_complete",1);
	thread aud_foam_room_emitters();
	start_interior_alarms();
	courtyard_start_dish();
}

//Function Number: 29
start_courtyard_jammer(param_00)
{
	soundscripts\_audio_zone_manager::azm_start_zone("lab_int_main",1);
	music("courtyard_door_hack_start_dialogue");
	start_courtyard_alarms();
}

//Function Number: 30
start_tank_hangar()
{
	soundscripts\_audio_zone_manager::azm_start_zone("lab_int_main",1);
	thread aud_post_courtyard_emitters();
	start_post_courtyard_interior_alarms();
}

//Function Number: 31
start_tank_board()
{
	soundscripts\_audio_zone_manager::azm_start_zone("lab_int_tank_hangar",1);
	thread tank_checkpoint_engine();
}

//Function Number: 32
tank_checkpoint_engine()
{
	var_00 = spawn("script_origin",(-12771,9352,-1203));
	var_00 soundscripts\_snd_playsound::snd_play_loop("ht_startup_engine_loop");
	level waittill("kill_tank_startup_loop");
	wait(4.8);
	soundscripts\_audio::aud_fade_loop_out_and_delete(var_00,4);
}

//Function Number: 33
start_tank_road()
{
	tank_screens_boot_up();
	soundscripts\_audio_mix_manager::mm_add_submix("tank_battle",0.25);
	soundscripts\_snd::snd_music_message("begin_tank_combat");
}

//Function Number: 34
start_tank_field()
{
	soundscripts\_audio_zone_manager::azm_start_zone("lab_int_tank",1);
	tank_screens_boot_up();
	soundscripts\_audio_mix_manager::mm_add_submix("tank_battle",0.25);
	soundscripts\_snd::snd_music_message("begin_tank_combat");
}

//Function Number: 35
start_exfil()
{
	soundscripts\_audio_zone_manager::azm_start_zone("lab_ext_field",1);
	soundscripts\_audio_mix_manager::mm_add_submix("tank_battle",0.25);
}

//Function Number: 36
aud_lab_intro_screen()
{
	wait(0.5);
	thread aud_introblack_bullet("right");
	soundscripts\_snd_playsound::snd_play_2d("lab_introblack_breathing");
	soundscripts\_snd_playsound::snd_play_delayed_2d("lab_introblack_gearfoley",3);
	wait(1.5);
	thread aud_introblack_bullet("left");
	wait(3);
	thread aud_introblack_bullet("right");
	wait(3);
	thread aud_introblack_bullet("left");
	wait(5.5);
	soundscripts\_audio_mix_manager::mm_clear_submix("lab_intro_black",5);
}

//Function Number: 37
aud_introblack_bullet(param_00)
{
	var_01 = "left";
	if(isdefined(param_00))
	{
		var_01 = param_00;
	}

	soundscripts\_snd_playsound::snd_play_2d("lab_introblack_whizby");
	if(var_01 == "left")
	{
		soundscripts\_snd_playsound::snd_play_delayed_2d("lab_introblack_bullet_l",0.2);
		return;
	}

	soundscripts\_snd_playsound::snd_play_delayed_2d("lab_introblack_bullet_r",0.2);
}

//Function Number: 38
aud_burke_intro_anim()
{
	soundscripts\_snd_playsound::snd_play_2d("lab_introblack_helo_flyby_rears");
	soundscripts\_snd_playsound::snd_play_delayed_2d("lab_introblack_burke_trip",0.8);
}

//Function Number: 39
hud_malfunction()
{
	soundscripts\_snd::snd_music_message("mus_lab_intro_black_done");
}

//Function Number: 40
player_reaches_shack()
{
	level notify("hud_malfunction_loop_stop");
}

//Function Number: 41
aud_helo_spotlight_spawn()
{
	var_00 = self;
}

//Function Number: 42
chopper_sniper_shot(param_00,param_01)
{
	var_02 = param_00;
	var_03 = param_01;
	thread aud_chopper_sniper_whizby(var_02,var_03);
	thread aud_chopper_sniper_bullet(var_02,var_03);
	wait(0.5);
	soundscripts\_snd_playsound::snd_play_at("helo_sniper_shot",var_02);
	var_04 = distance(level.player.origin,var_02);
	var_05 = soundscripts\_snd::snd_map(var_04,level.aud.envs["snipe_report_delay"]);
	wait(var_05);
	var_06 = soundscripts\_snd_playsound::snd_play_2d("helo_sniper_tail");
	var_07 = soundscripts\_snd::snd_map(var_04,level.aud.envs["snipe_report_volume"]);
	var_06 scalevolume(var_07,0.05);
}

//Function Number: 43
aud_chopper_sniper_whizby(param_00,param_01)
{
	var_02 = soundscripts\_snd_playsound::snd_play_at("whizby_sniper",param_00);
	var_02 moveto(param_01,0.2);
}

//Function Number: 44
aud_chopper_sniper_bullet(param_00,param_01)
{
	var_02 = param_01 - param_00 * 1.05 + param_00;
	var_03 = bullettrace(param_00,var_02,0,level.helo_spotlight,0,0,0,1);
	var_04 = var_03["surfacetype"];
	if(var_04 == "none")
	{
		var_04 = "dirt";
	}

	if(!soundscripts\_snd_common::snd_is_valid_surface(var_04,level.aud.sniper["surfaces"]))
	{
		var_04 = "dirt";
	}

	if(var_04 == "water")
	{
		return;
	}

	var_05 = "bullet_sniper_" + var_04;
	wait(0.2);
	soundscripts\_snd_playsound::snd_play_at(var_05,param_01);
}

//Function Number: 45
aud_shack_explode_whizby()
{
	soundscripts\_audio_mix_manager::mm_add_submix("lab_shack_explode");
	level.burke soundscripts\_snd_playsound::snd_play_linked("lab_shack_explode_whizby");
}

//Function Number: 46
aud_shack_explode(param_00)
{
	var_01 = level.burke soundscripts\_snd_playsound::snd_play_linked("lab_shack_explode_impact");
	var_01 waittill("sounddone");
	soundscripts\_audio_mix_manager::mm_clear_submix("lab_shack_explode");
}

//Function Number: 47
aud_burke_stumble_run()
{
}

//Function Number: 48
aud_burke_step_over_log()
{
}

//Function Number: 49
aud_burke_tree_cover_01()
{
	soundscripts\_audio_mix_manager::mm_add_submix("lab_hill_slide",0.05);
}

//Function Number: 50
aud_burke_stumble_knee()
{
	soundscripts\_audio_mix_manager::mm_add_submix("lab_hill_slide",0.05);
}

//Function Number: 51
burke_hill_slide(param_00)
{
	if(param_00 == "anim_01")
	{
		level.burke soundscripts\_snd_playsound::snd_play_delayed_linked("hill_slide_burke_fence",0);
		level.burke soundscripts\_snd_playsound::snd_play_delayed_linked("hill_slide_burke",1.8);
		return;
	}

	if(param_00 == "anim_02")
	{
		level.burke soundscripts\_snd_playsound::snd_play_delayed_linked("hill_slide_burke",0.25);
	}
}

//Function Number: 52
aud_player_hill_slide()
{
	soundscripts\_snd_playsound::snd_play_delayed_2d("hill_slide_log_grab",0.45);
	soundscripts\_snd_playsound::snd_play_delayed_2d("hill_slide_main",1.6);
	wait(7);
	soundscripts\_audio_mix_manager::mm_clear_submix("lab_hill_slide");
}

//Function Number: 53
aud_burke_hill_slide_stump()
{
	soundscripts\_audio_mix_manager::mm_add_submix("lab_river",0.05);
}

//Function Number: 54
aud_burke_river_over_log()
{
	soundscripts\_audio_mix_manager::mm_add_submix("lab_river_foley",0.05);
}

//Function Number: 55
setup_burke_river_cross_notetracks()
{
	if(level.currentgen && !istransientloaded("lab_intro_tr"))
	{
		return;
	}

	maps\_anim::addnotetrack_customfunction("burke","aud_burke_water_jump",::aud_burke_water_jump,"burke_river_cross");
	maps\_anim::addnotetrack_customfunction("burke","aud_burke_water_enter",::aud_burke_water_enter,"burke_river_cross");
	maps\_anim::addnotetrack_customfunction("burke","aud_burke_water_deep_step",::aud_burke_water_deep_step,"burke_river_cross");
	maps\_anim::addnotetrack_customfunction("burke","aud_burke_water_slip",::aud_burke_water_slip,"burke_river_cross");
	maps\_anim::addnotetrack_customfunction("burke","aud_burke_water_fall_forward",::aud_burke_water_fall_forward,"burke_river_cross");
	maps\_anim::addnotetrack_customfunction("burke","aud_burke_water_shallow_step",::aud_burke_water_shallow_step,"burke_river_cross");
	maps\_anim::addnotetrack_customfunction("burke","aud_burke_water_exit",::aud_burke_water_exit,"burke_river_cross");
	maps\_anim::addnotetrack_customfunction("burke","aud_burke_water_footstep_left",::aud_burke_water_footstep_left,"burke_river_cross");
	maps\_anim::addnotetrack_customfunction("burke","aud_burke_water_footstep_right",::aud_burke_water_footstep_right,"burke_river_cross");
	maps\_anim::addnotetrack_customfunction("burke","aud_burke_riverbank_footstep_left",::aud_burke_riverbank_footstep_left,"burke_river_cross");
	maps\_anim::addnotetrack_customfunction("burke","aud_burke_riverbank_footstep_right",::aud_burke_riverbank_footstep_right,"burke_river_cross");
	maps\_anim::addnotetrack_customfunction("burke","aud_burke_riverbank_slide",::aud_burke_riverbank_slide,"burke_river_to_tree");
}

//Function Number: 56
aud_handle_river_progress_flags()
{
	common_scripts\utility::flag_wait("aud_player_entering_river");
	var_00 = length(level.player getvelocity());
	if(var_00 > 275)
	{
		soundscripts\_snd_playsound::snd_play_2d("river_player_splash_hvy");
	}
}

//Function Number: 57
aud_burke_water_jump(param_00)
{
	param_00 soundscripts\_snd_playsound::snd_play_delayed_linked("river_burke_splash",0.4);
}

//Function Number: 58
aud_burke_water_enter(param_00)
{
	param_00 soundscripts\_snd_playsound::snd_play_linked("river_burke_movement");
}

//Function Number: 59
aud_burke_water_deep_step(param_00)
{
}

//Function Number: 60
aud_burke_water_slip(param_00)
{
}

//Function Number: 61
aud_burke_water_fall_forward(param_00)
{
	param_00 soundscripts\_snd_playsound::snd_play_linked("river_burke_fall_forward");
}

//Function Number: 62
aud_burke_water_shallow_step(param_00)
{
}

//Function Number: 63
aud_burke_water_exit(param_00)
{
	param_00 soundscripts\_snd_playsound::snd_play_linked("river_burke_water_exit");
}

//Function Number: 64
aud_burke_water_footstep_left(param_00)
{
}

//Function Number: 65
aud_burke_water_footstep_right(param_00)
{
}

//Function Number: 66
aud_burke_riverbank_footstep_left(param_00)
{
}

//Function Number: 67
aud_burke_riverbank_footstep_right(param_00)
{
}

//Function Number: 68
aud_burke_riverbank_slide(param_00)
{
	param_00 soundscripts\_snd_playsound::snd_play_linked("lab_burke_slide_01");
}

//Function Number: 69
aud_handle_river_shallow_flag()
{
	level endon("aud_river_complete");
	for(;;)
	{
		common_scripts\utility::flag_wait("aud_river_shallow_water");
		soundscripts\_audio_mix_manager::mm_add_submix("lab_river_shallow",1.5);
		for(;;)
		{
			if(common_scripts\utility::flag("aud_river_shallow_water") == 0)
			{
				soundscripts\_audio_mix_manager::mm_clear_submix("lab_river_shallow",2);
				break;
			}

			wait(0.1);
		}

		wait(0.1);
	}
}

//Function Number: 70
forest_climb_wall_start()
{
}

//Function Number: 71
aud_forest_ambient_loops()
{
	if(level.currentgen && !istransientloaded("lab_intro_audio_tr"))
	{
		return;
	}

	var_00 = [];
	var_01 = [(-8761,5374,-125),(-8171,4923,-229),(-7729,5360,-93),(-7793,4878,-125),(-8368,5757,-39),(-8334,6698,42),(-8796,7843,136),(-9307,9345,203),(-9401,7219,110),(-9920,6863,137),(-9604,6146,163),(-9039,6273,82),(-9948,6252,64),(-10676,5843,39),(-11209,6488,166),(-12571,6420,188),(-13202,5550,110),(-13626,5622,113),(-13478,6332,123),(-14324,6694,132),(-14855,7641,65),(-15099,8229,41)];
	foreach(var_03 in var_01)
	{
		var_00[var_00.size] = common_scripts\utility::play_loopsound_in_space("emt_crickets_lp",var_03);
	}

	if(level.currentgen)
	{
		level waittill("tff_pre_intro_audio_to_middle");
		foreach(var_06 in var_00)
		{
			var_06 stoploopsound();
			var_06 delete();
		}
	}
}

//Function Number: 72
aud_burke_wall_climb()
{
	soundscripts\_audio_mix_manager::mm_add_submix("lab_wall_climb_foley_mute");
	level.burke soundscripts\_snd_playsound::snd_play_linked("wall_climb_burke");
}

//Function Number: 73
setup_gideon_climb_notetracks()
{
	if(level.currentgen && !istransientloaded("lab_intro_tr"))
	{
		return;
	}

	maps\_anim::addnotetrack_customfunction("burke","gideon_wall_cloak_on",::gideon_wall_cloak_on,"burke_says_exo_is_on");
}

//Function Number: 74
gideon_wall_cloak_on(param_00)
{
	param_00 soundscripts\_snd_playsound::snd_play_linked("wall_climb_burke_cloak_on");
}

//Function Number: 75
aud_player_wall_climb_01()
{
	soundscripts\_audio_mix_manager::mm_add_submix("player_wall_climb",0.05);
	soundscripts\_snd_playsound::snd_play_2d("wall_climb_player_01");
	wait(0.05);
	level notify("aud_river_complete");
}

//Function Number: 76
aud_player_wall_climb_02()
{
	soundscripts\_snd_playsound::snd_play_2d("wall_climb_player_02");
}

//Function Number: 77
aud_player_wall_climb_03()
{
	soundscripts\_snd_playsound::snd_play_2d("wall_climb_player_03");
}

//Function Number: 78
aud_player_wall_climb_04()
{
	soundscripts\_snd_playsound::snd_play_2d("wall_climb_player_04");
}

//Function Number: 79
aud_player_wall_climb_05()
{
	soundscripts\_snd_playsound::snd_play_2d("wall_climb_player_05");
}

//Function Number: 80
damb_animal_sfx_offset()
{
	level waittill("aud_wall_climb_done");
	soundscripts\_audio_zone_manager::azm_set_zone_dynamic_ambience("lab_ext_forest_ent","damb_ext_forest_animal",10);
}

//Function Number: 81
player_cloak_on()
{
	soundscripts\_snd::snd_music_message("player_cloak_on");
}

//Function Number: 82
wall_climb_cloak_activate()
{
	soundscripts\_snd::snd_music_message("aud_player_wall_climb_end");
	soundscripts\_snd_playsound::snd_play_2d("wall_climb_cloak_panel");
	soundscripts\_snd_playsound::snd_play_2d("wall_climb_player_last_branch");
	level.player soundscripts\_snd_playsound::snd_play_delayed_linked("wall_climb_cloak_on",1,undefined,undefined,undefined,undefined,undefined,(0,50,50));
	soundscripts\_snd_playsound::snd_play_delayed_2d("wall_climb_cloak_on_wide",1.2);
	soundscripts\_audio_mix_manager::mm_clear_submix("lab_heli_sniper");
}

//Function Number: 83
wall_climb_last_jump()
{
	soundscripts\_snd_playsound::snd_play_2d("wall_climb_player_jump_to_top");
	wait(3);
	soundscripts\_audio_mix_manager::mm_clear_submix("lab_river_foley",0.05);
	soundscripts\_audio_mix_manager::mm_clear_submix("player_wall_climb",0.05);
}

//Function Number: 84
burke_run_slide()
{
	common_scripts\utility::flag_wait("flag_search_drone_burke_anim_start");
	wait(2.5);
	level.burke soundscripts\_snd_playsound::snd_play_linked("burke_dodges_drone",undefined,undefined,undefined,undefined,(0,0,-10));
}

//Function Number: 85
drone_turn(param_00)
{
	param_00 soundscripts\_snd_playsound::snd_play_linked("atlasdrn_turn");
}

//Function Number: 86
drone_detect(param_00)
{
	param_00 soundscripts\_snd_playsound::snd_play_delayed_linked("atlasdrn_turn_02",0);
	param_00 soundscripts\_snd_playsound::snd_play_delayed_linked("atlasdrn_turn_03",1.33);
	param_00 soundscripts\_snd_playsound::snd_play_delayed_linked("atlasdrn_detect",2.23);
	param_00 soundscripts\_snd_playsound::snd_play_delayed_linked("atlasdrn_turn_04",7.63);
}

//Function Number: 87
setup_deer_notetracks()
{
	if(level.currentgen && !istransientloaded("lab_intro_tr"))
	{
		return;
	}

	maps\_anim::addnotetrack_customfunction("search_drone","dronefirstturn",::drone_turn,"search_drone");
	maps\_anim::addnotetrack_customfunction("search_drone","droneturn",::drone_detect,"search_drone");
}

//Function Number: 88
deer_sequence()
{
	var_00 = self;
	soundscripts\_audio_mix_manager::mm_add_submix("deer_moment",0.05);
	wait(16.5);
	var_00 soundscripts\_snd_playsound::snd_play_linked("deer_foliage_rustle_01");
	wait(1.5);
	var_00 soundscripts\_snd_playsound::snd_play_linked("deer_jumps_out");
	wait(0.25);
	var_00 soundscripts\_snd_playsound::snd_play_linked("deer_runs_away");
	wait(4);
	soundscripts\_audio_mix_manager::mm_clear_submix("deer_moment",0.05);
	soundscripts\_audio_mix_manager::mm_clear_submix("lab_wall_climb_foley_mute");
}

//Function Number: 89
random_dog_barks()
{
	level endon("dog_barks_stop");
	var_00 = (-8962,6119,25);
	var_01 = (-8204,7556,118);
	var_02 = (-7695,6451,67);
	var_03 = (-7820,5647,-26);
	var_04 = (-8618,5723,-26);
	var_05 = [var_00,var_01,var_02,var_03,var_04];
	var_06 = 17.6;
	for(;;)
	{
		var_07 = length(level.player getvelocity()) / var_06;
		var_08 = soundscripts\_snd::snd_map(var_07,level.aud.envs["dog_bark_percentage"]);
		if(soundscripts\_audio::aud_percent_chance(var_08))
		{
			soundscripts\_snd_playsound::snd_play_at("guard_dog_distant",var_05[randomintrange(0,var_05.size)]);
		}

		wait(1);
	}
}

//Function Number: 90
burke_slide_02()
{
	level.burke soundscripts\_snd_playsound::snd_play_linked("lab_burke_slide_02",undefined,undefined,undefined,undefined,(0,0,-25));
}

//Function Number: 91
setup_player_takedown_notetracks()
{
	if(level.currentgen && !istransientloaded("lab_intro_tr"))
	{
		return;
	}

	maps\_anim::addnotetrack_customfunction("player_rig","plyr_forest_takedown_gun_wrestle",::plyr_forest_takedown_gun_wrestle,"forest_disarm");
	maps\_anim::addnotetrack_customfunction("player_rig","plyr_forest_takedown_punch",::plyr_forest_takedown_punch,"forest_disarm");
	maps\_anim::addnotetrack_customfunction("player_rig","plyr_forest_takedown_tree_slam",::plyr_forest_takedown_tree_slam,"forest_disarm");
}

//Function Number: 92
plyr_forest_takedown_gun_wrestle(param_00)
{
	soundscripts\_snd_playsound::snd_play_2d("forest_takedown_player_grab");
}

//Function Number: 93
plyr_forest_takedown_punch(param_00)
{
	soundscripts\_snd_playsound::snd_play_2d("forest_takedown_player_punch");
}

//Function Number: 94
plyr_forest_takedown_tree_slam(param_00)
{
	soundscripts\_snd_playsound::snd_play_2d("forest_takedown_player_tree");
}

//Function Number: 95
player_forest_takedown(param_00)
{
	soundscripts\_audio_mix_manager::mm_add_submix("forest_takedown",0.05);
	soundscripts\_audio_mix_manager::mm_clear_submix("lab_river",0.05);
	thread player_forest_takedown_bad_guy_left_vox(param_00);
	param_00 soundscripts\_snd_playsound::snd_play_delayed_linked("forest_takedown_bod_fall",4.85);
}

//Function Number: 96
player_forest_takedown_bad_guy_left_vox(param_00)
{
	param_00 soundscripts\_snd_playsound::snd_play_delayed_linked("lab_gr1_takedown1react1",0.5);
	param_00 soundscripts\_snd_playsound::snd_play_delayed_linked("lab_gr11_takedown1react2",0.95);
	param_00 soundscripts\_snd_playsound::snd_play_delayed_linked("lab_gr1_takedown1react3",2.15);
}

//Function Number: 97
burke_forest_takedown(param_00)
{
	thread player_forest_takedown_bad_guy_right_vox(param_00);
	level.burke soundscripts\_snd_playsound::snd_play_delayed_linked("forest_takedown_burke_neck",5.8);
	wait(9.25);
	param_00 soundscripts\_snd_playsound::snd_play_linked("forest_takedown_burke_fall");
	level.burke soundscripts\_snd_playsound::snd_play_delayed_linked("forest_takedown_pickup_wpn",3.4,undefined,undefined,undefined,undefined,undefined,(0,0,-10));
	wait(2);
	soundscripts\_audio_mix_manager::mm_clear_submix("forest_takedown");
}

//Function Number: 98
player_forest_takedown_bad_guy_right_vox(param_00)
{
	param_00 soundscripts\_snd_playsound::snd_play_delayed_linked("lab_gr2_takedown2react1",6);
}

//Function Number: 99
takedown_01_complete()
{
}

//Function Number: 100
combat_forest_patrols_start(param_00)
{
	level endon("patrol_radios_stop");
	for(;;)
	{
		var_01 = randomintrange(5,9);
		var_02 = randomintrange(0,param_00.size);
		var_03 = param_00[var_02];
		if(isdefined(var_03))
		{
			var_03 soundscripts\_snd_playsound::snd_play_linked("random_patrol_radio");
		}

		wait(var_01);
	}
}

//Function Number: 101
aud_patrol_helo_debris_sfx()
{
	var_00 = self;
	var_01 = (0,0,-875);
}

//Function Number: 102
gaz_01_dist_by()
{
	var_00 = self;
	var_00 soundscripts\_snd_playsound::snd_play_linked("gaz_01_dist_by");
	var_00 soundscripts\_snd_playsound::snd_play_delayed_linked("gaz_01_dist_bumps",7);
}

//Function Number: 103
gaz_02_dist_by()
{
	var_00 = self;
	var_00 soundscripts\_snd_playsound::snd_play_delayed_linked("gaz_02_dist_by",7);
}

//Function Number: 104
gaz_03_close_by()
{
	var_00 = self;
	var_00 soundscripts\_snd_playsound::snd_play_linked("gaz_03_close_by");
	var_00 soundscripts\_snd_playsound::snd_play_loop_linked("gaz_dirt_crush_lp","aud_stop_dirt_crush_lp");
	var_00 soundscripts\_snd_playsound::snd_play_loop_linked("gaz_bumps_lp","aud_stop_bumps_lp");
	if(level.currentgen)
	{
		level waittill("tff_pre_intro_audio_to_middle");
		level notify("aud_stop_dirt_crush_lp");
	}
}

//Function Number: 105
flank_right_dialogue()
{
	soundscripts\_snd::snd_music_message("flank_right_dialogue");
}

//Function Number: 106
burke_solo_takedown(param_00)
{
	soundscripts\_audio_mix_manager::mm_add_submix("lab_stab_takedown_foley_mute");
	level.burke soundscripts\_snd_playsound::snd_play_delayed_linked("burke_solo_takedown_gunsling",0.5,undefined,undefined,undefined,undefined,undefined,(0,0,50));
	level.burke soundscripts\_snd_playsound::snd_play_delayed_linked("burke_solo_takedown",1.41,undefined,undefined,undefined,undefined,undefined,(0,0,50));
	param_00 soundscripts\_snd_playsound::snd_play_delayed_linked("burke_solo_takedown_fall",3.01,undefined,undefined,undefined,undefined,undefined,(0,0,-25));
	param_00 soundscripts\_snd_playsound::snd_play_delayed_linked("lab_gr3_takedown3react1",2.45);
	param_00 soundscripts\_snd_playsound::snd_play_delayed_linked("lab_gr3_takedown3react2",3.01);
	maps\_utility::delaythread(4,::gideon_knife_takedown_unmute_foley);
}

//Function Number: 107
gideon_knife_takedown_unmute_foley()
{
	soundscripts\_audio_mix_manager::mm_clear_submix("lab_stab_takedown_foley_mute");
}

//Function Number: 108
setup_npc_cloak_button_anims()
{
	if(level.currentgen && !istransientloaded("lab_intro_tr"))
	{
		return;
	}

	maps\_anim::addnotetrack_customfunction("burke","crch_lft_npc_cloak_buttons",::crch_lft_npc_cloak_buttons,"cornercrouch_left_cloak_toggle");
	maps\_anim::addnotetrack_customfunction("burke","crch_rt_npc_cloak_buttons",::crch_rt_npc_cloak_buttons,"cornercrouch_right_cloak_toggle");
	maps\_anim::addnotetrack_customfunction("burke","crch_exp_npc_cloak_buttons",::crch_exp_npc_cloak_buttons,"crouch_exposed_cloak_toggle");
}

//Function Number: 109
crch_lft_npc_cloak_buttons(param_00)
{
	param_00 soundscripts\_snd_playsound::snd_play_linked("burke_cloak_buttons_crouched");
}

//Function Number: 110
crch_rt_npc_cloak_buttons(param_00)
{
	param_00 soundscripts\_snd_playsound::snd_play_linked("burke_cloak_buttons_crouched");
}

//Function Number: 111
crch_exp_npc_cloak_buttons(param_00)
{
	param_00 soundscripts\_snd_playsound::snd_play_linked("burke_cloak_buttons_crouched");
}

//Function Number: 112
lab_brk_illtakedriver()
{
	soundscripts\_snd::snd_music_message("lab_brk_illtakedriver");
	soundscripts\_audio_mix_manager::mm_add_submix("vehicle_takedown_vo_duck");
}

//Function Number: 113
aud_vrap_mute_start(param_00,param_01)
{
	var_02 = self;
	soundscripts\_snd_playsound::snd_play_delayed_2d("mute_device_activate",0.5);
	wait(1.25);
	soundscripts\_audio_mix_manager::mm_add_submix("lab_vrap_mute_device",0.05);
	var_02 thread soundscripts\_snd_common::snd_mute_device("mute_device",param_00,param_00 + 250,param_01,"mute_device");
	var_02 thread aud_stop_vrap_mute_device();
}

//Function Number: 114
aud_stop_vrap_mute_device()
{
	level waittill("aud_vehicle_takedown_complete");
	self notify("turn_off");
	soundscripts\_audio_mix_manager::mm_clear_submix("lab_vrap_mute_device",2);
}

//Function Number: 115
truck_takedown_radio(param_00)
{
	soundscripts\_audio_mix_manager::mm_add_submix("truck_takedown",0.05);
	wait(3);
	var_01 = param_00 soundscripts\_snd_playsound::snd_play_linked("truck_takedown_radio",undefined,undefined,undefined,undefined,(0,0,60));
	level waittill("kill_radio");
	param_00 soundscripts\_snd_playsound::snd_play_delayed_linked("lab_gr4_takedown4react1",0.8);
	param_00 soundscripts\_snd_playsound::snd_play_delayed_linked("lab_gr4_takedown4react2",2.1);
	level.burke soundscripts\_snd_playsound::snd_play_delayed_linked("lab_gr5_takedown5react1",3.4);
	wait(0.5);
	if(isdefined(var_01))
	{
		var_01 scalevolume(0,0.05);
	}
}

//Function Number: 116
truck_takedown()
{
	thread truck_takedown_burke();
	level notify("kill_radio");
	soundscripts\_snd_playsound::snd_play_2d("truck_takedown_player");
	var_00 = spawn("script_origin",(-9001,7208,60));
	var_00 soundscripts\_snd_playsound::snd_play_delayed_linked("truck_player_door_close",7);
	common_scripts\utility::flag_wait("truck_takedown_burke_done");
	soundscripts\_audio_mix_manager::mm_clear_submix("truck_takedown",0.05);
}

//Function Number: 117
truck_takedown_burke()
{
	level.burke soundscripts\_snd_playsound::snd_play_delayed_linked("truck_takedown_door_open",2,undefined,undefined,undefined,undefined,undefined,(0,0,50));
	wait(3.25);
	level.burke soundscripts\_snd_playsound::snd_play_linked("truck_takedown_burke",undefined,undefined,undefined,undefined,(0,0,50));
	wait(2);
	level notify("aud_vehicle_takedown_complete");
	wait(1.85);
	var_00 = level.burke soundscripts\_snd_playsound::snd_play_linked("truck_takedown_door_close");
	while(isdefined(var_00))
	{
		wait(0.5);
	}

	common_scripts\utility::flag_set("truck_takedown_burke_done");
}

//Function Number: 118
takedown_truck_lights_off()
{
	soundscripts\_snd_playsound::snd_play_at("truck_takedown_lights_off",(-8997,7138,70));
}

//Function Number: 119
vehicle_takedown_01_complete()
{
	soundscripts\_snd::snd_music_message("vehicle_takedown_01_complete");
	soundscripts\_audio_mix_manager::mm_clear_submix("vehicle_takedown_vo_duck");
}

//Function Number: 120
gaz_04_slow_by()
{
	var_00 = self;
	var_00 soundscripts\_snd_playsound::snd_play_linked("gaz_04_slow_by");
	var_00 soundscripts\_snd_playsound::snd_play_loop_linked("gaz_dirt_crush_close_lp","aud_stop_dirt_crush_lp");
	var_00 soundscripts\_snd_playsound::snd_play_loop_linked("gaz_bumps_close_lp","aud_stop_bumps_lp");
	if(level.currentgen)
	{
		level waittill("tff_pre_intro_audio_to_middle");
		level notify("aud_stop_dirt_crush_lp");
	}
}

//Function Number: 121
gaz_05_slow_by()
{
	var_00 = self;
	var_00 soundscripts\_snd_playsound::snd_play_delayed_linked("gaz_05_slow_by",10);
	var_00 soundscripts\_snd_playsound::snd_play_loop_linked("gaz_dirt_crush_close_lp","aud_stop_dirt_crush_lp");
	var_00 soundscripts\_snd_playsound::snd_play_loop_linked("gaz_bumps_close_lp","aud_stop_bumps_lp");
	if(level.currentgen)
	{
		level waittill("tff_pre_intro_audio_to_middle");
		level notify("aud_stop_dirt_crush_lp");
	}
}

//Function Number: 122
forest_mech_spawn()
{
	wait(2.5);
	soundscripts\_snd::snd_music_message("mus_forest_mech_march");
}

//Function Number: 123
skr_distant_pull_up_and_scan()
{
	var_00 = self;
	var_00 soundscripts\_snd_playsound::snd_play_linked("seeker_pullup_stop");
	var_00 soundscripts\_snd_playsound::snd_play_loop_linked("seeker_bumps_lp","aud_stop_bumps_lp");
	var_00 soundscripts\_snd_playsound::snd_play_delayed_linked("seeker_tire_skid",5.4);
	wait(5);
	level notify("aud_stop_bumps_lp");
}

//Function Number: 124
start_seeker_audio()
{
	if(level.currentgen && !istransientloaded("lab_intro_audio_tr"))
	{
		return;
	}

	var_00 = self;
	var_01 = soundscripts\_snd_playsound::snd_play_loop_at("seeker_scan_lp",var_00.origin,"",0.4);
	var_00 thread monitor_seeker_pos(var_01);
	var_00 thread stop_seeker_audio(var_01);
	if(level.currentgen)
	{
		level waittill("tff_pre_intro_audio_to_middle");
		var_01 soundscripts\_snd_playsound::snd_stop_sound();
	}
}

//Function Number: 125
stop_seeker_audio(param_00)
{
	self waittill("stop_seeker_audio");
	param_00 soundscripts\_snd_playsound::snd_stop_sound();
}

//Function Number: 126
monitor_seeker_pos(param_00)
{
	var_01 = self;
	var_01 endon("stop_seeker_audio");
	for(;;)
	{
		var_01 waittill("update_seeker_audio",var_02);
		param_00.origin = var_02;
	}
}

//Function Number: 127
start_fixed_scanner_audio()
{
	if(level.currentgen && !istransientloaded("lab_middle_tr"))
	{
		level waittill("tff_post_intro_to_middle");
	}

	var_00 = self;
	var_01 = soundscripts\_snd::snd_new_guid();
	var_02 = "stop_scan_notify" + var_01;
	var_03 = "stop_alert_notify" + var_01;
	var_00 thread monitor_fixed_scanner_explode(var_02,var_03);
	var_00 monitor_fixed_scanner(var_02,var_03);
	level notify(var_02);
	level notify(var_03);
}

//Function Number: 128
monitor_fixed_scanner(param_00,param_01)
{
	var_02 = self;
	var_02 endon("stop_fixed_scanner_audio");
	var_02 endon("death");
	level endon("kill_all_scanner_audio");
	var_02 soundscripts\_snd_playsound::snd_play_loop_linked("fixed_camera_scan",param_00);
	for(;;)
	{
		var_02 waittill("update_fixed_scanner_audio",var_03);
		if(var_03)
		{
			level notify(param_00);
			var_02 soundscripts\_snd_playsound::snd_play_loop_linked("fixed_camera_alert",param_01);
			continue;
		}

		level notify(param_01);
		var_02 soundscripts\_snd_playsound::snd_play_loop_linked("fixed_camera_scan",param_00);
	}
}

//Function Number: 129
monitor_fixed_scanner_explode(param_00,param_01)
{
	var_02 = self;
	level endon("kill_all_scanner_audio");
	var_03 = var_02.origin;
	var_02 common_scripts\utility::waittill_any("death","stop_fixed_scanner_audio");
	level notify(param_00);
	level notify(param_01);
	soundscripts\_snd_playsound::snd_play_at("fixed_camera_explode",var_03);
}

//Function Number: 130
seeker_clear()
{
	soundscripts\_snd::snd_music_message("seeker_clear");
}

//Function Number: 131
aud_handle_clearing_dambs()
{
	level waittill("aud_start_clearing_damb");
	soundscripts\_audio_dynamic_ambi::damb_start_preset_at_point("damb_ext_clearing_birds",(-15522,8176,391));
	soundscripts\_audio_dynamic_ambi::damb_start_preset_at_point("damb_ext_clearing_birds",(-14805,8244,300));
	level waittill("aud_stop_clearing_damb");
	soundscripts\_audio_dynamic_ambi::damb_stop_preset("damb_ext_clearing_birds",3);
	level waittill("cliff_rappel_landing");
	soundscripts\_audio_dynamic_ambi::damb_start_preset_at_point("damb_ext_forest_animal",level.player.origin);
	level waittill("aud_stop_forest_ext_damb");
	soundscripts\_audio_dynamic_ambi::damb_stop_preset("damb_ext_forest_animal",3);
}

//Function Number: 132
aud_burke_nearing_cliff()
{
	level.burke soundscripts\_snd_playsound::snd_play_linked("meetup_burke_nearing_cliff");
	soundscripts\_audio_mix_manager::mm_add_submix("lab_ext_cliff_scene");
}

//Function Number: 133
setup_cormack_meetup_scene_notetracks()
{
	if(level.currentgen && !istransientloaded("lab_intro_tr"))
	{
		return;
	}

	maps\_anim::addnotetrack_customfunction("cormack","aud_cormack_approach",::aud_cormack_approach,"cliff_meetup");
	maps\_anim::addnotetrack_customfunction("knox","aud_knox_keypad",::aud_knox_keypad,"cliff_meetup");
	maps\_anim::addnotetrack_customfunction("cormack","aud_cormack_rappel_cable",::aud_cormack_rappel_cable,"cliff_meetup");
}

//Function Number: 134
aud_cormack_approach(param_00)
{
	level.cormack soundscripts\_snd_playsound::snd_play_delayed_linked("meetup_foley_cormack_01",0.05);
	level.burke soundscripts\_snd_playsound::snd_play_delayed_linked("meetup_foley_burke_01",0.25);
	level.knox soundscripts\_snd_playsound::snd_play_delayed_linked("meetup_foley_knox_01",2.55);
	level.knox soundscripts\_snd_playsound::snd_play_delayed_linked("meetup_foley_knox_02",21);
}

//Function Number: 135
aud_knox_keypad(param_00)
{
	level.cormack soundscripts\_snd_playsound::snd_play_delayed_linked("meetup_foley_cormack_02",0.75);
}

//Function Number: 136
aud_cormack_rappel_cable(param_00)
{
	level.cormack soundscripts\_snd_playsound::snd_play_delayed_linked("meetup_foley_cormack_03",0.1);
	level.knox soundscripts\_snd_playsound::snd_play_delayed_linked("meetup_foley_knox_03",0.25);
	level.burke soundscripts\_snd_playsound::snd_play_delayed_linked("meetup_foley_burke_02",3.8);
	level.knox soundscripts\_snd_playsound::snd_play_delayed_linked("rappel_knox_hookup",4.55);
}

//Function Number: 137
aud_rappel_player_hookup()
{
	wait(0.65);
	level.player soundscripts\_snd_playsound::snd_play_delayed_linked("rappel_player_hookup",0);
	level.burke soundscripts\_snd_playsound::snd_play_delayed_linked("rappel_burke_jump",8.9);
	level.player soundscripts\_snd_playsound::snd_play_delayed_linked("rappel_player_jump",10.65);
	level.player soundscripts\_snd_playsound::snd_play_delayed_linked("rappel_gust",12.85);
	level.burke soundscripts\_snd_playsound::snd_play_delayed_linked("rappel_burke_descend",15.05);
}

//Function Number: 138
aud_rappel_player_movement_start(param_00)
{
	if(!level.aud.rope_started)
	{
		level.aud.rope_started = 1;
		if(!isdefined(level.aud.ropesound))
		{
			level.aud.ropesound = spawn("script_origin",level.player.origin);
			level.aud.ropesound soundscripts\_snd_playsound::snd_play_loop("rappel_player_descend_lp");
			param_00 thread aud_watch_for_anim_end();
		}

		level.player soundscripts\_snd_playsound::snd_play("rappel_player_descend_start");
		level.aud.ropesound scalevolume(1,0.5);
		level.aud.ropesound scalepitch(1,2);
		var_01 = param_00 common_scripts\utility::waittill_any_return("start_cliff_jump","aud_faded_loop");
		if(var_01 == "start_cliff_jump")
		{
			if(isdefined(level.aud.ropesound))
			{
				level.aud.ropesound scalevolume(0,0.15);
				level.aud.ropesound scalepitch(0.5,0.15);
			}

			level.player soundscripts\_snd_playsound::snd_play("rappel_player_land");
		}
	}
}

//Function Number: 139
aud_watch_for_anim_end()
{
	for(;;)
	{
		var_00 = self getanimtime(level.scr_anim["player_rig"]["cliff_jump"]);
		if(var_00 > 0.94)
		{
			self notify("start_cliff_jump");
			return;
		}

		wait 0.05;
	}
}

//Function Number: 140
aud_rappel_player_movement_stop(param_00)
{
	if(level.aud.rope_started)
	{
		level.aud.rope_started = 0;
		level.player soundscripts\_snd_playsound::snd_play("rappel_player_descend_stop");
		if(isdefined(level.aud.ropesound))
		{
			level.aud.ropesound scalevolume(0,0.05);
			level.aud.ropesound scalepitch(0.5,0.05);
			wait(0.05);
			param_00 notify("aud_faded_loop");
		}
	}
}

//Function Number: 141
aud_player_rappel_complete()
{
	soundscripts\_audio_mix_manager::mm_clear_submix("lab_ext_cliff_scene");
	if(isdefined(level.aud.ropesound))
	{
		level.aud.ropesound scalevolume(0,0.05);
		level.aud.ropesound scalepitch(0.5,0.05);
		wait(0.05);
		if(isdefined(level.aud.ropesound))
		{
			level.aud.ropesound stoploopsound();
			wait(0.05);
			if(isdefined(level.aud.ropesound))
			{
				level.aud.ropesound delete();
				return;
			}
		}
	}
}

//Function Number: 142
lab_mute_gun_holster()
{
	soundscripts\_snd_playsound::snd_play_2d("wpn_med_holster_plr");
}

//Function Number: 143
aud_facility_breach_start()
{
	level notify("aud_stop_forest_ext_damb");
	var_00 = self;
	level.player enablecustomweaponcontext();
	soundscripts\_snd_common::snd_enable_soundcontextoverride("mute");
	soundscripts\_snd_playsound::snd_play_delayed_2d("mute_device_activate",0.5);
	soundscripts\_snd_playsound::snd_play_delayed_2d("mute_device_step_back",1.5);
	soundscripts\_snd_playsound::snd_play_delayed_2d("mute_device_breach_plant",4.2);
	soundscripts\_snd_playsound::snd_play_delayed_2d("mute_device_breach_exp",9.65);
	wait(1.25);
	soundscripts\_audio_mix_manager::mm_add_submix("lab_facility_breach",0.05);
	var_00 thread soundscripts\_snd_common::snd_mute_device("mute_device",350,600,40,"mute_device");
	var_00 thread aud_stop_mute_device_for_vo();
	wait(8);
	soundscripts\_audio_mix_manager::mm_clear_submix("lab_facility_breach",3);
}

//Function Number: 144
aud_stop_mute_device_for_vo()
{
	level waittill("flag_post_breach_patrol");
	self notify("turn_off");
	soundscripts\_snd_common::snd_disable_soundcontextoverride("mute");
	level.player disablecustomweaponcontext();
}

//Function Number: 145
aud_lab_ambient_emitters()
{
	if(level.currentgen && !istransientloaded("lab_middle_tr"))
	{
		level waittill("tff_post_intro_to_middle");
	}

	var_00 = spawn("script_origin",(-14293,12048,-1336));
	var_01 = spawn("script_origin",(-14278,11609,-1322));
	var_02 = spawn("script_origin",(-14346,11610,-1322));
	var_03 = spawn("script_origin",(-14454,11538,-1322));
	var_04 = spawn("script_origin",(-13909,11329,-1322));
	var_05 = spawn("script_origin",(-13962,11329,-1322));
	var_06 = spawn("script_origin",(-13925,11570,-1263));
	var_07 = spawn("script_origin",(-13801,11293,-1263));
	var_08 = spawn("script_origin",(-14280,11297,-1263));
	var_09 = spawn("script_origin",(-14044,12307,-1318));
	var_0A = spawn("script_origin",(-13990,11552,-1314));
	var_0B = spawn("script_origin",(-13600,11500,-1268));
	var_0C = spawn("script_origin",(-14343,12604,-1322));
	var_0D = spawn("script_origin",(-14335,11846,-1264));
	var_0E = spawn("script_origin",(-13878,11846,-1264));
	var_0F = spawn("script_origin",(-13902,12387,-1323));
	var_10 = spawn("script_origin",(-13538,11354,-1275));
	var_11 = spawn("script_origin",(-13506,11915,-1136));
	var_00 thread soundscripts\_snd_playsound::snd_play_loop_linked("lab_computer_01","aud_stop_lab_amb_emits",0.3,undefined,1);
	var_01 thread soundscripts\_snd_playsound::snd_play_loop_linked("lab_electromech_01","aud_stop_lab_amb_emits",0.3,undefined,1);
	var_02 thread soundscripts\_snd_playsound::snd_play_loop_linked("lab_electromech_02","aud_stop_lab_amb_emits",0.3,undefined,1);
	var_03 thread soundscripts\_snd_playsound::snd_play_loop_linked("lab_electromech_03","aud_stop_lab_amb_emits",0.3,undefined,1);
	var_04 thread soundscripts\_snd_playsound::snd_play_loop_linked("lab_electromech_04","aud_stop_lab_amb_emits",0.3,undefined,1);
	var_05 thread soundscripts\_snd_playsound::snd_play_loop_linked("lab_electromech_05","aud_stop_lab_amb_emits",0.3,undefined,1);
	var_06 thread soundscripts\_snd_playsound::snd_play_loop_linked("lab_ventilation_01","aud_stop_lab_amb_emits",0.3,undefined,1);
	var_07 thread soundscripts\_snd_playsound::snd_play_loop_linked("lab_ventilation_02","aud_stop_lab_amb_emits",0.3,undefined,1);
	var_08 thread soundscripts\_snd_playsound::snd_play_loop_linked("lab_ventilation_03","aud_stop_lab_amb_emits",0.3,undefined,1);
	var_09 thread soundscripts\_snd_playsound::snd_play_loop_linked("lab_transformer_01","aud_stop_lab_amb_emits",0.3,undefined,1);
	var_0A thread soundscripts\_snd_playsound::snd_play_loop_linked("lab_transformer_02","aud_stop_lab_amb_emits",0.3,undefined,1);
	var_0B thread soundscripts\_snd_playsound::snd_play_loop_linked("lab_transformer_03","aud_stop_lab_amb_emits",0.3,undefined,1);
	var_0C thread soundscripts\_snd_playsound::snd_play_loop_linked("lab_ventilation_04","aud_stop_lab_amb_emits",0.3,undefined,1);
	var_0D thread soundscripts\_snd_playsound::snd_play_loop_linked("lab_ventilation_05","aud_stop_lab_amb_emits",0.3,undefined,1);
	var_0E thread soundscripts\_snd_playsound::snd_play_loop_linked("lab_ventilation_06","aud_stop_lab_amb_emits",0.3,undefined,1);
	var_0F thread soundscripts\_snd_playsound::snd_play_loop_linked("lab_ventilation_01","aud_stop_lab_amb_emits",0.3,undefined,1);
	var_10 thread soundscripts\_snd_playsound::snd_play_loop_linked("lab_occluded_machine_hum_01","aud_stop_lab_amb_emits",0.3,undefined,1);
	var_11 thread soundscripts\_snd_playsound::snd_play_loop_linked("lab_occluded_machine_hum_02","aud_stop_lab_amb_emits",0.3,undefined,1);
	thread aud_lab_phone_wait();
	if(level.currentgen)
	{
		level waittill("tff_pre_middle_to_outro");
		level notify("aud_stop_lab_amb_emits");
	}
}

//Function Number: 146
aud_lab_phone_wait()
{
	common_scripts\utility::flag_wait("aud_lab_phone_start");
	for(var_00 = 0;var_00 <= 3;var_00++)
	{
		soundscripts\_snd_playsound::snd_play_at("lab_phone_next_door",(-13739,11640,-1320));
		wait(2.5);
	}
}

//Function Number: 147
aud_server_room_door_crack()
{
	if(level.currentgen && !istransientloaded("lab_middle_tr"))
	{
		level waittill("tff_post_intro_to_middle");
	}

	wait(1);
	soundscripts\_snd_playsound::snd_play_at("server_door_crack",(-13695,11854,-1062));
	var_00 = "server_room_pt_src_snds_1";
	var_01 = "server_room_pt_src_snds_2";
	var_02 = 0.3;
	var_03 = 2;
	var_04 = (-13695,11854,-1083);
	var_05 = (-14421,12070,-1083);
	var_06 = (-13881,11949,-1062);
	var_07 = (-14274,11638,-1062);
	var_08 = (-13975,11639,-1062);
	var_09 = (-14198,11945,-1143);
	var_0A = (-14442,11630,-1143);
	var_0B = (-14198,11945,-1143);
	var_0C = (-14442,11630,-1143);
	var_0D = (-14305,12011,-1143);
	var_0E = (-13926,11638,-1143);
	var_0F = (-14198,11646,-1143);
	var_10 = (-14326,11644,-1143);
	soundscripts\_snd_playsound::snd_play_loop_at("server_light_hum_01",var_04,var_00,var_02,0);
	soundscripts\_snd_playsound::snd_play_loop_at("server_light_hum_02",var_05,var_00,var_02,0);
	soundscripts\_snd_playsound::snd_play_loop_at("server_vent_01",var_06,var_00,var_02,0);
	soundscripts\_snd_playsound::snd_play_loop_at("server_vent_02",var_07,var_00,var_02,0);
	soundscripts\_snd_playsound::snd_play_loop_at("server_vent_03",var_08,var_00,var_02,0);
	soundscripts\_snd_playsound::snd_play_loop_at("server_machine_purr_01",var_09,var_01,var_02,var_03);
	soundscripts\_snd_playsound::snd_play_loop_at("server_machine_purr_02",var_0A,var_01,var_02,var_03);
	soundscripts\_snd_playsound::snd_play_loop_at("server_data_center_01",var_0B,var_01,var_02,var_03);
	soundscripts\_snd_playsound::snd_play_loop_at("server_data_center_02",var_0C,var_01,var_02,var_03);
	soundscripts\_snd_playsound::snd_play_loop_at("server_data_center_03",var_0D,var_01,var_02,var_03);
	soundscripts\_snd_playsound::snd_play_loop_at("server_computer_screen_01",var_0E,var_01,var_02,var_03);
	soundscripts\_snd_playsound::snd_play_loop_at("server_computer_screen_02",var_0F,var_01,var_02,var_03);
	soundscripts\_snd_playsound::snd_play_loop_at("server_computer_screen_01",var_10,var_01,var_02,var_03);
	common_scripts\utility::flag_wait("flag_obj_bio_weapons_hack");
	wait(23.5);
	thread aud_server_room_thermite();
	wait(3);
	level notify(var_01);
	if(level.currentgen)
	{
		level waittill("tff_pre_middle_to_outro");
		level notify(var_00);
	}
}

//Function Number: 148
aud_server_room_door_kick()
{
}

//Function Number: 149
aud_server_room_door_enter()
{
	wait(1);
}

//Function Number: 150
setup_server_room_scene_notetracks()
{
	if(level.currentgen && !istransientloaded("lab_middle_tr"))
	{
		level waittill("tff_post_intro_to_middle");
	}

	maps\_anim::addnotetrack_customfunction("player_rig","aud_player_computer",::aud_player_computer,"server_room_exit");
	maps\_anim::addnotetrack_customfunction("knox","aud_knox_thermite",::aud_knox_thermite,"server_room_exit");
	maps\_anim::addnotetrack_customfunction("cormack","aud_cormack_monitor_smash",::aud_cormack_final_monitor_smash,"server_room_exit");
	maps\_anim::addnotetrack_customfunction("cormack","cormack_smash_monitor_01",::cormack_smash_monitor_01,"server_room_exit");
	maps\_anim::addnotetrack_customfunction("cormack","cormack_smash_monitor_02",::cormack_smash_monitor_02,"server_room_exit");
	maps\_anim::addnotetrack_customfunction("player_rig","aud_player_computer",::aud_player_computer_promo,"server_room_exit_promo");
	maps\_anim::addnotetrack_customfunction("knox","aud_knox_thermite",::aud_knox_thermite_promo,"server_room_exit_promo");
	maps\_anim::addnotetrack_customfunction("cormack","aud_cormack_monitor_smash_promo",::aud_cormack_monitor_smash_promo,"server_room_exit_promo");
	maps\_anim::addnotetrack_customfunction("cormack","aud_cormack_final_smash_promo",::aud_cormack_final_smash_promo,"server_room_exit_promo");
}

//Function Number: 151
aud_player_computer(param_00)
{
	soundscripts\_snd_playsound::snd_play_2d("server_player_monitor_move");
}

//Function Number: 152
aud_player_computer_gl_timing_fix()
{
	level.player soundscripts\_snd_playsound::snd_play_delayed_linked("server_player_interact",0.45);
	level.player soundscripts\_snd_playsound::snd_play_delayed_linked("server_footsteps_in",1.05);
}

//Function Number: 153
aud_knox_thermite(param_00)
{
	level.player soundscripts\_snd_playsound::snd_play_delayed_linked("server_monitor_smashing",0.25);
	level.player soundscripts\_snd_playsound::snd_play_delayed_linked("server_player_step_back",7.25);
}

//Function Number: 154
cormack_smash_monitor_01(param_00)
{
	param_00 soundscripts\_snd_playsound::snd_play_linked("server_crmk_smash_01");
}

//Function Number: 155
cormack_smash_monitor_02(param_00)
{
	param_00 soundscripts\_snd_playsound::snd_play_linked("server_crmk_smash_02");
}

//Function Number: 156
aud_cormack_final_monitor_smash(param_00)
{
}

//Function Number: 157
aud_player_computer_promo(param_00)
{
}

//Function Number: 158
aud_knox_thermite_promo(param_00)
{
	level.player soundscripts\_snd_playsound::snd_play_delayed_linked("server_player_step_back",7.25);
}

//Function Number: 159
aud_cormack_monitor_smash_promo(param_00)
{
	soundscripts\_audio_mix_manager::mm_add_submix("lab_server_promo_smash");
	level.player soundscripts\_snd_playsound::snd_play_2d("server_promo_monitor_smashing");
	wait(5);
	soundscripts\_audio_mix_manager::mm_add_submix("lab_server_promo",5);
}

//Function Number: 160
aud_cormack_final_smash_promo(param_00)
{
	level.player soundscripts\_snd_playsound::snd_play_2d("server_promo_final_smash");
	soundscripts\_audio_mix_manager::mm_clear_submix("lab_server_promo",8);
	soundscripts\_audio_mix_manager::mm_clear_submix("lab_server_promo_smash",8);
}

//Function Number: 161
aud_server_room_thermite()
{
	thread aud_server_thermite_out();
	thread aud_server_thermite_burn_start();
	thread aud_server_thermite_burn_loop();
}

//Function Number: 162
aud_server_thermite_out()
{
	soundscripts\_snd_playsound::snd_play_at("server_thermite_throw_01",(-14237,11851,-1148));
	wait(4);
	soundscripts\_snd_playsound::snd_play_at("server_thermite_throw_02",(-14274,11867,-1148));
}

//Function Number: 163
aud_server_thermite_burn_start()
{
	wait(9);
	level.player soundscripts\_snd_playsound::snd_play_linked("server_thermite_flames_start");
	wait(0.5);
	soundscripts\_snd_playsound::snd_play_at("server_data_center_burn_electrical_02",(-14339,11949,-1183));
	soundscripts\_snd_filters::snd_fade_in_filter("lab_alarm_occlusion",0.5);
	start_interior_alarms();
	wait(3);
	soundscripts\_snd_playsound::snd_play_at("server_data_center_burn_electrical_01",(-14403,11671,-1183));
}

//Function Number: 164
aud_server_thermite_burn_loop()
{
	var_00 = "aud_server_thermite_burn_loop";
	var_01 = 1;
	var_02 = 1.5;
	var_03 = (-14211,11909,-1183);
	var_04 = (-14339,11949,-1183);
	var_05 = (-14403,11671,-1183);
	soundscripts\_snd_playsound::snd_play_loop_at("server_data_center_burn_lp_01",var_03,var_00,var_01,var_02);
	wait(22.5);
	soundscripts\_snd_playsound::snd_play_loop_at("server_data_center_burn_lp_02",var_04,var_00,var_01,var_02);
	wait(2);
	soundscripts\_snd_playsound::snd_play_loop_at("server_data_center_burn_lp_03",var_05,var_00,var_01,var_02);
	common_scripts\utility::flag_wait("vfx_server_room_exit");
	wait(14);
	level notify(var_00);
}

//Function Number: 165
aud_foam_room_emitters()
{
	if(level.currentgen && !istransientloaded("lab_middle_tr"))
	{
		level waittill("tff_post_intro_to_middle");
	}

	var_00 = (-11120,15628,-1266);
	var_01 = (-11120,15072,-1266);
	var_02 = (-11120,15337,-1266);
	var_03 = (-11492,15947,-1266);
	var_04 = (-11492,15224,-1266);
	var_05 = (-11266,15826,-1332);
	var_06 = (-11845,15892,-1283);
	var_07 = "aud_server_thermite_burn_loop";
	var_08 = 0.3;
	soundscripts\_snd_playsound::snd_play_loop_at("locker_rm_ventilation_01",var_00,var_07,var_08);
	soundscripts\_snd_playsound::snd_play_loop_at("locker_rm_ventilation_02",var_01,var_07,var_08);
	soundscripts\_snd_playsound::snd_play_loop_at("locker_rm_ventilation_03",var_02,var_07,var_08);
	soundscripts\_snd_playsound::snd_play_loop_at("foam_rm_large_ventilation_01",var_03,var_07,var_08);
	soundscripts\_snd_playsound::snd_play_loop_at("foam_rm_large_ventilation_02",var_04,var_07,var_08);
	soundscripts\_snd_playsound::snd_play_loop_at("foam_rm_large_ventilation_03",var_05,var_07,var_08);
	soundscripts\_snd_playsound::snd_play_loop_at("foam_rm_computer_01",var_06,var_07,var_08);
	if(level.currentgen)
	{
		level waittill("tff_pre_middle_to_outro");
		level notify(var_07);
	}
}

//Function Number: 166
aud_post_courtyard_emitters()
{
	var_00 = spawn("script_origin",(-12753,10939,-1245));
	var_01 = spawn("script_origin",(-12963,10956,-1256));
	var_02 = spawn("script_origin",(-11863,11300,-1256));
	var_03 = spawn("script_origin",(-11412,11044,-1149));
	var_04 = spawn("script_origin",(-11667,10866,-1034));
	thread aud_balcony_aircraft_wait();
	var_05 = spawn("script_origin",(-11017,10329,-1006));
	var_06 = spawn("script_origin",(-11526,10305,-862));
	var_07 = spawn("script_origin",(-11404,9942,-1007));
	var_08 = spawn("script_origin",(-11049,9586,-1075));
	var_09 = spawn("script_origin",(-12409,9438,-1244));
	var_0A = spawn("script_origin",(-12193,9033,-1263));
	var_0B = spawn("script_origin",(-12200,9594,-1254));
	var_0C = spawn("script_origin",(-12788,8695,-1055));
	var_0D = spawn("script_origin",(-13226,9027,-1075));
	var_0E = spawn("script_origin",(-12164,9970,-1075));
	var_0F = spawn("script_origin",(-12062,9618,-1231));
	var_10 = spawn("script_origin",(-13244,9199,-1223));
	var_11 = spawn("script_origin",(-13244,9389,-1223));
	var_12 = spawn("script_origin",(-12429,9680,-1123));
	var_13 = spawn("script_origin",(-12429,9101,-1123));
	var_14 = spawn("script_origin",(-12815,8943,-1153));
	var_15 = spawn("script_origin",(-13074,9282,-1257));
	var_16 = spawn("script_origin",(-12932,8798,-1245));
	var_17 = spawn("script_origin",(-12612,8798,-1245));
	var_18 = spawn("script_origin",(-12294,8588,-1200));
	var_19 = spawn("script_origin",(-13189,9585,-1250));
	var_1A = spawn("script_origin",(-12295,9360,-1174));
	var_1B = spawn("script_origin",(-12405,9439,-1174));
	var_1C = spawn("script_origin",(-12307,9516,-1174));
	var_00 thread soundscripts\_snd_playsound::snd_play_loop_linked("lab_electromech_06",undefined,0.3,undefined,1);
	var_01 thread soundscripts\_snd_playsound::snd_play_loop_linked("post_courtyard_turbine_01",undefined,0.3,undefined,1);
	var_02 thread soundscripts\_snd_playsound::snd_play_loop_linked("post_courtyard_turbine_02",undefined,0.3,undefined,1);
	var_03 thread soundscripts\_snd_playsound::snd_play_loop_linked("post_courtyard_ventilation_01",undefined,0.3,undefined,1);
	var_04 thread soundscripts\_snd_playsound::snd_play_loop_linked("post_courtyard_turbine_03",undefined,0.3,undefined,1);
	var_05 thread soundscripts\_snd_playsound::snd_play_loop_linked("balcony_left",undefined,0.3,undefined,1);
	var_06 thread soundscripts\_snd_playsound::snd_play_loop_linked("balcony_right",undefined,0.3,undefined,1);
	var_07 thread soundscripts\_snd_playsound::snd_play_loop_linked("post_courtyard_ventilation_02",undefined,0.3,undefined,1);
	var_08 thread soundscripts\_snd_playsound::snd_play_loop_linked("post_courtyard_turbine_05",undefined,0.3,undefined,1);
	var_0C thread soundscripts\_snd_playsound::snd_play_loop_linked("post_courtyard_turbine_04",undefined,0.3,undefined,1);
	var_0D thread soundscripts\_snd_playsound::snd_play_loop_linked("post_courtyard_ventilation_03",undefined,0.3,undefined,1);
	var_0E thread soundscripts\_snd_playsound::snd_play_loop_linked("post_courtyard_ventilation_01",undefined,0.3,undefined,1);
	if(level.currentgen && !istransientloaded("lab_outro_tr"))
	{
		level waittill("tff_post_middle_to_outro");
	}

	var_09 thread soundscripts\_snd_playsound::snd_play_loop_linked("hangar_comp_close_02",undefined,0.3,undefined,1);
	var_0A thread soundscripts\_snd_playsound::snd_play_loop_linked("hangar_comp_close_01",undefined,0.3,undefined,1);
	var_0B thread soundscripts\_snd_playsound::snd_play_loop_linked("hangar_comp_close_01",undefined,0.3,undefined,1);
	var_0F thread soundscripts\_snd_playsound::snd_play_loop_linked("hangar_computer_01",undefined,0.3,undefined,1);
	var_10 thread soundscripts\_snd_playsound::snd_play_loop_linked("hangar_computer_02",undefined,0.3,undefined,1);
	var_11 thread soundscripts\_snd_playsound::snd_play_loop_linked("hangar_computer_03",undefined,0.3,undefined,1);
	common_scripts\utility::flag_wait("aud_hangar_light_hum_start");
	var_12 thread soundscripts\_snd_playsound::snd_play_loop_linked("hangar_light_hum_01",undefined,6,undefined,1);
	var_13 thread soundscripts\_snd_playsound::snd_play_loop_linked("hangar_light_hum_02",undefined,6,undefined,1);
	var_14 thread soundscripts\_snd_playsound::snd_play_loop_linked("hangar_small_electromech_01",undefined,0.1,undefined,1);
	var_15 thread soundscripts\_snd_playsound::snd_play_loop_linked("hangar_small_electromech_02",undefined,0.1,undefined,1);
	var_16 thread soundscripts\_snd_playsound::snd_play_loop_linked("hangar_ventilation_01",undefined,1,undefined,1);
	var_17 thread soundscripts\_snd_playsound::snd_play_loop_linked("hangar_ventilation_02",undefined,1,undefined,1);
	var_18 thread soundscripts\_snd_playsound::snd_play_loop_linked("hangar_transformer_01",undefined,0.1,undefined,1);
	var_19 thread soundscripts\_snd_playsound::snd_play_loop_linked("hangar_transformer_02",undefined,0.1,undefined,1);
	var_1A thread soundscripts\_snd_playsound::snd_play_loop_linked("hangar_comp_low_drone",undefined,1,undefined,1);
	var_1B thread soundscripts\_snd_playsound::snd_play_loop_linked("hangar_comp_high_drone",undefined,1,undefined,1);
	var_1A setpitch(0.5);
	var_1B setpitch(0.4);
	wait 0.05;
	var_1A scalepitch(1,4);
	var_1B scalepitch(1,2.5);
	wait(1);
	var_1C thread soundscripts\_snd_playsound::snd_play_loop_linked("hangar_comp_bg",undefined,5,undefined,1);
	common_scripts\utility::flag_wait("flag_hovertank_reveal_scene_started");
	wait(4);
	var_0C scalevolume(0.1,4);
	var_0D scalevolume(0.1,4);
	var_0E scalevolume(0.1,4);
	var_12 scalevolume(0.1,4);
	var_13 scalevolume(0.1,4);
	var_14 scalevolume(0.1,4);
	var_15 scalevolume(0.1,4);
	var_16 scalevolume(0.1,4);
	var_17 scalevolume(0.1,4);
	var_1A scalevolume(0.3,4);
	var_1B scalevolume(0.3,4);
	var_1C scalevolume(0.3,4);
	for(var_1D = 0;var_1D <= 3;var_1D++)
	{
		soundscripts\_snd_playsound::snd_play_at("hangar_warning",(-12776,10038,-1084));
		wait(3);
	}

	level waittill("kill_tank_startup_loop");
	wait(4.8);
	thread soundscripts\_audio::aud_fade_loop_out_and_delete(var_00,4);
	thread soundscripts\_audio::aud_fade_loop_out_and_delete(var_01,4);
	thread soundscripts\_audio::aud_fade_loop_out_and_delete(var_02,4);
	thread soundscripts\_audio::aud_fade_loop_out_and_delete(var_03,4);
	thread soundscripts\_audio::aud_fade_loop_out_and_delete(var_04,4);
	thread soundscripts\_audio::aud_fade_loop_out_and_delete(var_05,4);
	thread soundscripts\_audio::aud_fade_loop_out_and_delete(var_06,4);
	thread soundscripts\_audio::aud_fade_loop_out_and_delete(var_07,4);
	thread soundscripts\_audio::aud_fade_loop_out_and_delete(var_08,4);
	thread soundscripts\_audio::aud_fade_loop_out_and_delete(var_09,4);
	thread soundscripts\_audio::aud_fade_loop_out_and_delete(var_0A,4);
	thread soundscripts\_audio::aud_fade_loop_out_and_delete(var_0B,4);
	thread soundscripts\_audio::aud_fade_loop_out_and_delete(var_0C,4);
	thread soundscripts\_audio::aud_fade_loop_out_and_delete(var_0D,4);
	thread soundscripts\_audio::aud_fade_loop_out_and_delete(var_0E,4);
	thread soundscripts\_audio::aud_fade_loop_out_and_delete(var_0F,4);
	thread soundscripts\_audio::aud_fade_loop_out_and_delete(var_10,4);
	thread soundscripts\_audio::aud_fade_loop_out_and_delete(var_11,4);
	thread soundscripts\_audio::aud_fade_loop_out_and_delete(var_12,4);
	thread soundscripts\_audio::aud_fade_loop_out_and_delete(var_13,4);
	thread soundscripts\_audio::aud_fade_loop_out_and_delete(var_14,4);
	thread soundscripts\_audio::aud_fade_loop_out_and_delete(var_15,4);
	thread soundscripts\_audio::aud_fade_loop_out_and_delete(var_16,4);
	thread soundscripts\_audio::aud_fade_loop_out_and_delete(var_17,4);
	thread soundscripts\_audio::aud_fade_loop_out_and_delete(var_1A,4);
	thread soundscripts\_audio::aud_fade_loop_out_and_delete(var_1B,4);
	thread soundscripts\_audio::aud_fade_loop_out_and_delete(var_1C,4);
}

//Function Number: 167
aud_balcony_aircraft_wait()
{
	common_scripts\utility::flag_wait("aud_balcony_aircraft");
	soundscripts\_snd_playsound::snd_play_at("balcony_aircraft",(-11050,10541,-733));
}

//Function Number: 168
player_plant_frb()
{
	soundscripts\_audio_mix_manager::mm_add_submix("bio_room_detonate",0.05);
	soundscripts\_snd_playsound::snd_play_2d("bio_lab_frb_plant");
}

//Function Number: 169
foam_room_door_close(param_00,param_01)
{
	soundscripts\_snd_playsound::snd_play_2d("bio_lab_frb_clacker_equip");
	param_00 soundscripts\_snd_playsound::snd_play_linked("bio_lab_door_close_left");
	param_01 soundscripts\_snd_playsound::snd_play_linked("bio_lab_door_close_right");
	level notify("kill_all_scanner_audio");
	level waittill("vfx_foam_room_explode_start");
	gas_release();
}

//Function Number: 170
gas_release()
{
	var_00 = spawn("script_origin",(-11430,15458,-1352));
	var_01 = "stop_bio_lab_gas_loop";
	var_02 = 1.5;
	var_03 = 1;
	var_00 soundscripts\_snd_playsound::snd_play_linked("bio_lab_gas_exp");
	var_00 soundscripts\_snd_playsound::snd_play_loop_linked("bio_lab_gas_loop",var_01,var_02,var_03);
	level waittill("kill_gas_loop");
	level notify(var_01);
	wait(0.5);
	soundscripts\_audio_mix_manager::mm_clear_submix("bio_room_detonate",1);
}

//Function Number: 171
door2courtyard_open()
{
	var_00 = (-11247,15082,-1373);
	var_01 = (-11247,15137,-1373);
	common_scripts\utility::flag_wait("flag_foam_room_complete_dialogue");
	soundscripts\_snd_playsound::snd_play_at("door_to_courtyard_left",var_00);
	soundscripts\_snd_playsound::snd_play_at("door_to_courtyard_right",var_01);
}

//Function Number: 172
current_gen_hangar_door_open()
{
	soundscripts\_snd_playsound::snd_play_at("lab_hangar_door_open",(-11420,10077,-1068));
}

//Function Number: 173
hangar_lights_on()
{
	soundscripts\_snd::snd_music_message("tank_reveal");
	var_00 = (-12621,9561,-1059);
	var_01 = (-12926,9561,-1059);
	var_02 = (-12926,9496,-1059);
	var_03 = (-12621,9496,-1059);
	var_04 = (-12621,9433,-1059);
	var_05 = (-12926,9433,-1059);
	var_06 = (-12926,9367,-1059);
	var_07 = (-12621,9367,-1059);
	var_08 = (-12621,9305,-1059);
	var_09 = (-12926,9305,-1059);
	var_0A = (-12926,9240,-1059);
	var_0B = (-12621,9240,-1059);
	var_0C = (-12621,9175,-1059);
	var_0D = (-12926,9175,-1059);
	var_0E = 1;
	common_scripts\utility::flag_set("aud_hangar_light_hum_start");
	soundscripts\_snd_playsound::snd_play_at("tank_hangar_light_on",var_01);
	soundscripts\_snd_playsound::snd_play_at("tank_hangar_light_on",var_0C);
	wait(var_0E);
	soundscripts\_snd_playsound::snd_play_at("tank_hangar_light_on",var_02);
	soundscripts\_snd_playsound::snd_play_at("tank_hangar_light_on",var_0B);
	wait(var_0E);
	soundscripts\_snd_playsound::snd_play_at("tank_hangar_light_on",var_05);
	soundscripts\_snd_playsound::snd_play_at("tank_hangar_light_on",var_08);
	wait(var_0E);
	soundscripts\_snd_playsound::snd_play_at("tank_hangar_light_on",var_06);
	soundscripts\_snd_playsound::snd_play_at("tank_hangar_light_on",var_07);
	wait(var_0E);
	soundscripts\_snd_playsound::snd_play_at("tank_hangar_light_on",var_09);
	soundscripts\_snd_playsound::snd_play_at("tank_hangar_light_on",var_04);
	wait(var_0E);
	soundscripts\_snd_playsound::snd_play_at("tank_hangar_light_on",var_0A);
	soundscripts\_snd_playsound::snd_play_at("tank_hangar_light_on",var_03);
	wait(var_0E);
	soundscripts\_snd_playsound::snd_play_at("tank_hangar_light_on",var_0D);
	soundscripts\_snd_playsound::snd_play_at("tank_hangar_light_on",var_00);
}

//Function Number: 174
setup_hangar_notetracks()
{
	if(level.currentgen && !istransientloaded("lab_outro_tr"))
	{
		level waittill("tff_post_middle_to_outro");
	}

	maps\_anim::addnotetrack_customfunction("knox","aud_knox_control_panel",::hovertank_control_panel,"hovertank_reveal_approach");
}

//Function Number: 175
hovertank_control_panel(param_00)
{
}

//Function Number: 176
hover_tank_startup_sequence()
{
	var_00 = (-12771,9352,-1203);
	var_01 = (-12769,9327,-1155);
	var_02 = (-12593,9526,-1256);
	var_02 = (-12934,9526,-1256);
	var_03 = (-12593,9242,-1256);
	var_03 = (-12934,9242,-1256);
	var_04 = (-12660,9173,-1227);
	var_05 = (-12801,9173,-1227);
	soundscripts\_audio_mix_manager::mm_add_submix("hover_tank_startup",0.1);
	soundscripts\_snd::snd_music_message("hover_tank_startup");
	soundscripts\_snd_playsound::snd_play_delayed_at("ht_startup_main",var_00,3.5);
	wait(16.6);
	soundscripts\_snd_playsound::snd_play_at("ht_startup_hover_engage",var_00);
	soundscripts\_snd_playsound::snd_play_at("ht_support_release_fl",var_02);
	soundscripts\_snd_playsound::snd_play_at("ht_support_release_fr",var_02);
	soundscripts\_snd_playsound::snd_play_at("ht_support_release_rl",var_03);
	soundscripts\_snd_playsound::snd_play_at("ht_support_release_rr",var_03);
	wait(2.2);
	var_06 = "stop_ht_startup_engine_loop";
	var_07 = 3.75;
	var_08 = 4;
	soundscripts\_snd_playsound::snd_play_loop_at("ht_startup_engine_loop",var_00,var_06,var_07,var_08);
	soundscripts\_snd_playsound::snd_play_at("ht_startup_armor_panels",var_00);
	wait(3);
	soundscripts\_snd_playsound::snd_play_at("ht_rear_panels_l",var_04);
	soundscripts\_snd_playsound::snd_play_at("ht_rear_panels_r",var_05);
	wait(10.2);
	soundscripts\_snd_playsound::snd_play_at("ht_hatch_open_ext",var_01);
	level.cormack soundscripts\_snd_playsound::snd_play_delayed_linked("ht_cormack_feet_ext_hangar",3,undefined,undefined,undefined,undefined,undefined,(0,0,-25));
	level.burke soundscripts\_snd_playsound::snd_play_delayed_linked("ht_burke_feet_ext_hangar",3,undefined,undefined,undefined,undefined,undefined,(0,0,-25));
	level waittill("kill_tank_startup_loop");
	wait(4.8);
	level notify(var_06);
}

//Function Number: 177
hovertank_enter()
{
	level notify("kill_tank_startup_loop");
	soundscripts\_audio_mix_manager::mm_add_submix("lab_tank_foley_mute");
	thread soundscripts\_snd_common::snd_enable_soundcontextoverride("bullet_metal_vehicle");
	soundscripts\_snd_playsound::snd_play_2d("ht_player_tank_enter");
	var_00 = (-12768,9350,-1248);
	var_01 = "stop_ht_int_idle_low";
	var_02 = 6;
	var_03 = 1;
	var_04 = 0.3;
	soundscripts\_snd_playsound::snd_play_loop_at("ht_int_idle_low",var_00,var_01,var_02,var_03,var_04);
	wait(5.8);
	level.burke soundscripts\_snd_playsound::snd_play_linked("ht_burke_tank_enter");
	level waittill("tank_switch");
	tank_screens_boot_up();
	level notify(var_01);
	wait(3);
	soundscripts\_audio_mix_manager::mm_clear_submix("hover_tank_startup",1);
}

//Function Number: 178
aud_player_gets_in_tank()
{
	soundscripts\_audio_zone_manager::azm_start_zone("lab_int_tank",1);
	aud_hangar_door_open();
	soundscripts\_audio_mix_manager::mm_add_submix("tank_battle",0.25);
}

//Function Number: 179
tank_screens_boot_up()
{
	level notify("stop_post_courtyard_alarms");
	soundscripts\_snd_playsound::snd_play_2d("ht_monitors_boot_up");
}

//Function Number: 180
aud_impact_system_hovertank(param_00)
{
	var_01 = [];
	var_01["Debug"] = 0;
	var_01["VehicleID"] = "tank_impact";
	var_01["PV_MinVelocityThreshold"] = 10;
	var_01["PV_MaxVelocity"] = 250;
	var_01["PV_NumVelocityRanges"] = 3;
	var_01["PV_MaxSmlVelocity"] = 45;
	var_01["PV_MaxMedVelocity"] = 125;
	var_01["PV_MaxLrgVelocity"] = 250;
	var_01["NPC_MinVelocityThreshold"] = 25;
	var_01["NPC_MaxVelocity"] = 800;
	var_01["NPC_NumVelocityRanges"] = 3;
	var_01["NPC_MaxSmlVelocity"] = 100;
	var_01["NPC_MaxMedVelocity"] = 400;
	var_01["NPC_MaxLrgVelocity"] = 800;
	var_01["MinLFEVolumeThreshold"] = 0;
	var_01["FallVelMultiplier"] = 2;
	var_01["MinTimeThreshold"] = 250;
	var_01["ScrapeEnabled"] = 0;
	var_01["ScrapeSeperationTime"] = 0.5;
	var_01["ScrapeFadeOutTime"] = 0.5;
	var_01["ScrapeUpdateRate"] = 0.05;
	var_01["TireSkidProbability"] = 0;
	var_01["MaxDistanceThreshold"] = 6000;
	var_01["MedVolMin"] = 0.1;
	var_01["LrgVolMin"] = 0.5;
	var_01["NonPlayerImpVolReduction"] = 0;
	soundscripts\_snd_common::snd_play_vehicle_collision(param_00,var_01);
}

//Function Number: 181
aud_hangar_door_open()
{
	wait(0.1);
	soundscripts\_snd_playsound::snd_play_at("hangar_door_open",(-12765,10082,-1108));
}

//Function Number: 182
begin_pcap_vo_lab_serverroom_cormack()
{
	soundscripts\_snd::snd_music_message("begin_pcap_vo_lab_serverroom_cormack");
}

//Function Number: 183
open_server_room_door()
{
	soundscripts\_snd::snd_music_message("open_server_room_door");
	soundscripts\_snd_filters::snd_fade_out_filter(0.5);
}

//Function Number: 184
research_building_combat_complete()
{
	soundscripts\_snd::snd_music_message("research_building_combat_complete");
	soundscripts\_audio_mix_manager::mm_add_submix("lab_neutralize_bio_weapons_complete",1);
}

//Function Number: 185
foam_room_crmk_plant_these_frvs()
{
	soundscripts\_snd::snd_music_message("foam_room_crmk_plant_these_frvs");
}

//Function Number: 186
neutralize_bio_weapons_complete()
{
	soundscripts\_snd::snd_music_message("neutralize_bio_weapons_complete");
}

//Function Number: 187
foam_room_complete_dialogue()
{
	soundscripts\_snd::snd_music_message("begin_courtyard_combat");
	start_courtyard_alarms();
	soundscripts\_audio_mix_manager::mm_clear_submix("lab_neutralize_bio_weapons_complete",6);
}

//Function Number: 188
begin_courtyard_combat()
{
}

//Function Number: 189
aud_ctyard_vrap01()
{
	level.courtyard_vrap01 soundscripts\_snd_playsound::snd_play_linked("scn_lab_ctyard_vrap01");
	level notify("stop_interior_alarms");
	soundscripts\_snd::snd_music_message("pre_mech_vrap");
}

//Function Number: 190
aud_ctyard_vrap02()
{
	level.courtyard_vrap02 soundscripts\_snd_playsound::snd_play_delayed_linked("scn_lab_ctyard_vrap02",0.01);
}

//Function Number: 191
aud_ctyard_vrap04()
{
	level.courtyard_vrap04 soundscripts\_snd_playsound::snd_play_linked("scn_lab_ctyard_vrap04");
	level notify("kill_gas_loop");
}

//Function Number: 192
aud_ctyard_vrap05()
{
	level.courtyard_vrap05 soundscripts\_snd_playsound::snd_play_delayed_linked("scn_lab_ctyard_vrap05",0.95);
}

//Function Number: 193
courtyard_hangar_mech_01_spawned(param_00)
{
	soundscripts\_snd::snd_music_message("courtyard_hangar_mech_01_spawned");
}

//Function Number: 194
courtyard_door_hack_start_dialogue()
{
	soundscripts\_snd::snd_music_message("courtyard_door_hack_start_dialogue");
}

//Function Number: 195
courtyard_start_dish()
{
	if(level.currentgen && !istransientloaded("lab_middle_tr"))
	{
		level waittill("tff_post_intro_to_middle");
	}

	var_00 = spawn("script_origin",(-12332,13331,-1093));
	var_00 thread soundscripts\_snd_playsound::snd_play_loop_linked("courtyard_jammer_mech",undefined,0.3,undefined,1);
	common_scripts\utility::flag_wait("aud_start_jammer");
	var_01 = spawn("script_origin",(-12289,13353,-1120));
	var_02 = spawn("script_origin",(-12324,13352,-1088));
	var_01 thread soundscripts\_snd_playsound::snd_play_loop_linked("courtyard_jammer_emi_close",undefined,1,undefined,1);
	var_02 thread soundscripts\_snd_playsound::snd_play_loop_linked("courtyard_jammer_emi_wide",undefined,1,undefined,1);
	common_scripts\utility::flag_wait("flag_obj_jammer_interact");
	wait(2);
	var_00 scalepitch(0.5,3);
	thread soundscripts\_audio::aud_fade_loop_out_and_delete(var_01,1);
	var_02 scalepitch(0.1,2);
	wait(1);
	thread soundscripts\_audio::aud_fade_loop_out_and_delete(var_00,2);
	thread soundscripts\_audio::aud_fade_loop_out_and_delete(var_02,1);
}

//Function Number: 196
courtyard_end_jammer()
{
	wait(1.35);
	level.player soundscripts\_snd_playsound::snd_play_linked("courtyard_jammer_plant");
}

//Function Number: 197
courtyard_defend_start()
{
	soundscripts\_snd::snd_music_message("courtyard_defend_start");
}

//Function Number: 198
aud_courtyard_hangar_door_close()
{
	soundscripts\_snd_playsound::snd_play_at("lab_hangar_door_close",(-12699,11527,-1256));
}

//Function Number: 199
aud_courtyard_hangar_door_hack(param_00,param_01)
{
	wait_for_anim_start(param_00,param_01);
	wait(2);
	level.knox soundscripts\_snd_playsound::snd_play_linked("lab_hangar_door_hack_foley_start");
}

//Function Number: 200
aud_courtyard_hangar_door_hack_idle(param_00,param_01)
{
	level endon("hack_success");
	var_02 = 1;
	wait_for_anim_start(param_00,param_01);
	for(;;)
	{
		var_03 = param_01 getanimtime(param_00);
		if(var_03 < var_02)
		{
			maps\_utility::delaythread(3.45,::play_sound_stop_on_notify,"lab_hangar_door_hack_foley",level.knox,"hack_success");
		}

		var_02 = var_03;
		wait 0.05;
	}
}

//Function Number: 201
aud_courtyard_hangar_door_open()
{
	soundscripts\_snd_playsound::snd_play_at("lab_hangar_door_open",(-12699,11527,-1256));
	start_post_courtyard_interior_alarms();
}

//Function Number: 202
courtyard_hangar_door_close_rpg(param_00,param_01)
{
	var_02 = self;
	soundscripts\_snd::snd_music_message("courtyard_hangar_door_close");
	var_02 thread play_courtyard_hangar_door_rpg(param_00,param_01);
	soundscripts\_snd_filters::snd_fade_in_filter("lab_courtyard_hangar_door_rpg",param_01);
}

//Function Number: 203
play_courtyard_hangar_door_rpg(param_00,param_01)
{
	if(isdefined(self))
	{
		var_02 = self;
		var_03 = var_02.origin;
		soundscripts\_snd_playsound::snd_play_at("lab_hangar_door_close_int",(-12699,11491,-1256));
		soundscripts\_snd_playsound::snd_play_at("courtyard_hangar_door_rpg_fire",var_03);
		var_02 soundscripts\_snd_playsound::snd_play_loop_linked("courtyard_hangar_door_rpg_travel","stop_courtyard_hangar_door_rpg_travel");
		wait(param_01);
		level notify("stop_courtyard_hangar_door_rpg_travel");
		var_04 = spawnstruct();
		var_04.pos = param_00;
		var_04.speed_of_sound_ = 1;
		var_04.incoming_alias_ = "exp_generic_incoming";
		var_04.duck_alias_ = "exp_generic_explo_sub_kick";
		var_04.duck_dist_threshold_ = 1000;
		var_04.explo_delay_chance_ = 100;
		var_04.shake_dist_threshold_ = 2000;
		var_04.explo_debris_alias_ = "exp_debris_dirt_chunks";
		var_04.ground_zero_alias_ = "exp_grnd_zero_stone";
		var_04.ground_zero_dist_threshold_ = 500;
		soundscripts\_snd_common::snd_ambient_explosion(var_04);
	}
}

//Function Number: 204
boxtruck_explode()
{
	var_00 = self;
	var_00 soundscripts\_snd_playsound::snd_play_linked("lab_boxtruck_explode");
}

//Function Number: 205
warbird_emp_death()
{
	var_00 = self;
	var_00 soundscripts\_snd_playsound::snd_play("warbird_emp_impact");
}

//Function Number: 206
log_pile_collapse(param_00)
{
	soundscripts\_snd_playsound::snd_play_at("log_pile_collapse",param_00.origin + (0,0,100));
}

//Function Number: 207
tank_shack_destruct(param_00)
{
	soundscripts\_snd_playsound::snd_play_at("shack_destroyed",param_00);
}

//Function Number: 208
aud_tank_road_littlebird_1(param_00)
{
	var_01 = "LB-" + param_00;
	var_02 = "littlebird_road_flyby";
	var_03 = [];
	var_03["littlebird_med_incoming"] = 9.5;
	var_04 = [];
	var_04[0] = 1400;
	var_04[1] = 2000;
	var_04[2] = 2500;
	var_05 = [];
	var_05[0] = 40;
	thread soundscripts\_snd_common::snd_advanced_flyby_system(var_02,var_03,var_04,var_05,1,"littlebird_death_spin","littlebird_death_explo");
}

//Function Number: 209
aud_tank_road_littlebird_2(param_00)
{
	var_01 = "LB-" + param_00;
	var_02 = "littlebird_road_flyby";
	var_03 = [];
	var_03[0] = 1600;
	var_04 = [];
	var_04[0] = 33;
	thread soundscripts\_snd_common::snd_advanced_flyby_system(var_02,undefined,var_03,var_04,1,"littlebird_death_spin","littlebird_death_explo");
}

//Function Number: 210
aud_tank_field_warbird()
{
	var_00 = "WB-1:  ";
	var_01 = "warbird_field_flyby";
	var_02 = [];
	var_02["warbird_field_spawn_1st"] = 0.266;
	var_02["warbird_field_spawn_2nd"] = 16.096;
	var_03 = [];
	var_03[0] = 2000;
	thread soundscripts\_snd_common::snd_advanced_flyby_system(var_01,var_02,var_03,undefined,1,undefined,"warbird_death_explo");
}

//Function Number: 211
aud_tank_field_littlebird(param_00)
{
	var_01 = "LB-" + param_00 + ":  ";
	var_02 = "littlebird_flyby";
	var_03 = [];
	var_03["littlebird_field_spawn_far"] = 4.857;
	thread soundscripts\_snd_common::snd_advanced_flyby_system(var_02,var_03,undefined,undefined,1,"littlebird_death_spin","littlebird_death_explo");
}

//Function Number: 212
aud_combat_clearing_1_warbird()
{
	var_00 = "WB-2:  ";
	var_01 = "warbird_clearing_flyby";
	var_02 = [];
	var_02["warbird_clearing_spawn_1st"] = 0.369;
	var_02["warbird_clearing_spawn_2nd"] = 15.957;
	var_02["warbird_clearing_spawn_3rd"] = 18.859;
	var_03 = [];
	var_03[0] = 2000;
	var_03[1] = 3000;
	var_03[2] = 5000;
	thread soundscripts\_snd_common::snd_advanced_flyby_system(var_01,var_02,var_03,undefined,1,undefined,"warbird_death_explo");
}

//Function Number: 213
aud_combat_clearing_2_littlebird_1(param_00)
{
	var_01 = "LB-" + param_00 + ":  ";
	var_02 = "littlebird_clearing2_flyby";
	var_03 = [];
	var_03["littlebird_clearing2_spawn"] = 4.74;
	var_04 = [];
	var_04[0] = 2000;
	var_04[1] = 3000;
	var_05 = [];
	var_05[0] = 40;
	thread soundscripts\_snd_common::snd_advanced_flyby_system(var_02,var_03,var_04,var_05,1,"littlebird_death_spin","littlebird_death_explo");
}

//Function Number: 214
aud_combat_clearing_2_littlebird_2(param_00)
{
	var_01 = "LB-" + param_00 + ":  ";
	var_02 = "littlebird_flyby";
	var_03 = [];
	var_03["littlebird_med_incoming"] = 0.1;
	var_03["littlebird_far_incoming"] = 15.415;
	var_04 = [];
	var_04[0] = 1900;
	var_05 = [];
	var_05[0] = 15;
	thread soundscripts\_snd_common::snd_advanced_flyby_system(var_02,var_03,var_04,var_05,1,"littlebird_death_spin","littlebird_death_explo");
}

//Function Number: 215
aud_combat_clearing_3_littlebird_1(param_00)
{
	var_01 = "LB-" + param_00 + ":  ";
	var_02 = "littlebird_flyby";
	var_03 = [];
	var_03["littlebird1_clearing3_spawn"] = 3.145;
	var_04 = [];
	var_04[0] = 500;
	thread soundscripts\_snd_common::snd_advanced_flyby_system(var_02,var_03,var_04,undefined,1,"littlebird_death_spin","littlebird_death_explo");
}

//Function Number: 216
aud_combat_clearing_3_littlebird_2(param_00)
{
	var_01 = "LB-" + param_00 + ":  ";
	var_02 = "littlebird_flyby";
	var_03 = [];
	var_03["littlebird2_clearing3_spawn"] = 4.658;
	var_04 = [];
	var_04[0] = 500;
	thread soundscripts\_snd_common::snd_advanced_flyby_system(var_02,var_03,var_04,undefined,1,"littlebird_death_spin","littlebird_death_explo");
}

//Function Number: 217
aud_ascent_final_warbird()
{
	var_00 = "WB-3:  ";
	var_01 = "warbird_flyby";
	var_02 = [];
	var_02["warbird_ascent_spawn"] = 1;
	var_03 = [];
	var_03[0] = 500;
	thread soundscripts\_snd_common::snd_advanced_flyby_system(var_01,var_02,var_03,undefined,1,undefined,"warbird_death_explo");
}

//Function Number: 218
tank_disabled()
{
	soundscripts\_snd_playsound::snd_play_2d("ht_monitors_power_down");
	var_00 = (6859,14947,-484);
	soundscripts\_snd_playsound::snd_play_at("ht_hatch_open_int",(6792,14954,-448));
	soundscripts\_snd_playsound::snd_play_at("ht_exfil_engine_power_down",var_00);
	soundscripts\_snd_playsound::snd_play_at("ht_exfil_tank_rattle",var_00);
	wait(2.7);
	soundscripts\_snd::snd_music_message("end_tank_combat");
}

//Function Number: 219
tank_exit()
{
	thread razorback_fly_in();
	thread soundscripts\_snd_common::snd_disable_soundcontextoverride("bullet_metal_vehicle");
	wait(8.3);
	soundscripts\_audio_mix_manager::mm_clear_submix("tank_battle");
	soundscripts\_audio_mix_manager::mm_add_submix("tank_exfil");
}

//Function Number: 220
set_up_tank_exit_anims()
{
	if(level.currentgen && !istransientloaded("lab_outro_tr"))
	{
		level waittill("tff_post_middle_to_outro");
	}

	maps\_anim::addnotetrack_customfunction("burke","lab_tank_exit_gid_stand",::lab_tank_exit_gid_stand,"hovertank_exit");
	maps\_anim::addnotetrack_customfunction("burke","lab_tank_exit_gid_walk",::lab_tank_exit_gid_walk,"hovertank_exit");
	maps\_anim::addnotetrack_customfunction("burke","lab_tank_exit_gid_stairs",::lab_tank_exit_gid_stairs,"hovertank_exit");
	maps\_anim::addnotetrack_customfunction("burke","lab_tank_exit_gid_at_hatch",::lab_tank_exit_gid_at_hatch,"hovertank_exit");
	maps\_anim::addnotetrack_customfunction("cormack","lab_tank_exit_crmk_stand",::lab_tank_exit_crmk_stand,"hovertank_exit");
	maps\_anim::addnotetrack_customfunction("cormack","lab_tank_exit_crmk_walk",::lab_tank_exit_crmk_walk,"hovertank_exit");
	maps\_anim::addnotetrack_customfunction("cormack","lab_tank_exit_crmk_land",::lab_tank_exit_crmk_land,"hovertank_exit");
	maps\_anim::addnotetrack_customfunction("knox","lab_tank_exit_knx_stand",::lab_tank_exit_knx_stand,"hovertank_exit");
	maps\_anim::addnotetrack_customfunction("knox","lab_tank_exit_knx_stairs",::lab_tank_exit_knx_stairs,"hovertank_exit");
	maps\_anim::addnotetrack_customfunction("knox","lab_tank_exit_knx_at_hatch",::lab_tank_exit_knx_at_hatch,"hovertank_exit");
	maps\_anim::addnotetrack_customfunction("knox","lab_tank_exit_knx_land",::lab_tank_exit_knx_land,"hovertank_exit");
	maps\_anim::addnotetrack_customfunction("player_rig","lab_tank_exit_plr_stand",::lab_tank_exit_plr_stand,"hovertank_exit");
	maps\_anim::addnotetrack_customfunction("player_rig","lab_tank_exit_plr_stairs",::lab_tank_exit_plr_stairs,"hovertank_exit");
	maps\_anim::addnotetrack_customfunction("player_rig","lab_tank_exit_plr_at_hatch",::lab_tank_exit_plr_at_hatch,"hovertank_exit");
	maps\_anim::addnotetrack_customfunction("player_rig","lab_tank_exit_plr_land",::lab_tank_exit_plr_land,"hovertank_exit");
}

//Function Number: 221
lab_tank_exit_gid_stand(param_00)
{
	param_00 soundscripts\_snd_playsound::snd_play_linked("ht_exit_tank_burke_stand");
}

//Function Number: 222
lab_tank_exit_gid_walk(param_00)
{
}

//Function Number: 223
lab_tank_exit_gid_stairs(param_00)
{
	param_00 soundscripts\_snd_playsound::snd_play_linked("ht_exit_tank_burke_stairs");
}

//Function Number: 224
lab_tank_exit_gid_at_hatch(param_00)
{
	param_00 soundscripts\_snd_playsound::snd_play_linked("ht_exit_tank_burke_hatch");
}

//Function Number: 225
lab_tank_exit_crmk_stand(param_00)
{
	param_00 soundscripts\_snd_playsound::snd_play_linked("ht_exit_tank_cormack_stand");
}

//Function Number: 226
lab_tank_exit_crmk_walk(param_00)
{
	param_00 soundscripts\_snd_playsound::snd_play_linked("ht_exit_tank_cormack_stairs");
}

//Function Number: 227
lab_tank_exit_crmk_land(param_00)
{
	param_00 soundscripts\_snd_playsound::snd_play_linked("ht_exit_tank_cormack_land");
}

//Function Number: 228
lab_tank_exit_knx_stand(param_00)
{
	param_00 soundscripts\_snd_playsound::snd_play_linked("ht_exit_tank_knox_stand");
}

//Function Number: 229
lab_tank_exit_knx_stairs(param_00)
{
}

//Function Number: 230
lab_tank_exit_knx_at_hatch(param_00)
{
}

//Function Number: 231
lab_tank_exit_knx_land(param_00)
{
	param_00 soundscripts\_snd_playsound::snd_play_linked("ht_exit_tank_knox_land");
}

//Function Number: 232
lab_tank_exit_plr_stand(param_00)
{
	soundscripts\_snd_playsound::snd_play_2d("ht_exit_tank_player");
}

//Function Number: 233
lab_tank_exit_plr_stairs(param_00)
{
}

//Function Number: 234
lab_tank_exit_plr_at_hatch(param_00)
{
}

//Function Number: 235
lab_tank_exit_plr_land(param_00)
{
	soundscripts\_snd_playsound::snd_play_2d("ht_exit_tank_player_land");
}

//Function Number: 236
lab_exfil_missile_strike()
{
	var_00 = self;
	var_00 soundscripts\_snd_playsound::snd_play_linked("lab_missile_strike_incoming");
	var_01 = var_00.origin;
	while(isdefined(var_00))
	{
		var_01 = var_00.origin;
		wait(0.05);
	}

	soundscripts\_snd_playsound::snd_play_at("lab_missile_strike_explo",var_01);
}

//Function Number: 237
razorback_fly_in()
{
	soundscripts\_audio_mix_manager::mm_clear_submix("lab_tank_foley_mute");
	soundscripts\_audio_mix_manager::mm_add_submix("razorback_fly_in");
	level waittill("hovertank_hide_interior");
	soundscripts\_snd_playsound::snd_play_2d("razorback_fly_by");
}

//Function Number: 238
razorback_land()
{
	var_00 = (7836,14849,-505);
	var_01 = (7899,14651,-526);
	level.razorback soundscripts\_snd_playsound::snd_play_linked("razorback_overhead");
	wait(3.5);
	var_02 = soundscripts\_snd_playsound::snd_play_loop_at("razorback_ext_idle",var_01,"kill_engine_loop");
	var_03 = soundscripts\_snd_playsound::snd_play_loop_at("razorback_ext_idle_jet",var_00,"kill_jet_loop");
	level waittill("player_enters_razorback");
	soundscripts\_snd_playsound::snd_play_2d("razorback_int_takeoff");
	var_03 scalevolume(0,2);
	wait(2);
	level notify("kill_jet_loop");
	var_02 scalevolume(0.5,4);
	wait(5);
	var_02 scalevolume(0,3);
	wait(3);
	level notify("kill_engine_loop");
}

//Function Number: 239
aud_start_exfil_foley()
{
	soundscripts\_audio_mix_manager::mm_add_submix("lab_razor_exfil_foley_mute");
	wait(0.65);
	soundscripts\_snd_playsound::snd_play_2d("lab_exfil_player_foley");
	wait(3.76);
	soundscripts\_snd_playsound::snd_play_at("lab_exfil_portside_guy_foley",(7958,14634,-529));
	wait(1.1);
	soundscripts\_snd_playsound::snd_play_at("lab_exfil_cormack_foley",(7894,14727,-538));
}

//Function Number: 240
lab_exfil_detonate_anims()
{
	if(level.currentgen && !istransientloaded("lab_outro_tr"))
	{
		level waittill("tff_post_middle_to_outro");
	}

	maps\_anim::addnotetrack_customfunction("burke","lab_exfil_wrist_panel",::lab_exfil_wrist_panel,"exfil_enter");
}

//Function Number: 241
lab_exfil_wrist_panel(param_00)
{
	param_00 soundscripts\_snd_playsound::snd_play_linked("lab_exfil_gideon_exo_panel");
}

//Function Number: 242
tank_exfil_charges_going_off()
{
	soundscripts\_snd_playsound::snd_play_2d("ht_exfil_charges_ignite");
}

//Function Number: 243
tank_exfil_detonate()
{
	soundscripts\_snd_playsound::snd_play_2d("ht_exfil_detonate");
	wait(3);
	soundscripts\_snd_playsound::snd_play_2d("ht_exfil_exp_secondaries");
}

//Function Number: 244
lab_e3_end_logo()
{
	soundscripts\_snd_playsound::snd_play_delayed_2d("lab_end_logo_e3",0.5);
	soundscripts\_audio_mix_manager::mm_add_submix("lab_end_logo");
}

//Function Number: 245
e3_demo_fade_out()
{
	soundscripts\_audio_mix_manager::mm_add_submix("mute_all",3);
}

//Function Number: 246
e3_demo_clear_alarm()
{
	level notify("stop_interior_alarms");
}

//Function Number: 247
e3_demo_fade_in()
{
	soundscripts\_audio_mix_manager::mm_add_submix("mute_all");
	wait(0.05);
	start_post_courtyard_interior_alarms();
	soundscripts\_audio_mix_manager::mm_clear_submix("mute_all",2);
}

//Function Number: 248
aud_lab_foley_override_handler()
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
				if(isdefined(level.aud.in_river) && level.aud.in_river == 1)
				{
					if(var_02)
					{
						soundscripts\_snd_playsound::snd_play_2d("fs_river_player_walk_l");
					}
					else
					{
						soundscripts\_snd_playsound::snd_play_2d("fs_river_player_walk_r");
					}
				}
				else if(isdefined(level.aud.opening_run) && level.aud.opening_run == 1)
				{
					soundscripts\_snd_playsound::snd_play_2d("lab_opening_chase_walk");
				}
				break;
	
			case "run":
				if(isdefined(level.aud.in_river) && level.aud.in_river == 1)
				{
					if(var_02)
					{
						soundscripts\_snd_playsound::snd_play_2d("fs_river_player_sprint_l");
					}
					else
					{
						soundscripts\_snd_playsound::snd_play_2d("fs_river_player_sprint_r");
					}
				}
				else if(isdefined(level.aud.opening_run) && level.aud.opening_run == 1)
				{
					soundscripts\_snd_playsound::snd_play_2d("lab_opening_chase_run");
				}
				break;
	
			case "sprint":
				if(isdefined(level.aud.in_river) && level.aud.in_river == 1)
				{
					if(var_02)
					{
						soundscripts\_snd_playsound::snd_play_2d("fs_river_player_sprint_l");
					}
					else
					{
						soundscripts\_snd_playsound::snd_play_2d("fs_river_player_sprint_r");
					}
				}
				else if(isdefined(level.aud.opening_run) && level.aud.opening_run == 1)
				{
					soundscripts\_snd_playsound::snd_play_2d("lab_opening_chase_sprint");
				}
				break;
	
			case "jump":
				break;
	
			case "lightland":
				if(isdefined(level.aud.in_river) && level.aud.in_river == 1)
				{
					soundscripts\_snd_playsound::snd_play_2d("fs_river_player_sprint_l");
					soundscripts\_snd_playsound::snd_play_2d("fs_river_player_sprint_r");
				}
				else if(isdefined(level.aud.opening_run) && level.aud.opening_run == 1)
				{
					soundscripts\_snd_playsound::snd_play_2d("lab_opening_chase_land_lt");
				}
				break;
	
			case "mediumland":
				if(isdefined(level.aud.in_river) && level.aud.in_river == 1)
				{
					soundscripts\_snd_playsound::snd_play_2d("river_player_splash_med");
				}
				else if(isdefined(level.aud.opening_run) && level.aud.opening_run == 1)
				{
					soundscripts\_snd_playsound::snd_play_2d("lab_opening_chase_land_med");
				}
				break;
	
			case "heavyland":
				if(isdefined(level.aud.opening_run) && level.aud.opening_run == 1)
				{
					soundscripts\_snd_playsound::snd_play_2d("lab_opening_chase_land_hv");
				}
				break;
	
			case "damageland":
				break;
	
			case "mantleuphigh":
				soundscripts\_snd_playsound::snd_play_2d("log_mantle_up_high");
				break;
	
			case "mantleupmedium":
				soundscripts\_snd_playsound::snd_play_2d("log_mantle_up_medium");
				break;
	
			case "mantleuplow":
				soundscripts\_snd_playsound::snd_play_2d("log_mantle_up_low");
				break;
	
			case "mantleoverhigh":
				soundscripts\_snd_playsound::snd_play_2d("log_mantle_over_high");
				break;
	
			case "mantleovermedium":
				soundscripts\_snd_playsound::snd_play_2d("log_mantle_over_medium");
				break;
	
			case "mantleoverlow":
				soundscripts\_snd_playsound::snd_play_2d("log_mantle_over_low");
				break;
		}
	}
}

//Function Number: 249
start_interior_alarms()
{
	var_00 = [[0,1],[79.5249,1],[194.9644,0.8796],[305.2732,0.733],[377.1021,0.5916],[446.3658,0.4293],[513.0641,0.2408],[579.7625,0.1047],[700.3325,0.01],[1080,0.01]];
	var_01 = [[0,0.25],[284.7506,0.5],[495.1069,0.4974],[625.9382,0.4293],[728.5511,0.2984],[823.4679,0.1937],[915.8195,0.1099],[1080,0.01]];
	thread alarm_enable((-14489,12517,-1115),0.4,"alarm_av_04_int_near",var_00,"alarm_av_04_int_far",var_01,"stop_interior_alarms");
	thread alarm_enable((-14431,12807,-1148),0.1,"alarm_av_07_int_near",var_00,"alarm_av_07_int_far",var_01,"stop_interior_alarms");
	thread alarm_enable((-13884,14223,-1154),0.2,"alarm_av_01_int_near",var_00,"alarm_av_01_int_far",var_01,"stop_interior_alarms");
	thread alarm_enable((-13884,14223,-1154),0.2,"alarm_av_09_int_near",var_00,"alarm_av_09_int_far",var_01,"stop_interior_alarms");
	thread alarm_enable((-12548,14973,-1148),0.3,"alarm_av_04_int_near",var_00,"alarm_av_04_int_far",var_01,"stop_interior_alarms");
	thread alarm_enable((-13072,15642,-1148),0.3,"alarm_av_04_int_near",var_00,"alarm_av_04_int_far",var_01,"stop_interior_alarms");
	thread alarm_enable((-11896,15552,-1148),0.2,"alarm_01_int_near",var_00,"alarm_01_int_far",var_01,"stop_interior_alarms");
}

//Function Number: 250
start_courtyard_alarms()
{
	var_00 = [[0,1],[79.5249,1],[194.9644,0.8796],[305.2732,0.733],[377.1021,0.5916],[446.3658,0.4293],[513.0641,0.2408],[579.7625,0.1047],[700.3325,0.01],[1080,0.01]];
	var_01 = [[0,0.25],[284.7506,0.5],[495.1069,0.4974],[625.9382,0.4293],[728.5511,0.2984],[823.4679,0.1937],[915.8195,0.1099],[1080,0.01]];
	var_00 = soundscripts\_audio::aud_scale_envelope(var_00,1.7);
	var_01 = soundscripts\_audio::aud_scale_envelope(var_01,1.7);
	thread alarm_enable((-12683,11674,-1260),0.6,"alarm_al_01a_int_near",var_00,"alarm_06_int_far",var_01,"stop_courtyard_alarms");
}

//Function Number: 251
start_post_courtyard_interior_alarms()
{
	var_00 = [[0,1],[79.5249,1],[194.9644,0.8796],[305.2732,0.733],[377.1021,0.5916],[446.3658,0.4293],[513.0641,0.2408],[579.7625,0.1047],[700.3325,0.01],[1080,0.01]];
	var_01 = [[0,0.25],[284.7506,0.5],[495.1069,0.4974],[625.9382,0.4293],[728.5511,0.2984],[823.4679,0.1937],[915.8195,0.1099],[1080,0.01]];
	var_02 = (-12837,11152,-1239);
	var_03 = (-12163,11008,-1210);
	var_04 = (-11496,10433,-1068);
	var_05 = (-10758,10549,-1078);
	var_06 = (-11601,9528,-1068);
	thread alarm_enable(var_02,0.25,"alarm_av_04_int_near_hangar",var_00,"alarm_av_04_int_far_hangar",var_01,"stop_post_courtyard_alarms");
	thread alarm_enable(var_03,0.25,"alarm_av_04_int_near_hangar",var_00,"alarm_av_04_int_far_hangar",var_01,"stop_post_courtyard_alarms");
	thread alarm_enable(var_05,0.15,"alarm_06_int_far_hangar",var_00,"alarm_06_int_far_hangar",var_01,"stop_post_courtyard_alarms");
	thread alarm_enable(var_06,0.25,"alarm_av_04_int_near_hangar",var_00,"alarm_av_04_int_far_hangar",var_01,"stop_post_courtyard_alarms");
}

//Function Number: 252
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

//Function Number: 253
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

//Function Number: 254
alarm_create_loops(param_00,param_01,param_02)
{
	var_03 = spawnstruct();
	var_03.alias = param_00;
	var_03.env = param_01;
	var_03.fade_time = param_02;
	return var_03;
}

//Function Number: 255
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

//Function Number: 256
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

//Function Number: 257
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

//Function Number: 258
alarm_monitor_cleanup()
{
	var_00 = self;
	level waittill(var_00.stop_notify_string);
	var_00 alarm_stop_loops();
}

//Function Number: 259
aud_tank_section_vehicles_spawned(param_00,param_01)
{
	foreach(var_03 in param_00)
	{
		var_04 = var_03.vehicletype;
		var_03 aud_tank_section_vehicles_handler(var_04,param_01);
	}
}

//Function Number: 260
aud_tank_section_vehicles_handler(param_00,param_01)
{
	if(isdefined(param_00))
	{
		switch(param_00)
		{
			case "ft101_tank_physics":
				thread aud_tank_death_listener();
				break;

			case "vrap_physics":
				thread aud_jeep_death_listener();
				break;

			default:
				break;
		}
	}

	if(isdefined(param_01))
	{
		switch(param_01)
		{
			case "flag_tank_road_littlebirds":
				if(param_00 == "littlebird")
				{
					if(!isdefined(level.aud.tank_road_littlebird))
					{
						var_02 = 1;
						thread aud_tank_road_littlebird_1(var_02);
					}
					else
					{
						var_02 = level.aud.tank_road_littlebird + 1;
						thread aud_tank_road_littlebird_2(var_02);
					}
	
					level.aud.tank_road_littlebird = var_02;
				}
				break;

			case "flag_tank_field_warbird_and_littlebird":
				if(param_00 == "xh9_warbird")
				{
					thread aud_tank_field_warbird();
				}
				else if(param_00 == "littlebird")
				{
					var_02 = 1;
					thread aud_tank_field_littlebird(var_02);
				}
				break;

			case "flag_hovertank_combat_clearing_choppers_1":
				if(param_00 == "xh9_warbird")
				{
					thread aud_combat_clearing_1_warbird();
				}
				break;

			case "flag_hovertank_combat_clearing_choppers_2":
				if(param_00 == "littlebird")
				{
					if(!isdefined(level.aud.tank_clearing2_littlebird))
					{
						var_02 = 1;
						thread aud_combat_clearing_2_littlebird_1(var_02);
					}
					else
					{
						var_02 = level.aud.tank_clearing2_littlebird + 1;
						thread aud_combat_clearing_2_littlebird_2(var_02);
					}
	
					level.aud.tank_clearing2_littlebird = var_02;
				}
				break;

			case "flag_hovertank_combat_clearing_choppers_3":
				if(param_00 == "littlebird")
				{
					if(!isdefined(level.aud.tank_clearing3_littlebird))
					{
						var_02 = 1;
						thread aud_combat_clearing_3_littlebird_1(var_02);
					}
					else
					{
						var_02 = level.aud.tank_clearing3_littlebird + 1;
						thread aud_combat_clearing_3_littlebird_2(var_02);
					}
	
					level.aud.tank_clearing3_littlebird = var_02;
				}
				break;

			case "flag_hovertank_ascent_final_enemies":
				if(param_00 == "xh9_warbird")
				{
					thread aud_ascent_final_warbird();
				}
				break;

			default:
				break;
		}
	}
}

//Function Number: 261
aud_tank_death_listener()
{
	self waittill("death");
	var_00 = 0;
	if(isdefined(self))
	{
		var_01 = distance2d(self.origin,level.player.origin);
		if(var_01 < 720)
		{
			soundscripts\_audio_mix_manager::mm_add_submix("tank_vehicle_destruct");
			var_00 = 1;
		}
	}

	wait(0.05);
	level.player soundscripts\_snd_playsound::snd_play("enemy_tank_destroyed_impact");
	if(var_00)
	{
		wait(0.35);
		soundscripts\_audio_mix_manager::mm_clear_submix("tank_vehicle_destruct",0.5);
	}
}

//Function Number: 262
aud_jeep_death_listener()
{
	self waittill("death");
	var_00 = 0;
	if(isdefined(self))
	{
		if(distance2d(self.origin,level.player.origin) < 720)
		{
			soundscripts\_audio_mix_manager::mm_add_submix("jeep_vehicle_destruct");
			var_00 = 1;
		}
	}

	wait(0.05);
	level.player soundscripts\_snd_playsound::snd_play("enemy_jeep_destroyed_impact");
	if(var_00)
	{
		wait(0.35);
		soundscripts\_audio_mix_manager::mm_clear_submix("jeep_vehicle_destruct",0.5);
	}
}

//Function Number: 263
wait_for_anim_start(param_00,param_01)
{
	while(param_01 getanimtime(param_00) == 0)
	{
		wait 0.05;
	}
}

//Function Number: 264
play_sound_stop_on_notify(param_00,param_01,param_02)
{
	var_03 = spawn("script_origin",param_01.origin);
	var_03 linkto(param_01);
	var_03 soundscripts\_snd_playsound::snd_play(param_00,"sounddone");
	common_scripts\utility::waittill_any_ents(var_03,"sounddone",level,param_02);
	soundscripts\_audio::aud_fade_out_and_delete(var_03,0.1);
}