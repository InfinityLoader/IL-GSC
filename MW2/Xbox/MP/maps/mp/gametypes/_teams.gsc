/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes\_teams.gsc
 * Game: Call of Duty: Modern Warfare 2
 * Platform: Xbox
*******************************************************************/

init()
{
	initscoreboard();
	if(!level.console)
	{
		game["strings"]["autobalance"] = &"MP_AUTOBALANCE_NOW";
		precachestring(&"MP_AUTOBALANCE_NOW");
		precachestring(&"MP_AUTOBALANCE_NEXT_ROUND");
		precachestring(&"MP_AUTOBALANCE_SECONDS");
	}

	level.teambalance = getdvarint("scr_teambalance");
	level.maxclients = getdvarint("sv_maxclients");
	level._effect["thermal_beacon"] = loadfx("misc/thermal_beacon_inverted");
	effect = level._effect["thermal_beacon"];
	precachefxteamthermal(effect, "J_Spine4");
	setplayermodels();
	level.freeplayers = [];
	if(level.teambased)
	{
		level thread onplayerconnect();
		level thread updateteambalance();
		wait 0.15;
		level thread updateplayertimes();
		return;
	}

	level thread onfreeplayerconnect();
	wait 0.15;
	level thread updatefreeplayertimes();
}

initscoreboard()
{
	setdvar("g_TeamName_Allies", getteamshortname("allies"));
	setdvar("g_TeamIcon_Allies", getteamicon("allies"));
	setdvar("g_TeamIcon_MyAllies", getteamicon("allies"));
	setdvar("g_TeamIcon_EnemyAllies", getteamicon("allies"));
	scorecolor = getteamcolor("allies");
	setdvar("g_ScoresColor_Allies", scorecolor[0] + " " + scorecolor[1] + " " + scorecolor[2]);
	setdvar("g_TeamName_Axis", getteamshortname("axis"));
	setdvar("g_TeamIcon_Axis", getteamicon("axis"));
	setdvar("g_TeamIcon_MyAxis", getteamicon("axis"));
	setdvar("g_TeamIcon_EnemyAxis", getteamicon("axis"));
	scorecolor = getteamcolor("axis");
	setdvar("g_ScoresColor_Axis", scorecolor[0] + " " + scorecolor[1] + " " + scorecolor[2]);
	setdvar("g_ScoresColor_Spectator", ".25 .25 .25");
	setdvar("g_ScoresColor_Free", ".76 .78 .10");
	setdvar("g_teamColor_MyTeam", ".6 .8 .6");
	setdvar("g_teamColor_EnemyTeam", "1 .45 .5");
	setdvar("g_teamTitleColor_MyTeam", ".6 .8 .6");
	setdvar("g_teamTitleColor_EnemyTeam", "1 .45 .5");
}

onplayerconnect()
{
	for(;;)
	{
		level waittill("connected", player);
		player thread onjoinedteam();
		player thread onjoinedspectators();
		player thread onplayerspawned();
		player thread trackplayedtime();
	}
}

onfreeplayerconnect()
{
	for(;;)
	{
		level waittill("connected", player);
		player thread trackfreeplayedtime();
	}
}

onjoinedteam()
{
	self endon("disconnect");
	for(;;)
	{
		self waittill("joined_team");
		updateteamtime();
	}
}

onjoinedspectators()
{
	self endon("disconnect");
	for(;;)
	{
		self waittill("joined_spectators");
		self.pers["teamTime"] = undefined;
	}
}

trackplayedtime()
{
	self endon("disconnect");
	self.timeplayed["allies"] = 0;
	self.timeplayed["axis"] = 0;
	self.timeplayed["free"] = 0;
	self.timeplayed["other"] = 0;
	self.timeplayed["total"] = 0;
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

		wait 1;
	}
}

updateplayertimes()
{
	if(!level.rankedmatch)
	{
		return;
	}

	level endon("game_ended");
	for(;;)
	{
		foreach(player in level.players)
		{
			player updateplayedtime();
		}

		wait 1;
	}
}

updateplayedtime()
{
	if(!maps\mp\_utility::rankingenabled())
	{
		return;
	}

	if(self.timeplayed["allies"])
	{
		maps\mp\gametypes\_persistence::stataddbuffered("timePlayedAllies", self.timeplayed["allies"]);
		maps\mp\gametypes\_persistence::stataddbuffered("timePlayedTotal", self.timeplayed["allies"]);
		maps\mp\gametypes\_persistence::stataddchildbuffered("round", "timePlayed", self.timeplayed["allies"]);
	}

	if(self.timeplayed["axis"])
	{
		maps\mp\gametypes\_persistence::stataddbuffered("timePlayedOpfor", self.timeplayed["axis"]);
		maps\mp\gametypes\_persistence::stataddbuffered("timePlayedTotal", self.timeplayed["axis"]);
		maps\mp\gametypes\_persistence::stataddchildbuffered("round", "timePlayed", self.timeplayed["axis"]);
	}

	if(self.timeplayed["other"])
	{
		maps\mp\gametypes\_persistence::stataddbuffered("timePlayedOther", self.timeplayed["other"]);
		maps\mp\gametypes\_persistence::stataddbuffered("timePlayedTotal", self.timeplayed["other"]);
		maps\mp\gametypes\_persistence::stataddchildbuffered("round", "timePlayed", self.timeplayed["other"]);
	}

	if(game["state"] == "postgame")
	{
		return;
	}

	self.timeplayed["allies"] = 0;
	self.timeplayed["axis"] = 0;
	self.timeplayed["other"] = 0;
}

updateteamtime()
{
	if(game["state"] != "playing")
	{
		return;
	}

	self.pers["teamTime"] = gettime();
}

updateteambalancedvar()
{
	for(;;)
	{
		teambalance = getdvarint("scr_teambalance");
		if(level.teambalance != teambalance)
		{
			level.teambalance = getdvarint("scr_teambalance");
		}

		wait 1;
	}
}

updateteambalance()
{
	level.teamlimit = level.maxclients / 2;
	level thread updateteambalancedvar();
	wait 0.15;
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
				iprintlnbold(&"MP_AUTOBALANCE_SECONDS", 15);
				wait 15;
				if(!getteambalance())
				{
					level balanceteams();
				}
			}

			wait 59;
		}

		wait 1;
	}
}

getteambalance()
{
	level.team["allies"] = 0;
	level.team["axis"] = 0;
	players = level.players;
	for(i = 0;i < players.size;i++)
	{
		if(isdefined(players[i].pers["team"]) && players[i].pers["team"] == "allies")
		{
			level.team["allies"]++;
			continue;
		}

		if(isdefined(players[i].pers["team"]) && players[i].pers["team"] == "axis")
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

balanceteams()
{
	iprintlnbold(game["strings"]["autobalance"]);
	alliedplayers = [];
	axisplayers = [];
	players = level.players;
	for(i = 0;i < players.size;i++)
	{
		if(!isdefined(players[i].pers["teamTime"]))
		{
			continue;
		}

		if(isdefined(players[i].pers["team"]) && players[i].pers["team"] == "allies")
		{
			alliedplayers[alliedplayers.size] = players[i];
			continue;
		}

		if(isdefined(players[i].pers["team"]) && players[i].pers["team"] == "axis")
		{
			axisplayers[axisplayers.size] = players[i];
		}
	}

	mostrecent = undefined;
	while(alliedplayers.size > axisplayers.size + 1 || axisplayers.size > alliedplayers.size + 1)
	{
		if(alliedplayers.size > axisplayers.size + 1)
		{
			for(j = 0;j < alliedplayers.size;j++)
			{
				if(isdefined(alliedplayers[j].dont_auto_balance))
				{
					continue;
				}

				if(!isdefined(mostrecent))
				{
					mostrecent = alliedplayers[j];
					continue;
				}

				if(alliedplayers[j].pers["teamTime"] > mostrecent.pers["teamTime"])
				{
					mostrecent = alliedplayers[j];
				}
			}

			mostrecent [[ level.axis ]]();
		}
		else if(axisplayers.size > alliedplayers.size + 1)
		{
			for(j = 0;j < axisplayers.size;j++)
			{
				if(isdefined(axisplayers[j].dont_auto_balance))
				{
					continue;
				}

				if(!isdefined(mostrecent))
				{
					mostrecent = axisplayers[j];
					continue;
				}

				if(axisplayers[j].pers["teamTime"] > mostrecent.pers["teamTime"])
				{
					mostrecent = axisplayers[j];
				}
			}

			mostrecent [[ level.allies ]]();
		}

		mostrecent = undefined;
		alliedplayers = [];
		axisplayers = [];
		players = level.players;
		for(i = 0;i < players.size;i++)
		{
			if(isdefined(players[i].pers["team"]) && players[i].pers["team"] == "allies")
			{
				alliedplayers[alliedplayers.size] = players[i];
				continue;
			}

			if(isdefined(players[i].pers["team"]) && players[i].pers["team"] == "axis")
			{
				axisplayers[axisplayers.size] = players[i];
			}
		}
	}
}

setghilliemodels(param_479)
{
	level.environment = param_479;
	switch(param_479)
	{
		case "desert":
			mptype\mptype_ally_ghillie_desert::precache();
			mptype\mptype_opforce_ghillie_desert::precache();
			game["allies_model"]["GHILLIE"] = ::mptype\mptype_ally_ghillie_desert::main;
			game["axis_model"]["GHILLIE"] = ::mptype\mptype_opforce_ghillie_desert::main;
			break;

		case "arctic":
			mptype\mptype_ally_ghillie_arctic::precache();
			mptype\mptype_opforce_ghillie_arctic::precache();
			game["allies_model"]["GHILLIE"] = ::mptype\mptype_ally_ghillie_arctic::main;
			game["axis_model"]["GHILLIE"] = ::mptype\mptype_opforce_ghillie_arctic::main;
			break;

		case "urban":
			mptype\mptype_ally_ghillie_urban::precache();
			mptype\mptype_opforce_ghillie_urban::precache();
			game["allies_model"]["GHILLIE"] = ::mptype\mptype_ally_ghillie_urban::main;
			game["axis_model"]["GHILLIE"] = ::mptype\mptype_opforce_ghillie_urban::main;
			break;

		case "forest":
			mptype\mptype_ally_ghillie_forest::precache();
			mptype\mptype_opforce_ghillie_forest::precache();
			game["allies_model"]["GHILLIE"] = ::mptype\mptype_ally_ghillie_forest::main;
			game["axis_model"]["GHILLIE"] = ::mptype\mptype_opforce_ghillie_forest::main;
			break;

		default:
			break;
	}
}

setteammodels(team, param_47B)
{
	switch(param_47B)
	{
		case "seals_udt":
			mptype\mptype_seal_udt_sniper::precache();
			mptype\mptype_seal_udt_lmg::precache();
			mptype\mptype_seal_udt_assault::precache();
			mptype\mptype_seal_udt_shotgun::precache();
			mptype\mptype_seal_udt_smg::precache();
			mptype\mptype_seal_udt_riot::precache();
			game[team + "_model"]["SNIPER"] = ::mptype\mptype_seal_udt_sniper::main;
			game[team + "_model"]["LMG"] = ::mptype\mptype_seal_udt_lmg::main;
			game[team + "_model"]["ASSAULT"] = ::mptype\mptype_seal_udt_assault::main;
			game[team + "_model"]["SHOTGUN"] = ::mptype\mptype_seal_udt_shotgun::main;
			game[team + "_model"]["SMG"] = ::mptype\mptype_seal_udt_smg::main;
			game[team + "_model"]["RIOT"] = ::mptype\mptype_seal_udt_riot::main;
			break;

		case "us_army":
			mptype\mptype_us_army_sniper::precache();
			mptype\mptype_us_army_lmg::precache();
			mptype\mptype_us_army_assault::precache();
			mptype\mptype_us_army_shotgun::precache();
			mptype\mptype_us_army_smg::precache();
			mptype\mptype_us_army_riot::precache();
			game[team + "_model"]["SNIPER"] = ::mptype\mptype_us_army_sniper::main;
			game[team + "_model"]["LMG"] = ::mptype\mptype_us_army_lmg::main;
			game[team + "_model"]["ASSAULT"] = ::mptype\mptype_us_army_assault::main;
			game[team + "_model"]["SHOTGUN"] = ::mptype\mptype_us_army_shotgun::main;
			game[team + "_model"]["SMG"] = ::mptype\mptype_us_army_smg::main;
			game[team + "_model"]["RIOT"] = ::mptype\mptype_us_army_riot::main;
			break;

		case "opforce_composite":
			mptype\mptype_opforce_comp_assault::precache();
			mptype\mptype_opforce_comp_lmg::precache();
			mptype\mptype_opforce_comp_shotgun::precache();
			mptype\mptype_opforce_comp_smg::precache();
			mptype\mptype_opforce_comp_sniper::precache();
			mptype\mptype_opforce_comp_riot::precache();
			game[team + "_model"]["SNIPER"] = ::mptype\mptype_opforce_comp_sniper::main;
			game[team + "_model"]["LMG"] = ::mptype\mptype_opforce_comp_lmg::main;
			game[team + "_model"]["ASSAULT"] = ::mptype\mptype_opforce_comp_assault::main;
			game[team + "_model"]["SHOTGUN"] = ::mptype\mptype_opforce_comp_shotgun::main;
			game[team + "_model"]["SMG"] = ::mptype\mptype_opforce_comp_smg::main;
			game[team + "_model"]["RIOT"] = ::mptype\mptype_opforce_comp_riot::main;
			break;

		case "opforce_arctic":
			mptype\mptype_opforce_arctic_assault::precache();
			mptype\mptype_opforce_arctic_lmg::precache();
			mptype\mptype_opforce_arctic_shotgun::precache();
			mptype\mptype_opforce_arctic_smg::precache();
			mptype\mptype_opforce_arctic_sniper::precache();
			mptype\mptype_opforce_arctic_riot::precache();
			game[team + "_model"]["SNIPER"] = ::mptype\mptype_opforce_arctic_sniper::main;
			game[team + "_model"]["LMG"] = ::mptype\mptype_opforce_arctic_lmg::main;
			game[team + "_model"]["ASSAULT"] = ::mptype\mptype_opforce_arctic_assault::main;
			game[team + "_model"]["SHOTGUN"] = ::mptype\mptype_opforce_arctic_shotgun::main;
			game[team + "_model"]["SMG"] = ::mptype\mptype_opforce_arctic_smg::main;
			game[team + "_model"]["RIOT"] = ::mptype\mptype_opforce_arctic_riot::main;
			break;

		case "opforce_airborne":
			mptype\mptype_opforce_airborne_assault::precache();
			mptype\mptype_opforce_airborne_lmg::precache();
			mptype\mptype_opforce_airborne_shotgun::precache();
			mptype\mptype_opforce_airborne_smg::precache();
			mptype\mptype_opforce_airborne_sniper::precache();
			mptype\mptype_opforce_airborne_riot::precache();
			game[team + "_model"]["SNIPER"] = ::mptype\mptype_opforce_airborne_sniper::main;
			game[team + "_model"]["LMG"] = ::mptype\mptype_opforce_airborne_lmg::main;
			game[team + "_model"]["ASSAULT"] = ::mptype\mptype_opforce_airborne_assault::main;
			game[team + "_model"]["SHOTGUN"] = ::mptype\mptype_opforce_airborne_shotgun::main;
			game[team + "_model"]["SMG"] = ::mptype\mptype_opforce_airborne_smg::main;
			game[team + "_model"]["RIOT"] = ::mptype\mptype_opforce_airborne_riot::main;
			break;

		case "militia":
			mptype\mptype_opforce_militia_assault::precache();
			mptype\mptype_opforce_militia_lmg::precache();
			mptype\mptype_opforce_militia_shotgun::precache();
			mptype\mptype_opforce_militia_smg::precache();
			mptype\mptype_opforce_militia_sniper::precache();
			mptype\mptype_opforce_militia_riot::precache();
			game[team + "_model"]["SNIPER"] = ::mptype\mptype_opforce_militia_sniper::main;
			game[team + "_model"]["LMG"] = ::mptype\mptype_opforce_militia_lmg::main;
			game[team + "_model"]["ASSAULT"] = ::mptype\mptype_opforce_militia_assault::main;
			game[team + "_model"]["SHOTGUN"] = ::mptype\mptype_opforce_militia_shotgun::main;
			game[team + "_model"]["SMG"] = ::mptype\mptype_opforce_militia_smg::main;
			game[team + "_model"]["RIOT"] = ::mptype\mptype_opforce_militia_riot::main;
			break;

		case "socom_141":
			mptype\mptype_socom_assault::precache();
			mptype\mptype_socom_lmg::precache();
			mptype\mptype_socom_shotgun::precache();
			mptype\mptype_socom_smg::precache();
			mptype\mptype_socom_sniper::precache();
			game[team + "_model"]["SNIPER"] = ::mptype\mptype_socom_sniper::main;
			game[team + "_model"]["LMG"] = ::mptype\mptype_socom_lmg::main;
			game[team + "_model"]["ASSAULT"] = ::mptype\mptype_socom_assault::main;
			game[team + "_model"]["SHOTGUN"] = ::mptype\mptype_socom_shotgun::main;
			game[team + "_model"]["SMG"] = ::mptype\mptype_socom_smg::main;
			game[team + "_model"]["RIOT"] = ::mptype\mptype_socom_smg::main;
			break;

		case "socom_141_desert":
			mptype\mptype_tf141_desert_assault::precache();
			mptype\mptype_tf141_desert_lmg::precache();
			mptype\mptype_tf141_desert_smg::precache();
			mptype\mptype_tf141_desert_shotgun::precache();
			mptype\mptype_tf141_desert_sniper::precache();
			mptype\mptype_tf141_desert_riot::precache();
			game[team + "_model"]["SNIPER"] = ::mptype\mptype_tf141_desert_sniper::main;
			game[team + "_model"]["LMG"] = ::mptype\mptype_tf141_desert_lmg::main;
			game[team + "_model"]["ASSAULT"] = ::mptype\mptype_tf141_desert_assault::main;
			game[team + "_model"]["SHOTGUN"] = ::mptype\mptype_tf141_desert_shotgun::main;
			game[team + "_model"]["SMG"] = ::mptype\mptype_tf141_desert_smg::main;
			game[team + "_model"]["RIOT"] = ::mptype\mptype_tf141_desert_riot::main;
			break;

		case "socom_141_forest":
			mptype\mptype_tf141_forest_assault::precache();
			mptype\mptype_tf141_forest_lmg::precache();
			mptype\mptype_tf141_forest_smg::precache();
			mptype\mptype_tf141_forest_shotgun::precache();
			mptype\mptype_tf141_forest_sniper::precache();
			mptype\mptype_tf141_forest_riot::precache();
			game[team + "_model"]["SNIPER"] = ::mptype\mptype_tf141_forest_sniper::main;
			game[team + "_model"]["LMG"] = ::mptype\mptype_tf141_forest_lmg::main;
			game[team + "_model"]["ASSAULT"] = ::mptype\mptype_tf141_forest_assault::main;
			game[team + "_model"]["SHOTGUN"] = ::mptype\mptype_tf141_forest_shotgun::main;
			game[team + "_model"]["SMG"] = ::mptype\mptype_tf141_forest_smg::main;
			game[team + "_model"]["RIOT"] = ::mptype\mptype_tf141_forest_riot::main;
			break;

		case "socom_141_arctic":
			mptype\mptype_tf141_arctic_assault::precache();
			mptype\mptype_tf141_arctic_lmg::precache();
			mptype\mptype_tf141_arctic_smg::precache();
			mptype\mptype_tf141_arctic_shotgun::precache();
			mptype\mptype_tf141_arctic_sniper::precache();
			mptype\mptype_tf141_arctic_riot::precache();
			game[team + "_model"]["SNIPER"] = ::mptype\mptype_tf141_arctic_sniper::main;
			game[team + "_model"]["LMG"] = ::mptype\mptype_tf141_arctic_lmg::main;
			game[team + "_model"]["ASSAULT"] = ::mptype\mptype_tf141_arctic_assault::main;
			game[team + "_model"]["SHOTGUN"] = ::mptype\mptype_tf141_arctic_shotgun::main;
			game[team + "_model"]["SMG"] = ::mptype\mptype_tf141_arctic_smg::main;
			game[team + "_model"]["RIOT"] = ::mptype\mptype_tf141_arctic_riot::main;
			break;
	}
}

setplayermodels()
{
	setteammodels("allies", game["allies"]);
	setteammodels("axis", game["axis"]);
	setghilliemodels(getmapcustom("environment"));
}

playermodelforweapon(weapon, param_47C)
{
	team = self.team;
	if(isdefined(game[team + "_model"][weapon]))
	{
		[[ game[team + "_model"][weapon] ]]();
		return;
	}

	weaponclass = tablelookup("mp/statstable.csv", 4, weapon, 2);
	switch(weaponclass)
	{
		case "weapon_smg":
			[[ game[team + "_model"]["SMG"] ]]();
			break;

		case "weapon_assault":
			weaponclass = tablelookup("mp/statstable.csv", 4, param_47C, 2);
			if(weaponclass == "weapon_shotgun")
			{
				[[ game[team + "_model"]["SHOTGUN"] ]]();
			}
			else
			{
				[[ game[team + "_model"]["ASSAULT"] ]]();
			}
			break;

		case "weapon_sniper":
			if(level.environment != "" && self isitemunlocked("ghillie_" + level.environment))
			{
				[[ game[team + "_model"]["GHILLIE"] ]]();
			}
			else
			{
				[[ game[team + "_model"]["SNIPER"] ]]();
			}
			break;

		case "weapon_lmg":
			[[ game[team + "_model"]["LMG"] ]]();
			break;

		case "weapon_riot":
			[[ game[team + "_model"]["RIOT"] ]]();
			break;

		default:
			[[ game[team + "_model"]["ASSAULT"] ]]();
			break;
	}
}

countplayers()
{
	players = level.players;
	allies = 0;
	axis = 0;
	for(i = 0;i < players.size;i++)
	{
		if(players[i] == self)
		{
			continue;
		}

		if(isdefined(players[i].pers["team"]) && players[i].pers["team"] == "allies")
		{
			allies++;
			continue;
		}

		if(isdefined(players[i].pers["team"]) && players[i].pers["team"] == "axis")
		{
			axis++;
		}
	}

	players["allies"] = allies;
	players["axis"] = axis;
	return players;
}

trackfreeplayedtime()
{
	self endon("disconnect");
	self.timeplayed["allies"] = 0;
	self.timeplayed["axis"] = 0;
	self.timeplayed["other"] = 0;
	self.timeplayed["total"] = 0;
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

		wait 1;
	}
}

updatefreeplayertimes()
{
	if(!level.rankedmatch)
	{
		return;
	}

	nexttoupdate = 0;
	for(;;)
	{
		nexttoupdate++;
		if(nexttoupdate >= level.players.size)
		{
			nexttoupdate = 0;
		}

		if(isdefined(level.players[nexttoupdate]))
		{
			level.players[nexttoupdate] updatefreeplayedtime();
		}

		wait 1;
	}
}

updatefreeplayedtime()
{
	if(!maps\mp\_utility::rankingenabled())
	{
		return;
	}

	if(self.timeplayed["allies"])
	{
		maps\mp\gametypes\_persistence::stataddbuffered("timePlayedAllies", self.timeplayed["allies"]);
		maps\mp\gametypes\_persistence::stataddbuffered("timePlayedTotal", self.timeplayed["allies"]);
	}

	if(self.timeplayed["axis"])
	{
		maps\mp\gametypes\_persistence::stataddbuffered("timePlayedOpfor", self.timeplayed["axis"]);
		maps\mp\gametypes\_persistence::stataddbuffered("timePlayedTotal", self.timeplayed["axis"]);
	}

	if(self.timeplayed["other"])
	{
		maps\mp\gametypes\_persistence::stataddbuffered("timePlayedOther", self.timeplayed["other"]);
		maps\mp\gametypes\_persistence::stataddbuffered("timePlayedTotal", self.timeplayed["other"]);
	}

	if(game["state"] == "postgame")
	{
		return;
	}

	self.timeplayed["allies"] = 0;
	self.timeplayed["axis"] = 0;
	self.timeplayed["other"] = 0;
}

getjointeampermissions(team)
{
	teamcount = 0;
	players = level.players;
	for(i = 0;i < players.size;i++)
	{
		player = players[i];
		if(isdefined(player.pers["team"]) && player.pers["team"] == team)
		{
			teamcount++;
		}
	}

	if(teamcount < level.teamlimit)
	{
		return 1;
	}

	return 0;
}

onplayerspawned()
{
	level endon("game_ended");
	self waittill("spawned_player");
}

getteamname(teamref)
{
	return tablelookupistring("mp/factionTable.csv", 0, game[teamref], 1);
}

getteamshortname(teamref)
{
	return tablelookupistring("mp/factionTable.csv", 0, game[teamref], 2);
}

getteamforfeitedstring(teamref)
{
	return tablelookupistring("mp/factionTable.csv", 0, game[teamref], 4);
}

getteameliminatedstring(teamref)
{
	return tablelookupistring("mp/factionTable.csv", 0, game[teamref], 3);
}

getteamicon(teamref)
{
	return tablelookup("mp/factionTable.csv", 0, game[teamref], 5);
}

getteamhudicon(teamref)
{
	return tablelookup("mp/factionTable.csv", 0, game[teamref], 6);
}

getteamheadicon(teamref)
{
	return tablelookup("mp/factionTable.csv", 0, game[teamref], 17);
}

getteamvoiceprefix(teamref)
{
	return tablelookup("mp/factionTable.csv", 0, game[teamref], 7);
}

getteamspawnmusic(teamref)
{
	return tablelookup("mp/factionTable.csv", 0, game[teamref], 8);
}

getteamwinmusic(teamref)
{
	return tablelookup("mp/factionTable.csv", 0, game[teamref], 9);
}

getteamflagmodel(teamref)
{
	return tablelookup("mp/factionTable.csv", 0, game[teamref], 10);
}

getteamflagcarrymodel(teamref)
{
	return tablelookup("mp/factionTable.csv", 0, game[teamref], 11);
}

getteamflagicon(teamref)
{
	return tablelookup("mp/factionTable.csv", 0, game[teamref], 12);
}

getteamflagfx(teamref)
{
	return tablelookup("mp/factionTable.csv", 0, game[teamref], 13);
}

getteamcolor(teamref)
{
	return (maps\mp\_utility::stringtofloat(tablelookup("mp/factionTable.csv", 0, game[teamref], 14)),maps\mp\_utility::stringtofloat(tablelookup("mp/factionTable.csv", 0, game[teamref], 15)),maps\mp\_utility::stringtofloat(tablelookup("mp/factionTable.csv", 0, game[teamref], 16)));
}

getteamcratemodel(teamref)
{
	return tablelookup("mp/factionTable.csv", 0, game[teamref], 18);
}