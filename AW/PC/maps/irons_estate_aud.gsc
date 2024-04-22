/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: irons_estate_aud.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 118
 * Decompile Time: 1631 ms
 * Timestamp: 4/22/2024 2:31:43 AM
*******************************************************************/

//Function Number: 1
main()
{
	config_system();
	init_snd_flags();
	init_globals();
	global_mix();
	launch_threads();
	launch_loops();
	create_level_envelop_arrays();
	init_level_arrays();
	precache_presets();
	register_snd_messages();
}

//Function Number: 2
config_system()
{
	soundscripts\_audio::set_stringtable_mapname("shg");
	soundscripts\_snd_filters::snd_set_occlusion("med_occlusion");
	soundscripts\_snd_timescale::snd_set_timescale("irons_timescale_override");
}

//Function Number: 3
init_snd_flags()
{
	common_scripts\utility::flag_init("cliff_rock_debris");
	common_scripts\utility::flag_init("aud_falls_bottom");
	common_scripts\utility::flag_init("aud_foliage_1");
	common_scripts\utility::flag_init("aud_foliage_2");
	common_scripts\utility::flag_init("aud_foliage_3");
	common_scripts\utility::flag_init("aud_falls_top");
	common_scripts\utility::flag_init("aud_pool_area_begin_stealth_music");
	common_scripts\utility::flag_init("aud_stop_server_alarm");
	common_scripts\utility::flag_init("aud_approaching_poolhouse");
	common_scripts\utility::flag_init("aud_reached_penthouse");
	common_scripts\utility::flag_init("aud_player_on_penthouse_balcony");
	common_scripts\utility::flag_init("aud_woman_spots_player");
	common_scripts\utility::flag_init("aud_vtol_fadeout_approach_loop");
	common_scripts\utility::flag_init("aud_start_hangar");
	common_scripts\utility::flag_init("aud_rooftop_wind_1");
	common_scripts\utility::flag_init("aud_rooftop_wind_2");
	common_scripts\utility::flag_init("aud_rooftop_wind_3");
	common_scripts\utility::flag_init("aud_human_activity_area_1");
	common_scripts\utility::flag_init("aud_human_activity_area_2");
	common_scripts\utility::flag_init("aud_human_activity_area_3");
	common_scripts\utility::flag_init("aud_tick");
	common_scripts\utility::flag_init("aud_grapple_kill_foliage_movement");
	common_scripts\utility::flag_init("aud_speedrun_rappel");
}

//Function Number: 4
init_globals()
{
	level.aud_mus_boost = 0;
	level.aud_music_state = 0;
	level.aud_old_music_state = 0;
	level.aud_ironsstealth = 0;
	level.aud_stealth_broken_timer = 721;
	level.aud_insect_sound = 0;
	level.aud_last_time = 0;
	level.aud_drone_investigating = 0;
	level.aud_vtol_passed = 0;
	level.aud_lowstealth = 1;
	level.aud_drone_attack = 0;
}

//Function Number: 5
global_mix()
{
	soundscripts\_audio_mix_manager::mm_add_submix("irons_mute_mw3_sounds");
}

//Function Number: 6
launch_threads()
{
	if(soundscripts\_audio::aud_is_specops())
	{
		return;
	}

	thread aud_grapple_monitor();
	thread soundscripts\_audio_mix_manager::mm_add_submix("master_mix");
}

//Function Number: 7
launch_loops()
{
	soundscripts\_snd_playsound::snd_play_loop_at("irons_dam_waterfall_near_quiet_01",(-8481,-8070,-2802),undefined,5);
	soundscripts\_snd_playsound::snd_play_loop_at("irons_dam_waterfall_near_quiet_04",(-8793,-7845,-2771),undefined,5);
	thread soundscripts\_audio::aud_play_line_emitter("falls_lapping_irons_01","irons_falls_water_lapping_01",(-8811,-8008,-2769),(-8522,-8123,-2769));
	thread soundscripts\_audio::aud_play_line_emitter("falls_splats_irons_01","irons_falls_cascade_large",(-9440,-5424,-1228),(-9488,-6130,-1383),5);
	thread soundscripts\_audio::aud_play_line_emitter("falls_irons_01","irons_dam_waterfall_01",(-8155,-6382,-2189),(-8228,-6364,-3704));
	thread soundscripts\_audio::aud_play_line_emitter("falls_irons_02","irons_dam_waterfall_02",(-7392,-6523,-2119),(-7186,-6620,-3613));
	thread soundscripts\_audio::aud_play_line_emitter("falls_irons_03","irons_dam_waterfall_03",(-7772,-5301,-112),(-8036,-5739,-1255));
	thread soundscripts\_audio::aud_play_line_emitter("falls_irons_04","irons_dam_waterfall_04",(-9112,-5659,-1733),(-9053,-5899,-2573));
	thread soundscripts\_audio::aud_play_line_emitter("falls_irons_01","irons_dam_waterfall_01",(-9275,-4975,-252),(-9237,-5258,-1687));
	thread soundscripts\_audio::aud_play_line_emitter("falls_lapping_irons_02","irons_falls_water_lapping_01",(-7503,-5399,-30),(-7164,-1554,-30));
	common_scripts\utility::loop_fx_sound("irons_palm_wind_01",(-8485,-4780,632),1);
	common_scripts\utility::loop_fx_sound("irons_palm_wind_02",(-6958,-1803,568),1);
	common_scripts\utility::loop_fx_sound("irons_palm_wind_03",(-6460,-2137,512),1);
	common_scripts\utility::loop_fx_sound("irons_palm_wind_04",(-6738,-4146,441),1);
	common_scripts\utility::loop_fx_sound("irons_palm_wind_05",(-5616,-2513,607),1);
	common_scripts\utility::loop_fx_sound("irons_palm_wind_01",(-5421,-3366,717),1);
	common_scripts\utility::loop_fx_sound("irons_palm_wind_02",(-5310,-2191,717),1);
	common_scripts\utility::loop_fx_sound("irons_palm_wind_03",(-4743,-2412,717),1);
	common_scripts\utility::loop_fx_sound("irons_palm_wind_04",(-5242,-4221,717),1);
	common_scripts\utility::loop_fx_sound("irons_palm_wind_05",(-3786,-2744,557),1);
	common_scripts\utility::loop_fx_sound("irons_palm_wind_01",(-1008,-2079,915),1);
	common_scripts\utility::loop_fx_sound("irons_palm_wind_02",(-768,-2924,1009),1);
	common_scripts\utility::loop_fx_sound("irons_palm_wind_03",(-2890,-2791,628),1);
	common_scripts\utility::loop_fx_sound("irons_palm_wind_04",(-2836,-3672,628),1);
	common_scripts\utility::loop_fx_sound("irons_palm_wind_05",(-3734,-3639,628),1);
	common_scripts\utility::loop_fx_sound("irons_palm_wind_01",(-4776,-4860,628),1);
	common_scripts\utility::loop_fx_sound("irons_palm_wind_02",(-6729,-4467,419),1);
	common_scripts\utility::loop_fx_sound("irons_palm_wind_03",(-6974,-4038,419),1);
	common_scripts\utility::loop_fx_sound("irons_palm_wind_04",(-5868,-989,652),1);
	common_scripts\utility::loop_fx_sound("irons_palm_wind_05",(-5960,-1940,652),1);
	thread aud_human_activity_streams();
	common_scripts\utility::loop_fx_sound("irons_hangar_surv_vent",(4804,-1658,783),1);
}

//Function Number: 8
create_level_envelop_arrays()
{
	level.aud.envs = [];
	level.aud.envs["example_envelop"] = [[0,0],[0.082,0.426],[0.238,0.736],[0.408,0.844],[0.756,0.953],[1,1]];
	level.aud.envs["snipe_report_volume"] = [[700,0.6],[900,0.7],[1150,0.8],[1350,0.9],[1600,1]];
	level.aud.envs["snipe_report_delay"] = [[750,0],[900,0],[1200,0.1],[1600,0.2],[1800,0.3]];
	level.aud.envs["player_speed_to_music_vol"] = [[0,0],[10,1]];
	level.aud.envs["dog_bark_percentage"] = [[0,0],[0.5,0],[17,100]];
	level.aud.envs["aud_mute_device_falloff"] = [[0,1],[0.1,0.9],[0.2,0.88],[0.3,0.85],[0.4,0.82],[0.5,0.8],[0.6,0.65],[0.7,0.5],[0.8,0.35],[0.9,0.15],[1,0]];
}

//Function Number: 9
init_level_arrays()
{
	level.aud.sniper = [];
	level.aud.sniper["surfaces"] = ["dirt","wood","water"];
}

//Function Number: 10
precache_presets()
{
}

//Function Number: 11
register_snd_messages()
{
	soundscripts\_snd::snd_register_message("snd_zone_handler",::zone_handler);
	soundscripts\_snd::snd_register_message("snd_music_handler",::music_handler);
	soundscripts\_snd::snd_register_message("start_briefing",::start_briefing);
	soundscripts\_snd::snd_register_message("start_intro",::start_intro);
	soundscripts\_snd::snd_register_message("start_grapple",::start_grapple);
	soundscripts\_snd::snd_register_message("start_jump_grapple",::start_jump_grapple);
	soundscripts\_snd::snd_register_message("start_recon",::start_recon);
	soundscripts\_snd::snd_register_message("start_infil",::start_infil);
	soundscripts\_snd::snd_register_message("start_security_center",::start_security_center);
	soundscripts\_snd::snd_register_message("start_hack_security",::start_hack_security);
	soundscripts\_snd::snd_register_message("start_penthouse",::start_penthouse);
	soundscripts\_snd::snd_register_message("start_bedroom",::start_bedroom);
	soundscripts\_snd::snd_register_message("start_intel",::start_intel);
	soundscripts\_snd::snd_register_message("start_meet_cormack_pt2",::start_meet_cormack_pt2);
	soundscripts\_snd::snd_register_message("start_track_irons",::start_track_irons);
	soundscripts\_snd::snd_register_message("start_plant_tracker",::start_plant_tracker);
	soundscripts\_snd::snd_register_message("aud_briefing",::aud_briefing);
	soundscripts\_snd::snd_register_message("aud_cave_ambience",::aud_cave_ambience);
	soundscripts\_snd::snd_register_message("aud_patching_in_foley",::aud_patching_in_foley);
	soundscripts\_snd::snd_register_message("aud_intro_foley",::aud_intro_foley);
	soundscripts\_snd::snd_register_message("aud_ready_hooks",::aud_ready_hooks);
	soundscripts\_snd::snd_register_message("aud_waterfall_ambience",::aud_waterfall_ambience);
	soundscripts\_snd::snd_register_message("aud_falls_climbing",::aud_falls_climbing);
	soundscripts\_snd::snd_register_message("aud_grapple_land",::aud_grapple_land_debris);
	soundscripts\_snd::snd_register_message("aud_recon_foley",::aud_recon_foley);
	soundscripts\_snd::snd_register_message("aud_grapple_infil",::aud_grapple_infil);
	soundscripts\_snd::snd_register_message("aud_estate_grounds_emitters",::aud_estate_grounds_emitters);
	soundscripts\_snd::snd_register_message("aud_approaching_poolhouse",::aud_approaching_poolhouse);
	soundscripts\_snd::snd_register_message("aud_security_plant_emp",::aud_security_plant_emp);
	soundscripts\_snd::snd_register_message("aud_security_vent",::aud_security_vent);
	soundscripts\_snd::snd_register_message("aud_security_prints",::aud_security_prints);
	soundscripts\_snd::snd_register_message("aud_security_welcome",::aud_security_welcome);
	soundscripts\_snd::snd_register_message("aud_security_main_screen",::aud_security_main_screen);
	soundscripts\_snd::snd_register_message("aud_security_reboot",::aud_security_reboot);
	soundscripts\_snd::snd_register_message("aud_security_center_drones_on",::aud_security_center_drones_on);
	soundscripts\_snd::snd_register_message("aud_security_countdown",::aud_security_countdown);
	soundscripts\_snd::snd_register_message("aud_security_hatch_exit",::aud_security_hatch_exit);
	soundscripts\_snd::snd_register_message("aud_vtol_land",::aud_vtol_land);
	soundscripts\_snd::snd_register_message("aud_garage_lift",::aud_garage_lift);
	soundscripts\_snd::snd_register_message("aud_tennis_court_wakeup",::aud_tennis_court_wakeup);
	soundscripts\_snd::snd_register_message("aud_penthouse_front_door",::aud_penthouse_front_door);
	soundscripts\_snd::snd_register_message("aud_cormack_grapple_kill",::aud_cormack_grapple_kill);
	soundscripts\_snd::snd_register_message("aud_intel",::aud_intel);
	soundscripts\_snd::snd_register_message("aud_lockdown_alarm",::aud_lockdown_alarm);
	soundscripts\_snd::snd_register_message("aud_reinforcements_door1",::aud_reinforcements_door1);
	soundscripts\_snd::snd_register_message("aud_reinforcements_door2",::aud_reinforcements_door2);
	soundscripts\_snd::snd_register_message("aud_trucks_arrive",::aud_trucks_arrive);
	soundscripts\_snd::snd_register_message("aud_vehicle_ride_data",::aud_vehicle_ride_data);
	soundscripts\_snd::snd_register_message("aud_estate_living_ambience",::aud_estate_living_ambience);
	soundscripts\_snd::snd_register_message("aud_estate_security_ambience",::aud_estate_security_ambience);
	soundscripts\_snd::snd_register_message("aud_conduit_smash",::aud_conduit_smash);
	soundscripts\_snd::snd_register_message("aud_tire_splash",::aud_tire_splash);
	soundscripts\_snd::snd_register_message("aud_hangar_car_door_exit",::aud_hangar_car_door_exit);
	soundscripts\_snd::snd_register_message("aud_monitor_irons",::aud_monitor_irons);
	soundscripts\_snd::snd_register_message("aud_exfil_vtol_start",::aud_exfil_vtol_start);
	soundscripts\_snd::snd_register_message("aud_exfil_door_1",::aud_exfil_door_1);
	soundscripts\_snd::snd_register_message("aud_exfil_door_2a",::aud_exfil_door_2a);
	soundscripts\_snd::snd_register_message("aud_exfil_door_2b",::aud_exfil_door_2b);
	soundscripts\_snd::snd_register_message("aud_exfil_vtol_ascend",::aud_exfil_vtol_ascend);
	soundscripts\_snd::snd_register_message("aud_exfil_vtol_grapple",::aud_exfil_vtol_grapple);
	soundscripts\_snd::snd_register_message("aud_grapple_kill_foliage",::aud_grapple_kill_foliage);
	soundscripts\_snd::snd_register_message("aud_grapple_from_foliage",::aud_grapple_from_foliage);
	soundscripts\_snd::snd_register_message("aud_stealth_melee",::aud_stealth_melee);
	soundscripts\_snd::snd_register_message("aud_panic_walla",::aud_panic_walla);
}

//Function Number: 12
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
		case "enter_irons_int_poolhouse":
			if(var_02 == "irons_ext_grounds_quiet")
			{
				thread aud_poolhouse_ambience();
			}
			break;

		case "exit_irons_int_poolhouse":
			if(var_03 == "irons_ext_grounds_quiet")
			{
				level notify("aud_stop_poolhouse_ambience");
			}
			break;

		case "enter_irons_int_guesthouse_living":
			if(var_02 == "irons_ext_grounds_quiet")
			{
				thread aud_estate_living_ambience();
				if(level.aud_music_state == 1)
				{
					soundscripts\_audio_mix_manager::mm_add_submix("irons_music_mute");
				}
			}
			break;

		case "exit_irons_int_guesthouse_living":
			if(var_03 == "irons_ext_grounds_quiet")
			{
				level notify("aud_stop_estate_living_ambience");
				soundscripts\_audio_mix_manager::mm_clear_submix("irons_music_mute");
			}
			break;

		case "enter_irons_int_guesthouse_bedroom":
			if(var_02 == "irons_ext_grounds_quiet")
			{
				thread aud_estate_living_ambience();
				level notify("aud_stop_ext_grounds_ambience");
			}
			break;

		case "exit_irons_int_guesthouse_bedroom":
			if(var_03 == "irons_ext_grounds_quiet")
			{
				thread aud_estate_grounds_ambience();
				level notify("aud_stop_estate_living_ambience");
			}
			break;

		case "enter_irons_int_security_center_entrance":
			if(var_02 == "irons_ext_grounds_quiet")
			{
				thread aud_estate_security_ambience();
			}
			break;

		case "exit_irons_int_security_center_entrance":
			if(var_03 == "irons_ext_grounds_quiet")
			{
				level notify("aud_stop_security_ambience");
			}
			break;

		case "enter_irons_int_security_center_main":
			if(var_02 == "irons_ext_grounds_quiet")
			{
				thread aud_estate_security_ambience();
			}
			break;

		case "exit_irons_int_security_center_main":
			if(var_03 == "irons_ext_grounds_quiet")
			{
				level notify("aud_stop_security_ambience");
			}
			break;

		case "enter_irons_int_garage":
			if(var_02 == "irons_ext_grounds_quiet")
			{
				thread aud_estate_living_ambience();
				if(level.aud_music_state == 1)
				{
					soundscripts\_audio_mix_manager::mm_add_submix("irons_music_mute");
				}
			}
			break;

		case "exit_irons_int_garage":
			if(var_03 == "irons_ext_grounds_quiet")
			{
				level notify("aud_stop_estate_living_ambience");
				soundscripts\_audio_mix_manager::mm_clear_submix("irons_music_mute");
			}
			break;

		case "enter_irons_int_hangar":
			if(var_02 == "irons_ext_grounds_quiet")
			{
				thread aud_hangar_ambience();
			}
			break;

		case "exit_irons_int_hangar":
			if(var_03 == "irons_ext_grounds_quiet")
			{
				level notify("aud_stop_hangar_ambience");
			}
			break;

		case "enter_irons_int_penthouse_living":
			if(var_02 == "irons_ext_grounds_quiet")
			{
				thread aud_estate_living_ambience();
			}
			break;

		case "exit_irons_int_penthouse_living":
			if(var_03 == "irons_ext_grounds_quiet")
			{
				level notify("aud_stop_estate_living_ambience");
			}
			break;

		case "enter_irons_int_greenhouse":
			if(var_02 == "irons_ext_grounds_quiet")
			{
				thread aud_estate_living_ambience();
			}
			break;

		case "exit_irons_int_greenhouse":
			if(var_03 == "irons_ext_grounds_quiet")
			{
				level notify("aud_stop_estate_living_ambience");
			}
			break;

		case "enter_irons_int_guard_station":
			if(var_02 == "irons_ext_grounds_quiet")
			{
				thread aud_guard_station_ambience();
			}
			else if(var_02 == "irons_int_guard_station_corridor")
			{
				thread aud_guard_station_ambience();
			}
	
			break;

		case "exit_irons_int_guard_station":
			if(var_03 == "irons_ext_grounds_quiet")
			{
				level notify("aud_stop_guard_station_ambience");
			}
			else if(var_03 == "irons_int_guard_station_corridor")
			{
				level notify("aud_stop_guard_station_ambience");
			}
			break;
	}
}

//Function Number: 13
music(param_00,param_01)
{
	thread music_handler(param_00,param_01);
}

//Function Number: 14
music_handler(param_00,param_01)
{
	level notify("exit_music_thread");
	level endon("exit_music_thread");
	switch(param_00)
	{
		case "mus_briefing":
			soundscripts\_snd_playsound::snd_play_delayed_2d("mus_irons_briefing_lowdrum",0.3);
			wait(4);
			soundscripts\_snd_playsound::snd_play_loop_2d("mus_irons_briefing","stop_briefing_music",undefined,5);
			level.allies[0] waittillmatch("fade_start","single anim");
			level notify("stop_briefing_music");
			break;

		case "mus_intro":
			wait(0.2);
			soundscripts\_snd_playsound::snd_play_loop_2d("mus_irons_intro","stop_intro_music",0,14);
			break;

		case "mus_grapple":
			break;

		case "mus_recon":
			wait(1);
			level notify("stop_intro_music");
			break;

		case "mus_infil":
			break;

		case "mus_security_center":
			break;

		case "mus_hack_security":
			break;

		case "mus_penthouse":
			level notify("end_stealth_music_control");
			level.aud_mus_boost = 3;
			thread stealth_music_control_p2();
			break;

		case "mus_bedroom":
			soundscripts\_snd_playsound::snd_play_loop_2d("mus_irons_enter_penthouse","stop_penthouse_entrance_music",5,6);
			level notify("end_stealth_music_control");
			level.aud_music_state = 0;
			level.aud_old_music_state = 0;
			level.aud_mus_boost = 0;
			break;

		case "mus_lockdown":
			soundscripts\_audio_music::mus_play("mus_irons_exit_penthouse",0);
			break;

		case "mus_identify_irons":
			break;

		case "mus_meet_cormack_pt2":
			break;

		case "mus_track_irons":
			break;

		case "mus_plant_tracker":
			break;

		default:
			if(getdvarint("snd_validate_music_messages"))
			{
			}
			break;
	}
}

//Function Number: 15
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

//Function Number: 16
mus_submixer_thread(param_00)
{
	level notify("kill_mus_submixer");
	level endon("kill_mus_submixer");
	var_01 = 0.25;
	var_02 = 0.1;
	var_03 = 0.02;
	var_04 = 0;
	var_05 = 17.6;
	var_06 = 10;
	for(;;)
	{
		var_07 = level.player getnormalizedcameramovements()[0];
		var_08 = level.player getnormalizedcameramovements()[1];
		var_09 = abs(var_07) + abs(var_08);
		var_0A = length(level.player getvelocity()) / var_05 / 2;
		if(level.player adsbuttonpressed())
		{
			var_0A = var_0A + 3;
		}

		if(level.player buttonpressed("BUTTON_B"))
		{
			var_0A = var_0A + 4;
		}

		if(level.player buttonpressed("BUTTON_Y"))
		{
			var_0A = var_0A + 4;
		}

		if(level.player buttonpressed("BUTTON_RTRIG"))
		{
			var_0A = var_0A + 10;
		}

		if(level.player buttonpressed("DPAD_UP"))
		{
			var_0A = var_0A + 4;
		}

		if(var_09 > 0.1)
		{
			var_0A = var_0A + 3;
		}

		if(isdefined(level.player.tagging) && isdefined(level.player.tagging["camera"]))
		{
			var_0A = var_0A + 6;
		}

		var_0A = var_0A + level.aud_mus_boost;
		if(var_0A > var_04)
		{
			var_0B = var_02;
		}
		else
		{
			var_0B = var_03;
		}

		var_04 = var_04 + var_0B * var_0A - var_04;
		var_0C = piecewiselinearlookup(var_04,level.aud.envs["player_speed_to_music_vol"]);
		soundscripts\_audio::aud_set_music_submix(var_0C * param_00,var_01);
		wait(0.25);
	}
}

//Function Number: 17
start_briefing()
{
}

//Function Number: 18
start_intro()
{
	soundscripts\_audio_mix_manager::mm_add_submix("irons_falls_fade_in");
	soundscripts\_audio_mix_manager::mm_add_submix("irons_mute_teleport");
	thread aud_cave_ambience();
	thread aud_waterfall_ambience();
}

//Function Number: 19
start_grapple()
{
	thread aud_cave_ambience();
	thread aud_forest_ambience();
	thread aud_waterfall_ambience();
	soundscripts\_audio_zone_manager::azm_start_zone("irons_ext_falls_cliff",1);
	soundscripts\_snd::snd_music_message("mus_intro");
	common_scripts\utility::flag_set("cliff_rock_debris");
	thread aud_foliage_movement();
	thread aud_foliage_mix();
	common_scripts\utility::flag_wait("aud_falls_bottom");
	thread aud_falls_climbing();
}

//Function Number: 20
start_jump_grapple()
{
	thread aud_cave_ambience();
	thread aud_forest_ambience();
	thread aud_waterfall_ambience();
	soundscripts\_audio_zone_manager::azm_start_zone("irons_ext_falls_cliff",1);
	thread aud_falls_climbing();
	thread aud_foliage_movement();
	thread aud_foliage_mix();
}

//Function Number: 21
start_recon()
{
	thread aud_waterfall_ambience();
	thread aud_forest_ambience();
	thread aud_approaching_poolhouse();
	soundscripts\_audio_zone_manager::azm_start_zone("irons_ext_falls_top",1);
	thread aud_foliage_movement();
	thread aud_foliage_mix();
}

//Function Number: 22
start_infil()
{
	thread aud_waterfall_ambience();
	thread aud_forest_ambience();
	thread aud_approaching_poolhouse();
	soundscripts\_audio_zone_manager::azm_start_zone("irons_ext_falls_top",1);
	thread aud_foliage_movement();
	thread aud_foliage_mix();
}

//Function Number: 23
start_security_center()
{
	common_scripts\utility::flag_set("aud_pool_area_begin_stealth_music");
	thread aud_waterfall_ambience();
	thread aud_estate_grounds_emitters();
	thread stealth_music_control_p1();
	soundscripts\_audio_zone_manager::azm_start_zone("irons_ext_grounds_quiet",1);
	thread aud_foliage_movement();
	thread aud_foliage_mix();
}

//Function Number: 24
start_hack_security()
{
	common_scripts\utility::flag_set("aud_pool_area_begin_stealth_music");
	thread aud_waterfall_ambience();
	thread aud_estate_grounds_emitters();
	thread stealth_music_control_p1();
	soundscripts\_audio_zone_manager::azm_start_zone("irons_int_security_center_main",1);
	thread aud_foliage_movement();
	thread aud_foliage_mix();
}

//Function Number: 25
start_penthouse()
{
	thread aud_reached_penthouse();
	thread aud_waterfall_ambience();
	thread aud_estate_grounds_emitters();
	thread stealth_music_control_p2();
	soundscripts\_audio_zone_manager::azm_start_zone("irons_ext_grounds_quiet",1);
	thread aud_foliage_movement();
	thread aud_foliage_mix();
	level.aud_lowstealth = 1;
	soundscripts\_snd_playsound::snd_play_loop_2d("mus_irons_low_stealth","aud_stop_lowstealth",20,3);
}

//Function Number: 26
start_bedroom()
{
	thread aud_reached_penthouse();
	thread aud_waterfall_ambience();
	thread aud_estate_grounds_emitters();
	soundscripts\_audio_zone_manager::azm_start_zone("irons_ext_grounds_quiet",1);
	thread aud_foliage_movement();
	thread aud_foliage_mix();
}

//Function Number: 27
start_intel()
{
	common_scripts\utility::flag_set("aud_reached_penthouse");
	thread aud_waterfall_ambience();
	thread aud_estate_grounds_emitters();
	soundscripts\_audio_zone_manager::azm_start_zone("irons_int_penthouse_living",1);
	soundscripts\_snd::snd_music_message("mus_bedroom");
	thread aud_guardhouse_foley_cormack();
	common_scripts\utility::flag_wait("intel_end");
	level notify("stop_penthouse_entrance_music");
	soundscripts\_snd::snd_music_message("mus_lockdown");
}

//Function Number: 28
start_meet_cormack_pt2()
{
	thread aud_estate_grounds_emitters();
	soundscripts\_audio_zone_manager::azm_start_zone("irons_int_penthouse_living",1);
	thread aud_guardhouse_foley_cormack();
	soundscripts\_snd::snd_music_message("mus_lockdown");
}

//Function Number: 29
start_track_irons()
{
	thread aud_estate_grounds_emitters();
	soundscripts\_audio_zone_manager::azm_start_zone("irons_int_hangar");
	thread aud_hangar_ambience();
	thread aud_hangar_walla();
}

//Function Number: 30
start_plant_tracker()
{
	thread aud_estate_grounds_emitters();
	soundscripts\_audio_zone_manager::azm_start_zone("irons_int_hangar");
	thread aud_hangar_ambience();
}

//Function Number: 31
aud_briefing()
{
	soundscripts\_audio_mix_manager::mm_add_submix("irons_briefing_fade_in");
	soundscripts\_audio_mix_manager::mm_add_submix("irons_falls_fade_in");
	soundscripts\_audio_zone_manager::azm_start_zone("irons_briefing_hangar");
	common_scripts\utility::flag_wait("introscreen1_complete");
	thread briefing_foley();
	soundscripts\_snd_playsound::snd_play_loop_at("irons_amb_briefing_hangar_front",(-12100,-18990,-5371),"stop_briefing_music");
	soundscripts\_snd_playsound::snd_play_loop_at("irons_amb_briefing_hangar_rear",(-12100,-16081,-5371),"stop_briefing_music");
	soundscripts\_snd_playsound::snd_play_loop_at("irons_hangar_bg_activity",(-12100,-18990,-5371),"stop_bg_activity_sound",undefined,7);
	soundscripts\_audio_mix_manager::mm_clear_submix("irons_briefing_fade_in",1);
	soundscripts\_snd::snd_music_message("mus_briefing");
	wait(26);
	level notify("stop_bg_activity_sound");
	level.allies[0] waittillmatch("fade_start","single anim");
	soundscripts\_audio_mix_manager::mm_add_submix("irons_mute_teleport",1);
	wait(2);
	thread aud_cave_ambience();
	thread aud_waterfall_ambience();
}

//Function Number: 32
briefing_foley()
{
	level.allies[1] soundscripts\_snd_playsound::snd_play_delayed_linked("irons_foley_briefing_ilona_1",0.1);
	level.allies[0] soundscripts\_snd_playsound::snd_play_delayed_linked("irons_foley_briefing_cormack_1",0.7);
	level.allies[0] soundscripts\_snd_playsound::snd_play_delayed_linked("irons_foley_briefing_cormack_2",12.7);
	level.allies[0] soundscripts\_snd_playsound::snd_play_delayed_linked("irons_foley_briefing_cormack_3",25.2);
	level.allies[1] soundscripts\_snd_playsound::snd_play_delayed_linked("irons_foley_briefing_ilona_2",26);
	soundscripts\_snd_playsound::snd_play_delayed_at("irons_foley_briefing_sold_1",(-11687,-17583,-5755),40);
	soundscripts\_snd_playsound::snd_play_delayed_at("irons_foley_briefing_sold_2",(-11687,-17583,-5755),50);
	level.allies[0] soundscripts\_snd_playsound::snd_play_delayed_linked("irons_foley_briefing_cormack_4",57);
	level.allies[1] soundscripts\_snd_playsound::snd_play_delayed_linked("irons_foley_briefing_ilona_3",58);
}

//Function Number: 33
aud_cave_ambience()
{
	soundscripts\_audio_zone_manager::azm_start_zone("irons_ext_cave_intro",1);
	var_00 = soundscripts\_snd_playsound::snd_play_loop_2d("mus_irons_cave_amb","stop_mus_irons_cave_amb",9,3);
	soundscripts\_snd_playsound::snd_play_loop_at("irons_amb_intro_cave_front",(-8673,-8174,-2733),"aud_stop_cave_ambience");
	soundscripts\_snd_playsound::snd_play_loop_at("irons_amb_intro_cave_rear",(-8751,-8552,-2733),"aud_stop_cave_ambience");
	thread aud_cave_cascade();
	thread aud_foliage_movement();
	thread aud_foliage_mix();
	wait(0.1);
	soundscripts\_audio_mix_manager::mm_clear_submix("irons_falls_fade_in",5);
	wait(3.5);
	thread aud_intro_drone();
	thread aud_forest_ambience();
	wait(3.5);
	soundscripts\_snd_playsound::snd_play_2d("irons_intro_boom_1");
	wait(5);
	soundscripts\_audio_mix_manager::mm_clear_submix("irons_mute_teleport");
	wait(4);
	soundscripts\_snd_playsound::snd_play_2d("irons_intro_boom_2");
	var_00 scalevolume(0.5,3);
	wait(8);
	soundscripts\_snd_playsound::snd_play_2d("irons_intro_boom_3");
	common_scripts\utility::flag_wait("drone_passed");
	common_scripts\utility::flag_set("cliff_rock_debris");
	common_scripts\utility::flag_wait("aud_falls_bottom");
	level notify("aud_stop_cave_ambience");
	thread aud_falls_climbing();
}

//Function Number: 34
aud_patching_in_foley()
{
	level.allies[0] soundscripts\_snd_playsound::snd_play_delayed_linked("irons_foley_intro_cormack_start",1.5);
	level.allies[1] soundscripts\_snd_playsound::snd_play_delayed_linked("irons_foley_intro_ilona_start",1.25);
	level.allies[2] soundscripts\_snd_playsound::snd_play_delayed_linked("irons_foley_intro_knox_patching_1",1);
	level.allies[2] soundscripts\_snd_playsound::snd_play_delayed_linked("irons_foley_intro_knox_patching_2",12.4);
	level.allies[0] soundscripts\_snd_playsound::snd_play_delayed_linked("irons_foley_intro_cormack_idle",8);
}

//Function Number: 35
aud_intro_foley()
{
	thread aud_ready_hooks();
	wait(3.5);
	level.allies[1] soundscripts\_snd_playsound::snd_play_delayed_linked("irons_foley_intro_ilona_exit",0.8);
	level.allies[0] soundscripts\_snd_playsound::snd_play_linked("irons_foley_intro_cormack_exit");
	level.allies[2] soundscripts\_snd_playsound::snd_play_delayed_linked("irons_foley_intro_knox_exit",1.3);
	wait(0.5);
	level notify("stop_mus_irons_cave_amb");
	soundscripts\_snd::snd_music_message("mus_intro");
}

//Function Number: 36
aud_ready_hooks()
{
	level waittill("ready_hooks");
	wait(1.5);
	level.allies[1] soundscripts\_snd_playsound::snd_play_linked("irons_ready_hooks_npc");
	wait(0.7);
	soundscripts\_snd_playsound::snd_play_2d("irons_ready_hooks_player");
}

//Function Number: 37
aud_intro_drone()
{
	wait(6);
	soundscripts\_snd_playsound::snd_play_at("irons_intro_cave_drone",(-8483,-7308,-2746));
}

//Function Number: 38
aud_cave_cascade()
{
	thread soundscripts\_audio::aud_play_line_emitter("cave_cascade","irons_cave_cascade",(-8441,-8211,-2744),(-8818,-8056,-2744));
}

//Function Number: 39
aud_forest_ambience()
{
	soundscripts\_snd_playsound::snd_play_loop_at("irons_amb_intro_woods_front",(-8551,-4765,413),"aud_stop_forest_ambience",undefined,5);
	soundscripts\_snd_playsound::snd_play_loop_at("irons_amb_intro_woods_rear",(-6320,-9520,-733),"aud_stop_forest_ambience",undefined,5);
}

//Function Number: 40
aud_waterfall_ambience()
{
	soundscripts\_snd_playsound::snd_play_loop_at("irons_amb_waterfall_front",(-10781,-4516,-1627),"aud_stop_waterfall_ambience",undefined,5);
	soundscripts\_snd_playsound::snd_play_loop_at("irons_amb_waterfall_rear",(-6386,-9482,-1627),"aud_stop_waterfall_ambience",undefined,5);
	soundscripts\_snd_playsound::snd_play_loop_at("irons_amb_waterfall_LFE",(-8403,-6068,-3399),"aud_stop_waterfall_ambience",undefined,5);
}

//Function Number: 41
aud_falls_climbing()
{
	common_scripts\utility::flag_wait("aud_falls_top");
	thread aud_approaching_poolhouse();
	soundscripts\_snd::snd_music_message("mus_recon");
	common_scripts\utility::flag_clear("cliff_rock_debris");
}

//Function Number: 42
aud_grapple_land_debris()
{
	if(common_scripts\utility::flag("cliff_rock_debris"))
	{
		soundscripts\_snd_playsound::snd_play_2d("irons_grapple_cliff_rock_debris");
	}
}

//Function Number: 43
aud_recon_foley()
{
	level.allies[2] soundscripts\_snd_playsound::snd_play_delayed_linked("irons_foley_recon_knox",1.2);
	level.allies[0] soundscripts\_snd_playsound::snd_play_delayed_linked("irons_foley_recon_corm_1",1.1);
	level.allies[0] soundscripts\_snd_playsound::snd_play_delayed_linked("irons_foley_recon_corm_2",8);
	level.allies[0] soundscripts\_snd_playsound::snd_play_delayed_linked("irons_foley_recon_corm_3",12);
}

//Function Number: 44
aud_grapple_infil()
{
	soundscripts\_snd_playsound::snd_play_2d("irons_foley_infil_grapple");
	soundscripts\_snd_playsound::snd_play_delayed_2d("gear_rattle_crouch_stand",13);
}

//Function Number: 45
aud_grapple_monitor()
{
	level endon("death");
	for(;;)
	{
		level waittill("stop_grapplesound");
		soundscripts\_audio_mix_manager::mm_add_submix("irons_mute_grapplewind",0.1);
		level waittill("aud_grapple_start");
		soundscripts\_audio_mix_manager::mm_clear_submix("irons_mute_grapplewind",0.1);
	}
}

//Function Number: 46
aud_estate_grounds_emitters()
{
	thread soundscripts\_audio::aud_play_line_emitter("pool_cascade_large_01","irons_pool_cascade_large",(-6890,-3585,72),(-6984,-3168,72));
	thread soundscripts\_audio::aud_play_line_emitter("pool_cascade_large_01","irons_pool_cascade_large",(-2077,-2271,603),(-1963,-2693,603));
	thread aud_sprinklers();
	soundscripts\_snd_playsound::snd_play_loop_at("irons_hot_tub",(-6323,-3752,163));
	soundscripts\_snd_playsound::snd_play_loop_at("irons_gas_fireplace",(-5586,-3577,229));
	thread soundscripts\_audio::aud_play_line_emitter("penthouse_fireplace","irons_gas_fireplace",(743,-3996,1058),(881,-3989,1058));
	thread aud_ac_units();
	thread aud_security_vent();
	thread aud_ball_fountain();
	thread aud_estate_grounds_ambience();
	thread aud_rooftops_ambience();
	thread aud_garage_hyd_wrench();
	thread aud_fountains();
}

//Function Number: 47
aud_sprinklers()
{
	level.player endon("death");
	var_00 = 0;
	for(;;)
	{
		if(common_scripts\utility::flag("aud_human_activity_area_1") == 1 && var_00 != 1)
		{
			var_00 = 1;
			level notify("aud_stop_mid_area_sprinklers");
			wait(2);
			soundscripts\_snd_playsound::snd_play_loop_at("irons_sprinkler_01",(-6328,-4187,348),"aud_stop_pool_area_sprinklers",1,1.5);
		}
		else if(common_scripts\utility::flag("aud_human_activity_area_2") == 1 && var_00 != 2)
		{
			var_00 = 2;
			level notify("aud_stop_pool_area_sprinklers");
			level notify("aud_stop_back_yard_sprinklers");
			wait(2);
			soundscripts\_snd_playsound::snd_play_loop_at("irons_sprinkler_01",(-4062,-2307,634),"aud_stop_mid_area_sprinklers",1,1.5);
		}
		else if(common_scripts\utility::flag("aud_human_activity_area_3") == 1 && var_00 != 3)
		{
			var_00 = 3;
			level notify("aud_stop_mid_area_sprinklers");
			wait(2);
			soundscripts\_snd_playsound::snd_play_loop_at("irons_sprinkler_01_louder",(3106,-2331,526),"aud_stop_back_yard_sprinklers",1,1.5);
		}

		wait(0.2);
	}
}

//Function Number: 48
aud_ac_units()
{
	soundscripts\_snd_playsound::snd_play_loop_at("irons_ext_air_conditioning_unit_01",(-6512,-4672,297),undefined,1);
	soundscripts\_snd_playsound::snd_play_loop_at("irons_ext_air_conditioning_unit_02",(-6467,-4887,314),undefined,1);
	soundscripts\_snd_playsound::snd_play_loop_at("irons_ext_air_conditioning_unit_04",(1474,-2763,1242),undefined,1);
	soundscripts\_snd_playsound::snd_play_loop_at("irons_ext_air_conditioning_unit_05",(5214,-2956,1285),undefined,1);
	soundscripts\_snd_playsound::snd_play_loop_at("irons_ext_air_conditioning_unit_06",(5353,-3639,1193),undefined,1);
	soundscripts\_snd_playsound::snd_play_loop_at("irons_ext_air_conditioning_unit_07",(5354,-4247,1325),undefined,1);
	soundscripts\_snd_playsound::snd_play_loop_at("irons_ext_air_conditioning_unit_01",(-1273,-4442,941),undefined,1);
	soundscripts\_snd_playsound::snd_play_loop_at("irons_ext_air_conditioning_unit_02",(-1532,-1480,1224),undefined,1);
	soundscripts\_snd_playsound::snd_play_loop_at("irons_int_air_conditioning_unit_02",(5698,-4722,796),undefined,1);
	soundscripts\_snd_playsound::snd_play_loop_at("irons_int_air_conditioning_unit_03",(5720,-5138,796),undefined,1);
}

//Function Number: 49
aud_fountains()
{
	soundscripts\_snd_playsound::snd_play_loop_at("irons_fountain_penthouse",(303,-2310,790),undefined,1);
	soundscripts\_snd_playsound::snd_play_loop_at("irons_fountain_penthouse",(303,-4487,790),undefined,1);
}

//Function Number: 50
aud_human_activity_streams()
{
	level.player endon("death");
	var_00 = 0;
	for(;;)
	{
		if(common_scripts\utility::flag("aud_human_activity_area_1") == 1 && var_00 != 1)
		{
			var_00 = 1;
			level notify("aud_stop_guest_house_music");
			level notify("aud_stop_garage_music");
			level notify("aud_stop_parked_car_music");
			level notify("aud_stop_guest_house_walla");
			soundscripts\_snd_playsound::snd_play_loop_at("mus_irons_pool_music_distant",(-6337,-2759,350),"aud_stop_pool_music",1,8);
			soundscripts\_snd_playsound::snd_play_loop_at("mus_irons_pool_music_close",(-6337,-2759,350),"aud_stop_pool_music",1,8);
			soundscripts\_snd_playsound::snd_play_loop_at("irons_veranda_walla",(-6356,-2859,233),"aud_stop_veranda_walla",1,4);
			wait(5);
			soundscripts\_snd_playsound::snd_play_loop_at("irons_pool_house_bar_walla",(-5589,-3363,258),"aud_stop_pool_house_walla",1,4);
		}
		else if(common_scripts\utility::flag("aud_human_activity_area_2") == 1 && var_00 != 2)
		{
			var_00 = 2;
			level notify("aud_stop_pool_music");
			level notify("aud_stop_pool_music");
			level notify("aud_stop_veranda_walla");
			level notify("aud_start_panic_walla");
			level notify("aud_stop_pool_house_walla");
			soundscripts\_snd_playsound::snd_play_loop_at("mus_irons_guesthouse",(-3675,-791,715),"aud_stop_guest_house_music",1,4);
			soundscripts\_snd_playsound::snd_play_loop_at("irons_guesthouse_walla",(-3550,-879,619),"aud_stop_guest_house_walla",1,4);
			wait(4.5);
			soundscripts\_snd_playsound::snd_play_loop_at("mus_irons_garage_radio",(-731,-920,741),"aud_stop_garage_music",1,4);
			soundscripts\_snd_playsound::snd_play_loop_at("mus_irons_parked_car",(-1189,-3221,676),"aud_stop_parked_car_music",1,4);
		}
		else if(common_scripts\utility::flag("aud_human_activity_area_3") == 1 && var_00 != 3)
		{
			var_00 = 3;
			level notify("aud_stop_guest_house_music");
			level notify("aud_stop_garage_music");
			level notify("aud_stop_parked_car_music");
			level notify("aud_stop_guest_house_walla");
		}

		wait(0.2);
	}
}

//Function Number: 51
aud_security_vent()
{
	soundscripts\_snd_playsound::snd_play_loop_at("irons_security_vent_whine_roof",(-6582,-1112,448),"aud_stop_security_vent",1,1.5);
	soundscripts\_snd_playsound::snd_play_loop_at("irons_ext_air_conditioning_unit_03",(-6729,-1515,181),"aud_stop_security_vent",1,1.5);
	common_scripts\utility::flag_wait("security_center_begin");
	common_scripts\utility::flag_wait("emp_detonated");
	soundscripts\_snd_playsound::snd_play_2d("irons_security_emp_pulse");
	wait(1);
	level notify("aud_stop_security_vent");
	thread aud_security_alarm();
	soundscripts\_snd_playsound::snd_play_at("irons_security_whine_shutdown",(-6582,-1112,448));
	soundscripts\_snd_playsound::snd_play_2d("irons_security_hatch_open");
	soundscripts\_snd_playsound::snd_play_delayed_loop_2d("mus_irons_security",6,undefined,"aud_stop_security_center_music",10,9);
	wait(2.8);
	soundscripts\_audio_music::mus_stop(3);
	wait(2);
	soundscripts\_snd_playsound::snd_play_2d("irons_security_descend_start");
	common_scripts\utility::flag_wait("security_center_wake_up");
	wait(1);
	soundscripts\_snd_playsound::snd_play_2d("irons_security_descent_land");
	wait(1.1);
	soundscripts\_snd_playsound::snd_play_at("irons_security_wakeup",(-6383,-1263,171));
	common_scripts\utility::flag_wait("hack_security_begin");
	common_scripts\utility::flag_wait("player_is_exiting_security_center");
	level notify("aud_stop_security_center_music");
	common_scripts\utility::flag_wait("security_center_exit_complete");
	level notify("aud_stop_drone_wakeup");
	soundscripts\_snd::snd_music_message("mus_penthouse");
	thread aud_reached_penthouse();
	level.aud_lowstealth = 1;
	soundscripts\_snd_playsound::snd_play_loop_2d("mus_irons_low_stealth","aud_stop_lowstealth",20,3);
}

//Function Number: 52
aud_security_plant_emp()
{
	soundscripts\_snd_playsound::snd_play_2d("irons_security_emp_plant");
}

//Function Number: 53
aud_security_alarm()
{
	while(!common_scripts\utility::flag("aud_stop_server_alarm"))
	{
		soundscripts\_snd_playsound::snd_play_at("irons_server_alarm",(-6383,-1263,171),undefined,1,1.5);
		wait(1.3);
	}
}

//Function Number: 54
aud_security_prints()
{
	wait(1);
	soundscripts\_snd_playsound::snd_play_2d("irons_security_prints_start");
	wait(0.9);
	soundscripts\_snd_playsound::snd_play_2d("irons_security_prints");
	wait(1.5);
	soundscripts\_snd_playsound::snd_play_2d("irons_security_prints_end");
}

//Function Number: 55
aud_security_welcome()
{
	wait(2.1);
	soundscripts\_snd_playsound::snd_play_at("ie_cv_welcome",(-6122,-1131,164));
}

//Function Number: 56
aud_security_center_drones_on()
{
	level endon("aud_stop_drone_wakeup");
	soundscripts\_audio_mix_manager::mm_add_submix("irons_int_security_boost_drones",0.1);
	soundscripts\_snd_playsound::snd_play_at("irons_security_drone_group_wakeup",(-6707,-1130,230));
}

//Function Number: 57
aud_security_countdown()
{
	var_00 = 16;
	while(!common_scripts\utility::flag("player_is_out_of_security_center") && var_00 > 1)
	{
		var_01 = gettime();
		if(var_01 - level.aud_last_time > 950)
		{
			soundscripts\_snd_playsound::snd_play_2d("irons_timer_tick");
			level.aud_last_time = var_01;
			var_00 = var_00 - 1;
		}

		wait(0.05);
	}

	common_scripts\utility::flag_set("aud_stop_server_alarm");
	soundscripts\_snd_playsound::snd_play_at("irons_security_vents_wakeup",(-6582,-1112,448));
	wait(0.3);
	soundscripts\_snd_playsound::snd_play_loop_at("irons_security_vent_whine_roof",(-6582,-1112,448),undefined,0.1);
	soundscripts\_snd_playsound::snd_play_loop_at("irons_ext_air_conditioning_unit_03",(-6729,-1515,181),undefined,0.1);
}

//Function Number: 58
aud_security_main_screen()
{
	soundscripts\_snd_playsound::snd_play_at("irons_security_main_screen_boot",(-6122,-1131,164));
}

//Function Number: 59
aud_security_hatch_exit()
{
	wait(0.1);
	soundscripts\_snd_playsound::snd_play_2d("irons_security_exit_hatch");
	soundscripts\_audio_mix_manager::mm_clear_submix("irons_int_security_boost_drones",0.5);
}

//Function Number: 60
aud_vtol_land(param_00)
{
	if(level.aud_vtol_passed == 0)
	{
		param_00 soundscripts\_snd_playsound::snd_play_linked("irons_vtol_landing");
		level.aud_vtol_passed = 1;
	}
}

//Function Number: 61
aud_ball_fountain()
{
	soundscripts\_snd_playsound::snd_play_loop_at("irons_ball_fountain",(-896,-2425,837));
}

//Function Number: 62
aud_security_reboot()
{
	soundscripts\_snd_playsound::snd_play_at("irons_security_reboot",(-6337,-1086,173));
}

//Function Number: 63
aud_estate_grounds_ambience()
{
	soundscripts\_snd_playsound::snd_play_loop_at("irons_amb_grounds_quiet_front",(-7925,-3370,1443),"aud_stop_ext_grounds_ambience",0.05,0.5);
	soundscripts\_snd_playsound::snd_play_loop_at("irons_amb_grounds_quiet_rear",(8151,-3673,1443),"aud_stop_ext_grounds_ambience",0.05,0.5);
}

//Function Number: 64
aud_rooftops_ambience()
{
	level.player endon("death");
	var_00 = spawn("script_origin",(-7925,-3370,1443));
	var_01 = spawn("script_origin",(8151,-3673,1443));
	var_00 soundscripts\_snd_playsound::snd_play_loop("irons_amb_rooftops_front");
	var_01 soundscripts\_snd_playsound::snd_play_loop("irons_amb_rooftops_rear");
	for(;;)
	{
		var_02 = level.player.origin[2];
		if(common_scripts\utility::flag("aud_rooftop_wind_1") == 1)
		{
			level.aud_rooftop_wind_volume = var_02 - 200 / 200;
			soundscripts\_audio_mix_manager::mm_clear_submix("irons_occlude_pool_music");
		}
		else if(common_scripts\utility::flag("aud_rooftop_wind_2") == 1)
		{
			level.aud_rooftop_wind_volume = var_02 - 350 / 350;
			soundscripts\_audio_mix_manager::mm_add_submix("irons_occlude_pool_music");
		}
		else if(common_scripts\utility::flag("aud_rooftop_wind_3") == 1)
		{
			level.aud_rooftop_wind_volume = var_02 - 800 / 800;
			soundscripts\_audio_mix_manager::mm_add_submix("irons_occlude_pool_music");
		}
		else
		{
			level.aud_rooftop_wind_volume = 0.01;
		}

		if(level.aud_rooftop_wind_volume > 1)
		{
			level.aud_rooftop_wind_volume = 1;
		}
		else if(level.aud_rooftop_wind_volume <= 0.01)
		{
			level.aud_rooftop_wind_volume = 0.01;
		}

		var_00 scalevolume(level.aud_rooftop_wind_volume,0.2);
		var_01 scalevolume(level.aud_rooftop_wind_volume,0.2);
		wait(0.2);
	}
}

//Function Number: 65
aud_poolhouse_ambience()
{
	soundscripts\_snd_playsound::snd_play_loop_at("irons_amb_estate_living_front",(-16384,-2944,1443),"aud_stop_poolhouse_ambience",1,1.5);
	soundscripts\_snd_playsound::snd_play_loop_at("irons_amb_estate_living_rear",(19504,-2944,1443),"aud_stop_poolhouse_ambience",1,1.5);
}

//Function Number: 66
aud_estate_living_ambience()
{
	soundscripts\_snd_playsound::snd_play_loop_at("irons_amb_estate_living_front",(-16384,-2944,1443),"aud_stop_estate_living_ambience",1,1.5);
	soundscripts\_snd_playsound::snd_play_loop_at("irons_amb_estate_living_rear",(19504,-2944,1443),"aud_stop_estate_living_ambience",1,1.5);
}

//Function Number: 67
aud_hangar_ambience()
{
	soundscripts\_snd_playsound::snd_play_loop_at("irons_amb_hangar_front",(-16384,-2944,1443),"aud_stop_hangar_ambience",1,1.5);
	soundscripts\_snd_playsound::snd_play_loop_at("irons_amb_hangar_rear",(19504,-2944,1443),"aud_stop_hangar_ambience",1,1.5);
}

//Function Number: 68
aud_estate_security_ambience()
{
	soundscripts\_snd_playsound::snd_play_loop_at("irons_amb_security_center_front",(-16384,-2944,1443),"aud_stop_security_ambience",1,1.5);
	soundscripts\_snd_playsound::snd_play_loop_at("irons_amb_security_center_rear",(19504,-2944,1443),"aud_stop_security_ambience",1,1.5);
}

//Function Number: 69
aud_guard_station_ambience()
{
	soundscripts\_snd_playsound::snd_play_loop_at("irons_amb_guard_station_front",(-16384,-2944,1443),"aud_stop_guard_station_ambience",1,1.5);
	soundscripts\_snd_playsound::snd_play_loop_at("irons_amb_guard_station_rear",(19504,-2944,1443),"aud_stop_guard_station_ambience",1,1.5);
}

//Function Number: 70
aud_approaching_poolhouse()
{
	common_scripts\utility::flag_wait("aud_player_reached_estate");
	level notify("aud_stop_forest_ambience");
	thread aud_estate_grounds_emitters();
	thread stealth_music_control_p1();
	soundscripts\_snd_playsound::snd_play_at("irons_sports_car_distant",(-2988,-5067,1111));
}

//Function Number: 71
aud_tennis_court_wakeup()
{
	soundscripts\_snd_playsound::snd_play_at("irons_tennis_court_wakeup",(-3166,-4927,422));
	soundscripts\_snd_playsound::snd_play_delayed_at("irons_tennis_net_on",(-3166,-4927,422),0.5);
}

//Function Number: 72
aud_garage_lift()
{
	soundscripts\_snd_playsound::snd_play_at("irons_garage_lift_start",(-1100,-1305,686));
	soundscripts\_snd_playsound::snd_play_loop_at("irons_garage_lift_lp",(-1100,-1305,686),"aud_stop_garage_lift",undefined,0.2);
	wait(8);
	soundscripts\_snd_playsound::snd_play_at("irons_garage_lift_stop",(-1100,-1305,686));
	wait(0.05);
	level notify("aud_stop_garage_lift");
}

//Function Number: 73
aud_garage_hyd_wrench()
{
	while(!common_scripts\utility::flag("_stealth_spotted"))
	{
		wait(randomintrange(2,8));
		soundscripts\_snd_playsound::snd_play_at("irons_garage_hyd_wrench",(-1100,-1305,686));
	}
}

//Function Number: 74
aud_reached_penthouse()
{
	common_scripts\utility::flag_wait("aud_player_on_penthouse_balcony");
	soundscripts\_snd_playsound::snd_play_loop_at("irons_pent_grap_kill_scuffle_lp",(752,-3260,1080),"aud_stop_grapple_kill_scuffle",0.5,0.2);
	soundscripts\_snd::snd_music_message("mus_bedroom");
	common_scripts\utility::flag_wait("aud_reached_penthouse");
	level notify("aud_stop_lowstealth");
	level notify("end_stealth_music_control");
	thread aud_guardhouse_foley_cormack();
	common_scripts\utility::flag_wait("intel_end");
	level notify("stop_penthouse_entrance_music");
	soundscripts\_snd::snd_music_message("mus_lockdown");
}

//Function Number: 75
aud_penthouse_front_door()
{
	soundscripts\_snd_playsound::snd_play_at("irons_penthouse_sliding_door_open",(419,-3202,1224));
	common_scripts\utility::flag_wait("player_entered_balcony_door");
	soundscripts\_snd_playsound::snd_play_at("irons_penthouse_sliding_door_close",(419,-3202,1224));
}

//Function Number: 76
aud_cormack_grapple_kill()
{
	thread cormack_grapple_kill_rope();
	thread cormack_intel_foley();
	thread aud_painting_fall();
	soundscripts\_snd_playsound::snd_play_at("irons_pent_grap_kill_door",(752,-3260,1080));
	level notify("aud_stop_grapple_kill_scuffle");
	level.allies[0] soundscripts\_snd_playsound::snd_play_delayed_linked("irons_pent_grap_kill_start_corm",0.5);
}

//Function Number: 77
cormack_grapple_kill_rope()
{
	wait(3.35);
	var_00 = spawn("script_origin",(633,-3376,1073));
	var_00 soundscripts\_snd_playsound::snd_play_linked("irons_pent_grap_kill_end");
	var_01 = (724,-3215,1059);
	var_00 moveto(var_01,0.9);
	wait(5);
	var_00 delete();
}

//Function Number: 78
aud_painting_fall()
{
	soundscripts\_snd_playsound::snd_play_delayed_at("irons_pent_painting_fall",(817,-3291,1033),4.9);
}

//Function Number: 79
cormack_intel_foley()
{
	level.allies[0] soundscripts\_snd_playsound::snd_play_delayed_linked("irons_foley_pent_corm_1",7);
	common_scripts\utility::flag_wait("player_used_intel_trigger");
	level.allies[0] soundscripts\_snd_playsound::snd_play_delayed_linked("irons_foley_pent_corm_2",37.5);
}

//Function Number: 80
aud_intel()
{
	soundscripts\_snd_playsound::snd_play_delayed_2d("irons_foley_pent_plr_1",0.5);
	soundscripts\_snd_playsound::snd_play_delayed_2d("irons_penthouse_desk_ui",3);
	soundscripts\_snd_playsound::snd_play_delayed_2d("irons_foley_pent_plr_1",34.2);
}

//Function Number: 81
aud_lockdown_alarm()
{
	soundscripts\_snd_playsound::snd_play_loop_at("irons_lockdown_alarm",(804,-3809,1067));
}

//Function Number: 82
aud_reinforcements_door1()
{
	soundscripts\_snd_playsound::snd_play_at("irons_pent_reinf_door",(1309,-3776,1090));
}

//Function Number: 83
aud_reinforcements_door2()
{
	soundscripts\_snd_playsound::snd_play_at("irons_pent_reinf_door",(1236,-4442,666));
}

//Function Number: 84
aud_guardhouse_foley_cormack()
{
	level waittill("start_car_ride_moment_anims");
	wait(0.1);
	level.allies[0] soundscripts\_snd_playsound::snd_play_linked("irons_foley_gdhouse_cormack_open_door");
	soundscripts\_audio_music::mus_stop(7);
	thread aud_guard_station_main_door();
	wait(5.7);
	level.allies[0] soundscripts\_snd_playsound::snd_play_linked("irons_foley_gdhouse_cormack_hide");
	level.allies[0] waittillmatch("run_to_street","single anim");
	wait(0.5);
	level.allies[0] soundscripts\_snd_playsound::snd_play_linked("irons_foley_gdhouse_cormack_go_car");
	common_scripts\utility::flag_wait("player_under_car");
	soundscripts\_snd_playsound::snd_play_2d("irons_foley_gdhouse_player_under_car");
	level.allies[0] waittillmatch("roll_out","single anim");
	wait(0.5);
	level.allies[0] soundscripts\_snd_playsound::snd_play_linked("irons_foley_gdhouse_cormack_rollout_car");
	wait(0.5);
	soundscripts\_snd_playsound::snd_play_2d("irons_foley_gdhouse_player_rollout_car");
}

//Function Number: 85
aud_guard_station_main_door()
{
	wait(0.9);
	soundscripts\_snd_playsound::snd_play_at("irons_guard_house_main_door_open",(1885,-4332,694));
	wait(0.1);
	soundscripts\_snd_playsound::snd_play_at("irons_guard_house_door_alarm",(1810,-4397,663));
}

//Function Number: 86
aud_conduit_smash()
{
	soundscripts\_snd_playsound::snd_play_at("irons_guard_house_conduit_smash",(1917,-4363,698));
}

//Function Number: 87
aud_trucks_arrive()
{
	wait(3);
	soundscripts\_audio_mix_manager::mm_add_submix("irons_music_dim_6dB");
	thread aud_truck1_engine_pullup();
	thread aud_truck2_engine_pullup();
	wait(5);
	thread aud_grates();
	wait(7);
	thread aud_truck2_engine_idle();
	thread aud_truck2_engine_drive();
	soundscripts\_audio_mix_manager::mm_clear_submix("irons_music_dim_6dB");
	wait(29);
	thread aud_hangar_ambience();
	thread aud_hangar_walla();
}

//Function Number: 88
aud_truck1_engine_pullup()
{
	level.gaz2 soundscripts\_snd_playsound::snd_play_linked("irons_truck1_arrives");
}

//Function Number: 89
aud_truck2_engine_pullup()
{
	level.gaz soundscripts\_snd_playsound::snd_play_linked("irons_truck2_arrives","aud_gaz2_engine_stop_notify",undefined,1.5);
	wait(13);
	level notify("aud_gaz2_engine_stop_notify");
}

//Function Number: 90
aud_grates()
{
	soundscripts\_snd_playsound::snd_play_at("irons_tires_grate_1",(2104,-4453,627));
	wait(1);
	soundscripts\_snd_playsound::snd_play_at("irons_tires_grate_2",(2104,-4190,627));
}

//Function Number: 91
aud_truck2_engine_idle()
{
	soundscripts\_snd_playsound::snd_play_loop_at("irons_truck2_idle",level.gaz.origin,"aud_gaz2_idle_stop_notify",1.5,1.5);
	soundscripts\_snd_playsound::snd_play_loop_at("irons_exhaust_pipe_close",(2093,-4239,636),"aud_gaz2_idle_stop_notify",2,2);
	common_scripts\utility::flag_wait("player_under_car");
	soundscripts\_audio_mix_manager::mm_add_submix("irons_vehicle_ride");
	wait(9.6);
	level notify("aud_gaz2_idle_stop_notify");
}

//Function Number: 92
aud_truck2_engine_drive()
{
	common_scripts\utility::flag_wait("player_under_car");
	wait(7.4);
	level.gaz2 soundscripts\_snd_playsound::snd_play_linked("irons_truck1_drive");
	wait(1.7);
	level.gaz soundscripts\_snd_playsound::snd_play_linked("irons_truck2_drive");
}

//Function Number: 93
aud_vehicle_ride_data()
{
	wait(1.2);
	soundscripts\_snd_playsound::snd_play_2d("irons_vehicle_ride_data");
	wait(8.65);
	soundscripts\_snd_playsound::snd_play_2d("irons_vehicle_ride_data_end");
}

//Function Number: 94
aud_tire_splash()
{
	soundscripts\_snd_playsound::snd_play_2d("irons_tire_splash");
}

//Function Number: 95
aud_hangar_car_door_exit()
{
	soundscripts\_snd_playsound::snd_play_at("irons_hangar_car_door_exit",(4265,-2205,503));
	soundscripts\_audio_music::mus_stop(8);
	wait(0.75);
	soundscripts\_snd_playsound::snd_play_at("irons_foley_hangar_doctor_fs",(4265,-2205,503));
	wait(0.6);
	soundscripts\_snd_playsound::snd_play_at("irons_foley_hangar_workers_fs",(4437,-2157,498));
	wait(5);
	soundscripts\_audio_mix_manager::mm_clear_submix("irons_vehicle_ride");
}

//Function Number: 96
aud_hangar_walla()
{
	soundscripts\_snd_playsound::snd_play_loop_at("irons_hangar_walla",(4873,-2330,679),"aud_stop_hangar_walla",1,1);
}

//Function Number: 97
aud_monitor_irons()
{
	soundscripts\_snd_playsound::snd_play_delayed_2d("irons_hang_surv_start",2);
	soundscripts\_snd_playsound::snd_play_delayed_2d("irons_hang_surv_bg",3,undefined,"aud_stop_surveillance_bg");
	soundscripts\_snd_playsound::snd_play_delayed_2d("irons_hang_surv_1",3);
	soundscripts\_snd_playsound::snd_play_delayed_2d("irons_hang_surv_2",7.95);
	soundscripts\_snd_playsound::snd_play_delayed_2d("irons_hang_surv_3",16.45);
	soundscripts\_snd_playsound::snd_play_delayed_2d("irons_hang_surv_4",28);
	soundscripts\_snd_playsound::snd_play_delayed_at("irons_hangar_lift",(5058,-2230,649),31);
	soundscripts\_snd_playsound::snd_play_delayed_2d("irons_hang_surv_end",37.4);
	wait(3);
	soundscripts\_audio_mix_manager::mm_add_submix("irons_listening_hangar");
	wait(23);
	soundscripts\_audio_mix_manager::mm_clear_submix("irons_listening_hangar");
	wait(11.2);
	level notify("aud_stop_surveillance_bg");
}

//Function Number: 98
aud_exfil_vtol_start()
{
	level.vtol soundscripts\_snd_playsound::snd_play_linked("irons_vtol_start","aud_fade_out_vtol_start",0,3);
	soundscripts\_audio_music::mus_play("mus_irons_exfil_hangar");
}

//Function Number: 99
aud_exfil_door_1()
{
	wait(0.45);
	level.allies[0] soundscripts\_snd_playsound::snd_play_linked("irons_finale_door_1");
	wait(0.05);
	soundscripts\_snd_playsound::snd_play_loop_at("irons_finale_jet_interior_idle",(4072,-2871,1084),"aud_stop_interior_idle",0,0.3);
	level.allies[0] soundscripts\_snd_playsound::snd_play_linked("irons_finale_cormack_foley","aud_stop_finale_stairs_foley");
}

//Function Number: 100
aud_exfil_door_2a()
{
	level.allies[0] soundscripts\_snd_playsound::snd_play_delayed_linked("irons_finale_door_2",0.3);
	level notify("aud_stop_finale_stairs_foley");
	soundscripts\_audio_music::mus_play("mus_irons_exfil_vtol",undefined,0.3);
	soundscripts\_snd_playsound::snd_play_delayed_2d("irons_vtol_takeoff_stinger",2.25);
}

//Function Number: 101
aud_exfil_door_2b()
{
	level.allies[0] soundscripts\_snd_playsound::snd_play_delayed_linked("irons_finale_door_2_kick",0.15);
	level.allies[0] soundscripts\_snd_playsound::snd_play_delayed_linked("irons_finale_door_2",3.1);
	soundscripts\_snd_playsound::snd_play_delayed_2d("irons_vtol_takeoff_stinger",5.35);
	wait(4.1);
	soundscripts\_audio_music::mus_play("mus_irons_exfil_vtol",undefined,0.3);
}

//Function Number: 102
aud_exfil_vtol_ascend()
{
	thread aud_vtol_exterior_idle();
	common_scripts\utility::flag_wait("start_exfil_moment_final_liftoff_started");
	level notify("aud_fade_out_exterior_idle");
	level.vtol soundscripts\_snd_playsound::snd_play_linked("irons_finale_jet_takeoff_start");
	level.vtol soundscripts\_snd_playsound::snd_play_delayed_linked("irons_vtol_ascend",0.3,undefined,"finale_grapple_success",0,0.3);
	wait(2.25);
	soundscripts\_snd_playsound::snd_play_2d("irons_vtol_takeoff_stinger");
}

//Function Number: 103
aud_vtol_exterior_idle()
{
	var_00 = level.vtol soundscripts\_snd_playsound::snd_play_loop_linked("irons_finale_jet_exterior_idle","aud_fade_out_exterior_idle",0.05,0.2);
	level notify("aud_stop_interior_idle");
	wait(2);
	var_00 scalepitch(1.5,30);
}

//Function Number: 104
aud_exfil_vtol_grapple()
{
	level notify("finale_grapple_success");
	var_00 = level.vtol.origin[2];
	var_01 = level.player.origin[2];
	var_02 = var_00 - var_01 / 2500;
	soundscripts\_snd_playsound::snd_play_delayed_2d("irons_vtol_grapple",var_02);
	soundscripts\_snd_playsound::snd_play_delayed_2d("irons_finale_onboard_front",var_02);
	wait(var_02);
	thread aud_exfil_vtol_wind();
	thread aud_vtol_excellerate_end();
	level.player waittill("grappled_to_vtol");
	soundscripts\_snd_playsound::snd_play_delayed_2d("irons_finale_tracker_plant",0.3);
	thread aud_detach_from_vtol();
}

//Function Number: 105
aud_vtol_excellerate_start()
{
	wait(5);
	soundscripts\_snd_playsound::snd_play_2d("irons_vtol_accelerate_start");
}

//Function Number: 106
aud_vtol_excellerate_end()
{
	level.vtol waittillmatch("rumble_heavy1","single anim");
	soundscripts\_snd_playsound::snd_play_2d("irons_vtol_accelerate_end");
}

//Function Number: 107
aud_exfil_vtol_wind()
{
	wait(1);
	soundscripts\_snd_playsound::snd_play_loop_2d("irons_vtol_wind","aud_fade_out_vtol_wind",1,6);
	wait(1);
	soundscripts\_snd_playsound::snd_play_loop_2d("mus_irons_exfil_vtol_grappled_layer","aud_fade_out_vtol_grappled_layer",3,5);
}

//Function Number: 108
aud_detach_from_vtol()
{
	common_scripts\utility::flag_wait("DETACHED_FROM_VTOL");
	soundscripts\_audio_music::mus_stop(0.5);
	soundscripts\_snd_playsound::snd_play_2d("mus_irons_end");
	soundscripts\_snd_playsound::snd_play_2d("irons_vtol_fall_start","aud_fade_out_vtol_fall_start",undefined,0.1);
	soundscripts\_snd_playsound::snd_play_2d("irons_finale_detach_front","aud_fade_out_vtol_fall_start",undefined,0.1);
	level notify("aud_fade_out_vtol_start");
	wait(0.1);
	level notify("aud_fade_out_vtol_ascend");
	wait(0.1);
	level notify("aud_fade_out_vtol_wind");
	wait(0.1);
	level notify("aud_fade_out_vtol_grappled_layer");
	wait(0.1);
	level notify("aud_stop_ext_grounds_ambience");
	soundscripts\_audio_mix_manager::mm_add_submix("irons_detach_from_vtol",1);
	wait(2.1);
	soundscripts\_snd_playsound::snd_play_delayed_2d("irons_vtol_fall_end",4.3);
	soundscripts\_snd_playsound::snd_play_delayed_2d("irons_finale_water_front",4.3);
	wait(5);
	maps\_water::setunderwateraudiozone();
	soundscripts\_snd_playsound::snd_play_delayed_2d("irons_end_scuba_foley",10);
}

//Function Number: 109
stealth_music_control_p1()
{
	level endon("end_stealth_music_control");
	for(;;)
	{
		if(level.aud_old_music_state != level.aud_music_state || level.aud_music_state == 0)
		{
			level.aud_old_music_state = level.aud_music_state;
			switch(level.aud_music_state)
			{
				case 0:
					if(level.aud_drone_investigating == 0)
					{
						level.aud_drone_attack = 0;
						soundscripts\_audio_music::mus_stop(8);
						soundscripts\_audio_mix_manager::mm_clear_submix("irons_stealth_broken");
					}
					break;
	
				case 1:
					if(level.aud_drone_attack == 0)
					{
						soundscripts\_audio_music::mus_play("mus_irons_stealth_01",6,5);
					}
		
					soundscripts\_audio_mix_manager::mm_add_submix("irons_stealth_broken");
					break;
	
				case 2:
					if(level.aud_drone_attack == 0)
					{
						soundscripts\_audio_music::mus_play("mus_irons_alerted_01",5,4);
					}
		
					soundscripts\_audio_mix_manager::mm_add_submix("irons_stealth_broken");
					break;
	
				case 3:
					level.aud_drone_attack = 1;
					soundscripts\_audio_music::mus_play("mus_irons_spotted_01",3,3);
					soundscripts\_audio_mix_manager::mm_add_submix("irons_stealth_broken");
					break;
			}
		}

		wait(0.05);
	}
}

//Function Number: 110
stealth_music_control_p2()
{
	level endon("end_stealth_music_control");
	for(;;)
	{
		if(level.aud_old_music_state != level.aud_music_state || level.aud_music_state == 0)
		{
			level.aud_old_music_state = level.aud_music_state;
			switch(level.aud_music_state)
			{
				case 0:
					if(level.aud_drone_investigating == 0)
					{
						level.aud_drone_attack = 0;
						soundscripts\_audio_music::mus_stop(8);
						soundscripts\_audio_mix_manager::mm_clear_submix("irons_stealth_broken");
						if(level.aud_lowstealth == 0)
						{
							level.aud_lowstealth = 1;
							soundscripts\_snd_playsound::snd_play_loop_2d("mus_irons_low_stealth","aud_stop_lowstealth",20,3);
						}
					}
					break;
	
				case 1:
					if(level.aud_drone_attack == 0)
					{
						soundscripts\_audio_music::mus_play("mus_irons_stealth_02",6,5);
					}
		
					soundscripts\_audio_mix_manager::mm_add_submix("irons_stealth_broken");
					level notify("aud_stop_lowstealth");
					level.aud_lowstealth = 0;
					break;
	
				case 2:
					if(level.aud_drone_attack == 0)
					{
						soundscripts\_audio_music::mus_play("mus_irons_alerted_02",5,4);
					}
		
					soundscripts\_audio_mix_manager::mm_add_submix("irons_stealth_broken");
					level notify("aud_stop_lowstealth");
					level.aud_lowstealth = 0;
					break;
	
				case 3:
					level.aud_drone_attack = 1;
					soundscripts\_audio_music::mus_play("mus_irons_spotted_02",3,3);
					soundscripts\_audio_mix_manager::mm_add_submix("irons_stealth_broken");
					level notify("aud_stop_lowstealth");
					level.aud_lowstealth = 0;
					break;
			}
		}

		wait(0.05);
	}
}

//Function Number: 111
aud_panic_walla()
{
	if(common_scripts\utility::flag("aud_human_activity_area_1") == 1)
	{
		soundscripts\_snd_playsound::snd_play_loop_at("irons_panic_walla",(-6356,-2859,233),undefined,1);
		return;
	}

	if(common_scripts\utility::flag("aud_human_activity_area_2") == 1)
	{
		soundscripts\_snd_playsound::snd_play_loop_at("irons_panic_walla",(-3550,-879,619),undefined,1);
	}
}

//Function Number: 112
aud_foliage_movement()
{
	level.player endon("death");
	var_00 = level.player soundscripts\_snd_playsound::snd_play_loop_linked("irons_foliage_movement_plr_lp");
	var_00 setvolume(0,0);
	var_01 = 0;
	while(isdefined(var_00))
	{
		if(common_scripts\utility::flag("aud_foliage_1") == 1 || common_scripts\utility::flag("aud_foliage_2") == 1 || common_scripts\utility::flag("aud_foliage_3") == 1)
		{
			var_02 = distance(level.player getvelocity(),(0,0,0));
			if(var_02 > 0)
			{
				if(level.player getstance() == "crouch")
				{
					var_02 = var_02 / 140;
				}
				else if(level.player getstance() == "prone")
				{
					var_02 = var_02 / 30;
				}
				else
				{
					var_02 = var_02 / 220;
				}
			}

			if(var_02 > 1)
			{
				var_02 = 1;
			}

			if(common_scripts\utility::flag("aud_grapple_kill_foliage_movement"))
			{
				var_00 scalevolume(1,0.1);
				while(common_scripts\utility::flag("aud_grapple_kill_foliage_movement"))
				{
					wait(0.1);
				}

				var_00 scalevolume(0,0.8);
			}
			else
			{
				var_00 scalevolume(var_02,0.1);
			}

			thread aud_foliage_insects();
			continue;
		}

		var_00 scalevolume(0,0.6);
		wait(0.2);
	}
}

//Function Number: 113
aud_foliage_mix()
{
	level.player endon("death");
	var_00 = "stand";
	for(;;)
	{
		var_01 = level.player getstance();
		if(var_01 != var_00)
		{
			if(common_scripts\utility::flag("aud_foliage_1") == 1 || common_scripts\utility::flag("aud_foliage_2") == 1 || common_scripts\utility::flag("aud_foliage_3") == 1)
			{
				if(var_01 == "crouch")
				{
					soundscripts\_audio_mix_manager::mm_add_submix("irons_player_in_foliage_crouch",0.5);
					soundscripts\_audio_mix_manager::mm_clear_submix("irons_player_in_foliage_prone",0.5);
					soundscripts\_audio_mix_manager::mm_clear_submix("irons_player_in_foliage_stand",0.5);
				}
				else if(var_01 == "prone")
				{
					soundscripts\_audio_mix_manager::mm_clear_submix("irons_player_in_foliage_crouch",0.5);
					soundscripts\_audio_mix_manager::mm_add_submix("irons_player_in_foliage_prone",0.5);
					soundscripts\_audio_mix_manager::mm_clear_submix("irons_player_in_foliage_stand",0.5);
				}
				else
				{
					soundscripts\_audio_mix_manager::mm_clear_submix("irons_player_in_foliage_crouch",0.5);
					soundscripts\_audio_mix_manager::mm_clear_submix("irons_player_in_foliage_prone",0.5);
					soundscripts\_audio_mix_manager::mm_add_submix("irons_player_in_foliage_stand",0.5);
				}
			}
			else
			{
				soundscripts\_audio_mix_manager::mm_clear_submix("irons_player_in_foliage_crouch",0.5);
				soundscripts\_audio_mix_manager::mm_clear_submix("irons_player_in_foliage_prone",0.5);
				soundscripts\_audio_mix_manager::mm_clear_submix("irons_player_in_foliage_stand",0.5);
			}
		}

		var_00 = var_01;
		wait(0.2);
	}
}

//Function Number: 114
aud_foliage_insects()
{
	if(randomint(100) > 94 && level.aud_insect_sound == 0)
	{
		level.aud_insect_sound = 1;
		if(randomint(10) == 0)
		{
			var_00 = level.player.origin + (randomintrange(-50,50),randomintrange(-50,50),0);
			soundscripts\_snd_playsound::snd_play_at("irons_insect_buzz",var_00);
		}
		else
		{
			var_01 = randomint(4);
			switch(var_01)
			{
				case 0:
					var_02 = level.player.origin + (randomintrange(-1000,1000),randomintrange(-1000,1000),0);
					var_03 = randomint(7);
					for(var_04 = 0;var_04 < var_03;var_04++)
					{
						soundscripts\_snd_playsound::snd_play_at("irons_insect_chirp_a",var_02);
						wait(0.8);
					}
					break;

				case 1:
					var_05 = level.player.origin + (randomintrange(-1000,1000),randomintrange(-1000,1000),0);
					var_03 = randomint(4);
					for(var_04 = 0;var_04 < var_03;var_04++)
					{
						soundscripts\_snd_playsound::snd_play_at("irons_insect_chirp_b",var_05);
						wait(0.7);
					}
					break;

				case 2:
					var_06 = level.player.origin + (randomintrange(-1000,1000),randomintrange(-1000,1000),0);
					var_03 = randomint(7);
					for(var_04 = 0;var_04 < var_03;var_04++)
					{
						soundscripts\_snd_playsound::snd_play_at("irons_insect_chirp_c",var_06);
						wait(0.75);
					}
					break;

				case 3:
					var_07 = level.player.origin + (randomintrange(-1000,1000),randomintrange(-1000,1000),0);
					var_03 = randomint(4);
					for(var_04 = 0;var_04 < var_03;var_04++)
					{
						soundscripts\_snd_playsound::snd_play_at("irons_insect_chirp_d",var_07);
						wait(0.5);
					}
					break;

				case 4:
					var_08 = level.player.origin + (randomintrange(-1000,1000),randomintrange(-1000,1000),0);
					soundscripts\_snd_playsound::snd_play_at("irons_insect_chirp_random",var_08);
					break;
			}
		}

		wait(1);
		level.aud_insect_sound = 0;
	}
}

//Function Number: 115
aud_grapple_kill_foliage()
{
	if(common_scripts\utility::flag("aud_foliage_1") == 1 || common_scripts\utility::flag("aud_foliage_2") == 1 || common_scripts\utility::flag("aud_foliage_3") == 1)
	{
		soundscripts\_snd_playsound::snd_play_2d("irons_stealth_kill_foliage");
		common_scripts\utility::flag_set("aud_grapple_kill_foliage_movement");
		wait(3);
		common_scripts\utility::flag_clear("aud_grapple_kill_foliage_movement");
	}
}

//Function Number: 116
aud_grapple_from_foliage()
{
	if(common_scripts\utility::flag("aud_foliage_1") == 1 || common_scripts\utility::flag("aud_foliage_2") == 1 || common_scripts\utility::flag("aud_foliage_3") == 1)
	{
		wait(0.2);
		soundscripts\_snd_playsound::snd_play_2d("irons_foliage_collision");
	}
}

//Function Number: 117
aud_stealth_melee()
{
	soundscripts\_audio_mix_manager::mm_add_submix("irons_stealth_melee");
	wait(1.2);
	soundscripts\_audio_mix_manager::mm_clear_submix("irons_stealth_melee");
}

//Function Number: 118
forklift_audio_loop()
{
	for(;;)
	{
		self waittillmatch("forklift_sound_001","looping anim");
		wait(1);
		soundscripts\_snd_playsound::snd_play_linked("irons_hangar_forklift_path2");
		self waittillmatch("forklift_sound_300","looping anim");
		wait(0.3);
		soundscripts\_snd_playsound::snd_play_linked("irons_hangar_forklift_slow_to_stop");
		wait(3.2);
		soundscripts\_snd_playsound::snd_play_linked("irons_hangar_forklift_reverse_beeps");
		wait(0.3);
		soundscripts\_snd_playsound::snd_play_linked("irons_hangar_forklift_3p_turn");
		wait(2);
		soundscripts\_snd_playsound::snd_play_linked("irons_hangar_forklift_path1");
		self waittillmatch("forklift_sound_700","looping anim");
		wait(0.5);
		soundscripts\_snd_playsound::snd_play_linked("irons_hangar_forklift_slow_to_stop");
	}
}