/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\_ambient.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: PC
 * Function Count: 11
 * Decompile Time: 174 ms
 * Timestamp: 10/27/2023 2:22:00 AM
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

	maps\_audio::aud_set_filter(param_00,param_01);
}

//Function Number: 3
deactivate_index(param_00)
{
	level.eq_track[param_00] = "";
	level.player deactivateeq(param_00);
}

//Function Number: 4
blend_to_eq_track(param_00,param_01)
{
	var_02 = 1;
	if(isdefined(param_01))
	{
		var_02 = param_01;
	}

	var_03 = 0.05;
	var_04 = var_02 / var_03;
	var_05 = 1 / var_04;
	for(var_06 = 0;var_06 <= 1;var_06 = var_06 + var_05)
	{
		level.player seteqlerp(var_06,param_00);
		wait var_03;
	}

	level.player seteqlerp(1,param_00);
}

//Function Number: 5
use_reverb_settings(param_00)
{
	if(level.player maps\_utility::ent_flag("player_has_red_flashing_overlay"))
	{
		return;
	}

	lib_0086::func_1465(param_00);
}

//Function Number: 6
deactivate_reverb()
{
	lib_0086::func_146B();
}

//Function Number: 7
ambientdelay(param_00,param_01,param_02)
{
	maps\_audio::aud_print_warning("ambientDelay called, this is deprecated! Use new preset string tables.");
}

//Function Number: 8
ambientevent(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	maps\_audio::aud_print_warning("ambientEvent called, this is deprecated! Use new preset string tables.");
}

//Function Number: 9
ambienteventstart(param_00)
{
	maps\_audio::aud_print_warning("ambientEventStart called, this is deprecated! Use maps_utility::set_ambient( track, fade_ ).");
	maps\_utility::set_ambient(param_00);
}

//Function Number: 10
start_ambient_event(param_00)
{
	maps\_audio::aud_print_warning("start_ambient_event called, this is deprecated! Use maps_utility::set_ambient( track, fade_ ).");
	maps\_utility::set_ambient(param_00);
}

//Function Number: 11
get_progess(param_00,param_01,param_02,param_03)
{
	maps\_utility::get_progress(param_00,param_01,param_03,param_02);
}