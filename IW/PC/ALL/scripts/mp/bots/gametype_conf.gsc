/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\mp\bots\gametype_conf.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 16
 * Decompile Time: 863 ms
 * Timestamp: 10/27/2023 12:11:51 AM
*******************************************************************/

//Function Number: 1
main()
{
	func_F8F4();
	func_F8D8();
}

//Function Number: 2
func_F8F4()
{
	level.var_2D9E["gametype_think"] = ::func_2D39;
}

//Function Number: 3
func_F8D8()
{
	level.var_2EA7 = 200;
	level.var_2EA6 = 38;
}

//Function Number: 4
func_2D39()
{
	self notify("bot_conf_think");
	self endon("bot_conf_think");
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	self.var_BF68 = gettime() + 500;
	self.var_1141F = [];
	childthread func_2ED3();
	if(self.var_CA79 == "camper")
	{
		self.var_4503 = 0;
		if(!isdefined(self.var_4504))
		{
			self.var_4504 = 0;
		}
	}

	for(;;)
	{
		var_00 = isdefined(self.var_113DD);
		var_01 = 0;
		if(var_00 && self bothasscriptgoal())
		{
			var_02 = self botgetscriptgoal();
			if(scripts\mp\bots\_bots_util::func_2EC6(self.var_113DD.var_4B2C,var_02))
			{
				if(self botpursuingscriptgoal())
				{
					var_01 = 1;
				}
			}
			else if(scripts\mp\bots\_bots_strategy::func_2DC5("kill_tag") && self.var_113DD scripts\mp\_gameobjects::caninteractwith(self.team))
			{
				self.var_113DD = undefined;
				var_00 = 0;
			}
		}

		self botsetflag("force_sprint",var_01);
		self.var_1141F = func_2E65(self.var_1141F);
		var_03 = func_2D74(self.var_1141F,1);
		var_04 = isdefined(var_03);
		if((var_00 && !var_04) || !var_00 && var_04 || var_00 && var_04 && self.var_113DD != var_03)
		{
			self.var_113DD = var_03;
			self botclearscriptgoal();
			self notify("stop_camping_tag");
			scripts\mp\bots\_bots_personality::func_413A();
			scripts\mp\bots\_bots_strategy::func_2D02("kill_tag");
		}

		if(isdefined(self.var_113DD))
		{
			self.var_4504 = 0;
			if(self.var_CA79 == "camper" && self.var_4503)
			{
				self.var_4504 = 1;
				if(scripts\mp\bots\_bots_personality::func_FF87())
				{
					if(scripts\mp\bots\_bots_personality::func_6C77(self.var_113DD.var_4B2C,1000))
					{
						childthread func_2D1F(self.var_113DD,"camp");
					}
					else
					{
						self.var_4504 = 0;
					}
				}
			}

			if(!self.var_4504)
			{
				if(!scripts\mp\bots\_bots_strategy::func_2DC5("kill_tag"))
				{
					var_05 = spawnstruct();
					var_05.var_EDCA = "objective";
					var_05.var_C293 = level.var_2EA7;
					scripts\mp\bots\_bots_strategy::func_2E27("kill_tag",self.var_113DD.var_4B2C,25,var_05);
				}
			}
		}

		var_06 = 0;
		if(isdefined(self.var_17D9))
		{
			var_06 = self [[ self.var_17D9 ]]();
		}

		if(!isdefined(self.var_113DD))
		{
			if(!var_06)
			{
				self [[ self.var_CA7B ]]();
			}
		}

		if(gettime() > self.var_BF68)
		{
			self.var_BF68 = gettime() + 500;
			var_07 = func_2D7C(1);
			self.var_1141F = func_2D38(var_07,self.var_1141F);
		}

		wait(0.05);
	}
}

//Function Number: 5
func_2D2E(param_00)
{
	if(isdefined(param_00.on_path_grid) && param_00.on_path_grid)
	{
		var_01 = self.origin + (0,0,55);
		if(distance2dsquared(param_00.var_4B2C,var_01) < 144)
		{
			var_02 = param_00.var_4B2C[2] - var_01[2];
			if(var_02 > 0)
			{
				if(var_02 < level.var_2EA6)
				{
					if(!isdefined(self.var_A920))
					{
						self.var_A920 = 0;
					}

					if(gettime() - self.var_A920 > 3000)
					{
						self.var_A920 = gettime();
						thread func_2DE3();
					}
				}
				else
				{
					param_00.on_path_grid = 0;
					return 1;
				}
			}
		}
	}

	return 0;
}

//Function Number: 6
func_2DE3()
{
	self endon("death");
	self endon("disconnect");
	self botsetstance("stand");
	wait(1);
	self botpressbutton("jump");
	wait(1);
	self botsetstance("none");
}

//Function Number: 7
func_2ED3()
{
	for(;;)
	{
		level waittill("new_tag_spawned",var_00);
		self.var_BF68 = -1;
		if(isdefined(var_00))
		{
			if((isdefined(var_00.var_13372) && var_00.var_13372 == self) || isdefined(var_00.var_4F) && var_00.var_4F == self)
			{
				if(!isdefined(var_00.on_path_grid) && !isdefined(var_00.var_3731))
				{
					thread func_3704(var_00);
					func_1380A(var_00);
					if(var_00.on_path_grid)
					{
						var_01 = spawnstruct();
						var_01.origin = var_00.var_4B2C;
						var_01.var_2DD = var_00;
						var_02[0] = var_01;
						self.var_1141F = func_2D38(var_02,self.var_1141F);
					}
				}
			}
		}
	}
}

//Function Number: 8
func_2D38(param_00,param_01)
{
	var_02 = param_01;
	foreach(var_04 in param_00)
	{
		var_05 = 0;
		foreach(var_07 in param_01)
		{
			if(var_04.var_2DD == var_07.var_2DD && scripts\mp\bots\_bots_util::func_2EC6(var_04.origin,var_07.origin))
			{
				var_05 = 1;
				break;
			}
		}

		if(!var_05)
		{
			var_02 = scripts\common\utility::array_add(var_02,var_04);
		}
	}

	return var_02;
}

//Function Number: 9
func_2DE1(param_00,param_01,param_02)
{
	if(!param_00.calculated_nearest_node)
	{
		param_00.nearest_node = getclosestnodeinsight(param_00.var_4B2C);
		param_00.calculated_nearest_node = 1;
	}

	if(isdefined(param_00.var_3731))
	{
		return 0;
	}

	var_03 = param_00.nearest_node;
	var_04 = !isdefined(param_00.on_path_grid);
	if(isdefined(var_03) && var_04 || param_00.on_path_grid)
	{
		var_05 = var_03 == param_01 || nodesvisible(var_03,param_01,1);
		if(var_05)
		{
			var_06 = scripts\common\utility::func_13D90(self.origin,self.angles,param_00.var_4B2C,param_02);
			if(var_06)
			{
				if(var_04)
				{
					thread func_3704(param_00);
					func_1380A(param_00);
					if(!param_00.on_path_grid)
					{
						return 0;
					}
				}

				return 1;
			}
		}
	}

	return 0;
}

//Function Number: 10
func_2D7C(param_00,param_01,param_02)
{
	var_03 = undefined;
	if(isdefined(param_01))
	{
		var_03 = param_01;
	}
	else
	{
		var_03 = self getnearestnode();
	}

	var_04 = undefined;
	if(isdefined(param_02))
	{
		var_04 = param_02;
	}
	else
	{
		var_04 = self botgetfovdot();
	}

	var_05 = [];
	if(isdefined(var_03) && isdefined(level.var_58C0))
	{
		foreach(var_07 in level.var_58C0)
		{
			if(var_07 scripts\mp\_gameobjects::caninteractwith(self.team))
			{
				var_08 = 0;
				if(!param_00)
				{
					if(!isdefined(var_07.var_3731))
					{
						if(!isdefined(var_07.on_path_grid))
						{
							level thread func_3704(var_07);
							func_1380A(var_07);
						}

						var_08 = distancesquared(self.origin,var_07.var_4B2C) < 1000000 && var_07.on_path_grid;
					}
				}
				else if(func_2DE1(var_07,var_03,var_04))
				{
					var_08 = 1;
				}

				if(var_08)
				{
					var_09 = spawnstruct();
					var_09.origin = var_07.var_4B2C;
					var_09.var_2DD = var_07;
					var_05 = scripts\common\utility::array_add(var_05,var_09);
				}
			}
		}
	}

	return var_05;
}

//Function Number: 11
func_3704(param_00)
{
	param_00 endon("reset");
	param_00.var_3731 = 1;
	param_00.on_path_grid = scripts\mp\bots\_bots_util::func_2E4E(param_00.var_4B2C,undefined,level.var_2EA6 + 55);
	param_00.var_3731 = undefined;
}

//Function Number: 12
func_1380A(param_00)
{
	while(!isdefined(param_00.on_path_grid))
	{
		wait(0.05);
	}
}

//Function Number: 13
func_2D74(param_00,param_01)
{
	var_02 = undefined;
	if(param_00.size > 0)
	{
		var_03 = 1409865409;
		foreach(var_05 in param_00)
		{
			var_06 = func_7B2E(var_05.var_2DD);
			if(!param_01 || var_06 < 2)
			{
				var_07 = distancesquared(var_05.var_2DD.var_4B2C,self.origin);
				if(var_07 < var_03)
				{
					var_02 = var_05.var_2DD;
					var_03 = var_07;
				}
			}
		}
	}

	return var_02;
}

//Function Number: 14
func_2E65(param_00)
{
	var_01 = [];
	foreach(var_03 in param_00)
	{
		if(var_03.var_2DD scripts\mp\_gameobjects::caninteractwith(self.team) && scripts\mp\bots\_bots_util::func_2EC6(var_03.var_2DD.var_4B2C,var_03.origin))
		{
			if(!func_2D2E(var_03.var_2DD) && var_03.var_2DD.on_path_grid)
			{
				var_01 = scripts\common\utility::array_add(var_01,var_03);
			}
		}
	}

	return var_01;
}

//Function Number: 15
func_7B2E(param_00)
{
	var_01 = 0;
	foreach(var_03 in level.var_C928)
	{
		if(!isdefined(var_03.team))
		{
			continue;
		}

		if(var_03.team == self.team && var_03 != self)
		{
			if(isai(var_03))
			{
				if(isdefined(var_03.var_113DD) && var_03.var_113DD == param_00)
				{
					var_01++;
				}

				continue;
			}

			if(distancesquared(var_03.origin,param_00.var_4B2C) < 160000)
			{
				var_01++;
			}
		}
	}

	return var_01;
}

//Function Number: 16
func_2D1F(param_00,param_01,param_02)
{
	self notify("bot_camp_tag");
	self endon("bot_camp_tag");
	self endon("stop_camping_tag");
	if(isdefined(param_02))
	{
		self endon(param_02);
	}

	self botsetscriptgoalnode(self.var_C02A,param_01,self.var_1E2A);
	var_03 = scripts\mp\bots\_bots_util::func_2ECB();
	if(var_03 == "goal")
	{
		var_04 = param_00.nearest_node;
		if(isdefined(var_04))
		{
			var_05 = findentrances(self.origin);
			var_05 = scripts\common\utility::array_add(var_05,var_04);
			childthread scripts\mp\bots\_bots_util::func_2ED4(var_05);
		}
	}
}