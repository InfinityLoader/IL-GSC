/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 1292.gsc
 * Game: Call of Duty: WWII
 * Platform: PC
 * Function Count: 65
 * Decompile Time: 81 ms
 * Timestamp: 10/27/2023 3:24:27 AM
*******************************************************************/

//Function Number: 1
func_534F()
{
	var_00 = "mp/spawnConstantsPerMap.csv";
	var_01 = function_027B(var_00);
	for(var_02 = 1;var_02 < var_01;var_02++)
	{
		var_03 = tablelookup(var_00,0,"spawn_constants",var_02);
		if(isdefined(var_03) && func_57DA(var_03))
		{
			var_04 = func_468F(var_00,var_02);
			level.var_9036[var_03] = var_04;
			var_05 = tablelookup(var_00,0,"save_squared_constant",var_02);
			if(isdefined(var_05) && var_05 == "TRUE")
			{
				level.var_9037[var_03] = squared(var_04);
			}
		}
	}

	if(level.var_3FDC == "ctf")
	{
		level.var_9036["allyDeathTime"] = 4000;
	}
}

//Function Number: 2
func_57DA(param_00)
{
	switch(param_00)
	{
		case "DOMPointTooCloseDistance":
		case "HPZoneTooCloseDistance":
		case "HPZoneNearDistance":
		case "CTFBaseDistance":
		case "allyDeathTime":
		case "allyDeathDistance":
		case "enemySpawnAreaTime":
		case "enemySpawnAreaDistance":
		case "allyDistance":
		case "enemyDistance":
		case "LOSDistance":
		case "DOMPointPerferLastTeamSpawnTime":
			return 1;

		default:
			return 0;
	}
}

//Function Number: 3
func_468F(param_00,param_01)
{
	var_02 = tablelookup(param_00,0,maps\mp\_utility::func_4571(),param_01);
	if(!isdefined(var_02) || var_02 == "")
	{
		var_02 = tablelookup(param_00,0,"mp_default",param_01);
	}

	return int(var_02);
}

//Function Number: 4
func_80A2(param_00,param_01,param_02,param_03,param_04)
{
	if(isdefined(param_04))
	{
		var_05 = [[ param_01 ]](param_02,param_03,param_04);
	}
	else
	{
		var_05 = [[ param_02 ]](param_03,param_04);
	}

	var_05 = clamp(var_05,0,100);
	var_05 = var_05 * param_00;
	param_03.var_2B5E[param_03.var_2B5E.size] = var_05;
	param_03.var_9AB7 = param_03.var_9AB7 + 100 * param_00;
	return var_05;
}

//Function Number: 5
func_2857(param_00,param_01,param_02,param_03)
{
	if(isdefined(param_03))
	{
		var_04 = [[ param_00 ]](param_01,param_02,param_03);
	}
	else
	{
		var_04 = [[ param_01 ]](param_02,param_03);
	}

	var_04 = clamp(var_04,0,100);
	param_02.var_2B4F[param_02.var_2B4F.size] = var_04;
	return var_04;
}

//Function Number: 6
func_1437(param_00,param_01)
{
	foreach(var_03 in level.var_1FFD)
	{
		if(!isdefined(var_03))
		{
			continue;
		}

		if(distancesquared(param_01.var_116,var_03.var_116) < 2500)
		{
			return 0;
		}
	}

	return 100;
}

//Function Number: 7
func_1443(param_00,param_01)
{
	foreach(var_03 in level.var_486C)
	{
		if(!isdefined(var_03) || !var_03 func_56E4(self))
		{
			continue;
		}

		if(distancesquared(param_01.var_116,var_03.var_116) < 65536)
		{
			return 0;
		}
	}

	return 100;
}

//Function Number: 8
func_1447(param_00,param_01)
{
	var_02 = level.var_61ED;
	foreach(var_04 in var_02)
	{
		if(!isdefined(var_04) || !var_04 func_56E4(self))
		{
			continue;
		}

		if(distancesquared(param_01.var_116,var_04.var_116) < 65536)
		{
			return 0;
		}
	}

	return 100;
}

//Function Number: 9
func_56E4(param_00)
{
	if(!level.var_984D || level.var_3EC4 || isdefined(param_00) && !isdefined(param_00.var_1A7))
	{
		return 1;
	}

	if(!isdefined(self.var_117) || !isdefined(self.var_117.var_1A7))
	{
		return 1;
	}

	if(isdefined(param_00) && param_00 == self.var_117)
	{
		return 1;
	}

	var_01 = self.var_117.var_1A7;
	return var_01 != param_00.var_1A7;
}

//Function Number: 10
func_144D(param_00,param_01)
{
	if(!isdefined(level.var_80B4))
	{
		return 100;
	}

	if(!param_01.var_6C97)
	{
		return 100;
	}

	var_02 = lib_0526::func_4675(param_01.var_116);
	if(var_02 > 0.25)
	{
		return 0;
	}

	return 100;
}

//Function Number: 11
func_143A(param_00,param_01)
{
	var_02 = maps\mp\gametypes\_gameobjects::func_44B9(param_00);
	if(param_01.var_266E[var_02] > 0)
	{
		return 0;
	}

	return 100;
}

//Function Number: 12
func_1442(param_00,param_01)
{
	var_02 = maps\mp\gametypes\_gameobjects::func_44B9(param_00);
	if(param_01.var_3EFF[var_02] > 0)
	{
		return 0;
	}

	return 100;
}

//Function Number: 13
func_765F(param_00,param_01)
{
	var_02 = maps\mp\_utility::func_45DE(param_00);
	if(getdvarint("disableSpawnClaim") || level.var_909B["preferClaimedSpawn"]["scoreFactorWeight"] == 0)
	{
		return 0;
	}

	if(!isdefined(level.var_9034))
	{
		level.var_9034 = 0;
		var_03 = lib_050D::func_44F9();
		var_04 = lib_050D::func_46A0("allies");
		var_05 = lib_050D::func_46A0("axis");
		foreach(var_11, var_07 in var_03)
		{
			var_08 = 9999999;
			foreach(var_0A in var_04)
			{
				var_0B = distance(var_07.var_116,var_0A.var_116);
				if(var_0B < var_08)
				{
					var_08 = var_0B;
				}
			}

			if(isdefined(var_07.var_165) && var_07.var_165 == "axis_override")
			{
				var_07.var_2BD3 = "axis";
				continue;
			}

			if(isdefined(var_07.var_165) && var_07.var_165 == "allies_override")
			{
				var_07.var_2BD3 = "allies";
				continue;
			}

			var_07.var_2BD3 = "allies";
			foreach(var_0E in var_05)
			{
				var_0F = distance(var_07.var_116,var_0E.var_116);
				if(var_0F < var_08 / 2)
				{
					var_07.var_2BD3 = "axis";
					break;
				}
				else if(var_0F <= var_08 * 2)
				{
					var_07.var_2BD3 = "none";
				}
			}
		}
	}

	if(level.var_9034)
	{
		var_12 = maps\mp\_utility::func_45DE(param_00);
	}
	else
	{
		var_12 = param_01;
	}

	if(param_01.var_2BD3 == var_12)
	{
		return 100;
	}

	return 0;
}

//Function Number: 14
func_10DE(param_00,param_01)
{
	if(func_2936() && isdefined(param_01.var_3EF5) && level.var_3EF3.var_565F[self.var_1A7] && param_01.var_3EF5 != self.var_1A7)
	{
		return 0;
	}

	return 100;
}

//Function Number: 15
func_1451(param_00,param_01)
{
	if(positionwouldtelefrag(param_01.var_116))
	{
		foreach(var_03 in param_01.var_CAD)
		{
			if(!positionwouldtelefrag(var_03))
			{
				break;
			}
		}

		return 0;
	}

	return 100;
}

//Function Number: 16
func_144C(param_00,param_01)
{
	if(isdefined(self.var_5BE0) && self.var_5BE0 == param_01)
	{
		return 0;
	}

	return 100;
}

//Function Number: 17
func_144A(param_00,param_01)
{
	if(isdefined(param_01.var_5BE2))
	{
		var_02 = gettime() - param_01.var_5BE2;
		if(var_02 > 4000)
		{
			return 100;
		}

		return var_02 / 4000 * 100;
	}

	return 100;
}

//Function Number: 18
func_143E(param_00,param_01)
{
	if(isdefined(param_01.var_5BE1) && !level.var_984D || param_01.var_5BE1 != param_00)
	{
		var_02 = param_01.var_5BE2 + 500;
		if(gettime() < var_02)
		{
			return 0;
		}
	}

	return 100;
}

//Function Number: 19
func_1438(param_00,param_01)
{
	var_02 = func_3B92(param_00,param_01,1);
	if(isdefined(var_02))
	{
		var_03 = var_02 / level.var_9037["enemySpawnAreaDistance"];
		return var_03 * 100;
	}

	return 100;
}

//Function Number: 20
func_3B92(param_00,param_01,param_02)
{
	var_03 = maps\mp\_utility::func_45DE(param_00);
	if(!level.var_984D)
	{
		param_00 = "all";
		var_03 = "all";
	}

	if(!isdefined(level.var_7AD4[var_03]))
	{
		return undefined;
	}

	var_04 = [];
	var_05 = 99999999;
	var_06 = 0;
	foreach(var_08 in level.var_7AD4[var_03])
	{
		var_09 = gettime() - var_08["time"];
		if(var_09 > level.var_9036["enemySpawnAreaTime"])
		{
			continue;
		}

		var_04[var_04.size] = var_08;
		var_0A = distancesquared(param_01.var_116,var_08["position"]);
		if((param_02 && var_0A > level.var_9037["enemySpawnAreaDistance"]) || !level.var_984D && var_08["player"] == self.var_48CA)
		{
			continue;
		}

		if(var_0A < var_05)
		{
			var_05 = var_0A;
			var_06 = 1;
		}
	}

	if(var_06)
	{
		return var_05;
	}

	return undefined;
}

//Function Number: 21
func_1450(param_00,param_01,param_02)
{
	if(!isdefined(param_02))
	{
		return 0;
	}

	var_03 = distancesquared(param_01.var_116,param_02["position"]);
	var_04 = var_03 / level.var_9037["enemySpawnAreaDistance"];
	return var_04 * 100;
}

//Function Number: 22
func_143F(param_00,param_01)
{
	var_02 = level.var_909B["avoidEnemySpawnLocations"]["scoreFactorWeight"];
	var_03 = maps\mp\_utility::func_45DE(param_00);
	if(!level.var_984D)
	{
		param_00 = "all";
		var_03 = "all";
	}

	var_04 = 0;
	var_05 = [];
	foreach(var_07 in level.var_7AD4[var_03])
	{
		var_08 = gettime() - var_07["time"];
		if(var_08 > level.var_9036["enemySpawnAreaTime"])
		{
			continue;
		}

		var_05[var_05.size] = var_07;
		if(level.var_984D || var_07["player"] != self.var_48CA)
		{
			var_04 = var_04 + func_80A2(var_02,::func_1450,param_00,param_01,var_07);
		}
	}

	level.var_7AD4[var_03] = var_05;
	return var_04;
}

//Function Number: 23
func_144F(param_00,param_01,param_02)
{
	var_03 = distancesquared(param_02.var_116,param_01.var_116);
	if(var_03 < 692224)
	{
		return 0;
	}

	return 100;
}

//Function Number: 24
func_144E(param_00,param_01,param_02)
{
	return func_144F(param_00,param_01,maps/mp/gametypes/hp::func_4484());
}

//Function Number: 25
func_68A3(param_00,param_01)
{
	if(!isdefined(param_01.var_9849) || param_01.var_9849 == "none" || param_00 == param_01.var_9849)
	{
		return 100;
	}

	return 0;
}

//Function Number: 26
func_1446(param_00,param_01)
{
	if(!isdefined(self.var_5B90))
	{
		return 100;
	}

	var_02 = distancesquared(param_01.var_116,self.var_5B90);
	if(var_02 > 4000000)
	{
		return 100;
	}

	var_03 = var_02 / 4000000;
	return var_03 * 100;
}

//Function Number: 27
func_7664(param_00,param_01)
{
	if(!isdefined(self.var_5B90))
	{
		return 0;
	}

	var_02 = distancesquared(param_01.var_116,self.var_5B90);
	if(var_02 > 400000000)
	{
		return 0;
	}

	var_03 = 1 - var_02 / 400000000;
	return var_03 * 100;
}

//Function Number: 28
func_1439(param_00,param_01)
{
	var_02 = func_3B91(param_00,param_01,1);
	if(isdefined(var_02))
	{
		var_03 = var_02 / level.var_9037["allyDeathDistance"];
		return var_03 * 100;
	}

	return 100;
}

//Function Number: 29
func_3B91(param_00,param_01,param_02)
{
	if(!level.var_984D)
	{
		param_00 = "all";
	}

	if(!isdefined(level.var_7AD1[param_00]))
	{
		return undefined;
	}

	var_03 = [];
	var_04 = 99999999;
	var_05 = 0;
	foreach(var_07 in level.var_7AD1[param_00])
	{
		var_08 = gettime() - var_07["time"];
		if(var_08 > level.var_9036["allyDeathTime"])
		{
			continue;
		}

		var_03[var_03.size] = var_07;
		var_09 = distancesquared(param_01.var_116,var_07["position"]);
		if((param_02 && var_09 > level.var_9037["allyDeathDistance"]) || !level.var_984D && var_07["player"] != self.var_48CA)
		{
			continue;
		}

		if(var_09 < var_04)
		{
			var_04 = var_09;
			var_05 = 1;
		}
	}

	level.var_7AD1[param_00] = var_03;
	if(var_05)
	{
		return var_04;
	}

	return undefined;
}

//Function Number: 30
func_143B(param_00,param_01,param_02)
{
	if(!isdefined(param_02))
	{
		return 0;
	}

	var_03 = distancesquared(param_01.var_116,param_02["position"]);
	var_04 = var_03 / level.var_9037["allyDeathDistance"];
	return var_04 * 100;
}

//Function Number: 31
func_1435(param_00,param_01)
{
	var_02 = level.var_909B["avoidAllyDeathLocations"]["scoreFactorWeight"];
	if(!level.var_984D)
	{
		param_00 = "all";
	}

	var_03 = 0;
	var_04 = [];
	foreach(var_06 in level.var_7AD1[param_00])
	{
		var_07 = gettime() - var_06["time"];
		if(var_07 > level.var_9036["allyDeathTime"])
		{
			continue;
		}

		var_04[var_04.size] = var_06;
		if(level.var_984D || var_06["player"] == self.var_48CA)
		{
			var_03 = var_03 + func_80A2(var_02,::func_143B,param_00,param_01,var_06);
		}
	}

	level.var_7AD1[param_00] = var_04;
	return var_03;
}

//Function Number: 32
func_1445(param_00,param_01)
{
	if(!isdefined(self.var_E6) || !isdefined(self.var_E6.var_116))
	{
		return 100;
	}

	if(!maps\mp\_utility::func_57A0(self.var_E6))
	{
		return 100;
	}

	var_02 = distancesquared(param_01.var_116,self.var_E6.var_116);
	if(var_02 > 4000000)
	{
		return 100;
	}

	var_03 = var_02 / 4000000;
	return var_03 * 100;
}

//Function Number: 33
func_765D(param_00,param_01)
{
	var_02 = getspawnpointtotalplayers(param_01.var_D4,param_00);
	if(var_02 == 0)
	{
		return 0;
	}

	var_03 = getspawnpointdistsum(param_01.var_D4,param_00);
	if(!isdefined(var_03))
	{
		return 0;
	}

	var_03 = var_03 / var_02;
	var_03 = min(var_03,level.var_9036["enemyDistance"]);
	var_04 = 1 - var_03 / level.var_9036["enemyDistance"];
	return var_04 * 100;
}

//Function Number: 34
func_7660(param_00,param_01)
{
	if(getspawnpointtotalplayers(param_01.var_D4,param_00) == 0)
	{
		return 0;
	}

	var_02 = getspawnpointmindist(param_01.var_D4,param_00);
	if(!isdefined(var_02))
	{
		return 0;
	}

	var_03 = 1 - var_02 / level.var_9036["allyDistance"];
	return var_03 * 100;
}

//Function Number: 35
func_AAFF(param_00,param_01)
{
	var_02 = maps\mp\gametypes\_gameobjects::func_44B9(param_00);
	if(getspawnpointtotalplayers(param_01.var_D4,var_02) == 0)
	{
		return 100;
	}

	var_03 = getspawnpointmindist(param_01.var_D4,var_02);
	if(!isdefined(var_03))
	{
		return 0;
	}

	var_04 = var_03 / level.var_9036["enemyDistance"];
	return var_04 * 100;
}

//Function Number: 36
func_7669(param_00,param_01,param_02)
{
	var_03 = getspawnpointdistancetoplayer(param_01.var_D4,param_02 getentitynumber());
	if(!isdefined(var_03) || !maps\mp\_utility::func_57A0(param_02))
	{
		return 100;
	}

	var_04 = 1 - var_03 / level.var_9036["allyDistance"];
	return var_04 * 100;
}

//Function Number: 37
func_1449(param_00,param_01,param_02)
{
	var_03 = getspawnpointdistancetoplayer(param_01.var_D4,param_02 getentitynumber());
	if(!isdefined(var_03) || !maps\mp\_utility::func_57A0(param_02))
	{
		return 100;
	}

	var_04 = var_03 / level.var_9036["enemyDistance"];
	return var_04 * 100;
}

//Function Number: 38
func_143C(param_00,param_01)
{
	var_02 = 0;
	var_03 = 0;
	if(isdefined(level.var_909B["avoidEnemies"]))
	{
		var_02 = level.var_909B["avoidEnemies"]["scoreFactorWeight"];
	}

	if(isdefined(level.var_909B["preferAllies"]))
	{
		var_03 = level.var_909B["preferAllies"]["scoreFactorWeight"];
	}

	var_04 = 0;
	if(isdefined(param_00))
	{
		foreach(var_06 in level.var_744A)
		{
			if(!isdefined(var_06) || !isdefined(var_06.var_1A7) || var_06 == self || function_02D5(var_06) == "spectator")
			{
				continue;
			}
			else
			{
				if(((level.var_984D && var_06.var_1A7 != param_00) || !level.var_984D) && var_02 > 0)
				{
					var_04 = var_04 + func_80A2(var_02,::func_1449,param_00,param_01,var_06);
					continue;
				}

				if(level.var_984D && var_06.var_1A7 == param_00 && var_03 > 0)
				{
					var_04 = var_04 + func_80A2(var_03,::func_7669,param_00,param_01,var_06);
				}
			}
		}
	}

	return var_04;
}

//Function Number: 39
func_7663(param_00,param_01)
{
	if(param_01.var_3767 > 0)
	{
		var_02 = param_01.var_3ED2 / param_01.var_3767 / param_01.var_3ED1.var_4D3F * 1.33;
	}
	else
	{
		var_02 = 0;
	}

	return var_02 * 100;
}

//Function Number: 40
func_7662(param_00,param_01)
{
	if(param_01.var_3767 > 0 && param_01.var_3ED1.var_645F > 0)
	{
		var_02 = param_01.var_3767 / param_01.var_3ED1.var_645F;
	}
	else
	{
		var_02 = 0;
	}

	return var_02 * 100;
}

//Function Number: 41
func_7661(param_00,param_01)
{
	if((param_00 == "allies" && level.var_BF7 == 0) || param_00 == "axis" && level.var_147E == 0)
	{
		return 0;
	}

	return func_7662(param_00,param_01);
}

//Function Number: 42
func_1441(param_00,param_01)
{
	if(param_01.var_3ED2 > level.var_9037["CTFBaseDistance"])
	{
		return 100;
	}

	var_02 = param_01.var_3ED2 / level.var_9037["CTFBaseDistance"];
	return var_02 * 100;
}

//Function Number: 43
func_1440(param_00,param_01)
{
	if((param_00 == "allies" && level.var_BF7 == 0) || param_00 == "axis" && level.var_147E == 0)
	{
		return func_1441(param_00,param_01);
	}

	return 0;
}

//Function Number: 44
func_765E(param_00,param_01)
{
	var_02 = maps/mp/gametypes/dom::func_4638(param_00);
	if(isdefined(param_01.var_766F) && var_02[param_01.var_766F])
	{
		return 100;
	}

	return 0;
}

//Function Number: 45
func_143D(param_00,param_01)
{
	var_02 = maps/mp/gametypes/dom::func_4638(maps\mp\_utility::func_45DE(param_00));
	if(!isdefined(param_01.var_766F) || !var_02[param_01.var_766F])
	{
		return 100;
	}

	var_03 = distancesquared(param_01.var_116,maps/mp/gametypes/dom::func_44E1(param_01.var_766F));
	var_04 = var_03 / level.var_9037["DOMPointTooCloseDistance"];
	return 100 * var_04;
}

//Function Number: 46
func_7676(param_00,param_01)
{
	if(!isdefined(level.var_321C) || !isdefined(level.var_321C[param_00]))
	{
		return 0;
	}

	var_02 = gettime() - level.var_321C[param_00]["time"];
	if(var_02 > level.var_9036["DOMPointPerferLastTeamSpawnTime"])
	{
		level.var_321C[param_00] = undefined;
		return 0;
	}

	if(isdefined(param_01.var_766F) && param_01.var_766F == level.var_321C[param_00]["flag"])
	{
		return 100;
	}

	return 0;
}

//Function Number: 47
func_7A5E(param_00,param_01)
{
	return randomintrange(0,99);
}

//Function Number: 48
func_7667(param_00,param_01)
{
	var_02 = maps/mp/gametypes/hp::func_4484();
	var_03 = distancesquared(var_02.var_116,param_01.var_116);
	var_04 = var_03 - 692224;
	var_05 = 6067776;
	var_06 = 1867776;
	if(var_04 >= var_06)
	{
		return 100 * 1 - 0.25 * var_04 - var_06 / var_05 - var_06;
	}

	if(var_04 > 0)
	{
		return 100 * var_04 / var_06;
	}

	return 0;
}

//Function Number: 49
func_1452(param_00,param_01)
{
	var_02 = maps/mp/gametypes/hp::func_4484();
	var_03 = distancesquared(var_02.var_116,param_01.var_116);
	if(var_03 <= level.var_9037["HPZoneTooCloseDistance"])
	{
		return 0;
	}

	return 100;
}

//Function Number: 50
func_7666(param_00,param_01)
{
	var_02 = maps/mp/gametypes/hp::func_4484();
	var_03 = distancesquared(var_02.var_116,param_01.var_116);
	if(var_03 >= level.var_9037["HPZoneNearDistance"])
	{
		return 0;
	}

	var_04 = 1 - var_03 / level.var_9037["HPZoneNearDistance"];
	return var_04 * 100;
}

//Function Number: 51
avoidveryclosetorelic(param_00,param_01)
{
	var_02 = level.var_1562[0].var_28D4;
	var_03 = distancesquared(var_02,param_01.var_116);
	if(var_03 <= level.var_9037["HPZoneTooCloseDistance"])
	{
		return 0;
	}

	return 100;
}

//Function Number: 52
prefernearrelic(param_00,param_01)
{
	var_02 = level.var_1562[0].var_28D4;
	var_03 = distancesquared(var_02,param_01.var_116);
	if(var_03 >= level.var_9037["HPZoneNearDistance"])
	{
		return 0;
	}

	var_04 = 1 - var_03 / level.var_9037["HPZoneNearDistance"];
	return var_04 * 100;
}

//Function Number: 53
func_7668(param_00,param_01)
{
	var_02 = maps\mp\_utility::func_45DE(param_00);
	var_03 = getspawnpointnearbyfriendlies(param_01.var_D4,param_00);
	var_04 = getspawnpointnearbyenemies(param_01.var_D4,var_02);
	if(var_03 == 0)
	{
		return 0;
	}

	if(var_04 == 0)
	{
		return 100;
	}

	var_05 = var_03 - var_04;
	if(var_05 <= 0)
	{
		return 0;
	}

	if(var_05 == 1)
	{
		return 35;
	}

	if(var_05 >= 2)
	{
		return 50;
	}

	return 0;
}

//Function Number: 54
func_AB32(param_00,param_01)
{
	if(!isdefined(param_01.var_165))
	{
		return 100;
	}

	if(isdefined(level.zombies_active_spawn_event))
	{
		var_02 = "zombie_event_spawn_" + level.zombies_active_spawn_event;
		if(isdefined(param_01.var_1A5) && param_01.var_1A5 == var_02)
		{
			return 100;
		}
	}

	if(isdefined(level.var_1F1D) && ![[ level.var_1F1D ]](param_01.var_165))
	{
		return 0;
	}

	if(isdefined(level.var_AC88) && [[ level.var_AC88 ]](param_01.var_165))
	{
		return 0;
	}

	return 100;
}

//Function Number: 55
func_AB3F(param_00,param_01)
{
	if(!isdefined(level.var_A24A) || !level.var_A24A)
	{
		return 0;
	}

	if(!isdefined(self.var_5B90) || !isdefined(level.var_4200) || !isdefined(level.var_43F2))
	{
		return 100;
	}

	var_02 = [[ level.var_4200 ]](self.var_5B90);
	if(!isdefined(var_02))
	{
		return 100;
	}

	var_03 = [[ level.var_43F2 ]](var_02,param_01.var_165);
	if(var_03 < 0)
	{
		return 0;
	}

	if(var_03 == 0)
	{
		return 100;
	}

	return 100 / var_03;
}

//Function Number: 56
func_AB40(param_00,param_01)
{
	if(isdefined(level.var_A24A) && level.var_A24A)
	{
		return 0;
	}

	if(!isdefined(level.var_AC88))
	{
		return 0;
	}

	if(!isdefined(self.var_5B90) || !isdefined(level.var_4200) || !isdefined(level.var_43F4))
	{
		return 100;
	}

	var_02 = [[ level.var_4200 ]](self.var_5B90);
	if(!isdefined(var_02))
	{
		return 100;
	}

	var_03 = [[ level.var_43F4 ]](var_02,param_01.var_165);
	if(var_03 < 0)
	{
		return 0;
	}

	if(var_03 == 0)
	{
		return 100;
	}

	return 100 / var_03;
}

//Function Number: 57
func_AB41(param_00,param_01)
{
	if(!isdefined(self.var_5B90))
	{
		return 0;
	}

	var_02 = distance(param_01.var_116,self.var_5B90);
	if(var_02 >= 2500 || var_02 <= 500)
	{
		return 0;
	}

	var_03 = max(0,1 - abs(1500 - var_02) / 1000);
	return var_03 * 100;
}

//Function Number: 58
func_A119(param_00)
{
	if(!func_A11B())
	{
		return;
	}

	func_7FA2(param_00);
	func_A11A();
}

//Function Number: 59
func_A11B()
{
	if(!func_2936())
	{
		return 0;
	}

	var_00 = func_4500();
	var_01 = func_4572();
	var_02 = gettime();
	if(!isdefined(var_00.var_5C09))
	{
		var_00.var_5C09 = var_02;
	}
	else if(var_00.var_565F["allies"] && var_00.var_565F["axis"])
	{
		var_00.var_A1C7 = var_00.var_A1C7 + var_00.var_5C0A;
	}
	else
	{
		var_00.var_32D2 = var_00.var_32D2 + var_00.var_5C0A;
	}

	var_03 = var_02 - var_00.var_5C09 / 1000;
	var_00.var_5C09 = var_02;
	var_00.var_5C0A = var_03;
	var_04 = func_44F2("allies");
	if(!isdefined(var_04))
	{
		return 0;
	}

	var_04 = (var_04[0],var_04[1],0);
	var_00.var_BF3 = var_04;
	var_05 = func_44F2("axis");
	if(!isdefined(var_05))
	{
		return 0;
	}

	var_05 = (var_05[0],var_05[1],0);
	var_00.var_1479 = var_05;
	var_06 = var_05 - var_04;
	var_07 = vectortoyaw(var_06);
	var_08 = var_04 + var_06 * 0.5;
	if(var_07 > 180)
	{
		var_07 = var_07 - 360;
	}
	else if(var_07 < -180)
	{
		var_07 = 360 + var_07;
	}

	var_00.var_5030 = var_08;
	var_00.var_5031 = var_07;
	var_09 = common_scripts\utility::func_98E7(var_00.var_9A9D == "allies","axis","allies");
	var_0A = common_scripts\utility::func_98E7(var_00.var_9A9D == "allies",var_04,var_05);
	var_0B = common_scripts\utility::func_98E7(var_09 == "allies",var_04,var_05);
	var_0C = distance2dsquared(var_0B,(var_01.var_5FEB[0] - var_01.var_3D75,var_01.var_5FEB[1],var_08[2])) < distance2dsquared(var_0A,(var_01.var_5FEB[0] - var_01.var_3D75,var_01.var_5FEB[1],var_08[2]));
	var_0D = distance2dsquared(var_0B,(var_01.var_5FEB[0] + var_01.var_3D75,var_01.var_5FEB[1],var_08[2])) > distance2dsquared(var_0A,(var_01.var_5FEB[0] + var_01.var_3D75,var_01.var_5FEB[1],var_08[2]));
	var_0E = 0;
	var_02 = gettime();
	if(var_02 > var_00.var_5B9D + var_01.var_3D76)
	{
		if((var_07 < var_01.var_3D72 && var_07 > -180 - var_01.var_3D72) || (var_07 > var_01.var_3D70 && var_07 < 180 - var_01.var_3D70) || distance2d(var_01.var_5FEB,var_08) > var_01.var_3D75 || var_0D || var_0C)
		{
			if(isdefined(var_00.var_530B))
			{
				if(var_02 > var_00.var_530B + var_01.var_3D71)
				{
					if(var_0D || var_0C)
					{
						var_0E = 1;
						var_00.var_5B9D = var_02;
						var_00.var_9A9D = var_09;
						level.var_90A2 = 1;
					}

					var_00.var_530B = undefined;
				}
			}
			else
			{
				var_00.var_530B = var_02;
			}
		}
		else
		{
			var_00.var_530B = undefined;
		}
	}
	else
	{
		var_00.var_530B = undefined;
	}

	var_0F = clamp(var_08[0],var_01.var_5FEB[0] - var_01.var_14F,var_01.var_5FEB[0] + var_01.var_14F);
	var_10 = var_01.var_5FEB[1];
	var_08 = (var_0F,var_10,var_08[2]);
	var_11 = 1 - abs(var_08[0] - var_01.var_5FEB[0] / var_01.var_14F);
	var_12 = 0;
	if(var_07 < var_01.var_6224 * var_11 && var_07 > -180 - var_01.var_6224 * var_11)
	{
		if(var_07 >= -90)
		{
			var_07 = clamp(var_07,var_01.var_6224 * var_11,0);
		}
		else
		{
			var_07 = clamp(-1 * var_07,0,var_01.var_60A8 * var_11) + 180;
			var_12 = 1;
		}
	}
	else if(var_07 < var_01.var_6224 * var_11)
	{
		var_12 = 1;
	}
	else if(var_07 > var_01.var_60A8 * var_11 && var_07 < 180 - var_01.var_60A8 * var_11)
	{
		if(var_07 <= 90)
		{
			var_07 = clamp(var_07,0,var_01.var_60A8 * var_11);
		}
		else
		{
			var_07 = clamp(-1 * var_07,var_01.var_6224 * var_11,0) - 180;
			var_12 = 1;
		}
	}
	else if(var_07 > var_01.var_60A8 * var_11)
	{
		var_12 = 1;
	}

	if(!isdefined(var_00.var_9851) || !var_00.var_565F["allies"] || !var_00.var_565F["axis"])
	{
		var_00.var_9851 = var_07;
	}

	var_00.var_9851 = var_07;
	if(!isdefined(var_00.var_6162) || !var_00.var_565F["allies"] || !var_00.var_565F["axis"])
	{
		var_00.var_6162 = var_08;
	}

	var_13 = var_08 - var_00.var_6162;
	var_14 = length2d(var_13);
	var_15 = min(var_14,40 * var_03);
	if(var_15 > 0)
	{
		var_13 = var_13 * var_15 / var_14;
		var_00.var_6162 = var_00.var_6162 + var_13;
	}

	var_16 = anglestoforward((0,var_00.var_9851,0));
	if(var_00.var_3C62)
	{
		var_00.var_5B9D = gettime();
		var_17 = var_00.var_6162 - var_00.var_BF3;
		var_18 = vectordot(var_17,var_16);
		var_00.var_9A9D = common_scripts\utility::func_98E7(var_18 > 0,"allies","axis");
		var_00.var_3C62 = 0;
	}

	var_19 = level.var_908B;
	var_19 = lib_050D::func_44F9();
	foreach(var_1B in var_19)
	{
		var_1C = undefined;
		var_1D = var_00.var_6162 - var_1B.var_116;
		var_18 = vectordot(vectornormalize(var_1D),vectornormalize(var_16));
		if((var_00.var_9A9D == "allies" && var_18 > 0) || var_00.var_9A9D != "allies" && var_18 <= 0)
		{
			if(!var_12)
			{
				var_1C = "allies";
			}
			else
			{
				var_1C = "axis";
			}

			var_1B.var_3EF5 = var_1C;
			continue;
		}

		if(!var_12)
		{
			var_1C = "axis";
		}
		else
		{
			var_1C = "allies";
		}

		var_1B.var_3EF5 = var_1C;
	}

	return 1;
}

//Function Number: 60
func_A11A()
{
	var_00 = isdefined(level.var_602E) && isdefined(level.var_602D);
	var_01 = 0;
	if(!var_00 && !var_01)
	{
		return;
	}

	var_02 = func_4500();
	if(!isdefined(var_02.var_5E94) && isdefined(level.var_602D))
	{
		var_02.var_5E94 = [];
		var_02.var_5E94["line"] = [[ level.var_602D ]]();
		var_02.var_5E94["alliesCenter"] = [[ level.var_602D ]]();
		var_02.var_5E94["axisCenter"] = [[ level.var_602D ]]();
	}

	if(!var_02.var_565F["allies"] && !var_02.var_565F["axis"])
	{
		return;
	}

	var_03 = (var_02.var_6162[0],var_02.var_6162[1],level.var_5FEB[2]);
	var_04 = anglestoright((0,var_02.var_9851,0));
	var_05 = var_03 + var_04 * 5000;
	var_06 = var_03 - var_04 * 5000;
	if(isdefined(level.var_602E))
	{
		var_07 = undefined;
		if(var_02.var_565F["allies"] && var_02.var_565F["axis"])
		{
			var_07 = "FRONT_LINE";
		}
		else
		{
			var_07 = common_scripts\utility::func_98E7(var_02.var_565F["allies"],"FRONT_LINE_ALLIES","FRONT_LINE_AXIS");
		}

		[[ level.var_602E ]](var_02.var_5E94["line"],"allies",var_07,var_05[0],var_05[1],gettime(),undefined,var_06[0],var_06[1]);
	}

	if(isdefined(level.var_602E))
	{
		var_08 = common_scripts\utility::func_98E7(var_02.var_565F["axis"],var_02.var_1479,(10000,10000,10000));
		[[ level.var_602E ]](var_02.var_5E94["axisCenter"],"axis","ANCHOR",var_08[0],var_08[1],gettime());
		var_09 = common_scripts\utility::func_98E7(var_02.var_565F["allies"],var_02.var_BF3,(10000,10000,10000));
		[[ level.var_602E ]](var_02.var_5E94["alliesCenter"],"allies","ANCHOR",var_09[0],var_09[1],gettime());
	}
}

//Function Number: 61
func_44F2(param_00)
{
	var_01 = [];
	foreach(var_03 in level.var_744A)
	{
		if(!isdefined(var_03))
		{
			continue;
		}

		if(!maps\mp\_utility::func_57A0(var_03))
		{
			continue;
		}

		if(var_03.var_1A7 == param_00)
		{
			var_01[var_01.size] = var_03;
		}
	}

	if(var_01.size == 0)
	{
		return undefined;
	}

	var_05 = maps\mp\_utility::func_442E(var_01);
	return var_05;
}

//Function Number: 62
func_7FA2(param_00)
{
	if(!func_2936())
	{
		return;
	}

	var_01 = func_4500();
	var_01.var_565F[param_00] = 1;
	if(getdvarint("scr_frontline_trap_checks") == 0)
	{
		return;
	}

	var_02 = getdvarint("scr_frontline_min_spawns",0);
	if(var_02 == 0)
	{
		var_02 = 4;
	}

	var_03 = maps\mp\_utility::func_45DE(param_00);
	var_04 = 0;
	var_05 = level.var_908B;
	var_05 = lib_050D::func_44F9();
	foreach(var_07 in var_05)
	{
		if(!isdefined(var_07.var_3EF5) || var_07.var_3EF5 != param_00)
		{
			continue;
		}

		if(!isdefined(var_07.var_3EFF) || !isdefined(var_07.var_3EFF[var_03]) || var_07.var_3EFF[var_03] <= 0)
		{
			var_04++;
		}
	}

	var_09 = var_04 / var_05.size;
	if(var_04 < var_02 || var_09 < 0)
	{
		if(var_04 < var_02)
		{
			var_01.var_2F7F[param_00] = 0;
		}
		else
		{
			var_01.var_2F7F[param_00] = 1;
		}

		var_01.var_565F[param_00] = 0;
	}
}

//Function Number: 63
func_2936()
{
	if(getdvarint("spawning_revised_frontline") == 0)
	{
		return 0;
	}

	if(level.var_3FDC != "war" && level.var_3FDC != "conf" && level.var_3FDC != "cranked")
	{
		return 0;
	}

	if(maps\mp\_utility::func_4571() != "mp_d_day")
	{
		return 0;
	}

	return 1;
}

//Function Number: 64
func_4500()
{
	if(!isdefined(level.var_3EF3))
	{
		level.var_3EF3 = spawnstruct();
		level.var_3EF3.var_565F = [];
		level.var_3EF3.var_565F["allies"] = 0;
		level.var_3EF3.var_565F["axis"] = 0;
		level.var_3EF3.var_A1C7 = 0;
		level.var_3EF3.var_32D2 = 0;
		level.var_3EF3.var_5B9D = 0;
		level.var_3EF3.var_530B = undefined;
		level.var_3EF3.var_9A9D = "none";
		level.var_3EF3.var_3C62 = 1;
	}

	return level.var_3EF3;
}

//Function Number: 65
func_4572()
{
	if(!isdefined(level.var_3EF4))
	{
		level.var_3EF4 = spawnstruct();
		var_00 = getentarray("minimap_corner","targetname");
		level.var_3EF4.var_5FEB = lib_050D::func_3B89(var_00[0].var_116,var_00[1].var_116);
		level.var_3EF4.var_14F = 500;
		level.var_3EF4.var_60A8 = 20;
		level.var_3EF4.var_6224 = -20;
		level.var_3EF4.var_3D70 = 50;
		level.var_3EF4.var_3D72 = -50;
		level.var_3EF4.var_3D75 = 850;
		level.var_3EF4.var_3D71 = 2500;
		level.var_3EF4.var_3D76 = 14000;
	}

	return level.var_3EF4;
}