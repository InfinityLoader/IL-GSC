/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: vehicle_scripts/_attack_drone_aud.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 4
 * Decompile Time: 44 ms
 * Timestamp: 10/27/2023 2:06:07 AM
*******************************************************************/

//Function Number: 1
attack_drone_queen_audio()
{
	var_00 = 0.1;
	var_01 = 3;
	var_02 = 5;
	var_03 = 0.05;
	var_04 = 0.85;
	var_05 = 1.2;
	if(!isdefined(level._snd))
	{
		level._snd = spawnstruct();
	}

	if(!isdefined(level._snd.queen_count))
	{
		level._snd.queen_count = 0;
	}

	if(level._snd.queen_count > var_01)
	{
		attack_drone_queen_1shot_handler(var_01);
		return;
	}

	if(!issubstr(self.classname,"queen"))
	{
		return;
	}

	level._snd.queen_count = level._snd.queen_count + 1;
	var_06 = self;
	var_07 = 20;
	var_08 = [[0,var_04],[var_07,var_05]];
	var_09 = ["attack_drone_queen_lp_near","attack_drone_queen_lp_med","attack_drone_queen_lp_dist"];
	var_0A = [];
	var_0B = "attack_drone_queen_audio_stop_notify" + soundscripts\_snd::snd_new_guid();
	var_0C = 0;
	foreach(var_0E in var_09)
	{
		var_0A[var_0E] = var_06 soundscripts\_snd_playsound::snd_play_loop_linked(var_0E,var_0B,var_02,var_02);
	}

	while(isdefined(var_06) && var_06.classname != "script_vehicle_corpse")
	{
		var_10 = var_06 vehicle_getspeed();
		if(var_10 > var_07)
		{
			var_07 = var_10;
			var_08[var_08.size - 1][0] = var_07;
		}

		var_10 = soundscripts\_audio::aud_smooth(var_0C,var_10,var_03);
		var_0C = var_10;
		var_11 = soundscripts\_snd::snd_map(var_10,var_08);
		foreach(var_13 in var_0A)
		{
			if(isdefined(var_13) && !isremovedentity(var_13))
			{
				var_13 scalepitch(var_11,var_00);
			}
		}

		wait(var_00);
	}

	level notify(var_0B);
	level._snd.queen_count = level._snd.queen_count - 1;
}

//Function Number: 2
attack_drone_kamikaze_audio()
{
	soundscripts\_snd_playsound::snd_play_linked("attack_drone_kamikazi","drone_kamikaze_crash");
	for(;;)
	{
		level waittill("drone_kamikaze_crash",var_00);
		if(isremovedentity(self))
		{
			break;
		}
	}

	if(level.player getcurrentweapon() == "weapon_suv_door_shield_fl")
	{
		soundscripts\_snd_playsound::snd_play_at("seo_drone_suicide_door",var_00);
	}
}

//Function Number: 3
attack_drone_queen_1shot_handler(param_00)
{
	if(!isdefined(level._snd.drone_swarm_queen))
	{
		var_01 = param_00 + 1;
		thread attack_drone_queen_flybys_audio(var_01);
	}
	else
	{
		var_01 = level._snd.drone_swarm_queen + 1;
		if(randomint(100) > 75)
		{
			thread attack_drone_queen_flybys_audio(var_01);
		}
	}

	level._snd.drone_swarm_queen = var_01;
}

//Function Number: 4
attack_drone_queen_flybys_audio(param_00)
{
	var_01 = "Q-" + param_00 + ":  ";
	var_02 = "drone_swarm_flyby";
	var_03 = [];
	var_03[0] = 500;
	var_03[1] = 1500;
	var_04 = [];
	var_04[0] = 20;
	thread soundscripts\_snd_common::snd_advanced_flyby_system(var_02,undefined,var_03,var_04,1,undefined,undefined,3,2);
}