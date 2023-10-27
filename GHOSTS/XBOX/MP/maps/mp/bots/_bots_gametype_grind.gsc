/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\bots\_bots_gametype_grind.gsc
 * Game: Call of Duty: Ghosts
 * Platform: Console
 * Function Count: 7
 * Decompile Time: 129 ms
 * Timestamp: 10/27/2023 1:28:28 AM
*******************************************************************/

//Function Number: 1
func_4FDD()
{
	func_710C();
	maps/mp/bots/_bots_gametype_conf::setup_bot_conf();
}

//Function Number: 2
func_710C()
{
	level.bot_funcs["gametype_think"] = ::func_8FF1;
}

//Function Number: 3
func_8FF1()
{
	self notify("bot_grind_think");
	self endon("bot_grind_think");
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	self.grind_waiting_to_bank = 0;
	self.goal_zone = undefined;
	self.conf_camping_zone = 0;
	self.additional_tactical_logic_func = ::func_8FF0;
	if(self botgetdifficultysetting("strategyLevel") > 0)
	{
		childthread func_9138();
	}

	maps/mp/bots/_bots_gametype_conf::func_8FDE();
}

//Function Number: 4
func_8FF0()
{
	if(!isdefined(self.tag_getting))
	{
		if(self.tagscarried > 0)
		{
			var_00 = squared(500 + self.tagscarried * 250);
			if(game["teamScores"][self.team] + self.tagscarried >= maps\mp\_utility::getwatcheddvar("scorelimit"))
			{
				var_00 = squared(5000);
			}
			else if(!isdefined(self.enemy) && !maps/mp/bots/_bots_util::bot_in_combat())
			{
				var_00 = squared(1500 + self.tagscarried * 250);
			}

			var_01 = undefined;
			foreach(var_03 in level.zonelist)
			{
				var_04 = distancesquared(self.origin,var_03.origin);
				if(var_04 < var_00)
				{
					var_00 = var_04;
					var_01 = var_03;
				}
			}

			if(isdefined(var_01))
			{
				var_06 = 1;
				if(self.grind_waiting_to_bank)
				{
					if(isdefined(self.goal_zone) && self.goal_zone == var_01)
					{
						var_06 = 0;
					}
				}

				if(var_06)
				{
					self.grind_waiting_to_bank = 1;
					self.goal_zone = var_01;
					self botclearscriptgoal();
					self notify("stop_going_to_zone");
					self notify("stop_camping_zone");
					self.conf_camping_zone = 0;
					maps/mp/bots/_bots_personality::func_1D01();
					maps/mp/bots/_bots_strategy::bot_abort_tactical_goal("kill_tag");
					childthread func_8FEF(var_01,"tactical");
				}
			}

			if(self.grind_waiting_to_bank)
			{
				if(game["teamScores"][self.team] + self.tagscarried >= maps\mp\_utility::getwatcheddvar("scorelimit"))
				{
					self botsetflag("force_sprint",1);
				}
			}
		}
		else if(self.grind_waiting_to_bank)
		{
			self.grind_waiting_to_bank = 0;
			self.goal_zone = undefined;
			self notify("stop_going_to_zone");
			self botclearscriptgoal();
		}

		if(self.personality == "camper" && !self.conf_camping_tag && !self.grind_waiting_to_bank)
		{
			var_00 = undefined;
			var_01 = undefined;
			foreach(var_03 in level.zonelist)
			{
				var_04 = distancesquared(self.origin,var_03.origin);
				if(!isdefined(var_00) || var_04 < var_00)
				{
					var_00 = var_04;
					var_01 = var_03;
				}
			}

			if(isdefined(var_01))
			{
				if(maps/mp/bots/_bots_personality::func_748C())
				{
					if(maps/mp/bots/_bots_personality::func_325A(var_01.origin))
					{
						self.conf_camping_zone = 1;
						self notify("stop_going_to_zone");
						self.grind_waiting_to_bank = 0;
						self botclearscriptgoal();
						childthread func_8FD7(var_01,"camp");
					}
					else
					{
						self notify("stop_camping_zone");
						self.conf_camping_zone = 0;
						maps/mp/bots/_bots_personality::func_1D01();
					}
				}
			}
			else
			{
				self.conf_camping_zone = 1;
			}
		}
	}
	else
	{
		self notify("stop_going_to_zone");
		self.grind_waiting_to_bank = 0;
		self.goal_zone = undefined;
		self notify("stop_camping_zone");
		self.conf_camping_zone = 0;
	}

	return self.grind_waiting_to_bank || self.conf_camping_zone;
}

//Function Number: 5
func_8FEF(param_00,param_01)
{
	self endon("stop_going_to_zone");
	if(!isdefined(param_00.calculated_nearest_node))
	{
		param_00.nearest_node = getclosestnodeinsight(param_00.origin);
		param_00.calculated_nearest_node = 1;
	}

	var_02 = param_00.nearest_node;
	self botsetscriptgoal(var_02.origin,32,param_01);
	var_03 = maps/mp/bots/_bots_util::bot_waittill_goal_or_fail();
}

//Function Number: 6
func_8FD7(param_00,param_01)
{
	self endon("stop_camping_zone");
	self botsetscriptgoalnode(self.node_ambushing_from,param_01,self.ambush_yaw);
	var_02 = maps/mp/bots/_bots_util::bot_waittill_goal_or_fail();
	if(var_02 == "goal")
	{
		if(!isdefined(param_00.calculated_nearest_node))
		{
			param_00.nearest_node = getclosestnodeinsight(param_00.origin);
			param_00.calculated_nearest_node = 1;
		}

		var_03 = param_00.nearest_node;
		if(isdefined(var_03))
		{
			var_04 = nodeexposedtosky(self.origin);
			var_04 = common_scripts\utility::array_add(var_04,var_03);
			childthread maps/mp/bots/_bots_util::bot_watch_nodes(var_04);
		}
	}
}

//Function Number: 7
func_9138()
{
	self.default_meleechargedist = self botgetdifficultysetting("meleeChargeDist");
	for(;;)
	{
		if(self botgetdifficultysetting("strategyLevel") < 2)
		{
			wait(0.5);
		}
		else
		{
			wait(0.2);
		}

		if(isdefined(self.enemy) && isplayer(self.enemy) && isdefined(self.enemy.tagscarried) && self.enemy.tagscarried >= 3 && self botcanseeentity(self.enemy) && distance(self.origin,self.enemy.origin) <= 500)
		{
			self botsetdifficultysetting("meleeChargeDist",500);
			self botsetflag("prefer_melee",1);
			continue;
		}

		self botsetdifficultysetting("meleeChargeDist",self.default_meleechargedist);
		self botsetflag("prefer_melee",0);
	}
}