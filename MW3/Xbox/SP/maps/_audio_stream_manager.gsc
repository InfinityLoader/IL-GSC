/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\_audio_stream_manager.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: Console
 * Function Count: 13
 * Decompile Time: 194 ms
 * Timestamp: 10/27/2023 2:32:58 AM
*******************************************************************/

//Function Number: 1
sm_init()
{
	level._audio.stream = spawnstruct();
	level._audio.stream.music = spawnstruct();
	level._audio.stream.music.var_1042 = smx_create_struct();
	level._audio.stream.music.prev = smx_create_struct();
	level._audio.stream.var_1044 = spawnstruct();
	level._audio.stream.var_1044.var_1042 = smx_create_struct();
	level._audio.stream.var_1044.prev = smx_create_struct();
}

//Function Number: 2
func_1045(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = 1;
	if(isdefined(param_01))
	{
		var_05 = max(param_01,0);
	}

	var_06 = 1;
	if(isdefined(param_04))
	{
		var_06 = max(param_04,0);
	}

	smx_set_values_for_struct(level._audio.stream.var_1044.prev,level._audio.stream.var_1044.var_1042.name,level._audio.stream.var_1044.var_1042.vol,level._audio.stream.var_1044.var_1042.fade);
	smx_set_values_for_struct(level._audio.stream.var_1044.var_1042,param_00,var_06,var_05);
	ambientplay(param_00,var_05,var_06);
}

//Function Number: 3
func_1048(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = 1;
	if(isdefined(param_01))
	{
		var_05 = max(param_01,0);
	}

	var_06 = 1;
	if(isdefined(param_02))
	{
		var_06 = param_02;
	}

	var_07 = 1;
	if(isdefined(param_03))
	{
		var_07 = max(param_03,0);
	}

	smx_set_values_for_struct(level._audio.stream.music.prev,level._audio.stream.music.var_1042.name,level._audio.stream.music.var_1042.vol,level._audio.stream.music.var_1042.fade);
	smx_set_values_for_struct(level._audio.stream.music.var_1042,param_00,var_07,var_05);
	if(isdefined(param_04))
	{
		musicstop(var_06,param_04);
		musicplay(param_00,var_05,var_07,0);
		return;
	}

	musicplay(param_00,var_05,var_07);
}

//Function Number: 4
sm_stop_ambient_alias(param_00,param_01)
{
	if(param_00 != "none")
	{
		var_02 = 1;
		if(isdefined(param_01))
		{
			var_02 = max(param_01,0);
		}

		if(level._audio.stream.var_1044.var_1042.name == param_00)
		{
			level._audio.stream.var_1044.var_1042 = level._audio.stream.var_1044.prev;
			smx_clear_struct(level._audio.stream.var_1044.prev);
		}
		else if(level._audio.stream.var_1044.prev.name == param_00)
		{
			smx_clear_struct(level._audio.stream.var_1044.prev);
		}

		ambientstop(var_02,param_00);
	}
}

//Function Number: 5
sm_stop_music_alias(param_00,param_01)
{
	var_02 = 1;
	if(isdefined(param_01))
	{
		var_02 = max(param_01,0);
	}

	if(level._audio.stream.music.var_1042.name == param_00)
	{
		level._audio.stream.music.var_1042 = level._audio.stream.music.prev;
		smx_clear_struct(level._audio.stream.music.prev);
	}
	else if(level._audio.stream.var_1044.prev.name == param_00)
	{
		smx_clear_struct(level._audio.stream.music.prev);
	}

	musicstop(var_02,param_00);
}

//Function Number: 6
sm_stop_ambience(param_00)
{
	var_01 = 1;
	if(isdefined(param_00))
	{
		var_01 = param_00;
	}

	ambientstop(var_01);
}

//Function Number: 7
sm_stop_music(param_00)
{
	var_01 = 1;
	if(isdefined(param_00))
	{
		var_01 = param_00;
	}

	smx_clear_struct(level._audio.stream.music.var_1042);
	smx_clear_struct(level._audio.stream.music.prev);
	musicstop(var_01);
}

//Function Number: 8
sm_mix_ambience(param_00)
{
	var_01 = 0.009;
	if(param_00.size == 1)
	{
		smx_set_values_for_struct(level._audio.stream.var_1044.var_1042,param_00[0].alias,param_00[0].vol,param_00[0].fade);
	}
	else if(param_00.size == 2)
	{
		smx_set_values_for_struct(level._audio.stream.var_1044.prev,param_00[0].alias,param_00[0].vol,param_00[0].fade);
		smx_set_values_for_struct(level._audio.stream.var_1044.var_1042,param_00[1].alias,param_00[1].vol,param_00[1].fade);
	}

	for(var_06 = 0;var_06 < param_00.size;var_06++)
	{
		var_07 = param_00[var_06].alias;
		var_08 = max(param_00[var_06].vol,0);
		var_09 = clamp(param_00[var_06].fade,0,1);
		if(var_07 != "none")
		{
			if(var_08 < var_01)
			{
				ambientstop(var_09,var_07);
				continue;
			}

			ambientplay(var_07,var_09,var_08,0);
		}
	}
}

//Function Number: 9
sm_get_current_ambience_name()
{
	return level._audio.stream.var_1044.var_1042.name;
}

//Function Number: 10
sm_get_current_music_name()
{
	return level._audio.stream.music.var_1042.name;
}

//Function Number: 11
smx_set_values_for_struct(param_00,param_01,param_02,param_03)
{
	param_00.name = param_01;
	param_00.vol = param_02;
	param_00.fade = param_03;
}

//Function Number: 12
smx_create_struct()
{
	var_00 = spawnstruct();
	var_00.name = "";
	var_00.vol = 0;
	var_00.fade = 0;
	return var_00;
}

//Function Number: 13
smx_clear_struct(param_00)
{
	param_00.name = "";
	param_00.vol = 0;
	param_00.fade = 0;
}