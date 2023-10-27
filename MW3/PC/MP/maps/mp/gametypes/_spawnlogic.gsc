/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes\_spawnlogic.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: PC
 * Function Count: 48
 * Decompile Time: 702 ms
 * Timestamp: 10/27/2023 2:12:56 AM
*******************************************************************/

//Function Number: 1
findboxcenter(param_00,param_01)
{
	var_02 = (0,0,0);
	var_02 = param_01 - param_00;
	var_02 = (var_02[0] / 2,var_02[1] / 2,var_02[2] / 2) + param_00;
	return var_02;
}

//Function Number: 2
expandmins(param_00,param_01)
{
	if(param_00[0] > param_01[0])
	{
		param_00 = (param_01[0],param_00[1],param_00[2]);
	}

	if(param_00[1] > param_01[1])
	{
		param_00 = (param_00[0],param_01[1],param_00[2]);
	}

	if(param_00[2] > param_01[2])
	{
		param_00 = (param_00[0],param_00[1],param_01[2]);
	}

	return param_00;
}

//Function Number: 3
expandmaxs(param_00,param_01)
{
	if(param_00[0] < param_01[0])
	{
		param_00 = (param_01[0],param_00[1],param_00[2]);
	}

	if(param_00[1] < param_01[1])
	{
		param_00 = (param_00[0],param_01[1],param_00[2]);
	}

	if(param_00[2] < param_01[2])
	{
		param_00 = (param_00[0],param_00[1],param_01[2]);
	}

	return param_00;
}

//Function Number: 4
addspawnpoints(param_00,param_01,param_02)
{
	if(!isdefined(param_02))
	{
		param_02 = 0;
	}

	var_03 = [];
	if(level.teamspawnpoints[param_00].size)
	{
		var_03 = level.teamspawnpoints[param_00];
	}

	level.teamspawnpoints[param_00] = getspawnpointarray(param_01);
	if(!level.teamspawnpoints[param_00].size && !param_02)
	{
		maps\mp\gametypes\_callbacksetup::abortlevel();
		wait 1;
		return;
	}

	if(!isdefined(level.spawnpoints))
	{
		level.spawnpoints = [];
	}

	for(var_04 = 0;var_04 < level.teamspawnpoints[param_00].size;var_04++)
	{
		var_05 = level.teamspawnpoints[param_00][var_04];
		if(!isdefined(var_05.inited))
		{
			var_05 spawnpointinit();
			level.spawnpoints[level.spawnpoints.size] = var_05;
		}
	}

	for(var_04 = 0;var_04 < var_03.size;var_04++)
	{
		var_06 = var_03[var_04].origin;
		level.spawnmins = expandmins(level.spawnmins,var_06);
		level.spawnmaxs = expandmaxs(level.spawnmaxs,var_06);
		level.teamspawnpoints[param_00][level.teamspawnpoints[param_00].size] = var_03[var_04];
	}
}

//Function Number: 5
placespawnpoints(param_00)
{
	var_01 = getspawnpointarray(param_00);
	if(!var_01.size)
	{
		maps\mp\gametypes\_callbacksetup::abortlevel();
		wait 1;
		return;
	}

	if(!isdefined(level.startspawnpoints))
	{
		level.startspawnpoints = [];
	}

	for(var_02 = 0;var_02 < var_01.size;var_02++)
	{
		var_01[var_02] spawnpointinit();
		level.startspawnpoints[level.startspawnpoints.size] = var_01[var_02];
	}
}

//Function Number: 6
getspawnpointarray(param_00)
{
	var_01 = getentarray(param_00,"classname");
	if(!isdefined(level.extraspawnpoints) || !isdefined(level.extraspawnpoints[param_00]))
	{
		return var_01;
	}

	for(var_02 = 0;var_02 < level.extraspawnpoints[param_00].size;var_02++)
	{
		var_01[var_01.size] = level.extraspawnpoints[param_00][var_02];
	}

	return var_01;
}

//Function Number: 7
expandspawnpointbounds(param_00)
{
	var_01 = getspawnpointarray(param_00);
	for(var_02 = 0;var_02 < var_01.size;var_02++)
	{
		level.spawnmins = expandmins(level.spawnmins,var_01[var_02].origin);
		level.spawnmaxs = expandmaxs(level.spawnmaxs,var_01[var_02].origin);
	}
}

//Function Number: 8
setmapcenterforreflections()
{
	level.spawnmins = (0,0,0);
	level.spawnmaxs = (0,0,0);
	expandspawnpointbounds("mp_tdm_spawn_allies_start");
	expandspawnpointbounds("mp_tdm_spawn_axis_start");
	level.mapcenter = findboxcenter(level.spawnmins,level.spawnmaxs);
	setmapcenter(level.mapcenter);
}

//Function Number: 9
spawnpointinit()
{
	var_00 = self;
	var_01 = var_00.origin;
	level.spawnmins = expandmins(level.spawnmins,var_01);
	level.spawnmaxs = expandmaxs(level.spawnmaxs,var_01);
	var_00 placespawnpoint();
	var_00.forward = anglestoforward(var_00.angles);
	var_00.sighttracepoint = var_00.origin + (0,0,50);
	var_00.lastspawnedplayer = var_00;
	var_00.lastspawntime = gettime();
	var_02 = 1024;
	var_00.outside = 1;
	if(!bullettracepassed(var_00.sighttracepoint,var_00.sighttracepoint + (0,0,var_02),0,undefined))
	{
		var_03 = var_00.sighttracepoint + var_00.forward * 100;
		if(!bullettracepassed(var_03,var_03 + (0,0,var_02),0,undefined))
		{
			var_00.outside = 0;
		}
	}

	var_04 = anglestoright(var_00.angles);
	var_00.alternates = [];
	addalternatespawnpoint(var_00,var_00.origin + var_04 * 45);
	addalternatespawnpoint(var_00,var_00.origin - var_04 * 45);
	spawnpointupdate(var_00);
	var_00.inited = 1;
}

//Function Number: 10
addalternatespawnpoint(param_00,param_01)
{
	var_02 = playerphysicstrace(param_00.origin,param_00.origin + (0,0,18),0,undefined);
	var_03 = var_02[2] - param_00.origin[2];
	var_04 = (param_01[0],param_01[1],param_01[2] + var_03);
	var_05 = playerphysicstrace(var_02,var_04,0,undefined);
	if(var_05 != var_04)
	{
		return;
	}

	var_06 = playerphysicstrace(var_04,param_01);
	param_00.alternates[param_00.alternates.size] = var_06;
}

//Function Number: 11
getteamspawnpoints(param_00)
{
	return level.teamspawnpoints[param_00];
}

//Function Number: 12
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
		var_03 = getentarray("care_package","targetname");
		for(var_04 = 0;var_04 < param_00.size;var_04++)
		{
			if(isdefined(self.lastspawnpoint) && self.lastspawnpoint == param_00[var_04])
			{
				continue;
			}

			if(positionwouldtelefrag(param_00[var_04].origin))
			{
				continue;
			}

			if(var_03.size && !canspawn(param_00[var_04].origin))
			{
				continue;
			}

			var_02 = param_00[var_04];
			break;
		}

		if(!isdefined(var_02))
		{
			if(isdefined(self.lastspawnpoint) && !positionwouldtelefrag(self.lastspawnpoint.origin))
			{
				for(var_04 = 0;var_04 < param_00.size;var_04++)
				{
					if(param_00[var_04] == self.lastspawnpoint)
					{
						var_02 = param_00[var_04];
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

//Function Number: 13
finalizespawnpointchoice(param_00)
{
	var_01 = gettime();
	self.lastspawnpoint = param_00;
	self.lastspawntime = var_01;
	param_00.lastspawnedplayer = self;
	param_00.lastspawntime = var_01;
}

//Function Number: 14
getbestweightedspawnpoint(param_00)
{
	var_01 = maps\mp\_utility::getotherteam(self.team);
	var_02 = 0;
	for(;;)
	{
		var_03 = [];
		var_03[0] = param_00[0];
		var_04 = param_00[0].weight;
		for(var_05 = 1;var_05 < param_00.size;var_05++)
		{
			var_06 = param_00[var_05];
			if(var_06.weight > var_04)
			{
				var_03 = [];
				var_03[0] = var_06;
				var_04 = var_06.weight;
				continue;
			}

			if(var_06.weight == var_04)
			{
				var_03[var_03.size] = var_06;
			}
		}

		var_07 = var_03[randomint(var_03.size)];
		if(var_02 >= 3)
		{
			return var_07;
		}

		var_08 = 0;
		if(level.teambased)
		{
			var_08 = var_07.sights[var_01];
		}
		else
		{
			var_08 = var_07.sights;
		}

		if(var_08 > 0)
		{
			return var_07;
		}

		if(isdefined(var_07.lastsighttracetime) && var_07.lastsighttracetime == gettime())
		{
			return var_07;
		}

		var_09 = lastminutesighttraces(var_07);
		if(var_09 == 0)
		{
			return var_07;
		}

		var_09 = adjustsightvalue(var_09);
		if(level.teambased)
		{
			var_07.sights[var_01] = var_07.sights[var_01] + var_09;
		}
		else
		{
			var_07.sights = var_07.sights + var_09;
		}

		var_0A = getlospenalty() * var_09;
		var_07.weight = var_07.weight - var_0A;
		var_07.lastsighttracetime = gettime();
		var_02++;
	}
}

//Function Number: 15
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

	if(isdefined(self.predictedspawnpoint))
	{
		for(var_01 = 1;var_01 < param_00.size;var_01++)
		{
			if(param_00[var_01] == self.predictedspawnpoint)
			{
				var_04 = param_00[0];
				param_00[0] = param_00[var_01];
				param_00[var_01] = var_04;
				break;
			}
		}
	}

	return getspawnpoint_final(param_00,0);
}

//Function Number: 16
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

//Function Number: 17
initweights(param_00)
{
	for(var_01 = 0;var_01 < param_00.size;var_01++)
	{
		param_00[var_01].weight = 0;
	}
}

//Function Number: 18
getspawnpoint_nearteam(param_00,param_01)
{
	if(!isdefined(param_00))
	{
		return undefined;
	}

	spawnlogic_begin();
	initweights(param_00);
	var_02 = 2;
	var_03 = self.team;
	var_04 = maps\mp\_utility::getotherteam(var_03);
	var_05 = getentarray("care_package","targetname");
	foreach(var_07 in param_00)
	{
		if(var_07.numplayersatlastupdate > 0)
		{
			var_08 = var_07.weighteddistsum[var_03];
			var_09 = var_07.distsum[var_04];
			var_07.weight = var_09 - var_02 * var_08 / var_07.numplayersatlastupdate;
			if(isdefined(level.favorclosespawnent))
			{
				if(!isdefined(level.favorclosespawnscalar))
				{
					level.favorclosespawnscalar = 1;
				}

				var_0A = distance(var_07.origin,level.favorclosespawnent.origin);
				var_07.weight = var_07.weight - var_0A * level.favorclosespawnscalar;
			}
		}
		else
		{
			var_07.weight = 0;
		}

		if(var_05.size && !canspawn(var_07.origin))
		{
			var_07.weight = var_07.weight - 500000;
		}
	}

	if(isdefined(param_01))
	{
		for(var_0C = 0;var_0C < param_01.size;var_0C++)
		{
			param_01[var_0C].weight = param_01[var_0C].weight + -15536;
		}
	}

	if(isdefined(self.predictedspawnpoint) && isdefined(self.predictedspawnpoint.weight))
	{
		self.predictedspawnpoint.weight = self.predictedspawnpoint.weight + 100;
	}

	avoidsamespawn();
	avoidweapondamage(param_00);
	avoidvisibleenemies(param_00,1);
	if(isdefined(self.lastdeathpos) && level.gametype != "dom")
	{
		avoidrevengespawn(param_00,self.lastdeathpos);
	}

	var_0D = getspawnpoint_final(param_00);
	return var_0D;
}

//Function Number: 19
getspawnpoint_safespawn(param_00)
{
	if(!isdefined(param_00))
	{
		return undefined;
	}

	spawnlogic_begin();
	var_01 = undefined;
	var_02 = undefined;
	var_03 = maps\mp\_utility::getotherteam(self.team);
	if(!level.teambased)
	{
		var_03 = "all";
	}

	var_04 = 250000;
	foreach(var_06 in param_00)
	{
		var_07 = var_06.mindist[var_03];
		foreach(var_09 in level.grenades)
		{
			if(!isdefined(var_09))
			{
				continue;
			}

			if(distancesquared(var_06.origin,var_09.origin) < var_04)
			{
				var_0A = distance(var_06.origin,var_09.origin) - 220;
				if(var_0A < var_07)
				{
					if(var_0A < 0)
					{
						var_0A = 0;
					}

					var_07 = var_0A;
				}
			}
		}

		if(positionwouldtelefrag(var_06.origin))
		{
			var_07 = var_07 - 200;
		}

		if(isdefined(level.artillerydangercenters))
		{
			var_0C = maps\mp\killstreaks\_airstrike::getairstrikedanger(var_06.origin);
			if(var_0C > 0)
			{
				var_07 = 0;
			}
		}

		if(level.teambased)
		{
			if(var_06.sights[var_03] > 0)
			{
				var_07 = 0;
			}
		}
		else if(var_06.sights > 0)
		{
			var_07 = 0;
		}

		if(!isdefined(var_01) || var_07 > var_02)
		{
			var_01 = var_06;
			var_02 = var_07;
		}
	}

	if(!isdefined(var_01))
	{
		var_01 = param_00[randomint(param_00.size)];
		var_01.safespawndangerdist = 500;
	}
	else
	{
		var_01.safespawndangerdist = var_02;
	}

	return var_01;
}

//Function Number: 20
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

	var_0C = getentarray("care_package","targetname");
	for(var_04 = 0;var_04 < param_00.size;var_04++)
	{
		if(var_0C.size && !canspawn(param_00[var_04].origin))
		{
			param_00[var_04].weight = param_00[var_04].weight - 500000;
		}
	}

	if(isdefined(self.predictedspawnpoint) && isdefined(self.predictedspawnpoint.weight))
	{
		self.predictedspawnpoint.weight = self.predictedspawnpoint.weight + 100;
	}

	avoidsamespawn();
	avoidweapondamage(param_00);
	avoidvisibleenemies(param_00,0);
	return getspawnpoint_final(param_00);
}

//Function Number: 21
spawnlogic_begin()
{
}

//Function Number: 22
init()
{
	setupkillstreakspawnshield();
	level.spawnlogic_deaths = [];
	level.spawnlogic_spawnkills = [];
	level.players = [];
	level.grenades = [];
	level.pipebombs = [];
	level.turrets = [];
	level.helis = [];
	level.tanks = [];
	level.scramblers = [];
	level.ims = [];
	level.ugvs = [];
	level.teamspawnpoints["axis"] = [];
	level.teamspawnpoints["allies"] = [];
	level thread trackgrenades();
	level thread trackmissiles();
	level.spawnmins = (0,0,0);
	level.spawnmaxs = (0,0,0);
	if(isdefined(level.safespawns))
	{
		for(var_00 = 0;var_00 < level.safespawns.size;var_00++)
		{
			level.safespawns[var_00] spawnpointinit();
		}
	}
}

//Function Number: 23
sightcheckcost()
{
	var_00 = 30;
	for(;;)
	{
		var_01 = getdvar("scr_debugcost");
		if(var_01 == "bullet" && isdefined(level.players[0]))
		{
			for(var_02 = 0;var_02 < var_00;var_02++)
			{
				bullettracepassed(level.players[0].origin + (0,0,50),(0,0,0),0,undefined);
			}
		}
		else if(var_01 == "damagecone" && isdefined(level.players[0]))
		{
			for(var_02 = 0;var_02 < var_00;var_02++)
			{
				level.players[0] damageconetrace((0,0,0));
			}
		}
		else if(var_01 == "sightcone" && isdefined(level.players[0]))
		{
			for(var_02 = 0;var_02 < var_00;var_02++)
			{
				level.players[0] sightconetrace((0,0,0));
			}
		}
		else
		{
			wait 1;
		}

		wait 0.05;
	}
}

//Function Number: 24
watchspawnprofile()
{
	for(;;)
	{
		while(getdvar("scr_spawnprofile") == "" || getdvar("scr_spawnprofile") == "0")
		{
			wait 0.05;
		}

		thread spawnprofile();
		while(getdvar("scr_spawnprofile") != "" && getdvar("scr_spawnprofile") != "0")
		{
			wait 0.05;
		}

		level notify("stop_spawn_profile");
	}
}

//Function Number: 25
spawnprofile()
{
	level endon("stop_spawn_profile");
	var_00 = spawnstruct();
	for(;;)
	{
		var_01 = getdvar("scr_spawnprofile");
		if(var_01 != "allies" && var_01 != "axis")
		{
			if(common_scripts\utility::cointoss())
			{
				var_01 = "allies";
			}
			else
			{
				var_01 = "axis";
			}
		}

		var_00.team = var_01;
		var_00.pers["team"] = var_01;
		var_00 getspawnpoint_nearteam(level.spawnpoints);
		wait 0.05;
	}
}

//Function Number: 26
spawngraphcheck()
{
	for(;;)
	{
		if(getdvarint("scr_spawngraph") < 1)
		{
			wait 3;
			continue;
		}

		thread spawngraph();
		while(getdvarint("scr_spawngraph") >= 1)
		{
			wait 0.2;
			continue;
		}

		level notify("end_spawn_graph");
		level notify("spawn_graph_stop_draw");
	}
}

//Function Number: 27
spawngraph()
{
	level endon("end_spawn_graph");
	var_00 = 20;
	var_01 = 20;
	var_02 = 0.1;
	var_03 = [];
	var_04 = getentarray("minimap_corner","targetname");
	if(var_04.size != 2)
	{
		return;
	}

	var_05 = var_04[0].origin;
	var_06 = var_04[0].origin;
	if(var_04[1].origin[0] > var_06[0])
	{
		var_06 = (var_04[1].origin[0],var_06[1],var_06[2]);
	}
	else
	{
		var_05 = (var_04[1].origin[0],var_05[1],var_05[2]);
	}

	if(var_04[1].origin[1] > var_06[1])
	{
		var_06 = (var_06[0],var_04[1].origin[1],var_06[2]);
	}
	else
	{
		var_05 = (var_05[0],var_04[1].origin[1],var_05[2]);
	}

	var_07 = 0;
	for(var_08 = 0;var_08 < var_01;var_08++)
	{
		var_09 = var_08 / var_01 - 1;
		for(var_0A = 0;var_0A < var_00;var_0A++)
		{
			var_0B = var_0A / var_00 - 1;
			var_03[var_07] = spawnstruct();
			var_03[var_07].origin = (var_05[0] * var_0B + var_06[0] * 1 - var_0B,var_05[1] * var_09 + var_06[1] * 1 - var_09,var_05[2]);
			var_03[var_07].angles = (0,0,0);
			var_03[var_07].forward = anglestoforward(var_03[var_07].angles);
			var_03[var_07].sighttracepoint = var_03[var_07].origin;
			var_03[var_07].outside = 1;
			var_03[var_07].secondfloor = 0;
			var_03[var_07].fake = 1;
			var_07++;
		}
	}

	var_0C = 0;
	for(;;)
	{
		var_0D = 0;
		var_0E = 10;
		for(var_07 = 0;var_07 < var_0E;var_07++)
		{
			if(!level.players.size || !isdefined(level.players[0].team) || level.players[0].team == "spectator" || !isdefined(level.players[0].class))
			{
				break;
			}

			var_0F = var_0D + var_03.size / var_0E;
			if(var_07 == var_0E - 1)
			{
				var_0F = var_03.size;
			}

			while(var_0D < var_0F)
			{
				spawnpointupdate(var_03[var_0D]);
				var_0D++;
			}

			wait 0.05;
		}

		if(!level.players.size || !isdefined(level.players[0].team) || level.players[0].team == "spectator" || !isdefined(level.players[0].class))
		{
			wait 1;
			continue;
		}

		level.players[0] getspawnpoint_nearteam(var_03);
		for(var_07 = 0;var_07 < var_03.size;var_07++)
		{
			setupspawngraphpoint(var_03[var_07],var_02);
		}

		var_0C = 1;
		level.players[0] drawspawngraph(var_03,var_00,var_01,var_02);
		wait 0.05;
	}
}

//Function Number: 28
drawspawngraph(param_00,param_01,param_02,param_03)
{
	level notify("spawn_graph_stop_draw");
	var_04 = 0;
	for(var_05 = 0;var_05 < param_02;var_05++)
	{
		var_06 = var_05 / param_02 - 1;
		for(var_07 = 0;var_07 < param_01;var_07++)
		{
			var_08 = var_07 / param_01 - 1;
			if(var_05 > 0)
			{
				thread spawngraphline(param_00[var_04],param_00[var_04 - param_01],param_03);
			}

			if(var_07 > 0)
			{
				thread spawngraphline(param_00[var_04],param_00[var_04 - 1],param_03);
			}

			var_04++;
		}
	}
}

//Function Number: 29
setupspawngraphpoint(param_00,param_01)
{
	param_00.visible = 1;
	if(param_00.weight < -1000 / param_01)
	{
		param_00.visible = 0;
	}
}

//Function Number: 30
spawngraphline(param_00,param_01,param_02)
{
	if(!param_00.visible || !param_01.visible)
	{
		return;
	}

	var_03 = param_00.origin + (0,0,param_00.weight * param_02 + 100);
	var_04 = param_01.origin + (0,0,param_01.weight * param_02 + 100);
	level endon("spawn_graph_stop_draw");
	for(;;)
	{
		wait 0.05;
		waittillframeend;
	}
}

//Function Number: 31
loopbotspawns()
{
	for(;;)
	{
		if(getdvarint("scr_killbots") < 1)
		{
			wait 3;
			continue;
		}

		if(!isdefined(level.players))
		{
			wait 0.05;
			continue;
		}

		var_00 = [];
		for(var_01 = 0;var_01 < level.players.size;var_01++)
		{
			if(!isdefined(level.players[var_01]))
			{
				continue;
			}

			if(level.players[var_01].sessionstate == "playing" && issubstr(level.players[var_01].name,"bot"))
			{
				var_00[var_00.size] = level.players[var_01];
			}
		}

		if(var_00.size > 0)
		{
			if(getdvarint("scr_killbots") == 1)
			{
				var_02 = var_00[randomint(var_00.size)];
				var_03 = var_00[randomint(var_00.size)];
				var_03 thread [[ level.callbackplayerdamage ]](var_02,var_02,1000,0,"MOD_RIFLE_BULLET","none",(0,0,0),(0,0,0),"none",0);
			}
			else
			{
				var_04 = getdvarint("scr_killbots");
				var_05 = undefined;
				for(var_06 = 0;var_06 < var_04;var_06++)
				{
					var_02 = var_00[randomint(var_00.size)];
					var_03 = var_00[randomint(var_00.size)];
					while(isdefined(var_05) && var_03 == var_05)
					{
						var_03 = var_00[randomint(var_00.size)];
					}

					var_03 thread [[ level.callbackplayerdamage ]](var_02,var_02,1000,0,"MOD_RIFLE_BULLET","none",(0,0,0),(0,0,0),"none",0);
					var_05 = var_03;
				}
			}
		}

		if(getdvarfloat("scr_killbottimer") > 0.05)
		{
			wait getdvarfloat("scr_killbottimer");
			continue;
		}

		wait 0.05;
	}
}

//Function Number: 32
trackgrenades()
{
	for(;;)
	{
		level.grenades = getentarray("grenade","classname");
		wait 0.05;
	}
}

//Function Number: 33
trackmissiles()
{
	for(;;)
	{
		level.missiles = getentarray("rocket","classname");
		wait 0.05;
	}
}

//Function Number: 34
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

//Function Number: 35
avoidweapondamage(param_00)
{
	var_01 = 100000;
	if(getdvar("scr_spawnpointweaponpenalty") != "" && getdvar("scr_spawnpointweaponpenalty") != "0")
	{
		var_01 = getdvarfloat("scr_spawnpointweaponpenalty");
	}

	var_02 = -3036;
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

		foreach(var_06 in level.mines)
		{
			if(!isdefined(var_06))
			{
				continue;
			}

			if(distancesquared(param_00[var_03].origin,var_06.origin) < var_02)
			{
				param_00[var_03].weight = param_00[var_03].weight - var_01;
			}
		}

		if(!isdefined(level.artillerydangercenters))
		{
			continue;
		}

		var_08 = maps\mp\killstreaks\_airstrike::getairstrikedanger(param_00[var_03].origin);
		if(var_08 > 0)
		{
			var_09 = var_08 * var_01;
			param_00[var_03].weight = param_00[var_03].weight - var_09;
		}
	}
}

//Function Number: 36
spawnperframeupdate()
{
	var_00 = 0;
	for(;;)
	{
		wait 0.05;
		if(!isdefined(level.spawnpoints))
		{
			return;
		}

		var_00 = var_00 + 1 % level.spawnpoints.size;
		if(getdvar("scr_spawnpoint_forceindex") != "")
		{
			var_00 = getdvarint("scr_spawnpoint_forceindex");
		}

		var_01 = level.spawnpoints[var_00];
		spawnpointupdate(var_01);
	}
}

//Function Number: 37
adjustsightvalue(param_00)
{
	if(param_00 <= 0)
	{
		return 0;
	}

	if(param_00 >= 1)
	{
		return 1;
	}

	return param_00 * 0.5 + 0.25;
}

//Function Number: 38
spawnpointupdate(param_00)
{
	if(level.teambased)
	{
		param_00.sights["axis"] = 0;
		param_00.sights["allies"] = 0;
	}
	else
	{
		param_00.sights = 0;
	}

	var_01 = param_00.forward;
	var_02 = 0;
	param_00.distsum["all"] = 0;
	param_00.distsum["allies"] = 0;
	param_00.distsum["axis"] = 0;
	param_00.weighteddistsum["all"] = 0;
	param_00.weighteddistsum["allies"] = 0;
	param_00.weighteddistsum["axis"] = 0;
	param_00.mindist["all"] = 9999999;
	param_00.mindist["allies"] = 9999999;
	param_00.mindist["axis"] = 9999999;
	param_00.numplayersatlastupdate = 0;
	var_03["all"] = 0;
	param_00["all"] = 0;
	var_05 = undefined;
	var_06 = gettime();
	var_07 = "all";
	var_08 = level.teambased;
	foreach(var_0A in level.players)
	{
		if(var_0A.sessionstate != "playing")
		{
			continue;
		}

		var_0B = var_0A.origin - param_00.origin;
		var_0B = (var_0B[0],var_0B[1],0);
		var_0C = 1;
		var_0D = length(var_0B);
		if(var_08)
		{
			var_07 = var_0A.team;
		}

		if(var_0D < param_00.mindist[var_07])
		{
			param_00.mindist[var_07] = var_0D;
		}

		if(var_0A.wasti && var_06 - var_0A.spawntime < 15000)
		{
			var_0C = var_0C * 0.1;
		}

		if(var_0A.issniper)
		{
			var_0C = var_0C * 0.5;
		}

		var_7B[var_07] = var_7B[var_07] + var_0C;
		param_00.weighteddistsum[var_07] = param_00.weighteddistsum[var_07] + var_0D * var_0C;
		param_00.distsum[var_07] = param_00.distsum[var_07] + var_0D;
		param_00.numplayersatlastupdate++ = var_7B["axis"];
		var_03[var_07]++ = 0;
		var_0E = anglestoforward(var_0A.angles);
		if(vectordot(var_01,var_0B) < 0 && vectordot(var_0E,var_0B) > 0)
		{
			continue;
		}

		var_0F = spawnsighttrace(param_00,param_00.sighttracepoint,var_0A.origin + (0,0,50));
		param_00.lastsighttracetime = gettime();
		if(var_0F > 0)
		{
			var_0F = adjustsightvalue(var_0F);
			if(var_08)
			{
				param_00.sights[var_07] = param_00.sights[var_07] + var_0F;
				continue;
			}

			param_00.sights = param_00.sights + var_0F;
		}
	}

	var_11 = maps\mp\_utility::getfloatproperty("scr_spawn_enemyavoiddist",2000);
	var_12 = 2000;
	foreach(var_07, var_14 in var_7B)
	{
		if(var_7B[var_07])
		{
			param_00.weighteddistsum[var_07] = param_00.weighteddistsum[var_07] / var_7B[var_07] * var_03[var_07];
		}

		var_15 = 0;
		if(param_00.mindist[var_07] < var_11)
		{
			var_15 = var_12 * 1 - param_00.mindist[var_07] / var_11;
		}

		param_00.nearbypenalty[var_07] = var_15;
	}

	foreach(var_17 in level.tanks)
	{
		var_0F = spawnsighttrace(param_00,param_00.sighttracepoint,var_17.origin + (0,0,50));
		param_00.lastsighttracetime = gettime();
		if(var_0F <= 0)
		{
			continue;
		}

		var_0F = adjustsightvalue(var_0F);
		if(var_08)
		{
			param_00.sights[var_17.team] = param_00.sights[var_17.team] + var_0F;
			continue;
		}

		param_00.sights = param_00.sights + var_0F;
	}

	foreach(var_1A in level.turrets)
	{
		if(!isdefined(var_1A))
		{
			continue;
		}

		var_0F = spawnsighttrace(param_00,param_00.sighttracepoint,var_1A.origin + (0,0,50));
		param_00.lastsighttracetime = gettime();
		if(var_0F <= 0)
		{
			continue;
		}

		var_0F = adjustsightvalue(var_0F);
		if(var_08)
		{
			param_00.sights[var_1A.team] = param_00.sights[var_1A.team] + var_0F;
			continue;
		}

		param_00.sights = param_00.sights + var_0F;
	}

	foreach(var_1D in level.ims)
	{
		if(!isdefined(var_1D))
		{
			continue;
		}

		if(!isdefined(var_1D.attackheightpos))
		{
			continue;
		}

		var_0F = spawnsighttrace(param_00,param_00.sighttracepoint,var_1D.attackheightpos);
		param_00.lastsighttracetime = gettime();
		if(var_0F <= 0)
		{
			continue;
		}

		var_0F = adjustsightvalue(var_0F);
		if(var_08)
		{
			param_00.sights[var_1D.team] = param_00.sights[var_1D.team] + var_0F;
			continue;
		}

		param_00.sights = param_00.sights + var_0F;
	}

	foreach(var_20 in level.ugvs)
	{
		if(!isdefined(var_20))
		{
			continue;
		}

		var_0F = spawnsighttrace(param_00,param_00.sighttracepoint,var_20.origin + (0,0,50));
		param_00.lastsighttracetime = gettime();
		if(var_0F <= 0)
		{
			continue;
		}

		var_0F = adjustsightvalue(var_0F);
		if(var_08)
		{
			param_00.sights[var_20.team] = param_00.sights[var_20.team] + var_0F;
			continue;
		}

		param_00.sights = param_00.sights + var_0F;
	}
}

//Function Number: 39
getlospenalty()
{
	if(getdvar("scr_spawnpointlospenalty") != "" && getdvar("scr_spawnpointlospenalty") != "0")
	{
		return getdvarfloat("scr_spawnpointlospenalty");
	}

	return 100000;
}

//Function Number: 40
lastminutesighttraces(param_00)
{
	var_01 = undefined;
	var_02 = 1E+08;
	var_03 = undefined;
	var_04 = 1E+08;
	foreach(var_06 in level.players)
	{
		if(var_06.team == self.team && level.teambased)
		{
			continue;
		}

		if(var_06.sessionstate != "playing")
		{
			continue;
		}

		if(var_06 == self)
		{
			continue;
		}

		var_07 = distancesquared(param_00.origin,var_06.origin);
		if(var_07 < var_02)
		{
			var_03 = var_01;
			var_04 = var_02;
			var_01 = var_06;
			var_02 = var_07;
			continue;
		}

		if(var_07 < var_04)
		{
			var_03 = var_06;
			var_04 = var_07;
		}
	}

	if(isdefined(var_01))
	{
		var_09 = spawnsighttrace(param_00,param_00.sighttracepoint,var_01.origin + (0,0,50));
		if(var_09 > 0)
		{
			var_09 = adjustsightvalue(var_09);
			return var_09;
		}
	}

	if(isdefined(var_03))
	{
		var_09 = spawnsighttrace(param_00,param_00.sighttracepoint,var_03.origin + (0,0,50));
		if(var_09 > 0)
		{
			var_09 = adjustsightvalue(var_09);
			return var_09;
		}
	}

	return 0;
}

//Function Number: 41
getrevengespawnpenalty()
{
	var_00 = getdvarfloat("scr_revengespawnpenalty",25000);
	return var_00;
}

//Function Number: 42
getrevengespawndistancesq()
{
	var_00 = getdvarfloat("scr_revengespawndist",1200);
	return var_00 * var_00;
}

//Function Number: 43
avoidrevengespawn(param_00,param_01)
{
	var_02 = getrevengespawndistancesq();
	var_03 = getrevengespawnpenalty();
	foreach(var_05 in param_00)
	{
		var_06 = distancesquared(var_05.origin,param_01);
		if(var_06 < var_02)
		{
			var_05.weight = var_05.weight - var_03;
		}
	}

	if(isdefined(self.lastattacker) && isdefined(self.lastattacker.origin))
	{
		avoidrevengespawnstage2(param_00,self.lastattacker.origin);
	}
}

//Function Number: 44
avoidrevengespawnstage2(param_00,param_01)
{
	var_02 = getrevengespawndistancesq();
	var_03 = getrevengespawnpenalty();
	foreach(var_05 in param_00)
	{
		var_06 = distancesquared(var_05.origin,param_01);
		if(var_06 < var_02)
		{
			var_05.weight = var_05.weight - var_03;
		}
	}
}

//Function Number: 45
avoidvisibleenemies(param_00,param_01)
{
	var_02 = getlospenalty();
	var_03 = "axis";
	if(self.team == "axis")
	{
		var_03 = "allies";
	}

	if(param_01)
	{
		foreach(var_05 in param_00)
		{
			var_06 = var_02 * var_05.sights[var_03];
			var_05.weight = var_05.weight - var_06;
		}
	}
	else
	{
		foreach(var_05 in var_02)
		{
			var_06 = var_02 * var_05.sights;
			var_05.weight = var_05.weight - var_06;
		}

		var_03 = "all";
	}

	foreach(var_05 in param_00)
	{
		var_05.weight = var_05.weight - var_05.nearbypenalty[var_03];
		if(positionwouldtelefrag(var_05.origin))
		{
			var_0B = 1;
			foreach(var_0D in var_05.alternates)
			{
				if(positionwouldtelefrag(var_0D))
				{
					var_0B++;
					continue;
				}

				break;
			}

			var_06 = 100000;
			if(var_0B < var_05.alternates.size + 1)
			{
				var_06 = 1500 * var_0B;
				if(isdefined(self.forcespawnnearteammates))
				{
					var_06 = 0;
				}
			}

			var_05.weight = var_05.weight - var_06;
		}
	}
}

//Function Number: 46
avoidspawnreuse(param_00,param_01)
{
	var_02 = gettime();
	var_03 = 10000;
	var_04 = 1048576;
	foreach(var_06 in param_00)
	{
		var_07 = var_06.lastspawnedplayer;
		if(!isalive(var_07))
		{
			continue;
		}

		if(param_01 && var_06.lastspawnedplayer.team == self.team)
		{
			continue;
		}

		if(var_06.lastspawnedplayer == self)
		{
			continue;
		}

		var_08 = var_02 - var_06.lastspawntime;
		if(var_08 < var_03)
		{
			var_09 = distancesquared(var_06.lastspawnedplayer.origin,var_06.origin);
			if(var_09 < var_04)
			{
				var_0A = 5000 * 1 - var_09 / var_04 * 1 - var_08 / var_03;
				var_06.weight = var_06.weight - var_0A;
			}
			else
			{
				var_06.lastspawnedplayer = undefined;
			}

			continue;
		}

		var_06.lastspawnedplayer = undefined;
	}
}

//Function Number: 47
avoidsamespawn()
{
	var_00 = self.lastspawnpoint;
	if(!isdefined(var_00) || !isdefined(var_00.weight))
	{
		return;
	}

	var_00.weight = var_00.weight - 1000;
}

//Function Number: 48
setupkillstreakspawnshield()
{
	level.killstreakspawnshield = 5000;
	if(getdvar("killstreakSpawnShield") != "")
	{
		var_00 = getdvarint("killstreakSpawnShield");
		if(var_00 >= 0 && var_00 <= 10000)
		{
			level.killstreakspawnshield = var_00;
		}
	}
}