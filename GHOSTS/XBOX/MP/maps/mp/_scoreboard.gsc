/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\_scoreboard.gsc
 * Game: Call of Duty: Ghosts
 * Platform: Console
 * Function Count: 3
 * Decompile Time: 51 ms
 * Timestamp: 10/27/2023 1:30:05 AM
*******************************************************************/

//Function Number: 1
func_61D4()
{
	foreach(var_01 in level.placement["all"])
	{
		var_01 func_709F();
	}

	if(level.multiteambased)
	{
		buildscoreboardtype("multiteam");
		foreach(var_01 in level.players)
		{
			var_01 setcommonplayerdata("round","scoreboardType","multiteam");
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

		setclientmatchdata("alliesScore",var_05);
		setclientmatchdata("axisScore",var_06);
		setclientmatchdata("alliesKills",var_07);
		setclientmatchdata("alliesDeaths",var_08);
		if(var_05 == var_06)
		{
			var_0B = "tied";
		}
		else if(var_06 > var_07)
		{
			var_0B = "allies";
		}
		else
		{
			var_0B = "axis";
		}

		if(var_0B == "tied")
		{
			buildscoreboardtype("allies");
			buildscoreboardtype("axis");
			foreach(var_01 in level.players)
			{
				var_0D = var_01.pers["team"];
				if(!isdefined(var_0D))
				{
					continue;
				}

				if(var_0D == "spectator")
				{
					var_01 setcommonplayerdata("round","scoreboardType","allies");
					continue;
				}

				var_01 setcommonplayerdata("round","scoreboardType",var_0D);
			}
		}
		else
		{
			buildscoreboardtype(var_0B);
			foreach(var_01 in level.players)
			{
				var_01 setcommonplayerdata("round","scoreboardType",var_0B);
			}
		}
	}
	else
	{
		buildscoreboardtype("neutral");
		foreach(var_01 in level.players)
		{
			var_01 setcommonplayerdata("round","scoreboardType","neutral");
		}

		setclientmatchdata("alliesScore",-1);
		setclientmatchdata("axisScore",-1);
		setclientmatchdata("alliesKills",-1);
		setclientmatchdata("alliesDeaths",-1);
	}

	foreach(var_01 in level.players)
	{
		if(!isai(var_01) && maps\mp\_utility::func_61B9() || maps\mp\_utility::func_50C1())
		{
			var_01 setcommonplayerdata("round","squadMemberIndex",var_01.pers["activeSquadMember"]);
		}

		var_01 setcommonplayerdata("round","totalXp",var_01.pers["summary"]["xp"]);
		var_01 setcommonplayerdata("round","scoreXp",var_01.pers["summary"]["score"]);
		var_01 setcommonplayerdata("round","operationXp",var_01.pers["summary"]["operation"]);
		var_01 setcommonplayerdata("round","challengeXp",var_01.pers["summary"]["challenge"]);
		var_01 setcommonplayerdata("round","matchXp",var_01.pers["summary"]["match"]);
		var_01 setcommonplayerdata("round","miscXp",var_01.pers["summary"]["misc"]);
		var_01 visionsetpostapplyforplayer("common_entitlement_xp",var_01.pers["summary"]["entitlementXP"]);
		var_01 visionsetpostapplyforplayer("common_clan_wars_xp",var_01.pers["summary"]["clanWarsXP"]);
	}
}

//Function Number: 2
func_709F()
{
	var_00 = getclientmatchdata("scoreboardPlayerCount");
	if(var_00 <= 24)
	{
		setclientmatchdata("players",self.clientmatchdataid,"score",self.pers["score"]);
		if(isdefined(level.ishorde))
		{
			var_01 = self.pers["hordeKills"];
		}
		else
		{
			var_01 = self.pers["kills"];
		}

		setclientmatchdata("players",self.clientmatchdataid,"kills",var_01);
		if(isdefined(level.ishorde))
		{
			var_02 = self.pers["hordeRevives"];
		}
		else if(level.gametype == "dm" || level.gametype == "sotf_ffa" || level.gametype == "gun")
		{
			var_02 = self.assists;
		}
		else
		{
			var_02 = self.pers["assists"];
		}

		setclientmatchdata("players",self.clientmatchdataid,"assists",var_02);
		var_03 = self.pers["deaths"];
		setclientmatchdata("players",self.clientmatchdataid,"deaths",var_03);
		var_04 = self.pers["team"];
		setclientmatchdata("players",self.clientmatchdataid,"team",var_04);
		var_05 = game[self.pers["team"]];
		setclientmatchdata("players",self.clientmatchdataid,"faction",var_05);
		var_06 = self.pers["extrascore0"];
		setclientmatchdata("players",self.clientmatchdataid,"extrascore0",var_06);
		var_00++;
		setclientmatchdata("scoreboardPlayerCount",var_00);
	}
}

//Function Number: 3
buildscoreboardtype(param_00)
{
	if(param_00 == "multiteam")
	{
		var_01 = 0;
		foreach(var_03 in level.teamnamelist)
		{
			foreach(var_05 in level.placement[var_03])
			{
				setclientmatchdata("scoreboards","multiteam",var_01,var_05.clientmatchdataid);
				var_01++;
			}
		}
	}

	if(var_05 == "neutral")
	{
		var_01 = 0;
		foreach(var_05 in level.placement["all"])
		{
			setclientmatchdata("scoreboards",param_00,var_01,var_05.clientmatchdataid);
			var_01++;
		}
	}

	var_0A = maps\mp\_utility::getotherteam(var_05);
	var_01 = 0;
	foreach(var_05 in level.placement[param_00])
	{
		setclientmatchdata("scoreboards",param_00,var_01,var_05.clientmatchdataid);
		var_01++;
	}

	foreach(var_05 in level.placement[var_0A])
	{
		setclientmatchdata("scoreboards",param_00,var_01,var_05.clientmatchdataid);
		var_01++;
	}
}