/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: _diveboat_aud.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 7
 * Decompile Time: 115 ms
 * Timestamp: 4/22/2024 2:04:48 AM
*******************************************************************/

//Function Number: 1
diveboat_constructor()
{
	var_00 = 0;
	var_01 = 60;
	var_02 = -2;
	var_03 = 2;
	var_04 = 0;
	var_05 = 1;
	var_06 = 0;
	var_07 = 1;
	soundscripts\_audio_vehicle_manager::avm_begin_preset_def("diveboat");
	soundscripts\_audio_vehicle_manager::avm_add_envelope("dvbt_water_idle_spd2vol",[[0,0.65],[100.7957,0.2],[450,0]]);
	soundscripts\_audio_vehicle_manager::avm_add_envelope("dvbt_engine_idle_spd2pch",[[0,0.625],[100.7957,0.625],[450,0.625]]);
	soundscripts\_audio_vehicle_manager::avm_add_envelope("dvbt_engine_idle_spd2vol",[[0,0.8],[50.2613,0.5],[100,0.25]]);
	soundscripts\_audio_vehicle_manager::avm_add_envelope("dvbt_engine_high_throt2vol",[[0,0.1],[40.2755,0.2],[170.1021,0.4346],[290.5012,0.5864],[450,0.6283]]);
	soundscripts\_audio_vehicle_manager::avm_add_envelope("dvbt_engine_high_throt2pch",[[0,0.5],[25.6033,0.6126],[45.4204,0.7932],[100.62,0.8252],[170.6366,0.9764],[310.2114,1.2937],[450,1.5]]);
	soundscripts\_audio_vehicle_manager::avm_add_envelope("dvbt_engine_low_throt2vol",[[0,0.5],[25.5,0.75],[50.0689,0.85],[100.6722,0.95],[125.4513,1],[150.6508,1],[250.0119,1],[330.8836,0.9891],[450,0.9562]]);
	soundscripts\_audio_vehicle_manager::avm_add_envelope("dvbt_engine_low_throt2pch",[[0,0.625],[10.6033,0.7126],[30.4204,0.852],[90.62,0.9252],[170.6366,1],[250.6366,1.25],[310.2114,1.3],[450,1.5]]);
	soundscripts\_audio_vehicle_manager::avm_add_envelope("dvbt_engine_high_jump_throt2vol",[[0,0],[30.5725,0],[36.9477,0],[43.0333,0],[53.4656,0.3508],[57.8124,0.5707],[61,0.8534]]);
	soundscripts\_audio_vehicle_manager::avm_add_envelope("dvbt_engine_high_jump_throt2pch",[[0,0.0314],[61,1]]);
	soundscripts\_audio_vehicle_manager::avm_add_envelope("dvbt_engine_low_jump_throt2vol",[[0,0.5],[25.5,0.85],[50.0689,0.95],[100.6722,0.97],[125.4513,0.987],[450,1]]);
	soundscripts\_audio_vehicle_manager::avm_add_envelope("dvbt_engine_low_jump_throt2pch",[[0,0.525],[10.6033,0.6126],[30.4204,0.652],[50.62,1.375],[170.6366,1.4],[250.6366,1.5],[310.2114,1.6],[450,2]]);
	soundscripts\_audio_vehicle_manager::avm_add_envelope("dvbt_engine_low_ending_throt2vol",[[0,0],[50.0689,0],[100.6722,0.25],[125.4513,0.3],[150.6508,0.5],[250.0119,0.6],[330.8836,0.9891],[450,0.9562]]);
	soundscripts\_audio_vehicle_manager::avm_add_envelope("dvbt_engine_low_ending_throt2pch",[[0,0.625],[10.6033,0.625],[30.4204,0.625],[90.62,0.625],[170.6366,1],[250.6366,1.25],[310.2114,1.3],[450,1.5]]);
	soundscripts\_audio_vehicle_manager::avm_add_envelope("dvbt_drag_fast_drag2vol",[[0,0],[16.5677,0.002],[18.5677,0.25],[24.3705,1],[45,1]]);
	soundscripts\_audio_vehicle_manager::avm_add_envelope("dvbt_drag_med_drag2vol",[[0,0],[10,0.6],[50.5344,0.7],[100.772,0.8569],[150.0713,1],[240.7981,0.8],[320.2803,0.75],[450,0.5141]]);
	soundscripts\_audio_vehicle_manager::avm_add_envelope("dvbt_drag_med_drag2pch",[[0,0.7],[50,0.8],[130.2542,0.9],[450,1]]);
	soundscripts\_audio_vehicle_manager::avm_begin_loop_data(3);
	soundscripts\_audio_vehicle_manager::avm_begin_loop_def("dive_boat_engine_idle");
	soundscripts\_audio_vehicle_manager::avm_begin_param_map("speed_mph",0.08,0.06);
	soundscripts\_audio_vehicle_manager::avm_add_param_map_env("volume","dvbt_engine_idle_spd2vol");
	soundscripts\_audio_vehicle_manager::avm_add_param_map_env("volume","dvbt_engine_idle_spd2pch");
	soundscripts\_audio_vehicle_manager::avm_end_param_map();
	soundscripts\_audio_vehicle_manager::avm_end_loop_def();
	soundscripts\_audio_vehicle_manager::avm_begin_loop_def("dive_boat_water_idle");
	soundscripts\_audio_vehicle_manager::avm_begin_param_map("speed_mph",0.3,0.3);
	soundscripts\_audio_vehicle_manager::avm_add_param_map_env("volume","dvbt_water_idle_spd2vol");
	soundscripts\_audio_vehicle_manager::avm_end_param_map();
	soundscripts\_audio_vehicle_manager::avm_end_loop_def();
	soundscripts\_audio_vehicle_manager::avm_begin_loop_def("dive_boat_engine_drive_high");
	soundscripts\_audio_vehicle_manager::avm_begin_param_map("diveboat_throttle",0.2,0.06);
	soundscripts\_audio_vehicle_manager::avm_add_param_map_env("volume","dvbt_engine_high_throt2vol");
	soundscripts\_audio_vehicle_manager::avm_add_param_map_env("pitch","dvbt_engine_high_throt2pch");
	soundscripts\_audio_vehicle_manager::avm_end_param_map();
	soundscripts\_audio_vehicle_manager::avm_end_loop_def();
	soundscripts\_audio_vehicle_manager::avm_begin_loop_def("dive_boat_engine_drive_low");
	soundscripts\_audio_vehicle_manager::avm_begin_param_map("diveboat_throttle",0.08,0.2);
	soundscripts\_audio_vehicle_manager::avm_add_param_map_env("volume","dvbt_engine_low_throt2vol");
	soundscripts\_audio_vehicle_manager::avm_add_param_map_env("pitch","dvbt_engine_low_throt2pch");
	soundscripts\_audio_vehicle_manager::avm_end_param_map();
	soundscripts\_audio_vehicle_manager::avm_end_loop_def();
	soundscripts\_audio_vehicle_manager::avm_begin_loop_def("dive_boat_engine_drive_high_jump");
	soundscripts\_audio_vehicle_manager::avm_begin_param_map("diveboat_throttle",0.1,0.3);
	soundscripts\_audio_vehicle_manager::avm_add_param_map_env("volume","dvbt_engine_high_jump_throt2vol");
	soundscripts\_audio_vehicle_manager::avm_add_param_map_env("pitch","dvbt_engine_high_jump_throt2pch");
	soundscripts\_audio_vehicle_manager::avm_end_param_map();
	soundscripts\_audio_vehicle_manager::avm_end_loop_def();
	soundscripts\_audio_vehicle_manager::avm_begin_loop_def("dive_boat_engine_drive_low_jump",0.1);
	soundscripts\_audio_vehicle_manager::avm_begin_param_map("diveboat_throttle",0.9,0.95);
	soundscripts\_audio_vehicle_manager::avm_add_param_map_env("volume","dvbt_engine_low_jump_throt2vol");
	soundscripts\_audio_vehicle_manager::avm_add_param_map_env("pitch","dvbt_engine_low_jump_throt2pch");
	soundscripts\_audio_vehicle_manager::avm_end_param_map();
	soundscripts\_audio_vehicle_manager::avm_end_loop_def();
	soundscripts\_audio_vehicle_manager::avm_begin_loop_def("dive_boat_drive_water_fast");
	soundscripts\_audio_vehicle_manager::avm_begin_param_map("diveboat_drag_with_mph",0.5,0.2);
	soundscripts\_audio_vehicle_manager::avm_add_param_map_env("volume","dvbt_drag_fast_drag2vol");
	soundscripts\_audio_vehicle_manager::avm_end_param_map();
	soundscripts\_audio_vehicle_manager::avm_end_loop_def();
	soundscripts\_audio_vehicle_manager::avm_begin_loop_def("dive_boat_drive_water_med");
	soundscripts\_audio_vehicle_manager::avm_begin_param_map("diveboat_drag_with_mph",0.3,0.4);
	soundscripts\_audio_vehicle_manager::avm_add_param_map_env("volume","dvbt_drag_med_drag2vol");
	soundscripts\_audio_vehicle_manager::avm_add_param_map_env("pitch","dvbt_drag_med_drag2pch");
	soundscripts\_audio_vehicle_manager::avm_end_param_map();
	soundscripts\_audio_vehicle_manager::avm_end_loop_def();
	soundscripts\_audio_vehicle_manager::avm_begin_loop_def("dive_boat_engine_drive_low_ending");
	soundscripts\_audio_vehicle_manager::avm_begin_param_map("diveboat_throttle",0.9,0.05);
	soundscripts\_audio_vehicle_manager::avm_add_param_map_env("volume","dvbt_engine_low_ending_throt2vol");
	soundscripts\_audio_vehicle_manager::avm_add_param_map_env("pitch","dvbt_engine_low_ending_throt2pch");
	soundscripts\_audio_vehicle_manager::avm_end_param_map();
	soundscripts\_audio_vehicle_manager::avm_end_loop_def();
	soundscripts\_audio_vehicle_manager::avm_end_loop_data();
	soundscripts\_audio_vehicle_manager::avm_begin_oneshot_data();
	soundscripts\_audio_vehicle_manager::avm_begin_oneshot_def("dive_boat_accel_one_shot",undefined,undefined,2);
	soundscripts\_audio_vehicle_manager::avm_end_oneshot_def();
	soundscripts\_audio_vehicle_manager::avm_begin_oneshot_def("dive_boat_drag_one_shot",undefined,undefined,2);
	soundscripts\_audio_vehicle_manager::avm_end_oneshot_def();
	soundscripts\_audio_vehicle_manager::avm_end_oneshot_data();
	soundscripts\_audio_vehicle_manager::avm_begin_behavior_data();
	soundscripts\_audio_vehicle_manager::avm_begin_behavior_def("to_state_idle",::diveboat_condition_callback_to_state_idle,["diveboat_throttle","speed_mph"]);
	soundscripts\_audio_vehicle_manager::avm_add_loops(["dive_boat_engine_idle","dive_boat_water_idle","dive_boat_engine_drive_low"]);
	soundscripts\_audio_vehicle_manager::avm_end_behavior_def();
	soundscripts\_audio_vehicle_manager::avm_begin_behavior_def("to_state_throttling",::diveboat_condition_callback_to_state_throttling,["diveboat_throttle","speed_mph"]);
	soundscripts\_audio_vehicle_manager::avm_add_loops(["dive_boat_engine_idle","dive_boat_engine_drive_high","dive_boat_engine_drive_low","dive_boat_drive_water_fast","dive_boat_drive_water_med"]);
	soundscripts\_audio_vehicle_manager::avm_add_oneshots("dive_boat_accel_one_shot");
	soundscripts\_audio_vehicle_manager::avm_end_behavior_def();
	soundscripts\_audio_vehicle_manager::avm_begin_behavior_def("to_state_dragging",::diveboat_condition_callback_to_state_dragging,["diveboat_throttle","speed_mph"]);
	soundscripts\_audio_vehicle_manager::avm_add_loops(["dive_boat_engine_idle","dive_boat_engine_drive_high","dive_boat_engine_drive_low"]);
	soundscripts\_audio_vehicle_manager::avm_add_oneshots("dive_boat_drag_one_shot");
	soundscripts\_audio_vehicle_manager::avm_end_behavior_def();
	soundscripts\_audio_vehicle_manager::avm_begin_behavior_def("to_state_jumping",::diveboat_condition_callback_to_state_jumping,["diveboat_throttle","speed_mph"]);
	soundscripts\_audio_vehicle_manager::avm_add_loops(["dive_boat_engine_idle","dive_boat_engine_drive_low_jump"]);
	soundscripts\_audio_vehicle_manager::avm_end_behavior_def();
	soundscripts\_audio_vehicle_manager::avm_begin_behavior_def("to_state_ending",::diveboat_condition_callback_to_state_ending,["diveboat_throttle","speed_mph"]);
	soundscripts\_audio_vehicle_manager::avm_add_loops(["dive_boat_engine_idle","dive_boat_engine_drive_low_ending"]);
	soundscripts\_audio_vehicle_manager::avm_end_behavior_def();
	soundscripts\_audio_vehicle_manager::avm_end_behavior_data();
	soundscripts\_audio_vehicle_manager::avm_begin_state_data(0.25,50);
	soundscripts\_audio_vehicle_manager::avm_begin_state_group("test_state_group","state_idle","to_state_idle",50,1);
	soundscripts\_audio_vehicle_manager::avm_begin_state_def("state_idle");
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("state_throttling","to_state_throttling");
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("state_ending","to_state_ending");
	soundscripts\_audio_vehicle_manager::avm_end_state_def();
	soundscripts\_audio_vehicle_manager::avm_begin_state_def("state_throttling");
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("state_idle","to_state_idle");
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("state_jumping","to_state_jumping");
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("state_drag","to_state_dragging");
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("state_ending","to_state_ending");
	soundscripts\_audio_vehicle_manager::avm_end_state_def();
	soundscripts\_audio_vehicle_manager::avm_begin_state_def("state_drag");
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("state_idle","to_state_idle");
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("state_jumping","to_state_jumping");
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("state_throttling","to_state_throttling");
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("state_ending","to_state_ending");
	soundscripts\_audio_vehicle_manager::avm_end_state_def();
	soundscripts\_audio_vehicle_manager::avm_begin_state_def("state_jumping");
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("state_throttling","to_state_throttling");
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("state_drag","to_state_dragging");
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("state_ending","to_state_ending");
	soundscripts\_audio_vehicle_manager::avm_end_state_def();
	soundscripts\_audio_vehicle_manager::avm_begin_state_def("state_ending");
	soundscripts\_audio_vehicle_manager::avm_end_state_def();
	soundscripts\_audio_vehicle_manager::avm_end_state_group();
	soundscripts\_audio_vehicle_manager::avm_end_state_data();
	soundscripts\_audio_vehicle_manager::avm_end_preset_def();
}

//Function Number: 2
diveboat_init(param_00)
{
}

//Function Number: 3
diveboat_condition_callback_to_state_idle(param_00,param_01)
{
	var_02 = 0;
	var_03 = param_00["diveboat_throttle"];
	var_04 = param_00["speed_mph"];
	var_05 = soundscripts\_audio_vehicle_manager::avmx_get_vehicle_entity();
	var_06 = var_05.origin[2];
	if(!isdefined(param_01.prev_throttle) || !isdefined(param_01.prev_speed) || !isdefined(param_01.prev_height))
	{
		var_02 = 1;
		param_01.prev_throttle = var_03;
		param_01.prev_speed = var_04;
		param_01.prev_height = var_06;
	}
	else if(var_03 <= 0.1 && var_04 <= 1 && param_01.prev_speed > 1)
	{
		var_02 = 1;
		param_01.prev_throttle = var_03;
		param_01.prev_speed = var_04;
		param_01.prev_height = var_06;
	}

	return var_02;
}

//Function Number: 4
diveboat_condition_callback_to_state_throttling(param_00,param_01)
{
	var_02 = 0;
	var_03 = param_00["diveboat_throttle"];
	var_04 = param_00["speed_mph"];
	var_05 = soundscripts\_audio_vehicle_manager::avmx_get_vehicle_entity();
	var_06 = var_05.origin[2];
	if(isdefined(param_01.prev_throttle) && param_01.prev_throttle <= 0.1 && var_03 > 0.1)
	{
		var_02 = 1;
	}
	else if(isdefined(param_01.prev_height) && param_01.prev_height > -560 && var_06 <= -560 && var_03 > 0.1)
	{
		var_02 = 1;
	}

	if(var_06 <= -560)
	{
		param_01.prev_throttle = var_03;
		param_01.prev_speed = var_04;
		param_01.prev_height = var_06;
	}

	return var_02;
}

//Function Number: 5
diveboat_condition_callback_to_state_dragging(param_00,param_01)
{
	var_02 = 0;
	var_03 = param_00["diveboat_throttle"];
	var_04 = param_00["speed_mph"];
	var_05 = soundscripts\_audio_vehicle_manager::avmx_get_vehicle_entity();
	var_06 = var_05.origin[2];
	if(isdefined(param_01.prev_throttle) && param_01.prev_throttle > 0.1 && var_03 <= 0.1 && var_04 > 1)
	{
		var_02 = 1;
	}
	else if(isdefined(param_01.prev_height) && param_01.prev_height > -560 && var_06 <= -560 && var_03 <= 0.1)
	{
		var_02 = 1;
	}

	param_01.prev_throttle = var_03;
	param_01.prev_speed = var_04;
	param_01.prev_height = var_06;
	return var_02;
}

//Function Number: 6
diveboat_condition_callback_to_state_jumping(param_00,param_01)
{
	var_02 = 0;
	var_03 = param_00["diveboat_throttle"];
	var_04 = param_00["speed_mph"];
	var_05 = soundscripts\_audio_vehicle_manager::avmx_get_vehicle_entity();
	var_06 = var_05.origin[2];
	if(isdefined(param_01.prev_height) && var_06 > -560 && param_01.prev_height <= -560)
	{
		var_02 = 1;
		param_01.prev_throttle = var_03;
		param_01.prev_speed = var_04;
		param_01.prev_height = var_06;
	}

	return var_02;
}

//Function Number: 7
diveboat_condition_callback_to_state_ending(param_00,param_01)
{
	var_02 = 0;
	if(isdefined(level.aud.diveboat_ending) && level.aud.diveboat_ending == 1)
	{
		var_02 = 1;
	}

	return var_02;
}