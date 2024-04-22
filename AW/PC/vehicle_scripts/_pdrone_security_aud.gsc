/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: _pdrone_security_aud.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 13
 * Decompile Time: 228 ms
 * Timestamp: 4/22/2024 2:05:23 AM
*******************************************************************/

//Function Number: 1
snd_pdrone_security_constructor()
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
	soundscripts\_audio_vehicle_manager::avm_begin_preset_def("pdrone_security");
	soundscripts\_audio_vehicle_manager::avm_begin_loop_data(3);
	soundscripts\_audio_vehicle_manager::avm_begin_loop_def("sdrone_thrusters_lw");
	soundscripts\_audio_vehicle_manager::avm_begin_param_map("speed");
	soundscripts\_audio_vehicle_manager::avm_add_param_map_env("volume","sdrone_thrusters_lw");
	soundscripts\_audio_vehicle_manager::avm_add_param_map_env("volume","pdrone_security_loopset_vol_env");
	soundscripts\_audio_vehicle_manager::avm_end_param_map();
	soundscripts\_audio_vehicle_manager::avm_begin_param_map("doppler_exaggerated");
	soundscripts\_audio_vehicle_manager::avm_add_param_map_env("pitch","pdrone_security_doppler2pch");
	soundscripts\_audio_vehicle_manager::avm_end_param_map();
	soundscripts\_audio_vehicle_manager::avm_end_loop_def();
	soundscripts\_audio_vehicle_manager::avm_begin_loop_def("sdrone_thrusters_md");
	soundscripts\_audio_vehicle_manager::avm_begin_param_map("speed");
	soundscripts\_audio_vehicle_manager::avm_add_param_map_env("volume","sdrone_thrusters_hi");
	soundscripts\_audio_vehicle_manager::avm_add_param_map_env("volume","pdrone_security_loopset_vol_env");
	soundscripts\_audio_vehicle_manager::avm_end_param_map();
	soundscripts\_audio_vehicle_manager::avm_begin_param_map("doppler_exaggerated");
	soundscripts\_audio_vehicle_manager::avm_add_param_map_env("pitch","pdrone_security_doppler2pch");
	soundscripts\_audio_vehicle_manager::avm_end_param_map();
	soundscripts\_audio_vehicle_manager::avm_end_loop_def();
	soundscripts\_audio_vehicle_manager::avm_begin_loop_def("sdrone_thrusters_hi");
	soundscripts\_audio_vehicle_manager::avm_begin_param_map("speed");
	soundscripts\_audio_vehicle_manager::avm_add_param_map_env("volume","sdrone_thrusters_md");
	soundscripts\_audio_vehicle_manager::avm_add_param_map_env("volume","pdrone_security_loopset_vol_env");
	soundscripts\_audio_vehicle_manager::avm_end_param_map();
	soundscripts\_audio_vehicle_manager::avm_begin_param_map("doppler_exaggerated");
	soundscripts\_audio_vehicle_manager::avm_add_param_map_env("pitch","pdrone_security_doppler2pch");
	soundscripts\_audio_vehicle_manager::avm_end_param_map();
	soundscripts\_audio_vehicle_manager::avm_end_loop_def();
	soundscripts\_audio_vehicle_manager::avm_begin_loop_def("sdrone_thrusters_main_lp");
	soundscripts\_audio_vehicle_manager::avm_begin_param_map("speed",0.65,0.3);
	soundscripts\_audio_vehicle_manager::avm_add_param_map_env("volume","pdrone_security_rotor_vel2vol");
	soundscripts\_audio_vehicle_manager::avm_add_param_map_env("volume","pdrone_security_loopset_vol_env");
	soundscripts\_audio_vehicle_manager::avm_end_param_map();
	soundscripts\_audio_vehicle_manager::avm_begin_param_map("doppler_exaggerated",0.65,0.3);
	soundscripts\_audio_vehicle_manager::avm_add_param_map_env("pitch","pdrone_security_doppler2pch");
	soundscripts\_audio_vehicle_manager::avm_end_param_map();
	soundscripts\_audio_vehicle_manager::avm_end_loop_def();
	if(!level.currentgen)
	{
		soundscripts\_audio_vehicle_manager::avm_begin_loop_def("sdrone_thrusters_whine_lp");
		soundscripts\_audio_vehicle_manager::avm_begin_param_map("speed",0.65,0.3);
		soundscripts\_audio_vehicle_manager::avm_add_param_map_env("volume","pdrone_security_whine_vel2vol");
		soundscripts\_audio_vehicle_manager::avm_end_param_map();
		soundscripts\_audio_vehicle_manager::avm_begin_param_map("doppler_exaggerated",0.65,0.3);
		soundscripts\_audio_vehicle_manager::avm_add_param_map_env("pitch","pdrone_security_doppler2pch");
		soundscripts\_audio_vehicle_manager::avm_end_param_map();
		soundscripts\_audio_vehicle_manager::avm_end_loop_def();
		soundscripts\_audio_vehicle_manager::avm_begin_loop_def("pdrone_security_pink_hipass_lp");
		soundscripts\_audio_vehicle_manager::avm_begin_param_map("speed");
		soundscripts\_audio_vehicle_manager::avm_add_param_map_env("volume","pdrone_security_noise_hi_vel2vol");
		soundscripts\_audio_vehicle_manager::avm_end_param_map();
		soundscripts\_audio_vehicle_manager::avm_begin_param_map("distance");
		soundscripts\_audio_vehicle_manager::avm_add_param_map_env("volume","pdrone_security_noise_hi_dist2vol");
		soundscripts\_audio_vehicle_manager::avm_end_param_map();
		soundscripts\_audio_vehicle_manager::avm_begin_param_map("doppler_exaggerated",0.65,0.3);
		soundscripts\_audio_vehicle_manager::avm_add_param_map_env("pitch","pdrone_security_doppler2pch");
		soundscripts\_audio_vehicle_manager::avm_end_param_map();
		soundscripts\_audio_vehicle_manager::avm_end_loop_def();
		soundscripts\_audio_vehicle_manager::avm_begin_loop_def("pdrone_security_pink_lopass_lp");
		soundscripts\_audio_vehicle_manager::avm_begin_param_map("speed");
		soundscripts\_audio_vehicle_manager::avm_add_param_map_env("volume","pdrone_security_noise_lo_vel2vol");
		soundscripts\_audio_vehicle_manager::avm_end_param_map();
		soundscripts\_audio_vehicle_manager::avm_begin_param_map("distance");
		soundscripts\_audio_vehicle_manager::avm_add_param_map_env("volume","pdrone_security_noise_lo_dist2vol");
		soundscripts\_audio_vehicle_manager::avm_end_param_map();
		soundscripts\_audio_vehicle_manager::avm_begin_param_map("doppler_exaggerated",0.65,0.3);
		soundscripts\_audio_vehicle_manager::avm_add_param_map_env("pitch","pdrone_security_doppler2pch");
		soundscripts\_audio_vehicle_manager::avm_end_param_map();
		soundscripts\_audio_vehicle_manager::avm_end_loop_def();
	}

	soundscripts\_audio_vehicle_manager::avm_end_loop_data();
	soundscripts\_audio_vehicle_manager::avm_begin_oneshot_data();
	soundscripts\_audio_vehicle_manager::avm_begin_oneshot_def("pdrone_security_flyby","pdrone_security_flyby_duck_envelope",0.25,1,["sdrone_by_1","sdrone_by_2"]);
	soundscripts\_audio_vehicle_manager::avm_begin_param_map("speed",1,1);
	soundscripts\_audio_vehicle_manager::avm_add_param_map_env("pitch","pdrone_security_flyby_vel2pch");
	soundscripts\_audio_vehicle_manager::avm_add_param_map_env("volume","pdrone_security_flyby_vel2vol");
	soundscripts\_audio_vehicle_manager::avm_end_param_map();
	soundscripts\_audio_vehicle_manager::avm_begin_param_map("doppler_exaggerated",1,1);
	soundscripts\_audio_vehicle_manager::avm_add_param_map_env("pitch","pdrone_security_doppler2pch");
	soundscripts\_audio_vehicle_manager::avm_end_param_map();
	soundscripts\_audio_vehicle_manager::avm_end_oneshot_def();
	soundscripts\_audio_vehicle_manager::avm_begin_oneshot_def("foo_oneshot","pdrone_security_flyby_duck_envelope",0.25,1,["sdrone_by_1","sdrone_by_2"]);
	soundscripts\_audio_vehicle_manager::avm_begin_param_map("speed",1,1);
	soundscripts\_audio_vehicle_manager::avm_add_param_map_env("pitch","pdrone_security_flyby_vel2pch");
	soundscripts\_audio_vehicle_manager::avm_add_param_map_env("volume","pdrone_security_flyby_vel2vol");
	soundscripts\_audio_vehicle_manager::avm_end_param_map();
	soundscripts\_audio_vehicle_manager::avm_begin_param_map("doppler_exaggerated",1,1);
	soundscripts\_audio_vehicle_manager::avm_add_param_map_env("pitch","pdrone_security_doppler2pch");
	soundscripts\_audio_vehicle_manager::avm_end_param_map();
	soundscripts\_audio_vehicle_manager::avm_end_oneshot_def();
	soundscripts\_audio_vehicle_manager::avm_end_oneshot_data();
	soundscripts\_audio_vehicle_manager::avm_begin_behavior_data();
	soundscripts\_audio_vehicle_manager::avm_begin_behavior_def("to_state_hover",::pdrone_security_condition_callback_to_state_hover,["speed","distance2d"]);
	soundscripts\_audio_vehicle_manager::avm_add_loops("ALL");
	soundscripts\_audio_vehicle_manager::avm_end_behavior_def();
	soundscripts\_audio_vehicle_manager::avm_begin_behavior_def("to_state_flying",::pdrone_security_condition_callback_to_state_flying,["speed","distance2d"]);
	soundscripts\_audio_vehicle_manager::avm_add_loops("ALL");
	soundscripts\_audio_vehicle_manager::avm_add_oneshots("foo_oneshot");
	soundscripts\_audio_vehicle_manager::avm_end_behavior_def();
	soundscripts\_audio_vehicle_manager::avm_begin_behavior_def("to_state_distant",::pdrone_security_condition_callback_to_state_distant,["distance2d"]);
	soundscripts\_audio_vehicle_manager::avm_add_loops("sdrone_thrusters_main_lp");
	soundscripts\_audio_vehicle_manager::avm_end_behavior_def();
	soundscripts\_audio_vehicle_manager::avm_begin_behavior_def("to_state_flyby",::pdrone_security_condition_callback_to_state_flyby,["distance2d"]);
	soundscripts\_audio_vehicle_manager::avm_add_loops("ALL");
	if(!0)
	{
		soundscripts\_audio_vehicle_manager::avm_add_oneshots("pdrone_security_flyby");
	}

	soundscripts\_audio_vehicle_manager::avm_end_behavior_def();
	soundscripts\_audio_vehicle_manager::avm_begin_behavior_def("to_state_deathspin",::pdrone_security_condition_callback_to_state_deathspin);
	soundscripts\_audio_vehicle_manager::avm_add_loops("NONE");
	soundscripts\_audio_vehicle_manager::avm_end_behavior_def();
	soundscripts\_audio_vehicle_manager::avm_begin_behavior_def("to_state_destruct",::pdrone_security_condition_callback_to_state_destruct);
	soundscripts\_audio_vehicle_manager::avm_add_loops("NONE");
	soundscripts\_audio_vehicle_manager::avm_end_behavior_def();
	soundscripts\_audio_vehicle_manager::avm_begin_behavior_def("to_state_off",::pdrone_security_condition_callback_to_state_off);
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
	soundscripts\_audio_vehicle_manager::avm_add_envelope("pdrone_security_foo_env_function",::foo_env_function);
	soundscripts\_audio_vehicle_manager::avm_add_envelope("pdrone_security_loopset_vol_env",[[var_04 * 0,0.65 * var_00],[var_04 * 0.0204,0.66155 * var_00],[var_04 * 0.0816,0.670545 * var_00],[var_04 * 0.1836,0.688885 * var_00],[var_04 * 0.3265,0.7274899 * var_00],[var_04 * 0.5102,0.80554 * var_00],[var_04 * 0.7346,0.926535 * var_00],[var_04 * 1,1 * var_00]]);
	soundscripts\_audio_vehicle_manager::avm_add_envelope("sdrone_thrusters_lw",[[var_04 * 0,1],[var_04 * 0.333,1],[var_04 * 0.666,0],[var_04 * 1,0]]);
	soundscripts\_audio_vehicle_manager::avm_add_envelope("sdrone_thrusters_md",[[var_04 * 0,0],[var_04 * 0.333,1],[var_04 * 0.666,1],[var_04 * 1,0]]);
	soundscripts\_audio_vehicle_manager::avm_add_envelope("sdrone_thrusters_hi",[[var_04 * 0,0],[var_04 * 0.333,0],[var_04 * 0.666,1],[var_04 * 1,1]]);
	soundscripts\_audio_vehicle_manager::avm_add_envelope("pdrone_security_rotor_vel2vol",[[var_02,var_06],[var_04,var_07]]);
	soundscripts\_audio_vehicle_manager::avm_add_envelope("pdrone_security_rotor_vel2pch",[[var_02,var_08],[var_03,var_09],[var_04,var_0A]]);
	soundscripts\_audio_vehicle_manager::avm_add_envelope("pdrone_security_whine_vel2vol",[[var_02,var_0B],[var_02 + var_04 - var_02 * 0.666,var_0B + var_0C - var_0B * 0],[var_04,var_0C]]);
	soundscripts\_audio_vehicle_manager::avm_add_envelope("pdrone_security_whine_vel2pch",[[var_02,var_0D],[var_04,var_0E]]);
	soundscripts\_audio_vehicle_manager::avm_add_envelope("pdrone_security_noise_lo_vel2vol",[[var_02,var_0F],[var_02 + var_04 - var_02 * 0.66,var_0B],[var_04,var_10]]);
	soundscripts\_audio_vehicle_manager::avm_add_envelope("pdrone_security_noise_hi_vel2vol",[[var_02,var_0F],[var_02 + var_04 - var_02 * 0.66,var_0B],[var_04,var_11]]);
	soundscripts\_audio_vehicle_manager::avm_add_envelope("pdrone_security_noise_vel2pch",[[var_02,var_12],[var_04,var_12]]);
	soundscripts\_audio_vehicle_manager::avm_add_envelope("pdrone_security_noise_hi_dist2vol",[[soundscripts\_audio_vehicle_manager::yards2dist(0),var_11],[soundscripts\_audio_vehicle_manager::yards2dist(4),var_11 * 0.25],[soundscripts\_audio_vehicle_manager::yards2dist(6),var_11 * 0.4],[soundscripts\_audio_vehicle_manager::yards2dist(8),var_0F]]);
	soundscripts\_audio_vehicle_manager::avm_add_envelope("pdrone_security_noise_lo_dist2vol",[[soundscripts\_audio_vehicle_manager::yards2dist(3),var_10],[soundscripts\_audio_vehicle_manager::yards2dist(12),var_0F]]);
	soundscripts\_audio_vehicle_manager::avm_add_envelope("pdrone_security_flyby_vel2vol",[[var_02,var_14],[var_04,var_15]]);
	soundscripts\_audio_vehicle_manager::avm_add_envelope("pdrone_security_flyby_vel2pch",[[var_02,var_16],[var_04,var_17]]);
	soundscripts\_audio_vehicle_manager::avm_add_envelope("pdrone_security_flyby_duck_envelope",[[0,1],[0.33,0.33],[0.66,0.33],[1.33,1]]);
	soundscripts\_audio_vehicle_manager::avm_add_envelope("pdrone_security_doppler2pch",[[0,0],[2,2]]);
	soundscripts\_audio_vehicle_manager::avm_end_preset_def();
}

//Function Number: 2
foo_env_function()
{
	return 1;
}

//Function Number: 3
pdrone_security_condition_callback_to_state_off()
{
	return 0;
}

//Function Number: 4
pdrone_security_condition_callback_to_state_hover(param_00,param_01)
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

//Function Number: 5
pdrone_security_condition_callback_to_state_flying(param_00,param_01)
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

//Function Number: 6
pdrone_security_condition_callback_to_state_distant(param_00,param_01)
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

//Function Number: 7
pdrone_security_condition_callback_to_state_flyby(param_00,param_01)
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
				var_02 = ["pdrone_security_flyby"];
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

//Function Number: 8
pdrone_security_condition_callback_to_state_flyover(param_00,param_01)
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

//Function Number: 9
pdrone_security_condition_callback_to_state_deathspin(param_00,param_01)
{
	return 0;
}

//Function Number: 10
pdrone_security_condition_callback_to_state_destruct(param_00,param_01)
{
	return 0;
}

//Function Number: 11
pdrone_security_speed_modifier_callback_smoother(param_00,param_01)
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

//Function Number: 12
pdrone_security_speed_modifier_callback_perlin_noise(param_00,param_01)
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

//Function Number: 13
pdrone_security_speed_modifier_callback_linear(param_00,param_01)
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