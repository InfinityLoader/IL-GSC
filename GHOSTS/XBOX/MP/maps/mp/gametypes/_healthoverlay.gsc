/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes\_healthoverlay.gsc
 * Game: Call of Duty: Ghosts
 * Platform: Console
 * Function Count: 8
 * Decompile Time: 131 ms
 * Timestamp: 10/27/2023 1:30:57 AM
*******************************************************************/

//Function Number: 1
func_44DF()
{
	level.healthoverlaycutoff = 0.55;
	var_00 = 5;
	var_00 = maps\mp\gametypes\_tweakables::func_3C5B("player","healthregentime");
	level.playerhealth_regularregendelay = var_00;
	level.healthregendisabled = level.playerhealth_regularregendelay <= 0;
	level thread func_595D();
}

//Function Number: 2
func_595D()
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
		thread func_5FB3();
		self visionsetthermalforplayer(game["thermal_vision"]);
	}
}

//Function Number: 4
func_5FB3()
{
	self endon("death");
	self endon("disconnect");
	self endon("joined_team");
	self endon("joined_spectators");
	self endon("faux_spawn");
	level endon("game_ended");
	if(self.health <= 0)
	{
	}

	var_00 = 0;
	var_01 = 0;
	thread playerpainbreathingsound(self.maxhealth * 0.55);
	for(;;)
	{
		self waittill("damage");
		if(self.health <= 0)
		{
		}

		if(maps\mp\_utility::isjuggernaut())
		{
			continue;
		}

		var_01 = gettime();
		var_02 = self.health / self.maxhealth;
		self.regenspeed = 1;
		if(maps\mp\_utility::_hasperk("specialty_regenfaster"))
		{
			self.regenspeed = self.regenspeed * level.regenfastermod;
		}
		else if(maps\mp\_utility::_hasperk("specialty_bloodrush"))
		{
			self.regenspeed = self.regenspeed * self.bloodrushregenspeedmod;
		}

		if(var_02 <= level.healthoverlaycutoff)
		{
			self.atbrinkofdeath = 1;
		}

		thread func_405D(var_01,var_02);
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
	if(maps\mp\_utility::func_4995())
	{
	}

	if(!isplayer(self))
	{
	}

	self.breathingstoptime = param_00 + 6000 * self.regenspeed;
	wait(6 * self.regenspeed);
	if(!level.gameended)
	{
		if(self cancelmantle())
		{
			self playlocalsound("Fem_breathing_better");
		}

		self playlocalsound("breathing_better");
	}
}

//Function Number: 6
func_405D(param_00,param_01)
{
	self notify("healthRegeneration");
	self endon("healthRegeneration");
	self endon("death");
	self endon("disconnect");
	self endon("joined_team");
	self endon("joined_spectators");
	level endon("game_ended");
	var_02 = level.healthregendisabled || isdefined(self.healthregendisabled) && self.healthregendisabled;
	if(var_02)
	{
	}

	childthread maps\mp\perks\_perkfunctions::regenspeedwatcher();
	wait(level.playerhealth_regularregendelay * self.regenspeed);
	if(param_01 < 0.55)
	{
		var_03 = 1;
	}
	else
	{
		var_03 = 0;
	}

	for(;;)
	{
		if(!isdefined(self.regenspeed) || self.regenspeed == 1)
		{
			wait(0.05);
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
		else
		{
			wait(0.05);
			if(self.health < self.maxhealth)
			{
				if(maps\mp\_utility::_hasperk("specialty_regenfaster"))
				{
					self.health = self.health + level.regenfasterhealthmod;
				}
				else if(maps\mp\_utility::_hasperk("specialty_bloodrush"))
				{
					self.health = self.health + self.bloodrushregenhealthmod;
				}
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

	self notify("healed");
	maps\mp\gametypes\_damage::func_6606();
	if(var_03)
	{
		maps\mp\gametypes\_missions::func_405B();
	}
}

//Function Number: 7
func_8A87()
{
	self notify("waiting_to_stop_remote");
	self endon("waiting_to_stop_remote");
	self endon("death");
	level endon("game_ended");
	self waittill("stopped_using_remote");
	maps\mp\_utility::func_6659(0);
}

//Function Number: 8
playerpainbreathingsound(param_00)
{
	level endon("game_ended");
	self endon("death");
	self endon("disconnect");
	self endon("joined_team");
	self endon("joined_spectators");
	if(!isplayer(self))
	{
	}

	wait(2);
	for(;;)
	{
		wait(0.2);
		if(self.health <= 0)
		{
		}

		if(self.health >= param_00)
		{
			continue;
		}

		var_01 = level.healthregendisabled || isdefined(self.healthregendisabled) && self.healthregendisabled;
		if(var_01 && isdefined(self.breathingstoptime) && gettime() > self.breathingstoptime)
		{
			continue;
		}

		if(maps\mp\_utility::func_4995())
		{
			continue;
		}

		if(self cancelmantle())
		{
			self playlocalsound("Fem_breathing_hurt");
		}
		else
		{
			self playlocalsound("breathing_hurt");
		}

		wait(0.784);
		wait(0.1 + randomfloat(0.8));
	}
}