/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\_mgturret.gsc
 * Game: Call of Duty: Black Ops 2
 * Platform: Console
 * Function Count: 11
 * Decompile Time: 52 ms
 * Timestamp: 10/27/2023 3:05:06 AM
*******************************************************************/

#include common_scripts/utility;
#include maps/mp/_utility;

//Function Number: 1
main()
{
	if(GetDvar(#"7C9A91DF") == "")
	{
		setdvar("mgTurret","off");
	}

	level.magic_distance = 24;
	turretinfos = getentarray("turretInfo","targetname");
	for(index = 0;index < turretinfos.size;index++)
	{
		turretinfos[index] delete();
	}
}

//Function Number: 2
set_difficulty(difficulty)
{
	init_turret_difficulty_settings();
	turrets = getentarray("misc_turret","classname");
	for(index = 0;index < turrets.size;index++)
	{
		if(IsDefined(turrets[index].script_skilloverride))
		{
			switch(turrets[index].script_skilloverride)
			{
				case "€GSC\r\n":
					difficulty = "easy";
					break;

				case "€GSC\r\n":
					difficulty = "medium";
					break;

				case "€GSC\r\n":
					difficulty = "hard";
					break;

				case "€GSC\r\n":
					difficulty = "fu";
					break;

				default:
					break;
			}
		}

		turret_set_difficulty(turrets[index],difficulty);
	}
}

//Function Number: 3
init_turret_difficulty_settings()
{
	level.mgturretsettings["easy"]["convergenceTime"] = 2.5;
	level.mgturretsettings["easy"]["suppressionTime"] = 3;
	level.mgturretsettings["easy"]["accuracy"] = 0.38;
	level.mgturretsettings["easy"]["aiSpread"] = 2;
	level.mgturretsettings["easy"]["playerSpread"] = 0.5;
	level.mgturretsettings["medium"]["convergenceTime"] = 1.5;
	level.mgturretsettings["medium"]["suppressionTime"] = 3;
	level.mgturretsettings["medium"]["accuracy"] = 0.38;
	level.mgturretsettings["medium"]["aiSpread"] = 2;
	level.mgturretsettings["medium"]["playerSpread"] = 0.5;
	level.mgturretsettings["hard"]["convergenceTime"] = 0.8;
	level.mgturretsettings["hard"]["suppressionTime"] = 3;
	level.mgturretsettings["hard"]["accuracy"] = 0.38;
	level.mgturretsettings["hard"]["aiSpread"] = 2;
	level.mgturretsettings["hard"]["playerSpread"] = 0.5;
	level.mgturretsettings["fu"]["convergenceTime"] = 0.4;
	level.mgturretsettings["fu"]["suppressionTime"] = 3;
	level.mgturretsettings["fu"]["accuracy"] = 0.38;
	level.mgturretsettings["fu"]["aiSpread"] = 2;
	level.mgturretsettings["fu"]["playerSpread"] = 0.5;
}

//Function Number: 4
turret_set_difficulty(turret,difficulty)
{
	turret.convergencetime = level.mgturretsettings[difficulty]["convergenceTime"];
	turret.suppressiontime = level.mgturretsettings[difficulty]["suppressionTime"];
	turret.accuracy = level.mgturretsettings[difficulty]["accuracy"];
	turret.aispread = level.mgturretsettings[difficulty]["aiSpread"];
	turret.playerspread = level.mgturretsettings[difficulty]["playerSpread"];
}

//Function Number: 5
turret_suppression_fire(targets)
{
	self endon("death");
	self endon("stop_suppression_fire");
	if(!(IsDefined(self.suppresionfire)))
	{
		self.suppresionfire = 1;
	}

	for(;;)
	{
		while(self.suppresionfire)
		{
			self settargetentity(targets[randomint(targets.size)]);
			wait(2 + randomfloat(2));
		}

		self cleartargetentity();
		while(!(self.suppresionfire))
		{
			wait(1);
		}
	}
}

//Function Number: 6
burst_fire_settings(setting)
{
	if(setting == "delay")
	{
		return 0.2;
	}
	else if(setting == "delay_range")
	{
		return 0.5;
	}
	else if(setting == "burst")
	{
		return 0.5;
	}
	else if(setting == "burst_range")
	{
		return 4;
	}
}

//Function Number: 7
burst_fire(turret,manual_target)
{
	turret endon("death");
	turret endon("stopfiring");
	self endon("stop_using_built_in_burst_fire");
	if(IsDefined(turret.script_delay_min))
	{
		turret_delay = turret.script_delay_min;
	}
	else
	{
		turret_delay = burst_fire_settings("delay");
	}

	if(IsDefined(turret.script_delay_max))
	{
		turret_delay_range = turret.script_delay_max - turret_delay;
	}
	else
	{
		turret_delay_range = burst_fire_settings("delay_range");
	}

	if(IsDefined(turret.script_burst_min))
	{
		turret_burst = turret.script_burst_min;
	}
	else
	{
		turret_burst = burst_fire_settings("burst");
	}

	if(IsDefined(turret.script_burst_max))
	{
		turret_burst_range = turret.script_burst_max - turret_burst;
	}
	else
	{
		turret_burst_range = burst_fire_settings("burst_range");
	}

	while(1)
	{
		turret startfiring();
		if(IsDefined(manual_target))
		{
			turret thread random_spread(manual_target);
		}

		turret do_shoot();
		wait(turret_burst + randomfloat(turret_burst_range));
		turret stopshootturret();
		turret stopfiring();
		wait(turret_delay + randomfloat(turret_delay_range));
	}
}

//Function Number: 8
burst_fire_unmanned()
{
	self notify("stop_burst_fire_unmanned");
	self endon("stop_burst_fire_unmanned");
	self endon("death");
	self endon("remote_start");
	level endon("game_ended");
	if(IsDefined(self.controlled) && self.controlled)
	{
		return;
	}

	if(IsDefined(self.script_delay_min))
	{
		turret_delay = self.script_delay_min;
	}
	else
	{
		turret_delay = burst_fire_settings("delay");
	}

	if(IsDefined(self.script_delay_max))
	{
		turret_delay_range = self.script_delay_max - turret_delay;
	}
	else
	{
		turret_delay_range = burst_fire_settings("delay_range");
	}

	if(IsDefined(self.script_burst_min))
	{
		turret_burst = self.script_burst_min;
	}
	else
	{
		turret_burst = burst_fire_settings("burst");
	}

	if(IsDefined(self.script_burst_max))
	{
		turret_burst_range = self.script_burst_max - turret_burst;
	}
	else
	{
		turret_burst_range = burst_fire_settings("burst_range");
	}

	pauseuntiltime = GetTime();
	turretstate = "start";
	self.script_shooting = 0;
	for(;;)
	{
		if(IsDefined(self.manual_targets))
		{
			self cleartargetentity();
			self settargetentity(self.manual_targets[randomint(self.manual_targets.size)]);
		}

		duration = pauseuntiltime - GetTime() * 0.001;
		if(self isfiringturret() && duration <= 0)
		{
			if(turretstate != "fire")
			{
				turretstate = "fire";
				self playsound("mpl_turret_alert");
				self thread do_shoot();
				self.script_shooting = 1;
			}

			duration = turret_burst + randomfloat(turret_burst_range);
			self thread turret_timer(duration);
			self waittill("turretstatechange");
			self.script_shooting = 0;
			duration = turret_delay + randomfloat(turret_delay_range);
			pauseuntiltime = GetTime() + int(duration * 1000);
			continue;
		}

		if(turretstate != "aim")
		{
			turretstate = "aim";
		}

		self thread turret_timer(duration);
		self waittill("turretstatechange");
	}
}

//Function Number: 9
do_shoot()
{
	self endon("death");
	self endon("turretstatechange");
	for(;;)
	{
		self shootturret();
		wait(0.112);
	}
}

//Function Number: 10
turret_timer(duration)
{
	if(duration <= 0)
	{
		return;
	}

	self endon("turretstatechange");
	wait(duration);
	if(IsDefined(self))
	{
		self notify("turretstatechange");
	}
}

//Function Number: 11
random_spread(ent)
{
	self endon("death");
	self notify("stop random_spread");
	self endon("stop random_spread");
	self endon("stopfiring");
	self settargetentity(ent);
	self.manual_target = ent;
	while(1)
	{
		if(isplayer(ent))
		{
			ent.origin = self.manual_target getorigin();
		}
		else
		{
			ent.origin = self.manual_target.origin;
		}

		ent.origin = ent.origin + (20 - randomfloat(40),20 - randomfloat(40),20 - randomfloat(60));
		wait(0.2);
	}
}