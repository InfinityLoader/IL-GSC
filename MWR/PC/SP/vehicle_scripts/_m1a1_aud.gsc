/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: vehicle_scripts\_m1a1_aud.gsc
 * Game: Call of Duty: Modern Warfare Remastered
 * Platform: PC
 * Function Count: 8
 * Decompile Time: 138 ms
 * Timestamp: 10/27/2023 2:46:20 AM
*******************************************************************/

//Function Number: 1
snd_init_m1a1()
{
	soundscripts\_audio_vehicle_manager::avm_register_callback("about_to_stop",::m1a1_input_callback_about_to_stop);
	soundscripts\_snd::snd_message("snd_register_vehicle","m1a1",::snd_m1a1_constructor);
}

//Function Number: 2
snd_start_m1a1()
{
	if(isdefined(self.snd_instance))
	{
		wait(1);
		snd_stop_m1a1(1);
	}

	thread snd_monitor_about_to_stop();
	var_00 = spawnstruct();
	var_00.preset_name = "m1a1";
	soundscripts\_snd::snd_message("snd_start_vehicle",var_00);
}

//Function Number: 3
snd_monitor_about_to_stop()
{
	self endon("death");
	self endon("snd_stop_vehicle");
	self waittill("about_to_stop",var_00);
	if(var_00 > 1)
	{
		wait(var_00 - 1);
		if(!isdefined(self))
		{
			return;
		}
	}

	self.about_to_stop = 1;
}

//Function Number: 4
snd_stop_m1a1(param_00)
{
	if(isdefined(self.snd_instance))
	{
		soundscripts\_snd::snd_message("snd_stop_vehicle",param_00);
		self notify("snd_stop_vehicle");
	}
}

//Function Number: 5
snd_m1a1_constructor()
{
	soundscripts\_audio_vehicle_manager::avm_begin_preset_def("m1a1");
	soundscripts\_audio_vehicle_manager::avm_begin_loop_data();
	soundscripts\_audio_vehicle_manager::avm_begin_loop_def("m1a1_abrams_idle_close_loop");
	soundscripts\_audio_vehicle_manager::avm_begin_param_map("speed");
	soundscripts\_audio_vehicle_manager::avm_add_param_map_env("volume","m1a1_idle_vel2vol");
	soundscripts\_audio_vehicle_manager::avm_add_param_map_env("pitch","m1a1_idle_vel2pch");
	soundscripts\_audio_vehicle_manager::avm_end_param_map();
	soundscripts\_audio_vehicle_manager::avm_end_loop_def();
	soundscripts\_audio_vehicle_manager::avm_begin_loop_def("m1a1_abrams_engine_close_loop");
	soundscripts\_audio_vehicle_manager::avm_begin_param_map("speed");
	soundscripts\_audio_vehicle_manager::avm_add_param_map_env("volume","m1a1_engine_vel2vol");
	soundscripts\_audio_vehicle_manager::avm_add_param_map_env("pitch","m1a1_engine_vel2pch");
	soundscripts\_audio_vehicle_manager::avm_end_param_map();
	soundscripts\_audio_vehicle_manager::avm_end_loop_def();
	soundscripts\_audio_vehicle_manager::avm_begin_loop_def("m1a1_abrams_engine_treads_loop");
	soundscripts\_audio_vehicle_manager::avm_begin_param_map("speed");
	soundscripts\_audio_vehicle_manager::avm_add_param_map_env("volume","m1a1_treads_vel2vol");
	soundscripts\_audio_vehicle_manager::avm_add_param_map_env("pitch","m1a1_treads_vel2pch");
	soundscripts\_audio_vehicle_manager::avm_end_param_map();
	soundscripts\_audio_vehicle_manager::avm_end_loop_def();
	soundscripts\_audio_vehicle_manager::avm_begin_loop_def("m1a1_abrams_engine_treads_loop_2");
	soundscripts\_audio_vehicle_manager::avm_begin_param_map("speed");
	soundscripts\_audio_vehicle_manager::avm_add_param_map_env("volume","m1a1_treads_vel2vol");
	soundscripts\_audio_vehicle_manager::avm_add_param_map_env("pitch","m1a1_treads_vel2pch");
	soundscripts\_audio_vehicle_manager::avm_end_param_map();
	soundscripts\_audio_vehicle_manager::avm_end_loop_def();
	soundscripts\_audio_vehicle_manager::avm_end_loop_data();
	soundscripts\_audio_vehicle_manager::avm_begin_oneshot_data(0.5);
	soundscripts\_audio_vehicle_manager::avm_end_oneshot_data();
	soundscripts\_audio_vehicle_manager::avm_begin_behavior_data();
	soundscripts\_audio_vehicle_manager::avm_begin_behavior_def("to_state_idle",::m1a1_condition_callback_to_idle);
	soundscripts\_audio_vehicle_manager::avm_add_loops("ALL");
	soundscripts\_audio_vehicle_manager::avm_begin_param_map("speed",1,1);
	soundscripts\_audio_vehicle_manager::avm_end_param_map();
	soundscripts\_audio_vehicle_manager::avm_begin_param_map("about_to_stop");
	soundscripts\_audio_vehicle_manager::avm_end_param_map();
	soundscripts\_audio_vehicle_manager::avm_end_behavior_def();
	soundscripts\_audio_vehicle_manager::avm_begin_behavior_def("to_state_engine",::m1a1_condition_callback_to_engine);
	soundscripts\_audio_vehicle_manager::avm_add_loops("ALL");
	soundscripts\_audio_vehicle_manager::avm_begin_param_map("speed",1,1);
	soundscripts\_audio_vehicle_manager::avm_end_param_map();
	soundscripts\_audio_vehicle_manager::avm_begin_param_map("about_to_stop");
	soundscripts\_audio_vehicle_manager::avm_end_param_map();
	soundscripts\_audio_vehicle_manager::avm_end_behavior_def();
	soundscripts\_audio_vehicle_manager::avm_end_behavior_data();
	soundscripts\_audio_vehicle_manager::avm_begin_state_data();
	soundscripts\_audio_vehicle_manager::avm_begin_state_group("main_oneshots","state_idle","to_state_idle",50,0.1);
	soundscripts\_audio_vehicle_manager::avm_begin_state_def("state_idle");
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("state_engine","to_state_engine");
	soundscripts\_audio_vehicle_manager::avm_end_state_def();
	soundscripts\_audio_vehicle_manager::avm_begin_state_def("state_engine",1);
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("state_idle","to_state_idle");
	soundscripts\_audio_vehicle_manager::avm_end_state_def();
	soundscripts\_audio_vehicle_manager::avm_end_state_group();
	soundscripts\_audio_vehicle_manager::avm_end_state_data();
	soundscripts\_audio_vehicle_manager::avm_add_envelope("m1a1_idle_vel2vol",[[0,1],[8,0]]);
	soundscripts\_audio_vehicle_manager::avm_add_envelope("m1a1_idle_vel2pch",[[0,1],[2.5,1.25]]);
	soundscripts\_audio_vehicle_manager::avm_add_envelope("m1a1_engine_vel2vol",[[0,0],[5,0.7],[8,1]]);
	soundscripts\_audio_vehicle_manager::avm_add_envelope("m1a1_engine_vel2pch",[[0,0.8],[8,1],[10,1.1]]);
	soundscripts\_audio_vehicle_manager::avm_add_envelope("m1a1_treads_vel2vol",[[0,0],[5,0.7],[8,1]]);
	soundscripts\_audio_vehicle_manager::avm_add_envelope("m1a1_treads_vel2pch",[[0,0.8],[8,1.2]]);
	soundscripts\_audio_vehicle_manager::avm_end_preset_def();
}

//Function Number: 6
m1a1_input_callback_about_to_stop()
{
	var_00 = soundscripts\_audio_vehicle_manager::avmx_get_vehicle_entity();
	return isdefined(var_00.about_to_stop);
}

//Function Number: 7
m1a1_condition_callback_to_idle(param_00,param_01)
{
	var_02 = param_00["speed"];
	var_03 = param_00["about_to_stop"];
	if(var_02 <= 0.01 || var_03 > 0.5)
	{
		return 1;
	}

	return 0;
}

//Function Number: 8
m1a1_condition_callback_to_engine(param_00,param_01)
{
	var_02 = param_00["speed"];
	var_03 = param_00["about_to_stop"];
	if(var_02 > 0.01 && var_03 < 0.5)
	{
		return 1;
	}

	return 0;
}