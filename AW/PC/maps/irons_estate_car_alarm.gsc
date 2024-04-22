/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: irons_estate_car_alarm.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 7
 * Decompile Time: 109 ms
 * Timestamp: 4/22/2024 2:31:45 AM
*******************************************************************/

//Function Number: 1
car_alarm_main(param_00,param_01)
{
	var_02 = getentarray(param_00,"targetname");
	var_02 = maps\_utility::remove_without_classname(var_02,"trigger_multiple");
	foreach(var_04 in var_02)
	{
		var_05 = getent(var_04.script_linkto,"script_linkname");
		var_05 setcandamage(1);
		var_05 setcanradiusdamage(1);
		var_05.health = 99999999;
		var_04 thread car_alarm_setup(var_05,param_01);
	}
}

//Function Number: 2
car_alarm_setup(param_00,param_01)
{
	level endon("car_alarm_triggered");
	thread player_touched_car_watcher(param_00,param_01);
	param_00 thread player_damaged_car_watcher(param_01);
	var_02 = param_00 common_scripts\utility::waittill_any_return("player_touched","player_damaged","remotely_hacked");
	if(isdefined(var_02))
	{
		if(var_02 == "player_touched")
		{
			param_00 thread start_car_alarm("player_touched");
		}
		else if(var_02 == "player_damaged")
		{
			param_00 thread start_car_alarm("player_damaged");
		}
		else if(var_02 == "remotely_hacked")
		{
			param_00 thread start_car_alarm("remotely_hacked");
		}
	}

	level notify("stop_all_player_touched_car_watchers");
	level notify("stop_all_player_damaged_car_watchers");
	level notify("car_alarm_triggered");
}

//Function Number: 3
player_touched_car_watcher(param_00,param_01)
{
	self endon(param_01);
	level endon("stop_all_player_touched_car_watchers");
	param_00 endon("player_touched");
	param_00 endon("player_damaged");
	self waittill("trigger");
	param_00 notify("player_touched");
}

//Function Number: 4
player_damaged_car_watcher(param_00)
{
	self endon(param_00);
	level endon("stop_all_player_damaged_car_watchers");
	self endon("player_touched");
	self endon("player_damaged");
	for(;;)
	{
		self waittill("damage",var_01,var_02);
		if(isdefined(var_02) && var_02 == level.player)
		{
			self notify("player_damaged");
			continue;
		}

		wait(0.05);
	}
}

//Function Number: 5
start_car_alarm(param_00)
{
	self endon("death");
	var_01[0] = spawnstruct();
	var_01[0].vo = "ie_iln_getout6";
	var_01[0].vo_priority = 4;
	var_01[1] = spawnstruct();
	var_01[1].vo = "ie_lin_stayout4";
	var_01[1].vo_priority = 4;
	thread maps\irons_estate_code::notifyaftertime("stop_car_alarm","stop_car_alarm",10);
	thread car_alarm_sound();
	if(!common_scripts\utility::flag("_stealth_spotted"))
	{
		if(isdefined(param_00) && !common_scripts\utility::flag("meet_cormack_start"))
		{
			if(param_00 == "player_touched")
			{
				thread maps\irons_estate_code::ally_vo_controller(var_01[0]);
			}
			else if(param_00 == "player_damaged")
			{
				thread maps\irons_estate_code::ally_vo_controller(var_01[1]);
			}
		}

		wait(0.25);
		var_02 = getaiarray("axis");
		foreach(var_04 in var_02)
		{
			if((isdefined(var_04.script_parameters) && var_04.script_parameters == "ignore_car_alarm") || isdefined(var_04.script_noteworthy) && var_04.script_noteworthy == "ignore_car_alarm")
			{
				var_02 = common_scripts\utility::array_remove(var_02,var_04);
			}
		}

		var_06 = common_scripts\utility::get_array_of_closest(self.origin,var_02,undefined,undefined,1024,undefined);
		if(isdefined(var_06))
		{
			foreach(var_08 in var_06)
			{
				wait(0.1);
				if(!common_scripts\utility::flag("_stealth_spotted") && isalive(var_08) && isdefined(var_08._stealth))
				{
					var_08 notify("reaction_generic",self.origin);
					var_09 = maps\_stealth_shared_utilities::group_get_ai_in_group(var_08.script_stealthgroup);
					if(isdefined(var_09))
					{
						foreach(var_04 in var_09)
						{
							if(var_04 == self)
							{
								continue;
							}

							if(isdefined(var_04.enemy) || isdefined(var_04.favoriteenemy))
							{
								continue;
							}

							var_04 thread maps\irons_estate_code::notify_delay_param("reaction_generic",randomfloatrange(0.1,0.5),self.origin);
						}

						break;
					}
				}
			}
		}
	}
}

//Function Number: 6
car_alarm_sound()
{
	self endon("death");
	self endon("stop_car_alarm");
	thread turn_off_car_alarm();
	for(;;)
	{
		self playsound("car_alarm_horn_01");
		wait(1.08);
	}
}

//Function Number: 7
turn_off_car_alarm()
{
	self endon("death");
	self waittill("stop_car_alarm");
	self stopsounds();
	wait(0.05);
	self playsound("car_alarm_horn_chirp");
}