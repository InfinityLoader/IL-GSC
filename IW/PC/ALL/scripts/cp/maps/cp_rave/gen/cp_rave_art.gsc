/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\cp\maps\cp_rave\gen\cp_rave_art.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 12
 * Decompile Time: 671 ms
 * Timestamp: 10/27/2023 12:05:50 AM
*******************************************************************/

//Function Number: 1
main()
{
	level.var_12ACA = 1;
	thread light_control_flags_init();
	thread strobelight_init();
	thread fire_light_flicker_init();
	thread light_fixture_flicker_init();
}

//Function Number: 2
light_control_flags_init()
{
	scripts\common\utility::flag_init("light_fixture_on");
	scripts\common\utility::flag_init("light_fixture_off");
	scripts\common\utility::flag_init("strobe_red");
	scripts\common\utility::flag_init("strobe_green");
	scripts\common\utility::flag_init("strobe_blue");
}

//Function Number: 3
strobelight_init()
{
	var_00 = getentarray("strobelight_r","targetname");
	var_01 = getentarray("strobelight_g","targetname");
	var_02 = getentarray("strobelight_b","targetname");
	thread strobe_light_rand_generator();
	scripts\common\utility::array_thread(var_00,::strobelight_setup);
	scripts\common\utility::array_thread(var_01,::strobelight_setup);
	scripts\common\utility::array_thread(var_02,::strobelight_setup);
}

//Function Number: 4
strobelight_setup()
{
	var_00 = func_C901();
	self.light_targetname = self.var_336;
	self.light_position_show = self.origin;
	self.light_position_hide = self.origin - (0,0,1024);
	for(;;)
	{
		if(self.light_targetname == "strobelight_r" && scripts\common\utility::flag("strobe_red"))
		{
			self.origin = self.light_position_show;
		}

		if(self.light_targetname == "strobelight_r" && !scripts\common\utility::flag("strobe_red"))
		{
			self.origin = self.light_position_hide;
		}

		if(self.light_targetname == "strobelight_g" && scripts\common\utility::flag("strobe_green"))
		{
			self.origin = self.light_position_show;
		}

		if(self.light_targetname == "strobelight_g" && !scripts\common\utility::flag("strobe_green"))
		{
			self.origin = self.light_position_hide;
		}

		if(self.light_targetname == "strobelight_b" && scripts\common\utility::flag("strobe_blue"))
		{
			self.origin = self.light_position_show;
		}

		if(self.light_targetname == "strobelight_b" && !scripts\common\utility::flag("strobe_blue"))
		{
			self.origin = self.light_position_hide;
		}

		scripts\common\utility::func_136F7();
	}
}

//Function Number: 5
strobe_light_rand_generator()
{
	for(;;)
	{
		var_00 = randomintrange(0,150);
		if(var_00 >= 50 && var_00 <= 100)
		{
			scripts\common\utility::flag_set("strobe_red");
			scripts\common\utility::func_6E2A("strobe_green");
			scripts\common\utility::func_6E2A("strobe_blue");
		}
		else if(var_00 >= 100)
		{
			scripts\common\utility::func_6E2A("strobe_red");
			scripts\common\utility::flag_set("strobe_green");
			scripts\common\utility::func_6E2A("strobe_blue");
		}
		else
		{
			scripts\common\utility::func_6E2A("strobe_red");
			scripts\common\utility::func_6E2A("strobe_green");
			scripts\common\utility::flag_set("strobe_blue");
		}

		wait(0.5);
	}
}

//Function Number: 6
fire_light_flicker_init()
{
	var_00 = getentarray("fire_light_flicker","targetname");
	scripts\common\utility::array_thread(var_00,::fire_light_flicker_setup);
}

//Function Number: 7
fire_light_flicker_setup()
{
	var_00 = func_C901();
	self.var_738E = 100;
	self.var_B442 = 750;
	self.var_B749 = 5;
	if(isdefined(var_00["frequency"]))
	{
		self.var_738E = float(var_00["frequency"]);
	}

	if(isdefined(var_00["max_intensity"]))
	{
		self.var_B442 = float(var_00["max_intensity"]);
	}

	if(isdefined(var_00["min_intensity"]))
	{
		self.var_B749 = float(var_00["min_intensity"]);
	}

	thread fire_light_flicker();
}

//Function Number: 8
fire_light_flicker()
{
	for(;;)
	{
		var_00 = randomfloatrange(self.var_B749,self.var_B442);
		self setlightintensity(var_00);
		wait(1 / self.var_738E);
	}
}

//Function Number: 9
light_fixture_flicker_init()
{
	thread light_fixture_flicker_rand_generator();
	thread light_fixture_flicker_setup();
}

//Function Number: 10
light_fixture_flicker_setup()
{
	var_00 = func_C901();
	var_01 = getentarray("light_fixture_flicker","targetname");
	var_02 = getentarray("light_fixture_flicker_off","targetname");
	var_03 = getentarray("light_fixture_flicker_on","targetname");
	var_04 = 150;
	var_05 = 5;
	for(;;)
	{
		if(scripts\common\utility::flag("light_fixture_on"))
		{
			foreach(var_07 in var_03)
			{
				var_07 show();
			}

			foreach(var_0A in var_02)
			{
				var_0A hide();
			}

			foreach(var_0D in var_01)
			{
				var_0D setlightintensity(var_04);
			}
		}
		else if(scripts\common\utility::flag("light_fixture_off"))
		{
			foreach(var_07 in var_03)
			{
				var_07 hide();
			}

			foreach(var_0A in var_02)
			{
				var_0A show();
			}

			foreach(var_0D in var_01)
			{
				var_0D setlightintensity(var_05);
			}
		}

		scripts\common\utility::func_136F7();
	}
}

//Function Number: 11
light_fixture_flicker_rand_generator()
{
	for(;;)
	{
		var_00 = randomintrange(0,500);
		if(var_00 >= 250)
		{
			scripts\common\utility::func_6E2A("light_fixture_off");
			scripts\common\utility::flag_set("light_fixture_on");
		}
		else
		{
			scripts\common\utility::func_6E2A("light_fixture_on");
			scripts\common\utility::flag_set("light_fixture_off");
		}

		scripts\common\utility::func_136F7();
	}
}

//Function Number: 12
func_C901()
{
	var_00 = [];
	if(isdefined(self.script_noteworthy))
	{
		var_01 = strtok(self.script_noteworthy," ");
		foreach(var_03 in var_01)
		{
			var_04 = strtok(var_03,":");
			var_00[var_04[0]] = var_04[1];
		}
	}

	return var_00;
}