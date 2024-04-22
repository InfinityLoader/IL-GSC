/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: mp\killstreaks\_teamammorefill.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 4
 * Decompile Time: 80 ms
 * Timestamp: 4/22/2024 2:12:19 AM
*******************************************************************/

//Function Number: 1
init()
{
	level.killstreakfuncs["team_ammo_refill"] = ::tryuseteamammorefill;
}

//Function Number: 2
tryuseteamammorefill(param_00,param_01)
{
	var_02 = giveteamammorefill();
	if(var_02)
	{
		maps\mp\_matchdata::logkillstreakevent("team_ammo_refill",self.origin);
	}

	return var_02;
}

//Function Number: 3
giveteamammorefill()
{
	if(level.teambased)
	{
		foreach(var_01 in level.players)
		{
			if(var_01.team == self.team)
			{
				var_01 refillammo(1);
			}
		}
	}
	else
	{
		refillammo(1);
	}

	level thread maps\mp\_utility::teamplayercardsplash("used_team_ammo_refill",self);
	return 1;
}

//Function Number: 4
refillammo(param_00)
{
	var_01 = self getweaponslistall();
	foreach(var_03 in var_01)
	{
		if(issubstr(var_03,"grenade") || getsubstr(var_03,0,2) == "gl")
		{
			if(!param_00 || self getammocount(var_03) >= 1)
			{
				continue;
			}
		}

		self givemaxammo(var_03);
	}

	self playlocalsound("ammo_crate_use");
}