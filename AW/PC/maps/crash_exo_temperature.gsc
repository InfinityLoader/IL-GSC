/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: crash_exo_temperature.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 9
 * Decompile Time: 142 ms
 * Timestamp: 4/22/2024 2:27:09 AM
*******************************************************************/

//Function Number: 1
precache_exo_temperature()
{
	precacheshader("hud_exo_temp_bg");
	precacheshader("hud_exo_temp_warning");
	precacheshader("overlay_frozen_2");
	precachestring(&"temperature_fade_out");
	precachestring(&"temperature_fade_in");
	precachestring(&"temperature_warning_blink");
	precachestring(&"temperature_warning_hide");
}

//Function Number: 2
create_exo_temperature_hud(param_00)
{
	setomnvar("ui_temperaturegauge_hud",1);
	level.player setclientomnvar("ui_temperaturegauge_external",param_00);
	level.body_temp = 98.6;
	level.exo_temp = param_00 + 25;
	level.exo_temperature_hud = [];
	level.exo_temperature_hud["overlay"] = newhudelem();
	level.exo_temperature_hud["overlay"].x = 0;
	level.exo_temperature_hud["overlay"].y = 0;
	level.exo_temperature_hud["overlay"] setshader("overlay_frozen_2",640,480);
	level.exo_temperature_hud["overlay"].sort = 50;
	level.exo_temperature_hud["overlay"].lowresbackground = 1;
	level.exo_temperature_hud["overlay"].alignx = "left";
	level.exo_temperature_hud["overlay"].aligny = "top";
	level.exo_temperature_hud["overlay"].horzalign = "fullscreen";
	level.exo_temperature_hud["overlay"].vertalign = "fullscreen";
	level.exo_temperature_hud["overlay"].alpha = 0;
	foreach(var_02 in level.exo_temperature_hud)
	{
		var_02.hidewheninmenu = 1;
	}

	thread monitor_temperature();
}

//Function Number: 3
remove_exo_temperature_hud(param_00)
{
	level notify("remove_exo_temperature_hud");
	if(isdefined(param_00) && param_00 > 0)
	{
		luinotifyevent(&"temperature_fade_out",1,int(param_00 * 1000));
		foreach(var_02 in level.exo_temperature_hud)
		{
			var_02 fadeovertime(param_00);
			var_02.alpha = 0;
		}

		wait(param_00);
	}

	foreach(var_02 in level.exo_temperature_hud)
	{
		var_02 destroy();
	}

	level.exo_temperature_hud = undefined;
	setomnvar("ui_temperaturegauge_hud",0);
}

//Function Number: 4
monitor_temperature()
{
	level endon("remove_exo_temperature_hud");
	var_00 = 98.6;
	var_01 = 96;
	var_02 = 92.5;
	var_03 = 97;
	var_04 = 91.5;
	var_05 = 0;
	for(;;)
	{
		level.exo_temperature_hud["overlay"].alpha = 1 - clamp(level.body_temp - var_04 / var_03 - var_04,0,1);
		if(level.body_temp < var_01 && !var_05)
		{
			luinotifyevent(&"temperature_warning_blink",1,500);
			var_05 = 1;
		}
		else if(level.body_temp > var_01 && var_05)
		{
			luinotifyevent(&"temperature_warning_hide",1,100);
			var_05 = 0;
		}

		wait(0.05);
	}
}

//Function Number: 5
activate_heater()
{
}

//Function Number: 6
deactivate_heater()
{
}

//Function Number: 7
set_exo_temperature_over_time(param_00,param_01)
{
	level notify("set_exo_temperature");
	level endon("set_exo_temperature");
	level endon("remove_exo_temperature_hud");
	var_02 = param_00 - level.exo_temp / param_01 * 0.05;
	while(param_01 > 0)
	{
		level.exo_temp = level.exo_temp + var_02;
		param_01 = param_01 - 0.05;
		wait(0.05);
	}

	level.exo_temp = param_00;
}

//Function Number: 8
set_operator_temperature_over_time(param_00,param_01)
{
	level notify("set_operator_temperature");
	level endon("set_operator_temperature");
	level endon("remove_exo_temperature_hud");
	var_02 = param_00 - level.body_temp / param_01 * 0.05;
	while(param_01 > 0)
	{
		level.body_temp = level.body_temp + var_02;
		param_01 = param_01 - 0.05;
		wait(0.05);
	}

	level.body_temp = param_00;
}

//Function Number: 9
set_external_temperature_over_time(param_00,param_01)
{
	level notify("set_external_temperature");
	level endon("set_external_temperature");
	level endon("remove_exo_temperature_hud");
	var_02 = param_00 - level.player getclientomnvar("ui_temperaturegauge_external") / param_01 * 0.05;
	while(param_01 > 0)
	{
		level.player setclientomnvar("ui_temperaturegauge_external",level.player getclientomnvar("ui_temperaturegauge_external") + var_02);
		param_01 = param_01 - 0.05;
		wait(0.05);
	}

	level.player setclientomnvar("ui_temperaturegauge_external",param_00);
}