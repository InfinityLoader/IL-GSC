/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: _stealth_display.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 6
 * Decompile Time: 102 ms
 * Timestamp: 4/22/2024 2:23:05 AM
*******************************************************************/

//Function Number: 1
main()
{
	setdvarifuninitialized("stealth_display",1);
	setdvarifuninitialized("stealth_display_radius",140);
	setdvarifuninitialized("stealth_display_width",8);
	setdvarifuninitialized("stealth_display_height",64);
	setdvarifuninitialized("stealth_display_count",90);
	setdvarifuninitialized("stealth_display_frames",8);
	setdvarifuninitialized("stealth_display_spread",0.75);
	foreach(var_01 in level.players)
	{
		var_01 thread stealth_display_thread();
	}
}

//Function Number: 2
stealth_display_off()
{
	setdvar("stealth_display",0);
}

//Function Number: 3
stealth_display_on()
{
	setdvar("stealth_display",1);
}

//Function Number: 4
stealth_display_thread()
{
	self notify("stealth_display_thread");
	self endon("stealth_display_thread");
	if(!isdefined(self.stealth_display))
	{
		self.stealth_display = [];
	}

	for(;;)
	{
		level.stealth_display_count = 0;
		var_00 = (0,-1,0) * getdvarfloat("stealth_display_radius");
		var_01 = getdvarint("stealth_display_width");
		var_02 = getdvarint("stealth_display_height");
		var_03 = getdvarint("stealth_display_count");
		var_04 = getdvarint("stealth_display_frames");
		var_05 = 360 / var_03;
		var_06 = int(float(gettime()) / 100);
		self.stealth_display_active = 0;
		self.stealth_display_max = 0;
		if(!getdvarint("stealth_display"))
		{
			for(var_07 = 0;var_07 < self.stealth_display.size;var_07++)
			{
				var_08 = self.stealth_display[var_07];
				if(isdefined(var_08.hud_elem))
				{
					var_08.hud_elem destroy();
					var_08.hud_elem = undefined;
				}
			}

			wait(0.05);
			continue;
		}

		for(var_07 = 0;var_07 < var_03;var_07++)
		{
			if(!isdefined(self.stealth_display[var_07]))
			{
				var_08 = spawnstruct();
				var_08.value = 0;
				var_08.value_last = 0;
				var_08.state = 0;
				var_08.state_last = 0;
				var_08.hold_frames = 0;
				var_08.see_frames = 0;
				self.stealth_display[var_07] = var_08;
			}

			var_08 = self.stealth_display[var_07];
			var_08.screenangle = var_05 * var_07;
			if(var_08.value > 0 && var_08.hold_frames <= 0)
			{
				var_08.value = var_08.value - 0.1;
			}

			if(var_08.hold_frames > 0)
			{
				var_08.hold_frames = var_08.hold_frames - 1;
			}

			if(var_08.see_frames > 0)
			{
				var_08.see_frames = var_08.see_frames - 1;
			}

			var_08.state = floor(var_08.value * var_04);
			if(var_08.state == 0)
			{
				var_08.state = 1;
			}

			if(var_08.value > 0 && var_08.value_last <= 0)
			{
				var_09 = maps\_hud_util::createicon("stealth_eq_0" + var_08.state,var_01,var_02);
				level.stealth_display_count++;
				var_09.sort = 1000;
				var_09.alignx = "center";
				var_09.aligny = "middle";
				var_09.horzalign = "center";
				var_09.vertalign = "middle";
				var_08.offset = rotatevector(var_00,(0,var_08.screenangle,0));
				var_09.x = var_08.offset[0];
				var_09.y = var_08.offset[1];
				var_09.rotation = var_08.screenangle;
				var_08.hud_elem = var_09;
			}
			else if(var_08.value <= 0 && var_08.value_last > 0 && isdefined(var_08.hud_elem))
			{
				var_08.hud_elem destroy();
				var_08.hud_elem = undefined;
			}
			else if(isdefined(var_08.hud_elem) && var_08.state != var_08.state_last)
			{
				var_08.hud_elem setshader("stealth_eq_0" + var_08.state,var_01,var_02);
				level.stealth_display_count++;
			}

			if(isdefined(var_08.hud_elem))
			{
				self.stealth_display_active = 1;
				self.stealth_display_max = max(self.stealth_display_max,var_08.value);
				if(var_08.see_frames > 0)
				{
					var_0A = 0.5 + sin(float(gettime() * 2)) * 0.5;
					var_08.hud_elem.alpha = 0.5 + var_0A * 0.5;
				}
				else
				{
					var_08.hud_elem.alpha = 1;
				}
			}

			var_08.value_last = var_08.value;
			var_08.state_last = var_08.state;
		}

		for(var_07 = var_03;var_07 < self.stealth_display.size;var_07++)
		{
			var_08 = self.stealth_display[var_07];
			if(isdefined(var_08.hud_elem))
			{
				var_08.hud_elem destroy();
				var_08.hud_elem = undefined;
			}
		}

		wait(0.05);
	}
}

//Function Number: 5
stealth_display_seed_angle(param_00,param_01,param_02)
{
	if(!getdvarint("stealth_display"))
	{
		return;
	}

	if(param_01 <= 0)
	{
		return;
	}

	if(!param_02)
	{
		param_01 = min(param_01,0.99);
	}

	var_03 = getdvarint("stealth_display_count");
	if(var_03 == 0)
	{
		return;
	}

	var_04 = getdvarint("stealth_display_frames");
	var_05 = getdvarfloat("stealth_display_spread");
	var_06 = 1 / float(var_04);
	var_07 = 360 / var_03;
	var_08 = int(floor(param_00 / var_07));
	if(self.stealth_display.size < var_03)
	{
		return;
	}

	var_09 = 0;
	if(param_01 >= 1)
	{
		var_09 = 2;
	}

	for(var_0A = 0;var_0A < var_03;var_0A++)
	{
		var_0B = var_08 - var_0A;
		if(var_0B < 0)
		{
			var_0B = var_0B + var_03;
		}

		var_0C = param_01;
		if(var_0A > 0 && var_0C < 1 - var_06 && randomint(100) > 80)
		{
			var_0C = var_0C + var_06;
		}

		self.stealth_display[var_0B].value = max(self.stealth_display[var_0B].value,var_0C);
		self.stealth_display[var_0B].hold_frames = max(self.stealth_display[var_0B].hold_frames,var_09);
		if(param_02)
		{
			self.stealth_display[var_0B].see_frames = max(self.stealth_display[var_0B].see_frames,var_09);
		}

		if(param_01 < 1 / var_04)
		{
			self.stealth_display[var_0B].hold_frames = max(self.stealth_display[var_0B].hold_frames,2);
		}

		if(var_0A > 0)
		{
			var_0B = var_08 + var_0A;
			if(var_0B >= var_03)
			{
				var_0B = var_0B - var_03;
			}

			self.stealth_display[var_0B].value = max(self.stealth_display[var_0B].value,var_0C);
			self.stealth_display[var_0B].hold_frames = max(self.stealth_display[var_0B].hold_frames,var_09);
			if(param_02)
			{
				self.stealth_display[var_0B].see_frames = max(self.stealth_display[var_0B].see_frames,var_09);
			}

			if(param_01 < 1 / var_04)
			{
				self.stealth_display[var_0B].hold_frames = max(self.stealth_display[var_0B].hold_frames,2);
			}
		}
		else
		{
			var_09 = min(var_09,1);
		}

		if(param_01 < 1 / var_04)
		{
			break;
		}

		param_01 = param_01 * var_05;
		var_05 = var_05 * var_05;
	}
}

//Function Number: 6
stealth_display_seed(param_00,param_01,param_02)
{
	var_03 = angleclamp(self getplayerangles()[1] - vectortoyaw(param_00.origin - self.origin));
	stealth_display_seed_angle(var_03,param_01,param_02);
}