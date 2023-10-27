/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\mp\killstreaks\_teamammorefill.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 4
 * Decompile Time: 209 ms
 * Timestamp: 10/27/2023 12:29:46 AM
*******************************************************************/

//Function Number: 1
init()
{
	scripts\mp\killstreaks\_killstreaks::func_DEFB("team_ammo_refill",::func_12908);
}

//Function Number: 2
func_12908(param_00)
{
	var_01 = func_83AD();
	if(var_01)
	{
		scripts\mp\_matchdata::func_AFC9("team_ammo_refill",self.origin);
	}

	return var_01;
}

//Function Number: 3
func_83AD()
{
	if(level.teambased)
	{
		foreach(var_01 in level.players)
		{
			if(var_01.team == self.team)
			{
				var_01 func_DE4B(1);
			}
		}
	}
	else
	{
		func_DE4B(1);
	}

	level thread scripts\mp\_utility::func_115DE("used_team_ammo_refill",self);
	return 1;
}

//Function Number: 4
func_DE4B(param_00)
{
	var_01 = self getweaponslistall();
	if(param_00)
	{
	}

	foreach(var_03 in var_01)
	{
		if(issubstr(var_03,"grenade") || getsubstr(var_03,0,2) == "gl")
		{
			if(!param_00 || self method_80FB(var_03) >= 1)
			{
				continue;
			}
		}

		self givemaxammo(var_03);
	}

	self playlocalsound("ammo_crate_use");
}