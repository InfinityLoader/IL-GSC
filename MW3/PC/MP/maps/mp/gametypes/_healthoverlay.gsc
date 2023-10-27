/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes\_healthoverlay.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: PC
 * Function Count: 8
 * Decompile Time: 134 ms
 * Timestamp: 10/27/2023 2:12:30 AM
*******************************************************************/

//Function Number: 1
init()
{
	level.healthoverlaycutoff = 0.55;
	var_00 = 5;
	var_00 = maps\mp\gametypes\_tweakables::gettweakablevalue("player","healthregentime");
	level.playerhealth_regularregendelay = var_00 * 1000;
	level.healthregendisabled = level.playerhealth_regularregendelay <= 0;
	level thread onplayerconnect();
}

//Function Number: 2
onplayerconnect()
{
	for(;;)
	{
		level waittill("connected",var_00);
		var_00 thread onplayerspawned();
	}
}

//Function Number: 3
onplayerspawned()
{
	self endon("disconnect");
	for(;;)
	{
		self waittill("spawned_player");
		thread playerhealthregen();
	}
}

//Function Number: 4
playerhealthregen()
{
	self endon("death");
	self endon("disconnect");
	self endon("joined_team");
	self endon("joined_spectators");
	self endon("faux_spawn");
	level endon("game_ended");
	if(self.health <= 0)
	{
		return;
	}

	var_00 = 0;
	var_01 = 0;
	thread playerpainbreathingsound(self.maxhealth * 0.55);
	for(;;)
	{
		self waittill("damage");
		if(self.health <= 0)
		{
			return;
		}

		var_01 = gettime();
		var_02 = self.health / self.maxhealth;
		if(!isdefined(self.healthregenlevel))
		{
			self.regenspeed = 1;
		}
		else if(self.healthregenlevel == 0.33)
		{
			self.regenspeed = 0.75;
		}
		else if(self.healthregenlevel == 0.66)
		{
			self.regenspeed = 0.5;
		}
		else if(self.healthregenlevel == 0.99)
		{
			self.regenspeed = 0.3;
		}
		else
		{
			self.regenspeed = 1;
		}

		if(var_02 <= level.healthoverlaycutoff)
		{
			self.atbrinkofdeath = 1;
		}

		thread healthregeneration(var_01,var_02);
		thread breathingmanager(var_01,var_02);
	}
}

//Function Number: 5
breathingmanager(param_00,param_01)
{
	self notify("breathingManager");
	self endon("breathingManager");
	self endon("death");
	self endon("disconnect");
	self endon("joined_team");
	self endon("joined_spectators");
	level endon("game_ended");
	if(maps\mp\_utility::isusingremote())
	{
		return;
	}

	self.breathingstoptime = param_00 + 6000 * self.regenspeed;
	wait 6 * self.regenspeed;
	if(!level.gameended)
	{
		self playlocalsound("breathing_better");
	}
}

//Function Number: 6
healthregeneration(param_00,param_01)
{
	self notify("healthRegeneration");
	self endon("healthRegeneration");
	self endon("death");
	self endon("disconnect");
	self endon("joined_team");
	self endon("joined_spectators");
	level endon("game_ended");
	if(level.healthregendisabled)
	{
		return;
	}

	wait level.playerhealth_regularregendelay / 1000 * self.regenspeed;
	if(param_01 < 0.55)
	{
		var_02 = 1;
	}
	else
	{
		var_02 = 0;
	}

	for(;;)
	{
		if(self.regenspeed == 0.75)
		{
			wait 0.2;
			if(self.health < self.maxhealth)
			{
				self.health = self.health + 5;
			}
			else
			{
				break;
			}
		}
		else if(self.regenspeed == 0.5)
		{
			wait 0.05;
			if(self.health < self.maxhealth)
			{
				self.health = self.health + 2;
			}
			else
			{
				break;
			}
		}
		else if(self.regenspeed == 0.3)
		{
			wait 0.15;
			if(self.health < self.maxhealth)
			{
				self.health = self.health + 9;
			}
			else
			{
				break;
			}
		}
		else if(!isdefined(self.regenspeed) || self.regenspeed == 1)
		{
			wait 0.05;
			if(self.health < self.maxhealth)
			{
				self.health = self.health + 1;
				param_01 = self.health / self.maxhealth;
			}
			else
			{
				break;
			}
		}

		if(self.health > self.maxhealth)
		{
			self.health = self.maxhealth;
		}
	}

	maps\mp\gametypes\_damage::resetattackerlist();
	if(var_02)
	{
		maps\mp\gametypes\_missions::healthregenerated();
	}
}

//Function Number: 7
wait_for_not_using_remote()
{
	self notify("waiting_to_stop_remote");
	self endon("waiting_to_stop_remote");
	self endon("death");
	level endon("game_ended");
	self waittill("stopped_using_remote");
	if(isdefined(level.nukedetonated))
	{
		self visionsetnakedforplayer(level.nukevisionset,0);
		return;
	}

	self visionsetnakedforplayer("",0);
}

//Function Number: 8
playerpainbreathingsound(param_00)
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

		if(self.health >= param_00)
		{
			continue;
		}

		if(level.healthregendisabled && gettime() > self.breathingstoptime)
		{
			continue;
		}

		if(maps\mp\_utility::isusingremote())
		{
			continue;
		}

		self playlocalsound("breathing_hurt");
		wait 0.784;
		wait 0.1 + randomfloat(0.8);
	}
}