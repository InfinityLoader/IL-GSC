/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\mp\_loot.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 15
 * Decompile Time: 627 ms
 * Timestamp: 10/27/2023 12:20:48 AM
*******************************************************************/

//Function Number: 1
init()
{
	level.var_B09C = [];
	level.lootweaponrefs = [];
	var_00 = 0;
	for(;;)
	{
		var_01 = tablelookupbyrow("mp/loot/iw7_weapon_loot_master.csv",var_00,0);
		if(!isdefined(var_01) || var_01 == "")
		{
			break;
		}

		var_01 = int(var_01);
		var_02 = tablelookupbyrow("mp/loot/iw7_weapon_loot_master.csv",var_00,1);
		level.lootweaponrefs[var_01] = var_02;
		var_00++;
	}
}

//Function Number: 2
func_804C(param_00)
{
	if(isplayer(self) && weaponhasprestigenuke(param_00))
	{
		return ["passive_nuke"];
	}

	var_01 = func_7F82(param_00);
	if(isdefined(var_01))
	{
		return var_01.var_C946;
	}

	return undefined;
}

//Function Number: 3
func_7F82(param_00)
{
	var_01 = function_02C4(param_00);
	if(!isdefined(var_01))
	{
		return undefined;
	}

	var_02 = scripts\mp\_utility::func_8234(param_00);
	if(isdefined(level.var_B09C[var_02]) && isdefined(level.var_B09C[var_02][var_01]))
	{
		var_03 = level.var_B09C[var_02][var_01];
		return var_03;
	}

	var_03 = func_36A4(var_01,var_03,var_02);
	if(isdefined(var_03))
	{
		return var_03;
	}

	return undefined;
}

//Function Number: 4
func_8215(param_00,param_01)
{
	var_02 = "mp/loot/weapon/" + param_00 + ".csv";
	var_03 = tablelookup(var_02,0,param_01,3);
	return var_03;
}

//Function Number: 5
lookupvariantref(param_00,param_01)
{
	var_02 = "mp/loot/weapon/" + param_00 + ".csv";
	var_03 = tablelookup(var_02,0,param_01,1);
	return var_03;
}

//Function Number: 6
func_A001(param_00)
{
	return param_00 >= 1 && param_00 <= 9999;
}

//Function Number: 7
func_9E69(param_00)
{
	return param_00 >= 10000 && param_00 <= 19999;
}

//Function Number: 8
func_9F08(param_00)
{
	return param_00 >= 20000 && param_00 <= 29999;
}

//Function Number: 9
func_9D90(param_00)
{
	return param_00 >= 30000 && param_00 <= -25537;
}

//Function Number: 10
func_9D95(param_00)
{
	return param_00 >= -25536 && param_00 <= -15537;
}

//Function Number: 11
func_36A4(param_00,param_01,param_02)
{
	if(!isdefined(level.var_B09C[param_01]))
	{
		level.var_B09C[param_01] = [];
	}

	var_03 = function_02C3(param_00);
	var_04 = func_DD6A(var_03,param_02);
	level.var_B09C[param_01][param_02] = var_04;
	return var_04;
}

//Function Number: 12
func_DD6A(param_00,param_01)
{
	var_02 = tablelookuprownum(param_00,0,param_01);
	var_03 = spawnstruct();
	var_03.var_DE3F = tablelookupbyrow(param_00,var_02,1);
	var_03.var_13C74 = tablelookupbyrow(param_00,var_02,1);
	var_03.var_C946 = [];
	for(var_04 = 0;var_04 < 3;var_04++)
	{
		var_05 = tablelookupbyrow(param_00,var_02,5 + var_04);
		if(isdefined(var_05) && var_05 != "")
		{
			var_03.var_C946[var_03.var_C946.size] = var_05;
		}
	}

	var_03.var_DB52 = int(tablelookupbyrow(param_00,var_02,4));
	var_03.var_1318B = param_01;
	return var_03;
}

//Function Number: 13
getweaponqualitybyid(param_00,param_01)
{
	if(!isdefined(param_01) || param_01 < 0)
	{
		return 0;
	}

	var_02 = function_02C3(param_00);
	var_03 = int(tablelookup(var_02,0,param_01,4));
	return var_03;
}

//Function Number: 14
getlootweaponref(param_00)
{
	return level.lootweaponrefs[param_00];
}

//Function Number: 15
weaponhasprestigenuke(param_00)
{
	var_01 = scripts\mp\_utility::func_8234(param_00);
	var_02 = var_01 + "_nuke";
	if(isdefined(level.prestigeextras[var_02]))
	{
		return self isitemunlocked(var_02,"prestigeExtras",1);
	}

	return 0;
}