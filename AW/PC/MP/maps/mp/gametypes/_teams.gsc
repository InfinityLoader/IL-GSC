/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps/mp/gametypes/_teams.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 49
 * Decompile Time: 780 ms
 * Timestamp: 10/27/2023 1:51:09 AM
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
trackplayedtime()
{
	self endon("disconnect");
	lootservicestarttrackingplaytime(self.xuid);
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

		wait(1);
	}
}

//Function Number: 8
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

//Function Number: 9
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

//Function Number: 10
updateteamtime()
{
	if(game["state"] != "playing")
	{
		return;
	}

	self.pers["teamTime"] = gettime();
}

//Function Number: 11
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

//Function Number: 12
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

//Function Number: 13
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

//Function Number: 14
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

//Function Number: 15
setghilliemodels(param_00)
{
}

//Function Number: 16
setteammodels(param_00,param_01)
{
}

//Function Number: 17
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

//Function Number: 18
playercostume()
{
	if(isagent(self) && !getdvarint("virtualLobbyActive",0))
	{
		return 1;
	}

	self setcostumemodels(self.costume);
	if(isdefined(self.perks) && !getdvarint("virtualLobbyActive",0))
	{
		if(maps\mp\_utility::_hasperk("specialty_exo_shoulderlauncher"))
		{
			if(!maps\mp\_utility::_hasperk("specialty_wildcard_dualtacticals"))
			{
				self attach("npc_exo_launcher_base_L","",1);
			}

			if(maps\mp\_utility::_hasperk("specialty_wildcard_duallethals"))
			{
				self attach("npc_exo_launcher_base_R","",1);
			}
		}
		else
		{
			if(!maps\mp\_utility::_hasperk("specialty_wildcard_dualtacticals") || maps\mp\_utility::isgrapplinghookgamemode())
			{
				self attach("npc_exo_arm_launcher_L","J_Elbow_LE",1);
			}

			if(maps\mp\_utility::_hasperk("specialty_wildcard_duallethals"))
			{
				self attach("npc_exo_arm_launcher_R","J_Elbow_RI",1);
			}
		}
	}

	self.voice = "american";
	self setclothtype("vestlight");
	return 1;
}

//Function Number: 19
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

//Function Number: 20
getdefaultcostume()
{
	var_00 = randomcostume();
	return var_00;
}

//Function Number: 21
getpracticeroundcostume()
{
	if(!isdefined(level.practice_round_costume))
	{
		level.practice_round_max_costumes = tablegetcolumncount(level.practiceroundcostumetablename) - 1;
		level.practice_round_costume = randomint(level.practice_round_max_costumes);
	}

	var_00 = 0;
	for(var_01 = 0;var_01 < level.players.size;var_01++)
	{
		if(level.players[var_01] == self)
		{
			var_00 = var_01;
			break;
		}
	}

	var_02 = level.practice_round_costume + var_00 % level.practice_round_max_costumes;
	var_03 = getcostumefromtable(level.practiceroundcostumetablename,var_02 + 1);
	return var_03;
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
playermodelforweapon(param_00,param_01)
{
	var_02 = self.team;
	var_03 = playercostume();
	self notify("player_model_set");
}

//Function Number: 24
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

//Function Number: 25
trackfreeplayedtime()
{
	self endon("disconnect");
	lootservicestarttrackingplaytime(self.xuid);
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

		wait(1);
	}
}

//Function Number: 26
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

//Function Number: 27
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

//Function Number: 28
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

	return 0;
}

//Function Number: 29
onplayerspawned()
{
	level endon("game_ended");
	self waittill("spawned_player");
}

//Function Number: 30
mt_getteamname(param_00)
{
	return tablelookupistring("mp/MTTable.csv",0,param_00,1);
}

//Function Number: 31
mt_getteamicon(param_00)
{
	return tablelookup("mp/MTTable.csv",0,param_00,2);
}

//Function Number: 32
mt_getteamheadicon(param_00)
{
	return tablelookup("mp/MTTable.csv",0,param_00,3);
}

//Function Number: 33
getteamname(param_00)
{
	return tablelookupistring("mp/factionTable.csv",0,game[param_00],1);
}

//Function Number: 34
getteamshortname(param_00)
{
	return tablelookupistring("mp/factionTable.csv",0,game[param_00],2);
}

//Function Number: 35
getteamforfeitedstring(param_00)
{
	return tablelookupistring("mp/factionTable.csv",0,game[param_00],4);
}

//Function Number: 36
getteameliminatedstring(param_00)
{
	return tablelookupistring("mp/factionTable.csv",0,game[param_00],3);
}

//Function Number: 37
getteamicon(param_00)
{
	return tablelookup("mp/factionTable.csv",0,game[param_00],5);
}

//Function Number: 38
getteamhudicon(param_00)
{
	return tablelookup("mp/factionTable.csv",0,game[param_00],6);
}

//Function Number: 39
getteamheadicon(param_00)
{
	return tablelookup("mp/factionTable.csv",0,game[param_00],17);
}

//Function Number: 40
getteamvoiceprefix(param_00)
{
	return tablelookup("mp/factionTable.csv",0,game[param_00],7);
}

//Function Number: 41
getteamspawnmusic(param_00)
{
	return tablelookup("mp/factionTable.csv",0,game[param_00],8);
}

//Function Number: 42
getteamwinmusic(param_00)
{
	return tablelookup("mp/factionTable.csv",0,game[param_00],9);
}

//Function Number: 43
getteamflagmodel(param_00)
{
	return tablelookup("mp/factionTable.csv",0,game[param_00],10);
}

//Function Number: 44
getteamflagcarrymodel(param_00)
{
	return tablelookup("mp/factionTable.csv",0,game[param_00],11);
}

//Function Number: 45
getteamflagicon(param_00)
{
	return tablelookup("mp/factionTable.csv",0,game[param_00],12);
}

//Function Number: 46
getteamflagfx(param_00)
{
	return tablelookup("mp/factionTable.csv",0,game[param_00],13);
}

//Function Number: 47
getteamcolor(param_00)
{
	return (maps\mp\_utility::stringtofloat(tablelookup("mp/factionTable.csv",0,game[param_00],14)),maps\mp\_utility::stringtofloat(tablelookup("mp/factionTable.csv",0,game[param_00],15)),maps\mp\_utility::stringtofloat(tablelookup("mp/factionTable.csv",0,game[param_00],16)));
}

//Function Number: 48
getteamcratemodel(param_00)
{
	return tablelookup("mp/factionTable.csv",0,game[param_00],18);
}

//Function Number: 49
getteamdeploymodel(param_00)
{
	return tablelookup("mp/factionTable.csv",0,game[param_00],19);
}