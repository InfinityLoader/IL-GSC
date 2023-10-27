/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\mp\bots\gametype_siege.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 6
 * Decompile Time: 327 ms
 * Timestamp: 10/27/2023 12:12:07 AM
*******************************************************************/

//Function Number: 1
main()
{
	func_F8F4();
	thread func_2E97();
	func_F8E0();
}

//Function Number: 2
func_F8F4()
{
	level.var_2D9E["gametype_think"] = ::func_2E98;
}

//Function Number: 3
func_F8E0()
{
	level.var_2DA1 = 1;
}

//Function Number: 4
func_2E97()
{
	level.var_101C3 = [];
	scripts\mp\_utility::func_7670("prematch_done");
	for(;;)
	{
		level.var_101C3 = [];
		foreach(var_01 in level.players)
		{
			if(!scripts\mp\_utility::func_9F19(var_01) && var_01.var_8C2A)
			{
				if(var_01.team != "spectator" && var_01.team != "neutral")
				{
					level.var_101C3[var_01.team] = 1;
				}
			}
		}

		var_03 = [];
		foreach(var_05 in level.var_134)
		{
			var_06 = var_05.var_130AC scripts\mp\_gameobjects::func_803E();
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
				var_0A = scripts\mp\_utility::getotherteam(var_06);
				level.var_101C3[var_0A] = 1;
			}
		}

		wait(1);
	}
}

//Function Number: 5
func_2E98()
{
	self notify("bot_siege_think");
	self endon("bot_siege_think");
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	while(!isdefined(level.var_2DA1))
	{
		wait(0.05);
	}

	while(!isdefined(level.var_101C3))
	{
		wait(0.05);
	}

	self botsetflag("separation",0);
	self botsetflag("use_obj_path_style",1);
	for(;;)
	{
		if(isdefined(level.var_101C3[self.team]) && level.var_101C3[self.team])
		{
			func_2D31();
		}
		else if(isdefined(self.var_8434))
		{
			if(scripts\mp\bots\_bots_util::func_2DD7())
			{
				scripts\mp\bots\_bots_strategy::func_2D4E();
			}

			self.var_8434 = undefined;
		}

		wait(1);
	}
}

//Function Number: 6
func_2D31()
{
	var_00 = undefined;
	var_01 = undefined;
	foreach(var_03 in level.var_134)
	{
		var_04 = var_03.var_130AC scripts\mp\_gameobjects::func_803E();
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
		if(!isdefined(self.var_8434) || self.var_8434 != var_00)
		{
			self.var_8434 = var_00;
			scripts\mp\bots\_bots_strategy::func_2D2B(var_00.origin,100);
		}
	}
}