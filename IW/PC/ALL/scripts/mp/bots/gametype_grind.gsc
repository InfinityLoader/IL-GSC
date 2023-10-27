/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\mp\bots\gametype_grind.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 7
 * Decompile Time: 378 ms
 * Timestamp: 10/27/2023 12:11:58 AM
*******************************************************************/

//Function Number: 1
main()
{
	func_F8F4();
	scripts\mp\bots\gametype_conf::func_F8D8();
}

//Function Number: 2
func_F8F4()
{
	level.var_2D9E["gametype_think"] = ::func_2DBF;
}

//Function Number: 3
func_2DBF()
{
	self notify("bot_grind_think");
	self endon("bot_grind_think");
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	self.var_860B = 0;
	self.var_8432 = undefined;
	self.var_4505 = 0;
	self.var_17D9 = ::func_2DBE;
	if(self botgetdifficultysetting("strategyLevel") > 0)
	{
		childthread func_6541();
	}

	scripts\mp\bots\gametype_conf::func_2D39();
}

//Function Number: 4
func_2DBE()
{
	if(!isdefined(self.var_113DD))
	{
		if(self.var_11422 > 0)
		{
			var_00 = squared(500 + self.var_11422 * 250);
			if(game["teamScores"][self.team] + self.var_11422 >= level.var_E763)
			{
				var_00 = squared(5000);
			}
			else if(!isdefined(self.var_10C) && !scripts\mp\bots\_bots_util::func_2DCA())
			{
				var_00 = squared(1500 + self.var_11422 * 250);
			}

			var_01 = undefined;
			foreach(var_03 in level.var_13FC1)
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
				if(self.var_860B)
				{
					if(isdefined(self.var_8432) && self.var_8432 == var_01)
					{
						var_06 = 0;
					}
				}

				if(var_06)
				{
					self.var_860B = 1;
					self.var_8432 = var_01;
					self botclearscriptgoal();
					self notify("stop_going_to_zone");
					self notify("stop_camping_zone");
					self.var_4505 = 0;
					scripts\mp\bots\_bots_personality::func_413A();
					scripts\mp\bots\_bots_strategy::func_2D02("kill_tag");
					childthread func_2DBC(var_01,"tactical");
				}
			}

			if(self.var_860B)
			{
				if(game["teamScores"][self.team] + self.var_11422 >= level.var_E763)
				{
					self botsetflag("force_sprint",1);
				}
			}
		}
		else if(self.var_860B)
		{
			self.var_860B = 0;
			self.var_8432 = undefined;
			self notify("stop_going_to_zone");
			self botclearscriptgoal();
		}

		if(self.var_CA79 == "camper" && !self.var_4504 && !self.var_860B)
		{
			var_00 = undefined;
			var_01 = undefined;
			foreach(var_03 in level.var_13FC1)
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
				if(scripts\mp\bots\_bots_personality::func_FF87())
				{
					if(scripts\mp\bots\_bots_personality::func_6C77(var_01.origin))
					{
						self.var_4505 = 1;
						self notify("stop_going_to_zone");
						self.var_860B = 0;
						self botclearscriptgoal();
						childthread func_2D20(var_01,"camp");
					}
					else
					{
						self notify("stop_camping_zone");
						self.var_4505 = 0;
						scripts\mp\bots\_bots_personality::func_413A();
					}
				}
			}
			else
			{
				self.var_4505 = 1;
			}
		}
	}
	else
	{
		self notify("stop_going_to_zone");
		self.var_860B = 0;
		self.var_8432 = undefined;
		self notify("stop_camping_zone");
		self.var_4505 = 0;
	}

	return self.var_860B || self.var_4505;
}

//Function Number: 5
func_2DBC(param_00,param_01)
{
	self endon("stop_going_to_zone");
	if(!isdefined(param_00.calculated_nearest_node))
	{
		param_00.nearest_node = getclosestnodeinsight(param_00.origin);
		param_00.calculated_nearest_node = 1;
	}

	var_02 = param_00.nearest_node;
	self botsetscriptgoal(var_02.origin,32,param_01);
	var_03 = scripts\mp\bots\_bots_util::func_2ECB();
}

//Function Number: 6
func_2D20(param_00,param_01)
{
	self endon("stop_camping_zone");
	self botsetscriptgoalnode(self.var_C02A,param_01,self.var_1E2A);
	var_02 = scripts\mp\bots\_bots_util::func_2ECB();
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
			var_04 = findentrances(self.origin);
			var_04 = scripts\common\utility::array_add(var_04,var_03);
			childthread scripts\mp\bots\_bots_util::func_2ED4(var_04);
		}
	}
}

//Function Number: 7
func_6541()
{
	self.var_5001 = self botgetdifficultysetting("meleeChargeDist");
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

		if(isdefined(self.var_10C) && isplayer(self.var_10C) && isdefined(self.var_10C.var_11422) && self.var_10C.var_11422 >= 3 && self botcanseeentity(self.var_10C) && distance(self.origin,self.var_10C.origin) <= 500)
		{
			self method_804D("meleeChargeDist",500);
			self botsetflag("prefer_melee",1);
			continue;
		}

		self method_804D("meleeChargeDist",self.var_5001);
		self botsetflag("prefer_melee",0);
	}
}