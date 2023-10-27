/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\bots\_bots_ks.gsc
 * Game: Call of Duty: Ghosts
 * Platform: PC
 * Function Count: 31
 * Decompile Time: 577 ms
 * Timestamp: 10/27/2023 1:17:28 AM
*******************************************************************/

//Function Number: 1
bot_killstreak_setup()
{
	if(!isdefined(level.killstreak_botfunc))
	{
		bot_register_killstreak_func("ball_drone_backup",::bot_killstreak_simple_use,::bot_can_use_ball_drone);
		bot_register_killstreak_func("ball_drone_radar",::bot_killstreak_simple_use,::bot_can_use_ball_drone);
		bot_register_killstreak_func("guard_dog",::bot_killstreak_simple_use);
		bot_register_killstreak_func("recon_agent",::bot_killstreak_simple_use);
		bot_register_killstreak_func("agent",::bot_killstreak_simple_use);
		bot_register_killstreak_func("nuke",::bot_killstreak_simple_use);
		bot_register_killstreak_func("jammer",::bot_killstreak_simple_use,::func_158A);
		bot_register_killstreak_func("air_superiority",::bot_killstreak_simple_use,::bot_can_use_air_superiority);
		bot_register_killstreak_func("helicopter",::bot_killstreak_simple_use,::aerial_vehicle_allowed);
		bot_register_killstreak_func("specialist",::bot_killstreak_simple_use);
		bot_register_killstreak_func("all_perks_bonus",::bot_killstreak_simple_use);
		bot_register_killstreak_func("airdrop_juggernaut",::bot_killstreak_drop_outside);
		bot_register_killstreak_func("airdrop_juggernaut_maniac",::bot_killstreak_drop_outside);
		bot_register_killstreak_func("airdrop_juggernaut_recon",::bot_killstreak_drop_outside);
		bot_register_killstreak_func("uav_3dping",::bot_killstreak_drop_outside);
		bot_register_killstreak_func("deployable_vest",::func_1608);
		bot_register_killstreak_func("deployable_ammo",::func_1608);
		bot_register_killstreak_func("odin_assault",::maps/mp/bots/_bots_ks_remote_vehicle::bot_killstreak_remote_control,::aerial_vehicle_allowed,::maps/mp/bots/_bots_ks_remote_vehicle::func_159A);
		bot_register_killstreak_func("odin_support",::maps/mp/bots/_bots_ks_remote_vehicle::bot_killstreak_remote_control,::aerial_vehicle_allowed,::maps/mp/bots/_bots_ks_remote_vehicle::func_159B);
		bot_register_killstreak_func("heli_pilot",::maps/mp/bots/_bots_ks_remote_vehicle::bot_killstreak_remote_control,::maps/mp/bots/_bots_ks_remote_vehicle::func_40FC,::maps/mp/bots/_bots_ks_remote_vehicle::bot_control_heli_pilot);
		bot_register_killstreak_func("heli_sniper",::maps/mp/bots/_bots_ks_remote_vehicle::bot_killstreak_remote_control,::maps/mp/bots/_bots_ks_remote_vehicle::func_410C,::maps/mp/bots/_bots_ks_remote_vehicle::bot_control_heli_sniper);
		bot_register_killstreak_func("drone_hive",::maps/mp/bots/_bots_ks_remote_vehicle::bot_killstreak_remote_control,undefined,::maps/mp/bots/_bots_ks_remote_vehicle::func_159C);
		bot_register_killstreak_func("vanguard",::maps/mp/bots/_bots_ks_remote_vehicle::func_1618,::maps/mp/bots/_bots_ks_remote_vehicle::func_881F,::maps/mp/bots/_bots_ks_remote_vehicle::bot_control_vanguard);
		bot_register_killstreak_func("ims",::maps/mp/bots/_bots_sentry::bot_killstreak_sentry,undefined,"trap");
		bot_register_killstreak_func("sentry",::maps/mp/bots/_bots_sentry::bot_killstreak_sentry,undefined,"turret");
		bot_register_killstreak_func("uplink",::maps/mp/bots/_bots_sentry::bot_killstreak_sentry,undefined,"hide_nonlethal");
		bot_register_killstreak_func("uplink_support",::maps/mp/bots/_bots_sentry::bot_killstreak_sentry,undefined,"hide_nonlethal");
		bot_register_killstreak_func("aa_launcher",::bot_killstreak_never_use,::bot_can_use_aa_launcher);
		bot_register_killstreak_func("airdrop_assault",::bot_killstreak_drop_outside);
		if(isdefined(level.mapcustombotkillstreakfunc))
		{
			[[ level.mapcustombotkillstreakfunc ]]();
		}
	}

	thread maps/mp/bots/_bots_ks_remote_vehicle::func_64D4();
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
bot_killstreak_valid_for_specific_streaktype(param_00,param_01,param_02)
{
	if(maps\mp\_utility::bot_is_fireteam_mode())
	{
		return 1;
	}

	if(bot_killstreak_is_valid_internal(param_00,"bots",undefined,param_01))
	{
		return 1;
	}
	else if(param_02)
	{
	}

	return 0;
}

//Function Number: 4
bot_killstreak_is_valid_internal(param_00,param_01,param_02,param_03)
{
	var_04 = undefined;
	if(param_00 == "specialist")
	{
		return 1;
	}

	if(!func_1611(param_00,param_01))
	{
		return 0;
	}

	if(isdefined(param_03))
	{
		var_04 = getsubstr(param_03,11);
		switch(var_04)
		{
			case "assault":
				if(!maps\mp\_utility::isassaultkillstreak(param_00))
				{
					return 0;
				}
				break;

			case "support":
				if(!maps\mp\_utility::issupportkillstreak(param_00))
				{
					return 0;
				}
				break;

			case "specialist":
				if(!maps\mp\_utility::func_496B(param_00))
				{
					return 0;
				}
				break;
		}
	}

	return 1;
}

//Function Number: 5
func_1611(param_00,param_01)
{
	if(param_01 == "humans")
	{
		return isdefined(level.killstreakfuncs[param_00]) && maps\mp\_utility::func_3AFB(param_00) != -1;
	}
	else if(param_01 == "bots")
	{
		return isdefined(level.killstreak_botfunc[param_00]);
	}
}

//Function Number: 6
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

	childthread bot_start_aa_launcher_tracking();
	for(;;)
	{
		if(maps/mp/bots/_bots_util::bot_allowed_to_use_killstreaks())
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
						if(var_03.streakname == "all_perks_bonus")
						{
							continue;
						}

						if(maps\mp\_utility::func_496B(var_03.streakname))
						{
							if(!var_03.earned)
							{
								var_04 = "specialist";
							}
							else
							{
								continue;
							}
						}

						var_03.weapon = maps\mp\_utility::getkillstreakweapon(var_03.streakname);
						var_05 = level.killstreak_botcanuse[var_04];
						if(isdefined(var_05) && !self [[ var_05 ]]())
						{
							continue;
						}

						if(!maps\mp\_utility::func_8818(var_03.streakname,1))
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
							maps\mp\killstreaks\_killstreaks::func_86F7(0);
						}

						var_01 = 1;
					}
				}
			}
		}

		wait(randomfloatrange(1,2));
	}
}

//Function Number: 7
bot_can_use_aa_launcher()
{
	return 0;
}

//Function Number: 8
bot_start_aa_launcher_tracking()
{
	var_00 = lib_05E9::func_3A08();
	for(;;)
	{
		self waittill("aa_launcher_fire");
		var_01 = self getammocount(var_00);
		if(var_01 == 0)
		{
			self switchtoweapon(var_00);
			var_02 = common_scripts\utility::func_8B33("LGM_player_allMissilesDestroyed","enemy");
			wait(0.5);
			self switchtoweapon("none");
		}
	}
}

//Function Number: 9
bot_killstreak_never_use()
{
}

//Function Number: 10
bot_can_use_air_superiority()
{
	if(!aerial_vehicle_allowed())
	{
		return 0;
	}

	var_00 = maps\mp\killstreaks\_air_superiority::findalltargets(self,self.team);
	var_01 = gettime();
	foreach(var_03 in var_00)
	{
		if(var_01 - var_03.birthtime > 5000)
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 11
aerial_vehicle_allowed()
{
	if(maps\mp\_utility::isairdenied())
	{
		return 0;
	}

	if(func_894B())
	{
		return 0;
	}

	return 1;
}

//Function Number: 12
func_894B()
{
	return maps\mp\_utility::func_21E7() >= maps\mp\_utility::maxvehiclesallowed() || level.fauxvehiclecount + 1 >= maps\mp\_utility::maxvehiclesallowed();
}

//Function Number: 13
func_158A()
{
	if(isdefined(level.empplayer))
	{
		return 0;
	}

	var_00 = level.otherteam[self.team];
	if(isdefined(level.teamemped) && isdefined(level.teamemped[var_00]) && level.teamemped[var_00])
	{
		return 0;
	}

	return 1;
}

//Function Number: 14
bot_can_use_ball_drone()
{
	if(maps\mp\_utility::func_4995())
	{
		return 0;
	}

	if(lib_05F3::exceededmaxballdrones())
	{
		return 0;
	}

	if(func_894B())
	{
		return 0;
	}

	if(isdefined(self.balldrone))
	{
		return 0;
	}

	return 1;
}

//Function Number: 15
bot_killstreak_simple_use(param_00,param_01,param_02,param_03)
{
	self endon("commander_took_over");
	wait(randomintrange(3,5));
	if(!maps/mp/bots/_bots_util::bot_allowed_to_use_killstreaks())
	{
		return 1;
	}

	if(isdefined(param_02) && !self [[ param_02 ]]())
	{
		return 0;
	}

	bot_switch_to_killstreak_weapon(param_00,param_01,param_00.weapon);
	return 1;
}

//Function Number: 16
func_1608(param_00,param_01,param_02,param_03)
{
	bot_killstreak_drop(param_00,param_01,param_02,param_03,"anywhere");
}

//Function Number: 17
bot_killstreak_drop_outside(param_00,param_01,param_02,param_03)
{
	bot_killstreak_drop(param_00,param_01,param_02,param_03,"outside");
}

//Function Number: 18
bot_killstreak_drop_hidden(param_00,param_01,param_02,param_03)
{
	bot_killstreak_drop(param_00,param_01,param_02,param_03,"hidden");
}

//Function Number: 19
bot_killstreak_drop(param_00,param_01,param_02,param_03,param_04)
{
	self endon("commander_took_over");
	wait(randomintrange(2,4));
	if(!isdefined(param_04))
	{
		param_04 = "anywhere";
	}

	if(!maps/mp/bots/_bots_util::bot_allowed_to_use_killstreaks())
	{
		return 1;
	}

	if(isdefined(param_02) && !self [[ param_02 ]]())
	{
		return 0;
	}

	var_05 = self getweaponammoclip(param_00.weapon) + self getweaponammostock(param_00.weapon);
	if(var_05 == 0)
	{
		foreach(var_07 in param_01)
		{
			if(isdefined(var_07.streakname) && var_07.streakname == param_00.streakname)
			{
				var_07.available = 0;
			}
		}

		maps\mp\killstreaks\_killstreaks::func_86F7(0);
		return 1;
	}

	var_09 = undefined;
	if(var_07 == "outside")
	{
		var_0A = [];
		var_0B = maps/mp/bots/_bots_util::bot_get_nodes_in_cone(750,0.6,1);
		foreach(var_0D in var_0B)
		{
			if(nodeexposedtosky(var_0D))
			{
				var_0A = common_scripts\utility::array_add(var_0A,var_0D);
			}
		}

		if(var_0B.size > 5 && var_0A.size > var_0B.size * 0.6)
		{
			var_0F = common_scripts\utility::func_37D5(self.origin,var_0A,undefined,undefined,undefined,150);
			if(var_0F.size > 0)
			{
				var_09 = common_scripts\utility::func_6306(var_0F);
			}
			else
			{
				var_09 = common_scripts\utility::func_6306(var_0A);
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

//Function Number: 20
bot_switch_to_killstreak_weapon(param_00,param_01,param_02)
{
	bot_notify_streak_used(param_00,param_01);
	wait(0.05);
	self switchtoweapon(param_02);
}

//Function Number: 21
bot_notify_streak_used(param_00,param_01)
{
	if(isdefined(param_00.isgimme) && param_00.isgimme)
	{
		self notify("streakUsed1");
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

//Function Number: 22
bot_killstreak_choose_loc_enemies(param_00,param_01,param_02,param_03)
{
	self endon("commander_took_over");
	wait(randomintrange(3,5));
	if(!maps/mp/bots/_bots_util::bot_allowed_to_use_killstreaks())
	{
	}

	var_04 = getzonenearest(self.origin);
	if(!isdefined(var_04))
	{
	}

	self botsetflag("disable_movement",1);
	bot_switch_to_killstreak_weapon(param_00,param_01,param_00.weapon);
	wait(2);
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
		var_0D = getzoneorigin(common_scripts\utility::func_6306(var_09));
	}
	else
	{
		var_0D = getzoneorigin(randomint(level.zonecount));
	}

	var_0E = (randomfloatrange(-500,500),randomfloatrange(-500,500),0);
	self notify("confirm_location",var_0D + var_0E,randomintrange(0,360));
	wait(1);
	self botsetflag("disable_movement",0);
}

//Function Number: 23
func_16B4()
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

	level.killstreak_global_bp_exists_for["allies"] = [];
	level.killstreak_global_bp_exists_for["axis"] = [];
	var_00 = 0;
	var_01 = randomfloatrange(0.05,4);
	for(;;)
	{
		wait(var_01);
		var_01 = randomfloatrange(0.05,4);
		if(maps/mp/bots/_bots_util::bot_is_remote_or_linked())
		{
			continue;
		}

		if(self botgetdifficultysetting("strategyLevel") == 0)
		{
			continue;
		}

		var_02 = 0;
		if(isdefined(level.chopper) && level.chopper.team != self.team)
		{
			var_02 = 1;
		}

		if(isdefined(level.lbsniper) && level.lbsniper.team != self.team)
		{
			var_02 = 1;
		}

		if(isdefined(level.heli_pilot[common_scripts\utility::func_386F(self.team)]))
		{
			var_02 = 1;
		}

		if(enemy_mortar_strike_exists(self.team))
		{
			var_02 = 1;
			func_83E9("mortar_strike",::enemy_mortar_strike_exists);
		}

		if(enemy_switchblade_exists(self.team))
		{
			var_02 = 1;
			func_83E9("switchblade",::enemy_switchblade_exists);
		}

		if(enemy_odin_assault_exists(self.team))
		{
			var_02 = 1;
			func_83E9("odin_assault",::enemy_odin_assault_exists);
		}

		var_03 = func_3870();
		if(isdefined(var_03))
		{
			var_04 = self geteye();
			if(common_scripts\utility::func_8E18(var_04,self getplayerangles(),var_03.attackarrow.origin,self botgetfovdot()))
			{
				if(sighttracepassed(var_04,var_03.attackarrow.origin,0,self,var_03.attackarrow))
				{
					badplace_cylinder("vanguard_" + var_03 getentitynumber(),var_01 + 0.5,var_03.attackarrow.origin,200,100,self.team);
				}
			}
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
	}
}

//Function Number: 24
func_83E9(param_00,param_01)
{
	if(!isdefined(level.killstreak_global_bp_exists_for[self.team][param_00]))
	{
		level.killstreak_global_bp_exists_for[self.team][param_00] = 0;
	}

	if(!level.killstreak_global_bp_exists_for[self.team][param_00])
	{
		level.killstreak_global_bp_exists_for[self.team][param_00] = 1;
		level thread func_5344(self.team,param_00,param_01);
	}
}

//Function Number: 25
func_5344(param_00,param_01,param_02)
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

//Function Number: 26
enemy_mortar_strike_exists(param_00)
{
	if(isdefined(level.air_raid_active) && level.air_raid_active)
	{
		if(param_00 != level.air_raid_team_called)
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 27
enemy_switchblade_exists(param_00)
{
	if(isdefined(level.remotemissileinprogress))
	{
		foreach(var_02 in level.rockets)
		{
			if(isdefined(var_02.type) && var_02.type == "remote" && var_02.team != param_00)
			{
				return 1;
			}
		}
	}

	return 0;
}

//Function Number: 28
enemy_odin_assault_exists(param_00)
{
	foreach(var_02 in level.players)
	{
		if(!level.teambased || isdefined(var_02.team) && param_00 != var_02.team)
		{
			if(isdefined(var_02.odin) && var_02.odin.odintype == "odin_assault" && gettime() - var_02.odin.birthtime > 3000)
			{
				return 1;
			}
		}
	}

	return 0;
}

//Function Number: 29
func_3870()
{
	foreach(var_01 in level.players)
	{
		if(!level.teambased || isdefined(var_01.team) && self.team != var_01.team)
		{
			if(isdefined(var_01.remoteuav) && var_01.remoteuav.helitype == "remote_uav")
			{
				return var_01.remoteuav;
			}
		}
	}

	return undefined;
}

//Function Number: 30
iskillstreakblockedforbots(param_00)
{
	return isdefined(level.botblockedkillstreaks) && isdefined(level.botblockedkillstreaks[param_00]) && level.botblockedkillstreaks[param_00];
}

//Function Number: 31
blockkillstreakforbots(param_00)
{
	level.botblockedkillstreaks[param_00] = 1;
}