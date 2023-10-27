/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes\_legacyspawnlogic.gsc
 * Game: Call of Duty: Modern Warfare Remastered
 * Platform: PC
 * Function Count: 22
 * Decompile Time: 374 ms
 * Timestamp: 10/27/2023 2:37:55 AM
*******************************************************************/

//Function Number: 1
init()
{
	level.uselegacyspawning = issupportedmap() && issupportedmode() && getdvarint("legacySpawningEnabled",0);
}

//Function Number: 2
issupportedmap()
{
	switch(level.script)
	{
		case "mp_countdown":
		case "mp_bog":
		case "mp_cargoship":
		case "mp_bog_summer":
			break;

		default:
			break;
	}
}

//Function Number: 3
issupportedmode()
{
	switch(level.gametype)
	{
		case "dom":
		case "conf":
		case "war":
			break;

		default:
			break;
	}
}

//Function Number: 4
uselegacyspawning()
{
	return level.uselegacyspawning;
}

//Function Number: 5
getspawnpoint_final(param_00,param_01)
{
	var_02 = undefined;
	if(!isdefined(param_00) || param_00.size == 0)
	{
		return undefined;
	}

	if(!isdefined(param_01))
	{
		param_01 = 1;
	}

	if(param_01)
	{
		var_02 = getbestweightedspawnpoint(param_00);
	}
	else
	{
		for(var_03 = 0;var_03 < param_00.size;var_03++)
		{
			if(isdefined(self.lastspawnpoint) && self.lastspawnpoint == param_00[var_03])
			{
				continue;
			}

			if(positionwouldtelefrag(param_00[var_03].origin))
			{
				continue;
			}

			var_02 = param_00[var_03];
			break;
		}

		if(!isdefined(var_02))
		{
			if(isdefined(self.lastspawnpoint) && !positionwouldtelefrag(self.lastspawnpoint.origin))
			{
				for(var_03 = 0;var_03 < param_00.size;var_03++)
				{
					if(param_00[var_03] == self.lastspawnpoint)
					{
						var_02 = param_00[var_03];
						break;
					}
				}
			}
		}
	}

	if(!isdefined(var_02))
	{
		if(param_01)
		{
			var_02 = param_00[randomint(param_00.size)];
		}
		else
		{
			var_02 = param_00[0];
		}
	}

	return var_02;
}

//Function Number: 6
getbestweightedspawnpoint(param_00)
{
	var_01 = 3;
	for(var_02 = 0;var_02 <= var_01;var_02++)
	{
		var_03 = [];
		var_04 = undefined;
		var_05 = undefined;
		for(var_06 = 0;var_06 < param_00.size;var_06++)
		{
			if(!isdefined(var_04) || param_00[var_06].weight > var_04)
			{
				if(positionwouldtelefrag(param_00[var_06].origin))
				{
					continue;
				}

				var_03 = [];
				var_03[0] = param_00[var_06];
				var_04 = param_00[var_06].weight;
				continue;
			}

			if(param_00[var_06].weight == var_04)
			{
				if(positionwouldtelefrag(param_00[var_06].origin))
				{
					continue;
				}

				var_03[var_03.size] = param_00[var_06];
			}
		}

		if(var_03.size == 0)
		{
			return undefined;
		}

		var_05 = var_03[randomint(var_03.size)];
		if(var_02 == var_01)
		{
			return var_05;
		}

		if(isdefined(var_05.lastsighttracetime) && var_05.lastsighttracetime == gettime())
		{
			return var_05;
		}

		if(!lastminutesighttraces(var_05))
		{
			return var_05;
		}

		var_07 = getlospenalty();
		var_05.weight = var_05.weight - var_07;
		var_05.lastsighttracetime = gettime();
	}
}

//Function Number: 7
getspawnpoint_random(param_00)
{
	if(!isdefined(param_00))
	{
		return undefined;
	}

	for(var_01 = 0;var_01 < param_00.size;var_01++)
	{
		var_02 = randomint(param_00.size);
		var_03 = param_00[var_01];
		param_00[var_01] = param_00[var_02];
		param_00[var_02] = var_03;
	}

	return getspawnpoint_final(param_00,0);
}

//Function Number: 8
getallotherplayers()
{
	var_00 = [];
	for(var_01 = 0;var_01 < level.players.size;var_01++)
	{
		if(!isdefined(level.players[var_01]))
		{
			continue;
		}

		var_02 = level.players[var_01];
		if(var_02.sessionstate != "playing" || var_02 == self)
		{
			continue;
		}

		var_00[var_00.size] = var_02;
	}

	return var_00;
}

//Function Number: 9
getallalliedandenemyplayers(param_00)
{
	if(level.teambased)
	{
		if(self.pers["team"] == "allies")
		{
			param_00.allies = level.aliveplayers["allies"];
			param_00.enemies = level.aliveplayers["axis"];
			return;
		}

		param_00.allies = level.aliveplayers["axis"];
		param_00.enemies = level.aliveplayers["allies"];
		return;
	}

	param_00.allies = [];
	param_00.enemies = level.activeplayers;
}

//Function Number: 10
initweights(param_00)
{
	for(var_01 = 0;var_01 < param_00.size;var_01++)
	{
		param_00[var_01].weight = 0;
	}
}

//Function Number: 11
getspawnpoint_nearteam(param_00,param_01)
{
	if(!isdefined(param_00))
	{
		return undefined;
	}

	if(getdvarint("scr_spawnsimple") > 0)
	{
		return getspawnpoint_random(param_00);
	}

	spawnlogic_begin();
	initweights(param_00);
	var_02 = spawnstruct();
	getallalliedandenemyplayers(var_02);
	var_03 = var_02.allies.size + var_02.enemies.size;
	var_04 = 2;
	var_05 = self.pers["team"];
	var_06 = maps\mp\_utility::getotherteam(var_05);
	for(var_07 = 0;var_07 < param_00.size;var_07++)
	{
		var_08 = param_00[var_07];
		if(var_08.numplayersatlastupdate > 0)
		{
			var_09 = var_08.distsum[var_05];
			var_0A = var_08.distsum[var_06];
			var_08.weight = var_0A - var_04 * var_09 / var_08.numplayersatlastupdate;
			continue;
		}

		var_08.weight = 0;
	}

	if(isdefined(param_01))
	{
		for(var_07 = 0;var_07 < param_01.size;var_07++)
		{
			param_01[var_07].weight = param_01[var_07].weight + 25000;
		}
	}

	avoidsamespawn(param_00);
	avoidspawnreuse(param_00,1);
	avoidweapondamage(param_00);
	avoidvisibleenemies(param_00,1);
	var_0B = getspawnpoint_final(param_00);
	return var_0B;
}

//Function Number: 12
getspawnpoint_dm(param_00)
{
	if(!isdefined(param_00))
	{
		return undefined;
	}

	spawnlogic_begin();
	initweights(param_00);
	var_01 = getallotherplayers();
	var_02 = 1600;
	var_03 = 1200;
	if(var_01.size > 0)
	{
		for(var_04 = 0;var_04 < param_00.size;var_04++)
		{
			var_05 = 0;
			var_06 = 0;
			for(var_07 = 0;var_07 < var_01.size;var_07++)
			{
				var_08 = distance(param_00[var_04].origin,var_01[var_07].origin);
				if(var_08 < var_03)
				{
					var_06 = var_06 + var_03 - var_08 / var_03;
				}

				var_09 = abs(var_08 - var_02);
				var_05 = var_05 + var_09;
			}

			var_0A = var_05 / var_01.size;
			var_0B = var_02 - var_0A / var_02;
			param_00[var_04].weight = var_0B - var_06 * 2 + randomfloat(0.2);
		}
	}

	avoidsamespawn(param_00);
	avoidspawnreuse(param_00,0);
	avoidweapondamage(param_00);
	avoidvisibleenemies(param_00,0);
	return getspawnpoint_final(param_00);
}

//Function Number: 13
spawnlogic_begin()
{
}

//Function Number: 14
ispointvulnerable(param_00)
{
	var_01 = self.origin + level.claymoremodelcenteroffset;
	var_02 = param_00 + (0,0,32);
	var_03 = distancesquared(var_01,var_02);
	var_04 = anglestoforward(self.angles);
	if(var_03 < level.claymoredetectionradius * level.claymoredetectionradius)
	{
		var_05 = vectornormalize(var_02 - var_01);
		var_06 = acos(vectordot(var_05,var_04));
		if(var_06 < level.claymoredetectionconeangle)
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 15
avoidweapondamage(param_00)
{
	if(getdvar("scr_spawnpointnewlogic") == "0")
	{
		return;
	}

	var_01 = 100000;
	if(getdvar("scr_spawnpointweaponpenalty") != "" && getdvar("scr_spawnpointweaponpenalty") != "0")
	{
		var_01 = getdvarfloat("scr_spawnpointweaponpenalty");
	}

	var_02 = 62500;
	for(var_03 = 0;var_03 < param_00.size;var_03++)
	{
		for(var_04 = 0;var_04 < level.grenades.size;var_04++)
		{
			if(!isdefined(level.grenades[var_04]))
			{
				continue;
			}

			if(distancesquared(param_00[var_03].origin,level.grenades[var_04].origin) < var_02)
			{
				param_00[var_03].weight = param_00[var_03].weight - var_01;
			}
		}

		if(!isdefined(level.artillerydangercenters))
		{
			continue;
		}

		var_05 = maps\mp\gametypes\_hardpoints::getairstrikedanger(param_00[var_03].origin);
		if(var_05 > 0)
		{
			var_06 = var_05 * var_01;
			param_00[var_03].weight = param_00[var_03].weight - var_06;
		}
	}
}

//Function Number: 16
spawnperframeupdate()
{
	var_00 = 0;
	var_01 = undefined;
	var_02 = 0;
	var_03 = 0;
	var_04 = 1;
	for(;;)
	{
		if(var_04)
		{
			wait(0.05);
			var_02 = 0;
			var_03 = 0;
		}

		if(!isdefined(level.spawnpoints))
		{
			return;
		}

		var_00 = var_00 + 1 % level.spawnpoints.size;
		var_05 = level.spawnpoints[var_00];
		if(level.teambased)
		{
			var_05.sights["axis"] = 0;
			var_05.sights["allies"] = 0;
			var_05.nearbyplayers["axis"] = [];
			var_05.nearbyplayers["allies"] = [];
		}
		else
		{
			var_05.sights = 0;
			var_05.nearbyplayers["all"] = [];
		}

		var_06 = var_05.forward;
		var_05.distsum["all"] = 0;
		var_05.distsum["allies"] = 0;
		var_05.distsum["axis"] = 0;
		var_05.numplayersatlastupdate = 0;
		var_07 = 0;
		for(var_08 = 0;var_08 < level.players.size;var_08++)
		{
			var_09 = level.players[var_08];
			if(var_09.sessionstate != "playing")
			{
				continue;
			}

			var_07++;
			var_0A = var_09.origin - var_05.origin;
			var_0B = length(var_0A);
			var_0C = "all";
			if(level.teambased)
			{
				var_0C = var_09.pers["team"];
			}

			if(var_0B < 1024)
			{
				var_05.nearbyplayers[var_0C][var_05.nearbyplayers[var_0C].size] = var_09;
			}

			var_05.distsum[var_0C] = var_05.distsum[var_0C] + var_0B;
			var_05.numplayersatlastupdate++;
			var_0D = anglestoforward(var_09.angles);
			if(vectordot(var_06,var_0A) < 0 && vectordot(var_0D,var_0A) > 0)
			{
				continue;
			}

			var_02++;
			var_0E = legacybullettracepassed(var_09.origin + (0,0,50),var_05.sighttracepoint,var_05);
			var_05.lastsighttracetime = gettime();
			if(var_0E)
			{
				if(level.teambased)
				{
					var_05.sights[var_09.pers["team"]]++;
					continue;
				}

				var_05.sights++;
			}
		}

		var_03++;
		var_0F = var_03 == level.spawnpoints.size;
		var_10 = var_02 + var_07 > getdvarint("legacySpawningMaxTraces",18);
		var_04 = var_0F || var_10;
	}
}

//Function Number: 17
legacybullettracepassed(param_00,param_01,param_02)
{
	var_03 = getdvarfloat("legacySpawningSightFrac",1);
	if(var_03 >= 1)
	{
		return bullettracepassed(param_00,param_01,0,undefined);
	}

	return spawnsighttrace(param_02,param_00,param_01,param_02.index) >= var_03;
}

//Function Number: 18
getlospenalty()
{
	if(getdvar("scr_spawnpointlospenalty") != "" && getdvar("scr_spawnpointlospenalty") != "0")
	{
		return getdvarfloat("scr_spawnpointlospenalty");
	}

	return 100000;
}

//Function Number: 19
lastminutesighttraces(param_00)
{
	var_01 = "all";
	if(level.teambased)
	{
		var_01 = maps\mp\_utility::getotherteam(self.pers["team"]);
	}

	if(!isdefined(param_00.nearbyplayers))
	{
		return 0;
	}

	var_02 = undefined;
	var_03 = undefined;
	var_04 = undefined;
	var_05 = undefined;
	for(var_06 = 0;var_06 < param_00.nearbyplayers[var_01].size;var_06++)
	{
		var_07 = param_00.nearbyplayers[var_01][var_06];
		if(!isdefined(var_07))
		{
			continue;
		}

		if(var_07.sessionstate != "playing")
		{
			continue;
		}

		if(var_07 == self)
		{
			continue;
		}

		var_08 = distancesquared(param_00.origin,var_07.origin);
		if(!isdefined(var_02) || var_08 < var_03)
		{
			var_04 = var_02;
			var_05 = var_03;
			var_02 = var_07;
			var_03 = var_08;
			continue;
		}

		if(!isdefined(var_04) || var_08 < var_05)
		{
			var_04 = var_07;
			var_05 = var_08;
		}
	}

	if(isdefined(var_02))
	{
		if(legacybullettracepassed(var_02.origin + (0,0,50),param_00.sighttracepoint,param_00))
		{
			return 1;
		}
	}

	if(isdefined(var_04))
	{
		if(legacybullettracepassed(var_04.origin + (0,0,50),param_00.sighttracepoint,param_00))
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 20
avoidvisibleenemies(param_00,param_01)
{
	if(getdvar("scr_spawnpointnewlogic") == "0")
	{
		return;
	}

	var_02 = getlospenalty();
	var_03 = "axis";
	if(self.pers["team"] == "axis")
	{
		var_03 = "allies";
	}

	if(param_01 || maps\mp\_utility::ishodgepodgemm())
	{
		for(var_04 = 0;var_04 < param_00.size;var_04++)
		{
			if(!isdefined(param_00[var_04].sights))
			{
				continue;
			}

			var_05 = var_02 * param_00[var_04].sights[var_03];
			param_00[var_04].weight = param_00[var_04].weight - var_05;
		}

		return;
	}

	for(var_04 = 0;var_04 < param_00.size;var_04++)
	{
		if(!isdefined(param_00[var_04].sights))
		{
			continue;
		}

		var_05 = var_02 * param_00[var_04].sights;
		param_00[var_04].weight = param_00[var_04].weight - var_05;
	}
}

//Function Number: 21
avoidspawnreuse(param_00,param_01)
{
	if(getdvar("scr_spawnpointnewlogic") == "0")
	{
		return;
	}

	var_02 = gettime();
	var_03 = 10000;
	var_04 = 640000;
	for(var_05 = 0;var_05 < param_00.size;var_05++)
	{
		if(!isdefined(param_00[var_05].lastspawnedplayer) || !isdefined(param_00[var_05].lastspawntime) || !isalive(param_00[var_05].lastspawnedplayer))
		{
			continue;
		}

		if(param_00[var_05].lastspawnedplayer == self)
		{
			continue;
		}

		if(param_01 && param_00[var_05].lastspawnedplayer.pers["team"] == self.pers["team"])
		{
			continue;
		}

		var_06 = var_02 - param_00[var_05].lastspawntime;
		if(var_06 < var_03)
		{
			var_07 = distancesquared(param_00[var_05].lastspawnedplayer.origin,param_00[var_05].origin);
			if(var_07 < var_04)
			{
				var_08 = 1000 * 1 - var_07 / var_04 * 1 - var_06 / var_03;
				param_00[var_05].weight = param_00[var_05].weight - var_08;
			}
			else
			{
				param_00[var_05].lastspawnedplayer = undefined;
			}

			continue;
		}

		param_00[var_05].lastspawnedplayer = undefined;
	}
}

//Function Number: 22
avoidsamespawn(param_00)
{
	if(getdvar("scr_spawnpointnewlogic") == "0")
	{
		return;
	}

	if(!isdefined(self.lastspawnpoint))
	{
		return;
	}

	for(var_01 = 0;var_01 < param_00.size;var_01++)
	{
		if(param_00[var_01] == self.lastspawnpoint)
		{
			param_00[var_01].weight = param_00[var_01].weight - 50000;
			break;
		}
	}
}