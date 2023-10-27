/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\_friendlyfire.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: Console
 * Function Count: 15
 * Decompile Time: 251 ms
 * Timestamp: 10/27/2023 2:35:26 AM
*******************************************************************/

//Function Number: 1
main()
{
	level.friendlyfire["min_participation"] = -200;
	level.friendlyfire["max_participation"] = 1000;
	level.friendlyfire["enemy_kill_points"] = 250;
	level.friendlyfire["friend_kill_points"] = -650;
	level.friendlyfire["point_loss_interval"] = 1.25;
	level.player.participation = 0;
	level.friendlyfiredisabled = 0;
	level.friendlyfiredisabledfordestructible = 0;
	setdvarifuninitialized("friendlyfire_dev_disabled","0");
	common_scripts\utility::flag_init("friendly_fire_warning");
	thread debug_friendlyfire();
	thread participation_point_flattenovertime();
}

//Function Number: 2
debug_friendlyfire()
{
}

//Function Number: 3
friendly_fire_think(param_00)
{
	if(!isdefined(param_00))
	{
		return;
	}

	if(!isdefined(param_00.team))
	{
		param_00.team = "allies";
	}

	if(isdefined(level.no_friendly_fire_penalty))
	{
		return;
	}

	level endon("mission failed");
	level thread func_1B91(param_00);
	level thread notifydamagenotdone(param_00);
	level thread notifydeath(param_00);
	for(;;)
	{
		if(!isdefined(param_00))
		{
			return;
		}

		if(param_00.health <= 0)
		{
			return;
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
			return;
		}

		if(!isdefined(var_02))
		{
			continue;
		}

		var_08 = 0;
		if(!isdefined(var_06))
		{
			var_06 = param_00.damageweapon;
		}

		if(isdefined(level.var_80E1))
		{
			if(isdefined(var_02.damageowner))
			{
				var_07 = 1;
				var_02 = var_02.damageowner;
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
		if(level.script == "airport")
		{
			var_0B = 0;
		}
		else if(isdefined(param_00.type) && param_00.type == "civilian")
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
				level.player.participation = level.player.participation + level.friendlyfire["enemy_kill_points"];
				participation_point_cap();
				return;
			}

			continue;
		}

		if(isdefined(param_00.no_friendly_fire_penalty))
		{
			continue;
		}

		if(var_05 == "MOD_PROJECTILE_SPLASH" && isdefined(level.no_friendly_fire_splash_damage))
		{
			continue;
		}

		if(isdefined(var_06) && var_06 == "claymore")
		{
			continue;
		}

		if(var_0C)
		{
			if(isdefined(param_00.var_1B84))
			{
				level.player.participation = level.player.participation + param_00.var_1B84;
			}
			else
			{
				level.player.participation = level.player.participation + level.friendlyfire["friend_kill_points"];
			}
		}
		else
		{
			level.player.participation = level.player.participation - var_01;
		}

		participation_point_cap();
		if(func_1B88(param_00,var_05) && func_1B89())
		{
			if(var_0C)
			{
				return;
			}
			else
			{
				continue;
			}
		}

		if(isdefined(level.var_1B85))
		{
			[[ level.var_1B85 ]](param_00,var_01,var_02,var_03,var_04,var_05,var_06);
			continue;
		}

		friendly_fire_checkpoints(var_0B);
	}
}

//Function Number: 4
friendly_fire_checkpoints(param_00)
{
	if(isdefined(level.failonfriendlyfire) && level.failonfriendlyfire)
	{
		level thread func_1B8E(param_00);
		return;
	}

	var_01 = level.friendlyfiredisabledfordestructible;
	if(isdefined(level.var_80E1) && param_00)
	{
		var_01 = 0;
	}

	if(var_01)
	{
		return;
	}

	if(level.friendlyfiredisabled == 1)
	{
		return;
	}

	if(level.player.participation <= level.friendlyfire["min_participation"])
	{
		level thread func_1B8E(param_00);
	}
}

//Function Number: 5
func_1B88(param_00,param_01)
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

//Function Number: 6
func_1B89()
{
	var_00 = gettime();
	if(var_00 < 4500)
	{
		return 1;
	}
	else if(var_00 - level.var_17C9 < 4500)
	{
		return 1;
	}

	return 0;
}

//Function Number: 7
participation_point_cap()
{
	if(level.player.participation > level.friendlyfire["max_participation"])
	{
		level.player.participation = level.friendlyfire["max_participation"];
	}

	if(level.player.participation < level.friendlyfire["min_participation"])
	{
		level.player.participation = level.friendlyfire["min_participation"];
	}
}

//Function Number: 8
participation_point_flattenovertime()
{
	level endon("mission failed");
	for(;;)
	{
		if(level.player.participation > 0)
		{
			level.player.participation--;
		}
		else if(level.player.participation < 0)
		{
			level.player.participation++;
		}

		wait level.friendlyfire["point_loss_interval"];
	}
}

//Function Number: 9
turnbackon()
{
	level.friendlyfiredisabled = 0;
}

//Function Number: 10
func_1B8D()
{
	level.friendlyfiredisabled = 1;
}

//Function Number: 11
func_1B8E(param_00)
{
	if(!isdefined(param_00))
	{
		param_00 = 0;
	}

	if(level.script == "airport")
	{
		if(param_00)
		{
			return;
		}

		common_scripts\utility::flag_set("friendly_fire_warning");
		return;
	}

	if(getdvar("friendlyfire_dev_disabled") == "1")
	{
		return;
	}

	level.player endon("death");
	if(!isalive(level.player))
	{
		return;
	}

	level endon("mine death");
	level notify("mission failed");
	level notify("friendlyfire_mission_fail");
	waittillframeend;
	setsaveddvar("hud_missionFailed",1);
	if(isdefined(level.player.var_1A92))
	{
		return;
	}

	if(param_00)
	{
		setdvar("ui_deadquote",&"SCRIPT_MISSIONFAIL_CIVILIAN_KILLED");
	}
	else if(isdefined(level.custom_friendly_fire_message))
	{
		setdvar("ui_deadquote",level.custom_friendly_fire_message);
	}
	else if(level.campaign == "british")
	{
		setdvar("ui_deadquote",&"SCRIPT_MISSIONFAIL_KILLTEAM_BRITISH");
	}
	else if(level.campaign == "russian")
	{
		setdvar("ui_deadquote",&"SCRIPT_MISSIONFAIL_KILLTEAM_RUSSIAN");
	}
	else
	{
		setdvar("ui_deadquote",&"SCRIPT_MISSIONFAIL_KILLTEAM_AMERICAN");
	}

	if(isdefined(level.var_1B90))
	{
		thread maps\_load::special_death_indicator_hudelement(level.var_1B90,64,64,0);
	}

	reconspatialevent(level.player.origin,"script_friendlyfire: civilian %d",param_00);
	maps\_utility::func_13EE();
}

//Function Number: 12
func_1B91(param_00)
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

//Function Number: 13
notifydamagenotdone(param_00)
{
	level endon("mission failed");
	param_00 waittill("damage_notdone",var_01,var_02,var_03,var_04,var_05);
	param_00 notify("friendlyfire_notify",-1,var_02,undefined,undefined,var_05);
}

//Function Number: 14
notifydeath(param_00)
{
	level endon("mission failed");
	param_00 waittill("death",var_01,var_02,var_03);
	param_00 notify("friendlyfire_notify",-1,var_01,undefined,undefined,var_02,var_03);
}

//Function Number: 15
detectfriendlyfireonentity(param_00)
{
}