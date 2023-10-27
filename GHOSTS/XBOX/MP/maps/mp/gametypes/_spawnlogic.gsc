/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes\_spawnlogic.gsc
 * Game: Call of Duty: Ghosts
 * Platform: Console
 * Function Count: 43
 * Decompile Time: 749 ms
 * Timestamp: 10/27/2023 1:31:37 AM
*******************************************************************/

//Function Number: 1
func_44DF()
{
	level.killstreakspawnshield = 5000;
	level.forcebuddyspawn = 0;
	level.supportbuddyspawn = 1;
	level.spawnmins = (0,0,0);
	level.spawnmaxs = (0,0,0);
	level.clienttracespawnclass = undefined;
	level.disableclientspawntraces = 0;
	level.numplayerswaitingtospawn = 0;
	level.numplayerswaitingtoenterkillcam = 0;
	level.players = [];
	level.participants = [];
	level.characters = [];
	level.spawnpointarray = [];
	level.grenades = [];
	level.missiles = [];
	level.carepackages = [];
	level.helis = [];
	level.turrets = [];
	level.tanks = [];
	level.scramblers = [];
	level.ims = [];
	level.ugvs = [];
	level.balldrones = [];
	level thread func_595D();
	level thread spawnpointupdate();
	level thread func_8214();
	level thread func_8227();
	level thread func_8211();
	level thread func_8215();
	if(getdvarint("scr_frontlineSpawns",0) == 1)
	{
		if(level.gametype == "war" || level.gametype == "conf" || level.gametype == "cranked")
		{
			level thread maps\mp\gametypes\_spawnfactor::spawnfrontlinethink();
		}
	}
	else
	{
		var_00 = castint(getdvar("scr_anchorSpawns"));
		if(level.gametype == "war" || level.gametype == "conf" || level.gametype == "cranked")
		{
			level thread maps\mp\gametypes\_spawnfactor::func_9087();
		}
	}

	for(var_01 = 0;var_01 < level.teamnamelist.size;var_01++)
	{
		level.teamspawnpoints[level.teamnamelist[var_01]] = [];
	}

	maps\mp\gametypes\_spawnfactor::func_9267();
}

//Function Number: 2
func_8215()
{
	for(;;)
	{
		self waittill("host_migration_end");
		foreach(var_01 in level.participants)
		{
			var_01.canperformclienttraces = canperformclienttraces(var_01);
		}
	}
}

//Function Number: 3
func_595D()
{
	for(;;)
	{
		level waittill("connected",var_00);
		level thread func_7AC4(var_00);
		level thread func_310F(var_00);
	}
}

//Function Number: 4
func_310F(param_00)
{
	param_00 endon("disconnect");
	for(;;)
	{
		if(param_00.sessionstate == "playing" && maps\mp\_utility::func_4945(param_00) && !param_00 maps\mp\_utility::_hasperk("specialty_gpsjammer"))
		{
			var_01 = 0;
			var_02 = param_00 getplayerssightingme();
			foreach(var_04 in var_02)
			{
				if(level.teambased && var_04.team == param_00.team)
				{
					continue;
				}

				if(param_00.sessionstate != "playing" || !maps\mp\_utility::func_4945(param_00))
				{
					continue;
				}

				var_01 = 1;
				param_00 notify("eyesOn");
				break;
			}

			param_00 markforeyeson(var_01);
		}
		else
		{
			param_00 markforeyeson(0);
			param_00 notify("eyesOff");
		}

		wait(0.05);
	}
}

//Function Number: 5
func_7AC4(param_00)
{
	param_00 endon("disconnect");
	param_00.canperformclienttraces = canperformclienttraces(param_00);
	if(!param_00.canperformclienttraces)
	{
	}

	wait(0.05);
	param_00 setclientspawnsighttraces(level.clienttracespawnclass);
}

//Function Number: 6
canperformclienttraces(param_00)
{
	if(level.disableclientspawntraces)
	{
		return 0;
	}

	if(!isdefined(level.clienttracespawnclass))
	{
		return 0;
	}

	if(isai(param_00))
	{
		return 0;
	}

	if(param_00 ishost())
	{
		return 0;
	}

	return 1;
}

//Function Number: 7
addstartspawnpoints(param_00)
{
	var_01 = func_3BF6(param_00);
	if(!var_01.size)
	{
	}

	if(!isdefined(level.startspawnpoints))
	{
		level.startspawnpoints = [];
	}

	for(var_02 = 0;var_02 < var_01.size;var_02++)
	{
		var_01[var_02] func_78B8();
		var_01[var_02].selected = 0;
		level.startspawnpoints[level.startspawnpoints.size] = var_01[var_02];
	}

	foreach(var_04 in var_01)
	{
		var_04.infront = 1;
		var_05 = anglestoforward(var_04.angles);
		foreach(var_07 in var_01)
		{
			if(var_04 == var_07)
			{
				continue;
			}

			var_08 = vectornormalize(var_07.origin - var_04.origin);
			var_09 = vectordot(var_05,var_08);
			if(var_09 > 0.86)
			{
				var_04.infront = 0;
				break;
			}
		}
	}
}

//Function Number: 8
addspawnpoints(param_00,param_01,param_02)
{
	if(!isdefined(level.spawnpoints))
	{
		level.spawnpoints = [];
	}

	if(!isdefined(level.teamspawnpoints[param_00]))
	{
		level.teamspawnpoints[param_00] = [];
	}

	if(!isdefined(param_02))
	{
		param_02 = 0;
	}

	var_03 = [];
	var_03 = func_3BF6(param_01);
	if(!isdefined(level.clienttracespawnclass))
	{
		level.clienttracespawnclass = param_01;
	}

	if(!var_03.size && !param_02)
	{
	}

	foreach(var_05 in var_03)
	{
		if(!isdefined(var_05.inited))
		{
			var_05 func_78B8();
			level.spawnpoints[level.spawnpoints.size] = var_05;
		}

		level.teamspawnpoints[param_00][level.teamspawnpoints[param_00].size] = var_05;
	}
}

//Function Number: 9
func_78B8()
{
	var_00 = self;
	level.spawnmins = func_30A2(level.spawnmins,var_00.origin);
	level.spawnmaxs = func_30A1(level.spawnmaxs,var_00.origin);
	var_00.forward = anglestoforward(var_00.angles);
	var_00.sighttracepoint = var_00.origin + (0,0,50);
	var_00.lastspawntime = gettime();
	var_00.outside = 1;
	var_00.inited = 1;
	var_00.alternates = [];
	var_01 = 1024;
	if(!bullettracepassed(var_00.sighttracepoint,var_00.sighttracepoint + (0,0,var_01),0,undefined))
	{
		var_02 = var_00.sighttracepoint + var_00.forward * 100;
		if(!bullettracepassed(var_02,var_02 + (0,0,var_01),0,undefined))
		{
			var_00.outside = 0;
		}
	}

	var_03 = anglestoright(var_00.angles);
	addalternatespawnpoint(var_00,var_00.origin + var_03 * 45);
	addalternatespawnpoint(var_00,var_00.origin - var_03 * 45);
	func_464F(var_00);
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
	}

	var_06 = playerphysicstrace(var_04,param_01);
	param_00.alternates[param_00.alternates.size] = var_06;
}

//Function Number: 11
func_3BF6(param_00)
{
	if(!isdefined(level.spawnpointarray))
	{
		level.spawnpointarray = [];
	}

	if(!isdefined(level.spawnpointarray[param_00]))
	{
		level.spawnpointarray[param_00] = [];
		level.spawnpointarray[param_00] = getspawnarray(param_00);
		foreach(var_02 in level.spawnpointarray[param_00])
		{
			var_02.classname = param_00;
		}
	}

	return level.spawnpointarray[param_00];
}

//Function Number: 12
func_3BF2(param_00)
{
	if(!isdefined(param_00))
	{
		return undefined;
	}

	var_01 = undefined;
	param_00 = maps\mp\gametypes\_spawnscoring::checkdynamicspawns(param_00);
	param_00 = common_scripts\utility::array_randomize(param_00);
	foreach(var_03 in param_00)
	{
		var_01 = var_03;
		if(canspawn(var_01.origin) && !positionwouldtelefrag(var_01.origin))
		{
			break;
		}
	}

	return var_01;
}

//Function Number: 13
func_3BF5(param_00)
{
	if(!isdefined(param_00))
	{
		return undefined;
	}

	var_01 = undefined;
	param_00 = maps\mp\gametypes\_spawnscoring::checkdynamicspawns(param_00);
	foreach(var_03 in param_00)
	{
		if(var_03.selected)
		{
			continue;
		}

		if(var_03.infront)
		{
			var_01 = var_03;
			break;
		}

		var_01 = var_03;
	}

	if(!isdefined(var_01))
	{
		var_01 = func_3BF2(param_00);
	}

	var_01.selected = 1;
	return var_01;
}

//Function Number: 14
func_3BF1(param_00,param_01)
{
	wait(5);
}

//Function Number: 15
func_8214()
{
	for(;;)
	{
		level.grenades = getentarray("grenade","classname");
		wait(0.05);
	}
}

//Function Number: 16
func_8227()
{
	for(;;)
	{
		level.missiles = getentarray("rocket","classname");
		wait(0.05);
	}
}

//Function Number: 17
func_8211()
{
	for(;;)
	{
		level.carepackages = getentarray("care_package","targetname");
		wait(0.05);
	}
}

//Function Number: 18
func_3C41(param_00)
{
	return level.teamspawnpoints[param_00];
}

//Function Number: 19
func_4928()
{
	if(!isdefined(level.pathdataavailable))
	{
		var_00 = getallnodes();
		level.pathdataavailable = isdefined(var_00) && var_00.size > 150;
	}

	return level.pathdataavailable;
}

//Function Number: 20
addtoparticipantsarray()
{
	level.participants[level.participants.size] = self;
}

//Function Number: 21
func_6592()
{
	var_00 = 0;
	for(var_01 = 0;var_01 < level.participants.size;var_01++)
	{
		if(level.participants[var_01] == self)
		{
			var_00 = 1;
			while(var_01 < level.participants.size - 1)
			{
				level.participants[var_01] = level.participants[var_01 + 1];
				var_01++;
			}

			level.participants[var_01] = undefined;
			break;
		}
	}
}

//Function Number: 22
addtocharactersarray()
{
	if(maps\mp\_utility::func_47BB())
	{
		for(var_00 = 0;var_00 < level.characters.size;var_00++)
		{
			if(level.characters[var_00] == self)
			{
			}
		}
	}

	level.characters[level.characters.size] = self;
}

//Function Number: 23
func_658C()
{
	var_00 = 0;
	for(var_01 = 0;var_01 < level.characters.size;var_01++)
	{
		if(level.characters[var_01] == self)
		{
			var_00 = 1;
			while(var_01 < level.characters.size - 1)
			{
				level.characters[var_01] = level.characters[var_01 + 1];
				var_01++;
			}

			level.characters[var_01] = undefined;
			break;
		}
	}
}

//Function Number: 24
spawnpointupdate()
{
	while(!isdefined(level.spawnpoints) || level.spawnpoints.size == 0)
	{
		wait(0.05);
	}

	level thread func_78BA();
	level thread func_78B7();
	for(;;)
	{
		level.disableclientspawntraces = getdvarint("scr_disableClientSpawnTraces") > 0;
		wait(0.05);
	}
}

//Function Number: 25
getactiveplayerlist()
{
	var_00 = [];
	foreach(var_02 in level.characters)
	{
		if(!maps\mp\_utility::func_4945(var_02))
		{
			continue;
		}

		if(isplayer(var_02) && var_02.sessionstate != "playing")
		{
			continue;
		}

		if(var_02 maps\mp\killstreaks\_killstreaks::func_4994() && isdefined(var_02.chopper) && !isdefined(var_02.chopper.movedlow) || !var_02.chopper.movedlow)
		{
			continue;
		}

		var_02.spawnlogicteam = getspawnteam(var_02);
		if(var_02.spawnlogicteam == "spectator")
		{
			continue;
		}

		if(isbot(var_02) && var_02.agent_type == "dog")
		{
			var_02.spawnlogictraceheight = getplayertraceheight(var_02,1);
			var_02.spawntracelocation = var_02.origin + (0,0,var_02.spawnlogictraceheight);
		}
		else if(!var_02.canperformclienttraces)
		{
			var_03 = getplayertraceheight(var_02);
			var_04 = var_02 geteye();
			var_04 = (var_04[0],var_04[1],var_02.origin[2] + var_03);
			var_02.spawnlogictraceheight = var_03;
			var_02.spawntracelocation = var_04;
		}

		var_00[var_00.size] = var_02;
	}

	return var_00;
}

//Function Number: 26
func_78BA()
{
	var_00 = 18;
	var_01 = 0;
	var_02 = 0;
	var_03 = getactiveplayerlist();
	for(;;)
	{
		if(var_02)
		{
			wait(0.05);
			var_01 = 0;
			var_02 = 0;
			var_03 = getactiveplayerlist();
		}

		var_04 = level.spawnpoints;
		var_04 = maps\mp\gametypes\_spawnscoring::checkdynamicspawns(var_04);
		var_02 = 1;
		foreach(var_06 in var_04)
		{
			func_1D54(var_06);
			foreach(var_08 in var_03)
			{
				if(var_06.fullsights[var_08.spawnlogicteam])
				{
					continue;
				}

				if(var_08.canperformclienttraces)
				{
					var_09 = var_08 clientspawnsighttracepassed(var_06.index);
				}
				else
				{
					var_09 = spawnsighttrace(var_06,var_06.origin + (0,0,var_08.spawnlogictraceheight),var_08.spawntracelocation);
					var_01++;
				}

				if(!var_09)
				{
					continue;
				}

				if(var_09 > 0.95)
				{
					var_06.fullsights[var_08.spawnlogicteam]++;
					continue;
				}

				var_06.cornersights[var_08.spawnlogicteam]++;
			}

			additionalsighttraceentities(var_06,level.turrets);
			additionalsighttraceentities(var_06,level.ugvs);
			if(func_74C2(var_00,var_01))
			{
				wait(0.05);
				var_01 = 0;
				var_02 = 0;
				var_03 = getactiveplayerlist();
			}
		}
	}
}

//Function Number: 27
func_74C2(param_00,param_01)
{
	var_02 = 0;
	foreach(var_04 in level.participants)
	{
		if(!var_04.canperformclienttraces)
		{
			var_02++;
		}
	}

	if(param_01 + var_02 > param_00)
	{
		return 1;
	}

	return 0;
}

//Function Number: 28
func_78B7()
{
	var_00 = getactiveplayerlist();
	var_01 = gettime();
	var_02 = 4;
	var_03 = 0;
	for(;;)
	{
		var_04 = level.spawnpoints;
		var_04 = maps\mp\gametypes\_spawnscoring::checkdynamicspawns(var_04);
		foreach(var_06 in var_04)
		{
			clearspawnpointdistancedata(var_06);
			var_03++;
			foreach(var_08 in var_00)
			{
				var_09 = distancesquared(var_08.origin,var_06.origin);
				if(var_09 < var_06.mindistsquared[var_08.spawnlogicteam])
				{
					var_06.mindistsquared[var_08.spawnlogicteam] = var_09;
				}

				if(var_08.spawnlogicteam == "spectator")
				{
					continue;
				}

				var_06.distsumsquared[var_08.spawnlogicteam] = var_06.distsumsquared[var_08.spawnlogicteam] + var_09;
				var_06.distsumsquaredcapped[var_08.spawnlogicteam] = var_06.distsumsquaredcapped[var_08.spawnlogicteam] + min(var_09,maps\mp\gametypes\_spawnfactor::maxplayerspawninfluencedistsquared());
				var_06.totalplayers[var_08.spawnlogicteam]++;
			}

			if(isdefined(level.alliesweightorg))
			{
				var_0B = 25;
				for(var_0C = 0;var_0C < var_0B;var_0C++)
				{
					var_09 = distancesquared(level.alliesweightorg,var_06.origin);
					var_06.totalplayers["allies"]++;
					var_06.distsumsquared["allies"] = var_06.distsumsquared["allies"] + var_09;
					var_06.distsumsquaredcapped["allies"] = var_06.distsumsquaredcapped["allies"] + var_09;
					var_09 = distancesquared(level.axisweightorg,var_06.origin);
					var_06.totalplayers["axis"]++;
					var_06.distsumsquared["axis"] = var_06.distsumsquared["axis"] + var_09;
					var_06.distsumsquaredcapped["axis"] = var_06.distsumsquaredcapped["axis"] + var_09;
				}
			}

			if(var_03 == var_02)
			{
				wait(0.05);
				var_00 = getactiveplayerlist();
				var_01 = gettime();
				var_03 = 0;
			}
		}
	}
}

//Function Number: 29
getspawnteam(param_00)
{
	var_01 = "all";
	if(level.teambased)
	{
		var_01 = param_00.team;
	}

	return var_01;
}

//Function Number: 30
func_464F(param_00)
{
	func_1D54(param_00);
	clearspawnpointdistancedata(param_00);
}

//Function Number: 31
func_1D54(param_00)
{
	if(level.teambased)
	{
		foreach(var_02 in level.teamnamelist)
		{
			clearteamspawnpointsightdata(param_00,var_02);
		}
	}

	clearteamspawnpointsightdata(param_00,"all");
}

//Function Number: 32
clearspawnpointdistancedata(param_00)
{
	if(level.teambased)
	{
		foreach(var_02 in level.teamnamelist)
		{
			func_1D55(param_00,var_02);
		}
	}

	func_1D55(param_00,"all");
}

//Function Number: 33
clearteamspawnpointsightdata(param_00,param_01)
{
	param_00.fullsights[param_01] = 0;
	param_00.cornersights[param_01] = 0;
}

//Function Number: 34
func_1D55(param_00,param_01)
{
	param_00.distsumsquared[param_01] = 0;
	param_00.distsumsquaredcapped[param_01] = 0;
	param_00.mindistsquared[param_01] = 9999999;
	param_00.totalplayers[param_01] = 0;
}

//Function Number: 35
getplayertraceheight(param_00,param_01)
{
	if(isdefined(param_01) && param_01)
	{
		return 64;
	}

	var_02 = param_00 getstance();
	if(var_02 == "stand")
	{
		return 64;
	}

	if(var_02 == "crouch")
	{
		return 44;
	}

	return 32;
}

//Function Number: 36
additionalsighttraceentities(param_00,param_01)
{
	foreach(var_03 in param_01)
	{
		if(!isdefined(var_03))
		{
			continue;
		}

		var_04 = getspawnteam(var_03);
		if(param_00.fullsights[var_04])
		{
			continue;
		}

		var_05 = spawnsighttrace(param_00,param_00.sighttracepoint,var_03.origin + (0,0,50));
		if(!var_05)
		{
			continue;
		}

		if(var_05 > 0.95)
		{
			param_00.fullsights[var_04]++;
			continue;
		}

		param_00.cornersights[var_04]++;
	}
}

//Function Number: 37
func_3247(param_00)
{
	var_01 = gettime();
	self.lastspawnpoint = param_00;
	self.lastspawntime = var_01;
	param_00.lastspawntime = var_01;
	param_00.lastspawnteam = self.team;
}

//Function Number: 38
func_30A3(param_00)
{
	var_01 = func_3BF6(param_00);
	for(var_02 = 0;var_02 < var_01.size;var_02++)
	{
		level.spawnmins = func_30A2(level.spawnmins,var_01[var_02].origin);
		level.spawnmaxs = func_30A1(level.spawnmaxs,var_01[var_02].origin);
	}
}

//Function Number: 39
func_30A2(param_00,param_01)
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

//Function Number: 40
func_30A1(param_00,param_01)
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

//Function Number: 41
findboxcenter(param_00,param_01)
{
	var_02 = (0,0,0);
	var_02 = param_01 - param_00;
	var_02 = (var_02[0] / 2,var_02[1] / 2,var_02[2] / 2) + param_00;
	return var_02;
}

//Function Number: 42
setmapcenterfordev()
{
	level.spawnmins = (0,0,0);
	level.spawnmaxs = (0,0,0);
	func_30A3("mp_tdm_spawn_allies_start");
	func_30A3("mp_tdm_spawn_axis_start");
	level.mapcenter = findboxcenter(level.spawnmins,level.spawnmaxs);
	setmapcenter(level.mapcenter);
}

//Function Number: 43
func_948D()
{
	return level.ingraceperiod && !isdefined(level.numkills) || level.numkills == 0;
}