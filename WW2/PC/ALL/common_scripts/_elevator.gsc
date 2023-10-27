/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: common_scripts\_elevator.gsc
 * Game: Call of Duty: WWII
 * Platform: PC
 * Function Count: 55
 * Decompile Time: 847 ms
 * Timestamp: 10/27/2023 3:26:32 AM
*******************************************************************/

//Function Number: 1
func_00D5()
{
	if(getdvar("scr_elevator_disabled") == "1")
	{
		return;
	}

	var_00 = getentarray("elevator_group","targetname");
	if(!isdefined(var_00))
	{
		return;
	}

	if(!var_00.size)
	{
		return;
	}

	precachestring(&"ELEVATOR_CALL_HINT");
	precachestring(&"ELEVATOR_USE_HINT");
	precachestring(&"ELEVATOR_FLOOR_SELECT_HINT");
	precachemenu("elevator_floor_selector");
	thread func_35CF();
	level.var_35D1 = [];
	level.var_35B8 = func_35C0("scr_elevator_callbutton_link_v","96");
	level.var_35B7 = func_35C0("scr_elevator_callbutton_link_h","256");
	func_1D07();
	func_758A();
	func_35B6();
	if(!level.var_35D1.size)
	{
		return;
	}

	foreach(var_02 in level.var_35D1)
	{
		var_02 thread func_35CE();
		var_02 thread func_35CB();
	}

	thread func_35BA();
}

//Function Number: 2
func_35CF()
{
	for(;;)
	{
		level.var_35B4 = func_35BF("scr_elevator_accel","0.2");
		level.var_35BB = func_35BF("scr_elevator_decel","0.2");
		level.var_35C8 = func_35C0("scr_elevator_music","1");
		level.var_35CC = func_35C0("scr_elevator_speed","96");
		level.var_35C1 = func_35C0("scr_elevator_innerdoorspeed","14");
		level.var_35C9 = func_35C0("scr_elevator_outterdoorspeed","16");
		level.var_35CA = func_35C0("scr_elevator_return","0");
		level.var_35D0 = func_35C0("scr_elevator_waittime","6");
		level.var_35B5 = func_35C0("scr_elevator_aggressive_call","0");
		level.var_35BA = func_35C0("debug_elevator","0");
		if(common_scripts\utility::func_57D7())
		{
			level.var_35C6 = func_35C0("scr_elevator_motion_detection","0");
		}
		else
		{
			level.var_35C6 = func_35C0("scr_elevator_motion_detection","1");
		}

		wait(1);
	}
}

//Function Number: 3
func_35CE()
{
	func_35BE("[A]");
}

//Function Number: 4
func_35B6()
{
	foreach(var_01 in level.var_35B9)
	{
		var_01 thread end_portal_name();
	}
}

//Function Number: 5
func_3D88(param_00)
{
	self endon("elevator_moving");
	self.var_3D88 = 0;
	self.var_6CC6 = undefined;
	for(;;)
	{
		param_00 waittill("trigger",var_01);
		self.var_3D88 = 1;
		self.var_6CC6 = var_01;
		break;
	}

	self notify("floor_override");
}

//Function Number: 6
func_35BE(param_00)
{
	self.var_3876 = param_00;
	var_01 = func_41C7();
	var_02 = func_41C8();
	for(;;)
	{
		if(self.var_3876 == "[A]")
		{
			if(level.var_35CA && func_4128() != func_41DB())
			{
				self.var_64D2 = func_41DB();
				thread func_3D88(var_02);
				func_A752("floor_override",level.var_35D0);
				if(self.var_3D88 && isdefined(self.var_6CC6) && isplayer(self.var_6CC6))
				{
					func_4199(self.var_6CC6);
				}

				self.var_3876 = "[B]";
				continue;
			}

			for(;;)
			{
				if(self.var_64D2 == func_4128())
				{
					var_03 = var_02 func_2FC7("trigger");
				}
				else
				{
					var_03 = "elevator_called";
				}

				if(isstring(var_03) && var_03 == "elevator_called" && self.var_64D2 != func_4128())
				{
					self.var_3876 = "[B]";
					break;
				}

				if(isdefined(var_03) && isplayer(var_03) && isalive(var_03))
				{
					var_04 = var_03 istouching(var_02);
					var_05 = isdefined(var_02.var_6464) && var_03 istouching(var_02.var_6464);
					var_06 = var_04 || var_05;
					if(var_06)
					{
						var_07 = var_03;
						func_4199(var_07);
						if(self.var_64D2 == func_4128())
						{
							continue;
						}

						self.var_3876 = "[B]";
						break;
					}
				}
			}
		}

		if(self.var_3876 == "[B]")
		{
			thread func_35C2(var_01);
			var_08 = func_4128();
			thread func_2437();
			thread func_2439(var_08);
			common_scripts\utility::knock_off_battery("closed_inner_doors","interrupted");
			if(self.var_35C3)
			{
				self.var_3876 = "[C]";
				continue;
			}

			self.var_3876 = "[D]";
			continue;
		}

		if(self.var_3876 == "[C]")
		{
			var_08 = func_4128();
			thread func_6BEC();
			thread func_6BEE(var_08);
			self waittill("opened_floor_" + var_08 + "_outer_doors");
			if(self.var_35C3)
			{
				self.var_3876 = "[B]";
				continue;
			}

			self.var_3876 = "[A]";
			continue;
		}

		if(self.var_3876 == "[D]")
		{
			if(self.var_64D2 != func_4128())
			{
				thread func_35C7(self.var_64D2);
				self waittill("elevator_moved");
			}

			self.var_3876 = "[C]";
			continue;
		}
	}
}

//Function Number: 7
end_portal_name()
{
	for(;;)
	{
		var_00 = func_2FC7("trigger");
		var_01 = undefined;
		var_02 = [];
		foreach(var_05, var_04 in self.var_3532)
		{
			var_01 = var_05;
			var_02 = var_04;
		}

		var_06 = 0;
		foreach(var_08 in var_02)
		{
			var_09 = var_08 func_35BD();
			if(!level.var_35B5 && !var_09)
			{
				if(var_08 func_4128() == var_01)
				{
					var_06 = 1;
					var_02 = [];
					break;
				}
			}
		}

		foreach(var_08 in var_02)
		{
			if(var_08.var_3876 == "[A]")
			{
				var_08 func_1E5B(var_01);
				var_06 = 1;
				if(!level.var_35B5)
				{
					break;
				}
			}
		}

		if(var_06)
		{
			self method_8617("elev_bell_ding");
		}
	}
}

//Function Number: 8
func_1E5B(param_00)
{
	self.var_64D2 = param_00;
	var_01 = func_41C8();
	var_01 notify("trigger","elevator_called");
	if(level.var_35C6)
	{
		var_01.var_6464 notify("trigger","elevator_called");
	}
}

//Function Number: 9
func_4199(param_00)
{
	var_01 = func_4271();
	if(var_01.size == 2)
	{
		var_02 = func_4128();
		self.var_64D2 = !var_02;
		return;
	}

	var_01 openpopupmenu("elevator_floor_selector");
	var_01 setclientdvar("player_current_floor",func_4128());
	for(;;)
	{
		var_01 waittill("menuresponse",var_03,var_04);
		if(var_03 == "elevator_floor_selector")
		{
			if(var_04 != "none")
			{
				self.var_64D2 = int(var_04);
			}

			break;
		}
	}
}

//Function Number: 10
func_35C2(param_00)
{
	self notify("interrupt_watch");
	level notify("elevator_interior_button_pressed");
	self endon("interrupt_watch");
	self endon("elevator_moving");
	self.var_35C3 = 0;
	wait(0.5);
	param_00 waittill("trigger",var_01);
	self notify("interrupted");
	self.var_35C3 = 1;
}

//Function Number: 11
func_35BD()
{
	var_00 = func_41CB();
	var_01 = var_00.var_116;
	var_02 = 1;
	foreach(var_06, var_04 in func_4271())
	{
		var_05 = self.var_3532["floor" + var_06 + "_pos"];
		if(var_01 == var_05)
		{
			self.var_3532["current_floor"] = var_06;
			var_02 = 0;
		}
	}

	return var_02;
}

//Function Number: 12
func_35CB()
{
	var_00 = func_41CD();
	if(level.var_35C8 && isdefined(var_00))
	{
		var_00 method_861D("elev_musak_loop");
	}

	thread func_5DCD("closing_inner_doors");
	thread func_5DCD("opening_inner_doors");
	thread func_5DCD("closed_inner_doors");
	thread func_5DCD("opened_inner_doors");
	foreach(var_03, var_02 in func_4271())
	{
		thread func_5DCD("closing_floor_" + var_03 + "_outer_doors");
		thread func_5DCD("opening_floor_" + var_03 + "_outer_doors");
		thread func_5DCD("closed_floor_" + var_03 + "_outer_doors");
		thread func_5DCD("opened_floor_" + var_03 + "_outer_doors");
	}

	thread func_5DCD("interrupted");
	thread func_5DCD("elevator_moving");
	thread func_5DCD("elevator_moved");
}

//Function Number: 13
func_5DCD(param_00)
{
	for(;;)
	{
		self waittill(param_00);
		var_01 = func_41CB();
		if(issubstr(param_00,"closing_"))
		{
			var_01 method_8617("elev_door_close");
		}

		if(issubstr(param_00,"opening_"))
		{
			var_01 method_8617("elev_door_open");
		}

		if(param_00 == "elevator_moving")
		{
			var_01 method_8617("elev_run_start");
			var_01 method_861D("elev_run_loop");
		}

		if(param_00 == "interrupted")
		{
			var_01 method_8617("elev_door_interupt");
		}

		if(param_00 == "elevator_moved")
		{
			var_01 stoploopsound("elev_run_loop");
			var_01 method_8617("elev_run_end");
			var_01 method_8617("elev_bell_ding");
		}
	}
}

//Function Number: 14
func_758A()
{
	foreach(var_01 in level.var_35D1)
	{
		var_01.var_64D2 = var_01 func_4128();
		foreach(var_04, var_03 in var_01 func_4271())
		{
			if(var_01 func_4128() != var_04)
			{
				var_01 thread func_2439(var_04);
			}
		}
	}
}

//Function Number: 15
func_35C7(param_00)
{
	self notify("elevator_moving");
	self endon("elevator_moving");
	var_01 = func_41CB();
	var_02 = self.var_3532["floor" + param_00 + "_pos"] - var_01.var_116;
	var_03 = level.var_35CC;
	var_04 = abs(distance(self.var_3532["floor" + param_00 + "_pos"],var_01.var_116));
	var_05 = var_04 / var_03;
	var_01 moveto(var_01.var_116 + var_02,var_05,var_05 * level.var_35B4,var_05 * level.var_35BB);
	foreach(var_07 in func_41C5())
	{
		var_08 = var_07.var_116 + var_02;
		if(!issubstr(var_07.var_3A,"trigger_"))
		{
			var_07 moveto(var_08,var_05,var_05 * level.var_35B4,var_05 * level.var_35BB);
			continue;
		}

		var_07.var_116 = var_08;
	}

	func_A73D(var_01,self.var_3532["floor" + param_00 + "_pos"]);
	self notify("elevator_moved");
}

//Function Number: 16
func_2437()
{
	self notify("closing_inner_doors");
	self endon("closing_inner_doors");
	self endon("opening_inner_doors");
	var_00 = func_41C9();
	var_01 = func_41CF();
	var_02 = func_41CB();
	var_03 = func_41C6();
	var_04 = (var_03[0],var_03[1],var_02.var_116[2]);
	var_05 = level.var_35C1;
	var_06 = abs(distance(var_00.var_116,var_04));
	var_07 = var_06 / var_05;
	var_00 moveto(var_04,var_07,var_07 * 0.1,var_07 * 0.25);
	var_01 moveto(var_04,var_07,var_07 * 0.1,var_07 * 0.25);
	func_A73D(var_00,var_04,var_01,var_04);
	self notify("closed_inner_doors");
}

//Function Number: 17
func_6BEC()
{
	self notify("opening_inner_doors");
	self endon("opening_inner_doors");
	var_00 = func_41C9();
	var_01 = func_41CF();
	var_02 = func_41CB();
	var_03 = func_41CA();
	var_04 = func_41D0();
	var_05 = (var_03[0],var_03[1],var_02.var_116[2]);
	var_06 = (var_04[0],var_04[1],var_02.var_116[2]);
	var_07 = level.var_35C1;
	var_08 = abs(distance(var_05,var_06) * 0.5);
	var_09 = var_08 / var_07 * 0.5;
	var_00 moveto(var_05,var_09,var_09 * 0.1,var_09 * 0.25);
	var_01 moveto(var_06,var_09,var_09 * 0.1,var_09 * 0.25);
	func_A73D(var_00,var_05,var_01,var_06);
	self notify("opened_inner_doors");
}

//Function Number: 18
func_2439(param_00)
{
	self notify("closing_floor_" + param_00 + "_outer_doors");
	self endon("closing_floor_" + param_00 + "_outer_doors");
	self endon("opening_floor_" + param_00 + "_outer_doors");
	var_01 = func_4272(param_00);
	var_02 = func_4274(param_00);
	var_03 = func_4273(param_00);
	var_04 = func_426F(param_00);
	var_05 = level.var_35C9;
	var_06 = abs(distance(var_03,var_04));
	var_07 = var_06 / var_05;
	var_01 moveto(var_04,var_07,var_07 * 0.1,var_07 * 0.25);
	var_02 moveto(var_04,var_07,var_07 * 0.1,var_07 * 0.25);
	func_A73D(var_01,var_04,var_02,var_04);
	self notify("closed_floor_" + param_00 + "_outer_doors");
}

//Function Number: 19
func_6BEE(param_00)
{
	level notify("elevator_doors_opening");
	self notify("opening_floor_" + param_00 + "_outer_doors");
	self endon("opening_floor_" + param_00 + "_outer_doors");
	var_01 = func_4272(param_00);
	var_02 = func_4274(param_00);
	var_03 = func_4273(param_00);
	var_04 = func_4275(param_00);
	var_05 = func_426F(param_00);
	var_06 = level.var_35C9;
	var_07 = abs(distance(var_03,var_05));
	var_08 = var_07 / var_06 * 0.5;
	var_01 moveto(var_03,var_08,var_08 * 0.1,var_08 * 0.25);
	var_02 moveto(var_04,var_08,var_08 * 0.1,var_08 * 0.25);
	func_A73D(var_01,var_03,var_02,var_04);
	self notify("opened_floor_" + param_00 + "_outer_doors");
}

//Function Number: 20
func_1D07()
{
	var_00 = getentarray("elevator_group","targetname");
	var_01 = getentarray("elevator_housing","targetname");
	var_02 = getentarray("elevator_doorset","targetname");
	foreach(var_04 in var_00)
	{
		var_05 = getent(var_04.var_1A2,"targetname");
		var_06 = [];
		var_06[0] = min(var_04.var_116[0],var_05.var_116[0]);
		var_06[1] = max(var_04.var_116[0],var_05.var_116[0]);
		var_06[2] = min(var_04.var_116[1],var_05.var_116[1]);
		var_06[3] = max(var_04.var_116[1],var_05.var_116[1]);
		var_07 = spawnstruct();
		var_07.var_3532["id"] = level.var_35D1.size;
		var_07.var_3532["housing"] = [];
		var_07.var_3532["housing"]["mainframe"] = [];
		foreach(var_09 in var_01)
		{
			if(var_09 func_5719(var_06))
			{
				var_07.var_3532["housing"]["mainframe"][var_07.var_3532["housing"]["mainframe"].size] = var_09;
				if(var_09.var_3A == "script_model")
				{
					continue;
				}

				if(var_09.var_3B == "light")
				{
					continue;
				}

				var_0A = getent(var_09.var_1A2,"targetname");
				var_07.var_3532["housing"]["left_door"] = var_0A;
				var_07.var_3532["housing"]["left_door_opened_pos"] = var_0A.var_116;
				var_0B = getent(var_0A.var_1A2,"targetname");
				var_07.var_3532["housing"]["right_door"] = var_0B;
				var_07.var_3532["housing"]["right_door_opened_pos"] = var_0B.var_116;
				var_0C = var_0A.var_116 - var_0B.var_116 * (0.5,0.5,0.5) + var_0B.var_116;
				var_07.var_3532["housing"]["door_closed_pos"] = var_0C;
				var_0D = getent(var_0B.var_1A2,"targetname");
				var_07.var_3532["housing"]["door_trigger"] = var_0D;
				var_0E = getent(var_0D.var_1A2,"targetname");
				var_07.var_3532["housing"]["inside_trigger"] = var_0E;
				var_0E func_5FA7();
				var_0E.var_6464 = spawn("trigger_radius",var_09.var_116,0,64,128);
			}
		}

		var_07.var_3532["outer_doorset"] = [];
		foreach(var_11 in var_02)
		{
			if(var_11 func_5719(var_06))
			{
				var_12 = isdefined(var_11.var_165) && var_11.var_165 == "closed_for_lighting";
				var_13 = var_07.var_3532["outer_doorset"].size;
				var_07.var_3532["outer_doorset"][var_13] = [];
				var_07.var_3532["outer_doorset"][var_13]["door_closed_pos"] = var_11.var_116;
				var_14 = getent(var_11.var_1A2,"targetname");
				var_07.var_3532["outer_doorset"][var_13]["left_door"] = var_14;
				var_07.var_3532["outer_doorset"][var_13]["left_door_opened_pos"] = var_14.var_116;
				var_15 = getent(var_14.var_1A2,"targetname");
				var_07.var_3532["outer_doorset"][var_13]["right_door"] = var_15;
				var_07.var_3532["outer_doorset"][var_13]["right_door_opened_pos"] = var_15.var_116;
				if(var_12)
				{
					var_16 = var_11.var_116 - var_14.var_116;
					var_11.var_116 = var_14.var_116;
					var_14.var_116 = var_14.var_116 + var_16;
					var_15.var_116 = var_15.var_116 - var_16;
					var_07.var_3532["outer_doorset"][var_13]["door_closed_pos"] = var_11.var_116;
					var_07.var_3532["outer_doorset"][var_13]["left_door_opened_pos"] = var_14.var_116;
					var_07.var_3532["outer_doorset"][var_13]["right_door_opened_pos"] = var_15.var_116;
				}
			}
		}

		for(var_18 = 0;var_18 < var_07.var_3532["outer_doorset"].size - 1;var_18++)
		{
			for(var_19 = 0;var_19 < var_07.var_3532["outer_doorset"].size - 1 - var_18;var_19++)
			{
				if(var_07.var_3532["outer_doorset"][var_19 + 1]["door_closed_pos"][2] < var_07.var_3532["outer_doorset"][var_19]["door_closed_pos"][2])
				{
					var_1A = var_07.var_3532["outer_doorset"][var_19]["left_door"];
					var_1B = var_07.var_3532["outer_doorset"][var_19]["left_door_opened_pos"];
					var_1C = var_07.var_3532["outer_doorset"][var_19]["right_door"];
					var_1D = var_07.var_3532["outer_doorset"][var_19]["right_door_opened_pos"];
					var_1E = var_07.var_3532["outer_doorset"][var_19]["door_closed_pos"];
					var_07.var_3532["outer_doorset"][var_19]["left_door"] = var_07.var_3532["outer_doorset"][var_19 + 1]["left_door"];
					var_07.var_3532["outer_doorset"][var_19]["left_door_opened_pos"] = var_07.var_3532["outer_doorset"][var_19 + 1]["left_door_opened_pos"];
					var_07.var_3532["outer_doorset"][var_19]["right_door"] = var_07.var_3532["outer_doorset"][var_19 + 1]["right_door"];
					var_07.var_3532["outer_doorset"][var_19]["right_door_opened_pos"] = var_07.var_3532["outer_doorset"][var_19 + 1]["right_door_opened_pos"];
					var_07.var_3532["outer_doorset"][var_19]["door_closed_pos"] = var_07.var_3532["outer_doorset"][var_19 + 1]["door_closed_pos"];
					var_07.var_3532["outer_doorset"][var_19 + 1]["left_door"] = var_1A;
					var_07.var_3532["outer_doorset"][var_19 + 1]["left_door_opened_pos"] = var_1B;
					var_07.var_3532["outer_doorset"][var_19 + 1]["right_door"] = var_1C;
					var_07.var_3532["outer_doorset"][var_19 + 1]["right_door_opened_pos"] = var_1D;
					var_07.var_3532["outer_doorset"][var_19 + 1]["door_closed_pos"] = var_1E;
				}
			}
		}

		var_1F = [];
		foreach(var_18, var_21 in var_07.var_3532["outer_doorset"])
		{
			var_22 = var_07 func_41CB();
			var_1F = (var_22.var_116[0],var_22.var_116[1],var_21["door_closed_pos"][2]);
			var_07.var_3532["floor" + var_18 + "_pos"] = var_1F;
			if(var_22.var_116 == var_1F)
			{
				var_07.var_3532["initial_floor"] = var_18;
				var_07.var_3532["current_floor"] = var_18;
			}
		}

		level.var_35D1[level.var_35D1.size] = var_07;
		var_04 delete();
		var_05 delete();
	}

	foreach(var_11 in var_02)
	{
		var_11 delete();
	}

	func_1CF9();
	if(!level.var_35C6)
	{
		func_8853();
	}

	foreach(var_27 in level.var_35D1)
	{
		var_28 = var_27 func_41CE();
		if(isdefined(var_28) && var_28.size)
		{
			foreach(var_2A in var_28)
			{
				var_2A method_81DF(0.75);
			}
		}
	}
}

//Function Number: 21
func_1CF9()
{
	level.var_35B9 = getentarray("elevator_call","targetname");
	foreach(var_01 in level.var_35B9)
	{
		var_01.var_3532 = [];
		var_02 = (0,0,var_01.var_116[2]);
		var_03 = (var_01.var_116[0],var_01.var_116[1],0);
		var_04 = [];
		foreach(var_06 in level.var_35D1)
		{
			foreach(var_0B, var_08 in var_06 func_4271())
			{
				var_09 = (0,0,var_06.var_3532["floor" + var_0B + "_pos"][2]);
				var_0A = (var_06.var_3532["floor" + var_0B + "_pos"][0],var_06.var_3532["floor" + var_0B + "_pos"][1],0);
				if(abs(distance(var_02,var_09)) <= level.var_35B8)
				{
					if(abs(distance(var_03,var_0A)) <= level.var_35B7)
					{
						var_04[var_04.size] = var_06;
						var_01.var_3532[var_0B] = var_04;
					}
				}
			}
		}

		var_01 func_5FA7();
		var_01.var_6464 = spawn("trigger_radius",var_01.var_116 + (0,0,-32),0,32,64);
	}
}

//Function Number: 22
func_8853()
{
	foreach(var_01 in level.var_35D1)
	{
		var_02 = var_01 func_41C8();
		var_03 = var_01 func_4271();
		var_04 = var_03.size;
		var_02 setcursorhint("HINT_NOICON");
		if(var_04 > 2)
		{
			var_02 sethintstring(&"ELEVATOR_FLOOR_SELECT_HINT");
			continue;
		}

		var_02 sethintstring(&"ELEVATOR_USE_HINT");
	}

	foreach(var_07 in level.var_35B9)
	{
		var_07 setcursorhint("HINT_NOICON");
		var_07 sethintstring(&"ELEVATOR_CALL_HINT");
	}
}

//Function Number: 23
func_5FA7()
{
	self.var_3655 = 1;
	func_2F65();
}

//Function Number: 24
func_2FC7(param_00)
{
	func_364D();
	if(level.var_35C6)
	{
		self.var_6464 waittill(param_00,var_01);
	}
	else
	{
		self waittill(var_01,var_01);
	}

	func_2F65();
	return var_01;
}

//Function Number: 25
func_364D()
{
	if(!self.var_3655)
	{
		self.var_3655 = 1;
		self.var_116 = self.var_116 + (0,0,10000);
		if(isdefined(self.var_6464))
		{
			self.var_6464.var_116 = self.var_6464.var_116 + (0,0,10000);
		}
	}
}

//Function Number: 26
func_2F65()
{
	self notify("disable_trigger");
	if(self.var_3655)
	{
		thread func_2F66();
	}
}

//Function Number: 27
func_2F66()
{
	self endon("disable_trigger");
	self.var_3655 = 0;
	wait(1.5);
	self.var_116 = self.var_116 + (0,0,-10000);
	if(isdefined(self.var_6464))
	{
		self.var_6464.var_116 = self.var_6464.var_116 + (0,0,-10000);
	}
}

//Function Number: 28
func_4270(param_00)
{
	return self.var_3532["outer_doorset"][param_00];
}

//Function Number: 29
func_4271()
{
	return self.var_3532["outer_doorset"];
}

//Function Number: 30
func_426F(param_00)
{
	return self.var_3532["outer_doorset"][param_00]["door_closed_pos"];
}

//Function Number: 31
func_4272(param_00)
{
	return self.var_3532["outer_doorset"][param_00]["left_door"];
}

//Function Number: 32
func_4274(param_00)
{
	return self.var_3532["outer_doorset"][param_00]["right_door"];
}

//Function Number: 33
func_4273(param_00)
{
	return self.var_3532["outer_doorset"][param_00]["left_door_opened_pos"];
}

//Function Number: 34
func_4275(param_00)
{
	return self.var_3532["outer_doorset"][param_00]["right_door_opened_pos"];
}

//Function Number: 35
func_41C5()
{
	var_00 = [];
	var_01 = func_41C7();
	var_02 = func_41C8();
	var_03 = var_02.var_6464;
	var_04 = func_41C9();
	var_05 = func_41CF();
	var_00[var_00.size] = var_01;
	var_00[var_00.size] = var_02;
	var_00[var_00.size] = var_04;
	var_00[var_00.size] = var_05;
	if(isdefined(var_03))
	{
		var_00[var_00.size] = var_03;
	}

	var_06 = func_41CC();
	foreach(var_08 in var_06)
	{
		var_00[var_00.size] = var_08;
	}

	var_0A = func_41CE();
	foreach(var_0C in var_0A)
	{
		var_00[var_00.size] = var_0C;
	}

	return var_00;
}

//Function Number: 36
func_41CB()
{
	var_00 = self.var_3532["housing"]["mainframe"];
	var_01 = undefined;
	foreach(var_03 in var_00)
	{
		if(var_03.var_3A != "script_model" && var_03.var_3B != "light")
		{
			var_01 = var_03;
		}
	}

	return var_01;
}

//Function Number: 37
func_41CC()
{
	var_00 = self.var_3532["housing"]["mainframe"];
	var_01 = [];
	foreach(var_03 in var_00)
	{
		if(var_03.var_3A == "script_model")
		{
			var_01[var_01.size] = var_03;
		}
	}

	return var_01;
}

//Function Number: 38
func_41CE()
{
	var_00 = self.var_3532["housing"]["mainframe"];
	var_01 = [];
	foreach(var_03 in var_00)
	{
		if(var_03.var_3B == "light")
		{
			var_01[var_01.size] = var_03;
		}
	}

	return var_01;
}

//Function Number: 39
func_41CD()
{
	var_00 = func_41CC();
	var_01 = undefined;
	foreach(var_03 in var_00)
	{
		if(isdefined(var_03.var_165) && var_03.var_165 == "play_musak")
		{
			var_01 = var_03;
		}
	}

	return var_01;
}

//Function Number: 40
func_41C7()
{
	return self.var_3532["housing"]["door_trigger"];
}

//Function Number: 41
func_41C8()
{
	return self.var_3532["housing"]["inside_trigger"];
}

//Function Number: 42
func_41C6()
{
	return self.var_3532["housing"]["door_closed_pos"];
}

//Function Number: 43
func_41C9()
{
	return self.var_3532["housing"]["left_door"];
}

//Function Number: 44
func_41CF()
{
	return self.var_3532["housing"]["right_door"];
}

//Function Number: 45
func_41CA()
{
	return self.var_3532["housing"]["left_door_opened_pos"];
}

//Function Number: 46
func_41D0()
{
	return self.var_3532["housing"]["right_door_opened_pos"];
}

//Function Number: 47
func_4128()
{
	var_00 = func_35BD();
	return self.var_3532["current_floor"];
}

//Function Number: 48
func_41DB()
{
	return self.var_3532["initial_floor"];
}

//Function Number: 49
func_A73D(param_00,param_01,param_02,param_03)
{
	if(!isdefined(param_02) && !isdefined(param_03))
	{
		param_02 = param_00;
		param_03 = param_01;
	}

	for(;;)
	{
		var_04 = param_00.var_116;
		var_05 = param_02.var_116;
		if(var_04 == param_01 && var_05 == param_03)
		{
			break;
		}

		wait 0.05;
	}
}

//Function Number: 50
func_5719(param_00)
{
	var_01 = self.var_116[0];
	var_02 = self.var_116[1];
	var_03 = param_00[0];
	var_04 = param_00[1];
	var_05 = param_00[2];
	var_06 = param_00[3];
	return var_01 >= var_03 && var_01 <= var_04 && var_02 >= var_05 && var_02 <= var_06;
}

//Function Number: 51
func_571B(param_00)
{
	var_01 = self.var_116[0];
	var_02 = self.var_116[1];
	var_03 = param_00[0];
	var_04 = param_00[1];
	var_05 = param_00[2];
	var_06 = param_00[3];
	var_07 = var_03 + var_04 / 2;
	var_08 = var_05 + var_06 / 2;
	var_09 = abs(distance((var_03,var_05,0),(var_07,var_08,0)));
	return abs(distance((var_01,var_02,0),(var_07,var_08,0))) < var_09;
}

//Function Number: 52
func_A752(param_00,param_01)
{
	self endon(param_00);
	wait(param_01);
}

//Function Number: 53
func_35C0(param_00,param_01)
{
	return int(func_35BF(param_00,param_01));
}

//Function Number: 54
func_35BF(param_00,param_01)
{
	if(getdvar(param_00) != "")
	{
		return getdvarfloat(param_00);
	}

	setdvar(param_00,param_01);
	return param_01;
}

//Function Number: 55
func_35BA()
{
	if(!level.var_35BA)
	{
		return;
	}

	for(;;)
	{
		if(level.var_35BA != 2)
		{
			continue;
		}

		foreach(var_01 in level.var_35D1)
		{
			var_02 = var_01 func_41CB();
			var_03 = var_01 func_41CD();
			foreach(var_05 in var_01.var_3532["outer_doorset"])
			{
			}
		}

		foreach(var_11, var_09 in level.var_35B9)
		{
			foreach(var_05 in var_09.var_3532)
			{
				var_0B = 0;
				foreach(var_0D in var_05)
				{
					var_0B++;
					var_0E = var_09.var_116 + (0,0,var_0B * -4);
				}
			}
		}

		wait 0.05;
	}
}