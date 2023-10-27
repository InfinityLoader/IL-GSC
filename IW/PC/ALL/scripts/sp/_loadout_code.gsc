/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\sp\_loadout_code.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 11
 * Decompile Time: 511 ms
 * Timestamp: 10/27/2023 12:24:42 AM
*******************************************************************/

//Function Number: 1
func_EB77(param_00,param_01)
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
	var_03 = level.player method_8115();
	game["weaponstates"][param_00]["offhand"] = var_03;
	game["weaponstates"][param_00]["list"] = [];
	var_04 = scripts\common\utility::array_combine(level.player getweaponslistprimaries(),level.player getweaponslistoffhands());
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
func_E2E3(param_00,param_01,param_02)
{
	var_03 = scripts\common\utility::func_116D7(isdefined(param_02) && param_02,::method_83B6,::switchtoweapon);
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

	level.player method_83B7();
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

	level.player method_83B4(game["weaponstates"][param_00]["offhand"]);
	level.player [[ var_03 ]](game["weaponstates"][param_00]["current"]);
	return 1;
}

//Function Number: 3
func_F6B5()
{
	self method_8299(1,"");
	self method_8299(2,"altMode");
	self method_8299(3,"");
	self method_8299(4,"");
}

//Function Number: 4
func_96D7()
{
	func_F6B5();
	self method_83B7();
}

//Function Number: 5
func_7AA6()
{
	if(isdefined(level.var_AE21))
	{
		return level.var_AE21;
	}

	return level.script;
}

//Function Number: 6
func_37E7(param_00)
{
	level.var_1303 = param_00;
}

//Function Number: 7
func_CA6E(param_00,param_01,param_02)
{
	var_03 = func_7AA6();
	if(param_00 != var_03)
	{
		return;
	}

	if(!isdefined(game["previous_map"]))
	{
		return;
	}

	level.var_1304 = 1;
	if(isdefined(param_02))
	{
		level.player method_831D(param_02);
	}

	func_E2E3(func_7AA6(),1);
	level.var_8B8E = 1;
}

//Function Number: 8
func_AE21(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07)
{
	if(isdefined(param_00))
	{
		var_08 = func_7AA6();
		if(param_00 != var_08 || isdefined(level.var_1304))
		{
			return;
		}
	}

	if(isdefined(param_01))
	{
		if(param_01 == "iw7_ar57")
		{
			param_01 = "iw7_ar57+ar57scope";
		}

		level.var_502E = param_01;
		level.player giveweapon(param_01);
	}

	if(isdefined(param_06))
	{
		if(param_06 == "iw7_erad")
		{
			param_06 = "iw7_erad+eradscope";
		}

		level.player method_831D(param_06);
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
		level.player method_8369(param_05);
	}

	level.var_37E7 = level.var_1303;
	level.var_1303 = undefined;
	level.var_8B8E = 1;
	if(isdefined(param_07))
	{
		func_F551(param_07);
	}
}

//Function Number: 9
func_F551(param_00)
{
	level.var_D32B = param_00;
	precachemodel(level.var_D32B);
}

//Function Number: 10
func_AE27()
{
	level.var_AE64 = 1;
	level notify("loadout complete");
}

//Function Number: 11
func_4FFD()
{
	if(level.var_8B8E)
	{
		return;
	}

	func_AE21(undefined,"iw7_ar57_reflex",undefined,"flash_grenade","fraggrenade","viewmodel_base_viewhands","flash");
	level.var_B32C = 1;
}