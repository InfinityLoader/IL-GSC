/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: mp\mp_laser2_aud.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 4
 * Decompile Time: 70 ms
 * Timestamp: 4/22/2024 2:17:52 AM
*******************************************************************/

//Function Number: 1
main()
{
	thread watch_for_underwater();
}

//Function Number: 2
watch_for_underwater()
{
	level endon("game_ended");
}

//Function Number: 3
start_rough_tide()
{
	wait(1.5);
	playsoundatpos((2382,44,140),"mp_laser2_wave_crashes_under_helipad_large");
	wait(5);
	thread play_interval_sound("mp_laser2_wave_crashes_under_helipad",(2265,-273,184),12,15);
	wait(6);
	thread play_interval_sound("mp_laser2_wave_crashes_under_helipad",(2554,188,181),11,20);
	wait(5);
	thread play_interval_sound("mp_laser2_wave_crashes_under_helipad",(2562,477,184),11,16);
}

//Function Number: 4
play_interval_sound(param_00,param_01,param_02,param_03)
{
	for(;;)
	{
		playsoundatpos(param_01,param_00);
		var_04 = level common_scripts\utility::waittill_any_timeout(randomintrange(param_02,param_03),"end_high_tide_waves");
		if(var_04 != "timeout")
		{
			return;
		}
	}
}