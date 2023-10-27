/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\mp\bots\gametype_dom.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 45
 * Decompile Time: 2269 ms
 * Timestamp: 10/27/2023 12:11:57 AM
*******************************************************************/

//Function Number: 1
main()
{
	func_F8F4();
	func_F8DB();
	level thread scripts\mp\bots\_bots_util::func_2E21(::scripts\mp\bots\_bots_util::func_2EBF);
}

//Function Number: 2
func_F8F4()
{
	level.var_2D9E["crate_can_use"] = ::func_4830;
	level.var_2D9E["gametype_think"] = ::func_2D64;
	level.var_2D9E["should_start_cautious_approach"] = ::func_FF9B;
	level.var_2D9E["leader_dialog"] = ::func_2D62;
	level.var_2D9E["get_watch_node_chance"] = ::func_2D61;
	level.var_2D9E["commander_gametype_tactics"] = ::func_2D5E;
}

//Function Number: 3
func_2DD3(param_00)
{
	var_01 = 90000;
	if(scripts\mp\bots\_bots_util::func_2DD7() && distance2dsquared(param_00,self.var_2D52) < var_01)
	{
		return 1;
	}

	if(self bothasscriptgoal())
	{
		var_02 = self botgetscriptgoal();
		if(distance2dsquared(param_00,var_02) < var_01)
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 4
func_4832(param_00)
{
	if(isagent(self))
	{
		if(!isdefined(level.var_10356) || self.var_222 != level.var_10356)
		{
			return func_4830();
		}

		if(!isdefined(param_00.var_2F33) && scripts\mp\bots\_bots_util::func_2D44(param_00))
		{
			return func_2DD3(param_00.origin);
		}

		return 0;
	}

	return func_4830(param_00);
}

//Function Number: 5
func_4830(param_00)
{
	if(isagent(self) && !isdefined(param_00.var_2F33))
	{
		return 0;
	}

	if(isdefined(param_00.var_485F) && !scripts\mp\bots\_bots_killstreaks::func_2DDB(param_00.var_485F))
	{
		return 0;
	}

	if(!scripts\mp\_utility::func_9F9D(self))
	{
		return 1;
	}

	return scripts\mp\bots\_bots_util::func_2DDD();
}

//Function Number: 6
func_2D5E(param_00)
{
	var_01 = 0;
	switch(param_00)
	{
		case "tactic_none":
			level.var_2D63[self.team] = [];
			var_01 = 1;
			break;

		case "tactic_dom_holdA":
			level.var_2D63[self.team] = [];
			level.var_2D63[self.team][0] = func_7C92("A");
			var_01 = 1;
			break;

		case "tactic_dom_holdB":
			level.var_2D63[self.team] = [];
			level.var_2D63[self.team][0] = func_7C92("B");
			var_01 = 1;
			break;

		case "tactic_dom_holdC":
			level.var_2D63[self.team] = [];
			level.var_2D63[self.team][0] = func_7C92("C");
			var_01 = 1;
			break;

		case "tactic_dom_holdAB":
			level.var_2D63[self.team] = [];
			level.var_2D63[self.team][0] = func_7C92("A");
			level.var_2D63[self.team][1] = func_7C92("B");
			var_01 = 1;
			break;

		case "tactic_dom_holdBC":
			level.var_2D63[self.team] = [];
			level.var_2D63[self.team][0] = func_7C92("B");
			level.var_2D63[self.team][1] = func_7C92("C");
			var_01 = 1;
			break;

		case "tactic_dom_holdAC":
			level.var_2D63[self.team] = [];
			level.var_2D63[self.team][0] = func_7C92("A");
			level.var_2D63[self.team][1] = func_7C92("C");
			var_01 = 1;
			break;

		case "tactic_dom_holdABC":
			level.var_2D63[self.team] = [];
			level.var_2D63[self.team][0] = func_7C92("A");
			level.var_2D63[self.team][1] = func_7C92("B");
			level.var_2D63[self.team][2] = func_7C92("C");
			var_01 = 1;
			break;
	}

	if(var_01)
	{
		foreach(var_03 in level.var_C928)
		{
			if(!isdefined(var_03.team))
			{
				continue;
			}

			if(scripts\mp\_utility::func_9D36(var_03) && var_03.team == self.team)
			{
				var_03.var_727F = 1;
			}
		}
	}
}

//Function Number: 7
func_B9B0()
{
	self notify("monitor_zone_control");
	self endon("monitor_zone_control");
	self endon("death");
	level endon("game_ended");
	for(;;)
	{
		wait(1);
		var_00 = self.var_130AC scripts\mp\_gameobjects::func_803E();
		if(var_00 != "neutral")
		{
			var_01 = getzonenearest(self.origin);
			if(isdefined(var_01))
			{
				function_002B(var_01,var_00);
			}
		}
	}
}

//Function Number: 8
func_B970()
{
	self notify("monitor_flag_ownership");
	self endon("monitor_flag_ownership");
	self endon("death");
	level endon("game_ended");
	var_00 = self.var_130AC scripts\mp\_gameobjects::func_803E();
	for(;;)
	{
		var_01 = self.var_130AC scripts\mp\_gameobjects::func_803E();
		if(var_01 != var_00)
		{
			level notify("flag_changed_ownership");
		}

		var_00 = var_01;
		wait(0.05);
	}
}

//Function Number: 9
func_F8DB()
{
	var_00 = func_2DA2();
	if(var_00.size > 3)
	{
		while(!isdefined(level.var_1161F))
		{
			wait(0.05);
		}

		var_01 = [];
		foreach(var_03 in var_00)
		{
			if(!isdefined(var_01[var_03.var_11651]))
			{
				var_01[var_03.var_11651] = [];
			}

			var_01[var_03.var_11651] = scripts\common\utility::array_add(var_01[var_03.var_11651],var_03);
		}

		foreach(var_07, var_06 in var_01)
		{
			level.var_6652 = 0;
			func_2D1B(var_06);
			scripts\mp\bots\_bots_util::func_2D1A(var_06,var_07 + "_flag");
		}
	}
	else
	{
		scripts\mp\bots\_bots_util::func_2D1A(var_00,"flag");
		func_2D1B(var_00);
	}

	foreach(var_03 in var_00)
	{
		var_03 thread func_B9B0();
		var_03 thread func_B970();
		if(var_03.script_label != "_a" && var_03.script_label != "_b" && var_03.script_label != "_c")
		{
		}

		var_03.var_C053 = function_00B7(var_03);
		func_1711(var_03);
	}

	level.var_2D63 = [];
	level.var_2D63["axis"] = [];
	level.var_2D63["allies"] = [];
	level.var_2DA1 = 1;
}

//Function Number: 10
func_2DA2()
{
	if(isdefined(level.var_1BEA))
	{
		return level.var_1BEA;
	}

	return level.var_134;
}

//Function Number: 11
func_2D1B(param_00)
{
	if(!isdefined(level.var_6E32))
	{
		level.var_6E32 = [];
	}

	for(var_01 = 0;var_01 < param_00.size - 1;var_01++)
	{
		for(var_02 = var_01 + 1;var_02 < param_00.size;var_02++)
		{
			var_03 = distance(param_00[var_01].origin,param_00[var_02].origin);
			var_04 = func_79BB(param_00[var_01]);
			var_05 = func_79BB(param_00[var_02]);
			level.var_6E32[var_04][var_05] = var_03;
			level.var_6E32[var_05][var_04] = var_03;
		}
	}
}

//Function Number: 12
func_1711(param_00)
{
	if(param_00.classname == "trigger_radius")
	{
		var_01 = getnodesinradius(param_00.origin,param_00.var_257,0,100);
		var_02 = scripts\common\utility::func_22AC(var_01,param_00.var_C053);
		if(var_02.size > 0)
		{
			param_00.var_C053 = scripts\common\utility::array_combine(param_00.var_C053,var_02);
			return;
		}

		return;
	}

	if(param_00.classname == "trigger_multiple")
	{
		var_03[0] = param_00 method_8159(1,1,1);
		var_03[1] = param_00 method_8159(1,1,-1);
		var_03[2] = param_00 method_8159(1,-1,1);
		var_03[3] = param_00 method_8159(1,-1,-1);
		var_03[4] = param_00 method_8159(-1,1,1);
		var_03[5] = param_00 method_8159(-1,1,-1);
		var_03[6] = param_00 method_8159(-1,-1,1);
		var_03[7] = param_00 method_8159(-1,-1,-1);
		var_04 = 0;
		foreach(var_06 in var_03)
		{
			var_07 = distance(var_06,param_00.origin);
			if(var_07 > var_04)
			{
				var_04 = var_07;
			}
		}

		var_01 = getnodesinradius(param_00.origin,var_04,0,100);
		foreach(var_0A in var_01)
		{
			if(!function_010F(var_0A.origin,param_00))
			{
				if(function_010F(var_0A.origin + (0,0,40),param_00) || function_010F(var_0A.origin + (0,0,80),param_00) || function_010F(var_0A.origin + (0,0,120),param_00))
				{
					param_00.var_C053 = scripts\common\utility::array_add(param_00.var_C053,var_0A);
				}
			}
		}
	}
}

//Function Number: 13
func_FF9B(param_00)
{
	if(param_00)
	{
		if(self.var_4B75.var_130AC scripts\mp\_gameobjects::func_803E() == "neutral" && func_6E38(self.var_4B75))
		{
			var_01 = func_78B7(self.var_A9F4.origin);
			if(var_01 == self.var_4B75)
			{
				return 0;
			}
			else
			{
				var_02 = func_7B51(var_01,self.var_4B75);
				var_03 = distancesquared(var_01.origin,self.var_4B75.origin);
				var_04 = distancesquared(var_02.origin,self.var_4B75.origin);
				if(var_03 < var_04)
				{
					return 0;
				}
			}
		}
	}

	return scripts\mp\bots\_bots_strategy::func_FF9A(param_00);
}

//Function Number: 14
func_2D5F()
{
	return 0;
}

//Function Number: 15
func_2D60()
{
	return 0;
}

//Function Number: 16
func_2D64()
{
	self notify("bot_dom_think");
	self endon("bot_dom_think");
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	while(!isdefined(level.var_2DA1))
	{
		wait(0.05);
	}

	self.var_727F = 0;
	self.var_BF08 = 0;
	self.var_BF60 = 0;
	self botsetflag("separation",0);
	self botsetflag("grenade_objectives",1);
	self botsetflag("use_obj_path_style",1);
	for(;;)
	{
		scripts\mp\bots\_bots_util::func_2EBD();
		var_00 = gettime();
		if(var_00 > self.var_BF60)
		{
			self.var_BF60 = gettime() + 10000;
			self.var_110DC = self botgetdifficultysetting("strategyLevel");
		}

		if(var_00 > self.var_BF08 || self.var_727F)
		{
			if(func_FF25())
			{
				self.var_BF08 = var_00 + 5000;
			}
			else
			{
				self.var_727F = 0;
				func_2D31();
				self.var_BF08 = var_00 + randomintrange(30000,-20536);
			}
		}

		scripts\common\utility::waittill_notify_or_timeout("needs_new_flag_goal",1);
	}
}

//Function Number: 17
func_FF25()
{
	if(self.var_727F)
	{
		return 0;
	}

	if(!scripts\mp\bots\_bots_util::func_2DD5())
	{
		return 0;
	}

	if(self.var_4B75.var_130AC scripts\mp\_gameobjects::func_803E() == self.team)
	{
		return 0;
	}

	var_00 = func_79BA();
	if(distancesquared(self.origin,self.var_4B75.origin) < var_00 * 2 * var_00 * 2)
	{
		var_01 = func_780B(self.team);
		if(var_01.size == 2 && !scripts\common\utility::func_2286(var_01,self.var_4B75) && !func_2D09())
		{
			return 0;
		}

		return 1;
	}

	return 0;
}

//Function Number: 18
func_7B5E()
{
	return level.var_2D63[self.team];
}

//Function Number: 19
func_8B98()
{
	var_00 = func_7B5E();
	return var_00.size > 0;
}

//Function Number: 20
func_6E37(param_00)
{
	return !func_6E38(param_00);
}

//Function Number: 21
func_6E38(param_00)
{
	return param_00.var_130AC.var_6DE3;
}

//Function Number: 22
func_2D31()
{
	var_00 = undefined;
	var_01 = [];
	var_02 = [];
	var_03 = 1;
	var_04 = func_7B5E();
	if(var_04.size > 0)
	{
		var_05 = var_04;
	}
	else
	{
		var_05 = level.var_134;
	}

	for(var_06 = 0;var_06 < var_05.size;var_06++)
	{
		var_07 = var_05[var_06].var_130AC scripts\mp\_gameobjects::func_803E();
		if(var_03)
		{
			if(func_6E37(var_05[var_06]))
			{
				var_03 = 0;
			}
			else
			{
			}
		}

		if(var_07 != self.team)
		{
			var_01[var_01.size] = var_05[var_06];
			continue;
		}

		var_02[var_02.size] = var_05[var_06];
	}

	var_08 = undefined;
	if(var_01.size == 3)
	{
		var_08 = 1;
	}
	else if(var_01.size == 2)
	{
		if(var_02.size == 1)
		{
			if(!func_2E8D(var_02[0],1))
			{
				var_08 = 1;
			}
			else
			{
				var_08 = !func_2E8C(0.34);
			}
		}
		else if(var_02.size == 0)
		{
			var_08 = 1;
		}
	}
	else if(var_01.size == 1)
	{
		if(var_02.size == 2)
		{
			if(func_2D09())
			{
				if(!func_2E8D(var_02[0],2) && !func_2E8D(var_02[1],2))
				{
					var_08 = 1;
				}
				else if(self.var_110DC == 0)
				{
					var_08 = !func_2E8C(0.34);
				}
				else
				{
					var_08 = !func_2E8C(0.5);
				}
			}
			else
			{
				var_08 = 0;
			}
		}
		else if(var_02.size == 1)
		{
			if(!func_2E8D(var_02[0],1))
			{
				var_08 = 1;
			}
			else
			{
				var_08 = !func_2E8C(0.34);
			}
		}
		else if(var_02.size == 0)
		{
			var_08 = 1;
		}
	}
	else if(var_01.size == 0)
	{
		var_08 = 0;
	}

	if(var_08)
	{
		if(var_01.size > 1)
		{
			var_09 = scripts\common\utility::func_782F(self.origin,var_01);
		}
		else
		{
			var_09 = var_02;
		}

		if(var_03 && !func_8B98())
		{
			var_0A = func_7B2D(var_09[0],1);
			if(var_0A < 2)
			{
				var_0B = 0;
			}
			else
			{
				var_0C = 20;
				var_0D = 65;
				var_0E = 15;
				if(self.var_110DC == 0)
				{
					var_0C = 50;
					var_0D = 25;
					var_0E = 25;
				}

				var_0F = randomint(100);
				if(var_0F < var_0C)
				{
					var_0B = 0;
				}
				else if(var_0F < var_0C + var_0D)
				{
					var_0B = 1;
				}
				else
				{
					var_0B = 2;
				}
			}

			var_10 = undefined;
			if(var_0B == 0)
			{
				var_10 = "critical";
			}

			func_3A37(var_09[var_0B],var_10);
			return;
		}

		if(var_10.size == 1)
		{
			var_03 = var_10[0];
		}
		else if(distancesquared(var_10[0].origin,self.origin) < 102400)
		{
			var_03 = var_10[0];
		}
		else
		{
			var_11 = [];
			var_12 = [];
			for(var_09 = 0;var_09 < var_10.size;var_09++)
			{
				var_13 = distance(var_10[var_09].origin,self.origin);
				var_12[var_09] = var_13;
				var_11[var_09] = var_13;
			}

			if(var_05.size == 1)
			{
				var_14 = 1.5;
				for(var_09 = 0;var_09 < var_11.size;var_09++)
				{
					var_11[var_09] = var_11[var_09] + level.var_6E32[func_79BB(var_10[var_09])][func_79BB(var_05[0])] * var_14;
				}
			}

			if(self.var_110DC == 0)
			{
				var_0F = randomint(100);
				if(var_0F < 50)
				{
					var_03 = var_10[0];
				}
				else if(var_0F < 50 + 50 / var_10.size - 1)
				{
					var_03 = var_10[1];
				}
				else
				{
					var_03 = var_10[2];
				}
			}
			else if(var_11.size == 2)
			{
				var_15[0] = 50;
				var_15[1] = 50;
				for(var_09 = 0;var_09 < var_10.size;var_09++)
				{
					if(var_11[var_09] < var_11[1 - var_09])
					{
						var_15[var_09] = var_15[var_09] + 20;
						var_15[1 - var_09] = var_15[1 - var_09] - 20;
					}

					if(var_12[var_09] < 640)
					{
						var_15[var_09] = var_15[var_09] + 15;
						var_15[1 - var_09] = var_15[1 - var_09] - 15;
					}

					if(var_10[var_09].var_130AC scripts\mp\_gameobjects::func_803E() == "neutral")
					{
						var_15[var_09] = var_15[var_09] + 15;
						var_15[1 - var_09] = var_15[1 - var_09] - 15;
					}
				}

				var_0F = randomint(100);
				if(var_0F < var_15[0])
				{
					var_03 = var_10[0];
				}
				else
				{
					var_03 = var_10[1];
				}
			}
			else if(var_11.size == 3)
			{
				var_15[0] = 34;
				var_15[1] = 33;
				var_15[2] = 33;
				for(var_09 = 0;var_09 < var_10.size;var_09++)
				{
					var_16 = var_09 + 1 % 3;
					var_17 = var_09 + 2 % 3;
					if(var_11[var_09] < var_11[var_16] && var_11[var_09] < var_11[var_17])
					{
						var_15[var_09] = var_15[var_09] + 36;
						var_15[var_16] = var_15[var_16] - 18;
						var_15[var_17] = var_15[var_17] - 18;
					}

					if(var_12[var_09] < 640)
					{
						var_15[var_09] = var_15[var_09] + 15;
						var_15[var_16] = var_15[var_16] - 7;
						var_15[var_17] = var_15[var_17] - 8;
					}

					if(var_10[var_09].var_130AC scripts\mp\_gameobjects::func_803E() == "neutral")
					{
						var_15[var_09] = var_15[var_09] + 15;
						var_15[var_16] = var_15[var_16] - 7;
						var_15[var_17] = var_15[var_17] - 8;
					}
				}

				var_0F = randomint(100);
				if(var_0F < var_15[0])
				{
					var_03 = var_10[0];
				}
				else if(var_0F < var_15[0] + var_15[1])
				{
					var_03 = var_10[1];
				}
				else
				{
					var_03 = var_10[2];
				}
			}
		}
	}
	else
	{
		if(var_05.size > 1)
		{
			var_18 = scripts\common\utility::func_782F(self.origin,var_05);
		}
		else
		{
			var_18 = var_06;
		}

		foreach(var_1A in var_18)
		{
			if(func_2E8D(var_1A,var_05.size))
			{
				var_03 = var_1A;
				break;
			}
		}

		if(!isdefined(var_03))
		{
			if(self.var_110DC == 0)
			{
				var_03 = var_05[0];
			}
			else if(var_18.size == 2)
			{
				var_1C = func_7B51(var_18[0],var_18[1]);
				var_1D = scripts\common\utility::func_782F(var_1C.origin,var_18);
				var_0F = randomint(100);
				if(var_0F < 70)
				{
					var_03 = var_1D[0];
				}
				else
				{
					var_03 = var_1D[1];
				}
			}
			else
			{
				var_03 = var_18[0];
			}
		}
	}

	if(var_0B)
	{
		func_3A37(var_03);
		return;
	}

	func_5062(var_03);
}

//Function Number: 23
func_2D09()
{
	if(self.var_110DC == 0)
	{
		return 1;
	}

	var_00 = func_7B5E();
	if(var_00.size == 3)
	{
		return 1;
	}

	var_01 = scripts\mp\_gamescore::func_12B6(scripts\common\utility::func_7984(self.team));
	var_02 = scripts\mp\_gamescore::func_12B6(self.team);
	var_03 = 200 - var_01;
	var_04 = 200 - var_02;
	var_05 = var_04 * 0.5 > var_03;
	return var_05;
}

//Function Number: 24
func_2E8C(param_00)
{
	if(randomfloat(1) < param_00)
	{
		return 1;
	}

	var_01 = level.var_2E46[self.var_CA79];
	if(var_01 == "stationary")
	{
		return 1;
	}
	else if(var_01 == "active")
	{
		return 0;
	}
}

//Function Number: 25
func_3A37(param_00,param_01,param_02)
{
	self.var_4B75 = param_00;
	if(func_2D60())
	{
		var_03["override_goal_type"] = param_01;
		var_03["entrance_points_index"] = func_79BB(param_00);
		scripts\mp\bots\_bots_strategy::func_2E57(param_00.origin,func_79BC(),var_03);
	}
	else
	{
		param_00["override_goal_type"] = param_02;
		var_03["entrance_points_index"] = func_79BB(param_00);
		scripts\mp\bots\_bots_strategy::func_2D2C(param_00.origin,param_00.var_C053,param_00,var_03);
	}

	if(!isdefined(param_02) || !param_02)
	{
		thread func_B971(param_00);
	}
}

//Function Number: 26
func_5062(param_00)
{
	self.var_4B75 = param_00;
	if(func_2D5F())
	{
		var_01["entrance_points_index"] = func_79BB(param_00);
		scripts\mp\bots\_bots_strategy::func_2D2C(param_00.origin,param_00.var_C053,param_00,var_01);
	}
	else
	{
		param_00["entrance_points_index"] = func_79BB(var_01);
		var_01["nearest_node"] = param_00.nearest_node;
		scripts\mp\bots\_bots_strategy::func_2E57(param_00.origin,func_79BC(),var_01);
	}

	thread func_B971(param_00);
}

//Function Number: 27
func_79BA()
{
	if(!isdefined(level.var_3A38))
	{
		level.var_3A38 = 158;
	}

	return level.var_3A38;
}

//Function Number: 28
func_79BC()
{
	if(!isdefined(level.var_DAA3))
	{
		var_00 = self method_803C();
		var_01 = var_00[0] + var_00[1] / 2;
		level.var_DAA3 = min(1000,var_01 / 3.5);
	}

	return level.var_DAA3;
}

//Function Number: 29
func_2D62(param_00,param_01)
{
	if(issubstr(param_00,"losing"))
	{
		var_02 = getsubstr(param_00,param_00.size - 2);
		var_03 = undefined;
		for(var_04 = 0;var_04 < level.var_134.size;var_04++)
		{
			if(var_02 == level.var_134[var_04].script_label)
			{
				var_03 = level.var_134[var_04];
			}
		}

		if(isdefined(var_03) && func_2D08(var_03))
		{
			self botmemoryevent("known_enemy",undefined,var_03.origin);
			if(!isdefined(self.var_A8E1) || gettime() - self.var_A8E1 > 10000)
			{
				if(scripts\mp\bots\_bots_util::func_2DDD())
				{
					if(distancesquared(self.origin,var_03.origin) < 490000)
					{
						func_3A37(var_03);
						self.var_A8E1 = gettime();
					}
				}
			}
		}
	}

	scripts\mp\bots\_bots_util::func_2DFB(param_00,param_01);
}

//Function Number: 30
func_2D08(param_00)
{
	var_01 = func_7B5E();
	if(var_01.size == 0)
	{
		return 1;
	}

	if(scripts\common\utility::func_2286(var_01,param_00))
	{
		return 1;
	}

	return 0;
}

//Function Number: 31
func_B971(param_00)
{
	self notify("monitor_flag_status");
	self endon("monitor_flag_status");
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	var_01 = func_7B2F(self.team);
	var_02 = func_79BA() * func_79BA();
	var_03 = func_79BA() * 3 * func_79BA() * 3;
	var_04 = 1;
	while(var_04)
	{
		var_05 = 0;
		var_06 = param_00.var_130AC scripts\mp\_gameobjects::func_803E();
		var_07 = func_7B2F(self.team);
		var_08 = func_797C(self.team);
		if(scripts\mp\bots\_bots_util::func_2DD5())
		{
			if(var_06 == self.team && param_00.var_130AC.claimteam == "none")
			{
				if(!func_2D5F())
				{
					var_05 = 1;
				}
			}

			if(var_07 == 2 && var_06 != self.team && !func_2D09())
			{
				if(distancesquared(self.origin,param_00.origin) > var_02)
				{
					var_05 = 1;
				}
			}

			foreach(var_0A in var_08)
			{
				if(var_0A != param_00 && func_2D08(var_0A))
				{
					if(distancesquared(self.origin,var_0A.origin) < var_03)
					{
						var_05 = 1;
					}
				}
			}

			if(self istouching(param_00) && param_00.var_130AC.userate <= 0)
			{
				if(self bothasscriptgoal())
				{
					var_0C = self botgetscriptgoal();
					var_0D = self botgetscriptgoalradius();
					if(distancesquared(self.origin,var_0C) < squared(var_0D))
					{
						var_0E = self getnearestnode();
						if(isdefined(var_0E))
						{
							var_0F = undefined;
							foreach(var_11 in param_00.var_C053)
							{
								if(!nodesvisible(var_11,var_0E))
								{
									var_0F = var_11.origin;
									break;
								}
							}

							if(isdefined(var_0F))
							{
								self.var_5090 = var_0F;
								self notify("defend_force_node_recalculation");
							}
						}
					}
				}
			}
		}

		if(scripts\mp\bots\_bots_util::func_2DDD())
		{
			if(var_06 != self.team)
			{
				if(!func_2D60())
				{
					var_05 = 1;
				}
			}
			else if(var_07 == 1 && var_01 > 1)
			{
				var_05 = 1;
			}
		}

		var_01 = var_07;
		if(var_05)
		{
			self.var_727F = 1;
			var_04 = 0;
			self notify("needs_new_flag_goal");
			continue;
		}

		var_13 = level scripts\common\utility::waittill_notify_or_timeout_return("flag_changed_ownership",1 + randomfloatrange(0,2));
		if(!isdefined(var_13) && var_13 == "timeout")
		{
			var_14 = randomfloatrange(0.5,1);
			wait(var_14);
		}
	}
}

//Function Number: 32
func_2D61(param_00)
{
	if(param_00 == self.var_C031)
	{
		return 1;
	}

	if(!isdefined(self.var_4B75))
	{
		return 1;
	}

	var_01 = 0;
	var_02 = func_79BB(self.var_4B75);
	var_03 = func_780B(self.team);
	foreach(var_05 in var_03)
	{
		if(var_05 != self.var_4B75)
		{
			var_01 = param_00 scripts\mp\bots\_bots_util::func_C037(var_02,func_79BB(var_05));
			if(var_01)
			{
				var_06 = func_7B51(self.var_4B75,var_05);
				var_07 = var_06.var_130AC scripts\mp\_gameobjects::func_803E();
				if(var_07 != self.team)
				{
					if(param_00 scripts\mp\bots\_bots_util::func_C037(var_02,func_79BB(var_06)))
					{
						var_01 = 0;
					}
				}
			}
		}
	}

	if(var_01)
	{
		return 0.2;
	}

	return 1;
}

//Function Number: 33
func_79BB(param_00)
{
	var_01 = "";
	if(isdefined(param_00.var_11651))
	{
		var_01 = var_01 + param_00.var_11651 + "_";
	}

	var_01 = var_01 + "flag" + param_00.script_label;
	return var_01;
}

//Function Number: 34
func_7B51(param_00,param_01)
{
	for(var_02 = 0;var_02 < level.var_134.size;var_02++)
	{
		if(level.var_134[var_02] != param_00 && level.var_134[var_02] != param_01)
		{
			return level.var_134[var_02];
		}
	}
}

//Function Number: 35
func_7C92(param_00)
{
	param_00 = "_" + tolower(param_00);
	for(var_01 = 0;var_01 < level.var_134.size;var_01++)
	{
		if(level.var_134[var_01].script_label == param_00)
		{
			return level.var_134[var_01];
		}
	}
}

//Function Number: 36
func_78B7(param_00)
{
	var_01 = undefined;
	var_02 = undefined;
	foreach(var_04 in level.var_134)
	{
		var_05 = distancesquared(var_04.origin,param_00);
		if(!isdefined(var_02) || var_05 < var_02)
		{
			var_01 = var_04;
			var_02 = var_05;
		}
	}

	return var_01;
}

//Function Number: 37
func_7B2D(param_00,param_01)
{
	var_02 = 0;
	var_03 = func_79BA();
	foreach(var_05 in level.var_C928)
	{
		if(!isdefined(var_05.team))
		{
			continue;
		}

		if(var_05.team == self.team && var_05 != self && scripts\mp\_utility::func_9F9D(var_05))
		{
			if(isai(var_05))
			{
				if(var_05 func_2DD6(param_00))
				{
					var_02++;
				}

				continue;
			}

			if(!isdefined(param_01) || !param_01)
			{
				if(var_05 istouching(param_00))
				{
					var_02++;
				}
			}
		}
	}

	return var_02;
}

//Function Number: 38
func_2DD6(param_00)
{
	if(!scripts\mp\bots\_bots_util::func_2DD5())
	{
		return 0;
	}

	return func_2EA9(param_00);
}

//Function Number: 39
func_2DDE(param_00)
{
	if(!scripts\mp\bots\_bots_util::func_2DDD())
	{
		return 0;
	}

	return func_2EA9(param_00);
}

//Function Number: 40
func_2EA9(param_00)
{
	return isdefined(self.var_4B75) && self.var_4B75 == param_00;
}

//Function Number: 41
func_7B2F(param_00)
{
	var_01 = 0;
	for(var_02 = 0;var_02 < level.var_134.size;var_02++)
	{
		var_03 = level.var_134[var_02].var_130AC scripts\mp\_gameobjects::func_803E();
		if(var_03 == param_00)
		{
			var_01++;
		}
	}

	return var_01;
}

//Function Number: 42
func_797C(param_00)
{
	var_01 = [];
	for(var_02 = 0;var_02 < level.var_134.size;var_02++)
	{
		var_03 = level.var_134[var_02].var_130AC scripts\mp\_gameobjects::func_803E();
		if(var_03 == scripts\common\utility::func_7984(param_00))
		{
			var_01 = scripts\common\utility::array_add(var_01,level.var_134[var_02]);
		}
	}

	return var_01;
}

//Function Number: 43
func_780B(param_00)
{
	var_01 = [];
	for(var_02 = 0;var_02 < level.var_134.size;var_02++)
	{
		var_03 = level.var_134[var_02].var_130AC scripts\mp\_gameobjects::func_803E();
		if(var_03 == param_00)
		{
			var_01 = scripts\common\utility::array_add(var_01,level.var_134[var_02]);
		}
	}

	return var_01;
}

//Function Number: 44
func_2E8D(param_00,param_01)
{
	if(param_01 == 1)
	{
		var_02 = 1;
	}
	else
	{
		var_02 = 2;
	}

	var_03 = func_7879(param_00);
	return var_03.size < var_02;
}

//Function Number: 45
func_7879(param_00)
{
	var_01 = func_79BC();
	var_02 = [];
	foreach(var_04 in level.var_C928)
	{
		if(!isdefined(var_04.team))
		{
			continue;
		}

		if(var_04.team == self.team && var_04 != self && scripts\mp\_utility::func_9F9D(var_04))
		{
			if(isai(var_04))
			{
				if(var_04 func_2DDE(param_00))
				{
					var_02 = scripts\common\utility::array_add(var_02,var_04);
				}

				continue;
			}

			if(distancesquared(param_00.origin,var_04.origin) < var_01 * var_01)
			{
				var_02 = scripts\common\utility::array_add(var_02,var_04);
			}
		}
	}

	return var_02;
}