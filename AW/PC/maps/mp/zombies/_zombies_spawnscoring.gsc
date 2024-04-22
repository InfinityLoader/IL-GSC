/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: mp\zombies\_zombies_spawnscoring.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 18
 * Decompile Time: 314 ms
 * Timestamp: 4/22/2024 2:14:45 AM
*******************************************************************/

//Function Number: 1
zombiecriticalfactors_global(param_00)
{
	if(!maps\mp\gametypes\_spawnfactor::critical_factor(::maps\mp\gametypes\_spawnfactor::avoidgrenades,param_00))
	{
		return "secondary";
	}

	if(!maps\mp\gametypes\_spawnfactor::critical_factor(::maps\mp\gametypes\_spawnfactor::avoidgasclouds,param_00))
	{
		return "secondary";
	}

	if(!maps\mp\gametypes\_spawnfactor::critical_factor(::maps\mp\gametypes\_spawnfactor::avoidmines,param_00))
	{
		return "secondary";
	}

	if(!maps\mp\gametypes\_spawnfactor::critical_factor(::maps\mp\gametypes\_spawnfactor::avoidairstrikelocations,param_00))
	{
		return "secondary";
	}

	if(!maps\mp\gametypes\_spawnfactor::critical_factor(::maps\mp\gametypes\_spawnfactor::avoidcarepackages,param_00))
	{
		return "secondary";
	}

	if(!maps\mp\gametypes\_spawnfactor::critical_factor(::maps\mp\gametypes\_spawnfactor::avoidtelefrag,param_00))
	{
		return "secondary";
	}

	if(!maps\mp\gametypes\_spawnfactor::critical_factor(::maps\mp\gametypes\_spawnfactor::avoidenemyspawn,param_00))
	{
		return "secondary";
	}

	return "primary";
}

//Function Number: 2
getzombiesspawnpoint_neartombstone(param_00)
{
	param_00 = maps\mp\gametypes\_spawnscoring::checkdynamicspawns(param_00);
	var_01["primary"] = [];
	var_01["secondary"] = [];
	var_01["bad"] = [];
	var_02 = [];
	foreach(var_04 in param_00)
	{
		maps\mp\gametypes\_spawnscoring::initscoredata(var_04);
		if(!isinvalidzone(var_04))
		{
			continue;
		}

		var_04.criticalresult = zombiecriticalfactors_global(var_04);
		var_01[var_04.criticalresult][var_01[var_04.criticalresult].size] = var_04;
		var_02[var_02.size] = var_04;
	}

	if(var_01["primary"].size)
	{
		var_06 = scorespawns_neartombstone(var_01["primary"]);
	}
	else if(var_02["secondary"].size)
	{
		var_06 = scorespawns_neartombstone(var_02["secondary"]);
	}
	else if(var_03.size)
	{
		var_06 = maps\mp\gametypes\_spawnscoring::selectbestspawnpoint(var_03[0],var_03);
	}
	else
	{
		var_06 = maps\mp\gametypes\_spawnscoring::selectbestspawnpoint(var_01[0],var_01);
	}

	foreach(var_04 in param_00)
	{
		maps\mp\gametypes\_spawnscoring::recon_log_spawnpoint_info_wrapper(var_04);
		var_04.criticalresult = undefined;
	}

	return var_06;
}

//Function Number: 3
scorespawns_neartombstone(param_00)
{
	var_01 = undefined;
	foreach(var_03 in param_00)
	{
		scorefactors_neartombstone(var_03);
		if(!isdefined(var_01) || var_03.totalscore > var_01.totalscore)
		{
			var_01 = var_03;
		}
	}

	if(isdefined(var_01))
	{
		var_01 = maps\mp\gametypes\_spawnscoring::selectbestspawnpoint(var_01,param_00);
	}
	else
	{
		var_01 = maps\mp\gametypes\_spawnscoring::scorespawns_nearteam(param_00);
	}

	return var_01;
}

//Function Number: 4
scorefactors_neartombstone(param_00)
{
	var_01 = maps\mp\gametypes\_spawnfactor::score_factor(2,::prefertombstonebydistance,param_00);
	param_00.totalscore = param_00.totalscore + var_01;
	var_01 = maps\mp\gametypes\_spawnfactor::score_factor(0.5,::maps\mp\gametypes\_spawnfactor::preferalliesbydistance,param_00);
	param_00.totalscore = param_00.totalscore + var_01;
	var_01 = maps\mp\gametypes\_spawnfactor::score_factor(1.25,::maps\mp\gametypes\_spawnfactor::avoidrecentlyused,param_00);
	param_00.totalscore = param_00.totalscore + var_01;
	var_01 = maps\mp\gametypes\_spawnfactor::score_factor(0.25,::maps\mp\gametypes\_spawnfactor::avoidsamespawn,param_00);
	param_00.totalscore = param_00.totalscore + var_01;
	if(isdefined(level.usezoneconnectiontombstonescoring) && level.usezoneconnectiontombstonescoring)
	{
		var_01 = maps\mp\gametypes\_spawnfactor::score_factor(2,::prefershortzoneconnection,param_00);
		param_00.totalscore = param_00.totalscore + var_01;
		return;
	}

	if(isdefined(level.zone_is_contaminated_func))
	{
		var_01 = maps\mp\gametypes\_spawnfactor::score_factor(2,::prefershortzoneconnectionnoninfected,param_00);
		param_00.totalscore = param_00.totalscore + var_01;
	}
}

//Function Number: 5
isinvalidzone(param_00)
{
	if(!isdefined(param_00.script_noteworthy))
	{
		return 1;
	}

	if(!maps\mp\zombies\_zombies_zone_manager::iszoneenabled(param_00.script_noteworthy))
	{
		return 0;
	}

	if(isdefined(level.zone_is_contaminated_func) && [[ level.zone_is_contaminated_func ]](param_00.script_noteworthy))
	{
		return 0;
	}

	return 1;
}

//Function Number: 6
prefershortzoneconnection(param_00)
{
	if(!isdefined(self.lastdeathpos))
	{
		return 100;
	}

	var_01 = maps\mp\zombies\_zombies_zone_manager::getlocationzone(self.lastdeathpos);
	if(!isdefined(var_01))
	{
		var_01 = maps\mp\zombies\_zombies_zone_manager::getlocationzone(self.lastdeathpos + (randomfloatrange(-1,1),randomfloatrange(-1,1),0));
	}

	if(!isdefined(var_01))
	{
		return 100;
	}

	var_02 = maps\mp\zombies\_zombies_zone_manager::getzoneconnectionlength(var_01,param_00.script_noteworthy);
	if(var_02 < 0)
	{
		return 0;
	}

	if(var_02 == 0)
	{
		return 100;
	}

	return 100 / var_02;
}

//Function Number: 7
prefershortzoneconnectionnoninfected(param_00)
{
	if(!isdefined(self.lastdeathpos))
	{
		return 100;
	}

	var_01 = maps\mp\zombies\_zombies_zone_manager::getlocationzone(self.lastdeathpos);
	if(!isdefined(var_01))
	{
		var_01 = maps\mp\zombies\_zombies_zone_manager::getlocationzone(self.lastdeathpos + (randomfloatrange(-1,1),randomfloatrange(-1,1),0));
	}

	if(!isdefined(var_01))
	{
		return 100;
	}

	var_02 = maps\mp\zombies\_zombies_zone_manager::getzoneinfectedconnectionlength(var_01,param_00.script_noteworthy);
	if(var_02 < 0)
	{
		return 0;
	}

	if(var_02 == 0)
	{
		return 100;
	}

	return 100 / var_02;
}

//Function Number: 8
prefertombstonebydistance(param_00)
{
	if(!isdefined(self.lastdeathpos))
	{
		return 100;
	}

	var_01 = distance(param_00.origin,self.lastdeathpos);
	if(var_01 >= 2500 || var_01 <= 500)
	{
		return 0;
	}

	var_02 = max(0,1 - abs(1500 - var_01) / 1000);
	return var_02 * 100;
}

//Function Number: 9
getzombiesspawnpoint_nearteam(param_00)
{
	param_00 = maps\mp\gametypes\_spawnscoring::checkdynamicspawns(param_00);
	var_01["primary"] = [];
	var_01["secondary"] = [];
	var_01["bad"] = [];
	var_02 = [];
	foreach(var_04 in param_00)
	{
		maps\mp\gametypes\_spawnscoring::initscoredata(var_04);
		if(!isinvalidzone(var_04))
		{
			continue;
		}

		var_04.criticalresult = zombiecriticalfactors_global(var_04);
		var_01[var_04.criticalresult][var_01[var_04.criticalresult].size] = var_04;
		var_02[var_02.size] = var_04;
	}

	if(var_01["primary"].size)
	{
		var_06 = scorezombiespawns_nearteam(var_01["primary"]);
	}
	else if(var_02["secondary"].size)
	{
		var_06 = scorezombiespawns_nearteam(var_02["secondary"]);
	}
	else if(var_03.size)
	{
		var_06 = maps\mp\gametypes\_spawnscoring::selectbestspawnpoint(var_03[0],var_03);
	}
	else
	{
		var_06 = maps\mp\gametypes\_spawnscoring::selectbestspawnpoint(var_01[0],var_01);
	}

	foreach(var_04 in param_00)
	{
		maps\mp\gametypes\_spawnscoring::recon_log_spawnpoint_info_wrapper(var_04);
		var_04.criticalresult = undefined;
	}

	return var_06;
}

//Function Number: 10
scorezombiespawns_nearteam(param_00)
{
	var_01 = undefined;
	foreach(var_03 in param_00)
	{
		maps\mp\gametypes\_spawnscoring::scorefactors_nearteam(var_03);
		if(!isdefined(var_01) || var_03.totalscore > var_01.totalscore)
		{
			var_01 = var_03;
		}
	}

	if(isdefined(var_01))
	{
		var_01 = maps\mp\gametypes\_spawnscoring::selectbestspawnpoint(var_01,param_00);
	}
	else
	{
		var_01 = maps\mp\gametypes\_spawnscoring::scorespawns_nearteam(param_00);
	}

	return var_01;
}

//Function Number: 11
getzombiesspawnpoint_aizombies(param_00,param_01,param_02)
{
	var_03 = [];
	foreach(var_05 in param_00)
	{
		maps\mp\gametypes\_spawnscoring::initscoredata(var_05);
		if(var_05 maps\mp\zombies\_zombies_zone_manager::spawnercanbeusedfor(param_01,param_02))
		{
			var_03[var_03.size] = var_05;
		}
	}

	if(var_03.size)
	{
		var_07 = scorespawns_aizombies(var_03,param_01,param_02);
	}
	else
	{
		var_07 = maps\mp\gametypes\_spawnscoring::selectbestspawnpoint(param_01);
	}

	return var_07;
}

//Function Number: 12
scorespawns_aizombies(param_00,param_01,param_02)
{
	var_03 = param_00[0];
	foreach(var_05 in param_00)
	{
		scorefactors_aizombies(var_05,param_01,param_02);
		if(!isdefined(var_03) || var_05.totalscore > var_03.totalscore)
		{
			var_03 = var_05;
		}
	}

	return var_03;
}

//Function Number: 13
scorefactors_aizombies(param_00,param_01,param_02)
{
	var_03 = score_factor_ai(2,::preferplayerinzone,param_00);
	param_00.totalscore = param_00.totalscore + var_03;
	var_03 = score_factor_ai(1,::avoidrecentlyusedspawns,param_00);
	param_00.totalscore = param_00.totalscore + var_03;
	var_03 = score_factor_ai(6,::matchclassname,param_00,param_01,param_02);
	param_00.totalscore = param_00.totalscore + var_03;
}

//Function Number: 14
matchclassname(param_00,param_01,param_02)
{
	if(param_00 maps\mp\zombies\_zombies_zone_manager::spawnercanbeusedfor(param_01,param_02))
	{
		return 100;
	}

	return 0;
}

//Function Number: 15
preferplayerinzone(param_00)
{
	if(!isdefined(param_00.zone_name))
	{
		return 0;
	}

	if(maps\mp\zombies\_zombies_zone_manager::isplayerinzone(param_00.zone_name))
	{
		return 100;
	}

	return 0;
}

//Function Number: 16
avoidrecentlyusedspawns(param_00)
{
	if(isdefined(param_00.lastspawntime))
	{
		var_01 = gettime() - param_00.lastspawntime;
		if(var_01 > 30000)
		{
			return 100;
		}

		return var_01 / 30000 * 100;
	}

	return 100;
}

//Function Number: 17
preferloneplayers(param_00)
{
	if(!isdefined(param_00.zone_name))
	{
		return 0;
	}

	var_01 = maps\mp\zombies\_zombies_zone_manager::getnumberofplayersinzone(param_00.zone_name);
	if(var_01 == 0)
	{
		return 0;
	}

	return 100 * 1 - var_01 * 0.15;
}

//Function Number: 18
score_factor_ai(param_00,param_01,param_02,param_03,param_04)
{
	if(isdefined(param_04))
	{
		var_05 = [[ param_01 ]](param_02,param_03,param_04);
	}
	else if(isdefined(param_04))
	{
		var_05 = [[ param_02 ]](param_03,param_04);
	}
	else
	{
		var_05 = [[ param_02 ]](param_03);
	}

	var_05 = clamp(var_05,0,100);
	var_05 = var_05 * param_00;
	return var_05;
}