/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: soundscripts\_ambient.gsc
 * Game: Call of Duty: Modern Warfare Remastered
 * Platform: PC
 * Function Count: 9
 * Decompile Time: 132 ms
 * Timestamp: 10/27/2023 2:50:16 AM
*******************************************************************/

//Function Number: 1
setup_new_eq_settings(param_00,param_01)
{
	if(!isdefined(param_00) || !isdefined(level.ambient_eq[param_00]))
	{
		deactivate_index(param_01);
		return 0;
	}

	if(level.eq_track[param_01] == param_00)
	{
		return 0;
	}

	level.eq_track[param_01] = param_00;
	use_eq_settings(param_00,param_01);
	return 1;
}

//Function Number: 2
use_eq_settings(param_00,param_01)
{
	if(level.player maps\_utility::ent_flag("player_has_red_flashing_overlay"))
	{
		return;
	}

	soundscripts\_snd_filters::snd_set_filter(param_00,param_01);
}

//Function Number: 3
deactivate_index(param_00)
{
	level.eq_track[param_00] = "";
	level.player deactivateeq(param_00);
}

//Function Number: 4
use_reverb_settings(param_00)
{
	if(level.player maps\_utility::ent_flag("player_has_red_flashing_overlay"))
	{
		return;
	}

	soundscripts\_audio_reverb::rvb_start_preset(param_00);
}

//Function Number: 5
deactivate_reverb()
{
	soundscripts\_audio_reverb::rvb_deactive_reverb();
}

//Function Number: 6
ambientdelay(param_00,param_01,param_02)
{
	soundscripts\_audio::aud_print_warning("ambientDelay called, this is deprecated! Use new preset string tables.");
}

//Function Number: 7
ambientevent(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	soundscripts\_audio::aud_print_warning("ambientEvent called, this is deprecated! Use new preset string tables.");
}

//Function Number: 8
ambienteventstart(param_00)
{
	soundscripts\_audio::aud_print_warning("ambientEventStart called, this is deprecated! Use maps_utility::set_ambient( track, fade_ ).");
	maps\_utility::set_ambient(param_00);
}

//Function Number: 9
start_ambient_event(param_00)
{
	soundscripts\_audio::aud_print_warning("start_ambient_event called, this is deprecated! Use maps_utility::set_ambient( track, fade_ ).");
	maps\_utility::set_ambient(param_00);
}