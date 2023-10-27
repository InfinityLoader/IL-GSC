/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\_flashgrenades.gsc
 * Game: Call of Duty: WWII
 * Platform: PC
 * Function Count: 7
 * Decompile Time: 124 ms
 * Timestamp: 10/27/2023 3:21:25 AM
*******************************************************************/

//Function Number: 1
func_00F9()
{
	precacheshellshock("flashbang_mp");
}

//Function Number: 2
func_92E8()
{
	thread func_6394();
}

//Function Number: 3
func_940E(param_00)
{
	self notify("stop_monitoring_flash");
}

//Function Number: 4
func_3D58(param_00)
{
	self endon("stop_monitoring_flash");
	self endon("flash_rumble_loop");
	self notify("flash_rumble_loop");
	var_01 = gettime() + param_00 * 1000;
	while(gettime() < var_01)
	{
		self playrumbleonentity("damage_heavy");
		wait 0.05;
	}
}

//Function Number: 5
func_6394()
{
	self endon("disconnect");
	self notify("monitorFlash");
	self endon("monitorFlash");
	self.var_3D48 = 0;
	self.var_8C5E = 0;
	var_00 = 2.5;
	for(;;)
	{
		self waittill("flashbang",var_01,var_02,var_03,var_04,var_05,var_06);
		if(!isalive(self))
		{
			break;
		}

		if(isdefined(self.var_A25C))
		{
			continue;
		}

		if(!isdefined(var_06))
		{
			var_06 = 0;
		}

		var_07 = 0;
		var_08 = 1;
		if(var_03 < 0.25)
		{
			var_03 = 0.25;
		}
		else if(var_03 > 0.8)
		{
			var_03 = 1;
		}

		var_09 = var_02 * var_03 * var_00;
		var_09 = var_09 + var_06;
		var_0A = 0;
		if(isdefined(self.var_94BE))
		{
			var_09 = var_09 * self.var_94BE;
			if(self.var_94BE == 0.1)
			{
				var_0A = 1;
			}
		}

		if(var_09 < 0.25)
		{
			continue;
		}

		var_0B = undefined;
		if(var_09 > 2)
		{
			var_0B = 0.75;
		}
		else
		{
			var_0B = 0.25;
		}

		if(level.var_984D && isdefined(var_04) && isdefined(var_04.var_1A7) && var_04.var_1A7 == self.var_1A7 && var_04 != self)
		{
			if(level.var_3EC4 == 0)
			{
				continue;
			}
			else if(level.var_3EC4 == 1)
			{
			}
			else if(level.var_3EC4 == 2)
			{
				var_09 = var_09 * 0.5;
				var_0B = var_0B * 0.5;
				var_08 = 0;
				var_07 = 1;
			}
			else if(level.var_3EC4 == 3)
			{
				var_09 = var_09 * 0.5;
				var_0B = var_0B * 0.5;
				var_07 = 1;
			}
		}
		else if(isdefined(var_04))
		{
			if(var_04 != self)
			{
				var_04 maps\mp\gametypes\_missions::func_7750("ch_indecentexposure");
			}
		}

		if(var_08 && isdefined(self))
		{
			thread func_0F33(var_09,var_0B,var_0A);
			if(isdefined(var_04) && var_04 != self)
			{
				var_04 thread maps\mp\gametypes\_damagefeedback::func_A102("flash");
				var_0C = self;
				if(isplayer(var_04) && var_04 maps\mp\_utility::func_649("specialty_paint"))
				{
					var_0C thread maps\mp\perks\_perkfunctions::func_86ED(var_04,0);
				}
			}
		}

		if(var_07 && isdefined(var_04))
		{
			var_04 thread func_0F33(var_09,var_0B);
		}
	}
}

//Function Number: 6
func_0F33(param_00,param_01,param_02)
{
	if(!isdefined(self.var_3D46) || param_00 > self.var_3D46)
	{
		self.var_3D46 = param_00;
	}

	if(!isdefined(self.var_3D57) || param_01 > self.var_3D57)
	{
		self.var_3D57 = param_01;
	}

	wait 0.05;
	if(isdefined(self.var_3D46))
	{
		self shellshock("flashbang_mp",self.var_3D46);
		self.var_3D48 = gettime() + self.var_3D46 * 1000;
		if(param_02)
		{
			self.var_8C5C = self.var_3D46 * 10;
			self.var_8C5E = gettime() + self.var_8C5C * 1000;
		}
	}

	if(isdefined(self.var_3D57))
	{
		thread func_3D58(self.var_3D57);
	}

	self.var_3D46 = undefined;
	self.var_3D57 = undefined;
}

//Function Number: 7
func_56F3()
{
	return isdefined(self.var_3D48) && gettime() < self.var_3D48;
}