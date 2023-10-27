/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\_flashgrenades.gsc
 * Game: Call of Duty: Ghosts
 * Platform: Console
 * Function Count: 7
 * Decompile Time: 115 ms
 * Timestamp: 10/27/2023 1:29:53 AM
*******************************************************************/

//Function Number: 1
func_4FDD()
{
}

//Function Number: 2
func_7AE2()
{
	thread func_538C();
}

//Function Number: 3
func_7C6A(param_00)
{
	self notify("stop_monitoring_flash");
}

//Function Number: 4
flashrumbleloop(param_00)
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
func_538C()
{
	self endon("disconnect");
	self notify("monitorFlash");
	self endon("monitorFlash");
	self.flashendtime = 0;
	var_00 = 1;
	for(;;)
	{
		self waittill("flashbang",var_01,var_02,var_03,var_04,var_05,var_06);
		if(!isalive(self))
		{
			break;
		}

		if(isdefined(self.usingremote))
		{
			continue;
		}

		if(isdefined(self.owner) && isdefined(var_04) && var_04 == self.owner)
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
		var_09 = maps\mp\perks\_perkfunctions::applystunresistence(var_09);
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
			if(level.friendlyfire == 0)
			{
				continue;
			}
			else if(level.friendlyfire == 1)
			{
			}
			else if(level.friendlyfire == 2)
			{
				var_09 = var_09 * 0.5;
				var_0A = var_0A * 0.5;
				var_08 = 0;
				var_07 = 1;
			}
			else if(level.friendlyfire == 3)
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
				var_04 maps\mp\gametypes\_missions::func_61CE("ch_indecentexposure");
			}
		}

		if(var_08 && isdefined(self))
		{
			thread applyflash(var_09,var_0A);
			if(isdefined(var_04) && var_04 != self)
			{
				var_04 thread maps\mp\gametypes\_damagefeedback::func_86E0("flash");
				var_0B = self;
				if(isplayer(var_04) && var_04 isitemunlocked("specialty_paint") && var_04 maps\mp\_utility::_hasperk("specialty_paint"))
				{
					if(!var_0B maps\mp\perks\_perkfunctions::ispainted())
					{
						var_04 maps\mp\gametypes\_missions::func_61CE("ch_paint_pro");
					}

					var_0B thread maps\mp\perks\_perkfunctions::func_708E(var_04);
				}
			}
		}

		if(var_07 && isdefined(var_04))
		{
			var_04 thread applyflash(var_09,var_0A);
		}
	}
}

//Function Number: 6
applyflash(param_00,param_01)
{
	if(!isdefined(self.flashduration) || param_00 > self.flashduration)
	{
		self.flashduration = param_00;
	}

	if(!isdefined(self.flashrumbleduration) || param_01 > self.flashrumbleduration)
	{
		self.flashrumbleduration = param_01;
	}

	wait(0.05);
	if(isdefined(self.flashduration))
	{
		self shellshock("flashbang_mp",self.flashduration);
		self.flashendtime = gettime() + self.flashduration * 1000;
	}

	if(isdefined(self.flashrumbleduration))
	{
		thread flashrumbleloop(self.flashrumbleduration);
	}

	self.flashduration = undefined;
	self.flashrumbleduration = undefined;
}

//Function Number: 7
func_48C3()
{
	return isdefined(self.flashendtime) && gettime() < self.flashendtime;
}