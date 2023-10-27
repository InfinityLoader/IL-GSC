/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\mp\_powerloot.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 18
 * Decompile Time: 719 ms
 * Timestamp: 10/27/2023 12:21:18 AM
*******************************************************************/

//Function Number: 1
init()
{
	level.var_D77E = spawnstruct();
	level.var_D77E.var_C947 = [];
	level.var_D77E.var_D799 = [];
	func_DF04("passive_decreased_cost");
	func_DF04("passive_reduced_cooldown");
	func_DF04("passive_increased_charges");
	func_DF06("power_blinkKnife",["passive_health_regen_on_kill"]);
	func_DF06("power_clusterGrenade",["passive_increased_speed","passive_increased_spread","passive_increased_entities"]);
}

//Function Number: 2
func_804B(param_00)
{
	if(param_00 <= 0)
	{
		return [];
	}

	var_01 = level.var_D77E.var_C947[param_00];
	if(!isdefined(var_01))
	{
		var_02 = tablelookuprownum("mp/loot/iw7_power_loot_master.csv",0,param_00);
		var_03 = [8,9,10];
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

		level.var_D77E.var_C947[param_00] = var_01;
	}

	return var_01;
}

//Function Number: 3
func_B030(param_00,param_01)
{
	var_02 = tablelookupbyrow("mp/loot/iw7_power_loot_master.csv",param_00,param_01);
	return scripts\common\utility::func_116D7(isdefined(var_02) && var_02 != "",var_02,undefined);
}

//Function Number: 4
func_D779(param_00,param_01)
{
	if(param_00 == "power_teleport" && isdefined(self.var_115FC) && self.var_115FC)
	{
		return 0;
	}

	var_03 = self.var_D782[param_00];
	if(!isdefined(var_03) || !isdefined(var_03.var_C946))
	{
		return 0;
	}

	foreach(var_05 in var_03.var_C946)
	{
		if(var_05 == param_01)
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 5
func_DF06(param_00,param_01)
{
	var_02 = level.var_D77E;
	foreach(var_04 in param_01)
	{
		if(!isdefined(var_02.var_D799[var_04]))
		{
			var_02.var_D799[var_04] = [];
		}

		var_02.var_D799[var_04][param_00] = 1;
	}
}

//Function Number: 6
func_DF04(param_00)
{
	var_01 = level.var_D77E;
	if(!isdefined(var_01.var_D799[param_00]))
	{
		var_01.var_D799[param_00] = [];
	}

	var_01.var_D799[param_00]["all"] = 1;
}

//Function Number: 7
func_9ED5(param_00,param_01)
{
	var_02 = level.var_D77E;
	if(!isdefined(var_02.var_D799[param_01]))
	{
		return 0;
	}

	if(scripts\mp\_utility::func_9FB3(var_02.var_D799[param_01]["all"]))
	{
		return 1;
	}

	return scripts\mp\_utility::func_9FB3(var_02.var_D799[param_01][param_00]);
}

//Function Number: 8
func_B937(param_00)
{
	if(func_D779(param_00,"passive_decreased_cost"))
	{
		return 1.15;
	}

	return 1;
}

//Function Number: 9
func_7FC1(param_00,param_01)
{
	if(func_D779(param_00,"passive_increased_duration"))
	{
		switch(param_00)
		{
			case "power_opticWave":
				return param_01 + 0.5;

			case "power_domeshield":
				return param_01 + 2;

			case "power_overCharge":
			case "power_splashGrenade":
			case "power_fearGrenade":
			case "power_blackholeGrenade":
			case "power_phaseShift":
				return param_01 + 1;

			default:
				return float(param_01) * float(1.15);
		}
	}

	return param_01;
}

//Function Number: 10
func_7FBF(param_00,param_01)
{
	if(func_D779(param_00,"passive_reduced_cooldown"))
	{
		switch(param_00)
		{
			default:
				return float(param_01) * float(0.9);
		}
	}

	return param_01;
}

//Function Number: 11
func_7FC0(param_00,param_01)
{
	if(func_D779(param_00,"passive_increased_damage"))
	{
		switch(param_00)
		{
			case "power_fearGrenade":
				return param_01 * 1.5;

			default:
				return float(param_01) * float(1.15);
		}
	}

	return param_01;
}

//Function Number: 12
func_7FC7(param_00,param_01)
{
	if(func_D779(param_00,"passive_increased_spread"))
	{
		switch(param_00)
		{
			default:
				if(function_02A5(param_01))
				{
					return param_01 * float(1.15);
				}
				else
				{
					return float(param_01) * float(1.15);
				}
	
				break;
		}
	}

	return param_01;
}

//Function Number: 13
func_7FC4(param_00,param_01)
{
	if(func_D779(param_00,"passive_increased_radius"))
	{
		switch(param_00)
		{
			default:
				return int(float(param_01) * float(1.15));
		}
	}

	return param_01;
}

//Function Number: 14
func_7FC5(param_00,param_01)
{
	if(func_D779(param_00,"passive_increased_range"))
	{
		switch(param_00)
		{
			default:
				return float(param_01) * float(1.15);
		}
	}

	return param_01;
}

//Function Number: 15
func_7FBE(param_00,param_01)
{
	if(func_D779(param_00,"passive_increased_charges"))
	{
		switch(param_00)
		{
			default:
				return int(param_01) + int(1);
		}
	}

	return param_01;
}

//Function Number: 16
func_7FC2(param_00,param_01)
{
	if(func_D779(param_00,"passive_increased_entities"))
	{
		switch(param_00)
		{
			case "power_shardBall":
				return param_01 + 5;

			default:
				return int(param_01) + int(1);
		}
	}

	return param_01;
}

//Function Number: 17
func_7FC3(param_00,param_01)
{
	if(func_D779(param_00,"passive_increased_health"))
	{
		switch(param_00)
		{
			case "power_explodingDrone":
			case "power_blackholeGrenade":
				return param_01 + 20;

			default:
				return float(param_01) * float(1.15);
		}
	}

	return param_01;
}

//Function Number: 18
func_7FC6(param_00,param_01)
{
	if(func_D779(param_00,"passive_increased_speed"))
	{
		switch(param_00)
		{
			case "power_blackholeGrenade":
				return param_01 * 0.6;

			case "power_arcGrenade":
				return param_01 * 0.25;

			case "power_adrenaline":
				return param_01 + 0.1;

			default:
				return float(param_01) * float(0.85);
		}
	}

	return param_01;
}