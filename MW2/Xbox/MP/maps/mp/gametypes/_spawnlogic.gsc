/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes\_spawnlogic.gsc
 * Game: Call of Duty: Modern Warfare 2
 * Platform: Xbox
*******************************************************************/

findboxcenter(mins, maxs)
{
	center = (0,0,0);
	center = maxs - mins;
	center = (center[0] / 2,center[1] / 2,center[2] / 2) + mins;
	return center;
}

expandmins(mins, point)
{
	if(mins[0] > point[0])
	{
		mins = (point[0],mins[1],mins[2]);
	}

	if(mins[1] > point[1])
	{
		mins = (mins[0],point[1],mins[2]);
	}

	if(mins[2] > point[2])
	{
		mins = (mins[0],mins[1],point[2]);
	}

	return mins;
}

expandmaxs(maxs, point)
{
	if(maxs[0] < point[0])
	{
		maxs = (point[0],maxs[1],maxs[2]);
	}

	if(maxs[1] < point[1])
	{
		maxs = (maxs[0],point[1],maxs[2]);
	}

	if(maxs[2] < point[2])
	{
		maxs = (maxs[0],maxs[1],point[2]);
	}

	return maxs;
}

addspawnpoints(team, spawnpointname, param_603)
{
	if(!isdefined(param_603))
	{
		param_603 = 0;
	}

	oldspawnpoints = [];
	if(level.teamspawnpoints[team].size)
	{
		oldspawnpoints = level.teamspawnpoints[team];
	}

	level.teamspawnpoints[team] = getspawnpointarray(spawnpointname);
	if(!level.teamspawnpoints[team].size && !param_603)
	{
		maps\mp\gametypes\_callbacksetup::abortlevel();
		wait 1;
		return;
	}

	if(!isdefined(level.spawnpoints))
	{
		level.spawnpoints = [];
	}

	for(index = 0;index < level.teamspawnpoints[team].size;index++)
	{
		spawnpoint = level.teamspawnpoints[team][index];
		if(!isdefined(spawnpoint.inited))
		{
			spawnpoint spawnpointinit();
			level.spawnpoints[level.spawnpoints.size] = spawnpoint;
		}
	}

	for(index = 0;index < oldspawnpoints.size;index++)
	{
		origin = oldspawnpoints[index].origin;
		level.spawnmins = expandmins(level.spawnmins, origin);
		level.spawnmaxs = expandmaxs(level.spawnmaxs, origin);
		level.teamspawnpoints[team][level.teamspawnpoints[team].size] = oldspawnpoints[index];
	}
}

placespawnpoints(spawnpointname)
{
	spawnpoints = getspawnpointarray(spawnpointname);
	if(!spawnpoints.size)
	{
		maps\mp\gametypes\_callbacksetup::abortlevel();
		wait 1;
		return;
	}

	for(index = 0;index < spawnpoints.size;index++)
	{
		spawnpoints[index] spawnpointinit();
	}
}

getspawnpointarray(classname)
{
	spawnpoints = getentarray(classname, "classname");
	if(!isdefined(level.extraspawnpoints) || !isdefined(level.extraspawnpoints[classname]))
	{
		return spawnpoints;
	}

	for(i = 0;i < level.extraspawnpoints[classname].size;i++)
	{
		spawnpoints[spawnpoints.size] = level.extraspawnpoints[classname][i];
	}

	return spawnpoints;
}

expandspawnpointbounds(classname)
{
	spawnpoints = getspawnpointarray(classname);
	for(index = 0;index < spawnpoints.size;index++)
	{
		level.spawnmins = expandmins(level.spawnmins, spawnpoints[index].origin);
		level.spawnmaxs = expandmaxs(level.spawnmaxs, spawnpoints[index].origin);
	}
}

setmapcenterforreflections()
{
	level.spawnmins = (0,0,0);
	level.spawnmaxs = (0,0,0);
	expandspawnpointbounds("mp_tdm_spawn_allies_start");
	expandspawnpointbounds("mp_tdm_spawn_axis_start");
	level.mapcenter = findboxcenter(level.spawnmins, level.spawnmaxs);
	setmapcenter(level.mapcenter);
}

spawnpointinit()
{
	spawnpoint = self;
	origin = spawnpoint.origin;
	level.spawnmins = expandmins(level.spawnmins, origin);
	level.spawnmaxs = expandmaxs(level.spawnmaxs, origin);
	spawnpoint placespawnpoint();
	spawnpoint.forward = anglestoforward(spawnpoint.angles);
	spawnpoint.sighttracepoint = spawnpoint.origin + (0,0,50);
	spawnpoint.lastspawnedplayer = spawnpoint;
	spawnpoint.lastspawntime = gettime();
	skyheight = 1024;
	spawnpoint.outside = 1;
	if(!bullettracepassed(spawnpoint.sighttracepoint, spawnpoint.sighttracepoint + (0,0,skyheight), 0, undefined))
	{
		startpoint = spawnpoint.sighttracepoint + spawnpoint.forward * 100;
		if(!bullettracepassed(startpoint, startpoint + (0,0,skyheight), 0, undefined))
		{
			spawnpoint.outside = 0;
		}
	}

	right = anglestoright(spawnpoint.angles);
	spawnpoint.alternates = [];
	addalternatespawnpoint(spawnpoint, spawnpoint.origin + right * 45);
	addalternatespawnpoint(spawnpoint, spawnpoint.origin - right * 45);
	spawnpointupdate(spawnpoint);
	spawnpoint.inited = 1;
}

addalternatespawnpoint(spawnpoint, alternatepos)
{
	spawnpointposraised = playerphysicstrace(spawnpoint.origin, spawnpoint.origin + (0,0,18), 0, undefined);
	zdiff = spawnpointposraised[2] - spawnpoint.origin[2];
	alternateposraised = (alternatepos[0],alternatepos[1],alternatepos[2] + zdiff);
	traceresult = playerphysicstrace(spawnpointposraised, alternateposraised, 0, undefined);
	if(traceresult != alternateposraised)
	{
		return;
	}

	finalalternatepos = playerphysicstrace(alternateposraised, alternatepos);
	spawnpoint.alternates[spawnpoint.alternates.size] = finalalternatepos;
}

getteamspawnpoints(team)
{
	return level.teamspawnpoints[team];
}

getspawnpoint_final(spawnpoints, useweights)
{
	bestspawnpoint = undefined;
	if(!isdefined(spawnpoints) || spawnpoints.size == 0)
	{
		return undefined;
	}

	if(!isdefined(useweights))
	{
		useweights = 1;
	}

	if(useweights)
	{
		bestspawnpoint = getbestweightedspawnpoint(spawnpoints);
	}
	else
	{
		carepackages = getentarray("care_package", "targetname");
		for(i = 0;i < spawnpoints.size;i++)
		{
			if(isdefined(self.lastspawnpoint) && self.lastspawnpoint == spawnpoints[i])
			{
				continue;
			}

			if(positionwouldtelefrag(spawnpoints[i].origin))
			{
				continue;
			}

			if(carepackages.size && !canspawn(spawnpoints[i].origin))
			{
				continue;
			}

			bestspawnpoint = spawnpoints[i];
			break;
		}

		if(!isdefined(bestspawnpoint))
		{
			if(isdefined(self.lastspawnpoint) && !positionwouldtelefrag(self.lastspawnpoint.origin))
			{
				for(i = 0;i < spawnpoints.size;i++)
				{
					if(spawnpoints[i] == self.lastspawnpoint)
					{
						bestspawnpoint = spawnpoints[i];
						break;
					}
				}
			}
		}
	}

	if(!isdefined(bestspawnpoint))
	{
		if(useweights)
		{
			bestspawnpoint = spawnpoints[randomint(spawnpoints.size)];
		}
		else
		{
			bestspawnpoint = spawnpoints[0];
		}
	}

	return bestspawnpoint;
}

finalizespawnpointchoice(spawnpoint)
{
	time = gettime();
	self.lastspawnpoint = spawnpoint;
	self.lastspawntime = time;
	spawnpoint.lastspawnedplayer = self;
	spawnpoint.lastspawntime = time;
}

getbestweightedspawnpoint(spawnpoints)
{
	otherteam = maps\mp\_utility::getotherteam(self.team);
	try = 0;
	for(;;)
	{
		bestspawnpoints = [];
		bestspawnpoints[0] = spawnpoints[0];
		bestweight = spawnpoints[0].weight;
		for(i = 1;i < spawnpoints.size;i++)
		{
			spawnpoint = spawnpoints[i];
			if(spawnpoint.weight > bestweight)
			{
				bestspawnpoints = [];
				bestspawnpoints[0] = spawnpoint;
				bestweight = spawnpoint.weight;
				continue;
			}

			if(spawnpoint.weight == bestweight)
			{
				bestspawnpoints[bestspawnpoints.size] = spawnpoint;
			}
		}

		bestspawnpoint = bestspawnpoints[randomint(bestspawnpoints.size)];
		if(try >= 3)
		{
			return bestspawnpoint;
		}

		sights = 0;
		if(level.teambased)
		{
			sights = bestspawnpoint.sights[otherteam];
		}
		else
		{
			sights = bestspawnpoint.sights;
		}

		if(sights > 0)
		{
			return bestspawnpoint;
		}

		if(isdefined(bestspawnpoint.lastsighttracetime) && bestspawnpoint.lastsighttracetime == gettime())
		{
			return bestspawnpoint;
		}

		sightvalue = lastminutesighttraces(bestspawnpoint);
		if(sightvalue == 0)
		{
			return bestspawnpoint;
		}

		sightvalue = adjustsightvalue(sightvalue);
		if(level.teambased)
		{
			bestspawnpoint.sights[otherteam] = bestspawnpoint.sights[otherteam] + sightvalue;
		}
		else
		{
			bestspawnpoint.sights = bestspawnpoint.sights + sightvalue;
		}

		penalty = getlospenalty() * sightvalue;
		bestspawnpoint.weight = bestspawnpoint.weight - penalty;
		bestspawnpoint.lastsighttracetime = gettime();
		try++;
	}
}

getspawnpoint_random(spawnpoints)
{
	if(!isdefined(spawnpoints))
	{
		return undefined;
	}

	for(i = 0;i < spawnpoints.size;i++)
	{
		j = randomint(spawnpoints.size);
		spawnpoint = spawnpoints[i];
		spawnpoints[i] = spawnpoints[j];
		spawnpoints[j] = spawnpoint;
	}

	if(isdefined(self.predictedspawnpoint))
	{
		for(i = 1;i < spawnpoints.size;i++)
		{
			if(spawnpoints[i] == self.predictedspawnpoint)
			{
				temp = spawnpoints[0];
				spawnpoints[0] = spawnpoints[i];
				spawnpoints[i] = temp;
				break;
			}
		}
	}

	return getspawnpoint_final(spawnpoints, 0);
}

getallotherplayers()
{
	aliveplayers = [];
	for(i = 0;i < level.players.size;i++)
	{
		if(!isdefined(level.players[i]))
		{
			continue;
		}

		player = level.players[i];
		if(player.sessionstate != "playing" || player == self)
		{
			continue;
		}

		aliveplayers[aliveplayers.size] = player;
	}

	return aliveplayers;
}

initweights(spawnpoints)
{
	for(i = 0;i < spawnpoints.size;i++)
	{
		spawnpoints[i].weight = 0;
	}
}

getspawnpoint_nearteam(spawnpoints, param_623)
{
	if(!isdefined(spawnpoints))
	{
		return undefined;
	}

	spawnlogic_begin();
	initweights(spawnpoints);
	obj = spawnstruct();
	allieddistanceweight = 2;
	myteam = self.team;
	enemyteam = maps\mp\_utility::getotherteam(myteam);
	carepackages = getentarray("care_package", "targetname");
	foreach(spawnpoint in spawnpoints)
	{
		if(spawnpoint.numplayersatlastupdate > 0)
		{
			allydistsum = spawnpoint.weighteddistsum[myteam];
			enemydistsum = spawnpoint.distsum[enemyteam];
			spawnpoint.weight = enemydistsum - allieddistanceweight * allydistsum / spawnpoint.numplayersatlastupdate;
		}
		else
		{
			spawnpoint.weight = 0;
		}

		if(carepackages.size && !canspawn(spawnpoint.origin))
		{
			spawnpoint.weight = spawnpoint.weight - 500000;
		}
	}

	if(isdefined(param_623))
	{
		for(i = 0;i < param_623.size;i++)
		{
			param_623[i].weight = param_623[i].weight + -15536;
		}
	}

	if(isdefined(self.predictedspawnpoint) && isdefined(self.predictedspawnpoint.weight))
	{
		self.predictedspawnpoint.weight = self.predictedspawnpoint.weight + 100;
	}

	avoidsamespawn();
	avoidweapondamage(spawnpoints);
	avoidvisibleenemies(spawnpoints, 1);
	result = getspawnpoint_final(spawnpoints);
	return result;
}

getspawnpoint_safespawn(spawnpoints)
{
	if(!isdefined(spawnpoints))
	{
		return undefined;
	}

	spawnlogic_begin();
	safestspawnpoint = undefined;
	safestdangerdist = undefined;
	enemyteam = maps\mp\_utility::getotherteam(self.team);
	if(!level.teambased)
	{
		enemyteam = "all";
	}

	mingrenadedistsquared = 250000;
	foreach(spawnpoint in spawnpoints)
	{
		dangerdist = spawnpoint.mindist[enemyteam];
		foreach(grenade in level.grenades)
		{
			if(!isdefined(grenade))
			{
				continue;
			}

			if(distancesquared(spawnpoint.origin, grenade.origin) < mingrenadedistsquared)
			{
				grenadedist = distance(spawnpoint.origin, grenade.origin) - 220;
				if(grenadedist < dangerdist)
				{
					if(grenadedist < 0)
					{
						grenadedist = 0;
					}

					dangerdist = grenadedist;
				}
			}
		}

		if(positionwouldtelefrag(spawnpoint.origin))
		{
			dangerdist = dangerdist - 200;
		}

		if(isdefined(level.artillerydangercenters))
		{
			airstrikedanger = maps\mp\killstreaks\_airstrike::getairstrikedanger(spawnpoint.origin);
			if(airstrikedanger > 0)
			{
				dangerdist = 0;
			}
		}

		if(level.teambased)
		{
			if(spawnpoint.sights[enemyteam] > 0)
			{
				dangerdist = 0;
			}
		}
		else if(spawnpoint.sights > 0)
		{
			dangerdist = 0;
		}

		if(!isdefined(safestspawnpoint) || dangerdist > safestdangerdist)
		{
			safestspawnpoint = spawnpoint;
			safestdangerdist = dangerdist;
		}
	}

	if(!isdefined(safestspawnpoint))
	{
		safestspawnpoint = spawnpoints[randomint(spawnpoints.size)];
		safestspawnpoint.safespawndangerdist = 500;
	}
	else
	{
		safestspawnpoint.safespawndangerdist = safestdangerdist;
	}

	return safestspawnpoint;
}

getspawnpoint_dm(spawnpoints)
{
	if(!isdefined(spawnpoints))
	{
		return undefined;
	}

	spawnlogic_begin();
	initweights(spawnpoints);
	aliveplayers = getallotherplayers();
	idealdist = 1600;
	baddist = 1200;
	if(aliveplayers.size > 0)
	{
		for(i = 0;i < spawnpoints.size;i++)
		{
			totaldistfromideal = 0;
			nearbybadamount = 0;
			for(j = 0;j < aliveplayers.size;j++)
			{
				dist = distance(spawnpoints[i].origin, aliveplayers[j].origin);
				if(dist < baddist)
				{
					nearbybadamount = nearbybadamount + baddist - dist / baddist;
				}

				distfromideal = abs(dist - idealdist);
				totaldistfromideal = totaldistfromideal + distfromideal;
			}

			avgdistfromideal = totaldistfromideal / aliveplayers.size;
			welldistancedamount = idealdist - avgdistfromideal / idealdist;
			spawnpoints[i].weight = welldistancedamount - nearbybadamount * 2 + randomfloat(0.2);
		}
	}

	carepackages = getentarray("care_package", "targetname");
	for(i = 0;i < spawnpoints.size;i++)
	{
		if(carepackages.size && !canspawn(spawnpoints[i].origin))
		{
			spawnpoints[i].weight = spawnpoints[i].weight - 500000;
		}
	}

	if(isdefined(self.predictedspawnpoint) && isdefined(self.predictedspawnpoint.weight))
	{
		self.predictedspawnpoint.weight = self.predictedspawnpoint.weight + 100;
	}

	avoidsamespawn();
	avoidweapondamage(spawnpoints);
	avoidvisibleenemies(spawnpoints, 0);
	return getspawnpoint_final(spawnpoints);
}

spawnlogic_begin()
{
}

init()
{
	level.spawnlogic_deaths = [];
	level.spawnlogic_spawnkills = [];
	level.players = [];
	level.grenades = [];
	level.pipebombs = [];
	level.turrets = [];
	level.helis = [];
	level.tanks = [];
	level.teamspawnpoints["axis"] = [];
	level.teamspawnpoints["allies"] = [];
	level thread trackgrenades();
	level.spawnmins = (0,0,0);
	level.spawnmaxs = (0,0,0);
	if(isdefined(level.safespawns))
	{
		for(i = 0;i < level.safespawns.size;i++)
		{
			level.safespawns[i] spawnpointinit();
		}

		return;
	}
}

trackgrenades()
{
	for(;;)
	{
		level.grenades = getentarray("grenade", "classname");
		wait 0.05;
	}
}

ispointvulnerable(playerorigin)
{
	pos = self.origin + level.claymoremodelcenteroffset;
	playerpos = playerorigin + (0,0,32);
	distsqrd = distancesquared(pos, playerpos);
	forward = anglestoforward(self.angles);
	if(distsqrd < level.claymoredetectionradius * level.claymoredetectionradius)
	{
		playerdir = vectornormalize(playerpos - pos);
		angle = acos(vectordot(playerdir, forward));
		if(angle < level.claymoredetectionconeangle)
		{
			return 1;
		}
	}

	return 0;
}

avoidweapondamage(spawnpoints)
{
	weapondamagepenalty = 100000;
	if(getdvar("scr_spawnpointweaponpenalty") != "" && getdvar("scr_spawnpointweaponpenalty") != "0")
	{
		weapondamagepenalty = getdvarfloat("scr_spawnpointweaponpenalty");
	}

	mingrenadedistsquared = -3036;
	for(i = 0;i < spawnpoints.size;i++)
	{
		for(j = 0;j < level.grenades.size;j++)
		{
			if(!isdefined(level.grenades[j]))
			{
				continue;
			}

			if(distancesquared(spawnpoints[i].origin, level.grenades[j].origin) < mingrenadedistsquared)
			{
				spawnpoints[i].weight = spawnpoints[i].weight - weapondamagepenalty;
			}
		}

		if(!isdefined(level.artillerydangercenters))
		{
			continue;
		}

		airstrikedanger = maps\mp\killstreaks\_airstrike::getairstrikedanger(spawnpoints[i].origin);
		if(airstrikedanger > 0)
		{
			worsen = airstrikedanger * weapondamagepenalty;
			spawnpoints[i].weight = spawnpoints[i].weight - worsen;
		}
	}
}

spawnperframeupdate()
{
	spawnpointindex = 0;
	for(;;)
	{
		wait 0.05;
		if(!isdefined(level.spawnpoints))
		{
			return;
		}

		spawnpointindex = spawnpointindex + 1 % level.spawnpoints.size;
		if(getdvar("scr_spawnpoint_forceindex") != "")
		{
			spawnpointindex = getdvarint("scr_spawnpoint_forceindex");
		}

		spawnpoint = level.spawnpoints[spawnpointindex];
		spawnpointupdate(spawnpoint);
	}
}

adjustsightvalue(sightvalue)
{
	if(sightvalue <= 0)
	{
		return 0;
	}

	if(sightvalue >= 1)
	{
		return 1;
	}

	return sightvalue * 0.5 + 0.25;
}

spawnpointupdate(spawnpoint)
{
	if(level.teambased)
	{
		spawnpoint.sights["axis"] = 0;
		spawnpoint.sights["allies"] = 0;
	}
	else
	{
		spawnpoint.sights = 0;
	}

	spawnpointdir = spawnpoint.forward;
	debug = 0;
	spawnpoint.distsum["all"] = 0;
	spawnpoint.distsum["allies"] = 0;
	spawnpoint.distsum["axis"] = 0;
	spawnpoint.weighteddistsum["all"] = 0;
	spawnpoint.weighteddistsum["allies"] = 0;
	spawnpoint.weighteddistsum["axis"] = 0;
	spawnpoint.mindist["all"] = 9999999;
	spawnpoint.mindist["allies"] = 9999999;
	spawnpoint.mindist["axis"] = 9999999;
	spawnpoint.numplayersatlastupdate = 0;
	totalplayers["all"] = 0;
	totalplayers["allies"] = 0;
	totalplayers["axis"] = 0;
	weightsum["all"] = 0;
	weightsum["allies"] = 0;
	weightsum["axis"] = 0;
	winner = undefined;
	curtime = gettime();
	team = "all";
	teambased = level.teambased;
	foreach(player in level.players)
	{
		if(player.sessionstate != "playing")
		{
			continue;
		}

		diff = player.origin - spawnpoint.origin;
		diff = (diff[0],diff[1],0);
		weight = 1;
		dist = length(diff);
		if(teambased)
		{
			team = player.team;
		}

		if(dist < spawnpoint.mindist[team])
		{
			spawnpoint.mindist[team] = dist;
		}

		if(player.wasti && curtime - player.spawntime < 15000)
		{
			weight = weight * 0.1;
		}

		if(player.issniper)
		{
			weight = weight * 0.5;
		}

		weightsum[team] = weightsum[team] + weight;
		spawnpoint.weighteddistsum[team] = spawnpoint.weighteddistsum[team] + dist * weight;
		spawnpoint.distsum[team] = spawnpoint.distsum[team] + dist;
		spawnpoint.numplayersatlastupdate++;
		totalplayers[team]++;
		pdir = anglestoforward(player.angles);
		if(vectordot(spawnpointdir, diff) < 0 && vectordot(pdir, diff) > 0)
		{
			continue;
		}

		sightvalue = spawnsighttrace(spawnpoint, spawnpoint.sighttracepoint, player.origin + (0,0,50));
		spawnpoint.lastsighttracetime = gettime();
		if(sightvalue > 0)
		{
			sightvalue = adjustsightvalue(sightvalue);
			if(teambased)
			{
				spawnpoint.sights[team] = spawnpoint.sights[team] + sightvalue;
				continue;
			}

			spawnpoint.sights = spawnpoint.sights + sightvalue;
		}
	}

	nearbyenemyrange = maps\mp\_utility::getfloatproperty("scr_spawn_enemyavoiddist", 1000);
	nearbyenemypenalty = 2000;
	foreach(team, value in weightsum)
	{
		if(weightsum[team])
		{
			spawnpoint.weighteddistsum[team] = spawnpoint.weighteddistsum[team] / weightsum[team] * totalplayers[team];
		}

		nearbypenalty = 0;
		if(spawnpoint.mindist[team] < nearbyenemyrange)
		{
			nearbypenalty = nearbyenemypenalty * 1 - spawnpoint.mindist[team] / nearbyenemyrange;
		}

		spawnpoint.nearbypenalty[team] = nearbypenalty;
	}

	foreach(tank in level.tanks)
	{
		sightvalue = spawnsighttrace(spawnpoint, spawnpoint.sighttracepoint, tank.origin + (0,0,50));
		spawnpoint.lastsighttracetime = gettime();
		if(sightvalue <= 0)
		{
			continue;
		}

		sightvalue = adjustsightvalue(sightvalue);
		if(teambased)
		{
			spawnpoint.sights[tank.team] = spawnpoint.sights[tank.team] + sightvalue;
			continue;
		}

		spawnpoint.sights = spawnpoint.sights + sightvalue;
	}

	foreach(turret in level.turrets)
	{
		if(!isdefined(turret))
		{
			continue;
		}

		sightvalue = spawnsighttrace(spawnpoint, spawnpoint.sighttracepoint, turret.origin + (0,0,50));
		spawnpoint.lastsighttracetime = gettime();
		if(sightvalue <= 0)
		{
			continue;
		}

		sightvalue = adjustsightvalue(sightvalue);
		if(teambased)
		{
			spawnpoint.sights[turret.team] = spawnpoint.sights[turret.team] + sightvalue;
			continue;
		}

		spawnpoint.sights = spawnpoint.sights + sightvalue;
	}
}

getlospenalty()
{
	if(getdvar("scr_spawnpointlospenalty") != "" && getdvar("scr_spawnpointlospenalty") != "0")
	{
		return getdvarfloat("scr_spawnpointlospenalty");
	}

	return 100000;
}

lastminutesighttraces(spawnpoint)
{
	closest = undefined;
	closestdistsq = 1E+08;
	secondclosest = undefined;
	secondclosestdistsq = 1E+08;
	foreach(player in level.players)
	{
		if(player.team == self.team && level.teambased)
		{
			continue;
		}

		if(player.sessionstate != "playing")
		{
			continue;
		}

		if(player == self)
		{
			continue;
		}

		distsq = distancesquared(spawnpoint.origin, player.origin);
		if(distsq < closestdistsq)
		{
			secondclosest = closest;
			secondclosestdistsq = closestdistsq;
			closest = player;
			closestdistsq = distsq;
			continue;
		}

		if(distsq < secondclosestdistsq)
		{
			secondclosest = player;
			secondclosestdistsq = distsq;
		}
	}

	if(isdefined(closest))
	{
		sightvalue = spawnsighttrace(spawnpoint, spawnpoint.sighttracepoint, closest.origin + (0,0,50));
		if(sightvalue > 0)
		{
			sightvalue = adjustsightvalue(sightvalue);
			return sightvalue;
		}
	}

	if(isdefined(secondclosest))
	{
		sightvalue = spawnsighttrace(spawnpoint, spawnpoint.sighttracepoint, secondclosest.origin + (0,0,50));
		if(sightvalue > 0)
		{
			sightvalue = adjustsightvalue(sightvalue);
			return sightvalue;
		}
	}

	return 0;
}

avoidvisibleenemies(spawnpoints, teambased)
{
	lospenalty = getlospenalty();
	otherteam = "axis";
	if(self.team == "axis")
	{
		otherteam = "allies";
	}

	if(teambased)
	{
		foreach(spawnpoint in spawnpoints)
		{
			penalty = lospenalty * spawnpoint.sights[otherteam];
			spawnpoint.weight = spawnpoint.weight - penalty;
		}
	}
	else
	{
		foreach(spawnpoint in spawnpoints)
		{
			penalty = lospenalty * spawnpoint.sights;
			spawnpoint.weight = spawnpoint.weight - penalty;
		}

		otherteam = "all";
	}

	foreach(spawnpoint in spawnpoints)
	{
		spawnpoint.weight = spawnpoint.weight - spawnpoint.nearbypenalty[otherteam];
		if(positionwouldtelefrag(spawnpoint.origin))
		{
			telefragcount = 1;
			foreach(alternate in spawnpoint.alternates)
			{
				if(positionwouldtelefrag(alternate))
				{
					telefragcount++;
					continue;
				}

				break;
			}

			penalty = 100000;
			if(telefragcount < spawnpoint.alternates.size + 1)
			{
				penalty = 1500 * telefragcount;
				if(isdefined(self.forcespawnnearteammates))
				{
					penalty = 0;
				}
			}

			spawnpoint.weight = spawnpoint.weight - penalty;
		}
	}
}

avoidspawnreuse(spawnpoints, teambased)
{
	time = gettime();
	maxtime = 10000;
	maxdistsq = 1048576;
	foreach(spawnpoint in spawnpoints)
	{
		lastspawnedplayer = spawnpoint.lastspawnedplayer;
		if(!isalive(lastspawnedplayer))
		{
			continue;
		}

		if(teambased && spawnpoint.lastspawnedplayer.team == self.team)
		{
			continue;
		}

		if(spawnpoint.lastspawnedplayer == self)
		{
			continue;
		}

		timepassed = time - spawnpoint.lastspawntime;
		if(timepassed < maxtime)
		{
			distsq = distancesquared(spawnpoint.lastspawnedplayer.origin, spawnpoint.origin);
			if(distsq < maxdistsq)
			{
				worsen = 5000 * 1 - distsq / maxdistsq * 1 - timepassed / maxtime;
				spawnpoint.weight = spawnpoint.weight - worsen;
			}
			else
			{
				spawnpoint.lastspawnedplayer = undefined;
			}

			continue;
		}

		spawnpoint.lastspawnedplayer = undefined;
	}
}

avoidsamespawn()
{
	spawnpoint = self.lastspawnpoint;
	if(!isdefined(spawnpoint) || !isdefined(spawnpoint.weight))
	{
		return;
	}

	spawnpoint.weight = spawnpoint.weight - 1000;
}