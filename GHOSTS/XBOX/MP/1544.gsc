/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 1544.gsc
 * Game: Call of Duty: Ghosts
 * Platform: Console
 * Function Count: 8
 * Decompile Time: 0 ms
 * Timestamp: 10/27/2023 1:32:44 AM
*******************************************************************/

//Function Number: 1
func_44DF()
{
	level.killstreakfuncs["high_value_target"] = ::func_843C;
	level.hvts_active["axis"] = 0;
	level.hvts_active["allies"] = 0;
	game["dialog"]["hvt_gone"] = "hvt_gone";
}

//Function Number: 2
func_843C(param_00,param_01)
{
	return func_87BD(self,param_00);
}

//Function Number: 3
func_63A6()
{
	if(level.teambased)
	{
		return level.hvts_active[self.team] >= 4;
	}
	else if(isdefined(self.hvts_active))
	{
		return self.hvts_active >= 2;
	}

	return 0;
}

//Function Number: 4
func_87BD(param_00,param_01)
{
	if(!maps\mp\_utility::func_4945(param_00))
	{
		return 0;
	}

	if(param_00.team == "spectator")
	{
		return 0;
	}

	if(func_63A6() || isdefined(param_00.hvts_active) && param_00.hvts_active >= 2)
	{
		self iprintlnbold(&"KILLSTREAKS_HVT_MAX");
		return 0;
	}

	param_00 thread func_704E();
	level thread maps\mp\_utility::func_7FA0("used_hvt",param_00,param_00.team);
	return 1;
}

//Function Number: 5
func_704E()
{
	level endon("game_ended");
	self endon("disconnect");
	var_00 = self.team;
	func_4482();
	thread func_8CFA(var_00);
	maps\mp\gametypes\_hostmigration::func_8B0D(10);
	if(level.teambased)
	{
		maps\mp\_utility::func_4D30("hvt_gone",var_00);
	}
	else
	{
		maps\mp\_utility::func_4D35("hvt_gone");
	}

	if(level.teambased)
	{
		level decreasexpboost(var_00);
	}

	decreasexpboost();
}

//Function Number: 6
func_4482()
{
	var_00 = 0;
	if(level.teambased)
	{
		level.hvts_active[self.team]++;
		var_00 = level.hvts_active[self.team];
		var_01 = self.team;
	}
	else
	{
		if(!isdefined(self.hvts_active))
		{
			self.hvts_active = 1;
		}
		else
		{
			self.hvts_active++;
		}

		var_01 = self.hvts_active;
		var_01 = self getentitynumber();
	}

	var_02 = 1 + var_00 * 0.5;
	level.teamxpscale[var_01] = clamp(var_02,1,4);
}

//Function Number: 7
decreasexpboost(param_00)
{
	var_01 = 0;
	if(level.teambased)
	{
		if(level.hvts_active[param_00] > 0)
		{
			level.hvts_active[param_00]--;
		}

		var_01 = level.hvts_active[param_00];
		var_02 = param_00;
	}
	else
	{
		if(self.hvts_active > 0)
		{
			self.hvts_active--;
		}

		var_02 = self.hvts_active;
		var_02 = self getentitynumber();
	}

	var_03 = 1 + var_01 * 0.5;
	level.teamxpscale[var_02] = clamp(var_03,1,4);
}

//Function Number: 8
func_8CFA(param_00)
{
	level endon("game_ended");
	var_01 = common_scripts\utility::func_8B33("disconnect","joined_team","joined_spectators");
	if(level.teambased)
	{
		level decreasexpboost(param_00);
	}

	if(isdefined(self) && var_01 != "disconnect")
	{
		decreasexpboost();
	}
}