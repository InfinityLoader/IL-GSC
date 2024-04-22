/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: sanfran_b_sonar_vision.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 11
 * Decompile Time: 161 ms
 * Timestamp: 4/22/2024 2:35:33 AM
*******************************************************************/

//Function Number: 1
main()
{
	precacheshader("nightvision_overlay_goggles");
	precacheshader("dpad_icon_nvg");
}

//Function Number: 2
monitor_vision_use()
{
	self endon("death");
	for(;;)
	{
		level.player waittill("sonar_vision");
		if(is_sonar_vision_on())
		{
			level.player thread sonar_vision_off();
		}
		else
		{
			level.player thread sonar_vision_on();
		}

		wait(1);
	}
}

//Function Number: 3
sonar_vision_on()
{
	level.player endon("death");
	level.player endon("sonar_vision_off");
	level.player notify("sonar_vision_on");
	level.player.sonar_vision = 1;
	for(;;)
	{
		thread detection_highlight_hud_effect(level.player);
		thread detect_enemies();
		wait(6);
		level notify("end_sonar_threads");
	}
}

//Function Number: 4
sonar_vision_off()
{
	level.player notify("sonar_vision_off");
	level.player.sonar_vision = undefined;
	level notify("end_sonar_threads");
}

//Function Number: 5
is_sonar_vision_on()
{
	return isdefined(level.player.sonar_vision) && level.player.sonar_vision;
}

//Function Number: 6
detect_enemies()
{
	level endon("end_sonar_threads");
	level.player endon("death");
	level.player endon("sonar_vision_off");
	var_00 = getaiarray("axis");
	foreach(var_02 in var_00)
	{
		if(distance(var_02.origin,self.origin) < 5000)
		{
			var_02 thread maps\_variable_grenade::handle_marking_guy("sonar_vision",5);
		}
	}
}

//Function Number: 7
detection_highlight_hud_effect(param_00)
{
	level endon("end_sonar_threads");
	level.player endon("death");
	level.player endon("sonar_vision_off");
	var_01 = newclienthudelem(param_00);
	var_01.color = (0.025,0.05,1);
	var_01.alpha = 0.01;
	var_02 = 5;
	var_01 setradarhighlight(var_02);
	var_01 thread destroy_radar_hud_elem_early();
	wait(var_02);
	var_01 destroy();
}

//Function Number: 8
detection_grenade_hud_effect(param_00)
{
	level endon("end_sonar_threads");
	level.player endon("death");
	level.player endon("sonar_vision_off");
	var_01 = newclienthudelem(param_00);
	var_01.x = param_00.origin[0];
	var_01.y = param_00.origin[1];
	var_01.z = param_00.origin[2];
	var_01.color = (0.025,0.05,1);
	var_01.alpha = 0.1;
	var_02 = 2;
	var_03 = 5000;
	var_04 = 1500;
	var_01 setradarping(int(var_03 + var_04 / 2),int(var_04),var_02 + 0.05);
	var_01 thread destroy_radar_hud_elem_early();
	wait(var_02);
	var_01 destroy();
}

//Function Number: 9
destroy_radar_hud_elem_early()
{
	level.player endon("death");
	self endon("death");
	level.player waittill("sonar_vision_off");
	self destroy();
}

//Function Number: 10
create_nvg_overlay(param_00,param_01,param_02)
{
	var_03 = newhudelem();
	var_03.x = 0;
	var_03.y = 0;
	var_03.sort = param_01;
	var_03.horzalign = "fullscreen";
	var_03.vertalign = "fullscreen";
	var_03.alpha = param_02;
	var_03 setshader(param_00,640,480);
	return var_03;
}

//Function Number: 11
wait_to_destroy_nvg_overlay()
{
	level.player endon("death");
	level.player waittill("sonar_vision_off");
	if(isdefined(self))
	{
		self destroy();
	}
}