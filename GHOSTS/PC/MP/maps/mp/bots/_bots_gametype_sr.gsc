/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\bots\_bots_gametype_sr.gsc
 * Game: Call of Duty: Ghosts
 * Platform: PC
 * Function Count: 14
 * Decompile Time: 250 ms
 * Timestamp: 10/27/2023 1:17:26 AM
*******************************************************************/

//Function Number: 1
func_4FDD()
{
	maps/mp/bots/_bots_gametype_sd::func_710C();
	func_710C();
	maps/mp/bots/_bots_gametype_conf::setup_bot_conf();
	maps/mp/bots/_bots_gametype_sd::func_900B();
}

//Function Number: 2
func_710C()
{
	level.bot_funcs["gametype_think"] = ::func_9012;
}

//Function Number: 3
func_9012()
{
	self notify("bot_sr_think");
	self endon("bot_sr_think");
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	while(!isdefined(level.bot_gametype_precaching_done))
	{
		wait(0.05);
	}

	self.suspend_sd_role = undefined;
	childthread func_94FA();
	maps/mp/bots/_bots_gametype_sd::func_900C();
}

//Function Number: 4
func_94FA()
{
	for(;;)
	{
		wait(0.05);
		if(self.health <= 0)
		{
			continue;
		}

		if(!isdefined(self.role))
		{
			continue;
		}

		var_00 = maps/mp/bots/_bots_gametype_conf::func_8FEB(0);
		if(var_00.size > 0)
		{
			var_01 = common_scripts\utility::func_6306(var_00);
			if(distancesquared(self.origin,var_01.tag.curorigin) < 10000)
			{
				func_94E3(var_01.tag);
			}
			else if(self.team == game["attackers"])
			{
				if(self.role != "atk_bomber")
				{
					func_94E3(var_01.tag);
				}
			}
			else if(self.role != "bomb_defuser")
			{
				func_94E3(var_01.tag);
			}
		}
	}
}

//Function Number: 5
func_94E3(param_00)
{
	if(isdefined(param_00.bot_picking_up) && isdefined(param_00.bot_picking_up[self.team]) && isalive(param_00.bot_picking_up[self.team]) && param_00.bot_picking_up[self.team] != self)
	{
	}

	if(func_94E1(param_00))
	{
	}

	if(!isdefined(self.role))
	{
	}

	if(maps/mp/bots/_bots_util::bot_is_defending())
	{
		maps/mp/bots/_bots_strategy::bot_defend_stop();
	}

	param_00.bot_picking_up[self.team] = self;
	param_00 thread clear_bot_on_reset();
	param_00 thread func_906B(self);
	self.suspend_sd_role = 1;
	childthread func_936C(param_00,"tag_picked_up");
	var_01 = param_00.curorigin;
	self botsetscriptgoal(var_01,0,"tactical");
	childthread func_9591(param_00);
	var_02 = maps/mp/bots/_bots_util::bot_waittill_goal_or_fail(undefined,"tag_picked_up","new_role");
	self notify("stop_watch_tag_destination");
	if(var_02 == "no_path")
	{
		var_01 = var_01 + (16 * func_93DB(),16 * func_93DB(),0);
		self botsetscriptgoal(var_01,0,"tactical");
		var_02 = maps/mp/bots/_bots_util::bot_waittill_goal_or_fail(undefined,"tag_picked_up","new_role");
		if(var_02 == "no_path")
		{
			var_01 = maps/mp/bots/_bots_util::bot_queued_process("BotGetClosestNavigablePoint",::maps/mp/bots/_bots_util::func_35A6,param_00.curorigin,32,self);
			if(isdefined(var_01))
			{
				self botsetscriptgoal(var_01,0,"tactical");
				var_02 = maps/mp/bots/_bots_util::bot_waittill_goal_or_fail(undefined,"tag_picked_up","new_role");
			}
		}
	}
	else if(var_02 == "bad_path")
	{
		var_03 = getnodesinradiussorted(param_00.curorigin,256,0,level.bot_tag_allowable_jump_height + 55);
		if(var_03.size > 0)
		{
			var_04 = (param_00.curorigin[0],param_00.curorigin[1],var_03[0].origin[2] + param_00.curorigin[2] * 0.5);
			self botsetscriptgoal(var_04,0,"tactical");
			var_02 = maps/mp/bots/_bots_util::bot_waittill_goal_or_fail(undefined,"tag_picked_up","new_role");
		}
	}

	if(var_02 == "goal" && param_00 maps\mp\gametypes\_gameobjects::func_19CA(self.team))
	{
		wait(3);
	}

	if(self bothasscriptgoal() && isdefined(var_01))
	{
		var_05 = self botgetscriptgoal();
		if(maps/mp/bots/_bots_util::func_16C0(var_05,var_01))
		{
			self botclearscriptgoal();
		}
	}

	self notify("stop_tag_watcher");
	param_00.bot_picking_up[self.team] = undefined;
	self.suspend_sd_role = undefined;
}

//Function Number: 6
func_9591(param_00)
{
	self endon("stop_watch_tag_destination");
	for(;;)
	{
		if(!param_00 maps\mp\gametypes\_gameobjects::func_19CA(self.team))
		{
			wait(0.05);
		}

		var_01 = self botgetscriptgoal();
		wait(0.05);
	}
}

//Function Number: 7
func_94E1(param_00)
{
	var_01 = distance(self.origin,param_00.curorigin);
	var_02 = maps/mp/bots/_bots_gametype_sd::func_91AA(self.team,1);
	foreach(var_04 in var_02)
	{
		if(var_04 != self && isdefined(var_04.role) && var_04.role != "atk_bomber" && var_04.role != "bomb_defuser")
		{
			var_05 = distance(var_04.origin,param_00.curorigin);
			if(var_05 < var_01 * 0.5)
			{
				return 1;
			}
		}
	}

	return 0;
}

//Function Number: 8
func_93DB()
{
	return randomintrange(0,2) * 2 - 1;
}

//Function Number: 9
clear_bot_on_reset()
{
	self waittill("reset");
	self.bot_picking_up = [];
}

//Function Number: 10
func_906B(param_00)
{
	self endon("reset");
	var_01 = param_00.team;
	param_00 common_scripts\utility::func_8B2A("death","disconnect");
	self.bot_picking_up[var_01] = undefined;
}

//Function Number: 11
func_936C(param_00,param_01)
{
	self endon("stop_tag_watcher");
	while(param_00 maps\mp\gametypes\_gameobjects::func_19CA(self.team) && !maps/mp/bots/_bots_gametype_conf::func_8FDA(param_00))
	{
		wait(0.05);
	}

	self notify(param_01);
}

//Function Number: 12
func_94E2(param_00)
{
	if(isdefined(param_00.bot_camping) && isdefined(param_00.bot_camping[self.team]) && isalive(param_00.bot_camping[self.team]) && param_00.bot_camping[self.team] != self)
	{
	}

	if(!isdefined(self.role))
	{
	}

	if(maps/mp/bots/_bots_util::bot_is_defending())
	{
		maps/mp/bots/_bots_strategy::bot_defend_stop();
	}

	param_00.bot_camping[self.team] = self;
	param_00 thread func_906A();
	param_00 thread func_9069(self);
	self.suspend_sd_role = 1;
	maps/mp/bots/_bots_personality::func_1D01();
	var_01 = self.role;
	while(param_00 maps\mp\gametypes\_gameobjects::func_19CA(self.team) && self.role == var_01)
	{
		if(maps/mp/bots/_bots_personality::func_748C())
		{
			if(maps/mp/bots/_bots_personality::func_325A(param_00.curorigin,1000))
			{
				childthread maps/mp/bots/_bots_gametype_conf::func_8FD6(param_00,"tactical","new_role");
			}
		}

		wait(0.05);
	}

	self notify("stop_camping_tag");
	self botclearscriptgoal();
	param_00.bot_camping[self.team] = undefined;
	self.suspend_sd_role = undefined;
}

//Function Number: 13
func_906A()
{
	self waittill("reset");
	self.bot_camping = [];
}

//Function Number: 14
func_9069(param_00)
{
	self endon("reset");
	var_01 = param_00.team;
	param_00 common_scripts\utility::func_8B2A("death","disconnect");
	self.bot_camping[var_01] = undefined;
}