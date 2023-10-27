/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: soundscripts\_audio_music.gsc
 * Game: Call of Duty: Modern Warfare Remastered
 * Platform: PC
 * Function Count: 25
 * Decompile Time: 428 ms
 * Timestamp: 10/27/2023 2:50:28 AM
*******************************************************************/

//Function Number: 1
mus_init()
{
	ams_init();
	if(!isdefined(level._audio))
	{
		level._audio = spawnstruct();
	}

	level._audio.music = spawnstruct();
	level._audio.music.cue_cash = [];
	level._audio.music.curr_cue_name = "";
	level._audio.music.prev_cue_name = "";
	level._audio.music.enable_auto_mix = 0;
	level._audio.music.env_threat_to_vol = [[0,0.5],[0.9,1],[1,1]];
	thread musx_monitor_game_vars();
}

//Function Number: 2
mus_play(param_00,param_01,param_02,param_03,param_04)
{
	if(!soundexists(param_00))
	{
		return;
	}

	var_05 = undefined;
	var_06 = mus_get_playing_cue_preset();
	var_07 = musx_construct_cue(param_00);
	var_08 = var_07["fade_in_time"];
	if(isdefined(param_01))
	{
		var_08 = param_01;
	}

	var_09 = 2;
	if(isdefined(var_06))
	{
		if(isdefined(param_02))
		{
			var_09 = param_02;
		}
		else if(isdefined(param_01))
		{
			var_09 = param_01;
		}
		else if(isdefined(var_06["fade_out_time"]))
		{
			var_09 = var_06["fade_out_time"];
		}
	}

	var_0A = var_07["volume"];
	if(isdefined(param_03))
	{
		var_0A = param_03;
	}

	musx_start_cue(var_07["name"],var_08,var_09,var_0A,param_04);
}

//Function Number: 3
mus_stop(param_00)
{
	var_01 = 3;
	if(mus_is_playing())
	{
		var_02 = musx_get_cashed_cue(level._audio.music.curr_cue_name);
		var_01 = var_02["fade_out_time"];
	}

	if(isdefined(param_00))
	{
		var_01 = param_00;
	}

	musx_stop_all_music(var_01);
}

//Function Number: 4
mus_is_playing()
{
	return isdefined(level._audio.music.curr_cue_name) && level._audio.music.curr_cue_name != "";
}

//Function Number: 5
mus_get_playing_cue_preset()
{
	var_00 = undefined;
	if(mus_is_playing())
	{
		var_00 = musx_get_cashed_cue(level._audio.music.curr_cue_name);
	}

	return var_00;
}

//Function Number: 6
musx_construct_cue(param_00)
{
	var_01 = musx_get_cashed_cue(param_00);
	if(!isdefined(var_01))
	{
		var_01 = [];
		var_01["alias"] = param_00;
		var_01["volume"] = 1;
		var_01["fade_in_time"] = 1.5;
		var_01["fade_out_time"] = 1.5;
		var_01["auto_mix"] = 0;
		var_01["name"] = param_00;
		musx_cash_cue(var_01);
	}

	return var_01;
}

//Function Number: 7
musx_start_cue(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = 0;
	if(isdefined(param_04))
	{
		var_05 = param_04;
	}

	if(param_00 == level._audio.music.curr_cue_name && !var_05)
	{
		return;
	}

	var_06 = level._audio.music.prev_cue_name;
	var_07 = level._audio.music.curr_cue_name;
	level._audio.music.prev_cue_name = level._audio.music.curr_cue_name;
	level._audio.music.curr_cue_name = param_00;
	var_08 = musx_get_cashed_cue(level._audio.music.curr_cue_name);
	var_09 = musx_get_cashed_cue(level._audio.music.prev_cue_name);
	var_0A = undefined;
	if(isdefined(var_09))
	{
		var_0A = var_09["alias"];
	}

	soundscripts\_audio_stream_manager::sm_start_music(var_08["alias"],param_01,param_02,param_03,var_0A);
}

//Function Number: 8
musx_stop_all_music(param_00)
{
	soundscripts\_audio_stream_manager::sm_stop_music(param_00);
}

//Function Number: 9
musx_get_auto_mix()
{
	return level._audio.music.enable_auto_mix;
}

//Function Number: 10
musx_get_cashed_cue(param_00)
{
	return level._audio.music.cue_cash[param_00];
}

//Function Number: 11
musx_cash_cue(param_00)
{
	level._audio.music.cue_cash[param_00["name"]] = param_00;
}

//Function Number: 12
musx_monitor_game_vars()
{
	if(musx_get_auto_mix())
	{
		var_00 = 1;
		for(;;)
		{
			wait(var_00);
			if(musx_get_auto_mix())
			{
				var_01 = soundscripts\_audio::aud_get_threat_level();
				var_02 = soundscripts\_audio::deprecated_aud_map(var_01,level._audio.music.env_threat_to_vol);
			}
		}
	}
}

//Function Number: 13
ams_init()
{
	level._snd._ams = spawnstruct();
	level._snd._ams.curr_intensity = 0;
	level._snd._ams.curr_state = "";
	soundscripts\_snd::snd_register_message("ams_start",::ams_start);
	soundscripts\_snd::snd_register_message("ams_stop",::ams_stop);
	soundscripts\_snd::snd_register_message("ams_set_state",::ams_set_state);
	soundscripts\_snd::snd_register_message("ams_set_proxy_vehicle",::ams_set_proxy_vehicle);
	soundscripts\_snd::snd_register_message("ams_set_intensity",::ams_set_intensity);
	soundscripts\_audio_vehicle_manager::avm_register_callback("ams_intensity",::ams_intensity);
	soundscripts\_audio_vehicle_manager::avm_register_callback("ams_proxy_vehicle_speed",::ams_proxy_vehicle_speed);
}

//Function Number: 14
ams_start(param_00,param_01,param_02,param_03)
{
	var_04 = amsx_get();
	var_04.proxy = soundscripts\_audio_vehicle_manager::avm_create_vehicle_proxy();
	var_05 = 3;
	var_06 = 3;
	if(isdefined(param_00) && !isstring(param_00))
	{
		var_07 = param_00;
		param_00 = var_07.preset_name;
		param_01 = var_07.initial_state;
		param_02 = var_07.fadein_time;
		param_03 = var_07.fadeout_time;
	}
	else
	{
	}

	ams_set_state(param_01);
	var_08 = spawnstruct();
	var_08.preset_name = param_00;
	var_08.fadein_time = soundscripts\_audio::aud_get_optional_param(var_05,param_02);
	var_08.fadeout_time = soundscripts\_audio::aud_get_optional_param(var_06,param_03);
	var_04.proxy soundscripts\_snd::snd_message("snd_start_vehicle",var_08);
}

//Function Number: 15
ams_stop(param_00)
{
	param_00 = soundscripts\_audio::aud_get_optional_param(3,param_00);
	var_01 = amsx_get_proxy();
	var_01 soundscripts\_snd::snd_message("snd_stop_vehicle",param_00);
	var_01 delete();
}

//Function Number: 16
ams_get_state()
{
	return level._snd._ams.curr_state;
}

//Function Number: 17
ams_set_state(param_00)
{
	level._snd._ams.curr_state = param_00;
}

//Function Number: 18
ams_set_intensity(param_00)
{
	var_01 = amsx_get();
	var_01.curr_intensity = param_00;
}

//Function Number: 19
ams_set_proxy_vehicle(param_00)
{
	level._snd._ams.proxy.veh_ent = param_00;
}

//Function Number: 20
ams_intensity()
{
	return amsx_get().curr_intensity;
}

//Function Number: 21
ams_player_health()
{
	return level.player.health;
}

//Function Number: 22
ams_proxy_vehicle_speed()
{
	var_00 = 0;
	var_01 = soundscripts\_audio_vehicle_manager::avmx_get_vehicle_entity();
	var_02 = amsx_get_proxy_vehicle_ent();
	if(isdefined(var_02))
	{
		var_00 = var_02 vehicle_getspeed();
	}

	return var_00;
}

//Function Number: 23
amsx_get()
{
	return level._snd._ams;
}

//Function Number: 24
amsx_get_proxy()
{
	return level._snd._ams.proxy;
}

//Function Number: 25
amsx_get_proxy_vehicle_ent()
{
	var_00 = undefined;
	var_01 = amsx_get_proxy();
	if(isdefined(var_01))
	{
		var_00 = level._snd._ams.proxy.veh_ent;
	}

	return var_00;
}