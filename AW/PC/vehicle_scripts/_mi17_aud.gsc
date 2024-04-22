/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: _mi17_aud.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 10
 * Decompile Time: 157 ms
 * Timestamp: 4/22/2024 2:05:06 AM
*******************************************************************/

//Function Number: 1
snd_init_mi17()
{
	soundscripts\_audio_vehicle_manager::avm_register_callback("facing",::mi17_input_callback_facing);
	soundscripts\_audio_vehicle_manager::avm_register_callback("about_to_unload",::mi17_input_callback_about_to_unload);
	soundscripts\_snd::snd_message("snd_register_vehicle","mi17",::snd_mi17_constructor);
}

//Function Number: 2
snd_start_mi17()
{
	if(isdefined(self.snd_instance))
	{
		wait(1);
		snd_stop_mi17(1);
	}

	thread snd_monitor_about_to_unload();
	var_00 = spawnstruct();
	var_00.preset_name = "mi17";
	soundscripts\_snd::snd_message("snd_start_vehicle",var_00);
}

//Function Number: 3
snd_stop_mi17(param_00)
{
	if(isdefined(self.snd_instance))
	{
		soundscripts\_snd::snd_message("snd_stop_vehicle",param_00);
		self notify("snd_stop_vehicle");
	}
}

//Function Number: 4
snd_monitor_about_to_unload()
{
	self endon("death");
	self endon("snd_stop_vehicle");
	for(;;)
	{
		self waittill("about_to_unload");
		self.about_to_unload = 1;
		self waittill("unloaded");
		self.about_to_unload = undefined;
	}
}

//Function Number: 5
snd_mi17_constructor()
{
	soundscripts\_audio_vehicle_manager::avm_begin_preset_def("mi17");
	soundscripts\_audio_vehicle_manager::avm_begin_loop_data();
	soundscripts\_audio_vehicle_manager::avm_begin_loop_def("mi17_dist_towards_lp");
	soundscripts\_audio_vehicle_manager::avm_begin_param_map("facing",0.65,0.65);
	soundscripts\_audio_vehicle_manager::avm_add_param_map_env("volume","mi17_towards_facing2vol","mi17_towards_facing2vol");
	soundscripts\_audio_vehicle_manager::avm_end_param_map();
	soundscripts\_audio_vehicle_manager::avm_end_loop_def();
	soundscripts\_audio_vehicle_manager::avm_begin_loop_def("mi17_dist_away_lp");
	soundscripts\_audio_vehicle_manager::avm_begin_param_map("facing",0.65,0.65);
	soundscripts\_audio_vehicle_manager::avm_add_param_map_env("volume","mi17_away_facing2vol","mi17_away_facing2vol");
	soundscripts\_audio_vehicle_manager::avm_end_param_map();
	soundscripts\_audio_vehicle_manager::avm_end_loop_def();
	soundscripts\_audio_vehicle_manager::avm_begin_loop_def("mi17_close_towards_lp");
	soundscripts\_audio_vehicle_manager::avm_begin_param_map("facing",0.65,0.65);
	soundscripts\_audio_vehicle_manager::avm_add_param_map_env("volume","mi17_towards_facing2vol","mi17_towards_facing2vol");
	soundscripts\_audio_vehicle_manager::avm_end_param_map();
	soundscripts\_audio_vehicle_manager::avm_end_loop_def();
	soundscripts\_audio_vehicle_manager::avm_begin_loop_def("mi17_close_away_lp");
	soundscripts\_audio_vehicle_manager::avm_begin_param_map("facing",0.65,0.65);
	soundscripts\_audio_vehicle_manager::avm_add_param_map_env("volume","mi17_away_facing2vol","mi17_away_facing2vol");
	soundscripts\_audio_vehicle_manager::avm_end_param_map();
	soundscripts\_audio_vehicle_manager::avm_end_loop_def();
	soundscripts\_audio_vehicle_manager::avm_end_loop_data();
	soundscripts\_audio_vehicle_manager::avm_begin_oneshot_data(0.5);
	soundscripts\_audio_vehicle_manager::avm_begin_oneshot_def("mi17_by_in","mi17_noduck");
	soundscripts\_audio_vehicle_manager::avm_end_oneshot_def();
	soundscripts\_audio_vehicle_manager::avm_begin_oneshot_def("mi17_by_windup","mi17_noduck");
	soundscripts\_audio_vehicle_manager::avm_end_oneshot_def();
	soundscripts\_audio_vehicle_manager::avm_begin_oneshot_def("mi17_by_out","mi17_noduck");
	soundscripts\_audio_vehicle_manager::avm_end_oneshot_def();
	soundscripts\_audio_vehicle_manager::avm_end_oneshot_data();
	soundscripts\_audio_vehicle_manager::avm_begin_behavior_data();
	soundscripts\_audio_vehicle_manager::avm_begin_behavior_def("to_state_hover_initial",::mi17_condition_callback_to_hover);
	soundscripts\_audio_vehicle_manager::avm_add_loops("ALL");
	soundscripts\_audio_vehicle_manager::avm_begin_param_map("speed",0.65,0.65);
	soundscripts\_audio_vehicle_manager::avm_end_param_map();
	soundscripts\_audio_vehicle_manager::avm_begin_param_map("about_to_unload",1,1);
	soundscripts\_audio_vehicle_manager::avm_end_param_map();
	soundscripts\_audio_vehicle_manager::avm_end_behavior_def();
	soundscripts\_audio_vehicle_manager::avm_begin_behavior_def("to_state_hover",::mi17_condition_callback_to_hover);
	soundscripts\_audio_vehicle_manager::avm_add_oneshots("mi17_by_in");
	soundscripts\_audio_vehicle_manager::avm_begin_param_map("speed",0.65,0.65);
	soundscripts\_audio_vehicle_manager::avm_end_param_map();
	soundscripts\_audio_vehicle_manager::avm_begin_param_map("about_to_unload",1,1);
	soundscripts\_audio_vehicle_manager::avm_end_param_map();
	soundscripts\_audio_vehicle_manager::avm_end_behavior_def();
	soundscripts\_audio_vehicle_manager::avm_begin_behavior_def("to_state_fly_from_hover_initial",::mi17_condition_callback_to_fly);
	soundscripts\_audio_vehicle_manager::avm_add_loops("ALL");
	soundscripts\_audio_vehicle_manager::avm_begin_param_map("speed",0.65,0.65);
	soundscripts\_audio_vehicle_manager::avm_end_param_map();
	soundscripts\_audio_vehicle_manager::avm_begin_param_map("about_to_unload",1,1);
	soundscripts\_audio_vehicle_manager::avm_end_param_map();
	soundscripts\_audio_vehicle_manager::avm_end_behavior_def();
	soundscripts\_audio_vehicle_manager::avm_begin_behavior_def("to_state_fly_from_hover",::mi17_condition_callback_to_fly);
	soundscripts\_audio_vehicle_manager::avm_add_oneshots("mi17_by_windup");
	soundscripts\_audio_vehicle_manager::avm_begin_param_map("speed",0.65,0.65);
	soundscripts\_audio_vehicle_manager::avm_end_param_map();
	soundscripts\_audio_vehicle_manager::avm_begin_param_map("about_to_unload",1,1);
	soundscripts\_audio_vehicle_manager::avm_end_param_map();
	soundscripts\_audio_vehicle_manager::avm_end_behavior_def();
	soundscripts\_audio_vehicle_manager::avm_begin_behavior_def("to_state_fly_from_flyby",::mi17_condition_callback_to_fly);
	soundscripts\_audio_vehicle_manager::avm_begin_param_map("speed",0.65,0.65);
	soundscripts\_audio_vehicle_manager::avm_end_param_map();
	soundscripts\_audio_vehicle_manager::avm_begin_param_map("about_to_unload",1,1);
	soundscripts\_audio_vehicle_manager::avm_end_param_map();
	soundscripts\_audio_vehicle_manager::avm_end_behavior_def();
	soundscripts\_audio_vehicle_manager::avm_begin_behavior_def("to_state_flyby",::mi17_condition_callback_to_flyby);
	soundscripts\_audio_vehicle_manager::avm_add_oneshots("mi17_by_out");
	soundscripts\_audio_vehicle_manager::avm_begin_param_map("speed",0.65,0.65);
	soundscripts\_audio_vehicle_manager::avm_end_param_map();
	soundscripts\_audio_vehicle_manager::avm_begin_param_map("about_to_unload",1,1);
	soundscripts\_audio_vehicle_manager::avm_end_param_map();
	soundscripts\_audio_vehicle_manager::avm_begin_param_map("facing",1,1);
	soundscripts\_audio_vehicle_manager::avm_end_param_map();
	soundscripts\_audio_vehicle_manager::avm_end_behavior_def();
	soundscripts\_audio_vehicle_manager::avm_end_behavior_data();
	soundscripts\_audio_vehicle_manager::avm_begin_state_data();
	soundscripts\_audio_vehicle_manager::avm_begin_state_group("engine_oneshots","state_hover_initial","to_state_hover_initial",50,1);
	soundscripts\_audio_vehicle_manager::avm_begin_state_def("state_hover_initial",0);
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("state_fly","to_state_fly_from_hover");
	soundscripts\_audio_vehicle_manager::avm_end_state_def();
	soundscripts\_audio_vehicle_manager::avm_begin_state_def("state_hover",0);
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("state_fly","to_state_fly_from_hover");
	soundscripts\_audio_vehicle_manager::avm_end_state_def();
	soundscripts\_audio_vehicle_manager::avm_begin_state_def("state_fly",0);
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("state_hover","to_state_hover");
	soundscripts\_audio_vehicle_manager::avm_end_state_def();
	soundscripts\_audio_vehicle_manager::avm_end_state_group();
	soundscripts\_audio_vehicle_manager::avm_begin_state_group("flyby","flyby_1","to_state_flyby",50,1);
	soundscripts\_audio_vehicle_manager::avm_begin_state_def("flyby_1",0,50);
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("flyby_2","to_state_flyby");
	soundscripts\_audio_vehicle_manager::avm_end_state_def();
	soundscripts\_audio_vehicle_manager::avm_begin_state_def("flyby_2",0,50);
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("flyby_1","to_state_flyby");
	soundscripts\_audio_vehicle_manager::avm_end_state_def();
	soundscripts\_audio_vehicle_manager::avm_end_state_group();
	soundscripts\_audio_vehicle_manager::avm_end_state_data();
	soundscripts\_audio_vehicle_manager::avm_add_envelope("mi17_towards_facing2vol",[[-0.5,0.35],[0.5,0.7]]);
	soundscripts\_audio_vehicle_manager::avm_add_envelope("mi17_away_facing2vol",[[-0.5,0.7],[0.5,0.175]]);
	soundscripts\_audio_vehicle_manager::avm_add_envelope("mi17_noduck",[[0,1],[1,1]]);
	soundscripts\_audio_vehicle_manager::avm_end_preset_def();
}

//Function Number: 6
mi17_input_callback_facing()
{
	var_00 = soundscripts\_audio_vehicle_manager::avmx_get_vehicle_entity();
	var_01 = anglestoforward(var_00.angles);
	var_02 = vectornormalize(level.player.origin - var_00.origin);
	var_03 = vectordot(var_01,var_02);
	return var_03;
}

//Function Number: 7
mi17_input_callback_about_to_unload()
{
	var_00 = soundscripts\_audio_vehicle_manager::avmx_get_vehicle_entity();
	return isdefined(var_00.about_to_unload);
}

//Function Number: 8
mi17_condition_callback_to_hover(param_00,param_01)
{
	var_02 = param_00["speed"];
	var_03 = param_00["about_to_unload"];
	if(var_03 > 0.5 || var_02 < 5)
	{
		return 1;
	}

	return 0;
}

//Function Number: 9
mi17_condition_callback_to_fly(param_00,param_01)
{
	var_02 = param_00["speed"];
	var_03 = param_00["about_to_unload"];
	var_04 = 0;
	if(var_03 < 0.5 && var_02 >= 5)
	{
		return 1;
	}

	return 0;
}

//Function Number: 10
mi17_condition_callback_to_flyby(param_00,param_01)
{
	var_02 = param_00["speed"];
	var_03 = param_00["about_to_unload"];
	var_04 = param_00["facing"];
	var_05 = 0;
	if(!isdefined(param_01.last_flyby_time))
	{
		param_01.last_flyby_time = 0;
	}

	if(isdefined(param_01.last_facing))
	{
		var_06 = gettime();
		if(param_01.last_facing >= 0 && var_04 < 0 && var_03 < 0.5 && var_02 > 5 && var_06 - param_01.last_flyby_time > 3000)
		{
			param_01.last_flyby_time = var_06;
			var_05 = 1;
		}
	}

	param_01.last_facing = var_04;
	return var_05;
}