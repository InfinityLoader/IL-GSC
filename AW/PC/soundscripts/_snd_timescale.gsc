/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: _snd_timescale.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 11
 * Decompile Time: 167 ms
 * Timestamp: 4/22/2024 2:04:07 AM
*******************************************************************/

//Function Number: 1
snd_timescale_init()
{
	snd_load_timescale_presets();
	snd_set_current_timescale_preset_name("");
}

//Function Number: 2
snd_set_current_timescale_preset_name(param_00)
{
	level._snd.timescale.current_preset_name = param_00;
}

//Function Number: 3
snd_get_current_timescale_preset_name()
{
	return level._snd.timescale.current_preset_name;
}

//Function Number: 4
snd_load_timescale_presets()
{
	level._snd.timescale = spawnstruct();
	var_00 = [];
	var_00[var_00.size] = "soundtables/sp_defaults.csv";
	var_00[var_00.size] = "soundtables/" + level.script + ".csv";
	level._snd.timescale.presets = soundscripts\_snd::snd_parse_soundtables("Timescale",var_00,3,"timescale_names","zone_names;reverb_names;filter_names;occlusion_names;timescale_names;dynamic_ambience_names;components;loop_defs;whizby_preset_names;mix_names;healthfx_params");
}

//Function Number: 5
snd_set_timescale(param_00)
{
	var_01 = snd_get_timescale_preset(param_00);
	if(!isdefined(var_01))
	{
		return;
	}

	if(snd_get_current_timescale_preset_name() != param_00)
	{
		thread snd_set_timescale_threaded(var_01);
	}
}

//Function Number: 6
snd_get_timescale_preset(param_00)
{
	if(isdefined(level._snd.timescale.presets) && isdefined(level._snd.timescale.presets[param_00]))
	{
		return level._snd.timescale.presets[param_00];
	}

	return undefined;
}

//Function Number: 7
snd_set_timescale_threaded(param_00)
{
	var_01 = soundscripts\_snd::snd_get_throttler();
	foreach(var_03 in param_00.settings)
	{
		var_04 = var_03["dsp_bus_name"];
		if(var_04 == "all")
		{
			var_05 = soundscripts\_snd_filters::snd_get_dsp_buses();
			foreach(var_07 in var_05)
			{
				soundsettimescalefactor(var_07,var_03["scalefactor"]);
				var_01 soundscripts\_snd::snd_throttle_wait();
			}

			continue;
		}

		soundsettimescalefactor(var_04,var_03["scalefactor"]);
	}
}

//Function Number: 8
snd_set_timescale_all(param_00)
{
	thread snd_set_timescale_all_threaded(param_00);
}

//Function Number: 9
snd_set_timescale_all_threaded(param_00)
{
	var_01 = soundscripts\_snd::snd_get_throttler();
	var_02 = soundscripts\_snd_filters::snd_get_dsp_buses();
	foreach(var_04 in var_02)
	{
		soundsettimescalefactor(var_04,param_00);
		var_01 soundscripts\_snd::snd_throttle_wait();
	}
}

//Function Number: 10
snd_set_timescale_array_to_value(param_00,param_01)
{
	thread snd_set_timescale_array_to_value_threaded(param_00,param_01);
}

//Function Number: 11
snd_set_timescale_array_to_value_threaded(param_00,param_01)
{
	var_02 = soundscripts\_snd::snd_get_throttler();
	foreach(var_04 in param_00)
	{
		soundsettimescalefactor(var_04,param_01);
		var_02 soundscripts\_snd::snd_throttle_wait();
	}
}