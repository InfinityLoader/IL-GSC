/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\_scoreboard.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: PC
 * Function Count: 3
 * Decompile Time: 72 ms
 * Timestamp: 10/27/2023 2:15:07 AM
*******************************************************************/

//Function Number: 1
processlobbyscoreboards()
{
	foreach(var_01 in level.placement["all"])
	{
		var_01 setplayerscoreboardinfo();
	}

	if(level.teambased)
	{
		var_03 = getteamscore("allies");
		var_04 = getteamscore("axis");
		if(var_03 == var_04)
		{
			var_05 = "tied";
		}
		else if(var_04 > var_05)
		{
			var_05 = "allies";
		}
		else
		{
			var_05 = "axis";
		}

		if(var_05 == "tied")
		{
			buildscoreboardtype("allies");
			buildscoreboardtype("axis");
			foreach(var_01 in level.players)
			{
				if(var_01.pers["team"] == "spectator")
				{
					var_01 setplayerdata("round","scoreboardType","allies");
					continue;
				}

				var_01 setplayerdata("round","scoreboardType",var_01.pers["team"]);
			}
		}
		else
		{
			buildscoreboardtype(var_05);
			foreach(var_01 in level.players)
			{
				var_01 setplayerdata("round","scoreboardType",var_05);
			}
		}
	}
	else
	{
		buildscoreboardtype("neutral");
		foreach(var_01 in level.players)
		{
			var_01 setplayerdata("round","scoreboardType","neutral");
		}
	}

	foreach(var_01 in level.players)
	{
		var_01 setclientdvars("player_summary_xp",var_01.pers["summary"]["xp"],"player_summary_score",var_01.pers["summary"]["score"],"player_summary_challenge",var_01.pers["summary"]["challenge"],"player_summary_match",var_01.pers["summary"]["match"],"player_summary_misc",var_01.pers["summary"]["misc"]);
	}
}

//Function Number: 2
setplayerscoreboardinfo()
{
	var_00 = getclientmatchdata("scoreboardPlayerCount");
	if(var_00 <= 24)
	{
		setclientmatchdata("players",self.clientmatchdataid,"score",self.pers["score"]);
		var_01 = maps\mp\_utility::getplayerstat("kills");
		setclientmatchdata("players",self.clientmatchdataid,"kills",var_01);
		var_02 = maps\mp\_utility::getplayerstat("assists");
		setclientmatchdata("players",self.clientmatchdataid,"assists",var_02);
		var_03 = maps\mp\_utility::getplayerstat("deaths");
		setclientmatchdata("players",self.clientmatchdataid,"deaths",var_03);
		var_04 = game[self.pers["team"]];
		setclientmatchdata("players",self.clientmatchdataid,"faction",var_04);
		var_00++;
		setclientmatchdata("scoreboardPlayerCount",var_00);
	}
}

//Function Number: 3
buildscoreboardtype(param_00)
{
	if(param_00 == "neutral")
	{
		var_01 = 0;
		foreach(var_03 in level.placement["all"])
		{
			setclientmatchdata("scoreboards",param_00,var_01,var_03.clientmatchdataid);
			var_01++;
		}

		return;
	}

	var_05 = maps\mp\_utility::getotherteam(var_03);
	var_01 = 0;
	foreach(var_03 in level.placement[param_00])
	{
		setclientmatchdata("scoreboards",param_00,var_01,var_03.clientmatchdataid);
		var_01++;
	}

	foreach(var_03 in level.placement[var_05])
	{
		setclientmatchdata("scoreboards",param_00,var_01,var_03.clientmatchdataid);
		var_01++;
	}
}