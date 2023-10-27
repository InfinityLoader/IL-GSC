/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: soundscripts\_audio_stream_manager.gsc
 * Game: Call of Duty: Modern Warfare Remastered
 * Platform: PC
 * Function Count: 13
 * Decompile Time: 198 ms
 * Timestamp: 10/27/2023 2:50:32 AM
*******************************************************************/

//Function Number: 1
sm_init()
{
	level._audio.stream = spawnstruct();
	level._audio.stream.music = spawnstruct();
	level._audio.stream.music.curr = smx_create_struct();
	level._audio.stream.music.prev = smx_create_struct();
	level._audio.stream.ambience = spawnstruct();
	level._audio.stream.ambience.curr = smx_create_struct();
	level._audio.stream.ambience.prev = smx_create_struct();
}

//Function Number: 2
sm_start_preset(param_00,param_01,param_02,param_03,param_04)
{
	if(!soundexists(param_00))
	{
		return;
	}

	var_06 = 1;
	if(isdefined(param_01))
	{
		var_06 = max(param_01,0);
	}

	var_07 = 1;
	if(isdefined(param_04))
	{
		var_07 = max(param_04,0);
	}

	smx_set_values_for_struct(level._audio.stream.ambience.prev,level._audio.stream.ambience.curr.name,level._audio.stream.ambience.curr.vol,level._audio.stream.ambience.curr.fade);
	smx_set_values_for_struct(level._audio.stream.ambience.curr,param_00,var_07,var_06);
	ambientplay(param_00,var_06,var_07);
}

//Function Number: 3
sm_start_music(param_00,param_01,param_02,param_03,param_04)
{
	if(!soundexists(param_00))
	{
		return;
	}

	var_06 = 1;
	if(isdefined(param_01))
	{
		var_06 = max(param_01,0);
	}

	var_07 = 1;
	if(isdefined(param_02))
	{
		var_07 = param_02;
	}

	var_08 = 1;
	if(isdefined(param_03))
	{
		var_08 = max(param_03,0);
	}

	smx_set_values_for_struct(level._audio.stream.music.prev,level._audio.stream.music.curr.name,level._audio.stream.music.curr.vol,level._audio.stream.music.curr.fade);
	smx_set_values_for_struct(level._audio.stream.music.curr,param_00,var_08,var_06);
	if(isdefined(param_04))
	{
		musicstop(var_07,param_04);
		musicplay(param_00,var_06,var_08,0);
		return;
	}

	musicplay(param_00,var_06,var_08);
}

//Function Number: 4
sm_stop_ambient_alias(param_00,param_01)
{
	if(param_00 != "none")
	{
		if(!soundexists(param_00))
		{
			return;
		}

		var_03 = 1;
		if(isdefined(param_01))
		{
			var_03 = max(param_01,0);
		}

		if(level._audio.stream.ambience.curr.name == param_00)
		{
			level._audio.stream.ambience.curr = level._audio.stream.ambience.prev;
			smx_clear_struct(level._audio.stream.ambience.prev);
		}
		else if(level._audio.stream.ambience.prev.name == param_00)
		{
			smx_clear_struct(level._audio.stream.ambience.prev);
		}

		ambientstop(var_03,param_00);
	}
}

//Function Number: 5
sm_stop_music_alias(param_00,param_01)
{
	if(!soundexists(param_00))
	{
		return;
	}

	var_03 = 1;
	if(isdefined(param_01))
	{
		var_03 = max(param_01,0);
	}

	if(level._audio.stream.music.curr.name == param_00)
	{
		level._audio.stream.music.curr = level._audio.stream.music.prev;
		smx_clear_struct(level._audio.stream.music.prev);
	}
	else if(level._audio.stream.ambience.prev.name == param_00)
	{
		smx_clear_struct(level._audio.stream.music.prev);
	}

	musicstop(var_03,param_00);
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

	smx_clear_struct(level._audio.stream.music.curr);
	smx_clear_struct(level._audio.stream.music.prev);
	musicstop(var_01);
}

//Function Number: 8
sm_mix_ambience(param_00)
{
	var_01 = 0.009;
	if(param_00.size == 1)
	{
		smx_set_values_for_struct(level._audio.stream.ambience.curr,param_00[0].alias,param_00[0].vol,param_00[0].fade);
	}
	else if(param_00.size == 2)
	{
		smx_set_values_for_struct(level._audio.stream.ambience.prev,param_00[0].alias,param_00[0].vol,param_00[0].fade);
		smx_set_values_for_struct(level._audio.stream.ambience.curr,param_00[1].alias,param_00[1].vol,param_00[1].fade);
	}

	for(var_06 = 0;var_06 < param_00.size;var_06++)
	{
		var_07 = param_00[var_06].alias;
		var_08 = max(param_00[var_06].vol,0);
		var_09 = clamp(param_00[var_06].fade,0,1);
		if(var_07 != "none")
		{
			if(!soundexists(var_07))
			{
				continue;
			}

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
	return level._audio.stream.ambience.curr.name;
}

//Function Number: 10
sm_get_current_music_name()
{
	return level._audio.stream.music.curr.name;
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