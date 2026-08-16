/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\_scoreboard.gsc
 * Game: Call of Duty: Modern Warfare 2
 * Platform: PC
*******************************************************************/

processlobbyscoreboards()
{
	foreach(player in level.placement["all"])
	{
		player setplayerscoreboardinfo();
	}

	if(level.teambased)
	{
		alliesscore = getteamscore("allies");
		axisscore = getteamscore("axis");
		if(alliesscore == axisscore)
		{
			winner = "tied";
		}
		else if(alliesscore > axisscore)
		{
			winner = "allies";
		}
		else
		{
			winner = "axis";
		}

		if(winner == "tied")
		{
			buildscoreboardtype("allies");
			buildscoreboardtype("axis");
			foreach(player in level.players)
			{
				if(player.pers["team"] == "spectator")
				{
					player setplayerdata("round", "scoreboardType", "allies");
					continue;
				}

				player setplayerdata("round", "scoreboardType", player.pers["team"]);
			}
		}
		else
		{
			buildscoreboardtype(winner);
			foreach(player in level.players)
			{
				player setplayerdata("round", "scoreboardType", winner);
			}
		}
	}
	else
	{
		buildscoreboardtype("neutral");
		foreach(player in level.players)
		{
			player setplayerdata("round", "scoreboardType", "neutral");
		}
	}

	foreach(player in level.players)
	{
		player setclientdvars("player_summary_xp", player.pers["summary"]["xp"], "player_summary_score", player.pers["summary"]["score"], "player_summary_challenge", player.pers["summary"]["challenge"], "player_summary_match", player.pers["summary"]["match"], "player_summary_misc", player.pers["summary"]["misc"]);
	}
}

setplayerscoreboardinfo()
{
	scoreboardplayercount = getclientmatchdata("scoreboardPlayerCount");
	if(scoreboardplayercount <= 24)
	{
		setclientmatchdata("players", self.clientmatchdataid, "score", self.pers["score"]);
		kills = maps\mp\_utility::getplayerstat("kills");
		setclientmatchdata("players", self.clientmatchdataid, "kills", kills);
		assists = maps\mp\_utility::getplayerstat("assists");
		setclientmatchdata("players", self.clientmatchdataid, "assists", assists);
		deaths = maps\mp\_utility::getplayerstat("deaths");
		setclientmatchdata("players", self.clientmatchdataid, "deaths", deaths);
		faction = game[self.pers["team"]];
		setclientmatchdata("players", self.clientmatchdataid, "faction", faction);
		scoreboardplayercount++;
		setclientmatchdata("scoreboardPlayerCount", scoreboardplayercount);
		return;
	}
}

buildscoreboardtype(team)
{
	if(team == "neutral")
	{
		index = 0;
		foreach(player in level.placement["all"])
		{
			setclientmatchdata("scoreboards", team, index, player.clientmatchdataid);
			index++;
		}

		return;
	}

	otherteam = maps\mp\_utility::getotherteam(team);
	index = 0;
	foreach(player in level.placement[team])
	{
		setclientmatchdata("scoreboards", team, index, player.clientmatchdataid);
		index++;
	}

	foreach(player in level.placement[otherteam])
	{
		setclientmatchdata("scoreboards", team, index, player.clientmatchdataid);
		index++;
	}
}