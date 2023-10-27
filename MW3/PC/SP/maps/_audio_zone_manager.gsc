/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\_audio_zone_manager.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: PC
 * Function Count: 30
 * Decompile Time: 379 ms
 * Timestamp: 10/27/2023 2:20:29 AM
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
		level._audio.zone_mgr.overrides.indexed = [];
		level._audio.zone_mgr.overrides.rev = [];
		level._audio.zone_mgr.overrides.occ = [];
		level._audio.zone_mgr.use_string_table_presets = 0;
		level._audio.zone_mgr.use_iw_presets = 0;
	}

	if(!isdefined(level._audio.use_level_audio_zones))
	{
		level._audio.level_audio_reverb_function = undefined;
	}
}

//Function Number: 2
azm_use_string_table()
{
	level._audio.zone_mgr.use_string_table_presets = 1;
	level._audio.zone_mgr.use_iw_presets = 0;
}

//Function Number: 3
azm_use_iw_presets()
{
	level._audio.zone_mgr.use_iw_presets = 1;
	level._audio.zone_mgr.use_string_table_presets = 0;
}

//Function Number: 4
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
		maps\_audio::aud_print_warning("ZONEM_start_zone(\" + param_00 + "\") being called even though audio zone, \" + param_00 + "\", is already started.");
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
	maps\_audio::aud_print_zone("ZONE START: " + param_00);
	level._audio.zone_mgr.zones[param_00]["state"] = "playing";
	var_05 = var_04["priority"];
	var_06 = var_04["interrupt_fade"];
	if(isdefined(var_04["streamed_ambience"]))
	{
		if(var_04["streamed_ambience"] != "none")
		{
			lib_0068::func_147D(var_04["streamed_ambience"],var_03,var_05,var_06);
		}
		else
		{
			lib_0068::func_1483(var_03);
		}
	}

	if(isdefined(var_04["dynamic_ambience"]))
	{
		if(var_04["dynamic_ambience"] != "none")
		{
			maps\_audio_dynamic_ambi::damb_zone_start_preset(var_04["dynamic_ambience"],1);
		}
		else
		{
			maps\_audio_dynamic_ambi::damb_stop_zone(1);
		}
	}

	if(isdefined(var_04["occlusion"]))
	{
		if(var_04["occlusion"] != "none")
		{
			maps\_audio::aud_set_occlusion(var_04["occlusion"]);
		}
		else
		{
			maps\_audio::aud_deactivate_occlusion();
		}
	}

	if(isdefined(var_04["filter"]))
	{
		if(var_04["filter"] != "none")
		{
			maps\_audio::aud_set_filter(var_04["filter"],0);
			level.player seteqlerp(1,0);
		}
	}

	if(isdefined(var_04["reverb"]))
	{
		if(var_04["reverb"] != "none")
		{
			lib_0086::func_1465(var_04["reverb"]);
		}
		else
		{
			lib_0086::func_146B();
		}
	}

	if(isdefined(var_04["mix"]))
	{
		if(var_04["mix"] != "none")
		{
			lib_0087::func_1510(var_04["mix"]);
			return;
		}

		lib_0087::func_1513(1);
	}
}

//Function Number: 5
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

//Function Number: 6
azm_set_zone_dynamic_ambience(param_00,param_01,param_02)
{
	if(!isdefined(param_01))
	{
		param_01 = "none";
	}

	azmx_set_param_internal(param_00,"dynamic_ambience",param_01,::azmx_restart_damb,param_02);
	level._audio.zone_mgr.overrides.damb[param_00] = param_01;
}

//Function Number: 7
azm_set_zone_reverb(param_00,param_01,param_02)
{
	if(!isdefined(param_01))
	{
		param_01 = "none";
	}

	azmx_set_param_internal(param_00,"reverb",param_01,::azmx_restart_reverb,param_02);
	level._audio.zone_mgr.overrides.rev[param_00] = param_01;
}

//Function Number: 8
azm_set_zone_occlusion(param_00,param_01,param_02)
{
	if(!isdefined(param_01))
	{
		param_01 = "none";
	}

	azmx_set_param_internal(param_00,"occlusion",param_01,::azmx_restart_occlusion,param_02);
	level._audio.zone_mgr.overrides.indexed[param_01] = param_01;
}

//Function Number: 9
azm_set_zone_mix(param_00,param_01,param_02)
{
	if(!isdefined(param_01))
	{
		param_01 = "none";
	}

	azmx_set_param_internal(param_00,"mix",param_01,::azmx_restart_mix,param_02);
	level._audio.zone_mgr.overrides.indexed[param_01] = param_01;
}

//Function Number: 10
azm_stop_zones(param_00)
{
	var_01 = 1;
	if(isdefined(param_00))
	{
		var_01 = param_00;
	}

	maps\_audio::aud_print_zone("ZONE STOP ALL");
	foreach(var_03 in level._audio.zone_mgr.zones)
	{
		azm_stop_zone(var_03["name"],var_01,0);
	}
}

//Function Number: 11
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
			maps\_audio::aud_print_zone("ZONE STOP ZONE: " + param_00);
		}

		if(isdefined(var_04["streamed_ambience"]))
		{
			lib_0068::func_1481(var_04["streamed_ambience"],var_03);
		}

		if(isdefined(var_04["dynamic_ambience"]))
		{
			maps\_audio_dynamic_ambi::damb_zone_stop_preset(var_04["dynamic_ambience"],var_03);
		}

		level._audio.zone_mgr.zones[param_00]["state"] = "stopping";
		thread azmx_wait_till_fade_done_and_remove_zone(param_00,var_03);
	}
}

//Function Number: 12
azm_get_current_zone()
{
	return level._audio.zone_mgr.current_zone;
}

//Function Number: 13
azm_set_current_zone(param_00)
{
	level._audio.zone_mgr.current_zone = param_00;
}

//Function Number: 14
azm_print_enter_blend(param_00,param_01,param_02)
{
}

//Function Number: 15
azm_print_exit_blend(param_00)
{
}

//Function Number: 16
azm_print_progress(param_00)
{
}

//Function Number: 17
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
	if(isdefined(level._audio.zone_mgr.overrides.samb[param_00]))
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

	if(isdefined(level._audio.zone_mgr.overrides.damb[param_00]))
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

	if(isdefined(level._audio.zone_mgr.overrides.rev[param_00]))
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

	if(isdefined(level._audio.zone_mgr.overrides.occ[param_00]))
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

	if(isdefined(level._audio.zone_mgr.overrides.indexed[param_00]))
	{
		if(level._audio.zone_mgr.overrides.indexed[param_00] == "none")
		{
			var_01["mix"] = undefined;
		}
		else
		{
			var_01["mix"] = level._audio.zone_mgr.overrides.indexed[param_00];
		}

		var_02 = 1;
		level._audio.zone_mgr.overrides.indexed[param_00] = undefined;
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

//Function Number: 18
azmx_get_preset_from_string_table(param_00,param_01)
{
	var_02 = "soundtables/common_zone.csv";
	var_03 = maps\_audio::get_zone_stringtable();
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

//Function Number: 19
azmx_get_zone_preset_from_stringtable_internal(param_00,param_01)
{
	var_02 = [];
	var_03 = "";
	var_04 = "";
	var_05 = 8;
	for(var_06 = 1;var_06 < var_05;var_06++)
	{
		if(var_03 != "comments" && var_04 != "")
		{
			var_02[var_03] = var_04;
		}

		var_03 = tablelookup(param_00,0,"zone_names",var_06);
		var_04 = tablelookup(param_00,0,param_01,var_06);
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

//Function Number: 20
azmx_restart_stream(param_00,param_01)
{
	var_02 = level._audio.zone_mgr.zones[param_00]["streamed_ambience"];
	if(isdefined(var_02))
	{
		lib_0068::func_147D(var_02,param_01);
		return;
	}

	lib_0068::func_1483(param_01);
}

//Function Number: 21
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
		maps\_audio_dynamic_ambi::damb_zone_start_preset(var_03,var_02);
		return;
	}

	maps\_audio_dynamic_ambi::damb_zone_stop_preset(undefined,var_02);
}

//Function Number: 22
azmx_restart_reverb(param_00,param_01)
{
	var_02 = level._audio.zone_mgr.zones[param_00]["reverb"];
	if(isdefined(var_02))
	{
		lib_0086::func_1465(var_02);
	}
}

//Function Number: 23
azmx_restart_occlusion(param_00,param_01)
{
	var_02 = level._audio.zone_mgr.zones[param_00]["occlusion"];
	if(isdefined(var_02))
	{
		maps\_audio::aud_set_occlusion(var_02);
	}
}

//Function Number: 24
azmx_restart_mix(param_00,param_01)
{
	var_02 = level._audio.zone_mgr.zones[param_00]["mix"];
	if(isdefined(var_02))
	{
		lib_0087::func_150F(var_02);
	}
}

//Function Number: 25
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

//Function Number: 26
azmx_wait_till_fade_done_and_remove_zone(param_00,param_01)
{
	wait param_01;
	wait 0.05;
	if(level._audio.zone_mgr.zones[param_00]["state"] == "stopping")
	{
	}
}

//Function Number: 27
azmx_get_blend_args(param_00,param_01)
{
	var_02 = spawnstruct();
	var_02.zone_from_name = param_00;
	var_02.zone_to_name = param_01;
	var_02.samb1_name = undefined;
	var_02.samb2_name = undefined;
	var_02.damb1_name = undefined;
	var_02.damb2_name = undefined;
	var_02.var_158F = undefined;
	var_02.var_1590 = undefined;
	var_02.filter1 = undefined;
	var_02.filter2 = undefined;
	var_02.occlusion1 = undefined;
	var_02.var_1594 = undefined;
	var_02.mix1_name = undefined;
	var_02.mix2_name = undefined;
	if(!isdefined(level._audio.zone_mgr.zones[param_00]))
	{
		var_03 = azmx_load_zone(param_00);
		if(!isdefined(var_03))
		{
			maps\_audio::aud_print_warning("Couldn\'t find zone: " + param_00);
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
			maps\_audio::aud_print_warning("Couldn\'t find zone: " + param_01);
			return;
		}

		level._audio.zone_mgr.zones[param_01] = var_03;
	}

	var_05 = level._audio.zone_mgr.zones[param_01];
	var_02.var_158F = var_04["occlusion"];
	var_02.var_1590 = var_05["occlusion"];
	var_02.filter1 = var_04["filter"];
	var_02.filter2 = var_05["filter"];
	var_02.occlusion1 = var_04["reverb"];
	var_02.var_1594 = var_05["reverb"];
	var_02.mix2 = var_04["mix"];
	var_02.var_1598 = var_05["mix"];
	var_02.samb1_name = var_04["streamed_ambience"];
	var_02.samb2_name = var_05["streamed_ambience"];
	var_06 = level._audio.damb.playing["zone"].size;
	if(var_06 != 1)
	{
		maps\_audio_dynamic_ambi::damb_stop(1,"zone");
	}

	if(var_06 == 1)
	{
		foreach(var_09, var_08 in level._audio.damb.playing["zone"])
		{
			var_02.damb1_name = var_09;
			break;
		}
	}

	var_02.damb2_name = var_05["dynamic_ambience"];
	return var_02;
}

//Function Number: 28
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

//Function Number: 29
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

//Function Number: 30
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
			lib_0068::func_1485(var_03);
		}
	}

	if(azmx_is_valid_damb_blend_request(param_02.damb1_name,param_02.damb2_name))
	{
		maps\_audio_dynamic_ambi::damb_prob_mix_damb_presets(param_02.damb1_name,param_00,param_02.damb2_name,param_01);
	}

	var_07 = 0;
	if(maps\_audio::aud_is_zone_filter_enabled())
	{
		if(isdefined(param_02.filter1))
		{
			var_07 = 1;
			maps\_audio::aud_set_filter(param_02.filter1,0,0);
		}
		else
		{
			maps\_audio::aud_set_filter(undefined,0,0);
		}

		if(isdefined(param_02.filter2))
		{
			var_07 = 1;
			maps\_audio::aud_set_filter(param_02.filter2,1,0);
		}
		else
		{
			maps\_audio::aud_set_filter(undefined,1,0);
		}

		if(!isdefined(level._audio.var_159D) && level._audio.var_159D)
		{
			if(isdefined(param_02.filter1) || isdefined(param_02.filter2))
			{
				level.player seteqlerp(param_00,0);
			}
		}
	}

	if(param_00 >= 0.75)
	{
		if(isdefined(param_02.occlusion1))
		{
			if(param_02.occlusion1 == "none")
			{
				lib_0086::func_1465(undefined);
			}
			else
			{
				lib_0086::func_1465(param_02.occlusion1);
			}
		}

		if(isdefined(param_02.mix2))
		{
			if(param_02.mix2 == "none")
			{
				lib_0087::func_1513(2);
			}
			else
			{
				lib_0087::func_1510(param_02.mix2);
			}
		}

		if(maps\_audio::aud_is_zone_filter_enabled())
		{
			if(isdefined(param_02.var_158F))
			{
				if(param_02.var_158F == "none")
				{
					maps\_audio::aud_deactivate_occlusion();
					return;
				}

				maps\_audio::aud_set_occlusion(param_02.var_158F);
				return;
			}

			return;
		}

		return;
	}

	if(param_01 >= 0.75)
	{
		if(isdefined(param_02.var_1594))
		{
			if(param_02.var_1594 == "none")
			{
				lib_0086::func_1465(undefined);
			}
			else
			{
				lib_0086::func_1465(param_02.var_1594);
			}
		}

		if(isdefined(param_02.var_1598))
		{
			if(param_02.var_1598 == "none")
			{
				lib_0087::func_1513(2);
			}
			else
			{
				lib_0087::func_1510(param_02.var_1598);
			}
		}

		if(maps\_audio::aud_is_zone_filter_enabled())
		{
			if(isdefined(param_02.var_1590))
			{
				if(param_02.var_1590 == "none")
				{
					maps\_audio::aud_deactivate_occlusion();
					return;
				}

				maps\_audio::aud_set_occlusion(param_02.var_1590);
				return;
			}

			return;
		}
	}
}