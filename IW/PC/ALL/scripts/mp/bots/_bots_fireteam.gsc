/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\mp\bots\_bots_fireteam.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 24
 * Decompile Time: 1066 ms
 * Timestamp: 10/27/2023 12:27:30 AM
*******************************************************************/

//Function Number: 1
func_2D92()
{
}

//Function Number: 2
func_2D8E()
{
	level.var_2EF1 = [];
	level thread func_2D8B();
}

//Function Number: 3
func_2D8B()
{
	self notify("bot_connect_monitor");
	self endon("bot_connect_monitor");
	level.var_2EF0 = [];
	for(;;)
	{
		foreach(var_01 in level.players)
		{
			if(!isbot(var_01) && !isdefined(var_01.var_D99A))
			{
				if(isdefined(var_01.team) && var_01.team == "allies" || var_01.team == "axis")
				{
					var_01.var_D99A = 1;
					level.var_2EF0[var_01.team] = var_01;
					level.var_2EF1[var_01.team] = 0;
					var_02 = scripts\mp\bots\_bots_util::func_2DB5();
					if(level.var_2EF0.size == 2)
					{
						scripts\mp\bots\_bots::func_5CE4(var_02 - 1,var_01.team);
					}

					scripts\mp\bots\_bots::func_10656(var_02 - 1,var_01.team,::func_2D93);
					if(level.var_2EF0.size == 1)
					{
						var_03 = 0;
						foreach(var_05 in level.players)
						{
							if(isdefined(var_05) && !isbot(var_05))
							{
								var_03++;
							}
						}

						if(var_03 == 1)
						{
							scripts\mp\bots\_bots::func_10656(var_02 - 1,scripts\common\utility::func_7984(var_01.team));
						}
					}
				}
			}
		}

		wait(0.25);
	}
}

//Function Number: 4
func_2D93()
{
	self.var_C80E = ::func_2D91;
	self.var_6D88 = level.var_2EF0[self.var_2EAC];
	thread func_2D90();
}

//Function Number: 5
func_2D91()
{
	self.var_4009 = ::func_2D8F;
	return "callback";
}

//Function Number: 6
func_2D8F()
{
	if(isdefined(self.var_2EE3))
	{
		return self.var_2EE3;
	}

	self.var_4006 = level.var_2EF1[self.team];
	level.var_2EF1[self.team] = level.var_2EF1[self.team] + 1;
	if(self.var_4006 == 5)
	{
		self.var_4006 = 0;
	}

	var_00["loadoutPrimary"] = self.var_6D88 func_2D85(self.var_4006,0);
	var_00["loadoutPrimaryAttachment"] = self.var_6D88 func_2D86(self.var_4006,0);
	var_00["loadoutPrimaryAttachment2"] = self.var_6D88 func_2D87(self.var_4006,0);
	var_00["loadoutPrimaryCamo"] = self.var_6D88 func_2D89(self.var_4006,0);
	var_00["loadoutPrimaryReticle"] = self.var_6D88 func_2D8A(self.var_4006,0);
	var_00["loadoutSecondary"] = self.var_6D88 func_2D85(self.var_4006,1);
	var_00["loadoutSecondaryAttachment"] = self.var_6D88 func_2D86(self.var_4006,1);
	var_00["loadoutSecondaryAttachment2"] = self.var_6D88 func_2D87(self.var_4006,1);
	var_00["loadoutSecondaryCamo"] = self.var_6D88 func_2D89(self.var_4006,1);
	var_00["loadoutSecondaryReticle"] = self.var_6D88 func_2D8A(self.var_4006,1);
	var_00["loadoutEquipment"] = self.var_6D88 func_2D82(self.var_4006);
	var_00["loadoutOffhand"] = self.var_6D88 func_2D83(self.var_4006);
	var_00["loadoutPerk1"] = self.var_6D88 func_2D81(self.var_4006,2);
	var_00["loadoutPerk2"] = self.var_6D88 func_2D81(self.var_4006,3);
	var_00["loadoutPerk3"] = self.var_6D88 func_2D81(self.var_4006,4);
	var_00["loadoutStreakType"] = self.var_6D88 func_2D81(self.var_4006,5);
	if(var_00["loadoutStreakType"] != "specialty_null")
	{
		var_01 = getsubstr(var_00["loadoutStreakType"],11) + "Streaks";
		var_00["loadoutStreak1"] = self.var_6D88 func_2D84(self.var_4006,var_01,0);
		if(var_00["loadoutStreak1"] == "none")
		{
			var_00["loadoutStreak1"] = undefined;
		}

		var_00["loadoutStreak2"] = self.var_6D88 func_2D84(self.var_4006,var_01,1);
		if(var_00["loadoutStreak2"] == "none")
		{
			var_00["loadoutStreak2"] = undefined;
		}

		var_00["loadoutStreak3"] = self.var_6D88 func_2D84(self.var_4006,var_01,2);
		if(var_00["loadoutStreak3"] == "none")
		{
			var_00["loadoutStreak3"] = undefined;
		}
	}

	self.var_2EE3 = var_00;
	return var_00;
}

//Function Number: 7
func_2D85(param_00,param_01)
{
	return self getplayerdata(level.var_AEA6,"squadMembers",param_00,"weaponSetups",param_01,"weapon");
}

//Function Number: 8
func_2D86(param_00,param_01)
{
	return self getplayerdata(level.var_AEA6,"squadMembers",param_00,"weaponSetups",param_01,"attachment",0);
}

//Function Number: 9
func_2D87(param_00,param_01)
{
	return self getplayerdata(level.var_AEA6,"squadMembers",param_00,"weaponSetups",param_01,"attachment",1);
}

//Function Number: 10
func_2D89(param_00,param_01)
{
	return self getplayerdata(level.var_AEA6,"squadMembers",param_00,"weaponSetups",param_01,"camo");
}

//Function Number: 11
func_2D8A(param_00,param_01)
{
	return self getplayerdata(level.var_AEA6,"squadMembers",param_00,"weaponSetups",param_01,"reticle");
}

//Function Number: 12
func_2D82(param_00)
{
	return self getplayerdata(level.var_AEA6,"squadMembers",param_00,"perks",0);
}

//Function Number: 13
func_2D83(param_00)
{
	return self getplayerdata(level.var_AEA6,"squadMembers",param_00,"perks",1);
}

//Function Number: 14
func_2D81(param_00,param_01)
{
	return self getplayerdata(level.var_AEA6,"squadMembers",param_00,"perks",param_01);
}

//Function Number: 15
func_2D84(param_00,param_01,param_02)
{
	return self getplayerdata(level.var_AEA6,"squadMembers",param_00,param_01,param_02);
}

//Function Number: 16
func_2D7F()
{
	var_00 = 250;
	var_01 = var_00 * var_00;
	if(!scripts\mp\bots\_bots_util::func_2DDA(self.var_222))
	{
		scripts\mp\bots\_bots_strategy::func_2DC1(self.var_222,var_00);
	}

	if(distancesquared(self.origin,self.var_222.origin) > var_01)
	{
		self botsetflag("force_sprint",1);
		return;
	}

	if(self.var_222 method_81BD())
	{
		self botsetflag("force_sprint",1);
		return;
	}

	self botsetflag("force_sprint",0);
}

//Function Number: 17
func_2D7E()
{
	self endon("buddy_cancel");
	self endon("disconnect");
	self notify("buddy_search_start");
	self endon("buddy_search_start");
	for(;;)
	{
		if(isalive(self) && !isdefined(self.var_2D8C))
		{
			if(isdefined(self.var_222))
			{
				if(self.sessionstate == "playing")
				{
					if(!self.var_222.var_452B)
					{
						self.var_222.var_2D8C = undefined;
						self.var_222 = undefined;
					}
					else if(isdefined(level.var_6D88[self.team]))
					{
						if(isdefined(level.var_6D88[self.team].var_4447) && level.var_6D88[self.team].var_4447 == self)
						{
							self.var_222.var_2D8C = undefined;
							self.var_222.var_222 = level.var_6D88[self.team];
							self.var_222.var_CA7B = ::func_2D7F;
							self.var_222 = undefined;
						}
						else if(isdefined(level.var_6D88[self.team].var_4447) && level.var_6D88[self.team].var_4447 == self.var_222)
						{
							self.var_222.var_2D8C = undefined;
							self.var_222 = level.var_6D88[self.team];
							self.var_222.var_2D8C = self;
						}
						else if(self.var_222 == level.var_6D88[self.team] && !isdefined(self.var_222.var_4447))
						{
							self.var_222.var_2D8C = undefined;
							if(isdefined(self.var_222.var_A89D))
							{
								self.var_222 = self.var_222.var_A89D;
								self.var_222.var_2D8C = self;
							}
							else
							{
								self.var_222 = undefined;
							}
						}
					}
				}
				else if(isdefined(level.var_6D88[self.team]))
				{
					if(isdefined(level.var_6D88[self.team].var_4447) && level.var_6D88[self.team].var_4447 == self)
					{
						self.var_222.var_2D8C = undefined;
						self.var_222.var_222 = level.var_6D88[self.team];
						self.var_222.var_CA7B = ::func_2D7F;
						self.var_222 = undefined;
					}
				}
			}

			if(self.sessionstate == "playing")
			{
				if(!isdefined(self.var_222))
				{
					var_00 = [];
					foreach(var_02 in level.players)
					{
						if(var_02 != self && var_02.team == self.team)
						{
							if(isalive(var_02) && var_02.sessionstate == "playing" && !isdefined(var_02.var_2D8C) && !isdefined(var_02.var_222))
							{
								var_00[var_00.size] = var_02;
							}
						}
					}

					if(var_00.size > 0)
					{
						var_04 = scripts\common\utility::getclosest(self.origin,var_00);
						if(isdefined(var_04))
						{
							self.var_222 = var_04;
							self.var_222.var_2D8C = self;
						}
					}
				}
			}

			if(isdefined(self.var_222))
			{
				self.var_CA7B = ::func_2D7F;
			}
			else
			{
				scripts\mp\bots\_bots_personality::func_2D0C();
			}
		}

		wait(0.5);
	}
}

//Function Number: 18
func_6D94(param_00)
{
	var_01 = [];
	foreach(var_03 in level.players)
	{
		if(var_03.team == param_00)
		{
			if(var_03.var_452B && isalive(var_03) && var_03.sessionstate == "playing")
			{
				if(!isbot(var_03))
				{
					level.var_6D8C[param_00] = var_03;
					return 1;
				}
				else
				{
					var_01[var_01.size] = var_03;
				}
			}
		}
	}

	if(!isdefined(level.var_6D8C[param_00]))
	{
		if(var_01.size > 0)
		{
			if(var_01.size == 1)
			{
				level.var_6D8C[param_00] = var_01[0];
			}
			else
			{
				level.var_6D8C[param_00] = var_01[randomint(var_01.size)];
			}

			return 1;
		}
	}

	return 0;
}

//Function Number: 19
func_6D92(param_00)
{
	level notify("hunting_party_end_" + param_00);
	level.var_6D8C[param_00] = undefined;
	level.var_6D8E[param_00] = undefined;
	level.var_2E5E[param_00] = ::scripts\mp\bots\_bots_personality::func_2E5D;
}

//Function Number: 20
func_6D93(param_00,param_01)
{
	var_02 = 0;
	var_03 = undefined;
	var_04 = -1;
	if(level.var_13FBD > 0)
	{
		for(var_05 = 0;var_05 < level.var_13FBD;var_05++)
		{
			var_06 = botzonegetcount(var_05,param_01,"enemy_predict");
			if(var_06 < var_02)
			{
				continue;
			}

			var_07 = undefined;
			if(var_06 == var_02)
			{
				var_07 = function_00F2(param_00,var_05);
				if(!isdefined(var_07))
				{
					continue;
				}

				if(var_04 >= 0 && var_07.size > var_04)
				{
					continue;
				}
			}

			var_02 = var_06;
			var_03 = var_05;
			if(isdefined(var_07))
			{
				var_04 = var_07.size;
				continue;
			}

			var_04 = -1;
		}
	}

	return var_03;
}

//Function Number: 21
func_6D91(param_00)
{
	level endon("hunting_party_end_" + param_00);
	self endon("disconnect");
	level endon("game_ended");
	if(level.var_13FBD <= 0)
	{
		return;
	}

	level.var_2E5E[param_00] = ::func_2D8D;
	for(;;)
	{
		var_01 = 3;
		if(!isdefined(level.var_6D8C[param_00]) || isbot(level.var_6D8C[param_00]) || isdefined(level.var_6D8C[param_00].var_4447))
		{
			func_6D94(param_00);
		}

		if(isdefined(level.var_6D8C[param_00]))
		{
			var_02 = getzonenearest(level.var_6D8C[param_00].origin);
			if(!isdefined(var_02))
			{
				wait(var_01);
				continue;
			}

			if(!isbot(level.var_6D8C[param_00]))
			{
				if(isalive(level.var_6D8C[param_00]) && level.var_6D8C[param_00].sessionstate == "playing" && !isdefined(level.var_6D8C[param_00].var_4E72) || level.var_6D8C[param_00].var_4E72 + 5000 < gettime())
				{
					level.var_6D8E[param_00] = var_02;
					level.var_6D8D[param_00] = gettime() + 1000;
					var_01 = 0.5;
				}
				else
				{
					var_01 = 1;
				}
			}
			else
			{
				var_03 = 0;
				var_04 = 0;
				var_05 = undefined;
				if(isdefined(level.var_6D8E[param_00]))
				{
					var_05 = level.var_6D8E[param_00];
				}
				else
				{
					var_03 = 1;
					var_04 = 1;
					var_05 = var_02;
				}

				var_06 = undefined;
				if(isdefined(var_05))
				{
					var_06 = func_6D93(var_02,param_00);
					if(!var_03)
					{
						if(!isdefined(var_06) || var_06 != var_05)
						{
							if(var_05 == var_02)
							{
								var_04 = 1;
							}
							else if(gettime() > level.var_6D8D[param_00])
							{
								var_04 = 1;
							}
						}
					}

					if(var_04)
					{
						if(!isdefined(var_06))
						{
							var_07 = 0;
							var_08 = -1;
							for(var_09 = 0;var_09 < level.var_13FBD;var_09++)
							{
								var_0A = distance2d(getzoneorigin(var_09),level.var_6D8C[param_00].origin);
								if(var_0A > var_07)
								{
									var_07 = var_0A;
									var_08 = var_09;
								}
							}

							var_06 = var_08;
						}

						if(isdefined(var_06))
						{
							if(!isdefined(level.var_6D8E[param_00]) || level.var_6D8E[param_00] != var_06)
							{
								foreach(var_0C in level.players)
								{
									if(isbot(var_0C) && var_0C.team == param_00)
									{
										var_0C botclearscriptgoal();
										var_0C.var_6D8B = undefined;
										var_0C thread func_2D8D();
									}
								}
							}

							level.var_6D8E[param_00] = var_06;
							level.var_6D8D[param_00] = gettime() + 12000;
						}
					}
				}
			}
		}

		wait(var_01);
	}
}

//Function Number: 22
func_2D49()
{
	self notify("bot_debug_script_goal");
	level endon("hunting_party_end_" + self.team);
	self endon("bot_debug_script_goal");
	var_00 = 48;
	for(;;)
	{
		if(self bothasscriptgoal())
		{
			var_01 = self botgetscriptgoal();
			if(!isdefined(self.var_6D8B))
			{
			}
			else if(self.var_6D8B != var_01)
			{
			}
			else
			{
			}
		}
		else if(isdefined(self.var_6D8B))
		{
		}

		wait(0.05);
	}
}

//Function Number: 23
func_2D8D()
{
	var_00 = 0;
	var_01 = undefined;
	if(isdefined(level.var_6D8E[self.team]))
	{
		var_02 = function_00EF(level.var_6D8E[self.team],0);
		if(var_02.size <= 18)
		{
			var_02 = function_00EF(level.var_6D8E[self.team],1);
			if(var_02.size <= 18)
			{
				var_02 = function_00EF(level.var_6D8E[self.team],2);
				if(var_02.size <= 18)
				{
					var_02 = function_00EF(level.var_6D8E[self.team],3);
				}
			}
		}

		if(var_02.size <= 0)
		{
			return scripts\mp\bots\_bots_personality::func_2E5D();
		}

		var_01 = self botnodepick(var_02,var_02.size,"node_hide");
		var_03 = 0;
		while(!isdefined(var_01) || !self method_8042(var_01))
		{
			var_03++;
			if(var_03 >= 10)
			{
				return scripts\mp\bots\_bots_personality::func_2E5D();
			}

			var_01 = var_02[randomint(var_02.size)];
		}

		var_04 = var_01.origin;
		if(isdefined(var_04))
		{
			var_05 = "guard";
			var_06 = getzonenearest(self.origin);
			if(isdefined(var_06) && var_06 == level.var_6D8E[self.team])
			{
				self botsetflag("force_sprint",0);
			}
			else
			{
				self botsetflag("force_sprint",1);
			}

			var_00 = self botsetscriptgoal(var_04,128,var_05);
			self.var_6D8B = var_04;
		}
	}

	if(!var_00)
	{
		return scripts\mp\bots\_bots_personality::func_2E5D();
	}

	return var_00;
}

//Function Number: 24
func_2D90()
{
	level endon("game_ended");
	self endon("disconnect");
	self notify("bot_fireteam_monitor_killstreak_earned");
	self endon("bot_fireteam_monitor_killstreak_earned");
	for(;;)
	{
		self waittill("bot_killstreak_earned",var_00,var_01);
		if(scripts\mp\_utility::func_2DD9())
		{
			if(isdefined(self) && isbot(self))
			{
				if(isdefined(self.var_6D88))
				{
					var_02 = undefined;
					if(isdefined(self.var_6D88.var_4447))
					{
						var_02 = self.var_6D88.var_4447;
					}
					else
					{
						var_02 = self.var_6D88 method_815D();
					}

					if(!isdefined(var_02) || var_02 != self)
					{
						self.var_6D88 thread scripts\mp\_hud_message::func_10151(var_00,var_01,self);
					}
				}
			}
		}
	}
}