/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\_fx.gsc
 * Game: Call of Duty: Ghosts
 * Platform: PC
 * Function Count: 6
 * Decompile Time: 118 ms
 * Timestamp: 10/27/2023 1:22:17 AM
*******************************************************************/

//Function Number: 1
func_6C85()
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
func_3DB0(param_00)
{
	playfx(level._effect["mechanical explosion"],param_00);
	earthquake(0.15,0.5,param_00,250);
}

//Function Number: 3
func_771F(param_00,param_01,param_02)
{
	var_03 = spawn("script_origin",(0,0,0));
	var_03.origin = param_01;
	var_03 playloopsound(param_00);
	if(isdefined(param_02))
	{
		var_03 thread func_7720(param_02);
	}
}

//Function Number: 4
func_7720(param_00)
{
	level waittill(param_00);
	self delete();
}

//Function Number: 5
func_35AE()
{
	var_00 = [];
	var_01 = [];
	var_02 = getentarray("vfx_custom_glass","targetname");
	foreach(var_04 in var_02)
	{
		if(isdefined(var_04.script_noteworthy))
		{
			var_05 = getglass(var_04.script_noteworthy);
			if(isdefined(var_05))
			{
				var_01[var_05] = var_04;
				var_00[var_00.size] = var_05;
			}
		}
	}

	var_07 = var_00.size;
	var_08 = var_00.size;
	var_09 = 5;
	var_0A = 0;
	while(var_07 != 0)
	{
		var_0B = var_0A + var_09 - 1;
		if(var_0B > var_08)
		{
			var_0B = var_08;
		}

		if(var_0A == var_08)
		{
			var_0A = 0;
		}

		while(var_0A < var_0B)
		{
			var_0C = var_00[var_0A];
			var_04 = var_01[var_0C];
			if(isdefined(var_04))
			{
				if(isglassdestroyed(var_0C))
				{
					var_04 delete();
					var_07--;
					var_01[var_0C] = undefined;
				}
			}

			var_0A++;
		}

		wait(0.05);
	}
}

//Function Number: 6
func_14DD(param_00)
{
	self waittill("death");
	param_00 delete();
}