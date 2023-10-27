/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes\_spawnlogic.gsc
 * Game: Call of Duty: Modern Warfare Remastered
 * Platform: PC
 * Function Count: 56
 * Decompile Time: 875 ms
 * Timestamp: 10/27/2023 2:42:08 AM
*******************************************************************/

//Function Number: 1
init()
{
	level.killstreakspawnshield = 0;
	level.spawnmins = (0,0,0);
	level.spawnmaxs = (0,0,0);
	level.clienttracespawnclass = undefined;
	level.disableclientspawntraces = 0;
	level.numplayerswaitingtospawn = 0;
	level.numplayerswaitingtoenterkillcam = 0;
	level.badspawncount["axis"] = 0;
	level.badspawncount["allies"] = 0;
	level.players = [];
	level.participants = [];
	level.characters = [];
	level.spawnpointarray = [];
	level.grenades = [];
	level.missiles = [];
	level.carepackages = [];
	level.turrets = [];
	level.scramblers = [];
	level.ugvs = [];
	level.trackingdrones = [];
	level.activeplayerlistupdatetime = -1;
	level.activeplayerlist = [];
	maps\mp\gametypes\_legacyspawnlogic::init();
	level thread trackgrenades();
	if(!maps\mp\gametypes\_legacyspawnlogic::uselegacyspawning())
	{
		level thread onplayerconnect();
		level thread spawnpointupdate();
		level thread trackmissiles();
		level thread trackcarepackages();
		level thread trackhostmigrationend();
	}

	for(var_00 = 0;var_00 < level.teamnamelist.size;var_00++)
	{
		level.teamspawnpoints[level.teamnamelist[var_00]] = [];
	}
}

//Function Number: 2
trackhostmigrationend()
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
onplayerconnect()
{
	for(;;)
	{
		level waittill("connected",var_00);
		level thread startclientspawnpointtraces(var_00);
		level thread updatespawnsightsforplayer(var_00);
	}
}

//Function Number: 4
startclientspawnpointtraces(param_00)
{
	param_00 endon("disconnect");
	param_00.canperformclienttraces = canperformclienttraces(param_00);
	if(!param_00.canperformclienttraces)
	{
		return;
	}

	wait(0.05);
	param_00 setclientspawnsighttraces(level.clienttracespawnclass);
}

//Function Number: 5
updatespawnsightsforplayer(param_00)
{
	while(isdefined(param_00))
	{
		var_01 = param_00 common_scripts\utility::waittill_any_return_no_endon_death("death","disconnect","joined_spectators","joined_team");
		removespawnsightsforplayer(param_00);
		if(var_01 == "disconnect")
		{
			break;
		}
	}
}

//Function Number: 6
calculatespawntospawnsights()
{
	var_00 = (0,0,64);
	foreach(var_02 in level.spawnpoints)
	{
		var_02.fullsightspawns = [];
		var_02.cornersightspawns = [];
		var_02.trackplayersights = 1;
	}

	foreach(var_02 in level.spawnpoints)
	{
		if(!maps\mp\_utility::is_true(var_02.trackplayersights))
		{
			continue;
		}

		var_05 = var_02.origin + var_00;
		foreach(var_07 in level.spawnpoints)
		{
			var_08 = var_07.origin + var_00;
			var_09 = spawnsighttrace(var_02,var_05,var_08,var_02.index);
			if(var_09 > 0.95)
			{
				var_02.fullsightspawns[var_02.fullsightspawns.size] = var_07;
				continue;
			}

			if(var_09 > 0)
			{
				var_02.cornersightspawns[var_02.cornersightspawns.size] = var_07;
			}
		}
	}
}

//Function Number: 7
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

//Function Number: 8
addstartspawnpoints(param_00,param_01)
{
	var_02 = getspawnpointarray(param_00);
	if(!var_02.size)
	{
		if(!maps\mp\_utility::is_true(param_01))
		{
		}

		return;
	}

	if(!isdefined(level.startspawnpoints))
	{
		level.startspawnpoints = [];
	}

	for(var_03 = 0;var_03 < var_02.size;var_03++)
	{
		var_02[var_03] spawnpointinit();
		var_02[var_03].selected = 0;
		level.startspawnpoints[level.startspawnpoints.size] = var_02[var_03];
	}

	foreach(var_05 in var_02)
	{
		var_05.infront = 1;
		var_06 = anglestoforward(var_05.angles);
		foreach(var_08 in var_02)
		{
			if(var_05 == var_08)
			{
				continue;
			}

			var_09 = vectornormalize(var_08.origin - var_05.origin);
			var_0A = vectordot(var_06,var_09);
			if(var_0A > 0.86)
			{
				var_05.infront = 0;
				break;
			}
		}
	}

	if(!maps\mp\_utility::is_true(param_01))
	{
		var_0D = var_02.size;
		var_0E = level.startspawnpoints.size;
		addstartspawnpoints(param_00 + "_overflow",1);
		var_0F = level.startspawnpoints.size - var_0E;
	}
}

//Function Number: 9
addspawnpoints(param_00,param_01)
{
	if(!isdefined(level.spawnpoints))
	{
		level.spawnpoints = [];
	}

	if(!isdefined(level.teamspawnpoints[param_00]))
	{
		level.teamspawnpoints[param_00] = [];
	}

	var_02 = [];
	var_02 = getspawnpointarray(param_01);
	if(!isdefined(level.clienttracespawnclass))
	{
		level.clienttracespawnclass = param_01;
	}

	if(!var_02.size)
	{
		return;
	}

	foreach(var_04 in var_02)
	{
		if(!isdefined(var_04.inited))
		{
			var_04 spawnpointinit();
			level.spawnpoints[level.spawnpoints.size] = var_04;
		}

		level.teamspawnpoints[param_00][level.teamspawnpoints[param_00].size] = var_04;
	}
}

//Function Number: 10
spawnpointinit()
{
	var_00 = self;
	level.spawnmins = expandmins(level.spawnmins,var_00.origin);
	level.spawnmaxs = expandmaxs(level.spawnmaxs,var_00.origin);
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
	initspawnpointvalues(var_00);
}

//Function Number: 11
addalternatespawnpoint(param_00,param_01)
{
	var_02 = playerphysicstrace(param_00.origin,param_00.origin + (0,0,18));
	var_03 = var_02[2] - param_00.origin[2];
	var_04 = (param_01[0],param_01[1],param_01[2] + var_03);
	var_05 = playerphysicstrace(var_02,var_04);
	if(var_05 != var_04)
	{
		return;
	}

	var_06 = droptoground(var_04);
	if(abs(var_06[2] - param_01[2]) > 128)
	{
		return;
	}

	param_00.alternates[param_00.alternates.size] = var_06;
}

//Function Number: 12
getspawnpointarray(param_00)
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

//Function Number: 13
cananyplayerseeffaspawnpoint(param_00)
{
	var_01 = (0,0,64);
	var_02 = param_00.origin + var_01;
	foreach(var_04 in level.players)
	{
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

		var_05 = var_04.origin + var_01;
		if(sighttracepassed(var_02,var_05,0,var_04))
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 14
getstartspawnffa(param_00)
{
	if(!isdefined(level.ffastartspawnpoints))
	{
		level.ffastartspawnpoints = [];
	}

	if(!isdefined(level.ffastartspawnpoints[param_00]))
	{
		var_01 = getteamspawnpoints(param_00);
		level.ffastartspawnpoints[param_00] = [];
		foreach(var_03 in var_01)
		{
			if(isdefined(var_03.script_noteworthy) && var_03.script_noteworthy == "start_spawn")
			{
				level.ffastartspawnpoints[param_00][level.ffastartspawnpoints[param_00].size] = var_03;
			}
		}
	}

	var_05 = undefined;
	if(level.ffastartspawnpoints[param_00].size >= level.players.size)
	{
		var_05 = getspawnpoint_random(level.ffastartspawnpoints[param_00],1);
	}

	if(!isdefined(var_05))
	{
		var_06 = getteamspawnpoints(param_00);
		var_06 = common_scripts\utility::array_randomize(var_06);
		foreach(var_08 in var_06)
		{
			if(!isdefined(var_08.ffastartspawnsighted))
			{
				var_08.ffastartspawnsighted = 0;
			}
			else if(var_08.ffastartspawnsighted)
			{
				continue;
			}

			if(cananyplayerseeffaspawnpoint(var_08))
			{
				var_08.ffastartspawnsighted = 1;
				continue;
			}

			if(canspawn(var_08.origin) && !positionwouldtelefrag(var_08.origin))
			{
				var_05 = var_08;
				break;
			}
		}

		if(!isdefined(var_05))
		{
			var_05 = getspawnpoint_random(var_06);
		}
	}

	return var_05;
}

//Function Number: 15
getspawnpoint_random(param_00,param_01)
{
	if(!isdefined(param_00))
	{
		return undefined;
	}

	param_00 = maps\mp\gametypes\_spawnscoring::checkdynamicspawns(param_00);
	param_00 = common_scripts\utility::array_randomize(param_00);
	foreach(var_03 in param_00)
	{
		if(canspawn(var_03.origin) && !positionwouldtelefrag(var_03.origin))
		{
			return var_03;
		}
	}

	if(!maps\mp\_utility::is_true(param_01) && param_00.size > 0)
	{
		return param_00[param_00.size - 1];
	}

	return undefined;
}

//Function Number: 16
getbeststartspawn(param_00)
{
	var_01 = getspawnpointarray(param_00);
	var_02 = getspawnpoint_startspawn(var_01);
	if(!isdefined(var_02))
	{
		var_03 = getspawnpointarray(param_00 + "_overflow");
		var_02 = getspawnpoint_startspawn(var_03);
	}

	if(!isdefined(var_02))
	{
		var_02 = getspawnpoint_random(var_01);
		var_02.selected = 1;
	}

	return var_02;
}

//Function Number: 17
getrandomstartspawn(param_00)
{
	var_01 = getspawnpointarray(param_00);
	var_02 = getspawnpoint_random(var_01,1);
	if(!isdefined(var_02))
	{
		var_03 = getspawnpointarray(param_00 + "_overflow");
		var_02 = getspawnpoint_random(var_03,1);
	}

	if(!isdefined(var_02))
	{
		var_02 = getspawnpoint_random(var_01);
	}

	return var_02;
}

//Function Number: 18
getspawnpoint_startspawn(param_00)
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

	if(isdefined(var_01))
	{
		var_01.selected = 1;
	}

	return var_01;
}

//Function Number: 19
getspawnpoint_nearteam(param_00,param_01)
{
	wait(5);
}

//Function Number: 20
trackgrenades()
{
	for(;;)
	{
		level.grenades = getentarray("grenade","classname");
		wait(0.05);
	}
}

//Function Number: 21
trackmissiles()
{
	for(;;)
	{
		level.missiles = getentarray("rocket","classname");
		wait(0.05);
	}
}

//Function Number: 22
trackcarepackages()
{
	for(;;)
	{
		level.carepackages = getentarray("care_package","targetname");
		wait(0.05);
	}
}

//Function Number: 23
getteamspawnpoints(param_00)
{
	return level.teamspawnpoints[param_00];
}

//Function Number: 24
ispathdataavailable()
{
	if(!isdefined(level.pathdataavailable))
	{
		var_00 = getallnodes();
		level.pathdataavailable = isdefined(var_00) && var_00.size > 150;
	}

	return level.pathdataavailable;
}

//Function Number: 25
addtoparticipantsarray()
{
	if(isdefined(level.ishorde) && level.ishorde)
	{
		level notify("participant_added",self);
	}

	level.participants[level.participants.size] = self;
}

//Function Number: 26
removefromparticipantsarray()
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

//Function Number: 27
addtocharactersarray()
{
	level.characters[level.characters.size] = self;
}

//Function Number: 28
removefromcharactersarray()
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

//Function Number: 29
spawnpointupdate()
{
	if(maps\mp\_utility::invirtuallobby())
	{
		return;
	}

	while(!isdefined(level.spawnpoints) || level.spawnpoints.size == 0)
	{
		wait(0.05);
	}

	calculatespawntospawnsights();
	level thread spawnpointsightupdate();
	level thread spawnpointclientsightupdate();
	level thread spawnpointdistanceupdate();
}

//Function Number: 30
updateactiveplayerlist()
{
	var_00 = gettime();
	if(level.activeplayerlistupdatetime == var_00)
	{
		return;
	}

	level.activeplayerlistupdatetime = var_00;
	level.activeplayerlist = [];
	level.active_ffa_players = 0;
	var_01 = level.gametype;
	var_02 = 0;
	if(var_01 == "dm" || var_01 == "gun")
	{
		var_02 = 1;
	}

	foreach(var_04 in level.characters)
	{
		var_04.isactiveplayer = 0;
		if(isplayer(var_04) && var_02 && var_04.sessionstate == "playing" || var_04.sessionstate == "dead")
		{
			level.active_ffa_players++;
		}

		if(!maps\mp\_utility::isreallyalive(var_04))
		{
			continue;
		}

		if(isplayer(var_04) && var_04.sessionstate != "playing")
		{
			continue;
		}

		var_04.spawnlogicteam = getspawnteam(var_04);
		if(var_04.spawnlogicteam == "spectator")
		{
			continue;
		}

		var_05 = getplayertraceheight(var_04);
		var_06 = var_04 geteye();
		var_06 = (var_06[0],var_06[1],var_04.origin[2] + var_05);
		var_04.spawnlogictraceheight = var_05;
		var_04.spawntracelocation = var_06;
		var_04.isactiveplayer = 1;
		level.activeplayerlist[level.activeplayerlist.size] = var_04;
	}
}

//Function Number: 31
spawnpointclientsightupdate()
{
	level.maxclientupdatesperframe = 200;
	var_00 = 0;
	var_01 = 0;
	updateactiveplayerlist();
	for(;;)
	{
		if(var_01)
		{
			wait(0.05);
			var_00 = 0;
			var_01 = 0;
			updateactiveplayerlist();
		}

		var_02 = level.spawnpoints;
		var_02 = maps\mp\gametypes\_spawnscoring::checkdynamicspawns(var_02);
		var_01 = 1;
		for(var_03 = 0;var_03 < level.characters.size;var_03++)
		{
			var_04 = level.characters[var_03];
			if(!var_04.canperformclienttraces)
			{
				continue;
			}

			if(!var_04.isactiveplayer)
			{
				removespawnsightsforplayer(var_04);
				continue;
			}

			for(var_05 = 0;var_05 < level.spawnpoints.size;var_05++)
			{
				var_00++;
				var_06 = level.spawnpoints[var_05];
				var_07 = var_04 method_857B(var_06.classname);
				var_08 = var_06.fullsightsplayers[var_04.guid];
				var_09 = isdefined(var_08);
				var_0A = var_06.cornersightsplayers[var_04.guid];
				var_0B = isdefined(var_0A);
				var_0C = 0;
				if(var_09)
				{
					var_0C = var_08.time;
				}
				else if(var_0B)
				{
					var_0C = var_0A.time;
				}

				if(var_07 <= var_0C)
				{
					continue;
				}

				var_0D = var_04 clientspawnsighttracepassed(var_06.index,var_06.classname);
				if(var_0D >= 1)
				{
					if(var_09)
					{
						var_08.time = var_07;
					}
					else
					{
						if(var_0B)
						{
							removecornersightsfromspawnforplayer(var_06,var_04);
						}

						addfullsightspawnforplayer(var_06,var_04,var_07);
					}

					continue;
				}

				if(var_0D >= 0.5 && level.active_ffa_players <= 8)
				{
					if(var_0B)
					{
						var_0A.time = var_07;
					}
					else
					{
						if(var_09)
						{
							removefullsightsfromspawnforplayer(var_06,var_04);
						}

						addcornersightspawnforplayer(var_06,var_04,var_07);
					}

					continue;
				}

				if(var_0B)
				{
					removecornersightsfromspawnforplayer(var_06,var_04);
				}

				if(var_09)
				{
					removefullsightsfromspawnforplayer(var_06,var_04);
				}
			}

			if(var_00 + level.spawnpoints.size > level.maxclientupdatesperframe)
			{
				wait(0.05);
				var_00 = 0;
				var_01 = 0;
				updateactiveplayerlist();
			}
		}
	}
}

//Function Number: 32
spawnpointsightupdate()
{
	if(isdefined(level.skipspawnsighttraces) && level.skipspawnsighttraces)
	{
		return;
	}

	level.maxtraceperframe = 36;
	var_00 = 0;
	var_01 = 0;
	for(;;)
	{
		if(var_01)
		{
			wait(0.05);
			var_00 = 0;
			var_01 = 0;
			updateactiveplayerlist();
		}

		var_02 = level.spawnpoints;
		var_02 = maps\mp\gametypes\_spawnscoring::checkdynamicspawns(var_02);
		var_01 = 1;
		foreach(var_04 in var_02)
		{
			var_04.lastupdatetime = gettime();
			var_05 = 0;
			foreach(var_07 in level.activeplayerlist)
			{
				var_08 = var_04.origin + (0,0,var_07.spawnlogictraceheight);
				var_09 = var_07.spawntracelocation;
				removespawnsightsfromspawnforplayer(var_04,var_07);
				var_0A = spawnsighttrace(var_04,var_08,var_09,var_04.index);
				var_00++;
				var_05++;
				if(!var_0A)
				{
					continue;
				}

				if(var_0A > 0.95)
				{
					addfullsightspawnforplayer(var_04,var_07,gettime());
					continue;
				}

				if(level.active_ffa_players > 8)
				{
					continue;
				}

				addcornersightspawnforplayer(var_04,var_07,gettime());
			}

			if(var_00 + var_05 > level.maxtraceperframe)
			{
				wait(0.05);
				var_00 = 0;
				var_01 = 0;
				updateactiveplayerlist();
			}
		}
	}
}

//Function Number: 33
spawnpointdistanceupdate()
{
	var_00 = gettime();
	var_01 = 4;
	var_02 = 0;
	updateactiveplayerlist();
	for(;;)
	{
		var_03 = level.spawnpoints;
		var_03 = maps\mp\gametypes\_spawnscoring::checkdynamicspawns(var_03);
		var_04 = 0;
		foreach(var_06 in var_03)
		{
			clearspawnpointdistancedata(var_06);
			var_02++;
			foreach(var_08 in level.activeplayerlist)
			{
				if(var_08.spawnlogicteam == "spectator")
				{
					continue;
				}

				if(isdefined(level.spawndistanceteamskip) && var_08.spawnlogicteam == level.spawndistanceteamskip)
				{
					continue;
				}

				var_09 = distancesquared(var_08.origin,var_06.origin);
				if(var_09 < var_06.mindistsquared[var_08.spawnlogicteam])
				{
					var_06.mindistsquared[var_08.spawnlogicteam] = var_09;
				}

				var_06.distsumsquared[var_08.spawnlogicteam] = var_06.distsumsquared[var_08.spawnlogicteam] + var_09;
				var_06.totalplayers[var_08.spawnlogicteam]++;
				if(var_09 < 1638400)
				{
					if(maps\mp\_utility::isreallyalive(var_08))
					{
						var_06.nearbyplayers[var_08.spawnlogicteam]++;
					}
				}
			}

			if(var_02 == var_01)
			{
				var_04 = 1;
				wait(0.05);
				updateactiveplayerlist();
				var_00 = gettime();
				var_02 = 0;
			}
		}

		if(!var_04)
		{
			wait(0.05);
			updateactiveplayerlist();
			var_00 = gettime();
			var_02 = 0;
		}
	}
}

//Function Number: 34
getspawnteam(param_00)
{
	var_01 = "all";
	if(level.teambased)
	{
		var_01 = param_00.team;
	}

	return var_01;
}

//Function Number: 35
initspawnpointvalues(param_00)
{
	clearspawnpointsightdata(param_00);
	clearspawnpointdistancedata(param_00);
}

//Function Number: 36
clearspawnpointsightdata(param_00)
{
	if(level.teambased)
	{
		foreach(var_02 in level.teamnamelist)
		{
			clearteamspawnpointsightdata(param_00,var_02);
		}

		return;
	}

	clearteamspawnpointsightdata(param_00,"all");
}

//Function Number: 37
clearspawnpointdistancedata(param_00)
{
	if(level.teambased)
	{
		foreach(var_02 in level.teamnamelist)
		{
			clearteamspawnpointdistancedata(param_00,var_02);
		}

		return;
	}

	clearteamspawnpointdistancedata(param_00,"all");
}

//Function Number: 38
clearteamspawnpointsightdata(param_00,param_01)
{
	param_00.fullsights[param_01] = 0;
	param_00.fullsightsplayers = [];
	param_00.cornersights[param_01] = 0;
	param_00.cornersightsplayers = [];
}

//Function Number: 39
clearteamspawnpointdistancedata(param_00,param_01)
{
	param_00.distsumsquared[param_01] = 0;
	param_00.mindistsquared[param_01] = 9999999;
	param_00.totalplayers[param_01] = 0;
	param_00.nearbyplayers[param_01] = 0;
}

//Function Number: 40
removespawnsightsfromspawnforplayer(param_00,param_01)
{
	removefullsightsfromspawnforplayer(param_00,param_01);
	removecornersightsfromspawnforplayer(param_00,param_01);
}

//Function Number: 41
removefullsightsfromspawnforplayer(param_00,param_01)
{
	var_02 = param_00.fullsightsplayers[param_01.guid];
	if(isdefined(var_02))
	{
		param_00.fullsights[var_02.team]--;
		param_00.fullsightsplayers[param_01.guid] = undefined;
	}
}

//Function Number: 42
removecornersightsfromspawnforplayer(param_00,param_01)
{
	var_02 = param_00.cornersightsplayers[param_01.guid];
	if(isdefined(var_02))
	{
		param_00.cornersights[var_02.team]--;
		param_00.cornersightsplayers[param_01.guid] = undefined;
	}
}

//Function Number: 43
removespawnsightsforplayer(param_00)
{
	if(!isdefined(level.spawnpoints))
	{
		return;
	}

	foreach(var_02 in level.spawnpoints)
	{
		if(!maps\mp\_utility::is_true(var_02.trackplayersights))
		{
			continue;
		}

		removespawnsightsfromspawnforplayer(var_02,param_00);
	}
}

//Function Number: 44
addspawnsights(param_00,param_01)
{
	if(!maps\mp\_utility::is_true(param_00.trackplayersights))
	{
		return;
	}

	foreach(var_03 in param_00.fullsightspawns)
	{
		addfullsightspawnforplayer(var_03,param_01,gettime());
	}

	foreach(var_06 in param_00.cornersightspawns)
	{
		addcornersightspawnforplayer(var_06,param_01,gettime());
	}
}

//Function Number: 45
addfullsightspawnforplayer(param_00,param_01,param_02)
{
	if(!maps\mp\_utility::is_true(param_00.trackplayersights))
	{
		return;
	}

	param_01.spawnlogicteam = getspawnteam(param_01);
	param_00.fullsights[param_01.spawnlogicteam]++;
	var_03 = spawnstruct();
	var_03.player = param_01;
	var_03.time = param_02;
	var_03.team = param_01.spawnlogicteam;
	param_00.fullsightsplayers[param_01.guid] = var_03;
}

//Function Number: 46
addcornersightspawnforplayer(param_00,param_01,param_02)
{
	if(!maps\mp\_utility::is_true(param_00.trackplayersights))
	{
		return;
	}

	param_01.spawnlogicteam = getspawnteam(param_01);
	param_00.cornersights[param_01.spawnlogicteam]++;
	var_03 = spawnstruct();
	var_03.player = param_01;
	var_03.time = param_02;
	var_03.team = param_01.spawnlogicteam;
	param_00.cornersightsplayers[param_01.guid] = var_03;
}

//Function Number: 47
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

//Function Number: 48
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

		var_05 = spawnsighttrace(param_00,param_00.sighttracepoint,var_03.origin + (0,0,50),param_00.index);
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

//Function Number: 49
finalizespawnpointchoice(param_00)
{
	var_01 = gettime();
	self.lastspawnpoint = param_00;
	self.lastspawntime = var_01;
	param_00.lastspawntime = var_01;
	param_00.lastspawnteam = self.team;
	if(maps\mp\gametypes\_legacyspawnlogic::uselegacyspawning())
	{
		param_00.lastspawnedplayer = self;
		return;
	}

	removespawnsightsforplayer(self);
	addspawnsights(param_00,self);
}

//Function Number: 50
expandspawnpointbounds(param_00)
{
	var_01 = getspawnpointarray(param_00);
	for(var_02 = 0;var_02 < var_01.size;var_02++)
	{
		level.spawnmins = expandmins(level.spawnmins,var_01[var_02].origin);
		level.spawnmaxs = expandmaxs(level.spawnmaxs,var_01[var_02].origin);
	}
}

//Function Number: 51
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

//Function Number: 52
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

//Function Number: 53
findboxcenter(param_00,param_01)
{
	var_02 = (0,0,0);
	var_02 = param_01 - param_00;
	var_02 = (var_02[0] / 2,var_02[1] / 2,var_02[2] / 2) + param_00;
	return var_02;
}

//Function Number: 54
setmapcenterfordev()
{
	level.spawnmins = (0,0,0);
	level.spawnmaxs = (0,0,0);
	expandspawnpointbounds("mp_tdm_spawn_allies_start");
	expandspawnpointbounds("mp_tdm_spawn_axis_start");
	level.mapcenter = findboxcenter(level.spawnmins,level.spawnmaxs);
	setmapcenter(level.mapcenter);
}

//Function Number: 55
shoulduseteamstartspawn()
{
	return level.ingraceperiod && !isdefined(level.numkills) || level.numkills == 0;
}

//Function Number: 56
recon_set_spawnpoint(param_00)
{
	if(!isdefined(self.spawninfo))
	{
		self.spawninfo = spawnstruct();
	}

	self.spawninfo.spawnpoint = param_00;
}