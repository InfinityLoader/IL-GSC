/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: _audio_vehicles.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 46
 * Decompile Time: 557 ms
 * Timestamp: 4/22/2024 2:03:53 AM
*******************************************************************/

//Function Number: 1
vm_init()
{
	if(!isdefined(level._audio))
	{
		level._audio = spawnstruct();
	}

	if(!isdefined(level._audio.veh))
	{
		level._audio.veh = spawnstruct();
		level._audio.veh.minrate = 0.1;
		level._audio.veh.defrate = 0.5;
		level._audio.veh.defsmooth = 0.1;
		level._audio.veh.minpitch = 0.5;
		level._audio.veh.maxpitch = 1.5;
		level._audio.veh.fadein_time = 2;
		level._audio.veh.callbacks = [];
		level._audio.veh.print_speed = 0;
		level._audio.veh.print_tilt = 0;
		level._audio.veh.print_yaw = 0;
		level._audio.veh.print_roll = 0;
		level._audio.veh.print_altitude = 0;
		level._audio.veh.print_throttle = 0;
		level._audio.veh.presets = [];
		level._audio.veh.maps = [];
		level._audio.veh.instances = [];
		level._audio.veh.ducked_instances = [];
		level._audio.veh.duck_starts = [];
		level._audio.veh.duck_stops = [];
	}
}

//Function Number: 2
vm_register_custom_callback(param_00,param_01)
{
	level._audio.veh.callbacks[param_00] = param_01;
}

//Function Number: 3
vm_start_preset(param_00,param_01,param_02,param_03,param_04,param_05)
{
	wait(0.25);
	if(isdefined(level._audio.veh.instances[param_00]))
	{
		vm_stop_preset_instance(param_00);
	}

	if(isdefined(param_04))
	{
		thread soundscripts\_audio::deprecated_aud_play_linked_sound(param_04,param_02,undefined,undefined,param_05);
	}

	level._audio.veh.instances[param_00] = [];
	level._audio.veh.instances[param_00]["entity"] = param_02;
	if(!isdefined(level._audio.veh.presets[param_01]))
	{
		var_06 = [];
		var_06 = soundscripts\_audio_presets_vehicles::audio_presets_vehicles(param_01,var_06);
		level._audio.veh.presets[param_01] = var_06;
	}

	level._audio.veh.instances[param_00]["entity"] = param_02;
	foreach(var_13, var_08 in level._audio.veh.presets[param_01])
	{
		var_09 = spawnstruct();
		var_09.instance_name = param_00;
		var_09.vehicle = param_02;
		switch(var_13)
		{
			case "tilt":
				var_09.type = "tilt";
				var_09.callback = ::vmx_get_tilt;
				var_09.min = -45;
				var_09.max = 45;
				break;

			case "yaw":
				var_09.type = "yaw";
				var_09.callback = ::vmx_get_yaw;
				var_09.min = 0;
				var_09.max = 360;
				break;

			case "roll":
				var_09.type = "roll";
				var_09.callback = ::vmx_get_roll;
				var_09.min = -45;
				var_09.max = 45;
				break;

			case "speed":
				var_09.type = "speed";
				var_09.callback = ::vmx_get_speed;
				var_09.min = 0;
				var_09.max = 100;
				break;

			case "altitude":
				var_09.type = "altitude";
				var_09.callback = ::vmx_get_altitude;
				var_09.min = 0;
				var_09.max = 100;
				break;

			case "start_stop":
				var_09.type = "start_stop";
				var_09.callback = ::vmx_get_throttle;
				var_09.min = 0;
				var_09.max = 1;
				break;

			default:
				break;
		}

		var_09.smoothness = level._audio.veh.defsmooth;
		var_09.smooth_up = undefined;
		var_09.smooth_down = undefined;
		var_09.updaterate = level._audio.veh.defrate;
		var_09.alias_data = [];
		var_09.fadein = 0.5;
		if(isdefined(param_03))
		{
			var_09.fadein = param_03;
		}

		foreach(var_0B in var_08)
		{
			switch(var_0B[0])
			{
				case "updaterate":
					var_09.updaterate = var_0B[1];
					break;

				case "smoothness":
					var_09.smoothness = var_0B[1];
					break;

				case "smooth_up":
					var_09.smooth_up = var_0B[1];
					break;

				case "smooth_down":
					var_09.smooth_down = var_0B[1];
					break;

				case "heightmax":
					var_09.heightmax = var_0B[1];
					break;

				case "callback":
					var_0C = var_0B[1];
					var_09.custom_callback = level._audio.veh.callbacks[var_0C];
					break;

				case "range":
					var_09.min = min(var_0B[1],var_0B[2]);
					var_09.max = max(var_0B[1],var_0B[2]);
					break;

				case "multiply_by_throttle":
					var_09.multiply_by_throttle = 1;
					break;

				case "multiply_by_leftstick":
					var_09.multiply_by_leftstick = 1;
					break;

				case "start":
					var_09.start_alias_data = spawnstruct();
					var_09.start_alias_data.name = var_0B[1];
					for(var_0D = 2;var_0D < var_0B.size;var_0D++)
					{
						if(isarray(var_0B[var_0D]))
						{
							var_0E = var_0B[var_0D][0];
							var_0F = var_0B[var_0D][1];
							if(var_0E == "pitch")
							{
								var_09.start_alias_data.pitch_map_name = var_0F;
							}
							else if(var_0E == "volume")
							{
								var_09.start_alias_data.volume_map_name = var_0F;
							}
	
							if(!isdefined(level._audio.veh.maps[var_0F]))
							{
								var_10 = [];
								var_10 = soundscripts\_audio_presets_vehicles::audio_presets_vehicle_maps(var_0F,var_10);
								level._audio.veh.maps[var_0F] = var_10;
							}
	
							continue;
						}
	
						level._audio.veh.duck_starts[param_00] = var_0B[var_0D];
					}
					break;

				case "stop":
					var_09.stop_alias_data = spawnstruct();
					var_09.stop_alias_data.name = var_0B[1];
					for(var_0D = 2;var_0D < var_0B.size;var_0D++)
					{
						if(isarray(var_0B[var_0D]))
						{
							var_0E = var_0B[var_0D][0];
							var_0F = var_0B[var_0D][1];
							if(var_0E == "pitch")
							{
								var_09.stop_alias_data.pitch_map_name = var_0F;
							}
							else if(var_0E == "volume")
							{
								var_09.stop_alias_data.volume_map_name = var_0F;
							}
	
							if(!isdefined(level._audio.veh.maps[var_0F]))
							{
								var_10 = [];
								var_10 = soundscripts\_audio_presets_vehicles::audio_presets_vehicle_maps(var_0F,var_10);
								level._audio.veh.maps[var_0F] = var_10;
							}
	
							continue;
						}
	
						level._audio.veh.duck_stops[param_00] = var_0B[var_0D];
					}
					break;

				case "throttle_input":
					var_09.throttle_input = var_0B[1];
					break;

				case "on_threshold":
					var_09.on_threshold = var_0B[1];
					break;

				case "off_threshold":
					var_09.off_threshold = var_0B[1];
					break;

				case "oneshot_duck":
					var_09.duck_amount = var_0B[1];
					break;

				case "oneshot_duck_time":
					var_09.duck_time = var_0B[1];
					break;

				case "offset":
					var_09.offset = var_0B[1];
					break;

				default:
					var_11 = spawnstruct();
					var_11.alias_name = var_0B[0];
					for(var_0D = 1;var_0D < var_0B.size;var_0D++)
					{
						var_0F = var_0B[var_0D][1];
						if(var_0B[var_0D][0] == "pitch")
						{
							var_11.pitch_map_name = var_0F;
						}
						else
						{
							var_11.vol_map_name = var_0F;
						}
	
						if(!isdefined(level._audio.veh.maps[var_0F]))
						{
							var_10 = [];
							var_10 = soundscripts\_audio_presets_vehicles::audio_presets_vehicle_maps(var_0F,var_10);
							level._audio.veh.maps[var_0F] = var_10;
						}
					}
	
					var_09.alias_data[var_09.alias_data.size] = var_11;
					break;
			}
		}

		if(var_09.type == "start_stop")
		{
			thread vmx_do_start_stop_callback(var_09);
			continue;
		}

		thread vmx_callback(var_09);
	}
}

//Function Number: 4
vm_stop(param_00)
{
	level notify("aud_veh_stop");
	var_01 = 1;
	if(isdefined(param_00))
	{
		var_01 = max(0.1,param_00);
	}

	foreach(var_03 in level._audio.veh.playing_presets)
	{
		if(var_03.size > 0)
		{
			foreach(var_05 in var_03)
			{
				thread soundscripts\_audio::aud_fade_out_and_delete(var_05,var_01);
			}
		}
	}

	level._audio.veh.playing_presets = [];
}

//Function Number: 5
vm_stop_preset_instance(param_00,param_01)
{
	var_02 = 1;
	if(isdefined(param_01))
	{
		var_02 = max(0.01,param_01);
	}

	if(isdefined(level._audio.veh.instances[param_00]))
	{
		level notify("aud_veh_stop_" + param_00);
		if(level._audio.veh.instances[param_00].size > 0)
		{
			foreach(var_05, var_04 in level._audio.veh.instances[param_00])
			{
				if(var_05 != "entity" && var_05 != "speed" && var_05 != "throttle")
				{
					var_04 scalevolume(0,var_02);
				}
			}
		}

		wait(var_02 + 0.05);
		if(level._audio.veh.instances[param_00].size > 0)
		{
			foreach(var_05, var_04 in level._audio.veh.instances[param_00])
			{
				if(var_05 != "entity" && var_05 != "speed" && var_05 != "throttle")
				{
					var_04 delete();
				}
			}
		}

		level._audio.veh.instances[param_00] = undefined;
	}
}

//Function Number: 6
vm_set_range(param_00,param_01,param_02)
{
	if(!isdefined(self.aud_overrides))
	{
		self.aud_overrides = [];
	}

	self.aud_overrides[param_00] = spawnstruct();
	self.aud_overrides[param_00].min_range = param_01;
	self.aud_overrides[param_00].max_range = param_02;
}

//Function Number: 7
vmx_init_oneshot_ents(param_00)
{
	if(!isdefined(level._audio.veh.start_ents))
	{
		level._audio.veh.start_ents = [];
	}

	if(!isdefined(level._audio.veh.stop_ents))
	{
		level._audio.veh.stop_ents = [];
	}

	if(!isdefined(level._audio.veh.start_ent_count))
	{
		level._audio.veh.start_ent_count = [];
	}

	if(!isdefined(level._audio.veh.stop_ent_count))
	{
		level._audio.veh.stop_ent_count = [];
	}

	level._audio.veh.start_ents[param_00] = [];
	level._audio.veh.start_ent_count[param_00] = 0;
	level._audio.veh.stop_ents[param_00] = [];
	level._audio.veh.stop_ent_count[param_00] = 0;
}

//Function Number: 8
vmx_get_need_to_duck(param_00)
{
	var_01 = 0;
	if(isdefined(level._audio.veh.duck_starts[param_00]) && level._audio.veh.duck_starts[param_00] && vmx_get_start_sound_playing(param_00))
	{
		var_01 = 1;
	}

	if(isdefined(level._audio.veh.duck_stops[param_00]) && level._audio.veh.duck_stops[param_00] && vmx_get_stop_sound_playing(param_00))
	{
		var_01 = 1;
	}

	return var_01;
}

//Function Number: 9
vmx_get_start_sound_playing(param_00)
{
	if(level._audio.veh.start_ents[param_00].size > 0)
	{
		return 1;
	}

	return 0;
}

//Function Number: 10
vmx_get_stop_sound_playing(param_00)
{
	if(level._audio.veh.stop_ents[param_00].size > 0)
	{
		return 1;
	}

	return 0;
}

//Function Number: 11
vmx_scale_start_sound_pitch(param_00,param_01,param_02)
{
	foreach(var_04 in level._audio.veh.start_ents[param_02])
	{
		if(isdefined(var_04))
		{
			var_04 setpitch(param_00,param_01);
		}
	}
}

//Function Number: 12
vmx_scale_stop_sound_pitch(param_00,param_01,param_02)
{
	foreach(var_04 in level._audio.veh.stop_ents[param_02])
	{
		if(isdefined(var_04))
		{
			var_04 setpitch(param_00,param_01);
		}
	}
}

//Function Number: 13
vmx_scale_start_sound_volume(param_00,param_01,param_02)
{
	foreach(var_04 in level._audio.veh.start_ents[param_02])
	{
		if(isdefined(var_04))
		{
			var_04 scalevolume(param_00,param_01);
		}
	}
}

//Function Number: 14
vmx_scale_stop_sound_volume(param_00,param_01,param_02)
{
	foreach(var_04 in level._audio.veh.stop_ents[param_02])
	{
		if(isdefined(var_04))
		{
			var_04 scalevolume(param_00,param_01);
		}
	}
}

//Function Number: 15
vmx_play_start_sound(param_00,param_01,param_02,param_03)
{
	var_04 = 0;
	if(isdefined(param_03))
	{
		var_04 = param_03;
	}

	var_05 = spawn("script_origin",param_01.origin);
	var_05 linkto(param_01,"tag_origin",(var_04,0,0),(0,0,0));
	var_05.ref = level._audio.veh.start_ent_count[param_02];
	var_05 playsound(param_00,"sounddone");
	var_05 thread vmx_monitor_start_ent(param_02);
	level._audio.veh.start_ents[param_02][var_05.ref] = var_05;
	level._audio.veh.start_ent_count[param_02]++;
}

//Function Number: 16
vmx_play_stop_sound(param_00,param_01,param_02,param_03)
{
	var_04 = 0;
	if(isdefined(param_03))
	{
		var_04 = param_03;
	}

	var_05 = spawn("script_origin",param_01.origin);
	var_05 linkto(param_01,"tag_origin",(var_04,0,0),(0,0,0));
	var_05.ref = level._audio.veh.stop_ent_count[param_02];
	var_05 playsound(param_00,"sounddone");
	level._audio.veh.stop_ents[param_02][var_05.ref] = var_05;
	level._audio.veh.stop_ent_count[param_02]++;
	wait(0.05);
	var_05 thread vmx_monitor_stop_ent(param_02);
}

//Function Number: 17
vmx_monitor_start_ent(param_00)
{
	self endon("kill");
	self waittill("sounddone");
	level._audio.veh.start_ents[param_00][self.ref] = undefined;
	if(isdefined(level._audio.veh.ducked_instances[param_00]))
	{
		level._audio.veh.ducked_instances[param_00] = undefined;
	}

	self delete();
}

//Function Number: 18
vmx_monitor_stop_ent(param_00)
{
	self endon("kill");
	self waittill("sounddone");
	level._audio.veh.stop_ents[param_00][self.ref] = undefined;
	if(isdefined(level._audio.veh.ducked_instances[param_00]))
	{
		level._audio.veh.ducked_instances[param_00] = undefined;
	}

	self delete();
}

//Function Number: 19
vmx_stop_stop_ent(param_00,param_01,param_02)
{
	if(isdefined(level._audio.veh.ducked_instances[param_02]))
	{
		level._audio.veh.ducked_instances[param_02] = undefined;
	}

	var_03 = 0.1;
	if(isdefined(param_01))
	{
		var_03 = param_01;
	}

	level._audio.veh.stop_ents[param_02][param_00.ref] = undefined;
	param_00 scalevolume(0,var_03 + 0.05);
	param_00 notify("kill");
	wait(var_03 + 0.05);
	param_00 stopsounds();
	wait(0.05);
	param_00 delete();
}

//Function Number: 20
vmx_stop_start_ent(param_00,param_01,param_02)
{
	if(isdefined(level._audio.veh.ducked_instances[param_02]))
	{
		level._audio.veh.ducked_instances[param_02] = undefined;
	}

	var_03 = 0.1;
	if(isdefined(param_01))
	{
		var_03 = param_01;
	}

	level._audio.veh.start_ents[param_02][param_00.ref] = undefined;
	param_00 scalevolume(0,var_03 + 0.05);
	param_00 notify("kill");
	wait(var_03 + 0.05);
	param_00 stopsounds();
	wait(0.05);
	param_00 delete();
}

//Function Number: 21
vmx_do_start_stop_callback(param_00)
{
	var_01 = param_00.instance_name;
	level endon("aud_veh_stop");
	level endon("aud_veh_stop_" + var_01);
	level._audio.veh.instances[var_01]["entity"] endon("death");
	var_02 = 0;
	var_03 = 0;
	var_04 = -1;
	var_05 = "off";
	var_06 = param_00.smoothness;
	var_07 = param_00.smooth_up;
	var_08 = param_00.smooth_down;
	var_09 = param_00.min;
	var_0A = param_00.max;
	var_0B = 0;
	vmx_init_oneshot_ents(var_01);
	var_0C = gettime();
	for(;;)
	{
		var_0D = [[ param_00.callback ]](param_00);
		var_0D = var_0D - param_00.min / param_00.max - param_00.min;
		var_0D = clamp(var_0D,0,1);
		var_0B = var_0D;
		if(isdefined(var_07) && var_0D > var_02)
		{
			var_02 = var_02 + var_07 * var_0D - var_02;
		}
		else if(isdefined(var_08) && var_0D <= var_02)
		{
			var_02 = var_02 + var_08 * var_0D - var_02;
		}
		else
		{
			var_02 = var_02 + var_06 * var_0D - var_02;
		}

		var_0E = var_02 - var_03;
		var_03 = var_02;
		var_0F = gettime();
		var_10 = var_0F - var_0C;
		var_11 = 0;
		var_12 = 0;
		if((var_0E >= param_00.on_threshold || var_0B >= 0.99) && var_05 == "off" && var_10 > 200)
		{
			var_0C = var_0F;
			var_05 = "on";
			var_11 = 1;
			wait(0.05);
			var_13 = level._audio.veh.instances[var_01]["entity"];
			thread vmx_play_start_sound(param_00.start_alias_data.name,var_13,param_00.instance_name,param_00.offset);
			if(isdefined(level._audio.veh.stop_ents[param_00.instance_name]))
			{
				var_14 = level._audio.veh.stop_ents[param_00.instance_name];
				foreach(var_13 in var_14)
				{
					thread vmx_stop_stop_ent(var_13,undefined,param_00.instance_name);
				}
			}
		}
		else if((var_0E <= param_00.off_threshold || var_0B <= 0.01) && var_05 == "on" && var_10 > 200)
		{
			var_0C = var_0F;
			var_05 = "off";
			var_12 = 1;
			wait(0.05);
			var_13 = level._audio.veh.instances[var_01]["entity"];
			thread vmx_play_stop_sound(param_00.stop_alias_data.name,var_13,param_00.instance_name,param_00.offset);
			if(isdefined(level._audio.veh.start_ents[param_00.instance_name]))
			{
				var_17 = level._audio.veh.start_ents[param_00.instance_name];
				foreach(var_13 in var_17)
				{
					thread vmx_stop_start_ent(var_13,undefined,param_00.instance_name);
				}
			}
		}

		var_1A = undefined;
		var_1B = undefined;
		if(vmx_get_start_sound_playing(param_00.instance_name))
		{
			if(var_11)
			{
				var_11 = 0;
				if(isdefined(param_00.start_alias_data.pitch_map_name))
				{
					var_1A = soundscripts\_audio::deprecated_aud_map(var_02,level._audio.veh.maps[param_00.start_alias_data.pitch_map_name]);
					var_1A = level._audio.veh.minpitch + var_1A * level._audio.veh.maxpitch - level._audio.veh.minpitch;
					vmx_scale_start_sound_pitch(var_1A,param_00.updaterate,param_00.instance_name);
				}
			}

			if(isdefined(param_00.start_alias_data.vol_map_name))
			{
				var_1B = soundscripts\_audio::deprecated_aud_map(var_02,level._audio.veh.maps[param_00.start_alias_data.vol_map_name]);
				vmx_scale_start_sound_volume(var_1B,param_00.updaterate,param_00.instance_name);
			}
		}

		if(vmx_get_stop_sound_playing(param_00.instance_name))
		{
			if(var_12)
			{
				var_12 = 0;
				if(isdefined(param_00.stop_alias_data.pitch_map_name))
				{
					var_1A = soundscripts\_audio::deprecated_aud_map(var_02,level._audio.veh.maps[param_00.stop_alias_data.pitch_map_name]);
					var_1A = level._audio.veh.minpitch + var_1A * level._audio.veh.maxpitch - level._audio.veh.minpitch;
					vmx_scale_stop_sound_pitch(var_1A,param_00.updaterate,param_00.instance_name);
				}
			}

			if(isdefined(param_00.stop_alias_data.vol_map_name))
			{
				var_1B = soundscripts\_audio::deprecated_aud_map(var_02,level._audio.veh.maps[param_00.stop_alias_data.vol_map_name]);
				vmx_scale_stop_sound_volume(var_1B,param_00.updaterate,param_00.instance_name);
			}
		}

		var_04 = var_02;
		wait(param_00.updaterate);
	}
}

//Function Number: 22
vm_disablethrottleupdate(param_00)
{
	self.aud_engine_disable = 1;
	if(isdefined(param_00))
	{
		self.aud_engine_throttle_amount = param_00;
	}
}

//Function Number: 23
vm_enablethrottleupdate()
{
	self.aud_engine_disable = undefined;
}

//Function Number: 24
vmx_callback(param_00)
{
	var_01 = param_00.instance_name;
	level endon("aud_veh_stop");
	level endon("aud_veh_stop_" + var_01);
	var_02 = undefined;
	var_03 = param_00.smoothness;
	var_04 = param_00.smooth_up;
	var_05 = param_00.smooth_down;
	var_06 = param_00.min;
	var_07 = param_00.max;
	if(isdefined(param_00.heightmax))
	{
		var_08 = level._audio.veh.instances[var_01]["entity"];
		param_00.init_height = var_08.origin[2];
	}

	var_09 = 1;
	for(;;)
	{
		param_00.smoothness = var_03;
		param_00.smooth_up = var_04;
		param_00.smooth_down = var_05;
		var_08 = level._audio.veh.instances[var_01]["entity"];
		if(isdefined(var_08.aud_overrides) && isdefined(var_08.aud_overrides[param_00.type]) && isdefined(var_08.aud_overrides[param_00.type].min_range))
		{
			param_00.min = var_08.aud_overrides[param_00.type].min_range;
			param_00.max = var_08.aud_overrides[param_00.type].max_range;
		}
		else
		{
			param_00.min = var_06;
			param_00.max = var_07;
		}

		if(!isdefined(var_08))
		{
			vm_stop(param_00.instance_name);
			return;
		}

		var_0A = 0;
		var_0B = 0;
		if(isdefined(var_08.aud_engine_disable))
		{
			var_0A = var_08.aud_engine_disable;
			if(isdefined(var_08.aud_engine_throttle_amount))
			{
				var_0B = var_08.aud_engine_throttle_amount;
			}
		}

		var_0C = [[ param_00.callback ]](param_00);
		if(isdefined(param_00.multiply_by_throttle))
		{
			if(var_0A)
			{
				var_0D = var_0B;
			}
			else
			{
				var_0D = vmx_get_throttle(var_01);
			}

			if(level._audio.veh.print_throttle)
			{
				iprintln("throttle: " + var_0D);
			}

			var_0C = var_0C * var_0D;
		}

		var_0C = var_0C - param_00.min / param_00.max - param_00.min;
		var_0C = clamp(var_0C,0,1);
		if(isdefined(var_02))
		{
			if(isdefined(param_00.smooth_up) && var_0C > var_02)
			{
				var_02 = var_02 + param_00.smooth_up * var_0C - var_02;
			}
			else if(isdefined(param_00.smooth_down) && var_0C <= var_02)
			{
				var_02 = var_02 + param_00.smooth_down * var_0C - var_02;
			}
			else
			{
				var_02 = var_02 + param_00.smoothness * var_0C - var_02;
			}
		}
		else
		{
			var_02 = var_0C;
		}

		if(isdefined(param_00.custom_callback))
		{
			[[ param_00.custom_callback ]](var_08,var_02);
		}

		foreach(var_0F in param_00.alias_data)
		{
			thread vmx_update_sound(var_0F,param_00,var_02,var_01,var_09);
		}

		if(var_09)
		{
			var_09 = 0;
			wait(param_00.fadein);
			continue;
		}

		wait(param_00.updaterate);
	}
}

//Function Number: 25
vmx_update_sound(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = undefined;
	var_06 = undefined;
	if(isdefined(param_00.pitch_map_name))
	{
		var_05 = soundscripts\_audio::deprecated_aud_map(param_02,level._audio.veh.maps[param_00.pitch_map_name]);
		var_05 = level._audio.veh.minpitch + var_05 * level._audio.veh.maxpitch - level._audio.veh.minpitch;
	}

	if(isdefined(param_00.vol_map_name))
	{
		var_06 = soundscripts\_audio::deprecated_aud_map(param_02,level._audio.veh.maps[param_00.vol_map_name]);
	}

	var_07 = 0;
	var_08 = 0;
	if(isdefined(level._audio.veh.ducked_instances[param_03]))
	{
		var_09 = level._audio.veh.ducked_instances[param_03];
		var_0A = gettime();
		var_0B = 2.5;
		if(isdefined(param_01.duck_time))
		{
			var_0B = param_01.duck_time;
		}

		if(var_0A - var_09 < var_0B * 1000)
		{
			var_07 = 1;
		}
	}

	if(!var_07)
	{
		if(!isdefined(level._audio.veh.ducked_instances[param_03]) && vmx_get_need_to_duck(param_03))
		{
			var_07 = 1;
			level._audio.veh.ducked_instances[param_03] = gettime();
		}
	}

	if(var_07)
	{
		var_0C = 0.7;
		if(isdefined(param_01.duck_amount))
		{
			var_0C = param_01.duck_amount;
		}

		var_06 = var_06 * var_0C;
	}

	if(isdefined(param_01.heightmax))
	{
		var_0D = param_01.vehicle.origin[2];
		var_0E = var_0D - param_01.init_height;
		if(var_0E > param_01.heightmax)
		{
			var_06 = 0;
		}
	}

	if(!isdefined(level._audio.veh.instances[param_03][param_00.alias_name]))
	{
		level._audio.veh.instances[param_03][param_00.alias_name] = spawn("script_origin",param_01.vehicle.origin);
		var_0F = 0;
		if(isdefined(param_01.offset))
		{
			var_0F = param_01.offset;
		}

		level._audio.veh.instances[param_03][param_00.alias_name] linkto(param_01.vehicle,"tag_origin",(var_0F,0,0),(0,0,0));
		level._audio.veh.instances[param_03][param_00.alias_name] playloopsound(param_00.alias_name);
		level._audio.veh.instances[param_03][param_00.alias_name] scalevolume(0);
		wait(0.05);
		level._audio.veh.instances[param_03][param_00.alias_name] scalevolume(var_06,param_01.fadein);
		return;
	}

	if(isdefined(var_05))
	{
		level._audio.veh.instances[param_03][param_00.alias_name] setpitch(var_05,param_01.updaterate);
	}

	if(isdefined(var_06))
	{
		level._audio.veh.instances[param_03][param_00.alias_name] scalevolume(var_06,param_01.updaterate);
	}
}

//Function Number: 26
vm_linkto_new_entity(param_00,param_01,param_02,param_03)
{
	var_04 = "tag_origin";
	if(isdefined(param_02))
	{
		var_04 = "tag_origin";
	}

	var_05 = 0;
	if(isdefined(param_03))
	{
		var_05 = param_03;
	}

	if(isdefined(level._audio.veh.instances[param_00]))
	{
		foreach(var_08, var_07 in level._audio.veh.instances[param_00])
		{
			if(var_08 != "entity" && var_08 != "speed" && var_08 != "throttle")
			{
				var_07 unlink();
				var_07 linkto(param_01,var_04,(var_05,0,0),(0,0,0));
			}
		}

		level._audio.veh.instances[param_00]["entity"] = param_01;
	}
}

//Function Number: 27
vm_set_speed_callback(param_00,param_01)
{
	if(isdefined(level._audio.veh.instances[param_00]))
	{
		level._audio.veh.instances[param_00]["speed"] = param_01;
	}
}

//Function Number: 28
vm_set_throttle_callback(param_00,param_01)
{
	if(isdefined(level._audio.veh.instances[param_00]))
	{
		level._audio.veh.instances[param_00]["throttle"] = param_01;
	}
}

//Function Number: 29
vm_set_start_stop_callback(param_00,param_01)
{
	if(isdefined(level._audio.veh.instances[param_00]))
	{
	}
}

//Function Number: 30
vmx_get_tilt(param_00)
{
	var_01 = level._audio.veh.instances[param_00.instance_name]["entity"];
	var_02 = var_01.angles[0];
	if(level._audio.veh.print_tilt)
	{
		iprintln("tilt: " + var_02);
	}

	return var_02;
}

//Function Number: 31
vmx_get_speed(param_00)
{
	var_01 = level._audio.veh.instances[param_00.instance_name]["entity"];
	var_02 = 0;
	if(isdefined(level._audio.veh.instances[param_00.instance_name]["speed"]))
	{
		var_03 = level._audio.veh.instances[param_00.instance_name]["speed"];
		var_02 = var_01 [[ var_03 ]]();
	}
	else
	{
		var_02 = param_00.vehicle vehicle_getspeed();
	}

	if(level._audio.veh.print_speed)
	{
		iprintln("speed: " + var_02);
	}

	return var_02;
}

//Function Number: 32
vmx_get_yaw(param_00)
{
	var_01 = level._audio.veh.instances[param_00.instance_name]["entity"];
	var_02 = var_01.angles[1];
	if(level._audio.veh.print_speed)
	{
		iprintln("yaw: " + var_02);
	}

	return var_02;
}

//Function Number: 33
vmx_get_roll(param_00)
{
	var_01 = level._audio.veh.instances[param_00.instance_name]["entity"];
	var_02 = var_01.angles[2];
	if(level._audio.veh.print_roll)
	{
		iprintln("roll: " + var_02);
	}

	return var_02;
}

//Function Number: 34
vmx_get_altitude(param_00)
{
	var_01 = level._audio.veh.instances[param_00.instance_name]["entity"];
	return 1;
}

//Function Number: 35
vmx_get_throttle(param_00)
{
	var_01 = level._audio.veh.instances[param_00.instance_name]["entity"];
	var_02 = 0;
	if(isdefined(level._audio.veh.instances[param_00.instance_name]["throttle"]))
	{
		var_03 = level._audio.veh.instances[param_00.instance_name]["speed"];
		var_02 = var_01 [[ var_03 ]]();
	}
	else if(isdefined(param_00.throttle_input) && param_00.throttle_input == "leftstick")
	{
		var_04 = level.player getnormalizedmovement();
		var_05 = var_04[0];
		var_02 = 0;
		if(var_05 >= 0)
		{
			var_02 = var_05;
		}
	}
	else if(isdefined(param_00.throttle_input) && param_00.throttle_input == "leftstick_abs")
	{
		var_04 = level.player getnormalizedmovement();
		var_05 = abs(var_04[0]);
		var_06 = abs(var_04[1]);
		var_02 = 2 * sqrt(var_05 * var_05 + var_06 * var_06);
		var_02 = clamp(var_02,0,1);
	}
	else if(isdefined(param_00.throttle_input) && param_00.throttle_input == "attack")
	{
		if(level.player attackbuttonpressed())
		{
			var_02 = 1;
		}
		else
		{
			var_02 = 0;
		}
	}
	else
	{
		var_02 = var_01 vehicle_getthrottle();
	}

	return var_02;
}

//Function Number: 36
vm_ground_vehicle_start(param_00,param_01,param_02,param_03,param_04,param_05)
{
	self endon("death");
	self.veh_aliases = spawnstruct();
	self.veh_aliases.move_lo_lp = param_00;
	self.veh_aliases.rolling_lp = param_01;
	self.veh_aliases.idle_lp = param_02;
	self.veh_aliases.engine_rev_lo_os = param_03;
	self.veh_aliases.breaks_os = param_04;
	thread vmx_monitor_explosion(param_05);
	thread vmx_ground_vehicle_monitor_death();
	thread vmx_cleanup_ents();
	vmx_vehicle_engine();
}

//Function Number: 37
vmx_vehicle_engine()
{
	self endon("death");
	self.do_rev = 1;
	self.ents_mixed_in = 0;
	self.has_idle_played = 0;
	self.has_move_played = 0;
	self.has_roll_played = 0;
	self.veh_mix_ents = spawnstruct();
	self.veh_mix_ents.idle_ent = spawn("script_origin",self.origin);
	self.veh_mix_ents.idle_ent linkto(self);
	self.veh_mix_ents.move_ent = spawn("script_origin",self.origin);
	self.veh_mix_ents.move_ent linkto(self);
	self.veh_mix_ents.roll_ent = spawn("script_origin",self.origin);
	self.veh_mix_ents.roll_ent linkto(self);
	self.veh_mix_ents.one_shot = spawn("script_origin",self.origin);
	self.veh_mix_ents.one_shot linkto(self);
	for(;;)
	{
		var_00 = self vehicle_getspeed();
		if(var_00 > 0.05)
		{
			self.do_rev = 1;
			vmx_ground_speed_watch(var_00);
		}

		wait(0.25);
	}
}

//Function Number: 38
vmx_ground_speed_watch(param_00)
{
	self endon("death");
	var_01 = 0.5;
	var_02 = 1.5;
	var_03 = 0;
	for(;;)
	{
		var_04 = param_00;
		wait(0.1);
		var_05 = 0.5 + self vehicle_getspeed();
		if(var_05 >= var_04)
		{
			if(isdefined(self.veh_aliases.idle_lp) && self.has_idle_played)
			{
				self.veh_mix_ents.idle_ent thread vmx_aud_ent_fade_out(0.5);
			}

			if(self.do_rev)
			{
				self.do_rev = 0;
				if(isdefined(self.veh_aliases.engine_rev_lo_os))
				{
					self.veh_mix_ents.one_shot playsound(self.veh_aliases.engine_rev_lo_os);
				}
			}
			else
			{
				if(isdefined(self.veh_aliases.rolling_lp) && !self.has_roll_played)
				{
					self.has_roll_played = 1;
					self.veh_mix_ents.roll_ent playloopsound(self.veh_aliases.rolling_lp);
				}

				if(isdefined(self.veh_aliases.move_lo_lp) && !self.has_move_played)
				{
					self.has_move_played = 1;
					self.veh_mix_ents.move_ent playloopsound(self.veh_aliases.move_lo_lp);
				}

				if(!var_03)
				{
					if(isdefined(self.veh_aliases.move_lo_lp))
					{
						self.veh_mix_ents.move_ent thread vmx_aud_ent_fade_in(var_01);
					}

					if(isdefined(self.veh_aliases.rolling_lp))
					{
						self.veh_mix_ents.roll_ent thread vmx_aud_ent_fade_in(var_01);
					}

					var_03 = 1;
				}
			}
		}
		else if(var_05 < var_04)
		{
			if(isdefined(self.veh_aliases.idle_lp))
			{
				if(!self.has_idle_played)
				{
					self.has_idle_played = 1;
					self.veh_mix_ents.idle_ent playloopsound(self.veh_aliases.idle_lp);
				}

				self.veh_mix_ents.idle_ent thread vmx_aud_ent_fade_in(0.5);
			}

			if(isdefined(self.veh_aliases.breaks_os))
			{
				self.veh_mix_ents.one_shot playsound(self.veh_aliases.breaks_os);
			}

			if(isdefined(self.veh_aliases.move_lo_lp))
			{
				self.veh_mix_ents.move_ent thread vmx_aud_ent_fade_out(0.5);
			}

			if(isdefined(self.veh_aliases.move_lo_lp))
			{
				self.veh_mix_ents.roll_ent thread vmx_aud_ent_fade_out(0.1);
			}

			return;
		}

		wait(0.2);
	}
}

//Function Number: 39
vmx_aud_ent_fade_out(param_00)
{
	self scalevolume(0,param_00);
}

//Function Number: 40
vmx_aud_ent_fade_in(param_00,param_01)
{
	var_02 = 1;
	if(isdefined(param_01))
	{
		var_02 = param_01;
	}

	self scalevolume(0);
	wait(0.05);
	self scalevolume(var_02,param_00);
}

//Function Number: 41
vmx_cleanup_ents()
{
	self waittill("cleanup_sound_ents");
	self.veh_mix_ents.idle_ent stoploopsound();
	self.veh_mix_ents.move_ent stoploopsound();
	self.veh_mix_ents.roll_ent stoploopsound();
	self.veh_mix_ents.one_shot stopsounds();
	wait(0.05);
	self.veh_mix_ents.idle_ent delete();
	self.veh_mix_ents.move_ent delete();
	self.veh_mix_ents.roll_ent delete();
	self.veh_mix_ents.one_shot delete();
}

//Function Number: 42
vmx_ground_vehicle_monitor_death()
{
	self endon("cleanup_sound_ents");
	self waittill("death");
	self notify("cleanup_sound_ents");
}

//Function Number: 43
vmx_monitor_explosion(param_00)
{
	self endon("cleanup_sound_ents");
	for(;;)
	{
		if(!isdefined(self))
		{
			break;
		}

		if(self.health < self.healthbuffer)
		{
			break;
		}

		wait(0.05);
	}

	self notify("died");
	if(isdefined(param_00))
	{
		common_scripts\utility::play_sound_in_space(param_00,self.origin);
	}

	self notify("ceanup_sound_ents");
}

//Function Number: 44
vm_aud_air_vehicle_flyby(param_00,param_01,param_02,param_03,param_04,param_05)
{
	var_06 = 0;
	if(isdefined(param_03))
	{
		var_06 = param_03;
	}

	var_07 = 0;
	if(isdefined(param_04))
	{
		var_07 = param_04;
	}

	while(isdefined(param_00))
	{
		if(var_07)
		{
			var_08 = distance(param_00.origin,level.player.origin);
		}
		else
		{
			var_08 = distance2d(param_00.origin,level.player.origin);
		}

		if(var_06)
		{
			iprintln("Distance: " + var_08);
		}

		if(var_08 < param_02)
		{
			var_09 = spawn("script_origin",param_00.origin);
			var_09 linkto(param_00);
			var_09 playsound(param_01,"sounddone");
			param_00 notify("flyby_sound_played");
			var_09 thread vmx_waittill_deathspin(param_00);
			var_09 thread vmx_waittill_sounddone();
			var_09 waittill("flyby_ent",var_0A);
			if(var_0A == "deathspin")
			{
				if(isdefined(param_05))
				{
					thread common_scripts\utility::play_sound_in_space(param_05,var_09.origin);
				}

				var_09 scalevolume(0,0.3);
				wait(0.4);
				var_09 stopsounds();
				wait(0.05);
				var_09 delete();
				return;
			}
			else if(var_0A == "sounddone")
			{
				wait(0.1);
				var_09 delete();
				return;
			}

			continue;
		}

		wait(0.05);
	}
}

//Function Number: 45
vmx_waittill_deathspin(param_00)
{
	self endon("flyby_ent");
	param_00 waittill("deathspin");
	self notify("flyby_ent","deathspin");
}

//Function Number: 46
vmx_waittill_sounddone()
{
	self endon("flyby_ent");
	self waittill("sounddone");
	self notify("flyby_ent","sounddone");
}