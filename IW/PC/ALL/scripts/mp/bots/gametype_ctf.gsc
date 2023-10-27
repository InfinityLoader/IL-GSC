/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\mp\bots\gametype_ctf.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 11
 * Decompile Time: 608 ms
 * Timestamp: 10/27/2023 12:11:53 AM
*******************************************************************/

//Function Number: 1
main()
{
	func_F8F4();
	func_F8D9();
}

//Function Number: 2
func_F8F4()
{
	level.var_2D9E["crate_can_use"] = ::func_4830;
	level.var_2D9E["gametype_think"] = ::func_2D46;
}

//Function Number: 3
func_F8D9()
{
	scripts\mp\bots\_bots_util::func_2ECA();
	level.var_115CC["allies"].label = "allies";
	level.var_115CC["axis"].label = "axis";
	var_00[0] = level.var_115CC["allies"].var_4B2C;
	var_01[0] = "flag_" + level.var_115CC["allies"].label;
	var_00[1] = level.var_115CC["axis"].var_4B2C;
	var_01[1] = "flag_" + level.var_115CC["axis"].label;
	scripts\mp\bots\_bots_util::func_2D18(var_00,var_01);
	var_02 = getzonenearest(level.var_115CC["allies"].var_4B2C);
	if(isdefined(var_02))
	{
		function_002B(var_02,"allies");
	}

	var_02 = getzonenearest(level.var_115CC["axis"].var_4B2C);
	if(isdefined(var_02))
	{
		function_002B(var_02,"axis");
	}

	level.var_2DA1 = 1;
}

//Function Number: 4
func_4830(param_00)
{
	if(isagent(self) && !isdefined(param_00.var_2F33))
	{
		return 0;
	}

	if(isdefined(self.var_3AF4))
	{
		return 0;
	}

	if(!level.var_115CC[self.team] scripts\mp\_gameobjects::func_9E35())
	{
		return 0;
	}

	return 1;
}

//Function Number: 5
func_46BE()
{
	var_00 = 0;
	foreach(var_02 in level.var_C928)
	{
		if(!isdefined(var_02.team))
		{
			continue;
		}

		if(var_02 == self)
		{
			continue;
		}

		if(scripts\mp\_utility::func_9F9D(var_02) && var_02.team == self.team)
		{
			var_00++;
		}
	}

	return var_00;
}

//Function Number: 6
func_2D46()
{
	self notify("bot_ctf_think");
	self endon("bot_ctf_think");
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	while(!isdefined(level.var_2DA1))
	{
		wait(0.05);
	}

	func_9557();
	self.var_BF69 = gettime();
	self.var_BF3E = gettime();
	self botsetflag("separation",0);
	if(!isdefined(level.var_BF3F))
	{
		level.var_BF3F = gettime() - 100;
	}

	for(;;)
	{
		wait(0.05);
		if(gettime() >= level.var_BF3F)
		{
			func_12DC1();
			level.var_BF3F = gettime() + 100;
		}

		if(self.health <= 0)
		{
			continue;
		}

		if(!isdefined(self.var_E67C))
		{
			func_F319();
		}

		if(isdefined(self.var_3AF4))
		{
			func_4143();
			if(!isdefined(level.var_6E28[level.var_C74B[self.team]]) || scripts\common\utility::istrue(level.var_3A3C))
			{
				self botsetscriptgoal(level.var_3A42[self.team].var_4B2C,16,"critical");
			}
			else if(isdefined(level.var_6E28[level.var_C74B[self.team]]) && func_46BE() == 0)
			{
				self botclearscriptgoal();
				self botsetscriptgoal(level.var_6E28[level.var_C74B[self.team]].origin,256,"guard");
			}
			else if(gettime() > self.var_BF3E)
			{
				var_00 = getnodesinradius(level.var_3A42[self.team].var_4B2C,900,0,300);
				var_01 = self botnodepick(var_00,var_00.size * 0.15,"node_hide");
				if(isdefined(var_01))
				{
					self botsetscriptgoalnode(var_01,"critical");
				}

				self.var_BF3E = gettime() + 10000;
			}

			continue;
		}

		if(self.var_E67C == "attacker")
		{
			if(isdefined(level.var_6E28[self.team]))
			{
				if(!scripts\mp\bots\_bots_util::func_2DD4())
				{
					scripts\mp\bots\_bots_strategy::func_2DC1(level.var_6E28[self.team],400);
				}
			}
			else
			{
				func_4143();
				self botsetscriptgoal(level.var_115CC[level.var_C74B[self.team]].var_4B2C,16,"guard");
			}

			continue;
		}

		if(!level.var_115CC[self.team] scripts\mp\_gameobjects::func_9E35())
		{
			if(!isdefined(level.var_6E28[level.var_C74B[self.team]]))
			{
				func_4143();
				self botsetscriptgoal(level.var_115CC[self.team].var_4B2C,16,"critical");
			}
			else
			{
				var_02 = level.var_6E28[level.var_C74B[self.team]];
				if(gettime() > self.var_BF69 || self botcanseeentity(var_02))
				{
					func_4143();
					self botsetscriptgoal(var_02.origin,16,"critical");
					self.var_BF69 = gettime() + randomintrange(4500,5500);
				}
			}

			continue;
		}

		if(!func_9C95())
		{
			self botclearscriptgoal();
			var_03["entrance_points_index"] = "flag_" + level.var_115CC[self.team].label;
			scripts\mp\bots\_bots_strategy::func_2E57(level.var_115CC[self.team].var_4B2C,600,var_03);
		}
	}
}

//Function Number: 7
func_4143()
{
	if(scripts\mp\bots\_bots_util::func_2DD7())
	{
		scripts\mp\bots\_bots_strategy::func_2D4E();
	}
}

//Function Number: 8
func_9C95()
{
	return scripts\mp\bots\_bots_util::func_2DDD();
}

//Function Number: 9
func_F319()
{
	self.var_E67C = level.var_BF57[self.team];
	if(level.var_BF57[self.team] == "attacker")
	{
		level.var_BF57[self.team] = "defender";
		return;
	}

	if(level.var_BF57[self.team] == "defender")
	{
		level.var_BF57[self.team] = "attacker";
	}
}

//Function Number: 10
func_9557()
{
	if(isdefined(level.var_2EF4) && level.var_2EF4)
	{
		return;
	}

	level.var_2EF4 = 1;
	level.var_BF57["allies"] = "attacker";
	level.var_BF57["axis"] = "attacker";
	level.var_6E28 = [];
}

//Function Number: 11
func_12DC1()
{
	level.var_6E28["allies"] = undefined;
	level.var_6E28["axis"] = undefined;
	foreach(var_01 in level.var_C928)
	{
		if(isalive(var_01) && isdefined(var_01.var_3AF4))
		{
			level.var_6E28[var_01.team] = var_01;
		}
	}

	var_03 = [];
	var_04 = [];
	var_05 = [];
	var_06 = [];
	foreach(var_01 in level.var_C928)
	{
		if(isdefined(var_01.var_E67C))
		{
			if(var_01.team == "allies")
			{
				if(var_01.var_E67C == "attacker")
				{
					var_03[var_03.size] = var_01;
				}
				else if(var_01.var_E67C == "defender")
				{
					var_04[var_04.size] = var_01;
				}

				continue;
			}

			if(var_01.team == "axis")
			{
				if(var_01.var_E67C == "attacker")
				{
					var_05[var_05.size] = var_01;
					continue;
				}

				if(var_01.var_E67C == "defender")
				{
					var_06[var_06.size] = var_01;
				}
			}
		}
	}

	if(var_04.size > var_03.size)
	{
		scripts\common\utility::random(var_04).var_E67C = undefined;
	}
	else if(var_03.size > var_04.size + 1)
	{
		scripts\common\utility::random(var_03).var_E67C = undefined;
	}

	if(var_06.size > var_05.size)
	{
		scripts\common\utility::random(var_06).var_E67C = undefined;
		return;
	}

	if(var_05.size > var_06.size + 1)
	{
		scripts\common\utility::random(var_05).var_E67C = undefined;
	}
}