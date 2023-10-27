/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\_snd_common_mp.gsc
 * Game: Call of Duty: Modern Warfare Remastered
 * Platform: PC
 * Function Count: 10
 * Decompile Time: 174 ms
 * Timestamp: 10/27/2023 2:40:35 AM
*******************************************************************/

//Function Number: 1
init()
{
	snd_message_init();
	register_common_mp_snd_messages();
	thread snd_mp_mix_init();
}

//Function Number: 2
snd_mp_mix_init()
{
	level._snd.dynamic_event_happened = 0;
	if(isdefined(level.players) && level.players.size > 0)
	{
		foreach(var_01 in level.players)
		{
			var_01 method_84CF("mp_init_mix");
			wait(0.05);
			var_01 method_84CF("mp_pre_event_mix");
			wait(0.05);
		}
	}
}

//Function Number: 3
snd_mp_mix_post_event()
{
	level._snd.dynamic_event_happened = 1;
	if(isdefined(level.players) && level.players.size > 0)
	{
		foreach(var_01 in level.players)
		{
			var_01 method_84D0("mp_pre_event_mix");
			wait(0.05);
			var_01 method_84CF("mp_post_event_mix");
			wait(0.05);
		}
	}
}

//Function Number: 4
snd_mp_player_join()
{
	self method_84CF("mp_init_mix");
	if(!isdefined(level._snd.dynamic_event_happened) || !level._snd.dynamic_event_happened)
	{
		self method_84CF("mp_pre_event_mix");
		return;
	}

	self method_84D0("mp_pre_event_mix");
	self method_84CF("mp_post_event_mix");
}

//Function Number: 5
snd_message_init()
{
	if(!isdefined(level._snd))
	{
		level._snd = spawnstruct();
	}

	if(!isdefined(level._snd.messages))
	{
		level._snd.messages = [];
	}
}

//Function Number: 6
snd_register_message(param_00,param_01)
{
	level._snd.messages[param_00] = param_01;
}

//Function Number: 7
snd_music_message(param_00,param_01,param_02)
{
	level notify("stop_other_music");
	level endon("stop_other_music");
	if(isdefined(param_02))
	{
		childthread snd_message("snd_music_handler",param_00,param_01,param_02);
		return;
	}

	if(isdefined(param_01))
	{
		childthread snd_message("snd_music_handler",param_00,param_01);
		return;
	}

	childthread snd_message("snd_music_handler",param_00);
}

//Function Number: 8
snd_message(param_00,param_01,param_02,param_03)
{
	if(isdefined(level._snd.messages[param_00]))
	{
		if(isdefined(param_03))
		{
			thread [[ level._snd.messages[param_00] ]](param_01,param_02,param_03);
			return;
		}

		if(isdefined(param_02))
		{
			thread [[ level._snd.messages[param_00] ]](param_01,param_02);
			return;
		}

		if(isdefined(param_01))
		{
			thread [[ level._snd.messages[param_00] ]](param_01);
			return;
		}

		thread [[ level._snd.messages[param_00] ]]();
		return;
	}
}

//Function Number: 9
register_common_mp_snd_messages()
{
	snd_register_message("exo_knife_player_impact",::mp_wpn_exo_knife_player_impact);
}

//Function Number: 10
mp_wpn_exo_knife_player_impact()
{
	playsoundatpos(self.origin,"wpn_combatknife_stab_npc");
}