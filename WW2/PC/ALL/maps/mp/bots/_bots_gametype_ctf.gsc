/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\bots\_bots_gametype_ctf.gsc
 * Game: Call of Duty: WWII
 * Platform: PC
 * Function Count: 22
 * Decompile Time: 366 ms
 * Timestamp: 10/27/2023 3:09:20 AM
*******************************************************************/

//Function Number: 1
func_00F9()
{
	func_87A7();
	func_8791();
}

//Function Number: 2
func_87A7()
{
	level.var_19D5["crate_can_use"] = ::func_2734;
	level.var_19D5["gametype_think"] = ::func_1993;
	level.var_19D5["get_watch_node_chance"] = ::func_1988;
}

//Function Number: 3
func_8791()
{
	level.var_19DB = ::func_2897;
	level.var_19DE = ::func_2898;
	level.var_19D6 = ::func_4091;
	level.var_19D7 = ::func_4092;
	level.var_19D9 = ::func_1984;
	level.var_19E3 = ::func_1990;
	maps/mp/bots/_bots_util::func_1B20();
	while(!isdefined(level.var_9853))
	{
		wait 0.05;
	}

	level.var_9853["allies"].var_81E8 = "allies";
	level.var_9853["axis"].var_81E8 = "axis";
	maps/mp/bots/_bots_gametype_common::func_194F(level.var_9853,"flag_");
	var_00 = getzonenearest(level.var_9853["allies"].var_116);
	if(isdefined(var_00))
	{
		botzonesetteam(var_00,"allies");
	}

	var_00 = getzonenearest(level.var_9853["axis"].var_116);
	if(isdefined(var_00))
	{
		botzonesetteam(var_00,"axis");
	}

	level.var_1FC6["allies"].var_6638 = level.var_9853["allies"].var_6638;
	level.var_1FC6["axis"].var_6638 = level.var_9853["axis"].var_6638;
	thread func_1983();
	level.var_19E8 = 1;
}

//Function Number: 4
func_2734(param_00)
{
	if(function_01EF(self) && !isdefined(param_00.var_1B7B))
	{
		return 0;
	}

	if(func_1991())
	{
		return 0;
	}

	return func_1986(self.var_1A7);
}

//Function Number: 5
func_1993()
{
	self notify("bot_ctf_think");
	self endon("bot_ctf_think");
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	while(!isdefined(level.var_19E8))
	{
		wait 0.05;
	}

	self.var_66A7 = 0;
	self botsetflag("separation",0);
	self botsetflag("use_obj_path_style",1);
	var_00 = 0;
	var_01 = 0;
	for(;;)
	{
		wait 0.05;
		if(self.var_BC <= 0)
		{
			continue;
		}

		if(!isdefined(self.var_7ECA))
		{
			maps/mp/bots/_bots_gametype_common::func_19E7();
		}

		if(func_1986(self.var_1A7))
		{
			if(isdefined(level.var_1A53) && isdefined(level.var_1A53[level.var_6C63[self.var_1A7]]))
			{
				level.var_1A53[level.var_6C63[self.var_1A7]] = undefined;
			}
		}

		var_02 = 0;
		if(self.var_7ECA == "attacker")
		{
			if(func_1991())
			{
				var_02 = 1;
			}
			else if(!func_1985())
			{
				var_02 = distancesquared(self.var_116,level.var_9853[level.var_6C63[self.var_1A7]].var_28D4) < squared(func_4195());
			}
		}
		else if(!func_1986(self.var_1A7))
		{
			var_02 = !func_1989();
		}

		self botsetflag("force_sprint",var_02);
		var_01 = 0;
		if(func_1991())
		{
			if(func_1986(self.var_1A7))
			{
				func_23B2();
				var_01 = 1;
				if(!var_00)
				{
					var_00 = 1;
					self botsetpathingstyle("scripted");
				}

				self botsetscriptgoal(level.var_1FC6[self.var_1A7].var_28D4,16,"critical");
			}
			else if(maps/mp/bots/_bots_gametype_common::func_19E1(self.var_1A7) == 1)
			{
				func_1992();
			}
			else if(gettime() > self.var_66A7)
			{
				func_23B2();
				var_03 = getnodesinradius(level.var_1FC6[self.var_1A7].var_28D4,900,0,300);
				var_04 = self method_8366(var_03,var_03.size * 0.15,"node_hide_anywhere");
				if(!isdefined(var_04))
				{
					var_04 = level.var_1FC6[self.var_1A7].var_6638;
				}

				var_05 = self botsetscriptgoalnode(var_04,"critical");
				if(var_05)
				{
					self.var_66A7 = gettime() + 15000;
				}
			}
		}
		else if(self.var_7ECA == "attacker")
		{
			if(func_1985())
			{
				if(!maps/mp/bots/_bots_util::func_1A27())
				{
					func_23B2();
					self method_8358();
					var_06 = level.var_9853[level.var_6C63[self.var_1A7]].var_2006;
					maps/mp/bots/_bots_strategy::func_1A0C(var_06,500);
				}
			}
			else
			{
				func_23B2();
				if(self method_835F() == "critical")
				{
					self method_8358();
				}

				self botsetscriptgoal(level.var_9853[level.var_6C63[self.var_1A7]].var_28D4,16,"objective",undefined,300);
			}
		}
		else if(!func_1986(self.var_1A7))
		{
			func_1992();
		}
		else if(!func_55F2())
		{
			self method_8358();
			var_07["score_flags"] = "strict_los";
			var_07["entrance_points_index"] = "flag_" + level.var_9853[self.var_1A7].var_81E8;
			var_07["nearest_node_to_center"] = level.var_9853[self.var_1A7].var_6638;
			maps/mp/bots/_bots_strategy::func_1AA6(level.var_9853[self.var_1A7].var_28D4,func_4195(),var_07);
		}

		if(var_00 && !var_01)
		{
			var_00 = 0;
			self botsetpathingstyle(undefined);
		}
	}
}

//Function Number: 6
func_1992()
{
	var_00 = undefined;
	var_01 = level.var_9853[self.var_1A7];
	var_02 = var_01.var_2006;
	if(!isdefined(var_02))
	{
		var_00 = var_01.var_28D4;
	}
	else if(self method_8371(var_02))
	{
		var_00 = var_02.var_116;
		if(self botgetdifficultysetting("strategyLevel") > 0 && !func_1986(self.var_1A7))
		{
			if(!isdefined(level.var_1A53))
			{
				level.var_1A53 = [];
			}

			if(!isdefined(level.var_1A53[var_02.var_1A7]))
			{
				level.var_1A53[var_02.var_1A7] = [];
			}

			level.var_1A53[var_02.var_1A7]["origin"] = var_00;
			level.var_1A53[var_02.var_1A7]["time"] = gettime();
		}
	}
	else if(isdefined(var_01.var_28CF))
	{
		if(isdefined(var_01.var_2562["friendly"]))
		{
			if(var_01.var_6990)
			{
				var_00 = var_01.var_28CF;
			}
			else
			{
				var_00 = var_02.var_116;
			}
		}
	}
	else
	{
		var_00 = var_01.var_28D4;
	}

	if(isdefined(var_00))
	{
		func_23B2();
		self botsetscriptgoal(var_00,16,"critical");
		return;
	}

	var_03 = undefined;
	var_04 = undefined;
	if(self botgetdifficultysetting("strategyLevel") > 0)
	{
		if(isdefined(level.var_1A53) && isdefined(level.var_1A53[var_02.var_1A7]))
		{
			var_04 = gettime() - level.var_1A53[var_02.var_1A7]["time"];
			if(var_04 < 10000)
			{
				var_03 = level.var_1A53[var_02.var_1A7]["origin"];
			}
		}
	}

	if(isdefined(var_03))
	{
		if(var_04 < 5000)
		{
			func_23B2();
			self botsetscriptgoal(var_03,16,"critical");
			return;
		}

		if(!maps/mp/bots/_bots_util::func_1A32())
		{
			maps/mp/bots/_bots_strategy::func_19A3();
			maps/mp/bots/_bots_strategy::func_1A8D(var_03,400);
			return;
		}

		return;
	}

	func_23B2();
	var_05 = self method_835F();
	if(var_05 == "objective" || var_05 == "critical")
	{
		self method_8358();
	}

	maps/mp/bots/_bots_personality::func_A0C0();
}

//Function Number: 7
func_23B2()
{
	if(maps/mp/bots/_bots_util::func_1A2D())
	{
		maps/mp/bots/_bots_strategy::func_19A3();
	}
}

//Function Number: 8
func_55F2()
{
	return maps/mp/bots/_bots_util::func_1A33();
}

//Function Number: 9
func_4195()
{
	if(isalive(self) && !isdefined(level.var_7790))
	{
		var_00 = self method_8361();
		var_01 = var_00[0] + var_00[1] / 2;
		level.var_7790 = min(800,var_01 / 5.5);
	}

	if(!isdefined(level.var_7790))
	{
		return 900;
	}

	return level.var_7790;
}

//Function Number: 10
func_2897(param_00)
{
	var_01 = maps/mp/bots/_bots_gametype_common::func_19E1(param_00);
	if(var_01 == 1)
	{
		return 1;
	}

	if(func_1986(param_00))
	{
		var_02 = var_01 * 0.67;
	}
	else if(func_1986(level.var_6C63[var_01]))
	{
		var_02 = var_02 * 0.5;
	}
	else
	{
		var_02 = var_02 * 0.4;
	}

	var_03 = int(exp(var_02));
	var_04 = game["teamScores"][param_00];
	var_05 = game["teamScores"][common_scripts\utility::func_416F(param_00)];
	if(var_04 + 1 < var_05)
	{
		var_03 = int(min(var_03 + 1,var_01));
	}

	return var_03;
}

//Function Number: 11
func_2898(param_00)
{
	var_01 = maps/mp/bots/_bots_gametype_common::func_19E1(param_00);
	return var_01 - func_2897(param_00);
}

//Function Number: 12
func_4091(param_00)
{
	return maps/mp/bots/_bots_gametype_common::func_19DF(param_00,level.var_1FC6[param_00].var_28D4,func_4195());
}

//Function Number: 13
func_4092(param_00)
{
	return maps/mp/bots/_bots_gametype_common::func_19E0(param_00,level.var_1FC6[param_00].var_28D4,func_4195());
}

//Function Number: 14
func_1983()
{
	level notify("bot_ctf_ai_director_update");
	level endon("bot_ctf_ai_director_update");
	level endon("game_ended");
	thread maps/mp/bots/_bots_gametype_common::func_19DA();
}

//Function Number: 15
func_1988(param_00)
{
	if(param_00 == self.var_6709)
	{
		return 1;
	}

	if(!func_55F2())
	{
		return 1;
	}

	var_01 = param_00 maps/mp/bots/_bots_util::func_670D("flag_allies","flag_axis");
	if(var_01)
	{
		return 1;
	}

	return 0.2;
}

//Function Number: 16
func_1986(param_00)
{
	return level.var_9853[param_00] maps\mp\gametypes\_gameobjects::func_5715();
}

//Function Number: 17
func_1987(param_00)
{
	return isdefined(level.var_9853[param_00].var_2006);
}

//Function Number: 18
func_1989()
{
	return func_1987(self.var_1A7);
}

//Function Number: 19
func_1985()
{
	return func_1987(level.var_6C63[self.var_1A7]);
}

//Function Number: 20
func_1991()
{
	return isdefined(self.var_2013);
}

//Function Number: 21
func_1984()
{
	if(func_1991())
	{
		return 0;
	}

	return 1;
}

//Function Number: 22
func_1990()
{
	if(func_1991())
	{
		return 1;
	}

	return 0;
}