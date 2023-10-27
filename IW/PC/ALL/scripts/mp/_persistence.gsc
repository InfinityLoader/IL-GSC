/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\mp\_persistence.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 33
 * Decompile Time: 1330 ms
 * Timestamp: 10/27/2023 12:21:11 AM
*******************************************************************/

//Function Number: 1
init()
{
	level.var_CA70 = [];
	level thread func_12E6A();
	level thread func_12F85();
	level thread func_13E05();
}

//Function Number: 2
func_97E2()
{
	self.var_316E = [];
	self.var_10AEC = [];
	if(scripts\mp\_utility::func_DCD5())
	{
		self.var_316E["totalShots"] = self getplayerdata("mp","totalShots");
		self.var_316E["accuracy"] = self getplayerdata("mp","accuracy");
		self.var_316E["misses"] = self getplayerdata("mp","misses");
		self.var_316E["hits"] = self getplayerdata("mp","hits");
	}

	self.var_316E["timePlayedAllies"] = self getplayerdata("mp","timePlayedAllies");
	self.var_316E["timePlayedOpfor"] = self getplayerdata("mp","timePlayedOpfor");
	self.var_316E["timePlayedOther"] = self getplayerdata("mp","timePlayedOther");
	self.var_316E["timePlayedTotal"] = self getplayerdata("mp","timePlayedTotal");
	self.var_3169 = [];
	self.var_3169["round"] = [];
	self.var_3169["round"]["timePlayed"] = self getplayerdata("common","round","timePlayed");
	if(scripts\mp\_utility::func_DCD5())
	{
		self.var_3169["xpMultiplierTimePlayed"] = [];
		self.var_3169["xpMultiplierTimePlayed"][0] = self getplayerdata("mp","xpMultiplierTimePlayed",0);
		self.var_3169["xpMultiplierTimePlayed"][1] = self getplayerdata("mp","xpMultiplierTimePlayed",1);
		self.var_3169["xpMultiplierTimePlayed"][2] = self getplayerdata("mp","xpMultiplierTimePlayed",2);
		self.var_316A["xpMaxMultiplierTimePlayed"] = [];
		self.var_316A["xpMaxMultiplierTimePlayed"][0] = self getplayerdata("mp","xpMaxMultiplierTimePlayed",0);
		self.var_316A["xpMaxMultiplierTimePlayed"][1] = self getplayerdata("mp","xpMaxMultiplierTimePlayed",1);
		self.var_316A["xpMaxMultiplierTimePlayed"][2] = self getplayerdata("mp","xpMaxMultiplierTimePlayed",2);
		self.var_3169["challengeXPMultiplierTimePlayed"] = [];
		self.var_3169["challengeXPMultiplierTimePlayed"][0] = self getplayerdata("mp","challengeXPMultiplierTimePlayed",0);
		self.var_316A["challengeXPMaxMultiplierTimePlayed"] = [];
		self.var_316A["challengeXPMaxMultiplierTimePlayed"][0] = self getplayerdata("mp","challengeXPMaxMultiplierTimePlayed",0);
		self.var_3169["weaponXPMultiplierTimePlayed"] = [];
		self.var_3169["weaponXPMultiplierTimePlayed"][0] = self getplayerdata("mp","weaponXPMultiplierTimePlayed",0);
		self.var_316A["weaponXPMaxMultiplierTimePlayed"] = [];
		self.var_316A["weaponXPMaxMultiplierTimePlayed"][0] = self getplayerdata("mp","weaponXPMaxMultiplierTimePlayed",0);
		self.var_316E["prestigeDoubleWeaponXp"] = self getplayerdata("mp","prestigeDoubleWeaponXp");
		self.var_316E["prestigeDoubleWeaponXpTimePlayed"] = self getplayerdata("mp","prestigeDoubleWeaponXpTimePlayed");
		self.var_316F["prestigeDoubleWeaponXpMaxTimePlayed"] = self getplayerdata("mp","prestigeDoubleWeaponXpMaxTimePlayed");
	}

	func_97DB();
}

//Function Number: 3
func_97DB()
{
	var_00 = "mp/bestscorestatsTable.csv";
	self.var_2A98 = [];
	self.var_3168 = [];
	var_01 = 0;
	for(;;)
	{
		var_02 = tablelookupbyrow(var_00,var_01,0);
		if(var_02 == "")
		{
			break;
		}

		self.var_2A98[var_02] = self getplayerdata("mp","bestScores",var_02);
		var_01++;
	}
}

//Function Number: 4
func_10E33(param_00)
{
	return self getplayerdata("mp",param_00);
}

//Function Number: 5
func_10E54(param_00,param_01)
{
	if(!scripts\mp\_utility::func_DCD5())
	{
		return;
	}

	self setplayerdata("mp",param_00,param_01);
}

//Function Number: 6
func_10E12(param_00,param_01,param_02)
{
	if(!scripts\mp\_utility::func_DCD5())
	{
		return;
	}

	if(isdefined(param_02))
	{
		var_03 = self getplayerdata("mp",param_00,param_02);
		self setplayerdata("mp",param_00,param_02,param_01 + var_03);
		return;
	}

	var_04 = self getplayerdata("mp",param_00) + param_01;
	self setplayerdata("mp",param_00,var_04);
}

//Function Number: 7
func_10E35(param_00,param_01)
{
	if(param_00 == "round")
	{
		return self getplayerdata("common",param_00,param_01);
	}

	return self getplayerdata("mp",param_00,param_01);
}

//Function Number: 8
func_10E56(param_00,param_01,param_02,param_03)
{
	if(isagent(self))
	{
		return;
	}

	if(isdefined(param_03) || !scripts\mp\_utility::func_DCD5())
	{
		return;
	}

	if(param_00 == "round")
	{
		self setplayerdata("common",param_00,param_01,param_02);
		func_F662(param_01,param_02);
		return;
	}

	self setplayerdata("mp",param_00,param_01,param_02);
}

//Function Number: 9
func_10E15(param_00,param_01,param_02)
{
	if(!scripts\mp\_utility::func_DCD5())
	{
		return;
	}

	var_03 = self getplayerdata("mp",param_00,param_01);
	self setplayerdata("mp",param_00,param_01,var_03 + param_02);
}

//Function Number: 10
func_10E36(param_00,param_01,param_02)
{
	if(!scripts\mp\_utility::func_DCD5() && !scripts\mp\_utility::func_9FB3(param_02))
	{
		return 0;
	}

	return self.var_3169[param_00][param_01];
}

//Function Number: 11
func_10E57(param_00,param_01,param_02,param_03)
{
	if(!scripts\mp\_utility::func_DCD5() && !scripts\mp\_utility::func_9FB3(param_03))
	{
		return;
	}

	self.var_3169[param_00][param_01] = param_02;
}

//Function Number: 12
func_10E16(param_00,param_01,param_02,param_03)
{
	if(!scripts\mp\_utility::func_DCD5() && !scripts\mp\_utility::func_9FB3(param_03))
	{
		return;
	}

	var_04 = func_10E36(param_00,param_01,param_03);
	func_10E57(param_00,param_01,var_04 + param_02,param_03);
}

//Function Number: 13
func_10E14(param_00,param_01,param_02)
{
	if(!scripts\mp\_utility::func_DCD5())
	{
		return;
	}

	var_03 = func_10E34(param_00) + param_01;
	if(var_03 > param_02)
	{
		var_03 = param_02;
	}

	if(var_03 < func_10E34(param_00))
	{
		var_03 = param_02;
	}

	func_10E55(param_00,var_03);
}

//Function Number: 14
func_10E17(param_00,param_01,param_02,param_03)
{
	if(!scripts\mp\_utility::func_DCD5())
	{
		return;
	}

	var_04 = func_10E36(param_00,param_01) + param_02;
	if(var_04 > param_03)
	{
		var_04 = param_03;
	}

	if(var_04 < func_10E36(param_00,param_01))
	{
		var_04 = param_03;
	}

	func_10E57(param_00,param_01,var_04);
}

//Function Number: 15
func_10E34(param_00,param_01)
{
	if(!scripts\mp\_utility::func_DCD5() && !scripts\mp\_utility::func_9FB3(param_01))
	{
		return 0;
	}

	return self.var_316E[param_00];
}

//Function Number: 16
func_10E37(param_00)
{
	if(!scripts\mp\_utility::func_DCD5())
	{
		return 0;
	}

	return self.var_10AEC[param_00];
}

//Function Number: 17
func_10E55(param_00,param_01,param_02)
{
	if(!scripts\mp\_utility::func_DCD5() && !scripts\mp\_utility::func_9FB3(param_02))
	{
		return;
	}

	self.var_316E[param_00] = param_01;
}

//Function Number: 18
func_10E58(param_00,param_01)
{
	if(!scripts\mp\_utility::func_DCD5())
	{
		return;
	}

	self.var_10AEC[param_00] = param_01;
}

//Function Number: 19
func_10E13(param_00,param_01,param_02)
{
	if(!scripts\mp\_utility::func_DCD5() && !scripts\mp\_utility::func_9FB3(param_02))
	{
		return;
	}

	var_03 = func_10E34(param_00,param_02);
	func_10E55(param_00,var_03 + param_01,param_02);
}

//Function Number: 20
func_10E18(param_00,param_01)
{
	if(!scripts\mp\_utility::func_DCD5())
	{
		return;
	}

	var_02 = func_10E37(param_00);
	func_10E58(param_00,var_02 + param_01);
}

//Function Number: 21
func_12E6A()
{
	wait(0.15);
	var_00 = 0;
	while(!level.var_7669)
	{
		scripts\mp\_hostmigration::func_13834();
		var_00++;
		if(var_00 >= level.players.size)
		{
			var_00 = 0;
		}

		if(isdefined(level.players[var_00]))
		{
			level.players[var_00] func_13E04();
			level.players[var_00] func_12F5E();
		}

		wait(2);
	}

	foreach(var_02 in level.players)
	{
		var_02 func_13E04();
		var_02 func_12F5E();
	}
}

//Function Number: 22
func_F662(param_00,param_01)
{
	var_02 = scripts\mp\_utility::func_DCD5();
	if(!var_02)
	{
		return;
	}

	if(isdefined(self.var_2A98[param_00]) && param_01 > self.var_2A98[param_00])
	{
		self.var_2A98[param_00] = param_01;
		self.var_3168[param_00] = param_01;
	}
}

//Function Number: 23
func_13E03()
{
	foreach(var_01 in level.players)
	{
		if(isdefined(var_01) && var_01 scripts\mp\_utility::func_DCD5())
		{
			foreach(var_04, var_03 in var_01.var_3168)
			{
				var_01 setplayerdata("mp","bestScores",var_04,var_03);
			}
		}
	}
}

//Function Number: 24
func_13E04()
{
	var_00 = scripts\mp\_utility::func_DCD5();
	if(var_00)
	{
		foreach(var_03, var_02 in self.var_316E)
		{
			self setplayerdata("mp",var_03,var_02);
		}

		if(!isai(self))
		{
			foreach(var_03, var_02 in self.var_10AEC)
			{
				self setplayerdata("rankedloadouts","squadMembers",var_03,var_02);
			}
		}
	}

	foreach(var_03, var_02 in self.var_3169)
	{
		foreach(var_08, var_07 in var_02)
		{
			if(var_03 == "round")
			{
				self setplayerdata("common",var_03,var_08,var_07);
				func_F662(var_08,var_07);
				continue;
			}

			if(var_00)
			{
				self setplayerdata("mp",var_03,var_08,var_07);
			}
		}
	}
}

//Function Number: 25
func_13E05()
{
	if(!scripts\mp\_utility::func_B3EC())
	{
		return;
	}

	level waittill("game_ended");
	wait(0.1);
	if(scripts\mp\_utility::func_13916() || !scripts\mp\_utility::func_9F32() && scripts\mp\_utility::func_9049())
	{
		foreach(var_01 in level.players)
		{
			var_01 func_93FB(var_01.var_1AB,var_01.var_E9);
		}
	}
}

//Function Number: 26
func_93FB(param_00,param_01)
{
	if(!scripts\mp\_utility::func_DCD5())
	{
		return;
	}

	for(var_02 = 0;var_02 < 4;var_02++)
	{
		var_03 = self getplayerdata("mp","kdHistoryK",var_02 + 1);
		self setplayerdata("mp","kdHistoryK",var_02,var_03);
		var_03 = self getplayerdata("mp","kdHistoryD",var_02 + 1);
		self setplayerdata("mp","kdHistoryD",var_02,var_03);
	}

	self setplayerdata("mp","kdHistoryK",4,int(clamp(param_00,0,255)));
	self setplayerdata("mp","kdHistoryD",4,int(clamp(param_01,0,255)));
}

//Function Number: 27
func_93FC(param_00,param_01,param_02)
{
	if(scripts\mp\_utility::func_9E6C(param_00))
	{
		return;
	}

	if(isdefined(level.var_561D))
	{
		return;
	}

	if(scripts\mp\_utility::func_DCD5())
	{
		var_03 = self getplayerdata("mp","weaponStats",param_00,param_01);
		self setplayerdata("mp","weaponStats",param_00,param_01,var_03 + param_02);
	}
}

//Function Number: 28
func_93F9(param_00,param_01,param_02)
{
	if(isdefined(level.var_561D))
	{
		return;
	}

	if(!scripts\mp\_utility::func_2490(param_00))
	{
		return;
	}

	if(scripts\mp\_utility::func_DCD5())
	{
		var_03 = self getplayerdata("mp","attachmentsStats",param_00,param_01);
		self setplayerdata("mp","attachmentsStats",param_00,param_01,var_03 + param_02);
	}
}

//Function Number: 29
func_12F5E()
{
	if(!isdefined(self.var_11AF0))
	{
		return;
	}

	if(self.var_11AF0 == "" || self.var_11AF0 == "none")
	{
		return;
	}

	if(scripts\mp\_utility::func_9E6C(self.var_11AF0) || scripts\mp\_utility::func_9DE2(self.var_11AF0) || scripts\mp\_utility::func_9D6E(self.var_11AF0))
	{
		return;
	}

	var_00 = self.var_11AF0;
	var_01 = undefined;
	var_02 = getsubstr(var_00,0,4);
	if(var_02 == "alt_")
	{
		var_03 = scripts\mp\_utility::func_821A(var_00);
		foreach(var_05 in var_03)
		{
			if(var_05 == "shotgun" || var_05 == "gl")
			{
				var_01 = var_05;
				break;
			}
		}
	}

	if(!isdefined(var_01))
	{
		if(var_02 == "alt_")
		{
			var_00 = getsubstr(var_00,4);
			var_02 = getsubstr(var_00,0,4);
		}

		if(var_02 == "iw6_" || var_02 == "iw7_")
		{
			var_07 = strtok(var_00,"_");
			var_01 = var_07[0] + "_" + var_07[1];
		}
	}

	if(var_01 == "gl" || var_01 == "shotgun" || var_01 == "missglprox" || var_01 == "stickglprox" || var_01 == "shotgunglprox" || var_01 == "shotgunglr")
	{
		func_CA72(var_01);
		func_CA6D();
		return;
	}

	if(!scripts\mp\_utility::func_9D78(var_01) && !scripts\mp\_utility::func_9D79(var_01))
	{
		return;
	}

	var_08 = function_02C4(var_00);
	func_CA73(var_01,var_08);
	var_03 = function_00E3(var_00);
	foreach(var_05 in var_03)
	{
		var_0A = scripts\mp\_utility::func_2494(var_05);
		if(!scripts\mp\_utility::func_2490(var_0A))
		{
			continue;
		}

		switch(var_0A)
		{
			case "gl":
			case "shotgun":
				break;
		}

		func_CA72(var_0A);
	}

	func_CA6D();
}

//Function Number: 30
func_CA6D()
{
	self.var_11AF0 = "none";
	self.var_11AF1 = 0;
	self.var_11AEF = 0;
	self.var_11AEE = 0;
	self.var_11AED = 0;
	self.var_11AEC = 0;
}

//Function Number: 31
func_CA73(param_00,param_01)
{
	if(self.var_11AF1 > 0)
	{
		func_93FC(param_00,"shots",self.var_11AF1);
		scripts\mp\_matchdata::func_AFDC(param_00,"shots",self.var_11AF1,param_01);
	}

	if(self.var_11AEF > 0)
	{
		func_93FC(param_00,"kills",self.var_11AEF);
		scripts\mp\_matchdata::func_AFDC(param_00,"kills",self.var_11AEF,param_01);
	}

	if(self.var_11AEE > 0)
	{
		func_93FC(param_00,"hits",self.var_11AEE);
		scripts\mp\_matchdata::func_AFDC(param_00,"hits",self.var_11AEE,param_01);
	}

	if(self.var_11AED > 0)
	{
		func_93FC(param_00,"headShots",self.var_11AED);
		scripts\mp\_matchdata::func_AFDC(param_00,"headShots",self.var_11AED,param_01);
	}

	if(self.var_11AEC > 0)
	{
		func_93FC(param_00,"deaths",self.var_11AEC);
		scripts\mp\_matchdata::func_AFDC(param_00,"deaths",self.var_11AEC,param_01);
	}
}

//Function Number: 32
func_CA72(param_00)
{
	if(!scripts\mp\_utility::func_2490(param_00))
	{
		return;
	}

	if(self.var_11AF1 > 0 && param_00 != "tactical")
	{
		func_93F9(param_00,"shots",self.var_11AF1);
		scripts\mp\_matchdata::func_AF94(param_00,"shots",self.var_11AF1);
	}

	if(self.var_11AEF > 0 && param_00 != "tactical")
	{
		func_93F9(param_00,"kills",self.var_11AEF);
		scripts\mp\_matchdata::func_AF94(param_00,"kills",self.var_11AEF);
	}

	if(self.var_11AEE > 0 && param_00 != "tactical")
	{
		func_93F9(param_00,"hits",self.var_11AEE);
		scripts\mp\_matchdata::func_AF94(param_00,"hits",self.var_11AEE);
	}

	if(self.var_11AED > 0 && param_00 != "tactical")
	{
		func_93F9(param_00,"headShots",self.var_11AED);
		scripts\mp\_matchdata::func_AF94(param_00,"headShots",self.var_11AED);
	}

	if(self.var_11AEC > 0)
	{
		func_93F9(param_00,"deaths",self.var_11AEC);
		scripts\mp\_matchdata::func_AF94(param_00,"deaths",self.var_11AEC);
	}
}

//Function Number: 33
func_12F85()
{
	level waittill("game_ended");
	if(!scripts\mp\_utility::func_B3EC())
	{
		return;
	}

	var_00 = 0;
	var_01 = 0;
	var_02 = 0;
	var_03 = 0;
	var_04 = 0;
	var_05 = 0;
	foreach(var_07 in level.players)
	{
		var_05 = var_05 + var_07.var_1190E["total"];
	}

	function_00F5("global_minutes",int(var_05 / 60));
	if(scripts\mp\_utility::func_9F32() && !scripts\mp\_utility::func_13916())
	{
		return;
	}

	wait(0.05);
	foreach(var_07 in level.players)
	{
		var_00 = var_00 + var_07.var_1AB;
		var_01 = var_01 + var_07.var_E9;
		var_02 = var_02 + var_07.var_4D;
		var_03 = var_03 + var_07.var_8CA0;
		var_04 = var_04 + var_07.var_111BB;
	}

	function_00F5("global_headshots",var_03);
	function_00F5("global_suicides",var_04);
	function_00F5("global_games",1);
	if(!isdefined(level.var_23E9))
	{
		function_00F5("global_assists",var_02);
	}
}