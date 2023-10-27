/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\_fx.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: PC
 * Function Count: 10
 * Decompile Time: 149 ms
 * Timestamp: 10/27/2023 2:23:05 AM
*******************************************************************/

//Function Number: 1
script_print_fx()
{
	if(!isdefined(self.script_fxid) || !isdefined(self.script_fxcommand) || !isdefined(self.script_delay))
	{
		self delete();
		return;
	}

	if(isdefined(self.target))
	{
		var_00 = getent(self.target).origin;
	}
	else
	{
		var_00 = "undefined";
	}

	if(self.script_fxcommand == "OneShotfx")
	{
	}

	if(self.script_fxcommand == "loopfx")
	{
	}

	if(self.script_fxcommand == "loopsound")
	{
	}
}

//Function Number: 2
script_playfx(param_00,param_01,param_02)
{
	if(!param_00)
	{
		return;
	}

	if(isdefined(param_02))
	{
		playfx(param_00,param_01,param_02);
		return;
	}

	playfx(param_00,param_01);
}

//Function Number: 3
script_playfxontag(param_00,param_01,param_02)
{
	if(!param_00)
	{
		return;
	}

	playfxontag(param_00,param_01,param_02);
}

//Function Number: 4
grenadeexplosionfx(param_00)
{
	playfx(level._effect["mechanical explosion"],param_00);
	earthquake(0.15,0.5,param_00,250);
}

//Function Number: 5
soundfx(param_00,param_01,param_02)
{
	var_03 = spawn("script_origin",(0,0,0));
	var_03.origin = param_01;
	var_03 playloopsound(param_00);
	if(isdefined(param_02))
	{
		var_03 thread soundfxdelete(param_02);
	}
}

//Function Number: 6
soundfxdelete(param_00)
{
	level waittill(param_00);
	self delete();
}

//Function Number: 7
rainfx(param_00,param_01,param_02)
{
	var_03 = spawn("script_origin",(0,0,0));
	var_03.origin = param_02;
	var_03 thread rainloop(param_00,param_01);
}

//Function Number: 8
rainloop(param_00,param_01)
{
	self endon("death");
	var_02 = spawn("sound_blend",(0,0,0));
	var_02.origin = self.origin;
	thread blenddelete(var_02);
	var_03 = spawn("sound_blend",(0,0,0));
	var_03.origin = self.origin;
	thread blenddelete(var_03);
	var_02 setsoundblend(param_01 + "_null",param_01,0);
	var_03 setsoundblend(param_00 + "_null",param_00,1);
	var_04 = "hard";
	var_05 = undefined;
	for(;;)
	{
		level waittill("rain_change",var_06,var_05);
		var_05 = var_05 * 20;
		if(var_06 == "hard")
		{
			if(var_04 == "none")
			{
				var_05 = var_05 * 0.5;
				for(var_07 = 0;var_07 < var_05;var_07++)
				{
					var_02 setsoundblend(param_01 + "_null",param_01,var_07 / var_05);
					wait 0.05;
				}

				var_04 = "light";
			}

			if(var_04 == "light")
			{
				for(var_07 = 0;var_07 < var_05;var_07++)
				{
					var_02 setsoundblend(param_01 + "_null",param_01,1 - var_07 / var_05);
					var_03 setsoundblend(param_00 + "_null",param_00,var_07 / var_05);
					wait 0.05;
				}
			}
		}

		if(var_06 == "none")
		{
			if(var_04 == "hard")
			{
				var_05 = var_05 * 0.5;
				for(var_07 = 0;var_07 < var_05;var_07++)
				{
					var_02 setsoundblend(param_01 + "_null",param_01,var_07 / var_05);
					var_03 setsoundblend(param_00 + "_null",param_00,1 - var_07 / var_05);
					wait 0.05;
				}

				var_04 = "light";
			}

			if(var_04 == "light")
			{
				for(var_07 = 0;var_07 < var_05;var_07++)
				{
					var_02 setsoundblend(param_01 + "_null",param_01,1 - var_07 / var_05);
					wait 0.05;
				}
			}
		}

		if(var_06 == "light")
		{
			if(var_04 == "none")
			{
				for(var_07 = 0;var_07 < var_05;var_07++)
				{
					var_02 setsoundblend(param_01 + "_null",param_01,var_07 / var_05);
					wait 0.05;
				}
			}

			if(var_04 == "hard")
			{
				for(var_07 = 0;var_07 < var_05;var_07++)
				{
					var_02 setsoundblend(param_01 + "_null",param_01,var_07 / var_05);
					var_03 setsoundblend(param_00 + "_null",param_00,1 - var_07 / var_05);
					wait 0.05;
				}
			}
		}

		var_04 = var_06;
	}
}

//Function Number: 9
blenddelete(param_00)
{
	self waittill("death");
	param_00 delete();
}

//Function Number: 10
watersheeting(param_00)
{
	var_01 = 3;
	if(isdefined(param_00.script_duration))
	{
		var_01 = param_00.script_duration;
	}

	for(;;)
	{
		param_00 waittill("trigger",var_02);
		if(isplayer(var_02))
		{
			var_02 setwatersheeting(1,var_01);
			wait var_01 * 0.2;
		}
	}
}