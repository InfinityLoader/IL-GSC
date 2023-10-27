/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: soundscripts/_snd_filters.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 35
 * Decompile Time: 408 ms
 * Timestamp: 10/27/2023 2:06:00 AM
*******************************************************************/

//Function Number: 1
snd_filters_init()
{
	snd_init_current_filters();
	snd_init_current_occlusion();
	snd_load_filter_presets();
	snd_load_occlusion_presets();
}

//Function Number: 2
snd_set_filter_lerp(param_00)
{
	level._snd.current_filters.lerp = param_00;
	level.player seteqlerp(param_00,0);
}

//Function Number: 3
snd_get_current_filter_lerp()
{
	return level._snd.current_filters.lerp;
}

//Function Number: 4
snd_init_current_filters()
{
	var_00 = spawnstruct();
	var_00.names = [];
	var_00.names[0] = "";
	var_00.names[1] = "";
	var_00.lerp = 0;
	level._snd.current_filters = var_00;
}

//Function Number: 5
snd_get_current_filter_name(param_00)
{
	return level._snd.current_filters.names[param_00];
}

//Function Number: 6
snd_set_current_filter_name(param_00,param_01)
{
	level._snd.current_filters.names[param_00] = param_01;
}

//Function Number: 7
snd_init_current_occlusion()
{
	var_00 = spawnstruct();
	var_00.name = "";
	level._snd.current_occlusion = var_00;
	snd_set_current_occlusion_name("");
}

//Function Number: 8
snd_get_current_occlusion_name()
{
	return level._snd.current_occlusion.name;
}

//Function Number: 9
snd_set_current_occlusion_name(param_00)
{
	level._snd.current_occlusion.name = param_00;
}

//Function Number: 10
snd_load_dsp_buses()
{
	var_00 = soundscripts\_snd::snd_parse_soundtables("DSP bus",["sounddata/dspbuses.csv"],2,"name","name");
	if(isdefined(var_00))
	{
		level._snd.dsp_buses = var_00;
		return;
	}

	level._snd.dsp_buses = [];
}

//Function Number: 11
snd_get_dsp_buses()
{
	var_00 = [];
	foreach(var_02 in level._snd.dsp_buses)
	{
		var_00[var_00.size] = var_02.name;
	}

	return var_00;
}

//Function Number: 12
snd_is_dsp_bus(param_00)
{
	return isdefined(level._snd.dsp_buses[param_00]);
}

//Function Number: 13
snd_get_dsp_filename()
{
	return "sounddata/dspbuses.csv";
}

//Function Number: 14
snd_load_filter_presets()
{
	level._snd.filters = spawnstruct();
	var_00 = [];
	var_00[var_00.size] = "soundtables/sp_defaults.csv";
	var_00[var_00.size] = "soundtables/" + level.script + ".csv";
	level._snd.filters.presets = soundscripts\_snd::snd_parse_soundtables("Filter",var_00,6,"filter_names","zone_names;reverb_names;filter_names;occlusion_names;timescale_names;dynamic_ambience_names;components;loop_defs;whizby_preset_names;mix_names;healthfx_params");
}

//Function Number: 15
snd_set_filter(param_00,param_01,param_02)
{
	if(isdefined(level.player.ent_flag) && isdefined(level.player.ent_flag["player_has_red_flashing_overlay"]) && level.player maps\_utility::ent_flag("player_has_red_flashing_overlay"))
	{
		return;
	}

	var_03 = 0;
	if(isdefined(param_01))
	{
		var_03 = param_01;
	}

	if(!isdefined(param_00) || isdefined(param_00) && param_00 == "" || param_00 == "none")
	{
		snd_set_current_filter_name(var_03,"");
		level.player deactivateeq(var_03);
		return;
	}

	var_04 = snd_get_filter_preset(param_00);
	if(!isdefined(var_04))
	{
		return;
	}

	if(snd_get_current_filter_name(var_03) != param_00)
	{
		snd_set_current_filter_name(var_03,param_00);
		thread snd_set_filter_threaded(var_03,var_04);
	}
}

//Function Number: 16
sndx_fade_in_filter_lerp(param_00)
{
	self endon("fade_begin");
	var_01 = 0;
	var_02 = 0.05 / param_00;
	while(var_01 < 1)
	{
		snd_set_filter_lerp(var_01);
		var_01 = var_01 + var_02;
		wait(0.05);
	}

	snd_set_filter_lerp(1);
}

//Function Number: 17
snd_fade_in_filter(param_00,param_01)
{
	self notify("fade_begin");
	snd_set_filter_lerp(0);
	snd_clear_filter(0);
	snd_clear_filter(1);
	snd_set_filter(param_00);
	thread sndx_fade_in_filter_lerp(param_01);
}

//Function Number: 18
sndx_fade_out_filter_lerp(param_00)
{
	self endon("fade_begin");
	var_01 = snd_get_current_filter_lerp();
	var_02 = var_01 * 0.05 / param_00;
	while(var_01 > 0)
	{
		snd_set_filter_lerp(var_01);
		var_01 = var_01 - var_02;
		wait(0.05);
	}

	snd_set_filter_lerp(0);
}

//Function Number: 19
snd_fade_out_filter(param_00)
{
	self notify("fade_begin");
	thread sndx_fade_out_filter_lerp(param_00);
}

//Function Number: 20
snd_get_filter_preset(param_00)
{
	if(isdefined(level._snd.filters.presets[param_00]))
	{
		return level._snd.filters.presets[param_00];
	}

	return undefined;
}

//Function Number: 21
sndx_get_dsp_filter_setting(param_00,param_01,param_02)
{
	var_03 = spawnstruct();
	var_03.dsp_bus = param_01;
	var_03.index = param_00;
	var_03.type = param_02["type"];
	var_03.gain = param_02["gain"];
	var_03.freq = param_02["freq"];
	var_03.q = param_02["q"];
	return var_03;
}

//Function Number: 22
snd_set_filter_threaded(param_00,param_01)
{
	var_02 = soundscripts\_snd::snd_get_throttler();
	var_03 = [];
	foreach(var_05 in param_01.settings)
	{
		var_06 = var_05["dsp_bus_name"];
		if(var_06 == "all" || var_06 == "set_all")
		{
			var_07 = snd_get_dsp_buses();
			foreach(var_09 in var_07)
			{
				var_03[var_09] = sndx_get_dsp_filter_setting(param_00,var_09,var_05);
			}

			continue;
		}

		if(snd_is_dsp_bus(var_06))
		{
			var_03[var_06] = sndx_get_dsp_filter_setting(param_00,var_06,var_05);
			continue;
		}
	}

	foreach(var_0D in var_03)
	{
		level.player seteq(var_0D.dsp_bus,var_0D.index,var_0D.type,var_0D.gain,var_0D.freq,var_0D.q);
		var_02 soundscripts\_snd::snd_throttle_wait();
	}
}

//Function Number: 23
snd_clear_filter(param_00)
{
	var_01 = 0;
	if(isdefined(param_00))
	{
		var_01 = param_00;
	}

	snd_set_filter(undefined,var_01);
}

//Function Number: 24
snd_load_occlusion_presets()
{
	level._snd.occlusion = spawnstruct();
	var_00 = [];
	var_00[var_00.size] = "soundtables/sp_defaults.csv";
	var_00[var_00.size] = "soundtables/" + level.script + ".csv";
	level._snd.occlusion.presets = soundscripts\_snd::snd_parse_soundtables("Filter",var_00,6,"occlusion_names","zone_names;reverb_names;filter_names;occlusion_names;timescale_names;dynamic_ambience_names;components;loop_defs;whizby_preset_names;mix_names;healthfx_params");
}

//Function Number: 25
snd_set_occlusion(param_00)
{
	if(isdefined(level.player.ent_flag) && isdefined(level.player.ent_flag["player_has_red_flashing_overlay"]) && level.player maps\_utility::ent_flag("player_has_red_flashing_overlay"))
	{
		return;
	}

	if(!isdefined(param_00))
	{
		snd_set_current_occlusion_name("");
		thread snd_disable_occlusion_threaded();
		return;
	}

	var_01 = snd_get_occlusion_preset(param_00);
	if(!isdefined(var_01))
	{
		return;
	}

	if(snd_get_current_occlusion_name() != param_00)
	{
		snd_set_current_occlusion_name(param_00);
		thread snd_set_occlusion_threaded(var_01.settings);
	}
}

//Function Number: 26
snd_get_occlusion_preset(param_00)
{
	if(isdefined(level._snd.occlusion.presets[param_00]))
	{
		return level._snd.occlusion.presets[param_00];
	}

	return undefined;
}

//Function Number: 27
snd_set_occlusion_threaded(param_00)
{
	var_01 = soundscripts\_snd::snd_get_throttler();
	foreach(var_03 in param_00)
	{
		var_04 = var_03["dsp_bus_name"];
		if(var_04 == "all")
		{
			var_05 = snd_get_dsp_buses();
			foreach(var_07 in var_05)
			{
				level.player setocclusion(var_07,var_03["freq"],var_03["type"],var_03["gain"],var_03["q"]);
				var_01 soundscripts\_snd::snd_throttle_wait();
			}

			break;
		}
		else
		{
			if(snd_is_dsp_bus(var_04))
			{
				level.player setocclusion(var_04,var_03["freq"],var_03["type"],var_03["gain"],var_03["q"]);
			}
			else
			{
			}

			var_01 soundscripts\_snd::snd_throttle_wait();
		}
	}
}

//Function Number: 28
snd_enable_occlusion()
{
	level._snd.occlusion.is_enabled = 1;
}

//Function Number: 29
snd_disable_occlusion_threaded()
{
	var_00 = soundscripts\_snd::snd_get_throttler();
	var_01 = snd_get_dsp_buses();
	foreach(var_03 in var_01)
	{
		level.player deactivateocclusion(var_03);
		var_00 soundscripts\_snd::snd_throttle_wait();
	}
}

//Function Number: 30
snd_disable_occlusion()
{
	level._snd.occlusion.is_enabled = 0;
	thread snd_disable_occlusion_threaded();
}

//Function Number: 31
snd_disable_zone_filters()
{
	level._snd.zone_filters_enabled = undefined;
}

//Function Number: 32
snd_enable_zone_filters()
{
	level._snd.zone_filters_enabled = 1;
}

//Function Number: 33
snd_get_zone_filters_enabled()
{
	return isdefined(level._snd.zone_filters_enabled);
}

//Function Number: 34
snd_disable_zone_occlusion_and_filtering()
{
	snd_set_filter(undefined,0);
	snd_set_filter(undefined,1);
	snd_disable_occlusion();
	snd_disable_zone_filters();
}

//Function Number: 35
snd_enable_zone_occlusion_and_filtering()
{
	var_00 = undefined;
	var_01 = "default";
	if(isdefined(level._audio.zone_mgr.current_zone) && isdefined(level._audio.zone_mgr.zones[level._audio.zone_mgr.current_zone]))
	{
		var_02 = soundscripts\_audio_zone_manager::azm_get_current_zone();
		var_03 = level._audio.zone_mgr.zones[var_02];
		if(isdefined(var_03["occlusion"]) && var_03["occlusion"] != "none")
		{
			var_01 = var_03["occlusion"];
		}

		if(isdefined(var_03["filter"]) && var_03["filter"] != "none")
		{
			var_00 = var_03["filter"];
		}
	}

	if(snd_get_current_occlusion_name() != var_01)
	{
		var_01 = snd_get_current_occlusion_name();
	}

	snd_enable_zone_filters();
	snd_set_filter(var_00,0);
	snd_set_filter(undefined,1);
	snd_set_occlusion(var_01);
}