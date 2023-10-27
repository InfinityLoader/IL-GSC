/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\mp\killstreaks\_highvaluetarget.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 8
 * Decompile Time: 386 ms
 * Timestamp: 10/27/2023 12:28:47 AM
*******************************************************************/

//Function Number: 1
init()
{
	scripts\mp\killstreaks\_killstreaks::func_DEFB("high_value_target",::func_128E9);
	level.var_9264["axis"] = 0;
	level.var_9264["allies"] = 0;
	game["dialog"]["hvt_gone"] = "hvt_gone";
}

//Function Number: 2
func_128E9(param_00,param_01)
{
	return func_13091(self,param_00);
}

//Function Number: 3
func_DD18()
{
	if(level.teambased)
	{
		return level.var_9264[self.team] >= 4;
	}
	else if(isdefined(self.var_9264))
	{
		return self.var_9264 >= 2;
	}

	return 0;
}

//Function Number: 4
func_13091(param_00,param_01)
{
	if(!scripts\mp\_utility::func_9F19(param_00))
	{
		return 0;
	}

	if(param_00.team == "spectator")
	{
		return 0;
	}

	if(func_DD18() || isdefined(param_00.var_9264) && param_00.var_9264 >= 2)
	{
		self iprintlnbold(&"KILLSTREAKS_HVT_MAX");
		return 0;
	}

	param_00 thread func_F745();
	level thread scripts\mp\_utility::func_115DE("used_hvt",param_00,param_00.team);
	return 1;
}

//Function Number: 5
func_F745()
{
	level endon("game_ended");
	self endon("disconnect");
	var_00 = self.team;
	func_93F0();
	thread func_13AA6(var_00);
	scripts\mp\_hostmigration::func_13708(10);
	if(level.teambased)
	{
		scripts\mp\_utility::func_AAE7("hvt_gone",var_00);
	}
	else
	{
		scripts\mp\_utility::func_AAEC("hvt_gone");
	}

	if(level.teambased)
	{
		level func_4FBA(var_00);
		return;
	}

	func_4FBA();
}

//Function Number: 6
func_93F0()
{
	var_00 = 0;
	if(level.teambased)
	{
		level.var_9264[self.team]++;
		var_00 = level.var_9264[self.team];
		var_01 = self.team;
	}
	else
	{
		if(!isdefined(self.var_9264))
		{
			self.var_9264 = 1;
		}
		else
		{
			self.var_9264++;
		}

		var_01 = self.var_9264;
		var_01 = self getentitynumber();
	}

	var_02 = 1 + var_00 * 0.5;
	level.var_115F3[var_01] = clamp(var_02,1,4);
}

//Function Number: 7
func_4FBA(param_00)
{
	var_01 = 0;
	if(level.teambased)
	{
		if(level.var_9264[param_00] > 0)
		{
			level.var_9264[param_00]--;
		}

		var_01 = level.var_9264[param_00];
		var_02 = param_00;
	}
	else
	{
		if(self.var_9264 > 0)
		{
			self.var_9264--;
		}

		var_02 = self.var_9264;
		var_02 = self getentitynumber();
	}

	var_03 = 1 + var_01 * 0.5;
	level.var_115F3[var_02] = clamp(var_03,1,4);
}

//Function Number: 8
func_13AA6(param_00)
{
	level endon("game_ended");
	var_01 = scripts\common\utility::func_13734("disconnect","joined_team","joined_spectators");
	if(level.teambased)
	{
		level func_4FBA(param_00);
		return;
	}

	if(isdefined(self) && var_01 != "disconnect")
	{
		func_4FBA();
	}
}