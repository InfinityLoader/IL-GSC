/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: soundscripts\_audio_vehicle_manager.gsc
 * Game: Call of Duty: Modern Warfare Remastered
 * Platform: PC
 * Function Count: 174
 * Decompile Time: 2778 ms
 * Timestamp: 10/27/2023 2:50:40 AM
*******************************************************************/

//Function Number: 1
avm_add_oneshot(param_00,param_01)
{
}

//Function Number: 2
avm_init()
{
	if(isdefined(level._audio.vm))
	{
		return;
	}

	if(!isdefined(level._audio.vm))
	{
		level._audio.vm = spawnstruct();
	}

	var_00 = avmx_get();
	var_00.init_time = gettime();
	var_00.callbacks = [];
	var_00.preset_constructors = [];
	var_00.presets = [];
	var_00.running_intance_accumulator = 0;
	var_00.def_asset_type = "alias";
	var_00.def_player_mode = 0;
	var_00.def_fadein_time = 1;
	var_00.def_fadeout_time = 1;
	var_00.def_state_min_retrigger_time = 0;
	var_00.def_sound_offset = (0,0,0);
	var_00.def_smooth_up = 1;
	var_00.def_smooth_down = 1;
	var_00.def_input_name = "distance";
	var_00.def_output_name = "volume";
	var_00.def_output_scalar = 1;
	var_00.def_priority = 50;
	soundscripts\_snd::snd_register_message("snd_register_vehicle",::snd_register_vehicle);
	soundscripts\_snd::snd_register_message("snd_start_vehicle",::snd_start_vehicle);
	soundscripts\_snd::snd_register_message("snd_stop_vehicle",::snd_stop_vehicle);
	avm_register_callback("distance2d",::input_callback_distance2d);
	avm_register_callback("distance",::input_callback_distance);
	avm_register_callback("throttle",::input_callback_throttle);
	avm_register_callback("speed",::input_callback_speed);
	avm_register_callback("relative_speed",::input_callback_relative_speed);
	avm_register_callback("doppler",::input_callback_doppler);
	avm_register_callback("doppler_exaggerated",::input_callback_doppler_exaggerated);
	avm_register_callback("doppler_subtle",::input_callback_doppler_subtle);
	avm_register_callback("speed_mph",::input_callback_speed_mph);
	avm_register_callback("acceleration_g",::input_callback_acceleration_g);
	avm_register_callback("jerk_gps",::input_callback_jerk_gps);
	avm_register_callback("pitch",::input_callback_pitch);
	avm_register_callback("yaw",::input_callback_yaw);
	avm_register_callback("pitch_roll_max",::input_callback_pitch_roll_max);
	avm_register_callback("degrees_from_upright",::input_callback_degrees_from_upright);
	avm_register_callback("jetbike_thrust",::input_callback_jetbike_thrust);
	avm_register_callback("jetbike_drag",::input_callback_jetbike_drag);
	avm_register_callback("jetbike_anti_slip",::input_callback_jetbike_anti_slip);
	avm_register_callback("jetbike_total_repulsor",::input_callback_jetbike_total_repulsor);
	avm_register_callback("jetbike_height",::input_callback_player_jetbike_height);
	avm_register_callback("hovertank_anti_slip_magnitude",::input_hovertank_anti_slip_magnitude);
	avm_register_callback("hovertank_anti_slip_direction",::input_hovertank_anti_slip_direction);
	avm_register_callback("hovertank_auto_yaw_magnitude",::input_hovertank_auto_yaw_magnitude);
	avm_register_callback("hovertank_auto_yaw_direction",::input_hovertank_auto_yaw_direction);
	avm_register_callback("hovertank_repulsor_front_left",::input_hovertank_repulsor_front_left);
	avm_register_callback("hovertank_repulsor_front_right",::input_hovertank_repulsor_front_right);
	avm_register_callback("hovertank_repulsor_back_left",::input_hovertank_repulsor_back_left);
	avm_register_callback("hovertank_repulsor_back_right",::input_hovertank_repulsor_back_right);
	avm_register_callback("hovertank_throttle_magnitude",::input_hovertank_throttle_magnitude);
	avm_register_callback("hovertank_throttle_direction",::input_hovertank_throttle_direction);
	avm_register_callback("hovertank_uprighting",::input_hovertank_uprighting);
	avm_register_callback("hovertank_turret_yaw",::input_hovertank_turret_yaw);
	avm_register_callback("hovertank_turret_pitch",::input_hovertank_turret_pch);
	avm_register_callback("diveboat_throttle",::input_diveboat_throttle);
	avm_register_callback("diveboat_drag",::input_diveboat_drag);
	avm_register_callback("diveboat_drag_with_mph",::input_diveboat_drag_with_mph);
	avm_register_callback("player_pdrone_look",::input_player_pdrone_look);
}

//Function Number: 3
snd_register_vehicle(param_00,param_01)
{
	var_02 = avmx_get();
	var_02.preset_constructors[param_00] = param_01;
}

//Function Number: 4
snd_start_vehicle(param_00)
{
	var_01 = avmx_get();
	if(isstring(param_00))
	{
		var_02 = param_00;
		param_00 = spawnstruct();
		param_00.preset_name = var_02;
	}

	var_02 = param_00.preset_name;
	var_03 = soundscripts\_audio::aud_get_optional_param(var_01.def_player_mode,param_00.player_mode);
	var_04 = soundscripts\_audio::aud_get_optional_param(var_01.def_fadein_time,param_00.fadein_time);
	var_05 = soundscripts\_audio::aud_get_optional_param(var_01.def_fadeout_time,param_00.fadeout_time);
	var_06 = soundscripts\_audio::aud_get_optional_param(var_01.def_sound_offset,param_00.offset);
	var_07 = soundscripts\_audio::aud_get_optional_param(undefined,param_00.initial_state_spec);
	self.snd_instance = thread avmx_start_instance(var_02,var_03,var_04,var_05,var_06,var_07);
}

//Function Number: 5
snd_stop_vehicle(param_00,param_01)
{
	var_02 = self;
	var_03 = avmx_get();
	var_04 = var_02.snd_instance;
	var_02.snd_instance = undefined;
	var_05 = var_04 avmx_get_instance_preset();
	var_06 = soundscripts\_audio::aud_get_optional_param(var_04.fadeout_time,var_05.header.fadeout_time);
	var_04.fadeout_time = soundscripts\_audio::aud_get_optional_param(var_06,param_00);
	param_01 = soundscripts\_audio::aud_get_optional_param(0,param_01);
	var_04 maps\_utility::delaythread(param_01,::avmx_stop_instance,var_04.fadeout_time);
}

//Function Number: 6
avm_create_vehicle_proxy()
{
	var_00 = common_scripts\utility::spawn_tag_origin();
	var_00.vm_is_proxy = 1;
	return var_00;
}

//Function Number: 7
avmx_is_vehicle_proxy()
{
	return isdefined(self.vm_is_proxy) && self.vm_is_proxy == 1;
}

//Function Number: 8
avm_begin_preset_def(param_00,param_01)
{
	var_02 = avmx_get();
	avmx_set_preset_name(param_00);
	avmx_set_instance_init_callback(param_01);
	var_02.vehicle_under_construction = self;
}

//Function Number: 9
avm_begin_loop_data(param_00,param_01,param_02)
{
	var_03 = avmx_get();
	self.loop_data = spawnstruct();
	self.loop_data.loops = [];
	self.loop_data.defaults = spawnstruct();
	self.loop_data.defaults.fadeout_time = soundscripts\_audio::aud_get_optional_param(var_03.def_fadeout_time,param_00);
	self.loop_data.defaults.smooth_up = soundscripts\_audio::aud_get_optional_param(var_03.def_smooth_up,param_01);
	self.loop_data.defaults.smooth_down = soundscripts\_audio::aud_get_optional_param(var_03.def_smooth_down,param_02);
}

//Function Number: 10
avm_begin_loop_def(param_00,param_01,param_02,param_03,param_04,param_05)
{
	if(isarray(param_00))
	{
		var_06 = param_00;
	}
	else
	{
		var_06 = [param_01];
	}

	param_01 = soundscripts\_audio::aud_get_optional_param(self.loop_data.defaults.fadeout_time,param_01);
	param_02 = soundscripts\_audio::aud_get_optional_param(self.loop_data.defaults.smooth_up,param_02);
	param_03 = soundscripts\_audio::aud_get_optional_param(self.loop_data.defaults.smooth_down,param_03);
	param_04 = soundscripts\_audio::aud_get_optional_param(param_00,param_04);
	param_05 = soundscripts\_audio::aud_get_optional_param("alias",param_05);
	var_0A = spawnstruct();
	var_0A.name = param_04;
	var_0A.fadeout_time = param_01;
	var_0A.asset_type = param_05;
	var_0A.asset_names = var_06;
	var_0A.preset_name = avmx_get_preset_name();
	var_0A.param_maps = [];
	var_0A avmx_preset_set_param_map_defaults(param_02,param_03);
	self.loop_data.loops[var_0A.name] = var_0A;
	self.loop_data.loop_under_construction = var_0A;
}

//Function Number: 11
avmx_preset_determine_param_map_owner(param_00)
{
	var_01 = undefined;
	if(isdefined(self.loop_data) && isdefined(self.loop_data.loop_under_construction))
	{
		var_01 = self.loop_data.loop_under_construction;
		if(isdefined(self.behavior_data))
		{
		}
	}
	else if(isdefined(self.oneshot_data) && isdefined(self.oneshot_data.oneshot_under_construction))
	{
		var_01 = self.oneshot_data.oneshot_under_construction;
	}
	else if(isdefined(self.behavior_data) && isdefined(self.behavior_data.behavior_under_construction))
	{
		var_01 = self.behavior_data.behavior_under_construction;
	}

	return var_01;
}

//Function Number: 12
avmx_preset_determine_param_map_env_owner(param_00)
{
	var_01 = undefined;
	var_02 = avmx_preset_determine_param_map_owner(param_00);
	if(isdefined(var_02))
	{
		var_01 = var_02.pmap_under_construction;
	}

	return var_01;
}

//Function Number: 13
avmx_preset_set_param_map_defaults(param_00,param_01)
{
	var_02 = avmx_get();
	self.param_map_defaults = spawnstruct();
	var_03 = soundscripts\_audio::aud_get_optional_param(var_02.def_smooth_up,self.param_map_defaults.smooth_up);
	var_04 = soundscripts\_audio::aud_get_optional_param(var_02.def_smooth_down,self.param_map_defaults.smooth_down);
	self.param_map_defaults.smooth_up = soundscripts\_audio::aud_get_optional_param(var_03,param_00);
	self.param_map_defaults.smooth_down = soundscripts\_audio::aud_get_optional_param(var_04,param_01);
	self.param_map_defaults.input_name = var_02.def_input_name;
	self.param_map_defaults.output_name = var_02.def_output_name;
	self.param_map_defaults.input_modifiers = [];
}

//Function Number: 14
avm_begin_param_map(param_00,param_01,param_02)
{
	param_00 = tolower(param_00);
	var_03 = param_00;
	if(!isstring(var_03))
	{
		var_03 = "";
	}

	var_04 = avmx_preset_determine_param_map_owner(var_03);
	var_03 = param_00;
	var_06 = spawnstruct();
	var_06.envs = [];
	var_06.input_name = param_00;
	var_06.smooth_up = soundscripts\_audio::aud_get_optional_param(var_04.param_map_defaults.smooth_up,param_01);
	var_06.smooth_down = soundscripts\_audio::aud_get_optional_param(var_04.param_map_defaults.smooth_down,soundscripts\_audio::aud_get_optional_param(param_01,param_02));
	var_06.def_output_name = var_04.param_map_defaults.output_name;
	var_06.smooth_up = avm_change_smoothing_rate(var_06.smooth_up,0.1,0.1);
	var_06.smooth_down = avm_change_smoothing_rate(var_06.smooth_down,0.1,0.1);
	var_04.param_maps[var_03] = var_06;
	var_04.pmap_under_construction = var_06;
}

//Function Number: 15
avm_compute_smoothing_rc_from_alpha(param_00,param_01)
{
	return param_01 * 1 - param_00 / param_00;
}

//Function Number: 16
avm_compute_alpha_from_rc(param_00,param_01)
{
	return param_01 / param_00 + param_01;
}

//Function Number: 17
avm_change_smoothing_rate(param_00,param_01,param_02)
{
	var_03 = avm_compute_smoothing_rc_from_alpha(param_00,param_01);
	var_04 = avm_compute_alpha_from_rc(var_03,param_02);
	return var_04;
}

//Function Number: 18
avmx_add_behavior_shortcut_param_maps(param_00,param_01,param_02)
{
	foreach(var_04 in param_00)
	{
		avm_begin_param_map(var_04,param_01,param_02);
		avm_end_param_map();
	}
}

//Function Number: 19
avm_add_param_map_env(param_00,param_01,param_02)
{
	if(isstring(param_01))
	{
		param_02 = soundscripts\_audio::aud_get_optional_param(param_01,param_02);
	}

	var_03 = avmx_preset_determine_param_map_env_owner(param_02);
	var_04 = param_01;
	if(!isstring(var_04))
	{
		var_04 = "???";
	}

	var_05 = spawnstruct();
	var_05.asset_name = param_01;
	var_05.output_name = param_00;
	var_03.envs[param_02] = var_05;
}

//Function Number: 20
avm_end_param_map()
{
	var_00 = avmx_preset_determine_param_map_owner("UNKNOWN param_map being terminated by AVM_end_param_map()");
	if(isdefined(var_00))
	{
		var_00.pmap_under_construction = undefined;
	}
}

//Function Number: 21
avm_end_loop_def()
{
	self.loop_data.loop_under_construction = undefined;
}

//Function Number: 22
avm_end_loop_data()
{
}

//Function Number: 23
avm_begin_oneshot_data(param_00)
{
	var_01 = avmx_get();
	self.oneshot_data = spawnstruct();
	self.oneshot_data.oneshots = [];
	self.oneshot_data.defaults = spawnstruct();
	self.oneshot_data.defaults.fadeout_time = soundscripts\_audio::aud_get_optional_param(var_01.def_fadeout_time,param_00);
}

//Function Number: 24
avm_begin_oneshot_def(param_00,param_01,param_02,param_03,param_04,param_05)
{
	var_06 = avmx_get();
	param_01 = soundscripts\_audio::aud_get_optional_param(undefined,param_01);
	param_02 = soundscripts\_audio::aud_get_optional_param(self.oneshot_data.defaults.fadeout_time,param_02);
	param_03 = soundscripts\_audio::aud_get_optional_param(1,param_03);
	param_04 = soundscripts\_audio::aud_get_optional_param(param_00,param_04);
	param_05 = soundscripts\_audio::aud_get_optional_param(var_06.def_asset_type,param_05);
	var_07 = param_04;
	if(isstring(param_04))
	{
		var_07 = [param_04];
	}

	var_0B = spawnstruct();
	var_0B.name = param_00;
	var_0B.asset_names = var_07;
	var_0B.asset_type = param_05;
	var_0B.duck_env_name = param_01;
	var_0B.fadeout_time = param_02;
	var_0B.oneshot_poly_mode = param_03;
	var_0B.param_maps = [];
	var_0B.snd_ents = [];
	var_0B avmx_preset_set_param_map_defaults();
	self.oneshot_data.oneshots[var_0B.name] = var_0B;
	self.oneshot_data.oneshot_under_construction = var_0B;
}

//Function Number: 25
avmx_set_oneshot_update_mode(param_00)
{
	var_01 = self.oneshot_data.oneshot_under_construction;
	var_01.oneshot_update_mode = param_00;
}

//Function Number: 26
avm_end_oneshot_def()
{
	self.oneshot_data.oneshot_under_construction = undefined;
}

//Function Number: 27
avm_end_oneshot_data()
{
}

//Function Number: 28
avm_begin_behavior_data(param_00,param_01)
{
	self.behavior_data = spawnstruct();
	self.behavior_data.behaviors = [];
	self.behavior_data.defaults = spawnstruct();
	self.behavior_data.defaults.smooth_up = param_00;
	self.behavior_data.defaults.smooth_down = param_01;
}

//Function Number: 29
avm_begin_behavior_def(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = avmx_get();
	var_06 = spawnstruct();
	var_06.oneshots = [];
	var_06.loops = [];
	var_06.preset_name = avmx_get_preset_name();
	var_06.param_maps = [];
	var_06.name = param_00;
	var_06.condition_callback = param_01;
	param_03 = soundscripts\_audio::aud_get_optional_param(self.behavior_data.defaults.smooth_up,param_03);
	param_04 = soundscripts\_audio::aud_get_optional_param(self.behavior_data.defaults.smooth_down,param_04);
	var_06 avmx_preset_set_param_map_defaults(param_03,param_04);
	self.behavior_data.behaviors[var_06.name] = var_06;
	self.behavior_data.behavior_under_construction = var_06;
	if(isarray(param_02))
	{
		avmx_add_behavior_shortcut_param_maps(param_02,self.behavior_data.defaults.smooth_up,self.behavior_data.defaults.smooth_down);
	}
}

//Function Number: 30
avm_add_init_state_callback(param_00)
{
	self.behavior_data.behavior_under_construction.init_state_callback = param_00;
}

//Function Number: 31
avm_add_in_state_callback(param_00)
{
	self.behavior_data.behavior_under_construction.in_state_callback = param_00;
}

//Function Number: 32
avm_add_oneshots(param_00)
{
	if(isstring(param_00))
	{
		param_00 = [param_00];
	}

	foreach(var_02 in param_00)
	{
		var_03 = self.behavior_data.behavior_under_construction;
		var_03.oneshots[var_02] = var_02;
	}
}

//Function Number: 33
avm_add_loops(param_00)
{
	var_01 = self.behavior_data.behavior_under_construction;
	if(!isdefined(param_00) || param_00.size == 0)
	{
		param_00 = "none";
	}

	if(isstring(param_00))
	{
		if(tolower(param_00) == "all")
		{
			var_01.loops[0] = "all";
			return;
		}

		if(tolower(param_00) == "none")
		{
			var_01.loops[0] = "none";
			return;
		}

		var_01.loops[param_00] = param_00;
		return;
	}

	var_01.loops[0] = undefined;
	foreach(var_03 in param_00)
	{
		if(var_03 != "all" && var_03 != "none")
		{
		}

		var_01.loops[var_03] = var_03;
	}
}

//Function Number: 34
avm_end_behavior_def()
{
	self.behavior_data.behavior_under_construction = undefined;
}

//Function Number: 35
avm_end_behavior_data()
{
}

//Function Number: 36
avm_begin_state_data(param_00,param_01)
{
	if(isdefined(param_00))
	{
		param_00 = param_00 * 1000;
	}

	var_02 = avmx_get();
	self.state_data = spawnstruct();
	self.state_data.state_groups = [];
	self.state_data.defaults = spawnstruct();
	self.state_data.defaults.priority = soundscripts\_audio::aud_get_optional_param(var_02.def_priority,param_01);
	self.state_data.defaults.min_retrigger_time = soundscripts\_audio::aud_get_optional_param(var_02.def_state_min_retrigger_time,param_00);
}

//Function Number: 37
avm_begin_state_group(param_00,param_01,param_02,param_03,param_04)
{
	if(isdefined(param_04))
	{
		param_04 = param_04 * 1000;
	}

	var_05 = spawnstruct();
	var_05.name = param_00;
	var_05.initial_state_name_pair = [param_01,param_02];
	var_05.priority = soundscripts\_audio::aud_get_optional_param(self.state_data.defaults.priority,param_03);
	var_05.min_retrigger_time = soundscripts\_audio::aud_get_optional_param(self.state_data.defaults.min_retrigger_time,param_04);
	var_05.states = [];
	self.state_data.state_groups[param_00] = var_05;
	self.state_data.group_under_construction = var_05;
}

//Function Number: 38
avm_begin_state_def(param_00,param_01,param_02)
{
	if(isdefined(param_01))
	{
		param_01 = param_01 * 1000;
	}

	var_03 = self.state_data.group_under_construction;
	var_04 = var_03.name;
	var_05 = spawnstruct();
	var_05.name = param_00;
	var_05.transitions = [];
	var_05.priority = soundscripts\_audio::aud_get_optional_param(var_03.priority,param_02);
	var_05.min_retrigger_time = soundscripts\_audio::aud_get_optional_param(var_03.min_retrigger_time,param_01);
	var_05.preset_name = avmx_get_preset_name();
	var_03.states[param_00] = var_05;
	self.state_data.group_under_construction.state_under_construction = var_05;
}

//Function Number: 39
avm_add_state_transition(param_00,param_01)
{
	var_03 = self.state_data.group_under_construction.state_under_construction;
	var_03.transitions[var_03.transitions.size] = [param_00,param_01];
}

//Function Number: 40
avm_end_state_def()
{
	self.state_data.group_under_construction.state_under_construction = undefined;
}

//Function Number: 41
avm_end_state_group()
{
	self.state_data.group_under_construction = undefined;
}

//Function Number: 42
avm_end_state_data()
{
}

//Function Number: 43
avm_add_envelope(param_00,param_01)
{
	if(isstring(param_00))
	{
		param_00 = tolower(param_00);
	}

	var_04 = avmx_get();
	if(!isdefined(self.env_data))
	{
		self.env_data = [];
	}

	var_05 = spawnstruct();
	if(isarray(param_01))
	{
		var_05.env_array = [];
		if(getdvarint("enableMW1GetArrayKeysAndForEach") != 0)
		{
			for(var_06 = 0;var_06 < param_01.size;var_06++)
			{
				var_07 = param_01[var_06];
				var_05.env_array[var_05.env_array.size] = (var_07[0],var_07[1],0);
			}
		}
		else
		{
			foreach(var_07 in var_04)
			{
				var_05.env_array[var_05.env_array.size] = (var_07[0],var_07[1],0);
			}
		}
	}
	else
	{
		var_05.env_function = param_01;
	}

	self.env_data[param_00] = var_05;
}

//Function Number: 44
avm_end_preset_def()
{
	var_00 = avmx_get();
	self.consolidated_inputs = [];
	foreach(var_08, var_02 in self.loop_data.loops)
	{
		var_03 = var_08;
		var_04 = var_02;
		foreach(var_07, var_06 in var_04.param_maps)
		{
			self.consolidated_inputs[var_07] = avmx_get_callback(var_07);
		}
	}

	foreach(var_08, var_02 in self.oneshot_data.oneshots)
	{
		var_0A = var_08;
		var_0B = var_02;
		foreach(var_07, var_06 in var_0B.param_maps)
		{
			self.consolidated_inputs[var_07] = avmx_get_callback(var_07);
		}
	}

	foreach(var_08, var_02 in self.behavior_data.behaviors)
	{
		var_0E = var_08;
		var_0F = var_02;
		foreach(var_07, var_06 in var_0F.param_maps)
		{
			self.consolidated_inputs[var_07] = avmx_get_callback(var_07);
		}
	}

	var_00.vehicle_under_construction = undefined;
}

//Function Number: 45
avmx_get_master_volume()
{
	return self.master_volume;
}

//Function Number: 46
vm2_get_vehicle_snd_instance()
{
	return self.snd_instance;
}

//Function Number: 47
vm2_get_instance_name()
{
	return avmx_get_instance_name();
}

//Function Number: 48
avm_set_instance_master_volume(param_00,param_01)
{
	thread avmx_set_instance_master_volume(param_00,param_01);
}

//Function Number: 49
avmx_set_instance_master_volume(param_00,param_01)
{
	var_02 = self;
	var_03 = var_02 avmx_get_instance_name();
	var_04 = var_02 avmx_get_vehicle_entity();
	param_00 = clamp(param_00,0,1);
	param_01 = clamp(soundscripts\_audio::aud_get_optional_param(1,param_01),0,60);
	var_05 = var_03;
	var_02 notify(var_05);
	var_02 endon(var_05);
	level endon("msg_snd_vehicle_stop");
	level endon("msg_snd_vehicle_stop_" + var_02 avmx_get_instance_name());
	var_04 endon("death");
	var_06 = avm_get_update_rate();
	var_07 = param_00 - var_02.master_volume;
	var_08 = max(1,param_01 / var_06);
	var_09 = var_07 / var_08;
	for(;;)
	{
		if(var_09 < 0)
		{
			if(var_02.master_volume > param_00)
			{
				var_02.master_volume = max(0,var_02.master_volume + var_09);
			}
			else
			{
				break;
			}
		}
		else if(var_09 > 0)
		{
			if(var_02.master_volume < param_00)
			{
				var_02.master_volume = min(1,var_02.master_volume + var_09);
			}
			else
			{
				break;
			}
		}

		wait(var_06);
	}
}

//Function Number: 50
avm_get_running_instance_count(param_00)
{
	return avmx_get().running_intance_accumulator;
}

//Function Number: 51
avm_get_update_rate()
{
	return 0.1;
}

//Function Number: 52
vm2_get_vehicle_instance_count(param_00)
{
	var_01 = 0;
	var_02 = avmx_get();
	if(isstring(param_00))
	{
		var_03 = var_02.presets[param_00];
		if(isdefined(var_03) & isarray(var_03.instances))
		{
			var_01 = var_03.instances.size;
		}
	}
	else
	{
		foreach(var_03 in var_03.presets)
		{
			if(isarray(var_03.instances))
			{
				var_01 = var_01 + var_03.instances.size;
			}
		}
	}

	return var_01;
}

//Function Number: 53
avmx_create_preset(param_00)
{
	var_01 = avmx_get();
	var_02 = var_01.preset_constructors[param_00];
	var_03 = spawnstruct();
	var_03.global_data = spawnstruct();
	var_03.user_data = spawnstruct();
	var_03.header = spawnstruct();
	var_03.instances = [];
	var_03.header.preset_name = soundscripts\_audio::aud_get_optional_param(undefined,param_00);
	var_03.header.fadein_time = var_01.def_fadein_time;
	var_03.header.fadeout_time = var_01.def_fadeout_time;
	var_03.header.sound_offset = var_01.def_sound_offset;
	var_03 [[ var_02 ]]();
	var_03 avmx_add_preset();
	return var_03;
}

//Function Number: 54
avmx_add_preset()
{
	var_00 = avmx_get();
	var_00.presets[self.header.preset_name] = self;
}

//Function Number: 55
vm2x_remove_preset()
{
	var_00 = avmx_get();
	var_00.presets[self.header.preset_name] = undefined;
}

//Function Number: 56
avmx_add_instance()
{
	var_00 = avmx_get();
	var_00.presets[self.preset_name].instances[self.instance_name] = self;
	var_00.running_intance_accumulator++;
}

//Function Number: 57
avmx_remove_instance()
{
	var_00 = avmx_get();
	var_00.presets[self.preset_name].instances[self.instance_name] = undefined;
}

//Function Number: 58
avmx_generate_instance_name(param_00)
{
	var_01 = self.header.preset_name + "_" + avm_get_running_instance_count();
	if(isdefined(param_00) && param_00 == 1)
	{
		var_01 = var_01 + "_player";
	}

	return var_01;
}

//Function Number: 59
avm_register_callback(param_00,param_01,param_02)
{
	avmx_get().callbacks[param_00] = [param_01,param_02];
}

//Function Number: 60
avmx_get_instance_state_struct(param_00)
{
	var_01 = self;
	var_02 = undefined;
	foreach(var_04 in var_01.state_group_list)
	{
		var_02 = var_04[param_00];
		if(isdefined(var_02))
		{
			break;
		}
	}

	return var_02;
}

//Function Number: 61
avmx_get_behavior_instance_struct(param_00)
{
	var_01 = self;
	return var_01.behavior_list[param_00];
}

//Function Number: 62
avmx_get_state_preset_struct(param_00)
{
	var_01 = self;
	var_02 = undefined;
	foreach(var_04 in var_01.state_data.state_groups)
	{
		var_02 = var_04.states[param_00];
		if(isdefined(var_02))
		{
			break;
		}
	}

	return var_02;
}

//Function Number: 63
avmx_get_behavior_preset_struct(param_00)
{
	var_01 = self;
	return var_01.behavior_data.behaviors[param_00];
}

//Function Number: 64
avmx_create_instance_struct(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = self;
	var_06 = spawnstruct();
	var_06.user_data = spawnstruct();
	var_06.preset_name = var_05 avmx_get_preset_name();
	var_06.instance_name = var_05 avmx_generate_instance_name(param_04);
	var_06.veh_ent = param_00;
	var_06.fadein_time = param_01;
	var_06.fadeout_time = param_02;
	var_06.sound_offset = param_03;
	var_06.player_mode = param_04;
	var_06.loop_duck_scalar = 1;
	var_06.oneshot_duck_vals = [];
	var_06.master_volume = 1;
	var_06.loop_list = [];
	foreach(var_08 in var_05.loop_data.loops)
	{
		var_09 = spawnstruct();
		var_09.ps_item = var_08;
		var_09.play_mode = 0;
		var_09.curr_io = var_06 avmx_create_param_io_struct(var_08);
		var_09.snd_ents = [];
		var_09.volume = 1;
		var_06.loop_list[var_08.name] = var_09;
	}

	var_06.oneshot_list = [];
	foreach(var_08 in var_05.oneshot_data.oneshots)
	{
		var_09 = spawnstruct();
		var_09.ps_item = var_08;
		var_09.curr_io = var_06 avmx_create_param_io_struct(var_08);
		var_09.snd_ents = [];
		var_06.oneshot_list[var_08.name] = var_09;
	}

	var_06.behavior_list = [];
	foreach(var_08 in var_05.behavior_data.behaviors)
	{
		var_09 = spawnstruct();
		var_09.ps_item = var_08;
		var_09.curr_io = var_06 avmx_create_param_io_struct(var_08);
		var_06.behavior_list[var_08.name] = var_09;
	}

	var_06.state_group_list = [];
	foreach(var_15, var_10 in var_05.state_data.state_groups)
	{
		var_06.state_group_list[var_15] = [];
		foreach(var_14, var_12 in var_10.states)
		{
			var_13 = spawnstruct();
			var_13.ps_item = var_12;
			var_13.start_time = 0;
			var_06.state_group_list[var_15][var_14] = var_13;
		}
	}

	if(isdefined(var_05.global_data.instance_init_callback))
	{
		var_06 [[ var_05.global_data.instance_init_callback ]](var_06.user_data);
	}

	return var_06;
}

//Function Number: 65
avmx_start_instance(param_00,param_01,param_02,param_03,param_04,param_05)
{
	var_06 = self;
	if(var_06 avmx_is_vehicle_proxy() == 0)
	{
		var_06 vehicle_turnengineoff();
	}

	var_07 = avmx_get_preset(param_00);
	if(!isdefined(var_07))
	{
		var_07 = avmx_create_preset(param_00);
	}

	var_08 = var_07 avmx_create_instance_struct(var_06,param_02,param_03,param_04,param_01);
	var_08 avmx_add_instance();
	var_08 thread avmx_update_loops();
	var_08 thread avmx_launch_state_machines(param_05);
	var_06 thread avmx_monitor_death(var_08);
	return var_08;
}

//Function Number: 66
avmx_stop_instance(param_00)
{
	if(!isdefined(self.is_stopping))
	{
		self.is_stopping = 1;
		var_01 = self;
		var_02 = var_01 avmx_get_instance_preset();
		var_03 = var_01 avmx_get_instance_name();
		param_00 = max(0.01,soundscripts\_audio::aud_get_optional_param(var_01.fadeout_time,param_00));
		level notify("msg_snd_vehicle_stop_" + var_03);
		foreach(var_05 in var_01.loop_list)
		{
			var_06 = soundscripts\_audio::aud_get_optional_param(var_05.ps_item.fadeout_time,param_00);
			var_05 thread avmx_fade_stop_and_delete_sound_obj(var_06);
		}

		foreach(var_09 in var_01.oneshot_list)
		{
			var_06 = soundscripts\_audio::aud_get_optional_param(var_09.ps_item.fadeout_time,param_00);
			var_09 thread avmx_fade_stop_and_delete_sound_obj(var_06);
		}

		wait(param_00 + 0.05);
		var_01 avmx_remove_instance();
	}
}

//Function Number: 67
avmx_monitor_death(param_00)
{
	var_01 = param_00 avmx_get_instance_name();
	level endon("msg_snd_vehicle_stop_" + var_01);
	self waittill("death");
	param_00 thread avmx_stop_instance();
}

//Function Number: 68
avmx_create_param_io_struct(param_00)
{
	var_01 = self;
	var_02 = spawnstruct();
	var_02.smoothed_input = [];
	var_02.physical_output = [];
	foreach(var_04 in param_00.param_maps)
	{
		var_02.smoothed_input[var_04.input_name] = 0;
		foreach(var_06 in var_04.envs)
		{
			if(!isdefined(var_02.physical_output[var_06.output_name]))
			{
				var_02.physical_output[var_06.output_name] = 1;
			}
		}
	}

	if(!isdefined(var_02.physical_output["volume"]))
	{
		var_02.physical_output["volume"] = 1;
	}

	if(!isdefined(var_02.physical_output["pitch"]))
	{
		var_02.physical_output["pitch"] = 1;
	}

	return var_02;
}

//Function Number: 69
vm2x_init_param_io_struct(param_00)
{
	var_01 = self;
	foreach(var_04, var_03 in param_00.smoothed_input)
	{
		param_00.smoothed_input[var_04] = 0;
	}

	foreach(var_04, var_03 in param_00.physical_output)
	{
		param_00.physical_output[var_04] = 1;
	}
}

//Function Number: 70
avmx_get_current_instance_sound_item_input()
{
	return self.curr_io.smoothed_input;
}

//Function Number: 71
avmx_get_instance_sound_item_output()
{
	return self.curr_io.physical_output;
}

//Function Number: 72
avmx_get_instance_sound_item_volume()
{
	var_00 = avmx_get_instance_sound_item_output();
	var_01 = var_00["volume"];
	if(!isdefined(var_01))
	{
		var_01 = 1;
	}

	return var_01;
}

//Function Number: 73
avmx_update_loops()
{
	var_00 = self;
	var_01 = avmx_get_instance_preset();
	var_02 = avmx_get_vehicle_entity();
	level endon("msg_snd_vehicle_stop");
	level endon("msg_snd_vehicle_stop_" + avmx_get_instance_name());
	var_02 endon("death");
	var_03 = undefined;
	for(;;)
	{
		var_00 avmx_update_loop_ducking_scalar();
		foreach(var_05 in var_00.loop_list)
		{
			if(var_05.play_mode == 1)
			{
				var_06 = var_05.ps_item.name;
				var_00 avmx_map_io(var_05,var_03);
				var_00 avmx_update_instance_loop_assets(var_05);
			}
		}

		var_03 = gettime();
		var_08 = distance2d(var_00.veh_ent.origin,level.player.origin);
		if(var_08 < 400)
		{
			var_09 = 1;
		}
		else if(var_08 > 1500)
		{
			var_09 = 10;
		}
		else
		{
			var_09 = 1 + 9 * var_08 - 400 / 1100;
		}

		wait(0.1 * var_09);
	}
}

//Function Number: 74
avmx_set_loop_play_state(param_00,param_01)
{
	var_02 = self;
	switch(param_00.ps_item.asset_type)
	{
		case "alias":
			break;

		case "soundevent":
			break;

		case "damb":
			break;

		default:
			break;
	}
}

//Function Number: 75
avmx_map_io(param_00,param_01)
{
	if(param_00.ps_item.param_maps.size == 0)
	{
		return;
	}

	var_02 = self;
	var_03 = avmx_get_instance_preset();
	var_04 = param_00.ps_item;
	var_05 = param_00.curr_io;
	var_06 = gettime();
	param_01 = soundscripts\_audio::aud_get_optional_param(var_06 - 100,param_01);
	var_05.physical_output = [];
	var_07 = [];
	foreach(var_0A, var_09 in var_03.consolidated_inputs)
	{
		var_07[var_0A] = var_02 [[ var_09 ]]();
	}

	foreach(var_0C in var_04.param_maps)
	{
		var_0D = var_0C.input_name;
		var_0E = var_07[var_0D];
		var_0F = var_05.smoothed_input[var_0D];
		if(var_0E > var_0F)
		{
			var_10 = var_0C.smooth_up;
		}
		else
		{
			var_10 = var_0C.smooth_down;
		}

		var_11 = var_06 - param_01 / 100;
		var_10 = 1 - pow(1 - var_10,var_11);
		var_12 = var_0F + var_10 * var_0E - var_0F;
		foreach(var_17, var_14 in var_0C.envs)
		{
			var_15 = var_03.env_data[var_17];
			var_16 = piecewiselinearlookup(var_12,var_15.env_array);
			if(isdefined(var_05.physical_output[var_14.output_name]))
			{
				var_05.physical_output[var_14.output_name] = var_05.physical_output[var_14.output_name] * var_16;
				continue;
			}

			var_05.physical_output[var_14.output_name] = var_16;
		}

		var_05.smoothed_input[var_0D] = var_12;
	}
}

//Function Number: 76
avmx_update_loop_ducking_scalar()
{
	self.loop_duck_scalar = 1;
	foreach(var_01 in self.oneshot_duck_vals)
	{
		self.loop_duck_scalar = self.loop_duck_scalar * var_01;
	}
}

//Function Number: 77
avmx_update_instance_loop_assets(param_00)
{
	var_01 = self;
	foreach(var_07, var_03 in param_00.curr_io.physical_output)
	{
		if(var_07 == "volume")
		{
			var_03 = var_03 * var_01.loop_duck_scalar * param_00.volume;
			if(isdefined(param_00.fade_in_scalar))
			{
				param_00.fade_in_scalar = min(param_00.fade_in_scalar + param_00.fade_in_inc,1);
				var_03 = var_03 * param_00.fade_in_scalar;
				if(param_00.fade_in_scalar >= 1)
				{
					param_00.fade_in_scalar = undefined;
				}
			}
		}

		foreach(var_05 in param_00.snd_ents)
		{
			var_05 avmx_update_sound_ent_output_param(var_07,var_03);
		}
	}
}

//Function Number: 78
avm_set_loop_mute_state(param_00,param_01,param_02)
{
	var_03 = self;
	var_04 = var_03.loop_list[param_00];
	var_05 = 1;
	if(param_01 == 1)
	{
		var_05 = 0;
	}

	param_02 = soundscripts\_audio::aud_get_optional_param(0.05,param_02);
	var_06 = var_05 - var_04.volume;
	var_07 = max(1,param_02 / avm_get_update_rate());
	var_08 = var_06 / var_07;
	var_03 thread avmx_set_loop_volume(var_04,var_05,var_08,avm_get_update_rate());
}

//Function Number: 79
avmx_set_loop_volume(param_00,param_01,param_02,param_03)
{
	var_04 = self;
	var_05 = var_04 avmx_get_vehicle_entity();
	var_06 = param_00.ps_item.name;
	var_04 notify(var_06);
	var_04 endon(var_06);
	level endon("msg_snd_vehicle_stop");
	level endon("msg_snd_vehicle_stop_" + var_04 avmx_get_instance_name());
	var_05 endon("death");
	for(;;)
	{
		if(param_02 < 0)
		{
			if(param_00.volume > param_01)
			{
				param_00.volume = max(0,param_00.volume + param_02);
			}
			else
			{
				break;
			}
		}
		else if(param_02 > 0)
		{
			if(param_00.volume < param_01)
			{
				param_00.volume = min(1,param_00.volume + param_02);
			}
			else
			{
				break;
			}
		}

		wait(param_03);
	}
}

//Function Number: 80
avmx_launch_state_machines(param_00)
{
	var_01 = self;
	var_02 = avmx_get_instance_preset();
	foreach(var_0A, var_04 in var_02.state_data.state_groups)
	{
		var_05 = var_04.initial_state_name_pair;
		if(isarray(param_00))
		{
			var_05 = param_00[var_0A];
		}

		var_06 = var_05[0];
		var_07 = var_05[1];
		var_08 = var_01.state_group_list[var_0A][var_06];
		var_09 = var_01.behavior_list[var_07];
		var_01 avmx_map_io(var_09);
		var_01 thread avmx_state_enter_action_function(var_08,var_09,1);
	}
}

//Function Number: 81
avmx_state_enter_action_function(param_00,param_01,param_02)
{
	var_03 = self;
	var_04 = var_03 avmx_get_instance_preset();
	var_05 = param_00.ps_item;
	var_06 = var_03 avmx_get_vehicle_entity();
	level endon("msg_snd_vehicle_stop");
	level endon("msg_snd_vehicle_stop_" + avmx_get_instance_name());
	var_06 endon("death");
	param_00.start_time = gettime();
	var_03 avmx_state_enter_action_init_data(param_00,param_01);
	var_03 avmx_state_enter_action_play_oneshots(param_00,param_01);
	var_03 avmx_state_enter_action_play_loops(param_00,param_01);
	if(isdefined(param_01.ps_item.init_state_callback))
	{
		var_03 [[ param_01.ps_item.init_state_callback ]](var_03.user_data);
	}

	var_07 = undefined;
	var_08 = undefined;
	var_09 = undefined;
	var_0A = undefined;
	var_0B = undefined;
	var_0C = 1;
	for(;;)
	{
		if(isdefined(param_01.ps_item.in_state_callback))
		{
			var_03 avmx_map_io(param_01);
			var_03 [[ param_01.ps_item.in_state_callback ]](param_01.curr_io.smoothed_input,var_03.user_data);
		}

		foreach(var_0E in var_05.transitions)
		{
			var_0F = var_0E[0];
			var_10 = var_0E[1];
			var_11 = var_0E[2];
			var_12 = var_03 avmx_get_instance_state_struct(var_0F);
			var_13 = var_03 avmx_get_behavior_instance_struct(var_10);
			var_14 = var_12.ps_item;
			var_15 = var_13.ps_item;
			if(gettime() - var_12.start_time < var_14.min_retrigger_time)
			{
				continue;
			}

			var_03 avmx_map_io(var_13,var_0B);
			var_16 = var_03 avmx_state_condition_function(var_12,var_13);
			if(isarray(var_16))
			{
				var_0A = var_16;
				var_16 = 1;
			}

			if(var_16)
			{
				if(!isdefined(var_07) || var_14.priority > var_07.ps_item.priority)
				{
					var_07 = var_12;
					var_08 = var_13;
					var_09 = var_0A;
					var_0A = undefined;
				}
			}
		}

		if(isdefined(var_07))
		{
			break;
		}

		var_0C = 0;
		var_0B = gettime();
		var_18 = distance2d(var_03.veh_ent.origin,level.player.origin);
		if(var_18 < 400)
		{
			var_19 = 1;
		}
		else if(var_18 > 1500)
		{
			var_19 = 10;
		}
		else
		{
			var_19 = 1 + 9 * var_18 - 400 / 1100;
		}

		wait(0.1 * var_19);
	}

	var_03 avmx_set_behavior_oneshot_overrides(var_08,var_09);
	var_1A = var_03 avmx_get_behavior_restricted_oneshots(var_08);
	var_1B = var_1A.size > 0;
	var_03 thread avmx_state_exit_action_function(param_01,var_1B);
	if(var_0C && !param_02)
	{
	}

	var_03 thread avmx_state_enter_action_function(var_07,var_08,0);
}

//Function Number: 82
avmx_state_enter_action_init_data(param_00,param_01)
{
	var_02 = self;
	var_03 = param_01.ps_item;
	if(isdefined(var_03.loops[0]))
	{
		if(var_03.loops[0] == "all")
		{
			foreach(var_05 in var_02.loop_list)
			{
				var_05.volume = 1;
			}

			return;
		}

		return;
	}

	foreach(var_07 in var_06.loops)
	{
		var_08 = var_04.loop_list[var_07];
		var_08.volume = 1;
	}
}

//Function Number: 83
avmx_state_exit_action_function(param_00,param_01)
{
	var_02 = self;
	var_03 = param_00.ps_item.oneshots;
	foreach(var_05 in var_03)
	{
		var_06 = var_02.oneshot_list[var_05];
		var_07 = var_06.ps_item.oneshot_poly_mode;
		if(var_07 == 2 || var_07 == 1 && param_01)
		{
			var_08 = var_06.snd_ents;
			var_06.snd_ents = [];
			var_09 = var_06.ps_item.fadeout_time;
			foreach(var_0B in var_08)
			{
				var_0B thread avmx_stop_snd_ent(var_09);
			}
		}
	}
}

//Function Number: 84
vm2x_fade_sound_obj(param_00)
{
	var_01 = self;
	param_00 = max(0.01,soundscripts\_audio::aud_get_optional_param(0.05,param_00));
	switch(var_01.ps_item.asset_type)
	{
		case "alias":
			break;

		case "soundevent":
			break;

		case "damb":
			break;

		default:
			break;
	}
}

//Function Number: 85
avmx_state_condition_function(param_00,param_01)
{
	var_02 = 0;
	var_03 = self;
	var_02 = var_03 [[ param_01.ps_item.condition_callback ]](param_01.curr_io.smoothed_input,var_03.user_data);
	return var_02;
}

//Function Number: 86
avmx_state_enter_action_play_oneshots(param_00,param_01)
{
	var_02 = self;
	var_03 = var_02 avmx_get_instance_preset();
	var_04 = param_00.ps_item;
	var_05 = param_01.ps_item;
	var_06 = param_01.oneshot_overrides;
	if(!isdefined(var_06))
	{
		var_06 = var_05.oneshots;
	}

	foreach(var_08 in var_06)
	{
		var_09 = var_02.oneshot_list[var_08];
		var_0A = var_09.ps_item;
		var_0B = var_02 avmx_get_oneshot_poly_mode(var_08);
		var_0C = var_02 avmx_get_oneshot_update_mode(var_08);
		if(var_0A.asset_type == "alias")
		{
			var_02 avmx_map_io(var_09);
			for(var_0D = 0;var_0D < var_0A.asset_names.size;var_0D++)
			{
				var_0E = var_02 avmx_start_oneshot_alias(var_09,var_0D);
				foreach(var_11, var_10 in var_09.curr_io.physical_output)
				{
					var_0E avmx_update_sound_ent_output_param(var_11,var_10);
				}

				if(var_0C)
				{
					var_02 thread avmx_continuously_update_snd_ent(var_09,var_0E);
				}

				if(var_0B == 1 || var_0B == 2)
				{
					var_09.snd_ents[var_0D] = var_0E;
				}
			}

			var_02 thread avmx_handle_oneshot_ducking(var_09);
		}
	}
}

//Function Number: 87
avmx_continuously_update_snd_ent(param_00,param_01)
{
	var_02 = self;
	var_03 = var_02 avmx_get_vehicle_entity();
	var_04 = avm_get_update_rate();
	level endon("msg_snd_vehicle_stop");
	level endon("msg_snd_vehicle_stop_" + var_02 avmx_get_instance_name());
	var_03 endon("death");
	wait(var_04);
	while(isdefined(param_01))
	{
		var_02 avmx_map_io(param_00);
		if(isdefined(param_01))
		{
			foreach(var_07, var_06 in param_00.curr_io.physical_output)
			{
				param_01 avmx_update_sound_ent_output_param(var_07,var_06);
			}
		}

		wait(var_04);
	}
}

//Function Number: 88
avmx_state_enter_action_play_loops(param_00,param_01)
{
	var_02 = self;
	var_03 = var_02 avmx_get_instance_preset();
	var_04 = param_00.ps_item;
	var_05 = param_01.ps_item;
	var_06 = var_05.loops;
	if(isdefined(var_06[0]))
	{
		if(var_06[0] == "all")
		{
			foreach(var_08 in var_02.loop_list)
			{
				avmx_set_loop_play_state(var_08,1);
			}

			return;
		}

		if(var_06[0] == "none")
		{
			foreach(var_08 in var_02.loop_list)
			{
				avmx_set_loop_play_state(var_08,0);
			}

			return;
		}

		return;
	}

	if(var_06.size > 0)
	{
		var_0B = [];
		var_0C = [];
		foreach(var_09, var_08 in var_02.loop_list)
		{
			if(isdefined(var_06[var_09]))
			{
				var_0B[var_09] = var_08;
				continue;
			}

			var_0C[var_09] = var_08;
		}

		foreach(var_08 in var_0B)
		{
			avmx_set_loop_play_state(var_08,1);
		}

		foreach(var_08 in var_0C)
		{
			avmx_set_loop_play_state(var_08,0);
		}
	}
}

//Function Number: 89
input_callback_distance2d()
{
	var_00 = avmx_get_vehicle_entity();
	return distance2d(var_00.origin,level.player.origin);
}

//Function Number: 90
input_callback_distance()
{
	var_00 = avmx_get_vehicle_entity();
	return distance(var_00.origin,level.player.origin);
}

//Function Number: 91
input_callback_throttle()
{
	var_00 = avmx_get_vehicle_entity();
	return var_00 vehicle_getthrottle();
}

//Function Number: 92
input_callback_speed()
{
	var_00 = avmx_get_vehicle_entity();
	var_01 = length(var_00 vehicle_getvelocity() * 0.05681818);
	return var_01;
}

//Function Number: 93
input_callback_relative_speed()
{
	var_00 = avmx_get_vehicle_entity();
	var_01 = var_00 vehicle_getvelocity();
	var_02 = level.player getvelocity();
	var_03 = var_01 - var_02;
	var_04 = length(var_03) * 0.05681818;
	return var_04;
}

//Function Number: 94
input_callback_speed_mph()
{
	var_00 = avmx_get_vehicle_entity();
	if(isdefined(var_00.fakespeed))
	{
		return var_00.fakespeed;
	}

	return var_00 maps\_shg_utility::get_differentiated_speed() * 0.05681818;
}

//Function Number: 95
input_callback_acceleration_g()
{
	var_00 = avmx_get_vehicle_entity();
	return length(var_00 maps\_shg_utility::get_differentiated_acceleration()) * 0.00125;
}

//Function Number: 96
input_callback_jerk_gps()
{
	var_00 = avmx_get_vehicle_entity();
	return length(var_00 maps\_shg_utility::get_differentiated_jerk()) * 0.00125;
}

//Function Number: 97
input_callback_doppler()
{
	var_00 = avmx_get_vehicle_entity();
	return dopplerpitch(var_00.origin,var_00 vehicle_getvelocity(),level.player.origin,level.player getvelocity());
}

//Function Number: 98
input_callback_doppler_exaggerated()
{
	var_00 = avmx_get_vehicle_entity();
	return dopplerpitch(var_00.origin,var_00 vehicle_getvelocity(),level.player.origin,level.player getvelocity(),2,5);
}

//Function Number: 99
input_callback_doppler_subtle()
{
	var_00 = avmx_get_vehicle_entity();
	return dopplerpitch(var_00.origin,var_00 vehicle_getvelocity(),level.player.origin,level.player getvelocity(),1,0.5);
}

//Function Number: 100
avm_compute_doppler_pitch(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	if(!isdefined(param_04))
	{
		param_04 = 1;
	}

	if(!isdefined(param_05))
	{
		param_05 = 1;
	}

	if(!isdefined(param_06))
	{
		param_06 = 13397;
	}

	if(param_04 != 1)
	{
		var_07 = param_01 - param_03;
		var_08 = vectornormalize(var_07);
		var_09 = param_02 - param_00;
		var_0A = var_08 * vectordot(var_08,var_09);
		var_0B = var_09 - var_0A;
		param_02 = param_00 + var_0A + var_0B / param_04;
	}

	var_0C = vectornormalize(param_00 - param_02);
	var_0D = vectordot(param_01,var_0C);
	var_0E = vectordot(param_03,var_0C);
	var_0F = param_06 + var_0E / param_06 + var_0D;
	var_0F = pow(var_0F,param_05);
	var_0F = clamp(var_0F,0.1,1.99);
	return var_0F;
}

//Function Number: 101
input_callback_pitch()
{
	var_00 = avmx_get_vehicle_entity();
	var_01 = var_00.angles[0];
	return var_01;
}

//Function Number: 102
input_callback_yaw()
{
	var_00 = avmx_get_vehicle_entity();
	var_01 = var_00.angles[1];
	return var_01;
}

//Function Number: 103
input_callback_pitch_roll_max()
{
	var_00 = avmx_get_vehicle_entity();
	return max(abs(angleclamp180(var_00.angles[0])),abs(angleclamp180(var_00.angles[2])));
}

//Function Number: 104
input_callback_degrees_from_upright()
{
	var_00 = avmx_get_vehicle_entity();
	return acos(anglestoup(var_00.angles)[2]);
}

//Function Number: 105
input_callback_jetbike_thrust()
{
	var_00 = avmx_get_vehicle_entity();
	return var_00 method_844C();
}

//Function Number: 106
input_callback_jetbike_drag()
{
	var_00 = avmx_get_vehicle_entity();
	return var_00 method_844D();
}

//Function Number: 107
input_callback_jetbike_anti_slip()
{
	var_00 = avmx_get_vehicle_entity();
	return var_00 method_844E();
}

//Function Number: 108
input_callback_jetbike_total_repulsor()
{
	var_00 = avmx_get_vehicle_entity();
	return var_00 method_844F();
}

//Function Number: 109
input_callback_player_jetbike_height()
{
	var_00 = 0;
	var_01 = avmx_get_vehicle_entity();
	var_02 = 0.1;
	if(avmx_is_player_mode())
	{
		if(!isdefined(var_01.amv_jetbike_height_time))
		{
			var_01.amv_jetbike_height_time = 0;
		}

		var_03 = gettime();
		if(var_03 > var_01.amv_jetbike_height_time + var_02)
		{
			var_01.amv_jetbike_height_time = var_03;
			var_04 = bullettrace(var_01.origin,var_01.origin - (0,0,360),0);
			var_01.amv_jetbike_height_val = var_04["fraction"];
			if(!isdefined(var_01.amv_jetbike_height_val))
			{
				var_01.amv_jetbike_height_val = 0;
			}
		}

		var_00 = clamp(var_01.amv_jetbike_height_val,0,1);
	}

	return var_00;
}

//Function Number: 110
input_hovertank_anti_slip()
{
	var_00 = avmx_get_vehicle_entity();
	return var_00 method_8471();
}

//Function Number: 111
input_hovertank_anti_slip_magnitude()
{
	var_00 = input_hovertank_anti_slip();
	return var_00[0];
}

//Function Number: 112
input_hovertank_anti_slip_direction()
{
	var_00 = input_hovertank_anti_slip();
	return var_00[1];
}

//Function Number: 113
input_hovertank_auto_yaw()
{
	var_00 = avmx_get_vehicle_entity();
	return var_00 method_8473();
}

//Function Number: 114
input_hovertank_auto_yaw_magnitude()
{
	var_00 = input_hovertank_auto_yaw();
	return var_00[0];
}

//Function Number: 115
input_hovertank_auto_yaw_direction()
{
	var_00 = input_hovertank_auto_yaw();
	return var_00[1];
}

//Function Number: 116
input_hovertank_repulsors()
{
	var_00 = avmx_get_vehicle_entity();
	return var_00 method_8470();
}

//Function Number: 117
input_hovertank_repulsor_front_left()
{
	var_00 = input_hovertank_repulsors();
	return var_00[0];
}

//Function Number: 118
input_hovertank_repulsor_front_right()
{
	var_00 = input_hovertank_repulsors();
	return var_00[1];
}

//Function Number: 119
input_hovertank_repulsor_back_left()
{
	var_00 = input_hovertank_repulsors();
	return var_00[2];
}

//Function Number: 120
input_hovertank_repulsor_back_right()
{
	var_00 = input_hovertank_repulsors();
	return var_00[3];
}

//Function Number: 121
input_hovertank_throttle()
{
	var_00 = avmx_get_vehicle_entity();
	return var_00 method_846F();
}

//Function Number: 122
input_hovertank_throttle_magnitude()
{
	var_00 = input_hovertank_throttle();
	return var_00[0];
}

//Function Number: 123
input_hovertank_throttle_direction()
{
	var_00 = input_hovertank_throttle();
	return var_00[1];
}

//Function Number: 124
input_hovertank_uprighting()
{
	var_00 = avmx_get_vehicle_entity();
	return var_00 method_8472();
}

//Function Number: 125
input_hovertank_turret_pch()
{
	var_00 = avmx_get_vehicle_entity();
	var_01 = var_00.turret method_8475();
	var_01 = abs(var_01);
	var_01 = clamp(var_01,0,90);
	var_01 = avmx_normalize_ranged_value(var_01,0,90);
	var_02 = level.player getnormalizedcameramovement();
	var_03 = abs(var_02[0]);
	return 0;
}

//Function Number: 126
input_hovertank_turret_yaw()
{
	var_00 = avmx_get_vehicle_entity();
	var_01 = var_00.turret method_8474();
	var_01 = abs(var_01);
	var_02 = var_00.turret method_8475();
	var_02 = abs(var_02);
	var_03 = length2d((var_01,var_02,0));
	var_03 = clamp(var_03,0,135);
	var_04 = avmx_normalize_ranged_value(var_03,0,135);
	var_05 = level.player getnormalizedcameramovement();
	var_06 = length2d(var_05);
	return var_04 * var_06;
}

//Function Number: 127
input_diveboat_throttle()
{
	var_00 = avmx_get_vehicle_entity();
	if(isdefined(level.aud.diveboat_ending) && level.aud.diveboat_ending == 1)
	{
		level.aud.diveboat_throttle = level.aud.diveboat_throttle * 0.94;
		return level.aud.diveboat_throttle;
	}

	var_01 = var_00 method_8512();
	if(var_01 != 0)
	{
		level.aud.diveboat_throttle = var_01;
	}

	return var_01;
}

//Function Number: 128
input_diveboat_drag()
{
	var_00 = avmx_get_vehicle_entity();
	var_01 = var_00 method_8513();
	return var_01;
}

//Function Number: 129
input_diveboat_drag_with_mph()
{
	var_00 = input_diveboat_drag();
	var_01 = input_callback_speed_mph();
	var_02 = var_01 + abs(var_00) * 0.1;
	return var_01 + abs(var_00) * 0.1;
}

//Function Number: 130
input_player_pdrone_look()
{
	var_00 = level.player getnormalizedcameramovement();
	var_01 = abs(var_00[0]);
	var_02 = abs(var_00[1]);
	if(var_01 > var_02)
	{
		return var_01;
	}

	return var_02;
}

//Function Number: 131
avmx_start_oneshot_alias(param_00,param_01)
{
	var_02 = self;
	var_03 = param_00.ps_item;
	var_04 = undefined;
	var_05 = var_02 avmx_get_sound_alias(var_03,param_01);
	if(isstring(var_05))
	{
		var_06 = var_02 avmx_get_vehicle_entity();
		var_04 = spawn("script_origin",var_06.origin);
		var_04 linkto(var_06,"tag_origin",var_02.sound_offset,(0,0,0));
		var_04 scalevolume(0);
		var_04 soundscripts\_snd_playsound::snd_play(var_05,"sound_done");
		var_04 thread avmx_monitor_oneshot_done("sound_done");
	}

	return var_04;
}

//Function Number: 132
avmx_monitor_oneshot_done(param_00)
{
	self endon("death");
	self waittill(param_00);
	if(isdefined(self))
	{
		self delete();
	}
}

//Function Number: 133
avmx_is_player_mode()
{
	return isdefined(self.player_mode) && self.player_mode;
}

//Function Number: 134
avmx_get_sound_alias(param_00,param_01)
{
	var_02 = self;
	var_03 = param_00.asset_names[soundscripts\_audio::aud_get_optional_param(0,param_01)];
	if(isdefined(var_03) && var_02 avmx_is_player_mode())
	{
		var_03 = var_03 + "_plr";
	}

	return var_03;
}

//Function Number: 135
avmx_get_sound_alias_count(param_00)
{
	return param_00.asset_names.size;
}

//Function Number: 136
avmx_update_sound_ent_output_param(param_00,param_01)
{
	switch(param_00)
	{
		case "volume":
			break;

		case "pitch":
			break;

		default:
			break;
	}
}

//Function Number: 137
avmx_handle_oneshot_ducking(param_00)
{
	var_01 = self;
	var_02 = param_00.ps_item;
	var_01 avmx_add_oneshot_ducking_scalar(var_02.name);
	var_01 avmx_update_oneshot_duck_scalar(param_00);
	var_01 avmx_remove_oneshot_ducking_scalar(var_02.name);
}

//Function Number: 138
avmx_update_oneshot_duck_scalar(param_00)
{
	var_01 = self;
	var_02 = var_01 avmx_get_instance_preset();
	var_03 = param_00.ps_item;
	level endon("msg_snd_vehicle_stop");
	level endon("msg_snd_vehicle_stop_" + var_01 avmx_get_instance_name());
	var_01 avmx_get_vehicle_entity() endon("death");
	if(isdefined(var_03.duck_env_name))
	{
		var_04 = var_02 avmx_get_envelope(var_03.duck_env_name);
		var_05 = soundscripts\_audio::aud_get_envelope_domain(var_04);
		var_06 = 0;
		var_07 = var_05[1];
		var_08 = var_03.name;
		while(avmx_are_all_defined(param_00.snd_ents) && var_06 < var_07)
		{
			var_09 = param_00 avmx_get_instance_sound_item_volume();
			var_0A = var_02 avmx_map_input(var_06,var_03.duck_env_name);
			var_0A = 1 - var_09 * 1 - var_0A;
			var_01 avmx_set_oneshot_ducking_scalar(var_08,var_0A);
			wait(0.1);
			var_06 = var_06 + 0.1;
		}
	}
}

//Function Number: 139
avmx_are_all_defined(param_00)
{
	var_01 = 1;
	foreach(var_03 in param_00)
	{
		if(!isdefined(var_03))
		{
			var_01 = 0;
			break;
		}
	}

	return var_01;
}

//Function Number: 140
avmx_add_oneshot_ducking_scalar(param_00)
{
	self.oneshot_duck_vals[param_00] = 1;
}

//Function Number: 141
avmx_remove_oneshot_ducking_scalar(param_00)
{
	self.oneshot_duck_vals[param_00] = undefined;
}

//Function Number: 142
avmx_set_oneshot_ducking_scalar(param_00,param_01)
{
	self.oneshot_duck_vals[param_00] = param_01;
}

//Function Number: 143
avmx_normalize_ranged_value(param_00,param_01,param_02)
{
	return param_00 - param_01 / param_02 - param_01;
}

//Function Number: 144
avmx_get()
{
	return level._audio.vm;
}

//Function Number: 145
avmx_get_callback(param_00)
{
	return avmx_get().callbacks[param_00][0];
}

//Function Number: 146
avmx_get_preset_name()
{
	return self.header.preset_name;
}

//Function Number: 147
avmx_set_preset_name(param_00)
{
	self.header.preset_name = param_00;
}

//Function Number: 148
avmx_set_instance_init_callback(param_00)
{
	self.global_data.instance_init_callback = param_00;
}

//Function Number: 149
avmx_get_instance_name()
{
	return self.instance_name;
}

//Function Number: 150
avmx_get_instance_preset_name()
{
	return self.preset_name;
}

//Function Number: 151
avmx_get_instance_preset()
{
	return avmx_get_preset(self.preset_name);
}

//Function Number: 152
avmx_get_preset(param_00)
{
	var_01 = avmx_get();
	return var_01.presets[param_00];
}

//Function Number: 153
avmx_get_instance(param_00,param_01)
{
	var_02 = undefined;
	var_03 = avmx_get();
	if(isstring(param_01))
	{
		var_04 = avmx_get_preset(param_01);
		if(isdefined(var_04))
		{
			var_02 = var_04.instances[param_00];
		}
	}
	else
	{
		foreach(var_04 in var_04.presets)
		{
			foreach(var_07 in var_04.instances)
			{
				if(var_07.instance_name == param_00)
				{
					var_02 = var_07;
					break;
				}
			}
		}
	}

	return var_02;
}

//Function Number: 154
avmx_get_vehicle_entity()
{
	return self.veh_ent;
}

//Function Number: 155
avmx_get_sound_instance()
{
	return self.snd_instance;
}

//Function Number: 156
avmx_get_fadein_time()
{
	return self.header.fadein_time;
}

//Function Number: 157
avmx_get_fadeout_time()
{
	return self.header.fadeout_time;
}

//Function Number: 158
avmx_set_behavior_oneshot_overrides(param_00,param_01)
{
	param_00.oneshot_overrides = param_01;
}

//Function Number: 159
avmx_get_behavior_restricted_oneshots(param_00)
{
	var_01 = self;
	var_02 = [];
	var_03 = param_00.ps_item;
	var_04 = avmx_get_preset(var_03.preset_name);
	var_05 = param_00.oneshot_overrides;
	if(!isdefined(var_05))
	{
		var_05 = var_03.oneshots;
	}

	foreach(var_07 in var_05)
	{
		if(var_01 avmx_get_oneshot_poly_mode(var_07) == 1)
		{
			var_02[var_07] = var_07;
		}
	}

	return var_02;
}

//Function Number: 160
avmx_get_oneshot_poly_mode(param_00)
{
	var_01 = self;
	var_02 = var_01.oneshot_list[param_00].ps_item;
	return var_02.oneshot_poly_mode;
}

//Function Number: 161
avmx_get_oneshot_update_mode(param_00)
{
	var_01 = self;
	var_02 = 0;
	if(isstring(param_00))
	{
		var_03 = var_01.oneshot_list[param_00].ps_item;
	}
	else
	{
		var_03 = var_01.ps_item;
	}

	var_02 = var_03.oneshot_update_mode;
	if(!isdefined(var_02))
	{
		var_02 = 0;
	}

	return var_02;
}

//Function Number: 162
avmx_get_envelope(param_00)
{
	return self.env_data[param_00];
}

//Function Number: 163
avmx_map_input(param_00,param_01)
{
	var_02 = self;
	var_03 = var_02 avmx_get_envelope(param_01);
	if(isdefined(var_03.env_function))
	{
		var_04 = [[ var_03.env_function ]](param_00);
	}
	else
	{
		var_04 = piecewiselinearlookup(param_01,var_04.env_array);
	}

	return var_04;
}

//Function Number: 164
avmx_start_loop(param_00)
{
	var_01 = self;
	var_02 = var_01 avmx_get_instance_preset();
	var_03 = var_01 avmx_get_vehicle_entity();
	var_04 = param_00.ps_item;
	var_05 = var_02 avmx_get_sound_alias_count(var_04);
	var_06 = var_01.sound_offset;
	var_07 = param_00.ps_item.fadeout_time;
	var_08 = 1;
	param_00.fade_in_inc = 0.1 / var_07;
	param_00.fade_in_scalar = 0;
	for(var_09 = 0;var_09 < var_05;var_09++)
	{
		var_0A = var_01 avmx_get_sound_alias(var_04,var_09);
		var_0B = spawn("script_origin",var_03.origin);
		var_0B linkto(var_03,"tag_origin",var_06,(0,0,0));
		var_0B scalevolume(0);
		var_0B soundscripts\_snd_playsound::snd_play_loop(var_0A);
		param_00.snd_ents[var_0A] = var_0B;
	}
}

//Function Number: 165
avmx_stop_loop(param_00)
{
	var_01 = self;
	var_02 = param_00.snd_ents;
	param_00.snd_ents = [];
	foreach(var_04 in var_02)
	{
		var_04 thread avmx_stop_snd_ent(param_00.ps_item.fadeout_time);
	}
}

//Function Number: 166
avmx_stop_snd_ent(param_00)
{
	var_01 = self;
	param_00 = max(0.05,soundscripts\_audio::aud_get_optional_param(0.05,param_00));
	if(isdefined(var_01))
	{
		var_01 setvolume(0,param_00);
		wait(param_00);
		if(isdefined(var_01))
		{
			var_01 stopsounds();
		}

		wait(0.05);
		if(isdefined(var_01))
		{
			var_01 delete();
		}
	}
}

//Function Number: 167
vm2x_fadeout_vehicle(param_00)
{
	var_01 = self;
	foreach(var_03 in var_01.loop_list)
	{
		var_03 avmx_fade_stop_and_delete_sound_obj(param_00);
	}

	foreach(var_06 in var_01.oneshot_list)
	{
		var_06 avmx_fade_stop_and_delete_sound_obj(param_00);
	}
}

//Function Number: 168
avmx_fade_stop_and_delete_sound_obj(param_00)
{
	var_01 = self;
	switch(var_01.ps_item.asset_type)
	{
		case "alias":
			break;

		case "soundevent":
			break;

		case "damb":
			break;
	}
}

//Function Number: 169
vm2x_delete_vehicle_sound_ents()
{
	var_00 = self;
	var_01 = var_00.loop_list;
	var_03 = getfirstarraykey(var_01);
	if(isdefined(var_03))
	{
		var_02 = var_01[var_03];
		switch(var_02.ps_item.asset_type)
		{
			case "alias":
				break;

			case "soundevent":
				break;

			case "damb":
				break;

			default:
				break;
		}
	}
}

//Function Number: 170
units2yards(param_00)
{
	return param_00 * 0.02777778;
}

//Function Number: 171
yards2units(param_00)
{
	return param_00 * 36;
}

//Function Number: 172
dist2yards(param_00)
{
	return param_00 * 0.02777778;
}

//Function Number: 173
yards2dist(param_00)
{
	return param_00 * 36;
}

//Function Number: 174
avmx_vehicle_getspeed()
{
	var_00 = 0;
	if(avmx_is_vehicle_proxy() == 0)
	{
		var_00 = self vehicle_getspeed();
	}

	return var_00;
}