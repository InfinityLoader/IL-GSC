/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: vehicle_scripts/_pdrone_aud.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 37
 * Decompile Time: 450 ms
 * Timestamp: 10/27/2023 2:06:27 AM
*******************************************************************/

//Function Number: 1
snd_pdrone_swarm_constructor()
{
	var_00 = 1;
	var_01 = 0.8;
	var_02 = 0;
	var_03 = 10;
	var_04 = 15;
	var_05 = var_04 - var_02;
	var_06 = 0.7;
	var_07 = 1;
	var_08 = 0.8;
	var_09 = 1;
	var_0A = 1.1;
	var_0B = 0;
	var_0C = 0.5;
	var_0D = 0.85;
	var_0E = 1;
	var_0F = 0;
	var_10 = 0.5;
	var_11 = 1;
	var_12 = 0.8;
	var_13 = 1.1;
	var_14 = 0;
	var_15 = 1;
	var_16 = 0.5;
	var_17 = 1.5;
	soundscripts\_audio_vehicle_manager::avm_begin_preset_def("pdrone_swarm");
	soundscripts\_audio_vehicle_manager::avm_begin_loop_data(0.25);
	soundscripts\_audio_vehicle_manager::avm_begin_loop_def("pdrn_swarm_rotor_ww");
	soundscripts\_audio_vehicle_manager::avm_begin_param_map("speed");
	soundscripts\_audio_vehicle_manager::avm_add_param_map_env("volume","pdrn_rotor_vel2vol");
	soundscripts\_audio_vehicle_manager::avm_add_param_map_env("pitch","pdrn_rotor_vel2pch");
	soundscripts\_audio_vehicle_manager::avm_end_param_map();
	soundscripts\_audio_vehicle_manager::avm_begin_param_map("doppler_exaggerated");
	soundscripts\_audio_vehicle_manager::avm_add_param_map_env("pitch","pdrn_doppler2pch");
	soundscripts\_audio_vehicle_manager::avm_end_param_map();
	soundscripts\_audio_vehicle_manager::avm_end_loop_def();
	soundscripts\_audio_vehicle_manager::avm_begin_loop_def("pdrn_swarm_rotor_main_lp");
	soundscripts\_audio_vehicle_manager::avm_begin_param_map("speed",0.65,0.3);
	soundscripts\_audio_vehicle_manager::avm_add_param_map_env("volume","pdrn_rotor_vel2vol");
	soundscripts\_audio_vehicle_manager::avm_end_param_map();
	soundscripts\_audio_vehicle_manager::avm_begin_param_map("doppler_exaggerated",0.65,0.3);
	soundscripts\_audio_vehicle_manager::avm_add_param_map_env("pitch","pdrn_doppler2pch");
	soundscripts\_audio_vehicle_manager::avm_end_param_map();
	soundscripts\_audio_vehicle_manager::avm_end_loop_def();
	soundscripts\_audio_vehicle_manager::avm_end_loop_data();
	soundscripts\_audio_vehicle_manager::avm_begin_oneshot_data();
	soundscripts\_audio_vehicle_manager::avm_begin_oneshot_def("pdrone_flyby","pdrn_flyby_duck_envelope",0.25,1,["pdrn_by_comp"]);
	soundscripts\_audio_vehicle_manager::avm_begin_param_map("speed",1,1);
	soundscripts\_audio_vehicle_manager::avm_add_param_map_env("pitch","pdrn_flyby_vel2pch");
	soundscripts\_audio_vehicle_manager::avm_add_param_map_env("volume","pdrn_flyby_vel2vol");
	soundscripts\_audio_vehicle_manager::avm_end_param_map();
	soundscripts\_audio_vehicle_manager::avm_begin_param_map("doppler_exaggerated",1,1);
	soundscripts\_audio_vehicle_manager::avm_add_param_map_env("pitch","pdrn_doppler2pch");
	soundscripts\_audio_vehicle_manager::avm_end_param_map();
	soundscripts\_audio_vehicle_manager::avm_end_oneshot_def();
	soundscripts\_audio_vehicle_manager::avm_end_oneshot_data();
	soundscripts\_audio_vehicle_manager::avm_begin_behavior_data();
	soundscripts\_audio_vehicle_manager::avm_begin_behavior_def("to_state_hover",::pdrone_swarm_condition_callback_to_state_hover,["speed","distance2d"]);
	soundscripts\_audio_vehicle_manager::avm_add_loops("ALL");
	soundscripts\_audio_vehicle_manager::avm_end_behavior_def();
	soundscripts\_audio_vehicle_manager::avm_begin_behavior_def("to_state_flying",::pdrone_swarm_condition_callback_to_state_flying,["speed","distance2d"]);
	soundscripts\_audio_vehicle_manager::avm_add_loops("ALL");
	soundscripts\_audio_vehicle_manager::avm_end_behavior_def();
	soundscripts\_audio_vehicle_manager::avm_begin_behavior_def("to_state_distant",::pdrone_swarm_condition_callback_to_state_distant,["distance2d"]);
	soundscripts\_audio_vehicle_manager::avm_add_loops("pdrn_swarm_rotor_main_lp");
	soundscripts\_audio_vehicle_manager::avm_end_behavior_def();
	soundscripts\_audio_vehicle_manager::avm_begin_behavior_def("to_state_flyby",::pdrone_condition_callback_to_state_flyby,["distance2d"]);
	soundscripts\_audio_vehicle_manager::avm_add_loops("ALL");
	soundscripts\_audio_vehicle_manager::avm_add_oneshots("pdrone_flyby");
	soundscripts\_audio_vehicle_manager::avm_end_behavior_def();
	soundscripts\_audio_vehicle_manager::avm_begin_behavior_def("to_state_deathspin",::pdrone_condition_callback_to_state_deathspin);
	soundscripts\_audio_vehicle_manager::avm_add_loops("NONE");
	soundscripts\_audio_vehicle_manager::avm_end_behavior_def();
	soundscripts\_audio_vehicle_manager::avm_begin_behavior_def("to_state_destruct",::pdrone_condition_callback_to_state_destruct);
	soundscripts\_audio_vehicle_manager::avm_add_loops("NONE");
	soundscripts\_audio_vehicle_manager::avm_end_behavior_def();
	soundscripts\_audio_vehicle_manager::avm_begin_behavior_def("to_state_off",::pdrone_condition_callback_to_state_off);
	soundscripts\_audio_vehicle_manager::avm_add_loops("NONE");
	soundscripts\_audio_vehicle_manager::avm_end_behavior_def();
	soundscripts\_audio_vehicle_manager::avm_end_behavior_data();
	soundscripts\_audio_vehicle_manager::avm_begin_state_data(0.25,50);
	soundscripts\_audio_vehicle_manager::avm_begin_state_group("main_oneshots","state_hover","to_state_hover",50,1);
	soundscripts\_audio_vehicle_manager::avm_begin_state_def("state_off");
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("state_hover","to_state_hover");
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("state_distant","to_state_distant");
	soundscripts\_audio_vehicle_manager::avm_end_state_def();
	soundscripts\_audio_vehicle_manager::avm_begin_state_def("state_hover");
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("state_flyby","to_state_flyby");
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("state_flying","to_state_flying");
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("state_distant","to_state_distant");
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("state_deathspin","to_state_deathspin");
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("state_destruct","to_state_destruct");
	soundscripts\_audio_vehicle_manager::avm_end_state_def();
	soundscripts\_audio_vehicle_manager::avm_begin_state_def("state_flying");
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("state_flyby","to_state_flyby");
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("state_distant","to_state_distant");
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("state_deathspin","to_state_deathspin");
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("state_destruct","to_state_destruct");
	soundscripts\_audio_vehicle_manager::avm_end_state_def();
	soundscripts\_audio_vehicle_manager::avm_begin_state_def("state_distant");
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("state_hover","to_state_hover");
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("state_flying","to_state_flying");
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("state_flyby","to_state_flyby");
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("state_deathspin","to_state_deathspin");
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("state_destruct","to_state_destruct");
	soundscripts\_audio_vehicle_manager::avm_end_state_def();
	soundscripts\_audio_vehicle_manager::avm_begin_state_def("state_flyby",3);
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("state_hover","to_state_hover");
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("state_flying","to_state_flying");
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("state_flyby","to_state_flyby");
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("state_distant","to_state_distant");
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("state_deathspin","to_state_deathspin");
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("state_destruct","to_state_destruct");
	soundscripts\_audio_vehicle_manager::avm_end_state_def();
	soundscripts\_audio_vehicle_manager::avm_begin_state_def("state_deathspin");
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("state_destruct","to_state_destruct");
	soundscripts\_audio_vehicle_manager::avm_end_state_def();
	soundscripts\_audio_vehicle_manager::avm_begin_state_def("state_destruct");
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("state_off","to_state_off");
	soundscripts\_audio_vehicle_manager::avm_end_state_def();
	soundscripts\_audio_vehicle_manager::avm_end_state_group();
	soundscripts\_audio_vehicle_manager::avm_end_state_data();
	soundscripts\_audio_vehicle_manager::avm_add_envelope("pdrn_loopset_vol_env",[[var_04 * 0,0.65 * var_00],[var_04 * 0.0204,0.66155 * var_00],[var_04 * 0.0816,0.670545 * var_00],[var_04 * 0.1836,0.688885 * var_00],[var_04 * 0.3265,0.7274899 * var_00],[var_04 * 0.5102,0.80554 * var_00],[var_04 * 0.7346,0.926535 * var_00],[var_04 * 1,1 * var_00]]);
	soundscripts\_audio_vehicle_manager::avm_add_envelope("pdrn_rotor_vel2vol",[[var_02,var_07],[var_04,var_07]]);
	soundscripts\_audio_vehicle_manager::avm_add_envelope("pdrn_rotor_vel2pch",[[var_02,var_08],[var_03,var_09],[var_04,var_0A]]);
	soundscripts\_audio_vehicle_manager::avm_add_envelope("pdrn_flyby_vel2vol",[[var_02,var_14],[var_04,var_15]]);
	soundscripts\_audio_vehicle_manager::avm_add_envelope("pdrn_flyby_vel2pch",[[var_02,var_16],[var_04,var_17]]);
	soundscripts\_audio_vehicle_manager::avm_add_envelope("pdrn_flyby_duck_envelope",[[0,1],[1,1]]);
	soundscripts\_audio_vehicle_manager::avm_add_envelope("pdrn_doppler2pch",[[0,0],[2,2]]);
	soundscripts\_audio_vehicle_manager::avm_end_preset_def();
}

//Function Number: 2
pdrone_swarm_condition_callback_to_state_hover(param_00,param_01)
{
	var_02 = 0;
	var_03 = param_00["speed"];
	var_04 = param_00["distance2d"];
	var_05 = soundscripts\_audio_vehicle_manager::dist2yards(var_04);
	if(var_03 <= 5.1 && var_05 < 50)
	{
		var_02 = 1;
	}

	return var_02;
}

//Function Number: 3
pdrone_swarm_condition_callback_to_state_flying(param_00,param_01)
{
	var_02 = 0;
	var_03 = param_00["speed"];
	var_04 = param_00["distance2d"];
	var_05 = soundscripts\_audio_vehicle_manager::dist2yards(var_04);
	if(var_03 > 5.1 && var_05 < 50)
	{
		var_02 = 1;
	}

	return var_02;
}

//Function Number: 4
pdrone_swarm_condition_callback_to_state_distant(param_00,param_01)
{
	var_02 = 0;
	var_03 = param_00["distance2d"];
	var_04 = soundscripts\_audio_vehicle_manager::dist2yards(var_03);
	if(var_04 >= 50)
	{
		var_02 = 1;
	}

	return var_02;
}

//Function Number: 5
snd_pdrone_atlas_constructor()
{
	var_00 = 0;
	var_01 = 10;
	var_02 = 30;
	var_03 = var_02 - var_00;
	var_04 = 0.4;
	var_05 = 0.4;
	var_06 = var_05 - var_04;
	var_07 = 1.5;
	var_08 = 1.9;
	var_09 = var_08 - var_07;
	var_0A = 270;
	var_0B = 1080;
	var_0C = 0;
	var_0D = 1;
	var_0E = var_0D - var_0C;
	var_0F = 1;
	var_10 = 2;
	var_11 = var_10 - var_0F;
	var_12 = 0;
	var_13 = 0.45;
	var_14 = var_13 - var_12;
	var_15 = 0.9;
	var_16 = 1.4;
	var_17 = var_16 - var_15;
	var_18 = 0;
	var_19 = 0.5;
	var_1A = var_02 * 0;
	var_1B = var_02 * 0.65;
	var_1C = 288;
	var_1D = 720;
	var_1E = 0;
	var_1F = 1;
	var_20 = var_02 * 0.6;
	var_21 = var_02 * 1;
	var_22 = var_21 - var_20;
	var_23 = 0.85;
	var_24 = 1.25;
	var_25 = 30;
	var_26 = 0;
	var_27 = 0.8;
	var_28 = 0.75;
	var_29 = 1.25;
	var_2A = 100;
	var_2B = 200;
	var_2C = 500;
	var_2D = 6;
	var_2E = 5;
	var_2F = undefined;
	var_30 = 0.6;
	var_31 = 0.5;
	soundscripts\_audio_vehicle_manager::avm_begin_preset_def("pdrone_atlas",::pdrone_atlas_init);
	soundscripts\_audio_vehicle_manager::avm_add_envelope("atlasdrn_realhelo_spd2vol",[[var_00,var_04],[var_02,var_05]]);
	soundscripts\_audio_vehicle_manager::avm_add_envelope("atlasdrn_realhelo_spd2pch",[[var_00,var_07],[var_02,var_08]]);
	soundscripts\_audio_vehicle_manager::avm_add_envelope("atlasdrn_snthhelo_spd2pch",[[var_02 * 0,var_0F + 0 * var_11],[var_02 * 0.0204,var_0F + 0.033 * var_11],[var_02 * 0.0816,var_0F + 0.0587 * var_11],[var_02 * 0.1836,var_0F + 0.1111 * var_11],[var_02 * 0.3265,var_0F + 0.2214 * var_11],[var_02 * 0.5102,var_0F + 0.4444 * var_11],[var_02 * 0.7346,var_0F + 0.7901 * var_11],[var_02 * 1,var_0F + 1 * var_11]]);
	soundscripts\_audio_vehicle_manager::avm_add_envelope("atlasdrn_snthhelo_dst2vol",[[var_0A,var_0D],[var_0B,var_0C]]);
	soundscripts\_audio_vehicle_manager::avm_add_envelope("atlasdrn_snthhelo_spd2vol",[[var_00,var_0C],[var_02,var_0D]]);
	soundscripts\_audio_vehicle_manager::avm_add_envelope("atlasdrn_hover_spd2pch",[[var_00,var_15],[var_02,var_16]]);
	soundscripts\_audio_vehicle_manager::avm_add_envelope("atlasdrn_hover_spd2vol",[[var_00,var_13],[var_02,var_12]]);
	soundscripts\_audio_vehicle_manager::avm_add_envelope("atlasdrn_travelslw_spd2vol",[[var_1A,var_19],[var_1B,var_18]]);
	soundscripts\_audio_vehicle_manager::avm_add_envelope("atlasdrn_travelfst_dst2vol",[[var_1C,var_1F],[var_1D,var_1E]]);
	soundscripts\_audio_vehicle_manager::avm_add_envelope("atlasdrn_travelfst_spd2vol",[[var_20 + var_22 * 0,var_1F * 0],[var_20 + var_22 * 0.0204,var_1F * 0.033],[var_20 + var_22 * 0.0816,var_1F * 0.0587],[var_20 + var_22 * 0.1836,var_1F * 0.1111],[var_20 + var_22 * 0.3265,var_1F * 0.2214],[var_20 + var_22 * 0.5102,var_1F * 0.4444],[var_20 + var_22 * 0.7346,var_1F * 0.7901],[var_20 + var_22 * 1,var_1F * 1]]);
	soundscripts\_audio_vehicle_manager::avm_add_envelope("atlasdrn_travelfst_spd2pch",[[var_00,var_23],[var_02,var_24]]);
	soundscripts\_audio_vehicle_manager::avm_add_envelope("atlasdrn_flyby_vel2vol",[[var_00,var_26],[var_03 * 0.25,var_27 * 0.5],[var_02,var_27]]);
	soundscripts\_audio_vehicle_manager::avm_add_envelope("atlasdrn_flyby_vel2pch",[[var_00,var_28],[var_02,var_29]]);
	soundscripts\_audio_vehicle_manager::avm_add_envelope("atlasdrn_doppler2pch",[[0,0],[2,2]]);
	soundscripts\_audio_vehicle_manager::avm_add_envelope("atlasdrn_flyby_duck_envelope",[[0,1],[0.4,0.7],[0.6,0.5],[0.8,0.7],[1,1]]);
	soundscripts\_audio_vehicle_manager::avm_begin_loop_data(1,var_30,var_31);
	soundscripts\_audio_vehicle_manager::avm_begin_loop_def("atlasdrn_real_helo_lp");
	soundscripts\_audio_vehicle_manager::avm_begin_param_map("SPEED");
	soundscripts\_audio_vehicle_manager::avm_add_param_map_env("volume","atlasdrn_realhelo_spd2vol");
	soundscripts\_audio_vehicle_manager::avm_add_param_map_env("pitch","atlasdrn_realhelo_spd2pch");
	soundscripts\_audio_vehicle_manager::avm_end_param_map();
	soundscripts\_audio_vehicle_manager::avm_begin_param_map("DOPPLER_EXAGGERATED");
	soundscripts\_audio_vehicle_manager::avm_add_param_map_env("pitch","atlasdrn_doppler2pch");
	soundscripts\_audio_vehicle_manager::avm_end_param_map();
	soundscripts\_audio_vehicle_manager::avm_end_loop_def();
	soundscripts\_audio_vehicle_manager::avm_begin_loop_def("atlasdrn_snth_helo_lp");
	soundscripts\_audio_vehicle_manager::avm_begin_param_map("DISTANCE");
	soundscripts\_audio_vehicle_manager::avm_add_param_map_env("volume","atlasdrn_snthhelo_dst2vol");
	soundscripts\_audio_vehicle_manager::avm_end_param_map();
	soundscripts\_audio_vehicle_manager::avm_begin_param_map("SPEED");
	soundscripts\_audio_vehicle_manager::avm_add_param_map_env("volume","atlasdrn_snthhelo_spd2vol");
	soundscripts\_audio_vehicle_manager::avm_add_param_map_env("pitch","atlasdrn_snthhelo_spd2pch");
	soundscripts\_audio_vehicle_manager::avm_end_param_map();
	soundscripts\_audio_vehicle_manager::avm_begin_param_map("DOPPLER");
	soundscripts\_audio_vehicle_manager::avm_add_param_map_env("pitch","atlasdrn_doppler2pch");
	soundscripts\_audio_vehicle_manager::avm_end_param_map();
	soundscripts\_audio_vehicle_manager::avm_end_loop_def();
	soundscripts\_audio_vehicle_manager::avm_begin_loop_def("atlasdrn_hover_lp");
	soundscripts\_audio_vehicle_manager::avm_begin_param_map("SPEED");
	soundscripts\_audio_vehicle_manager::avm_add_param_map_env("volume","atlasdrn_hover_spd2vol");
	soundscripts\_audio_vehicle_manager::avm_add_param_map_env("pitch","atlasdrn_hover_spd2pch");
	soundscripts\_audio_vehicle_manager::avm_end_param_map();
	soundscripts\_audio_vehicle_manager::avm_end_loop_def();
	soundscripts\_audio_vehicle_manager::avm_begin_loop_def("atlasdrn_travel_fst_lp");
	soundscripts\_audio_vehicle_manager::avm_begin_param_map("DISTANCE2D");
	soundscripts\_audio_vehicle_manager::avm_add_param_map_env("volume","atlasdrn_travelfst_dst2vol");
	soundscripts\_audio_vehicle_manager::avm_end_param_map();
	soundscripts\_audio_vehicle_manager::avm_begin_param_map("SPEED");
	soundscripts\_audio_vehicle_manager::avm_add_param_map_env("volume","atlasdrn_travelfst_spd2vol");
	soundscripts\_audio_vehicle_manager::avm_end_param_map();
	soundscripts\_audio_vehicle_manager::avm_begin_param_map("DOPPLER");
	soundscripts\_audio_vehicle_manager::avm_add_param_map_env("pitch","atlasdrn_doppler2pch");
	soundscripts\_audio_vehicle_manager::avm_end_param_map();
	soundscripts\_audio_vehicle_manager::avm_end_loop_def();
	soundscripts\_audio_vehicle_manager::avm_end_loop_data();
	soundscripts\_audio_vehicle_manager::avm_begin_oneshot_data();
	soundscripts\_audio_vehicle_manager::avm_begin_oneshot_def("atlasdrn_flyby1","atlasdrn_flyby_duck_envelope",0.25);
	soundscripts\_audio_vehicle_manager::avm_begin_param_map("SPEED",1,1);
	soundscripts\_audio_vehicle_manager::avm_add_param_map_env("pitch","atlasdrn_flyby_vel2pch");
	soundscripts\_audio_vehicle_manager::avm_add_param_map_env("volume","atlasdrn_flyby_vel2vol");
	soundscripts\_audio_vehicle_manager::avm_end_param_map();
	soundscripts\_audio_vehicle_manager::avm_end_oneshot_def();
	soundscripts\_audio_vehicle_manager::avm_end_oneshot_data();
	soundscripts\_audio_vehicle_manager::avm_begin_behavior_data();
	soundscripts\_audio_vehicle_manager::avm_begin_behavior_def("to_state_hover",::atlasdrn_condition_callback_to_state_hover,["speed","distance2d"]);
	soundscripts\_audio_vehicle_manager::avm_add_loops("ALL");
	soundscripts\_audio_vehicle_manager::avm_end_behavior_def();
	soundscripts\_audio_vehicle_manager::avm_begin_behavior_def("to_state_flying",::atlasdrn_condition_callback_to_state_flying,["speed","distance2d"]);
	soundscripts\_audio_vehicle_manager::avm_add_loops("ALL");
	soundscripts\_audio_vehicle_manager::avm_end_behavior_def();
	soundscripts\_audio_vehicle_manager::avm_begin_behavior_def("to_state_distant",::atlasdrn_condition_callback_to_state_distant,["distance2d"]);
	soundscripts\_audio_vehicle_manager::avm_add_loops("NONE");
	soundscripts\_audio_vehicle_manager::avm_end_behavior_def();
	soundscripts\_audio_vehicle_manager::avm_begin_behavior_def("to_state_flyby",::atlasdrn_condition_callback_to_state_flyby,["distance2d"]);
	soundscripts\_audio_vehicle_manager::avm_add_loops("ALL");
	soundscripts\_audio_vehicle_manager::avm_add_oneshots("atlasdrn_flyby1");
	soundscripts\_audio_vehicle_manager::avm_end_behavior_def();
	soundscripts\_audio_vehicle_manager::avm_begin_behavior_def("to_state_deathspin",::atlasdrn_condition_callback_to_state_deathspin);
	soundscripts\_audio_vehicle_manager::avm_add_loops("NONE");
	soundscripts\_audio_vehicle_manager::avm_end_behavior_def();
	soundscripts\_audio_vehicle_manager::avm_begin_behavior_def("to_state_destruct",::atlasdrn_condition_callback_to_state_destruct);
	soundscripts\_audio_vehicle_manager::avm_add_loops("NONE");
	soundscripts\_audio_vehicle_manager::avm_end_behavior_def();
	soundscripts\_audio_vehicle_manager::avm_begin_behavior_def("to_state_off",::atlasdrn_condition_callback_to_state_off);
	soundscripts\_audio_vehicle_manager::avm_add_loops("NONE");
	soundscripts\_audio_vehicle_manager::avm_end_behavior_def();
	soundscripts\_audio_vehicle_manager::avm_end_behavior_data();
	soundscripts\_audio_vehicle_manager::avm_begin_state_data(0.25,50);
	soundscripts\_audio_vehicle_manager::avm_begin_state_group("main_oneshots","state_hover","to_state_hover",50,1);
	soundscripts\_audio_vehicle_manager::avm_begin_state_def("state_off");
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("state_hover","to_state_hover");
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("state_distant","to_state_distant");
	soundscripts\_audio_vehicle_manager::avm_end_state_def();
	soundscripts\_audio_vehicle_manager::avm_begin_state_def("state_hover");
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("state_flyby","to_state_flyby");
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("state_flying","to_state_flying");
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("state_distant","to_state_distant");
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("state_deathspin","to_state_deathspin");
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("state_destruct","to_state_destruct");
	soundscripts\_audio_vehicle_manager::avm_end_state_def();
	soundscripts\_audio_vehicle_manager::avm_begin_state_def("state_flying");
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("state_flyby","to_state_flyby");
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("state_distant","to_state_distant");
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("state_deathspin","to_state_deathspin");
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("state_destruct","to_state_destruct");
	soundscripts\_audio_vehicle_manager::avm_end_state_def();
	soundscripts\_audio_vehicle_manager::avm_begin_state_def("state_distant");
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("state_hover","to_state_hover");
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("state_flying","to_state_flying");
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("state_flyby","to_state_flyby");
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("state_deathspin","to_state_deathspin");
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("state_destruct","to_state_destruct");
	soundscripts\_audio_vehicle_manager::avm_end_state_def();
	soundscripts\_audio_vehicle_manager::avm_begin_state_def("state_flyby",3);
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("state_hover","to_state_hover");
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("state_flying","to_state_flying");
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("state_flyby","to_state_flyby");
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("state_distant","to_state_distant");
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("state_deathspin","to_state_deathspin");
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("state_destruct","to_state_destruct");
	soundscripts\_audio_vehicle_manager::avm_end_state_def();
	soundscripts\_audio_vehicle_manager::avm_begin_state_def("state_deathspin");
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("state_destruct","to_state_destruct");
	soundscripts\_audio_vehicle_manager::avm_end_state_def();
	soundscripts\_audio_vehicle_manager::avm_begin_state_def("state_destruct");
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("state_off","to_state_off");
	soundscripts\_audio_vehicle_manager::avm_end_state_def();
	soundscripts\_audio_vehicle_manager::avm_end_state_group();
	soundscripts\_audio_vehicle_manager::avm_end_state_data();
	soundscripts\_audio_vehicle_manager::avm_end_preset_def();
}

//Function Number: 6
pdrone_atlas_init(param_00)
{
	var_01 = self;
	var_02 = var_01 soundscripts\_audio_vehicle_manager::avmx_get_vehicle_entity();
	var_02 thread atlasdrn_lens_focus();
}

//Function Number: 7
atlasdrn_condition_callback_to_state_off()
{
	return 0;
}

//Function Number: 8
atlasdrn_condition_callback_to_state_hover(param_00,param_01)
{
	var_02 = 0;
	var_03 = param_00["speed"];
	var_04 = param_00["distance2d"];
	var_05 = soundscripts\_audio_vehicle_manager::dist2yards(var_04);
	if(var_03 <= 5.1 && var_05 < 20)
	{
		var_02 = 1;
	}

	return var_02;
}

//Function Number: 9
atlasdrn_condition_callback_to_state_flying(param_00,param_01)
{
	var_02 = 0;
	var_03 = param_00["speed"];
	var_04 = param_00["distance2d"];
	var_05 = soundscripts\_audio_vehicle_manager::dist2yards(var_04);
	if(var_03 > 5.1 && var_05 < 20)
	{
		var_02 = 1;
	}

	return var_02;
}

//Function Number: 10
atlasdrn_condition_callback_to_state_distant(param_00,param_01)
{
	var_02 = 0;
	var_03 = param_00["distance2d"];
	var_04 = soundscripts\_audio_vehicle_manager::dist2yards(var_03);
	if(var_04 >= 20)
	{
		var_02 = 1;
	}

	return var_02;
}

//Function Number: 11
atlasdrn_condition_callback_to_state_flyby(param_00,param_01)
{
	var_02 = 0;
	var_03 = param_00["distance2d"];
	var_04 = soundscripts\_audio_vehicle_manager::dist2yards(var_03);
	if(!isdefined(param_01.flyby))
	{
		param_01.flyby = spawnstruct();
		param_01.flyby.prev_yards = var_04;
		param_01.flyby.prev_dx = 0;
	}
	else
	{
		var_05 = var_04 - param_01.flyby.prev_yards;
		if(var_05 < 0 && var_04 < 6)
		{
			var_02 = 1;
		}

		param_01.flyby.prev_yards = var_04;
		param_01.flyby.prev_dx = var_05;
	}

	return var_02;
}

//Function Number: 12
atlasdrn_condition_callback_to_state_flyover(param_00,param_01)
{
	var_02 = 0;
	var_03 = param_00["distance2d"];
	var_04 = param_00["relative_speed"];
	var_05 = soundscripts\_audio_vehicle_manager::dist2yards(var_03);
	if(var_05 < 30)
	{
		var_02 = 1;
	}

	return var_02;
}

//Function Number: 13
atlasdrn_condition_callback_to_state_deathspin(param_00,param_01)
{
	return 0;
}

//Function Number: 14
atlasdrn_condition_callback_to_state_destruct(param_00,param_01)
{
	return 0;
}

//Function Number: 15
atlasdrn_lens_focus()
{
	self endon("death");
	var_00 = self;
	var_01 = 360;
	var_02 = level.player.origin;
	var_03 = 0.25;
	var_04 = 17.6;
	while(isdefined(var_00))
	{
		if(distance(level.player.origin,var_00.origin) < var_01)
		{
			var_05 = length(level.player getvelocity()) / var_04;
			if(var_05 > 0.5)
			{
				if(soundscripts\_audio::aud_percent_chance(20))
				{
					var_00 maps\_utility::play_sound_on_entity("atlasdrn_lens_focus");
					wait(randomfloatrange(2,5));
				}
			}

			var_02 = level.player.origin;
		}

		wait(var_03);
	}
}

//Function Number: 16
snd_pdrone_atlas_large_constructor()
{
	var_00 = 0;
	var_01 = 30;
	var_02 = var_01 - var_00;
	var_03 = 0.4;
	var_04 = 0.4;
	var_05 = 1.5;
	var_06 = 1.9;
	var_07 = 270;
	var_08 = 3600;
	var_09 = 0;
	var_0A = 1;
	var_0B = var_0A - var_09;
	var_0C = 1;
	var_0D = 2;
	var_0E = var_0D - var_0C;
	var_0F = 0;
	var_10 = 0.45;
	var_11 = var_10 - var_0F;
	var_12 = 0.9;
	var_13 = 1.4;
	var_14 = var_13 - var_12;
	var_15 = 288;
	var_16 = 720;
	var_17 = 0;
	var_18 = 1;
	var_19 = var_01 * 0.6;
	var_1A = var_01 * 1;
	var_1B = var_1A - var_19;
	var_1C = 0.85;
	var_1D = 1.25;
	var_1E = 0;
	var_1F = 1;
	var_20 = 0.5;
	var_21 = 1.5;
	var_22 = 100;
	var_23 = 200;
	var_24 = 500;
	var_25 = 6;
	var_26 = 20;
	var_27 = 5;
	var_28 = undefined;
	var_29 = 0.3;
	var_2A = 0.3;
	soundscripts\_audio_vehicle_manager::avm_begin_preset_def("pdrone_atlas_large");
	soundscripts\_audio_vehicle_manager::avm_begin_loop_data(3,var_29,var_2A);
	soundscripts\_audio_vehicle_manager::avm_begin_loop_def("adrn_real_helo_lp");
	soundscripts\_audio_vehicle_manager::avm_begin_param_map("SPEED");
	soundscripts\_audio_vehicle_manager::avm_add_param_map_env("volume","adrn_realhelo_spd2vol");
	soundscripts\_audio_vehicle_manager::avm_add_param_map_env("pitch","adrn_realhelo_spd2pch");
	soundscripts\_audio_vehicle_manager::avm_end_param_map();
	soundscripts\_audio_vehicle_manager::avm_begin_param_map("DOPPLER_EXAGGERATED");
	soundscripts\_audio_vehicle_manager::avm_add_param_map_env("pitch","adrn_doppler2pch");
	soundscripts\_audio_vehicle_manager::avm_end_param_map();
	soundscripts\_audio_vehicle_manager::avm_end_loop_def();
	soundscripts\_audio_vehicle_manager::avm_begin_loop_def("adrn_snth_helo_lp");
	soundscripts\_audio_vehicle_manager::avm_begin_param_map("SPEED");
	soundscripts\_audio_vehicle_manager::avm_add_param_map_env("volume","adrn_snthhelo_spd2vol");
	soundscripts\_audio_vehicle_manager::avm_add_param_map_env("pitch","adrn_snthhelo_spd2pch");
	soundscripts\_audio_vehicle_manager::avm_end_param_map();
	soundscripts\_audio_vehicle_manager::avm_begin_param_map("DOPPLER");
	soundscripts\_audio_vehicle_manager::avm_add_param_map_env("pitch","adrn_doppler2pch");
	soundscripts\_audio_vehicle_manager::avm_end_param_map();
	soundscripts\_audio_vehicle_manager::avm_end_loop_def();
	soundscripts\_audio_vehicle_manager::avm_begin_loop_def("adrn_hover_lp");
	soundscripts\_audio_vehicle_manager::avm_begin_param_map("SPEED");
	soundscripts\_audio_vehicle_manager::avm_add_param_map_env("volume","adrn_hover_spd2vol");
	soundscripts\_audio_vehicle_manager::avm_add_param_map_env("pitch","adrn_hover_spd2pch");
	soundscripts\_audio_vehicle_manager::avm_end_param_map();
	soundscripts\_audio_vehicle_manager::avm_end_loop_def();
	soundscripts\_audio_vehicle_manager::avm_begin_loop_def("adrn_travel_fst_lp");
	soundscripts\_audio_vehicle_manager::avm_begin_param_map("SPEED");
	soundscripts\_audio_vehicle_manager::avm_add_param_map_env("volume","adrn_travelfst_spd2vol");
	soundscripts\_audio_vehicle_manager::avm_add_param_map_env("pitch","adrn_travelfst_spd2pch");
	soundscripts\_audio_vehicle_manager::avm_end_param_map();
	soundscripts\_audio_vehicle_manager::avm_begin_param_map("DOPPLER");
	soundscripts\_audio_vehicle_manager::avm_add_param_map_env("pitch","adrn_doppler2pch");
	soundscripts\_audio_vehicle_manager::avm_end_param_map();
	soundscripts\_audio_vehicle_manager::avm_end_loop_def();
	soundscripts\_audio_vehicle_manager::avm_end_loop_data();
	soundscripts\_audio_vehicle_manager::avm_begin_oneshot_data();
	soundscripts\_audio_vehicle_manager::avm_begin_oneshot_def("adrn_flyby1","adrn_flyby_duckenvelope",0.25);
	soundscripts\_audio_vehicle_manager::avm_begin_param_map("SPEED",1,1);
	soundscripts\_audio_vehicle_manager::avm_add_param_map_env("pitch","adrn_flyby_vel2pch");
	soundscripts\_audio_vehicle_manager::avm_add_param_map_env("volume","adrn_flyby_vel2vol");
	soundscripts\_audio_vehicle_manager::avm_end_param_map();
	soundscripts\_audio_vehicle_manager::avm_end_oneshot_def();
	soundscripts\_audio_vehicle_manager::avm_end_oneshot_data();
	soundscripts\_audio_vehicle_manager::avm_begin_behavior_data();
	soundscripts\_audio_vehicle_manager::avm_begin_behavior_def("to_state_hover",::adrone_condition_callback_to_state_hover,["speed","distance2d"]);
	soundscripts\_audio_vehicle_manager::avm_add_loops("ALL");
	soundscripts\_audio_vehicle_manager::avm_end_behavior_def();
	soundscripts\_audio_vehicle_manager::avm_begin_behavior_def("to_state_flying",::adrone_condition_callback_to_state_flying,["speed","distance2d"]);
	soundscripts\_audio_vehicle_manager::avm_add_loops("ALL");
	soundscripts\_audio_vehicle_manager::avm_end_behavior_def();
	soundscripts\_audio_vehicle_manager::avm_begin_behavior_def("to_state_distant",::adrone_condition_callback_to_state_distant,["distance2d"]);
	soundscripts\_audio_vehicle_manager::avm_add_loops(["adrn_real_helo_lp"]);
	soundscripts\_audio_vehicle_manager::avm_end_behavior_def();
	soundscripts\_audio_vehicle_manager::avm_begin_behavior_def("to_state_flyby",::adrone_condition_callback_to_state_flyby,["distance2d"]);
	soundscripts\_audio_vehicle_manager::avm_add_loops("ALL");
	soundscripts\_audio_vehicle_manager::avm_add_oneshots("adrn_flyby1");
	soundscripts\_audio_vehicle_manager::avm_end_behavior_def();
	soundscripts\_audio_vehicle_manager::avm_begin_behavior_def("to_state_deathspin",::adrone_condition_callback_to_state_deathspin);
	soundscripts\_audio_vehicle_manager::avm_add_loops("NONE");
	soundscripts\_audio_vehicle_manager::avm_end_behavior_def();
	soundscripts\_audio_vehicle_manager::avm_begin_behavior_def("to_state_destruct",::adrone_condition_callback_to_state_destruct);
	soundscripts\_audio_vehicle_manager::avm_add_loops("NONE");
	soundscripts\_audio_vehicle_manager::avm_end_behavior_def();
	soundscripts\_audio_vehicle_manager::avm_begin_behavior_def("to_state_off",::adrone_condition_callback_to_state_off);
	soundscripts\_audio_vehicle_manager::avm_add_loops("NONE");
	soundscripts\_audio_vehicle_manager::avm_end_behavior_def();
	soundscripts\_audio_vehicle_manager::avm_end_behavior_data();
	soundscripts\_audio_vehicle_manager::avm_begin_state_data(0.25,50);
	soundscripts\_audio_vehicle_manager::avm_begin_state_group("main_oneshots","state_hover","to_state_hover",50,1);
	soundscripts\_audio_vehicle_manager::avm_begin_state_def("state_off");
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("state_hover","to_state_hover");
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("state_distant","to_state_distant");
	soundscripts\_audio_vehicle_manager::avm_end_state_def();
	soundscripts\_audio_vehicle_manager::avm_begin_state_def("state_hover");
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("state_flyby","to_state_flyby");
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("state_flying","to_state_flying");
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("state_distant","to_state_distant");
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("state_deathspin","to_state_deathspin");
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("state_destruct","to_state_destruct");
	soundscripts\_audio_vehicle_manager::avm_end_state_def();
	soundscripts\_audio_vehicle_manager::avm_begin_state_def("state_flying");
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("state_flyby","to_state_flyby");
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("state_distant","to_state_distant");
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("state_deathspin","to_state_deathspin");
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("state_destruct","to_state_destruct");
	soundscripts\_audio_vehicle_manager::avm_end_state_def();
	soundscripts\_audio_vehicle_manager::avm_begin_state_def("state_distant");
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("state_hover","to_state_hover");
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("state_flying","to_state_flying");
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("state_flyby","to_state_flyby");
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("state_deathspin","to_state_deathspin");
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("state_destruct","to_state_destruct");
	soundscripts\_audio_vehicle_manager::avm_end_state_def();
	soundscripts\_audio_vehicle_manager::avm_begin_state_def("state_flyby",3);
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("state_hover","to_state_hover");
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("state_flying","to_state_flying");
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("state_flyby","to_state_flyby");
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("state_distant","to_state_distant");
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("state_deathspin","to_state_deathspin");
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("state_destruct","to_state_destruct");
	soundscripts\_audio_vehicle_manager::avm_end_state_def();
	soundscripts\_audio_vehicle_manager::avm_begin_state_def("state_deathspin");
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("state_destruct","to_state_destruct");
	soundscripts\_audio_vehicle_manager::avm_end_state_def();
	soundscripts\_audio_vehicle_manager::avm_begin_state_def("state_destruct");
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("state_off","to_state_off");
	soundscripts\_audio_vehicle_manager::avm_end_state_def();
	soundscripts\_audio_vehicle_manager::avm_end_state_group();
	soundscripts\_audio_vehicle_manager::avm_end_state_data();
	soundscripts\_audio_vehicle_manager::avm_add_envelope("adrn_realhelo_spd2vol",[[0,0.2827],[30,0.466]]);
	soundscripts\_audio_vehicle_manager::avm_add_envelope("adrn_realhelo_spd2pch",[[0,1.45],[22.5178,1.7906],[30,2]]);
	soundscripts\_audio_vehicle_manager::avm_add_envelope("adrn_snthhelo_spd2vol",[[0,0.0026],[4.2043,0],[12.4703,0.144],[30,0.5]]);
	soundscripts\_audio_vehicle_manager::avm_add_envelope("adrn_snthhelo_spd2pch",[[0,0.555],[30,2]]);
	soundscripts\_audio_vehicle_manager::avm_add_envelope("adrn_snthhelo_dst2vol",[[var_07,var_0A],[var_08,var_09]]);
	soundscripts\_audio_vehicle_manager::avm_add_envelope("adrn_hover_spd2vol",[[0,0.0974],[2.3515,0.0958],[5.4157,0.1084],[13.4679,0.2027],[18.171,0.2403],[30,0.3]]);
	soundscripts\_audio_vehicle_manager::avm_add_envelope("adrn_hover_spd2pch",[[0,0.8584],[30,1.25]]);
	soundscripts\_audio_vehicle_manager::avm_add_envelope("adrn_travelfst_spd2vol",[[0,0],[7.4109,0],[13.9667,0.0385],[19.1686,0.1026],[23.3729,0.1686],[26.2233,0.2456],[30,0.35]]);
	soundscripts\_audio_vehicle_manager::avm_add_envelope("adrn_travelfst_spd2pch",[[0,0.8584],[30,1.25]]);
	soundscripts\_audio_vehicle_manager::avm_add_envelope("adrn_travelfst_dst2vol",[[0,0.2827],[30,0.466]]);
	soundscripts\_audio_vehicle_manager::avm_add_envelope("adrn_flyby_vel2vol",[[var_00,var_1E],[var_02 * 0.25,var_1F * 0.5],[var_01,var_1F]]);
	soundscripts\_audio_vehicle_manager::avm_add_envelope("adrn_flyby_vel2pch",[[var_00,var_20],[var_01,var_21]]);
	soundscripts\_audio_vehicle_manager::avm_add_envelope("adrn_doppler2pch",[[0,0],[2,2]]);
	soundscripts\_audio_vehicle_manager::avm_add_envelope("adrn_flyby_duckenvelope",[[0,1],[0.4,0.7],[0.6,0.5],[0.8,0.7],[1,1]]);
	soundscripts\_audio_vehicle_manager::avm_end_preset_def();
}

//Function Number: 17
adrone_condition_callback_to_state_off()
{
	return 0;
}

//Function Number: 18
adrone_condition_callback_to_state_hover(param_00,param_01)
{
	var_02 = 0;
	var_03 = param_00["speed"];
	var_04 = param_00["distance2d"];
	var_05 = soundscripts\_audio_vehicle_manager::dist2yards(var_04);
	if(var_03 <= 5.1 && var_05 < 30)
	{
		var_02 = 1;
	}

	return var_02;
}

//Function Number: 19
adrone_condition_callback_to_state_flying(param_00,param_01)
{
	var_02 = 0;
	var_03 = param_00["speed"];
	var_04 = param_00["distance2d"];
	var_05 = soundscripts\_audio_vehicle_manager::dist2yards(var_04);
	if(var_03 > 5.1 && var_05 < 30)
	{
		var_02 = 1;
	}

	return var_02;
}

//Function Number: 20
adrone_condition_callback_to_state_distant(param_00,param_01)
{
	var_02 = 0;
	var_03 = param_00["distance2d"];
	var_04 = soundscripts\_audio_vehicle_manager::dist2yards(var_03);
	if(var_04 >= 30)
	{
		var_02 = 1;
	}

	return var_02;
}

//Function Number: 21
adrone_condition_callback_to_state_flyby(param_00,param_01)
{
	var_02 = 0;
	var_03 = param_00["distance2d"];
	var_04 = soundscripts\_audio_vehicle_manager::dist2yards(var_03);
	if(!isdefined(param_01.flyby))
	{
		param_01.flyby = spawnstruct();
		param_01.flyby.prev_yards = var_04;
		param_01.flyby.prev_dx = 0;
	}
	else
	{
		var_05 = var_04 - param_01.flyby.prev_yards;
		if(var_05 < 0 && var_04 < 6)
		{
			var_02 = 1;
		}

		param_01.flyby.prev_yards = var_04;
		param_01.flyby.prev_dx = var_05;
	}

	return var_02;
}

//Function Number: 22
adrone_condition_callback_to_state_flyover(param_00,param_01)
{
	var_02 = 0;
	var_03 = param_00["distance2d"];
	var_04 = param_00["relative_speed"];
	var_05 = soundscripts\_audio_vehicle_manager::dist2yards(var_03);
	if(var_05 < 30)
	{
		var_02 = 1;
	}

	return var_02;
}

//Function Number: 23
adrone_condition_callback_to_state_deathspin(param_00,param_01)
{
	return 0;
}

//Function Number: 24
adrone_condition_callback_to_state_destruct(param_00,param_01)
{
	return 0;
}

//Function Number: 25
snd_pdrone_constructor()
{
	var_00 = 1;
	var_01 = 0.8;
	var_02 = 0;
	var_03 = 10;
	var_04 = 15;
	var_05 = var_04 - var_02;
	var_06 = 0.7;
	var_07 = 1;
	var_08 = 0.8;
	var_09 = 1;
	var_0A = 1.1;
	var_0B = 0;
	var_0C = 0.5;
	var_0D = 0.85;
	var_0E = 1;
	var_0F = 0;
	var_10 = 0.5;
	var_11 = 1;
	var_12 = 0.8;
	var_13 = 1.1;
	var_14 = 0;
	var_15 = 1;
	var_16 = 0.5;
	var_17 = 1.5;
	soundscripts\_audio_vehicle_manager::avm_begin_preset_def("pdrone");
	soundscripts\_audio_vehicle_manager::avm_begin_loop_data(3);
	soundscripts\_audio_vehicle_manager::avm_begin_loop_def("pdrn_rotor_ww_lw");
	soundscripts\_audio_vehicle_manager::avm_begin_param_map("speed");
	soundscripts\_audio_vehicle_manager::avm_add_param_map_env("volume","pdrn_rotor_ww_lw");
	soundscripts\_audio_vehicle_manager::avm_add_param_map_env("volume","pdrn_loopset_vol_env");
	soundscripts\_audio_vehicle_manager::avm_end_param_map();
	soundscripts\_audio_vehicle_manager::avm_begin_param_map("doppler_exaggerated");
	soundscripts\_audio_vehicle_manager::avm_add_param_map_env("pitch","pdrn_doppler2pch");
	soundscripts\_audio_vehicle_manager::avm_end_param_map();
	soundscripts\_audio_vehicle_manager::avm_end_loop_def();
	soundscripts\_audio_vehicle_manager::avm_begin_loop_def("pdrn_rotor_ww_md");
	soundscripts\_audio_vehicle_manager::avm_begin_param_map("speed");
	soundscripts\_audio_vehicle_manager::avm_add_param_map_env("volume","pdrn_rotor_ww_hi");
	soundscripts\_audio_vehicle_manager::avm_add_param_map_env("volume","pdrn_loopset_vol_env");
	soundscripts\_audio_vehicle_manager::avm_end_param_map();
	soundscripts\_audio_vehicle_manager::avm_begin_param_map("doppler_exaggerated");
	soundscripts\_audio_vehicle_manager::avm_add_param_map_env("pitch","pdrn_doppler2pch");
	soundscripts\_audio_vehicle_manager::avm_end_param_map();
	soundscripts\_audio_vehicle_manager::avm_end_loop_def();
	soundscripts\_audio_vehicle_manager::avm_begin_loop_def("pdrn_rotor_ww_hi");
	soundscripts\_audio_vehicle_manager::avm_begin_param_map("speed");
	soundscripts\_audio_vehicle_manager::avm_add_param_map_env("volume","pdrn_rotor_ww_md");
	soundscripts\_audio_vehicle_manager::avm_add_param_map_env("volume","pdrn_loopset_vol_env");
	soundscripts\_audio_vehicle_manager::avm_end_param_map();
	soundscripts\_audio_vehicle_manager::avm_begin_param_map("doppler_exaggerated");
	soundscripts\_audio_vehicle_manager::avm_add_param_map_env("pitch","pdrn_doppler2pch");
	soundscripts\_audio_vehicle_manager::avm_end_param_map();
	soundscripts\_audio_vehicle_manager::avm_end_loop_def();
	soundscripts\_audio_vehicle_manager::avm_begin_loop_def("pdrn_rotor_main_lp");
	soundscripts\_audio_vehicle_manager::avm_begin_param_map("speed",0.65,0.3);
	soundscripts\_audio_vehicle_manager::avm_add_param_map_env("volume","pdrn_rotor_vel2vol");
	soundscripts\_audio_vehicle_manager::avm_add_param_map_env("volume","pdrn_loopset_vol_env");
	soundscripts\_audio_vehicle_manager::avm_end_param_map();
	soundscripts\_audio_vehicle_manager::avm_begin_param_map("doppler_exaggerated",0.65,0.3);
	soundscripts\_audio_vehicle_manager::avm_add_param_map_env("pitch","pdrn_doppler2pch");
	soundscripts\_audio_vehicle_manager::avm_end_param_map();
	soundscripts\_audio_vehicle_manager::avm_end_loop_def();
	if(!level.currentgen)
	{
		soundscripts\_audio_vehicle_manager::avm_begin_loop_def("pdrn_whine_lp");
		soundscripts\_audio_vehicle_manager::avm_begin_param_map("speed",0.65,0.3);
		soundscripts\_audio_vehicle_manager::avm_add_param_map_env("volume","pdrn_whine_vel2vol");
		soundscripts\_audio_vehicle_manager::avm_end_param_map();
		soundscripts\_audio_vehicle_manager::avm_begin_param_map("doppler_exaggerated",0.65,0.3);
		soundscripts\_audio_vehicle_manager::avm_add_param_map_env("pitch","pdrn_doppler2pch");
		soundscripts\_audio_vehicle_manager::avm_end_param_map();
		soundscripts\_audio_vehicle_manager::avm_end_loop_def();
		soundscripts\_audio_vehicle_manager::avm_begin_loop_def("pdrn_pink_hipass_lp");
		soundscripts\_audio_vehicle_manager::avm_begin_param_map("speed");
		soundscripts\_audio_vehicle_manager::avm_add_param_map_env("volume","pdrn_noise_hi_vel2vol");
		soundscripts\_audio_vehicle_manager::avm_end_param_map();
		soundscripts\_audio_vehicle_manager::avm_begin_param_map("distance");
		soundscripts\_audio_vehicle_manager::avm_add_param_map_env("volume","pdrn_noise_hi_dist2vol");
		soundscripts\_audio_vehicle_manager::avm_end_param_map();
		soundscripts\_audio_vehicle_manager::avm_begin_param_map("doppler_exaggerated",0.65,0.3);
		soundscripts\_audio_vehicle_manager::avm_add_param_map_env("pitch","pdrn_doppler2pch");
		soundscripts\_audio_vehicle_manager::avm_end_param_map();
		soundscripts\_audio_vehicle_manager::avm_end_loop_def();
		soundscripts\_audio_vehicle_manager::avm_begin_loop_def("pdrn_pink_lopass_lp");
		soundscripts\_audio_vehicle_manager::avm_begin_param_map("speed");
		soundscripts\_audio_vehicle_manager::avm_add_param_map_env("volume","pdrn_noise_lo_vel2vol");
		soundscripts\_audio_vehicle_manager::avm_end_param_map();
		soundscripts\_audio_vehicle_manager::avm_begin_param_map("distance");
		soundscripts\_audio_vehicle_manager::avm_add_param_map_env("volume","pdrn_noise_lo_dist2vol");
		soundscripts\_audio_vehicle_manager::avm_end_param_map();
		soundscripts\_audio_vehicle_manager::avm_begin_param_map("doppler_exaggerated",0.65,0.3);
		soundscripts\_audio_vehicle_manager::avm_add_param_map_env("pitch","pdrn_doppler2pch");
		soundscripts\_audio_vehicle_manager::avm_end_param_map();
		soundscripts\_audio_vehicle_manager::avm_end_loop_def();
	}

	soundscripts\_audio_vehicle_manager::avm_end_loop_data();
	soundscripts\_audio_vehicle_manager::avm_begin_oneshot_data();
	soundscripts\_audio_vehicle_manager::avm_begin_oneshot_def("pdrone_flyby","pdrn_flyby_duck_envelope",0.25,1,["pdrn_by_1","pdrn_by_2"]);
	soundscripts\_audio_vehicle_manager::avm_begin_param_map("speed",1,1);
	soundscripts\_audio_vehicle_manager::avm_add_param_map_env("pitch","pdrn_flyby_vel2pch");
	soundscripts\_audio_vehicle_manager::avm_add_param_map_env("volume","pdrn_flyby_vel2vol");
	soundscripts\_audio_vehicle_manager::avm_end_param_map();
	soundscripts\_audio_vehicle_manager::avm_begin_param_map("doppler_exaggerated",1,1);
	soundscripts\_audio_vehicle_manager::avm_add_param_map_env("pitch","pdrn_doppler2pch");
	soundscripts\_audio_vehicle_manager::avm_end_param_map();
	soundscripts\_audio_vehicle_manager::avm_end_oneshot_def();
	soundscripts\_audio_vehicle_manager::avm_begin_oneshot_def("foo_oneshot","pdrn_flyby_duck_envelope",0.25,1,["pdrn_by_1","pdrn_by_2"]);
	soundscripts\_audio_vehicle_manager::avm_begin_param_map("speed",1,1);
	soundscripts\_audio_vehicle_manager::avm_add_param_map_env("pitch","pdrn_flyby_vel2pch");
	soundscripts\_audio_vehicle_manager::avm_add_param_map_env("volume","pdrn_flyby_vel2vol");
	soundscripts\_audio_vehicle_manager::avm_end_param_map();
	soundscripts\_audio_vehicle_manager::avm_begin_param_map("doppler_exaggerated",1,1);
	soundscripts\_audio_vehicle_manager::avm_add_param_map_env("pitch","pdrn_doppler2pch");
	soundscripts\_audio_vehicle_manager::avm_end_param_map();
	soundscripts\_audio_vehicle_manager::avm_end_oneshot_def();
	soundscripts\_audio_vehicle_manager::avm_end_oneshot_data();
	soundscripts\_audio_vehicle_manager::avm_begin_behavior_data();
	soundscripts\_audio_vehicle_manager::avm_begin_behavior_def("to_state_hover",::pdrone_condition_callback_to_state_hover,["speed","distance2d"]);
	soundscripts\_audio_vehicle_manager::avm_add_loops("ALL");
	soundscripts\_audio_vehicle_manager::avm_end_behavior_def();
	soundscripts\_audio_vehicle_manager::avm_begin_behavior_def("to_state_flying",::pdrone_condition_callback_to_state_flying,["speed","distance2d"]);
	soundscripts\_audio_vehicle_manager::avm_add_loops("ALL");
	soundscripts\_audio_vehicle_manager::avm_add_oneshots("foo_oneshot");
	soundscripts\_audio_vehicle_manager::avm_end_behavior_def();
	soundscripts\_audio_vehicle_manager::avm_begin_behavior_def("to_state_distant",::pdrone_condition_callback_to_state_distant,["distance2d"]);
	soundscripts\_audio_vehicle_manager::avm_add_loops("pdrn_rotor_main_lp");
	soundscripts\_audio_vehicle_manager::avm_end_behavior_def();
	soundscripts\_audio_vehicle_manager::avm_begin_behavior_def("to_state_flyby",::pdrone_condition_callback_to_state_flyby,["distance2d"]);
	soundscripts\_audio_vehicle_manager::avm_add_loops("ALL");
	if(!0)
	{
		soundscripts\_audio_vehicle_manager::avm_add_oneshots("pdrone_flyby");
	}

	soundscripts\_audio_vehicle_manager::avm_end_behavior_def();
	soundscripts\_audio_vehicle_manager::avm_begin_behavior_def("to_state_deathspin",::pdrone_condition_callback_to_state_deathspin);
	soundscripts\_audio_vehicle_manager::avm_add_loops("NONE");
	soundscripts\_audio_vehicle_manager::avm_end_behavior_def();
	soundscripts\_audio_vehicle_manager::avm_begin_behavior_def("to_state_destruct",::pdrone_condition_callback_to_state_destruct);
	soundscripts\_audio_vehicle_manager::avm_add_loops("NONE");
	soundscripts\_audio_vehicle_manager::avm_end_behavior_def();
	soundscripts\_audio_vehicle_manager::avm_begin_behavior_def("to_state_off",::pdrone_condition_callback_to_state_off);
	soundscripts\_audio_vehicle_manager::avm_add_loops("NONE");
	soundscripts\_audio_vehicle_manager::avm_end_behavior_def();
	soundscripts\_audio_vehicle_manager::avm_end_behavior_data();
	soundscripts\_audio_vehicle_manager::avm_begin_state_data(0.25,50);
	soundscripts\_audio_vehicle_manager::avm_begin_state_group("main_oneshots","state_hover","to_state_hover",50,1);
	soundscripts\_audio_vehicle_manager::avm_begin_state_def("state_off");
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("state_hover","to_state_hover");
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("state_distant","to_state_distant");
	soundscripts\_audio_vehicle_manager::avm_end_state_def();
	soundscripts\_audio_vehicle_manager::avm_begin_state_def("state_hover");
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("state_flyby","to_state_flyby");
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("state_flying","to_state_flying");
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("state_distant","to_state_distant");
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("state_deathspin","to_state_deathspin");
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("state_destruct","to_state_destruct");
	soundscripts\_audio_vehicle_manager::avm_end_state_def();
	soundscripts\_audio_vehicle_manager::avm_begin_state_def("state_flying");
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("state_flyby","to_state_flyby");
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("state_distant","to_state_distant");
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("state_deathspin","to_state_deathspin");
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("state_destruct","to_state_destruct");
	soundscripts\_audio_vehicle_manager::avm_end_state_def();
	soundscripts\_audio_vehicle_manager::avm_begin_state_def("state_distant");
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("state_hover","to_state_hover");
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("state_flying","to_state_flying");
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("state_flyby","to_state_flyby");
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("state_deathspin","to_state_deathspin");
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("state_destruct","to_state_destruct");
	soundscripts\_audio_vehicle_manager::avm_end_state_def();
	soundscripts\_audio_vehicle_manager::avm_begin_state_def("state_flyby",3);
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("state_hover","to_state_hover");
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("state_flying","to_state_flying");
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("state_flyby","to_state_flyby");
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("state_distant","to_state_distant");
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("state_deathspin","to_state_deathspin");
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("state_destruct","to_state_destruct");
	soundscripts\_audio_vehicle_manager::avm_end_state_def();
	soundscripts\_audio_vehicle_manager::avm_begin_state_def("state_deathspin");
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("state_destruct","to_state_destruct");
	soundscripts\_audio_vehicle_manager::avm_end_state_def();
	soundscripts\_audio_vehicle_manager::avm_begin_state_def("state_destruct");
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("state_off","to_state_off");
	soundscripts\_audio_vehicle_manager::avm_end_state_def();
	soundscripts\_audio_vehicle_manager::avm_end_state_group();
	soundscripts\_audio_vehicle_manager::avm_end_state_data();
	soundscripts\_audio_vehicle_manager::avm_add_envelope("pdrn_foo_env_function",::foo_env_function);
	soundscripts\_audio_vehicle_manager::avm_add_envelope("pdrn_loopset_vol_env",[[var_04 * 0,0.65 * var_00],[var_04 * 0.0204,0.66155 * var_00],[var_04 * 0.0816,0.670545 * var_00],[var_04 * 0.1836,0.688885 * var_00],[var_04 * 0.3265,0.7274899 * var_00],[var_04 * 0.5102,0.80554 * var_00],[var_04 * 0.7346,0.926535 * var_00],[var_04 * 1,1 * var_00]]);
	soundscripts\_audio_vehicle_manager::avm_add_envelope("pdrn_rotor_ww_lw",[[var_04 * 0,1],[var_04 * 0.333,1],[var_04 * 0.666,0],[var_04 * 1,0]]);
	soundscripts\_audio_vehicle_manager::avm_add_envelope("pdrn_rotor_ww_md",[[var_04 * 0,0],[var_04 * 0.333,1],[var_04 * 0.666,1],[var_04 * 1,0]]);
	soundscripts\_audio_vehicle_manager::avm_add_envelope("pdrn_rotor_ww_hi",[[var_04 * 0,0],[var_04 * 0.333,0],[var_04 * 0.666,1],[var_04 * 1,1]]);
	soundscripts\_audio_vehicle_manager::avm_add_envelope("pdrn_rotor_vel2vol",[[var_02,var_06],[var_04,var_07]]);
	soundscripts\_audio_vehicle_manager::avm_add_envelope("pdrn_rotor_vel2pch",[[var_02,var_08],[var_03,var_09],[var_04,var_0A]]);
	soundscripts\_audio_vehicle_manager::avm_add_envelope("pdrn_whine_vel2vol",[[var_02,var_0B],[var_02 + var_04 - var_02 * 0.666,var_0B + var_0C - var_0B * 0],[var_04,var_0C]]);
	soundscripts\_audio_vehicle_manager::avm_add_envelope("pdrn_whine_vel2pch",[[var_02,var_0D],[var_04,var_0E]]);
	soundscripts\_audio_vehicle_manager::avm_add_envelope("pdrn_noise_lo_vel2vol",[[var_02,var_0F],[var_02 + var_04 - var_02 * 0.66,var_0B],[var_04,var_10]]);
	soundscripts\_audio_vehicle_manager::avm_add_envelope("pdrn_noise_hi_vel2vol",[[var_02,var_0F],[var_02 + var_04 - var_02 * 0.66,var_0B],[var_04,var_11]]);
	soundscripts\_audio_vehicle_manager::avm_add_envelope("pdrn_noise_vel2pch",[[var_02,var_12],[var_04,var_12]]);
	soundscripts\_audio_vehicle_manager::avm_add_envelope("pdrn_noise_hi_dist2vol",[[soundscripts\_audio_vehicle_manager::yards2dist(0),var_11],[soundscripts\_audio_vehicle_manager::yards2dist(4),var_11 * 0.25],[soundscripts\_audio_vehicle_manager::yards2dist(6),var_11 * 0.4],[soundscripts\_audio_vehicle_manager::yards2dist(8),var_0F]]);
	soundscripts\_audio_vehicle_manager::avm_add_envelope("pdrn_noise_lo_dist2vol",[[soundscripts\_audio_vehicle_manager::yards2dist(3),var_10],[soundscripts\_audio_vehicle_manager::yards2dist(12),var_0F]]);
	soundscripts\_audio_vehicle_manager::avm_add_envelope("pdrn_flyby_vel2vol",[[var_02,var_14],[var_04,var_15]]);
	soundscripts\_audio_vehicle_manager::avm_add_envelope("pdrn_flyby_vel2pch",[[var_02,var_16],[var_04,var_17]]);
	soundscripts\_audio_vehicle_manager::avm_add_envelope("pdrn_flyby_duck_envelope",[[0,1],[0.33,0.33],[0.66,0.33],[1.33,1]]);
	soundscripts\_audio_vehicle_manager::avm_add_envelope("pdrn_doppler2pch",[[0,0],[2,2]]);
	soundscripts\_audio_vehicle_manager::avm_end_preset_def();
}

//Function Number: 26
foo_env_function()
{
	return 1;
}

//Function Number: 27
pdrone_condition_callback_to_state_off()
{
	return 0;
}

//Function Number: 28
pdrone_condition_callback_to_state_hover(param_00,param_01)
{
	var_02 = 0;
	var_03 = param_00["speed"];
	var_04 = param_00["distance2d"];
	var_05 = soundscripts\_audio_vehicle_manager::dist2yards(var_04);
	if(var_03 <= 5.1 && var_05 < 25)
	{
		var_02 = 1;
	}

	return var_02;
}

//Function Number: 29
pdrone_condition_callback_to_state_flying(param_00,param_01)
{
	var_02 = 0;
	var_03 = param_00["speed"];
	var_04 = param_00["distance2d"];
	var_05 = soundscripts\_audio_vehicle_manager::dist2yards(var_04);
	if(var_03 > 5.1 && var_05 < 25)
	{
		var_02 = 1;
	}

	return var_02;
}

//Function Number: 30
pdrone_condition_callback_to_state_distant(param_00,param_01)
{
	var_02 = 0;
	var_03 = param_00["distance2d"];
	var_04 = soundscripts\_audio_vehicle_manager::dist2yards(var_03);
	if(var_04 >= 25)
	{
		var_02 = 1;
	}

	return var_02;
}

//Function Number: 31
pdrone_condition_callback_to_state_flyby(param_00,param_01)
{
	var_02 = 0;
	var_03 = param_00["distance2d"];
	var_04 = soundscripts\_audio_vehicle_manager::dist2yards(var_03);
	if(!isdefined(param_01.flyby))
	{
		param_01.flyby = spawnstruct();
		param_01.flyby.prev_yards = var_04;
		param_01.flyby.prev_dx = 0;
	}
	else
	{
		var_05 = var_04 - param_01.flyby.prev_yards;
		if(var_05 < 0 && var_04 < 6)
		{
			if(0)
			{
				var_02 = ["pdrone_flyby"];
			}
			else
			{
				var_02 = 1;
			}
		}

		param_01.flyby.prev_yards = var_04;
		param_01.flyby.prev_dx = var_05;
	}

	return var_02;
}

//Function Number: 32
pdrone_condition_callback_to_state_flyover(param_00,param_01)
{
	var_02 = 0;
	var_03 = param_00["distance2d"];
	var_04 = param_00["relative_speed"];
	var_05 = soundscripts\_audio_vehicle_manager::dist2yards(var_03);
	if(var_05 < 30)
	{
		var_02 = 1;
	}

	return var_02;
}

//Function Number: 33
pdrone_condition_callback_to_state_deathspin(param_00,param_01)
{
	return 0;
}

//Function Number: 34
pdrone_condition_callback_to_state_destruct(param_00,param_01)
{
	return 0;
}

//Function Number: 35
pdrone_speed_modifier_callback_smoother(param_00,param_01)
{
	if(!isdefined(param_01.input_scalar_target))
	{
		param_01.input_scalar_target = 1;
		param_01.input_scalar_actual = 1;
		param_01.min_range = 0.7;
		param_01.max_range = 1.2;
		param_01.smooth_up = 0.65;
		param_01.smooth_down = 0.3;
	}

	if(abs(param_01.input_scalar_actual - param_01.input_scalar_target) < 0.0001)
	{
		param_01.input_scalar_target = randomfloatrange(param_01.min_range,param_01.max_range);
	}

	if(param_01.input_scalar_target > param_01.input_scalar_actual)
	{
		var_02 = param_01.smooth_up;
	}
	else
	{
		var_02 = var_02.smooth_down;
	}

	param_01.input_scalar_actual = param_01.input_scalar_actual + var_02 * param_01.input_scalar_target - param_01.input_scalar_actual;
	return param_00 * param_01.input_scalar_actual;
}

//Function Number: 36
pdrone_speed_modifier_callback_perlin_noise(param_00,param_01)
{
	if(!isdefined(param_01.input_scalar_target))
	{
		param_01.world_x = 0;
	}

	param_01.world_x = param_01.world_x + 1;
	var_02 = gettime() * 0.001;
	var_03 = 0;
	var_04 = 2;
	var_05 = 2;
	var_06 = 1;
	var_07 = perlinnoise2d(var_02,var_03,var_04,var_05,1);
	return param_00 * 1;
}

//Function Number: 37
pdrone_speed_modifier_callback_linear(param_00,param_01)
{
	if(!isdefined(param_01.input_scalar_target) || gettime() >= param_01.input_start_time + param_01.input_delta_time)
	{
		param_01.input_scalar_actual = 1;
		param_01.input_scalar_target = randomfloatrange(0.7,1.2);
		param_01.input_start_time = gettime();
		param_01.input_delta_time = randomintrange(500,500);
	}

	var_02 = param_01.input_scalar_target - param_01.input_scalar_actual / param_01.input_delta_time;
	param_01.input_scalar_actual = param_01.input_scalar_actual + var_02;
	return param_00 * 1;
}