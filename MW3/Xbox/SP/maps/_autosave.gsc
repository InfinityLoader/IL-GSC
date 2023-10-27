/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\_autosave.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: Console
 * Function Count: 28
 * Decompile Time: 461 ms
 * Timestamp: 10/27/2023 2:34:55 AM
*******************************************************************/

//Function Number: 1
main()
{
	level.var_17C9 = 0;
	common_scripts\utility::flag_init("game_saving");
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
	level waittill("finished final intro screen fadein");
	if(level.var_1291)
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
func_17D3(param_00)
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
	thread maps\_quotes::setdeadquote();
	if(isdefined(param_00))
	{
		param_00 delete();
	}
}

//Function Number: 9
autosavenamethink(param_00)
{
	if(maps\_utility::func_17D7())
	{
		return;
	}

	param_00 waittill("trigger");
	if(isdefined(level.customautosavecheck))
	{
		if(![[ level.customautosavecheck ]]())
		{
			return;
		}
	}

	var_01 = param_00.script_autosavename;
	maps\_utility::autosave_by_name(var_01);
	param_00 delete();
}

//Function Number: 10
func_17DA(param_00)
{
	param_00 waittill("trigger");
}

//Function Number: 11
func_17DB(param_00,param_01)
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
	wait param_00;
	common_scripts\utility::flag_clear("game_saving");
	level notify("autosave_timeout");
}

//Function Number: 13
func_17DD()
{
	var_00 = "levelshots / autosave / autosave_" + level.script + "start";
	savegame("levelstart",&"AUTOSAVE_LEVELSTART",var_00,1);
	func_17F7(0);
}

//Function Number: 14
func_17DE()
{
	var_00 = "levelshots / autosave / autosave_" + level.script + "start";
	if(getdvarint("g_reloading") == 0)
	{
		savegame("levelstart",&"AUTOSAVE_LEVELSTART",var_00,1);
		func_17F7(0);
	}
}

//Function Number: 15
_autosave_game_now(param_00)
{
	if(isdefined(level.var_1291) && level.var_1291)
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

	wait 0.05;
	if(issaverecentlyloaded())
	{
		level.var_17C9 = gettime();
		return 0;
	}

	if(var_05 < 0)
	{
		return 0;
	}

	if(!func_17E2())
	{
		return 0;
	}

	common_scripts\utility::flag_set("game_saving");
	wait 2;
	common_scripts\utility::flag_clear("game_saving");
	if(!commitwouldbevalid(var_05))
	{
		return 0;
	}

	if(func_17E2())
	{
		if(!isdefined(param_00))
		{
			thread maps\_arcademode::arcademode_checkpoint_print();
		}

		func_17F7(var_05);
		commitsave(var_05);
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
func_17E2()
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
tryautosave(param_00,param_01,param_02,param_03,param_04,param_05)
{
	if(common_scripts\utility::flag("disable_autosaves"))
	{
		return 0;
	}

	level endon("nextmission");
	level.player endon("death");
	if(maps\_utility::func_E89())
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

	var_06 = 1.25;
	var_07 = 1.25;
	if(isdefined(param_03) && param_03 < var_06 + var_07)
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
	var_08 = getdescription();
	var_09 = gettime();
	for(;;)
	{
		if(autosavecheck(undefined,param_04))
		{
			var_0A = savegamenocommit(param_00,var_08,param_02,param_05);
			if(var_0A < 0)
			{
				break;
			}

			wait 0.05;
			if(issaverecentlyloaded())
			{
				level.var_17C9 = gettime();
				break;
			}

			wait var_06;
			if(extra_autosave_checks_failed())
			{
				continue;
			}

			if(!autosavecheck(undefined,param_04))
			{
				continue;
			}

			wait var_07;
			if(!func_17E6())
			{
				continue;
			}

			if(isdefined(param_03))
			{
				if(gettime() > var_09 + param_03 * 1000)
				{
					break;
				}
			}

			if(!common_scripts\utility::flag("can_save"))
			{
				break;
			}

			if(!commitwouldbevalid(var_0A))
			{
				common_scripts\utility::flag_clear("game_saving");
				return 0;
			}

			thread maps\_arcademode::arcademode_checkpoint_print();
			func_17F7(var_0A);
			commitsave(var_0A);
			level.var_17E4 = gettime();
			setdvar("ui_grenade_death","0");
			break;
		}

		wait 0.25;
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
			func_17DB("autosave failed: " + var_01["msg"]);
			return 1;
		}
	}

	return 0;
}

//Function Number: 20
func_17E6()
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

	if(level.var_1291)
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
		if(!func_17F4(param_00))
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

	if(isdefined(level.savehere) && !level.savehere)
	{
		return 0;
	}

	if(isdefined(level.cansave) && !level.cansave)
	{
		return 0;
	}

	if(!issavesuccessful())
	{
		func_17DB("autosave failed: save call was unsuccessful");
		return 0;
	}

	return 1;
}

//Function Number: 22
autosaveplayercheck(param_00)
{
	if(isdefined(level.ac130gunner) && level.ac130gunner == self)
	{
		return 1;
	}

	if(self ismeleeing() && param_00)
	{
		func_17DB("autosave failed:player is meleeing");
		return 0;
	}

	if(self isthrowinggrenade() && param_00)
	{
		func_17DB("autosave failed:player is throwing a grenade");
		return 0;
	}

	if(self isfiring() && param_00)
	{
		func_17DB("autosave failed:player is firing");
		return 0;
	}

	if(isdefined(self.shellshocked) && self.shellshocked)
	{
		func_17DB("autosave failed:player is in shellshock");
		return 0;
	}

	if(common_scripts\utility::isflashed())
	{
		func_17DB("autosave failed:player is flashbanged");
		return 0;
	}

	return 1;
}

//Function Number: 23
autosaveammocheck()
{
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

	func_17DB("autosave failed: ammo too low");
	return 0;
}

//Function Number: 24
autosavehealthcheck()
{
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

	if(common_scripts\utility::flag("_radiation_poisoning"))
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
func_17F4(param_00)
{
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
			if(param_00 || var_03 animscripts/utility::canseeenemy(0) && var_03 canshootenemy(0))
			{
				return 0;
			}
		}

		if(isdefined(var_03.a.aimidlethread) && var_03 animscripts/utility::canseeenemy(0) && var_03 canshootenemy(0))
		{
			return 0;
		}
	}

	if(maps\_utility::func_17F5())
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
func_17F7(param_00)
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