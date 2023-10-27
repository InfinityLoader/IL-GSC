/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\_audio_music.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: Console
 * Function Count: 12
 * Decompile Time: 186 ms
 * Timestamp: 10/27/2023 2:33:20 AM
*******************************************************************/

//Function Number: 1
mus_init()
{
	if(!isdefined(level._audio))
	{
		level._audio = spawnstruct();
	}

	level._audio.music = spawnstruct();
	level._audio.music.cue_cash = [];
	level._audio.music.curr_cue_name = "";
	level._audio.music.prev_cue_name = "";
	level._audio.music.var_116D = 0;
	level._audio.music.var_116E = [[0,0.5],[0.9,1],[1,1]];
	thread musx_monitor_game_vars();
}

//Function Number: 2
mus_play(param_00,param_01,param_02,param_03,param_04)
{
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
func_1170(param_00)
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
		musx_cash_cue(var_41);
	}

	return var_41;
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

	maps\_audio_stream_manager::func_1048(var_08["alias"],param_01,param_02,param_03,var_0A);
}

//Function Number: 8
musx_stop_all_music(param_00)
{
	maps\_audio_stream_manager::sm_stop_music(param_00);
}

//Function Number: 9
func_1176()
{
	return level._audio.music.var_116D;
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
	if(func_1176())
	{
		var_00 = 1;
		for(;;)
		{
			wait var_00;
			if(func_1176())
			{
				var_01 = maps\_audio::func_117A();
				var_02 = maps\_audio::func_117B(var_01,level._audio.music.var_116E);
			}
		}
	}
}