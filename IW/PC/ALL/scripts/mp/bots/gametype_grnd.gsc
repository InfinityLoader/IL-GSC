/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\mp\bots\gametype_grnd.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 7
 * Decompile Time: 414 ms
 * Timestamp: 10/27/2023 12:11:59 AM
*******************************************************************/

//Function Number: 1
main()
{
	func_F8F4();
	func_F8DC();
}

//Function Number: 2
func_F8F4()
{
	level.var_2D9E["gametype_think"] = ::func_2DC0;
}

//Function Number: 3
func_F8DC()
{
	scripts\mp\bots\_bots_util::func_2ECA(1);
	level.var_DAA3 = 128;
	level.var_2DA1 = 1;
}

//Function Number: 4
func_2DC0()
{
	self notify("bot_grnd_think");
	self endon("bot_grnd_think");
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	self botclearscriptgoal();
	while(!isdefined(level.var_2DA1))
	{
		wait(0.05);
	}

	self botsetflag("separation",0);
	thread func_4143();
	for(;;)
	{
		wait(0.05);
		if(scripts\mp\bots\_bots_strategy::func_2DC5())
		{
			continue;
		}

		if(!self bothasscriptgoal())
		{
			var_00 = func_7FFA();
			if(isdefined(var_00))
			{
				self botsetscriptgoal(var_00.origin,0,"objective");
			}

			continue;
		}

		if(!scripts\mp\bots\_bots_util::func_2DD7())
		{
			self botclearscriptgoal();
			var_00 = func_7FFA();
			if(isdefined(var_00))
			{
				scripts\mp\bots\_bots_strategy::func_2E57(var_00.origin,level.var_DAA3);
			}
		}
	}
}

//Function Number: 5
func_4143()
{
	for(;;)
	{
		level waittill("zone_reset");
		if(scripts\mp\bots\_bots_util::func_2DD7())
		{
			scripts\mp\bots\_bots_strategy::func_2D4E();
		}
	}
}

//Function Number: 6
func_7FFA()
{
	var_00 = function_00B7(level.var_13FB0.var_767B.trigger);
	if(var_00.size == 0 || !isdefined(var_00))
	{
		return undefined;
	}

	var_01 = randomintrange(0,var_00.size);
	var_02 = var_00[var_01];
	return var_02;
}

//Function Number: 7
func_1166D()
{
}