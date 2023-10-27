/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes\_spawnscoring.gsc
 * Game: Call of Duty: Ghosts
 * Platform: Console
 * Function Count: 43
 * Decompile Time: 716 ms
 * Timestamp: 10/27/2023 1:31:40 AM
*******************************************************************/

//Function Number: 1
func_3BF1(param_00)
{
	param_00 = checkdynamicspawns(param_00);
	var_01["primary"] = [];
	var_01["secondary"] = [];
	var_01["bad"] = [];
	foreach(var_03 in param_00)
	{
		func_464D(var_03);
		var_04 = criticalfactors_nearteam(var_03);
		var_01[var_04][var_01[var_04].size] = var_03;
	}

	if(var_01["primary"].size)
	{
		return func_6AE7(var_01["primary"]);
	}

	if(var_01["secondary"].size)
	{
		return func_6AE7(var_01["secondary"]);
	}

	logbadspawn("Buddy Spawn");
	return func_6D70(param_00[0],param_00);
}

//Function Number: 2
func_6AE7(param_00)
{
	var_01 = param_00[0];
	foreach(var_03 in param_00)
	{
		func_6ADE(var_03);
		if(var_03.totalscore > var_01.totalscore)
		{
			var_01 = var_03;
		}
	}

	var_01 = func_6D70(var_01,param_00);
	return var_01;
}

//Function Number: 3
checkdynamicspawns(param_00)
{
	if(isdefined(level.dynamicspawns))
	{
		param_00 = [[ level.dynamicspawns ]](param_00);
	}

	return param_00;
}

//Function Number: 4
func_6D70(param_00,param_01)
{
	var_02 = param_00;
	var_03 = 0;
	foreach(var_05 in param_01)
	{
		if(var_05.totalscore > 0)
		{
			var_03++;
		}
	}

	if(var_03 == 0 || level.forcebuddyspawn)
	{
		if(level.teambased && level.supportbuddyspawn)
		{
			var_07 = func_3282();
			if(var_07.buddyspawn)
			{
				var_02 = var_07;
			}
		}

		if(var_02.totalscore == 0)
		{
			logbadspawn("UNABLE TO BUDDY SPAWN. Extremely bad.");
			var_02 = param_01[randomint(param_01.size)];
		}
	}

	return var_02;
}

//Function Number: 5
func_328C(param_00,param_01)
{
	if(param_01.size < 2)
	{
		return param_00;
	}

	var_02 = param_01[0];
	if(var_02 == param_00)
	{
		var_02 = param_01[1];
	}

	foreach(var_04 in param_01)
	{
		if(var_04 == param_00)
		{
			continue;
		}

		if(var_04.totalscore > var_02.totalscore)
		{
			var_02 = var_04;
		}
	}

	return var_02;
}

//Function Number: 6
func_3282()
{
	var_00 = addstruct();
	func_464D(var_00);
	var_01 = func_3C3C(self.team);
	var_02 = addstruct();
	var_02.maxtracecount = 18;
	var_02.currenttracecount = 0;
	foreach(var_04 in var_01)
	{
		var_05 = findspawnlocationnearplayer(var_04);
		if(!isdefined(var_05))
		{
			continue;
		}

		if(func_4952(var_04,var_05,var_02))
		{
			var_00.totalscore = 999;
			var_00.buddyspawn = 1;
			var_00.origin = var_05;
			var_00.angles = getbuddyspawnangles(var_04,var_00.origin);
			break;
		}

		if(var_02.currenttracecount == var_02.maxtracecount)
		{
			break;
		}
	}

	return var_00;
}

//Function Number: 7
getbuddyspawnangles(param_00,param_01)
{
	var_02 = (0,param_00.angles[1],0);
	var_03 = nodeexposedtosky(param_01);
	if(isdefined(var_03) && var_03.size > 0)
	{
		var_02 = vectortoangles(var_03[0].origin - param_01);
	}

	return var_02;
}

//Function Number: 8
func_3C3C(param_00)
{
	var_01 = [];
	foreach(var_03 in level.players)
	{
		if(var_03.team != param_00)
		{
			continue;
		}

		if(var_03.sessionstate != "playing")
		{
			continue;
		}

		if(!maps\mp\_utility::func_4945(var_03))
		{
			continue;
		}

		if(var_03 == self)
		{
			continue;
		}

		if(func_4933(var_03))
		{
			continue;
		}

		var_01[var_01.size] = var_03;
	}

	return common_scripts\utility::array_randomize(var_01);
}

//Function Number: 9
func_4933(param_00,param_01)
{
	if(param_00 issighted())
	{
		func_241C(param_00,"IsSighted");
		return 1;
	}

	if(!param_00 isonground())
	{
		func_241C(param_00,"IsOnGround");
		return 1;
	}

	if(param_00 isonladder())
	{
		func_241C(param_00,"IsOnLadder");
		return 1;
	}

	if(param_00 common_scripts\utility::isflashed())
	{
		func_241C(param_00,"isFlashed");
		return 1;
	}

	if(isdefined(param_01) && param_01)
	{
		if(param_00.health < param_00.maxhealth && !isdefined(param_00.lastdamagedtime) || gettime() < param_00.lastdamagedtime + 3000)
		{
			func_241C(param_00,"RecentDamage");
			return 1;
		}
	}
	else if(param_00.health < param_00.maxhealth)
	{
		func_241C(param_00,"MaxHealth");
		return 1;
	}

	if(!maps\mp\gametypes\_spawnfactor::avoidgrenades(param_00))
	{
		func_241C(param_00,"Grenades");
		return 1;
	}

	if(!maps\mp\gametypes\_spawnfactor::avoidmines(param_00))
	{
		func_241C(param_00,"Mines");
		return 1;
	}

	return 0;
}

//Function Number: 10
func_241C(param_00,param_01)
{
	var_02 = "none";
	if(isdefined(param_00.battlebuddy))
	{
		var_02 = param_00.battlebuddy.name;
	}

	function_021E("battlebuddy_spawn","player %s buddy %s reason %s",param_00.name,var_02,param_01);
}

//Function Number: 11
findspawnlocationnearplayer(param_00)
{
	var_01 = maps\mp\gametypes\_spawnlogic::getplayertraceheight(param_00,1);
	var_02 = findbuddypathnode(param_00,var_01,0.5);
	if(isdefined(var_02))
	{
		return var_02.origin;
	}

	return undefined;
}

//Function Number: 12
findbuddypathnode(param_00,param_01,param_02)
{
	var_03 = getnodesinradiussorted(param_00.origin,192,64,param_01,"Path");
	var_04 = undefined;
	if(isdefined(var_03) && var_03.size > 0)
	{
		var_05 = anglestoforward(param_00.angles);
		foreach(var_07 in var_03)
		{
			var_08 = vectornormalize(var_07.origin - param_00.origin);
			var_09 = vectordot(var_05,var_08);
			if(maps\mp\_utility::getmapname() == "mp_fahrenheit")
			{
				if(var_07.origin == (1778.9,171.6,716) || var_07.origin == (1772.1,271.4,716) || var_07.origin == (1657.2,259.6,716) || var_07.origin == (1633.7,333.9,716) || var_07.origin == (1634.4,415.7,716) || var_07.origin == (1537.3,419.3,716) || var_07.origin == (1410.9,420.8,716) || var_07.origin == (1315.6,416.6,716) || var_07.origin == (1079.4,414.6,716) || var_07.origin == (982.9,421.8,716) || var_07.origin == (896.9,423.8,716))
				{
					continue;
				}
			}

			if(var_09 <= param_02 && !positionwouldtelefrag(var_07.origin))
			{
				if(sighttracepassed(param_00.origin + (0,0,param_01),var_07.origin + (0,0,param_01),0,param_00))
				{
					var_04 = var_07;
					if(var_09 <= 0)
					{
						break;
					}
				}
			}
		}
	}

	return var_04;
}

//Function Number: 13
finddronepathnode(param_00,param_01,param_02,param_03)
{
	var_04 = getnodesinradiussorted(param_00.origin,param_03,32,param_01,"Path");
	var_05 = undefined;
	if(isdefined(var_04) && var_04.size > 0)
	{
		var_06 = anglestoforward(param_00.angles);
		foreach(var_08 in var_04)
		{
			var_09 = var_08.origin + (0,0,param_01);
			if(stopcinematicforall(var_09,param_02,param_02 * 2 + 0.01,undefined,1,1))
			{
				if(bullettracepassed(param_00 geteye(),var_09,0,param_00))
				{
					var_05 = var_09;
					break;
				}
			}
		}
	}

	return var_05;
}

//Function Number: 14
func_4952(param_00,param_01,param_02)
{
	if(param_00 issighted())
	{
		func_241C(self,"IsSighted-2");
		return 0;
	}

	foreach(var_04 in level.players)
	{
		if(param_02.currenttracecount == param_02.maxtracecount)
		{
			func_241C(self,"TooManyTraces");
			return 0;
		}

		if(var_04.team == self.team)
		{
			continue;
		}

		if(var_04.sessionstate != "playing")
		{
			continue;
		}

		if(!maps\mp\_utility::func_4945(var_04))
		{
			continue;
		}

		if(var_04 == self)
		{
			continue;
		}

		param_02.currenttracecount++;
		var_05 = maps\mp\gametypes\_spawnlogic::getplayertraceheight(var_04);
		var_06 = var_04 geteye();
		var_06 = (var_06[0],var_06[1],var_04.origin[2] + var_05);
		var_07 = spawnsighttrace(param_02,param_01 + (0,0,var_05),var_06);
		if(var_07 > 0)
		{
			func_241C(self,"lineOfSight");
			return 0;
		}
	}

	return 1;
}

//Function Number: 15
func_464D(param_00)
{
	param_00.totalscore = 0;
	param_00.numberofpossiblespawnchoices = 0;
	param_00.buddyspawn = 0;
}

//Function Number: 16
criticalfactors_nearteam(param_00)
{
	if(!maps\mp\gametypes\_spawnfactor::critical_factor(::maps\mp\gametypes\_spawnfactor::func_11E8,param_00))
	{
		return "bad";
	}

	if(!maps\mp\gametypes\_spawnfactor::critical_factor(::maps\mp\gametypes\_spawnfactor::avoidgrenades,param_00))
	{
		return "bad";
	}

	if(!maps\mp\gametypes\_spawnfactor::critical_factor(::maps\mp\gametypes\_spawnfactor::avoidmines,param_00))
	{
		return "bad";
	}

	if(!maps\mp\gametypes\_spawnfactor::critical_factor(::maps\mp\gametypes\_spawnfactor::avoidairstrikelocations,param_00))
	{
		return "bad";
	}

	if(!maps\mp\gametypes\_spawnfactor::critical_factor(::maps\mp\gametypes\_spawnfactor::avoidcarepackages,param_00))
	{
		return "bad";
	}

	if(!maps\mp\gametypes\_spawnfactor::critical_factor(::maps\mp\gametypes\_spawnfactor::func_11F0,param_00))
	{
		return "bad";
	}

	if(!maps\mp\gametypes\_spawnfactor::critical_factor(::maps\mp\gametypes\_spawnfactor::avoidenemyspawn,param_00))
	{
		return "bad";
	}

	if(isdefined(param_00.forcedteam) && param_00.forcedteam != self.team)
	{
		return "bad";
	}

	if(!maps\mp\gametypes\_spawnfactor::critical_factor(::maps\mp\gametypes\_spawnfactor::avoidcornervisibleenemies,param_00))
	{
		return "secondary";
	}

	if(!maps\mp\gametypes\_spawnfactor::critical_factor(::maps\mp\gametypes\_spawnfactor::func_8F91,param_00))
	{
		return "secondary";
	}

	return "primary";
}

//Function Number: 17
func_6ADE(param_00)
{
	var_01 = maps\mp\gametypes\_spawnfactor::func_6ADA(1.25,::maps\mp\gametypes\_spawnfactor::func_6122,param_00);
	param_00.totalscore = param_00.totalscore + var_01;
	var_01 = maps\mp\gametypes\_spawnfactor::func_6ADA(1,::maps\mp\gametypes\_spawnfactor::avoidrecentlyusedbyenemies,param_00);
	param_00.totalscore = param_00.totalscore + var_01;
	var_01 = maps\mp\gametypes\_spawnfactor::func_6ADA(1,::maps\mp\gametypes\_spawnfactor::func_11E6,param_00);
	param_00.totalscore = param_00.totalscore + var_01;
	var_01 = maps\mp\gametypes\_spawnfactor::func_6ADA(0.5,::maps\mp\gametypes\_spawnfactor::avoidlastdeathlocation,param_00);
	param_00.totalscore = param_00.totalscore + var_01;
	var_01 = maps\mp\gametypes\_spawnfactor::func_6ADA(0.5,::maps\mp\gametypes\_spawnfactor::avoidlastattackerlocation,param_00);
	param_00.totalscore = param_00.totalscore + var_01;
	var_01 = maps\mp\gametypes\_spawnfactor::func_6ADA(0.25,::maps\mp\gametypes\_spawnfactor::avoidsamespawn,param_00);
	param_00.totalscore = param_00.totalscore + var_01;
	var_01 = maps\mp\gametypes\_spawnfactor::func_6ADA(0.25,::maps\mp\gametypes\_spawnfactor::avoidrecentlyusedbyanyone,param_00);
	param_00.totalscore = param_00.totalscore + var_01;
}

//Function Number: 18
criticalfactors_dz(param_00)
{
	return criticalfactors_nearteam(param_00);
}

//Function Number: 19
getspawnpoint_dz(param_00,param_01)
{
	param_00 = checkdynamicspawns(param_00);
	var_02["primary"] = [];
	var_02["secondary"] = [];
	var_02["bad"] = [];
	foreach(var_04 in param_00)
	{
		func_464D(var_04);
		var_05 = criticalfactors_dz(var_04);
		var_02[var_05][var_02[var_05].size] = var_04;
	}

	if(var_02["primary"].size)
	{
		return scorespawns_dz(var_02["primary"],param_01);
	}

	if(var_02["secondary"].size)
	{
		return scorespawns_dz(var_02["secondary"],param_01);
	}

	return func_6D70(param_00[0],param_00);
}

//Function Number: 20
getspawnpoint_domination(param_00,param_01)
{
	param_00 = checkdynamicspawns(param_00);
	var_02["primary"] = [];
	var_02["secondary"] = [];
	var_02["bad"] = [];
	foreach(var_04 in param_00)
	{
		func_464D(var_04);
		var_05 = criticalfactors_domination(var_04);
		var_02[var_05][var_02[var_05].size] = var_04;
	}

	if(var_02["primary"].size)
	{
		return func_6AE5(var_02["primary"],param_01);
	}

	if(var_02["secondary"].size)
	{
		return func_6AE5(var_02["secondary"],param_01);
	}

	logbadspawn("Buddy Spawn");
	return func_6D70(param_00[0],param_00);
}

//Function Number: 21
scorespawns_dz(param_00,param_01)
{
	var_02 = param_00[0];
	foreach(var_04 in param_00)
	{
		scorefactors_dz(var_04,param_01);
		if(var_04.totalscore > var_02.totalscore)
		{
			var_02 = var_04;
		}
	}

	var_02 = func_6D70(var_02,param_00);
	return var_02;
}

//Function Number: 22
func_6AE5(param_00,param_01)
{
	var_02 = param_00[0];
	foreach(var_04 in param_00)
	{
		func_6ADC(var_04,param_01);
		if(var_04.totalscore > var_02.totalscore)
		{
			var_02 = var_04;
		}
	}

	var_02 = func_6D70(var_02,param_00);
	return var_02;
}

//Function Number: 23
criticalfactors_domination(param_00)
{
	return criticalfactors_nearteam(param_00);
}

//Function Number: 24
scorefactors_dz(param_00,param_01)
{
	var_02 = maps\mp\gametypes\_spawnfactor::func_6ADA(2.5,::maps\mp\gametypes\_spawnfactor::preferclosepoints,param_00,param_01);
	param_00.totalscore = param_00.totalscore + var_02;
	var_02 = maps\mp\gametypes\_spawnfactor::func_6ADA(1,::maps\mp\gametypes\_spawnfactor::func_6122,param_00);
	param_00.totalscore = param_00.totalscore + var_02;
	var_02 = maps\mp\gametypes\_spawnfactor::func_6ADA(1,::maps\mp\gametypes\_spawnfactor::avoidrecentlyusedbyenemies,param_00);
	param_00.totalscore = param_00.totalscore + var_02;
	var_02 = maps\mp\gametypes\_spawnfactor::func_6ADA(1,::maps\mp\gametypes\_spawnfactor::func_11E6,param_00);
	param_00.totalscore = param_00.totalscore + var_02;
	var_02 = maps\mp\gametypes\_spawnfactor::func_6ADA(0.25,::maps\mp\gametypes\_spawnfactor::avoidlastdeathlocation,param_00);
	param_00.totalscore = param_00.totalscore + var_02;
	var_02 = maps\mp\gametypes\_spawnfactor::func_6ADA(0.25,::maps\mp\gametypes\_spawnfactor::avoidlastattackerlocation,param_00);
	param_00.totalscore = param_00.totalscore + var_02;
	var_02 = maps\mp\gametypes\_spawnfactor::func_6ADA(0.25,::maps\mp\gametypes\_spawnfactor::avoidsamespawn,param_00);
	param_00.totalscore = param_00.totalscore + var_02;
	var_02 = maps\mp\gametypes\_spawnfactor::func_6ADA(0.25,::maps\mp\gametypes\_spawnfactor::avoidrecentlyusedbyanyone,param_00);
	param_00.totalscore = param_00.totalscore + var_02;
}

//Function Number: 25
func_6ADC(param_00,param_01)
{
	var_02 = maps\mp\gametypes\_spawnfactor::func_6ADA(2.5,::maps\mp\gametypes\_spawnfactor::func_6124,param_00,param_01);
	param_00.totalscore = param_00.totalscore + var_02;
	var_02 = maps\mp\gametypes\_spawnfactor::func_6ADA(1,::maps\mp\gametypes\_spawnfactor::func_6122,param_00);
	param_00.totalscore = param_00.totalscore + var_02;
	var_02 = maps\mp\gametypes\_spawnfactor::func_6ADA(1,::maps\mp\gametypes\_spawnfactor::avoidrecentlyusedbyenemies,param_00);
	param_00.totalscore = param_00.totalscore + var_02;
	var_02 = maps\mp\gametypes\_spawnfactor::func_6ADA(1,::maps\mp\gametypes\_spawnfactor::func_11E6,param_00);
	param_00.totalscore = param_00.totalscore + var_02;
	var_02 = maps\mp\gametypes\_spawnfactor::func_6ADA(0.25,::maps\mp\gametypes\_spawnfactor::avoidlastdeathlocation,param_00);
	param_00.totalscore = param_00.totalscore + var_02;
	var_02 = maps\mp\gametypes\_spawnfactor::func_6ADA(0.25,::maps\mp\gametypes\_spawnfactor::avoidlastattackerlocation,param_00);
	param_00.totalscore = param_00.totalscore + var_02;
	var_02 = maps\mp\gametypes\_spawnfactor::func_6ADA(0.25,::maps\mp\gametypes\_spawnfactor::avoidsamespawn,param_00);
	param_00.totalscore = param_00.totalscore + var_02;
	var_02 = maps\mp\gametypes\_spawnfactor::func_6ADA(0.25,::maps\mp\gametypes\_spawnfactor::avoidrecentlyusedbyanyone,param_00);
	param_00.totalscore = param_00.totalscore + var_02;
}

//Function Number: 26
func_91F9(param_00)
{
	if(!isdefined(param_00))
	{
		return undefined;
	}

	var_01 = undefined;
	var_02 = maps\mp\gametypes\_spawnlogic::getactiveplayerlist();
	param_00 = checkdynamicspawns(param_00);
	if(!isdefined(var_02) || var_02.size == 0)
	{
		return maps\mp\gametypes\_spawnlogic::func_3BF2(param_00);
	}

	var_03 = 0;
	foreach(var_05 in param_00)
	{
		if(canspawn(var_05.origin) && !positionwouldtelefrag(var_05.origin))
		{
			var_06 = undefined;
			foreach(var_08 in var_02)
			{
				var_09 = distancesquared(var_05.origin,var_08.origin);
				if(!isdefined(var_06) || var_09 < var_06)
				{
					var_06 = var_09;
				}
			}

			if(!isdefined(var_01) || var_06 > var_03)
			{
				var_01 = var_05;
				var_03 = var_06;
			}
		}
	}

	if(!isdefined(var_01))
	{
		return maps\mp\gametypes\_spawnlogic::func_3BF2(param_00);
	}

	return var_01;
}

//Function Number: 27
func_3BF0(param_00)
{
	param_00 = checkdynamicspawns(param_00);
	var_01["primary"] = [];
	var_01["secondary"] = [];
	var_01["bad"] = [];
	foreach(var_03 in param_00)
	{
		func_464D(var_03);
		var_04 = func_2144(var_03);
		var_01[var_04][var_01[var_04].size] = var_03;
	}

	if(var_01["primary"].size)
	{
		return func_6AE6(var_01["primary"]);
	}

	if(var_01["secondary"].size)
	{
		return func_6AE6(var_01["secondary"]);
	}

	if(getdvarint("scr_altFFASpawns") == 1 && var_01["bad"].size)
	{
		logbadspawn("Bad FFA Spawn");
		return func_6AE6(var_01["bad"]);
	}

	logbadspawn("FFA Random Spawn");
	return func_6D70(param_00[0],param_00);
}

//Function Number: 28
func_6AE6(param_00)
{
	var_01 = param_00[0];
	foreach(var_03 in param_00)
	{
		func_6ADD(var_03);
		if(var_03.totalscore > var_01.totalscore)
		{
			var_01 = var_03;
		}
	}

	var_01 = func_6D70(var_01,param_00);
	return var_01;
}

//Function Number: 29
func_2144(param_00)
{
	return criticalfactors_nearteam(param_00);
}

//Function Number: 30
func_6ADD(param_00)
{
	var_01 = 3;
	if(getdvarint("scr_altFFASpawns") == 1)
	{
		var_02 = maps\mp\gametypes\_spawnfactor::func_6ADA(3,::maps\mp\gametypes\_spawnfactor::avoidclosestenemy,param_00);
		param_00.totalscore = param_00.totalscore + var_02;
		var_01 = 2;
	}

	var_02 = maps\mp\gametypes\_spawnfactor::func_6ADA(var_01,::maps\mp\gametypes\_spawnfactor::func_11E6,param_00);
	param_00.totalscore = param_00.totalscore + var_02;
	var_02 = maps\mp\gametypes\_spawnfactor::func_6ADA(2,::maps\mp\gametypes\_spawnfactor::avoidrecentlyusedbyenemies,param_00);
	param_00.totalscore = param_00.totalscore + var_02;
	var_02 = maps\mp\gametypes\_spawnfactor::func_6ADA(0.5,::maps\mp\gametypes\_spawnfactor::avoidlastdeathlocation,param_00);
	param_00.totalscore = param_00.totalscore + var_02;
	var_02 = maps\mp\gametypes\_spawnfactor::func_6ADA(0.5,::maps\mp\gametypes\_spawnfactor::avoidlastattackerlocation,param_00);
	param_00.totalscore = param_00.totalscore + var_02;
	var_02 = maps\mp\gametypes\_spawnfactor::func_6ADA(0.5,::maps\mp\gametypes\_spawnfactor::avoidsamespawn,param_00);
	param_00.totalscore = param_00.totalscore + var_02;
}

//Function Number: 31
func_3BF4(param_00)
{
	param_00 = checkdynamicspawns(param_00);
	var_01["primary"] = [];
	var_01["secondary"] = [];
	var_01["bad"] = [];
	foreach(var_03 in param_00)
	{
		func_464D(var_03);
		var_04 = func_2147(var_03);
		var_01[var_04][var_01[var_04].size] = var_03;
	}

	if(var_01["primary"].size)
	{
		return func_6AE9(var_01["primary"]);
	}

	if(var_01["secondary"].size)
	{
		return func_6AE9(var_01["secondary"]);
	}

	logbadspawn("Buddy Spawn");
	return func_6D70(param_00[0],param_00);
}

//Function Number: 32
func_6AE9(param_00)
{
	var_01 = param_00[0];
	foreach(var_03 in param_00)
	{
		func_6AE0(var_03);
		if(var_03.totalscore > var_01.totalscore)
		{
			var_01 = var_03;
		}
	}

	var_01 = func_6D70(var_01,param_00);
	return var_01;
}

//Function Number: 33
func_2147(param_00)
{
	return criticalfactors_nearteam(param_00);
}

//Function Number: 34
func_6AE0(param_00)
{
	var_01 = maps\mp\gametypes\_spawnfactor::func_6ADA(3,::maps\mp\gametypes\_spawnfactor::func_11E6,param_00);
	param_00.totalscore = param_00.totalscore + var_01;
	var_01 = maps\mp\gametypes\_spawnfactor::func_6ADA(1,::maps\mp\gametypes\_spawnfactor::func_6122,param_00);
	param_00.totalscore = param_00.totalscore + var_01;
	var_01 = maps\mp\gametypes\_spawnfactor::func_6ADA(0.5,::maps\mp\gametypes\_spawnfactor::avoidlastdeathlocation,param_00);
	param_00.totalscore = param_00.totalscore + var_01;
	var_01 = maps\mp\gametypes\_spawnfactor::func_6ADA(0.5,::maps\mp\gametypes\_spawnfactor::avoidlastattackerlocation,param_00);
	param_00.totalscore = param_00.totalscore + var_01;
}

//Function Number: 35
func_3BEE(param_00,param_01,param_02)
{
	if(!isdefined(param_02))
	{
		param_02 = 0;
	}

	param_00 = checkdynamicspawns(param_00);
	var_03["primary"] = [];
	var_03["secondary"] = [];
	var_03["bad"] = [];
	foreach(var_05 in param_00)
	{
		func_464D(var_05);
		var_06 = criticalfactors_awayfromenemies(var_05);
		var_03[var_06][var_03[var_06].size] = var_05;
	}

	if(var_03["primary"].size)
	{
		return func_6AE4(var_03["primary"],param_01);
	}

	if(var_03["secondary"].size)
	{
		return func_6AE4(var_03["secondary"],param_01);
	}

	if(param_02)
	{
		return undefined;
	}

	logbadspawn("Buddy Spawn");
	return func_6D70(param_00[0],param_00);
}

//Function Number: 36
func_6AE4(param_00,param_01)
{
	var_02 = param_00[0];
	foreach(var_04 in param_00)
	{
		func_6ADB(var_04,param_01);
		if(var_04.totalscore > var_02.totalscore)
		{
			var_02 = var_04;
		}
	}

	var_02 = func_6D70(var_02,param_00);
	return var_02;
}

//Function Number: 37
criticalfactors_awayfromenemies(param_00)
{
	return criticalfactors_nearteam(param_00);
}

//Function Number: 38
func_6ADB(param_00,param_01)
{
	var_02 = maps\mp\gametypes\_spawnfactor::func_6ADA(2,::maps\mp\gametypes\_spawnfactor::func_11E6,param_00);
	param_00.totalscore = param_00.totalscore + var_02;
	var_02 = maps\mp\gametypes\_spawnfactor::func_6ADA(1,::maps\mp\gametypes\_spawnfactor::avoidlastattackerlocation,param_00);
	param_00.totalscore = param_00.totalscore + var_02;
	var_02 = maps\mp\gametypes\_spawnfactor::func_6ADA(1,::maps\mp\gametypes\_spawnfactor::func_6122,param_00);
	param_00.totalscore = param_00.totalscore + var_02;
	var_02 = maps\mp\gametypes\_spawnfactor::func_6ADA(1,::maps\mp\gametypes\_spawnfactor::avoidrecentlyusedbyenemies,param_00);
	param_00.totalscore = param_00.totalscore + var_02;
	var_02 = maps\mp\gametypes\_spawnfactor::func_6ADA(0.25,::maps\mp\gametypes\_spawnfactor::avoidlastdeathlocation,param_00);
	param_00.totalscore = param_00.totalscore + var_02;
	var_02 = maps\mp\gametypes\_spawnfactor::func_6ADA(0.25,::maps\mp\gametypes\_spawnfactor::avoidsamespawn,param_00);
	param_00.totalscore = param_00.totalscore + var_02;
	var_02 = maps\mp\gametypes\_spawnfactor::func_6ADA(0.25,::maps\mp\gametypes\_spawnfactor::avoidrecentlyusedbyanyone,param_00);
	param_00.totalscore = param_00.totalscore + var_02;
}

//Function Number: 39
func_3BF3(param_00)
{
	param_00 = checkdynamicspawns(param_00);
	var_01["primary"] = [];
	var_01["secondary"] = [];
	var_01["bad"] = [];
	foreach(var_03 in param_00)
	{
		func_464D(var_03);
		var_04 = criticalfactors_safeguard(var_03);
		var_01[var_04][var_01[var_04].size] = var_03;
	}

	if(var_01["primary"].size)
	{
		return func_6AE8(var_01["primary"]);
	}

	if(var_01["secondary"].size)
	{
		return func_6AE8(var_01["secondary"]);
	}

	logbadspawn("Buddy Spawn");
	return func_6D70(param_00[0],param_00);
}

//Function Number: 40
func_6AE8(param_00)
{
	var_01 = param_00[0];
	foreach(var_03 in param_00)
	{
		func_6ADF(var_03);
		if(var_03.totalscore > var_01.totalscore)
		{
			var_01 = var_03;
		}
	}

	var_01 = func_6D70(var_01,param_00);
	return var_01;
}

//Function Number: 41
criticalfactors_safeguard(param_00)
{
	return criticalfactors_nearteam(param_00);
}

//Function Number: 42
func_6ADF(param_00)
{
	var_01 = maps\mp\gametypes\_spawnfactor::func_6ADA(1,::maps\mp\gametypes\_spawnfactor::func_6342,param_00);
	param_00.totalscore = param_00.totalscore + var_01;
	var_01 = maps\mp\gametypes\_spawnfactor::func_6ADA(1,::maps\mp\gametypes\_spawnfactor::func_6122,param_00);
	param_00.totalscore = param_00.totalscore + var_01;
	var_01 = maps\mp\gametypes\_spawnfactor::func_6ADA(0.5,::maps\mp\gametypes\_spawnfactor::func_11E6,param_00);
	param_00.totalscore = param_00.totalscore + var_01;
}

//Function Number: 43
logbadspawn(param_00)
{
	if(!isdefined(param_00))
	{
		param_00 = "";
	}
	else
	{
		param_00 = "(" + param_00 + ")";
	}

	if(isdefined(level.matchrecording_logeventmsg))
	{
		[[ level.matchrecording_logeventmsg ]]("LOG_BAD_SPAWN",gettime(),param_00);
	}
}