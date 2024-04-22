/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: _dog_kinect.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 6
 * Decompile Time: 96 ms
 * Timestamp: 4/22/2024 2:20:44 AM
*******************************************************************/

//Function Number: 1
enable_dog_kinect()
{
	if(level.script == "enemyhq")
	{
		speechenablegrammar("speech/s1/grammars/en-us_rileyenemyhq.cfg",1);
	}
	else if(level.script == "nml")
	{
		speechenablegrammar("speech/s1/grammars/en-us_rileynml.cfg",1);
	}

	speechenable(1);
	setdvar("show_riley_commands",0);
}

//Function Number: 2
disable_dog_kinect()
{
	speechenable(0);
	if(level.script == "enemyhq")
	{
		speechenablegrammar("speech/s1/grammars/en-us_rileyenemyhq.cfg",0);
		return;
	}

	if(level.script == "nml")
	{
		speechenablegrammar("speech/s1/grammars/en-us_rileynml.cfg",0);
	}
}

//Function Number: 3
speechcommands()
{
	enable_dog_kinect();
	level.player thread listen_for_dog_kinect_commands(level.dog);
}

//Function Number: 4
listen_for_dog_kinect_commands(param_00)
{
	self endon("death");
	param_00 endon("death");
	for(;;)
	{
		level.player waittill("speechCommand",var_01,var_02);
		if(getdvarint("show_riley_commands") == 1)
		{
			iprintlnbold("speechCommand: " + var_02 + " at " + var_01 + " confidence.");
		}

		var_03 = 0.3;
		var_04 = 0.7;
		switch(var_02)
		{
			case "attack":
				if(var_01 > var_03)
				{
					if(isdefined(param_00.controlling_dog) && param_00 maps\_utility::ent_flag("pause_dog_command"))
					{
						level.player notify("attack_command");
					}
					else
					{
						level.player notify("fired_laser");
					}
				}
				break;
	
			case "cancel":
				if(var_01 > var_03)
				{
					param_00 notify("cancel_dog_attack");
				}
				break;
	
			case "bark":
				if(var_01 > var_04)
				{
					if(isdefined(param_00.controlling_dog))
					{
						level.player notify("LISTEN_ads_button_pressed");
					}
				}
				break;
	
			case "platform":
				if(var_01 > var_03)
				{
					var_05 = ["platform","ramp","walkway","catwalk"];
					foreach(var_07 in var_05)
					{
						var_08 = findlocation(var_07);
						if(isdefined(var_08))
						{
							laser_designate_target_kinect(var_08);
							break;
						}
					}
				}
				break;
	
			case "cart":
				if(var_01 > var_03)
				{
					var_0A = ["cart","counter","stand","conession","concession"];
					foreach(var_0C in var_0A)
					{
						var_08 = findlocation(var_0C);
						if(isdefined(var_08))
						{
							laser_designate_target_kinect(var_08);
							break;
						}
					}
				}
				break;
	
			case "vehicle":
				if(var_01 > var_03)
				{
					var_0E = ["car","van","bus"];
					foreach(var_10 in var_0E)
					{
						var_08 = findlocation(var_10);
						if(isdefined(var_08))
						{
							laser_designate_target_kinect(var_08);
							break;
						}
					}
				}
				break;
	
			case "debris":
				if(var_01 > var_03)
				{
					var_12 = ["debris","rubble"];
					foreach(var_14 in var_12)
					{
						var_08 = findlocation(var_14);
						if(isdefined(var_08))
						{
							laser_designate_target_kinect(var_08);
							break;
						}
					}
				}
				break;
	
			default:
				if(var_01 > var_03)
				{
					var_08 = findlocation(var_02);
					if(isdefined(var_08))
					{
						laser_designate_target_kinect(var_08);
					}
				}
				break;
		}
	}
}

//Function Number: 5
findlocation(param_00)
{
	var_01 = level.bcs_locations;
	foreach(var_03 in var_01)
	{
		if(isdefined(var_03.locationaliases))
		{
			foreach(var_05 in var_03.locationaliases)
			{
				if(issubstr(var_05,param_00))
				{
					return var_05;
				}
			}
		}
	}

	return undefined;
}

//Function Number: 6
laser_designate_target_kinect(param_00)
{
	var_01 = [];
	var_02 = getaiarray("axis");
	foreach(var_04 in var_02)
	{
		if(var_04.type == "dog")
		{
			continue;
		}

		var_05 = var_04 gettagorigin("J_SpineUpper");
		if(maps\_utility::player_looking_at(var_05,0.8,1))
		{
			var_06 = var_04 animscripts\battlechatter::get_all_my_locations();
			foreach(var_08 in var_06)
			{
				var_09 = var_08.locationaliases;
				foreach(var_0B in var_09)
				{
					if(var_0B == param_00)
					{
						var_01 = common_scripts\utility::array_add(var_01,var_04);
						break;
					}
				}
			}
		}
	}

	var_0F = maps\_dog_control::get_eye();
	if(var_01.size > 0)
	{
		var_01 = sortbydistance(var_01,var_0F);
		foreach(var_04 in var_01)
		{
			if(!isdefined(var_04.a.doinglongdeath))
			{
				var_11 = maps\_dog_control::get_laser_designated_trace();
				self notify("issue_dog_command",var_11,undefined,var_04);
				return;
			}
		}
	}
}