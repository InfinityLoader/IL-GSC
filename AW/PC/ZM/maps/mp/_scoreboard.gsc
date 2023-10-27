/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps/mp/_scoreboard.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 3
 * Decompile Time: 50 ms
 * Timestamp: 10/27/2023 2:08:31 AM
*******************************************************************/

//Function Number: 1
processlobbyscoreboards()
{
	foreach(var_01 in level.placement["all"])
	{
		var_01 setplayerscoreboardinfo();
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
	}
	else if(level.teambased)
	{
		var_05 = getteamscore("allies");
		var_06 = getteamscore("axis");
		if(var_05 == var_06)
		{
			var_07 = "tied";
		}
		else if(var_06 > var_07)
		{
			var_07 = "allies";
		}
		else
		{
			var_07 = "axis";
		}

		setclientmatchdata("alliesScore",var_05);
		setclientmatchdata("axisScore",var_06);
		if(var_07 == "tied")
		{
			buildscoreboardtype("allies");
			buildscoreboardtype("axis");
			foreach(var_01 in level.players)
			{
				var_09 = var_01.pers["team"];
				if(!isdefined(var_09))
				{
					continue;
				}

				if(var_09 == "spectator")
				{
					var_01 setcommonplayerdata("round","scoreboardType","allies");
					continue;
				}

				var_01 setcommonplayerdata("round","scoreboardType",var_09);
			}
		}
		else
		{
			buildscoreboardtype(var_07);
			foreach(var_01 in level.players)
			{
				var_01 setcommonplayerdata("round","scoreboardType",var_07);
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
	}

	foreach(var_01 in level.players)
	{
		var_10 = 0;
		if(!var_01 maps\mp\_utility::rankingenabled() || maps\mp\_utility::practiceroundgame())
		{
			var_10 = var_01.pers["summary"]["xp"];
		}
		else
		{
			var_10 = var_01 gettotalmpxp() - var_01.pers["summary"]["matchStartXp"];
		}

		var_01 setcommonplayerdata("round","totalXp",var_10);
		var_01 setcommonplayerdata("round","scoreXp",var_01.pers["summary"]["score"]);
		var_01 setcommonplayerdata("round","challengeXp",var_01.pers["summary"]["challenge"]);
		var_01 setcommonplayerdata("round","matchXp",var_01.pers["summary"]["match"]);
		var_01 setcommonplayerdata("round","miscXp",var_01.pers["summary"]["misc"]);
		var_01 setcommonplayerdata("round","entitlementXp",var_01.pers["summary"]["entitlementXP"]);
		var_01 setcommonplayerdata("round","clanWarsXp",var_01.pers["summary"]["clanWarsXP"]);
	}
}

//Function Number: 2
setplayerscoreboardinfo()
{
	var_00 = getclientmatchdata("scoreboardPlayerCount");
	if(var_00 <= 24)
	{
		setclientmatchdata("players",self.clientmatchdataid,"score",self.pers["score"]);
		var_01 = self.pers["kills"];
		setclientmatchdata("players",self.clientmatchdataid,"kills",var_01);
		if(level.gametype == "ctf" || level.gametype == "sr" || level.gametype == "gun")
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
		var_04 = self.pers["headshots"];
		setclientmatchdata("players",self.clientmatchdataid,"headshots",var_04);
		var_05 = self.pers["team"];
		setclientmatchdata("players",self.clientmatchdataid,"team",var_05);
		var_06 = game[self.pers["team"]];
		setclientmatchdata("players",self.clientmatchdataid,"faction",var_06);
		var_07 = self.pers["extrascore0"];
		setclientmatchdata("players",self.clientmatchdataid,"extrascore0",var_07);
		var_08 = self.pers["extrascore1"];
		setclientmatchdata("players",self.clientmatchdataid,"extrascore1",var_08);
		var_09 = 0;
		if(isdefined(self.pers["division"]) && isdefined(self.pers["division"]["index"]))
		{
			var_09 = self.pers["division"]["index"];
		}

		setclientmatchdata("players",self.clientmatchdataid,"division",var_09);
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

		return;
	}

	if(var_05 == "neutral")
	{
		var_01 = 0;
		foreach(var_05 in level.placement["all"])
		{
			setclientmatchdata("scoreboards",param_00,var_01,var_05.clientmatchdataid);
			var_01++;
		}

		return;
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