/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\_audio_mix_manager.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: Console
 * Function Count: 62
 * Decompile Time: 1056 ms
 * Timestamp: 10/27/2023 2:33:08 AM
*******************************************************************/

//Function Number: 1
mm_init()
{
	if(!isdefined(level._audio))
	{
		level._audio = spawnstruct();
	}

	if(!isdefined(level._audio.mix))
	{
		level._audio.mix = spawnstruct();
	}

	mmx_init_volmods();
	level._audio.mix.use_string_table_presets = 0;
	level._audio.mix.use_iw_presets = 0;
	level._audio.mix.var_10C6 = 0;
	level._audio.mix.debug_mix_mode = 0;
	var_00 = 10;
	thread mmx_mix_server_throttler(var_00);
	thread mmx_volmod_server_throttler(var_00);
	level._audio.mix.var_10C8 = "";
	level._audio.mix.var_10C9 = "";
	level._audio.mix.sticky_submixes = [];
	if(!isdefined(level._audio.volmod_submixes))
	{
		level._audio.volmod_submixes = [];
	}

	level._audio.mix.volmod_submixblends = [];
	level._audio.mix.preset_cache = [];
	level._audio.mix.changed_presets = [];
	level._audio.mix.headroom = 0.85;
	level._audio.mix.blend_value = 0;
	level._audio.mix.blend_name = "";
	thread func_1106();
	waittillframeend;
	thread mmx_apply_initial_mix();
}

//Function Number: 2
mm_precache_preset(param_00)
{
	func_111E(param_00);
}

//Function Number: 3
mm_set_headroom_mix(param_00,param_01,param_02)
{
	if(!level._audio.mix.debug_mix_mode)
	{
		var_03 = 1;
		if(isdefined(param_02))
		{
			var_03 = param_02;
		}

		level._audio.mix.headroom = param_01;
		var_04 = func_111E(param_00);
		if(isdefined(var_04))
		{
			level._audio.mix.headroom_preset = var_04;
			mmx_update_mix(var_03,param_00);
		}
	}
}

//Function Number: 4
func_10D4()
{
	level._audio.mix.debug_mix_mode = 1;
}

//Function Number: 5
mm_disable_debug_mode()
{
	level._audio.mix.debug_mix_mode = 0;
}

//Function Number: 6
mm_use_string_table()
{
	level._audio.mix.use_string_table_presets = 1;
	level._audio.mix.use_iw_presets = 0;
}

//Function Number: 7
mm_start_preset(param_00,param_01)
{
	if(!level._audio.mix.debug_mix_mode && !level._audio.mix.var_10C6)
	{
		if(param_00 != level._audio.mix.var_10C8)
		{
			mmx_clear_submixes(0);
			mmx_set_mix(param_00,param_01);
		}
	}
}

//Function Number: 8
mm_start_zone_preset(param_00)
{
	if(!level._audio.mix.debug_mix_mode && !level._audio.mix.var_10C6)
	{
		var_01 = func_111E(param_00);
		if(!isdefined(var_01))
		{
			return;
		}

		if(isdefined(level._audio.mix.volmod_submixes["zone_mix"]))
		{
			foreach(var_04, var_03 in level._audio.mix.volmod_submixes["zone_mix"])
			{
				if(var_04 != "fade_time" && var_04 != "preset_name")
				{
					level._audio.mix.volmod_submixes["zone_mix"][var_04].current_volume = 1;
				}
			}
		}
		else
		{
			level._audio.mix.volmod_submixes["zone_mix"] = [];
		}

		level._audio.mix.volmod_submixes["zone_mix"]["preset_name"] = param_00;
		foreach(var_04, var_03 in var_01)
		{
			if(var_04 != "fade_time" && var_04 != "name")
			{
				level._audio.mix.volmod_submixes["zone_mix"][var_04] = spawnstruct();
				level._audio.mix.volmod_submixes["zone_mix"][var_04].current_volume = var_03;
				level._audio.mix.volmod_submixes["zone_mix"][var_04].var_10DA = var_03;
			}
		}

		var_06 = 1;
		if(isdefined(var_01["fade_time"]))
		{
			var_06 = var_01["fade_time"];
		}

		mmx_update_mix(var_06,"zone_mix");
	}
}

//Function Number: 9
func_10DB(param_00)
{
	var_01 = 1;
	if(isdefined(param_00))
	{
		var_01 = param_00;
	}

	if(isdefined(level._audio.mix.volmod_submixes["zone_mix"]))
	{
		level._audio.mix.volmod_submixes["zone_mix"]["CLEAR"] = 1;
		mmx_update_mix(var_01,"zone_mix");
	}
}

//Function Number: 10
mm_clear_submixes(param_00)
{
	mmx_clear_submixes(1,param_00);
}

//Function Number: 11
mm_make_submix_sticky(param_00)
{
	level._audio.mix.sticky_submixes[param_00] = 1;
}

//Function Number: 12
mm_make_submix_unsticky(param_00)
{
	level._audio.mix.sticky_submixes[param_00] = undefined;
}

//Function Number: 13
mm_add_submix(param_00,param_01,param_02)
{
	if(!level._audio.mix.debug_mix_mode && !level._audio.mix.var_10C6)
	{
		mmx_set_mix(param_00,param_01,param_02);
	}
}

//Function Number: 14
mm_add_submix_blend_to(param_00,param_01,param_02,param_03)
{
	if(!isdefined(level._audio.mix.volmod_submixblends[param_01]))
	{
		var_04 = mmx_create_submix_blend(undefined,param_00,param_02);
		if(!isdefined(var_04))
		{
			return;
		}

		level._audio.mix.volmod_submixblends[param_01] = var_04;
		mmx_update_mix(param_03,param_00);
	}
}

//Function Number: 15
mm_add_submix_blend(param_00,param_01,param_02,param_03,param_04)
{
	if(!isdefined(level._audio.mix.volmod_submixblends[param_02]))
	{
		var_05 = mmx_create_submix_blend(param_00,param_01,param_03);
		if(!isdefined(var_05))
		{
			return;
		}

		level._audio.mix.volmod_submixblends[param_02] = var_05;
		mmx_update_mix(param_04,param_02);
	}
}

//Function Number: 16
mm_set_submix_blend_value(param_00,param_01,param_02)
{
	if(isdefined(level._audio.mix.volmod_submixblends[param_00]))
	{
		level._audio.mix.volmod_submixblends[param_00].var_10E3 = clamp(param_01,0,1);
		mmx_update_mix(param_02,param_00);
	}
}

//Function Number: 17
func_10E4(param_00,param_01)
{
	if(isdefined(level._audio.mix.volmod_submixblends[param_00]))
	{
		level._audio.mix.volmod_submixblends[param_00].clear = 1;
		mmx_update_mix(param_01,param_00);
	}
}

//Function Number: 18
mm_scale_submix(param_00,param_01,param_02)
{
	if(!level._audio.mix.debug_mix_mode && !level._audio.mix.var_10C6)
	{
		if(isdefined(level._audio.mix.volmod_submixes[param_00]))
		{
			func_10FE(param_00,param_01);
		}
		else
		{
			func_10FF(param_00,param_01);
		}

		mmx_update_mix(param_02,param_00);
	}
}

//Function Number: 19
func_10E7(param_00,param_01)
{
	if(!level._audio.mix.debug_mix_mode && !level._audio.mix.var_10C6)
	{
		if(isdefined(level._audio.mix.volmod_submixes[param_00]))
		{
			level._audio.mix.volmod_submixes[param_00].current_volume = level._audio.mix.volmod_submixes[param_00].var_10DA;
			mmx_update_mix(param_01,param_00);
		}
	}
}

//Function Number: 20
mm_clear_submix(param_00,param_01)
{
	if(!level._audio.mix.debug_mix_mode && !level._audio.mix.var_10C6)
	{
		if(param_00 == "default")
		{
			return;
		}

		if(!isdefined(level._audio.mix.sticky_submixes[param_00]) && isdefined(level._audio.mix.volmod_submixes[param_00]))
		{
			level._audio.mix.volmod_submixes[param_00]["CLEAR"] = 1;
			mmx_update_mix(param_01,param_00);
		}
	}
}

//Function Number: 21
mm_get_applied_preset_name()
{
	return level._audio.mix.var_10C8;
}

//Function Number: 22
mm_add_dynamic_volmod_submix(param_00,param_01,param_02)
{
	if(!level._audio.mix.debug_mix_mode)
	{
		if(isdefined(level._audio.mix.volmod_submixes[param_00]))
		{
			return;
		}

		level._audio.mix.volmod_submixes[param_00] = [];
		var_03 = 0;
		var_04 = undefined;
		foreach(var_06 in param_01)
		{
			if(maps\_audio::aud_is_even(var_03))
			{
				var_04 = var_06;
			}
			else
			{
				if(!mmx_is_volmod_channel(var_04))
				{
					level._audio.mix.volmod_submixes[param_00] = undefined;
					return;
				}

				level._audio.mix.volmod_submixes[param_00][var_04] = spawnstruct();
				level._audio.mix.volmod_submixes[param_00][var_04].current_volume = var_06;
				level._audio.mix.volmod_submixes[param_00][var_04].var_10DA = var_06;
				var_04 = undefined;
			}

			var_03++;
		}

		mmx_update_mix(param_02,param_00);
	}
}

//Function Number: 23
mm_add_dynamic_submix(param_00,param_01,param_02)
{
	if(!level._audio.mix.debug_mix_mode)
	{
		level._audio.mix.volmod_submixes[param_00] = [];
		var_03 = 0;
		var_04 = undefined;
		foreach(var_06 in param_01)
		{
			if(maps\_audio::aud_is_even(var_03))
			{
				var_04 = var_06;
			}
			else
			{
				level._audio.mix.volmod_submixes[param_00][var_04] = spawnstruct();
				level._audio.mix.volmod_submixes[param_00][var_04].current_volume = var_06;
				level._audio.mix.volmod_submixes[param_00][var_04].var_10DA = var_06;
				var_04 = undefined;
			}

			var_03++;
		}

		mmx_update_mix(param_02,param_00);
	}
}

//Function Number: 24
mm_does_volmod_submix_exist(param_00)
{
	return isdefined(level._audio.mix.volmod_submixes[param_00]);
}

//Function Number: 25
mm_mute_volmods(param_00,param_01)
{
	if(!level._audio.mix.debug_mix_mode)
	{
		level._audio.mix.volmod_submixes["mm_mute"] = [];
		if(isstring(param_00))
		{
			if(!isdefined(level._audio.mix.volmod_submixes["mm_mute"][param_00]))
			{
				level._audio.mix.volmod_submixes["mm_mute"][param_00] = spawnstruct();
			}

			level._audio.mix.volmod_submixes["mm_mute"][param_00].current_volume = 0;
			level._audio.mix.volmod_submixes["mm_mute"][param_00].var_10DA = 1;
		}
		else
		{
			foreach(var_03 in param_00)
			{
				if(!isdefined(level._audio.mix.volmod_submixes["mm_mute"][var_03]))
				{
					level._audio.mix.volmod_submixes["mm_mute"][var_03] = spawnstruct();
				}

				level._audio.mix.volmod_submixes["mm_mute"][var_03].current_volume = 0;
				level._audio.mix.volmod_submixes["mm_mute"][var_03].var_10DA = 1;
			}
		}

		mmx_update_mix(param_01,"mm_mute");
	}
}

//Function Number: 26
mm_clear_volmod_mute_mix(param_00)
{
	if(isdefined(level._audio.volmod_submixes["mm_mute"]))
	{
		level._audio.volmod_submixes["mm_mute"] = undefined;
		mmx_update_mix(param_00,"mm_mute");
	}
}

//Function Number: 27
mm_solo_volmods(param_00,param_01)
{
	if(!level._audio.mix.debug_mix_mode)
	{
		level._audio.mix.volmod_submixes["mm_solo"] = [];
		foreach(var_04, var_03 in level._audio.mix.volmod_vals)
		{
			level._audio.mix.volmod_submixes["mm_solo"][var_04] = spawnstruct();
			level._audio.mix.volmod_submixes["mm_solo"][var_04].current_volume = 0;
			level._audio.mix.volmod_submixes["mm_solo"][var_04].var_10DA = 1;
		}

		if(isstring(param_00))
		{
			level._audio.mix.volmod_submixes["mm_solo"][param_00].current_volume = 1;
		}
		else
		{
			foreach(var_06 in param_00)
			{
				level._audio.mix.volmod_submixes["mm_solo"][var_06].current_volume = 1;
			}
		}

		mmx_update_mix(param_01,"mm_solo");
	}
}

//Function Number: 28
mm_clear_solo_volmods(param_00)
{
	if(isdefined(level._audio.mix.volmod_submixes["mm_solo"]))
	{
		level._audio.mix.volmod_submixes["mm_solo"] = undefined;
		mmx_update_mix(param_00,"mm_solo");
	}
}

//Function Number: 29
mm_get_channel_names()
{
	return level._audio.mix.channel_names;
}

//Function Number: 30
mm_get_num_volmod_submixes()
{
	return level._audio.mix.volmod_submixes.size;
}

//Function Number: 31
mm_get_num_submixes()
{
	return 0;
}

//Function Number: 32
func_10F7(param_00)
{
	var_01 = undefined;
	if(isdefined(level._audio.mix.volmod_submixes) && param_00 < level._audio.mix.volmod_submixes.size)
	{
		var_02 = 0;
		foreach(var_06, var_04 in level._audio.mix.volmod_submixes)
		{
			if(var_04.size > 0)
			{
				if(var_02 == param_00)
				{
					if(var_06 == "zone_mix")
					{
						var_05 = level._audio.mix.volmod_submixes["zone_mix"]["preset_name"];
						var_06 = "zone_mix : " + var_05;
					}

					var_01 = var_06;
					break;
				}

				var_02++;
			}
		}
	}

	return var_01;
}

//Function Number: 33
mm_get_volmod_submix_by_name(param_00)
{
	var_01 = undefined;
	if(getsubstr(param_00,0,8) == "zone_mix")
	{
		param_00 = "zone_mix";
	}

	if(isdefined(level._audio.mix.volmod_submixes) && isdefined(level._audio.mix.volmod_submixes[param_00]))
	{
		if(level._audio.mix.volmod_submixes[param_00].size > 0)
		{
			var_01 = level._audio.mix.volmod_submixes[param_00];
		}
	}

	return var_01;
}

//Function Number: 34
mm_set_default_volmod(param_00,param_01,param_02)
{
	param_01 = clamp(param_01,0,1);
	if(isdefined(level._audio.mix.volmod_submixes["default"]))
	{
		if(isdefined(level._audio.mix.volmod_submixes["default"][param_00]))
		{
			level._audio.mix.volmod_submixes["default"][param_00].current_volume = param_01;
			mmx_update_mix(param_02,"default");
			return;
		}

		maps\_audio::aud_print_error("Trying to set a volmod value on the default submix but the volmod doesn\'t exist: " + param_00);
		return;
	}

	maps\_audio::aud_print_error("Trying to set a volmod value on the default submix but \"default\" doesn\'t exist.");
}

//Function Number: 35
mm_get_original_default_volmod(param_00)
{
	var_01 = undefined;
	if(isdefined(level._audio.mix.volmod_submixes["default"]))
	{
		if(isdefined(level._audio.mix.volmod_submixes["default"][param_00]))
		{
			var_01 = level._audio.mix.volmod_submixes["default"][param_00].var_10DA;
		}
		else
		{
			maps\_audio::aud_print_error("Trying to set a volmod value on the default submix but the volmod doesn\'t exist: " + param_00);
		}
	}
	else
	{
		maps\_audio::aud_print_error("Trying to set a volmod value on the default submix but \"default\" doesn\'t exist.");
	}

	return var_01;
}

//Function Number: 36
mm_restore_original_default_volmod(param_00,param_01)
{
	var_02 = mm_get_original_default_volmod(param_00);
	if(isdefined(var_02))
	{
		mm_set_default_volmod(param_00,var_02,param_01);
	}
}

//Function Number: 37
mmx_set_mix(param_00,param_01,param_02)
{
	func_10FF(param_00,param_02);
	level._audio.mix.var_10C9 = level._audio.mix.var_10C8;
	level._audio.mix.var_10C8 = param_00;
	mmx_update_mix(param_01,param_00);
}

//Function Number: 38
func_10FE(param_00,param_01)
{
	if(isdefined(level._audio.mix.volmod_submixes[param_00]))
	{
		foreach(var_04, var_03 in level._audio.mix.volmod_submixes[param_00])
		{
			level._audio.mix.volmod_submixes[param_00][var_04].current_volume = var_03.var_10DA * param_01;
		}
	}
}

//Function Number: 39
func_10FF(param_00,param_01)
{
	if(param_00 == "default")
	{
		return;
	}

	if(!isdefined(level._audio.mix.volmod_submixes[param_00]))
	{
		var_02 = func_111E(param_00);
		if(!isdefined(var_02))
		{
			return;
		}

		var_03 = 1;
		if(isdefined(param_01))
		{
			var_03 = param_01;
			var_03 = max(var_03,0);
		}

		level._audio.mix.volmod_submixes[param_00] = [];
		foreach(var_06, var_05 in var_02)
		{
			if(var_06 != "name" && var_06 != "fade_time")
			{
				level._audio.mix.volmod_submixes[param_00][var_06] = spawnstruct();
				level._audio.mix.volmod_submixes[param_00][var_06].current_volume = var_05 * var_03;
				level._audio.mix.volmod_submixes[param_00][var_06].var_10DA = var_05;
			}
		}
	}
}

//Function Number: 40
mmx_create_submix_blend(param_00,param_01,param_02)
{
	var_03 = 0;
	if(isdefined(param_02))
	{
		var_03 = clamp(param_02,0,1);
	}

	var_04 = spawnstruct();
	var_05 = func_111E(param_01);
	if(!isdefined(var_05))
	{
		return;
	}

	var_04.presetb = var_05;
	var_04.presetb["fade_time"] = undefined;
	var_04.presetb["name"] = undefined;
	if(isdefined(param_00))
	{
		var_06 = func_111E(param_00);
		if(!isdefined(var_06))
		{
			return;
		}

		var_04.preseta = var_06;
		var_04.preseta["fade_time"] = undefined;
		var_04.preseta["name"] = undefined;
	}
	else
	{
		var_04.preseta = [];
		foreach(var_09, var_08 in var_04.presetb)
		{
			var_04.preseta[var_09] = 1;
		}
	}

	var_04.var_10E3 = var_03;
	return var_04;
}

//Function Number: 41
mmx_clear_submixes(param_00,param_01)
{
	var_02 = 1;
	if(isdefined(param_00))
	{
		var_02 = param_00;
	}

	foreach(var_05, var_04 in level._audio.mix.volmod_submixes)
	{
		if(var_05 != "default" && var_05 != "zone_mix" && !isdefined(level._audio.mix.sticky_submixes[var_05]) && var_05 != "mm_solo" && var_05 != "mm_mute")
		{
			level._audio.mix.volmod_submixes[var_05]["CLEAR"] = 1;
			level._audio.mix.changed_presets[var_05] = 1;
		}
	}

	if(var_02)
	{
		mmx_update_mix(param_01,undefined);
	}
}

//Function Number: 42
mmx_update_mix(param_00,param_01)
{
	level._audio.mix.last_fade_time = param_00;
	if(isdefined(param_01))
	{
		level._audio.mix.changed_presets[param_01] = 1;
	}

	level notify("mix_update");
}

//Function Number: 43
func_1106()
{
	level waittill("mix_update");
	for(;;)
	{
		waittillframeend;
		var_00 = 0;
		if(isdefined(level._audio.mix.last_fade_time))
		{
			var_00 = level._audio.mix.last_fade_time;
		}

		func_1109(var_00);
		level waittill("mix_update");
	}
}

//Function Number: 44
mmx_mix_in_non_changed_submixes()
{
	var_00 = [];
	foreach(var_03, var_02 in level._audio.mix.volmod_submixes)
	{
		if(!isdefined(level._audio.mix.changed_presets[var_03]))
		{
			var_00[var_03] = 1;
		}
	}

	foreach(var_08, var_05 in level._audio.mix.volume_products)
	{
		foreach(var_03, var_07 in var_00)
		{
			if(isdefined(level._audio.mix.volmod_submixes[var_03][var_08]))
			{
				level._audio.mix.volume_products[var_08] = level._audio.mix.volume_products[var_08] * level._audio.mix.volmod_submixes[var_03][var_08].current_volume;
			}
		}
	}
}

//Function Number: 45
func_1109(param_00)
{
	var_01 = 1;
	if(isdefined(param_00))
	{
		var_01 = param_00;
		var_01 = max(var_01,0);
	}

	level._audio.mix.volume_products = undefined;
	mmx_set_volume_products_volmods(0);
	mmx_mix_in_non_changed_submixes();
	var_02 = 0;
	foreach(var_05, var_04 in level._audio.mix.volume_products)
	{
		if(var_05 != "voiceover_critical" && var_05 != "fullvolume")
		{
			var_04 = var_04 * level._audio.mix.headroom;
		}

		if(var_04 != level._audio.mix.volmod_vals[var_05].volume)
		{
			var_02 = 1;
			level._audio.mix.volmod_vals[var_05].volume = var_04;
			level._audio.mix.volmod_vals[var_05].fade_time = var_01;
			mmx_volmod_setting_enqueue(var_05,var_04,var_01);
		}
	}

	level._audio.mix.changed_presets = [];
	if(var_02)
	{
		level notify("aud_new_volmod_set");
	}
}

//Function Number: 46
mmx_set_volume_products_volmods(param_00)
{
	level._audio.mix.volume_products = [];
	var_01 = [];
	foreach(var_10, var_03 in level._audio.mix.changed_presets)
	{
		if(isdefined(level._audio.mix.volmod_submixes[var_10]))
		{
			var_04 = level._audio.mix.volmod_submixes[var_10];
			var_04["name"] = undefined;
			var_04["fade_time"] = undefined;
			var_04["preset_name"] = undefined;
			var_05 = 0;
			if(isdefined(var_04["CLEAR"]))
			{
				var_05 = 1;
			}

			var_04["CLEAR"] = undefined;
			foreach(var_08, var_07 in var_04)
			{
				if(isdefined(level._audio.mix.volume_products[var_08]) && !var_05)
				{
					level._audio.mix.volume_products[var_08] = level._audio.mix.volume_products[var_08] * var_07.current_volume;
					continue;
				}

				if(var_05 && !isdefined(level._audio.mix.volume_products[var_08]))
				{
					level._audio.mix.volume_products[var_08] = 1;
					continue;
				}

				if(!var_05)
				{
					level._audio.mix.volume_products[var_08] = var_07.current_volume;
				}
			}

			if(var_05)
			{
				level._audio.mix.volmod_submixes[var_10] = undefined;
			}

			continue;
		}

		if(isdefined(level._audio.mix.volmod_submixblends[var_10]))
		{
			var_09 = level._audio.mix.volmod_submixblends[var_10];
			var_05 = 0;
			if(isdefined(var_09.clear))
			{
				var_05 = 1;
			}

			foreach(var_08, var_0B in var_09.preseta)
			{
				if(!isdefined(var_01[var_08]))
				{
					var_01[var_08] = 1;
				}

				if(!var_05)
				{
					var_0C = var_09.presetb[var_08];
					var_0D = var_09.preseta[var_08];
					var_0E = var_09.var_10E3;
					var_0F = var_0E * var_0C - var_0D + var_0D;
					var_01[var_08] = var_01[var_08] * var_0F;
				}
			}

			if(var_05)
			{
				level._audio.mix.volmod_submixblends[var_10] = undefined;
			}
		}
	}

	foreach(var_12, var_0B in var_01)
	{
		if(isdefined(level._audio.mix.volume_products[var_12]))
		{
			level._audio.mix.volume_products[var_12] = level._audio.mix.volume_products[var_12] * var_0B;
			continue;
		}

		level._audio.mix.volume_products[var_12] = var_0B;
	}
}

//Function Number: 47
mmx_apply_initial_mix()
{
	var_00 = undefined;
	var_01 = undefined;
}

//Function Number: 48
mmx_apply_debug_mix(param_00)
{
	if(level._audio.mix.debug_mix_mode)
	{
		while(!isdefined(level.player))
		{
			wait 0.05;
		}

		mmx_set_mix(param_00);
	}
}

//Function Number: 49
mmx_volmod_setting_enqueue(param_00,param_01,param_02)
{
	if(!isdefined(level._audio.mix.volmod_queue))
	{
		level._audio.mix.volmod_queue = [];
		level._audio.mix.volmod_index = 0;
	}

	var_03 = 0;
	foreach(var_06, var_05 in level._audio.mix.volmod_queue)
	{
		if(var_05["volmod"] == param_00)
		{
			var_03 = 1;
			level._audio.mix.volmod_queue[var_06]["volume"] = param_01;
			level._audio.mix.volmod_queue[var_06]["fade_time"] = param_02;
			break;
		}
	}

	if(!var_03)
	{
		var_07 = [];
		level._audio.mix.volmod_queue[level._audio.mix.volmod_index] = var_41;
		level._audio.mix.volmod_index++ = var_41["fade_time"];
	}
}

//Function Number: 50
mmx_mix_setting_enqueue(param_00,param_01,param_02)
{
	if(!isdefined(level._audio.mix.var_1113))
	{
		level._audio.mix.var_1113 = [];
		level._audio.mix.index = 0;
	}

	var_03 = 0;
	foreach(var_06, var_05 in level._audio.mix.var_1113)
	{
		if(var_05["channel"] == param_00)
		{
			var_03 = 1;
			level._audio.mix.var_1113[var_06]["volume"] = param_01;
			level._audio.mix.var_1113[var_06]["fade_time"] = param_02;
			break;
		}
	}

	if(!var_03)
	{
		var_07 = [];
		level._audio.mix.var_1113[level._audio.mix.index] = var_41;
		level._audio.mix.index++ = var_41["fade_time"];
	}
}

//Function Number: 51
mmx_volmod_server_throttler(param_00)
{
	if(!isdefined(level._audio.mix.volmod_queue))
	{
		level._audio.mix.volmod_queue = [];
		level._audio.mix.volmod_index = 0;
	}

	var_01 = 5;
	if(isdefined(param_00))
	{
		var_01 = param_00;
		var_01 = max(var_01,1);
	}

	for(;;)
	{
		level waittill("aud_new_volmod_set");
		while(level._audio.mix.volmod_queue.size > 0)
		{
			var_02 = 0;
			var_03 = [];
			foreach(var_0A, var_05 in level._audio.mix.volmod_queue)
			{
				if(var_02 < var_01)
				{
					var_02++;
					var_03[var_03.size] = var_0A;
					var_06 = level._audio.mix.volmod_queue[var_0A];
					var_07 = var_06["volmod"];
					var_08 = var_06["volume"];
					var_09 = var_06["fade_time"];
					var_08 = clamp(var_08,0,1);
					level.player setvolmod(var_07,var_08,var_09);
					continue;
				}

				break;
			}

			for(var_0B = 0;var_0B < var_03.size;var_0B++)
			{
				var_0C = var_03[var_0B];
				level._audio.mix.volmod_queue[var_0C] = undefined;
			}

			wait 0.05;
		}
	}
}

//Function Number: 52
mmx_mix_server_throttler(param_00)
{
	if(!isdefined(level._audio.mix.var_1113))
	{
		level._audio.mix.var_1113 = [];
		level._audio.mix.index = 0;
	}

	var_01 = 5;
	if(isdefined(param_00))
	{
		var_01 = param_00;
		var_01 = max(var_01,1);
	}

	for(;;)
	{
		level waittill("aud_new_mix_set");
		while(level._audio.mix.var_1113.size > 0)
		{
			var_02 = 0;
			var_03 = [];
			foreach(var_0A, var_05 in level._audio.mix.var_1113)
			{
				if(var_02 < var_01)
				{
					var_02++;
					var_03[var_03.size] = var_0A;
					var_06 = level._audio.mix.var_1113[var_0A];
					var_07 = var_06["channel"];
					var_08 = var_06["volume"];
					var_09 = var_06["fade_time"];
					var_08 = clamp(var_08,0,1);
					level.player setchannelvolume(var_07,var_08,var_09);
					continue;
				}

				break;
			}

			for(var_0B = 0;var_0B < var_03.size;var_0B++)
			{
				var_0C = var_03[var_0B];
				level._audio.mix.var_1113[var_0C] = undefined;
			}

			wait 0.05;
		}
	}
}

//Function Number: 53
mmx_get_preset_from_string_table(param_00,param_01)
{
	var_02 = [];
	var_03 = maps\_audio::get_mix_stringtable();
	var_04 = "soundtables/common_mix.csv";
	if(!isdefined(level._audio.mix.preset_cache))
	{
		level._audio.mix.preset_cache = [];
	}

	if(isdefined(level._audio.mix.preset_cache[param_00]))
	{
		var_02 = level._audio.mix.preset_cache[param_00];
	}
	else
	{
		if(param_01)
		{
			var_02 = mmx_get_mix_preset_from_stringtable_internal(var_03,param_00,0);
		}

		if(!isdefined(var_02) || var_02.size == 0)
		{
			var_02 = mmx_get_mix_preset_from_stringtable_internal(var_04,param_00,1);
		}

		if(!isdefined(var_02) || var_02.size == 0)
		{
			return;
		}

		level._audio.mix.preset_cache[param_00] = var_02;
	}

	return var_02;
}

//Function Number: 54
mmx_get_mix_preset_from_stringtable_internal(param_00,param_01,param_02)
{
	var_03 = 4;
	var_04 = "";
	var_05 = 0;
	var_06 = 0;
	var_07 = 0;
	var_08 = undefined;
	var_09 = [];
	if(!isdefined(level._audio.mix.var_1119))
	{
		level._audio.mix.var_1119 = [];
	}

	if(!isdefined(level._audio.mix.var_1119[param_00]))
	{
		level._audio.mix.var_1119[param_00] = [];
		for(var_0A = 1;var_0A < var_03;var_0A++)
		{
			var_0B = tablelookupbyrow(param_00,0,var_0A);
			level._audio.mix.var_1119[param_00][var_0B] = var_0A;
		}
	}

	var_0C = maps\_audio::func_111A("mix",param_01,param_02);
	if(var_0C != -1)
	{
		var_05 = var_0C;
	}
	else if((param_02 && maps\_audio::aud_is_common_indexed()) || !param_02 && maps\_audio::aud_is_local_indexed())
	{
		return var_09;
	}

	var_0D = 0;
	while(var_04 != "EOF" && var_07 < 10)
	{
		var_04 = tablelookupbyrow(param_00,var_05,0);
		if(var_04 != "")
		{
			var_07 = 0;
		}

		while(var_04 == param_01)
		{
			var_06 = 1;
			if(!isdefined(var_08))
			{
				var_0E = level._audio.mix.var_1119[param_00]["fade_time"];
				var_08 = tablelookupbyrow(param_00,var_05,var_0E);
				if(!isdefined(var_08) || isdefined(var_08) && var_08 == "")
				{
					var_08 = 1;
				}
			}

			var_0F = level._audio.mix.var_1119[param_00]["channels"];
			var_10 = level._audio.mix.var_1119[param_00]["value"];
			var_11 = tablelookupbyrow(param_00,var_05,var_0F);
			var_12 = tablelookupbyrow(param_00,var_05,var_10);
			if(var_11 == "set_all" || var_11 == "setall")
			{
				if(float(var_12) < 1)
				{
					var_09 = volmod_mix_with_all_channels_at(float(var_12));
				}
			}
			else
			{
				if(!isdefined(level._audio.mix.volmodfile[var_11]))
				{
					maps\_audio::aud_print_error("In soundtable " + param_00 + ", " + param_01 + " uses a volmod group name that doesn\'t exist in the volmodgroups.csv file.");
					return;
				}

				var_09[var_11] = float(var_12);
			}

			var_05++;
			var_04 = tablelookupbyrow(param_00,var_05,0);
			var_0D++;
		}

		var_07++;
		if(var_06)
		{
			break;
		}

		var_05++;
	}

	if(var_06 && isdefined(var_08))
	{
		var_09["fade_time"] = float(var_08);
	}

	return var_09;
}

//Function Number: 55
func_111E(param_00)
{
	if(!isdefined(level._audio.mix.preset_cache))
	{
		level._audio.mix.preset_cache = [];
	}

	var_01 = [];
	if(isdefined(level._audio.mix.preset_cache[param_00]))
	{
		var_01 = level._audio.mix.preset_cache[param_00];
	}
	else
	{
		var_01 = undefined;
		if(level._audio.mix.use_string_table_presets)
		{
			var_01 = mmx_get_preset_from_string_table(param_00,1);
		}
		else
		{
			var_01 = mmx_get_preset_from_string_table(param_00,0);
			if(!isdefined(var_01) || var_01.size == 0)
			{
				var_01 = maps\_audio::audio_presets_mix(param_00,var_01);
			}
		}

		if(!isdefined(var_01) || var_01.size == 0)
		{
			return;
		}

		if(!isdefined(var_41["fade_time"]))
		{
		}

		level._audio.mix.preset_cache[var_01] = var_41;
	}

	return var_41;
}

//Function Number: 56
mmx_init_volmods()
{
	if(!isdefined(level._audio.mix.volmodfile))
	{
		mmx_parse_volumemodgroups_csv();
	}

	level._audio.mix.volmod_vals = [];
	foreach(var_02, var_01 in level._audio.mix.volmodfile)
	{
		level._audio.mix.volmod_vals[var_02] = spawnstruct();
		level._audio.mix.volmod_vals[var_02].volume = var_01;
		level._audio.mix.volmod_vals[var_02].fade_time = 0;
	}

	mmx_init_channel_names();
}

//Function Number: 57
mmx_init_channel_names()
{
	if(!isdefined(level._audio.mix.channel_names))
	{
		var_00 = [];
		level._audio.mix.channel_names = var_41;
	}
}

//Function Number: 58
mmx_get_channel_volumes()
{
	return level._audio.mix.channel_volumes;
}

//Function Number: 59
volmod_mix_with_all_channels_at(param_00)
{
	var_01 = [];
	foreach(var_04, var_03 in level._audio.mix.volmodfile)
	{
		if(var_04 != "hud" && var_04 != "interface" && var_04 != "interface_music")
		{
			var_01[var_04] = param_00;
		}
	}

	return var_01;
}

//Function Number: 60
mmx_parse_volumemodgroups_csv()
{
	var_00 = "soundaliases/volumemodgroups.svmod";
	level._audio.mix.volmodfile = [];
	var_01 = 10;
	var_02 = 0;
	for(var_03 = 0;var_02 < var_01;var_03++)
	{
		var_04 = tablelookupbyrow(var_00,var_03,0);
		if(var_04 == "")
		{
			var_02++;
			continue;
		}

		var_05 = getsubstr(var_04,0,0);
		if(var_05 == "#")
		{
			continue;
		}

		var_06 = tablelookupbyrow(var_00,var_03,1);
		level._audio.mix.volmodfile[var_04] = float(var_06);
	}

	if(!isdefined(level._audio.volmod_submixes))
	{
		level._audio.volmod_submixes = [];
	}

	level._audio.mix.volmod_submixes["default"] = [];
	foreach(var_04, var_08 in level._audio.mix.volmodfile)
	{
		level._audio.mix.volmod_submixes["default"][var_04] = spawnstruct();
		level._audio.mix.volmod_submixes["default"][var_04].current_volume = var_08;
		level._audio.mix.volmod_submixes["default"][var_04].var_10DA = var_08;
	}
}

//Function Number: 61
mmx_is_mix_channel(param_00)
{
	return isdefined(level._audio.mix.channel_names[param_00]);
}

//Function Number: 62
mmx_is_volmod_channel(param_00)
{
	return isdefined(level._audio.mix.volmodfile[param_00]);
}