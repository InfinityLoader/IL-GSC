/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: _cover_drone_aud.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 40
 * Decompile Time: 592 ms
 * Timestamp: 4/22/2024 2:04:46 AM
*******************************************************************/

//Function Number: 1
snd_init_cover_drone()
{
	soundscripts\_audio_vehicle_manager::avm_register_callback("input_cdrn_in_use",::input_cdrn_in_use);
	soundscripts\_audio_vehicle_manager::avm_register_callback("input_cdrn_speed",::input_cdrn_speed);
	soundscripts\_audio_vehicle_manager::avm_register_callback("input_cdrn_throttle",::input_cdrn_throttle);
	soundscripts\_audio_vehicle_manager::avm_register_callback("input_cdrn_wheel_speed_left",::input_cdrn_wheel_speed_left);
	soundscripts\_audio_vehicle_manager::avm_register_callback("input_cdrn_wheel_speed_right",::input_cdrn_wheel_speed_right);
	soundscripts\_audio_vehicle_manager::avm_register_callback("input_cdrn_ball_joint_pitch_rate",::input_cdrn_ball_joint_pitch_rate);
	soundscripts\_audio_vehicle_manager::avm_register_callback("input_cdrn_ball_joint_roll_rate",::input_cdrn_ball_joint_roll_rate);
	soundscripts\_audio_vehicle_manager::avm_register_callback("input_cdrn_stuck_amount",::input_cdrn_stuck_amount);
	soundscripts\_snd::snd_register_message("cdrn_auto_unlink",::cdrn_auto_unlink);
	soundscripts\_snd::snd_message("snd_register_vehicle","cover_drone",::snd_cover_drone_constructor);
	var_00 = spawnstruct();
	var_00.preset_name = "cover_drone";
	soundscripts\_snd::snd_message("snd_start_vehicle",var_00);
}

//Function Number: 2
snd_stop_cover_drone(param_00,param_01)
{
	soundscripts\_snd::snd_message("snd_stop_vehicle",param_00,param_01);
}

//Function Number: 3
cdrn_intance_init(param_00)
{
}

//Function Number: 4
snd_cover_drone_constructor()
{
	soundscripts\_audio_vehicle_manager::avm_begin_preset_def("cover_drone");
	soundscripts\_audio_vehicle_manager::avm_begin_loop_data();
	soundscripts\_audio_vehicle_manager::avm_begin_loop_def("cdrn_rolling_wheels_lp");
	soundscripts\_audio_vehicle_manager::avm_begin_param_map("input_cdrn_speed",0.5,0.5);
	soundscripts\_audio_vehicle_manager::avm_add_param_map_env("volume","cdrn_rolling_wheels","cdrn_rolling_wheels");
	soundscripts\_audio_vehicle_manager::avm_end_param_map();
	soundscripts\_audio_vehicle_manager::avm_end_loop_def();
	soundscripts\_audio_vehicle_manager::avm_begin_loop_def("cdrn_throttle_lw_lp");
	soundscripts\_audio_vehicle_manager::avm_begin_param_map("input_cdrn_throttle",0.1,0.5);
	soundscripts\_audio_vehicle_manager::avm_add_param_map_env("volume","cdrn_throt2vol_lw","cdrn_throt2vol_lw");
	soundscripts\_audio_vehicle_manager::avm_add_param_map_env("volume","cdrn_throt2vol_all","cdrn_throt2vol_all");
	soundscripts\_audio_vehicle_manager::avm_add_param_map_env("pitch","cdrn_throt2pch","cdrn_throt2pch");
	soundscripts\_audio_vehicle_manager::avm_end_param_map();
	soundscripts\_audio_vehicle_manager::avm_end_loop_def();
	soundscripts\_audio_vehicle_manager::avm_begin_loop_def("cdrn_throttle_md_lp");
	soundscripts\_audio_vehicle_manager::avm_begin_param_map("input_cdrn_throttle",0.1,0.5);
	soundscripts\_audio_vehicle_manager::avm_add_param_map_env("volume","cdrn_throt2vol_md","cdrn_throt2vol_md");
	soundscripts\_audio_vehicle_manager::avm_add_param_map_env("volume","cdrn_throt2vol_all","cdrn_throt2vol_all");
	soundscripts\_audio_vehicle_manager::avm_add_param_map_env("pitch","cdrn_throt2pch","cdrn_throt2pch");
	soundscripts\_audio_vehicle_manager::avm_end_param_map();
	soundscripts\_audio_vehicle_manager::avm_end_loop_def();
	soundscripts\_audio_vehicle_manager::avm_begin_loop_def("cdrn_throttle_hi_lp");
	soundscripts\_audio_vehicle_manager::avm_begin_param_map("input_cdrn_throttle",0.1,0.5);
	soundscripts\_audio_vehicle_manager::avm_add_param_map_env("volume","cdrn_throt2vol_hi","cdrn_throt2vol_hi");
	soundscripts\_audio_vehicle_manager::avm_add_param_map_env("volume","cdrn_throt2vol_all","cdrn_throt2vol_all");
	soundscripts\_audio_vehicle_manager::avm_add_param_map_env("pitch","cdrn_throt2pch","cdrn_throt2pch");
	soundscripts\_audio_vehicle_manager::avm_end_param_map();
	soundscripts\_audio_vehicle_manager::avm_end_loop_def();
	soundscripts\_audio_vehicle_manager::avm_begin_loop_def("cdrn_rccar_lg");
	soundscripts\_audio_vehicle_manager::avm_begin_param_map("input_cdrn_wheel_speed_left",0.09,0.4);
	soundscripts\_audio_vehicle_manager::avm_add_param_map_env("volume","cdrn_wheel_vel2vol","cdrn_wheel_vel2vol");
	soundscripts\_audio_vehicle_manager::avm_add_param_map_env("pitch","cdrn_wheel_vel2pch","cdrn_wheel_vel2pch");
	soundscripts\_audio_vehicle_manager::avm_end_param_map();
	soundscripts\_audio_vehicle_manager::avm_begin_param_map("input_cdrn_in_use",0.09,0.4);
	soundscripts\_audio_vehicle_manager::avm_add_param_map_env("volume","cdrn_wheel_inuse2vol","cdrn_wheel_inuse2vol");
	soundscripts\_audio_vehicle_manager::avm_add_param_map_env("pitch","cdrn_wheel_inuse2pch","cdrn_wheel_inuse2pch");
	soundscripts\_audio_vehicle_manager::avm_end_param_map();
	soundscripts\_audio_vehicle_manager::avm_end_loop_def();
	soundscripts\_audio_vehicle_manager::avm_begin_loop_def("cdrn_rccar_md");
	soundscripts\_audio_vehicle_manager::avm_begin_param_map("input_cdrn_wheel_speed_right",0.15,0.5);
	soundscripts\_audio_vehicle_manager::avm_add_param_map_env("volume","cdrn_wheel_vel2vol","cdrn_wheel_vel2vol");
	soundscripts\_audio_vehicle_manager::avm_add_param_map_env("pitch","cdrn_wheel_vel2pch","cdrn_wheel_vel2pch");
	soundscripts\_audio_vehicle_manager::avm_end_param_map();
	soundscripts\_audio_vehicle_manager::avm_begin_param_map("input_cdrn_in_use",0.6,0.2);
	soundscripts\_audio_vehicle_manager::avm_add_param_map_env("volume","cdrn_wheel_inuse2vol","cdrn_wheel_inuse2vol");
	soundscripts\_audio_vehicle_manager::avm_add_param_map_env("pitch","cdrn_wheel_inuse2pch","cdrn_wheel_inuse2pch");
	soundscripts\_audio_vehicle_manager::avm_end_param_map();
	soundscripts\_audio_vehicle_manager::avm_end_loop_def();
	soundscripts\_audio_vehicle_manager::avm_end_loop_data();
	soundscripts\_audio_vehicle_manager::avm_begin_oneshot_data(0.25);
	soundscripts\_audio_vehicle_manager::avm_begin_oneshot_def("cdrn_startup","cdrn_startup_duck_envelope");
	soundscripts\_audio_vehicle_manager::avm_begin_param_map("input_cdrn_in_use");
	soundscripts\_audio_vehicle_manager::avm_add_param_map_env("volume","cdrn_startup_scalar");
	soundscripts\_audio_vehicle_manager::avm_end_param_map();
	soundscripts\_audio_vehicle_manager::avm_end_oneshot_def();
	soundscripts\_audio_vehicle_manager::avm_begin_oneshot_def("cdrn_shutdown","cdrn_startup_duck_envelope");
	soundscripts\_audio_vehicle_manager::avm_begin_param_map("input_cdrn_in_use");
	soundscripts\_audio_vehicle_manager::avm_add_param_map_env("volume","cdrn_shutdown_scalar");
	soundscripts\_audio_vehicle_manager::avm_end_param_map();
	soundscripts\_audio_vehicle_manager::avm_end_oneshot_def();
	soundscripts\_audio_vehicle_manager::avm_begin_oneshot_def("cdrn_wheel_start_move_l",undefined,0.25,0,"cdrn_wheel_start_move");
	soundscripts\_audio_vehicle_manager::avm_begin_param_map("input_cdrn_wheel_speed_left");
	soundscripts\_audio_vehicle_manager::avm_add_param_map_env("volume","cdrn_servo_oneshot_vol_scalar");
	soundscripts\_audio_vehicle_manager::avm_add_param_map_env("pitch",::cdrn_servo_oneshot_pch_func,"cdrn_servo_oneshot_pch_scalar");
	soundscripts\_audio_vehicle_manager::avm_end_param_map();
	soundscripts\_audio_vehicle_manager::avm_end_oneshot_def();
	soundscripts\_audio_vehicle_manager::avm_begin_oneshot_def("cdrn_wheel_stop_move_l",undefined,0.25,0,"cdrn_wheel_stop_move");
	soundscripts\_audio_vehicle_manager::avm_begin_param_map("input_cdrn_wheel_speed_left");
	soundscripts\_audio_vehicle_manager::avm_add_param_map_env("volume","cdrn_servo_oneshot_vol_scalar");
	soundscripts\_audio_vehicle_manager::avm_add_param_map_env("pitch",::cdrn_servo_oneshot_pch_func,"cdrn_servo_oneshot_pch_scalar");
	soundscripts\_audio_vehicle_manager::avm_end_param_map();
	soundscripts\_audio_vehicle_manager::avm_end_oneshot_def();
	soundscripts\_audio_vehicle_manager::avm_begin_oneshot_def("cdrn_wheel_start_move_r",undefined,0.25,0,"cdrn_wheel_start_move");
	soundscripts\_audio_vehicle_manager::avm_begin_param_map("input_cdrn_wheel_speed_right");
	soundscripts\_audio_vehicle_manager::avm_add_param_map_env("volume","cdrn_servo_oneshot_vol_scalar");
	soundscripts\_audio_vehicle_manager::avm_add_param_map_env("pitch",::cdrn_servo_oneshot_pch_func,"cdrn_servo_oneshot_pch_scalar");
	soundscripts\_audio_vehicle_manager::avm_end_param_map();
	soundscripts\_audio_vehicle_manager::avm_end_oneshot_def();
	soundscripts\_audio_vehicle_manager::avm_begin_oneshot_def("cdrn_wheel_stop_move_r",undefined,0.25,0,"cdrn_wheel_stop_move");
	soundscripts\_audio_vehicle_manager::avm_begin_param_map("input_cdrn_wheel_speed_right");
	soundscripts\_audio_vehicle_manager::avm_add_param_map_env("volume","cdrn_servo_oneshot_vol_scalar");
	soundscripts\_audio_vehicle_manager::avm_add_param_map_env("pitch",::cdrn_servo_oneshot_pch_func,"cdrn_servo_oneshot_pch_scalar");
	soundscripts\_audio_vehicle_manager::avm_end_param_map();
	soundscripts\_audio_vehicle_manager::avm_end_oneshot_def();
	soundscripts\_audio_vehicle_manager::avm_begin_oneshot_def("cdrn_ball_pitch_start",undefined,0.25,0,"cdrn_ball_pitch_start_stop");
	soundscripts\_audio_vehicle_manager::avm_begin_param_map("input_cdrn_ball_joint_pitch_rate");
	soundscripts\_audio_vehicle_manager::avm_add_param_map_env("volume","cdrn_servo_oneshot_vol_scalar");
	soundscripts\_audio_vehicle_manager::avm_add_param_map_env("pitch",::cdrn_servo_oneshot_pch_func,"cdrn_servo_oneshot_pch_scalar");
	soundscripts\_audio_vehicle_manager::avm_end_param_map();
	soundscripts\_audio_vehicle_manager::avm_end_oneshot_def();
	soundscripts\_audio_vehicle_manager::avm_begin_oneshot_def("cdrn_ball_pitch_stop",undefined,0.25,0,"cdrn_ball_pitch_start_stop");
	soundscripts\_audio_vehicle_manager::avm_begin_param_map("input_cdrn_ball_joint_pitch_rate");
	soundscripts\_audio_vehicle_manager::avm_add_param_map_env("volume","cdrn_servo_oneshot_vol_scalar");
	soundscripts\_audio_vehicle_manager::avm_end_param_map();
	soundscripts\_audio_vehicle_manager::avm_end_oneshot_def();
	soundscripts\_audio_vehicle_manager::avm_begin_oneshot_def("cdrn_ball_roll_start_move",undefined,0.25,0);
	soundscripts\_audio_vehicle_manager::avm_begin_param_map("input_cdrn_ball_joint_roll_rate");
	soundscripts\_audio_vehicle_manager::avm_add_param_map_env("volume","cdrn_servo_oneshot_vol_scalar");
	soundscripts\_audio_vehicle_manager::avm_add_param_map_env("pitch",::cdrn_servo_oneshot_pch_func,"cdrn_servo_oneshot_pch_scalar");
	soundscripts\_audio_vehicle_manager::avm_end_param_map();
	soundscripts\_audio_vehicle_manager::avm_end_oneshot_def();
	soundscripts\_audio_vehicle_manager::avm_begin_oneshot_def("cdrn_ball_roll_stop_move",undefined,0.25,0);
	soundscripts\_audio_vehicle_manager::avm_begin_param_map("input_cdrn_ball_joint_roll_rate");
	soundscripts\_audio_vehicle_manager::avm_add_param_map_env("volume","cdrn_servo_oneshot_vol_scalar");
	soundscripts\_audio_vehicle_manager::avm_end_param_map();
	soundscripts\_audio_vehicle_manager::avm_end_oneshot_def();
	soundscripts\_audio_vehicle_manager::avm_begin_oneshot_def("cdrn_bump_lg","cdrn_bump_duck_env",0.25,0);
	soundscripts\_audio_vehicle_manager::avm_begin_param_map("input_cdrn_ball_joint_pitch_rate");
	soundscripts\_audio_vehicle_manager::avm_add_param_map_env("volume","cdrn_ball_roll_bump_vel2vol");
	soundscripts\_audio_vehicle_manager::avm_end_param_map();
	soundscripts\_audio_vehicle_manager::avm_begin_param_map("input_cdrn_ball_joint_roll_rate");
	soundscripts\_audio_vehicle_manager::avm_add_param_map_env("volume","cdrn_ball_roll_bump_vel2vol");
	soundscripts\_audio_vehicle_manager::avm_end_param_map();
	soundscripts\_audio_vehicle_manager::avm_end_oneshot_def();
	soundscripts\_audio_vehicle_manager::avm_begin_oneshot_def("cdrn_bump_md","cdrn_bump_duck_env",0.25,0);
	soundscripts\_audio_vehicle_manager::avm_begin_param_map("input_cdrn_ball_joint_pitch_rate");
	soundscripts\_audio_vehicle_manager::avm_add_param_map_env("volume","cdrn_ball_roll_bump_vel2vol");
	soundscripts\_audio_vehicle_manager::avm_end_param_map();
	soundscripts\_audio_vehicle_manager::avm_begin_param_map("input_cdrn_ball_joint_roll_rate");
	soundscripts\_audio_vehicle_manager::avm_add_param_map_env("volume","cdrn_ball_roll_bump_vel2vol");
	soundscripts\_audio_vehicle_manager::avm_end_param_map();
	soundscripts\_audio_vehicle_manager::avm_end_oneshot_def();
	soundscripts\_audio_vehicle_manager::avm_begin_oneshot_def("cdrn_bump_sm","cdrn_bump_duck_env",0.25,0);
	soundscripts\_audio_vehicle_manager::avm_begin_param_map("input_cdrn_ball_joint_pitch_rate");
	soundscripts\_audio_vehicle_manager::avm_add_param_map_env("volume","cdrn_ball_roll_bump_vel2vol");
	soundscripts\_audio_vehicle_manager::avm_end_param_map();
	soundscripts\_audio_vehicle_manager::avm_begin_param_map("input_cdrn_ball_joint_roll_rate");
	soundscripts\_audio_vehicle_manager::avm_add_param_map_env("volume","cdrn_ball_roll_bump_vel2vol");
	soundscripts\_audio_vehicle_manager::avm_end_param_map();
	soundscripts\_audio_vehicle_manager::avm_end_oneshot_def();
	soundscripts\_audio_vehicle_manager::avm_end_oneshot_data();
	soundscripts\_audio_vehicle_manager::avm_begin_behavior_data();
	soundscripts\_audio_vehicle_manager::avm_begin_behavior_def("to_vehicle_off",::to_vehicle_off,["input_cdrn_in_use"]);
	soundscripts\_audio_vehicle_manager::avm_add_loops("NONE");
	soundscripts\_audio_vehicle_manager::avm_end_behavior_def();
	soundscripts\_audio_vehicle_manager::avm_begin_behavior_def("to_vehicle_startup",::to_vehicle_startup,["input_cdrn_in_use"]);
	soundscripts\_audio_vehicle_manager::avm_add_loops("ALL");
	soundscripts\_audio_vehicle_manager::avm_add_oneshots("cdrn_startup");
	soundscripts\_audio_vehicle_manager::avm_end_behavior_def();
	soundscripts\_audio_vehicle_manager::avm_begin_behavior_def("to_vehicle_on",::to_vehicle_on,["input_cdrn_in_use"]);
	soundscripts\_audio_vehicle_manager::avm_add_loops("ALL");
	soundscripts\_audio_vehicle_manager::avm_end_behavior_def();
	soundscripts\_audio_vehicle_manager::avm_begin_behavior_def("to_vehicle_shutdown",::to_vehicle_shutdown,["input_cdrn_in_use"]);
	soundscripts\_audio_vehicle_manager::avm_add_loops("NONE");
	soundscripts\_audio_vehicle_manager::avm_add_oneshots("cdrn_shutdown");
	soundscripts\_audio_vehicle_manager::avm_end_behavior_def();
	soundscripts\_audio_vehicle_manager::avm_begin_behavior_def("to_wheel_left_idle",::to_wheel_left_idle,["input_cdrn_wheel_speed_left"]);
	soundscripts\_audio_vehicle_manager::avm_end_behavior_def();
	soundscripts\_audio_vehicle_manager::avm_begin_behavior_def("to_wheel_left_start_move",::to_wheel_left_start_move,["input_cdrn_wheel_speed_left"]);
	soundscripts\_audio_vehicle_manager::avm_add_oneshots("cdrn_wheel_start_move_l");
	soundscripts\_audio_vehicle_manager::avm_end_behavior_def();
	soundscripts\_audio_vehicle_manager::avm_begin_behavior_def("to_wheel_left_moving",::to_wheel_left_moving,["input_cdrn_wheel_speed_left"]);
	soundscripts\_audio_vehicle_manager::avm_end_behavior_def();
	soundscripts\_audio_vehicle_manager::avm_begin_behavior_def("to_wheel_left_stop_move",::to_wheel_left_stop_move,["input_cdrn_wheel_speed_left"]);
	soundscripts\_audio_vehicle_manager::avm_add_oneshots("cdrn_wheel_stop_move_l");
	soundscripts\_audio_vehicle_manager::avm_end_behavior_def();
	soundscripts\_audio_vehicle_manager::avm_begin_behavior_def("to_wheel_right_idle",::to_wheel_right_idle,["input_cdrn_wheel_speed_right"]);
	soundscripts\_audio_vehicle_manager::avm_end_behavior_def();
	soundscripts\_audio_vehicle_manager::avm_begin_behavior_def("to_wheel_right_start_move",::to_wheel_right_start_move,["input_cdrn_wheel_speed_right"]);
	soundscripts\_audio_vehicle_manager::avm_add_oneshots("cdrn_wheel_start_move_r");
	soundscripts\_audio_vehicle_manager::avm_end_behavior_def();
	soundscripts\_audio_vehicle_manager::avm_begin_behavior_def("to_wheel_right_moving",::to_wheel_right_moving,["input_cdrn_wheel_speed_right"]);
	soundscripts\_audio_vehicle_manager::avm_end_behavior_def();
	soundscripts\_audio_vehicle_manager::avm_begin_behavior_def("to_wheel_right_stop_move",::to_wheel_right_stop_move,["input_cdrn_wheel_speed_right"]);
	soundscripts\_audio_vehicle_manager::avm_add_oneshots("cdrn_wheel_stop_move_r");
	soundscripts\_audio_vehicle_manager::avm_end_behavior_def();
	soundscripts\_audio_vehicle_manager::avm_begin_behavior_def("to_ball_pitch_idle",::to_ball_pitch_idle,["input_cdrn_ball_joint_pitch_rate"]);
	soundscripts\_audio_vehicle_manager::avm_end_behavior_def();
	soundscripts\_audio_vehicle_manager::avm_begin_behavior_def("to_ball_pitch_start_move",::to_ball_pitch_start_move,["input_cdrn_ball_joint_pitch_rate"]);
	soundscripts\_audio_vehicle_manager::avm_add_oneshots("cdrn_ball_pitch_start");
	soundscripts\_audio_vehicle_manager::avm_end_behavior_def();
	soundscripts\_audio_vehicle_manager::avm_begin_behavior_def("to_ball_pitch_moving",::to_ball_pitch_moving,["speed"]);
	soundscripts\_audio_vehicle_manager::avm_begin_param_map("input_cdrn_ball_joint_pitch_rate");
	soundscripts\_audio_vehicle_manager::avm_add_param_map_env("volume","cdrn_ball_roll_bump_vel2vol");
	soundscripts\_audio_vehicle_manager::avm_end_param_map();
	soundscripts\_audio_vehicle_manager::avm_end_behavior_def();
	soundscripts\_audio_vehicle_manager::avm_begin_behavior_def("to_ball_pitch_stop_move",::to_ball_pitch_stop_move,["input_cdrn_ball_joint_pitch_rate"]);
	soundscripts\_audio_vehicle_manager::avm_add_oneshots("cdrn_ball_pitch_stop");
	soundscripts\_audio_vehicle_manager::avm_end_behavior_def();
	soundscripts\_audio_vehicle_manager::avm_begin_behavior_def("to_ball_roll_idle",::to_ball_roll_idle,["input_cdrn_ball_joint_roll_rate"]);
	soundscripts\_audio_vehicle_manager::avm_end_behavior_def();
	soundscripts\_audio_vehicle_manager::avm_begin_behavior_def("to_ball_roll_start_move",::to_ball_roll_start_move,["input_cdrn_ball_joint_roll_rate"]);
	soundscripts\_audio_vehicle_manager::avm_add_oneshots("cdrn_ball_roll_start_move");
	soundscripts\_audio_vehicle_manager::avm_end_behavior_def();
	soundscripts\_audio_vehicle_manager::avm_begin_behavior_def("to_ball_roll_moving",::to_ball_roll_moving,["speed"]);
	soundscripts\_audio_vehicle_manager::avm_begin_param_map("input_cdrn_ball_joint_roll_rate");
	soundscripts\_audio_vehicle_manager::avm_add_param_map_env("volume","cdrn_ball_roll_bump_vel2vol");
	soundscripts\_audio_vehicle_manager::avm_end_param_map();
	soundscripts\_audio_vehicle_manager::avm_end_behavior_def();
	soundscripts\_audio_vehicle_manager::avm_begin_behavior_def("to_ball_roll_stop_move",::to_ball_roll_stop_move,["input_cdrn_ball_joint_roll_rate"]);
	soundscripts\_audio_vehicle_manager::avm_end_behavior_def();
	soundscripts\_audio_vehicle_manager::avm_end_behavior_data();
	soundscripts\_audio_vehicle_manager::avm_begin_state_data();
	soundscripts\_audio_vehicle_manager::avm_begin_state_group("vehicle","vehicle_off","to_vehicle_off",50,0);
	soundscripts\_audio_vehicle_manager::avm_begin_state_def("vehicle_off");
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("vehicle_startup","to_vehicle_startup");
	soundscripts\_audio_vehicle_manager::avm_end_state_def();
	soundscripts\_audio_vehicle_manager::avm_begin_state_def("vehicle_startup",0,100);
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("vehicle_on","to_vehicle_on");
	soundscripts\_audio_vehicle_manager::avm_end_state_def();
	soundscripts\_audio_vehicle_manager::avm_begin_state_def("vehicle_on");
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("vehicle_shutdown","to_vehicle_shutdown");
	soundscripts\_audio_vehicle_manager::avm_end_state_def();
	soundscripts\_audio_vehicle_manager::avm_begin_state_def("vehicle_shutdown");
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("vehicle_off","to_vehicle_off");
	soundscripts\_audio_vehicle_manager::avm_end_state_def();
	soundscripts\_audio_vehicle_manager::avm_end_state_group();
	soundscripts\_audio_vehicle_manager::avm_begin_state_group("ball_pitch","ball_pitch_idle","to_ball_pitch_idle",50);
	soundscripts\_audio_vehicle_manager::avm_begin_state_def("ball_pitch_idle");
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("ball_pitch_start_move","to_ball_pitch_start_move");
	soundscripts\_audio_vehicle_manager::avm_end_state_def();
	soundscripts\_audio_vehicle_manager::avm_begin_state_def("ball_pitch_start_move");
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("ball_pitch_moving","to_ball_pitch_moving");
	soundscripts\_audio_vehicle_manager::avm_end_state_def();
	soundscripts\_audio_vehicle_manager::avm_begin_state_def("ball_pitch_moving");
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("ball_pitch_stop_move","to_ball_pitch_stop_move");
	soundscripts\_audio_vehicle_manager::avm_end_state_def();
	soundscripts\_audio_vehicle_manager::avm_begin_state_def("ball_pitch_stop_move");
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("ball_pitch_idle","to_ball_pitch_idle");
	soundscripts\_audio_vehicle_manager::avm_end_state_def();
	soundscripts\_audio_vehicle_manager::avm_end_state_group();
	soundscripts\_audio_vehicle_manager::avm_begin_state_group("ball_roll","ball_roll_idle","to_ball_roll_idle",50,0.25);
	soundscripts\_audio_vehicle_manager::avm_begin_state_def("ball_roll_idle");
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("ball_roll_start_move","to_ball_roll_start_move");
	soundscripts\_audio_vehicle_manager::avm_end_state_def();
	soundscripts\_audio_vehicle_manager::avm_begin_state_def("ball_roll_start_move");
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("ball_roll_moving","to_ball_roll_moving");
	soundscripts\_audio_vehicle_manager::avm_end_state_def();
	soundscripts\_audio_vehicle_manager::avm_begin_state_def("ball_roll_moving");
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("ball_roll_moving","to_ball_roll_moving");
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("ball_roll_stop_move","to_ball_roll_stop_move");
	soundscripts\_audio_vehicle_manager::avm_end_state_def();
	soundscripts\_audio_vehicle_manager::avm_begin_state_def("ball_roll_stop_move",0.25,60);
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("ball_roll_idle","to_ball_roll_idle");
	soundscripts\_audio_vehicle_manager::avm_end_state_def();
	soundscripts\_audio_vehicle_manager::avm_end_state_group();
	soundscripts\_audio_vehicle_manager::avm_end_state_data();
	soundscripts\_audio_vehicle_manager::avm_add_envelope("cdrn_foo_env_function",::foo_env_function);
	soundscripts\_audio_vehicle_manager::avm_add_envelope("cdrn_throt2vol_all",[[0,0],[1.122,0],[4.488,0],[10.098,0],[17.9575,0],[28.061,0],[40.403,0],[55,0]]);
	soundscripts\_audio_vehicle_manager::avm_add_envelope("cdrn_rolling_wheels",[[0,0],[0.051,0.0165],[0.204,0.02935],[0.459,0.05555],[0.81625,0.1107],[1.2755,0.2222],[1.8365,0.39505],[2.5,0.5]]);
	soundscripts\_audio_vehicle_manager::avm_add_envelope("cdrn_throt2vol_lw",[[0,1],[18.315,1],[55,0]]);
	soundscripts\_audio_vehicle_manager::avm_add_envelope("cdrn_throt2vol_md",[[0,0],[18.315,1],[36.63,1],[55,0.6]]);
	soundscripts\_audio_vehicle_manager::avm_add_envelope("cdrn_throt2vol_hi",[[0,0],[36.63,1],[55,1]]);
	soundscripts\_audio_vehicle_manager::avm_add_envelope("cdrn_throt2pch",[[0,1],[1,1.4]]);
	soundscripts\_audio_vehicle_manager::avm_add_envelope("cdrn_wheel_vel2vol",[[0,0.125],[0.918,0.130775],[3.672,0.1352725],[8.262,0.1444425],[14.6925,0.163745],[22.959,0.20277],[33.057,0.2632675],[45,0.3]]);
	soundscripts\_audio_vehicle_manager::avm_add_envelope("cdrn_wheel_vel2pch",[[0,0.95],[45,1.1]]);
	soundscripts\_audio_vehicle_manager::avm_add_envelope("cdrn_wheel_inuse2vol",[[0,0],[0.5,0.6],[1,0.6]]);
	soundscripts\_audio_vehicle_manager::avm_add_envelope("cdrn_wheel_inuse2pch",[[0,0.2375],[1,1]]);
	soundscripts\_audio_vehicle_manager::avm_add_envelope("cdrn_ball_roll_bump_vel2vol",[[0,0.225],[20,0.9]]);
	soundscripts\_audio_vehicle_manager::avm_add_envelope("cdrn_startup_duck_envelope",[[0,1],[0.2,0.6],[0.5,0.6],[0.6,1]]);
	soundscripts\_audio_vehicle_manager::avm_add_envelope("cdrn_bump_duck_env",[[0,1],[0.1,0.6],[0.25,0.6],[0.5,1]]);
	soundscripts\_audio_vehicle_manager::avm_add_envelope("cdrn_fullvol",[[0,1],[1,1]]);
	soundscripts\_audio_vehicle_manager::avm_add_envelope("cdrn_startup_scalar",[[0,1],[1,1]]);
	soundscripts\_audio_vehicle_manager::avm_add_envelope("cdrn_shutdown_scalar",[[0,1],[1,1]]);
	soundscripts\_audio_vehicle_manager::avm_add_envelope("cdrn_servo_oneshot_vol_scalar",[[0,0.1],[45,0.1]]);
	soundscripts\_audio_vehicle_manager::avm_add_envelope("cdrn_servo_oneshot_pch_scalar",[[0,0.8],[0,0.8],[20,0.8]]);
	soundscripts\_audio_vehicle_manager::avm_end_preset_def();
}

//Function Number: 5
foo_env_function()
{
	return 1;
}

//Function Number: 6
cdrn_servo_oneshot_pch_func(param_00)
{
	return randomfloatrange(0.7,1);
}

//Function Number: 7
print_state(param_00,param_01,param_02)
{
	if(isarray(param_00) || param_00)
	{
		var_03 = "";
		if(isdefined(param_02))
		{
			var_03 = var_03 + param_02;
		}

		iprintlnbold(param_01 + " " + var_03);
	}
}

//Function Number: 8
to_vehicle_off(param_00,param_01)
{
	var_02 = param_00["input_cdrn_in_use"] == 0;
	return var_02;
}

//Function Number: 9
to_vehicle_startup(param_00,param_01)
{
	var_02 = param_00["input_cdrn_in_use"] == 1;
	if(var_02)
	{
	}

	return var_02;
}

//Function Number: 10
to_vehicle_on(param_00,param_01)
{
	var_02 = param_00["input_cdrn_in_use"] == 1;
	return var_02;
}

//Function Number: 11
to_vehicle_shutdown(param_00,param_01)
{
	var_02 = param_00["input_cdrn_in_use"] == 0;
	return var_02;
}

//Function Number: 12
to_wheel_left_idle(param_00,param_01)
{
	var_02 = param_00["input_cdrn_wheel_speed_left"];
	var_03 = var_02 < 4;
	return var_03;
}

//Function Number: 13
to_wheel_left_start_move(param_00,param_01)
{
	var_02 = param_00["input_cdrn_wheel_speed_left"];
	var_03 = var_02 > 4;
	if(var_03)
	{
	}

	return var_03;
}

//Function Number: 14
to_wheel_left_moving(param_00,param_01)
{
	var_02 = param_00["input_cdrn_wheel_speed_left"] > 0;
	var_03 = var_02 > 0;
	return var_03;
}

//Function Number: 15
to_wheel_left_stop_move(param_00,param_01)
{
	var_02 = param_00["input_cdrn_wheel_speed_left"] < 4;
	var_03 = var_02 < 4;
	if(var_03)
	{
	}

	return var_03;
}

//Function Number: 16
to_wheel_right_idle(param_00,param_01)
{
	var_02 = param_00["input_cdrn_wheel_speed_right"] < 4;
	var_03 = var_02 > 0;
	return var_03;
}

//Function Number: 17
to_wheel_right_start_move(param_00,param_01)
{
	var_02 = param_00["input_cdrn_wheel_speed_right"];
	var_03 = var_02 > 4;
	return var_03;
}

//Function Number: 18
to_wheel_right_moving(param_00,param_01)
{
	var_02 = param_00["input_cdrn_wheel_speed_right"];
	var_03 = var_02 > 0;
	return var_03;
}

//Function Number: 19
to_wheel_right_stop_move(param_00,param_01)
{
	var_02 = param_00["input_cdrn_wheel_speed_right"];
	var_03 = var_02 < 4;
	return var_03;
}

//Function Number: 20
to_ball_pitch_idle(param_00,param_01)
{
	var_02 = param_00["input_cdrn_ball_joint_pitch_rate"];
	var_03 = abs(var_02) < 4;
	return var_03;
}

//Function Number: 21
to_ball_pitch_start_move(param_00,param_01)
{
	var_02 = param_00["input_cdrn_ball_joint_pitch_rate"];
	var_03 = abs(var_02) > 4;
	return var_03;
}

//Function Number: 22
to_ball_pitch_moving(param_00,param_01)
{
	var_02 = param_00["input_cdrn_ball_joint_pitch_rate"];
	var_03 = param_00["speed"];
	var_04 = do_bumps(var_02,var_03,param_01);
	return var_04;
}

//Function Number: 23
to_ball_pitch_stop_move(param_00,param_01)
{
	var_02 = param_00["input_cdrn_ball_joint_pitch_rate"];
	var_03 = abs(var_02) < 4;
	return var_03;
}

//Function Number: 24
to_ball_roll_idle(param_00,param_01)
{
	var_02 = param_00["input_cdrn_ball_joint_roll_rate"];
	var_03 = abs(var_02) < 4;
	return var_03;
}

//Function Number: 25
to_ball_roll_start_move(param_00,param_01)
{
	var_02 = param_00["input_cdrn_ball_joint_roll_rate"];
	var_03 = abs(var_02) > 4;
	return var_03;
}

//Function Number: 26
to_ball_roll_moving(param_00,param_01)
{
	var_02 = param_00["input_cdrn_ball_joint_roll_rate"];
	var_03 = param_00["speed"];
	var_04 = do_bumps(var_02,var_03,param_01);
	return var_04;
}

//Function Number: 27
do_bumps(param_00,param_01,param_02)
{
	var_03 = 1;
	if(!isdefined(param_02.to_ball_roll_moving))
	{
		param_02.to_ball_roll_moving = spawnstruct();
		var_04 = param_02.to_ball_roll_moving;
		var_04.prev_rate = param_00;
		var_04.prev_accel_oneshot_time = 0;
	}

	var_04 = param_02.to_ball_roll_moving;
	var_05 = abs(param_00 - var_04.prev_rate);
	if(var_05 > 0)
	{
	}

	var_06 = gettime();
	if(param_01 > 0.5 && var_05 > 2 && var_06 - var_04.prev_accel_oneshot_time > 0.25)
	{
		if(var_05 > 20)
		{
			var_03 = ["cdrn_bump_lg"];
		}
		else if(var_05 > 10)
		{
			var_03 = ["cdrn_bump_md"];
		}
		else
		{
			var_03 = ["cdrn_bump_sm"];
		}

		var_04.prev_accel_oneshot_time = var_06;
	}

	var_04.prev_rate = param_00;
	if((isarray(var_03) && var_03.size > 0) || var_03)
	{
	}

	return var_03;
}

//Function Number: 28
to_ball_roll_stop_move(param_00,param_01)
{
	var_02 = param_00["input_cdrn_ball_joint_roll_rate"];
	var_03 = abs(var_02) < 4;
	return var_03;
}

//Function Number: 29
input_cdrn_in_use()
{
	var_00 = 0;
	var_01 = soundscripts\_audio_vehicle_manager::avmx_get_vehicle_entity();
	if(isdefined(var_01.linked_player))
	{
		var_00 = 1;
	}

	return var_00;
}

//Function Number: 30
input_cdrn_speed()
{
	var_00 = soundscripts\_audio_vehicle_manager::avmx_get_vehicle_entity();
	var_01 = var_00 vehicle_getspeed();
	return var_01;
}

//Function Number: 31
input_cdrn_throttle()
{
	var_00 = input_cdrn_wheel_speed(0);
	var_01 = input_cdrn_wheel_speed(1);
	var_02 = var_00 + var_01 * 0.5;
	return var_02;
}

//Function Number: 32
input_cdrn_wheel_speed_left()
{
	var_00 = input_cdrn_wheel_speed(0);
	return var_00;
}

//Function Number: 33
input_cdrn_wheel_speed_right()
{
	var_00 = input_cdrn_wheel_speed(1);
	return var_00;
}

//Function Number: 34
input_cdrn_wheel_speed(param_00)
{
	var_01 = soundscripts\_audio_vehicle_manager::avmx_get_vehicle_entity();
	if(!isdefined(var_01.cover_drone_wheels))
	{
		var_01.cover_drone_wheels = [];
	}

	if(!isdefined(var_01.cover_drone_wheels[param_00]))
	{
		var_01.cover_drone_wheels[param_00] = spawnstruct();
	}

	if(param_00 == 0)
	{
		var_02 = 18;
	}
	else
	{
		var_02 = -18;
	}

	var_01.cover_drone_wheels[param_00].origin = var_01.origin + anglestoright(var_01.angles) * var_02;
	var_03 = var_01.cover_drone_wheels[param_00] maps\_shg_utility::get_differentiated_speed();
	return var_03;
}

//Function Number: 35
input_cdrn_ball_joint_pitch_rate()
{
	var_00 = input_cdrn_ball_joint_rate(0);
	return var_00;
}

//Function Number: 36
input_cdrn_ball_joint_roll_rate()
{
	var_00 = 0;
	if(input_cdrn_in_use())
	{
		var_00 = input_cdrn_ball_joint_rate(2);
		if(abs(var_00) < 1)
		{
			var_00 = 0;
		}
	}

	return var_00;
}

//Function Number: 37
input_cdrn_ball_joint_rate(param_00)
{
	var_01 = soundscripts\_audio_vehicle_manager::avmx_get_vehicle_entity();
	var_02 = gettime();
	if(!isdefined(var_01.ball_joint_last_update_msec))
	{
		var_01.ball_joint_last_update_msec = var_02;
		var_01.ball_joint_last_angles = var_01.angles;
		var_01.ball_joint_angles_rate = (0,0,0);
	}
	else if(var_01.ball_joint_last_update_msec != var_02)
	{
		var_03 = var_02 - var_01.ball_joint_last_update_msec * 0.001;
		var_01.ball_joint_last_update_msec = var_02;
		var_04 = (clamp(angleclamp180(var_01.angles[0]),-20,20),0,clamp(angleclamp180(var_01.angles[2]),-10,10));
		var_05 = var_04 - var_01.ball_joint_last_angles;
		var_05 = (angleclamp180(var_05[0]),angleclamp180(var_05[1]),angleclamp180(var_05[2]));
		var_01.ball_joint_last_angles = var_01.angles;
		var_01.ball_joint_angles_rate = var_05 / var_03;
	}

	return var_01.ball_joint_angles_rate[param_00];
}

//Function Number: 38
input_cdrn_stuck_amount()
{
	return 0;
}

//Function Number: 39
cdrn_wheel_speed_modifier_callback_linear(param_00,param_01)
{
	if(!isdefined(param_01.wheel_speed_modifier))
	{
		param_01.wheel_speed_modifier = spawnstruct();
		param_01.wheel_speed_modifier.scalar_actual = 1;
		param_01.wheel_speed_modifier.scalar_target = 1;
		param_01.wheel_speed_modifier.start_time = 0;
		param_01.wheel_speed_modifier.curr_time = 0;
		param_01.wheel_speed_modifier.total_time = 0;
		param_01.wheel_speed_modifier.dt = soundscripts\_audio_vehicle_manager::avm_get_update_rate();
		param_01.wheel_speed_modifier.total_dist = 0;
		param_01.wheel_speed_modifier.g_dx = 0;
		param_01.wheel_speed_modifier.frac = 0;
	}

	var_02 = param_01.wheel_speed_modifier;
	var_02.curr_time = gettime() / 1000;
	if(var_02.curr_time >= var_02.start_time + var_02.dt)
	{
		var_02.start_time = var_02.curr_time;
		var_02.scalar_actual = 1;
		var_02.scalar_target = randomfloatrange(0.4,1.2);
		var_02.total_time = randomfloatrange(0.5,2);
		var_02.total_dist = var_02.scalar_target - var_02.scalar_actual;
		var_02.frac = var_02.dt / var_02.total_time;
		var_02.g_dx = var_02.frac * var_02.total_dist;
	}

	var_02.scalar_actual = var_02.scalar_actual + var_02.g_dx;
	return param_00 * var_02.scalar_actual;
}

//Function Number: 40
cdrn_auto_unlink()
{
}