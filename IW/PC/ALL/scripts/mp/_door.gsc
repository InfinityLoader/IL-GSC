/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\mp\_door.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 15
 * Decompile Time: 804 ms
 * Timestamp: 10/27/2023 12:15:11 AM
*******************************************************************/

//Function Number: 1
func_59F5(param_00)
{
	var_01 = getentarray(param_00,"targetname");
	foreach(var_03 in var_01)
	{
		if(isdefined(var_03.var_EE79))
		{
			var_03 func_32E7(var_03.var_EE79);
		}

		var_03 func_59E7();
	}

	foreach(var_03 in var_01)
	{
		var_03 thread func_59F7();
	}
}

//Function Number: 2
func_59E7()
{
	var_00 = self;
	var_00.var_5A2B = [];
	if(isdefined(var_00.var_EDE8))
	{
		var_00.var_5A17 = max(0.1,float(var_00.var_EDE8) / 1000);
	}

	var_01 = getentarray(var_00.target,"targetname");
	foreach(var_03 in var_01)
	{
		if(issubstr(var_03.classname,"trigger"))
		{
			if(!isdefined(var_00.var_12720))
			{
				var_00.var_12720 = [];
			}

			if(isdefined(var_03.var_EE79))
			{
				var_03 func_1277D(var_03.var_EE79);
			}

			if(isdefined(var_03.var_EE01))
			{
				var_04 = getent(var_03.var_EE01,"script_linkname");
				var_03 enablelinkto();
				var_03 linkto(var_04);
			}

			var_00.var_12720[var_00.var_12720.size] = var_03;
			continue;
		}

		if(var_03.classname == "script_brushmodel" || var_03.classname == "script_model")
		{
			if(isdefined(var_03.script_noteworthy) && issubstr(var_03.script_noteworthy,"light"))
			{
				if(issubstr(var_03.script_noteworthy,"light_on"))
				{
					if(!isdefined(var_00.var_ACCE))
					{
						var_00.var_ACCE = [];
					}

					var_03 hide();
					var_00.var_ACCE[var_00.var_ACCE.size] = var_03;
				}
				else if(issubstr(var_03.script_noteworthy,"light_off"))
				{
					if(!isdefined(var_00.var_ACCC))
					{
						var_00.var_ACCC = [];
					}

					var_03 hide();
					var_00.var_ACCC[var_00.var_ACCC.size] = var_03;
				}
				else
				{
				}
			}
			else if(var_03.var_2AF & 2)
			{
				if(!isdefined(var_00.var_19E5))
				{
					var_00.var_19E5 = [];
				}

				var_03 notsolid();
				var_03 hide();
				var_03 method_829D(0);
				var_00.var_19E5[var_00.var_19E5.size] = var_03;
			}
			else
			{
				var_00.var_5A2B[var_00.var_5A2B.size] = var_03;
			}

			continue;
		}

		if(var_03.classname == "script_origin")
		{
			var_00.var_6666 = var_03;
		}
	}

	if(!isdefined(var_00.var_6666) && var_00.var_5A2B.size)
	{
		var_00.var_6666 = sortbydistance(var_00.var_5A2B,var_00.origin)[0];
	}

	foreach(var_07 in var_00.var_5A2B)
	{
		var_07.var_D6A4 = var_07.origin;
		var_07.var_D6AE = scripts\common\utility::getstruct(var_07.target,"targetname").origin;
		var_07.var_5717 = distance(var_07.var_D6AE,var_07.var_D6A4);
		var_07.origin = var_07.var_D6AE;
		var_07.var_C001 = 0;
		if(isdefined(var_07.var_EE79))
		{
			var_07 func_59BD(var_07.var_EE79);
		}
	}
}

//Function Number: 3
func_59F7()
{
	var_00 = self;
	var_00 func_59EC(2,1);
	for(;;)
	{
		var_00.var_10E27 = undefined;
		var_00.var_10E29 = undefined;
		var_00 scripts\common\utility::waittill_any_3("door_state_done","door_state_interrupted");
		if(isdefined(var_00.var_10E27) && var_00.var_10E27)
		{
			var_01 = var_00 func_59EE(var_00.var_10E26);
			var_00 func_59EC(var_01,0);
			continue;
		}

		if(isdefined(var_00.var_10E29) && var_00.var_10E29)
		{
			var_00 func_59EC(4,0);
			continue;
		}
	}
}

//Function Number: 4
func_59EE(param_00)
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
		var_02 = var_01.var_10E2E;
	}
	else
	{
	}

	return var_02;
}

//Function Number: 5
func_59F0(param_00)
{
	var_01 = self;
	var_01 endon("door_state_interrupted");
	var_01.var_10E27 = undefined;
	if(var_01.var_10E26 == 0 || var_01.var_10E26 == 2)
	{
		if(!param_00)
		{
			foreach(var_03 in var_01.var_5A2B)
			{
				if(isdefined(var_03.var_11041))
				{
					var_03 stoploopsound();
					var_03 playsoundonmovingent(var_03.var_11041);
				}
			}
		}

		if(isdefined(var_01.var_ACCE))
		{
			foreach(var_06 in var_01.var_ACCE)
			{
				var_06 show();
			}
		}

		foreach(var_03 in var_01.var_5A2B)
		{
			if(var_01.var_10E26 == 0)
			{
				if(isdefined(var_01.var_19E5))
				{
					foreach(var_0A in var_01.var_19E5)
					{
						var_0A show();
						var_0A method_829D(1);
					}
				}

				if(var_03.var_2AF & 1)
				{
					var_03 disconnectpaths();
				}
			}
			else
			{
				if(isdefined(var_01.var_19E5))
				{
					foreach(var_0A in var_01.var_19E5)
					{
						var_0A hide();
						var_0A method_829D(0);
					}
				}

				if(var_03.var_2AF & 1)
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

			if(var_03.var_C001)
			{
				var_03.var_12BE7 = undefined;
			}
		}

		var_0F = scripts\common\utility::func_116D7(var_01.var_10E26 == 0,&"MP_DOOR_USE_OPEN",&"MP_DOOR_USE_CLOSE");
		var_01 sethintstring(var_0F);
		var_01 makeusable();
		var_01 waittill("trigger");
		if(isdefined(var_01.var_32E9))
		{
			var_01 playsound(var_01.var_32E9);
		}
	}
	else if(var_01.var_10E26 == 1 || var_01.var_10E26 == 3)
	{
		if(isdefined(var_01.var_ACCC))
		{
			foreach(var_06 in var_01.var_ACCC)
			{
				var_06 show();
			}
		}

		var_01 makeunusable();
		if(var_01.var_10E26 == 1)
		{
			var_01 thread func_59EF();
			foreach(var_03 in var_01.var_5A2B)
			{
				if(isdefined(var_03.script_noteworthy))
				{
					var_13 = scripts\common\utility::func_116D7(isdefined(var_01.var_5A17),var_01.var_5A17,3);
					var_14 = scripts\common\utility::func_116D7(var_01.var_10E26 == 1,var_03.var_D6A4,var_03.var_D6AE);
					var_15 = distance(var_03.origin,var_14);
					var_16 = max(0.1,var_15 / var_03.var_5717 * var_13);
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
		else if(var_01.var_10E26 == 3)
		{
			if(isdefined(var_01.var_C607) && var_01.var_C607)
			{
				var_01 thread func_59EF();
			}

			foreach(var_03 in var_01.var_5A2B)
			{
				if(isdefined(var_03.script_noteworthy))
				{
					var_13 = scripts\common\utility::func_116D7(isdefined(var_01.var_5A17),var_01.var_5A17,3);
					var_14 = scripts\common\utility::func_116D7(var_01.var_10E26 == 1,var_03.var_D6A4,var_03.var_D6AE);
					var_15 = distance(var_03.origin,var_14);
					var_16 = max(0.1,var_15 / var_03.var_5717 * var_13);
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
		var_01 childthread func_59F1("garage_door_start","garage_door_loop");
		var_13 = scripts\common\utility::func_116D7(isdefined(var_01.var_5A17),var_01.var_5A17,3);
		var_1C = undefined;
		foreach(var_03 in var_01.var_5A2B)
		{
			var_14 = scripts\common\utility::func_116D7(var_01.var_10E26 == 1,var_03.var_D6A4,var_03.var_D6AE);
			if(var_03.origin != var_14)
			{
				var_16 = max(0.1,distance(var_03.origin,var_14) / var_03.var_5717 * var_13);
				var_17 = max(var_16 * 0.25,0.05);
				var_03 moveto(var_14,var_16,var_17,var_17);
				var_03 scripts\mp\_movers::func_C13B();
				if(var_03.var_C001)
				{
					var_03.var_12BE7 = ::scripts\mp\_movers::func_12BEE;
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
	else if(var_01.var_10E26 == 4)
	{
		foreach(var_03 in var_01.var_5A2B)
		{
			var_03 moveto(var_03.origin,0.05,0,0);
			var_03 scripts\mp\_movers::func_C13B();
			if(var_03.var_C001)
			{
				var_03.var_12BE7 = undefined;
			}

			if(isdefined(var_03.script_noteworthy))
			{
				if(var_03.script_noteworthy == "clockwise_wheel" || var_03.script_noteworthy == "counterclockwise_wheel")
				{
					var_03 rotatevelocity((0,0,0),0.05);
				}
			}
		}

		if(isdefined(var_01.var_ACCC))
		{
			foreach(var_06 in var_01.var_ACCC)
			{
				var_06 show();
			}
		}

		var_01.var_6666 stoploopsound();
		foreach(var_03 in var_01.var_5A2B)
		{
			if(isdefined(var_03.var_9A88))
			{
				var_03 playsound(var_03.var_9A88);
			}
		}

		wait(1);
	}
	else
	{
	}

	var_01.var_10E27 = 1;
	foreach(var_03 in var_01.var_5A2B)
	{
		var_03.var_10E27 = 1;
	}

	var_01 notify("door_state_done");
}

//Function Number: 6
func_59F1(param_00,param_01)
{
	var_02 = self;
	var_03 = 1;
	var_04 = 1;
	var_05 = 0;
	if(var_02.var_10E26 == 3 || var_02.var_10E26 == 1)
	{
		foreach(var_07 in var_02.var_5A2B)
		{
			if(isdefined(var_07.var_10D2A))
			{
				var_07 playsoundonmovingent(var_07.var_10D2A);
				var_05 = lookupsoundlength(var_07.var_10D2A) / 1000;
				var_03 = 0;
			}
		}

		if(var_03)
		{
			var_05 = lookupsoundlength(param_00) / 1000;
			playsoundatpos(var_02.var_6666.origin,param_00);
		}
	}

	wait(var_05 * 0.3);
	if(var_02.var_10E26 == 3 || var_02.var_10E26 == 1)
	{
		foreach(var_07 in var_02.var_5A2B)
		{
			if(isdefined(var_07.var_B048))
			{
				if(var_07.var_B048 != "none")
				{
					var_07 playloopsound(var_07.var_B048);
				}

				var_04 = 0;
			}
		}

		if(var_04)
		{
			var_02.var_6666 playloopsound(param_01);
		}
	}
}

//Function Number: 7
func_59EC(param_00,param_01)
{
	var_02 = self;
	if(isdefined(var_02.var_10E26))
	{
		func_59ED(var_02.var_10E26);
		var_02.var_10E2E = var_02.var_10E26;
	}

	var_02.var_10E26 = param_00;
	var_02 thread func_59F0(param_01);
}

//Function Number: 8
func_59ED(param_00)
{
	var_01 = self;
	if(param_00 == 0 || param_00 == 2)
	{
		if(isdefined(var_01.var_ACCE))
		{
			foreach(var_03 in var_01.var_ACCE)
			{
				var_03 hide();
			}

			return;
		}

		return;
	}

	if(var_03 == 1 || var_03 == 3)
	{
		if(isdefined(var_04.var_ACCC))
		{
			foreach(var_05 in var_04.var_ACCC)
			{
				var_05 hide();
			}
		}

		var_03.var_6666 stoploopsound();
		foreach(var_08 in var_03.var_5A2B)
		{
			if(isdefined(var_08.var_B048))
			{
				var_08 stoploopsound();
			}
		}

		return;
	}

	if(var_02 == 4)
	{
		return;
	}
}

//Function Number: 9
func_59EF()
{
	var_00 = self;
	var_00 endon("door_state_done");
	var_01 = [];
	foreach(var_03 in var_00.var_12720)
	{
		if(var_00.var_10E26 == 1)
		{
			if(isdefined(var_03.var_C0B1) && var_03.var_C0B1 == 1)
			{
				continue;
			}
		}
		else if(var_00.var_10E26 == 3)
		{
			if(isdefined(var_03.var_C0B2) && var_03.var_C0B2 == 1)
			{
				continue;
			}
		}

		var_01[var_01.size] = var_03;
	}

	if(var_01.size > 0)
	{
		var_05 = var_00 func_13739(var_01);
		if(!isdefined(var_05.var_6BA7) || var_05.var_6BA7 == 0)
		{
			var_00.var_10E29 = 1;
			var_00 notify("door_state_interrupted");
		}
	}
}

//Function Number: 10
func_13739(param_00)
{
	var_01 = self;
	foreach(var_03 in param_00)
	{
		var_01 thread func_E467(var_03);
	}

	var_01 waittill("interrupted");
	return var_01.var_9A8E;
}

//Function Number: 11
func_E467(param_00)
{
	var_01 = self;
	var_01 endon("door_state_done");
	var_01 endon("interrupted");
	for(;;)
	{
		param_00 waittill("trigger",var_02);
		if(isdefined(param_00.var_DA79) && param_00.var_DA79 == 1)
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

	var_01.var_9A8E = var_02;
	var_01 notify("interrupted");
}

//Function Number: 12
func_32E7(param_00)
{
	var_01 = self;
	var_01.var_32E9 = undefined;
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
			var_01.var_C8F0[var_05[0]] = undefined;
			continue;
		}

		switch(var_05[0])
		{
			case "open_interrupt":
				var_01.var_C607 = func_11149(var_05[1]);
				break;

			case "button_sound":
				var_01.var_32E9 = var_05[1];
				break;

			default:
				break;
		}
	}
}

//Function Number: 13
func_59BD(param_00)
{
	var_01 = self;
	var_01.var_10D2A = undefined;
	var_01.var_11041 = undefined;
	var_01.var_B048 = undefined;
	var_01.var_9A88 = undefined;
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
			var_01.var_C8F0[var_05[0]] = undefined;
			continue;
		}

		switch(var_05[0])
		{
			case "stop_sound":
				var_01.var_11041 = var_05[1];
				break;

			case "interrupt_sound":
				var_01.var_9A88 = var_05[1];
				break;

			case "loop_sound":
				var_01.var_B048 = var_05[1];
				break;

			case "open_interrupt":
				var_01.var_C607 = func_11149(var_05[1]);
				break;

			case "start_sound":
				var_01.var_10D2A = var_05[1];
				break;

			case "unresolved_collision_nodes":
				var_01.var_12BEB = function_00B4(var_05[1],"targetname");
				break;

			case "no_moving_unresolved_collisions":
				var_01.var_C001 = func_11149(var_05[1]);
				break;

			default:
				break;
		}
	}
}

//Function Number: 14
func_1277D(param_00)
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
			var_01.var_C8F0[var_05[0]] = undefined;
			continue;
		}

		switch(var_05[0])
		{
			case "not_opening":
				var_01.var_C0B2 = func_11149(var_05[1]);
				break;

			case "not_closing":
				var_01.var_C0B1 = func_11149(var_05[1]);
				break;

			case "prone_only":
				var_01.var_DA79 = func_11149(var_05[1]);
				break;

			default:
				break;
		}
	}
}

//Function Number: 15
func_11149(param_00)
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