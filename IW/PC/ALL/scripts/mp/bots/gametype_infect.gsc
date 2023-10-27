/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\mp\bots\gametype_infect.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 10
 * Decompile Time: 536 ms
 * Timestamp: 10/27/2023 12:12:00 AM
*******************************************************************/

//Function Number: 1
main()
{
	func_F8F4();
	func_F8DD();
}

//Function Number: 2
func_F8F4()
{
	level.var_2D9E["gametype_think"] = ::func_2DCF;
	level.var_2D9E["should_pickup_weapons"] = ::func_2E91;
}

//Function Number: 3
func_F8DD()
{
	level.var_2EF2 = 1;
	level.var_2EF5 = 1;
	level.var_2EF3 = 1;
	thread func_2DCB();
}

//Function Number: 4
func_2E91()
{
	if(level.var_9410 && self.team == "axis")
	{
		return 0;
	}

	return scripts\mp\bots\_bots::func_2E90();
}

//Function Number: 5
func_2DCF()
{
	self notify("bot_infect_think");
	self endon("bot_infect_think");
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	childthread func_2DCE();
	for(;;)
	{
		if(level.var_9410)
		{
			if(self.team == "axis" && self method_8035() != "run_and_gun")
			{
				scripts\mp\bots\_bots_util::func_2E83("run_and_gun");
			}
		}

		if(self.var_2EAC != self.team)
		{
			self.var_2EAC = self.team;
		}

		if(self.team == "axis")
		{
			var_00 = scripts\mp\bots\_bots_strategy::func_2E1E();
			if(!isdefined(var_00) || var_00)
			{
				self botclearscriptgoal();
			}
		}

		self [[ self.var_CA7B ]]();
		wait(0.05);
	}
}

//Function Number: 6
func_2DCB()
{
	level notify("bot_infect_ai_director_update");
	level endon("bot_infect_ai_director_update");
	level endon("game_ended");
	for(;;)
	{
		var_00 = [];
		var_01 = [];
		foreach(var_03 in level.players)
		{
			if(!isdefined(var_03.var_982D) && var_03.health > 0 && isdefined(var_03.team) && var_03.team == "allies" || var_03.team == "axis")
			{
				var_03.var_982D = gettime();
			}

			if(isdefined(var_03.var_982D) && gettime() - var_03.var_982D > 5000)
			{
				if(!isdefined(var_03.team))
				{
					continue;
				}

				if(var_03.team == "axis")
				{
					var_00[var_00.size] = var_03;
					continue;
				}

				if(var_03.team == "allies")
				{
					var_01[var_01.size] = var_03;
				}
			}
		}

		if(var_00.size > 0 && var_01.size > 0)
		{
			var_05 = 1;
			foreach(var_07 in var_01)
			{
				if(isbot(var_07))
				{
					var_05 = 0;
				}
			}

			if(var_05)
			{
				foreach(var_03 in var_01)
				{
					if(!isdefined(var_03.var_A8D2))
					{
						var_03.var_A8D2 = gettime();
						var_03.var_A8D1 = var_03.origin;
						var_03.var_118DA = 0;
					}

					if(gettime() >= var_03.var_A8D2 + 5000)
					{
						var_03.var_A8D2 = gettime();
						var_0A = distancesquared(var_03.origin,var_03.var_A8D1);
						var_03.var_A8D1 = var_03.origin;
						if(var_0A < 90000)
						{
							var_03.var_118DA = var_03.var_118DA + 5000;
							if(var_03.var_118DA >= 20000)
							{
								var_0B = scripts\common\utility::func_782F(var_03.origin,var_00);
								foreach(var_0D in var_0B)
								{
									if(isbot(var_0D))
									{
										var_0E = var_0D botgetscriptgoaltype();
										if(var_0E != "tactical" && var_0E != "critical")
										{
											var_0D thread func_91E4(var_03);
											break;
										}
									}
								}
							}
						}
						else
						{
							var_03.var_118DA = 0;
							var_03.var_A8D1 = var_03.origin;
						}
					}
				}
			}
		}

		wait(1);
	}
}

//Function Number: 7
func_91E4(param_00)
{
	self endon("disconnect");
	self endon("death");
	self botsetscriptgoal(param_00.origin,0,"critical");
	scripts\mp\bots\_bots_util::func_2ECB();
	self botclearscriptgoal();
}

//Function Number: 8
func_2DCE()
{
	if(self.team == "axis")
	{
		self.var_3829 = 0;
		self.var_B58B = undefined;
		self.var_B58D = undefined;
		self.var_B58C = 0;
		self.var_B5B2 = undefined;
		self.var_B5B1 = 0;
		var_00 = self botgetdifficultysetting("throwKnifeChance");
		if(var_00 < 0.25)
		{
			self method_804D("throwKnifeChance",0.25);
		}

		self method_804D("allowGrenades",1);
		self botsetflag("path_traverse_wait",1);
		for(;;)
		{
			if(self hasweapon("throwingknife_mp"))
			{
				if(scripts\mp\_utility::func_9E0E(self.var_10C))
				{
					var_01 = gettime();
					if(!isdefined(self.var_B58B) || self.var_B58B != self.var_10C)
					{
						self.var_B58B = self.var_10C;
						self.var_B58D = self.var_10C getnearestnode();
						self.var_B58C = var_01;
					}
					else
					{
						var_02 = squared(self botgetdifficultysetting("meleeDist"));
						if(distancesquared(self.var_10C.origin,self.origin) <= var_02)
						{
							self.var_3829 = var_01;
						}

						var_03 = self.var_10C getnearestnode();
						var_04 = self getnearestnode();
						if(!isdefined(self.var_B58D) || self.var_B58D != var_03)
						{
							self.var_B58C = var_01;
							self.var_B58D = var_03;
						}

						if(!isdefined(self.var_B5B2) || self.var_B5B2 != var_04)
						{
							self.var_B5B1 = var_01;
							self.var_B5B2 = var_04;
						}
						else if(distancesquared(self.origin,self.var_B5B2.origin) > 9216)
						{
							self.var_B5B0 = var_01;
						}

						if(self.var_3829 + 3000 < var_01)
						{
							if(self.var_B5B1 + 3000 < var_01)
							{
								if(self.var_B58C + 3000 < var_01)
								{
									if(func_2DCC(self.origin,self.var_10C.origin))
									{
										scripts\mp\bots\_bots_util::func_2E58("find_node_can_see_ent",::func_2DCD,self.var_10C,self.var_B5B2);
									}

									if(!self method_80FB("throwingknife_mp"))
									{
										self setweaponammoclip("throwingknife_mp",1);
									}

									scripts\mp\_utility::func_136EF(30,"enemy");
									self botclearscriptgoal();
								}
							}
						}
					}
				}
			}

			wait(0.25);
		}
	}
}

//Function Number: 9
func_2DCC(param_00,param_01)
{
	if(abs(param_00[2] - param_01[2]) > 56 && distance2dsquared(param_00,param_01) < 2304)
	{
		return 1;
	}

	return 0;
}

//Function Number: 10
func_2DCD(param_00,param_01)
{
	if(!isdefined(param_00) || !isdefined(param_01))
	{
		return;
	}

	var_02 = 0;
	if(issubstr(param_01.type,"Begin"))
	{
		var_02 = 1;
	}

	var_03 = getlinkednodes(param_01);
	if(isdefined(var_03) && var_03.size)
	{
		var_04 = scripts\common\utility::array_randomize(var_03);
		foreach(var_06 in var_04)
		{
			if(var_02 && issubstr(var_06.type,"End"))
			{
				continue;
			}

			if(func_2DCC(var_06.origin,param_00.origin))
			{
				continue;
			}

			var_07 = self geteye() - self.origin;
			var_08 = var_06.origin + var_07;
			var_09 = param_00.origin;
			if(isplayer(param_00))
			{
				var_09 = param_00 scripts\mp\_utility::func_815C();
			}

			if(sighttracepassed(var_08,var_09,0,self,param_00))
			{
				var_0A = vectortoyaw(var_09 - var_08);
				self botsetscriptgoalnode(var_06,"critical",var_0A);
				scripts\mp\bots\_bots_util::func_2ECB(3);
				return;
			}

			wait(0.05);
		}
	}
}