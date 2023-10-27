/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\mp\_flashgrenades.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 7
 * Decompile Time: 284 ms
 * Timestamp: 10/27/2023 12:20:16 AM
*******************************************************************/

//Function Number: 1
main()
{
}

//Function Number: 2
func_10DC6()
{
	thread func_B9D9();
}

//Function Number: 3
func_1107E(param_00)
{
	self notify("stop_monitoring_flash");
}

//Function Number: 4
func_6EDC(param_00)
{
	self endon("stop_monitoring_flash");
	self endon("flash_rumble_loop");
	self notify("flash_rumble_loop");
	var_01 = gettime() + param_00 * 1000;
	while(gettime() < var_01)
	{
		self playrumbleonentity("damage_heavy");
		wait(0.05);
	}
}

//Function Number: 5
func_B9D9()
{
	self endon("death");
	self endon("disconnect");
	self notify("monitorFlash");
	self endon("monitorFlash");
	self.var_6ECA = 0;
	var_00 = 1;
	for(;;)
	{
		self waittill("flashbang",var_01,var_02,var_03,var_04,var_05,var_06);
		if(!isalive(self))
		{
			break;
		}

		if(isdefined(self.var_13118))
		{
			continue;
		}

		if(isdefined(self.var_222) && isdefined(var_04) && var_04 == self.var_222)
		{
			continue;
		}

		if(!isdefined(var_06))
		{
			var_06 = 0;
		}

		var_07 = 0;
		var_08 = 1;
		var_03 = 1;
		var_09 = var_02 * var_03 * var_00;
		var_09 = var_09 + var_06;
		var_09 = scripts\mp\perks\_perkfunctions::func_20E0(var_04,self,var_09);
		if(var_09 < 0.25)
		{
			continue;
		}

		var_0A = undefined;
		if(var_09 > 2)
		{
			var_0A = 0.75;
		}
		else
		{
			var_0A = 0.25;
		}

		if(level.teambased && isdefined(var_04) && isdefined(var_04.team) && var_04.team == self.team && var_04 != self)
		{
			if(level.var_740A == 0)
			{
				continue;
			}
			else if(level.var_740A == 1)
			{
			}
			else if(level.var_740A == 2)
			{
				var_09 = var_09 * 0.5;
				var_0A = var_0A * 0.5;
				var_08 = 0;
				var_07 = 1;
			}
			else if(level.var_740A == 3)
			{
				var_09 = var_09 * 0.5;
				var_0A = var_0A * 0.5;
				var_07 = 1;
			}
		}
		else if(isdefined(var_04))
		{
			var_04 notify("flash_hit");
			if(var_04 != self)
			{
				var_04 scripts\mp\_missions::func_D992("ch_indecentexposure");
			}
		}

		if(var_08 && isdefined(self))
		{
			thread func_20CA(var_09,var_0A);
			if(isdefined(var_04) && var_04 != self)
			{
				var_04 thread scripts\mp\_damagefeedback::func_12E84("flash");
				var_0B = self;
				if(isplayer(var_04) && var_04 isitemunlocked("specialty_paint","perk") && var_04 scripts\mp\_utility::_hasperk("specialty_paint"))
				{
					var_0B thread scripts\mp\perks\_perkfunctions::func_F7D5(var_04);
				}
			}
		}

		if(var_07 && isdefined(var_04))
		{
			var_04 thread func_20CA(var_09,var_0A);
		}
	}
}

//Function Number: 6
func_20CA(param_00,param_01)
{
	self endon("disconnect");
	if(!isdefined(self.var_6EC8) || param_00 > self.var_6EC8)
	{
		self.var_6EC8 = param_00;
	}

	if(!isdefined(self.var_6EDB) || param_01 > self.var_6EDB)
	{
		self.var_6EDB = param_01;
	}

	wait(0.05);
	self.var_6EC8 = undefined;
	self.var_6EDB = undefined;
}

//Function Number: 7
func_9DFA()
{
	return isdefined(self.var_6ECA) && gettime() < self.var_6ECA;
}