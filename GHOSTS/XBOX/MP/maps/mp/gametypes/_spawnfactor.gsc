/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes\_spawnfactor.gsc
 * Game: Call of Duty: Ghosts
 * Platform: Console
 * Function Count: 30
 * Decompile Time: 517 ms
 * Timestamp: 10/27/2023 1:31:35 AM
*******************************************************************/

//Function Number: 1
func_9267()
{
	if(!isdefined(level.spawn_closeenemydistsq))
	{
		level.spawn_closeenemydistsq = 250000;
	}
}

//Function Number: 2
func_6ADA(param_00,param_01,param_02,param_03)
{
	if(isdefined(param_03))
	{
		var_04 = [[ param_01 ]](param_02,param_03);
	}
	else
	{
		var_04 = [[ param_02 ]](param_03);
	}

	var_04 = clamp(var_04,0,100);
	var_04 = var_04 * param_00;
	return var_04;
}

//Function Number: 3
critical_factor(param_00,param_01)
{
	var_02 = [[ param_00 ]](param_01);
	var_02 = clamp(var_02,0,100);
	return var_02;
}

//Function Number: 4
avoidcarepackages(param_00)
{
	foreach(var_02 in level.carepackages)
	{
		if(!isdefined(var_02))
		{
			continue;
		}

		if(distancesquared(param_00.origin,var_02.origin) < 22500)
		{
			return 0;
		}
	}

	return 100;
}

//Function Number: 5
avoidgrenades(param_00)
{
	foreach(var_02 in level.grenades)
	{
		if(!isdefined(var_02) || !var_02 func_48BA(param_00))
		{
			continue;
		}

		if(distancesquared(param_00.origin,var_02.origin) < 122500)
		{
			return 0;
		}
	}

	return 100;
}

//Function Number: 6
avoidmines(param_00)
{
	var_01 = common_scripts\utility::array_combine(level.mines,level.placedims);
	if(isdefined(level.traps) && level.traps.size > 0)
	{
		var_01 = common_scripts\utility::array_combine(var_01,level.traps);
	}

	foreach(var_03 in var_01)
	{
		if(!isdefined(var_03) || !var_03 func_48BA(param_00))
		{
			continue;
		}

		if(distancesquared(param_00.origin,var_03.origin) < 122500)
		{
			return 0;
		}
	}

	return 100;
}

//Function Number: 7
func_48BA(param_00)
{
	if(!level.teambased || level.friendlyfire || !isdefined(param_00.team))
	{
		return 1;
	}

	var_01 = undefined;
	if(isdefined(self.owner))
	{
		var_01 = self.owner.team;
	}

	if(isdefined(var_01))
	{
		return var_01 != param_00.team;
	}

	return 1;
}

//Function Number: 8
avoidairstrikelocations(param_00)
{
	if(!isdefined(level.artillerydangercenters))
	{
		return 100;
	}

	if(!param_00.outside)
	{
		return 100;
	}

	var_01 = maps\mp\killstreaks\_airstrike::getairstrikedanger(param_00.origin);
	if(var_01 > 0)
	{
		return 0;
	}

	return 100;
}

//Function Number: 9
avoidcornervisibleenemies(param_00)
{
	var_01 = "all";
	if(level.teambased)
	{
		var_01 = maps\mp\gametypes\_gameobjects::func_3A9A(self.team);
	}

	if(param_00.cornersights[var_01] > 0)
	{
		return 0;
	}

	return 100;
}

//Function Number: 10
func_11E8(param_00)
{
	var_01 = "all";
	if(level.teambased)
	{
		var_01 = maps\mp\gametypes\_gameobjects::func_3A9A(self.team);
	}

	if(param_00.fullsights[var_01] > 0)
	{
		return 0;
	}

	return 100;
}

//Function Number: 11
func_8F91(param_00)
{
	var_01 = [];
	var_02 = [];
	if(level.teambased)
	{
		var_01[0] = maps\mp\gametypes\_gameobjects::func_3A9A(self.team);
	}
	else
	{
		var_01[var_01.size] = "all";
	}

	foreach(var_04 in var_01)
	{
		if(param_00.totalplayers[var_04] == 0)
		{
			continue;
		}

		var_02[var_02.size] = var_04;
	}

	if(var_02.size == 0)
	{
		return 100;
	}

	foreach(var_04 in var_02)
	{
		if(param_00.mindistsquared[var_04] < level.spawn_closeenemydistsq)
		{
			return 0;
		}
	}

	return 100;
}

//Function Number: 12
func_11F0(param_00)
{
	if(isdefined(self.allowtelefrag))
	{
		return 100;
	}

	if(positionwouldtelefrag(param_00.origin))
	{
		foreach(var_02 in param_00.alternates)
		{
			if(!positionwouldtelefrag(var_02))
			{
				return 100;
			}
		}

		return 0;
	}

	return 100;
}

//Function Number: 13
avoidsamespawn(param_00)
{
	if(isdefined(self.lastspawnpoint) && self.lastspawnpoint == param_00)
	{
		return 0;
	}

	return 100;
}

//Function Number: 14
avoidenemyspawn(param_00)
{
	if(isdefined(param_00.lastspawnteam) && !level.teambased || param_00.lastspawnteam != self.team)
	{
		var_01 = param_00.lastspawntime + 500;
		if(gettime() < var_01)
		{
			return 0;
		}
	}

	return 100;
}

//Function Number: 15
avoidrecentlyusedbyenemies(param_00)
{
	var_01 = !level.teambased || isdefined(param_00.lastspawnteam) && self.team != param_00.lastspawnteam;
	if(var_01 && isdefined(param_00.lastspawntime))
	{
		var_02 = gettime() - param_00.lastspawntime;
		if(var_02 > 4000)
		{
			return 100;
		}

		return var_02 / 4000 * 100;
	}

	return 100;
}

//Function Number: 16
avoidrecentlyusedbyanyone(param_00)
{
	if(isdefined(param_00.lastspawntime))
	{
		var_01 = gettime() - param_00.lastspawntime;
		if(var_01 > 4000)
		{
			return 100;
		}

		return var_01 / 4000 * 100;
	}

	return 100;
}

//Function Number: 17
avoidlastdeathlocation(param_00)
{
	if(!isdefined(self.lastdeathpos))
	{
		return 100;
	}

	var_01 = distancesquared(param_00.origin,self.lastdeathpos);
	if(var_01 > 3240000)
	{
		return 100;
	}

	var_02 = var_01 / 3240000;
	return var_02 * 100;
}

//Function Number: 18
avoidlastattackerlocation(param_00)
{
	if(!isdefined(self.lastattacker) || !isdefined(self.lastattacker.origin))
	{
		return 100;
	}

	if(!maps\mp\_utility::func_4945(self.lastattacker))
	{
		return 100;
	}

	var_01 = distancesquared(param_00.origin,self.lastattacker.origin);
	if(var_01 > 3240000)
	{
		return 100;
	}

	var_02 = var_01 / 3240000;
	return var_02 * 100;
}

//Function Number: 19
spawnfrontlinethink()
{
	if(!level.teambased)
	{
	}

	while(!isdefined(level.spawnpoints))
	{
		wait(0.05);
	}

	var_00 = undefined;
	var_01 = undefined;
	var_02 = isdefined(level.matchrecording_logevent) && isdefined(level.matchrecording_generateid);
	var_03 = getdvarint("scr_draw_frontline") == 1;
	var_04 = getdvarint("scr_frontline_min_spawns",0);
	if(var_04 == 0)
	{
		var_04 = 3;
	}

	var_05 = getdvarint("scr_frontline_disable_ratio_check",0) != 1;
	for(;;)
	{
		wait(0.5);
		var_06 = [];
		var_07 = [];
		foreach(var_09 in level.players)
		{
			if(!isdefined(var_09))
			{
				continue;
			}

			if(!maps\mp\_utility::func_4945(var_09))
			{
				continue;
			}

			if(var_09.team == "axis")
			{
				var_06[var_06.size] = var_09;
				continue;
			}

			var_07[var_07.size] = var_09;
		}

		var_0B = maps\mp\_utility::func_3A30(var_07);
		if(!isdefined(var_0B))
		{
			wait(0.05);
			continue;
		}

		var_0B = (var_0B[0],var_0B[1],0);
		var_0C = maps\mp\_utility::func_3A30(var_06);
		if(!isdefined(var_0C))
		{
			wait(0.05);
			continue;
		}

		var_0C = (var_0C[0],var_0C[1],0);
		var_0D = var_0C - var_0B;
		var_0E = vectortoyaw(var_0D);
		if(!isdefined(var_00))
		{
			var_00 = var_0E;
		}

		var_0F = 4;
		var_10 = var_0E - var_00;
		if(var_10 > 180)
		{
			var_10 = var_10 - 360;
		}
		else if(var_10 < -180)
		{
			var_10 = 360 + var_10;
		}

		var_0F = clamp(var_10,var_0F * -1,var_0F);
		var_00 = var_00 + var_0F;
		var_11 = var_0B + var_0D * 0.5;
		if(!isdefined(var_01))
		{
			var_01 = var_11;
		}

		var_12 = var_11 - var_01;
		var_13 = length2d(var_12);
		var_14 = min(var_13,100);
		if(var_14 > 0)
		{
			var_12 = var_12 * var_14 / var_13;
			var_01 = var_01 + var_12;
		}

		var_15 = anglestoforward((0,var_00,0));
		var_16 = [];
		var_16["allies"] = 0;
		var_16["axis"] = 0;
		var_17 = level.spawnpoints;
		var_17 = maps\mp\gametypes\_spawnscoring::checkdynamicspawns(var_17);
		foreach(var_19 in var_17)
		{
			var_1A = undefined;
			var_1B = var_01 - var_19.origin;
			var_1C = vectordot(var_1B,var_15);
			if(var_1C > 0)
			{
				var_1A = "allies";
				var_19.forcedteam = var_1A;
			}
			else
			{
				var_1A = "axis";
				var_19.forcedteam = var_1A;
			}

			var_1D = maps\mp\_utility::getotherteam(var_1A);
			if(!isdefined(var_19.fullsights) || !isdefined(var_19.fullsights[var_1D]) || var_19.fullsights[var_1D] <= 0)
			{
				var_16[var_1A]++;
			}
		}

		var_1F = common_scripts\utility::func_803F(var_16["allies"] < var_16["axis"],"allies","axis");
		var_20 = maps\mp\_utility::getotherteam(var_1F);
		var_21 = var_16[var_1F] < var_16[var_20] * 0.5;
		if(var_16[var_1F] <= var_04 || var_05 && var_21)
		{
			foreach(var_19 in var_17)
			{
				var_19.forcedteam = undefined;
			}

			var_01 = undefined;
			var_00 = undefined;
		}

		if(var_02 || var_03)
		{
			if(var_02 && !isdefined(level.frontlinelogids))
			{
				level.frontlinelogids = [];
				level.frontlinelogids["line"] = [[ level.matchrecording_generateid ]]();
				level.frontlinelogids["alliesCenter"] = [[ level.matchrecording_generateid ]]();
				level.frontlinelogids["axisCenter"] = [[ level.matchrecording_generateid ]]();
			}

			if(isdefined(var_01) && isdefined(var_00))
			{
				var_24 = (var_01[0],var_01[1],level.mapcenter[2]);
				var_25 = anglestoright((0,var_00,0));
				var_26 = var_24 + var_25 * 5000;
				var_27 = var_24 - var_25 * 5000;
				if(var_02)
				{
					[[ level.matchrecording_logevent ]](level.frontlinelogids["line"],"allies","FRONT_LINE",var_26[0],var_26[1],gettime(),undefined,var_27[0],var_27[1]);
				}
			}
			else if(var_02)
			{
				[[ level.matchrecording_logevent ]](level.frontlinelogids["line"],"allies","FRONT_LINE",0,0,gettime(),undefined,0,0);
			}

			if(var_02)
			{
				[[ level.matchrecording_logevent ]](level.frontlinelogids["alliesCenter"],"axis","ANCHOR",var_0C[0],var_0C[1],gettime());
				[[ level.matchrecording_logevent ]](level.frontlinelogids["axisCenter"],"allies","ANCHOR",var_0B[0],var_0B[1],gettime());
			}
		}
	}
}

//Function Number: 20
func_9087()
{
	level notify("correctHomogenization");
	level endon("correctHomogenization");
	if(!level.teambased)
	{
	}

	var_00 = 2;
	var_01 = 0;
	var_02 = [];
	var_03 = [];
	var_04 = [];
	var_05 = [];
	var_06 = [];
	var_07 = [];
	var_02 = getspawnarray("mp_tdm_spawn_allies_start");
	var_03 = getspawnarray("mp_tdm_spawn_axis_start");
	var_08 = [];
	while(!isdefined(level.spawnpoints))
	{
		wait(0.05);
	}

	var_09 = tolower(getdvar("mapname"));
	if(var_09 == "mp_strikezone")
	{
		foreach(var_0B in level.spawnpoints)
		{
			if(var_0B.origin[2] < 20000)
			{
				var_04[var_04.size] = var_0B;
				continue;
			}

			var_05[var_05.size] = var_0B;
		}

		if(level.teleport_zone_current == "start")
		{
			var_06 = sortbydistance(var_04,level.mapcenter);
		}
		else
		{
			var_06 = sortbydistance(var_05,level.mapcenter);
		}

		for(var_0D = 0;var_0D < 8;var_0D++)
		{
			var_07[var_0D] = var_06[var_06.size - var_0D + 1];
		}
	}
	else
	{
		var_07 = sortbydistance(level.spawnpoints,level.mapcenter);
		for(var_0D = 0;var_0D < 8;var_0D++)
		{
			var_07[var_0D] = var_06[var_06.size - var_0D + 1];
		}

		var_07[var_07.size] = var_02[0];
		var_07[var_07.size] = var_03[0];
	}

	var_0E = castint(getdvar("scr_anchorSpawns"));
	for(;;)
	{
		wait(5);
		var_0F = [];
		var_10 = [];
		foreach(var_12 in level.players)
		{
			if(!isdefined(var_12))
			{
				continue;
			}

			if(!maps\mp\_utility::func_4945(var_12))
			{
				continue;
			}

			if(var_12.team == "axis")
			{
				var_0F[var_0F.size] = var_12;
				continue;
			}

			var_10[var_10.size] = var_12;
		}

		var_14 = maps\mp\_utility::func_3A30(var_10);
		if(!isdefined(var_14))
		{
			wait(0.05);
			continue;
		}

		var_15 = [];
		var_15 = sortbydistance(var_07,var_14);
		var_16 = var_15[0];
		var_17 = 0;
		var_18 = undefined;
		for(var_0D = 0;var_0D < var_08.size;var_0D++)
		{
			if(var_16 == var_08[var_0D])
			{
				var_17 = 1;
				continue;
			}

			var_17 = 0;
			break;
		}

		if(var_17)
		{
			var_01 = var_01 + 1;
			if(var_01 >= var_00)
			{
				var_18 = var_15[var_15.size - 1];
				var_08[var_08.size] = var_18;
			}
		}

		if(!isdefined(var_18))
		{
			var_18 = var_16;
			var_08[var_08.size] = var_18;
		}

		var_19 = [];
		var_19 = sortbydistance(var_07,var_18.origin);
		var_1A = var_19[var_19.size - 1];
		level.alliesweightorg = var_18.origin;
		level.axisweightorg = var_1A.origin;
	}
}

//Function Number: 21
func_90EF()
{
	var_00 = [];
	var_01 = [];
	if(level.teambased)
	{
		foreach(var_03 in level.players)
		{
			if(!isdefined(var_03))
			{
				continue;
			}

			if(!maps\mp\_utility::func_4945(var_03))
			{
				continue;
			}

			if(var_03.team == "axis")
			{
				var_00[var_00.size] = var_03;
				continue;
			}

			var_01[var_01.size] = var_03;
		}

		var_05 = maps\mp\_utility::func_3A30(var_00);
		var_06 = maps\mp\_utility::func_3A30(var_01);
		if(!isdefined(var_06) || !isdefined(var_05))
		{
			return 0;
		}

		if(common_scripts\utility::func_27FE(var_06,var_05) < 1048576)
		{
			return 1;
		}

		return 0;
	}

	return 0;
}

//Function Number: 22
func_6122(param_00)
{
	if(param_00.totalplayers[self.team] == 0)
	{
		return 0;
	}

	var_01 = param_00.distsumsquared[self.team] / param_00.totalplayers[self.team];
	var_01 = min(var_01,3240000);
	var_02 = 1 - var_01 / 3240000;
	return var_02 * 100;
}

//Function Number: 23
func_11E6(param_00)
{
	var_01 = [];
	var_02 = [];
	if(level.teambased)
	{
		var_01[0] = maps\mp\gametypes\_gameobjects::func_3A9A(self.team);
	}
	else
	{
		var_01[var_01.size] = "all";
	}

	foreach(var_04 in var_01)
	{
		if(param_00.totalplayers[var_04] == 0)
		{
			continue;
		}

		var_02[var_02.size] = var_04;
	}

	if(var_02.size == 0)
	{
		return 100;
	}

	foreach(var_04 in var_02)
	{
		if(param_00.mindistsquared[var_04] < 250000)
		{
			return 0;
		}
	}

	var_08 = 0;
	var_09 = 0;
	foreach(var_04 in var_02)
	{
		var_08 = var_08 + param_00.distsumsquaredcapped[var_04];
		var_09 = var_09 + param_00.totalplayers[var_04];
	}

	var_0C = var_08 / var_09;
	var_0C = min(var_0C,3240000);
	var_0D = var_0C / 3240000;
	return var_0D * 100;
}

//Function Number: 24
avoidclosestenemy(param_00)
{
	var_01 = [];
	var_02 = [];
	if(level.teambased)
	{
		var_01[0] = maps\mp\gametypes\_gameobjects::func_3A9A(self.team);
	}
	else
	{
		var_01[var_01.size] = "all";
	}

	foreach(var_04 in var_01)
	{
		if(param_00.totalplayers[var_04] == 0)
		{
			continue;
		}

		var_02[var_02.size] = var_04;
	}

	if(var_02.size == 0)
	{
		return 100;
	}

	var_06 = 0;
	foreach(var_04 in var_02)
	{
		if(param_00.mindistsquared[var_04] < 250000)
		{
			return 0;
		}

		var_08 = min(param_00.mindistsquared[var_04],3240000);
		var_09 = var_08 / 3240000;
		var_06 = var_06 + var_09 * 100;
	}

	return var_06 / var_02.size;
}

//Function Number: 25
scoredompoint(param_00)
{
	var_01 = undefined;
	foreach(var_03 in level.domflags)
	{
		if(isdefined(var_03.dompointnumber) && var_03.dompointnumber == param_00)
		{
			var_01 = var_03;
			break;
		}
	}

	if(!isdefined(var_01))
	{
		return 100;
	}

	var_05 = var_01 maps\mp\gametypes\_gameobjects::func_3A53();
	if(var_05 == "none")
	{
		return 100;
	}

	return 50;
}

//Function Number: 26
func_6124(param_00,param_01)
{
	if(param_01[0] && param_00.dompointa)
	{
		return scoredompoint(0);
	}

	if(param_01[1] && param_00.dompointb)
	{
		return scoredompoint(1);
	}

	if(param_01[2] && param_00.dompointc)
	{
		return scoredompoint(2);
	}

	return 0;
}

//Function Number: 27
preferclosepoints(param_00,param_01)
{
	foreach(var_03 in param_01)
	{
		if(param_00 == var_03)
		{
			return 100;
		}
	}

	return 0;
}

//Function Number: 28
func_6123(param_00,param_01)
{
	if(isdefined(param_00.teambase) && param_00.teambase == param_01)
	{
		return 100;
	}

	return 0;
}

//Function Number: 29
func_6342(param_00)
{
	return randomintrange(0,99);
}

//Function Number: 30
maxplayerspawninfluencedistsquared(param_00)
{
	return 3240000;
}