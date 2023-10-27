/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\bots\_bots_gametype_sr.gsc
 * Game: Call of Duty: WWII
 * Platform: PC
 * Function Count: 14
 * Decompile Time: 239 ms
 * Timestamp: 10/27/2023 3:09:46 AM
*******************************************************************/

//Function Number: 1
func_00F9()
{
	maps/mp/bots/_bots_gametype_sd::func_87A7();
	func_87A7();
	maps/mp/bots/_bots_gametype_conf::func_8790();
	maps/mp/bots/_bots_gametype_sd::func_1ABF();
}

//Function Number: 2
func_87A7()
{
	level.var_19D5["gametype_think"] = ::func_1AF0;
}

//Function Number: 3
func_1AF0()
{
	self notify("bot_sr_think");
	self endon("bot_sr_think");
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	self.var_4B44 = undefined;
	while(!isdefined(level.var_19E8))
	{
		wait 0.05;
	}

	self.var_9526 = undefined;
	childthread init_dj_quests();
	maps/mp/bots/_bots_gametype_sd::func_1AC0();
}

//Function Number: 4
init_dj_quests()
{
	for(;;)
	{
		wait 0.05;
		if(self.var_BC <= 0)
		{
			continue;
		}

		if(!isdefined(self.var_7ECA))
		{
			continue;
		}

		var_00 = maps/mp/bots/_bots_gametype_conf::func_19D1(0);
		if(var_00.size > 0)
		{
			var_01 = common_scripts\utility::func_7A33(var_00);
			if(distancesquared(self.var_116,var_01.var_95A6.var_28D4) < 10000)
			{
				func_913E(var_01.var_95A6);
			}
			else if(self.var_1A7 == game["attackers"])
			{
				if(self.var_7ECA != "atk_bomber")
				{
					func_913E(var_01.var_95A6);
				}
			}
			else if(self.var_7ECA != "defuser")
			{
				func_913E(var_01.var_95A6);
			}
		}
	}
}

//Function Number: 5
func_913E(param_00)
{
	if(isdefined(param_00.var_1A9A) && isdefined(param_00.var_1A9A[self.var_1A7]) && isalive(param_00.var_1A9A[self.var_1A7]) && param_00.var_1A9A[self.var_1A7] != self)
	{
		return;
	}

	if(func_913C(param_00))
	{
		return;
	}

	if(!isdefined(self.var_7ECA))
	{
		return;
	}

	if(maps/mp/bots/_bots_util::func_1A2D())
	{
		maps/mp/bots/_bots_strategy::func_19A3();
	}

	param_00.var_1A9A[self.var_1A7] = self;
	param_00 thread func_23A9();
	param_00 thread func_23A8(self);
	self.var_9526 = 1;
	childthread func_6804(param_00,"tag_picked_up");
	var_01 = param_00.var_28D4;
	self botsetscriptgoal(var_01,0,"tactical");
	childthread func_A8E2(param_00);
	var_02 = maps/mp/bots/_bots_util::func_1B21(undefined,"tag_picked_up","new_role");
	self notify("stop_watch_tag_destination");
	if(var_02 == "no_path")
	{
		var_01 = var_01 + (16 * func_7A32(),16 * func_7A32(),0);
		self botsetscriptgoal(var_01,0,"tactical");
		var_02 = maps/mp/bots/_bots_util::func_1B21(undefined,"tag_picked_up","new_role");
		if(var_02 == "no_path")
		{
			var_01 = maps/mp/bots/_bots_util::func_1AA8("BotGetClosestNavigablePoint",::maps/mp/bots/_bots_util::func_3F03,param_00.var_28D4,32,self);
			if(isdefined(var_01))
			{
				self botsetscriptgoal(var_01,0,"tactical");
				var_02 = maps/mp/bots/_bots_util::func_1B21(undefined,"tag_picked_up","new_role");
			}
		}
	}
	else if(var_02 == "bad_path")
	{
		var_03 = getnodesinradiussorted(param_00.var_28D4,256,0,level.var_1AF5 + 55);
		if(var_03.size > 0)
		{
			var_04 = (param_00.var_28D4[0],param_00.var_28D4[1],var_03[0].var_116[2] + param_00.var_28D4[2] * 0.5);
			self botsetscriptgoal(var_04,0,"tactical");
			var_02 = maps/mp/bots/_bots_util::func_1B21(undefined,"tag_picked_up","new_role");
		}
	}

	if(var_02 == "goal" && param_00 maps\mp\gametypes\_gameobjects::func_1F53(self.var_1A7))
	{
		wait(3);
	}

	if(self method_8367() && isdefined(var_01))
	{
		var_05 = self method_835C();
		if(maps/mp/bots/_bots_util::func_1B1C(var_05,var_01))
		{
			self method_8358();
		}
	}

	self notify("stop_tag_watcher");
	param_00.var_1A9A[self.var_1A7] = undefined;
	self.var_9526 = undefined;
}

//Function Number: 6
func_A8E2(param_00)
{
	self endon("stop_watch_tag_destination");
	for(;;)
	{
		if(!param_00 maps\mp\gametypes\_gameobjects::func_1F53(self.var_1A7))
		{
			wait 0.05;
		}

		var_01 = self method_835C();
		wait 0.05;
	}
}

//Function Number: 7
func_913C(param_00)
{
	var_01 = distance(self.var_116,param_00.var_28D4);
	var_02 = maps/mp/bots/_bots_gametype_common::func_41FB(self.var_1A7,1);
	foreach(var_04 in var_02)
	{
		if(var_04 != self && isdefined(var_04.var_7ECA) && var_04.var_7ECA != "atk_bomber" && var_04.var_7ECA != "defuser")
		{
			var_05 = distance(var_04.var_116,param_00.var_28D4);
			if(var_05 < var_01 * 0.5)
			{
				return 1;
			}
		}
	}

	return 0;
}

//Function Number: 8
func_7A32()
{
	return randomintrange(0,2) * 2 - 1;
}

//Function Number: 9
func_23A9()
{
	self waittill("reset");
	self.var_1A9A = [];
}

//Function Number: 10
func_23A8(param_00)
{
	self endon("reset");
	var_01 = param_00.var_1A7;
	param_00 common_scripts\utility::knock_off_battery("death","disconnect");
	self.var_1A9A[var_01] = undefined;
}

//Function Number: 11
func_6804(param_00,param_01)
{
	self endon("stop_tag_watcher");
	while(param_00 maps\mp\gametypes\_gameobjects::func_1F53(self.var_1A7) && !maps/mp/bots/_bots_gametype_conf::func_196E(param_00))
	{
		wait 0.05;
	}

	self notify(param_01);
}

//Function Number: 12
func_913D(param_00)
{
	if(isdefined(param_00.var_1955) && isdefined(param_00.var_1955[self.var_1A7]) && isalive(param_00.var_1955[self.var_1A7]) && param_00.var_1955[self.var_1A7] != self)
	{
		return;
	}

	if(!isdefined(self.var_7ECA))
	{
		return;
	}

	if(maps/mp/bots/_bots_util::func_1A2D())
	{
		maps/mp/bots/_bots_strategy::func_19A3();
	}

	param_00.var_1955[self.var_1A7] = self;
	param_00 thread func_23A7();
	param_00 thread func_23A6(self);
	self.var_9526 = 1;
	maps/mp/bots/_bots_personality::func_23AB();
	var_01 = self.var_7ECA;
	while(param_00 maps\mp\gametypes\_gameobjects::func_1F53(self.var_1A7) && self.var_7ECA == var_01)
	{
		if(maps/mp/bots/_bots_personality::func_8B73())
		{
			if(maps/mp/bots/_bots_personality::func_3B64(param_00.var_28D4,1000))
			{
				childthread maps/mp/bots/_bots_gametype_conf::func_1954(param_00,"tactical","new_role");
			}
		}

		wait 0.05;
	}

	self notify("stop_camping_tag");
	self method_8358();
	param_00.var_1955[self.var_1A7] = undefined;
	self.var_9526 = undefined;
}

//Function Number: 13
func_23A7()
{
	self waittill("reset");
	self.var_1955 = [];
}

//Function Number: 14
func_23A6(param_00)
{
	self endon("reset");
	var_01 = param_00.var_1A7;
	param_00 common_scripts\utility::knock_off_battery("death","disconnect");
	self.var_1955[var_01] = undefined;
}