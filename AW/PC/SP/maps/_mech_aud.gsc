/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps/_mech_aud.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 8
 * Decompile Time: 125 ms
 * Timestamp: 10/27/2023 1:59:49 AM
*******************************************************************/

//Function Number: 1
main()
{
	waittillframeend;
	register_snd_messages();
}

//Function Number: 2
register_snd_messages()
{
	if(isdefined(level._snd))
	{
		soundscripts\_snd::snd_register_message("snd_mech_emp_restart",::snd_mech_emp_restart);
		soundscripts\_snd::snd_register_message("snd_mech_add_rocketpack_raise",::snd_mech_add_rocketpack_raise);
		soundscripts\_snd::snd_register_message("snd_mech_add_rocketpack_lower",::snd_mech_add_rocketpack_lower);
	}
}

//Function Number: 3
snd_mech_emp_restart()
{
	soundscripts\_audio::deprecated_aud_play_linked_sound("mech_emp_restart",self);
}

//Function Number: 4
snd_mech_add_rocketpack_raise()
{
	soundscripts\_audio::deprecated_aud_play_linked_sound("mech_add_rocketpack_raise",self);
}

//Function Number: 5
snd_mech_add_rocketpack_lower()
{
	soundscripts\_audio::deprecated_aud_play_linked_sound("mech_add_rocketpack_lower",self);
}

//Function Number: 6
mech_movement(param_00,param_01)
{
	soundscripts\_audio::deprecated_aud_play_linked_sound(param_00,self);
}

//Function Number: 7
mech_fs_walk_slow(param_00)
{
	soundscripts\_audio::deprecated_aud_play_linked_sound("mech_fs_walk_slow",param_00);
}

//Function Number: 8
mech_metal_rattle(param_00)
{
	soundscripts\_audio::deprecated_aud_play_linked_sound("mech_metal_rattle",param_00);
}