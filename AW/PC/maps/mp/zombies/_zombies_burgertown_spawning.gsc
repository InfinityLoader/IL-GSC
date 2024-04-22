/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: mp\zombies\_zombies_burgertown_spawning.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 18
 * Decompile Time: 299 ms
 * Timestamp: 4/22/2024 2:14:33 AM
*******************************************************************/

//Function Number: 1
init()
{
	level.spawninfo = spawnstruct();
	level.spawninfo.specialspawnsinfo = [];
	level.spawninfo.packremaining = 0;
	level.currentmaxenemycountfunc = [];
	var_00 = "mp/dlc2SpecialAISpawnTable.csv";
	var_01 = 0;
	var_02 = 1;
	var_03 = 2;
	var_04 = 3;
	var_05 = 4;
	var_06 = 5;
	var_07 = 6;
	var_08 = 7;
	var_09 = 8;
	var_0A = 9;
	var_0B = tablegetrowcount(var_00);
	for(var_0C = 0;var_0C < var_0B;var_0C++)
	{
		var_0D = tablelookupbyrow(var_00,var_0C,var_01);
		var_0E = int(tablelookupbyrow(var_00,var_0C,var_02));
		var_0F = int(tablelookupbyrow(var_00,var_0C,var_03));
		var_10 = int(tablelookupbyrow(var_00,var_0C,var_04));
		var_11 = int(tablelookupbyrow(var_00,var_0C,var_05));
		var_12 = int(tablelookupbyrow(var_00,var_0C,var_06));
		var_13 = int(tablelookupbyrow(var_00,var_0C,var_07));
		var_14 = int(tablelookupbyrow(var_00,var_0C,var_08));
		var_15 = int(tablelookupbyrow(var_00,var_0C,var_09));
		var_16 = int(tablelookupbyrow(var_00,var_0C,var_0A));
		setupspecialspawninfo(var_0D,var_0E,var_0F,var_10,var_11,var_12,var_13,var_14,var_15,var_16);
	}
}

//Function Number: 2
setupspecialspawninfo(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09)
{
	var_0A = level.spawninfo.specialspawnsinfo.size;
	level.spawninfo.specialspawnsinfo[var_0A]["type"] = param_00;
	level.spawninfo.specialspawnsinfo[var_0A]["startingRound"] = param_01;
	level.spawninfo.specialspawnsinfo[var_0A]["startingCivilianRound"] = param_02;
	level.spawninfo.specialspawnsinfo[var_0A]["probabilityIncrease"] = param_03;
	level.spawninfo.specialspawnsinfo[var_0A]["currentProbability"] = 0;
	level.spawninfo.specialspawnsinfo[var_0A]["roundCooldown"] = param_04;
	level.spawninfo.specialspawnsinfo[var_0A]["currentRemainingCooldown"] = 0;
	level.spawninfo.specialspawnsinfo[var_0A]["minPackSize"] = param_05;
	level.spawninfo.specialspawnsinfo[var_0A]["maxPackSize"] = param_06;
	level.spawninfo.specialspawnsinfo[var_0A]["packCooldown"] = param_07 * 1000;
	level.spawninfo.specialspawnsinfo[var_0A]["nextValidSpawnTime"] = 0;
	level.spawninfo.specialspawnsinfo[var_0A]["startingMaxActive"] = param_08;
	level.spawninfo.specialspawnsinfo[var_0A]["startingTotalAllowed"] = param_09;
	level.spawninfo.specialspawnsinfo[var_0A]["spawned"] = 0;
	level.spawninfo.specialspawnsinfo[var_0A]["intro"] = 0;
}

//Function Number: 3
initializespecialai()
{
	for(var_00 = 0;var_00 < level.spawninfo.specialspawnsinfo.size;var_00++)
	{
		if(level.spawninfo.specialspawnsinfo[var_00]["spawned"])
		{
			level.spawninfo.specialspawnsinfo[var_00]["currentProbability"] = 0;
			level.spawninfo.specialspawnsinfo[var_00]["currentRemainingCooldown"] = level.spawninfo.specialspawnsinfo[var_00]["roundCooldown"];
		}
		else
		{
			level.spawninfo.specialspawnsinfo[var_00]["currentRemainingCooldown"]--;
			if(level.spawninfo.specialspawnsinfo[var_00]["currentRemainingCooldown"] < 0)
			{
				level.spawninfo.specialspawnsinfo[var_00]["currentRemainingCooldown"] = 0;
			}
		}

		if(level.spawninfo.specialspawnsinfo[var_00]["startingRound"] > level.wavecounter)
		{
			var_01 = 0;
		}
		else
		{
			var_01 = int(min(100,level.spawninfo.specialspawnsinfo[var_00]["currentProbability"] + level.spawninfo.specialspawnsinfo[var_00]["probabilityIncrease"]));
		}

		level.spawninfo.specialspawnsinfo[var_00]["currentProbability"] = var_01;
		level.spawninfo.specialspawnsinfo[var_00]["totalSpawned"] = 0;
		level.spawninfo.specialspawnsinfo[var_00]["spawned"] = 0;
		level.spawninfo.packremaining = 0;
	}
}

//Function Number: 4
spawnzombies(param_00,param_01)
{
	level.spawninfo.numberspawned = 0;
	level.spawninfo.maxspecialai = calculatemaxspecialaicount();
	level.spawninfo.nextpossiblespecialaipack = 0;
	initializespecialai();
	if(level.nextcivilianround == level.wavecounter + 1)
	{
		level thread upcomingcivilianroundnotification(param_00);
	}

	var_02 = spawnnumberofzombies(param_00,param_01);
}

//Function Number: 5
getmodifiedmaxenemycount(param_00)
{
	if(level.roundtype != "zombie_melee_goliath")
	{
		return param_00;
	}

	var_01 = param_00 - 2;
	if(var_01 < 0)
	{
		var_01 = 0;
	}

	return var_01;
}

//Function Number: 6
spawnzombiescivilianround(param_00,param_01)
{
	level.spawninfo.numberspawned = 0;
	level.spawninfo.specialairange = calculatecivilianspecialairange();
	level.spawninfo.nextpossiblespecialaipack = randomintrange(level.spawninfo.specialairange["min"],level.spawninfo.specialairange["max"]);
	initializespecialai();
	var_02 = spawnnumberofzombies(param_00,param_01);
	while(level.numberofalivecivilians > 0 || isdefined(level.waitingforcivilianspawn))
	{
		if(maps\mp\zombies\zombies_spawn_manager::getnumberofzombies() < param_00)
		{
			var_02 = spawnnumberofzombies(1,param_01);
		}

		wait 0.05;
	}
}

//Function Number: 7
spawnnumberofzombies(param_00,param_01)
{
	for(var_02 = 0;var_02 < param_00;var_02++)
	{
		checkspawningpaused(param_00);
		var_03 = maps\mp\zombies\zombies_spawn_manager::getenemytypetospawn(var_02,param_00);
		var_03 = modifyaitype(var_03,param_00);
		var_04 = maps\mp\zombies\zombies_spawn_manager::spawnzombietype(var_03);
		level.spawninfo.numberspawned++;
		if(isdefined(level.roundspawndelayfunc[level.roundtype]))
		{
			param_01 = [[ level.roundspawndelayfunc[level.roundtype] ]](var_02,param_00);
		}

		wait(param_01);
	}

	return var_02;
}

//Function Number: 8
checkspawningpaused(param_00)
{
	while(maps\mp\zombies\_util::iszombiegamepaused())
	{
		wait 0.05;
	}

	if(isdefined(level.currentmaxenemycountfunc[level.roundtype]))
	{
		var_01 = [[ level.currentmaxenemycountfunc[level.roundtype] ]](level.maxenemycount);
	}
	else
	{
		var_01 = level.maxenemycount;
	}

	while(maps\mp\agents\_agent_utility::getnumactiveagents() >= var_01)
	{
		wait(0.1);
	}
}

//Function Number: 9
checkforspecialaiintroround()
{
	var_00 = undefined;
	for(var_01 = 0;var_01 < level.spawninfo.specialspawnsinfo.size;var_01++)
	{
		var_02 = level.spawninfo.specialspawnsinfo[var_01];
		if(var_02["intro"])
		{
			continue;
		}

		if(level.roundtype == "normal" && var_02["startingRound"] > level.wavecounter)
		{
			continue;
		}

		if(level.roundtype != "normal" && var_02["startingCivilianRound"] > level.wavecounter)
		{
			continue;
		}

		if(var_02["totalSpawned"] >= var_02["startingTotalAllowed"])
		{
			continue;
		}

		if(maps\mp\agents\_agent_utility::getnumactiveagents(var_02["type"]) >= var_02["startingMaxActive"])
		{
			continue;
		}

		level.spawninfo.specialspawnsinfo[var_01]["intro"] = 1;
		return var_01;
	}

	return undefined;
}

//Function Number: 10
modifyaitype(param_00,param_01)
{
	if(isdefined(level.getspawntypefunc[level.roundtype]))
	{
		return [[ level.getspawntypefunc[level.roundtype] ]](level.spawninfo.numberspawned,param_01);
	}

	if(level.spawninfo.packremaining > 0)
	{
		level.spawninfo.packremaining--;
		return level.spawninfo.packtype;
	}

	if(level.spawninfo.nextpossiblespecialaipack <= level.spawninfo.numberspawned)
	{
		var_03 = checkforspecialaiintroround();
		if(isdefined(var_03))
		{
			setspecialspawntype(var_03);
			return level.spawninfo.specialspawnsinfo[var_03]["type"];
		}

		for(var_04 = 0;var_04 < level.spawninfo.specialspawnsinfo.size;var_04++)
		{
			var_05 = level.spawninfo.specialspawnsinfo[var_04];
			var_06 = var_05["type"];
			if(level.roundtype == "normal" && var_05["startingRound"] > level.wavecounter)
			{
				continue;
			}

			if(level.roundtype != "normal" && var_05["startingCivilianRound"] > level.wavecounter)
			{
				continue;
			}

			if(var_05["currentProbability"] <= 0)
			{
				continue;
			}

			if(var_05["currentRemainingCooldown"] > 0)
			{
				continue;
			}

			if(var_05["totalSpawned"] >= var_05["startingTotalAllowed"])
			{
				continue;
			}

			if(var_05["nextValidSpawnTime"] >= gettime())
			{
				continue;
			}

			if(maps\mp\agents\_agent_utility::getnumactiveagents(var_06) >= var_05["startingMaxActive"])
			{
				continue;
			}

			if(randomint(100) > var_05["currentProbability"])
			{
				continue;
			}

			setspecialspawntype(var_04);
			return var_06;
		}
	}

	return param_00;
}

//Function Number: 11
setspecialspawntype(param_00)
{
	var_01 = level.spawninfo.specialspawnsinfo[param_00];
	if(var_01["minPackSize"] < var_01["maxPackSize"])
	{
		var_02 = randomintrange(var_01["minPackSize"],var_01["maxPackSize"]);
	}
	else
	{
		var_02 = var_02["minPackSize"];
	}

	level.spawninfo.specialspawnsinfo[param_00]["spawned"] = 1;
	level.spawninfo.packtype = var_01["type"];
	level.spawninfo.packremaining = var_02 - 1;
	level.spawninfo.specialspawnsinfo[param_00]["currentProbability"] = level.spawninfo.specialspawnsinfo[param_00]["currentProbability"] - 10;
	if(level.roundtype == "normal")
	{
		level.spawninfo.nextpossiblespecialaipack = level.spawninfo.numberspawned + var_02 + 10;
		return;
	}

	level.spawninfo.nextpossiblespecialaipack = level.spawninfo.numberspawned + var_02 + randomintrange(level.spawninfo.specialairange["min"],level.spawninfo.specialairange["max"]);
}

//Function Number: 12
activatespecialspawncooldown(param_00)
{
	for(var_01 = 0;var_01 < level.spawninfo.specialspawnsinfo.size;var_01++)
	{
		if(level.spawninfo.specialspawnsinfo[var_01]["type"] == param_00)
		{
			level.spawninfo.specialspawnsinfo[var_01]["nextValidSpawnTime"] = gettime() + level.spawninfo.specialspawnsinfo[var_01]["packCooldown"];
			return;
		}
	}
}

//Function Number: 13
calculaterespawnthreshold()
{
	var_00 = maps\mp\zombies\_util::getnumplayers();
	var_01 = level.wavecounter / 3;
	if(var_00 == 1)
	{
		var_02 = var_01;
	}
	else
	{
		var_02 = var_01 - 1 * var_02 * 0.75;
	}

	return int(12 + var_02);
}

//Function Number: 14
calculatemaxactiveai()
{
	var_00 = maps\mp\zombies\_util::getnumplayers();
	var_01 = level.wavecounter / 2;
	if(var_01 < 1)
	{
		var_01 = 1;
	}

	if(var_00 == 1)
	{
		var_02 = var_01 * 0.5;
	}
	else
	{
		var_02 = var_01 - 1 * var_02;
	}

	return int(12 + var_02);
}

//Function Number: 15
calculatemaxspecialaicount()
{
	if(level.wavecounter < 4)
	{
		return 0;
	}

	var_00 = maps\mp\zombies\_util::getnumplayers();
	var_01 = level.wavecounter / 5;
	if(var_01 < 1)
	{
		var_01 = 1;
	}

	if(var_00 == 1)
	{
		var_02 = var_01;
	}
	else
	{
		var_02 = var_01 - 1 * var_02 * 0.5;
	}

	return int(6 + var_02);
}

//Function Number: 16
calculatecivilianspecialairange()
{
	var_00 = maps\mp\zombies\_util::getnumplayers();
	var_01 = level.wavecounter / 5;
	if(var_00 == 1)
	{
		var_02 = var_01;
	}
	else
	{
		var_02 = var_01 - 1 * 0.5 + var_02;
	}

	var_03 = [];
	var_03["min"] = int(max(0,6 - var_01 * 0.75));
	var_03["max"] = int(max(0,10 - var_01 * 0.5));
	return var_03;
}

//Function Number: 17
calculatecivilianpacksize()
{
	var_00 = maps\mp\zombies\_util::getnumplayers();
	var_01 = level.wavecounter / 2;
	if(var_00 == 1)
	{
		var_02 = var_01;
	}
	else
	{
		var_02 = var_01 - 1 * 0.5 * var_02;
	}

	return int(12 + var_02);
}

//Function Number: 18
upcomingcivilianroundnotification(param_00)
{
	level endon("game_ended");
	var_01 = int(param_00 * 0.5);
	for(;;)
	{
		if(level.spawninfo.numberspawned - maps\mp\zombies\zombies_spawn_manager::getnumberofzombies() >= var_01)
		{
			level notify("upcoming_civilian_round");
			break;
		}

		wait(0.1);
	}
}