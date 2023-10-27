/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes\_teams.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: Console
 * Function Count: 41
 * Decompile Time: 532 ms
 * Timestamp: 10/27/2023 2:25:55 AM
*******************************************************************/

//Function Number: 1
init()
{
	func_2745();
	level.teambalance = getdvarint("scr_teambalance");
	level.maxclients = getdvarint("sv_maxclients");
	level._effect["thermal_beacon"] = loadfx("misc/thermal_beacon_inverted");
	var_00 = level._effect["thermal_beacon"];
	precachefxteamthermal(var_00,"J_Spine4");
	func_2761();
	level.freeplayers = [];
	if(level.teambased)
	{
		level thread onplayerconnect();
		level thread func_2757();
		wait 0.15;
		level thread func_274C();
		return;
	}

	level thread onfreeplayerconnect();
	wait 0.15;
	level thread updatefreeplayertimes();
}

//Function Number: 2
func_2745()
{
	setdvar("g_TeamName_Allies",func_276B("allies"));
	setdvar("g_TeamIcon_Allies",getteamicon("allies"));
	setdvar("g_TeamIcon_MyAllies",getteamicon("allies"));
	setdvar("g_TeamIcon_EnemyAllies",getteamicon("allies"));
	var_00 = getteamcolor("allies");
	setdvar("g_ScoresColor_Allies",var_00[0] + " " + var_00[1] + " " + var_00[2]);
	setdvar("g_TeamName_Axis",func_276B("axis"));
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
		var_00 thread func_2747();
		var_00 thread func_2748();
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
		var_00 thread func_2765();
	}
}

//Function Number: 5
func_2747()
{
	self endon("disconnect");
	for(;;)
	{
		self waittill("joined_team");
		updateteamtime();
	}
}

//Function Number: 6
func_2748()
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
	maps\mp\_utility::func_274B("prematch_done");
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
func_274C()
{
	if(!level.rankedmatch)
	{
		return;
	}

	level endon("game_ended");
	for(;;)
	{
		maps\mp\gametypes\_hostmigration::func_273E();
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
		maps\mp\gametypes\_persistence::func_274F("timePlayedAllies",self.timeplayed["allies"]);
		maps\mp\gametypes\_persistence::func_274F("timePlayedTotal",self.timeplayed["allies"]);
		maps\mp\gametypes\_persistence::func_2750("round","timePlayed",self.timeplayed["allies"]);
		if(!self.prestigedoublexp)
		{
			maps\mp\gametypes\_persistence::stataddchildbufferedwithmax("xpMultiplierTimePlayed",0,self.timeplayed["allies"],self.bufferedchildstatsmax["xpMaxMultiplierTimePlayed"][0]);
			maps\mp\gametypes\_persistence::stataddchildbufferedwithmax("xpMultiplierTimePlayed",1,self.timeplayed["allies"],self.bufferedchildstatsmax["xpMaxMultiplierTimePlayed"][1]);
			maps\mp\gametypes\_persistence::stataddchildbufferedwithmax("xpMultiplierTimePlayed",2,self.timeplayed["allies"],self.bufferedchildstatsmax["xpMaxMultiplierTimePlayed"][2]);
		}

		maps\mp\gametypes\_persistence::stataddchildbufferedwithmax("challengeXPMultiplierTimePlayed",0,self.timeplayed["allies"],self.bufferedchildstatsmax["challengeXPMaxMultiplierTimePlayed"][0]);
		maps\mp\gametypes\_persistence::stataddchildbufferedwithmax("weaponXPMultiplierTimePlayed",0,self.timeplayed["allies"],self.bufferedchildstatsmax["weaponXPMaxMultiplierTimePlayed"][0]);
		maps\mp\gametypes\_persistence::stataddbufferedwithmax("prestigeDoubleXpTimePlayed",self.timeplayed["allies"],self.bufferedstatsmax["prestigeDoubleXpMaxTimePlayed"]);
		maps\mp\gametypes\_persistence::stataddbufferedwithmax("prestigeDoubleWeaponXpTimePlayed",self.timeplayed["allies"],self.bufferedstatsmax["prestigeDoubleWeaponXpMaxTimePlayed"]);
	}

	if(self.timeplayed["axis"])
	{
		maps\mp\gametypes\_persistence::func_274F("timePlayedOpfor",self.timeplayed["axis"]);
		maps\mp\gametypes\_persistence::func_274F("timePlayedTotal",self.timeplayed["axis"]);
		maps\mp\gametypes\_persistence::func_2750("round","timePlayed",self.timeplayed["axis"]);
		if(!self.prestigedoublexp)
		{
			maps\mp\gametypes\_persistence::stataddchildbufferedwithmax("xpMultiplierTimePlayed",0,self.timeplayed["axis"],self.bufferedchildstatsmax["xpMaxMultiplierTimePlayed"][0]);
			maps\mp\gametypes\_persistence::stataddchildbufferedwithmax("xpMultiplierTimePlayed",1,self.timeplayed["axis"],self.bufferedchildstatsmax["xpMaxMultiplierTimePlayed"][1]);
			maps\mp\gametypes\_persistence::stataddchildbufferedwithmax("xpMultiplierTimePlayed",2,self.timeplayed["axis"],self.bufferedchildstatsmax["xpMaxMultiplierTimePlayed"][2]);
		}

		maps\mp\gametypes\_persistence::stataddchildbufferedwithmax("challengeXPMultiplierTimePlayed",0,self.timeplayed["axis"],self.bufferedchildstatsmax["challengeXPMaxMultiplierTimePlayed"][0]);
		maps\mp\gametypes\_persistence::stataddchildbufferedwithmax("weaponXPMultiplierTimePlayed",0,self.timeplayed["axis"],self.bufferedchildstatsmax["weaponXPMaxMultiplierTimePlayed"][0]);
		maps\mp\gametypes\_persistence::stataddbufferedwithmax("prestigeDoubleXpTimePlayed",self.timeplayed["axis"],self.bufferedstatsmax["prestigeDoubleXpMaxTimePlayed"]);
		maps\mp\gametypes\_persistence::stataddbufferedwithmax("prestigeDoubleWeaponXpTimePlayed",self.timeplayed["axis"],self.bufferedstatsmax["prestigeDoubleWeaponXpMaxTimePlayed"]);
	}

	if(self.timeplayed["other"])
	{
		maps\mp\gametypes\_persistence::func_274F("timePlayedOther",self.timeplayed["other"]);
		maps\mp\gametypes\_persistence::func_274F("timePlayedTotal",self.timeplayed["other"]);
		maps\mp\gametypes\_persistence::func_2750("round","timePlayed",self.timeplayed["other"]);
		if(!self.prestigedoublexp)
		{
			maps\mp\gametypes\_persistence::stataddchildbufferedwithmax("xpMultiplierTimePlayed",0,self.timeplayed["other"],self.bufferedchildstatsmax["xpMaxMultiplierTimePlayed"][0]);
			maps\mp\gametypes\_persistence::stataddchildbufferedwithmax("xpMultiplierTimePlayed",1,self.timeplayed["other"],self.bufferedchildstatsmax["xpMaxMultiplierTimePlayed"][1]);
			maps\mp\gametypes\_persistence::stataddchildbufferedwithmax("xpMultiplierTimePlayed",2,self.timeplayed["other"],self.bufferedchildstatsmax["xpMaxMultiplierTimePlayed"][2]);
		}

		maps\mp\gametypes\_persistence::stataddchildbufferedwithmax("challengeXPMultiplierTimePlayed",0,self.timeplayed["other"],self.bufferedchildstatsmax["challengeXPMaxMultiplierTimePlayed"][0]);
		maps\mp\gametypes\_persistence::stataddchildbufferedwithmax("weaponXPMultiplierTimePlayed",0,self.timeplayed["other"],self.bufferedchildstatsmax["weaponXPMaxMultiplierTimePlayed"][0]);
		maps\mp\gametypes\_persistence::stataddbufferedwithmax("prestigeDoubleXpTimePlayed",self.timeplayed["other"],self.bufferedstatsmax["prestigeDoubleXpMaxTimePlayed"]);
		maps\mp\gametypes\_persistence::stataddbufferedwithmax("prestigeDoubleWeaponXpTimePlayed",self.timeplayed["other"],self.bufferedstatsmax["prestigeDoubleWeaponXpMaxTimePlayed"]);
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
func_2756()
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
func_2757()
{
	level.teamlimit = level.maxclients / 2;
	level thread func_2756();
	wait 0.15;
	if(level.teambalance && maps\mp\_utility::func_26EC())
	{
		if(isdefined(game["BalanceTeamsNextRound"]))
		{
			iprintlnbold(&"MP_AUTOBALANCE_NEXT_ROUND");
		}

		level waittill("restarting");
		if(isdefined(game["BalanceTeamsNextRound"]))
		{
			level func_275A();
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
					level func_275A();
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
func_275A()
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

		case "forest_militia":
			mptype\mptype_ally_ghillie_forest::precache();
			mptype\mptype_opforce_ghillie_militia::precache();
			game["allies_model"]["GHILLIE"] = ::mptype\mptype_ally_ghillie_forest::main;
			game["axis_model"]["GHILLIE"] = ::mptype\mptype_opforce_ghillie_militia::main;
			break;

		case "desert_militia":
			mptype\mptype_ally_ghillie_desert::precache();
			mptype\mptype_opforce_ghillie_militia::precache();
			game["allies_model"]["GHILLIE"] = ::mptype\mptype_ally_ghillie_desert::main;
			game["axis_model"]["GHILLIE"] = ::mptype\mptype_opforce_ghillie_militia::main;
			break;

		case "arctic_militia":
			mptype\mptype_ally_ghillie_arctic::precache();
			mptype\mptype_opforce_ghillie_militia::precache();
			game["allies_model"]["GHILLIE"] = ::mptype\mptype_ally_ghillie_arctic::main;
			game["axis_model"]["GHILLIE"] = ::mptype\mptype_opforce_ghillie_militia::main;
			break;

		case "urban_militia":
			mptype\mptype_ally_ghillie_urban::precache();
			mptype\mptype_opforce_ghillie_militia::precache();
			game["allies_model"]["GHILLIE"] = ::mptype\mptype_ally_ghillie_urban::main;
			game["axis_model"]["GHILLIE"] = ::mptype\mptype_opforce_ghillie_militia::main;
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
			mptype\mptype_delta_multicam_assault::precache();
			mptype\mptype_delta_multicam_lmg::precache();
			mptype\mptype_delta_multicam_smg::precache();
			mptype\mptype_delta_multicam_shotgun::precache();
			mptype\mptype_delta_multicam_sniper::precache();
			mptype\mptype_delta_multicam_riot::precache();
			mptype\mptype_ally_juggernaut::precache();
			game[param_00 + "_model"]["SNIPER"] = ::mptype\mptype_delta_multicam_sniper::main;
			game[param_00 + "_model"]["LMG"] = ::mptype\mptype_delta_multicam_lmg::main;
			game[param_00 + "_model"]["ASSAULT"] = ::mptype\mptype_delta_multicam_assault::main;
			game[param_00 + "_model"]["SHOTGUN"] = ::mptype\mptype_delta_multicam_shotgun::main;
			game[param_00 + "_model"]["SMG"] = ::mptype\mptype_delta_multicam_smg::main;
			game[param_00 + "_model"]["RIOT"] = ::mptype\mptype_delta_multicam_riot::main;
			game[param_00 + "_model"]["JUGGERNAUT"] = ::mptype\mptype_ally_juggernaut::main;
			break;

		case "sas_urban":
			mptype\mptype_sas_urban_assault::precache();
			mptype\mptype_sas_urban_lmg::precache();
			mptype\mptype_sas_urban_shotgun::precache();
			mptype\mptype_sas_urban_smg::precache();
			mptype\mptype_sas_urban_sniper::precache();
			mptype\mptype_ally_juggernaut::precache();
			game[param_00 + "_model"]["SNIPER"] = ::mptype\mptype_sas_urban_sniper::main;
			game[param_00 + "_model"]["LMG"] = ::mptype\mptype_sas_urban_lmg::main;
			game[param_00 + "_model"]["ASSAULT"] = ::mptype\mptype_sas_urban_assault::main;
			game[param_00 + "_model"]["SHOTGUN"] = ::mptype\mptype_sas_urban_shotgun::main;
			game[param_00 + "_model"]["SMG"] = ::mptype\mptype_sas_urban_smg::main;
			game[param_00 + "_model"]["RIOT"] = ::mptype\mptype_sas_urban_smg::main;
			game[param_00 + "_model"]["JUGGERNAUT"] = ::mptype\mptype_ally_juggernaut::main;
			break;

		case "gign_paris":
			mptype\mptype_gign_paris_assault::precache();
			mptype\mptype_gign_paris_lmg::precache();
			mptype\mptype_gign_paris_shotgun::precache();
			mptype\mptype_gign_paris_smg::precache();
			mptype\mptype_gign_paris_sniper::precache();
			mptype\mptype_gign_paris_riot::precache();
			mptype\mptype_ally_juggernaut::precache();
			game[param_00 + "_model"]["SNIPER"] = ::mptype\mptype_gign_paris_sniper::main;
			game[param_00 + "_model"]["LMG"] = ::mptype\mptype_gign_paris_lmg::main;
			game[param_00 + "_model"]["ASSAULT"] = ::mptype\mptype_gign_paris_assault::main;
			game[param_00 + "_model"]["SHOTGUN"] = ::mptype\mptype_gign_paris_shotgun::main;
			game[param_00 + "_model"]["SMG"] = ::mptype\mptype_gign_paris_smg::main;
			game[param_00 + "_model"]["RIOT"] = ::mptype\mptype_gign_paris_riot::main;
			game[param_00 + "_model"]["JUGGERNAUT"] = ::mptype\mptype_ally_juggernaut::main;
			break;

		case "pmc_africa":
			mptype\mptype_pmc_africa_assault::precache();
			mptype\mptype_pmc_africa_lmg::precache();
			mptype\mptype_pmc_africa_smg::precache();
			mptype\mptype_pmc_africa_shotgun::precache();
			mptype\mptype_pmc_africa_sniper::precache();
			mptype\mptype_pmc_africa_riot::precache();
			mptype\mptype_ally_juggernaut::precache();
			game[param_00 + "_model"]["SNIPER"] = ::mptype\mptype_pmc_africa_sniper::main;
			game[param_00 + "_model"]["LMG"] = ::mptype\mptype_pmc_africa_lmg::main;
			game[param_00 + "_model"]["ASSAULT"] = ::mptype\mptype_pmc_africa_assault::main;
			game[param_00 + "_model"]["SHOTGUN"] = ::mptype\mptype_pmc_africa_shotgun::main;
			game[param_00 + "_model"]["SMG"] = ::mptype\mptype_pmc_africa_smg::main;
			game[param_00 + "_model"]["RIOT"] = ::mptype\mptype_pmc_africa_riot::main;
			game[param_00 + "_model"]["JUGGERNAUT"] = ::mptype\mptype_ally_juggernaut::main;
			break;

		case "opforce_air":
			mptype\mptype_opforce_air_assault::precache();
			mptype\mptype_opforce_air_lmg::precache();
			mptype\mptype_opforce_air_shotgun::precache();
			mptype\mptype_opforce_air_smg::precache();
			mptype\mptype_opforce_air_sniper::precache();
			mptype\mptype_opforce_air_riot::precache();
			mptype\mptype_opforce_juggernaut::precache();
			game[param_00 + "_model"]["SNIPER"] = ::mptype\mptype_opforce_air_sniper::main;
			game[param_00 + "_model"]["LMG"] = ::mptype\mptype_opforce_air_lmg::main;
			game[param_00 + "_model"]["ASSAULT"] = ::mptype\mptype_opforce_air_assault::main;
			game[param_00 + "_model"]["SHOTGUN"] = ::mptype\mptype_opforce_air_shotgun::main;
			game[param_00 + "_model"]["SMG"] = ::mptype\mptype_opforce_air_smg::main;
			game[param_00 + "_model"]["RIOT"] = ::mptype\mptype_opforce_air_riot::main;
			game[param_00 + "_model"]["JUGGERNAUT"] = ::mptype\mptype_opforce_juggernaut::main;
			break;

		case "opforce_snow":
			mptype\mptype_opforce_snow_assault::precache();
			mptype\mptype_opforce_snow_lmg::precache();
			mptype\mptype_opforce_snow_shotgun::precache();
			mptype\mptype_opforce_snow_smg::precache();
			mptype\mptype_opforce_snow_sniper::precache();
			mptype\mptype_opforce_snow_riot::precache();
			mptype\mptype_opforce_juggernaut::precache();
			game[param_00 + "_model"]["SNIPER"] = ::mptype\mptype_opforce_snow_sniper::main;
			game[param_00 + "_model"]["LMG"] = ::mptype\mptype_opforce_snow_lmg::main;
			game[param_00 + "_model"]["ASSAULT"] = ::mptype\mptype_opforce_snow_assault::main;
			game[param_00 + "_model"]["SHOTGUN"] = ::mptype\mptype_opforce_snow_shotgun::main;
			game[param_00 + "_model"]["SMG"] = ::mptype\mptype_opforce_snow_smg::main;
			game[param_00 + "_model"]["RIOT"] = ::mptype\mptype_opforce_snow_riot::main;
			game[param_00 + "_model"]["JUGGERNAUT"] = ::mptype\mptype_opforce_juggernaut::main;
			break;

		case "opforce_urban":
			mptype\mptype_opforce_urban_assault::precache();
			mptype\mptype_opforce_urban_lmg::precache();
			mptype\mptype_opforce_urban_shotgun::precache();
			mptype\mptype_opforce_urban_smg::precache();
			mptype\mptype_opforce_urban_sniper::precache();
			mptype\mptype_opforce_urban_riot::precache();
			mptype\mptype_opforce_juggernaut::precache();
			game[param_00 + "_model"]["SNIPER"] = ::mptype\mptype_opforce_urban_sniper::main;
			game[param_00 + "_model"]["LMG"] = ::mptype\mptype_opforce_urban_lmg::main;
			game[param_00 + "_model"]["ASSAULT"] = ::mptype\mptype_opforce_urban_assault::main;
			game[param_00 + "_model"]["SHOTGUN"] = ::mptype\mptype_opforce_urban_shotgun::main;
			game[param_00 + "_model"]["SMG"] = ::mptype\mptype_opforce_urban_smg::main;
			game[param_00 + "_model"]["RIOT"] = ::mptype\mptype_opforce_urban_riot::main;
			game[param_00 + "_model"]["JUGGERNAUT"] = ::mptype\mptype_opforce_juggernaut::main;
			break;

		case "opforce_woodland":
			mptype\mptype_opforce_woodland_assault::precache();
			mptype\mptype_opforce_woodland_lmg::precache();
			mptype\mptype_opforce_woodland_shotgun::precache();
			mptype\mptype_opforce_woodland_smg::precache();
			mptype\mptype_opforce_woodland_sniper::precache();
			mptype\mptype_opforce_woodland_riot::precache();
			mptype\mptype_opforce_juggernaut::precache();
			game[param_00 + "_model"]["SNIPER"] = ::mptype\mptype_opforce_woodland_sniper::main;
			game[param_00 + "_model"]["LMG"] = ::mptype\mptype_opforce_woodland_lmg::main;
			game[param_00 + "_model"]["ASSAULT"] = ::mptype\mptype_opforce_woodland_assault::main;
			game[param_00 + "_model"]["SHOTGUN"] = ::mptype\mptype_opforce_woodland_shotgun::main;
			game[param_00 + "_model"]["SMG"] = ::mptype\mptype_opforce_woodland_smg::main;
			game[param_00 + "_model"]["RIOT"] = ::mptype\mptype_opforce_woodland_riot::main;
			game[param_00 + "_model"]["JUGGERNAUT"] = ::mptype\mptype_opforce_juggernaut::main;
			break;

		case "opforce_africa":
			mptype\mptype_opforce_africa_assault::precache();
			mptype\mptype_opforce_africa_lmg::precache();
			mptype\mptype_opforce_africa_shotgun::precache();
			mptype\mptype_opforce_africa_smg::precache();
			mptype\mptype_opforce_africa_sniper::precache();
			mptype\mptype_opforce_africa_riot::precache();
			mptype\mptype_opforce_juggernaut::precache();
			game[param_00 + "_model"]["SNIPER"] = ::mptype\mptype_opforce_africa_lmg::main;
			game[param_00 + "_model"]["LMG"] = ::mptype\mptype_opforce_africa_lmg::main;
			game[param_00 + "_model"]["ASSAULT"] = ::mptype\mptype_opforce_africa_assault::main;
			game[param_00 + "_model"]["SHOTGUN"] = ::mptype\mptype_opforce_africa_shotgun::main;
			game[param_00 + "_model"]["SMG"] = ::mptype\mptype_opforce_africa_smg::main;
			game[param_00 + "_model"]["RIOT"] = ::mptype\mptype_opforce_africa_riot::main;
			game[param_00 + "_model"]["JUGGERNAUT"] = ::mptype\mptype_opforce_juggernaut::main;
			break;

		case "opforce_henchmen":
			mptype\mptype_opforce_henchmen_assault::precache();
			mptype\mptype_opforce_henchmen_lmg::precache();
			mptype\mptype_opforce_henchmen_shotgun::precache();
			mptype\mptype_opforce_henchmen_smg::precache();
			mptype\mptype_opforce_henchmen_sniper::precache();
			mptype\mptype_opforce_henchmen_riot::precache();
			mptype\mptype_opforce_juggernaut::precache();
			game[param_00 + "_model"]["SNIPER"] = ::mptype\mptype_opforce_henchmen_sniper::main;
			game[param_00 + "_model"]["LMG"] = ::mptype\mptype_opforce_henchmen_lmg::main;
			game[param_00 + "_model"]["ASSAULT"] = ::mptype\mptype_opforce_henchmen_assault::main;
			game[param_00 + "_model"]["SHOTGUN"] = ::mptype\mptype_opforce_henchmen_shotgun::main;
			game[param_00 + "_model"]["SMG"] = ::mptype\mptype_opforce_henchmen_smg::main;
			game[param_00 + "_model"]["RIOT"] = ::mptype\mptype_opforce_henchmen_riot::main;
			game[param_00 + "_model"]["JUGGERNAUT"] = ::mptype\mptype_opforce_juggernaut::main;
			break;
	}
}

//Function Number: 17
func_2761()
{
	setteammodels("allies",game["allies"]);
	setteammodels("axis",game["axis"]);
	setghilliemodels(getmapcustom("environment"));
}

//Function Number: 18
func_2762(param_00,param_01)
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
func_2764()
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
func_2765()
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
		maps\mp\gametypes\_persistence::func_274F("timePlayedAllies",self.timeplayed["allies"]);
		maps\mp\gametypes\_persistence::func_274F("timePlayedTotal",self.timeplayed["allies"]);
		maps\mp\gametypes\_persistence::func_2750("round","timePlayed",self.timeplayed["allies"]);
		if(!self.prestigedoublexp)
		{
			maps\mp\gametypes\_persistence::stataddchildbufferedwithmax("xpMultiplierTimePlayed",0,self.timeplayed["allies"],self.bufferedchildstatsmax["xpMaxMultiplierTimePlayed"][0]);
			maps\mp\gametypes\_persistence::stataddchildbufferedwithmax("xpMultiplierTimePlayed",1,self.timeplayed["allies"],self.bufferedchildstatsmax["xpMaxMultiplierTimePlayed"][1]);
			maps\mp\gametypes\_persistence::stataddchildbufferedwithmax("xpMultiplierTimePlayed",2,self.timeplayed["allies"],self.bufferedchildstatsmax["xpMaxMultiplierTimePlayed"][2]);
		}

		maps\mp\gametypes\_persistence::stataddbufferedwithmax("prestigeDoubleXpTimePlayed",self.timeplayed["allies"],self.bufferedstatsmax["prestigeDoubleXpMaxTimePlayed"]);
		maps\mp\gametypes\_persistence::stataddbufferedwithmax("prestigeDoubleWeaponXpTimePlayed",self.timeplayed["allies"],self.bufferedstatsmax["prestigeDoubleWeaponXpMaxTimePlayed"]);
	}

	if(self.timeplayed["axis"])
	{
		maps\mp\gametypes\_persistence::func_274F("timePlayedOpfor",self.timeplayed["axis"]);
		maps\mp\gametypes\_persistence::func_274F("timePlayedTotal",self.timeplayed["axis"]);
		maps\mp\gametypes\_persistence::func_2750("round","timePlayed",self.timeplayed["axis"]);
		if(!self.prestigedoublexp)
		{
			maps\mp\gametypes\_persistence::stataddchildbufferedwithmax("xpMultiplierTimePlayed",0,self.timeplayed["axis"],self.bufferedchildstatsmax["xpMaxMultiplierTimePlayed"][0]);
			maps\mp\gametypes\_persistence::stataddchildbufferedwithmax("xpMultiplierTimePlayed",1,self.timeplayed["axis"],self.bufferedchildstatsmax["xpMaxMultiplierTimePlayed"][1]);
			maps\mp\gametypes\_persistence::stataddchildbufferedwithmax("xpMultiplierTimePlayed",2,self.timeplayed["axis"],self.bufferedchildstatsmax["xpMaxMultiplierTimePlayed"][2]);
		}

		maps\mp\gametypes\_persistence::stataddbufferedwithmax("prestigeDoubleXpTimePlayed",self.timeplayed["axis"],self.bufferedstatsmax["prestigeDoubleXpMaxTimePlayed"]);
		maps\mp\gametypes\_persistence::stataddbufferedwithmax("prestigeDoubleWeaponXpTimePlayed",self.timeplayed["axis"],self.bufferedstatsmax["prestigeDoubleWeaponXpMaxTimePlayed"]);
	}

	if(self.timeplayed["other"])
	{
		maps\mp\gametypes\_persistence::func_274F("timePlayedOther",self.timeplayed["other"]);
		maps\mp\gametypes\_persistence::func_274F("timePlayedTotal",self.timeplayed["other"]);
		maps\mp\gametypes\_persistence::func_2750("round","timePlayed",self.timeplayed["other"]);
		if(!self.prestigedoublexp)
		{
			maps\mp\gametypes\_persistence::stataddchildbufferedwithmax("xpMultiplierTimePlayed",0,self.timeplayed["other"],self.bufferedchildstatsmax["xpMaxMultiplierTimePlayed"][0]);
			maps\mp\gametypes\_persistence::stataddchildbufferedwithmax("xpMultiplierTimePlayed",1,self.timeplayed["other"],self.bufferedchildstatsmax["xpMaxMultiplierTimePlayed"][1]);
			maps\mp\gametypes\_persistence::stataddchildbufferedwithmax("xpMultiplierTimePlayed",2,self.timeplayed["other"],self.bufferedchildstatsmax["xpMaxMultiplierTimePlayed"][2]);
		}

		maps\mp\gametypes\_persistence::stataddbufferedwithmax("prestigeDoubleXpTimePlayed",self.timeplayed["other"],self.bufferedstatsmax["prestigeDoubleXpMaxTimePlayed"]);
		maps\mp\gametypes\_persistence::stataddbufferedwithmax("prestigeDoubleWeaponXpTimePlayed",self.timeplayed["other"],self.bufferedstatsmax["prestigeDoubleWeaponXpMaxTimePlayed"]);
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
func_276B(param_00)
{
	return tablelookupistring("mp/factionTable.csv",0,game[param_00],2);
}

//Function Number: 27
getteamforfeitedstring(param_00)
{
	return tablelookupistring("mp/factionTable.csv",0,game[param_00],4);
}

//Function Number: 28
func_276D(param_00)
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
func_2770(param_00)
{
	return tablelookup("mp/factionTable.csv",0,game[param_00],17);
}

//Function Number: 32
getteamvoiceprefix(param_00)
{
	return tablelookup("mp/factionTable.csv",0,game[param_00],7);
}

//Function Number: 33
func_2772(param_00)
{
	return tablelookup("mp/factionTable.csv",0,game[param_00],8);
}

//Function Number: 34
func_2773(param_00)
{
	return tablelookup("mp/factionTable.csv",0,game[param_00],9);
}

//Function Number: 35
func_2774(param_00)
{
	return tablelookup("mp/factionTable.csv",0,game[param_00],10);
}

//Function Number: 36
func_2775(param_00)
{
	return tablelookup("mp/factionTable.csv",0,game[param_00],11);
}

//Function Number: 37
func_2776(param_00)
{
	return tablelookup("mp/factionTable.csv",0,game[param_00],12);
}

//Function Number: 38
func_2777(param_00)
{
	return tablelookup("mp/factionTable.csv",0,game[param_00],13);
}

//Function Number: 39
getteamcolor(param_00)
{
	return (maps\mp\_utility::func_EBF(tablelookup("mp/factionTable.csv",0,game[param_00],14)),maps\mp\_utility::func_EBF(tablelookup("mp/factionTable.csv",0,game[param_00],15)),maps\mp\_utility::func_EBF(tablelookup("mp/factionTable.csv",0,game[param_00],16)));
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