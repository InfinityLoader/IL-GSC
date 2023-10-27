/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\bots\_bots_ks.gsc
 * Game: Call of Duty: Modern Warfare Remastered
 * Platform: PC
 * Function Count: 19
 * Decompile Time: 297 ms
 * Timestamp: 10/27/2023 2:37:25 AM
*******************************************************************/

//Function Number: 1
bot_killstreak_setup()
{
	var_00 = gettime();
	if(!isdefined(level.killstreak_botfunc))
	{
		bot_register_killstreak_func("radar_mp",::bot_killstreak_simple_use,::bot_can_use_uav);
		bot_register_killstreak_func("airstrike_mp",::bot_killstreak_choose_loc_enemies,::bot_can_use_airstrike);
		bot_register_killstreak_func("helicopter_mp",::bot_killstreak_simple_use,::bot_can_use_helicopter);
	}
}

//Function Number: 2
bot_register_killstreak_func(param_00,param_01,param_02,param_03)
{
	if(!isdefined(level.killstreak_botfunc))
	{
		level.killstreak_botfunc = [];
	}

	level.killstreak_botfunc[param_00] = param_01;
	if(!isdefined(level.killstreak_botcanuse))
	{
		level.killstreak_botcanuse = [];
	}

	level.killstreak_botcanuse[param_00] = param_02;
	if(!isdefined(level.killstreak_botparm))
	{
		level.killstreak_botparm = [];
	}

	level.killstreak_botparm[param_00] = param_03;
	if(!isdefined(level.bot_supported_killstreaks))
	{
		level.bot_supported_killstreaks = [];
	}

	level.bot_supported_killstreaks[level.bot_supported_killstreaks.size] = param_00;
}

//Function Number: 3
bot_think_killstreak()
{
	self notify("bot_think_killstreak");
	self endon("bot_think_killstreak");
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	while(!isdefined(level.killstreak_botfunc))
	{
		wait(0.05);
	}

	for(;;)
	{
		wait(randomfloatrange(2,4));
		if(maps\mp\bots\_bots_util::bot_allowed_to_use_killstreaks())
		{
			var_00 = self.pers["hardPointItem"];
			if(isdefined(var_00))
			{
				if(isdefined(self.bot_killstreak_wait) && isdefined(self.bot_killstreak_wait[var_00]) && gettime() < self.bot_killstreak_wait[var_00])
				{
					continue;
				}

				var_01 = level.killstreak_botcanuse[var_00];
				if(isdefined(var_01) && !self [[ var_01 ]](var_00))
				{
					continue;
				}

				var_02 = level.killstreak_botfunc[var_00];
				if(isdefined(var_02))
				{
					var_03 = self [[ var_02 ]](var_00,var_01);
					if(!isdefined(var_03) || var_03 == 0)
					{
						if(!isdefined(self.bot_killstreak_wait))
						{
							self.bot_killstreak_wait = [];
						}

						self.bot_killstreak_wait[var_00] = gettime() + 5000;
					}
				}
				else
				{
				}
			}
		}
	}
}

//Function Number: 4
bot_killstreak_never_use()
{
}

//Function Number: 5
bot_killstreak_do_not_use(param_00)
{
	return 0;
}

//Function Number: 6
bot_can_use_uav(param_00)
{
	if(!maps\mp\gametypes\_hardpoints::playerhasuavactive())
	{
		return 1;
	}

	return 0;
}

//Function Number: 7
bot_can_use_airstrike(param_00)
{
	if(isdefined(level.airstrikeinprogress))
	{
		return 0;
	}

	return 1;
}

//Function Number: 8
bot_can_use_helicopter(param_00)
{
	if(isdefined(level.chopper))
	{
		return 0;
	}

	return 1;
}

//Function Number: 9
bot_killstreak_simple_use(param_00,param_01)
{
	wait(randomintrange(3,5));
	if(!maps\mp\bots\_bots_util::bot_allowed_to_use_killstreaks())
	{
		return 1;
	}

	if(isdefined(param_01) && !self [[ param_01 ]](param_00))
	{
		return 0;
	}

	bot_switch_to_killstreak_weapon(param_00);
	return 1;
}

//Function Number: 10
bot_switch_to_killstreak_weapon(param_00)
{
	self switchtoweapon(param_00);
}

//Function Number: 11
bot_killstreak_get_zone_enemies()
{
	var_00 = [];
	foreach(var_02 in level.players)
	{
		if(!isalliedsentient(self,var_02) && isalive(var_02))
		{
			var_00[var_00.size] = var_02;
		}
	}

	var_04 = [];
	for(var_05 = 0;var_05 < level.zonecount;var_05++)
	{
		var_04[var_05] = [];
	}

	foreach(var_07 in var_00)
	{
		var_08 = var_07 getnearestnode();
		if(!isdefined(var_08))
		{
			var_09 = getnodesinradiussorted(var_07.origin,256,0);
			if(var_09.size > 0)
			{
				var_08 = var_09[0];
			}
		}

		if(isdefined(var_08))
		{
			var_0A = getnodezone(var_08);
			var_04[var_0A] = common_scripts\utility::array_add(var_04[var_0A],var_07);
		}
	}

	return var_04;
}

//Function Number: 12
bot_killstreak_choose_loc_enemies(param_00,param_01)
{
	wait(randomintrange(3,5));
	if(!maps\mp\bots\_bots_util::bot_allowed_to_use_killstreaks())
	{
		return;
	}

	var_02 = getzonenearest(self.origin);
	if(!isdefined(var_02))
	{
		return;
	}

	if(isdefined(param_01) && !self [[ param_01 ]](param_00))
	{
		return 0;
	}

	self botsetflag("disable_movement",1);
	bot_switch_to_killstreak_weapon(param_00);
	wait(2);
	if(!isdefined(self.selectinglocation))
	{
		self botsetflag("disable_movement",0);
		return;
	}

	var_03 = abs(level.bot_map_center[0] - level.bot_map_min_x);
	var_04 = abs(level.bot_map_center[0] - level.bot_map_max_x);
	var_05 = abs(level.bot_map_center[1] - level.bot_map_min_y);
	var_06 = abs(level.bot_map_center[1] - level.bot_map_max_y);
	var_07 = var_03 + var_04 + var_05 + var_06 / 4;
	var_08 = bot_killstreak_get_zone_enemies();
	var_09 = [];
	var_0A = [];
	for(var_0B = 0;var_0B < level.zonecount;var_0B++)
	{
		if(var_0B != var_02 && botzonegetindoorpercent(var_0B) < 0.25)
		{
			var_0C = spawnstruct();
			var_0C.zonenum = var_0B;
			var_0C.disttomapcenter = distance(level.bot_map_center,getzoneorigin(var_0B));
			var_0D = [];
			var_0E = var_08[var_0B];
			foreach(var_10 in var_0E)
			{
				if(maps\mp\gametypes\_hardpoints::playerhasuavactive())
				{
					var_0D[var_0D.size] = var_10;
					continue;
				}

				if(isdefined(var_10.lastshotfiredtime) && gettime() - var_10.lastshotfiredtime < 1500)
				{
					if(!function_02FB(var_10 getcurrentweapon()))
					{
						var_0D[var_0D.size] = var_10;
					}
				}
			}

			var_0C.enemieslist = var_0D;
			if(var_0D.size > 0)
			{
				var_09[var_09.size] = var_0C;
			}

			var_0A[var_0A.size] = var_0C;
		}
	}

	foreach(var_13 in var_0A)
	{
		var_14 = var_13.enemieslist.size * 100;
		var_15 = clamp(1 - var_13.disttomapcenter / var_07,0,1);
		var_14 = var_14 + var_15 * 100;
		var_13.weight = var_14;
	}

	var_17 = var_09;
	if(var_17.size == 0)
	{
		var_17 = var_0A;
	}

	var_18 = 0;
	foreach(var_13 in var_17)
	{
		var_18 = var_18 + var_13.weight;
	}

	if(var_18 > 0)
	{
		var_1B = randomfloat(var_18);
		var_1C = undefined;
		for(var_1D = 0;var_1B >= 0;var_1D++)
		{
			var_1C = var_17[var_1D];
			var_1B = var_1B - var_1C.weight;
		}

		var_0E = var_1C.enemieslist;
		var_1E = getzoneorigin(var_1C.zonenum);
		foreach(var_10 in var_0E)
		{
			var_1E = var_1E + var_10.origin;
		}

		var_1E = var_1E / var_0E.size + 1;
		var_21 = undefined;
		var_22 = getnodesinradiussorted(var_1E,256,0);
		if(var_22.size > 0)
		{
			var_21 = self botnodepick(var_22,var_22.size * 0.25,"node_traffic");
			var_23 = var_22[0].origin;
		}

		if(isdefined(var_21))
		{
			var_23 = var_21.origin;
		}
		else
		{
			var_23 = var_1E;
		}
	}
	else
	{
		var_23 = getzoneorigin(randomint(level.zonecount));
	}

	self notify("confirm_location",var_23);
	self waittill("stop_location_selection");
	wait(1);
	self botsetflag("disable_movement",0);
}

//Function Number: 13
bot_think_watch_aerial_killstreak()
{
	self notify("bot_think_watch_aerial_killstreak");
	self endon("bot_think_watch_aerial_killstreak");
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	if(!isdefined(level.last_global_badplace_time))
	{
		level.last_global_badplace_time = -10000;
	}

	if(!isdefined(level.killstreak_global_bp_exists_for))
	{
		level.killstreak_global_bp_exists_for["allies"] = [];
		level.killstreak_global_bp_exists_for["axis"] = [];
	}

	if(!isdefined(level.aerial_danger_exists_for))
	{
		level.aerial_danger_exists_for["allies"] = 0;
		level.aerial_danger_exists_for["axis"] = 0;
	}

	var_00 = 0;
	var_01 = randomfloatrange(0.05,4);
	for(;;)
	{
		wait(var_01);
		var_01 = randomfloatrange(0.05,4);
		if(maps\mp\bots\_bots_util::bot_is_remote_or_linked())
		{
			continue;
		}

		if(self botgetdifficultysetting("strategyLevel") == 0)
		{
			continue;
		}

		var_02 = 0;
		var_03 = get_enemy_helicopter(self.team);
		if(isdefined(var_03))
		{
			var_02 = 1;
			if(!bot_is_monitoring_aerial_danger(var_03))
			{
				childthread monitor_aerial_danger(var_03);
			}
		}

		if(enemy_airstrike_exists(self.team))
		{
			if(level.teambased)
			{
				try_place_global_badplace("airstrike",::enemy_airstrike_exists);
			}

			var_02 = 1;
		}

		if(!var_00 && var_02)
		{
			var_00 = 1;
			self botsetflag("hide_indoors",1);
		}

		if(var_00 && !var_02)
		{
			var_00 = 0;
			self botsetflag("hide_indoors",0);
		}

		level.aerial_danger_exists_for[self.team] = var_02;
	}
}

//Function Number: 14
bot_is_monitoring_aerial_danger(param_00)
{
	if(!isdefined(self.aerial_dangers_monitoring))
	{
		return 0;
	}

	return common_scripts\utility::array_contains(self.aerial_dangers_monitoring,param_00);
}

//Function Number: 15
monitor_aerial_danger(param_00)
{
	if(!isdefined(self.aerial_dangers_monitoring))
	{
		self.aerial_dangers_monitoring = [];
	}

	self.aerial_dangers_monitoring[self.aerial_dangers_monitoring.size] = param_00;
	var_01 = vectornormalize(param_00.origin - self.origin * (1,1,0));
	while(isalive(param_00))
	{
		var_02 = vectornormalize(param_00.origin - self.origin * (1,1,0));
		var_03 = vectordot(var_01,var_02);
		if(var_03 <= 0)
		{
			var_01 = var_02;
			self notify("defend_force_node_recalculation");
		}

		wait(0.05);
	}

	self.aerial_dangers_monitoring = common_scripts\utility::array_remove(self.aerial_dangers_monitoring,param_00);
}

//Function Number: 16
try_place_global_badplace(param_00,param_01)
{
	if(!isdefined(level.killstreak_global_bp_exists_for[self.team][param_00]))
	{
		level.killstreak_global_bp_exists_for[self.team][param_00] = 0;
	}

	if(!level.killstreak_global_bp_exists_for[self.team][param_00])
	{
		level.killstreak_global_bp_exists_for[self.team][param_00] = 1;
		level thread monitor_enemy_dangerous_killstreak(self.team,param_00,param_01);
	}
}

//Function Number: 17
monitor_enemy_dangerous_killstreak(param_00,param_01,param_02)
{
	var_03 = 0.5;
	while([[ param_02 ]](param_00))
	{
		if(gettime() > level.last_global_badplace_time + 4000)
		{
			badplace_global("",5,param_00,"only_sky");
			level.last_global_badplace_time = gettime();
		}

		wait(var_03);
	}

	level.killstreak_global_bp_exists_for[param_00][param_01] = 0;
}

//Function Number: 18
get_enemy_helicopter(param_00)
{
	if(isdefined(level.chopper))
	{
		if(level.teambased)
		{
			if(level.chopper.team != param_00)
			{
				return level.chopper;
			}
		}
		else if(level.chopper.owner != self)
		{
			return level.chopper;
		}
	}

	return undefined;
}

//Function Number: 19
enemy_airstrike_exists(param_00)
{
	if(isdefined(level.artillerydangercenters))
	{
		foreach(var_02 in level.artillerydangercenters)
		{
			if(level.teambased)
			{
				if(var_02.team != param_00)
				{
					return 1;
				}

				continue;
			}

			return 1;
		}
	}

	return 0;
}