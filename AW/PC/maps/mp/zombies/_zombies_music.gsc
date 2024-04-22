/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: mp\zombies\_zombies_music.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 12
 * Decompile Time: 194 ms
 * Timestamp: 4/22/2024 2:14:38 AM
*******************************************************************/

//Function Number: 1
init()
{
	level.zmmusicents = [];
	var_00 = 3;
	for(var_01 = 0;var_01 < var_00;var_01++)
	{
		level.zmmusicents[var_01] = spawn("script_model",(0,0,0));
		level.zmmusicents[var_01] scalevolume(0);
		level.zmmusicents[var_01].index = var_01;
	}

	level.zmb_music_states = [];
	level.zmb_music_states_active = 1;
	level thread setupmusicstate(0,"round_start","zmb_mus_roundcount",0,0,0.5,0);
	level thread setupmusicstate(1,"round_normal",["zmb_mus_wave_01_lp","zmb_mus_wave_02_lp","zmb_mus_wave_03_lp"],0,1,1,1);
	level thread setupmusicstate(1,"round_zombie_dog",["zmb_mus_spec_01_lp","zmb_mus_spec_02_lp","zmb_mus_spec_03_lp"],0,1,1,1);
	level thread setupmusicstate(1,"round_zombie_host",["zmb_mus_spec_01_lp","zmb_mus_spec_02_lp","zmb_mus_spec_03_lp"],0,1,1,1);
	level thread setupmusicstate(0,"round_end","zmb_mus_roundfinish",0,0,0.5,0);
	level thread setupmusicstate(2,"round_intermission","zmb_mus_postround",0,1,1,0);
	level thread setupmusicstate(0,"game_over","zmb_mus_sweeper",0,0,0,0);
	level thread setupmusicstate(-1,"player_died","zmb_mus_deathsting",1,0,0,0);
	if(isdefined(level.customzombiemusicstates))
	{
		level thread [[ level.customzombiemusicstates ]]();
	}
}

//Function Number: 2
setupmusicstate(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	if(param_03)
	{
		param_00 = undefined;
	}

	if(!isdefined(level.zmb_music_states[param_01]))
	{
		level.zmb_music_states[param_01] = spawnstruct();
	}

	if(isarray(param_02))
	{
		level.zmb_music_states[param_01].alias = param_02[0];
		level.zmb_music_states[param_01].alias_list = param_02;
	}
	else
	{
		level.zmb_music_states[param_01].alias = param_02;
	}

	level.zmb_music_states[param_01].ent_num = param_00;
	level.zmb_music_states[param_01].is_looping = param_04;
	level.zmb_music_states[param_01].on_player = param_03;
	level.zmb_music_states[param_01].start_wait = param_05;
	level.zmb_music_states[param_01].stop_wait = param_06;
}

//Function Number: 3
changezombiemusic(param_00,param_01)
{
	if(!level.zmb_music_states_active)
	{
		return;
	}

	var_02 = level.zmb_music_states[param_00];
	if(!isdefined(var_02))
	{
		return;
	}

	if(isdefined(level.old_music_state))
	{
		if(level.old_music_state == var_02)
		{
			return;
		}
		else if(level.old_music_state == level.zmb_music_states["game_over"])
		{
			return;
		}
	}

	if(maps\mp\zombies\_util::getzombieslevelnum() == 4)
	{
		thread dimmallmusic(param_00,param_01);
	}

	thread _playmusic(var_02,param_01);
	level.old_music_state = var_02;
}

//Function Number: 4
dimmallmusicforplayer()
{
	self endon("disconnect");
	self clientaddsoundsubmix("h2o_dim_mall_music",2);
	wait(20);
	self clientclearsoundsubmix("h2o_dim_mall_music",5);
}

//Function Number: 5
dimmallmusic(param_00,param_01)
{
	if(param_00 == "player_died")
	{
		param_01 clientaddsoundsubmix("h2o_dim_mall_music",2);
		return;
	}

	foreach(param_01 in level.players)
	{
		param_01 thread dimmallmusicforplayer();
	}
}

//Function Number: 6
shouldskipplayingmusic(param_00)
{
	var_01 = 0;
	if(maps\mp\zombies\_util::getzombieslevelnum() == 4 && param_00 == level.zmb_music_states["round_start_hard_mode"])
	{
		var_01 = 1;
	}

	return param_00 != level.zmb_music_states["round_start"] && param_00 != level.zmb_music_states["round_end"] && !var_01 && isdefined(level.sq_song_ent) && maps\mp\zombies\_util::is_true(level.sq_song_ent.playing);
}

//Function Number: 7
aliasisdefined(param_00)
{
	if(soundexists(param_00))
	{
		return 1;
	}

	return 0;
}

//Function Number: 8
disablemusicstatechanges()
{
	level.zmb_music_states_active = 0;
}

//Function Number: 9
enablemusicstatechanges()
{
	level.zmb_music_states_active = 1;
}

//Function Number: 10
_playmusic(param_00,param_01)
{
	if(shouldskipplayingmusic(param_00))
	{
		return;
	}

	if(isdefined(param_00.start_wait) && param_00.start_wait > 0)
	{
		wait(param_00.start_wait);
	}

	if(param_00 == level.zmb_music_states["round_intermission"])
	{
		if(!aliasisdefined(param_00.alias))
		{
			return;
		}

		var_02 = level.zmmusicents[param_00.ent_num];
		var_02 playloopsound(param_00.alias);
		var_02 scalevolume(1,0.5);
		wait(10);
		var_02 scalevolume(0,5);
		wait(5);
		var_02 stoploopsound();
		return;
	}

	if(param_00.is_looping)
	{
		var_02 = level.zmmusicents[param_00.ent_num];
		var_03 = param_00.alias;
		if(isdefined(param_00.alias_list))
		{
			if(!isdefined(param_00.last_alias_index))
			{
				param_00.last_alias_index = randomint(param_00.alias_list.size);
			}
			else
			{
				param_00.last_alias_index = param_00.last_alias_index + 1 % param_00.alias_list.size;
			}

			var_03 = param_00.alias_list[param_00.last_alias_index];
			param_00.alias = var_03;
		}

		if(!aliasisdefined(var_03))
		{
			return;
		}

		var_02 playloopsound(var_03);
		var_02 scalevolume(1);
		thread _stoponroundend(var_02,param_00);
		if(level.roundtype == "normal")
		{
			thread _stopontimeelapsed(var_02,param_00);
			return;
		}

		return;
	}

	if(param_00.on_player)
	{
		if(!aliasisdefined(param_00.alias))
		{
			return;
		}

		param_01 playsoundtoplayer(param_00.alias,param_01);
		return;
	}

	if(!aliasisdefined(param_00.alias))
	{
		return;
	}

	var_02 = level.zmmusicents[param_00.ent_num];
	var_02 playsoundonmovingent(param_00.alias);
	var_02 scalevolume(1);
}

//Function Number: 11
_stoponroundend(param_00,param_01)
{
	level endon("zombie_stopOnTimeElapsed");
	level waittill("zombie_wave_ended");
	if(isdefined(param_01.stop_wait) && param_01.stop_wait > 0)
	{
		wait(param_01.stop_wait);
	}

	param_00 scalevolume(0,2);
	wait(2);
	param_00 stoploopsound();
	param_00 scalevolume(1);
}

//Function Number: 12
_stopontimeelapsed(param_00,param_01)
{
	level endon("zombie_wave_ended");
	wait(20);
	param_00 scalevolume(0,20);
	wait(20);
	param_00 stoploopsound();
	param_00 scalevolume(1);
	level notify("zombie_stopOnTimeElapsed");
}