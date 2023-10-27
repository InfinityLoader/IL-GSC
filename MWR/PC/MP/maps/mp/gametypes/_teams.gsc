/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes\_teams.gsc
 * Game: Call of Duty: Modern Warfare Remastered
 * Platform: PC
 * Function Count: 73
 * Decompile Time: 1275 ms
 * Timestamp: 10/27/2023 2:42:15 AM
*******************************************************************/

//Function Number: 1
init()
{
	initscoreboard();
	level.teambalance = getdvarint("scr_teambalance");
	level.maxclients = getdvarint("sv_maxclients");
	setplayermodels();
	level.freeplayers = [];
	if(level.teambased)
	{
		level thread onplayerconnect();
		level thread updateteambalance();
		wait(0.15);
		level thread updateplayertimes();
		return;
	}

	level thread onfreeplayerconnect();
	wait(0.15);
	level thread updatefreeplayertimes();
}

//Function Number: 2
initscoreboard()
{
	if(maps\mp\_utility::invirtuallobby())
	{
		return;
	}

	setdvar("g_TeamName_Allies",getteamshortname("allies"));
	setdvar("g_TeamIcon_Allies",getteamicon("allies"));
	setdvar("g_TeamIcon_MyAllies",getteamicon("allies"));
	setdvar("g_TeamIcon_EnemyAllies",getteamicon("allies"));
	var_00 = getteamcolor("allies");
	setdvar("g_ScoresColor_Allies",var_00[0] + " " + var_00[1] + " " + var_00[2]);
	setdvar("g_TeamName_Axis",getteamshortname("axis"));
	setdvar("g_TeamIcon_Axis",getteamicon("axis"));
	setdvar("g_TeamIcon_MyAxis",getteamicon("axis"));
	setdvar("g_TeamIcon_EnemyAxis",getteamicon("axis"));
	var_00 = getteamcolor("axis");
	setdvar("g_ScoresColor_Axis",var_00[0] + " " + var_00[1] + " " + var_00[2]);
	setdvar("g_ScoresColor_Spectator",".25 .25 .25");
	setdvar("g_ScoresColor_Free",".76 .78 .10");
	setdvar("g_teamTitleColor_MyTeam",".6 .8 .6");
	setdvar("g_teamTitleColor_EnemyTeam","1 .45 .5");
}

//Function Number: 3
onplayerconnect()
{
	for(;;)
	{
		level waittill("connected",var_00);
		var_00 thread onjoinedteam();
		var_00 thread onjoinedspectators();
		var_00 thread onplayerspawned();
		var_00 thread trackplayedtime();
	}
}

//Function Number: 4
onfreeplayerconnect()
{
	for(;;)
	{
		level waittill("connected",var_00);
		var_00 thread trackfreeplayedtime();
	}
}

//Function Number: 5
onjoinedteam()
{
	self endon("disconnect");
	for(;;)
	{
		self waittill("joined_team");
		updateteamtime();
	}
}

//Function Number: 6
onjoinedspectators()
{
	self endon("disconnect");
	for(;;)
	{
		self waittill("joined_spectators");
		self.pers["teamTime"] = undefined;
	}
}

//Function Number: 7
updateinpartywithotherplayers()
{
	if(!isai(self) && maps\mp\_utility::matchmakinggame())
	{
		var_00 = function_0309(self.xuid);
		if(!isdefined(self.inpartywithotherplayers) || var_00 != self.inpartywithotherplayers)
		{
		}

		self.inpartywithotherplayers = var_00;
	}
}

//Function Number: 8
trackplayedtime()
{
	self endon("disconnect");
	lootservicestarttrackingplaytime(self.xuid);
	updateinpartywithotherplayers();
	self.timeplayed["allies"] = 0;
	self.timeplayed["axis"] = 0;
	self.timeplayed["other"] = 0;
	maps\mp\_utility::gameflagwait("prematch_done");
	for(;;)
	{
		if(game["state"] == "playing")
		{
			if(self.sessionteam == "allies")
			{
				self.timeplayed["allies"]++;
				self.timeplayed["total"]++;
			}
			else if(self.sessionteam == "axis")
			{
				self.timeplayed["axis"]++;
				self.timeplayed["total"]++;
			}
			else if(self.sessionteam == "spectator")
			{
				self.timeplayed["other"]++;
			}
		}

		if(!maps\mp\_utility::is_true(self.inpartywithotherplayers))
		{
			updateinpartywithotherplayers();
		}

		wait(1);
	}
}

//Function Number: 9
updateplayertimes()
{
	if(!level.rankedmatch)
	{
		return;
	}

	level endon("game_ended");
	for(;;)
	{
		maps\mp\gametypes\_hostmigration::waittillhostmigrationdone();
		foreach(var_01 in level.players)
		{
			var_01 updateplayedtime();
		}

		wait(1);
	}
}

//Function Number: 10
updateplayedtime()
{
	if(isai(self))
	{
		return;
	}

	if(!maps\mp\_utility::rankingenabled())
	{
		return;
	}

	if(self.timeplayed["allies"])
	{
		maps\mp\gametypes\_persistence::stataddbuffered("timePlayedAllies",self.timeplayed["allies"]);
		maps\mp\gametypes\_persistence::stataddbuffered("timePlayedTotal",self.timeplayed["allies"]);
		maps\mp\gametypes\_persistence::stataddchildbuffered("round","timePlayed",self.timeplayed["allies"]);
	}

	if(self.timeplayed["axis"])
	{
		maps\mp\gametypes\_persistence::stataddbuffered("timePlayedOpfor",self.timeplayed["axis"]);
		maps\mp\gametypes\_persistence::stataddbuffered("timePlayedTotal",self.timeplayed["axis"]);
		maps\mp\gametypes\_persistence::stataddchildbuffered("round","timePlayed",self.timeplayed["axis"]);
	}

	if(self.timeplayed["other"])
	{
		maps\mp\gametypes\_persistence::stataddbuffered("timePlayedOther",self.timeplayed["other"]);
		maps\mp\gametypes\_persistence::stataddbuffered("timePlayedTotal",self.timeplayed["other"]);
		maps\mp\gametypes\_persistence::stataddchildbuffered("round","timePlayed",self.timeplayed["other"]);
	}

	if(game["state"] == "postgame")
	{
		return;
	}

	self.timeplayed["allies"] = 0;
	self.timeplayed["axis"] = 0;
	self.timeplayed["other"] = 0;
}

//Function Number: 11
updateteamtime()
{
	if(game["state"] != "playing")
	{
		return;
	}

	self.pers["teamTime"] = gettime();
}

//Function Number: 12
updateteambalancedvar()
{
	for(;;)
	{
		var_00 = getdvarint("scr_teambalance");
		if(level.teambalance != var_00)
		{
			level.teambalance = getdvarint("scr_teambalance");
		}

		wait(1);
	}
}

//Function Number: 13
updateteambalance()
{
	level.teamlimit = level.maxclients / 2;
	level thread updateteambalancedvar();
	wait(0.15);
	if(level.teambalance && maps\mp\_utility::isroundbased())
	{
		if(isdefined(game["BalanceTeamsNextRound"]))
		{
			iprintlnbold(&"MP_AUTOBALANCE_NEXT_ROUND");
		}

		level waittill("restarting");
		if(isdefined(game["BalanceTeamsNextRound"]))
		{
			level balanceteams();
			game["BalanceTeamsNextRound"] = undefined;
			return;
		}

		if(!getteambalance())
		{
			game["BalanceTeamsNextRound"] = 1;
			return;
		}

		return;
	}

	level endon("game_ended");
	for(;;)
	{
		if(level.teambalance)
		{
			if(!getteambalance())
			{
				iprintlnbold(&"MP_AUTOBALANCE_SECONDS",15);
				wait(15);
				if(!getteambalance())
				{
					level balanceteams();
				}
			}

			wait(59);
		}

		wait(1);
	}
}

//Function Number: 14
getteambalance()
{
	level.team["allies"] = 0;
	level.team["axis"] = 0;
	var_00 = level.players;
	for(var_01 = 0;var_01 < var_00.size;var_01++)
	{
		if(isdefined(var_00[var_01].pers["team"]) && var_00[var_01].pers["team"] == "allies")
		{
			level.team["allies"]++;
			continue;
		}

		if(isdefined(var_00[var_01].pers["team"]) && var_00[var_01].pers["team"] == "axis")
		{
			level.team["axis"]++;
		}
	}

	if(level.team["allies"] > level.team["axis"] + level.teambalance || level.team["axis"] > level.team["allies"] + level.teambalance)
	{
		return 0;
	}

	return 1;
}

//Function Number: 15
balanceteams()
{
	iprintlnbold(game["strings"]["autobalance"]);
	var_00 = [];
	var_01 = [];
	var_02 = level.players;
	for(var_03 = 0;var_03 < var_02.size;var_03++)
	{
		if(!isdefined(var_02[var_03].pers["teamTime"]))
		{
			continue;
		}

		if(isdefined(var_02[var_03].pers["team"]) && var_02[var_03].pers["team"] == "allies")
		{
			var_00[var_00.size] = var_02[var_03];
			continue;
		}

		if(isdefined(var_02[var_03].pers["team"]) && var_02[var_03].pers["team"] == "axis")
		{
			var_01[var_01.size] = var_02[var_03];
		}
	}

	var_04 = undefined;
	while(var_00.size > var_01.size + 1 || var_01.size > var_00.size + 1)
	{
		if(var_00.size > var_01.size + 1)
		{
			for(var_05 = 0;var_05 < var_00.size;var_05++)
			{
				if(isdefined(var_00[var_05].dont_auto_balance))
				{
					continue;
				}

				if(!isdefined(var_04))
				{
					var_04 = var_00[var_05];
					continue;
				}

				if(var_00[var_05].pers["teamTime"] > var_04.pers["teamTime"])
				{
					var_04 = var_00[var_05];
				}
			}

			var_04 [[ level.onteamselection ]]("axis");
		}
		else if(var_01.size > var_00.size + 1)
		{
			for(var_05 = 0;var_05 < var_01.size;var_05++)
			{
				if(isdefined(var_01[var_05].dont_auto_balance))
				{
					continue;
				}

				if(!isdefined(var_04))
				{
					var_04 = var_01[var_05];
					continue;
				}

				if(var_01[var_05].pers["teamTime"] > var_04.pers["teamTime"])
				{
					var_04 = var_01[var_05];
				}
			}

			var_04 [[ level.onteamselection ]]("allies");
		}

		var_04 = undefined;
		var_00 = [];
		var_01 = [];
		var_02 = level.players;
		for(var_03 = 0;var_03 < var_02.size;var_03++)
		{
			if(isdefined(var_02[var_03].pers["team"]) && var_02[var_03].pers["team"] == "allies")
			{
				var_00[var_00.size] = var_02[var_03];
				continue;
			}

			if(isdefined(var_02[var_03].pers["team"]) && var_02[var_03].pers["team"] == "axis")
			{
				var_01[var_01.size] = var_02[var_03];
			}
		}
	}
}

//Function Number: 16
setghilliemodels(param_00)
{
}

//Function Number: 17
setteammodels(param_00,param_01)
{
}

//Function Number: 18
setplayermodels()
{
	if(level.multiteambased)
	{
		for(var_00 = 0;var_00 < level.teamnamelist.size;var_00++)
		{
			setteammodels(level.teamnamelist[var_00],game[level.teamnamelist[var_00]]);
		}
	}
	else
	{
		setteammodels("allies",game["allies"]);
		setteammodels("axis",game["axis"]);
	}

	setghilliemodels(getmapcustom("environment"));
}

//Function Number: 19
playercostume(param_00,param_01,param_02)
{
	if(isagent(self) && !getdvarint("virtualLobbyActive",0))
	{
		return 1;
	}

	if(isdefined(param_00))
	{
		param_00 = maps\mp\_utility::getbaseweaponname(param_00) + "_mp";
	}

	self method_84B6(self.costume,param_00,param_01,param_02);
	self.voice = "american";
	self setclothtype("vestlight");
	return 1;
}

//Function Number: 20
validcostume(param_00)
{
	if(!isdefined(param_00))
	{
		return 0;
	}

	var_01 = validatecostume(param_00);
	for(var_02 = 0;var_02 < param_00.size;var_02++)
	{
		if(param_00[var_02] != var_01[var_02])
		{
			return 0;
		}
	}

	return 1;
}

//Function Number: 21
getdefaultcostume()
{
	var_00 = randomcostume();
	return var_00;
}

//Function Number: 22
gethardcorecostume()
{
	var_00 = 2;
	if(self.pers["team"] == "axis")
	{
		var_00 = 1;
	}

	var_01 = getcostumefromtable(level.hardcorecostumetablename,var_00);
	return var_01;
}

//Function Number: 23
verifycostume()
{
	if(!validcostume(self.costume))
	{
		if(isdefined(self.sessioncostume) && validcostume(self.sessioncostume))
		{
			self.costume = self.sessioncostume;
			return;
		}

		self.costume = getdefaultcostume();
		if(isplayer(self))
		{
			maps\mp\gametypes\_class::cao_setactivecostume(self.costume);
		}

		self.sessioncostume = self.costume;
	}
}

//Function Number: 24
applycostume(param_00,param_01,param_02)
{
	verifycostume();
	var_03 = playercostume(param_00,param_01,param_02);
	self notify("player_model_set");
}

//Function Number: 25
countplayers()
{
	var_00 = [];
	for(var_01 = 0;var_01 < level.teamnamelist.size;var_01++)
	{
		var_00[level.teamnamelist[var_01]] = 0;
	}

	for(var_01 = 0;var_01 < level.players.size;var_01++)
	{
		if(level.players[var_01] == self)
		{
			continue;
		}

		if(level.players[var_01].pers["team"] == "spectator")
		{
			continue;
		}

		if(isdefined(level.players[var_01].pers["team"]))
		{
			var_00[level.players[var_01].pers["team"]]++;
		}
	}

	return var_00;
}

//Function Number: 26
trackfreeplayedtime()
{
	self endon("disconnect");
	lootservicestarttrackingplaytime(self.xuid);
	updateinpartywithotherplayers();
	self.timeplayed["allies"] = 0;
	self.timeplayed["axis"] = 0;
	self.timeplayed["other"] = 0;
	for(;;)
	{
		if(game["state"] == "playing")
		{
			if(isdefined(self.pers["team"]) && self.pers["team"] == "allies" && self.sessionteam != "spectator")
			{
				self.timeplayed["allies"]++;
				self.timeplayed["total"]++;
			}
			else if(isdefined(self.pers["team"]) && self.pers["team"] == "axis" && self.sessionteam != "spectator")
			{
				self.timeplayed["axis"]++;
				self.timeplayed["total"]++;
			}
			else
			{
				self.timeplayed["other"]++;
			}
		}

		if(!maps\mp\_utility::is_true(self.inpartywithotherplayers))
		{
			updateinpartywithotherplayers();
		}

		wait(1);
	}
}

//Function Number: 27
updatefreeplayertimes()
{
	if(!level.rankedmatch)
	{
		return;
	}

	var_00 = 0;
	for(;;)
	{
		var_00++;
		if(var_00 >= level.players.size)
		{
			var_00 = 0;
		}

		if(isdefined(level.players[var_00]))
		{
			level.players[var_00] updatefreeplayedtime();
		}

		wait(1);
	}
}

//Function Number: 28
updatefreeplayedtime()
{
	if(!maps\mp\_utility::rankingenabled())
	{
		return;
	}

	if(isai(self))
	{
		return;
	}

	if(self.timeplayed["allies"])
	{
		maps\mp\gametypes\_persistence::stataddbuffered("timePlayedAllies",self.timeplayed["allies"]);
		maps\mp\gametypes\_persistence::stataddbuffered("timePlayedTotal",self.timeplayed["allies"]);
		maps\mp\gametypes\_persistence::stataddchildbuffered("round","timePlayed",self.timeplayed["allies"]);
	}

	if(self.timeplayed["axis"])
	{
		maps\mp\gametypes\_persistence::stataddbuffered("timePlayedOpfor",self.timeplayed["axis"]);
		maps\mp\gametypes\_persistence::stataddbuffered("timePlayedTotal",self.timeplayed["axis"]);
		maps\mp\gametypes\_persistence::stataddchildbuffered("round","timePlayed",self.timeplayed["axis"]);
	}

	if(self.timeplayed["other"])
	{
		maps\mp\gametypes\_persistence::stataddbuffered("timePlayedOther",self.timeplayed["other"]);
		maps\mp\gametypes\_persistence::stataddbuffered("timePlayedTotal",self.timeplayed["other"]);
		maps\mp\gametypes\_persistence::stataddchildbuffered("round","timePlayed",self.timeplayed["other"]);
	}

	if(game["state"] == "postgame")
	{
		return;
	}

	self.timeplayed["allies"] = 0;
	self.timeplayed["axis"] = 0;
	self.timeplayed["other"] = 0;
}

//Function Number: 29
getjointeampermissions(param_00)
{
	if(maps\mp\_utility::iscoop())
	{
		return 1;
	}

	var_01 = 0;
	var_02 = 0;
	var_03 = level.players;
	for(var_04 = 0;var_04 < var_03.size;var_04++)
	{
		var_05 = var_03[var_04];
		if(isdefined(var_05.pers["team"]) && var_05.pers["team"] == param_00)
		{
			var_01++;
			if(isbot(var_05))
			{
				var_02++;
			}
		}
	}

	if(var_01 < level.teamlimit)
	{
		return 1;
	}

	if(var_02 > 0)
	{
		return 1;
	}

	if(level.gametype == "infect")
	{
		return 1;
	}

	if(maps\mp\_utility::ishodgepodgemm())
	{
		return 1;
	}

	return 0;
}

//Function Number: 30
onplayerspawned()
{
	level endon("game_ended");
	self waittill("spawned_player");
}

//Function Number: 31
mt_getteamname(param_00)
{
	return tablelookupistring("mp/MTTable.csv",0,param_00,1);
}

//Function Number: 32
mt_getteamicon(param_00)
{
	return tablelookup("mp/MTTable.csv",0,param_00,2);
}

//Function Number: 33
mt_getteamheadicon(param_00)
{
	return tablelookup("mp/MTTable.csv",0,param_00,3);
}

//Function Number: 34
getteamnamecol()
{
	return 1;
}

//Function Number: 35
getteamname(param_00)
{
	return factiontableistringlookup(param_00,getteamnamecol());
}

//Function Number: 36
getteamshortnamecol()
{
	return 2;
}

//Function Number: 37
getteamshortname(param_00)
{
	return factiontableistringlookup(param_00,getteamshortnamecol());
}

//Function Number: 38
getteamforfeitedstringcol()
{
	return 4;
}

//Function Number: 39
getteamforfeitedstring(param_00)
{
	return factiontableistringlookup(param_00,getteamforfeitedstringcol());
}

//Function Number: 40
getteameliminatedstringcol()
{
	return 3;
}

//Function Number: 41
getteameliminatedstring(param_00)
{
	return factiontableistringlookup(param_00,getteameliminatedstringcol());
}

//Function Number: 42
getteamiconcol()
{
	return 5;
}

//Function Number: 43
getteamicon(param_00)
{
	return factiontablelookup(param_00,getteamiconcol());
}

//Function Number: 44
getteamhudiconcol()
{
	return 6;
}

//Function Number: 45
getteamhudicon(param_00)
{
	return factiontablelookup(param_00,getteamhudiconcol());
}

//Function Number: 46
getteamheadiconcol()
{
	return 17;
}

//Function Number: 47
getteamheadicon(param_00)
{
	return factiontablelookup(param_00,getteamheadiconcol());
}

//Function Number: 48
getteamvoiceprefixcol()
{
	return 7;
}

//Function Number: 49
getteamvoiceprefix(param_00)
{
	return factiontablelookup(param_00,getteamvoiceprefixcol());
}

//Function Number: 50
getteamspawnmusiccol()
{
	return 8;
}

//Function Number: 51
getteamspawnmusic(param_00)
{
	return factiontablelookup(param_00,getteamspawnmusiccol());
}

//Function Number: 52
getteamwinmusiccol()
{
	return 9;
}

//Function Number: 53
getteamwinmusic(param_00)
{
	return factiontablelookup(param_00,getteamwinmusiccol());
}

//Function Number: 54
getteamflagmodelcol()
{
	return 10;
}

//Function Number: 55
getteamflagmodel(param_00)
{
	return factiontablelookup(param_00,getteamflagmodelcol());
}

//Function Number: 56
getteamflagcarrymodelcol()
{
	return 11;
}

//Function Number: 57
getteamflagcarrymodel(param_00)
{
	return factiontablelookup(param_00,getteamflagcarrymodelcol());
}

//Function Number: 58
getteamflagiconcol()
{
	return 12;
}

//Function Number: 59
getteamflagicon(param_00)
{
	return factiontablelookup(param_00,getteamflagiconcol());
}

//Function Number: 60
getteamflagfxcol()
{
	return 13;
}

//Function Number: 61
getteamflagfx(param_00)
{
	return factiontablelookup(param_00,getteamflagfxcol());
}

//Function Number: 62
getteamcolorredcol()
{
	return 14;
}

//Function Number: 63
getteamcolorgreencol()
{
	return 15;
}

//Function Number: 64
getteamcolorbluecol()
{
	return 16;
}

//Function Number: 65
getteamcolor(param_00)
{
	return (maps\mp\_utility::stringtofloat(factiontablelookup(param_00,getteamcolorredcol())),maps\mp\_utility::stringtofloat(factiontablelookup(param_00,getteamcolorgreencol())),maps\mp\_utility::stringtofloat(factiontablelookup(param_00,getteamcolorbluecol())));
}

//Function Number: 66
getteamcratemodelcol()
{
	return 18;
}

//Function Number: 67
getteamcratemodel(param_00)
{
	return factiontablelookup(param_00,getteamcratemodelcol());
}

//Function Number: 68
getteamdeploymodelcol()
{
	return 19;
}

//Function Number: 69
getteamdeploymodel(param_00)
{
	return factiontablelookup(param_00,getteamdeploymodelcol());
}

//Function Number: 70
setfactiontableoverride(param_00,param_01,param_02)
{
	if(!isdefined(level.factiontableoverrides))
	{
		level.factiontableoverrides = [];
	}

	if(!isdefined(level.factiontableoverrides[param_00]))
	{
		level.factiontableoverrides[param_00] = [];
	}

	level.factiontableoverrides[param_00][param_01] = param_02;
}

//Function Number: 71
getfactiontableoverride(param_00,param_01)
{
	var_02 = game[param_00];
	if(isdefined(level.factiontableoverrides) && isdefined(level.factiontableoverrides[var_02]))
	{
		return level.factiontableoverrides[var_02][param_01];
	}

	return undefined;
}

//Function Number: 72
factiontablelookup(param_00,param_01)
{
	var_02 = getfactiontableoverride(param_00,param_01);
	if(isdefined(var_02))
	{
		return var_02;
	}

	return tablelookup("mp/factionTable.csv",0,game[param_00],param_01);
}

//Function Number: 73
factiontableistringlookup(param_00,param_01)
{
	var_02 = getfactiontableoverride(param_00,param_01);
	if(isdefined(var_02))
	{
		return var_02;
	}

	return tablelookupistring("mp/factionTable.csv",0,game[param_00],param_01);
}