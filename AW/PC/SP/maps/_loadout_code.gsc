/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps/_loadout_code.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 10
 * Decompile Time: 156 ms
 * Timestamp: 10/27/2023 1:59:45 AM
*******************************************************************/

//Function Number: 1
saveplayerweaponstatepersistent(param_00,param_01)
{
	if(!isdefined(param_01))
	{
		param_01 = 0;
	}

	level.player endon("death");
	if(level.player.health == 0)
	{
		return;
	}

	var_02 = level.player maps\_utility::get_storable_current_weapon_primary();
	if(!isdefined(var_02) || var_02 == "none")
	{
	}

	game["weaponstates"][param_00]["current"] = var_02;
	var_03 = level.player getcurrentoffhand();
	var_04 = level.player getlethalweapon();
	var_05 = level.player gettacticalweapon();
	game["weaponstates"][param_00]["offhand"] = var_03;
	game["weaponstates"][param_00]["list"] = [];
	var_06 = common_scripts\utility::array_combine(level.player getweaponslistprimaries(),level.player getweaponslistoffhands());
	var_07 = 0;
	foreach(var_09 in var_06)
	{
		if(level.player maps\_utility::is_unstorable_weapon(var_09))
		{
			continue;
		}

		game["weaponstates"][param_00]["list"][var_07]["name"] = var_06[var_07];
		var_0A = level.player gethybridsightenabled(var_06[var_07]);
		game["weaponstates"][param_00]["list"][var_07]["hybrid_sight_enabled"] = var_0A;
		if(var_06[var_07] == var_04)
		{
			game["weaponstates"][param_00]["list"][var_07]["isLethal"] = 1;
		}
		else
		{
			game["weaponstates"][param_00]["list"][var_07]["isLethal"] = 0;
		}

		if(var_06[var_07] == var_05)
		{
			game["weaponstates"][param_00]["list"][var_07]["isTactical"] = 1;
		}
		else
		{
			game["weaponstates"][param_00]["list"][var_07]["isTactical"] = 0;
		}

		if(param_01)
		{
			game["weaponstates"][param_00]["list"][var_07]["clip"] = level.player getweaponammoclip(var_06[var_07]);
			game["weaponstates"][param_00]["list"][var_07]["stock"] = level.player setweaponammostock(var_06[var_07]);
		}

		var_07++;
	}
}

//Function Number: 2
restoreplayerweaponstatepersistent(param_00,param_01,param_02)
{
	var_03 = common_scripts\utility::ter_op(isdefined(param_02) && param_02,::switchtoweaponimmediate,::switchtoweapon);
	if(!isdefined(param_01))
	{
		param_01 = 0;
	}

	if(!isdefined(game["weaponstates"]))
	{
		return 0;
	}

	if(!isdefined(game["weaponstates"][param_00]))
	{
		return 0;
	}

	level.player takeallweapons();
	var_04 = [];
	for(var_05 = 0;var_05 < game["weaponstates"][param_00]["list"].size;var_05++)
	{
		var_06 = game["weaponstates"][param_00]["list"][var_05]["name"];
		if(var_06 == "c4")
		{
			continue;
		}

		if(var_06 == "claymore")
		{
			continue;
		}

		if(game["weaponstates"][param_00]["list"][var_05]["isLethal"] == 1)
		{
			level.player setlethalweapon(var_06);
		}

		if(game["weaponstates"][param_00]["list"][var_05]["isTactical"] == 1)
		{
			level.player settacticalweapon(var_06);
		}

		level.player giveweapon(var_06);
		level.player givemaxammo(var_06);
		var_07 = game["weaponstates"][param_00]["list"][var_05]["hybrid_sight_enabled"];
		level.player enablehybridsight(var_06,var_07);
		if(param_01)
		{
			var_08 = var_04.size;
			var_04[var_08]["name"] = var_06;
			var_04[var_08]["clip"] = game["weaponstates"][param_00]["list"][var_05]["clip"];
			var_04[var_08]["stock"] = game["weaponstates"][param_00]["list"][var_05]["stock"];
		}
	}

	foreach(var_0A in var_04)
	{
		level.player setweaponammoclip(var_0A["name"],var_0A["clip"]);
		level.player setweaponammostock(var_0A["name"],var_0A["stock"]);
	}

	level.player switchtooffhand(game["weaponstates"][param_00]["offhand"]);
	level.player [[ var_03 ]](game["weaponstates"][param_00]["current"]);
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
campaign(param_00)
{
	level._lc = param_00;
}

//Function Number: 7
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

	level._lc_persists = 1;
	restoreplayerweaponstatepersistent(param_01,1);
	level.has_loadout = 1;
}

//Function Number: 8
loadout(param_00,param_01,param_02,param_03,param_04,param_05)
{
	if(isdefined(param_00))
	{
		var_06 = get_loadout();
		if(param_00 != var_06 || isdefined(level._lc_persists))
		{
			return;
		}
	}

	if(isdefined(param_01))
	{
		level.default_weapon = param_01;
		level.player giveweapon(param_01);
	}

	if(isdefined(param_02))
	{
		level.player giveweapon(param_02);
	}

	if(isdefined(param_03))
	{
		level.player setlethalweapon(param_03);
		level.player giveweapon(param_03);
	}

	if(isdefined(param_04))
	{
		level.player settacticalweapon(param_04);
		level.player giveweapon(param_04);
	}

	level.player switchtoweapon(param_01);
	if(isdefined(param_05))
	{
		level.player setviewmodel(param_05);
	}

	level.campaign = level._lc;
	level._lc = undefined;
	level.has_loadout = 1;
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

	loadout(undefined,"iw5_sn6_sp",undefined,"fraggrenade","flash_grenade","viewmodel_base_viewhands");
	level.map_without_loadout = 1;
}