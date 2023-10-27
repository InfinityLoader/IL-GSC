/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\mp\_scoreboard.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 4
 * Decompile Time: 198 ms
 * Timestamp: 10/27/2023 12:21:28 AM
*******************************************************************/

//Function Number: 1
func_D9AB()
{
	foreach(var_01 in level.var_CC1D["all"])
	{
		var_01 func_F7F8();
	}

	if(level.multiteambased)
	{
		func_3219("multiteam");
		foreach(var_01 in level.players)
		{
			var_01 setplayerdata("common","round","scoreboardType","multiteam");
		}

		setclientmatchdata("alliesScore",-1);
		setclientmatchdata("axisScore",-1);
		setclientmatchdata("alliesKills",-1);
		setclientmatchdata("alliesDeaths",-1);
	}
	else if(level.teambased)
	{
		var_05 = getteamscore("allies");
		var_06 = getteamscore("axis");
		var_07 = 0;
		var_08 = 0;
		foreach(var_01 in level.players)
		{
			if(isdefined(var_01.pers["team"]) && var_01.pers["team"] == "allies")
			{
				var_07 = var_07 + var_01.pers["kills"];
				var_08 = var_08 + var_01.pers["deaths"];
			}
		}

		var_0B = "tied";
		if(scripts\mp\_utility::func_9900() && scripts\mp\_utility::func_9FAA())
		{
			if(game["timeToBeatTeam"] == "none")
			{
				setclientmatchdata("alliesTTB",0);
				setclientmatchdata("axisTTB",0);
				var_0B = "tied";
			}
			else
			{
				if("allies" == game["timeToBeatTeam"])
				{
					var_05++;
				}
				else
				{
					var_06++;
				}

				setclientmatchdata("alliesTTB",scripts\common\utility::func_116D7("allies" == game["timeToBeatTeam"],game["timeToBeat"],game["timeToBeatOld"]));
				setclientmatchdata("axisTTB",scripts\common\utility::func_116D7("axis" == game["timeToBeatTeam"],game["timeToBeat"],game["timeToBeatOld"]));
				var_0B = game["timeToBeatTeam"];
			}
		}
		else if(var_05 == var_06)
		{
			var_0B = "tied";
		}
		else if(var_05 > var_06)
		{
			var_0B = "allies";
		}
		else
		{
			var_0B = "axis";
		}

		setclientmatchdata("alliesScore",var_05);
		setclientmatchdata("axisScore",var_06);
		setclientmatchdata("alliesKills",var_07);
		setclientmatchdata("alliesDeaths",var_08);
		if(var_0B == "tied")
		{
			func_3219("allies");
			func_3219("axis");
			foreach(var_01 in level.players)
			{
				var_0D = var_01.pers["team"];
				if(!isdefined(var_0D))
				{
					continue;
				}

				if(var_0D == "spectator")
				{
					var_01 setplayerdata("common","round","scoreboardType","allies");
					continue;
				}

				var_01 setplayerdata("common","round","scoreboardType",var_0D);
			}
		}
		else
		{
			func_3219(var_0B);
			foreach(var_01 in level.players)
			{
				var_01 setplayerdata("common","round","scoreboardType",var_0B);
			}
		}
	}
	else
	{
		func_3219("neutral");
		foreach(var_01 in level.players)
		{
			var_01 setplayerdata("common","round","scoreboardType","neutral");
		}

		setclientmatchdata("alliesScore",-1);
		setclientmatchdata("axisScore",-1);
		setclientmatchdata("alliesKills",-1);
		setclientmatchdata("alliesDeaths",-1);
	}

	foreach(var_01 in level.players)
	{
		var_01 setplayerdata("common","round","totalXp",var_01.pers["summary"]["xp"]);
		var_01 setplayerdata("common","round","scoreXp",var_01.pers["summary"]["score"]);
		var_01 setplayerdata("common","round","challengeXp",var_01.pers["summary"]["challenge"]);
		var_01 setplayerdata("common","round","matchXp",var_01.pers["summary"]["match"]);
		var_01 setplayerdata("common","round","miscXp",var_01.pers["summary"]["misc"]);
		var_01 setplayerdata("common","round","medalXp",var_01.pers["summary"]["medal"]);
		var_01 setplayerdata("common","common_entitlement_xp",var_01.pers["summary"]["bonusXP"]);
	}
}

//Function Number: 2
func_F7F8()
{
	var_00 = function_0080("scoreboardPlayerCount");
	if(var_00 <= 24)
	{
		setclientmatchdata("players",self.var_41F4,"score",self.pers["score"]);
		var_01 = self.pers["kills"];
		setclientmatchdata("players",self.var_41F4,"kills",var_01);
		if(level.gametype == "dm" || level.gametype == "gun")
		{
			var_02 = self.var_4D;
		}
		else
		{
			var_02 = self.pers["assists"];
		}

		setclientmatchdata("players",self.var_41F4,"assists",var_02);
		var_03 = self.pers["deaths"];
		setclientmatchdata("players",self.var_41F4,"deaths",var_03);
		var_04 = self.pers["team"];
		setclientmatchdata("players",self.var_41F4,"team",var_04);
		var_05 = game[self.pers["team"]];
		setclientmatchdata("players",self.var_41F4,"faction",var_05);
		var_06 = self.pers["extrascore0"];
		setclientmatchdata("players",self.var_41F4,"extrascore0",var_06);
		var_07 = self.pers["extrascore1"];
		setclientmatchdata("players",self.var_41F4,"extrascore1",var_07);
		var_08 = self.var_1190E["total"];
		setclientmatchdata("players",self.var_41F4,"timeplayed",var_08);
		var_09 = scripts\mp\_rank::func_80C8();
		setclientmatchdata("players",self.var_41F4,"rank",var_09);
		var_0A = scripts\mp\_rank::func_8098();
		setclientmatchdata("players",self.var_41F4,"prestige",var_0A);
		var_00++;
		setclientmatchdata("scoreboardPlayerCount",var_00);
	}
}

//Function Number: 3
func_448F(param_00,param_01)
{
	if(param_00 == "none")
	{
		return 0 + param_01;
	}

	if(param_00 == "neutral")
	{
		return 24 + param_01;
	}

	if(param_00 == "allies")
	{
		return 48 + param_01;
	}

	if(param_00 == "axis")
	{
		return 72 + param_01;
	}

	if(param_00 == "multiteam")
	{
		return 96 + param_01;
	}

	return 0;
}

//Function Number: 4
func_3219(param_00)
{
	if(param_00 == "multiteam")
	{
		var_01 = 0;
		foreach(var_03 in level.teamnamelist)
		{
			foreach(var_05 in level.var_CC1D[var_03])
			{
				setclientmatchdata("scoreboards",func_448F("multiteam",var_01),var_05.var_41F4);
				var_01++;
			}
		}

		return;
	}

	if(var_05 == "neutral")
	{
		var_01 = 0;
		foreach(var_05 in level.var_CC1D["all"])
		{
			setclientmatchdata("scoreboards",func_448F(param_00,var_01),var_05.var_41F4);
			var_01++;
		}

		return;
	}

	var_0A = scripts\mp\_utility::getotherteam(var_05);
	var_01 = 0;
	foreach(var_05 in level.var_CC1D[param_00])
	{
		setclientmatchdata("scoreboards",func_448F(param_00,var_01),var_05.var_41F4);
		var_01++;
	}

	foreach(var_05 in level.var_CC1D[var_0A])
	{
		setclientmatchdata("scoreboards",func_448F(param_00,var_01),var_05.var_41F4);
		var_01++;
	}
}