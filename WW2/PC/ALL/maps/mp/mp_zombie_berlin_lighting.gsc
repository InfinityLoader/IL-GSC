/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\mp_zombie_berlin_lighting.gsc
 * Game: Call of Duty: WWII
 * Platform: PC
 * Function Count: 19
 * Decompile Time: 332 ms
 * Timestamp: 10/27/2023 3:17:35 AM
*******************************************************************/

//Function Number: 1
func_00F9()
{
	func_84F8();
	if(level.var_1D4 && getdvar("2695") != "true")
	{
		xbox_optimizations();
	}

	level thread maps\mp\_utility::func_6F74(::func_6B82);
	thread set_anchor_pulse_lights_off();
	thread set_airship_corrupsing_spark_off();
}

//Function Number: 2
func_84F8()
{
	setdvar("2973",0);
	setdvar("2664",1);
	setdvar("2225",8);
	setdvar("sm_spotDynamics",8);
}

//Function Number: 3
func_6B82()
{
	var_00 = self;
	var_00 endon("disconnect");
	wait(0.5);
	var_00 vignettesetparams(1,0.25,1,1,0);
	var_00 setclutforplayer("clut_zombie_berlin",0.1);
}

//Function Number: 4
set_default_scriptable_state()
{
	var_00 = getentarray("script_default_shadow_on","targetname");
	foreach(var_02 in var_00)
	{
		wait(0.1);
		var_02 setscriptablepartstate("lightpart","on");
	}
}

//Function Number: 5
set_dagger_step03_light()
{
	maps\mp\_utility::func_5C98("dagger_step03_light",1,3000);
}

//Function Number: 6
set_anchor_lights()
{
	var_00 = function_021F("anchor_light_scriptable","targetname");
	foreach(var_02 in var_00)
	{
		var_02 setscriptablepartstate("lightpart","on",0);
	}
}

//Function Number: 7
set_anchor_pulse_lights_off()
{
	var_00 = function_021F("anchor_light_scriptable","targetname");
	foreach(var_02 in var_00)
	{
		var_02 setscriptablepartstate("part_pulse_switch","off",0);
	}
}

//Function Number: 8
set_anchor_pulse_lights_on()
{
	var_00 = function_021F("anchor_light_scriptable","targetname");
	foreach(var_02 in var_00)
	{
		var_02 setscriptablepartstate("part_pulse_switch","on",0);
	}
}

//Function Number: 9
set_anchor_fast_pulse_lights()
{
	var_00 = function_021F("anchor_light_scriptable","targetname");
	foreach(var_02 in var_00)
	{
		var_02 setscriptablepartstate("part_pulse_switch","pulse_fast",0);
	}
}

//Function Number: 10
set_anchor_slow_pulse_lights()
{
	var_00 = function_021F("anchor_light_scriptable","targetname");
	foreach(var_02 in var_00)
	{
		var_02 setscriptablepartstate("part_pulse_switch","pulse_slow",0);
	}
}

//Function Number: 11
straub_death_start_lights()
{
	var_00 = function_021F("straub_lights_scriptable","targetname");
	foreach(var_02 in var_00)
	{
		var_02 setscriptablepartstate("light_straub","color_change_init",0);
	}
}

//Function Number: 12
straub_death_start_02_lights()
{
	var_00 = function_021F("straub_lights_02_scriptable","targetname");
	foreach(var_02 in var_00)
	{
		var_02 setscriptablepartstate("light_straub","color_change_init",0);
	}
}

//Function Number: 13
straub_death_kill_lights()
{
	wait(21);
	var_00 = function_021F("straub_lights_scriptable","targetname");
	foreach(var_02 in var_00)
	{
		var_02 setscriptablepartstate("light_straub","off",0);
	}
}

//Function Number: 14
straub_death_kill_fill_lights()
{
	wait(21);
	var_00 = function_021F("straub_fill_lights_scriptable","targetname");
	foreach(var_02 in var_00)
	{
		var_02 setscriptablepartstate("light_straub","off",0);
	}
}

//Function Number: 15
airship_alarm_lights()
{
	wait(21);
	var_00 = function_021F("airship_alarm_lights","targetname");
	foreach(var_02 in var_00)
	{
		var_02 setscriptablepartstate("lightpart","pulse",0);
	}

	var_04 = function_021F("airship_corrupsing_sparks","targetname");
	foreach(var_06 in var_04)
	{
		var_06 setscriptablepartstate("part_spark","flicker_on_1",0);
	}
}

//Function Number: 16
airship_lowering_light_intensity_control(param_00)
{
	var_01 = function_021F("airship_fill_control","targetname");
	foreach(var_03 in var_01)
	{
		var_03 setscriptablepartstate("lightpart",param_00,0);
	}
}

//Function Number: 17
xbox_optimizations()
{
	setdvar("1578",0);
	setdvar("5156",0);
	setdvar("3158",0.7);
	setdvar("2225",4);
	setdvar("sm_spotDynamics",4);
}

//Function Number: 18
neo_optimizations()
{
	setdvar("1578",1);
	setdvar("5156",1);
}

//Function Number: 19
set_airship_corrupsing_spark_off()
{
	var_00 = function_021F("airship_corrupsing_sparks","targetname");
	foreach(var_02 in var_00)
	{
		var_02 setscriptablepartstate("part_spark","initial_off",0);
	}
}