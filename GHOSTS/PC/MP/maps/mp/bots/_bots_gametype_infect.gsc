/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\bots\_bots_gametype_infect.gsc
 * Game: Call of Duty: Ghosts
 * Platform: PC
 * Function Count: 10
 * Decompile Time: 202 ms
 * Timestamp: 10/27/2023 1:17:19 AM
*******************************************************************/

//Function Number: 1
func_4FDD()
{
	func_710C();
	func_945C();
}

//Function Number: 2
func_710C()
{
	level.bot_funcs["gametype_think"] = ::bot_infect_think;
	level.bot_funcs["should_pickup_weapons"] = ::func_9011;
}

//Function Number: 3
func_945C()
{
	level.bots_gametype_handles_class_choice = 1;
	level.bots_ignore_team_balance = 1;
	level.bots_gametype_handles_team_choice = 1;
	thread func_8FF2();
}

//Function Number: 4
func_9011()
{
	if(level.infect_chosefirstinfected && self.team == "axis")
	{
		return 0;
	}

	return maps/mp/bots/_bots::bot_should_pickup_weapons();
}

//Function Number: 5
bot_infect_think()
{
	self notify("bot_infect_think");
	self endon("bot_infect_think");
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	childthread func_8FF5();
	for(;;)
	{
		if(level.infect_chosefirstinfected)
		{
			if(self.team == "axis" && self botgetpersonality() != "run_and_gun")
			{
				maps/mp/bots/_bots_util::bot_set_personality("run_and_gun");
			}
		}

		if(self.bot_team != self.team)
		{
			self.bot_team = self.team;
		}

		if(self.team == "axis")
		{
			var_00 = maps/mp/bots/_bots_strategy::bot_melee_tactical_insertion_check();
			if(!isdefined(var_00) || var_00)
			{
				self botclearscriptgoal();
			}
		}

		self [[ self.personality_update_function ]]();
		wait(0.05);
	}
}

//Function Number: 6
func_8FF2()
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
			if(!isdefined(var_03.initial_spawn_time) && var_03.health > 0 && isdefined(var_03.team) && var_03.team == "allies" || var_03.team == "axis")
			{
				var_03.initial_spawn_time = gettime();
			}

			if(isdefined(var_03.initial_spawn_time) && gettime() - var_03.initial_spawn_time > 5000)
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
					if(!isdefined(var_03.last_infected_hiding_time))
					{
						var_03.last_infected_hiding_time = gettime();
						var_03.last_infected_hiding_loc = var_03.origin;
						var_03.time_spent_hiding = 0;
					}

					if(gettime() >= var_03.last_infected_hiding_time + 5000)
					{
						var_03.last_infected_hiding_time = gettime();
						var_0A = distancesquared(var_03.origin,var_03.last_infected_hiding_loc);
						var_03.last_infected_hiding_loc = var_03.origin;
						if(var_0A < 90000)
						{
							var_03.time_spent_hiding = var_03.time_spent_hiding + 5000;
							if(var_03.time_spent_hiding >= 20000)
							{
								var_0B = common_scripts\utility::func_37D5(var_03.origin,var_00);
								foreach(var_0D in var_0B)
								{
									if(isbot(var_0D))
									{
										var_0E = var_0D botgetscriptgoaltype();
										if(var_0E != "tactical" && var_0E != "critical")
										{
											var_0D thread func_923A(var_03);
											break;
										}
									}
								}
							}
						}
						else
						{
							var_03.time_spent_hiding = 0;
							var_03.last_infected_hiding_loc = var_03.origin;
						}
					}
				}
			}
		}

		wait(1);
	}
}

//Function Number: 7
func_923A(param_00)
{
	self endon("disconnect");
	self endon("death");
	self botsetscriptgoal(param_00.origin,0,"critical");
	maps/mp/bots/_bots_util::bot_waittill_goal_or_fail();
	self botclearscriptgoal();
}

//Function Number: 8
func_8FF5()
{
	if(self.team == "axis")
	{
		self.can_melee_enemy_time = 0;
		self.melee_enemy = undefined;
		self.melee_enemy_node = undefined;
		self.melee_enemy_new_node_time = 0;
		self.melee_self_node = undefined;
		self.melee_self_new_node_time = 0;
		var_00 = self botgetdifficultysetting("throwKnifeChance");
		if(var_00 < 0.25)
		{
			self botsetdifficultysetting("throwKnifeChance",0.25);
		}

		self botsetdifficultysetting("allowGrenades",1);
		self botsetflag("path_traverse_wait",1);
		for(;;)
		{
			if(self hasweapon("throwingknife_mp"))
			{
				if(maps\mp\_utility::func_48CE(self.enemy))
				{
					var_01 = gettime();
					if(!isdefined(self.melee_enemy) || self.melee_enemy != self.enemy)
					{
						self.melee_enemy = self.enemy;
						self.melee_enemy_node = self.enemy getnearestnode();
						self.melee_enemy_new_node_time = var_01;
					}
					else
					{
						var_02 = squared(self botgetdifficultysetting("meleeDist"));
						if(distancesquared(self.enemy.origin,self.origin) <= var_02)
						{
							self.can_melee_enemy_time = var_01;
						}

						var_03 = self.enemy getnearestnode();
						var_04 = self getnearestnode();
						if(!isdefined(self.melee_enemy_node) || self.melee_enemy_node != var_03)
						{
							self.melee_enemy_new_node_time = var_01;
							self.melee_enemy_node = var_03;
						}

						if(!isdefined(self.melee_self_node) || self.melee_self_node != var_04)
						{
							self.melee_self_new_node_time = var_01;
							self.melee_self_node = var_04;
						}
						else if(distancesquared(self.origin,self.melee_self_node.origin) > 9216)
						{
							self.melee_self_at_same_node_time = var_01;
						}

						if(self.can_melee_enemy_time + 3000 < var_01)
						{
							if(self.melee_self_new_node_time + 3000 < var_01)
							{
								if(self.melee_enemy_new_node_time + 3000 < var_01)
								{
									if(func_8FF3(self.origin,self.enemy.origin))
									{
										maps/mp/bots/_bots_util::bot_queued_process("find_node_can_see_ent",::func_8FF4,self.enemy,self.melee_self_node);
									}

									if(!self getammocount("throwingknife_mp"))
									{
										self setweaponammoclip("throwingknife_mp",1);
									}

									maps\mp\_utility::waitfortimeornotify(30,"enemy");
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
func_8FF3(param_00,param_01)
{
	if(abs(param_00[2] - param_01[2]) > 56 && distance2dsquared(param_00,param_01) < 2304)
	{
		return 1;
	}

	return 0;
}

//Function Number: 10
func_8FF4(param_00,param_01)
{
	if(!isdefined(param_00) || !isdefined(param_01))
	{
	}

	var_02 = 0;
	if(issubstr(param_01.type,"Begin"))
	{
		var_02 = 1;
	}

	var_03 = getlinkednodes(param_01);
	if(isdefined(var_03) && var_03.size)
	{
		var_04 = common_scripts\utility::array_randomize(var_03);
		foreach(var_06 in var_04)
		{
			if(var_02 && issubstr(var_06.type,"End"))
			{
				continue;
			}

			if(func_8FF3(var_06.origin,param_00.origin))
			{
				continue;
			}

			var_07 = self geteye() - self.origin;
			var_08 = var_06.origin + var_07;
			var_09 = param_00.origin;
			if(isplayer(param_00))
			{
				var_09 = param_00 maps\mp\_utility::func_3C02();
			}

			if(sighttracepassed(var_08,var_09,0,self,param_00))
			{
				var_0A = vectortoyaw(var_09 - var_08);
				self botsetscriptgoalnode(var_06,"critical",var_0A);
				maps/mp/bots/_bots_util::bot_waittill_goal_or_fail(3);
			}

			wait(0.05);
		}
	}
}