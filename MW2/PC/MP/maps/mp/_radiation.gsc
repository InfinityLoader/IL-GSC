/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\_radiation.gsc
 * Game: Call of Duty: Modern Warfare 2
 * Platform: PC
*******************************************************************/

radiation()
{
	precachestring(&"SCRIPT_RADIATION_DEATH");
	radiationfields = getentarray("radiation", "targetname");
	if(radiationfields.size > 0)
	{
		precacheshellshock("mp_radiation_low");
		precacheshellshock("mp_radiation_med");
		precacheshellshock("mp_radiation_high");
		foreach(trigger in radiationfields)
		{
			trigger thread common_scripts\_dynamic_world::triggertouchthink(::playerenterarea, ::playerleavearea);
		}

		thread onplayerconnect();
		return;
	}
}

onplayerconnect()
{
	for(;;)
	{
		level waittill("connected", player);
		player.numareas = 0;
	}
}

playerenterarea(trigger)
{
	self.numareas++;
	if(self.numareas == 1)
	{
		radiationeffect();
		return;
	}
}

playerleavearea(trigger)
{
	self.numareas--;
	if(self.numareas != 0)
	{
		return;
	}

	self.poison = 0;
	self notify("leftTrigger");
	if(isdefined(self.radiationoverlay))
	{
		self.radiationoverlay fadeoutblackout(0.1, 0);
		return;
	}
}

soundwatcher(soundorg)
{
	common_scripts\utility::waittill_any("death", "leftTrigger");
	self stoploopsound();
}

radiationeffect()
{
	self endon("disconnect");
	self endon("game_ended");
	self endon("death");
	self endon("leftTrigger");
	self.poison = 0;
	thread soundwatcher(self);
	for(;;)
	{
		self.poison++;
		switch(self.poison)
		{
			case 1:
				self.radiationsound = "item_geigercouner_level2";
				self playloopsound(self.radiationsound);
				self viewkick(1, self.origin);
				break;
	
			case 3:
				self shellshock("mp_radiation_low", 4);
				self.radiationsound = "item_geigercouner_level3";
				self stoploopsound();
				self playloopsound(self.radiationsound);
				self viewkick(3, self.origin);
				doradiationdamage(15);
				break;
	
			case 4:
				self shellshock("mp_radiation_med", 5);
				self.radiationsound = "item_geigercouner_level3";
				self stoploopsound();
				self playloopsound(self.radiationsound);
				self viewkick(15, self.origin);
				thread blackout();
				doradiationdamage(25);
				break;
	
			case 6:
				self shellshock("mp_radiation_high", 5);
				self.radiationsound = "item_geigercouner_level4";
				self stoploopsound();
				self playloopsound(self.radiationsound);
				self viewkick(75, self.origin);
				doradiationdamage(45);
				break;
	
			case 8:
				self shellshock("mp_radiation_high", 5);
				self.radiationsound = "item_geigercouner_level4";
				self stoploopsound();
				self playloopsound(self.radiationsound);
				self viewkick(127, self.origin);
				doradiationdamage(175);
				break;
		}

		wait 1;
	}

	wait 5;
}

blackout()
{
	self endon("disconnect");
	self endon("game_ended");
	self endon("death");
	self endon("leftTrigger");
	if(!isdefined(self.radiationoverlay))
	{
		self.radiationoverlay = newclienthudelem(self);
		self.radiationoverlay.x = 0;
		self.radiationoverlay.y = 0;
		self.radiationoverlay setshader("black", 640, 480);
		self.radiationoverlay.alignx = "left";
		self.radiationoverlay.aligny = "top";
		self.radiationoverlay.horzalign = "fullscreen";
		self.radiationoverlay.vertalign = "fullscreen";
		self.radiationoverlay.alpha = 0;
	}

	min_length = 1;
	max_length = 2;
	min_alpha = 0.25;
	max_alpha = 1;
	min_percent = 5;
	max_percent = 100;
	fraction = 0;
	for(;;)
	{
		while(self.poison > 1)
		{
			percent_range = max_percent - min_percent;
			fraction = self.poison - min_percent / percent_range;
			if(fraction < 0)
			{
				fraction = 0;
			}
			else if(fraction > 1)
			{
				fraction = 1;
			}

			length_range = max_length - min_length;
			length = min_length + length_range * 1 - fraction;
			alpha_range = max_alpha - min_alpha;
			alpha = min_alpha + alpha_range * fraction;
			end_alpha = fraction * 0.5;
			if(fraction == 1)
			{
				break;
			}

			duration = length / 2;
			self.radiationoverlay fadeinblackout(duration, alpha);
			self.radiationoverlay fadeoutblackout(duration, end_alpha);
			wait fraction * 0.5;
		}

		if(fraction == 1)
		{
			break;
		}

		if(self.radiationoverlay.alpha != 0)
		{
			self.radiationoverlay fadeoutblackout(1, 0);
		}

		wait 0.05;
	}

	self.radiationoverlay fadeinblackout(2, 0);
}

doradiationdamage(idamage)
{
	self thread [[ level.callbackplayerdamage ]](self, self, idamage, 0, "MOD_SUICIDE", "claymore_mp", self.origin, (0,0,0) - self.origin, "none", 0);
}

fadeinblackout(duration, alpha)
{
	self fadeovertime(duration);
	self.alpha = alpha;
	wait duration;
}

fadeoutblackout(duration, alpha)
{
	self fadeovertime(duration);
	self.alpha = alpha;
	wait duration;
}