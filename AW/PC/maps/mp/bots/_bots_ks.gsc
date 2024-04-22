/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: mp\bots\_bots_ks.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 35
 * Decompile Time: 521 ms
 * Timestamp: 4/22/2024 2:08:49 AM
*******************************************************************/

//Function Number: 1
bot_killstreak_setup()
{
	var_00 = gettime();
	if(!isdefined(level.killstreak_botfunc))
	{
		thread bot_setup_map_specific_killstreaks();
		bot_register_killstreak_func("uav",::bot_killstreak_simple_use);
		bot_register_killstreak_func("orbital_carepackage",::bot_killstreak_simple_use);
		bot_register_killstreak_func("heavy_exosuit",::bot_killstreak_simple_use);
		bot_register_killstreak_func("nuke",::bot_killstreak_simple_use);
		bot_register_killstreak_func("emp",::bot_killstreak_simple_use,::bot_can_use_emp);
		bot_register_killstreak_func("remote_mg_sentry_turret",::maps\mp\bots\_bots_sentry::bot_killstreak_sentry,::maps\mp\bots\_bots_sentry::bot_can_use_sentry_only_ai_version,"turret");
		bot_register_killstreak_func("assault_ugv",::bot_killstreak_simple_use,::bot_can_use_assault_ugv_only_ai_version);
		bot_register_killstreak_func("warbird",::bot_killstreak_simple_use,::bot_can_use_warbird_only_ai_version);
		bot_register_killstreak_func("strafing_run_airstrike",::bot_killstreak_choose_loc_enemies,::bot_can_use_strafing_run);
		bot_register_killstreak_func("orbitalsupport",::bot_killstreak_never_use,::bot_killstreak_do_not_use);
		bot_register_killstreak_func("recon_ugv",::bot_killstreak_never_use,::bot_killstreak_do_not_use);
		bot_register_killstreak_func("orbital_strike_laser",::bot_killstreak_never_use,::bot_killstreak_do_not_use);
		bot_register_killstreak_func("missile_strike",::bot_killstreak_never_use,::bot_killstreak_do_not_use);
	}

	thread maps\mp\bots\_bots_ks_remote_vehicle::remote_vehicle_setup();
}

//Function Number: 2
bot_setup_map_specific_killstreaks()
{
	wait(0.5);
	if(isdefined(level.mapcustombotkillstreakfunc))
	{
		[[ level.mapcustombotkillstreakfunc ]]();
		return;
	}

	if(isdefined(level.mapkillstreak))
	{
		bot_register_killstreak_func(level.mapkillstreak,::bot_killstreak_never_use,::bot_killstreak_do_not_use);
	}
}

//Function Number: 3
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

//Function Number: 4
bot_is_valid_killstreak(param_00,param_01)
{
	if(bot_killstreak_is_valid_internal(param_00,"bots",undefined))
	{
		return 1;
	}
	else if(param_01)
	{
	}

	return 0;
}

//Function Number: 5
bot_killstreak_is_valid_internal(param_00,param_01,param_02)
{
	if(!bot_killstreak_is_valid_single(param_00,param_01))
	{
		return 0;
	}

	return 1;
}

//Function Number: 6
bot_killstreak_is_valid_single(param_00,param_01)
{
	if(param_01 == "humans")
	{
		return isdefined(level.killstreakfuncs[param_00]) && maps\mp\_utility::getkillstreakindex(param_00) != -1;
	}
	else if(param_01 == "bots")
	{
		return isdefined(level.killstreak_botfunc[param_00]);
	}
}

//Function Number: 7
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
		if(maps\mp\bots\_bots_util::bot_allowed_to_use_killstreaks())
		{
			var_00 = self.pers["killstreaks"];
			if(isdefined(var_00))
			{
				var_01 = 0;
				for(var_02 = 0;var_02 < var_00.size && !var_01;var_02++)
				{
					var_03 = var_00[var_02];
					if(isdefined(var_03.streakname) && isdefined(self.bot_killstreak_wait) && isdefined(self.bot_killstreak_wait[var_03.streakname]) && gettime() < self.bot_killstreak_wait[var_03.streakname])
					{
						continue;
					}

					if(var_03.available)
					{
						var_04 = var_03.streakname;
						var_03.weapon = maps\mp\_utility::getkillstreakweapon(var_03.streakname,var_03.modules);
						var_05 = level.killstreak_botcanuse[var_04];
						if(isdefined(var_05) && !self [[ var_05 ]](var_03))
						{
							continue;
						}

						if(!maps\mp\_utility::validateusestreak(var_03.streakname,1))
						{
							continue;
						}

						var_06 = level.killstreak_botfunc[var_04];
						if(isdefined(var_06))
						{
							var_07 = self [[ var_06 ]](var_03,var_00,var_05,level.killstreak_botparm[var_03.streakname]);
							if(!isdefined(var_07) || var_07 == 0)
							{
								if(!isdefined(self.bot_killstreak_wait))
								{
									self.bot_killstreak_wait = [];
								}

								self.bot_killstreak_wait[var_03.streakname] = gettime() + 5000;
							}
						}
						else
						{
							var_03.available = 0;
							maps\mp\killstreaks\_killstreaks::updatekillstreaks(0);
						}

						var_01 = 1;
					}
				}
			}
		}

		wait(randomfloatrange(2,4));
	}
}

//Function Number: 8
bot_killstreak_never_use()
{
}

//Function Number: 9
bot_killstreak_do_not_use(param_00)
{
	return 0;
}

//Function Number: 10
bot_killstreak_can_use_weapon_version(param_00)
{
	return param_00.weapon == "killstreak_uav_mp";
}

//Function Number: 11
bot_can_use_warbird_only_ai_version(param_00)
{
	if(!bot_killstreak_can_use_weapon_version(param_00))
	{
		return 0;
	}

	if(!bot_can_use_warbird(param_00))
	{
		return 0;
	}

	return 1;
}

//Function Number: 12
bot_can_use_warbird(param_00)
{
	if(!maps\mp\killstreaks\_warbird::canusewarbird())
	{
		return 0;
	}

	if(vehicle_would_exceed_limit())
	{
		return 0;
	}

	return 1;
}

//Function Number: 13
bot_can_use_assault_ugv_only_ai_version(param_00)
{
	if(!bot_killstreak_can_use_weapon_version(param_00))
	{
		return 0;
	}

	if(!bot_can_use_assault_ugv(param_00))
	{
		return 0;
	}

	return 1;
}

//Function Number: 14
bot_can_use_assault_ugv(param_00)
{
	if(vehicle_would_exceed_limit())
	{
		return 0;
	}

	return 1;
}

//Function Number: 15
vehicle_would_exceed_limit()
{
	return maps\mp\_utility::currentactivevehiclecount() >= maps\mp\_utility::maxvehiclesallowed() || level.fauxvehiclecount + 1 >= maps\mp\_utility::maxvehiclesallowed();
}

//Function Number: 16
bot_can_use_emp(param_00)
{
	if(isdefined(level.empplayer))
	{
		return 0;
	}

	var_01 = level.otherteam[self.team];
	if(isdefined(level.teamemped) && isdefined(level.teamemped[var_01]) && level.teamemped[var_01])
	{
		return 0;
	}

	return 1;
}

//Function Number: 17
bot_can_use_strafing_run(param_00)
{
	if(isdefined(level.strafing_run_airstrike))
	{
		return 0;
	}

	return 1;
}

//Function Number: 18
bot_killstreak_simple_use(param_00,param_01,param_02,param_03)
{
	wait(randomintrange(3,5));
	if(!maps\mp\bots\_bots_util::bot_allowed_to_use_killstreaks())
	{
		return 1;
	}

	if(isdefined(param_02) && !self [[ param_02 ]](param_00))
	{
		return 0;
	}

	bot_switch_to_killstreak_weapon(param_00,param_01,param_00.weapon);
	return 1;
}

//Function Number: 19
bot_killstreak_drop_anywhere(param_00,param_01,param_02,param_03)
{
	bot_killstreak_drop(param_00,param_01,param_02,param_03,"anywhere");
}

//Function Number: 20
bot_killstreak_drop_outside(param_00,param_01,param_02,param_03)
{
	bot_killstreak_drop(param_00,param_01,param_02,param_03,"outside");
}

//Function Number: 21
bot_killstreak_drop_hidden(param_00,param_01,param_02,param_03)
{
	bot_killstreak_drop(param_00,param_01,param_02,param_03,"hidden");
}

//Function Number: 22
bot_killstreak_drop(param_00,param_01,param_02,param_03,param_04)
{
	wait(randomintrange(2,4));
	if(!isdefined(param_04))
	{
		param_04 = "anywhere";
	}

	if(!maps\mp\bots\_bots_util::bot_allowed_to_use_killstreaks())
	{
		return 1;
	}

	if(isdefined(param_02) && !self [[ param_02 ]](param_00))
	{
		return 0;
	}

	var_05 = self getweaponammoclip(param_00.weapon) + self setweaponammostock(param_00.weapon);
	if(var_05 == 0)
	{
		foreach(var_07 in param_01)
		{
			if(isdefined(var_07.streakname) && var_07.streakname == param_00.streakname)
			{
				var_07.available = 0;
			}
		}

		maps\mp\killstreaks\_killstreaks::updatekillstreaks(0);
		return 1;
	}

	var_09 = undefined;
	if(var_07 == "outside")
	{
		var_0A = [];
		var_0B = maps\mp\bots\_bots_util::bot_get_nodes_in_cone(0,750,0.6,1);
		foreach(var_0D in var_0B)
		{
			if(nodeexposedtosky(var_0D))
			{
				var_0A = common_scripts\utility::array_add(var_0A,var_0D);
			}
		}

		if(var_0B.size > 5 && var_0A.size > var_0B.size * 0.6)
		{
			var_0F = common_scripts\utility::get_array_of_closest(self.origin,var_0A,undefined,undefined,undefined,150);
			if(var_0F.size > 0)
			{
				var_09 = common_scripts\utility::random(var_0F);
			}
			else
			{
				var_09 = common_scripts\utility::random(var_0A);
			}
		}
	}
	else if(var_07 == "hidden")
	{
		var_10 = getnodesinradius(self.origin,256,0,40);
		var_11 = self getnearestnode();
		if(isdefined(var_11))
		{
			var_12 = [];
			foreach(var_0D in var_10)
			{
				if(nodesvisible(var_11,var_0D,1))
				{
					var_12 = common_scripts\utility::array_add(var_12,var_0D);
				}
			}

			var_09 = self botnodepick(var_12,1,"node_hide");
		}
	}

	if(isdefined(var_09) || var_07 == "anywhere")
	{
		self botsetflag("disable_movement",1);
		if(isdefined(var_09))
		{
			self botlookatpoint(var_09.origin,2.45,"script_forced");
		}

		bot_switch_to_killstreak_weapon(param_03,param_04,param_03.weapon);
		wait(2);
		self botpressbutton("attack");
		wait(1.5);
		self switchtoweapon("none");
		self botsetflag("disable_movement",0);
	}

	return 1;
}

//Function Number: 23
bot_switch_to_killstreak_weapon(param_00,param_01,param_02)
{
	bot_notify_streak_used(param_00,param_01);
	wait(0.05);
	self switchtoweapon(param_02);
}

//Function Number: 24
bot_notify_streak_used(param_00,param_01)
{
	if(isdefined(param_00.isgimme) && param_00.isgimme)
	{
		self notify("streakUsed1");
		return;
	}

	for(var_02 = 0;var_02 < 3;var_02++)
	{
		if(isdefined(param_01[var_02].streakname))
		{
			if(param_01[var_02].streakname == param_00.streakname)
			{
				break;
			}
		}
	}

	self notify("streakUsed" + var_02 + 1);
}

//Function Number: 25
bot_killstreak_choose_loc_enemies(param_00,param_01,param_02,param_03)
{
	wait(randomintrange(3,5));
	if(!maps\mp\bots\_bots_util::bot_allowed_to_use_killstreaks())
	{
		return;
	}

	var_04 = getzonenearest(self.origin);
	if(!isdefined(var_04))
	{
		return;
	}

	self botsetflag("disable_movement",1);
	bot_switch_to_killstreak_weapon(param_00,param_01,param_00.weapon);
	wait(2);
	if(!isdefined(self.selectinglocation))
	{
		return;
	}

	var_05 = level.zonecount;
	var_06 = -1;
	var_07 = 0;
	var_08 = [];
	var_09 = randomfloat(100) > 50;
	for(var_0A = 0;var_0A < var_05;var_0A++)
	{
		if(var_09)
		{
			var_0B = var_05 - 1 - var_0A;
		}
		else
		{
			var_0B = var_0A;
		}

		if(var_0B != var_04 && botzonegetindoorpercent(var_0B) < 0.25)
		{
			var_0C = botzonegetcount(var_0B,self.team,"enemy_predict");
			if(var_0C > var_07)
			{
				var_06 = var_0B;
				var_07 = var_0C;
			}

			var_08 = common_scripts\utility::array_add(var_08,var_0B);
		}
	}

	if(var_06 >= 0)
	{
		var_0D = getzoneorigin(var_06);
	}
	else if(var_09.size > 0)
	{
		var_0D = getzoneorigin(common_scripts\utility::random(var_09));
	}
	else
	{
		var_0D = getzoneorigin(randomint(level.zonecount));
	}

	var_0E = (randomfloatrange(-500,500),randomfloatrange(-500,500),0);
	var_0F = 1;
	while(var_0F)
	{
		self notify("confirm_location",var_0D + var_0E,randomintrange(0,360));
		var_10 = common_scripts\utility::waittill_any_return("location_selection_complete","airstrikeShowBlockedHUD");
		if(var_10 == "location_selection_complete")
		{
			var_0F = 0;
			continue;
		}

		wait(0.5);
	}

	wait(1);
	self botsetflag("disable_movement",0);
}

//Function Number: 26
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
		var_03 = get_enemy_warbird(self.team);
		if(isdefined(var_03))
		{
			var_02 = 1;
			if(!bot_is_monitoring_aerial_danger(var_03))
			{
				childthread monitor_aerial_danger(var_03);
			}
		}

		if(enemy_paladin_exists(self.team))
		{
			var_02 = 1;
			if(!bot_is_monitoring_aerial_danger(level.orbitalsupport_planemodel))
			{
				childthread monitor_aerial_danger(level.orbitalsupport_planemodel);
			}
		}

		if(enemy_orbital_laser_exists(self.team))
		{
			try_place_global_badplace("orbital_laser",::enemy_orbital_laser_exists);
			var_02 = 1;
		}

		if(enemy_missile_strike_exists(self.team))
		{
			try_place_global_badplace("missile_strike",::enemy_missile_strike_exists);
			var_02 = 1;
		}

		if(enemy_strafing_run_exists(self.team))
		{
			try_place_global_badplace("missile_strike",::enemy_strafing_run_exists);
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

//Function Number: 27
bot_is_monitoring_aerial_danger(param_00)
{
	if(!isdefined(self.aerial_dangers_monitoring))
	{
		return 0;
	}

	return common_scripts\utility::array_contains(self.aerial_dangers_monitoring,param_00);
}

//Function Number: 28
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

//Function Number: 29
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

//Function Number: 30
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

//Function Number: 31
get_enemy_warbird(param_00)
{
	if(isdefined(level.spawnedwarbirds))
	{
		foreach(var_02 in level.spawnedwarbirds)
		{
			if(!level.teambased || var_02.team != param_00)
			{
				return var_02;
			}
		}
	}

	return undefined;
}

//Function Number: 32
enemy_orbital_laser_exists(param_00)
{
	if(isdefined(level.orbital_lasers))
	{
		foreach(var_02 in level.orbital_lasers)
		{
			if(!level.teambased || var_02.team != param_00)
			{
				return 1;
			}
		}
	}

	return 0;
}

//Function Number: 33
enemy_paladin_exists(param_00)
{
	if(level.orbitalsupportinuse)
	{
		if(isdefined(level.orbitalsupport_planemodel) && isdefined(level.orbitalsupport_planemodel.owner))
		{
			if(!level.teambased || level.orbitalsupport_planemodel.owner.team != param_00)
			{
				return 1;
			}
		}
	}

	return 0;
}

//Function Number: 34
enemy_missile_strike_exists(param_00)
{
	if(isdefined(level.remotemissileinprogress))
	{
		foreach(var_02 in level.rockets)
		{
			if(var_02.type == "remote" && var_02.team != param_00)
			{
				return 1;
			}
		}
	}

	return 0;
}

//Function Number: 35
enemy_strafing_run_exists(param_00)
{
	if(isdefined(level.artillerydangercenters))
	{
		foreach(var_02 in level.artillerydangercenters)
		{
			if(maps\mp\_utility::isstrstart(var_02.streakname,"strafing_run_airstrike") && var_02.team != param_00)
			{
				return 1;
			}
		}
	}

	return 0;
}