/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps/mp/_snd_common_mp.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 30
 * Decompile Time: 473 ms
 * Timestamp: 10/27/2023 1:49:19 AM
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
			var_01 clientaddsoundsubmix("mp_init_mix");
			wait(0.05);
			var_01 clientaddsoundsubmix("mp_pre_event_mix");
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
			var_01 clientclearsoundsubmix("mp_pre_event_mix");
			wait(0.05);
			var_01 clientaddsoundsubmix("mp_post_event_mix");
			wait(0.05);
		}
	}
}

//Function Number: 4
snd_mp_player_join()
{
	self clientaddsoundsubmix("mp_init_mix");
	if(!isdefined(level._snd.dynamic_event_happened) || !level._snd.dynamic_event_happened)
	{
		self clientaddsoundsubmix("mp_pre_event_mix");
		return;
	}

	self clientclearsoundsubmix("mp_pre_event_mix");
	self clientaddsoundsubmix("mp_post_event_mix");
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
	snd_register_message("mp_exo_cloak_activate",::mp_exo_cloak_activate);
	snd_register_message("mp_exo_cloak_deactivate",::mp_exo_cloak_deactivate);
	snd_register_message("mp_exo_health_activate",::mp_exo_health_activate);
	snd_register_message("mp_exo_health_deactivate",::mp_exo_health_deactivate);
	snd_register_message("mp_regular_exo_hover",::mp_regular_exo_hover);
	snd_register_message("mp_suppressed_exo_hover",::mp_suppressed_exo_hover);
	snd_register_message("mp_exo_mute_activate",::mp_exo_mute_activate);
	snd_register_message("mp_exo_mute_deactivate",::mp_exo_mute_deactivate);
	snd_register_message("mp_exo_overclock_activate",::mp_exo_overclock_activate);
	snd_register_message("mp_exo_overclock_deactivate",::mp_exo_overclock_deactivate);
	snd_register_message("mp_exo_ping_activate",::mp_exo_ping_activate);
	snd_register_message("mp_exo_ping_deactivate",::mp_exo_ping_deactivate);
	snd_register_message("mp_exo_repulsor_activate",::mp_exo_repulsor_activate);
	snd_register_message("mp_exo_repulsor_deactivate",::mp_exo_repulsor_deactivate);
	snd_register_message("mp_exo_repulsor_repel",::mp_exo_repulsor_repel);
	snd_register_message("mp_exo_shield_activate",::mp_exo_shield_activate);
	snd_register_message("mp_exo_shield_deactivate",::mp_exo_shield_deactivate);
	snd_register_message("goliath_pod_burst",::mp_ks_goliath_pod_burst);
	snd_register_message("goliath_death_explosion",::mp_ks_goliath_death_explosion);
	snd_register_message("goliath_self_destruct",::mp_ks_goliath_self_destruct);
	snd_register_message("exo_knife_player_impact",::mp_wpn_exo_knife_player_impact);
}

//Function Number: 10
mp_exo_cloak_activate()
{
	self playsound("mp_exo_cloak_activate");
}

//Function Number: 11
mp_exo_cloak_deactivate()
{
	self playsound("mp_exo_cloak_deactivate");
}

//Function Number: 12
mp_exo_health_activate()
{
	self playsound("mp_exo_stim_activate");
}

//Function Number: 13
mp_exo_health_deactivate()
{
	self playsound("mp_exo_stim_deactivate");
}

//Function Number: 14
mp_regular_exo_hover()
{
	self playlocalsound("mp_exo_hover_activate");
	self playlocalsound("mp_exo_hover_fuel");
	self waittill("stop_exo_hover_effects");
	self playlocalsound("mp_exo_hover_deactivate");
	self stoplocalsound("mp_exo_hover_sup_fuel");
}

//Function Number: 15
mp_suppressed_exo_hover()
{
	self playlocalsound("mp_exo_hover_sup_activate");
	self playlocalsound("mp_exo_hover_sup_fuel");
	self waittill("stop_exo_hover_effects");
	self playlocalsound("mp_exo_hover_sup_deactivate");
	self stoplocalsound("mp_exo_hover_sup_fuel");
}

//Function Number: 16
mp_exo_mute_activate()
{
	self playlocalsound("mp_exo_mute_activate");
}

//Function Number: 17
mp_exo_mute_deactivate()
{
	self playlocalsound("mp_exo_mute_deactivate");
}

//Function Number: 18
mp_exo_overclock_activate()
{
	self playsound("mp_exo_overclock_activate");
}

//Function Number: 19
mp_exo_overclock_deactivate()
{
	self playsound("mp_exo_overclock_deactivate");
}

//Function Number: 20
mp_exo_ping_activate()
{
	self playlocalsound("mp_exo_ping_activate");
}

//Function Number: 21
mp_exo_ping_deactivate()
{
	self playsound("mp_exo_ping_deactivate");
}

//Function Number: 22
mp_exo_repulsor_activate()
{
	self playsound("mp_exo_trophy_activate");
}

//Function Number: 23
mp_exo_repulsor_deactivate()
{
	self playsound("mp_exo_trophy_deactivate");
}

//Function Number: 24
mp_exo_repulsor_repel()
{
	playsoundatpos(self.origin,"mp_exo_trophy_intercept");
}

//Function Number: 25
mp_exo_shield_activate()
{
	self playsound("mp_exo_shield_activate");
}

//Function Number: 26
mp_exo_shield_deactivate()
{
	self playsound("mp_exo_shield_deactivate");
}

//Function Number: 27
mp_wpn_exo_knife_player_impact()
{
	playsoundatpos(self.origin,"wpn_combatknife_stab_npc");
}

//Function Number: 28
mp_ks_goliath_pod_burst()
{
	self playlocalsound("goliath_suit_up_pod_burst");
}

//Function Number: 29
mp_ks_goliath_death_explosion()
{
	self playsound("goliath_death_destruct");
}

//Function Number: 30
mp_ks_goliath_self_destruct()
{
	self playsound("goliath_death_destruct");
}