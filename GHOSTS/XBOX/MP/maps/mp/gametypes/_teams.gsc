/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes\_teams.gsc
 * Game: Call of Duty: Ghosts
 * Platform: Console
 * Function Count: 51
 * Decompile Time: 859 ms
 * Timestamp: 10/27/2023 1:31:44 AM
*******************************************************************/

//Function Number: 1
func_44DF()
{
	initscoreboard();
	level.teambalance = getdvarint("scr_teambalance");
	level.maxclients = getdvarint("sv_maxclients");
	setplayermodels();
	level.freeplayers = [];
	if(level.teambased)
	{
		level thread func_595D();
		level thread func_873C();
		wait(0.15);
		if(!maps\mp\_utility::func_47BB())
		{
			level thread func_8713();
			return;
		}

		return;
	}

	level thread func_593E();
	wait(0.15);
	level thread func_86EA();
}

//Function Number: 2
initscoreboard()
{
	setdvar("g_TeamName_Allies",func_3C3E("allies"));
	setdvar("g_TeamIcon_Allies",func_3C3A("allies"));
	setdvar("g_TeamIcon_MyAllies",func_3C3A("allies"));
	setdvar("g_TeamIcon_EnemyAllies",func_3C3A("allies"));
	var_00 = getteamcolor("allies");
	setdvar("g_ScoresColor_Allies",var_00[0] + " " + var_00[1] + " " + var_00[2]);
	setdvar("g_TeamName_Axis",func_3C3E("axis"));
	setdvar("g_TeamIcon_Axis",func_3C3A("axis"));
	setdvar("g_TeamIcon_MyAxis",func_3C3A("axis"));
	setdvar("g_TeamIcon_EnemyAxis",func_3C3A("axis"));
	var_00 = getteamcolor("axis");
	setdvar("g_ScoresColor_Axis",var_00[0] + " " + var_00[1] + " " + var_00[2]);
	setdvar("g_ScoresColor_Spectator",".25 .25 .25");
	setdvar("g_ScoresColor_Free",".76 .78 .10");
	setdvar("g_teamTitleColor_MyTeam",".6 .8 .6");
	setdvar("g_teamTitleColor_EnemyTeam","1 .45 .5");
}

//Function Number: 3
func_595D()
{
	for(;;)
	{
		level waittill("connected",var_00);
		var_00 thread func_5945();
		var_00 thread onjoinedspectators();
		var_00 thread onplayerspawned();
		var_00 thread func_8228();
	}
}

//Function Number: 4
func_593E()
{
	for(;;)
	{
		level waittill("connected",var_00);
		var_00 thread func_8213();
	}
}

//Function Number: 5
func_5945()
{
	self endon("disconnect");
	for(;;)
	{
		self waittill("joined_team");
		func_8742();
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
func_8228()
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

		wait(1);
	}
}

//Function Number: 8
func_8713()
{
	if(!level.rankedmatch)
	{
	}

	level endon("game_ended");
	for(;;)
	{
		maps\mp\gametypes\_hostmigration::func_8BBA();
		foreach(var_01 in level.players)
		{
			var_01 func_8710();
		}

		wait(1);
	}
}

//Function Number: 9
func_8710()
{
	if(isai(self))
	{
	}

	if(!maps\mp\_utility::func_634C())
	{
	}

	if(self.timeplayed["allies"])
	{
		if(!getactiveclientcount())
		{
			maps\mp\gametypes\_persistence::func_7B08("timePlayedAllies",self.timeplayed["allies"]);
			maps\mp\gametypes\_persistence::func_7B08("timePlayedTotal",self.timeplayed["allies"]);
		}

		maps\mp\gametypes\_persistence::func_7B0B("round","timePlayed",self.timeplayed["allies"]);
		maps\mp\gametypes\_persistence::func_7B0C("xpMultiplierTimePlayed",0,self.timeplayed["allies"],self.bufferedchildstatsmax["xpMaxMultiplierTimePlayed"][0]);
		maps\mp\gametypes\_persistence::func_7B0C("xpMultiplierTimePlayed",1,self.timeplayed["allies"],self.bufferedchildstatsmax["xpMaxMultiplierTimePlayed"][1]);
		maps\mp\gametypes\_persistence::func_7B0C("xpMultiplierTimePlayed",2,self.timeplayed["allies"],self.bufferedchildstatsmax["xpMaxMultiplierTimePlayed"][2]);
		maps\mp\gametypes\_persistence::func_7B0C("challengeXPMultiplierTimePlayed",0,self.timeplayed["allies"],self.bufferedchildstatsmax["challengeXPMaxMultiplierTimePlayed"][0]);
		maps\mp\gametypes\_persistence::func_7B0C("weaponXPMultiplierTimePlayed",0,self.timeplayed["allies"],self.bufferedchildstatsmax["weaponXPMaxMultiplierTimePlayed"][0]);
		if(getactiveclientcount())
		{
			maps\mp\gametypes\_persistence::func_7B09("prestigeDoubleXpTimePlayed",self.timeplayed["allies"],self.bufferedstatsmax["prestigeDoubleXpMaxTimePlayed"]);
			maps\mp\gametypes\_persistence::func_7B09("prestigeDoubleWeaponXpTimePlayed",self.timeplayed["allies"],self.bufferedstatsmax["prestigeDoubleWeaponXpMaxTimePlayed"]);
		}
	}

	if(self.timeplayed["axis"])
	{
		if(!getactiveclientcount())
		{
			maps\mp\gametypes\_persistence::func_7B08("timePlayedOpfor",self.timeplayed["axis"]);
			maps\mp\gametypes\_persistence::func_7B08("timePlayedTotal",self.timeplayed["axis"]);
		}

		maps\mp\gametypes\_persistence::func_7B0B("round","timePlayed",self.timeplayed["axis"]);
		maps\mp\gametypes\_persistence::func_7B0C("xpMultiplierTimePlayed",0,self.timeplayed["axis"],self.bufferedchildstatsmax["xpMaxMultiplierTimePlayed"][0]);
		maps\mp\gametypes\_persistence::func_7B0C("xpMultiplierTimePlayed",1,self.timeplayed["axis"],self.bufferedchildstatsmax["xpMaxMultiplierTimePlayed"][1]);
		maps\mp\gametypes\_persistence::func_7B0C("xpMultiplierTimePlayed",2,self.timeplayed["axis"],self.bufferedchildstatsmax["xpMaxMultiplierTimePlayed"][2]);
		maps\mp\gametypes\_persistence::func_7B0C("challengeXPMultiplierTimePlayed",0,self.timeplayed["axis"],self.bufferedchildstatsmax["challengeXPMaxMultiplierTimePlayed"][0]);
		maps\mp\gametypes\_persistence::func_7B0C("weaponXPMultiplierTimePlayed",0,self.timeplayed["axis"],self.bufferedchildstatsmax["weaponXPMaxMultiplierTimePlayed"][0]);
		if(getactiveclientcount())
		{
			maps\mp\gametypes\_persistence::func_7B09("prestigeDoubleXpTimePlayed",self.timeplayed["axis"],self.bufferedstatsmax["prestigeDoubleXpMaxTimePlayed"]);
			maps\mp\gametypes\_persistence::func_7B09("prestigeDoubleWeaponXpTimePlayed",self.timeplayed["axis"],self.bufferedstatsmax["prestigeDoubleWeaponXpMaxTimePlayed"]);
		}
	}

	if(self.timeplayed["other"])
	{
		if(!getactiveclientcount())
		{
			maps\mp\gametypes\_persistence::func_7B08("timePlayedOther",self.timeplayed["other"]);
			maps\mp\gametypes\_persistence::func_7B08("timePlayedTotal",self.timeplayed["other"]);
		}

		maps\mp\gametypes\_persistence::func_7B0B("round","timePlayed",self.timeplayed["other"]);
		maps\mp\gametypes\_persistence::func_7B0C("xpMultiplierTimePlayed",0,self.timeplayed["other"],self.bufferedchildstatsmax["xpMaxMultiplierTimePlayed"][0]);
		maps\mp\gametypes\_persistence::func_7B0C("xpMultiplierTimePlayed",1,self.timeplayed["other"],self.bufferedchildstatsmax["xpMaxMultiplierTimePlayed"][1]);
		maps\mp\gametypes\_persistence::func_7B0C("xpMultiplierTimePlayed",2,self.timeplayed["other"],self.bufferedchildstatsmax["xpMaxMultiplierTimePlayed"][2]);
		maps\mp\gametypes\_persistence::func_7B0C("challengeXPMultiplierTimePlayed",0,self.timeplayed["other"],self.bufferedchildstatsmax["challengeXPMaxMultiplierTimePlayed"][0]);
		maps\mp\gametypes\_persistence::func_7B0C("weaponXPMultiplierTimePlayed",0,self.timeplayed["other"],self.bufferedchildstatsmax["weaponXPMaxMultiplierTimePlayed"][0]);
		if(getactiveclientcount())
		{
			maps\mp\gametypes\_persistence::func_7B09("prestigeDoubleXpTimePlayed",self.timeplayed["other"],self.bufferedstatsmax["prestigeDoubleXpMaxTimePlayed"]);
			maps\mp\gametypes\_persistence::func_7B09("prestigeDoubleWeaponXpTimePlayed",self.timeplayed["other"],self.bufferedstatsmax["prestigeDoubleWeaponXpMaxTimePlayed"]);
		}
	}

	if(self.pers["rank"] != level.maxrank)
	{
		if(self.timeplayed["allies"])
		{
			maps\mp\gametypes\_persistence::stataddsquadbuffered("experienceToPrestige",self.timeplayed["allies"]);
		}
		else if(self.timeplayed["axis"])
		{
			maps\mp\gametypes\_persistence::stataddsquadbuffered("experienceToPrestige",self.timeplayed["axis"]);
		}
		else if(self.timeplayed["other"])
		{
			maps\mp\gametypes\_persistence::stataddsquadbuffered("experienceToPrestige",self.timeplayed["other"]);
		}
	}

	if(game["state"] == "postgame")
	{
	}

	self.timeplayed["allies"] = 0;
	self.timeplayed["axis"] = 0;
	self.timeplayed["other"] = 0;
}

//Function Number: 10
func_8742()
{
	if(game["state"] != "playing")
	{
	}

	self.pers["teamTime"] = gettime();
}

//Function Number: 11
func_873D()
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
func_873C()
{
	level.teamlimit = level.maxclients / 2;
	level thread func_873D();
	wait(0.15);
	if(level.teambalance && maps\mp\_utility::func_4950())
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
		}

		if(!getteambalance())
		{
			game["BalanceTeamsNextRound"] = 1;
		}
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
setplayermodels()
{
	func_7016();
	game["allies_model"]["JUGGERNAUT"] = ::maps\mp\killstreaks\_juggernaut::setjugg;
	game["axis_model"]["JUGGERNAUT"] = ::maps\mp\killstreaks\_juggernaut::setjugg;
	game["allies_model"]["JUGGERNAUT_MANIAC"] = ::maps\mp\killstreaks\_juggernaut::func_705A;
	game["axis_model"]["JUGGERNAUT_MANIAC"] = ::maps\mp\killstreaks\_juggernaut::func_705A;
}

//Function Number: 16
func_5FC9(param_00,param_01)
{
}

//Function Number: 17
func_1F84()
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

//Function Number: 18
func_7016()
{
	if(!isdefined(level.defaultheadmodels))
	{
		level.defaultheadmodels = [];
		level.defaultheadmodels["allies"] = "head_mp_head_a";
		level.defaultheadmodels["axis"] = "head_mp_head_a";
	}

	if(!isdefined(level.defaultbodymodels))
	{
		level.defaultbodymodels = [];
		level.defaultbodymodels["allies"] = "mp_body_us_rangers_assault_a_urban";
		level.defaultbodymodels["axis"] = "mp_body_us_rangers_assault_a_woodland";
	}

	if(!isdefined(level.defaultviewarmmodels))
	{
		level.defaultviewarmmodels = [];
		level.defaultviewarmmodels["allies"] = "viewhands_us_rangers_urban";
		level.defaultviewarmmodels["axis"] = "viewhands_us_rangers_woodland";
	}

	if(!isdefined(level.defaultvoices))
	{
		level.defaultvoices = [];
		level.defaultvoices["allies"] = "delta";
		level.defaultvoices["axis"] = "delta";
	}
}

//Function Number: 19
func_7000(param_00,param_01,param_02)
{
	self setmodel(param_00);
	self setviewmodel(param_02);
	self attach(param_01,"",1);
	self.headmodel = param_01;
}

//Function Number: 20
func_7073()
{
	var_00 = self getcontrollertype();
	var_01 = self getcustomizationbody();
	var_02 = self getcustomizationhead();
	func_7000(var_00,var_01,var_02);
}

//Function Number: 21
setdefaultmodel()
{
	var_00 = level.defaultbodymodels[self.team];
	var_01 = level.defaultheadmodels[self.team];
	var_02 = level.defaultviewarmmodels[self.team];
	func_7000(var_00,var_01,var_02);
}

//Function Number: 22
getplayermodelindex()
{
	if(level.rankedmatch)
	{
		return self getrankedplayerdata("squadMembers",self.pers["activeSquadMember"],"body");
	}

	return self getprivateplayerdata("privateMatchSquadMembers",self.pers["activeSquadMember"],"body");
}

//Function Number: 23
getplayerfoleytype(param_00)
{
	return tablelookup("mp/cac/bodies.csv",0,param_00,5);
}

//Function Number: 24
getplayermodelname(param_00)
{
	return tablelookup("mp/cac/bodies.csv",0,param_00,1);
}

//Function Number: 25
func_7205()
{
	if(isplayer(self))
	{
		func_7073();
	}
	else
	{
		setdefaultmodel();
	}

	if(!isai(self))
	{
		var_00 = getplayermodelindex();
		self.bodyindex = var_00;
		var_01 = getplayerfoleytype(var_00);
		self setclothtype(var_01);
	}
	else
	{
		self setclothtype("vestLight");
	}

	self.voice = level.defaultvoices[self.team];
	if(maps\mp\_utility::isanymlgmatch() && !isai(self))
	{
		var_02 = getplayermodelname(getplayermodelindex());
		if(issubstr(var_02,"fullbody_sniper"))
		{
			thread forcedefaultmodel();
		}
	}

	if(maps\mp\_utility::isjuggernaut())
	{
		if(isdefined(self.isjuggernautmaniac) && self.isjuggernautmaniac)
		{
			thread [[ game[self.team + "_model"]["JUGGERNAUT_MANIAC"] ]]();
		}

		if(isdefined(self.isjuggernautlevelcustom) && self.isjuggernautlevelcustom)
		{
			thread [[ game[self.team + "_model"]["JUGGERNAUT_CUSTOM"] ]]();
		}

		thread [[ game[self.team + "_model"]["JUGGERNAUT"] ]]();
	}
}

//Function Number: 26
forcedefaultmodel()
{
	if(isdefined(self.headmodel))
	{
		self detach(self.headmodel,"");
		self.headmodel = undefined;
	}

	if(self.team == "axis")
	{
		self setmodel("mp_body_juggernaut_light_black");
		self setviewmodel("viewhands_juggernaut_ally");
	}
	else
	{
		self setmodel("mp_body_infected_a");
		self setviewmodel("viewhands_gs_hostage");
	}

	if(isdefined(self.headmodel))
	{
		self detach(self.headmodel,"");
		self.headmodel = undefined;
	}

	self attach("head_mp_infected","",1);
	self.headmodel = "head_mp_infected";
	self setclothtype("cloth");
}

//Function Number: 27
func_8213()
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

		wait(1);
	}
}

//Function Number: 28
func_86EA()
{
	if(!level.rankedmatch)
	{
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

//Function Number: 29
updatefreeplayedtime()
{
	if(!maps\mp\_utility::func_634C())
	{
	}

	if(isai(self))
	{
	}

	if(self.timeplayed["allies"])
	{
		if(!getactiveclientcount())
		{
			maps\mp\gametypes\_persistence::func_7B08("timePlayedAllies",self.timeplayed["allies"]);
			maps\mp\gametypes\_persistence::func_7B08("timePlayedTotal",self.timeplayed["allies"]);
		}

		maps\mp\gametypes\_persistence::func_7B0B("round","timePlayed",self.timeplayed["allies"]);
		maps\mp\gametypes\_persistence::func_7B0C("xpMultiplierTimePlayed",0,self.timeplayed["allies"],self.bufferedchildstatsmax["xpMaxMultiplierTimePlayed"][0]);
		maps\mp\gametypes\_persistence::func_7B0C("xpMultiplierTimePlayed",1,self.timeplayed["allies"],self.bufferedchildstatsmax["xpMaxMultiplierTimePlayed"][1]);
		maps\mp\gametypes\_persistence::func_7B0C("xpMultiplierTimePlayed",2,self.timeplayed["allies"],self.bufferedchildstatsmax["xpMaxMultiplierTimePlayed"][2]);
		if(getactiveclientcount())
		{
			maps\mp\gametypes\_persistence::func_7B09("prestigeDoubleXpTimePlayed",self.timeplayed["allies"],self.bufferedstatsmax["prestigeDoubleXpMaxTimePlayed"]);
			maps\mp\gametypes\_persistence::func_7B09("prestigeDoubleWeaponXpTimePlayed",self.timeplayed["allies"],self.bufferedstatsmax["prestigeDoubleWeaponXpMaxTimePlayed"]);
		}
	}

	if(self.timeplayed["axis"])
	{
		if(!getactiveclientcount())
		{
			maps\mp\gametypes\_persistence::func_7B08("timePlayedOpfor",self.timeplayed["axis"]);
			maps\mp\gametypes\_persistence::func_7B08("timePlayedTotal",self.timeplayed["axis"]);
		}

		maps\mp\gametypes\_persistence::func_7B0B("round","timePlayed",self.timeplayed["axis"]);
		maps\mp\gametypes\_persistence::func_7B0C("xpMultiplierTimePlayed",0,self.timeplayed["axis"],self.bufferedchildstatsmax["xpMaxMultiplierTimePlayed"][0]);
		maps\mp\gametypes\_persistence::func_7B0C("xpMultiplierTimePlayed",1,self.timeplayed["axis"],self.bufferedchildstatsmax["xpMaxMultiplierTimePlayed"][1]);
		maps\mp\gametypes\_persistence::func_7B0C("xpMultiplierTimePlayed",2,self.timeplayed["axis"],self.bufferedchildstatsmax["xpMaxMultiplierTimePlayed"][2]);
		if(getactiveclientcount())
		{
			maps\mp\gametypes\_persistence::func_7B09("prestigeDoubleXpTimePlayed",self.timeplayed["axis"],self.bufferedstatsmax["prestigeDoubleXpMaxTimePlayed"]);
			maps\mp\gametypes\_persistence::func_7B09("prestigeDoubleWeaponXpTimePlayed",self.timeplayed["axis"],self.bufferedstatsmax["prestigeDoubleWeaponXpMaxTimePlayed"]);
		}
	}

	if(self.timeplayed["other"])
	{
		if(!getactiveclientcount())
		{
			maps\mp\gametypes\_persistence::func_7B08("timePlayedOther",self.timeplayed["other"]);
			maps\mp\gametypes\_persistence::func_7B08("timePlayedTotal",self.timeplayed["other"]);
		}

		maps\mp\gametypes\_persistence::func_7B0B("round","timePlayed",self.timeplayed["other"]);
		maps\mp\gametypes\_persistence::func_7B0C("xpMultiplierTimePlayed",0,self.timeplayed["other"],self.bufferedchildstatsmax["xpMaxMultiplierTimePlayed"][0]);
		maps\mp\gametypes\_persistence::func_7B0C("xpMultiplierTimePlayed",1,self.timeplayed["other"],self.bufferedchildstatsmax["xpMaxMultiplierTimePlayed"][1]);
		maps\mp\gametypes\_persistence::func_7B0C("xpMultiplierTimePlayed",2,self.timeplayed["other"],self.bufferedchildstatsmax["xpMaxMultiplierTimePlayed"][2]);
		if(getactiveclientcount())
		{
			maps\mp\gametypes\_persistence::func_7B09("prestigeDoubleXpTimePlayed",self.timeplayed["other"],self.bufferedstatsmax["prestigeDoubleXpMaxTimePlayed"]);
			maps\mp\gametypes\_persistence::func_7B09("prestigeDoubleWeaponXpTimePlayed",self.timeplayed["other"],self.bufferedstatsmax["prestigeDoubleWeaponXpMaxTimePlayed"]);
		}
	}

	if(game["state"] == "postgame")
	{
	}

	self.timeplayed["allies"] = 0;
	self.timeplayed["axis"] = 0;
	self.timeplayed["other"] = 0;
}

//Function Number: 30
func_3AE0(param_00)
{
	if(maps\mp\_utility::func_47BB())
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
			if(botsentientswap(var_05))
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

	if(!maps\mp\_utility::func_50C1())
	{
		return 1;
	}

	if(level.gametype == "infect")
	{
		return 1;
	}

	return 0;
}

//Function Number: 31
onplayerspawned()
{
	level endon("game_ended");
	self waittill("spawned_player");
}

//Function Number: 32
func_54F7(param_00)
{
	return tablelookupistring("mp/MTTable.csv",0,param_00,1);
}

//Function Number: 33
func_54F6(param_00)
{
	return tablelookup("mp/MTTable.csv",0,param_00,2);
}

//Function Number: 34
func_54F5(param_00)
{
	return tablelookup("mp/MTTable.csv",0,param_00,3);
}

//Function Number: 35
func_3C3D(param_00)
{
	return tablelookupistring("mp/factionTable.csv",0,game[param_00],1);
}

//Function Number: 36
func_3C3E(param_00)
{
	return tablelookupistring("mp/factionTable.csv",0,game[param_00],2);
}

//Function Number: 37
getteamforfeitedstring(param_00)
{
	return tablelookupistring("mp/factionTable.csv",0,game[param_00],4);
}

//Function Number: 38
func_3C31(param_00)
{
	return tablelookupistring("mp/factionTable.csv",0,game[param_00],3);
}

//Function Number: 39
func_3C3A(param_00)
{
	return tablelookup("mp/factionTable.csv",0,game[param_00],5);
}

//Function Number: 40
getteamhudicon(param_00)
{
	return tablelookup("mp/factionTable.csv",0,game[param_00],6);
}

//Function Number: 41
func_3C38(param_00)
{
	return tablelookup("mp/factionTable.csv",0,game[param_00],17);
}

//Function Number: 42
getteamvoiceprefix(param_00)
{
	return tablelookup("mp/factionTable.csv",0,game[param_00],7);
}

//Function Number: 43
getteamspawnmusic(param_00)
{
	return tablelookup("mp/factionTable.csv",0,game[param_00],8);
}

//Function Number: 44
getteamwinmusic(param_00)
{
	return tablelookup("mp/factionTable.csv",0,game[param_00],9);
}

//Function Number: 45
getteamflagmodel(param_00)
{
	return tablelookup("mp/factionTable.csv",0,game[param_00],10);
}

//Function Number: 46
func_3C32(param_00)
{
	return tablelookup("mp/factionTable.csv",0,game[param_00],11);
}

//Function Number: 47
func_3C35(param_00)
{
	return tablelookup("mp/factionTable.csv",0,game[param_00],12);
}

//Function Number: 48
func_3C34(param_00)
{
	return tablelookup("mp/factionTable.csv",0,game[param_00],13);
}

//Function Number: 49
getteamcolor(param_00)
{
	return (maps\mp\_utility::func_7CE9(tablelookup("mp/factionTable.csv",0,game[param_00],14)),maps\mp\_utility::func_7CE9(tablelookup("mp/factionTable.csv",0,game[param_00],15)),maps\mp\_utility::func_7CE9(tablelookup("mp/factionTable.csv",0,game[param_00],16)));
}

//Function Number: 50
getteamcratemodel(param_00)
{
	return tablelookup("mp/factionTable.csv",0,game[param_00],18);
}

//Function Number: 51
getteamdeploymodel(param_00)
{
	return tablelookup("mp/factionTable.csv",0,game[param_00],19);
}