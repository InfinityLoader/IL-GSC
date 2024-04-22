/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: _audio_zone_manager.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 50
 * Decompile Time: 578 ms
 * Timestamp: 4/22/2024 2:03:55 AM
*******************************************************************/

//Function Number: 1
azm_init()
{
	if(!isdefined(level._audio.zone_mgr))
	{
		level._audio.zone_mgr = spawnstruct();
		level._audio.zone_mgr.current_zone = "";
		level._audio.zone_mgr.zones = [];
		level._audio.zone_mgr.overrides = spawnstruct();
		level._audio.zone_mgr.overrides.samb = [];
		level._audio.zone_mgr.overrides.damb = [];
		level._audio.zone_mgr.overrides.mix = [];
		level._audio.zone_mgr.overrides.rev = [];
		level._audio.zone_mgr.overrides.occ = [];
		azm_set_quad_enable(1);
		azm_set_damb_enable(1);
		azm_set_mix_enable(1);
		azm_set_reverb_enable(1);
		azm_set_filter_enable(1);
		azm_set_occlusion_enable(1);
		azm_set_mix_bypass(0);
		azm_set_reverb_bypass(0);
		azm_set_filter_bypass(0);
		azm_set_occlusion_bypass(0);
		level._audio.zone_mgr.use_string_table_presets = 0;
	}

	if(!isdefined(level._audio.use_level_audio_zones))
	{
		level._audio.level_audio_zones_function = undefined;
	}
}

//Function Number: 2
azm_use_string_table()
{
	level._audio.zone_mgr.use_string_table_presets = 1;
}

//Function Number: 3
azm_start_zone(param_00,param_01,param_02)
{
	if(level._audio.zone_mgr.current_zone == param_00)
	{
		return;
	}
	else if(level._audio.zone_mgr.current_zone != "")
	{
		azm_stop_zone(level._audio.zone_mgr.current_zone,param_01);
	}

	level._audio.zone_mgr.current_zone = param_00;
	if(isdefined(level._audio.zone_mgr.zones[param_00]) && isdefined(level._audio.zone_mgr.zones[param_00]["state"]) && level._audio.zone_mgr.zones[param_00]["state"] != "stopping")
	{
		soundscripts\_audio::aud_print_warning("ZONEM_start_zone(\" + param_00 + "\") being called even though audio zone, \" + param_00 + "\", is already started.");
		return;
	}

	var_03 = 2;
	if(isdefined(param_01))
	{
		var_03 = param_01;
	}

	if(!isdefined(level._audio.zone_mgr.zones[param_00]))
	{
		var_04 = azmx_load_zone(param_00);
		if(!isdefined(var_04))
		{
			return;
		}

		level._audio.zone_mgr.zones[param_00] = var_04;
	}

	var_04 = level._audio.zone_mgr.zones[param_00];
	soundscripts\_audio::aud_print_zone("ZONE START: " + param_00);
	level._audio.zone_mgr.zones[param_00]["state"] = "playing";
	var_05 = var_04["priority"];
	var_06 = var_04["interrupt_fade"];
	if(isdefined(var_04["streamed_ambience"]))
	{
		if(var_04["streamed_ambience"] != "none")
		{
			soundscripts\_audio_stream_manager::sm_start_preset(var_04["streamed_ambience"],var_03,var_05,var_06);
		}
		else
		{
			soundscripts\_audio_stream_manager::sm_stop_ambience(var_03);
		}
	}

	if(isdefined(var_04["dynamic_ambience"]))
	{
		if(var_04["dynamic_ambience"] != "none")
		{
			soundscripts\_audio_dynamic_ambi::damb_zone_start_preset(var_04["dynamic_ambience"],1);
		}
		else
		{
			soundscripts\_audio_dynamic_ambi::damb_stop_zone(1);
		}
	}

	if(isdefined(var_04["occlusion"]) && !azm_get_occlusion_bypass())
	{
		if(var_04["occlusion"] != "none")
		{
			soundscripts\_snd_filters::snd_set_occlusion(var_04["occlusion"]);
		}
		else
		{
			soundscripts\_snd_filters::snd_set_occlusion(undefined);
		}
	}

	if(isdefined(var_04["filter"]) && !azm_get_filter_bypass())
	{
		if(var_04["filter"] != "none")
		{
			soundscripts\_snd_filters::snd_set_filter(var_04["filter"],0);
			soundscripts\_snd_filters::snd_set_filter_lerp(1);
		}
	}

	if(isdefined(var_04["reverb"]) && !azm_get_reverb_bypass())
	{
		if(var_04["reverb"] != "none")
		{
			soundscripts\_audio_reverb::rvb_start_preset(var_04["reverb"]);
		}
		else
		{
			soundscripts\_audio_reverb::rvb_deactive_reverb();
		}
	}

	if(isdefined(var_04["mix"]) && !azm_get_mix_bypass())
	{
		if(var_04["mix"] != "none")
		{
			soundscripts\_audio_mix_manager::mm_start_zone_preset(var_04["mix"]);
			return;
		}

		soundscripts\_audio_mix_manager::mm_clear_zone_mix(undefined,1);
	}
}

//Function Number: 4
azm_set_zone_streamed_ambience(param_00,param_01,param_02)
{
	var_03 = azmx_set_param_internal(param_00,"streamed_ambience",param_01,::azmx_restart_stream,param_02);
	if(!var_03)
	{
		if(!isdefined(param_01))
		{
			param_01 = "none";
		}

		level._audio.zone_mgr.overrides.samb[param_00] = param_01;
	}
}

//Function Number: 5
azm_set_zone_dynamic_ambience(param_00,param_01,param_02)
{
	if(!isdefined(param_01))
	{
		param_01 = "none";
	}

	azmx_set_param_internal(param_00,"dynamic_ambience",param_01,::azmx_restart_damb,param_02);
	level._audio.zone_mgr.overrides.damb[param_00] = param_01;
}

//Function Number: 6
azm_set_zone_reverb(param_00,param_01,param_02)
{
	if(!isdefined(param_01))
	{
		param_01 = "none";
	}

	azmx_set_param_internal(param_00,"reverb",param_01,::azmx_restart_reverb,param_02);
	level._audio.zone_mgr.overrides.rev[param_00] = param_01;
}

//Function Number: 7
azm_set_zone_occlusion(param_00,param_01,param_02)
{
	if(!isdefined(param_01))
	{
		param_01 = "none";
	}

	azmx_set_param_internal(param_00,"occlusion",param_01,::azmx_restart_occlusion,param_02);
	level._audio.zone_mgr.overrides.mix[param_01] = param_01;
}

//Function Number: 8
azm_set_zone_mix(param_00,param_01,param_02)
{
	if(!isdefined(param_01))
	{
		param_01 = "none";
	}

	azmx_set_param_internal(param_00,"mix",param_01,::azmx_restart_mix,param_02);
	level._audio.zone_mgr.overrides.mix[param_01] = param_01;
}

//Function Number: 9
azm_stop_zones(param_00)
{
	var_01 = 1;
	if(isdefined(param_00))
	{
		var_01 = param_00;
	}

	soundscripts\_audio::aud_print_zone("ZONE STOP ALL");
	foreach(var_03 in level._audio.zone_mgr.zones)
	{
		azm_stop_zone(var_03["name"],var_01,0);
	}
}

//Function Number: 10
azm_stop_zone(param_00,param_01,param_02)
{
	if(isdefined(level._audio.zone_mgr.zones[param_00]) && isdefined(level._audio.zone_mgr.zones[param_00]["state"]) && level._audio.zone_mgr.zones[param_00]["state"] != "stopping")
	{
		var_03 = 1;
		if(isdefined(param_01))
		{
			var_03 = param_01;
		}

		var_04 = level._audio.zone_mgr.zones[param_00];
		var_05 = 0;
		if(isdefined(param_02))
		{
			var_05 = param_02;
		}

		if(var_05)
		{
			soundscripts\_audio::aud_print_zone("ZONE STOP ZONE: " + param_00);
		}

		if(isdefined(var_04["streamed_ambience"]))
		{
			soundscripts\_audio_stream_manager::sm_stop_ambient_alias(var_04["streamed_ambience"],var_03);
		}

		if(isdefined(var_04["dynamic_ambience"]))
		{
			soundscripts\_audio_dynamic_ambi::damb_zone_stop_preset(var_04["dynamic_ambience"],var_03);
		}

		if(isdefined(var_04["mix"]) && !azm_get_mix_bypass())
		{
			soundscripts\_audio_mix_manager::mm_clear_zone_mix(var_04["mix"],var_03);
		}

		level._audio.zone_mgr.zones[param_00]["state"] = "stopping";
		thread azmx_wait_till_fade_done_and_remove_zone(param_00,var_03);
	}
}

//Function Number: 11
azm_get_current_zone()
{
	return level._audio.zone_mgr.current_zone;
}

//Function Number: 12
azm_set_current_zone(param_00)
{
	level._audio.zone_mgr.current_zone = param_00;
}

//Function Number: 13
azm_print_enter_blend(param_00,param_01,param_02)
{
}

//Function Number: 14
azm_print_exit_blend(param_00)
{
}

//Function Number: 15
azm_print_progress(param_00)
{
}

//Function Number: 16
azm_set_quad_enable(param_00)
{
	level._audio.zone_mgr.overrides.quad_enable = param_00;
}

//Function Number: 17
azm_get_quad_enable()
{
	return level._audio.zone_mgr.overrides.quad_enable;
}

//Function Number: 18
azm_set_damb_enable(param_00)
{
	level._audio.zone_mgr.overrides.damb_enable = param_00;
}

//Function Number: 19
azm_get_damb_enable()
{
	return level._audio.zone_mgr.overrides.damb_enable;
}

//Function Number: 20
azm_set_mix_enable(param_00)
{
	level._audio.zone_mgr.overrides.mix_enable = param_00;
}

//Function Number: 21
azm_get_mix_enable()
{
	return level._audio.zone_mgr.overrides.mix_enable;
}

//Function Number: 22
azm_set_reverb_enable(param_00)
{
	level._audio.zone_mgr.overrides.reverb_enable = param_00;
}

//Function Number: 23
azm_get_reverb_enable()
{
	return level._audio.zone_mgr.overrides.reverb_enable;
}

//Function Number: 24
azm_set_filter_enable(param_00)
{
	level._audio.zone_mgr.overrides.filter_enable = param_00;
}

//Function Number: 25
azm_get_filter_enable()
{
	return level._audio.zone_mgr.overrides.filter_enable;
}

//Function Number: 26
azm_set_occlusion_enable(param_00)
{
	level._audio.zone_mgr.overrides.occlusion_enable = param_00;
}

//Function Number: 27
azm_get_occlusion_enable()
{
	return level._audio.zone_mgr.overrides.occlusion_enable;
}

//Function Number: 28
azm_set_mix_bypass(param_00)
{
	level._audio.zone_mgr.overrides.mix_bypass = param_00;
}

//Function Number: 29
azm_get_mix_bypass()
{
	return level._audio.zone_mgr.overrides.mix_bypass;
}

//Function Number: 30
azm_set_reverb_bypass(param_00)
{
	level._audio.zone_mgr.overrides.reverb_bypass = param_00;
}

//Function Number: 31
azm_get_reverb_bypass()
{
	return level._audio.zone_mgr.overrides.reverb_bypass;
}

//Function Number: 32
azm_set_filter_bypass(param_00)
{
	level._audio.zone_mgr.overrides.filter_bypass = param_00;
}

//Function Number: 33
azm_get_filter_bypass()
{
	return (isdefined(level.mute_device_active) && level.mute_device_active) || level._audio.zone_mgr.overrides.filter_bypass;
}

//Function Number: 34
azm_set_occlusion_bypass(param_00)
{
	level._audio.zone_mgr.overrides.occlusion_bypass = param_00;
}

//Function Number: 35
azm_get_occlusion_bypass()
{
	return level._audio.zone_mgr.overrides.occlusion_bypass;
}

//Function Number: 36
azmx_load_zone(param_00)
{
	if(isdefined(level._audio.zone_mgr.zones[param_00]))
	{
		return;
	}

	if(!isdefined(level._audio.zone_mgr.preset_cache))
	{
		level._audio.zone_mgr.preset_cache = [];
	}

	var_01 = [];
	if(isdefined(level._audio.zone_mgr.preset_cache[param_00]))
	{
		var_01 = level._audio.zone_mgr.preset_cache[param_00];
	}
	else
	{
		var_01 = azmx_get_preset_from_string_table(param_00,1);
	}

	if(!isdefined(var_01) || var_01.size == 0)
	{
		return;
	}

	level._audio.zone_mgr.preset_cache[param_00] = var_01;
	var_02 = 0;
	if(azm_get_quad_enable() && isdefined(level._audio.zone_mgr.overrides.samb[param_00]))
	{
		if(level._audio.zone_mgr.overrides.samb[param_00] == "none")
		{
			var_01["streamed_ambience"] = undefined;
		}
		else
		{
			var_01["streamed_ambience"] = level._audio.zone_mgr.overrides.samb[param_00];
		}

		var_02 = 1;
		level._audio.zone_mgr.overrides.samb[param_00] = undefined;
	}

	if(azm_get_damb_enable() && isdefined(level._audio.zone_mgr.overrides.damb[param_00]))
	{
		if(level._audio.zone_mgr.overrides.damb[param_00] == "none")
		{
			var_01["dynamic_ambience"] = undefined;
		}
		else
		{
			var_01["dynamic_ambience"] = level._audio.zone_mgr.overrides.damb[param_00];
		}

		var_02 = 1;
		level._audio.zone_mgr.overrides.damb[param_00] = undefined;
	}

	if(azm_get_reverb_enable() && isdefined(level._audio.zone_mgr.overrides.rev[param_00]))
	{
		if(level._audio.zone_mgr.overrides.rev[param_00] == "none")
		{
			var_01["reverb"] = undefined;
		}
		else
		{
			var_01["reverb"] = level._audio.zone_mgr.overrides.rev[param_00];
		}

		var_02 = 1;
		level._audio.zone_mgr.overrides.rev[param_00] = undefined;
	}

	if(azm_get_occlusion_enable() && isdefined(level._audio.zone_mgr.overrides.occ[param_00]))
	{
		if(level._audio.zone_mgr.overrides.occ[param_00] == "none")
		{
			var_01["occlusion"] = undefined;
		}
		else
		{
			var_01["occlusion"] = level._audio.zone_mgr.overrides.occ[param_00];
		}

		var_02 = 1;
		level._audio.zone_mgr.overrides.occ[param_00] = undefined;
	}

	if(azm_get_filter_enable() && isdefined(level._audio.zone_mgr.overrides.mix[param_00]))
	{
		if(level._audio.zone_mgr.overrides.mix[param_00] == "none")
		{
			var_01["mix"] = undefined;
		}
		else
		{
			var_01["mix"] = level._audio.zone_mgr.overrides.mix[param_00];
		}

		var_02 = 1;
		level._audio.zone_mgr.overrides.mix[param_00] = undefined;
	}

	if(var_02)
	{
		level._audio.zone_mgr.preset_cache[param_00] = var_01;
	}

	var_01["name"] = param_00;
	if(!isdefined(var_01["priority"]))
	{
		var_01["priority"] = 1;
	}

	if(!isdefined(var_01["interrupt_fade"]))
	{
		var_01["interrupt_fade"] = 0.1;
	}

	return var_01;
}

//Function Number: 37
azmx_get_preset_from_string_table(param_00,param_01)
{
	var_02 = "soundtables/sp_defaults.csv";
	var_03 = soundscripts\_audio::get_zone_stringtable();
	var_04 = [];
	if(param_01)
	{
		var_04 = azmx_get_zone_preset_from_stringtable_internal(var_03,param_00);
	}

	if(!isdefined(var_04) || var_04.size == 0)
	{
		var_04 = azmx_get_zone_preset_from_stringtable_internal(var_02,param_00);
	}

	if(!isdefined(var_04) || var_04.size == 0)
	{
		return;
	}

	return var_04;
}

//Function Number: 38
azmx_get_zone_preset_from_stringtable_internal(param_00,param_01)
{
	var_02 = [];
	var_03 = "";
	var_04 = "";
	var_05 = packedtablesectionlookup(param_00,"zone_names","zone_names;reverb_names;filter_names;occlusion_names;timescale_names;dynamic_ambience_names;components;loop_defs;whizby_preset_names;mix_names;healthfx_params");
	if(isdefined(var_05))
	{
		var_06 = 8;
		for(var_07 = 1;var_07 < var_06;var_07++)
		{
			if(var_03 != "comments" && var_04 != "")
			{
				var_02[var_03] = var_04;
			}

			var_03 = packedtablelookupwithrange(param_00,0,"zone_names",var_07,var_05[0],var_05[1]);
			var_04 = packedtablelookupwithrange(param_00,0,param_01,var_07,var_05[0],var_05[1]);
			if(var_03 != "comment" && var_03 != "comments" && var_04 != "")
			{
				switch(var_03)
				{
					case "streamed_ambience":
						var_02["streamed_ambience"] = var_04;
						break;

					case "dynamic_ambience":
						var_02["dynamic_ambience"] = var_04;
						break;

					case "mix":
						var_02["mix"] = var_04;
						break;

					case "reverb":
						var_02["reverb"] = var_04;
						break;

					case "filter":
						var_02["filter"] = var_04;
						break;

					case "occlusion":
						var_02["occlusion"] = var_04;
						break;

					default:
						break;
				}
			}
		}

		return var_02;
	}
}

//Function Number: 39
azmx_restart_stream(param_00,param_01)
{
	var_02 = level._audio.zone_mgr.zones[param_00]["streamed_ambience"];
	if(isdefined(var_02))
	{
		soundscripts\_audio_stream_manager::sm_start_preset(var_02,param_01);
		return;
	}

	soundscripts\_audio_stream_manager::sm_stop_ambience(param_01);
}

//Function Number: 40
azmx_restart_damb(param_00,param_01)
{
	var_02 = 1;
	if(isdefined(param_01))
	{
		var_02 = param_01;
	}

	var_03 = level._audio.zone_mgr.zones[param_00]["dynamic_ambience"];
	if(isdefined(var_03))
	{
		soundscripts\_audio_dynamic_ambi::damb_zone_start_preset(var_03,var_02);
		return;
	}

	soundscripts\_audio_dynamic_ambi::damb_zone_stop_preset(undefined,var_02);
}

//Function Number: 41
azmx_restart_reverb(param_00,param_01)
{
	var_02 = level._audio.zone_mgr.zones[param_00]["reverb"];
	if(isdefined(var_02) && !azm_get_reverb_bypass())
	{
		soundscripts\_audio_reverb::rvb_start_preset(var_02);
	}
}

//Function Number: 42
azmx_restart_occlusion(param_00,param_01)
{
	var_02 = level._audio.zone_mgr.zones[param_00]["occlusion"];
	if(isdefined(var_02) && !azm_get_occlusion_bypass())
	{
		soundscripts\_snd_filters::snd_set_occlusion(var_02);
	}
}

//Function Number: 43
azmx_restart_mix(param_00,param_01)
{
	var_02 = level._audio.zone_mgr.zones[param_00]["mix"];
	if(!azm_get_mix_bypass())
	{
		if(isdefined(var_02))
		{
			soundscripts\_audio_mix_manager::mm_start_zone_preset(var_02);
			return;
		}

		soundscripts\_audio_mix_manager::mm_clear_zone_mix(undefined,param_01);
	}
}

//Function Number: 44
azmx_set_param_internal(param_00,param_01,param_02,param_03,param_04)
{
	if(isdefined(level._audio.zone_mgr.zones[param_00]))
	{
		if((isdefined(level._audio.zone_mgr.zones[param_00][param_01]) && level._audio.zone_mgr.zones[param_00][param_01] != param_02) || !isdefined(level._audio.zone_mgr.zones[param_00][param_01]) && param_02 != "none")
		{
			if(param_02 == "none")
			{
				level._audio.zone_mgr.zones[param_00][param_01] = undefined;
			}
			else
			{
				level._audio.zone_mgr.zones[param_00][param_01] = param_02;
			}

			if(param_00 == azm_get_current_zone())
			{
				[[ param_03 ]](param_00,param_04);
			}
		}

		return 1;
	}

	return 0;
}

//Function Number: 45
azmx_wait_till_fade_done_and_remove_zone(param_00,param_01)
{
	wait(param_01);
	wait(0.05);
	if(level._audio.zone_mgr.zones[param_00]["state"] == "stopping")
	{
	}
}

//Function Number: 46
azmx_get_blend_args(param_00,param_01)
{
	var_02 = spawnstruct();
	var_02.zone_from_name = param_00;
	var_02.zone_to_name = param_01;
	var_02.samb1_name = undefined;
	var_02.samb2_name = undefined;
	var_02.damb1_name = undefined;
	var_02.damb2_name = undefined;
	var_02.occlusion1 = undefined;
	var_02.occlusion2 = undefined;
	var_02.filter1 = undefined;
	var_02.filter2 = undefined;
	var_02.reverb1 = undefined;
	var_02.reverb2 = undefined;
	var_02.mix1_name = undefined;
	var_02.mix2_name = undefined;
	if(!isdefined(level._audio.zone_mgr.zones[param_00]))
	{
		var_03 = azmx_load_zone(param_00);
		if(!isdefined(var_03))
		{
			soundscripts\_audio::aud_print_warning("Couldn\'t find zone: " + param_00);
			return;
		}

		level._audio.zone_mgr.zones[param_00] = var_03;
	}

	var_04 = level._audio.zone_mgr.zones[param_00];
	if(!isdefined(level._audio.zone_mgr.zones[param_01]))
	{
		var_03 = azmx_load_zone(param_01);
		if(!isdefined(var_03))
		{
			soundscripts\_audio::aud_print_warning("Couldn\'t find zone: " + param_01);
			return;
		}

		level._audio.zone_mgr.zones[param_01] = var_03;
	}

	var_05 = level._audio.zone_mgr.zones[param_01];
	var_02.occlusion1 = var_04["occlusion"];
	var_02.occlusion2 = var_05["occlusion"];
	var_02.filter1 = var_04["filter"];
	var_02.filter2 = var_05["filter"];
	var_02.reverb1 = var_04["reverb"];
	var_02.reverb2 = var_05["reverb"];
	var_02.mix1 = var_04["mix"];
	var_02.mix2 = var_05["mix"];
	var_02.samb1_name = var_04["streamed_ambience"];
	var_02.samb2_name = var_05["streamed_ambience"];
	var_06 = level._audio.damb.playing["zone"].size;
	if(var_06 > 1)
	{
		soundscripts\_audio_dynamic_ambi::damb_stop(1,"zone");
	}

	var_02.damb1_name = var_04["dynamic_ambience"];
	var_02.damb2_name = var_05["dynamic_ambience"];
	return var_02;
}

//Function Number: 47
azmx_is_valid_mix_blend_request(param_00,param_01)
{
	var_02 = 0;
	if(isdefined(param_00) && isdefined(param_01) && param_00 != param_01)
	{
		var_02 = 1;
	}
	else if(isdefined(param_01) && !isdefined(param_00))
	{
		var_02 = 1;
	}
	else if(isdefined(param_00) && !isdefined(param_01))
	{
		var_02 = 1;
	}

	return var_02;
}

//Function Number: 48
azmx_is_valid_damb_blend_request(param_00,param_01)
{
	var_02 = 0;
	if(isdefined(param_00) && isdefined(param_01) && param_00 != param_01)
	{
		var_02 = 1;
	}
	else if(isdefined(param_01) && !isdefined(param_00))
	{
		var_02 = 1;
	}
	else if(isdefined(param_00) && !isdefined(param_01))
	{
		var_02 = 1;
	}

	return var_02;
}

//Function Number: 49
azmx_is_valid_samb_blend_request(param_00,param_01)
{
	var_02 = 0;
	if(isdefined(param_00) && isdefined(param_01) && param_00 != param_01)
	{
		var_02 = 1;
	}
	else if(isdefined(param_01) && !isdefined(param_00))
	{
		var_02 = 1;
	}

	return var_02;
}

//Function Number: 50
azmx_blend_zones(param_00,param_01,param_02)
{
	if(azmx_is_valid_samb_blend_request(param_02.samb1_name,param_02.samb2_name))
	{
		var_03 = [];
		var_04 = 0;
		if(isdefined(param_02.samb1_name) && param_02.samb1_name != "")
		{
			var_05 = level._audio.zone_mgr.zones[param_02.zone_from_name];
			var_03[var_04] = spawnstruct();
			var_03[var_04].alias = param_02.samb1_name;
			var_03[var_04].vol = param_00;
			var_03[var_04].fade = var_05["interrupt_fade"];
			var_03[var_04].priority = var_05["priority"];
			var_04++;
		}

		if(isdefined(param_02.samb2_name) && param_02.samb2_name != "")
		{
			var_06 = level._audio.zone_mgr.zones[param_02.zone_to_name];
			var_03[var_04] = spawnstruct();
			var_03[var_04].alias = param_02.samb2_name;
			var_03[var_04].vol = param_01;
			var_03[var_04].fade = var_06["interrupt_fade"];
			var_03[var_04].priority = var_06["priority"];
		}

		if(var_03.size > 0)
		{
			soundscripts\_audio_stream_manager::sm_mix_ambience(var_03);
		}
	}

	if(azmx_is_valid_damb_blend_request(param_02.damb1_name,param_02.damb2_name))
	{
		soundscripts\_audio_dynamic_ambi::damb_prob_mix_damb_presets(param_02.damb1_name,param_00,param_02.damb2_name,param_01);
	}

	if(azmx_is_valid_mix_blend_request(param_02.mix1,param_02.mix2) && !azm_get_mix_bypass())
	{
		soundscripts\_audio_mix_manager::mm_blend_zone_mix(param_02.mix1,param_00,param_02.mix2,param_01);
	}

	if(isdefined(param_02.filter1))
	{
		if(!azm_get_filter_bypass())
		{
			soundscripts\_snd_filters::snd_set_filter(param_02.filter1,0,0);
		}
	}
	else if(!azm_get_filter_bypass())
	{
		soundscripts\_snd_filters::snd_set_filter(undefined,0,0);
	}

	if(isdefined(param_02.filter2))
	{
		if(!azm_get_filter_bypass())
		{
			soundscripts\_snd_filters::snd_set_filter(param_02.filter2,1,0);
		}
	}
	else if(!azm_get_filter_bypass())
	{
		soundscripts\_snd_filters::snd_set_filter(undefined,1,0);
	}

	if(isdefined(param_02.filter1) || isdefined(param_02.filter2))
	{
		if(!azm_get_filter_bypass())
		{
			soundscripts\_snd_filters::snd_set_filter_lerp(param_00);
		}
	}

	if(param_00 >= 0.75)
	{
		if(isdefined(param_02.reverb1) && !azm_get_reverb_bypass())
		{
			if(param_02.reverb1 == "none")
			{
				soundscripts\_audio_reverb::rvb_start_preset(undefined);
			}
			else
			{
				soundscripts\_audio_reverb::rvb_start_preset(param_02.reverb1);
			}
		}

		if(isdefined(param_02.occlusion1) && azm_get_occlusion_bypass())
		{
			if(param_02.occlusion1 == "none")
			{
				soundscripts\_snd_filters::snd_set_occlusion(undefined);
				return;
			}

			soundscripts\_snd_filters::snd_set_occlusion(param_02.occlusion1);
			return;
		}

		return;
	}

	if(param_01 >= 0.75)
	{
		if(isdefined(param_02.reverb2) && !azm_get_reverb_bypass())
		{
			if(param_02.reverb2 == "none")
			{
				soundscripts\_audio_reverb::rvb_start_preset(undefined);
			}
			else
			{
				soundscripts\_audio_reverb::rvb_start_preset(param_02.reverb2);
			}
		}

		if(isdefined(param_02.occlusion2) && !azm_get_occlusion_bypass())
		{
			if(param_02.occlusion2 == "none")
			{
				soundscripts\_snd_filters::snd_set_occlusion(undefined);
				return;
			}

			soundscripts\_snd_filters::snd_set_occlusion(param_02.occlusion2);
			return;
		}
	}
}