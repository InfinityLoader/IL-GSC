/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: vehicle_scripts/_pdrone_player_aud.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 7
 * Decompile Time: 88 ms
 * Timestamp: 10/27/2023 2:06:30 AM
*******************************************************************/

//Function Number: 1
snd_pdrone_player_constructor()
{
	soundscripts\_audio_vehicle_manager::avm_begin_preset_def("pdrone_player",::pdrone_player_init);
	soundscripts\_audio_vehicle_manager::avm_add_envelope("pdrone_player_hover_spd2vol",[[0,1],[30,0.5]]);
	soundscripts\_audio_vehicle_manager::avm_add_envelope("pdrone_player_hover_spd2pch",[[0,1],[30,1.2]]);
	soundscripts\_audio_vehicle_manager::avm_add_envelope("pdrone_player_fly_spd2vol",[[7,0],[8,1],[30,1]]);
	soundscripts\_audio_vehicle_manager::avm_add_envelope("pdrone_player_fly_spd2pch",[[8,1],[30,1.1]]);
	soundscripts\_audio_vehicle_manager::avm_add_envelope("pdrone_player_look_spd2vol",[[0.09,0],[0.1,1],[1,1]]);
	soundscripts\_audio_vehicle_manager::avm_add_envelope("pdrone_player_look_hover_spd2vol",[[2,1],[8,0]]);
	soundscripts\_audio_vehicle_manager::avm_add_envelope("pdrone_player_no_duck_envelope",[[0,1],[1,1]]);
	soundscripts\_audio_vehicle_manager::avm_begin_loop_data(1,0.6,0.5);
	soundscripts\_audio_vehicle_manager::avm_begin_loop_def("veh_wasp_idle_lp");
	soundscripts\_audio_vehicle_manager::avm_begin_param_map("SPEED");
	soundscripts\_audio_vehicle_manager::avm_add_param_map_env("volume","pdrone_player_hover_spd2vol");
	soundscripts\_audio_vehicle_manager::avm_add_param_map_env("pitch","pdrone_player_hover_spd2pch");
	soundscripts\_audio_vehicle_manager::avm_end_param_map();
	soundscripts\_audio_vehicle_manager::avm_end_loop_def();
	soundscripts\_audio_vehicle_manager::avm_begin_loop_def("veh_wasp_drive_med_lp");
	soundscripts\_audio_vehicle_manager::avm_begin_param_map("SPEED");
	soundscripts\_audio_vehicle_manager::avm_add_param_map_env("volume","pdrone_player_fly_spd2vol");
	soundscripts\_audio_vehicle_manager::avm_add_param_map_env("pitch","pdrone_player_fly_spd2pch");
	soundscripts\_audio_vehicle_manager::avm_end_param_map();
	soundscripts\_audio_vehicle_manager::avm_end_loop_def();
	soundscripts\_audio_vehicle_manager::avm_begin_loop_def("veh_wasp_look_lp");
	soundscripts\_audio_vehicle_manager::avm_begin_param_map("player_pdrone_look");
	soundscripts\_audio_vehicle_manager::avm_add_param_map_env("volume","pdrone_player_look_spd2vol");
	soundscripts\_audio_vehicle_manager::avm_end_param_map();
	soundscripts\_audio_vehicle_manager::avm_begin_param_map("speed");
	soundscripts\_audio_vehicle_manager::avm_add_param_map_env("volume","pdrone_player_look_hover_spd2vol");
	soundscripts\_audio_vehicle_manager::avm_end_param_map();
	soundscripts\_audio_vehicle_manager::avm_end_loop_def();
	soundscripts\_audio_vehicle_manager::avm_end_loop_data();
	soundscripts\_audio_vehicle_manager::avm_begin_oneshot_data();
	soundscripts\_audio_vehicle_manager::avm_begin_oneshot_def("veh_wasp_drive_med_start","pdrone_player_no_duck_envelope",0.25,0);
	soundscripts\_audio_vehicle_manager::avm_end_oneshot_def();
	soundscripts\_audio_vehicle_manager::avm_begin_oneshot_def("veh_wasp_drive_med_stop","pdrone_player_no_duck_envelope",0.25,0);
	soundscripts\_audio_vehicle_manager::avm_end_oneshot_def();
	soundscripts\_audio_vehicle_manager::avm_begin_oneshot_def("veh_wasp_look_start","pdrone_player_no_duck_envelope",0.25,0);
	soundscripts\_audio_vehicle_manager::avm_end_oneshot_def();
	soundscripts\_audio_vehicle_manager::avm_begin_oneshot_def("veh_wasp_look_stop","pdrone_player_no_duck_envelope",0.25,0);
	soundscripts\_audio_vehicle_manager::avm_end_oneshot_def();
	soundscripts\_audio_vehicle_manager::avm_end_oneshot_data();
	soundscripts\_audio_vehicle_manager::avm_begin_behavior_data();
	soundscripts\_audio_vehicle_manager::avm_begin_behavior_def("to_state_hover",::pdrone_player_condition_callback_to_state_hover,["speed"]);
	soundscripts\_audio_vehicle_manager::avm_add_loops("all");
	soundscripts\_audio_vehicle_manager::avm_end_behavior_def();
	soundscripts\_audio_vehicle_manager::avm_begin_behavior_def("to_state_start_flying",::pdrone_player_condition_callback_to_state_flying,["speed"]);
	soundscripts\_audio_vehicle_manager::avm_add_oneshots("veh_wasp_drive_med_start");
	soundscripts\_audio_vehicle_manager::avm_end_behavior_def();
	soundscripts\_audio_vehicle_manager::avm_begin_behavior_def("to_state_flying",::pdrone_player_condition_callback_to_state_flying,["speed"]);
	soundscripts\_audio_vehicle_manager::avm_add_loops(["veh_wasp_idle_lp","veh_wasp_drive_med_lp"]);
	soundscripts\_audio_vehicle_manager::avm_end_behavior_def();
	soundscripts\_audio_vehicle_manager::avm_begin_behavior_def("to_state_stop_flying",::pdrone_player_condition_callback_to_state_hover,["speed"]);
	soundscripts\_audio_vehicle_manager::avm_add_oneshots("veh_wasp_drive_med_stop");
	soundscripts\_audio_vehicle_manager::avm_end_behavior_def();
	soundscripts\_audio_vehicle_manager::avm_begin_behavior_def("to_state_idle",::pdrone_player_condition_callback_to_state_idle,["player_pdrone_look","speed"]);
	soundscripts\_audio_vehicle_manager::avm_add_loops("all");
	soundscripts\_audio_vehicle_manager::avm_end_behavior_def();
	soundscripts\_audio_vehicle_manager::avm_begin_behavior_def("to_state_start_looking",::pdrone_player_condition_callback_to_state_looking,["player_pdrone_look","speed"]);
	soundscripts\_audio_vehicle_manager::avm_add_oneshots("veh_wasp_look_start");
	soundscripts\_audio_vehicle_manager::avm_end_behavior_def();
	soundscripts\_audio_vehicle_manager::avm_begin_behavior_def("to_state_looking",::pdrone_player_condition_callback_to_state_looking,["player_pdrone_look","speed"]);
	soundscripts\_audio_vehicle_manager::avm_end_behavior_def();
	soundscripts\_audio_vehicle_manager::avm_begin_behavior_def("to_state_stop_looking",::pdrone_player_condition_callback_to_state_idle,["player_pdrone_look","speed"]);
	soundscripts\_audio_vehicle_manager::avm_add_oneshots("veh_wasp_look_stop");
	soundscripts\_audio_vehicle_manager::avm_end_behavior_def();
	soundscripts\_audio_vehicle_manager::avm_end_behavior_data();
	soundscripts\_audio_vehicle_manager::avm_begin_state_data(0.25,50);
	soundscripts\_audio_vehicle_manager::avm_begin_state_group("movement","state_hover","to_state_hover",50,1);
	soundscripts\_audio_vehicle_manager::avm_begin_state_def("state_hover");
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("state_start_flying","to_state_start_flying");
	soundscripts\_audio_vehicle_manager::avm_end_state_def();
	soundscripts\_audio_vehicle_manager::avm_begin_state_def("state_start_flying");
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("state_flying","to_state_flying");
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("state_hover","to_state_hover");
	soundscripts\_audio_vehicle_manager::avm_end_state_def();
	soundscripts\_audio_vehicle_manager::avm_begin_state_def("state_flying");
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("state_stop_flying","to_state_stop_flying");
	soundscripts\_audio_vehicle_manager::avm_end_state_def();
	soundscripts\_audio_vehicle_manager::avm_begin_state_def("state_stop_flying");
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("state_hover","to_state_hover");
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("state_flying","to_state_flying");
	soundscripts\_audio_vehicle_manager::avm_end_state_def();
	soundscripts\_audio_vehicle_manager::avm_end_state_group();
	soundscripts\_audio_vehicle_manager::avm_begin_state_group("player_pdrone_look","state_idle","to_state_idle",50,1);
	soundscripts\_audio_vehicle_manager::avm_begin_state_def("state_idle");
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("state_start_looking","to_state_start_looking");
	soundscripts\_audio_vehicle_manager::avm_end_state_def();
	soundscripts\_audio_vehicle_manager::avm_begin_state_def("state_start_looking");
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("state_looking","to_state_looking");
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("state_idle","to_state_idle");
	soundscripts\_audio_vehicle_manager::avm_end_state_def();
	soundscripts\_audio_vehicle_manager::avm_begin_state_def("state_looking");
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("state_stop_looking","to_state_stop_looking");
	soundscripts\_audio_vehicle_manager::avm_end_state_def();
	soundscripts\_audio_vehicle_manager::avm_begin_state_def("state_stop_looking");
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("state_idle","to_state_idle");
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("state_looking","to_state_looking");
	soundscripts\_audio_vehicle_manager::avm_end_state_def();
	soundscripts\_audio_vehicle_manager::avm_end_state_group();
	soundscripts\_audio_vehicle_manager::avm_end_state_data();
	soundscripts\_audio_vehicle_manager::avm_end_preset_def();
}

//Function Number: 2
pdrone_player_init(param_00)
{
	var_01 = soundscripts\_audio_vehicle_manager::avmx_get_vehicle_entity();
}

//Function Number: 3
pdrone_player_callback_look()
{
	var_00 = level.player getnormalizedcameramovements();
	var_01 = abs(var_00[0]);
	var_02 = abs(var_00[1]);
	if(var_01 > var_02)
	{
		return var_01;
	}

	return var_02;
}

//Function Number: 4
pdrone_player_condition_callback_to_state_hover(param_00,param_01)
{
	var_02 = param_00["speed"];
	if(var_02 <= 8)
	{
		return 1;
	}

	return 0;
}

//Function Number: 5
pdrone_player_condition_callback_to_state_flying(param_00,param_01)
{
	var_02 = param_00["speed"];
	if(var_02 > 8)
	{
		return 1;
	}

	return 0;
}

//Function Number: 6
pdrone_player_condition_callback_to_state_idle(param_00,param_01)
{
	var_02 = param_00["player_pdrone_look"];
	var_03 = param_00["speed"];
	if(var_02 <= 0.1 || var_03 > 2)
	{
		return 1;
	}

	return 0;
}

//Function Number: 7
pdrone_player_condition_callback_to_state_looking(param_00,param_01)
{
	var_02 = param_00["player_pdrone_look"];
	var_03 = param_00["speed"];
	if(var_02 > 0.1 && var_03 <= 2)
	{
		return 1;
	}

	return 0;
}