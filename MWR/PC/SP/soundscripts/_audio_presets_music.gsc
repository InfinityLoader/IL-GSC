/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: soundscripts\_audio_presets_music.gsc
 * Game: Call of Duty: Modern Warfare Remastered
 * Platform: PC
 * Function Count: 22
 * Decompile Time: 366 ms
 * Timestamp: 10/27/2023 2:50:29 AM
*******************************************************************/

//Function Number: 1
detroit_music_preset_constructor()
{
	var_00 = 0.1;
	var_01 = 0.05;
	soundscripts\_audio_vehicle_manager::avm_begin_preset_def("detroit_music");
	soundscripts\_audio_vehicle_manager::avm_add_envelope("env_low_intensity",[[0,1],[0.25,0.5],[1,0]]);
	soundscripts\_audio_vehicle_manager::avm_add_envelope("env_high_intensity",[[0,0],[0.25,0.75],[1,1]]);
	soundscripts\_audio_vehicle_manager::avm_begin_loop_data(5,var_00,var_01);
	soundscripts\_audio_vehicle_manager::avm_begin_loop_def("mus_dtrt_refugee_camp");
	soundscripts\_audio_vehicle_manager::avm_begin_param_map("ams_intensity");
	soundscripts\_audio_vehicle_manager::avm_add_param_map_env("volume","env_low_intensity");
	soundscripts\_audio_vehicle_manager::avm_end_param_map();
	soundscripts\_audio_vehicle_manager::avm_end_loop_def();
	soundscripts\_audio_vehicle_manager::avm_begin_loop_def("mus_dtrt_school");
	soundscripts\_audio_vehicle_manager::avm_begin_param_map("ams_intensity");
	soundscripts\_audio_vehicle_manager::avm_add_param_map_env("volume","env_low_intensity");
	soundscripts\_audio_vehicle_manager::avm_end_param_map();
	soundscripts\_audio_vehicle_manager::avm_end_loop_def();
	soundscripts\_audio_vehicle_manager::avm_begin_loop_def("mus_dtrt_low_tension1");
	soundscripts\_audio_vehicle_manager::avm_begin_param_map("ams_intensity");
	soundscripts\_audio_vehicle_manager::avm_add_param_map_env("volume","env_low_intensity");
	soundscripts\_audio_vehicle_manager::avm_end_param_map();
	soundscripts\_audio_vehicle_manager::avm_end_loop_def();
	soundscripts\_audio_vehicle_manager::avm_begin_loop_def("mus_dtrt_low_tension2");
	soundscripts\_audio_vehicle_manager::avm_begin_param_map("ams_intensity");
	soundscripts\_audio_vehicle_manager::avm_add_param_map_env("volume","env_low_intensity");
	soundscripts\_audio_vehicle_manager::avm_end_param_map();
	soundscripts\_audio_vehicle_manager::avm_end_loop_def();
	soundscripts\_audio_vehicle_manager::avm_begin_loop_def("mus_dtrt_low_tension3");
	soundscripts\_audio_vehicle_manager::avm_begin_param_map("ams_intensity");
	soundscripts\_audio_vehicle_manager::avm_add_param_map_env("volume","env_low_intensity");
	soundscripts\_audio_vehicle_manager::avm_end_param_map();
	soundscripts\_audio_vehicle_manager::avm_end_loop_def();
	soundscripts\_audio_vehicle_manager::avm_begin_loop_def("mus_dtrt_generic_combat");
	soundscripts\_audio_vehicle_manager::avm_begin_param_map("ams_intensity");
	soundscripts\_audio_vehicle_manager::avm_add_param_map_env("volume","env_high_intensity");
	soundscripts\_audio_vehicle_manager::avm_end_param_map();
	soundscripts\_audio_vehicle_manager::avm_end_loop_def();
	soundscripts\_audio_vehicle_manager::avm_end_loop_data();
	soundscripts\_audio_vehicle_manager::avm_begin_oneshot_data();
	soundscripts\_audio_vehicle_manager::avm_end_oneshot_data();
	soundscripts\_audio_vehicle_manager::avm_begin_behavior_data();
	soundscripts\_audio_vehicle_manager::avm_begin_behavior_def("to_refugee_camp",::to_refugee_camp);
	soundscripts\_audio_vehicle_manager::avm_add_loops(["mus_dtrt_refugee_camp","mus_dtrt_generic_combat"]);
	soundscripts\_audio_vehicle_manager::avm_end_behavior_def();
	soundscripts\_audio_vehicle_manager::avm_begin_behavior_def("to_school1",::to_school1);
	soundscripts\_audio_vehicle_manager::avm_add_loops(["mus_dtrt_low_tension1","mus_dtrt_generic_combat"]);
	soundscripts\_audio_vehicle_manager::avm_end_behavior_def();
	soundscripts\_audio_vehicle_manager::avm_begin_behavior_def("to_school2",::to_school2);
	soundscripts\_audio_vehicle_manager::avm_add_loops(["mus_dtrt_low_tension2","mus_dtrt_generic_combat"]);
	soundscripts\_audio_vehicle_manager::avm_end_behavior_def();
	soundscripts\_audio_vehicle_manager::avm_begin_behavior_def("to_school3",::to_school3);
	soundscripts\_audio_vehicle_manager::avm_add_loops(["mus_dtrt_low_tension3","mus_dtrt_generic_combat"]);
	soundscripts\_audio_vehicle_manager::avm_end_behavior_def();
	soundscripts\_audio_vehicle_manager::avm_end_behavior_data();
	soundscripts\_audio_vehicle_manager::avm_begin_state_data(0.25,50);
	soundscripts\_audio_vehicle_manager::avm_begin_state_group("main_group","refugee_camp","to_refugee_camp");
	soundscripts\_audio_vehicle_manager::avm_begin_state_def("refugee_camp");
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("school1","to_school1");
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("school2","to_school2");
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("school3","to_school3");
	soundscripts\_audio_vehicle_manager::avm_end_state_def();
	soundscripts\_audio_vehicle_manager::avm_begin_state_def("school1");
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("school2","to_school2");
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("school3","to_school3");
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("refugee_camp","to_refugee_camp");
	soundscripts\_audio_vehicle_manager::avm_end_state_def();
	soundscripts\_audio_vehicle_manager::avm_begin_state_def("school2");
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("school1","to_school1");
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("school3","to_school3");
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("refugee_camp","to_refugee_camp");
	soundscripts\_audio_vehicle_manager::avm_end_state_def();
	soundscripts\_audio_vehicle_manager::avm_begin_state_def("school3");
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("school1","to_school1");
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("school2","to_school2");
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("refugee_camp","to_refugee_camp");
	soundscripts\_audio_vehicle_manager::avm_end_state_def();
	soundscripts\_audio_vehicle_manager::avm_end_state_group();
	soundscripts\_audio_vehicle_manager::avm_end_state_data();
	soundscripts\_audio_vehicle_manager::avm_end_preset_def();
}

//Function Number: 2
to_refugee_camp(param_00,param_01)
{
	return soundscripts\_audio_music::ams_get_state() == "refugee_camp";
}

//Function Number: 3
to_school1(param_00,param_01)
{
	return soundscripts\_audio_music::ams_get_state() == "school1";
}

//Function Number: 4
to_school2(param_00,param_01)
{
	return soundscripts\_audio_music::ams_get_state() == "school2";
}

//Function Number: 5
to_school3(param_00,param_01)
{
	return soundscripts\_audio_music::ams_get_state() == "school3";
}

//Function Number: 6
virus1_preset_constructor()
{
	var_00 = 0.65;
	var_01 = 0.75;
	var_02 = 0;
	var_03 = 1;
	var_04 = 0.5;
	var_05 = 0.6;
	var_06 = 0.7;
	var_07 = 0.8;
	var_08 = 0;
	var_09 = 1;
	var_0A = 0.3;
	var_0B = 1;
	var_0C = 0;
	var_0D = 1;
	var_0E = 0.2;
	var_0F = 1;
	var_10 = 0;
	var_11 = 1;
	var_12 = 0.1;
	var_13 = 1;
	var_14 = 0;
	var_15 = 1;
	var_16 = 0;
	var_17 = 1;
	var_18 = 0.15;
	var_19 = 1;
	soundscripts\_audio_vehicle_manager::avm_begin_preset_def("virus1",::vrs1_instance_init);
	soundscripts\_audio_vehicle_manager::avm_begin_loop_data(5,0.1,0.05);
	soundscripts\_audio_vehicle_manager::avm_begin_loop_def("virus1_mix1");
	soundscripts\_audio_vehicle_manager::avm_end_loop_def();
	soundscripts\_audio_vehicle_manager::avm_begin_loop_def("virus1_mix2");
	soundscripts\_audio_vehicle_manager::avm_end_loop_def();
	soundscripts\_audio_vehicle_manager::avm_begin_loop_def("virus1_tilbell");
	soundscripts\_audio_vehicle_manager::avm_begin_param_map("ams_intensity");
	soundscripts\_audio_vehicle_manager::avm_add_param_map_env("volume","virus1_tilbell_i2vol");
	soundscripts\_audio_vehicle_manager::avm_end_param_map();
	soundscripts\_audio_vehicle_manager::avm_end_loop_def();
	soundscripts\_audio_vehicle_manager::avm_begin_loop_def("virus1_bigshufl");
	soundscripts\_audio_vehicle_manager::avm_begin_param_map("ams_intensity");
	soundscripts\_audio_vehicle_manager::avm_add_param_map_env("volume","virus1_bigshufl_i2vol");
	soundscripts\_audio_vehicle_manager::avm_end_param_map();
	soundscripts\_audio_vehicle_manager::avm_end_loop_def();
	soundscripts\_audio_vehicle_manager::avm_begin_loop_def("virus1_tribelgruv");
	soundscripts\_audio_vehicle_manager::avm_begin_param_map("ams_intensity");
	soundscripts\_audio_vehicle_manager::avm_add_param_map_env("volume","virus1_tribelgruv_i2vol");
	soundscripts\_audio_vehicle_manager::avm_end_param_map();
	soundscripts\_audio_vehicle_manager::avm_end_loop_def();
	soundscripts\_audio_vehicle_manager::avm_begin_loop_def("virus1_bsgprc1");
	soundscripts\_audio_vehicle_manager::avm_begin_param_map("ams_intensity");
	soundscripts\_audio_vehicle_manager::avm_add_param_map_env("volume","virus1_bsgprc1_i2vol");
	soundscripts\_audio_vehicle_manager::avm_end_param_map();
	soundscripts\_audio_vehicle_manager::avm_end_loop_def();
	soundscripts\_audio_vehicle_manager::avm_begin_loop_def("virus1_bsgprc2");
	soundscripts\_audio_vehicle_manager::avm_begin_param_map("ams_intensity");
	soundscripts\_audio_vehicle_manager::avm_add_param_map_env("volume","virus1_bsgprc2_i2vol");
	soundscripts\_audio_vehicle_manager::avm_end_param_map();
	soundscripts\_audio_vehicle_manager::avm_end_loop_def();
	soundscripts\_audio_vehicle_manager::avm_begin_loop_def("virus1_badbrain");
	soundscripts\_audio_vehicle_manager::avm_begin_param_map("ams_intensity");
	soundscripts\_audio_vehicle_manager::avm_add_param_map_env("volume","virus1_badbrain_i2vol");
	soundscripts\_audio_vehicle_manager::avm_end_param_map();
	soundscripts\_audio_vehicle_manager::avm_end_loop_def();
	soundscripts\_audio_vehicle_manager::avm_end_loop_data();
	soundscripts\_audio_vehicle_manager::avm_begin_oneshot_data();
	soundscripts\_audio_vehicle_manager::avm_end_oneshot_data();
	soundscripts\_audio_vehicle_manager::avm_begin_behavior_data();
	soundscripts\_audio_vehicle_manager::avm_begin_behavior_def("to_mix1",::vrs1_condition_to_mix1);
	soundscripts\_audio_vehicle_manager::avm_add_loops(["virus1_mix1"]);
	soundscripts\_audio_vehicle_manager::avm_add_init_state_callback(::vrs1_enter_mix1);
	soundscripts\_audio_vehicle_manager::avm_end_behavior_def();
	soundscripts\_audio_vehicle_manager::avm_begin_behavior_def("to_mix2",::vrs1_condition_to_mix2);
	soundscripts\_audio_vehicle_manager::avm_add_loops(["virus1_mix2"]);
	soundscripts\_audio_vehicle_manager::avm_add_init_state_callback(::vrs1_enter_mix2);
	soundscripts\_audio_vehicle_manager::avm_end_behavior_def();
	soundscripts\_audio_vehicle_manager::avm_begin_behavior_def("to_adaptive",::vrs1_condition_to_adaptive);
	soundscripts\_audio_vehicle_manager::avm_add_loops(["virus1_tilbell","virus1_bigshufl","virus1_badbrain","virus1_tribelgruv","virus1_bsgprc1","virus1_bsgprc2"]);
	soundscripts\_audio_vehicle_manager::avm_add_init_state_callback(::vrs1_enter_adaptive);
	soundscripts\_audio_vehicle_manager::avm_end_behavior_def();
	soundscripts\_audio_vehicle_manager::avm_end_behavior_data();
	soundscripts\_audio_vehicle_manager::avm_begin_state_data(0.25,50);
	soundscripts\_audio_vehicle_manager::avm_begin_state_group("main_group","mix1","to_mix1");
	soundscripts\_audio_vehicle_manager::avm_begin_state_def("mix1");
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("mix2","to_mix2");
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("adaptive","to_adaptive");
	soundscripts\_audio_vehicle_manager::avm_end_state_def();
	soundscripts\_audio_vehicle_manager::avm_begin_state_def("mix2");
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("mix1","to_mix1");
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("adaptive","to_adaptive");
	soundscripts\_audio_vehicle_manager::avm_end_state_def();
	soundscripts\_audio_vehicle_manager::avm_begin_state_def("adaptive");
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("mix1","to_mix1");
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("mix2","to_mix2");
	soundscripts\_audio_vehicle_manager::avm_end_state_def();
	soundscripts\_audio_vehicle_manager::avm_end_state_group();
	soundscripts\_audio_vehicle_manager::avm_end_state_data();
	soundscripts\_audio_vehicle_manager::avm_add_envelope("virus1_bsgprc2_i2vol",[[var_00,var_02],[var_01,var_03]]);
	soundscripts\_audio_vehicle_manager::avm_add_envelope("virus1_bsgprc1_i2vol",[[var_04,var_08],[var_05,var_09],[var_06,var_09],[var_07,var_08]]);
	soundscripts\_audio_vehicle_manager::avm_add_envelope("virus1_bigshufl_i2vol",[[var_0A,var_0C],[var_0B,var_0D]]);
	soundscripts\_audio_vehicle_manager::avm_add_envelope("virus1_tribelgruv_i2vol",[[var_0E,var_10],[var_0F,var_11]]);
	soundscripts\_audio_vehicle_manager::avm_add_envelope("virus1_tilbell_i2vol",[[0,0],[var_12,var_14],[var_13,var_15]]);
	soundscripts\_audio_vehicle_manager::avm_add_envelope("virus1_badbrain_i2vol",[[var_16,var_18],[var_17,var_19]]);
	soundscripts\_audio_vehicle_manager::avm_end_preset_def();
}

//Function Number: 7
vrs1_instance_init(param_00)
{
}

//Function Number: 8
vrs1_condition_to_mix1(param_00,param_01)
{
	return soundscripts\_audio_music::ams_get_state() == "mix1";
}

//Function Number: 9
vrs1_condition_to_mix2(param_00,param_01)
{
	return soundscripts\_audio_music::ams_get_state() == "mix2";
}

//Function Number: 10
vrs1_condition_to_adaptive(param_00,param_01)
{
	return soundscripts\_audio_music::ams_get_state() == "adaptive";
}

//Function Number: 11
vrs1_enter_mix1(param_00)
{
	soundscripts\_audio_vehicle_manager::avm_set_instance_master_volume(1,3);
}

//Function Number: 12
vrs1_enter_mix2(param_00)
{
	soundscripts\_audio_vehicle_manager::avm_set_instance_master_volume(1,3);
}

//Function Number: 13
vrs1_enter_adaptive(param_00)
{
	soundscripts\_audio_vehicle_manager::avm_set_instance_master_volume(1,3);
}

//Function Number: 14
bsgods_preset_constructor()
{
	soundscripts\_audio_vehicle_manager::avm_begin_preset_def("bsgods_preset",::bsgods_preset_instance_init_callback);
	soundscripts\_audio_vehicle_manager::avm_begin_loop_data(3,0.08,0.08);
	soundscripts\_audio_vehicle_manager::avm_begin_loop_def("mus_sfa_street_breakdown",3.1);
	soundscripts\_audio_vehicle_manager::avm_begin_param_map("ams_proxy_vehicle_speed");
	soundscripts\_audio_vehicle_manager::avm_add_param_map_env("volume","intro_loop_speed_to_vol");
	soundscripts\_audio_vehicle_manager::avm_end_param_map();
	soundscripts\_audio_vehicle_manager::avm_end_loop_def();
	soundscripts\_audio_vehicle_manager::avm_begin_loop_def("bsgods_prc_lyr1");
	soundscripts\_audio_vehicle_manager::avm_begin_param_map("ams_proxy_vehicle_speed");
	soundscripts\_audio_vehicle_manager::avm_add_param_map_env("volume","bsgods_prc_lyr1_speed_to_vol");
	soundscripts\_audio_vehicle_manager::avm_end_param_map();
	soundscripts\_audio_vehicle_manager::avm_end_loop_def();
	soundscripts\_audio_vehicle_manager::avm_begin_loop_def("bsgods_prc_lyr2");
	soundscripts\_audio_vehicle_manager::avm_begin_param_map("ams_proxy_vehicle_speed");
	soundscripts\_audio_vehicle_manager::avm_add_param_map_env("volume","bsgods_prc_lyr2_speed_to_vol");
	soundscripts\_audio_vehicle_manager::avm_end_param_map();
	soundscripts\_audio_vehicle_manager::avm_end_loop_def();
	soundscripts\_audio_vehicle_manager::avm_begin_loop_def("bsgods_prc_lyr3");
	soundscripts\_audio_vehicle_manager::avm_begin_param_map("ams_proxy_vehicle_speed");
	soundscripts\_audio_vehicle_manager::avm_add_param_map_env("volume","bsgods_prc_lyr3_speed_to_vol");
	soundscripts\_audio_vehicle_manager::avm_end_param_map();
	soundscripts\_audio_vehicle_manager::avm_end_loop_def();
	soundscripts\_audio_vehicle_manager::avm_begin_loop_def("bsgods_lps_lyr1");
	soundscripts\_audio_vehicle_manager::avm_begin_param_map("ams_proxy_vehicle_speed");
	soundscripts\_audio_vehicle_manager::avm_add_param_map_env("volume","bsgods_lps_lyr1_speed_to_vol");
	soundscripts\_audio_vehicle_manager::avm_end_param_map();
	soundscripts\_audio_vehicle_manager::avm_end_loop_def();
	soundscripts\_audio_vehicle_manager::avm_begin_loop_def("bsgods_lps_lyr2");
	soundscripts\_audio_vehicle_manager::avm_begin_param_map("ams_proxy_vehicle_speed");
	soundscripts\_audio_vehicle_manager::avm_add_param_map_env("volume","bsgods_lps_lyr2_speed_to_vol");
	soundscripts\_audio_vehicle_manager::avm_end_param_map();
	soundscripts\_audio_vehicle_manager::avm_end_loop_def();
	soundscripts\_audio_vehicle_manager::avm_begin_loop_def("bsgods_lps_lyr3");
	soundscripts\_audio_vehicle_manager::avm_begin_param_map("ams_proxy_vehicle_speed");
	soundscripts\_audio_vehicle_manager::avm_add_param_map_env("volume","bsgods_lps_lyr3_speed_to_vol");
	soundscripts\_audio_vehicle_manager::avm_end_param_map();
	soundscripts\_audio_vehicle_manager::avm_end_loop_def();
	soundscripts\_audio_vehicle_manager::avm_begin_loop_def("bsgods_lps_lyr4");
	soundscripts\_audio_vehicle_manager::avm_begin_param_map("ams_proxy_vehicle_speed");
	soundscripts\_audio_vehicle_manager::avm_add_param_map_env("volume","bsgods_lps_lyr4_speed_to_vol");
	soundscripts\_audio_vehicle_manager::avm_end_param_map();
	soundscripts\_audio_vehicle_manager::avm_end_loop_def();
	soundscripts\_audio_vehicle_manager::avm_begin_loop_def("bsgods_lps_lyr5");
	soundscripts\_audio_vehicle_manager::avm_begin_param_map("ams_proxy_vehicle_speed");
	soundscripts\_audio_vehicle_manager::avm_add_param_map_env("volume","bsgods_lps_lyr5_speed_to_vol");
	soundscripts\_audio_vehicle_manager::avm_end_param_map();
	soundscripts\_audio_vehicle_manager::avm_end_loop_def();
	soundscripts\_audio_vehicle_manager::avm_begin_loop_def("bsgods_atm_lyr2");
	soundscripts\_audio_vehicle_manager::avm_begin_param_map("ams_proxy_vehicle_speed");
	soundscripts\_audio_vehicle_manager::avm_add_param_map_env("volume","bsgods_atm_lyr1_speed_to_vol");
	soundscripts\_audio_vehicle_manager::avm_end_param_map();
	soundscripts\_audio_vehicle_manager::avm_end_loop_def();
	soundscripts\_audio_vehicle_manager::avm_begin_loop_def("bsgods_ris_lyr1");
	soundscripts\_audio_vehicle_manager::avm_begin_param_map("ams_proxy_vehicle_speed");
	soundscripts\_audio_vehicle_manager::avm_add_param_map_env("volume","bsgods_ris_lyr1_speed_to_vol");
	soundscripts\_audio_vehicle_manager::avm_end_param_map();
	soundscripts\_audio_vehicle_manager::avm_end_loop_def();
	soundscripts\_audio_vehicle_manager::avm_end_loop_data();
	soundscripts\_audio_vehicle_manager::avm_begin_oneshot_data();
	soundscripts\_audio_vehicle_manager::avm_begin_oneshot_def("bsgods_prc_hit1","bsgods_prc_hit_duck_envelope",0.25,0);
	soundscripts\_audio_vehicle_manager::avm_begin_param_map("ams_proxy_vehicle_speed");
	soundscripts\_audio_vehicle_manager::avm_add_param_map_env("volume","bsgods_prc_hit_speed_to_vol");
	soundscripts\_audio_vehicle_manager::avm_end_param_map();
	soundscripts\_audio_vehicle_manager::avm_end_oneshot_def();
	soundscripts\_audio_vehicle_manager::avm_begin_oneshot_def("bsgods_prc_hit2","bsgods_prc_hit_duck_envelope",0.25,0);
	soundscripts\_audio_vehicle_manager::avm_begin_param_map("ams_proxy_vehicle_speed");
	soundscripts\_audio_vehicle_manager::avm_add_param_map_env("volume","bsgods_prc_hit_speed_to_vol");
	soundscripts\_audio_vehicle_manager::avm_end_param_map();
	soundscripts\_audio_vehicle_manager::avm_end_oneshot_def();
	soundscripts\_audio_vehicle_manager::avm_end_oneshot_data();
	soundscripts\_audio_vehicle_manager::avm_begin_behavior_data();
	soundscripts\_audio_vehicle_manager::avm_begin_behavior_def("to_state_intro",::bsgods_condition_to_state_intro,["ams_proxy_vehicle_speed"]);
	soundscripts\_audio_vehicle_manager::avm_add_loops(["mus_sfa_street_breakdown"]);
	soundscripts\_audio_vehicle_manager::avm_add_oneshots("bsgods_prc_hit1");
	soundscripts\_audio_vehicle_manager::avm_end_behavior_def();
	soundscripts\_audio_vehicle_manager::avm_begin_behavior_def("to_state_driving",::bsgods_condition_to_state_driving);
	soundscripts\_audio_vehicle_manager::avm_add_loops(["bsgods_prc_lyr1","bsgods_prc_lyr2","bsgods_prc_lyr3","bsgods_lps_lyr1","bsgods_lps_lyr2","bsgods_lps_lyr3","bsgods_lps_lyr4","bsgods_lps_lyr5","bsgods_atm_lyr2","bsgods_ris_lyr1"]);
	soundscripts\_audio_vehicle_manager::avm_add_oneshots("bsgods_prc_hit1");
	soundscripts\_audio_vehicle_manager::avm_add_init_state_callback(::bsgods_enter_state_driving);
	soundscripts\_audio_vehicle_manager::avm_add_in_state_callback(::bsgods_in_state_driving);
	soundscripts\_audio_vehicle_manager::avm_begin_param_map("ams_proxy_vehicle_speed",0.025,0.025);
	soundscripts\_audio_vehicle_manager::avm_end_param_map();
	soundscripts\_audio_vehicle_manager::avm_end_behavior_def();
	soundscripts\_audio_vehicle_manager::avm_end_behavior_data();
	soundscripts\_audio_vehicle_manager::avm_begin_state_data(0.25,50);
	soundscripts\_audio_vehicle_manager::avm_begin_state_group("main_group","state_driving","to_state_driving");
	soundscripts\_audio_vehicle_manager::avm_begin_state_def("state_intro");
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("state_driving","to_state_driving");
	soundscripts\_audio_vehicle_manager::avm_end_state_def();
	soundscripts\_audio_vehicle_manager::avm_begin_state_def("state_driving");
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("state_intro","to_state_intro");
	soundscripts\_audio_vehicle_manager::avm_end_state_def();
	soundscripts\_audio_vehicle_manager::avm_end_state_group();
	soundscripts\_audio_vehicle_manager::avm_end_state_data();
	soundscripts\_audio_vehicle_manager::avm_add_envelope("intro_loop_speed_to_vol",[[0,1],[60,1]]);
	var_00 = [0,0.166,0.333,0.5,0.666,0.833,1];
	soundscripts\_audio_vehicle_manager::avm_add_envelope("bsgods_prc_lyr1_speed_to_vol",[[0 + 60 * var_00[0],1],[0 + 60 * var_00[2],1],[0 + 60 * var_00[3],0]]);
	soundscripts\_audio_vehicle_manager::avm_add_envelope("bsgods_prc_lyr2_speed_to_vol",[[0 + 60 * var_00[1],0],[0 + 60 * var_00[2],1],[0 + 60 * var_00[4],1],[0 + 60 * var_00[5],0]]);
	soundscripts\_audio_vehicle_manager::avm_add_envelope("bsgods_prc_lyr3_speed_to_vol",[[0 + 60 * var_00[3],0],[0 + 60 * var_00[4],1],[0 + 60 * var_00[6],1]]);
	soundscripts\_audio_vehicle_manager::avm_add_envelope("bsgods_prc_hit_speed_to_vol",[[0,0.5],[60,0.5]]);
	var_00 = [0,0.166,0.333,0.5,0.666,0.833,1];
	soundscripts\_audio_vehicle_manager::avm_add_envelope("bsgods_lps_lyr1_speed_to_vol",[[0 + 60 * var_00[0],1],[0 + 60 * var_00[1],1],[0 + 60 * var_00[2],1],[0 + 60 * var_00[2] + 0.1,0]]);
	soundscripts\_audio_vehicle_manager::avm_add_envelope("bsgods_lps_lyr2_speed_to_vol",[[0 + 60 * var_00[2] - 0.1,0],[0 + 60 * var_00[2],1],[0 + 60 * var_00[3],1],[0 + 60 * var_00[3] + 0.1,0]]);
	soundscripts\_audio_vehicle_manager::avm_add_envelope("bsgods_lps_lyr3_speed_to_vol",[[0 + 60 * var_00[3] - 0.1,0],[0 + 60 * var_00[3],1],[0 + 60 * var_00[4],1],[0 + 60 * var_00[4] + 0.1,0]]);
	soundscripts\_audio_vehicle_manager::avm_add_envelope("bsgods_lps_lyr4_speed_to_vol",[[0 + 60 * var_00[4] - 0.1,0],[0 + 60 * var_00[4],1],[0 + 60 * var_00[5],1],[0 + 60 * var_00[5] + 0.1,0]]);
	soundscripts\_audio_vehicle_manager::avm_add_envelope("bsgods_lps_lyr5_speed_to_vol",[[0 + 60 * var_00[5] - 0.1,0],[0 + 60 * var_00[5],1],[0 + 60 * var_00[6],1]]);
	var_00 = [0,0.166,0.333,0.5,0.666,0.833,1];
	soundscripts\_audio_vehicle_manager::avm_add_envelope("bsgods_atm_lyr1_speed_to_vol",[[0 + 60 * var_00[3],0],[0 + 60 * var_00[4],0.4],[0 + 60 * var_00[5],0.7],[0 + 60 * var_00[6],0.7]]);
	var_00 = [0.8,0.9,1];
	soundscripts\_audio_vehicle_manager::avm_add_envelope("bsgods_ris_lyr1_speed_to_vol",[[0 + 60 * var_00[0],0],[0 + 60 * var_00[1],1],[0 + 60 * var_00[2],1]]);
	soundscripts\_audio_vehicle_manager::avm_add_envelope("bsgods_prc_hit_duck_envelope",[[0,1],[0.05,0.5],[0.3,0.75],[1.12,1]]);
	soundscripts\_audio_vehicle_manager::avm_end_preset_def();
}

//Function Number: 15
bsgods_preset_instance_init_callback(param_00)
{
}

//Function Number: 16
bsgods_condition_to_state_intro(param_00,param_01)
{
	return soundscripts\_audio_music::ams_get_state() == "intro";
}

//Function Number: 17
bsgods_condition_to_state_driving(param_00,param_01)
{
	return soundscripts\_audio_music::ams_get_state() == "driving";
}

//Function Number: 18
bsgods_enter_state_driving(param_00)
{
	if(!isdefined(param_00.st_driving))
	{
		param_00.st_driving = spawnstruct();
	}

	param_00.st_driving.ris_is_muted = 1;
	param_00.st_driving.ris_mute_time = 0;
	param_00.st_driving.ris_off_time = 0;
	param_00.st_driving.ris_max_off_time = 36;
	param_00.st_driving.ris_max_on_time = 18;
	param_00.st_driving.atm_is_muted = 1;
	param_00.st_driving.atm_mute_time = 0;
	param_00.st_driving.atm_off_time = 0;
	param_00.st_driving.atm_max_off_time = 18;
	param_00.st_driving.atm_max_on_time = 9;
	soundscripts\_audio_vehicle_manager::avm_set_loop_mute_state("bsgods_ris_lyr1",param_00.st_driving.ris_is_muted,0.05);
	param_00.st_driving.ris_mute_time = soundscripts\_snd::snd_get_secs();
	soundscripts\_audio_vehicle_manager::avm_set_loop_mute_state("bsgods_atm_lyr2",param_00.st_driving.atm_is_muted,0.05);
	param_00.st_driving.atm_mute_time = soundscripts\_snd::snd_get_secs();
}

//Function Number: 19
bsgods_in_state_driving(param_00,param_01)
{
	var_02 = param_00["ams_proxy_vehicle_speed"];
	if(var_02 > 45)
	{
		var_03 = 4;
		var_04 = soundscripts\_snd::snd_get_secs() - param_01.st_driving.ris_mute_time;
		if(param_01.st_driving.ris_is_muted && var_04 > param_01.st_driving.ris_max_off_time)
		{
			soundscripts\_audio_vehicle_manager::avm_set_loop_mute_state("bsgods_ris_lyr1",0,var_03);
			param_01.st_driving.ris_is_muted = 0;
			param_01.st_driving.ris_mute_time = soundscripts\_snd::snd_get_secs();
		}
		else if(!param_01.st_driving.ris_is_muted && var_04 > param_01.st_driving.ris_max_on_time)
		{
			soundscripts\_audio_vehicle_manager::avm_set_loop_mute_state("bsgods_ris_lyr1",1,var_03);
			param_01.st_driving.ris_is_muted = 1;
			param_01.st_driving.ris_mute_time = soundscripts\_snd::snd_get_secs();
		}
	}
	else if(!param_01.st_driving.ris_is_muted)
	{
		param_01.st_driving.ris_is_muted = 1;
		soundscripts\_audio_vehicle_manager::avm_set_loop_mute_state("bsgods_ris_lyr1",param_01.st_driving.ris_is_muted,1);
		param_01.st_driving.ris_mute_time = soundscripts\_snd::snd_get_secs();
	}

	if(var_02 > 30)
	{
		var_03 = 2;
		var_04 = soundscripts\_snd::snd_get_secs() - param_01.st_driving.atm_mute_time;
		if(param_01.st_driving.atm_is_muted && var_04 > param_01.st_driving.atm_max_off_time)
		{
			soundscripts\_audio_vehicle_manager::avm_set_loop_mute_state("bsgods_atm_lyr2",0,var_03);
			param_01.st_driving.atm_is_muted = 0;
			param_01.st_driving.atm_mute_time = soundscripts\_snd::snd_get_secs();
			return;
		}

		if(!param_01.st_driving.atm_is_muted && var_04 > param_01.st_driving.atm_max_on_time)
		{
			soundscripts\_audio_vehicle_manager::avm_set_loop_mute_state("bsgods_atm_lyr2",1,var_03);
			param_01.st_driving.atm_is_muted = 1;
			param_01.st_driving.atm_mute_time = soundscripts\_snd::snd_get_secs();
			return;
		}

		return;
	}

	if(!param_01.st_driving.atm_is_muted)
	{
		param_01.st_driving.atm_is_muted = 1;
		soundscripts\_audio_vehicle_manager::avm_set_loop_mute_state("bsgods_atm_lyr2",param_01.st_driving.atm_is_muted,1);
		param_01.st_driving.atm_mute_time = soundscripts\_snd::snd_get_secs();
	}
}

//Function Number: 20
audio_presets_music_moods(param_00,param_01)
{
	soundscripts\_audio::aud_print_warning("CALLING MUSIC_MOODS PRESET USING OLD METHOD!");
}

//Function Number: 21
audio_presets_music_cue_groups(param_00,param_01)
{
	soundscripts\_audio::aud_print_warning("CALLING MUSIC_CUE_GROUPS PRESET USING OLD METHOD!");
}

//Function Number: 22
audio_presets_music_cues(param_00,param_01)
{
	soundscripts\_audio::aud_print_warning("CALLING MUSIC_CUES PRESET USING OLD METHOD!");
}