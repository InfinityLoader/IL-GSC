/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\bots\_bots_gametype_siege.gsc
 * Game: Call of Duty: Ghosts
 * Platform: PC
 * Function Count: 6
 * Decompile Time: 141 ms
 * Timestamp: 10/27/2023 1:17:23 AM
*******************************************************************/

//Function Number: 1
func_4FDD()
{
	func_710C();
	thread bot_siege_manager_think();
	setup_bot_siege();
}

//Function Number: 2
func_710C()
{
	level.bot_funcs["gametype_think"] = ::bot_siege_think;
}

//Function Number: 3
setup_bot_siege()
{
	level.bot_gametype_precaching_done = 1;
}

//Function Number: 4
bot_siege_manager_think()
{
	level.siege_bot_team_need_flags = [];
	maps\mp\_utility::gameflagwait("prematch_done");
	for(;;)
	{
		level.siege_bot_team_need_flags = [];
		foreach(var_01 in level.players)
		{
			if(!maps\mp\_utility::func_4945(var_01) && var_01.hasspawned)
			{
				if(var_01.team != "spectator" && var_01.team != "neutral")
				{
					level.siege_bot_team_need_flags[var_01.team] = 1;
				}
			}
		}

		var_03 = [];
		foreach(var_05 in level.flags)
		{
			var_06 = var_05.useobj maps\mp\gametypes\_gameobjects::func_3B78();
			if(var_06 != "neutral")
			{
				if(!isdefined(var_03[var_06]))
				{
					var_03[var_06] = 1;
					continue;
				}

				var_03[var_06]++;
			}
		}

		foreach(var_06, var_09 in var_03)
		{
			if(var_09 >= 2)
			{
				var_0A = maps\mp\_utility::getotherteam(var_06);
				level.siege_bot_team_need_flags[var_0A] = 1;
			}
		}

		wait(1);
	}
}

//Function Number: 5
bot_siege_think()
{
	self notify("bot_siege_think");
	self endon("bot_siege_think");
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	while(!isdefined(level.bot_gametype_precaching_done))
	{
		wait(0.05);
	}

	while(!isdefined(level.siege_bot_team_need_flags))
	{
		wait(0.05);
	}

	self botsetflag("separation",0);
	self botsetflag("use_obj_path_style",1);
	for(;;)
	{
		if(isdefined(level.siege_bot_team_need_flags[self.team]) && level.siege_bot_team_need_flags[self.team])
		{
			func_8FDB();
		}
		else if(isdefined(self.goalflag))
		{
			if(maps/mp/bots/_bots_util::bot_is_defending())
			{
				maps/mp/bots/_bots_strategy::bot_defend_stop();
			}

			self.goalflag = undefined;
		}

		wait(1);
	}
}

//Function Number: 6
func_8FDB()
{
	var_00 = undefined;
	var_01 = undefined;
	foreach(var_03 in level.flags)
	{
		var_04 = var_03.useobj maps\mp\gametypes\_gameobjects::func_3B78();
		if(var_04 != self.team)
		{
			var_05 = distancesquared(self.origin,var_03.origin);
			if(!isdefined(var_01) || var_05 < var_01)
			{
				var_01 = var_05;
				var_00 = var_03;
			}
		}
	}

	if(isdefined(var_00))
	{
		if(!isdefined(self.goalflag) || self.goalflag != var_00)
		{
			self.goalflag = var_00;
			maps/mp/bots/_bots_strategy::func_158C(var_00.origin,100);
		}
	}
}