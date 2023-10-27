/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes\_healthoverlay.gsc
 * Game: Call of Duty: Black Ops 2
 * Platform: PC
 * Function Count: 11
 * Decompile Time: 20 ms
 * Timestamp: 10/27/2023 3:00:07 AM
*******************************************************************/

#include maps/mp/gametypes/_globallogic_player;

//Function Number: 1
init()
{
	precacheshader("overlay_low_health");
	level.healthoverlaycutoff = 0.55;
	regentime = level.playerhealthregentime;
	level.playerhealth_regularregendelay = regentime * 1000;
	level.healthregendisabled = level.playerhealth_regularregendelay <= 0;
	level thread onplayerconnect();
}

//Function Number: 2
onplayerconnect()
{
	for(;;)
	{
		level waittill("connecting",player);
		player thread onplayerspawned();
		player thread onplayerkilled();
		player thread onjoinedteam();
		player thread onjoinedspectators();
		player thread onplayerdisconnect();
	}
}

//Function Number: 3
onjoinedteam()
{
	self endon("disconnect");
	for(;;)
	{
		self waittill("joined_team");
		self notify("end_healthregen");
	}
}

//Function Number: 4
onjoinedspectators()
{
	self endon("disconnect");
	for(;;)
	{
		self waittill("joined_spectators");
		self notify("end_healthregen");
	}
}

//Function Number: 5
onplayerspawned()
{
	self endon("disconnect");
	for(;;)
	{
		self waittill("spawned_player");
		self thread playerhealthregen();
	}
}

//Function Number: 6
onplayerkilled()
{
	self endon("disconnect");
	for(;;)
	{
		self waittill("killed_player");
		self notify("end_healthregen");
	}
}

//Function Number: 7
onplayerdisconnect()
{
	self waittill("disconnect");
	self notify("end_healthregen");
}

//Function Number: 8
playerhealthregen()
{
	self endon("end_healthregen");
	if(self.health <= 0)
	{
/#
		assert(!isalive(self));
#/
		return;
	}

	maxhealth = self.health;
	oldhealth = maxhealth;
	player = self;
	health_add = 0;
	regenrate = 0.1;
	usetrueregen = 0;
	veryhurt = 0;
	player.breathingstoptime = -10000;
	thread playerbreathingsound(maxhealth * 0.35);
	thread playerheartbeatsound(maxhealth * 0.35);
	lastsoundtime_recover = 0;
	hurttime = 0;
	newhealth = 0;
	for(;;)
	{
		wait(0.05);
		if(IsDefined(player.regenrate))
		{
			regenrate = player.regenrate;
			usetrueregen = 1;
		}

		if(player.health == maxhealth)
		{
			veryhurt = 0;
			self.atbrinkofdeath = 0;
			continue;
		}

		if(player.health <= 0)
		{
			return;
		}

		if(IsDefined(player.laststand) && player.laststand)
		{
			continue;
		}

		wasveryhurt = veryhurt;
		ratio = player.health / maxhealth;
		if(ratio <= level.healthoverlaycutoff)
		{
			veryhurt = 1;
			self.atbrinkofdeath = 1;
			if(!(wasveryhurt))
			{
				hurttime = GetTime();
			}
		}

		if(player.health >= oldhealth)
		{
			regentime = level.playerhealth_regularregendelay;
			if(player hasperk("specialty_healthregen"))
			{
				regentime = int(regentime / GetDvarFloat(#"C55B3BC4"));
			}

			if(GetTime() - hurttime < regentime)
			{
				continue;
			}

			if(level.healthregendisabled)
			{
				continue;
			}

			if(GetTime() - lastsoundtime_recover > regentime)
			{
				lastsoundtime_recover = GetTime();
				self notify("snd_breathing_better");
			}

			if(veryhurt)
			{
				newhealth = ratio;
				veryhurttime = 3000;
				if(player hasperk("specialty_healthregen"))
				{
					veryhurttime = int(veryhurttime / GetDvarFloat(#"C55B3BC4"));
				}

				if(GetTime() > hurttime + veryhurttime)
				{
					newhealth = newhealth + regenrate;
				}
			}
			else if(usetrueregen)
			{
				newhealth = ratio + regenrate;
			}
			else
			{
				newhealth = 1;
			}

			if(newhealth >= 1)
			{
				self maps/mp/gametypes/_globallogic_player::resetattackerlist();
				newhealth = 1;
			}

			if(newhealth <= 0)
			{
				return;
			}

			player setnormalhealth(newhealth);
			change = player.health - oldhealth;
			if(change > 0)
			{
				player decayplayerdamages(change);
			}

			oldhealth = player.health;
			continue;
		}

		oldhealth = player.health;
		health_add = 0;
		hurttime = GetTime();
		player.breathingstoptime = hurttime + 6000;
	}
}

//Function Number: 9
decayplayerdamages(decay)
{
	if(!(IsDefined(self.attackerdamage)))
	{
		return;
	}

	for(i = 0;i < self.attackerdamage.size;i++)
	{
		if(!IsDefined(self.attackerdamage[i]) || !IsDefined(self.attackerdamage[i].damage))
		{
		}
		else
		{
			self.attackerdamage[i].damage = self.attackerdamage[i].damage - decay;
			if(self.attackerdamage[i].damage < 0)
			{
				self.attackerdamage[i].damage = 0;
			}
		}
	}
}

//Function Number: 10
playerbreathingsound(healthcap)
{
	self endon("end_healthregen");
	wait(2);
	player = self;
	for(;;)
	{
		wait(0.2);
		if(player.health <= 0)
		{
			return;
		}

		if(player.health >= healthcap)
		{
			continue;
		}

		if(level.healthregendisabled && GetTime() > player.breathingstoptime)
		{
			continue;
		}

		player notify("snd_breathing_hurt");
		wait(0.784);
		wait(0.1 + randomfloat(0.8));
	}
}

//Function Number: 11
playerheartbeatsound(healthcap)
{
	self endon("end_healthregen");
	self.hearbeatwait = 0.2;
	wait(2);
	player = self;
	for(;;)
	{
		wait(0.2);
		if(player.health <= 0)
		{
			return;
		}

		if(player.health >= healthcap)
		{
			self.hearbeatwait = 0.3;
			continue;
		}

		if(level.healthregendisabled && GetTime() > player.breathingstoptime)
		{
			self.hearbeatwait = 0.3;
			continue;
		}

		player playlocalsound("mpl_player_heartbeat");
		wait(self.hearbeatwait);
		if(self.hearbeatwait <= 0.6)
		{
			self.hearbeatwait = self.hearbeatwait + 0.1;
		}
	}
}