/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\killstreaks\_teamammorefill.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: Console
 * Function Count: 4
 * Decompile Time: 82 ms
 * Timestamp: 10/27/2023 2:27:23 AM
*******************************************************************/

//Function Number: 1
init()
{
	level.killstreakfuncs["team_ammo_refill"] = ::func_3449;
}

//Function Number: 2
func_3449(param_00)
{
	var_01 = func_344A();
	if(var_01)
	{
		maps\mp\_matchdata::logkillstreakevent("team_ammo_refill",self.origin);
	}

	return var_01;
}

//Function Number: 3
func_344A()
{
	if(level.teambased)
	{
		foreach(var_01 in level.players)
		{
			if(var_01.team == self.team)
			{
				var_01 func_2E9E(1);
			}
		}
	}
	else
	{
		func_2E9E(1);
	}

	level thread maps\mp\_utility::teamplayercardsplash("used_team_ammo_refill",self);
	return 1;
}

//Function Number: 4
func_2E9E(param_00)
{
	var_01 = self getweaponslistall();
	if(param_00)
	{
		if(maps\mp\_utility::func_27AF("specialty_tacticalinsertion") && self getammocount("flare_mp") < 1)
		{
			maps\mp\_utility::giveperk("specialty_tacticalinsertion",0);
		}

		if(maps\mp\_utility::func_27AF("specialty_scrambler") && self getammocount("scrambler_mp") < 1)
		{
			maps\mp\_utility::giveperk("specialty_scrambler",0);
		}

		if(maps\mp\_utility::func_27AF("specialty_portable_radar") && self getammocount("portable_radar_mp") < 1)
		{
			maps\mp\_utility::giveperk("specialty_portable_radar",0);
		}
	}

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