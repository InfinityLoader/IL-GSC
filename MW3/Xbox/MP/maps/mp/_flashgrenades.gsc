/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\_flashgrenades.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: Console
 * Function Count: 7
 * Decompile Time: 133 ms
 * Timestamp: 10/27/2023 2:27:44 AM
*******************************************************************/

//Function Number: 1
main()
{
	precacheshellshock("flashbang_mp");
}

//Function Number: 2
startmonitoringflash()
{
	thread monitorflash();
}

//Function Number: 3
stopmonitoringflash(param_00)
{
	self notify("stop_monitoring_flash");
}

//Function Number: 4
func_2210(param_00)
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
monitorflash()
{
	self endon("disconnect");
	self.flashendtime = 0;
	for(;;)
	{
		self waittill("flashbang",var_00,var_01,var_02,var_03);
		if(!isalive(self))
		{
			continue;
		}

		if(isdefined(self.usingremote))
		{
			continue;
		}

		var_04 = 0;
		var_05 = 1;
		if(var_02 < 0.25)
		{
			var_02 = 0.25;
		}
		else if(var_02 > 0.8)
		{
			var_02 = 1;
		}

		var_06 = var_01 * var_02 * 5.5;
		if(isdefined(self.stunscaler))
		{
			var_06 = var_06 * self.stunscaler;
		}

		if(var_06 < 0.25)
		{
			continue;
		}

		var_07 = undefined;
		if(var_06 > 2)
		{
			var_07 = 0.75;
		}
		else
		{
			var_07 = 0.25;
		}

		if(level.teambased && isdefined(var_03) && isdefined(var_03.pers["team"]) && var_03.pers["team"] == self.pers["team"] && var_03 != self)
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
				var_06 = var_06 * 0.5;
				var_07 = var_07 * 0.5;
				var_05 = 0;
				var_04 = 1;
			}
			else if(level.friendlyfire == 3)
			{
				var_06 = var_06 * 0.5;
				var_07 = var_07 * 0.5;
				var_04 = 1;
			}
		}
		else if(isdefined(var_03))
		{
			var_03 notify("flash_hit");
			if(var_03 != self)
			{
				var_03 maps\mp\gametypes\_missions::processchallenge("ch_indecentexposure");
			}
		}

		if(var_05 && isdefined(self))
		{
			thread func_27AA(var_06,var_07);
			if(isdefined(var_03) && var_03 != self)
			{
				var_03 thread maps\mp\gametypes\_damagefeedback::updatedamagefeedback("flash");
				var_08 = self;
				if(isplayer(var_03) && var_03 isitemunlocked("specialty_paint") && var_03 maps\mp\_utility::func_27AF("specialty_paint"))
				{
					if(!var_08 maps\mp\perks\_perkfunctions::ispainted())
					{
						var_03 maps\mp\gametypes\_missions::processchallenge("ch_paint_pro");
					}

					var_08 thread maps\mp\perks\_perkfunctions::func_2980();
				}
			}
		}

		if(var_04 && isdefined(var_03))
		{
			var_03 thread func_27AA(var_06,var_07);
		}
	}
}

//Function Number: 6
func_27AA(param_00,param_01)
{
	if(!isdefined(self.flashduration) || param_00 > self.flashduration)
	{
		self.flashduration = param_00;
	}

	if(!isdefined(self.flashrumbleduration) || param_01 > self.flashrumbleduration)
	{
		self.flashrumbleduration = param_01;
	}

	wait 0.05;
	if(isdefined(self.flashduration))
	{
		self shellshock("flashbang_mp",self.flashduration);
		self.flashendtime = gettime() + self.flashduration * 1000;
	}

	if(isdefined(self.flashrumbleduration))
	{
		thread func_2210(self.flashrumbleduration);
	}

	self.flashduration = undefined;
	self.flashrumbleduration = undefined;
}

//Function Number: 7
isflashbanged()
{
	return isdefined(self.flashendtime) && gettime() < self.flashendtime;
}