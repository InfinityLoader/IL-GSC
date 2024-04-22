/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: credits_s1_aud.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 13
 * Decompile Time: 205 ms
 * Timestamp: 4/22/2024 2:27:26 AM
*******************************************************************/

//Function Number: 1
main()
{
	config_system();
	init_snd_flags();
	init_globals();
	launch_threads();
	launch_loops();
	create_level_envelop_arrays();
	precache_presets();
	register_snd_messages();
}

//Function Number: 2
register_snd_messages()
{
	soundscripts\_snd::snd_register_message("snd_zone_handler",::zone_handler);
	soundscripts\_snd::snd_register_message("snd_music_handler",::music_handler);
	soundscripts\_snd::snd_register_message("play_credits",::play_credits);
}

//Function Number: 3
config_system()
{
	soundscripts\_audio::set_stringtable_mapname("shg");
	soundscripts\_snd_filters::snd_set_occlusion("med_occlusion");
}

//Function Number: 4
init_snd_flags()
{
}

//Function Number: 5
init_globals()
{
	level.aud = spawnstruct();
}

//Function Number: 6
launch_threads()
{
	if(soundscripts\_audio::aud_is_specops())
	{
	}
}

//Function Number: 7
launch_loops()
{
}

//Function Number: 8
create_level_envelop_arrays()
{
	level.aud.envs = [];
	level.aud.envs["example_envelop"] = [[0,0],[0.082,0.426],[0.238,0.736],[0.408,0.844],[0.756,0.953],[1,1]];
}

//Function Number: 9
precache_presets()
{
}

//Function Number: 10
zone_handler(param_00,param_01)
{
	switch(param_00)
	{
	}
}

//Function Number: 11
music(param_00,param_01)
{
	thread music_handler(param_00,param_01);
}

//Function Number: 12
music_handler(param_00,param_01)
{
	switch(param_00)
	{
		case "play_credits":
			wait(0.5);
			soundscripts\_audio_music::mus_play("mus_credits");
			break;

		default:
			soundscripts\_audio::aud_print_warning("\tMUSIC MESSAGE NOT HANDLED: " + param_00);
			break;
	}
}

//Function Number: 13
play_credits(param_00)
{
	music("play_credits");
}