/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\_player_stats.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: Console
 * Function Count: 12
 * Decompile Time: 202 ms
 * Timestamp: 10/27/2023 2:34:04 AM
*******************************************************************/

//Function Number: 1
init_stats()
{
	self.stats["kills"] = 0;
	self.stats["kills_melee"] = 0;
	self.stats["kills_explosives"] = 0;
	self.stats["kills_juggernaut"] = 0;
	self.stats["kills_vehicle"] = 0;
	self.stats["kills_sentry"] = 0;
	self.stats["headshots"] = 0;
	self.stats["shots_fired"] = 0;
	self.stats["shots_hit"] = 0;
	self.stats["weapon"] = [];
	thread shots_fired_recorder();
}

//Function Number: 2
was_headshot()
{
	if(isdefined(self.died_of_headshot) && self.died_of_headshot)
	{
		return 1;
	}

	if(!isdefined(self.damagelocation))
	{
		return 0;
	}

	return self.damagelocation == "helmet" || self.damagelocation == "head" || self.damagelocation == "neck";
}

//Function Number: 3
register_kill(param_00,param_01,param_02,param_03)
{
	var_04 = self;
	if(isdefined(self.owner))
	{
		var_04 = self.owner;
	}

	if(!isplayer(var_04))
	{
		if(isdefined(level.pmc_match) && level.pmc_match)
		{
			var_04 = level.players[randomint(level.players.size)];
		}
	}

	if(!isplayer(var_04))
	{
		return;
	}

	if(isdefined(level.var_80DE) && isdefined(param_00.drivingvehicle) && param_00.drivingvehicle)
	{
		return;
	}

	var_04.stats["kills"]++;
	var_04 career_stat_increment("kills",1);
	if(maps\_utility::is_specialop())
	{
		level notify("specops_player_kill",var_04,param_00,param_02,param_03);
	}

	if(isdefined(param_00))
	{
		if(param_00 was_headshot())
		{
			var_04.stats["headshots"]++;
			var_04 career_stat_increment("headshots",1);
		}

		if(isdefined(param_00.juggernaut))
		{
			var_04.stats["kills_juggernaut"]++;
			var_04 career_stat_increment("kills_juggernaut",1);
		}

		if(isdefined(param_00.issentrygun))
		{
			var_04.stats["kills_sentry"]++;
		}

		if(param_00.code_classname == "script_vehicle")
		{
			var_04.stats["kills_vehicle"]++;
			if(isdefined(param_00.riders))
			{
				foreach(var_06 in param_00.riders)
				{
					if(isdefined(var_06))
					{
						var_04 register_kill(var_06,param_01,param_02,param_03);
					}
				}
			}
		}
	}

	if(cause_is_explosive(param_01))
	{
		var_04.stats["kills_explosives"]++;
	}

	if(!isdefined(param_02))
	{
		param_02 = var_04 getcurrentweapon();
	}

	if(issubstr(tolower(param_01),"melee"))
	{
		var_04.stats["kills_melee"]++;
		if(weaponinventorytype(param_02) == "primary")
		{
			return;
		}
	}

	if(var_04 is_new_weapon(param_02))
	{
		var_04 func_065B(param_02);
	}

	var_04.stats["weapon"][param_02].kills++;
}

//Function Number: 4
career_stat_increment(param_00,param_01)
{
	if(!maps\_utility::is_specialop())
	{
		return;
	}

	var_02 = int(self getplayerdata("career",param_00)) + param_01;
	self setplayerdata("career",param_00,var_02);
}

//Function Number: 5
register_shot_hit()
{
	if(!isplayer(self))
	{
		return;
	}

	if(isdefined(self.registeringshothit))
	{
		return;
	}

	self.registeringshothit = 1;
	self.stats["shots_hit"]++;
	career_stat_increment("bullets_hit",1);
	var_00 = self getcurrentweapon();
	if(is_new_weapon(var_00))
	{
		func_065B(var_00);
	}

	self.stats["weapon"][var_00].shots_hit++;
	waittillframeend;
	self.registeringshothit = undefined;
}

//Function Number: 6
shots_fired_recorder()
{
	self endon("death");
	for(;;)
	{
		self waittill("weapon_fired");
		var_00 = self getcurrentweapon();
		if(!isdefined(var_00) || !maps\_utility::isprimaryweapon(var_00))
		{
			continue;
		}

		self.stats["shots_fired"]++;
		career_stat_increment("bullets_fired",1);
		if(is_new_weapon(var_00))
		{
			func_065B(var_00);
		}

		self.stats["weapon"][var_00].shots_fired++;
	}
}

//Function Number: 7
is_new_weapon(param_00)
{
	if(isdefined(self.stats["weapon"][param_00]))
	{
		return 0;
	}

	return 1;
}

//Function Number: 8
cause_is_explosive(param_00)
{
	param_00 = tolower(param_00);
	switch(param_00)
	{
		case "splash":
		case "mod_explosive":
		case "mod_projectile_splash":
		case "mod_projectile":
		case "mod_grenade_splash":
		case "mod_grenade":
			return 1;

		default:
			return 0;
	}

	return 0;
}

//Function Number: 9
func_065B(param_00)
{
	self.stats["weapon"][param_00] = spawnstruct();
	self.stats["weapon"][param_00].name = param_00;
	self.stats["weapon"][param_00].shots_fired = 0;
	self.stats["weapon"][param_00].shots_hit = 0;
	self.stats["weapon"][param_00].kills = 0;
}

//Function Number: 10
func_065C()
{
	var_00 = 1;
	foreach(var_02 in level.players)
	{
		setdvar("stats_" + var_00 + "_kills_melee",var_02.stats["kills_melee"]);
		setdvar("stats_" + var_00 + "_kills_juggernaut",var_02.stats["kills_juggernaut"]);
		setdvar("stats_" + var_00 + "_kills_explosives",var_02.stats["kills_explosives"]);
		setdvar("stats_" + var_00 + "_kills_vehicle",var_02.stats["kills_vehicle"]);
		setdvar("stats_" + var_00 + "_kills_sentry",var_02.stats["kills_sentry"]);
		var_03 = var_02 get_best_weapons(5);
		foreach(var_05 in var_03)
		{
			var_05.accuracy = 0;
			if(var_05.shots_fired > 0)
			{
				var_05.accuracy = int(var_05.shots_hit / var_05.shots_fired * 100);
			}
		}

		for(var_07 = 1;var_07 < 6;var_07++)
		{
			setdvar("stats_" + var_00 + "_weapon" + var_07 + "_name"," ");
			setdvar("stats_" + var_00 + "_weapon" + var_07 + "_kills"," ");
			setdvar("stats_" + var_00 + "_weapon" + var_07 + "_shots"," ");
			setdvar("stats_" + var_00 + "_weapon" + var_07 + "_accuracy"," ");
		}

		for(var_07 = 0;var_07 < var_03.size;var_07++)
		{
			if(!isdefined(var_03[var_07]))
			{
				break;
			}

			setdvar("stats_" + var_00 + "_weapon" + var_07 + 1 + "_name",var_03[var_07].name);
			setdvar("stats_" + var_00 + "_weapon" + var_07 + 1 + "_kills",var_03[var_07].kills);
			setdvar("stats_" + var_00 + "_weapon" + var_07 + 1 + "_shots",var_03[var_07].shots_fired);
			setdvar("stats_" + var_00 + "_weapon" + var_07 + 1 + "_accuracy",var_03[var_07].accuracy + "%");
		}

		var_00++;
	}
}

//Function Number: 11
get_best_weapons(param_00)
{
	var_01 = [];
	for(var_02 = 0;var_02 < param_00;var_02++)
	{
		var_01[var_02] = get_weapon_with_most_kills(var_01);
	}

	return var_01;
}

//Function Number: 12
get_weapon_with_most_kills(param_00)
{
	if(!isdefined(param_00))
	{
		param_00 = [];
	}

	var_01 = undefined;
	foreach(var_03 in self.stats["weapon"])
	{
		var_04 = 0;
		foreach(var_06 in param_00)
		{
			if(var_03.name == var_06.name)
			{
				var_04 = 1;
				break;
			}
		}

		if(var_04)
		{
			continue;
		}

		if(!isdefined(var_01))
		{
			var_01 = var_03;
			continue;
		}

		if(var_03.kills > var_01.kills)
		{
			var_01 = var_03;
		}
	}

	return var_01;
}