/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: _x4walker_wheels_aud.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 31
 * Decompile Time: 486 ms
 * Timestamp: 4/22/2024 2:05:43 AM
*******************************************************************/

//Function Number: 1
snd_init_x4_walker_wheels()
{
	soundscripts\_audio_vehicle_manager::avm_register_callback("x4ww_zvelocity_front_left",::x4ww_input_callback_wheel_zvelocity_front_left);
	soundscripts\_audio_vehicle_manager::avm_register_callback("x4ww_zvelocity_front_right",::x4ww_input_callback_wheel_zvelocity_front_right);
	soundscripts\_audio_vehicle_manager::avm_register_callback("x4ww_zvelocity_rear_left",::x4ww_input_callback_wheel_zvelocity_rear_left);
	soundscripts\_audio_vehicle_manager::avm_register_callback("x4ww_zvelocity_rear_right",::x4ww_input_callback_wheel_zvelocity_rear_right);
	soundscripts\_audio_vehicle_manager::avm_register_callback("x4ww_gun_pitch_rate",::x4ww_input_callback_gun_pitch_rate);
	soundscripts\_audio_vehicle_manager::avm_register_callback("x4ww_gun_yaw_rate",::x4ww_input_callback_gun_yaw_rate);
	soundscripts\_audio_vehicle_manager::avm_register_callback("x4ww_player_driver",::x4ww_input_callback_player_driver);
	soundscripts\_audio_vehicle_manager::avm_register_callback("x4ww_gun_pitch_rate2",::x4ww_input_callback_gun_pitch_rate);
	soundscripts\_audio_vehicle_manager::avm_register_callback("x4ww_gun_yaw_rate2",::x4ww_input_callback_gun_yaw_rate);
	soundscripts\_snd::snd_message("snd_register_vehicle","x4walker_wheels",::snd_x4walker_wheels_constructor);
}

//Function Number: 2
snd_start_x4_walker_wheels(param_00)
{
	if(isdefined(self.snd_instance))
	{
		wait(1);
		var_01 = 1;
		soundscripts\_snd::snd_message("snd_stop_vehicle",var_01);
		soundscripts\_snd::snd_message("player_exit_walker");
	}

	var_02 = spawnstruct();
	var_02.preset_name = "x4walker_wheels";
	var_02.player_mode = param_00 == "plr";
	soundscripts\_snd::snd_message("snd_start_vehicle",var_02);
}

//Function Number: 3
snd_x4walker_wheels_constructor()
{
	soundscripts\_audio_vehicle_manager::avm_begin_preset_def("x4walker_wheels");
	soundscripts\_audio_vehicle_manager::avm_begin_loop_data(3,0.65,0.3);
	soundscripts\_audio_vehicle_manager::avm_begin_loop_def("x4ww_idle");
	soundscripts\_audio_vehicle_manager::avm_begin_param_map("speed");
	soundscripts\_audio_vehicle_manager::avm_add_param_map_env("volume","x4_idle_vel2vol","x4_idle_vel2vol");
	soundscripts\_audio_vehicle_manager::avm_end_param_map();
	soundscripts\_audio_vehicle_manager::avm_end_loop_def();
	soundscripts\_audio_vehicle_manager::avm_begin_loop_def("x4ww_move");
	soundscripts\_audio_vehicle_manager::avm_begin_param_map("speed");
	soundscripts\_audio_vehicle_manager::avm_add_param_map_env("volume","x4_move_vel2vol","x4_move_vel2vol");
	soundscripts\_audio_vehicle_manager::avm_add_param_map_env("pitch","x4_move_vel2pch","x4_move_vel2pch");
	soundscripts\_audio_vehicle_manager::avm_end_param_map();
	soundscripts\_audio_vehicle_manager::avm_begin_param_map("pitch");
	soundscripts\_audio_vehicle_manager::avm_add_param_map_env("pitch","x4_move_pit2pch","x4_move_pit2pch");
	soundscripts\_audio_vehicle_manager::avm_end_param_map();
	soundscripts\_audio_vehicle_manager::avm_end_loop_def();
	soundscripts\_audio_vehicle_manager::avm_begin_loop_def("x4ww_move2");
	soundscripts\_audio_vehicle_manager::avm_begin_param_map("speed");
	soundscripts\_audio_vehicle_manager::avm_add_param_map_env("volume","x4_move2_lp_vel2vol","x4_move2_lp_vel2vol");
	soundscripts\_audio_vehicle_manager::avm_add_param_map_env("pitch","x4_move2_lp_vel2pch","x4_move2_lp_vel2pch");
	soundscripts\_audio_vehicle_manager::avm_end_param_map();
	soundscripts\_audio_vehicle_manager::avm_begin_param_map("pitch");
	soundscripts\_audio_vehicle_manager::avm_add_param_map_env("pitch","x4_move_pit2pch","x4_move_pit2pch");
	soundscripts\_audio_vehicle_manager::avm_end_param_map();
	soundscripts\_audio_vehicle_manager::avm_end_loop_def();
	soundscripts\_audio_vehicle_manager::avm_end_loop_data();
	soundscripts\_audio_vehicle_manager::avm_begin_oneshot_data();
	soundscripts\_audio_vehicle_manager::avm_begin_oneshot_def("x4ww_startup","x4_startup_duck_envelope");
	soundscripts\_audio_vehicle_manager::avm_end_oneshot_def();
	soundscripts\_audio_vehicle_manager::avm_begin_oneshot_def("x4ww_shutoff","xwalk_shutoff_duck_envelope");
	soundscripts\_audio_vehicle_manager::avm_end_oneshot_def();
	soundscripts\_audio_vehicle_manager::avm_begin_oneshot_def("x4ww_accel_hard","xwalk_accel_duck_envelope");
	soundscripts\_audio_vehicle_manager::avm_begin_param_map("acceleration_g",0.65,0.3);
	soundscripts\_audio_vehicle_manager::avm_add_param_map_env("volume","x4_accel_1shot_accel2vol","x4_accel_1shot_accel2vol");
	soundscripts\_audio_vehicle_manager::avm_end_param_map();
	soundscripts\_audio_vehicle_manager::avm_end_oneshot_def();
	soundscripts\_audio_vehicle_manager::avm_begin_oneshot_def("x4ww_decel_1","xwalk_stop_duck_envelope",0.5,1,["x4ww_decel"]);
	soundscripts\_audio_vehicle_manager::avm_begin_param_map("speed",0.65,0.3);
	soundscripts\_audio_vehicle_manager::avm_add_param_map_env("volume","x4_break_squeal_vel2vol","x4_break_squeal_vel2vol");
	soundscripts\_audio_vehicle_manager::avm_end_param_map();
	soundscripts\_audio_vehicle_manager::avm_end_oneshot_def();
	soundscripts\_audio_vehicle_manager::avm_begin_oneshot_def("x4ww_decel_2","xwalk_stop_duck_envelope",0.5,1,["x4ww_decel","x4ww_stop_squeal"]);
	soundscripts\_audio_vehicle_manager::avm_begin_param_map("speed",0.65,0.3);
	soundscripts\_audio_vehicle_manager::avm_add_param_map_env("volume","x4_break_squeal_vel2vol","x4_break_squeal_vel2vol");
	soundscripts\_audio_vehicle_manager::avm_end_param_map();
	soundscripts\_audio_vehicle_manager::avm_end_oneshot_def();
	soundscripts\_audio_vehicle_manager::avm_begin_oneshot_def("x4ww_stop_chuff","xwalk_stop_duck_envelope");
	soundscripts\_audio_vehicle_manager::avm_begin_param_map("speed",1,1);
	soundscripts\_audio_vehicle_manager::avm_add_param_map_env("volume","x4_chuff_vel2vol","x4_chuff_vel2vol");
	soundscripts\_audio_vehicle_manager::avm_end_param_map();
	soundscripts\_audio_vehicle_manager::avm_end_oneshot_def();
	soundscripts\_audio_vehicle_manager::avm_begin_oneshot_def("x4ww_suspen_bump_hard","xwalk_stop_duck_envelope");
	soundscripts\_audio_vehicle_manager::avm_begin_param_map("speed");
	soundscripts\_audio_vehicle_manager::avm_add_param_map_env("volume","x4_chuff_vel2vol","x4_chuff_vel2vol");
	soundscripts\_audio_vehicle_manager::avm_end_param_map();
	soundscripts\_audio_vehicle_manager::avm_end_oneshot_def();
	soundscripts\_audio_vehicle_manager::avm_begin_oneshot_def("x4ww_rotate_stop","xwalk_stop_duck_envelope");
	soundscripts\_audio_vehicle_manager::avm_end_oneshot_def();
	soundscripts\_audio_vehicle_manager::avm_end_oneshot_data();
	soundscripts\_audio_vehicle_manager::avm_begin_behavior_data();
	soundscripts\_audio_vehicle_manager::avm_begin_behavior_def("to_state_off",::x4ww_condition_callback_to_state_off);
	soundscripts\_audio_vehicle_manager::avm_end_behavior_def();
	soundscripts\_audio_vehicle_manager::avm_begin_behavior_def("to_state_startup",::x4ww_condition_callback_to_state_startup);
	soundscripts\_audio_vehicle_manager::avm_add_loops("ALL");
	soundscripts\_audio_vehicle_manager::avm_add_oneshots("x4ww_startup");
	soundscripts\_audio_vehicle_manager::avm_end_behavior_def();
	soundscripts\_audio_vehicle_manager::avm_begin_behavior_def("to_state_shutoff",::x4ww_condition_callback_to_state_shutoff,["x4ww_player_driver"]);
	soundscripts\_audio_vehicle_manager::avm_add_oneshots("x4ww_shutoff");
	soundscripts\_audio_vehicle_manager::avm_end_behavior_def();
	soundscripts\_audio_vehicle_manager::avm_begin_behavior_def("to_state_enter_vehicle",::x4ww_condition_callback_to_state_enter_vehicle,["x4ww_player_driver"]);
	soundscripts\_audio_vehicle_manager::avm_end_behavior_def();
	soundscripts\_audio_vehicle_manager::avm_begin_behavior_def("to_state_idle",::x4ww_condition_callback_to_state_idle,["speed"]);
	soundscripts\_audio_vehicle_manager::avm_end_behavior_def();
	soundscripts\_audio_vehicle_manager::avm_begin_behavior_def("to_state_start_move",::x4ww_condition_callback_to_state_start_move);
	soundscripts\_audio_vehicle_manager::avm_add_oneshots("x4ww_accel_hard");
	soundscripts\_audio_vehicle_manager::avm_begin_param_map("speed",0.65,0.3);
	soundscripts\_audio_vehicle_manager::avm_end_param_map();
	soundscripts\_audio_vehicle_manager::avm_end_behavior_def();
	soundscripts\_audio_vehicle_manager::avm_begin_behavior_def("to_state_moving",::x4ww_condition_callback_to_state_moving,["speed"]);
	soundscripts\_audio_vehicle_manager::avm_end_behavior_def();
	soundscripts\_audio_vehicle_manager::avm_begin_behavior_def("to_state_breaking",::x4ww_condition_callback_to_state_breaking);
	soundscripts\_audio_vehicle_manager::avm_begin_param_map("speed",0.65,0.3);
	soundscripts\_audio_vehicle_manager::avm_end_param_map();
	soundscripts\_audio_vehicle_manager::avm_begin_param_map("pitch",0.65,0.3);
	soundscripts\_audio_vehicle_manager::avm_end_param_map();
	soundscripts\_audio_vehicle_manager::avm_end_behavior_def();
	soundscripts\_audio_vehicle_manager::avm_begin_behavior_def("to_state_stop",::x4ww_condition_callback_to_state_stopped,["speed"]);
	soundscripts\_audio_vehicle_manager::avm_add_oneshots("x4ww_stop_chuff");
	soundscripts\_audio_vehicle_manager::avm_end_behavior_def();
	soundscripts\_audio_vehicle_manager::avm_begin_behavior_def("to_state_destruct",::x4ww_condition_callback_to_state_destruct);
	soundscripts\_audio_vehicle_manager::avm_end_behavior_def();
	soundscripts\_audio_vehicle_manager::avm_begin_behavior_def("to_state_wheels_neutral",::x4ww_condition_callback_to_state_wheels_neutral);
	soundscripts\_audio_vehicle_manager::avm_end_behavior_def();
	soundscripts\_audio_vehicle_manager::avm_begin_behavior_def("to_state_wheels_bump_impact",::x4ww_condition_callback_to_state_wheels_bump_impact,["x4ww_zvelocity_front_left","x4ww_zvelocity_front_right","x4ww_zvelocity_rear_left","x4ww_zvelocity_rear_right","speed"],0.65,0.3);
	soundscripts\_audio_vehicle_manager::avm_add_oneshots("x4ww_suspen_bump_hard");
	soundscripts\_audio_vehicle_manager::avm_end_behavior_def();
	soundscripts\_audio_vehicle_manager::avm_begin_behavior_def("to_state_turret_rotate",::x4ww_condition_callback_to_state_turret_rotate);
	soundscripts\_audio_vehicle_manager::avm_end_behavior_def();
	soundscripts\_audio_vehicle_manager::avm_begin_behavior_def("to_state_turret_rotate_accel",::x4ww_condition_callback_to_state_turret_rotate_accel);
	soundscripts\_audio_vehicle_manager::avm_begin_param_map("x4ww_gun_yaw_rate",1,1);
	soundscripts\_audio_vehicle_manager::avm_end_param_map();
	soundscripts\_audio_vehicle_manager::avm_begin_param_map("speed",0.6,0.6);
	soundscripts\_audio_vehicle_manager::avm_end_param_map();
	soundscripts\_audio_vehicle_manager::avm_end_behavior_def();
	soundscripts\_audio_vehicle_manager::avm_begin_behavior_def("to_state_turret_rotate_decel",::x4ww_condition_callback_to_state_turret_rotate_decel);
	soundscripts\_audio_vehicle_manager::avm_end_behavior_def();
	soundscripts\_audio_vehicle_manager::avm_begin_behavior_def("to_state_turret_stopped",::x4ww_condition_callback_to_state_turret_stopped);
	soundscripts\_audio_vehicle_manager::avm_end_behavior_def();
	soundscripts\_audio_vehicle_manager::avm_begin_behavior_def("to_state_turret_elevate",::x4ww_condition_callback_to_state_turret_elevate);
	soundscripts\_audio_vehicle_manager::avm_end_behavior_def();
	soundscripts\_audio_vehicle_manager::avm_end_behavior_data();
	soundscripts\_audio_vehicle_manager::avm_begin_state_data();
	soundscripts\_audio_vehicle_manager::avm_begin_state_group("main_oneshots","state_enter_vehicle","to_state_enter_vehicle",50,1);
	soundscripts\_audio_vehicle_manager::avm_begin_state_def("state_off");
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("state_enter_vehicle","to_state_enter_vehicle");
	soundscripts\_audio_vehicle_manager::avm_end_state_def();
	soundscripts\_audio_vehicle_manager::avm_begin_state_def("state_enter_vehicle");
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("state_startup","to_state_startup");
	soundscripts\_audio_vehicle_manager::avm_end_state_def();
	soundscripts\_audio_vehicle_manager::avm_begin_state_def("state_startup");
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("state_idle","to_state_idle");
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("state_start_move","to_state_start_move");
	soundscripts\_audio_vehicle_manager::avm_end_state_def();
	soundscripts\_audio_vehicle_manager::avm_begin_state_def("state_shutoff");
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("state_off","to_state_off");
	soundscripts\_audio_vehicle_manager::avm_end_state_def();
	soundscripts\_audio_vehicle_manager::avm_begin_state_def("state_idle");
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("state_start_move","to_state_start_move");
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("state_shutoff","to_state_shutoff");
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("state_destruct","to_state_destruct");
	soundscripts\_audio_vehicle_manager::avm_end_state_def();
	soundscripts\_audio_vehicle_manager::avm_begin_state_def("state_start_move");
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("state_moving","to_state_moving");
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("state_shutoff","to_state_shutoff");
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("state_stop","to_state_stop");
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("state_breaking","to_state_breaking");
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("state_destruct","to_state_destruct");
	soundscripts\_audio_vehicle_manager::avm_end_state_def();
	soundscripts\_audio_vehicle_manager::avm_begin_state_def("state_breaking");
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("state_stop","to_state_stop");
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("state_moving","to_state_moving");
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("state_shutoff","to_state_shutoff");
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("state_start_move","to_state_start_move");
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("state_destruct","to_state_destruct");
	soundscripts\_audio_vehicle_manager::avm_end_state_def();
	soundscripts\_audio_vehicle_manager::avm_begin_state_def("state_stop");
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("state_idle","to_state_idle");
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("state_shutoff","to_state_shutoff");
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("state_destruct","to_state_destruct");
	soundscripts\_audio_vehicle_manager::avm_end_state_def();
	soundscripts\_audio_vehicle_manager::avm_begin_state_def("state_exit_vehicle");
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("state_off","to_state_off");
	soundscripts\_audio_vehicle_manager::avm_end_state_def();
	soundscripts\_audio_vehicle_manager::avm_begin_state_def("state_moving");
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("state_breaking","to_state_breaking");
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("state_stop","to_state_stop");
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("state_shutoff","to_state_shutoff");
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("state_start_move","to_state_start_move");
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("state_destruct","to_state_destruct");
	soundscripts\_audio_vehicle_manager::avm_end_state_def();
	soundscripts\_audio_vehicle_manager::avm_begin_state_def("state_destruct");
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("state_off","to_state_off");
	soundscripts\_audio_vehicle_manager::avm_end_state_def();
	soundscripts\_audio_vehicle_manager::avm_end_state_group();
	soundscripts\_audio_vehicle_manager::avm_begin_state_group("wheel_legs","state_wheels_neutral","to_state_wheels_neutral",50,1);
	soundscripts\_audio_vehicle_manager::avm_begin_state_def("state_wheels_neutral");
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("state_wheels_bump_impact","to_state_wheels_bump_impact");
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("state_wheels_neutral","to_state_wheels_neutral");
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("state_destruct","to_state_destruct");
	soundscripts\_audio_vehicle_manager::avm_end_state_def();
	soundscripts\_audio_vehicle_manager::avm_begin_state_def("state_wheels_bump_impact");
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("state_wheels_bump_impact","to_state_wheels_bump_impact");
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("state_wheels_neutral","to_state_wheels_neutral");
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("state_destruct","to_state_destruct");
	soundscripts\_audio_vehicle_manager::avm_end_state_def();
	soundscripts\_audio_vehicle_manager::avm_end_state_group();
	soundscripts\_audio_vehicle_manager::avm_begin_state_group("turret_rotate","state_turret_rotate","to_state_turret_rotate",50,1);
	soundscripts\_audio_vehicle_manager::avm_begin_state_def("state_turret_stopped");
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("state_turret_rotate","to_state_turret_rotate");
	soundscripts\_audio_vehicle_manager::avm_end_state_def();
	soundscripts\_audio_vehicle_manager::avm_begin_state_def("state_turret_rotate");
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("state_turret_rotate","to_state_turret_rotate");
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("state_turret_rotate_accel","to_state_turret_rotate_accel");
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("state_turret_rotate_decel","to_state_turret_rotate_decel");
	soundscripts\_audio_vehicle_manager::avm_end_state_def();
	soundscripts\_audio_vehicle_manager::avm_begin_state_def("state_turret_rotate_accel");
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("state_turret_rotate_accel","to_state_turret_rotate_accel");
	soundscripts\_audio_vehicle_manager::avm_end_state_def();
	soundscripts\_audio_vehicle_manager::avm_begin_state_def("state_turret_rotate_decel");
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("state_turret_rotate","to_state_turret_rotate");
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("state_turret_rotate_accel","to_state_turret_rotate_accel");
	soundscripts\_audio_vehicle_manager::avm_end_state_def();
	soundscripts\_audio_vehicle_manager::avm_end_state_group();
	soundscripts\_audio_vehicle_manager::avm_begin_state_group("turret_elevate","state_turret_elevate","to_state_turret_elevate",50,1);
	soundscripts\_audio_vehicle_manager::avm_begin_state_def("state_turret_elevate");
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("state_turret_elevate","to_state_turret_elevate");
	soundscripts\_audio_vehicle_manager::avm_end_state_def();
	soundscripts\_audio_vehicle_manager::avm_end_state_group();
	soundscripts\_audio_vehicle_manager::avm_end_state_data();
	soundscripts\_audio_vehicle_manager::avm_add_envelope("x4_idle_vel2vol",[[0,0.8],[1.75,0.3],[3.5,0.1]]);
	soundscripts\_audio_vehicle_manager::avm_add_envelope("x4_move_vel2vol",[[0,0],[1.75,0.9],[7,0]]);
	soundscripts\_audio_vehicle_manager::avm_add_envelope("x4_move2_lp_vel2vol",[[0,0],[1.75,0.7],[7,1]]);
	soundscripts\_audio_vehicle_manager::avm_add_envelope("x4_chuff_vel2vol",[[0,0.75],[1,1]]);
	soundscripts\_audio_vehicle_manager::avm_add_envelope("x4_break_squeal_vel2vol",[[0,0],[7,0.7]]);
	soundscripts\_audio_vehicle_manager::avm_add_envelope("x4_turret_rot_fast_vel2vol",[[-100,0.6],[-30,0.2],[0,0],[30,0.2],[100,0.6]]);
	soundscripts\_audio_vehicle_manager::avm_add_envelope("x4_turret_rot_slow_vel2vol",[[-100,0.6],[-10,0.5],[0,0],[10,0.5],[100,0.6]]);
	soundscripts\_audio_vehicle_manager::avm_add_envelope("x4_turret_rot_slow_vel2pit",[[-30,0.7],[0,0.5],[30,0.7]]);
	soundscripts\_audio_vehicle_manager::avm_add_envelope("x4_turret_rot_fast_vel2pit",[[-150,3],[-30,0.3],[0,0],[30,0.3],[150,3]]);
	soundscripts\_audio_vehicle_manager::avm_add_envelope("x4_turret_pitch_rate_vel2vol",[[-10,0.6],[-1,0.4],[0,0],[1,0.4],[10,0.6]]);
	soundscripts\_audio_vehicle_manager::avm_add_envelope("x4_turret_pitch_rate_gate",[[-0.3,1],[-0.2,0],[0,0],[0.2,0],[0.3,1]]);
	soundscripts\_audio_vehicle_manager::avm_add_envelope("x4_turret_pitch_rate_vel2pit",[[-100,0.5],[0,0.5],[100,0.5]]);
	soundscripts\_audio_vehicle_manager::avm_add_envelope("x4_move_vel2pch",[[0,0.9],[7,1.1]]);
	soundscripts\_audio_vehicle_manager::avm_add_envelope("x4_move2_lp_vel2pch",[[0,0.9],[2,0.9],[7,1.2]]);
	soundscripts\_audio_vehicle_manager::avm_add_envelope("x4_sub_lp_vel2vol",[[0,0.2],[7,0.4]]);
	soundscripts\_audio_vehicle_manager::avm_add_envelope("x4_veh_speed_to_turret_rot_vel2vol",[[0,1],[1.4,0],[7,0]]);
	soundscripts\_audio_vehicle_manager::avm_add_envelope("x4_veh_speed_to_turret_rot_gate",[[-1,1],[0,0],[1,1]]);
	soundscripts\_audio_vehicle_manager::avm_add_envelope("x4_suspen_vel2vol",[[0,0],[7,0.5]]);
	soundscripts\_audio_vehicle_manager::avm_add_envelope("x4_accel_1shot_accel2vol",[[0,1],[0.02,1],[0.1,1],[0.2,1]]);
	soundscripts\_audio_vehicle_manager::avm_add_envelope("xwalk_accel_duck_envelope",[[0,1],[0.55,0.4],[1,0.6],[2,1]]);
	soundscripts\_audio_vehicle_manager::avm_add_envelope("xwalk_accel2vol",[[0,0.7],[0.3,0.7],[1,0.7]]);
	soundscripts\_audio_vehicle_manager::avm_add_envelope("xwalk_vel2vol",[[0,1],[7,1]]);
	soundscripts\_audio_vehicle_manager::avm_add_envelope("x4_move_pit2pch",[[-2,0.9],[0,1],[2,1.1]]);
	soundscripts\_audio_vehicle_manager::avm_add_envelope("xwalk_stop_duck_envelope",[[0,1],[0.55,0.8],[0.85,0.8],[2,1]]);
	soundscripts\_audio_vehicle_manager::avm_add_envelope("x4_startup_duck_envelope",[[0,0],[0.55,0.1],[0.85,0.2],[1.5,1]]);
	soundscripts\_audio_vehicle_manager::avm_add_envelope("xwalk_shutoff_duck_envelope",[[0,1],[0.55,0.4],[0.85,0.3],[1.5,0],[5,0]]);
	soundscripts\_audio_vehicle_manager::avm_end_preset_def();
}

//Function Number: 4
x4ww_condition_callback_to_state_off(param_00,param_01)
{
	return 1;
}

//Function Number: 5
x4ww_condition_callback_to_state_enter_vehicle(param_00,param_01)
{
	var_02 = 0;
	var_03 = param_00["x4ww_player_driver"];
	if(var_03)
	{
		var_02 = 1;
	}

	return var_02;
}

//Function Number: 6
x4ww_condition_callback_to_state_exit_vehicle(param_00,param_01)
{
	var_02 = 0;
	var_03 = param_00["x4ww_player_driver"];
	if(!var_03)
	{
		var_02 = 1;
	}

	return var_02;
}

//Function Number: 7
x4ww_condition_callback_to_state_startup(param_00,param_01)
{
	param_01.g_xwalk_pitched_hard = 0;
	param_01.g_xwalk_was_stopped = 1;
	param_01.g_xwalk_vel_que = [0,0,0,0,0,0,0,0,0,0];
	param_01.g_turret_vel_array = [0,0,0,0];
	param_01.g_xwalk_started_to_move = 0;
	return 1;
}

//Function Number: 8
x4ww_condition_callback_to_state_shutoff(param_00,param_01)
{
	var_02 = 0;
	return var_02;
}

//Function Number: 9
x4ww_condition_callback_to_state_idle(param_00,param_01)
{
	var_02 = 0;
	var_03 = param_00["distance2d"];
	var_04 = param_00["speed"];
	if(var_04 <= 0.0001)
	{
		var_02 = 1;
	}

	return var_02;
}

//Function Number: 10
x4ww_condition_callback_to_state_start_move(param_00,param_01)
{
	var_02 = 0;
	var_03 = param_00["speed"];
	var_04 = 0;
	if(!isdefined(param_01.start_move))
	{
		param_01.start_move = spawnstruct();
		param_01.start_move.prev_velo = var_03;
		param_01.start_move.time_accel = 0;
		param_01.start_move.acceltime = 0;
		param_01.start_move.accelerating = 0;
		param_01.start_move.strain_accel_last_trigger = 0;
		param_01.start_move.strain_accel_time_since_trigger = 1000;
		param_01.start_move.rand_second_accel_thresh = randomintrange(1500,3500);
	}
	else
	{
		var_05 = var_03 - param_01.start_move.prev_velo;
		if(param_01.start_move.accelerating == 0 && var_05 > 0)
		{
			param_01.start_move.accelerating = 1;
			param_01.start_move.acceltime = gettime();
		}
		else if(param_01.start_move.accelerating == 1 && var_05 > 0)
		{
			param_01.start_move.time_accel = param_01.start_move.time_accel + gettime() - param_01.start_move.acceltime;
		}
		else if(var_05 <= 0 || var_03 >= 7)
		{
			param_01.start_move.accelerating = 0;
			param_01.start_move.acceltime = 0;
			param_01.start_move.time_accel = 0;
		}

		var_04 = gettime() - param_01.g_xwalk_started_to_move;
		if(param_01.g_xwalk_pitched_hard == 1 && var_05 > 0)
		{
			var_06 = gettime() - param_01.start_move.strain_accel_last_trigger;
			if(var_06 > 4000)
			{
				var_02 = 1;
				param_01.g_xwalk_started_to_move = gettime();
				param_01.start_move.acceltime = 0;
				param_01.start_move.accelerating = 0;
				param_01.start_move.time_accel = 0;
				param_01.g_xwalk_pitched_hard = 0;
				param_01.start_move.strain_accel_last_trigger = gettime();
				param_01.g_xwalk_was_stopped = 0;
			}
		}
		else if(param_01.start_move.time_accel > 400 && var_05 > 0.1 && param_01.g_xwalk_was_stopped)
		{
			var_02 = 1;
			param_01.g_xwalk_started_to_move = gettime();
			param_01.start_move.acceltime = 0;
			param_01.start_move.accelerating = 0;
			param_01.start_move.time_accel = 0;
			param_01.g_xwalk_was_stopped = 0;
		}
		else if(var_03 > 2 && var_04 > param_01.start_move.rand_second_accel_thresh && var_04 < param_01.start_move.rand_second_accel_thresh + 500)
		{
			var_02 = 1;
			param_01.start_move.acceltime = 0;
			param_01.start_move.accelerating = 0;
			param_01.start_move.time_accel = 0;
			param_01.g_xwalk_was_stopped = 0;
			param_01.start_move.rand_second_accel_thresh = randomintrange(1500,3500);
		}
		else if(var_03 >= 7 && param_01.g_xwalk_was_stopped)
		{
			var_02 = 1;
			param_01.g_xwalk_started_to_move = gettime();
			param_01.start_move.acceltime = 0;
			param_01.start_move.accelerating = 0;
			param_01.start_move.time_accel = 0;
			param_01.g_xwalk_was_stopped = 0;
		}

		param_01.start_move.prev_velo = var_03;
	}

	return var_02;
}

//Function Number: 11
x4ww_condition_callback_to_state_moving(param_00,param_01)
{
	var_02 = 0;
	var_03 = param_00["speed"];
	if(var_03 > 0.1)
	{
		var_02 = 1;
	}

	return var_02;
}

//Function Number: 12
x4ww_condition_callback_to_state_breaking(param_00,param_01)
{
	var_02 = 0;
	var_03 = param_00["speed"];
	var_04 = param_00["pitch"];
	var_05 = gettime() - param_01.g_xwalk_started_to_move;
	if(!isdefined(param_01.breaking))
	{
		param_01.breaking = spawnstruct();
		param_01.breaking.prev_velo = var_03;
		param_01.breaking.time_breaking = 0;
		param_01.breaking.breaktime = 0;
		param_01.breaking.is_breaking = 0;
		param_01.breaking.prev_pitch = 0;
		param_01.breaking.prev_dp = 0;
		param_01.breaking.time_pitching_hard = 0;
		param_01.breaking.pitching_hard = 0;
		param_01.breaking.pitching_hard_start_time = 0;
	}
	else
	{
		var_06 = var_04 - param_01.breaking.prev_pitch;
		if(abs(var_06) > 0.5 && param_01.g_xwalk_pitched_hard == 0)
		{
			var_02 = ["x4ww_decel_1"];
			param_01.g_xwalk_pitched_hard = 1;
		}

		var_07 = var_03 - param_01.breaking.prev_velo;
		if(param_01.breaking.is_breaking == 0 && var_07 < 0)
		{
			param_01.breaking.is_breaking = 1;
			param_01.breaktime = gettime();
		}
		else if(param_01.breaking.is_breaking == 1 && var_07 < 0)
		{
			param_01.breaking.time_breaking = param_01.breaking.time_breaking + gettime() - param_01.breaking.breaktime;
		}
		else if(var_07 >= 0)
		{
			param_01.breaking.breaking = 0;
			param_01.breaking.breaktime = 0;
			param_01.breaking.time_breaking = 0;
		}

		if(param_01.breaking.time_breaking > 400 && var_07 < -0.6 && var_05 > 2000)
		{
			param_01.breaking.breaktime = 0;
			param_01.breaking.breaking = 0;
			param_01.breaking.time_breaking = 0;
			var_02 = ["x4ww_decel_2"];
		}
		else if(param_01.breaking.time_breaking > 400 && var_07 < -0.6 && var_05 <= 2000)
		{
			param_01.breaking.breaktime = 0;
			param_01.breaking.breaking = 0;
			param_01.breaking.time_breaking = 0;
			var_02 = ["x4ww_decel_1"];
		}
		else if(var_03 < 0.1)
		{
			var_02 = 1;
			param_01.breaking.breaktime = 0;
			param_01.breaking.breaking = 0;
			param_01.breaking.time_breaking = 0;
			var_02 = ["x4ww_decel_1"];
		}

		param_01.breaking.prev_velo = var_03;
		param_01.breaking.prev_pitch = var_04;
	}

	return var_02;
}

//Function Number: 13
x4ww_condition_callback_to_state_stopped(param_00,param_01)
{
	var_02 = 0;
	var_03 = param_00["speed"];
	if(!isdefined(param_01.stopped))
	{
		param_01.stopped = spawnstruct();
		param_01.stopped.prev_velo = var_03;
		param_01.stopped.prev_dv = 0;
	}
	else
	{
		var_04 = var_03 - param_01.stopped.prev_velo;
		if(var_03 < 0.1)
		{
			var_02 = 1;
			param_01.g_xwalk_was_stopped = 1;
		}

		param_01.stopped.prev_velo = var_03;
		param_01.stopped.prev_dv = var_04;
	}

	return var_02;
}

//Function Number: 14
x4ww_condition_callback_to_state_destruct(param_00,param_01)
{
	return 0;
}

//Function Number: 15
x4ww_condition_callback_to_state_wheels_neutral(param_00,param_01)
{
	return 0;
}

//Function Number: 16
x4ww_condition_callback_to_state_wheels_bump_impact(param_00,param_01)
{
	var_02 = ["zv_front_left","zv_front_right","zv_rear_left","zv_rear_right"];
	var_03 = [];
	var_03["zv_front_left"] = param_00["x4ww_zvelocity_front_left"];
	var_03["zv_front_right"] = param_00["x4ww_zvelocity_front_right"];
	var_03["zv_rear_left"] = param_00["x4ww_zvelocity_rear_left"];
	var_03["zv_rear_right"] = param_00["x4ww_zvelocity_rear_right"];
	var_04 = param_00["speed"];
	var_05 = 0;
	if(!isdefined(param_01.wheels_bump_impact))
	{
		param_01.wheels_bump_impact = spawnstruct();
		param_01.wheels_bump_impact.prev_zv = [];
		foreach(var_07 in var_02)
		{
			param_01.wheels_bump_impact.prev_zv[var_07] = var_03[var_07];
		}

		var_09 = 0;
	}
	else
	{
		foreach(var_0B in var_03)
		{
			var_09 = var_03[var_0B] - param_01.wheels_bump_impact.prev_zv[var_0B];
			if(abs(var_09) > 2 && var_04 > 0)
			{
				var_05 = 1;
			}

			param_01.wheels_bump_impact.prev_zv[var_0B] = var_03[var_0B];
		}
	}

	return var_05;
}

//Function Number: 17
x4ww_condition_callback_to_state_turret_rotate(param_00,param_01)
{
	var_02 = 0;
	return var_02;
}

//Function Number: 18
x4ww_condition_callback_to_state_turret_stopped(param_00,param_01)
{
	var_02 = 0;
	return var_02;
}

//Function Number: 19
x4ww_condition_callback_to_state_turret_rotate_accel(param_00,param_01)
{
	var_02 = 0;
	var_03 = abs(param_00["x4ww_gun_yaw_rate"]);
	var_04 = param_00["speed"];
	if(!isdefined(param_01.turret_rotate_accel))
	{
		param_01.turret_rotate_accel = spawnstruct();
		param_01.turret_rotate_accel.prev_velo = var_03;
		param_01.turret_rotate_accel.prev_dv = 0;
		param_01.turret_rotate_accel.is_turret_accelerating = 0;
		param_01.turret_rotate_accel.time_turret_accelerating = 0;
		param_01.turret_rotate_accel.time_turret_accel_started = 0;
		param_01.turret_rotate_accel.time_last_turret_accel = 1000;
		param_01.turret_rotate_accel.can_turret_start_play = 1;
		param_01.turret_rotate_accel.time_turret_rotating = 0;
		param_01.turret_rotate_accel.is_turret_rotating = 0;
		param_01.turret_rotate_accel.time_turret_started_rotating = 0;
	}
	else
	{
		var_05 = var_03 - param_01.turret_rotate_accel.prev_velo;
		if(param_01.turret_rotate_accel.is_turret_accelerating == 0 && var_05 > 0)
		{
			param_01.turret_rotate_accel.is_turret_accelerating = 1;
			param_01.turret_rotate_accel.time_turret_accel_started = gettime();
		}
		else if(param_01.turret_rotate_accel.is_turret_accelerating == 1 && var_05 > 0)
		{
			param_01.turret_rotate_accel.time_turret_accelerating = param_01.turret_rotate_accel.time_turret_accelerating + gettime() - param_01.turret_rotate_accel.time_turret_accel_started;
		}
		else if(var_05 <= 0)
		{
			param_01.turret_rotate_accel.is_turret_accelerating = 0;
			param_01.turret_rotate_accel.time_turret_accelerating = 0;
			param_01.turret_rotate_accel.time_turret_accel_started = 0;
		}

		var_06 = gettime() - param_01.turret_rotate_accel.time_last_turret_accel;
		if(var_03 > 0.1 && param_01.turret_rotate_accel.is_turret_rotating == 0)
		{
			if(var_03 > 2 && var_05 > 0.05 && param_01.turret_rotate_accel.can_turret_start_play == 1 && var_04 < 0.1)
			{
				var_02 = ["x4ww_rotate_stop"];
				param_01.turret_rotate_accel.time_last_turret_accel = gettime();
				param_01.turret_rotate_accel.can_turret_start_play = 0;
				param_01.turret_rotate_accel.time_turret_started_rotating = gettime();
				param_01.turret_rotate_accel.is_turret_rotating = 1;
			}
			else if(var_03 > 0.5 && param_01.turret_rotate_accel.can_turret_start_play == 1)
			{
				param_01.turret_rotate_accel.can_turret_start_play = 0;
				param_01.turret_rotate_accel.time_turret_started_rotating = gettime();
				param_01.turret_rotate_accel.is_turret_rotating = 1;
			}
		}
		else if(var_03 <= 0.1 && param_01.turret_rotate_accel.is_turret_rotating == 1 && var_04 < 0.1)
		{
			var_07 = gettime() - param_01.turret_rotate_accel.time_turret_started_rotating;
			if(var_07 > 1500 && param_01.turret_rotate_accel.can_turret_start_play == 0)
			{
				var_02 = ["x4ww_rotate_stop"];
				param_01.turret_rotate_accel.can_turret_start_play = 1;
				param_01.turret_rotate_accel.is_turret_rotating = 0;
				var_07 = 0;
			}
			else if(var_07 <= 1500)
			{
				param_01.turret_rotate_accel.is_turret_rotating = 0;
				param_01.turret_rotate_accel.can_turret_start_play = 1;
				var_07 = 0;
			}
		}
		else if(var_03 <= 0.1 && param_01.turret_rotate_accel.is_turret_rotating == 1 && var_04 >= 0.1)
		{
			param_01.turret_rotate_accel.is_turret_rotating = 0;
			param_01.turret_rotate_accel.can_turret_start_play = 1;
			var_07 = 0;
		}

		param_01.turret_rotate_accel.prev_velo = var_03;
		param_01.turret_rotate_accel.prev_dv = var_05;
	}

	return var_02;
}

//Function Number: 20
x4ww_condition_callback_to_state_turret_rotate_decel(param_00,param_01)
{
	var_02 = 0;
	return var_02;
}

//Function Number: 21
x4ww_condition_callback_to_state_turret_elevate(param_00,param_01)
{
	var_02 = 0;
	return var_02;
}

//Function Number: 22
x4ww_input_callback_wheel_zvelocity_front_left()
{
	return x4ww_input_callback_wheel_zvelocity("tag_wheel_front_left");
}

//Function Number: 23
x4ww_input_callback_wheel_zvelocity_front_right()
{
	return x4ww_input_callback_wheel_zvelocity("tag_wheel_front_right");
}

//Function Number: 24
x4ww_input_callback_wheel_zvelocity_rear_left()
{
	return x4ww_input_callback_wheel_zvelocity("tag_wheel_back_left");
}

//Function Number: 25
x4ww_input_callback_wheel_zvelocity_rear_right()
{
	return x4ww_input_callback_wheel_zvelocity("tag_wheel_back_right");
}

//Function Number: 26
x4ww_input_callback_wheel_zvelocity(param_00)
{
	var_01 = soundscripts\_audio_vehicle_manager::avmx_get_vehicle_entity();
	var_02 = var_01 vehicle_scripts\_x4walker_wheels::get_wheel_velocity(param_00);
	var_03 = var_02[2];
	return var_03;
}

//Function Number: 27
x4ww_input_callback_gun_pitch_rate()
{
	var_00 = soundscripts\_audio_vehicle_manager::avmx_get_vehicle_entity();
	var_01 = 0;
	return var_01;
}

//Function Number: 28
x4ww_input_callback_gun_yaw_rate()
{
	var_00 = soundscripts\_audio_vehicle_manager::avmx_get_vehicle_entity();
	var_01 = 0;
	return var_01;
}

//Function Number: 29
x4ww_input_callback_player_driver()
{
	var_00 = soundscripts\_audio_vehicle_manager::avmx_get_vehicle_entity();
	return isdefined(var_00.player_driver);
}

//Function Number: 30
push_item_on_que(param_00,param_01)
{
	for(var_02 = param_00.size - 1;var_02 > 0;var_02--)
	{
		param_00[var_02] = param_00[var_02 - 1];
	}

	param_00[0] = param_01;
	return param_00;
}

//Function Number: 31
get_average_in_que(param_00)
{
	var_01 = 0;
	for(var_02 = 0;var_02 < param_00.size;var_02++)
	{
		var_01 = var_01 + param_00[var_02];
	}

	var_03 = var_01 / param_00.size;
	return var_03;
}