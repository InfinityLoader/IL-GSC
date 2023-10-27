/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\mp\bots\gametype_sr.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 14
 * Decompile Time: 751 ms
 * Timestamp: 10/27/2023 12:12:09 AM
*******************************************************************/

//Function Number: 1
main()
{
	scripts\mp\bots\gametype_sd::func_F8F4();
	func_F8F4();
	scripts\mp\bots\gametype_conf::func_F8D8();
	scripts\mp\bots\gametype_sd::func_2E6D();
}

//Function Number: 2
func_F8F4()
{
	level.var_2D9E["gametype_think"] = ::func_2E9F;
}

//Function Number: 3
func_2E9F()
{
	self notify("bot_sr_think");
	self endon("bot_sr_think");
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	self.var_8BAF = undefined;
	while(!isdefined(level.var_2DA1))
	{
		wait(0.05);
	}

	self.var_112FD = undefined;
	childthread func_113ED();
	scripts\mp\bots\gametype_sd::func_2E6E();
}

//Function Number: 4
func_113ED()
{
	for(;;)
	{
		wait(0.05);
		if(self.health <= 0)
		{
			continue;
		}

		if(!isdefined(self.var_E67C))
		{
			continue;
		}

		var_00 = scripts\mp\bots\gametype_conf::func_2D7C(0);
		if(var_00.size > 0)
		{
			var_01 = scripts\common\utility::random(var_00);
			if(distancesquared(self.origin,var_01.var_2DD.var_4B2C) < 10000)
			{
				func_10B2C(var_01.var_2DD);
			}
			else if(self.team == game["attackers"])
			{
				if(self.var_E67C != "atk_bomber")
				{
					func_10B2C(var_01.var_2DD);
				}
			}
			else if(self.var_E67C != "bomb_defuser")
			{
				func_10B2C(var_01.var_2DD);
			}
		}
	}
}

//Function Number: 5
func_10B2C(param_00)
{
	if(isdefined(param_00.var_2E4B) && isdefined(param_00.var_2E4B[self.team]) && isalive(param_00.var_2E4B[self.team]) && param_00.var_2E4B[self.team] != self)
	{
		return;
	}

	if(func_10B28(param_00))
	{
		return;
	}

	if(!isdefined(self.var_E67C))
	{
		return;
	}

	if(scripts\mp\bots\_bots_util::func_2DD7())
	{
		scripts\mp\bots\_bots_strategy::func_2D4E();
	}

	param_00.var_2E4B[self.team] = self;
	param_00 thread func_4136();
	param_00 thread func_4135(self);
	self.var_112FD = 1;
	childthread func_C158(param_00,"tag_picked_up");
	var_01 = param_00.var_4B2C;
	self botsetscriptgoal(var_01,0,"tactical");
	childthread func_1397F(param_00);
	var_02 = scripts\mp\bots\_bots_util::func_2ECB(undefined,"tag_picked_up","new_role");
	self notify("stop_watch_tag_destination");
	if(var_02 == "no_path")
	{
		var_01 = var_01 + (16 * func_DC68(),16 * func_DC68(),0);
		self botsetscriptgoal(var_01,0,"tactical");
		var_02 = scripts\mp\bots\_bots_util::func_2ECB(undefined,"tag_picked_up","new_role");
		if(var_02 == "no_path")
		{
			var_01 = scripts\mp\bots\_bots_util::func_2E58("BotGetClosestNavigablePoint",::scripts\mp\bots\_bots_util::func_74C3,param_00.var_4B2C,32,self);
			if(isdefined(var_01))
			{
				self botsetscriptgoal(var_01,0,"tactical");
				var_02 = scripts\mp\bots\_bots_util::func_2ECB(undefined,"tag_picked_up","new_role");
			}
		}
	}
	else if(var_02 == "bad_path")
	{
		var_03 = getnodesinradiussorted(param_00.var_4B2C,256,0,level.var_2EA6 + 55);
		if(var_03.size > 0)
		{
			var_04 = (param_00.var_4B2C[0],param_00.var_4B2C[1],var_03[0].origin[2] + param_00.var_4B2C[2] * 0.5);
			self botsetscriptgoal(var_04,0,"tactical");
			var_02 = scripts\mp\bots\_bots_util::func_2ECB(undefined,"tag_picked_up","new_role");
		}
	}

	if(var_02 == "goal" && param_00 scripts\mp\_gameobjects::caninteractwith(self.team))
	{
		wait(3);
	}

	if(self bothasscriptgoal() && isdefined(var_01))
	{
		var_05 = self botgetscriptgoal();
		if(scripts\mp\bots\_bots_util::func_2EC6(var_05,var_01))
		{
			self botclearscriptgoal();
		}
	}

	self notify("stop_tag_watcher");
	param_00.var_2E4B[self.team] = undefined;
	self.var_112FD = undefined;
}

//Function Number: 6
func_1397F(param_00)
{
	self endon("stop_watch_tag_destination");
	for(;;)
	{
		if(!param_00 scripts\mp\_gameobjects::caninteractwith(self.team))
		{
			wait(0.05);
		}

		var_01 = self botgetscriptgoal();
		wait(0.05);
	}
}

//Function Number: 7
func_10B28(param_00)
{
	var_01 = distance(self.origin,param_00.var_4B2C);
	var_02 = scripts\mp\bots\gametype_sd::func_7AA1(self.team,1);
	foreach(var_04 in var_02)
	{
		if(var_04 != self && isdefined(var_04.var_E67C) && var_04.var_E67C != "atk_bomber" && var_04.var_E67C != "bomb_defuser")
		{
			var_05 = distance(var_04.origin,param_00.var_4B2C);
			if(var_05 < var_01 * 0.5)
			{
				return 1;
			}
		}
	}

	return 0;
}

//Function Number: 8
func_DC68()
{
	return randomintrange(0,2) * 2 - 1;
}

//Function Number: 9
func_4136()
{
	self waittill("reset");
	self.var_2E4B = [];
}

//Function Number: 10
func_4135(param_00)
{
	self endon("reset");
	var_01 = param_00.team;
	param_00 scripts\common\utility::waittill_any_3("death","disconnect");
	self.var_2E4B[var_01] = undefined;
}

//Function Number: 11
func_C158(param_00,param_01)
{
	self endon("stop_tag_watcher");
	while(param_00 scripts\mp\_gameobjects::caninteractwith(self.team) && !scripts\mp\bots\gametype_conf::func_2D2E(param_00))
	{
		wait(0.05);
	}

	self notify(param_01);
}

//Function Number: 12
func_10B29(param_00)
{
	if(isdefined(param_00.var_2D21) && isdefined(param_00.var_2D21[self.team]) && isalive(param_00.var_2D21[self.team]) && param_00.var_2D21[self.team] != self)
	{
		return;
	}

	if(!isdefined(self.var_E67C))
	{
		return;
	}

	if(scripts\mp\bots\_bots_util::func_2DD7())
	{
		scripts\mp\bots\_bots_strategy::func_2D4E();
	}

	param_00.var_2D21[self.team] = self;
	param_00 thread func_4134();
	param_00 thread func_4133(self);
	self.var_112FD = 1;
	scripts\mp\bots\_bots_personality::func_413A();
	var_01 = self.var_E67C;
	while(param_00 scripts\mp\_gameobjects::caninteractwith(self.team) && self.var_E67C == var_01)
	{
		if(scripts\mp\bots\_bots_personality::func_FF87())
		{
			if(scripts\mp\bots\_bots_personality::func_6C77(param_00.var_4B2C,1000))
			{
				childthread scripts\mp\bots\gametype_conf::func_2D1F(param_00,"tactical","new_role");
			}
		}

		wait(0.05);
	}

	self notify("stop_camping_tag");
	self botclearscriptgoal();
	param_00.var_2D21[self.team] = undefined;
	self.var_112FD = undefined;
}

//Function Number: 13
func_4134()
{
	self waittill("reset");
	self.var_2D21 = [];
}

//Function Number: 14
func_4133(param_00)
{
	self endon("reset");
	var_01 = param_00.team;
	param_00 scripts\common\utility::waittill_any_3("death","disconnect");
	self.var_2D21[var_01] = undefined;
}