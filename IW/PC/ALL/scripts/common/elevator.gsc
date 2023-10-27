/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\common\elevator.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 55
 * Decompile Time: 2708 ms
 * Timestamp: 10/27/2023 12:03:21 AM
*******************************************************************/

//Function Number: 1
init()
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
	thread func_60E0();
	level.var_60EA = [];
	level.var_6043 = func_6077("scr_elevator_callbutton_link_v","96");
	level.var_6042 = func_6077("scr_elevator_callbutton_link_h","256");
	func_318E();
	func_D6A9();
	func_6041();
	if(!level.var_60EA.size)
	{
		return;
	}

	foreach(var_02 in level.var_60EA)
	{
		var_02 thread func_60D5();
		var_02 thread func_60CC();
	}

	thread func_6051();
}

//Function Number: 2
func_60E0()
{
	for(;;)
	{
		level.var_6028 = func_6076("scr_elevator_accel","0.2");
		level.var_6052 = func_6076("scr_elevator_decel","0.2");
		level.var_60AD = func_6077("scr_elevator_music","1");
		level.var_60CF = func_6077("scr_elevator_speed","96");
		level.var_6087 = func_6077("scr_elevator_innerdoorspeed","14");
		level.var_60B3 = func_6077("scr_elevator_outterdoorspeed","16");
		level.var_60BF = func_6077("scr_elevator_return","0");
		level.var_60E4 = func_6077("scr_elevator_waittime","6");
		level.var_6029 = func_6077("scr_elevator_aggressive_call","0");
		level.var_6051 = func_6077("debug_elevator","0");
		if(scripts\common\utility::issp())
		{
			level.var_60A7 = func_6077("scr_elevator_motion_detection","0");
		}
		else
		{
			level.var_60A7 = func_6077("scr_elevator_motion_detection","1");
		}

		wait(1);
	}
}

//Function Number: 3
func_60D5()
{
	func_6075("[A]");
}

//Function Number: 4
func_6041()
{
	foreach(var_01 in level.var_6044)
	{
		var_01 thread func_B958();
	}
}

//Function Number: 5
func_6F65(param_00)
{
	self endon("elevator_moving");
	self.var_6F65 = 0;
	self.var_C822 = undefined;
	for(;;)
	{
		param_00 waittill("trigger",var_01);
		self.var_6F65 = 1;
		self.var_C822 = var_01;
		break;
	}

	self notify("floor_override");
}

//Function Number: 6
func_6075(param_00)
{
	self.var_6746 = param_00;
	var_01 = func_7A16();
	var_02 = func_7A17();
	for(;;)
	{
		if(self.var_6746 == "[A]")
		{
			if(level.var_60BF && func_78F7() != func_7A3F())
			{
				self.var_BD12 = func_7A3F();
				thread func_6F65(var_02);
				func_137C0("floor_override",level.var_60E4);
				if(self.var_6F65 && isdefined(self.var_C822) && isplayer(self.var_C822))
				{
					func_79C2(self.var_C822);
				}

				self.var_6746 = "[B]";
				continue;
			}

			for(;;)
			{
				if(self.var_BD12 == func_78F7())
				{
					var_03 = var_02 func_5641("trigger");
				}
				else
				{
					var_03 = "elevator_called";
				}

				if(isstring(var_03) && var_03 == "elevator_called" && self.var_BD12 != func_78F7())
				{
					self.var_6746 = "[B]";
					break;
				}

				if(isdefined(var_03) && isplayer(var_03) && isalive(var_03))
				{
					var_04 = var_03 istouching(var_02);
					var_05 = isdefined(var_02.var_BBC0) && var_03 istouching(var_02.var_BBC0);
					var_06 = var_04 || var_05;
					if(var_06)
					{
						var_07 = var_03;
						func_79C2(var_07);
						if(self.var_BD12 == func_78F7())
						{
							continue;
						}

						self.var_6746 = "[B]";
						break;
					}
				}
			}
		}

		if(self.var_6746 == "[B]")
		{
			thread func_6088(var_01);
			var_08 = func_78F7();
			thread func_4272();
			thread func_4278(var_08);
			scripts\common\utility::waittill_any_3("closed_inner_doors","interrupted");
			if(self.var_6089)
			{
				self.var_6746 = "[C]";
				continue;
			}

			self.var_6746 = "[D]";
			continue;
		}

		if(self.var_6746 == "[C]")
		{
			var_08 = func_78F7();
			thread func_C606();
			thread func_C612(var_08);
			self waittill("opened_floor_" + var_08 + "_outer_doors");
			if(self.var_6089)
			{
				self.var_6746 = "[B]";
				continue;
			}

			self.var_6746 = "[A]";
			continue;
		}

		if(self.var_6746 == "[D]")
		{
			if(self.var_BD12 != func_78F7())
			{
				thread func_60A9(self.var_BD12);
				self waittill("elevator_moved");
			}

			self.var_6746 = "[C]";
			continue;
		}
	}
}

//Function Number: 7
func_B958()
{
	for(;;)
	{
		var_00 = func_5641("trigger");
		var_01 = undefined;
		var_02 = [];
		foreach(var_05, var_04 in self.var_5FAC)
		{
			var_01 = var_05;
			var_02 = var_04;
		}

		var_06 = 0;
		foreach(var_08 in var_02)
		{
			var_09 = var_08 func_6074();
			if(!level.var_6029 && !var_09)
			{
				if(var_08 func_78F7() == var_01)
				{
					var_06 = 1;
					var_02 = [];
					break;
				}
			}
		}

		foreach(var_08 in var_02)
		{
			if(var_08.var_6746 == "[A]")
			{
				var_08 func_3732(var_01);
				var_06 = 1;
				if(!level.var_6029)
				{
					break;
				}
			}
		}

		if(var_06)
		{
			self playsound("elev_bell_ding");
		}
	}
}

//Function Number: 8
func_3732(param_00)
{
	self.var_BD12 = param_00;
	var_01 = func_7A17();
	var_01 notify("trigger","elevator_called");
	if(level.var_60A7)
	{
		var_01.var_BBC0 notify("trigger","elevator_called");
	}
}

//Function Number: 9
func_79C2(param_00)
{
	var_01 = func_7B57();
	if(var_01.size == 2)
	{
		var_02 = func_78F7();
		self.var_BD12 = !var_02;
		return;
	}

	var_01 setclientdvar("player_current_floor",func_78F7());
	for(;;)
	{
		var_01 waittill("menuresponse",var_03,var_04);
		if(var_03 == "elevator_floor_selector")
		{
			if(var_04 != "none")
			{
				self.var_BD12 = int(var_04);
			}

			break;
		}
	}
}

//Function Number: 10
func_6088(param_00)
{
	self notify("interrupt_watch");
	level notify("elevator_interior_button_pressed");
	self endon("interrupt_watch");
	self endon("elevator_moving");
	self.var_6089 = 0;
	wait(0.5);
	param_00 waittill("trigger",var_01);
	self notify("interrupted");
	self.var_6089 = 1;
}

//Function Number: 11
func_6074()
{
	var_00 = func_7A1A();
	var_01 = var_00.origin;
	var_02 = 1;
	foreach(var_06, var_04 in func_7B57())
	{
		var_05 = self.var_5FAC["floor" + var_06 + "_pos"];
		if(var_01 == var_05)
		{
			self.var_5FAC["current_floor"] = var_06;
			var_02 = 0;
		}
	}

	return var_02;
}

//Function Number: 12
func_60CC()
{
	var_00 = func_7A1C();
	if(level.var_60AD && isdefined(var_00))
	{
		var_00 playloopsound("elev_musak_loop");
	}

	thread func_AD54("closing_inner_doors");
	thread func_AD54("opening_inner_doors");
	thread func_AD54("closed_inner_doors");
	thread func_AD54("opened_inner_doors");
	foreach(var_03, var_02 in func_7B57())
	{
		thread func_AD54("closing_floor_" + var_03 + "_outer_doors");
		thread func_AD54("opening_floor_" + var_03 + "_outer_doors");
		thread func_AD54("closed_floor_" + var_03 + "_outer_doors");
		thread func_AD54("opened_floor_" + var_03 + "_outer_doors");
	}

	thread func_AD54("interrupted");
	thread func_AD54("elevator_moving");
	thread func_AD54("elevator_moved");
}

//Function Number: 13
func_AD54(param_00)
{
	for(;;)
	{
		self waittill(param_00);
		var_01 = func_7A1A();
		if(issubstr(param_00,"closing_"))
		{
			var_01 playsound("elev_door_close");
		}

		if(issubstr(param_00,"opening_"))
		{
			var_01 playsound("elev_door_open");
		}

		if(param_00 == "elevator_moving")
		{
			var_01 playsound("elev_run_start");
			var_01 playloopsound("elev_run_loop");
		}

		if(param_00 == "interrupted")
		{
			var_01 playsound("elev_door_interupt");
		}

		if(param_00 == "elevator_moved")
		{
			var_01 stoploopsound("elev_run_loop");
			var_01 playsound("elev_run_end");
			var_01 playsound("elev_bell_ding");
		}
	}
}

//Function Number: 14
func_D6A9()
{
	foreach(var_01 in level.var_60EA)
	{
		var_01.var_BD12 = var_01 func_78F7();
		foreach(var_04, var_03 in var_01 func_7B57())
		{
			if(var_01 func_78F7() != var_04)
			{
				var_01 thread func_4278(var_04);
			}
		}
	}
}

//Function Number: 15
func_60A9(param_00)
{
	self notify("elevator_moving");
	self endon("elevator_moving");
	var_01 = func_7A1A();
	var_02 = self.var_5FAC["floor" + param_00 + "_pos"] - var_01.origin;
	var_03 = level.var_60CF;
	var_04 = abs(distance(self.var_5FAC["floor" + param_00 + "_pos"],var_01.origin));
	var_05 = var_04 / var_03;
	var_01 moveto(var_01.origin + var_02,var_05,var_05 * level.var_6028,var_05 * level.var_6052);
	foreach(var_07 in func_7A14())
	{
		var_08 = var_07.origin + var_02;
		if(!issubstr(var_07.classname,"trigger_"))
		{
			var_07 moveto(var_08,var_05,var_05 * level.var_6028,var_05 * level.var_6052);
			continue;
		}

		var_07.origin = var_08;
	}

	func_1376F(var_01,self.var_5FAC["floor" + param_00 + "_pos"]);
	self notify("elevator_moved");
}

//Function Number: 16
func_4272()
{
	self notify("closing_inner_doors");
	self endon("closing_inner_doors");
	self endon("opening_inner_doors");
	var_00 = func_7A18();
	var_01 = func_7A1E();
	var_02 = func_7A1A();
	var_03 = func_7A15();
	var_04 = (var_03[0],var_03[1],var_02.origin[2]);
	var_05 = level.var_6087;
	var_06 = abs(distance(var_00.origin,var_04));
	var_07 = var_06 / var_05;
	var_00 moveto(var_04,var_07,var_07 * 0.1,var_07 * 0.25);
	var_01 moveto(var_04,var_07,var_07 * 0.1,var_07 * 0.25);
	func_1376F(var_00,var_04,var_01,var_04);
	self notify("closed_inner_doors");
}

//Function Number: 17
func_C606()
{
	self notify("opening_inner_doors");
	self endon("opening_inner_doors");
	var_00 = func_7A18();
	var_01 = func_7A1E();
	var_02 = func_7A1A();
	var_03 = func_7A19();
	var_04 = func_7A1F();
	var_05 = (var_03[0],var_03[1],var_02.origin[2]);
	var_06 = (var_04[0],var_04[1],var_02.origin[2]);
	var_07 = level.var_6087;
	var_08 = abs(distance(var_05,var_06) * 0.5);
	var_09 = var_08 / var_07 * 0.5;
	var_00 moveto(var_05,var_09,var_09 * 0.1,var_09 * 0.25);
	var_01 moveto(var_06,var_09,var_09 * 0.1,var_09 * 0.25);
	func_1376F(var_00,var_05,var_01,var_06);
	self notify("opened_inner_doors");
}

//Function Number: 18
func_4278(param_00)
{
	self notify("closing_floor_" + param_00 + "_outer_doors");
	self endon("closing_floor_" + param_00 + "_outer_doors");
	self endon("opening_floor_" + param_00 + "_outer_doors");
	var_01 = func_7B58(param_00);
	var_02 = func_7B5A(param_00);
	var_03 = func_7B59(param_00);
	var_04 = func_7B55(param_00);
	var_05 = level.var_60B3;
	var_06 = abs(distance(var_03,var_04));
	var_07 = var_06 / var_05;
	var_01 moveto(var_04,var_07,var_07 * 0.1,var_07 * 0.25);
	var_02 moveto(var_04,var_07,var_07 * 0.1,var_07 * 0.25);
	func_1376F(var_01,var_04,var_02,var_04);
	self notify("closed_floor_" + param_00 + "_outer_doors");
}

//Function Number: 19
func_C612(param_00)
{
	level notify("elevator_doors_opening");
	self notify("opening_floor_" + param_00 + "_outer_doors");
	self endon("opening_floor_" + param_00 + "_outer_doors");
	var_01 = func_7B58(param_00);
	var_02 = func_7B5A(param_00);
	var_03 = func_7B59(param_00);
	var_04 = func_7B5B(param_00);
	var_05 = func_7B55(param_00);
	var_06 = level.var_60B3;
	var_07 = abs(distance(var_03,var_05));
	var_08 = var_07 / var_06 * 0.5;
	var_01 moveto(var_03,var_08,var_08 * 0.1,var_08 * 0.25);
	var_02 moveto(var_04,var_08,var_08 * 0.1,var_08 * 0.25);
	func_1376F(var_01,var_03,var_02,var_04);
	self notify("opened_floor_" + param_00 + "_outer_doors");
}

//Function Number: 20
func_318E()
{
	var_00 = getentarray("elevator_group","targetname");
	var_01 = getentarray("elevator_housing","targetname");
	var_02 = getentarray("elevator_doorset","targetname");
	foreach(var_04 in var_00)
	{
		var_05 = getent(var_04.target,"targetname");
		var_06 = [];
		var_06[0] = min(var_04.origin[0],var_05.origin[0]);
		var_06[1] = max(var_04.origin[0],var_05.origin[0]);
		var_06[2] = min(var_04.origin[1],var_05.origin[1]);
		var_06[3] = max(var_04.origin[1],var_05.origin[1]);
		var_07 = spawnstruct();
		var_07.var_5FAC["id"] = level.var_60EA.size;
		var_07.var_5FAC["housing"] = [];
		var_07.var_5FAC["housing"]["mainframe"] = [];
		foreach(var_09 in var_01)
		{
			if(var_09 func_9E3C(var_06))
			{
				var_07.var_5FAC["housing"]["mainframe"][var_07.var_5FAC["housing"]["mainframe"].size] = var_09;
				if(var_09.classname == "script_model")
				{
					continue;
				}

				if(var_09.var_9F == "light")
				{
					continue;
				}

				var_0A = getent(var_09.target,"targetname");
				var_07.var_5FAC["housing"]["left_door"] = var_0A;
				var_07.var_5FAC["housing"]["left_door_opened_pos"] = var_0A.origin;
				var_0B = getent(var_0A.target,"targetname");
				var_07.var_5FAC["housing"]["right_door"] = var_0B;
				var_07.var_5FAC["housing"]["right_door_opened_pos"] = var_0B.origin;
				var_0C = var_0A.origin - var_0B.origin * (0.5,0.5,0.5) + var_0B.origin;
				var_07.var_5FAC["housing"]["door_closed_pos"] = var_0C;
				var_0D = getent(var_0B.target,"targetname");
				var_07.var_5FAC["housing"]["door_trigger"] = var_0D;
				var_0E = getent(var_0D.target,"targetname");
				var_07.var_5FAC["housing"]["inside_trigger"] = var_0E;
				var_0E func_B266();
				var_0E.var_BBC0 = spawn("trigger_radius",var_09.origin,0,64,128);
			}
		}

		var_07.var_5FAC["outer_doorset"] = [];
		foreach(var_11 in var_02)
		{
			if(var_11 func_9E3C(var_06))
			{
				var_12 = isdefined(var_11.script_noteworthy) && var_11.script_noteworthy == "closed_for_lighting";
				var_13 = var_07.var_5FAC["outer_doorset"].size;
				var_07.var_5FAC["outer_doorset"][var_13] = [];
				var_07.var_5FAC["outer_doorset"][var_13]["door_closed_pos"] = var_11.origin;
				var_14 = getent(var_11.target,"targetname");
				var_07.var_5FAC["outer_doorset"][var_13]["left_door"] = var_14;
				var_07.var_5FAC["outer_doorset"][var_13]["left_door_opened_pos"] = var_14.origin;
				var_15 = getent(var_14.target,"targetname");
				var_07.var_5FAC["outer_doorset"][var_13]["right_door"] = var_15;
				var_07.var_5FAC["outer_doorset"][var_13]["right_door_opened_pos"] = var_15.origin;
				if(var_12)
				{
					var_16 = var_11.origin - var_14.origin;
					var_11.origin = var_14.origin;
					var_14.origin = var_14.origin + var_16;
					var_15.origin = var_15.origin - var_16;
					var_07.var_5FAC["outer_doorset"][var_13]["door_closed_pos"] = var_11.origin;
					var_07.var_5FAC["outer_doorset"][var_13]["left_door_opened_pos"] = var_14.origin;
					var_07.var_5FAC["outer_doorset"][var_13]["right_door_opened_pos"] = var_15.origin;
				}
			}
		}

		for(var_18 = 0;var_18 < var_07.var_5FAC["outer_doorset"].size - 1;var_18++)
		{
			for(var_19 = 0;var_19 < var_07.var_5FAC["outer_doorset"].size - 1 - var_18;var_19++)
			{
				if(var_07.var_5FAC["outer_doorset"][var_19 + 1]["door_closed_pos"][2] < var_07.var_5FAC["outer_doorset"][var_19]["door_closed_pos"][2])
				{
					var_1A = var_07.var_5FAC["outer_doorset"][var_19]["left_door"];
					var_1B = var_07.var_5FAC["outer_doorset"][var_19]["left_door_opened_pos"];
					var_1C = var_07.var_5FAC["outer_doorset"][var_19]["right_door"];
					var_1D = var_07.var_5FAC["outer_doorset"][var_19]["right_door_opened_pos"];
					var_1E = var_07.var_5FAC["outer_doorset"][var_19]["door_closed_pos"];
					var_07.var_5FAC["outer_doorset"][var_19]["left_door"] = var_07.var_5FAC["outer_doorset"][var_19 + 1]["left_door"];
					var_07.var_5FAC["outer_doorset"][var_19]["left_door_opened_pos"] = var_07.var_5FAC["outer_doorset"][var_19 + 1]["left_door_opened_pos"];
					var_07.var_5FAC["outer_doorset"][var_19]["right_door"] = var_07.var_5FAC["outer_doorset"][var_19 + 1]["right_door"];
					var_07.var_5FAC["outer_doorset"][var_19]["right_door_opened_pos"] = var_07.var_5FAC["outer_doorset"][var_19 + 1]["right_door_opened_pos"];
					var_07.var_5FAC["outer_doorset"][var_19]["door_closed_pos"] = var_07.var_5FAC["outer_doorset"][var_19 + 1]["door_closed_pos"];
					var_07.var_5FAC["outer_doorset"][var_19 + 1]["left_door"] = var_1A;
					var_07.var_5FAC["outer_doorset"][var_19 + 1]["left_door_opened_pos"] = var_1B;
					var_07.var_5FAC["outer_doorset"][var_19 + 1]["right_door"] = var_1C;
					var_07.var_5FAC["outer_doorset"][var_19 + 1]["right_door_opened_pos"] = var_1D;
					var_07.var_5FAC["outer_doorset"][var_19 + 1]["door_closed_pos"] = var_1E;
				}
			}
		}

		var_1F = [];
		foreach(var_18, var_21 in var_07.var_5FAC["outer_doorset"])
		{
			var_22 = var_07 func_7A1A();
			var_1F = (var_22.origin[0],var_22.origin[1],var_21["door_closed_pos"][2]);
			var_07.var_5FAC["floor" + var_18 + "_pos"] = var_1F;
			if(var_22.origin == var_1F)
			{
				var_07.var_5FAC["initial_floor"] = var_18;
				var_07.var_5FAC["current_floor"] = var_18;
			}
		}

		level.var_60EA[level.var_60EA.size] = var_07;
		var_04 delete();
		var_05 delete();
	}

	foreach(var_11 in var_02)
	{
		var_11 delete();
	}

	func_317B();
	if(!level.var_60A7)
	{
		func_F99D();
	}

	foreach(var_27 in level.var_60EA)
	{
		var_28 = var_27 func_7A1D();
		if(isdefined(var_28) && var_28.size)
		{
			foreach(var_2A in var_28)
			{
				var_2A setlightintensity(0.75);
			}
		}
	}
}

//Function Number: 21
func_317B()
{
	level.var_6044 = getentarray("elevator_call","targetname");
	foreach(var_01 in level.var_6044)
	{
		var_01.var_5FAC = [];
		var_02 = (0,0,var_01.origin[2]);
		var_03 = (var_01.origin[0],var_01.origin[1],0);
		var_04 = [];
		foreach(var_06 in level.var_60EA)
		{
			foreach(var_0B, var_08 in var_06 func_7B57())
			{
				var_09 = (0,0,var_06.var_5FAC["floor" + var_0B + "_pos"][2]);
				var_0A = (var_06.var_5FAC["floor" + var_0B + "_pos"][0],var_06.var_5FAC["floor" + var_0B + "_pos"][1],0);
				if(abs(distance(var_02,var_09)) <= level.var_6043)
				{
					if(abs(distance(var_03,var_0A)) <= level.var_6042)
					{
						var_04[var_04.size] = var_06;
						var_01.var_5FAC[var_0B] = var_04;
					}
				}
			}
		}

		var_01 func_B266();
		var_01.var_BBC0 = spawn("trigger_radius",var_01.origin + (0,0,-32),0,32,64);
	}
}

//Function Number: 22
func_F99D()
{
	foreach(var_01 in level.var_60EA)
	{
		var_02 = var_01 func_7A17();
		var_03 = var_01 func_7B57();
		var_04 = var_03.size;
		var_02 setcursorhint("HINT_NOICON");
		if(var_04 > 2)
		{
			var_02 sethintstring(&"ELEVATOR_FLOOR_SELECT_HINT");
			continue;
		}

		var_02 sethintstring(&"ELEVATOR_USE_HINT");
	}

	foreach(var_07 in level.var_6044)
	{
		var_07 setcursorhint("HINT_NOICON");
		var_07 sethintstring(&"ELEVATOR_CALL_HINT");
	}
}

//Function Number: 23
func_B266()
{
	self.var_6261 = 1;
	func_5596();
}

//Function Number: 24
func_5641(param_00)
{
	func_624A();
	if(level.var_60A7)
	{
		self.var_BBC0 waittill(param_00,var_01);
	}
	else
	{
		self waittill(var_01,var_01);
	}

	func_5596();
	return var_01;
}

//Function Number: 25
func_624A()
{
	if(!self.var_6261)
	{
		self.var_6261 = 1;
		self.origin = self.origin + (0,0,10000);
		if(isdefined(self.var_BBC0))
		{
			self.var_BBC0.origin = self.var_BBC0.origin + (0,0,10000);
		}
	}
}

//Function Number: 26
func_5596()
{
	self notify("disable_trigger");
	if(self.var_6261)
	{
		thread func_5597();
	}
}

//Function Number: 27
func_5597()
{
	self endon("disable_trigger");
	self.var_6261 = 0;
	wait(1.5);
	self.origin = self.origin + (0,0,-10000);
	if(isdefined(self.var_BBC0))
	{
		self.var_BBC0.origin = self.var_BBC0.origin + (0,0,-10000);
	}
}

//Function Number: 28
func_7B56(param_00)
{
	return self.var_5FAC["outer_doorset"][param_00];
}

//Function Number: 29
func_7B57()
{
	return self.var_5FAC["outer_doorset"];
}

//Function Number: 30
func_7B55(param_00)
{
	return self.var_5FAC["outer_doorset"][param_00]["door_closed_pos"];
}

//Function Number: 31
func_7B58(param_00)
{
	return self.var_5FAC["outer_doorset"][param_00]["left_door"];
}

//Function Number: 32
func_7B5A(param_00)
{
	return self.var_5FAC["outer_doorset"][param_00]["right_door"];
}

//Function Number: 33
func_7B59(param_00)
{
	return self.var_5FAC["outer_doorset"][param_00]["left_door_opened_pos"];
}

//Function Number: 34
func_7B5B(param_00)
{
	return self.var_5FAC["outer_doorset"][param_00]["right_door_opened_pos"];
}

//Function Number: 35
func_7A14()
{
	var_00 = [];
	var_01 = func_7A16();
	var_02 = func_7A17();
	var_03 = var_02.var_BBC0;
	var_04 = func_7A18();
	var_05 = func_7A1E();
	var_00[var_00.size] = var_01;
	var_00[var_00.size] = var_02;
	var_00[var_00.size] = var_04;
	var_00[var_00.size] = var_05;
	if(isdefined(var_03))
	{
		var_00[var_00.size] = var_03;
	}

	var_06 = func_7A1B();
	foreach(var_08 in var_06)
	{
		var_00[var_00.size] = var_08;
	}

	var_0A = func_7A1D();
	foreach(var_0C in var_0A)
	{
		var_00[var_00.size] = var_0C;
	}

	return var_00;
}

//Function Number: 36
func_7A1A()
{
	var_00 = self.var_5FAC["housing"]["mainframe"];
	var_01 = undefined;
	foreach(var_03 in var_00)
	{
		if(var_03.classname != "script_model" && var_03.var_9F != "light")
		{
			var_01 = var_03;
		}
	}

	return var_01;
}

//Function Number: 37
func_7A1B()
{
	var_00 = self.var_5FAC["housing"]["mainframe"];
	var_01 = [];
	foreach(var_03 in var_00)
	{
		if(var_03.classname == "script_model")
		{
			var_01[var_01.size] = var_03;
		}
	}

	return var_01;
}

//Function Number: 38
func_7A1D()
{
	var_00 = self.var_5FAC["housing"]["mainframe"];
	var_01 = [];
	foreach(var_03 in var_00)
	{
		if(var_03.var_9F == "light")
		{
			var_01[var_01.size] = var_03;
		}
	}

	return var_01;
}

//Function Number: 39
func_7A1C()
{
	var_00 = func_7A1B();
	var_01 = undefined;
	foreach(var_03 in var_00)
	{
		if(isdefined(var_03.script_noteworthy) && var_03.script_noteworthy == "play_musak")
		{
			var_01 = var_03;
		}
	}

	return var_01;
}

//Function Number: 40
func_7A16()
{
	return self.var_5FAC["housing"]["door_trigger"];
}

//Function Number: 41
func_7A17()
{
	return self.var_5FAC["housing"]["inside_trigger"];
}

//Function Number: 42
func_7A15()
{
	return self.var_5FAC["housing"]["door_closed_pos"];
}

//Function Number: 43
func_7A18()
{
	return self.var_5FAC["housing"]["left_door"];
}

//Function Number: 44
func_7A1E()
{
	return self.var_5FAC["housing"]["right_door"];
}

//Function Number: 45
func_7A19()
{
	return self.var_5FAC["housing"]["left_door_opened_pos"];
}

//Function Number: 46
func_7A1F()
{
	return self.var_5FAC["housing"]["right_door_opened_pos"];
}

//Function Number: 47
func_78F7()
{
	var_00 = func_6074();
	return self.var_5FAC["current_floor"];
}

//Function Number: 48
func_7A3F()
{
	return self.var_5FAC["initial_floor"];
}

//Function Number: 49
func_1376F(param_00,param_01,param_02,param_03)
{
	if(!isdefined(param_02) && !isdefined(param_03))
	{
		param_02 = param_00;
		param_03 = param_01;
	}

	for(;;)
	{
		var_04 = param_00.origin;
		var_05 = param_02.origin;
		if(var_04 == param_01 && var_05 == param_03)
		{
			break;
		}

		wait(0.05);
	}
}

//Function Number: 50
func_9E3C(param_00)
{
	var_01 = self.origin[0];
	var_02 = self.origin[1];
	var_03 = param_00[0];
	var_04 = param_00[1];
	var_05 = param_00[2];
	var_06 = param_00[3];
	return var_01 >= var_03 && var_01 <= var_04 && var_02 >= var_05 && var_02 <= var_06;
}

//Function Number: 51
func_9E3E(param_00)
{
	var_01 = self.origin[0];
	var_02 = self.origin[1];
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
func_137C0(param_00,param_01)
{
	self endon(param_00);
	wait(param_01);
}

//Function Number: 53
func_6077(param_00,param_01)
{
	return int(func_6076(param_00,param_01));
}

//Function Number: 54
func_6076(param_00,param_01)
{
	if(getdvar(param_00) != "")
	{
		return getdvarfloat(param_00);
	}

	setdvar(param_00,param_01);
	return param_01;
}

//Function Number: 55
func_6051()
{
	if(!level.var_6051)
	{
		return;
	}

	for(;;)
	{
		if(level.var_6051 != 2)
		{
			continue;
		}

		foreach(var_01 in level.var_60EA)
		{
			var_02 = var_01 func_7A1A();
			var_03 = var_01 func_7A1C();
			foreach(var_05 in var_01.var_5FAC["outer_doorset"])
			{
			}
		}

		foreach(var_09 in level.var_6044)
		{
			foreach(var_05 in var_09.var_5FAC)
			{
				var_0B = 0;
				foreach(var_0D in var_05)
				{
					var_0B++;
					var_0E = var_09.origin + (0,0,var_0B * -4);
				}
			}
		}

		wait(0.05);
	}
}