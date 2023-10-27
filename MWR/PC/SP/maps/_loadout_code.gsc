/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\_loadout_code.gsc
 * Game: Call of Duty: Modern Warfare Remastered
 * Platform: PC
 * Function Count: 19
 * Decompile Time: 305 ms
 * Timestamp: 10/27/2023 2:48:17 AM
*******************************************************************/

//Function Number: 1
saveplayerweaponstatepersistent(param_00)
{
	var_01 = level.player getcurrentweapon();
	if(!isdefined(var_01) || var_01 == "none")
	{
	}

	game["weaponstates"][param_00]["current"] = var_01;
	var_02 = level.player getcurrentoffhand();
	game["weaponstates"][param_00]["offhand"] = var_02;
	game["weaponstates"][param_00]["list"] = [];
	var_03 = level.player getweaponslistall();
	for(var_04 = 0;var_04 < var_03.size;var_04++)
	{
		game["weaponstates"][param_00]["list"][var_04]["name"] = var_03[var_04];
	}
}

//Function Number: 2
restoreplayerweaponstatepersistent(param_00)
{
	if(!isdefined(game["weaponstates"]))
	{
		return 0;
	}

	if(!isdefined(game["weaponstates"][param_00]))
	{
		return 0;
	}

	level.player takeallweapons();
	for(var_01 = 0;var_01 < game["weaponstates"][param_00]["list"].size;var_01++)
	{
		var_02 = game["weaponstates"][param_00]["list"][var_01]["name"];
		if(isdefined(level.legit_weapons))
		{
			if(!isdefined(level.legit_weapons[var_02]))
			{
				continue;
			}
		}

		if(var_02 == "c4")
		{
			continue;
		}

		if(var_02 == "claymore")
		{
			continue;
		}

		level.player giveweapon(var_02);
		level.player givemaxammo(var_02);
	}

	if(isdefined(level.legit_weapons))
	{
		var_02 = game["weaponstates"][param_00]["offhand"];
		if(isdefined(level.legit_weapons[var_02]))
		{
			level.player switchtooffhand(var_02);
		}

		var_02 = game["weaponstates"][param_00]["current"];
		if(isdefined(level.legit_weapons[var_02]))
		{
			level.player switchtoweapon(var_02);
		}
	}
	else
	{
		level.player switchtooffhand(game["weaponstates"][param_00]["offhand"]);
		level.player switchtoweapon(game["weaponstates"][param_00]["current"]);
	}

	return 1;
}

//Function Number: 3
setdefaultactionslot()
{
	self setactionslot(1,"");
	self setactionslot(2,"");
	self setactionslot(3,"altMode");
	self setactionslot(4,"");
}

//Function Number: 4
init_player()
{
	setdefaultactionslot();
	self takeallweapons();
}

//Function Number: 5
get_loadout()
{
	if(isdefined(level.loadout))
	{
		return level.loadout;
	}

	return level.script;
}

//Function Number: 6
persist(param_00,param_01)
{
	var_02 = get_loadout();
	if(param_00 != var_02)
	{
		return;
	}

	if(!isdefined(game["previous_map"]))
	{
		return;
	}

	if(game["previous_map"] != param_01)
	{
		return;
	}

	level._lc_persists = 1;
	restoreplayerweaponstatepersistent(param_01);
	level.has_loadout = 1;
}

//Function Number: 7
loadout(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	if(isdefined(param_00))
	{
		var_07 = get_loadout();
		if(param_00 != var_07)
		{
			return;
		}
	}

	if(!isdefined(level._lc_persists))
	{
		if(isdefined(param_01))
		{
			level.default_weapon = param_01;
			level.player giveweapon(param_01);
		}

		if(isdefined(param_02))
		{
			level.player giveweapon(param_02);
		}

		if(isdefined(param_01))
		{
			level.player switchtoweapon(param_01);
		}
		else if(isdefined(param_02))
		{
			level.player switchtoweapon(param_02);
		}
	}

	if(isdefined(param_03))
	{
		level.player setoffhandprimaryclass(param_03);
		level.player giveweapon(param_03);
	}

	if(isdefined(param_04))
	{
		level.player setoffhandsecondaryclass(param_04);
		level.player giveweapon(param_04);
	}

	if(isdefined(param_05))
	{
		level.player setviewmodel(param_05);
	}

	if(isdefined(param_06))
	{
		level.campaign = param_06;
	}

	level.has_loadout = 1;
}

//Function Number: 8
loadoutequipment(param_00,param_01,param_02)
{
	if(!isdefined(param_00))
	{
		return;
	}

	if(level.script != param_00)
	{
		return;
	}

	if(isdefined(param_01))
	{
		level.player giveweapon(param_01);
		level.player setactionslot(2,"weapon",param_01);
	}

	if(isdefined(param_02))
	{
		level.player giveweapon(param_02);
		level.player setactionslot(4,"weapon",param_02);
	}
}

//Function Number: 9
loadout_complete()
{
	level.loadoutcomplete = 1;
	level notify("loadout complete");
}

//Function Number: 10
default_loadout_if_notset()
{
	if(level.has_loadout)
	{
		return;
	}

	loadout(undefined,"mp5",undefined,"fraggrenade","flash_grenade","viewmodel_base_viewhands");
	level.map_without_loadout = 1;
}

//Function Number: 11
loadoutcustomization()
{
	switch(level.script)
	{
		case "killhouse":
			break;

		case "cargoship":
			break;

		case "coup":
			break;

		case "blackout":
			break;

		case "armada":
			break;

		case "bog_a":
			break;

		case "hunted":
			break;

		case "ac130":
			break;

		case "bog_b":
			break;

		case "airlift":
			break;

		case "aftermath":
			break;

		case "village_assault":
			break;

		case "scoutsniper":
			break;

		case "sniperescape":
			break;

		case "village_defend":
			break;

		case "ambush":
			break;

		case "icbm":
			break;

		case "launchfacility_a":
			break;

		case "launchfacility_b":
			break;

		case "jeepride":
			break;

		case "airplane":
			break;

		case "simplecredits":
			break;
	}
}

//Function Number: 12
loadout_killhouse()
{
	level.player setweaponammoclip("fraggrenade",0);
	level.player setweaponammoclip("flash_grenade",0);
}

//Function Number: 13
loadout_blackout()
{
	level.player givemaxammo("m4m203_silencer_reflex");
	level.player givemaxammo("m14_scoped_silencer_woodland");
}

//Function Number: 14
loadout_scoutsniper()
{
	level.player givemaxammo("m14_scoped_silencer");
	level.player givemaxammo("usp_silencer");
}

//Function Number: 15
loadout_sniperescape()
{
	if(level.gameskill >= 2)
	{
		level.player setweaponammoclip("claymore",10);
		level.player setweaponammoclip("c4",6);
		return;
	}

	level.player setweaponammoclip("claymore",8);
	level.player setweaponammoclip("c4",3);
}

//Function Number: 16
loadout_village_defend()
{
	level.player givemaxammo("claymore");
}

//Function Number: 17
loadout_ambush()
{
	level.player setweaponammostock("remington700",10);
}

//Function Number: 18
loadout_launchfacility_a()
{
	level.player givemaxammo("claymore");
}

//Function Number: 19
loadout_launchfacility_b()
{
	var_00 = undefined;
	var_01 = 0;
	var_02 = level.player getweaponslistprimaries();
	foreach(var_04 in var_02)
	{
		if(issubstr(var_04,"javelin"))
		{
			var_00 = var_04;
			continue;
		}

		if(issubstr(var_04,"m4m203_silencer_reflex"))
		{
			var_01 = 1;
		}
	}

	if(isdefined(var_00))
	{
		level.player takeweapon(var_00);
		if(var_01)
		{
			level.player giveweapon("usp_silencer");
		}
		else
		{
			level.player giveweapon("m4m203_silencer_reflex");
		}

		level.player switchtoweaponimmediate("m4m203_silencer_reflex");
	}
}