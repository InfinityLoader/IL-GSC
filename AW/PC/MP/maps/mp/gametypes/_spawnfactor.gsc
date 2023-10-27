/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps/mp/gametypes/_spawnfactor.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 26
 * Decompile Time: 417 ms
 * Timestamp: 10/27/2023 1:51:00 AM
*******************************************************************/

//Function Number: 1
score_factor(param_00,param_01,param_02,param_03)
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
	param_02.debugscoredata[param_02.debugscoredata.size] = var_04;
	param_02.totalpossiblescore = param_02.totalpossiblescore + 100 * param_00;
	return var_04;
}

//Function Number: 2
critical_factor(param_00,param_01,param_02)
{
	if(isdefined(param_02))
	{
		var_03 = [[ param_00 ]](param_01,param_02);
	}
	else
	{
		var_03 = [[ param_01 ]](param_02);
	}

	var_03 = clamp(var_03,0,100);
	param_01.debugcriticaldata[param_01.debugcriticaldata.size] = var_03;
	return var_03;
}

//Function Number: 3
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

//Function Number: 4
avoidgasclouds(param_00)
{
	foreach(var_02 in level.missile_strike_gas_clouds)
	{
		if(!isdefined(var_02))
		{
			continue;
		}

		if(distancesquared(param_00.origin,var_02.origin) < 90000)
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
		if(!isdefined(var_02) || !var_02 isexplosivedangeroustoplayer(self))
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
	var_01 = level.mines;
	foreach(var_03 in var_01)
	{
		if(!isdefined(var_03) || !var_03 isexplosivedangeroustoplayer(self))
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
isexplosivedangeroustoplayer(param_00)
{
	if(!level.teambased || level.friendlyfire || !isdefined(param_00.team))
	{
		return 1;
	}

	if(!isdefined(self.owner) || !isdefined(self.owner.team))
	{
		return 1;
	}

	if(param_00 == self.owner)
	{
		return 1;
	}

	var_01 = self.owner.team;
	return var_01 != param_00.team;
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
		var_01 = maps\mp\gametypes\_gameobjects::getenemyteam(self.team);
	}

	if(param_00.cornersights[var_01] > 0)
	{
		return 0;
	}

	return 100;
}

//Function Number: 10
avoidfullvisibleenemies(param_00)
{
	var_01 = "all";
	if(level.teambased)
	{
		var_01 = maps\mp\gametypes\_gameobjects::getenemyteam(self.team);
	}

	if(param_00.fullsights[var_01] > 0)
	{
		return 0;
	}

	return 100;
}

//Function Number: 11
avoidtelefrag(param_00)
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
				break;
			}
		}

		return 0;
	}

	return 100;
}

//Function Number: 12
avoidsamespawn(param_00)
{
	if(isdefined(self.lastspawnpoint) && self.lastspawnpoint == param_00)
	{
		return 0;
	}

	return 100;
}

//Function Number: 13
avoidrecentlyused(param_00)
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
avoidspawninzone(param_00,param_01)
{
	var_02 = distancesquared(param_01.origin,param_00.origin);
	if(var_02 < 692224)
	{
		return 0;
	}

	return 100;
}

//Function Number: 16
avoidlastdeathlocation(param_00)
{
	if(!isdefined(self.lastdeathpos))
	{
		return 100;
	}

	var_01 = distancesquared(param_00.origin,self.lastdeathpos);
	if(var_01 > 4000000)
	{
		return 100;
	}

	var_02 = var_01 / 4000000;
	return var_02 * 100;
}

//Function Number: 17
avoidlastattackerlocation(param_00)
{
	if(!isdefined(self.lastattacker) || !isdefined(self.lastattacker.origin))
	{
		return 100;
	}

	if(!maps\mp\_utility::isreallyalive(self.lastattacker))
	{
		return 100;
	}

	var_01 = distancesquared(param_00.origin,self.lastattacker.origin);
	if(var_01 > 4000000)
	{
		return 100;
	}

	var_02 = var_01 / 4000000;
	return var_02 * 100;
}

//Function Number: 18
preferalliesbydistance(param_00)
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

//Function Number: 19
avoidenemiesbydistance(param_00)
{
	var_01 = "all";
	if(level.teambased)
	{
		var_01 = maps\mp\gametypes\_gameobjects::getenemyteam(self.team);
	}

	if(param_00.totalplayers[var_01] == 0)
	{
		return 100;
	}

	setdvarifuninitialized("scr_spawnfactor_maxenemydistance",1800);
	var_02 = getdvarint("scr_spawnfactor_maxenemydistance");
	var_02 = var_02 * var_02;
	var_03 = min(param_00.mindistsquared[var_01],var_02);
	var_04 = var_03 / var_02;
	return var_04 * 100;
}

//Function Number: 20
avoidbadspawns(param_00)
{
	if(isdefined(self.spawninfo) && isdefined(self.spawninfo.badspawn) && self.spawninfo.badspawn)
	{
		if(self.spawninfo.spawnpoint == param_00)
		{
			return 100;
		}

		if(isdefined(self.spawninfo.pastbadspawncount))
		{
			for(var_01 = 0;var_01 < self.spawninfo.pastbadspawncount;var_01++)
			{
				if(self.spawninfo.pastbadspawns[var_01] == param_00)
				{
					return 100;
				}
			}
		}
	}

	return 0;
}

//Function Number: 21
avoidflagbydistance(param_00)
{
	if(param_00.enemyflagdist > 0)
	{
		var_01 = param_00.friendlyflagdist / param_00.enemyflagdist / param_00.friendlyflag.highestspawndistratio * 1.33;
	}
	else
	{
		var_01 = 0;
	}

	return var_01 * 100;
}

//Function Number: 22
preferdompoints(param_00,param_01)
{
	if(param_01[0] && param_00.preferreddompoint == 0)
	{
		return 100;
	}

	if(param_01[1] && param_00.preferreddompoint == 1)
	{
		return 100;
	}

	if(param_01[2] && param_00.preferreddompoint == 2)
	{
		return 100;
	}

	return 0;
}

//Function Number: 23
preferbyteambase(param_00,param_01)
{
	if(isdefined(param_00.teambase) && param_00.teambase == param_01)
	{
		return 100;
	}

	return 0;
}

//Function Number: 24
randomspawnscore(param_00)
{
	return randomintrange(0,99);
}

//Function Number: 25
avoidzone(param_00,param_01)
{
	var_02 = distancesquared(param_01.origin,param_00.origin);
	var_03 = var_02 - 692224;
	var_04 = 6067776;
	var_05 = 1867776;
	if(var_03 >= var_05)
	{
		return 100 * 1 - 0.25 * var_03 - var_05 / var_04 - var_05;
	}

	if(var_03 > 0)
	{
		return 100 * var_03 / var_05;
	}

	return 0;
}

//Function Number: 26
preferplayeranchors(param_00)
{
	var_01 = self.team;
	var_02 = maps\mp\_utility::getotherteam(var_01);
	if(param_00.nearbyplayers[var_01] == 0)
	{
		return 0;
	}

	if(param_00.nearbyplayers[var_02] == 0)
	{
		return 100;
	}

	var_03 = param_00.nearbyplayers[var_01] - param_00.nearbyplayers[var_02];
	if(var_03 <= 0)
	{
		return 0;
	}

	if(var_03 == 1)
	{
		return 50;
	}

	if(var_03 >= 2)
	{
		return 75;
	}

	return 0;
}