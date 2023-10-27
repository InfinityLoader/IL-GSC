/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\mp\bots\_bots_personality.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 23
 * Decompile Time: 1124 ms
 * Timestamp: 10/27/2023 12:27:41 AM
*******************************************************************/

//Function Number: 1
func_F9FD()
{
	level.var_2E44 = [];
	level.var_2E45 = [];
	level.var_2E44["active"][0] = "default";
	level.var_2E44["active"][1] = "run_and_gun";
	level.var_2E44["active"][2] = "cqb";
	level.var_2E44["stationary"][0] = "camper";
	level.var_2E46 = [];
	foreach(var_05, var_01 in level.var_2E44)
	{
		foreach(var_03 in var_01)
		{
			level.var_2E46[var_03] = var_05;
			level.var_2E45[level.var_2E45.size] = var_03;
		}
	}

	level.var_2E47 = [];
	level.var_2E47["active"] = 2;
	level.var_2E47["stationary"] = 1;
	level.var_2E42 = [];
	level.var_2E42["default"] = ::func_96D4;
	level.var_2E42["camper"] = ::func_96D3;
	level.var_2E43["default"] = ::func_12E08;
	level.var_2E43["camper"] = ::func_12E07;
}

//Function Number: 2
func_2D0C()
{
	self.var_CA79 = self method_8035();
	self.var_CA7A = level.var_2E42[self.var_CA79];
	if(!isdefined(self.var_CA7A))
	{
		self.var_CA7A = level.var_2E42["default"];
	}

	self [[ self.var_CA7A ]]();
	self.var_CA7B = level.var_2E43[self.var_CA79];
	if(!isdefined(self.var_CA7B))
	{
		self.var_CA7B = level.var_2E43["default"];
	}
}

//Function Number: 3
func_2D10()
{
	if(isdefined(self.var_CA7C) && self.var_CA7C)
	{
		return;
	}

	if(scripts\mp\_utility::func_2DD9())
	{
		return;
	}

	var_00 = [];
	var_01 = [];
	foreach(var_07, var_03 in level.var_2E44)
	{
		var_01[var_07] = 0;
		foreach(var_05 in var_03)
		{
			var_00[var_05] = 0;
		}
	}

	foreach(var_09 in level.players)
	{
		if(isbot(var_09) && isdefined(var_09.team) && var_09.team == self.team && var_09 != self && isdefined(var_09.var_8B68))
		{
			var_05 = var_09 method_8035();
			var_07 = level.var_2E46[var_05];
			var_00[var_05] = var_00[var_05] + 1;
			var_01[var_07] = var_01[var_07] + 1;
		}
	}

	var_0B = undefined;
	while(!isdefined(var_0B))
	{
		for(var_0C = level.var_2E47;var_0C.size > 0;var_0C[var_0D] = undefined)
		{
			var_0D = scripts\mp\bots\_bots_util::func_2DB4(var_0C,randomint(var_0C.size));
			var_01[var_0D] = var_01[var_0D] - level.var_2E47[var_0D];
			if(var_01[var_0D] < 0)
			{
				var_0B = var_0D;
				break;
			}
		}
	}

	var_0E = undefined;
	var_0F = undefined;
	var_10 = 9999;
	var_11 = undefined;
	var_12 = -9999;
	var_13 = scripts\common\utility::array_randomize(level.var_2E44[var_0B]);
	foreach(var_05 in var_13)
	{
		if(var_00[var_05] < var_10)
		{
			var_0F = var_05;
			var_10 = var_00[var_05];
		}

		if(var_00[var_05] > var_12)
		{
			var_11 = var_05;
			var_12 = var_00[var_05];
		}
	}

	if(var_12 - var_10 >= 2)
	{
		var_0E = var_0F;
	}
	else
	{
		var_0E = scripts\common\utility::random(level.var_2E44[var_0B]);
	}

	if(self method_8035() != var_0E)
	{
		self botsetpersonality(var_0E);
	}

	self.var_8B68 = 1;
}

//Function Number: 4
func_96D3()
{
	func_413A();
}

//Function Number: 5
func_96D4()
{
	func_413A();
}

//Function Number: 6
func_12E07()
{
	if(func_FF87() && !scripts\mp\bots\_bots_util::func_2DD7() && !scripts\mp\bots\_bots_util::func_2DE0())
	{
		var_00 = self botgetscriptgoaltype();
		var_01 = 0;
		if(!isdefined(self.var_37EB))
		{
			self.var_37EB = 0;
		}

		var_02 = var_00 == "hunt";
		var_03 = gettime() > self.var_37EB + 10000;
		if((!var_02 || var_03) && !scripts\mp\bots\_bots_util::func_2E3B())
		{
			if(!self bothasscriptgoal())
			{
				func_2E5C();
			}

			var_01 = func_6C7E();
			if(!var_01)
			{
				self.var_37EB = gettime();
			}
		}

		if(isdefined(var_01) && var_01)
		{
			self.var_1E16 = scripts\mp\bots\_bots_util::func_2E58("bot_find_ambush_entrances",::func_2D73,self.var_C02A,1);
			var_04 = scripts\mp\bots\_bots_strategy::func_2DA3("trap_directional","trap","c4");
			if(isdefined(var_04))
			{
				var_05 = gettime();
				scripts\mp\bots\_bots_strategy::func_2E7E(var_04,self.var_1E16,self.var_C02A,self.var_1E2A);
				var_05 = gettime() - var_05;
				if(var_05 > 0 && isdefined(self.var_1E14) && isdefined(self.var_C02A))
				{
					self.var_1E14 = self.var_1E14 + var_05;
					self.var_C02A.var_2D0B = self.var_1E14 + 10000;
				}
			}

			if(!scripts\mp\bots\_bots_strategy::func_2DC5() && !scripts\mp\bots\_bots_util::func_2DD7() && isdefined(self.var_C02A))
			{
				self botsetscriptgoalnode(self.var_C02A,"camp",self.var_1E2A);
				thread func_417C("bad_path","node_relinquished","out_of_ammo");
				thread func_13961();
				thread func_2D03("clear_camper_data","goal");
				thread func_2ECF("clear_camper_data","bot_add_ambush_time_delayed",self.var_1E16,self.var_1E2A);
				return;
			}

			return;
		}

		if(var_00 == "camp")
		{
			self botclearscriptgoal();
		}

		func_12E08();
	}
}

//Function Number: 7
func_12E08()
{
	var_00 = undefined;
	var_01 = self bothasscriptgoal();
	if(var_01)
	{
		var_00 = self botgetscriptgoal();
	}

	if(!scripts\mp\bots\_bots_strategy::func_2DC5() && !scripts\mp\bots\_bots_util::func_2DE0())
	{
		var_02 = undefined;
		var_03 = undefined;
		if(var_01)
		{
			var_02 = distancesquared(self.origin,var_00);
			var_03 = self botgetscriptgoalradius();
			var_04 = var_03 * 2;
			if(isdefined(self.var_2E1F) && var_02 < var_04 * var_04)
			{
				var_05 = botmemoryflags("investigated");
				function_0021(0,gettime() - self.var_2E20,1,self.var_2E1F,var_04,"kill",var_05,self);
				function_0021(0,gettime() - self.var_2E20,1,self.var_2E1F,var_04,"death",var_05,self);
				self.var_2E1F = undefined;
				self.var_2E20 = undefined;
			}
		}

		if(!var_01 || var_02 < var_03 * var_03)
		{
			var_06 = func_2E5C();
			if(var_06 && randomfloat(100) < 25)
			{
				var_07 = scripts\mp\bots\_bots_strategy::func_2DA3("trap_directional","trap");
				if(isdefined(var_07))
				{
					var_08 = self botgetscriptgoal();
					if(isdefined(var_08))
					{
						var_09 = getclosestnodeinsight(var_08);
						if(isdefined(var_09))
						{
							var_0A = scripts\mp\bots\_bots_util::func_2E58("bot_find_ambush_entrances",::func_2D73,var_09,0);
							var_0B = scripts\mp\bots\_bots_strategy::func_2E7E(var_07,var_0A,var_09);
							if(!isdefined(var_0B) || var_0B)
							{
								self botclearscriptgoal();
								var_06 = func_2E5C();
							}
						}
					}
				}
			}

			if(var_06)
			{
				thread func_417C("enemy","bad_path","goal","node_relinquished","search_end");
				return;
			}
		}
	}
}

//Function Number: 8
func_417C(param_00,param_01,param_02,param_03,param_04)
{
	self notify("clear_script_goal_on");
	self endon("clear_script_goal_on");
	self endon("death");
	self endon("disconnect");
	self endon("start_tactical_goal");
	var_05 = self botgetscriptgoal();
	var_06 = 1;
	while(var_06)
	{
		var_07 = scripts\common\utility::func_13734(param_00,param_01,param_02,param_03,param_04,"script_goal_changed");
		var_06 = 0;
		var_08 = 1;
		if(var_07 == "node_relinquished" || var_07 == "goal" || var_07 == "script_goal_changed")
		{
			if(!self bothasscriptgoal())
			{
				var_08 = 0;
			}
			else
			{
				var_09 = self botgetscriptgoal();
				var_08 = scripts\mp\bots\_bots_util::func_2EC6(var_05,var_09);
			}
		}

		if(var_07 == "enemy" && isdefined(self.var_10C))
		{
			var_08 = 0;
			var_06 = 1;
		}

		if(var_08)
		{
			self botclearscriptgoal();
		}
	}
}

//Function Number: 9
func_13961()
{
	self notify("watch_out_of_ammo");
	self endon("watch_out_of_ammo");
	self endon("death");
	self endon("disconnect");
	while(!scripts\mp\bots\_bots_util::func_2E3B())
	{
		wait(0.5);
	}

	self notify("out_of_ammo");
}

//Function Number: 10
func_2D03(param_00,param_01)
{
	self notify("bot_add_ambush_time_delayed");
	self endon("bot_add_ambush_time_delayed");
	self endon("death");
	self endon("disconnect");
	if(isdefined(param_00))
	{
		self endon(param_00);
	}

	self endon("node_relinquished");
	self endon("bad_path");
	var_02 = gettime();
	if(isdefined(param_01))
	{
		self waittill(param_01);
	}

	if(isdefined(self.var_1E14) && isdefined(self.var_C02A))
	{
		self.var_1E14 = self.var_1E14 + gettime() - var_02;
		self.var_C02A.var_2D0B = self.var_1E14 + 10000;
	}

	self notify("bot_add_ambush_time_delayed");
}

//Function Number: 11
func_2ECF(param_00,param_01,param_02,param_03)
{
	self notify("bot_watch_entrances_delayed");
	if(param_02.size > 0)
	{
		self endon("bot_watch_entrances_delayed");
		self endon("death");
		self endon("disconnect");
		self endon(param_00);
		self endon("node_relinquished");
		self endon("bad_path");
		if(isdefined(param_01))
		{
			self waittill(param_01);
		}

		self endon("path_enemy");
		childthread scripts\mp\bots\_bots_util::func_2ED4(param_02,param_03,0,self.var_1E14);
		childthread func_2E24();
	}
}

//Function Number: 12
func_2E24()
{
	self notify("bot_monitor_watch_entrances_camp");
	self endon("bot_monitor_watch_entrances_camp");
	self notify("bot_monitor_watch_entrances");
	self endon("bot_monitor_watch_entrances");
	self endon("disconnect");
	self endon("death");
	while(!isdefined(self.var_1395E))
	{
		wait(0.05);
	}

	while(isdefined(self.var_1395E))
	{
		foreach(var_01 in self.var_1395E)
		{
			var_01.var_1395D[self.var_6640] = 1;
		}

		scripts\mp\bots\_bots_strategy::func_D924(0.5);
		wait(randomfloatrange(0.5,0.75));
	}
}

//Function Number: 13
func_2D73(param_00,param_01)
{
	self endon("disconnect");
	var_02 = [];
	var_03 = findentrances(param_00.origin);
	if(isdefined(var_03) && var_03.size > 0)
	{
		wait(0.05);
		var_04 = param_00.type != "Cover Stand" && param_00.type != "Conceal Stand";
		if(var_04 && param_01)
		{
			var_03 = self method_8045(var_03,"node_exposure_vis",param_00.origin,"crouch");
		}

		foreach(var_06 in var_03)
		{
			if(distancesquared(self.origin,var_06.origin) < 90000)
			{
				continue;
			}

			if(var_04 && param_01)
			{
				wait(0.05);
				if(!scripts\mp\bots\_bots_util::func_6655(var_06.origin,param_00.origin,"crouch"))
				{
					continue;
				}
			}

			var_02[var_02.size] = var_06;
		}
	}

	return var_02;
}

//Function Number: 14
func_2D71(param_00)
{
	var_01 = [];
	var_02 = gettime();
	var_03 = param_00.size;
	for(var_04 = 0;var_04 < var_03;var_04++)
	{
		var_05 = param_00[var_04];
		if(!isdefined(var_05.var_2D0B) || var_02 > var_05.var_2D0B)
		{
			var_01[var_01.size] = var_05;
		}
	}

	return var_01;
}

//Function Number: 15
func_2D72(param_00,param_01,param_02)
{
	var_03 = [];
	var_04 = [];
	var_05 = param_02 * param_02;
	if(level.teambased)
	{
		foreach(var_07 in level.var_C928)
		{
			if(!scripts\mp\_utility::func_9F19(var_07))
			{
				continue;
			}

			if(!isdefined(var_07.team))
			{
				continue;
			}

			if(var_07.team == param_01.team && var_07 != param_01 && isdefined(var_07.var_C02A))
			{
				var_04[var_04.size] = var_07.var_C02A.origin;
			}
		}
	}

	var_09 = var_04.size;
	var_0A = param_00.size;
	for(var_0B = 0;var_0B < var_0A;var_0B++)
	{
		var_0C = 0;
		var_0D = param_00[var_0B];
		for(var_0E = 0;!var_0C && var_0E < var_09;var_0E++)
		{
			var_0F = distancesquared(var_04[var_0E],var_0D.origin);
			var_0C = var_0F < var_05;
		}

		if(!var_0C)
		{
			var_03[var_03.size] = var_0D;
		}
	}

	return var_03;
}

//Function Number: 16
func_413A()
{
	self notify("clear_camper_data");
	if(isdefined(self.var_C02A) && isdefined(self.var_C02A.var_2D0B))
	{
		self.var_C02A.var_2D0B = undefined;
	}

	self.var_C02A = undefined;
	self.var_D63C = undefined;
	self.var_1E2A = undefined;
	self.var_1E16 = undefined;
	self.var_1E12 = randomintrange(20000,30000);
	self.var_1E14 = -1;
}

//Function Number: 17
func_FF87()
{
	if(scripts\mp\bots\_bots_strategy::func_2DC5())
	{
		return 0;
	}

	if(gettime() > self.var_1E14)
	{
		return 1;
	}

	if(!self bothasscriptgoal())
	{
		return 1;
	}

	return 0;
}

//Function Number: 18
func_6C7E()
{
	self notify("find_camp_node");
	self endon("find_camp_node");
	return scripts\mp\bots\_bots_util::func_2E58("find_camp_node_worker",::func_6C7F);
}

//Function Number: 19
func_6C7F()
{
	self notify("find_camp_node_worker");
	self endon("find_camp_node_worker");
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	func_413A();
	if(level.var_13FBD <= 0)
	{
		return 0;
	}

	var_00 = getzonenearest(self.origin);
	var_01 = undefined;
	var_02 = undefined;
	var_03 = self.angles;
	if(isdefined(var_00))
	{
		var_04 = botzonenearestcount(var_00,self.team,-1,"enemy_predict",">",0,"ally","<",1);
		if(!isdefined(var_04))
		{
			var_04 = botzonenearestcount(var_00,self.team,-1,"enemy_predict",">",0);
		}

		if(!isdefined(var_04))
		{
			var_05 = -1;
			var_06 = -1;
			for(var_07 = 0;var_07 < level.var_13FBD;var_07++)
			{
				var_08 = distance2dsquared(getzoneorigin(var_07),self.origin);
				if(var_08 > var_05)
				{
					var_05 = var_08;
					var_06 = var_07;
				}
			}

			var_04 = var_06;
		}

		var_09 = function_00F2(var_00,var_04);
		if(isdefined(var_09) && var_09.size > 0)
		{
			for(var_0A = 0;var_0A <= int(var_09.size / 2);var_0A++)
			{
				var_01 = var_09[var_0A];
				var_02 = var_09[int(min(var_0A + 1,var_09.size - 1))];
				if(botzonegetcount(var_02,self.team,"enemy_predict") != 0)
				{
					break;
				}
			}

			if(isdefined(var_01) && isdefined(var_02) && var_01 != var_02)
			{
				var_03 = getzoneorigin(var_02) - getzoneorigin(var_01);
				var_03 = vectortoangles(var_03);
			}
		}
	}

	var_0B = undefined;
	if(isdefined(var_01))
	{
		var_0C = 1;
		var_0D = 1;
		var_0E = 0;
		while(var_0C)
		{
			var_0F = function_00F0(var_01,800 * var_0D,1);
			if(var_0F.size > 1024)
			{
				var_0F = function_00EF(var_01,0);
			}

			wait(0.05);
			var_10 = randomint(100);
			if(var_10 < 66 && var_10 >= 33)
			{
				var_03 = (var_03[0],var_03[1] + 45,0);
			}
			else if(var_10 < 33)
			{
				var_03 = (var_03[0],var_03[1] - 45,0);
			}

			if(var_0F.size > 0)
			{
				var_11 = int(min(max(1,var_0F.size * 0.15),5));
				if(var_0E)
				{
					var_0F = self botnodepickmultiple(var_0F,var_11,var_11,"node_camp",anglestoforward(var_03),"lenient");
				}
				else
				{
					var_0F = self botnodepickmultiple(var_0F,var_11,var_11,"node_camp",anglestoforward(var_03));
				}

				var_0F = func_2D71(var_0F);
				if(!isdefined(self.var_3802) || !self.var_3802)
				{
					var_12 = 800;
					var_0F = func_2D72(var_0F,self,var_12);
				}

				if(var_0F.size > 0)
				{
					var_0B = scripts\common\utility::func_DCA4(var_0F);
				}
			}

			if(isdefined(var_0B))
			{
				var_0C = 0;
				continue;
			}

			if(isdefined(self.var_37EF))
			{
				if(var_0D == 1 && !var_0E)
				{
					var_0D = 3;
				}
				else if(var_0D == 3 && !var_0E)
				{
					var_0E = 1;
				}
				else if(var_0D == 3 && var_0E)
				{
					var_0C = 0;
				}

				continue;
			}

			var_0C = 0;
			if(var_0C)
			{
				wait(0.05);
			}
		}
	}

	if(!isdefined(var_0B) || !self method_8042(var_0B))
	{
		return 0;
	}

	self.var_C02A = var_0B;
	self.var_1E14 = gettime() + self.var_1E12;
	self.var_C02A.var_2D0B = self.var_1E14;
	self.var_1E2A = var_03[1];
	return 1;
}

//Function Number: 20
func_6C77(param_00,param_01)
{
	func_413A();
	if(isdefined(param_00))
	{
		self.var_D63C = param_00;
	}
	else
	{
		var_02 = undefined;
		var_03 = getnodesinradius(self.origin,5000,0,2000);
		if(var_03.size > 0)
		{
			var_02 = self botnodepick(var_03,var_03.size * 0.25,"node_traffic");
		}

		if(isdefined(var_02))
		{
			self.var_D63C = var_02.origin;
		}
		else
		{
			return 0;
		}
	}

	var_04 = 2000;
	if(isdefined(param_01))
	{
		var_04 = param_01;
	}

	var_05 = getnodesinradius(self.var_D63C,var_04,0,1000);
	var_06 = undefined;
	if(var_05.size > 0)
	{
		var_07 = int(max(1,int(var_05.size * 0.15)));
		var_05 = self botnodepickmultiple(var_05,var_07,var_07,"node_ambush",self.var_D63C);
	}

	var_05 = func_2D71(var_05);
	if(var_05.size > 0)
	{
		var_06 = scripts\common\utility::func_DCA4(var_05);
	}

	if(!isdefined(var_06) || !self method_8042(var_06))
	{
		return 0;
	}

	self.var_C02A = var_06;
	self.var_1E14 = gettime() + self.var_1E12;
	self.var_C02A.var_2D0B = self.var_1E14;
	var_08 = vectornormalize(self.var_D63C - self.var_C02A.origin);
	var_09 = vectortoangles(var_08);
	self.var_1E2A = var_09[1];
	return 1;
}

//Function Number: 21
func_2E5C()
{
	if(scripts\mp\bots\_bots_util::func_2DE0())
	{
		return 0;
	}

	var_00 = level.var_2E5E[self.team];
	return self [[ var_00 ]]();
}

//Function Number: 22
func_2E5D()
{
	var_00 = 0;
	var_01 = 50;
	if(self.var_CA79 == "camper")
	{
		var_01 = 0;
	}

	var_02 = undefined;
	if(randomint(100) < var_01)
	{
		var_02 = scripts\mp\bots\_bots_util::func_2E62();
	}

	if(!isdefined(var_02))
	{
		var_03 = self method_8029();
		if(isdefined(var_03))
		{
			var_02 = var_03.origin;
		}
	}

	if(isdefined(var_02))
	{
		var_00 = self botsetscriptgoal(var_02,128,"hunt");
	}

	return var_00;
}

//Function Number: 23
func_2E88()
{
	if(scripts\mp\bots\_bots_loadout::func_2E89())
	{
		return "callback";
	}

	return "class0";
}