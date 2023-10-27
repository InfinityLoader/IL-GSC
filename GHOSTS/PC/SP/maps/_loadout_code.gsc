/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\_loadout_code.gsc
 * Game: Call of Duty: Ghosts
 * Platform: PC
 * Function Count: 10
 * Decompile Time: 148 ms
 * Timestamp: 10/27/2023 1:24:53 AM
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

	var_02 = level.player getcurrentprimaryweapon();
	if(!isdefined(var_02) || var_02 == "none")
	{
	}

	game["weaponstates"][param_00]["current"] = var_02;
	var_03 = level.player getcurrentoffhand();
	game["weaponstates"][param_00]["offhand"] = var_03;
	game["weaponstates"][param_00]["list"] = [];
	var_04 = common_scripts\utility::array_combine(level.player getweaponslistprimaries(),level.player getweaponslistoffhands());
	for(var_05 = 0;var_05 < var_04.size;var_05++)
	{
		game["weaponstates"][param_00]["list"][var_05]["name"] = var_04[var_05];
		if(param_01)
		{
			game["weaponstates"][param_00]["list"][var_05]["clip"] = level.player getweaponammoclip(var_04[var_05]);
			game["weaponstates"][param_00]["list"][var_05]["stock"] = level.player getweaponammostock(var_04[var_05]);
		}
	}
}

//Function Number: 2
func_6661(param_00,param_01,param_02)
{
	var_03 = common_scripts\utility::func_803F(isdefined(param_02) && param_02,::switchtoweaponimmediate,::switchtoweapon);
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
	for(var_04 = 0;var_04 < game["weaponstates"][param_00]["list"].size;var_04++)
	{
		var_05 = game["weaponstates"][param_00]["list"][var_04]["name"];
		if(var_05 == "c4")
		{
			continue;
		}

		if(var_05 == "claymore")
		{
			continue;
		}

		level.player giveweapon(var_05);
		level.player givemaxammo(var_05);
		if(param_01)
		{
			level.player setweaponammoclip(var_05,game["weaponstates"][param_00]["list"][var_04]["clip"]);
			level.player setweaponammostock(var_05,game["weaponstates"][param_00]["list"][var_04]["stock"]);
		}
	}

	level.player switchtooffhand(game["weaponstates"][param_00]["offhand"]);
	level.player [[ var_03 ]](game["weaponstates"][param_00]["current"]);
	return 1;
}

//Function Number: 3
func_7014()
{
	self setactionslot(1,"");
	self setactionslot(2,"");
	self setactionslot(3,"altMode");
	self setactionslot(4,"");
}

//Function Number: 4
func_4587()
{
	func_7014();
	self takeallweapons();
}

//Function Number: 5
get_loadout()
{
	if(isdefined(level.var_4E9D))
	{
		return level.var_4E9D;
	}

	return level.script;
}

//Function Number: 6
func_1973(param_00)
{
	level._lc = param_00;
}

//Function Number: 7
persist(param_00,param_01,param_02)
{
	var_03 = get_loadout();
	if(param_00 != var_03)
	{
	}

	if(!isdefined(game["previous_map"]))
	{
	}

	level._lc_persists = 1;
	if(isdefined(param_02))
	{
		level.player setoffhandsecondaryclass(param_02);
	}

	func_6661(get_loadout(),1);
	level.has_loadout = 1;
}

//Function Number: 8
func_4E9D(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	if(isdefined(param_00))
	{
		var_07 = get_loadout();
		if(param_00 != var_07 || isdefined(level._lc_persists))
		{
		}
	}

	if(isdefined(param_01))
	{
		level.var_24B3 = param_01;
		level.player giveweapon(param_01);
	}

	if(isdefined(param_06))
	{
		level.player setoffhandsecondaryclass(param_06);
	}

	if(isdefined(param_02))
	{
		level.player giveweapon(param_02);
	}

	if(isdefined(param_03))
	{
		level.player giveweapon(param_03);
	}

	if(isdefined(param_04))
	{
		level.player giveweapon(param_04);
	}

	level.player switchtoweapon(param_01);
	if(isdefined(param_05))
	{
		level.player setviewmodel(param_05);
	}

	level.var_1973 = level._lc;
	level._lc = undefined;
	level.has_loadout = 1;
}

//Function Number: 9
func_4E9E()
{
	level.var_4EA0 = 1;
	level notify("loadout complete");
}

//Function Number: 10
default_loadout_if_notset()
{
	if(level.has_loadout)
	{
	}

	func_4E9D(undefined,"kriss",undefined,"flash_grenade","fraggrenade","viewmodel_base_viewhands","flash");
	level.map_without_loadout = 1;
}