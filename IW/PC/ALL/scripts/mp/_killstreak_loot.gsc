/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\mp\_killstreak_loot.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 13
 * Decompile Time: 511 ms
 * Timestamp: 10/27/2023 12:20:44 AM
*******************************************************************/

//Function Number: 1
init()
{
	level.var_110EC = spawnstruct();
	level.var_110EC.var_C947 = [];
	level.var_110EC.var_110F3 = [];
	level.var_110EC.costoverride = [];
	level.var_110EC.costoverridepersist = [];
	level.var_110EC.rarity = [];
	level.var_110EC.var_E76D = [];
	level.var_110EC.baseref = [];
	level.var_110EC.var_DE3F = [];
	level thread registerkillstreakvariantinfo();
	func_DF05("passive_decreased_cost");
	func_DF05("passive_extra_points");
}

//Function Number: 2
registerkillstreakvariantinfo()
{
	level endon("game_ended");
	var_00 = 0;
	var_01 = tablelookupbyrow("mp/loot/iw7_killstreak_loot_master.csv",var_00,0);
	while(var_01 != "")
	{
		level.var_110EC.costoverride[int(var_01)] = int(tablelookup("mp/loot/iw7_killstreak_loot_master.csv",0,var_01,17));
		level.var_110EC.costoverridepersist[int(var_01)] = int(tablelookup("mp/loot/iw7_killstreak_loot_master.csv",0,var_01,18));
		level.var_110EC.rarity[int(var_01)] = int(tablelookup("mp/loot/iw7_killstreak_loot_master.csv",0,var_01,2));
		level.var_110EC.var_E76D[int(var_01)] = var_00;
		level.var_110EC.baseref[int(var_01)] = tablelookup("mp/loot/iw7_killstreak_loot_master.csv",0,var_01,6);
		level.var_110EC.var_DE3F[int(var_01)] = tablelookup("mp/loot/iw7_killstreak_loot_master.csv",0,var_01,1);
		var_00++;
		var_01 = tablelookupbyrow("mp/loot/iw7_killstreak_loot_master.csv",var_00,0);
	}
}

//Function Number: 3
getrandomvariantfrombaseref(param_00)
{
	var_01 = [];
	foreach(var_04, var_03 in level.var_110EC.baseref)
	{
		if(var_03 == param_00)
		{
			var_01[var_01.size] = var_04;
		}
	}

	if(var_01.size == 0)
	{
		return undefined;
	}

	return var_01[randomint(var_01.size)];
}

//Function Number: 4
modifycostforlootitem(param_00,param_01)
{
	if(isdefined(param_00) && param_00 >= 0)
	{
		var_02 = scripts\common\utility::func_116D7(scripts\mp\_utility::_hasperk("specialty_support_killstreaks"),level.var_110EC.costoverridepersist[param_00],level.var_110EC.costoverride[param_00]);
		if(isdefined(var_02))
		{
			return var_02;
		}
	}

	return param_01;
}

//Function Number: 5
getrarityforlootitem(param_00)
{
	var_01 = "";
	var_02 = undefined;
	if(isdefined(param_00))
	{
		var_02 = level.var_110EC.rarity[param_00];
	}

	if(!isdefined(var_02))
	{
		return var_01;
	}

	if(var_02 == 1)
	{
		var_01 = "";
	}
	else if(var_02 == 2)
	{
		var_01 = "rare";
	}
	else if(var_02 == 3)
	{
		var_01 = "legend";
	}
	else
	{
		var_01 = "epic";
	}

	return var_01;
}

//Function Number: 6
func_804B(param_00)
{
	if(param_00 <= 0)
	{
		return [];
	}

	var_01 = level.var_110EC.var_C947[param_00];
	if(!isdefined(var_01))
	{
		var_02 = tablelookuprownum("mp/loot/iw7_killstreak_loot_master.csv",0,param_00);
		var_03 = [7,8,9];
		var_01 = [];
		foreach(var_05 in var_03)
		{
			var_06 = func_B030(var_02,var_05);
			if(!isdefined(var_06))
			{
				break;
			}

			var_01[var_01.size] = var_06;
		}

		level.var_110EC.var_C947[param_00] = var_01;
	}

	return var_01;
}

//Function Number: 7
func_B030(param_00,param_01)
{
	var_02 = tablelookupbyrow("mp/loot/iw7_killstreak_loot_master.csv",param_00,param_01);
	return scripts\common\utility::func_116D7(isdefined(var_02) && var_02 != "",var_02,undefined);
}

//Function Number: 8
func_988A(param_00,param_01)
{
	param_00.var_C946 = param_01;
}

//Function Number: 9
func_DF07(param_00,param_01)
{
	var_02 = level.var_110EC;
	foreach(var_04 in param_01)
	{
		if(!isdefined(var_02.var_110F3[var_04]))
		{
			var_02.var_110F3[var_04] = [];
		}

		var_02.var_110F3[var_04][param_00] = 1;
	}
}

//Function Number: 10
func_DF05(param_00)
{
	var_01 = level.var_110EC;
	if(!isdefined(var_01.var_110F3[param_00]))
	{
		var_01.var_110F3[param_00] = [];
	}

	var_01.var_110F3[param_00]["all"] = 1;
}

//Function Number: 11
func_9ED5(param_00,param_01)
{
	var_02 = level.var_110EC;
	if(!isdefined(var_02.var_110F3[param_01]))
	{
		return 0;
	}

	if(scripts\mp\_utility::func_9FB3(var_02.var_110F3[param_01]["all"]))
	{
		return 1;
	}

	return scripts\mp\_utility::func_9FB3(var_02.var_110F3[param_01][param_00]);
}

//Function Number: 12
func_89BC(param_00)
{
	if(scripts\mp\killstreaks\_utility::func_A69F(param_00,"passive_extra_points"))
	{
		thread func_2A66(self,param_00);
	}
}

//Function Number: 13
func_2A66(param_00,param_01)
{
	param_00 endon("death");
	param_00 waittill("killed_enemy");
	param_00 thread scripts\mp\_utility::func_83B4("extra_points_loot");
}