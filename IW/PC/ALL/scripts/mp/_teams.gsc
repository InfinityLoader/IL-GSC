/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\mp\_teams.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 55
 * Decompile Time: 2194 ms
 * Timestamp: 10/27/2023 12:21:48 AM
*******************************************************************/

//Function Number: 1
init()
{
	level.var_115C1 = getdvarint("scr_teambalance");
	level.maxclients = getmaxclients();
	func_F7F6();
	level.var_7371 = [];
	if(level.teambased)
	{
		level thread func_C56E();
		level thread func_12F37();
		wait(0.15);
		level thread func_12EF3();
		level thread finalizeplayertimes();
	}
	else
	{
		level thread func_C532();
		wait(0.15);
		level thread func_12E95();
	}

	if(scripts\mp\_utility::func_B3EC())
	{
		level thread watchafk();
	}
}

//Function Number: 2
func_C56E()
{
	for(;;)
	{
		level waittill("connected",var_00);
		var_00 thread func_C541();
		var_00 thread func_C540();
		var_00 thread func_C57B();
		var_00 thread func_11B01();
	}
}

//Function Number: 3
func_C532()
{
	for(;;)
	{
		level waittill("connected",var_00);
		var_00 thread func_11B01();
	}
}

//Function Number: 4
func_C541()
{
	self endon("disconnect");
	for(;;)
	{
		self waittill("joined_team");
		func_12F3E();
	}
}

//Function Number: 5
func_C540()
{
	self endon("disconnect");
	for(;;)
	{
		self waittill("joined_spectators");
		self.pers["teamTime"] = undefined;
	}
}

//Function Number: 6
func_11B01()
{
	self endon("disconnect");
	self.var_1190E["allies"] = 0;
	self.var_1190E["axis"] = 0;
	self.var_1190E["free"] = 0;
	self.var_1190E["other"] = 0;
	self.var_1190E["total"] = 0;
	self.var_1190E["missionTeam"] = 0;
	if(!isdefined(self.pers["validKickTime"]))
	{
		self.pers["validKickTime"] = 0;
	}

	scripts\mp\_utility::func_7670("prematch_done");
	while(!level.var_7669)
	{
		wait(1);
		if(self.sessionteam == "allies")
		{
			self.var_1190E["allies"]++;
			self.var_1190E["total"]++;
			self.var_1190E["missionTeam"]++;
			if(scripts\mp\_utility::func_9F19(self))
			{
				self.pers["validKickTime"]++;
			}

			continue;
		}

		if(self.sessionteam == "axis")
		{
			self.var_1190E["axis"]++;
			self.var_1190E["total"]++;
			self.var_1190E["missionTeam"]++;
			if(scripts\mp\_utility::func_9F19(self))
			{
				self.pers["validKickTime"]++;
			}

			continue;
		}

		if(self.sessionteam == "none")
		{
			if(isdefined(self.pers["team"]) && self.pers["team"] == "allies")
			{
				self.var_1190E["allies"]++;
			}
			else if(isdefined(self.pers["team"]) && self.pers["team"] == "axis")
			{
				self.var_1190E["axis"]++;
			}

			self.var_1190E["total"]++;
			self.var_1190E["missionTeam"]++;
			if(scripts\mp\_utility::func_9F19(self))
			{
				self.pers["validKickTime"]++;
			}

			continue;
		}

		if(self.sessionteam == "spectator")
		{
			self.var_1190E["other"]++;
		}
	}
}

//Function Number: 7
func_12EF3()
{
	level endon("game_ended");
	for(;;)
	{
		scripts\mp\_hostmigration::func_13834();
		foreach(var_01 in level.players)
		{
			var_01 func_12EEE();
		}

		wait(10);
	}
}

//Function Number: 8
finalizeplayertimes()
{
	while(!level.var_7669)
	{
		wait(2);
	}

	foreach(var_01 in level.players)
	{
		var_01 func_12EEE();
		var_01 scripts\mp\_persistence::func_13E04();
		var_01 scripts\mp\_persistence::func_12F5E();
	}
}

//Function Number: 9
func_12EEE()
{
	if(isai(self))
	{
		return;
	}

	if(!scripts\mp\_utility::func_DCD5())
	{
		if(self.var_1190E["allies"])
		{
			scripts\mp\_persistence::func_10E13("timePlayedAllies",self.var_1190E["allies"],1);
			scripts\mp\_persistence::func_10E13("timePlayedTotal",self.var_1190E["allies"],1);
			scripts\mp\_persistence::func_10E16("round","timePlayed",self.var_1190E["allies"],1);
		}

		if(self.var_1190E["axis"])
		{
			scripts\mp\_persistence::func_10E13("timePlayedOpfor",self.var_1190E["axis"],1);
			scripts\mp\_persistence::func_10E13("timePlayedTotal",self.var_1190E["axis"],1);
			scripts\mp\_persistence::func_10E16("round","timePlayed",self.var_1190E["axis"],1);
		}

		if(self.var_1190E["other"])
		{
			scripts\mp\_persistence::func_10E13("timePlayedOther",self.var_1190E["other"],1);
			scripts\mp\_persistence::func_10E13("timePlayedTotal",self.var_1190E["other"],1);
			scripts\mp\_persistence::func_10E16("round","timePlayed",self.var_1190E["other"],1);
		}
	}
	else
	{
		if(self.var_1190E["allies"])
		{
			scripts\mp\_persistence::func_10E13("timePlayedAllies",self.var_1190E["allies"]);
			scripts\mp\_persistence::func_10E13("timePlayedTotal",self.var_1190E["allies"]);
			scripts\mp\_persistence::func_10E16("round","timePlayed",self.var_1190E["allies"]);
			scripts\mp\_persistence::func_10E17("xpMultiplierTimePlayed",0,self.var_1190E["allies"],self.var_316A["xpMaxMultiplierTimePlayed"][0]);
			scripts\mp\_persistence::func_10E17("xpMultiplierTimePlayed",1,self.var_1190E["allies"],self.var_316A["xpMaxMultiplierTimePlayed"][1]);
			scripts\mp\_persistence::func_10E17("xpMultiplierTimePlayed",2,self.var_1190E["allies"],self.var_316A["xpMaxMultiplierTimePlayed"][2]);
			scripts\mp\_persistence::func_10E17("challengeXPMultiplierTimePlayed",0,self.var_1190E["allies"],self.var_316A["challengeXPMaxMultiplierTimePlayed"][0]);
			scripts\mp\_persistence::func_10E17("weaponXPMultiplierTimePlayed",0,self.var_1190E["allies"],self.var_316A["weaponXPMaxMultiplierTimePlayed"][0]);
		}

		if(self.var_1190E["axis"])
		{
			scripts\mp\_persistence::func_10E13("timePlayedOpfor",self.var_1190E["axis"]);
			scripts\mp\_persistence::func_10E13("timePlayedTotal",self.var_1190E["axis"]);
			scripts\mp\_persistence::func_10E16("round","timePlayed",self.var_1190E["axis"]);
			scripts\mp\_persistence::func_10E17("xpMultiplierTimePlayed",0,self.var_1190E["axis"],self.var_316A["xpMaxMultiplierTimePlayed"][0]);
			scripts\mp\_persistence::func_10E17("xpMultiplierTimePlayed",1,self.var_1190E["axis"],self.var_316A["xpMaxMultiplierTimePlayed"][1]);
			scripts\mp\_persistence::func_10E17("xpMultiplierTimePlayed",2,self.var_1190E["axis"],self.var_316A["xpMaxMultiplierTimePlayed"][2]);
			scripts\mp\_persistence::func_10E17("challengeXPMultiplierTimePlayed",0,self.var_1190E["axis"],self.var_316A["challengeXPMaxMultiplierTimePlayed"][0]);
			scripts\mp\_persistence::func_10E17("weaponXPMultiplierTimePlayed",0,self.var_1190E["axis"],self.var_316A["weaponXPMaxMultiplierTimePlayed"][0]);
		}

		if(self.var_1190E["other"])
		{
			scripts\mp\_persistence::func_10E13("timePlayedOther",self.var_1190E["other"]);
			scripts\mp\_persistence::func_10E13("timePlayedTotal",self.var_1190E["other"]);
			scripts\mp\_persistence::func_10E16("round","timePlayed",self.var_1190E["other"]);
			scripts\mp\_persistence::func_10E17("xpMultiplierTimePlayed",0,self.var_1190E["other"],self.var_316A["xpMaxMultiplierTimePlayed"][0]);
			scripts\mp\_persistence::func_10E17("xpMultiplierTimePlayed",1,self.var_1190E["other"],self.var_316A["xpMaxMultiplierTimePlayed"][1]);
			scripts\mp\_persistence::func_10E17("xpMultiplierTimePlayed",2,self.var_1190E["other"],self.var_316A["xpMaxMultiplierTimePlayed"][2]);
			scripts\mp\_persistence::func_10E17("challengeXPMultiplierTimePlayed",0,self.var_1190E["other"],self.var_316A["challengeXPMaxMultiplierTimePlayed"][0]);
			scripts\mp\_persistence::func_10E17("weaponXPMultiplierTimePlayed",0,self.var_1190E["other"],self.var_316A["weaponXPMaxMultiplierTimePlayed"][0]);
		}

		if(self.var_1190E["missionTeam"])
		{
			if(scripts\mp\_utility::func_DCD5() && isdefined(self.var_9978) && isdefined(self.var_9978.var_4C0D))
			{
				var_00 = self.var_B8D4;
				var_01 = self getplayerdata("mp","missionTeamPerformanceData",var_00,"timePlayed");
				self setplayerdata("mp","missionTeamPerformanceData",var_00,"timePlayed",var_01 + self.var_1190E["missionTeam"]);
			}
		}
	}

	if(game["state"] == "postgame")
	{
		return;
	}

	self.var_1190E["allies"] = 0;
	self.var_1190E["axis"] = 0;
	self.var_1190E["other"] = 0;
	self.var_1190E["missionTeam"] = 0;
}

//Function Number: 10
func_12F3E()
{
	if(game["state"] != "playing")
	{
		return;
	}

	self.pers["teamTime"] = gettime();
}

//Function Number: 11
func_12F38()
{
	for(;;)
	{
		var_00 = getdvarint("scr_teambalance");
		if(level.var_115C1 != var_00)
		{
			level.var_115C1 = getdvarint("scr_teambalance");
		}

		wait(1);
	}
}

//Function Number: 12
func_12F37()
{
	level.teamlimit = level.maxclients / 2;
	level thread func_12F38();
	wait(0.15);
	if(level.var_115C1 && scripts\mp\_utility::func_9F32())
	{
		if(isdefined(game["BalanceTeamsNextRound"]))
		{
			scripts\mp\_hud_message::func_10123("MP_AUTOBALANCE_NEXT_ROUND");
		}

		level waittill("restarting");
		if(isdefined(game["BalanceTeamsNextRound"]))
		{
			level func_2765();
			game["BalanceTeamsNextRound"] = undefined;
			return;
		}

		if(!func_81A2())
		{
			game["BalanceTeamsNextRound"] = 1;
			return;
		}

		return;
	}

	level endon("game_ended");
	for(;;)
	{
		if(level.var_115C1)
		{
			if(!func_81A2())
			{
				scripts\mp\_hud_message::func_10123("MP_AUTOBALANCE_SECONDS",15);
				wait(15);
				if(!func_81A2())
				{
					level func_2765();
				}
			}

			wait(59);
		}

		wait(1);
	}
}

//Function Number: 13
func_81A2()
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

	if(level.team["allies"] > level.team["axis"] + level.var_115C1 || level.team["axis"] > level.team["allies"] + level.var_115C1)
	{
		return 0;
	}

	return 1;
}

//Function Number: 14
func_2765()
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
				if(isdefined(var_00[var_05].var_5940))
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

			var_04 [[ level.var_C5B1 ]]("axis");
		}
		else if(var_01.size > var_00.size + 1)
		{
			for(var_05 = 0;var_05 < var_01.size;var_05++)
			{
				if(isdefined(var_01[var_05].var_5940))
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

			var_04 [[ level.var_C5B1 ]]("allies");
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
func_F7F6()
{
	func_F6B8();
}

//Function Number: 16
func_D3D8(param_00,param_01)
{
}

//Function Number: 17
func_46BB()
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
func_F6B8()
{
	if(!isdefined(level.var_503D))
	{
		level.var_503D = [];
		level.var_503D["allies"] = "mp_warfighter_head_1_3";
		level.var_503D["axis"] = "mp_warfighter_head_1_3";
	}

	if(!isdefined(level.var_5033))
	{
		level.var_5033 = [];
		level.var_5033["allies"] = "mp_warfighter_body_1_3";
		level.var_5033["axis"] = "mp_warfighter_body_1_3";
	}

	if(!isdefined(level.var_5050))
	{
		level.var_5050 = [];
		level.var_5050["allies"] = "viewhands_us_rangers_urban";
		level.var_5050["axis"] = "viewhands_us_rangers_woodland";
	}

	if(!isdefined(level.var_5052))
	{
		level.var_5052 = [];
		level.var_5052["allies"] = "delta";
		level.var_5052["axis"] = "delta";
	}
}

//Function Number: 19
func_F68D(param_00,param_01,param_02)
{
	if(isdefined(self.var_8C98))
	{
		self detach(self.var_8C98);
	}

	self setmodel(param_00);
	self method_8369(param_02);
	self attach(param_01,"",1);
	self.var_8C98 = param_01;
}

//Function Number: 20
func_72A5(param_00)
{
	var_01 = undefined;
	var_02 = undefined;
	var_03 = [];
	switch(param_00)
	{
		case 1:
			var_01 = "mp_warfighter_body_1_3";
			var_02 = "mp_warfighter_head_1_3";
			break;

		case 2:
			var_01 = "mp_body_heavy_1_2";
			var_02 = "mp_head_heavy_1_2";
			break;

		case 3:
			if(level.gametype == "infect")
			{
				var_01 = "mp_synaptic_body_1_4";
				var_02 = "mp_synaptic_head_1_4";
			}
			else
			{
				var_01 = "mp_synaptic_body_1_1";
				var_02 = "mp_synaptic_head_1_1";
			}
			break;

		case 4:
			var_01 = "mp_ftl_body_3_1";
			var_02 = "mp_ftl_head_5_1";
			break;

		case 5:
			var_01 = "mp_stryker_body_2_1";
			var_02 = "mp_stryker_head_3_1";
			break;

		case 6:
			var_01 = "mp_ghost_body_1_3";
			var_02 = "mp_ghost_head_1_1";
			break;
	}

	self setcustomization(var_01,var_02);
	var_04 = self method_8119();
	var_05 = self method_811A();
	var_06 = self method_811B();
	func_F68D(var_04,var_05,var_06);
}

//Function Number: 21
func_7E55()
{
	var_00 = undefined;
	var_01 = undefined;
	var_02 = [];
	var_03 = func_8078();
	var_04 = func_8073();
	self.var_6A = var_03;
	self.var_171 = var_04;
	var_00 = tablelookupbyrow("mp/cac/bodies.csv",var_03,1);
	var_01 = tablelookupbyrow("mp/cac/heads.csv",var_04,1);
	var_02["body"] = var_00;
	var_02["head"] = var_01;
	return var_02;
}

//Function Number: 22
func_F7A2()
{
	var_00 = func_7E55();
	self setcustomization(var_00["body"],var_00["head"]);
	var_01 = self method_8119();
	var_02 = self method_811A();
	var_03 = self method_811B();
	func_F68D(var_01,var_02,var_03);
}

//Function Number: 23
func_F6BE()
{
	var_00 = level.var_5033[self.team];
	var_01 = level.var_503D[self.team];
	var_02 = level.var_5050[self.team];
	func_F68D(var_00,var_01,var_02);
}

//Function Number: 24
func_8078()
{
	if(level.rankedmatch)
	{
		return self getplayerdata("rankedloadouts","squadMembers","body");
	}

	return self getplayerdata("privateloadouts","squadMembers","body");
}

//Function Number: 25
func_8073()
{
	if(level.rankedmatch)
	{
		return self getplayerdata("rankedloadouts","squadMembers","head");
	}

	return self getplayerdata("privateloadouts","squadMembers","head");
}

//Function Number: 26
func_8070(param_00)
{
	return tablelookup("mp/cac/bodies.csv",0,param_00,5);
}

//Function Number: 27
func_8079(param_00)
{
	return tablelookup("mp/cac/bodies.csv",0,param_00,1);
}

//Function Number: 28
func_FADC()
{
	if(isai(self) || level.gametype == "infect" && self.team == "allies" && isdefined(self.infected_archtype) && self.infected_archtype == "archetype_scout")
	{
		var_00 = lib_0D69::func_80F3(self.var_AE62) + 1;
	}
	else if(isdefined(self.var_3C56))
	{
		var_00 = lib_0D69::func_80F3(self.var_3C56.var_2123) + 1;
	}
	else
	{
		var_00 = getdvarint("forceArchetype",0);
	}

	if(level.gametype == "infect" && self.team == "axis")
	{
		var_00 = 3;
	}

	if(isplayer(self) && var_00 == 0)
	{
		func_F7A2();
	}
	else
	{
		func_72A5(var_00);
	}

	if(!isai(self))
	{
		var_01 = func_8078();
		self.var_6A = var_01;
		var_02 = func_8070(var_01);
	}
	else
	{
		self method_82C6("vestLight");
	}

	self.var_13525 = level.var_5052[self.team];
	if(scripts\mp\_utility::func_9D46() && !isai(self))
	{
		var_03 = func_8079(func_8078());
		if(issubstr(var_03,"fullbody_sniper"))
		{
			thread func_72B2();
		}
	}

	if(scripts\mp\_utility::func_9E59())
	{
		if(isdefined(self.var_9E5D) && self.var_9E5D)
		{
			thread [[ game[self.team + "_model"]["JUGGERNAUT_MANIAC"] ]]();
			return;
		}

		if(isdefined(self.var_9E5C) && self.var_9E5C)
		{
			thread [[ game[self.team + "_model"]["JUGGERNAUT_CUSTOM"] ]]();
			return;
		}

		thread [[ game[self.team + "_model"]["JUGGERNAUT"] ]]();
		return;
	}
}

//Function Number: 29
func_72B2()
{
	if(self.team == "axis")
	{
		self setmodel("mp_fullbody_heavy");
		self method_8369("viewmodel_mp_warfighter_1");
	}
	else
	{
		self setmodel("mp_body_infected_a");
		self method_8369("viewmodel_mp_warfighter_1");
	}

	if(isdefined(self.var_8C98))
	{
		self detach(self.var_8C98,"");
		self.var_8C98 = undefined;
	}

	self attach("head_mp_infected","",1);
	self.var_8C98 = "head_mp_infected";
	self method_82C6("cloth");
}

//Function Number: 30
func_12E95()
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
			level.players[var_00] func_12E94();
		}

		wait(1);
	}
}

//Function Number: 31
func_12E94()
{
	if(isai(self))
	{
		return;
	}

	if(!scripts\mp\_utility::func_DCD5())
	{
		if(self.var_1190E["allies"])
		{
			scripts\mp\_persistence::func_10E13("timePlayedAllies",self.var_1190E["allies"],1);
			scripts\mp\_persistence::func_10E13("timePlayedTotal",self.var_1190E["allies"],1);
			scripts\mp\_persistence::func_10E16("round","timePlayed",self.var_1190E["allies"],1);
		}

		if(self.var_1190E["axis"])
		{
			scripts\mp\_persistence::func_10E13("timePlayedOpfor",self.var_1190E["axis"],1);
			scripts\mp\_persistence::func_10E13("timePlayedTotal",self.var_1190E["axis"],1);
			scripts\mp\_persistence::func_10E16("round","timePlayed",self.var_1190E["axis"],1);
		}

		if(self.var_1190E["other"])
		{
			scripts\mp\_persistence::func_10E13("timePlayedOther",self.var_1190E["other"],1);
			scripts\mp\_persistence::func_10E13("timePlayedTotal",self.var_1190E["other"],1);
			scripts\mp\_persistence::func_10E16("round","timePlayed",self.var_1190E["other"],1);
		}

		return;
	}

	if(self.var_1190E["allies"])
	{
		scripts\mp\_persistence::func_10E13("timePlayedAllies",self.var_1190E["allies"]);
		scripts\mp\_persistence::func_10E13("timePlayedTotal",self.var_1190E["allies"]);
		scripts\mp\_persistence::func_10E16("round","timePlayed",self.var_1190E["allies"]);
		scripts\mp\_persistence::func_10E17("xpMultiplierTimePlayed",0,self.var_1190E["allies"],self.var_316A["xpMaxMultiplierTimePlayed"][0]);
		scripts\mp\_persistence::func_10E17("xpMultiplierTimePlayed",1,self.var_1190E["allies"],self.var_316A["xpMaxMultiplierTimePlayed"][1]);
		scripts\mp\_persistence::func_10E17("xpMultiplierTimePlayed",2,self.var_1190E["allies"],self.var_316A["xpMaxMultiplierTimePlayed"][2]);
	}

	if(self.var_1190E["axis"])
	{
		scripts\mp\_persistence::func_10E13("timePlayedOpfor",self.var_1190E["axis"]);
		scripts\mp\_persistence::func_10E13("timePlayedTotal",self.var_1190E["axis"]);
		scripts\mp\_persistence::func_10E16("round","timePlayed",self.var_1190E["axis"]);
		scripts\mp\_persistence::func_10E17("xpMultiplierTimePlayed",0,self.var_1190E["axis"],self.var_316A["xpMaxMultiplierTimePlayed"][0]);
		scripts\mp\_persistence::func_10E17("xpMultiplierTimePlayed",1,self.var_1190E["axis"],self.var_316A["xpMaxMultiplierTimePlayed"][1]);
		scripts\mp\_persistence::func_10E17("xpMultiplierTimePlayed",2,self.var_1190E["axis"],self.var_316A["xpMaxMultiplierTimePlayed"][2]);
	}

	if(self.var_1190E["other"])
	{
		scripts\mp\_persistence::func_10E13("timePlayedOther",self.var_1190E["other"]);
		scripts\mp\_persistence::func_10E13("timePlayedTotal",self.var_1190E["other"]);
		scripts\mp\_persistence::func_10E16("round","timePlayed",self.var_1190E["other"]);
		scripts\mp\_persistence::func_10E17("xpMultiplierTimePlayed",0,self.var_1190E["other"],self.var_316A["xpMaxMultiplierTimePlayed"][0]);
		scripts\mp\_persistence::func_10E17("xpMultiplierTimePlayed",1,self.var_1190E["other"],self.var_316A["xpMaxMultiplierTimePlayed"][1]);
		scripts\mp\_persistence::func_10E17("xpMultiplierTimePlayed",2,self.var_1190E["other"],self.var_316A["xpMaxMultiplierTimePlayed"][2]);
	}

	self.var_1190E["allies"] = 0;
	self.var_1190E["axis"] = 0;
	self.var_1190E["other"] = 0;
}

//Function Number: 32
watchafk()
{
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
			if(isai(level.players[var_00]))
			{
				continue;
			}

			level.players[var_00] checkforafk();
		}

		wait(1);
		scripts\mp\_hostmigration::func_13834();
	}
}

//Function Number: 33
checkforafk()
{
	if(scripts\mp\_utility::func_9FB3(level.var_7669))
	{
		return;
	}

	if(!isdefined(self.pers["validKickTime"]))
	{
		self.pers["validKickTime"] = 0;
	}

	var_00 = self.pers["validKickTime"];
	var_01 = 0;
	var_02 = self.pers["kills"];
	var_03 = self.pers["assists"];
	var_04 = var_02 == 0 && var_03 == 0;
	if(isdefined(self.pers["stanceTracking"]) && var_00 > 30)
	{
		var_05 = self.pers["stanceTracking"]["crouch"] / var_00;
		if(var_05 > 1)
		{
			var_01 = 1;
		}
	}

	if(var_04 && var_00 > 60)
	{
		if(!isdefined(self.pers["distTrackingPassed"]))
		{
			if(level.gametype == "infect")
			{
				if(self.team == "axis")
				{
					var_01 = 1;
				}
			}
			else
			{
				var_01 = 1;
			}
		}
	}

	if(var_04 && var_00 > 120)
	{
		if(!isdefined(self.var_A96A) || self.var_A96A + -5536 < gettime())
		{
			switch(level.gametype)
			{
				case "gun":
					if(scripts\mp\_utility::func_9FB3(level.kick_afk_check))
					{
						var_01 = 1;
					}
					break;
			}
		}
	}

	if(var_01 && !function_0303())
	{
		kick(self getentitynumber(),"EXE_PLAYERKICKED_INACTIVE",1);
	}
}

//Function Number: 34
func_7F24(param_00)
{
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

	if(!scripts\mp\_utility::func_B3EC())
	{
		return 1;
	}

	if(level.gametype == "infect")
	{
		return 1;
	}

	bbprint("mp_exceeded_team_max_error","player_xuid %s isHost %i",self getxuid(),self ishost());
	if(self ishost())
	{
		wait(1.5);
	}

	function_01BD(1);
	level.nojip = 1;
	kick(self getentitynumber(),"EXE_PLAYERKICKED_INVALIDTEAM");
	return 0;
}

//Function Number: 35
func_C57B()
{
	level endon("game_ended");
	self waittill("spawned_player");
}

//Function Number: 36
func_BD73(param_00)
{
	return tablelookupistring("mp/MTTable.csv",0,param_00,1);
}

//Function Number: 37
func_BD72(param_00)
{
	return tablelookup("mp/MTTable.csv",0,param_00,2);
}

//Function Number: 38
func_BD71(param_00)
{
	return tablelookup("mp/MTTable.csv",0,param_00,3);
}

//Function Number: 39
func_81B5(param_00)
{
	return tablelookupistring("mp/factionTable.csv",0,game[param_00],1);
}

//Function Number: 40
func_81B7(param_00)
{
	return tablelookupistring("mp/factionTable.csv",0,game[param_00],2);
}

//Function Number: 41
func_81AF(param_00)
{
	return tablelookupistring("mp/factionTable.csv",0,game[param_00],4);
}

//Function Number: 42
func_81A8(param_00)
{
	return tablelookupistring("mp/factionTable.csv",0,game[param_00],3);
}

//Function Number: 43
func_81B2(param_00)
{
	return tablelookup("mp/factionTable.csv",0,game[param_00],5);
}

//Function Number: 44
func_81B1(param_00)
{
	return tablelookup("mp/factionTable.csv",0,game[param_00],6);
}

//Function Number: 45
func_81B0(param_00)
{
	return tablelookup("mp/factionTable.csv",0,game[param_00],17);
}

//Function Number: 46
func_81BC(param_00)
{
	return tablelookup("mp/factionTable.csv",0,game[param_00],7);
}

//Function Number: 47
func_81B9(param_00)
{
	return tablelookup("mp/factionTable.csv",0,game[param_00],8);
}

//Function Number: 48
func_81BD(param_00)
{
	return tablelookup("mp/factionTable.csv",0,game[param_00],9);
}

//Function Number: 49
func_81AE(param_00)
{
	return tablelookup("mp/factionTable.csv",0,game[param_00],10);
}

//Function Number: 50
func_81AA(param_00)
{
	return tablelookup("mp/factionTable.csv",0,game[param_00],11);
}

//Function Number: 51
func_81AD(param_00)
{
	return tablelookup("mp/factionTable.csv",0,game[param_00],12);
}

//Function Number: 52
func_81AC(param_00)
{
	return tablelookup("mp/factionTable.csv",0,game[param_00],13);
}

//Function Number: 53
func_81A4(param_00)
{
	return (scripts\mp\_utility::func_1114F(tablelookup("mp/factionTable.csv",0,game[param_00],14)),scripts\mp\_utility::func_1114F(tablelookup("mp/factionTable.csv",0,game[param_00],15)),scripts\mp\_utility::func_1114F(tablelookup("mp/factionTable.csv",0,game[param_00],16)));
}

//Function Number: 54
func_81A5(param_00)
{
	return tablelookup("mp/factionTable.csv",0,game[param_00],18);
}

//Function Number: 55
func_81A6(param_00)
{
	return tablelookup("mp/factionTable.csv",0,game[param_00],19);
}