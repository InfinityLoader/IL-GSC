/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\_flashgrenades.gsc
 * Game: Call of Duty: Modern Warfare 2
 * Platform: Xbox
*******************************************************************/

main()
{
	precacheshellshock("flashbang_mp");
}

startmonitoringflash()
{
	thread monitorflash();
}

stopmonitoringflash(disconnected)
{
	self notify("stop_monitoring_flash");
}

flashrumbleloop(duration)
{
	self endon("stop_monitoring_flash");
	self endon("flash_rumble_loop");
	self notify("flash_rumble_loop");
	goaltime = gettime() + duration * 1000;
	while(gettime() < goaltime)
	{
		self playrumbleonentity("damage_heavy");
		wait 0.05;
	}
}

monitorflash()
{
	self endon("disconnect");
	self.flashendtime = 0;
	for(;;)
	{
		self waittill("flashbang", origin, amount_distance, amount_angle, attacker);
		if(!isalive(self))
		{
			continue;
		}

		if(isdefined(self.usingremote))
		{
			continue;
		}

		hurtattacker = 0;
		hurtvictim = 1;
		if(amount_angle < 0.5)
		{
			amount_angle = 0.5;
		}
		else if(amount_angle > 0.8)
		{
			amount_angle = 1;
		}

		duration = amount_distance * amount_angle * 6;
		if(duration < 0.25)
		{
			continue;
		}

		rumbleduration = undefined;
		if(duration > 2)
		{
			rumbleduration = 0.75;
		}
		else
		{
			rumbleduration = 0.25;
		}

		if(level.teambased && isdefined(attacker) && isdefined(attacker.pers["team"]) && attacker.pers["team"] == self.pers["team"] && attacker != self)
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
				duration = duration * 0.5;
				rumbleduration = rumbleduration * 0.5;
				hurtvictim = 0;
				hurtattacker = 1;
			}
			else if(level.friendlyfire == 3)
			{
				duration = duration * 0.5;
				rumbleduration = rumbleduration * 0.5;
				hurtattacker = 1;
			}
		}
		else
		{
			attacker notify("flash_hit");
		}

		if(hurtvictim)
		{
			thread applyflash(duration, rumbleduration);
		}

		if(hurtattacker)
		{
			attacker thread applyflash(duration, rumbleduration);
		}
	}
}

applyflash(duration, rumbleduration)
{
	if(!isdefined(self.flashduration) || duration > self.flashduration)
	{
		self.flashduration = duration;
	}

	if(!isdefined(self.flashrumbleduration) || rumbleduration > self.flashrumbleduration)
	{
		self.flashrumbleduration = rumbleduration;
	}

	wait 0.05;
	if(isdefined(self.flashduration))
	{
		self shellshock("flashbang_mp", self.flashduration);
		self.flashendtime = gettime() + self.flashduration * 1000;
	}

	if(isdefined(self.flashrumbleduration))
	{
		thread flashrumbleloop(self.flashrumbleduration);
	}

	self.flashduration = undefined;
	self.flashrumbleduration = undefined;
}

isflashbanged()
{
	return isdefined(self.flashendtime) && gettime() < self.flashendtime;
}