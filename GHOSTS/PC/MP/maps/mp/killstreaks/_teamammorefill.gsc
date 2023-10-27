/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\killstreaks\_teamammorefill.gsc
 * Game: Call of Duty: Ghosts
 * Platform: PC
 * Function Count: 4
 * Decompile Time: 91 ms
 * Timestamp: 10/27/2023 1:21:44 AM
*******************************************************************/

//Function Number: 1
func_44DF()
{
	level.killstreakfuncs["team_ammo_refill"] = ::func_8458;
}

//Function Number: 2
func_8458(param_00)
{
	var_01 = func_3D11();
	if(var_01)
	{
		maps\mp\_matchdata::func_4F1D("team_ammo_refill",self.origin);
	}

	return var_01;
}

//Function Number: 3
func_3D11()
{
	if(level.teambased)
	{
		foreach(var_01 in level.players)
		{
			if(var_01.team == self.team)
			{
				var_01 func_6429(1);
			}
		}
	}
	else
	{
		func_6429(1);
	}

	level thread maps\mp\_utility::func_7FA0("used_team_ammo_refill",self);
	return 1;
}

//Function Number: 4
func_6429(param_00)
{
	var_01 = self getweaponslistall();
	if(param_00)
	{
		if(maps\mp\_utility::_hasperk("specialty_tacticalinsertion") && self getammocount("flare_mp") < 1)
		{
			maps\mp\_utility::func_3CFD("specialty_tacticalinsertion",0);
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