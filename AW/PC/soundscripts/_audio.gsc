/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: _audio.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 123
 * Decompile Time: 1402 ms
 * Timestamp: 4/22/2024 2:03:38 AM
*******************************************************************/

//Function Number: 1
aud_init(param_00)
{
	if(isdefined(param_00))
	{
		aud_set_level_fade_time(param_00);
	}

	soundscripts\_snd::snd_init();
	if(!isdefined(level.aud))
	{
		level.aud = spawnstruct();
	}

	if(!isdefined(level.script))
	{
		level.script = tolower(getdvar("mapname"));
	}

	if(!isdefined(level._audio))
	{
		level._audio = spawnstruct();
	}

	level._audio.using_string_tables = 0;
	level._audio.stringtables = [];
	level._audio.message_handlers = [];
	level._audio.progress_trigger_callbacks = [];
	level._audio.progress_maps = [];
	level._audio.vo_duck_active = 0;
	level._audio.sticky_threat = undefined;
	level._audio.player_state = spawnstruct();
	level._audio.player_state.locamote = "idle";
	level._audio.player_state.locamote_prev = "idle";
	level.ambient_reverb = [];
	level.ambient_track = [];
	level.fxfireloopmod = 1;
	level.reverb_track = "";
	level.eq_main_track = 0;
	level.eq_mix_track = 1;
	level.eq_track[level.eq_main_track] = "";
	level.eq_track[level.eq_mix_track] = "";
	soundscripts\_audio_stream_manager::sm_init();
	soundscripts\_audio_dynamic_ambi::damb_init();
	soundscripts\_audio_zone_manager::azm_init();
	thread soundscripts\_audio_mix_manager::mm_init();
	soundscripts\_audio_reverb::rvb_init();
	soundscripts\_audio_whizby::whiz_init();
	soundscripts\_audio_vehicle_manager::avm_init();
	soundscripts\_audio_music::mus_init();
	thread aud_level_fadein();
	deprecated_aud_register_msg_handler(::deprecated__audio_msg_handler);
}

//Function Number: 2
aud_set_level_fade_time(param_00)
{
	if(!isdefined(level._audio))
	{
		level._audio = spawnstruct();
	}

	level._audio.level_fade_time = param_00;
}

//Function Number: 3
aud_level_fadein()
{
	if(!isdefined(level._audio.level_fade_time))
	{
		level._audio.level_fade_time = 1;
	}

	wait(0.05);
	if(common_scripts\utility::flag_exist("chyron_video_done"))
	{
		common_scripts\utility::flag_wait("chyron_video_done");
	}

	levelsoundfade(1,level._audio.level_fade_time);
}

//Function Number: 4
aud_is_specops()
{
	return isdefined(level._audio.specops);
}

//Function Number: 5
audx_set_spec_ops()
{
	if(!isdefined(level._audio))
	{
		level._audio = spawnstruct();
	}

	level._audio.specops = 1;
}

//Function Number: 6
aud_set_spec_ops()
{
	thread audx_set_spec_ops();
}

//Function Number: 7
aud_stop_line_emitter(param_00)
{
	level notify(param_00 + "_line_emitter_stop");
}

//Function Number: 8
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
	var_08.point1 = param_02;
	var_08.point2 = param_03;
	var_08.fade_in = var_06;
	var_08.label = param_00;
	var_08 thread audx_play_line_emitter_internal();
	level waittill(param_00 + "_line_emitter_stop");
	var_08 scalevolume(0,var_07);
	wait(var_07);
	var_08 soundscripts\_snd_playsound::snd_stop_sound();
	wait(0.05);
	var_08 delete();
}

//Function Number: 9
audx_play_line_emitter_internal()
{
	level endon(self.label + "_line_emitter_stop");
	var_00 = self.point2 - self.point1;
	var_01 = vectornormalize(var_00);
	var_02 = distance(self.point1,self.point2);
	var_03 = 0.1;
	for(;;)
	{
		var_04 = level.player.origin - self.point1;
		var_05 = vectordot(var_04,var_01);
		var_05 = clamp(var_05,0,var_02);
		var_06 = self.point1 + var_01 * var_05;
		if(!self.is_playing)
		{
			self.origin = var_06;
			soundscripts\_snd_playsound::snd_play_loop(self.alias);
			self scalevolume(0);
			wait(0.05);
			self scalevolume(1,self.fade_in);
			self.is_playing = 1;
		}
		else
		{
			self moveto(var_06,var_03);
		}

		wait(var_03);
	}
}

//Function Number: 10
aud_play_point_source_loop(param_00,param_01,param_02,param_03)
{
	var_04 = aud_get_optional_param(1,param_02);
	var_05 = aud_get_optional_param(1,param_03);
	var_06 = spawn("script_origin",param_01);
	deprecated_aud_fade_sound_in(var_06,param_00,var_04,var_05,1);
	return var_06;
}

//Function Number: 11
aud_stop_point_source_loop(param_00,param_01)
{
	var_02 = aud_get_optional_param(1,param_01);
	aud_fade_out_and_delete(param_00,var_02);
}

//Function Number: 12
aud_set_point_source_loop_volume(param_00,param_01,param_02)
{
	param_01 = clamp(param_01,0,1);
	var_03 = aud_get_optional_param(1,param_02);
	param_00 scalevolume(param_01,var_03);
}

//Function Number: 13
aud_set_music_submix(param_00,param_01)
{
	if(param_00 == 1)
	{
		soundscripts\_audio_mix_manager::mm_make_submix_unsticky("music");
		soundscripts\_audio_mix_manager::mm_clear_submix("music",param_01);
	}
	else
	{
		soundscripts\_audio_mix_manager::mm_scale_submix("music",param_00,param_01);
		soundscripts\_audio_mix_manager::mm_make_submix_sticky("music");
	}

	level._audio.curr_music_submix = param_00;
}

//Function Number: 14
aud_set_ambi_submix(param_00,param_01)
{
	if(param_00 == 1)
	{
		soundscripts\_audio_mix_manager::mm_make_submix_unsticky("ambi");
		soundscripts\_audio_mix_manager::mm_clear_submix("ambi",param_01);
	}
	else
	{
		soundscripts\_audio_mix_manager::mm_scale_submix("ambi",param_00,param_01);
		soundscripts\_audio_mix_manager::mm_make_submix_sticky("ambi");
	}

	level._audio.curr_ambi_submix = param_00;
}

//Function Number: 15
aud_get_music_submix()
{
	var_00 = 1;
	if(isdefined(level._audio.curr_music_submix))
	{
		var_00 = level._audio.curr_music_submix;
	}

	return var_00;
}

//Function Number: 16
aud_get_ambi_submix()
{
	var_00 = 1;
	if(isdefined(level._audio.curr_ambi_submix))
	{
		var_00 = level._audio.curr_ambi_submix;
	}

	return var_00;
}

//Function Number: 17
trigger_multiple_audio_trigger(param_00)
{
	if(!isdefined(level._audio))
	{
		level._audio = spawnstruct();
	}

	if(!isdefined(level._audio.trigger_functions))
	{
		level._audio.trigger_functions = [];
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
			soundscripts\_audio_zone_manager::azm_start_zone(var_01[0],self.script_duration);
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

		if(isdefined(trigger_multiple_audio_get_target_ent_target()))
		{
			var_03 = trigger_multiple_audio_get_target_ent_origin();
			if(!isdefined(trigger_multiple_audio_get_target_ent_target_ent()))
			{
				aud_print_error("Audo Zone Trigger at " + self.origin + " has defined a target, " + trigger_multiple_audio_get_target_ent_target() + ", but that target doesn\'t exist.");
				return;
			}

			var_04 = trigger_multiple_audio_get_target_ent_target_ent_origin();
		}
		else
		{
			var_06 = common_scripts\utility::get_target_ent();
			var_07 = 2 * self.origin - var_06.origin;
			var_08 = vectortoangles(var_07);
			var_03 = trigger_multiple_audio_get_target_ent_origin();
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
			if(isdefined(var_01) && isdefined(var_01[0]) && isdefined(var_01[1]))
			{
				var_0A = soundscripts\_audio_zone_manager::azm_get_current_zone();
				if(var_0A == var_01[0])
				{
					var_09 = 0;
				}
				else if(var_0A == var_01[1])
				{
					var_09 = 1;
				}
				else if(var_0A != "")
				{
					var_0B = trigger_multiple_audio_progress(var_03,var_04,var_05,var_02.origin);
					if(var_0B < 0.5)
					{
						soundscripts\_audio_zone_manager::azm_start_zone(var_01[0]);
						var_09 = 0;
					}
					else
					{
						soundscripts\_audio_zone_manager::azm_start_zone(var_01[1]);
						var_09 = 1;
					}
				}
				else
				{
				}
			}
			else
			{
				var_0B = trigger_multiple_audio_progress(var_03,var_04,var_05,var_02.origin);
				if(var_0B < 0.5)
				{
					var_09 = 0;
				}
				else
				{
					var_09 = 1;
				}
			}

			if(!var_09)
			{
				if(isdefined(var_01) && isdefined(var_01[0]))
				{
					if(isdefined(level._snd) && isdefined(var_01[1]))
					{
						var_0C = "enter_" + var_01[1];
						soundscripts\_snd::snd_message("snd_zone_handler",var_0C,var_01[0]);
					}
					else if(isdefined(self.script_audio_enter_msg))
					{
						deprecated_aud_send_msg(self.script_audio_enter_msg,var_01[0]);
					}
				}
				else if(isdefined(self.script_audio_enter_msg))
				{
					deprecated_aud_send_msg(self.script_audio_enter_msg,"front");
				}

				if(isdefined(self.script_audio_enter_func))
				{
					if(isdefined(var_01) && isdefined(var_01[0]))
					{
						if(isdefined(level._audio.trigger_functions[self.script_audio_enter_func]))
						{
							[[ level._audio.trigger_functions[self.script_audio_enter_func] ]](var_01[0]);
						}
					}
					else if(isdefined(level._audio.trigger_functions[self.script_audio_enter_func]))
					{
						[[ level._audio.trigger_functions[self.script_audio_enter_func] ]]("front");
					}
				}
			}
			else
			{
				if(isdefined(var_01) && isdefined(var_01[1]))
				{
					if(isdefined(level._snd))
					{
						var_0C = "enter_" + var_01[1];
						soundscripts\_snd::snd_message("snd_zone_handler",var_0C,var_01[1]);
					}
					else if(isdefined(self.script_audio_enter_msg))
					{
						deprecated_aud_send_msg(self.script_audio_enter_msg,var_01[1]);
					}
				}
				else if(isdefined(self.script_audio_enter_msg))
				{
					deprecated_aud_send_msg(self.script_audio_enter_msg,"back");
				}

				if(isdefined(self.script_audio_enter_func))
				{
					if(isdefined(var_01) && isdefined(var_01[1]))
					{
						if(isdefined(level._audio.trigger_functions[self.script_audio_enter_func]))
						{
							[[ level._audio.trigger_functions[self.script_audio_enter_func] ]](var_01[1]);
						}
					}
					else if(isdefined(level._audio.trigger_functions[self.script_audio_enter_func]))
					{
						[[ level._audio.trigger_functions[self.script_audio_enter_func] ]]("back");
					}
				}
			}
		}
		else
		{
			if(isdefined(self.script_audio_enter_msg))
			{
				deprecated_aud_send_msg(self.script_audio_enter_msg);
			}

			if(isdefined(self.script_audio_enter_func))
			{
				if(isdefined(level._audio.trigger_functions[self.script_audio_enter_func]))
				{
					[[ level._audio.trigger_functions[self.script_audio_enter_func] ]]();
				}
			}
		}

		var_0D = undefined;
		if(isdefined(trigger_multiple_audio_get_zone_from(var_01,var_09)) && isdefined(trigger_multiple_audio_get_zone_to(var_01,var_09)))
		{
			var_0D = soundscripts\_audio_zone_manager::azmx_get_blend_args(trigger_multiple_audio_get_zone_from(var_01,var_09),trigger_multiple_audio_get_zone_to(var_01,var_09));
			if(isdefined(var_0D))
			{
				var_0D.mode = self.script_audio_blend_mode;
			}
		}

		if(isdefined(var_0D))
		{
			if(isdefined(var_0D.filter1) || isdefined(var_0D.filter2))
			{
				if(!level._audio.zone_mgr.overrides.filter_bypass)
				{
					soundscripts\_snd_filters::snd_clear_filter(0);
					soundscripts\_snd_filters::snd_clear_filter(1);
				}
			}
		}

		var_0E = -1;
		var_0B = -1;
		while(var_02 istouching(self))
		{
			if(isdefined(self.script_audio_point_func))
			{
				var_0F = trigger_multiple_audio_progress_point(var_03,var_04,var_02.origin);
				if(isdefined(level._audio.trigger_functions[self.script_audio_point_func]))
				{
					[[ level._audio.trigger_functions[self.script_audio_point_func] ]](var_0F);
				}
			}

			if(isdefined(var_03) && isdefined(var_04))
			{
				var_0B = trigger_multiple_audio_progress(var_03,var_04,var_05,var_02.origin);
				if(isdefined(self.script_audio_progress_map))
				{
					var_0B = deprecated_aud_map(var_0B,level._audio.progress_maps[self.script_audio_progress_map]);
				}

				if(var_0B != var_0E)
				{
					if(isdefined(trigger_multiple_audio_get_zone_from(var_01,var_09)) && isdefined(trigger_multiple_audio_get_zone_to(var_01,var_09)))
					{
						soundscripts\_audio_zone_manager::azm_print_enter_blend(trigger_multiple_audio_get_zone_from(var_01,var_09),trigger_multiple_audio_get_zone_to(var_01,var_09),var_0B);
					}

					if(isdefined(self.script_audio_progress_msg))
					{
						deprecated_aud_send_msg(self.script_audio_progress_msg,var_0B);
					}

					if(isdefined(self.script_audio_progress_func))
					{
						if(isdefined(level._audio.trigger_functions[self.script_audio_progress_func]))
						{
							[[ level._audio.trigger_functions[self.script_audio_progress_func] ]](var_0B);
						}
					}

					if(isdefined(var_0D))
					{
						trigger_multiple_audio_blend(var_0B,var_0D,var_09);
					}

					var_0E = var_0B;
					soundscripts\_audio_zone_manager::azm_print_progress(var_0B);
				}
			}

			if(isdefined(self.script_audio_update_rate))
			{
				wait(self.script_audio_update_rate);
				continue;
			}

			wait(0.1);
		}

		if(isdefined(var_03) && isdefined(var_04))
		{
			if(var_0B > 0.5)
			{
				if(isdefined(var_01) && isdefined(var_01[1]))
				{
					soundscripts\_audio_zone_manager::azm_set_current_zone(var_01[1]);
				}

				if(isdefined(var_01) && isdefined(var_01[1]))
				{
					if(isdefined(level._snd))
					{
						var_10 = "exit_" + var_01[1];
						soundscripts\_snd::snd_message("snd_zone_handler",var_10,var_01[1]);
					}
					else if(isdefined(self.script_audio_exit_msg))
					{
						deprecated_aud_send_msg(self.script_audio_exit_msg,var_01[1]);
					}
				}
				else if(isdefined(self.script_audio_exit_msg))
				{
					deprecated_aud_send_msg(self.script_audio_exit_msg,"back");
				}

				if(isdefined(self.script_audio_exit_func))
				{
					if(isdefined(var_01) && isdefined(var_01[1]))
					{
						if(isdefined(level._audio.trigger_functions[self.script_audio_exit_func]))
						{
							[[ level._audio.trigger_functions[self.script_audio_exit_func] ]](var_01[1]);
						}
					}
					else if(isdefined(level._audio.trigger_functions[self.script_audio_exit_func]))
					{
						[[ level._audio.trigger_functions[self.script_audio_exit_func] ]]("back");
					}
				}

				var_0B = 1;
			}
			else
			{
				if(isdefined(var_01) && isdefined(var_01[0]))
				{
					soundscripts\_audio_zone_manager::azm_set_current_zone(var_01[0]);
				}

				if(isdefined(var_01) && isdefined(var_01[0]))
				{
					if(isdefined(level._snd))
					{
						var_10 = "exit_" + var_01[1];
						soundscripts\_snd::snd_message("snd_zone_handler",var_10,var_01[0]);
					}
					else if(isdefined(self.script_audio_exit_msg))
					{
						deprecated_aud_send_msg(self.script_audio_exit_msg,var_01[0]);
					}
				}
				else if(isdefined(self.script_audio_exit_msg))
				{
					deprecated_aud_send_msg(self.script_audio_exit_msg,"front");
				}

				if(isdefined(self.script_audio_exit_func))
				{
					if(isdefined(var_01) && isdefined(var_01[0]))
					{
						if(isdefined(level._audio.trigger_functions[self.script_audio_exit_func]))
						{
							[[ level._audio.trigger_functions[self.script_audio_exit_func] ]](var_01[0]);
						}
					}
					else if(isdefined(level._audio.trigger_functions[self.script_audio_exit_func]))
					{
						[[ level._audio.trigger_functions[self.script_audio_exit_func] ]]("front");
					}
				}

				var_0B = 0;
			}

			if(isdefined(var_0D))
			{
				trigger_multiple_audio_blend(var_0B,var_0D,var_09);
			}

			continue;
		}

		if(isdefined(self.script_audio_exit_msg))
		{
			deprecated_aud_send_msg(self.script_audio_exit_msg);
		}

		if(isdefined(self.script_audio_exit_func))
		{
			if(isdefined(level._audio.trigger_functions[self.script_audio_exit_func]))
			{
				[[ level._audio.trigger_functions[self.script_audio_exit_func] ]]();
			}
		}
	}
}

//Function Number: 18
trigger_multiple_audio_progress(param_00,param_01,param_02,param_03)
{
	var_04 = vectornormalize(param_01 - param_00);
	var_05 = param_03 - param_00;
	var_06 = vectordot(var_05,var_04);
	var_06 = var_06 / param_02;
	return clamp(var_06,0,1);
}

//Function Number: 19
trigger_multiple_audio_progress_point(param_00,param_01,param_02)
{
	var_03 = vectornormalize(param_01 - param_00);
	var_04 = param_02 - param_00;
	var_05 = vectordot(var_04,var_03);
	return var_03 * var_05 + param_00;
}

//Function Number: 20
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
		soundscripts\_audio_zone_manager::azmx_blend_zones(var_04,var_05,param_01);
		return;
	}

	if(param_00 < 0.33)
	{
		soundscripts\_audio_zone_manager::azm_start_zone(param_01.zone_from_name);
		return;
	}

	if(param_00 > 0.66)
	{
		soundscripts\_audio_zone_manager::azm_start_zone(param_01.zone_to_name);
		return;
	}
}

//Function Number: 21
trigger_multiple_audio_register_callback(param_00)
{
	if(!isdefined(level._audio.trigger_functions))
	{
		level._audio.trigger_functions = [];
	}

	for(var_01 = 0;var_01 < param_00.size;var_01++)
	{
		var_02 = param_00[var_01];
		var_03 = var_02[0];
		var_04 = var_02[1];
		level._audio.trigger_functions[var_03] = var_04;
	}

	if(isdefined(level._audio.trigger_function_keys))
	{
		foreach(var_03 in level._audio.trigger_function_keys)
		{
		}

		level._audio.trigger_function_keys = undefined;
	}
}

//Function Number: 22
trigger_multiple_audio_get_target_ent_target()
{
	var_00 = common_scripts\utility::get_target_ent();
	return var_00.target;
}

//Function Number: 23
trigger_multiple_audio_get_target_ent_origin()
{
	var_00 = common_scripts\utility::get_target_ent();
	return var_00.origin;
}

//Function Number: 24
trigger_multiple_audio_get_target_ent_target_ent()
{
	var_00 = common_scripts\utility::get_target_ent();
	return var_00 common_scripts\utility::get_target_ent();
}

//Function Number: 25
trigger_multiple_audio_get_target_ent_target_ent_origin()
{
	var_00 = trigger_multiple_audio_get_target_ent_target_ent();
	return var_00.origin;
}

//Function Number: 26
trigger_multiple_audio_get_zone_from(param_00,param_01)
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

//Function Number: 27
trigger_multiple_audio_get_zone_to(param_00,param_01)
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

//Function Number: 28
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

	var_09 = audx_do_dynamic_explosion_math(var_07.origin,var_06.origin,param_03,param_04);
	var_09[0] = (var_09[0][0],var_09[0][1],var_06.origin[2]);
	var_09[1] = (var_09[1][0],var_09[1][1],var_06.origin[2]);
	var_0A = distance(var_07.origin,var_09[0]);
	if(!isdefined(param_05))
	{
		param_05 = 1800;
	}

	var_0B = var_0A / param_05;
	if(isdefined(var_09) && var_09.size == 2)
	{
		var_0C = spawn("script_origin",var_07.origin);
		var_0D = spawn("script_origin",var_07.origin);
		var_0C soundscripts\_snd_playsound::snd_play(param_01);
		var_0D soundscripts\_snd_playsound::snd_play(param_02);
		var_0C moveto(var_09[0],var_0B,0,0);
		var_0D moveto(var_09[1],var_0B,0,0);
	}
}

//Function Number: 29
audx_do_dynamic_explosion_math(param_00,param_01,param_02,param_03)
{
	var_04 = param_01 - param_00;
	var_05 = aud_copy_vector(var_04);
	var_06 = aud_copy_vector(var_04);
	var_07 = aud_vector_magnitude_2d(var_05);
	var_08 = 0.5 * param_02 / var_07;
	var_05 = aud_scale_vector_2d(var_05,var_08);
	var_06 = aud_scale_vector_2d(var_06,var_08);
	var_05 = aud_rotate_vector_yaw(var_05,90);
	var_06 = aud_rotate_vector_yaw(var_06,-90);
	var_09 = aud_vector_magnitude_2d(var_04);
	var_0A = param_03 / var_09;
	var_0B = aud_scale_vector_2d(var_04,var_0A);
	var_0B = var_0B + var_04;
	var_0B = var_0B + var_04;
	var_05 = var_05 + var_0B;
	var_06 = var_06 + var_0B;
	var_0C = [];
	var_0C[0] = var_05;
	var_0C[1] = var_06;
	return var_0C;
}

//Function Number: 30
aud_get_optional_param(param_00,param_01)
{
	var_02 = param_00;
	if(isdefined(param_01))
	{
		var_02 = param_01;
	}

	return var_02;
}

//Function Number: 31
aud_scale_vector_2d(param_00,param_01)
{
	return (param_00[0] * param_01,param_00[1] * param_01,param_00[2]);
}

//Function Number: 32
aud_scale_vector(param_00,param_01)
{
	return (param_00[0] * param_01,param_00[1] * param_01,param_00[2] * param_01);
}

//Function Number: 33
aud_rotate_vector_yaw(param_00,param_01)
{
	var_02 = param_00[0] * cos(param_01) - param_00[1] * sin(param_01);
	var_03 = param_00[0] * sin(param_01) + param_00[1] * cos(param_01);
	return (var_02,var_03,param_00[2]);
}

//Function Number: 34
aud_copy_vector(param_00)
{
	var_01 = (0,0,0);
	var_01 = var_01 + param_00;
	return var_01;
}

//Function Number: 35
aud_vector_magnitude_2d(param_00)
{
	return sqrt(param_00[0] * param_00[0] + param_00[1] * param_00[1]);
}

//Function Number: 36
aud_print_synch(param_00)
{
	aud_print(param_00,"synch_frame");
}

//Function Number: 37
aud_print(param_00,param_01)
{
}

//Function Number: 38
aud_print_warning(param_00)
{
	aud_print(param_00,"warning");
}

//Function Number: 39
aud_print_error(param_00)
{
	aud_print(param_00,"error");
}

//Function Number: 40
aud_print_debug(param_00)
{
	aud_print(param_00);
}

//Function Number: 41
aud_print_zone(param_00)
{
	aud_print(param_00,"zone");
}

//Function Number: 42
aud_print_zone_small(param_00)
{
	aud_print(param_00,"zone_small");
}

//Function Number: 43
equal_strings(param_00,param_01)
{
	if(isdefined(param_00) && isdefined(param_01))
	{
		return param_00 == param_01;
	}

	return !isdefined(param_00) && !isdefined(param_01);
}

//Function Number: 44
isundefined(param_00)
{
	return !isdefined(param_00);
}

//Function Number: 45
aud_fade_out_and_delete(param_00,param_01)
{
	param_00 scalevolume(0,param_01);
	param_00 common_scripts\utility::delaycall(param_01 + 0.05,::stopsounds);
	param_00 common_scripts\utility::delaycall(param_01 + 0.1,::delete);
}

//Function Number: 46
aud_fade_loop_out_and_delete(param_00,param_01)
{
	param_00 scalevolume(0,param_01);
	wait(param_01 + 0.05);
	param_00 stoploopsound();
	wait(0.05);
	param_00 delete();
}

//Function Number: 47
aud_min(param_00,param_01)
{
	if(param_00 <= param_01)
	{
		return param_00;
	}

	return param_01;
}

//Function Number: 48
aud_max(param_00,param_01)
{
	if(param_00 >= param_01)
	{
		return param_00;
	}

	return param_01;
}

//Function Number: 49
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

//Function Number: 50
aud_get_envelope_domain(param_00)
{
	if(isarray(param_00))
	{
		return [param_00[0][0],param_00[param_00.size - 1][0]];
	}

	return [param_00.env_array[0][0],param_00.env_array[param_00.env_array.size - 1][0]];
}

//Function Number: 51
aud_scale_envelope(param_00,param_01,param_02)
{
	param_01 = aud_get_optional_param(1,param_01);
	param_02 = aud_get_optional_param(1,param_02);
	for(var_03 = 0;var_03 < param_00.size;var_03++)
	{
		param_00[var_03][0] = param_00[var_03][0] * param_01;
		param_00[var_03][1] = param_00[var_03][1] * param_02;
	}

	return param_00;
}

//Function Number: 52
aud_smooth(param_00,param_01,param_02)
{
	return param_00 + param_02 * param_01 - param_00;
}

//Function Number: 53
aud_is_even(param_00)
{
	return param_00 == int(param_00 / 2) * 2;
}

//Function Number: 54
aud_fade_in_music(param_00)
{
	var_01 = 10;
	if(isdefined(param_00))
	{
		var_01 = param_00;
	}

	soundscripts\_audio_mix_manager::mm_add_submix("mute_music",0.1);
	wait(0.05);
	soundscripts\_audio_mix_manager::mm_clear_submix("mute_music",var_01);
}

//Function Number: 55
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

//Function Number: 56
aud_in_zone(param_00)
{
	return equal_strings(soundscripts\_audio_zone_manager::azm_get_current_zone(),param_00);
}

//Function Number: 57
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

//Function Number: 58
aud_duck(param_00,param_01,param_02,param_03)
{
	thread audx_duck(param_00,param_01,param_02,param_03);
}

//Function Number: 59
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

	soundscripts\_audio_mix_manager::mm_add_submix(param_00,var_04);
	wait(param_01);
	soundscripts\_audio_mix_manager::mm_clear_submix(param_00,var_05);
}

//Function Number: 60
aud_percent_chance(param_00)
{
	return randomintrange(1,100) <= param_00;
}

//Function Number: 61
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

		wait(0.05);
	}
}

//Function Number: 62
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

//Function Number: 63
aud_stop_slow_mo_gunshot_callback()
{
	level notify("aud_stop_slow_mo_gunshot");
}

//Function Number: 64
aud_wait_delay(param_00,param_01,param_02,param_03)
{
	if(isdefined(param_02))
	{
		var_04 = 60;
		if(isdefined(param_03))
		{
			var_04 = param_03;
		}

		var_05 = floor(param_00);
		var_06 = param_00 - var_05 * 100;
		param_00 = var_05 + var_06 * 1 / var_04;
	}

	var_07 = param_00;
	if(isdefined(param_01) && param_01)
	{
		aud_slomo_wait(var_07);
		return;
	}

	wait(var_07);
}

//Function Number: 65
aud_slomo_wait(param_00)
{
	var_01 = spawn("script_origin",(0,0,0));
	var_01 thread audx_slomo_wait(param_00);
	var_01 waittill("slo_mo_wait_done");
	var_01 delete();
}

//Function Number: 66
audx_slomo_wait(param_00)
{
	var_01 = 0;
	while(var_01 < param_00)
	{
		var_02 = getdvarfloat("com_timescale");
		var_01 = var_01 + 0.05 / var_02;
		wait(0.05);
	}

	self notify("slo_mo_wait_done");
}

//Function Number: 67
aud_print_3d_on_ent(param_00,param_01,param_02,param_03,param_04)
{
	if(isdefined(self))
	{
		var_05 = (1,1,1);
		var_06 = (1,0,0);
		var_07 = (0,1,0);
		var_08 = (0,1,1);
		var_09 = 5;
		var_0A = var_05;
		if(isdefined(param_01))
		{
			var_09 = param_01;
		}

		if(isdefined(param_02))
		{
			var_0A = param_02;
			switch(var_0A)
			{
				case "red":
					var_0A = var_06;
					break;

				case "white":
					var_0A = var_05;
					break;

				case "blue":
					var_0A = var_08;
					break;

				case "green":
					var_0A = var_07;
					break;

				default:
					var_0A = var_05;
					break;
			}
		}

		if(isdefined(param_04))
		{
			thread audx_print_3d_timer(param_04);
		}

		self endon("death");
		self endon("aud_stop_3D_print");
		while(isdefined(self))
		{
			var_0B = param_00;
			if(isdefined(param_03))
			{
				var_0B = var_0B + self [[ param_03 ]]();
			}

			wait(0.05);
		}
	}
}

//Function Number: 68
audx_print_3d_timer(param_00)
{
	self endon("death");
	wait(param_00);
	if(isdefined(self))
	{
		self notify("aud_stop_3D_print");
	}
}

//Function Number: 69
aud_add_progress_map(param_00,param_01)
{
	level._audio.progress_maps[param_00] = param_01;
}

//Function Number: 70
aud_get_progress_map(param_00)
{
	if(isdefined(level._audio.progress_maps[param_00]))
	{
		return level._audio.progress_maps[param_00];
	}
}

//Function Number: 71
is_deathsdoor_audio_enabled()
{
	if(!isdefined(level._audio.deathsdoor_enabled))
	{
		return 1;
	}

	return level._audio.deathsdoor_enabled;
}

//Function Number: 72
aud_enable_deathsdoor_audio()
{
	level.player.disable_breathing_sound = 0;
	level._audio.deathsdoor_enabled = 1;
}

//Function Number: 73
aud_disable_deathsdoor_audio()
{
	level.player.disable_breathing_sound = 1;
	level._audio.deathsdoor_enabled = 0;
}

//Function Number: 74
restore_after_deathsdoor()
{
	if(is_deathsdoor_audio_enabled() || isdefined(level._audio.in_deathsdoor))
	{
		level._audio.in_deathsdoor = undefined;
		soundscripts\_audio_mix_manager::mm_clear_submix("deaths_door",2);
		soundscripts\_snd_filters::snd_fade_out_filter(2);
		soundscripts\_audio_zone_manager::azm_set_filter_bypass(0);
		soundscripts\_snd_common::snd_disable_soundcontextoverride("deathsdoor");
		level notify("kill_deaths_door_audio");
		level.player setpainvisioneq(0);
		level.player deactivatereverb("snd_enveffectsprio_level",1);
		soundscripts\_audio_zone_manager::azm_set_reverb_bypass(0);
		soundscripts\_snd_playsound::snd_play_2d("deaths_door_exit");
	}
}

//Function Number: 75
set_deathsdoor()
{
	level._audio.in_deathsdoor = 1;
	if(!isdefined(level._audio.deathsdoor))
	{
		level._audio.deathsdoor = spawnstruct();
	}

	level._audio.deathsdoor.reverb = undefined;
	level._audio.deathsdoor.reverb = level._audio.current_reverb;
	if(is_deathsdoor_audio_enabled())
	{
		soundscripts\_audio_zone_manager::azm_set_filter_bypass(1);
		soundscripts\_audio_zone_manager::azm_set_reverb_bypass(1);
		level.player setreverb("snd_enveffectsprio_level","sewer",1,0.7,1);
		soundscripts\_audio_mix_manager::mm_add_submix("deaths_door",0.05);
		soundscripts\_snd_filters::snd_fade_in_filter("deathsdoor",0.5);
		soundscripts\_snd_common::snd_enable_soundcontextoverride("deathsdoor");
		soundscripts\_snd_playsound::snd_play_2d("deaths_door_breaths","kill_deaths_door_audio",undefined,0.25);
		soundscripts\_snd_playsound::snd_play_loop_2d("deaths_door_loop","kill_deaths_door_audio",0.05,1);
		level.player setpainvisioneq(1);
	}
}

//Function Number: 76
aud_set_mission_failed_music(param_00)
{
	level._audio.failed_music_alias = param_00;
}

//Function Number: 77
aud_wait_for_mission_fail_music()
{
	wait(0.05);
	while(!common_scripts\utility::flag_exist("missionfailed"))
	{
		wait(0.05);
	}

	var_00 = "shg_mission_failed_stinger";
	common_scripts\utility::flag_wait("missionfailed");
	if(isdefined(level._audio.failed_music_alias))
	{
		var_00 = level._audio.failed_music_alias;
	}

	if(soundexists(var_00))
	{
		soundscripts\_audio_music::mus_play(var_00,2,4);
	}
}

//Function Number: 78
aud_use_string_tables()
{
	level._audio.using_string_tables = 1;
	soundscripts\_audio_zone_manager::azm_use_string_table();
	soundscripts\_audio_reverb::rvb_use_string_table();
	soundscripts\_audio_dynamic_ambi::damb_use_string_table();
	soundscripts\_audio_whizby::whiz_use_string_table();
	soundscripts\_audio_whizby::whiz_set_preset("default");
}

//Function Number: 79
set_stringtable_mapname(param_00)
{
	soundscripts\_snd::snd_set_soundtable_name(param_00);
	aud_use_string_tables();
	level._audio.stringtables["map"] = param_00;
}

//Function Number: 80
get_stringtable_mapname()
{
	return soundscripts\_snd::snd_get_soundtable_name();
}

//Function Number: 81
set_damb_stringtable(param_00)
{
	level._audio.stringtables["damb"] = param_00;
}

//Function Number: 82
get_damb_stringtable()
{
	if(!isdefined(level._audio.stringtables["damb"]))
	{
		return "soundtables/" + level.script + ".csv";
	}

	return "soundtables/" + level._audio.stringtables["damb"];
}

//Function Number: 83
set_damb_component_stringtable(param_00)
{
	level._audio.stringtables["damb_comp"] = param_00;
}

//Function Number: 84
get_damb_component_stringtable(param_00)
{
	if(!isdefined(level._audio.stringtables["damb_comp"]))
	{
		return "soundtables/" + level.script + ".csv";
	}

	return "soundtables/" + level._audio.stringtables["damb_comp"];
}

//Function Number: 85
set_damb_loops_stringtable(param_00)
{
	level._audio.stringtables["damb_loops"] = param_00;
}

//Function Number: 86
get_damb_loops_stringtable(param_00)
{
	if(!isdefined(level._audio.stringtables["damb_loops"]))
	{
		return "soundtables/" + level.script + ".csv";
	}

	return "soundtables/" + level._audio.stringtables["damb_loops"];
}

//Function Number: 87
set_reverb_stringtable(param_00)
{
	level._audio.stringtables["reverb"] = param_00;
}

//Function Number: 88
get_reverb_stringtable()
{
	if(!isdefined(level._audio.stringtables["reverb"]))
	{
		return "soundtables/" + level.script + ".csv";
	}

	return "soundtables/" + level._audio.stringtables["reverb"];
}

//Function Number: 89
set_zone_stringtable(param_00)
{
	level._audio.stringtables["zone"] = param_00;
}

//Function Number: 90
get_zone_stringtable()
{
	if(!isdefined(level._audio.stringtables["zone"]))
	{
		return "soundtables/" + level.script + ".csv";
	}

	return "soundtables/" + level._audio.stringtables["zone"];
}

//Function Number: 91
aud_get_player_locamote_state()
{
	return level._audio.player_state.locamote;
}

//Function Number: 92
aud_get_threat_level(param_00,param_01,param_02)
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

//Function Number: 93
aud_get_sticky_threat()
{
	return level._audio.sticky_threat;
}

//Function Number: 94
aud_set_sticky_threat(param_00)
{
	level._audio.sticky_threat = param_00;
}

//Function Number: 95
aud_clear_sticky_threat()
{
	level._audio.sticky_threat = undefined;
}

//Function Number: 96
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

//Function Number: 97
deprecated_aud_fade_sound_in(param_00,param_01,param_02,param_03,param_04)
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
		param_00 soundscripts\_snd_playsound::snd_play_loop(param_01);
	}
	else
	{
		param_00 soundscripts\_snd_playsound::snd_play(param_01);
	}

	param_00 scalevolume(0);
	param_00 common_scripts\utility::delaycall(0.05,::scalevolume,param_02,param_03);
}

//Function Number: 98
deprecated_aud_map2(param_00,param_01)
{
	return piecewiselinearlookup(param_00,param_01);
}

//Function Number: 99
deprecated_aud_map(param_00,param_01)
{
	return piecewiselinearlookup(param_00,param_01);
}

//Function Number: 100
deprecated_aud_map_range(param_00,param_01,param_02,param_03)
{
	var_04 = param_00 - param_01 / param_02 - param_01;
	var_04 = clamp(var_04,0,1);
	return piecewiselinearlookup(var_04,param_03);
}

//Function Number: 101
deprecated_aud_register_msg_handler(param_00)
{
	level._audio.message_handlers[level._audio.message_handlers.size] = param_00;
}

//Function Number: 102
deprecated_audio_message(param_00,param_01,param_02)
{
	thread deprecated_audx_dispatch_msg(param_00,param_01,param_02);
}

//Function Number: 103
deprecated_aud_send_msg(param_00,param_01,param_02)
{
	deprecated_audio_message(param_00,param_01,param_02);
}

//Function Number: 104
deprecated_audx_dispatch_msg(param_00,param_01,param_02)
{
	var_03 = 0;
	var_04 = 0;
	foreach(var_06 in level._audio.message_handlers)
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

//Function Number: 105
aud_play_pcap_vo(param_00,param_01,param_02)
{
	var_03 = 0;
	var_04 = 1;
	var_05 = self;
	if(isdefined(param_02))
	{
		deprecated_aud_delay_play_2d_sound(param_00,param_01,var_03,var_04);
		return;
	}

	deprecated_aud_delay_play_linked_sound(param_00,var_05,param_01,var_03,var_04);
}

//Function Number: 106
deprecated_play_2d_sound_internal(param_00)
{
	soundscripts\_snd_playsound::snd_play(param_00,"sounddone");
	self waittill("sounddone");
	wait(0.05);
	self delete();
}

//Function Number: 107
deprecated_aud_delay_play_2d_sound_internal(param_00,param_01,param_02,param_03)
{
	aud_wait_delay(param_01,param_02,param_03);
	var_04 = spawn("script_origin",level.player.origin);
	var_04 thread deprecated_play_2d_sound_internal(param_00);
	return var_04;
}

//Function Number: 108
deprecated_aud_play_2d_sound(param_00)
{
	var_01 = spawn("script_origin",level.player.origin);
	var_01 thread deprecated_play_2d_sound_internal(param_00);
	return var_01;
}

//Function Number: 109
deprecated_aud_delay_play_2d_sound(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = thread deprecated_aud_delay_play_2d_sound_internal(param_00,param_01,param_02,param_03);
	return var_05;
}

//Function Number: 110
deprecated_aud_delay_play_linked_sound(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08)
{
	thread deprecated_aud_delay_play_linked_sound_internal(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08);
}

//Function Number: 111
deprecated_aud_delay_play_linked_sound_internal(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09)
{
	aud_wait_delay(param_02,param_03,param_04,param_05);
	thread deprecated_aud_play_linked_sound(param_00,param_01,param_06,param_07,param_08,param_09);
}

//Function Number: 112
deprecated_audx_play_linked_sound_internal(param_00,param_01,param_02,param_03,param_04)
{
	if(param_00 == "loop")
	{
		level endon(param_02 + "internal");
		soundscripts\_snd_playsound::snd_play_loop(param_01);
		level waittill(param_02);
		if(isdefined(self))
		{
			if(isdefined(param_04))
			{
				self scalevolume(0,param_04);
				wait(param_04);
			}

			soundscripts\_snd_playsound::snd_stop_sound();
			wait(0.05);
			self delete();
			return;
		}

		return;
	}

	if(param_00 == "oneshot")
	{
		soundscripts\_snd_playsound::snd_play(param_01,"sounddone");
		if(isdefined(param_03))
		{
			self scalevolume(param_03,0);
		}

		self waittill("sounddone");
		if(isdefined(self))
		{
			self delete();
			return;
		}
	}
}

//Function Number: 113
deprecated_audx_monitor_linked_entity_health(param_00,param_01,param_02)
{
	level endon(param_01);
	while(isdefined(self))
	{
		wait(0.1);
	}

	level notify(param_01 + "internal");
	if(isdefined(param_00))
	{
		if(isdefined(param_02))
		{
			param_00 scalevolume(0,param_02);
			wait(param_02);
		}

		param_00 soundscripts\_snd_playsound::snd_stop_sound();
		wait(0.05);
		param_00 delete();
	}
}

//Function Number: 114
deprecated_aud_play_linked_sound(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07)
{
	var_08 = "oneshot";
	if(isdefined(param_02))
	{
		var_08 = param_02;
	}

	var_09 = param_01.origin;
	if(isdefined(param_06))
	{
		var_09 = param_06;
	}

	var_0A = spawn("script_origin",var_09);
	if(isdefined(param_04))
	{
		var_0A linkto(param_01,"tag_origin",param_04,(0,0,0));
	}
	else
	{
		var_0A linkto(param_01);
	}

	if(var_08 == "loop")
	{
		param_01 thread deprecated_audx_monitor_linked_entity_health(var_0A,param_03,param_07);
	}

	var_0A thread deprecated_audx_play_linked_sound_internal(var_08,param_00,param_03,param_05,param_07);
	return var_0A;
}

//Function Number: 115
deprecated_aud_play_sound_at_internal(param_00,param_01,param_02)
{
	soundscripts\_snd_playsound::snd_play(param_00,"sounddone");
	if(isdefined(param_02))
	{
		wait(param_02);
		self stopsounds();
	}
	else
	{
		self waittill("sounddone");
	}

	wait(0.05);
	self delete();
}

//Function Number: 116
deprecated_aud_play_sound_at(param_00,param_01,param_02)
{
	var_03 = spawn("script_origin",param_01);
	var_03 thread deprecated_aud_play_sound_at_internal(param_00,param_01,param_02);
	return var_03;
}

//Function Number: 117
deprecated_aud_set_occlusion(param_00)
{
	soundscripts\_snd_filters::snd_set_occlusion(param_00);
}

//Function Number: 118
deprecated_aud_set_filter(param_00,param_01,param_02,param_03)
{
	soundscripts\_snd_filters::snd_set_filter(param_00,param_01,param_03);
}

//Function Number: 119
deprecated_aud_delete_on_sounddone()
{
	self waittill("sounddone");
	deprecated_delete_sound_entity();
}

//Function Number: 120
deprecated_delete_sound_entity()
{
	common_scripts\utility::delaycall(0.05,::delete);
}

//Function Number: 121
deprecated__audio_msg_handler(param_00,param_01)
{
	var_02 = 1;
	switch(param_00)
	{
		case "level_fade_to_black":
			var_03 = param_01[0];
			var_04 = param_01[1];
			wait(var_03);
			soundscripts\_audio_mix_manager::mm_start_preset("mute_all",var_04);
			break;

		case "generic_building_bomb_shake":
			level.player soundscripts\_snd_playsound::snd_play("sewer_bombs");
			break;

		case "start_player_slide_trigger":
			break;

		case "end_player_slide_trigger":
			break;

		case "missile_fired":
			break;

		case "msg_audio_fx_ambientExp":
			break;

		case "DEPRECATED_aud_play_sound_at":
			deprecated_aud_play_sound_at(param_01.alias,param_01.pos);
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
	
			aud_play_dynamic_explosion(param_01.explosion_pos,param_01.left_alias,param_01.right_alias,var_05,var_06,var_07);
			break;

		case "DEPRECATED_aud_play_conversation":
			deprecated_aud_play_conversation(param_00,param_01);
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
			deprecated_aud_handle_flickering_light(var_09);
			break;

		default:
			var_02 = 0;
			break;
	}

	return var_02;
}

//Function Number: 122
deprecated_aud_handle_flickering_light(param_00)
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

//Function Number: 123
deprecated_aud_play_conversation(param_00,param_01)
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
			wait(var_06.delay);
		}

		var_07 = spawn("script_origin",(0,0,0));
		var_07 linkto(var_06.ent,"",(0,0,0),(0,0,0));
		var_07 soundscripts\_snd_playsound::snd_play(var_06.sound,"sounddone");
		var_07 waittill("sounddone");
		wait(0.05);
		var_07 delete();
	}

	for(var_04 = 0;var_04 < var_02.size;var_04++)
	{
		var_02[var_04].ent.battlechatter = var_03[var_04];
	}
}