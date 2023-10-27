/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\_player_stats.gsc
 * Game: Call of Duty: Ghosts
 * Platform: Console
 * Function Count: 12
 * Decompile Time: 195 ms
 * Timestamp: 10/27/2023 1:37:24 AM
*******************************************************************/

//Function Number: 1
func_45B1()
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
	thread func_7464();
}

//Function Number: 2
func_8C3A()
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
func_6454(param_00,param_01,param_02,param_03)
{
	var_04 = self;
	if(isdefined(self.owner))
	{
		var_04 = self.owner;
	}

	if(!isplayer(var_04))
	{
		if(isdefined(level.var_6084) && level.var_6084)
		{
			var_04 = level.players[randomint(level.players.size)];
		}
	}

	if(!isplayer(var_04))
	{
	}

	if(isdefined(level.var_7579) && isdefined(param_00.drivingvehicle) && param_00.drivingvehicle)
	{
	}

	var_04.stats["kills"]++;
	var_04 career_stat_increment("kills",1);
	if(maps\_utility::func_4840())
	{
		level notify("specops_player_kill",var_04,param_00,param_02,param_03);
	}

	if(isdefined(param_00))
	{
		if(param_00 func_8C3A())
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
			if(isdefined(param_00.var_66A8))
			{
				foreach(var_06 in param_00.var_66A8)
				{
					if(isdefined(var_06))
					{
						var_04 func_6454(var_06,param_01,param_02,param_03);
					}
				}
			}
		}
	}

	if(func_1A81(param_01))
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
		}
	}

	if(var_04 func_4812(param_02))
	{
		var_04 func_645A(param_02);
	}

	var_04.stats["weapon"][param_02].kills++;
}

//Function Number: 4
career_stat_increment(param_00,param_01)
{
	if(!maps\_utility::func_4840())
	{
	}

	var_02 = castint(self getplayerdata("career",param_00)) + param_01;
	self setplayerdata("career",param_00,var_02);
}

//Function Number: 5
func_6461()
{
	if(!isplayer(self))
	{
	}

	if(isdefined(self.var_646B))
	{
	}

	self.var_646B = 1;
	self.stats["shots_hit"]++;
	career_stat_increment("bullets_hit",1);
	var_00 = self getcurrentweapon();
	if(func_4812(var_00))
	{
		func_645A(var_00);
	}

	self.stats["weapon"][var_00].var_7465++;
	waittillframeend;
	self.var_646B = undefined;
}

//Function Number: 6
func_7464()
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
		if(func_4812(var_00))
		{
			func_645A(var_00);
		}

		self.stats["weapon"][var_00].var_7463++;
	}
}

//Function Number: 7
func_4812(param_00)
{
	if(isdefined(self.stats["weapon"][param_00]))
	{
		return 0;
	}

	return 1;
}

//Function Number: 8
func_1A81(param_00)
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
func_645A(param_00)
{
	self.stats["weapon"][param_00] = addstruct();
	self.stats["weapon"][param_00].name = param_00;
	self.stats["weapon"][param_00].var_7463 = 0;
	self.stats["weapon"][param_00].var_7465 = 0;
	self.stats["weapon"][param_00].kills = 0;
}

//Function Number: 10
func_6F9F()
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
			if(var_05.var_7463 > 0)
			{
				var_05.accuracy = castint(var_05.var_7465 / var_05.var_7463 * 100);
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
			setdvar("stats_" + var_00 + "_weapon" + var_07 + 1 + "_shots",var_03[var_07].var_7463);
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
		var_01[var_02] = func_39FB(var_01);
	}

	return var_01;
}

//Function Number: 12
func_39FB(param_00)
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