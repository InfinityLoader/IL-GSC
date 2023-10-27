/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes\_door.gsc
 * Game: Call of Duty: Ghosts
 * Platform: Console
 * Function Count: 15
 * Decompile Time: 266 ms
 * Timestamp: 10/27/2023 1:30:43 AM
*******************************************************************/

//Function Number: 1
func_29E5(param_00)
{
	var_01 = getentarray(param_00,"targetname");
	foreach(var_03 in var_01)
	{
		if(isdefined(var_03.script_parameters))
		{
			var_03 button_parse_parameters(var_03.script_parameters);
		}

		var_03 func_29D6();
	}

	foreach(var_03 in var_01)
	{
		var_03 thread func_29E6();
	}
}

//Function Number: 2
func_29D6()
{
	var_00 = self;
	var_00.doors = [];
	if(isdefined(var_00.script_index))
	{
		var_00.doormovetime = max(0.1,castfloat(var_00.script_index) / 1000);
	}

	var_01 = getentarray(var_00.target,"targetname");
	foreach(var_03 in var_01)
	{
		if(issubstr(var_03.classname,"trigger"))
		{
			if(!isdefined(var_00.trigblock))
			{
				var_00.trigblock = [];
			}

			if(isdefined(var_03.script_parameters))
			{
				var_03 trigger_parse_parameters(var_03.script_parameters);
			}

			if(isdefined(var_03.script_linkto))
			{
				var_04 = getent(var_03.script_linkto,"script_linkname");
				var_03 enablelinkto();
				var_03 linkto(var_04);
			}

			var_00.trigblock[var_00.trigblock.size] = var_03;
			continue;
		}

		if(var_03.classname == "script_brushmodel" || var_03.classname == "script_model")
		{
			if(isdefined(var_03.script_noteworthy) && issubstr(var_03.script_noteworthy,"light"))
			{
				if(issubstr(var_03.script_noteworthy,"light_on"))
				{
					if(!isdefined(var_00.lights_on))
					{
						var_00.lights_on = [];
					}

					var_03 hide();
					var_00.lights_on[var_00.lights_on.size] = var_03;
				}
				else if(issubstr(var_03.script_noteworthy,"light_off"))
				{
					if(!isdefined(var_00.lights_off))
					{
						var_00.lights_off = [];
					}

					var_03 hide();
					var_00.lights_off[var_00.lights_off.size] = var_03;
				}
				else
				{
				}
			}
			else if(var_03.spawnflags & 2)
			{
				if(!isdefined(var_00.ai_sight_brushes))
				{
					var_00.ai_sight_brushes = [];
				}

				var_03 notsolid();
				var_03 hide();
				var_03 setaisightlinevisible(0);
				var_00.ai_sight_brushes[var_00.ai_sight_brushes.size] = var_03;
			}
			else
			{
				var_00.doors[var_00.doors.size] = var_03;
			}

			continue;
		}

		if(var_03.classname == "script_origin")
		{
			var_00.entsound = var_03;
		}
	}

	if(!isdefined(var_00.entsound) && var_00.doors.size)
	{
		var_00.entsound = sortbydistance(var_00.doors,var_00.origin)[0];
	}

	foreach(var_07 in var_00.doors)
	{
		var_07.posclosed = var_07.origin;
		var_07.posopen = common_scripts\utility::func_3C18(var_07.target,"targetname").origin;
		var_07.distmove = distance(var_07.posopen,var_07.posclosed);
		var_07.origin = var_07.posopen;
		var_07.no_moving_unresolved_collisions = 0;
		if(isdefined(var_07.script_parameters))
		{
			var_07 door_parse_parameters(var_07.script_parameters);
		}
	}
}

//Function Number: 3
func_29E6()
{
	var_00 = self;
	var_00 func_29D8(2,1);
	for(;;)
	{
		var_00.statedone = undefined;
		var_00.stateinterrupted = undefined;
		var_00 common_scripts\utility::func_8B2A("door_state_done","door_state_interrupted");
		if(isdefined(var_00.statedone) && var_00.statedone)
		{
			var_01 = var_00 func_29DA(var_00.statecurr);
			var_00 func_29D8(var_01,0);
			continue;
		}

		if(isdefined(var_00.stateinterrupted) && var_00.stateinterrupted)
		{
			var_00 func_29D8(4,0);
			continue;
		}
	}
}

//Function Number: 4
func_29DA(param_00)
{
	var_01 = self;
	var_02 = undefined;
	if(param_00 == 0)
	{
		var_02 = 3;
	}
	else if(param_00 == 2)
	{
		var_02 = 1;
	}
	else if(param_00 == 1)
	{
		var_02 = 0;
	}
	else if(param_00 == 3)
	{
		var_02 = 2;
	}
	else if(param_00 == 4)
	{
		var_02 = var_01.stateprev;
	}
	else
	{
	}

	return var_02;
}

//Function Number: 5
func_29DC(param_00)
{
	var_01 = self;
	var_01 endon("door_state_interrupted");
	var_01.statedone = undefined;
	if(var_01.statecurr == 0 || var_01.statecurr == 2)
	{
		if(!param_00)
		{
			foreach(var_03 in var_01.doors)
			{
				if(isdefined(var_03.stop_sound))
				{
					var_03 stoploopsound();
					var_03 botpredictenemycampspots(var_03.stop_sound);
				}
			}
		}

		if(isdefined(var_01.lights_on))
		{
			foreach(var_06 in var_01.lights_on)
			{
				var_06 show();
			}
		}

		foreach(var_03 in var_01.doors)
		{
			if(var_01.statecurr == 0)
			{
				if(isdefined(var_01.ai_sight_brushes))
				{
					foreach(var_0A in var_01.ai_sight_brushes)
					{
						var_0A show();
						var_0A setaisightlinevisible(1);
					}
				}

				if(var_03.spawnflags & 1)
				{
					var_03 disconnectpaths();
				}
			}
			else
			{
				if(isdefined(var_01.ai_sight_brushes))
				{
					foreach(var_0A in var_01.ai_sight_brushes)
					{
						var_0A hide();
						var_0A setaisightlinevisible(0);
					}
				}

				if(var_03.spawnflags & 1)
				{
					if(isdefined(var_03.script_noteworthy) && var_03.script_noteworthy == "always_disconnect")
					{
						var_03 disconnectpaths();
					}
					else
					{
						var_03 connectpaths();
					}
				}
			}

			if(isdefined(var_03.script_noteworthy))
			{
				if(var_03.script_noteworthy == "clockwise_wheel" || var_03.script_noteworthy == "counterclockwise_wheel")
				{
					var_03 rotatevelocity((0,0,0),0.1);
				}
			}

			if(var_03.no_moving_unresolved_collisions)
			{
				var_03.unresolved_collision_func = undefined;
			}
		}

		var_0F = common_scripts\utility::func_803F(var_01.statecurr == 0,&"MP_DOOR_USE_OPEN",&"MP_DOOR_USE_CLOSE");
		var_01 sethintstring(var_0F);
		var_01 makeusable();
		var_01 waittill("trigger");
		if(isdefined(var_01.button_sound))
		{
			var_01 playsound(var_01.button_sound);
		}
	}
	else if(var_01.statecurr == 1 || var_01.statecurr == 3)
	{
		if(isdefined(var_01.lights_off))
		{
			foreach(var_06 in var_01.lights_off)
			{
				var_06 show();
			}
		}

		var_01 makeunusable();
		if(var_01.statecurr == 1)
		{
			var_01 thread func_29DB();
			foreach(var_03 in var_01.doors)
			{
				if(isdefined(var_03.script_noteworthy))
				{
					var_13 = common_scripts\utility::func_803F(isdefined(var_01.doormovetime),var_01.doormovetime,3);
					var_14 = common_scripts\utility::func_803F(var_01.statecurr == 1,var_03.posclosed,var_03.posopen);
					var_15 = distance(var_03.origin,var_14);
					var_16 = max(0.1,var_15 / var_03.distmove * var_13);
					var_17 = max(var_16 * 0.25,0.05);
					var_18 = 360 * var_15 / 94.2;
					if(var_03.script_noteworthy == "clockwise_wheel")
					{
						var_03 rotatevelocity((0,0,-1 * var_18 / var_16),var_16,var_17,var_17);
					}
					else if(var_03.script_noteworthy == "counterclockwise_wheel")
					{
						var_03 rotatevelocity((0,0,var_18 / var_16),var_16,var_17,var_17);
					}
				}
			}
		}
		else if(var_01.statecurr == 3)
		{
			if(isdefined(var_01.open_interrupt) && var_01.open_interrupt)
			{
				var_01 thread func_29DB();
			}

			foreach(var_03 in var_01.doors)
			{
				if(isdefined(var_03.script_noteworthy))
				{
					var_13 = common_scripts\utility::func_803F(isdefined(var_01.doormovetime),var_01.doormovetime,3);
					var_14 = common_scripts\utility::func_803F(var_01.statecurr == 1,var_03.posclosed,var_03.posopen);
					var_15 = distance(var_03.origin,var_14);
					var_16 = max(0.1,var_15 / var_03.distmove * var_13);
					var_17 = max(var_16 * 0.25,0.05);
					var_18 = 360 * var_15 / 94.2;
					if(var_03.script_noteworthy == "clockwise_wheel")
					{
						var_03 rotatevelocity((0,0,var_18 / var_16),var_16,var_17,var_17);
					}
					else if(var_03.script_noteworthy == "counterclockwise_wheel")
					{
						var_03 rotatevelocity((0,0,-1 * var_18 / var_16),var_16,var_17,var_17);
					}
				}
			}
		}

		wait(0.1);
		var_01 childthread door_state_update_sound("garage_door_start","garage_door_loop");
		var_13 = common_scripts\utility::func_803F(isdefined(var_01.doormovetime),var_01.doormovetime,3);
		var_1C = undefined;
		foreach(var_03 in var_01.doors)
		{
			var_14 = common_scripts\utility::func_803F(var_01.statecurr == 1,var_03.posclosed,var_03.posopen);
			if(var_03.origin != var_14)
			{
				var_16 = max(0.1,distance(var_03.origin,var_14) / var_03.distmove * var_13);
				var_17 = max(var_16 * 0.25,0.05);
				var_03 moveto(var_14,var_16,var_17,var_17);
				var_03 maps\mp\_movers::notify_moving_platform_invalid();
				if(var_03.no_moving_unresolved_collisions)
				{
					var_03.unresolved_collision_func = ::maps\mp\_movers::func_85CF;
				}

				if(!isdefined(var_1C) || var_16 > var_1C)
				{
					var_1C = var_16;
				}
			}
		}

		if(isdefined(var_1C))
		{
			wait(var_1C);
		}
	}
	else if(var_01.statecurr == 4)
	{
		foreach(var_03 in var_01.doors)
		{
			var_03 moveto(var_03.origin,0.05,0,0);
			var_03 maps\mp\_movers::notify_moving_platform_invalid();
			if(var_03.no_moving_unresolved_collisions)
			{
				var_03.unresolved_collision_func = undefined;
			}

			if(isdefined(var_03.script_noteworthy))
			{
				if(var_03.script_noteworthy == "clockwise_wheel" || var_03.script_noteworthy == "counterclockwise_wheel")
				{
					var_03 rotatevelocity((0,0,0),0.05);
				}
			}
		}

		if(isdefined(var_01.lights_off))
		{
			foreach(var_06 in var_01.lights_off)
			{
				var_06 show();
			}
		}

		var_01.entsound stoploopsound();
		foreach(var_03 in var_01.doors)
		{
			if(isdefined(var_03.interrupt_sound))
			{
				var_03 playsound(var_03.interrupt_sound);
			}
		}

		wait(1);
	}
	else
	{
	}

	var_01.statedone = 1;
	foreach(var_03 in var_01.doors)
	{
		var_03.statedone = 1;
	}

	var_01 notify("door_state_done");
}

//Function Number: 6
door_state_update_sound(param_00,param_01)
{
	var_02 = self;
	var_03 = 1;
	var_04 = 1;
	var_05 = 0;
	if(var_02.statecurr == 3 || var_02.statecurr == 1)
	{
		foreach(var_07 in var_02.doors)
		{
			if(isdefined(var_07.start_sound))
			{
				var_07 botpredictenemycampspots(var_07.start_sound);
				var_05 = getenemysquaddata(var_07.start_sound) / 1000;
				var_03 = 0;
			}
		}

		if(var_03)
		{
			var_05 = getenemysquaddata(param_00) / 1000;
			playsoundatpos(var_02.entsound.origin,param_00);
		}
	}

	wait(var_05 * 0.3);
	if(var_02.statecurr == 3 || var_02.statecurr == 1)
	{
		foreach(var_07 in var_02.doors)
		{
			if(isdefined(var_07.loop_sound))
			{
				if(var_07.loop_sound != "none")
				{
					var_07 playloopsound(var_07.loop_sound);
				}

				var_04 = 0;
			}
		}

		if(var_04)
		{
			var_02.entsound playloopsound(param_01);
		}
	}
}

//Function Number: 7
func_29D8(param_00,param_01)
{
	var_02 = self;
	if(isdefined(var_02.statecurr))
	{
		door_state_exit(var_02.statecurr);
		var_02.stateprev = var_02.statecurr;
	}

	var_02.statecurr = param_00;
	var_02 thread func_29DC(param_01);
}

//Function Number: 8
door_state_exit(param_00)
{
	var_01 = self;
	if(param_00 == 0 || param_00 == 2)
	{
		if(isdefined(var_01.lights_on))
		{
			foreach(var_03 in var_01.lights_on)
			{
				var_03 hide();
			}
		}
	}

	if(var_03 == 1 || var_03 == 3)
	{
		if(isdefined(var_04.lights_off))
		{
			foreach(var_05 in var_04.lights_off)
			{
				var_05 hide();
			}
		}

		var_03.entsound stoploopsound();
		foreach(var_08 in var_03.doors)
		{
			if(isdefined(var_08.loop_sound))
			{
				var_08 stoploopsound();
			}
		}
	}

	if(var_02 == 4)
	{
	}
}

//Function Number: 9
func_29DB()
{
	var_00 = self;
	var_00 endon("door_state_done");
	var_01 = [];
	foreach(var_03 in var_00.trigblock)
	{
		if(var_00.statecurr == 1)
		{
			if(isdefined(var_03.not_closing) && var_03.not_closing == 1)
			{
				continue;
			}
		}
		else if(var_00.statecurr == 3)
		{
			if(isdefined(var_03.not_opening) && var_03.not_opening == 1)
			{
				continue;
			}
		}

		var_01[var_01.size] = var_03;
	}

	if(var_01.size > 0)
	{
		var_05 = var_00 waittill_any_triggered_return_triggerer(var_01);
		if(!isdefined(var_05.fauxdead) || var_05.fauxdead == 0)
		{
			var_00.stateinterrupted = 1;
			var_00 notify("door_state_interrupted");
		}
	}
}

//Function Number: 10
waittill_any_triggered_return_triggerer(param_00)
{
	var_01 = self;
	foreach(var_03 in param_00)
	{
		var_01 thread func_6685(var_03);
	}

	var_01 waittill("interrupted");
	return var_01.interrupter;
}

//Function Number: 11
func_6685(param_00)
{
	var_01 = self;
	var_01 endon("door_state_done");
	var_01 endon("interrupted");
	for(;;)
	{
		param_00 waittill("trigger",var_02);
		if(isdefined(param_00.prone_only) && param_00.prone_only == 1)
		{
			if(isplayer(var_02))
			{
				var_03 = var_02 getstance();
				if(var_03 != "prone")
				{
					continue;
				}
				else
				{
					var_04 = vectornormalize(anglestoforward(var_02.angles));
					var_05 = vectornormalize(param_00.origin - var_02.origin);
					var_06 = vectordot(var_04,var_05);
					if(var_06 > 0)
					{
						continue;
					}
				}
			}
		}

		break;
	}

	var_01.interrupter = var_02;
	var_01 notify("interrupted");
}

//Function Number: 12
button_parse_parameters(param_00)
{
	var_01 = self;
	var_01.button_sound = undefined;
	if(!isdefined(param_00))
	{
		param_00 = "";
	}

	var_02 = strtok(param_00,";");
	foreach(var_04 in var_02)
	{
		var_05 = strtok(var_04,"=");
		if(var_05.size != 2)
		{
			continue;
		}

		if(var_05[1] == "undefined" || var_05[1] == "default")
		{
			var_01.params[var_05[0]] = undefined;
			continue;
		}

		switch(var_05[0])
		{
			case "open_interrupt":
				var_01.open_interrupt = string_to_bool(var_05[1]);
				break;

			case "button_sound":
				var_01.button_sound = var_05[1];
				break;

			default:
				break;
		}
	}
}

//Function Number: 13
door_parse_parameters(param_00)
{
	var_01 = self;
	var_01.start_sound = undefined;
	var_01.stop_sound = undefined;
	var_01.loop_sound = undefined;
	var_01.interrupt_sound = undefined;
	if(!isdefined(param_00))
	{
		param_00 = "";
	}

	var_02 = strtok(param_00,";");
	foreach(var_04 in var_02)
	{
		var_05 = strtok(var_04,"=");
		if(var_05.size != 2)
		{
			continue;
		}

		if(var_05[1] == "undefined" || var_05[1] == "default")
		{
			var_01.params[var_05[0]] = undefined;
			continue;
		}

		switch(var_05[0])
		{
			case "stop_sound":
				var_01.stop_sound = var_05[1];
				break;

			case "interrupt_sound":
				var_01.interrupt_sound = var_05[1];
				break;

			case "loop_sound":
				var_01.loop_sound = var_05[1];
				break;

			case "open_interrupt":
				var_01.open_interrupt = string_to_bool(var_05[1]);
				break;

			case "start_sound":
				var_01.start_sound = var_05[1];
				break;

			case "unresolved_collision_nodes":
				var_01.unresolved_collision_nodes = getnodearray(var_05[1],"targetname");
				break;

			case "no_moving_unresolved_collisions":
				var_01.no_moving_unresolved_collisions = string_to_bool(var_05[1]);
				break;

			default:
				break;
		}
	}
}

//Function Number: 14
trigger_parse_parameters(param_00)
{
	var_01 = self;
	if(!isdefined(param_00))
	{
		param_00 = "";
	}

	var_02 = strtok(param_00,";");
	foreach(var_04 in var_02)
	{
		var_05 = strtok(var_04,"=");
		if(var_05.size != 2)
		{
			continue;
		}

		if(var_05[1] == "undefined" || var_05[1] == "default")
		{
			var_01.params[var_05[0]] = undefined;
			continue;
		}

		switch(var_05[0])
		{
			case "not_opening":
				var_01.not_opening = string_to_bool(var_05[1]);
				break;

			case "not_closing":
				var_01.not_closing = string_to_bool(var_05[1]);
				break;

			case "prone_only":
				var_01.prone_only = string_to_bool(var_05[1]);
				break;

			default:
				break;
		}
	}
}

//Function Number: 15
string_to_bool(param_00)
{
	var_01 = undefined;
	switch(param_00)
	{
		case "true":
		case "1":
			var_01 = 1;
			break;

		case "false":
		case "0":
			var_01 = 0;
			break;

		default:
			break;
	}

	return var_01;
}