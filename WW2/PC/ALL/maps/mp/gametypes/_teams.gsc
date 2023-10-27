/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes\_teams.gsc
 * Game: Call of Duty: WWII
 * Platform: PC
 * Function Count: 49
 * Decompile Time: 775 ms
 * Timestamp: 10/27/2023 3:24:31 AM
*******************************************************************/

//Function Number: 1
func_00D5()
{
	func_534C();
	level.var_984C = getdvarint("scr_teambalance");
	level.var_6079 = getdvarint("2299");
	func_86FF();
	level.var_3E8B = [];
	if(level.var_984D)
	{
		level thread func_6B6C();
		level thread func_A171();
		wait(0.15);
		level thread func_A153();
		return;
	}

	level thread func_6B3D();
	wait(0.15);
	level thread func_A115();
}

//Function Number: 2
func_534C()
{
	setdvar("1202",func_46D6("allies"));
	setdvar("3729",func_46D3("allies"));
	setdvar("4487",func_46D3("allies"));
	setdvar("942",func_46D3("allies"));
	var_00 = func_46C5("allies");
	setdvar("1138",var_00[0] + " " + var_00[1] + " " + var_00[2]);
	setdvar("2991",func_46D6("axis"));
	setdvar("5558",func_46D3("axis"));
	setdvar("675",func_46D3("axis"));
	setdvar("4622",func_46D3("axis"));
	var_00 = func_46C5("axis");
	setdvar("1513",var_00[0] + " " + var_00[1] + " " + var_00[2]);
	setdvar("370",".25 .25 .25");
	setdvar("2942",".76 .78 .10");
	setdvar("1725",".6 .8 .6");
	setdvar("4832","1 .45 .5");
}

//Function Number: 3
func_6B6C()
{
	for(;;)
	{
		level waittill("connected",var_00);
		var_00 thread func_6B49();
		var_00 thread func_6B48();
		var_00 thread func_9BC3();
	}
}

//Function Number: 4
func_6B3D()
{
	for(;;)
	{
		level waittill("connected",var_00);
		var_00 thread func_9BA7();
	}
}

//Function Number: 5
func_6B49()
{
	self endon("disconnect");
	for(;;)
	{
		self waittill("joined_team");
		func_A176();
	}
}

//Function Number: 6
func_6B48()
{
	self endon("disconnect");
	for(;;)
	{
		self waittill("joined_spectators");
		self.var_12C["teamTime"] = undefined;
	}
}

//Function Number: 7
func_9BC3()
{
	self endon("disconnect");
	if(!function_0367())
	{
		if(maps\mp\_utility::func_585F())
		{
			if(common_scripts\utility::func_562E(level.zombie_game_was_restarted))
			{
				wait(30);
			}
		}

		lootservicestarttrackingplaytime(self.var_1D6);
		self.loot_service_started_tracking_playtime = 1;
	}

	self.var_9A06["allies"] = 0;
	self.var_9A06["axis"] = 0;
	self.var_9A06["other"] = 0;
	maps\mp\_utility::func_3FA5("prematch_done");
	for(;;)
	{
		if(game["state"] == "playing")
		{
			if(self.var_179 == "allies")
			{
				self.var_9A06["allies"]++;
				self.var_9A06["total"]++;
			}
			else if(self.var_179 == "axis")
			{
				self.var_9A06["axis"]++;
				self.var_9A06["total"]++;
			}
			else if(self.var_179 == "spectator")
			{
				self.var_9A06["other"]++;
			}
		}

		wait(1);
	}
}

//Function Number: 8
func_A153()
{
	if(!level.var_7A67)
	{
		return;
	}

	level endon("game_ended");
	for(;;)
	{
		maps\mp\gametypes\_hostmigration::func_A782();
		foreach(var_01 in level.var_744A)
		{
			var_01 func_A14E();
		}

		wait(1);
	}
}

//Function Number: 9
func_A14E()
{
	if(isai(self))
	{
		return;
	}

	if(!maps\mp\_utility::func_7A69())
	{
		return;
	}

	if(self.var_9A06["allies"])
	{
		maps\mp\gametypes\_persistence::func_9315("timePlayedAllies",self.var_9A06["allies"]);
		maps\mp\gametypes\_persistence::func_9315("timePlayedTotal",self.var_9A06["allies"]);
		maps\mp\gametypes\_persistence::func_9318("round","timePlayed",self.var_9A06["allies"]);
	}

	if(self.var_9A06["axis"])
	{
		maps\mp\gametypes\_persistence::func_9315("timePlayedOpfor",self.var_9A06["axis"]);
		maps\mp\gametypes\_persistence::func_9315("timePlayedTotal",self.var_9A06["axis"]);
		maps\mp\gametypes\_persistence::func_9318("round","timePlayed",self.var_9A06["axis"]);
	}

	if(self.var_9A06["other"])
	{
		maps\mp\gametypes\_persistence::func_9315("timePlayedOther",self.var_9A06["other"]);
		maps\mp\gametypes\_persistence::func_9315("timePlayedTotal",self.var_9A06["other"]);
		maps\mp\gametypes\_persistence::func_9318("round","timePlayed",self.var_9A06["other"]);
	}

	if(game["state"] == "postgame")
	{
		return;
	}

	self.var_9A06["allies"] = 0;
	self.var_9A06["axis"] = 0;
	self.var_9A06["other"] = 0;
}

//Function Number: 10
func_A176()
{
	if(game["state"] != "playing")
	{
		return;
	}

	self.var_12C["teamTime"] = gettime();
}

//Function Number: 11
func_A172()
{
	for(;;)
	{
		var_00 = getdvarint("scr_teambalance");
		if(level.var_984C != var_00)
		{
			level.var_984C = getdvarint("scr_teambalance");
		}

		wait(1);
	}
}

//Function Number: 12
func_A171()
{
	if(function_0154() == "hub")
	{
		level.var_9858 = level.var_6079;
		return;
	}

	level.var_9858 = level.var_6079 / 2;
	level thread func_A172();
	wait(0.15);
	if(level.var_984C && maps\mp\_utility::func_57B2())
	{
		if(isdefined(game["BalanceTeamsNextRound"]))
		{
			iprintlnbold(&"MP_AUTOBALANCE_NEXT_ROUND");
		}

		level waittill("restarting");
		if(isdefined(game["BalanceTeamsNextRound"]))
		{
			level func_1502();
			game["BalanceTeamsNextRound"] = undefined;
			return;
		}

		if(!func_46C4())
		{
			game["BalanceTeamsNextRound"] = 1;
			return;
		}

		return;
	}

	level endon("game_ended");
	for(;;)
	{
		if(level.var_984C)
		{
			if(!func_46C4())
			{
				iprintlnbold(&"MP_AUTOBALANCE_SECONDS",15);
				wait(15);
				if(!func_46C4())
				{
					level func_1502();
				}
			}

			wait(59);
		}

		wait(1);
	}
}

//Function Number: 13
func_46C4()
{
	level.var_1A7["allies"] = 0;
	level.var_1A7["axis"] = 0;
	var_00 = level.var_744A;
	for(var_01 = 0;var_01 < var_00.size;var_01++)
	{
		if(isdefined(var_00[var_01].var_12C["team"]) && var_00[var_01].var_12C["team"] == "allies")
		{
			level.var_1A7["allies"]++;
			continue;
		}

		if(isdefined(var_00[var_01].var_12C["team"]) && var_00[var_01].var_12C["team"] == "axis")
		{
			level.var_1A7["axis"]++;
		}
	}

	if(level.var_1A7["allies"] > level.var_1A7["axis"] + level.var_984C || level.var_1A7["axis"] > level.var_1A7["allies"] + level.var_984C)
	{
		return 0;
	}

	return 1;
}

//Function Number: 14
func_1502()
{
	iprintlnbold(game["strings"]["autobalance"]);
	var_00 = [];
	var_01 = [];
	var_02 = level.var_744A;
	for(var_03 = 0;var_03 < var_02.size;var_03++)
	{
		if(!isdefined(var_02[var_03].var_12C["teamTime"]))
		{
			continue;
		}

		if(isdefined(var_02[var_03].var_12C["team"]) && var_02[var_03].var_12C["team"] == "allies")
		{
			var_00[var_00.size] = var_02[var_03];
			continue;
		}

		if(isdefined(var_02[var_03].var_12C["team"]) && var_02[var_03].var_12C["team"] == "axis")
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
				if(isdefined(var_00[var_05].var_322F))
				{
					continue;
				}

				if(!isdefined(var_04))
				{
					var_04 = var_00[var_05];
					continue;
				}

				if(var_00[var_05].var_12C["teamTime"] > var_04.var_12C["teamTime"])
				{
					var_04 = var_00[var_05];
				}
			}

			var_04 [[ level.var_6BB4 ]]("axis");
		}
		else if(var_01.size > var_00.size + 1)
		{
			for(var_05 = 0;var_05 < var_01.size;var_05++)
			{
				if(isdefined(var_01[var_05].var_322F))
				{
					continue;
				}

				if(!isdefined(var_04))
				{
					var_04 = var_01[var_05];
					continue;
				}

				if(var_01[var_05].var_12C["teamTime"] > var_04.var_12C["teamTime"])
				{
					var_04 = var_01[var_05];
				}
			}

			var_04 [[ level.var_6BB4 ]]("allies");
		}

		var_04 = undefined;
		var_00 = [];
		var_01 = [];
		var_02 = level.var_744A;
		for(var_03 = 0;var_03 < var_02.size;var_03++)
		{
			if(isdefined(var_02[var_03].var_12C["team"]) && var_02[var_03].var_12C["team"] == "allies")
			{
				var_00[var_00.size] = var_02[var_03];
				continue;
			}

			if(isdefined(var_02[var_03].var_12C["team"]) && var_02[var_03].var_12C["team"] == "axis")
			{
				var_01[var_01.size] = var_02[var_03];
			}
		}
	}
}

//Function Number: 15
func_8692(param_00)
{
}

//Function Number: 16
func_873E(param_00,param_01)
{
}

//Function Number: 17
func_86FF()
{
	if(level.var_6520)
	{
		for(var_00 = 0;var_00 < level.var_985B.size;var_00++)
		{
			func_873E(level.var_985B[var_00],game[level.var_985B[var_00]]);
		}
	}
	else
	{
		func_873E("allies",game["allies"]);
		func_873E("axis",game["axis"]);
	}

	func_8692(getmapcustom("environment"));
}

//Function Number: 18
func_73CA()
{
	if(function_01EF(self) && !getdvarint("4017",0))
	{
		return 1;
	}

	if(!isdefined(self.var_5097) || !self.var_5097)
	{
		self setcostumemodels(self.var_267E,undefined,1,1);
		self method_8423(self);
	}

	self.var_A600 = "american";
	self method_83E1("vestlight");
	return 1;
}

//Function Number: 19
func_A27D(param_00,param_01)
{
	if(!isdefined(param_00))
	{
		return 0;
	}

	var_02 = function_0282(param_00,param_01);
	for(var_03 = 0;var_03 < param_00.size;var_03++)
	{
		if(param_00[var_03] != var_02[var_03])
		{
			return 0;
		}
	}

	return 1;
}

//Function Number: 20
func_448C()
{
	var_00 = function_0283();
	return var_00;
}

//Function Number: 21
func_4430()
{
	if(isdefined(self.var_79))
	{
		var_00 = getdivisioncostume(self.var_79,0);
	}
	else
	{
		var_00 = function_0332();
	}

	return var_00;
}

//Function Number: 22
func_4636()
{
	if(!isdefined(level.var_7613))
	{
		level.var_7614 = function_027B(level.var_761B) - 1;
		level.var_7613 = randomint(level.var_7614);
	}

	var_00 = 0;
	for(var_01 = 0;var_01 < level.var_744A.size;var_01++)
	{
		if(level.var_744A[var_01] == self)
		{
			var_00 = var_01;
			break;
		}
	}

	var_02 = level.var_7613 + var_00 % level.var_7614;
	var_03 = getcostumefromtable(level.var_761B,var_02 + 1);
	return var_03;
}

//Function Number: 23
func_4503()
{
	var_00 = 2;
	if(self.var_12C["team"] == "axis")
	{
		var_00 = 1;
	}

	var_01 = getcostumefromtable(level.var_4B16,var_00);
	return var_01;
}

//Function Number: 24
func_7427(param_00,param_01)
{
	var_02 = self.var_1A7;
	var_03 = func_73CA();
	self notify("player_model_set");
}

//Function Number: 25
func_2697()
{
	var_00 = [];
	for(var_01 = 0;var_01 < level.var_985B.size;var_01++)
	{
		var_00[level.var_985B[var_01]] = 0;
	}

	for(var_01 = 0;var_01 < level.var_744A.size;var_01++)
	{
		if(level.var_744A[var_01] == self)
		{
			continue;
		}

		if(level.var_744A[var_01].var_12C["team"] == "spectator")
		{
			continue;
		}

		if(isdefined(level.var_744A[var_01].var_12C["team"]))
		{
			var_00[level.var_744A[var_01].var_12C["team"]]++;
		}
	}

	return var_00;
}

//Function Number: 26
func_9BA7()
{
	self endon("disconnect");
	if(!function_0367())
	{
		if(maps\mp\_utility::func_585F())
		{
			if(common_scripts\utility::func_562E(level.zombie_game_was_restarted))
			{
				wait(30);
			}
		}

		lootservicestarttrackingplaytime(self.var_1D6);
		self.loot_service_started_tracking_playtime = 1;
	}

	self.var_9A06["allies"] = 0;
	self.var_9A06["axis"] = 0;
	self.var_9A06["other"] = 0;
	for(;;)
	{
		if(game["state"] == "playing")
		{
			if(isdefined(self.var_12C["team"]) && self.var_12C["team"] == "allies" && self.var_179 != "spectator")
			{
				self.var_9A06["allies"]++;
				self.var_9A06["total"]++;
			}
			else if(isdefined(self.var_12C["team"]) && self.var_12C["team"] == "axis" && self.var_179 != "spectator")
			{
				self.var_9A06["axis"]++;
				self.var_9A06["total"]++;
			}
			else
			{
				self.var_9A06["other"]++;
			}
		}

		wait(1);
	}
}

//Function Number: 27
func_A115()
{
	if(!level.var_7A67)
	{
		return;
	}

	var_00 = 0;
	for(;;)
	{
		var_00++;
		if(var_00 >= level.var_744A.size)
		{
			var_00 = 0;
		}

		if(isdefined(level.var_744A[var_00]))
		{
			level.var_744A[var_00] func_A114();
		}

		wait(1);
	}
}

//Function Number: 28
func_A114()
{
	if(!maps\mp\_utility::func_7A69())
	{
		return;
	}

	if(isai(self))
	{
		return;
	}

	if(self.var_9A06["allies"])
	{
		maps\mp\gametypes\_persistence::func_9315("timePlayedAllies",self.var_9A06["allies"]);
		maps\mp\gametypes\_persistence::func_9315("timePlayedTotal",self.var_9A06["allies"]);
		maps\mp\gametypes\_persistence::func_9318("round","timePlayed",self.var_9A06["allies"]);
	}

	if(self.var_9A06["axis"])
	{
		maps\mp\gametypes\_persistence::func_9315("timePlayedOpfor",self.var_9A06["axis"]);
		maps\mp\gametypes\_persistence::func_9315("timePlayedTotal",self.var_9A06["axis"]);
		maps\mp\gametypes\_persistence::func_9318("round","timePlayed",self.var_9A06["axis"]);
	}

	if(self.var_9A06["other"])
	{
		maps\mp\gametypes\_persistence::func_9315("timePlayedOther",self.var_9A06["other"]);
		maps\mp\gametypes\_persistence::func_9315("timePlayedTotal",self.var_9A06["other"]);
		maps\mp\gametypes\_persistence::func_9318("round","timePlayed",self.var_9A06["other"]);
	}

	if(game["state"] == "postgame")
	{
		return;
	}

	self.var_9A06["allies"] = 0;
	self.var_9A06["axis"] = 0;
	self.var_9A06["other"] = 0;
}

//Function Number: 29
func_452D(param_00)
{
	if(maps\mp\_utility::func_56B9())
	{
		return 1;
	}

	if(level.var_3FDC == "infect")
	{
		return 1;
	}

	if(function_0154() == "hub")
	{
		return 1;
	}

	var_01 = 0;
	var_02 = level.var_744A;
	for(var_03 = 0;var_03 < var_02.size;var_03++)
	{
		var_04 = var_02[var_03];
		if(isdefined(var_04.var_12C["team"]) && var_04.var_12C["team"] == param_00)
		{
			var_01++;
			if(isbot(var_04))
			{
				return 1;
			}
		}
	}

	if(var_01 < level.var_9858)
	{
		return 1;
	}

	return 0;
}

//Function Number: 30
func_650C(param_00)
{
	return function_01AF("mp/MTTable.csv",0,param_00,1);
}

//Function Number: 31
func_650B(param_00)
{
	return tablelookup("mp/MTTable.csv",0,param_00,2);
}

//Function Number: 32
func_650A(param_00)
{
	return tablelookup("mp/MTTable.csv",0,param_00,3);
}

//Function Number: 33
func_46D5(param_00)
{
	return function_01AF("mp/factionTable.csv",0,game[param_00],1);
}

//Function Number: 34
func_46D6(param_00)
{
	return function_01AF("mp/factionTable.csv",0,game[param_00],2);
}

//Function Number: 35
func_46D0(param_00)
{
	return function_01AF("mp/factionTable.csv",0,game[param_00],4);
}

//Function Number: 36
func_46C9(param_00)
{
	return function_01AF("mp/factionTable.csv",0,game[param_00],3);
}

//Function Number: 37
func_46D3(param_00)
{
	return tablelookup("mp/factionTable.csv",0,game[param_00],5);
}

//Function Number: 38
func_46D2(param_00)
{
	return tablelookup("mp/factionTable.csv",0,game[param_00],6);
}

//Function Number: 39
func_46D1(param_00)
{
	return tablelookup("mp/factionTable.csv",0,game[param_00],17);
}

//Function Number: 40
func_46D9(param_00)
{
	return tablelookup("mp/factionTable.csv",0,game[param_00],7);
}

//Function Number: 41
func_46D8(param_00)
{
	return tablelookup("mp/factionTable.csv",0,game[param_00],8);
}

//Function Number: 42
func_46DA(param_00)
{
	return tablelookup("mp/factionTable.csv",0,game[param_00],9);
}

//Function Number: 43
func_46CF(param_00)
{
	return tablelookup("mp/factionTable.csv",0,game[param_00],10);
}

//Function Number: 44
func_46CB(param_00)
{
	return tablelookup("mp/factionTable.csv",0,game[param_00],11);
}

//Function Number: 45
func_46CE(param_00)
{
	return tablelookup("mp/factionTable.csv",0,game[param_00],12);
}

//Function Number: 46
func_46CD(param_00)
{
	return tablelookup("mp/factionTable.csv",0,game[param_00],13);
}

//Function Number: 47
func_46C5(param_00)
{
	return (common_scripts\utility::func_9468(tablelookup("mp/factionTable.csv",0,game[param_00],14)),common_scripts\utility::func_9468(tablelookup("mp/factionTable.csv",0,game[param_00],15)),common_scripts\utility::func_9468(tablelookup("mp/factionTable.csv",0,game[param_00],16)));
}

//Function Number: 48
func_46C6(param_00)
{
	return tablelookup("mp/factionTable.csv",0,game[param_00],18);
}

//Function Number: 49
func_46C7(param_00)
{
	return tablelookup("mp/factionTable.csv",0,game[param_00],19);
}