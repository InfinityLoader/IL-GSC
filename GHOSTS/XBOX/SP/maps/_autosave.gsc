/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\_autosave.gsc
 * Game: Call of Duty: Ghosts
 * Platform: Console
 * Function Count: 28
 * Decompile Time: 528 ms
 * Timestamp: 10/27/2023 1:39:23 AM
*******************************************************************/

//Function Number: 1
func_4FDD()
{
	level.lastautosavetime = 0;
	common_scripts\utility::func_3385("game_saving");
	common_scripts\utility::func_3385("can_save");
	common_scripts\utility::flag_set("can_save");
	common_scripts\utility::func_3385("disable_autosaves");
	if(!isdefined(level._extra_autosave_checks))
	{
		level._extra_autosave_checks = [];
	}

	level.var_11C3 = ::func_11C3;
}

//Function Number: 2
getdescription()
{
	return &"AUTOSAVE_AUTOSAVE";
}

//Function Number: 3
func_3B39(param_00)
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

	if(level.var_52F1)
	{
	}

	if(common_scripts\utility::flag("game_saving"))
	{
	}

	common_scripts\utility::flag_set("game_saving");
	var_00 = "levelshots / autosave / autosave_" + level.script + "start";
	function_01A0("levelstart",&"AUTOSAVE_LEVELSTART",var_00,1);
	setdvar("ui_grenade_death","0");
	common_scripts\utility::func_337C("game_saving");
}

//Function Number: 5
func_832E(param_00)
{
	param_00 waittill("trigger");
	maps\_utility::func_11C5();
}

//Function Number: 6
func_832F(param_00)
{
	param_00 waittill("trigger");
	maps\_utility::autosave_tactical();
}

//Function Number: 7
func_832C(param_00)
{
	if(!isdefined(param_00.var_6B46))
	{
		param_00.var_6B46 = 0;
	}

	autosaves_think(param_00);
}

//Function Number: 8
autosaves_think(param_00)
{
	var_01 = func_3B39(param_00.var_6B46);
	if(!isdefined(var_01))
	{
	}

	wait(1);
	param_00 waittill("trigger");
	var_02 = param_00.var_6B46;
	var_03 = "levelshots / autosave / autosave_" + level.script + var_02;
	func_83F8(var_02,var_01,var_03);
	if(isdefined(param_00))
	{
		param_00 delete();
	}
}

//Function Number: 9
func_11D3(param_00)
{
	if(maps\_utility::func_4813())
	{
	}

	wait(1);
	param_00 waittill("trigger");
	if(!isdefined(param_00))
	{
	}

	var_01 = param_00.var_6B47;
	param_00 delete();
	if(isdefined(level.customautosavecheck))
	{
		if(![[ level.customautosavecheck ]]())
		{
		}
	}

	maps\_utility::autosave_by_name(var_01);
}

//Function Number: 10
func_832D(param_00)
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
	common_scripts\utility::func_337C("game_saving");
	level notify("autosave_timeout");
}

//Function Number: 13
_autosave_game_now_nochecks()
{
	var_00 = "levelshots / autosave / autosave_" + level.script + "start";
	function_01A0("levelstart",&"AUTOSAVE_LEVELSTART",var_00,1);
	autosave_recon(0);
}

//Function Number: 14
_autosave_game_now_notrestart()
{
	var_00 = "levelshots / autosave / autosave_" + level.script + "start";
	if(getdvarint("g_reloading") == 0)
	{
		function_01A0("levelstart",&"AUTOSAVE_LEVELSTART",var_00,1);
		autosave_recon(0);
	}
}

//Function Number: 15
_autosave_game_now(param_00)
{
	if(isdefined(level.var_52F1) && level.var_52F1)
	{
	}

	if(common_scripts\utility::flag("game_saving"))
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
		var_05 = function_01A3(var_03,var_04,"$default",1);
	}
	else
	{
		var_05 = function_01A3(var_04,var_05);
	}

	wait(0.05);
	if(function_01A2())
	{
		level.lastautosavetime = gettime();
		return 0;
	}

	if(var_05 < 0)
	{
		return 0;
	}

	if(!func_83EE())
	{
		return 0;
	}

	common_scripts\utility::flag_set("game_saving");
	wait(2);
	common_scripts\utility::func_337C("game_saving");
	if(!function_01A5(var_05))
	{
		return 0;
	}

	if(func_83EE())
	{
		autosave_recon(var_05);
		function_01A4(var_05);
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
func_83EE()
{
	if(!function_01A1())
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
func_83F8(param_00,param_01,param_02,param_03,param_04,param_05)
{
	if(common_scripts\utility::flag("disable_autosaves"))
	{
		return 0;
	}

	level endon("nextmission");
	level.player endon("death");
	if(maps\_utility::func_47D0())
	{
		level.var_5D60 endon("death");
	}

	level notify("trying_new_autosave");
	if(common_scripts\utility::flag("game_saving"))
	{
		return 0;
	}

	if(isdefined(level.var_55F6))
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
			var_0A = function_01A3(param_00,var_08,param_02,param_05);
			if(var_0A < 0)
			{
				break;
			}

			wait(0.05);
			if(function_01A2())
			{
				level.lastautosavetime = gettime();
				break;
			}

			wait(var_06);
			if(func_3109())
			{
				continue;
			}

			if(!autosavecheck(undefined,param_04))
			{
				continue;
			}

			wait(var_07);
			if(!autosavecheck_not_picky())
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

			if(!function_01A5(var_0A))
			{
				common_scripts\utility::func_337C("game_saving");
				return 0;
			}

			autosave_recon(var_0A);
			function_01A4(var_0A);
			level.var_4C95 = gettime();
			setdvar("ui_grenade_death","0");
			break;
		}

		wait(0.25);
	}

	common_scripts\utility::func_337C("game_saving");
	return 1;
}

//Function Number: 19
func_3109()
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

	if(isdefined(level.var_78DB) && ![[ level.var_78DB ]]())
	{
		return 0;
	}

	if(level.var_52F1)
	{
		return 0;
	}

	if(!isdefined(param_00))
	{
		param_00 = level.var_2A05;
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
		if(!var_03 func_11D4(param_00))
		{
			return 0;
		}
	}

	if(isdefined(level.var_6AAA) && !level.var_6AAA)
	{
		return 0;
	}

	if(isdefined(level.cansave) && !level.cansave)
	{
		return 0;
	}

	if(!function_01A1())
	{
		autosaveprint("autosave failed: save call was unsuccessful");
		return 0;
	}

	return 1;
}

//Function Number: 22
func_11D4(param_00)
{
	if(isdefined(level.ac130gunner) && level.ac130gunner == self)
	{
		return 1;
	}

	if(self ismeleeing() && param_00)
	{
		autosaveprint("autosave failed:player is meleeing");
		return 0;
	}

	if(self method_8287() && param_00)
	{
		autosaveprint("autosave failed:player is throwing a grenade");
		return 0;
	}

	if(self method_8288() && param_00)
	{
		autosaveprint("autosave failed:player is firing");
		return 0;
	}

	if(isdefined(self.var_73FD) && self.var_73FD)
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
autosavethreatcheck(param_00)
{
	if(isdefined(level.ac130gunner) && level.ac130gunner == self)
	{
		return 1;
	}

	var_01 = function_016C("bad_guys","all");
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

		if(isdefined(var_03.var_5138) && isdefined(var_03.var_5138.target) && isplayer(var_03.var_5138.target))
		{
			return 0;
		}

		var_07 = [[ level.var_11C3 ]](var_03);
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
			if(param_00 || var_03 animscripts/utility::func_19F6(0) && var_03 method_81F1(0))
			{
				return 0;
			}
		}

		if(isdefined(var_03.a.aimidlethread) && var_03 animscripts/utility::func_19F6(0) && var_03 method_81F1(0))
		{
			return 0;
		}
	}

	if(maps\_utility::func_5E65())
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
func_2EA8()
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
func_11C3(param_00)
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
	if(!maps\_utility::func_47DB())
	{
	}

	var_01 = maps\_utility_code::get_leveltime();
	var_02 = var_01;
	if(isdefined(level.var_6406))
	{
		var_02 = var_01 - level.var_6406;
	}

	level.var_6406 = var_01;
	function_0142("script_checkpoint: id %d, leveltime %d, deltatime %d",param_00,var_01,var_02);
}