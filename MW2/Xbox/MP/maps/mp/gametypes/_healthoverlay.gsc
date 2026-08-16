/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes\_healthoverlay.gsc
 * Game: Call of Duty: Modern Warfare 2
 * Platform: Xbox
*******************************************************************/

init()
{
	level.healthoverlaycutoff = 0.55;
	regentime = 5;
	regentime = maps\mp\gametypes\_tweakables::gettweakablevalue("player", "healthregentime");
	level.playerhealth_regularregendelay = regentime * 1000;
	level.healthregendisabled = level.playerhealth_regularregendelay <= 0;
	level thread onplayerconnect();
}

onplayerconnect()
{
	for(;;)
	{
		level waittill("connected", player);
		player thread onplayerspawned();
	}
}

onplayerspawned()
{
	self endon("disconnect");
	for(;;)
	{
		self waittill("spawned_player");
		thread playerhealthregen();
		thread showtempdamage();
	}
}

showtempdamage()
{
	self endon("death");
	self endon("disconnect");
}

playerhealthregen()
{
	self endon("death");
	self endon("disconnect");
	self endon("joined_team");
	self endon("joined_spectators");
	if(self.health <= 0)
	{
		return;
	}

	oldhealth = self.maxhealth;
	regenrate = 0.1;
	veryhurt = 0;
	self.breathingstoptime = -10000;
	thread playerbreathingsound(self.maxhealth * 0.35);
	lastsoundtime_recover = 0;
	hurttime = 0;
	newhealth = 0;
	for(;;)
	{
		wait 0.05;
		if(isdefined(level.hostmigrationtimer))
		{
			timepassed = maps\mp\gametypes\_hostmigration::waittillhostmigrationdone();
			hurttime = hurttime + timepassed;
			lastsoundtime_recover = lastsoundtime_recover + timepassed;
		}

		if(self.health == self.maxhealth || level.diehardmode && isdefined(self.healthclamped) && self.health >= self.healthclamped)
		{
			oldhealth = self.maxhealth;
			veryhurt = 0;
			self.atbrinkofdeath = 0;
			continue;
		}

		if(self.health <= 0)
		{
			return;
		}

		curtime = gettime();
		ratio = self.health / self.maxhealth;
		if(ratio <= level.healthoverlaycutoff)
		{
			if(!veryhurt)
			{
				hurttime = curtime;
			}

			veryhurt = 1;
			self.atbrinkofdeath = 1;
		}

		if(self.health >= oldhealth)
		{
			if(curtime - hurttime < level.playerhealth_regularregendelay)
			{
				continue;
			}

			if(level.healthregendisabled)
			{
				wait 3;
				self.maxhealth = int(max(self.health, 2));
				self.health = self.maxhealth;
				continue;
			}

			if(curtime - lastsoundtime_recover > level.playerhealth_regularregendelay)
			{
				lastsoundtime_recover = curtime;
				if(!level.gameended)
				{
					self playlocalsound("breathing_better");
				}
			}

			if(veryhurt)
			{
				newhealth = ratio;
				if(curtime > hurttime + 3000)
				{
					newhealth = newhealth + regenrate;
				}
			}
			else
			{
				newhealth = 1;
			}

			if(newhealth >= 1)
			{
				if(veryhurt)
				{
					maps\mp\gametypes\_missions::healthregenerated();
				}

				maps\mp\gametypes\_damage::resetattackerlist();
				newhealth = 1;
			}

			if(newhealth <= 0)
			{
				return;
			}

			self setnormalhealth(newhealth);
			oldhealth = self.health;
			continue;
		}

		oldhealth = self.health;
		hurttime = curtime;
		self.breathingstoptime = hurttime + 6000;
	}
}

playerbreathingsound(healthcap)
{
	level endon("game_ended");
	self endon("death");
	self endon("disconnect");
	self endon("joined_team");
	self endon("joined_spectators");
	wait 2;
	for(;;)
	{
		wait 0.2;
		if(self.health <= 0)
		{
			return;
		}

		if(self.health >= healthcap)
		{
			continue;
		}

		if(level.healthregendisabled && gettime() > self.breathingstoptime)
		{
			continue;
		}

		self playlocalsound("breathing_hurt");
		wait 0.784;
		wait 0.1 + randomfloat(0.8);
	}
}