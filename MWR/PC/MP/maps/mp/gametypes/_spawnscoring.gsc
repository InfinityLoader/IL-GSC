/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes\_spawnscoring.gsc
 * Game: Call of Duty: Modern Warfare Remastered
 * Platform: PC
 * Function Count: 37
 * Decompile Time: 617 ms
 * Timestamp: 10/27/2023 2:42:10 AM
*******************************************************************/

//Function Number: 1
getspawnpoint_nearteam(param_00)
{
	param_00 = checkdynamicspawns(param_00);
	var_01["primary"] = [];
	var_01["secondary"] = [];
	var_01["bad"] = [];
	foreach(var_03 in param_00)
	{
		initscoredata(var_03);
		var_03.criticalresult = criticalfactors_global(var_03);
		var_01[var_03.criticalresult][var_01[var_03.criticalresult].size] = var_03;
	}

	if(var_01["primary"].size)
	{
		var_05 = scorespawns_nearteam(var_01["primary"]);
		level.badspawncount[self.team] = 0;
	}
	else if(var_02["secondary"].size)
	{
		var_05 = scorespawns_nearteam(var_02["secondary"]);
		level.badspawncount[self.team] = 0;
	}
	else
	{
		var_05 = scorespawns_nearteam(var_02["bad"],1);
		level.badspawncount[self.team]++;
	}

	foreach(var_03 in param_00)
	{
		recon_log_spawnpoint_info(var_03);
		var_03.criticalresult = undefined;
	}

	return var_05;
}

//Function Number: 2
scorespawns_nearteam(param_00,param_01)
{
	var_02 = param_00[0];
	foreach(var_04 in param_00)
	{
		scorefactors_nearteam(var_04);
		if(var_04.totalscore > var_02.totalscore)
		{
			var_02 = var_04;
		}
	}

	var_02 = selectbestspawnpoint(var_02,param_00,param_01);
	return var_02;
}

//Function Number: 3
getspawnpoint_twar(param_00,param_01)
{
	param_00 = checkdynamicspawns(param_00);
	var_02["primary"] = [];
	var_02["secondary"] = [];
	var_02["bad"] = [];
	foreach(var_04 in param_00)
	{
		initscoredata(var_04);
		var_04.criticalresult = criticalfactors_twar(var_04);
		var_02[var_04.criticalresult][var_02[var_04.criticalresult].size] = var_04;
	}

	if(var_02["primary"].size)
	{
		var_06 = scorespawns_twar(var_02["primary"],param_01);
		level.badspawncount[self.team] = 0;
	}
	else if(var_03["secondary"].size)
	{
		var_06 = scorespawns_twar(var_03["secondary"],var_02);
		level.badspawncount[self.team] = 0;
	}
	else
	{
		var_06 = scorespawns_twar(var_03["bad"],var_02,1);
		level.badspawncount[self.team]++;
	}

	foreach(var_04 in param_00)
	{
		if(!isagent(self))
		{
			recon_log_spawnpoint_info(var_04);
		}

		var_04.criticalresult = undefined;
	}

	return var_06;
}

//Function Number: 4
criticalfactors_twar(param_00)
{
	param_00.criticalresult = criticalfactors_global(param_00);
	if(!maps\mp\gametypes\_spawnfactor::critical_factor(::maps\mp\gametypes\_spawnfactor::avoidspawninzone,param_00,level.twar_use_obj.zone))
	{
		return "bad";
	}

	return param_00.criticalresult;
}

//Function Number: 5
scorespawns_twar(param_00,param_01,param_02)
{
	var_03 = param_00[0];
	foreach(var_05 in param_00)
	{
		scorefactors_twar(var_05,param_01);
		if(var_05.totalscore > var_03.totalscore)
		{
			var_03 = var_05;
		}
	}

	var_03 = selectbestspawnpoint(var_03,param_00,param_02);
	return var_03;
}

//Function Number: 6
checkdynamicspawns(param_00)
{
	if(isdefined(level.dynamicspawns))
	{
		param_00 = [[ level.dynamicspawns ]](param_00);
	}

	return param_00;
}

//Function Number: 7
selectbestspawnpoint(param_00,param_01,param_02)
{
	var_03 = param_00;
	var_04 = 0;
	if(isdefined(param_02) && param_02 && param_01.size > 1)
	{
		param_01 = maps\mp\_utility::quicksort(param_01,::spawnpointcomparefunc);
		var_05 = int(min(level.badspawncount[self.team] / 2 + 1,param_01.size - 1));
		var_03 = param_01[randomint(var_05)];
		var_03.israndom = 1;
	}
	else
	{
		var_04 = param_01.size;
	}

	var_03.numberofpossiblespawnchoices = var_04;
	return var_03;
}

//Function Number: 8
spawnpointcomparefunc(param_00,param_01)
{
	return param_00.totalscore >= param_01.totalscore;
}

//Function Number: 9
recon_log_spawnpoint_info_wrapper(param_00)
{
	recon_log_spawnpoint_info(param_00);
}

//Function Number: 10
recon_log_spawnpoint_info(param_00)
{
	if(!isdefined(param_00.israndom))
	{
		param_00.israndom = 0;
	}

	if(!isdefined(param_00.teambase))
	{
		param_00.teambase = "none";
	}

	if(!isdefined(param_00.lastspawnteam))
	{
		param_00.lastspawnteam = "none";
	}

	if(!isdefined(param_00.lastspawntime))
	{
		param_00.lastspawntime = -1;
	}

	if(level.teambased)
	{
		var_01 = param_00.fullsights["allies"];
		var_02 = param_00.fullsights["axis"];
		var_03 = param_00.cornersights["allies"];
		var_04 = param_00.cornersights["axis"];
		var_05 = param_00.mindistsquared["allies"];
		var_06 = param_00.mindistsquared["axis"];
	}
	else
	{
		var_01 = var_06.fullsights["all"];
		var_02 = -1;
		var_03 = var_04.cornersights["all"];
		var_04 = -1;
		var_05 = var_02.mindistsquared["all"];
		var_06 = -1;
	}

	var_07 = -1;
	var_08 = -1;
	var_09 = -1;
	var_0A = -1;
	var_0B = -1;
	var_0C = -1;
	var_0D = -1;
	var_0E = -1;
	var_0F = "_spawnscoring.gsc";
	var_10 = gettime();
	var_11 = param_00.classname;
	var_12 = param_00.totalscore;
	var_13 = param_00.criticalresult;
	var_14 = param_00.teambase;
	var_15 = param_00.outside;
	if(isdefined(param_00.debugcriticaldata[0]))
	{
		var_07 = param_00.debugcriticaldata[0];
	}

	if(isdefined(param_00.debugcriticaldata[1]))
	{
		var_08 = param_00.debugcriticaldata[1];
	}

	if(isdefined(param_00.debugcriticaldata[2]))
	{
		var_09 = param_00.debugcriticaldata[2];
	}

	if(isdefined(param_00.debugcriticaldata[3]))
	{
		var_0A = param_00.debugcriticaldata[3];
	}

	if(isdefined(param_00.debugcriticaldata[4]))
	{
		var_0B = param_00.debugcriticaldata[4];
	}

	if(isdefined(param_00.debugcriticaldata[5]))
	{
		var_0C = param_00.debugcriticaldata[5];
	}

	if(isdefined(param_00.debugcriticaldata[6]))
	{
		var_0D = param_00.debugcriticaldata[6];
	}

	if(isdefined(param_00.debugcriticaldata[7]))
	{
		var_0E = param_00.debugcriticaldata[7];
	}

	var_16 = param_00.totalpossiblescore;
	var_17 = -1;
	var_18 = -1;
	var_19 = -1;
	var_1A = -1;
	var_1B = -1;
	var_1C = -1;
	var_1D = -1;
	var_1E = -1;
	if(isdefined(param_00.debugscoredata[0]))
	{
		var_17 = param_00.debugscoredata[0];
	}

	if(isdefined(param_00.debugscoredata[1]))
	{
		var_18 = param_00.debugscoredata[1];
	}

	if(isdefined(param_00.debugscoredata[2]))
	{
		var_19 = param_00.debugscoredata[2];
	}

	if(isdefined(param_00.debugscoredata[3]))
	{
		var_1A = param_00.debugscoredata[3];
	}

	if(isdefined(param_00.debugscoredata[4]))
	{
		var_1B = param_00.debugscoredata[4];
	}

	if(isdefined(param_00.debugscoredata[5]))
	{
		var_1C = param_00.debugscoredata[5];
	}

	if(isdefined(param_00.debugscoredata[6]))
	{
		var_1D = param_00.debugscoredata[6];
	}

	if(isdefined(param_00.debugscoredata[7]))
	{
		var_1E = param_00.debugscoredata[7];
	}

	reconspatialevent(param_00.origin,"@"script_mp_spawnpoint_score: player_name %s, life_id %d, script_file %s, gameTime %d, classname %s, totalscore %d, totalPossibleScore %d, score_data0 %d, score_data1 %d, score_data2 %d, score_data3 %d, score_data4 %d, score_data5 %d, score_data6 %d, score_data7 %d, fullsights_allies %d, fullsights_axis %d, cornersights_allies %d, cornersights_axis %d, min_dist_squared_allies %d, min_dist_squared_axis %d, criticalResult %s, critical_data0 %d, critical_data1 %d, critical_data2 %d, critical_data3 %d, critical_data4 %d, critical_data5 %d, critical_data6 %d, critical_data7 %d, teambase %s, outside %d",self.name,self.lifeid,var_0F,var_10,var_11,var_12,var_16,var_17,var_18,var_19,var_1A,var_1B,var_1C,var_1D,var_1E,var_01,var_02,var_03,var_04,var_05,var_06,var_13,var_07,var_08,var_09,var_0A,var_0B,var_0C,var_0D,var_0E,var_14,var_15);
}

//Function Number: 11
findsecondhighestspawnscore(param_00,param_01)
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

//Function Number: 12
initscoredata(param_00)
{
	param_00.totalscore = 0;
	param_00.numberofpossiblespawnchoices = 0;
	param_00.debugscoredata = [];
	param_00.debugcriticaldata = [];
	param_00.totalpossiblescore = 0;
}

//Function Number: 13
criticalfactors_global(param_00)
{
	if(!maps\mp\gametypes\_spawnfactor::critical_factor(::maps\mp\gametypes\_spawnfactor::avoidfullvisibleenemies,param_00))
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

	if(!maps\mp\gametypes\_spawnfactor::critical_factor(::maps\mp\gametypes\_spawnfactor::avoidtelefrag,param_00))
	{
		return "bad";
	}

	if(!maps\mp\gametypes\_spawnfactor::critical_factor(::maps\mp\gametypes\_spawnfactor::avoidenemyspawn,param_00))
	{
		return "bad";
	}

	if(!maps\mp\gametypes\_spawnfactor::critical_factor(::maps\mp\gametypes\_spawnfactor::avoidcornervisibleenemies,param_00))
	{
		return "secondary";
	}

	return "primary";
}

//Function Number: 14
scorefactors_nearteam(param_00)
{
	var_01 = maps\mp\gametypes\_spawnfactor::score_factor(1.25,::maps\mp\gametypes\_spawnfactor::preferalliesbydistance,param_00);
	param_00.totalscore = param_00.totalscore + var_01;
	var_01 = maps\mp\gametypes\_spawnfactor::score_factor(1.25,::maps\mp\gametypes\_spawnfactor::avoidrecentlyused,param_00);
	param_00.totalscore = param_00.totalscore + var_01;
	var_01 = maps\mp\gametypes\_spawnfactor::score_factor(1,::maps\mp\gametypes\_spawnfactor::avoidenemiesbydistance,param_00);
	param_00.totalscore = param_00.totalscore + var_01;
	var_01 = maps\mp\gametypes\_spawnfactor::score_factor(0.25,::maps\mp\gametypes\_spawnfactor::avoidlastdeathlocation,param_00);
	param_00.totalscore = param_00.totalscore + var_01;
	var_01 = maps\mp\gametypes\_spawnfactor::score_factor(0.25,::maps\mp\gametypes\_spawnfactor::avoidlastattackerlocation,param_00);
	param_00.totalscore = param_00.totalscore + var_01;
	var_01 = maps\mp\gametypes\_spawnfactor::score_factor(0.25,::maps\mp\gametypes\_spawnfactor::avoidsamespawn,param_00);
	param_00.totalscore = param_00.totalscore + var_01;
}

//Function Number: 15
scorefactors_twar(param_00,param_01)
{
	var_02 = maps\mp\gametypes\_spawnfactor::score_factor(1.5,::maps\mp\gametypes\_spawnfactor::avoidzone,param_00,param_01);
	param_00.totalscore = param_00.totalscore + var_02;
	var_02 = maps\mp\gametypes\_spawnfactor::score_factor(1,::maps\mp\gametypes\_spawnfactor::preferplayeranchors,param_00);
	param_00.totalscore = param_00.totalscore + var_02;
	var_02 = maps\mp\gametypes\_spawnfactor::score_factor(1,::maps\mp\gametypes\_spawnfactor::avoidenemiesbydistance,param_00);
	param_00.totalscore = param_00.totalscore + var_02;
}

//Function Number: 16
getspawnpoint_domination(param_00,param_01)
{
	param_00 = checkdynamicspawns(param_00);
	var_02["primary"] = [];
	var_02["secondary"] = [];
	var_02["bad"] = [];
	foreach(var_04 in param_00)
	{
		initscoredata(var_04);
		var_04.criticalresult = criticalfactors_global(var_04);
		var_02[var_04.criticalresult][var_02[var_04.criticalresult].size] = var_04;
	}

	if(var_02["primary"].size)
	{
		var_06 = scorespawns_domination(var_02["primary"],param_01);
		level.badspawncount[self.team] = 0;
	}
	else if(var_03["secondary"].size)
	{
		var_06 = scorespawns_domination(var_03["secondary"],var_02);
		level.badspawncount[self.team] = 0;
	}
	else
	{
		var_06 = scorespawns_domination(var_03["bad"],var_02,1);
		level.badspawncount[self.team]++;
	}

	foreach(var_04 in param_00)
	{
		recon_log_spawnpoint_info(var_04);
		var_04.criticalresult = undefined;
	}

	return var_06;
}

//Function Number: 17
scorespawns_domination(param_00,param_01,param_02)
{
	var_03 = param_00[0];
	foreach(var_05 in param_00)
	{
		scorefactors_domination(var_05,param_01);
		if(var_05.totalscore > var_03.totalscore)
		{
			var_03 = var_05;
		}
	}

	var_03 = selectbestspawnpoint(var_03,param_00,param_02);
	return var_03;
}

//Function Number: 18
scorefactors_domination(param_00,param_01)
{
	var_02 = maps\mp\gametypes\_spawnfactor::score_factor(1,::maps\mp\gametypes\_spawnfactor::preferdompoints,param_00,param_01);
	param_00.totalscore = param_00.totalscore + var_02;
	var_02 = maps\mp\gametypes\_spawnfactor::score_factor(1,::maps\mp\gametypes\_spawnfactor::preferplayeranchors,param_00);
	param_00.totalscore = param_00.totalscore + var_02;
	var_02 = maps\mp\gametypes\_spawnfactor::score_factor(0.5,::maps\mp\gametypes\_spawnfactor::avoidrecentlyused,param_00);
	param_00.totalscore = param_00.totalscore + var_02;
	var_02 = maps\mp\gametypes\_spawnfactor::score_factor(1.5,::maps\mp\gametypes\_spawnfactor::avoidenemiesbydistance,param_00);
	param_00.totalscore = param_00.totalscore + var_02;
	var_02 = maps\mp\gametypes\_spawnfactor::score_factor(0.25,::maps\mp\gametypes\_spawnfactor::avoidlastdeathlocation,param_00);
	param_00.totalscore = param_00.totalscore + var_02;
	var_02 = maps\mp\gametypes\_spawnfactor::score_factor(0.25,::maps\mp\gametypes\_spawnfactor::avoidsamespawn,param_00);
	param_00.totalscore = param_00.totalscore + var_02;
}

//Function Number: 19
getspawnpoint_freeforall(param_00)
{
	if(maps\mp\gametypes\_legacyspawnlogic::uselegacyspawning())
	{
		return maps\mp\gametypes\_legacyspawnlogic::getspawnpoint_dm(param_00);
	}

	param_00 = checkdynamicspawns(param_00);
	var_01["primary"] = [];
	var_01["secondary"] = [];
	var_01["bad"] = [];
	foreach(var_03 in param_00)
	{
		initscoredata(var_03);
		var_03.criticalresult = criticalfactors_global(var_03);
		var_01[var_03.criticalresult][var_01[var_03.criticalresult].size] = var_03;
	}

	if(var_01["primary"].size)
	{
		var_05 = scorespawns_freeforall(var_01["primary"]);
	}
	else if(var_02["secondary"].size)
	{
		var_05 = scorespawns_freeforall(var_02["secondary"]);
	}
	else
	{
		var_05 = scorespawns_freeforall(var_02["bad"],1);
	}

	foreach(var_03 in param_00)
	{
		recon_log_spawnpoint_info(var_03);
		var_03.criticalresult = undefined;
	}

	return var_05;
}

//Function Number: 20
scorespawns_freeforall(param_00,param_01)
{
	var_02 = param_00[0];
	foreach(var_04 in param_00)
	{
		scorefactors_freeforall(var_04);
		if(var_04.totalscore > var_02.totalscore)
		{
			var_02 = var_04;
		}
	}

	var_02 = selectbestspawnpoint(var_02,param_00,param_01);
	return var_02;
}

//Function Number: 21
scorefactors_freeforall(param_00)
{
	var_01 = maps\mp\gametypes\_spawnfactor::score_factor(1.5,::maps\mp\gametypes\_spawnfactor::avoidenemiesbydistance,param_00);
	param_00.totalscore = param_00.totalscore + var_01;
	var_01 = maps\mp\gametypes\_spawnfactor::score_factor(1,::maps\mp\gametypes\_spawnfactor::avoidrecentlyused,param_00);
	param_00.totalscore = param_00.totalscore + var_01;
	var_01 = maps\mp\gametypes\_spawnfactor::score_factor(0.25,::maps\mp\gametypes\_spawnfactor::avoidlastdeathlocation,param_00);
	param_00.totalscore = param_00.totalscore + var_01;
	var_01 = maps\mp\gametypes\_spawnfactor::score_factor(0.25,::maps\mp\gametypes\_spawnfactor::avoidlastattackerlocation,param_00);
	param_00.totalscore = param_00.totalscore + var_01;
	var_01 = maps\mp\gametypes\_spawnfactor::score_factor(0.25,::maps\mp\gametypes\_spawnfactor::avoidsamespawn,param_00);
	param_00.totalscore = param_00.totalscore + var_01;
}

//Function Number: 22
getspawnpoint_searchandrescue(param_00)
{
	param_00 = checkdynamicspawns(param_00);
	var_01["primary"] = [];
	var_01["secondary"] = [];
	var_01["bad"] = [];
	foreach(var_03 in param_00)
	{
		initscoredata(var_03);
		var_03.criticalresult = criticalfactors_global(var_03);
		var_01[var_03.criticalresult][var_01[var_03.criticalresult].size] = var_03;
	}

	if(var_01["primary"].size)
	{
		var_05 = scorespawns_searchandrescue(var_01["primary"]);
		level.badspawncount[self.team] = 0;
	}
	else if(var_02["secondary"].size)
	{
		var_05 = scorespawns_searchandrescue(var_02["secondary"]);
		level.badspawncount[self.team] = 0;
	}
	else
	{
		var_05 = scorespawns_searchandrescue(var_02["bad"],1);
		level.badspawncount[self.team]++;
	}

	foreach(var_03 in param_00)
	{
		recon_log_spawnpoint_info(var_03);
		var_03.criticalresult = undefined;
	}

	return var_05;
}

//Function Number: 23
scorespawns_searchandrescue(param_00,param_01)
{
	var_02 = param_00[0];
	foreach(var_04 in param_00)
	{
		scorefactors_searchandrescue(var_04);
		if(var_04.totalscore > var_02.totalscore)
		{
			var_02 = var_04;
		}
	}

	var_02 = selectbestspawnpoint(var_02,param_00,param_01);
	return var_02;
}

//Function Number: 24
scorefactors_searchandrescue(param_00)
{
	var_01 = maps\mp\gametypes\_spawnfactor::score_factor(3,::maps\mp\gametypes\_spawnfactor::avoidenemiesbydistance,param_00);
	param_00.totalscore = param_00.totalscore + var_01;
	var_01 = maps\mp\gametypes\_spawnfactor::score_factor(1,::maps\mp\gametypes\_spawnfactor::preferalliesbydistance,param_00);
	param_00.totalscore = param_00.totalscore + var_01;
	var_01 = maps\mp\gametypes\_spawnfactor::score_factor(0.5,::maps\mp\gametypes\_spawnfactor::avoidlastdeathlocation,param_00);
	param_00.totalscore = param_00.totalscore + var_01;
	var_01 = maps\mp\gametypes\_spawnfactor::score_factor(0.5,::maps\mp\gametypes\_spawnfactor::avoidlastattackerlocation,param_00);
	param_00.totalscore = param_00.totalscore + var_01;
}

//Function Number: 25
getspawnpoint_hardpoint(param_00)
{
	param_00 = checkdynamicspawns(param_00);
	var_01["primary"] = [];
	var_01["secondary"] = [];
	var_01["bad"] = [];
	var_02 = param_00[randomint(param_00.size)];
	foreach(var_04 in param_00)
	{
		initscoredata(var_04);
		var_04.criticalresult = criticalfactors_hardpoint(var_04);
		var_01[var_04.criticalresult][var_01[var_04.criticalresult].size] = var_04;
	}

	if(var_01["primary"].size)
	{
		var_02 = scorespawns_hardpoint(var_01["primary"]);
		level.badspawncount[self.team] = 0;
	}
	else if(var_01["secondary"].size)
	{
		var_02 = scorespawns_hardpoint(var_01["secondary"]);
		level.badspawncount[self.team] = 0;
	}
	else
	{
		var_02 = scorespawns_hardpoint(var_01["bad"],1);
		level.badspawncount[self.team]++;
	}

	foreach(var_04 in param_00)
	{
		recon_log_spawnpoint_info(var_04);
		var_04.criticalresult = undefined;
	}

	return var_02;
}

//Function Number: 26
criticalfactors_hardpoint(param_00)
{
	param_00.criticalresult = criticalfactors_global(param_00);
	if(!maps\mp\gametypes\_spawnfactor::critical_factor(::maps\mp\gametypes\_spawnfactor::avoidspawninzone,param_00,level.zone))
	{
		return "bad";
	}

	return param_00.criticalresult;
}

//Function Number: 27
scorespawns_hardpoint(param_00,param_01)
{
	var_02 = param_00[randomint(param_00.size)];
	foreach(var_04 in param_00)
	{
		scorefactors_hardpoint(var_04);
		if(var_04.totalscore > var_02.totalscore)
		{
			var_02 = var_04;
		}
	}

	var_02 = selectbestspawnpoint(var_02,param_00,param_01);
	return var_02;
}

//Function Number: 28
scorefactors_hardpoint(param_00)
{
	var_01 = maps\mp\gametypes\_spawnfactor::score_factor(1.5,::maps\mp\gametypes\_spawnfactor::avoidzone,param_00,level.zone);
	param_00.totalscore = param_00.totalscore + var_01;
	var_01 = maps\mp\gametypes\_spawnfactor::score_factor(1,::maps\mp\gametypes\_spawnfactor::preferplayeranchors,param_00);
	param_00.totalscore = param_00.totalscore + var_01;
	var_01 = maps\mp\gametypes\_spawnfactor::score_factor(1,::maps\mp\gametypes\_spawnfactor::avoidenemiesbydistance,param_00);
	param_00.totalscore = param_00.totalscore + var_01;
}

//Function Number: 29
getspawnpoint_ctf(param_00,param_01)
{
	param_00 = checkdynamicspawns(param_00);
	var_02["primary"] = [];
	var_02["secondary"] = [];
	var_02["bad"] = [];
	if(!isdefined(param_01))
	{
		param_01 = self.team;
	}

	foreach(var_04 in param_00)
	{
		initscoredata(var_04);
		var_04.criticalresult = criticalfactors_global(var_04);
		var_02[var_04.criticalresult][var_02[var_04.criticalresult].size] = var_04;
	}

	if(var_02["primary"].size)
	{
		var_06 = scorespawns_ctf(var_02["primary"],param_01);
		level.badspawncount[param_01] = 0;
	}
	else if(var_03["secondary"].size)
	{
		var_06 = scorespawns_ctf(var_03["secondary"],var_02);
		level.badspawncount[param_01] = 0;
	}
	else
	{
		var_06 = scorespawns_ctf(var_03["bad"],var_02,1);
		level.badspawncount[param_01]++;
	}

	foreach(var_04 in param_00)
	{
		recon_log_spawnpoint_info(var_04);
		var_04.criticalresult = undefined;
	}

	return var_06;
}

//Function Number: 30
scorespawns_ctf(param_00,param_01,param_02)
{
	var_03 = param_00[0];
	foreach(var_05 in param_00)
	{
		scorefactors_ctf(var_05,param_01);
		if(var_05.totalscore > var_03.totalscore)
		{
			var_03 = var_05;
		}
	}

	var_03 = selectbestspawnpoint(var_03,param_00,param_02);
	return var_03;
}

//Function Number: 31
scorefactors_ctf(param_00,param_01)
{
	var_02 = maps\mp\gametypes\_spawnfactor::score_factor(1,::maps\mp\gametypes\_spawnfactor::avoidenemiesbydistance,param_00);
	param_00.totalscore = param_00.totalscore + var_02;
	var_02 = maps\mp\gametypes\_spawnfactor::score_factor(0.25,::maps\mp\gametypes\_spawnfactor::avoidsamespawn,param_00);
	param_00.totalscore = param_00.totalscore + var_02;
	var_02 = maps\mp\gametypes\_spawnfactor::score_factor(0.75,::maps\mp\gametypes\_spawnfactor::avoidflagbydistance,param_00);
	param_00.totalscore = param_00.totalscore + var_02;
}

//Function Number: 32
getspawnpoint_awayfromenemies(param_00,param_01)
{
	if(maps\mp\gametypes\_legacyspawnlogic::uselegacyspawning())
	{
		return maps\mp\gametypes\_legacyspawnlogic::getspawnpoint_nearteam(param_00);
	}

	param_00 = checkdynamicspawns(param_00);
	var_02["primary"] = [];
	var_02["secondary"] = [];
	var_02["bad"] = [];
	if(!isdefined(param_01))
	{
		param_01 = self.team;
	}

	foreach(var_04 in param_00)
	{
		initscoredata(var_04);
		var_04.criticalresult = criticalfactors_global(var_04);
		var_02[var_04.criticalresult][var_02[var_04.criticalresult].size] = var_04;
	}

	if(var_02["primary"].size)
	{
		var_06 = scorespawns_awayfromenemies(var_02["primary"],param_01);
		level.badspawncount[param_01] = 0;
	}
	else if(var_03["secondary"].size)
	{
		var_06 = scorespawns_awayfromenemies(var_03["secondary"],var_02);
		level.badspawncount[param_01] = 0;
	}
	else
	{
		var_06 = scorespawns_awayfromenemies(var_03["bad"],var_02,1);
		level.badspawncount[param_01]++;
	}

	foreach(var_04 in param_00)
	{
		recon_log_spawnpoint_info(var_04);
		var_04.criticalresult = undefined;
	}

	return var_06;
}

//Function Number: 33
scorespawns_awayfromenemies(param_00,param_01,param_02)
{
	var_03 = param_00[0];
	foreach(var_05 in param_00)
	{
		scorefactors_awayfromenemies(var_05,param_01);
		if(var_05.totalscore > var_03.totalscore)
		{
			var_03 = var_05;
		}
	}

	var_03 = selectbestspawnpoint(var_03,param_00,param_02);
	return var_03;
}

//Function Number: 34
scorefactors_awayfromenemies(param_00,param_01)
{
	var_02 = maps\mp\gametypes\_spawnfactor::score_factor(1,::maps\mp\gametypes\_spawnfactor::avoidenemiesbydistance,param_00);
	param_00.totalscore = param_00.totalscore + var_02;
	var_02 = maps\mp\gametypes\_spawnfactor::score_factor(0.25,::maps\mp\gametypes\_spawnfactor::avoidsamespawn,param_00);
	param_00.totalscore = param_00.totalscore + var_02;
}

//Function Number: 35
getspawnpoint_safeguard(param_00)
{
	param_00 = checkdynamicspawns(param_00);
	var_01["primary"] = [];
	var_01["secondary"] = [];
	var_01["bad"] = [];
	foreach(var_03 in param_00)
	{
		initscoredata(var_03);
		var_03.criticalresult = criticalfactors_global(var_03);
		var_01[var_03.criticalresult][var_01[var_03.criticalresult].size] = var_03;
	}

	if(var_01["primary"].size)
	{
		var_05 = scorespawns_safeguard(var_01["primary"]);
		level.badspawncount[self.team] = 0;
	}
	else if(var_02["secondary"].size)
	{
		var_05 = scorespawns_safeguard(var_02["secondary"]);
		level.badspawncount[self.team] = 0;
	}
	else
	{
		var_05 = scorespawns_safeguard(var_02["bad"],1);
		level.badspawncount[self.team]++;
	}

	foreach(var_03 in param_00)
	{
		var_03.criticalresult = undefined;
	}

	return var_05;
}

//Function Number: 36
scorespawns_safeguard(param_00,param_01)
{
	var_02 = param_00[0];
	foreach(var_04 in param_00)
	{
		scorefactors_safeguard(var_04);
		if(var_04.totalscore > var_02.totalscore)
		{
			var_02 = var_04;
		}
	}

	var_02 = selectbestspawnpoint(var_02,param_00,param_01);
	return var_02;
}

//Function Number: 37
scorefactors_safeguard(param_00)
{
	var_01 = maps\mp\gametypes\_spawnfactor::score_factor(1,::maps\mp\gametypes\_spawnfactor::randomspawnscore,param_00);
	param_00.totalscore = param_00.totalscore + var_01;
	var_01 = maps\mp\gametypes\_spawnfactor::score_factor(1,::maps\mp\gametypes\_spawnfactor::preferalliesbydistance,param_00);
	param_00.totalscore = param_00.totalscore + var_01;
	var_01 = maps\mp\gametypes\_spawnfactor::score_factor(0.5,::maps\mp\gametypes\_spawnfactor::avoidenemiesbydistance,param_00);
	param_00.totalscore = param_00.totalscore + var_01;
}