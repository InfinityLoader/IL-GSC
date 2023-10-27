/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: vehicle_scripts\_blackhawk_aud.gsc
 * Game: Call of Duty: Modern Warfare Remastered
 * Platform: PC
 * Function Count: 8
 * Decompile Time: 142 ms
 * Timestamp: 10/27/2023 2:46:16 AM
*******************************************************************/

//Function Number: 1
snd_init_blackhawk()
{
	soundscripts\_snd::snd_message("snd_register_vehicle","blackhawk",::snd_blackhawk_constructor);
}

//Function Number: 2
snd_start_blackhawk()
{
	if(isdefined(self.snd_instance))
	{
		wait(1);
		snd_stop_blackhawk(1);
	}

	var_00 = spawnstruct();
	var_00.preset_name = "blackhawk";
	soundscripts\_snd::snd_message("snd_start_vehicle",var_00);
}

//Function Number: 3
snd_stop_blackhawk(param_00)
{
	if(isdefined(self.snd_instance))
	{
		soundscripts\_snd::snd_message("snd_stop_vehicle",param_00);
		self notify("snd_stop_vehicle");
	}
}

//Function Number: 4
snd_blackhawk_constructor()
{
	soundscripts\_audio_vehicle_manager::avm_begin_preset_def("blackhawk");
	soundscripts\_audio_vehicle_manager::avm_begin_loop_data();
	soundscripts\_audio_vehicle_manager::avm_begin_loop_def("h1r_blackhawk_engine_far_lp");
	soundscripts\_audio_vehicle_manager::avm_begin_param_map("speed");
	soundscripts\_audio_vehicle_manager::avm_add_param_map_env("volume","blackhawk_engine_far_vel2vol");
	soundscripts\_audio_vehicle_manager::avm_add_param_map_env("pitch","blackhawk_engine_far_vel2pch");
	soundscripts\_audio_vehicle_manager::avm_end_param_map();
	soundscripts\_audio_vehicle_manager::avm_begin_param_map("doppler",0.65,0.3);
	soundscripts\_audio_vehicle_manager::avm_add_param_map_env("pitch","blackhawk_doppler2pch");
	soundscripts\_audio_vehicle_manager::avm_end_param_map();
	soundscripts\_audio_vehicle_manager::avm_end_loop_def();
	soundscripts\_audio_vehicle_manager::avm_begin_loop_def("h1r_blackhawk_engine_close_lp");
	soundscripts\_audio_vehicle_manager::avm_begin_param_map("speed");
	soundscripts\_audio_vehicle_manager::avm_add_param_map_env("volume","blackhawk_engine_close_vel2vol");
	soundscripts\_audio_vehicle_manager::avm_end_param_map();
	soundscripts\_audio_vehicle_manager::avm_begin_param_map("doppler",0.65,0.3);
	soundscripts\_audio_vehicle_manager::avm_add_param_map_env("pitch","blackhawk_doppler2pch");
	soundscripts\_audio_vehicle_manager::avm_end_param_map();
	soundscripts\_audio_vehicle_manager::avm_end_loop_def();
	soundscripts\_audio_vehicle_manager::avm_end_loop_data();
	soundscripts\_audio_vehicle_manager::avm_begin_oneshot_data(0.5);
	soundscripts\_audio_vehicle_manager::avm_begin_oneshot_def("h1r_blackhawk_start_rev","blackhawk_start_rev_duck");
	soundscripts\_audio_vehicle_manager::avm_begin_param_map("speed");
	soundscripts\_audio_vehicle_manager::avm_add_param_map_env("volume","blackhawk_start_rev_vel2vol");
	soundscripts\_audio_vehicle_manager::avm_end_param_map();
	soundscripts\_audio_vehicle_manager::avm_end_oneshot_def();
	soundscripts\_audio_vehicle_manager::avm_begin_oneshot_def("h1r_blackhawk_pass_by","blackhawk_pass_by_duck_envelope");
	soundscripts\_audio_vehicle_manager::avm_begin_param_map("speed");
	soundscripts\_audio_vehicle_manager::avm_add_param_map_env("pitch","blackhawk_pass_by_vel2pch");
	soundscripts\_audio_vehicle_manager::avm_add_param_map_env("volume","blackhawk_pass_by_vel2vol");
	soundscripts\_audio_vehicle_manager::avm_end_param_map();
	soundscripts\_audio_vehicle_manager::avm_end_oneshot_def();
	soundscripts\_audio_vehicle_manager::avm_end_oneshot_data();
	soundscripts\_audio_vehicle_manager::avm_begin_behavior_data();
	soundscripts\_audio_vehicle_manager::avm_begin_behavior_def("to_state_hover",::blackhawk_condition_callback_to_hover,["speed","distance2d"]);
	soundscripts\_audio_vehicle_manager::avm_add_loops("ALL");
	soundscripts\_audio_vehicle_manager::avm_end_behavior_def();
	soundscripts\_audio_vehicle_manager::avm_begin_behavior_def("to_state_fly",::blackhawk_condition_callback_to_fly,["speed","distance2d"]);
	soundscripts\_audio_vehicle_manager::avm_add_loops("ALL");
	soundscripts\_audio_vehicle_manager::avm_end_behavior_def();
	soundscripts\_audio_vehicle_manager::avm_begin_behavior_def("to_state_fly_from_hover",::blackhawk_condition_callback_to_fly,["speed","distance2d"]);
	soundscripts\_audio_vehicle_manager::avm_add_loops("ALL");
	soundscripts\_audio_vehicle_manager::avm_add_oneshots("h1r_blackhawk_start_rev");
	soundscripts\_audio_vehicle_manager::avm_end_behavior_def();
	soundscripts\_audio_vehicle_manager::avm_begin_behavior_def("to_state_distant",::blackhawk_condition_callback_to_distant,["distance2d"]);
	soundscripts\_audio_vehicle_manager::avm_add_loops("h1r_blackhawk_engine_far_lp");
	soundscripts\_audio_vehicle_manager::avm_end_behavior_def();
	soundscripts\_audio_vehicle_manager::avm_begin_behavior_def("to_state_flyby",::blackhawk_condition_callback_to_flyby,["speed","distance2d","doppler"]);
	soundscripts\_audio_vehicle_manager::avm_add_loops("ALL");
	soundscripts\_audio_vehicle_manager::avm_add_oneshots("h1r_blackhawk_pass_by");
	soundscripts\_audio_vehicle_manager::avm_end_behavior_def();
	soundscripts\_audio_vehicle_manager::avm_end_behavior_data();
	soundscripts\_audio_vehicle_manager::avm_begin_state_data(0.25,0.5);
	soundscripts\_audio_vehicle_manager::avm_begin_state_group("engine_oneshots","state_fly","to_state_fly",50,1);
	soundscripts\_audio_vehicle_manager::avm_begin_state_def("state_hover");
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("state_fly","to_state_fly_from_hover");
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("state_flyby","to_state_flyby");
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("state_distant","to_state_distant");
	soundscripts\_audio_vehicle_manager::avm_end_state_def();
	soundscripts\_audio_vehicle_manager::avm_begin_state_def("state_distant");
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("state_hover","to_state_hover");
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("state_fly","to_state_fly");
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("state_flyby","to_state_flyby");
	soundscripts\_audio_vehicle_manager::avm_end_state_def();
	soundscripts\_audio_vehicle_manager::avm_begin_state_def("state_fly");
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("state_hover","to_state_hover");
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("state_flyby","to_state_flyby");
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("state_distant","to_state_distant");
	soundscripts\_audio_vehicle_manager::avm_end_state_def();
	soundscripts\_audio_vehicle_manager::avm_begin_state_def("state_flyby",7);
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("state_hover","to_state_hover");
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("state_fly","to_state_fly");
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("state_distant","to_state_distant");
	soundscripts\_audio_vehicle_manager::avm_end_state_def();
	soundscripts\_audio_vehicle_manager::avm_end_state_group();
	soundscripts\_audio_vehicle_manager::avm_end_state_data();
	soundscripts\_audio_vehicle_manager::avm_add_envelope("blackhawk_engine_far_vel2vol",[[0,1],[10,1],[150,1]]);
	soundscripts\_audio_vehicle_manager::avm_add_envelope("blackhawk_engine_close_vel2vol",[[0,1],[20,1],[150,1]]);
	soundscripts\_audio_vehicle_manager::avm_add_envelope("blackhawk_engine_far_vel2pch",[[0,0.9],[10,1],[20,1.1]]);
	soundscripts\_audio_vehicle_manager::avm_add_envelope("blackhawk_start_rev_duck",[[0,1],[0.25,1],[0.3,0.7],[0.7,1],[1,1]]);
	soundscripts\_audio_vehicle_manager::avm_add_envelope("blackhawk_start_rev_vel2vol",[[0,0],[3,0.3],[5,0.7],[8,0.8],[150,1]]);
	soundscripts\_audio_vehicle_manager::avm_add_envelope("blackhawk_pass_by_duck_envelope",[[0,1],[0.15,1],[0.3,0.5],[0.5,0.55],[0.6,1]]);
	soundscripts\_audio_vehicle_manager::avm_add_envelope("blackhawk_pass_by_vel2vol",[[0,0],[9.06,0],[15.1,0.7],[150,1]]);
	soundscripts\_audio_vehicle_manager::avm_add_envelope("blackhawk_pass_by_vel2pch",[[0,0.9],[15.1,1],[150,1.1]]);
	soundscripts\_audio_vehicle_manager::avm_add_envelope("blackhawk_doppler2pch",[[0,0],[2,2]]);
	soundscripts\_audio_vehicle_manager::avm_end_preset_def();
}

//Function Number: 5
blackhawk_condition_callback_to_hover(param_00,param_01)
{
	var_02 = param_00["speed"];
	var_03 = param_00["distance2d"];
	var_04 = soundscripts\_audio_vehicle_manager::dist2yards(var_03);
	if(var_02 < 1.1 && var_04 < 3000)
	{
		return 1;
	}

	return 0;
}

//Function Number: 6
blackhawk_condition_callback_to_fly(param_00,param_01)
{
	var_02 = param_00["speed"];
	var_03 = param_00["distance2d"];
	var_04 = soundscripts\_audio_vehicle_manager::dist2yards(var_03);
	if(var_02 >= 1.1 && var_04 < 3000)
	{
		return 1;
	}

	return 0;
}

//Function Number: 7
blackhawk_condition_callback_to_flyby(param_00,param_01)
{
	var_02 = 0;
	var_03 = param_00["distance2d"];
	var_04 = soundscripts\_audio_vehicle_manager::dist2yards(var_03);
	var_05 = param_00["speed"];
	var_06 = param_00["doppler"];
	if(!isdefined(param_01.flyby))
	{
		param_01.flyby = spawnstruct();
		param_01.flyby.prev_dist = var_03;
		param_01.flyby.prev_dx = 0;
	}
	else
	{
		var_07 = var_03 - param_01.flyby.prev_dist;
		if(var_07 < 0 && var_05 >= 15.1 && var_04 < 2100 && var_06 >= 1.02)
		{
			var_02 = 1;
		}

		param_01.flyby.prev_dist = var_03;
		param_01.flyby.prev_dx = var_07;
	}

	return var_02;
}

//Function Number: 8
blackhawk_condition_callback_to_distant(param_00,param_01)
{
	var_02 = param_00["distance2d"];
	var_03 = soundscripts\_audio_vehicle_manager::dist2yards(var_02);
	if(var_03 >= 3000)
	{
		return 1;
	}

	return 0;
}