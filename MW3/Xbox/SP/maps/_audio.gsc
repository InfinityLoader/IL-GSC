/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\_audio.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: Console
 * Function Count: 175
 * Decompile Time: 2936 ms
 * Timestamp: 10/27/2023 2:32:58 AM
*******************************************************************/

//Function Number: 1
aud_init()
{
	if(!isdefined(level.aud))
	{
		if(!isdefined(level.script))
		{
			level.script = tolower(getdvar("mapname"));
		}

		level.aud = spawnstruct();
		if(!isdefined(level._audio))
		{
			level._audio = spawnstruct();
		}

		level._audio.using_string_tables = 0;
		level._audio.var_12BF = [];
		var_00 = spawnstruct();
		level._audio.index = spawnstruct();
		level._audio.index.local = func_1371();
		level._audio.index.common = func_1371();
		index_common_presets();
		level._audio.var_12C2 = [];
		level._audio.progress_trigger_callbacks = [];
		level._audio.progress_maps = [];
		level._audio.var_12C5 = 0;
		level._audio.var_12C6 = "";
		level._audio.current_filter_indices = ["",""];
		level._audio.var_1165 = 0;
		level._audio.vo_duck_active = 0;
		level._audio.var_12C9 = undefined;
		level._audio.player_state = spawnstruct();
		level._audio.player_state.locamote = "idle";
		level._audio.player_state.locamote_prev = "idle";
		level.ambient_reverb = [];
		level.var_12CD = [];
		level.fxfireloopmod = 1;
		level.var_1031 = "";
		level.var_12CE = 0;
		level.eq_mix_track = 1;
		level.eq_track[level.var_12CE] = "";
		level.eq_track[level.eq_mix_track] = "";
		maps\_audio_stream_manager::sm_init();
		maps\_audio_dynamic_ambi::damb_init();
		maps\_audio_zone_manager::azm_init();
		thread maps\_audio_mix_manager::mm_init();
		maps\_audio_reverb::rvb_init();
		maps\_audio_music::mus_init();
		maps\_audio_whizby::whiz_init();
		maps\_audio_vehicles::vm_init();
		thread aud_level_fadein();
		thread aud_wait_for_mission_fail_music();
		func_1314(::_audio_msg_handler);
	}
}

//Function Number: 2
audio_presets_dynamic_ambience(param_00,param_01)
{
	aud_print_error("CALLING DYNAMIC_AMBIENCE PRESET USING OLD METHOD!");
}

//Function Number: 3
audio_presets_dynamic_ambience_components(param_00,param_01)
{
	aud_print_error("CALLING DYNAMIC_AMBIENCE_COMPONENTS PRESET USING OLD METHOD!");
}

//Function Number: 4
audio_presets_dynamic_ambience_loop_definitions(param_00,param_01)
{
	aud_print_error("CALLING DYNAMIC_AMBIENCE_LOOP_DEFINITIONS PRESET USING OLD METHOD!");
}

//Function Number: 5
audio_presets_mix(param_00,param_01)
{
	aud_print_error("CALLING MIX PRESET USING OLD METHOD!");
}

//Function Number: 6
audio_presets_occlusion(param_00,param_01)
{
	aud_print_error("CALLING OCCLUSION PRESET USING OLD METHOD!");
}

//Function Number: 7
audio_presets_reverb(param_00,param_01)
{
	aud_print_error("CALLING REVERB PRESET USING OLD METHOD!");
}

//Function Number: 8
audio_presets_whizby(param_00,param_01)
{
	aud_print_error("CALLING WHIZBY PRESET USING OLD METHOD!");
}

//Function Number: 9
audio_presets_zones(param_00,param_01)
{
	aud_print_error("CALLING ZONE PRESET USING OLD METHOD!");
}

//Function Number: 10
aud_prime_stream(param_00,param_01,param_02)
{
	var_03 = 0;
	if(isdefined(param_01))
	{
		var_03 = param_01;
	}

	self endon("release" + param_00);
	for(;;)
	{
		self prefetchsound(param_00,"primed" + param_00);
		self waittill("primed" + param_00);
		if(!isdefined(self.var_12D4))
		{
			self.var_12D4 = [];
		}

		self.var_12D4[param_00] = 1;
		if(!var_03)
		{
			return;
		}
		else if(isdefined(param_02))
		{
			wait param_02;
		}
	}
}

//Function Number: 11
aud_is_stream_primed(param_00)
{
	if(isdefined(self.var_12D4) && isdefined(self.var_12D4[param_00]) && self.var_12D4[param_00])
	{
		return 1;
	}

	return 0;
}

//Function Number: 12
aud_error_if_not_primed(param_00)
{
}

//Function Number: 13
func_12D7(param_00,param_01)
{
	var_02 = 0;
	if(isdefined(param_01))
	{
		var_02 = param_01;
	}

	self notify("release" + param_00);
	if(var_02 && isdefined(self))
	{
		self stopsounds();
	}
}

//Function Number: 14
aud_wait_till_primed(param_00)
{
	if(isdefined(self.var_12D4) && isdefined(self.var_12D4[param_00]) && self.var_12D4[param_00])
	{
		return;
	}

	self waittill("primed" + param_00);
	self notify("release" + param_00);
}

//Function Number: 15
aud_prime_and_play_internal(param_00,param_01,param_02)
{
	aud_prime_stream(param_00);
	if(isdefined(param_02) && param_02)
	{
		aud_slomo_wait(param_01);
	}
	else
	{
		wait param_01;
	}

	self playsound(param_00,"sounddone");
	self waittill("sounddone");
	wait 0.05;
	self delete();
}

//Function Number: 16
aud_prime_and_play(param_00,param_01,param_02,param_03)
{
	var_04 = level.player.origin;
	if(isdefined(param_02))
	{
		var_04 = param_02;
	}

	var_05 = spawn("script_origin",var_04);
	var_05 thread aud_prime_and_play_internal(param_00,param_01,param_03);
	return var_05;
}

//Function Number: 17
aud_add_progress_map(param_00,param_01)
{
	level._audio.progress_maps[param_00] = param_01;
}

//Function Number: 18
aud_get_progress_map(param_00)
{
	if(isdefined(level._audio.progress_maps[param_00]))
	{
		return level._audio.progress_maps[param_00];
	}
}

//Function Number: 19
is_deathsdoor_audio_enabled()
{
	if(!isdefined(level._audio.deathsdoor_enabled))
	{
		return 1;
	}

	return level._audio.deathsdoor_enabled;
}

//Function Number: 20
aud_enable_deathsdoor_audio()
{
	level.player.disable_breathing_sound = 0;
	level._audio.deathsdoor_enabled = 1;
}

//Function Number: 21
aud_disable_deathsdoor_audio()
{
	level.player.disable_breathing_sound = 1;
	level._audio.deathsdoor_enabled = 0;
}

//Function Number: 22
func_12E2()
{
	if(is_deathsdoor_audio_enabled() || isdefined(level._audio.in_deathsdoor))
	{
		level._audio.in_deathsdoor = undefined;
		thread aud_set_occlusion(level._audio.deathsdoor.occlusion);
		thread func_1138(level._audio.deathsdoor.filter);
		thread maps\_audio_reverb::rvb_start_preset(level._audio.deathsdoor.reverb);
	}
}

//Function Number: 23
set_deathsdoor()
{
	level._audio.in_deathsdoor = 1;
	if(!isdefined(level._audio.deathsdoor))
	{
		level._audio.deathsdoor = spawnstruct();
	}

	level._audio.deathsdoor.filter = undefined;
	level._audio.deathsdoor.occlusion = undefined;
	level._audio.deathsdoor.reverb = undefined;
	level._audio.deathsdoor.filter = level._audio.var_12C6;
	level._audio.deathsdoor.occlusion = level._audio.var_12E7;
	level._audio.deathsdoor.reverb = level._audio.current_reverb;
	if(is_deathsdoor_audio_enabled())
	{
		thread func_1138("deathsdoor");
		thread maps\_audio_reverb::rvb_start_preset("deathsdoor");
	}
}

//Function Number: 24
aud_set_mission_failed_music(param_00)
{
	level._audio.var_12E9 = param_00;
}

//Function Number: 25
aud_wait_for_mission_fail_music()
{
	wait 0.05;
	while(!common_scripts\utility::flag_exist("missionfailed"))
	{
		wait 0.05;
	}

	var_00 = "shg_mission_failed_stinger";
	common_scripts\utility::flag_wait("missionfailed");
	if(isdefined(level._audio.var_12E9))
	{
		var_00 = level._audio.var_12E9;
	}

	if(soundexists(var_00))
	{
		maps\_audio_music::mus_play(var_00,2,4);
	}
}

//Function Number: 26
aud_set_filter_internal(param_00,param_01,param_02,param_03)
{
	var_04 = 7;
	var_05 = "";
	var_06 = 0;
	var_07 = [];
	var_08 = [];
	var_09 = 0;
	var_0A = 0;
	param_02 = func_111A("filter",param_00,param_03);
	if(param_02 != -1)
	{
		var_06 = param_02;
	}
	else if((param_03 && aud_is_common_indexed()) || !param_03 && aud_is_local_indexed())
	{
		return 0;
	}

	while(var_05 != "EOF" && var_0A < 10)
	{
		var_05 = tablelookupbyrow(param_01,var_06,0);
		if(var_05 != "")
		{
			var_0A = 0;
		}

		while(var_05 == param_00)
		{
			var_09 = 1;
			var_07 = undefined;
			for(var_0B = 1;var_0B < var_04;var_0B++)
			{
				if(!isdefined(var_08[var_0B]))
				{
					var_08[var_0B] = tablelookupbyrow(param_01,0,var_0B);
				}

				var_0C = var_08[var_0B];
				var_0D = tablelookupbyrow(param_01,var_06,var_0B);
				if(var_0D != "")
				{
					switch(var_0C)
					{
						case "channel_name":
							var_07 = spawnstruct();
							var_07.channel = var_0D;
							break;

						case "band":
							var_07.var_12ED = int(var_0D);
							break;

						case "type":
							var_07.type = var_0D;
							break;

						case "freq":
							var_07.var_12EE = float(var_0D);
							break;

						case "gain":
							var_07.gain = float(var_0D);
							break;

						case "q":
							var_07.q = float(var_0D);
							break;

						default:
							break;
					}
				}
			}

			if(!isdefined(level._audio.var_12F1[param_00]))
			{
				level._audio.var_12F1[param_00] = [];
			}

			level._audio.var_12F1[param_00][level._audio.var_12F1[param_00].size] = var_07;
			var_06++;
			var_05 = tablelookupbyrow(param_01,var_06,0);
		}

		var_0A++;
		if(var_09)
		{
			return 1;
		}

		var_06++;
	}

	return 0;
}

//Function Number: 27
aud_set_filter_threaded(param_00,param_01,param_02)
{
	if(!isdefined(level._audio.var_12F1))
	{
		level._audio.var_12F1 = [];
	}

	var_03 = 0;
	if(isdefined(param_01))
	{
		var_03 = param_01;
	}

	if(!isdefined(level._audio.var_12F1[param_00]))
	{
		level._audio.var_12F1[param_00] = [];
		var_04 = "soundtables/common_filter.csv";
		var_05 = get_filter_stringtable();
		var_06 = 1;
		var_06 = aud_set_filter_internal(param_00,var_05,var_03,0);
		if(!var_06)
		{
			var_06 = aud_set_filter_internal(param_00,var_04,var_03,1);
		}

		if(!var_06)
		{
			return;
		}
	}

	level._audio.var_12C6 = param_00;
	if(level._audio.current_filter_indices[var_03] != param_00)
	{
		level._audio.current_filter_indices[var_03] = param_00;
		var_07 = 10;
		if(isdefined(param_02))
		{
			var_07 = param_02;
		}

		var_08 = 0;
		foreach(var_0A in level._audio.var_12F1[param_00])
		{
			level.player seteq(var_0A.channel,var_03,var_0A.var_12ED,var_0A.type,var_0A.gain,var_0A.var_12EE,var_0A.q);
			if(var_08 < var_07)
			{
				var_08++;
				continue;
			}

			var_08 = 0;
			wait 0.05;
		}
	}
}

//Function Number: 28
aud_clear_filter(param_00)
{
	var_01 = 0;
	if(isdefined(param_00))
	{
		var_01 = param_00;
	}

	level._audio.current_filter_indices[var_01] = "";
	func_1138(undefined,var_01);
}

//Function Number: 29
func_12F4()
{
	level._audio.filter_zone_disabled = 1;
}

//Function Number: 30
func_12F6()
{
	level._audio.filter_zone_disabled = undefined;
}

//Function Number: 31
func_1164()
{
	return !isdefined(level._audio.filter_zone_disabled);
}

//Function Number: 32
func_1138(param_00,param_01,param_02,param_03)
{
	if(level._audio.var_12C5)
	{
		return;
	}

	if(isdefined(level.player.ent_flag) && isdefined(level.player.ent_flag["player_has_red_flashing_overlay"]) && level.player maps\_utility::ent_flag("player_has_red_flashing_overlay"))
	{
		return;
	}

	var_04 = 0;
	if(isdefined(param_01))
	{
		var_04 = param_01;
	}

	if(!isdefined(param_00) || isdefined(param_00) && param_00 == "")
	{
		level._audio.var_12C6 = undefined;
		level.player deactivateeq(var_04);
		return;
	}

	thread aud_set_filter_threaded(param_00,param_01,param_02);
}

//Function Number: 33
aud_disable_filter_setting(param_00)
{
	level._audio.var_12C5 = 1;
}

//Function Number: 34
func_12F8(param_00)
{
	level._audio.var_12C5 = 0;
}

//Function Number: 35
func_12F9(param_00)
{
	var_01 = "soundtables/common_timescale.csv";
	var_02 = 2;
	var_03 = "";
	var_04 = 0;
	var_05 = [];
	var_06 = [];
	var_07 = 0;
	var_08 = 0;
	var_09 = func_111A("timescale",param_00,1);
	if(var_09 != -1)
	{
		var_04 = var_09;
	}
	else if(aud_is_common_indexed())
	{
		return 0;
	}

	while(var_03 != "EOF" && var_08 < 10)
	{
		var_03 = tablelookupbyrow(var_01,var_04,0);
		if(var_03 != "")
		{
			var_08 = 0;
		}

		while(var_03 == param_00)
		{
			var_07 = 1;
			var_05 = undefined;
			for(var_0A = 1;var_0A < var_02 + 1;var_0A++)
			{
				if(!isdefined(var_06[var_0A]))
				{
					var_06[var_0A] = tablelookupbyrow(var_01,0,var_0A);
				}

				var_0B = var_06[var_0A];
				var_0C = tablelookupbyrow(var_01,var_04,var_0A);
				if(var_0C != "")
				{
					switch(var_0B)
					{
						case "channel_name":
							var_05 = spawnstruct();
							var_05.channel = var_0C;
							break;

						case "scalefactor":
							var_05.scalefactor = float(var_0C);
							break;

						default:
							aud_print_error("In timescale preset table, common_timescale.csv, there is an improperly labeled parameter column, \" + var_0B + "\".");
							break;
					}
				}
			}

			if(isdefined(var_05))
			{
				level._audio.var_12FB[param_00][level._audio.var_12FB[param_00].size] = var_05;
			}

			var_04++;
			var_03 = tablelookupbyrow(var_01,var_04,0);
		}

		var_08++;
		if(var_07)
		{
			return 1;
		}

		var_04++;
	}

	return 0;
}

//Function Number: 36
aud_set_timescale_threaded(param_00,param_01)
{
	var_02 = "default";
	if(isdefined(param_00))
	{
		var_02 = param_00;
	}

	if(!isdefined(level._audio.var_12FB))
	{
		level._audio.var_12FB = [];
	}

	var_03 = 1;
	if(!isdefined(level._audio.var_12FB[var_02]))
	{
		level._audio.var_12FB[var_02] = [];
		var_03 = func_12F9(var_02);
	}

	if(!var_03)
	{
		return;
	}

	var_04 = 10;
	if(isdefined(param_01))
	{
		var_04 = param_01;
	}

	var_05 = 0;
	foreach(var_07 in level._audio.var_12FB[var_02])
	{
		soundsettimescalefactor(var_07.channel,var_07.scalefactor);
		if(var_05 < var_04)
		{
			var_05++;
			continue;
		}

		var_05 = 0;
		wait 0.05;
	}
}

//Function Number: 37
aud_set_timescale(param_00,param_01)
{
	thread aud_set_timescale_threaded(param_00,param_01);
}

//Function Number: 38
aud_set_occlusion_internal(param_00)
{
	if(!isdefined(param_00))
	{
		return;
	}

	var_01 = "soundtables/common_occlusion.csv";
	var_02 = 5;
	var_03 = "";
	var_04 = 0;
	var_05 = [];
	var_06 = [];
	var_07 = 0;
	var_08 = 0;
	var_09 = func_111A("occlusion",param_00,1);
	if(var_09 != -1)
	{
		var_04 = var_09;
	}
	else if(aud_is_common_indexed())
	{
		return 0;
	}

	while(var_03 != "EOF" && var_08 < 10)
	{
		var_03 = tablelookupbyrow(var_01,var_04,0);
		if(var_03 != "")
		{
			var_08 = 0;
		}

		while(var_03 == param_00)
		{
			var_07 = 1;
			var_05 = undefined;
			for(var_0A = 1;var_0A < var_02 + 1;var_0A++)
			{
				if(!isdefined(var_06[var_0A]))
				{
					var_06[var_0A] = tablelookupbyrow(var_01,0,var_0A);
				}

				var_0B = var_06[var_0A];
				var_0C = tablelookupbyrow(var_01,var_04,var_0A);
				if(var_0C != "")
				{
					switch(var_0B)
					{
						case "channel_name":
							var_05 = spawnstruct();
							var_05.channel = var_0C;
							break;

						case "frequency":
							var_05.var_12EE = float(var_0C);
							break;

						case "type":
							var_05.type = var_0C;
							break;

						case "gain":
							var_05.gain = float(var_0C);
							break;

						case "q":
							var_05.q = float(var_0C);
							break;

						default:
							aud_print_error("In occlusion preset table, common_occlusion.csv, there is an improperly labeled parameter column, \" + var_0B + "\".");
							break;
					}
				}
			}

			if(!isdefined(var_05.var_12EE))
			{
				var_05.var_12EE = 600;
			}

			if(!isdefined(var_05.type))
			{
				var_05.type = "highshelf";
			}

			if(!isdefined(var_05.gain))
			{
				var_05.gain = -12;
			}

			if(!isdefined(var_05.q))
			{
				var_05.q = 1;
			}

			level._audio.occlusion_presets[param_00][level._audio.occlusion_presets[param_00].size] = var_05;
			var_04++;
			var_03 = tablelookupbyrow(var_01,var_04,0);
		}

		var_08++;
		if(var_07)
		{
			return 1;
		}

		var_04++;
	}

	return 0;
}

//Function Number: 39
aud_set_occlusion_threaded(param_00,param_01)
{
	var_02 = "default";
	if(isdefined(param_00))
	{
		var_02 = param_00;
	}

	if(!isdefined(level._audio.occlusion_presets))
	{
		level._audio.occlusion_presets = [];
	}

	var_03 = 1;
	if(!isdefined(level._audio.occlusion_presets[var_02]))
	{
		level._audio.occlusion_presets[var_02] = [];
		var_03 = aud_set_occlusion_internal(var_02);
	}

	if(!var_03)
	{
		return;
	}

	level._audio.var_12E7 = var_02;
	if(!isdefined(level._audio.var_1165) && level._audio.var_1165)
	{
		var_04 = 10;
		if(isdefined(param_01))
		{
			var_04 = var_04;
		}

		var_05 = 0;
		foreach(var_07 in level._audio.occlusion_presets[var_02])
		{
			level.player setocclusion(var_07.channel,var_07.var_12EE,var_07.type,var_07.gain,var_07.q);
			if(var_05 < var_04)
			{
				var_05++;
				continue;
			}

			var_05 = 0;
			wait 0.05;
		}
	}
}

//Function Number: 40
aud_set_occlusion(param_00,param_01)
{
	if(isdefined(level.player.ent_flag) && isdefined(level.player.ent_flag["player_has_red_flashing_overlay"]) && level.player maps\_utility::ent_flag("player_has_red_flashing_overlay"))
	{
		return;
	}

	if(!isdefined(param_00))
	{
		level._audio.var_12C6 = undefined;
		return;
	}

	thread aud_set_occlusion_threaded(param_00,param_01);
}

//Function Number: 41
func_1137(param_00)
{
	var_01 = 10;
	if(isdefined(param_00))
	{
		var_01 = var_01;
	}

	var_02 = 0;
	foreach(var_05, var_04 in level._audio.mix.channel_names)
	{
		level.player deactivateocclusion(var_05);
		if(var_02 < var_01)
		{
			var_02++;
			continue;
		}

		var_02 = 0;
		wait 0.05;
	}
}

//Function Number: 42
func_1301(param_00)
{
	var_01 = 10;
	if(isdefined(param_00))
	{
		var_01 = var_01;
	}

	func_1138(undefined,0,var_01);
	func_1138(undefined,1,var_01);
	func_1137(var_01);
	level._audio.var_1165 = 1;
}

//Function Number: 43
func_1302(param_00)
{
	var_01 = undefined;
	var_02 = "default";
	var_03 = 10;
	if(isdefined(param_00))
	{
		var_03 = var_03;
	}

	if(isdefined(level._audio.zone_mgr.current_zone) && isdefined(level._audio.zone_mgr.var_112B[level._audio.zone_mgr.current_zone]))
	{
		var_04 = maps\_audio_zone_manager::azm_get_current_zone();
		var_05 = level._audio.zone_mgr.var_112B[var_04];
		if(isdefined(var_05["occlusion"]) && var_05["occlusion"] != "none")
		{
			var_02 = var_05["occlusion"];
		}

		if(isdefined(var_05["filter"]) && var_05["filter"] != "none")
		{
			var_01 = var_05["filter"];
		}
	}

	if(level._audio.var_12E7 != var_02)
	{
		var_02 = level._audio.var_12E7;
	}

	level._audio.var_1165 = 0;
	func_1138(var_01,0,var_03);
	func_1138(undefined,1,var_03);
	aud_set_occlusion(var_02,var_03);
}

//Function Number: 44
aud_use_level_zones(param_00)
{
	level._audio.level_audio_zones_function = param_00;
}

//Function Number: 45
aud_use_level_reverb(param_00)
{
	level._audio.var_103C = param_00;
}

//Function Number: 46
aud_use_level_filters(param_00)
{
	level._audio.level_audio_filter_function = param_00;
}

//Function Number: 47
func_1307(param_00)
{
	var_01 = 1;
	if(isdefined(param_00))
	{
		var_01 = param_00;
	}

	level._audio.using_string_tables = 1;
	maps\_audio_zone_manager::azm_use_string_table();
	maps\_audio_reverb::rvb_use_string_table();
	maps\_audio_dynamic_ambi::damb_use_string_table();
	maps\_audio_mix_manager::mm_use_string_table();
	maps\_audio_whizby::whiz_use_string_table();
	if(var_01)
	{
		func_1374();
	}

	maps\_audio_whizby::whiz_set_preset("default");
}

//Function Number: 48
set_stringtable_mapname(param_00)
{
	func_1307(0);
	level._audio.var_12BF["map"] = param_00;
	func_1374();
}

//Function Number: 49
get_stringtable_mapname()
{
	if(isdefined(level._audio.var_12BF["map"]))
	{
		return level._audio.var_12BF["map"];
	}

	return common_scripts\utility::get_template_level();
}

//Function Number: 50
func_130A(param_00)
{
	level._audio.var_12BF["mix"] = param_00;
}

//Function Number: 51
get_mix_stringtable()
{
	if(!isdefined(level._audio.var_12BF["mix"]))
	{
		return "soundtables/" + get_stringtable_mapname() + "_mix.csv";
	}

	return "soundtables/" + level._audio.var_12BF["mix"];
}

//Function Number: 52
set_damb_stringtable(param_00)
{
	level._audio.var_12BF["damb"] = param_00;
}

//Function Number: 53
get_damb_stringtable()
{
	if(!isdefined(level._audio.var_12BF["damb"]))
	{
		return "soundtables/" + get_stringtable_mapname() + "_damb.csv";
	}

	return "soundtables/" + level._audio.var_12BF["damb"];
}

//Function Number: 54
set_damb_component_stringtable(param_00)
{
	level._audio.var_12BF["damb_comp"] = param_00;
}

//Function Number: 55
get_damb_component_stringtable(param_00)
{
	if(!isdefined(level._audio.var_12BF["damb_comp"]))
	{
		return "soundtables/" + get_stringtable_mapname() + "_damb_components.csv";
	}

	return "soundtables/" + level._audio.var_12BF["damb_comp"];
}

//Function Number: 56
set_damb_loops_stringtable(param_00)
{
	level._audio.var_12BF["damb_loops"] = param_00;
}

//Function Number: 57
get_damb_loops_stringtable(param_00)
{
	if(!isdefined(level._audio.var_12BF["damb_loops"]))
	{
		return "soundtables/" + get_stringtable_mapname() + "_damb_loops.csv";
	}

	return "soundtables/" + level._audio.var_12BF["damb_loops"];
}

//Function Number: 58
func_130E(param_00)
{
	level._audio.var_12BF["reverb"] = param_00;
}

//Function Number: 59
get_reverb_stringtable()
{
	if(!isdefined(level._audio.var_12BF["reverb"]))
	{
		return "soundtables/" + get_stringtable_mapname() + "_reverb.csv";
	}

	return "soundtables/" + level._audio.var_12BF["reverb"];
}

//Function Number: 60
func_130F(param_00)
{
	level._audio.var_12BF["filter"] = param_00;
}

//Function Number: 61
get_filter_stringtable()
{
	if(!isdefined(level._audio.var_12BF["filter"]))
	{
		return "soundtables/" + get_stringtable_mapname() + "_filter.csv";
	}

	return "soundtables/" + level._audio.var_12BF["filter"];
}

//Function Number: 62
func_1311(param_00)
{
	level._audio.var_12BF["zone"] = param_00;
}

//Function Number: 63
get_zone_stringtable()
{
	if(!isdefined(level._audio.var_12BF["zone"]))
	{
		return "soundtables/" + get_stringtable_mapname() + "_zone.csv";
	}

	return "soundtables/" + level._audio.var_12BF["zone"];
}

//Function Number: 64
set_occlusion_stringtable(param_00)
{
	level._audio.var_12BF["occlusion"] = param_00;
}

//Function Number: 65
get_occlusion_stringtable()
{
	if(!isdefined(level._audio.var_12BF["occlusion"]))
	{
		return "soundtables/" + get_stringtable_mapname() + "_occlusion.csv";
	}

	return "soundtables/" + level._audio.var_12BF["occlusion"];
}

//Function Number: 66
func_1314(param_00)
{
	level._audio.var_12C2[level._audio.var_12C2.size] = param_00;
}

//Function Number: 67
func_121F(param_00,param_01,param_02)
{
	thread aud_dispatch_msg(param_00,param_01,param_02);
}

//Function Number: 68
aud_dispatch_msg(param_00,param_01,param_02)
{
	var_03 = 0;
	var_04 = 0;
	foreach(var_06 in level._audio.var_12C2)
	{
		var_04 = self [[ var_06 ]](param_00,param_01);
		if(!var_03 && isdefined(var_04) && var_04 == 1)
		{
			var_03 = var_04;
			continue;
		}

		if(!var_03 && !isdefined(var_04))
		{
			var_03 = 1;
		}
	}

	if(isdefined(param_02))
	{
		self notify(param_02);
	}

	if(!var_03)
	{
		aud_print_warning("\tAUDIO MESSAGE NOT HANDLED: " + param_00);
	}
}

//Function Number: 69
aud_get_player_locamote_state()
{
	return level._audio.player_state.locamote;
}

//Function Number: 70
func_117A(param_00,param_01,param_02)
{
	var_03 = 0;
	var_04 = aud_get_sticky_threat();
	if(isdefined(var_04))
	{
		var_03 = var_04;
	}
	else
	{
		var_05 = 3;
		var_06 = 10;
		var_07 = 100;
		if(isdefined(param_00))
		{
			var_05 = param_00;
		}

		if(isdefined(param_02))
		{
			var_07 = param_02;
		}

		if(isdefined(param_02))
		{
			var_06 = param_01;
		}

		var_08 = 36 * var_07;
		var_09 = 36 * var_06;
		var_0A = getaiarray("bad_guys");
		var_0B = 0;
		var_0C = 0;
		foreach(var_0E in var_0A)
		{
			if(isdefined(var_0E.alertlevelint) && var_0E.alertlevelint >= var_05)
			{
				var_0F = distance(level.player.origin,var_0E.origin);
				if(var_0F < var_08)
				{
					var_0B++;
					if(var_0F < var_09)
					{
						var_10 = 1;
					}
					else
					{
						var_10 = 1 - var_10 - var_0A / var_09 - var_0A;
					}

					var_0C = var_0C + var_10;
				}
			}
		}

		if(var_0B > 0)
		{
			var_03 = var_0C / var_0B;
		}
		else
		{
			var_03 = 0;
		}
	}

	return var_03;
}

//Function Number: 71
aud_get_sticky_threat()
{
	return level._audio.var_12C9;
}

//Function Number: 72
aud_set_sticky_threat(param_00)
{
	level._audio.var_12C9 = param_00;
}

//Function Number: 73
aud_clear_sticky_threat()
{
	level._audio.var_12C9 = undefined;
}

//Function Number: 74
aud_num_alive_enemies(param_00)
{
	var_01 = 0;
	var_02 = 3600;
	if(isdefined(param_00))
	{
		var_02 = 36 * param_00;
	}

	var_03 = getaiarray("bad_guys");
	foreach(var_05 in var_03)
	{
		if(isalive(var_05))
		{
			var_06 = distance(level.player.origin,var_05.origin);
			if(var_06 < var_02)
			{
				var_01++;
			}
		}
	}

	return var_01;
}

//Function Number: 75
_audio_msg_handler(param_00,param_01)
{
	var_02 = 1;
	switch(param_00)
	{
		case "level_fade_to_black":
			var_03 = param_01[0];
			var_04 = param_01[1];
			wait var_03;
			maps\_audio_mix_manager::mm_start_preset("mute_all",var_04);
			break;

		case "generic_building_bomb_shake":
			level.player playsound("sewer_bombs");
			break;

		case "start_player_slide_trigger":
			break;

		case "end_player_slide_trigger":
			break;

		case "missile_fired":
			break;

		case "msg_audio_fx_ambientExp":
			break;

		case "aud_play_sound_at":
			aud_play_sound_at(param_01.alias,param_01.pos);
			break;

		case "aud_play_dynamic_explosion":
			if(isdefined(param_01.spread_width))
			{
				var_05 = param_01.spread_width;
			}
			else
			{
				var_05 = undefined;
			}
	
			if(isdefined(param_01.rear_dist))
			{
				var_06 = param_01.rear_dist;
			}
			else
			{
				var_06 = undefined;
			}
	
			if(isdefined(param_01.velocity))
			{
				var_07 = param_01.velocity;
			}
			else
			{
				var_07 = undefined;
			}
	
			aud_play_dynamic_explosion(param_01.explosion_pos,param_01.var_1320,param_01.right_alias,var_05,var_06,var_07);
			break;

		case "aud_play_conversation":
			aud_play_conversation(param_00,param_01);
			break;

		case "xm25_contact_explode":
			if(soundexists("xm25_proj_explo"))
			{
				var_08 = param_01;
				thread common_scripts\utility::play_sound_in_space("xm25_proj_explo",var_08);
			}
			break;

		case "light_flicker_on":
			var_09 = param_01;
			aud_handle_flickering_light(var_09);
			break;

		default:
			var_02 = 0;
			break;
	}

	return var_02;
}

//Function Number: 76
aud_handle_flickering_light(param_00)
{
	var_01 = 0;
	switch(param_00.model)
	{
		case "furniture_lamp_table1":
		case "com_cafe_light_part1_off":
		case "furniture_lamp_floor1_off":
			var_01 = 1;
			if(soundexists("paris_lamplight_flicker"))
			{
				thread common_scripts\utility::play_sound_in_space("paris_lamplight_flicker",param_00.origin);
			}
			break;

		default:
			var_01 = 0;
			break;
	}

	return var_01;
}

//Function Number: 77
aud_play_conversation(param_00,param_01)
{
	var_02 = param_01;
	var_03 = [];
	for(var_04 = 0;var_04 < var_02.size;var_04++)
	{
		var_03[var_04] = var_02[var_04].ent.battlechatter;
		var_02[var_04].ent.battlechatter = 0;
	}

	foreach(var_06 in var_02)
	{
		if(isdefined(var_06.delay))
		{
			wait var_06.delay;
		}

		var_07 = spawn("script_origin",(0,0,0));
		var_07 linkto(var_06.ent,"",(0,0,0),(0,0,0));
		var_07 playsound(var_06.sound,"sounddone");
		var_07 waittill("sounddone");
		wait 0.05;
		var_07 delete();
	}

	for(var_04 = 0;var_04 < var_02.size;var_04++)
	{
		var_02[var_04].ent.battlechatter = var_03[var_04];
	}
}

//Function Number: 78
trigger_multiple_audio_register_callback(param_00)
{
	if(!isdefined(level._audio.var_1017))
	{
		level._audio.var_1017 = [];
	}

	for(var_01 = 0;var_01 < param_00.size;var_01++)
	{
		var_02 = param_00[var_01];
		var_03 = var_02[0];
		var_04 = var_02[1];
		level._audio.var_1017[var_03] = var_04;
	}

	if(isdefined(level._audio.trigger_function_keys))
	{
		foreach(var_03 in level._audio.trigger_function_keys)
		{
		}

		level._audio.trigger_function_keys = undefined;
	}
}

//Function Number: 79
get_target_ent_target()
{
	var_00 = common_scripts\utility::get_target_ent();
	return var_00.target;
}

//Function Number: 80
get_target_ent_origin()
{
	var_00 = common_scripts\utility::get_target_ent();
	return var_00.origin;
}

//Function Number: 81
get_target_ent_target_ent()
{
	var_00 = common_scripts\utility::get_target_ent();
	return var_00 common_scripts\utility::get_target_ent();
}

//Function Number: 82
get_target_ent_target_ent_origin()
{
	var_00 = get_target_ent_target_ent();
	return var_00.origin;
}

//Function Number: 83
func_132B(param_00,param_01)
{
	if(!isdefined(param_00) || !isdefined(param_01))
	{
		return undefined;
	}

	if(param_01)
	{
		return param_00[1];
	}

	return param_00[0];
}

//Function Number: 84
get_zone_to(param_00,param_01)
{
	if(!isdefined(param_00) || !isdefined(param_01))
	{
		return undefined;
	}

	if(param_01)
	{
		return param_00[0];
	}

	return param_00[1];
}

//Function Number: 85
trigger_multiple_audio_trigger(param_00)
{
	if(!isdefined(level._audio))
	{
		level._audio = spawnstruct();
	}

	if(!isdefined(level._audio.var_1017))
	{
		level._audio.var_1017 = [];
	}

	var_01 = undefined;
	if(isdefined(param_00) && param_00)
	{
		if(isdefined(self.ambient))
		{
			var_01 = strtok(self.ambient," ");
		}
	}
	else if(isdefined(self.script_audio_zones))
	{
		var_01 = strtok(self.script_audio_zones," ");
	}
	else if(isdefined(self.audio_zones))
	{
		var_01 = strtok(self.audio_zones," ");
	}

	if(isdefined(var_01) && var_01.size == 2)
	{
	}
	else if(isdefined(var_01) && var_01.size == 1)
	{
		for(;;)
		{
			self waittill("trigger",var_02);
			maps\_audio_zone_manager::func_1134(var_01[0],self.script_duration);
		}
	}

	if(isdefined(self.script_audio_progress_map))
	{
		if(!isdefined(level._audio.progress_maps[self.script_audio_progress_map]))
		{
			aud_print_error("Trying to set a progress_map_function without defining the envelope in the level.aud.envs array.");
			self.script_audio_progress_map = undefined;
		}
	}

	if(!isdefined(level._audio.trigger_function_keys))
	{
		level._audio.trigger_function_keys = [];
	}

	if(isdefined(self.script_audio_enter_func))
	{
		level._audio.trigger_function_keys[level._audio.trigger_function_keys.size] = self.script_audio_enter_func;
	}

	if(isdefined(self.script_audio_exit_func))
	{
		level._audio.trigger_function_keys[level._audio.trigger_function_keys.size] = self.script_audio_exit_func;
	}

	if(isdefined(self.script_audio_progress_func))
	{
		level._audio.trigger_function_keys[level._audio.trigger_function_keys.size] = self.script_audio_progress_func;
	}

	if(isdefined(self.script_audio_point_func))
	{
		level._audio.trigger_function_keys[level._audio.trigger_function_keys.size] = self.script_audio_point_func;
	}

	if(!isdefined(self.script_audio_blend_mode))
	{
		self.script_audio_blend_mode = "blend";
	}

	var_03 = undefined;
	var_04 = undefined;
	var_05 = undefined;
	if(isdefined(self.target))
	{
		if(!isdefined(common_scripts\utility::get_target_ent()))
		{
			aud_print_error("Audo Zone Trigger at " + self.origin + " has defined a target, " + self.target + ", but that target doesn\'t exist.");
			return;
		}

		if(isdefined(get_target_ent_target()))
		{
			var_03 = get_target_ent_origin();
			if(!isdefined(get_target_ent_target_ent()))
			{
				aud_print_error("Audo Zone Trigger at " + self.origin + " has defined a target, " + get_target_ent_target() + ", but that target doesn\'t exist.");
				return;
			}

			var_04 = get_target_ent_target_ent_origin();
		}
		else
		{
			var_06 = common_scripts\utility::get_target_ent();
			var_07 = 2 * self.origin - var_06.origin;
			var_08 = vectortoangles(var_07);
			var_03 = get_target_ent_origin();
			var_04 = var_03 + var_07;
			if(angleclamp180(var_08[0]) < 45)
			{
				var_03 = (var_03[0],var_03[1],0);
				var_04 = (var_04[0],var_04[1],0);
			}
		}

		var_05 = distance(var_03,var_04);
	}

	var_09 = 0;
	for(;;)
	{
		self waittill("trigger",var_02);
		if(aud_is_specops() && var_02 != level.player)
		{
			continue;
		}

		if(isdefined(var_03) && isdefined(var_04))
		{
			var_0A = trigger_multiple_audio_progress(var_03,var_04,var_05,var_02.origin);
			if(var_0A < 0.5)
			{
				var_09 = 0;
				if(isdefined(self.script_audio_enter_msg))
				{
					if(isdefined(var_01) && isdefined(var_01[0]))
					{
						func_121F(self.script_audio_enter_msg,var_01[0]);
					}
					else
					{
						func_121F(self.script_audio_enter_msg,"front");
					}
				}

				if(isdefined(self.script_audio_enter_func))
				{
					if(isdefined(var_01) && isdefined(var_01[0]))
					{
						if(isdefined(level._audio.var_1017[self.script_audio_enter_func]))
						{
							[[ level._audio.var_1017[self.script_audio_enter_func] ]](var_01[0]);
						}
					}
					else if(isdefined(level._audio.var_1017[self.script_audio_enter_func]))
					{
						[[ level._audio.var_1017[self.script_audio_enter_func] ]]("front");
					}
				}
			}
			else
			{
				var_09 = 1;
				if(isdefined(self.script_audio_enter_msg))
				{
					if(isdefined(var_01) && isdefined(var_01[1]))
					{
						func_121F(self.script_audio_enter_msg,var_01[1]);
					}
					else
					{
						func_121F(self.script_audio_enter_msg,"back");
					}
				}

				if(isdefined(self.script_audio_enter_func))
				{
					if(isdefined(var_01) && isdefined(var_01[1]))
					{
						if(isdefined(level._audio.var_1017[self.script_audio_enter_func]))
						{
							[[ level._audio.var_1017[self.script_audio_enter_func] ]](var_01[1]);
						}
					}
					else if(isdefined(level._audio.var_1017[self.script_audio_enter_func]))
					{
						[[ level._audio.var_1017[self.script_audio_enter_func] ]]("back");
					}
				}
			}
		}
		else
		{
			if(isdefined(self.script_audio_enter_msg))
			{
				func_121F(self.script_audio_enter_msg);
			}

			if(isdefined(self.script_audio_enter_func))
			{
				if(isdefined(level._audio.var_1017[self.script_audio_enter_func]))
				{
					[[ level._audio.var_1017[self.script_audio_enter_func] ]]();
				}
			}
		}

		var_0B = undefined;
		if(isdefined(func_132B(var_01,var_09)) && isdefined(get_zone_to(var_01,var_09)))
		{
			var_0B = maps\_audio_zone_manager::func_1150(func_132B(var_01,var_09),get_zone_to(var_01,var_09));
			if(!isdefined(var_0B))
			{
				return;
			}

			var_0B.mode = self.script_audio_blend_mode;
		}

		if(isdefined(var_0B) && func_1164())
		{
			if(isdefined(var_0B.filter1) || isdefined(var_0B.filter2))
			{
				level.player deactivateeq(1);
			}
		}

		var_0C = -1;
		var_0A = -1;
		while(var_02 istouching(self))
		{
			if(isdefined(self.script_audio_point_func))
			{
				var_0D = trigger_multiple_audio_progress_point(var_03,var_04,var_02.origin);
				if(isdefined(level._audio.var_1017[self.script_audio_point_func]))
				{
					[[ level._audio.var_1017[self.script_audio_point_func] ]](var_0D);
				}
			}

			if(isdefined(var_03) && isdefined(var_04))
			{
				var_0A = trigger_multiple_audio_progress(var_03,var_04,var_05,var_02.origin);
				if(isdefined(self.script_audio_progress_map))
				{
					var_0A = func_117B(var_0A,level._audio.progress_maps[self.script_audio_progress_map]);
				}

				if(var_0A != var_0C)
				{
					if(isdefined(func_132B(var_01,var_09)) && isdefined(get_zone_to(var_01,var_09)))
					{
						maps\_audio_zone_manager::azm_print_enter_blend(func_132B(var_01,var_09),get_zone_to(var_01,var_09),var_0A);
					}

					if(isdefined(self.script_audio_progress_msg))
					{
						func_121F(self.script_audio_progress_msg,var_0A);
					}

					if(isdefined(self.script_audio_progress_func))
					{
						if(isdefined(level._audio.var_1017[self.script_audio_progress_func]))
						{
							[[ level._audio.var_1017[self.script_audio_progress_func] ]](var_0A);
						}
					}

					if(isdefined(var_0B))
					{
						trigger_multiple_audio_blend(var_0A,var_0B,var_09);
					}

					var_0C = var_0A;
					maps\_audio_zone_manager::func_1144(var_0A);
				}
			}

			if(isdefined(self.var_1338))
			{
				wait self.var_1338;
				continue;
			}

			wait 0.1;
		}

		if(isdefined(var_03) && isdefined(var_04))
		{
			if(var_0A > 0.5)
			{
				if(isdefined(var_01) && isdefined(var_01[1]))
				{
					maps\_audio_zone_manager::azm_set_current_zone(var_01[1]);
				}

				if(isdefined(self.script_audio_exit_msg))
				{
					if(isdefined(var_01) && isdefined(var_01[1]))
					{
						func_121F(self.script_audio_exit_msg,var_01[1]);
					}
					else
					{
						func_121F(self.script_audio_exit_msg,"back");
					}
				}

				if(isdefined(self.script_audio_exit_func))
				{
					if(isdefined(var_01) && isdefined(var_01[1]))
					{
						if(isdefined(level._audio.var_1017[self.script_audio_exit_func]))
						{
							[[ level._audio.var_1017[self.script_audio_exit_func] ]](var_01[1]);
						}
					}
					else if(isdefined(level._audio.var_1017[self.script_audio_exit_func]))
					{
						[[ level._audio.var_1017[self.script_audio_exit_func] ]]("back");
					}
				}

				var_0A = 1;
			}
			else
			{
				if(isdefined(var_01) && isdefined(var_01[0]))
				{
					maps\_audio_zone_manager::azm_set_current_zone(var_01[0]);
				}

				if(isdefined(self.script_audio_exit_msg))
				{
					if(isdefined(var_01) && isdefined(var_01[0]))
					{
						func_121F(self.script_audio_exit_msg,var_01[0]);
					}
					else
					{
						func_121F(self.script_audio_exit_msg,"front");
					}
				}

				if(isdefined(self.script_audio_exit_func))
				{
					if(isdefined(var_01) && isdefined(var_01[0]))
					{
						if(isdefined(level._audio.var_1017[self.script_audio_exit_func]))
						{
							[[ level._audio.var_1017[self.script_audio_exit_func] ]](var_01[0]);
						}
					}
					else if(isdefined(level._audio.var_1017[self.script_audio_exit_func]))
					{
						[[ level._audio.var_1017[self.script_audio_exit_func] ]]("front");
					}
				}

				var_0A = 0;
			}

			if(isdefined(var_0B))
			{
				trigger_multiple_audio_blend(var_0A,var_0B,var_09);
			}

			continue;
		}

		if(isdefined(self.script_audio_exit_msg))
		{
			func_121F(self.script_audio_exit_msg);
		}

		if(isdefined(self.script_audio_exit_func))
		{
			if(isdefined(level._audio.var_1017[self.script_audio_exit_func]))
			{
				[[ level._audio.var_1017[self.script_audio_exit_func] ]]();
			}
		}
	}
}

//Function Number: 86
trigger_multiple_audio_progress(param_00,param_01,param_02,param_03)
{
	var_04 = vectornormalize(param_01 - param_00);
	var_05 = param_03 - param_00;
	var_06 = vectordot(var_05,var_04);
	var_06 = var_06 / param_02;
	return clamp(var_06,0,1);
}

//Function Number: 87
trigger_multiple_audio_progress_point(param_00,param_01,param_02)
{
	var_03 = vectornormalize(param_01 - param_00);
	var_04 = param_02 - param_00;
	var_05 = vectordot(var_04,var_03);
	return var_03 * var_05 + param_00;
}

//Function Number: 88
trigger_multiple_audio_blend(param_00,param_01,param_02)
{
	param_00 = clamp(param_00,0,1);
	if(param_02)
	{
		param_00 = 1 - param_00;
	}

	var_03 = param_01.mode;
	if(var_03 == "blend")
	{
		var_04 = 1 - param_00;
		var_05 = param_00;
		maps\_audio_zone_manager::azmx_blend_zones(var_04,var_05,param_01);
		return;
	}

	if(param_00 < 0.33)
	{
		maps\_audio_zone_manager::func_1134(param_01.var_1151);
		return;
	}

	if(param_00 > 0.66)
	{
		maps\_audio_zone_manager::func_1134(param_01.var_1152);
		return;
	}
}

//Function Number: 89
aud_play_dynamic_explosion(param_00,param_01,param_02,param_03,param_04,param_05)
{
	var_06 = spawn("script_origin",level.player.origin);
	var_07 = spawn("script_origin",param_00);
	if(!isdefined(param_03))
	{
		param_03 = distance(var_07.origin,var_06.origin);
	}

	if(!isdefined(param_04))
	{
		var_08 = 30;
		param_04 = 36 * var_08;
	}

	var_09 = aud_do_dynamic_explosion_math(var_07.origin,var_06.origin,param_03,param_04);
	var_0A = distance(var_09.origin,var_41[0]);
	if(!isdefined(var_06))
	{
		var_06 = 1800;
	}

	var_0B = var_0A / var_06;
	if(isdefined(var_41) && var_41.size == 2)
	{
		var_0C = spawn("script_origin",var_09.origin);
		var_0D = spawn("script_origin",var_09.origin);
		var_0C playsound(param_02);
		var_0D playsound(param_03);
		var_0C moveto(var_41[0],var_0B,0,0);
		var_0D moveto(var_41[1],var_0B,0,0);
	}
}

//Function Number: 90
aud_do_dynamic_explosion_math(param_00,param_01,param_02,param_03)
{
	var_04 = param_01 - param_00;
	var_05 = func_1343(var_04);
	var_06 = func_1343(var_04);
	var_07 = aud_vector_magnitude_2d(var_05);
	var_08 = 0.5 * param_02 / var_07;
	var_05 = aud_scale_vector_2d(var_05,var_08);
	var_06 = aud_scale_vector_2d(var_06,var_08);
	var_05 = func_1342(var_05,90);
	var_06 = func_1342(var_06,-90);
	var_09 = aud_vector_magnitude_2d(var_04);
	var_0A = param_03 / var_09;
	var_0B = aud_scale_vector_2d(var_04,var_0A);
	var_0B = var_0B + var_04;
	var_0B = var_0B + var_04;
	var_05 = var_05 + var_0B;
	var_06 = var_06 + var_0B;
	var_0C = [];
	return var_41;
}

//Function Number: 91
aud_get_optional_param(param_00,param_01)
{
	var_02 = param_01;
	if(isdefined(param_00))
	{
		var_02 = param_00;
	}

	return var_02;
}

//Function Number: 92
aud_scale_vector_2d(param_00,param_01)
{
	return (param_00[0] * param_01,param_00[1] * param_01,param_00[2]);
}

//Function Number: 93
func_1341(param_00,param_01)
{
	return (param_00[0] * param_01,param_00[1] * param_01,param_00[2] * param_01);
}

//Function Number: 94
func_1342(param_00,param_01)
{
	var_02 = param_00[0] * cos(param_01) - param_00[1] * sin(param_01);
	var_03 = param_00[0] * sin(param_01) + param_00[1] * cos(param_01);
	return (var_02,var_03,param_00[2]);
}

//Function Number: 95
func_1343(param_00)
{
	var_01 = (0,0,0);
	var_01 = var_01 + param_00;
	return var_01;
}

//Function Number: 96
aud_vector_magnitude_2d(param_00)
{
	return sqrt(param_00[0] * param_00[0] + param_00[1] * param_00[1]);
}

//Function Number: 97
aud_print_synch(param_00)
{
	aud_print(param_00,"synch_frame");
}

//Function Number: 98
aud_print(param_00,param_01)
{
}

//Function Number: 99
aud_print_warning(param_00)
{
	aud_print(param_00,"warning");
}

//Function Number: 100
aud_print_error(param_00)
{
	aud_print(param_00,"error");
}

//Function Number: 101
aud_print_debug(param_00)
{
	aud_print(param_00);
}

//Function Number: 102
func_1135(param_00)
{
	aud_print(param_00,"zone");
}

//Function Number: 103
aud_print_zone_small(param_00)
{
	aud_print(param_00,"zone_small");
}

//Function Number: 104
equal_strings(param_00,param_01)
{
	if(isdefined(param_00) && isdefined(param_01))
	{
		return param_00 == param_01;
	}

	return !isdefined(param_00) && !isdefined(param_01);
}

//Function Number: 105
isundefined(param_00)
{
	return !isdefined(param_00);
}

//Function Number: 106
delete_on_sounddone(param_00)
{
	param_00 waittill("sounddone");
	param_00 delete_sound_entity();
}

//Function Number: 107
delete_sound_entity()
{
	common_scripts\utility::delaycall(0.05,::delete);
}

//Function Number: 108
aud_fade_out_and_delete(param_00,param_01)
{
	param_00 scalevolume(0,param_01);
	param_00 common_scripts\utility::delaycall(param_01 + 0.05,::stopsounds);
	param_00 common_scripts\utility::delaycall(param_01 + 0.1,::delete);
}

//Function Number: 109
aud_fade_loop_out_and_delete(param_00,param_01)
{
	param_00 scalevolume(0,param_01);
	wait param_01 + 0.05;
	param_00 stoploopsound();
	wait 0.05;
	param_00 delete();
}

//Function Number: 110
aud_min(param_00,param_01)
{
	if(param_00 <= param_01)
	{
		return param_00;
	}

	return param_01;
}

//Function Number: 111
aud_max(param_00,param_01)
{
	if(param_00 >= param_01)
	{
		return param_00;
	}

	return param_01;
}

//Function Number: 112
aud_clamp(param_00,param_01,param_02)
{
	if(param_00 < param_01)
	{
		param_00 = param_01;
	}
	else if(param_00 > param_02)
	{
		param_00 = param_02;
	}

	return param_00;
}

//Function Number: 113
aud_fade_sound_in(param_00,param_01,param_02,param_03,param_04)
{
	param_02 = aud_clamp(param_02,0,1);
	param_03 = aud_max(0.05,param_03);
	var_05 = 0;
	if(isdefined(param_04))
	{
		var_05 = param_04;
	}

	if(var_05)
	{
		param_00 playloopsound(param_01);
	}
	else
	{
		param_00 playsound(param_01);
	}

	param_00 scalevolume(0);
	param_00 common_scripts\utility::delaycall(0.05,::scalevolume,param_02,param_03);
}

//Function Number: 114
func_1351(param_00,param_01)
{
	var_04 = param_01[0][0];
	var_05 = param_01[param_01.size - 1][0];
	var_06 = param_01[0][1];
	var_07 = param_01[param_01.size - 1][1];
	var_08 = undefined;
	if(param_00 <= var_04)
	{
		var_08 = var_06;
	}
	else if(param_00 >= var_05)
	{
		var_08 = var_07;
	}
	else
	{
		var_09 = undefined;
		var_02 = var_04;
		var_0A = var_06;
		for(var_03 = 0;var_03 < param_01.size;var_03++)
		{
			var_09 = param_01[var_03][0];
			var_0B = param_01[var_03][1];
			if(param_00 >= var_02 && param_00 < var_09)
			{
				var_0C = param_00 - var_02 / var_09 - var_02;
				var_08 = var_0A + var_0C * var_0B - var_0A;
				break;
			}

			var_02 = var_09;
			var_0A = var_0B;
		}
	}

	return var_08;
}

//Function Number: 115
func_117B(param_00,param_01)
{
	var_02 = 0;
	var_03 = param_01.size;
	var_04 = param_01[0];
	for(var_05 = 1;var_05 < param_01.size;var_05++)
	{
		var_06 = param_01[var_05];
		if(param_00 >= var_04[0] && param_00 <= var_06[0])
		{
			var_07 = var_04[0];
			var_08 = var_06[0];
			var_09 = var_04[1];
			var_0A = var_06[1];
			var_0B = param_00 - var_07 / var_08 - var_07;
			var_02 = var_09 + var_0B * var_0A - var_09;
			break;
		}
		else
		{
			var_04 = var_06;
		}
	}

	return var_02;
}

//Function Number: 116
aud_map_range(param_00,param_01,param_02,param_03)
{
	var_04 = param_00 - param_01 / param_02 - param_01;
	var_04 = clamp(var_04,0,1);
	return func_117B(var_04,param_03);
}

//Function Number: 117
aud_smooth(param_00,param_01,param_02)
{
	return param_00 + param_02 * param_01 - param_00;
}

//Function Number: 118
aud_is_even(param_00)
{
	return param_00 == int(param_00 / 2) * 2;
}

//Function Number: 119
func_1354(param_00)
{
	var_01 = maps\_audio_mix_manager::mm_get_channel_names();
	var_02 = [];
	foreach(var_04 in param_00)
	{
		var_01[var_04] = undefined;
	}

	foreach(var_04, var_07 in var_01)
	{
		var_02[var_02.size] = var_04;
	}

	return var_02;
}

//Function Number: 120
all_mix_channels()
{
	var_00 = maps\_audio_mix_manager::mm_get_channel_names();
	var_01 = [];
	foreach(var_04, var_03 in var_00)
	{
		var_01[var_01.size] = var_04;
	}

	return var_01;
}

//Function Number: 121
aud_setalltimescalefactors(param_00)
{
	param_00 = clamp(param_00,0,1);
	var_01 = all_mix_channels();
	aud_settimescalefactors(var_01,param_00);
}

//Function Number: 122
aud_settimescalefactors(param_00,param_01)
{
	thread audx_settimescalefactors(param_00,param_01);
}

//Function Number: 123
audx_settimescalefactors(param_00,param_01)
{
	var_02 = 8;
	var_03 = 0;
	var_04 = 0;
	var_05 = 0;
	while(var_04 < param_00.size)
	{
		var_05 = var_04;
		for(var_03 = 0;var_03 < var_02 && var_05 < param_00.size;var_03++)
		{
			soundsettimescalefactor(param_00[var_05],param_01);
			var_05++;
		}

		wait 0.05;
		var_04 = var_04 + var_02;
	}
}

//Function Number: 124
aud_set_breach_time_scale_factors()
{
	var_00 = all_mix_channels();
	aud_settimescalefactors(var_00,1);
	wait 0.5;
	soundsettimescalefactor("Music",0);
	soundsettimescalefactor("Menu",0);
	soundsettimescalefactor("local3",0);
	soundsettimescalefactor("Mission",0);
	soundsettimescalefactor("Announcer",0);
	soundsettimescalefactor("Bulletimpact",0.6);
	soundsettimescalefactor("Voice",0.4);
	soundsettimescalefactor("effects1",0.2);
	soundsettimescalefactor("effects2",0.2);
	soundsettimescalefactor("local",0.2);
	soundsettimescalefactor("local2",0.2);
	soundsettimescalefactor("physics",0.2);
	soundsettimescalefactor("ambient",0.5);
	soundsettimescalefactor("auto",0.5);
}

//Function Number: 125
play_2d_sound_internal(param_00)
{
	self playsound(param_00,"sounddone");
	self waittill("sounddone");
	wait 0.05;
	self delete();
}

//Function Number: 126
aud_delay_play_2d_sound_internal(param_00,param_01,param_02)
{
	if(isdefined(param_02) && param_02)
	{
		aud_slomo_wait(param_01);
	}
	else
	{
		wait param_01;
	}

	var_03 = spawn("script_origin",level.player.origin);
	var_03 thread play_2d_sound_internal(param_00);
	return var_03;
}

//Function Number: 127
aud_play_2d_sound(param_00)
{
	var_01 = spawn("script_origin",level.player.origin);
	var_01 thread play_2d_sound_internal(param_00);
	return var_01;
}

//Function Number: 128
func_135D(param_00,param_01,param_02)
{
	var_03 = thread aud_delay_play_2d_sound_internal(param_00,param_01,param_02);
	return var_03;
}

//Function Number: 129
audx_play_linked_sound_internal(param_00,param_01,param_02)
{
	if(param_00 == "loop")
	{
		level endon(param_02 + "internal");
		self playloopsound(param_01);
		level waittill(param_02);
		if(isdefined(self))
		{
			self stoploopsound(param_01);
			wait 0.05;
			self delete();
			return;
		}

		return;
	}

	if(param_00 == "oneshot")
	{
		self playsound(param_01,"sounddone");
		self waittill("sounddone");
		if(isdefined(self))
		{
			self delete();
			return;
		}
	}
}

//Function Number: 130
audx_monitor_linked_entity_health(param_00,param_01)
{
	level endon(param_01);
	while(isdefined(self))
	{
		wait 0.1;
	}

	level notify(param_01 + "internal");
	if(isdefined(param_00))
	{
		param_00 stoploopsound();
		wait 0.05;
		param_00 delete();
	}
}

//Function Number: 131
aud_play_linked_sound(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = "oneshot";
	if(isdefined(param_02))
	{
		var_05 = param_02;
	}

	var_06 = spawn("script_origin",param_01.origin);
	if(isdefined(param_04))
	{
		var_06 linkto(param_01,"tag_origin",param_04,(0,0,0));
	}
	else
	{
		var_06 linkto(param_01);
	}

	if(var_05 == "loop")
	{
		param_01 thread audx_monitor_linked_entity_health(var_06,param_03);
	}

	var_06 thread audx_play_linked_sound_internal(var_05,param_00,param_03);
	return var_06;
}

//Function Number: 132
func_1360(param_00,param_01,param_02)
{
	var_03 = spawn("script_origin",param_01.origin);
	var_03 linkto(param_01);
	var_04 = "oneshot";
	if(isdefined(param_02))
	{
		var_04 = param_02;
	}

	if(var_04 == "loop")
	{
		var_03 playloopsound(param_00);
	}
	else
	{
		var_03 playsound(param_00);
	}

	return var_03;
}

//Function Number: 133
aud_play_sound_at_internal(param_00,param_01,param_02)
{
	self playsound(param_00,"sounddone");
	if(isdefined(param_02))
	{
		wait param_02;
		self stopsounds();
	}
	else
	{
		self waittill("sounddone");
	}

	wait 0.05;
	self delete();
}

//Function Number: 134
aud_play_sound_at(param_00,param_01,param_02)
{
	var_03 = spawn("script_origin",param_01);
	var_03 thread aud_play_sound_at_internal(param_00,param_01,param_02);
	return var_03;
}

//Function Number: 135
func_1363(param_00,param_01)
{
	var_02 = spawn("script_origin",param_01);
	var_02 thread aud_prime_stream(param_00,1,0.1);
	return var_02;
}

//Function Number: 136
aud_play_primed_point_source_loop(param_00,param_01,param_02)
{
	var_03 = aud_get_optional_param(param_01,1);
	var_04 = aud_get_optional_param(param_02,1);
	aud_fade_sound_in(self,param_00,var_03,var_04,1);
	func_12D7(param_00);
}

//Function Number: 137
aud_play_point_source_loop(param_00,param_01,param_02,param_03)
{
	var_04 = aud_get_optional_param(param_02,1);
	var_05 = aud_get_optional_param(param_03,1);
	var_06 = spawn("script_origin",param_01);
	aud_fade_sound_in(var_06,param_00,var_04,var_05,1);
	return var_06;
}

//Function Number: 138
aud_stop_point_source_loop(param_00,param_01)
{
	var_02 = aud_get_optional_param(param_01,1);
	aud_fade_out_and_delete(param_00,var_02);
}

//Function Number: 139
aud_set_point_source_loop_volume(param_00,param_01,param_02)
{
	param_01 = clamp(param_01,0,1);
	var_03 = aud_get_optional_param(param_02,1);
	param_00 scalevolume(param_01,var_03);
}

//Function Number: 140
aud_play_loops_on_destructables_array(param_00,param_01,param_02,param_03)
{
	var_04 = 0.1;
	if(isdefined(param_03))
	{
		var_04 = param_03;
	}

	var_05 = getentarray(param_00,"script_noteworthy");
	var_06 = var_05.size;
	foreach(var_08 in var_05)
	{
		var_08 playloopsound(param_01);
		var_08.loop_sound_stopped = 0;
	}

	while(var_06 > 0)
	{
		wait var_04;
		foreach(var_08 in var_05)
		{
			if(var_08.health < 0 && !var_08.loop_sound_stopped)
			{
				var_06--;
				var_08 stoploopsound();
				var_08.loop_sound_stopped = 1;
				if(isdefined(param_02))
				{
					common_scripts\utility::play_sound_in_space(param_02,var_08.origin);
				}
			}
		}
	}
}

//Function Number: 141
aud_set_music_submix(param_00,param_01)
{
	var_02 = "music_submix";
	if(!maps\_audio_mix_manager::mm_does_volmod_submix_exist(var_02))
	{
		maps\_audio_mix_manager::mm_add_dynamic_volmod_submix(var_02,["music",1],param_01);
		maps\_audio_mix_manager::mm_make_submix_sticky(var_02);
	}

	maps\_audio_mix_manager::mm_scale_submix(var_02,param_00,param_01);
}

//Function Number: 142
aud_set_ambi_submix(param_00,param_01)
{
	var_02 = "ambi_submix";
	if(!maps\_audio_mix_manager::mm_does_volmod_submix_exist(var_02))
	{
		maps\_audio_mix_manager::mm_add_dynamic_volmod_submix(var_02,["ambience",1],param_01);
		maps\_audio_mix_manager::mm_make_submix_sticky(var_02);
	}

	maps\_audio_mix_manager::mm_scale_submix(var_02,param_00,param_01);
}

//Function Number: 143
aud_fade_in_music(param_00)
{
	var_01 = 10;
	if(isdefined(param_00))
	{
		var_01 = param_00;
	}

	maps\_audio_mix_manager::mm_add_submix("mute_music",0.1);
	wait 0.05;
	maps\_audio_mix_manager::mm_clear_submix("mute_music",var_01);
}

//Function Number: 144
aud_check_sound_done()
{
	self endon("cleanup");
	if(!isdefined(self.sounddone))
	{
		self.sounddone = 0;
	}

	self waittill("sounddone");
	if(isdefined(self))
	{
		self.sounddone = 1;
		self notify("cleanup");
	}
}

//Function Number: 145
aud_in_zone(param_00)
{
	return equal_strings(maps\_audio_zone_manager::azm_get_current_zone(),param_00);
}

//Function Number: 146
aud_find_exploder(param_00)
{
	if(isdefined(level.createfxexploders))
	{
		var_01 = level.createfxexploders["" + param_00];
		if(isdefined(var_01))
		{
			return var_01[0];
		}
	}
	else
	{
		for(var_02 = 0;var_02 < level.createfxent.size;var_02++)
		{
			var_03 = level.createfxent[var_02];
			if(!isdefined(var_03))
			{
				continue;
			}

			if(var_03.v["type"] != "exploder")
			{
				continue;
			}

			if(!isdefined(var_03.v["exploder"]))
			{
				continue;
			}

			if(int(var_03.v["exploder"]) != param_00)
			{
				continue;
			}

			return var_03;
		}
	}

	return undefined;
}

//Function Number: 147
aud_duck(param_00,param_01,param_02,param_03)
{
	thread audx_duck(param_00,param_01,param_02,param_03);
}

//Function Number: 148
audx_duck(param_00,param_01,param_02,param_03)
{
	param_01 = clamp(param_01,0,10);
	var_04 = 1;
	if(isdefined(param_02))
	{
		var_04 = param_02;
	}

	var_05 = var_04;
	if(isdefined(param_03))
	{
		var_05 = param_03;
	}

	maps\_audio_mix_manager::mm_add_submix(param_00,var_04);
	wait param_01;
	maps\_audio_mix_manager::mm_clear_submix(param_00,var_05);
}

//Function Number: 149
func_1371()
{
	var_00 = spawnstruct();
	var_00.filter = [];
	var_00.mix = [];
	var_00.occlusion = [];
	var_00.var_1372 = [];
	var_00.var_1373 = 0;
	return var_00;
}

//Function Number: 150
func_1374()
{
	level._audio.index.local.mix = func_1377(get_mix_stringtable());
	level._audio.index.local.filter = func_1377(get_filter_stringtable());
	level._audio.index.local.var_1373 = 1;
}

//Function Number: 151
aud_is_local_indexed()
{
	return level._audio.index.local.var_1373;
}

//Function Number: 152
index_common_presets()
{
	level._audio.index.common.mix = func_1377("soundtables/common_mix.csv");
	level._audio.index.common.occlusion = func_1377("soundtables/common_occlusion.csv");
	level._audio.index.common.var_1372 = func_1377("soundtables/common_timescale.csv");
	level._audio.index.common.filter = func_1377("soundtables/common_filter.csv");
	level._audio.index.common.var_1373 = 1;
}

//Function Number: 153
aud_is_common_indexed()
{
	return level._audio.index.common.var_1373;
}

//Function Number: 154
func_111A(param_00,param_01,param_02)
{
	var_03 = 1;
	if(isdefined(param_02))
	{
		var_03 = param_02;
	}

	var_04 = undefined;
	if(var_03)
	{
		var_04 = level._audio.index.common;
	}
	else
	{
		var_04 = level._audio.index.local;
	}

	var_05 = undefined;
	switch(param_00)
	{
		case "mix":
			var_05 = var_04.mix[param_01];
			break;

		case "filter":
			var_05 = var_04.filter[param_01];
			break;

		case "occlusion":
			var_05 = level._audio.index.common.occlusion[param_01];
			break;

		case "timescale":
			var_05 = level._audio.index.common.var_1372[param_01];
			break;

		default:
			break;
	}

	if(!isdefined(var_05))
	{
		var_05 = -1;
	}

	return var_05;
}

//Function Number: 155
get_mix_index(param_00,param_01)
{
	if(param_01)
	{
		return level._audio.index.common.mix[param_00];
	}

	return level._audio.index.local.mix[param_00];
}

//Function Number: 156
func_1377(param_00)
{
	var_01 = "";
	var_02 = 0;
	var_03 = 1;
	var_04 = [];
	var_05 = "";
	while(var_02 < 10 && var_05 != "EOF")
	{
		var_05 = tablelookupbyrow(param_00,var_03,0);
		if(isdefined(var_05) && var_05 != var_01 && var_05 != "" && var_05 != "EOF")
		{
			var_02 = 0;
			var_01 = var_05;
			var_04[var_01] = var_03;
			continue;
		}

		if(var_05 == "")
		{
			var_02++;
		}

		var_03++;
	}

	return var_04;
}

//Function Number: 157
aud_percent_chance(param_00)
{
	return randomintrange(1,100) <= param_00;
}

//Function Number: 158
aud_start_slow_mo_gunshot_callback(param_00,param_01)
{
	level endon("aud_stop_slow_mo_gunshot");
	var_02 = getaiarray("axis");
	foreach(var_04 in var_02)
	{
		var_04 thread aud_impact_monitor(param_01);
	}

	var_06 = 0;
	var_07 = level.player getcurrentweapon();
	for(;;)
	{
		if(level.player attackbuttonpressed())
		{
			if(!var_06)
			{
				var_06 = 1;
				[[ param_00 ]](var_07);
			}
		}
		else
		{
			var_06 = 0;
		}

		wait 0.05;
	}
}

//Function Number: 159
aud_impact_monitor(param_00)
{
	level endon("aud_stop_slow_mo_gunshot");
	var_01 = level.player getcurrentweapon();
	for(;;)
	{
		self waittill("damage",var_02,var_03,var_04,var_05,var_06);
		if(isdefined(var_05))
		{
			[[ param_00 ]](var_01,var_02,var_03,var_05,var_06);
		}
	}
}

//Function Number: 160
aud_stop_slow_mo_gunshot_callback()
{
	level notify("aud_stop_slow_mo_gunshot");
}

//Function Number: 161
func_137C(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	self.var_137D = 1;
	self.alias = param_00;
	self.points = param_01;
	self.edge_spread = param_02;
	self.update_rate = param_05;
	self.var_1381 = param_03;
	self.max_dist = param_04;
	self.vol_scale = param_06;
	self playloopsound(param_00);
	wait 0.1;
	thread audx_distributed_sound_update_loop(param_01,param_02,param_05,param_03,param_04,param_06);
}

//Function Number: 162
func_1384()
{
	self notify("stop");
}

//Function Number: 163
aud_start_distributed_sound()
{
	if(isdefined(self.var_137D))
	{
		self playloopsound(self.alias);
		wait 0.1;
		thread audx_distributed_sound_update_loop(self.points,self.edge_spread,self.update_rate,self.var_1381,self.max_dist,self.vol_scale);
	}
}

//Function Number: 164
audx_distributed_sound_update_loop(param_00,param_01,param_02,param_03,param_04,param_05)
{
	self endon("stop");
	var_06 = 0.1;
	if(isdefined(param_02))
	{
		var_06 = param_02;
	}

	var_07 = 1;
	if(isdefined(param_05))
	{
		var_07 = param_05;
	}

	if(isdefined(param_03))
	{
		if(!isdefined(param_04))
		{
			return;
		}

		while(isdefined(self))
		{
			self setdistributed2dsound(param_00,param_01,var_06,var_07,param_03,param_04);
			wait var_06;
		}

		return;
	}

	while(isdefined(self))
	{
		self setdistributed2dsound(param_00,param_01,var_06,var_07);
		wait var_06;
	}
}

//Function Number: 165
aud_slomo_wait(param_00)
{
	var_01 = spawn("script_origin",(0,0,0));
	var_01 thread aud_slomo_wait_internal(param_00);
	var_01 waittill("slo_mo_wait_done");
	var_01 delete();
}

//Function Number: 166
aud_slomo_wait_internal(param_00)
{
	var_01 = 0;
	while(var_01 < param_00)
	{
		var_02 = getdvarfloat("com_timescale");
		var_01 = var_01 + 0.05 / var_02;
		wait 0.05;
	}

	self notify("slo_mo_wait_done");
}

//Function Number: 167
aud_set_level_fade_time(param_00)
{
	if(!isdefined(level._audio))
	{
		level._audio = spawnstruct();
	}

	level._audio.level_fade_time = param_00;
}

//Function Number: 168
aud_level_fadein()
{
	if(!isdefined(level._audio.level_fade_time))
	{
		level._audio.level_fade_time = 1;
	}

	wait 0.05;
	levelsoundfade(1,level._audio.level_fade_time);
}

//Function Number: 169
aud_is_specops()
{
	return isdefined(level._audio.specops);
}

//Function Number: 170
audx_set_spec_ops_internal()
{
	if(!isdefined(level._audio))
	{
		level._audio = spawnstruct();
	}

	level._audio.specops = 1;
}

//Function Number: 171
aud_set_spec_ops()
{
	thread audx_set_spec_ops_internal();
}

//Function Number: 172
audx_play_line_emitter_internal()
{
	level endon(self.label + "_line_emitter_stop");
	var_00 = self.point2 - self.var_1392;
	var_01 = vectornormalize(var_00);
	var_02 = distance(self.var_1392,self.point2);
	var_03 = 0.1;
	for(;;)
	{
		var_04 = level.player.origin - self.var_1392;
		var_05 = vectordot(var_04,var_01);
		var_05 = clamp(var_05,0,var_02);
		var_06 = self.var_1392 + var_01 * var_05;
		if(!self.is_playing)
		{
			self.origin = var_06;
			self playloopsound(self.alias);
			self scalevolume(0);
			wait 0.05;
			self scalevolume(1,self.fade_in);
			self.is_playing = 1;
		}
		else
		{
			self moveto(var_06,var_03);
		}

		wait var_03;
	}
}

//Function Number: 173
aud_stop_line_emitter(param_00)
{
	level notify(param_00 + "_line_emitter_stop");
}

//Function Number: 174
aud_play_line_emitter(param_00,param_01,param_02,param_03,param_04,param_05)
{
	var_06 = 0.1;
	var_07 = 0.1;
	if(isdefined(param_04))
	{
		var_06 = max(param_04,0);
		var_07 = max(param_04,0);
	}

	if(isdefined(param_05))
	{
		var_07 = max(param_05,0);
	}

	var_08 = spawn("script_origin",(0,0,0));
	var_08.alias = param_01;
	var_08.is_playing = 0;
	var_08.var_1392 = param_02;
	var_08.point2 = param_03;
	var_08.fade_in = var_06;
	var_08.label = param_00;
	var_08 thread audx_play_line_emitter_internal();
	level waittill(param_00 + "_line_emitter_stop");
	var_08 scalevolume(0,var_07);
	wait var_07;
	var_08 stoploopsound();
	wait 0.05;
	var_08 delete();
}

//Function Number: 175
aud_print_3d_on_ent(param_00,param_01,param_02)
{
	if(isdefined(self))
	{
		var_03 = (1,1,1);
		var_04 = (1,0,0);
		var_05 = (0,1,0);
		var_06 = (0,1,1);
		var_07 = 5;
		var_08 = var_03;
		if(isdefined(param_01))
		{
			var_07 = param_01;
		}

		if(isdefined(param_02))
		{
			var_08 = param_02;
			switch(var_08)
			{
				case "red":
					var_08 = var_04;
					break;

				case "white":
					var_08 = var_03;
					break;

				case "blue":
					var_08 = var_06;
					break;

				case "green":
					var_08 = var_05;
					break;

				default:
					var_08 = var_03;
					break;
			}
		}

		self endon("death");
		while(isdefined(self))
		{
			wait 0.05;
		}
	}
}