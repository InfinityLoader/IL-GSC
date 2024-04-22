/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: _littlebird_aud.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 10
 * Decompile Time: 154 ms
 * Timestamp: 4/22/2024 2:05:04 AM
*******************************************************************/

//Function Number: 1
handle_littlebird_audio()
{
	self endon("death");
	soundscripts\_snd::snd_message("rec_littlebird_formation_spawn",self);
	if(issubstr(self.classname,"sentinel") || issubstr(self.classname,"armed") || issubstr(self.classname,"atlas_bench"))
	{
		var_00 = 0.25;
		if(level.currentgen)
		{
			var_00 = 1;
		}

		var_01 = 0;
		var_02 = 0;
		var_03 = spawnstruct();
		var_03.preset_name = "littlebird_sentinel";
		var_03.fadein_time = 3;
		var_03.fadeout_time = 3;
		soundscripts\_snd::snd_message("snd_register_vehicle","littlebird_sentinel",::littlebird_sentinel_constructor);
		for(;;)
		{
			var_04 = distance(self.origin,level.player.origin);
			if(!var_01 && var_04 < 5400)
			{
				soundscripts\_snd::snd_message("snd_start_vehicle",var_03);
				var_01 = 1;
				continue;
			}

			if(var_01 && var_04 > 5400)
			{
				soundscripts\_snd::snd_message("snd_stop_vehicle");
				var_01 = 0;
			}

			wait(var_00);
		}
	}
}

//Function Number: 2
littlebird_sentinel_constructor()
{
	var_00 = undefined;
	var_01 = 1;
	var_02 = 1;
	soundscripts\_audio_vehicle_manager::avm_begin_preset_def("littlebird_sentinel");
	soundscripts\_audio_vehicle_manager::avm_begin_loop_data(var_00,var_01,var_02);
	soundscripts\_audio_vehicle_manager::avm_begin_loop_def("lbs_near");
	soundscripts\_audio_vehicle_manager::avm_begin_param_map("DISTANCE");
	soundscripts\_audio_vehicle_manager::avm_add_param_map_env("volume","lbs_near_dist2vol");
	soundscripts\_audio_vehicle_manager::avm_end_param_map();
	soundscripts\_audio_vehicle_manager::avm_begin_param_map("pitch");
	soundscripts\_audio_vehicle_manager::avm_add_param_map_env("volume","lbs_near_pch2vol");
	soundscripts\_audio_vehicle_manager::avm_end_param_map();
	soundscripts\_audio_vehicle_manager::avm_begin_param_map("DOPPLER");
	soundscripts\_audio_vehicle_manager::avm_add_param_map_env("pitch","lbs_dplr2pch");
	soundscripts\_audio_vehicle_manager::avm_end_param_map();
	soundscripts\_audio_vehicle_manager::avm_end_loop_def();
	soundscripts\_audio_vehicle_manager::avm_begin_loop_def("lbs_far");
	soundscripts\_audio_vehicle_manager::avm_begin_param_map("DISTANCE");
	soundscripts\_audio_vehicle_manager::avm_add_param_map_env("volume","lbs_far_dist2vol");
	soundscripts\_audio_vehicle_manager::avm_end_param_map();
	soundscripts\_audio_vehicle_manager::avm_begin_param_map("pitch");
	soundscripts\_audio_vehicle_manager::avm_add_param_map_env("volume","lbs_far_pch2vol");
	soundscripts\_audio_vehicle_manager::avm_end_param_map();
	soundscripts\_audio_vehicle_manager::avm_begin_param_map("DOPPLER");
	soundscripts\_audio_vehicle_manager::avm_add_param_map_env("pitch","lbs_dplr2pch");
	soundscripts\_audio_vehicle_manager::avm_end_param_map();
	soundscripts\_audio_vehicle_manager::avm_end_loop_def();
	soundscripts\_audio_vehicle_manager::avm_begin_loop_def("lbs_pitch");
	soundscripts\_audio_vehicle_manager::avm_begin_param_map("pitch");
	soundscripts\_audio_vehicle_manager::avm_add_param_map_env("volume","lbs_pitch_pch2vol");
	soundscripts\_audio_vehicle_manager::avm_end_param_map();
	soundscripts\_audio_vehicle_manager::avm_begin_param_map("DOPPLER");
	soundscripts\_audio_vehicle_manager::avm_add_param_map_env("pitch","lbs_dplr2pch");
	soundscripts\_audio_vehicle_manager::avm_end_param_map();
	soundscripts\_audio_vehicle_manager::avm_end_loop_def();
	soundscripts\_audio_vehicle_manager::avm_end_loop_data();
	soundscripts\_audio_vehicle_manager::avm_begin_oneshot_data();
	soundscripts\_audio_vehicle_manager::avm_end_oneshot_data();
	soundscripts\_audio_vehicle_manager::avm_begin_behavior_data();
	soundscripts\_audio_vehicle_manager::avm_begin_behavior_def("to_state_hover",::lbs_condition_callback_to_state_hover,["speed","distance2d"]);
	soundscripts\_audio_vehicle_manager::avm_add_loops("ALL");
	soundscripts\_audio_vehicle_manager::avm_end_behavior_def();
	soundscripts\_audio_vehicle_manager::avm_begin_behavior_def("to_state_flying",::lbs_condition_callback_to_state_flying,["speed","distance2d"]);
	soundscripts\_audio_vehicle_manager::avm_add_loops("ALL");
	soundscripts\_audio_vehicle_manager::avm_end_behavior_def();
	soundscripts\_audio_vehicle_manager::avm_begin_behavior_def("to_state_distant",::lbs_condition_callback_to_state_distant,["distance2d"]);
	soundscripts\_audio_vehicle_manager::avm_add_loops("ALL");
	soundscripts\_audio_vehicle_manager::avm_end_behavior_def();
	soundscripts\_audio_vehicle_manager::avm_begin_behavior_def("to_state_flyby",::lbs_condition_callback_to_state_flyby,["distance2d"]);
	soundscripts\_audio_vehicle_manager::avm_add_loops("ALL");
	soundscripts\_audio_vehicle_manager::avm_end_behavior_def();
	soundscripts\_audio_vehicle_manager::avm_begin_behavior_def("to_state_deathspin",::lbs_condition_callback_to_state_deathspin);
	soundscripts\_audio_vehicle_manager::avm_add_loops("NONE");
	soundscripts\_audio_vehicle_manager::avm_end_behavior_def();
	soundscripts\_audio_vehicle_manager::avm_begin_behavior_def("to_state_destruct",::lbs_condition_callback_to_state_destruct);
	soundscripts\_audio_vehicle_manager::avm_add_loops("NONE");
	soundscripts\_audio_vehicle_manager::avm_end_behavior_def();
	soundscripts\_audio_vehicle_manager::avm_begin_behavior_def("to_state_off",::lbs_condition_callback_to_state_off);
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
	var_03 = 0;
	var_04 = 10;
	var_05 = 30;
	var_06 = var_05 - var_03;
	var_07 = soundscripts\_audio_vehicle_manager::yards2units(0);
	var_08 = soundscripts\_audio_vehicle_manager::yards2units(99.00001);
	var_09 = var_08 - var_07;
	var_0A = 0;
	var_0B = 1;
	var_0C = var_0B - var_0A;
	var_0D = soundscripts\_audio_vehicle_manager::yards2units(10);
	var_0E = soundscripts\_audio_vehicle_manager::yards2units(30);
	var_0F = soundscripts\_audio_vehicle_manager::yards2units(1000000);
	var_10 = var_0F - var_0D;
	var_11 = 0;
	var_12 = 1;
	var_13 = var_12 - var_11;
	var_14 = -25;
	var_15 = 0;
	var_16 = 25;
	var_17 = soundscripts\_audio_vehicle_manager::yards2units(0);
	var_18 = soundscripts\_audio_vehicle_manager::yards2units(75);
	var_19 = var_18 - var_17;
	var_1A = 0;
	var_1B = 1;
	var_1C = var_1B - var_1A;
	var_1D = 0.6;
	var_1E = 1;
	var_1F = 1.6;
	var_20 = soundscripts\_audio_vehicle_manager::yards2units(0);
	var_21 = soundscripts\_audio_vehicle_manager::yards2units(150);
	var_22 = var_18 - var_17;
	var_23 = 0;
	var_24 = 0.4;
	var_25 = var_1B - var_1A;
	var_26 = 0;
	var_27 = 0.5;
	var_28 = var_1B - var_1A;
	var_29 = var_17;
	var_2A = var_18;
	var_2B = 0;
	var_2C = 1;
	var_2D = var_2C - var_2B;
	var_2E = 1;
	var_2F = 2;
	var_30 = var_2F - var_2E;
	var_31 = 30;
	var_32 = 0;
	var_33 = 1;
	var_34 = 0.5;
	var_35 = 1.5;
	var_36 = 100;
	var_37 = 200;
	var_38 = 500;
	var_39 = 6;
	soundscripts\_audio_vehicle_manager::avm_add_envelope("lbs_near_dist2vol",[[var_07,1],[var_08,0]]);
	soundscripts\_audio_vehicle_manager::avm_add_envelope("lbs_far_dist2vol",[[var_0D,0],[var_0E,1],[var_0F,1]]);
	soundscripts\_audio_vehicle_manager::avm_add_envelope("lbs_near_pch2vol",[[var_14,0.2],[var_15,1],[var_16,0.2]]);
	soundscripts\_audio_vehicle_manager::avm_add_envelope("lbs_far_pch2vol",[[var_14,0.2],[var_15,1],[var_16,0.2]]);
	soundscripts\_audio_vehicle_manager::avm_add_envelope("lbs_pitch_pch2vol",[[var_14,1],[var_15,0],[var_16,1]]);
	soundscripts\_audio_vehicle_manager::avm_add_envelope("lbs_live_dist2vol",[[var_17,1],[var_18,0]]);
	soundscripts\_audio_vehicle_manager::avm_add_envelope("lbs_dist_far_dist2vol",[[var_20,0],[var_21 * 0.333,0.333],[var_21,0]]);
	soundscripts\_audio_vehicle_manager::avm_add_envelope("lbs_live1_accel2pch",[[var_26,0.9],[var_27,1.1]]);
	soundscripts\_audio_vehicle_manager::avm_add_envelope("lbs_live1_accel2vol",[[var_26,0],[var_27,1]]);
	soundscripts\_audio_vehicle_manager::avm_add_envelope("lbs_live1_dst2vol",[[var_29,var_2C],[var_2A,var_2B]]);
	soundscripts\_audio_vehicle_manager::avm_add_envelope("lbs_flyby_vel2vol",[[var_03,var_32],[var_06 * 0.25,var_33 * 0.5],[var_05,var_33]]);
	soundscripts\_audio_vehicle_manager::avm_add_envelope("lbs_flyby_vel2pch",[[var_03,var_34],[var_05,var_35]]);
	soundscripts\_audio_vehicle_manager::avm_add_envelope("lbs_dplr2pch",[[0,0],[2,2]]);
	soundscripts\_audio_vehicle_manager::avm_add_envelope("lbs_dplr2vol",[[var_1D,var_1B],[var_1E,var_1A],[var_1F,var_1B]]);
	soundscripts\_audio_vehicle_manager::avm_add_envelope("lbs_flyby_duck_envelope",[[0,1],[0.4,0.7],[0.6,0.5],[0.8,0.7],[1,1]]);
	soundscripts\_audio_vehicle_manager::avm_end_preset_def();
}

//Function Number: 3
lbs_condition_callback_to_state_off()
{
	return 0;
}

//Function Number: 4
lbs_condition_callback_to_state_hover(param_00,param_01)
{
	var_02 = 0;
	var_03 = param_00["speed"];
	var_04 = param_00["distance2d"];
	var_05 = soundscripts\_audio_vehicle_manager::units2yards(var_04);
	if(var_03 <= 5.1 && var_05 < 100)
	{
		var_02 = 1;
	}

	return var_02;
}

//Function Number: 5
lbs_condition_callback_to_state_flying(param_00,param_01)
{
	var_02 = 0;
	var_03 = param_00["speed"];
	var_04 = param_00["distance2d"];
	var_05 = soundscripts\_audio_vehicle_manager::units2yards(var_04);
	if(var_03 > 5.1 && var_05 < 100)
	{
		var_02 = 1;
	}

	return var_02;
}

//Function Number: 6
lbs_condition_callback_to_state_distant(param_00,param_01)
{
	var_02 = 0;
	var_03 = param_00["distance2d"];
	var_04 = soundscripts\_audio_vehicle_manager::units2yards(var_03);
	if(var_04 >= 100)
	{
		var_02 = 1;
	}

	return var_02;
}

//Function Number: 7
lbs_condition_callback_to_state_flyby(param_00,param_01)
{
	var_02 = 0;
	var_03 = param_00["distance2d"];
	var_04 = soundscripts\_audio_vehicle_manager::units2yards(var_03);
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

//Function Number: 8
lbs_condition_callback_to_state_flyover(param_00,param_01)
{
	var_02 = 0;
	var_03 = param_00["distance2d"];
	var_04 = param_00["relative_speed"];
	var_05 = soundscripts\_audio_vehicle_manager::units2yards(var_03);
	if(var_05 < 30)
	{
		var_02 = 1;
	}

	return var_02;
}

//Function Number: 9
lbs_condition_callback_to_state_deathspin(param_00,param_01)
{
	return 0;
}

//Function Number: 10
lbs_condition_callback_to_state_destruct(param_00,param_01)
{
	return 0;
}