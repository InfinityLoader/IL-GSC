/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: mp\gametypes\_spawnscoring.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 46
 * Decompile Time: 671 ms
 * Timestamp: 4/22/2024 2:10:23 AM
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
	}
	else if(var_02["secondary"].size)
	{
		var_05 = scorespawns_nearteam(var_02["secondary"]);
	}
	else
	{
		var_05 = scorespawns_nearteam(var_01);
	}

	foreach(var_03 in param_00)
	{
		recon_log_spawnpoint_info(var_03);
		var_03.criticalresult = undefined;
	}

	return var_05;
}

//Function Number: 2
scorespawns_nearteam(param_00)
{
	var_01 = param_00[0];
	foreach(var_03 in param_00)
	{
		scorefactors_nearteam(var_03);
		if(var_03.totalscore > var_01.totalscore)
		{
			var_01 = var_03;
		}
	}

	var_01 = selectbestspawnpoint(var_01,param_00);
	return var_01;
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
		var_04.criticalresult = criticalfactors_global(var_04);
		var_02[var_04.criticalresult][var_02[var_04.criticalresult].size] = var_04;
	}

	if(var_02["primary"].size)
	{
		var_06 = scorespawns_twar(var_02["primary"],param_01);
	}
	else if(var_03["secondary"].size)
	{
		var_06 = scorespawns_twar(var_03["secondary"],var_02);
	}
	else
	{
		var_06 = scorespawns_twar(param_01,var_02);
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
scorespawns_twar(param_00,param_01)
{
	var_02 = param_00[0];
	foreach(var_04 in param_00)
	{
		scorefactors_twar(var_04,param_01);
		if(var_04.totalscore > var_02.totalscore)
		{
			var_02 = var_04;
		}
	}

	var_02 = selectbestspawnpoint(var_02,param_00);
	return var_02;
}

//Function Number: 5
checkdynamicspawns(param_00)
{
	if(isdefined(level.dynamicspawns))
	{
		param_00 = [[ level.dynamicspawns ]](param_00);
	}

	return param_00;
}

//Function Number: 6
selectbestspawnpoint(param_00,param_01)
{
	var_02 = param_00;
	var_03 = 0;
	var_04 = [];
	foreach(var_06 in param_01)
	{
		if(var_06.totalscore == var_02.totalscore)
		{
			var_04[var_04.size] = var_06;
		}
	}

	var_02 = var_04[randomint(var_04.size)];
	foreach(var_06 in param_01)
	{
		if(var_06.totalscore > 0)
		{
			var_03++;
		}
	}

	if(var_03 == 0)
	{
		if(var_02.totalscore == 0)
		{
			var_02 = param_01[randomint(param_01.size)];
			var_02.israndom = 1;
		}
	}

	var_02.numberofpossiblespawnchoices = var_03;
	return var_02;
}

//Function Number: 7
recon_log_spawnpoint_info_wrapper(param_00)
{
	recon_log_spawnpoint_info(param_00);
}

//Function Number: 8
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

//Function Number: 9
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

//Function Number: 10
findbuddyspawn()
{
	var_00 = spawnstruct();
	initscoredata(var_00);
	var_01 = getteammatesoutofcombat(self.team);
	var_02 = spawnstruct();
	var_02.maxtracecount = 18;
	var_02.currenttracecount = 0;
	foreach(var_04 in var_01)
	{
		var_05 = findspawnlocationnearplayer(var_04);
		if(!isdefined(var_05))
		{
			continue;
		}

		if(issafetospawnon(var_04,var_05,var_02))
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

//Function Number: 11
getbuddyspawnangles(param_00,param_01)
{
	var_02 = (0,param_00.angles[1],0);
	var_03 = findentrances(param_01);
	if(isdefined(var_03) && var_03.size > 0)
	{
		var_02 = vectortoangles(var_03[0].origin - param_01);
	}

	return var_02;
}

//Function Number: 12
getteammatesoutofcombat(param_00)
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

		if(!maps\mp\_utility::isreallyalive(var_03))
		{
			continue;
		}

		if(var_03 == self)
		{
			continue;
		}

		if(isplayerincombat(var_03))
		{
			continue;
		}

		var_01[var_01.size] = var_03;
	}

	return common_scripts\utility::array_randomize(var_01);
}

//Function Number: 13
isplayerincombat(param_00)
{
	if(param_00 issighted())
	{
		return 1;
	}

	if(!param_00 isonground())
	{
		return 1;
	}

	if(param_00 isonladder())
	{
		return 1;
	}

	if(param_00 common_scripts\utility::isflashed())
	{
		return 1;
	}

	var_01 = 3000;
	if(param_00.health < param_00.maxhealth && isdefined(param_00.lastdamagedtime) && gettime() < param_00.lastdamagedtime + var_01)
	{
		return 1;
	}

	if(!maps\mp\gametypes\_spawnfactor::avoidgrenades(param_00))
	{
		return 1;
	}

	if(!maps\mp\gametypes\_spawnfactor::avoidmines(param_00))
	{
		return 1;
	}

	return 0;
}

//Function Number: 14
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

//Function Number: 15
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

//Function Number: 16
issafetospawnon(param_00,param_01,param_02)
{
	if(param_00 issighted())
	{
		return 0;
	}

	foreach(var_04 in level.players)
	{
		if(param_02.currenttracecount == param_02.maxtracecount)
		{
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

		if(!maps\mp\_utility::isreallyalive(var_04))
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
		var_07 = spawnsighttrace(param_02,param_01 + (0,0,var_05),var_06,0);
		if(var_07 > 0)
		{
			return 0;
		}
	}

	return 1;
}

//Function Number: 17
initscoredata(param_00)
{
	param_00.totalscore = 0;
	param_00.numberofpossiblespawnchoices = 0;
	param_00.buddyspawn = 0;
	param_00.debugscoredata = [];
	param_00.debugcriticaldata = [];
	param_00.totalpossiblescore = 0;
}

//Function Number: 18
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

	if(!maps\mp\gametypes\_spawnfactor::critical_factor(::maps\mp\gametypes\_spawnfactor::avoidgasclouds,param_00))
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

	if(level.gametype == "hp")
	{
		if(!maps\mp\gametypes\_spawnfactor::critical_factor(::maps\mp\gametypes\_spawnfactor::avoidspawninzone,param_00,level.zone))
		{
			return "bad";
		}
	}

	if(level.gametype == "twar")
	{
		if(!maps\mp\gametypes\_spawnfactor::critical_factor(::maps\mp\gametypes\_spawnfactor::avoidspawninzone,param_00,level.twar_use_obj.zone))
		{
			return "bad";
		}
	}

	if(!maps\mp\gametypes\_spawnfactor::critical_factor(::maps\mp\gametypes\_spawnfactor::avoidcornervisibleenemies,param_00))
	{
		return "secondary";
	}

	return "primary";
}

//Function Number: 19
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

//Function Number: 20
scorefactors_twar(param_00,param_01)
{
	var_02 = maps\mp\gametypes\_spawnfactor::score_factor(1.5,::maps\mp\gametypes\_spawnfactor::avoidzone,param_00,param_01);
	param_00.totalscore = param_00.totalscore + var_02;
	var_02 = maps\mp\gametypes\_spawnfactor::score_factor(1,::maps\mp\gametypes\_spawnfactor::preferplayeranchors,param_00);
	param_00.totalscore = param_00.totalscore + var_02;
	var_02 = maps\mp\gametypes\_spawnfactor::score_factor(1,::maps\mp\gametypes\_spawnfactor::avoidenemiesbydistance,param_00);
	param_00.totalscore = param_00.totalscore + var_02;
	var_02 = maps\mp\gametypes\_spawnfactor::score_factor(-100,::maps\mp\gametypes\_spawnfactor::avoidbadspawns,param_00);
	param_00.totalscore = param_00.totalscore + var_02;
}

//Function Number: 21
getspawnpoint_domination(param_00,param_01)
{
	param_00 = checkdynamicspawns(param_00);
	var_02["primary"] = [];
	var_02["secondary"] = [];
	var_02["bad"] = [];
	foreach(var_04 in param_00)
	{
		initscoredata(var_04);
		var_04.criticalresult = criticalfactors_domination(var_04);
		var_02[var_04.criticalresult][var_02[var_04.criticalresult].size] = var_04;
	}

	if(var_02["primary"].size)
	{
		var_06 = scorespawns_domination(var_02["primary"],param_01);
	}
	else if(var_03["secondary"].size)
	{
		var_06 = scorespawns_domination(var_03["secondary"],var_02);
	}
	else
	{
		var_06 = scorespawns_domination(param_01,var_02);
	}

	foreach(var_04 in param_00)
	{
		recon_log_spawnpoint_info(var_04);
		var_04.criticalresult = undefined;
	}

	return var_06;
}

//Function Number: 22
scorespawns_domination(param_00,param_01)
{
	var_02 = param_00[0];
	foreach(var_04 in param_00)
	{
		scorefactors_domination(var_04,param_01);
		if(var_04.totalscore > var_02.totalscore)
		{
			var_02 = var_04;
		}
	}

	var_02 = selectbestspawnpoint(var_02,param_00);
	return var_02;
}

//Function Number: 23
criticalfactors_domination(param_00)
{
	return criticalfactors_global(param_00);
}

//Function Number: 24
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

//Function Number: 25
getspawnpoint_freeforall(param_00)
{
	param_00 = checkdynamicspawns(param_00);
	var_01["primary"] = [];
	var_01["secondary"] = [];
	var_01["bad"] = [];
	foreach(var_03 in param_00)
	{
		initscoredata(var_03);
		var_03.criticalresult = criticalfactors_freeforall(var_03);
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
		var_05 = scorespawns_freeforall(var_01);
	}

	foreach(var_03 in param_00)
	{
		recon_log_spawnpoint_info(var_03);
		var_03.criticalresult = undefined;
	}

	return var_05;
}

//Function Number: 26
scorespawns_freeforall(param_00)
{
	var_01 = param_00[0];
	foreach(var_03 in param_00)
	{
		scorefactors_freeforall(var_03);
		if(var_03.totalscore > var_01.totalscore)
		{
			var_01 = var_03;
		}
	}

	var_01 = selectbestspawnpoint(var_01,param_00);
	return var_01;
}

//Function Number: 27
criticalfactors_freeforall(param_00)
{
	return criticalfactors_global(param_00);
}

//Function Number: 28
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

//Function Number: 29
getspawnpoint_searchandrescue(param_00)
{
	param_00 = checkdynamicspawns(param_00);
	var_01["primary"] = [];
	var_01["secondary"] = [];
	var_01["bad"] = [];
	foreach(var_03 in param_00)
	{
		initscoredata(var_03);
		var_03.criticalresult = criticalfactors_searchandrescue(var_03);
		var_01[var_03.criticalresult][var_01[var_03.criticalresult].size] = var_03;
	}

	if(var_01["primary"].size)
	{
		var_05 = scorespawns_searchandrescue(var_01["primary"]);
	}
	else if(var_02["secondary"].size)
	{
		var_05 = scorespawns_searchandrescue(var_02["secondary"]);
	}
	else
	{
		var_05 = scorespawns_searchandrescue(var_01);
	}

	foreach(var_03 in param_00)
	{
		recon_log_spawnpoint_info(var_03);
		var_03.criticalresult = undefined;
	}

	return var_05;
}

//Function Number: 30
scorespawns_searchandrescue(param_00)
{
	var_01 = param_00[0];
	foreach(var_03 in param_00)
	{
		scorefactors_searchandrescue(var_03);
		if(var_03.totalscore > var_01.totalscore)
		{
			var_01 = var_03;
		}
	}

	var_01 = selectbestspawnpoint(var_01,param_00);
	return var_01;
}

//Function Number: 31
criticalfactors_searchandrescue(param_00)
{
	return criticalfactors_global(param_00);
}

//Function Number: 32
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

//Function Number: 33
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
		var_04.criticalresult = criticalfactors_global(var_04);
		if(var_04.criticalresult == "bad")
		{
			continue;
		}

		var_01[var_04.criticalresult][var_01[var_04.criticalresult].size] = var_04;
	}

	if(var_01["primary"].size)
	{
		var_02 = scorespawns_hardpoint(var_01["primary"]);
	}
	else if(var_01["secondary"].size)
	{
		var_02 = scorespawns_hardpoint(var_01["secondary"]);
	}
	else
	{
		var_02 = scorespawns_hardpoint(param_00);
	}

	foreach(var_04 in param_00)
	{
		recon_log_spawnpoint_info(var_04);
		var_04.criticalresult = undefined;
	}

	return var_02;
}

//Function Number: 34
scorespawns_hardpoint(param_00)
{
	var_01 = param_00[randomint(param_00.size)];
	foreach(var_03 in param_00)
	{
		scorefactors_hardpoint(var_03);
		if(var_03.totalscore > var_01.totalscore)
		{
			var_01 = var_03;
		}
	}

	var_01 = selectbestspawnpoint(var_01,param_00);
	return var_01;
}

//Function Number: 35
scorefactors_hardpoint(param_00)
{
	var_01 = maps\mp\gametypes\_spawnfactor::score_factor(1.5,::maps\mp\gametypes\_spawnfactor::avoidzone,param_00,level.zone);
	param_00.totalscore = param_00.totalscore + var_01;
	var_01 = maps\mp\gametypes\_spawnfactor::score_factor(1,::maps\mp\gametypes\_spawnfactor::preferplayeranchors,param_00);
	param_00.totalscore = param_00.totalscore + var_01;
	var_01 = maps\mp\gametypes\_spawnfactor::score_factor(1,::maps\mp\gametypes\_spawnfactor::avoidenemiesbydistance,param_00);
	param_00.totalscore = param_00.totalscore + var_01;
}

//Function Number: 36
getspawnpoint_ctf(param_00,param_01)
{
	param_00 = checkdynamicspawns(param_00);
	var_02["primary"] = [];
	var_02["secondary"] = [];
	var_02["bad"] = [];
	foreach(var_04 in param_00)
	{
		initscoredata(var_04);
		var_04.criticalresult = criticalfactors_awayfromenemies(var_04);
		var_02[var_04.criticalresult][var_02[var_04.criticalresult].size] = var_04;
	}

	if(var_02["primary"].size)
	{
		var_06 = scorespawns_ctf(var_02["primary"],param_01);
	}
	else if(var_03["secondary"].size)
	{
		var_06 = scorespawns_ctf(var_03["secondary"],var_02);
	}
	else
	{
		var_06 = scorespawns_ctf(param_01,var_02);
	}

	foreach(var_04 in param_00)
	{
		recon_log_spawnpoint_info(var_04);
		var_04.criticalresult = undefined;
	}

	return var_06;
}

//Function Number: 37
scorespawns_ctf(param_00,param_01)
{
	var_02 = param_00[0];
	foreach(var_04 in param_00)
	{
		scorefactors_ctf(var_04,param_01);
		if(var_04.totalscore > var_02.totalscore)
		{
			var_02 = var_04;
		}
	}

	var_02 = selectbestspawnpoint(var_02,param_00);
	return var_02;
}

//Function Number: 38
scorefactors_ctf(param_00,param_01)
{
	var_02 = maps\mp\gametypes\_spawnfactor::score_factor(1,::maps\mp\gametypes\_spawnfactor::avoidenemiesbydistance,param_00);
	param_00.totalscore = param_00.totalscore + var_02;
	var_02 = maps\mp\gametypes\_spawnfactor::score_factor(0.25,::maps\mp\gametypes\_spawnfactor::avoidsamespawn,param_00);
	param_00.totalscore = param_00.totalscore + var_02;
	var_02 = maps\mp\gametypes\_spawnfactor::score_factor(0.75,::maps\mp\gametypes\_spawnfactor::avoidflagbydistance,param_00);
	param_00.totalscore = param_00.totalscore + var_02;
}

//Function Number: 39
getspawnpoint_awayfromenemies(param_00,param_01)
{
	param_00 = checkdynamicspawns(param_00);
	var_02["primary"] = [];
	var_02["secondary"] = [];
	var_02["bad"] = [];
	foreach(var_04 in param_00)
	{
		initscoredata(var_04);
		var_04.criticalresult = criticalfactors_awayfromenemies(var_04);
		var_02[var_04.criticalresult][var_02[var_04.criticalresult].size] = var_04;
	}

	if(var_02["primary"].size)
	{
		var_06 = scorespawns_awayfromenemies(var_02["primary"],param_01);
	}
	else if(var_03["secondary"].size)
	{
		var_06 = scorespawns_awayfromenemies(var_03["secondary"],var_02);
	}
	else
	{
		var_06 = scorespawns_awayfromenemies(param_01,var_02);
	}

	foreach(var_04 in param_00)
	{
		recon_log_spawnpoint_info(var_04);
		var_04.criticalresult = undefined;
	}

	return var_06;
}

//Function Number: 40
scorespawns_awayfromenemies(param_00,param_01)
{
	var_02 = param_00[0];
	foreach(var_04 in param_00)
	{
		scorefactors_awayfromenemies(var_04,param_01);
		if(var_04.totalscore > var_02.totalscore)
		{
			var_02 = var_04;
		}
	}

	var_02 = selectbestspawnpoint(var_02,param_00);
	return var_02;
}

//Function Number: 41
criticalfactors_awayfromenemies(param_00)
{
	return criticalfactors_global(param_00);
}

//Function Number: 42
scorefactors_awayfromenemies(param_00,param_01)
{
	var_02 = maps\mp\gametypes\_spawnfactor::score_factor(1,::maps\mp\gametypes\_spawnfactor::avoidenemiesbydistance,param_00);
	param_00.totalscore = param_00.totalscore + var_02;
	var_02 = maps\mp\gametypes\_spawnfactor::score_factor(0.25,::maps\mp\gametypes\_spawnfactor::avoidsamespawn,param_00);
	param_00.totalscore = param_00.totalscore + var_02;
}

//Function Number: 43
getspawnpoint_safeguard(param_00)
{
	param_00 = checkdynamicspawns(param_00);
	var_01["primary"] = [];
	var_01["secondary"] = [];
	var_01["bad"] = [];
	foreach(var_03 in param_00)
	{
		initscoredata(var_03);
		var_03.criticalresult = criticalfactors_safeguard(var_03);
		var_01[var_03.criticalresult][var_01[var_03.criticalresult].size] = var_03;
	}

	if(var_01["primary"].size)
	{
		var_05 = scorespawns_safeguard(var_01["primary"]);
	}
	else if(var_02["secondary"].size)
	{
		var_05 = scorespawns_safeguard(var_02["secondary"]);
	}
	else
	{
		var_05 = scorespawns_safeguard(var_01);
	}

	foreach(var_03 in param_00)
	{
		var_03.criticalresult = undefined;
	}

	return var_05;
}

//Function Number: 44
scorespawns_safeguard(param_00)
{
	var_01 = param_00[0];
	foreach(var_03 in param_00)
	{
		scorefactors_safeguard(var_03);
		if(var_03.totalscore > var_01.totalscore)
		{
			var_01 = var_03;
		}
	}

	var_01 = selectbestspawnpoint(var_01,param_00);
	return var_01;
}

//Function Number: 45
criticalfactors_safeguard(param_00)
{
	return criticalfactors_global(param_00);
}

//Function Number: 46
scorefactors_safeguard(param_00)
{
	var_01 = maps\mp\gametypes\_spawnfactor::score_factor(1,::maps\mp\gametypes\_spawnfactor::randomspawnscore,param_00);
	param_00.totalscore = param_00.totalscore + var_01;
	var_01 = maps\mp\gametypes\_spawnfactor::score_factor(1,::maps\mp\gametypes\_spawnfactor::preferalliesbydistance,param_00);
	param_00.totalscore = param_00.totalscore + var_01;
	var_01 = maps\mp\gametypes\_spawnfactor::score_factor(0.5,::maps\mp\gametypes\_spawnfactor::avoidenemiesbydistance,param_00);
	param_00.totalscore = param_00.totalscore + var_01;
}