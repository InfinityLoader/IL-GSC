/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: _pitbull_aud.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 15
 * Decompile Time: 253 ms
 * Timestamp: 4/22/2024 2:05:27 AM
*******************************************************************/

//Function Number: 1
snd_pitbull_constructor()
{
	soundscripts\_audio_vehicle_manager::avm_register_callback("throttle",::soundscripts\_audio_vehicle_manager::input_callback_throttle);
	soundscripts\_audio_vehicle_manager::avm_begin_preset_def("pitbull",::pbull_init);
	soundscripts\_audio_vehicle_manager::avm_begin_loop_data();
	soundscripts\_audio_vehicle_manager::avm_begin_loop_def("pbull_rpm_idle_lp");
	soundscripts\_audio_vehicle_manager::avm_begin_param_map("speed");
	soundscripts\_audio_vehicle_manager::avm_add_param_map_env("volume","pbull_rpm_idle_vol_map");
	soundscripts\_audio_vehicle_manager::avm_end_param_map();
	soundscripts\_audio_vehicle_manager::avm_end_loop_def();
	soundscripts\_audio_vehicle_manager::avm_begin_loop_def("pbull_rpm_hi_lp");
	soundscripts\_audio_vehicle_manager::avm_begin_param_map("speed");
	soundscripts\_audio_vehicle_manager::avm_add_param_map_env("volume","pbull_rpm_hi_vol_map");
	soundscripts\_audio_vehicle_manager::avm_end_param_map();
	soundscripts\_audio_vehicle_manager::avm_end_loop_def();
	soundscripts\_audio_vehicle_manager::avm_begin_loop_def("pbull_int_sus_lp");
	soundscripts\_audio_vehicle_manager::avm_begin_param_map("speed");
	soundscripts\_audio_vehicle_manager::avm_add_param_map_env("volume","pbull_int_sus_lo_vol_map");
	soundscripts\_audio_vehicle_manager::avm_end_param_map();
	soundscripts\_audio_vehicle_manager::avm_end_loop_def();
	soundscripts\_audio_vehicle_manager::avm_begin_loop_def("pbull_reverse_lp");
	soundscripts\_audio_vehicle_manager::avm_begin_param_map("speed");
	soundscripts\_audio_vehicle_manager::avm_add_param_map_env("volume","pbull_reverse_loop_vol_map");
	soundscripts\_audio_vehicle_manager::avm_end_param_map();
	soundscripts\_audio_vehicle_manager::avm_end_loop_def();
	soundscripts\_audio_vehicle_manager::avm_end_loop_data();
	soundscripts\_audio_vehicle_manager::avm_begin_oneshot_data();
	soundscripts\_audio_vehicle_manager::avm_begin_oneshot_def("pbull_rev_low_to_hi",undefined,0.75,1);
	soundscripts\_audio_vehicle_manager::avm_begin_param_map("speed",1,1);
	soundscripts\_audio_vehicle_manager::avm_add_param_map_env("volume","dummy_map");
	soundscripts\_audio_vehicle_manager::avm_end_param_map();
	soundscripts\_audio_vehicle_manager::avm_end_oneshot_def();
	soundscripts\_audio_vehicle_manager::avm_begin_oneshot_def("pbull_rev_med_to_hi",undefined,0.75,1);
	soundscripts\_audio_vehicle_manager::avm_begin_param_map("speed",1,1);
	soundscripts\_audio_vehicle_manager::avm_add_param_map_env("volume","dummy_map");
	soundscripts\_audio_vehicle_manager::avm_end_param_map();
	soundscripts\_audio_vehicle_manager::avm_end_oneshot_def();
	soundscripts\_audio_vehicle_manager::avm_begin_oneshot_def("pbull_rev_hi_to_max",undefined,0.75,1);
	soundscripts\_audio_vehicle_manager::avm_begin_param_map("speed",1,1);
	soundscripts\_audio_vehicle_manager::avm_add_param_map_env("volume","dummy_map");
	soundscripts\_audio_vehicle_manager::avm_end_param_map();
	soundscripts\_audio_vehicle_manager::avm_end_oneshot_def();
	soundscripts\_audio_vehicle_manager::avm_begin_oneshot_def("pbull_brakes_med",undefined,0.75,1);
	soundscripts\_audio_vehicle_manager::avm_begin_param_map("speed",1,1);
	soundscripts\_audio_vehicle_manager::avm_add_param_map_env("volume","dummy_map");
	soundscripts\_audio_vehicle_manager::avm_end_param_map();
	soundscripts\_audio_vehicle_manager::avm_end_oneshot_def();
	soundscripts\_audio_vehicle_manager::avm_begin_oneshot_def("pbull_int_brake_pedal",undefined,0.75,1);
	soundscripts\_audio_vehicle_manager::avm_begin_param_map("speed",1,1);
	soundscripts\_audio_vehicle_manager::avm_add_param_map_env("volume","dummy_map");
	soundscripts\_audio_vehicle_manager::avm_end_param_map();
	soundscripts\_audio_vehicle_manager::avm_end_oneshot_def();
	soundscripts\_audio_vehicle_manager::avm_begin_oneshot_def("blank_oneshot",undefined,0.75,1);
	soundscripts\_audio_vehicle_manager::avm_begin_param_map("speed",1,1);
	soundscripts\_audio_vehicle_manager::avm_add_param_map_env("volume","dummy_map");
	soundscripts\_audio_vehicle_manager::avm_end_param_map();
	soundscripts\_audio_vehicle_manager::avm_end_oneshot_def();
	soundscripts\_audio_vehicle_manager::avm_begin_oneshot_def("pbull_reverse",undefined,0.75,0);
	soundscripts\_audio_vehicle_manager::avm_begin_param_map("speed",1,1);
	soundscripts\_audio_vehicle_manager::avm_add_param_map_env("volume","dummy_map");
	soundscripts\_audio_vehicle_manager::avm_end_param_map();
	soundscripts\_audio_vehicle_manager::avm_end_oneshot_def();
	soundscripts\_audio_vehicle_manager::avm_begin_oneshot_def("pbull_decel_to_idle",undefined,0.75,1);
	soundscripts\_audio_vehicle_manager::avm_begin_param_map("speed",1,1);
	soundscripts\_audio_vehicle_manager::avm_add_param_map_env("volume","dummy_map");
	soundscripts\_audio_vehicle_manager::avm_end_param_map();
	soundscripts\_audio_vehicle_manager::avm_end_oneshot_def();
	soundscripts\_audio_vehicle_manager::avm_end_oneshot_data();
	soundscripts\_audio_vehicle_manager::avm_begin_behavior_data();
	soundscripts\_audio_vehicle_manager::avm_begin_behavior_def("from_any_to_gas_off",::pbull_callback_gas_off,["speed"]);
	soundscripts\_audio_vehicle_manager::avm_add_loops("ALL");
	soundscripts\_audio_vehicle_manager::avm_add_oneshots("pbull_decel_to_idle");
	soundscripts\_audio_vehicle_manager::avm_end_behavior_def();
	soundscripts\_audio_vehicle_manager::avm_begin_behavior_def("from_any_to_crash",::pbull_callback_crash,["speed"]);
	soundscripts\_audio_vehicle_manager::avm_add_loops("ALL");
	soundscripts\_audio_vehicle_manager::avm_add_oneshots("pbull_decel_to_idle");
	soundscripts\_audio_vehicle_manager::avm_end_behavior_def();
	soundscripts\_audio_vehicle_manager::avm_begin_behavior_def("from_stopped_to_reverse",::pbull_callback_from_stopped_to_reverse,["speed"]);
	soundscripts\_audio_vehicle_manager::avm_add_loops(["pbull_int_sus_lp","pbull_reverse_lp"]);
	soundscripts\_audio_vehicle_manager::avm_add_oneshots("pbull_reverse");
	soundscripts\_audio_vehicle_manager::avm_end_behavior_def();
	soundscripts\_audio_vehicle_manager::avm_begin_behavior_def("from_reverse_to_reverse_gas_off",::pbull_callback_from_reverse_to_reverse_gas_off,["speed"]);
	soundscripts\_audio_vehicle_manager::avm_add_loops("ALL");
	soundscripts\_audio_vehicle_manager::avm_add_oneshots("pbull_decel_to_idle");
	soundscripts\_audio_vehicle_manager::avm_end_behavior_def();
	soundscripts\_audio_vehicle_manager::avm_begin_behavior_def("from_gas_off_to_rev_low",::pbull_callback_from_gas_off_to_rev_low,["speed"]);
	soundscripts\_audio_vehicle_manager::avm_add_loops("ALL");
	soundscripts\_audio_vehicle_manager::avm_add_oneshots("pbull_rev_low_to_hi");
	soundscripts\_audio_vehicle_manager::avm_end_behavior_def();
	soundscripts\_audio_vehicle_manager::avm_begin_behavior_def("from_gas_off_to_rev_med",::pbull_callback_from_gas_off_to_rev_med,["speed"]);
	soundscripts\_audio_vehicle_manager::avm_add_loops("ALL");
	soundscripts\_audio_vehicle_manager::avm_add_oneshots("pbull_rev_med_to_hi");
	soundscripts\_audio_vehicle_manager::avm_end_behavior_def();
	soundscripts\_audio_vehicle_manager::avm_begin_behavior_def("from_gas_off_to_rev_hi",::pbull_callback_from_gas_off_to_rev_hi,["speed"]);
	soundscripts\_audio_vehicle_manager::avm_add_loops("ALL");
	soundscripts\_audio_vehicle_manager::avm_add_oneshots("pbull_rev_hi_to_max");
	soundscripts\_audio_vehicle_manager::avm_end_behavior_def();
	soundscripts\_audio_vehicle_manager::avm_begin_behavior_def("from_any_to_brakes_med",::pbull_callback_to_brakes_med,["speed"]);
	soundscripts\_audio_vehicle_manager::avm_add_loops("ALL");
	soundscripts\_audio_vehicle_manager::avm_add_oneshots("pbull_brakes_med");
	soundscripts\_audio_vehicle_manager::avm_add_oneshots("pbull_int_brake_pedal");
	soundscripts\_audio_vehicle_manager::avm_end_behavior_def();
	soundscripts\_audio_vehicle_manager::avm_end_behavior_data();
	soundscripts\_audio_vehicle_manager::avm_begin_state_data(0.25,50);
	soundscripts\_audio_vehicle_manager::avm_begin_state_group("main_oneshots","state_gas_off","from_any_to_gas_off",50,1);
	soundscripts\_audio_vehicle_manager::avm_begin_state_def("state_gas_off",0.75,2);
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("state_rev_low","from_gas_off_to_rev_low");
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("state_rev_med","from_gas_off_to_rev_med");
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("state_rev_hi","from_gas_off_to_rev_hi");
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("state_brakes_skid","from_any_to_brakes_med");
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("state_reverse","from_stopped_to_reverse");
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("state_crash","from_any_to_crash");
	soundscripts\_audio_vehicle_manager::avm_end_state_def();
	soundscripts\_audio_vehicle_manager::avm_begin_state_def("state_reverse",0.75,2);
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("state_brakes_skid","from_any_to_brakes_med");
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("state_reverse_gas_off","from_reverse_to_reverse_gas_off");
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("state_crash","from_any_to_crash");
	soundscripts\_audio_vehicle_manager::avm_end_state_def();
	soundscripts\_audio_vehicle_manager::avm_begin_state_def("state_reverse_gas_off",0.75,2);
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("state_rev_low","from_gas_off_to_rev_low");
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("state_rev_med","from_gas_off_to_rev_med");
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("state_rev_hi","from_gas_off_to_rev_hi");
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("state_brakes_skid","from_any_to_brakes_med");
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("state_crash","from_any_to_crash");
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("state_reverse","from_stopped_to_reverse");
	soundscripts\_audio_vehicle_manager::avm_end_state_def();
	soundscripts\_audio_vehicle_manager::avm_begin_state_def("state_rev_low",0.75,3);
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("state_brakes_skid","from_any_to_brakes_med");
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("state_gas_off","from_any_to_gas_off");
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("state_crash","from_any_to_crash");
	soundscripts\_audio_vehicle_manager::avm_end_state_def();
	soundscripts\_audio_vehicle_manager::avm_begin_state_def("state_rev_med",0.75,3);
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("state_brakes_skid","from_any_to_brakes_med");
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("state_gas_off","from_any_to_gas_off");
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("state_crash","from_any_to_crash");
	soundscripts\_audio_vehicle_manager::avm_end_state_def();
	soundscripts\_audio_vehicle_manager::avm_begin_state_def("state_rev_hi",0.75,3);
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("state_brakes_skid","from_any_to_brakes_med");
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("state_gas_off","from_any_to_gas_off");
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("state_crash","from_any_to_crash");
	soundscripts\_audio_vehicle_manager::avm_end_state_def();
	soundscripts\_audio_vehicle_manager::avm_begin_state_def("state_brakes_skid",3.5,1);
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("state_rev_low","from_gas_off_to_rev_low");
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("state_rev_med","from_gas_off_to_rev_med");
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("state_rev_hi","from_gas_off_to_rev_hi");
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("state_gas_off","from_any_to_gas_off");
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("state_crash","from_any_to_crash");
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("state_reverse","from_stopped_to_reverse");
	soundscripts\_audio_vehicle_manager::avm_end_state_def();
	soundscripts\_audio_vehicle_manager::avm_begin_state_def("state_crash",3.5,1);
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("state_rev_low","from_gas_off_to_rev_low");
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("state_rev_med","from_gas_off_to_rev_med");
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("state_rev_hi","from_gas_off_to_rev_hi");
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("state_gas_off","from_any_to_gas_off");
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("state_reverse","from_stopped_to_reverse");
	soundscripts\_audio_vehicle_manager::avm_end_state_def();
	soundscripts\_audio_vehicle_manager::avm_begin_state_def("state_off",3.5,1);
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("state_rev_low","from_gas_off_to_rev_low");
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("state_rev_med","from_gas_off_to_rev_med");
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("state_rev_hi","from_gas_off_to_rev_hi");
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("state_gas_off","from_any_to_gas_off");
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("state_reverse","from_stopped_to_reverse");
	soundscripts\_audio_vehicle_manager::avm_end_state_def();
	soundscripts\_audio_vehicle_manager::avm_end_state_group();
	soundscripts\_audio_vehicle_manager::avm_end_state_data();
	soundscripts\_audio_vehicle_manager::avm_add_envelope("pbull_rpm_idle_vol_map",[[1,0.7],[30,0.45],[63,0]]);
	soundscripts\_audio_vehicle_manager::avm_add_envelope("pbull_rpm_med_vol_map",[[1,0],[40,0.8],[63,0]]);
	soundscripts\_audio_vehicle_manager::avm_add_envelope("pbull_rpm_med_pitch_map",[[1,0.8],[70,1.2]]);
	soundscripts\_audio_vehicle_manager::avm_add_envelope("pbull_rpm_hi_vol_map",[[1,0],[40,0.1],[63,0.3],[70,0.8]]);
	soundscripts\_audio_vehicle_manager::avm_add_envelope("pbull_int_sus_lo_vol_map",[[1,0.1],[40,0.75],[70,0.78]]);
	soundscripts\_audio_vehicle_manager::avm_add_envelope("pbull_reverse_loop_vol_map",[[1,1],[70,1]]);
	soundscripts\_audio_vehicle_manager::avm_add_envelope("dummy_map",[[1,1],[70,1]]);
	soundscripts\_audio_vehicle_manager::avm_add_envelope("pbull_rev_ducks_lp_env",[[0,1],[0.33,0.33],[0.66,0.33],[1.33,1]]);
	soundscripts\_audio_vehicle_manager::avm_end_preset_def();
}

//Function Number: 2
foo_env_function()
{
	return 1;
}

//Function Number: 3
pbull_init(param_00)
{
	var_01 = self;
	var_02 = var_01 soundscripts\_audio_vehicle_manager::avmx_get_vehicle_entity();
	param_00.pbull_is_revving = 0;
	param_00.pbull_is_reversed = 0;
	param_00.pbull_is_upshifting = 0;
	param_00.pbull_is_downshifting = 0;
	param_00.crash = spawnstruct();
	param_00.crash.crash_event = 0;
	param_00.crash.crash_time = undefined;
	param_00.crash.crash_speed = 0;
	var_02 thread pbull_crash_watch(param_00);
	var_02 thread pbull_shift_watch(param_00);
}

//Function Number: 4
pbull_callback_gas_off(param_00,param_01)
{
	var_02 = 0;
	if(param_01.pbull_is_upshifting == 1)
	{
		var_02 = 1;
		param_01.pbull_is_upshifting = 0;
		param_01.pbull_is_revving = 0;
	}
	else
	{
		var_03 = param_00["speed"];
		if(!level.player attackbuttonpressed() && param_01.pbull_is_revving == 1)
		{
			param_01.pbull_is_revving = 0;
			param_01.pbull_is_reversed = 0;
			var_02 = 1;
		}
	}

	return var_02;
}

//Function Number: 5
pbull_callback_to_brakes_med(param_00,param_01)
{
	var_02 = 0;
	var_03 = param_00["speed"];
	if(level.player buttonpressed("BUTTON_B") && var_03 > 20 && !level.player attackbuttonpressed() && !param_01.pbull_is_reversed)
	{
		param_01.pbull_is_revving = 0;
		param_01.pbull_is_reversed = 0;
		var_02 = 1;
	}

	return var_02;
}

//Function Number: 6
pbull_callback_from_gas_off_to_rev_low(param_00,param_01)
{
	var_02 = 0;
	var_03 = param_00["speed"];
	if(level.player attackbuttonpressed() && var_03 < 40 && param_01.pbull_is_revving == 0 && var_03 > 3)
	{
		param_01.pbull_is_revving = 1;
		param_01.pbull_is_reversed = 0;
		var_02 = 1;
	}

	return var_02;
}

//Function Number: 7
pbull_callback_from_gas_off_to_rev_med(param_00,param_01)
{
	var_02 = 0;
	var_03 = param_00["speed"];
	if(level.player attackbuttonpressed() && var_03 > 40 && var_03 < 63 && param_01.pbull_is_revving == 0)
	{
		param_01.pbull_is_revving = 1;
		param_01.pbull_is_reversed = 0;
		var_02 = 1;
	}

	return var_02;
}

//Function Number: 8
pbull_callback_from_gas_off_to_rev_hi(param_00,param_01)
{
	var_02 = 0;
	var_03 = param_00["speed"];
	if(level.player attackbuttonpressed() && var_03 > 63 && var_03 < 67 && param_01.pbull_is_revving == 0)
	{
		param_01.pbull_is_revving = 1;
		param_01.pbull_is_reversed = 0;
		var_02 = 1;
	}

	return var_02;
}

//Function Number: 9
pbull_callback_from_stopped_to_reverse(param_00,param_01)
{
	var_02 = 0;
	var_03 = param_00["speed"];
	if(level.player buttonpressed("BUTTON_B") && var_03 > 0 && !param_01.pbull_is_reversed)
	{
		param_01.pbull_is_reversed = 1;
		thread pbull_play_reverse_beeps(param_01);
		var_02 = 1;
	}

	return var_02;
}

//Function Number: 10
pbull_callback_from_reverse_to_reverse_gas_off(param_00,param_01)
{
	var_02 = 0;
	var_03 = param_00["speed"];
	if(!level.player buttonpressed("BUTTON_B"))
	{
		param_01.pbull_is_revving = 0;
		param_01.pbull_is_reversed = 0;
		var_02 = 1;
	}

	return var_02;
}

//Function Number: 11
pbull_callback_crash(param_00,param_01)
{
	var_02 = 0;
	if(param_01.crash.crash_event == 1)
	{
		if(!isdefined(param_01.crash.crash_time))
		{
			param_01.crash.crash_time = gettime();
			param_01.crash.crash_speed = param_00["speed"];
		}
		else
		{
			var_03 = gettime() - param_01.crash.crash_time;
			if(var_03 > 300)
			{
				var_04 = param_01.crash.crash_speed - param_00["speed"];
				if(var_04 > 3)
				{
					param_01.pbull_is_revving = 0;
					param_01.pbull_is_reversed = 0;
					var_02 = 1;
				}

				param_01.crash.crash_event = 0;
				param_01.crash.crash_time = undefined;
			}
		}
	}

	return var_02;
}

//Function Number: 12
player_pbull_honk()
{
	var_00 = "honk";
	level.player notifyonplayercommand(var_00,"+usereload");
	for(;;)
	{
		level.player waittill(var_00);
		level.player soundscripts\_snd_playsound::snd_play("pbull_honk");
		wait(0.3);
	}
}

//Function Number: 13
pbull_play_reverse_beeps(param_00)
{
	wait(0.5);
	while(param_00.pbull_is_reversed)
	{
		level.player soundscripts\_snd_playsound::snd_play("pbull_reverse_beep");
		wait(1);
	}
}

//Function Number: 14
pbull_crash_watch(param_00,param_01)
{
	for(;;)
	{
		level.player_pitbull waittill("veh_contact",var_02,var_03,var_04,var_05,var_06);
		param_00.crash.crash_event = 1;
	}
}

//Function Number: 15
pbull_shift_watch(param_00)
{
	for(;;)
	{
		self waittill("audio_shift",var_01);
		soundscripts\_snd_playsound::snd_play("pbull_int_shift");
		var_02 = self vehicle_getspeed();
		if(var_01 == "gear_up")
		{
			if(var_02 > 35)
			{
				param_00.pbull_is_upshifting = 1;
				param_00.pbull_is_downshifting = 0;
			}

			continue;
		}

		if(var_01 == "gear_down")
		{
			if(var_02 < 35)
			{
				param_00.pbull_is_upshifting = 0;
				param_00.pbull_is_downshifting = 1;
				soundscripts\_snd_playsound::snd_play("pbull_downshift_to_idle");
			}
		}
	}
}