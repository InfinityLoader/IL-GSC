/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\bots\_bots_gametype_blitz.gsc
 * Game: Call of Duty: Ghosts
 * Platform: Console
 * Function Count: 13
 * Decompile Time: 243 ms
 * Timestamp: 10/27/2023 1:28:22 AM
*******************************************************************/

//Function Number: 1
func_4FDD()
{
	func_710C();
	func_9459();
}

//Function Number: 2
func_710C()
{
	level.bot_funcs["gametype_think"] = ::func_8FD4;
}

//Function Number: 3
func_9459()
{
	maps/mp/bots/_bots_util::func_16C4(1);
	level.protect_radius = 600;
	thread func_8FD3();
	level.bot_gametype_precaching_done = 1;
}

//Function Number: 4
func_8FD4()
{
	self notify("bot_blitz_think");
	self endon("bot_blitz_think");
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	while(!isdefined(level.bot_gametype_precaching_done))
	{
		wait(0.05);
	}

	self botsetflag("separation",0);
	for(;;)
	{
		wait(0.05);
		if(!isdefined(self.role))
		{
			initialize_blitz_role();
		}

		if(maps/mp/bots/_bots_strategy::bot_has_tactical_goal())
		{
			continue;
		}

		if(self.role == "attacker")
		{
			var_00 = level.portallist[common_scripts\utility::func_386F(self.team)];
			if(var_00.open)
			{
				if(maps/mp/bots/_bots_util::bot_is_defending())
				{
					maps/mp/bots/_bots_strategy::bot_defend_stop();
				}

				if(!self bothasscriptgoal())
				{
					self botsetscriptgoal(var_00.origin,0,"objective");
				}
			}
			else if(!maps/mp/bots/_bots_util::bot_is_defending())
			{
				self botclearscriptgoal();
				maps/mp/bots/_bots_strategy::bot_protect_point(var_00.origin,level.protect_radius);
			}

			continue;
		}

		if(self.role == "defender")
		{
			var_00 = level.portallist[self.team];
			if(!maps/mp/bots/_bots_util::bot_is_defending_point(var_00.origin))
			{
				var_01["min_goal_time"] = 20;
				var_01["max_goal_time"] = 30;
				var_01["score_flags"] = "strict_los";
				maps/mp/bots/_bots_strategy::bot_protect_point(var_00.origin,level.protect_radius,var_01);
			}
		}
	}
}

//Function Number: 5
initialize_blitz_role()
{
	var_00 = func_9187(self.team);
	var_01 = func_9188(self.team);
	var_02 = func_8FB1(self.team);
	var_03 = func_8FB2(self.team);
	var_04 = level.bot_personality_type[self.personality];
	if(var_04 == "active")
	{
		if(var_00.size >= var_02)
		{
			var_05 = 0;
			foreach(var_07 in var_00)
			{
				if(isai(var_07) && level.bot_personality_type[var_07.personality] == "stationary")
				{
					var_07.role = undefined;
					var_05 = 1;
					break;
				}
			}

			if(var_05)
			{
				func_8FB4("attacker");
			}

			func_8FB4("defender");
		}

		func_8FB4("attacker");
	}

	if(var_04 == "stationary")
	{
		if(var_01.size >= var_03)
		{
			var_05 = 0;
			foreach(var_0A in var_01)
			{
				if(isai(var_0A) && level.bot_personality_type[var_0A.personality] == "active")
				{
					var_0A.role = undefined;
					var_05 = 1;
					break;
				}
			}

			if(var_05)
			{
				func_8FB4("defender");
			}

			func_8FB4("attacker");
		}

		func_8FB4("defender");
	}
}

//Function Number: 6
func_8FD3()
{
	level notify("bot_blitz_ai_director_update");
	level endon("bot_blitz_ai_director_update");
	level endon("game_ended");
	var_00[0] = "allies";
	var_00[1] = "axis";
	for(;;)
	{
		foreach(var_02 in var_00)
		{
			var_03 = func_8FB1(var_02);
			var_04 = func_8FB2(var_02);
			var_05 = func_9187(var_02);
			var_06 = func_9188(var_02);
			if(var_05.size > var_03)
			{
				var_07 = [];
				var_08 = 0;
				foreach(var_0A in var_05)
				{
					if(isai(var_0A))
					{
						if(level.bot_personality_type[var_0A.personality] == "stationary")
						{
							var_0A func_8FB4("defender");
							var_08 = 1;
							break;
						}
						else
						{
							var_07 = common_scripts\utility::array_add(var_07,var_0A);
						}
					}
				}

				if(!var_08 && var_07.size > 0)
				{
					common_scripts\utility::func_6306(var_07) func_8FB4("defender");
				}
			}

			if(var_06.size > var_04)
			{
				var_0C = [];
				var_0D = 0;
				foreach(var_0F in var_06)
				{
					if(isai(var_0F))
					{
						if(level.bot_personality_type[var_0F.personality] == "active")
						{
							var_0F func_8FB4("attacker");
							var_0D = 1;
							break;
						}
						else
						{
							var_0C = common_scripts\utility::array_add(var_0C,var_0F);
						}
					}
				}

				if(!var_0D && var_0C.size > 0)
				{
					common_scripts\utility::func_6306(var_0C) func_8FB4("attacker");
				}
			}
		}

		wait(1);
	}
}

//Function Number: 7
func_8FB1(param_00)
{
	var_01 = func_8FB3(param_00);
	return castint(castint(var_01) / 2) + 1 + castint(var_01) % 2;
}

//Function Number: 8
func_8FB2(param_00)
{
	var_01 = func_8FB3(param_00);
	return max(castint(castint(var_01) / 2) - 1,0);
}

//Function Number: 9
func_8FB3(param_00)
{
	var_01 = 0;
	foreach(var_03 in level.participants)
	{
		if(maps\mp\_utility::func_4984(var_03) && isdefined(var_03.team) && var_03.team == param_00)
		{
			var_01++;
		}
	}

	return var_01;
}

//Function Number: 10
func_9187(param_00)
{
	var_01 = func_91C0("attacker",param_00);
	foreach(var_03 in level.players)
	{
		if(!isai(var_03) && isdefined(var_03.team) && var_03.team == param_00)
		{
			if(distancesquared(level.portallist[param_00].origin,var_03.origin) > level.protect_radius * level.protect_radius)
			{
				var_01 = common_scripts\utility::array_add(var_01,var_03);
			}
		}
	}

	return var_01;
}

//Function Number: 11
func_9188(param_00)
{
	var_01 = func_91C0("defender",param_00);
	foreach(var_03 in level.players)
	{
		if(!isai(var_03) && isdefined(var_03.team) && var_03.team == param_00)
		{
			if(distancesquared(level.portallist[param_00].origin,var_03.origin) <= level.protect_radius * level.protect_radius)
			{
				var_01 = common_scripts\utility::array_add(var_01,var_03);
			}
		}
	}

	return var_01;
}

//Function Number: 12
func_8FB4(param_00)
{
	self.role = param_00;
	self botclearscriptgoal();
	maps/mp/bots/_bots_strategy::bot_defend_stop();
}

//Function Number: 13
func_91C0(param_00,param_01)
{
	var_02 = [];
	foreach(var_04 in level.participants)
	{
		if(!isdefined(var_04.team))
		{
			continue;
		}

		if(isalive(var_04) && maps\mp\_utility::func_4984(var_04) && var_04.team == param_01 && isdefined(var_04.role) && var_04.role == param_00)
		{
			var_02[var_02.size] = var_04;
		}
	}

	return var_02;
}