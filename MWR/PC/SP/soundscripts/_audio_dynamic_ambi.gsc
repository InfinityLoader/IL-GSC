/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: soundscripts\_audio_dynamic_ambi.gsc
 * Game: Call of Duty: Modern Warfare Remastered
 * Platform: PC
 * Function Count: 54
 * Decompile Time: 867 ms
 * Timestamp: 10/27/2023 2:50:25 AM
*******************************************************************/

//Function Number: 1
damb_init()
{
	if(!isdefined(level._audio))
	{
		level._audio = spawnstruct();
	}

	if(!isdefined(level._audio.damb))
	{
		level._audio.damb = spawnstruct();
		level._audio.damb.loop_handle_index = 0;
		level._audio.damb.single_loop_handle_index = 0;
		level._audio.damb.oneshot_handle_index = 0;
		level._audio.damb.serial_playback_lock = 1;
		level._audio.damb.playing = [];
		level._audio.damb.playing["zone"] = [];
		level._audio.damb.playing["free"] = [];
		level._audio.damb.component_weights = [];
		level._audio.damb.callbacks = [];
		level._audio.damb.preset_cache = [];
		level._audio.damb.component_cache = [];
		level._audio.damb.loop_cache = [];
		level._audio.damb.use_string_table_presets = 0;
		level._audio.damb.entity_ref_count = 0;
		level._audio.damb.loop_entity_ref_count = 0;
		level._audio.damb.max_entities = 15;
	}
}

//Function Number: 2
damb_set_max_entities(param_00)
{
	level._audio.damb.max_entities = param_00;
}

//Function Number: 3
damb_use_string_table()
{
	level._audio.damb.use_string_table_presets = 1;
}

//Function Number: 4
damb_zone_start_preset(param_00,param_01)
{
	dambx_start_preset("zone",param_00,undefined,param_01);
}

//Function Number: 5
damb_start_preset(param_00,param_01,param_02,param_03)
{
	dambx_start_preset("free",param_00,param_01,param_02,undefined,undefined,undefined,param_03);
}

//Function Number: 6
damb_start_preset_at_point(param_00,param_01,param_02,param_03,param_04,param_05)
{
	if(isdefined(param_03))
	{
		thread dambx_monitor_damb_point_distance(param_00,param_01,param_02,param_03,param_04,param_05);
		return;
	}

	dambx_start_preset("free",param_00,param_02,undefined,param_01,undefined,undefined,param_05);
}

//Function Number: 7
damb_stop_preset_at_point(param_00,param_01,param_02)
{
	if(isstring(param_01))
	{
		var_03 = param_01;
	}
	else
	{
		var_03 = param_01;
	}

	level notify(var_03 + "dist_monitor_stop");
	damb_stop_preset(var_03,param_02);
}

//Function Number: 8
damb_make_linked_damb(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = spawnstruct();
	var_05.name = param_00;
	var_05.point = param_01;
	var_05.label = param_02;
	var_05.min_delay = param_03;
	var_05.max_delay = param_04;
	return var_05;
}

//Function Number: 9
dambx_monitor_damb_point_distance(param_00,param_01,param_02,param_03,param_04,param_05)
{
	if(isstring(param_02))
	{
		level endon(param_02 + "dist_monitor_stop");
	}
	else
	{
		level endon(param_00 + "dist_monitor_stop");
	}

	var_06 = 1;
	if(isdefined(param_04))
	{
		var_06 = param_04;
	}

	var_07 = 1;
	for(;;)
	{
		var_08 = distance(level.player.origin,param_01);
		if(var_08 < param_03)
		{
			if(var_07)
			{
				var_07 = 0;
				dambx_start_preset("free",param_00,param_02,undefined,param_01,undefined,undefined,param_05);
			}
		}
		else if(!var_07)
		{
			var_07 = 1;
			if(isdefined(param_02))
			{
				dambx_stop_preset("free",param_02,var_06);
			}
			else
			{
				dambx_stop_preset("free",param_00,var_06);
			}
		}

		wait(1);
	}
}

//Function Number: 10
damb_start_preset_on_entity(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = "attach";
	if(isdefined(param_03))
	{
		var_05 = param_03;
	}

	dambx_start_preset("free",param_00,param_02,param_04,undefined,param_01,var_05);
}

//Function Number: 11
damb_stop(param_00,param_01)
{
	var_02 = 2;
	if(isdefined(param_00))
	{
		var_02 = param_00;
	}

	var_03 = "all";
	if(isdefined(param_01))
	{
		var_03 = param_01;
	}

	if(var_03 == "free" || var_03 == "all")
	{
		foreach(var_06, var_05 in level._audio.damb.playing["free"])
		{
			damb_stop_preset(var_06,var_02);
		}
	}

	if(var_03 == "zone" || var_03 == "all")
	{
		foreach(var_06, var_05 in level._audio.damb.playing["zone"])
		{
			damb_zone_stop_preset(var_06,var_02);
		}
	}
}

//Function Number: 12
damb_stop_zone(param_00)
{
	dambx_stop_preset("zone",undefined,param_00);
}

//Function Number: 13
damb_zone_stop_preset(param_00,param_01)
{
	dambx_stop_preset("zone",param_00,param_01);
}

//Function Number: 14
damb_stop_preset(param_00,param_01)
{
	dambx_stop_preset("free",param_00,param_01);
}

//Function Number: 15
damb_prob_mix_damb_presets(param_00,param_01,param_02,param_03)
{
	if(isdefined(param_00) && param_00 != "none")
	{
		if(param_01 == 0)
		{
			damb_zone_stop_preset(param_00,2);
		}
		else
		{
			damb_zone_start_preset(param_00,param_01);
		}
	}

	if(isdefined(param_02) && param_02 != "none")
	{
		if(param_03 == 0)
		{
			damb_zone_stop_preset(param_02,2);
			return;
		}

		damb_zone_start_preset(param_02,param_03);
	}
}

//Function Number: 16
damb_set_oneshot_callback_for_component(param_00,param_01)
{
	if(!isdefined(level._audio.damb.callback))
	{
		level._audio.damb.callback = [];
	}

	level._audio.damb.callback[param_00] = param_01;
}

//Function Number: 17
damb_set_oneshot_callback_for_dynamic_ambience(param_00,param_01)
{
	var_02 = [];
	if(isdefined(level._audio.damb.preset_cache[param_00]))
	{
		var_02 = level._audio.damb.preset_cache[param_00];
	}
	else if(level._audio.damb.use_string_table_presets)
	{
		var_02 = dambx_get_preset_from_string_table(param_00,1);
		level._audio.damb.preset_cache[param_00] = var_02;
	}
	else
	{
		var_02 = dambx_get_preset_from_string_table(param_00,0);
		level._audio.damb.preset_cache[param_00] = var_02;
	}

	foreach(var_04 in var_02["components"])
	{
		damb_set_oneshot_callback_for_component(var_04,param_01);
	}
}

//Function Number: 18
damb_pause_damb(param_00,param_01)
{
	var_02 = "free";
	if(isdefined(param_01))
	{
		var_02 = param_01;
	}

	if(isdefined(level._audio.damb.playing[var_02][param_00]))
	{
		level._audio.damb.playing[var_02][param_00]["paused"] = 1;
	}
}

//Function Number: 19
damb_unpause_damb(param_00,param_01)
{
	var_02 = "free";
	if(isdefined(param_01))
	{
		var_02 = param_01;
	}

	if(isdefined(level._audio.damb.playing[var_02][param_00]))
	{
		level._audio.damb.playing[var_02][param_00]["paused"] = 0;
		level notify(var_02 + "_" + param_00 + "_event");
	}
}

//Function Number: 20
damb_manual_trigger(param_00,param_01)
{
	var_02 = "free";
	if(isdefined(param_01))
	{
		var_02 = param_01;
	}

	if(isdefined(level._audio.damb.playing[var_02][param_00]))
	{
		level notify(var_02 + "_" + param_00 + "_event");
	}
}

//Function Number: 21
damb_link_to_damb(param_00,param_01,param_02,param_03)
{
	var_04 = "free";
	if(isdefined(level._audio.damb.playing[var_04][param_00]) && isdefined(level._audio.damb.playing[var_04][param_01]))
	{
		param_02 = min(param_02,param_03);
		param_03 = max(param_02,param_03);
		if(!isdefined(level._audio.damb.playing[var_04][param_00]["linked_dambs"]))
		{
			level._audio.damb.playing[var_04][param_00]["linked_dambs"] = [];
		}

		var_05 = level._audio.damb.playing[var_04][param_00]["linked_dambs"].size;
		level._audio.damb.playing[var_04][param_00]["linked_dambs"][var_05] = spawnstruct();
		level._audio.damb.playing[var_04][param_00]["linked_dambs"][var_05].name = param_01;
		level._audio.damb.playing[var_04][param_00]["linked_dambs"][var_05].min_delay = max(param_02,0);
		level._audio.damb.playing[var_04][param_00]["linked_dambs"][var_05].max_delay = max(param_03,0);
	}
}

//Function Number: 22
dambx_start_preset(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07)
{
	var_08 = 1;
	if(isdefined(param_03))
	{
		var_08 = param_03;
	}

	var_09 = param_01;
	if(isstring(param_02))
	{
		var_09 = param_02;
	}

	if(!isdefined(level._audio.damb.playing[param_00][var_09]))
	{
		var_0A = dambx_get_damb_preset(param_01);
		if(!isdefined(var_0A))
		{
			return;
		}

		level._audio.damb.playing[param_00][var_09] = var_0A;
		level._audio.damb.playing[param_00][var_09]["prob_scale"] = var_08;
		level._audio.damb.playing[param_00][var_09]["paused"] = 0;
		if(isdefined(param_07))
		{
			dambx_start_linked_dambs(var_09,param_07);
		}

		if(isdefined(param_05))
		{
			level._audio.damb.playing[param_00][var_09]["entity"] = param_05;
			level._audio.damb.playing[param_00][var_09]["mode"] = param_06;
		}

		thread dambx_play(param_00,var_09,param_04);
		return;
	}

	if(level._audio.damb.playing[param_00][var_09]["prob_scale"] != var_08)
	{
		level._audio.damb.playing[param_00][var_09]["prob_scale"] = var_08;
	}
}

//Function Number: 23
dambx_start_linked_dambs(param_00,param_01)
{
	if(isarray(param_01))
	{
		foreach(var_03 in param_01)
		{
			dambx_start_preset("free",var_03.name,var_03.label,undefined,var_03.point);
			damb_pause_damb(var_03.label);
			damb_link_to_damb(param_00,var_03.label,var_03.min_delay,var_03.max_delay);
		}

		return;
	}

	dambx_start_preset("free",param_01.name,param_01.label,undefined,param_01.point);
	damb_pause_damb(param_01.label);
	damb_link_to_damb(param_00,param_01.label,param_01.min_delay,param_01.max_delay);
}

//Function Number: 24
dambx_stop_preset(param_00,param_01,param_02)
{
	var_03 = 2;
	if(isdefined(param_02))
	{
		var_03 = param_02;
	}

	if(param_00 == "zone" && !isdefined(param_01))
	{
		if(isdefined(level._audio.damb.playing[param_00]))
		{
			foreach(param_01, var_05 in level._audio.damb.playing[param_00])
			{
				level._audio.damb.playing[param_00][param_01]["fade"] = var_03;
				level notify(param_00 + "_" + param_01 + "_stop");
			}

			return;
		}

		return;
	}

	if(isdefined(level._audio.damb.playing[param_02][var_03]))
	{
		level._audio.damb.playing[param_02][var_03]["fade"] = var_05;
		level notify(param_02 + "_" + var_03 + "_stop");
	}
}

//Function Number: 25
dambx_update_serially(param_00,param_01,param_02)
{
	level endon(param_00 + "_" + param_01 + "_stop");
	var_03 = level._audio.damb.playing[param_00][param_01]["event_time"];
	var_04 = min(var_03[0],var_03[1]);
	var_05 = max(var_03[0],var_03[1]);
	var_06 = undefined;
	var_07 = undefined;
	if(isdefined(level._audio.damb.playing[param_00][param_01]["first_event"]))
	{
		var_03 = level._audio.damb.playing[param_00][param_01]["first_event"];
		var_06 = min(var_03[0],var_03[1]);
		var_07 = max(var_03[0],var_03[1]);
	}

	var_08 = undefined;
	if(isdefined(var_06))
	{
		var_08 = randomfloatrange(var_06,var_07);
	}
	else
	{
		var_08 = randomfloatrange(var_04,var_05);
	}

	for(;;)
	{
		if(!level._audio.damb.playing[param_00][param_01]["paused"])
		{
			wait(var_08);
		}

		if(level._audio.damb.playing[param_00][param_01]["paused"])
		{
			level waittill(param_00 + "_" + param_01 + "_event");
		}

		var_09 = dambx_pick_random_component(param_00,param_01);
		if(!isdefined(var_09))
		{
			continue;
		}

		var_0A = dambx_get_component_data(param_00,param_01,var_09,param_01);
		if(var_0A.using_oneshots_or_loops)
		{
			if(var_0A.using_entity && !isdefined(var_0A.ent))
			{
				level notify(param_00 + "_" + param_01 + "_stop");
				break;
			}

			var_0B = dambx_create_damb_event(var_0A,param_01,var_09);
			if(var_0B.success)
			{
				if(level._audio.damb.serial_playback_lock)
				{
					dambx_perform_play_event(param_00,param_01,var_0B);
				}
				else
				{
					thread dambx_perform_play_event(param_00,param_01,var_0B);
				}
			}
		}
		else
		{
			soundscripts\_audio::aud_print_warning("Dynamic ambience is playing back serially and using components which do not define oneshots or loops");
		}

		var_08 = randomfloatrange(var_04,var_05);
	}
}

//Function Number: 26
dambx_play_component_loops(param_00,param_01,param_02,param_03,param_04)
{
	if(isdefined(param_02["single_loops"]))
	{
		foreach(var_06 in param_02["single_loops"])
		{
			var_07 = undefined;
			if(isdefined(param_04))
			{
				var_07 = spawn("script_origin",param_04.origin);
			}
			else if(isdefined(param_03))
			{
				var_07 = spawn("script_origin",param_03);
			}
			else
			{
				var_07 = spawn("script_origin",level.player.origin);
			}

			level._audio.damb.loop_entity_ref_count++;
			var_07 playloopsound(var_06);
			if(isdefined(param_04))
			{
				var_07 linkto(param_04);
			}

			var_08 = level._audio.damb.single_loop_handle_index;
			level._audio.damb.playing[param_00][param_01]["single_loops"][var_08] = var_07;
			level._audio.damb.single_loop_handle_index++;
		}
	}
}

//Function Number: 27
dambx_get_component_data(param_00,param_01,param_02)
{
	var_03 = spawnstruct();
	var_03.using_oneshots_or_loops = 0;
	if(!isdefined(param_02["single_loops"]))
	{
		var_03.single_loops = 0;
	}
	else
	{
		var_03.single_loops = 1;
	}

	if(isdefined(param_02["oneshots"]) || isdefined(param_02["loops"]))
	{
		var_03.using_oneshots_or_loops = 1;
		if(!isdefined(param_02["radius"]))
		{
			param_02["radius"] = [0,0.01];
		}

		var_03.min_radius = min(param_02["radius"][0],param_02["radius"][1]);
		var_03.max_radius = max(param_02["radius"][0],param_02["radius"][1]);
		if(isarray(param_02["event_time"]))
		{
			var_03.min_time = min(param_02["event_time"][0],param_02["event_time"][1]);
			var_03.max_time = max(param_02["event_time"][0],param_02["event_time"][1]);
		}

		if(isarray(param_02["first_event"]))
		{
			var_03.first_event = 1;
			var_03.first_event_min = min(param_02["first_event"][0],param_02["first_event"][1]);
			var_03.first_event_max = max(param_02["first_event"][0],param_02["first_event"][1]);
		}

		if(isarray(param_02["pitch"]))
		{
			var_03.min_pitch = min(param_02["pitch"][0],param_02["pitch"][1]);
			var_03.max_pitch = max(param_02["pitch"][0],param_02["pitch"][1]);
		}

		if(isarray(param_02["travel_time"]))
		{
			var_03.min_trav_time = min(param_02["travel_time"][0],param_02["travel_time"][1]);
			var_03.max_trav_time = max(param_02["travel_time"][0],param_02["travel_time"][1]);
			if(isarray(param_02["delta"]))
			{
				var_03.min_delta = min(param_02["delta"][0],param_02["delta"][1]);
				var_03.max_delta = max(param_02["delta"][0],param_02["delta"][1]);
			}
			else
			{
				var_03.min_delta_angle = min(param_02["delta_angle"][0],param_02["delta_angle"][1]);
				var_03.max_delta_angle = max(param_02["delta_angle"][0],param_02["delta_angle"][1]);
			}
		}

		if(isarray(param_02["pitch_time"]))
		{
			var_03.min_pitch_time = min(param_02["pitch_time"][0],param_02["pitch_time"][1]);
			var_03.max_pitch_time = max(param_02["pitch_time"][0],param_02["pitch_time"][1]);
		}

		if(isdefined(param_02["cone"]))
		{
			var_03.min_start_angle = min(param_02["cone"][0],param_02["cone"][1]);
			var_03.max_start_angle = max(param_02["cone"][0],param_02["cone"][1]);
		}
	}
	else
	{
		var_03.using_oneshots_or_loops = 0;
	}

	var_03.using_entity = 0;
	if(isdefined(level._audio.damb.playing[param_00][param_01]["entity"]))
	{
		var_03.using_entity = 1;
		var_03.ent = level._audio.damb.playing[param_00][param_01]["entity"];
		var_03.mode = level._audio.damb.playing[param_00][param_01]["mode"];
	}

	var_03.prob_scale = level._audio.damb.playing[param_00][param_01]["prob_scale"];
	return var_03;
}

//Function Number: 28
dambx_monitor_single_loops_on_ent(param_00,param_01,param_02)
{
	for(;;)
	{
		if(!isdefined(param_02))
		{
			level notify(param_00 + "_" + param_01 + "_stop");
		}

		wait(1);
	}
}

//Function Number: 29
dambx_create_damb_event(param_00,param_01,param_02,param_03)
{
	var_04 = spawnstruct();
	if(randomfloat(1) < param_00.prob_scale)
	{
		var_04.success = 1;
		if(isdefined(level._audio.damb.callbacks[param_01]))
		{
			thread [[ level._audio.damb.callback[param_01] ]]();
		}
		else
		{
			var_04.alias = dambx_pick_random_alias(param_02);
			var_04.point = param_03;
			var_04.ent = param_00.ent;
			var_04.mode = param_00.mode;
			var_05 = randomfloatrange(param_00.min_radius,param_00.max_radius);
			var_06 = undefined;
			if(isdefined(param_00.min_start_angle))
			{
				var_06 = randomfloatrange(param_00.min_start_angle,param_00.max_start_angle);
			}
			else
			{
				var_06 = randomfloatrange(0,360);
			}

			var_07 = var_05 * cos(var_06);
			var_08 = var_05 * sin(var_06);
			var_04.start_position = (var_07,var_08,0);
			if(isdefined(param_00.min_trav_time))
			{
				var_04.travel_time = randomfloatrange(param_00.min_trav_time,param_00.max_trav_time);
				if(isdefined(param_00.min_delta))
				{
					var_05 = randomfloatrange(param_00.min_delta,param_00.max_delta);
					var_06 = randomfloatrange(0,360);
					var_07 = var_05 * cos(var_06);
					var_08 = var_05 * sin(var_06);
					var_04.end_position = var_04.start_position + (var_07,var_08,0);
				}
				else
				{
					var_09 = randomfloatrange(param_00.min_delta_angle,param_00.max_delta_angle);
					var_09 = var_09 * 0.5;
					var_0A = level.player.origin;
					if(isdefined(param_03))
					{
						var_0A = param_03;
					}

					var_0B = var_04.start_position - var_0A;
					var_07 = var_0B[0] * cos(var_09) - var_0B[1] * sin(var_09);
					var_08 = var_0B[0] * sin(var_09) + var_0B[1] * cos(var_09);
					var_04.end_position = var_04.start_position + (var_07,var_08,0);
				}
			}

			if(isdefined(param_00.min_pitch))
			{
				var_04.start_pitch = randomfloatrange(param_00.min_pitch,param_00.max_pitch);
			}

			if(isdefined(param_00.min_pitch_time))
			{
				var_04.end_pitch = randomfloatrange(param_00.min_pitch,param_00.max_pitch);
				var_04.pitch_time = randomfloatrange(param_00.min_pitch_time,param_00.max_pitch_time);
			}
		}
	}
	else
	{
		var_04.success = 0;
	}

	return var_04;
}

//Function Number: 30
dambx_trigger_linked_damb(param_00,param_01)
{
	wait(param_01);
	damb_manual_trigger(param_00);
}

//Function Number: 31
dambx_make_first_wait(param_00)
{
	var_01 = undefined;
	if(isdefined(param_00.first_event))
	{
		var_01 = randomfloatrange(param_00.first_event_min,param_00.first_event_max);
	}
	else
	{
		var_01 = randomfloatrange(param_00.min_time,param_00.max_time);
	}

	return var_01;
}

//Function Number: 32
dambx_update(param_00,param_01,param_02,param_03)
{
	level endon(param_00 + "_" + param_01 + "_stop");
	var_04 = dambx_get_component_data(param_00,param_01,param_02,param_01);
	if(var_04.single_loops)
	{
		dambx_play_component_loops(param_00,param_01,param_02,param_03,var_04.ent);
		if(var_04.using_entity && !var_04.using_oneshots_or_loops)
		{
			thread dambx_monitor_single_loops_on_ent(param_00,param_01,var_04.ent);
		}
	}

	if(var_04.using_oneshots_or_loops)
	{
		var_05 = dambx_make_first_wait(var_04);
		for(;;)
		{
			if(!level._audio.damb.playing[param_00][param_01]["paused"])
			{
				wait(var_05);
			}

			if(level._audio.damb.playing[param_00][param_01]["paused"])
			{
				level waittill(param_00 + "_" + param_01 + "_event");
			}

			if(var_04.using_entity && !isdefined(var_04.ent))
			{
				level notify(param_00 + "_" + param_01 + "_stop");
				break;
			}

			if(isdefined(level._audio.damb.playing[param_00][param_01]["linked_dambs"]))
			{
				foreach(var_07 in level._audio.damb.playing[param_00][param_01]["linked_dambs"])
				{
					var_08 = randomfloatrange(var_07.min_delay,var_07.max_delay);
					thread dambx_trigger_linked_damb(var_07.name,var_08);
				}
			}

			var_04.prob_scale = level._audio.damb.playing[param_00][param_01]["prob_scale"];
			var_0A = dambx_create_damb_event(var_04,param_01,param_02,param_03);
			if(var_0A.success)
			{
				thread dambx_perform_play_event(param_00,param_01,var_0A);
			}

			var_05 = randomfloatrange(var_04.min_time,var_04.max_time);
		}
	}
}

//Function Number: 33
dambx_wait_till_sound_done_and_remove_handle(param_00,param_01,param_02,param_03)
{
	level endon(param_00 + "_" + param_01 + "_stop");
	param_03 waittill("sounddone");
	if(isdefined(level._audio.damb.playing[param_00][param_01]["oneshots"][param_02]))
	{
		param_03 delete();
		decrement_ref_count();
		level._audio.damb.playing[param_00][param_01]["oneshots"][param_02] = undefined;
	}
}

//Function Number: 34
dambx_perform_play_event(param_00,param_01,param_02)
{
	level endon(param_00 + "_" + param_01 + "_stop");
	if(param_02.alias["type"] == "loop")
	{
		dambx_perform_loop_event(param_00,param_01,param_02);
		return;
	}

	dambx_perform_oneshot_event(param_00,param_01,param_02);
}

//Function Number: 35
dambx_perform_oneshot_event(param_00,param_01,param_02)
{
	level endon(param_00 + "_" + param_01 + "_stop");
	var_03 = level.player.origin;
	if(isdefined(param_02.ent))
	{
		var_03 = param_02.ent.origin;
	}
	else if(isdefined(param_02.point))
	{
		var_03 = param_02.point;
	}

	if(level._audio.damb.entity_ref_count < level._audio.damb.max_entities)
	{
		var_04 = spawn("script_origin",var_03 + param_02.start_position);
		if(isdefined(param_02.ent) && param_02.mode == "attach")
		{
			var_04 linkto(param_02.ent);
		}

		var_04 playsound(param_02.alias["name"],"sounddone");
		var_04 thread soundscripts\_audio::aud_check_sound_done();
		if(!var_04.sounddone)
		{
			var_05 = level._audio.damb.oneshot_handle_index;
			level._audio.damb.playing[param_00][param_01]["oneshots"][var_05] = var_04;
			level._audio.damb.oneshot_handle_index++;
			increment_ref_count();
			if(isdefined(param_02.end_position) && !isdefined(param_02.entity))
			{
				var_06 = 0.1 * param_02.travel_time;
				var_04 moveto(var_03 + param_02.end_position,param_02.travel_time,var_06,var_06);
			}

			if(isdefined(param_02.start_pitch))
			{
				var_04 scalepitch(param_02.start_pitch);
			}

			if(isdefined(param_02.pitch_time))
			{
				wait(0.05);
				if(isdefined(var_04) && !var_04.sounddone)
				{
					var_04 scalepitch(param_02.end_pitch,param_02.pitch_time);
				}
			}

			thread dambx_wait_till_sound_done_and_remove_handle(param_00,param_01,var_05,var_04);
			var_04 waittill("sounddone");
			return;
		}

		var_04 delete();
		return;
	}

	soundscripts\_audio::aud_print_warning("TRYING TO PLAY ONESHOT WITH DAMB REF COUNT AT MAXIMUM!");
}

//Function Number: 36
dambx_perform_loop_event(param_00,param_01,param_02)
{
	level endon(param_00 + "_" + param_01 + "_stop");
	if(level._audio.damb.entity_ref_count < level._audio.damb.max_entities)
	{
		var_03 = level.player.origin;
		if(isdefined(param_02.ent))
		{
			var_03 = param_02.ent.origin;
		}
		else if(isdefined(param_02.point))
		{
			var_03 = param_02.point;
		}

		var_04 = param_02.alias["name"];
		var_05 = dambx_get_loop_preset(var_04);
		if(!isdefined(var_05))
		{
			return;
		}

		var_06 = min(var_05["duration"][0],var_05["duration"][1]);
		var_07 = max(var_05["duration"][0],var_05["duration"][1]);
		var_08 = randomfloatrange(var_06,var_07);
		var_09 = var_05["loop_alias"];
		var_0A = var_05["fade_in"];
		var_0B = var_05["fade_out"];
		var_0C = undefined;
		if(isdefined(var_05["end_alias"]))
		{
			var_0C = var_05["end_alias"];
		}

		var_0D = spawn("script_origin",var_03 + param_02.start_position);
		if(isdefined(param_02.ent) && param_02.mode == "attach")
		{
			var_0D linkto(param_02.ent);
		}

		var_0D playloopsound(var_09);
		if(isdefined(var_0A))
		{
			var_0D scalevolume(0);
			wait(0.05);
			var_0D scalevolume(1,var_0A);
		}

		var_0D thread soundscripts\_audio::aud_check_sound_done();
		if(!var_0D.sounddone)
		{
			var_0E = level._audio.damb.loop_handle_index;
			level._audio.damb.playing[param_00][param_01]["loops"][var_0E] = var_0D;
			increment_ref_count();
			level._audio.damb.loop_handle_index++;
			var_0F = 0;
			if(isdefined(param_02.mode) && param_02.mode == "free" && isdefined(param_02.end_position))
			{
				var_0F = 1;
			}
			else if(!isdefined(param_02.mode) && isdefined(param_02.end_position))
			{
				var_0F = 1;
			}

			if(var_0F)
			{
				var_10 = 0.1 * param_02.travel_time;
				var_0D moveto(var_03 + param_02.end_position,param_02.travel_time,var_10,var_10);
			}

			if(isdefined(param_02.start_pitch))
			{
				var_0D setpitch(param_02.start_pitch);
			}

			if(isdefined(param_02.pitch_time))
			{
				wait(0.05);
				if(isdefined(var_0D) && !var_0D.sounddone)
				{
					var_0D setpitch(param_02.end_pitch,param_02.pitch_time);
				}
			}

			wait(var_08);
			if(!var_0D.sounddone)
			{
				if(isdefined(level._audio.damb.playing[param_00][param_01]["loops"][var_0E]))
				{
					if(isdefined(var_0C))
					{
						var_11 = spawn("script_origin",var_0D.origin);
						var_11 playsound(var_0C,"sounddone");
						var_12 = level._audio.damb.oneshot_handle_index;
						level._audio.damb.oneshot_handle_index++;
						level._audio.damb.playing[param_00][param_01]["oneshots"][var_12] = var_11;
						increment_ref_count();
						thread dambx_wait_till_sound_done_and_remove_handle(param_00,param_01,var_12,var_11);
					}

					if(isdefined(var_0B))
					{
						thread soundscripts\_audio::aud_fade_loop_out_and_delete(var_0D,var_0B);
					}
					else
					{
						var_0D stoploopsound();
						wait(0.05);
						var_0D delete();
					}

					decrement_ref_count();
					level._audio.damb.playing[param_00][param_01]["loops"][var_0E] = undefined;
					return;
				}

				return;
			}

			var_0D stoploopsound();
			var_0D delete();
			decrement_ref_count();
			level._audio.damb.playing[param_00][param_01]["loops"][var_0E] = undefined;
			return;
		}

		var_0D delete();
		return;
	}

	soundscripts\_audio::aud_print_warning("TRYING TO PLAY LOOP WITH DAMB REF COUNT AT MAXIMUM!");
}

//Function Number: 37
dambx_pick_random_component(param_00,param_01)
{
	var_02 = 0;
	foreach(var_04 in level._audio.damb.playing[param_00][param_01]["components"])
	{
		var_05 = var_04[1];
		var_02 = var_02 + var_05;
	}

	var_07 = randomfloat(var_02);
	var_08 = 0;
	var_09 = undefined;
	foreach(var_04 in level._audio.damb.playing[param_00][param_01]["components"])
	{
		var_0B = var_08 + var_04[1];
		if(var_07 >= var_08 && var_07 < var_0B)
		{
			var_09 = var_04[0];
			break;
		}

		var_08 = var_0B;
	}

	var_0D = dambx_get_component_preset(var_09);
	if(!isdefined(var_0D))
	{
		return;
	}

	var_0D["name"] = var_09;
	return var_0D;
}

//Function Number: 38
dambx_pick_random_alias(param_00)
{
	var_01 = param_00["loops"];
	var_02 = param_00["oneshots"];
	var_03 = undefined;
	if(!isdefined(level._audio.damb.component_weights[param_00["name"]]))
	{
		var_03 = 0;
		if(isdefined(var_01))
		{
			if(isstring(var_01[0]))
			{
				var_03 = var_03 + var_01[1];
			}
			else
			{
				foreach(var_05 in var_01)
				{
					var_03 = var_03 + var_05[1];
				}
			}
		}

		if(isdefined(var_02))
		{
			if(isstring(var_02[0]))
			{
				var_03 = var_03 + var_02[1];
			}
			else
			{
				foreach(var_05 in var_02)
				{
					var_03 = var_03 + var_05[1];
				}
			}
		}

		level._audio.damb.component_weights[param_00["name"]] = var_03;
	}
	else
	{
		var_03 = level._audio.damb.component_weights[param_00["name"]];
	}

	var_09 = randomfloatrange(0,var_03);
	var_0A = undefined;
	var_0B = undefined;
	var_0C = 0;
	if(isdefined(var_01))
	{
		if(isstring(var_01[0]))
		{
			var_0D = var_0C + var_01[1];
			if(var_09 >= var_0C && var_09 < var_0D)
			{
				var_0A = var_01[0];
				var_0B = "loop";
			}
			else
			{
				var_0C = var_0D;
			}
		}
		else
		{
			foreach(var_05 in var_02)
			{
				var_0D = var_0C + var_05[1];
				if(var_09 >= var_0C && var_09 < var_0D)
				{
					var_0A = var_05[0];
					var_0B = "loop";
					break;
				}
				else
				{
					var_0C = var_0D;
				}
			}
		}
	}

	if(!isdefined(var_0A) && isdefined(var_02))
	{
		if(isarray(var_02))
		{
			foreach(var_05 in var_02)
			{
				var_0D = var_0C + var_05[1];
				if(var_09 >= var_0C && var_09 < var_0D)
				{
					var_0A = var_05[0];
					var_0B = "oneshot";
					break;
				}
				else
				{
					var_0C = var_0D;
				}
			}
		}
		else
		{
			var_0D = var_0D + var_03[1];
			if(var_09 >= var_0C && var_09 < var_0D)
			{
				var_0A = var_02[0];
				var_0B = "oneshot";
			}
			else
			{
				var_0C = var_0D;
			}
		}
	}

	var_12 = [];
	var_12["name"] = var_0A;
	var_12["type"] = var_0B;
	return var_12;
}

//Function Number: 39
dambx_get_loop_preset(param_00)
{
	var_01 = [];
	if(isdefined(level._audio.damb.loop_cache[param_00]))
	{
		var_01 = level._audio.damb.loop_cache[param_00];
	}
	else
	{
		var_01 = dambx_get_loop_def_from_string_table(param_00,1);
	}

	if(!isdefined(var_01) || var_01.size == 0)
	{
		return;
	}

	level._audio.damb.loop_cache[param_00] = var_01;
	return var_01;
}

//Function Number: 40
dambx_get_component_preset(param_00)
{
	if(!isdefined(level._audio.damb.component_cache))
	{
		level._audio.damb.component_cache = [];
	}

	var_01 = [];
	if(isdefined(level._audio.damb.component_cache[param_00]))
	{
		var_01 = level._audio.damb.component_cache[param_00];
	}

	var_01 = dambx_get_component_from_string_table(param_00,1);
	if(!isdefined(var_01) || var_01.size == 0)
	{
		return;
	}

	level._audio.damb.component_cache[param_00] = var_01;
	return var_01;
}

//Function Number: 41
dambx_play(param_00,param_01,param_02)
{
	level._audio.damb.playing[param_00][param_01]["loops"] = [];
	level._audio.damb.playing[param_00][param_01]["single_loops"] = [];
	level._audio.damb.playing[param_00][param_01]["oneshots"] = [];
	if(!isdefined(level._audio.damb.playing[param_00][param_01]["event_time"]))
	{
		foreach(var_04 in level._audio.damb.playing[param_00][param_01]["components"])
		{
			var_05 = dambx_get_component_preset(var_04);
			if(!isdefined(var_05))
			{
				return;
			}

			var_05["name"] = var_04;
			thread dambx_update(param_00,param_01,var_05,param_02);
		}
	}
	else
	{
		thread dambx_update_serially(param_00,param_01,param_02);
	}

	level waittill(param_00 + "_" + param_01 + "_stop");
	wait(0.1);
	foreach(var_08 in level._audio.damb.playing[param_00][param_01]["loops"])
	{
		thread dambx_fade_out_playing_loop(var_08,level._audio.damb.playing[param_00][param_01]["fade"],0);
	}

	foreach(var_08 in level._audio.damb.playing[param_00][param_01]["single_loops"])
	{
		thread dambx_fade_out_playing_loop(var_08,level._audio.damb.playing[param_00][param_01]["fade"],1);
	}

	foreach(var_08 in level._audio.damb.playing[param_00][param_01]["oneshots"])
	{
		thread dambx_fade_out_playing_sound(var_08,level._audio.damb.playing[param_00][param_01]["fade"]);
	}

	level._audio.damb.playing[param_00][param_01] = undefined;
}

//Function Number: 42
dambx_fade_out_playing_sound(param_00,param_01)
{
	if(isdefined(param_00))
	{
		param_00 scalevolume(0,param_01);
		wait(param_01);
		param_00 stopsounds();
		wait(0.05);
		param_00 delete();
		decrement_ref_count();
	}
}

//Function Number: 43
dambx_fade_out_playing_loop(param_00,param_01,param_02)
{
	param_00 scalevolume(0,param_01);
	wait(param_01);
	if(isdefined(param_00))
	{
		param_00 stoploopsound();
		wait(0.05);
		param_00 delete();
	}

	if(param_02)
	{
		level._audio.damb.loop_entity_ref_count--;
		return;
	}

	decrement_ref_count();
}

//Function Number: 44
dambx_get_list_value_from_string_table(param_00,param_01,param_02,param_03)
{
	var_04 = 0;
	if(isdefined(param_03))
	{
		var_04 = param_03;
	}

	var_05 = [];
	var_06 = 0;
	var_07 = strtok(param_00,"+");
	var_08 = 0;
	for(var_09 = 0;var_09 < var_07.size;var_09++)
	{
		var_0A = strtok(var_07[var_09]," ");
		if(var_0A.size == 1 && var_0A[0] != "")
		{
			var_05[var_05.size] = var_0A[0];
			continue;
		}

		var_0B = var_05.size;
		var_05[var_0B] = [];
		var_05[var_0B][0] = var_0A[0];
		var_05[var_0B][1] = float(var_0A[1]);
	}

	if(!var_06 && var_04)
	{
		var_0C = [];
		for(var_09 = 0;var_09 < var_05.size;var_09++)
		{
			var_0D = var_0C.size;
			var_0C[var_0D] = [];
			var_0C[var_0D][0] = var_05[var_09];
			var_0C[var_0D][1] = 1;
		}

		var_05 = var_0C;
	}

	return var_05;
}

//Function Number: 45
dambx_get_loop_def_from_string_table(param_00,param_01)
{
	var_02 = "soundtables/sp_defaults.csv";
	var_03 = soundscripts\_audio::get_damb_loops_stringtable();
	var_04 = [];
	if(param_01)
	{
		var_04 = dambx_get_loop_def_from_string_table_internal(var_03,param_00);
	}

	if(!isdefined(var_04) || var_04.size == 0)
	{
		var_04 = dambx_get_loop_def_from_string_table_internal(var_02,param_00);
	}

	if(!isdefined(var_04) || var_04.size == 0)
	{
		return;
	}

	return var_04;
}

//Function Number: 46
dambx_get_loop_def_from_string_table_internal(param_00,param_01)
{
	var_02 = [];
	var_03 = 8;
	var_04 = undefined;
	var_05 = undefined;
	var_06 = undefined;
	var_07 = undefined;
	var_08 = [];
	var_09 = packedtablesectionlookup(param_00,"loop_defs","zone_names;reverb_names;filter_names;occlusion_names;timescale_names;dynamic_ambience_names;components;loop_defs;whizby_preset_names;mix_names;healthfx_params");
	if(isdefined(var_09))
	{
		var_0A = 0;
		if(var_0A < var_03)
		{
			var_0B = packedtablelookupwithrange(param_00,0,"loop_defs",var_0A,var_09[0],var_09[1]);
			if(!isdefined(var_0B) || var_0B == "")
			{
				return;
			}

			var_0C = packedtablelookupwithrange(param_00,0,param_01,var_0A,var_09[0],var_09[1]);
			if(var_0C != "" && var_0B != "comments")
			{
				switch(var_0B)
				{
					case "loop_alias":
						break;

					case "fade_in":
						break;

					case "fade_out":
						break;

					case "end_alias":
						break;

					case "duration_min":
						break;

					case "duration_max":
						break;

					default:
						break;
				}
			}
		}
	}
}

//Function Number: 47
dambx_get_two_value_float_array(param_00)
{
	var_01 = [];
	var_01[0] = float(param_00[0]);
	var_01[1] = float(param_00[1]);
	return var_01;
}

//Function Number: 48
dambx_get_component_from_string_table_internal(param_00,param_01)
{
	var_02 = [];
	var_03 = 21;
	var_04 = 8;
	var_05 = [];
	var_06 = [];
	var_07 = [];
	var_08 = [];
	var_09 = [];
	var_0A = [];
	var_0B = [];
	var_0C = [];
	var_0D = [];
	var_0E = [];
	var_0F = [];
	var_10 = 0;
	var_11 = packedtablesectionlookup(param_00,"components","zone_names;reverb_names;filter_names;occlusion_names;timescale_names;dynamic_ambience_names;components;loop_defs;whizby_preset_names;mix_names;healthfx_params");
	if(isdefined(var_11))
	{
		var_12 = 1;
		if(var_12 < var_03)
		{
			var_13 = packedtablelookupwithrange(param_00,0,"components",var_12,var_11[0],var_11[1]);
			if(!isdefined(var_13))
			{
				return;
			}

			var_14 = packedtablelookupwithrange(param_00,0,param_01,var_12,var_11[0],var_11[1]);
			if(var_14 != "" && var_13 != "comments")
			{
				var_10++;
				switch(var_13)
				{
					case "oneshots":
						break;

					case "loops":
						break;

					case "single_loops":
						break;

					case "first_event_min":
						break;

					case "first_event_max":
						break;

					case "event_time_min":
						break;

					case "event_time_max":
						break;

					case "dist_min":
						break;

					case "dist_max":
						break;

					case "cone_min":
						break;

					case "cone_max":
						break;

					case "travel_min":
						break;

					case "travel_max":
						break;

					case "travel_time_min":
						break;

					case "travel_time_max":
						break;

					case "pitch_min":
						break;

					case "pitch_max":
						break;

					case "pitch_time_min":
						break;

					case "pitch_time_max":
						break;

					default:
						break;
				}
			}
		}
	}
}

//Function Number: 49
dambx_get_component_from_string_table(param_00,param_01)
{
	var_02 = soundscripts\_audio::get_damb_component_stringtable();
	var_03 = "soundtables/sp_defaults.csv";
	var_04 = [];
	if(param_01)
	{
		var_04 = dambx_get_component_from_string_table_internal(var_02,param_00);
	}

	if(!isdefined(var_04) || var_04.size == 0)
	{
		var_04 = dambx_get_component_from_string_table_internal(var_03,param_00);
	}

	if(!isdefined(var_04) || var_04.size == 0)
	{
		return;
	}

	return var_04;
}

//Function Number: 50
dambx_get_preset_from_stringtable_internal(param_00,param_01)
{
	var_02 = 7;
	var_03 = [];
	var_04 = [];
	var_05 = [];
	var_06 = [];
	var_07 = packedtablesectionlookup(param_00,"dynamic_ambience_names","zone_names;reverb_names;filter_names;occlusion_names;timescale_names;dynamic_ambience_names;components;loop_defs;whizby_preset_names;mix_names;healthfx_params");
	if(isdefined(var_07))
	{
		var_08 = 1;
		if(var_08 < var_02)
		{
			var_09 = packedtablelookupwithrange(param_00,0,"dynamic_ambience_names",var_08,var_07[0],var_07[1]);
			var_0A = packedtablelookupwithrange(param_00,0,param_01,var_08,var_07[0],var_07[1]);
			var_0B = 0;
			if(var_0A != "" && var_09 != "comments")
			{
				switch(var_09)
				{
					case "components":
						break;

					case "first_event_min":
						break;

					case "first_event_max":
						break;

					case "event_time_min":
						break;

					case "event_time_max":
						break;

					case "comment":
						break;

					default:
						break;
				}
			}
		}
	}
}

//Function Number: 51
dambx_get_preset_from_string_table(param_00,param_01)
{
	var_02 = soundscripts\_audio::get_damb_stringtable();
	var_03 = "soundtables/sp_defaults.csv";
	var_04 = [];
	if(param_01)
	{
		var_04 = dambx_get_preset_from_stringtable_internal(var_02,param_00);
	}

	if(!isdefined(var_04) || var_04.size == 0)
	{
		var_04 = dambx_get_preset_from_stringtable_internal(var_03,param_00);
	}

	if(!isdefined(var_04) || var_04.size == 0)
	{
		return;
	}

	return var_04;
}

//Function Number: 52
dambx_get_damb_preset(param_00)
{
	var_01 = [];
	if(isdefined(level._audio.damb.preset_cache[param_00]))
	{
		var_01 = level._audio.damb.preset_cache[param_00];
	}
	else
	{
		var_01 = dambx_get_preset_from_string_table(param_00,1);
	}

	if(!isdefined(var_01) || var_01.size == 0)
	{
		return;
	}

	level._audio.damb.preset_cache[param_00] = var_01;
	var_01["name"] = param_00;
	return var_01;
}

//Function Number: 53
increment_ref_count()
{
	level._audio.damb.entity_ref_count++;
}

//Function Number: 54
decrement_ref_count()
{
	level._audio.damb.entity_ref_count--;
}