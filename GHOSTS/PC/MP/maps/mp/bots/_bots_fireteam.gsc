/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\bots\_bots_fireteam.gsc
 * Game: Call of Duty: Ghosts
 * Platform: PC
 * Function Count: 25
 * Decompile Time: 462 ms
 * Timestamp: 10/27/2023 1:17:07 AM
*******************************************************************/

//Function Number: 1
bot_fireteam_setup_callbacks()
{
}

//Function Number: 2
func_15D3()
{
	level.bots_fireteam_num_classes_loaded = [];
	level thread func_15D0();
}

//Function Number: 3
func_15D0()
{
	self notify("bot_connect_monitor");
	self endon("bot_connect_monitor");
	level.bots_fireteam_humans = [];
	for(;;)
	{
		foreach(var_01 in level.players)
		{
			if(!isbot(var_01) && !isdefined(var_01.processed_for_fireteam))
			{
				if(isdefined(var_01.team) && var_01.team == "allies" || var_01.team == "axis")
				{
					var_01.processed_for_fireteam = 1;
					level.bots_fireteam_humans[var_01.team] = var_01;
					level.bots_fireteam_num_classes_loaded[var_01.team] = 0;
					var_02 = maps/mp/bots/_bots_util::bot_get_team_limit();
					if(level.bots_fireteam_humans.size == 2)
					{
						maps/mp/bots/_bots::func_2B33(var_02 - 1,var_01.team);
					}

					maps/mp/bots/_bots::func_778F(var_02 - 1,var_01.team,::func_15D8);
					if(level.bots_fireteam_humans.size == 1)
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
							maps/mp/bots/_bots::func_778F(var_02 - 1,common_scripts\utility::func_386F(var_01.team));
						}
					}
				}
			}
		}

		wait(0.25);
	}
}

//Function Number: 4
func_15D8()
{
	self.override_class_function = ::bot_fireteam_setup_callback_class;
	self.fireteam_commander = level.bots_fireteam_humans[self.bot_team];
	thread bot_fireteam_monitor_killstreak_earned();
}

//Function Number: 5
bot_fireteam_setup_callback_class()
{
	self.classcallback = ::bot_fireteam_loadout_class_callback;
	return "callback";
}

//Function Number: 6
bot_fireteam_loadout_class_callback()
{
	if(isdefined(self.botlastloadout))
	{
		return self.botlastloadout;
	}

	self.class_num = level.bots_fireteam_num_classes_loaded[self.team];
	level.bots_fireteam_num_classes_loaded[self.team] = level.bots_fireteam_num_classes_loaded[self.team] + 1;
	if(self.class_num == 5)
	{
		self.class_num = 0;
	}

	var_00["loadoutPrimary"] = self.fireteam_commander bot_fireteam_cac_getweapon(self.class_num,0);
	var_00["loadoutPrimaryAttachment"] = self.fireteam_commander func_15CB(self.class_num,0);
	var_00["loadoutPrimaryAttachment2"] = self.fireteam_commander bot_fireteam_cac_getweaponattachmenttwo(self.class_num,0);
	var_00["loadoutPrimaryBuff"] = self.fireteam_commander bot_fireteam_cac_getweaponbuff(self.class_num,0);
	var_00["loadoutPrimaryCamo"] = self.fireteam_commander bot_fireteam_cac_getweaponcamo(self.class_num,0);
	var_00["loadoutPrimaryReticle"] = self.fireteam_commander bot_fireteam_cac_getweaponreticle(self.class_num,0);
	var_00["loadoutSecondary"] = self.fireteam_commander bot_fireteam_cac_getweapon(self.class_num,1);
	var_00["loadoutSecondaryAttachment"] = self.fireteam_commander func_15CB(self.class_num,1);
	var_00["loadoutSecondaryAttachment2"] = self.fireteam_commander bot_fireteam_cac_getweaponattachmenttwo(self.class_num,1);
	var_00["loadoutSecondaryBuff"] = self.fireteam_commander bot_fireteam_cac_getweaponbuff(self.class_num,1);
	var_00["loadoutSecondaryCamo"] = self.fireteam_commander bot_fireteam_cac_getweaponcamo(self.class_num,1);
	var_00["loadoutSecondaryReticle"] = self.fireteam_commander bot_fireteam_cac_getweaponreticle(self.class_num,1);
	var_00["loadoutEquipment"] = self.fireteam_commander bot_fireteam_cac_getprimarygrenade(self.class_num);
	var_00["loadoutOffhand"] = self.fireteam_commander bot_fireteam_cac_getsecondarygrenade(self.class_num);
	var_00["loadoutPerk1"] = self.fireteam_commander bot_fireteam_cac_getperk(self.class_num,2);
	var_00["loadoutPerk2"] = self.fireteam_commander bot_fireteam_cac_getperk(self.class_num,3);
	var_00["loadoutPerk3"] = self.fireteam_commander bot_fireteam_cac_getperk(self.class_num,4);
	var_00["loadoutStreakType"] = self.fireteam_commander bot_fireteam_cac_getperk(self.class_num,5);
	if(var_00["loadoutStreakType"] != "specialty_null")
	{
		var_01 = getsubstr(var_00["loadoutStreakType"],11) + "Streaks";
		var_00["loadoutStreak1"] = self.fireteam_commander bot_fireteam_cac_getstreak(self.class_num,var_01,0);
		if(var_00["loadoutStreak1"] == "none")
		{
			var_00["loadoutStreak1"] = undefined;
		}

		var_00["loadoutStreak2"] = self.fireteam_commander bot_fireteam_cac_getstreak(self.class_num,var_01,1);
		if(var_00["loadoutStreak2"] == "none")
		{
			var_00["loadoutStreak2"] = undefined;
		}

		var_00["loadoutStreak3"] = self.fireteam_commander bot_fireteam_cac_getstreak(self.class_num,var_01,2);
		if(var_00["loadoutStreak3"] == "none")
		{
			var_00["loadoutStreak3"] = undefined;
		}
	}

	self.botlastloadout = var_00;
	return var_00;
}

//Function Number: 7
bot_fireteam_cac_getweapon(param_00,param_01)
{
	return self getcacplayerdata(param_00,"weaponSetups",param_01,"weapon");
}

//Function Number: 8
func_15CB(param_00,param_01)
{
	return self getcacplayerdata(param_00,"weaponSetups",param_01,"attachment",0);
}

//Function Number: 9
bot_fireteam_cac_getweaponattachmenttwo(param_00,param_01)
{
	return self getcacplayerdata(param_00,"weaponSetups",param_01,"attachment",1);
}

//Function Number: 10
bot_fireteam_cac_getweaponbuff(param_00,param_01)
{
	return self getcacplayerdata(param_00,"weaponSetups",param_01,"buff");
}

//Function Number: 11
bot_fireteam_cac_getweaponcamo(param_00,param_01)
{
	return self getcacplayerdata(param_00,"weaponSetups",param_01,"camo");
}

//Function Number: 12
bot_fireteam_cac_getweaponreticle(param_00,param_01)
{
	return self getcacplayerdata(param_00,"weaponSetups",param_01,"reticle");
}

//Function Number: 13
bot_fireteam_cac_getprimarygrenade(param_00)
{
	return self getcacplayerdata(param_00,"perks",0);
}

//Function Number: 14
bot_fireteam_cac_getsecondarygrenade(param_00)
{
	return self getcacplayerdata(param_00,"perks",1);
}

//Function Number: 15
bot_fireteam_cac_getperk(param_00,param_01)
{
	return self getcacplayerdata(param_00,"perks",param_01);
}

//Function Number: 16
bot_fireteam_cac_getstreak(param_00,param_01,param_02)
{
	return self getcacplayerdata(param_00,param_01,param_02);
}

//Function Number: 17
bot_fireteam_buddy_think()
{
	var_00 = 250;
	var_01 = var_00 * var_00;
	if(!maps/mp/bots/_bots_util::bot_is_guarding_player(self.owner))
	{
		maps/mp/bots/_bots_strategy::bot_guard_player(self.owner,var_00);
	}

	if(distancesquared(self.origin,self.owner.origin) > var_01)
	{
		self botsetflag("force_sprint",1);
	}

	if(self.owner issprinting())
	{
		self botsetflag("force_sprint",1);
	}

	self botsetflag("force_sprint",0);
}

//Function Number: 18
bot_fireteam_buddy_search()
{
	self endon("buddy_cancel");
	self endon("disconnect");
	self notify("buddy_search_start");
	self endon("buddy_search_start");
	for(;;)
	{
		if(isalive(self) && !isdefined(self.bot_fireteam_follower))
		{
			if(isdefined(self.owner))
			{
				if(self.sessionstate == "playing")
				{
					if(!self.owner.connected)
					{
						self.owner.bot_fireteam_follower = undefined;
						self.owner = undefined;
					}
					else if(isdefined(level.fireteam_commander[self.team]))
					{
						if(isdefined(level.fireteam_commander[self.team].commanding_bot) && level.fireteam_commander[self.team].commanding_bot == self)
						{
							self.owner.bot_fireteam_follower = undefined;
							self.owner.owner = level.fireteam_commander[self.team];
							self.owner.personality_update_function = ::bot_fireteam_buddy_think;
							self.owner = undefined;
						}
						else if(isdefined(level.fireteam_commander[self.team].commanding_bot) && level.fireteam_commander[self.team].commanding_bot == self.owner)
						{
							self.owner.bot_fireteam_follower = undefined;
							self.owner = level.fireteam_commander[self.team];
							self.owner.bot_fireteam_follower = self;
						}
						else if(self.owner == level.fireteam_commander[self.team] && !isdefined(self.owner.commanding_bot))
						{
							self.owner.bot_fireteam_follower = undefined;
							if(isdefined(self.owner.last_commanded_bot))
							{
								self.owner = self.owner.last_commanded_bot;
								self.owner.bot_fireteam_follower = self;
							}
							else
							{
								self.owner = undefined;
							}
						}
					}
				}
				else if(isdefined(level.fireteam_commander[self.team]))
				{
					if(isdefined(level.fireteam_commander[self.team].commanding_bot) && level.fireteam_commander[self.team].commanding_bot == self)
					{
						self.owner.bot_fireteam_follower = undefined;
						self.owner.owner = level.fireteam_commander[self.team];
						self.owner.personality_update_function = ::bot_fireteam_buddy_think;
						self.owner = undefined;
					}
				}
			}

			if(self.sessionstate == "playing")
			{
				if(!isdefined(self.owner))
				{
					var_00 = [];
					foreach(var_02 in level.players)
					{
						if(var_02 != self && var_02.team == self.team)
						{
							if(isalive(var_02) && var_02.sessionstate == "playing" && !isdefined(var_02.bot_fireteam_follower) && !isdefined(var_02.owner))
							{
								var_00[var_00.size] = var_02;
							}
						}
					}

					if(var_00.size > 0)
					{
						var_04 = common_scripts\utility::func_3A56(self.origin,var_00);
						if(isdefined(var_04))
						{
							self.owner = var_04;
							self.owner.bot_fireteam_follower = self;
						}
					}
				}
			}

			if(isdefined(self.owner))
			{
				self.personality_update_function = ::bot_fireteam_buddy_think;
			}
			else
			{
				maps/mp/bots/_bots_personality::func_157C();
			}
		}

		wait(0.5);
	}
}

//Function Number: 19
fireteam_tdm_set_hunt_leader(param_00)
{
	var_01 = [];
	foreach(var_03 in level.players)
	{
		if(var_03.team == param_00)
		{
			if(var_03.connected && isalive(var_03) && var_03.sessionstate == "playing")
			{
				if(!isbot(var_03))
				{
					level.fireteam_hunt_leader[param_00] = var_03;
					return 1;
				}
				else
				{
					var_01[var_01.size] = var_03;
				}
			}
		}
	}

	if(!isdefined(level.fireteam_hunt_leader[param_00]))
	{
		if(var_01.size > 0)
		{
			if(var_01.size == 1)
			{
				level.fireteam_hunt_leader[param_00] = var_01[0];
			}
			else
			{
				level.fireteam_hunt_leader[param_00] = var_01[randomint(var_01.size)];
			}

			return 1;
		}
	}

	return 0;
}

//Function Number: 20
func_3321(param_00)
{
	level notify("hunting_party_end_" + param_00);
	level.fireteam_hunt_leader[param_00] = undefined;
	level.fireteam_hunt_target_zone[param_00] = undefined;
	level.bot_random_path_function[param_00] = ::maps/mp/bots/_bots_personality::bot_random_path_default;
}

//Function Number: 21
func_3322(param_00,param_01)
{
	var_02 = 0;
	var_03 = undefined;
	var_04 = -1;
	if(level.zonecount > 0)
	{
		for(var_05 = 0;var_05 < level.zonecount;var_05++)
		{
			var_06 = botzonegetcount(var_05,param_01,"enemy_predict");
			if(var_06 < var_02)
			{
				continue;
			}

			var_07 = undefined;
			if(var_06 == var_02)
			{
				var_07 = getzonepath(param_00,var_05);
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

//Function Number: 22
func_3320(param_00)
{
	level endon("hunting_party_end_" + param_00);
	self endon("disconnect");
	level endon("game_ended");
	if(level.zonecount <= 0)
	{
	}

	level.bot_random_path_function[param_00] = ::func_15D2;
	for(;;)
	{
		var_01 = 3;
		if(!isdefined(level.fireteam_hunt_leader[param_00]) || isbot(level.fireteam_hunt_leader[param_00]) || isdefined(level.fireteam_hunt_leader[param_00].commanding_bot))
		{
			fireteam_tdm_set_hunt_leader(param_00);
		}

		if(isdefined(level.fireteam_hunt_leader[param_00]))
		{
			var_02 = getzonenearest(level.fireteam_hunt_leader[param_00].origin);
			if(!isdefined(var_02))
			{
				wait(var_01);
				continue;
			}

			if(!isbot(level.fireteam_hunt_leader[param_00]))
			{
				if(isalive(level.fireteam_hunt_leader[param_00]) && level.fireteam_hunt_leader[param_00].sessionstate == "playing" && !isdefined(level.fireteam_hunt_leader[param_00].deathtime) || level.fireteam_hunt_leader[param_00].deathtime + 5000 < gettime())
				{
					level.fireteam_hunt_target_zone[param_00] = var_02;
					level.fireteam_hunt_next_zone_search_time[param_00] = gettime() + 1000;
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
				if(isdefined(level.fireteam_hunt_target_zone[param_00]))
				{
					var_05 = level.fireteam_hunt_target_zone[param_00];
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
					var_06 = func_3322(var_02,param_00);
					if(!var_03)
					{
						if(!isdefined(var_06) || var_06 != var_05)
						{
							if(var_05 == var_02)
							{
								var_04 = 1;
							}
							else if(gettime() > level.fireteam_hunt_next_zone_search_time[param_00])
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
							for(var_09 = 0;var_09 < level.zonecount;var_09++)
							{
								var_0A = distance2d(getzoneorigin(var_09),level.fireteam_hunt_leader[param_00].origin);
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
							if(!isdefined(level.fireteam_hunt_target_zone[param_00]) || level.fireteam_hunt_target_zone[param_00] != var_06)
							{
								foreach(var_0C in level.players)
								{
									if(isbot(var_0C) && var_0C.team == param_00)
									{
										var_0C botclearscriptgoal();
										var_0C.fireteam_hunt_goalpos = undefined;
										var_0C thread func_15D2();
									}
								}
							}

							level.fireteam_hunt_target_zone[param_00] = var_06;
							level.fireteam_hunt_next_zone_search_time[param_00] = gettime() + 12000;
						}
					}
				}
			}
		}

		wait(var_01);
	}
}

//Function Number: 23
func_15A1()
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
			if(!isdefined(self.fireteam_hunt_goalpos))
			{
			}
			else if(self.fireteam_hunt_goalpos != var_01)
			{
			}
			else
			{
			}
		}
		else if(isdefined(self.fireteam_hunt_goalpos))
		{
		}

		wait(0.05);
	}
}

//Function Number: 24
func_15D2()
{
	var_00 = 0;
	var_01 = undefined;
	if(isdefined(level.fireteam_hunt_target_zone[self.team]))
	{
		var_02 = getzonenodes(level.fireteam_hunt_target_zone[self.team],0);
		if(var_02.size <= 18)
		{
			var_02 = getzonenodes(level.fireteam_hunt_target_zone[self.team],1);
			if(var_02.size <= 18)
			{
				var_02 = getzonenodes(level.fireteam_hunt_target_zone[self.team],2);
				if(var_02.size <= 18)
				{
					var_02 = getzonenodes(level.fireteam_hunt_target_zone[self.team],3);
				}
			}
		}

		if(var_02.size <= 0)
		{
			return maps/mp/bots/_bots_personality::bot_random_path_default();
		}

		var_01 = self botnodepick(var_02,var_02.size,"node_hide");
		var_03 = 0;
		while(!isdefined(var_01) || !self botnodeavailable(var_01))
		{
			var_03++;
			if(var_03 >= 10)
			{
				return maps/mp/bots/_bots_personality::bot_random_path_default();
			}

			var_01 = var_02[randomint(var_02.size)];
		}

		var_04 = var_01.origin;
		if(isdefined(var_04))
		{
			var_05 = "guard";
			var_06 = getzonenearest(self.origin);
			if(isdefined(var_06) && var_06 == level.fireteam_hunt_target_zone[self.team])
			{
				self botsetflag("force_sprint",0);
			}
			else
			{
				self botsetflag("force_sprint",1);
			}

			var_00 = self botsetscriptgoal(var_04,128,var_05);
			self.fireteam_hunt_goalpos = var_04;
		}
	}

	if(!var_00)
	{
		return maps/mp/bots/_bots_personality::bot_random_path_default();
	}

	return var_00;
}

//Function Number: 25
bot_fireteam_monitor_killstreak_earned()
{
	level endon("game_ended");
	self endon("disconnect");
	self notify("bot_fireteam_monitor_killstreak_earned");
	self endon("bot_fireteam_monitor_killstreak_earned");
	for(;;)
	{
		self waittill("bot_killstreak_earned",var_00,var_01);
		if(maps\mp\_utility::bot_is_fireteam_mode())
		{
			if(isdefined(self) && isbot(self))
			{
				if(isdefined(self.fireteam_commander))
				{
					var_02 = undefined;
					if(isdefined(self.fireteam_commander.commanding_bot))
					{
						var_02 = self.fireteam_commander.commanding_bot;
					}
					else
					{
						var_02 = self.fireteam_commander getspectatingplayer();
					}

					if(!isdefined(var_02) || var_02 != self)
					{
						self.fireteam_commander thread maps\mp\gametypes\_hud_message::func_5F9A(var_00,self,var_01);
					}
				}
			}
		}
	}
}