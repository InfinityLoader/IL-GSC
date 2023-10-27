/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\_friendlyfire.gsc
 * Game: Call of Duty: Ghosts
 * Platform: PC
 * Function Count: 17
 * Decompile Time: 306 ms
 * Timestamp: 10/27/2023 1:27:37 AM
*******************************************************************/

//Function Number: 1
func_4FDD()
{
	level.friendlyfire["min_participation"] = -200;
	level.friendlyfire["max_participation"] = 1000;
	level.friendlyfire["enemy_kill_points"] = 250;
	level.friendlyfire["friend_kill_points"] = -650;
	level.friendlyfire["point_loss_interval"] = 1.25;
	level.player.var_5B08 = 0;
	level.var_3580 = 0;
	level.friendlyfiredisabledfordestructible = 0;
	setdvarifuninitialized("friendlyfire_dev_disabled","0");
	common_scripts\utility::func_3385("friendly_fire_warning");
	thread debug_friendlyfire();
	thread func_5B0A();
}

//Function Number: 2
debug_friendlyfire()
{
}

//Function Number: 3
apply_friendly_fire_damage_modifier(param_00)
{
	level.friendlyfire_damage_modifier = param_00;
}

//Function Number: 4
func_6527(param_00)
{
	level.friendlyfire_damage_modifier = undefined;
}

//Function Number: 5
func_3535(param_00)
{
	if(!isdefined(param_00))
	{
	}

	if(!isdefined(param_00.team))
	{
		param_00.team = "allies";
	}

	if(isdefined(level.var_561D))
	{
	}

	level endon("mission failed");
	level thread notifydamage(param_00);
	level thread notifydamagenotdone(param_00);
	level thread func_5724(param_00);
	for(;;)
	{
		if(!isdefined(param_00))
		{
		}

		if(param_00.health <= 0)
		{
		}

		var_01 = undefined;
		var_02 = undefined;
		var_03 = undefined;
		var_04 = undefined;
		var_05 = undefined;
		var_06 = undefined;
		var_07 = undefined;
		param_00 waittill("friendlyfire_notify",var_01,var_02,var_03,var_04,var_05,var_06);
		if(!isdefined(param_00))
		{
		}

		if(!isdefined(var_02))
		{
			continue;
		}

		if(isdefined(level.friendlyfire_damage_modifier))
		{
			var_01 = var_01 * level.friendlyfire_damage_modifier;
			var_01 = int(var_01);
		}

		var_08 = 0;
		if(!isdefined(var_06))
		{
			var_06 = param_00.damageweapon;
		}

		if(isdefined(level.friendlyfire_destructible_attacker))
		{
			if(isdefined(var_02.damageowner))
			{
				var_07 = 1;
				var_02 = var_02.damageowner;
			}
		}

		if(isdefined(level.var_3576))
		{
			if(isdefined(var_02) && isdefined(var_02.owner) && var_02.owner == level.player)
			{
				var_08 = 1;
			}
		}

		if(isplayer(var_02))
		{
			var_08 = 1;
			if(isdefined(var_06) && var_06 == "none")
			{
				var_08 = 0;
			}

			if(var_02 isusingturret())
			{
				var_08 = 1;
			}

			if(isdefined(var_07))
			{
				var_08 = 1;
			}
		}
		else if(isdefined(var_02.code_classname) && var_02.code_classname == "script_vehicle")
		{
			var_09 = var_02 getvehicleowner();
			if(isdefined(var_09) && isplayer(var_09))
			{
				var_08 = 1;
			}
		}

		if(!var_08)
		{
			continue;
		}

		if(!isdefined(param_00.team))
		{
			continue;
		}

		var_0A = param_00.team == level.player.team;
		var_0B = undefined;
		if(isdefined(param_00.type) && param_00.type == "civilian")
		{
			var_0B = 1;
		}
		else
		{
			var_0B = issubstr(param_00.classname,"civilian");
		}

		var_0C = var_01 == -1;
		if(!var_0A && !var_0B)
		{
			if(var_0C)
			{
				level.player.var_5B08 = level.player.var_5B08 + level.friendlyfire["enemy_kill_points"];
				participation_point_cap();
			}

			continue;
		}

		if(isdefined(param_00.var_561D))
		{
			continue;
		}

		if(var_05 == "MOD_PROJECTILE_SPLASH" && isdefined(level.var_561E))
		{
			continue;
		}

		if(isdefined(var_06) && var_06 == "claymore")
		{
			continue;
		}

		if(var_0C)
		{
			if(isdefined(param_00.var_3515))
			{
				level.player.var_5B08 = level.player.var_5B08 + param_00.var_3515;
			}
			else
			{
				level.player.var_5B08 = level.player.var_5B08 + level.friendlyfire["friend_kill_points"];
			}
		}
		else
		{
			level.player.var_5B08 = level.player.var_5B08 - var_01;
		}

		participation_point_cap();
		if(check_grenade(param_00,var_05) && func_6AA1())
		{
			if(var_0C)
			{
			}
			else
			{
				continue;
			}
		}

		if(isdefined(level.friendly_fire_fail_check))
		{
			[[ level.friendly_fire_fail_check ]](param_00,var_01,var_02,var_03,var_04,var_05,var_06);
			continue;
		}

		func_3532(var_0B);
	}
}

//Function Number: 6
func_3532(param_00)
{
	if(isdefined(level.failonfriendlyfire) && level.failonfriendlyfire)
	{
		level thread missionfail(param_00);
	}

	var_01 = level.friendlyfiredisabledfordestructible;
	if(isdefined(level.friendlyfire_destructible_attacker) && param_00)
	{
		var_01 = 0;
	}

	if(var_01)
	{
	}

	if(level.var_3580 == 1)
	{
	}

	if(level.player.var_5B08 <= level.friendlyfire["min_participation"])
	{
		level thread missionfail(param_00);
	}
}

//Function Number: 7
check_grenade(param_00,param_01)
{
	if(!isdefined(param_00))
	{
		return 0;
	}

	var_02 = 0;
	if(isdefined(param_00.damageweapon) && param_00.damageweapon == "none")
	{
		var_02 = 1;
	}

	if(isdefined(param_01) && param_01 == "MOD_GRENADE_SPLASH")
	{
		var_02 = 1;
	}

	return var_02;
}

//Function Number: 8
func_6AA1()
{
	var_00 = gettime();
	if(var_00 < 4500)
	{
		return 1;
	}
	else if(var_00 - level.lastautosavetime < 4500)
	{
		return 1;
	}

	return 0;
}

//Function Number: 9
participation_point_cap()
{
	if(level.player.var_5B08 > level.friendlyfire["max_participation"])
	{
		level.player.var_5B08 = level.friendlyfire["max_participation"];
	}

	if(level.player.var_5B08 < level.friendlyfire["min_participation"])
	{
		level.player.var_5B08 = level.friendlyfire["min_participation"];
	}
}

//Function Number: 10
func_5B0A()
{
	level endon("mission failed");
	for(;;)
	{
		if(level.player.var_5B08 > 0)
		{
			level.player.var_5B08--;
		}
		else if(level.player.var_5B08 < 0)
		{
			level.player.var_5B08++;
		}

		wait(level.friendlyfire["point_loss_interval"]);
	}
}

//Function Number: 11
turnbackon()
{
	level.var_3580 = 0;
}

//Function Number: 12
turnoff()
{
	level.var_3580 = 1;
}

//Function Number: 13
missionfail(param_00)
{
	if(!isdefined(param_00))
	{
		param_00 = 0;
	}

	if(getdvar("friendlyfire_dev_disabled") == "1")
	{
	}

	level.player endon("death");
	if(!isalive(level.player))
	{
	}

	level endon("mine death");
	level notify("mission failed");
	level notify("friendlyfire_mission_fail");
	waittillframeend;
	setsaveddvar("hud_missionFailed",1);
	setsaveddvar("ammoCounterHide",1);
	setsaveddvar("hud_showstance",0);
	setsaveddvar("actionSlotsHide",1);
	if(isdefined(level.player.var_3164))
	{
	}

	if(param_00)
	{
		maps\_player_death::func_6E75(&"SCRIPT_MISSIONFAIL_CIVILIAN_KILLED");
	}
	else if(isdefined(level.custom_friendly_fire_message))
	{
		maps\_player_death::func_6E75(level.custom_friendly_fire_message);
	}
	else if(level.var_1973 == "british")
	{
		maps\_player_death::func_6E75(&"SCRIPT_MISSIONFAIL_KILLTEAM_BRITISH");
	}
	else if(level.var_1973 == "russian")
	{
		maps\_player_death::func_6E75(&"SCRIPT_MISSIONFAIL_KILLTEAM_RUSSIAN");
	}
	else
	{
		maps\_player_death::func_6E75(&"SCRIPT_MISSIONFAIL_KILLTEAM_AMERICAN");
	}

	if(isdefined(level.custom_friendly_fire_shader))
	{
		thread maps\_player_death::func_6E77(level.custom_friendly_fire_shader,64,64,0);
	}

	reconspatialevent(level.player.origin,"script_friendlyfire: civilian %d",param_00);
	maps\_utility::func_52F2();
}

//Function Number: 14
notifydamage(param_00)
{
	level endon("mission failed");
	param_00 endon("death");
	for(;;)
	{
		var_01 = undefined;
		var_02 = undefined;
		var_03 = undefined;
		var_04 = undefined;
		var_05 = undefined;
		var_06 = undefined;
		var_07 = undefined;
		var_08 = undefined;
		var_09 = undefined;
		var_0A = undefined;
		param_00 waittill("damage",var_01,var_02,var_03,var_04,var_05,var_06,var_07,var_08,var_09,var_0A);
		param_00 notify("friendlyfire_notify",var_01,var_02,var_03,var_04,var_05,var_0A);
	}
}

//Function Number: 15
notifydamagenotdone(param_00)
{
	level endon("mission failed");
	param_00 waittill("damage_notdone",var_01,var_02,var_03,var_04,var_05);
	param_00 notify("friendlyfire_notify",-1,var_02,undefined,undefined,var_05);
}

//Function Number: 16
func_5724(param_00)
{
	level endon("mission failed");
	param_00 waittill("death",var_01,var_02,var_03);
	param_00 notify("friendlyfire_notify",-1,var_01,undefined,undefined,var_02,var_03);
}

//Function Number: 17
detectfriendlyfireonentity(param_00)
{
}