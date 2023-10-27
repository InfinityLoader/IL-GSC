/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes\_teams.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: PC
 * Function Count: 41
 * Decompile Time: 574 ms
 * Timestamp: 10/27/2023 2:12:59 AM
*******************************************************************/

//Function Number: 1
init()
{
	initscoreboard();
	level.teambalance = getdvarint("scr_teambalance");
	level.maxclients = getdvarint("sv_maxclients");
	level._effect["thermal_beacon"] = loadfx("misc/thermal_beacon_inverted");
	var_00 = level._effect["thermal_beacon"];
	precachefxteamthermal(var_00,"J_Spine4");
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

		wait 1;
	}
}

//Function Number: 9
updateplayedtime()
{
	if(!maps\mp\_utility::rankingenabled())
	{
		return;
	}

	if(self.timeplayed["allies"])
	{
		maps\mp\gametypes\_persistance::stataddbuffered("timePlayedAllies",self.timeplayed["allies"]);
		maps\mp\gametypes\_persistance::stataddbuffered("timePlayedTotal",self.timeplayed["allies"]);
		maps\mp\gametypes\_persistance::stataddchildbuffered("round","timePlayed",self.timeplayed["allies"]);
		if(!self.prestigedoublexp)
		{
			maps\mp\gametypes\_persistance::stataddchildbufferedwithmax("xpMultiplierTimePlayed",0,self.timeplayed["allies"],self.bufferedchildstatsmax["xpMaxMultiplierTimePlayed"][0]);
			maps\mp\gametypes\_persistance::stataddchildbufferedwithmax("xpMultiplierTimePlayed",1,self.timeplayed["allies"],self.bufferedchildstatsmax["xpMaxMultiplierTimePlayed"][1]);
			maps\mp\gametypes\_persistance::stataddchildbufferedwithmax("xpMultiplierTimePlayed",2,self.timeplayed["allies"],self.bufferedchildstatsmax["xpMaxMultiplierTimePlayed"][2]);
		}

		maps\mp\gametypes\_persistance::stataddchildbufferedwithmax("challengeXPMultiplierTimePlayed",0,self.timeplayed["allies"],self.bufferedchildstatsmax["challengeXPMaxMultiplierTimePlayed"][0]);
		maps\mp\gametypes\_persistance::stataddchildbufferedwithmax("weaponXPMultiplierTimePlayed",0,self.timeplayed["allies"],self.bufferedchildstatsmax["weaponXPMaxMultiplierTimePlayed"][0]);
		maps\mp\gametypes\_persistance::stataddbufferedwithmax("prestigeDoubleXpTimePlayed",self.timeplayed["allies"],self.bufferedstatsmax["prestigeDoubleXpMaxTimePlayed"]);
		maps\mp\gametypes\_persistance::stataddbufferedwithmax("prestigeDoubleWeaponXpTimePlayed",self.timeplayed["allies"],self.bufferedstatsmax["prestigeDoubleWeaponXpMaxTimePlayed"]);
	}

	if(self.timeplayed["axis"])
	{
		maps\mp\gametypes\_persistance::stataddbuffered("timePlayedOpfor",self.timeplayed["axis"]);
		maps\mp\gametypes\_persistance::stataddbuffered("timePlayedTotal",self.timeplayed["axis"]);
		maps\mp\gametypes\_persistance::stataddchildbuffered("round","timePlayed",self.timeplayed["axis"]);
		if(!self.prestigedoublexp)
		{
			maps\mp\gametypes\_persistance::stataddchildbufferedwithmax("xpMultiplierTimePlayed",0,self.timeplayed["axis"],self.bufferedchildstatsmax["xpMaxMultiplierTimePlayed"][0]);
			maps\mp\gametypes\_persistance::stataddchildbufferedwithmax("xpMultiplierTimePlayed",1,self.timeplayed["axis"],self.bufferedchildstatsmax["xpMaxMultiplierTimePlayed"][1]);
			maps\mp\gametypes\_persistance::stataddchildbufferedwithmax("xpMultiplierTimePlayed",2,self.timeplayed["axis"],self.bufferedchildstatsmax["xpMaxMultiplierTimePlayed"][2]);
		}

		maps\mp\gametypes\_persistance::stataddchildbufferedwithmax("challengeXPMultiplierTimePlayed",0,self.timeplayed["axis"],self.bufferedchildstatsmax["challengeXPMaxMultiplierTimePlayed"][0]);
		maps\mp\gametypes\_persistance::stataddchildbufferedwithmax("weaponXPMultiplierTimePlayed",0,self.timeplayed["axis"],self.bufferedchildstatsmax["weaponXPMaxMultiplierTimePlayed"][0]);
		maps\mp\gametypes\_persistance::stataddbufferedwithmax("prestigeDoubleXpTimePlayed",self.timeplayed["axis"],self.bufferedstatsmax["prestigeDoubleXpMaxTimePlayed"]);
		maps\mp\gametypes\_persistance::stataddbufferedwithmax("prestigeDoubleWeaponXpTimePlayed",self.timeplayed["axis"],self.bufferedstatsmax["prestigeDoubleWeaponXpMaxTimePlayed"]);
	}

	if(self.timeplayed["other"])
	{
		maps\mp\gametypes\_persistance::stataddbuffered("timePlayedOther",self.timeplayed["other"]);
		maps\mp\gametypes\_persistance::stataddbuffered("timePlayedTotal",self.timeplayed["other"]);
		maps\mp\gametypes\_persistance::stataddchildbuffered("round","timePlayed",self.timeplayed["other"]);
		if(!self.prestigedoublexp)
		{
			maps\mp\gametypes\_persistance::stataddchildbufferedwithmax("xpMultiplierTimePlayed",0,self.timeplayed["other"],self.bufferedchildstatsmax["xpMaxMultiplierTimePlayed"][0]);
			maps\mp\gametypes\_persistance::stataddchildbufferedwithmax("xpMultiplierTimePlayed",1,self.timeplayed["other"],self.bufferedchildstatsmax["xpMaxMultiplierTimePlayed"][1]);
			maps\mp\gametypes\_persistance::stataddchildbufferedwithmax("xpMultiplierTimePlayed",2,self.timeplayed["other"],self.bufferedchildstatsmax["xpMaxMultiplierTimePlayed"][2]);
		}

		maps\mp\gametypes\_persistance::stataddchildbufferedwithmax("challengeXPMultiplierTimePlayed",0,self.timeplayed["other"],self.bufferedchildstatsmax["challengeXPMaxMultiplierTimePlayed"][0]);
		maps\mp\gametypes\_persistance::stataddchildbufferedwithmax("weaponXPMultiplierTimePlayed",0,self.timeplayed["other"],self.bufferedchildstatsmax["weaponXPMaxMultiplierTimePlayed"][0]);
		maps\mp\gametypes\_persistance::stataddbufferedwithmax("prestigeDoubleXpTimePlayed",self.timeplayed["other"],self.bufferedstatsmax["prestigeDoubleXpMaxTimePlayed"]);
		maps\mp\gametypes\_persistance::stataddbufferedwithmax("prestigeDoubleWeaponXpTimePlayed",self.timeplayed["other"],self.bufferedstatsmax["prestigeDoubleWeaponXpMaxTimePlayed"]);
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

		wait 1;
	}
}

//Function Number: 12
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
				iprintlnbold(&"MP_AUTOBALANCE_SECONDS",15);
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

			var_04 [[ level.axis ]]();
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

			var_04 [[ level.allies ]]();
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
	level.environment = param_00;
	switch(param_00)
	{
		case "desert":
			lib_02C9::precache();
			lib_02CA::precache();
			game["allies_model"]["GHILLIE"] = ::lib_02C9::main;
			game["axis_model"]["GHILLIE"] = ::lib_02CA::main;
			break;

		case "arctic":
			lib_02CB::precache();
			lib_02CC::precache();
			game["allies_model"]["GHILLIE"] = ::lib_02CB::main;
			game["axis_model"]["GHILLIE"] = ::lib_02CC::main;
			break;

		case "urban":
			lib_02CD::precache();
			lib_02CE::precache();
			game["allies_model"]["GHILLIE"] = ::lib_02CD::main;
			game["axis_model"]["GHILLIE"] = ::lib_02CE::main;
			break;

		case "forest":
			lib_02CF::precache();
			lib_02D0::precache();
			game["allies_model"]["GHILLIE"] = ::lib_02CF::main;
			game["axis_model"]["GHILLIE"] = ::lib_02D0::main;
			break;

		case "forest_militia":
			lib_02CF::precache();
			lib_02D1::precache();
			game["allies_model"]["GHILLIE"] = ::lib_02CF::main;
			game["axis_model"]["GHILLIE"] = ::lib_02D1::main;
			break;

		case "desert_militia":
			lib_02C9::precache();
			lib_02D1::precache();
			game["allies_model"]["GHILLIE"] = ::lib_02C9::main;
			game["axis_model"]["GHILLIE"] = ::lib_02D1::main;
			break;

		case "arctic_militia":
			lib_02CB::precache();
			lib_02D1::precache();
			game["allies_model"]["GHILLIE"] = ::lib_02CB::main;
			game["axis_model"]["GHILLIE"] = ::lib_02D1::main;
			break;

		case "urban_militia":
			lib_02CD::precache();
			lib_02D1::precache();
			game["allies_model"]["GHILLIE"] = ::lib_02CD::main;
			game["axis_model"]["GHILLIE"] = ::lib_02D1::main;
			break;

		default:
			break;
	}
}

//Function Number: 16
setteammodels(param_00,param_01)
{
	switch(param_01)
	{
		case "delta_multicam":
			lib_02D2::precache();
			lib_02D3::precache();
			lib_02D4::precache();
			lib_02D5::precache();
			lib_033D::precache();
			lib_02D6::precache();
			lib_02D7::precache();
			game[param_00 + "_model"]["SNIPER"] = ::lib_033D::main;
			game[param_00 + "_model"]["LMG"] = ::lib_02D3::main;
			game[param_00 + "_model"]["ASSAULT"] = ::lib_02D2::main;
			game[param_00 + "_model"]["SHOTGUN"] = ::lib_02D5::main;
			game[param_00 + "_model"]["SMG"] = ::lib_02D4::main;
			game[param_00 + "_model"]["RIOT"] = ::lib_02D6::main;
			game[param_00 + "_model"]["JUGGERNAUT"] = ::lib_02D7::main;
			break;

		case "sas_urban":
			lib_02D8::precache();
			lib_02D9::precache();
			lib_02DA::precache();
			lib_02DB::precache();
			lib_02DC::precache();
			lib_02D7::precache();
			game[param_00 + "_model"]["SNIPER"] = ::lib_02DC::main;
			game[param_00 + "_model"]["LMG"] = ::lib_02D9::main;
			game[param_00 + "_model"]["ASSAULT"] = ::lib_02D8::main;
			game[param_00 + "_model"]["SHOTGUN"] = ::lib_02DA::main;
			game[param_00 + "_model"]["SMG"] = ::lib_02DB::main;
			game[param_00 + "_model"]["RIOT"] = ::lib_02DB::main;
			game[param_00 + "_model"]["JUGGERNAUT"] = ::lib_02D7::main;
			break;

		case "gign_paris":
			lib_02DD::precache();
			lib_02DE::precache();
			lib_02DF::precache();
			lib_02E0::precache();
			lib_02FF::precache();
			lib_0300::precache();
			lib_02D7::precache();
			game[param_00 + "_model"]["SNIPER"] = ::lib_02FF::main;
			game[param_00 + "_model"]["LMG"] = ::lib_02DE::main;
			game[param_00 + "_model"]["ASSAULT"] = ::lib_02DD::main;
			game[param_00 + "_model"]["SHOTGUN"] = ::lib_02DF::main;
			game[param_00 + "_model"]["SMG"] = ::lib_02E0::main;
			game[param_00 + "_model"]["RIOT"] = ::lib_0300::main;
			game[param_00 + "_model"]["JUGGERNAUT"] = ::lib_02D7::main;
			break;

		case "pmc_africa":
			lib_0301::precache();
			lib_0302::precache();
			lib_0303::precache();
			lib_0304::precache();
			lib_0305::precache();
			lib_0306::precache();
			lib_02D7::precache();
			game[param_00 + "_model"]["SNIPER"] = ::lib_0305::main;
			game[param_00 + "_model"]["LMG"] = ::lib_0302::main;
			game[param_00 + "_model"]["ASSAULT"] = ::lib_0301::main;
			game[param_00 + "_model"]["SHOTGUN"] = ::lib_0304::main;
			game[param_00 + "_model"]["SMG"] = ::lib_0303::main;
			game[param_00 + "_model"]["RIOT"] = ::lib_0306::main;
			game[param_00 + "_model"]["JUGGERNAUT"] = ::lib_02D7::main;
			break;

		case "opforce_air":
			lib_0307::precache();
			lib_0308::precache();
			lib_0309::precache();
			lib_030A::precache();
			lib_030B::precache();
			lib_030C::precache();
			lib_030D::precache();
			game[param_00 + "_model"]["SNIPER"] = ::lib_030B::main;
			game[param_00 + "_model"]["LMG"] = ::lib_0308::main;
			game[param_00 + "_model"]["ASSAULT"] = ::lib_0307::main;
			game[param_00 + "_model"]["SHOTGUN"] = ::lib_0309::main;
			game[param_00 + "_model"]["SMG"] = ::lib_030A::main;
			game[param_00 + "_model"]["RIOT"] = ::lib_030C::main;
			game[param_00 + "_model"]["JUGGERNAUT"] = ::lib_030D::main;
			break;

		case "opforce_snow":
			lib_030E::precache();
			lib_030F::precache();
			lib_0310::precache();
			lib_0311::precache();
			lib_0312::precache();
			lib_0313::precache();
			lib_030D::precache();
			game[param_00 + "_model"]["SNIPER"] = ::lib_0312::main;
			game[param_00 + "_model"]["LMG"] = ::lib_030F::main;
			game[param_00 + "_model"]["ASSAULT"] = ::lib_030E::main;
			game[param_00 + "_model"]["SHOTGUN"] = ::lib_0310::main;
			game[param_00 + "_model"]["SMG"] = ::lib_0311::main;
			game[param_00 + "_model"]["RIOT"] = ::lib_0313::main;
			game[param_00 + "_model"]["JUGGERNAUT"] = ::lib_030D::main;
			break;

		case "opforce_urban":
			lib_0314::precache();
			lib_0315::precache();
			lib_0316::precache();
			lib_0317::precache();
			lib_0318::precache();
			lib_0319::precache();
			lib_030D::precache();
			game[param_00 + "_model"]["SNIPER"] = ::lib_0318::main;
			game[param_00 + "_model"]["LMG"] = ::lib_0315::main;
			game[param_00 + "_model"]["ASSAULT"] = ::lib_0314::main;
			game[param_00 + "_model"]["SHOTGUN"] = ::lib_0316::main;
			game[param_00 + "_model"]["SMG"] = ::lib_0317::main;
			game[param_00 + "_model"]["RIOT"] = ::lib_0319::main;
			game[param_00 + "_model"]["JUGGERNAUT"] = ::lib_030D::main;
			break;

		case "opforce_woodland":
			lib_031A::precache();
			lib_031B::precache();
			lib_031C::precache();
			lib_0333::precache();
			lib_0334::precache();
			lib_0335::precache();
			lib_030D::precache();
			game[param_00 + "_model"]["SNIPER"] = ::lib_0334::main;
			game[param_00 + "_model"]["LMG"] = ::lib_031B::main;
			game[param_00 + "_model"]["ASSAULT"] = ::lib_031A::main;
			game[param_00 + "_model"]["SHOTGUN"] = ::lib_031C::main;
			game[param_00 + "_model"]["SMG"] = ::lib_0333::main;
			game[param_00 + "_model"]["RIOT"] = ::lib_0335::main;
			game[param_00 + "_model"]["JUGGERNAUT"] = ::lib_030D::main;
			break;

		case "opforce_africa":
			lib_0336::precache();
			lib_0337::precache();
			lib_0338::precache();
			lib_0339::precache();
			lib_033A::precache();
			lib_033B::precache();
			lib_030D::precache();
			game[param_00 + "_model"]["SNIPER"] = ::lib_0337::main;
			game[param_00 + "_model"]["LMG"] = ::lib_0337::main;
			game[param_00 + "_model"]["ASSAULT"] = ::lib_0336::main;
			game[param_00 + "_model"]["SHOTGUN"] = ::lib_0338::main;
			game[param_00 + "_model"]["SMG"] = ::lib_0339::main;
			game[param_00 + "_model"]["RIOT"] = ::lib_033B::main;
			game[param_00 + "_model"]["JUGGERNAUT"] = ::lib_030D::main;
			break;

		case "opforce_henchmen":
			lib_033C::precache();
			lib_033E::precache();
			lib_033F::precache();
			lib_0340::precache();
			lib_0341::precache();
			lib_0342::precache();
			lib_030D::precache();
			game[param_00 + "_model"]["SNIPER"] = ::lib_0341::main;
			game[param_00 + "_model"]["LMG"] = ::lib_033E::main;
			game[param_00 + "_model"]["ASSAULT"] = ::lib_033C::main;
			game[param_00 + "_model"]["SHOTGUN"] = ::lib_033F::main;
			game[param_00 + "_model"]["SMG"] = ::lib_0340::main;
			game[param_00 + "_model"]["RIOT"] = ::lib_0342::main;
			game[param_00 + "_model"]["JUGGERNAUT"] = ::lib_030D::main;
			break;
	}
}

//Function Number: 17
setplayermodels()
{
	setteammodels("allies",game["allies"]);
	setteammodels("axis",game["axis"]);
	setghilliemodels(getmapcustom("environment"));
}

//Function Number: 18
playermodelforweapon(param_00,param_01)
{
	var_02 = self.team;
	if(isdefined(game[var_02 + "_model"][param_00]))
	{
		[[ game[var_02 + "_model"][param_00] ]]();
		return;
	}

	var_03 = tablelookup("mp/statstable.csv",4,param_00,2);
	switch(var_03)
	{
		case "weapon_smg":
			[[ game[var_02 + "_model"]["SMG"] ]]();
			break;

		case "weapon_assault":
			[[ game[var_02 + "_model"]["ASSAULT"] ]]();
			break;

		case "weapon_sniper":
			if(level.environment != "" && self isitemunlocked("ghillie_" + level.environment) && game[var_02] != "opforce_africa")
			{
				[[ game[var_02 + "_model"]["GHILLIE"] ]]();
			}
			else
			{
				[[ game[var_02 + "_model"]["SNIPER"] ]]();
			}
			break;

		case "weapon_lmg":
			[[ game[var_02 + "_model"]["LMG"] ]]();
			break;

		case "weapon_riot":
			[[ game[var_02 + "_model"]["RIOT"] ]]();
			break;

		case "weapon_shotgun":
			[[ game[var_02 + "_model"]["SHOTGUN"] ]]();
			break;

		default:
			[[ game[var_02 + "_model"]["ASSAULT"] ]]();
			break;
	}

	if(maps\mp\_utility::isjuggernaut())
	{
		[[ game[var_02 + "_model"]["JUGGERNAUT"] ]]();
	}
}

//Function Number: 19
countplayers()
{
	var_00 = level.players;
	var_01 = 0;
	var_02 = 0;
	for(var_03 = 0;var_03 < var_00.size;var_03++)
	{
		if(var_00[var_03] == self)
		{
			continue;
		}

		if(isdefined(var_00[var_03].pers["team"]) && var_00[var_03].pers["team"] == "allies")
		{
			var_01++;
			continue;
		}

		if(isdefined(var_00[var_03].pers["team"]) && var_00[var_03].pers["team"] == "axis")
		{
			var_02++;
		}
	}

	var_00["allies"] = var_01;
	var_00["axis"] = var_02;
	return var_00;
}

//Function Number: 20
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

//Function Number: 21
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

		wait 1;
	}
}

//Function Number: 22
updatefreeplayedtime()
{
	if(!maps\mp\_utility::rankingenabled())
	{
		return;
	}

	if(self.timeplayed["allies"])
	{
		maps\mp\gametypes\_persistance::stataddbuffered("timePlayedAllies",self.timeplayed["allies"]);
		maps\mp\gametypes\_persistance::stataddbuffered("timePlayedTotal",self.timeplayed["allies"]);
		maps\mp\gametypes\_persistance::stataddchildbuffered("round","timePlayed",self.timeplayed["allies"]);
		if(!self.prestigedoublexp)
		{
			maps\mp\gametypes\_persistance::stataddchildbufferedwithmax("xpMultiplierTimePlayed",0,self.timeplayed["allies"],self.bufferedchildstatsmax["xpMaxMultiplierTimePlayed"][0]);
			maps\mp\gametypes\_persistance::stataddchildbufferedwithmax("xpMultiplierTimePlayed",1,self.timeplayed["allies"],self.bufferedchildstatsmax["xpMaxMultiplierTimePlayed"][1]);
			maps\mp\gametypes\_persistance::stataddchildbufferedwithmax("xpMultiplierTimePlayed",2,self.timeplayed["allies"],self.bufferedchildstatsmax["xpMaxMultiplierTimePlayed"][2]);
		}

		maps\mp\gametypes\_persistance::stataddbufferedwithmax("prestigeDoubleXpTimePlayed",self.timeplayed["allies"],self.bufferedstatsmax["prestigeDoubleXpMaxTimePlayed"]);
		maps\mp\gametypes\_persistance::stataddbufferedwithmax("prestigeDoubleWeaponXpTimePlayed",self.timeplayed["allies"],self.bufferedstatsmax["prestigeDoubleWeaponXpMaxTimePlayed"]);
	}

	if(self.timeplayed["axis"])
	{
		maps\mp\gametypes\_persistance::stataddbuffered("timePlayedOpfor",self.timeplayed["axis"]);
		maps\mp\gametypes\_persistance::stataddbuffered("timePlayedTotal",self.timeplayed["axis"]);
		maps\mp\gametypes\_persistance::stataddchildbuffered("round","timePlayed",self.timeplayed["axis"]);
		if(!self.prestigedoublexp)
		{
			maps\mp\gametypes\_persistance::stataddchildbufferedwithmax("xpMultiplierTimePlayed",0,self.timeplayed["axis"],self.bufferedchildstatsmax["xpMaxMultiplierTimePlayed"][0]);
			maps\mp\gametypes\_persistance::stataddchildbufferedwithmax("xpMultiplierTimePlayed",1,self.timeplayed["axis"],self.bufferedchildstatsmax["xpMaxMultiplierTimePlayed"][1]);
			maps\mp\gametypes\_persistance::stataddchildbufferedwithmax("xpMultiplierTimePlayed",2,self.timeplayed["axis"],self.bufferedchildstatsmax["xpMaxMultiplierTimePlayed"][2]);
		}

		maps\mp\gametypes\_persistance::stataddbufferedwithmax("prestigeDoubleXpTimePlayed",self.timeplayed["axis"],self.bufferedstatsmax["prestigeDoubleXpMaxTimePlayed"]);
		maps\mp\gametypes\_persistance::stataddbufferedwithmax("prestigeDoubleWeaponXpTimePlayed",self.timeplayed["axis"],self.bufferedstatsmax["prestigeDoubleWeaponXpMaxTimePlayed"]);
	}

	if(self.timeplayed["other"])
	{
		maps\mp\gametypes\_persistance::stataddbuffered("timePlayedOther",self.timeplayed["other"]);
		maps\mp\gametypes\_persistance::stataddbuffered("timePlayedTotal",self.timeplayed["other"]);
		maps\mp\gametypes\_persistance::stataddchildbuffered("round","timePlayed",self.timeplayed["other"]);
		if(!self.prestigedoublexp)
		{
			maps\mp\gametypes\_persistance::stataddchildbufferedwithmax("xpMultiplierTimePlayed",0,self.timeplayed["other"],self.bufferedchildstatsmax["xpMaxMultiplierTimePlayed"][0]);
			maps\mp\gametypes\_persistance::stataddchildbufferedwithmax("xpMultiplierTimePlayed",1,self.timeplayed["other"],self.bufferedchildstatsmax["xpMaxMultiplierTimePlayed"][1]);
			maps\mp\gametypes\_persistance::stataddchildbufferedwithmax("xpMultiplierTimePlayed",2,self.timeplayed["other"],self.bufferedchildstatsmax["xpMaxMultiplierTimePlayed"][2]);
		}

		maps\mp\gametypes\_persistance::stataddbufferedwithmax("prestigeDoubleXpTimePlayed",self.timeplayed["other"],self.bufferedstatsmax["prestigeDoubleXpMaxTimePlayed"]);
		maps\mp\gametypes\_persistance::stataddbufferedwithmax("prestigeDoubleWeaponXpTimePlayed",self.timeplayed["other"],self.bufferedstatsmax["prestigeDoubleWeaponXpMaxTimePlayed"]);
	}

	if(game["state"] == "postgame")
	{
		return;
	}

	self.timeplayed["allies"] = 0;
	self.timeplayed["axis"] = 0;
	self.timeplayed["other"] = 0;
}

//Function Number: 23
getjointeampermissions(param_00)
{
	var_01 = 0;
	var_02 = level.players;
	for(var_03 = 0;var_03 < var_02.size;var_03++)
	{
		var_04 = var_02[var_03];
		if(isdefined(var_04.pers["team"]) && var_04.pers["team"] == param_00)
		{
			var_01++;
		}
	}

	if(var_01 < level.teamlimit)
	{
		return 1;
	}

	return 0;
}

//Function Number: 24
onplayerspawned()
{
	level endon("game_ended");
	self waittill("spawned_player");
}

//Function Number: 25
getteamname(param_00)
{
	return tablelookupistring("mp/factionTable.csv",0,game[param_00],1);
}

//Function Number: 26
getteamshortname(param_00)
{
	return tablelookupistring("mp/factionTable.csv",0,game[param_00],2);
}

//Function Number: 27
getteamforfeitedstring(param_00)
{
	return tablelookupistring("mp/factionTable.csv",0,game[param_00],4);
}

//Function Number: 28
getteameliminatedstring(param_00)
{
	return tablelookupistring("mp/factionTable.csv",0,game[param_00],3);
}

//Function Number: 29
getteamicon(param_00)
{
	return tablelookup("mp/factionTable.csv",0,game[param_00],5);
}

//Function Number: 30
getteamhudicon(param_00)
{
	return tablelookup("mp/factionTable.csv",0,game[param_00],6);
}

//Function Number: 31
init(param_00)
{
	return tablelookup("mp/factionTable.csv",0,game[param_00],17);
}

//Function Number: 32
getteamvoiceprefix(param_00)
{
	return tablelookup("mp/factionTable.csv",0,game[param_00],7);
}

//Function Number: 33
getteamspawnmusic(param_00)
{
	return tablelookup("mp/factionTable.csv",0,game[param_00],8);
}

//Function Number: 34
getteamwinmusic(param_00)
{
	return tablelookup("mp/factionTable.csv",0,game[param_00],9);
}

//Function Number: 35
getteamflagmodel(param_00)
{
	return tablelookup("mp/factionTable.csv",0,game[param_00],10);
}

//Function Number: 36
getteamflagcarrymodel(param_00)
{
	return tablelookup("mp/factionTable.csv",0,game[param_00],11);
}

//Function Number: 37
getteamflagicon(param_00)
{
	return tablelookup("mp/factionTable.csv",0,game[param_00],12);
}

//Function Number: 38
getteamflagfx(param_00)
{
	return tablelookup("mp/factionTable.csv",0,game[param_00],13);
}

//Function Number: 39
getteamcolor(param_00)
{
	return (maps\mp\_utility::stringtofloat(tablelookup("mp/factionTable.csv",0,game[param_00],14)),maps\mp\_utility::stringtofloat(tablelookup("mp/factionTable.csv",0,game[param_00],15)),maps\mp\_utility::stringtofloat(tablelookup("mp/factionTable.csv",0,game[param_00],16)));
}

//Function Number: 40
getteamcratemodel(param_00)
{
	return tablelookup("mp/factionTable.csv",0,game[param_00],18);
}

//Function Number: 41
getteamdeploymodel(param_00)
{
	return tablelookup("mp/factionTable.csv",0,game[param_00],19);
}