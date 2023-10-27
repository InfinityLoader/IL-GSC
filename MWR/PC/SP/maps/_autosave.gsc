/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\_autosave.gsc
 * Game: Call of Duty: Modern Warfare Remastered
 * Platform: PC
 * Function Count: 28
 * Decompile Time: 636 ms
 * Timestamp: 10/27/2023 2:47:16 AM
*******************************************************************/

//Function Number: 1
main()
{
	level.lastautosavetime = 0;
	level.lasttimeplayedregister = 0;
	common_scripts\utility::flag_init("game_saving");
	common_scripts\utility::flag_init("being_spotted");
	common_scripts\utility::flag_init("can_save");
	common_scripts\utility::flag_set("can_save");
	common_scripts\utility::flag_init("disable_autosaves");
	if(!isdefined(level._extra_autosave_checks))
	{
		level._extra_autosave_checks = [];
	}

	level.autosave_proximity_threat_func = ::autosave_proximity_threat_func;
}

//Function Number: 2
getdescription()
{
	return &"AUTOSAVE_AUTOSAVE";
}

//Function Number: 3
getnames(param_00)
{
	if(param_00 == 0)
	{
		var_01 = &"AUTOSAVE_GAME";
	}
	else
	{
		var_01 = &"AUTOSAVE_NOGAME";
	}

	return var_01;
}

//Function Number: 4
beginningoflevelsave()
{
	common_scripts\utility::flag_wait("introscreen_complete");
	if(isdefined(level.introscreen_complete_delay))
	{
		wait(level.introscreen_complete_delay);
	}

	if(level.missionfailed)
	{
		return;
	}

	if(maps\_arcademode::arcademode_complete())
	{
		return;
	}

	if(common_scripts\utility::flag("game_saving"))
	{
		return;
	}

	common_scripts\utility::flag_set("game_saving");
	var_00 = "levelshots / autosave / autosave_" + level.script + "start";
	savegame("levelstart",&"AUTOSAVE_LEVELSTART",var_00,1);
	setdvar("ui_grenade_death","0");
	common_scripts\utility::flag_clear("game_saving");
}

//Function Number: 5
trigger_autosave_stealth(param_00)
{
	param_00 waittill("trigger");
	maps\_utility::autosave_stealth();
}

//Function Number: 6
trigger_autosave_tactical(param_00)
{
	param_00 waittill("trigger");
	maps\_utility::autosave_tactical();
}

//Function Number: 7
trigger_autosave(param_00)
{
	if(!isdefined(param_00.script_autosave))
	{
		param_00.script_autosave = 0;
	}

	autosaves_think(param_00);
}

//Function Number: 8
autosaves_think(param_00)
{
	var_01 = getnames(param_00.script_autosave);
	if(!isdefined(var_01))
	{
		return;
	}

	param_00 waittill("trigger");
	var_02 = param_00.script_autosave;
	var_03 = "levelshots / autosave / autosave_" + level.script + var_02;
	tryautosave(var_02,var_01,var_03);
	if(isdefined(param_00))
	{
		param_00 delete();
	}
}

//Function Number: 9
autosavenamethink(param_00)
{
	if(maps\_utility::is_no_game_start())
	{
		return;
	}

	param_00 waittill("trigger");
	if(!isdefined(param_00))
	{
		return;
	}

	var_01 = param_00.script_autosavename;
	param_00 delete();
	if(isdefined(level.customautosavecheck))
	{
		if(![[ level.customautosavecheck ]]())
		{
			return;
		}
	}

	maps\_utility::autosave_by_name(var_01);
}

//Function Number: 10
trigger_autosave_immediate(param_00)
{
	param_00 waittill("trigger");
}

//Function Number: 11
autosaveprint(param_00,param_01)
{
	if(isdefined(param_01))
	{
	}
}

//Function Number: 12
autosave_timeout(param_00)
{
	level endon("trying_new_autosave");
	level endon("autosave_complete");
	wait(param_00);
	common_scripts\utility::flag_clear("game_saving");
	level notify("autosave_timeout");
}

//Function Number: 13
_autosave_game_now_nochecks()
{
	var_00 = "levelshots / autosave / autosave_" + level.script + "start";
	savegame("levelstart",&"AUTOSAVE_LEVELSTART",var_00,1);
	autosave_recon(0);
}

//Function Number: 14
_autosave_game_now_notrestart()
{
	var_00 = "levelshots / autosave / autosave_" + level.script + "start";
	if(getdvarint("g_reloading") == 0)
	{
		savegame("levelstart",&"AUTOSAVE_LEVELSTART",var_00,1);
		autosave_recon(0);
	}
}

//Function Number: 15
_autosave_game_now(param_00)
{
	if(isdefined(level.missionfailed) && level.missionfailed)
	{
		return;
	}

	if(common_scripts\utility::flag("game_saving"))
	{
		return 0;
	}

	if(maps\_arcademode::arcademode_complete())
	{
		return 0;
	}

	for(var_01 = 0;var_01 < level.players.size;var_01++)
	{
		var_02 = level.players[var_01];
		if(!isalive(var_02))
		{
			return 0;
		}
	}

	var_03 = "save_now";
	var_04 = getdescription();
	if(isdefined(param_00))
	{
		var_05 = savegamenocommit(var_03,var_04,"$default",1);
	}
	else
	{
		var_05 = savegamenocommit(var_04,var_05);
	}

	wait(0.05);
	if(issaverecentlyloaded())
	{
		level.lastautosavetime = gettime();
		level.lasttimeplayedregister = level.lastautosavetime;
		return 0;
	}

	if(var_05 < 0)
	{
		return 0;
	}

	if(!try_to_autosave_now())
	{
		return 0;
	}

	common_scripts\utility::flag_set("game_saving");
	wait(2);
	common_scripts\utility::flag_clear("game_saving");
	if(!commitwouldbevalid(var_05))
	{
		return 0;
	}

	if(try_to_autosave_now())
	{
		autosave_recon(var_05);
		if(!isdefined(param_00))
		{
			thread maps\_arcademode::arcademode_checkpoint_print();
		}

		commitsave(var_05);
		level.timeplayeddelta = gettime();
		setdvar("ui_grenade_death","0");
	}

	return 1;
}

//Function Number: 16
autosave_now_trigger(param_00)
{
	param_00 waittill("trigger");
	maps\_utility::autosave_now();
}

//Function Number: 17
try_to_autosave_now()
{
	if(!issavesuccessful())
	{
		return 0;
	}

	for(var_00 = 0;var_00 < level.players.size;var_00++)
	{
		var_01 = level.players[var_00];
		if(!var_01 autosavehealthcheck())
		{
			return 0;
		}
	}

	if(!common_scripts\utility::flag("can_save"))
	{
		return 0;
	}

	return 1;
}

//Function Number: 18
tryautosave(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	if(common_scripts\utility::flag("disable_autosaves"))
	{
		return 0;
	}

	level endon("nextmission");
	level.player endon("death");
	if(maps\_utility::is_coop())
	{
		level.player2 endon("death");
	}

	level notify("trying_new_autosave");
	if(common_scripts\utility::flag("game_saving"))
	{
		return 0;
	}

	if(isdefined(level.nextmission))
	{
		return 0;
	}

	var_07 = 1.25;
	var_08 = 1.25;
	if(isdefined(param_03) && param_03 < var_07 + var_08)
	{
	}

	if(!isdefined(param_05))
	{
		param_05 = 0;
	}

	if(!isdefined(param_02))
	{
		param_02 = "$default";
	}

	if(!isdefined(param_04))
	{
		param_04 = 0;
	}

	common_scripts\utility::flag_set("game_saving");
	var_09 = getdescription();
	var_0A = gettime();
	for(;;)
	{
		if(autosavecheck(undefined,param_04))
		{
			var_0B = savegamenocommit(param_00,var_09,param_02,param_05);
			if(var_0B < 0)
			{
				break;
			}

			wait(0.05);
			if(issaverecentlyloaded())
			{
				level.lastautosavetime = gettime();
				level.lasttimeplayedregister = level.lastautosavetime;
				break;
			}

			wait(var_07);
			if(!autosavecheck(undefined,param_04))
			{
				continue;
			}

			wait(var_08);
			if(!autosavecheck_not_picky())
			{
				continue;
			}

			if(isdefined(param_03))
			{
				if(gettime() > var_0A + param_03 * 1000)
				{
					break;
				}
			}

			if(!common_scripts\utility::flag("can_save"))
			{
				break;
			}

			if(common_scripts\utility::flag("being_spotted"))
			{
				break;
			}

			if(!commitwouldbevalid(var_0B))
			{
				common_scripts\utility::flag_clear("game_saving");
				return 0;
			}

			if(level.script == "scoutsniper" && isdefined(param_06) && param_06 == "cargo2")
			{
				if(common_scripts\utility::flag("_stealth_spotted"))
				{
					continue;
				}
			}

			autosave_recon(var_0B);
			thread maps\_arcademode::arcademode_checkpoint_print();
			commitsave(var_0B);
			maps\_utility::save_time_played();
			level.lastsavetime = gettime();
			level.lasttimeplayedregister = gettime();
			setdvar("ui_grenade_death","0");
			break;
		}

		wait(0.25);
	}

	common_scripts\utility::flag_clear("game_saving");
	return 1;
}

//Function Number: 19
extra_autosave_checks_failed()
{
	foreach(var_01 in level._extra_autosave_checks)
	{
		if(![[ var_01["func"] ]]())
		{
			autosaveprint("autosave failed: " + var_01["msg"]);
			return 1;
		}
	}

	return 0;
}

//Function Number: 20
autosavecheck_not_picky()
{
	return autosavecheck(0,0);
}

//Function Number: 21
autosavecheck(param_00,param_01)
{
	if(isdefined(level.autosave_check_override))
	{
		return [[ level.autosave_check_override ]]();
	}

	if(isdefined(level.special_autosavecondition) && ![[ level.special_autosavecondition ]]())
	{
		return 0;
	}

	if(level.missionfailed)
	{
		return 0;
	}

	if(maps\_arcademode::arcademode_complete())
	{
		return 0;
	}

	if(!isdefined(param_00))
	{
		param_00 = level.dopickyautosavechecks;
	}

	if(!isdefined(param_01))
	{
		param_01 = 0;
	}

	if(param_01)
	{
		if(![[ level.global_callbacks["_autosave_stealthcheck"] ]]())
		{
			return 0;
		}
	}

	for(var_02 = 0;var_02 < level.players.size;var_02++)
	{
		var_03 = level.players[var_02];
		if(!var_03 autosavehealthcheck())
		{
			return 0;
		}

		if(param_00 && !var_03 autosaveammocheck())
		{
			return 0;
		}
	}

	if(level.autosave_threat_check_enabled)
	{
		if(!autosavethreatcheck(param_00))
		{
			return 0;
		}
	}

	for(var_02 = 0;var_02 < level.players.size;var_02++)
	{
		var_03 = level.players[var_02];
		if(!var_03 autosaveplayercheck(param_00))
		{
			return 0;
		}
	}

	if(isdefined(level.cansave) && !level.cansave)
	{
		return 0;
	}

	if(extra_autosave_checks_failed())
	{
		return 0;
	}

	if(!issavesuccessful())
	{
		autosaveprint("autosave failed: save call was unsuccessful");
		return 0;
	}

	return 1;
}

//Function Number: 22
autosaveplayercheck(param_00)
{
	if(level.script == "ac130")
	{
		return 1;
	}

	if(isdefined(level.ac130gunner) && level.ac130gunner == self)
	{
		return 1;
	}

	if(self ismeleeing() && param_00)
	{
		autosaveprint("autosave failed:player is meleeing");
		return 0;
	}

	if(self isthrowinggrenade() && param_00)
	{
		autosaveprint("autosave failed:player is throwing a grenade");
		return 0;
	}

	if(self isfiring() && param_00)
	{
		autosaveprint("autosave failed:player is firing");
		return 0;
	}

	if(isdefined(self.shellshocked) && self.shellshocked)
	{
		autosaveprint("autosave failed:player is in shellshock");
		return 0;
	}

	if(common_scripts\utility::isflashed())
	{
		autosaveprint("autosave failed:player is flashbanged");
		return 0;
	}

	return 1;
}

//Function Number: 23
autosaveammocheck()
{
	if(isdefined(level.noautosaveammocheck) && level.noautosaveammocheck)
	{
		return 1;
	}

	if(level.script == "ac130")
	{
		return 1;
	}

	if(isdefined(level.ac130gunner) && level.ac130gunner == self)
	{
		return 1;
	}

	var_00 = self getweaponslistprimaries();
	for(var_01 = 0;var_01 < var_00.size;var_01++)
	{
		var_02 = self getfractionmaxammo(var_00[var_01]);
		if(var_02 > 0.1)
		{
			return 1;
		}
	}

	autosaveprint("autosave failed: ammo too low");
	return 0;
}

//Function Number: 24
autosavehealthcheck()
{
	if(level.script == "ac130")
	{
		return 1;
	}

	if(isdefined(level.ac130gunner) && level.ac130gunner == self)
	{
		return 1;
	}

	if(maps\_utility::ent_flag_exist("laststand_downed") && maps\_utility::ent_flag("laststand_downed"))
	{
		return 0;
	}

	var_00 = self.health / self.maxhealth;
	if(var_00 < 0.5)
	{
		return 0;
	}

	if(maps\_utility::ent_flag("_radiation_poisoning"))
	{
		return 0;
	}

	if(maps\_utility::ent_flag("player_has_red_flashing_overlay"))
	{
		return 0;
	}

	return 1;
}

//Function Number: 25
autosavethreatcheck(param_00)
{
	if(level.script == "ac130")
	{
		return 1;
	}

	if(isdefined(level.ac130gunner) && level.ac130gunner == self)
	{
		return 1;
	}

	var_01 = getaispeciesarray("bad_guys","all");
	foreach(var_03 in var_01)
	{
		if(!isdefined(var_03.enemy))
		{
			continue;
		}

		if(!isplayer(var_03.enemy))
		{
			continue;
		}

		if(var_03.type == "dog")
		{
			foreach(var_05 in level.players)
			{
				if(distance(var_03.origin,var_05.origin) < 384)
				{
					return 0;
				}
			}

			continue;
		}

		if(isdefined(var_03.melee) && isdefined(var_03.melee.target) && isplayer(var_03.melee.target))
		{
			return 0;
		}

		var_07 = [[ level.autosave_proximity_threat_func ]](var_03);
		if(var_07 == "return_even_if_low_accuracy")
		{
			return 0;
		}

		if(var_03.finalaccuracy < 0.021 && var_03.finalaccuracy > -1)
		{
			continue;
		}

		if(var_07 == "return")
		{
			return 0;
		}

		if(var_07 == "none")
		{
			continue;
		}

		if(var_03.a.lastshoottime > gettime() - 500)
		{
			if(param_00 || var_03 animscripts\utility::canseeenemy(0) && var_03 canshootenemy(0))
			{
				return 0;
			}
		}

		if(isdefined(var_03.a.aimidlethread) && var_03 animscripts\utility::canseeenemy(0) && var_03 canshootenemy(0))
		{
			return 0;
		}
	}

	if(maps\_utility::player_is_near_live_grenade())
	{
		return 0;
	}

	var_09 = getentarray("destructible","classname");
	foreach(var_0B in var_09)
	{
		if(!isdefined(var_0B.healthdrain))
		{
			continue;
		}

		foreach(var_05 in level.players)
		{
			if(distance(var_0B.origin,var_05.origin) < 400)
			{
				return 0;
			}
		}
	}

	return 1;
}

//Function Number: 26
enemy_is_a_threat()
{
	if(self.finalaccuracy >= 0.021)
	{
		return 1;
	}

	foreach(var_01 in level.players)
	{
		if(distance(self.origin,var_01.origin) < 500)
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 27
autosave_proximity_threat_func(param_00)
{
	foreach(var_02 in level.players)
	{
		var_03 = distance(param_00.origin,var_02.origin);
		if(var_03 < 200)
		{
			return "return_even_if_low_accuracy";
		}
		else if(var_03 < 360)
		{
			return "return";
		}
		else if(var_03 < 1000)
		{
			return "threat_exists";
		}
	}

	return "none";
}

//Function Number: 28
autosave_recon(param_00)
{
	if(!maps\_utility::is_default_start())
	{
		return;
	}

	var_01 = maps\_utility_code::get_leveltime();
	var_02 = var_01;
	if(isdefined(level.recon_checkpoint_lasttime))
	{
		var_02 = var_01 - level.recon_checkpoint_lasttime;
	}

	level.recon_checkpoint_lasttime = var_01;
	reconevent("script_checkpoint: id %d, leveltime %d, deltatime %d",param_00,var_01,var_02);
}