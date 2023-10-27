/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\killhouse_aud.gsc
 * Game: Call of Duty: Modern Warfare Remastered
 * Platform: PC
 * Function Count: 39
 * Decompile Time: 627 ms
 * Timestamp: 10/27/2023 2:46:03 AM
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
	soundscripts\_audio::set_stringtable_mapname("shg");
	soundscripts\_snd_filters::snd_set_occlusion("med_occlusion");
	soundscripts\_audio_mix_manager::mm_add_submix("mix_killhouse_global");
	aud_deactivate_hangar_transition_zone();
}

//Function Number: 3
init_snd_flags()
{
}

//Function Number: 4
init_globals()
{
}

//Function Number: 5
launch_threads()
{
}

//Function Number: 6
launch_loops()
{
}

//Function Number: 7
launch_line_emitters()
{
	wait(0.1);
}

//Function Number: 8
create_level_envelop_arrays()
{
}

//Function Number: 9
precache_presets()
{
}

//Function Number: 10
register_snd_messages()
{
	soundscripts\_snd::snd_register_message("start_inside_checkpoint",::start_inside_checkpoint);
	soundscripts\_snd::snd_register_message("start_look_training_checkpoint",::start_look_training_checkpoint);
	soundscripts\_snd::snd_register_message("start_rifle_start_checkpoint",::start_rifle_start_checkpoint);
	soundscripts\_snd::snd_register_message("start_rifle_timed_start_checkpoint",::start_rifle_timed_start_checkpoint);
	soundscripts\_snd::snd_register_message("start_sidearm_start_checkpoint",::start_sidearm_start_checkpoint);
	soundscripts\_snd::snd_register_message("start_frag_start_checkpoint",::start_frag_start_checkpoint);
	soundscripts\_snd::snd_register_message("start_launcher_start_checkpoint",::start_launcher_start_checkpoint);
	soundscripts\_snd::snd_register_message("start_explosives_start_checkpoint",::start_explosives_start_checkpoint);
	soundscripts\_snd::snd_register_message("start_course_start_checkpoint",::start_course_start_checkpoint);
	soundscripts\_snd::snd_register_message("start_reveal_start_checkpoint",::start_reveal_start_checkpoint);
	soundscripts\_snd::snd_register_message("start_cargoship_start_checkpoint",::start_cargoship_start_checkpoint);
	soundscripts\_snd::snd_register_message("start_debrief_start_checkpoint",::start_debrief_start_checkpoint);
	soundscripts\_snd::snd_register_message("start_fade_to_black_end",::start_fade_to_black_end);
}

//Function Number: 11
zone_handler(param_00,param_01)
{
}

//Function Number: 12
music_handler(param_00,param_01)
{
}

//Function Number: 13
start_inside_checkpoint(param_00)
{
	soundscripts\_audio_zone_manager::azm_start_zone("hangar1");
}

//Function Number: 14
start_look_training_checkpoint(param_00)
{
	soundscripts\_audio_zone_manager::azm_start_zone("hangar1");
}

//Function Number: 15
start_rifle_start_checkpoint(param_00)
{
	soundscripts\_audio_zone_manager::azm_start_zone("hangar1");
}

//Function Number: 16
start_rifle_timed_start_checkpoint(param_00)
{
	soundscripts\_audio_zone_manager::azm_start_zone("hangar1");
}

//Function Number: 17
start_sidearm_start_checkpoint(param_00)
{
	soundscripts\_audio_zone_manager::azm_start_zone("hangar1");
}

//Function Number: 18
start_frag_start_checkpoint(param_00)
{
	soundscripts\_audio_zone_manager::azm_start_zone("exterior");
}

//Function Number: 19
start_launcher_start_checkpoint(param_00)
{
	soundscripts\_audio_zone_manager::azm_start_zone("exterior");
}

//Function Number: 20
start_explosives_start_checkpoint(param_00)
{
	soundscripts\_audio_zone_manager::azm_start_zone("exterior");
}

//Function Number: 21
start_course_start_checkpoint(param_00)
{
	soundscripts\_audio_zone_manager::azm_start_zone("exterior");
}

//Function Number: 22
start_reveal_start_checkpoint(param_00)
{
	soundscripts\_audio_zone_manager::azm_start_zone("exterior");
}

//Function Number: 23
start_cargoship_start_checkpoint(param_00)
{
	soundscripts\_audio_zone_manager::azm_start_zone("hangar2");
}

//Function Number: 24
start_debrief_start_checkpoint(param_00)
{
	soundscripts\_audio_zone_manager::azm_start_zone("hangar2");
}

//Function Number: 25
aud_deactivate_hangar_transition_zone()
{
	var_00 = getent("hangar_audio_transition_zone","targetname");
	var_00 common_scripts\utility::trigger_off();
}

//Function Number: 26
aud_activate_hangar_transition_zone()
{
	maps\_utility::enable_trigger_with_targetname("hangar_audio_transition_zone");
}

//Function Number: 27
aud_disable_bm21_idle()
{
	var_00 = getent("bm21_no_sound_01","targetname");
	var_00 vehicle_turnengineoff();
}

//Function Number: 28
aud_bm21_driveby_snd(param_00)
{
	param_00 vehicle_turnengineoff();
	var_01 = aud_entity_link_on_tag("scn_truck_passby_close_tire_left",param_00,"tag_wheel_back_left");
	var_02 = aud_entity_link_on_tag("scn_truck_passby_close_tire_right",param_00,"tag_wheel_back_right");
	var_03 = aud_entity_link_on_tag("scn_truck_passby_engine",param_00,"tag_body");
	var_04 = aud_vehicle_node_handler("vehicle_near_end_node");
	var_05 = aud_entity_link_on_tag("truck_brakesqueal",param_00,"tag_body");
	var_05 scalevolume(0,0);
	var_05 playloopsound("truck_idle_high");
	var_05 scalevolume(1,0.2);
	var_01 scalevolume(0,2);
	var_02 scalevolume(0,2);
	var_03 scalevolume(0,0.8);
	var_06 = aud_vehicle_node_handler("vehicle_end_node");
	var_01 stopsounds();
	var_02 stopsounds();
	var_03 stopsounds();
	var_01 delete();
	var_02 delete();
	var_03 delete();
}

//Function Number: 29
aud_entity_link_on_tag(param_00,param_01,param_02)
{
	var_03 = spawn("script_origin",(0,0,0));
	var_03 linkto(param_01,param_02,(0,0,0),(0,0,0));
	var_03 playloopsound(param_00);
	return var_03;
}

//Function Number: 30
aud_vehicle_node_handler(param_00)
{
	var_01 = maps\_utility::getent_or_struct_or_node(param_00,"script_noteworthy");
	var_01 waittill("trigger",var_02);
}

//Function Number: 31
aud_timer_end()
{
	var_00 = getent("timerEntity","targetname");
	var_00 playsound("scn_timer_end");
}

//Function Number: 32
aud_jet_passby()
{
	var_00 = maps\_utility::getent_or_struct_or_node("jet01_sound","script_noteworthy");
	var_01 = maps\_utility::getent_or_struct_or_node("jet02_sound","script_noteworthy");
	thread aud_jet_start_node_handler(var_00);
	thread aud_jet_start_node_handler(var_01);
}

//Function Number: 33
aud_jet_start_node_handler(param_00)
{
	param_00 waittill("trigger",var_01);
	wait(0.9);
	var_01 thread maps\_utility::play_sound_on_entity("scn_mig29_passby");
	var_01 thread maps\_utility::play_sound_on_entity("veh_mig29_passby_layer");
}

//Function Number: 34
aud_vehicle_driveby_manager()
{
	if(self.vehicletype == "bm21_troops")
	{
		soundscripts\_audio_mix_manager::mm_add_submix("bm21_engine_mute");
		thread maps\_utility::play_sound_on_entity("scn_bm21_break");
		thread maps\_utility::play_sound_on_entity("scn_bm21_horn");
		return;
	}

	thread maps\_utility::play_sound_on_entity("scn_jeep_break");
	thread maps\_utility::play_sound_on_entity("scn_jeep_horn");
}

//Function Number: 35
aud_vehicle_driveby_reset()
{
	if(self.vehicletype == "bm21_troops")
	{
		soundscripts\_audio_mix_manager::mm_clear_submix("bm21_engine_mute");
		thread maps\_utility::play_sound_on_entity("scn_bm21_start");
	}
}

//Function Number: 36
aud_bm21_tire_sounds()
{
	if(self.vehicletype == "bm21_troops")
	{
		var_00 = aud_entity_link_on_tag("scn_truck_passby_close_tire_left",self,"tag_wheel_back_left");
		var_01 = aud_entity_link_on_tag("scn_truck_passby_close_tire_right",self,"tag_wheel_back_right");
	}
}

//Function Number: 37
aud_fail_mix()
{
	level waittill("mission failed");
	soundscripts\_audio_mix_manager::mm_add_submix("fail_mix");
}

//Function Number: 38
aud_hangar_amb_ext()
{
	var_00 = spawn("script_origin",(3077.4,-1176.59,139.321));
	var_01 = spawn("script_origin",(3056.51,-1177.58,137.088));
	var_00 thread common_scripts\utility::play_loop_sound_on_entity("h1_emt_walla_military_int");
	var_01 thread common_scripts\utility::play_loop_sound_on_entity("amb_hangar_int_windows_outside_lp");
	level waittill("DespawnGuysHangar1");
	wait(3);
	var_00 delete();
	var_01 delete();
}

//Function Number: 39
start_fade_to_black_end()
{
	soundscripts\_audio_mix_manager::mm_add_submix("fade_to_black_end_mix");
}