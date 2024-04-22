/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: mp\mp_solar_aud.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 4
 * Decompile Time: 86 ms
 * Timestamp: 4/22/2024 2:18:24 AM
*******************************************************************/

//Function Number: 1
main()
{
}

//Function Number: 2
watchforlasermovement(param_00)
{
	array_sound_start();
	self endon("solar_reflector_player_removed");
	var_01 = 0.05;
	var_02 = 0;
	var_03 = self getplayerangles();
	var_04 = spawn("script_origin",level.solar_reflector_cam_tag.origin);
	var_04 linkto(level.solar_reflector_cam_tag);
	thread wait_for_laser_end(var_04);
	for(;;)
	{
		var_05 = self getplayerangles();
		var_06 = distance2d(var_05,var_03);
		if(var_06 > var_01)
		{
			if(!var_02)
			{
				var_04 playloopsound("mp_solar_array_player_move");
				var_04 scalevolume(0.7,0.1);
				var_02 = 1;
			}
		}
		else if(var_02)
		{
			var_04 scalevolume(0,0.3);
			var_04 stoploopsound();
			var_02 = 0;
		}

		var_03 = var_05;
		wait(0.05);
	}
}

//Function Number: 3
array_sound_start()
{
	playsoundatpos((1423.67,1543.22,64.4061),"mp_solar_array_generator");
}

//Function Number: 4
wait_for_laser_end(param_00)
{
	self waittill("solar_reflector_player_removed");
	param_00 stoploopsound();
	wait(0.25);
	param_00 delete();
}