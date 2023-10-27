/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes\_persistence.gsc
 * Game: Call of Duty: Black Ops 2
 * Platform: PC
 * Function Count: 26
 * Decompile Time: 62 ms
 * Timestamp: 10/27/2023 3:00:11 AM
*******************************************************************/

#include maps/mp/_challenges;
#include maps/mp/_medals;
#include maps/mp/_popups;
#include maps/mp/_scoreevents;
#include maps/mp/_utility;
#include maps/mp/bots/_bot;
#include maps/mp/gametypes/_class;
#include maps/mp/gametypes/_globallogic;
#include maps/mp/gametypes/_persistence;
#include maps/mp/gametypes/_rank;

//Function Number: 1
init()
{
	level.persistentdatainfo = [];
	level.maxrecentstats = 10;
	level.maxhitlocations = 19;
	maps/mp/gametypes/_class::init();
	maps/mp/gametypes/_rank::init();
	level thread maps/mp/_challenges::init();
	level thread maps/mp/_medals::init();
	level thread maps/mp/_scoreevents::init();
	maps/mp/_popups::init();
	level thread onplayerconnect();
	level thread initializestattracking();
	level thread uploadglobalstatcounters();
}

//Function Number: 2
onplayerconnect()
{
	for(;;)
	{
		level waittill("connected",player);
		player.enabletext = 1;
	}
}

//Function Number: 3
initializestattracking()
{
	level.globalexecutions = 0;
	level.globalchallenges = 0;
	level.globalsharepackages = 0;
	level.globalcontractsfailed = 0;
	level.globalcontractspassed = 0;
	level.globalcontractscppaid = 0;
	level.globalkillstreakscalled = 0;
	level.globalkillstreaksdestroyed = 0;
	level.globalkillstreaksdeathsfrom = 0;
	level.globallarryskilled = 0;
	level.globalbuzzkills = 0;
	level.globalrevives = 0;
	level.globalafterlifes = 0;
	level.globalcomebacks = 0;
	level.globalpaybacks = 0;
	level.globalbackstabs = 0;
	level.globalbankshots = 0;
	level.globalskewered = 0;
	level.globalteammedals = 0;
	level.globalfeetfallen = 0;
	level.globaldistancesprinted = 0;
	level.globaldembombsprotected = 0;
	level.globaldembombsdestroyed = 0;
	level.globalbombsdestroyed = 0;
	level.globalfraggrenadesfired = 0;
	level.globalsatchelchargefired = 0;
	level.globalshotsfired = 0;
	level.globalcrossbowfired = 0;
	level.globalcarsdestroyed = 0;
	level.globalbarrelsdestroyed = 0;
	level.globalbombsdestroyedbyteam = [];
	foreach(team in level.teams)
	{
		level.globalbombsdestroyedbyteam[team] = 0;
	}
}

//Function Number: 4
uploadglobalstatcounters()
{
	level waittill("game_ended");
	if(!level.rankedmatch && !level.wagermatch)
	{
		return;
	}

	totalkills = 0;
	totaldeaths = 0;
	totalassists = 0;
	totalheadshots = 0;
	totalsuicides = 0;
	totaltimeplayed = 0;
	totalflagscaptured = 0;
	totalflagsreturned = 0;
	totalhqsdestroyed = 0;
	totalhqscaptured = 0;
	totalsddefused = 0;
	totalsdplants = 0;
	totalhumiliations = 0;
	totalsabdestroyedbyteam = [];
	foreach(team in level.teams)
	{
		totalsabdestroyedbyteam[team] = 0;
	}

	switch(level.gametype)
	{
		case "dem":
			bombzonesleft = 0;
			index = 0;
			for(;;)
			{
				level.globaldembombsprotected++;
				level.globaldembombsdestroyed++;
				index++;
			}
	
			break;
	Stack-Empty ? index < level.bombzones.size : !IsDefined(level.bombzones[index].bombexploded) || !level.bombzones[index].bombexploded
			break;

		case "sab":
			_a117 = level.teams;
			_k117 = FirstArrayKey(_a117);
			for(;;)
			{
				team = _a117[_k117];
				totalsabdestroyedbyteam[team] = level.globalbombsdestroyedbyteam[team];
				_k117 = NextArrayKey(_a117);
			}
	
			break;
	_k117
	IsDefined(_k117)
			break;
	}

	players = get_players();
	for(i = 0;i < players.size;i++)
	{
		player = players[i];
		totaltimeplayed = totaltimeplayed + min(player.timeplayed["total"],level.timeplayedcap);
	}

	incrementcounter("global_executions",level.globalexecutions);
	incrementcounter("global_sharedpackagemedals",level.globalsharepackages);
	incrementcounter("global_dem_bombsdestroyed",level.globaldembombsdestroyed);
	incrementcounter("global_dem_bombsprotected",level.globaldembombsprotected);
	incrementcounter("global_contracts_failed",level.globalcontractsfailed);
	incrementcounter("global_killstreaks_called",level.globalkillstreakscalled);
	incrementcounter("global_killstreaks_destroyed",level.globalkillstreaksdestroyed);
	incrementcounter("global_killstreaks_deathsfrom",level.globalkillstreaksdeathsfrom);
	incrementcounter("global_buzzkills",level.globalbuzzkills);
	incrementcounter("global_revives",level.globalrevives);
	incrementcounter("global_afterlifes",level.globalafterlifes);
	incrementcounter("global_comebacks",level.globalcomebacks);
	incrementcounter("global_paybacks",level.globalpaybacks);
	incrementcounter("global_backstabs",level.globalbackstabs);
	incrementcounter("global_bankshots",level.globalbankshots);
	incrementcounter("global_skewered",level.globalskewered);
	incrementcounter("global_teammedals",level.globalteammedals);
	incrementcounter("global_fraggrenadesthrown",level.globalfraggrenadesfired);
	incrementcounter("global_c4thrown",level.globalsatchelchargefired);
	incrementcounter("global_shotsfired",level.globalshotsfired);
	incrementcounter("global_crossbowfired",level.globalcrossbowfired);
	incrementcounter("global_carsdestroyed",level.globalcarsdestroyed);
	incrementcounter("global_barrelsdestroyed",level.globalbarrelsdestroyed);
	incrementcounter("global_challenges_finished",level.globalchallenges);
	incrementcounter("global_contractscppaid",level.globalcontractscppaid);
	incrementcounter("global_distancesprinted100inches",int(level.globaldistancesprinted));
	incrementcounter("global_combattraining_botskilled",level.globallarryskilled);
	incrementcounter("global_distancefeetfallen",int(level.globalfeetfallen));
	incrementcounter("global_minutes",int(totaltimeplayed / 60));
	if(!(waslastround()))
	{
		return;
	}

	wait(0.05);
	players = get_players();
	for(i = 0;i < players.size;i++)
	{
		player = players[i];
		totalkills = totalkills + player.kills;
		totaldeaths = totaldeaths + player.deaths;
		totalassists = totalassists + player.assists;
		totalheadshots = totalheadshots + player.headshots;
		totalsuicides = totalsuicides + player.suicides;
		totalhumiliations = totalhumiliations + player.humiliated;
		totaltimeplayed = totaltimeplayed + int(min(player.timeplayed["alive"],level.timeplayedcap));
		switch(level.gametype)
		{
			case "ctf":
				totalflagscaptured = totalflagscaptured + player.captures;
				totalflagsreturned = totalflagsreturned + player.returns;
				break;

			case "koth":
				totalhqsdestroyed = totalhqsdestroyed + player.destructions;
				totalhqscaptured = totalhqscaptured + player.captures;
				break;

			case "sd":
				totalsddefused = totalsddefused + player.defuses;
				totalsdplants = totalsdplants + player.plants;
				break;

			case "sab":
				totalsabdestroyedbyteam[player.team] = totalsabdestroyedbyteam[player.team] + player.destructions;
				break;
	IsDefined(player.team) && IsDefined(level.teams[player.team])
				break;
		}
	}

	if(maps/mp/bots/_bot::is_bot_ranked_match())
	{
		incrementcounter("global_combattraining_gamesplayed",1);
	}

	incrementcounter("global_kills",totalkills);
	incrementcounter("global_deaths",totaldeaths);
	incrementcounter("global_assists",totalassists);
	incrementcounter("global_headshots",totalheadshots);
	incrementcounter("global_suicides",totalsuicides);
	incrementcounter("global_games",1);
	incrementcounter("global_ctf_flagscaptured",totalflagscaptured);
	incrementcounter("global_ctf_flagsreturned",totalflagsreturned);
	incrementcounter("global_hq_destroyed",totalhqsdestroyed);
	incrementcounter("global_hq_captured",totalhqscaptured);
	incrementcounter("global_snd_defuses",totalsddefused);
	incrementcounter("global_snd_plants",totalsdplants);
	incrementcounter("global_sab_destroyedbyops",totalsabdestroyedbyteam["allies"]);
	incrementcounter("global_sab_destroyedbycommunists",totalsabdestroyedbyteam["axis"]);
	incrementcounter("global_humiliations",totalhumiliations);
	if(IsDefined(game["wager_pot"]))
	{
		incrementcounter("global_wageredcp",game["wager_pot"]);
	}
}

//Function Number: 5
statgetwithgametype(dataname)
{
	if(IsDefined(level.nopersistence) && level.nopersistence)
	{
		return 0;
	}

	if(!(level.onlinegame))
	{
		return 0;
	}

	return self getdstat("PlayerStatsByGameType",getgametypename(),dataname,"StatValue");
}

//Function Number: 6
getgametypename()
{
	if(!(IsDefined(level.fullgametypename)))
	{
		if(IsDefined(level.hardcoremode) && level.hardcoremode && ispartygamemode() == 0)
		{
			prefix = "HC";
		}
		else
		{
			prefix = "";
		}

		level.fullgametypename = tolower(prefix + level.gametype);
	}

	return level.fullgametypename;
}

//Function Number: 7
ispartygamemode()
{
	switch(level.gametype)
	{
		case "gun":
		case "oic":
		case "sas":
		case "shrp":
			return 1;
	}

	return 0;
}

//Function Number: 8
isstatmodifiable(dataname)
{
	return level.rankedmatch || level.wagermatch;
}

//Function Number: 9
statsetwithgametype(dataname,value,incvalue)
{
	if(IsDefined(level.nopersistence) && level.nopersistence)
	{
		return 0;
	}

	if(!(isstatmodifiable(dataname)))
	{
		return;
	}

	if(level.disablestattracking)
	{
		return;
	}

	self setdstat("PlayerStatsByGameType",getgametypename(),dataname,"StatValue",value);
}

//Function Number: 10
adjustrecentstats()
{
/#
GetDvarInt(#"7AEF62D7") == 1 || GetDvarInt(#"1F8C9394") == 1
#/
	initializematchstats();
}

//Function Number: 11
getrecentstat(isglobal,index,statname)
{
	if(level.wagermatch)
	{
		return self getdstat("RecentEarnings",index,statname);
	}
	else if(isglobal)
	{
		modename = maps/mp/gametypes/_globallogic::getcurrentgamemode();
		return self getdstat("gameHistory",modename,"matchHistory",index,statname);
	}
	else
	{
		return self getdstat("PlayerStatsByGameType",getgametypename(),"prevScores",index,statname);
	}
}

//Function Number: 12
setrecentstat(isglobal,index,statname,value)
{
	if(IsDefined(level.nopersistence) && level.nopersistence)
	{
		return;
	}

	if(!(level.onlinegame))
	{
		return;
	}

	if(!(isstatmodifiable(statname)))
	{
		return;
	}

	if(index < 0 || index > 9)
	{
		return;
	}

	if(level.wagermatch)
	{
		self setdstat("RecentEarnings",index,statname,value);
	}
	else if(isglobal)
	{
		modename = maps/mp/gametypes/_globallogic::getcurrentgamemode();
		self setdstat("gameHistory",modename,"matchHistory","" + index,statname,value);
		return;
	}
	else
	{
		self setdstat("PlayerStatsByGameType",getgametypename(),"prevScores",index,statname,value);
	}
}

//Function Number: 13
addrecentstat(isglobal,index,statname,value)
{
	if(IsDefined(level.nopersistence) && level.nopersistence)
	{
		return;
	}

	if(!(level.onlinegame))
	{
		return;
	}

	if(!(isstatmodifiable(statname)))
	{
		return;
	}

	currstat = getrecentstat(isglobal,index,statname);
	setrecentstat(isglobal,index,statname,currstat + value);
}

//Function Number: 14
setmatchhistorystat(statname,value)
{
	modename = maps/mp/gametypes/_globallogic::getcurrentgamemode();
	historyindex = self getdstat("gameHistory",modename,"currentMatchHistoryIndex");
	setrecentstat(1,historyindex,statname,value);
}

//Function Number: 15
addmatchhistorystat(statname,value)
{
	modename = maps/mp/gametypes/_globallogic::getcurrentgamemode();
	historyindex = self getdstat("gameHistory",modename,"currentMatchHistoryIndex");
	addrecentstat(1,historyindex,statname,value);
}

//Function Number: 16
initializematchstats()
{
	if(IsDefined(level.nopersistence) && level.nopersistence)
	{
		return;
	}

	if(!(level.onlinegame))
	{
		return;
	}

	if(!(level.rankedmatch || level.wagermatch || level.leaguematch))
	{
		return;
	}

	self.pers["lastHighestScore"] = self getdstat("HighestStats","highest_score");
	currgametype = maps/mp/gametypes/_persistence::getgametypename();
	self gamehistorystartmatch(getgametypeenumfromname(currgametype,level.hardcoremode));
}

//Function Number: 17
setafteractionreportstat(statname,value,index)
{
	if(self is_bot())
	{
		return;
	}

/#
GetDvarInt(#"7AEF62D7") == 1 || GetDvarInt(#"1F8C9394") == 1
#/
	if(level.rankedmatch || level.wagermatch || level.leaguematch)
	{
		if(IsDefined(index))
		{
			self setdstat("AfterActionReportStats",statname,index,value);
		}
		else
		{
			self setdstat("AfterActionReportStats",statname,value);
		}
	}
}

//Function Number: 18
codecallback_challengecomplete(rewardxp,maxval,row,tablenumber,challengetype,itemindex,challengeindex)
{
	self luinotifyevent(&"challenge_complete",7,challengeindex,itemindex,challengetype,tablenumber,row,maxval,rewardxp);
	self luinotifyeventtospectators(&"challenge_complete",7,challengeindex,itemindex,challengetype,tablenumber,row,maxval,rewardxp);
}

//Function Number: 19
codecallback_gunchallengecomplete(rewardxp,attachmentindex,itemindex,rankid)
{
	self luinotifyevent(&"gun_level_complete",4,rankid,itemindex,attachmentindex,rewardxp);
	self luinotifyeventtospectators(&"gun_level_complete",4,rankid,itemindex,attachmentindex,rewardxp);
}

//Function Number: 20
checkcontractexpirations()
{
}

//Function Number: 21
incrementcontracttimes(timeinc)
{
}

//Function Number: 22
addcontracttoqueue(index,passed)
{
}

//Function Number: 23
uploadstatssoon()
{
	self notify("upload_stats_soon");
	self endon("upload_stats_soon");
	self endon("disconnect");
	wait(1);
	uploadstats(self);
}

//Function Number: 24
codecallback_onaddplayerstat(dataname,value)
{
}

//Function Number: 25
codecallback_onaddweaponstat(weapname,dataname,value)
{
}

//Function Number: 26
processcontractsonaddstat(stattype,dataname,value,weapname)
{
}