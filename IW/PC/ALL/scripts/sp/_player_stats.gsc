/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\sp\_player_stats.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 11
 * Decompile Time: 555 ms
 * Timestamp: 10/27/2023 12:24:55 AM
*******************************************************************/

//Function Number: 1
func_9768()
{
	self.var_10E53["kills"] = 0;
	self.var_10E53["kills_melee"] = 0;
	self.var_10E53["kills_explosives"] = 0;
	self.var_10E53["kills_juggernaut"] = 0;
	self.var_10E53["kills_vehicle"] = 0;
	self.var_10E53["kills_sentry"] = 0;
	self.var_10E53["headshots"] = 0;
	self.var_10E53["shots_fired"] = 0;
	self.var_10E53["shots_hit"] = 0;
	self.var_10E53["weapon"] = [];
	thread func_FF05();
}

//Function Number: 2
func_13901()
{
	if(isdefined(self.var_54CA) && self.var_54CA)
	{
		return 1;
	}

	if(!isdefined(self.var_DD))
	{
		return 0;
	}

	return self.var_DD == "helmet" || self.var_DD == "head" || self.var_DD == "neck";
}

//Function Number: 3
func_DEBD(param_00,param_01,param_02,param_03)
{
	var_04 = self;
	if(isdefined(self.var_222))
	{
		var_04 = self.var_222;
	}

	if(!isplayer(var_04))
	{
		if(isdefined(level.var_D5ED) && level.var_D5ED)
		{
			var_04 = level.players[randomint(level.players.size)];
		}
	}

	if(!isplayer(var_04))
	{
		return;
	}

	if(isdefined(level.var_10259) && isdefined(param_00.var_5BD6) && param_00.var_5BD6)
	{
		return;
	}

	var_04.var_10E53["kills"]++;
	if(isdefined(param_00))
	{
		if(param_00 func_13901())
		{
			var_04.var_10E53["headshots"]++;
		}

		if(isdefined(param_00.var_A4A3))
		{
			var_04.var_10E53["kills_juggernaut"]++;
		}

		if(isdefined(param_00.var_9F45))
		{
			var_04.var_10E53["kills_sentry"]++;
		}

		if(param_00.var_9F == "script_vehicle")
		{
			var_04.var_10E53["kills_vehicle"]++;
			if(isdefined(param_00.var_E4FB))
			{
				foreach(var_06 in param_00.var_E4FB)
				{
					if(isdefined(var_06))
					{
						var_04 func_DEBD(var_06,param_01,param_02,param_03);
					}
				}
			}
		}
	}

	if(func_3B9F(param_01))
	{
		var_04.var_10E53["kills_explosives"]++;
	}

	if(!isdefined(param_02))
	{
		param_02 = var_04 getcurrentweapon();
	}

	if(issubstr(tolower(param_01),"melee"))
	{
		var_04.var_10E53["kills_melee"]++;
		if(function_0244(param_02) == "primary")
		{
			return;
		}
	}

	if(var_04 func_9C49(param_02))
	{
		var_04 func_DEC5(param_02);
	}

	var_04.var_10E53["weapon"][param_02].var_1AB++;
}

//Function Number: 4
func_DED8()
{
	if(!isplayer(self))
	{
		return;
	}

	if(isdefined(self.var_DEF6))
	{
		return;
	}

	self.var_DEF6 = 1;
	self.var_10E53["shots_hit"]++;
	var_00 = self getcurrentweapon();
	if(func_9C49(var_00))
	{
		func_DEC5(var_00);
	}

	self.var_10E53["weapon"][var_00].var_FF06++;
	waittillframeend;
	self.var_DEF6 = undefined;
}

//Function Number: 5
func_FF05()
{
	self endon("death");
	for(;;)
	{
		self waittill("weapon_fired");
		var_00 = self getcurrentweapon();
		if(!isdefined(var_00) || !scripts\sp\_utility::func_9F0E(var_00))
		{
			continue;
		}

		self.var_10E53["shots_fired"]++;
		if(func_9C49(var_00))
		{
			func_DEC5(var_00);
		}

		self.var_10E53["weapon"][var_00].var_FF04++;
	}
}

//Function Number: 6
func_9C49(param_00)
{
	if(isdefined(self.var_10E53["weapon"][param_00]))
	{
		return 0;
	}

	return 1;
}

//Function Number: 7
func_3B9F(param_00)
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

//Function Number: 8
func_DEC5(param_00)
{
	self.var_10E53["weapon"][param_00] = spawnstruct();
	self.var_10E53["weapon"][param_00].name = param_00;
	self.var_10E53["weapon"][param_00].var_FF04 = 0;
	self.var_10E53["weapon"][param_00].var_FF06 = 0;
	self.var_10E53["weapon"][param_00].var_1AB = 0;
}

//Function Number: 9
func_F5B2()
{
	var_00 = 1;
	foreach(var_02 in level.players)
	{
		setdvar("stats_" + var_00 + "_kills_melee",var_02.var_10E53["kills_melee"]);
		setdvar("stats_" + var_00 + "_kills_juggernaut",var_02.var_10E53["kills_juggernaut"]);
		setdvar("stats_" + var_00 + "_kills_explosives",var_02.var_10E53["kills_explosives"]);
		setdvar("stats_" + var_00 + "_kills_vehicle",var_02.var_10E53["kills_vehicle"]);
		setdvar("stats_" + var_00 + "_kills_sentry",var_02.var_10E53["kills_sentry"]);
		var_03 = var_02 func_7867(5);
		foreach(var_05 in var_03)
		{
			var_05.accuracy = 0;
			if(var_05.var_FF04 > 0)
			{
				var_05.accuracy = int(var_05.var_FF06 / var_05.var_FF04 * 100);
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
			setdvar("stats_" + var_00 + "_weapon" + var_07 + 1 + "_kills",var_03[var_07].var_1AB);
			setdvar("stats_" + var_00 + "_weapon" + var_07 + 1 + "_shots",var_03[var_07].var_FF04);
			setdvar("stats_" + var_00 + "_weapon" + var_07 + 1 + "_accuracy",var_03[var_07].accuracy + "%");
		}

		var_00++;
	}
}

//Function Number: 10
func_7867(param_00)
{
	var_01 = [];
	for(var_02 = 0;var_02 < param_00;var_02++)
	{
		var_01[var_02] = func_7D73(var_01);
	}

	return var_01;
}

//Function Number: 11
func_7D73(param_00)
{
	if(!isdefined(param_00))
	{
		param_00 = [];
	}

	var_01 = undefined;
	foreach(var_03 in self.var_10E53["weapon"])
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

		if(var_03.var_1AB > var_01.var_1AB)
		{
			var_01 = var_03;
		}
	}

	return var_01;
}