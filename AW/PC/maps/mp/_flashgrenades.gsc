/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: mp\_flashgrenades.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 7
 * Decompile Time: 130 ms
 * Timestamp: 4/22/2024 2:15:54 AM
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
monitorflash()
{
	self endon("disconnect");
	self notify("monitorFlash");
	self endon("monitorFlash");
	self.flashendtime = 0;
	var_00 = 2.5;
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
		if(isdefined(self.stunscaler))
		{
			var_09 = var_09 * self.stunscaler;
		}

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
			if(var_04 != self)
			{
				var_04 maps\mp\gametypes\_missions::processchallenge("ch_indecentexposure");
			}
		}

		if(var_08 && isdefined(self))
		{
			thread applyflash(var_09,var_0A);
			if(isdefined(var_04) && var_04 != self)
			{
				var_04 thread maps\mp\gametypes\_damagefeedback::updatedamagefeedback("flash");
				var_0B = self;
				if(isplayer(var_04) && var_04 isitemunlocked("specialty_paint") && var_04 maps\mp\_utility::_hasperk("specialty_paint"))
				{
					if(!var_0B maps\mp\perks\_perkfunctions::ispainted())
					{
						var_04 maps\mp\gametypes\_missions::processchallenge("ch_paint_pro");
					}

					var_0B thread maps\mp\perks\_perkfunctions::setpainted(var_04);
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
		thread maps\mp\_utility::light_set_override_for_player("flashed",0.1,0.1,self.flashduration - 0.1);
	}

	if(isdefined(self.flashrumbleduration))
	{
		thread flashrumbleloop(self.flashrumbleduration);
	}

	self.flashduration = undefined;
	self.flashrumbleduration = undefined;
}

//Function Number: 7
isflashbanged()
{
	return isdefined(self.flashendtime) && gettime() < self.flashendtime;
}